Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AE9CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298g-0007XX-ON; Fri, 26 Sep 2025 10:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298V-0007Ko-MF
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:23 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298E-0005fl-CY
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:22 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so1766998f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895741; x=1759500541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=apLLASp4weKyN7zWsCtf8AKJ98rMJgUXlQ4z+73SGew=;
 b=elcBGXhfoWk1ca29fCqpJibV/D/E9i9Us78O38eMEexmetDZo6XrBPsl2CGMGzBHFK
 77yywEfjgP5bZdJMjBsELRcoTUaoCtGJUm6NlZ87mtmR+Y3+xaQjJDTZlPFC1i2r0R/I
 88yW71QBtDj+hWboM0idBfliGIgxIlrpjZTqsvM8W32yMJlZzMNp/7v6BJBHbR2gNoB3
 qumk+g5V8o+zULFhq4cbJuRAZDwV3oqeTfpVlWTaEWGbbXWo6jjCp1JnJuUbh3HyQUwI
 8RJWg5zjZIyukV5q5jw0BlC+m6Jm6dGILO8+HCZSEWa+gvgccfj76bAB/9alsdNaYaGF
 KcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895741; x=1759500541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=apLLASp4weKyN7zWsCtf8AKJ98rMJgUXlQ4z+73SGew=;
 b=dXgmWHDDceuEgdHmLmJKkJ4NXmqk6hMuK5cVIVJYmq/17OlyACq4Qf92Oex4FBylpS
 vJm/UaMkoeu+w6Q/irV8eIG+GnnC0tLjNxmD/+jXCmnrmodh/HjzAFhk7jp2PcUM27iA
 n0saqSmSqm2eGrPM30te4t4i0vG+BUo79YP6QXjZlmkuuCgjvkGc/DeZoKH/DXLra8UH
 hN9junAj7abxuzvu+jPbOWGUO+SoKi9SA1nncDBS8XXBX1QbjrDQBINrSsLHjyfZYhHE
 lVBfuFGhR3VO9hC5yqOgvv63ZUECFVWRhNP5l+aZk+hyBY9TdeazfW4MfM2DtsEKU3DN
 oLNQ==
X-Gm-Message-State: AOJu0YwbGCLO4z++ngCu2IidS8L0Mcd0z82rf18kytE9v/1JhAgswe1Q
 axeB5sMm+FU2WKFYIItXCnEToVxhWWnH4VgbFfxfYpcG7t2iTEZbt3ijAkfAkcw8ny5yXX7/83l
 zy9TQ
X-Gm-Gg: ASbGncsCH8DVPow6/9BIQ6aYfOksyZ1Nj/rp4pFoz36R2Exu0cQ3z7YCMbEhShWXndh
 6gPIGNBM6JHblNJbouR9i4JZNLGbh391BhadFipsQJtF5dxON6v1bX/C7xsEXn/dEneJkop6XSw
 2s+CuJUhUTGi/KnsPe+0UFa5RQUOBd10WNodk0JKN6e8STv51OJ4ohoET7k1ykYsUx6hqikc2Kv
 X3VbZqV5PDMR36jpfhPnyWwVGv6vfBUZVPHEnSH5+q2xvBTumxBQCkxH4T/czuXTPe/VE9XDDBy
 dhQQmciU8hhGF0/OqrsyApRipVrh5XHoYDU8By928TiT4Zw4+MpsVlgUroh0v/uEYRpAoy4cC2T
 ajdJ//lu4nncb0lVX0SpSx2X2O4wx
X-Google-Smtp-Source: AGHT+IES8WEcjchgptnlNTXXyi+JNRvV3wB2zq3FdRYGmusigJEa5Ei31F+5Xv6dsypfAr4ChKFRpg==
X-Received: by 2002:a05:6000:26cf:b0:3ee:1125:5250 with SMTP id
 ffacd0b85a97d-40e46ad0128mr7048187f8f.24.1758895741139; 
 Fri, 26 Sep 2025 07:09:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/44] target/arm: Drop define_one_arm_cp_reg_with_opaque
Date: Fri, 26 Sep 2025 15:08:14 +0100
Message-ID: <20250926140844.1493020-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

The last use of this interface was removed in 603bc048a27f
("hw/arm: Remove pxa2xx_pic").  As the comment in gicv3
stated, keeping pointer references to cpregs has SMP issues,
so avoid future temptation by removing the interface.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h       | 32 ++++++++------------------------
 hw/intc/arm_gicv3_cpuif.c | 10 +---------
 target/arm/helper.c       | 29 +++++++++++------------------
 3 files changed, 20 insertions(+), 51 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 8f3e728d8ed..d02d74f1f5d 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -931,11 +931,7 @@ struct ARMCPRegInfo {
      */
     uint32_t nv2_redirect_offset;
 
-    /*
-     * The opaque pointer passed to define_arm_cp_regs_with_opaque() when
-     * this register was defined: can be used to hand data through to the
-     * register read/write functions, since they are passed the ARMCPRegInfo*.
-     */
+    /* This is used only by VHE. */
     void *opaque;
     /*
      * Value of this register, if it is ARM_CP_CONST. Otherwise, if
@@ -1029,27 +1025,15 @@ struct ARMCPRegInfo {
 #define CPREG_FIELD64(env, ri) \
     (*(uint64_t *)((char *)(env) + (ri)->fieldoffset))
 
-void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu, const ARMCPRegInfo *reg,
-                                       void *opaque);
+void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *regs);
+void define_arm_cp_regs_len(ARMCPU *cpu, const ARMCPRegInfo *regs, size_t len);
 
-static inline void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *regs)
-{
-    define_one_arm_cp_reg_with_opaque(cpu, regs, NULL);
-}
-
-void define_arm_cp_regs_with_opaque_len(ARMCPU *cpu, const ARMCPRegInfo *regs,
-                                        void *opaque, size_t len);
-
-#define define_arm_cp_regs_with_opaque(CPU, REGS, OPAQUE)               \
-    do {                                                                \
-        QEMU_BUILD_BUG_ON(ARRAY_SIZE(REGS) == 0);                       \
-        define_arm_cp_regs_with_opaque_len(CPU, REGS, OPAQUE,           \
-                                           ARRAY_SIZE(REGS));           \
+#define define_arm_cp_regs(CPU, REGS)                           \
+    do {                                                        \
+        QEMU_BUILD_BUG_ON(ARRAY_SIZE(REGS) == 0);               \
+        define_arm_cp_regs_len(CPU, REGS, ARRAY_SIZE(REGS));    \
     } while (0)
 
-#define define_arm_cp_regs(CPU, REGS) \
-    define_arm_cp_regs_with_opaque(CPU, REGS, NULL)
-
 const ARMCPRegInfo *get_arm_cp_reginfo(GHashTable *cpregs, uint32_t encoded_cp);
 
 /*
@@ -1168,7 +1152,7 @@ static inline bool arm_cpreg_traps_in_nv(const ARMCPRegInfo *ri)
      * means that the right set of registers is exactly those where
      * the opc1 field is 4 or 5. (You can see this also in the assert
      * we do that the opc1 field and the permissions mask line up in
-     * define_one_arm_cp_reg_with_opaque().)
+     * define_one_arm_cp_reg().)
      * Checking the opc1 field is easier for us and avoids the problem
      * that we do not consistently use the right architectural names
      * for all sysregs, since we treat the name field as largely for debug.
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 4b4cf091570..72e91f971a4 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -3037,15 +3037,7 @@ void gicv3_init_cpuif(GICv3State *s)
          *  cpu->gic_pribits
          */
 
-        /* Note that we can't just use the GICv3CPUState as an opaque pointer
-         * in define_arm_cp_regs_with_opaque(), because when we're called back
-         * it might be with code translated by CPU 0 but run by CPU 1, in
-         * which case we'd get the wrong value.
-         * So instead we define the regs with no ri->opaque info, and
-         * get back to the GICv3CPUState from the CPUARMState.
-         *
-         * These CP regs callbacks can be called from either TCG or HVF code.
-         */
+        /* These CP regs callbacks can be called from either TCG or HVF. */
         define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
 
         /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7b23e7e5889..b76a0edb0f4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7355,12 +7355,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 }
 
 /*
- * Private utility function for define_one_arm_cp_reg_with_opaque():
+ * Private utility function for define_one_arm_cp_reg():
  * add a single reginfo struct to the hash table.
  */
 static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
-                                   void *opaque, CPState state,
-                                   CPSecureState secstate,
+                                   CPState state, CPSecureState secstate,
                                    int crm, int opc1, int opc2,
                                    const char *name)
 {
@@ -7448,9 +7447,6 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     r2->opc2 = opc2;
     r2->state = state;
     r2->secure = secstate;
-    if (opaque) {
-        r2->opaque = opaque;
-    }
 
     if (make_const) {
         /* This should not have been a very special register to begin. */
@@ -7555,8 +7551,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
 }
 
 
-void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
-                                       const ARMCPRegInfo *r, void *opaque)
+void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
 {
     /*
      * Define implementations of coprocessor registers.
@@ -7715,7 +7710,7 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
                         if (nxs_ri.fgt) {
                             nxs_ri.fgt |= R_FGT_NXS_MASK;
                         }
-                        add_cpreg_to_hashtable(cpu, &nxs_ri, opaque, state,
+                        add_cpreg_to_hashtable(cpu, &nxs_ri, state,
                                                ARM_CP_SECSTATE_NS,
                                                crm, opc1, opc2, name);
                     }
@@ -7729,17 +7724,17 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
                         switch (r->secure) {
                         case ARM_CP_SECSTATE_S:
                         case ARM_CP_SECSTATE_NS:
-                            add_cpreg_to_hashtable(cpu, r, opaque, state,
+                            add_cpreg_to_hashtable(cpu, r, state,
                                                    r->secure, crm, opc1, opc2,
                                                    r->name);
                             break;
                         case ARM_CP_SECSTATE_BOTH:
                             name = g_strdup_printf("%s_S", r->name);
-                            add_cpreg_to_hashtable(cpu, r, opaque, state,
+                            add_cpreg_to_hashtable(cpu, r, state,
                                                    ARM_CP_SECSTATE_S,
                                                    crm, opc1, opc2, name);
                             g_free(name);
-                            add_cpreg_to_hashtable(cpu, r, opaque, state,
+                            add_cpreg_to_hashtable(cpu, r, state,
                                                    ARM_CP_SECSTATE_NS,
                                                    crm, opc1, opc2, r->name);
                             break;
@@ -7751,7 +7746,7 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
                          * AArch64 registers get mapped to non-secure instance
                          * of AArch32
                          */
-                        add_cpreg_to_hashtable(cpu, r, opaque, state,
+                        add_cpreg_to_hashtable(cpu, r, state,
                                                ARM_CP_SECSTATE_NS,
                                                crm, opc1, opc2, r->name);
                     }
@@ -7762,12 +7757,10 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
 }
 
 /* Define a whole list of registers */
-void define_arm_cp_regs_with_opaque_len(ARMCPU *cpu, const ARMCPRegInfo *regs,
-                                        void *opaque, size_t len)
+void define_arm_cp_regs_len(ARMCPU *cpu, const ARMCPRegInfo *regs, size_t len)
 {
-    size_t i;
-    for (i = 0; i < len; ++i) {
-        define_one_arm_cp_reg_with_opaque(cpu, regs + i, opaque);
+    for (size_t i = 0; i < len; ++i) {
+        define_one_arm_cp_reg(cpu, regs + i);
     }
 }
 
-- 
2.43.0


