from typing import Tuple


def simulate_uniswap_v2_swap(
    amount_in: float,
    token_in: int,
    reserves: Tuple[float, float],
    fee: float,
) -> float:
    """
    Simulate a Uniswap V2 swap using the CPMM formula with an input fee.

    Formula:
      amount_in_with_fee = amount_in * (1 - fee)
      amount_out = (amount_in_with_fee * reserve_out) / (reserve_in + amount_in_with_fee)

    Args:
        amount_in: Input token amount.
        token_in: 0 for token0 -> token1, 1 for token1 -> token0.
        reserves: (reserve0, reserve1).
        fee: Decimal fee (e.g., 0.003 for 0.30%).
    """

    reserve0, reserve1 = reserves
    reserve_in, reserve_out = (
        (reserve0, reserve1) if token_in == 0 else (reserve1, reserve0)
    )

    amount_in_with_fee = amount_in * (1.0 - fee)
    return (amount_in_with_fee * reserve_out) / (reserve_in + amount_in_with_fee)


__all__ = ["simulate_uniswap_v2_swap"]


