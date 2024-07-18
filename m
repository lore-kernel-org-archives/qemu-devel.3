Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6114CC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGd4-0003vT-CA; Wed, 17 Jul 2024 22:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcY-0001Dd-VT
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:53 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcR-0003cW-G5
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:45 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fc65329979so233445ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268702; x=1721873502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVutBx/1rvFWfLOrtQY3jqjYBvnyIfkoXQEDwqZMd/k=;
 b=YoKBtc7SDbKBH9vFYpPp0Wkbko517iSjJrFwsEKkYRkPrAP9lk2lSBcAlI+3mMyxIm
 ti9fmJCkYShFY6atr77T1o5/DJGK/7YBmFC9SoKU1EcYZMKke2tgQNexCg/G1ijqsTgo
 g7VH1RFhXn/6VBAeTDs2hzMR2GrNuP3su8AcJTqISANqYDuSWtlc2eLg2UkDy5kSTEZD
 44W1vt2YNme33JuSzeP1kCW48bkKqwyIKWUhTXUfwMl+b7oKQNVYM0m0enIvwovnGTaw
 H1n92j0bJYpalPmZIY+Lh99RzBRqiO1mUyUZHlkRnZeCVl2vgo7hvJGUzmigRZaqd8yN
 Q8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268702; x=1721873502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zVutBx/1rvFWfLOrtQY3jqjYBvnyIfkoXQEDwqZMd/k=;
 b=NmZUfjqYeb9NoH9/WuFlTKGg/ow53inhTqrgzgoGo8AHtE3ON1WAMRXsAKdAgpvpIm
 Ep/QARIA5k8JY3GcqoNkw8ItPqSQDNnflBhDxLZ/cuLTAOwWpxtRqDoNbFGO7JN4rlsG
 Oh+BAe5L7cu4dgBJV//Kco9/RXFtMdPU+eLBH4/m4i+6/1AzeAMKvbIORTtxev60xlJK
 U9PHwCDCW0GOJZagmBowbcN0MeynVOnnaDe+t0ebrjeTt/nVX8wAtLMSPyOgOzMBAauS
 FM3o6GQ5URixzUb07guibru8zMupfPCtWoEcvfJPA+kvMmshyO8wB4eZA6SCvg20yKXv
 mytA==
X-Gm-Message-State: AOJu0Yy780mZfy9lsuK1X/drL4Id+jIwHUCeJ6Ps4Crh8cwcXdUJmNt/
 6wJdezxTDlmx52uFfJbQ9Kneim392IbCsH1fzOjfmPem+kWnWRH9VmAJOU7U
X-Google-Smtp-Source: AGHT+IGYdMKK+I2/yRGeziF97KwbKvXYZj6cgyovVT4k2j4m24bmzrQcQ/qZP3NKrsPzslqJ6AldNA==
X-Received: by 2002:a17:902:da92:b0:1fc:5a11:4ac7 with SMTP id
 d9443c01a7336-1fc5a114bc1mr14286535ad.64.1721268701638; 
 Wed, 17 Jul 2024 19:11:41 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:11:41 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/30] target/riscv: Do not setup pmu timer if OF is disabled
Date: Thu, 18 Jul 2024 12:10:08 +1000
Message-ID: <20240718021012.2057986-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Atish Patra <atishp@rivosinc.com>

The timer is setup function is invoked in both hpmcounter
write and mcountinhibit write path. If the OF bit set, the
LCOFI interrupt is disabled. There is no benefitting in
setting up the qemu timer until LCOFI is cleared to indicate
that interrupts can be fired again.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20240711-smcntrpmf_v7-v8-12-b7c38ae7b263@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmu.c | 56 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index a4729f6c53..3cc0b3648c 100644
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
2.45.2


