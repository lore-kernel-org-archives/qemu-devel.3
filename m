Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1EAC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 18:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2YqU-0006Wj-Du; Fri, 04 Sep 2026 14:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1x2YqR-0006WW-OL
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 14:40:59 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1x2YqO-0006wg-Pz
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 14:40:59 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 1EB6C41579
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2026 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1788547253;
 bh=uoI52og40fV4zCR/84AOL718ncNsejXnN0Bz3/O0lco=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=rG6ZGMI/Q+2OBHKadhmimI2z33QoXA6NunxvEBozLyk+/LaAVjCRxVQFdZ3vkhCYd
 xDnIX5NPyB4e1dPuegTb1N4Z/4x8NEKTWKR4+mbLifEyPJ1BOpw5ckm4hG6D68vHms
 5lQaEK7CJfy5/w311rZSVZP0KxIx+PH8rzVDhgHtCfXA+5hJDxmo0Rbe1tHhqoL2Ag
 upqUBUeSQAg5uSXywq8QvI0mOvPTxHpDVD20I7rgeofGsxrHng38z+lxjkjnjzx13y
 3NfbQ7a91B2DjKIaAuOFD7QlN/gWzJgWztX6fhEqWqvmUSqReqPdOKpc3lf5Jn6dXh
 0ZxjS7HsIz8zw==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id CBFD27E55C
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2026 18:40:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 18:30:22 -0000
From: Benjamin Wheeler <2166076@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=linux; component=main;
 status=Invalid; importance=Undecided; assignee=benjamin.wheeler@canonical.com;
X-Launchpad-Bug-Tags: kernel-daily-bug
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: benjaminwheeler kim-naru
X-Launchpad-Bug-Reporter: Kim Naru (kim-naru)
X-Launchpad-Bug-Modifier: Benjamin Wheeler (benjaminwheeler)
References: <178828093562.4133656.9431106140758891557.malonedeb@juju-98d295-prod-launchpad-54>
Message-Id: <178854662254.1801621.12341844661460663508.malone@juju-98d295-prod-launchpad-55>
Subject: [Bug 2166076] Re:  QEMU : ELIMINATION OF HYPERTRANSPORT MEMORY HOLE 
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b0097495a28d09c3303dbd078ca616792464b9f2";
 Instance="launchpad-scripts"
X-Launchpad-Hash: f1b357e8a0d48ba68439b540ab0dc2cf9708a350
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
Reply-To: Bug 2166076 <2166076@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Kim, thanks for submitting a bug report. It sounds like this is an
issue with qemu rather than the Ubuntu Linux kernel. Can you please open
a bug with upstream qemu? https://gitlab.com/qemu-
project/qemu/-/work_items

Thank you! Please let me know if I missed any information pertaining to
Ubuntu.

** Also affects: qemu
   Importance: Undecided
       Status: New

** Changed in: linux (Ubuntu)
       Status: New =3D> Invalid

** Changed in: linux (Ubuntu)
     Assignee: (unassigned) =3D> Benjamin Wheeler (benjaminwheeler)

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2166076

Title:
   QEMU : ELIMINATION OF HYPERTRANSPORT MEMORY HOLE

Status in QEMU:
  New
Status in linux package in Ubuntu:
  Invalid

Bug description:
  Historically, AMD processors reserved a=E2=80=AF1 TB memory hole=E2=80=AF=
in the
  physical address space around the 1 TB boundary (specifically from 1
  TB to ~ 2 TB). This reservation was a legacy requirement from
  the=E2=80=AFHyperTransport=E2=80=AFera to maintain compatibility with old=
er IOMMU (I/O
  Memory Management Unit) implementations that expected this address
  space to be reserved for I/O devices and memory-mapped I/O operations.

  ISSUE:

  This 1 TB hole meant that:

  Systems couldn't use physical memory addresses in that range for
  actual DRAM

  With large memory configurations (approaching/exceeding 1 TB), this
  created inefficiencies in memory mapping

  It limited the contiguous addressable memory space available to the OS
  and applications

  The reservation was maintained for legacy compatibility.

  SOLUTION:=20
  Starting with=E2=80=AFEPYC 9005 (Turin), AMD introduced the ability to=E2=
=80=AFeliminate this legacy 1 TB IOMMU/HyperTransport memory hole. This fea=
ture:=20

  Reclaims the 1 TB address space=E2=80=AFpreviously reserved for legacy
  compatibility

  Allows systems to use=E2=80=AFmore contiguous physical memory addressing

  Improves memory efficiency for large-memory configurations

  Is controlled via BIOS/firmware settings

  Represents a clean break from HyperTransport-era constraints


  Pre-6.1 QEMU would report the host e820 to the guest. BUT QEMU did not
  detect if the hole was present or not. QEMU IOMMU emulation had
  assumptions about the hole. QEMU memory accounting didn=E2=80=99t properly
  handle both cases. When the hole was absent, QEMU's internal
  calculations were wrong.

 =20
                                          QEMU Pre-6.1	                  QE=
MU 6.1+
  Legacy (with hole) + No pass-through	Works as expected	          Works as=
 expected
  Legacy (with hole) + with pass-through	Works as expected	          Works =
as expected
  Modern (no hole) + No pass-through	Memory in the hole is STRANDED	  Works=
 as expected
  Modern (no hole) + with pass-through	DMA to wrong memory system crash  Wo=
rks as expected

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/2166076/+subscriptions


