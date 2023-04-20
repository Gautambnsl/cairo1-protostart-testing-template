use result::ResultTrait;
use array::ArrayTrait;
use debug::PrintTrait;
use traits::Into;
use starknet::ContractAddress;
use starknet::contract_address;


#[contract]
mod test_contract{
    use result::ResultTrait;
    use array::ArrayTrait;
    use debug::PrintTrait;
    use traits::Into;
    use starknet::ContractAddress;
    use starknet::contract_address;

    struct Storage{
        _deposit: felt252,
        _open : felt252,
        _temp : felt252,
    }

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
            // _deposit::write(deposit_contract_address);
        }

        #[test]
        fn test_Deploy_open(){
            let class_hash1 = declare('open').unwrap();
            let mut prepare_result1 = prepare(class_hash1, ArrayTrait::new()).unwrap();
            let mut prepared_contract1 = PreparedContract {
                contract_address: prepare_result1.contract_address,
                class_hash: prepare_result1.class_hash,
                constructor_calldata: prepare_result1.constructor_calldata
            };
            let open_contract_address = deploy(prepared_contract1).unwrap();
            _open::write(open_contract_address);
        }
        
        #[test]
        fn test_final(){
            let mut calldata1 = ArrayTrait::new();
            let mut calldata2 = ArrayTrait::new();
            let x = _deposit::read();
            calldata1.append(x);
            calldata2.append(x);
            invoke(_open::read(), 'set', calldata1).unwrap();
            let return_data = call(_open::read(), 'get',calldata2).unwrap();
            

        }
        
}