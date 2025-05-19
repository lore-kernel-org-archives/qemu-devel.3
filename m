Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728F0C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3T-0000g3-Mt; Mon, 19 May 2025 00:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGro7-00072G-Lz
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:08:56 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGro3-0004H6-NA
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:08:55 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b26f67f10ddso1526261a12.3
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627730; x=1748232530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmUgwEfoQhqxtFyJjDXjMNdBeEt/DbzUtpPXfwQzoz4=;
 b=CUjrSVvcXl9djOHdzvokGctQj/Ix6uDnnmvPp85YTpYE16td6O8vP9ADKwEktHvFRe
 bOuxltKLzB5wNjsiClNdVXnysQeWRg5V3nQqjTjrJnLYO7QrkGKf6+qYqjNfHh8OsqYD
 iaihIF/EzQoyOCc6dciwSimxBjgcZqHUO7HRIbxvJAtO7BO8sROn30DARHRstIvFJB7G
 hBdzWk2ZpBUUKVOfd3axiGKcb8N9ChJ9XVpRomDSe7iHMUXWR0fpOS+TRmVlVSPm0IDF
 mBqtYPxxd/WcStJhmqs2dzDRSYYRYSFou9PNUmz4m4plVnM1GRRBVpmcdVLoyXnpLh2v
 xqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627730; x=1748232530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmUgwEfoQhqxtFyJjDXjMNdBeEt/DbzUtpPXfwQzoz4=;
 b=Y7rVlsull2hjQ+XjUYS7yjJ3+EUFvOHNhHvkzrvTNv7Czby9O2PUUVam98uDMayvRT
 6IsqrMvLn4MBSh62n66RUJqf+r4o+dYaEeSBZImxWDBfegfiFtVfdE3eRjPSYCwGf92q
 AQbkEHczDfRMUbLm1LEQ47uc3qB8cYUbuZV3D3HI2p0kWhO7c0SbjBXt1OkpSpcRpCsg
 csE5rBow4EKdjRLbT6tiOKFwcnYaqLvd7Zmkp5izpMO8I/fSANerIHCBJ9Zjkz7MB1pB
 FtbYhw0j1n81IaIx1S9+icjPcHDn8ojj4FpEPZEt0ofZy/7sEjBlbyYxRZQd31AYhqha
 vA4Q==
X-Gm-Message-State: AOJu0YzSlpT8S0GNLB7DVuxq+M+l2oFIc/KF4wJ+8T6ydOeJvjQ/3bKk
 eMVl5A8sLt9xlyxnLBpkTF3uuW7E6qUynbZ1JfhbZOc2hWIft92oBVxK5feY0A==
X-Gm-Gg: ASbGncuvLaHHu6tlTPhUk3T1xB3sNhxlsNspcb1Ft7KKtlJ2vv+72QFQot/hy1LRy3B
 5ktx3q7GxqgwwtplfLmplyuRznW1x02ArwT34aiimdA7HKvJM2ginuuQXrKfj3csPEQbEcME1Wb
 j9pkFJZq2u2v3Vsjh+jc5k9x6EsaJSMZrayhVJezAJvvGeGzY2fD2PsXshWgwGXokCph4+Jz8/u
 +5PWHU2wrjbzd/rg2T/Nc+QARTQaP688cLrxBMacyIN93e/j2f2N7Mpg0/geW9jKODH+MXlSSFg
 BM5HpYTh8d+UsgSYQKRQcy6jQrIA0P6rN135TzxEgDHlTcGm+19fjbiSdxWZseo7t1fG4Bh8oZy
 VUnVlcJRy36Lx0UHRAIjAyaUY0S2hCTV8dJWm/mLCUEArCo2gCsG71T17
X-Google-Smtp-Source: AGHT+IGpl9oMytrESFvPoFkol9Mh+/fipmZZcByanl0Iu6POnWY6GFIgFtEDyrxLlP8K3whM3LJq9A==
X-Received: by 2002:a17:902:c411:b0:224:1ec0:8a1d with SMTP id
 d9443c01a7336-231de376684mr139458035ad.30.1747627729914; 
 Sun, 18 May 2025 21:08:49 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:49 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/56] target/riscv: Pass ra to riscv_csr_write_fn
Date: Mon, 19 May 2025 14:05:29 +1000
Message-ID: <20250519040555.3797167-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250425152311.804338-2-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h |   3 +-
 target/riscv/csr.c | 226 +++++++++++++++++++++++----------------------
 2 files changed, 118 insertions(+), 111 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c66ac3bc27..4265ce06ee 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -838,7 +838,8 @@ typedef RISCVException (*riscv_csr_predicate_fn)(CPURISCVState *env,
 typedef RISCVException (*riscv_csr_read_fn)(CPURISCVState *env, int csrno,
                                             target_ulong *ret_value);
 typedef RISCVException (*riscv_csr_write_fn)(CPURISCVState *env, int csrno,
-                                             target_ulong new_value);
+                                             target_ulong new_value,
+                                             uintptr_t ra);
 typedef RISCVException (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
                                           target_ulong *ret_value,
                                           target_ulong new_value,
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a32e1455c9..ba7620ef3d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -830,13 +830,15 @@ static RISCVException seed(CPURISCVState *env, int csrno)
 }
 
 /* zicfiss CSR_SSP read and write */
-static int read_ssp(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_ssp(CPURISCVState *env, int csrno,
+                               target_ulong *val)
 {
     *val = env->ssp;
     return RISCV_EXCP_NONE;
 }
 
-static int write_ssp(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_ssp(CPURISCVState *env, int csrno,
+                                target_ulong val, uintptr_t ra)
 {
     env->ssp = val;
     return RISCV_EXCP_NONE;
@@ -851,7 +853,7 @@ static RISCVException read_fflags(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_fflags(CPURISCVState *env, int csrno,
-                                   target_ulong val)
+                                   target_ulong val, uintptr_t ra)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (riscv_has_ext(env, RVF)) {
@@ -870,7 +872,7 @@ static RISCVException read_frm(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_frm(CPURISCVState *env, int csrno,
-                                target_ulong val)
+                                target_ulong val, uintptr_t ra)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (riscv_has_ext(env, RVF)) {
@@ -890,7 +892,7 @@ static RISCVException read_fcsr(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_fcsr(CPURISCVState *env, int csrno,
-                                 target_ulong val)
+                                 target_ulong val, uintptr_t ra)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (riscv_has_ext(env, RVF)) {
@@ -942,7 +944,7 @@ static RISCVException read_vxrm(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_vxrm(CPURISCVState *env, int csrno,
-                                 target_ulong val)
+                                 target_ulong val, uintptr_t ra)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
@@ -959,7 +961,7 @@ static RISCVException read_vxsat(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_vxsat(CPURISCVState *env, int csrno,
-                                  target_ulong val)
+                                  target_ulong val, uintptr_t ra)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
@@ -976,7 +978,7 @@ static RISCVException read_vstart(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_vstart(CPURISCVState *env, int csrno,
-                                   target_ulong val)
+                                   target_ulong val, uintptr_t ra)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
@@ -997,7 +999,7 @@ static RISCVException read_vcsr(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_vcsr(CPURISCVState *env, int csrno,
-                                 target_ulong val)
+                                 target_ulong val, uintptr_t ra)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
@@ -1055,7 +1057,7 @@ static RISCVException read_mcyclecfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
-                                      target_ulong val)
+                                      target_ulong val, uintptr_t ra)
 {
     uint64_t inh_avail_mask;
 
@@ -1084,7 +1086,7 @@ static RISCVException read_mcyclecfgh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
-                                       target_ulong val)
+                                       target_ulong val, uintptr_t ra)
 {
     target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
                                                  MCYCLECFGH_BIT_MINH);
@@ -1109,7 +1111,7 @@ static RISCVException read_minstretcfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
-                                        target_ulong val)
+                                        target_ulong val, uintptr_t ra)
 {
     uint64_t inh_avail_mask;
 
@@ -1136,7 +1138,7 @@ static RISCVException read_minstretcfgh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
-                                         target_ulong val)
+                                         target_ulong val, uintptr_t ra)
 {
     target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
                                                  MINSTRETCFGH_BIT_MINH);
@@ -1163,7 +1165,7 @@ static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
-                                      target_ulong val)
+                                      target_ulong val, uintptr_t ra)
 {
     int evt_index = csrno - CSR_MCOUNTINHIBIT;
     uint64_t mhpmevt_val = val;
@@ -1201,7 +1203,7 @@ static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
-                                       target_ulong val)
+                                       target_ulong val, uintptr_t ra)
 {
     int evt_index = csrno - CSR_MHPMEVENT3H + 3;
     uint64_t mhpmevth_val;
@@ -1343,14 +1345,16 @@ static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
     return RISCV_EXCP_NONE;
 }
 
-static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
+                                        target_ulong val, uintptr_t ra)
 {
     int ctr_idx = csrno - CSR_MCYCLE;
 
     return riscv_pmu_write_ctr(env, val, ctr_idx);
 }
 
-static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
+                                         target_ulong val, uintptr_t ra)
 {
     int ctr_idx = csrno - CSR_MCYCLEH;
 
@@ -1661,7 +1665,7 @@ static RISCVException read_vstimecmph(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_vstimecmp(CPURISCVState *env, int csrno,
-                                      target_ulong val)
+                                      target_ulong val, uintptr_t ra)
 {
     if (riscv_cpu_mxl(env) == MXL_RV32) {
         env->vstimecmp = deposit64(env->vstimecmp, 0, 32, (uint64_t)val);
@@ -1676,7 +1680,7 @@ static RISCVException write_vstimecmp(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_vstimecmph(CPURISCVState *env, int csrno,
-                                       target_ulong val)
+                                       target_ulong val, uintptr_t ra)
 {
     env->vstimecmp = deposit64(env->vstimecmp, 32, 32, (uint64_t)val);
     riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
@@ -1710,13 +1714,13 @@ static RISCVException read_stimecmph(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_stimecmp(CPURISCVState *env, int csrno,
-                                     target_ulong val)
+                                     target_ulong val, uintptr_t ra)
 {
     if (env->virt_enabled) {
         if (env->hvictl & HVICTL_VTI) {
             return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
         }
-        return write_vstimecmp(env, csrno, val);
+        return write_vstimecmp(env, csrno, val, ra);
     }
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
@@ -1731,13 +1735,13 @@ static RISCVException write_stimecmp(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
-                                      target_ulong val)
+                                      target_ulong val, uintptr_t ra)
 {
     if (env->virt_enabled) {
         if (env->hvictl & HVICTL_VTI) {
             return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
         }
-        return write_vstimecmph(env, csrno, val);
+        return write_vstimecmph(env, csrno, val, ra);
     }
 
     env->stimecmp = deposit64(env->stimecmp, 32, 32, (uint64_t)val);
@@ -1842,7 +1846,7 @@ static RISCVException read_zero(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_ignore(CPURISCVState *env, int csrno,
-                                   target_ulong val)
+                                   target_ulong val, uintptr_t ra)
 {
     return RISCV_EXCP_NONE;
 }
@@ -1963,7 +1967,7 @@ static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mpp,
 }
 
 static RISCVException write_mstatus(CPURISCVState *env, int csrno,
-                                    target_ulong val)
+                                    target_ulong val, uintptr_t ra)
 {
     uint64_t mstatus = env->mstatus;
     uint64_t mask = 0;
@@ -2042,7 +2046,7 @@ static RISCVException read_mstatush(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mstatush(CPURISCVState *env, int csrno,
-                                     target_ulong val)
+                                     target_ulong val, uintptr_t ra)
 {
     uint64_t valh = (uint64_t)val << 32;
     uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
@@ -2096,7 +2100,7 @@ static RISCVException read_misa(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_misa(CPURISCVState *env, int csrno,
-                                 target_ulong val)
+                                 target_ulong val, uintptr_t ra)
 {
     RISCVCPU *cpu = env_archcpu(env);
     uint32_t orig_misa_ext = env->misa_ext;
@@ -2160,7 +2164,7 @@ static RISCVException read_medeleg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_medeleg(CPURISCVState *env, int csrno,
-                                    target_ulong val)
+                                    target_ulong val, uintptr_t ra)
 {
     env->medeleg = (env->medeleg & ~DELEGABLE_EXCPS) | (val & DELEGABLE_EXCPS);
     return RISCV_EXCP_NONE;
@@ -2955,7 +2959,7 @@ static RISCVException read_mtvec(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mtvec(CPURISCVState *env, int csrno,
-                                  target_ulong val)
+                                  target_ulong val, uintptr_t ra)
 {
     /* bits [1:0] encode mode; 0 = direct, 1 = vectored, 2 >= reserved */
     if ((val & 3) < 2) {
@@ -2974,7 +2978,7 @@ static RISCVException read_mcountinhibit(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
-                                          target_ulong val)
+                                          target_ulong val, uintptr_t ra)
 {
     int cidx;
     PMUCTRState *counter;
@@ -3049,10 +3053,9 @@ static RISCVException read_scountinhibit(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_scountinhibit(CPURISCVState *env, int csrno,
-                                          target_ulong val)
+                                          target_ulong val, uintptr_t ra)
 {
-    write_mcountinhibit(env, csrno, val & env->mcounteren);
-    return RISCV_EXCP_NONE;
+    return write_mcountinhibit(env, csrno, val & env->mcounteren, ra);
 }
 
 static RISCVException read_mcounteren(CPURISCVState *env, int csrno,
@@ -3063,7 +3066,7 @@ static RISCVException read_mcounteren(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mcounteren(CPURISCVState *env, int csrno,
-                                       target_ulong val)
+                                       target_ulong val, uintptr_t ra)
 {
     RISCVCPU *cpu = env_archcpu(env);
 
@@ -3097,7 +3100,7 @@ static RISCVException read_mscratch(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mscratch(CPURISCVState *env, int csrno,
-                                     target_ulong val)
+                                     target_ulong val, uintptr_t ra)
 {
     env->mscratch = val;
     return RISCV_EXCP_NONE;
@@ -3111,7 +3114,7 @@ static RISCVException read_mepc(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mepc(CPURISCVState *env, int csrno,
-                                 target_ulong val)
+                                 target_ulong val, uintptr_t ra)
 {
     env->mepc = val;
     return RISCV_EXCP_NONE;
@@ -3125,7 +3128,7 @@ static RISCVException read_mcause(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mcause(CPURISCVState *env, int csrno,
-                                   target_ulong val)
+                                   target_ulong val, uintptr_t ra)
 {
     env->mcause = val;
     return RISCV_EXCP_NONE;
@@ -3139,7 +3142,7 @@ static RISCVException read_mtval(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mtval(CPURISCVState *env, int csrno,
-                                  target_ulong val)
+                                  target_ulong val, uintptr_t ra)
 {
     env->mtval = val;
     return RISCV_EXCP_NONE;
@@ -3154,9 +3157,9 @@ static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
-                                    target_ulong val);
+                                    target_ulong val, uintptr_t ra);
 static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
-                                    target_ulong val)
+                                    target_ulong val, uintptr_t ra)
 {
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
@@ -3188,9 +3191,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
-    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
-
-    return RISCV_EXCP_NONE;
+    return write_henvcfg(env, CSR_HENVCFG, env->henvcfg, ra);
 }
 
 static RISCVException read_menvcfgh(CPURISCVState *env, int csrno,
@@ -3201,9 +3202,9 @@ static RISCVException read_menvcfgh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
-                                    target_ulong val);
+                                     target_ulong val, uintptr_t ra);
 static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
-                                     target_ulong val)
+                                     target_ulong val, uintptr_t ra)
 {
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
@@ -3218,9 +3219,7 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     }
 
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
-    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
-
-    return RISCV_EXCP_NONE;
+    return write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32, ra);
 }
 
 static RISCVException read_senvcfg(CPURISCVState *env, int csrno,
@@ -3238,7 +3237,7 @@ static RISCVException read_senvcfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
-                                    target_ulong val)
+                                    target_ulong val, uintptr_t ra)
 {
     uint64_t mask = SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENVCFG_CBZE;
     RISCVException ret;
@@ -3295,7 +3294,7 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
-                                    target_ulong val)
+                                    target_ulong val, uintptr_t ra)
 {
     uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
     RISCVException ret;
@@ -3350,7 +3349,7 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
-                                     target_ulong val)
+                                     target_ulong val, uintptr_t ra)
 {
     uint64_t mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
                                     HENVCFG_ADUE | HENVCFG_DTE);
@@ -3388,7 +3387,7 @@ static RISCVException write_mstateen(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
-                                      target_ulong new_val)
+                                      target_ulong new_val, uintptr_t ra)
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
     if (!riscv_has_ext(env, RVF)) {
@@ -3420,7 +3419,7 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mstateen_1_3(CPURISCVState *env, int csrno,
-                                         target_ulong new_val)
+                                         target_ulong new_val, uintptr_t ra)
 {
     return write_mstateen(env, csrno, SMSTATEEN_STATEEN, new_val);
 }
@@ -3447,7 +3446,7 @@ static RISCVException write_mstateenh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
-                                       target_ulong new_val)
+                                       target_ulong new_val, uintptr_t ra)
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
@@ -3463,7 +3462,7 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mstateenh_1_3(CPURISCVState *env, int csrno,
-                                          target_ulong new_val)
+                                          target_ulong new_val, uintptr_t ra)
 {
     return write_mstateenh(env, csrno, SMSTATEEN_STATEEN, new_val);
 }
@@ -3492,7 +3491,7 @@ static RISCVException write_hstateen(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
-                                      target_ulong new_val)
+                                      target_ulong new_val, uintptr_t ra)
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
@@ -3521,7 +3520,7 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hstateen_1_3(CPURISCVState *env, int csrno,
-                                         target_ulong new_val)
+                                         target_ulong new_val, uintptr_t ra)
 {
     return write_hstateen(env, csrno, SMSTATEEN_STATEEN, new_val);
 }
@@ -3552,7 +3551,7 @@ static RISCVException write_hstateenh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hstateen0h(CPURISCVState *env, int csrno,
-                                       target_ulong new_val)
+                                       target_ulong new_val, uintptr_t ra)
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
@@ -3564,7 +3563,7 @@ static RISCVException write_hstateen0h(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hstateenh_1_3(CPURISCVState *env, int csrno,
-                                          target_ulong new_val)
+                                          target_ulong new_val, uintptr_t ra)
 {
     return write_hstateenh(env, csrno, SMSTATEEN_STATEEN, new_val);
 }
@@ -3603,7 +3602,7 @@ static RISCVException write_sstateen(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
-                                      target_ulong new_val)
+                                      target_ulong new_val, uintptr_t ra)
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
@@ -3615,7 +3614,7 @@ static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_sstateen_1_3(CPURISCVState *env, int csrno,
-                                      target_ulong new_val)
+                                         target_ulong new_val, uintptr_t ra)
 {
     return write_sstateen(env, csrno, SMSTATEEN_STATEEN, new_val);
 }
@@ -3866,7 +3865,7 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_sstatus(CPURISCVState *env, int csrno,
-                                    target_ulong val)
+                                    target_ulong val, uintptr_t ra)
 {
     target_ulong mask = (sstatus_v1_10_mask);
 
@@ -3883,7 +3882,7 @@ static RISCVException write_sstatus(CPURISCVState *env, int csrno,
         mask |= SSTATUS_SDT;
     }
     target_ulong newval = (env->mstatus & ~mask) | (val & mask);
-    return write_mstatus(env, CSR_MSTATUS, newval);
+    return write_mstatus(env, CSR_MSTATUS, newval, ra);
 }
 
 static RISCVException rmw_vsie64(CPURISCVState *env, int csrno,
@@ -4035,7 +4034,7 @@ static RISCVException read_stvec(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_stvec(CPURISCVState *env, int csrno,
-                                  target_ulong val)
+                                  target_ulong val, uintptr_t ra)
 {
     /* bits [1:0] encode mode; 0 = direct, 1 = vectored, 2 >= reserved */
     if ((val & 3) < 2) {
@@ -4054,7 +4053,7 @@ static RISCVException read_scounteren(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_scounteren(CPURISCVState *env, int csrno,
-                                       target_ulong val)
+                                       target_ulong val, uintptr_t ra)
 {
     RISCVCPU *cpu = env_archcpu(env);
 
@@ -4088,7 +4087,7 @@ static RISCVException read_sscratch(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_sscratch(CPURISCVState *env, int csrno,
-                                     target_ulong val)
+                                     target_ulong val, uintptr_t ra)
 {
     env->sscratch = val;
     return RISCV_EXCP_NONE;
@@ -4102,7 +4101,7 @@ static RISCVException read_sepc(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_sepc(CPURISCVState *env, int csrno,
-                                 target_ulong val)
+                                 target_ulong val, uintptr_t ra)
 {
     env->sepc = val;
     return RISCV_EXCP_NONE;
@@ -4116,7 +4115,7 @@ static RISCVException read_scause(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_scause(CPURISCVState *env, int csrno,
-                                   target_ulong val)
+                                   target_ulong val, uintptr_t ra)
 {
     env->scause = val;
     return RISCV_EXCP_NONE;
@@ -4130,7 +4129,7 @@ static RISCVException read_stval(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_stval(CPURISCVState *env, int csrno,
-                                  target_ulong val)
+                                  target_ulong val, uintptr_t ra)
 {
     env->stval = val;
     return RISCV_EXCP_NONE;
@@ -4270,7 +4269,7 @@ static RISCVException read_satp(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_satp(CPURISCVState *env, int csrno,
-                                 target_ulong val)
+                                 target_ulong val, uintptr_t ra)
 {
     if (!riscv_cpu_cfg(env)->mmu) {
         return RISCV_EXCP_NONE;
@@ -4492,7 +4491,7 @@ static RISCVException read_hstatus(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hstatus(CPURISCVState *env, int csrno,
-                                    target_ulong val)
+                                    target_ulong val, uintptr_t ra)
 {
     uint64_t mask = (target_ulong)-1;
     if (!env_archcpu(env)->cfg.ext_svukte) {
@@ -4524,7 +4523,7 @@ static RISCVException read_hedeleg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hedeleg(CPURISCVState *env, int csrno,
-                                    target_ulong val)
+                                    target_ulong val, uintptr_t ra)
 {
     env->hedeleg = val & vs_delegable_excps;
     return RISCV_EXCP_NONE;
@@ -4545,7 +4544,7 @@ static RISCVException read_hedelegh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hedelegh(CPURISCVState *env, int csrno,
-                                    target_ulong val)
+                                     target_ulong val, uintptr_t ra)
 {
     RISCVException ret;
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
@@ -4808,7 +4807,7 @@ static RISCVException read_hcounteren(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hcounteren(CPURISCVState *env, int csrno,
-                                       target_ulong val)
+                                       target_ulong val, uintptr_t ra)
 {
     RISCVCPU *cpu = env_archcpu(env);
 
@@ -4828,7 +4827,7 @@ static RISCVException read_hgeie(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hgeie(CPURISCVState *env, int csrno,
-                                  target_ulong val)
+                                  target_ulong val, uintptr_t ra)
 {
     /* Only GEILEN:1 bits implemented and BIT0 is never implemented */
     val &= ((((target_ulong)1) << env->geilen) - 1) << 1;
@@ -4847,7 +4846,7 @@ static RISCVException read_htval(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_htval(CPURISCVState *env, int csrno,
-                                  target_ulong val)
+                                  target_ulong val, uintptr_t ra)
 {
     env->htval = val;
     return RISCV_EXCP_NONE;
@@ -4861,7 +4860,7 @@ static RISCVException read_htinst(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_htinst(CPURISCVState *env, int csrno,
-                                   target_ulong val)
+                                   target_ulong val, uintptr_t ra)
 {
     return RISCV_EXCP_NONE;
 }
@@ -4883,7 +4882,7 @@ static RISCVException read_hgatp(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hgatp(CPURISCVState *env, int csrno,
-                                  target_ulong val)
+                                  target_ulong val, uintptr_t ra)
 {
     env->hgatp = legalize_xatp(env, env->hgatp, val);
     return RISCV_EXCP_NONE;
@@ -4901,7 +4900,7 @@ static RISCVException read_htimedelta(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_htimedelta(CPURISCVState *env, int csrno,
-                                       target_ulong val)
+                                       target_ulong val, uintptr_t ra)
 {
     if (!env->rdtime_fn) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -4933,7 +4932,7 @@ static RISCVException read_htimedeltah(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_htimedeltah(CPURISCVState *env, int csrno,
-                                        target_ulong val)
+                                        target_ulong val, uintptr_t ra)
 {
     if (!env->rdtime_fn) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -4957,7 +4956,7 @@ static RISCVException read_hvictl(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hvictl(CPURISCVState *env, int csrno,
-                                   target_ulong val)
+                                   target_ulong val, uintptr_t ra)
 {
     env->hvictl = val & HVICTL_VALID_MASK;
     return RISCV_EXCP_NONE;
@@ -5022,7 +5021,7 @@ static RISCVException read_hviprio1(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hviprio1(CPURISCVState *env, int csrno,
-                                     target_ulong val)
+                                     target_ulong val, uintptr_t ra)
 {
     return write_hvipriox(env, 0, env->hviprio, val);
 }
@@ -5034,7 +5033,7 @@ static RISCVException read_hviprio1h(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hviprio1h(CPURISCVState *env, int csrno,
-                                      target_ulong val)
+                                      target_ulong val, uintptr_t ra)
 {
     return write_hvipriox(env, 4, env->hviprio, val);
 }
@@ -5046,7 +5045,7 @@ static RISCVException read_hviprio2(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hviprio2(CPURISCVState *env, int csrno,
-                                     target_ulong val)
+                                     target_ulong val, uintptr_t ra)
 {
     return write_hvipriox(env, 8, env->hviprio, val);
 }
@@ -5058,7 +5057,7 @@ static RISCVException read_hviprio2h(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hviprio2h(CPURISCVState *env, int csrno,
-                                      target_ulong val)
+                                      target_ulong val, uintptr_t ra)
 {
     return write_hvipriox(env, 12, env->hviprio, val);
 }
@@ -5072,7 +5071,7 @@ static RISCVException read_vsstatus(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
-                                     target_ulong val)
+                                     target_ulong val, uintptr_t ra)
 {
     uint64_t mask = (target_ulong)-1;
     if ((val & VSSTATUS64_UXL) == 0) {
@@ -5097,7 +5096,7 @@ static RISCVException read_vstvec(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_vstvec(CPURISCVState *env, int csrno,
-                                   target_ulong val)
+                                   target_ulong val, uintptr_t ra)
 {
     /* bits [1:0] encode mode; 0 = direct, 1 = vectored, 2 >= reserved */
     if ((val & 3) < 2) {
@@ -5116,7 +5115,7 @@ static RISCVException read_vsscratch(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_vsscratch(CPURISCVState *env, int csrno,
-                                      target_ulong val)
+                                      target_ulong val, uintptr_t ra)
 {
     env->vsscratch = val;
     return RISCV_EXCP_NONE;
@@ -5130,7 +5129,7 @@ static RISCVException read_vsepc(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_vsepc(CPURISCVState *env, int csrno,
-                                  target_ulong val)
+                                  target_ulong val, uintptr_t ra)
 {
     env->vsepc = val;
     return RISCV_EXCP_NONE;
@@ -5144,7 +5143,7 @@ static RISCVException read_vscause(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_vscause(CPURISCVState *env, int csrno,
-                                    target_ulong val)
+                                    target_ulong val, uintptr_t ra)
 {
     env->vscause = val;
     return RISCV_EXCP_NONE;
@@ -5158,7 +5157,7 @@ static RISCVException read_vstval(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_vstval(CPURISCVState *env, int csrno,
-                                   target_ulong val)
+                                   target_ulong val, uintptr_t ra)
 {
     env->vstval = val;
     return RISCV_EXCP_NONE;
@@ -5172,7 +5171,7 @@ static RISCVException read_vsatp(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_vsatp(CPURISCVState *env, int csrno,
-                                  target_ulong val)
+                                  target_ulong val, uintptr_t ra)
 {
     env->vsatp = legalize_xatp(env, env->vsatp, val);
     return RISCV_EXCP_NONE;
@@ -5186,7 +5185,7 @@ static RISCVException read_mtval2(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mtval2(CPURISCVState *env, int csrno,
-                                   target_ulong val)
+                                   target_ulong val, uintptr_t ra)
 {
     env->mtval2 = val;
     return RISCV_EXCP_NONE;
@@ -5200,7 +5199,7 @@ static RISCVException read_mtinst(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mtinst(CPURISCVState *env, int csrno,
-                                   target_ulong val)
+                                   target_ulong val, uintptr_t ra)
 {
     env->mtinst = val;
     return RISCV_EXCP_NONE;
@@ -5215,7 +5214,7 @@ static RISCVException read_mseccfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mseccfg(CPURISCVState *env, int csrno,
-                                    target_ulong val)
+                                    target_ulong val, uintptr_t ra)
 {
     mseccfg_csr_write(env, val);
     return RISCV_EXCP_NONE;
@@ -5231,7 +5230,7 @@ static RISCVException read_pmpcfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_pmpcfg(CPURISCVState *env, int csrno,
-                                   target_ulong val)
+                                   target_ulong val, uintptr_t ra)
 {
     uint32_t reg_index = csrno - CSR_PMPCFG0;
 
@@ -5247,7 +5246,7 @@ static RISCVException read_pmpaddr(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_pmpaddr(CPURISCVState *env, int csrno,
-                                    target_ulong val)
+                                    target_ulong val, uintptr_t ra)
 {
     pmpaddr_csr_write(env, csrno - CSR_PMPADDR0, val);
     return RISCV_EXCP_NONE;
@@ -5261,7 +5260,7 @@ static RISCVException read_tselect(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_tselect(CPURISCVState *env, int csrno,
-                                    target_ulong val)
+                                    target_ulong val, uintptr_t ra)
 {
     tselect_csr_write(env, val);
     return RISCV_EXCP_NONE;
@@ -5285,7 +5284,7 @@ static RISCVException read_tdata(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_tdata(CPURISCVState *env, int csrno,
-                                  target_ulong val)
+                                  target_ulong val, uintptr_t ra)
 {
     if (!tdata_available(env, csrno - CSR_TDATA1)) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -5310,7 +5309,7 @@ static RISCVException read_mcontext(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mcontext(CPURISCVState *env, int csrno,
-                                     target_ulong val)
+                                     target_ulong val, uintptr_t ra)
 {
     bool rv32 = riscv_cpu_mxl(env) == MXL_RV32 ? true : false;
     int32_t mask;
@@ -5334,43 +5333,50 @@ static RISCVException read_mnscratch(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static int write_mnscratch(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_mnscratch(CPURISCVState *env, int csrno,
+                                      target_ulong val, uintptr_t ra)
 {
     env->mnscratch = val;
     return RISCV_EXCP_NONE;
 }
 
-static int read_mnepc(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_mnepc(CPURISCVState *env, int csrno,
+                                 target_ulong *val)
 {
     *val = env->mnepc;
     return RISCV_EXCP_NONE;
 }
 
-static int write_mnepc(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_mnepc(CPURISCVState *env, int csrno,
+                                  target_ulong val, uintptr_t ra)
 {
     env->mnepc = val;
     return RISCV_EXCP_NONE;
 }
 
-static int read_mncause(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_mncause(CPURISCVState *env, int csrno,
+                                   target_ulong *val)
 {
     *val = env->mncause;
     return RISCV_EXCP_NONE;
 }
 
-static int write_mncause(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_mncause(CPURISCVState *env, int csrno,
+                                    target_ulong val, uintptr_t ra)
 {
     env->mncause = val;
     return RISCV_EXCP_NONE;
 }
 
-static int read_mnstatus(CPURISCVState *env, int csrno, target_ulong *val)
+static RISCVException read_mnstatus(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
 {
     *val = env->mnstatus;
     return RISCV_EXCP_NONE;
 }
 
-static int write_mnstatus(CPURISCVState *env, int csrno, target_ulong val)
+static RISCVException write_mnstatus(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
 {
     target_ulong mask = (MNSTATUS_NMIE | MNSTATUS_MNPP);
 
@@ -5540,7 +5546,7 @@ static RISCVException riscv_csrrw_do64(CPURISCVState *env, int csrno,
     if (write_mask) {
         new_value = (old_value & ~write_mask) | (new_value & write_mask);
         if (csr_ops[csrno].write) {
-            ret = csr_ops[csrno].write(env, csrno, new_value);
+            ret = csr_ops[csrno].write(env, csrno, new_value, 0);
             if (ret != RISCV_EXCP_NONE) {
                 return ret;
             }
@@ -5603,7 +5609,7 @@ static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
             }
         } else if (csr_ops[csrno].write) {
             /* avoids having to write wrappers for all registers */
-            ret = csr_ops[csrno].write(env, csrno, int128_getlo(new_value));
+            ret = csr_ops[csrno].write(env, csrno, int128_getlo(new_value), 0);
             if (ret != RISCV_EXCP_NONE) {
                 return ret;
             }
@@ -5714,7 +5720,7 @@ static RISCVException read_jvt(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_jvt(CPURISCVState *env, int csrno,
-                                target_ulong val)
+                                target_ulong val, uintptr_t ra)
 {
     env->jvt = val;
     return RISCV_EXCP_NONE;
-- 
2.49.0


