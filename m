Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAA3CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 11:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4HQA-0005hn-Ee; Thu, 02 Oct 2025 07:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQ4-0005fh-1p
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:22 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HPk-0005qj-FL
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:19 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-71d71bcab6fso10025727b3.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 04:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759404237; x=1760009037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rj9K7Fd4/ICuKm9d/eSoRj/Kqexm+sKHBoerBI9UwwQ=;
 b=bZDOFPaPjtRaATuPuNhBKhp6OK68nIhQHGAxrDhw4M7BjOsjOq4SQ/UXmtCzizypJY
 XK3OQalHhwf3hN3Z+ms1o/dEPF4+4TIKrW4S9AG9DANsIx6JxWPlvLlYXljek8eQJvzo
 YEaDbk601Z3puovB1ZD3UiCetNmOIqwoaOEZEc3KBd/R3+Rj8/nFP4QdAdOWmxGJAxA+
 mZ9LqJGu7Mr7xfw8NArzOhbnr6p8aNyh12hBsTXaDotJk86SUCKhAeGwftmcefu10FPJ
 PBlFxDLzsNiT7xrKJfOdolHSMXIIua9VB4Fk83DlMLTiMx86H/1xBOUgxr0Mos+AgICi
 0EAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759404237; x=1760009037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rj9K7Fd4/ICuKm9d/eSoRj/Kqexm+sKHBoerBI9UwwQ=;
 b=E79BNXf2XaaKn6u1N5ZG7mV+x+KwQsik8TxOqMqaV4Y/i9r26R5jYWkSYUGpsK52qj
 doYu3OLH80IFVxFsa1tDtS2hd5XRDc2TmTKQKI2nRnHakHPdKOhpLeMXLAEU5N2RA4bo
 WrPwWKhSkn9lWhoRFsJfUObgxXJAFtDhoXKNcFPKsOyuo4T7Tdh6Qhk8WLRjWI2k8ejv
 upaQ8xiCLny7tOLVuy5lN3ZtzSjtb91TO2w46V0aaMQcExc+qmBc3YW1F3hENjrXvXbK
 5pp9NIu99TgItyXwPdEGVBTNt8Knuw0oo3vVlthBF5l7zedp0eqq9+3Dm6RqyZ79T6nB
 YgMQ==
X-Gm-Message-State: AOJu0YyVlJAxwqyBJfJlhGn9sX9mnZFmFtU/vTbRPQ3aEQKnqMqQoYm+
 T9WWy3kdsCm/kKk9hgb7GkzkCWCVWgn6CbvmhL41SCM4O40vnIJPKSc8x81b3bsd7qGcPP6ucME
 GpDuNHBU=
X-Gm-Gg: ASbGncvqIcEXYBDNVDtHMTX/q8TAyNOVNr0kcJ8B8xVe6dhrj5+H+scir/hWqW8/137
 Hdlq2nobMFJIW7BTJj5fWrVl8Gi48FcPfHt4n+l6VSuKhbk/Hv9+a3FmKcIjeNgjfQzHahFonqT
 gv1yw7dt2zMkmMmsFtSfNx4Y/kxqBN2M1bJnVkzwq1GgGB8lQFmqAWy9fC9pfK3V0+YrXWDLACx
 lenbzP8WGa3aqogXF+2YHrJi9NuR7e/AbPN2EwjPyRl2j6PeyjWZENIE5N83hzC7gHIc//y+TWL
 wPx+PzCVABVqQRtjVH1QUPAzgMqq4aw579hmB/DVsO3nFovrnalapu9/xkTQNEh4OYlSNCHaCHS
 YnQC2ZFtOdWqjWSxlIWy604f/j6HUhkxUaP28mCl0q5iJpIhKc6YKwrCdp7ujBcbwfOtn4BVG5T
 g=
X-Google-Smtp-Source: AGHT+IEzQKpVBJazzuTU2OIx44Qbip5MJoLuPqWKVgU2koX81saWvfQT6D3Au7a4g8vzEY/0ZoZnvQ==
X-Received: by 2002:a05:690c:6c91:b0:76b:50dc:998a with SMTP id
 00721157ae682-77f6f11539fmr97971637b3.19.1759404237083; 
 Thu, 02 Oct 2025 04:23:57 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:b174:a9af:8146:7deb:fbf3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-77f81c068f6sm7331627b3.5.2025.10.02.04.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 04:23:56 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 06/17] hw/riscv: add e-trace message helpers
Date: Thu,  2 Oct 2025 08:23:24 -0300
Message-ID: <20251002112335.2374517-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
References: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
2.51.0


