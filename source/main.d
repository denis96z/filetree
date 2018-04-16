import std.stdio;
import std.path;
import std.file;

void main(string[] argv)
{
    if (argv.length != 2)
    {
        writeln("Wrong number of arguments. Format:");
        writeln("filetree [root]");
    }
    else
    {
        auto root = argv[1];
        if (isValidPath(root))
        {
            printTree(root);
        }
        else
        {
            writeln("Invalid path.");
        }
    }
}

void printTree(string root)
{
    printFile(root, 0);
}

void printDir(string path, int level)
{
    foreach (string file; dirEntries(path, SpanMode.shallow, false))
    {
        printFile(file, level);
    }
}

void printFile(string path, int level)
{
    auto isdir = isDir(path);

    auto numSpaces = (level * 4) - (isdir ? 1 : 0);
    for (auto i = 0; i < numSpaces; ++i)
    {
        write(" ");
    }
    if (isdir)
    {
        write("-");
    }
    writeln(baseName(path));

    if (isdir)
    {
        printDir(path, level + 1);
    }
}