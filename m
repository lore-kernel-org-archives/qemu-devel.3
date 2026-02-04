Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5CCE9D40D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vng1N-000747-1P; Wed, 04 Feb 2026 11:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng18-0006zy-HI
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:14 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng16-0004W7-Fq
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:14 -0500
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id A6E8B1D00159;
 Wed,  4 Feb 2026 11:46:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Wed, 04 Feb 2026 11:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1770223569; x=1770309969; bh=4XGr06A/W0
 aSE0oX6rLm0Us87QE/lB+Kij1ppG0Uw8A=; b=FdZ0y4jPGcyFc0LYNs3RcUC3Pr
 rbxfzFEe72uaEftJQ+FLPkGoZ2FdfP/qa3McEY6ohzaT5OKUQVkgQX/VUf06ZeOW
 V1bTfi6Akou+NGimzTSyTnCk62fMZ5csyIWHy2OGpM+DaWxNB/TwGtTw7GxRX1Gw
 g0NSA5qr78IYKL3zAu9F8q/TqljSzP1FLC4tE/EFhHaNASmmTdagdAMY1bPWbJU6
 CsipUq8uwkciNZbOheeZy1YA0viQKM1w8zwf0sWn5qeJkMZT/8JR6Lj7nqKyr9iI
 NW4rSBgcCqQAPvpIzjnP1GyyPMDs2UT0v4uXB0bNqYco5rCMfQ6RtKq1fUyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1770223569; x=1770309969; bh=4XGr06A/W0aSE0oX6rLm0Us87QE/lB+Kij1
 ppG0Uw8A=; b=hM8+phFtYPVahbD2Vj6mHiooj4J1rEAryA7Q1O6DaYbC7vdmFfN
 OQzXRvykyOcj8k04rcEJzrVamOUiwIrFCnXQFJzf/B5bv3HC92yXIPW4XVL/3sHS
 bnjVcgg+7OG9yednXIawp5WmX/sZD4PXh0dJMd0aGufsf8r1pttDvPlTl/TrraEJ
 KvQSjqeWqYn/1RxXkItcNGJ7pbqYOeZdEbAGOU7TR0IiDNls6tGGWkt6xKxaLve8
 HEoC7JxJCz3vLnhGNZRqN7z4+gPqfNS/zBPyK5uvjr8wA1OEjAL7SvaULGkh47sZ
 tbbSX3Wz+x13IzHm3J7igySJshN9sBOCM1w==
X-ME-Sender: <xms:0HeDadg2ExGy60mFtwKU6GH16KYyeWAxwBlns9Alvi6MKaqvMhFGUg>
 <xme:0HeDaZdhZhlAq3gFtlLEXJ4B0r4TLWVuIANN-czPNhlu9UdjxASzqdd2kU5sYuUHS
 beYLcTTVv0tKGSqvA-OunXWkWZ-cyxVdIsZ-oG2SVAji0RAdAJ_BsZJ>
X-ME-Received: <xmr:0HeDaac_9-myPfK3nk3Mr8KFFPhEX8BrMB_1EFPlbYOLN0akfSco_L_zA5jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
 ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcu
 oegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhephfdtvd
 ehieevgefgteffheeigeehtdelvddvueeijeejvdeliefftedvffejtdeunecuffhomhgr
 ihhnpegtohguvggsvghrghdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
 grmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidpnhgspghr
 tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhn
 uhdrohhrghdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuh
X-ME-Proxy: <xmx:0HeDab-nNCrEC_N9kWprENMKhfdajszPhIq65GyNoOeVfD-H49jXEA>
 <xmx:0HeDaemBlvfSXMrWuPN1zBBceNrE0MKTfebSgSv8m-ztDOoOuXx_qA>
 <xmx:0HeDaV8nKn93gwrjsgIZ-x4lat0F5if-yt9dgbroqxm03VeiRKTMBg>
 <xmx:0HeDaUknuR9Hq-0Lh8dmKG1pvW3SlTN-mVy9tZHw004Dpg1rqVDrfw>
 <xmx:0XeDaRqYrLZxbBBZ-WtnPdCk_HkWyMyEVNIIwdZwOJvgZl7EeatC9dIe>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 11:46:08 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id f928f03f;
 Wed, 4 Feb 2026 16:46:08 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v8 00/18] ati-vga: Implement HOST_DATA transfers to enable
 X.org text rendering
Date: Wed,  4 Feb 2026 11:45:48 -0500
Message-ID: <20260204164606.3425246-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.150; envelope-from=chad@jablonski.xyz;
 helo=fout-b7-smtp.messagingengine.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.499,
 FROM_SUSPICIOUS_NTLD_FP=1.989, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
https://codeberg.org/cjab/ati-tests/src/commit/e3e01a74f51f6f7f1fd0b447033036eabe800633/tests/host_data.c

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

 hw/display/ati.c      | 145 ++++++++++++++-
 hw/display/ati_2d.c   | 398 ++++++++++++++++++++++++++++--------------
 hw/display/ati_dbg.c  |   9 +
 hw/display/ati_int.h  |  25 ++-
 hw/display/ati_regs.h |  20 +++
 5 files changed, 457 insertions(+), 140 deletions(-)

-- 
2.52.0


