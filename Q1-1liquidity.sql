-- Liquidity (TVL) of stETH/WETH Uniswap V2 pool, denominated in ETH
-- Addresses
-- stETH: 0xae7ab96520de3a18e5e111b5eaab095312d7fe84 (token0)
-- WETH:  0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2 (token1)
-- Pool:  0x4028daac072e492d34a3afdbef0ba7e35d8b55c4 (stETH/WETH)

SELECT
    evt_block_time                                                                 AS ts,
    -- TVL in ETH = stETH (in ETH) + WETH
    (CAST(reserve0 AS DOUBLE) * (CAST(reserve1 AS DOUBLE) / NULLIF(CAST(reserve0 AS DOUBLE), 0.0))
      + CAST(reserve1 AS DOUBLE)) / 1e18                                           AS liquidity_eth
FROM uniswap_v2_ethereum.pair_evt_Sync
WHERE contract_address = 0x4028daac072e492d34a3afdbef0ba7e35d8b55c4
  AND evt_block_time >= TIMESTAMP '2024-07-30 00:00:00'
  AND evt_block_time <  TIMESTAMP '2024-08-07 00:00:00'
ORDER BY evt_block_time;


