Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761D3F99C63
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 20:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDqGI-0000et-VT; Fri, 17 Apr 2026 16:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wDqGH-0000dS-GV
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 16:58:01 -0400
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wDqGE-0002fD-Ou
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 16:58:00 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 45A8B7A0160;
 Fri, 17 Apr 2026 16:57:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 17 Apr 2026 16:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1776459477; x=1776545877; bh=oLnh0vhJ5B
 /i4EgnfEpvEqOHlg6psmVAusdckEyJs84=; b=EwqXnBJNAAHx7ATUndEXhu/PUh
 pszb+L3HI3ffSmPc7bhjk6mp3fvg4oGLq578SoiZtWK37RC6NTXS+1Uwv1PKdDqK
 DaYhDZ3ByDrfFcSb/0ShG+V9VyasRZCQxp4ZrubS4K4Qdegvi/18z5ucDWebCHKb
 SL45zl9NpetM/WYjaVur9g1vtAFHIM5+WhLbaWLAD4kA322jKPgqic9WXYnoSEHk
 UOWrQjV0ip75xKlkGGPw4LwRFaDm/8kW2npnxQzm15RUL2vAX0W+ZT99Mf2oI/th
 3NQ1hgMdYmppi2Bt5r/05eJ8kUl8piw7itzNQGeAlXWmHZPvbdiXE1zraFFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1776459477; x=1776545877; bh=oLnh0vhJ5B/i4EgnfEpvEqOHlg6psmVAusd
 ckEyJs84=; b=XQRj68knn3q7O8l5kEkues8n2bMyN4xWvxgVlCUPTODJHM+NAgB
 AaYegj2UP6ABgcbhNKw8NaV6TfcngH9y99UTRmwnYoV6knyxNOL/nTrqbCQfz5+q
 gpO+Sy521C8XcdrAgajcqwifO9knXtrrbNXTlMSrAeVWZNkqiWnTf7ttf5KV56i1
 aESjyJVusOfrul+7EBFZ+1fDbRCTHRVahjA2fqDbvtQdl3RQxL8VWt/DEtWAN5bU
 gZOAgnbGUi6sVk2OEujCL8Z9czPg2mK+gaRIc5HpmEWekYpbDsyovqMtUfP1VYVQ
 3QOG7fiHKFsWeJ7mQX11nsgPEhdwW7sZBxA==
X-ME-Sender: <xms:1J7iadiKkVYgbiCjbQ-ihXln85sqm1eKEdt0LanHJ0-7izDrVp7NmQ>
 <xme:1J7iaZclqJ859pAOuar-9Pnh0leSySfSVlbs3AfdbeI9sMy-l8fbvDnEaMd0uEeSZ
 SUnfF4l8TzEBi6uwWNrcCaZzM6Rd_WsJIziPXzEgF8s72P4gL-tWrFa>
X-ME-Received: <xmr:1J7iaaezD9qdsq_41Gs-Ct9Au-fzbPamfa_Z_w1DoUFROLta9Ux6Og_BFF_x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehtdeltdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculdejtddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
 rhhomhepvehhrgguucflrggslhhonhhskhhiuceotghhrggusehjrggslhhonhhskhhird
 ighiiiqeenucggtffrrghtthgvrhhnpefhteeugfeujeelteeggfeigeevjeelgeegudfg
 uedvheeghfffudffledukeeiveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidpnhgspghrtghp
 thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrlhgrthhonhesvg
 hikhdrsghmvgdrhhhupdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdr
 ohhrghdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihii
X-ME-Proxy: <xmx:1J7iab8L1kwXAEtsJ68b6yPssHYZ1LKOjVgYk6WmRKURR7oQmi779Q>
 <xmx:1J7iaekVJuZ-GMkE1XbpyPOmicQ5MLsuTt8iuejEm3-65neyfVbcyg>
 <xmx:1J7iaV8rRIEyol5mVrAnufh0L3bVNeNf9h49c9tfmFjbrE2GcspImg>
 <xmx:1J7iaUnbZBQ3AK0kJLLFUolTuruN8j6vW5OJj0QerZhlwArxz7Amaw>
 <xmx:1Z7iaRo8It6Tzs2e6LFrx1wkZBeVafj_pb7b0rhn0yJU0vbbiuhXeeLR>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 16:57:55 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id cf87f365;
 Fri, 17 Apr 2026 20:57:55 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH] ati-vga: fix ati_set_dirty address calculation
Date: Fri, 17 Apr 2026 16:57:52 -0400
Message-ID: <20260417205752.3932801-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.157; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.498,
 FROM_SUSPICIOUS_NTLD_FP=1.997, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
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

When using a virtual desktop any amount of scrolling would cause
ati_set_dirty to set the wrong region of memory as dirty and screen
updates are missed. This is because the previous implementation
used vga->vbe_start_addr in the dirty address calculation. It
works when it's zero but as soon as the virtual desktop is involved
it's often non-zero.

The first issue is that vga->vbe_start_addr is a word offset and was
being added to byte offsets. But regardless, the vbe_start_address affects
the scan out and not the framebuffer. We shouldn't need to apply an
offset for it at all when thinking about dirty tracking.

The second is that a bounds check was also being performed to ensure
that the dirty memory was within the visible screen. With the virtual
desktop this isn't actually what we want. Updates can and will happen
outside of the visible screen area. Those should be marked dirty.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 504d1c5708..dc33b014eb 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -71,17 +71,11 @@ static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
     DisplaySurface *ds = qemu_console_surface(vga->con);
 
     (void)ds;
-    DPRINTF("%p %u ds: %p %d %d rop: %x\n", vga->vram_ptr, vga->vbe_start_addr,
-            surface_data(ds), surface_stride(ds), surface_bits_per_pixel(ds),
-            ctx->rop3 >> 16);
-    if (ctx->dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
-        ctx->dst_bits < vga->vram_ptr + vga->vbe_start_addr +
-        vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
-        memory_region_set_dirty(&vga->vram,
-                                vga->vbe_start_addr + ctx->dst_offset +
-                                ctx->dst.y * ctx->dst_stride,
-                                ctx->dst.height * ctx->dst_stride);
-    }
+    DPRINTF("%p ds: %p %d %d rop: %x\n", vga->vram_ptr, surface_data(ds),
+            surface_stride(ds), surface_bits_per_pixel(ds), ctx->rop3 >> 16);
+    memory_region_set_dirty(&vga->vram,
+                            ctx->dst_offset + ctx->dst.y * ctx->dst_stride,
+                            ctx->dst.height * ctx->dst_stride);
 }
 
 static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
-- 
2.53.0


