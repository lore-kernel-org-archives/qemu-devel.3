Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF45FE7FDD3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 20:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn0rQ-0001SE-HW; Mon, 02 Feb 2026 15:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q7-0007Mn-Cf
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:09 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q3-0001pI-0y
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:05 -0500
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 6836C7A0116;
 Mon,  2 Feb 2026 15:48:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Mon, 02 Feb 2026 15:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770065281; x=
 1770151681; bh=JWVVtkHhgh2zxANpbFwsWKWT3u3BmhZsOxPsQoOWRzg=; b=s
 OGCkzaeI56mM5Rf4T9cjbC6DA3F8rk+5iXF7pxLviUinemGSBLJZG+hP+EC/r0Ck
 bda3RpIZYDltgJPIiD4b/mO0eo0woWLkAtKrZPTy1Tw6ZOnLjigcYTq8CWMyQEes
 g39E12YU4w75rEqJ5LMfaENXGl4PDL1Ba5ubjs+vzr8vSckhncdmvEiUzboCJTu3
 psfCuSs5INnyrr9h1Ra1qxFh13LfToZ+RbAjylqxswEOoo6pCVJfLO3GhHjZMSCZ
 EsVamzMOD/TV5oujyJ8M4hPgqlIlKUbVQPYX/ZoA8Y+c+7TWFjjlOJoRugezIIEc
 IvE4X6I0pvHAxtvvxgszA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770065281; x=1770151681; bh=J
 WVVtkHhgh2zxANpbFwsWKWT3u3BmhZsOxPsQoOWRzg=; b=CXyodYObmD2Faw6DK
 EPXslIIXeXlKmhCoT0N6T+BEer0IFE0qvNKGhaLKZScdnObO7cEmO/GnKXNDMQ+6
 fiGsT35be3S7EXYcdUv8YNb+rRwgheowLpuwwoaiOuRLGJTTe3JnJuVTtdEEr6u6
 DGb3qT7DTLg5iGDU7cp3mFYcgeC280Mg8lMbaecm9rJA/Qyl+60qZZB5XD8BGafI
 hGEVuevERdY2rjsqu80E7lxNT7Wp013fxs+ckLDLmpIshDKOcUMVP7DpLV63YBaY
 kuSVt4B5KST/0Drx12L5yrXaSfFyWtDWBMUTd7wukRYCRe2gBMge/hpnuhRuQeVq
 XYhAw==
X-ME-Sender: <xms:gQ2BaXWvCUy5KF44p9nNCjSj5E4NVgHLTuff19p97_nMtFeHCwFoGA>
 <xme:gQ2BaXDKcPtL3b4O7MAqqN2pF6bl3UQRnWVMw7C1OQRD6xTzXOVVeXdgLH1wEsq7B
 u1XFos90VdTAd9kELm4qIp8DOlSJ2YGhaFGv3w1fCsBnDegRk4rgGk>
X-ME-Received: <xmr:gQ2BaQzapFjsUQh1LZNSyC1BZuQZQhPfRo22TggnH7a3OvZZ-_w21MnwC33P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekieefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpth
 htoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsggrlhgrthho
 nhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:gQ2BacAi8i39VflPeEoJ-xjeadffAvIouESAY6FefqlMKrxQrRfjKA>
 <xmx:gQ2BaVbHsg73zvKStVqcWzB4fS6KxRA_hWR-zgu6QswOM_eH8HdfJg>
 <xmx:gQ2BacikD0NFTqV4MHrJHokY4CzTqaUAoK9mXXfizBqA4iscN-6sjQ>
 <xmx:gQ2Baf7i52HIY1j6pqt-pLjujjcyKQWf0yIJZmRNv-C_avyI4ycChg>
 <xmx:gQ2Baat-3tMFPwAnur57o6BeFLFiykesY9ERa5cWiota8KECta2GJqD_>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 15:48:00 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 16f08fdf;
 Mon, 2 Feb 2026 20:47:53 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v7 19/19] ati-vga: Implement HOST_DATA flush to VRAM
Date: Mon,  2 Feb 2026 15:47:37 -0500
Message-ID: <20260202204738.3080092-20-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202204738.3080092-1-chad@jablonski.xyz>
References: <20260202204738.3080092-1-chad@jablonski.xyz>
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

Implement flushing the 128-bit HOST_DATA accumulator to VRAM to enable
text rendering in X. Currently supports only the monochrome
foreground/background datatype.

The flush is broken up into two steps. First, expansion of the
monochrome bits to the destination color depth. Then the expanded pixels
are sent to the ati_2d_do_blt one scanline at a time. ati_2d_do_blt then
clips and performs the blit.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      |  4 +--
 hw/display/ati_2d.c   | 84 +++++++++++++++++++++++++++++++++++++++++++
 hw/display/ati_int.h  |  3 ++
 hw/display/ati_regs.h |  4 +++
 4 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index fd717044b0..514935e510 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1045,13 +1045,13 @@ static void ati_mm_write(void *opaque, hwaddr addr,
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
index b9fc9f3057..cd757c10f8 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -289,6 +289,11 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
 void ati_2d_blt(ATIVGAState *s)
 {
     ATI2DCtx ctx;
+    uint32_t src_source = s->regs.dp_mix & DP_SRC_SOURCE;
+    if (src_source == DP_SRC_HOST || src_source == DP_SRC_HOST_BYTEALIGN) {
+        /* HOST_DATA sources are handled by ati_flush_host_data() */
+        return;
+    }
     setup_2d_blt_ctx(s, &ctx);
     if (ctx.src.x > 0x3fff || ctx.src.y > 0x3fff
         || ctx.src_bits >= ctx.vram_end
@@ -301,3 +306,82 @@ void ati_2d_blt(ATIVGAState *s)
     ati_2d_do_blt(&ctx, s->use_pixman);
     ati_set_dirty(&s->vga, &ctx);
 }
+
+void ati_flush_host_data(ATIVGAState *s)
+{
+    ATI2DCtx ctx, chunk;
+    uint32_t fg = s->regs.dp_src_frgd_clr;
+    uint32_t bg = s->regs.dp_src_bkgd_clr;
+    unsigned bypp, row, col, idx;
+    uint8_t pix_buf[ATI_HOST_DATA_ACC_BITS * sizeof(uint32_t)];
+    uint32_t byte_pix_order = s->regs.dp_datatype & DP_BYTE_PIX_ORDER;
+    uint32_t src_source = s->regs.dp_mix & DP_SRC_SOURCE;
+    uint32_t src_datatype = s->regs.dp_datatype & DP_SRC_DATATYPE;
+
+    if (src_source != DP_SRC_HOST) {
+        qemu_log_mask(LOG_UNIMP, "host_data_blt: only DP_SRC_HOST supported\n");
+        return;
+    }
+    if (src_datatype != SRC_MONO_FRGD_BKGD) {
+        qemu_log_mask(LOG_UNIMP,
+                      "host_data_blt: only SRC_MONO_FRGD_BKGD supported\n");
+        return;
+    }
+
+    setup_2d_blt_ctx(s, &ctx);
+
+    if (!ctx.left_to_right || !ctx.top_to_bottom) {
+        qemu_log_mask(LOG_UNIMP, "host_data_blt: only L->R, T->B supported\n");
+        return;
+    }
+
+    bypp = ctx.bpp / 8;
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
+    while (idx < ATI_HOST_DATA_ACC_BITS && row < ctx.dst.height) {
+        unsigned pix_in_scanline = MIN(ATI_HOST_DATA_ACC_BITS - idx,
+                                       ctx.dst.width - col);
+        chunk.src.x = idx;
+        /* Build a rect for this scanline chunk */
+        chunk.dst.x = ctx.dst.x + col;
+        chunk.dst.y = ctx.dst.y + row;
+        chunk.dst.width = pix_in_scanline;
+        chunk.dst.height = 1;
+        ati_2d_do_blt(&chunk, s->use_pixman);
+        ati_set_dirty(&s->vga, &chunk);
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
+}
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index ef474e366e..32d1e628d3 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -33,6 +33,8 @@
 #define ATI_RAGE128_LINEAR_APER_SIZE (64 * MiB)
 #define ATI_R100_LINEAR_APER_SIZE (128 * MiB)
 
+#define ATI_HOST_DATA_ACC_BITS 128
+
 #define TYPE_ATI_VGA "ati-vga"
 OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
 
@@ -125,5 +127,6 @@ struct ATIVGAState {
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
2.52.0


