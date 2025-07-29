# Credit Card Transactions-India

### Project overview
This project involves analyzing a large dataset of credit card transactions across Indian cities using SQL. The goal is to derive meaningful business insights related to customer spending behavior, transaction patterns, and card usage. 

### Data source
The primary dataset used for this analysis is the "Credit card transactions-India.csv" containing detailed information about credit card spending habits in India


### Exploratory data analysis (EDA)

Before diving into SQL queries, the dataset was explored to understand the structure and types of information present.

**Key columns include:**

Transaction_id: Unique ID for each transaction

Date: Timestamp of transaction

Amount: Transaction amount

City: Location of the transaction

Card_type: Type of card used (Gold, Silver, Platinum, Signature)

Gender: Gender of the cardholder

Exp_type: Expense type (e.g., Fuel, Bills, Travel, etc.)

**Initial Observations:**

Transactions span multiple cities and expense types.

Amounts vary widely across card types.

Cardholder gender is available, allowing for demographic segmentation.

## SQL Queries

All SQL queries used to derive the insights are available in [`credit_card_queries.sql`](./credit_card_queries.sql).

### Key Questions Answered:
1. Top 5 cities by total spend and their percentage of total spend.
2. Highest spend month by card type.
3. City having highest total spend to total no of transcations ratio on weekends




### Results/findings

**Highest & Lowest Expense Types by City:**
For each city, found which expense category received the most and least spend — helps localize marketing or partnership strategies.

**Cumulative Spend Threshold:**
Found the point (transaction) at which each card type hit ₹10,00,000 in cumulative spend. Useful for tracking early high-performance behavior.

**Lowest Gold Card Contribution:**
Identified the city where gold card spend was proportionally the lowest. Could indicate untapped market or user preference for other cards.

**Female Spend Contribution by Expense Type:**
Calculated female spending as a percentage of total for each expense type, offering insights into gender-based usage patterns.

**Weekend Spend Efficiency:**
Evaluated which city had the highest ratio of total weekend spend to number of weekend transactions — revealing high-value areas.

**Time to 500th Transaction:**
Measured how fast each city reached its 500th transaction since its first — useful for tracking customer activity growth.
