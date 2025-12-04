Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3E2D1D878
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 07:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR3Kc-0005VT-Na; Thu, 04 Dec 2025 02:00:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vR3KW-0005OQ-Qt
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:00:46 -0500
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vR3KU-0006qW-HV
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:00:44 -0500
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 3A8F4420D5
 for <qemu-devel@nongnu.org>; Thu,  4 Dec 2025 07:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1764831640;
 bh=lAtIMecCPC/wiLJDQ2/ZintJ28g1w9B7yiJFdnhH95Y=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=Jeqtnax97p+pJAj/62F5t8w09qL8HUlmAFLCjRsS5RizMs3C+UqDKGYzsM33nUulM
 CnO3lNmlSxFAVLu4unfnFDW1jJa8dS8gftRjcagNLHsyDS+WWrDFYj0FJ+Hor87VBC
 4Z+h6kZWbzLwIvgUz6zYSBALGAEIXVjkbxntAxvcifZrbwVI5vRQHdVgPXrJhqvH45
 YjtWncUf50JuZIXtJ24LQzR4Wze3MbVmeZ3swWiD5zXX78yoXgqe6dlVB6fiX8wz3S
 5fnOxq7Xs3W+LA5IMRWjw9twuCS//AVow2t/owV7sBE3XZWbvj4g3KnBL6Rh27T9wl
 BU28YoKEWKi/g==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 26EFE7F813
 for <qemu-devel@nongnu.org>; Thu,  4 Dec 2025 07:00:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Dec 2025 06:51:30 -0000
From: Christian Ehrhardt <2133804@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Unknown; importance=Unknown;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 milestone=ubuntu-26.04; status=Confirmed; importance=High; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=jammy; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Low; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=noble; sourcepackage=qemu;
 component=main; status=Confirmed; importance=High; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=plucky; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Medium; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=questing; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Medium; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=resolute; sourcepackage=qemu;
 component=main; milestone=ubuntu-26.04; status=Confirmed; importance=High;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: paelzer xypron
X-Launchpad-Bug-Reporter: Heinrich Schuchardt (xypron)
X-Launchpad-Bug-Modifier: Christian Ehrhardt (paelzer)
References: <176477927666.3767208.4954653462090539439.malonedeb@juju-98d295-prod-launchpad-3>
Message-Id: <176483109068.1060137.12863328826273380570.malone@juju-98d295-prod-launchpad-3>
Subject: [Bug 2133804] Re: QEMU does not emulate IOCTL TCGETS2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="379e22b8475e3402088a4cdb4a6e7936a4d28414";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 510ac863c9364fa7ad27a08ce8fd7b4a92c3b727
Received-SPF: pass client-ip=185.125.188.250;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-0.canonical.com
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
Reply-To: Bug 2133804 <2133804@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thanks for the report,
we need to add that indeed the moment we have something reliable by upstream
I've added the upstream bug tracker https://gitlab.com/qemu-project/qemu/-/=
issues/3065

Implementation looks like being worked on since
https://mail.gnu.org/archive/html/qemu-devel/2025-08/msg04984.html

With iterations on feedback and fixes like
https://mail.gnu.org/archive/html/qemu-devel/2025-10/msg08521.html
https://mail.gnu.org/archive/html/qemu-devel/2025-11/msg00043.html

Recently got some more attention by us and Fedora picking up and seeing the=
 same
https://mail.gnu.org/archive/html/qemu-devel/2025-12/msg00468.html

@Heinrich
do you think we need to rush glossing over it by using the incomplete versi=
ons in resolute until the final one is out. No risc there yet, but this isn=
't exclusive to risc - that is just more common to run emulated.
Or can we wait until they have it finalized (either way before resolute rel=
ease we should have it in R but also in SRU that we expect to run resolute =
binaries.

** Bug watch added: gitlab.com/qemu-project/qemu/-/issues #3065
   https://gitlab.com/qemu-project/qemu/-/issues/3065

** Also affects: qemu via
   https://gitlab.com/qemu-project/qemu/-/issues/3065
   Importance: Unknown
       Status: Unknown

** Also affects: qemu (Ubuntu Noble)
   Importance: Undecided
       Status: New

** Also affects: qemu (Ubuntu Resolute)
   Importance: High
       Status: Confirmed

** Also affects: qemu (Ubuntu Jammy)
   Importance: Undecided
       Status: New

** Also affects: qemu (Ubuntu Plucky)
   Importance: Undecided
       Status: New

** Also affects: qemu (Ubuntu Questing)
   Importance: Undecided
       Status: New

** Changed in: qemu (Ubuntu Questing)
       Status: New =3D> Confirmed

** Changed in: qemu (Ubuntu Plucky)
       Status: New =3D> Confirmed

** Changed in: qemu (Ubuntu Noble)
       Status: New =3D> Confirmed

** Changed in: qemu (Ubuntu Jammy)
       Status: New =3D> Confirmed

** Changed in: qemu (Ubuntu Questing)
   Importance: Undecided =3D> Medium

** Changed in: qemu (Ubuntu Plucky)
   Importance: Undecided =3D> Medium

** Changed in: qemu (Ubuntu Noble)
   Importance: Undecided =3D> High

** Changed in: qemu (Ubuntu Jammy)
   Importance: Undecided =3D> Low

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2133804

Title:
  QEMU does not emulate IOCTL TCGETS2

Status in QEMU:
  Unknown
Status in qemu package in Ubuntu:
  Confirmed
Status in qemu source package in Jammy:
  Confirmed
Status in qemu source package in Noble:
  Confirmed
Status in qemu source package in Plucky:
  Confirmed
Status in qemu source package in Questing:
  Confirmed
Status in qemu source package in Resolute:
  Confirmed

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


