# import pandas as pd

# # Path to your CSV file
# csv_file_path = 'assets\worldcities.csv'

# # Read the CSV file, ensuring no rows are skipped
# df = pd.read_csv(csv_file_path)

# # Specify the column name you want to convert to a list
# column_name = 'city_ascii'  # Replace with your actual column name

# # Check if the column exists in the DataFrame
# if column_name not in df.columns:
#     raise ValueError(f"Column '{column_name}' does not exist in the CSV file.")

# # Convert the specified column to a list, handling missing values
# column_list = df[column_name].dropna().tolist()

# # Print or use the list as needed
# print(f"Total items in the list: {len(column_list)}")
# print(column_list[:10])  # Print first 10 items as a sample

# # Save the list to a JSON file if needed
# import json

# json_file_path = 'assets\cities.json'
# with open(json_file_path, 'w') as json_file:
#     json.dump(column_list, json_file)

# print(f"List saved to {json_file_path}")



# import pandas as pd
# import json

# # Path to your Excel file
# xlsx_file_path = 'assets/worldcities.xlsx'

# # Read the Excel file
# df = pd.read_excel(xlsx_file_path)

# # Select the 'city_ascii' and 'country' columns
# filtered_df = df[['city_ascii', 'country']]

# # Convert the selected columns to a list of dictionaries
# column_list = filtered_df.to_dict(orient='records')

# # Print or use the list as needed
# print(f"Total items in the list: {len(column_list)}")
# print(column_list[:10])  # Print first 10 items as a sample

# # Save the list to a JSON file
# json_file_path = 'assets/cities_and_countries.json'
# with open(json_file_path, 'w') as json_file:
#     json.dump(column_list, json_file, indent=4)

# print(f"Data saved to {json_file_path}")



# import pandas as pd
# import json

# # Path to your Excel file
# xlsx_file_path = 'assets\worldcities.xlsx'

# # Path where you want to save the JSON file
# json_file_path = 'assets/cities_and_countries.json'

# # Read the Excel file
# df = pd.read_excel(xlsx_file_path)

# # Select only the 'city_ascii' and 'country' columns
# filtered_df = df[['city_ascii', 'country']]

# # Convert the DataFrame to a list of dictionaries
# data_list = filtered_df.to_dict(orient='records')

# # Write the list of dictionaries to a JSON file
# with open(json_file_path, 'w', encoding='utf-8') as json_file:
#     json.dump(data_list, json_file, indent=4)

# print(f"Data has been successfully converted and saved to {json_file_path}")



import pandas as pd
import json

# Path to your Excel file
xlsx_file_path = 'assets\worldcities.xlsx'

# Paths for the JSON files
cities_json_path = 'assets/cities.json'
countries_json_path = 'assets/countries.json'

# Read the Excel file
df = pd.read_excel(xlsx_file_path)

# Ensure the required columns exist
if 'city_ascii' not in df.columns or 'country' not in df.columns:
    raise ValueError("The required columns 'city_ascii' or 'country' are missing in the Excel file.")

# Extract the columns
cities = df['city_ascii'].tolist()
countries = df['country'].tolist()

# Ensure the lists are of the same length
if len(cities) != len(countries):
    raise ValueError(f"The lengths of 'city_ascii' and 'country' columns do not match.\ncountries number: {len(countries)}\n cities number: {len(cities)}")

# Convert lists to dictionaries
cities_data = [{'city': city, 'country': countries[i]} for i, city in enumerate(cities)]

# Save city and country data to separate JSON files
with open(cities_json_path, 'w', encoding='utf-8') as cities_file:
    json.dump(cities, cities_file, indent=4)

with open(countries_json_path, 'w', encoding='utf-8') as countries_file:
    json.dump(countries, countries_file, indent=4)

print(f"Cities and countries have been successfully saved to {cities_json_path} and {countries_json_path}")



# import pandas as pd

# # Path to your Excel file
# xlsx_file_path = 'assets\worldcities.xlsx'

# # Read the Excel file
# df = pd.read_excel(xlsx_file_path)

# # Extract the columns
# cities = df['city_ascii'].tolist()
# countries = df['country'].tolist()

# # Check for mismatches in length
# if len(cities) != len(countries):
#     print(f"Mismatch found: cities number = {len(cities)}, countries number = {len(countries)}")

#     # Find the indices of missing values
#     missing_city_indices = [i for i, city in enumerate(cities) if pd.isna(city)]
#     missing_country_indices = [i for i, country in enumerate(countries) if pd.isna(country)]

#     print(f"Indices with missing cities: {missing_city_indices}")
#     print(f"Indices with missing countries: {missing_country_indices}")

#     # Additional check to ensure indices are consistent
#     if missing_city_indices:
#         for index in missing_city_indices:
#             print(f"City missing at index {index}, Country value: {countries[index] if index < len(countries) else 'N/A'}")
    
#     if missing_country_indices:
#         for index in missing_country_indices:
#             print(f"Country missing at index {index}, City value: {cities[index] if index < len(cities) else 'N/A'}")

# else:
#     print("Lengths match. No missing values detected.")

