
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

#[contract]
mod deposit{
   
    use super::Deposit;

    struct Storage{
        object : Deposit,
    }
    
    #[external]
    fn setDeposit(){
        let x = Deposit{
            value : 500_u128,
        };
        object::write(x);
    }
    
    #[view]
    fn getDeposit() -> u128{
        let x = object::read();
        x.value
    }


}



#[derive(Copy)]
struct Deposit{
value : u128
}

impl Deposit_StorageAccess of StorageAccess::<Deposit> {
    fn read(
        address_domain: u32, base: StorageBaseAddress
    ) -> SyscallResult::<Deposit> {
        Result::Ok(
            Deposit {
                value: storage_read_syscall(
                    address_domain, storage_address_from_base_and_offset(base, 0_u8)
                )?.try_into().unwrap(),
            }
        )
    }

    fn write(
        address_domain: u32, base: StorageBaseAddress, value: Deposit
    ) -> SyscallResult::<()> {
        storage_write_syscall(
            address_domain,
            storage_address_from_base_and_offset(base, 0_u8),
            value.value.into()
        )
    }
}



#[abi]
trait IDeposit {
    fn getDeposit() -> u128;

    fn setDeposit();

}