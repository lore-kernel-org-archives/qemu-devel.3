Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD375CEE32E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNy8-000694-8q; Tue, 18 Nov 2025 10:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwl-0004wl-Mu
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:57 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwV-0001wA-1X
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:32 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id AC7377A00FA;
 Tue, 18 Nov 2025 10:48:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 18 Nov 2025 10:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1763480906; x=1763567306; bh=0z5pP8RPoz
 WbwSF90KR9lGuqIMlcti0MiexUPvXb9FQ=; b=ZtysCWKhz+4G5xUFb4W23IYXqz
 rKGhww7EIemsDXNZSyt9c6uRUKMan2fckXia7bhCGVyh1FazIF+BJ0G2jkGRtI34
 zKTkRFYemql3AbCZKgzoq1pIxJcvQjT4JWaRxc4bLBXKfoGPCxURk9rN+jJGcE6/
 r6vRgx5AayZKeqXPw/zNNCirw2rwUi/DOGQIAFutRYxaW/LylkU9fwo0D7VygE+Q
 lhymlkTGfvs/L7P0sDWx5EcPIoMcENcUCp3mQOPTu6hNCIY5JJg0pu6GK57zxhLO
 NNt8DbWYPum6A0xcnSNPAvkwrbkNwtdEjKotzzwrCU/Z9G84OmHgSKlw9giw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1763480906; x=1763567306; bh=0z5pP8RPozWbwSF90KR9lGuqIMlcti0Miex
 UPvXb9FQ=; b=TzC3OD7cHY14Qf3H9lhNkYqNtuTcuVs7jM0lfDlIFcbl5cT0nrX
 phCFdaaXumD2cCwPi9KQANhnfwJ2f96X95Jt7667jtcBM73NAuwPdliB5L9U5MmF
 D4HiHX5XdNxuujlU/nfbMH2ytgu3x+Pyh2yYjRCu+0qFs3LL5XAz5U2zHLc62OU/
 Io4b/JFRXIpMHv/c4Zc0QWCQtzfah+nrMmN6l2exwbF8mPa/CoKQN6QmxKBoc3/J
 jnGtryQww0sxEpePxoKZ72nPBjzHNHCUnCOMEgIxLqdnAJ5QtmNTeo8Vdhv5Zrc8
 P9P3n7VgWjxgSgFqGSuhR7SsnDBE65tRvKg==
X-ME-Sender: <xms:SZUcaXKRDHuJC2BDda3TipMIy1swo8eNkmSsvG3aAUyTw1UJpH-HIA>
 <xme:SZUcaSlR8FEUOxVb2yztkramkqiJ2bB8JXmmzURtUGiWvytN_1qwHE-3bjm3k9mxK
 x3XY_Qr7Suy14yfXA_ZNBIg6e8miaLvUMCMn_gM2b4oGpstfJTucFA>
X-ME-Received: <xmr:SZUcadFsh2B_04XN-dJ4FM4nKKuEWTiDOiWX4aJ0bTVeE1UGQtXH1X1eEBZf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddujeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
 ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcu
 oegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhephfdtvd
 ehieevgefgteffheeigeehtdelvddvueeijeejvdeliefftedvffejtdeunecuffhomhgr
 ihhnpegtohguvggsvghrghdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
 grmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidpnhgspghr
 tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqdguvg
 hvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhk
 ihdrgiihiidprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuh
X-ME-Proxy: <xmx:SZUcaaGe4zwvviMA-04rGb4c6sUO3p-cUr03BqN0ItyAQ43TFJV-xg>
 <xmx:SZUcaSOsPLJL1yPLXimRRFPee1OU2cArJDG4yvIJqunWK_assHjxRQ>
 <xmx:SZUcaRE-Unt08VVHd3iLCULQYaqY_Hxg6lAmWZknTTJ-Rii66a95Gg>
 <xmx:SZUcaRO9RsnNBeIBEz6p4x9RP-6V33BPWNkSjBJ7VQ3mttng0IK7AQ>
 <xmx:SpUcaRyE-JpQXsz66t5sC-BE7QnE0NvLvCC5snL_NFTuppeUOYwCGPr2>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 10:48:25 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id cdc12a91;
 Tue, 18 Nov 2025 15:48:23 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 00/11] ati-vga: Implement HOST_DATA transfers to
Date: Tue, 18 Nov 2025 10:48:01 -0500
Message-ID: <20251118154812.57861-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.153; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b2-smtp.messagingengine.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.499,
 FROM_SUSPICIOUS_NTLD_FP=1.999, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

* Patches 1-5:   Bug fixes and register implementations
* Patches 6-7:   Scissor clipping
* Patches 8-9:   Destination setup refactor
* Patches 10-11: HOST_DATA register writes, color expansion, and
                 accumulator flush

Tested with xterm on X.org using the r128 driver built with
--disable-dri (MMIO mode).

Hardware tests can be found at: https://codeberg.org/cjab/ati-tests.

Changes from v2:

- Verified with hardware that clipping default bit latches
- Verified with hardware that pitch/offset default bits latch
  (supersedes BALATON's "ati-vga: Separate default control bit for
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

Chad Jablonski (11):
  ati-vga: Fix DST_PITCH and SRC_PITCH reads
  ati-vga: Add scissor clipping register support
  ati-vga: Implement foreground and background color register writes
  ati-vga: Latch src and dst pitch and offset on master_cntl default
  ati-vga: Fix DP_GUI_MASTER_CNTL register mask
  ati-vga: Create dst and sc rectangle helpers
  ati-vga: Implement scissor rectangle clipping for 2D operations
  ati-vga: Create 2d_blt destination setup helper
  ati-vga: Refactor ati_2d_blt to use dst setup helper
  ati-vga: Implement HOST_DATA register writes
  ati-vga: Implement HOST_DATA flush to VRAM

 hw/display/ati.c      | 124 +++++++++++++-
 hw/display/ati_2d.c   | 370 +++++++++++++++++++++++++++++++-----------
 hw/display/ati_dbg.c  |   9 +
 hw/display/ati_int.h  |  21 ++-
 hw/display/ati_regs.h |  44 ++++-
 5 files changed, 467 insertions(+), 101 deletions(-)

-- 
2.51.0


