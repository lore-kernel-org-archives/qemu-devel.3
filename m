Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A64CEE327
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNxT-0005nU-CY; Tue, 18 Nov 2025 10:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwv-000514-ST
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:58 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwt-0001xC-Sg
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:57 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D05337A01E7;
 Tue, 18 Nov 2025 10:48:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 18 Nov 2025 10:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1763480917; x=
 1763567317; bh=DHfMJm90VsM7kQKgvIvw0QuFSuaf25hpBjZModfq2y0=; b=H
 2oHVDKXOvjyC877uQrR6ig2o11RNAiFi6XfdITzOtoU4A9T7+cq6DQk2lxcQzSPb
 11yJIPZXMGY/mKxEZIzGGDvXWTDksXkZdUehgIuVxGOC3w8E0lrY/C6tMFLO4ezI
 pEyR0OBxX/101h5iFdd1iCqACNWxuRYccQLXUevzJitOtriygxt7fiVF0ULdSwEK
 cotNXcJM5UeGP7whdMWZe+TV5MQRqbxM1hLFAu630UL1YDzR/8YFJrquA2LzZRdi
 0VGcZMlgU7K5oO3jK9t3OOikGsJXdHmTZRr6PMiRC6qVXKzmXU67Eumz03c4NcP0
 K8e/DBNQgtvFHjh7d8o+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1763480917; x=1763567317; bh=D
 HfMJm90VsM7kQKgvIvw0QuFSuaf25hpBjZModfq2y0=; b=fjdkir2hJU8brX3F7
 xuJFdmKdcSmyOzy7ots7JdvIZuZ5dS1UGN7zJ3s+h925sVHPI9P4hmsCMLfOLl5e
 w0p57d0TfipUneebj4mbkhsaz2X2wAfQrfKy+8zWgetqVWUmLE6F1+h7ZcRDZ0Fk
 bt9bXR4j3mZU4tcIcSFSjU3YuFEj8U9kYxFc2EqJAM/mC8FtPmwDoYi/2zF+a0LT
 YWLuIQ2P1tVn0I9ipY1dpwqOjYmT1Yxh2T1i8oMnnZ0y5KZPYWl8ylgAJdB1MPL5
 APpI55IOMk3HSPCCNKspvbKh84FmAJ55q7O5hYBCDH2L9YbIpDq72RCkbhn4T1+S
 K5K9Q==
X-ME-Sender: <xms:VZUcaQK3lEl0BgpYcAV95FuxyHVVIx4JGSbECzYhj6lNLtLxOOYi5A>
 <xme:VZUcaXmvZxTtx-9QNEimmLBuExEH5WBxKiUDIeWH6aREcARGQoCBBGQ-5EObry2RE
 5QFJpgn6SbllspKs4LmlzUdh8W4jmHQhm_bdSvDegdGw4n3Bzjy6Wk>
X-ME-Received: <xmr:VZUcaeF01r2t9bw12HEoTtZ0aEov5R-Ol9v7yOfImOe45E0RnWB8W973vHUv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddujedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:VZUcaXFtiEfTUlGI8app84ElZV5uQTeClPoet0-0O46GvAquSsaHAQ>
 <xmx:VZUcabOa91MDNqd2YVtRNJrLSP8uYczv2bQ3lxYrvE_HyyRxtGJ7Vw>
 <xmx:VZUcaWEx_xZgZ4YCfs5orlMHFLKCeNxENaxF9Y34mj0fM1GEwC8OHg>
 <xmx:VZUcaSM2RCIn7xg6Ick0G-ymODJtPl-Sf3BDi7MEjHSesqcIC3ruhQ>
 <xmx:VZUcaeyX264EPezSDGOrTmGIZYSbuV49li5qD7sU-Imt9OgS6IV83yXV>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 10:48:37 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id d2f15234;
 Tue, 18 Nov 2025 15:48:31 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 10/11] ati-vga: Implement HOST_DATA register writes
Date: Tue, 18 Nov 2025 10:48:11 -0500
Message-ID: <20251118154812.57861-11-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118154812.57861-1-chad@jablonski.xyz>
References: <20251118154812.57861-1-chad@jablonski.xyz>
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

Writing to any of the HOST_DATA0-7 registers pushes the written data
into a 128-bit accumulator. When the accumulator is full a flush is
triggered to copy it to the framebuffer. A final write to HOST_DATA_LAST
will also initiate a flush. The flush itself is left for the next patch.

Unaligned HOST_DATA* writes result in, from what I can tell, undefined
behavior on real hardware. A well-behaved driver shouldn't be doing this
anyway. For that reason they are not handled here at all.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 33 +++++++++++++++++++++++++++++++++
 hw/display/ati_dbg.c  |  9 +++++++++
 hw/display/ati_int.h  |  9 +++++++++
 hw/display/ati_regs.h |  9 +++++++++
 4 files changed, 60 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index cfb5dc2fb8..dc302eb6f2 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -555,6 +555,13 @@ static inline void ati_reg_write_offs(uint32_t *reg, int offs,
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
@@ -830,6 +837,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         break;
     case DST_WIDTH:
         s->regs.dst_width = data & 0x3fff;
+        ati_host_data_reset(&s->host_data);
         ati_2d_blt(s);
         break;
     case DST_HEIGHT:
@@ -880,6 +888,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DST_HEIGHT_WIDTH:
         s->regs.dst_width = data & 0x3fff;
         s->regs.dst_height = (data >> 16) & 0x3fff;
+        ati_host_data_reset(&s->host_data);
         ati_2d_blt(s);
         break;
     case DP_GUI_MASTER_CNTL:
@@ -910,6 +919,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DST_WIDTH_X:
         s->regs.dst_x = data & 0x3fff;
         s->regs.dst_width = (data >> 16) & 0x3fff;
+        ati_host_data_reset(&s->host_data);
         ati_2d_blt(s);
         break;
     case SRC_X_Y:
@@ -923,6 +933,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case DST_WIDTH_HEIGHT:
         s->regs.dst_height = data & 0x3fff;
         s->regs.dst_width = (data >> 16) & 0x3fff;
+        ati_host_data_reset(&s->host_data);
         ati_2d_blt(s);
         break;
     case DST_HEIGHT_Y:
@@ -1017,6 +1028,26 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         break;
     case SRC_SC_BOTTOM:
         s->regs.src_sc_bottom = data & 0x3fff;
+    case HOST_DATA0:
+    case HOST_DATA1:
+    case HOST_DATA2:
+    case HOST_DATA3:
+    case HOST_DATA4:
+    case HOST_DATA5:
+    case HOST_DATA6:
+    case HOST_DATA7:
+        s->host_data.acc[s->host_data.next] = data;
+        if (s->host_data.next >= 3) {
+            qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
+            s->host_data.next = 0;
+            break;
+        }
+        s->host_data.next += 1;
+        break;
+    case HOST_DATA_LAST:
+        s->host_data.acc[s->host_data.next] = data;
+        qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
+        ati_host_data_reset(&s->host_data);
         break;
     default:
         break;
@@ -1123,6 +1154,8 @@ static void ati_vga_reset(DeviceState *dev)
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
index 1e999b11c2..b9142ce6d8 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -15,6 +15,7 @@
 #include "hw/i2c/bitbang_i2c.h"
 #include "vga_int.h"
 #include "qom/object.h"
+#include "qemu/units.h"
 
 /*#define DEBUG_ATI*/
 
@@ -95,6 +96,13 @@ typedef struct ATIVGARegs {
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
@@ -112,6 +120,7 @@ struct ATIVGAState {
     MemoryRegion io;
     MemoryRegion mm;
     ATIVGARegs regs;
+    ATIHostDataState host_data;
 };
 
 const char *ati_reg_name(int num);
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 02025eef36..9eb68fbec6 100644
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
2.51.0


