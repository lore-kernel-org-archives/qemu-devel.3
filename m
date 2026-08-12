Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7290AC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuD0b-0002zk-OF; Wed, 12 Aug 2026 13:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wuD0N-0002sL-OW
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 13:44:45 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wuD0J-0007ds-L8
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 13:44:43 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso1435293a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 10:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1786556678; x=1787161478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bOfQP/P1K7kFj3ubNy1v4DdxRk8JtgxA6LtLrm9P4BM=;
 b=bS4+I2iW1PEM4wvMCtaFgIqMdv3ir5W3+rerQNaHT/WVChD0L3D3WT7WPn856eZA/L
 B+EjUg21dsEK7g72TEyzyEjRM+kUb0mtY9HON9AsqQMQdapWjJyHT1wQmzamSGCmF9OF
 j9pr+TAGsMgSAvY0GYq5ZLZvGPlfxNmt9Vj1ZYMuLfjt6P9AKsQtsHPVAlURhdxa5yeZ
 7woDQMATTB6UlBosoF0DptuhkMLGH11orJC8DIWshJy8NG0pMJ84ocvmde4PVyF6jXMi
 ra4KqvAeCBFwYv66jiI5dkUi8tbALxT4wyjFVvKkLJ+rbkqHMsYEPE3EUrFikrMKozZm
 MjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786556678; x=1787161478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bOfQP/P1K7kFj3ubNy1v4DdxRk8JtgxA6LtLrm9P4BM=;
 b=OjpS3HLWMNAOVlKTw0E+NVPjQtKarILVVVomPM+6jHG/UMeMG8IfbqkK0Bdkz++i2s
 dPOpmtyhdStRkd9ZnqziMTUHsiQlUaFFfRHx7m4QjRkBNccoZYxY73MqBacC4/e/VM4B
 lXVWtgsixlqGt/UvCJkfbcQ+YnhYUZo1Vj5/+u5Oz4kFt361ywb2krc4PRNFfAgxw4lP
 V8gLSssE0j4vMrwJLBPDekxHJe1sia7tzr3WvDjmJtUL4z4+P1D4tgtimI7AgGRCluXj
 Wl9ZfBwLfnzZZsHCLgdaiQZZc2jWay95R7mmy4vpWTXpYBBTdfU2JQSn18y54VBL1CCb
 wl4A==
X-Gm-Message-State: AOJu0YywYRL50uFJGeiaaRe06Gv8rwfqQUG0tjnJwikNTTh2wJbQtgDD
 AElNDNjyiGcsaTIYWvyn2veIicUSXCYIEjNSyGfNbNOuVV0OiiSo6Fs3YVXgF0NaHrM4q/tpsts
 O1RjwjRziDHCC47hf8DWDW+UzTSvejBKrXL5FexJeHsZGgPeXPCGQ+I8JIL+edEj30gmh2moUGb
 tC5maGLZMSR9Q/MDfrcX87gtwOd6HVRf48HQX6zIs=
X-Gm-Gg: AR+sD11uPn6xXhX8Hbxq8BLvb68j9wmHcZJlv/+oJbQLhmb3rthRUeQr2z6lL+A01yE
 mxL+/ARqFH9K6IbbQOg3XpdehjKZAXEfyXBOm7hJQ3oY6ct8i5WsLQNFPRb6+PwCxxbl5fPaEwl
 hxxfBsk4RxANgbS3W45vUWAz09/qeTUKCYQH8SrHnmRz47kEMT1OhhQQFGLtKBNChlqbpbiLx0j
 pp/XvFT7aSw2ZSSutKZcPSy6m4cgeudq+M1v3Gn6w4ULEQVW9/9n53vRuHz9AswH6fvfVHAboKm
 OOcECOj6mbr+IPAAwpxnh9QcTbaWYbojGU6KqTvtwveZUnsQaxCJfB0tPbguUDiKHCuJ1kepton
 AFYj7Xhew4zQjZNBKYFrt/Zqz60k8ubpWREE87rm5NdAYxZNPWlJtYA0qPggo4L8mhMVjPSXc9k
 ldQrD8oUTTeBQvF5n0E6ibRPhUt/cJ0qW3+uBvkAAOH5hp0YdP6ndZ+E1eUYPPXZcLHB0gAHUXR
 B/Azxou8EQCjk+8Ul3ilg5OE9YWOSrper1118liJ2yA86goo5cmCTr9KyCygMFO
X-Received: by 2002:a17:90b:3907:b0:381:a766:efcc with SMTP id
 98e67ed59e1d1-393014f6cc9mr7170205a91.14.1786556677945; 
 Wed, 12 Aug 2026 10:44:37 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931db13c3bsm13210a91.3.2026.08.12.10.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 10:44:37 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Chou <max.chou@sifive.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 4/6] target/riscv: rvv: Add SiFive custom int8 matmul
 instructions
Date: Thu, 13 Aug 2026 01:44:14 +0800
Message-ID: <20260812174417.2468981-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812174417.2468981-1-max.chou@sifive.com>
References: <20260812174417.2468981-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1029.google.com
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
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 MAINTAINERS                                 |  8 ++
 target/riscv/cpu_cfg.h                      |  5 ++
 target/riscv/helper.h                       | 10 +++
 target/riscv/meson.build                    |  1 +
 target/riscv/tcg/insn_trans/trans_xsf.c.inc | 98 +++++++++++++++++++++
 target/riscv/tcg/meson.build                |  1 +
 target/riscv/tcg/translate.c                |  3 +
 target/riscv/tcg/xsf_helper.c               | 87 ++++++++++++++++++
 target/riscv/xsf.decode                     | 30 +++++++
 9 files changed, 243 insertions(+)
 create mode 100644 target/riscv/tcg/insn_trans/trans_xsf.c.inc
 create mode 100644 target/riscv/tcg/xsf_helper.c
 create mode 100644 target/riscv/xsf.decode

diff --git a/MAINTAINERS b/MAINTAINERS
index 902db77218e..9c9f9bd645a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -391,6 +391,14 @@ F: target/riscv/XVentanaCondOps.decode
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
index 211d0708ba4..d6db1cfb7cc 100644
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
index 542b7c264fc..4234f462716 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1358,3 +1358,13 @@ DEF_HELPER_1(ssamoswap_disabled, void, env)
 
 /* Zalrsc SC write probe */
 DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
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
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 42d0f6d538a..c06526adb26 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -6,6 +6,7 @@ gen = [
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decode=decode_XVentanaCodeOps'),
   decodetree.process('xmips.decode', extra_args: '--static-decode=decode_xmips'),
   decodetree.process('xlrbr.decode', extra_args: '--static-decode=decode_xlrbr'),
+  decodetree.process('xsf.decode', extra_args: '--static-decode=decode_xsf'),
 ]
 
 riscv_ss = ss.source_set()
diff --git a/target/riscv/tcg/insn_trans/trans_xsf.c.inc b/target/riscv/tcg/insn_trans/trans_xsf.c.inc
new file mode 100644
index 00000000000..1677352689f
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
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index a05ab642f41..86805b30cbc 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -15,6 +15,7 @@ riscv_ss.add(files(
   'vcrypto_helper.c',
   'vector_helper.c',
   'vector_internals.c',
+  'xsf_helper.c',
   'zce_helper.c'))
 
 
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index 9684dbe7528..41e3dd2fe21 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -1216,10 +1216,12 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
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
@@ -1240,6 +1242,7 @@ const RISCVDecoder decoder_table[] = {
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
     { has_xlrbr_p, decode_xlrbr},
+    { has_xsf_p, decode_xsf },
 };
 
 const size_t decoder_table_size = ARRAY_SIZE(decoder_table);
diff --git a/target/riscv/tcg/xsf_helper.c b/target/riscv/tcg/xsf_helper.c
new file mode 100644
index 00000000000..6e953d12493
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
diff --git a/target/riscv/xsf.decode b/target/riscv/xsf.decode
new file mode 100644
index 00000000000..bb585046ab1
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
-- 
2.43.0


