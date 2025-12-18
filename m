Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2828D6E2D8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWIo3-0003wN-4T; Thu, 18 Dec 2025 13:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1vWImy-0003mR-JS
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:31:49 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1vWImw-0007LK-Dk
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:31:48 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-598eaafa587so1036970e87.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766082704; x=1766687504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qY9aDXCdvQKlOQpzxCCXLCIfXFIvBpXlP4Of3TlgDT0=;
 b=frfUp7CztBhrF7bUwQhPdmIX3Zwt/YHXcqjYoMTbmFbJSnHmS1n5jpDeuqsc056G2x
 GC1JKj99e05SCfdwti1aL5CFbVU6TbLnk3wkl299PQZKoTIXHGYkVqvByFQDM2pvx2uR
 eotf6k9u/J/JNCn6OYV+2X9xcbywdMHRy8iRCzkdD9FaBSuC8eAsjSmrMzIAuWwEsCbK
 Af2o2RyuOQ4smzNXwHfeneKyvRgTOIllE1eh85wzZRm2k5ANEa7koftiSGBoFGH73ijO
 b1BL4L3HDlVjLw/neRPktDmx+mawSWVys+R88pR98V0TiX+6tVU+6eH1n5EOhBG+YByd
 XqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766082704; x=1766687504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qY9aDXCdvQKlOQpzxCCXLCIfXFIvBpXlP4Of3TlgDT0=;
 b=uhaxYmTsj9oeIQsrmOF5ATdkSLaQml3m6+3xCsePdgoBEhnXl8tJJIh3w0ZauKlBiJ
 QFTDhTwZxnKca3g061VtJFBLB975pme5IlzEOCey0WukFWd339I6XGwlCaDgvqRBYIIf
 kMuHKnCvSYGBLudocKuFoyGn4WvcsPd/6uZw/pd38jvANPlaw03r5oBNAgDeHor6LWvw
 S66oTwiAllJNwPt8ze5Ca1BN06DgsQEkCI3xcRuWtYpR7Z0ArLs14W3nT7hXZlm3LvsU
 PvpHSMf4yKWyxS+EuYHQdbYYq9tuamMAddr7/T0s8EPC3r+vz2Z107OhyWnRh0o7FiUA
 Bv6Q==
X-Gm-Message-State: AOJu0Ywo/cRQ+4xnJ2abYSLffHjPdlFKhE61KBRS7tThM6Z1kjdlwjuk
 BKA+FU8dbZ/fXoG5W8KTiRck1O9zgcHR3goPmOyVjwyJABRFKLMqefJzCp6WzCkI
X-Gm-Gg: AY/fxX4JoovVOafXQ79crc/1qiKl9hefV5pvbK6Et4pxoZHuJ1cpzBO1a7EdytZB50l
 j7wrMn19TPH8P3wwoaxQs3cEfJ5KlBZBY3KVixJFWQbVwJBh+M4qE2BC4Aa447DS9xJY+SU/1PG
 z2h0Asy8GAyBEatzd/fX6mCoQvTuJwKgAMDs7qeNLfN8k+Edy1kipxKCd5pqjfMw4+GQhMdTUa3
 9CxHH3nSj6jJq3iMAnYcK/wonJckw6S+Ja+0spEYWrctcryXsL9bP5YBlhC6CDhw+aLIyXiTCdc
 vY9IQdVFBisW21YRXezUr3JM8uWmudMKv4lJUQjfo3fEV1MgHYml0km1t/9UClGxygW9AwLUm6O
 G2EJNeq1eV9khshlYPDQypy6K4t9dKspkH2NhXHHd88blzq2iI/J3VitnX1bSo7xS+g/YDrUhqT
 1yAfwCgY6orOXIMcpQxS6oTGg=
X-Google-Smtp-Source: AGHT+IHJ6lbcS8fFShto5gll/FXeeb1NoDPVa5BWh8z711aAmKy1tNvUoNTRCTAyCbvA2jpbTAp3fA==
X-Received: by 2002:a05:6512:a96:b0:594:5f00:c0b7 with SMTP id
 2adb3069b0e04-59a17d8cf43mr149974e87.15.1766082703963; 
 Thu, 18 Dec 2025 10:31:43 -0800 (PST)
Received: from NB-8855.Dlink ([81.201.19.27]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59a185dd229sm46777e87.22.2025.12.18.10.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 10:31:43 -0800 (PST)
From: Aleksandr Sergeev <sergeev0xef@gmail.com>
To: qemu-devel@nongnu.org
Cc: halip0503@gmail.com,
	Aleksandr Sergeev <sergeev0xef@gmail.com>
Subject: [RFC PATCH 1/6] target/riscv: Refactor counter index calculation.
Date: Thu, 18 Dec 2025 21:31:16 +0300
Message-ID: <20251218183122.408690-2-sergeev0xef@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218183122.408690-1-sergeev0xef@gmail.com>
References: <20251218183122.408690-1-sergeev0xef@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=sergeev0xef@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:32:34 -0500
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

When working with hpm registers, we need to calculate counter index
by csr number. By now it was done manually. Let's add a function --
riscv_pmu_csrno_to_ctr_idx(), which incapsulates this action.

Signed-off-by: Aleksandr Sergeev <sergeev0xef@gmail.com>
Reviewed-by: Alexei Filippov <halip0503@gmail.com>
---
 target/riscv/cpu_bits.h |  4 +++
 target/riscv/csr.c      | 73 ++++++++++++++---------------------------
 target/riscv/pmu.c      | 44 +++++++++++++++++++++++++
 target/riscv/pmu.h      |  1 +
 4 files changed, 73 insertions(+), 49 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index b62dd82fe7..5c3c1af64e 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -1145,6 +1145,10 @@ typedef enum CTRType {
 /* RISC-V-specific interrupt pending bits. */
 #define CPU_INTERRUPT_RNMI                 CPU_INTERRUPT_TGT_EXT_0
 
+#define HPM_MCYCLE_IDX                     0
+#define HPM_MTIME_IDX                      1
+#define HPM_MINSTRET_IDX                   2
+
 /* JVT CSR bits */
 #define JVT_MODE                           0x3F
 #define JVT_BASE                           (~0x3F)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5c91658c3d..8bdbc71160 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -110,17 +110,8 @@ static RISCVException ctr(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
     RISCVCPU *cpu = env_archcpu(env);
-    int ctr_index;
-    target_ulong ctr_mask;
-    int base_csrno = CSR_CYCLE;
-    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32 ? true : false;
-
-    if (rv32 && csrno >= CSR_CYCLEH) {
-        /* Offset for RV32 hpmcounternh counters */
-        base_csrno += 0x80;
-    }
-    ctr_index = csrno - base_csrno;
-    ctr_mask = BIT(ctr_index);
+    uint32_t ctr_index = riscv_pmu_csrno_to_ctr_idx(csrno);
+    target_ulong ctr_mask = BIT(ctr_index);
 
     if ((csrno >= CSR_CYCLE && csrno <= CSR_INSTRET) ||
         (csrno >= CSR_CYCLEH && csrno <= CSR_INSTRETH)) {
@@ -1166,9 +1157,9 @@ static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
 static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
-    int evt_index = csrno - CSR_MCOUNTINHIBIT;
+    uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
 
-    *val = env->mhpmevent_val[evt_index];
+    *val = env->mhpmevent_val[ctr_idx];
 
     return RISCV_EXCP_NONE;
 }
@@ -1176,14 +1167,15 @@ static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
 static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
                                       target_ulong val, uintptr_t ra)
 {
-    int evt_index = csrno - CSR_MCOUNTINHIBIT;
+    uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
+
     uint64_t mhpmevt_val = val;
     uint64_t inh_avail_mask;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        env->mhpmevent_val[evt_index] = val;
+        env->mhpmevent_val[ctr_idx] = val;
         mhpmevt_val = mhpmevt_val |
-                      ((uint64_t)env->mhpmeventh_val[evt_index] << 32);
+                      ((uint64_t)env->mhpmeventh_val[ctr_idx] << 32);
     } else {
         inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MHPMEVENT_BIT_MINH;
         inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENT_BIT_UINH : 0;
@@ -1193,10 +1185,10 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
         inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                            riscv_has_ext(env, RVS)) ? MHPMEVENT_BIT_VSINH : 0;
         mhpmevt_val = val & inh_avail_mask;
-        env->mhpmevent_val[evt_index] = mhpmevt_val;
+        env->mhpmevent_val[ctr_idx] = mhpmevt_val;
     }
 
-    riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
+    riscv_pmu_update_event_map(env, mhpmevt_val, ctr_idx);
 
     return RISCV_EXCP_NONE;
 }
@@ -1204,9 +1196,9 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
 static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
                                       target_ulong *val)
 {
-    int evt_index = csrno - CSR_MHPMEVENT3H + 3;
+    uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
 
-    *val = env->mhpmeventh_val[evt_index];
+    *val = env->mhpmeventh_val[ctr_idx];
 
     return RISCV_EXCP_NONE;
 }
@@ -1214,9 +1206,9 @@ static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
 static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
                                        target_ulong val, uintptr_t ra)
 {
-    int evt_index = csrno - CSR_MHPMEVENT3H + 3;
+    uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
     uint64_t mhpmevth_val;
-    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
+    uint64_t mhpmevt_val = env->mhpmevent_val[ctr_idx];
     target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
                                                   MHPMEVENTH_BIT_MINH);
 
@@ -1229,9 +1221,9 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
 
     mhpmevth_val = val & inh_avail_mask;
     mhpmevt_val = mhpmevt_val | (mhpmevth_val << 32);
-    env->mhpmeventh_val[evt_index] = mhpmevth_val;
+    env->mhpmeventh_val[ctr_idx] = mhpmevth_val;
 
-    riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
+    riscv_pmu_update_event_map(env, mhpmevt_val, ctr_idx);
 
     return RISCV_EXCP_NONE;
 }
@@ -1357,7 +1349,7 @@ static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
 static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
                                         target_ulong val, uintptr_t ra)
 {
-    int ctr_idx = csrno - CSR_MCYCLE;
+    uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
 
     return riscv_pmu_write_ctr(env, val, ctr_idx);
 }
@@ -1365,7 +1357,7 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
 static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
                                          target_ulong val, uintptr_t ra)
 {
-    int ctr_idx = csrno - CSR_MCYCLEH;
+    uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
 
     return riscv_pmu_write_ctrh(env, val, ctr_idx);
 }
@@ -1406,33 +1398,16 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
 static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
                                       target_ulong *val)
 {
-    uint16_t ctr_index;
-
-    if (csrno >= CSR_MCYCLE && csrno <= CSR_MHPMCOUNTER31) {
-        ctr_index = csrno - CSR_MCYCLE;
-    } else if (csrno >= CSR_CYCLE && csrno <= CSR_HPMCOUNTER31) {
-        ctr_index = csrno - CSR_CYCLE;
-    } else {
-        return RISCV_EXCP_ILLEGAL_INST;
-    }
-
-    return riscv_pmu_read_ctr(env, val, false, ctr_index);
+    uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
+    return riscv_pmu_read_ctr(env, val, false, ctr_idx);
 }
 
 static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
                                        target_ulong *val)
 {
-    uint16_t ctr_index;
 
-    if (csrno >= CSR_MCYCLEH && csrno <= CSR_MHPMCOUNTER31H) {
-        ctr_index = csrno - CSR_MCYCLEH;
-    } else if (csrno >= CSR_CYCLEH && csrno <= CSR_HPMCOUNTER31H) {
-        ctr_index = csrno - CSR_CYCLEH;
-    } else {
-        return RISCV_EXCP_ILLEGAL_INST;
-    }
-
-    return riscv_pmu_read_ctr(env, val, true, ctr_index);
+    uint32_t ctr_idx = riscv_pmu_csrno_to_ctr_idx(csrno);
+    return riscv_pmu_read_ctr(env, val, true, ctr_idx);
 }
 
 static int rmw_cd_mhpmcounter(CPURISCVState *env, int ctr_idx,
@@ -1599,8 +1574,8 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
 static RISCVException read_scountovf(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
-    int mhpmevt_start = CSR_MHPMEVENT3 - CSR_MCOUNTINHIBIT;
-    int i;
+    uint32_t mhpmevt_start = riscv_pmu_csrno_to_ctr_idx(CSR_MHPMEVENT3);
+    uint32_t i;
     *val = 0;
     target_ulong *mhpm_evt_val;
     uint64_t of_bit_mask;
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index a68809eef3..b983eadd83 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -600,3 +600,47 @@ void riscv_pmu_init(RISCVCPU *cpu, Error **errp)
 
     cpu->pmu_avail_ctrs = cpu->cfg.pmu_mask;
 }
+
+uint32_t riscv_pmu_csrno_to_ctr_idx(int csrno)
+{
+    #define CASE_RANGE(low, high, offset) { \
+        case (low)...(high): \
+            return csrno - (low) + (offset); \
+    }
+    #define HPMCOUNTER_START (HPM_MINSTRET_IDX + 1)
+
+    switch (csrno) {
+    CASE_RANGE(CSR_MHPMEVENT3, CSR_MHPMEVENT31, HPMCOUNTER_START)
+    CASE_RANGE(CSR_MHPMEVENT3H, CSR_MHPMEVENT31H, HPMCOUNTER_START)
+    CASE_RANGE(CSR_HPMCOUNTER3, CSR_HPMCOUNTER31, HPMCOUNTER_START)
+    CASE_RANGE(CSR_HPMCOUNTER3H, CSR_HPMCOUNTER31H, HPMCOUNTER_START)
+    CASE_RANGE(CSR_MHPMCOUNTER3, CSR_MHPMCOUNTER31, HPMCOUNTER_START)
+    CASE_RANGE(CSR_MHPMCOUNTER3H, CSR_MHPMCOUNTER31H, HPMCOUNTER_START)
+
+    case CSR_MCYCLE:
+    case CSR_MCYCLEH:
+    case CSR_CYCLE:
+    case CSR_CYCLEH:
+    case CSR_MCYCLECFG:
+    case CSR_MCYCLECFGH:
+        return HPM_MCYCLE_IDX;
+
+    case CSR_MINSTRET:
+    case CSR_MINSTRETH:
+    case CSR_INSTRET:
+    case CSR_INSTRETH:
+    case CSR_MINSTRETCFG:
+    case CSR_MINSTRETCFGH:
+        return HPM_MINSTRET_IDX;
+
+    case CSR_TIME:
+    case CSR_TIMEH:
+        return HPM_MTIME_IDX;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    #undef HPMCOUNTER_START
+    #undef CASE_RANGE
+}
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 3853d0e262..8f019bea9f 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -38,5 +38,6 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
                                  bool new_virt);
 RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
                                   bool upper_half, uint32_t ctr_idx);
+uint32_t riscv_pmu_csrno_to_ctr_idx(int csrno);
 
 #endif /* RISCV_PMU_H */
-- 
2.51.0


