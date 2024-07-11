Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97A9C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 22:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS2KP-00013B-Qk; Thu, 11 Jul 2024 18:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2KO-0000wZ-0X
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:52 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2KL-0001f1-Ty
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:51 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fb3cf78fbdso9714845ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720737108; x=1721341908;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fPS11BBBq2Nn4RJ2JAWB0GCizp88P/htp+YkSfYLhzE=;
 b=ll1Jquh/SzqAUaxaPuW/H75yUA4YErk7ut+723IVQZjQ3+binf/HPxTFdQWW0mB2HN
 KwfX9GJFOrLvg6pRt7C4QSJlhw0kYp9y/UhJSJxhzRlLKr1UAV15xT6T6izAxDCQoTWh
 F81l/1acv/QKS5jwJmu4HpLS1Gjg+ZXqwsgNFv3umKQOIl9hAghzKiaTjn85TE64iWF1
 mruQJWrhCXisCQAu4HHA3+Mr4ajAnH40eTxxsnDKOF33ecMA1FAOfKFtS3Cv95glrkGh
 Djxxd5nTTHXofBrsPKgQnggKI6peLigGPlxc/I4vQpIXhzoJHH0DuWqqSEVkezafdemH
 ZIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720737108; x=1721341908;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fPS11BBBq2Nn4RJ2JAWB0GCizp88P/htp+YkSfYLhzE=;
 b=LRbcjLK0fsz9M7H8OVXk3t8QKQngnEgUXYsvmk/PELkMeKqL+ZVKnw0rcWzjnSS/r3
 Yjhr3ZLO9G+B0VcZPsWgW0vvsdMBT2omSqKLdbz5i5n6OSgb442R9fMUjE0Ls+DjfdLy
 aq7IVWAWHB4ukJhq/hQNJ12yK8oy/nRN1fUbTNFoydyAEzaMNRDEUneoJdnTnqe2hAFm
 Zbyx0EtfLG+iRfXtL94yo1eOFleHaxSjUeAQKnEjP4450VIPgZVysr7GZZ3FIs8BVD6h
 GzvGJ2SLmuuyNQiHb4mcFWEupZ1Bmcegzq0cPPCAPi0QWFeNdT9Ek7WN7yqfUa02Nfni
 rW/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVzzQ0cleavc4i5F/7S8CZCJhSQl9MAX07vD8keTRWf/6abrSDMRGdNXLBE8wAFB3bLMPV9HTPfU+2J45Jo3ih19srM2w=
X-Gm-Message-State: AOJu0YxLIrWgDLMvmj8jEadiRu0OMrruP5Bh9Wp+IO5ipOMLlZvI7qRP
 Rk1Xaw+LdjH/W+6ce3abpzYMPUX8hWqJoZBAzJnlDEIc46k+ou7TYp95nRi1Mn0=
X-Google-Smtp-Source: AGHT+IHbrIsqx1w/2VoacGalx9V8z1VIGvenzCaqA2OmOGNusj6q1D2VXdqrJu6lKO8jEeJkmEhmeQ==
X-Received: by 2002:a17:902:e806:b0:1fb:a38b:c5a0 with SMTP id
 d9443c01a7336-1fbb6d0855bmr86588575ad.31.1720737108429; 
 Thu, 11 Jul 2024 15:31:48 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6b34ca2sm55161565ad.53.2024.07.11.15.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 15:31:48 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 11 Jul 2024 15:31:15 -0700
Subject: [PATCH v8 12/13] target/riscv: Do not setup pmu timer if OF is
 disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-smcntrpmf_v7-v8-12-b7c38ae7b263@rivosinc.com>
References: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
In-Reply-To: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The timer is setup function is invoked in both hpmcounter
write and mcountinhibit write path. If the OF bit set, the
LCOFI interrupt is disabled. There is no benefitting in
setting up the qemu timer until LCOFI is cleared to indicate
that interrupts can be fired again.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/pmu.c | 56 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index a4729f6c53bb..3cc0b3648cad 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -416,14 +416,49 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
     return 0;
 }
 
+static bool pmu_hpmevent_is_of_set(CPURISCVState *env, uint32_t ctr_idx)
+{
+    target_ulong mhpmevent_val;
+    uint64_t of_bit_mask;
+
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        mhpmevent_val = env->mhpmeventh_val[ctr_idx];
+        of_bit_mask = MHPMEVENTH_BIT_OF;
+     } else {
+        mhpmevent_val = env->mhpmevent_val[ctr_idx];
+        of_bit_mask = MHPMEVENT_BIT_OF;
+    }
+
+    return get_field(mhpmevent_val, of_bit_mask);
+}
+
+static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
+{
+    target_ulong *mhpmevent_val;
+    uint64_t of_bit_mask;
+
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        mhpmevent_val = &env->mhpmeventh_val[ctr_idx];
+        of_bit_mask = MHPMEVENTH_BIT_OF;
+     } else {
+        mhpmevent_val = &env->mhpmevent_val[ctr_idx];
+        of_bit_mask = MHPMEVENT_BIT_OF;
+    }
+
+    if (!get_field(*mhpmevent_val, of_bit_mask)) {
+        *mhpmevent_val |= of_bit_mask;
+        return true;
+    }
+
+    return false;
+}
+
 static void pmu_timer_trigger_irq(RISCVCPU *cpu,
                                   enum riscv_pmu_event_idx evt_idx)
 {
     uint32_t ctr_idx;
     CPURISCVState *env = &cpu->env;
     PMUCTRState *counter;
-    target_ulong *mhpmevent_val;
-    uint64_t of_bit_mask;
     int64_t irq_trigger_at;
     uint64_t curr_ctr_val, curr_ctrh_val;
     uint64_t ctr_val;
@@ -439,12 +474,9 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
         return;
     }
 
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        mhpmevent_val = &env->mhpmeventh_val[ctr_idx];
-        of_bit_mask = MHPMEVENTH_BIT_OF;
-     } else {
-        mhpmevent_val = &env->mhpmevent_val[ctr_idx];
-        of_bit_mask = MHPMEVENT_BIT_OF;
+    /* Generate interrupt only if OF bit is clear */
+    if (pmu_hpmevent_is_of_set(env, ctr_idx)) {
+        return;
     }
 
     counter = &env->pmu_ctrs[ctr_idx];
@@ -477,9 +509,7 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
     }
 
     if (cpu->pmu_avail_ctrs & BIT(ctr_idx)) {
-        /* Generate interrupt only if OF bit is clear */
-        if (!(*mhpmevent_val & of_bit_mask)) {
-            *mhpmevent_val |= of_bit_mask;
+        if (pmu_hpmevent_set_of_if_clear(env, ctr_idx)) {
             riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
         }
     }
@@ -502,7 +532,9 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
     RISCVCPU *cpu = env_archcpu(env);
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
 
-    if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->cfg.ext_sscofpmf) {
+    /* No need to setup a timer if LCOFI is disabled when OF is set */
+    if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->cfg.ext_sscofpmf ||
+        pmu_hpmevent_is_of_set(env, ctr_idx)) {
         return -1;
     }
 

-- 
2.34.1


