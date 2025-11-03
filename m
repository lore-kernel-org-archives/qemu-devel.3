Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C369CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFlN3-0005jn-5X; Sun, 02 Nov 2025 22:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFlMx-0005hU-HE
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:36:35 -0500
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFlMr-00080v-Vr
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:36:34 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3C0A21400104;
 Sun,  2 Nov 2025 22:36:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sun, 02 Nov 2025 22:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1762140988; x=
 1762227388; bh=dTYYFACOpdC66c5YM67Ci0gn2Q7rJnzZ0tIHdI02mts=; b=U
 CYHOY/Xk+z6NFr5o4pUA6DTwnKC09IW8RUbPZlrxhtSYEvIRjryrmrbftmsoVTHA
 HqWov9+NtrZw9YmKqK1nVb+RBXtrTTpIfrdA8jy4jX7wgdaHvr2iBaOMBHgLnaWo
 DIY2izTadx9gHkrerIsSqDyIzv+6XnRF0vSYqOnH7eIPEfRVkZDlMmytGG1yFtPt
 3i4sGP4cAsLTMdNKN9YRKRkBt4jWsGG62M+LjyaTQaEYCop7ArUXvWjV65NlqJyK
 k38HOpOPMG3bueWwpaV+OszCwT4A0FslA/AqRtdJgcyfGs8qbTTK6Xs7GbXOoYXr
 CiOFSF1UnS5CJHReB/HTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1762140988; x=1762227388; bh=d
 TYYFACOpdC66c5YM67Ci0gn2Q7rJnzZ0tIHdI02mts=; b=1fTyR9Ns3TwqsZt8z
 KKOLltMGrMEcR6tF6aqV2JzYP9SCqfWUmHiA4Boq2zA115bkw2SNs88EEi5FJZ/b
 Z+sIncJbCHp6GGRfKmULfzXTMRevDh3gRrllz0yWwR4SvgTff8P3aB53gOZKcEUu
 FFHowzXsitW9J+OGFrcD3OVH/IZWj7MHFeMBdlPV5YV/6Y6vOqQNHusN3p+f+WKH
 Goy4dFLSDvLo2TkuBi6Xxl5IDT1UoWxcndyOmTEoiIMnbOlM3C6gE1R9dYDxtI/z
 U0zEbHwjSiGUi6F+dqTwPYXI+uiemhyQH2JS1Qf7+MEoN4A7acnnoW6ro2YtU5xC
 pycpg==
X-ME-Sender: <xms:PCMIaTxpLix6enRULyAr8LlASTuTibVgchSzoUjKNAH9ZmUjVVdNfg>
 <xme:PCMIaei-HMLSQ1QA6fknWzhDz41QYCr0LBiYqT21aZS5PVK5XeeoQ4XZ_snr6hTLN
 L5Dgz7SJHVhjOXORfW6QI0_iMCOiEbpVBCzxTBMNqVtALUbDPqJS7c>
X-ME-Received: <xmr:PCMIaWw8bJDoIO4RHjFRgp_3sKj3XTNNaM5zpGoOuef3ajRQ4zqIJaQ3ieMV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejtdejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheptghhrggusehj
 rggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:PCMIaZI9UIKy-Ne_kVaSmfqW4ALHaZZKIdK-4nwL7npV3posiOwM8A>
 <xmx:PCMIaVTkpPz1HPILFUi-CJamViKbm742JMv6QiPj1E0P7NR35uXZXQ>
 <xmx:PCMIaZq5m3oAskSUY-uN2WJ5mZ_XwMyqVxjp-BWjgPl20W8z66NLHg>
 <xmx:PCMIaSojNSZKURXAzi-L2hULI7TMNG8C1Yu8LmW-DQtsVF5TrQwGrw>
 <xmx:PCMIaZ2MhdK8h0LiwB5kZblFO-a6PBNLiAuAA83T3Y9AY_DUNV88vwv5>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 22:36:27 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id c6ae8662;
 Mon, 3 Nov 2025 03:36:23 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2 7/7] ati-vga: Implement HOST_DATA blit source with color
 expansion
Date: Sun,  2 Nov 2025 22:36:08 -0500
Message-ID: <20251103033608.120908-8-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103033608.120908-1-chad@jablonski.xyz>
References: <20251103033608.120908-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.153; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

SRCCOPY blits using 1bpp HOST_DATA as a source are expanded
to 32bpp ARGB. If pixman is enabled any additional color depth conversions
are handled. The fallback path does not yet support color conversion
and logs an error.

Unlike VRAM sourced blits, host data blits are not triggered by writing
to the dst width registers. They're only triggered on HOST_DATA_LAST
writes.

Supports MONO_FRGD_BKGD and COLOR datatypes. MONO_FRGD (transparent
background) is left for future work and logged.
GMC_SRC_SOURCE_HOST_DATA_ALIGNED is unimplemented and also logged.
Neither of these are used for xterm text rendering.

This combines clipping, host data transfers and color expansion to
enable text rendering in xterm under X.org.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      |  28 +++++++--
 hw/display/ati_2d.c   | 135 +++++++++++++++++++++++++++++++++++-------
 hw/display/ati_regs.h |  13 ++++
 3 files changed, 152 insertions(+), 24 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 0a686750ae..6ec50279ed 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -813,9 +813,14 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         }
         break;
     case DST_WIDTH:
+    {
+        uint32_t src = s->regs.dp_gui_master_cntl & GMC_SRC_SOURCE_MASK;
         s->regs.dst_width = data & 0x3fff;
-        ati_2d_blt(s);
+        if (src != GMC_SRC_SOURCE_HOST_DATA) {
+            ati_2d_blt(s);
+        }
         break;
+    }
     case DST_HEIGHT:
         s->regs.dst_height = data & 0x3fff;
         break;
@@ -862,10 +867,15 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dst_y = (data >> 16) & 0x3fff;
         break;
     case DST_HEIGHT_WIDTH:
+    {
+        uint32_t src = s->regs.dp_gui_master_cntl & GMC_SRC_SOURCE_MASK;
         s->regs.dst_width = data & 0x3fff;
         s->regs.dst_height = (data >> 16) & 0x3fff;
-        ati_2d_blt(s);
+        if (src != GMC_SRC_SOURCE_HOST_DATA) {
+            ati_2d_blt(s);
+        }
         break;
+    }
     case DP_GUI_MASTER_CNTL:
         s->regs.dp_gui_master_cntl = data & 0xff00000f;
         s->regs.dp_datatype = (data & 0x0f00) >> 8 | (data & 0x30f0) << 4 |
@@ -881,10 +891,15 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         }
         break;
     case DST_WIDTH_X:
+    {
+        uint32_t src = s->regs.dp_gui_master_cntl & GMC_SRC_SOURCE_MASK;
         s->regs.dst_x = data & 0x3fff;
         s->regs.dst_width = (data >> 16) & 0x3fff;
-        ati_2d_blt(s);
+        if (src != GMC_SRC_SOURCE_HOST_DATA) {
+            ati_2d_blt(s);
+        }
         break;
+    }
     case SRC_X_Y:
         s->regs.src_y = data & 0x3fff;
         s->regs.src_x = (data >> 16) & 0x3fff;
@@ -894,10 +909,15 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dst_x = (data >> 16) & 0x3fff;
         break;
     case DST_WIDTH_HEIGHT:
+    {
+        uint32_t src = s->regs.dp_gui_master_cntl & GMC_SRC_SOURCE_MASK;
         s->regs.dst_height = data & 0x3fff;
         s->regs.dst_width = (data >> 16) & 0x3fff;
-        ati_2d_blt(s);
+        if (src != GMC_SRC_SOURCE_HOST_DATA) {
+            ati_2d_blt(s);
+        }
         break;
+    }
     case DST_HEIGHT_Y:
         s->regs.dst_y = data & 0x3fff;
         s->regs.dst_height = (data >> 16) & 0x3fff;
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 181bf634f0..c177686338 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -25,6 +25,9 @@
  * possible.
  */
 
+#define DEFAULT_CNTL (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL)
+#define EXPANDED_SRC_BPP 32
+
 static int ati_bpp_from_datatype(ATIVGAState *s)
 {
     switch (s->regs.dp_datatype & 0xf) {
@@ -44,7 +47,6 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
     }
 }
 
-#define DEFAULT_CNTL (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL)
 /* Convert 1bpp monochrome data to 32bpp ARGB using color expansion */
 static void expand_colors(uint8_t *color_dst, const uint8_t *mono_src,
                           uint32_t width, uint32_t height,
@@ -139,30 +141,112 @@ void ati_2d_blt(ATIVGAState *s)
     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
     case ROP3_SRCCOPY:
     {
+        uint32_t src = s->regs.dp_gui_master_cntl & GMC_SRC_SOURCE_MASK;
+        uint8_t *color_data = NULL;
         bool fallback = false;
-        unsigned src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                         s->regs.src_x + clip_left :
-                         s->regs.src_x + 1 - dst.width + clip_left);
-        unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                         s->regs.src_y + clip_top :
-                         s->regs.src_y + 1 - dst.height + clip_top);
-        int src_stride = DEFAULT_CNTL ?
+        unsigned src_x, src_y, src_stride, src_bpp;
+        uint8_t *src_bits;
+
+        switch (src) {
+        case GMC_SRC_SOURCE_HOST_DATA:
+        {
+            unsigned src_datatype = s->regs.dp_gui_master_cntl &
+                                    GMC_SRC_DATATYPE_MASK;
+            switch (src_datatype) {
+            case GMC_SRC_DATATYPE_MONO_FRGD_BKGD:
+            {
+                bool lsb_to_msb = s->regs.dp_gui_master_cntl &
+                                  GMC_BYTE_ORDER_LSB_TO_MSB;
+                /* Monochrome source is 1 bpp aligned to 32-bit rows */
+                uint32_t mono_size = ((dst.width + 31) / 32) * 4 * dst.height;
+                if (s->host_data_pos < mono_size) {
+                    qemu_log_mask(LOG_UNIMP,
+                                  "HOST_DATA blit requires %u bytes, buffer holds %u "
+                                  "(increase buffer size)\n",
+                                  mono_size, s->host_data_pos);
+                    return;
+                }
+
+                /* Expand all of the source, clipping will be applied later */
+                color_data = g_malloc(dst.width * dst.height *
+                                      sizeof(uint32_t));
+                src_bpp = EXPANDED_SRC_BPP;
+                expand_colors(color_data, s->host_data_buffer,
+                              dst.width, dst.height, s->regs.dp_src_frgd_clr,
+                              s->regs.dp_src_bkgd_clr, lsb_to_msb);
+                break;
+            }
+            case GMC_SRC_DATATYPE_COLOR:
+            {
+                uint32_t color_size = dst.width * dst.height * (bpp / 8);
+                if (s->host_data_pos < color_size) {
+                    qemu_log_mask(LOG_UNIMP,
+                                  "HOST_DATA blit requires %u bytes, buffer holds %u "
+                                  "(increase buffer size)\n",
+                                  color_size, s->host_data_pos);
+                    return;
+                }
+                /*
+                 * The rage128 register guide states that the bit depth in this
+                 * case matches the bit depth of the dst. There is no
+                 * independent bit depth register for the src.
+                 */
+                src_bpp = bpp;
+                color_data = s->host_data_buffer;
+                break;
+            }
+            case GMC_SRC_DATATYPE_MONO_FRGD:
+                qemu_log_mask(LOG_UNIMP, "ati_2d blt source datatype "
+                              "MONO_FRGD (leave-alone) not yet supported\n");
+                return;
+            default:
+                qemu_log_mask(LOG_UNIMP, "ati_2d blt source datatype %x is "
+                              "not yet supported\n", src_datatype);
+                return;
+            }
+
+            src_x = clip_left;
+            src_y = clip_top;
+            src_stride = dst.width * (src_bpp / 8);
+            src_bits = color_data;
+            s->host_data_pos = 0;
+            break;
+        }
+        case GMC_SRC_SOURCE_MEMORY:
+        {
+            src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
+                     s->regs.src_x + clip_left :
+                     s->regs.src_x + 1 - dst.width + clip_left);
+            src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
+                     s->regs.src_y + clip_top :
+                     s->regs.src_y + 1 - dst.height + clip_top);
+            src_stride = DEFAULT_CNTL ?
                          s->regs.src_pitch : s->regs.default_pitch;
-        if (!src_stride) {
-            qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
+            src_bpp = bpp;
+            src_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
+                       s->regs.src_offset : s->regs.default_offset);
+            if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
+                src_bits += s->regs.crtc_offset & 0x07ffffff;
+                src_stride *= bpp;
+            }
+            if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
+                || src_bits + src_x
+                 + (src_y + clipped.height) * src_stride >= end) {
+                qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
+                return;
+            }
+            break;
+        }
+        case GMC_SRC_SOURCE_HOST_DATA_ALIGNED:
+        default:
+            qemu_log_mask(LOG_UNIMP, "ati_2d blt source %x is not "
+                          "yet supported\n", src);
             return;
         }
-        uint8_t *src_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
-                            s->regs.src_offset : s->regs.default_offset);
 
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            src_bits += s->regs.crtc_offset & 0x07ffffff;
-            src_stride *= bpp;
-        }
-        if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
-            || src_bits + src_x
-             + (src_y + clipped.height) * src_stride >= end) {
-            qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
+        if (!src_stride) {
+            qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
+            g_free(color_data);
             return;
         }
 
@@ -207,6 +291,15 @@ void ati_2d_blt(ATIVGAState *s)
             unsigned int src_pitch = src_stride * sizeof(uint32_t);
             unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
 
+            if (src_bpp != bpp) {
+                qemu_log_mask(LOG_UNIMP,
+                              "Mismatched bit depths not yet supported "
+                              "in the fallback (non-pixman) implementation. "
+                              "src: %d != dst: %d\n", src_bpp, bpp);
+                g_free(color_data);
+                return;
+            }
+
             for (y = 0; y < clipped.height; y++) {
                 i = clipped.x * bypp;
                 j = src_x * bypp;
@@ -232,6 +325,8 @@ void ati_2d_blt(ATIVGAState *s)
                          clipped.x + clipped.width : clipped.x);
         s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
                          clipped.y + clipped.height : clipped.y);
+
+        g_free(color_data);
         break;
     }
     case ROP3_PATCOPY:
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 9b52b61dcb..b741c3c6b8 100644
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
@@ -421,6 +422,18 @@
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


