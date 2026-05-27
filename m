Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC6DCD6E45
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSKdn-00064S-Lp; Wed, 27 May 2026 16:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKdm-000649-34
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:14:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKdk-00056L-A3
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:14:09 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so127858995e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779912846; x=1780517646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvsndL3uE0tKY0e5Ntpbz61TpwE+wT5Q3inzD1J7b1A=;
 b=rG/doMNgF7Jm7XQGlB3x8BYLhBCLp7MegKcV2eSX+qrSJEMr/njkUOpA07CatzIwth
 uyLIASval1lEnmVABU9jqgSv/cMZ4X+vzCX5cW3HbxowTB8Sn4jV3cMr0YdieAIWpgf4
 WAO4ZMRvWxC3s6ZdC78L0hMCyBvjO4McQsL8UVu2/3GvRKizEHW9bAMuhPbC3vM1plqO
 NUKGHUCn/u/O+rBqjBu3/GoyMs+japLxiVssLsjxkZoECoWL/b8diUd+ln/Q4CkXcgCL
 TVvcT1y7jvZ0dV7LIqYDmUUGJmZ7xR3q4zkURHuZAFOnAHiKfAxe1bdpKRGbRCCQgGxK
 FmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912846; x=1780517646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bvsndL3uE0tKY0e5Ntpbz61TpwE+wT5Q3inzD1J7b1A=;
 b=OOqwRtC6JSEj9BioHASYE3EPHdxmND6BfELH0Xi3iW9h1KyMdhO+jwepfHgS2g2eEH
 sAdKeQ/I6yjKAiKmmMKUuE5dBUy+rcTI/U4IlGhBJkyryFOI46jVGNKd2/18HJVuX/8k
 RSbOd0+uSQ441NyiNrehuoT+Z5jcPJ+0vAtsJvb5pwPax2kGMAw20Xs+oNSOLW9Hn3A9
 HYfMTdmCxo8TyPHQx4+u9KJxEvi0FNYH1LFRrtjnSb8aBqddcx+64hEK4388CYaQN/xA
 FZpttrdga3Nsk5EaydXqv9KAE6UCkLpfcRcaGGKmevGxZoMye+qoYwB65Z8DcbxU9LAX
 A3mg==
X-Gm-Message-State: AOJu0Yx3Ng2ue4RkMvciJIxin/7ipmlimyJfjGPBQUcBuqR6tqa91ZXY
 r7p5ZLPEoRTnMvZ4iSWrs0Xn0h1USzVeckJTURMt9B90r5svlz2vn2y7yFeEKQbirFBDyQgYeVy
 diIQc4Zuqrw==
X-Gm-Gg: Acq92OGAOUGvoBerskvO3+k8iX+AUteJMQJwmVIeiHa7lmFUHD0JWnmf2GHVEomrQav
 fff45V4aCPT4DC+5geBAW1Fp+Hm6x78ZDNCW0T5dUmNKmQqhIuBjogXqSn1Z1TFzrHNkamZBRPT
 0GSWL9b8yiM2O5SgN5xC1f1LvZquzyx54qNP4fXhZ0OMvSasurfafxbJ4Dch99zm8Wjx+MQow7v
 OqPl04KdcbYQwMqn6izcOK0Hxyyo/DOBpu2Y/EJARXjV4G/6j8XTEjLCgSoZLWy9jMWu09vB+6R
 pWB1Uva8ERDUhrn2GU32byQ3ny7A3rhgHn+Cl3UxOuIV2cXLZOrpO2er7Eq40VdaeEw4IMzmoj/
 SO+fwUI4tVci3hUkPwGUc0guYcwUv0+m4Rkl1tScZwaZ+2X1fh6thrwW7Vx29/GAIvxT/AprQTL
 N6q4fo/sgJzDMcxzlbR4wZZizKorLElBVeNxc2Z/PGewJaQZja6fFaGscTEhglHKkLhw==
X-Received: by 2002:a05:600c:3b0a:b0:490:60cb:560b with SMTP id
 5b1f17b1804b1-49060cb57b1mr282702815e9.28.1779912846279; 
 Wed, 27 May 2026 13:14:06 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454ea134sm461258225e9.8.2026.05.27.13.14.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 13:14:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 02/12] target/riscv: Implement runtime data endianness via
 MSTATUS bits
Date: Wed, 27 May 2026 22:13:38 +0200
Message-ID: <20260527201348.29511-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527201348.29511-1-philmd@linaro.org>
References: <20260527201348.29511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
---
 target/riscv/cpu.h         |  1 +
 target/riscv/internals.h   | 29 +++++++++++++++++++++--------
 target/riscv/cpu.c         |  7 ++-----
 target/riscv/tcg/tcg-cpu.c |  2 ++
 target/riscv/translate.c   | 15 ++-------------
 5 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7d79c7a5a7e..1f3cbbf823f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -706,6 +706,7 @@ FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
 
 FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
 FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
+FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 8c24af0d855..2b3bdbbf30a 100644
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
index 862834b4809..52f143f1cd4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -830,11 +830,8 @@ static void riscv_cpu_disas_set_info(const CPUState *s, disassemble_info *info)
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
index 3e22e7ed53d..45bbf658cad 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -193,6 +193,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
 
     ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
+    ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, BIG_ENDIAN,
+                           mo_endian_env(env) == MO_BE);
 
     return (TCGTBCPUState){
         .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9367f159f90..35c6b37c0b6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -129,18 +129,6 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
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
@@ -1362,7 +1350,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
     ctx->decoders = cpu->decoders;
-    ctx->mo_endianness = mo_endian(ctx);
+    ctx->mo_endianness = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, BIG_ENDIAN)
+                         ? MO_BE : MO_LE;
 }
 
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
-- 
2.53.0


