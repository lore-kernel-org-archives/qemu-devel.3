Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135DDC9833F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 08:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkD9-000469-Bj; Sun, 27 Sep 2026 04:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xAkCv-00044o-08
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 04:26:02 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xAkCo-0004hA-S9
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 04:25:57 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so1194684a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 01:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790497553; x=1791102353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eJyZv5zlZVLLhvPG7D5trWPlNxAU7G9VLrphRIn6S4A=;
 b=S5dbZwttGILlZDWw29yIVoldE8Udcx52uYJKPh4Zuxtjhw00b0pSWY2AF6fOJumeaI
 Cme4TBSCQ53NhtbNnt4xJxmA2WBUlEdvA/LD3j+QSupXdtRPatxiW9dX31dyzDHDnlqd
 A2+2BCG5+Xai1Bo9NPQLJi5lLDWu17JPGXXTsMOSID2yMbLnoH0lOKbGD7eU1FGn02PO
 QvYcagCkES7VBp3iq2wAiYVzmlM771K06DTCWPEIabbqKl1j4nzRsMmIYgmTC0+C/y7A
 Ww0V2VaRqmVZcVstscqgprj+akTO7OS0hMNik692D7O5Vz6kez0SFk0WGO8m94V3r+7K
 zx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790497553; x=1791102353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eJyZv5zlZVLLhvPG7D5trWPlNxAU7G9VLrphRIn6S4A=;
 b=uvKWcmEAN8dmlLU81fBpTRV3GBJYuYOYq64lzU5pxiJ8FcZokUP7JTV/AIWIl+YGag
 fvnLljbB8vWExUGYz0X399Jsz8jLBsINUC+LnZqjARDQl/DKZJz7SgmUn+xyI0k2YN4x
 EtVQATrCzXGTa9zRGxTWHdvMoXojwAY6fTYJRPX2sPR8cfGDqj1Tj7BMGTxpQB0BgU08
 3qPbKAmIYOpCoInfpvXPmUdXJz2nw9zIYRAdbOTHeXJm8btwUpP2gheZMGxhNehItAW6
 j/ZcCMVEYB77uto+rhD/Jas1dExS64MXIzMzRlJMxq7MwmHJbre4gHJ6k5FU0F10HDEz
 I34w==
X-Gm-Message-State: AFq9FYJye7QRf9im04KP91xaTQbadC51J7TSx8stoXhC69qBVuvc+1LW
 gHoZQnrFNfHNI+R0BqtLPCjsbVdAT28a+Wwd9qSVLXE538LZE36jLRk2kuY69UGotWlgLgezvQM
 Vyetvj3+5QNaBh2bF2PHy0wvlOMRUZHB4V5x0tW/ELpFvEZhr2orqnOl+ibHY/uyzETN7xQk/fx
 m6iUGL2mHCB3Zv1A+dvLP8pPFHSgWQSzurtvCC1xNMjg==
X-Gm-Gg: AYBFou1WFudvuiNPhJTHY+IdRz48Ogdeacajc+tVcKFt5/1S6HUf3jT3urtk4tqBecD
 vLSOFOxw+KFbRwdcs/C6Kqk5gB23NCM1wqhC4HqM1nxbCf9axNpRpfVuZYE+/GTeSKZalGx4015
 k+pbhrZwnd8uV9sdDMYqNkyar+So/W/Ks914OAfvwNo2Yl9K6bIcuvUsmYR9y+YI/CCmnGu/Jdm
 ZvQKJVBDZIkBy1CrijLjhczrY+OH5NSzHrQR/fuqtlNmEUiJS1wpy7SgpwK2sTJ8LVnkdg517Jn
 upQbBLn+vWjLBG0ZnHTO0fj28xBcVdMSlswlMv4RgBx4xbmmjmPTkqdnL05ZgmpcDKQGPL8uFDH
 D1i2RVukpxZzjPhceMiqGxhhS9z4L+4jVzk/3ONrNlSFIuhf5lBIPnV+qeXB1ROf9eD+rWJPJNV
 bHzKvjAvsNwFtPK5cdQAqiNyFMBYP1A8dZb0N9Kpy3/WPGBjIZCeqB032pdJUlSa7CNjUcXP4ph
 +XXHAP/HiWlbPtTxYS7x47MxErg+yZ6Yj6g+6BRnHMPFDq44Bb/6SWVcyQ+eotR77qmAlX2UA==
X-Received: by 2002:a17:90b:4d09:b0:39e:6a7e:ee1b with SMTP id
 98e67ed59e1d1-3a098d96146mr7883160a91.39.1790497552824; 
 Sun, 27 Sep 2026 01:25:52 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b9357f64sm14498871a91.3.2026.09.27.01.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 01:25:52 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Chou <max.chou@sifive.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jason Chien <jason.chien@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 5/6] disas/riscv: Add disassembler support for
 Xsfvqmaccdod/Xsfvqmaccqoq
Date: Sun, 27 Sep 2026 16:25:33 +0800
Message-ID: <20260927082534.3228237-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927082534.3228237-1-max.chou@sifive.com>
References: <20260927082534.3228237-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=max.chou@sifive.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
---
 MAINTAINERS              |  1 +
 disas/meson.build        |  3 ++-
 disas/riscv-xsf-op.c.inc | 11 +++++++++
 disas/riscv-xsf.c        | 49 ++++++++++++++++++++++++++++++++++++++++
 disas/riscv-xsf.h        | 16 +++++++++++++
 disas/riscv.c            |  2 ++
 disas/riscv.h            |  1 +
 7 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 disas/riscv-xsf-op.c.inc
 create mode 100644 disas/riscv-xsf.c
 create mode 100644 disas/riscv-xsf.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a3a8199840f..be1c505ac20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -406,6 +406,7 @@ S: Supported
 F: target/riscv/xsf.decode
 F: target/riscv/tcg/insn_trans/trans_xsf.c.inc
 F: target/riscv/tcg/xsf_helper.c
+F: disas/riscv-xsf*
 
 RENESAS RX CPUs
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
diff --git a/disas/meson.build b/disas/meson.build
index b382550e41f..9b14adf4f1b 100644
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
diff --git a/disas/riscv-xsf-op.c.inc b/disas/riscv-xsf-op.c.inc
new file mode 100644
index 00000000000..c8daa7ebef8
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
diff --git a/disas/riscv-xsf.c b/disas/riscv-xsf.c
new file mode 100644
index 00000000000..745fcc8efda
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
diff --git a/disas/riscv-xsf.h b/disas/riscv-xsf.h
new file mode 100644
index 00000000000..b15b7aa97c8
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
diff --git a/disas/riscv.c b/disas/riscv.c
index ef8b7ff20f9..d755172164a 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -27,6 +27,7 @@
 #include "disas/riscv-xthead.h"
 #include "disas/riscv-xventana.h"
 #include "disas/riscv-xlrbr.h"
+#include "disas/riscv-xsf.h"
 
 /* register names */
 
@@ -3456,6 +3457,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
             { has_xtheadsync_p, decode_xtheadsync },
             { has_XVentanaCondOps_p, decode_xventanacondops },
             { has_xlrbr_p, decode_xlrbr },
+            { has_xsf_p, decode_xsf },
         };
 
         for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
diff --git a/disas/riscv.h b/disas/riscv.h
index b0269bb709f..4f1ffc4ae02 100644
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
-- 
2.43.0


