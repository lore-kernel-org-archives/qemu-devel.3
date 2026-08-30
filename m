Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EC2C61DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 16:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0i0p-00065z-MY; Sun, 30 Aug 2026 12:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x0i0o-00065S-MA
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 12:04:02 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x0i0m-0007jh-96
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 12:04:02 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8556ec44e9aso2515136b3a.3
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 09:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788105838; x=1788710638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qfuWLkfY56DlvFvnk9V0XwwVqHrq/j9Qp1CQlP5+yfo=;
 b=kBq7dmBoOplSB7qj63nK+L1pIoYRQZW6R8L7wi8uqdMrU4S6oGKTz+FRWhbDlo8GQg
 Rr9vPh+f8Rc8TY7usSkBTXrJI6fBRtB988vcO8aYYCbqGl7MqvyhE0EinrYgmSEiALZg
 xjIXlMeEgVcF9UxE1fqw027LrKuIU2TN03eSxMoez7OKYY/0DyZsKSLg7O7JLaFNFZsM
 75cfe8OZOrqF3AbBZQr9uVUf6cjxnKNfeAZOYpiblxPcyA8Tho/FiMU+LUfw+d/how9O
 kkwphMm5BvVwnvOzNiRdXcN903AV++ia946fuiKfUeCRKXh0qzZHfmnVpiuP8iEXXkYd
 8bpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788105838; x=1788710638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qfuWLkfY56DlvFvnk9V0XwwVqHrq/j9Qp1CQlP5+yfo=;
 b=YHnuMH8Aj0+EsmhQHS3gD8WManzkX4hYCc9/rxtiCLqe1mADMwFyRStFjX3OPCwmXD
 tJ/iYu6E3SFgu+2nrjP+/Xr7ZYAsbG04Mb47wwkBA02aBbopMbhO26E/btxpARoIcL/6
 KybxCjDTExlKt6RukwZFgRmDs6nX4mGmkjjarGtSoT7Ud7xmjfxHBblu1HcEyx21cLFE
 gxnRJl+Oqo/Q5DaReX67pzz9pujn+Jd03yXBJRMB29V2xoY5tdLlC+jBFBWBjfm4kmHz
 AppxM95/HYzayhL1/xqe7dfB+4qJDePUtTZRurIbVRAhhHbmyjQ5/6w3oBYrYmwz6fU4
 SETg==
X-Gm-Message-State: AFuF++lCu6Pv5hb6GGV1a2bkL2GQ5qKJM4ss3OiTfoAANCh7nwnX+u6m
 Qxno/YGdgs5ClOzIWrdjzpeUDl7oWZW9SPWgdRgOiv8eaWwlWhimgj6WbuXD5HKYmh/y9H4/HOI
 L9E/iSIVeR0Pc3e99nwXmogMNL5ZeXAtFd/sRmgTDUaynuYv6KFMEfR/oaY8wdt3IOINfJ0FbMW
 jbVnAY0QKcE9BWJbtWXWXHLK40QIIMNKyd72w4omCo2g==
X-Gm-Gg: AR+sD12VDDbsUP6+W4pEk8bdFgucUlebaCEh9nugWP1jjbi6kX04dgNo91ccpmvRAUP
 AWPeBTMDY2pVDI1WsdH/QsHpkiOtL8WGdB4+PpEVVf+/1ze2N6Ob99WDaI/IY9OZuCmjYWy46Kb
 jWDPnn2FsSzAtEyo0bjpHnrO21NOlap/iG2e20Lz1uILUi9RTO05hBKsu2TdAfAoaeXKVBuU24b
 DeFxbKM+8LMWEbQweaadJzbSvOKiNh9QX29usPd6mPYeFNjehv+1gXunBYw1IdqWgNTGHbuvhn7
 z5b38eR5NSykr+L8TE34jzwu/Em60iWhlQPcTOActTwZAgj1qFG2fQ5uS0yK0vTxauD8SdxcOqO
 qWTMuVFWRWDqGSeAlbSG97go+P5mvbNcA+o5TuXrRuUl3gBwgn1O41ExjHRzGScTwfBCdpX6YfK
 69lXXToLcGvcZcQIpB2yOqTzacN7lp17nmtLjCIrgeyzmspPAFkntssfFXUB62NS/mOUFjnLSb9
 10+wmOxUSRpV3s+5lLMEJMvwlJS3kM9ubZsBkKgDN+Vbva3bDeySRegpZsdI7Dnb2G4CPMi9g==
X-Received: by 2002:a05:6a00:2e90:b0:851:ba04:ca02 with SMTP id
 d2e1a72fcca58-8562b782769mr29074680b3a.16.1788105838354; 
 Sun, 30 Aug 2026 09:03:58 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8569ff701d5sm2455900b3a.25.2026.08.30.09.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 09:03:57 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Chou <max.chou@sifive.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jason Chien <jason.chien@sifive.com>
Subject: [PATCH v3 5/6] disas/riscv: Add disassembler support for
 Xsfvqmaccdod/Xsfvqmaccqoq
Date: Mon, 31 Aug 2026 00:03:34 +0800
Message-ID: <20260830160335.3441069-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830160335.3441069-1-max.chou@sifive.com>
References: <20260830160335.3441069-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42b.google.com
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

From: Jason Chien <jason.chien@sifive.com>

Add disassembler support for all SiFive custom int8 matrix-multiply
instructions: sf.vqmacc{u,,us,su}.4x8x4 and sf.vqmacc{u,,us,su}.2x8x2.

These instructions share opcode 0b1011011 and funct3 0b010, and are
distinguished by funct6: 60-63 for the 4x8x4 (Xsfvqmaccqoq) tile and
44-47 for the 2x8x2 (Xsfvqmaccdod) tile.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
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
index 2e8dace19ff..629a238c925 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -405,6 +405,7 @@ S: Supported
 F: target/riscv/xsf.decode
 F: target/riscv/tcg/insn_trans/trans_xsf.c.inc
 F: target/riscv/tcg/xsf_helper.c
+F: disas/riscv-xsf*
 
 RENESAS RX CPUs
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
diff --git a/disas/meson.build b/disas/meson.build
index 42977a1f74d..91357162682 100644
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
index e85dbac0351..60d934744de 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -27,6 +27,7 @@
 #include "disas/riscv-xthead.h"
 #include "disas/riscv-xventana.h"
 #include "disas/riscv-xlrbr.h"
+#include "disas/riscv-xsf.h"
 
 /* register names */
 
@@ -3457,6 +3458,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
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


