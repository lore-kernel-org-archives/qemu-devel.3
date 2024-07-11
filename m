Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC23C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 22:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS2KK-0000hp-Kv; Thu, 11 Jul 2024 18:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2KI-0000Zo-92
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:46 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sS2KG-0001d4-BB
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:31:46 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fb472eacf4so9104605ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720737103; x=1721341903;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BW5+TxeQ3j3oHVi+BKnOm1Q4Ol2XxFfjITvZ7dSErUo=;
 b=phzZ6RjUciSySo+rMQlBqyDp6uXxtXV5wuIt5DnhOCtpp2dSQgJ3EGSE3+MeVArgXi
 ocOfnNvbjzz85mLufGU7OWUXUkOkUY+LGArouizZZxQZ/tz3WvmZGXVdljcKDJaWAwUs
 IEy/zGVaOL18mGYl84SpIWl7YWid2Wv7Ls0z19YoQvIriPS9QBFyAIpNkS2wzNg+M9+V
 4nY+5RHQgDSsxewvT5HpL3khuQheipM95zciXLO6FOG67Oy9G304//iyz1+yCrO6SOuN
 qvpwFjfgLDljdonh3mThVKKAb3rBICjcU4Z6wPBoTuFJ/er35AEUY44J6bl4qff2ccth
 99ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720737103; x=1721341903;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BW5+TxeQ3j3oHVi+BKnOm1Q4Ol2XxFfjITvZ7dSErUo=;
 b=kdJ3HW24wut4IntbQIfeFWJdGey+ga3SzwJbTWHmpyt2btvgZ/3PFHJ6Mdrq7Bh0QX
 cQxDRYPiOI0OX1mvgfMo4MlscH0iZ5giufMRxVD8vy5861KM6H1RumGsDw/Z78Av1qkA
 OyRHlRFMnhfLikYyu8nYYqwaQQ4c9XGz3OyMt9ijknzljPRW0qBl8b3iGhq3WuUwNTcE
 KuWwFw4nQabgeffUgyfyT/aBz7MWTLm6i0TWdZ5V1M22DHrp8JjNcsB4oRe/4InQbAtz
 iQuD7A+yd9zNR7nrVpEIJqIcyPW5f+4SqTIfeTxrqGfAKKq1oQ4JP38sxIoEITBvj5tP
 AI4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSBfzm7uEA3GUEDS6opzOCzZpuDI96NXV35J118I0xvNRgEkWGKBoGyKqjdxisxtvFjRwgd6EZci/LAs5meMfpEXK5gjY=
X-Gm-Message-State: AOJu0YxxMTwmVHZZGdWZeQJRAvk55zJfGSNG8fCttrWmXwH8DvSRyrjZ
 ViWURY13iUfyQzT+hFnlOULlMH2hXgEyUZvTD2AHnlyvqNsd10ltjYP6QDPT2uA=
X-Google-Smtp-Source: AGHT+IHOrYKTeUloSRwMvcoSCH4k/m7NJQwDYvZ03jOgWvmyL1/tJWRS7wgrCQJ3SvEdFh5uvcc+YA==
X-Received: by 2002:a17:903:1cc:b0:1fb:9a61:6fe with SMTP id
 d9443c01a7336-1fbb6edf5d2mr69698785ad.58.1720737103105; 
 Thu, 11 Jul 2024 15:31:43 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6b34ca2sm55161565ad.53.2024.07.11.15.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 15:31:41 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 11 Jul 2024 15:31:11 -0700
Subject: [PATCH v8 08/13] target/riscv: Save counter values during
 countinhibit update
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-smcntrpmf_v7-v8-8-b7c38ae7b263@rivosinc.com>
References: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
In-Reply-To: <20240711-smcntrpmf_v7-v8-0-b7c38ae7b263@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x631.google.com
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

Currently, if a counter monitoring cycle/instret is stopped via
mcountinhibit we just update the state while the value is saved
during the next read. This is not accurate as the read may happen
many cycles after the counter is stopped. Ideally, the read should
return the value saved when the counter is stopped.

Thus, save the value of the counter during the inhibit update
operation and return that value during the read if corresponding bit
in mcountihibit is set.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.h     |  1 -
 target/riscv/csr.c     | 34 ++++++++++++++++++++++------------
 target/riscv/machine.c |  5 ++---
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d56d640b06be..91fe2a46ba35 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -153,7 +153,6 @@ typedef struct PMUCTRState {
     target_ulong mhpmcounter_prev;
     /* Snapshort value of a counter in RV32 */
     target_ulong mhpmcounterh_prev;
-    bool started;
     /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt trigger */
     target_ulong irq_overflow_left;
 } PMUCTRState;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 53f1a7ff00db..5e76ad5a350c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1131,17 +1131,11 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
 
     if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
         /*
-         * Counter should not increment if inhibit bit is set. We can't really
-         * stop the icount counting. Just return the counter value written by
-         * the supervisor to indicate that counter was not incremented.
+         * Counter should not increment if inhibit bit is set. Just return the
+         * current counter value.
          */
-        if (!counter->started) {
-            *val = ctr_val;
-            return RISCV_EXCP_NONE;
-        } else {
-            /* Mark that the counter has been stopped */
-            counter->started = false;
-        }
+         *val = ctr_val;
+         return RISCV_EXCP_NONE;
     }
 
     /*
@@ -2183,9 +2177,25 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
 
     /* Check if any other counter is also monitoring cycles/instructions */
     for (cidx = 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
-        if (!get_field(env->mcountinhibit, BIT(cidx))) {
             counter = &env->pmu_ctrs[cidx];
-            counter->started = true;
+        if (get_field(env->mcountinhibit, BIT(cidx)) && (val & BIT(cidx))) {
+            /*
+             * Update the counter value for cycle/instret as we can't stop the
+             * host ticks. But we should show the current value at this moment.
+             */
+            if (riscv_pmu_ctr_monitor_cycles(env, cidx) ||
+                riscv_pmu_ctr_monitor_instructions(env, cidx)) {
+                counter->mhpmcounter_val =
+                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false) -
+                                           counter->mhpmcounter_prev +
+                                           counter->mhpmcounter_val;
+                if (riscv_cpu_mxl(env) == MXL_RV32) {
+                    counter->mhpmcounterh_val =
+                        riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true) -
+                                                counter->mhpmcounterh_prev +
+                                                counter->mhpmcounterh_val;
+                }
+            }
         }
     }
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 76f2150f78b5..492c2c6d9d79 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -320,15 +320,14 @@ static bool pmu_needed(void *opaque)
 
 static const VMStateDescription vmstate_pmu_ctr_state = {
     .name = "cpu/pmu",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = pmu_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(mhpmcounter_val, PMUCTRState),
         VMSTATE_UINTTL(mhpmcounterh_val, PMUCTRState),
         VMSTATE_UINTTL(mhpmcounter_prev, PMUCTRState),
         VMSTATE_UINTTL(mhpmcounterh_prev, PMUCTRState),
-        VMSTATE_BOOL(started, PMUCTRState),
         VMSTATE_END_OF_LIST()
     }
 };

-- 
2.34.1


