Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB96D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RG-0005uo-9s; Fri, 09 Jan 2026 01:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Po-0004BG-HA
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:10 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Pm-0002sR-OE
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:08 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c2dd0c24e5cso1858585a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941764; x=1768546564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NUVJ50pMerMBWSn7Z98nJwbK+qbScAloCXDstwpPmJA=;
 b=b3SfkJJIfPXlsEWILz2ExgLXcd+KBt0QxeWFdtOhgcm7nF/6sL4+8qtayx3YCUhSp9
 Hngu9FJDajlkEDV7PBQqIfdGhDywKVmDImBslfwUwO/0wvMAtM7VxHKjjdPVj7f5+4IT
 23XeFK98O0TD5uwz2TuA6dYRFtU8+sfyLZtu55vXuSAfXu0jOPc2L15iWL9C9b6qO29u
 CuwCVc0xdayHkV+f5yk11n0lHx6hIsxH+UNkFPx6nSbnW3DT87QQewVkpG6P8WQE5Yy/
 Mw2XP2UoVUyzdl73pV2TxpiEGUTFawvy5W0bfwgAI7WpZLLC+PnFG29Z1QuyhevhFsSR
 SEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941764; x=1768546564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NUVJ50pMerMBWSn7Z98nJwbK+qbScAloCXDstwpPmJA=;
 b=B90JRqTPA5PudYA1E3Yauyza4N5wLFE2K5YpZXU8x8aY+EobL//NcjLzkn5K48TpxP
 XElo/ePfT+0UfSnf9NpxgoAYQOyKWF686jiZPdp1s87uM+Y6RZ/vm0gip7uByvfl1TsU
 UlOYPzdQ9ueZnnEwu87PO877RziVH3YTdl+g83V5sz4CxWOgNhVPIx7nDPGIinDfc8Ml
 zw1lT+sc9Ms7JX+m8WgvFMyZPf+B703S0MVPyZmCXgtCfBR6bMm7GuKPQBSZl0VvXVK2
 Yi/KkHZqufZg1Wp0ZXWZpt43PBfdGk8/eCSGgE16EGl2U/rZPSFzwN7z2/+fy8ywaNDm
 bRzQ==
X-Gm-Message-State: AOJu0YzugB8m0u5mWLHbyOavBISDCQ/N6+k52WBmgVRd7GOhaU8bpiEQ
 4nCs/N4jSLcpHN76t7h1zHzzYBk+gpZLkUNnUwlMhTMZ9G7vx8VTJyyGBYVCwQ==
X-Gm-Gg: AY/fxX69+bgY1BRcHjx5WS8k6yqtduAR92i9xkPPlUu/ZsdPY/+WolPgr6GOqFswlSW
 1rWorDdCrXBhwU31/Gzu+/rptSdRcuoySvrX3MGjyJKoEp7XnZTlOIMUPI8zXGh0r7ym/mAH3f8
 x0KB4Bs5L7h2inEOQOVhfck/9ZWDajUnRagPLLMPdVymvCjknkIplxtJT+zU14q7MVcWNedUYsb
 DhcWVlTAj/PfuCo0tW5eV9U8AeO4HOyzA6nfX0cpHYSsLg432HazITp+Nlajusf+8tp9pTY8mwQ
 Nbmmc7ezL56wc0yGlGOOyOUf36x6WdUUA4ICI2C5tK6SvIuJQ/bR28hE8DPqUSM8wNf2YgtWgLv
 TxUtDR8551iRSjG08UADk3armXer+nwCBp9F3n0NLo+hNj0lXH3xWoYypJ1pqwtCxINBJwX9zbL
 5aDRjBONrGn9mY4bYV3LbT+uN2GV1vch6f1Mder3h/zu08QRTuSi/95ry8lgCPWob2FPkOHJHou
 LgE5mrWQPr6wJYeXeM=
X-Google-Smtp-Source: AGHT+IEQ5AG0P4oTLfSPsFcATrxPK2WLrXKBuXv4P03Zfjvnx1O7aslgVxAFAylwXvscG1IXmtVeHA==
X-Received: by 2002:a05:6a20:2444:b0:366:14ac:e20b with SMTP id
 adf61e73a8af0-3898fa669d1mr8459479637.73.1767941764160; 
 Thu, 08 Jan 2026 22:56:04 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:56:03 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/34] target/riscv: Remove upper_half from
 riscv_pmu_ctr_get_fixed_counters_val
Date: Fri,  9 Jan 2026 16:54:42 +1000
Message-ID: <20260109065459.19987-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

Now that mhpmcounter is always a 64-bit value we can remove the
upper_half argument from riscv_pmu_ctr_get_fixed_counters_val() and
always return a 64-bit value.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251103033713.904455-9-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 40 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4ef9e9c377..05c7ec8352 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1235,14 +1235,12 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
-                                                         int counter_idx,
-                                                         bool upper_half)
+static uint64_t riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
+                                                     int counter_idx)
 {
     int inst = riscv_pmu_ctr_monitor_instructions(env, counter_idx);
     uint64_t *counter_arr_virt = env->pmu_fixed_ctrs[inst].counter_virt;
     uint64_t *counter_arr = env->pmu_fixed_ctrs[inst].counter;
-    target_ulong result = 0;
     uint64_t curr_val = 0;
     uint64_t cfg_val = 0;
 
@@ -1262,7 +1260,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
             curr_val = cpu_get_host_ticks();
         }
 
-        goto done;
+        return curr_val;
     }
 
     /* Update counter before reading. */
@@ -1288,14 +1286,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
         curr_val += counter_arr_virt[PRV_U];
     }
 
-done:
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        result = upper_half ? curr_val >> 32 : curr_val;
-    } else {
-        result = curr_val;
-    }
-
-    return result;
+    return curr_val;
 }
 
 static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
@@ -1312,7 +1303,7 @@ static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, false);
+        ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
         counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
                                               0, deposit_size, ctr);
         if (ctr_idx > 2) {
@@ -1339,7 +1330,7 @@ static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        ctrh = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, true);
+        ctrh = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
         counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
                                               32, 32, ctrh);
         if (ctr_idx > 2) {
@@ -1399,7 +1390,7 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
      */
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, upper_half) -
+        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
                                                     ctr_prev + ctr_val;
     } else {
         *val = ctr_val;
@@ -3006,7 +2997,6 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
     uint32_t present_ctrs = cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR;
     target_ulong updated_ctrs = (env->mcountinhibit ^ val) & present_ctrs;
     uint64_t mhpmctr_val, prev_count, curr_count;
-    uint64_t ctrh;
 
     /* WARL register - disable unavailable counters; TM bit is always 0 */
     env->mcountinhibit = val & present_ctrs;
@@ -3022,28 +3012,16 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
         counter = &env->pmu_ctrs[cidx];
 
         if (!get_field(env->mcountinhibit, BIT(cidx))) {
-            counter->mhpmcounter_prev =
-                riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
-            if (riscv_cpu_mxl(env) == MXL_RV32) {
-                ctrh = riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
-                counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
-                                                      32, 32, ctrh);
-            }
+            counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env, cidx);
 
             if (cidx > 2) {
                 riscv_pmu_setup_timer(env, counter->mhpmcounter_val, cidx);
             }
         } else {
-            curr_count = riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false);
+            curr_count = riscv_pmu_ctr_get_fixed_counters_val(env, cidx);
 
             mhpmctr_val = counter->mhpmcounter_val;
             prev_count = counter->mhpmcounter_prev;
-            if (riscv_cpu_mxl(env) == MXL_RV32) {
-                uint64_t tmp =
-                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true);
-
-                curr_count = curr_count | (tmp << 32);
-            }
 
             /* Adjust the counter for later reads. */
             mhpmctr_val = curr_count - prev_count + mhpmctr_val;
-- 
2.52.0


