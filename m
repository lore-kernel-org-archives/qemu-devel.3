Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DD8E6BF18
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlppR-0004lB-Ug; Fri, 30 Jan 2026 09:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppO-0004ir-3q
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:30 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppL-00038T-D6
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:29 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 265937A0167;
 Fri, 30 Jan 2026 09:50:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 30 Jan 2026 09:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1769784626; x=
 1769871026; bh=KRvjY95S9WC5R7utng58A1IuUIjwKpupOAaLfYpwcTM=; b=k
 C6Q8pllQmcTh/ZUGkl6xNKcS3nJUXKAo6+byqh1Xh55BoL3sPYvd9RtBV67Qhto/
 WEJIXmaq3upqXIDN8hH26QWbJTVBYs/eslFoNfkzFL5gKJ0Rj9fBfmgYNuTagakk
 evYHcIokFjHHMbjsHkejIJl5PXCWPVHdIcCkV6c1XTrU0wgW/FV81XDqJsQOFNXN
 s5dEv+BGVt/QZMf/23YUXkuoi1VOK4FtiMpfFmaX7YCguxh/Wk8GPAEecRPbAwsd
 P0LW6Bk9aulEPH3HXeeHzaY0F4J9HzJTHU8I1/pOxw2rLCuZpVGUlqbAo2ljMpyH
 pqEbluOG5lgvni/PR3xhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769784626; x=1769871026; bh=K
 RvjY95S9WC5R7utng58A1IuUIjwKpupOAaLfYpwcTM=; b=vmRAu1z0LsHmkTkfi
 bW84OIN8Tk/oUUhd/IaaQ8Ky8o4sXY9Zqfsj9LUoZ1TgiCn5fRWA5Fn5XyDCmwk8
 VTB+DOj58gOyi1UQy4T5s3Ebl6V+fhXIHMPAFqVFF5rMAPhZlzomGoyIBb3VTk92
 BAS08SlR2BKf7A1vCS0wrpEt3jbsPLHr4eHBm3Pq1IwntUWZ1fHuT3oDy36B8eFp
 u5EsQQtyGVbxul5ZG5Mu0KFrpMgsr9AiwCqybhGYN1dPBMgU+qIUJfYYqcdI5S7y
 IP/3q11F7PL6q78UKb5/XRPrvB8DU4RZjugVAJ+9fJhVmySy9Z4zPKAAsT2+e8oD
 47KTg==
X-ME-Sender: <xms:McV8aTFOdIQTAQjaplSNPdHsK82tV3lWiwFFcCeGPm3ga5ZaG49uvQ>
 <xme:McV8aXxIwyhfN0GXhmZ9VcOFlZbbiLJxCdUsWNpy9AY5OaOD4TOiMux9dooiW4imZ
 apANjFExAjDnkfrr9yEeqwcQJ0OBAQBlnnFEhFU7xx4LcHUZdjBJUs>
X-ME-Received: <xmr:McV8aShNE10hmznuy-r6rIVH5o4M0DjOy0rWo2R6HMO4iHZczkZXqcxuSBp4>
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
X-ME-Proxy: <xmx:McV8aaxNNLI24Hk3WtR7amSSTVuxELrbjkegd2ORdiGSknFM40kVjw>
 <xmx:McV8adIV_woRthx7GVH3iQ-Nv21-Ifycc8ddPil6YOcD-s9HeVHCLw>
 <xmx:McV8aZR3YCCfYggoUayvc-TN-gudNTxLEG_MB8t-lMqKg9n7EB19iw>
 <xmx:McV8adrrxHZ3NS0KbVyt5Ud_p2Vwz_d69975IoN9Mb45qSZZoxtOYQ>
 <xmx:MsV8aVcyxaD1_jBg1M0FDhAtZZSLwnXKsQHAb0icJn9-reFv8ZDHA7dy>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 09:50:25 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id a8f1f6eb;
 Fri, 30 Jan 2026 14:50:19 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v6 15/20] ati-vga: Extract ati_set_dirty helper function
Date: Fri, 30 Jan 2026 09:50:00 -0500
Message-ID: <20260130145005.731129-16-chad@jablonski.xyz>
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

This is done in preparation for the removal of the ATIVGAState *s
parameter. It will also be used by the HOST_DATA implementation.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 39ea67aeb7..5c15c3ec70 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -64,6 +64,19 @@ typedef struct {
     const uint8_t *src_bits;
 } ATI2DCtx;
 
+static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
+{
+    DisplaySurface *ds = qemu_console_surface(vga->con);
+    unsigned dst_offset = ctx->dst_bits - vga->vram_ptr;
+    if (ctx->dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
+        ctx->dst_bits < vga->vram_ptr + vga->vbe_start_addr +
+        vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
+        memory_region_set_dirty(&vga->vram, vga->vbe_start_addr +
+                                dst_offset + ctx->dst.y * surface_stride(ds),
+                                ctx->dst.height * surface_stride(ds));
+    }
+}
+
 static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
 {
     ctx->bpp = ati_bpp_from_datatype(s);
@@ -105,14 +118,12 @@ static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx, uint8_t use_pixman)
 {
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
-    DisplaySurface *ds = qemu_console_surface(s->vga.con);
     bool use_pixman_fill = use_pixman & BIT(0);
     bool use_pixman_blt = use_pixman & BIT(1);
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
             ctx->rop3 >> 16);
-    unsigned dst_offset = s->regs.dst_offset;
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
         return;
@@ -261,14 +272,6 @@ static void ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx, uint8_t use_pixman)
                       ctx->rop3 >> 16);
         return;
     }
-
-    if (ctx->dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
-        ctx->dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
-        s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
-        memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
-                                dst_offset + ctx->dst.y * surface_stride(ds),
-                                ctx->dst.height * surface_stride(ds));
-    }
 }
 
 void ati_2d_blt(ATIVGAState *s)
@@ -276,4 +279,5 @@ void ati_2d_blt(ATIVGAState *s)
     ATI2DCtx ctx;
     setup_2d_blt_ctx(s, &ctx);
     ati_2d_do_blt(s, &ctx, s->use_pixman);
+    ati_set_dirty(&s->vga, &ctx);
 }
-- 
2.52.0


