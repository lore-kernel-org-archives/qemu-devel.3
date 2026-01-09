Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8ACED232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6Q3-0004bK-Hu; Fri, 09 Jan 2026 01:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Pe-00041R-6a
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:00 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Pc-0002rj-Gk
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:57 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-bd1ce1b35e7so2510486a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941754; x=1768546554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMHVGUF1vA3taZtzxBSy3w8duYLfMgoZCSi9wLwIFHA=;
 b=DwkXvAq2jPrfDDi+5uf61EMl1UX1PfvjIgpqlk2PaFju7m3PYdn50vx2RZLdfI9hLu
 6eRqfjbEYcHdOiHcUmovYLT+EbW/scXjDCovjgj+QB8FKKuTBErrHu7XmIZOHzcUpQhG
 FyzrTz17Y/z4zsElUt0KwXyKTqIKwgVw85tV+TOsCLAQDXrJDkuxVhaXdF5wDdxxrNo3
 LS9Sj92opWU5yx9PYWYTHaUGh+u2I5gI8ZP9S+QewBbu5kV9Dln99wVGOTRiHlKBHqsF
 l6KsIBMe1RF8STBnMWB4oCTCXVK3LpE79RF6uH3WjQUjiHFlv8An5TqpZkebpOwAvA9N
 tVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941754; x=1768546554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GMHVGUF1vA3taZtzxBSy3w8duYLfMgoZCSi9wLwIFHA=;
 b=MA3OvI+Werg8xVN2nx0nZinU1+LjLUMURyn28Is6PQtH/fqAtPZliWhu6mQdXJKh1+
 c86K1j6+K8ZKwc0ZDwIipjLtqohIEb5Tmq+cFLna8RC3u8/6jYOD4zGOZGpkZQ70Szcv
 iGHpl9rAQyQhPkWoyiydNq9U57Rr39lr6zpFSJRllDO00AiiWYQ8IM1kGhptLIEeRsSr
 I2lNU688Z1He1cTbudbTyJM/7gWszVCY1NUoRUvAR8dYhbrGH837vizKX3JDXs1PsS/c
 ZCLlhmap0SYdhRc8kZzpfdb6dxUQFYld0ovbKjEgLU/RtD5XcGeSKgUpq36kBU3Vl7Zh
 9G7g==
X-Gm-Message-State: AOJu0YwJknNL7yDkrMV6zTgjdqqvv0vbWQ03G10mp8BHc68/sAXWjYQp
 oyaPxmzaL1p0NAapZCpfdifLNbOtjlaI3QNj35i9cBPyex63VEE/JGdoWfQzXw==
X-Gm-Gg: AY/fxX4YFQHk7Nf99760qsKB1NPdTM3vq67jMSMEUa/daXmD5Yc3LA6+b+PcGnRgUcR
 Wdgr2jLlr7RF2rtsNe7jc6vF83gt7VcAs+FNT8VZSKJeVyP5A5EPoqZbG18z++7NKIBjQOesH2e
 Iyv0ufRQtUDkmoIq3WuZbSog1KtfBwv8GDDMU6E/gGGCx2Vvxhb0USvL9paa9MmLelojXqiRdjf
 ZC9qQJQUH5qo9yYXa+0X6paAf8sv5bAVNlR5YWC0IJVxDPvxkcDsTToOrnjHJfWBQtwZAn9HamR
 Tnn7vdhFG2IlgIzPdjpBavW30eCK+UGWBfwfJfFtDvc04IBzcwOH8hdD3vrQWCJMFeCjzsQeY9E
 33zTaBMpat+Sx/Bk4o2jvveUpy1poJufwyxMZ9i2FELZOlA9AiFjcOCoVbQFlq2eokf78EMQtA5
 rNgHip+wXtL612m3eh8VTlEuwZ8LifYRSa463eJcaVQwIkoZwdY/dUef/rgOGUFokRqfOMhS8gD
 73XijsJs4/FQBCvj2w=
X-Google-Smtp-Source: AGHT+IFE9aKenh5vh1nagl0uGxFL5tYxhP7M+FrCkJ0k1lFKfrtY9CJd5veugbaCdufJjT0VPaMOQg==
X-Received: by 2002:a05:6a20:7f84:b0:35f:cfb:1ee3 with SMTP id
 adf61e73a8af0-3898f90535bmr8275972637.25.1767941754194; 
 Thu, 08 Jan 2026 22:55:54 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:55:53 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 14/34] target/riscv: Combine mcyclecfg and mcyclecfgh
Date: Fri,  9 Jan 2026 16:54:39 +1000
Message-ID: <20260109065459.19987-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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

From: Anton Johansson <anjo@rev.ng>

According to version 20250508 of the privileged specification, mcyclecfg
is a 64-bit register and mcyclecfgh refers to the top 32 bits of this
register when XLEN == 32.  No real advantage is gained by keeping
them separate, and combining them allows for slight simplification.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20251027181831.27016-7-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251103033713.904455-6-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h |  3 +--
 target/riscv/csr.c | 28 +++++++++++++++++-----------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f9d2ebfb5d..2942fc1eda 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -420,8 +420,7 @@ struct CPUArchState {
     uint32_t mcountinhibit;
 
     /* PMU cycle & instret privilege mode filtering */
-    target_ulong mcyclecfg;
-    target_ulong mcyclecfgh;
+    uint64_t mcyclecfg;
     target_ulong minstretcfg;
     target_ulong minstretcfgh;
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0af85c4309..e9e30384b4 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1061,7 +1061,8 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
 static RISCVException read_mcyclecfg(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
-    *val = env->mcyclecfg;
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+    *val = extract64(env->mcyclecfg, 0, rv32 ? 32 : 64);
     return RISCV_EXCP_NONE;
 }
 
@@ -1071,7 +1072,7 @@ static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
     uint64_t inh_avail_mask;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        env->mcyclecfg = val;
+        env->mcyclecfg = deposit64(env->mcyclecfg, 0, 32, val);
     } else {
         /* Set xINH fields if priv mode supported */
         inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MCYCLECFG_BIT_MINH;
@@ -1090,7 +1091,7 @@ static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
 static RISCVException read_mcyclecfgh(CPURISCVState *env, int csrno,
                                       target_ulong *val)
 {
-    *val = env->mcyclecfgh;
+    *val = extract64(env->mcyclecfg, 32, 32);
     return RISCV_EXCP_NONE;
 }
 
@@ -1108,7 +1109,7 @@ static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                        riscv_has_ext(env, RVS)) ? MCYCLECFGH_BIT_VSINH : 0;
 
-    env->mcyclecfgh = val & inh_avail_mask;
+    env->mcyclecfg = deposit64(env->mcyclecfg, 32, 32, val & inh_avail_mask);
     return RISCV_EXCP_NONE;
 }
 
@@ -1244,8 +1245,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
     uint64_t cfg_val = 0;
 
     if (counter_idx == 0) {
-        cfg_val = upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
-                  env->mcyclecfg;
+        cfg_val = env->mcyclecfg;
     } else if (counter_idx == 2) {
         cfg_val = upper_half ? ((uint64_t)env->minstretcfgh << 32) :
                   env->minstretcfg;
@@ -1525,8 +1525,12 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
 }
 
 static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
-                            target_ulong new_val, target_ulong wr_mask)
+                          target_ulong new_val, uint64_t wr_mask)
 {
+    /*
+     * wr_mask is 64-bit so upper 32 bits of mcyclecfg and minstretcfg
+     * are retained.
+     */
     switch (cfg_index) {
     case 0:             /* CYCLECFG */
         if (wr_mask) {
@@ -1552,8 +1556,9 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
 }
 
 static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
-                            target_ulong new_val, target_ulong wr_mask)
+                           target_ulong new_val, target_ulong wr_mask)
 {
+    uint64_t cfgh;
 
     if (riscv_cpu_mxl(env) != MXL_RV32) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -1561,12 +1566,13 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
 
     switch (cfg_index) {
     case 0:         /* CYCLECFGH */
+        cfgh = extract64(env->mcyclecfg, 32, 32);
         if (wr_mask) {
             wr_mask &= ~MCYCLECFGH_BIT_MINH;
-            env->mcyclecfgh = (new_val & wr_mask) |
-                              (env->mcyclecfgh & ~wr_mask);
+            cfgh = (new_val & wr_mask) | (cfgh & ~wr_mask);
+            env->mcyclecfg = deposit64(env->mcyclecfg, 32, 32, cfgh);
         } else {
-            *val = env->mcyclecfgh;
+            *val = cfgh;
         }
         break;
     case 2:          /* INSTRETCFGH */
-- 
2.52.0


