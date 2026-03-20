Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF731098782
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3a8G-0001Tc-0o; Fri, 20 Mar 2026 09:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1w3a84-0001Qy-67
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:43:09 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1w3a81-0006oG-Dh
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:43:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so14395425e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1774014183; x=1774618983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWWNv53bjeYLS34UR+DUDWLX2qsxTxX0OjS975P/Fl4=;
 b=OvJjbng8HlFS1EXcY9gdkR7AxTyA9TcbBSsEf+SxqNUKNVa6VDF58juKlEsvEGVelx
 Tt5kjNnTSNYTv9kJ6CpHnfPAhG6Bo4rRXsuTmboAIceRX9jVogobOmle1d3UKj7GU7Bl
 HmxNUn53CKhszp/jkW0WjIz5R8+UUjhDfkSeRyhguR/xAoalCXfemRU+ocSTrC+BJfTv
 7JVhCXI9qnAh8woevisCBBVgH4YDFsn6ebMlHWL/uKwfeN8im954BaTqroeTGMKUVB/4
 lL7R4qkiYi5TS/66abRDfzD7L7fSutp4Zqp0Z2xY71CRf6sH8nU6UAv1Q0QQ/429Sa/m
 9uUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774014183; x=1774618983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wWWNv53bjeYLS34UR+DUDWLX2qsxTxX0OjS975P/Fl4=;
 b=HtjLNm1pjsC9A5mwvS0rhPdXd4lVJSB7MDBDh9ckqWoRTsDt7hi7V+LkOx3t9H4zuC
 lz7lHwJQrCTZk4PrXb+bTdwJPcDMAv/VDkuttgOdtgBDSOxPL2N3gSShdvV1dIGUeCEP
 jRRdtCbFXPzHxmLAtbtXWOLC++lDzpZP6DGbFQV+siQG8dwws4E/6tJJiP2x24Xr48zR
 PD6o3AHCESEhf1Y3+wvSbN2QDXQqlWrqMlDo8t57YyRdIH7GbhULbtZDsh55zLheW4ma
 q3Qbm2Kl7PCuR6UsyX/K1xtfkmX0Dk5PwV89PuiFqTUnFmCqCz1+qjWScICWO2rF1r91
 SNsQ==
X-Gm-Message-State: AOJu0YyfkWjFK89PAfdtCYDez/yzJUOuugZN0fQxY3pKcWZKY6KjhH+n
 +YlIXQZD5Dq3aeWBLgTwBPNV6Uzdt5Sl7mGC0/sDy11/3IKxAq9ucNFb+1y5WTb9pkA=
X-Gm-Gg: ATEYQzxJiqWGfJA5YSkgKBqwcFj97WlIcFCqXSK3af5vqmR6DJQvHzM9R9EeMdKOKP7
 xHPMneOMSMzN42clDYCWBPSNGgaLX4YgVKu6xNq5QcsonM3/fahtw/O2eXAe/EYzSYWpCVRtrIW
 izv6VUJo5IusNpWNhnaawuNYHhB4yNDb5VFnCgzj2V6hwPU/E0BPEkKz89sluNVGLdgRqIOzQyT
 5T/puQ4kE3FbMpQ0bgu6cKpeJFhmmY3i5TqJInaR3z9P/+j9Qa+LP3nxzpOBvzaBO+mDyVIIV1j
 8jdIbcVCnDB/EKOPqvRR50rKhxxPwPsvtneRI9pJBhQjVcIR57k0/YKg0J1uYqmyNHxxlr81jg5
 D8x6TocC/v8OspeUL8vjazRx5HWieykQ9D81rjZG+aGrvaYzjRnGt+Hd2C01Ojevi1dliHaNJow
 yASm5I+FrjQr0BFDltuVS2FWPgog6cO5KkZCJPE817P+OfgL7xSgfHon7zOKin+l6W9Ckt0cpzN
 JcqrFsLeIkV9EaLvkfn
X-Received: by 2002:a05:600c:3d97:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-486fe8e4066mr51951435e9.10.1774014183392; 
 Fri, 20 Mar 2026 06:43:03 -0700 (PDT)
Received: from jw-ThinkPad-T14-Gen-3.home (236.139.189.80.dyn.plus.net.
 [80.189.139.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe85ed6asm18328885e9.1.2026.03.20.06.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:43:03 -0700 (PDT)
From: James Wainwright <james.wainwright@lowrisc.org>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 Emmanuel Blot <eblot@rivosinc.com>,
 James Wainwright <james.wainwright@lowrisc.org>
Subject: [PATCH v5 3/3] disas: diassemble RISC-V xlrbr (crc32) instructions
Date: Fri, 20 Mar 2026 13:42:54 +0000
Message-ID: <20260320134254.217123-4-james.wainwright@lowrisc.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260320134254.217123-1-james.wainwright@lowrisc.org>
References: <20260320134254.217123-1-james.wainwright@lowrisc.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=james.wainwright@lowrisc.org; helo=mail-wm1-x32f.google.com
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

Placed in a separate file as a vendor extension.

Signed-off-by: James Wainwright <james.wainwright@lowrisc.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


