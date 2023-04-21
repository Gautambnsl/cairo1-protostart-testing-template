use result::ResultTrait;
use array::ArrayTrait;
use debug::PrintTrait;
use traits::Into;
use starknet::ContractAddress;
use starknet::contract_address;


// #[contract]
// mod test_contract{
//     use result::ResultTrait;
//     use array::ArrayTrait;
//     use debug::PrintTrait;
//     use traits::Into;
//     use starknet::ContractAddress;
//     use starknet::contract_address;

//     struct Storage{
//         _deposit: felt252,
//         _open : felt252,
//         _temp : felt252,
//     }

    #[test]
    fn test_Deploy_Deposit(){
        //deposit deploy
            let class_hash1 = declare('deposit').unwrap();
            let mut prepare_result1 = prepare(class_hash1, ArrayTrait::new()).unwrap();
            let mut prepared_contract1 = PreparedContract {
                contract_address: prepare_result1.contract_address,
                class_hash: prepare_result1.class_hash,
                constructor_calldata: prepare_result1.constructor_calldata
            };
            let deposit_contract_address = deploy(prepared_contract1).unwrap();

        //deploy open
            let class_hash1 = declare('open').unwrap();
            let mut prepare_result1 = prepare(class_hash1, ArrayTrait::new()).unwrap();
            let mut prepared_contract1 = PreparedContract {
                contract_address: prepare_result1.contract_address,
                class_hash: prepare_result1.class_hash,
                constructor_calldata: prepare_result1.constructor_calldata
            };
            let open_contract_address = deploy(prepared_contract1).unwrap();

        //test
            let mut calldata1 = ArrayTrait::new();
            let mut calldata2 = ArrayTrait::new();
            calldata1.append(deposit_contract_address);
            calldata2.append(deposit_contract_address);
            invoke(open_contract_address, 'set', calldata1).unwrap();
            let return_data = call(open_contract_address, 'get',calldata2).unwrap();
            
            assert(*return_data.at(0_u32)==5,*return_data.at(0_u32));
        }
        
