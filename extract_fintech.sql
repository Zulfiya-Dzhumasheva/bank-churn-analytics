WITH customer_activity AS (
    SELECT 
        CLIENTNUM AS client_id,
        Attrition_Flag AS attrition_flag,
        Customer_Age AS age,
        Gender AS gender,
        Education_Level AS education,
        Income_Category AS income_category,
        Card_Category AS card_category,
        Credit_Limit AS credit_limit,
        Total_Revolving_Bal AS revolving_bal,
        Total_Trans_Amt AS total_trans_amt,
        Total_Trans_Ct AS total_trans_ct,
        Avg_Utilization_Ratio AS utilization_ratio
    FROM bank_churners
    WHERE Credit_Limit > 0 AND Total_Trans_Ct > 0
)
SELECT 
    *,
    ROUND(CAST(total_trans_amt AS REAL) / total_trans_ct, 2) AS avg_check,
    ROUND(AVG(total_trans_amt) OVER(PARTITION BY card_category), 2) AS avg_tier_spend,
    ROW_NUMBER() OVER(PARTITION BY card_category ORDER BY total_trans_amt DESC) AS rank_in_tier
FROM customer_activity;
