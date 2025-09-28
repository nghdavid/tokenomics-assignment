-- Price of stETH denominated in ETH using Uniswap V2 pool reserves
-- Addresses
-- stETH: 0xae7ab96520de3a18e5e111b5eaab095312d7fe84 (token0)
-- WETH:  0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2 (token1)
-- Pool:  0x4028daac072e492d34a3afdbef0ba7e35d8b55c4 (stETH/WETH)

SELECT
    evt_block_time                                              AS ts,
    -- ETH per 1 stETH
    CAST(reserve1 AS DOUBLE) / NULLIF(CAST(reserve0 AS DOUBLE), 0.0) AS price
FROM uniswap_v2_ethereum.pair_evt_Sync
WHERE contract_address = 0x4028daac072e492d34a3afdbef0ba7e35d8b55c4
  AND evt_block_time >= TIMESTAMP '2024-08-04 00:00:00'
  AND evt_block_time <  TIMESTAMP '2024-08-07 00:00:00'
ORDER BY evt_block_time;


