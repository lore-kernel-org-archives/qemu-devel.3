Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824FBC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 17:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2ZaC-0007MY-Ma; Wed, 09 Apr 2025 13:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1u2Za5-00076a-N8
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 13:51:23 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1u2Za1-00059j-MP
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 13:51:21 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id D2DD644D8F
 for <qemu-devel@nongnu.org>; Wed,  9 Apr 2025 17:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1744221065;
 bh=2pgFbxLS6bnFSH6XlkgTRWFEwha/pzB4KCj2FwgVvLQ=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=TdrEwYG1zbEQgtrborApQuV9uRapDl3YS+20/nTsuZ7fkeTKHT0ulHhclPLeFM0vI
 tgdS5jUMfwSRuSKDitTXTpqxCR3aVlUyE9RppohQguu0CZICYyC0vQsoXn9P6DbUEk
 5VqVHShwR0Dh9FtlAf61iFCRsIHJhqjapWqRGzIVOX57KI6H9bDn28MDTS+l5+sCKH
 xuV0zGzCZsuCL1buPQh7GCaeHMKkNOsA5jEITIgqMA+MaD9vhqgd2f5BU7aUfMJZUM
 GTTY4nZqceJLwjBxm61quQ42h3cUQUrCcd08ASJ1CeD4T73jl4SLiz8kfk6oII6NDj
 V75+u1T2S2/XA==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id BB59E7E148
 for <qemu-devel@nongnu.org>; Wed,  9 Apr 2025 17:51:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Apr 2025 17:40:14 -0000
From: Andreas Hasenack <2072564@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Unknown;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Fix Released; importance=Undecided;
 assignee=lukas.maerdian@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=noble; sourcepackage=qemu;
 component=main; status=Fix Committed; importance=Undecided;
 assignee=lukas.maerdian@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=oracular; sourcepackage=qemu;
 component=main; status=Fix Committed; importance=Undecided;
 assignee=lukas.maerdian@canonical.com; 
X-Launchpad-Bug-Tags: patch verification-needed verification-needed-noble
 verification-needed-oracular
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ahasenack crichton dimitry.unified-streaming.com
 janitor michal.fita paelzer sergiodj thir820
X-Launchpad-Bug-Reporter: Dimitry Andric (dimitry.unified-streaming.com)
X-Launchpad-Bug-Modifier: Andreas Hasenack (ahasenack)
References: <172053137048.3332067.13534832802726064667.malonedeb@juju-98d295-prod-launchpad-7>
Message-Id: <174422041427.3299966.17935107661250509384.malone@juju-98d295-prod-launchpad-2>
Subject: [Bug 2072564] Please test proposed package
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e76edd883483c71c468bb038e98836435de44530";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 8a7f6fb4585d59d18e626e0a7b8d501b99dea656
Received-SPF: pass client-ip=185.125.188.251;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-1.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 2072564 <2072564@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Dimitry, or anyone else affected,

Accepted qemu into oracular-proposed. The package will build now and be
available at
https://launchpad.net/ubuntu/+source/qemu/1:9.0.2+ds-4ubuntu5.3 in a few
hours, and then in the -proposed repository.

Please help us by testing this new package.  See
https://wiki.ubuntu.com/Testing/EnableProposed for documentation on how
to enable and use -proposed.  Your feedback will aid us getting this
update out to other Ubuntu users.

If this package fixes the bug for you, please add a comment to this bug,
mentioning the version of the package you tested, what testing has been
performed on the package and change the tag from verification-needed-
oracular to verification-done-oracular. If it does not fix the bug for
you, please add a comment stating that, and change the tag to
verification-failed-oracular. In either case, without details of your
testing we will not be able to proceed.

Further information regarding the verification process can be found at
https://wiki.ubuntu.com/QATeam/PerformingSRUVerification .  Thank you in
advance for helping!

N.B. The updated package will be released to -updates after the bug(s)
fixed by this package have been verified and the package has been in
-proposed for a minimum of 7 days.

** Changed in: qemu (Ubuntu Noble)
       Status: In Progress =3D> Fix Committed

** Tags added: verification-needed-noble

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2072564

Title:
  qemu-aarch64-static segfaults running ldconfig.real (amd64 host)

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Noble:
  Fix Committed
Status in qemu source package in Oracular:
  Fix Committed

Bug description:
  [ Impact ]

   * QEMU crashes when running (emulating) ldconfig in a Ubuntu 22.04
  arm64 guest

   * This affects the qemu-user-static 1:8.2.2+ds-0ubuntu1 package on
  Ubuntu 24.04+, running on a amd64 host.

   * When running docker containers with Ubuntu 22.04 in them, emulating
  arm64 with qemu-aarch64-static, invocations of ldconfig (actually
  ldconfig.real) segfault, leading to problems when loading shared
  libraries.

  [ Test Plan ]

   * Reproducer is very easy:

  $ sudo snap install docker
  docker 27.5.1 from Canonical** installed
  $ docker run -ti --platform linux/arm64/v8 ubuntu:22.04
  Unable to find image 'ubuntu:22.04' locally
  22.04: Pulling from library/ubuntu
  0d1c17d4e593: Pull complete=20
  Digest: sha256:ed1544e454989078f5dec1bfdabd8c5cc9c48e0705d07b678ab6ae3fb6=
1952d2
  Status: Downloaded newer image for ubuntu:22.04

  # Execute ldconfig.real inside the arm64 guest.
  # This should not crash after the fix!
  root@ad80af5378dc:/# /sbin/ldconfig.real
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault (core dumped)

  [ Where problems could occur ]

   * This changes the alignment of sections in the ELF binary via QEMUs
  elfloader, if something goes wrong with this change, it could lead to
  all kind of crashes (segfault) of any emulated binaries.

  [ Other Info ]

   * Upstream bug: https://gitlab.com/qemu-project/qemu/-/issues/1913
   * Upstream fix: https://gitlab.com/qemu-project/qemu/-/commit/4b7b20a3
     - Fix dependency (needed for QEMU < 9.20): https://gitlab.com/qemu-pro=
ject/qemu/-/commit/c81d1faf

  --- original bug report ---

 =20
  This affects the qemu-user-static 1:8.2.2+ds-0ubuntu1 package on Ubuntu 2=
4.04, running on a amd64 host.

  When running docker containers with Ubuntu 22.04 in them, emulating
  arm64 with qemu-aarch64-static, invocations of ldconfig (actually
  ldconfig.real) segfault. For example:

  $ docker run -ti --platform linux/arm64/v8 ubuntu:22.04
  root@8861ff640a1c:/# /sbin/ldconfig.real
  Segmentation fault

  If you copy the ldconfig.real binary to the host, and run it directly
  via qemu-aarch64-static:

  $ gdb --args qemu-aarch64-static ./ldconfig.real
  GNU gdb (Ubuntu 15.0.50.20240403-0ubuntu1) 15.0.50.20240403-git
  Copyright (C) 2024 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.
  Type "show copying" and "show warranty" for details.
  This GDB was configured as "x86_64-linux-gnu".
  Type "show configuration" for configuration details.
  For bug reporting instructions, please see:
  <https://www.gnu.org/software/gdb/bugs/>.
  Find the GDB manual and other documentation resources online at:
  =C2=A0=C2=A0=C2=A0=C2=A0<http://www.gnu.org/software/gdb/documentation/>.

  For help, type "help".
  Type "apropos word" to search for commands related to "word"...
  Reading symbols from qemu-aarch64-static...
  Reading symbols from /home/dim/.cache/debuginfod_client/86579812b213be096=
4189499f62f176bea817bf2/debuginfo...
  (gdb) r
  Starting program: /usr/bin/qemu-aarch64-static ./ldconfig.real
  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
  [New Thread 0x7ffff76006c0 (LWP 28378)]

  Thread 1 "qemu-aarch64-st" received signal SIGSEGV, Segmentation fault.
  0x00007fffe801645b in ?? ()
  (gdb) disassemble
  No function contains program counter for selected frame.

  It looks like this is a known qemu regression after v8.1.1:
  https://gitlab.com/qemu-project/qemu/-/issues/1913

  Downgrading the package to qemu-user-
  static_8.0.4+dfsg-1ubuntu3_amd64.deb fixes the segfault.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/2072564/+subscriptions


