Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084CDEB1049
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzubP-0007OW-4R; Tue, 10 Mar 2026 06:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vzubL-0007MM-Gq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vzubI-0005rf-Ei
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:11 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439d8dc4ae4so2604995f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1773139567; x=1773744367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ZS3AXJHktWWvwO3kycTiD2AM9NjiR6+eRDuwHc95Bs=;
 b=joE9NYBzLOfrqM53IirzUJ16fn/HzYjxVCFDPaebJxJcUVF4M2Uct5lwQVyWu/rGo0
 VuZGqi6nlV6vzrRe7WEketmfcP4qr0vpaDiMrGYZgLuwoiJ9MqXQ8CqoJqlUXLcQ1YJS
 zFHmBuOhV2xnfsBUWXgZS0CdBYn49h4rim2z9+Mu8KDljswdBhgteLxxrsMgcmpNMply
 CYbVQDWR8VZ5eLaSCeellehP4JsV4DoDjHwG/iEEHHuZ6jdVZYqOasEpYxxnNn59bL7N
 o55P8lcWKTdHBuVlLi1I9NKNFFBGynjO5yqpXI/dop/tdOi48o7k8/R0Gn6dfzCgcIOg
 mIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139567; x=1773744367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ZS3AXJHktWWvwO3kycTiD2AM9NjiR6+eRDuwHc95Bs=;
 b=bSdouFCXoj/t0m7sim295Coha1sx3m69/S4Vm0BBh3wP9OQBy8id/ldPBpW1luX+BR
 chhYyN9fVCv1qLKKAeacbpN1mkemVTKs3xn6zg87fBaxjd7q7/Rkjxee3Pa5ER+l5bfT
 qG/yUxN+RYlFCL3Pa/3yKbzzfyHaTUEmC1kZOOeHBm16RPjWjJOvwjMB/5HPwtSCihpB
 whkCtFquHJ7xv5WmOOe6dFzkc/i2by4sf/b115JpOLdFawnK5jMAnoH3E5ZVrmiDIWJs
 EAkyiLLkYEGN/NFDMRjyNxoPgG6GqH+XOA0y0f/nlNjSdqzM+gzegagcERpEBHNSgaoa
 UfZQ==
X-Gm-Message-State: AOJu0Yz0Qho/p96vW4MXhjfhk7GbpuDqT1xKqG8ArbiUjqw5A2qMmEaL
 jHC6nGdSkmZmocYlcloN12PpbaGe/Jxjy6naPQzYmAMDXRn5BeD4AqeZkUB/ktdfXjw=
X-Gm-Gg: ATEYQzyTLNb/kw7+4EHczVC5V9Ji4i3HkPINTXd/o601M5iBVac6ynABR2rJTxRDYwC
 oXGPX2Uyryxb1o8VS/mZ8rajXHRwL5L7H94PuRNfDcvyeMt4ZLk3lZ9BDOH5tG5N+XmEbXt9OOU
 nZieFWNkTUUTY0HFjZWe4FV9Qtx9oD2GrF269y0Tl3JGcYm8nblKbH8MQamcRJrn3UjlgUuRmW1
 jnzqOAGnWV3lkK6zWYZ7j0okKrAGDNaXPyLz00olXdlkjCKirolNMnzr92biwzmz5Ds7/6nhc3W
 JqhelnqX3CSVtq0PDN7/kBA7JnZKikeU15jU6UsBKqszJMqdCgXbZmfnm8DpOGtzE56+wIl6GMc
 AqJyxTXZIKzdZ744qxeQuab5RQ7G/gio/tFTOdILdhqwk9ODeCo5ZHjL09Y6xfdYizqy10YEBPA
 9kJNqtFLet7BnAkuaGTadczJptxTzXj1HuGbrT373CyYRfK25Iw36KD5fNRZyqPPaNG+KCNrrAQ
 juM6YWf7J6uP5z+/+zF
X-Received: by 2002:a05:6000:186e:b0:439:b65a:fd30 with SMTP id
 ffacd0b85a97d-439da87bddcmr26329282f8f.57.1773139566700; 
 Tue, 10 Mar 2026 03:46:06 -0700 (PDT)
Received: from jw-ThinkPad-T14-Gen-3.home (128.70.159.143.dyn.plus.net.
 [143.159.70.128]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadb29fdsm34838715f8f.16.2026.03.10.03.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 03:46:06 -0700 (PDT)
From: James Wainwright <james.wainwright@lowrisc.org>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 Emmanuel Blot <eblot@rivosinc.com>,
 James Wainwright <james.wainwright@lowrisc.org>
Subject: [PATCH v2 2/3] target/riscv: add draft RISC-V Zbr ext as xbr0p93
Date: Tue, 10 Mar 2026 10:45:57 +0000
Message-ID: <20260310104558.52838-3-james.wainwright@lowrisc.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260310104558.52838-1-james.wainwright@lowrisc.org>
References: <20260310104558.52838-1-james.wainwright@lowrisc.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=james.wainwright@lowrisc.org; helo=mail-wr1-x431.google.com
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

This extension was not ratified with the Zb[abcs] bitmanip extensions.
This is the latest draft version (0.93) as implemented by the Ibex core.

These instructions are in the reserved encoding space but have not been
ratified and could conflict with future ratified instructions. For this
reason they are added as a vendor extension to support Ibex's impl.

Signed-off-by: James Wainwright <james.wainwright@lowrisc.org>
---
 target/riscv/bitmanip_helper.c              | 20 +++++++
 target/riscv/cpu.c                          |  4 +-
 target/riscv/cpu_cfg.h                      |  1 +
 target/riscv/cpu_cfg_fields.h.inc           |  1 +
 target/riscv/helper.h                       |  2 +
 target/riscv/insn_trans/trans_xbr0p93.c.inc | 55 ++++++++++++++++++
 target/riscv/meson.build                    |  1 +
 target/riscv/translate.c                    |  3 +
 target/riscv/xbr0p93.decode                 | 42 ++++++++++++++
 tests/tcg/riscv64/Makefile.softmmu-target   |  5 ++
 tests/tcg/riscv64/test-crc32.S              | 64 +++++++++++++++++++++
 11 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 target/riscv/insn_trans/trans_xbr0p93.c.inc
 create mode 100644 target/riscv/xbr0p93.decode
 create mode 100644 tests/tcg/riscv64/test-crc32.S

diff --git a/target/riscv/bitmanip_helper.c b/target/riscv/bitmanip_helper.c
index e9c8d7f778..1156a87dd3 100644
--- a/target/riscv/bitmanip_helper.c
+++ b/target/riscv/bitmanip_helper.c
@@ -23,6 +23,8 @@
 #include "exec/target_long.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg.h"
+#include "qemu/crc32.h"
+#include "qemu/crc32c.h"
 
 target_ulong HELPER(clmul)(target_ulong rs1, target_ulong rs2)
 {
@@ -129,3 +131,21 @@ target_ulong HELPER(xperm8)(target_ulong rs1, target_ulong rs2)
 {
     return do_xperm(rs1, rs2, 3);
 }
+
+target_ulong HELPER(crc32)(target_ulong rs1, target_ulong sz)
+{
+    for (target_ulong i = 0; i < sz; i++) {
+        rs1 = crc32_table[rs1 & 0xFF] ^ (rs1 >> 8);
+    }
+
+    return rs1;
+}
+
+target_ulong HELPER(crc32c)(target_ulong rs1, target_ulong sz)
+{
+    for (target_ulong i = 0; i < sz; i++) {
+        rs1 = crc32c_table[rs1 & 0xFF] ^ (rs1 >> 8);
+    }
+
+    return rs1;
+}
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e56470a374..025ff79b7d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1370,6 +1370,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
     MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
+    MULTI_EXT_CFG_BOOL("xbr0p93", ext_xbr0p93, false),
 
     { },
 };
@@ -3056,7 +3057,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zba = true,
         .cfg.ext_zbb = true,
         .cfg.ext_zbc = true,
-        .cfg.ext_zbs = true
+        .cfg.ext_zbs = true,
+        .cfg.ext_xbr0p93 = true
     ),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index cd1cba797c..5e7ad0300f 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -69,5 +69,6 @@ MATERIALISE_EXT_PREDICATE(xtheadmemidx)
 MATERIALISE_EXT_PREDICATE(xtheadmempair)
 MATERIALISE_EXT_PREDICATE(xtheadsync)
 MATERIALISE_EXT_PREDICATE(XVentanaCondOps)
+MATERIALISE_EXT_PREDICATE(xbr0p93);
 
 #endif
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 70ec650abf..573ca70739 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -153,6 +153,7 @@ BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
 BOOL_FIELD(ext_xmipslsp)
+BOOL_FIELD(ext_xbr0p93)
 
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b785456ee0..7722c590bd 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -84,6 +84,8 @@ DEF_HELPER_FLAGS_1(unzip, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(zip, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(xperm4, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 DEF_HELPER_FLAGS_2(xperm8, TCG_CALL_NO_RWG_SE, tl, tl, tl)
+DEF_HELPER_FLAGS_2(crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl)
+DEF_HELPER_FLAGS_2(crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 
 /* Floating Point - Half Precision */
 DEF_HELPER_FLAGS_3(fadd_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
diff --git a/target/riscv/insn_trans/trans_xbr0p93.c.inc b/target/riscv/insn_trans/trans_xbr0p93.c.inc
new file mode 100644
index 0000000000..a79cceaba6
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xbr0p93.c.inc
@@ -0,0 +1,55 @@
+/*
+ * RISC-V translation routines for  xbr0p93 matching the unratified Zbr CRC32
+ * bitmanip extension v0.93.
+ *
+ * Copyright (c) 2026 Rivos Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define REQUIRE_XBR0P93(ctx) do {                    \
+    if (!ctx->cfg_ptr->ext_xbr0p93) {                \
+        return false;                            \
+    }                                            \
+} while (0)
+
+static bool gen_crc(DisasContext *ctx, arg_r2 *a,
+                    void (*func)(TCGv, TCGv, TCGv), TCGv tsz)
+{
+    REQUIRE_XBR0P93(ctx);
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);
+
+    func(dest, src1, tsz);
+    gen_set_gpr(ctx, a->rd, dest);
+
+    return true;
+}
+
+#define TRANS_CRC32(NAME, SIZE) \
+    static bool trans_crc32_##NAME(DisasContext *ctx, arg_r2 *a) \
+    { if (SIZE == 8) { REQUIRE_64BIT(ctx); }; \
+      return gen_crc(ctx, a, gen_helper_crc32, tcg_constant_tl(SIZE)); }
+#define TRANS_CRC32C(NAME, SIZE) \
+    static bool trans_crc32c_##NAME(DisasContext *ctx, arg_r2 *a) \
+    { if (SIZE == 8) { REQUIRE_64BIT(ctx); }; \
+      return gen_crc(ctx, a, gen_helper_crc32c, tcg_constant_tl(SIZE)); }
+
+TRANS_CRC32(b, 1);
+TRANS_CRC32(h, 2);
+TRANS_CRC32(w, 4);
+TRANS_CRC32(d, 8);
+TRANS_CRC32C(b, 1);
+TRANS_CRC32C(h, 2);
+TRANS_CRC32C(w, 4);
+TRANS_CRC32C(d, 8);
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 3842c7c1a8..7d19a605ef 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -5,6 +5,7 @@ gen = [
   decodetree.process('xthead.decode', extra_args: '--static-decode=decode_xthead'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decode=decode_XVentanaCodeOps'),
   decodetree.process('xmips.decode', extra_args: '--static-decode=decode_xmips'),
+  decodetree.process('xbr0p93.decode', extra_args: '--static-decode=decode_xbr0p93'),
 ]
 
 riscv_ss = ss.source_set()
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index cb4f443601..05a6916f17 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1213,9 +1213,11 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
 #include "decode-xmips.c.inc"
+#include "decode-xbr0p93.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
 #include "insn_trans/trans_xmips.c.inc"
+#include "insn_trans/trans_xbr0p93.c.inc"
 
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1235,6 +1237,7 @@ const RISCVDecoder decoder_table[] = {
     { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
+    { has_xbr0p93_p, decode_xbr0p93},
 };
 
 const size_t decoder_table_size = ARRAY_SIZE(decoder_table);
diff --git a/target/riscv/xbr0p93.decode b/target/riscv/xbr0p93.decode
new file mode 100644
index 0000000000..8dafb86db6
--- /dev/null
+++ b/target/riscv/xbr0p93.decode
@@ -0,0 +1,42 @@
+#
+# Translation routines for the instructions of the xbr0p93 ISA extension
+# (matching the draft encodings in the standard reserved encoding space for the
+# unratified Zbr CRC32 bitmanip extension version 0.93).
+#
+# Copyright (c) 2026 Rivos Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms and conditions of the GNU General Public License,
+# version 2 or later, as published by the Free Software Foundation.
+#
+# This program is distributed in the hope it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+# more details.
+#
+# You should have received a copy of the GNU General Public License along with
+# this program.  If not, see <http://www.gnu.org/licenses/>.
+
+# Fields:
+%rs1       15:5
+%rd        7:5
+
+# Argument sets:
+&r2        rd rs1                                 !extern
+
+# Formats 32:
+@r2        .......  ..... ..... ... ..... ....... &r2 %rs1 %rd
+
+# *** RV32 xbr0p93 extension ***
+crc32_b    0110000  10000 ..... 001 ..... 0010011 @r2
+crc32_h    0110000  10001 ..... 001 ..... 0010011 @r2
+crc32_w    0110000  10010 ..... 001 ..... 0010011 @r2
+crc32c_b   0110000  11000 ..... 001 ..... 0010011 @r2
+crc32c_h   0110000  11001 ..... 001 ..... 0010011 @r2
+crc32c_w   0110000  11010 ..... 001 ..... 0010011 @r2
+
+# *** RV64 xbr0p93 extension (in addition to RV32) ***
+crc32_d    0110000  10011 ..... 001 ..... 0010011 @r2
+crc32c_d   0110000  11011 ..... 001 ..... 0010011 @r2
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index eb1ce6504a..2328af3746 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -36,5 +36,10 @@ run-plugin-interruptedmemory: interruptedmemory
 	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
 	  $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-crc32
+comma:= ,
+run-test-crc32: test-crc32
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xbr0p93=true $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-crc32.S b/tests/tcg/riscv64/test-crc32.S
new file mode 100644
index 0000000000..70d70b16a9
--- /dev/null
+++ b/tests/tcg/riscv64/test-crc32.S
@@ -0,0 +1,64 @@
+/*
+ * Copyright (c) 2026 lowRISC CIC
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define crc32(op, rd, rs1) .insn r 19, 1, 48, rd, rs1, x##op
+
+#define crc32_b(rd, rs1) crc32(16, rd, rs1)
+#define crc32_h(rd, rs1) crc32(17, rd, rs1)
+#define crc32_w(rd, rs1) crc32(18, rd, rs1)
+#define crc32_d(rd, rs1) crc32(19, rd, rs1)
+#define crc32c_b(rd, rs1) crc32(24, rd, rs1)
+#define crc32c_h(rd, rs1) crc32(25, rd, rs1)
+#define crc32c_w(rd, rs1) crc32(26, rd, rs1)
+#define crc32c_d(rd, rs1) crc32(27, rd, rs1)
+
+	.option norvc
+
+	.text
+	.globl _start
+_start:
+	lla t0, trap
+	csrw mtvec, t0
+
+	li	t0, 0x34e24a2cd65650d4
+
+	crc32_b 	(t0, t0)
+	crc32_h 	(t0, t0)
+	crc32_w 	(t0, t0)
+	crc32_d 	(t0, t0)
+	crc32c_b	(t0, t0)
+	crc32c_h	(t0, t0)
+	crc32c_w	(t0, t0)
+	crc32c_d	(t0, t0)
+
+	li	t1, 0x68167e78
+
+	li	a0, 0
+	beq	t0, t1, _exit
+fail:
+	li	a0, 1
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	# ADP_Stopped_ApplicationExit
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	# TARGET_SYS_EXIT_EXTENDED
+
+	# Semihosting call sequence
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
+
+trap:
+	csrr t0, mepc
+	addi t0, t0, 4
+	mret
-- 
2.48.1


