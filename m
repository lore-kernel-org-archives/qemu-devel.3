Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADF9CD8C85
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 19:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVx4T-00065G-2x; Sat, 06 Jun 2026 15:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wVx4R-00064j-NC
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 15:52:39 -0400
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wVx4N-00016B-E5
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 15:52:39 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id B2F781D000C9;
 Sat,  6 Jun 2026 15:52:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sat, 06 Jun 2026 15:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1780775554; x=
 1780861954; bh=+IdjkECJzo6/qC+4f0PG311HJezFiDTLnfR+m17wj+k=; b=R
 R6MUeq1DUqldFpByWfYey4oVdPUyXX9JvkeoAsSSOc+NPVodVWuqYN0ecRE+ocdZ
 hicHCnS0b/W4x9qdgSnYi/9hkn0Qdd7UHQSR6M8aOFuAE4uJpIt1Thj7c5VRyqM0
 LetIx4gps7lC8hLmdlIM8FIyz8LMVWT09/15tbYG+G8XQjO2CrDGH0/TMIfbX5p3
 ODaEtW3+fsx2zXHX70UMuhADC/+a3JirAbpLs1wPxwO6zjYfnp1wJ0rxfgK35ItW
 rYk/oPasxaGO1SQvbt4o1e4AybNhogqzJfxmqj9mJf9THLxgOZWyaNdcNfaKcWbr
 c74QskN2W5nCnSLavXBtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780775554; x=1780861954; bh=+
 IdjkECJzo6/qC+4f0PG311HJezFiDTLnfR+m17wj+k=; b=Se7oFaBmSjST3Ih0M
 QwqV0i5sReRaBBinZ15D0SJDPRa976knkapjaZ65pGxYzMaBXh9O2wBarex8oqWk
 uFghKkIe2LG2uAco/G0aIqKFhkbLT5tmK6kWcTu7efoH7r09ymChbr8+zhuB1Wki
 tJGfByHfs10XozpjAyMWPl3p9cDYDx/XNvq50LI+GuAxXvZPjhCNLSIVaRJOMFoA
 WD4Ph3w/1MyJRMaZbwGCI5/Cwc1CdCQ319T+Sd7zwEi7kKVRjOutZPR2PfPpjiaK
 dPbP2zZqIaI0ONyIWL6pRfRqnYmU0QTKA2aSIl6IcdRpmMi8VLF1KlN53ciiwSRY
 7jsPQ==
X-ME-Sender: <xms:gnokaulTTSiDZy_WSQ-tPKS1Q6boCxjiZDL6eFa3j7-kxeyot0NaDQ>
 <xme:gnokatQH7ryxqtYhJA4i_X57IGa3ixGW002YIgF--K9Xkt4djEjX8CLHWrAP4MEsP
 9GicaYMHXbaE_pbmR34mmheoG-ihd7TEmqwU33b5zIcmIJ9sFIukbI>
X-ME-Received: <xmr:gnokaqDVT5AezYDAkScJ7IIYGaJxDxA4h4RQCn1tuRnhN15W9NZSM8DUtrDE>
X-ME-Proxy-Cause: dmFkZTF5V5TJt4YyOidEvSaeu/MRla4xP+DmdZQhB39MOi6suQo+ewwhopiobLPZpZFZya
 cAlJGIfDtnd9YI9euUev0/BPlhx7gFnO282gf6qihxTXQ9XGsNSFgetoCcqBrBvyjHrANh
 atTdGgjKUldYBX7wk7l0Cl09WJIHvldYLH4ZomEKYEpVZT82+Oh5snshv7XK6+9Sb5cWbw
 e84vQB5olzLLZrdcgzNge+k12PyvF6W544E61zazKBZo950akvs+WrgTOdnqD9gQaa29eu
 Mvbl6jhgYAGUnVDqLD0fWkRRImSA3/gMsTXu4gQwDYtEjGvTqg8SUjhCR0pAYP3BvhiEeP
 1/w+oDwjfue59X+c6Wz8gGj6v0O44BkHBvgEL0BcWm1DDlO7uCSiR6iaw6B/6BrVW3YKmj
 Fw4G8tzBgLtVorOO86WkCxMYHhqwTPjD3yx8JHJbbWHqTw7sF7Wvi1pCcqtuLGSctVemAC
 b6S2eWZkrXBopUudViLsOxoV79c6Lv3MeUz4gZvp06kEFEdZiQMhkldnrepXYq03QZn3cC
 u9N0/dNNjLrK35krKRpaw+XQjnH4TIY3slgWpC2R6+rEOa2apROyTVyb9DvbHK4o/6NmRi
 jo69AomR+NK6wM+UVlO4xzZXllDQCsildwh82gcXFTUmY3zIK0VCFckq0WvQ
X-ME-Proxy: <xmx:gnokasQ4NsSn8PJL21vg39IYRE5_nq511g2z4QDBZGnZJmk3swR7OA>
 <xmx:gnokagq_J_mIeaaQbUCt1e09jbDV3VKtWaUjrpt_0A7CjPaAKEpXJg>
 <xmx:gnokamzUWJ-h9i1K7B-DcA0wtaXtNHsIO7_V8vIL1ygoVDl0nRfNUg>
 <xmx:gnokatKDDpFYK-6Pqc-cSdEFBX1NncIjAAtmKumlxqoGQb5QSEfkog>
 <xmx:gnokau_imevkjGZamXfCYbWAWSCvSF-NoZdpEosMwc_hIWlt3q3dg0t4>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jun 2026 15:52:34 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 2a7b70fb;
 Sat, 6 Jun 2026 19:52:30 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 7/7] ati-vga: Process Type-0/1/2 CCE packets via PIO
Date: Sat,  6 Jun 2026 15:52:16 -0400
Message-ID: <20260606195216.2524314-8-chad@jablonski.xyz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606195216.2524314-1-chad@jablonski.xyz>
References: <20260606195216.2524314-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.151; envelope-from=chad@jablonski.xyz;
 helo=fout-b8-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
 hw/display/ati_cce.c    | 154 ++++++++++++++++++++++++++++++++++++++++
 hw/display/ati_int.h    |  54 ++++++++++++++
 hw/display/meson.build  |   3 +-
 hw/display/trace-events |   9 +++
 5 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 hw/display/ati_cce.c

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 582c646a3d..25de3ff544 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1170,6 +1170,16 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
         s->cce.microcode.addr += 1;
         break;
     }
+    /* R100: CP_CSQ_APER_PRIMARY */
+    case PM4_FIFO_DATA_EVEN:
+    case PM4_FIFO_DATA_ODD:
+        /*
+         * R128 does seem to behave differently when the even/odd
+         * sequence is not strictly adhered to but it's difficult to determine
+         * exactly what is happening. So for now we treat them the same.
+         */
+        ati_cce_receive_data(s, data);
+        break;
     default:
         break;
     }
diff --git a/hw/display/ati_cce.c b/hw/display/ati_cce.c
new file mode 100644
index 0000000000..bf87e4017c
--- /dev/null
+++ b/hw/display/ati_cce.c
@@ -0,0 +1,154 @@
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
+#include "qemu/log.h"
+
+static inline uint32_t ati_cce_data_packets_remaining(const ATIPacketState *p)
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
+        g_assert_not_reached();
+        return 0;
+    }
+}
+
+static void ati_cce_parse_packet_header(ATIPacketState *p, uint32_t header)
+{
+    p->dwords_processed = 0;
+    p->type = (header & ATI_CCE_TYPE_MASK) >> ATI_CCE_TYPE_SHIFT;
+    switch (p->type) {
+    case ATI_CCE_TYPE0: {
+        ATIType0Header t0 = {
+            /* Packet stores base_reg as word offset, convert to byte offset */
+            .base_reg = ((header & ATI_CCE_TYPE0_BASE_REG_MASK) >>
+                        ATI_CCE_TYPE0_BASE_REG_SHIFT) << 2,
+            /* Packet stores count as n-1, convert to actual count */
+            .count = ((header & ATI_CCE_TYPE0_COUNT_MASK) >>
+                     ATI_CCE_TYPE0_COUNT_SHIFT) + 1,
+            .one_reg_wr = !!(header & ATI_CCE_TYPE0_ONE_REG_WR),
+        };
+        p->t0 = t0;
+        trace_ati_cce_packet_type0(t0.base_reg, t0.count, t0.one_reg_wr);
+        break;
+    }
+    case ATI_CCE_TYPE1: {
+        ATIType1Header t1 = {
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
+        ATIType3Header t3 = {
+            .opcode = (header & ATI_CCE_TYPE3_OPCODE_MASK) >>
+                      ATI_CCE_TYPE3_OPCODE_SHIFT,
+            /* Packet stores count as n-1, convert to actual count */
+            .count = ((header & ATI_CCE_TYPE3_COUNT_MASK) >>
+                     ATI_CCE_TYPE3_COUNT_SHIFT) + 1,
+        };
+        p->t3 = t3;
+        qemu_log_mask(LOG_UNIMP, "Type-3 CCE packets not yet implemented\n");
+        trace_ati_cce_packet_type3(t3.opcode, t3.count);
+        break;
+    }
+    default:
+        /* This should never happen, type is 2-bits wide */
+        g_assert_not_reached();
+        break;
+    }
+}
+
+static void ati_cce_process_type0_data(ATIVGAState *s, uint32_t data)
+{
+    ATIPacketState *p = &s->cce.cur_packet;
+    uint32_t offset = p->t0.one_reg_wr ? 0 :
+                      (p->dwords_processed * sizeof(uint32_t));
+    uint32_t reg = p->t0.base_reg + offset;
+    trace_ati_cce_packet_type0_data(p->dwords_processed, reg, data);
+    ati_reg_write(s, reg, data, sizeof(uint32_t));
+}
+
+static void ati_cce_process_type1_data(ATIVGAState *s, uint32_t data)
+{
+    ATIPacketState *p = &s->cce.cur_packet;
+    uint32_t reg = p->dwords_processed == 0 ? p->t1.reg0 : p->t1.reg1;
+    trace_ati_cce_packet_type1_data(p->dwords_processed, reg, data);
+    ati_reg_write(s, reg, data, sizeof(uint32_t));
+}
+
+static void ati_cce_process_type3_data(ATIVGAState *s, uint32_t data)
+{
+    ATIPacketState *p = &s->cce.cur_packet;
+    uint32_t opcode = p->t3.opcode;
+    trace_ati_cce_packet_type3_data(p->dwords_processed, opcode, data);
+}
+
+static void ati_cce_process_packet_data(ATIVGAState *s, uint32_t data)
+{
+    ATIPacketState *p = &s->cce.cur_packet;
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
+        g_assert_not_reached();
+        break;
+    case ATI_CCE_TYPE3: {
+        ati_cce_process_type3_data(s, data);
+        p->dwords_processed += 1;
+        break;
+    }
+    default:
+        /* This should never happen, type is 2-bits wide */
+        g_assert_not_reached();
+        break;
+    }
+}
+
+void ati_cce_receive_data(ATIVGAState *s, uint32_t data)
+{
+    uint32_t remaining = ati_cce_data_packets_remaining(&s->cce.cur_packet);
+    if (remaining == 0) {
+        /* We're ready to start processing a new packet header */
+        ati_cce_parse_packet_header(&s->cce.cur_packet, data);
+        return;
+    }
+    ati_cce_process_packet_data(s, data);
+}
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 9259373733..8eea0a7c6f 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -38,6 +38,30 @@
 #define TYPE_ATI_VGA "ati-vga"
 OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
 
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
 typedef struct ATIVGARegs {
     uint32_t mm_index;
     uint32_t bios_scratch[8];
@@ -105,6 +129,34 @@ typedef struct ATIHostDataState {
     uint32_t acc[4];
 } ATIHostDataState;
 
+typedef struct ATIType0Header {
+    uint32_t base_reg;
+    uint16_t count;
+    bool one_reg_wr;
+} ATIType0Header;
+
+typedef struct ATIType1Header {
+    uint32_t reg0;
+    uint32_t reg1;
+} ATIType1Header;
+
+/* Type-2 headers are a no-op and have no state */
+
+typedef struct ATIType3Header {
+    uint8_t opcode;
+    uint16_t count;
+} ATIType3Header;
+
+typedef struct ATIPacketState {
+    uint8_t type;
+    uint16_t dwords_processed;
+    union {
+        ATIType0Header t0;
+        ATIType1Header t1;
+        ATIType3Header t3;
+    };
+} ATIPacketState;
+
 typedef struct ATIMicrocodeState {
     uint8_t addr;
     uint8_t raddr;
@@ -115,6 +167,7 @@ typedef struct ATICCEState {
     ATIMicrocodeState microcode;
     /* MicroCntl */
     bool freerun;
+    ATIPacketState cur_packet;
     /* BufferCntl */
     uint32_t buffer_size_l2qw;
     bool no_update;
@@ -152,4 +205,5 @@ void ati_2d_blt(ATIVGAState *s);
 bool ati_host_data_flush(ATIVGAState *s);
 void ati_host_data_finish(ATIVGAState *s);
 
+void ati_cce_receive_data(ATIVGAState *s, uint32_t data);
 #endif /* ATI_INT_H */
diff --git a/hw/display/meson.build b/hw/display/meson.build
index ffecedbf70..5a44d4c12f 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -60,7 +60,8 @@ system_ss.add(when: 'CONFIG_XLNX_DISPLAYPORT', if_true: files('xlnx_dp.c'))
 
 system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
 
-system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
+system_ss.add(when: 'CONFIG_ATI_VGA',
+              if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c', 'ati_cce.c'), pixman])
 
 system_ss.add(when: [pvg, 'CONFIG_MAC_PVG_PCI'],     if_true: [files('apple-gfx.m', 'apple-gfx-pci.m')])
 system_ss.add(when: [pvg, 'CONFIG_MAC_PVG_MMIO'],    if_true: [files('apple-gfx.m', 'apple-gfx-mmio.m')])
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 4bfc457fba..8e9c91a99f 100644
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
+ati_cce_packet_type3_data(uint32_t data_idx, uint8_t opcode, uint32_t data) "data_idx=%u opcode=0x%x data=0x%x"
+
 # artist.c
 artist_reg_read(unsigned int size, uint64_t addr, const char *name, uint64_t val) "%u 0x%"PRIx64 "%s -> 0x%08"PRIx64
 artist_reg_write(unsigned int size, uint64_t addr, const char *name, uint64_t val) "%u 0x%"PRIx64 "%s <- 0x%08"PRIx64
-- 
2.53.0


