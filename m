Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4A9F8FA9A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDbk-0007LO-AD; Tue, 21 Apr 2026 12:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1wFDbV-0007Ie-VE
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:05:46 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1wFDbQ-0006PZ-MT
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:05:37 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 5CC3642ABA
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 16:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1776787526;
 bh=Gz2azgupzA563YC4+toZsvcBFlTg7ptc5dNA5P0jMGM=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=FLnx3xlx8snuJKpVrva2C9oUu68igEqKCXWow3Bca7+l4CoRHEa5FlPCFAYQIO8aF
 5ebeq4z+m5S6AMLOej93aIMSo2WiB3Z+E2yBydmKNzRzTD97ppGMUjVug/78WmXnG9
 KWAzmOHThPBjY0NALoDPr72ZekgplxNj4D84HGT6iz6FaQU63EPzMIfjgyVBlo/2nL
 D8e3QbNlKOAuJ4QSsitgrXmRSqlbHhs6BLhFWho+cljTgmIYV3euS9119DBTjyLAH9
 23jCB35QU5FWFb3ztt6YjCcJx7DoXNv+iCSYt/45Wd0iMuPXRPobbnChPf3MMNcdC+
 WbJURV15Voo8A==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 4EABE7F3B0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 16:05:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 15:59:29 -0000
From: Launchpad Bug Tracker <2133804@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Unknown;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 milestone=ubuntu-26.04; status=Fix Released; importance=High;
 assignee=hector.cao@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=jammy; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Medium;
 assignee=hector.cao@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=noble; sourcepackage=qemu;
 component=main; milestone=ubuntu-24.04.4; status=Confirmed; importance=Medium;
 assignee=hector.cao@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=plucky; sourcepackage=qemu;
 component=main; status=Won't Fix; importance=Medium; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=questing; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Medium;
 assignee=hector.cao@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=resolute; sourcepackage=qemu;
 component=main; milestone=ubuntu-26.04; status=Fix Released; importance=High;
 assignee=hector.cao@canonical.com; 
X-Launchpad-Bug-Tags: server-todo
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: hectorcao janitor mjt+launchpad-tls paelzer
 utkarsh xypron
X-Launchpad-Bug-Reporter: Heinrich Schuchardt (xypron)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <176477927666.3767208.4954653462090539439.malonedeb@juju-98d295-prod-launchpad-3>
Message-Id: <177678717018.3867700.14300090745690145397.launchpad@scripts-bzrsyncd.lp.internal>
Subject: [Bug 2133804] Re: QEMU does not emulate IOCTL TCGETS2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="866d07beecca8ac2e3326342adf6c1740cd3e7b3";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 3fa08fb5e7d540f277f44ee59ee968c89627cdd6
Received-SPF: pass client-ip=185.125.188.250;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-0.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 2133804 <2133804@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

** Merge proposal linked:
   https://code.launchpad.net/~hectorcao/ubuntu/+source/qemu/+git/qemu/+mer=
ge/504068

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2133804

Title:
  QEMU does not emulate IOCTL TCGETS2

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Jammy:
  Confirmed
Status in qemu source package in Noble:
  Confirmed
Status in qemu source package in Plucky:
  Won't Fix
Status in qemu source package in Questing:
  Confirmed
Status in qemu source package in Resolute:
  Fix Released

Bug description:
  In Ubuntu 25.10 we moved to glibc 2.42. Here glibc has changed the
  implementation of isatty(). It now uses IOCTL TCGETS2 instead of
  TCGETS. TCGETS2 is not emulated by static QEMU (qemu-riscv64, qemu-
  arm64, ...).

  This leads to failures in containers for foreign architectures. E.g. no c=
onsole prompt is displayed.=20
  A detailed analysis is contained in LP #2133188.

  A proper implementation of the missing IOCTLs will include:

  Functions:

  in linux-user/syscall.c:
  host_to_target_termios2()
  target_to_host_termios2()
  print_termios2()

  Definitions:

  in linux-user/syscall.c
  #define termios2 host_termios2

  in linux-user/syscall_types.h
  STRUCT_SPECIAL(termios2)

  in linux-user/ioctls.h:
  IOCTL(TCGETS2, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETS2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETSF2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETSW2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))

  in linux-user/user-internals.h:
  void print_termios2(void *arg);

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/2133804/+subscriptions


