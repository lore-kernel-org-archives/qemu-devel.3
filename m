Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07E7C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 13:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ91c-0004jI-Ay; Wed, 31 Jul 2024 09:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1sZ91W-0004et-Eq
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 09:05:46 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1sZ91U-0001sV-7A
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 09:05:46 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 2B29941207
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 13:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1722431140;
 bh=0ppAZKFYmOdqYyRRoQb4S1cbnkVOsnxbmg7QQmbtseg=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=K/Bbf7KCS3TAaYs1KLnuDL6d/eBaO45dIZAhZ6yG3oFN1+enyD8SKIZ3g6xyBDHVc
 bYPyXMoODlponZ1VQfCAy1dyMKZ3NPVNFI5Mkp5EOXBCiXrFhCDV3M9DR/jCxNXRTf
 c60RX4mZCW4z7gttuq8aSdYZWLW6SPqBM3YGeJRPTyX4n56dcKLuCtOzXPejXOU5cs
 0JIecFAo+UT6d18Pp8u/CT4SWg4lp0cHYDxIs+3ihYlJdbQv8cf9usy8W5zx74ym62
 VqGXBC4KTOBd4Oov7O8HK4b+8C75O4NWXxMADezBBPLgf9JFyqLOmPUkNizJBGs0Uo
 jyFrB91TyPGzA==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 218B87E1F6
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 13:05:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 Jul 2024 12:56:24 -0000
From: =?utf-8?q?Micha=C5=82_Fita?= <2072564@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Unknown; assignee=None;
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Triaged; importance=Undecided; assignee=sergio.durigan@canonical.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dimitry.unified-streaming.com michal.fita sergiodj
X-Launchpad-Bug-Reporter: Dimitry Andric (dimitry.unified-streaming.com)
X-Launchpad-Bug-Modifier: =?utf-8?q?Micha=C5=82_Fita_=28michal=2Efita=29?=
References: <172053137048.3332067.13534832802726064667.malonedeb@juju-98d295-prod-launchpad-7>
Message-Id: <172243058497.3038745.7611135827346947168.malone@juju-98d295-prod-launchpad-7>
Subject: [Bug 2072564] Re: qemu-aarch64-static segfaults running ldconfig.real
 (amd64 host)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e3ace39cea497a5ecb83e8fb6dd8e7e169f02939";
 Instance="launchpad-scripts"
X-Launchpad-Hash: ea9a332e36b19be6d5ee0b2167258aebecd9299a
Received-SPF: pass client-ip=185.125.188.251;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-1.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

I'm using quemu to tweak Armbian Jammy images for Raspberry Pi 5 (so it
would have ldconfig from 22.04) and I have signal 11 when libc
reconfiguration is triggered by apt.

What you may find interesting running the same process of updates on the
same base image on Ubuntu 22.04 (which has qemu 6.2) works fine.

My googling around "libc signal 11 quemu" lead to a lot of people
reporting problems with docker buildx with qemu predating 7.0. This
smells kind of regression in 8.2 used in 24.04. Then the issue linked
above says affected ldconfigs are 2.33 to 2.35...

Does Ubuntu really need to wait for upstream to deal with this? It's a
huge slap in the face for everyone on 24.04 needing to meddle 22.04
ARM64 images.

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2072564

Title:
  qemu-aarch64-static segfaults running ldconfig.real (amd64 host)

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  Triaged

Bug description:
  This affects the qemu-user-static 1:8.2.2+ds-0ubuntu1 package on
  Ubuntu 24.04, running on a amd64 host.

  When running docker containers with Ubuntu 22.04 in them, emulating
  arm64 with qemu-aarch64-static, invocations of ldconfig (actually
  ldconfig.real) segfault. For example:

  $ docker run -ti --platform linux/arm64/v8 ubuntu:22.04=20
  root@8861ff640a1c:/# /sbin/ldconfig.real
  Segmentation fault

  If you copy the ldconfig.real binary to the host, and run it directly
  via qemu-aarch64-static:

  $ gdb --args qemu-aarch64-static ./ldconfig.real=20
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
      <http://www.gnu.org/software/gdb/documentation/>.

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
  (gdb) disassemble=20
  No function contains program counter for selected frame.

  It looks like this is a known qemu regression after v8.1.1:
  https://gitlab.com/qemu-project/qemu/-/issues/1913

  Downgrading the package to qemu-user-
  static_8.0.4+dfsg-1ubuntu3_amd64.deb fixes the segfault.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/2072564/+subscriptions


