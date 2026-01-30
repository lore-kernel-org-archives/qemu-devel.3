Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DBFE6BF17
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlppM-0004hc-P2; Fri, 30 Jan 2026 09:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppJ-0004fv-Pu
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:25 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppH-00035b-CJ
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:25 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id B30F71D00125;
 Fri, 30 Jan 2026 09:50:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Fri, 30 Jan 2026 09:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1769784620; x=1769871020; bh=pZJzPe/TJq
 K4+jdVghNGr1+m+dhN3cyniv9xYbVCDNo=; b=n3R4ZSBYK/R7FwY5NMtorfYvf9
 ng0jfHxFlc5L6ff1kqw27Yk2aUY02nxehMe0BPT+2hMZ0V+AeDdD3nyL+8nFewYG
 IeZVv+RQ7+qvuzJeBZ8nz5ElNNMVZdhv0bYvQUrUaGyBscwcYVpTB3KU3kCHsS2O
 FO2LwWzHzq4LBZf7W1MMgURJg4ioqL1udzXL103Cc9RwD+zjKhw3YKOQnp05Qp70
 Zqg8EPbrpx9zS8s2WWT6FECXc/lFw8saDG50p80mGQWjfLd0+OWXX2Mdp00UyD76
 jItMbjMyAfPTrK2iqZjSFdcEbh6ZxH++uCURhDD8N15LD8efdBzDtED0Bo6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1769784620; x=1769871020; bh=pZJzPe/TJqK4+jdVghNGr1+m+dhN3cyniv9
 xYbVCDNo=; b=cmStGcqRFZAX89PyDOTvqLYKfRhrjVUpKTxrnHl92TODDLgFCPw
 Ark75JGUeAIlqBSStk6ubCERG8+y7hwPzklC21YOEeKGnqc1fALMelJcTYulX3VE
 TyUe+Hp2ImxTvzv6jAp/mYe00LghQPX3OPcykAvENM7eg+2hXNCtjzKARA7eVAEc
 NN9H9HXAtNQkz7H92dkUEt8WYZ3ROO0oBH6UmZIJlmLO2FDh8UaDwwkXI7ShmLCO
 4IxIqGLbdEVAOQHnl2wbG9x0CPQaNLQYmrzjlelxfaoZPwazDDUqoBXnxKLF/wZ/
 kVy3odxBEyRyMW6mAKRPCtsK5m8zhikatAA==
X-ME-Sender: <xms:LMV8aU3Fg1mYEk2m9cpKDm0cMPTFJXRc8xEEifNMtzkvIlor8aSGFQ>
 <xme:LMV8aWgnLNuuL1XUMd50UitfPj8qrWx_zTE1YxBkxCS4-Joc89rIu7qj5ZGK32Bft
 kQh_HuvvunJ-fv3Mq1HI-c-CYfkTaFzcy9CyTxIquZLsMbvTMFzAzk>
X-ME-Received: <xmr:LMV8aaQ_krXw-KEfTiLRWLkvZvrWisI3CYZqgrBzARgfOKngNP9_3A6M08ni>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
 ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcu
 oegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhephfdtvd
 ehieevgefgteffheeigeehtdelvddvueeijeejvdeliefftedvffejtdeunecuffhomhgr
 ihhnpegtohguvggsvghrghdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
 grmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidpnhgspghr
 tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrlhgrthhonh
 esvghikhdrsghmvgdrhhhupdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdig
 hiiipdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:LMV8aXj0bIC2OLiW3VvHEf0yxLm554-gOuvdsdbXhQVTgdopXiVuQg>
 <xmx:LMV8aa5iCWuzCZ4VCH9uUPsmKeXxuzZBS4HvM0kP44Ad_WiRQuUM5w>
 <xmx:LMV8aUDZoOg8WwCHNTB2ZILL_WvEfedEinxeSKI5m1wjHVFaP-iyZw>
 <xmx:LMV8aRYKf8Tx03vl7t0ZNNOnK5FBFlNiuzjb9OovQ4cC5GyF6VHHog>
 <xmx:LMV8aeOvFNi_aOU8iVAY2zZ8aP5TwJms3sJ0ZC4O0I-DtipuHj3BOhKk>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 09:50:19 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id e17f6162;
 Fri, 30 Jan 2026 14:50:19 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v6 00/20] ati-vga: Implement HOST_DATA transfers to enable
 X.org text rendering
Date: Fri, 30 Jan 2026 09:49:45 -0500
Message-ID: <20260130145005.731129-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.147; envelope-from=chad@jablonski.xyz;
 helo=fout-b4-smtp.messagingengine.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.499,
 FROM_SUSPICIOUS_NTLD_FP=0.843, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
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
* Patches  7-17:  Refactor of ati_2d_blt to decouple from ATIVGAState
* Patch      18:  Scissor clipping implementation
* Patches 19-20:  HOST_DATA register writes, color expansion, and
                  accumulator flush

Tested with xterm on X.org using the r128 driver built with
--disable-dri (MMIO mode).

Hardware tests can be found at:
https://codeberg.org/cjab/ati-tests/src/commit/e3e01a74f51f6f7f1fd0b447033036eabe800633/tests/host_data.c

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

Chad Jablonski (20):
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
  ati-vga: Pass use_pixman to ati_2d_do_blt
  ati-vga: Extract ati_set_dirty helper function
  ati-vga: Remove ATIVGAState param from ati_2d_do_blt
  ati-vga: Move source bounds validation to ati_2d_blt
  ati-vga: Implement scissor rectangle clipping for 2D operations
  ati-vga: Implement HOST_DATA register writes
  ati-vga: Implement HOST_DATA flush to VRAM

 hw/display/ati.c      | 145 ++++++++++++++-
 hw/display/ati_2d.c   | 410 ++++++++++++++++++++++++++++--------------
 hw/display/ati_dbg.c  |   9 +
 hw/display/ati_int.h  |  25 ++-
 hw/display/ati_regs.h |  20 +++
 5 files changed, 469 insertions(+), 140 deletions(-)

-- 
2.52.0


