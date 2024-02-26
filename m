Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377C8C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVDQ-0002m5-A9; Mon, 26 Feb 2024 02:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1reVDN-0002lF-RS
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:15:53 -0500
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1reVDL-0006x9-9b
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:15:53 -0500
Received: from juju-98d295-prod-launchpad-16.localdomain (scripts.lp.internal
 [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 10FCF3FECD
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 07:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1708931735;
 bh=eR3T/Y2S7UVwhVQr4klY6hF0KOo5xvmb6gaFaXWneTQ=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=GzWeIW73DPr2AOWWLHZITmUAYEsEwuPf8nn4Ht/983qEx3TEObmf4Cz5HnG+pDhRG
 nCsvChvnl2CnmZlhBZguVLtupyH9OnP927sjCxDJA7q/AJd5fCaxg2BuVCTRwQ6WIk
 SbVntxMyHVsxe4hnHLKmFtRWV0r0EUzrzdmxvPGWuT1Ym9dTY/gTtQMIkMldu5tjsI
 t0LlLNRlaZLsXLTS7gnvVPzPj14IEQxZ8O8pfjb1Ng9/y2JpHfQmeFy6UQ+dLIkvY3
 +WylLVHoe6dvGrO5JhJLG2ni20/wxGwctz6QLXcaaF2tjtEEnjhJwV8VY7zR3GRM3k
 J5dNioctQ1xqQ==
Received: from [10.131.215.246] (localhost [127.0.0.1])
 by juju-98d295-prod-launchpad-16.localdomain (Postfix) with ESMTP id
 1213F7EBB5
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 07:15:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Feb 2024 07:07:15 -0000
From: Frank Heimes <2055003@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=ubuntu-power-systems; status=New; importance=High;
 assignee=ubuntu-power-triage; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=New; importance=High; assignee=None; 
X-Launchpad-Bug-Tags: architecture-ppc64le bugnameltc-205716 severity-high
 targetmilestone-inin---
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bugproxy
X-Launchpad-Bug-Reporter: bugproxy (bugproxy)
X-Launchpad-Bug-Modifier: Frank Heimes (fheimes)
References: <170892838434.1980782.6845327796296448659.malonedeb@juju-98d295-prod-launchpad-2>
Message-Id: <170893123576.2032717.4916109193103177062.launchpad@juju-98d295-prod-launchpad-2>
Subject: [Bug 2055003] Re: Qemu cmdline core dumped with more(8193 or more)
 cpus
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="9643586c585856148a18782148972ae9c1179d06";
 Instance="launchpad-scripts"
X-Launchpad-Hash: b4af5b44f255940bee8553a3eca2f3da00be2b66
Received-SPF: pass client-ip=185.125.188.251;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-1.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Bug 2055003 <2055003@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

** Also affects: qemu
   Importance: Undecided
       Status: New

** No longer affects: qemu

** Also affects: ubuntu-power-systems
   Importance: Undecided
       Status: New

** Changed in: ubuntu-power-systems
     Assignee: (unassigned) =3D> Ubuntu on IBM Power Systems Bug Triage (ub=
untu-power-triage)

** Changed in: qemu (Ubuntu)
     Assignee: Ubuntu on IBM Power Systems Bug Triage (ubuntu-power-triage)=
 =3D> (unassigned)

** Changed in: ubuntu-power-systems
   Importance: Undecided =3D> High

** Changed in: qemu (Ubuntu)
   Importance: Undecided =3D> High

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2055003

Title:
  Qemu cmdline core dumped with more(8193 or more) cpus

Status in The Ubuntu-power-systems project:
  New
Status in qemu package in Ubuntu:
  New

Bug description:
  ---Debugger---
  A debugger is not configured
  =20
  ---Steps to Reproduce---
  =20
  ---Problem Description---
   Qemu cmdline core dumped with more(8193 or more) cpus
  =20
  ---Debugger---
  A debugger is not configured
  =20
  ---Steps to Reproduce---
   Qemu cmdline core dumped when more number of CPUs were given.

 =20
  [root@ltcmihawk39 ~]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=3D9000
  **
  ERROR:../tcg/region.c:782:tcg_region_init: assertion failed: (region_size=
 >=3D 2 * page_size)
  Bail out! ERROR:../tcg/region.c:782:tcg_region_init: assertion failed: (r=
egion_size >=3D 2 * page_size)
  Aborted (core dumped)

  Expected Result:
  Warning message like "Number of cpus requested exceeds the cpus supported"

  Actual Result:
  core dumped

  Steps to Reproduce:
  --------------------

  1. Clone the upstream qemu from https://gitlab.com/qemu-project/qemu.git
  2. Compile qemu with below steps.
      cd qemu/
      git submodule init
      git submodule update --recursive
      ./configure --target-list=3Dppc64-softmmu --prefix=3D/usr
      make
      make install
  3. set maxcpus=3D8193 or more

 =20
  [root@ltcmihawk39 ~]# qemu-system-ppc64 --version
  QEMU emulator version 8.0.94 (v8.1.0-rc4)
  Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers

  NOTE: This behavior is observed only when qemu is built without disabling=
 the tcg.
  =20
  Contact Information =3D sthoufee@in.ibm.com=20
  =20
  Machine Type =3D x=20
  =20
  ---uname output---
  x

  Action needed

  Our IBM Dev want to include this patch in latest Canonical distro.

  Need the distro to review and integrate fixes provided by IBM

  https://github.com/qemu/qemu/commit/c4f91d7b7be76c47015521ab0109c6e998a36=
9b0

  Need to include this commit in latest Canonical distro.

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu-power-systems/+bug/2055003/+subscriptions


