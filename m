Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CFEE7FDCD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 20:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn0q9-0007O0-CD; Mon, 02 Feb 2026 15:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q1-0007Gj-T6
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:02 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0py-0001np-Jn
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:01 -0500
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id AA3EE1D00059;
 Mon,  2 Feb 2026 15:47:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Mon, 02 Feb 2026 15:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1770065275; x=1770151675; bh=5qUV5PbVb7
 j+mef2pzsVpsVGcZxfqkPQhIkU0R8TwYE=; b=Rh9+RwM0xFcjMY6cIP+7zJ+DbG
 k9UHxyQV05OqAm+CxAWVWFsNR6O6Chp1WARHffRodre2UuSHXtXUGugrCDIk1Rz5
 SUcTG1+IBXZERWefVX3lNtVfdV4uzU9v8qZ9MAF2XuCJSjFZ3o4568daV2j+/Ov7
 MAfvMYW/fY3LsyutGn0lH9zMK3FbFXoc5/LZdJc0z07sBK9dLcPzdJX+i6BkTmFK
 xXZR+KuhcTsrI5xt/VVayN1/EfPLsCJMG0/4qH2YwllLrDP0t9eJAPBuVuWGXWx2
 ZgeyVU5pcz251fMFOG21JN0tpooqQArxuItHtnOdTtSzBYBt7+TcJ8zgNu2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1770065275; x=1770151675; bh=5qUV5PbVb7j+mef2pzsVpsVGcZxfqkPQhIk
 U0R8TwYE=; b=d6OaRKNv6t+92qgsepTAx6SizBKNjJp6F15fhxhShJv0qb7Erf0
 eReG3ToBo3NPWblx0GUsuiBWwHuVysf6aE0y2l5Gx3U8L17odZaQyhgeEHcZgEIb
 CY1WXPj6j9qHaS6NF4ZIfxJ5B2QNZBAZOFZNqLGqGJ9eelRpSi6vNXi1/SmXATYC
 YTyH3tPySuIBXhVOk5CNelJrt83y1/K+NGrKE4tsu+ajoRaN1Y4gmedIxmB9ql6W
 u7DzLAotkroyzv1pkbU4s4hkiCLpAQTXcFXvNqbULv6pbaxpyfMLuX8zHz8rMHjM
 gD+Js91EN6Ow15IHCsvYwUD4TZdjVcpcZKg==
X-ME-Sender: <xms:eg2BaUng8X7ilvH6Z10mCdqH339j3AAzXDc-J4K1Wljh0phxkFCNiQ>
 <xme:eg2BabQMnB-q-Cwy_VgEvBK8aTfWOkP1q8m3sqPn3f2bnQij-UGDkkmWjOnS-4zUY
 LT3LLvvpsHArGSqrxjNvZaZpiEC5mCqH0wSBdUr92PbMylc_MVpAHY>
X-ME-Received: <xmr:eg2BaQApSast6dxZZFiWoaDw6DradILNr5G0VE_EMX22mNL-99YtfJdLy9mm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekieefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:eg2BaaT4xl32w7Iy3jHBOwnXcYai47kXLznkGzbWAMAKQG85do8ksQ>
 <xmx:eg2BaWqxrIrFV75-8aKXcMttz4ZIklRH3-QG1x0yiBPNrUqc9lcg9w>
 <xmx:eg2BaUxHNrdmctWfRjGxQqLID8k4UNXZuf52GK8wirBBfxOeyxYXYw>
 <xmx:eg2BaTKtDdbWyQ4GmuAZVGrR1kh7vgAnu-Z12xGHYpIF92kMLvwDCQ>
 <xmx:ew2Bac8wD5KifiTnN0TkTY0z1zGnZD7Gr_c3IzcKOviwPTKZyghWMB4E>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 15:47:54 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 3a3ed4c2;
 Mon, 2 Feb 2026 20:47:53 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v7 00/19] ati-vga: Implement HOST_DATA transfers to enable
 X.org text rendering
Date: Mon,  2 Feb 2026 15:47:18 -0500
Message-ID: <20260202204738.3080092-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.147; envelope-from=chad@jablonski.xyz;
 helo=fout-b4-smtp.messagingengine.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.499,
 FROM_SUSPICIOUS_NTLD_FP=1.987, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
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
* Patches  7-16:  Refactor of ati_2d_blt to decouple from ATIVGAState
* Patch      17:  Scissor clipping implementation
* Patches 18-19:  HOST_DATA register writes, color expansion, and
                  accumulator flush

Tested with xterm on X.org using the r128 driver built with
--disable-dri (MMIO mode).

Hardware tests can be found at:
https://codeberg.org/cjab/ati-tests/src/commit/e3e01a74f51f6f7f1fd0b447033036eabe800633/tests/host_data.c

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

Chad Jablonski (19):
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
  ati-vga: Remove ATIVGAState param from ati_2d_do_blt
  ati-vga: Move source bounds validation to ati_2d_blt
  ati-vga: Implement scissor rectangle clipping for 2D operations
  ati-vga: Implement HOST_DATA register writes
  ati-vga: Implement HOST_DATA flush to VRAM

 hw/display/ati.c      | 145 ++++++++++++++-
 hw/display/ati_2d.c   | 407 ++++++++++++++++++++++++++++--------------
 hw/display/ati_dbg.c  |   9 +
 hw/display/ati_int.h  |  25 ++-
 hw/display/ati_regs.h |  20 +++
 5 files changed, 466 insertions(+), 140 deletions(-)

-- 
2.52.0


