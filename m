Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DEDE9410C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 03:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vb9oe-0002JP-Pl; Wed, 31 Dec 2025 22:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb9oc-0002H5-0T
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 22:57:34 -0500
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb9oZ-0003il-KL
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 22:57:33 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id EBAC77A009D;
 Wed, 31 Dec 2025 22:57:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 31 Dec 2025 22:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767239850; x=
 1767326250; bh=EkI0gdrEWlcSXoQ6b50KWdouVYdjK0ERFZcdI/3S9yo=; b=V
 1HTEToHoyGUucUhoKmor3FwLJ1HjurtBL3oqh4rdCTQkwdjQH0bP0fy6J2TmDeKv
 VxHrEe0cCPUg5mseXxiFoH72UCXNwGP5BdSLDyYEi+coFUKQ2qJK7Ndv0hQhoA8W
 pd7kC0r5X11QspsSUaZ7QVS7PZX9q+8nnBF0NnBATcFXknY3nfVsO/NOlkFUA4sI
 2zKfRdHZJyOtrhEPlxuH2954inEphw66eVuY3T9ZU4JPYrVYcd2+TFVVcfwbc7IB
 ipxba3zb86JD23QQXy0N/bSY47cmcKbd4XGqU0m1Szt+WX/xm1Mcev/87DZUstbf
 pXVJbcD7iOTiWFoOkbZ1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767239850; x=1767326250; bh=E
 kI0gdrEWlcSXoQ6b50KWdouVYdjK0ERFZcdI/3S9yo=; b=EDZE8q3p09N0mVN18
 FulOc019Y1znIZrCIfZetrzdubIb8b+hMIShNdnTDJSI8yd+u2yBXBr9+1tCaUZ+
 RBwaWUshREp52xRiCmbi+Nz1rYhLskZ+ixBNHJKgPlR5w/lbaecO+0hloCoWTI6Y
 gJWxdwiLY9lbtqTdl+mrSlkyrpzpTExP8iAZUJiTVrjZBtMTSoeGpsGWKQQd8c78
 aUv3dsXXhrOIlZcidWTzdw5l2DRMpU1WwfuBRDBrV98V0nB5tFWdqan3+Mty17M8
 VO9a46x7uYTw4dwcNB3IX4u1As42sSjHWIYZCnNXD2WD5FYXm9GWc7QtF1hyJcyn
 EKWWA==
X-ME-Sender: <xms:qvBVaTiJkfWA89qvgBkXtRtcLMVpqUlutYKG9j1GSZiQlYCPUsAGIQ>
 <xme:qvBVaXe0sREbvz3Rqaf1ICepcQzPqdV1U8rI7rbQTHoofMAnqM7UReqGO2ujz-30z
 olZhoXN1ijTOoAC7go-MH3-61hG0cLQsGs6l3sWgAgHMu7lcsBOOggh>
X-ME-Received: <xmr:qvBVaQfJ_vT0ndbJcA0bkX1Mb27X5qKQu78v9zs8c_frcGWEh79HFGsZ5bzh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekgeejiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvvefuff
 fkofgjfhgggfestdekredtredttdenucfhrhhomhepvehhrgguucflrggslhhonhhskhhi
 uceotghhrggusehjrggslhhonhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefgie
 etjefhleehfeeiteejgfeljeffhfeuffdvudeijefgueeuuedvvdekjefhleenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsg
 hlohhnshhkihdrgiihiidpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtth
 hopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopegsrghlrghtohhn
 segvihhkrdgsmhgvrdhhuh
X-ME-Proxy: <xmx:qvBVaZ9lVoaRjcMoeEBh1_TYvzAQ9Bt9xKXWw4Be7lS9CyRVA9haFA>
 <xmx:qvBVaUmaC82nzEpwK2MufwJTs_U-lYaZxNvgd__omvFOYrxvbtmTUw>
 <xmx:qvBVaT_Ia07HNMMmzInft2Utb2gCVDiou-sGOJni1zlS_XuH2zXhwg>
 <xmx:qvBVaanms-Mpo9_u2aCxL8exWDh36N38fM4l5j43DpHdBTU4PDtw9w>
 <xmx:qvBVafrDy-8GodO2kCHAhSOd7ZuojQYAyTFqr8yrGFW_t1MYffIdtpIM>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 22:57:30 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id fa10c085;
 Thu, 1 Jan 2026 03:57:26 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2 6/7] ati-vga: Process Type-0/1/2 CCE packets via PIO
Date: Wed, 31 Dec 2025 22:55:54 -0500
Message-ID: <20260101035555.1300511-7-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260101035555.1300511-1-chad@jablonski.xyz>
References: <20260101035555.1300511-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.154; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b3-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

While drivers use bus mastering modes, PIO is the simplest place to start.
This implements the PM4_FIFO_DATA_EVEN/ODD registers. Writing to these
registers in sequence places packets into the CCE FIFO directly without
need for a ring buffer. This enables testing of the CCE packet processing
itself. Ring buffer registers will follow in a future patch.

Type-0 and Type-1 packets write to registers. Type-2 packets are NOPs.
Type-3 packet headers are parsed but only logged as of now.

Hardware testing and poking at the microcode suggests that Type-0/1/2
packets may be implemented in hardware and not the microcode. Type-3,
however, definitely depends on the microcode.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c        |  10 +++
 hw/display/ati_cce.c    | 156 ++++++++++++++++++++++++++++++++++++++++
 hw/display/ati_cce.h    |  56 +++++++++++++++
 hw/display/meson.build  |   2 +-
 hw/display/trace-events |   9 +++
 5 files changed, 232 insertions(+), 1 deletion(-)
 create mode 100644 hw/display/ati_cce.c

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 29a89b3f80..9edde2b0bc 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -997,6 +997,16 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
         s->cce.freerun = data & PM4_MICRO_FREERUN;
         break;
     }
+    case PM4_FIFO_DATA_EVEN:
+        /* fall through */
+    case PM4_FIFO_DATA_ODD:
+        /*
+         * Real hardware does seem to behave differently when the even/odd
+         * sequence is not strictly adhered to but it's difficult to determine
+         * exactly what is happenning. So for now we treat them the same.
+         */
+        ati_cce_receive_data(s, data);
+        break;
     default:
         break;
     }
diff --git a/hw/display/ati_cce.c b/hw/display/ati_cce.c
new file mode 100644
index 0000000000..62a88a54df
--- /dev/null
+++ b/hw/display/ati_cce.c
@@ -0,0 +1,156 @@
+/*
+ * QEMU ATI SVGA emulation
+ * CCE engine functions
+ *
+ * Copyright (c) 2025 Chad Jablonski
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "ati_regs.h"
+#include "ati_int.h"
+#include "trace.h"
+
+static inline uint32_t
+ati_cce_data_packets_remaining(const ATIPM4PacketState *p)
+{
+    switch (p->type) {
+    case ATI_CCE_TYPE0:
+        return p->t0.count - p->dwords_processed;
+    case ATI_CCE_TYPE1:
+        return 2 - p->dwords_processed;
+    case ATI_CCE_TYPE2:
+        return 0;
+    case ATI_CCE_TYPE3:
+        return p->t3.count - p->dwords_processed;
+    default:
+        /* This should never happen, type is 2-bits wide */
+        return 0;
+    }
+}
+
+static void
+ati_cce_parse_packet_header(ATIPM4PacketState *p, uint32_t header)
+{
+    p->dwords_processed = 0;
+    p->type = (header & ATI_CCE_TYPE_MASK) >> ATI_CCE_TYPE_SHIFT;
+    switch (p->type) {
+    case ATI_CCE_TYPE0: {
+        ATIPM4Type0Header t0 = {
+            /* Packet stores base_reg as word offset, convert to byte offset */
+            .base_reg = ((header & ATI_CCE_TYPE0_BASE_REG_MASK) >>
+                        ATI_CCE_TYPE0_BASE_REG_SHIFT) << 2,
+            /* Packet stores count as n-1, convert to actual count */
+            .count = ((header & ATI_CCE_TYPE0_COUNT_MASK) >>
+                     ATI_CCE_TYPE0_COUNT_SHIFT) + 1,
+            .one_reg_wr = header & ATI_CCE_TYPE0_ONE_REG_WR,
+        };
+        p->t0 = t0;
+        trace_ati_cce_packet_type0(t0.base_reg, t0.count, t0.one_reg_wr);
+        break;
+    }
+    case ATI_CCE_TYPE1: {
+        ATIPM4Type1Header t1 = {
+            /* Packet stores reg0 as word offset, convert to byte offset */
+            .reg0 = ((header & ATI_CCE_TYPE1_REG0_MASK) >>
+                    ATI_CCE_TYPE1_REG0_SHIFT) << 2,
+            /* Packet stores reg1 as word offset, convert to byte offset */
+            .reg1 = ((header & ATI_CCE_TYPE1_REG1_MASK) >>
+                    ATI_CCE_TYPE1_REG1_SHIFT) << 2,
+        };
+        p->t1 = t1;
+        trace_ati_cce_packet_type1(t1.reg0, t1.reg1);
+        break;
+    }
+    case ATI_CCE_TYPE2: {
+        /* Type-2 is a no-op, it has no header state */
+        trace_ati_cce_packet_type2();
+        break;
+    }
+    case ATI_CCE_TYPE3: {
+        ATIPM4Type3Header t3 = {
+            .opcode = (header & ATI_CCE_TYPE3_OPCODE_MASK) >>
+                      ATI_CCE_TYPE3_OPCODE_SHIFT,
+            /* Packet stores count as n-1, convert to actual count */
+            .count = ((header & ATI_CCE_TYPE3_COUNT_MASK) >>
+                     ATI_CCE_TYPE3_COUNT_SHIFT) + 1,
+        };
+        p->t3 = t3;
+        trace_ati_cce_packet_type3(t3.opcode, t3.count);
+        break;
+    }
+    default:
+        /* This should never happen, type is 2-bits wide */
+        break;
+    }
+}
+
+static void
+ati_cce_process_type0_data(ATIVGAState *s, uint32_t data)
+{
+    ATIPM4PacketState *p = &s->cce.cur_packet;
+    uint32_t offset = p->t0.one_reg_wr ? 0 :
+                      (p->dwords_processed * sizeof(uint32_t));
+    uint32_t reg = p->t0.base_reg + offset;
+    trace_ati_cce_packet_type0_data(p->dwords_processed, reg, data);
+    ati_reg_write(s, reg, data, sizeof(uint32_t));
+}
+
+static void
+ati_cce_process_type1_data(ATIVGAState *s, uint32_t data)
+{
+    ATIPM4PacketState *p = &s->cce.cur_packet;
+    uint32_t reg = p->dwords_processed == 0 ? p->t1.reg0 : p->t1.reg1;
+    trace_ati_cce_packet_type1_data(p->dwords_processed, reg, data);
+    ati_reg_write(s, reg, data, sizeof(uint32_t));
+}
+
+static void
+ati_cce_process_type3_data(ATIVGAState *s, uint32_t data)
+{
+    ATIPM4PacketState *p = &s->cce.cur_packet;
+    uint32_t opcode = p->t3.opcode;
+    qemu_log_mask(LOG_UNIMP, "Type-3 CCE packets not yet implemented\n");
+    trace_ati_cce_packet_type3_data(p->dwords_processed, opcode, data);
+}
+
+static void
+ati_cce_process_packet_data(ATIVGAState *s, uint32_t data)
+{
+    ATIPM4PacketState *p = &s->cce.cur_packet;
+    switch (p->type) {
+    case ATI_CCE_TYPE0: {
+        ati_cce_process_type0_data(s, data);
+        p->dwords_processed += 1;
+        break;
+    }
+    case ATI_CCE_TYPE1: {
+        ati_cce_process_type1_data(s, data);
+        p->dwords_processed += 1;
+        break;
+    }
+    case ATI_CCE_TYPE2:
+        /* Type-2 packets have no data, we should never end up here */
+        break;
+    case ATI_CCE_TYPE3: {
+        ati_cce_process_type3_data(s, data);
+        p->dwords_processed += 1;
+        break;
+    }
+    default:
+        /* This should never happen, type is 2-bits wide */
+        break;
+    }
+}
+
+void
+ati_cce_receive_data(ATIVGAState *s, uint32_t data)
+{
+    uint32_t remaining = ati_cce_data_packets_remaining(&s->cce.cur_packet);
+    if (remaining == 0) {
+        /* We're ready to start processing a new packet header */
+        ati_cce_parse_packet_header(&s->cce.cur_packet, data);
+        return;
+    }
+    ati_cce_process_packet_data(s, data);
+}
diff --git a/hw/display/ati_cce.h b/hw/display/ati_cce.h
index a6a9aa87c4..b6ad21f47e 100644
--- a/hw/display/ati_cce.h
+++ b/hw/display/ati_cce.h
@@ -13,6 +13,60 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 
+typedef struct ATIVGAState ATIVGAState;
+
+#define ATI_CCE_TYPE_MASK            0xc0000000
+#define ATI_CCE_TYPE_SHIFT           30
+
+#define ATI_CCE_TYPE0                0
+#define ATI_CCE_TYPE0_BASE_REG_MASK  0x00007fff
+#define ATI_CCE_TYPE0_BASE_REG_SHIFT 0
+#define ATI_CCE_TYPE0_ONE_REG_WR     0x00008000
+#define ATI_CCE_TYPE0_COUNT_MASK     0x3fff0000
+#define ATI_CCE_TYPE0_COUNT_SHIFT    16
+
+#define ATI_CCE_TYPE1                1
+#define ATI_CCE_TYPE1_REG0_MASK      0x000007ff
+#define ATI_CCE_TYPE1_REG0_SHIFT     0
+#define ATI_CCE_TYPE1_REG1_MASK      0x003ff800
+#define ATI_CCE_TYPE1_REG1_SHIFT     11
+
+#define ATI_CCE_TYPE2                2
+
+#define ATI_CCE_TYPE3                3
+#define ATI_CCE_TYPE3_OPCODE_MASK    0x0000ff00
+#define ATI_CCE_TYPE3_OPCODE_SHIFT   8
+#define ATI_CCE_TYPE3_COUNT_MASK     0x3fff0000
+#define ATI_CCE_TYPE3_COUNT_SHIFT    16
+
+typedef struct ATIPM4Type0Header {
+    uint32_t base_reg;
+    uint16_t count;
+    bool one_reg_wr;
+} ATIPM4Type0Header;
+
+typedef struct ATIPM4Type1Header {
+    uint32_t reg0;
+    uint32_t reg1;
+} ATIPM4Type1Header;
+
+/* Type-2 headers are a no-op and have no state */
+
+typedef struct ATIPM4Type3Header {
+    uint8_t opcode;
+    uint16_t count;
+} ATIPM4Type3Header;
+
+typedef struct ATIPM4PacketState {
+    uint8_t type;
+    uint16_t dwords_processed;
+    union {
+        ATIPM4Type0Header t0;
+        ATIPM4Type1Header t1;
+        ATIPM4Type3Header t3;
+    };
+} ATIPM4PacketState;
+
 typedef struct ATIPM4MicrocodeState {
     uint8_t addr;
     uint8_t raddr;
@@ -23,10 +77,12 @@ typedef struct ATICCEState {
     ATIPM4MicrocodeState microcode;
     /* MicroCntl */
     bool freerun;
+    ATIPM4PacketState cur_packet;
     /* BufferCntl */
     uint32_t buffer_size_l2qw;
     bool no_update;
     uint8_t buffer_mode;
 } ATICCEState;
 
+void ati_cce_receive_data(ATIVGAState *s, uint32_t data);
 #endif /* ATI_CCE_H */
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 90e6c041bd..136d014746 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -59,7 +59,7 @@ system_ss.add(when: 'CONFIG_XLNX_DISPLAYPORT', if_true: files('xlnx_dp.c'))
 
 system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
 
-system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
+system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c', 'ati_cce.c'), pixman])
 
 system_ss.add(when: [pvg, 'CONFIG_MAC_PVG_PCI'],     if_true: [files('apple-gfx.m', 'apple-gfx-pci.m')])
 system_ss.add(when: [pvg, 'CONFIG_MAC_PVG_MMIO'],    if_true: [files('apple-gfx.m', 'apple-gfx-mmio.m')])
diff --git a/hw/display/trace-events b/hw/display/trace-events
index e323a82cff..d3c7ca1467 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -147,6 +147,15 @@ sii9022_switch_mode(const char *mode) "mode: %s"
 ati_mm_read(unsigned int size, uint64_t addr, const char *name, uint64_t val) "%u 0x%"PRIx64 " %s -> 0x%"PRIx64
 ati_mm_write(unsigned int size, uint64_t addr, const char *name, uint64_t val) "%u 0x%"PRIx64 " %s <- 0x%"PRIx64
 
+# ati_cce.c
+ati_cce_packet_type0(uint32_t base_reg, uint32_t count, bool one_reg_wr) "base_reg=0x%x count=%u one_reg_wr=%u"
+ati_cce_packet_type0_data(uint32_t data_idx, uint32_t reg, uint32_t data) "data_idx=%u reg=0x%x data=0x%x"
+ati_cce_packet_type1(uint32_t reg0, uint32_t reg1) "reg0=0x%x reg1=0x%x"
+ati_cce_packet_type1_data(uint32_t data_idx, uint32_t reg, uint32_t data) "data_idx=%u reg=0x%x data=0x%x"
+ati_cce_packet_type2(void) ""
+ati_cce_packet_type3(uint8_t opcode, uint32_t count) "opcode=0x%x count=%u"
+ati_cce_packet_type3_data(uint32_t data_idx, uint8_t opcode, uint32_t data) "data_idx=%u opcode=0x%x data=%u"
+
 # artist.c
 artist_reg_read(unsigned int size, uint64_t addr, const char *name, uint64_t val) "%u 0x%"PRIx64 "%s -> 0x%08"PRIx64
 artist_reg_write(unsigned int size, uint64_t addr, const char *name, uint64_t val) "%u 0x%"PRIx64 "%s <- 0x%08"PRIx64
-- 
2.51.2


