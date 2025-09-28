from uniswapv2 import simulate_uniswap_v2_swap

# Example: swap 10 token0 in a pool with reserves (1000, 1000), fee 0.3%
out = simulate_uniswap_v2_swap(
    amount_in=0.590938841,
    token_in=0,
    reserves=(15447.019081008409196921, 26852668.001452),
    fee=0.003 # 0.3%
)
print(out)