Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E5FC4451B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 16:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlUBD-0007l2-R1; Sun, 19 Jul 2026 12:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUBA-0007io-GV
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:48 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUB8-0002PO-BX
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:48 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 943641D0008A;
 Sun, 19 Jul 2026 12:15:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sun, 19 Jul 2026 12:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1784477745; x=
 1784564145; bh=XIEbaKbA6qCI+vUiKXGbW6ddbkkTKmWPHJ44Mdgl4hM=; b=u
 vDUn8CbeokcTgGtr3sJOXfOD98Y6jA4k48msLsRuxadkGZYqtdUytQIIFT8hCbyE
 QSWREeMg+Xqz3izRuaoKVDy5Ip/1IF+IcNIs44ZAz8Ui1bKBE52OFKBo3iFlwe1w
 EjuytJuxoLEG59NxhyJRHAWncb3j1bZzMZ9aEyryfj8Nm5A4nhyfrgqhRhJK5Aqh
 u8hPrVDnQ4ykEIyMe/024t3rdMAYVZzyfYkGG6pSomQY4JIolB1MQi5uO7E5+l8G
 DMXh0IZn8XJFZodN1aAdrGm1gK+X3CL00SBG5ft8jfQ5aS8MMHmFOAowDd3bVWqr
 rIeRHyfqyvWn4pqMny9AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784477745; x=1784564145; bh=X
 IEbaKbA6qCI+vUiKXGbW6ddbkkTKmWPHJ44Mdgl4hM=; b=a1jNkmkmTAaCKXmUz
 iL2KprdQ0wBHk6UQS2jjzAIV9ZsAENQNEWMCSx1HwU2hsCay30Flqtrm+jY5cIlP
 2A4Bgr848LPDzfn59WMYAtzhBzLUr6ez14uBzDCRh9DOMhdI6RvKH4pHeTMZ4528
 d0a3jAuTTdhnIsdSriNGwfrYmSQ6XU8fQ2YhuL5XwxB/v5HwfVvolzQVI8D9FG6n
 oooVa7WNlJXxnml4iJ7dxeoWkG3kt7XuRxQwBOtyA1yzuI5sUuCTY5qFO1LNMoKZ
 dBVbtDi8oP/CqbsbPIAvuamY51h4yNxx0Vk0XOJR8suLegAg7ZhfPdmZ/cQuNw+1
 UlUWg==
X-ME-Sender: <xms:MfhcaqOneWDN6Gb1yFoSgJqbbojoFSZGNEr1VltRP9C0NPW019Z0EA>
 <xme:MfhcasPaKnmqBStwwjFvc76vJAtxBDk2ZepMJfgQYsnHwcCtr_jRs3D-kX4xMxK72
 T5hptMJIkCusg7yMvyW4BhZcrX9SmEi2CSW6YbsCOtZH2DCD5pKuIOs>
X-ME-Received: <xmr:MfhcaqvaWMaubEY-ybzBNby0zSmCeJSF7Y8QBnv0P2qYjq5Dco7UEzG6zEs>
X-ME-Proxy-Cause: dmFkZTFX22WwMbS2sW99eCB50G1QKT6MSqCpx6iK5itrq8JxZaP0521f6QSaZn8xZ08MPO
 fOwSNa6WDSeLTJNQVc/fxMSGvDLkf+yg/0G9Q09ZIOYGIXIBd2hVswgLVRGFoWlNQkKsDF
 GdNkKsfijsKMESGF+IJc7XNHY6Tof4qnJ8h5MKF7zpjgYI3Er1oT6Sc3p82wEBVA4tVY6K
 sm0munSEzPQOSr/py3N0SGFxIhaHx4yY0PMKs1GFt63biT3SGPXDCwnyEFOs/p40onWKAs
 7IByVaX4T1Xvhqors54F3a+bmhyr13Lneen+jWeanFhb1s0umv08sceX1eK90gcHhjDIfe
 FEyRmoosCfObZC303QICRwqNW0LYjTK7vWfEfuH5qRTjEblV5YstMrxrFu1cmOBzJb5LC2
 9pFCn3y7XqzRbB7HdZt1vLIZJ+VG1I8xfkJgWXDyKCC21fPKUCpXaBc0Aoy3Q0gsQj4BkM
 7AOfprQQxR0+rx96We3pJsdIIaAxPzAQjeP26larrmN/vIy2IxmJuXAC50U2WofXZguKQ8
 hQgXpBnAiWff1wUDfbsAfixFPbduHjADtk2u5Ldbkpf6VmDR8LUZUFlFLGEKU4WDzPQl7T
 rrS2/skI+AG1BfVnzbyXwOLE/ZzuxGqrlfSfk9SeJXIKe9QHozXmm/B13CFQ
X-ME-Proxy: <xmx:MfhcamU4UJL3Ce53B61lTJFYRCodMK4Jw_SfJLIEECiLdFqkStcW3A>
 <xmx:MfhcaitCgPwn9-ifNPwsDlv6DfRGISwRrFkEOGzXE4KxTNRNh281iw>
 <xmx:MfhcaiXYhXUAQSmZ-3m12UQA7xQX7IUPcAxsTRPN4GzMPqf2JxvEig>
 <xmx:MfhcalkGeQXlCebgyQ0uqegUwkkLTUvaKhOsr6lFEnNf4-Dk_U7wNQ>
 <xmx:MfhcaiA_w86-SWMKO2aQGaWMjwEPFIkjBD6oA07hcIbUiNSDP4Jqa3jE>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 12:15:44 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 387629cd;
 Sun, 19 Jul 2026 16:15:40 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH 6/9] ati-vga: Process Type-0/1/2 CP packets
Date: Sun, 19 Jul 2026 12:15:33 -0400
Message-ID: <20260719161536.774061-7-chad@jablonski.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260719161536.774061-1-chad@jablonski.xyz>
References: <20260719161536.774061-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.146; envelope-from=chad@jablonski.xyz;
 helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

This implements packet processing for r100.

Type-0 and Type-1 packets write to registers. Type-2 packets are NOPs.
Type-3 packet headers are parsed but only logged as of now.

Hardware testing and poking at the microcode suggests that Type-0/1/2
packets may be implemented in hardware and not the microcode. Type-3,
however, depends on the microcode.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c        |   3 +-
 hw/display/ati_int.h    |  55 +++++++++++++++
 hw/display/ati_pkt.c    | 151 ++++++++++++++++++++++++++++++++++++++++
 hw/display/meson.build  |   3 +-
 hw/display/trace-events |   9 +++
 5 files changed, 219 insertions(+), 2 deletions(-)
 create mode 100644 hw/display/ati_pkt.c

diff --git a/hw/display/ati.c b/hw/display/ati.c
index f19a0613d7..ad32965866 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -626,7 +626,7 @@ static inline void ati_reg_write_offs(uint32_t *reg, int offs,
     }
 }
 
-static void ati_mm_write(void *opaque, hwaddr addr,
+void ati_mm_write(void *opaque, hwaddr addr,
                            uint64_t data, unsigned int size)
 {
     ATIVGAState *s = opaque;
@@ -1251,6 +1251,7 @@ static void ati_vga_reset(DeviceState *dev)
     s->host_data.next = 0;
     s->host_data.row = 0;
     s->host_data.col = 0;
+    memset(&s->cur_packet, 0, sizeof(s->cur_packet));
 }
 
 static void ati_vga_exit(PCIDevice *dev)
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index bb08e0c23d..bbc360b636 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -38,6 +38,30 @@
 #define TYPE_ATI_VGA "ati-vga"
 OBJECT_DECLARE_SIMPLE_TYPE(ATIVGAState, ATI_VGA)
 
+#define ATI_PKT_TYPE_MASK            0xc0000000
+#define ATI_PKT_TYPE_SHIFT           30
+
+#define ATI_PKT_TYPE0                0
+#define ATI_PKT_TYPE0_BASE_REG_MASK  0x00007fff
+#define ATI_PKT_TYPE0_BASE_REG_SHIFT 0
+#define ATI_PKT_TYPE0_ONE_REG_WR     0x00008000
+#define ATI_PKT_TYPE0_COUNT_MASK     0x3fff0000
+#define ATI_PKT_TYPE0_COUNT_SHIFT    16
+
+#define ATI_PKT_TYPE1                1
+#define ATI_PKT_TYPE1_REG0_MASK      0x000007ff
+#define ATI_PKT_TYPE1_REG0_SHIFT     0
+#define ATI_PKT_TYPE1_REG1_MASK      0x003ff800
+#define ATI_PKT_TYPE1_REG1_SHIFT     11
+
+#define ATI_PKT_TYPE2                2
+
+#define ATI_PKT_TYPE3                3
+#define ATI_PKT_TYPE3_OPCODE_MASK    0x0000ff00
+#define ATI_PKT_TYPE3_OPCODE_SHIFT   8
+#define ATI_PKT_TYPE3_COUNT_MASK     0x3fff0000
+#define ATI_PKT_TYPE3_COUNT_SHIFT    16
+
 typedef struct ATIVGARegs {
     uint32_t mm_index;
     uint32_t bios_scratch[8];
@@ -110,6 +134,34 @@ typedef struct ATIHostDataState {
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
+typedef struct ATIPktState {
+    uint8_t type;
+    uint16_t dwords_processed;
+    union {
+        ATIType0Header t0;
+        ATIType1Header t1;
+        ATIType3Header t3;
+    };
+} ATIPktState;
+
 struct ATIVGAState {
     PCIDevice dev;
     VGACommonState vga;
@@ -130,6 +182,7 @@ struct ATIVGAState {
     MemoryRegion mm;
     ATIVGARegs regs;
     ATIHostDataState host_data;
+    ATIPktState cur_packet;
 };
 
 typedef struct {
@@ -139,9 +192,11 @@ typedef struct {
 
 const char *ati_reg_name(int num);
 
+void ati_mm_write(void *opaque, hwaddr addr, uint64_t data, unsigned int size);
 ATIMemRoute ati_mc_route(ATIVGAState *s, uint32_t gpu_addr);
 void ati_2d_blt(ATIVGAState *s);
 bool ati_host_data_flush(ATIVGAState *s);
 void ati_host_data_finish(ATIVGAState *s);
+void ati_pkt_receive_data(ATIVGAState *s, ATIPktState *p, uint32_t data);
 
 #endif /* ATI_INT_H */
diff --git a/hw/display/ati_pkt.c b/hw/display/ati_pkt.c
new file mode 100644
index 0000000000..584ab667f0
--- /dev/null
+++ b/hw/display/ati_pkt.c
@@ -0,0 +1,151 @@
+/*
+ * QEMU ATI SVGA emulation
+ * Packet processing functions
+ *
+ * Copyright (c) 2026 Chad Jablonski
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "ati_regs.h"
+#include "ati_int.h"
+#include "trace.h"
+#include "qemu/log.h"
+
+static inline uint32_t ati_pkt_dwords_remaining(const ATIPktState *p)
+{
+    switch (p->type) {
+    case ATI_PKT_TYPE0:
+        return p->t0.count - p->dwords_processed;
+    case ATI_PKT_TYPE1:
+        return 2 - p->dwords_processed;
+    case ATI_PKT_TYPE2:
+        return 0;
+    case ATI_PKT_TYPE3:
+        return p->t3.count - p->dwords_processed;
+    default:
+        /* This should never happen, type is 2-bits wide */
+        g_assert_not_reached();
+        return 0;
+    }
+}
+
+static void ati_pkt_parse_header(ATIPktState *p, uint32_t header)
+{
+    p->dwords_processed = 0;
+    p->type = (header & ATI_PKT_TYPE_MASK) >> ATI_PKT_TYPE_SHIFT;
+    switch (p->type) {
+    case ATI_PKT_TYPE0: {
+        ATIType0Header t0 = {
+            /* Packet stores base_reg as word offset, convert to byte offset */
+            .base_reg = ((header & ATI_PKT_TYPE0_BASE_REG_MASK) >>
+                        ATI_PKT_TYPE0_BASE_REG_SHIFT) << 2,
+            /* Packet stores count as n-1, convert to actual count */
+            .count = ((header & ATI_PKT_TYPE0_COUNT_MASK) >>
+                     ATI_PKT_TYPE0_COUNT_SHIFT) + 1,
+            .one_reg_wr = !!(header & ATI_PKT_TYPE0_ONE_REG_WR),
+        };
+        p->t0 = t0;
+        trace_ati_pkt_type0(t0.base_reg, ati_reg_name(t0.base_reg),
+                            t0.count, t0.one_reg_wr);
+        break;
+    }
+    case ATI_PKT_TYPE1: {
+        ATIType1Header t1 = {
+            /* Packet stores reg0 as word offset, convert to byte offset */
+            .reg0 = ((header & ATI_PKT_TYPE1_REG0_MASK) >>
+                    ATI_PKT_TYPE1_REG0_SHIFT) << 2,
+            /* Packet stores reg1 as word offset, convert to byte offset */
+            .reg1 = ((header & ATI_PKT_TYPE1_REG1_MASK) >>
+                    ATI_PKT_TYPE1_REG1_SHIFT) << 2,
+        };
+        p->t1 = t1;
+        trace_ati_pkt_type1(t1.reg0, t1.reg1);
+        break;
+    }
+    case ATI_PKT_TYPE2: {
+        /* Type-2 is a no-op, it has no header state */
+        trace_ati_pkt_type2();
+        break;
+    }
+    case ATI_PKT_TYPE3: {
+        ATIType3Header t3 = {
+            .opcode = (header & ATI_PKT_TYPE3_OPCODE_MASK) >>
+                      ATI_PKT_TYPE3_OPCODE_SHIFT,
+            /* Packet stores count as n-1, convert to actual count */
+            .count = ((header & ATI_PKT_TYPE3_COUNT_MASK) >>
+                     ATI_PKT_TYPE3_COUNT_SHIFT) + 1,
+        };
+        p->t3 = t3;
+        qemu_log_mask(LOG_UNIMP, "Type-3 CCE packets not yet implemented\n");
+        trace_ati_pkt_type3(t3.opcode, t3.count);
+        break;
+    }
+    default:
+        /* This should never happen, type is 2-bits wide */
+        g_assert_not_reached();
+        break;
+    }
+}
+
+static void ati_pkt_type0_data(ATIVGAState *s, ATIPktState *p, uint32_t data)
+{
+    uint32_t offset = p->t0.one_reg_wr ? 0 :
+                      (p->dwords_processed * sizeof(uint32_t));
+    uint32_t reg = p->t0.base_reg + offset;
+    trace_ati_pkt_type0_data(p->dwords_processed, reg, ati_reg_name(reg), data);
+    ati_mm_write(s, reg, data, sizeof(uint32_t));
+}
+
+static void ati_pkt_type1_data(ATIVGAState *s, ATIPktState *p, uint32_t data)
+{
+    uint32_t reg = p->dwords_processed == 0 ? p->t1.reg0 : p->t1.reg1;
+    trace_ati_pkt_type1_data(p->dwords_processed, reg, data);
+    ati_mm_write(s, reg, data, sizeof(uint32_t));
+}
+
+static void ati_pkt_type3_data(ATIVGAState *s, ATIPktState *p, uint32_t data)
+{
+    uint32_t opcode = p->t3.opcode;
+    trace_ati_pkt_type3_data(p->dwords_processed, opcode, data);
+}
+
+static void ati_pkt_data(ATIVGAState *s, ATIPktState *p, uint32_t data)
+{
+    switch (p->type) {
+    case ATI_PKT_TYPE0: {
+        ati_pkt_type0_data(s, p, data);
+        p->dwords_processed += 1;
+        break;
+    }
+    case ATI_PKT_TYPE1: {
+        ati_pkt_type1_data(s, p, data);
+        p->dwords_processed += 1;
+        break;
+    }
+    case ATI_PKT_TYPE2:
+        /* Type-2 packets have no data, we should never end up here */
+        g_assert_not_reached();
+        break;
+    case ATI_PKT_TYPE3: {
+        ati_pkt_type3_data(s, p, data);
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
+void ati_pkt_receive_data(ATIVGAState *s, ATIPktState *p, uint32_t data)
+{
+    uint32_t remaining = ati_pkt_dwords_remaining(p);
+    if (remaining == 0) {
+        /* We're ready to start processing a new packet header */
+        ati_pkt_parse_header(p, data);
+        return;
+    }
+    ati_pkt_data(s, p, data);
+}
diff --git a/hw/display/meson.build b/hw/display/meson.build
index ffecedbf70..0fd2bb79c6 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -60,7 +60,8 @@ system_ss.add(when: 'CONFIG_XLNX_DISPLAYPORT', if_true: files('xlnx_dp.c'))
 
 system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
 
-system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
+system_ss.add(when: 'CONFIG_ATI_VGA',
+              if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c', 'ati_pkt.c'), pixman])
 
 system_ss.add(when: [pvg, 'CONFIG_MAC_PVG_PCI'],     if_true: [files('apple-gfx.m', 'apple-gfx-pci.m')])
 system_ss.add(when: [pvg, 'CONFIG_MAC_PVG_MMIO'],    if_true: [files('apple-gfx.m', 'apple-gfx-mmio.m')])
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 4bfc457fba..52bd91313b 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -147,6 +147,15 @@ sii9022_switch_mode(const char *mode) "mode: %s"
 ati_mm_read(unsigned int size, uint64_t addr, const char *name, uint64_t val) "%u 0x%"PRIx64 " %s -> 0x%"PRIx64
 ati_mm_write(unsigned int size, uint64_t addr, const char *name, uint64_t val) "%u 0x%"PRIx64 " %s <- 0x%"PRIx64
 
+# ati_pkt.c
+ati_pkt_type0(uint32_t base_reg, const char *name, uint32_t count, bool one_reg_wr) "base_reg=0x%x name=%s count=%u one_reg_wr=%d"
+ati_pkt_type0_data(uint32_t data_idx, uint32_t reg, const char *name, uint32_t data) "data_idx=%u reg=0x%x name=%s data=0x%x"
+ati_pkt_type1(uint32_t reg0, uint32_t reg1) "reg0=0x%x reg1=0x%x"
+ati_pkt_type1_data(uint32_t data_idx, uint32_t reg, uint32_t data) "data_idx=%u reg=0x%x data=0x%x"
+ati_pkt_type2(void) ""
+ati_pkt_type3(uint8_t opcode, uint32_t count) "opcode=0x%x count=%u"
+ati_pkt_type3_data(uint32_t data_idx, uint8_t opcode, uint32_t data) "data_idx=%u opcode=0x%x data=0x%x"
+
 # artist.c
 artist_reg_read(unsigned int size, uint64_t addr, const char *name, uint64_t val) "%u 0x%"PRIx64 "%s -> 0x%08"PRIx64
 artist_reg_write(unsigned int size, uint64_t addr, const char *name, uint64_t val) "%u 0x%"PRIx64 "%s <- 0x%08"PRIx64
-- 
2.54.0


