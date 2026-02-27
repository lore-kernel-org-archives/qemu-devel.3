Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3443FEFB51
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4e8-0002JD-Vf; Fri, 27 Feb 2026 15:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4dx-0001MZ-PG
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:03 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4dv-0007Oh-8h
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:01 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 906EDEC0632;
 Fri, 27 Feb 2026 15:40:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 27 Feb 2026 15:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1772224857; x=1772311257; bh=D/9XodGQWU
 gEMOapxbVo8SZR9Sw8LUVI01gh4qzXrW4=; b=pYr0snH6WmC2KZYtqDnLuYDuP3
 +W+0xBlp6hnlkr23TRPGTgDtOzjCYskKAe6HG8fP1P9sRo2zzB9KebiRdWBFOfrI
 B5RJCRyZvIuQRQbCp1LRSsryupxSBuFPh0NaGCXmn+M7oKIxLvawLp11OBs4m35P
 Zx7oYzSGJ92QQdvRhPPuE2KHhYNJiBmi29CyCLeGQk4nKjfKUr7GzTH0/sTv9bsy
 AvJyeEh5027khKp7+Xw2glfad4vyrtfmcRGcv65gz4EFULDiU25FKRLGs3XfBU2t
 5bV0HLG3LJps4vhIB/izqagDb1bWpEUApovJWHpGXSKpM1b67B0RNYzUI64A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1772224857; x=1772311257; bh=D/9XodGQWUgEMOapxbVo8SZR9Sw8LUVI01g
 h4qzXrW4=; b=IGInhldU7TrZflqliD7PwONH3YlLzapazjKcqpWI3Uqev44N95Z
 6r9kebQnxq7BOg3UPPQl/HzUs9zZJoJTYA8LdlDZCEuliKer3MzwRw+gUNzlP6fN
 AFFjJx1hPaJ7sbf9u/9J5UprxbyDnooiymqNbbLFzPzel/Y66w35j6u8nrmfr/Nq
 bYnM8FODPryYS3UI2b81ypl1UObgjilJFRq0xKGu/bXE+8Y9FaR5FB1m8GbIwJvN
 t/jahUpDP9uZqaFMykKsB35Umy7iMy7rjHkQvm0WtSBcy0CZTrnIBhTSvL0XHn8o
 n1pKn5xXTIylL6u5Er1qdgrOcHG03t1kKzQ==
X-ME-Sender: <xms:WAGiaa5IEqY3h28YEt6M2eLBx0aiCTCfKqqOi_qQVyMLHXRBbuFyYQ>
 <xme:WAGiaawsqiI3nw3euPMBOVtteyd5bYm748tfdcuBv_5iujbmoheGiRDmkkG5KMH9f
 Y1WNd9krSdlqEdbBZDIxgYGUXLXoRWfsrmfWuf9kdREsXOIFoHY_qM>
X-ME-Received: <xmr:WAGiaRwgOqA_jyFWgJGt2j4Fw2A-dMooUvBijnmynBcMErt9GOCeSKujbg_1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelleekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
 hfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnshhkih
 drgiihiieqnecuggftrfgrthhtvghrnhephfdtvdehieevgefgteffheeigeehtdelvddv
 ueeijeejvdeliefftedvffejtdeunecuffhomhgrihhnpegtohguvggsvghrghdrohhrgh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgr
 ugesjhgrsghlohhnshhkihdrgiihiidpnhgspghrtghpthhtohephedpmhhouggvpehsmh
 htphhouhhtpdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdprhgtphht
 thhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghpth
 htohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegthhgr
 ugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopegsrghlrghtohhnsegvihhkrd
 gsmhgvrdhhuh
X-ME-Proxy: <xmx:WAGiaSz-Cdnk-fvEUeyFn9b1WKtjz2xhhEmCn0I_JQo-JNFBTom5zw>
 <xmx:WAGiabZ9QhHvjLf-1bFTj0pkc1Luhq6cycriaywECbzZSsvP_o_zUg>
 <xmx:WAGiaTVkBdIMBY_01mmSBWio5IieORztIOMjVzMNx8SOac_XkhR4Jg>
 <xmx:WAGiaZiQaPHZB0ELhlmtQ0Xj-cLZkg_JKlOXfWiFgk7Gh7IbkiB3wg>
 <xmx:WQGiaYfgTAc0mLcBTHobf9qotd3PVfehuAlQK4YgCbqZt1jgWc7i0ouz>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 15:40:56 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 431869eb;
 Fri, 27 Feb 2026 20:40:55 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v9 00/18] ati-vga: Implement HOST_DATA transfers to enable
 X.org text rendering
Date: Fri, 27 Feb 2026 15:39:26 -0500
Message-ID: <20260227203944.746471-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=chad@jablonski.xyz;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 FROM_SUSPICIOUS_NTLD_FP=1.999, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
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
* Patches  7-15:  Refactor of ati_2d_blt to decouple from ATIVGAState
* Patch      16:  Scissor clipping implementation
* Patches 17-18:  HOST_DATA register writes, color expansion, and
                  accumulator flush

Tested with xterm on X.org using the r128 driver built with
--disable-dri (MMIO mode).

Hardware tests can be found at:
https://codeberg.org/cjab/ati-tests/src/commit/995cdccbbe969920984bc30d953379b02cb132f8/tests/common/host_data.c

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

Chad Jablonski (18):
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
  ati-vga: Move source bounds validation to ati_2d_blt
  ati-vga: Implement scissor rectangle clipping for 2D operations
  ati-vga: Implement HOST_DATA register writes
  ati-vga: Implement HOST_DATA flush to VRAM

 hw/display/ati.c      | 144 +++++++++++++-
 hw/display/ati_2d.c   | 452 +++++++++++++++++++++++++++++-------------
 hw/display/ati_dbg.c  |   9 +
 hw/display/ati_int.h  |  27 ++-
 hw/display/ati_regs.h |  20 ++
 5 files changed, 510 insertions(+), 142 deletions(-)

-- 
2.52.0


