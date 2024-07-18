Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC1FC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGcj-0001ts-9c; Wed, 17 Jul 2024 22:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcR-0000jE-GG
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:50 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcO-0003Yl-Mw
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:42 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fb3cf78ff3so3051695ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268699; x=1721873499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OMLqLPGdKpMpGa2NCFkYMyr470auwHqwk3KIR1TgvtY=;
 b=Yl9mlvDlhAItGYXtKfNptq8RT7aFJwlimGHtkiRnIUwyg9QFmkZDncTBjRW4YJzdw7
 zD53Jqgrke0LXOoLtjT4cBhQVW2qLBZ0z5h4TVpuVoq9uACi+khKfM+7g4bzQyXNIr5E
 dHGWNXvhgG9Aj95BnxjBS0B7NQdkJ9acRNP6TJShaiyOqpCodH4GiR43/e6h9epoDT1z
 fxUYJyitJtfrLNjXxseGCR/BM1hD9G5ez9Db/AcCIMowvaB+kuGZcUis/nqGKYdEJMGp
 uoT4vYoztype/++0OBBxB2054L9nIGGrzKBBgewmZwXaZ7/IX3gqdMhrGBEC7FuQMpPY
 6a2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268699; x=1721873499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMLqLPGdKpMpGa2NCFkYMyr470auwHqwk3KIR1TgvtY=;
 b=RHOm1Xy7AhlO+hMzOP3nsy0bF8eJQXnDTkwsT5jxEIk40Pp/h5Q456TGfmQDwnE1eK
 4Twnninq97V/d9Y9j7DI1zgJ6yzYtsSs8Yg6YuPxl2Q4nfD8I5asD+LqUMmqi9Vpxrff
 zb/mUeV0QVZjAf9v7yESD8re4k6gsPyQcK9v+7ls1/zsDG33Chsno4PBP5ls3Mr3xyuI
 n6J+ZUtBExt3OVL0M7pUttft2r9DiTnrS4pp8/aaQ7GZdNPohro5BFjqFxeJ6htVO8TH
 5Gec1hXmK3z5Y5n4mrqZuZgILjrRhLZnzgxBFqKoLYwqFZhHH6BKOpG3t0eoixBpJskm
 IRhg==
X-Gm-Message-State: AOJu0Yz5faN1tVY6rvjcuZLeHdE4eInl0io76BTTDZp0O7TGUUG6gVfs
 xEMPgx2QEn0woa2/mYCvn1ugTl54h/torR/ovPnqnfiW4sric4CPAkKrE6sh
X-Google-Smtp-Source: AGHT+IFTTNF2uvhHmncKcNZl6Wn8q8l2gZYzBAoqMjFAmwmZkvmYu4uX/CSbLkGghFp/aArmCDr7Hw==
X-Received: by 2002:a17:902:d4cc:b0:1fc:39b2:2967 with SMTP id
 d9443c01a7336-1fc4e1367femr39502855ad.14.1721268698722; 
 Wed, 17 Jul 2024 19:11:38 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:11:38 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/30] target/riscv: More accurately model priv mode filtering.
Date: Thu, 18 Jul 2024 12:10:07 +1000
Message-ID: <20240718021012.2057986-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

In case of programmable counters configured to count inst/cycles
we often end-up with counter not incrementing at all from kernel's
perspective.

For example:
- Kernel configures hpm3 to count instructions and sets hpmcounter
  to -10000 and all modes except U mode are inhibited.
- In QEMU we configure a timer to expire after ~10000 instructions.
- Problem is, it's often the case that kernel might not even schedule
  Umode task and we hit the timer callback in QEMU.
- In the timer callback we inject the interrupt into kernel, kernel
  runs the handler and reads hpmcounter3 value.
- Given QEMU maintains individual counters to count for each privilege
  mode, and given umode never ran, the umode counter didn't increment
  and QEMU returns same value as was programmed by the kernel when
  starting the counter.
- Kernel checks for overflow using previous and current value of the
  counter and reprograms the counter given there wasn't an overflow
  as per the counter value. (Which itself is a problem. We have QEMU
  telling kernel that counter3 overflowed but the counter value
  returned by QEMU doesn't seem to reflect that.).

This change makes sure that timer is reprogrammed from the handler
if the counter didn't overflow based on the counter value.

Second, this change makes sure that whenever the counter is read,
it's value is updated to reflect the latest count.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240711-smcntrpmf_v7-v8-11-b7c38ae7b263@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmu.h |  2 ++
 target/riscv/csr.c |  5 ++++-
 target/riscv/pmu.c | 30 +++++++++++++++++++++++++++---
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index ca40cfeed6..3853d0e262 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -36,5 +36,7 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
 void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
                                  bool new_virt);
+RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
+                                  bool upper_half, uint32_t ctr_idx);
 
 #endif /* RISCV_PMU_H */
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index bb6ac33ac2..781ef27eba 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1039,6 +1039,9 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
         goto done;
     }
 
+    /* Update counter before reading. */
+    riscv_pmu_update_fixed_ctrs(env, env->priv, env->virt_enabled);
+
     if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
         curr_val += counter_arr[PRV_M];
     }
@@ -1122,7 +1125,7 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
+RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
                                          bool upper_half, uint32_t ctr_idx)
 {
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 63420d9f36..a4729f6c53 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -425,6 +425,8 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
     target_ulong *mhpmevent_val;
     uint64_t of_bit_mask;
     int64_t irq_trigger_at;
+    uint64_t curr_ctr_val, curr_ctrh_val;
+    uint64_t ctr_val;
 
     if (evt_idx != RISCV_PMU_EVENT_HW_CPU_CYCLES &&
         evt_idx != RISCV_PMU_EVENT_HW_INSTRUCTIONS) {
@@ -454,6 +456,26 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
         return;
     }
 
+    riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctr_val, false, ctr_idx);
+    ctr_val = counter->mhpmcounter_val;
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctrh_val, true, ctr_idx);
+        curr_ctr_val = curr_ctr_val | (curr_ctrh_val << 32);
+        ctr_val = ctr_val |
+                ((uint64_t)counter->mhpmcounterh_val << 32);
+    }
+
+    /*
+     * We can not accommodate for inhibited modes when setting up timer. Check
+     * if the counter has actually overflowed or not by comparing current
+     * counter value (accommodated for inhibited modes) with software written
+     * counter value.
+     */
+    if (curr_ctr_val >= ctr_val) {
+        riscv_pmu_setup_timer(env, curr_ctr_val, ctr_idx);
+        return;
+    }
+
     if (cpu->pmu_avail_ctrs & BIT(ctr_idx)) {
         /* Generate interrupt only if OF bit is clear */
         if (!(*mhpmevent_val & of_bit_mask)) {
@@ -475,7 +497,7 @@ void riscv_pmu_timer_cb(void *priv)
 
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
 {
-    uint64_t overflow_delta, overflow_at;
+    uint64_t overflow_delta, overflow_at, curr_ns;
     int64_t overflow_ns, overflow_left = 0;
     RISCVCPU *cpu = env_archcpu(env);
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
@@ -506,8 +528,10 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
     } else {
         return -1;
     }
-    overflow_at = (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                  overflow_ns;
+    curr_ns = (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    overflow_at =  curr_ns + overflow_ns;
+    if (overflow_at <= curr_ns)
+        overflow_at = UINT64_MAX;
 
     if (overflow_at > INT64_MAX) {
         overflow_left += overflow_at - INT64_MAX;
-- 
2.45.2


