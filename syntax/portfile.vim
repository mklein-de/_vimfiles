syn keyword portfileVariable contained
\ name version epoch description long_description notes revision categories
\ maintainers platforms homepage master_sites worksrcdir distname checksums
\ macosx_deployment_target copy_log_files conflicts replaced_by add_users
\ installs_libs prefix libpath portpath workpath worksrcpath filesdir
\ filespath distpath applications_dir frameworks_dir destroot supported_archs
\ patchfiles dist_subdir license developer_dir distfiles universal_variant

syn keyword portfileChecksumAlgorithm md5 rmd160 sha1 sha256

syn match portfileVariable "use_\(automake\|autoconf\|configure\|parallel_build\)" contained
syn match portfileVariable "use_\(dmg\|zip\|bzip2\|lzma\|xz\|7z\)" contained
syn match portfileVariable "depends_\(fetch\|extract\|build\|run\|lib\)\(-append\)\?" contained
syn match portfileVariable "os\.\(arch\|version\|major\|endian\|platform\|subplatform\)" contained
syn match portfileVariable "install\.\(user\|group\)" contained
syn match portfileVariable "livecheck\.\(type\|name\|distname\|version\|url\|regex\|md5\)" contained
syn match portfileVariable "xcode\.\(target\|configuration\|project\|destroot\.settings\(-append\)\?\)" contained
syn match portfileVariable "configure\.\(args\|cflags\|cppflags\|ldflags\)\(-append\|-delete\)\?" contained
syn match portfileVariable "configure\.\(compiler\)" contained
syn match portfileVariable "extract\.\(suffix\)" contained
syn match portfileVariable "fetch\.\(type\)" contained
syn match portfileVariable "build\.\(dir\|type\|target\)" contained
syn match portfileVariable "\(destroot\|build\)\.\(env\)\(-append\)\?" contained
syn match portfileVariable "svn\.\(url\|tag\)" contained
syn match portfileVariable "git\.\(url\|branch\)" contained
syn match portfileVariable "destroot\.\(destdir\|violate_mtree\)" contained
syn match portfileVariable "startupitem\.\(create\|start\|stop\)" contained
syn match portfileVariable "patch\.\(pre_args\)" contained
syn match portfileVariable "python\.\(prefix\)" contained

syn match portfileIdentifier "\K\k*" contained contains=portfileVariable

syn match portfileTab "\t"
syn match portfileTrailingSpace "\s\+$"
syn match portfileComment "#.*$"
syn match portfileExpansion "\${\K\?\k*}" contains=portfileIdentifier
syn match portfileLine "^\s*\K\k*\ze\s" contains=portfileIdentifier
syn match portfilePhase "^\s*\(\(pre\|post\)-\)\?\(fetch\|extract\|patch\|configure\|build\|destroot\)\ze\s*{"

syn match portfilePortSystem "^PortSystem\ze\s\+[0-9.]\+"
syn match portfilePortGroup "^PortGroup\ze\s\+\(xcode\|qt4\|cmake\|python26\)*\s\+[0-9.]\+"

syn region String   start=+"+  skip=+\\\\\|\\"+  end=+"+ contains=portfileExpansion

hi link portfileTab Error
hi link portfileTrailingSpace Error
hi link portfileExpansion Statement
hi link portfileIdentifier Statement
hi link portfileVariable Identifier
hi link portfileComment Comment
hi link portfilePhase PreProc
hi link portfilePortSystem Type
hi link portfilePortGroup Type
hi link portfileChecksumAlgorithm Keyword
