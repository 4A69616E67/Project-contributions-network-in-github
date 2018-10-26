open(IN,"github.csv");
open(EDGE,">github.edge.csv");
open(NODE,">github.node.csv");
print EDGE "source\ttarget\tweight\n";
print NODE "id\tlabel\tstar_count\tlanguage\n";
%hash=();
%node=();
while($line=<IN>)
{
    chomp $line;
    @str=split(/:|,/,$line);
    pop(@str);
    @title=split(/\*/,shift(@str));
    $project_name=$title[0];
    $star_count=$title[1];
    $language=$title[2];
    print NODE $project_name."\t".$project_name."\t".$star_count."\t".$language."\n";
    foreach $i (@str[1..$#str])
    {
        push(@{$hash{$project_name}},$i);
    }
}
close(NODE);
@name_list=keys(%hash);
for($i=0;$i<scalar(@name_list)-1;$i++)
{
    %namehash=();
    foreach $number (@{$hash{$name_list[$i]}})
    {
        $namehash{$number}=1;
    }
    for($j=$i+1;$j<scalar(@name_list);$j++)
    {
        $count=0;
        foreach $number (@{$hash{$name_list[$j]}})
        {
            if(exists($namehash{$number}))
            {
                $count++;
            }
        }
        if($count>0)
        {
            print EDGE $name_list[$i]."\t".$name_list[$j]."\t".$count."\n";
        }
    }
}
close(EDGE);

open(IN,"Datas.csv");
open(OUT,">Datas.edge.csv");
print OUT "source\ttarget\tweight\n";
$line=<IN>;
chomp $line;
@name=split(/,/,$line);
shift(@name);
$i=0;
while($line=<IN>)
{
    chomp $line;
    @{$num[$i]}=split(/,/,$line);
    shift(@{$num[$i]});
    $i++;
}
for($i=0;$i<scalar(@name);$i++)
{
    for($j=$i+1;$j<scalar(@name);$j++)
    {
        if($num[$i][$j]>0.1)
        {
            print OUT $name[$i]."\t".$name[$j]."\t".$num[$i][$j]."\n";
        }
    }
}
close(OUT);
