WITH user_journey AS(
  SELECT
  is_make_order AS make_order,
  COUNT (DISTINCT masked_user_id) AS total_user,
  SUM (view_microsite_count) view_microsite,
  SUM (view_pdp_count) view_pdp,
  SUM (input_kode_promo_count) input_promo,
  SUM (pilih_metode_pembayaran_count) AS metode_bayar
  FROM `bitlabs-dab.I_CID_02.activity`
  GROUP BY is_make_order
)
SELECT *,
ROUND((SUM(user_journey.view_pdp)-SUM(user_journey.view_microsite))/SUM(user_journey.view_microsite)*100) AS percentage_microsite_to_pdp,
ROUND((SUM(user_journey.input_promo)-SUM(user_journey.view_pdp))/SUM(user_journey.view_pdp)*100) AS percentage_pdp_to_promo,
ROUND((SUM(user_journey.metode_bayar)-SUM(user_journey.input_promo))/SUM(user_journey.input_promo)*100) AS percentage_promo_to_bayar,
ROUND((SUM(user_journey.metode_bayar)-SUM(user_journey.input_promo)-SUM(user_journey.view_pdp))/SUM(user_journey.view_pdp)*100) AS percentage_pdp_to_bayar
FROM user_journey
GROUP BY 1,2,3,4,5,6