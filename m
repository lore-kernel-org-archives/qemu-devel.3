Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677F3D4A5E4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 02:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgZoR-0005xT-II; Thu, 15 Jan 2026 21:43:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZo4-0005qo-N5
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:28 -0500
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vgZo0-0002SS-Hf
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 21:43:24 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 0C83A1D000A0;
 Thu, 15 Jan 2026 21:43:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 15 Jan 2026 21:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1768531393; x=
 1768617793; bh=zGvttkKy0pDSpTQds3P1akklhdg1e4l+VNLCN/ge4Jw=; b=B
 9bRBmS63uO4ViZ8rV3SWK75EC0aTOWqTYUKEzWwXPhzx6oBePx4s5YiGUfqiYbTb
 7/0bo5PYc2R7qWB15/97lY4rp66fqZLDvUKFqvkYZEHVP60b4qqfdyAl5jT7V7zk
 NJ5C1kjIhiRRcWempAbYENyi4DjnIOAR0F47Cbz25QbR79O2NlBgzuy2mw37+G+K
 fy07q9LDBKv9vjTtj0Igy/BWSf7HLn5mqx4T9MeFaRNxe2hSOVsPKoOhOdlvjqJN
 GI9n+k7xP43hDjT+WYm/LuTjCI7EHQQ4M8v+ZyHn+cbyjSAFYl9yXusYIXZrmeEy
 32a0YZlGyF2FuXAiQh5bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1768531393; x=1768617793; bh=z
 GvttkKy0pDSpTQds3P1akklhdg1e4l+VNLCN/ge4Jw=; b=hAWPNqGf12XL5ePBb
 LeK2CUlO8YX8PZzBO+Wv85zLn40ivZPEcxnLRz6eM9J4v8RV5ngI9vHA93n5IUQe
 AZt7PT9Uu+Z+qmQxrjk6A2KVKovtlLD8by1l3lGFuyBSwZ/3h/c0czNHsx2+K3tf
 xhKTbXgbSUklPCMcO9mbMOMvPg2xQylUL5i2Zaa9e68al2qlxW5AYCJYsI7ValgS
 0NBqtaVAclLPhY5TCmRdVCHZnSpT/Y0hvrDEdkrVwBFOJiRT2XlP5W4AYzBJMm22
 eogvEsbPaiU9pdu3fXsFuThj2cFvU/kuEGLy9fAtMRiHNB4M5/Gldf97bxgWN7OX
 iq8yg==
X-ME-Sender: <xms:waVpaeE5Hehwyt-Fcr7y0E6DyaoDMNaFu2QN1-xJ1LxYibYsPkWbcg>
 <xme:waVpaWzCr0F1p5ATvWlnhUxy5Vb9s9qaDjUWk7IF1PyGUu77gzlavyv27YARTsVqA
 eLnuvG1c957nBZtjFp73apcXSkHOy4GmA9i5h8U7hIFyyZz9J54f7o>
X-ME-Received: <xmr:waVpaVjYkPgJdo2n53NRL-lGaSSi203MPF0QEl0BEuSfdc2zPw4KFflyt-1R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejjeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepsggrlhgrthho
 nhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:waVpaRyx9aHG8F83v0CfxwnFoL_yV7jzNGcmC-DN0bjYZ9gdjKd01g>
 <xmx:waVpaYIM7ar8j9sE5Tu6-AIyjRWV3BETzv_ImU2cfGThpVoNv8pQcQ>
 <xmx:waVpaYSglA5KPTYNfS6C4xg0NXVt1FuQ4kAaduwmryuFyAz3hkWKCw>
 <xmx:waVpaQr6AZ3KkyM9F1QpzUspbbUepnRaKckiDrcUfpffbrEDYOgTyQ>
 <xmx:waVpacdU2XsxZLvAiA9mKRwSQF6s9HS5ZqtHlGbsMaJJIC7w31mcpLcV>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 21:43:13 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id aa2df0d7;
 Fri, 16 Jan 2026 02:43:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v5 12/12] ati-vga: Implement HOST_DATA flush to VRAM
Date: Thu, 15 Jan 2026 21:42:58 -0500
Message-ID: <20260116024258.1487173-13-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260116024258.1487173-1-chad@jablonski.xyz>
References: <20260116024258.1487173-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.151; envelope-from=chad@jablonski.xyz;
 helo=fout-b8-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
text rendering in X. Currently supports only the monochrome
foreground/background datatype.

The flush is broken up into two steps. First, expansion of the
monochrome bits to the destination color depth. Then the expanded pixels
are sent to the ati_2d_do_blt one scanline at a time. ati_2d_do_blt then
clips and performs the blit.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      |  4 +-
 hw/display/ati_2d.c   | 85 ++++++++++++++++++++++++++++++++++++++++++-
 hw/display/ati_int.h  |  3 ++
 hw/display/ati_regs.h |  4 ++
 4 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index e6868ddb8b..aa13c25f59 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1052,13 +1052,13 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case HOST_DATA7:
         s->host_data.acc[s->host_data.next++] = data;
         if (s->host_data.next >= 4) {
-            qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
+            ati_flush_host_data(s);
             s->host_data.next = 0;
         }
         break;
     case HOST_DATA_LAST:
         s->host_data.acc[s->host_data.next] = data;
-        qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
+        ati_flush_host_data(s);
         ati_host_data_reset(&s->host_data);
         break;
     default:
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index a5dc5ba98e..5a0e918810 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -274,6 +274,12 @@ void ati_2d_blt(ATIVGAState *s)
     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
     ATIBltDst dst;
     ATIBltSrc src;
+    uint32_t src_source = s->regs.dp_mix & DP_SRC_SOURCE;
+
+    if (src_source == DP_SRC_HOST || src_source == DP_SRC_HOST_BYTEALIGN) {
+        /* HOST_DATA sources are handled by ati_flush_host_data() */
+        return;
+    }
 
     setup_2d_blt_dst(s, &dst);
 
@@ -290,7 +296,6 @@ void ati_2d_blt(ATIVGAState *s)
         src.bits += s->regs.crtc_offset & 0x07ffffff;
         src.stride *= dst.bpp;
     }
-
     if (src.x > 0x3fff || src.y > 0x3fff || src.bits >= end
         || src.bits + src.x
          + (src.y + dst.rect.height) * src.stride >= end) {
@@ -300,3 +305,81 @@ void ati_2d_blt(ATIVGAState *s)
 
     ati_2d_do_blt(s, &src, &dst);
 }
+
+void ati_flush_host_data(ATIVGAState *s)
+{
+    ATIBltDst dst, chunk;
+    ATIBltSrc src;
+    uint32_t fg, bg;
+    unsigned bypp, row, col, idx;
+    uint8_t pix_buf[ATI_HOST_DATA_ACC_BITS * sizeof(uint32_t)];
+    uint32_t byte_pix_order = s->regs.dp_datatype & DP_BYTE_PIX_ORDER;
+
+    if ((s->regs.dp_mix & DP_SRC_SOURCE) != DP_SRC_HOST) {
+        qemu_log_mask(LOG_UNIMP, "host_data_blt: only DP_SRC_HOST supported\n");
+        return;
+    }
+    if ((s->regs.dp_datatype & DP_SRC_DATATYPE) != SRC_MONO_FRGD_BKGD) {
+        qemu_log_mask(LOG_UNIMP,
+                      "host_data_blt: only SRC_MONO_FRGD_BKGD supported\n");
+        return;
+    }
+
+    setup_2d_blt_dst(s, &dst);
+
+    if (!dst.left_to_right || !dst.top_to_bottom) {
+        qemu_log_mask(LOG_UNIMP, "host_data_blt: only L->R, T->B supported\n");
+        return;
+    }
+
+    fg = s->regs.dp_src_frgd_clr;
+    bg = s->regs.dp_src_bkgd_clr;
+    bypp = dst.bpp / 8;
+
+    /* Expand monochrome bits to color pixels */
+    idx = 0;
+    for (int word = 0; word < 4; word++) {
+        for (int byte = 0; byte < 4; byte++) {
+            uint8_t byte_val = s->host_data.acc[word] >> (byte * 8);
+            for (int i = 0; i < 8; i++) {
+                int bit = byte_pix_order ? i : (7 - i);
+                bool is_fg = extract8(byte_val, bit, 1);
+                uint32_t color = is_fg ? fg : bg;
+                stn_he_p(&pix_buf[idx * bypp], bypp, color);
+                idx += 1;
+            }
+        }
+    }
+
+    /* Set up source to point at pix_buf (treated as a single row) */
+    src.bits = pix_buf;
+    src.y = 0;
+    src.stride = ATI_HOST_DATA_ACC_BITS * bypp;
+
+    /* Copy to VRAM one scanline chunk at a time */
+    row = s->host_data.row;
+    col = s->host_data.col;
+    idx = 0;
+    chunk = dst;
+    while (idx < ATI_HOST_DATA_ACC_BITS && row < dst.rect.height) {
+        unsigned pix_in_scanline = MIN(ATI_HOST_DATA_ACC_BITS - idx,
+                                       dst.rect.width - col);
+        src.x = idx;
+        /* Build a rect for this scanline chunk */
+        qemu_rect_init(&chunk.rect,
+                       dst.rect.x + col,
+                       dst.rect.y + row,
+                       pix_in_scanline, 1);
+        ati_2d_do_blt(s, &src, &chunk);
+        idx += pix_in_scanline;
+        col += pix_in_scanline;
+        if (col >= dst.rect.width) {
+            col = 0;
+            row += 1;
+        }
+    }
+
+    /* Track state of the overall blit for use by the next flush */
+    s->host_data.row = row;
+    s->host_data.col = col;
+}
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 38725c57fa..ff7148a71a 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -29,6 +29,8 @@
 /* Radeon RV100 (VE) */
 #define PCI_DEVICE_ID_ATI_RADEON_QY 0x5159
 
+#define ATI_HOST_DATA_ACC_BITS 128
+
 #define TYPE_ATI_VGA "ati-vga"
 OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
 
@@ -120,5 +122,6 @@ struct ATIVGAState {
 const char *ati_reg_name(int num);
 
 void ati_2d_blt(ATIVGAState *s);
+void ati_flush_host_data(ATIVGAState *s);
 
 #endif /* ATI_INT_H */
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 48f15e9b1d..9d08d3e956 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -397,7 +397,11 @@
 #define DST_32BPP                               0x00000006
 #define DP_DST_DATATYPE                         0x0000000f
 #define DP_BRUSH_DATATYPE                       0x00000f00
+#define SRC_MONO_FRGD_BKGD                      0x00000000
+#define SRC_MONO_FRGD                           0x00010000
+#define SRC_COLOR                               0x00020000
 #define DP_SRC_DATATYPE                         0x00030000
+#define DP_BYTE_PIX_ORDER                       0x40000000
 
 #define BRUSH_SOLIDCOLOR                        0x00000d00
 
-- 
2.51.2


