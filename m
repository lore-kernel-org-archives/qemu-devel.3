Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3735C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGcP-0000FR-Kz; Wed, 17 Jul 2024 22:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcH-0008Eb-9L
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:33 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcF-0003WS-A0
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:32 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fb1c918860so11488495ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268690; x=1721873490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQ3ir6R/Un7beJ33KrZqh4N2Z21J7s720KQ1RD1Jasg=;
 b=grfRsYXeAaEtIHzbojI4ZKDCGnBt0rp3PSxkqrfJIQJQ22DazOAlluXFHra+laQ0bz
 ghxXq6Y9wnE6Bp8zuDb8dvw8s4pzdKmmwxrRb4LyC1m2t/ZYJg5DRoAnTUwk+65eOgBD
 zqgTXC4XJaqlDNJWDDyySCIoTGvx1Csklfg2ggwbB7O+Rjuk9qd84VJtgAIm9x0nCOAt
 VTar/C7aSbZ3cbqvdON4OrFxHpTf3YRdyyVuM4fBFIf95mbOyEZmm+S2W2Q1nzAoR1qX
 2QShPYI9HCOsA96xLBUX2WtRp7mgZlnbScbdXJyPzYcyI6IRJ5HVE2aLtuw87DJ5j33N
 P2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268690; x=1721873490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQ3ir6R/Un7beJ33KrZqh4N2Z21J7s720KQ1RD1Jasg=;
 b=Kt9BZmlTEmcExPjUdH33lLuJXRnXdTa3/jm6yBQGbk5JRfRG+HcmVJRJOFhKkhH48E
 MNS8cZmmcnzKi9Hq3zqW5kv21xPK9RHXl7VRBsPriAj2t5X6GqMsWWxTh4Bh6sq5BL2z
 qs6rUzxhXaSVvFsOofWBkAaI7Kv2dsD+P0ROOMDGXPu1lPZPQj8KOikTeNeis6esLq9R
 2QbBi1UjCvu8+xW3sgcqVw77rh9lUPUnkvgSzdpDFt+Df/GwF4VZfHzT3wTxb+lRh8LC
 basBRaINs7LmR58HkB9GrALuDSJGa/PV/z2nzPJ8tlkIRD6kP169BuzCp9E3XdJxmFPO
 wC/Q==
X-Gm-Message-State: AOJu0Yw6d+9DKod5/ZniwWj31BJ+YHPd1IK1H0Y8te25ZquR8rIWsdVS
 6zht4Fo9CNS84ozaom9Fg5w1Wei6yL1yMhhFgWSCQUAzxyMbfL3OjdIGfPGm
X-Google-Smtp-Source: AGHT+IH2U87xsLVD2oTDtR1OWGR5RIRUin0vpsbKm02pLrwk4A6dEFiXU2pgv2q6yzcJt93Mt6417w==
X-Received: by 2002:a17:903:234a:b0:1fb:7530:61c6 with SMTP id
 d9443c01a7336-1fc5b5e064bmr22294325ad.2.1721268689763; 
 Wed, 17 Jul 2024 19:11:29 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:11:29 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 22/30] target/riscv: Save counter values during countinhibit
 update
Date: Thu, 18 Jul 2024 12:10:04 +1000
Message-ID: <20240718021012.2057986-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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
Message-ID: <20240711-smcntrpmf_v7-v8-8-b7c38ae7b263@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     |  1 -
 target/riscv/csr.c     | 34 ++++++++++++++++++++++------------
 target/riscv/machine.c |  5 ++---
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f515ad072b..093c86b8b9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -176,7 +176,6 @@ typedef struct PMUCTRState {
     target_ulong mhpmcounter_prev;
     /* Snapshort value of a counter in RV32 */
     target_ulong mhpmcounterh_prev;
-    bool started;
     /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt trigger */
     target_ulong irq_overflow_left;
 } PMUCTRState;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 85d3f0aa3f..b7a24f9c60 100644
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
index 76f2150f78..492c2c6d9d 100644
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
2.45.2


