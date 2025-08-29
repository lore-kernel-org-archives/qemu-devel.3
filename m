Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88636CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN7s-0000VR-FT; Sat, 30 Aug 2025 11:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urtEI-00010B-WF
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:08:59 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urtEF-0005dE-Rx
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:08:58 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso1298476f8f.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 00:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756451334; x=1757056134; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9aICflX9gr9phC4mPWfoSDn4j5XQSCYNcihAm/aBfTE=;
 b=lPcYg4RCtgbjLhx02No2XvrSOvFerqw+iP46CYiNU8JwQe/558bFdA7/6n3T2FoyhL
 0zpSBAkgLa7ma3ltBvuKiGu09T3VFsSQufvgVGTMyJctJ2aQJfJ+4x/jqKQI0NwSXckT
 O6Uc/FCE/1CTDSBuqnNTNfQdMB83MZvJKmDg+DJ10ANBahU2U+ncbKY3rZQrcg31rBVf
 t9mrekigBwXajyVcCWGAZXSet3oKx1SRTmU0bUKwBSyQDMl4X1zaOFcwlGAmnVSsUEIF
 lUJ8sNJ4Xl5hV7SvrGdZIy6nF8j5SpFPyWvfBvSxCRW5p67ZfOD4tgX69zBIIJp6l3ka
 zskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756451334; x=1757056134;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9aICflX9gr9phC4mPWfoSDn4j5XQSCYNcihAm/aBfTE=;
 b=hGu1par7WsUTVVgme7evA2+ujOidFBnLQr6jIHeqt/HWXNyzfzCqlK6gfDXiyx0IBF
 8MFGISohm54VOxlaVIzDCovaBerCnd+qVjKVXzgwqB+DlZ8lVw8XD/pZ9lg6+e4hPtjh
 AM6GEbOXybb9XIwlp6pr6S6ipjap2dXmckv9W4vJsoEZcD+c4yGC/jP81Meu7GsO+xP3
 UoGicAE6A/KvwPgbjYCp2C2j2rtoMDMahj9jN/LBHn34lGkDlcRBkq/vj4a6Ddzg1/uh
 tc64WbNoMfDq1DUD24qO4zip1aUcV+1AIMaHE6J+7z9XIvgNGtrC17rEGEF+RycFeEPC
 QgGg==
X-Gm-Message-State: AOJu0YwXeAE6M/1bJtFOa/cJ8fTewSLxf0q5klYPKqGTxUV/YiP3h6B9
 PtoLsmsk4oWz96yvV5BLFaEpSstf3u/cgTbMEqbK1ddMYDJ0RmzAZij08jfeLmksYjHK/Q4X2dk
 Cs0O0/TI=
X-Gm-Gg: ASbGncv5EWgRuImMsi+It8dZSaaVkFJTImGPpJwOB4jNk5r26jhb9nEmE/v3haZJDfr
 RIZ3IIblX5NZ6V6F9Um9M8/rzqmmQmWQVdL+4J6b2xHlBDL1LobkcP5k8+2X3VFjYay8uGt76Yr
 oKc0X1LfblOFq/U/6nJPqX2J1vg+4+ugzpIy6higlKqTOuNGv7wrc42qf8bKYwCc3o8zq49c8ei
 JfjWB23lalvtBQ8rK7ax/H0qHLUlbEh9oYuJr5Qu9hjgzB15e0hRrC1K0SfzxHnHK8QwTAkEeRg
 +UQ2W9oNoS/+VLNMRo6XRhupisQUERJwpYoedZaWihMTcsLGukCTR3BjNzfVCuMu71/VYAW3wy5
 9bfnoBwhwQMK2EfF04M7llrd8NQVaQYlqRaedjRPO8MreN89runzWu0WxJ0bL+wW0O2nKIhYI+p
 m5eBCCBGY=
X-Google-Smtp-Source: AGHT+IElSrOaHHzZ9ww1z2efUqbaAiDR5j2pVFHmdlkBpYVRCbQJgwm3jKGH4T81/qe7ylGGD42utA==
X-Received: by 2002:a5d:5889:0:b0:3cf:74e0:55b9 with SMTP id
 ffacd0b85a97d-3cf74e05a00mr1243338f8f.63.1756451333614; 
 Fri, 29 Aug 2025 00:08:53 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33add7f2sm2248694f8f.32.2025.08.29.00.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 00:08:53 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:06:34 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 12/61] target/arm: Drop define_one_arm_cp_reg_with_opaque
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-17-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-17-richard.henderson@linaro.org>
Message-ID: <t1quis.qr3o003jaimj@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
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

On Wed, 27 Aug 2025 04:04, Richard Henderson <richard.henderson@linaro.org> wrote:
>The last use of this interface was removed in 603bc048a27f
>("hw/arm: Remove pxa2xx_pic").  As the comment in gicv3
>stated, keeping pointer references to cpregs has SMP issues,
>so avoid future temptation by removing the interface.
>
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> target/arm/cpregs.h       | 32 ++++++++------------------------
> hw/intc/arm_gicv3_cpuif.c | 10 +---------
> target/arm/helper.c       | 29 +++++++++++------------------
> 3 files changed, 20 insertions(+), 51 deletions(-)
>
>diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
>index 3344a02bd3..b610716c24 100644
>--- a/target/arm/cpregs.h
>+++ b/target/arm/cpregs.h
>@@ -906,11 +906,7 @@ struct ARMCPRegInfo {
>      */
>     uint32_t nv2_redirect_offset;
> 
>-    /*
>-     * The opaque pointer passed to define_arm_cp_regs_with_opaque() when
>-     * this register was defined: can be used to hand data through to the
>-     * register read/write functions, since they are passed the ARMCPRegInfo*.
>-     */
>+    /* This is used only by VHE. */
>     void *opaque;
>     /*
>      * Value of this register, if it is ARM_CP_CONST. Otherwise, if
>@@ -1004,27 +1000,15 @@ struct ARMCPRegInfo {
> #define CPREG_FIELD64(env, ri) \
>     (*(uint64_t *)((char *)(env) + (ri)->fieldoffset))
> 
>-void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu, const ARMCPRegInfo *reg,
>-                                       void *opaque);
>+void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *regs);
>+void define_arm_cp_regs_len(ARMCPU *cpu, const ARMCPRegInfo *regs, size_t len);
> 
>-static inline void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *regs)
>-{
>-    define_one_arm_cp_reg_with_opaque(cpu, regs, NULL);
>-}
>-
>-void define_arm_cp_regs_with_opaque_len(ARMCPU *cpu, const ARMCPRegInfo *regs,
>-                                        void *opaque, size_t len);
>-
>-#define define_arm_cp_regs_with_opaque(CPU, REGS, OPAQUE)               \
>-    do {                                                                \
>-        QEMU_BUILD_BUG_ON(ARRAY_SIZE(REGS) == 0);                       \
>-        define_arm_cp_regs_with_opaque_len(CPU, REGS, OPAQUE,           \
>-                                           ARRAY_SIZE(REGS));           \
>+#define define_arm_cp_regs(CPU, REGS)                           \
>+    do {                                                        \
>+        QEMU_BUILD_BUG_ON(ARRAY_SIZE(REGS) == 0);               \
>+        define_arm_cp_regs_len(CPU, REGS, ARRAY_SIZE(REGS));    \
>     } while (0)
> 
>-#define define_arm_cp_regs(CPU, REGS) \
>-    define_arm_cp_regs_with_opaque(CPU, REGS, NULL)
>-
> const ARMCPRegInfo *get_arm_cp_reginfo(GHashTable *cpregs, uint32_t encoded_cp);
> 
> /*
>@@ -1143,7 +1127,7 @@ static inline bool arm_cpreg_traps_in_nv(const ARMCPRegInfo *ri)
>      * means that the right set of registers is exactly those where
>      * the opc1 field is 4 or 5. (You can see this also in the assert
>      * we do that the opc1 field and the permissions mask line up in
>-     * define_one_arm_cp_reg_with_opaque().)
>+     * define_one_arm_cp_reg().)
>      * Checking the opc1 field is easier for us and avoids the problem
>      * that we do not consistently use the right architectural names
>      * for all sysregs, since we treat the name field as largely for debug.
>diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
>index 4b4cf09157..72e91f971a 100644
>--- a/hw/intc/arm_gicv3_cpuif.c
>+++ b/hw/intc/arm_gicv3_cpuif.c
>@@ -3037,15 +3037,7 @@ void gicv3_init_cpuif(GICv3State *s)
>          *  cpu->gic_pribits
>          */
> 
>-        /* Note that we can't just use the GICv3CPUState as an opaque pointer
>-         * in define_arm_cp_regs_with_opaque(), because when we're called back
>-         * it might be with code translated by CPU 0 but run by CPU 1, in
>-         * which case we'd get the wrong value.
>-         * So instead we define the regs with no ri->opaque info, and
>-         * get back to the GICv3CPUState from the CPUARMState.
>-         *
>-         * These CP regs callbacks can be called from either TCG or HVF code.
>-         */
>+        /* These CP regs callbacks can be called from either TCG or HVF. */
>         define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
> 
>         /*
>diff --git a/target/arm/helper.c b/target/arm/helper.c
>index e03cbc0394..35a176ea3b 100644
>--- a/target/arm/helper.c
>+++ b/target/arm/helper.c
>@@ -7256,12 +7256,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
> }
> 
> /*
>- * Private utility function for define_one_arm_cp_reg_with_opaque():
>+ * Private utility function for define_one_arm_cp_reg():
>  * add a single reginfo struct to the hash table.
>  */
> static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
>-                                   void *opaque, CPState state,
>-                                   CPSecureState secstate,
>+                                   CPState state, CPSecureState secstate,
>                                    int crm, int opc1, int opc2,
>                                    const char *name)
> {
>@@ -7349,9 +7348,6 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
>     r2->opc2 = opc2;
>     r2->state = state;
>     r2->secure = secstate;
>-    if (opaque) {
>-        r2->opaque = opaque;
>-    }
> 
>     if (make_const) {
>         /* This should not have been a very special register to begin. */
>@@ -7456,8 +7452,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
> }
> 
> 
>-void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
>-                                       const ARMCPRegInfo *r, void *opaque)
>+void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
> {
>     /*
>      * Define implementations of coprocessor registers.
>@@ -7616,7 +7611,7 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
>                         if (nxs_ri.fgt) {
>                             nxs_ri.fgt |= R_FGT_NXS_MASK;
>                         }
>-                        add_cpreg_to_hashtable(cpu, &nxs_ri, opaque, state,
>+                        add_cpreg_to_hashtable(cpu, &nxs_ri, state,
>                                                ARM_CP_SECSTATE_NS,
>                                                crm, opc1, opc2, name);
>                     }
>@@ -7630,17 +7625,17 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
>                         switch (r->secure) {
>                         case ARM_CP_SECSTATE_S:
>                         case ARM_CP_SECSTATE_NS:
>-                            add_cpreg_to_hashtable(cpu, r, opaque, state,
>+                            add_cpreg_to_hashtable(cpu, r, state,
>                                                    r->secure, crm, opc1, opc2,
>                                                    r->name);
>                             break;
>                         case ARM_CP_SECSTATE_BOTH:
>                             name = g_strdup_printf("%s_S", r->name);
>-                            add_cpreg_to_hashtable(cpu, r, opaque, state,
>+                            add_cpreg_to_hashtable(cpu, r, state,
>                                                    ARM_CP_SECSTATE_S,
>                                                    crm, opc1, opc2, name);
>                             g_free(name);
>-                            add_cpreg_to_hashtable(cpu, r, opaque, state,
>+                            add_cpreg_to_hashtable(cpu, r, state,
>                                                    ARM_CP_SECSTATE_NS,
>                                                    crm, opc1, opc2, r->name);
>                             break;
>@@ -7652,7 +7647,7 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
>                          * AArch64 registers get mapped to non-secure instance
>                          * of AArch32
>                          */
>-                        add_cpreg_to_hashtable(cpu, r, opaque, state,
>+                        add_cpreg_to_hashtable(cpu, r, state,
>                                                ARM_CP_SECSTATE_NS,
>                                                crm, opc1, opc2, r->name);
>                     }
>@@ -7663,12 +7658,10 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
> }
> 
> /* Define a whole list of registers */
>-void define_arm_cp_regs_with_opaque_len(ARMCPU *cpu, const ARMCPRegInfo *regs,
>-                                        void *opaque, size_t len)
>+void define_arm_cp_regs_len(ARMCPU *cpu, const ARMCPRegInfo *regs, size_t len)
> {
>-    size_t i;
>-    for (i = 0; i < len; ++i) {
>-        define_one_arm_cp_reg_with_opaque(cpu, regs + i, opaque);
>+    for (size_t i = 0; i < len; ++i) {
>+        define_one_arm_cp_reg(cpu, regs + i);
>     }
> }
> 
>-- 
>2.43.0
>
>

