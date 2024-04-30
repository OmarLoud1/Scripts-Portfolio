BEGIN { total_queries = 0; successful_queries = 0; total_response_time = 0; min_response_time = -1; max_response_time = -1; }
{
    total_queries++;
    if ($1 == "Server:" && $2 != "") {
        successful_queries++;
        response_time = $(NF-1);
        sub("time=", "", response_time);
        sub("ms", "", response_time);
        response_time += 0;
        total_response_time += response_time;
        if (min_response_time == -1 || response_time < min_response_time) { min_response_time = response_time; }
        if (max_response_time == -1 || response_time > max_response_time) { max_response_time = response_time; }
    }
}
END {
    if (successful_queries > 0) { avg_response_time = total_response_time / successful_queries; } else { avg_response_time = 0; }
    printf("Total DNS queries: %d\n", total_queries);
    printf("Successful DNS queries: %d\n", successful_queries);
    printf("Failed DNS queries: %d\n", total_queries - successful_queries);
    printf("Average response time: %.2f ms\n", avg_response_time);
    printf("Minimum response time: %.2f ms\n", min_response_time);
    printf("Maximum response time: %.2f ms\n", max_response_time);
}
