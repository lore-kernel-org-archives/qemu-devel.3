Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815A6C35FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 19:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuyzm-0007U6-Mo; Wed, 19 Mar 2025 15:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tuyzk-0007P7-Cb
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:22:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tuyzd-0002D8-AM
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:22:28 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22548a28d0cso46825095ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 12:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1742412139; x=1743016939; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kKVHcadJ/wQJ8iIOiIdf/pZi6zcVqYjt3QxMjbunVFA=;
 b=ezAgp1hCqfrYJ0wMBB/9kg4fBSToBXNaM4NSWRw4iR2J8Lx00Aqkpxr29MPuVZ+Top
 fELM/Ojr5euyNxmmm0shNmPBItnkpIpUSMltPTrI8kd5IhmeNprDo4mE5ozbn5qIPl6W
 xPQgPTtG5aKqJwCWrHknIZy0pCw74capAXcq+90arKh2BAXLek4YCQ6AYCYJGvNDqg53
 P6MCVFp1sq7z+ohcbwR5HfDZSqSejbglvLApc1TEEnzFrUrv3RObrf3X+jzmry53ieoz
 eToWLvt3/JqcVTaBFJOvCav0eqfsbxNgsqhCbSO3siakW6dQBB/Saq/tMiZ+kKxc/PXb
 frAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742412139; x=1743016939;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kKVHcadJ/wQJ8iIOiIdf/pZi6zcVqYjt3QxMjbunVFA=;
 b=aiAFMyeVPPM/+d0zX1BanjLJkqFOeImWOW+iIHVTreO0ng0MSQn4Y7Y1PGwALk1XVi
 95Ifd0lX5OHYZ9Bs5g8oEoVPyOuo9wDRjW0JUq/0Pn7dlPj16O4X7bJoWX6fd4Hcpl6l
 eP2rkwZk1BTKiDBkzkRiV/tQRyGzwn45uXY2qKyDbFbDCp1opP3/USU7FDnFhJu+hbSC
 /PAclSryq0L5IA6mjrnGEThcIZ8AS1caiuSMpygfwhlRA1/U0evLPMJOHDYbEdhEqTYM
 ww5KxvmjhE0uBvCvVxrpPfeBuZPaqOAD1ey9+tRsqYnGDkvjIW6GKZs/Jwo5NDr949j+
 YMeg==
X-Gm-Message-State: AOJu0Ywf3lVhWQ8r4Lsl7aZXAnZDQnCdEEXme+l4JWdJ9Ejd8ERd3CtX
 gCbHBWIc9u1AuKvo4tEDF2OVZUrY6nn2p6WvN1FjdFPz4QRApJAV4bPF7diEUWLXCLDOvOExTPS
 LOb6JhR//3TJg90Zar6iYb2paljUQmRJKd56inhY8+fYojHKizlnP1A/RV7s7qzOaC9JEHvZAz+
 WRq3fQwKM27qbZwxdT/qQ1EhTrxS1zM3/FlQ==
X-Gm-Gg: ASbGnctTZm4GQDWcaxEXIFaSeu6BReQ2kiQShJkTxWebI4+0y9snPCVE3L5cfF3O2fr
 mlGNCMv3hurE4gnPOhTSj5ZTNS1Lu4NoYr69uhiBdAD/Fqczyys0iot1s6W/XxnTV07dnMUKKBj
 vN/ulllwUUS9iEUKG0lDBy763TZIPn5IQ5nt8l/Zz9NfgcfH1KJZD/J8ls2OpVaCwP7CbEqhfat
 bnQGdGjDDQmuzWabt8OACF94+wN6l0lXQC++cx6vdYwiVa71DrlKh/PfmdMxM/Lhps/vshmN5qt
 MXXhykGhUlCJmUG2nZpFniSkBhmlnj7oVPSv2U/dDjXIgGiq7j4hkdsnOCSK4Z80vwk=
X-Google-Smtp-Source: AGHT+IE+s0ns02b5SoF9eHzgQxIiDo+b24T8XSNbzWahmXzOfeu8JrjHz1xg7U2xiPkEYxI63QKe7g==
X-Received: by 2002:a05:6300:614a:b0:1f5:7d57:830f with SMTP id
 adf61e73a8af0-1fd133f00cemr839571637.33.1742412138660; 
 Wed, 19 Mar 2025 12:22:18 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea947a4sm11432175a12.70.2025.03.19.12.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 12:22:18 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 4/4] target/riscv: Enable/Disable S/VS-mode Timer when STCE
 bit is changed
Date: Thu, 20 Mar 2025 03:21:53 +0800
Message-Id: <20250319192153.28549-5-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250319192153.28549-1-jim.shu@sifive.com>
References: <20250319192153.28549-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Updating STCE will enable/disable SSTC in S-mode or/and VS-mode, so we
also need to update S/VS-mode Timer and S/VSTIP bits in $mip CSR.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/csr.c         | 44 ++++++++++++++++++++++++++++++++
 target/riscv/time_helper.c | 51 ++++++++++++++++++++++++++++++++++++++
 target/riscv/time_helper.h |  1 +
 3 files changed, 96 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ba026dfc8e..c954e49cae 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3156,6 +3156,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
                     MENVCFG_CBZE | MENVCFG_CDE;
+    bool stce_changed = false;
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
@@ -3181,10 +3182,19 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         if ((val & MENVCFG_DTE) == 0) {
             env->mstatus &= ~MSTATUS_SDT;
         }
+
+        if (cfg->ext_sstc &&
+            ((env->menvcfg & MENVCFG_STCE) != (val & MENVCFG_STCE))) {
+            stce_changed = true;
+        }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
     write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
 
+    if (stce_changed) {
+        riscv_timer_stce_changed(env, true, !!(val & MENVCFG_STCE));
+    }
+
     return RISCV_EXCP_NONE;
 }
 
@@ -3207,6 +3217,12 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
                     (cfg->ext_smcdeleg ? MENVCFG_CDE : 0) |
                     (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
     uint64_t valh = (uint64_t)val << 32;
+    bool stce_changed = false;
+
+    if (cfg->ext_sstc &&
+        ((env->menvcfg & MENVCFG_STCE) != (valh & MENVCFG_STCE))) {
+        stce_changed = true;
+    }
 
     if ((valh & MENVCFG_DTE) == 0) {
         env->mstatus &= ~MSTATUS_SDT;
@@ -3215,6 +3231,10 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
     write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
 
+    if (stce_changed) {
+        riscv_timer_stce_changed(env, true, !!(valh & MENVCFG_STCE));
+    }
+
     return RISCV_EXCP_NONE;
 }
 
@@ -3292,8 +3312,10 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
 static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
     RISCVException ret;
+    bool stce_changed = false;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
     if (ret != RISCV_EXCP_NONE) {
@@ -3319,6 +3341,11 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
             get_field(val, HENVCFG_PMM) != PMM_FIELD_RESERVED) {
             mask |= HENVCFG_PMM;
         }
+
+        if (cfg->ext_sstc &&
+            ((env->henvcfg & HENVCFG_STCE) != (val & HENVCFG_STCE))) {
+            stce_changed = true;
+        }
     }
 
     env->henvcfg = val & mask;
@@ -3326,6 +3353,10 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         env->vsstatus &= ~MSTATUS_SDT;
     }
 
+    if (stce_changed) {
+        riscv_timer_stce_changed(env, false, !!(val & HENVCFG_STCE));
+    }
+
     return RISCV_EXCP_NONE;
 }
 
@@ -3347,19 +3378,32 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
 static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
                                     HENVCFG_ADUE | HENVCFG_DTE);
     uint64_t valh = (uint64_t)val << 32;
     RISCVException ret;
+    bool stce_changed = false;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
     if (ret != RISCV_EXCP_NONE) {
         return ret;
     }
+
+    if (cfg->ext_sstc &&
+        ((env->henvcfg & HENVCFG_STCE) != (valh & HENVCFG_STCE))) {
+        stce_changed = true;
+    }
+
     env->henvcfg = (env->henvcfg & 0xFFFFFFFF) | (valh & mask);
     if ((env->henvcfg & HENVCFG_DTE) == 0) {
         env->vsstatus &= ~MSTATUS_SDT;
     }
+
+    if (stce_changed) {
+        riscv_timer_stce_changed(env, false, !!(val & HENVCFG_STCE));
+    }
+
     return RISCV_EXCP_NONE;
 }
 
diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index aebf0798d0..c648c9fac7 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -140,6 +140,57 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
     timer_mod(timer, next);
 }
 
+/*
+ * When disabling xenvcfg.STCE, the S/VS Timer may be disabled at the same time.
+ * It is safe to call this function regardless of whether the timer has been
+ * deleted or not. timer_del() will do nothing if the timer has already
+ * been deleted.
+ */
+static void riscv_timer_disable_timecmp(CPURISCVState *env, QEMUTimer *timer,
+                                 uint32_t timer_irq)
+{
+    /* Disable S-mode Timer IRQ and HW-based STIP */
+    if ((timer_irq == MIP_STIP) && !get_field(env->menvcfg, MENVCFG_STCE)) {
+        riscv_cpu_update_mip(env, timer_irq, BOOL_TO_MASK(0));
+        timer_del(timer);
+        return;
+    }
+
+    /* Disable VS-mode Timer IRQ and HW-based VSTIP */
+    if ((timer_irq == MIP_VSTIP) &&
+        (!get_field(env->menvcfg, MENVCFG_STCE) ||
+         !get_field(env->henvcfg, HENVCFG_STCE))) {
+        env->vstime_irq = 0;
+        riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(0));
+        timer_del(timer);
+        return;
+    }
+}
+
+/* Enable or disable S/VS-mode Timer when xenvcfg.STCE is changed */
+void riscv_timer_stce_changed(CPURISCVState *env, bool is_m_mode, bool enable)
+{
+    if (is_m_mode) {
+        /* menvcfg.STCE changes */
+        if (enable) {
+            riscv_timer_write_timecmp(env, env->stimer, env->stimecmp, 0, MIP_STIP);
+            riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
+                                      env->htimedelta, MIP_VSTIP);
+        } else {
+            riscv_timer_disable_timecmp(env, env->stimer, MIP_STIP);
+            riscv_timer_disable_timecmp(env, env->vstimer, MIP_VSTIP);
+        }
+    } else {
+        /* henvcfg.STCE changes */
+        if (enable) {
+            riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
+                                      env->htimedelta, MIP_VSTIP);
+        } else {
+            riscv_timer_disable_timecmp(env, env->vstimer, MIP_VSTIP);
+        }
+    }
+}
+
 void riscv_timer_init(RISCVCPU *cpu)
 {
     CPURISCVState *env;
diff --git a/target/riscv/time_helper.h b/target/riscv/time_helper.h
index cacd79b80c..af1f634f89 100644
--- a/target/riscv/time_helper.h
+++ b/target/riscv/time_helper.h
@@ -25,6 +25,7 @@
 void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
                                uint64_t timecmp, uint64_t delta,
                                uint32_t timer_irq);
+void riscv_timer_stce_changed(CPURISCVState *env, bool is_m_mode, bool enable);
 void riscv_timer_init(RISCVCPU *cpu);
 
 #endif
-- 
2.17.1


