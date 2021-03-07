#!/bin/bash
#!/bin/sh

ssh -o ConnectTimeout=1 serverArnie "cat serverArnie.txt" >> data/server.txt'
ssh -o ConnectTimeout=1 serverAlex "cat serverAlex.txt" >> data/server.txt'
