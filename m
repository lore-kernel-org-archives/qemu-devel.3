Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65295CD6E5C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 13:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJXjI-0006IF-F9; Thu, 13 Nov 2025 08:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vJXj7-0006Bc-04
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 08:51:05 -0500
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vJXj4-0002GD-6F
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 08:51:04 -0500
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 3E1AC43982
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 13:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1763041860;
 bh=96q41YLLWEJdO3MLI0pRASap4svKRNf1WL1ps0YEhG8=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=qj0IK6iLtnztZ7HSG7T+Dncl1+/dvvp1EweSp+/Fj5JKA5nuYGx1FR+piw2V+bSN2
 k8xTYSFqRdWBH533gfKoTrHvv2DqIjY1TLoQe1xf9g/Ms4KxLJHmo6wHi2OwpQUvVO
 im2kS59eXiE8p6ALZ79zwAlKNmL5pIiIoT8st2chRlMYzZPhzfsMBTwJlM7xU+PE4C
 BsfDlmL5/7em4zZWHZX/XI68CjKYegU9Uck3hbmVzBSMuCgF7elJ7Vrq2c9parKMWu
 WTDIQV480fFxOLv0KWH+qtlc8SGmZrOFjp/Z5LQoDf+oSKRaUjJSnRoc4NJewqFlXr
 h9CoGs2JJhInQ==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 297557F65E
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 13:51:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Nov 2025 13:44:06 -0000
From: Valentin Haudiquet <2123828@bugs.launchpad.net>
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
X-Launchpad-Bug-Tags: block-proposed-questing update-excuse verification-done
 verification-done-questing
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ahasenack enr0n hectorcao janitor paelzer schopin
 slyon ubuntu-sru-bot vhaudiquet xypron
X-Launchpad-Bug-Reporter: =?utf-8?q?Lukas_M=C3=A4rdian_=28slyon=29?=
X-Launchpad-Bug-Modifier: Valentin Haudiquet (vhaudiquet)
References: <175793222278.1250191.6568998309826575823.malonedeb@juju-98d295-prod-launchpad-2>
Message-Id: <176304144629.714072.13713819323099882162.malone@juju-98d295-prod-launchpad-7>
Subject: [Bug 2123828] Re: [SRU] RISC-V: incorrect emulation of load and store
 on big-endian systems
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1d08ffb47b836b8a4c9a0f11318dfdea7420ab6d";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 502a63699c8cb7b0b4b3ece24d299590f5a8cae8
Received-SPF: pass client-ip=185.125.188.251;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-1.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

I don't think I fully understand: I thought the only issue was the ceph
SRU still waiting, and everything would be fixed after that. So this SRU
is already "over", right ? (to me it was).

I don't plan on fixing something else for now, if that is your
question... but maybe that question was not for me but for Lukas ?

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


