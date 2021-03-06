pragma solidity ^0.4.18;

contract FilmManager {
    struct FilmStruct {
        uint filmIndex;
        string filmName;
        string filmDescription;
        string filmImageUrl;
        string filmUrl; // droit de diffusion
        uint filmPrice;
        uint filmNumberVoir;
        uint filmNotation;
        bool filmPublished;
        bool filmIco;
        string userEmailProducer;
    }
    
    event logFilm(
        string function_call,
        uint filmIndex,
        string filmName,
        string filmDescription,
        string filmImageUrl,
        string filmUrl,
        uint filmPrice,
        uint filmNumberVoir,
        uint filmNotation
    );

    event logFilm_published_ico_producer(
        string function_call,
        uint filmIndex,
        bool filmPublished,
        bool filmIco,
        string userEmailProducer
    );

    event operationFilm(
        string function_call,
        bool success
    );
    
    mapping(uint => FilmStruct) filmStructs;
    uint[] filmIndexes;
    uint count = 1;
    
    /* Constructor */
    function FilmManager() public {
        // insertFilm(filmName, filmDescription, filmImageUrl, filmUrl, filmPrice, filmNumberVoir, filmNotation, filmPublished, filmIco, userEmailProducer)
        // published
        insertFilm("film_1", "filmDescription_1", "imageUrl.com_1", "url.com_1", 3, 0, 0, true, false, "2@gmail.com");
        insertFilm("film_2", "filmDescription_2", "imageUrl.com_2", "url.com_2", 5, 0, 0, true, false, "2@gmail.com");
        insertFilm("film_3", "filmDescription_3", "imageUrl.com_3", "url.com_3", 30, 0, 0, true, false, "2@gmail.com");
        // ICO => index_filmIndexes = 3, 4
        insertFilm("film_4", "filmDescription_4", "imageUrl.com_4", "url.com_4", 1, 0, 0, false, true, "2@gmail.com");
        insertFilm("film_5", "filmDescription_5", "imageUrl.com_5", "url.com_5", 1, 0, 0, false, true, "2@gmail.com");
    }

    // verify the existence of film
    function isFilm(uint filmIndex) private constant returns(bool isIndeed) {
        if(filmIndexes.length == 0 || filmStructs[filmIndex].filmIndex >= filmIndexes.length) return false;
        return (filmIndexes[filmStructs[filmIndex].filmIndex] == filmIndex);
    }

    function insertFilm(string filmName, string filmDescription, string filmImageUrl,
        string filmUrl, uint filmPrice, uint filmNumberVoir, uint filmNotation, 
        bool filmPublished, bool filmIco, string userEmailProducer) 
    public returns(uint index_filmIndexes) {
        var filmIndex = count;
        count ++;
        if(isFilm(filmIndex)) revert(); 

        filmStructs[filmIndex].filmIndex = filmIndexes.push(filmIndex) - 1;
        filmStructs[filmIndex].filmName = filmName;
        filmStructs[filmIndex].filmDescription = filmDescription;
        filmStructs[filmIndex].filmImageUrl = filmImageUrl;
        filmStructs[filmIndex].filmUrl = filmUrl;
        filmStructs[filmIndex].filmPrice = filmPrice;
        filmStructs[filmIndex].filmNumberVoir = filmNumberVoir;
        filmStructs[filmIndex].filmNotation = filmNotation;
        filmStructs[filmIndex].filmPublished = filmPublished;
        filmStructs[filmIndex].filmIco = filmIco;
        filmStructs[filmIndex].userEmailProducer = userEmailProducer;


        logFilm("insertFilm", filmStructs[filmIndex].filmIndex, filmName, filmDescription, 
            filmImageUrl, filmUrl, filmPrice, filmNumberVoir, filmNotation);
        logFilm_published_ico_producer("insertFilm", filmStructs[filmIndex].filmIndex, 
            filmPublished, filmIco, userEmailProducer);
        return filmIndexes.length-1;
    }

    function getFilm(uint filmIndex) public constant returns(
        string filmName, string filmDescription, string filmImageUrl, 
        string filmUrl, uint filmPrice, uint filmNumberVoir, uint filmNotation
        ) {
        if(!isFilm(filmIndex)) revert();
        return(
            filmStructs[filmIndex].filmName,
            filmStructs[filmIndex].filmDescription,
            filmStructs[filmIndex].filmImageUrl,
            filmStructs[filmIndex].filmUrl,
            filmStructs[filmIndex].filmPrice,
            filmStructs[filmIndex].filmNumberVoir,
            filmStructs[filmIndex].filmNotation
        );
    }

    function getFilmInfo_published_ico_producer(uint filmIndex) public constant returns(
        uint index_filmIndexes, bool filmPublished, bool filmIco, string userEmailProducer) {
        if(!isFilm(filmIndex)) revert();
        return(
            filmStructs[filmIndex].filmIndex, 
            filmStructs[filmIndex].filmPublished,
            filmStructs[filmIndex].filmIco,
            filmStructs[filmIndex].userEmailProducer
        );
    }


    function updateFilm(uint filmIndex, string filmName, string filmDescription, 
        string filmImageUrl, string filmUrl, uint filmPrice, uint filmNumberVoir, 
        uint filmNotation, bool filmPublished, bool filmIco) public returns(bool success) {
        if(!isFilm(filmIndex)) revert();

        filmStructs[filmIndex].filmName = filmName;
        filmStructs[filmIndex].filmDescription = filmDescription;
        filmStructs[filmIndex].filmImageUrl = filmImageUrl;
        filmStructs[filmIndex].filmUrl = filmUrl;
        filmStructs[filmIndex].filmPrice = filmPrice;
        filmStructs[filmIndex].filmNumberVoir = filmNumberVoir;
        filmStructs[filmIndex].filmNotation = filmNotation;
        filmStructs[filmIndex].filmPublished = filmPublished;
        filmStructs[filmIndex].filmIco = filmIco;

        logFilm("updateFilm", filmStructs[filmIndex].filmIndex, filmName, 
            filmDescription, filmImageUrl, filmUrl, filmPrice, filmNumberVoir, 
            filmNotation);
        logFilm_published_ico_producer("updateFilm", filmStructs[filmIndex].filmIndex, 
            filmPublished, filmIco, "");
        return true;
    }

    function deleteFilm(uint filmIndex) public returns(bool success) {
        if(!isFilm(filmIndex)) revert();

        uint rowToDelete = filmStructs[filmIndex].filmIndex;
        uint keyToMove = filmIndexes[filmIndexes.length-1];
        filmIndexes[rowToDelete] = keyToMove;
        filmStructs[keyToMove].filmIndex = rowToDelete;
        filmIndexes.length--;

        operationFilm("deleteFilm", true);
        return true;
    }

    function getNextFilmIndex() public constant returns(uint nextFIlmIndex) {
        return count;
    }

    function getNumberFilm() public constant returns(uint numberFilm) {
        return filmIndexes.length;
    }

    function getByIndex_filmIndexes(uint index_filmIndexes) public constant returns(uint filmIndex) {
        return filmIndexes[index_filmIndexes];
    }

}