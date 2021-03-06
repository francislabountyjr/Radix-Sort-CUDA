#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <thrust/device_vector.h>
#include <thrust/sort.h>
#include <thrust/random.h>
#include <iostream>

//helper routines
void initialize(thrust::device_vector<int>& v)
{
	thrust::default_random_engine rng(2021);
	thrust::uniform_int_distribution<int> dist(10, 99);

	for (size_t i = 0; i < v.size(); i++)
	{
		v[i] = dist(rng);
	}
}

void print(const thrust::device_vector<int>& v)
{
	for (size_t i = 0; i < v.size(); i++)
	{
		std::cout << ' ' << v[i];
	}

	std::cout << '\n';
}

int main()
{
	size_t N = 16;

	std::cout << "---------- Sorting integers ----------\n";
	{
		thrust::device_vector<int> keys(N);
		initialize(keys);
		print(keys);
		thrust::sort(keys.begin(), keys.end());
		print(keys);
	}

	std::cout << "---------- Sorting integers (descending) ----------\n";

	{
		thrust::device_vector<int> keys(N);
		initialize(keys);
		print(keys);
		thrust::sort(keys.begin(), keys.end(), thrust::greater<int>());
		print(keys);
	}

	return 0;
}