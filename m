Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BDDCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNx6-0001v3-Qd; Sat, 30 Aug 2025 11:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEN6-0006MF-G3
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:43:31 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEN2-0004Np-8D
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:43:26 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b49d3b48d8aso1795846a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532603; x=1757137403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=007qAvjrooYq7034Un0ES2KI2qZ/WO23zK0c0aGYG6M=;
 b=bwFn0qEEU9fot4uTSC/JUgqBEOhLuxZJaO/klxfjgOm/Q2n9LYvhDrKo//0kaK7PUs
 U8HyTjfdN62aQlc/Z/6bUY6HzQrpPOb47UXbnASnwXCYYwY5r5JoAoY84vQEdkbHLkEI
 qPl2G56e9oUuPq+u4pADmX0GWeK6KtIffulM0tSFDFyGSAWYwI8T6omw3nJi6r/FXOxe
 oJN5QAS4247KSYW8N08i04XmqkxBBhtzr4WXtbs267/Y3FoP6cUR8Q4Y9IbsBmMknuoU
 5IkJOp6MiuytxGYMj3yZOBHFrtRq//rM9zkWOknO/cFa3z1uFWOynsi91C3fZUWZ3ATl
 vBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532603; x=1757137403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=007qAvjrooYq7034Un0ES2KI2qZ/WO23zK0c0aGYG6M=;
 b=rIAqQIsXN+xxp+WQttGGWSKT5ZKABV2qCnVzBd8JmZyUZFJHk04I6e8x9jj9cLEay0
 f34gjrq2zjRN5AaqjaM6he3NiTMfwV0nF7qWKpE611O+Hzlmzd2DLu1ifoDn7ePKCjpa
 GHKGVeuHW8b66WMb7khxlUCrNmaWhw33K2fw0FRwJWlbVnRpAoMnr7rUqwvxF2E0Xfw4
 g2bN1nBaV7Ec3eGNlt3Te4jIBBx6wQL+qDJUavXbwobXpybBmGbsW9bKUv2CXzRPdJ87
 Y+m8Xup7KvJtfgkw+YfIF0cu4MK0u7DmmIADVZ3N9AZ/Pj3Dea+DMUHbxnq6zMcXdIP7
 t29g==
X-Gm-Message-State: AOJu0YzTvtR/BllYrw1bop+aQCLhw6+vNqeqWT3zinp8467NMf1yufP4
 pM+UUCI+sZkVtuHsdN+YPvvFOn6+n4KjvZmn9ekZNKvxIDvMBE0WYz7RMEn9xIluvEMfInzJuNl
 O/TkAiBQ=
X-Gm-Gg: ASbGncunuyRoNBcn6BYJG1IPcvEzXny8mvHa5u89yNUpsN/X9elupTs/X9A1nqcZthJ
 xMckvYPVRG0Et1DbRYFgDaC2RhsciygI41t2wO3w/crMDAKEF7AOkYGqn0dQ4O6toZ4/MWIYkiC
 UJxfcqA06BDBn2GxjrZnCEXwc/Re/bzQkUuG3Ll5WpieEJhDKbRAZobHZTWUN6aLjv/LbA7bgy4
 atORMwKusZajlFXlqGUaEzMBHHc0gfxMAm5LLPxD/kAhuPm+y7vuk6/7GhDP8kEIQPlc/SOIWf6
 u9LpWvqQfikVPgdS/5ECXen/JCfODOa3LOKEqLZMltz37JGo46H+t4Jb2OvfJi30E+aijtGw+aW
 gkM21XVjX0ujF6+fx3+ZFENpvQ2ibo1VK1TObJY9q5xFHlbxdnYuHv5r+Py5U
X-Google-Smtp-Source: AGHT+IGWyaA55K07CyAxEMV2PDXZHtfUpJtKfJraOyv1bikIeePI6x3hWr6oyGycjcxNmWI3mBslyg==
X-Received: by 2002:a05:6a20:244d:b0:243:ae10:2433 with SMTP id
 adf61e73a8af0-243d6f41727mr1737444637.40.1756532602616; 
 Fri, 29 Aug 2025 22:43:22 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:43:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 39/84] target/arm: Remove unused env argument from
 regime_is_user
Date: Sat, 30 Aug 2025 15:40:43 +1000
Message-ID: <20250830054128.448363-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  2 +-
 target/arm/helper.c    |  2 +-
 target/arm/ptw.c       | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 2148814835..1704ee8dbb 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1032,7 +1032,7 @@ static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
     return mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S;
 }
 
-static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
+static inline bool regime_is_user(ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_E10_0:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b88d1573ae..4901fd5388 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9586,7 +9586,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         ds = extract64(tcr, 59, 1);
 
         if (e0pd && cpu_isar_feature(aa64_e0pd, cpu) &&
-            regime_is_user(env, mmu_idx)) {
+            regime_is_user(mmu_idx)) {
             epd = true;
         }
 
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index a8c450d28b..23307b2760 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -964,7 +964,7 @@ static int ap_to_rw_prot(CPUARMState *env, ARMMMUIdx mmu_idx,
                          int ap, int domain_prot)
 {
    return ap_to_rw_prot_is_user(env, mmu_idx, ap, domain_prot,
-                                regime_is_user(env, mmu_idx));
+                                regime_is_user(mmu_idx));
 }
 
 /*
@@ -990,7 +990,7 @@ static int simple_ap_to_rw_prot_is_user(int ap, bool is_user)
 
 static int simple_ap_to_rw_prot(CPUARMState *env, ARMMMUIdx mmu_idx, int ap)
 {
-    return simple_ap_to_rw_prot_is_user(ap, regime_is_user(env, mmu_idx));
+    return simple_ap_to_rw_prot_is_user(ap, regime_is_user(mmu_idx));
 }
 
 static bool get_phys_addr_v5(CPUARMState *env, S1Translate *ptw,
@@ -1377,7 +1377,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
                       ARMSecuritySpace in_pa, ARMSecuritySpace out_pa)
 {
     ARMCPU *cpu = env_archcpu(env);
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
     bool have_wxn;
     int wxn = 0;
 
@@ -1539,7 +1539,7 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
         if ((u_perm & (PAGE_RWX | PAGE_GCS)) && regime_is_pan(mmu_idx)) {
             p_perm &= ~(PAGE_READ | PAGE_WRITE);
         }
-        perm = regime_is_user(env, mmu_idx) ? u_perm : p_perm;
+        perm = regime_is_user(mmu_idx) ? u_perm : p_perm;
     }
 
     if (in_pa != out_pa) {
@@ -2384,7 +2384,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
     uint32_t mask;
     uint32_t base;
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
 
     if (regime_translation_disabled(env, mmu_idx, ptw->in_space)) {
         /* MPU disabled.  */
@@ -2551,7 +2551,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
     ARMCPU *cpu = env_archcpu(env);
     int n;
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
     bool secure = arm_space_is_secure(ptw->in_space);
 
     result->f.phys_addr = address;
@@ -2771,7 +2771,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
      * memory system to use a subpage.
      */
     ARMCPU *cpu = env_archcpu(env);
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
     int n;
     int matchregion = -1;
     bool hit = false;
@@ -3651,7 +3651,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
         break;
     }
 
-    result->f.attrs.user = regime_is_user(env, mmu_idx);
+    result->f.attrs.user = regime_is_user(mmu_idx);
 
     /*
      * Fast Context Switch Extension. This doesn't exist at all in v8.
-- 
2.43.0


