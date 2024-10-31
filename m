Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1794E68953
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Mjq-00049B-71; Thu, 31 Oct 2024 00:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Mjn-00042p-Tl
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:24:47 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Mjj-0006xB-Pl
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:24:46 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-539d9fffea1so474386e87.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730348681; x=1730953481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAp5Ln/TOaBbXfbAl+alUE9uLY3Kuq1n+bXOlaVNwGY=;
 b=vbJux36xnan/fCLg95ptgXmV34ulseeodYyMotBlRDMr3D71dibw5q1+HO7XlMkiP/
 I6fQAfC4SUzOUouLAQV0Jd+zlKe+F1UCVaUiNi0vj23qygMUddeAdn1WTSXI9Dad1yQI
 RYS9pM74zmItPPWuJkFcq3L8g+8oi7KxzVnNZ1G4i4/TKPxUg6IfL5sLMng7HNbdnGap
 QwrxjVBFiztYBVWGmnDsqOUDH3+GcC1Uu9p/aAFXRhwRM+Q94kdOQfng5HCDNte4GmeP
 KKh4wHRDH0orTBoHBtqcffV/ngbKBGhngtmNoNMjJGRei35y4KsqVKugCoby9w3qjhbo
 s1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730348681; x=1730953481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HAp5Ln/TOaBbXfbAl+alUE9uLY3Kuq1n+bXOlaVNwGY=;
 b=XRw4C84g7w0VMK/vhyxf97mEtb1YCkz9w2Yyb6bHGUDhuCtPZHWJpDERuImv+yalyn
 nNNwvWCdoY3UZb2T+EuVvTgHUQDMWHrJheOtRPTuuwynbpZclvqLUpHHPdqEuhBdFThG
 6Hc2gV8XndWjyF1mhX8dtBlIF056QX0a7JQwrJKF0TYIr9WNMnOWpUdXfhHL0jzO38rL
 MGYzPwDsQCbdOz4aksHJ0OQI1DYkCXUYzcBOzTR53MjDSGQTT3Aut7DRo4bpqOG5V0gp
 7qekadS6z0JSr+9/mweZDteMyHmUFFzHHqjapqFdlQZgN+DO7t9y6XUeskA3IKxBfa65
 f4AQ==
X-Gm-Message-State: AOJu0YzB4k3GE0ldg79L9j+d5Ng6MUes20pfgbA6G+wrcQ2ZL6NlnIbu
 /Sor0d+ub/L6ePeLa4iH7Vi98YSs4yBxSrhvJpTWgY20VprVjTYADZ6VEuA8uzej20NluWpvCpV
 a
X-Google-Smtp-Source: AGHT+IH6y/pZO71fZRlg4nagsLC2t0HQ9fnERFKUMYn5Bm93J6W8iKENYtsS4xGCuPp6xadF5a3VCg==
X-Received: by 2002:a05:6512:2210:b0:539:adb0:b91 with SMTP id
 2adb3069b0e04-53b34c8ee46mr7084370e87.57.1730348681405; 
 Wed, 30 Oct 2024 21:24:41 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53c7bc95941sm77940e87.50.2024.10.30.21.24.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Oct 2024 21:24:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/14] target/mips: Introduce ase_3d_available() helper
Date: Thu, 31 Oct 2024 01:21:28 -0300
Message-ID: <20241031042130.98450-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031042130.98450-1-philmd@linaro.org>
References: <20241031042130.98450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Determine if the MIPS-3D ASE is implemented by checking
the state of the 3D bit in the FIR CP1 control register.
Remove the then unused ASE_MIPS3D definition.

Note, this allows using MIPS-3D on the mips64dspr2 model.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241021145832.34920-1-philmd@linaro.org>
---
 target/mips/cpu.h                         | 6 ++++++
 target/mips/mips-defs.h                   | 1 -
 target/mips/tcg/translate.c               | 8 ++++++--
 target/mips/cpu-defs.c.inc                | 4 ++--
 target/mips/tcg/micromips_translate.c.inc | 5 ++++-
 5 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index a4a46ebbe98..3dbfbfdb3d3 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1319,6 +1319,12 @@ bool cpu_type_supports_cps_smp(const char *cpu_type);
 bool cpu_supports_isa(const CPUMIPSState *env, uint64_t isa_mask);
 bool cpu_type_supports_isa(const char *cpu_type, uint64_t isa);
 
+/* Check presence of MIPS-3D ASE */
+static inline bool ase_3d_available(const CPUMIPSState *env)
+{
+    return env->active_fpu.fcr0 & (1 << FCR0_3D);
+}
+
 /* Check presence of MSA implementation */
 static inline bool ase_msa_available(CPUMIPSState *env)
 {
diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index a6cebe0265c..6b5cd0d8f53 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -26,7 +26,6 @@
  *   bits 24-39: MIPS ASEs
  */
 #define ASE_MIPS16        0x0000000001000000ULL
-#define ASE_MIPS3D        0x0000000002000000ULL
 #define ASE_MDMX          0x0000000004000000ULL
 #define ASE_DSP           0x0000000008000000ULL
 #define ASE_DSP_R2        0x0000000010000000ULL
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 2d01f5c4a8b..9a3ae10a919 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -14710,7 +14710,9 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
             } else {
                 /* OPC_BC1ANY2 */
                 check_cop1x(ctx);
-                check_insn(ctx, ASE_MIPS3D);
+                if (!ase_3d_available(env)) {
+                    return false;
+                }
                 gen_compute_branch1(ctx, MASK_BC1(ctx->opcode),
                                     (rt >> 2) & 0x7, imm << 2);
             }
@@ -14725,7 +14727,9 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
             check_cp1_enabled(ctx);
             check_insn_opc_removed(ctx, ISA_MIPS_R6);
             check_cop1x(ctx);
-            check_insn(ctx, ASE_MIPS3D);
+            if (!ase_3d_available(env)) {
+                return false;
+            }
             /* fall through */
         case OPC_BC1:
             check_cp1_enabled(ctx);
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index 1ab026c57e7..09bd62d430a 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -663,7 +663,7 @@ const mips_def_t mips_defs[] =
         .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .SEGBITS = 40,
         .PABITS = 36,
-        .insn_flags = CPU_MIPS64R1 | ASE_MIPS3D,
+        .insn_flags = CPU_MIPS64R1,
         .mmu_type = MMU_TYPE_R4000,
     },
     {
@@ -692,7 +692,7 @@ const mips_def_t mips_defs[] =
         .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .SEGBITS = 42,
         .PABITS = 36,
-        .insn_flags = CPU_MIPS64R2 | ASE_MIPS3D,
+        .insn_flags = CPU_MIPS64R2,
         .mmu_type = MMU_TYPE_R4000,
     },
     {
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 3cbf53bf2b3..c479bec1081 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -2484,7 +2484,10 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             mips32_op = OPC_BC1TANY4;
         do_cp1mips3d:
             check_cop1x(ctx);
-            check_insn(ctx, ASE_MIPS3D);
+            if (!ase_3d_available(env)) {
+                gen_reserved_instruction(ctx);
+                break;
+            }
             /* Fall through */
         do_cp1branch:
             if (env->CP0_Config1 & (1 << CP0C1_FP)) {
-- 
2.45.2


