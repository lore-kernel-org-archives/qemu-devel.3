Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30474CEE32A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNxQ-0005l1-Fo; Tue, 18 Nov 2025 10:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwr-0004xN-Uk
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:57 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vLNwi-0001wN-M8
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:48:50 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id AE0437A01A2;
 Tue, 18 Nov 2025 10:48:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 18 Nov 2025 10:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1763480912; x=
 1763567312; bh=xP7ee5deXC3cx6fsf+EWJjx4WhXOJ95aF8qXAbt7Hoo=; b=A
 4IayLg0Rnk0+8dMgj9xDcsuZmPwNWTR+Dr3kfu7l0pz919WMrUrkljoQb0sQ1dia
 tIn2rXgmSdvK8/fnS3KWf/bggl6U0NhM7Pj+AEA0m50i+qmzQNTGyRTtsjrof5MN
 pQWh7WtUFgm9nkqRXUyVIPoogM/XLCnVOnNMq839lBbo/6y2kVRLNpP5ewbK3zyb
 5l9mdCvhZz6DPAzY/aCi6sKwAZfoLm3gM1lWzmEb4jr1mO5vHpK/M6DnK44xHq8+
 9AGTIhAc+JzdgAVvqQ5nTbyQyo9G8wlG7NRWl1YzmKidK6Apg5+sMuajUCSiCaPG
 jNPkgnR43NhK84aeNGujg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1763480912; x=1763567312; bh=x
 P7ee5deXC3cx6fsf+EWJjx4WhXOJ95aF8qXAbt7Hoo=; b=bM7GMXOOAymp6q+UM
 9weTeTC3xjJh1Z7t0BETxeI2Y0yY9Coh/gMaSamKqrh7eRoD+oFaxC3Iu0Xg3DUh
 hFIh7592LEmatJEIALf796x+wpTBu+pumI9exPiifDLQbpvPvvbbWq+hDpAkiPBV
 S1Y7E5Un11ZvoCqVQZZJuxh7s3MoABoTLa9XiXD6x+dUp5jr8a7qpltsTofoJ1Yd
 3NnVRyRJAYrwrMG8Rh6biEqcIKvyiVajuaou6+8GN8jDcFnp/H1nWkmpoEw1tfRD
 lahi+QTl6YyeLVGT7hIAEYDuut3yPq7ysjr+TMkRMTpNqzCMfkrpi12vcu3YZQpn
 g5R8A==
X-ME-Sender: <xms:UJUcaeihUVSL-RP46_4jYuGQy_Fl6SSDNK3vceTRG1haS62I91_WqQ>
 <xme:UJUcaWdX6mFfGszZrRVVh84ClvvDCAtQ0P4I-8AQTlnWRfmPcO7mGKE15IEA56v6P
 YATR2jXJMUSpN5YTQVmlSLeW1F7kDgFUMzx12Qr9X8AO8vf3q8s>
X-ME-Received: <xmr:UJUcaTfJv1T9z01YgpKVAmWk_F3ZJLITLwnQDLkopTMJDCjzFEbNqGVyOyaa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddujedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpth
 htoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsggrlhgrthho
 nhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:UJUcaQ-a7n3hDJnn4UHSBPEIVzFiUA0f9wf1i-ZfY-hBsdm7oDdMzQ>
 <xmx:UJUcafmNNm8vDxlFIlHB0RMo50ZCijGHJwHLIEA37fwiij7vjsL-Ow>
 <xmx:UJUcaS-q5TcYpF30Bwj1zT2euM4QVbfOYG3urJIh__A1K9LcxqKU5A>
 <xmx:UJUcadm51jZmhwqqKmyQaQJNoktYz9kkvPimLSsztG7cKSN-Y_PZuA>
 <xmx:UJUcaWpHtyML1ORWMlfH_kP0oVRonm7zYPUasI2dRCMVSKZ5Yoqrl5mG>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 10:48:31 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id b846bca0;
 Tue, 18 Nov 2025 15:48:31 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 02/11] ati-vga: Add scissor clipping register support
Date: Tue, 18 Nov 2025 10:48:03 -0500
Message-ID: <20251118154812.57861-3-chad@jablonski.xyz>
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
---
 hw/display/ati.c      | 71 +++++++++++++++++++++++++++++++++++++++++--
 hw/display/ati_int.h  |  9 +++++-
 hw/display/ati_regs.h | 12 ++++++--
 3 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 66fad6459a..cb979ae0fa 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -508,7 +508,32 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
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
@@ -862,6 +887,17 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dp_datatype = (data & 0x0f00) >> 8 | (data & 0x30f0) << 4 |
                               (data & 0x4000) << 16;
         s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
+
+        if ((data & GMC_SRC_CLIPPING_MASK) == GMC_SRC_CLIP_DEFAULT) {
+            s->regs.src_sc_right = s->regs.default_sc_right;
+            s->regs.src_sc_bottom = s->regs.default_sc_bottom;
+        }
+        if ((data & GMC_DST_CLIPPING_MASK) == GMC_DST_CLIP_DEFAULT) {
+            s->regs.sc_top = 0;
+            s->regs.sc_left = 0;
+            s->regs.sc_right = s->regs.default_sc_right;
+            s->regs.sc_bottom = s->regs.default_sc_bottom;
+        }
         break;
     case DST_WIDTH_X:
         s->regs.dst_x = data & 0x3fff;
@@ -935,7 +971,38 @@ static void ati_mm_write(void *opaque, hwaddr addr,
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
index 708cc1dd3a..1e999b11c2 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -85,7 +85,14 @@ typedef struct ATIVGARegs {
     uint32_t default_offset;
     uint32_t default_pitch;
     uint32_t default_tile;
-    uint32_t default_sc_bottom_right;
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


