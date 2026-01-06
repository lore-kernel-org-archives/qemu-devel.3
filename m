Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96154CEFCF2
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 18:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdCFN-0004P3-Df; Tue, 06 Jan 2026 13:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCF4-0004I2-8t
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:19 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vdCEz-0001xV-Pl
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 13:57:18 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id B57B11D0011E;
 Tue,  6 Jan 2026 13:57:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 06 Jan 2026 13:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767725832; x=
 1767812232; bh=TMy1K/DMjYp2J0pX1A+XL69Sq60qdOX9TaoYpnfRYqM=; b=r
 23ynbBE6vqCs8se146zlWJabtjju8kuMbA0IpmM4Yp2b19XkwzuT0nq23rheF7UB
 bLTrZKTX2x5GBrPI3qbKU27L5MECyXKImAcQgL31BTQWtxC0HeXc7ezhl8NxdWaQ
 oU/4q7g4M+MA/ZVt8aqk12V3y3/Yt7IyyiabzJIluqR6TbyMQ6TS91Ulhmtq6X3Q
 ozZqZD7ZqWCnPumU6SGEazgtf8mv0TuBg93B+EYHptt1jfrPaPVmwXfz4HjQ4AKW
 13E/Ta2NLjSJNfAKHycaaucLItzUeIPaC9yxGIF17ebjTmmCV/VKAlNzADtEs0RY
 UPIFZufXZ+STrobkpIvUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767725832; x=1767812232; bh=T
 My1K/DMjYp2J0pX1A+XL69Sq60qdOX9TaoYpnfRYqM=; b=QS92ZHe6YibJn1No+
 IBDsDsSi3i1THv/IU8Fze+8ZGOhi3TEpZWw35C9sGqfEqu3iCC7emlMbJ8XQSwB6
 WuwvfOX0YrAjcKjSzxdOHJbYlPEa8Prq2Yee4sW9del4JKhO0u4BiwX6XEY2lcbO
 4pjAF2VH3EAftFqqFG2Tu98T5BFZsL7UzFEIh+DiVJbYFiV7rX7dj3er+oFm36ts
 LVuCMFPapIQcIgJHX95lFn/dLvS+4xWAX/b0Gg2YePCTnT5OJyfsql4R4u0bRQJI
 8zlzw5vakWmDZggXsH4cOfxQthxJJF049kwwloLFOarSobH+f1sSq56hPLN29Jv/
 pG8Zw==
X-ME-Sender: <xms:CFtdaQgbYMJpM_RmQYfwklx3-b7-YJxNGsXnzWyEc2kc-1vVu0kTWg>
 <xme:CFtdaQeqZqiV_s3EoaSp31UqOC4jAI428wqiCHuunGUGNXp3JLLoESM6RCmXOc3Kt
 iW9vs2NpdQ09nca0Exwe6PgWWdFsXWJoqXPVdKyIocQHWY1KKmsdsU>
X-ME-Received: <xmr:CFtdaVe3avVPs3bkaWvGC1rXSxHGawGo4gWHwcqOzbjwjHqAs_ib_Is7bixF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtleejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:CFtdaa-9Jr4I27chz7bavJlRhC7jq0xGU3UvJeoyyrcBrfSvBKw99g>
 <xmx:CFtdaRl5n87A0lIjQjSAbzssgtd9kM6DLpmeaOxn46_TOieAJBv8og>
 <xmx:CFtdac-GUJzHLXQ0NdxEwmUwK8IIkA-FBtRscJrBr2MlBRCSg6zjSQ>
 <xmx:CFtdaflpDh4c8sY4FQ5-pvNJZl1L80viy_AZG2k3ynADaUGHRojEAQ>
 <xmx:CFtdaQpVebneOskK7FGsaTJL_6Z_Mel6z_D0nviJTPSrvdKRGFD88e_X>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 13:57:12 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 6969dca7;
 Tue, 6 Jan 2026 18:57:07 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v4 8/9] ati-vga: Implement HOST_DATA register writes
Date: Tue,  6 Jan 2026 13:56:59 -0500
Message-ID: <20260106185700.2102742-9-chad@jablonski.xyz>
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

Writing to any of the HOST_DATA0-7 registers pushes the written data
into a 128-bit accumulator. When the accumulator is full a flush is
triggered to copy it to the framebuffer. A final write to HOST_DATA_LAST
will also initiate a flush. The flush itself is left for the next patch.

Unaligned HOST_DATA* writes result in, from what I can tell, undefined
behavior on real hardware. A well-behaved driver shouldn't be doing this
anyway. For that reason they are not handled here at all.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 32 ++++++++++++++++++++++++++++++++
 hw/display/ati_dbg.c  |  9 +++++++++
 hw/display/ati_int.h  |  9 +++++++++
 hw/display/ati_regs.h |  9 +++++++++
 4 files changed, 59 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 04f1c3c790..88d30bf532 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -567,6 +567,13 @@ static inline void ati_reg_write_offs(uint32_t *reg, int offs,
     }
 }
 
+static void ati_host_data_reset(ATIHostDataState *hd)
+{
+    hd->next = 0;
+    hd->row = 0;
+    hd->col = 0;
+}
+
 static void ati_mm_write(void *opaque, hwaddr addr,
                            uint64_t data, unsigned int size)
 {
@@ -842,6 +849,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         break;
     case DST_WIDTH:
         s->regs.dst_width = data & 0x3fff;
+        ati_host_data_reset(&s->host_data);
         ati_2d_blt(s);
         break;
     case DST_HEIGHT:
@@ -892,6 +900,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DST_HEIGHT_WIDTH:
         s->regs.dst_width = data & 0x3fff;
         s->regs.dst_height = (data >> 16) & 0x3fff;
+        ati_host_data_reset(&s->host_data);
         ati_2d_blt(s);
         break;
     case DP_GUI_MASTER_CNTL:
@@ -929,6 +938,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DST_WIDTH_X:
         s->regs.dst_x = data & 0x3fff;
         s->regs.dst_width = (data >> 16) & 0x3fff;
+        ati_host_data_reset(&s->host_data);
         ati_2d_blt(s);
         break;
     case SRC_X_Y:
@@ -942,6 +952,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DST_WIDTH_HEIGHT:
         s->regs.dst_height = data & 0x3fff;
         s->regs.dst_width = (data >> 16) & 0x3fff;
+        ati_host_data_reset(&s->host_data);
         ati_2d_blt(s);
         break;
     case DST_HEIGHT_Y:
@@ -1043,6 +1054,25 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case SRC_SC_BOTTOM:
         s->regs.src_sc_bottom = data & 0x3fff;
         break;
+    case HOST_DATA0:
+    case HOST_DATA1:
+    case HOST_DATA2:
+    case HOST_DATA3:
+    case HOST_DATA4:
+    case HOST_DATA5:
+    case HOST_DATA6:
+    case HOST_DATA7:
+        s->host_data.acc[s->host_data.next++] = data;
+        if (s->host_data.next >= 4) {
+            qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
+            s->host_data.next = 0;
+        }
+        break;
+    case HOST_DATA_LAST:
+        s->host_data.acc[s->host_data.next] = data;
+        qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
+        ati_host_data_reset(&s->host_data);
+        break;
     default:
         break;
     }
@@ -1136,6 +1166,8 @@ static void ati_vga_reset(DeviceState *dev)
     /* reset vga */
     vga_common_reset(&s->vga);
     s->mode = VGA_MODE;
+
+    ati_host_data_reset(&s->host_data);
 }
 
 static void ati_vga_exit(PCIDevice *dev)
diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
index 3ffa7f35df..5c799d540a 100644
--- a/hw/display/ati_dbg.c
+++ b/hw/display/ati_dbg.c
@@ -252,6 +252,15 @@ static struct ati_regdesc ati_reg_names[] = {
     {"MC_SRC1_CNTL", 0x19D8},
     {"TEX_CNTL", 0x1800},
     {"RAGE128_MPP_TB_CONFIG", 0x01c0},
+    {"HOST_DATA0", 0x17c0},
+    {"HOST_DATA1", 0x17c4},
+    {"HOST_DATA2", 0x17c8},
+    {"HOST_DATA3", 0x17cc},
+    {"HOST_DATA4", 0x17d0},
+    {"HOST_DATA5", 0x17d4},
+    {"HOST_DATA6", 0x17d8},
+    {"HOST_DATA7", 0x17dc},
+    {"HOST_DATA_LAST", 0x17e0},
     {NULL, -1}
 };
 
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index d9ac8ee135..3029dc7e3c 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -14,6 +14,7 @@
 #include "hw/i2c/bitbang_i2c.h"
 #include "vga_int.h"
 #include "qom/object.h"
+#include "qemu/units.h"
 
 /*#define DEBUG_ATI*/
 
@@ -97,6 +98,13 @@ typedef struct ATIVGARegs {
     uint16_t src_sc_right;
 } ATIVGARegs;
 
+typedef struct ATIHostDataState {
+    uint32_t row;
+    uint32_t col;
+    uint32_t next;
+    uint32_t acc[4];
+} ATIHostDataState;
+
 struct ATIVGAState {
     PCIDevice dev;
     VGACommonState vga;
@@ -113,6 +121,7 @@ struct ATIVGAState {
     MemoryRegion io;
     MemoryRegion mm;
     ATIVGARegs regs;
+    ATIHostDataState host_data;
 };
 
 const char *ati_reg_name(int num);
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 9c638314f0..c8bbafe1c6 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -252,6 +252,15 @@
 #define DP_T12_CNTL                             0x178c
 #define DST_BRES_T1_LNTH                        0x1790
 #define DST_BRES_T2_LNTH                        0x1794
+#define HOST_DATA0                              0x17c0
+#define HOST_DATA1                              0x17c4
+#define HOST_DATA2                              0x17c8
+#define HOST_DATA3                              0x17cc
+#define HOST_DATA4                              0x17d0
+#define HOST_DATA5                              0x17d4
+#define HOST_DATA6                              0x17d8
+#define HOST_DATA7                              0x17dc
+#define HOST_DATA_LAST                          0x17e0
 #define SCALE_SRC_HEIGHT_WIDTH                  0x1994
 #define SCALE_OFFSET_0                          0x1998
 #define SCALE_PITCH                             0x199c
-- 
2.51.2


