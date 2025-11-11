Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719E3CD13D2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImrR-000759-F0; Tue, 11 Nov 2025 06:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqn-0005GQ-6V
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:53 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImql-0004RU-4O
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:52 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-298144fb9bcso20462095ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861667; x=1763466467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EiLpyGQ8iPmBHhAq4gzyV2rfadUDO5QoV6sue0EbPas=;
 b=Ts/aQZP+aoeAvpdPWAuxRCb5azeZNvcBN/9Ag26H40O91iNxNRtI3aTqnI7pZwu5c8
 1cPfM95A0q5v4uOfaDgvXeUJkSgg/RQ/NDIPfi/s/eVdXcidX4FpZcXiolTB4tL80z8f
 vByPAyYzJT6ux5tDvauuVrD1Le7qxpjRkBbOtug3wEfNRtDDkIwn8i4bqzDy11N9gCVH
 kcmbbm3epYgR36fXHj+/JfJB/4eVNAroHwZ8pQeE0b60OlazixO7XisUZv5vOKBYCHSs
 1GdxHLWP2Bsjg1eSNzO2QAyuH85tgds3I9iTkCM0BOTz5fzR4yWD55M7Of5Q6NBJer7E
 E2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861667; x=1763466467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EiLpyGQ8iPmBHhAq4gzyV2rfadUDO5QoV6sue0EbPas=;
 b=Gf6OPBtuPjndqyfBg07Nd1cAjlcY9PPwMr/XiA2L7V0YI+0SlL/+qsZiEx0qOIvJ9H
 /ucDemHATvF9h6Ch0ELmcpArb7ppkNuQHsz31ZVdYDGqChgqTESpa59Cg/NyIcl75ryI
 5lIg2UcmAVT65W6/wB/YXKUvvOpDlRMOs4SKzFZc5nThwA11+letJIObglIq/oEnDaR2
 +YIVB7Wy6EGodQku1H0tamelvs4gS4BJie9Zh2Vu48gHFWKvK0yxQB7W/1UVtHd8dpS4
 98a4xCY93JpHLVH1p9nWZoutq1GCOrSyvqDKYRa4FIP3ULNJ8QeYdnLRk6Cf5rz9nHU1
 HfHQ==
X-Gm-Message-State: AOJu0YyIx9OBDvVunv942w/W8gwUp3ZKuX2bh06Ob/98e/TqF6nUbcFF
 Mdz1W2G5kwg4Pum2xN2e/53hMhJCckaHbP9Byc0x7wcAsmTidW7ZTXEC6KTXrAjEQ7houA24Nrc
 JubffFwQ=
X-Gm-Gg: ASbGncvF6h5kipaPagqeeCj8GKjPKhyCfBm6L9Bh80DJJqrrCrFRIT9DW4AfTzzbz8v
 qf3MVrC/XS2fMVSznxI29ApEw1j4l/oAJ1DELmsrM9+CFkAyopQbPd1947dTvhZ0dBpAFhWedRz
 /JnQy2YbR2DVlO85n2dCgRwAhVYMy4mKOkl5nYeOpEP1AZ8zi4RCeeaipGriN0VhNAAlJg4LZfA
 1zcpnrOV/ugl7DQsDHD7t1OYQ0dICSfFS35yFl0il/Fj8hDpwkQCHWwVU5E03eZFfn5VsI8mcC6
 QAOnN82lHqPx/ZxwTnPCszO5vs5lLVjvLt6PoN4QyON6AVjie16Agie4MufQXYYeL3qc9MpbgYQ
 VzCmLdFdXuPu16+24eiE6NRSZeC4GipIGdEvPWLHn4JOSRhm1CvLy6+VoNnKVGRTPqkrdhxFm4K
 8dDUwyiJO7TbawwvUXJ3BvySPGdya/mGxSfr0fVQ==
X-Google-Smtp-Source: AGHT+IG5JHOXzrKL+0JXSIHFHeDam3JihVGouIEB10YaHN7vHqNZ2Ubuz2hxeOs7vvAJFE0Xbe8A/A==
X-Received: by 2002:a17:903:3848:b0:276:76e1:2e84 with SMTP id
 d9443c01a7336-297e561aa62mr152798655ad.3.1762861666209; 
 Tue, 11 Nov 2025 03:47:46 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:47:45 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 06/17] hw/riscv: add e-trace message helpers
Date: Tue, 11 Nov 2025 08:46:45 -0300
Message-ID: <20251111114656.2285048-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Before making the trace encoder writing into the RAM sink we need a way
to encode the messages/packets. The encoding is LSB (least significant
bit) based. The doc "Efficient Trace for RISC-V", Chapter 7, mentions:

"The remainder of this section describes the contents of the payload
portion which should be independent of the infrastructure. In each
table, the fields are listed in transmission order: first field in
the table is transmitted first, and multi-bit fields are transmitted
LSB first."

The "RISC-V Trace Control Interface Specification" docs, Chapter 7,
states when talking about the Trace RAM Sink:

"Trace data is placed in memory in LSB order (first byte of trace
packet/data is placed on LSB)."

This means that the LSB encoding must be used to write into the RAM Sink
memory, which is our goal.

The design we're going for is to have all these encoder helpers, along
with the message formats, in a separated file. The trace encoder will
make use of these helpers to blindly write a byte array with the packet
desired, and then write it as is in the RAM Sink.

We'll start by modeling the synchronisation packet first, adding more
formats as we increment the Trace Encoder capabilities.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/meson.build         |  3 +-
 hw/riscv/rv-trace-messages.c | 94 ++++++++++++++++++++++++++++++++++++
 hw/riscv/rv-trace-messages.h | 25 ++++++++++
 3 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 hw/riscv/rv-trace-messages.c
 create mode 100644 hw/riscv/rv-trace-messages.h

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 2aadbe1e50..7d3576fcdf 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -14,6 +14,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c', 'trace-ram-sink.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c',
+        'trace-ram-sink.c', 'rv-trace-messages.c'))
 
 hw_arch += {'riscv': riscv_ss}
diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
new file mode 100644
index 0000000000..215135dd47
--- /dev/null
+++ b/hw/riscv/rv-trace-messages.c
@@ -0,0 +1,94 @@
+/*
+ * Helpers for RISC-V Trace Messages
+ *
+ * Copyright (C) 2025 Ventana Micro Systems Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "rv-trace-messages.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "trace.h"
+
+typedef struct RVTraceMessageHeader {
+    uint8_t length:5;
+    uint8_t flow:2;
+    uint8_t extend:1;
+} RVTraceMessageHeader;
+#define HEADER_SIZE 1
+
+/*
+ * Format 3 subformat 0 without 'time' and 'context' fields
+ */
+typedef struct RVTraceSyncPayload {
+    uint8_t format:2;
+    uint8_t subformat:2;
+    uint8_t branch:1;
+    uint8_t privilege:3;
+    uint32_t addressLow;
+    uint32_t addressHigh;
+} RVTraceSyncPayload;
+#define SYNC_PAYLOAD_SIZE_64BITS 9
+
+static void rv_etrace_write_bits(uint8_t *bytes, uint32_t bit_pos,
+                                 uint32_t num_bits, uint32_t val)
+{
+    uint32_t pos, byte_index, byte_pos, byte_bits = 0;
+
+    if (!num_bits || 32 < num_bits) {
+        return;
+    }
+
+    for (pos = 0; pos < num_bits; pos += byte_bits) {
+        byte_index = (bit_pos + pos) >> 3;
+        byte_pos = (bit_pos + pos) & 0x7;
+        byte_bits = (8 - byte_pos) < (num_bits - pos) ?
+                    (8 - byte_pos) : (num_bits - pos);
+        bytes[byte_index] &= ~(((1U << byte_bits) - 1) << byte_pos);
+        bytes[byte_index] |= ((val >> pos) & ((1U << byte_bits) - 1)) << byte_pos;
+    }
+}
+
+static void rv_etrace_write_header(uint8_t *buf, RVTraceMessageHeader header)
+{
+    /* flow and extend are always zero, i.e just write length */
+    rv_etrace_write_bits(buf, 0, 5, header.length);
+}
+
+size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
+                                      TracePrivLevel priv_level)
+{
+    RVTraceSyncPayload payload = {.format = 0b11,
+                                  .subformat = 0b00,
+                                  .branch = 1,
+                                  .privilege = priv_level};
+    RVTraceMessageHeader header = {.flow = 0, .extend = 0,
+                                   .length = SYNC_PAYLOAD_SIZE_64BITS};
+    uint8_t bit_pos;
+
+    payload.addressLow = extract64(pc, 0, 32);
+    payload.addressHigh = extract64(pc, 32, 32);
+
+    rv_etrace_write_header(buf, header);
+    bit_pos = 8;
+
+    rv_etrace_write_bits(buf, bit_pos, 2, payload.format);
+    bit_pos += 2;
+    rv_etrace_write_bits(buf, bit_pos, 2, payload.subformat);
+    bit_pos += 2;
+    rv_etrace_write_bits(buf, bit_pos, 1, payload.branch);
+    bit_pos += 1;
+    rv_etrace_write_bits(buf, bit_pos, 3, payload.privilege);
+    bit_pos += 3;
+
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.addressLow);
+    bit_pos += 32;
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.addressHigh);
+
+    return HEADER_SIZE + SYNC_PAYLOAD_SIZE_64BITS;
+}
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
new file mode 100644
index 0000000000..aeafea8849
--- /dev/null
+++ b/hw/riscv/rv-trace-messages.h
@@ -0,0 +1,25 @@
+/*
+ * Helpers for RISC-V Trace Messages
+ *
+ * Copyright (C) 2025 Ventana Micro Systems Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef RISCV_RV_TRACE_MESSAGES_H
+#define RISCV_RV_TRACE_MESSAGES_H
+
+typedef enum {
+    U = 0,
+    S_HS = 1,
+    RESERVED = 2,
+    M = 3,
+    D = 4,
+    VU = 5,
+    VS = 6,
+} TracePrivLevel;
+
+size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
+                                      TracePrivLevel priv_level);
+
+#endif
-- 
2.51.1


