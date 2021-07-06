from brownie import chain
# Supply in 5 years 1e7 + 1e18
def test_five_years(accounts,token):
    chain.sleep(157784631)
    token.claim()
    assert token.totalSupply() == 1e25

#  After 10 years
def test_ten_years(accounts,token):
    chain.sleep(157784630*2)
    token.claim()
    assert token.totalSupply() == 1e25

# After 2 years
def test_two_years(accounts,token):
    chain.sleep(63113852)
    token.claim()
    assert round(token.totalSupply()/1e18) == (1e7/5)*2

# After 5 years
def test_after_five(accounts,token):
    chain.sleep(157784730)
    token.claim()
    assert token.totalSupply() == 1e25

def test_seconds(accounts,token):
    first=token.lastClaimedAt()
    token.claim()
    second=token.lastClaimedAt()
    supply = token.totalSupply()
    diff = second - first
    assert diff *(1e7/157784630) == supply/1e18
#  test the amount in seconds how much each second