Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B15EB3622
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7di-0006HG-V0; Mon, 02 Mar 2026 13:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7de-0006Bs-Le
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:03 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7db-0006LQ-Sp
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:02 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 14C4FEC0605;
 Mon,  2 Mar 2026 13:04:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 13:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm3; t=1772474699; x=1772561099; bh=8yhq+Fmuls
 rLOfnfWQWOnCmIWc4xi6kgMNbHkv2oUaM=; b=bJfK/xBzw64NnGHgRbfvShgdQt
 LvLUnEZpxiElcRLQTc25Jte2eO/7IX+rXbn7G7e6OLCklhTbjlvFF4mGp8pXBV29
 2WrB9N/zWmCF7AELGx22Bu3koQ9Ly6EJWCPKyCDpSck4oiCnnWYYhH7kwm3PNc2I
 xHh5tsJmPtVPTiBiTAgstVj+mqNST2HUH1F34vAxt2I1z3XsUCAYlGuU4xMkDnk9
 nT8LkZekwaE8Nwyp4bv+U1ijt76QfBjn4gIumOuhl1lFtLO1Uz4umlS/e9wrzMNy
 NYav8RhFb4rXBYWa917p6bnqEaN6970czxs2UC2ag434Rg0NupvNN3kHUItg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1772474699; x=1772561099; bh=8yhq+FmulsrLOfnfWQWOnCmIWc4xi6kgMNb
 Hkv2oUaM=; b=up0jyXtnY5Lu0N6PrhARswA2w8tk1jDT8xOTY2Vx6u/e0J/dRxs
 UT7cMb26mKbi7NlSfv8QqSU2B4HkNMJnNYo1gNRheB17GWEG3chnn6abwFoK15qt
 zlMBwxfCC4xwl23l+W/6YgIES4uqBRqMKhOm7ifcVyhq/eCjwSQqxdkiGSJRqUm2
 JLCovXKG7y6E5vby4PTAIlsVPRGjNJADPjEM3/F0awXkexNT8IrZ30Ci/q8/+cMN
 snjOHmgXe6/ETgr1uucXAXOwkMiNTfJbiwezuj2H1fFMHkWYRMFakLDdSn5G+35Q
 8VRhL2pp6VBvI5LYPji18WmT78IsKbUTnCA==
X-ME-Sender: <xms:StGlaXXpShQUO8X4tyyA4IYryMkIG_wCayMQ2yHGaO15ZC7vaydz-Q>
 <xme:StGlaWdrrbqmcrqx3v3Ej_ic6wTcwTZIsKGyO99oa-8qFNVMcyUYNvxrpM4KtWobD
 gOObPFQspIOP1YkN_RecdFEbrfOzUg8qzwpidte7V9ItnUKE2KQ57s>
X-ME-Received: <xmr:StGlabvXW0KHMRrd5zArH3visjpPe-jdQohX-fN8T7TXy0piRfMfkHZsblm5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
 hfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnshhkih
 drgiihiieqnecuggftrfgrthhtvghrnhephfdtvdehieevgefgteffheeigeehtdelvddv
 ueeijeejvdeliefftedvffejtdeunecuffhomhgrihhnpegtohguvggsvghrghdrohhrgh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgr
 ugesjhgrsghlohhnshhkihdrgiihiidpnhgspghrtghpthhtohephedpmhhouggvpehsmh
 htphhouhhtpdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghp
 thhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopegthhgrugesjh
 grsghlohhnshhkihdrgiihiidprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhg
 nhhurdhorhhgpdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhh
 grthdrtghomh
X-ME-Proxy: <xmx:StGlad8G8lT2ICx3Y8wL--DQ4hAsA5xqdlo_j6w9zfLcr8DzPQviJw>
 <xmx:StGlae0D44mTdWRLiD81l9_J4F-M0n8rEITTxL0tdNL1cdbYaF6Rnw>
 <xmx:StGlaaDzp9PAQ1M6n_GDSTRf9w2ViNwYo5kM9NO8v9PqmuVQmU72LA>
 <xmx:StGlaSfDHbGGSAmxCJDt-FGYRz_R_lURqkrSM05V-nB2RW8l15gjaA>
 <xmx:S9GlaVYoMz9dFti3ME_Dp7sAy05hzdPCQotOTCXgH_Byxjgj3C7C6NzW>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:04:58 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 8ce71be5;
 Mon, 2 Mar 2026 18:04:57 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v10 00/17] ati-vga: Implement HOST_DATA transfers to enable
 X.org text rendering
Date: Mon,  2 Mar 2026 13:04:30 -0500
Message-ID: <20260302180447.1078098-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=chad@jablonski.xyz;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: 32
X-Spam_score: 3.2
X-Spam_bar: +++
X-Spam_report: (3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 FROM_SUSPICIOUS_NTLD_FP=1.999, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

* Patches   1-6:  Bug fixes and register implementations
* Patches  7-14:  Refactor of ati_2d_blt to decouple from ATIVGAState
* Patch      15:  Scissor clipping implementation
* Patches 16-17:  HOST_DATA register writes, color expansion, and
                  accumulator flush

Tested with xterm on X.org using the r128 driver built with
--disable-dri (MMIO mode).

Hardware tests can be found at:
https://codeberg.org/cjab/ati-tests/src/commit/995cdccbbe969920984bc30d953379b02cb132f8/tests/common/host_data.c

Changes from v9:
- Remove unneeded FIXME comment in ati_2d_do_blt
- ati_set_dirty is no longer called when the blit exits early
- Drop patch 15 moving src bounds validation to ati_2d_blt
- Check src vram bounds using clipped values, only when host_data is inactive
- Return to 128-bit accumulator for simplicity
- Small tweak to color expansion to avoid a multiply

Changes from v8:
- Rename tmp_stride to tmp_stride_words
- Small formatting tweaks
- Add clipping debug logging
- Replace extract8 with BIT masking in expansion hot path
- Add SRC_COLOR support
- Fix SRC_COLOR value (was 0x20000, should have been 0x30000)
- Add partial SRC_MONO_FRGD support
- Src bound validation now only done on ROP3_SRCCOPY blits
- Other improved log messages
- Host data accumulator expanded from 128-bits to 256-bits based on hardware
  testing. Real hardware flushes after 128-bits but early HOST_DATA_LAST writes
  make use of the entire 256-bits to finish the blit.
- Added ati_finish_host_data to match hardware in the early HOST_DATA_LAST case
- Added active flag for host_data blits ignoring HOST_DATA writes
  when no blit is active.
- Removed ati_host_data_reset. This is now handled either when flushing or a new
  blit is started.

Changes from v7:
- Avoid potential issue with dst_offset calculation (found by Zoltan)
- Remove unnecessary newlines and other small formatting fixes
- Squash patch 15 into patches 13 and 14
- Note: Zoltan's suggestion to embed ATI2DCtx in ATIVGAState will be
  revisited in a follow-up series

Changes from v6:
- Reduce churn by adding ctx_ struct and pointer
- Moved extraction of ati_set_dirty helper earlier in the series
- Moved register logging into setup_2d_blt_ctx
- Remove unnecessary comments

Changes from v5:
- Added previously standalone aperture size patch to series
- Introduced ATI2DCtx to hold all blit state (suggested by Zoltan)
- Made refactor patches more granular
- Simplified DP_GUI_MASTER_CNTL bit shifting
- Sorted clipping regs by offsets
- Removed dst_x/y update after blit (confirmed by hardware testing)

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

Chad Jablonski (17):
  ati-vga: Fix framebuffer mapping by using hardware-correct aperture
    sizes
  ati-vga: Fix DST_PITCH and SRC_PITCH reads
  ati-vga: Read aliased values from DP_GUI_MASTER_CNTL
  ati-vga: Latch src and dst pitch and offset on master_cntl default
  ati-vga: Implement foreground and background color register writes
  ati-vga: Add scissor clipping register support
  ati-vga: Remove dst_x/y updates after blit
  ati-vga: Consolidate dirty region tracking in ati_2d_blt
  ati-vga: Remove src and dst stride mutation in ati_2d_blt
  ati-vga: Use local variables for register values in ati_2d_blt
  ati-vga: Introduce ATI2DCtx struct for 2D blit context
  ati-vga: Extract setup_2d_blt_ctx from ati_2d_blt
  ati-vga: Split ati_2d_do_blt from ati_2d_blt
  ati-vga: Remove ATIVGAState param from ati_2d_do_blt
  ati-vga: Implement scissor rectangle clipping for 2D operations
  ati-vga: Implement HOST_DATA register writes
  ati-vga: Implement HOST_DATA flush to VRAM

 hw/display/ati.c      | 142 ++++++++++++-
 hw/display/ati_2d.c   | 459 +++++++++++++++++++++++++++++-------------
 hw/display/ati_dbg.c  |   9 +
 hw/display/ati_int.h  |  26 ++-
 hw/display/ati_regs.h |  20 ++
 5 files changed, 511 insertions(+), 145 deletions(-)

-- 
2.52.0


