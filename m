Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CE7CD129A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt82-00021j-Gr; Mon, 08 Apr 2024 13:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt81-00021J-1a
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:57 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7y-0003eZ-Vx
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:56 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2a559928f46so356889a91.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598594; x=1713203394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRQqZ9oBK6iehJFrs+uDcTw60o+LKkDegjDNYSUR+vc=;
 b=HGCQM44MjAuwF3wUiEPfynqh9i3FG6wxDFLiimmfFGg3Sshza/iP/FolAFTKbRtmAG
 GDRSb/kr4CXjZOChbGkgSSs4MLEUPBcJwfwCmuO4CJC4HsQQjFLMOG0g2u6BJb0sxVbn
 7Vxafz1pr+uCl7FdvVPO5FWnT6s+0UW1DjdpMd5SBwwaDe90Cq8hbcGRkBpyJ11n13x1
 ZGoS+wLtAxlLvUntCQfpu0/NaXlyuMTbO+4iPLb6CWKjYw3G23H6cTgbW11z29tBldTy
 LfpMW0dcvuU7EBi4a7X2Em/PeqkoX7udUDxLBOXrbXa0aw/2Rz5KpWE6s+vY/dgIni7N
 Ugqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598594; x=1713203394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRQqZ9oBK6iehJFrs+uDcTw60o+LKkDegjDNYSUR+vc=;
 b=wkpcKaYZMj/n+ZQ7sHT+2x+q2lVkceCaLVLfltHe97t2HG/myTeVwyVEU4qMHeFrnm
 bQ0jDdy9C28ymwyrOmW5wLrJ+nWNV4PYHvmOPKZQ2rSygWSJFatY8h1ZxyKrVIMw789i
 ydghdu2C74hYfjAjQp/uZtCOAHLqkF/vHR9aBaVduDL4Bye5enRuI/oQkHW59eeFQfEu
 JnI392Jp1CTxk7DeC4PpLiTYs/ZuAbN6Ft7a6va4wKkMW2+2jT68V8JsZ7+QGwtwlrrT
 82wqq9QHH5Kh5sEuygrGF8KpTTwC2U8ap6tOMUDt+5qTpKNYuSqXRy3wuDqyRm3NCzpf
 q70w==
X-Gm-Message-State: AOJu0Yzl1tzvEaA/AmaPPW74gH+SacE+V/l9DODXxdx1oRfcPRt3EKFr
 zH1pjC/GzHSjcUtBm3G96xxLYvx4/6GtzEM1tAX/I9S3+2JSt0RuS7pmyyQXhPXqD1TRZwQ3jcH
 K
X-Google-Smtp-Source: AGHT+IHY/uyeF+5qClnPaueU6w0Sqq2uwjffvq2z772WNcRJTTx0YDS6sUwUuqaSgAi5BRXu4INeMw==
X-Received: by 2002:a17:90b:4a09:b0:2a5:1e47:a927 with SMTP id
 kk9-20020a17090b4a0900b002a51e47a927mr3067743pjb.5.1712598593724; 
 Mon, 08 Apr 2024 10:49:53 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PULL 15/35] target/m68k: Map FPU exceptions to FPSR register
Date: Mon,  8 Apr 2024 07:49:09 -1000
Message-Id: <20240408174929.862917-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

From: Keith Packard <keithp@keithp.com>

Add helpers for reading/writing the 68881 FPSR register so that
changes in floating point exception state can be seen by the
application.

Call these helpers in pre_load/post_load hooks to synchronize
exception state.

Signed-off-by: Keith Packard <keithp@keithp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230803035231.429697-1-keithp@keithp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h        |  3 +-
 target/m68k/helper.h     |  2 ++
 target/m68k/cpu.c        | 12 +++++--
 target/m68k/fpu_helper.c | 72 ++++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.c     |  4 +--
 target/m68k/translate.c  |  4 +--
 6 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 346427e144..e184239a81 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -199,7 +199,8 @@ void cpu_m68k_set_ccr(CPUM68KState *env, uint32_t);
 void cpu_m68k_set_sr(CPUM68KState *env, uint32_t);
 void cpu_m68k_restore_fp_status(CPUM68KState *env);
 void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val);
-
+uint32_t cpu_m68k_get_fpsr(CPUM68KState *env);
+void cpu_m68k_set_fpsr(CPUM68KState *env, uint32_t val);
 
 /*
  * Instead of computing the condition codes after each m68k instruction,
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 2bbe0dc032..95aa5e53bb 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -54,6 +54,8 @@ DEF_HELPER_4(fsdiv, void, env, fp, fp, fp)
 DEF_HELPER_4(fddiv, void, env, fp, fp, fp)
 DEF_HELPER_4(fsgldiv, void, env, fp, fp, fp)
 DEF_HELPER_FLAGS_3(fcmp, TCG_CALL_NO_RWG, void, env, fp, fp)
+DEF_HELPER_2(set_fpsr, void, env, i32)
+DEF_HELPER_1(get_fpsr, i32, env)
 DEF_HELPER_FLAGS_2(set_fpcr, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(ftst, TCG_CALL_NO_RWG, void, env, fp)
 DEF_HELPER_3(fconst, void, env, fp, i32)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 7c8efbb42c..df49ff1880 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -390,12 +390,19 @@ static const VMStateDescription vmstate_freg = {
     }
 };
 
+static int fpu_pre_save(void *opaque)
+{
+    M68kCPU *s = opaque;
+
+    s->env.fpsr = cpu_m68k_get_fpsr(&s->env);
+    return 0;
+}
+
 static int fpu_post_load(void *opaque, int version)
 {
     M68kCPU *s = opaque;
 
-    cpu_m68k_restore_fp_status(&s->env);
-
+    cpu_m68k_set_fpsr(&s->env, s->env.fpsr);
     return 0;
 }
 
@@ -404,6 +411,7 @@ const VMStateDescription vmmstate_fpu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = fpu_needed,
+    .pre_save = fpu_pre_save,
     .post_load = fpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.fpcr, M68kCPU),
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index ab120b5f59..8314791f50 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -164,6 +164,78 @@ void HELPER(set_fpcr)(CPUM68KState *env, uint32_t val)
     cpu_m68k_set_fpcr(env, val);
 }
 
+/* Convert host exception flags to cpu_m68k form.  */
+static int cpu_m68k_exceptbits_from_host(int host_bits)
+{
+    int target_bits = 0;
+
+    if (host_bits & float_flag_invalid) {
+        target_bits |= 0x80;
+    }
+    if (host_bits & float_flag_overflow) {
+        target_bits |= 0x40;
+    }
+    if (host_bits & (float_flag_underflow | float_flag_output_denormal)) {
+        target_bits |= 0x20;
+    }
+    if (host_bits & float_flag_divbyzero) {
+        target_bits |= 0x10;
+    }
+    if (host_bits & float_flag_inexact) {
+        target_bits |= 0x08;
+    }
+    return target_bits;
+}
+
+/* Convert cpu_m68k exception flags to target form.  */
+static int cpu_m68k_exceptbits_to_host(int target_bits)
+{
+    int host_bits = 0;
+
+    if (target_bits & 0x80) {
+        host_bits |= float_flag_invalid;
+    }
+    if (target_bits & 0x40) {
+        host_bits |= float_flag_overflow;
+    }
+    if (target_bits & 0x20) {
+        host_bits |= float_flag_underflow;
+    }
+    if (target_bits & 0x10) {
+        host_bits |= float_flag_divbyzero;
+    }
+    if (target_bits & 0x08) {
+        host_bits |= float_flag_inexact;
+    }
+    return host_bits;
+}
+
+uint32_t cpu_m68k_get_fpsr(CPUM68KState *env)
+{
+    int host_flags = get_float_exception_flags(&env->fp_status);
+    int target_flags = cpu_m68k_exceptbits_from_host(host_flags);
+    int except = (env->fpsr & ~(0xf8)) | target_flags;
+    return except;
+}
+
+uint32_t HELPER(get_fpsr)(CPUM68KState *env)
+{
+    return cpu_m68k_get_fpsr(env);
+}
+
+void cpu_m68k_set_fpsr(CPUM68KState *env, uint32_t val)
+{
+    env->fpsr = val;
+
+    int host_flags = cpu_m68k_exceptbits_to_host((int) env->fpsr);
+    set_float_exception_flags(host_flags, &env->fp_status);
+}
+
+void HELPER(set_fpsr)(CPUM68KState *env, uint32_t val)
+{
+    cpu_m68k_set_fpsr(env, val);
+}
+
 #define PREC_BEGIN(prec)                                        \
     do {                                                        \
         FloatX80RoundPrec old =                                 \
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 1a475f082a..7a91f33b17 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -87,7 +87,7 @@ static int m68k_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
     case 8: /* fpcontrol */
         return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
-        return gdb_get_reg32(mem_buf, env->fpsr);
+        return gdb_get_reg32(mem_buf, cpu_m68k_get_fpsr(env));
     case 10: /* fpiar, not implemented */
         return gdb_get_reg32(mem_buf, 0);
     }
@@ -109,7 +109,7 @@ static int m68k_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
         cpu_m68k_set_fpcr(env, ldl_p(mem_buf));
         return 4;
     case 9: /* fpstatus */
-        env->fpsr = ldl_p(mem_buf);
+        cpu_m68k_set_fpsr(env, ldl_p(mem_buf));
         return 4;
     case 10: /* fpiar, not implemented */
         return 4;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 6ae3df43bc..8a194f2f21 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4686,7 +4686,7 @@ static void gen_load_fcr(DisasContext *s, TCGv res, int reg)
         tcg_gen_movi_i32(res, 0);
         break;
     case M68K_FPSR:
-        tcg_gen_ld_i32(res, tcg_env, offsetof(CPUM68KState, fpsr));
+        gen_helper_get_fpsr(res, tcg_env);
         break;
     case M68K_FPCR:
         tcg_gen_ld_i32(res, tcg_env, offsetof(CPUM68KState, fpcr));
@@ -4700,7 +4700,7 @@ static void gen_store_fcr(DisasContext *s, TCGv val, int reg)
     case M68K_FPIAR:
         break;
     case M68K_FPSR:
-        tcg_gen_st_i32(val, tcg_env, offsetof(CPUM68KState, fpsr));
+        gen_helper_set_fpsr(tcg_env, val);
         break;
     case M68K_FPCR:
         gen_helper_set_fpcr(tcg_env, val);
-- 
2.34.1


