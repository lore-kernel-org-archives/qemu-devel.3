Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93142C3DA4D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 22:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS2Ka-0001kK-Sk; Thu, 11 Jul 2024 18:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2KY-0001dU-NR
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:32:02 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2KK-0001eR-KJ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:32:02 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fb53bfb6easo10581405ad.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720737106; x=1721341906;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A3cArR5WRmWK1k/DcuOegvGiYxXTXfx2ryu99Fjf2H4=;
 b=InmEqWY4z3RdgZKc56iF6QLBoMismQpOaZBeqInwww0VZGsid7ZqR8zOb1H041PzlK
 nZiexQlrzUcintB2KEITVxCJAiW5S6rCooRttBoqwsodYEEkyDVp6eETqt3eHgHlpJZe
 b4cJxIQ+w4YdxD1o8bCMKfWbvEQGF8OfNMzJ/JRRinFNUJh0dMo+hM14NMSTCOe5Lp5h
 neHE07eZkvg4BcJht87U0azzdC4Np4G0J5W8dIjlMsew6pgQW13fYvCY98WplOQc/K1F
 Cjlf3sOFP+ubZuxuxumde5PBq3ZEafJvRlbJ2WONH6hllgatO3iGqbM1Yl+/idGkyPTS
 USFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720737106; x=1721341906;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A3cArR5WRmWK1k/DcuOegvGiYxXTXfx2ryu99Fjf2H4=;
 b=b/pA01xFaWc3O4reNI17JD/nBcG1rDe+2j0UYoNMuEo1K9FuRXTSV9rAr+gk4OW+wB
 R9I744w4sffFejWGDcosHEg5+r6BA7iODTU8kBf5Y2kN2p2HAIRPMUxxMSEsCyl5P92r
 tbVQkMEGQI3ChsKlW1kmYA4IRPkGkMk3Vf5PFE3phSb6FdPbbKG7jJqcwtReOXmmGSBL
 yorz+SejFdEmXt4UOKJQE6socaf62hRSLFfoBA6CqlrQJoLVf9RJYAbZrZHk7LzAY3LY
 ruHoGyEs+3gvcQ0F9/VkJgHHvBpYDpS2h6uuOpmFCCuYmwoQoHgfwlGakEDm+1a/84OD
 uDxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIIPqqWrfE+RLGLVTeszA6DD1ONqc2MWJGNERdXCTRyzNCmMa36i07/mUvhqNJ6lgnz4alKIn+VplH5AG3BMhQKVwERT8=
X-Gm-Message-State: AOJu0YxWUU5h/vUtvnq+J/7x63yjih+OQmvX4LFb09OPc//nslBA566i
 d4jMX431HTa2G8NBQ0cbmi6F51BsXCjZAoGN/koejYDuSiPiATqPRaMsloQ3sOk=
X-Google-Smtp-Source: AGHT+IGLnCReZd+vBiltlGXAwSbb53RogOi0iOxNrgwbCTCvXUBFfQFT5YK89pyLXaZUKJ+T8r6MvA==
X-Received: by 2002:a17:902:ce85:b0:1fb:5b83:48e4 with SMTP id
 d9443c01a7336-1fbb6ce52e0mr86611055ad.9.1720737106133; 
 Thu, 11 Jul 2024 15:31:46 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6b34ca2sm55161565ad.53.2024.07.11.15.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 15:31:45 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 11 Jul 2024 15:31:13 -0700
Subject: [PATCH v8 10/13] target/riscv: Start counters from both
 mhpmcounter and mcountinhibit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-smcntrpmf_v7-v8-10-b7c38ae7b263@rivosinc.com>
References: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
In-Reply-To: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

Currently we start timer counter from write_mhpmcounter path only
without checking for mcountinhibit bit. This changes adds mcountinhibit
check and also programs the counter from write_mcountinhibit as well.

When a counter is stopped using mcountinhibit we simply update
the value of the counter based on current host ticks and save
it for future reads.

We don't need to disable running timer as pmu_timer_trigger_irq
will discard the interrupt if the counter has been inhibited.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/csr.c | 75 ++++++++++++++++++++++++++++++++++++++----------------
 target/riscv/pmu.c |  3 +--
 2 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5ef641918120..ff06276192dd 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1077,8 +1077,9 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
     uint64_t mhpmctr_val = val;
 
     counter->mhpmcounter_val = val;
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
+    if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
+        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
+         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
         counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
                                                                 ctr_idx, false);
         if (ctr_idx > 2) {
@@ -1106,8 +1107,9 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
 
     counter->mhpmcounterh_val = val;
     mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
+    if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
+        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
+         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
         counter->mhpmcounterh_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
                                                                  ctr_idx, true);
         if (ctr_idx > 2) {
@@ -2170,31 +2172,60 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
     int cidx;
     PMUCTRState *counter;
     RISCVCPU *cpu = env_archcpu(env);
+    uint32_t present_ctrs = cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR;
+    target_ulong updated_ctrs = (env->mcountinhibit ^ val) & present_ctrs;
+    uint64_t mhpmctr_val, prev_count, curr_count;
 
     /* WARL register - disable unavailable counters; TM bit is always 0 */
-    env->mcountinhibit =
-        val & (cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR);
+    env->mcountinhibit = val & present_ctrs;
 
     /* Check if any other counter is also monitoring cycles/instructions */
     for (cidx = 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
-            counter = &env->pmu_ctrs[cidx];
-        if (get_field(env->mcountinhibit, BIT(cidx)) && (val & BIT(cidx))) {
-            /*
-             * Update the counter value for cycle/instret as we can't stop the
-             * host ticks. But we should show the current value at this moment.
-             */
-            if (riscv_pmu_ctr_monitor_cycles(env, cidx) ||
-                riscv_pmu_ctr_monitor_instructions(env, cidx)) {
-                counter->mhpmcounter_val =
-                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false) -
-                                           counter->mhpmcounter_prev +
-                                           counter->mhpmcounter_val;
+        if (!(updated_ctrs & BIT(cidx)) ||
+            (!riscv_pmu_ctr_monitor_cycles(env, cidx) &&
+            !riscv_pmu_ctr_monitor_instructions(env, cidx))) {
+            continue;
+        }
+
+        counter = &env->pmu_ctrs[cidx];
+
+        if (!get_field(env->mcountinhibit, BIT(cidx))) {
+            counter->mhpmcounter_prev =
+                riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
+            if (riscv_cpu_mxl(env) == MXL_RV32) {
+                counter->mhpmcounterh_prev =
+                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
+            }
+
+            if (cidx > 2) {
+                mhpmctr_val = counter->mhpmcounter_val;
                 if (riscv_cpu_mxl(env) == MXL_RV32) {
-                    counter->mhpmcounterh_val =
-                        riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true) -
-                                                counter->mhpmcounterh_prev +
-                                                counter->mhpmcounterh_val;
+                    mhpmctr_val = mhpmctr_val |
+                            ((uint64_t)counter->mhpmcounterh_val << 32);
                 }
+                riscv_pmu_setup_timer(env, mhpmctr_val, cidx);
+            }
+        } else {
+            curr_count = riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
+
+            mhpmctr_val = counter->mhpmcounter_val;
+            prev_count = counter->mhpmcounter_prev;
+            if (riscv_cpu_mxl(env) == MXL_RV32) {
+                uint64_t tmp =
+                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
+
+                curr_count = curr_count | (tmp << 32);
+                mhpmctr_val = mhpmctr_val |
+                    ((uint64_t)counter->mhpmcounterh_val << 32);
+                prev_count = prev_count |
+                    ((uint64_t)counter->mhpmcounterh_prev << 32);
+            }
+
+            /* Adjust the counter for later reads. */
+            mhpmctr_val = curr_count - prev_count + mhpmctr_val;
+            counter->mhpmcounter_val = mhpmctr_val;
+            if (riscv_cpu_mxl(env) == MXL_RV32) {
+                counter->mhpmcounterh_val = mhpmctr_val >> 32;
             }
         }
     }
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index ac648cff8d7c..63420d9f3679 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -285,8 +285,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
     }
 
     ctr_idx = GPOINTER_TO_UINT(value);
-    if (!riscv_pmu_counter_enabled(cpu, ctr_idx) ||
-        get_field(env->mcountinhibit, BIT(ctr_idx))) {
+    if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
         return -1;
     }
 

-- 
2.34.1


