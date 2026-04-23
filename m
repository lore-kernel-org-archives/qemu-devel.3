Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8ACF589DA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFumV-0001Mn-Mh; Thu, 23 Apr 2026 10:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1wFum5-0001MM-1b
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:11:25 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1wFulz-0002f5-Oj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:11:24 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id A154344253
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1776953477;
 bh=EPx64DuJH/k6dT1W4B6gPeIZfW9q/jwe3KDBmvHubcM=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=EAtAighbG4QeZkreqRW+VpSrBcRb3IGPiEQmy2sxmnEUmy6R6VgkCI9shHXHHCO3y
 7ZzsVZAOfPGdEVyycaPtF2bTUj78YawjkEoSGlv6ijkPBKSMtjsHbn5iDf1xRTR3M8
 FeGiJgL55CwGIX5mXksPykWec4rACMKqs2wUA1JwMjIHTEERHttAIvJ0FWdf4QVvgB
 VgGcXcV0boTPtgA4Ud8DmfKxAshs/CC8596A0/5cO57ETnrIZS0H4AIRvxBitnFCnM
 5i59nD+8F7buojJhYbDh4bUUIFqnCfTUB6VG1We/xzIXTvFJmVNHJITz7TwX8ND0lN
 cK+LB8CEaQ1Ng==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 95F927E139
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:11:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 13:53:18 -0000
From: Hector CAO <2133804@bugs.launchpad.net>
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
 component=main; milestone=ubuntu-24.04.4; status=In Progress;
 importance=Medium; assignee=hector.cao@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=plucky; sourcepackage=qemu;
 component=main; status=Won't Fix; importance=Medium; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=questing; sourcepackage=qemu;
 component=main; status=In Progress; importance=Medium;
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
X-Launchpad-Bug-Modifier: Hector CAO (hectorcao)
References: <176477927666.3767208.4954653462090539439.malonedeb@juju-98d295-prod-launchpad-3>
Message-Id: <177695239911.1512467.14197591136970783956.launchpad@juju-98d295-prod-launchpad-3>
Subject: [Bug 2133804] Re: QEMU does not emulate IOCTL TCGETS2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="424255f77ce35135d8fe54ca83d727444673d524";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 6a8b2f81af343d9e2e8f2c8960edefc65aa0ad43
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

** Description changed:

+ [ Impact ]
+=20
+ Terminal prompt is missing for multiarch containers with qemu-user
+=20
+=20
+ [ Test Plan ]
+=20
+ $ sudo apt install -y docker.io qemu-user-static
+ $ sudo usermod -aG docker ubuntu
+=20
+ Log out / Log in
+=20
+ $ docker run --platform=3Dlinux/arm64 --name ubuntu26 -itd ubuntu:26.04
+ bash
+=20
+ You cannot see the prompt
+=20
+ [ Where problems could occur ]
+=20
+ The fix is around the termios managament so regressions can happen
+ there.
+=20
+ [ Other Info ]
+=20
+ None
+=20
+ -- Original bug report ---
+=20
  In Ubuntu 25.10 we moved to glibc 2.42. Here glibc has changed the
  implementation of isatty(). It now uses IOCTL TCGETS2 instead of TCGETS.
  TCGETS2 is not emulated by static QEMU (qemu-riscv64, qemu-arm64, ...).
 =20
- This leads to failures in containers for foreign architectures. E.g. no c=
onsole prompt is displayed.=20
+ This leads to failures in containers for foreign architectures. E.g. no c=
onsole prompt is displayed.
  A detailed analysis is contained in LP #2133188.
 =20
  A proper implementation of the missing IOCTLs will include:
 =20
  Functions:
 =20
  in linux-user/syscall.c:
  host_to_target_termios2()
  target_to_host_termios2()
  print_termios2()
 =20
  Definitions:
 =20
  in linux-user/syscall.c
  #define termios2 host_termios2
 =20
  in linux-user/syscall_types.h
  STRUCT_SPECIAL(termios2)
 =20
  in linux-user/ioctls.h:
  IOCTL(TCGETS2, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETS2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETSF2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETSW2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
 =20
  in linux-user/user-internals.h:
  void print_termios2(void *arg);

** Description changed:

  [ Impact ]
 =20
  Terminal prompt is missing for multiarch containers with qemu-user
-=20
 =20
  [ Test Plan ]
 =20
  $ sudo apt install -y docker.io qemu-user-static
  $ sudo usermod -aG docker ubuntu
-=20
- Log out / Log in
-=20
- $ docker run --platform=3Dlinux/arm64 --name ubuntu26 -itd ubuntu:26.04
- bash
+ $ newgrp docker
+ $ docker run --platform=3Dlinux/arm64 --name ubuntu26 -it ubuntu:26.04 ba=
sh
 =20
  You cannot see the prompt
 =20
  [ Where problems could occur ]
 =20
  The fix is around the termios managament so regressions can happen
  there.
 =20
  [ Other Info ]
 =20
  None
 =20
  -- Original bug report ---
 =20
  In Ubuntu 25.10 we moved to glibc 2.42. Here glibc has changed the
  implementation of isatty(). It now uses IOCTL TCGETS2 instead of TCGETS.
  TCGETS2 is not emulated by static QEMU (qemu-riscv64, qemu-arm64, ...).
 =20
  This leads to failures in containers for foreign architectures. E.g. no c=
onsole prompt is displayed.
  A detailed analysis is contained in LP #2133188.
 =20
  A proper implementation of the missing IOCTLs will include:
 =20
  Functions:
 =20
  in linux-user/syscall.c:
  host_to_target_termios2()
  target_to_host_termios2()
  print_termios2()
 =20
  Definitions:
 =20
  in linux-user/syscall.c
  #define termios2 host_termios2
 =20
  in linux-user/syscall_types.h
  STRUCT_SPECIAL(termios2)
 =20
  in linux-user/ioctls.h:
  IOCTL(TCGETS2, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETS2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETSF2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETSW2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
 =20
  in linux-user/user-internals.h:
  void print_termios2(void *arg);

** Description changed:

  [ Impact ]
 =20
  Terminal prompt is missing for multiarch containers with qemu-user
 =20
  [ Test Plan ]
 =20
  $ sudo apt install -y docker.io qemu-user-static
  $ sudo usermod -aG docker ubuntu
  $ newgrp docker
- $ docker run --platform=3Dlinux/arm64 --name ubuntu26 -it ubuntu:26.04 ba=
sh
+ $ docker run --platform=3Dlinux/arm64 -it ubuntu:26.04 bash
+  (this runs on AMD64 host, if you are runnig on ARM64, use -platform=3Dli=
nux/riscv64 instead)
 =20
  You cannot see the prompt
 =20
  [ Where problems could occur ]
 =20
  The fix is around the termios managament so regressions can happen
  there.
 =20
  [ Other Info ]
 =20
  None
 =20
  -- Original bug report ---
 =20
  In Ubuntu 25.10 we moved to glibc 2.42. Here glibc has changed the
  implementation of isatty(). It now uses IOCTL TCGETS2 instead of TCGETS.
  TCGETS2 is not emulated by static QEMU (qemu-riscv64, qemu-arm64, ...).
 =20
  This leads to failures in containers for foreign architectures. E.g. no c=
onsole prompt is displayed.
  A detailed analysis is contained in LP #2133188.
 =20
  A proper implementation of the missing IOCTLs will include:
 =20
  Functions:
 =20
  in linux-user/syscall.c:
  host_to_target_termios2()
  target_to_host_termios2()
  print_termios2()
 =20
  Definitions:
 =20
  in linux-user/syscall.c
  #define termios2 host_termios2
 =20
  in linux-user/syscall_types.h
  STRUCT_SPECIAL(termios2)
 =20
  in linux-user/ioctls.h:
  IOCTL(TCGETS2, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETS2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETSF2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETSW2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
 =20
  in linux-user/user-internals.h:
  void print_termios2(void *arg);

** Description changed:

  [ Impact ]
 =20
  Terminal prompt is missing for multiarch containers with qemu-user
 =20
  [ Test Plan ]
 =20
+ On an amd64 host
+=20
  $ sudo apt install -y docker.io qemu-user-static
  $ sudo usermod -aG docker ubuntu
  $ newgrp docker
  $ docker run --platform=3Dlinux/arm64 -it ubuntu:26.04 bash
-  (this runs on AMD64 host, if you are runnig on ARM64, use -platform=3Dli=
nux/riscv64 instead)
+ =C2=A0(this runs on AMD64 host, if you are runnig on ARM64, use -platform=
=3Dlinux/riscv64 instead)
 =20
  You cannot see the prompt
 =20
  [ Where problems could occur ]
 =20
  The fix is around the termios managament so regressions can happen
  there.
 =20
  [ Other Info ]
 =20
  None
 =20
  -- Original bug report ---
 =20
  In Ubuntu 25.10 we moved to glibc 2.42. Here glibc has changed the
  implementation of isatty(). It now uses IOCTL TCGETS2 instead of TCGETS.
  TCGETS2 is not emulated by static QEMU (qemu-riscv64, qemu-arm64, ...).
 =20
  This leads to failures in containers for foreign architectures. E.g. no c=
onsole prompt is displayed.
  A detailed analysis is contained in LP #2133188.
 =20
  A proper implementation of the missing IOCTLs will include:
 =20
  Functions:
 =20
  in linux-user/syscall.c:
  host_to_target_termios2()
  target_to_host_termios2()
  print_termios2()
 =20
  Definitions:
 =20
  in linux-user/syscall.c
  #define termios2 host_termios2
 =20
  in linux-user/syscall_types.h
  STRUCT_SPECIAL(termios2)
 =20
  in linux-user/ioctls.h:
  IOCTL(TCGETS2, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETS2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETSF2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETSW2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
 =20
  in linux-user/user-internals.h:
  void print_termios2(void *arg);

** Description changed:

  [ Impact ]
 =20
  Terminal prompt is missing for multiarch containers with qemu-user
 =20
  [ Test Plan ]
 =20
  On an amd64 host
 =20
  $ sudo apt install -y docker.io qemu-user-static
  $ sudo usermod -aG docker ubuntu
  $ newgrp docker
  $ docker run --platform=3Dlinux/arm64 -it ubuntu:26.04 bash
  =C2=A0(this runs on AMD64 host, if you are runnig on ARM64, use -platform=
=3Dlinux/riscv64 instead)
 =20
- You cannot see the prompt
+ After docker pulls the image and run the container, you cannot see the
+ prompt
+=20
+ ...
+ Status: Downloaded newer image for ubuntu:26.04
+ ...
+=20
+ $ docker run --platform=3Dlinux/arm64 -it ubuntu:24.04 bash
+=20
+ Doing the same for Ubuntu Noble image works.
+=20
+ $ docker run --platform=3Dlinux/arm64 -it ubuntu:24.04 bash
+ Unable to find image 'ubuntu:24.04' locally
+ 24.04: Pulling from library/ubuntu
+ 818154cda96d: Pull complete=20
+ 352b2c3faa58: Download complete=20
+ Digest: sha256:c4a8d5503dfb2a3eb8ab5f807da5bc69a85730fb49b5cfca2330194ebc=
c41c7b
+ Status: Downloaded newer image for ubuntu:24.04
+ root@bf8124075385:/#=20
+=20
 =20
  [ Where problems could occur ]
 =20
  The fix is around the termios managament so regressions can happen
  there.
 =20
  [ Other Info ]
 =20
  None
 =20
  -- Original bug report ---
 =20
  In Ubuntu 25.10 we moved to glibc 2.42. Here glibc has changed the
  implementation of isatty(). It now uses IOCTL TCGETS2 instead of TCGETS.
  TCGETS2 is not emulated by static QEMU (qemu-riscv64, qemu-arm64, ...).
 =20
  This leads to failures in containers for foreign architectures. E.g. no c=
onsole prompt is displayed.
  A detailed analysis is contained in LP #2133188.
 =20
  A proper implementation of the missing IOCTLs will include:
 =20
  Functions:
 =20
  in linux-user/syscall.c:
  host_to_target_termios2()
  target_to_host_termios2()
  print_termios2()
 =20
  Definitions:
 =20
  in linux-user/syscall.c
  #define termios2 host_termios2
 =20
  in linux-user/syscall_types.h
  STRUCT_SPECIAL(termios2)
 =20
  in linux-user/ioctls.h:
  IOCTL(TCGETS2, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETS2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETSF2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
  IOCTL(TCSETSW2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
 =20
  in linux-user/user-internals.h:
  void print_termios2(void *arg);

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
  In Progress
Status in qemu source package in Plucky:
  Won't Fix
Status in qemu source package in Questing:
  In Progress
Status in qemu source package in Resolute:
  Fix Released

Bug description:
  [ Impact ]

  Terminal prompt is missing for multiarch containers with qemu-user

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
  818154cda96d: Pull complete=20
  352b2c3faa58: Download complete=20
  Digest: sha256:c4a8d5503dfb2a3eb8ab5f807da5bc69a85730fb49b5cfca2330194ebc=
c41c7b
  Status: Downloaded newer image for ubuntu:24.04
  root@bf8124075385:/#=20


  [ Where problems could occur ]

  The fix is around the termios managament so regressions can happen
  there.

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


