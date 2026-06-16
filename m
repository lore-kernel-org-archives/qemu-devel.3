Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E39CD98EC
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQiG-0004ix-On; Tue, 16 Jun 2026 06:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQiF-0004fz-7C
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:07 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQiD-0003a9-CT
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:06 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-36d98b9aa9aso3624238a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604484; x=1782209284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kbgCJ59Xgnc50VCPq3lgNF9mVy/0CctYffqoXbtdNfM=;
 b=qidP1XLWbk3P7KOBIJACBg8eDUZWRR1GY2Fg2H4lrdENjsqak0Fv4ECzhkfI4lYZqv
 2WfHk4bL/FBrs0lyQNMuEvbost9Tks8DBxFZPJ2zDnDRGPLhYLJtqfojweOjbDQEHwVe
 3WRtkGn3Mcb/itlAJVBvhJCoIbf/mP/fx2GMo4VHEkizTbzw5cotE4ReGRKqZmRjVMVS
 viUaEdbXTmD5LDTgPVIo+77+GlYRUNrKizM2t/CUtadLUVfR8ggVFm5bNdqdjEQOLbje
 +kDV/Fxi2cFAPvq4Br79MjZ8rf6v1XrU2HIGkY9JgKUycAOVrI6pABZU/FnWFcOSVAQe
 XYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604484; x=1782209284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kbgCJ59Xgnc50VCPq3lgNF9mVy/0CctYffqoXbtdNfM=;
 b=IxbY3+YRSr616dd3sPuCQFxmjGnvZzvc5nxoryIn3d8Y9QTpKJhHMt3OyMG4rUTuX+
 0uNLW1NuF/ld1MmA9vXUbRRVpj7XAYauF9NWskFkGEvh3hxC0qtUC4kU80b9Dc7GRqfO
 4h21s7nfiM4QJDitPYfYsaohfinqGN+vKpD0qI08VKRHWQQM8mjaMnIj2aRNtTEV6xEx
 LvDHTIHt/UYllOoVXUMhBnCkK069wDryyccjt5LAfRk8+9OOvgbXIivB0i9wx9zf8Ydm
 3eIHh4x6mbovN6lKKXuJluZugEawarEE13Fds9q2xhFyzzNTkvPWxpyDJi56/1gidS1I
 ijCQ==
X-Gm-Message-State: AOJu0YyD1mbvu6R4bMH/xA05ygW26Vy+4V4NyTQ/hUcS/o+fivyy1Dl9
 SBKxP/YESloNpjzwZ4scLX0yWeY0m2wXbvLUyozEHJcf536BFdyRfzisxyDrkOnV
X-Gm-Gg: Acq92OH2I3aNgh8z0FQxaMEuCXVTmF5nTgiw1yD36vgElNZO8LqGZiAEWcOuwpnGMHb
 L+iD5HlEJ9fK26BMEOR84RAR0afY6X/nIMMSjV4vCzYkt9hMGZyboTsfRXTfNAGGqalgMqlkJXW
 lPZkvymPA3Gg57iHRZa8ZiOCjxG1G0AS+phVCU8SWdp6EHft1tPW/JAFzhh8zFLywqGehtWhRSn
 HPiHko8I0I5oaNsMBMv9Ta0nXi2n7G6diZx+Kpm4RJk1CUfD7EnqWUWRZBNJz7Z9i9JtS+SVb8h
 Fy7Q/Opi5x84Ks/y0oEUwpwPL+I0FpX9NOaC/o6tsfGZKJc6xv2FfYfH/6Ez5IeDNQT6q/IlbMX
 zJ8C9uIxHgL4aRXcvQbQVpIGbFG6kbmrmwaKYKfYNYyoYrpPpCYd9v4jqIKZ4V6korusaXqxme1
 TWEyzeiKrbnqJS0Ufgjrn3OIJn8xonSNnhUn+rTEUzgKgkXLtXRf0=
X-Received: by 2002:a17:90b:2fc7:b0:37c:54d5:290e with SMTP id
 98e67ed59e1d1-37c54d52dc3mr2488268a91.21.1781604483837; 
 Tue, 16 Jun 2026 03:08:03 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:08:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 43/83] target/riscv: Implement runtime data endianness via
 MSTATUS bits
Date: Tue, 16 Jun 2026 20:04:46 +1000
Message-ID: <20260616100527.1939565-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1033.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Make data accesses honour the MSTATUS MBE/SBE/UBE endianness bits
instead of being hardcoded to little-endian. Update mo_endian_env()
to pick the bit corresponding to the current privilege level (MBE
for M, SBE for S, UBE for U). Remove the now unused mo_endian()
helper.

Note, TB_FLAGS has no free bits, so the data endianness is carried
in the extended RISC-V TB flags stored in cs_base. It uses
EXT_TB_FLAGS.BIG_ENDIAN at bit 33, leaving bit 32 for
EXT_TB_FLAGS.ALTFMT. This keys TBs correctly on the current data
endianness.

Instruction fetches remain MO_LE unconditionally; RISC-V instructions
are always little-endian per the ISA specification. Update the
disassembler comment to clarify that BFD_ENDIAN_LITTLE is correct.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260527201348.29511-3-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  1 +
 target/riscv/internals.h   | 29 +++++++++++++++++++++--------
 target/riscv/cpu.c         |  7 ++-----
 target/riscv/tcg/tcg-cpu.c |  2 ++
 target/riscv/translate.c   | 15 ++-------------
 5 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1805aa8dfd..febd905389 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -714,6 +714,7 @@ FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
 
 FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
 FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
+FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index e143a86f97..5d84e4de96 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -62,16 +62,29 @@ static inline bool mmuidx_2stage(int mmu_idx)
     return mmu_idx & MMU_2STAGE_BIT;
 }
 
+/*
+ * Return the endianness for the current privilege
+ * level, based on the MSTATUS MBE/SBE/UBE bits.
+ */
 static inline MemOp mo_endian_env(CPURISCVState *env)
 {
-    /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
-     */
-    return MO_LE;
+    bool be = false;
+#if !defined(CONFIG_USER_ONLY)
+    switch (env->priv) {
+    case PRV_M:
+        be = env->mstatus & MSTATUS_MBE;
+        break;
+    case PRV_S:
+        be = env->mstatus & MSTATUS_SBE;
+        break;
+    case PRV_U:
+        be = env->mstatus & MSTATUS_UBE;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+#endif
+    return be ? MO_BE : MO_LE;
 }
 
 /* share data between vector helpers and decode code */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1d9e575bb2..ee74cc5b20 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -831,11 +831,8 @@ static void riscv_cpu_disas_set_info(const CPUState *s, disassemble_info *info)
     info->target_info = &cpu->cfg;
 
     /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
+     * RISC-V instructions are always little-endian, regardless of the
+     * data endianness configured via MSTATUS UBE/SBE/MBE bits.
      */
     info->endian = BFD_ENDIAN_LITTLE;
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 7e964e8f1a..60afb4ccc2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -194,6 +194,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
 
     ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
+    ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, BIG_ENDIAN,
+                           mo_endian_env(env) == MO_BE);
 
     return (TCGTBCPUState){
         .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 5405db9ea5..9684dbe752 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -130,18 +130,6 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
     return ctx->misa_ext & ext;
 }
 
-static inline MemOp mo_endian(DisasContext *ctx)
-{
-    /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
-     */
-    return MO_LE;
-}
-
 #ifdef TARGET_RISCV32
 #define get_xl(ctx)    MXL_RV32
 #elif defined(CONFIG_USER_ONLY)
@@ -1365,7 +1353,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
     ctx->decoders = cpu->decoders;
-    ctx->mo_endianness = mo_endian(ctx);
+    ctx->mo_endianness = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, BIG_ENDIAN)
+                         ? MO_BE : MO_LE;
 }
 
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
-- 
2.54.0


