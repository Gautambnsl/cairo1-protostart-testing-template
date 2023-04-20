
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
    struct Storage{
        value : felt252,
    }
    
    #[external]
    fn setDeposit(){
        value::write(5);
    }
    
    #[view]
    fn getDeposit() -> felt252{
        let x = value::read();
        return x;
    }

}




// #[derive(Copy, Drop)]
// struct Deposit{
// value : u128
// }


// impl Deposit_StorageAccess of StorageAccess::<Deposit> {
//     fn read(
//         address_domain: u32, base: StorageBaseAddress
//     ) -> SyscallResult::<Deposit> {
//         Result::Ok(
//             Deposit {
//                 value: storage_read_syscall(
//                     address_domain, storage_address_from_base_and_offset(base, 0_u8)
//                 )?.try_into().unwrap(),
//             }
//         )
//     }

//     fn write(
//         address_domain: u32, base: StorageBaseAddress, value: Deposit
//     ) -> SyscallResult::<()> {
//         storage_write_syscall(
//             address_domain,
//             storage_address_from_base_and_offset(base, 0_u8),
//             value.value.into()
//         )
//     }
// }






// impl DepositSerde of serde::Serde::<Deposit>{
//     fn serialize(ref serialized: Array::<felt252>, input: Deposit) {
//            serde::Serde::<u128>::serialize(ref serialized, input.value);
//     }
//     fn deserialize(ref serialized: Span::<felt252>) -> Option::<Deposit> {
//            Option::Some(
//                Deposit {
//                    value: serde::Serde::<u128>::deserialize(ref serialized)?,
//                }
//            )
//     }
// }