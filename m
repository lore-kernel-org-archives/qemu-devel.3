Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7609CD3420
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 09:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slQ6J-0008Kq-Dh; Tue, 03 Sep 2024 05:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1slQ6E-0008Ik-R3
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 05:45:22 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1slQ6D-0005uj-7K
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 05:45:22 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id DCC1340F70
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2024 09:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1725356719;
 bh=FpJkSeFYGuWtgrrS7c7ed16368W6UNK1OoE9sx3NQfQ=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=GdlOBvzFc6Y8rM0RJ762KgwBD/NQe0nFmnuN4jOP/X3PC5YqX4e6JW+CVGqIwiQcz
 2K+2jhBlwWFp6gP/bPCDNWTYG+DSjUrdX9YiyUJLGcR9NlAmdmADa8ICqpo5IF6/Lf
 x0xLLWs8OaWjaoEyRaGnnI7Befs1iodm8mjUi2mO1HgClGIPaABjccbnk7bCIIAe36
 KxfdqvwB54/dyK0jg5d0/eNqY6auPZgC4PA664vp18snEQAWpK6WSnP+CBs8CIFO6E
 4In/3LNmKfJynFh+LsOpdf/yl9YWDWOciOVkD6tEn117kCtdkJ3967PV/8Qn/ExTbM
 WjX+Wyn3dQUeQ==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id D21B07E088
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2024 09:45:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Sep 2024 09:37:16 -0000
From: Thomas Huth <2078790@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=linux-lowlatency-hwe-6.8;
 component=main; status=New; importance=Undecided;
 assignee=mehmet.basaran@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mehmetbasaran
X-Launchpad-Bug-Reporter: Mehmet Basaran (mehmetbasaran)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <172535521411.2600491.6207708752026464339.malonedeb@juju-98d295-prod-launchpad-3>
Message-Id: <172535623812.505620.5354836599527749586.launchpad@juju-98d295-prod-launchpad-4>
Subject: [Bug 2078790] Re: jammy qemu x86 int3: 0000 [#1] SMP NOPTI 
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1b1ed1ad2dbfc71ee62b5c5491c975135a771bf0";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 49bef7c4b9af54dac5264e67aedaa5dfb0c314a5
Received-SPF: pass client-ip=185.125.188.251;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-1.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Bug 2078790 <2078790@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

** Project changed: qemu =3D> qemu (Ubuntu)

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2078790

Title:
  jammy qemu x86 int3: 0000 [#1] SMP NOPTI

Status in linux-lowlatency-hwe-6.8 package in Ubuntu:
  New
Status in qemu package in Ubuntu:
  New

Bug description:
  jammy:linux-lowlatency-hwe-6.8 6.8.0-44.44.1~22.04.1 qemu-x86 QEMU
  Standard PC (i440FX + PIIX, 1996)

 =20
  Recently (2024.08.05), I have been seeing this issue with ADT:systemd:ups=
tream-1/2 test in which kernel panics/prints a stack. I have seen this with=
 jammy:linux-lowlatency-hwe-6.8 and jammy:linux-ibm-6.8. Stack trace is dif=
ferent everytime because kernel receives an interrupt, drop what it is doin=
g, and crash when handling the interrupt.

  I think this is an issue with qemu and not kernel. For jammy, we are
  using qemu 6.2 and there are some fixes related to x86 interrupt
  handling in 8.x
  (https://lore.kernel.org/lkml/20230705215008.GD17440@redhat.com/T/). I
  propose we create a launchpad bug and trace the issue. If I am
  correct, we shouldn't see this in noble. And we should occasionally
  see this in 5.15 jammy kernels (and more frequently with lowlantecy
  kernels).

 =20
  Meanwhile see comments below for some stack traces;

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/linux-lowlatency-hwe-6.8/+bug/207=
8790/+subscriptions


