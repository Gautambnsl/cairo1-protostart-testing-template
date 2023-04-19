
use starknet::StorageAccess;
use starknet::StorageBaseAddress;
use starknet::SyscallResult;
use starknet::storage_read_syscall;
use starknet::storage_write_syscall;
use starknet::storage_address_from_base_and_offset;
use traits::Into;
use traits::TryInto;
use option::OptionTrait;
use starknet::ContractAddress;
use starknet::contract_address;



#[abi]
trait IDeposit {
    fn getDeposit() -> u128;
    
    fn setDeposit();

}



#[contract]
mod open{
    
    use starknet::ContractAddress;
    use super::IDepositDispatcherTrait;
    use super::IDepositDispatcher;

        #[external]
        fn set(depositAddress: ContractAddress) {
            IDepositDispatcher{contract_address : depositAddress}.setDeposit();
        }
      
        #[view]
        fn get(depositAddress: ContractAddress) -> u128 {
           let value = IDepositDispatcher{contract_address : depositAddress}.getDeposit();
           return value;
        }

}



