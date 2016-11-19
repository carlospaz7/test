function IMDB()

% Execute the script to import the file and assign it to a table variable
     movieValue = importCsv();
     
% For each row on the file, we make an API request
    for i = 1:1:height(movieValue)
    %for i = 1:1:10
        
% We obtain only the year of the second cell
        cell = table2array(movieValue(i,2));
        yearNum = num2str(year(cell));
        
% We obtain the tile of the movie removing all special characters
        cell = table2array(movieValue(i,3));
        title = strrep(regexprep(char(cell),'[^a-z A-Z]',''),' ','+');
        
% The API call and we get a JSON response file
        url = strcat('http://www.omdbapi.com/?t=',title,'&y=',yearNum,'&plot=short&r=json&tomatoes=true');
        options = weboptions('ContentType','JSON');
        json = webread(url,options)
        
%  If a movie is found, we concatenate the results
        if(strcmp(json.Response, 'True'))
            genre{i} = json.Genre;
            imdbRating{i} = json.imdbRating;
            imdbVotes{i} = json.imdbVotes;
            Director{i} = json.Director;
            Country{i} = json.Country;
            Runtime{i} = json.Runtime;
            Language{i} = json.Language;
        else
            genre{i,1} = '';
            imdbRating{i,1} = '';
            imdbVotes{i,1} = '';
            Director{i,1} = '';
            Country{i,1} = '';
            Runtime{i,1} = '';
            Language{i,1} = '';
        end

    end

% Finally we append all the columns into a single table
     movieTable = [movieValue genre imdbRating imdbVotes Director Country Runtime Language]
     
end