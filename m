Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEE5C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 16:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTP23-0002Qj-0v; Fri, 26 Jan 2024 11:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rTP21-0002Qa-R2
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 11:26:17 -0500
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rTP1z-0001J0-Ml
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 11:26:17 -0500
Received: from juju-98d295-prod-launchpad-16.localdomain (scripts.lp.internal
 [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id F3B4640CBC
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 16:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1706286362;
 bh=rhPgogWQWZ/1I2W2mTJ2pNYUdzQAL3aIhxecxrq6+38=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=LB+1r66YaSfb1/cI9UMjYOWVz2L8Gva0g0+XuXBYPkrj1/5kZeVMNOcdsGmRXk99A
 w32ToW6d+SM34b4+spMhdR+Hy0vBbMrLsjUEqvzUzdNyU0afyhBkUbWZSTAeEAwEct
 7TG4D+0LpjYNVYglMiwnAvCniIp+lR1/pcF+chgMB43dSPl/pQdEw4AlAu80U8VsIY
 qJHu5RwrX3uz3/fTN8X/zWqYVGvYt8emFlOR9y8MkVywsanT0G9NW+z7S+DC9veYKQ
 515ALDhHeF1wdPC/D5PbNTeWZFYy8tzefm9Mt40tIzgOalmObztLtpoQrHEUUHdCRA
 2PLXA2e48ljNg==
Received: from [10.131.215.246] (localhost [127.0.0.1])
 by juju-98d295-prod-launchpad-16.localdomain (Postfix) with ESMTP id
 CCC9E83A77
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 16:25:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jan 2024 16:15:45 -0000
From: Thomas Huth <1225187@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jacob11 janitor kavsrf pmaydell th-huth
X-Launchpad-Bug-Reporter: alex (kavsrf)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20130913204828.19236.78809.malonedeb@soybean.canonical.com>
Message-Id: <170628574656.1729218.2163941051890796556.launchpad@juju-98d295-prod-launchpad-7>
Subject: [Bug 1225187] Re: qemu hangs in windows 7 host with -serial
 pipe:windbg
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="666c6bd52ccc7c38c7d6806b807b117caa7d8b6e";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 31c5129764160885bbd9c2e932fb8f719837df80
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
Reply-To: Bug 1225187 <1225187@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

** Changed in: qemu
       Status: New =3D> Invalid

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1225187

Title:
  qemu hangs in windows 7 host with -serial pipe:windbg

Status in QEMU:
  Invalid

Bug description:
  Execution line:
  qemu-system-i386.exe -m 512 c:\Disks\Qemu_XP_en.vhd  -serial pipe:windbg

  It waits for the pipe.
  Execute windbg
  c:\WINDDK\7600.16385.1\Debuggers\windbg.exe -k com:pipe,port=3D\\.\pipe\w=
indbg,resets=3D0,reconnect

  GUI black screen shown. QEMU hangs.

  qemu v1.5.3 (c0b1a7e207094dba0b37a892b41fe4cab3195e44). MinGW built.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1225187/+subscriptions


