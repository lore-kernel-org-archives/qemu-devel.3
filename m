Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981B71098785
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3a8F-0001TK-Cv; Fri, 20 Mar 2026 09:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1w3a83-0001Qw-NU
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:43:09 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1w3a80-0006o7-3Q
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:43:07 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso17115415e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1774014183; x=1774618983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jltOJOUiU/+47xOvfUBsxQgNYTmPqF3ZhBjDKaNASgA=;
 b=QE8KSWjF+XJoJvEZLUATqET+3G08pOudgwcjt8xuSWqCpQft7Pr61VyCubSjq8Ubr9
 PEldcHyZt5ToFXwXnydz4hlA4yetZ5NYeZvEF/k0FKaoNrv2VYK3ya0wvsQG3zivjirC
 g6TSfdqwvzVKGwchMuQqv0TSKaRV0utHB/9nBWOsdBKy/sgBF6wv5PenT2/CoSiIUfOy
 5wrXmccTGnJ+d33GmFS1G+N6Tz2D3LxsTEm0iPCwk9I8qbHll+oZ2uGlPODq4cPLNhJ+
 KRovXP2ysWIAQF7zjmmPSFmQ8wxbXrF0EOTS4ev5JYRPcfACyM0IJbRKJnAzgNCH6mYS
 hEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774014183; x=1774618983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jltOJOUiU/+47xOvfUBsxQgNYTmPqF3ZhBjDKaNASgA=;
 b=TVYI/eQa4pT1yqhTeBWOe/9GCw3X2cufD0GHnX9XPlSDrh7I3kpEW0kee30cQjjI8/
 8LfxAG/WvCXSQqSm5Wkb8pVMo2uTN6kCuWz6DV1hdVSg40uWucDrmbFYl+3LpOSYzvui
 PCnB929lWcdE+DM4FbpWZLjdIQtYVf80vLB4w6gJZYgSzGSdPd/ZJLNA7QuvZ3qEMdF2
 JM1M2YsJSwP4hGnXgjcZ0CwpJXVPikh8UbunZW7f+zO7CuynDT1STF0pZUNrt8OcjfV2
 KgLYZZ16RGBjcTD8hObOt7K1VrF7dpYuLHriT5KgKQ0Qa+QrlzsqAuOlOqTascKB4U2H
 2gIg==
X-Gm-Message-State: AOJu0YzE/5q5q0UoO1CAmI8r5V9EjtGeANPpja8ok3N1acby2XqxWgOV
 CDw2eMuHpG0gBGS772fduH11YGUAi1j9wnf7BHHHpipqIOzoDbnfPT73UXTv5Fc1Qq0=
X-Gm-Gg: ATEYQzywYWA/M2dcP42MDx2ADx9iMAB6raRwrkjuNaoXAURo0vCfwvbNN/GZCD8Y9mX
 TXuj3xU1HwT2dVnTLCTDeA50zNTq/G7a0Ip2wrEHUiiUgei0Ke6USa9+TrrjqVVlLapBBWBiM+N
 HEOSC8kxYqk9OFrGi2hjgBMosOAoJvajqdM+gosGMESiEQvd9m3O7tMB327VNy8nPstNtfkmGoF
 xWAPi+l0o/r9bN2Rd0Uoir+bpDuiWGiUbUW3aT3ZyxDq9F9R/FAZqxS3o0N9R5ezlHD7J9lDPZI
 9xaYa7kBsSph1U49ygLHYuqtsQlKWRWnGoBfBXhzpMWsF/MV+O3gL5sYOo1dejlJm1rFZNbjEEG
 RXgDBh+AFozSe/ZJO82F2DG7LOn0Lyp/bo08PMbNfpUo7kKadRt88Xlfd6pBB3Eh/nxzQoaJDaY
 XMkI9yQo4zc44V8NHU2KK30slJ5E8tfMw2cNVFv1kddqoiquZCuf7EK6AsB5TDlOaTYZrISw/Dl
 DFDoW8NBqv0fFSnNhpx
X-Received: by 2002:a05:600c:4e02:b0:486:de04:5906 with SMTP id
 5b1f17b1804b1-486ff0271a7mr41909825e9.19.1774014182566; 
 Fri, 20 Mar 2026 06:43:02 -0700 (PDT)
Received: from jw-ThinkPad-T14-Gen-3.home (236.139.189.80.dyn.plus.net.
 [80.189.139.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe85ed6asm18328885e9.1.2026.03.20.06.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:43:02 -0700 (PDT)
From: James Wainwright <james.wainwright@lowrisc.org>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 Emmanuel Blot <eblot@rivosinc.com>,
 James Wainwright <james.wainwright@lowrisc.org>
Subject: [PATCH v5 2/3] target/riscv: add draft RISC-V Zbr ext as xbr0p93
Date: Fri, 20 Mar 2026 13:42:53 +0000
Message-ID: <20260320134254.217123-3-james.wainwright@lowrisc.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260320134254.217123-1-james.wainwright@lowrisc.org>
References: <20260320134254.217123-1-james.wainwright@lowrisc.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=james.wainwright@lowrisc.org; helo=mail-wm1-x32d.google.com
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

This extension was not ratified with the Zb[abcs] bitmanip extensions.
This is the latest draft version (0.93) as implemented by the Ibex core.

These instructions are in the reserved encoding space but have not been
ratified and could conflict with future ratified instructions. For this
reason they are added as a vendor extension to support Ibex's impl.

Signed-off-by: James Wainwright <james.wainwright@lowrisc.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                               |  3 ++
 target/riscv/bitmanip_helper.c            | 20 +++++++
 target/riscv/cpu.c                        |  4 +-
 target/riscv/cpu_cfg.h                    |  1 +
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/helper.h                     |  2 +
 target/riscv/insn_trans/trans_xlrbr.c.inc | 45 ++++++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 ++
 target/riscv/xlrbr.decode                 | 30 +++++++++++
 tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
 tests/tcg/riscv64/test-crc32.S            | 64 +++++++++++++++++++++++
 12 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 target/riscv/insn_trans/trans_xlrbr.c.inc
 create mode 100644 target/riscv/xlrbr.decode
 create mode 100644 tests/tcg/riscv64/test-crc32.S

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d1614fd7e..847fd414bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1725,6 +1725,9 @@ F: hw/riscv/opentitan.c
 F: hw/*/ibex_*.c
 F: include/hw/riscv/opentitan.h
 F: include/hw/*/ibex_*.h
+F: target/riscv/insn_trans/trans_xthead.c.inc
+F: target/riscv/xlrbr.decode
+F: tests/tcg/riscv64/test-crc32.S
 
 Microchip PolarFire SoC Icicle Kit
 L: qemu-riscv@nongnu.org
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
index e56470a374..22bab85288 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1370,6 +1370,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
     MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
+    MULTI_EXT_CFG_BOOL("xlrbr", ext_xlrbr, false),
 
     { },
 };
@@ -3056,7 +3057,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zba = true,
         .cfg.ext_zbb = true,
         .cfg.ext_zbc = true,
-        .cfg.ext_zbs = true
+        .cfg.ext_zbs = true,
+        .cfg.ext_xlrbr = true
     ),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index cd1cba797c..211d0708ba 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -69,5 +69,6 @@ MATERIALISE_EXT_PREDICATE(xtheadmemidx)
 MATERIALISE_EXT_PREDICATE(xtheadmempair)
 MATERIALISE_EXT_PREDICATE(xtheadsync)
 MATERIALISE_EXT_PREDICATE(XVentanaCondOps)
+MATERIALISE_EXT_PREDICATE(xlrbr);
 
 #endif
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 70ec650abf..7ded97534c 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -153,6 +153,7 @@ BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
 BOOL_FIELD(ext_xmipslsp)
+BOOL_FIELD(ext_xlrbr)
 
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
diff --git a/target/riscv/insn_trans/trans_xlrbr.c.inc b/target/riscv/insn_trans/trans_xlrbr.c.inc
new file mode 100644
index 0000000000..01da2b6ce1
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xlrbr.c.inc
@@ -0,0 +1,45 @@
+/*
+ * RISC-V translation routines for xlrbr matching the unratified Zbr CRC32
+ * bitmanip extension v0.93.
+ *
+ * Copyright (c) 2026 Rivos Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define REQUIRE_XLRBR(ctx) do {                    \
+    if (!ctx->cfg_ptr->ext_xlrbr) {                \
+        return false;                            \
+    }                                            \
+} while (0)
+
+static bool gen_crc(DisasContext *ctx, arg_r2 *a,
+                    void (*func)(TCGv, TCGv, TCGv), TCGv tsz)
+{
+    REQUIRE_XLRBR(ctx);
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
index 3842c7c1a8..79f36abd63 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -5,6 +5,7 @@ gen = [
   decodetree.process('xthead.decode', extra_args: '--static-decode=decode_xthead'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decode=decode_XVentanaCodeOps'),
   decodetree.process('xmips.decode', extra_args: '--static-decode=decode_xmips'),
+  decodetree.process('xlrbr.decode', extra_args: '--static-decode=decode_xlrbr'),
 ]
 
 riscv_ss = ss.source_set()
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index cb4f443601..9b05eb3695 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1213,9 +1213,11 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
 #include "decode-xmips.c.inc"
+#include "decode-xlrbr.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
 #include "insn_trans/trans_xmips.c.inc"
+#include "insn_trans/trans_xlrbr.c.inc"
 
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1235,6 +1237,7 @@ const RISCVDecoder decoder_table[] = {
     { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
+    { has_xlrbr_p, decode_xlrbr},
 };
 
 const size_t decoder_table_size = ARRAY_SIZE(decoder_table);
diff --git a/target/riscv/xlrbr.decode b/target/riscv/xlrbr.decode
new file mode 100644
index 0000000000..893ce6ec71
--- /dev/null
+++ b/target/riscv/xlrbr.decode
@@ -0,0 +1,30 @@
+#
+# Translation routines for the instructions of the xlrbr ISA extension
+# (matching the draft encodings in the standard reserved encoding space for the
+# unratified Zbr CRC32 bitmanip extension version 0.93).
+#
+# Copyright (c) 2026 Rivos Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
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
+# *** RV32 xlrbr extension ***
+crc32_b    0110000  10000 ..... 001 ..... 0010011 @r2
+crc32_h    0110000  10001 ..... 001 ..... 0010011 @r2
+crc32_w    0110000  10010 ..... 001 ..... 0010011 @r2
+crc32c_b   0110000  11000 ..... 001 ..... 0010011 @r2
+crc32c_h   0110000  11001 ..... 001 ..... 0010011 @r2
+crc32c_w   0110000  11010 ..... 001 ..... 0010011 @r2
+
+# *** RV64 xlrbr extension (in addition to RV32) ***
+crc32_d    0110000  10011 ..... 001 ..... 0010011 @r2
+crc32c_d   0110000  11011 ..... 001 ..... 0010011 @r2
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index eb1ce6504a..82be8a2c91 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -36,5 +36,10 @@ run-plugin-interruptedmemory: interruptedmemory
 	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
 	  $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-crc32
+comma:= ,
+run-test-crc32: test-crc32
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
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


