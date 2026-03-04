Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1ED9EF8FEB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmvo-0002yY-CL; Wed, 04 Mar 2026 09:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vxl4X-00043p-9U
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 07:11:25 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vxl4U-0005yx-Ae
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 07:11:25 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439b97a8a8cso3140139f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 04:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1772626279; x=1773231079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GN/MBojFObjW4hTk6+kFYXvCHrFVsuEJkNUYUuvnHoA=;
 b=JAYouUjLAtQ0SoikggyVfeTE/HiqFh+zM7tURngmXCtj3HJTKYAjpStAAAn/rJmFEq
 eZPk4ciYNPXpnTJXPftsz1BYjSHDkLDcKET6vhAVY7ydS21WfW9Rm7Qcu6rirBJ+q8PC
 fYJC9+FnNXYm+AJWmnOPdgrkCjDcR4sEZr45FiuFAOqRBP6IjulYC8zTtWV37/AymoRd
 wjQvhkp1jj4seUAbBLERWdUjE2s7TkOdBYar7DRZYng2oOiwiF22TRqjCib1YwOBXzWi
 j6ktD8/vGUrPzdFBxTbFF+VdoDXD9IVItQK3koBmEx67q5+ijGgE50thjpyNZhOIqEz3
 tUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772626279; x=1773231079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GN/MBojFObjW4hTk6+kFYXvCHrFVsuEJkNUYUuvnHoA=;
 b=imuMOUM4AQxJMy5hbraH3jXufEcziCPAPrzeU1FdGKXhCpK8cb8nwaQM+r7HpJIkOT
 v20CHAUUO+UEO4xShvg0WYeplpvMr84VtS3TQTj9bsaBo/qr37ttx9Da0H2t5YboW/EM
 hXvoSc8+xLyeDNzPtWKi/ZWneGdEgIPYx9hhlI63RiS5BkN2J+VVgtcN15Ne/R4LlBYn
 cAVCPvDgSUIFy31FtplnBaogNUMOz5WRlj7B1kciN63SE26n7KT3RhCFphb4wfcniNzZ
 i86IfbtpuN3UOptRu3JvsS409BcwurXvCaxVFc4WIhCO9wa2gy8TNaKkDUBmDxnAdBIu
 BVkg==
X-Gm-Message-State: AOJu0YzgobvAWZ3r5TdiEVZEOO1CJJTNSoiQQPoIT6iaVT39O8aOCQTL
 obIkRQjUEiZn+r9EY1HGH7Yh2oO5NOZUkaYWpUhpQLWjSnUETasi6cYxGaLLp97ZhxY=
X-Gm-Gg: ATEYQzxiuAvJHWVJNxRsRIVwOaBRqQkMzTlcBp8yhDTLFumY8vcy2UpGCALCzQK6FD6
 LU2Gyi30UrbWEmaEs3yFg4SfIYpRJAY69cdjIWnufIrl8FbDrPSD+vzHSO+jA11ov+eJF+wugna
 OgVXoFeCYbu4lRezpp5V7jo2iYyvCYWc6VPf9SxbUBHO0rFaFk+FcHseylc1bdogkaTxH9ic6N2
 W96cMaVEpie5NPcVa9g5mZBcwCtmfUJ8MzBhHc2AZYNriLXvbOm+3ETeLgqZIn2dBewo2LerlPb
 npuePjkdHRYZxrGQtzY0A5ucOWx+/++scwIug/Anw2hmQ8JTZ9UEK+h0X/9uDrBRLarb6V6UEvi
 q2rF/RBJpgqoZrwJJvWHOTJC+WAQKmoHBz3II8c9mYaPeLNcINp/7R82J5/WRikxRWt8cCyLOym
 yIVOFUrS35b0ego8oSM95JGu1evDWd7M+VI+uEQmIHS9c/NEqK/LEcsxooXWnsEsj/AeJ++1TJ9
 dABXHMpY4pZRAtbOnyo
X-Received: by 2002:a05:6000:40e0:b0:439:af81:1b23 with SMTP id
 ffacd0b85a97d-439c7f791a0mr3524305f8f.21.1772626279158; 
 Wed, 04 Mar 2026 04:11:19 -0800 (PST)
Received: from jw-ThinkPad-T14-Gen-3.home (128.70.159.143.dyn.plus.net.
 [143.159.70.128]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b0549600sm28217570f8f.35.2026.03.04.04.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 04:11:18 -0800 (PST)
From: James Wainwright <james.wainwright@lowrisc.org>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 James Wainwright <james.wainwright@lowrisc.org>
Subject: [PATCH 3/3] disas: diassemble RISC-V Zbr0p93 instructions
Date: Wed,  4 Mar 2026 12:11:13 +0000
Message-ID: <20260304121113.117299-4-james.wainwright@lowrisc.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260304121113.117299-1-james.wainwright@lowrisc.org>
References: <20260304121113.117299-1-james.wainwright@lowrisc.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=james.wainwright@lowrisc.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Mar 2026 09:09:21 -0500
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

Placed in a separate file as an unratified extension.

Signed-off-by: James Wainwright <james.wainwright@lowrisc.org>
---
 MAINTAINERS       |  2 +-
 disas/meson.build |  3 +-
 disas/riscv-zbr.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 disas/riscv-zbr.h | 18 +++++++++++
 disas/riscv.c     |  4 +++
 5 files changed, 103 insertions(+), 2 deletions(-)
 create mode 100644 disas/riscv-zbr.c
 create mode 100644 disas/riscv-zbr.h

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
index bbfa119783..d549b9b072 100644
--- a/disas/meson.build
+++ b/disas/meson.build
@@ -7,7 +7,8 @@ common_ss.add(when: 'CONFIG_MIPS_DIS', if_true: files('mips.c', 'nanomips.c'))
 common_ss.add(when: 'CONFIG_RISCV_DIS', if_true: files(
     'riscv.c',
     'riscv-xthead.c',
-    'riscv-xventana.c'
+    'riscv-xventana.c',
+    'riscv-zbr.c'
 ))
 common_ss.add(when: 'CONFIG_SH4_DIS', if_true: files('sh4.c'))
 common_ss.add(when: 'CONFIG_SPARC_DIS', if_true: files('sparc.c'))
diff --git a/disas/riscv-zbr.c b/disas/riscv-zbr.c
new file mode 100644
index 0000000000..b8bde6026a
--- /dev/null
+++ b/disas/riscv-zbr.c
@@ -0,0 +1,78 @@
+/*
+ * QEMU RISC-V Disassembler for Zbr v0.93 (unratified)
+ *
+ * Copyright (c) 2023 Rivos Inc
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "disas/riscv.h"
+#include "disas/riscv-zbr.h"
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
+} rv_zbr_op;
+
+const rv_opcode_data rv_zbr_opcode_data[] = {
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
+void decode_zbr(rv_decode *dec, rv_isa isa)
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
diff --git a/disas/riscv-zbr.h b/disas/riscv-zbr.h
new file mode 100644
index 0000000000..327cdaea17
--- /dev/null
+++ b/disas/riscv-zbr.h
@@ -0,0 +1,18 @@
+/*
+ * QEMU RISC-V Disassembler for Zbr v0.93 (unratified)
+ *
+ * Copyright (c) 2023 Rivos Inc
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef DISAS_RISCV_ZBR_H
+#define DISAS_RISCV_ZBR_H
+
+#include "disas/riscv.h"
+
+extern const rv_opcode_data rv_zbr_opcode_data[];
+
+void decode_zbr(rv_decode *, rv_isa);
+
+#endif /* DISAS_RISCV_ZBR_H */
diff --git a/disas/riscv.c b/disas/riscv.c
index 6f2667482d..ebb77ea4ee 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -27,6 +27,9 @@
 #include "disas/riscv-xthead.h"
 #include "disas/riscv-xventana.h"
 
+/* Unratified extensions */
+#include "disas/riscv-zbr.h"
+
 typedef enum {
     /* 0 is reserved for rv_op_illegal. */
     rv_op_lui = 1,
@@ -5434,6 +5437,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
         { has_xtheadmempair_p, xthead_opcode_data, decode_xtheadmempair },
         { has_xtheadsync_p, xthead_opcode_data, decode_xtheadsync },
         { has_XVentanaCondOps_p, ventana_opcode_data, decode_xventanacondops },
+        { has_zbr_p, rv_zbr_opcode_data, decode_zbr },
     };
 
     for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
-- 
2.48.1


