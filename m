Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06747EF8FEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmv3-0002Gy-U0; Wed, 04 Mar 2026 09:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vxl4W-00041z-7s
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 07:11:24 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vxl4S-0005yo-2b
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 07:11:23 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439c9bdc241so348143f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 04:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1772626278; x=1773231078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gd2joM6rY/li7wvdJlP/PMgv1E2ePvup/TViSbVH7sg=;
 b=Cq830qF1+u1DlRYC7I6sZ2p9POW30egMJyBRAMbMMsfKNVEeMp3csIv2qREDiYQGzK
 faf4TITuZhx9ChhWV6a84GdLWWNBHqmd9eA8GeG4wktz6BPy4dunX/IdKVb56KT8SJEj
 O13I6Cd5o+El3St9A5Damuu2v4Tmudwv8SCeVhfVqZ78cW66MaVPabGF2edD1fS24Jwa
 N5aKSYwQdluIaTFjaSp/OMBmEWZiA/RG0ykSGFx3AAxt/AmpisE5k7ESAzpyLFCFfh06
 jxpY5AYWmk8lnnUmi+cUPl4+C+cFQOG7h0Q3W+/1a7STzfSIQ6Aa4m3ctQ7vuN5jQzEh
 yHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772626278; x=1773231078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gd2joM6rY/li7wvdJlP/PMgv1E2ePvup/TViSbVH7sg=;
 b=vLzyWKOVSYcqa4p3EkFWJV1cUoj2hrnzWvenaz1KRMRG1Z43joc2PuQwgjps2ER02q
 mou0aXcrvsXCWt3rSKhu3xdlKmEPr8RMbrdm5pu6VmOtEue38GPgjNxmd0FUXg+mu2Ar
 5C5QcX3BxxEaQ0Od6zOP0f9DBvr+4c6S6N8VlsgV1T+P16wR3ar4Mf2TEOCU+698R7oF
 SFpqFVX2y1nyr5/Jnjx9RR9jV4GyTICQTNwBivCegUWU8di7xA2rhdF6xyazzNHudb7/
 uUUhiirxgppUf59+byHODIXSazwsijarKN2O3osoreXLxTWB7GGNPzX63LQrXeffkjct
 CUeQ==
X-Gm-Message-State: AOJu0YzFv9YZUPVfR799XtLcVs6SBH414wTbdHxvnK0uJxHoRkPJADty
 b51d/GcHA88GgWMIF1jbAQQgDYZAokjQcGjtKiRbTa4gjbzmIA90kUpnKQeERnrRAXzGs9hQtJJ
 fupw+hxk=
X-Gm-Gg: ATEYQzw3TyZyi3OB7stMVkOwA8LoTRO1iTl3yScgm/BiP330Ts5Ry5nbeFI8h9iVdE5
 dX2OzHECRMQnsYsjTeJV9oIgD8l8A/f4q/4wGMxTPiaambco5nAaFtf9WZKEaWBOuDPFJN52PiB
 0VbRWKoQ+u6pxUaKnIpko96gIRIm0BOefY/fXQGXbrj01Snl1/Fbi8SS7Kf45uIw4gbjGFLxzMX
 K4HC0cTV6khrPk3QHzAWqsKU+VjoOZv+7gZZmdoGSGnPwgalA3r1Twm0eAVLVB1GoInI7IsvUeW
 v9KcnCGB/1OjgdIa76LJxkxVMevUWFq/bvNyCt96sQdljagdy2SjSvHs2zITpPrg2CYNPvrxF9T
 PUfhjoeAm4wIubo3CrMPbydRXZg0D5YCqHxn/ocEvgne8EDzaHbGZjY+0Kj0ioQqwaKdefvVAId
 aAX2rXav1UlvHHFJA49EClZ1Z6FkmSjjf+JCW/zkVDuLh+++16Ml2ToOdFekotJNZrneow2ef6Q
 UVoe6PIQ5s5oX19yTen
X-Received: by 2002:a05:6000:1861:b0:436:1a2e:9f1c with SMTP id
 ffacd0b85a97d-439c7fa4521mr3360041f8f.19.1772626278291; 
 Wed, 04 Mar 2026 04:11:18 -0800 (PST)
Received: from jw-ThinkPad-T14-Gen-3.home (128.70.159.143.dyn.plus.net.
 [143.159.70.128]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b0549600sm28217570f8f.35.2026.03.04.04.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 04:11:17 -0800 (PST)
From: James Wainwright <james.wainwright@lowrisc.org>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 James Wainwright <james.wainwright@lowrisc.org>
Subject: [PATCH 2/3] target/riscv: add unratified RISC-V Zbr0p93 ext
Date: Wed,  4 Mar 2026 12:11:12 +0000
Message-ID: <20260304121113.117299-3-james.wainwright@lowrisc.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260304121113.117299-1-james.wainwright@lowrisc.org>
References: <20260304121113.117299-1-james.wainwright@lowrisc.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=james.wainwright@lowrisc.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This extension was not ratified with the Zb[abcs] bitmanip extensions.
This is the latest draft version (0.93) as implemented by the Ibex core.

These instructions are in the reserved encoding space but have not been
ratified and could conflict with future ratified instructions.

Signed-off-by: James Wainwright <james.wainwright@lowrisc.org>
---
 target/riscv/bitmanip_helper.c            | 20 +++++++
 target/riscv/cpu.c                        |  4 +-
 target/riscv/cpu_cfg.h                    |  3 ++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/helper.h                     |  2 +
 target/riscv/insn32.decode                | 12 +++++
 target/riscv/insn_trans/trans_rvb.c.inc   | 37 +++++++++++++
 tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
 tests/tcg/riscv64/test-crc32.S            | 64 +++++++++++++++++++++++
 9 files changed, 147 insertions(+), 1 deletion(-)
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
index e56470a374..b83efb210e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1377,6 +1377,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
+    MULTI_EXT_CFG_BOOL("x-zbr", ext_zbr, false),
 
     { },
 };
@@ -3056,7 +3057,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zba = true,
         .cfg.ext_zbb = true,
         .cfg.ext_zbc = true,
-        .cfg.ext_zbs = true
+        .cfg.ext_zbs = true,
+        .cfg.ext_zbr = true
     ),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index cd1cba797c..2f18d16de2 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -70,4 +70,7 @@ MATERIALISE_EXT_PREDICATE(xtheadmempair)
 MATERIALISE_EXT_PREDICATE(xtheadsync)
 MATERIALISE_EXT_PREDICATE(XVentanaCondOps)
 
+/* Extensions that are not yet upstream */
+MATERIALISE_EXT_PREDICATE(zbr);
+
 #endif
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 70ec650abf..38cb512010 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -11,6 +11,7 @@ BOOL_FIELD(ext_zbc)
 BOOL_FIELD(ext_zbkb)
 BOOL_FIELD(ext_zbkc)
 BOOL_FIELD(ext_zbkx)
+BOOL_FIELD(ext_zbr)
 BOOL_FIELD(ext_zbs)
 BOOL_FIELD(ext_zca)
 BOOL_FIELD(ext_zcb)
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
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6e35c4b1e6..97bf9687b7 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -847,6 +847,18 @@ binvi      01101. ........... 001 ..... 0010011 @sh
 bset       0010100 .......... 001 ..... 0110011 @r
 bseti      00101. ........... 001 ..... 0010011 @sh
 
+# *** RV32 Zbr Experimental Extension ***
+crc32_b    0110000  10000 ..... 001 ..... 0010011 @r2
+crc32_h    0110000  10001 ..... 001 ..... 0010011 @r2
+crc32_w    0110000  10010 ..... 001 ..... 0010011 @r2
+crc32c_b   0110000  11000 ..... 001 ..... 0010011 @r2
+crc32c_h   0110000  11001 ..... 001 ..... 0010011 @r2
+crc32c_w   0110000  11010 ..... 001 ..... 0010011 @r2
+
+# *** RV64 Zbr Experimental Extension (in addition to RV32 Zbr) ***
+crc32_d    0110000  10011 ..... 001 ..... 0010011 @r2
+crc32c_d   0110000  11011 ..... 001 ..... 0010011 @r2
+
 # *** Zfa Standard Extension ***
 fli_s       1111000 00001 ..... 000 ..... 1010011 @r2
 fli_d       1111001 00001 ..... 000 ..... 1010011 @r2
diff --git a/target/riscv/insn_trans/trans_rvb.c.inc b/target/riscv/insn_trans/trans_rvb.c.inc
index e4dcc7c991..59db8b047f 100644
--- a/target/riscv/insn_trans/trans_rvb.c.inc
+++ b/target/riscv/insn_trans/trans_rvb.c.inc
@@ -36,6 +36,12 @@
     }                                            \
 } while (0)
 
+#define REQUIRE_ZBR(ctx) do {                    \
+    if (!ctx->cfg_ptr->ext_zbr) {                \
+        return false;                            \
+    }                                            \
+} while (0)
+
 #define REQUIRE_ZBS(ctx) do {                    \
     if (!ctx->cfg_ptr->ext_zbs) {                \
         return false;                            \
@@ -569,3 +575,34 @@ static bool trans_xperm8(DisasContext *ctx, arg_xperm8 *a)
     REQUIRE_ZBKX(ctx);
     return gen_arith(ctx, a, EXT_NONE, gen_helper_xperm8, NULL);
 }
+
+static bool gen_crc(DisasContext *ctx, arg_r2 *a,
+                    void (*func)(TCGv, TCGv, TCGv), TCGv tsz)
+{
+    REQUIRE_ZBR(ctx);
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
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index eb1ce6504a..f0bf4fa124 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -36,5 +36,10 @@ run-plugin-interruptedmemory: interruptedmemory
 	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
 	  $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-crc32
+comma:= ,
+run-test-crc32: test-crc32
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)x-zbr=true $(QEMU_OPTS)$<)
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


