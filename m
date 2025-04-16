Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B0CC369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4yzk-0006Cf-CH; Wed, 16 Apr 2025 05:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1u4yzf-00065l-5V
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:23:43 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1u4yza-000168-Qy
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:23:42 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id DA2A542BFE
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 09:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1744795414;
 bh=3DczRBIu1c8wh6t9eKIWDDaySAswVc9/vycbgRl1UTw=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=MbCs704paC1FN6J4FDI5pq1BSmwASsbc0hTPX6E9qU4D9dauGV8T2aHCGHnSEqjQS
 2L8fO9BHgVOh2QPQ30uSQisX2fjWp8P7mmp5TTwmo3thIWxNjeqFmUE/Gn3XVaHhGR
 tgpCGVagLxTDnXPXDO9LcX0eDQp5JeqTI773onYdTBqoWhLw13THZzGLRjw+71yVuJ
 WbifN3Cc9hijlHB2tqSyCb1wP3vLkZiA0RPvi880gxVvh61CLH6SLwdxxuDkrwZJAd
 cmNpVIqJLYj4U7LXDohPS//tjlyIV8Wd5SohRoiNXjhmgbwm1V51I+N0CmdLLJtMGR
 ckAgGL8G9Y8PQ==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id A06A87E917
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 09:23:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Apr 2025 09:09:55 -0000
From: =?utf-8?q?Lukas_M=C3=A4rdian?= <2072564@bugs.launchpad.net>
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
X-Launchpad-Bug-Tags: patch verification-done verification-done-noble
 verification-done-oracular
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ahasenack crichton dimitry.unified-streaming.com
 janitor michal.fita paelzer sergiodj slyon thir820 ubuntu-sru-bot
X-Launchpad-Bug-Reporter: Dimitry Andric (dimitry.unified-streaming.com)
X-Launchpad-Bug-Modifier: =?utf-8?q?Lukas_M=C3=A4rdian_=28slyon=29?=
References: <172053137048.3332067.13534832802726064667.malonedeb@juju-98d295-prod-launchpad-7>
Message-Id: <174479459584.2610407.524894513659161001.malone@juju-98d295-prod-launchpad-2>
Subject: [Bug 2072564] Re: qemu-aarch64-static segfaults running ldconfig.real
 (amd64 host)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e76edd883483c71c468bb038e98836435de44530";
 Instance="launchpad-scripts"
X-Launchpad-Hash: cf934cc3d14f8dcef0b0569202b258556a764b23
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
Reply-To: Bug 2072564 <2072564@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I verified qemu-user-static 1:9.0.2+ds-4ubuntu5.3 from oracular-
proposed. Looking good!


$ lxc launch --vm ubuntu-daily:oracular lp2072564-oo
$ lxc shell lp2072564-oo

root@lp2072564-oo:~# sudo apt install qemu-user-static  # the old, non-prop=
osed version (1:9.0.2+ds-4ubuntu5.2) to confirm the issue
[...]
root@lp2072564-oo:~# sudo snap install docker
2025-04-16T09:00:43Z INFO Waiting for automatic snapd restart...
docker 27.5.1 from Canonical=E2=9C=93 installed
root@lp2072564-oo:~# docker run -ti --platform linux/arm64/v8 ubuntu:22.04
Unable to find image 'ubuntu:22.04' locally
22.04: Pulling from library/ubuntu
7b76bc00f23a: Pull complete=20
Digest: sha256:d80997daaa3811b175119350d84305e1ec9129e1799bba0bd1e3120da3ff=
52c3
Status: Downloaded newer image for ubuntu:22.04
root@3516ec56fbf6:/# sbin/ldconfig.real
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault (core dumped)

=3D> I can reproduce the issue on the old version

root@lp2072564-oo:~# vim /etc/apt/sources.list.d/ubuntu.sources  # enable -=
proposed
root@lp2072564-oo:~# apt update
[...]
root@lp2072564-oo:~# apt install -t oracular-proposed qemu-user-static
[...]
Get:1 http://archive.ubuntu.com/ubuntu oracular-proposed/universe amd64 qem=
u-user-static amd64 1:9.0.2+ds-4ubuntu5.3 [16.7 MB]
[...]
root@lp2072564-oo:~# docker run -ti --platform linux/arm64/v8 ubuntu:22.04
root@d31821abb9c9:/# /sbin/ldconfig.real
root@d31821abb9c9:/# echo $?
0

=3D> Issue is fixed! \o/



** Tags removed: verification-needed-oracular
** Tags added: verification-done-oracular

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


