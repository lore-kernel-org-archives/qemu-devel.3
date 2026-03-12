Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907FA103E2EB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 13:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0gJ9-0004Az-Bb; Thu, 12 Mar 2026 09:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1w0gJ1-00047U-8w
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 09:42:30 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1w0gIx-0002Pw-GL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 09:42:26 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439c6fc2910so868722f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 06:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1773322937; x=1773927737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k8uF5GsAMR8qQ1wqC79LssvWzK7kAlOMQHA4mbMeZ6A=;
 b=dBIYA1ow0y99Z/wNpri2l5btNFY3JFX9HcnSI5rv4FateX7kySsS6vqX/9lvDrSwfB
 atniI8SpjfrjpTPlity1f9c0/dO+LsEGsg7Cc8JG4FbYR2MPfhcKNqMsv65MiEIYpHSS
 3SjVlpsT6NMDMtPorJGEYA0aRsKO9VG68M1DpYOG0RDRUgR5+i89kZHpjbqp/ypF7gvb
 OWMJkhINxM+vErrA/UjxlgHi7RegnTo2rHtKOq7+aUlw/UfIlTA/qRNBS6TdyWOD6x+D
 l/twl3UNPmO4E44g7qk1RQOpVfgVp+7eTSUhFBYJEcUdL/IJq7MnzBfI5mFTBSGo6QQQ
 L11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773322937; x=1773927737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k8uF5GsAMR8qQ1wqC79LssvWzK7kAlOMQHA4mbMeZ6A=;
 b=ZFlQ0uvW/cN3FbY6crCoZW78DVNcJpl1s34bfiWcxx4yTEPelvGON9OsqUs7Ina73f
 qNFTNpO7ODpKSLyAUEwJLOfSx6EeqeVJmi67gwYtrbSPo0gVgtcGGwd5M56Uydsei3Xj
 SoYAGnXCsdy3MdMD/BZxgDEpr1ou17GKvVKvHa4rmoUPjSZfIaG2FOAqpdlEfdE9vXnd
 hh0vg5kgaakISWbZJOQkvweweQTw+C0Zmon6YWHe3D8vx3DNf2Sl/3AH1KbGtmtaNIpc
 EogVimeSe5IRVnYJJ/yuW3tgirO5zbXKuCgPE8zAMVS3iLiOygZJ/jlZQRrvlONRBfaW
 Mryw==
X-Gm-Message-State: AOJu0YypEpN+FWFegYl4DrMHfA4n1Cumb+1ElDFweFccY04A3mY2oM+a
 PAZzmHHmaC9gZ3n25z3fFUmdHHtfwVjDJky/5quBlG7KP35EldNyPF2Ard1MP6nNYG22q7KoBLu
 zAa10tSI=
X-Gm-Gg: ATEYQzwK/Wk/Jc5rEBGVP35QIBg+4C8DdCqbxQn1/Y8FbEr/VTSEs4zKmk9LN9Qtuwk
 P9crxIyoc2SqrcuFInR6B+XiFdbuqyIsRGrUdTs3wX8IaNyST1S9uJ67dLHb26kZfzTT7ymjyqy
 wrch9hl97SADO4thYeCCb6xW9ZExLni0+1OBC7/z8aUWTCPYSjUnqRbB6ZGxW/ijNIKLnBMrYUD
 /z/POcaQi7ty2nVOEV+az/k95crTwsE4czchUSgILce0ZhfJp5qDNcgQMhuEP08Eu1Escxj4gTa
 toFOcwNbcMsb8KzM7PU6zmlVeDWKp3SFtj8QOEcxdvm26fLEORNkYQwwXQoublZvkMR1q0LEJ9+
 GUFKbItR3ldqYOXFkyGXCbDHbul0FfGfDxsVI+OlNhnjoSUSWTgLs9TxLe3dncnC8+RVTvlNLBC
 cDxaw6lKsKJOzbwnBVcOLSmm3711A0d5GuD4feuh1uKttLBQB68tUFp1Dv
X-Received: by 2002:a05:6000:2681:b0:439:cbf3:4a8f with SMTP id
 ffacd0b85a97d-439f8434f2amr12748916f8f.41.1773322937326; 
 Thu, 12 Mar 2026 06:42:17 -0700 (PDT)
Received: from localhost.localdomain ([193.35.234.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1a737csm7589814f8f.10.2026.03.12.06.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 06:42:17 -0700 (PDT)
From: James Wainwright <james.wainwright@lowrisc.org>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 Emmanuel Blot <eblot@rivosinc.com>,
 James Wainwright <james.wainwright@lowrisc.org>
Subject: [PATCH v4 3/3] disas: diassemble RISC-V xlrbr (crc32) instructions
Date: Thu, 12 Mar 2026 13:42:09 +0000
Message-ID: <20260312134210.5823-4-james.wainwright@lowrisc.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260312134210.5823-1-james.wainwright@lowrisc.org>
References: <20260312134210.5823-1-james.wainwright@lowrisc.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=james.wainwright@lowrisc.org; helo=mail-wr1-x429.google.com
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


