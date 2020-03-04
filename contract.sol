pragma solidity 0.5.16;
pragma experimental ABIEncoderV2;


contract Tracking {
   
     struct Asset {
        string name;
        string description;
        string locationX;
        string locationY;
        address owner;
        string price;
    }
    
 
    
    // Storage
    mapping (string => Asset) assetStorage;
    mapping (address => string) userStorage;
    string comma = " ,";
 
    event RejectCreate(address account, string uuid, string message);

    
    
    function createAsset(string  memory id, string memory name, string memory description, string memory locationX, string memory locationY, string  memory price) public {
 
  
        address owner = msg.sender;
        assetStorage[id] = Asset(name, description, locationX, locationY,  owner, price);
        userStorage[msg.sender]= id;
    }
    
    function sellAsset(string memory id, address newOwner, string  memory price) public {
 
        Asset memory assetToTransfer = assetStorage[id];
       if(assetToTransfer.owner != msg.sender){
           
       }

        string memory priceAux2 =  strConcat(assetStorage[id].price, comma, price);
       
        assetStorage[id] = Asset(assetToTransfer.name, assetToTransfer.description, assetToTransfer.locationX, assetToTransfer.locationY, newOwner, priceAux2);
        userStorage[msg.sender]= "";
        userStorage[newOwner] = id;
        
    }
     function getAsset(string memory id) public view returns (Asset memory){
        Asset memory asset= assetStorage[id];
       return asset;
    }
     function getPriceHistory(string memory id) public  view returns (string memory){
        return assetStorage[id].price;
     
    }
    
    
    
    
    
    function strConcat(string memory _a, string memory _b, string memory _c, string memory _d, string memory _e) internal returns (string memory){
    bytes memory _ba = bytes(_a);
    bytes memory _bb = bytes(_b);
    bytes memory _bc = bytes(_c);
    bytes memory _bd = bytes(_d);
    bytes memory _be = bytes(_e);
    string memory abcde = new string(_ba.length + _bb.length + _bc.length + _bd.length + _be.length);
    bytes memory babcde = bytes(abcde);
    uint k = 0;
    for (uint256 i = 0; i < _ba.length; i++) babcde[k++] = _ba[i];
    for (uint256 i = 0; i < _bb.length; i++) babcde[k++] = _bb[i];
    for (uint256 i = 0; i < _bc.length; i++) babcde[k++] = _bc[i];
    for (uint256 i = 0; i < _bd.length; i++) babcde[k++] = _bd[i];
    for (uint256 i = 0; i < _be.length; i++) babcde[k++] = _be[i];
    return string(babcde);
}

function strConcat(string memory _a, string memory _b, string memory _c, string memory _d) internal returns (string memory) {
    return strConcat(_a, _b, _c, _d, "");
}

function strConcat(string memory _a, string memory  _b, string memory _c) internal returns (string memory) {
    return strConcat(_a, _b, _c, "", "");
}

function strConcat(string memory _a, string memory _b) internal returns (string memory) {
    return strConcat(_a, _b, "", "", "");
}
    
    
    
    
    

    
}

