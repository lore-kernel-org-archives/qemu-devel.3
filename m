Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592E8D4A5E2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 02:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgZoP-0005x5-6P; Thu, 15 Jan 2026 21:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZnx-0005qD-Dg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:22 -0500
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZnu-0002Pt-0O
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:17 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 022861D00077;
 Thu, 15 Jan 2026 21:43:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 15 Jan 2026 21:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1768531389; x=1768617789; bh=SXqKWJ0Hgy
 Zn/0akxlIlymdar4DsFeXHB6fw4/1Y8N0=; b=EGsQd77ls/QUx2nKu+noVUZWut
 rfx909wo9EOyTXANexwKPP3ld1xMdT5G5iQYfelehU/OUp/+BJP9PlbEoDFUXzZg
 lSX5o+m5QaEIONerJ1U6bD+1aXiWt7O7RVSTPEC4myRSU8hMvyRsQCMaV8Efh8Hm
 mflvVz9b6BTyYSaF2BD7YsMZI7nFW1ZwBHs5asqCmHcVUMzniXP9+4w3yKggiRqy
 moJaBoJhPWPreWWn+GluORqpC4X1AKrl2Rvuy2lCYE1l30ffcWPk/w8TKex3lhBi
 jWaS3CMIdzQWmIN6Ffd/ZORDWuaB7d7MOu/br+Eu/wk38tj3jNrPJt8t+5pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1768531389; x=1768617789; bh=SXqKWJ0HgyZn/0akxlIlymdar4DsFeXHB6f
 w4/1Y8N0=; b=HpSPaJGiULyDgtQLNSadBcuuRLrQBMbun3e7NY0Yq4wus/tI0o2
 9P9v4QE/V9GuvOfm8fvzrPy1OVzvJyOhFo+3kvwQo9kjbVNERgRejku95SVyiWti
 /uzDdcbmODlZK99bjbtQc+HYBGF4HG2g7+IQfB7IvcUC89NIgqETgGi293HkaCg+
 i73bHCIj4QQJWbNvp0K1wYGUqUdm4pMWxrZtGuQKFWDW+BqI8vualfWxAggbEXgl
 zlQZcAAxGvAP72Cwf4KSJ7imIA5aQwsrgIBgO+nQWQI7VXC2TTbiDMk+jwR1ScV7
 gc2OD1jbqbGSD4buAvTqmwvD5nB6ip0drOg==
X-ME-Sender: <xms:vKVpaSkFncjAdhVZgSDAb62Nsz7Qk7evbbSvummO1PCRHJvsN13enQ>
 <xme:vKVpaRQAHH-MyrxdMGMIqIjshYhMd6lhVPBFJqQS7gZQJwfg4quT1JGuZTrU8nS-4
 eoTWXqslOK3jHzXnBZ-L3uv_vCLigJ4tv26gSu8FGIPRvT6XDKFM0U>
X-ME-Received: <xmr:vKVpaeAI7OWNrIIEy1rBkouRB_Ij_iheHzlUBsfU_CYZQgvypeJ3IY6GR-jK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejjeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
 ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcu
 oegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhephfdtvd
 ehieevgefgteffheeigeehtdelvddvueeijeejvdeliefftedvffejtdeunecuffhomhgr
 ihhnpegtohguvggsvghrghdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
 grmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidpnhgspghr
 tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrlhgrthhonh
 esvghikhdrsghmvgdrhhhupdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhn
 uhdrohhrghdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihii
X-ME-Proxy: <xmx:vKVpaQSLw0waATSTfppW6ksEUhNzsY72owzLA9CeWA2JPTEhZRUXIA>
 <xmx:vKVpaUpEOWh1Onr1w3qveQdp3uNo6JkgDrdeHT4sIJzh97gszs8pGw>
 <xmx:vKVpaawQhv4kNbNiwVpDWG2hwAl0xRmJWQnQePFp5dq6ZfbNZ196cg>
 <xmx:vKVpaRKrcsaojBOTyhzL36LwUixsmoY5H2dH-VcyK0BoR4BR_7-gVQ>
 <xmx:vaVpaS85GiNCeO54sJorPfVcpLTiEPasOnvHmGhEAghTcmcJdMCmUOdh>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 21:43:08 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 67ab2568;
 Fri, 16 Jan 2026 02:43:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v5 00/12] ati-vga: Implement HOST_DATA transfers to enable
 X.org text rendering
Date: Thu, 15 Jan 2026 21:42:46 -0500
Message-ID: <20260116024258.1487173-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.151; envelope-from=chad@jablonski.xyz;
 helo=fout-b8-smtp.messagingengine.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.499,
 FROM_SUSPICIOUS_NTLD_FP=1.999, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This series implements HOST_DATA as a blit source enabling text rendering in
xterm under X.org with 2D acceleration.

The series builds up functionality incrementally:

* Patches   1-5:  Bug fixes and register implementations
* Patches   6-9:  Refactor of ati_2d_blt
* Patch      10:  Scissor clipping implementation
* Patches 11-12:  HOST_DATA register writes, color expansion, and
                  accumulator flush

Tested with xterm on X.org using the r128 driver built with
--disable-dri (MMIO mode).

Hardware tests can be found at:
https://codeberg.org/cjab/ati-tests/src/branch/main/tests/host_data.c

Changes from v4:
- Refactored ati_2d_blt to accept src and dst state
- Implemented host_data blits on top of the refactored ati_2d_blt
  (suggested by Zoltan)
- Dropped separate field storage for DP_DATATYPE/DP_MIX (per Zoltan)

Changes from v3:
- New patch 1 fixing DP_DATATYPE/MIX register aliasing, this supersedes old patch 5
- Fix MSB/LSB HOST_DATA bit ordering, it is per-byte rather than per-word
- Fixed a missing break in register write handler
- Squashed and reorganized the dst/scissor helper patches (per Zoltan)
- Simplified register field constants and increment logic (per Zoltan)
- Tested with MorphOS and TVPaint (opaque bitmap fonts now work)

Changes from v2:
- Verified with hardware that clipping default bit latches
- Verified with hardware that pitch/offset default bits latch
  (supersedes Zoltan's "ati-vga: Separate default control bit for
  source")
- A new approach to HOST_DATA using a 128-bit accumulator instead of a
  large buffer
- Fixed a longstanding bug in (DST/SRC)_PITCH reads that zeroed pitch value.
- Removed mask from the DP_GUI_MASTER_CNTL write, all fields are
  important
- Created helpers for code shared between ati_2d_blt and
  ati_host_data_flush

Changes from v1:
- Split monolithic patch into 7 logical patches as requested
- Integrate HOST_DATA blit into existing ati_2d_blt()
- Add fallback implementation for non-pixman builds
- Remove unnecessary initialization in realize (kept in reset only)
- Fixed DP_GUI_MASTER_CNTL mask to preserve GMC_SRC_SOURCE field
- Implement scissor clipping

Chad Jablonski (12):
  ati-vga: Fix DST_PITCH and SRC_PITCH reads
  ati-vga: Read aliased values from DP_GUI_MASTER_CNTL
  ati-vga: Latch src and dst pitch and offset on master_cntl default
  ati-vga: Implement foreground and background color register writes
  ati-vga: Add scissor clipping register support
  ati-vga: Create setup_2d_blt_dst helper
  ati-vga: Create and use ATIBltSrc struct
  ati-vga: Consolidate set dirty and dst update
  ati-vga: Add internal ati_2d_do_blt accepting src and dst
  ati-vga: Implement scissor rectangle clipping for 2D operations
  ati-vga: Implement HOST_DATA register writes
  ati-vga: Implement HOST_DATA flush to VRAM

 hw/display/ati.c      | 138 +++++++++++++++-
 hw/display/ati_2d.c   | 369 +++++++++++++++++++++++++++++-------------
 hw/display/ati_dbg.c  |   9 ++
 hw/display/ati_int.h  |  19 +++
 hw/display/ati_regs.h |  20 +++
 5 files changed, 435 insertions(+), 120 deletions(-)

-- 
2.51.2


