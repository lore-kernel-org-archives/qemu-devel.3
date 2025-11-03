Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33611CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFlMy-0005hO-1w; Sun, 02 Nov 2025 22:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFlMt-0005gk-Od
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:36:32 -0500
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vFlMp-0007zk-B8
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:36:30 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0407414000DE;
 Sun,  2 Nov 2025 22:36:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sun, 02 Nov 2025 22:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1762140986; x=
 1762227386; bh=X51JYdqovByw+iWifxRgLEf3MHGDJowVU8SgOzqIV1Y=; b=H
 t3FZinqSMJ7m6LAppBVkFUW1P+BJue4tFpqHJwQsUF8Dc+kY1z8pXw2or3hlRTBL
 5YguVmuRQu+zSPAdN6pE8io12084znlYlWwNisOiur3nc7a8iJqdPJaKKvi2oWx+
 bsd0X/8JOzz1fF4Ln0X5++bswK8pQ4IHUc4TLYRyfjL5UNM3dTZ1VE9NDI2Rge+S
 PCjDgs0Ye287y/CkGKJ/P6NoSZSG5bQpbOf87mU4oSYv0DEPGfWzRuwRKhsU8keK
 9OjZ3TuFOXkBlykKKbm8ge29LmEDo3sGYBUVq9z97v1JvheOHY582HUjpGpG3HkZ
 cd00Wr/ncDiSs0/Sf5H/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1762140986; x=1762227386; bh=X
 51JYdqovByw+iWifxRgLEf3MHGDJowVU8SgOzqIV1Y=; b=n12BUe2FF26Ddzp1E
 Ne4uotxhdC4h+glbpQh+qe0CFp4eZhKmZd2tq7KBx+VdoPk/ZFcao78UwoDP35SJ
 u3M0toqiEBf3S/om0gHh5Qtj7oSlLNwdu8A52TIeRYzbY7/try5+a9vRIzDbxqOc
 yz2tvoc/bw0ngl1Sb8WYSRJkTjStcoglTNQ0MdiyxcTe7YmSa2K3lnnx5QddLtJS
 /+V16IwQ+9SvXb3ltARhV5KM/TH/dS+KelzBUAO+ole5m7ybAD6sf5FT8UW6RpZf
 SgwprXPZRzPUcykRpIBF62Yqc9cLMFl+2CYzO4NmNShZJe2EOw6axIUuPEQrMOz8
 wjjeQ==
X-ME-Sender: <xms:OSMIaZxDmSl_IBQ6t-8fhFBj2ZxHFTmK0DDEG_w-r-d_p_0E4TZEpA>
 <xme:OSMIaQvpobYHdQBrkXpRFJO9uFSEmiY4vuqeN0hnuToGJ39_1dAFh7XNCzqOdy4ln
 siZlwM1FB1OeKkCiXPEkI6QmCvagPWwoUfB4Co5xD3UowachtHEMAA>
X-ME-Received: <xmr:OSMIaQsk8s7PGoN8DzxukW92Azftuv4VbwD7ZI6nr2wgYBlYhdkHaPmJOuoR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejtdejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhope
 gthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:OSMIaVO-aVZ15ZVWBvzN5xGPHvVTOCo9TUT1o7wjtkdfDYutBR2i5A>
 <xmx:OSMIae0W6qQ1mYdZwdJbH1EN7wvdaIPHZbwCIC9rhnXgFvY05nEI_A>
 <xmx:OSMIaRMyUjv_FBIpQe9u5J-6jouFyjIFnlJFAXeVb7JfMymHOmSbkg>
 <xmx:OSMIae1tUyylf6Hu27hFbC7YqtwpXkh8JJtVeblNIi5IT_1yVRuabQ>
 <xmx:OSMIae59aiIAoM4ksSVNQGo34K4QuLlX9lez0_a7sVTBvzkzLlM1Koel>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 22:36:24 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id a6ea2445;
 Mon, 3 Nov 2025 03:36:23 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2 1/7] ati-vga: Add scissor clipping register support
Date: Sun,  2 Nov 2025 22:36:02 -0500
Message-ID: <20251103033608.120908-2-chad@jablonski.xyz>
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

Implement read and write operations on SC_TOP_LEFT, SC_BOTTOM_RIGHT,
and SRC_SC_BOTTOM_RIGHT registers. These registers are also updated
when the src and/or dst clipping fields on DP_GUI_MASTER_CNTL are set
to default clipping.

Scissor clipping is used when rendering text in X.org. The r128 driver
sends host data much wider than is necessary to draw a glyph and cuts it
down to size using clipping before rendering. The actual clipping
implementation follows in a future patch.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 26 ++++++++++++++++++++++++++
 hw/display/ati_int.h  |  3 +++
 hw/display/ati_regs.h | 12 ++++++++++--
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 0b4298d078..eb9b30672f 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -510,6 +510,15 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case DEFAULT_SC_BOTTOM_RIGHT:
         val = s->regs.default_sc_bottom_right;
         break;
+    case SC_TOP_LEFT:
+        val = s->regs.sc_top_left;
+        break;
+    case SC_BOTTOM_RIGHT:
+        val = s->regs.sc_bottom_right;
+        break;
+    case SRC_SC_BOTTOM_RIGHT:
+        val = s->regs.src_sc_bottom_right;
+        break;
     default:
         break;
     }
@@ -862,6 +871,14 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dp_datatype = (data & 0x0f00) >> 8 | (data & 0x30f0) << 4 |
                               (data & 0x4000) << 16;
         s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
+
+        if ((data & GMC_SRC_CLIPPING_MASK) == GMC_SRC_CLIP_DEFAULT) {
+            s->regs.src_sc_bottom_right = s->regs.default_sc_bottom_right;
+        }
+        if ((data & GMC_DST_CLIPPING_MASK) == GMC_DST_CLIP_DEFAULT) {
+            s->regs.sc_top_left = 0;
+            s->regs.sc_bottom_right = s->regs.default_sc_bottom_right;
+        }
         break;
     case DST_WIDTH_X:
         s->regs.dst_x = data & 0x3fff;
@@ -937,6 +954,15 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DEFAULT_SC_BOTTOM_RIGHT:
         s->regs.default_sc_bottom_right = data & 0x3fff3fff;
         break;
+    case SC_TOP_LEFT:
+        s->regs.sc_top_left = data;
+        break;
+    case SC_BOTTOM_RIGHT:
+        s->regs.sc_bottom_right = data;
+        break;
+    case SRC_SC_BOTTOM_RIGHT:
+        s->regs.src_sc_bottom_right = data;
+        break;
     default:
         break;
     }
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 708cc1dd3a..aab3cbf81a 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -86,6 +86,9 @@ typedef struct ATIVGARegs {
     uint32_t default_pitch;
     uint32_t default_tile;
     uint32_t default_sc_bottom_right;
+    uint32_t sc_top_left;
+    uint32_t sc_bottom_right;
+    uint32_t src_sc_bottom_right;
 } ATIVGARegs;
 
 struct ATIVGAState {
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index d7127748ff..2b56b9fb66 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -392,8 +392,6 @@
 /* DP_GUI_MASTER_CNTL bit constants */
 #define GMC_SRC_PITCH_OFFSET_CNTL               0x00000001
 #define GMC_DST_PITCH_OFFSET_CNTL               0x00000002
-#define GMC_SRC_CLIP_DEFAULT                    0x00000000
-#define GMC_DST_CLIP_DEFAULT                    0x00000000
 #define GMC_BRUSH_SOLIDCOLOR                    0x000000d0
 #define GMC_SRC_DSTCOLOR                        0x00003000
 #define GMC_BYTE_ORDER_MSB_TO_LSB               0x00000000
@@ -404,6 +402,16 @@
 #define GMC_WRITE_MASK_SET                      0x40000000
 #define GMC_DP_CONVERSION_TEMP_6500             0x00000000
 
+/* DP_GUI_MASTER_CNTL DP_SRC_CLIPPING named constants */
+#define GMC_SRC_CLIPPING_MASK                   0x00000004
+#define GMC_SRC_CLIP_DEFAULT                    0x00000000
+#define GMC_SRC_CLIP_LEAVE_ALONE                0x00000004
+
+/* DP_GUI_MASTER_CNTL DP_DST_CLIPPING named constants */
+#define GMC_DST_CLIPPING_MASK                   0x00000008
+#define GMC_DST_CLIP_DEFAULT                    0x00000000
+#define GMC_DST_CLIP_LEAVE_ALONE                0x00000008
+
 /* DP_GUI_MASTER_CNTL ROP3 named constants */
 #define GMC_ROP3_MASK                           0x00ff0000
 #define ROP3_BLACKNESS                          0x00000000
-- 
2.51.0


