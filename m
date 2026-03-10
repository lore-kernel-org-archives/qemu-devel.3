Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAAFEB106D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzymc-0006MT-I7; Tue, 10 Mar 2026 11:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vzymX-0006GZ-7A
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:14:02 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vzymU-00007Z-Ai
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:14:00 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-660dcafc85aso11991288a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1773155637; x=1773760437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzamEEUkcMfpB6zOM0SSyWILlySAOaiRA7ICfIsHeiY=;
 b=TKy/b5OkSvt96oMjtA5aUccJm4VXQfxC1XBuevfZWHMXVrtZHcoHLTKWPKLRN49fwN
 HtbrDekevr+LCvxIb13ZPau83roOdp+DDg5M4bC1i53DjN8HDheQi9Oy31pn9+HfZ1vA
 /0ljZdhJoyVlJlFJBv8TVQ/3NBjgGJ36sYaCYXtH46wnWWDlTsK0sSpHm0dXw93p+Ct1
 cFL47/JZVuKVQoBQu6NEsB56H2y7tt4uvNhO9XVVJkZkWmWsY6T6eZa8PqL0HQvu0415
 TNOM4iraAIJNVI1moR3QNW1lo76RGWHw7qQwjbHLtQq9cCBwctZLxVjtxy5bIxWUngIR
 dlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773155637; x=1773760437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DzamEEUkcMfpB6zOM0SSyWILlySAOaiRA7ICfIsHeiY=;
 b=PSFS0q87vcFmDrKHc6ozgwwIXIKlPPR2wMBuhSs7MPMHLiYYPnUUvoZz4OzZQtoK5M
 EbgAJB+1lA4Z63BBFGXxONNgD/anJceXKvNG6BbTRbf5arbq+pIzjNe/aD1RWyRj9kjM
 V1agYdXC4O1vb+kXK+tU/JEV83NlhtuqG1gQl3JYWmhefnJ6bkKiXD1f8F8rZmwf99rT
 2eXOjnvxo9TCl6Zfep5oNuwXiU8U/VCkdYHU8w7nplqSdNnUbImfsuQRNnX8Hw0YDpEQ
 Y46YPxUDmTSf71sQuRX8P+tuCDEEc9+VwV2ZvYJjrVseWQp9QFV1gZUafiWkGrR7iajK
 5vmQ==
X-Gm-Message-State: AOJu0YzAeax7Wo85PC5cmzYruji9nWi/4pDE2aYns8+E62Pr6/eaIsAd
 HiLgUZkEkTmv7FebYDjE2fuayOB9m+YxPiKKPtCbna1sQkFhNvFdgzU+IasgBbrA+Wc=
X-Gm-Gg: ATEYQzzcGWZHeJ1D1OI7f54v9VS2dmPmpQqrStjYcSUbq9rO6ITDEDVO1w1ba1vR0pC
 qwa4JHoF208TWCdSacVqsSJU9jEG6cdCggKAyJ32ANbN37fy82ifYhSY9XEMx6uZ9DBTi55ntc2
 q5P9fPRqFbA803bq9837EI7URVBhNg5noNwiEBTkfqB2bHVzO/1CnVBiwU4CnOkTohsPxjTV2jc
 c8/6pQMYOnlws+JrT0W+q7avE9OCOriOqTSxMmbc4ALtLnPbfhmsnEcqO2JubAR3pNNa8l+vaXb
 lYJLRMWvZMIOuwrUAyMMBF9TkOHIO07ng3UA1ppcrn4FgH4AbM497tQXdZR4JMsGrl1EGS7QVWO
 XfqdmYUo0ztNn4kvpNMz7sb8hP3Dl1d8bQhf88z8abGkktP3DcTCGVOaTUCDs07zuz66CWTaudV
 t/rnDVHPf+M8czkPihqUlTzvXCBfNids+q9dxCpyt2Fb5venofclwGvdms
X-Received: by 2002:a17:906:fd85:b0:b87:6953:9d5e with SMTP id
 a640c23a62f3a-b942dfb6e10mr988028766b.33.1773155636759; 
 Tue, 10 Mar 2026 08:13:56 -0700 (PDT)
Received: from localhost.localdomain ([193.35.234.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b942ef8cb2esm480204066b.26.2026.03.10.08.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:13:56 -0700 (PDT)
From: James Wainwright <james.wainwright@lowrisc.org>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 Emmanuel Blot <eblot@rivosinc.com>,
 James Wainwright <james.wainwright@lowrisc.org>
Subject: [PATCH v3 3/3] disas: diassemble RISC-V Zbr0p93 instructions
Date: Tue, 10 Mar 2026 15:13:47 +0000
Message-ID: <20260310151347.67263-4-james.wainwright@lowrisc.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260310151347.67263-1-james.wainwright@lowrisc.org>
References: <20260310151347.67263-1-james.wainwright@lowrisc.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=james.wainwright@lowrisc.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 MAINTAINERS         |  2 +-
 disas/meson.build   |  3 +-
 disas/riscv-xlrbr.c | 79 +++++++++++++++++++++++++++++++++++++++++++++
 disas/riscv-xlrbr.h | 19 +++++++++++
 disas/riscv.c       |  2 ++
 5 files changed, 103 insertions(+), 2 deletions(-)
 create mode 100644 disas/riscv-xlrbr.c
 create mode 100644 disas/riscv-xlrbr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 847fd414bc..12f106f4c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4154,7 +4154,7 @@ M: Alistair Francis <Alistair.Francis@wdc.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: tcg/riscv64/
-F: disas/riscv.[ch]
+F: disas/riscv*.[ch]
 
 S390 TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
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
-- 
2.48.1


