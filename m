Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37044CD8C88
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 19:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVx4P-00063B-LR; Sat, 06 Jun 2026 15:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wVx4O-00062f-79
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 15:52:36 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wVx4M-000131-4O
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 15:52:35 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 976E87A006C;
 Sat,  6 Jun 2026 15:52:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sat, 06 Jun 2026 15:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm3; t=1780775551; x=1780861951; bh=P47msMU6ls
 bcpuXhi5xe7jpEQjy6sLQYPS84Jk9VLIA=; b=f5YlTO+jgUNKfcKluHWcli8iSm
 4SgqMXhGsbW4Rkp4SpU4QFmeguWoAa+gnUKFIrQGgRQnPbXU9qH6rvd1wlzOgHGK
 Z6fNkqsqS8Nwjo1YsZv2GJT7XA94WeoV88gx8u5Gc8yvT6P79wK3SKYOTGTSXXub
 8Hu7vQZUiJwa3LWiiY1xubtbpdLKmuhjc9eGa61un2sn+IOKAs60QhGWs69U36T8
 Oyp/wKammPTAR5KkXhkANjvEaK9iZB7UMTz41Gtxg9A8sFW1D3Tu6SGAUXitZB2w
 a99a5uMW0RLB3N0WMSZ0cLdKnYJY12WKK4EyMd2ZNy3i7cWAf4JzEFNXhmCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1780775551; x=1780861951; bh=P47msMU6lsbcpuXhi5xe7jpEQjy6sLQYPS8
 4Jk9VLIA=; b=fr2fgVv81dYSGI/DEF3LmTgQV0xX+NS9f2XCK4ttNQSDPzPoo5u
 FhJiCBvklHTxfKbIwqu3PcJqPVUmD6UJSbyk34zR6aY3BLMxXJt9vCSmFqL+/8W5
 DRaK5HM21yjd0q/y4rLv2OmLJM283haOI2pUG6RymnYcnKS5VAsaJVw5tBaaqzYr
 4ltDSg8LTakyNj8cRxDPRvWjE5N9UHx8jaky6gqciSMPLf9bSyEzqPo+DxNwIVg4
 zihLBNi7rR1sBkW0Bd61GOYlVc5a1p8eCrdWVUc97reo9Yf+cMsvmHtVnbxkUXF+
 H7ArTpcfw75zLfdsPIWra+bA93ypfV2yMKw==
X-ME-Sender: <xms:fnokakaV4UCckS2CBy40sbkxDZQzcFT4k2S7_KCa05mv2w_ii1_E2Q>
 <xme:fnokam1qg04KC7Mp_l-w8N4MQ2PoSf2zIJqXDOavikguaksNMyyWALXb7wpAS8SwR
 bniOhRbBSQsLn2Z3mJ0hzRKCBgqd7DeZKL98gt0YWrBatU2m2-dbF8>
X-ME-Received: <xmr:fnokasVGjFZ3Vyv5zhtvJhBSXzt_EsHVC5X2G7cnjkWBqIDVsCuHSoFph4p3>
X-ME-Proxy-Cause: dmFkZTE3+80MbO8Fzd2gkeUtn8BzK0LWNZoNMlx+NWxLzhhmkNNWTfpWBiCZ3e3J9piSMT
 f5J5kLmfk+WNV4nodLn2dAez4KaLVZMaPgK6jKfLkaVVPnedJqPlJEvwstSmi/uxNERgQZ
 iPqzdwifDU9QLK3Wvf/REpD/86wdLEmLN9mDEcNzZ/CzEddZy9zW5/u4KsRAf6u1fA1pHN
 GJV4tg0JvOVZDgwiNnwF0kdCpDJbHbtV9B+oy9DesHcI4zprzNAS0LQHPFzdJ79JMGtloW
 r+WyemQK11DxeL/CWylhBkleffBvByvreMSQMCXWIJsVdyjL2qDCCbT2DtJctHThRukRYR
 F8UUhmNm0aVcPXThcwDIuUo0jqDVvjaqDhE1ZEUaCkJfSAs4aSGK3nBxMW91M0lLQM3Zs5
 FLAdnzswtLSHasg+icWnOXSBnrwokFOOXnDSvfGtjzdla2qL/yREFRfNp6A0QpiHWJtC09
 NUGFmZi0R3J9aYtACIPrrebcMld1f2VD0lGKPjXh++EPQ6EqyA5do1yUcExc31+3Sn55Ie
 k3S+/BgBBu3U5g5iYhSM6laNUTom16FTWTZehd8VqhCnNcapewmpvq5kpRXmsWfgbSiljt
 yvqb2P09/cEPcX66zASvzUuGDRedz/ZOk9KvDql7HFCXujgA/L9oU1Q71luA
X-ME-Proxy: <xmx:fnokaoWjtd31HnBhlDxIpr0KsRayqAetNqho3C6VHdsW9qaMKQG01Q>
 <xmx:fnokajeZPRZW-gby2rsgIX8qLFY9sDFaZBnFIp2MC7PBXM4gVxkyRA>
 <xmx:fnokapUnJ8t9GewKf5hh6cykxV6AYq_M7ImqNjqe4f4f681ym2ytpA>
 <xmx:fnokakfCas5E35Ov9YXZh8mAF-f3D6ydRTcy6xmajMsdG1lxGBb3Cg>
 <xmx:f3okakDVZUwhh6zQh1zwWtXFNO8w_NN3R1Juv6Fp70AV8zn3NBhzvzdm>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jun 2026 15:52:30 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id e8e02cd4;
 Sat, 6 Jun 2026 19:52:29 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 0/7] ati-vga: CCE engine setup and PIO packet processing
Date: Sat,  6 Jun 2026 15:52:09 -0400
Message-ID: <20260606195216.2524314-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.155; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, FROM_SUSPICIOUS_NTLD_FP=1.999,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series implements CCE engine setup and PIO packet submission/processing
for the Rage 128 and Radeon. This forms the foundation for full CCE support
for both chips in the future.

CCE engine microcode loading is shared across Rage 128 and Radeon. Microcode
is stored but not executed in this series. Type-0/1/2 packets are handled by
fixed-function hardware and do not require microcode. Ring buffer (BM modes)
and Type 3 packet processing will follow in future series.

There are differences between CCE setup for Rage 128 and Radeon. Patch 2
introduces chip-specific register handlers. The packet processing itself in
patch 7 is reusable for both chips.

The plan for the next series is to tackle BM modes for Radeon. Differences
between the two chips start to become larger in the BM modes.

Hardware tests available at:
r128: https://codeberg.org/cjab/ati-tests/src/commit/1ec2dc95d4ed8d11504723b8298847af9b5be075/tests/r128/cce.c
r100: https://codeberg.org/cjab/ati-tests/src/commit/1ec2dc95d4ed8d11504723b8298847af9b5be075/tests/r100/cce.c

Tested on Rage 128 Pro Ultra (PCI 1002:5446) and
Radeon QY (RV100) (PCI 1002:5159).

Changes from v2:
- MM_INDEX and MM_DATA are not available through ati_reg_write
- Use ati_int.h header instead of creating a new one
- Drop PM4_STAT register implementation for now. It will be easier to more
  accurately implement with BM modes.
- Introduce chip-specific register handlers
- Combine PM4_BUFFER_CNTL and PM4_MICRO_CNTL patches
- Add CCE mode registers for r100
- PM4_MICROCODE_DATAH is one bit wider for r100
- Testing on r100 showed that GUI MMIO is not disabled in CCE mode. Now
  gated for r128 only.
- Small style fixes

Changes from v1:
- Rebased onto master (no longer depends on HOST_DATA series)

Chad Jablonski (7):
  ati-vga: Extract ati_reg_write() from ati_mm_write()
  ati-vga: Chip-specific register handlers
  ati-vga: Implement CCE microcode register handling
  ati-vga: Implement CCE mode registers for r128
  ati-vga: Implement CCE mode registers for r100
  ati-vga: Disable GUI engine MMIO writes when CCE enabled (r128 only)
  ati-vga: Process Type-0/1/2 CCE packets via PIO

 hw/display/ati.c        | 505 +++++++++++++++++++++++++++-------------
 hw/display/ati_cce.c    | 154 ++++++++++++
 hw/display/ati_int.h    |  73 ++++++
 hw/display/ati_regs.h   |  15 ++
 hw/display/meson.build  |   3 +-
 hw/display/trace-events |   9 +
 6 files changed, 598 insertions(+), 161 deletions(-)
 create mode 100644 hw/display/ati_cce.c

-- 
2.53.0


