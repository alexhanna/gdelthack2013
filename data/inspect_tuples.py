#check out the dir of found tuples vs known pattern matches
#enter interactive mode to inspect
#get a dict of doc_id: [tabari codes, new dep paths]

from ast import literal_eval
import code
import os
import sys
from collections import defaultdict


def load_matches(match_file):
    match_dict = {}
    with open(match_file) as mf:
       for line in mf:
           tab_split = line.split("\t")
#in match_dict: tuple_to_match:(tabari_category, 0)
           tup = tab_split[2]
           tup = literal_eval(tup)
           tup = str(tup)
           match_dict[tup]=[tab_split[0],0]
    return match_dict

def doc_lists_from_t_file(unfound_tuples, t_file, match_dict):
    doc_verbs = defaultdict(list)
    with open(t_file) as t_f:
        for line in t_f:
            if line.startswith("=== "):
                split_id = line.split()
                doc_id = split_id[1]
            if line.startswith("TUPLE"):
                space_split = line.split()
                if space_split[1].rstrip().endswith("}"):
                    tup = literal_eval(space_split[1])
                    tup_path = tup["pred"]["path"]
                    as_str = str(tup_path)
#documenting how many times each of the known patterns occurs
#and adding the known pattern id to the doc record
                    if as_str in match_dict:
                        match_dict[as_str][1]+=1
                        doc_verbs[doc_id].append(match_dict[as_str][0])                        
                    else:
                        unfound_tuples.append(tup)
                        doc_verbs[doc_id].append(tup)
                        

def listdir_joined(path):
    return [os.path.join(path, entry) for entry in os.listdir(path)]                    

def main(match_file,tuple_dir):
    match_dict = load_matches(match_file)
    tup_files = [fn for fn in listdir_joined(tuple_dir) if fn.endswith(".tuple")]
    print len(tup_files)
    unfound_tuples = []
    doc_lists = []
    for tup_file in tup_files:
        doc_lists.extend(doc_lists_from_t_file(unfound_tuples,tup_file,match_dict))
    code.interact(local = locals())


if __name__ == "__main__":
    match_file = sys.argv[1]
    tuple_dir = sys.argv[2]
    main(match_file,tuple_dir)          
