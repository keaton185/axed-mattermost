for page in {0..2};
do
        curl -sS -i -H "Authorization: Bearer <MM AUTH TOKEN>" "https://mattermost.<yourdomain>.com/api/v4/users?per_page=200&page=$page" | egrep "^\[" | jq -rc '.[] | select(.delete_at!=0) | [.username, .delete_at] | @tsv';
done | while read line; do
        name=$(echo $line | awk '{print $1}');
        time=$(echo $line | awk '{print $2}');
        date=$(echo $time | rev | cut -c4- | rev | xargs -I{} date -r {} "+%Y/%m/%d");
        echo "$date $name";
done | sort
