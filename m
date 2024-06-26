Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A588C3065B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMcWQ-0007sg-I4; Wed, 26 Jun 2024 19:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sMcWO-0007qL-Ow
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:57:52 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sMcWN-0005Z9-4d
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:57:52 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fa244db0b2so37536965ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719446270; x=1720051070;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t71SRRSfC5H5RSbAHTZ+HHNmh04PdGKcyaMhHGUdPMc=;
 b=YQ9k7LdPXAgu8wwgoMZ+LDbQOwnqtfm7e+e/ZbCQG8oREgNO2CfhmvUelDkwOGpiln
 rrJIpZUUFmK2afnkl6LefQZV+/UnNXrgFftxwgkD1F9IJi2SyhpQ0isYd6roGQ5iKbEl
 DmNzVxxQzbQyMaM3P2pzGDLlKcbF+UtzUnD2100xPlRUjTBaAeQM8yWUHChksh54Yzfc
 s8Zf1/N6QopMMm+SHl95PhT6+aBgm1Kkgdynrbh1hxlhqKHaRe5j4MoXsF4noXGR9kQP
 UzHMDI9xxMdV0pv6aY0ATJiDxmcNqHe/JFvXEgEs0Xko8nLHN3r6XzfcprETR1q2Isxh
 I7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719446270; x=1720051070;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t71SRRSfC5H5RSbAHTZ+HHNmh04PdGKcyaMhHGUdPMc=;
 b=ce+fWT9HLAlrvRxk7fM+wrmgVZn64ruc9J/sCmmbXcXO6hZOXuiwbLU/MUuAKgChLW
 qQVgCjzaKkfsGpYZXATYV3Pc8viksJPM6+VMU/7ro61AVRf4WmN9w/q0EZv95/hCOa9L
 eX3NOdGJj8TR7eO+eNPeOQCLVQOjV3F19wC7q3wb0fQ+knQHp85WC8azz2VBXzu6gkuQ
 l9JYcNTLMhIp7kiMzuRU6gKBOesuxIxdgMAj2kEhPEDdmEx+GA3C64uFOgOYgcR/smy+
 sd2r5+Bx04G5Hxe0+naTJjY5q/O/REPAdOoR8dBko7JfaVBteR1kkD0pPbSmcA4FPRXK
 UGxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwaDKCkXERA+8TbUgzv+U+Cq2an+r2fKHEKggCVToNshNGN8JqFpIy9RH4MzCOTwkTH5EHvHRQglI2pSIYiBO3bAKY1ts=
X-Gm-Message-State: AOJu0YxGo2chBNRfbN/0ZUud4vj/1U/xvU8uc/9M+wxLAQGPBNORoZ+S
 BzsAAYPQno2OW7E8j5BtR2vpzbi/u4b64n3OSQ6tX5I/wiWvWCQjXSOpAHGxnUw=
X-Google-Smtp-Source: AGHT+IFznHoc86Vz0Tm6hqxg8f0sk8+SjilWuG8Y+2R57yr7bfNjdbVZDNrn8WjsGHKJwW0c3js1Pw==
X-Received: by 2002:a17:902:f689:b0:1f7:1b42:431d with SMTP id
 d9443c01a7336-1fa158e5aa8mr126873195ad.30.1719446269786; 
 Wed, 26 Jun 2024 16:57:49 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac998398sm630965ad.225.2024.06.26.16.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:57:49 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 26 Jun 2024 16:57:31 -0700
Subject: [PATCH v7 11/11] target/riscv: Do not setup pmu timer if OF is
 disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-smcntrpmf_v7-v7-11-bb0f10af7fa9@rivosinc.com>
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x62c.google.com
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


