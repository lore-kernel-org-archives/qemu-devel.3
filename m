Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C08CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxi9-0000cg-Dt; Tue, 09 Jun 2026 10:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1wWxi6-0000cU-OR
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:45:46 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1wWxi3-0001Cg-Vq
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:45:46 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 8C7DA402FA
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2026 14:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1781016341;
 bh=2cq3BDWZoSW2t5qL0ZbPXMkYXCLsgleWKlVyh2l7MWY=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=pnC6/b+wwXoG6SJ2rY9umggLFH/RT/pC4N8Wu0gI/SigNZ5+zOArkS2izj1wePMyb
 Uri9EnPr6/zlyRRlsTMqu8FoI45cJnoFkvLsJM1jdWVLYaKIaFwWcP2mj1y4nMLBIr
 Hn2T5YUJfY+iz4sYuSkxNPKSy4upvHJrQUuJ3uhW19AtslgMESWZBXFg/Tg1THj3+B
 tglvUD/V0hMmlS8El9L9AyjtOPaBL3JJvti/DdvzWZb8pT9IrwY0Ra3WVJO2+DlBEC
 jFj4uvigZvv7hbtX8J7JGxoBFP0vBnt6UjzOy6wpt+vIzXrMLclBz9JCnIuBTgsTnf
 pm4IBYJn5M5Iw==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 687B57F026
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2026 14:45:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 14:37:44 -0000
From: Ubuntu SRU Bot <2133804@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Unknown;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 milestone=ubuntu-26.04; status=Fix Released; importance=High;
 assignee=hector.cao@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=jammy; sourcepackage=qemu;
 component=main; status=Fix Committed; importance=Medium;
 assignee=hector.cao@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=noble; sourcepackage=qemu;
 component=main; milestone=ubuntu-24.04.4; status=Fix Committed;
 importance=Medium; assignee=hector.cao@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=plucky; sourcepackage=qemu;
 component=main; status=Won't Fix; importance=Medium; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=questing; sourcepackage=qemu;
 component=main; status=Fix Committed; importance=Medium;
 assignee=hector.cao@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=resolute; sourcepackage=qemu;
 component=main; milestone=ubuntu-26.04; status=Fix Released; importance=High;
 assignee=hector.cao@canonical.com; 
X-Launchpad-Bug-Tags: server-todo verification-done-questing
 verification-needed-jammy verification-needed-noble
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ahasenack hectorcao janitor juliank lvoytek
 mjt+launchpad-tls paelzer ubuntu-sru-bot utkarsh xypron
X-Launchpad-Bug-Reporter: Heinrich Schuchardt (xypron)
X-Launchpad-Bug-Modifier: Ubuntu SRU Bot (ubuntu-sru-bot)
References: <176477927666.3767208.4954653462090539439.malonedeb@juju-98d295-prod-launchpad-3>
Message-Id: <20260609143744.58D06FC029@ubuntu-archive-toolbox.internal>
Subject: [Bug 2133804] Autopkgtest regression report
 (qemu/1:6.2+dfsg-2ubuntu6.31)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="81b3240738cf12f6bd4aac6593260fef8d7b0d96";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 028b2a5bceac8b9b41a6be1e640d35c010ae2812
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

All autopkgtests for the newly accepted qemu (1:6.2+dfsg-2ubuntu6.31) for j=
ammy have finished running.
The following regressions have been reported in tests triggered by the pack=
age:

casper/unknown (amd64)
cinder/unknown (amd64, ppc64el)
cloud-utils/unknown (amd64)
debos/unknown (amd64)
dropbear/unknown (ppc64el)
edk2/unknown (i386)
glance/unknown (ppc64el)
golang-github-go-debos-fakemachine/unknown (amd64)
libvirt/8.0.0-1ubuntu7.16 (ppc64el)
libvirt/unknown (amd64)
multipath-tools/unknown (ppc64el)
nova/3:25.2.1-0ubuntu2.10 (ppc64el, s390x)
nova/unknown (amd64)
open-iscsi/unknown (ppc64el)
snek/unknown (amd64)
systemd/249.11-0ubuntu3.21 (ppc64el)


Please visit the excuses page listed below and investigate the failures, pr=
oceeding afterwards as per the StableReleaseUpdates policy regarding autopk=
gtest regressions [1].

https://ubuntu-archive-team.ubuntu.com/proposed-
migration/jammy/update_excuses.html#qemu

[1] https://documentation.ubuntu.com/project/SRU/howto/autopkgtest-
failure/

Thank you!

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
  Fix Committed
Status in qemu source package in Noble:
  Fix Committed
Status in qemu source package in Plucky:
  Won't Fix
Status in qemu source package in Questing:
  Fix Committed
Status in qemu source package in Resolute:
  Fix Released

Bug description:
  [ Impact ]

  - Terminal prompt is missing for multiarch containers with qemu-user

  - Users cannot see the prompt but still can type the commands
  =C2=A0=C2=A0However the absence of the prompt can be misleading and make =
users think that the container hangs.

  - this fix implements the missing ioctl TERMIOS2

  [ Test Plan ]

  On an amd64 host

  $ sudo apt install -y docker.io qemu-user-static
  $ sudo usermod -aG docker ubuntu
  $ newgrp docker
  $ docker run --platform=3Dlinux/arm64 -it ubuntu:26.04 bash
  =C2=A0(this runs on AMD64 host, if you are runnig on ARM64, use -platform=
=3Dlinux/riscv64 instead)

  After docker pulls the image and run the container, you cannot see the
  prompt

  ...
  Status: Downloaded newer image for ubuntu:26.04
  ...

  $ docker run --platform=3Dlinux/arm64 -it ubuntu:24.04 bash

  Doing the same for Ubuntu Noble image works.

  $ docker run --platform=3Dlinux/arm64 -it ubuntu:24.04 bash
  Unable to find image 'ubuntu:24.04' locally
  24.04: Pulling from library/ubuntu
  818154cda96d: Pull complete
  352b2c3faa58: Download complete
  Digest: sha256:c4a8d5503dfb2a3eb8ab5f807da5bc69a85730fb49b5cfca2330194ebc=
c41c7b
  Status: Downloaded newer image for ubuntu:24.04
  root@bf8124075385:/#

  With this fix, the users should see the prompt when they run bash
  interactively in the container:

  $ docker run --platform=3Dlinux/arm64 -it ubuntu:26.04 bash
  root@bf8124075385:/#

  [ Where problems could occur ]

  The fix is around the termios managament so regressions can happen there.
  There might be regressions on the prompt display.

  The prompt display is widely used so potential regressions should be
  visible quickly.

  [ Other Info ]

  None

  -- Original bug report ---

  In Ubuntu 25.10 we moved to glibc 2.42. Here glibc has changed the
  implementation of isatty(). It now uses IOCTL TCGETS2 instead of
  TCGETS. TCGETS2 is not emulated by static QEMU (qemu-riscv64, qemu-
  arm64, ...).

  This leads to failures in containers for foreign architectures. E.g. no c=
onsole prompt is displayed.
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


