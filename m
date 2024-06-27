Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B301DC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlxj-000753-Q1; Thu, 27 Jun 2024 06:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxP-0006m0-19
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:23 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxM-0001sU-5X
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:22 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7065a2f4573so4560719b3a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482538; x=1720087338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PBJYVBwlZcM3vrZPZTYGjjElJE2GDldPlxWfqT4Lng=;
 b=VOp8qkKXUWdRmjQJ8EuZ/k0Q+H/gpH0K2WssbFr4ET9e6FZoowmfhxxsEOZkIP04ND
 JRXVH8VzACFgDadg/c6ZFs8PtSYUuL/xIptrxvq55XzVtYGuzoEII/CS3Ll+wl9aEiUU
 DYMfB1O99tx8L9CE3C9WYjhAqTjDRthTQlNq69YGW3LkesUjZmI+TPlRweeakqXwnY/X
 WtsUtO2DHLU3LE8e91SBxCMU5lxMY8kTj4mt9U7gy7S3ZxZR1OaiFuZL0fblZ+sPDNc4
 ZkU/Dca4eGWnWLL/gzhh9R1TKN9dOqbSWirNwOsTC8B4w3ox9J7YMdBDUGvkgfNxWg+8
 V9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482538; x=1720087338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3PBJYVBwlZcM3vrZPZTYGjjElJE2GDldPlxWfqT4Lng=;
 b=KlPkRdvkfTw6ogqgsbltpllPwV+iqyWUFFb3ZGLnCtiJCejd2zplbUZWxm3ofdmxrN
 cykiOJSlMlv4hD8Q/b4U48KZvMOvIhT7L9F9ecupc+Bm2ojLz4i1M1BTjlF+eoTWfbTS
 cCXk58t5zfQoDbh9y27jzjPqlCxH+oSUa+SdSEqmZ3T5Bo6237bAGWbPH/E97+hU/dub
 FUYvFQ7/bjBCrzCyaTWN85LUFch02YulgTUElXoweM5ou9k9rhDR2/dh42Xmp5aI6oRs
 LOvBMeMQd0kYMcZ9DovSH9YMf90ITayZ+35JVe5dcMbQ+B4g3dWCFVG/LJjZqxgnMEhA
 6m1Q==
X-Gm-Message-State: AOJu0YyL1ch/Ihph3rm2QN9hd5EvZE3YPK8ZsV7iFVlHZrgtO2ZgDxkJ
 TTqbQOlOJDT2gGwBKpdmUEFvHyFthx+7DrYJqA/EArR7SImRsrZ3Fo84Vu9R
X-Google-Smtp-Source: AGHT+IEJQM4eKkM4nv7oVkK3yujEJlkyul5WTiFcWAod+14xI0UFGni0M/8MtptwtINoDCwLVzUDgA==
X-Received: by 2002:a05:6a00:a06:b0:706:9073:45ee with SMTP id
 d2e1a72fcca58-70690734663mr10959698b3a.25.1719482538319; 
 Thu, 27 Jun 2024 03:02:18 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:02:17 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/32] target/riscv: fix instructions count handling in icount
 mode
Date: Thu, 27 Jun 2024 20:00:44 +1000
Message-ID: <20240627100053.150937-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
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

From: Clément Léger <cleger@rivosinc.com>

When icount is enabled, rather than returning the virtual CPU time, we
should return the instruction count itself. Add an instructions bool
parameter to get_ticks() to correctly return icount_get_raw() when
icount_enabled() == 1 and instruction count is queried. This will modify
the existing behavior which was returning an instructions count close to
the number of cycles (CPI ~= 1).

Signed-off-by: Clément Léger <cleger@rivosinc.com>

Reviewed-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20240618112649.76683-1-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6f15612e76..432c59dc66 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -762,14 +762,18 @@ static RISCVException write_vcsr(CPURISCVState *env, int csrno,
 }
 
 /* User Timers and Counters */
-static target_ulong get_ticks(bool shift)
+static target_ulong get_ticks(bool shift, bool instructions)
 {
     int64_t val;
     target_ulong result;
 
 #if !defined(CONFIG_USER_ONLY)
     if (icount_enabled()) {
-        val = icount_get();
+        if (instructions) {
+            val = icount_get_raw();
+        } else {
+            val = icount_get();
+        }
     } else {
         val = cpu_get_host_ticks();
     }
@@ -804,14 +808,14 @@ static RISCVException read_timeh(CPURISCVState *env, int csrno,
 static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
                                       target_ulong *val)
 {
-    *val = get_ticks(false);
+    *val = get_ticks(false, (csrno == CSR_INSTRET));
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
                                        target_ulong *val)
 {
-    *val = get_ticks(true);
+    *val = get_ticks(true, (csrno == CSR_INSTRETH));
     return RISCV_EXCP_NONE;
 }
 
@@ -875,11 +879,11 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
     int ctr_idx = csrno - CSR_MCYCLE;
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
     uint64_t mhpmctr_val = val;
+    bool instr = riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
 
     counter->mhpmcounter_val = val;
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        counter->mhpmcounter_prev = get_ticks(false);
+    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) || instr) {
+        counter->mhpmcounter_prev = get_ticks(false, instr);
         if (ctr_idx > 2) {
             if (riscv_cpu_mxl(env) == MXL_RV32) {
                 mhpmctr_val = mhpmctr_val |
@@ -902,12 +906,12 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
     uint64_t mhpmctr_val = counter->mhpmcounter_val;
     uint64_t mhpmctrh_val = val;
+    bool instr = riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
 
     counter->mhpmcounterh_val = val;
     mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        counter->mhpmcounterh_prev = get_ticks(true);
+    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) || instr) {
+        counter->mhpmcounterh_prev = get_ticks(true, instr);
         if (ctr_idx > 2) {
             riscv_pmu_setup_timer(env, mhpmctr_val, ctr_idx);
         }
@@ -926,6 +930,7 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
                                          counter->mhpmcounter_prev;
     target_ulong ctr_val = upper_half ? counter->mhpmcounterh_val :
                                         counter->mhpmcounter_val;
+    bool instr = riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
 
     if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
         /*
@@ -946,9 +951,8 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
      * The kernel computes the perf delta by subtracting the current value from
      * the value it initialized previously (ctr_val).
      */
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        *val = get_ticks(upper_half) - ctr_prev + ctr_val;
+    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) || instr) {
+        *val = get_ticks(upper_half, instr) - ctr_prev + ctr_val;
     } else {
         *val = ctr_val;
     }
-- 
2.45.2


