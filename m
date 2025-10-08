Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F46ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 07:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6P2f-0002Zn-S8; Wed, 08 Oct 2025 03:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P2c-0002Yv-P5
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:56:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P2Y-0004sE-4w
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:56:54 -0400
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so3312431f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759910208; x=1760515008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2jq33JdL/X3WR+7O7gki88f6wMlK/FIWmU9BJBph7Q=;
 b=xLPMBvGn+O5OYwTADEsyKlEd16M+atv2m8QwH7q8WiCbbcwjPQ9NzpFr8wiGiRIfUm
 ugZPVh49d7VWB2OJd8kX+EWaLJ10v1AKMjDpz93/W0pPViIlBimgMIXR/RHBpOaxmsXM
 Zs85POlBHMQDxm7XhVpNQ6pOscRJ3K2DY5+YaLFWOe5tmDT2dLz+CVReW5nso8Vn175k
 E6ErgPckszOpqs9QCOp9TDMRERAbXlu3b7amLCYLPHjSrglvj6ZTJxK5MWv5346+HPIs
 uyzuElIFUYTL4+AMWHNS3IpHv8R0nfzbIeAC7M3M1ddyT0rYvieitr672jwrc5lIucYo
 eRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759910208; x=1760515008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z2jq33JdL/X3WR+7O7gki88f6wMlK/FIWmU9BJBph7Q=;
 b=CSnj/otAA1ywODD9JVIJu3MJM46PwS9OOC2EIh3rZRn5yIpQQzAjhyGPKrA7nIpZAq
 LEmKeuoF3Adw3eYRiomwBH1/tXp+Mql3Z+72FTjt8yVv3s4hAhBcz6wL3y06+Erv9Ucs
 Fwwx5x+HdCJPKmcJkOWjiHtjffvAgHweKgocw2nuuc68y2Yin7BWpIQjEkAcHNI8UNks
 Hb6w0y8M9At8JUWdyFFYFjzFciHyqfv2e8UFAsyZzm1XDINDNVEmf7sa3RxSmXbyDg7D
 LojJpPD8dS9w6Dyvs89q31Zcr4cgkd1C41l0Ht4uuOsfWxTxi0be8hk5jGSh71D5dMNm
 OgbA==
X-Gm-Message-State: AOJu0YxZXAdePIAPqjAJi+Oi9jPtyEUv5bTgFfWfAchIybGghTEqJcis
 ievCpslql2Xdx7NsU5e5JN7mnR31T2yKbC2fkT3KggRAOpTcEaik6BCAM4v3nR+PTOOqUSIbZkl
 qn9d69JzJY9e4
X-Gm-Gg: ASbGncu+3dcGAEBhFle1oiJaGRnhvmDSMDWmRkjBBhCAKPZha9aUudbBCkWSVDOLAIZ
 pGWZbr/r1xo0sB5XZ2FiLj8G2vp93IVJ6mRvKk4Of41xm0ge39hlS+oo3w+vIWgT1KhpvMMsriN
 c5f7EkPmCzhs+KRo7nE2RLqWwE0XjHy5tx2s0ANX07MDi9edU8qmdszFVJ/Ne+cbmMXCKkdAUqm
 mNsdDbzU9YxUdhsYGyfC11VLxbFTXHb6AMXglj4oa7amtYGCzI1uCOTaGQ1LKRHer2/Yclt9rxU
 Dl6SChs+lORs3EzfpzoDHJlw/ZfqFvv/MsuUZ7aKYIgjBhZ9267/sBaiJwL08hess5/+MoUIA8s
 af81nTZ81a65tGj8JAakO8x3x3qhnBkmNfJWuFZ/OpiRNYNTSqMfARRGNBbWYKGSmvofT/fzl+l
 WMJmmVQagFdr5LLklc+xHsmbsRckcoGmY6AJk=
X-Google-Smtp-Source: AGHT+IH0C98wt9U330uZnHOae0gRvqJAjR4z9lFOA6ac1i4u2ctAB4cNqCBGQ6RYQuTiE+Za31wldw==
X-Received: by 2002:a05:6000:18a9:b0:3f7:ce62:ce17 with SMTP id
 ffacd0b85a97d-4266e7d4406mr1417043f8f.38.1759910207791; 
 Wed, 08 Oct 2025 00:56:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abf0bsm28587052f8f.17.2025.10.08.00.56.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Oct 2025 00:56:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 7/7] target/openrisc: Replace target_ulong -> uint32_t
Date: Wed,  8 Oct 2025 09:56:11 +0200
Message-ID: <20251008075612.94193-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008075612.94193-1-philmd@linaro.org>
References: <20251008075612.94193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
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

The OpenRISC targets are only built as 32-bit, therefore
target_ulong always expands to uint32_t. Replace and adapt
the API uses mechanically:

  target_ulong -> uint32_t
  target_long -> int32_t
  tl -> i32
  TCGv -> TCGv_i32
  tcg_global_mem_new -> tcg_global_mem_new_i32

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: not sure how to split to ease review :|
---
 target/openrisc/cpu.h        |  22 +--
 target/openrisc/helper.h     |   8 +-
 target/openrisc/fpu_helper.c |   8 +-
 target/openrisc/machine.c    |  16 +-
 target/openrisc/sys_helper.c |   5 +-
 target/openrisc/translate.c  | 374 +++++++++++++++++------------------
 6 files changed, 216 insertions(+), 217 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 87201365a91..c8e2827930b 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -224,20 +224,20 @@ typedef struct CPUOpenRISCTLBContext {
 #endif
 
 typedef struct CPUArchState {
-    target_ulong shadow_gpr[16][32]; /* Shadow registers */
+    uint32_t shadow_gpr[16][32]; /* Shadow registers */
 
-    target_ulong pc;          /* Program counter */
-    target_ulong ppc;         /* Prev PC */
-    target_ulong jmp_pc;      /* Jump PC */
+    uint32_t pc;              /* Program counter */
+    uint32_t ppc;             /* Prev PC */
+    uint32_t jmp_pc;          /* Jump PC */
 
     uint64_t mac;             /* Multiply registers MACHI:MACLO */
 
-    target_ulong epcr;        /* Exception PC register */
-    target_ulong eear;        /* Exception EA register */
+    uint32_t epcr;            /* Exception PC register */
+    uint32_t eear;            /* Exception EA register */
 
-    target_ulong sr_f;        /* the SR_F bit, values 0, 1.  */
-    target_ulong sr_cy;       /* the SR_CY bit, values 0, 1.  */
-    target_long  sr_ov;       /* the SR_OV bit (in the sign bit only) */
+    uint32_t sr_f;            /* the SR_F bit, values 0, 1.  */
+    uint32_t sr_cy;           /* the SR_CY bit, values 0, 1.  */
+    int32_t  sr_ov;           /* the SR_OV bit (in the sign bit only) */
     uint32_t sr;              /* Supervisor register, without SR_{F,CY,OV} */
     uint32_t esr;             /* Exception supervisor register */
     uint32_t evbar;           /* Exception vector base address register */
@@ -245,8 +245,8 @@ typedef struct CPUArchState {
     uint32_t fpcsr;           /* Float register */
     float_status fp_status;
 
-    target_ulong lock_addr;
-    target_ulong lock_value;
+    uint32_t lock_addr;
+    uint32_t lock_value;
 
     uint32_t dflag;           /* In delay slot (boolean) */
 
diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
index d847814a28d..e0a8d402271 100644
--- a/target/openrisc/helper.h
+++ b/target/openrisc/helper.h
@@ -47,8 +47,8 @@ FOP_CALC(rem)
 #undef FOP_CALC
 
 #define FOP_CMP(op)                                              \
-DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_RWG, tl, env, i32, i32) \
-DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_RWG, tl, env, i64, i64)
+DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_RWG, i32, env, i32, i32) \
+DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_RWG, i32, env, i64, i64)
 FOP_CMP(eq)
 FOP_CMP(lt)
 FOP_CMP(le)
@@ -62,5 +62,5 @@ FOP_CMP(ult)
 DEF_HELPER_FLAGS_1(rfe, 0, void, env)
 
 /* sys */
-DEF_HELPER_FLAGS_3(mtspr, 0, void, env, tl, tl)
-DEF_HELPER_FLAGS_3(mfspr, TCG_CALL_NO_WG, tl, env, tl, tl)
+DEF_HELPER_FLAGS_3(mtspr, 0, void, env, i32, i32)
+DEF_HELPER_FLAGS_3(mfspr, TCG_CALL_NO_WG, i32, env, i32, i32)
diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index dba997255c6..39b6195dd7d 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -146,10 +146,10 @@ uint32_t helper_float_madd_s(CPUOpenRISCState *env, uint32_t a,
 
 
 #define FLOAT_CMP(name, impl)                                             \
-target_ulong helper_float_ ## name ## _d(CPUOpenRISCState *env,           \
+uint32_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
                                          uint64_t fdt0, uint64_t fdt1)    \
 { return float64_ ## impl(fdt0, fdt1, &env->fp_status); }                 \
-target_ulong helper_float_ ## name ## _s(CPUOpenRISCState *env,           \
+uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
                                          uint32_t fdt0, uint32_t fdt1)    \
 { return float32_ ## impl(fdt0, fdt1, &env->fp_status); }
 
@@ -160,13 +160,13 @@ FLOAT_CMP(un, unordered_quiet)
 #undef FLOAT_CMP
 
 #define FLOAT_UCMP(name, expr) \
-target_ulong helper_float_ ## name ## _d(CPUOpenRISCState *env,           \
+uint32_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
                                          uint64_t fdt0, uint64_t fdt1)    \
 {                                                                         \
     FloatRelation r = float64_compare_quiet(fdt0, fdt1, &env->fp_status); \
     return expr;                                                          \
 }                                                                         \
-target_ulong helper_float_ ## name ## _s(CPUOpenRISCState *env,           \
+uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
                                          uint32_t fdt0, uint32_t fdt1)    \
 {                                                                         \
     FloatRelation r = float32_compare_quiet(fdt0, fdt1, &env->fp_status); \
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index fa054e528bd..f2853674f0f 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -72,14 +72,14 @@ static const VMStateDescription vmstate_env = {
     .version_id = 6,
     .minimum_version_id = 6,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL_2DARRAY(shadow_gpr, CPUOpenRISCState, 16, 32),
-        VMSTATE_UINTTL(pc, CPUOpenRISCState),
-        VMSTATE_UINTTL(ppc, CPUOpenRISCState),
-        VMSTATE_UINTTL(jmp_pc, CPUOpenRISCState),
-        VMSTATE_UINTTL(lock_addr, CPUOpenRISCState),
-        VMSTATE_UINTTL(lock_value, CPUOpenRISCState),
-        VMSTATE_UINTTL(epcr, CPUOpenRISCState),
-        VMSTATE_UINTTL(eear, CPUOpenRISCState),
+        VMSTATE_UINT32_2DARRAY(shadow_gpr, CPUOpenRISCState, 16, 32),
+        VMSTATE_UINT32(pc, CPUOpenRISCState),
+        VMSTATE_UINT32(ppc, CPUOpenRISCState),
+        VMSTATE_UINT32(jmp_pc, CPUOpenRISCState),
+        VMSTATE_UINT32(lock_addr, CPUOpenRISCState),
+        VMSTATE_UINT32(lock_value, CPUOpenRISCState),
+        VMSTATE_UINT32(epcr, CPUOpenRISCState),
+        VMSTATE_UINT32(eear, CPUOpenRISCState),
 
         /* Save the architecture value of the SR, not the internally
            expanded version.  Since this architecture value does not
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index ad59939db3b..7ad908b6322 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -40,7 +40,7 @@ static inline bool is_user(CPUOpenRISCState *env)
 #endif
 }
 
-void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
+void HELPER(mtspr)(CPUOpenRISCState *env, uint32_t spr, uint32_t rb)
 {
     OpenRISCCPU *cpu = env_archcpu(env);
 #ifndef CONFIG_USER_ONLY
@@ -213,8 +213,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
 #endif
 }
 
-target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
-                           target_ulong spr)
+uint32_t HELPER(mfspr)(CPUOpenRISCState *env, uint32_t rd, uint32_t spr)
 {
     OpenRISCCPU *cpu = env_archcpu(env);
 #ifndef CONFIG_USER_ONLY
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 695e11642f7..a98209924bd 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -54,9 +54,9 @@ typedef struct DisasContext {
     vaddr jmp_pc_imm;
 
     /* The temporary corresponding to register 0 for this compilation.  */
-    TCGv R0;
+    TCGv_i32 R0;
     /* The constant zero. */
-    TCGv zero;
+    TCGv_i32 zero;
 } DisasContext;
 
 static inline bool is_user(DisasContext *dc)
@@ -71,16 +71,16 @@ static inline bool is_user(DisasContext *dc)
 /* Include the auto-generated decoder.  */
 #include "decode-insns.c.inc"
 
-static TCGv cpu_sr;
-static TCGv cpu_regs[32];
-static TCGv cpu_pc;
-static TCGv jmp_pc;            /* l.jr/l.jalr temp pc */
-static TCGv cpu_ppc;
-static TCGv cpu_sr_f;           /* bf/bnf, F flag taken */
-static TCGv cpu_sr_cy;          /* carry (unsigned overflow) */
-static TCGv cpu_sr_ov;          /* signed overflow */
-static TCGv cpu_lock_addr;
-static TCGv cpu_lock_value;
+static TCGv_i32 cpu_sr;
+static TCGv_i32 cpu_regs[32];
+static TCGv_i32 cpu_pc;
+static TCGv_i32 jmp_pc;         /* l.jr/l.jalr temp pc */
+static TCGv_i32 cpu_ppc;
+static TCGv_i32 cpu_sr_f;       /* bf/bnf, F flag taken */
+static TCGv_i32 cpu_sr_cy;      /* carry (unsigned overflow) */
+static TCGv_i32 cpu_sr_ov;      /* signed overflow */
+static TCGv_i32 cpu_lock_addr;
+static TCGv_i32 cpu_lock_value;
 static TCGv_i32 fpcsr;
 static TCGv_i64 cpu_mac;        /* MACHI:MACLO */
 static TCGv_i32 cpu_dflag;
@@ -95,27 +95,27 @@ void openrisc_translate_init(void)
     };
     int i;
 
-    cpu_sr = tcg_global_mem_new(tcg_env,
+    cpu_sr = tcg_global_mem_new_i32(tcg_env,
                                 offsetof(CPUOpenRISCState, sr), "sr");
     cpu_dflag = tcg_global_mem_new_i32(tcg_env,
                                        offsetof(CPUOpenRISCState, dflag),
                                        "dflag");
-    cpu_pc = tcg_global_mem_new(tcg_env,
+    cpu_pc = tcg_global_mem_new_i32(tcg_env,
                                 offsetof(CPUOpenRISCState, pc), "pc");
-    cpu_ppc = tcg_global_mem_new(tcg_env,
+    cpu_ppc = tcg_global_mem_new_i32(tcg_env,
                                  offsetof(CPUOpenRISCState, ppc), "ppc");
-    jmp_pc = tcg_global_mem_new(tcg_env,
+    jmp_pc = tcg_global_mem_new_i32(tcg_env,
                                 offsetof(CPUOpenRISCState, jmp_pc), "jmp_pc");
-    cpu_sr_f = tcg_global_mem_new(tcg_env,
+    cpu_sr_f = tcg_global_mem_new_i32(tcg_env,
                                   offsetof(CPUOpenRISCState, sr_f), "sr_f");
-    cpu_sr_cy = tcg_global_mem_new(tcg_env,
+    cpu_sr_cy = tcg_global_mem_new_i32(tcg_env,
                                    offsetof(CPUOpenRISCState, sr_cy), "sr_cy");
-    cpu_sr_ov = tcg_global_mem_new(tcg_env,
+    cpu_sr_ov = tcg_global_mem_new_i32(tcg_env,
                                    offsetof(CPUOpenRISCState, sr_ov), "sr_ov");
-    cpu_lock_addr = tcg_global_mem_new(tcg_env,
+    cpu_lock_addr = tcg_global_mem_new_i32(tcg_env,
                                        offsetof(CPUOpenRISCState, lock_addr),
                                        "lock_addr");
-    cpu_lock_value = tcg_global_mem_new(tcg_env,
+    cpu_lock_value = tcg_global_mem_new_i32(tcg_env,
                                         offsetof(CPUOpenRISCState, lock_value),
                                         "lock_value");
     fpcsr = tcg_global_mem_new_i32(tcg_env,
@@ -125,7 +125,7 @@ void openrisc_translate_init(void)
                                      offsetof(CPUOpenRISCState, mac),
                                      "mac");
     for (i = 0; i < 32; i++) {
-        cpu_regs[i] = tcg_global_mem_new(tcg_env,
+        cpu_regs[i] = tcg_global_mem_new_i32(tcg_env,
                                          offsetof(CPUOpenRISCState,
                                                   shadow_gpr[0][i]),
                                          regnames[i]);
@@ -139,7 +139,7 @@ static void gen_exception(DisasContext *dc, unsigned int excp)
 
 static void gen_illegal_exception(DisasContext *dc)
 {
-    tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
+    tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
     gen_exception(dc, EXCP_ILLEGAL);
     dc->base.is_jmp = DISAS_NORETURN;
 }
@@ -159,7 +159,7 @@ static bool check_of64a32s(DisasContext *dc)
     return dc->cpucfgr & CPUCFGR_OF64A32S;
 }
 
-static TCGv cpu_R(DisasContext *dc, int reg)
+static TCGv_i32 cpu_R(DisasContext *dc, int reg)
 {
     if (reg == 0) {
         return dc->R0;
@@ -200,107 +200,107 @@ static void gen_ove_cyov(DisasContext *dc)
     }
 }
 
-static void gen_add(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+static void gen_add(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, TCGv_i32 srcb)
 {
-    TCGv t0 = tcg_temp_new();
-    TCGv res = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new();
+    TCGv_i32 res = tcg_temp_new();
 
-    tcg_gen_add2_tl(res, cpu_sr_cy, srca, dc->zero, srcb, dc->zero);
-    tcg_gen_xor_tl(cpu_sr_ov, srca, srcb);
-    tcg_gen_xor_tl(t0, res, srcb);
-    tcg_gen_andc_tl(cpu_sr_ov, t0, cpu_sr_ov);
+    tcg_gen_add2_i32(res, cpu_sr_cy, srca, dc->zero, srcb, dc->zero);
+    tcg_gen_xor_i32(cpu_sr_ov, srca, srcb);
+    tcg_gen_xor_i32(t0, res, srcb);
+    tcg_gen_andc_i32(cpu_sr_ov, t0, cpu_sr_ov);
 
-    tcg_gen_mov_tl(dest, res);
+    tcg_gen_mov_i32(dest, res);
 
     gen_ove_cyov(dc);
 }
 
-static void gen_addc(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+static void gen_addc(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, TCGv_i32 srcb)
 {
-    TCGv t0 = tcg_temp_new();
-    TCGv res = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new();
+    TCGv_i32 res = tcg_temp_new();
 
-    tcg_gen_addcio_tl(res, cpu_sr_cy, srca, srcb, cpu_sr_cy);
-    tcg_gen_xor_tl(cpu_sr_ov, srca, srcb);
-    tcg_gen_xor_tl(t0, res, srcb);
-    tcg_gen_andc_tl(cpu_sr_ov, t0, cpu_sr_ov);
+    tcg_gen_addcio_i32(res, cpu_sr_cy, srca, srcb, cpu_sr_cy);
+    tcg_gen_xor_i32(cpu_sr_ov, srca, srcb);
+    tcg_gen_xor_i32(t0, res, srcb);
+    tcg_gen_andc_i32(cpu_sr_ov, t0, cpu_sr_ov);
 
-    tcg_gen_mov_tl(dest, res);
+    tcg_gen_mov_i32(dest, res);
 
     gen_ove_cyov(dc);
 }
 
-static void gen_sub(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+static void gen_sub(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, TCGv_i32 srcb)
 {
-    TCGv res = tcg_temp_new();
+    TCGv_i32 res = tcg_temp_new();
 
-    tcg_gen_sub_tl(res, srca, srcb);
-    tcg_gen_xor_tl(cpu_sr_cy, srca, srcb);
-    tcg_gen_xor_tl(cpu_sr_ov, res, srcb);
-    tcg_gen_and_tl(cpu_sr_ov, cpu_sr_ov, cpu_sr_cy);
-    tcg_gen_setcond_tl(TCG_COND_LTU, cpu_sr_cy, srca, srcb);
+    tcg_gen_sub_i32(res, srca, srcb);
+    tcg_gen_xor_i32(cpu_sr_cy, srca, srcb);
+    tcg_gen_xor_i32(cpu_sr_ov, res, srcb);
+    tcg_gen_and_i32(cpu_sr_ov, cpu_sr_ov, cpu_sr_cy);
+    tcg_gen_setcond_i32(TCG_COND_LTU, cpu_sr_cy, srca, srcb);
 
-    tcg_gen_mov_tl(dest, res);
+    tcg_gen_mov_i32(dest, res);
 
     gen_ove_cyov(dc);
 }
 
-static void gen_mul(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+static void gen_mul(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, TCGv_i32 srcb)
 {
-    TCGv t0 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new();
 
-    tcg_gen_muls2_tl(dest, cpu_sr_ov, srca, srcb);
-    tcg_gen_sari_tl(t0, dest, TARGET_LONG_BITS - 1);
-    tcg_gen_negsetcond_tl(TCG_COND_NE, cpu_sr_ov, cpu_sr_ov, t0);
+    tcg_gen_muls2_i32(dest, cpu_sr_ov, srca, srcb);
+    tcg_gen_sari_i32(t0, dest, TARGET_LONG_BITS - 1);
+    tcg_gen_negsetcond_i32(TCG_COND_NE, cpu_sr_ov, cpu_sr_ov, t0);
 
     gen_ove_ov(dc);
 }
 
-static void gen_mulu(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+static void gen_mulu(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, TCGv_i32 srcb)
 {
-    tcg_gen_muls2_tl(dest, cpu_sr_cy, srca, srcb);
-    tcg_gen_setcondi_tl(TCG_COND_NE, cpu_sr_cy, cpu_sr_cy, 0);
+    tcg_gen_muls2_i32(dest, cpu_sr_cy, srca, srcb);
+    tcg_gen_setcondi_i32(TCG_COND_NE, cpu_sr_cy, cpu_sr_cy, 0);
 
     gen_ove_cy(dc);
 }
 
-static void gen_div(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+static void gen_div(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, TCGv_i32 srcb)
 {
-    TCGv t0 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new();
 
-    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_ov, srcb, 0);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_ov, srcb, 0);
     /* The result of divide-by-zero is undefined.
        Suppress the host-side exception by dividing by 1. */
-    tcg_gen_or_tl(t0, srcb, cpu_sr_ov);
-    tcg_gen_div_tl(dest, srca, t0);
+    tcg_gen_or_i32(t0, srcb, cpu_sr_ov);
+    tcg_gen_div_i32(dest, srca, t0);
 
-    tcg_gen_neg_tl(cpu_sr_ov, cpu_sr_ov);
+    tcg_gen_neg_i32(cpu_sr_ov, cpu_sr_ov);
     gen_ove_ov(dc);
 }
 
-static void gen_divu(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
+static void gen_divu(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, TCGv_i32 srcb)
 {
-    TCGv t0 = tcg_temp_new();
+    TCGv_i32 t0 = tcg_temp_new();
 
-    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_cy, srcb, 0);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_cy, srcb, 0);
     /* The result of divide-by-zero is undefined.
        Suppress the host-side exception by dividing by 1. */
-    tcg_gen_or_tl(t0, srcb, cpu_sr_cy);
-    tcg_gen_divu_tl(dest, srca, t0);
+    tcg_gen_or_i32(t0, srcb, cpu_sr_cy);
+    tcg_gen_divu_i32(dest, srca, t0);
 
     gen_ove_cy(dc);
 }
 
-static void gen_muld(DisasContext *dc, TCGv srca, TCGv srcb)
+static void gen_muld(DisasContext *dc, TCGv_i32 srca, TCGv_i32 srcb)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
-    tcg_gen_ext_tl_i64(t1, srca);
-    tcg_gen_ext_tl_i64(t2, srcb);
+    tcg_gen_ext_i32_i64(t1, srca);
+    tcg_gen_ext_i32_i64(t2, srcb);
     if (TARGET_LONG_BITS == 32) {
         tcg_gen_mul_i64(cpu_mac, t1, t2);
-        tcg_gen_movi_tl(cpu_sr_ov, 0);
+        tcg_gen_movi_i32(cpu_sr_ov, 0);
     } else {
         TCGv_i64 high = tcg_temp_new_i64();
 
@@ -313,16 +313,16 @@ static void gen_muld(DisasContext *dc, TCGv srca, TCGv srcb)
     }
 }
 
-static void gen_muldu(DisasContext *dc, TCGv srca, TCGv srcb)
+static void gen_muldu(DisasContext *dc, TCGv_i32 srca, TCGv_i32 srcb)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
-    tcg_gen_extu_tl_i64(t1, srca);
-    tcg_gen_extu_tl_i64(t2, srcb);
+    tcg_gen_extu_i32_i64(t1, srca);
+    tcg_gen_extu_i32_i64(t2, srcb);
     if (TARGET_LONG_BITS == 32) {
         tcg_gen_mul_i64(cpu_mac, t1, t2);
-        tcg_gen_movi_tl(cpu_sr_cy, 0);
+        tcg_gen_movi_i32(cpu_sr_cy, 0);
     } else {
         TCGv_i64 high = tcg_temp_new_i64();
 
@@ -334,13 +334,13 @@ static void gen_muldu(DisasContext *dc, TCGv srca, TCGv srcb)
     }
 }
 
-static void gen_mac(DisasContext *dc, TCGv srca, TCGv srcb)
+static void gen_mac(DisasContext *dc, TCGv_i32 srca, TCGv_i32 srcb)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
-    tcg_gen_ext_tl_i64(t1, srca);
-    tcg_gen_ext_tl_i64(t2, srcb);
+    tcg_gen_ext_i32_i64(t1, srca);
+    tcg_gen_ext_i32_i64(t2, srcb);
     tcg_gen_mul_i64(t1, t1, t2);
 
     /* Note that overflow is only computed during addition stage.  */
@@ -358,13 +358,13 @@ static void gen_mac(DisasContext *dc, TCGv srca, TCGv srcb)
     gen_ove_ov(dc);
 }
 
-static void gen_macu(DisasContext *dc, TCGv srca, TCGv srcb)
+static void gen_macu(DisasContext *dc, TCGv_i32 srca, TCGv_i32 srcb)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
-    tcg_gen_extu_tl_i64(t1, srca);
-    tcg_gen_extu_tl_i64(t2, srcb);
+    tcg_gen_extu_i32_i64(t1, srca);
+    tcg_gen_extu_i32_i64(t2, srcb);
     tcg_gen_mul_i64(t1, t1, t2);
 
     /* Note that overflow is only computed during addition stage.  */
@@ -375,13 +375,13 @@ static void gen_macu(DisasContext *dc, TCGv srca, TCGv srcb)
     gen_ove_cy(dc);
 }
 
-static void gen_msb(DisasContext *dc, TCGv srca, TCGv srcb)
+static void gen_msb(DisasContext *dc, TCGv_i32 srca, TCGv_i32 srcb)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
-    tcg_gen_ext_tl_i64(t1, srca);
-    tcg_gen_ext_tl_i64(t2, srcb);
+    tcg_gen_ext_i32_i64(t1, srca);
+    tcg_gen_ext_i32_i64(t2, srcb);
     tcg_gen_mul_i64(t1, t1, t2);
 
     /* Note that overflow is only computed during subtraction stage.  */
@@ -399,13 +399,13 @@ static void gen_msb(DisasContext *dc, TCGv srca, TCGv srcb)
     gen_ove_ov(dc);
 }
 
-static void gen_msbu(DisasContext *dc, TCGv srca, TCGv srcb)
+static void gen_msbu(DisasContext *dc, TCGv_i32 srca, TCGv_i32 srcb)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
-    tcg_gen_extu_tl_i64(t1, srca);
-    tcg_gen_extu_tl_i64(t2, srcb);
+    tcg_gen_extu_i32_i64(t1, srca);
+    tcg_gen_extu_i32_i64(t2, srcb);
     tcg_gen_mul_i64(t1, t1, t2);
 
     /* Note that overflow is only computed during subtraction stage.  */
@@ -440,84 +440,84 @@ static bool trans_l_sub(DisasContext *dc, arg_dab *a)
 static bool trans_l_and(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_and_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
+    tcg_gen_and_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_or(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_or_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
+    tcg_gen_or_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_xor(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_xor_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
+    tcg_gen_xor_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sll(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_shl_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
+    tcg_gen_shl_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_srl(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_shr_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
+    tcg_gen_shr_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sra(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_sar_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
+    tcg_gen_sar_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_ror(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_rotr_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
+    tcg_gen_rotr_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_exths(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ext16s_tl(cpu_R(dc, a->d), cpu_R(dc, a->a));
+    tcg_gen_ext16s_i32(cpu_R(dc, a->d), cpu_R(dc, a->a));
     return true;
 }
 
 static bool trans_l_extbs(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ext8s_tl(cpu_R(dc, a->d), cpu_R(dc, a->a));
+    tcg_gen_ext8s_i32(cpu_R(dc, a->d), cpu_R(dc, a->a));
     return true;
 }
 
 static bool trans_l_exthz(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ext16u_tl(cpu_R(dc, a->d), cpu_R(dc, a->a));
+    tcg_gen_ext16u_i32(cpu_R(dc, a->d), cpu_R(dc, a->a));
     return true;
 }
 
 static bool trans_l_extbz(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ext8u_tl(cpu_R(dc, a->d), cpu_R(dc, a->a));
+    tcg_gen_ext8u_i32(cpu_R(dc, a->d), cpu_R(dc, a->a));
     return true;
 }
 
 static bool trans_l_cmov(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_movcond_tl(TCG_COND_NE, cpu_R(dc, a->d), cpu_sr_f, dc->zero,
+    tcg_gen_movcond_i32(TCG_COND_NE, cpu_R(dc, a->d), cpu_sr_f, dc->zero,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
@@ -525,16 +525,16 @@ static bool trans_l_cmov(DisasContext *dc, arg_dab *a)
 static bool trans_l_ff1(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ctzi_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), -1);
-    tcg_gen_addi_tl(cpu_R(dc, a->d), cpu_R(dc, a->d), 1);
+    tcg_gen_ctzi_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), -1);
+    tcg_gen_addi_i32(cpu_R(dc, a->d), cpu_R(dc, a->d), 1);
     return true;
 }
 
 static bool trans_l_fl1(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_clzi_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), TARGET_LONG_BITS);
-    tcg_gen_subfi_tl(cpu_R(dc, a->d), TARGET_LONG_BITS, cpu_R(dc, a->d));
+    tcg_gen_clzi_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), TARGET_LONG_BITS);
+    tcg_gen_subfi_i32(cpu_R(dc, a->d), TARGET_LONG_BITS, cpu_R(dc, a->d));
     return true;
 }
 
@@ -582,7 +582,7 @@ static bool trans_l_j(DisasContext *dc, arg_l_j *a)
 {
     vaddr tmp_pc = dc->base.pc_next + a->n * 4;
 
-    tcg_gen_movi_tl(jmp_pc, tmp_pc);
+    tcg_gen_movi_i32(jmp_pc, tmp_pc);
     dc->jmp_pc_imm = tmp_pc;
     dc->delayed_branch = 2;
     return true;
@@ -593,10 +593,10 @@ static bool trans_l_jal(DisasContext *dc, arg_l_jal *a)
     vaddr tmp_pc = dc->base.pc_next + a->n * 4;
     vaddr ret_pc = dc->base.pc_next + 8;
 
-    tcg_gen_movi_tl(cpu_regs[9], ret_pc);
+    tcg_gen_movi_i32(cpu_regs[9], ret_pc);
     /* Optimize jal being used to load the PC for PIC.  */
     if (tmp_pc != ret_pc) {
-        tcg_gen_movi_tl(jmp_pc, tmp_pc);
+        tcg_gen_movi_i32(jmp_pc, tmp_pc);
         dc->jmp_pc_imm = tmp_pc;
         dc->delayed_branch = 2;
     }
@@ -606,10 +606,10 @@ static bool trans_l_jal(DisasContext *dc, arg_l_jal *a)
 static void do_bf(DisasContext *dc, arg_l_bf *a, TCGCond cond)
 {
     vaddr tmp_pc = dc->base.pc_next + a->n * 4;
-    TCGv t_next = tcg_constant_tl(dc->base.pc_next + 8);
-    TCGv t_true = tcg_constant_tl(tmp_pc);
+    TCGv_i32 t_next = tcg_constant_i32(dc->base.pc_next + 8);
+    TCGv_i32 t_true = tcg_constant_i32(tmp_pc);
 
-    tcg_gen_movcond_tl(cond, jmp_pc, cpu_sr_f, dc->zero, t_true, t_next);
+    tcg_gen_movcond_i32(cond, jmp_pc, cpu_sr_f, dc->zero, t_true, t_next);
     dc->delayed_branch = 2;
 }
 
@@ -627,40 +627,40 @@ static bool trans_l_bnf(DisasContext *dc, arg_l_bf *a)
 
 static bool trans_l_jr(DisasContext *dc, arg_l_jr *a)
 {
-    tcg_gen_mov_tl(jmp_pc, cpu_R(dc, a->b));
+    tcg_gen_mov_i32(jmp_pc, cpu_R(dc, a->b));
     dc->delayed_branch = 2;
     return true;
 }
 
 static bool trans_l_jalr(DisasContext *dc, arg_l_jalr *a)
 {
-    tcg_gen_mov_tl(jmp_pc, cpu_R(dc, a->b));
-    tcg_gen_movi_tl(cpu_regs[9], dc->base.pc_next + 8);
+    tcg_gen_mov_i32(jmp_pc, cpu_R(dc, a->b));
+    tcg_gen_movi_i32(cpu_regs[9], dc->base.pc_next + 8);
     dc->delayed_branch = 2;
     return true;
 }
 
 static bool trans_l_lwa(DisasContext *dc, arg_load *a)
 {
-    TCGv ea;
+    TCGv_i32 ea;
 
     check_r0_write(dc, a->d);
     ea = tcg_temp_new();
-    tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
-    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TEUL);
-    tcg_gen_mov_tl(cpu_lock_addr, ea);
-    tcg_gen_mov_tl(cpu_lock_value, cpu_R(dc, a->d));
+    tcg_gen_addi_i32(ea, cpu_R(dc, a->a), a->i);
+    tcg_gen_qemu_ld_i32(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TEUL);
+    tcg_gen_mov_i32(cpu_lock_addr, ea);
+    tcg_gen_mov_i32(cpu_lock_value, cpu_R(dc, a->d));
     return true;
 }
 
 static void do_load(DisasContext *dc, arg_load *a, MemOp mop)
 {
-    TCGv ea;
+    TCGv_i32 ea;
 
     check_r0_write(dc, a->d);
     ea = tcg_temp_new();
-    tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
-    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, mop);
+    tcg_gen_addi_i32(ea, cpu_R(dc, a->a), a->i);
+    tcg_gen_qemu_ld_i32(cpu_R(dc, a->d), ea, dc->mem_idx, mop);
 }
 
 static bool trans_l_lwz(DisasContext *dc, arg_load *a)
@@ -701,36 +701,36 @@ static bool trans_l_lhs(DisasContext *dc, arg_load *a)
 
 static bool trans_l_swa(DisasContext *dc, arg_store *a)
 {
-    TCGv ea, val;
+    TCGv_i32 ea, val;
     TCGLabel *lab_fail, *lab_done;
 
     ea = tcg_temp_new();
-    tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
+    tcg_gen_addi_i32(ea, cpu_R(dc, a->a), a->i);
 
     lab_fail = gen_new_label();
     lab_done = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_NE, ea, cpu_lock_addr, lab_fail);
+    tcg_gen_brcond_i32(TCG_COND_NE, ea, cpu_lock_addr, lab_fail);
 
     val = tcg_temp_new();
-    tcg_gen_atomic_cmpxchg_tl(val, cpu_lock_addr, cpu_lock_value,
+    tcg_gen_atomic_cmpxchg_i32(val, cpu_lock_addr, cpu_lock_value,
                               cpu_R(dc, a->b), dc->mem_idx, MO_TEUL);
-    tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, val, cpu_lock_value);
+    tcg_gen_setcond_i32(TCG_COND_EQ, cpu_sr_f, val, cpu_lock_value);
 
     tcg_gen_br(lab_done);
 
     gen_set_label(lab_fail);
-    tcg_gen_movi_tl(cpu_sr_f, 0);
+    tcg_gen_movi_i32(cpu_sr_f, 0);
 
     gen_set_label(lab_done);
-    tcg_gen_movi_tl(cpu_lock_addr, -1);
+    tcg_gen_movi_i32(cpu_lock_addr, -1);
     return true;
 }
 
 static void do_store(DisasContext *dc, arg_store *a, MemOp mop)
 {
-    TCGv t0 = tcg_temp_new();
-    tcg_gen_addi_tl(t0, cpu_R(dc, a->a), a->i);
-    tcg_gen_qemu_st_tl(cpu_R(dc, a->b), t0, dc->mem_idx, mop);
+    TCGv_i32 t0 = tcg_temp_new();
+    tcg_gen_addi_i32(t0, cpu_R(dc, a->a), a->i);
+    tcg_gen_qemu_st_i32(cpu_R(dc, a->b), t0, dc->mem_idx, mop);
 }
 
 static bool trans_l_sw(DisasContext *dc, arg_store *a)
@@ -772,75 +772,75 @@ static bool trans_l_adrp(DisasContext *dc, arg_l_adrp *a)
 static bool trans_l_addi(DisasContext *dc, arg_rri *a)
 {
     check_r0_write(dc, a->d);
-    gen_add(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), tcg_constant_tl(a->i));
+    gen_add(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), tcg_constant_i32(a->i));
     return true;
 }
 
 static bool trans_l_addic(DisasContext *dc, arg_rri *a)
 {
     check_r0_write(dc, a->d);
-    gen_addc(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), tcg_constant_tl(a->i));
+    gen_addc(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), tcg_constant_i32(a->i));
     return true;
 }
 
 static bool trans_l_muli(DisasContext *dc, arg_rri *a)
 {
     check_r0_write(dc, a->d);
-    gen_mul(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), tcg_constant_tl(a->i));
+    gen_mul(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), tcg_constant_i32(a->i));
     return true;
 }
 
 static bool trans_l_maci(DisasContext *dc, arg_l_maci *a)
 {
-    gen_mac(dc, cpu_R(dc, a->a), tcg_constant_tl(a->i));
+    gen_mac(dc, cpu_R(dc, a->a), tcg_constant_i32(a->i));
     return true;
 }
 
 static bool trans_l_andi(DisasContext *dc, arg_rrk *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_andi_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), a->k);
+    tcg_gen_andi_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), a->k);
     return true;
 }
 
 static bool trans_l_ori(DisasContext *dc, arg_rrk *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ori_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), a->k);
+    tcg_gen_ori_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), a->k);
     return true;
 }
 
 static bool trans_l_xori(DisasContext *dc, arg_rri *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_xori_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), a->i);
+    tcg_gen_xori_i32(cpu_R(dc, a->d), cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a)
 {
-    TCGv spr = tcg_temp_new();
+    TCGv_i32 spr = tcg_temp_new();
 
     check_r0_write(dc, a->d);
 
     if (translator_io_start(&dc->base)) {
         if (dc->delayed_branch) {
-            tcg_gen_mov_tl(cpu_pc, jmp_pc);
-            tcg_gen_discard_tl(jmp_pc);
+            tcg_gen_mov_i32(cpu_pc, jmp_pc);
+            tcg_gen_discard_i32(jmp_pc);
         } else {
-            tcg_gen_movi_tl(cpu_pc, dc->base.pc_next + 4);
+            tcg_gen_movi_i32(cpu_pc, dc->base.pc_next + 4);
         }
         dc->base.is_jmp = DISAS_EXIT;
     }
 
-    tcg_gen_ori_tl(spr, cpu_R(dc, a->a), a->k);
+    tcg_gen_ori_i32(spr, cpu_R(dc, a->a), a->k);
     gen_helper_mfspr(cpu_R(dc, a->d), tcg_env, cpu_R(dc, a->d), spr);
     return true;
 }
 
 static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a)
 {
-    TCGv spr = tcg_temp_new();
+    TCGv_i32 spr = tcg_temp_new();
 
     translator_io_start(&dc->base);
 
@@ -851,14 +851,14 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a)
      * of the cpu state first, allowing it to be overwritten.
      */
     if (dc->delayed_branch) {
-        tcg_gen_mov_tl(cpu_pc, jmp_pc);
-        tcg_gen_discard_tl(jmp_pc);
+        tcg_gen_mov_i32(cpu_pc, jmp_pc);
+        tcg_gen_discard_i32(jmp_pc);
     } else {
-        tcg_gen_movi_tl(cpu_pc, dc->base.pc_next + 4);
+        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next + 4);
     }
     dc->base.is_jmp = DISAS_EXIT;
 
-    tcg_gen_ori_tl(spr, cpu_R(dc, a->a), a->k);
+    tcg_gen_ori_i32(spr, cpu_R(dc, a->a), a->k);
     gen_helper_mtspr(tcg_env, spr, cpu_R(dc, a->b));
     return true;
 }
@@ -890,7 +890,7 @@ static bool trans_l_msbu(DisasContext *dc, arg_ab *a)
 static bool trans_l_slli(DisasContext *dc, arg_dal *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_shli_tl(cpu_R(dc, a->d), cpu_R(dc, a->a),
+    tcg_gen_shli_i32(cpu_R(dc, a->d), cpu_R(dc, a->a),
                     a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
@@ -898,7 +898,7 @@ static bool trans_l_slli(DisasContext *dc, arg_dal *a)
 static bool trans_l_srli(DisasContext *dc, arg_dal *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_shri_tl(cpu_R(dc, a->d), cpu_R(dc, a->a),
+    tcg_gen_shri_i32(cpu_R(dc, a->d), cpu_R(dc, a->a),
                     a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
@@ -906,7 +906,7 @@ static bool trans_l_srli(DisasContext *dc, arg_dal *a)
 static bool trans_l_srai(DisasContext *dc, arg_dal *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_sari_tl(cpu_R(dc, a->d), cpu_R(dc, a->a),
+    tcg_gen_sari_i32(cpu_R(dc, a->d), cpu_R(dc, a->a),
                     a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
@@ -914,7 +914,7 @@ static bool trans_l_srai(DisasContext *dc, arg_dal *a)
 static bool trans_l_rori(DisasContext *dc, arg_dal *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_rotri_tl(cpu_R(dc, a->d), cpu_R(dc, a->a),
+    tcg_gen_rotri_i32(cpu_R(dc, a->d), cpu_R(dc, a->a),
                      a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
@@ -922,7 +922,7 @@ static bool trans_l_rori(DisasContext *dc, arg_dal *a)
 static bool trans_l_movhi(DisasContext *dc, arg_l_movhi *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_movi_tl(cpu_R(dc, a->d), a->k << 16);
+    tcg_gen_movi_i32(cpu_R(dc, a->d), a->k << 16);
     return true;
 }
 
@@ -936,137 +936,137 @@ static bool trans_l_macrc(DisasContext *dc, arg_l_macrc *a)
 
 static bool trans_l_sfeq(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_EQ, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfne(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_NE, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_NE, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfgtu(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_GTU, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_GTU, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfgeu(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_GEU, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_GEU, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfltu(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_LTU, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_LTU, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfleu(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_LEU, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_LEU, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfgts(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_GT, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_GT, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfges(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_GE, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_GE, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sflts(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_LT, cpu_sr_f,
+    tcg_gen_setcond_i32(TCG_COND_LT, cpu_sr_f,
                        cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfles(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_LE,
+    tcg_gen_setcond_i32(TCG_COND_LE,
                        cpu_sr_f, cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfeqi(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfnei(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_NE, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_NE, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfgtui(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_GTU, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_GTU, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfgeui(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_GEU, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfltui(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_LTU, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_LTU, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfleui(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_LEU, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_LEU, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfgtsi(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_GT, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_GT, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfgesi(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_GE, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_GE, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfltsi(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_LT, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_LT, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sflesi(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_LE, cpu_sr_f, cpu_R(dc, a->a), a->i);
+    tcg_gen_setcondi_i32(TCG_COND_LE, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sys(DisasContext *dc, arg_l_sys *a)
 {
-    tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
+    tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
     gen_exception(dc, EXCP_SYSCALL);
     dc->base.is_jmp = DISAS_NORETURN;
     return true;
@@ -1074,7 +1074,7 @@ static bool trans_l_sys(DisasContext *dc, arg_l_sys *a)
 
 static bool trans_l_trap(DisasContext *dc, arg_l_trap *a)
 {
-    tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
+    tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
     gen_exception(dc, EXCP_TRAP);
     dc->base.is_jmp = DISAS_NORETURN;
     return true;
@@ -1108,7 +1108,7 @@ static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a)
 }
 
 static bool do_fp2(DisasContext *dc, arg_da *a,
-                   void (*fn)(TCGv, TCGv_env, TCGv))
+                   void (*fn)(TCGv_i32, TCGv_env, TCGv_i32))
 {
     if (!check_of32s(dc)) {
         return false;
@@ -1120,7 +1120,7 @@ static bool do_fp2(DisasContext *dc, arg_da *a,
 }
 
 static bool do_fp3(DisasContext *dc, arg_dab *a,
-                   void (*fn)(TCGv, TCGv_env, TCGv, TCGv))
+                   void (*fn)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32))
 {
     if (!check_of32s(dc)) {
         return false;
@@ -1132,7 +1132,7 @@ static bool do_fp3(DisasContext *dc, arg_dab *a,
 }
 
 static bool do_fpcmp(DisasContext *dc, arg_ab *a,
-                     void (*fn)(TCGv, TCGv_env, TCGv, TCGv),
+                     void (*fn)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32),
                      bool inv, bool swap)
 {
     if (!check_of32s(dc)) {
@@ -1144,7 +1144,7 @@ static bool do_fpcmp(DisasContext *dc, arg_ab *a,
         fn(cpu_sr_f, tcg_env, cpu_R(dc, a->a), cpu_R(dc, a->b));
     }
     if (inv) {
-        tcg_gen_xori_tl(cpu_sr_f, cpu_sr_f, 1);
+        tcg_gen_xori_i32(cpu_sr_f, cpu_sr_f, 1);
     }
     gen_helper_update_fpcsr(tcg_env);
     return true;
@@ -1337,7 +1337,7 @@ static bool do_dp2(DisasContext *dc, arg_da_pair *a,
 }
 
 static bool do_dpcmp(DisasContext *dc, arg_ab_pair *a,
-                     void (*fn)(TCGv, TCGv_env, TCGv_i64, TCGv_i64),
+                     void (*fn)(TCGv_i32, TCGv_env, TCGv_i64, TCGv_i64),
                      bool inv, bool swap)
 {
     TCGv_i64 t0, t1;
@@ -1359,7 +1359,7 @@ static bool do_dpcmp(DisasContext *dc, arg_ab_pair *a,
     }
 
     if (inv) {
-        tcg_gen_xori_tl(cpu_sr_f, cpu_sr_f, 1);
+        tcg_gen_xori_i32(cpu_sr_f, cpu_sr_f, 1);
     }
     gen_helper_update_fpcsr(tcg_env);
     return true;
@@ -1544,7 +1544,7 @@ static void openrisc_tr_tb_start(DisasContextBase *db, CPUState *cs)
 
     /* Allow the TCG optimizer to see that R0 == 0,
        when it's true, which is the common case.  */
-    dc->zero = tcg_constant_tl(0);
+    dc->zero = tcg_constant_i32(0);
     if (dc->tb_flags & TB_FLAGS_R0_0) {
         dc->R0 = dc->zero;
     } else {
@@ -1600,32 +1600,32 @@ static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 
     /* For DISAS_TOO_MANY, jump to the next insn.  */
     jmp_dest = dc->base.pc_next;
-    tcg_gen_movi_tl(cpu_ppc, jmp_dest - 4);
+    tcg_gen_movi_i32(cpu_ppc, jmp_dest - 4);
 
     switch (dc->base.is_jmp) {
     case DISAS_JUMP:
         jmp_dest = dc->jmp_pc_imm;
         if (jmp_dest == -1) {
             /* The jump destination is indirect/computed; use jmp_pc.  */
-            tcg_gen_mov_tl(cpu_pc, jmp_pc);
-            tcg_gen_discard_tl(jmp_pc);
+            tcg_gen_mov_i32(cpu_pc, jmp_pc);
+            tcg_gen_discard_i32(jmp_pc);
             tcg_gen_lookup_and_goto_ptr();
             break;
         }
         /* The jump destination is direct; use jmp_pc_imm.
            However, we will have stored into jmp_pc as well;
            we know now that it wasn't needed.  */
-        tcg_gen_discard_tl(jmp_pc);
+        tcg_gen_discard_i32(jmp_pc);
         /* fallthru */
 
     case DISAS_TOO_MANY:
         if (translator_use_goto_tb(&dc->base, jmp_dest)) {
             tcg_gen_goto_tb(0);
-            tcg_gen_movi_tl(cpu_pc, jmp_dest);
+            tcg_gen_movi_i32(cpu_pc, jmp_dest);
             tcg_gen_exit_tb(dc->base.tb, 0);
             break;
         }
-        tcg_gen_movi_tl(cpu_pc, jmp_dest);
+        tcg_gen_movi_i32(cpu_pc, jmp_dest);
         tcg_gen_lookup_and_goto_ptr();
         break;
 
-- 
2.51.0


