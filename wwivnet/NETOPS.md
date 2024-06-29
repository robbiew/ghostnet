# WWIVnet Network Operations Guide

This is a guide to managing GHOSTnet, a WWIVnet based network. You don't need this guide unless you are network adminstrator, or interested in how a WWIVnet network is managed.

## GHOSTnet Network Architecture
- get-ghosted.com
  - WWIV v5.X: WWIVnet Hub:
    - WWIVnet nodes are managed here
    - Need to SSH into hub to update files

## WWIVnet Hub
### Managing Nodes
New WWIVnet network nodes can be added by editing WWIVnet Hub hosts' files in `net/ghostnet/`. Refer to the [WWIVnet docs]([https://](https://docs.wwivbbs.org/en/latest/archive/net37_docs/)) for more info on these files, but note the docs are pretty outdated.

It's best to keep these files version controlled, so Git is a good way to keep track of any changes to files listed below.

***Exception: `callout.net` should NEVER be committed to git as it contains each node's binkp password.***

### Process for adding/removing nodes:

- Add/Edit/Manage these 4 files on the WWIVnet Hub (each is explained below):
  - `net/ghostnet/bbslist.net`
  - `net/ghostnet/connect.net`
  - `net/ghostnet/binkp.net`
  - `net/ghostnet/callout.net`
- Submit a pull request to the files on github (e.g. from your forked repo)
- Chnages will be merged into the Main branch

#### `bbslist.net`
This file is the network Node List. Start by adding a new node to this file.

From the WWIVnet docs:  

> BBSLIST.NET -  For a small network, this file can list all nodes participating in the network.  The general format of this file is discussed in the appendices.  A small network does not need any of the remaining BBSLIST.x files. 
>
> BBSLIST.NET holds a listing of what systems are in the network. Each system has an entry, with the systems usually grouped by area code. The format for each system's line: system number  (preceded by @), system phone number (preceded by *), max bps rate of the system (preceded by #),system flags if any, WWIV registration number or date of entry (enclosed in brackets), and system name (enclosed in ""). For example, the BBSLIST line for Amber in NETXX could be:

bbslist.net format:

```
~1719439906

@1   &  *317-379-INET #33600    &|!     [062624]  "GHOSTnet WWIVnet Hub"                
@2      *317-379-INET #33600      !     [062624]  "Ghosts In The Machine"
@3      *925-464-INET #33600      !     [062624]  "GHOSTnet Talisman FTN Birdge"  
@4      *925-464-INET #33600      !     [062624]  "Space Junk!"  
```

Explained:
- the first line is a [Time Stamp]([https://](https://timestampgenerator.com/)). The first line of the BBSLIST.NET must be a tilde (~) followed by the Unix timestamp (seconds since midnight, Jan 1, 1970) indicating the date and time the file was sent out by the NC or GC.
- blank line
- Row entry:
  - '@1' is the Hub, every other system will be listed in rows below
  - '&' is network coorinator flag. There should only be one node with '&' flag
  - Phone number should start with the user's area code, and end in "INET"
  - The number in brackets e.g. '[062624]' is the date the node joined
  - Unsure of the next column/flags but copied from WWIVnet*
  - BBS Name is the last item in the row

#### `connect.net`
> CONNECT.NET lists the connection costs between systems. The cost listed should be the cost per minute, though for most networks using this system, the rule of thumb is 0.00 for local connects, 0.01 for long distance connects, and more for long distance connects that one wants to route less mail through.
>
> Each entry in the CONNECT.NET file specifies a one-way connection between two systems. The entries in the CONNECT.NET file do NOT need to be in any specific order. The format for system's connection entry is: the system number (preceded by "@"), first connection and cost (separated by "="), second connection and cost, and so forth. Like BBSLIST.NET, the first line is a tilde (~) followed by the UNIX timestamp.

`connect.net` format:

```
~1719439906

@1  2=0.00 3=0.00 4=0.00                                            
@2  1=0.00 
@3  1=0.00
@4  1=0.00
```

- first line a date stamp
- blank line
- node number, routing
  - @1 is the Hub, ad should be connected to all nodes (until we add more Hubs)
  - Add new node to have their own row (@XX 1=0.0)

#### `callout.net`
This file contains the routing for the network. If you wanted the Hub to call a system every 15 minutes, replace "+" with "/15". "+" means that node will call the Hub and the Hub will never call the node (the default for our network).

```
@2     +                 "sOmePasSword"
@3     +                 "anotHerPass"
@4     +                 "NodEpassWorD"
```

#### `binkp.net`
I'm pretty sure this maps the binkp port that WWIVnet uses, to each node. There doesn't appear to be any documentation around this, but the file is in the WWIVnet repo. Just add the new node number, URL and bink port.

```
@1 get-ghosted.com:24556
@2 ghostmachine.ddns.net:24557
@3 get-ghosted.com:24557
@4 spacejunkbbs.com:24555
```

## WWIVUtil
There are ./wwivutil network helpers. See the [WWIV Docs]([https://](https://docs.wwivbbs.org/en/latest/wwivutil/#wwivutil-net)).
