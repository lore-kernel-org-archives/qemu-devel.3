Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5911CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWau-0006PN-Ch; Tue, 16 Sep 2025 10:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaP-0005q9-Qg
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:15 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaI-0008Jm-V2
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:11 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-24457f581aeso55560315ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032570; x=1758637370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7wtwSeAyVxAyxj0iVv+zvWRTdY6KuYaJg6kG2AFAzk=;
 b=NMH3JlZpOMFCDSsdTOVQg8mrKJ10xaCPwptCa/oEVWyxKCpfJTyNy0Ad20edfl4czr
 URy1aX2RLBQPuP0S2+Olh/ba2woqhfdDw7KZdv9j6KC3nvzitXNV+xKxg4U3qzqw7eVo
 eObjjjq0Jl2QW5QrlxAhuAuhLLQXQpF2OsmR6kIL0gZsuq1HBGBQLHCery0oqt8N2rFo
 00fuQAxXTnF/JObfVivSyFnHNsQY2u6I9LCMc0nyhJ/hkH5jHpGj7BR6SRIojHHq0CrY
 dwNMs11JpVGT4rQ5kRh2IoLSub3poSuGIlheSbMPc7YUCBXTIqrIenlzkNpLVRH96Nrh
 f4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032570; x=1758637370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7wtwSeAyVxAyxj0iVv+zvWRTdY6KuYaJg6kG2AFAzk=;
 b=LDvuVZK04nUzdDrpBhm72pPKZmYjrHwpBxa5JRBjzNiKafQecG6xRWE1x0ZBb4Lxy+
 G6TL91M2nBXK847u/g0cpVaBl/KT1TCUTiFRUcf/Tmh0PY6Lf3zQ6O7lXiYTNtluX7DS
 9QZRJEilxvoCUJqve/pbhV1KMV9qV0350Z9Q8dNaycVxrOKNo2YN6f2v8qRFrpKeu04h
 ELOdxgSRTyJSJiw+uUYWWB2nfx7o3fblAteWPtOhfG85XYVVRx4vXHcqg9anzkuF2LDG
 tK+NgxPtCEaRsijYFP5YW5m083uldvLvq2vWpB3C5sds2FuwTlg+tAiQxMeq9Lq+rvZK
 ezTw==
X-Gm-Message-State: AOJu0YzuktMbzXB5Udxwh+AGreQQaAv4Zk0zIH/PW+e2qsG1Atjau9hH
 eMix+sfKPumgbOIcj2xtc/pgMqlCX5O0gCUoG0EDHpr2Sm3y1S9TiOy66onl0OqVcnpxuCih4be
 aPWyv
X-Gm-Gg: ASbGncsBpTr1VZ+3sM0o0WCBnUXOGpdme2tUOwx2gTz6rjcxHZrai0BZh0bmWzytzGv
 rl4/9j918HNb5I5CRocXJb1ggjuV9IX6lgfInS1/1mVhtXqRTxm3YERRTX5G9mxIURA7hleFMOU
 ckagWlfU2c8coDJBHrqNu2ouEPzrxlYqyHV3Z8bwoG2+f0q7Nd92eaSMWhQwBJN+Feg/VkHjD5b
 bDHNy9wcKv6SCrSjxt7ycCi6c8xAJcjSMp7slXLxaor6dz9A8fV4f8DZo1QVH3alX+SlfO18pHQ
 TriHamJW9Kzs2ib20q1bpZnnay90ccuXP+z/sttBpma8O/phJ6aYNonQ0b6JIXcl/rgKqk52tn9
 V8ohqhYYvymuChQAwr2zx+sdFtCRWnNqzfM7n/Jo=
X-Google-Smtp-Source: AGHT+IHlUQdVirHYnlXUBJTD6+fcQ4MnjOs0iMqeNKU+4UIsiEzUhUmfnCxvbsiawthsc7RzdNupvw==
X-Received: by 2002:a17:902:f68b:b0:264:ede2:683d with SMTP id
 d9443c01a7336-264ede26b0bmr117365955ad.56.1758032569582; 
 Tue, 16 Sep 2025 07:22:49 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 12/36] target/arm: Drop define_one_arm_cp_reg_with_opaque
Date: Tue, 16 Sep 2025 07:22:13 -0700
Message-ID: <20250916142238.664316-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

The last use of this interface was removed in 603bc048a27f
("hw/arm: Remove pxa2xx_pic").  As the comment in gicv3
stated, keeping pointer references to cpregs has SMP issues,
so avoid future temptation by removing the interface.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h       | 32 ++++++++------------------------
 hw/intc/arm_gicv3_cpuif.c | 10 +---------
 target/arm/helper.c       | 29 +++++++++++------------------
 3 files changed, 20 insertions(+), 51 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 3344a02bd3..b610716c24 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -906,11 +906,7 @@ struct ARMCPRegInfo {
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
@@ -1004,27 +1000,15 @@ struct ARMCPRegInfo {
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
@@ -1143,7 +1127,7 @@ static inline bool arm_cpreg_traps_in_nv(const ARMCPRegInfo *ri)
      * means that the right set of registers is exactly those where
      * the opc1 field is 4 or 5. (You can see this also in the assert
      * we do that the opc1 field and the permissions mask line up in
-     * define_one_arm_cp_reg_with_opaque().)
+     * define_one_arm_cp_reg().)
      * Checking the opc1 field is easier for us and avoids the problem
      * that we do not consistently use the right architectural names
      * for all sysregs, since we treat the name field as largely for debug.
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 4b4cf09157..72e91f971a 100644
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
index 4ba76c80b1..5bc8fb23cc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7410,12 +7410,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
@@ -7503,9 +7502,6 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     r2->opc2 = opc2;
     r2->state = state;
     r2->secure = secstate;
-    if (opaque) {
-        r2->opaque = opaque;
-    }
 
     if (make_const) {
         /* This should not have been a very special register to begin. */
@@ -7610,8 +7606,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
 }
 
 
-void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
-                                       const ARMCPRegInfo *r, void *opaque)
+void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
 {
     /*
      * Define implementations of coprocessor registers.
@@ -7770,7 +7765,7 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
                         if (nxs_ri.fgt) {
                             nxs_ri.fgt |= R_FGT_NXS_MASK;
                         }
-                        add_cpreg_to_hashtable(cpu, &nxs_ri, opaque, state,
+                        add_cpreg_to_hashtable(cpu, &nxs_ri, state,
                                                ARM_CP_SECSTATE_NS,
                                                crm, opc1, opc2, name);
                     }
@@ -7784,17 +7779,17 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
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
@@ -7806,7 +7801,7 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
                          * AArch64 registers get mapped to non-secure instance
                          * of AArch32
                          */
-                        add_cpreg_to_hashtable(cpu, r, opaque, state,
+                        add_cpreg_to_hashtable(cpu, r, state,
                                                ARM_CP_SECSTATE_NS,
                                                crm, opc1, opc2, r->name);
                     }
@@ -7817,12 +7812,10 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
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


