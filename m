Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FB1C25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 04:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDcTI-000393-Oa; Sun, 02 Jun 2024 00:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1sDcTG-00038M-4c
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 00:05:26 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1sDcTD-0003hD-RD
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 00:05:25 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 88A7740A99
 for <qemu-devel@nongnu.org>; Sun,  2 Jun 2024 04:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1717301120;
 bh=gRyINlJt0eQJr0tv/c2kf1Ycpb1VkEcb4khaLfzWeJI=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=lTp4x+LTsw9/hWa9pE+9h6vcdA3rKEo2nxwOEhv9CkR4L6vOeLqJY40wwrqprz4Px
 Zsa1t3kG4Cz238CIM99FYta+LpTzMMHC4l8v/D08kl7Vx+uVO86lLx5sq2aqYjgLai
 VcKYHLVe26pXVDdh6HmOKtZSTkO3HYox6x5cUM8x7klbiF2m6IIx5eBc1ILPrUC7Zp
 s9lseBeFnZ68k9NR/SI9JRk/PF0mhopnyOJUXlPRoPe90e3mUAb2QHuA+J+sGw8VVa
 08BD/Gg/0EuPIsNRspSZBTyGdy5rLSbVV0VTHNlXMvCiLWjNIV2Swljp/gi8RHxvqM
 HQWSrZu5Y5tCQ==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 7AA207E16C
 for <qemu-devel@nongnu.org>; Sun,  2 Jun 2024 04:05:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Jun 2024 04:00:12 -0000
From: Anchal Nigam <1524546@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: elayeek imthenachoman suro-patz xanclic
X-Launchpad-Bug-Reporter: Surojit Pathak (suro-patz)
X-Launchpad-Bug-Modifier: Anchal Nigam (imthenachoman)
References: <20151209233416.12733.38134.malonedeb@chaenomeles.canonical.com>
Message-Id: <171730081281.238888.11761430576924164585.malone@juju-98d295-prod-launchpad-4>
Subject: [Bug 1524546] Re: qemu-img rebase error message mentions wrong file
 name
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a60fb269857abd7169036a2da5afd37a6a1d41e8";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 80e325f475ce7ba136ccaf1358f125c489e2347b
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
Reply-To: Bug 1524546 <1524546@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

What to do if the old file has been moved?

Say the backing file was /path/to/os.qcow2 and it was moved to
/new/path/to/os.qcow2.

How can we tell snapshot.qcow2 to update the backing file from
/path/to/os.qcow2 to /new/path/to/os.qcow2?

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1524546

Title:
  qemu-img rebase error message mentions wrong file name

Status in QEMU:
  Fix Released

Bug description:
  While doing 'qemu-img rebase' for linking to a different backing file, if=
 the old backing file does not exist, the command fails. During this failur=
e, the error message shown is misleading.
  e.g. qemu-img rebase -b <backing_file> <filename> throws error saying "Co=
uld not open <filename>"
  Ideally it should "Could not open <old_backing_file>"

  snippet -
  [root@oxy-dev ~]# qemu-img info /opt/stack/data/nova/instances/94864a64-e=
bf8-45e6-a777-615921216a0a/disk
  image: /opt/stack/data/nova/instances/94864a64-ebf8-45e6-a777-615921216a0=
a/disk
  file format: qcow2
  virtual size: 20G (21474836480 bytes)
  disk size: 174M
  cluster_size: 65536
  backing file: /tmp/3559241a79b79ae663ec6e3d9b75d469967b383b
  Format specific information:
      compat: 1.1
      lazy refcounts: false
  [root@oxy-dev ~]# mv /tmp/3559241a79b79ae663ec6e3d9b75d469967b383b /tmp/3=
559241a79b79ae663ec6e3d9b75d469967b383a
  [root@oxy-dev ~]# file !$
  file /tmp/3559241a79b79ae663ec6e3d9b75d469967b383a
  /tmp/3559241a79b79ae663ec6e3d9b75d469967b383a: x86 boot sector; partition=
 1: ID=3D0x83, active, starthead 32, startsector 2048, 409600 sectors; part=
ition 2: ID=3D0x8e, starthead 159, startsector 411648, 16365568 sectors, co=
de offset 0xc0
  [root@oxy-dev ~]# file /tmp/3559241a79b79ae663ec6e3d9b75d469967b383b
  /tmp/3559241a79b79ae663ec6e3d9b75d469967b383b: cannot open (No such file =
or directory)
  [root@oxy-dev ~]# qemu-img rebase -b /tmp/3559241a79b79ae663ec6e3d9b75d46=
9967b383a /opt/stack/data/nova/instances/94864a64-ebf8-45e6-a777-615921216a=
0a/disk
  qemu-img: Could not open '/opt/stack/data/nova/instances/94864a64-ebf8-45=
e6-a777-615921216a0a/disk': Could not open file: No such file or directory
  [root@oxy-dev ~]#=20
  qemu-img version 1.5.3
  OS: RHEL7 - 3.10.0-229
  libvirtd (libvirt) 1.2.8

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1524546/+subscriptions


