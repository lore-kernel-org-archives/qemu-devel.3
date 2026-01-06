Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094F7CEFCF0
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 18:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdCFU-0004b5-L7; Tue, 06 Jan 2026 13:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCF1-0004Gc-LH
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:17 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCEx-0001wR-DT
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:14 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id 33DD61D00101;
 Tue,  6 Jan 2026 13:57:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Tue, 06 Jan 2026 13:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1767725829; x=1767812229; bh=D764j6FLhl
 nD/G/ImRtNqDnz6LvbSiaT6DuoojKqxCY=; b=mTrIWOzAvzdjiDS1EpTgHhIQuh
 Q6qro1Bg0wZLPwud9ycU3Sqcuy/ClZudGaeQP3h8MoDlic4EcQN7GDrU/FDREhCk
 pbwrgXj5tVfwez8ZnRWVI9P2isdp2OOKgLhmA81lvlVn414myjQoN1o6mbOs4Uww
 Pi4mBrFxCvvzA7KeLlLGCHHaGExmZUaqDMMP023UnyEXcy2iu8qzYXPF4jhmGRPe
 rewv0jabNhGs3+5c/7//JjqFjl8zbavXbYDxcxrpEtxOjWuLWdGoAsaTBQm7whTo
 i3uQt942pdVHMWISfv/2XB4IO5RgbCS7u6eHm3EYMMxq8SJSaac98W6fn+7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1767725829; x=1767812229; bh=D764j6FLhlnD/G/ImRtNqDnz6LvbSiaT6Du
 oojKqxCY=; b=kixqc0wGeNsI+KQsgYJQSwsJ64xl5/53R3SEYzJ+N3gMr2mgPya
 iAVeliUOCquHxvXP4NGuV6fIqTJX7gmPV1j10yrf1y6AdAnn/6bddUTYp6ORqA2+
 vg+WEd1wv19fVXo41ZXafHR8NUKeczrPUFIbJMQMzh2T0EIlr6tBITZWuMh2zi6T
 Fzq+WbHGjrHT8mx86kw2Y4+jeUxgBCLwuO1e3DMMvMUIyT3h+Q55fOYEETQD+q/o
 jOFbVdNHpPACm1c0XkkkGzwzlIz8HrTcS9Ieilt8hrOaQUdI8s/3jpdNUechV2e6
 /Uj6zr6votu9/kwDoHkZsxLbDnPu/BixqoA==
X-ME-Sender: <xms:BFtdaYbWYR_0yAj2CtQuNlC-FwaQH6ZH9P5QV8bR33EKqdL_Ew9J3A>
 <xme:BFtdaa2yvuxvN-LLGm49vfcEvTHdaVgyDNs6eTYJijAHkmH_MV2Ev6QJtHmj9J_70
 63UCLM0lO9OdhobPPdQvvAMMx485IRfxF2WCbwcJ-Sj9d4pY138>
X-ME-Received: <xmr:BFtdaQWKsxM8vOd5Efg2iqN8Xfpwqt8xpbEdUYJBoxGcTNcTmNG7_17ZYtDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtleejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
 ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcu
 oegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhephfdtvd
 ehieevgefgteffheeigeehtdelvddvueeijeejvdeliefftedvffejtdeunecuffhomhgr
 ihhnpegtohguvggsvghrghdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
 grmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidpnhgspghr
 tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqdguvg
 hvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgs
 mhgvrdhhuhdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihii
X-ME-Proxy: <xmx:BFtdacXF2CwzDQXjYFYQVoY8dQmxutJkkTuCAzk8SuWjDmHOCxOp7A>
 <xmx:BFtdaXeu-GuKpevm_ga4uWMiCoJDL2oeI8rpd8oJEDMqN2iHRtkS9Q>
 <xmx:BFtdadWz5nfTRIVGkFKj39MV4DO4y9TLPAIveq6ANNAk5F2kIbuIjQ>
 <xmx:BFtdaYf5-j7dH26rbkY4H9xIZ-5swlr0pKvff8G9ehlIi8H-D3Nk8w>
 <xmx:BVtdaYD7sGVxL1L6Xi0s8ue_-78Nq45R61gB-sPIbjgVTm31A9OxPfTB>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 13:57:08 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id ef415bfd;
 Tue, 6 Jan 2026 18:57:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v4 0/9] ati-vga: Implement HOST_DATA transfers to enable X.org
 text rendering
Date: Tue,  6 Jan 2026 13:56:51 -0500
Message-ID: <20260106185700.2102742-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.149; envelope-from=chad@jablonski.xyz;
 helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, FROM_SUSPICIOUS_NTLD_FP=0.058,
 PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
* Patches 6-7:   Scissor clipping and destination setup refactor
* Patches 8-9:   HOST_DATA register writes, color expansion, and
                 accumulator flush

Tested with xterm on X.org using the r128 driver built with
--disable-dri (MMIO mode).

Hardware tests can be found at:
https://codeberg.org/cjab/ati-tests/src/branch/main/tests/host_data.c

Changes from v3:
- New patch 1 fixing DP_DATATYPE/MIX register aliasing, this supersedes old patch 5
- Fix MSB/LSB HOST_DATA bit ordering, it is per-byte rather than per-word
- Fixed a missing break in register write handler
- Squashed and reorganized the dst/scissor helper patches (per BALATON)
- Simplified register field constants and increment logic (per BALATON)
- Tested with MorphOS and TVPaint (opaque bitmap fonts now work)

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

Chad Jablonski (9):
  ati-vga: Store DP_DATATYPE and DP_MIX fields independently
  ati-vga: Fix DST_PITCH and SRC_PITCH reads
  ati-vga: Add scissor clipping register support
  ati-vga: Implement foreground and background color register writes
  ati-vga: Latch src and dst pitch and offset on master_cntl default
  ati-vga: Implement scissor rectangle clipping for 2D operations
  ati-vga: Create 2d_blt destination setup helper
  ati-vga: Implement HOST_DATA register writes
  ati-vga: Implement HOST_DATA flush to VRAM

 hw/display/ati.c      | 162 ++++++++++++++++--
 hw/display/ati_2d.c   | 371 +++++++++++++++++++++++++++++++-----------
 hw/display/ati_dbg.c  |   9 +
 hw/display/ati_int.h  |  31 +++-
 hw/display/ati_regs.h |  44 ++++-
 5 files changed, 500 insertions(+), 117 deletions(-)

-- 
2.51.2


