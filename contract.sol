pragma solidity >=0.4.22 <0.7.0;
pragma experimental ABIEncoderV2;

contract Tracking {
   
     struct Asset {
        string name;
        string description;
        string locationX;
        string locationY;
        uint256 index;
        address owner;
        bool initialized;
    }
    
 
   
    
    // Storage
    mapping (string => Asset) assetStorage;
    mapping (address => string) userStorage;
    mapping (string => mapping(uint256 => string)) priceStorage;
    string[]  prices;
    
    // Events
    event AssetCreate(address account, string uuid, string manufacturer);
    event RejectCreate(address account, string uuid, string message);
    event AssetTransfer(address from, address to, string uuid);
    event HistoryPrices(string log, string[] prices);
    
    
    
    function createAsset(string  memory id, string memory name, string memory description, string memory locationX, string memory locationY, string  memory price) public {
 
    if(assetStorage[id].initialized) {
        emit RejectCreate(msg.sender, id, "Asset with this ID already exists.");
        return;
      }
        address owner = msg.sender;
        uint256 index = 0;
        
        
        assetStorage[id] = Asset(name, description, locationX, locationY, index, owner, true);
        priceStorage[id][index]= price; 
        userStorage[msg.sender]= id;
    }
    
    function sellAsset(string memory id, address newOwner, string  memory price) public {
 
        Asset storage assetToTransfer = assetStorage[id];
       if(assetToTransfer.owner != msg.sender){
           
       }
        uint256 index = assetToTransfer.index + 1;
        
        priceStorage[id][index]= price;

       
        assetStorage[id] = Asset(assetToTransfer.name, assetToTransfer.description, assetToTransfer.locationX, assetToTransfer.locationY, index, newOwner, true);
        userStorage[msg.sender]= "";
        userStorage[newOwner] = id;
        
    }
     function getAsset(string memory id) public view returns (Asset memory){
        Asset memory asset= assetStorage[id];
       return asset;
    }
     function getPriceHistory(string memory id) public{
        Asset memory asset= assetStorage[id];
        uint256  index = asset.index;
        prices = new string[](index);
        for(uint256 i= 0; i<= asset.index; i++){
            prices.push(priceStorage[id][i]);
        }
        emit HistoryPrices("PRECIOS", prices);
    }
    
    
    
    
    

    
}

