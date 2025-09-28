-- ezETH/WETH Uniswap V3 pool time series (price and current-range liquidity)
-- Pool: 0xBE80225f09645f172B079394312220637C440A63
-- Window: 2024-08-04 00:00:00 to 2024-08-07 00:00:00 UTC

WITH
pool AS (
    SELECT
        e.token0,
        e.token1,
        e.fee
    FROM uniswap_v3_ethereum.Factory_evt_PoolCreated e
    WHERE e.pool = 0xBE80225f09645f172B079394312220637C440A63
    ORDER BY e.evt_block_time DESC
    LIMIT 1
),
swaps AS (
    SELECT
        evt_block_time                                  AS ts,
        evt_block_number                                AS block_number,
        sqrtPriceX96,
        liquidity,
        tick
    FROM uniswap_v3_ethereum.Pair_evt_Swap
    WHERE contract_address = 0xBE80225f09645f172B079394312220637C440A63
      AND evt_block_time >= TIMESTAMP '2024-08-04 00:00:00'
      AND evt_block_time <  TIMESTAMP '2024-08-07 00:00:00'
)
SELECT
    s.ts,
    s.liquidity/ 1e18 
    -- s.sqrtPriceX96,
    -- ezETH price in ETH regardless of token ordering
    -- CASE
    --     WHEN p.token1 = 0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2 THEN (CAST(s.sqrtPriceX96 AS DOUBLE) * CAST(s.sqrtPriceX96 AS DOUBLE) / POWER(2.0, 192))
    --     WHEN p.token0 = 0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2 THEN 1.0 / NULLIF((CAST(s.sqrtPriceX96 AS DOUBLE) * CAST(s.sqrtPriceX96 AS DOUBLE) / POWER(2.0, 192)), 0.0)
    --     ELSE NULL
    -- END AS price_ezETH_in_ETH
FROM swaps s
CROSS JOIN pool p
ORDER BY s.ts;


