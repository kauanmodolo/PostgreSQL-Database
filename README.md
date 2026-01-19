<div align="center">
  
# 🗄️ PostgreSQL UVV Stores Database

A comprehensive relational database implementation for a retail store management system, featuring complete schema design, constraints, and PostgreSQL optimization.

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)]()
[![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)]()
[![SQL Power Architect](https://img.shields.io/badge/SQL%20Power%20Architect-Database%20Design-blue?style=for-the-badge)]()

</div>

---

## 📋 Overview

This repository contains a complete database implementation for a multi-store retail management system. The database schema is designed to handle products, inventory, customers, orders, and shipments across multiple store locations, both physical and online.

The project includes:
- ✅ Full database schema with 7 normalized tables
- ✅ Complete referential integrity with foreign keys
- ✅ Business logic constraints (CHECK constraints)
- ✅ Detailed documentation and comments
- ✅ Entity-Relationship diagram (ERD)
- ✅ MariaDB alternative implementation

## 🏗️ Database Architecture

### Schema Structure

The database consists of the following tables:

| Table | Description |
|-------|-------------|
| **produtos** | Product catalog with pricing and media information |
| **lojas** | Store information (physical and web locations) |
| **clientes** | Customer details and contact information |
| **estoques** | Inventory management per store |
| **pedidos** | Order tracking and status management |
| **pedidos_itens** | Individual items within orders |
| **envios** | Shipment tracking and delivery status |

### Key Features

- **Data Integrity**: Comprehensive foreign key relationships ensure referential integrity
- **Business Rules**: CHECK constraints enforce business logic:
  - Product prices must be non-negative
  - Stores must have either a web address or physical address
  - Inventory quantities cannot be negative
  - Email addresses must contain '@' symbol
  - Predefined status values for orders and shipments
- **Normalized Design**: 3rd Normal Form (3NF) structure to minimize redundancy
- **User Management**: Includes database user creation with proper permissions
- **Schema Organization**: All tables organized under the `lojas` schema

## 📊 Entity Relationship Diagram

The complete ERD is available in the repository as:
- `pset1/cc1n_202306090_postgresql.architect` (SQL Power Architect source)
- `pset1/cc1n_202306090_postgresql.pdf` (Visual diagram)

## 🚀 Getting Started

### Prerequisites

- PostgreSQL 12 or higher
- Linux environment (or WSL on Windows)
- UTF-8 locale support (`pt_BR.UTF-8`)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/kauanmodolo/PostgreSQL-Database.git
cd PostgreSQL-Database
```

2. Execute the SQL script:
```bash
psql -U postgres -f pset1/cc1n_202306090_postgresql.sql
```

The script will automatically:
- Create the database user
- Create the `uvv` database
- Set up the `lojas` schema
- Create all tables with constraints
- Establish foreign key relationships

### Configuration

The default configuration creates:
- **Database**: `uvv`
- **Schema**: `lojas`
- **User**: `kauan` (modify as needed in the script)
- **Encoding**: UTF-8
- **Collation**: `pt_BR.UTF-8`

> ⚠️ **Security Note**: Remember to change the default password in the script before deploying to production.

## 📁 Repository Structure

```
PostgreSQL-Database/
├── pset1/
│   ├── cc1n_202306090_postgresql.sql      # Main PostgreSQL script
│   ├── cc1n_202306090_postgresql.architect # ERD source file
│   ├── cc1n_202306090_postgresql.pdf      # ERD visualization
│   └── mariaDB/                            # MariaDB implementation
└── README.md
```

## 🔧 Technologies Used

- **PostgreSQL**: Primary database management system
- **SQL Power Architect**: Database modeling and ERD design
- **Linux**: Development and deployment environment
- **MariaDB**: Alternative database implementation

## 💡 Use Cases

This database schema is suitable for:
- E-commerce platforms with multiple stores
- Retail chain management systems
- Inventory tracking across locations
- Order fulfillment and shipment tracking
- Customer relationship management

## 📝 Table Details

### Products (produtos)
Stores product information including pricing, images, and metadata with support for multimedia content.

### Stores (lojas)
Manages both physical and online store locations with geolocation support (latitude/longitude).

### Customers (clientes)
Customer profiles with contact information supporting up to three phone numbers.

### Inventory (estoques)
Real-time inventory tracking per store location.

### Orders (pedidos)
Order management with status tracking (OPEN, PAID, COMPLETE, CANCELLED, REFUNDED, SHIPPED).

### Order Items (pedidos_itens)
Line items for each order with pricing and quantity information.

### Shipments (envios)
Delivery tracking with status updates (CREATED, SHIPPED, IN_TRANSIT, DELIVERED).
