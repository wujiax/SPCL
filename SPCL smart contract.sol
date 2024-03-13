pragma solidity >=0.4.21;
pragma experimental ABIEncoderV2;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract Storage {
    string[] DataList;
    string success_code = "success";
    string fail_code = "fail";   
    string file  = "file already exist";

    struct Data{
        string ID_ORDER;
        string PAYMENT;
        uint ID_RIDU;
        uint TS;
    }
    // define mapping Payment information to Data
    mapping (string => Data) private Dmap;
    

    /**
     * @dev Store value in variable
     */
    function store(string ID_ORDER,string  PAYMENT, uint ID_RIDU,uint TS) public returns(string memory) {
        uint ListLength = DataList.length;
        bool file_exist = false;
        for(uint i = 0; i < ListLength; i++){
            if (bytes(ID_ORDER).length != bytes(DataList[i]).length) {
            continue;
        } else {
            if(keccak256(ID_ORDER) == keccak256(DataList[i])){
                file_exist = true;
                return file;
            }
            }
        }
        if (file_exist == false){
            DataList.push(ID_ORDER);
            Data storage po = Dmap[ID_ORDER];
            po.ID_ORDER = ID_ORDER;
            po.ID_RIDU = ID_RIDU;
            po.TS = TS;
            return success_code;
        } else {
            return fail_code;
        }
    }
    
    function get(string memory ID_ORDER) public view returns(Data memory) {
        Data memory porder = Dmap[ID_ORDER];
        return porder;
    }
}