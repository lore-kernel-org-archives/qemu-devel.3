Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74F1C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 00:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u87JY-0005aE-Vj; Thu, 24 Apr 2025 20:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@unidef.net>) id 1u86aO-0005fZ-8G
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 20:06:32 -0400
Received: from p-west2-cluster4-host12-snip6-10.eps.apple.com
 ([2a01:b747:3000:203::7b] helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@unidef.net>) id 1u86aJ-000350-CB
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 20:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unidef.net; s=sig1;
 bh=akSZg1n335IScaVnpxY+ELmroDHIlQ83qrtyn5mrMN0=;
 h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme;
 b=gklFxB2jaXZ4vgZZN2IstwmljTvgdI7TjGeWt4JdlTi7tHUunKryYSouZO9qasMjF
 ZM7ky4SY+IjLMuqZ4up3qRDHqO3sp4i/F3mbSXcXeJufTeNIuGdxus62xkvxuVfZcz
 Dd5XxXPGmXtaNffcP6S9OMtHYkXwhL04o30/s//3gvhYmBaIvMsk5YF2pdeIyc7WKq
 8XQnSDzE3C0L4v/lWKBLi5uSVNFgbARCwmLA80cwYlPaSYRifONW8JY2oAlAlYIL2u
 ajZUncvdYnEAxz/Ix1z4VG4oci6RDzBXZWOS4PZWbBM02RcPtk5NFL9XCzvFM+YMdS
 92/IUBJm6ehXw==
Received: from smtpclient.apple (mr-asmtp-me-k8s.p00.prod.me.com
 [17.57.152.38])
 by outbound.mr.icloud.com (Postfix) with ESMTPSA id 77183180025C
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 00:06:18 +0000 (UTC)
From: Jon <jon@unidef.net>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_FA8FD7AA-7DCB-42B2-8569-3640F58C26BF"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Hi, would the qemu team be interested in using my shell scripts for
 their contrib dir?
Message-Id: <101E972D-BE95-46CF-9469-27DAFC9887FF@unidef.net>
Date: Thu, 24 Apr 2025 17:06:07 -0700
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Proofpoint-GUID: jFXgueze9fYV3Px1zH1LApyWPn4Lm14O
X-Proofpoint-ORIG-GUID: jFXgueze9fYV3Px1zH1LApyWPn4Lm14O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1030 spamscore=0 malwarescore=0
 bulkscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503100000 definitions=main-2504240171
Received-SPF: permerror client-ip=2a01:b747:3000:203::7b;
 envelope-from=jon@unidef.net; helo=outbound.mr.icloud.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 URI_HEX=0.1 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 24 Apr 2025 20:53:10 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--Apple-Mail=_FA8FD7AA-7DCB-42B2-8569-3640F58C26BF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

(The vmrun script is copy/pasted in this email,, sorry for getting =
spammy but I bought this domain =3D))

Im about 90% done with vmrun, all I need to do is add a backup/archive =
option, and a runner shell script that copies vm directory structure and =
allows you to copy and modify shell scripts.

My scripts do alot, it can download qemu10 and compile it (not from git =
just yet), it can create/delete vm directories, it can clean after =
itself, it can download the isos using curl, and I have it configured =
with -nographic; the scripts also print out all variables held in the =
script, and when the vm is done, it copies a copy of the vmrun script =
into the vm directory so you can do ./run

Most of the qemu binary commands are broken into environmental variables

If you could have an autogen script or something that generates a =
template like the script files I have on my git, it=E2=80=99d be awesome =
for qemu users, and yeah you=E2=80=99ll need a runner interface im =
guessing! and yeah, my codebase is a little shaky, some sed/awk/grep =
magic on the process ids would be nice, but if someone wants to rewrite =
my script to the qemu-devel team as a makeshift template to qemu it=E2=80=99=
d be awesome !!

You can do a clone of vmrun by running:

git clone https://github.com/unidef/vmrun

Here=E2=80=99s the readme:

VMRUN .1 beta
UNIDEF SOFTWARE
intro
** debian12 does not work just yet !! ** ** if you want to stop a =
virtual machine, you need to issue a 'pids' command to the script and =
try to end the processes by process of elimination! **
these scripts were made for mac silion (m1/m2/m3/m4) devices with an =
external hard disk for virtualizing fedora server 42, ubuntu server 24, =
and freebsd 14, its intended to be left at a central spot =
(~/.vmrun/src), then copied to another bash script, such as =
runsolaris13.sparc.sh in ~/.vmrun/prod, and then requires modification =
of the script to work properly, ie inputting the right variables to =
create and install to virtual machine directories and download an =
installation iso. after the variables are set, you can download, =
install, and delete virtual machines as well as make a copy of the shell =
script and place it in the vm dir all within commands issued to the =
shell scripts included
** these virtual machines will output directly to the terminal, meaning =
there is no need for hardware accelerated stuff, or buggy display =
managers !! works well in mac, is awesome on bsd/linux !!**
the urls to isos i included in the script files are dvd images, and can =
be as about 4gb in size, so be careful. i found that network installs =
lead to more erratic results in vms
you can modify these to use kvm and typical unix file system =
heriarchies. also from my experience debian12 doesnt work as well as =
intended, but the server scripts work fine along with freebsd 14 on my =
mac book air
installation extract the tarball and execute files with a shell =
interpreter, like bash or sh, or flag them as an executable using the =
chmod script included
usage:
general usage: copy a vmrun script to its own filename, edit the script, =
and execute with the sh or bash command, or even zsh

enviromental variables in scripts:

DISTRO      holds the image name, iso name, and directory name suffix.
VMPATH      this is the prefix to $DISTRO, and contains the root vm =
folder to use
VMSPACE     default size for qemu disk images, defaults to 200G
BOOTDISK    default boot disk for $DISTRO
QEMU_BINARY default location of bootstrapped qemu
LOCALPREFIX where to install qemu when fetched from script
QEMU_SMP    sets the number of processors in the vm, default 8
QEMU_MEM    sets the number of gigs to allocate to the vm, defaults to =
1G
QEMU_BIOS   sets the bios image for the qemu binary, can be an absolute =
path to a custom bios, there are a few bios' that come with qemu
FASTHDDEV   3 options are commented out but the latter FASTHHDEV is good =
enough!
SND	    intel hda sound interface
NETDRIVER   ethernet driver, defaults to e1000
QEMU_ACCEL  hardware acceleration for vms, defaults to hvf for macos, =
this should be kvm
	    for linux hosts
QEMU_VNC    vnc server so you can use x11 if connected (needs work done)
QEMU_CMD    main qemu command that launches virtualized environments
TERM_OPEN   unfinished
URL         URL is the url of the web address of the $DISTRO =
installation image
commands:
download =3D download image specified in this script
format =3D format an image for use with qemu
install =3D install using iso specified in script
copybash =3D copies script to vm dir
dirs =3D create all required directories
auto =3D automatically download an iso, format a 200G virtual drive, =
and, install the operating system (be sure to 	run this as root)
kill =3D kills all qemu processes
delIMAGES =3D deletes installation iso and disk images
qemu =3D bootstraps qemu 10.0.0 in /Users/r_atkins/.qlocal
run =3D runs the virtual machine and outputs its contents to the =
terminal
boot =3D same thing as rundebian12.aarch64.sh run
vars =3D show almost all enviormental variables used in script
clean =3D deletes all files created by shell script
deltemp =3D deletes temporary iso file
pids =3D shows all process ids=20
for auto setup:
the auto option creates directories, downloads the iso in question for =
the vm, formats a driver at VMPREFIX, and copies the script to its =
location, where you can run that script to boot the vm
additional notes: made for macos silicon devices dont forcefully =
terminate a vm or you might have trouble booting it next time
chmod_all_src.sh: this file reiterates over all files in the src/ =
directory and chmods them
todo: add backup/archive options

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94
Copy of a script from vmrun:

#!/bin/bash

DISTRO=3Dfreebsd14-aarch64
VMPATH=3D/Volumes/M2/virt
VMPREFIX=3D$VMPATH/$DISTRO
INSTALL_ISO_PATH=3D$VMPREFIX/iso
INSTALL_ISO=3D$INSTALL_ISO_PATH/$DISTRO.iso
INSTALL_ISO_TEMP=3D$INSTALL_ISO.temp
BOOTDISK=3D$VMPREFIX/$DISTRO.hd0.img
VMSPACE=3D200G


LOCALPREFIX=3D~/.qlocal

QEMU_BINARY=3D$LOCALPREFIX/bin/qemu-system-aarch64
QEMU_SOURCES=3D"https://download.qemu.org/qemu-10.0.0.tar.xz"
QEMU_SMP=3D8
QEMU_MEM=3D1G
NETWORKDEV=3Den0
QEMU_BIOS=3D"edk2-aarch64-code.fd"
#QEMU_BIOS=3D"QEMU,cgthree.bin"
#FASTHDDEV=3D"-device virtio-blk-pci,drive=3Dhd0,id=3Dhd0pci -drive =
file=3D$BOOTDISK,if=3Dnone,id=3Dhd0"
#FASTHDDEV=3D"-device virtio-blk-pci,drive=3Dhd0,id=3Dhd0pci -drive =
if=3Dvirtio,file=3D$BOOTDISK,format=3Dqcow2,drive=3Dhd0"
#FASTHDDEV=3D"-drive if=3Dnone,file=3D$BOOTDISK,id=3Dhd0 -device =
virtio-blk-device,drive=3Dhd0"
FASTHDDEV=3D"-hda $BOOTDISK"
SND=3D"-device intel-hda"
NETDRIVER=3D"e1000"
QEMU_ACCEL=3D"hvf"
QEMU_VNC=3D"-vnc 127.0.0.1:0"
QEMU_CMD=3D"$QEMU_BINARY -smp $QEMU_SMP -device $NETDRIVER,netdev=3Deth0 =
-netdev vmnet-bridged,ifname=3Deth0,id=3Deth0,ifname=3D$NETWORKDEV -M =
virt,highmem=3Doff -cpu host -accel $QEMU_ACCEL -bios $QEMU_BIOS -m =
$QEMU_MEM -nographic $FASTHDDEV $SND $QEMU_VNC -boot c"

TERM_OPEN=3D"osascript -e 'tell app "Terminal" to do script =
"$QEMU_CMD"'"

=
URL=3D"https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/14.2=
/FreeBSD-14.2-RELEASE-arm64-aarch64-dvd1.iso"
JOBS=3D80


function Vars(){
    echo "DISTRO $DISTRO"
    echo "VMPREFIX $VMPREFIX"
    echo "INSTALL_ISO $INSTALL_ISO"
    echo "BOOTDISK $BOOTDISK"
    echo "VMSPACE $VMSPACE"
    echo "------------"
    echo "QEMU_SOURCE $QEMU_SOURCES"
    echo "QEMU_BINARY $QEMU_BINARY"
    echo "QEMU_SMP $QEMU_SMP"
    echo "QEMU_MEM $QEMU_MEM"
    echo "URL $URL"
    echo "JOBS (COMPILE THREAD COUNT FOR COMPILING QEMU) $JOBS"
}

function intro(){
echo ""
echo ""
echo ""
echo "!-- using qemu-system-aarch64"
echo "!-- the DISTRO variable is a prefix for all disk and installer =
isos, the value of DISTRO now is $DISTRO, meaning the hard drive image =
will be $BOOTDISK and the disk image in question will be located at =
$INSTALL_ISO"
echo "!-- be sure to modify the INSTALL_ISO and BOOTDISK variables in =
this script"
echo "!-- the variable for INSTALL_ISO is $URL"
echo "!-- the variable  for BOOTDISK is $BOOTDISK"
echo "!-- the prefix set for VMPREFIX is $VMPREFIX"
echo "!-- the variable for VMSPACE is $VMSPACE"
echo "!-- be sure to run as root!"
echo "!-- this program should be able to download a distributions iso, =
format a drive on a local device, install, and be able to run a vm =
without much hassle"
echo ""
echo ""
echo ""
}

intro


function help(){
    echo ""
    echo ""
    echo ""
    echo "--- vmrun 0.1 beta"
    echo "--- $0 download =3D download image specified in this script"
    echo "--- $0 format =3D format an image for use with qemu"
    echo "--- $0 install =3D install using iso specified in script"
    echo "--- $0 copybash =3D copies $0 to $VMPREFIX"
    echo "--- $0 dirs =3D create all required directories"
    echo "--- $0 auto =3D automatically download an iso, format a 200G =
virtual drive, and, install the operating system (be sure to run this as =
root)"
    echo "--- $0 kill =3D kills all qemu processes"
    echo "--- $0 delIMAGES =3D deletes installation iso and disk images"
    echo "--- $0 qemu =3D bootstraps qemu 10.0.0 in $LOCALPREFIX"
    echo "--- $0 run =3D runs the virtual machine and outputs its =
contents to the terminal"
    echo "--- $0 boot =3D same thing as $0 run"
    echo "--- $0 vars =3D show almost all enviormental variables used in =
script"
    echo "--- $0 clean =3D deletes all files created by $0"
    echo "--- $0 deltemp =3D deletes temporary iso file"
    echo "-------"
    echo "typical usage is '$0 qemu' then '$0 auto', then '$0 run', but =
you can also do '$0 qemu' to get qemu10, '$0 download' to download $URL, =
'$0 format' to create a disk image at $BOOTDISK, '$0 install' to install =
the os and then '$0 boot'"
    echo "a copy of this script will be copied to the vm directory, so =
you can cd $VMPREFIX and execute $0 boot"
    echo "-------"
    echo ""
    echo ""
    echo ""
}

help

function create_local(){
    mkdir -p $INSTALL_ISO_PATH
    mkdir $VMPREFIX
    mkdir $LOCALPREFIX
    mkdir $LOCALPREFIX/src
}

function fetchqemu(){
    echo "creating local dirs"
    create_local
    echo "fetching git sources for qemu"
    mkdir $LOCALPREFIX/src
    curl $QEMU_SOURCES -o $LOCALPREFIX/src/dl.qemu.tar.xz
    cd $LOCALPREFIX/src
    tar xfv $LOCALPREFIX/src/dl.qemu.tar.xz
    cd qemu-10.0.0
    ./configure --prefix=3D$LOCALPREFIX
    make -j$JOBS
    make install
}


function downloadvm(){
    if [ -f $INSTALL_ISO ]; then
	echo "existing iso found, hopefully its not corrupt!"
	else
	echo "!--- downloading iso from $URL and saving it to =
$INSTALL_ISO_TEMP"
	curl $URL -o $INSTALL_ISO_TEMP && COMPLETE=3D1
	if [ $COMPLETE =3D 1 ]; then
	    echo "complete install detected, copying $INSTALL_ISO_TEMP =
to $INSTALL_ISO"
	    cp -v $INSTALL_ISO_TEMP $INSTALL_ISO
	    echo "deleting temp file"
	    delisotemp
	fi
=09
    fi

    echo "if your downloaded iso doesnt work as intended, try running $0 =
deltemp!"
}
function delisotemp(){
    echo "deleting $INSTALL_ISO_TEMP"
    rm -rf $INSTALL_ISO_TEMP
    echo "done"
    }
   =20
function delimages(){
    echo "REMOVING HARD DRIVE IMAGES AND INSTALLATION IMAGE!"
    rm -rf $BOOTDISK
    rm -rf $INSTALL_ISO
    echo "done"
}

function clean(){
    delimages
    echo "deleting $VMPREFIX"
    rm -rf $VMPREFIX
    echo "done"
    }


function formatvm(){
    echo "creating $BOOTDISK"
    qemu-img create -f qcow2 $BOOTDISK $VMSPACE
}

function installvm() {
exec sudo $QEMU_CMD -cdrom $INSTALL_ISO
copybash
}

function runvm() {
    exec sudo $QEMU_CMD
}



function vmlistpids(){
    ps -ax | grep qemu-system-aarch64 |  awk {'print NR " pid: " $1 " =
program: " $4'}
    echo "if you want to kill a specific process and gain access back to =
your disk image, use 'kill -9'"
}

function killall_vms(){
    echo "killing all qemu aarch64 proccesess"
    sudo killall qemu-system-aarch64
}

function copybash(){
    echo "copying bash script to $VMPREFIX"
    cd .
    cp $0 $VMPREFIX
    echo "done"
}

function auto(){
    echo "creating local directories"
    create_local
    echo "downloading iso"
    downloadvm
    echo "formatting qemu img"
    formatvm
    echo "copying script to $VMPREFIX"
    copybash
    echo "installing vm. good luck!"
    installvm
    copybash
}

if [[ "$@" =3D=3D "vars" ]]; then
    Vars
fi

if [[ "$@" =3D=3D "clean" ]]; then
    clean
fi


if [[ "$@" =3D=3D "boot" ]]; then
    runvm
fi

if [[ "$@" =3D=3D "run" ]]; then
    runvm
fi

if [[ "$@" =3D=3D "deltemp" ]]; then
    delisotemp
fi


if [[ "$@" =3D=3D "install" ]]; then
    installvm
fi

if [[ "$@" =3D=3D "kill" ]]; then
    killall_vms
fi

if [[ "$@" =3D=3D "format" ]]; then
    formatvm
fi

if [[ "$@" =3D=3D "download" ]]; then
    echo $URL
    echo $BOOT_DISK
    downloadvm
fi

if [[ "$@" =3D=3D "copybash" ]]; then
    copybash
fi


if [[ "$@" =3D=3D "auto" ]]; then
    auto
fi

if [[ "$@" =3D=3D "" ]]; then
    exit
fi

if [[ "$@" =3D=3D "help" ]]; then
    help
fi

if [[ "$@" =3D=3D "pids" ]]; then
    vmlistpids
fi

if [[ $@ =3D "qemu" ]]; then
    fetchqemu
fi

if [[ $@ =3D "delIMAGES" ]]; then
    delimages
fi

if [[ $@ =3D "dir" ]]; then
	create_local
fi
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94
And the chmod_all.sh script
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94
#!/bin/bash

cmd=3D`ls src/`
for x in $cmd; do
    echo "flagging $x as executable"
    chmod +x src/$x
done
echo "done"

jon
unidef.net admin
110110.net admin


--Apple-Mail=_FA8FD7AA-7DCB-42B2-8569-3640F58C26BF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><div>(The =
vmrun script is copy/pasted in this email,, sorry for getting spammy but =
I bought this domain =3D))</div><div><br></div>Im about 90% done with =
vmrun, all I need to do is add a backup/archive option, and a runner =
shell script that copies vm directory structure and allows you to copy =
and modify shell scripts.<div><br></div><div>My scripts do alot, it can =
download qemu10 and compile it (not from git just yet), it can =
create/delete vm directories, it can clean after itself, it can download =
the isos using curl, and I have it configured with -nographic; the =
scripts also print out all variables held in the script, and when the vm =
is done, it copies a copy of the vmrun script into the vm directory so =
you can do ./run</div><div><br></div><div>Most of the qemu binary =
commands are broken into environmental =
variables</div><div><br></div><div>If you could have an autogen script =
or something that generates a template like the script files I have on =
my git, it=E2=80=99d be awesome for qemu users, and yeah you=E2=80=99ll =
need a runner interface im guessing! and yeah, my codebase is a little =
shaky, some sed/awk/grep magic on the process ids would be nice, but if =
someone wants to rewrite my script to the qemu-devel team as a makeshift =
template to qemu it=E2=80=99d be awesome !!</div><div><br></div><div>You =
can do a clone of vmrun by running:</div><div><br></div><div>git clone =
<a =
href=3D"https://github.com/unidef/vmrun">https://github.com/unidef/vmrun</=
a></div><div><br></div><div>Here=E2=80=99s the =
readme:</div><div><br></div><div><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-bottom: var(--base-size-16); =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-top: 0px !important;">VMRUN .1 =
beta</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; margin-bottom: var(--base-size-16); =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;;">UNIDEF SOFTWARE</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
margin-bottom: var(--base-size-16); caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI =
Emoji&quot;;">intro</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; margin-bottom: =
var(--base-size-16); caret-color: rgb(31, 35, 40); color: rgb(31, 35, =
40); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe =
UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, =
&quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;;">** debian12 =
does not work just yet !! ** ** if you want to stop a virtual machine, =
you need to issue a 'pids' command to the script and try to end the =
processes by process of elimination! **</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
margin-bottom: var(--base-size-16); caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI =
Emoji&quot;;">these scripts were made for mac silion (m1/m2/m3/m4) =
devices with an external hard disk for virtualizing fedora server 42, =
ubuntu server 24, and freebsd 14, its intended to be left at a central =
spot (~/.vmrun/src), then copied to another bash script, such as =
runsolaris13.sparc.sh in ~/.vmrun/prod, and then requires modification =
of the script to work properly, ie inputting the right variables to =
create and install to virtual machine directories and download an =
installation iso. after the variables are set, you can download, =
install, and delete virtual machines as well as make a copy of the shell =
script and place it in the vm dir all within commands issued to the =
shell scripts included</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; margin-bottom: =
var(--base-size-16); caret-color: rgb(31, 35, 40); color: rgb(31, 35, =
40); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe =
UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, =
&quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;;">** these =
virtual machines will output directly to the terminal, meaning there is =
no need for hardware accelerated stuff, or buggy display managers !! =
works well in mac, is awesome on bsd/linux !!**</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
margin-bottom: var(--base-size-16); caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI =
Emoji&quot;;">the urls to isos i included in the script files are dvd =
images, and can be as about 4gb in size, so be careful. i found that =
network installs lead to more erratic results in vms</p><hr =
style=3D"font-size: 16px; box-sizing: border-box; height: 0.25em; =
margin: var(--base-size-24) 0; background-image: none; =
background-position: 0% 0%; background-size: auto; background-repeat: =
repeat; background-attachment: scroll; background-origin: padding-box; =
background-clip: border-box; border: 0px; padding: 0px; font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;;"><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; margin-bottom: =
var(--base-size-16); caret-color: rgb(31, 35, 40); color: rgb(31, 35, =
40); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe =
UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, =
&quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;;">you can =
modify these to use kvm and typical unix file system heriarchies. also =
from my experience debian12 doesnt work as well as intended, but the =
server scripts work fine along with freebsd 14 on my mac book air</p><hr =
style=3D"font-size: 16px; box-sizing: border-box; height: 0.25em; =
margin: var(--base-size-24) 0; background-image: none; =
background-position: 0% 0%; background-size: auto; background-repeat: =
repeat; background-attachment: scroll; background-origin: padding-box; =
background-clip: border-box; border: 0px; padding: 0px; font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;;"><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; margin-bottom: =
var(--base-size-16); caret-color: rgb(31, 35, 40); color: rgb(31, 35, =
40); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe =
UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, =
&quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;;">installation =
extract the tarball and execute files with a shell interpreter, like =
bash or sh, or flag them as an executable using the chmod script =
included</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; margin-bottom: var(--base-size-16); =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;;">usage:</p><div =
class=3D"snippet-clipboard-content notranslate position-relative =
overflow-auto" style=3D"font-size: 16px; box-sizing: border-box; =
display: flex; justify-content: space-between; margin-bottom: =
var(--base-size-16); caret-color: rgb(31, 35, 40); color: rgb(31, 35, =
40); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe =
UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, =
&quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; position: =
relative !important; overflow: auto !important;"><pre =
class=3D"notranslate" style=3D"box-sizing: border-box; font-family: =
var(--fontStack-monospace, ui-monospace, SFMono-Regular, SF Mono, Menlo, =
Consolas, Liberation Mono, monospace); font-size: 13.6px; margin-top: =
0px; margin-bottom: 0px; overflow-wrap: normal; padding: =
var(--base-size-16); overflow: auto; line-height: 1.45; border-radius: =
6px;"><code style=3D"box-sizing: border-box; font-family: =
var(--fontStack-monospace, ui-monospace, SFMono-Regular, SF Mono, Menlo, =
Consolas, Liberation Mono, monospace); font-size: 13.6px; padding: 0px; =
margin: 0px; background-image: none; background-position: 0% 0%; =
background-size: auto; background-repeat: repeat; background-attachment: =
scroll; background-origin: padding-box; background-clip: border-box; =
border-radius: 6px; word-break: normal; border: 0px; display: inline; =
overflow: visible; line-height: inherit; overflow-wrap: normal;">general =
usage: copy a vmrun script to its own filename, edit the script, and =
execute with the sh or bash command, or even zsh

enviromental variables in scripts:

DISTRO      holds the image name, iso name, and directory name suffix.
VMPATH      this is the prefix to $DISTRO, and contains the root vm =
folder to use
VMSPACE     default size for qemu disk images, defaults to 200G
BOOTDISK    default boot disk for $DISTRO
QEMU_BINARY default location of bootstrapped qemu
LOCALPREFIX where to install qemu when fetched from script
QEMU_SMP    sets the number of processors in the vm, default 8
QEMU_MEM    sets the number of gigs to allocate to the vm, defaults to =
1G
QEMU_BIOS   sets the bios image for the qemu binary, can be an absolute =
path to a custom bios, there are a few bios' that come with qemu
FASTHDDEV   3 options are commented out but the latter FASTHHDEV is good =
enough!
SND	    intel hda sound interface
NETDRIVER   ethernet driver, defaults to e1000
QEMU_ACCEL  hardware acceleration for vms, defaults to hvf for macos, =
this should be kvm
	    for linux hosts
QEMU_VNC    vnc server so you can use x11 if connected (needs work done)
QEMU_CMD    main qemu command that launches virtualized environments
TERM_OPEN   unfinished
URL         URL is the url of the web address of the $DISTRO =
installation image
</code></pre><div class=3D"zeroclipboard-container" style=3D"box-sizing: =
border-box; animation: auto;"><clipboard-copy aria-label=3D"Copy" =
class=3D"ClipboardButton btn btn-invisible js-clipboard-copy m-2 p-0 =
d-flex flex-justify-center flex-items-center" =
data-copy-feedback=3D"Copied!" data-tooltip-direction=3D"w" =
value=3D"general usage: copy a vmrun script to its own filename, edit =
the script, and execute with the sh or bash command, or even zsh

enviromental variables in scripts:

DISTRO      holds the image name, iso name, and directory name suffix.
VMPATH      this is the prefix to $DISTRO, and contains the root vm =
folder to use
VMSPACE     default size for qemu disk images, defaults to 200G
BOOTDISK    default boot disk for $DISTRO
QEMU_BINARY default location of bootstrapped qemu
LOCALPREFIX where to install qemu when fetched from script
QEMU_SMP    sets the number of processors in the vm, default 8
QEMU_MEM    sets the number of gigs to allocate to the vm, defaults to =
1G
QEMU_BIOS   sets the bios image for the qemu binary, can be an absolute =
path to a custom bios, there are a few bios' that come with qemu
FASTHDDEV   3 options are commented out but the latter FASTHHDEV is good =
enough!
SND	    intel hda sound interface
NETDRIVER   ethernet driver, defaults to e1000
QEMU_ACCEL  hardware acceleration for vms, defaults to hvf for macos, =
this should be kvm
	    for linux hosts
QEMU_VNC    vnc server so you can use x11 if connected (needs work done)
QEMU_CMD    main qemu command that launches virtualized environments
TERM_OPEN   unfinished
URL         URL is the url of the web address of the $DISTRO =
installation image" tabindex=3D"0" role=3D"button" style=3D"box-sizing: =
border-box; position: relative; font-size: 14px; line-height: 20px; =
white-space: nowrap; vertical-align: middle; cursor: pointer; =
-webkit-user-select: none; border: 0px; border-radius: 6px; appearance: =
none; box-shadow: none; transition: color 80ms cubic-bezier(0.33, 1, =
0.68, 1), background-color, box-shadow, border-color; width: =
var(--control-small-size, 28px); height: var(--control-small-size, =
28px); display: flex !important; padding: 0px !important; =
justify-content: center !important; align-items: center !important; =
margin: var(--base-size-8, 8px) !important;"><svg aria-hidden=3D"true" =
height=3D"16" viewBox=3D"0 0 16 16" version=3D"1.1" width=3D"16" =
data-view-component=3D"true" class=3D"octicon octicon-copy =
js-clipboard-copy-icon"></svg></clipboard-copy></div></div><p dir=3D"auto"=
 style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
margin-bottom: var(--base-size-16); caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI =
Emoji&quot;;">commands:</p><div class=3D"snippet-clipboard-content =
notranslate position-relative overflow-auto" style=3D"font-size: 16px; =
box-sizing: border-box; display: flex; justify-content: space-between; =
margin-bottom: var(--base-size-16); caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
position: relative !important; overflow: auto !important;"><pre =
class=3D"notranslate" style=3D"box-sizing: border-box; font-family: =
var(--fontStack-monospace, ui-monospace, SFMono-Regular, SF Mono, Menlo, =
Consolas, Liberation Mono, monospace); font-size: 13.6px; margin-top: =
0px; margin-bottom: 0px; overflow-wrap: normal; padding: =
var(--base-size-16); overflow: auto; line-height: 1.45; border-radius: =
6px;"><code style=3D"box-sizing: border-box; font-family: =
var(--fontStack-monospace, ui-monospace, SFMono-Regular, SF Mono, Menlo, =
Consolas, Liberation Mono, monospace); font-size: 13.6px; padding: 0px; =
margin: 0px; background-image: none; background-position: 0% 0%; =
background-size: auto; background-repeat: repeat; background-attachment: =
scroll; background-origin: padding-box; background-clip: border-box; =
border-radius: 6px; word-break: normal; border: 0px; display: inline; =
overflow: visible; line-height: inherit; overflow-wrap: =
normal;">download =3D download image specified in this script
format =3D format an image for use with qemu
install =3D install using iso specified in script
copybash =3D copies script to vm dir
dirs =3D create all required directories
auto =3D automatically download an iso, format a 200G virtual drive, =
and, install the operating system (be sure to 	run this as root)
kill =3D kills all qemu processes
delIMAGES =3D deletes installation iso and disk images
qemu =3D bootstraps qemu 10.0.0 in /Users/r_atkins/.qlocal
run =3D runs the virtual machine and outputs its contents to the =
terminal
boot =3D same thing as rundebian12.aarch64.sh run
vars =3D show almost all enviormental variables used in script
clean =3D deletes all files created by shell script
deltemp =3D deletes temporary iso file
pids =3D shows all process ids=20
</code></pre><div class=3D"zeroclipboard-container" style=3D"box-sizing: =
border-box; animation: auto;"><clipboard-copy aria-label=3D"Copy" =
class=3D"ClipboardButton btn btn-invisible js-clipboard-copy m-2 p-0 =
d-flex flex-justify-center flex-items-center" =
data-copy-feedback=3D"Copied!" data-tooltip-direction=3D"w" =
value=3D"download =3D download image specified in this script
format =3D format an image for use with qemu
install =3D install using iso specified in script
copybash =3D copies script to vm dir
dirs =3D create all required directories
auto =3D automatically download an iso, format a 200G virtual drive, =
and, install the operating system (be sure to 	run this as root)
kill =3D kills all qemu processes
delIMAGES =3D deletes installation iso and disk images
qemu =3D bootstraps qemu 10.0.0 in /Users/r_atkins/.qlocal
run =3D runs the virtual machine and outputs its contents to the =
terminal
boot =3D same thing as rundebian12.aarch64.sh run
vars =3D show almost all enviormental variables used in script
clean =3D deletes all files created by shell script
deltemp =3D deletes temporary iso file
pids =3D shows all process ids " tabindex=3D"0" role=3D"button" =
style=3D"box-sizing: border-box; position: relative; font-size: 14px; =
line-height: 20px; white-space: nowrap; vertical-align: middle; cursor: =
pointer; -webkit-user-select: none; border: 0px; border-radius: 6px; =
appearance: none; box-shadow: none; transition: color 80ms =
cubic-bezier(0.33, 1, 0.68, 1), background-color, box-shadow, =
border-color; width: var(--control-small-size, 28px); height: =
var(--control-small-size, 28px); display: flex !important; padding: 0px =
!important; justify-content: center !important; align-items: center =
!important; margin: var(--base-size-8, 8px) !important;"><svg =
aria-hidden=3D"true" height=3D"16" viewBox=3D"0 0 16 16" version=3D"1.1" =
width=3D"16" data-view-component=3D"true" class=3D"octicon octicon-copy =
js-clipboard-copy-icon"></svg></clipboard-copy></div></div><p dir=3D"auto"=
 style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
margin-bottom: var(--base-size-16); caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI =
Emoji&quot;;">for auto setup:</p><div class=3D"snippet-clipboard-content =
notranslate position-relative overflow-auto" style=3D"font-size: 16px; =
box-sizing: border-box; display: flex; justify-content: space-between; =
margin-bottom: var(--base-size-16); caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
position: relative !important; overflow: auto !important;"><pre =
class=3D"notranslate" style=3D"box-sizing: border-box; font-family: =
var(--fontStack-monospace, ui-monospace, SFMono-Regular, SF Mono, Menlo, =
Consolas, Liberation Mono, monospace); font-size: 13.6px; margin-top: =
0px; margin-bottom: 0px; overflow-wrap: normal; padding: =
var(--base-size-16); overflow: auto; line-height: 1.45; border-radius: =
6px;"><code style=3D"box-sizing: border-box; font-family: =
var(--fontStack-monospace, ui-monospace, SFMono-Regular, SF Mono, Menlo, =
Consolas, Liberation Mono, monospace); font-size: 13.6px; padding: 0px; =
margin: 0px; background-image: none; background-position: 0% 0%; =
background-size: auto; background-repeat: repeat; background-attachment: =
scroll; background-origin: padding-box; background-clip: border-box; =
border-radius: 6px; word-break: normal; border: 0px; display: inline; =
overflow: visible; line-height: inherit; overflow-wrap: normal;">the =
auto option creates directories, downloads the iso in question for the =
vm, formats a driver at VMPREFIX, and copies the script to its location, =
where you can run that script to boot the vm
</code></pre><div class=3D"zeroclipboard-container" style=3D"box-sizing: =
border-box; animation: auto;"><clipboard-copy aria-label=3D"Copy" =
class=3D"ClipboardButton btn btn-invisible js-clipboard-copy m-2 p-0 =
d-flex flex-justify-center flex-items-center" =
data-copy-feedback=3D"Copied!" data-tooltip-direction=3D"w" value=3D"the =
auto option creates directories, downloads the iso in question for the =
vm, formats a driver at VMPREFIX, and copies the script to its location, =
where you can run that script to boot the vm" tabindex=3D"0" =
role=3D"button" style=3D"box-sizing: border-box; position: relative; =
font-size: 14px; line-height: 20px; white-space: nowrap; vertical-align: =
middle; cursor: pointer; -webkit-user-select: none; border: 0px; =
border-radius: 6px; appearance: none; box-shadow: none; transition: =
color 80ms cubic-bezier(0.33, 1, 0.68, 1), background-color, box-shadow, =
border-color; width: var(--control-small-size, 28px); height: =
var(--control-small-size, 28px); display: flex !important; padding: 0px =
!important; justify-content: center !important; align-items: center =
!important; margin: var(--base-size-8, 8px) !important;"><svg =
aria-hidden=3D"true" height=3D"16" viewBox=3D"0 0 16 16" version=3D"1.1" =
width=3D"16" data-view-component=3D"true" class=3D"octicon octicon-copy =
js-clipboard-copy-icon"></svg></clipboard-copy></div></div><p dir=3D"auto"=
 style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
margin-bottom: var(--base-size-16); caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI =
Emoji&quot;;">additional notes: made for macos silicon devices dont =
forcefully terminate a vm or you might have trouble booting it next =
time</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; margin-bottom: var(--base-size-16); =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;;">chmod_all_src.sh: this file reiterates over =
all files in the src/ directory and chmods them</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">todo: add =
backup/archive options</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">Copy of a script from vmrun:</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><br></p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">#!/bin/bash</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">DISTRO=3Dfreebsd14-aarch64</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">VMPATH=3D/Volumes/M2/virt</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">VMPREFIX=3D$VMPATH/$DISTRO</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">INSTALL_ISO_PATH=3D$VMPREFIX/iso</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">INSTALL_ISO=3D$INSTALL_ISO_PATH/$DISTRO.iso</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">INSTALL_ISO_TEMP=3D$INSTALL_ISO.temp</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">BOOTDISK=3D$VMPREFIX/$DISTRO.hd0.img</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">VMSPACE=3D200G</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">LOCALPREFIX=3D~/.qlocal</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">QEMU_BINARY=3D$LOCALPREFIX/bin/qemu-system-aarch64</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">QEMU_SOURCES=3D"https://download.qemu.org/qemu-10.0.0.tar.xz"=
</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">QEMU_SMP=3D8</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">QEMU_MEM=3D1G</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">NETWORKDEV=3Den0</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px =
!important;">QEMU_BIOS=3D"edk2-aarch64-code.fd"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">#QEMU_BIOS=3D"QEMU,cgthree.bin"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">#FASTHDDEV=3D"-device virtio-blk-pci,drive=3Dhd0,id=3Dhd0pci =
-drive file=3D$BOOTDISK,if=3Dnone,id=3Dhd0"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">#FASTHDDEV=3D"-device virtio-blk-pci,drive=3Dhd0,id=3Dhd0pci =
-drive if=3Dvirtio,file=3D$BOOTDISK,format=3Dqcow2,drive=3Dhd0"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">#FASTHDDEV=3D"-drive if=3Dnone,file=3D$BOOTDISK,id=3Dhd0 =
-device virtio-blk-device,drive=3Dhd0"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">FASTHDDEV=3D"-hda $BOOTDISK"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">SND=3D"-device=
 intel-hda"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">NETDRIVER=3D"e1000"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">QEMU_ACCEL=3D"hvf"</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;">QEMU_VNC=3D"-vnc =
127.0.0.1:0"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">QEMU_CMD=3D"$QEMU_BINARY -smp $QEMU_SMP =
-device $NETDRIVER,netdev=3Deth0 -netdev =
vmnet-bridged,ifname=3Deth0,id=3Deth0,ifname=3D$NETWORKDEV -M =
virt,highmem=3Doff -cpu host -accel $QEMU_ACCEL -bios $QEMU_BIOS -m =
$QEMU_MEM -nographic $FASTHDDEV $SND $QEMU_VNC -boot c"</p><p dir=3D"auto"=
 style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">TERM_OPEN=3D"osascript -e 'tell app "Terminal" to do script =
"$QEMU_CMD"'"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">URL=3D"https://download.freebsd.org/releases/arm64/aarch64/IS=
O-IMAGES/14.2/FreeBSD-14.2-RELEASE-arm64-aarch64-dvd1.iso"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">JOBS=3D80</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">function Vars(){</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; &nbsp; echo =
"DISTRO $DISTRO"</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "VMPREFIX =
$VMPREFIX"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "INSTALL_ISO =
$INSTALL_ISO"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "BOOTDISK =
$BOOTDISK"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "VMSPACE =
$VMSPACE"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "------------"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; echo "QEMU_SOURCE $QEMU_SOURCES"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; echo "QEMU_BINARY $QEMU_BINARY"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; echo "QEMU_SMP $QEMU_SMP"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; echo "QEMU_MEM $QEMU_MEM"</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; &nbsp; echo "URL =
$URL"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "JOBS (COMPILE THREAD =
COUNT FOR COMPILING QEMU) $JOBS"</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;">}</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">function intro(){</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;">echo ""</p><p dir=3D"auto"=
 style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">echo =
""</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">echo ""</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">echo "!-- using =
qemu-system-aarch64"</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">echo "!-- the DISTRO variable is a =
prefix for all disk and installer isos, the value of DISTRO now is =
$DISTRO, meaning the hard drive image will be $BOOTDISK and the disk =
image in question will be located at $INSTALL_ISO"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">echo "!-- be =
sure to modify the INSTALL_ISO and BOOTDISK variables in this =
script"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">echo "!-- the variable for INSTALL_ISO =
is $URL"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">echo "!-- the variable &nbsp;for =
BOOTDISK is $BOOTDISK"</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">echo "!-- the prefix set for VMPREFIX is =
$VMPREFIX"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">echo "!-- the variable for VMSPACE is =
$VMSPACE"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">echo "!-- be sure to run as root!"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">echo "!-- this program should be able to download a =
distributions iso, format a drive on a local device, install, and be =
able to run a vm without much hassle"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">echo =
""</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">echo ""</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">echo ""</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">}</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><br></p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">intro</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><br></p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">function help(){</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; echo ""</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo ""</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; echo ""</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "--- vmrun 0.1 =
beta"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "--- $0 download =3D =
download image specified in this script"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; echo "--- $0 format =3D format an image for use with qemu"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; echo "--- $0 install =3D install using iso =
specified in script"</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "--- $0 copybash =3D =
copies $0 to $VMPREFIX"</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "--- $0 dirs =3D =
create all required directories"</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; &nbsp; echo "--- =
$0 auto =3D automatically download an iso, format a 200G virtual drive, =
and, install the operating system (be sure to run this as root)"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; echo "--- $0 kill =3D kills all qemu =
processes"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "--- $0 delIMAGES =3D =
deletes installation iso and disk images"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; echo "--- $0 qemu =3D bootstraps qemu 10.0.0 in =
$LOCALPREFIX"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "--- $0 run =3D runs =
the virtual machine and outputs its contents to the terminal"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; echo "--- $0 boot =3D same thing as $0 =
run"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "--- $0 vars =3D show =
almost all enviormental variables used in script"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; echo "--- $0 clean =3D deletes all files created by $0"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; echo "--- $0 deltemp =3D deletes temporary =
iso file"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "-------"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; echo "typical usage is '$0 qemu' then '$0 =
auto', then '$0 run', but you can also do '$0 qemu' to get qemu10, '$0 =
download' to download $URL, '$0 format' to create a disk image at =
$BOOTDISK, '$0 install' to install the os and then '$0 boot'"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; echo "a copy of this script will be copied to =
the vm directory, so you can cd $VMPREFIX and execute $0 boot"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; echo "-------"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; echo ""</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo ""</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; echo ""</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">}</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">help</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><br></p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">function create_local(){</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; mkdir -p $INSTALL_ISO_PATH</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; mkdir $VMPREFIX</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; mkdir $LOCALPREFIX</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; mkdir $LOCALPREFIX/src</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">}</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><br></p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">function fetchqemu(){</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; echo "creating local dirs"</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; &nbsp; =
create_local</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "fetching git sources =
for qemu"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; mkdir =
$LOCALPREFIX/src</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; curl $QEMU_SOURCES -o =
$LOCALPREFIX/src/dl.qemu.tar.xz</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; &nbsp; cd =
$LOCALPREFIX/src</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; tar xfv =
$LOCALPREFIX/src/dl.qemu.tar.xz</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; &nbsp; cd =
qemu-10.0.0</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; ./configure =
--prefix=3D$LOCALPREFIX</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; make -j$JOBS</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; make install</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">}</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><br></p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">function =
downloadvm(){</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; if [ -f $INSTALL_ISO ]; =
then</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>echo "existing iso found, =
hopefully its not corrupt!"</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>else</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;"><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>echo =
"!--- downloading iso from $URL and saving it to =
$INSTALL_ISO_TEMP"</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>curl $URL -o $INSTALL_ISO_TEMP =
&amp;&amp; COMPLETE=3D1</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if [ $COMPLETE =3D 1 ]; =
then</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span> &nbsp; &nbsp;echo "complete =
install detected, copying $INSTALL_ISO_TEMP to $INSTALL_ISO"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span> &nbsp; &nbsp;cp -v $INSTALL_ISO_TEMP $INSTALL_ISO</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span> &nbsp; &nbsp;echo "deleting temp file"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;"><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> &nbsp; =
&nbsp;delisotemp</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>fi</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;"><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span></p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; fi</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; echo "if your downloaded iso doesnt work as intended, try running =
$0 deltemp!"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">}</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;">function =
delisotemp(){</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "deleting =
$INSTALL_ISO_TEMP"</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; rm -rf =
$INSTALL_ISO_TEMP</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "done"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; }</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp;&nbsp;</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">function delimages(){</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; echo "REMOVING HARD DRIVE IMAGES AND INSTALLATION IMAGE!"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; rm -rf $BOOTDISK</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; rm -rf $INSTALL_ISO</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "done"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">}</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">function =
clean(){</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; delimages</p><p dir=3D"auto"=
 style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; echo "deleting $VMPREFIX"</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; &nbsp; rm -rf =
$VMPREFIX</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "done"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; }</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">function formatvm(){</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; &nbsp; echo =
"creating $BOOTDISK"</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; qemu-img create -f qcow2 =
$BOOTDISK $VMSPACE</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">}</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">function =
installvm() {</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">exec sudo $QEMU_CMD -cdrom =
$INSTALL_ISO</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">copybash</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">}</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><br></p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">function runvm() {</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; exec sudo $QEMU_CMD</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">}</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><br></p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">function vmlistpids(){</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; ps -ax | grep qemu-system-aarch64 | &nbsp;awk {'print NR " pid: " =
$1 " program: " $4'}</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "if you want to kill =
a specific process and gain access back to your disk image, use 'kill =
-9'"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">}</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">function =
killall_vms(){</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "killing all qemu =
aarch64 proccesess"</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; sudo killall =
qemu-system-aarch64</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">}</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">function =
copybash(){</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "copying bash script =
to $VMPREFIX"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; cd .</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; cp $0 $VMPREFIX</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "done"</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">}</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">function =
auto(){</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "creating local =
directories"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; create_local</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; echo "downloading iso"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; downloadvm</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "formatting qemu =
img"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; formatvm</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; echo "copying script to $VMPREFIX"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; copybash</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo "installing vm. good =
luck!"</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; installvm</p><p dir=3D"auto"=
 style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; copybash</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">}</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">if [[ "$@" =
=3D=3D "vars" ]]; then</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; Vars</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">fi</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><br></p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">if [[ "$@" =3D=3D "clean" ]]; then</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; clean</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;">fi</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><br></p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">if [[ "$@" =3D=3D "boot" ]]; then</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; runvm</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;">fi</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">if [[ "$@" =3D=3D "run" ]]; then</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; runvm</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">fi</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">if [[ "$@" =
=3D=3D "deltemp" ]]; then</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; delisotemp</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">fi</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">if [[ "$@" =3D=3D "install" ]]; then</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; installvm</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">fi</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">if [[ "$@" =
=3D=3D "kill" ]]; then</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; killall_vms</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">fi</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">if [[ "$@" =
=3D=3D "format" ]]; then</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; formatvm</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">fi</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><br></p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">if [[ "$@" =3D=3D "download" ]]; =
then</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; echo $URL</p><p dir=3D"auto"=
 style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; echo $BOOT_DISK</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; downloadvm</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">fi</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">if [[ "$@" =
=3D=3D "copybash" ]]; then</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; copybash</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">fi</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><br></p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">if [[ "$@" =
=3D=3D "auto" ]]; then</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; auto</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">fi</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><br></p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">if [[ "$@" =3D=3D "" ]]; then</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; exit</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;">fi</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">if [[ "$@" =3D=3D "help" ]]; then</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; help</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">fi</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">if [[ "$@" =
=3D=3D "pids" ]]; then</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; vmlistpids</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">fi</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">if [[ $@ =3D =
"qemu" ]]; then</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">&nbsp; &nbsp; fetchqemu</p><p dir=3D"auto"=
 style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">fi</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><br></p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">if [[ $@ =3D "delIMAGES" ]]; then</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">&nbsp; &nbsp; delimages</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">fi</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><br></p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">if [[ $@ =3D "dir" ]]; then</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;"><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>create_local</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">fi</p><p dir=3D"auto" style=3D"font-size: =
16px; box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, =
40); color: rgb(31, 35, 40); font-family: -apple-system, =
BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, =
Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;; margin-bottom: 0px =
!important;">=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">And the =
chmod_all.sh script</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94</p><p =
dir=3D"auto" style=3D"font-size: 16px; box-sizing: border-box; =
margin-top: 0px; caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); =
font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, =
&quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color =
Emoji&quot;, &quot;Segoe UI Emoji&quot;; margin-bottom: 0px =
!important;">#!/bin/bash</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;"><br></p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">cmd=3D`ls =
src/`</p><p dir=3D"auto" style=3D"font-size: 16px; box-sizing: =
border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); color: =
rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">for x in $cmd; do</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; echo "flagging $x as executable"</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">&nbsp; =
&nbsp; chmod +x src/$x</p><p dir=3D"auto" style=3D"font-size: 16px; =
box-sizing: border-box; margin-top: 0px; caret-color: rgb(31, 35, 40); =
color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, =
&quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, =
sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
margin-bottom: 0px !important;">done</p><p dir=3D"auto" =
style=3D"font-size: 16px; box-sizing: border-box; margin-top: 0px; =
caret-color: rgb(31, 35, 40); color: rgb(31, 35, 40); font-family: =
-apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto =
Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, =
&quot;Segoe UI Emoji&quot;; margin-bottom: 0px !important;">echo =
"done"</p></div><div><br><div>
<div>jon</div><div>unidef.net admin</div><div>110110.net admin</div>

</div>
<br></div></body></html>=

--Apple-Mail=_FA8FD7AA-7DCB-42B2-8569-3640F58C26BF--

