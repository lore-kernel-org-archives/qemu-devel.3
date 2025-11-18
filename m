Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43264CEE330
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNyO-0006k4-J5; Tue, 18 Nov 2025 10:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwv-000515-TF
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:58 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwt-0001xd-Rv
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:57 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 4270E1D00254;
 Tue, 18 Nov 2025 10:48:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 18 Nov 2025 10:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1763480918; x=
 1763567318; bh=MEKPQ/5QkQOI38vCicNvNTZNvNWJjbMdB3KIU43gg9I=; b=X
 PhC6OGd8C7IOIsFkWxw3tc5H+3DwO/NAZG07zV87364luLZN7CTO7zvNpaMYeN7X
 20K1/gWkDdh4ERDi3gSIhOP3w5fC35fSmW6IyAP/wg/9Kcf+DMT6NGJF+sGn5vKK
 ATVz1WZ9mEsNhYDTcNGmsY1RQILVbFBUlrFXqhh/cT0bnL6Q1LNmRZp4yhQe7M9M
 5TtAaS2kLGmFKReHeQYJdaNX0/F4qAOJx+8+17thOGIVW73cfwD05TLXshMkq5/K
 +4EZsXHsgtYCtgLWN5ZuTER3cu7/+fTeyjaTWsgnifvG2qTxpJUrBtxmjLJtmw8G
 l32Zyk4chy3uYWK0+lq7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1763480918; x=1763567318; bh=M
 EKPQ/5QkQOI38vCicNvNTZNvNWJjbMdB3KIU43gg9I=; b=IeexcOGUYn3WuAlJz
 0CQLBgCcifc6yRUm3rSpa3BPDhDo1W6NKqCkQ55HmU4Ojc3BcXeSn5zfakKoFi2F
 2pmRGj2c0jWqvCx/QQfbR5gytb2ONhv6wH+hzZzyK1rAAMffLepPgw0imvZP48ow
 +Ewn/HXg+MhziWrGLQw2sfEyIKiYBhilDgA3+gjMsEQzJMkaiUP60SCV4nbqZ8nM
 3BolG/ZgnW9lizeIVz44wyq5eggKJSN+BlHruXq35R0GxX8ljZfho4Su2lwzAcjf
 FjQmWy1eDuKXOJ9ft+k1ZFeuRlZl4ubu0O1IAEicpzwO4yovKHAzRQk16KrmbanI
 KrrHg==
X-ME-Sender: <xms:VpUcaT-8eooy1L78B6Bz1YGfdBZY6KOdSN5QiTgWTIRGqnIZ2slJRw>
 <xme:VpUcaXK4SBmYPjGgElO01lsY9tI3daE1ZMlbaSMH1sgi2ApzEnHen1119GPVCMNqc
 aLiiY352zH6SGvagG2GxeGHFtZYsTl-C-Et4Eii-YVuXJNVOZcpc4Y>
X-ME-Received: <xmr:VpUcaeb8QjM0XSrtouFvkAbRCJBlB9oD3nh4QAugqLEntOn8NBZBu_GEuwTJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddujedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhope
 gsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:VpUcaZLVjoMtIQiuLubLu9IKw8RRZ65RiBwiVC0jLlmKZErR0A1hNg>
 <xmx:VpUcacCWq0BfD1dMRqlB-oh704jYfVSee9nn6hcbAqfgvNfgWpORwg>
 <xmx:VpUcaeowETaCg5x852QTMZFtZCzEg2qLybrTC5UkWL3z-FIotyXndg>
 <xmx:VpUcaXgZz-jkXe8DeaWCk0p5FVDrHsXfLBlrslB2MCoYJY7RW7U4vg>
 <xmx:VpUcaZ0twrpFavQjMyD5SGNeypkG5SlLVo6OjDHX8EyHh7rAmJkET1ur>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 10:48:37 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id a3116f29;
 Tue, 18 Nov 2025 15:48:31 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 11/11] ati-vga: Implement HOST_DATA flush to VRAM
Date: Tue, 18 Nov 2025 10:48:12 -0500
Message-ID: <20251118154812.57861-12-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118154812.57861-1-chad@jablonski.xyz>
References: <20251118154812.57861-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.145; envelope-from=chad@jablonski.xyz;
 helo=fout-b2-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
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

Implement flushing the 128-bit HOST_DATA accumulator to VRAM to enable
text rendering in X. Currently supports only the monochrome
foreground/background datatype with the SRCCOPY ROP.

The flush is broken up into two steps for clarity. First, expansion of the
monochrome bits to the destination color depth. Then the expanded pixels
are clipped and copied into VRAM.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      |   4 +-
 hw/display/ati_2d.c   | 127 ++++++++++++++++++++++++++++++++++++++++++
 hw/display/ati_int.h  |   3 +
 hw/display/ati_regs.h |  13 +++++
 4 files changed, 145 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index dc302eb6f2..c5892a6305 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1038,7 +1038,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case HOST_DATA7:
         s->host_data.acc[s->host_data.next] = data;
         if (s->host_data.next >= 3) {
-            qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
+            ati_flush_host_data(s);
             s->host_data.next = 0;
             break;
         }
@@ -1046,7 +1046,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         break;
     case HOST_DATA_LAST:
         s->host_data.acc[s->host_data.next] = data;
-        qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
+        ati_flush_host_data(s);
         ati_host_data_reset(&s->host_data);
         break;
     default:
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index e30a4cd941..2cd5348965 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -123,6 +123,12 @@ static ATIBlitDest setup_2d_blt_dst(ATIVGAState *s)
 
 void ati_2d_blt(ATIVGAState *s)
 {
+    uint32_t src = s->regs.dp_gui_master_cntl & GMC_SRC_SOURCE_MASK;
+    if (src == GMC_SRC_SOURCE_HOST_DATA) {
+        /* HOST_DATA blits are handled separately by ati_flush_host_data() */
+        return;
+    }
+
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
     DisplaySurface *ds = qemu_console_surface(s->vga.con);
@@ -299,3 +305,124 @@ void ati_2d_blt(ATIVGAState *s)
                       (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
     }
 }
+
+void ati_flush_host_data(ATIVGAState *s)
+{
+    DisplaySurface *ds;
+    unsigned src = s->regs.dp_gui_master_cntl & GMC_SRC_SOURCE_MASK;
+    unsigned src_datatype = s->regs.dp_gui_master_cntl & GMC_SRC_DATATYPE_MASK;
+    unsigned rop = s->regs.dp_mix & GMC_ROP3_MASK;
+    ATIBlitDest dst;
+    bool lsb_to_msb;
+    uint32_t fg, bg;
+    unsigned bypp, row, col, idx;
+    uint8_t pix_buf[ATI_HOST_DATA_ACC_BITS * sizeof(uint32_t)];
+
+    if (src != GMC_SRC_SOURCE_HOST_DATA) {
+        qemu_log_mask(LOG_UNIMP,
+                      "host_data_blt: only GMC_SRC_SOURCE_HOST_DATA "
+                      "supported\n");
+        return;
+    }
+
+    if (src_datatype != GMC_SRC_DATATYPE_MONO_FRGD_BKGD) {
+        qemu_log_mask(LOG_UNIMP,
+                      "host_data_blt: only GMC_SRC_DATATYPE_MONO_FRGD_BKGD "
+                      "supported\n");
+        return;
+    }
+
+    if (rop != ROP3_SRCCOPY) {
+        qemu_log_mask(LOG_UNIMP,
+                      "host_data_blt: only ROP3_SRCCOPY supported. rop: %x\n",
+                      rop);
+        return;
+    }
+
+    dst = setup_2d_blt_dst(s);
+    if (!dst.valid) {
+        return;
+    }
+
+    if (!dst.left_to_right || !dst.top_to_bottom) {
+        qemu_log_mask(LOG_UNIMP, "host_data_blt: only L->R, T->B supported\n");
+        return;
+    }
+
+    lsb_to_msb = s->regs.dp_gui_master_cntl & GMC_BYTE_ORDER_LSB_TO_MSB;
+    fg = s->regs.dp_src_frgd_clr;
+    bg = s->regs.dp_src_bkgd_clr;
+    bypp = dst.bpp / 8;
+
+    /* Expand monochrome bits to color pixels */
+    idx = 0;
+    for (int word = 0; word < 4; word++) {
+        for (int i = 0; i < 32; i++) {
+            int bit = lsb_to_msb ? i : (31 - i);
+            bool is_fg = extract32(s->host_data.acc[word], bit, 1);
+            uint32_t color = is_fg ? fg : bg;
+            stn_he_p(&pix_buf[idx * bypp], bypp, color);
+            idx += 1;
+        }
+    }
+
+    /* Copy to VRAM one scanline at a time */
+    row = s->host_data.row;
+    col = s->host_data.col;
+    idx = 0;
+    while (idx < ATI_HOST_DATA_ACC_BITS && row < dst.rect.height) {
+        uint8_t *vram_dst;
+        unsigned start_col, end_col, vis_row, num_pix, pix_idx;
+        unsigned pix_in_scanline = MIN(ATI_HOST_DATA_ACC_BITS -
+                                       idx, dst.rect.width - col);
+
+        /* Row-based clipping */
+        if (row < dst.src_top_offset ||
+            row >= dst.src_top_offset + dst.visible.height) {
+            goto skip_pix;
+        }
+
+        /* Column-based clipping */
+        start_col = MAX(col, dst.src_left_offset);
+        end_col = MIN(col + pix_in_scanline,
+                      dst.src_left_offset + dst.visible.width);
+        if (end_col <= start_col) {
+            goto skip_pix;
+        }
+
+        /* Copy expanded bits/pixels to VRAM */
+        vis_row = row - dst.src_top_offset;
+        num_pix = end_col - start_col;
+        vram_dst = dst.bits +
+                   (dst.visible.y + vis_row) * dst.stride +
+                   (dst.visible.x + (start_col - dst.src_left_offset)) * bypp;
+
+        pix_idx = (idx + (start_col - col)) * bypp;
+        memcpy(vram_dst, &pix_buf[pix_idx], num_pix * bypp);
+
+    skip_pix:
+        idx += pix_in_scanline;
+        col += pix_in_scanline;
+        if (col >= dst.rect.width) {
+            col = 0;
+            row += 1;
+        }
+    }
+    /* Track state of the overall blit for use by the next flush */
+    s->host_data.row = row;
+    s->host_data.col = col;
+
+    /*
+     * TODO: This is setting the entire blit region to dirty.
+     *       We maybe just need this tiny section?
+     */
+    ds = qemu_console_surface(s->vga.con);
+    if (dst.bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
+        dst.bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
+        s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
+        memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
+                                s->regs.dst_offset +
+                                dst.visible.y * surface_stride(ds),
+                                dst.visible.height * surface_stride(ds));
+    }
+}
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index b9142ce6d8..f38f6a43d7 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -34,6 +34,8 @@
 #define ATI_RAGE128_LINEAR_APER_SIZE (64 * MiB)
 #define ATI_R100_LINEAR_APER_SIZE (128 * MiB)
 
+#define ATI_HOST_DATA_ACC_BITS 128
+
 #define TYPE_ATI_VGA "ati-vga"
 OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
 
@@ -126,5 +128,6 @@ struct ATIVGAState {
 const char *ati_reg_name(int num);
 
 void ati_2d_blt(ATIVGAState *s);
+void ati_flush_host_data(ATIVGAState *s);
 
 #endif /* ATI_INT_H */
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 9eb68fbec6..8f3335817f 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -404,6 +404,7 @@
 #define GMC_BRUSH_SOLIDCOLOR                    0x000000d0
 #define GMC_SRC_DSTCOLOR                        0x00003000
 #define GMC_BYTE_ORDER_MSB_TO_LSB               0x00000000
+#define GMC_BYTE_ORDER_LSB_TO_MSB               0x00004000
 #define GMC_DP_SRC_RECT                         0x02000000
 #define GMC_3D_FCN_EN_CLR                       0x00000000
 #define GMC_AUX_CLIP_CLEAR                      0x20000000
@@ -431,6 +432,18 @@
 #define GMC_DST_CLIP_DEFAULT                    0x00000000
 #define GMC_DST_CLIP_LEAVE_ALONE                0x00000008
 
+/* DP_GUI_MASTER_CNTL DP_SRC_DATATYPE named constants */
+#define GMC_SRC_DATATYPE_MASK                   0x00003000
+#define GMC_SRC_DATATYPE_MONO_FRGD_BKGD         0x00000000
+#define GMC_SRC_DATATYPE_MONO_FRGD              0x00001000
+#define GMC_SRC_DATATYPE_COLOR                  0x00003000
+
+/* DP_GUI_MASTER_CNTL DP_SRC_SOURCE named constants */
+#define GMC_SRC_SOURCE_MASK                     0x07000000
+#define GMC_SRC_SOURCE_MEMORY                   0x02000000
+#define GMC_SRC_SOURCE_HOST_DATA                0x03000000
+#define GMC_SRC_SOURCE_HOST_DATA_ALIGNED        0x04000000
+
 /* DP_GUI_MASTER_CNTL ROP3 named constants */
 #define GMC_ROP3_MASK                           0x00ff0000
 #define ROP3_BLACKNESS                          0x00000000
-- 
2.51.0


