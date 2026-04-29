Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D43BFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 17:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI97l-00043p-4n; Wed, 29 Apr 2026 13:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wI97j-00043c-5r
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:54:59 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wI97h-0004b1-9z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:54:58 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 41F47EC00DD;
 Wed, 29 Apr 2026 13:54:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 29 Apr 2026 13:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1777485296; x=1777571696; bh=DSx2jEGCym
 9AXEhGI+vByw+KQISlBYyUyne3gZ0gINA=; b=IeSPa0xsj+pWyu84POnir6yCdm
 2cwLTZ+soln5+LqzNx+4grKhlD09JHECvtiYyMVKeY+Cmpa6RwQ8v6rRtRk5Tusa
 fHrmybeeIpGqvak0SOj+Su40y5clD58XlcQfMdBweoXIRIS3Ryr1cLn9v+l9/MSn
 W8xbwfKO/UzaJz4i3EZwwDAuw9pahtSWfcadEtJ0i7eotw0bkJcBGoNPnjuEVh2a
 886styxD5dh/DqzBTr7NjMvtpBRakllSgeRSWuLxNO1KQjrWytWoflTdQSTkFvub
 8mPixUOVjcrUfQDN8RFTtuj0CSIwtVd4+/KBbWxycmZ4ssyCCwZBPAzUYlMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1777485296; x=1777571696; bh=DSx2jEGCym9AXEhGI+vByw+KQISlBYyUyne
 3gZ0gINA=; b=q7p+m/8g3/12PCaYC5Z3CDXs8f6Uy03Rv56MVhshsiO5DKBYvxT
 blVuM3waTw0CMt7rotIyF1ylqfvqA0ifKEm3WVOutTdSIDx2HWOOPWLbQlRtK3t4
 dSUgS1/FoByA7ose1FYsD/WDaT1m6GsP+kyhjXOkqe/S6SA2oAx9aFKBUjIjKTVw
 9kU6VqNwTSHl1iKa6ZMddCKTQNvja+xe99Xs2KkrVMVq5mqeExhPIYlLNTF+a0jr
 FwxbW8J8wCOCQ5yviw0o9fHjNMb7gOrEPhYIbz+U0J3a006P8Ixue+QcDmfzaEIX
 lq1yGCB0R0SyzMcPHolZYxYCTO9QZad5AAQ==
X-ME-Sender: <xms:70XyafCPI7XXI2b9vhBqu00WCroocrBsI2zQ74mXAubHNDoPEgwanw>
 <xme:70XyacbP4v_FyUzK8O-rMw22ElRW3dY7lvy5iqm6gzHH3dIuYLJbgSbracOG_GNHW
 gjbogLZSXMbQqXVTmeUpXb_hOw-uICNwxWhQ-QtQx8eRbbgF1ow20o>
X-ME-Received: <xmr:70XyaS7u2JsGu8v9v6EjVXmpYefzehbulK5qUHys-YxLVTTw5qPznyp0VOCi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekhedtlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculdejtddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
 rhhomhepvehhrgguucflrggslhhonhhskhhiuceotghhrggusehjrggslhhonhhskhhird
 ighiiiqeenucggtffrrghtthgvrhhnpefhteeugfeujeelteeggfeigeevjeelgeegudfg
 uedvheeghfffudffledukeeiveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidpnhgspghrtghp
 thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrrgigvghlsehrvg
 guhhgrthdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdho
 rhhgpdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhhgrthdrtg
 homhdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthho
 pegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuh
X-ME-Proxy: <xmx:70XyadbnYz2jP3S-qoPOyDgLYCFHdJzUgmJIi0O3-Ofe9zKpkBZzbA>
 <xmx:70XyaRi3MWh8S5vJLsIcD60snzmjOyGEbwRJ0N5EpLmUX7OpCQnwWw>
 <xmx:70Xyae_exqUySM4VEBoBybDb1crsY2Db8ASm8mc4IaizpDJi9u_lkQ>
 <xmx:70XyacrthF7FAnDKzg3gkukK6WqggPlC4hGsf6rWScq4kPRWjh30vA>
 <xmx:8EXyaX3Nfs8Uk44uNeqRAWJkwKPaItrImhbf-zcnlmsav4bGLS1vSuLa>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 13:54:55 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id bbd843ad;
 Wed, 29 Apr 2026 17:54:54 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2] ati-vga: fix ati_set_dirty address calculation
Date: Wed, 29 Apr 2026 13:54:34 -0400
Message-ID: <20260429175434.474429-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.145; envelope-from=chad@jablonski.xyz;
 helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.499,
 FROM_SUSPICIOUS_NTLD_FP=1.999, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
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

This fixes three bugs with the ati_set_dirty address calculation.

First, vbe_start_addr is a word offset. All other values in the
calculation are byte offsets. It must be converted to bytes.

Second, when setting the dirty region with memory_region_set_dirty
the vbe_start_addr is used to calculate the start of the dirty region.
This is a problem because the vbe_start_addr is the offset at which scan out
begins. This puts it in the visible screen coordinate system. The dirty
region however is in the virtual screen coordinate system. This can cause both
overmarking and missed updates. This is removed from the calculation.

Third, when the start address of a blit is outside of the bounds check
the entire blit is missed and not set to dirty. This happens even if the
blit does partially overlap with the visible screen. The fix here is to
find the intersection of the visible screen and the blit and mark only
that region as dirty.

This does not attempt to apply clipping to the blit. So there will be
overmarking in some cases.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 504d1c5708..3192b864fd 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -69,19 +69,31 @@ typedef struct {
 static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
 {
     DisplaySurface *ds = qemu_console_surface(vga->con);
+    unsigned int bypp = ctx->bpp / 8;
+    unsigned long dirty_size = ((ctx->dst.height - 1) * ctx->dst_stride) +
+                               (ctx->dst.width * bypp);
+    uint8_t *dirty_start = ctx->dst_bits + (ctx->dst.y * ctx->dst_stride) +
+                           (ctx->dst.x * bypp);
+    uint8_t *dirty_end = dirty_start + dirty_size;
+    /*
+     * The blit may be outside of the visible screen (e.g. virtual desktops.)
+     * Dirty only the intersection of the visible screen and the blit.
+     */
+    uint8_t *vis_start = vga->vram_ptr + (vga->vbe_start_addr * 4);
+    uint8_t *vis_end = vis_start + vga->vbe_regs[VBE_DISPI_INDEX_YRES] *
+                       vga->vbe_line_offset;
+    uint8_t *start = MAX(vis_start, dirty_start);
+    uint8_t *end = MIN(vis_end, dirty_end);
 
     (void)ds;
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", vga->vram_ptr, vga->vbe_start_addr,
             surface_data(ds), surface_stride(ds), surface_bits_per_pixel(ds),
             ctx->rop3 >> 16);
-    if (ctx->dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
-        ctx->dst_bits < vga->vram_ptr + vga->vbe_start_addr +
-        vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
-        memory_region_set_dirty(&vga->vram,
-                                vga->vbe_start_addr + ctx->dst_offset +
-                                ctx->dst.y * ctx->dst_stride,
-                                ctx->dst.height * ctx->dst_stride);
+
+    if (start >= end) {
+        return;
     }
+    memory_region_set_dirty(&vga->vram, start - vga->vram_ptr, end - start);
 }
 
 static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
-- 
2.53.0


