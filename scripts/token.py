from brownie import DEMO, accounts
def main():
    return DEMO.deploy({'from': accounts[0]})

# to run in command line brownie run token!
# if function !main brownie run token {name of function}