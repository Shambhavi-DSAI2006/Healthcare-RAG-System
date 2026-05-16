-- =========================================================
-- HEALTHCARE RAG DATABASE SCHEMA
-- =========================================================

-- Project:
-- Retrieval-Augmented Generation (RAG) Healthcare Dataset

-- Description:
-- This schema models a healthcare-focused RAG pipeline
-- including:
--   - healthcare document storage
--   - semantic chunking
--   - vector embeddings
--   - topic classification
--   - semantic retrieval
--   - AI-generated responses
--   - reliability evaluation

-- Database:
-- PostgreSQL

-- Embedding Model:
-- sentence-transformers/all-MiniLM-L6-v2

-- Notes:
-- Embedding vectors are currently stored as TEXT.
-- The schema can be extended using pgvector for
-- native vector similarity search.

-- =========================================================




-- =========================================================
-- DROP TABLES (safe restart)
-- =========================================================
DROP TABLE IF EXISTS evaluation;
DROP TABLE IF EXISTS retrieved_chunk;
DROP TABLE IF EXISTS chunk_topic;
DROP TABLE IF EXISTS response;
DROP TABLE IF EXISTS query;
DROP TABLE IF EXISTS topic;
DROP TABLE IF EXISTS embedding;
DROP TABLE IF EXISTS chunk;
DROP TABLE IF EXISTS section;
DROP TABLE IF EXISTS document;
DROP TABLE IF EXISTS source;


-- =========================================================
-- 1. SOURCE
-- Stores data sources (WHO, CDC, etc.)
-- =========================================================
CREATE TABLE source (
    source_id INT PRIMARY KEY,
    source_name VARCHAR(255) NOT NULL,
    organization_type VARCHAR(100) NOT NULL,
    country VARCHAR(100)
);

-- =========================================================
-- 2. DOCUMENT
-- Stores healthcare documents and reports
-- =========================================================

CREATE TABLE document (
    document_id INT PRIMARY KEY,
    source_id INT,
    title VARCHAR(500) NOT NULL,
    publication_date DATE,
    document_type VARCHAR(100),

    FOREIGN KEY (source_id)
    REFERENCES source(source_id)
);

-- =========================================================
-- 3. SECTION
-- Stores document sections
-- =========================================================

CREATE TABLE section (
    section_id INT PRIMARY KEY,
    document_id INT,
    section_title VARCHAR(255) NOT NULL,
    section_order INT,

    FOREIGN KEY (document_id)
    REFERENCES document(document_id)
);

-- =========================================================
-- 4. CHUNK
-- Stores semantic text chunks
-- =========================================================

CREATE TABLE chunk (
    chunk_id INT PRIMARY KEY,
    section_id INT,
    chunk_text VARCHAR(MAX) NOT NULL,
    chunk_order INT,
    word_count INT,

    FOREIGN KEY (section_id)
    REFERENCES section(section_id)
);

-- =========================================================
-- 5. EMBEDDING
-- Stores vector embeddings for chunks
-- =========================================================

CREATE TABLE embedding (
    embedding_id INT PRIMARY KEY,
    chunk_id INT,
    embedding_model VARCHAR(255),
    embedding_vector VARCHAR(MAX) NOT NULL,

    FOREIGN KEY (chunk_id)
    REFERENCES chunk(chunk_id)
);

-- =========================================================
-- 6. TOPIC
-- Stores healthcare topics
-- =========================================================

CREATE TABLE topic (
    topic_id INT PRIMARY KEY,
    topic_name VARCHAR(255) NOT NULL,
    topic_category VARCHAR(100)
);

-- =========================================================
-- 7. CHUNK_TOPIC
-- Maps chunks to healthcare topics
-- =========================================================

CREATE TABLE chunk_topic (
    chunk_id INT,
    topic_id INT,

    PRIMARY KEY (chunk_id, topic_id),

    FOREIGN KEY (chunk_id)
    REFERENCES chunk(chunk_id),

    FOREIGN KEY (topic_id)
    REFERENCES topic(topic_id)
);


-- =========================================================
-- 8. QUERY
-- Stores user healthcare questions
-- =========================================================

CREATE TABLE query (
    query_id INT PRIMARY KEY,
    query_text VARCHAR(MAX) NOT NULL,
    query_timestamp DATETIME,
    user_type VARCHAR(100)
);

-- =========================================================
-- 9. RETRIEVED_CHUNK
-- Stores chunks retrieved for each query
-- =========================================================

CREATE TABLE retrieved_chunk (
    retrieval_id INT PRIMARY KEY,
    query_id INT,
    chunk_id INT,
    relevance_score DECIMAL(4,3),

    FOREIGN KEY (query_id)
    REFERENCES query(query_id),

    FOREIGN KEY (chunk_id)
    REFERENCES chunk(chunk_id)
);

-- =========================================================
-- 10. RESPONSE
-- Stores AI-generated responses
-- =========================================================

CREATE TABLE response (
    response_id INT PRIMARY KEY,
    query_id INT,
    generated_answer VARCHAR(MAX) NOT NULL,
    confidence_score DECIMAL(4,3)
    CHECK (confidence_score BETWEEN 0 AND 1),
    generation_timestamp DATETIME,

    FOREIGN KEY (query_id)
    REFERENCES query(query_id)
);


-- =========================================================
-- 11. EVALUATION
-- Stores response reliability metrics
-- =========================================================

CREATE TABLE evaluation (
    evaluation_id INT PRIMARY KEY,
    response_id INT,
    factuality_score DECIMAL(4,3)
    CHECK (factuality_score BETWEEN 0 AND 1),
    consistency_score DECIMAL(4,3)
    CHECK (consistency_score BETWEEN 0 AND 1),
    evaluation_notes VARCHAR(MAX),

    FOREIGN KEY (response_id)
    REFERENCES response(response_id)
);


-- =========================================================
-- INDEXES FOR PERFORMANCE OPTIMIZATION
-- =========================================================

CREATE INDEX idx_chunk_section
ON chunk(section_id);

CREATE INDEX idx_embedding_chunk
ON embedding(chunk_id);

CREATE INDEX idx_retrieved_query
ON retrieved_chunk(query_id);

CREATE INDEX idx_response_query
ON response(query_id);