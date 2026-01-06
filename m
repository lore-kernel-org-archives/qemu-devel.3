Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA1CCEFCF1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 18:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdCFW-0004kQ-BO; Tue, 06 Jan 2026 13:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCF1-0004Ga-Kh
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:17 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCEx-0001wc-DU
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:14 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id EE97C7A00D1;
 Tue,  6 Jan 2026 13:57:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 06 Jan 2026 13:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767725829; x=
 1767812229; bh=PCThg2fGmzKYTpkU3egFELgoWRFes0FnSaw9SnLv9C0=; b=f
 UlssSk5puK2TiedPTZYL1kktiBAMyzv5uhQE2JdKX4Tv2LhMmKd4eD8TCXTDNbd8
 qrqlQy2fpr6dtWGfNH7vf/OIJxhyE/qBO/byEwrOlm1SBrSN5R0FfmB9udT6kVLi
 tofKq79gRdVCP0kaEQO3AmpMm0jetWxkw6kBWRQIDEfkOY3BUBtZBQIT06LnYPUh
 pzgGGbtsH/RbrPp3N0Lsh2bXYlwthORt4OMnIxVah2Dmk8FpMiLgpW0cbNzH8Zw1
 RV636Zv8WsZ+TQtjgvauNWKyep1uj5TKnOPqASVSUqnTfd/jF0XZLmY2dAJS2Wlk
 iMb+6e9WAsn8IRQ05pV+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767725829; x=1767812229; bh=P
 CThg2fGmzKYTpkU3egFELgoWRFes0FnSaw9SnLv9C0=; b=gkkBUboEJlbgroha/
 q/k/L+s7kNtJHIA23jA/+ZLRjTjBistED0BdX5b9UJ2yylSdvywfAJ/yYqePiQMv
 vR7Tkc+mWOYynM4z5GRKVFFGp1Aren0UDrD97kMeL6K0EingNjcwlpwkUU9qkNYS
 yOYFAqBUgyh4vyZjgw9+DPDIVa8CKJb9NE5sQjSYPI0Knsq4ezdhDRixAerJP1FZ
 OXDOQIlPBldX6qS6orE+H5V7bDOwkSheuzhE/TrwXOolIPNqjA+OQN/p/qo1b8ST
 L4mlnokRvHhmg206d+TPbggHdtao9E8gWVn6QAJoNsChy4UJdzYRXsThFOA02gqK
 rkwIg==
X-ME-Sender: <xms:BVtdaS7BctrFlNwo9boqtBnA_VtWq1r8w-tZ-4egzYfJnbHORyCyGA>
 <xme:BVtdaTWMpcg2mQMusCyEk8bqIaQhEWuoKzz-IkFD87R4Ed-sPFHgZKE9wanJQSTLx
 WWPwVDGKnjGqWhihM31sNHC7gvY8lKdZWpdw_Sl3CblIVWhY2xqYmY>
X-ME-Received: <xmr:BVtdae1YzpXxzOxN-ceXao4eTty6VlGd43696FzFh5VglMEPbyiys8Dy1v3R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtleejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:BVtdaY1OB5bDWRHFhafvxWZ2Ad7nSPph7QpVW_TJ5I92PPtgLKrLkw>
 <xmx:BVtdaZ-bDIxDqjSFAhnZxbOpxt_bcNmDiKKPNZGaoRuR0GB4jQ850A>
 <xmx:BVtdad2dVFga4k6Ig30-Fqw6-KdcdQxZ3xMO_oawoXLmr5GSttNeDw>
 <xmx:BVtdae_Oaj38Yt1rtHpyEkIv86oFPRAo9xAflFPQGxpJb9IFXYKGmg>
 <xmx:BVtdaciMQpMsovs426Bx7J3T4mywIu154wZRgn6LdP0zNh64dMEU6sSP>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 13:57:09 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 68f15c66;
 Tue, 6 Jan 2026 18:57:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v4 1/9] ati-vga: Store DP_DATATYPE and DP_MIX fields
 independently
Date: Tue,  6 Jan 2026 13:56:52 -0500
Message-ID: <20260106185700.2102742-2-chad@jablonski.xyz>
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

DP_GUI_MASTER_CNTL accesses the same values as DP_DATATYPE and DP_MIX.
This was not reflected in how we stored register state. This meant that
you could easily end up with stale state in one or the other register.

This stores each field directly instead of packing them into a field
named after the register. The register handlers then shift bits around
if needed. This not only keeps things in sync but means less shifting
and masking when using these values internally.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 41 +++++++++++++++++++++++++++++++++--------
 hw/display/ati_2d.c   | 12 ++++++------
 hw/display/ati_int.h  | 10 ++++++++--
 hw/display/ati_regs.h | 33 +++++++++++++++++++++++++++++----
 4 files changed, 76 insertions(+), 20 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index e9c3ad2cd1..0bbe8915f1 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -460,7 +460,14 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         val = s->regs.dst_y;
         break;
     case DP_GUI_MASTER_CNTL:
-        val = s->regs.dp_gui_master_cntl;
+        val = s->regs.dp_gui_master_cntl |
+              (s->regs.dp_brush_datatype << 4) |
+              (s->regs.dp_dst_datatype << 8) |
+              (s->regs.dp_src_datatype << 12) |
+              (s->regs.byte_pix_order << 14) |
+              (s->regs.conversion_temp << 15) |
+              (s->regs.dp_rop3 << 16) |
+              (s->regs.dp_src_source << 24);
         break;
     case SRC_OFFSET:
         val = s->regs.src_offset;
@@ -487,10 +494,15 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         val = s->regs.dp_cntl;
         break;
     case DP_DATATYPE:
-        val = s->regs.dp_datatype;
+        val = (s->regs.dp_dst_datatype) |
+              (s->regs.dp_brush_datatype << 8) |
+              (s->regs.dp_src_datatype << 16) |
+              (s->regs.host_big_endian_en << 29) |
+              (s->regs.byte_pix_order << 30) |
+              (s->regs.conversion_temp << 31);
         break;
     case DP_MIX:
-        val = s->regs.dp_mix;
+        val = (s->regs.dp_rop3 << 16) | (s->regs.dp_src_source << 8);
         break;
     case DP_WRITE_MASK:
         val = s->regs.dp_write_mask;
@@ -858,10 +870,17 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         ati_2d_blt(s);
         break;
     case DP_GUI_MASTER_CNTL:
+        /* Mask out fields that are stored independently */
         s->regs.dp_gui_master_cntl = data & 0xf800000f;
-        s->regs.dp_datatype = (data & 0x0f00) >> 8 | (data & 0x30f0) << 4 |
-                              (data & 0x4000) << 16;
-        s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
+        /* DP_DATATYPE fields */
+        s->regs.dp_brush_datatype = (data & GMC_BRUSH_DATATYPE_MASK) >> 4;
+        s->regs.dp_dst_datatype = (data & GMC_DST_DATATYPE_MASK) >> 8;
+        s->regs.dp_src_datatype = (data & GMC_SRC_DATATYPE_MASK) >> 12;
+        s->regs.byte_pix_order = (data & GMC_BYTE_PIX_ORDER) >> 14;
+        s->regs.conversion_temp = (data & GMC_CONVERSION_TEMP) >> 15;
+        /* DP_MIX fields */
+        s->regs.dp_rop3 = (data & GMC_ROP3_MASK) >> 16;
+        s->regs.dp_src_source = (data & GMC_SRC_SOURCE_MASK) >> 24;
         break;
     case DST_WIDTH_X:
         s->regs.dst_x = data & 0x3fff;
@@ -910,10 +929,16 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dp_cntl = data;
         break;
     case DP_DATATYPE:
-        s->regs.dp_datatype = data & 0xe0070f0f;
+        s->regs.dp_dst_datatype = (data & DP_DATATYPE_DST_DATATYPE_MASK);
+        s->regs.dp_brush_datatype = (data & DP_DATATYPE_BRUSH_DATATYPE_MASK) >> 8;
+        s->regs.dp_src_datatype = (data & DP_DATATYPE_SRC_DATATYPE_MASK) >> 16;
+        s->regs.host_big_endian_en = (data & DP_DATATYPE_HOST_BE_EN) >> 29;
+        s->regs.byte_pix_order = (data & DP_DATATYPE_BYTE_PIX_ORDER) >> 30;
+        s->regs.conversion_temp = (data & DP_DATATYPE_CONVERSION_TEMP) >> 31;
         break;
     case DP_MIX:
-        s->regs.dp_mix = data & 0x00ff0700;
+        s->regs.dp_src_source = (data & DP_MIX_SRC_SOURCE_MASK) >> 8;
+        s->regs.dp_rop3 = (data & DP_MIX_ROP3_MASK) >> 16;
         break;
     case DP_WRITE_MASK:
         s->regs.dp_write_mask = data;
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 309bb5ccb6..0531d1a526 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -26,7 +26,7 @@
 
 static int ati_bpp_from_datatype(ATIVGAState *s)
 {
-    switch (s->regs.dp_datatype & 0xf) {
+    switch (s->regs.dp_dst_datatype) {
     case 2:
         return 8;
     case 3:
@@ -38,7 +38,7 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
         return 32;
     default:
         qemu_log_mask(LOG_UNIMP, "Unknown dst datatype %d\n",
-                      s->regs.dp_datatype & 0xf);
+                      s->regs.dp_dst_datatype);
         return 0;
     }
 }
@@ -53,7 +53,7 @@ void ati_2d_blt(ATIVGAState *s)
     DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
-            (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
+            (s->regs.dp_rop3));
     unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
                       s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
     unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
@@ -89,7 +89,7 @@ void ati_2d_blt(ATIVGAState *s)
             s->regs.dst_width, s->regs.dst_height,
             (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ? '>' : '<'),
             (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ? 'v' : '^'));
-    switch (s->regs.dp_mix & GMC_ROP3_MASK) {
+    switch (s->regs.dp_rop3) {
     case ROP3_SRCCOPY:
     {
         bool fallback = false;
@@ -191,7 +191,7 @@ void ati_2d_blt(ATIVGAState *s)
     {
         uint32_t filler = 0;
 
-        switch (s->regs.dp_mix & GMC_ROP3_MASK) {
+        switch (s->regs.dp_rop3) {
         case ROP3_PATCOPY:
             filler = s->regs.dp_brush_frgd_clr;
             break;
@@ -239,6 +239,6 @@ void ati_2d_blt(ATIVGAState *s)
     }
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
-                      (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
+                      s->regs.dp_rop3);
     }
 }
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index f5a47b82b0..59a1812034 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -75,13 +75,19 @@ typedef struct ATIVGARegs {
     uint32_t dp_src_frgd_clr;
     uint32_t dp_src_bkgd_clr;
     uint32_t dp_cntl;
-    uint32_t dp_datatype;
-    uint32_t dp_mix;
     uint32_t dp_write_mask;
     uint32_t default_offset;
     uint32_t default_pitch;
     uint32_t default_tile;
     uint32_t default_sc_bottom_right;
+    uint8_t dp_src_source;
+    uint8_t dp_rop3;
+    uint8_t dp_dst_datatype;
+    uint8_t dp_brush_datatype;
+    uint8_t dp_src_datatype;
+    bool host_big_endian_en;
+    bool byte_pix_order;
+    bool conversion_temp;
 } ATIVGARegs;
 
 struct ATIVGAState {
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index d7127748ff..fce9270635 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -381,6 +381,12 @@
 #define PM4_BUFFER_CNTL_NONPM4                  0x00000000
 
 /* DP_DATATYPE bit constants */
+#define DP_DATATYPE_DST_DATATYPE_MASK           0x0000000f
+#define DP_DATATYPE_BRUSH_DATATYPE_MASK         0x00000f00
+#define DP_DATATYPE_SRC_DATATYPE_MASK           0x00030000
+#define DP_DATATYPE_HOST_BE_EN                  0x20000000
+#define DP_DATATYPE_BYTE_PIX_ORDER              0x40000000
+#define DP_DATATYPE_CONVERSION_TEMP             0x80000000
 #define DST_8BPP                                0x00000002
 #define DST_15BPP                               0x00000003
 #define DST_16BPP                               0x00000004
@@ -394,6 +400,11 @@
 #define GMC_DST_PITCH_OFFSET_CNTL               0x00000002
 #define GMC_SRC_CLIP_DEFAULT                    0x00000000
 #define GMC_DST_CLIP_DEFAULT                    0x00000000
+#define GMC_BRUSH_DATATYPE_MASK                 0x000000f0
+#define GMC_DST_DATATYPE_MASK                   0x00000f00
+#define GMC_SRC_DATATYPE_MASK                   0x00003000
+#define GMC_BYTE_PIX_ORDER                      0x00004000
+#define GMC_CONVERSION_TEMP                     0x00008000
 #define GMC_BRUSH_SOLIDCOLOR                    0x000000d0
 #define GMC_SRC_DSTCOLOR                        0x00003000
 #define GMC_BYTE_ORDER_MSB_TO_LSB               0x00000000
@@ -404,12 +415,24 @@
 #define GMC_WRITE_MASK_SET                      0x40000000
 #define GMC_DP_CONVERSION_TEMP_6500             0x00000000
 
+/* DP_GUI_MASTER_CNTL DP_SRC_DATATYPE named constants */
+#define GMC_SRC_DATATYPE_MASK                   0x00003000
+#define GMC_SRC_DATATYPE_MONO_FRGD_BKGD         0
+#define GMC_SRC_DATATYPE_MONO_FRGD              1
+#define GMC_SRC_DATATYPE_COLOR                  3
+
+/* DP_GUI_MASTER_CNTL DP_SRC_SOURCE named constants */
+#define GMC_SRC_SOURCE_MASK                     0x07000000
+#define GMC_SRC_SOURCE_MEMORY                   2
+#define GMC_SRC_SOURCE_HOST_DATA                3
+#define GMC_SRC_SOURCE_HOST_DATA_ALIGNED        4
+
 /* DP_GUI_MASTER_CNTL ROP3 named constants */
 #define GMC_ROP3_MASK                           0x00ff0000
-#define ROP3_BLACKNESS                          0x00000000
-#define ROP3_SRCCOPY                            0x00cc0000
-#define ROP3_PATCOPY                            0x00f00000
-#define ROP3_WHITENESS                          0x00ff0000
+#define ROP3_BLACKNESS                          0
+#define ROP3_SRCCOPY                            0xcc
+#define ROP3_PATCOPY                            0xf0
+#define ROP3_WHITENESS                          0xff
 
 #define SRC_DSTCOLOR                            0x00030000
 
@@ -434,6 +457,8 @@
 #define DST_POLY_EDGE                           0x00040000
 
 /* DP_MIX bit constants */
+#define DP_MIX_SRC_SOURCE_MASK                  0x00000700
+#define DP_MIX_ROP3_MASK                        0x00ff0000
 #define DP_SRC_RECT                             0x00000200
 #define DP_SRC_HOST                             0x00000300
 #define DP_SRC_HOST_BYTEALIGN                   0x00000400
-- 
2.51.2


