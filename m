Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2620CE6BF17
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlppR-0004kL-0Q; Fri, 30 Jan 2026 09:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppO-0004j2-VN
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:30 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppL-00038U-GE
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:30 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 581427A0168;
 Fri, 30 Jan 2026 09:50:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 30 Jan 2026 09:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1769784626; x=
 1769871026; bh=uCYbYki+RrEf0+bAMdGHQku8jFfKWrGr3ucgiXfFkIw=; b=p
 pNhS6svsD8drA+muQlDtT9fpU+gdJs4lVi3/QXhE+zNH3AXTeNmhWtgpRuZS3Z5G
 /XF6YRATfXHJuH5oy63ki7BEnQ/2XtFPMJ8Xbn/FBJ0+WL+VrIRbm2C3RlxaFvuC
 RBlS16mfiJtX+hgt3uhD/Y0sVxrdjtYXLFTQ6b2NDH4Fiy4UuSMj2d5xogGMQWgQ
 jKp4hIhYP5U88kX1J1nKXdqKLPxHxE9A1lhQ3rK3pU6RnVMhW/f4weGEun45Ux7U
 bec+DCwvzGSP5PcKyeIuJ7vwsOVMdL7ifmeZwEvJxOSOZdnfX9FDCfcdhqNGRq48
 D+K06X7eCo7cnPutXuVvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769784626; x=1769871026; bh=u
 CYbYki+RrEf0+bAMdGHQku8jFfKWrGr3ucgiXfFkIw=; b=ObvD9AM0jh8YjczJi
 2e7YWkBe3EpG1scMk0c0VqmQVaMkKa3Jw/yDzjkmDWf6csAUwicZFtgD6ycOrvjA
 6zi0n+Hf9valgxliCsbQJBEwx46jG9yz9qKd29ULFLSMrju5xJgurP9FbwL/1hpd
 XF12Fl/H03REzu9qnJNcCIupzOFQ9NJejuvzX5kpwaXn32uDvko7uUeHJo5Aafzl
 E0yTCASRWq54FdYzsLKBTg22vsP6J71za+QrgZHZe91wXEE2QDXrX8RjP4t9YkdQ
 OSkG0unHAJe3KxlEN964gxM32KyBYU1I3MSgQrud+1F88utsJIGcfTBwAihEb5gu
 OjVmw==
X-ME-Sender: <xms:MsV8aaOXxOupKD3EiPznEAOVEfXebylH5Gu8SRMMJYK9ZCtQ_OVX2g>
 <xme:MsV8aQb6Btl2dTMI2BnA5T8iicONGnZhnr3ZBAyuUrwHZ8aBcdl4iXn548uWYVdpa
 24BbbH2NzXHxk1_waPuFDz7_fmhtxJZOhia6dnotHasosw40Xf3Npo>
X-ME-Received: <xmr:MsV8aergn5KL3DgnnWoW0pSSXUXFY25iVmuUjiIOur7EtJVRkQwxOZVRVpPD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhope
 gsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:MsV8aUaDpz4SShOlxGdEBOVz7GdRNM1UIF23O4idthB6HoqdGZ7C1g>
 <xmx:MsV8aWRELVCnag8FZbvZ1Nxsr0parxk-0WCl4DNXf00CMeXdziAmTg>
 <xmx:MsV8ab53eZ1XB3LU7mXKHJa2ehkSmnyNkndq97nNO48PEtB3MkxRcA>
 <xmx:MsV8aby5R8PeNSJdiPYcQFRkh1wFL_kYDPhy_xoNwVSURvOhLHxgfQ>
 <xmx:MsV8aZEM_cMGODWYm50vXjHvh7RTBV8SevGDSn98kXEj_ShnLBIn6ysh>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 09:50:25 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id ab85122e;
 Fri, 30 Jan 2026 14:50:19 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v6 16/20] ati-vga: Remove ATIVGAState param from ati_2d_do_blt
Date: Fri, 30 Jan 2026 09:50:01 -0500
Message-ID: <20260130145005.731129-17-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130145005.731129-1-chad@jablonski.xyz>
References: <20260130145005.731129-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.153; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b2-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
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

This completes the decoupling from the ATIVGAState struct.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 5c15c3ec70..89a9d006af 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -68,6 +68,10 @@ static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
 {
     DisplaySurface *ds = qemu_console_surface(vga->con);
     unsigned dst_offset = ctx->dst_bits - vga->vram_ptr;
+    DPRINTF("%p %u ds: %p %d %d rop: %x\n", vga->vram_ptr,
+            vga->vbe_start_addr, surface_data(ds), surface_stride(ds),
+            surface_bits_per_pixel(ds),
+            ctx->rop3 >> 16);
     if (ctx->dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
         ctx->dst_bits < vga->vram_ptr + vga->vbe_start_addr +
         vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
@@ -114,16 +118,12 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
     }
 }
 
-static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx, uint8_t use_pixman)
+static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 {
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
     bool use_pixman_fill = use_pixman & BIT(0);
     bool use_pixman_blt = use_pixman & BIT(1);
-    DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
-            s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
-            surface_bits_per_pixel(ds),
-            ctx->rop3 >> 16);
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
@@ -140,9 +140,8 @@ static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx, uint8_t use_pixman)
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return;
     }
-    DPRINTF("%d %d %d, %d %d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
-            s->regs.src_offset, dst_offset, s->regs.default_offset,
-            ctx->src_stride, ctx->dst_stride, s->regs.default_pitch,
+    DPRINTF("%d %d, (%d,%d) -> (%d,%d) %dx%d %c %c\n",
+            ctx->src_stride, ctx->dst_stride,
             ctx->src.x, ctx->src.y, ctx->dst.x, ctx->dst.y,
             ctx->dst.width, ctx->dst.height,
             (ctx->left_to_right ? '>' : '<'),
@@ -278,6 +277,6 @@ void ati_2d_blt(ATIVGAState *s)
 {
     ATI2DCtx ctx;
     setup_2d_blt_ctx(s, &ctx);
-    ati_2d_do_blt(s, &ctx, s->use_pixman);
+    ati_2d_do_blt(&ctx, s->use_pixman);
     ati_set_dirty(&s->vga, &ctx);
 }
-- 
2.52.0


