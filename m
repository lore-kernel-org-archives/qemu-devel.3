Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11795CD3420
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 09:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slQ1l-0004XD-5q; Tue, 03 Sep 2024 05:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1slQ1h-0004W9-So
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 05:40:42 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1slQ1e-0005ew-7F
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 05:40:41 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 0291743FBE
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2024 09:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1725356436;
 bh=XYCCZX+nYnx+hemcPaPn3dNx9VlQjFB8Hl5Pzf8mjbU=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=O1sXwkkwVID2NQ20ZPoauuo6TO6CVf0u3SkYYKJvCHilUcZ8jOeS2qmHw/1ulZAPd
 DYp2j1lo9FmZQX6m6zkc0oJ/hItHobQWZ8xcq/NoDhuM3SZM9aolLgRBoTlrexVSju
 X4UBv9FwTkEU6FthrgxIZjDTWBmu2XyinJqOzpvwCj8zSQqbaQOBBnCivn/+XhE4Hl
 Tn99FVd2ixHOUqG4VkJid1h6vZq50iOSAvKH2MwA72lr1NwcRq3+2LM3c3i1yHxc3p
 ipvH/HT5IqAf3rG/v6ZB+CowF1fIlRqxSjg/L8XgaRdK0WTsKypY+W4x3ScT3EnRrp
 EvrzRt7DTMo2w==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id DB5AF7E386
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2024 09:40:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Sep 2024 09:26:39 -0000
From: Mehmet Basaran <2078790@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=linux-lowlatency-hwe-6.8;
 component=main; status=New; importance=Undecided;
 assignee=mehmet.basaran@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mehmetbasaran
X-Launchpad-Bug-Reporter: Mehmet Basaran (mehmetbasaran)
X-Launchpad-Bug-Modifier: Mehmet Basaran (mehmetbasaran)
References: <172535521411.2600491.6207708752026464339.malonedeb@juju-98d295-prod-launchpad-3>
Message-Id: <172535559937.1175752.2097583596890286125.malone@juju-98d295-prod-launchpad-2>
Subject: [Bug 2078790] Re: jammy qemu x86 int3: 0000 [#1] SMP NOPTI 
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1b1ed1ad2dbfc71ee62b5c5491c975135a771bf0";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 36162bd21b2a0ff757e65c002837d1ae887d77d0
Received-SPF: pass client-ip=185.125.188.250;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-0.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 2078790 <2078790@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

jammy:linux-lowlatency-hwe-6.8 6.8.0-44.44.1~22.04.1 qemu-x86 QEMU
Standard PC (i440FX + PIIX, 1996) -> ADT:systemd:upstream-1


2564s --x-- Running TEST-13-NSPAWN-SMOKE --x--
2564s make: Entering directory '/tmp/autopkgtest.Nji8tC/build.UBO/src/test/=
TEST-13-NSPAWN-SMOKE'
2564s Specify build directory with $BUILD_DIR
2565s TEST-13-NSPAWN-SMOKE SETUP: systemd-nspawn smoke test
2565s '/tmp/autopkgtest.Nji8tC/build.UBO/src/test/default.img' -> '/tmp/aut=
opkgtest.Nji8tC/build.UBO/src/test/TEST-13-NSPAWN-SMOKE/../nspawn.img'
2565s Reusing existing cached image /tmp/autopkgtest.Nji8tC/build.UBO/src/t=
est/TEST-13-NSPAWN-SMOKE/../nspawn.img =E2=86=92 /tmp/autopkgtest.Nji8tC/bu=
ild.UBO/src/test/nspawn.img
2565s '/tmp/autopkgtest.Nji8tC/build.UBO/src/test/nspawn.img' -> '/var/tmp/=
systemd-test.RZ0EoL/nspawn.img'
2566s I: Masking supporting services
2566s '/var/tmp/systemd-test.RZ0EoL/root/etc/systemd/system/systemd-hwdb-up=
date.service' -> '/dev/null'
2566s '/var/tmp/systemd-test.RZ0EoL/root/etc/systemd/system/systemd-journal=
-catalog-update.service' -> '/dev/null'
2566s '/var/tmp/systemd-test.RZ0EoL/root/etc/systemd/system/systemd-network=
d.service' -> '/dev/null'
2566s '/var/tmp/systemd-test.RZ0EoL/root/etc/systemd/system/systemd-network=
d.socket' -> '/dev/null'
2566s '/var/tmp/systemd-test.RZ0EoL/root/etc/systemd/system/systemd-resolve=
d.service' -> '/dev/null'
2566s Specify build directory with $BUILD_DIR
2566s TEST-13-NSPAWN-SMOKE RUN: systemd-nspawn smoke test
2566s + /bin/qemu-system-x86_64 -smp 4 -net none -m 512M -nographic -vga no=
ne -kernel /boot/vmlinuz-6.8.0-44-lowlatency -drive format=3Draw,cache=3Dun=
safe,file=3D/var/tmp/systemd-test.RZ0EoL/nspawn.img -initrd /boot/initrd.im=
g-6.8.0-44-lowlatency -append 'root=3D/dev/sda1 rw raid=3Dnoautodetect rd.l=
uks=3D0 loglevel=3D2 init=3D/lib/systemd/systemd console=3DttyS0 selinux=3D=
0 SYSTEMD_UNIT_PATH=3D/usr/lib/systemd/tests/testdata/testsuite-13.units:/u=
sr/lib/systemd/tests/testdata/units: systemd.unit=3Dtestsuite.target system=
d.wants=3Dtestsuite-13.service systemd.wants=3Dend.service'
2566s =1Bc=1B[?7l=1B[2J=1B[0mSeaBIOS (version 1.15.0-1)
2576s Booting from ROM..=1Bc=1B[?7l=1B[2JLoading, please wait...
2577s Starting version 249.11-0ubuntu3.12
2579s Begin: Loading essential drivers ... done.
2579s Begin: Running /scripts/init-premount ... done.
2579s Begin: Mounting root file system ... Begin: Running /scripts/local-to=
p ... done.
2580s Begin: Running /scripts/local-premount ... Scanning for Btrfs filesys=
tems
2580s done.
2580s Begin: Will now check root file system ... fsck from util-linux 2.37.2
2580s [/usr/sbin/fsck.ext4 (1) -- /dev/sda1] fsck.ext4 -a -C0 /dev/sda1
2580s systemd: clean, 2426/115200 files, 47727/115200 blocks
2580s done.
2580s done.
2581s Begin: Running /scripts/local-bottom ... done.
2581s Begin: Running /scripts/init-bottom ... done.
2582s
2582s Welcome to =1B[1mUbuntu 22.04.4 LTS=1B[0m!
2582s
2583s [=1B[0;32m  OK  =1B[0m] Created slice =1B[0;1;39mSlice /system/modpro=
be=1B[0m.
2583s [=1B[0;32m  OK  =1B[0m] Created slice =1B[0;1;39mSlice /system/serial=
-getty=1B[0m.
2583s [=1B[0;32m  OK  =1B[0m] Created slice =1B[0;1;39mUser and Session Sli=
ce=1B[0m.
2583s [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mDispatch Password =E2=80=
=A6ts to Console Directory Watch=1B[0m.
2583s [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mForward Password R=E2=80=
=A6uests to Wall Directory Watch=1B[0m.
2583s [=1B[0;1;38;5;185mUNSUPP=1B[0m] Starting of =1B[0;1;39mArbitrary Exec=
=E2=80=A6m Automount Point=1B[0m unsupported.
2583s [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mLocal Encrypted Vol=
umes=1B[0m.
2583s [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mPath Units=1B[0m.
2583s [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mSlice Units=1B[0m.
2583s [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mSwaps=1B[0m.
2583s [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mLocal Verity Protec=
ted Volumes=1B[0m.
2583s [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mProcess Core Dump Soc=
ket=1B[0m.
2583s [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39minitctl Compatibility=
 Named Pipe=1B[0m.
2583s [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mJournal Audit Socket=
=1B[0m.
2583s [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mJournal Socket (/dev/=
log)=1B[0m.
2583s [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mJournal Socket=1B[0m.
2583s [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mudev Control Socket=
=1B[0m.
2583s [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mudev Kernel Socket=1B=
[0m.
2583s [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mSockets=1B[0m.
2583s          Mounting =1B[0;1;39mHuge Pages File System=1B[0m...
2583s          Mounting =1B[0;1;39mPOSIX Message Queue File System=1B[0m...
2583s          Mounting =1B[0;1;39mKernel Debug File System=1B[0m...
2583s          Mounting =1B[0;1;39mKernel Trace File System=1B[0m...
2583s          Starting =1B[0;1;39mJournal Service=1B[0m...
2583s          Starting =1B[0;1;39mLoad Kernel Module configfs=1B[0m...
2583s          Starting =1B[0;1;39mLoad Kernel Module drm=1B[0m...
2583s          Starting =1B[0;1;39mLoad Kernel Module fuse=1B[0m...
2583s          Starting =1B[0;1;39mLoad Kernel Modules=1B[0m...
2584s          Starting =1B[0;1;39mRemount Root and Kernel File Systems=1B[=
0m...
2584s          Starting =1B[0;1;39mColdplug All udev Devices=1B[0m...
2584s [=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mHuge Pages File System=1B[=
0m.
2584s [=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mPOSIX Message Queue File S=
ystem=1B[0m.
2584s [=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mKernel Debug File System=
=1B[0m.
2584s [=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mKernel Trace File System=
=1B[0m.
2584s [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mLoad Kernel Module config=
fs=1B[0m.
2584s [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mLoad Kernel Module drm=1B=
[0m.
2584s [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mLoad Kernel Module fuse=
=1B[0m.
2584s [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mLoad Kernel Modules=1B[0m.
2584s [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mRemount Root and Kernel F=
ile Systems=1B[0m.
2584s          Mounting =1B[0;1;39mFUSE Control File System=1B[0m...
2584s          Mounting =1B[0;1;39mKernel Configuration File System=1B[0m...
2584s          Starting =1B[0;1;39mLoad/Save Random Seed=1B[0m...
2584s          Starting =1B[0;1;39mApply Kernel Variables=1B[0m...
2584s          Starting =1B[0;1;39mCreate System Users=1B[0m...
2584s [=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mFUSE Control File System=
=1B[0m.
2584s [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mJournal Service=1B[0m.
2584s [=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mKernel Configuration File =
System=1B[0m.
2584s          Starting =1B[0;1;39mFlush Journal to Persistent Storage=1B[0=
m...
2584s [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mLoad/Save Random Seed=1B[=
0m.
2584s [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mApply Kernel Variables=1B=
[0m.
2584s [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mCreate System Users=1B[0m.
2584s          Starting =1B[0;1;39mCreate Static Device Nodes in /dev=1B[0m=
...
2584s [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mFlush Journal to Persiste=
nt Storage=1B[0m.
2584s [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mCreate Static Device Node=
s in /dev=1B[0m.
2584s [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mPreparation for Loc=
al File Systems=1B[0m.
2584s [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mLocal File Systems=
=1B[0m.
2584s          Starting =1B[0;1;39mCreate Volatile Files and Directories=1B=
[0m...
2584s          Starting =1B[0;1;39mRule-based Manage=E2=80=A6for Device Eve=
nts and Files=1B[0m...
2585s [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mColdplug All udev Devices=
=1B[0m.
2585s [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mCreate Volatile Files and=
 Directories=1B[0m.
2585s          Starting =1B[0;1;39mRecord System Boot/Shutdown in UTMP=1B[0=
m...
2585s [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mRecord System Boot/Shutdo=
wn in UTMP=1B[0m.
2585s [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mRule-based Manager for Dev=
ice Events and Files=1B[0m.
2585s [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mSystem Initializati=
on=1B[0m.
2585s [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mDaily Cleanup of Temporary=
 Directories=1B[0m.
2585s [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mBasic System=1B[0m.
2585s [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mTimers=1B[0m.
2585s [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mD-Bus System Message =
Bus Socket=1B[0m.
2585s          Starting =1B[0;1;39m/etc/rc.local Compatibility=1B[0m...
2585s          Starting =1B[0;1;39mUser Login Management=1B[0m...
2585s [   16.813561] rc.local[255]: /etc/rc.local: 2: iptables: not found
2585s          Starting =1B[0;1;39mPermit User Sessions=1B[0m...
2585s          Starting =1B[0;1;39mTEST-13-NSPAWN-SMOKE=1B[0m...
2585s [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39m/etc/rc.local Compatibilit=
y=1B[0m.
2585s [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mPermit User Sessions=1B[0=
m.
2586s [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mD-Bus System Message Bus=
=1B[0m.
2586s [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mUser Login Management=1B[0=
m.
2588s [=1B[0;32m  OK  =1B[0m] Found device =1B[0;1;39m/dev/ttyS0=1B[0m.
2588s [=1B[0;32m  OK  =1B[0m] Created slice =1B[0;1;39mVirtual Machine and =
Container Slice=1B[0m.
2588s [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mContainer testsuite-13.bin=
d-tmp-path=1B[0m.
2588s [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mLoad/Save RF =E2=80=
=A6itch Status /dev/rfkill Watch=1B[0m.
2588s [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mSerial Getty on ttyS0=1B[0=
m.
2588s [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mLogin Prompts=1B[0m.
2588s [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mMulti-User System=
=1B[0m.
2588s          Starting =1B[0;1;39mRecord Runlevel Change in UTMP=1B[0m...
2588s [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mRecord Runlevel Change in=
 UTMP=1B[0m.
2589s          Starting =1B[0;1;39mVirtual Machine a=E2=80=A6tainer Registr=
ation Service=1B[0m...
2589s [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mVirtual Machine an=E2=80=
=A6ontainer Registration Service=1B[0m.
2590s [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mContainer testsuite-13.nor=
bind-path=1B[0m.
2591s [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mContainer testsuite-13.nc-=
container=1B[0m.
2594s

2607s H login: [   39.204860] int3: 0000 [#1] PREEMPT SMP NOPTI
2607s [   39.204860] CPU: 2 PID: 538 Comm: ip Not tainted 6.8.0-44-lowlaten=
cy #44.1~22.04.1-Ubuntu
2607s [   39.204860] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS 1.15.0-1 04/01/2014
2607s [   39.204860] RIP: 0010:get_any_partial+0x5f/0x1d0
2607s [   39.204860] Code: 2d 01 00 00 83 e6 0f b8 22 01 32 01 49 89 fd 8d =
0c 36 d3 f8 89 c1 65 48 8b 04 25 40 43 03 00 48 89 45 c8 83 e1 03 41 89 ce =
0f <1f> 44 00 00 c7 45 d4 00 00 00 00 41 8b 1c 24 e8 9d af 02 00 c1 eb
2607s [   39.204860] RSP: 0018:ffffad70c0a7b878 EFLAGS: 00000202
2607s [   39.204860] RAX: ffff904994a2cf00 RBX: ffffad70c0a7b8e0 RCX: 00000=
00000000002
2607s [   39.204860] RDX: 0000000000000017 RSI: 0000000000000000 RDI: ffff9=
04981054600
2607s [   39.204860] RBP: ffffad70c0a7b8b0 R08: 00000000ffffffff R09: 00000=
00000000246
2607s [   39.204860] R10: 0000000000000246 R11: 0000000000000000 R12: ffffa=
d70c0a7b8e0
2607s [   39.204860] R13: ffff904981054600 R14: 0000000000000002 R15: ffff9=
04981054600
2607s [   39.204860] FS:  00007e585fc45b80(0000) GS:ffff90499b100000(0000) =
knlGS:0000000000000000
2607s [   39.204860] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2607s [   39.204860] CR2: 00007ffe6da69e88 CR3: 0000000003d84000 CR4: 00000=
000000006f0
2607s [   39.204860] Call Trace:
2607s [   39.204860]  <TASK>
2607s [   39.204860]  ? show_regs+0x6d/0x80
2607s [   39.204860]  ? die+0x37/0xa0
2607s [   39.204860]  ? exc_int3+0xe2/0xf0
2607s [   39.204860]  ? asm_exc_int3+0x3a/0x40
2607s [   39.204860]  ? get_any_partial+0x5f/0x1d0
2607s [   39.204860]  ? get_any_partial+0x5f/0x1d0
2607s [   39.204860]  ? namecmp+0x26/0x40
2607s [   39.204860]  ___slab_alloc+0x735/0x8d0
2607s [   39.204860]  ? __mod_memcg_lruvec_state+0xa9/0x1b0
2607s [   39.204860]  ? __register_sysctl_table+0x3f/0x180
2607s [   39.204860]  ? mod_memcg_lruvec_state+0x2b/0x60
2607s [   39.204860]  ? __register_sysctl_table+0x3f/0x180
2607s [   39.204860]  __kmalloc+0x3e7/0x480
2607s [   39.204860]  ? string+0x5e/0x110
2607s [   39.204860]  __register_sysctl_table+0x3f/0x180
2607s [   39.204860]  ? __register_sysctl_table+0x3f/0x180
2607s [   39.204860]  register_net_sysctl_sz+0x62/0x80
2607s [   39.204860]  __devinet_sysctl_register+0x109/0x220
2607s [   39.204860]  devinet_sysctl_register+0x9c/0xd0
2607s [   39.204860]  inetdev_init+0xee/0x200
2607s [   39.204860]  inetdev_event+0x32d/0x3f0
2607s [   39.204860]  notifier_call_chain+0x61/0xe0
2607s [   39.204860]  raw_notifier_call_chain+0x16/0x30
2607s [   39.204860]  call_netdevice_notifiers_info+0x52/0xa0
2607s [   39.204860]  register_netdevice+0x716/0x8d0
2607s [   39.204860]  register_netdev+0x1e/0x40
2607s [   39.204860]  loopback_net_init+0x50/0xb0
2607s [   39.204860]  ops_init+0x3c/0xe0
2607s [   39.204860]  setup_net+0x12e/0x2a0
2607s [   39.204860]  copy_net_ns+0x13d/0x2b0
2607s [   39.204860]  create_new_namespaces+0x11c/0x300
2607s [   39.204860]  unshare_nsproxy_namespaces+0x5a/0xc0
2607s [   39.204860]  ksys_unshare+0x1fc/0x3e0
2607s [   39.204860]  __x64_sys_unshare+0x12/0x20
2607s [   39.204860]  x64_sys_call+0xd8a/0x24b0
2607s [   39.204860]  do_syscall_64+0x81/0x170
2607s [   39.204860]  ? syscall_exit_to_user_mode+0x89/0x260
2607s [   39.204860]  ? do_syscall_64+0x8d/0x170
2607s [   39.204860]  ? do_syscall_64+0x8d/0x170
2607s [   39.204860]  ? irqentry_exit+0x43/0x50
2607s [   39.204860]  entry_SYSCALL_64_after_hwframe+0x78/0x80
2607s [   39.204860] RIP: 0033:0x7e585fb26e1b
2607s [   39.204860] Code: 73 01 c3 48 8b 0d 15 30 0f 00 f7 d8 64 89 01 48 =
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 10 01 00 00 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 2f 0f 00 f7 d8 64 89 01 48
2607s [   39.204860] RSP: 002b:00007ffe6da6a668 EFLAGS: 00000217 ORIG_RAX: =
0000000000000110
2607s [   39.204860] RAX: ffffffffffffffda RBX: 0000628519178fcb RCX: 00007=
e585fb26e1b
2607s [   39.204860] RDX: 0000000000000000 RSI: 00006285191740bf RDI: 00000=
00040000000
2607s [   39.204860] RBP: 0000000000000005 R08: 0000000000000000 R09: 00007=
ffe6da6a4f0
2607s [   39.204860] R10: 0000000000000000 R11: 0000000000000217 R12: 00006=
28519173bea
2607s [   39.204860] R13: 0000000000000000 R14: 00007ffe6da6c880 R15: 00006=
28519175efe
2607s [   39.204860]  </TASK>
2607s [   39.204860] Modules linked in: btrfs blake2b_generic xor raid6_pq =
libcrc32c psmouse i2c_piix4 pata_acpi floppy
2607s [   39.204860] ---[ end trace 0000000000000000 ]---
2607s [   39.204860] RIP: 0010:get_any_partial+0x5f/0x1d0
2607s [   39.204860] Code: 2d 01 00 00 83 e6 0f b8 22 01 32 01 49 89 fd 8d =
0c 36 d3 f8 89 c1 65 48 8b 04 25 40 43 03 00 48 89 45 c8 83 e1 03 41 89 ce =
0f <1f> 44 00 00 c7 45 d4 00 00 00 00 41 8b 1c 24 e8 9d af 02 00 c1 eb
2607s [   39.204860] RSP: 0018:ffffad70c0a7b878 EFLAGS: 00000202
2607s [   39.204860] RAX: ffff904994a2cf00 RBX: ffffad70c0a7b8e0 RCX: 00000=
00000000002
2607s [   39.204860] RDX: 0000000000000017 RSI: 0000000000000000 RDI: ffff9=
04981054600
2607s [   39.204860] RBP: ffffad70c0a7b8b0 R08: 00000000ffffffff R09: 00000=
00000000246
2607s [   39.204860] R10: 0000000000000246 R11: 0000000000000000 R12: ffffa=
d70c0a7b8e0
2607s [   39.204860] R13: ffff904981054600 R14: 0000000000000002 R15: ffff9=
04981054600
2607s [   39.204860] FS:  00007e585fc45b80(0000) GS:ffff90499b100000(0000) =
knlGS:0000000000000000
2607s [   39.204860] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2607s [   39.204860] CR2: 00007ffe6da69e88 CR3: 0000000003d84000 CR4: 00000=
000000006f0
2607s [   39.204860] Kernel panic - not syncing: Fatal exception in interru=
pt
2607s [   39.204860] Kernel Offset: 0x11c00000 from 0xffffffff81000000 (rel=
ocation range: 0xffffffff80000000-0xffffffffbfffffff)
2607s [   39.204860] ---[ end Kernel panic - not syncing: Fatal exception i=
n interrupt ]---
22327s autopkgtest [14:32:03]: ERROR: timed out on command "su -s /bin/bash=
 root -c set -e; exec /tmp/autopkgtest.Nji8tC/wrapper.sh --artifacts=3D/tmp=
/autopkgtest.Nji8tC/upstream-1-artifacts --chdir=3D/tmp/autopkgtest.Nji8tC/=
build.UBO/src --env=3DAUTOPKGTEST_TESTBED_ARCH=3Damd64 --env=3DAUTOPKGTEST_=
TEST_ARCH=3Damd64 --env=3DDEB_BUILD_OPTIONS=3Dparallel=3D4 --env=3DDEBIAN_F=
RONTEND=3Dnoninteractive --env=3DLANG=3DC.UTF-8 --unset-env=3DLANGUAGE --un=
set-env=3DLC_ADDRESS --unset-env=3DLC_ALL --unset-env=3DLC_COLLATE --unset-=
env=3DLC_CTYPE --unset-env=3DLC_IDENTIFICATION --unset-env=3DLC_MEASUREMENT=
 --unset-env=3DLC_MESSAGES --unset-env=3DLC_MONETARY --unset-env=3DLC_NAME =
--unset-env=3DLC_NUMERIC --unset-env=3DLC_PAPER --unset-env=3DLC_TELEPHONE =
--unset-env=3DLC_TIME --script-pid-file=3D/tmp/autopkgtest_script_pid --sou=
rce-profile --stderr=3D/tmp/autopkgtest.Nji8tC/upstream-1-stderr --stdout=
=3D/tmp/autopkgtest.Nji8tC/upstream-1-stdout --tmp=3D/tmp/autopkgtest.Nji8t=
C/autopkgtest_tmp --env=3DAUTOPKGTEST_NORMAL_USER=3Dubuntu --env=3DADT_NORM=
AL_USER=3Dubuntu '--env=3DADT_TEST_TRIGGERS=3Dlinux-meta-lowlatency-hwe-6.8=
/6.8.0-44.44.1~22.04.1 linux-lowlatency-hwe-6.8/6.8.0-44.44.1~22.04.1' --ma=
ke-executable=3D/tmp/autopkgtest.Nji8tC/build.UBO/src/debian/tests/upstream=
-1 -- /tmp/autopkgtest.Nji8tC/build.UBO/src/debian/tests/upstream-1" (kind:=
 test)
22328s autopkgtest [14:32:04]: test upstream-1: -----------------------]
22328s autopkgtest [14:32:04]: test upstream-1:  - - - - - - - - - - result=
s - - - - - - - - - -
22328s upstream-1           FAIL timed out
22330s autopkgtest [14:32:06]: test upstream-2: preparing testbed


** Project changed: ubuntu-kernel-tests =3D> qemu

** Also affects: linux (Ubuntu)
   Importance: Undecided
       Status: New

** Package changed: linux (Ubuntu) =3D> linux-lowlatency-hwe-6.8 (Ubuntu)

** Changed in: linux-lowlatency-hwe-6.8 (Ubuntu)
     Assignee: (unassigned) =3D> Mehmet Basaran (mehmetbasaran)

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2078790

Title:
  jammy qemu x86 int3: 0000 [#1] SMP NOPTI

Status in linux-lowlatency-hwe-6.8 package in Ubuntu:
  New
Status in qemu package in Ubuntu:
  New

Bug description:
  jammy:linux-lowlatency-hwe-6.8 6.8.0-44.44.1~22.04.1 qemu-x86 QEMU
  Standard PC (i440FX + PIIX, 1996)

 =20
  Recently (2024.08.05), I have been seeing this issue with ADT:systemd:ups=
tream-1/2 test in which kernel panics/prints a stack. I have seen this with=
 jammy:linux-lowlatency-hwe-6.8 and jammy:linux-ibm-6.8. Stack trace is dif=
ferent everytime because kernel receives an interrupt, drop what it is doin=
g, and crash when handling the interrupt.

  I think this is an issue with qemu and not kernel. For jammy, we are
  using qemu 6.2 and there are some fixes related to x86 interrupt
  handling in 8.x
  (https://lore.kernel.org/lkml/20230705215008.GD17440@redhat.com/T/). I
  propose we create a launchpad bug and trace the issue. If I am
  correct, we shouldn't see this in noble. And we should occasionally
  see this in 5.15 jammy kernels (and more frequently with lowlantecy
  kernels).

 =20
  Meanwhile see comments below for some stack traces;

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/linux-lowlatency-hwe-6.8/+bug/207=
8790/+subscriptions


