Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7BFCAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23Q2-0004On-SX; Fri, 26 Sep 2025 04:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1v23Px-0004NO-Po
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 04:03:02 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1v23Pl-0007IX-61
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 04:03:00 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 53A1544B3E
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1758873368;
 bh=6zTyMfjMKlks6HDnoQPhRx2AKjLyKpwyQ1ypCGd4XlE=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=Es0X2UwDM+LMstNur3wQMPTBd8DBLiait/LmGXfa8YbzSufdvjlopsH1vdA8XjUC3
 BdRLvqzSn7TKvJQFunIpNHJd6vMoSqhgt4hnc9puePdTv7Db1hqcZ1tShBuHVQS9ZS
 OJu68JVlCpjNlZIL5InitlGxUt2Wok0IFK+URzBfEhdNLZ+sZewsk6cQjSAfL6G6Fr
 JbnscpMm3YiDGne0Z8ALh+CVXyz8fGjIZEA+nf7MfsWGTizp2WF1lWZW1+JCDrIkqs
 osbMEeXUPyzc1CkZk4Li/NiUQQDGuyy5HW+3vhYUU467hnJwi5tamGvulE9UNEd2YA
 50JcnEuVQU1iA==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 46ACF7F5C1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:56:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Sep 2025 07:47:08 -0000
From: Heinrich Schuchardt <2123828@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Unknown; importance=Unknown;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=gcc-15; component=main;
 status=Invalid; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=glibc; component=main;
 status=Invalid; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Confirmed; importance=Undecided;
 assignee=valentin.haudiquet@canonical.com; 
X-Launchpad-Bug-Tags: dcr-incoming update-excuse
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: schopin slyon xypron
X-Launchpad-Bug-Reporter: =?utf-8?q?Lukas_M=C3=A4rdian_=28slyon=29?=
X-Launchpad-Bug-Modifier: Heinrich Schuchardt (xypron)
References: <175793222278.1250191.6568998309826575823.malonedeb@juju-98d295-prod-launchpad-2>
Message-Id: <175887282972.3832771.1380958799483108788.launchpad@juju-98d295-prod-launchpad-3>
Subject: [Bug 2123828] Re: unsupported version 256 of Verdef record when
 running qemu-riscv64 on s390x
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6b7d10538685bbcfe8b2a2ba6e15514ae715297b";
 Instance="launchpad-scripts"
X-Launchpad-Hash: bf6f8c987897dfb4122b667135665f51216e9b57
Received-SPF: pass client-ip=185.125.188.251;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-1.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

** Changed in: qemu (Ubuntu)
     Assignee: Heinrich Schuchardt (xypron) =3D> Valentin Haudiquet (vhaudi=
quet)

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2123828

Title:
  unsupported version 256 of Verdef record when running qemu-riscv64 on
  s390x

Status in QEMU:
  Unknown
Status in gcc-15 package in Ubuntu:
  Invalid
Status in glibc package in Ubuntu:
  Invalid
Status in qemu package in Ubuntu:
  Confirmed

Bug description:
  QEMU's DEP-8 test fails on s390x, due to warning output on stderr
  about "unsupported version 256 of Verdef record", which is blocking
  migration of glibc 2.42-0ubuntu3.

  Minimal reproducer:
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

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/2123828/+subscriptions


