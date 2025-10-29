Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFAFCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2MZ-00066G-4D; Wed, 29 Oct 2025 05:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vE2MV-000666-8O
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:20:59 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vE2MO-0005f4-Ln
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:20:57 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id CD69D3F64F
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 09:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1761729646;
 bh=FC847Y0BuOV8Zcp6F3lCv9d/AHBU5teliCO0M67mwJo=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=wllGCtXXXCNcJJ8JI+adOIytr291mPvvUi1MjZrrc71xdJkCVV7i4QbZzGPaHQ0QS
 /yam/f6xSZpEUPsu/qyE594bElr2HTg+wjehhR7frPhqEOTm1zMM+1xkdR1Q7sR0Mx
 0+LNxWfs9I4Fx3gGW0KYSRy/1MP0Q67gt6Uqv227vLuTmaH53uyTYA2cwo44iv8BMg
 7/651+HBHTImucLINwMUzfk3GYaig5sNYsO0bineJ3oHTfnI963wKbwb6AL4W4pNGP
 2k9eQq5uCQ9BnArXkfPHtXK5przSpiD6p5oY8c6lVGRqqSj2MlHL2ANs4Mp3I70Uy+
 /E4EK1xWO56bQ==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id C11247E704
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 09:20:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Oct 2025 09:12:56 -0000
From: =?utf-8?q?Lukas_M=C3=A4rdian?= <2123828@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Unknown;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=glibc; component=main;
 status=Invalid; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Fix Released; importance=Undecided;
 assignee=valentin.haudiquet@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=noble; sourcepackage=gcc-15;
 component=None; status=Invalid; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=noble; sourcepackage=glibc;
 component=main; status=Invalid; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=noble; sourcepackage=qemu;
 component=main; status=Won't Fix; importance=Undecided;
 assignee=valentin.haudiquet@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=plucky; sourcepackage=gcc-15;
 component=main; status=Invalid; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=plucky; sourcepackage=glibc;
 component=main; status=Invalid; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=plucky; sourcepackage=qemu;
 component=main; status=Won't Fix; importance=Undecided;
 assignee=valentin.haudiquet@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=questing;
 sourcepackage=gcc-15; component=main; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=questing;
 sourcepackage=glibc; component=main; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=questing; sourcepackage=qemu;
 component=main; status=Fix Committed; importance=Undecided;
 assignee=valentin.haudiquet@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=resolute;
 sourcepackage=glibc; component=main; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=resolute; sourcepackage=qemu;
 component=main; status=Fix Released; importance=Undecided;
 assignee=valentin.haudiquet@canonical.com; 
X-Launchpad-Bug-Tags: update-excuse verification-done
 verification-done-questing
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: enr0n hectorcao janitor paelzer schopin slyon
 ubuntu-sru-bot vhaudiquet xypron
X-Launchpad-Bug-Reporter: =?utf-8?q?Lukas_M=C3=A4rdian_=28slyon=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Lukas_M=C3=A4rdian_=28slyon=29?=
References: <175793222278.1250191.6568998309826575823.malonedeb@juju-98d295-prod-launchpad-2>
Message-Id: <176172917679.1725196.14634126926117487144.malone@juju-98d295-prod-launchpad-7>
Subject: [Bug 2123828] Re: [SRU] RISC-V: incorrect emulation of load and store
 on big-endian systems
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 6b5ab297e3338b695599088ec6ca77d4349c0c13
Received-SPF: pass client-ip=185.125.188.250;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-0.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 2123828 <2123828@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Note: The Questing SRU was built against ceph/19.2.3-0ubuntu1 and should
be released together.

I did the verification for Questing on a s390x porterbox, all looking
good!

First of all, the DEP-8 tests for qemu/s390x from questing-proposed are gre=
en again (specifically the "test-qemu-user.sh    FAIL stderr: /bin/busybox:=
 /lib/ld-linux-riscv64-lp64d.so.1: unsupported version 256 of Verdef record=
" issue):
https://autopkgtest.ubuntu.com/results/autopkgtest-questing/questing/s390x/=
q/qemu/20251023_032142_0cef0@/log.gz

Also, the minimal reproducer [Test Plan] works as expected:

```
ubuntu@slyon-qq:~$ sudo apt install -t questing-proposed qemu-user
Upgrading:                     =20
  qemu-user  qemu-user-binfmt

Summary:
  Upgrading: 2, Installing: 0, Removing: 0, Not Upgrading: 15
  Download size: 20.7 MB
  Space needed: 4096 B / 18.5 GB available

Continue? [Y/n]=20
Get:1 http://ports.ubuntu.com/ubuntu-ports questing-proposed/universe s390x=
 qemu-user s390x 1:10.1.0+ds-5ubuntu2.1 [20.7 MB]
Get:2 http://ports.ubuntu.com/ubuntu-ports questing-proposed/universe s390x=
 qemu-user-binfmt s390x 1:10.1.0+ds-5ubuntu2.1 [1676 B]
Fetched 20.7 MB in 0s (53.0 MB/s)         =20
(Reading database ... 71246 files and directories currently installed.)
Preparing to unpack .../qemu-user_1%3a10.1.0+ds-5ubuntu2.1_s390x.deb ...
Unpacking qemu-user (1:10.1.0+ds-5ubuntu2.1) over (1:10.1.0+ds-5ubuntu2) ...
Preparing to unpack .../qemu-user-binfmt_1%3a10.1.0+ds-5ubuntu2.1_s390x.deb=
 ...
Unpacking qemu-user-binfmt (1:10.1.0+ds-5ubuntu2.1) over (1:10.1.0+ds-5ubun=
tu2) ...
Setting up qemu-user (1:10.1.0+ds-5ubuntu2.1) ...
Setting up qemu-user-binfmt (1:10.1.0+ds-5ubuntu2.1) ...
[...]

ubuntu@slyon-qq:~$ dpkg -l | grep libc6
ii  libc6:s390x                       2.42-0ubuntu3                        =
      s390x        GNU C Library: Shared libraries
ii  libc6-dev:s390x                   2.42-0ubuntu3                        =
      s390x        GNU C Library: Development Libraries and Header Files
ubuntu@slyon-qq:~$ dpkg -l | grep qemu-user
ii  qemu-user                         1:10.1.0+ds-5ubuntu2.1               =
      s390x        QEMU user mode emulation (static binaries)
ii  qemu-user-binfmt                  1:10.1.0+ds-5ubuntu2.1               =
      s390x        QEMU user mode binfmt registration for qemu-user
ubuntu@slyon-qq:~$ dpkg --print-architecture
s390x
ubuntu@slyon-qq:~$ sudo dpkg --add-architecture riscv64
ubuntu@slyon-qq:~$ sudo apt update
[...]

ubuntu@slyon-qq:~$ sudo apt install hello:riscv64
Installing:                    =20
  hello:riscv64

Installing dependencies:
  gcc-15-base:riscv64  libc6:riscv64  libgcc-s1:riscv64  libidn2-0:riscv64 =
 libunistring5:riscv64

Suggested packages:
  glibc-doc:riscv64  locales:riscv64  libnss-nis:riscv64  libnss-nisplus:ri=
scv64

Summary:
  Upgrading: 0, Installing: 6, Removing: 0, Not Upgrading: 9
  Download size: 3723 kB
  Space needed: 12.3 MB / 18.3 GB available

Continue? [Y/n]=20
[...]

ubuntu@slyon-qq:~$ /usr/bin/qemu-riscv64 /usr/bin/hello
Hello, world!
```


** Tags removed: verification-needed verification-needed-questing
** Tags added: verification-done verification-done-questing

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2123828

Title:
  [SRU] RISC-V: incorrect emulation of load and store on big-endian
  systems

Status in QEMU:
  Fix Released
Status in glibc package in Ubuntu:
  Invalid
Status in qemu package in Ubuntu:
  Fix Released
Status in gcc-15 source package in Noble:
  Invalid
Status in glibc source package in Noble:
  Invalid
Status in qemu source package in Noble:
  Won't Fix
Status in gcc-15 source package in Plucky:
  Invalid
Status in glibc source package in Plucky:
  Invalid
Status in qemu source package in Plucky:
  Won't Fix
Status in gcc-15 source package in Questing:
  Invalid
Status in glibc source package in Questing:
  Invalid
Status in qemu source package in Questing:
  Fix Committed
Status in glibc source package in Resolute:
  Invalid
Status in qemu source package in Resolute:
  Fix Released

Bug description:
  [ Impact ]

  On s390x architecture, qemu cannot emulate riscv64 well because of an
  endianess error. Original bug report :

  QEMU's DEP-8 test fails on s390x, due to warning output on stderr
  about "unsupported version 256 of Verdef record", which is blocking
  migration of glibc 2.42-0ubuntu3.

  DEP-8 logs:
  """
  323s =3D=3D=3D Checking if /usr/bin/qemu-riscv64 can run executables:
  323s glob with sh: /usr/bin/qemu-riscv64 /bin/busybox ash -c "/usr/bin/qe=
mu-riscv64 /bin/busybox ls -dCFl debian/*[t]*":
  323s /bin/busybox: /lib/ld-linux-riscv64-lp64d.so.1: unsupported version =
256 of Verdef record
  323s /bin/busybox: /lib/riscv64-linux-gnu/libresolv.so.2: unsupported ver=
sion 256 of Verdef record
  323s /bin/busybox: /lib/riscv64-linux-gnu/libc.so.6: unsupported version =
256 of Verdef record
  323s /bin/busybox: /lib/riscv64-linux-gnu/libc.so.6: unsupported version =
256 of Verdef record
  323s /bin/busybox: /lib/riscv64-linux-gnu/libc.so.6: unsupported version =
256 of Verdef record
  323s /bin/busybox: /lib/riscv64-linux-gnu/libc.so.6: unsupported version =
256 of Verdef record
  323s /bin/busybox: /lib/riscv64-linux-gnu/libc.so.6: unsupported version =
256 of Verdef record
  323s /bin/busybox: /lib/ld-linux-riscv64-lp64d.so.1: unsupported version =
256 of Verdef record
  323s
  323s Reading package lists.../bin/busybox: /lib/riscv64-linux-gnu/libc.so=
.6: unsupported version 256 of Verdef record
  323s /bin/busybox: /lib/riscv64-linux-gnu/libc.so.6: unsupported version =
256 of Verdef record
  323s /bin/busybox: /lib/riscv64-linux-gnu/libc.so.6: unsupported version =
256 of Verdef record
  323s /bin/busybox: /lib/ld-linux-riscv64-lp64d.so.1: unsupported version =
256 of Verdef record
  323s /bin/busybox: /lib/ld-linux-riscv64-lp64d.so.1: unsupported version =
256 of Verdef record
  323s /bin/busybox: /lib/ld-linux-riscv64-lp64d.so.1: unsupported version =
256 of Verdef record
  323s Expected output not found
  [...]
  328s autopkgtest [22:14:52]: @@@@@@@@@@@@@@@@@@@@ summary
  328s test-qemu-img.sh     PASS (superficial)
  328s test-qemu-system.sh  PASS (superficial)
  328s test-qemu-user.sh    FAIL stderr: /bin/busybox: /lib/ld-linux-riscv6=
4-lp64d.so.1: unsupported version 256 of Verdef record
  """

  Patched by flagging the faulty instructions with the endianness swap
  marker.

  [ Test Plan ]

  Minimal reproducer: (after booting up an s390x vm)
  ```
  ubuntu@slyon-lp-2123828-slyon-glibc-qemu-riscv64:~$ sudo apt update && su=
do apt install qemu-user
  ubuntu@slyon-lp-2123828-slyon-glibc-qemu-riscv64:~$ dpkg -l | grep libc6
  ii  libc6:s390x                           2.42-0ubuntu3
  ubuntu@slyon-lp-2123828-slyon-glibc-qemu-riscv64:~$ dpkg -l | grep qemu-u=
ser
  ii  qemu-user                             1:10.1.0+ds-5ubuntu1
  ubuntu@slyon-lp-2123828-slyon-glibc-qemu-riscv64:~$ dpkg --print-architec=
ture
  s390x
  ubuntu@slyon-lp-2123828-slyon-glibc-qemu-riscv64:~$ sudo dpkg --add-archi=
tecture riscv64
  ubuntu@slyon-lp-2123828-slyon-glibc-qemu-riscv64:~$ sudo apt update
  ubuntu@slyon-lp-2123828-slyon-glibc-qemu-riscv64:~$ sudo apt install hell=
o:riscv64
  ubuntu@slyon-lp-2123828-slyon-glibc-qemu-riscv64:~$ /usr/bin/qemu-riscv64=
 /usr/bin/hello
  /usr/bin/hello: /lib/ld-linux-riscv64-lp64d.so.1: unsupported version 256=
 of Verdef record
  /usr/bin/hello: /lib/riscv64-linux-gnu/libc.so.6: unsupported version 256=
 of Verdef record
  /usr/bin/hello: /lib/riscv64-linux-gnu/libc.so.6: unsupported version 256=
 of Verdef record
  /usr/bin/hello: /lib/riscv64-linux-gnu/libc.so.6: unsupported version 256=
 of Verdef record
  /usr/bin/hello: /lib/ld-linux-riscv64-lp64d.so.1: unsupported version 256=
 of Verdef record
  /usr/bin/hello: /lib/ld-linux-riscv64-lp64d.so.1: unsupported version 256=
 of Verdef record
  /usr/bin/hello: /lib/ld-linux-riscv64-lp64d.so.1: unsupported version 256=
 of Verdef record
  ```

  The same thing with the patch shows "Hello, world !".

  [ Where problems could occur ]

  This change is really small (3 lines), and only affects riscv64
  emulation from QEMU. If the fix was entirely wrong, riscv64 emulation
  of compressed instruction could be affected. It can be easily tested.

  The patch was accepted upstream, so such tests are conducted upstream
  as well, which reduces the amount of possible problems and work to do
  to fix those.

  [ Other Info ]

  Patch applied upstream: https://gitlab.com/qemu-project/qemu/-/commit/b25=
133d38fe693589cf695b85968caa0724bfafd
  Patch available on ppa: https://launchpad.net/~vhaudiquet/+archive/ubuntu=
/qemu-fix-lp2123828/+packages

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/2123828/+subscriptions


