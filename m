Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4589C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 23:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWOy6-0002nC-Du; Tue, 23 Jul 2024 19:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOxp-00025a-WA
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:30:39 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOxh-0007vI-NV
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:30:35 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2cb5deb027dso3565007a91.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 16:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721777427; x=1722382227;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cNT2hF9HLfBSmOaYJGBJ5QIholz9xkt8m/D+QTefv9s=;
 b=LeZX16rTVercNagiQNou/h3dV8VbGAFWTmv4d9wVcxhu/MWXHnK4WriP8/Aq+2MX9/
 K7FB1RUWVpAruBeVTQVpdsoJLFJZxZEqjmXjdefVqaLOH2yxKL+vNeBYsOvfMjQ5+om0
 04GfOe9H9AJAIhyT3dMos5KmR7R7JuX7TCs6S4VJ20+8n8ktOvPOkhxGWTjFkuQP0/nE
 FjisObMOY9x5w+RZBLXnQmmmNsWaV6UPYeIqhcqCQKEWLof53ccpgfK1P0yRD3q0cXSX
 piCVd6+sL9Q8zfzso63MdclsQQltaO4d/q3FzB/KkV+RCv2XEg2Uu95q1QtPr/Czf4Dk
 Ouog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721777427; x=1722382227;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cNT2hF9HLfBSmOaYJGBJ5QIholz9xkt8m/D+QTefv9s=;
 b=e+M1bzlfWWq6fhLQ/D+M+mkxdfYdLPIiQO4czrBShgiHfk3qK21jL7iKk03kwIZYI/
 C65ObqsVFYohMnuEjPJ9ZY8o72BSZPtPOaTG/RTebW1S1f6lVq65ToYDYl4l1PeyDWn9
 ombuAzaiQf8RUkSR/xeNRovraximy0OfL+1vnVo74S0Ptd9eTHwNOBmkPfyyCkFdCiHX
 3F5s/3AfgmnTa1bxUm7UJs4dnV+ALRGrjVKojpYI7R/TE/67k802H7u7VwWnt2N9GdXf
 q9qu3LqUj0pr4HBZfSg9r9ZVH2kGHpV8C68VlzpNaiQPu0piUoF195C/LZ00djC2OFv5
 BAqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWeD2sh6fYaP5trGF+wRsiZ4mLRDVbmJld3QKdOF3XXvIUxIdpTPPlXa+UPEXntLGcMXeGPuZd2X685r5i5n+z7nNPjLw=
X-Gm-Message-State: AOJu0YzXvuyiYsxpwU/UzZAZ6HZz6RVLKLTAHWZb1aQ4vaAIBn29KVCh
 3KV39J+bF3DQmdb+7RwqIvpqzt84u/eIkHcHRi2plVzgWsYKbpJLuAxTXATzCjQ=
X-Google-Smtp-Source: AGHT+IHVp8S4ZytWO0oHWj1/TPdyUGtW9ebfhOxY/DauM74sf9liX7jIibvG0jti3wGAviQkdJ03kg==
X-Received: by 2002:a17:90b:4f4c:b0:2c8:1f30:4e04 with SMTP id
 98e67ed59e1d1-2cd274a5198mr10793852a91.36.1721777426981; 
 Tue, 23 Jul 2024 16:30:26 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb74e894csm179217a91.41.2024.07.23.16.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 16:30:26 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 23 Jul 2024 16:30:04 -0700
Subject: [PATCH v2 07/13] target/riscv: Add counter
 delegation/configuration support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-counter_delegation-v2-7-c4170a5348ca@rivosinc.com>
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=atishp@rivosinc.com; helo=mail-pj1-x1034.google.com
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

The Smcdeleg/Ssccfg adds the support for counter delegation via
S*indcsr and Ssccfg.

It also adds a new shadow CSR scountinhibit and menvcfg enable bit (CDE)
to enable this extension and scountovf virtualization.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Co-developed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 302 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 290 insertions(+), 12 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index da27ba1b7580..2369a746a285 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -366,6 +366,21 @@ static RISCVException aia_smode32(CPURISCVState *env, int csrno)
     return smode32(env, csrno);
 }
 
+static RISCVException scountinhibit_pred(CPURISCVState *env, int csrno)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (!cpu->cfg.ext_ssccfg || !cpu->cfg.ext_smcdeleg) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    if (env->virt_enabled) {
+        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+    }
+
+    return smode(env, csrno);
+}
+
 static bool csrind_extensions_present(CPURISCVState *env)
 {
     return riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_sscsrind;
@@ -1190,10 +1205,9 @@ done:
     return result;
 }
 
-static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
-                                        target_ulong val)
+static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
+                                          uint32_t ctr_idx)
 {
-    int ctr_idx = csrno - CSR_MCYCLE;
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
     uint64_t mhpmctr_val = val;
 
@@ -1218,10 +1232,9 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
-                                         target_ulong val)
+static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
+                                          uint32_t ctr_idx)
 {
-    int ctr_idx = csrno - CSR_MCYCLEH;
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
     uint64_t mhpmctr_val = counter->mhpmcounter_val;
     uint64_t mhpmctrh_val = val;
@@ -1243,6 +1256,20 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong val)
+{
+    int ctr_idx = csrno - CSR_MCYCLE;
+
+    return riscv_pmu_write_ctr(env, val, ctr_idx);
+}
+
+static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulong val)
+{
+    int ctr_idx = csrno - CSR_MCYCLEH;
+
+    return riscv_pmu_write_ctrh(env, val, ctr_idx);
+}
+
 RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
                                          bool upper_half, uint32_t ctr_idx)
 {
@@ -1308,6 +1335,167 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
     return riscv_pmu_read_ctr(env, val, true, ctr_index);
 }
 
+static int rmw_cd_mhpmcounter(CPURISCVState *env, int ctr_idx,
+                              target_ulong *val, target_ulong new_val,
+                              target_ulong wr_mask)
+{
+    if (wr_mask != 0 && wr_mask != -1) {
+        return -EINVAL;
+    }
+
+    if (!wr_mask && val) {
+        riscv_pmu_read_ctr(env, val, false, ctr_idx);
+    } else if (wr_mask) {
+        riscv_pmu_write_ctr(env, new_val, ctr_idx);
+    } else {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
+                               target_ulong *val, target_ulong new_val,
+                               target_ulong wr_mask)
+{
+    if (wr_mask != 0 && wr_mask != -1) {
+        return -EINVAL;
+    }
+
+    if (!wr_mask && val) {
+        riscv_pmu_read_ctr(env, val, true, ctr_idx);
+    } else if (wr_mask) {
+        riscv_pmu_write_ctrh(env, new_val, ctr_idx);
+    } else {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
+                            target_ulong *val, target_ulong new_val,
+                            target_ulong wr_mask)
+{
+    uint64_t mhpmevt_val = new_val;
+
+    if (wr_mask != 0 && wr_mask != -1) {
+        return -EINVAL;
+    }
+
+    if (!wr_mask && val) {
+        *val = env->mhpmevent_val[evt_index];
+        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
+            *val &= ~MHPMEVENT_BIT_MINH;
+        }
+    } else if (wr_mask) {
+        wr_mask &= ~MHPMEVENT_BIT_MINH;
+        mhpmevt_val = (new_val & wr_mask) |
+                      (env->mhpmevent_val[evt_index] & ~wr_mask);
+        if (riscv_cpu_mxl(env) == MXL_RV32) {
+            mhpmevt_val = mhpmevt_val |
+                          ((uint64_t)env->mhpmeventh_val[evt_index] << 32);
+        }
+        env->mhpmevent_val[evt_index] = mhpmevt_val;
+        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
+    } else {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
+                             target_ulong *val, target_ulong new_val,
+                             target_ulong wr_mask)
+{
+    uint64_t mhpmevth_val;
+    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
+
+    if (wr_mask != 0 && wr_mask != -1) {
+        return -EINVAL;
+    }
+
+    if (!wr_mask && val) {
+        *val = env->mhpmeventh_val[evt_index];
+        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
+            *val &= ~MHPMEVENTH_BIT_MINH;
+        }
+    } else if (wr_mask) {
+        wr_mask &= ~MHPMEVENTH_BIT_MINH;
+        env->mhpmeventh_val[evt_index] =
+            (new_val & wr_mask) | (env->mhpmeventh_val[evt_index] & ~wr_mask);
+        mhpmevth_val = env->mhpmeventh_val[evt_index];
+        mhpmevt_val = mhpmevt_val | (mhpmevth_val << 32);
+        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
+    } else {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
+                            target_ulong new_val, target_ulong wr_mask)
+{
+    switch (cfg_index) {
+    case 0:             /* CYCLECFG */
+        if (wr_mask) {
+            wr_mask &= ~MCYCLECFG_BIT_MINH;
+            env->mcyclecfg = (new_val & wr_mask) | (env->mcyclecfg & ~wr_mask);
+        } else {
+            *val = env->mcyclecfg &= ~MHPMEVENTH_BIT_MINH;
+        }
+        break;
+    case 2:             /* INSTRETCFG */
+        if (wr_mask) {
+            wr_mask &= ~MINSTRETCFG_BIT_MINH;
+            env->minstretcfg = (new_val & wr_mask) |
+                               (env->minstretcfg & ~wr_mask);
+        } else {
+            *val = env->minstretcfg &= ~MHPMEVENTH_BIT_MINH;
+        }
+        break;
+    default:
+        return -EINVAL;
+    }
+    return 0;
+}
+
+static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
+                            target_ulong new_val, target_ulong wr_mask)
+{
+
+    if (riscv_cpu_mxl(env) != MXL_RV32) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    switch (cfg_index) {
+    case 0:         /* CYCLECFGH */
+        if (wr_mask) {
+            wr_mask &= ~MCYCLECFGH_BIT_MINH;
+            env->mcyclecfgh = (new_val & wr_mask) |
+                              (env->mcyclecfgh & ~wr_mask);
+        } else {
+            *val = env->mcyclecfgh;
+        }
+        break;
+    case 2:          /* INSTRETCFGH */
+        if (wr_mask) {
+            wr_mask &= ~MINSTRETCFGH_BIT_MINH;
+            env->minstretcfgh = (new_val & wr_mask) |
+                                (env->minstretcfgh & ~wr_mask);
+        } else {
+            *val = env->minstretcfgh;
+        }
+        break;
+    default:
+        return -EINVAL;
+    }
+    return 0;
+}
+
+
 static RISCVException read_scountovf(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
@@ -1317,6 +1505,14 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
     target_ulong *mhpm_evt_val;
     uint64_t of_bit_mask;
 
+    /* Virtualize scountovf for counter delegation */
+    if (riscv_cpu_cfg(env)->ext_sscofpmf &&
+        riscv_cpu_cfg(env)->ext_ssccfg &&
+        get_field(env->menvcfg, MENVCFG_CDE) &&
+        env->virt_enabled) {
+        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+    }
+
     if (riscv_cpu_mxl(env) == MXL_RV32) {
         mhpm_evt_val = env->mhpmeventh_val;
         of_bit_mask = MHPMEVENTH_BIT_OF;
@@ -2254,11 +2450,70 @@ static int rmw_xireg_cd(CPURISCVState *env, int csrno,
                         target_ulong isel, target_ulong *val,
                         target_ulong new_val, target_ulong wr_mask)
 {
-    if (!riscv_cpu_cfg(env)->ext_smcdeleg) {
+    int ret = -EINVAL;
+    int ctr_index = isel - ISELECT_CD_FIRST;
+    int isel_hpm_start = ISELECT_CD_FIRST + 3;
+
+    if (!riscv_cpu_cfg(env)->ext_smcdeleg || !riscv_cpu_cfg(env)->ext_ssccfg) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
-    /* TODO: Implement the functionality later */
-    return RISCV_EXCP_NONE;
+
+    /* Invalid siselect value for reserved */
+    if (ctr_index == 1) {
+        goto done;
+    }
+
+    /* sireg4 and sireg5 provides access RV32 only CSRs */
+    if (((csrno == CSR_SIREG5) || (csrno == CSR_SIREG4)) &&
+        (riscv_cpu_mxl(env) != MXL_RV32)) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    /* Check Sscofpmf dependancy */
+    if (!riscv_cpu_cfg(env)->ext_sscofpmf && csrno == CSR_SIREG5 &&
+        (isel_hpm_start <= isel && isel <= ISELECT_CD_LAST)) {
+        goto done;
+    }
+
+    /* Check smcntrpmf dependancy */
+    if (!riscv_cpu_cfg(env)->ext_smcntrpmf &&
+        (csrno == CSR_SIREG2 || csrno == CSR_SIREG5) &&
+        (ISELECT_CD_FIRST <= isel && isel < isel_hpm_start)) {
+        goto done;
+    }
+
+    if (!get_field(env->mcounteren, BIT(ctr_index)) ||
+        !get_field(env->menvcfg, MENVCFG_CDE)) {
+        goto done;
+    }
+
+    switch (csrno) {
+    case CSR_SIREG:
+        ret = rmw_cd_mhpmcounter(env, ctr_index, val, new_val, wr_mask);
+        break;
+    case CSR_SIREG4:
+        ret = rmw_cd_mhpmcounterh(env, ctr_index, val, new_val, wr_mask);
+        break;
+    case CSR_SIREG2:
+        if (ctr_index <= 2) {
+            ret = rmw_cd_ctr_cfg(env, ctr_index, val, new_val, wr_mask);
+        } else {
+            ret = rmw_cd_mhpmevent(env, ctr_index, val, new_val, wr_mask);
+        }
+        break;
+    case CSR_SIREG5:
+        if (ctr_index <= 2) {
+            ret = rmw_cd_ctr_cfgh(env, ctr_index, val, new_val, wr_mask);
+        } else {
+            ret = rmw_cd_mhpmeventh(env, ctr_index, val, new_val, wr_mask);
+        }
+        break;
+    default:
+        goto done;
+    }
+
+done:
+    return ret;
 }
 
 /*
@@ -2540,6 +2795,21 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_scountinhibit(CPURISCVState *env, int csrno,
+                                         target_ulong *val)
+{
+    /* S-mode can only access the bits delegated by M-mode */
+    *val = env->mcountinhibit & env->mcounteren;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_scountinhibit(CPURISCVState *env, int csrno,
+                                          target_ulong val)
+{
+    write_mcountinhibit(env, csrno, val & env->mcounteren);
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException read_mcounteren(CPURISCVState *env, int csrno,
                                       target_ulong *val)
 {
@@ -2642,12 +2912,14 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
-    uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE | MENVCFG_CBZE;
+    uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
+                    MENVCFG_CBZE | MENVCFG_CDE;
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
-                (cfg->ext_svadu ? MENVCFG_ADUE : 0);
+                (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
+                (cfg->ext_smcdeleg ? MENVCFG_CDE : 0);
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
 
@@ -2667,7 +2939,8 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                     (cfg->ext_sstc ? MENVCFG_STCE : 0) |
-                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
+                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
+                    (cfg->ext_smcdeleg ? MENVCFG_CDE : 0);
     uint64_t valh = (uint64_t)val << 32;
 
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
@@ -5417,6 +5690,11 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                         write_sstateen_1_3,
                         .min_priv_ver = PRIV_VERSION_1_12_0 },
 
+    /* Supervisor Counter Delegation */
+    [CSR_SCOUNTINHIBIT] = {"scountinhibit", scountinhibit_pred,
+                            read_scountinhibit, write_scountinhibit,
+                           .min_priv_ver = PRIV_VERSION_1_12_0 },
+
     /* Supervisor Trap Setup */
     [CSR_SSTATUS]    = { "sstatus",    smode, read_sstatus,    write_sstatus,
                          NULL,                read_sstatus_i128              },

-- 
2.34.1


