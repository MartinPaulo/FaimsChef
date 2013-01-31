#!/bin/sh

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# requires that the tdar user is created, 
# that password input is not required for that user - local is trusted

echo "creating user"
createuser -d -S -R -e tdar 

#psql postgres -c "create role tom login password 'hello'"
# sudo -u postgres createuser -d -R -P APPNAME
# sudo -u postgres createdb -O APPNAME APPNAME

echo "granting user rights to use plpgsql"
psql -U postgres --command "GRANT USAGE ON LANGUAGE plpgsql TO tdar;"

echo "dropping existing databases"
dropdb -U tdar tdarmetadata 
dropdb -U tdar tdardata 
echo "creating new databases"
createdb -O tdar  -U tdar tdarmetadata 
createdb -O tdar -U tdar tdardata
echo "loading schema"
psql -U tdar -f tdarmetadata_schema.sql tdarmetadata > log.txt
echo "loading controlled data"
psql -U tdar -f tdarmetadata_init.sql tdarmetadata >> log.txt
echo "running upgrade script"
psql -U tdar -f upgrade_scripts/upgrade-db.sql tdarmetadata >> log.txt
