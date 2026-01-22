Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD2DD3EE84
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 16:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vixfX-0003Nv-5M; Thu, 22 Jan 2026 11:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vixef-00035Y-AI
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:35:40 -0500
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vixeb-0003LU-CI
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:35:32 -0500
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 1AB4942793
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1769099727;
 bh=hWSqtcuIaRYzrHAgW7XtfT+nf48V01wLOp6Ux7IyhTs=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=gt+cjBZTthC9+g8f7ioUUTkF/0Ohx1WDy9lQPsvP+HoMqXC8JQ3B5Hq/WFO+Fu9fF
 f8eR16/7eMS5RIOfIxKWRDm+x7kcdOdQRVIuADvrJcgllX8uhKEezvp88xOx54bEIM
 BY/nWDiZzLIaiAYLAvv1eGa+Rg70PA1/6J1m5bA/ipyIpx3PU82FXkyA2Qddscpr+v
 3ZXFh3i9Rr59OiV3C5rZLwrxAfFQhBs1wYx4GO3LJXVmqrPt/KLBGPEWOrPRnVarsw
 rOjo7V6X7e75xuG1rOVvWUFq3xLced6tIvH1m+TpK4XYpwPRhNYtCNLgDwEL36HsFw
 Qbvhtj0jCGE8Q==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 0ECBE7E6FC
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 16:35:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jan 2026 16:27:29 -0000
From: Marc Deslauriers <2138885@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Unknown;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Fix Released; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=trusty; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Low; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=xenial; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Low; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=bionic; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Low; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=focal; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Low; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=jammy; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Low; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=noble; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Low; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=questing; sourcepackage=qemu;
 component=main; status=Fix Released; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=resolute; sourcepackage=qemu;
 component=main; status=Fix Released; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public Security
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: yes
X-Launchpad-Bug-Commenters: mdeslaur pmaydell
X-Launchpad-Bug-Reporter: Marc Deslauriers (mdeslaur)
X-Launchpad-Bug-Modifier: Marc Deslauriers (mdeslaur)
References: <176909579593.2793718.4382485579874417264.malonedeb@juju-98d295-prod-launchpad-7>
Message-Id: <176909925022.3101951.7843247290015979735.launchpad@juju-98d295-prod-launchpad-3>
Subject: [Bug 2138885] Re: iret security issue
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="9fcfff1971229ac997140f06b41a902ac8ec69f4";
 Instance="launchpad-scripts"
X-Launchpad-Hash: c0b7ac58b07e7c45149063e2aaa9841c07164994
Received-SPF: pass client-ip=185.125.188.250;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-0.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Bug 2138885 <2138885@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

** Changed in: qemu (Ubuntu Trusty)
   Importance: Undecided =3D> Low

** Changed in: qemu (Ubuntu Trusty)
       Status: New =3D> Confirmed

** Changed in: qemu (Ubuntu Xenial)
   Importance: Undecided =3D> Low

** Changed in: qemu (Ubuntu Xenial)
       Status: New =3D> Confirmed

** Changed in: qemu (Ubuntu Bionic)
   Importance: Undecided =3D> Low

** Changed in: qemu (Ubuntu Bionic)
       Status: New =3D> Confirmed

** Changed in: qemu (Ubuntu Focal)
   Importance: Undecided =3D> Low

** Changed in: qemu (Ubuntu Focal)
       Status: New =3D> Confirmed

** Changed in: qemu (Ubuntu Jammy)
   Importance: Undecided =3D> Low

** Changed in: qemu (Ubuntu Jammy)
       Status: New =3D> Confirmed

** Changed in: qemu (Ubuntu Noble)
   Importance: Undecided =3D> Low

** Changed in: qemu (Ubuntu Noble)
       Status: New =3D> Confirmed

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2138885

Title:
  iret issue in TCG

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Trusty:
  Confirmed
Status in qemu source package in Xenial:
  Confirmed
Status in qemu source package in Bionic:
  Confirmed
Status in qemu source package in Focal:
  Confirmed
Status in qemu source package in Jammy:
  Confirmed
Status in qemu source package in Noble:
  Confirmed
Status in qemu source package in Questing:
  Fix Released
Status in qemu source package in Resolute:
  Fix Released

Bug description:
  iret security issue. See here:

  https://kqx.io/post/qemu-nday/

  Upstream fix:
  https://gitlab.com/qemu-project/qemu/-/commit/0bd385e7e3c33e987d7a8879918=
be6df7b111ac4

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/2138885/+subscriptions


