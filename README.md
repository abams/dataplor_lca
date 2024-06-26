# README

This implementaiton uses the Ruby [Ancestry Gem](https://sqlfordevs.com/tree-as-materialized-path). I chose this to use Materialized paths for tree navigation. I have another implementation on a [recursive-cve](https://github.com/abams/dataplor_lca/tree/recursive-cte) branch as well, but though this was a better approach that required less code and allowed for more efficient tree naviation.

#### Install ruby 3.3.0 via [homebrew](https://brew.sh/)
```
$ brew install rbenv ruby-build
$ rbenv init
$ rbenv install 3.3.0
```

#### Setting up the application

```
$ bundle install
```

#### Database creation
Download and install the [postgress app](https://postgresapp.com/) if you do not have postgres on your machine

#### Database initialization
```
$ bin/rails db:setup
 ```

#### Running the test suite

```
$ bin/rails db:test:prepare
$ bin/rspec
```


#### Start server instructions

```
$ bin/rails s
```



# Prompt

Here's the code challenge. It's designed to test your decision making while trying to not write a lot of code or take a ton of time. That said, we do like to see clean, well organized code.

There's no set deadline, take as much time as you think you need and just let me know when to expect it.

Our objective is to assess how you think about, approach, and solve novel problems, so to the extent that you want to include a note about your thinking that you feel might not come through in the code, that helps us as well.

Thanks in advance!


We have an adjacency list that creates a tree of nodes where a child's parent_id = a parent's id. I have provided some sample data in the attached csv.

Please make an api (rails, sinatra, cuba--your choice) that has two endpoints:

```
1) /common_ancestor - It should take two params, a and b, and it should return the root_id, lowest_common_ancestor_id, and depth of tree of the lowest common ancestor that those two node ids share.
```

For example, given the data for nodes:
```
   id    | parent_id
---------+-----------
     125 |       130
     130 |
 2820230 |       125
 4430546 |       125
 5497637 |   4430546

```

```
/common_ancestor?a=5497637&b=2820230 should return
{root_id: 130, lowest_common_ancestor: 125, depth: 2}

/common_ancestor?a=5497637&b=130 should return
{root_id: 130, lowest_common_ancestor: 130, depth: 1}

/common_ancestor?a=5497637&b=4430546 should return
{root_id: 130, lowest_common_ancestor: 4430546, depth: 3}

if there is no common node match, return null for all fields

/common_ancestor?a=9&b=4430546 should return
{root_id: null, lowest_common_ancestor: null, depth: null}

if a==b, it should return itself

/common_ancestor?a=4430546&b=4430546 should return
{root_id: 130, lowest_common_ancestor: 4430546, depth: 3}

```
```
2) /birds - The second requirement for this project involves considering a second model, birds. Nodes have_many birds and birds belong_to nodes. Our second endpoint should take an array of node ids and return the ids of the birds that belong to one of those nodes or any descendant nodes.
```

The most efficient way to solve this problem probably involves pre-processing the data and then serving that pre-processed data, but I would like you assume that a different process will add to the data (with no assumption as to the magnitude of the additions). Your solution should be optimized for a system that could expand to hundreds of millions of records or maybe even billions of nodes.

At dataPlor we write software that deals with exponentially expanding data. We are looking for people who can take novel problems, demonstrate first principles design and performance that flows from deep understanding, and integrate that into best practices code quality and organization.

