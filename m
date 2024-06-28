Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E55C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCWj-0002di-Fz; Fri, 28 Jun 2024 10:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCWW-0002af-EK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:24:28 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCWC-0004Vm-5S
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:24:23 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52cf4ca8904so1007390e87.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719584636; x=1720189436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y23FTrJN45LFy6etcookcW60lgDZ8kVgEpVMDbNcKYI=;
 b=E8/UeFr5rYIL4nNHRs542lZ+9CGaU4pRHTlGO6tt17x3EOhtHEDohvI53/dFl21ocT
 VqFd/w2NDW4fRzUEV2AjhFPkq2OYGntMtW9YzG44ZggLIn2UTNdG/z38Qeb7xMtIvCFo
 xpa1wjqhAzZggXQAS2oYy01dbH+nDPlJUidluqMniZwGQNGJ8ZdlRP4r09Rud/VxxFh0
 YhKKt/lYhNyZ9VkR1WKZzHZ0WA0wHR32hfZw0Qj515oIOkGyyN5bZnNriPxMuq36cBm3
 SrZ7OpSyUk71eYBwvqXRGJ1VflQaAl7Wg/cjytj0GyKHqXT8jFr3qEGA/Zq5k0Ck974x
 euPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719584636; x=1720189436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y23FTrJN45LFy6etcookcW60lgDZ8kVgEpVMDbNcKYI=;
 b=TVtHYc3Lyj4t1qpcBjSeNPGO9qXZ+VbFa8EPhw45Ae+6MDEW4c1h+MQtomgKWYP8Uf
 EguVig8QfIpQyjoJVmyoYknzyYXgAiWzEeZ46c2m6Crgy3tLCccdZPimdiCUj+qK5Mld
 l6y7ScjR0TEmx0zP0Q/Cey9UdK9K/WtV8CSjWsjnKfs9aDpH/or/Y2ZafZBC4mltuRPG
 BXqjX1mPQshf84CrWbBD7H9d6YCui1OtPqZG+vT7Yf0yD1F3MycD5BQpzZjcTiRaX+t7
 N7kuqJHK3o+7YCmLSioKwwZGxj1zSJsmP/GGnIyjy8m0PTbfI215gDINQ+mFOpiFwiF9
 OTVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVThnlEWhrXWVWYgn7M48Urx+2ljQfkm3wE+P65XruLqJMfg5HlSHO2vQP37CgPSHIPk7qUWqYldpl9HxtpRVpJTe1KFxA=
X-Gm-Message-State: AOJu0YwGLBMDZY6NwHZL9+/9nSsGu44RbVAzpBAkzZejTi64+eHA9XzB
 mxyoeD8x2Ogx/KUmW0sc2VWXMlLlxIqPM7NHX9fG1SwZxIjv5PIcDBnPJBbUx8vnDxErYpkTNTq
 IhKc=
X-Google-Smtp-Source: AGHT+IEpI97rtoiayrKF39CsTS3Qa06I7Wr5nbuyqx0NfKoFDzPEkz/R2cfcQndsL3seX7f8SA3clg==
X-Received: by 2002:a05:6512:3b8d:b0:52d:6673:11da with SMTP id
 2adb3069b0e04-52d6673129emr7922103e87.57.1719584635910; 
 Fri, 28 Jun 2024 07:23:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55c0asm37180945e9.15.2024.06.28.07.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 07:23:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 6/9] target/arm: Store FPSR and FPCR in separate CPU state
 fields
Date: Fri, 28 Jun 2024 15:23:44 +0100
Message-Id: <20240628142347.1283015-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628142347.1283015-1-peter.maydell@linaro.org>
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

Now that we have refactored the set/get functions so that the FPSCR
format is no longer the authoritative one, we can keep FPSR and FPCR
in separate CPU state fields.

As well as the get and set functions, we also have a scattering of
places in the code which directly access vfp.xregs[ARM_VFP_FPSCR] to
extract single fields which are stored there.  These all change to
directly access either vfp.fpsr or vfp.fpcr, depending on the
location of the field.  (Most commonly, this is the NZCV flags.)

We make the field in the CPU state struct 64 bits, because
architecturally FPSR and FPCR are 64 bits.  However we leave the
types of the arguments and return values of the get/set functions as
32 bits, since we don't need to make that change with the current
architecture and various callsites would be unable to handle
set bits in the high half (for instance the gdbstub protocol
assumes they're only 32 bit registers).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h                  |  7 +++++++
 target/arm/tcg/translate.h        |  3 +--
 target/arm/tcg/mve_helper.c       | 12 ++++++------
 target/arm/tcg/translate-m-nocp.c |  6 +++---
 target/arm/tcg/translate-vfp.c    |  2 +-
 target/arm/vfp_helper.c           | 25 ++++++++++---------------
 6 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0a570afcab4..2eb7fc3bc39 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -619,6 +619,13 @@ typedef struct CPUArchState {
         int vec_len;
         int vec_stride;
 
+        /*
+         * Floating point status and control registers. Some bits are
+         * stored separately in other fields or in the float_status below.
+         */
+        uint64_t fpsr;
+        uint64_t fpcr;
+
         uint32_t xregs[16];
 
         /* Scratch space for aa32 neon expansion.  */
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index aba21f730fe..a8672c857c1 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -351,8 +351,7 @@ static inline TCGv_i32 get_ahp_flag(void)
 {
     TCGv_i32 ret = tcg_temp_new_i32();
 
-    tcg_gen_ld_i32(ret, tcg_env,
-                   offsetof(CPUARMState, vfp.xregs[ARM_VFP_FPSCR]));
+    tcg_gen_ld_i32(ret, tcg_env, offsetoflow32(CPUARMState, vfp.fpcr));
     tcg_gen_extract_i32(ret, ret, 26, 1);
 
     return ret;
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 8b99736aad1..234f395b093 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -1115,21 +1115,21 @@ static void do_vadc(CPUARMState *env, uint32_t *d, uint32_t *n, uint32_t *m,
 
     if (update_flags) {
         /* Store C, clear NZV. */
-        env->vfp.xregs[ARM_VFP_FPSCR] &= ~FPCR_NZCV_MASK;
-        env->vfp.xregs[ARM_VFP_FPSCR] |= carry_in * FPCR_C;
+        env->vfp.fpsr &= ~FPCR_NZCV_MASK;
+        env->vfp.fpsr |= carry_in * FPCR_C;
     }
     mve_advance_vpt(env);
 }
 
 void HELPER(mve_vadc)(CPUARMState *env, void *vd, void *vn, void *vm)
 {
-    bool carry_in = env->vfp.xregs[ARM_VFP_FPSCR] & FPCR_C;
+    bool carry_in = env->vfp.fpsr & FPCR_C;
     do_vadc(env, vd, vn, vm, 0, carry_in, false);
 }
 
 void HELPER(mve_vsbc)(CPUARMState *env, void *vd, void *vn, void *vm)
 {
-    bool carry_in = env->vfp.xregs[ARM_VFP_FPSCR] & FPCR_C;
+    bool carry_in = env->vfp.fpsr & FPCR_C;
     do_vadc(env, vd, vn, vm, -1, carry_in, false);
 }
 
@@ -3343,7 +3343,7 @@ static void do_vcvt_sh(CPUARMState *env, void *vd, void *vm, int top)
     uint32_t *m = vm;
     uint16_t r;
     uint16_t mask = mve_element_mask(env);
-    bool ieee = !(env->vfp.xregs[ARM_VFP_FPSCR] & FPCR_AHP);
+    bool ieee = !(env->vfp.fpcr & FPCR_AHP);
     unsigned e;
     float_status *fpst;
     float_status scratch_fpst;
@@ -3373,7 +3373,7 @@ static void do_vcvt_hs(CPUARMState *env, void *vd, void *vm, int top)
     uint16_t *m = vm;
     uint32_t r;
     uint16_t mask = mve_element_mask(env);
-    bool ieee = !(env->vfp.xregs[ARM_VFP_FPSCR] & FPCR_AHP);
+    bool ieee = !(env->vfp.fpcr & FPCR_AHP);
     unsigned e;
     float_status *fpst;
     float_status scratch_fpst;
diff --git a/target/arm/tcg/translate-m-nocp.c b/target/arm/tcg/translate-m-nocp.c
index f564d06ccf1..875f6a8725d 100644
--- a/target/arm/tcg/translate-m-nocp.c
+++ b/target/arm/tcg/translate-m-nocp.c
@@ -341,10 +341,10 @@ static bool gen_M_fp_sysreg_write(DisasContext *s, int regno,
                                  16, 16, qc);
         }
         tcg_gen_andi_i32(tmp, tmp, FPCR_NZCV_MASK);
-        fpscr = load_cpu_field(vfp.xregs[ARM_VFP_FPSCR]);
+        fpscr = load_cpu_field_low32(vfp.fpsr);
         tcg_gen_andi_i32(fpscr, fpscr, ~FPCR_NZCV_MASK);
         tcg_gen_or_i32(fpscr, fpscr, tmp);
-        store_cpu_field(fpscr, vfp.xregs[ARM_VFP_FPSCR]);
+        store_cpu_field_low32(fpscr, vfp.fpsr);
         break;
     }
     case ARM_VFP_FPCXT_NS:
@@ -465,7 +465,7 @@ static bool gen_M_fp_sysreg_read(DisasContext *s, int regno,
          * Read just NZCV; this is a special case to avoid the
          * helper call for the "VMRS to CPSR.NZCV" insn.
          */
-        tmp = load_cpu_field(vfp.xregs[ARM_VFP_FPSCR]);
+        tmp = load_cpu_field_low32(vfp.fpsr);
         tcg_gen_andi_i32(tmp, tmp, FPCR_NZCV_MASK);
         storefn(s, opaque, tmp, true);
         break;
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 39ec971ff70..0d9788e8103 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -833,7 +833,7 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
             break;
         case ARM_VFP_FPSCR:
             if (a->rt == 15) {
-                tmp = load_cpu_field(vfp.xregs[ARM_VFP_FPSCR]);
+                tmp = load_cpu_field_low32(vfp.fpsr);
                 tcg_gen_andi_i32(tmp, tmp, FPCR_NZCV_MASK);
             } else {
                 tmp = tcg_temp_new_i32();
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 38c8aadf9b4..f7a3da7f68b 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -115,7 +115,7 @@ static void vfp_set_fpsr_to_host(CPUARMState *env, uint32_t val)
 
 static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val)
 {
-    uint32_t changed = env->vfp.xregs[ARM_VFP_FPSCR];
+    uint64_t changed = env->vfp.fpcr;
 
     changed ^= val;
     if (changed & (3 << 22)) {
@@ -175,7 +175,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val)
 
 uint32_t vfp_get_fpcr(CPUARMState *env)
 {
-    uint32_t fpcr = (env->vfp.xregs[ARM_VFP_FPSCR] & FPCR_MASK)
+    uint32_t fpcr = env->vfp.fpcr
         | (env->vfp.vec_len << 16)
         | (env->vfp.vec_stride << 20);
 
@@ -190,7 +190,7 @@ uint32_t vfp_get_fpcr(CPUARMState *env)
 
 uint32_t vfp_get_fpsr(CPUARMState *env)
 {
-    uint32_t fpsr = env->vfp.xregs[ARM_VFP_FPSCR] & FPSR_MASK;
+    uint32_t fpsr = env->vfp.fpsr;
     uint32_t i;
 
     fpsr |= vfp_get_fpsr_from_host(env);
@@ -229,15 +229,13 @@ void vfp_set_fpsr(CPUARMState *env, uint32_t val)
     }
 
     /*
-     * The only FPSR bits we keep in vfp.xregs[FPSCR] are NZCV:
+     * The only FPSR bits we keep in vfp.fpsr are NZCV:
      * the exception flags IOC|DZC|OFC|UFC|IXC|IDC are stored in
      * fp_status, and QC is in vfp.qc[]. Store the NZCV bits there,
-     * and zero any of the other FPSR bits (but preserve the FPCR
-     * bits).
+     * and zero any of the other FPSR bits.
      */
     val &= FPCR_NZCV_MASK;
-    env->vfp.xregs[ARM_VFP_FPSCR] &= ~FPSR_MASK;
-    env->vfp.xregs[ARM_VFP_FPSCR] |= val;
+    env->vfp.fpsr = val;
 }
 
 void vfp_set_fpcr(CPUARMState *env, uint32_t val)
@@ -271,14 +269,13 @@ void vfp_set_fpcr(CPUARMState *env, uint32_t val)
      * We don't implement trapped exception handling, so the
      * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
      *
-     * The FPCR bits we keep in vfp.xregs[FPSCR] are AHP, DN, FZ, RMode
+     * The FPCR bits we keep in vfp.fpcr are AHP, DN, FZ, RMode
      * and FZ16. Len, Stride and LTPSIZE we just handled. Store those bits
      * there, and zero any of the other FPCR bits and the RES0 and RAZ/WI
      * bits.
      */
     val &= FPCR_AHP | FPCR_DN | FPCR_FZ | FPCR_RMODE_MASK | FPCR_FZ16;
-    env->vfp.xregs[ARM_VFP_FPSCR] &= ~FPCR_MASK;
-    env->vfp.xregs[ARM_VFP_FPSCR] |= val;
+    env->vfp.fpcr = val;
 }
 
 void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
@@ -356,8 +353,7 @@ static void softfloat_to_vfp_compare(CPUARMState *env, FloatRelation cmp)
     default:
         g_assert_not_reached();
     }
-    env->vfp.xregs[ARM_VFP_FPSCR] =
-        deposit32(env->vfp.xregs[ARM_VFP_FPSCR], 28, 4, flags);
+    env->vfp.fpsr = deposit64(env->vfp.fpsr, 28, 4, flags); /* NZCV */
 }
 
 /* XXX: check quiet/signaling case */
@@ -1160,8 +1156,7 @@ uint32_t HELPER(vjcvt)(float64 value, CPUARMState *env)
     uint32_t z = (pair >> 32) == 0;
 
     /* Store Z, clear NCV, in FPSCR.NZCV.  */
-    env->vfp.xregs[ARM_VFP_FPSCR]
-        = (env->vfp.xregs[ARM_VFP_FPSCR] & ~CPSR_NZCV) | (z * CPSR_Z);
+    env->vfp.fpsr = (env->vfp.fpsr & ~FPCR_NZCV_MASK) | (z * FPCR_Z);
 
     return result;
 }
-- 
2.34.1


