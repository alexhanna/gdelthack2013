import re,sys,json

def path_for_tabari(path_arr):
    """ path_arr is a list-of-lists-of-strings that represents the dependency path. """
    out = []
    for x in path_arr:
        if x[0]=='A':
            _,rel,arrow = x
            if rel.startswith("prep_"):
                prepword = rel.replace("prep_","")
                out.append( prepword + "_" )
            elif rel=='dobj' or rel=='semagent':
                pass
            else:
                ## um.. a weird relation. let's just skip this too.
                # deparc = ("&larr;"+rel) if arrow=='<-' else (rel+"&rarr;")
                # out.append("<span class=depedge>" +deparc+ "</span>")
                pass
        elif x[0]=='W':
            # need to decide how to do stemming here.
            _,lemma,pos = x
            lemma = lemma.lower()
            out.append(lemma)
    return ' '.join(out)

if __name__=='__main__':
    for line in sys.stdin:
        parts = line.rstrip('\n').split('\t')
        # print parts
        cameocode, pathstr = parts
        path = json.loads(pathstr)
        path2 = path_for_tabari(path)
        if not path2:
            continue
            # path2 = "NULLSKIP"
        # print "%s\t <-- \t%s" % (path2, line.strip())
        # print '\t'.join([cameocode, path2])
        print "%s [%s]" % (path2, cameocode)


