# Risk Test

## Understand the Industry

  1. Explain the money flow and the information flow in the acquirer market and the role of the main players.

    The money flow in the acquirer market refers to the movement of funds between the entities engaged in acquisitions. It involves the transfer of capital from the acquirer, the entity making the acquisition, to the target company, the entity being acquired. The acquirer typically pays a certain amount of money to the shareholders of the target company in exchange for acquiring a controlling stake or ownership of the target company.

    The information flow in the acquirer market involves the exchange of relevant data, market insights, and due diligence findings between the acquirer, target company, and other parties involved in the acquisition process. Accurate and timely information is crucial for making informed decisions and ensuring a successful acquisition.

  2. Explain the difference between acquirer, sub-acquirer and payment gateway and how the flow explained in question 1 changes for these players.

    An acquirer is a financial institution that processes credit and debit card transactions on behalf of merchants. The acquirer is responsible for ensuring that the transaction is authorized by the card issuer and for settling the transaction with the merchant. The money flow in this case involves the transfer of funds from the card issuer to the acquirer, who then transfers the funds to the merchant’s account.

    A sub-acquirer is a third-party company that works with an acquirer to provide payment processing services to merchants. The sub-acquirer acts as an intermediary between the merchant and the acquirer, handling tasks such as transaction authorization and settlement. In this case, the money flow involves the transfer of funds from the card issuer to the acquirer, who then transfers the funds to the sub-acquirer, who finally transfers the funds to the merchant’s account.

    A payment gateway is a service that authorizes credit card payments for online transactions. It acts as an intermediary between a merchant’s website and the acquiring bank, transmitting transaction information securely. In this case, the money flow involves the transfer of funds from the card issuer to the acquiring bank, who then transfers the funds to the merchant’s account.

  3. Explain what chargebacks are, how they differ from cancellations and what is their connection with fraud in the acquiring world.

    A chargeback is a transaction reversal initiated by the cardholder's bank (issuing bank) in response to a dispute or a specific reason. It allows the cardholder to request a refund for a transaction directly from their bank. The bank investigates the dispute and may reverse the transaction, debiting the funds from the merchant's account and crediting them back to the cardholder. Chargebacks are primarily designed to protect consumers from fraudulent transactions, billing errors, or unauthorized card usage.

    A cancellation refers to the act of voiding or canceling a transaction before it is processed or completed. It usually occurs when the customer or the merchant initiates the cancellation request, and the transaction is halted before any funds are transferred. Unlike chargebacks, cancellations do not involve the intervention of the cardholder's bank. Cancellations typically result in the transaction being voided, with no financial impact on either the customer or the merchant.

    Connection with fraud, chargebacks are closely connected to fraud in the acquiring world. Fraudulent activities, such as unauthorized transactions, stolen card details, or identity theft, can lead to chargebacks. If a cardholder detects an unrecognized or unauthorized transaction on their account, they may file a dispute with their bank, triggering a chargeback investigation. Merchants are responsible for proving the legitimacy of the transaction to avoid the chargeback and associated financial losses.

    Fraudulent chargebacks pose significant challenges for merchants and acquirers. Fraudsters may exploit the chargeback process by making illegitimate claims to obtain refunds while retaining the purchased goods or services. This type of fraud, known as friendly fraud or chargeback fraud, can result in financial losses for merchants and acquirers. It also puts pressure on acquirers to implement robust fraud prevention measures and dispute resolution processes to minimize the impact of chargeback fraud.

    To combat fraud-related chargebacks, acquirers and merchants employ various strategies, including transaction monitoring, fraud detection systems, enhanced authentication measures, and improved customer communication and support. By identifying and preventing fraudulent transactions, they can reduce the number of chargebacks and mitigate the associated financial and operational risks.

## Analysis of provided data

  The number of transactions made using a mobile can be calculated by counting the rows in the database.

  Analyzing the transaction amounts can provide insights into the spending patterns of users. Key metrics to consider include the average transaction amount, the minimum and maximum transaction amounts, and the distribution of transaction amounts. These statistics help identify any unusual or outlier transactions.

  Examining the "has_cbk" column, which indicates whether a transaction has resulted in a chargeback, can help identify the frequency of chargebacks. Calculating the chargeback rate (number of chargebacks divided by the total number of transactions) can provide an overview of the chargeback risk associated with mobile transactions.

  Analyzing the relationships between users and merchants can help identify any patterns or associations that may indicate potential fraud. For example, identifying multiple transactions from the same user or the same device across different merchants could raise suspicion.

  Additional data to consider for detecting patterns of possible frauds:

  Analyzing user behavior data, such as login timestamps, session duration, and frequency of transactions, can help identify unusual patterns. Sudden changes in user behavior, such as a significant increase in transaction volume or transactions made at unusual times, may indicate fraudulent activity.

  Considering the geolocation data associated with each transaction, such as IP addresses or GPS coordinates, can provide insights into the legitimacy of the transactions. Unusual or unexpected locations for transactions may raise suspicion.

  Examining device information, such as device IDs, device types, and operating systems, can help identify patterns related to fraud. Multiple transactions from the same device or inconsistencies in device data could indicate fraudulent activities.

  Analyzing the timing of transactions, including the time of day, day of the week, or seasonality patterns, can help identify any irregularities. Unusual transaction patterns occurring outside normal usage patterns may indicate fraudulent behavior.

  Utilizing historical transaction data, including previous chargebacks, fraud incidents, or suspicious activities, can help identify patterns and trends. Comparing current transaction data with historical data can help identify anomalies or recurring patterns.

### Application Risk Test

#### Requirements

-What is the main purpose of the system?
  - Analyze the risk of fraud in transactions made through mobile devices

- What are the functional objectives of the system?
  - Creates an endpoint to receives transaction data and returns a recommendation to `approve/deny` the transaction.
  - Reject transaction if user is trying too many transactions in a row.
  - Reject transactions above a certain amount in a given period.
  - Reject transaction if a user had a chargeback before (note that this information does not comes on the payload. The chargeback data is received days after the transaction was approved).
  - use rule-based, or score-based, or both, to make the decision.

- What are the non-functional objectives of the system?
  - Latency
  - Security
  - Architecture
  - Coding style

#### Database Structure

- I used sqlite3 because it's easy to setup and use.

- Merchant
  - id
  - name

- User
  - id
  - name

- Device
  - id
  - user_id
  - name
  - ip

- Transaction
  - id
  - merchant_id
  - user_id
  - card_number (use rails encrypt because the security)
  - reference_at
  - device_id
  - has_cbk (boolean)

#### Endpoints

- POST /recommendations
  - body:
  ```
  {
    "transaction_id" : 2342357,
    "merchant_id" : 29744,
    "user_id" : 97051,
    "card_number" : "434505******9116",
    "transaction_date" : "2019-11-31T23:16:32.812632",
    "transaction_amount" : 373,
    "device_id" : 285475
  }
  ```
  - response:
  ```
  { "transaction_id" : 2342357, "recommendation" : "approve" }
  ```
  - considerations: I used POST because we'll be sending `card_number` in the body, and if I used GET, the card number would be exposed in the URL. I used `recommendation` instead of `status` because I think it's more clear.

#### Diagram

![Diagram](./doc/images/diagram.png)

#### Run application

`bundle install`
`bundle exec rails db:setup`
`bundle exec rails s`

```
curl --location 'localhost:3000/recommendations' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer NUF13rdasrr51fninurgartausdb' \
--data '  {
    "transaction_id" : 2342357,
    "merchant_id" : 29744,
    "user_id" : 97051,
    "card_number" : "434505******9116",
    "transaction_date" : "2019-11-31T23:16:32.812632",
    "transaction_amount" : 373,
    "device_id" : 285475
  }'
```
#### How to run the tests

`bundle exec rspec`
