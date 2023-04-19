use result::ResultTrait;
use array::ArrayTrait;
use debug::PrintTrait;
use traits::Into;
use starknet::ContractAddress;
use starknet::contract_address;

#[test]
fn test_Deposit(){
    //deposit deploy
        let mut class_hash1 = declare('deposit').unwrap();
        let mut prepare_result1 = prepare(class_hash1, ArrayTrait::new()).unwrap();
        let mut prepared_contract1 = PreparedContract {
            contract_address: prepare_result1.contract_address,
            class_hash: prepare_result1.class_hash,
            constructor_calldata: prepare_result1.constructor_calldata
        };
        let deposit_contract_address = deploy(prepared_contract1).unwrap();
        //open deploy
        let mut class_hash = declare('open').unwrap();
        let mut prepare_result = prepare(class_hash, ArrayTrait::new()).unwrap();
        let mut prepared_contract = PreparedContract {
            contract_address: prepare_result.contract_address,
            class_hash: prepare_result.class_hash,
            constructor_calldata: prepare_result.constructor_calldata
        };
        let open_contract_address = deploy(prepared_contract).unwrap();
        //calldata append contractaddress
        let mut calldata = ArrayTrait::new();
        calldata.append(deposit_contract_address);   
        invoke(open_contract_address, 'set', calldata).unwrap();
        let return_data = call(open_contract_address, 'get',calldata).unwrap();
        // assert(*return_data.at(0_u32) == 500,'Test Failed');
}

