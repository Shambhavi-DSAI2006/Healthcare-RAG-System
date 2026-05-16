# Healthcare RAG Database Design — Milestone 1

## Project Overview

This milestone focuses on the database design and normalization phase of a healthcare-focused Retrieval-Augmented Generation (RAG) system.

The objective was to design a normalized relational database capable of supporting:

- healthcare document storage
- semantic chunk organization
- embedding-based retrieval workflows
- AI-generated response tracking
- evaluation and reliability analysis

This milestone establishes the foundational schema architecture for subsequent RAG pipeline implementation.



# Objectives

The main objectives of Milestone 1 were:

- design an Entity-Relationship (ER) model
- create a normalized relational schema
- identify entities and relationships
- enforce relational integrity
- prepare the database structure for semantic retrieval workflows



# Database Design Components

## ER Diagram

The project includes a complete ER diagram representing:

- entities
- primary keys
- foreign keys
- many-to-many relationships
- semantic retrieval mappings

The ER diagram is available in:


docs/E_R_DIAGRAM_MILESTONE_1.pdf




# Normalization

The schema was normalized up to:

# Third Normal Form (3NF)

The normalization process minimized:

- redundancy
- update anomalies
- insertion anomalies
- deletion anomalies

Normalization notes are available in:


normalization/3NF_NOTES_HEALTHCARE_RAG_SYSTEM.txt




# Schema Design

The relational schema includes the following entities:

| Entity | Purpose |
|---|---|
| source | Stores healthcare organizations and sources |
| document | Stores healthcare reports and articles |
| section | Stores document sections |
| chunk | Stores semantic healthcare chunks |
| embedding | Stores vector embeddings |
| topic | Stores healthcare topics |
| chunk_topic | Maps chunks to healthcare topics |
| user_query | Stores healthcare user queries |
| retrieved_chunk | Stores semantic retrieval mappings |
| response | Stores AI-generated responses |
| evaluation | Stores response evaluation metrics |



# Database Features

The schema design includes:

- Primary Keys
- Foreign Keys
- Composite Keys
- Many-to-Many Relationships
- Referential Integrity Constraints
- Normalized Table Design



# Technologies Used

| Technology | Purpose |
|---|---|
| SQL | Schema design |
| SQL Server | Relational database modeling |
| Draw.io / ER Tool | ER diagram creation |



# Folder Structure


milestone_1/
│
├── docs/
│   └── E_R_DIAGRAM_MILESTONE_1.pdf
│
├── normalization/
│   └── 3NF_NOTES_HEALTHCARE_RAG_SYSTEM.txt
│
├── schema/
│   └── schema.sql
│
└── README.md




# Deliverables

This milestone includes:

- ER diagram
- normalized relational schema
- 3NF documentation
- healthcare-oriented relational design



# Future Scope

The schema designed in this milestone serves as the foundation for:

- semantic chunk generation
- embedding creation
- retrieval mapping
- AI-generated responses
- healthcare RAG implementation
- evaluation analytics

These components are implemented in Milestone 2.



# Project Type

Database Management Systems Project  
Healthcare Retrieval-Augmented Generation (RAG) System