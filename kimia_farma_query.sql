SELECT
  ft.transaction_id,
  ft.date,
  kc.branch_id,
  kc.branch_name,
  kc.kota,
  kc.provinsi,
  kc.rating AS rating_cabang,
  ft.customer_name,
  pd.product_id,
  pd.product_name,
  pd.price AS actual_price,
  ft.discount_percentage,
  CASE
    WHEN pd.price <= 50000 THEN 0.10
    WHEN pd.price > 50000 AND pd.price <= 100000 THEN 0.15
    WHEN pd.price > 100000 AND pd.price <= 300000 THEN 0.20
    WHEN pd.price > 300000 AND pd.price <= 500000 THEN 0.25
    WHEN pd.price > 500000 THEN 0.30
  END AS persentase_gross_laba,
  ROUND((pd.price * (1 - ft.discount_percentage / 100)), 2) nett_sales,
  ROUND((pd.price * (1 - ft.discount_percentage / 100)) *
  CASE
    WHEN pd.price <= 50000 THEN 0.10
    WHEN pd.price > 50000 AND pd.price <= 100000 THEN 0.15
    WHEN pd.price > 100000 AND pd.price <= 300000 THEN 0.20
    WHEN pd.price > 300000 AND pd.price <= 500000 THEN 0.25
    WHEN pd.price > 500000 THEN 0.30
  END, 4) AS nett_profit,
  ft.rating AS rating_transaksi
FROM 
  `rakaminkfanalytics-452403.kimia_farma.kf_final_transaction` ft
JOIN 
  `rakaminkfanalytics-452403.kimia_farma.kf_kantor_cabang` kc ON ft.branch_id = kc.branch_id
JOIN
  `rakaminkfanalytics-452403.kimia_farma.kf_product` pd ON ft.product_id = pd.product_id