Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABED6C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGb-0000bM-GD; Tue, 09 Apr 2024 15:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGZ-0000ak-Kq
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:23 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGX-0004eT-Ln
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:23 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e3e84a302eso22005155ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691380; x=1713296180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRQqZ9oBK6iehJFrs+uDcTw60o+LKkDegjDNYSUR+vc=;
 b=Njv6Klsn32MQZyMu2C4khd0Qe6fc2lROL9mL4z/4uwi3ImU+enqWydBS9xh62QDFy6
 JEM9OMnWME8nenjgjCDEvCxyL0sPRxO74oA8u0HxlAy84anPjrL5ajHw9LZNg3BmRoVf
 XZZtxOdIOYAJdITPJayEf4wtkgwRwHKRbyawO2u4Axg1QtCGF3ibgdBw6vhmxIxPjmk+
 atQlfXgSF9Ee1d0lBJX89UpR5ZdMchUCaifLYWkcSsgfhvZnJTDGewZm282ptZ5kH+1s
 V7XU3ePVk6aSKKYNp2Sf+dFJfDTMWgWhP01XAgy5czYquTVRCxAH3JYliNdcNgtoA/nv
 ucgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691380; x=1713296180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRQqZ9oBK6iehJFrs+uDcTw60o+LKkDegjDNYSUR+vc=;
 b=nHpUcDC7GdmK38sLYmOc/VQHmBF0V1X2AI+iWmh0Q8xdpU07WKflBueomMc4Wc8Y7m
 0I90Sd+9HtjNnfYNA33JxGw5RZ5VnPU6JszeIvpj41jIfI7txE8MZYaJZ2exGZq1WYTp
 ZleslvlgkZzyUweVATqPX9u2V30BN3ls5/q1/OrCs7ipUgrakNrMdwY8z2fSxJmdAEeH
 UoM8vGeR/U7axImLFRcQMrAl7jzbvfYdHXxPvcbvAMvMLiJ9/RhN2S+ZPXj5Oa60GZyB
 pgdEz3tSs3al5z2g6yn9fNvSnM1AwOxDRYo4vge/aC80GpIksjyYzIooOl5Shal5jhC2
 33tQ==
X-Gm-Message-State: AOJu0Yw7Z7oQRm5ElYaovUtD284V1FSK7gN+FbEpfjLd8xNSKg/+1eM5
 Ygvitdk6J7/68FCCZVj4KR410OgN1s6n2oUMol0K9kPpTcoRtOx1X554NdOiIuo3T/qzeUbwGf8
 O
X-Google-Smtp-Source: AGHT+IGu6jp2pri160B//u+7wr4xzV0r/I+hRBTGUu/BPmpCQJdBI+pKVc4JnCGHptJ8QsQzlfbIYA==
X-Received: by 2002:a17:902:a3c8:b0:1e2:992a:ae3 with SMTP id
 q8-20020a170902a3c800b001e2992a0ae3mr782012plb.45.1712691380359; 
 Tue, 09 Apr 2024 12:36:20 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PULL v2 10/20] target/m68k: Map FPU exceptions to FPSR register
Date: Tue,  9 Apr 2024 09:35:53 -1000
Message-Id: <20240409193603.1703216-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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


