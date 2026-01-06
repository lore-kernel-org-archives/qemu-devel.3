Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4C0CEFCF0
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 18:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdCFA-0004Ju-QG; Tue, 06 Jan 2026 13:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCF1-0004Gb-L5
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:17 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCEx-0001wr-UT
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:14 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id DA9DE1D00108;
 Tue,  6 Jan 2026 13:57:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 13:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767725830; x=
 1767812230; bh=ut2udhF3CUgUMd6ohcEEQWOpiLUh6wpefY5CsdjkC0w=; b=Q
 ZxejkKHBn32qbL3aYZTOZVWUA8VnSEqXgYJYM+HDhda0x88e+xwdygS507pPcCmM
 FHWKyf6dZQeqJddY9jRSo4MMQ0c5hvWhBEDhvWvwVP5e07tepq4EcXhRR2gOuaNb
 RmW/FM71iCl/iyjaFPrixiigI0RssLfeCz6dojKvEaCSBUAL9bfgr9D2H3eem0Wo
 tSWreYjAt8zp96a02DYse1bJmMuD6Dj36dH2Sv2Xu5WK9B2Jaf40rpaXy4J2WVnl
 IgGB84ndcv1bzCQoTqz7VdASxqnBhhkseI+9mzkk84ikz1gXKwY4lZQR65GKhEmi
 k5+YmgxSm+Y4VHOh8sXtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767725830; x=1767812230; bh=u
 t2udhF3CUgUMd6ohcEEQWOpiLUh6wpefY5CsdjkC0w=; b=ai6wH344Xn1/kvG/T
 P5MdQ7BfTJb2h4qWLpEtb3hH4HTh+uZXhteRlCdJdEcIFYDX0Ey8IEZFVSZx5McQ
 9c1CKwCdYHfJ1dLhkR7jBoOpIGJUmOfiXEZvdt7AruT+6QwBy+QQVwXR5TUQTENB
 /LBtPUD7pGnm2BMwbAYNDrOt1R2E8+4Liti7J8+BN6X6mqvXxObjP1h1CMUkifPs
 C4hQdRpN2fQCrXaLgFjyNBwNAvQZCIC+vcr2i4nJmVvs9/mHU789EMlZR7JYLic4
 AuH0p/oeqSishZnvEkcUDxxNu3FSwivYPLkX6X6UoWfYvguvzXTilEOTezUSvS/A
 I/HoA==
X-ME-Sender: <xms:BltdaT5IhuQzqqaurAhRkJwsNPGubaCXozGsXpCuZ4a5j5Q7bXmutA>
 <xme:BltdaQVuDgEs-sP2O3xOPtg_BSK88K3SiIQ3yxfT8W9rpAu_-rnco6gi7q8aPtS_D
 eczRoMAz4DkdrmdRdDZK3R5dNKtIFl01UBwsseHyPUkrMg0H_nvCA>
X-ME-Received: <xmr:BltdaX1eF2GBlR4qYLpv1tLOYBbTwcJ3mOGEYZlqlmwSDCncpldX82bb7JfZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtleeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Bltdad0M3r-JEIjwhEqqlss825--ASvZewl62wwLLNChdj2G8uabrQ>
 <xmx:Bltdaa-DNx3L3GlWzq7aVxchiTNJLut0ltgx1sT7hRcusmUfoejRBw>
 <xmx:Bltdaa3M14I4l2L3P6gyB4WL9QCu9ItDgI5nZWmMllBDoCGaxPz-jQ>
 <xmx:BltdaX-dFLvAiTIkxN03_Wb2S4dZOGaPhc2IpMLnE4sIE_FIAglNCw>
 <xmx:BltdaRjIoLG_zG_2V53lFYQJ62NxSqhLDKrKIfZ9bTzjhvMoNy3qFvV->
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 13:57:10 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 81f78c11;
 Tue, 6 Jan 2026 18:57:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v4 3/9] ati-vga: Add scissor clipping register support
Date: Tue,  6 Jan 2026 13:56:54 -0500
Message-ID: <20260106185700.2102742-4-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260106185700.2102742-1-chad@jablonski.xyz>
References: <20260106185700.2102742-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.149; envelope-from=chad@jablonski.xyz;
 helo=fout-b6-smtp.messagingengine.com
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

Implement read and write operations on SC_TOP_LEFT, SC_BOTTOM_RIGHT,
and SRC_SC_BOTTOM_RIGHT registers. These registers are also updated
when the src and/or dst clipping fields on DP_GUI_MASTER_CNTL are set
to default clipping.

Scissor clipping is used when rendering text in X.org. The r128 driver
sends host data much wider than is necessary to draw a glyph and cuts it
down to size using clipping before rendering. The actual clipping
implementation follows in a future patch.

This also includes a very minor refactor of the combined
default_sc_bottom_right field in the registers struct to
default_sc_bottom and default_sc_right. This was done to
stay consistent with the other scissor registers and prevent repeated
masking and extraction.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c      | 71 +++++++++++++++++++++++++++++++++++++++++--
 hw/display/ati_int.h  |  9 +++++-
 hw/display/ati_regs.h |  2 ++
 3 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 2f919bcd22..bbae5455d0 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -520,7 +520,32 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         val |= s->regs.default_tile << 16;
         break;
     case DEFAULT_SC_BOTTOM_RIGHT:
-        val = s->regs.default_sc_bottom_right;
+        val = (s->regs.default_sc_bottom << 16) |
+              s->regs.default_sc_right;
+        break;
+    case SC_TOP:
+        val = s->regs.sc_top;
+        break;
+    case SC_LEFT:
+        val = s->regs.sc_left;
+        break;
+    case SC_BOTTOM:
+        val = s->regs.sc_bottom;
+        break;
+    case SC_RIGHT:
+        val = s->regs.sc_right;
+        break;
+    case SRC_SC_BOTTOM:
+        val = s->regs.src_sc_bottom;
+        break;
+    case SRC_SC_RIGHT:
+        val = s->regs.src_sc_right;
+        break;
+    case SC_TOP_LEFT:
+    case SC_BOTTOM_RIGHT:
+    case SRC_SC_BOTTOM_RIGHT:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Read from write-only register 0x%x\n", (unsigned)addr);
         break;
     default:
         break;
@@ -881,6 +906,17 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         /* DP_MIX fields */
         s->regs.dp_rop3 = (data & GMC_ROP3_MASK) >> 16;
         s->regs.dp_src_source = (data & GMC_SRC_SOURCE_MASK) >> 24;
+
+        if (!(data & GMC_SRC_CLIPPING)) {
+            s->regs.src_sc_right = s->regs.default_sc_right;
+            s->regs.src_sc_bottom = s->regs.default_sc_bottom;
+        }
+        if (!(data & GMC_DST_CLIPPING)) {
+            s->regs.sc_top = 0;
+            s->regs.sc_left = 0;
+            s->regs.sc_right = s->regs.default_sc_right;
+            s->regs.sc_bottom = s->regs.default_sc_bottom;
+        }
         break;
     case DST_WIDTH_X:
         s->regs.dst_x = data & 0x3fff;
@@ -960,7 +996,38 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         }
         break;
     case DEFAULT_SC_BOTTOM_RIGHT:
-        s->regs.default_sc_bottom_right = data & 0x3fff3fff;
+        s->regs.default_sc_right = data & 0x3fff;
+        s->regs.default_sc_bottom = (data >> 16) & 0x3fff;
+        break;
+    case SC_TOP_LEFT:
+        s->regs.sc_left = data & 0x3fff;
+        s->regs.sc_top = (data >> 16) & 0x3fff;
+        break;
+    case SC_LEFT:
+        s->regs.sc_left = data & 0x3fff;
+        break;
+    case SC_TOP:
+        s->regs.sc_top = data & 0x3fff;
+        break;
+    case SC_BOTTOM_RIGHT:
+        s->regs.sc_right = data & 0x3fff;
+        s->regs.sc_bottom = (data >> 16) & 0x3fff;
+        break;
+    case SC_RIGHT:
+        s->regs.sc_right = data & 0x3fff;
+        break;
+    case SC_BOTTOM:
+        s->regs.sc_bottom = data & 0x3fff;
+        break;
+    case SRC_SC_BOTTOM_RIGHT:
+        s->regs.src_sc_right = data & 0x3fff;
+        s->regs.src_sc_bottom = (data >> 16) & 0x3fff;
+        break;
+    case SRC_SC_RIGHT:
+        s->regs.src_sc_right = data & 0x3fff;
+        break;
+    case SRC_SC_BOTTOM:
+        s->regs.src_sc_bottom = data & 0x3fff;
         break;
     default:
         break;
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 59a1812034..d9ac8ee135 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -79,7 +79,6 @@ typedef struct ATIVGARegs {
     uint32_t default_offset;
     uint32_t default_pitch;
     uint32_t default_tile;
-    uint32_t default_sc_bottom_right;
     uint8_t dp_src_source;
     uint8_t dp_rop3;
     uint8_t dp_dst_datatype;
@@ -88,6 +87,14 @@ typedef struct ATIVGARegs {
     bool host_big_endian_en;
     bool byte_pix_order;
     bool conversion_temp;
+    uint16_t default_sc_bottom;
+    uint16_t default_sc_right;
+    uint16_t sc_top;
+    uint16_t sc_left;
+    uint16_t sc_bottom;
+    uint16_t sc_right;
+    uint16_t src_sc_bottom;
+    uint16_t src_sc_right;
 } ATIVGARegs;
 
 struct ATIVGAState {
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index fce9270635..9c638314f0 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -405,6 +405,8 @@
 #define GMC_SRC_DATATYPE_MASK                   0x00003000
 #define GMC_BYTE_PIX_ORDER                      0x00004000
 #define GMC_CONVERSION_TEMP                     0x00008000
+#define GMC_SRC_CLIPPING                        0x00000004
+#define GMC_DST_CLIPPING                        0x00000008
 #define GMC_BRUSH_SOLIDCOLOR                    0x000000d0
 #define GMC_SRC_DSTCOLOR                        0x00003000
 #define GMC_BYTE_ORDER_MSB_TO_LSB               0x00000000
-- 
2.51.2


