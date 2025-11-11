Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E6CCD13CF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImrW-0007Hk-W8; Tue, 11 Nov 2025 06:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImr8-0006Lf-2y
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:14 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImr6-0004Ux-9E
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:48:13 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-29806bd47b5so14736375ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861691; x=1763466491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bXaEMY5hrHceg93Rc9uvQovZc6dicIgVI/u0fM+HVTE=;
 b=SF+waTqO31Nt3UQCswda7R3S/tglTGg77Aa+tirCjaBDFYy8qKidRGy+fhX6kRQczi
 uJ9RwfL/Hesp86JUiGXAL/ADCz3XUSTpS83/8f1+UB+kAf83q6ZGdAgTCdeQfqZMRTr+
 6vzDn3Cf6aIbWYTJ5jW9yp0BEs48t8563LmHU9I78tmh093ybS3MEi3qycrpfz68V3bj
 BTcwbpAvpOYUrtNscaxjYnbHDOElLRDdXZFZI9bzLB4N46fUnyU3ejM1jGh16J0tDPXP
 uklsKG7s/udYqODU7LMHmmljZwUFArRzBwhjyxTCOv3mWgsB/vkvzLVIr307RB3+cZxN
 nH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861691; x=1763466491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bXaEMY5hrHceg93Rc9uvQovZc6dicIgVI/u0fM+HVTE=;
 b=A81A+btYXefZ9ZW40O7odbz/PYOuHjQRaDOm0I7+imB0ciACBt//HGmSaqw9k5PZ5I
 dBUOfQAgSuQ0uZsnHI1lYz/YZZQfPhfkRi6eARQfg2a1Dx2A2Hw1vzK22lCgzd3T+Gi0
 E8un25BB+bYVx4K5AOpCGIdDCGTuE2k1BQzDbM4Bt/GYgLzo8OFyh/MDVvpn5n9KoqWF
 918OoVK61rb5N9dsLlpGrQ1gvO5DYDfKLaJw7pRxPRHBFhcLOUaHcu4xi3El3UG6LH4x
 oIH6iRF3SIqM9rCsU98Ibd2qUyn65VdrJBkvvJEmSR2q/Sen7bd0D7/YHiQ+ai5dnWyS
 XSDg==
X-Gm-Message-State: AOJu0YyTzzQFBqFdQG1q7RyLi5uZ3oj1+0Ak6pz5mUkrSysF1GvJE19E
 kn7EgPPZ4xIOphzwwIv0e8LlykI1s9WaAel6YPVVVamgGMuxf4+B0hbQGnx5Cqud0OgixNsh2ho
 NJf150cA=
X-Gm-Gg: ASbGncseb3tziYiQh3kCBE1CVYsPr1XKHtluZ9u4nZR8cEcMAv+wPv3Xb/wZgUcQIrp
 OUiuQpL72W9QvLXGZvHg2hZL7u/vJiin1mvKuV9f1tKWT6D/CP9d5+sZ2D8JMVmjnEkeiILNCXL
 SqncGjSGvtrAwlawJ/6h6IIPiKNQ7J77YA9I6Wdjs6H5rqdnEr5r9InfWjR/Sywxfmhg4c/rMW7
 UucEMwa8sz5/5rzjlRUoBSlPDeyt2jpeTHINKc6BBYMU2oAuJ1EOqgeCzGhl0FLEu0jTZtpxiAR
 Xq5xv42ZY5MbR4rYYPTns6cXHTknX6KMNRF2uC3tsaz2vkfwdtOpi1L3DhPKbL3zHShsl898kZr
 bXG+JR79irnDF4U3z23AFg99wCBbSDCOR+Oo4jVW/lIvoVX+CP8PTPvF9mvKiaafS9MknUMb4Lu
 E8eM7mwO3qBYWI+UPt56DVzGhful0vsc7GxZyM4A==
X-Google-Smtp-Source: AGHT+IHITGaxe8inASeDgglUUDU9/81Iz0FO53n5bzol0sqrM0yySW/ASWe/w5q1O9KzXAOTN7XRgw==
X-Received: by 2002:a17:902:e888:b0:295:96bc:868c with SMTP id
 d9443c01a7336-297e5412cc8mr139301365ad.5.1762861690685; 
 Tue, 11 Nov 2025 03:48:10 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:48:10 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 10/17] hw/riscv/rv-trace-messages.c: add encoded trap
 message
Date: Tue, 11 Nov 2025 08:46:49 -0300
Message-ID: <20251111114656.2285048-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
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

The trap message consists of a Format 3 Subformat 1 e-trace message.

According to the Efficient Trace for RISC-V spec, section "Format 3
thaddr, address and privilege fields", the 'thaddr' will be zero if:

- we can't infer the EPC after an uninferable PC discontinuity (like traps).
  This doesn't happen in our current TCG backend - we'll always know the
  trap EPC in riscv_cpu_do_interrupt();

- a second interrupt/exception happens while the handler of the first
  trap hasn't exited. This also doesn't happen in TCG given that we do
  not emulate a multi-insn pipeline model, i.e. we'll only retire one
  insns at a time.

This means that we'll always send trap packets with 'thaddr' set to 1,
thus we're hardcoding it in the message helper.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/rv-trace-messages.c | 94 ++++++++++++++++++++++++++++++++++++
 hw/riscv/rv-trace-messages.h |  5 ++
 2 files changed, 99 insertions(+)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index 215135dd47..3e9466633d 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -35,6 +35,24 @@ typedef struct RVTraceSyncPayload {
 } RVTraceSyncPayload;
 #define SYNC_PAYLOAD_SIZE_64BITS 9
 
+/*
+ * Format 3 subformat 1 without 'time' and 'context' fields
+ */
+typedef struct RVTraceTrapPayload {
+    uint8_t format:2;
+    uint8_t subformat:2;
+    uint8_t branch:1;
+    uint8_t privilege:3;
+    uint8_t ecause:6;
+    uint8_t interrupt:1;
+    uint8_t thaddr:1;
+    uint32_t addressLow;
+    uint32_t addressHigh;
+    uint32_t tvalLow;
+    uint32_t tvalHigh;
+} RVTraceTrapPayload;
+#define TRAP_PAYLOAD_SIZE_64BITS 18
+
 static void rv_etrace_write_bits(uint8_t *bytes, uint32_t bit_pos,
                                  uint32_t num_bits, uint32_t val)
 {
@@ -92,3 +110,79 @@ size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
 
     return HEADER_SIZE + SYNC_PAYLOAD_SIZE_64BITS;
 }
+
+/*
+ * Note: this function assumes thaddr = 1.
+ */
+size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
+                                      TracePrivLevel priv_level,
+                                      uint8_t ecause,
+                                      bool is_interrupt,
+                                      uint64_t tval)
+{
+    RVTraceTrapPayload payload = {.format = 0b11,
+                                  .subformat = 0b01,
+                                  .branch = 1,
+                                  .privilege = priv_level,
+                                  .ecause = ecause};
+    RVTraceMessageHeader header = {.flow = 0, .extend = 0,
+                                   .length = TRAP_PAYLOAD_SIZE_64BITS};
+    uint8_t bit_pos;
+
+    payload.addressLow = extract64(trap_addr, 0, 32);
+    payload.addressHigh = extract64(trap_addr, 32, 32);
+
+    /*
+     * When interrupt = 1 'tval' is ommited. Take 8 bytes
+     * from the final size.
+     */
+    if (is_interrupt) {
+        header.length = TRAP_PAYLOAD_SIZE_64BITS - 8;
+    }
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
+    rv_etrace_write_bits(buf, bit_pos, 6, payload.ecause);
+    bit_pos += 6;
+
+    if (is_interrupt) {
+        rv_etrace_write_bits(buf, bit_pos, 1, 1);
+    } else {
+        rv_etrace_write_bits(buf, bit_pos, 1, 0);
+    }
+    bit_pos += 1;
+
+    /* thaddr is hardcoded to 1 for now */
+    rv_etrace_write_bits(buf, bit_pos, 1, 1);
+    bit_pos += 1;
+
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.addressLow);
+    bit_pos += 32;
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.addressHigh);
+    bit_pos += 32;
+
+    /* Skip trap_addr if is_interrupt  */
+    if (is_interrupt) {
+        goto out;
+    }
+
+    payload.tvalLow = extract64(trap_addr, 0, 32);
+    payload.tvalHigh = extract64(trap_addr, 32, 32);
+
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.tvalLow);
+    bit_pos += 32;
+    rv_etrace_write_bits(buf, bit_pos, 32, payload.tvalHigh);
+
+out:
+    return HEADER_SIZE + header.length;
+}
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
index aeafea8849..f3e38b571f 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -21,5 +21,10 @@ typedef enum {
 
 size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
                                       TracePrivLevel priv_level);
+size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
+                                      TracePrivLevel priv_level,
+                                      uint8_t ecause,
+                                      bool is_interrupt,
+                                      uint64_t tval);
 
 #endif
-- 
2.51.1


