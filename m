Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6519FEB1043
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzubO-0007OU-Io; Tue, 10 Mar 2026 06:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vzubM-0007N0-Hk
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vzubJ-0005rl-Ar
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48540355459so14048875e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1773139567; x=1773744367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EheWkw2OWNqmR+PTvFkXIAihDadgyU9zVwk6/vLuKwg=;
 b=CwOwJdRC5d3E086Y1BAuvpPekat2yelWOxNZGJujgSgvUBP3467xl4u548/qZy8Xot
 LTIrq3U9aDCI+rR1KRT7pox3Z9HrpK3tPNXbZFsFp18aBmjSQZbDZRB86Nc/adWftd6R
 EqoB6Y1AsV3zOl8CiPAIb4yV6Hp9wLQFLt0sVb2KnYwbiMd6Pfj5KJmYkoelBz40lYmu
 OCL92omoEw2OrZxQbfl6pbDhNfV8CYQm2/mn79srYFBfbYOkJJNTdBOCUD53Hr0nSxBD
 9ntWMNg+LnsEyOHpYA/FSK29yiW3m+E81XFchacgZ+th4OtlpPeYfuJ02uRiyozWP2j6
 WAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139567; x=1773744367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EheWkw2OWNqmR+PTvFkXIAihDadgyU9zVwk6/vLuKwg=;
 b=wKpT0myETPOEpzcMgy8QW06YjB/jNCSM7nfu07wgnmp18S35JK4NVLD36Fcq8SedBw
 y70qpbgoGWHwectvwylAnI2VCof9Da7Wizudw1keqdqbZdL+JDJJk92/3AAGPNNHda/T
 huMCY5cCAXpM55S1UfFTtecbrEg87i6q6rn/I1zBzUU4aB5n+fDD3ecZS9cVw+df2vBs
 ur5pUvL6YBS9wgDZEnNbZsyWRTzKeUmKVxybXjgDaDsWC2r8+iGqoZd8BmFRvaM8hjSX
 kYt7BP9IHRL93BIFywP5wJXJU9q90YLm4YMO714e8wQOMv+UZZg/x6bh+18oF30yXtsJ
 PG3w==
X-Gm-Message-State: AOJu0YyRjWZNFhDqDROVw5WEoOkt6rYt/cvP/YvBSH9lLtGVVsupbYzo
 I7OrWM/Lj5MHX7ZelULWukeb7H/zddmrP0HaT4RfbYSDyiloQGSiO4scGFygxjhZrG0=
X-Gm-Gg: ATEYQzz19qfPjKUOlnjKPv6lAZZrvmHR7hahdmz4xVCbahJFONJDY5/vauRidu/e47X
 fug36OmWp28iq7bPNWTiXAvPx9VTZ4lf/B3PPsVoxavz7wshhH4Bbgl/gC7Js4Kz0383G0iBu9g
 gLpkzH4mshJia8vFCHjF+s3bH06aHATYvnyeiuqvXBD5xHX41Gz1Kx0o+nXEGDv4FCtFc97eoRK
 7VTRy569T3pZ7I3+lhEw3XF0UohW22nOS7+NVPoFuEA5nJrvk8JWARAYRKzCae+qs/7txWwehdt
 nOd0aeHAkXdzg5Cq4/EDATavxyQWuGj0GVgpWip34ThjCJFbQYkLZ45msHr/VqwVpHlCF5/4T04
 2XKhzo6XmcgHY6d8Ne2NIMlS+tv/nWoQyzc8UN8MhP4nUDGk41BSkaz6rg9Sfmvq9pAp+mKfzpF
 y7bpqD+Ygv0KUrC3D7YMFlQfNAAVC0YQRh3eM2SX8skUc/6QwqUioJOwuy4XwADph3tUeLzcZQ9
 R8E0PZknqSYADeUiCCV
X-Received: by 2002:a05:600c:34c5:b0:485:3f38:3de3 with SMTP id
 5b1f17b1804b1-4853f383f6emr77588165e9.3.1773139567458; 
 Tue, 10 Mar 2026 03:46:07 -0700 (PDT)
Received: from jw-ThinkPad-T14-Gen-3.home (128.70.159.143.dyn.plus.net.
 [143.159.70.128]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadb29fdsm34838715f8f.16.2026.03.10.03.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 03:46:07 -0700 (PDT)
From: James Wainwright <james.wainwright@lowrisc.org>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 Emmanuel Blot <eblot@rivosinc.com>,
 James Wainwright <james.wainwright@lowrisc.org>
Subject: [PATCH v2 3/3] disas: diassemble RISC-V Zbr0p93 instructions
Date: Tue, 10 Mar 2026 10:45:58 +0000
Message-ID: <20260310104558.52838-4-james.wainwright@lowrisc.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260310104558.52838-1-james.wainwright@lowrisc.org>
References: <20260310104558.52838-1-james.wainwright@lowrisc.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=james.wainwright@lowrisc.org; helo=mail-wm1-x329.google.com
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

From: Emmanuel Blot <eblot@rivosinc.com>

Placed in a separate file as an unratified extension.

Signed-off-by: James Wainwright <james.wainwright@lowrisc.org>
---
 MAINTAINERS           |  2 +-
 disas/meson.build     |  3 +-
 disas/riscv-xbr0p93.c | 79 +++++++++++++++++++++++++++++++++++++++++++
 disas/riscv-xbr0p93.h | 19 +++++++++++
 disas/riscv.c         |  4 +++
 5 files changed, 105 insertions(+), 2 deletions(-)
 create mode 100644 disas/riscv-xbr0p93.c
 create mode 100644 disas/riscv-xbr0p93.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6698e5ff69..a3b747148d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4144,7 +4144,7 @@ M: Alistair Francis <Alistair.Francis@wdc.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: tcg/riscv64/
-F: disas/riscv.[ch]
+F: disas/riscv*.[ch]
 
 S390 TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
diff --git a/disas/meson.build b/disas/meson.build
index bbfa119783..06e265bccb 100644
--- a/disas/meson.build
+++ b/disas/meson.build
@@ -7,7 +7,8 @@ common_ss.add(when: 'CONFIG_MIPS_DIS', if_true: files('mips.c', 'nanomips.c'))
 common_ss.add(when: 'CONFIG_RISCV_DIS', if_true: files(
     'riscv.c',
     'riscv-xthead.c',
-    'riscv-xventana.c'
+    'riscv-xventana.c',
+    'riscv-xbr0p93.c'
 ))
 common_ss.add(when: 'CONFIG_SH4_DIS', if_true: files('sh4.c'))
 common_ss.add(when: 'CONFIG_SPARC_DIS', if_true: files('sparc.c'))
diff --git a/disas/riscv-xbr0p93.c b/disas/riscv-xbr0p93.c
new file mode 100644
index 0000000000..8880280ee1
--- /dev/null
+++ b/disas/riscv-xbr0p93.c
@@ -0,0 +1,79 @@
+/*
+ * QEMU RISC-V Disassembler for xbr0p93 matching the unratified Zbr CRC32
+ * bitmanip extension v0.93.
+ *
+ * Copyright (c) 2023 Rivos Inc
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "disas/riscv.h"
+#include "disas/riscv-xbr0p93.h"
+
+typedef enum {
+    /* 0 is reserved for rv_op_illegal. */
+    rv_op_crc32_b = 1,
+    rv_op_crc32_h = 2,
+    rv_op_crc32_w = 3,
+    rv_op_crc32_d = 4,
+    rv_op_crc32c_b = 5,
+    rv_op_crc32c_h = 6,
+    rv_op_crc32c_w = 7,
+    rv_op_crc32c_d = 8,
+} rv_xbr0p93_op;
+
+const rv_opcode_data rv_xbr0p93_opcode_data[] = {
+    { "illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, 0, 0 },
+    { "crc32.b", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
+    { "crc32.h", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
+    { "crc32.w", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
+    { "crc32.d", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
+    { "crc32c.b", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
+    { "crc32c.h", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
+    { "crc32c.w", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
+    { "crc32c.d", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
+};
+
+void decode_xbr0p93(rv_decode *dec, rv_isa isa)
+{
+    rv_inst inst = dec->inst;
+    rv_opcode op = rv_op_illegal;
+
+    switch ((inst >> 0) & 0b1111111) {
+    case 0b0010011:
+        switch ((inst >> 12) & 0b111) {
+        case 0b001:
+            switch ((inst >> 20 & 0b111111111111)) {
+            case 0b011000010000:
+                op = rv_op_crc32_b;
+                break;
+            case 0b011000010001:
+                op = rv_op_crc32_h;
+                break;
+            case 0b011000010010:
+                op = rv_op_crc32_w;
+                break;
+            case 0b011000010011:
+                op = rv_op_crc32_d;
+                break;
+            case 0b011000011000:
+                op = rv_op_crc32c_b;
+                break;
+            case 0b011000011001:
+                op = rv_op_crc32c_h;
+                break;
+            case 0b011000011010:
+                op = rv_op_crc32c_w;
+                break;
+            case 0b011000011011:
+                op = rv_op_crc32c_d;
+                break;
+            }
+            break;
+        }
+        break;
+    }
+    dec->op = op;
+}
diff --git a/disas/riscv-xbr0p93.h b/disas/riscv-xbr0p93.h
new file mode 100644
index 0000000000..29026cc5ec
--- /dev/null
+++ b/disas/riscv-xbr0p93.h
@@ -0,0 +1,19 @@
+/*
+ * QEMU RISC-V Disassembler for xbr0p93 matching the unratified Zbr CRC32
+ * bitmanip extension v0.93.
+ *
+ * Copyright (c) 2023 Rivos Inc
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef DISAS_RISCV_XBR0P93_H
+#define DISAS_RISCV_XBR0P93_H
+
+#include "disas/riscv.h"
+
+extern const rv_opcode_data rv_xbr0p93_opcode_data[];
+
+void decode_xbr0p93(rv_decode *, rv_isa);
+
+#endif /* DISAS_RISCV_XBR0P93_H */
diff --git a/disas/riscv.c b/disas/riscv.c
index 6f2667482d..9674032206 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -27,6 +27,9 @@
 #include "disas/riscv-xthead.h"
 #include "disas/riscv-xventana.h"
 
+/* Unratified extensions */
+#include "disas/riscv-xbr0p93.h"
+
 typedef enum {
     /* 0 is reserved for rv_op_illegal. */
     rv_op_lui = 1,
@@ -5434,6 +5437,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
         { has_xtheadmempair_p, xthead_opcode_data, decode_xtheadmempair },
         { has_xtheadsync_p, xthead_opcode_data, decode_xtheadsync },
         { has_XVentanaCondOps_p, ventana_opcode_data, decode_xventanacondops },
+        { has_xbr0p93_p, rv_xbr0p93_opcode_data, decode_xbr0p93 },
     };
 
     for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
-- 
2.48.1


