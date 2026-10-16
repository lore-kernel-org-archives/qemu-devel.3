Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DDECC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWP5-0004H9-2o; Thu, 15 Oct 2026 21:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWN7-0001TF-8U
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:38 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMz-0004Mx-Km
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:31 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2e7e742a2c7so4273045ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112658; x=1792717458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8G6RGESCOGWVtxjRzZKZwL6D2J+s968tdOS5ZPEAyTs=;
 b=FHUutJ9YpotRS2qfk29G+1Yt1C2UECUsgbrIrmwoRan8yoaADaFe+hr/GRD8CCTjLg
 f//UgAj9kB8duOGEruzzHO6P2NCrBZLbTjuHl0tXg5Yr0wnU6sutUhGu2eU+7XeUAXEF
 3OfSGAIzE4d6Ls3vFtwR73CE3FgFZVNZ8eQSFaw9j/a5EKhBIxr4/zxNOeJh2rM9xv0m
 LaLFSI1nCkDZVNnmLyOih9XeJttX9GfwJFCVeJvm+M9/3K9ilaLejPv7UGfJKwV+nwNc
 KlGQuJ527DuoOnauTcSRVODKUXd1qCqycMrHcWQfkyOZ6HXx8voQHdhrxLT20pPDcGfm
 IepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112658; x=1792717458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8G6RGESCOGWVtxjRzZKZwL6D2J+s968tdOS5ZPEAyTs=;
 b=rp4+oYKykWywz1JWZJlWyBv/eBHxePKPcZAv4+ylJ7nW4VJtIymYOkdlVRmP7BpV1K
 N/olupFvabyNj65d/kXKPb9GGeh+FkNzA+9Gs96HmCJ3nKeQ6jYqMDJZW8Pp1uwJQBhC
 240dijJFa3bQembG85tQ8EdbDa46n/M0E4aD00lC7WZf3AdJxZBTXtDQ6LN9B1sG7lsS
 /facNhOJom3DaG4KYnqwrns/Y+BoN/QiViJLLAGcPUkIa7rDnhUzKD8ThksVqy6U72D/
 zwB1jif42t4aMY9CMqgYXOzNCC6TTpcuGTB6QGXTbztyTdlrOyFS87p6vGRphgezLmYu
 DIvA==
X-Gm-Message-State: AFq9FYL8nUrZMDkRuwxrPp6NlN3BalUQFrCZ6/eklJxxN7OQkTxQaQko
 I4WsnL++cO+oiwguxnDa7MQfZJiqHwOFJ0RxtxLruXfF1YYYz+bTGZecU/vsYw==
X-Gm-Gg: AYBFou3e4rsMNzj5okK98UT8LLaYMUHjOF5Wnf9fSdDnyX67NorDqCyAWvQuB8PJkk2
 8mZwgYxDaimUKmo4V7yqQtzXC+YpnKn/wN2cpFZc6dgCP1XZcjEpAVwtZqvuzq3+RocdW4R2LdM
 JNnORlkV9W3UQ4+kgCl2fVe2oZC3zIdLa4i/47/ORJGmRwehM7pCtiiQ7qHR5RfW0Ae2O9U73Td
 HCn0MpJSBip7jAdcrvKzaY7khvWgwbxF0+Z94fTvPer5lxTgfTM1DMbKtUr7/5QMKtRZTGKt379
 3NnChpoA0VPRGRh89A62o4geJnfwjtnVE35qeTaV+717ffDzTsaViWPohRGD/2RsK8V9GHFLsV+
 CEgYoJKcLRgh3l3al/4T0ka12X3KSuvvOtSJVRtJHV8DjsrtFewBkRUTaDGsN3hTJOp6jS3yV3g
 I0DBUJX6Gn+mxCtWO3eUjaAukHCy48qAwPgqTIdWQo7/mIpTmrWMmEGV1JNBKfdGhm8ZXs+EKNU
 Lq+UsI160fESQJOU780+9dskVA=
X-Received: by 2002:a17:903:4b30:b0:2e9:5598:d182 with SMTP id
 d9443c01a7336-2e977542455mr11911965ad.15.1792112657936; 
 Thu, 15 Oct 2026 18:04:17 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:04:17 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Chou <max.chou@sifive.com>, Chao Liu <chao.liu@processmission.com>
Subject: [PULL v2 32/50] target/riscv: rvv: Add SiFive custom int8 matmul
 instructions
Date: Fri, 16 Oct 2026 11:02:19 +1000
Message-ID: <20261016010237.1102834-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Add the 8 SiFive custom int8 matrix-multiply vector instructions:
sf.vqmacc{u,,us,su}.4x8x4 and sf.vqmacc{u,,us,su}.2x8x2. Each name
suffix encodes the signedness of vs1/vs2.
The 4x8x4 forms multiply-accumulate a 4x8 by 8x4 int8 tile into a
4x4 int32 result; the 2x8x2 forms use a 2x8 by 8x2 tile producing a
2x2 int32 result. Both Xsfvqmaccqoq/Xsfvqmaccdod extensions are
gated on vlenb >= 32, sew == 8 and vm == 1, per the SiFive Int8
Matrix Multiplication Extensions Specification.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260927082534.3228237-5-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                                 |  8 ++
 target/riscv/cpu_cfg.h                      |  5 ++
 target/riscv/helper.h                       | 10 +++
 target/riscv/xsf.decode                     | 30 +++++++
 target/riscv/tcg/translate.c                |  3 +
 target/riscv/tcg/xsf_helper.c               | 87 ++++++++++++++++++
 target/riscv/tcg/insn_trans/trans_xsf.c.inc | 98 +++++++++++++++++++++
 target/riscv/meson.build                    |  1 +
 target/riscv/tcg/meson.build                |  1 +
 9 files changed, 243 insertions(+)
 create mode 100644 target/riscv/xsf.decode
 create mode 100644 target/riscv/tcg/xsf_helper.c
 create mode 100644 target/riscv/tcg/insn_trans/trans_xsf.c.inc

diff --git a/MAINTAINERS b/MAINTAINERS
index b912e4b8d8..09dc49d27f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -398,6 +398,14 @@ F: target/riscv/XVentanaCondOps.decode
 F: target/riscv/insn_trans/trans_xventanacondops.c.inc
 F: disas/riscv-xventana*
 
+RISC-V SiFive (Xsf*) extensions
+M: Max Chou <max.chou@sifive.com>
+L: qemu-riscv@nongnu.org
+S: Supported
+F: target/riscv/xsf.decode
+F: target/riscv/tcg/insn_trans/trans_xsf.c.inc
+F: target/riscv/tcg/xsf_helper.c
+
 RENESAS RX CPUs
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 211d0708ba..d6db1cfb7c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -51,6 +51,11 @@ static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
            cfg->ext_xtheadmempair || cfg->ext_xtheadsync;
 }
 
+static inline bool has_xsf_p(const RISCVCPUConfig *cfg)
+{
+    return cfg->ext_xsfvqmaccdod || cfg->ext_xsfvqmaccqoq;
+}
+
 #define MATERIALISE_EXT_PREDICATE(ext) \
     static inline bool has_ ## ext ## _p(const RISCVCPUConfig *cfg) \
     { \
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 32225471bc..0e22210377 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1365,3 +1365,13 @@ DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
 /* Invalidate reservations overlapping a completed linux-user store. */
 DEF_HELPER_3(riscv_invalidate_reservations, void, env, tl, tl)
 #endif
+
+/* SiFive Custom int8 Matrix-Multiply */
+DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(sf_vqmacc_4x8x4, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(sf_vqmaccus_4x8x4, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(sf_vqmaccsu_4x8x4, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(sf_vqmaccu_2x8x2, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(sf_vqmacc_2x8x2, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(sf_vqmaccus_2x8x2, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(sf_vqmaccsu_2x8x2, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/xsf.decode b/target/riscv/xsf.decode
new file mode 100644
index 0000000000..bb585046ab
--- /dev/null
+++ b/target/riscv/xsf.decode
@@ -0,0 +1,30 @@
+#
+# RISC-V translation routines for the SiFive vendor extensions
+#
+# Copyright (c) 2023 SiFive, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# Fields:
+%rs2       20:5
+%rs1       15:5
+%rd        7:5
+%vm        25:1
+
+# Argument sets:
+&rmrr      vm rd rs1 rs2                           !extern
+
+# Formats:
+@r_vm_1    ......  . ..... ..... ... ..... ....... &rmrr vm=1 %rs2 %rs1 %rd
+
+# *** Xsfvqmaccqoq: SiFive custom int8 matrix-multiply (4x8x4 tile) ***
+sf_vqmaccu_4x8x4    111100 1 ..... ..... 010 ..... 1011011 @r_vm_1
+sf_vqmacc_4x8x4     111101 1 ..... ..... 010 ..... 1011011 @r_vm_1
+sf_vqmaccus_4x8x4   111110 1 ..... ..... 010 ..... 1011011 @r_vm_1
+sf_vqmaccsu_4x8x4   111111 1 ..... ..... 010 ..... 1011011 @r_vm_1
+
+# *** Xsfvqmaccdod: SiFive custom int8 matrix-multiply (2x8x2 tile) ***
+sf_vqmaccu_2x8x2    101100 1 ..... ..... 010 ..... 1011011 @r_vm_1
+sf_vqmacc_2x8x2     101101 1 ..... ..... 010 ..... 1011011 @r_vm_1
+sf_vqmaccus_2x8x2   101110 1 ..... ..... 010 ..... 1011011 @r_vm_1
+sf_vqmaccsu_2x8x2   101111 1 ..... ..... 010 ..... 1011011 @r_vm_1
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index d6b1f9bfee..470a5e71b2 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -1255,10 +1255,12 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "decode-xthead.c.inc"
 #include "decode-xmips.c.inc"
 #include "decode-xlrbr.c.inc"
+#include "decode-xsf.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
 #include "insn_trans/trans_xmips.c.inc"
 #include "insn_trans/trans_xlrbr.c.inc"
+#include "insn_trans/trans_xsf.c.inc"
 
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1279,6 +1281,7 @@ const RISCVDecoder decoder_table[] = {
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
     { has_xlrbr_p, decode_xlrbr},
+    { has_xsf_p, decode_xsf },
 };
 
 const size_t decoder_table_size = ARRAY_SIZE(decoder_table);
diff --git a/target/riscv/tcg/xsf_helper.c b/target/riscv/tcg/xsf_helper.c
new file mode 100644
index 0000000000..6e953d1249
--- /dev/null
+++ b/target/riscv/tcg/xsf_helper.c
@@ -0,0 +1,87 @@
+/*
+ * RISC-V translation helpers for the SiFive vendor extensions (xsf*)
+ *
+ * Copyright (c) 2023 SiFive, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/helper-proto.h"
+#include "internals.h"
+#include "vector_internals.h"
+
+#define QOP_SUU_B int32_t, uint8_t, uint8_t, int32_t, int32_t
+#define QOP_SUS_B int32_t, uint8_t, int8_t, int32_t, int32_t
+#define QOP_SSU_B int32_t, int8_t, uint8_t, int32_t, int32_t
+#define QOP_SSS_B int32_t, int8_t, int8_t, int32_t, int32_t
+
+/* SiFive Custom int8 Matrix-Multiply */
+/*
+ * vd may overlap vs2, we need to allocate an additional vd array
+ * to save temporary results of vd and write them back at the end.
+ */
+#define GEN_VEXT_SF_INT8_MATMUL(NAME, TD, T1, T2, TX1, TX2,           \
+                                HD, HS1, HS2, ROWS, COLS, TILE_SIZE)  \
+void HELPER(NAME)(void *vd, void *vs1, void *vs2,                     \
+                  CPURISCVState *env, uint32_t desc)                  \
+{                                                                     \
+    int it, il, in, im, ivd, ivs1, ivs2;                              \
+    TD *vds;                                                          \
+                                                                      \
+    if (env->vl % TILE_SIZE) {                                        \
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC()); \
+        return;                                                       \
+    }                                                                 \
+                                                                      \
+    VSTART_CHECK_EARLY_EXIT(env, env->vl);                            \
+                                                                      \
+    vds = g_malloc0(sizeof(TD) *                                      \
+                    ROWS * ROWS * (env->vl / TILE_SIZE));             \
+                                                                      \
+    for (it = 0; it < (env->vl / TILE_SIZE); it++) {                  \
+        for (il = 0; il < ROWS; il++) {                               \
+            for (in = 0; in < ROWS; in++) {                           \
+                ivd = ROWS * ROWS * it + ROWS * il + in;              \
+                vds[ivd] = *((TD *)vd + HD(ivd));                     \
+                for (im = 0; im < COLS; im++) {                       \
+                    ivs1 = il * COLS + im;                            \
+                    ivs2 = TILE_SIZE * it + im * ROWS + in;           \
+                    T1 s1 = *((T1 *)vs1 + HS1(ivs1));                 \
+                    T2 s2 = *((T2 *)vs2 + HS2(ivs2));                 \
+                    vds[ivd] += (TX1)s1 * (TX2)s2;                    \
+                }                                                     \
+            }                                                         \
+        }                                                             \
+    }                                                                 \
+                                                                      \
+    for (it = 0; it < (env->vl / TILE_SIZE); it++) {                  \
+        for (il = 0; il < ROWS; il++) {                               \
+            for (in = 0; in < ROWS; in++) {                           \
+                ivd = ROWS * ROWS * it + ROWS * il + in;              \
+                *((TD *)vd + HD(ivd)) = vds[ivd];                     \
+            }                                                         \
+        }                                                             \
+    }                                                                 \
+                                                                      \
+    env->vstart = 0;                                                  \
+    g_free(vds);                                                      \
+}
+
+RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccu_4x8x4, QOP_SUU_B, H4, H1, H1,
+        4, 8, 32)
+RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmacc_4x8x4, QOP_SSS_B, H4, H1, H1,
+        4, 8, 32)
+RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccus_4x8x4, QOP_SUS_B, H4, H1, H1,
+        4, 8, 32)
+RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccsu_4x8x4, QOP_SSU_B, H4, H1, H1,
+        4, 8, 32)
+RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccu_2x8x2, QOP_SUU_B, H4, H1, H1,
+        2, 8, 16)
+RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmacc_2x8x2, QOP_SSS_B, H4, H1, H1,
+        2, 8, 16)
+RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccus_2x8x2, QOP_SUS_B, H4, H1, H1,
+        2, 8, 16)
+RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccsu_2x8x2, QOP_SSU_B, H4, H1, H1,
+        2, 8, 16)
diff --git a/target/riscv/tcg/insn_trans/trans_xsf.c.inc b/target/riscv/tcg/insn_trans/trans_xsf.c.inc
new file mode 100644
index 0000000000..1677352689
--- /dev/null
+++ b/target/riscv/tcg/insn_trans/trans_xsf.c.inc
@@ -0,0 +1,98 @@
+/*
+ * RISC-V translation routines for the SiFive vendor extensions (xsf*)
+ *
+ * Copyright (c) 2023 SiFive, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+
+/*
+ * SiFive Xsfvqmaccdod/Xsfvqmaccqoq custom int8 matrix-multiply extensions
+ */
+static bool sf_int8_matmul_check(DisasContext *s, arg_rmrr *a)
+{
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           s->vstart_eq_zero &&
+           (s->cfg_ptr->vlenb >= 32) &&
+           (s->sew == MO_8) &&
+           (a->vm == 1);
+}
+
+static bool sf_int8_matmul_4x8x4_check(DisasContext *s, arg_rmrr *a)
+{
+    /*
+     * vd  has EMUL=2*LMUL
+     * vs2 has EMUL=LMUL
+     * vs1 has EMUL=1
+     * vd must not overlap vs1
+     */
+    return sf_int8_matmul_check(s, a) &&
+           (s->cfg_ptr->ext_xsfvqmaccqoq) &&
+           (s->lmul <= 2) &&
+           require_align(a->rd, s->lmul + 1) &&
+           require_align(a->rs2, s->lmul) &&
+           require_align(a->rs1, 0) &&
+           require_noover(a->rd, s->lmul + 1, a->rs2, s->lmul) &&
+           !is_overlapped(a->rd, 1 << MAX(s->lmul + 1, 0), a->rs1, 1);
+}
+
+static bool sf_int8_matmul_2x8x2_check(DisasContext *s, arg_rmrr *a)
+{
+    /*
+     * vd  has EMUL=LMUL
+     * vs2 has EMUL=LMUL
+     * vs1 has EMUL=1
+     * vd must not overlap vs1
+     */
+    return sf_int8_matmul_check(s, a) &&
+           (s->cfg_ptr->ext_xsfvqmaccdod) &&
+           require_align(a->rd, s->lmul) &&
+           require_align(a->rs2, s->lmul) &&
+           require_align(a->rs1, 0) &&
+           !is_overlapped(a->rd, 1 << MAX(s->lmul, 0), a->rs1, 1);
+}
+
+static bool sf_int8_matmul_op(DisasContext *s, arg_rmrr *a, uint8_t seq)
+{
+    static gen_helper_gvec_3_ptr * const fns[8] = {
+        gen_helper_sf_vqmaccu_4x8x4, gen_helper_sf_vqmacc_4x8x4,
+        gen_helper_sf_vqmaccus_4x8x4, gen_helper_sf_vqmaccsu_4x8x4,
+        gen_helper_sf_vqmaccu_2x8x2, gen_helper_sf_vqmacc_2x8x2,
+        gen_helper_sf_vqmaccus_2x8x2, gen_helper_sf_vqmaccsu_2x8x2,
+    };
+
+    /*
+     * The helper raises an illegal-instruction exception when vl is not a
+     * multiple of the tile size; save the opcode so mtval/stval report the
+     * faulting instruction if that exception is thrown.
+     */
+    decode_save_opc(s, 0);
+
+    tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
+                       vreg_ofs(s, a->rs2), tcg_env,
+                       s->cfg_ptr->vlenb, s->cfg_ptr->vlenb, 0, fns[seq]);
+
+    finalize_rvv_inst(s);
+
+    return true;
+}
+
+#define GEN_SF_INT8_MATMUL_TRANS(NAME, CHECK, SEQ)       \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)   \
+{                                                        \
+    if (CHECK(s, a)) {                                   \
+        return sf_int8_matmul_op(s, a, SEQ);             \
+    }                                                    \
+    return false;                                        \
+}
+
+GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccu_4x8x4,  sf_int8_matmul_4x8x4_check, 0)
+GEN_SF_INT8_MATMUL_TRANS(sf_vqmacc_4x8x4,   sf_int8_matmul_4x8x4_check, 1)
+GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccus_4x8x4, sf_int8_matmul_4x8x4_check, 2)
+GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccsu_4x8x4, sf_int8_matmul_4x8x4_check, 3)
+GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccu_2x8x2,  sf_int8_matmul_2x8x2_check, 4)
+GEN_SF_INT8_MATMUL_TRANS(sf_vqmacc_2x8x2,   sf_int8_matmul_2x8x2_check, 5)
+GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccus_2x8x2, sf_int8_matmul_2x8x2_check, 6)
+GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccsu_2x8x2, sf_int8_matmul_2x8x2_check, 7)
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index e1b51d2bd4..da1df1e74e 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -6,6 +6,7 @@ gen = [
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decode=decode_XVentanaCodeOps'),
   decodetree.process('xmips.decode', extra_args: '--static-decode=decode_xmips'),
   decodetree.process('xlrbr.decode', extra_args: '--static-decode=decode_xlrbr'),
+  decodetree.process('xsf.decode', extra_args: '--static-decode=decode_xsf'),
 ]
 
 riscv_ss = ss.source_set()
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index a05ab642f4..86805b30cb 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -15,6 +15,7 @@ riscv_ss.add(files(
   'vcrypto_helper.c',
   'vector_helper.c',
   'vector_internals.c',
+  'xsf_helper.c',
   'zce_helper.c'))
 
 
-- 
2.55.0


