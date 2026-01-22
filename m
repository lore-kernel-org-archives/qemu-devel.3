Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F833D3EE8A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 16:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vixLS-0004DY-Le; Thu, 22 Jan 2026 11:15:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vixLJ-0004BR-Sn
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:15:34 -0500
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vixLD-0005hU-LE
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:15:30 -0500
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 857E142EAE
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1769098525;
 bh=H2cZR8lm0Nansh1UpyFbzSySVAMl1V7lEZZ9RWu3fLw=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=NeO7NasAA0IPnmUGd8dOTdyziEW9WGGNREovmFQFmFs+nLB4ayaAMaY5feyBWXIAV
 bRyHWd1xUCbJQCfqnA2ERIDV6gUk4OIVOMaMvRki/4FWYl9OFIAdenr/xaAOhKynXU
 ZLh1zkYK4nngxR2NebZsB+30dwzSzeNgfwksUUxCecEro87xqqf6MpSR+9JTyvG382
 tr6kZ45sfFgjErZ4/g4Z4NpzUDiKYtfkrluE6DU1UleUPM6//IWSXCYR+9dA7AQjKb
 MdxrWbvvND3ISQQ+eFvVtssx5pre1x91V1yPG6hH5HJFn47XzbtedlfMGczvVNf/YJ
 19mNPz4DMjwQQ==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 6AFB37E6DD
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 16:15:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jan 2026 16:09:33 -0000
From: Marc Deslauriers <2138885@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Unknown;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Fix Released; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=trusty; sourcepackage=qemu;
 component=main; status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=xenial; sourcepackage=qemu;
 component=main; status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=bionic; sourcepackage=qemu;
 component=main; status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=focal; sourcepackage=qemu;
 component=main; status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=jammy; sourcepackage=qemu;
 component=main; status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=noble; sourcepackage=qemu;
 component=main; status=New; importance=Undecided; assignee=None; 
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
Message-Id: <176909817365.3080590.18054676076935257251.malone@juju-98d295-prod-launchpad-2>
Subject: [Bug 2138885] Re: iret security issue
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="9fcfff1971229ac997140f06b41a902ac8ec69f4";
 Instance="launchpad-scripts"
X-Launchpad-Hash: c9b24109826750bd8a6b7fe984073716b9da577f
Received-SPF: pass client-ip=185.125.188.251;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-1.canonical.com
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

Thanks for the insight @pmaydell, much appreciated!

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2138885

Title:
  iret security issue

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Trusty:
  New
Status in qemu source package in Xenial:
  New
Status in qemu source package in Bionic:
  New
Status in qemu source package in Focal:
  New
Status in qemu source package in Jammy:
  New
Status in qemu source package in Noble:
  New
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


