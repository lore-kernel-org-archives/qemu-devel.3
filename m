Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435B4C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJX02-0003nH-Jd; Tue, 18 Jun 2024 07:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sJWzo-0003fM-C0
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:27:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sJWzk-0007yZ-Of
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:27:26 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4212b102935so3757615e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718710041; x=1719314841;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RENz7JQaP3Z2DOpOHwzXYz8SHC4pTV+PRNaAMchOSfk=;
 b=kj4Vhmj74j8I+6I0wz86xS5UN7OSNLNKWE7DoigBWAchsqdgp4CY2ge5oEWB5srH0t
 j4GTxqtDF7Anb8uvOUIXGvi5v1jbZWqCE8VQ5279sBqi7pDeDrrMgB9/b7fSGfubUwe1
 IWkbTm/NrduAuHRgl8cuRCxyIfbw7K1MujMNw/BCDTKhsVeLMuV3JJ40PYDI/JAZDiAb
 OReszrFRj3rTqCLjIUFAw8NGMW2vBsYRMoFncJyv0YjuknZwB6fEDxsGhKtjhSnQ/+OB
 NK6TkzyeOBmn9LFDvpB1bvo1NvN5+36Z4Z5tGzAl7BLvmvtTJFsDleY1QrsjPB4qH/uL
 23Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718710041; x=1719314841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RENz7JQaP3Z2DOpOHwzXYz8SHC4pTV+PRNaAMchOSfk=;
 b=TxsUX2iWazJYKO3QLFO2kUfT7LVj77wIrDWlS6v04xX0KFfD7H191ZVeuM81T5xUqR
 VjhLeguL7vEqBQYFe87oajmT0Mu+Lh2hhXMQq0ugh9KDrIxLvxkj29wfW4A6beILE6rN
 Z5S5/wq4sF3YswkjaGNm4qVqkjO3d5fIsO6TwZfRoN4P+WIz95FcH9akhHocjlEZ0zes
 owTm7YCBYFOSwM6exeBXP0RmbLj3aGFyHGC2SDCN8D8LbTKF03bwo+FbPDGIwkOeP0k2
 YzZgxs2bm717lUGY2ZsjZ+ZzIbc/mxR8MqFkq9sCoJxyz+D0ncFv6FSYSht+xyuLs5+G
 5tjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkFEvdc3ebivDUdXqv0lHQqitODLXXWfmyy93kMhipON/wyi/y6yaJTj0M4OCT8FULUtd9siH/xfGbhdEH8Zi7dbkjA6E=
X-Gm-Message-State: AOJu0Yy1kmWqys7P3rRMGOayNBTvp0soMmlvA/TxhjVQQjMwOmQY/jha
 /sJMRB+o4Hc5JCKy33SKWBjVwKFPNKHMvOMVLYzaQ2sGd//rn7pD+rGKC1Ya5bs=
X-Google-Smtp-Source: AGHT+IGQUR+ItdVrGYzNnFg9ogR/DwQcqbsRLzOvVokKC/gCBXZ6gXTycVfOl9MRlib76ORUT1ThQA==
X-Received: by 2002:a05:6000:1844:b0:35f:2584:76e9 with SMTP id
 ffacd0b85a97d-3607a76aa50mr9707645f8f.2.1718710040861; 
 Tue, 18 Jun 2024 04:27:20 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:45f5:4d94:4aa8:def4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36077536f78sm13747059f8f.7.2024.06.18.04.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 04:27:20 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 qemu-devel@nongnu.org, Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v2] target/riscv: fix instructions count handling in icount
 mode
Date: Tue, 18 Jun 2024 13:26:45 +0200
Message-ID: <20240618112649.76683-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When icount is enabled, rather than returning the virtual CPU time, we
should return the instruction count itself. Add an instructions bool
parameter to get_ticks() to correctly return icount_get_raw() when
icount_enabled() == 1 and instruction count is queried. This will modify
the existing behavior which was returning an instructions count close to
the number of cycles (CPI ~= 1).

Signed-off-by: Clément Léger <cleger@rivosinc.com>

---

v2:
 - Apply checkpatch and fixed missing braces

---
 target/riscv/csr.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 58ef7079dc..b8915e32a2 100644
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


