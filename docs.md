## Security Groups & Routing Tables for 3-Tier Architecture

### 1. Web Tier Security Group (Public)

| Resource | Type | Protocol | Port | Source | Purpose |
|----------|------|----------|------|--------|---------|
| **Web SG** | Inbound | TCP | 80 | 0.0.0.0/0 | HTTP from internet |
| **Web SG** | Inbound | TCP | 443 | 0.0.0.0/0 | HTTPS from internet |
| **Web SG** | Outbound | TCP | All traffic | 0.0.0.0/0 | External updates |

### 2. Application Tier Security Group (Private)

| Resource | Type | Protocol | Port | Source | Purpose |
|----------|------|----------|------|--------|---------|
| **App SG** | Inbound | TCP | 8080 | Web SG | From Web Tier |
| **App SG** | Inbound | TCP | 22 | 10.0.0.0/16 | SSH from within VPC |
| **App SG** | Inbound | TCP | 8000-9000 | App SG | Inter-app communication |
| **App SG** | Outbound | TCP | all traffic | 0.0.0.0/0 | External APIs |

### 3. Database Tier Security Group (Private)

| Resource | Type | Protocol | Port | Source | Purpose |
|----------|------|----------|------|--------|---------|
| **DB SG** | Inbound | TCP | 3306 | App SG | MySQL from App Tier |
|
| **DB SG** | Inbound | TCP | 22 | 10.0.1.0/24 | SSH from Public subnet |
| **DB SG** | Outbound | TCP | all traffic | 0.0.0.0/0 | all traffic

### 4. Load Balancer Security Group

| Resource | Type | Protocol | Port | Source | Purpose |
|----------|------|----------|------|--------|---------|
| **ALB SG** | Inbound | TCP | 8080 | 0.0.0.0/0 | HTTP from internet |
| **ALB SG** | Inbound | TCP | 443 | 0.0.0.0/0 | HTTPS from internet |
| **ALB SG** | Inbound | TCP | 8080 | web SG | HTTP from internet |
| **ALB SG** | Outbound | TCP | All trafic | Web SG | To Web Tier |


---

## Route Tables Configuration

### 1. Public Route Table (Web Tier)

| Destination | Target | Purpose |
|-------------|---------|---------|
| 10.0.0.0/16 | local | VPC internal traffic |
| 0.0.0.0/0 | internet-gateway | Internet access |


### 2. Private Route Table (Application Tier)

| Destination | Target | Purpose |
|-------------|---------|---------|
| 10.0.0.0/16 | local | VPC internal traffic |
| 0.0.0.0/0 | nat-gateway | Internet via NAT |


### 3. Isolated Route Table (Database Tier)

| Destination | Target | Purpose |
|-------------|---------|---------|
| 10.0.0.0/16 | local | VPC internal traffic only |
| 10.0.1.0/24 | local | Management subnet |


