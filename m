Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB034CA9EBD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGprs-0000sz-LH; Tue, 13 Oct 2026 23:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpro-0000cp-VJ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:25 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprm-0001jy-U2
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:24 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3ab3260b35dso2289456a91.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949282; x=1792554082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BXHIdCL2nwmPCAXE9RBEn375WNlbVPnjszwV9mXbAEo=;
 b=BQpxtiQtfN35qMB5QIDs0xnQa+8e0C94cqnxNKA3vyi9t0ks1CX+ti1mqzpORn/4mn
 JylB3Sy5bq+tGZdZx63pB1fkM2wCjwrdLbqCQob/ywkjqlEs68XDxaNzgg6W1toFdclx
 h4Bm8k+k0ee1Vn1cKQ52cA2C9KjobmASJJI2Ect3eMWudebieeG0nmGzhuQolbaRCydM
 K2hqp5Z1aPXjP18ZlxZP02GMS830Vv0gk2U+/ZVSMmaGIR+THahzlMfVSFVy+fX9EyKv
 AWcxIKha0m8fGOeyt8SmWYvNH3SwHtJ0LtfPOkVn8AXfqCCsx0uAWk/SYc4InwoFd3JY
 guRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949282; x=1792554082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BXHIdCL2nwmPCAXE9RBEn375WNlbVPnjszwV9mXbAEo=;
 b=FhQJE1dv7TR9qgXBime3O3UgV1g5dhtpF3uV7y3YL3BPADbl06lUW3penGL6eVWInd
 QgNMhP28kL2onetCZyEvFrDxO+eCSxry9BOJ5FUbz+mhpCb9DfnaK9YgJZU2sfdD1Blp
 74s0T5NyzROEK4y8U8nYElvNxB6EDz/+JBv7m2JtGexb6P9XXpLGblhdSHb29Zozn3F+
 AytUDXWm10hXMbwYHuk4t18gUcmbBFgHr+uuZwCEH4qm/ALJ3sFq4GI4lHuqc51D7Tfd
 0ihQYbkmUQirWX9icGS9C9zO+NRZOJQkdJE2i5hlyVBw0UpnuYQcIQfMsklSWjmM/nPj
 0PzQ==
X-Gm-Message-State: AFq9FYJ+F3gq6TadGtRONpK0FyMkGZA5FuJguCs62CzKyYREaDFCU8xr
 k3fc7NGyZQXZCSfJHxQfpO+rIj3G9sR/6r3OL49GuizgHxxCzjyiVBHmxEB/9g==
X-Gm-Gg: AYBFou0vI/JXADInZmDfp9mzD9moZxWImR6dWd2cpdquCsz/x3BJhFVRM09Vqt5k044
 oaJEI3+BDsLdLSyhKfP6bpBPVVfUnKhqjI6L7YNqfuLOeMGXNZkB7Uzh1H6GTSq2iUtjifM3I/9
 moaLMrIn9KrKAu6XMZ3FDy4eNgatzFyIuRSeySermR8gNA1Jeo6L1FpS/07fCDuLZ292RvoB57T
 saoYQC5Vk3/onwWyeJyC1wqP68ywkjKbyA4H7E9IBLXNj3ls88flzWeKWNGYPXXdHypEumW3Nfg
 tpdolsAeJ9ce6Wn4CaHcVCYGwizBD5JxqTXmixYcaUBMzusuSPB2F089PFWz6LXZ3oDHjOFxf0X
 PJaakp749zBMDdviiONudstEHRAuAQoQj4LpWybsiLMJ3JEKsKo389z1t7MOii/R7a39sFH4piP
 ZRkWk22gO3f3b5MTDDtGiNhXXKfntHkWIaj9wWJBU1doKZeEhE+X1nhjiZVDLXPEQd2x8Or2o+5
 f5VN7tAUh1E+Ih+
X-Received: by 2002:a17:90b:3143:b0:3ab:e588:c29b with SMTP id
 98e67ed59e1d1-3abe588fa64mr7508628a91.5.1791949281509; 
 Tue, 13 Oct 2026 20:41:21 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:41:20 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Chou <max.chou@sifive.com>, Chao Liu <chao.liu@processmission.com>
Subject: [PULL 38/52] disas/riscv: Add disassembler support for
 Xsfvqmaccdod/Xsfvqmaccqoq
Date: Wed, 14 Oct 2026 13:38:53 +1000
Message-ID: <20261014033907.3332383-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Jason Chien <jason.chien@sifive.com>

Add disassembler support for all SiFive custom int8 matrix-multiply
instructions: sf.vqmacc{u,,us,su}.4x8x4 and sf.vqmacc{u,,us,su}.2x8x2.

These instructions share opcode 0b1011011 and funct3 0b010, and are
distinguished by funct6: 60-63 for the 4x8x4 (Xsfvqmaccqoq) tile and
44-47 for the 2x8x2 (Xsfvqmaccdod) tile.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260927082534.3228237-6-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS              |  1 +
 disas/riscv-xsf.h        | 16 +++++++++++++
 disas/riscv.h            |  1 +
 disas/riscv-xsf.c        | 49 ++++++++++++++++++++++++++++++++++++++++
 disas/riscv.c            |  2 ++
 disas/riscv-xsf-op.c.inc | 11 +++++++++
 disas/meson.build        |  3 ++-
 7 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 disas/riscv-xsf.h
 create mode 100644 disas/riscv-xsf.c
 create mode 100644 disas/riscv-xsf-op.c.inc

diff --git a/MAINTAINERS b/MAINTAINERS
index 7954964f4b..3957de045f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -405,6 +405,7 @@ S: Supported
 F: target/riscv/xsf.decode
 F: target/riscv/tcg/insn_trans/trans_xsf.c.inc
 F: target/riscv/tcg/xsf_helper.c
+F: disas/riscv-xsf*
 
 RENESAS RX CPUs
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
diff --git a/disas/riscv-xsf.h b/disas/riscv-xsf.h
new file mode 100644
index 0000000000..b15b7aa97c
--- /dev/null
+++ b/disas/riscv-xsf.h
@@ -0,0 +1,16 @@
+/*
+ * QEMU disassembler -- RISC-V specific header (xsf*).
+ *
+ * Copyright (c) 2023 SiFive, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef DISAS_RISCV_XSF_H
+#define DISAS_RISCV_XSF_H
+
+#include "disas/riscv.h"
+
+const rv_opcode_data *decode_xsf(rv_decode *, rv_isa);
+
+#endif /* DISAS_RISCV_XSF_H */
diff --git a/disas/riscv.h b/disas/riscv.h
index b0269bb709..4f1ffc4ae0 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -262,6 +262,7 @@ typedef struct {
 #define rv_fmt_vd_vs2_imm_vm          "O\tD,F,im"
 #define rv_fmt_vd_vs2_uimm            "O\tD,F,u"
 #define rv_fmt_vd_vs2_uimm_vm         "O\tD,F,um"
+#define rv_fmt_vd_vs1_vs2             "O\tD,E,F"
 #define rv_fmt_vd_vs1_vs2_vm          "O\tD,E,Fm"
 #define rv_fmt_vd_rs1_vs2_vm          "O\tD,1,Fm"
 #define rv_fmt_vd_fs1_vs2_vm          "O\tD,4,Fm"
diff --git a/disas/riscv-xsf.c b/disas/riscv-xsf.c
new file mode 100644
index 0000000000..745fcc8efd
--- /dev/null
+++ b/disas/riscv-xsf.c
@@ -0,0 +1,49 @@
+/*
+ * QEMU RISC-V Disassembler for xsf (SiFive vendor extensions).
+ *
+ * Copyright (c) 2023 SiFive, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "disas/riscv.h"
+#include "disas/riscv-xsf.h"
+
+#define OP(N, ...) static const rv_opcode_data op_##N = { __VA_ARGS__ };
+#include "riscv-xsf-op.c.inc"
+#undef OP
+
+const rv_opcode_data *decode_xsf(rv_decode *dec, rv_isa isa)
+{
+    rv_inst inst = dec->inst;
+
+    switch ((inst >> 0) & 0b1111111) {
+    case 0b1011011:
+        switch ((inst >> 12) & 0b111) {
+        case 0b010:
+            switch ((inst >> 26) & 0b111111) {
+            case 0b101100:
+                return &op_sf_vqmaccu_2x8x2;
+            case 0b101101:
+                return &op_sf_vqmacc_2x8x2;
+            case 0b101110:
+                return &op_sf_vqmaccus_2x8x2;
+            case 0b101111:
+                return &op_sf_vqmaccsu_2x8x2;
+            case 0b111100:
+                return &op_sf_vqmaccu_4x8x4;
+            case 0b111101:
+                return &op_sf_vqmacc_4x8x4;
+            case 0b111110:
+                return &op_sf_vqmaccus_4x8x4;
+            case 0b111111:
+                return &op_sf_vqmaccsu_4x8x4;
+            }
+            break;
+        }
+        break;
+    }
+
+    return NULL;
+}
diff --git a/disas/riscv.c b/disas/riscv.c
index 9645e19232..ca0d6e90b3 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -27,6 +27,7 @@
 #include "disas/riscv-xthead.h"
 #include "disas/riscv-xventana.h"
 #include "disas/riscv-xlrbr.h"
+#include "disas/riscv-xsf.h"
 
 /* register names */
 
@@ -3470,6 +3471,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
             { has_xtheadsync_p, decode_xtheadsync },
             { has_XVentanaCondOps_p, decode_xventanacondops },
             { has_xlrbr_p, decode_xlrbr },
+            { has_xsf_p, decode_xsf },
         };
 
         for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
diff --git a/disas/riscv-xsf-op.c.inc b/disas/riscv-xsf-op.c.inc
new file mode 100644
index 0000000000..c8daa7ebef
--- /dev/null
+++ b/disas/riscv-xsf-op.c.inc
@@ -0,0 +1,11 @@
+/* Xsfvqmaccqoq */
+OP(sf_vqmaccu_4x8x4, "sf.vqmaccu.4x8x4", rv_codec_v_r, rv_fmt_vd_vs1_vs2)
+OP(sf_vqmacc_4x8x4, "sf.vqmacc.4x8x4", rv_codec_v_r, rv_fmt_vd_vs1_vs2)
+OP(sf_vqmaccus_4x8x4, "sf.vqmaccus.4x8x4", rv_codec_v_r, rv_fmt_vd_vs1_vs2)
+OP(sf_vqmaccsu_4x8x4, "sf.vqmaccsu.4x8x4", rv_codec_v_r, rv_fmt_vd_vs1_vs2)
+
+/* Xsfvqmaccdod */
+OP(sf_vqmaccu_2x8x2, "sf.vqmaccu.2x8x2", rv_codec_v_r, rv_fmt_vd_vs1_vs2)
+OP(sf_vqmacc_2x8x2, "sf.vqmacc.2x8x2", rv_codec_v_r, rv_fmt_vd_vs1_vs2)
+OP(sf_vqmaccus_2x8x2, "sf.vqmaccus.2x8x2", rv_codec_v_r, rv_fmt_vd_vs1_vs2)
+OP(sf_vqmaccsu_2x8x2, "sf.vqmaccsu.2x8x2", rv_codec_v_r, rv_fmt_vd_vs1_vs2)
diff --git a/disas/meson.build b/disas/meson.build
index b382550e41..9b14adf4f1 100644
--- a/disas/meson.build
+++ b/disas/meson.build
@@ -8,7 +8,8 @@ common_ss.add(when: 'CONFIG_RISCV_DIS', if_true: files(
     'riscv.c',
     'riscv-xthead.c',
     'riscv-xventana.c',
-    'riscv-xlrbr.c'
+    'riscv-xlrbr.c',
+    'riscv-xsf.c'
 ))
 common_ss.add(when: 'CONFIG_SH4_DIS', if_true: files('sh4.c'))
 common_ss.add(when: 'CONFIG_SPARC_DIS', if_true: files('sparc.c'))
-- 
2.55.0


