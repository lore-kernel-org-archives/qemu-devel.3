Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCE3FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwqk-00010I-TU; Wed, 29 Apr 2026 00:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwqi-0000zv-Ld
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:48:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwqf-0008FQ-Og
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:48:36 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b25cf1b5f0so66518875ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438112; x=1778042912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3qddBomdwVPgXcvkN5q95ic1E8DF7L9b2VLQtgxH/4=;
 b=gWUIgn2hGr+cIsN40PJdFOdieVnjuMR9O8+8/sDRdE8dpUiHDRgkgK2nnRXhA1PNNh
 8VGKdPlSXxTuuRHA5YlpQMgD1Lu9ntgcZ77nIz7pLApAU9GYwvqdtR+/nA38ppso0LPw
 PFJw6lt09HzBKpKTdruca86Zby0Kft+IPenYCPF9RUjdrNIJflcmOcXjJIlhJwfFaykQ
 41JZruUtHdmJrnOsMkyGDhsETbsgPBP5EVX73eBqxI5238QXxTM07wfbO5x2Lu+BQg8w
 ia+4BpkaQLT2dssMBj0O/rFEKv0P3tEQQg1dpSCrsJ4YSS/jW+NuGSDXlIYbsURZGXoM
 hJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438112; x=1778042912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W3qddBomdwVPgXcvkN5q95ic1E8DF7L9b2VLQtgxH/4=;
 b=SaA6lagaDTX7fC1VV2m2UnI9VhcSzEzIzeMZD5Zpl2cA5wcFTtWRbhz9mbsS/h/FBL
 /jwSBYFKcMwZacaq4MAnDklHsyAn8g5qI9nBQg+nLnoe7VOZD1n0yDLSh2oaCjwvZz2l
 hhB1pI7w97ZUmDzo9+VVHvTnFSoUCb5f/fGVm5nWkQUhIJdbyWEQ9vZ5DxSugt982s/G
 ljsvIUmCKZ3bd2WqjTWH5INHXwh606pToJ3VIsTHkzm5s3gvlAG7eilxgOWPeZ9RlTyj
 vreY3Wth5ZgziEgHU5b9p1CphAcGhbfN9V0pXfuj1+RLf1yeR1b/lxLRVlgL+jqKsaUD
 /C5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9m6ZhcCKPlzPsIHG8fEgxaXwzgUBPTpn2ekQ6R55l7l9aHPmx1iQGfrjKZg82kdFJB7dPgQAyqLtaK@nongnu.org
X-Gm-Message-State: AOJu0YzOnmLgdgJrWIpoKe9TY1EtZ63ZhfLXrIA0Su/ZQm28onF5GzEf
 idiwefGNnj+B4/Vs5jXoJLjzqfwI7CcNmF8/UtqUEIiR0NpFZGCo4hCV
X-Gm-Gg: AeBDieuf9YtYbMCAbVfWAE9YIoqeadenQQGIsnIvVHoy151xk62ppWPkU2EkdkJtK1P
 qAc3YMxPhUQMX+we5u6JorLCUav9ENKg4n7Hx0dxvFNBZr6IN3Z7Skj5xqs83t8EEjHRrQ5KloU
 KDuuCv5ERsVlW+MrTjB6Q30+pN9DQEiUUJ0Y6XpJ+JRAvtR4NwwHzR1V+aBIjqI+hHr1RBpR1ur
 6LzVuyoLo9W0M/hW5h0lqxxRi/EsGvmfxWpw7H7iP2OSTO3VfTCMjJOQKPFblWLuX+oLNTs/f7M
 6D5LdvXasxJwo1bQsiph+KMg/mV/dhOxPVy7HEYpY7DU1dOUxO+J+4TT6miV6lW68QAtsY1e4P+
 MbA7MRbuh7VYPrLR+MmKAqRfkg1mNDPnQAj3d7JQ87TdnaUNnpELLhXdIi6/Cna24yxXVH8b/YG
 GemOU10FwLITuawO9mLe7pbMyznGIKk793YxeA2hfrYxc6byScWp4Q
X-Received: by 2002:a17:902:f08d:b0:2ae:46b9:c653 with SMTP id
 d9443c01a7336-2b98744d1bdmr14639225ad.33.1777438112103; 
 Tue, 28 Apr 2026 21:48:32 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:48:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Emmanuel Blot <eblot@rivosinc.com>,
 James Wainwright <james.wainwright@lowrisc.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/51] disas: diassemble RISC-V xlrbr (crc32) instructions
Date: Wed, 29 Apr 2026 14:47:05 +1000
Message-ID: <20260429044752.4176397-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Placed in a separate file as a vendor extension.

Signed-off-by: James Wainwright <james.wainwright@lowrisc.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260320134254.217123-4-james.wainwright@lowrisc.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS         |  2 +-
 disas/riscv-xlrbr.h | 19 +++++++++++
 disas/riscv-xlrbr.c | 79 +++++++++++++++++++++++++++++++++++++++++++++
 disas/riscv.c       |  2 ++
 disas/meson.build   |  3 +-
 5 files changed, 103 insertions(+), 2 deletions(-)
 create mode 100644 disas/riscv-xlrbr.h
 create mode 100644 disas/riscv-xlrbr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f7e835cf55..e41f0eb92c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4135,7 +4135,7 @@ R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: tcg/riscv64/
-F: disas/riscv.[ch]
+F: disas/riscv*.[ch]
 
 S390 TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
diff --git a/disas/riscv-xlrbr.h b/disas/riscv-xlrbr.h
new file mode 100644
index 0000000000..939a69ea6d
--- /dev/null
+++ b/disas/riscv-xlrbr.h
@@ -0,0 +1,19 @@
+/*
+ * QEMU RISC-V Disassembler for xlrbr matching the unratified Zbr CRC32
+ * bitmanip extension v0.93.
+ *
+ * Copyright (c) 2023 Rivos Inc
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef DISAS_RISCV_XLRBR_H
+#define DISAS_RISCV_XLRBR_H
+
+#include "disas/riscv.h"
+
+extern const rv_opcode_data rv_xlrbr_opcode_data[];
+
+void decode_xlrbr(rv_decode *, rv_isa);
+
+#endif /* DISAS_RISCV_XLRBR_H */
diff --git a/disas/riscv-xlrbr.c b/disas/riscv-xlrbr.c
new file mode 100644
index 0000000000..57cb434523
--- /dev/null
+++ b/disas/riscv-xlrbr.c
@@ -0,0 +1,79 @@
+/*
+ * QEMU RISC-V Disassembler for xlrbr matching the unratified Zbr CRC32
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
+#include "disas/riscv-xlrbr.h"
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
+} rv_xlrbr_op;
+
+const rv_opcode_data rv_xlrbr_opcode_data[] = {
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
+void decode_xlrbr(rv_decode *dec, rv_isa isa)
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
diff --git a/disas/riscv.c b/disas/riscv.c
index 6f2667482d..d416a4d6b3 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -26,6 +26,7 @@
 /* Vendor extensions */
 #include "disas/riscv-xthead.h"
 #include "disas/riscv-xventana.h"
+#include "disas/riscv-xlrbr.h"
 
 typedef enum {
     /* 0 is reserved for rv_op_illegal. */
@@ -5434,6 +5435,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
         { has_xtheadmempair_p, xthead_opcode_data, decode_xtheadmempair },
         { has_xtheadsync_p, xthead_opcode_data, decode_xtheadsync },
         { has_XVentanaCondOps_p, ventana_opcode_data, decode_xventanacondops },
+        { has_xlrbr_p, rv_xlrbr_opcode_data, decode_xlrbr },
     };
 
     for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
diff --git a/disas/meson.build b/disas/meson.build
index bbfa119783..42977a1f74 100644
--- a/disas/meson.build
+++ b/disas/meson.build
@@ -7,7 +7,8 @@ common_ss.add(when: 'CONFIG_MIPS_DIS', if_true: files('mips.c', 'nanomips.c'))
 common_ss.add(when: 'CONFIG_RISCV_DIS', if_true: files(
     'riscv.c',
     'riscv-xthead.c',
-    'riscv-xventana.c'
+    'riscv-xventana.c',
+    'riscv-xlrbr.c'
 ))
 common_ss.add(when: 'CONFIG_SH4_DIS', if_true: files('sh4.c'))
 common_ss.add(when: 'CONFIG_SPARC_DIS', if_true: files('sparc.c'))
-- 
2.53.0


