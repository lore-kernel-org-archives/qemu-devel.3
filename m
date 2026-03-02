Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FBAEB362A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7e1-0006S0-RE; Mon, 02 Mar 2026 13:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dp-0006Lf-I2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:13 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dm-0006Yq-Dc
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:13 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 217B0EC031C;
 Mon,  2 Mar 2026 13:05:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 02 Mar 2026 13:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772474707; x=
 1772561107; bh=Pgj/JWn+AGpuGyRS+nBPcELdliW/L17J0+MU/TDro/o=; b=S
 W/l81FY4wzLeL2X0UIep/UAeQB4+slknY1dVUINEL3UZOTRlMPWe5aJ85F7JKsxs
 5qXj0FOprvi/LDWFiHYUDch9xeEj/cNeeVsKBwCfApqCe57CkBCob1GKpJt//jxU
 KtaoGFFomzKnjDktns0PITE4gwWTx+1oEMxfDJuuZHilNxSE26zvScxb8vzRaPfz
 k0K1V9qHO7s7Y9CrD9QVFPtaT3niuNx8HPriJ8gxfj9cmgUWfN2hmjUklzrNqJh2
 Dy2L7BMd+C+6e9ZxA6UvZcb57pzwhciSQjax6u6ufOafwDKIUpR4vxdbkLyT/lSJ
 YbCgOh/VEEq3gFY2Yzn7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772474707; x=1772561107; bh=P
 gj/JWn+AGpuGyRS+nBPcELdliW/L17J0+MU/TDro/o=; b=yMdIHKsXQsu3jxmTf
 3XkqJi7x2tANdl0qocR4o24F5QrQQso5w+0L914a90L7Q2IddRUNHM0l3dOWDnHp
 cICGWx1T9sq/lLYldzTzKydrlYNdO07DgejD8UzTUxFXwiaEoyhhjvzBR6aN3RJr
 y4s5UXBNPzZBjvnq8HJ/EnYseKCTFVYIjNhaqRAwe//DSvMbR4txHRw0rRgG8iRG
 uvyTaC5YO1deHoLNj0j0iFYu+yiZwdWiuHOi+mG/84IK/IkTJlh5hBx5DaUB5EY2
 EFWqYZf6dW4mnte5OAHRp3bV1HWLkjNlrwphneBZguhFWUXgnJMNzggCUtMO+Df9
 B4ahg==
X-ME-Sender: <xms:UtGlachG_0Dm8N-bG-GqHJ1X0HSzb-nYaHZv2UKPOtgRckK9V9VkSw>
 <xme:UtGlab651dGoG0pDYMHsSijyk0uj1MVvQbkeQMWJs7zO6nD8YQxK7C-yPeZ1blEp7
 71xsEklIHuGHRTBZAbNOfKdT3nApp32Ub2axac8DEnN2WBQpUvTlA>
X-ME-Received: <xmr:UtGlacZcG__wLPNEi3UeMFcV1rYqznoDHm1eLL4qBDedLKX3ySOta-PHIjvJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgepudenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtggrnh
 gurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhrrgigvghl
 sehrvgguhhgrthdrtghomhdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrd
 hhuhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghp
 thhtoheptghhrggusehjrggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:UtGlaY6OKfTe4VExNTmLvGcYcxt1oVqQ83UUZnjRbtVALssTiwWfyA>
 <xmx:U9GlaXADww_GLRV9C336UPDTGeun-irqJJu14rC6rxtb1a_MF_hNfw>
 <xmx:U9GlaWdwWzqfA_2V4cvAM0X-Ix_-ejd8qOOtBAfJVQs_lfVl0sh7jg>
 <xmx:U9GlaeKtGEceE9rIxgpT0e0cKBcCh2MyRckdbrMI0qTcdAJC1oWy8g>
 <xmx:U9GlafXIN3rAd3xQh7wZS91m0Fsznl5ZU--71RYx_FhHBwd7a8Qlz2ej>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:05:06 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 8ca07db7;
 Mon, 2 Mar 2026 18:04:57 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v10 17/17] ati-vga: Implement HOST_DATA flush to VRAM
Date: Mon,  2 Mar 2026 13:04:47 -0500
Message-ID: <20260302180447.1078098-18-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302180447.1078098-1-chad@jablonski.xyz>
References: <20260302180447.1078098-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=chad@jablonski.xyz;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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

Implement flushing the 128-bit HOST_DATA accumulator to VRAM to enable
text rendering in X. Supports all datatypes (monochrome frgd/bkgd,
monochrome frgd, and color), however monochrome frgd support is
partial and does not properly handle transparency/leave-alone.

The flush is broken up into two steps. First, if necessary, expansion of the
monochrome bits to the destination color depth. Then the expanded pixels
are sent to the ati_2d_do_blt one scanline at a time. ati_2d_do_blt then
clips and performs the blit.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      |   5 +-
 hw/display/ati_2d.c   | 128 +++++++++++++++++++++++++++++++++++++++++-
 hw/display/ati_int.h  |   3 +
 hw/display/ati_regs.h |   4 ++
 4 files changed, 135 insertions(+), 5 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 965110c13a..01969c9866 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1037,7 +1037,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         }
         s->host_data.acc[s->host_data.next++] = data;
         if (s->host_data.next >= 4) {
-            qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
+            ati_flush_host_data(s);
             s->host_data.next = 0;
         }
         break;
@@ -1046,8 +1046,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
             break;
         }
         s->host_data.acc[s->host_data.next] = data;
-        qemu_log_mask(LOG_UNIMP,
-                      "HOST_DATA finish flush not yet implemented\n");
+        ati_finish_host_data(s);
         break;
     default:
         break;
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index e240093f12..6c357259ba 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -47,6 +47,7 @@ static int ati_bpp_from_datatype(const ATIVGAState *s)
 typedef struct {
     int bpp;
     uint32_t rop3;
+    bool host_data_active;
     bool left_to_right;
     bool top_to_bottom;
     uint32_t frgd_clr;
@@ -85,6 +86,7 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
 {
     ctx->bpp = ati_bpp_from_datatype(s);
     ctx->rop3 = s->regs.dp_mix & GMC_ROP3_MASK;
+    ctx->host_data_active = s->host_data.active;
     ctx->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
     ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
     ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
@@ -181,10 +183,10 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
             return false;
         }
         int src_stride_words = ctx->src_stride / sizeof(uint32_t);
-        if (vis_src.x > 0x3fff || vis_src.y > 0x3fff
+        if (!ctx->host_data_active && (vis_src.x > 0x3fff || vis_src.y > 0x3fff
             || ctx->src_bits >= ctx->vram_end
             || ctx->src_bits + vis_src.x + (vis_src.y + vis_dst.height)
-             * ctx->src_stride >= ctx->vram_end) {
+             * ctx->src_stride >= ctx->vram_end)) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return false;
         }
@@ -298,8 +300,130 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 void ati_2d_blt(ATIVGAState *s)
 {
     ATI2DCtx ctx;
+    uint32_t src_source = s->regs.dp_mix & DP_SRC_SOURCE;
+
+    /* Finish any active HOST_DATA blits before starting a new blit */
+    ati_finish_host_data(s);
+
+    if (src_source == DP_SRC_HOST || src_source == DP_SRC_HOST_BYTEALIGN) {
+        /* Begin a HOST_DATA blit */
+        s->host_data.active = true;
+        s->host_data.next = 0;
+        s->host_data.col = 0;
+        s->host_data.row = 0;
+        return;
+    }
     setup_2d_blt_ctx(s, &ctx);
     if (ati_2d_do_blt(&ctx, s->use_pixman)) {
         ati_set_dirty(&s->vga, &ctx);
     }
 }
+
+bool ati_flush_host_data(ATIVGAState *s)
+{
+    ATI2DCtx ctx, chunk;
+    uint32_t fg = s->regs.dp_src_frgd_clr;
+    uint32_t bg = s->regs.dp_src_bkgd_clr;
+    unsigned bypp, pix_count, row, col, idx;
+    uint8_t pix_buf[ATI_HOST_DATA_ACC_BITS * sizeof(uint32_t)];
+    uint32_t byte_pix_order = s->regs.dp_datatype & DP_BYTE_PIX_ORDER;
+    uint32_t src_source = s->regs.dp_mix & DP_SRC_SOURCE;
+    uint32_t src_datatype = s->regs.dp_datatype & DP_SRC_DATATYPE;
+
+    if (!s->host_data.active) {
+        return false;
+    }
+    if (src_source != DP_SRC_HOST) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "host_data_blt: unsupported src_source %x\n", src_source);
+        return false;
+    }
+    if (src_datatype != SRC_MONO_FRGD_BKGD && src_datatype != SRC_MONO_FRGD &&
+        src_datatype != SRC_COLOR) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "host_data_blt: undefined src_datatype %x\n",
+                      src_datatype);
+        return false;
+    }
+
+    setup_2d_blt_ctx(s, &ctx);
+
+    if (!ctx.left_to_right || !ctx.top_to_bottom) {
+        qemu_log_mask(LOG_UNIMP,
+                      "host_data_blt: unsupported blit direction %c%c\n",
+                      ctx.left_to_right ? '>' : '<',
+                      ctx.top_to_bottom ? 'v' : '^');
+        return false;
+    }
+
+    bypp = ctx.bpp / 8;
+
+    if (src_datatype == SRC_COLOR) {
+        pix_count = ATI_HOST_DATA_ACC_BITS / ctx.bpp;
+        memcpy(pix_buf, &s->host_data.acc[0], 4 * sizeof(uint32_t));
+    } else {
+        pix_count = ATI_HOST_DATA_ACC_BITS;
+        /* Expand monochrome bits to color pixels */
+        idx = 0;
+        for (int word = 0; word < 4; word++) {
+            for (int byte = 0; byte < 4; byte++) {
+                uint8_t byte_val = s->host_data.acc[word] >> (byte * 8);
+                for (int i = 0; i < 8; i++) {
+                    bool is_fg = byte_val & BIT(byte_pix_order ? i : 7 - i);
+                    uint32_t color = is_fg ? fg : bg;
+                    stn_he_p(&pix_buf[idx], bypp, color);
+                    idx += bypp;
+                }
+            }
+        }
+    }
+
+    /* Copy and then modify blit ctx for use in a chunked blit */
+    chunk = ctx;
+    chunk.src_bits = pix_buf;
+    chunk.src.y = 0;
+    chunk.src_stride = ATI_HOST_DATA_ACC_BITS * bypp;
+
+    /* Blit one scanline chunk at a time */
+    row = s->host_data.row;
+    col = s->host_data.col;
+    idx = 0;
+    DPRINTF("blt %dpx @ row: %d, col: %d\n", pix_count, row, col);
+    while (idx < pix_count && row < ctx.dst.height) {
+        unsigned pix_in_scanline = MIN(pix_count - idx,
+                                       ctx.dst.width - col);
+        chunk.src.x = idx;
+        /* Build a rect for this scanline chunk */
+        chunk.dst.x = ctx.dst.x + col;
+        chunk.dst.y = ctx.dst.y + row;
+        chunk.dst.width = pix_in_scanline;
+        chunk.dst.height = 1;
+        DPRINTF("blt %dpx span @ row: %d, col: %d to dst (%d,%d)\n",
+                pix_in_scanline, row, col, chunk.dst.x, chunk.dst.y);
+        if (ati_2d_do_blt(&chunk, s->use_pixman)) {
+            ati_set_dirty(&s->vga, &chunk);
+        }
+        idx += pix_in_scanline;
+        col += pix_in_scanline;
+        if (col >= ctx.dst.width) {
+            col = 0;
+            row += 1;
+        }
+    }
+
+    /* Track state of the overall blit for use by the next flush */
+    s->host_data.row = row;
+    s->host_data.col = col;
+    if (s->host_data.row >= ctx.dst.height) {
+        s->host_data.active = false;
+    }
+
+    return s->host_data.active;
+}
+
+void ati_finish_host_data(ATIVGAState *s)
+{
+    while (ati_flush_host_data(s)) {
+        continue;
+    }
+}
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index baa264215c..071d3af47c 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -32,6 +32,7 @@
 
 #define ATI_RAGE128_LINEAR_APER_SIZE (64 * MiB)
 #define ATI_R100_LINEAR_APER_SIZE (128 * MiB)
+#define ATI_HOST_DATA_ACC_BITS 128
 
 #define TYPE_ATI_VGA "ati-vga"
 OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
@@ -126,5 +127,7 @@ struct ATIVGAState {
 const char *ati_reg_name(int num);
 
 void ati_2d_blt(ATIVGAState *s);
+bool ati_flush_host_data(ATIVGAState *s);
+void ati_finish_host_data(ATIVGAState *s);
 
 #endif /* ATI_INT_H */
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 48f15e9b1d..b813fa119e 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -397,7 +397,11 @@
 #define DST_32BPP                               0x00000006
 #define DP_DST_DATATYPE                         0x0000000f
 #define DP_BRUSH_DATATYPE                       0x00000f00
+#define SRC_MONO_FRGD_BKGD                      0x00000000
+#define SRC_MONO_FRGD                           0x00010000
+#define SRC_COLOR                               0x00030000
 #define DP_SRC_DATATYPE                         0x00030000
+#define DP_BYTE_PIX_ORDER                       0x40000000
 
 #define BRUSH_SOLIDCOLOR                        0x00000d00
 
-- 
2.52.0


