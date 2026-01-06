Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1B4CEFCF0
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 18:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdCFV-0004fL-A9; Tue, 06 Jan 2026 13:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCF4-0004I4-CE
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:19 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCEz-0001xb-Qi
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:18 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E36D97A00D0;
 Tue,  6 Jan 2026 13:57:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 06 Jan 2026 13:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767725832; x=
 1767812232; bh=Bt99epWLQh+1MzxKyr0D9zlVxnLq1a3VtxrEopU4fQM=; b=N
 DRPw4Sfz2fOYk6exdvliR4i/RSwQG0c4Nl3sSDuTqD33nadVAFbhwUrK/ayxa06B
 JfNl/b3uakkR7Y8TAMqOdqF7lpMKKf+Z96McnzAJ1KU5F6PhrG/sq7xePVqqvfHL
 JrnUPLay4Dq/90ha6V2zRI7QB1E1nw4TsINn0LdiBUYXIExKxO3bIzbxAcPF+fj5
 Ic9nRcmbUsq+B/Vo2YWZrb6vWIsIgNM0ACbH/1zNfuWuuXjSZU5CLfDln+ScE/jz
 /SY75sU99qnN5Jifm6V3STXH7lZtFwToSUqXXjypFpQpuj8DkqSKnT3OLSwF23lD
 sqxWZShZWXTMxGXjkO3Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767725832; x=1767812232; bh=B
 t99epWLQh+1MzxKyr0D9zlVxnLq1a3VtxrEopU4fQM=; b=H7hIRnI+pm3byQ+qm
 IFUiTt/mOjbmtnZWyuyhhj6nEYqbR4Tfq+WI2aH7k838hAVU13NXH5dLnqg62VXD
 y6PmjlSA37d1CRxODlZQ2e1SpTiKPFDaXS0TPd6+m71RTmR4rA6d3w62ACedg2jf
 KJB0pUvGvfmd6n8oICPQ7EGOjFPFP3CH8e0jzD2YEeGOAdKUPuaShH6dB9aMEpvt
 l3U3KVkIoUKbW9btzz/+lIX6eOgYVjxnONTPxpGZgaEPyuLrrFmsX0gpj065ndyF
 slhsLh+9Me2T+Kd7xNpoUr7Od81ZME24FKVJAMkH4WE5uKsOtZJ2IG5odDK/Xvz9
 2T2aw==
X-ME-Sender: <xms:CFtdaVGFXtbSKJ9Gqu--Ay5xEv-Io44dNmjRf64guyjRtx9OKpz1XQ>
 <xme:CFtdaRyBgwjJ8SQrTAU8kDwKfIenjGgi0_bLzUq7I2gKL3HAZADxZcb7nvUz0qPU9
 VtJF8r-AO5ssTqcLF5SBNzDtlBPr6Nb1Vz79t18-y1X32jSpFC0jXY>
X-ME-Received: <xmr:CFtdaUgpS0gz-EqLsTKh2CDpUtGLSIl_P_0DmD4TTRA_2o7LIWvGhKQ461MF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtleejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpth
 htohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoheptghhrggusehj
 rggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:CFtdaUzHQbbm9FZePcy1vigEUZ-Sa4TCxulXG3548n8wVRg_jPBZDw>
 <xmx:CFtdafKegb9t9gnVvxa2sHUfwiMdji9e0fWpLT3SGr9Jzib_fZBWRg>
 <xmx:CFtdaTSap2xG49SizpzKs59a4L4VcpcCexH_r5kIRG4n1FIIXwpi2Q>
 <xmx:CFtdafppqoXTW4TVFpmtfYZ0ZQnQLYp2FlqjEidO4NdmycqItTi66A>
 <xmx:CFtdaff1LlFRkMet-gEYBEbADcfhs-Js27L3HF-xXwWKwJrb2RvdIrLJ>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 13:57:12 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 5d21f4c4;
 Tue, 6 Jan 2026 18:57:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v4 9/9] ati-vga: Implement HOST_DATA flush to VRAM
Date: Tue,  6 Jan 2026 13:57:00 -0500
Message-ID: <20260106185700.2102742-10-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260106185700.2102742-1-chad@jablonski.xyz>
References: <20260106185700.2102742-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.157; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
 hw/display/ati.c     |   4 +-
 hw/display/ati_2d.c  | 124 +++++++++++++++++++++++++++++++++++++++++++
 hw/display/ati_int.h |   3 ++
 3 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 88d30bf532..cc5899981b 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1064,13 +1064,13 @@ static void ati_mm_write(void *opaque, hwaddr addr,
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
index 6c36e55412..19130ed291 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -117,6 +117,11 @@ static ATIBlitDest setup_2d_blt_dst(ATIVGAState *s)
 
 void ati_2d_blt(ATIVGAState *s)
 {
+    if (s->regs.dp_src_source == GMC_SRC_SOURCE_HOST_DATA) {
+        /* HOST_DATA blits are handled separately by ati_flush_host_data() */
+        return;
+    }
+
     /* FIXME it is probably more complex than this and may need to be */
     /* rewritten but for now as a start just to get some output: */
     DisplaySurface *ds = qemu_console_surface(s->vga.con);
@@ -293,3 +298,122 @@ void ati_2d_blt(ATIVGAState *s)
                       s->regs.dp_rop3);
     }
 }
+
+void ati_flush_host_data(ATIVGAState *s)
+{
+    DisplaySurface *ds;
+    ATIBlitDest dst;
+    uint32_t fg, bg;
+    unsigned bypp, row, col, idx;
+    uint8_t pix_buf[ATI_HOST_DATA_ACC_BITS * sizeof(uint32_t)];
+
+    if (s->regs.dp_src_source != GMC_SRC_SOURCE_HOST_DATA) {
+        qemu_log_mask(LOG_UNIMP,
+                      "host_data_blt: only GMC_SRC_SOURCE_HOST_DATA "
+                      "supported\n");
+        return;
+    }
+
+    if (s->regs.dp_src_datatype != GMC_SRC_DATATYPE_MONO_FRGD_BKGD) {
+        qemu_log_mask(LOG_UNIMP,
+                      "host_data_blt: only GMC_SRC_DATATYPE_MONO_FRGD_BKGD "
+                      "supported\n");
+        return;
+    }
+
+    if (s->regs.dp_rop3 != ROP3_SRCCOPY) {
+        qemu_log_mask(LOG_UNIMP,
+                      "host_data_blt: only ROP3_SRCCOPY supported. rop: %x\n",
+                      s->regs.dp_rop3);
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
+                int bit = s->regs.byte_pix_order ? i : (7 - i);
+                bool is_fg = extract8(byte_val, bit, 1);
+                uint32_t color = is_fg ? fg : bg;
+                stn_he_p(&pix_buf[idx * bypp], bypp, color);
+                idx += 1;
+            }
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
index 3029dc7e3c..448daf44a9 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -30,6 +30,8 @@
 /* Radeon RV100 (VE) */
 #define PCI_DEVICE_ID_ATI_RADEON_QY 0x5159
 
+#define ATI_HOST_DATA_ACC_BITS 128
+
 #define TYPE_ATI_VGA "ati-vga"
 OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
 
@@ -127,5 +129,6 @@ struct ATIVGAState {
 const char *ati_reg_name(int num);
 
 void ati_2d_blt(ATIVGAState *s);
+void ati_flush_host_data(ATIVGAState *s);
 
 #endif /* ATI_INT_H */
-- 
2.51.2


