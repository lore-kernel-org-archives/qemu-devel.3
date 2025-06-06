Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96818C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 07:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNRV2-0007Ne-H9; Fri, 06 Jun 2025 03:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uNRV1-0007NH-1b
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 03:28:23 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uNRUy-0007o7-JS
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 03:28:22 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-311bd8ce7e4so1637414a91.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 00:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1749194898; x=1749799698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQx/T6Uc/iWMaJC2E/aIGKCHSInnCoQ5QtSnpSy+XOU=;
 b=Ehw37s7SIUpune5B6cOEvJq05X8AdPTJNcX4h+vQupsDJbz1OaNum4rpzugWRGukxc
 jam001Y1XOLEzLLDqPSPPBXH81oxpr8tC6oEliBJRI55x8+JiKpAWxchEt+1wdnB3rN1
 tHfwQTusy66nDEjH77NXnxupV7p5GKLYt6XW4cBpCv0DAzFTxw3W/JciYSFgXePgNHBP
 P4/F3vF1gW9IAeKyhTQE0rg7uPKi08Qijnaw7X9nATZ1Gm6zqotdE1ACbNeeVYvdMW2A
 6qyAf8YcKBHeevDuJumMxIFrWUl6Ym0bMvvTfUJ0W/aJZsVU2RAH3zlr02N93NfeA80p
 pNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749194898; x=1749799698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQx/T6Uc/iWMaJC2E/aIGKCHSInnCoQ5QtSnpSy+XOU=;
 b=FN6dWU+MXORZb+/f48+wPZ+oTG6sQJihqe5zlQbL0uo5AVsuhpaKXWk7lTzxmA/Jd9
 WJUxLsg0G6vKY6pxrGx4sVibF6moszZRzY6+4kY4KDN4pJbvjOVqm5A1LBaJOESF1Cy4
 aY4DX/t12RV4zI1DnuiL/vnGLhQAoMlogkocsI9yYQDSked6/BBVor6G61S8W6I/BoiK
 Ji31Mydsw+tnrE3DFxjVun53PJ14HLdwwVdfyEXv9cVzi0d5ZzNPRXayYdoao+VLSoWC
 ArW8cHQeZDnrKufF3wv+zK9cbretJIFsRozp0O77IZsidcFyux8uTgpShMNTpyTcwgKo
 OweA==
X-Gm-Message-State: AOJu0Yy+BnS5g1/IrRW7wFwdL07Wj8mZ/tt2UulCHf35VAcQZJVr8nBs
 vb/t9uPyQDPik4Rwoq2NaQ5jrc5ZY/sOBWgWb+rcZ8dfOwjlH+ECABKxhLTBjkdTNwQvdwKpojd
 /mKVdYsPV1ZcLt/j6NXfTeoyghyvA+13Ql/cJivM0CadkRD83TRU9JoacS/B6JN7HsZT4tZcWW1
 pkbimUO3mQ2nFfDg1Re5oKPyaQtNDjDIZf00V08b3i
X-Gm-Gg: ASbGncsEyTKLD81Z1tJkvoRsm8YvXFg3mwPJpr0IculpquVinDKxUuLPe2qmcbC5YGk
 Wp9glwGbOPbrVsLUWoBfCgC8x5uCLrIYDFPRa3t+juNlJmj63+PPPUsyaUKF01ULFKRIQQe3Zeh
 IeLDfS52kDPfZ0K6HHdASl3UmeGalma3jRYUcMZNtNZnz7/0yoe14oJnLae9DzgGdpXn5q5HrBf
 Q7qEUFBXcwnRQraOhZyc9MHfM/xhuwcKymLL5NMkoYLgEmYZlR2YkxauRs66is2CQfMxUFK/qlj
 h06MBBxmHS5HzVB8xgB8AdDxXu+s45muNhw7qkCzMQ6zdraemsL31PbckV+xi5XyQGs7fbo5DSr
 N10n97jRruk7d5c4=
X-Google-Smtp-Source: AGHT+IEAwSlXeRbLpSfGQZqK0DISLvBCuPu5bThrWs5M0PQ3NdsouE2NiURlpLWvBzroUTZ6YD3L3g==
X-Received: by 2002:a17:90b:1d92:b0:312:e8ed:758 with SMTP id
 98e67ed59e1d1-313472eb24emr3737538a91.13.1749194898149; 
 Fri, 06 Jun 2025 00:28:18 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31349f17bddsm774703a91.9.2025.06.06.00.28.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 00:28:17 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v5 2/2] target/riscv: Make PMP region count configurable
Date: Fri,  6 Jun 2025 15:25:25 +0800
Message-ID: <20250606072525.17313-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606072525.17313-1-jay.chang@sifive.com>
References: <20250606072525.17313-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Previously, the number of PMP regions was hardcoded to 16 in QEMU.
This patch replaces the fixed value with a new `pmp_regions` field,
allowing platforms to configure the number of PMP regions.

If no specific value is provided, the default number of PMP regions
remains 16 to preserve the existing behavior.

A new CPU parameter num-pmp-regions has been introduced to the QEMU
command line. For example:

	-cpu rv64, g=true, c=true, pmp=true, num-pmp-regions=8

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c                | 48 +++++++++++++++++++++++++++++--
 target/riscv/cpu.h                |  3 +-
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/csr.c                |  5 +++-
 target/riscv/machine.c            |  3 +-
 target/riscv/pmp.c                | 28 ++++++++++++------
 6 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 629ac37501..f4a09ae70f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1117,6 +1117,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cbom_blocksize = 64;
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
+    cpu->cfg.pmp_regions = 16;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
@@ -1568,6 +1569,46 @@ static const PropertyInfo prop_pmp = {
     .set = prop_pmp_set,
 };
 
+static void prop_num_pmp_regions_set(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint8_t value;
+
+    visit_type_uint8(v, name, &value, errp);
+
+    if (cpu->cfg.pmp_regions != value && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        return;
+    }
+
+    if (cpu->env.priv_ver < PRIV_VERSION_1_12_0 && value > OLD_MAX_RISCV_PMPS) {
+        error_setg(errp, "Number of PMP regions exceeds maximum available");
+        return;
+    } else if (value > MAX_RISCV_PMPS) {
+        error_setg(errp, "Number of PMP regions exceeds maximum available");
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.pmp_regions = value;
+}
+
+static void prop_num_pmp_regions_get(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint8_t value = RISCV_CPU(obj)->cfg.pmp_regions;
+
+    visit_type_uint8(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_num_pmp_regions = {
+    .type = "uint8",
+    .description = "num-pmp-regions",
+    .get = prop_num_pmp_regions_get,
+    .set = prop_num_pmp_regions_set,
+};
+
 static int priv_spec_from_str(const char *priv_spec_str)
 {
     int priv_version = -1;
@@ -2567,6 +2608,7 @@ static const Property riscv_cpu_properties[] = {
 
     {.name = "mmu", .info = &prop_mmu},
     {.name = "pmp", .info = &prop_pmp},
+    {.name = "num-pmp-regions", .info = &prop_num_pmp_regions},
 
     {.name = "priv_spec", .info = &prop_priv_spec},
     {.name = "vext_spec", .info = &prop_vext_spec},
@@ -2937,7 +2979,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_MBARE,
         .cfg.ext_zifencei = true,
         .cfg.ext_zicsr = true,
-        .cfg.pmp = true
+        .cfg.pmp = true,
+        .cfg.pmp_regions = 8
     ),
 
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U, TYPE_RISCV_VENDOR_CPU,
@@ -2948,7 +2991,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zifencei = true,
         .cfg.ext_zicsr = true,
         .cfg.mmu = true,
-        .cfg.pmp = true
+        .cfg.pmp = true,
+        .cfg.pmp_regions = 8
     ),
 
 #if defined(TARGET_RISCV32) || \
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 229ade9ed9..67323a7d9d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -159,7 +159,8 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 
 #define MMU_USER_IDX 3
 
-#define MAX_RISCV_PMPS (16)
+#define MAX_RISCV_PMPS (64)
+#define OLD_MAX_RISCV_PMPS (16)
 
 #if !defined(CONFIG_USER_ONLY)
 #include "pmp.h"
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 59f134a419..33c4f9bac8 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -163,6 +163,7 @@ TYPED_FIELD(uint16_t, elen, 0)
 TYPED_FIELD(uint16_t, cbom_blocksize, 0)
 TYPED_FIELD(uint16_t, cbop_blocksize, 0)
 TYPED_FIELD(uint16_t, cboz_blocksize, 0)
+TYPED_FIELD(uint8_t,  pmp_regions, 0)
 
 TYPED_FIELD(int8_t, max_satp_mode, -1)
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d6cd441133..6296ecd1e1 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -738,7 +738,10 @@ static RISCVException dbltrp_hmode(CPURISCVState *env, int csrno)
 static RISCVException pmp(CPURISCVState *env, int csrno)
 {
     if (riscv_cpu_cfg(env)->pmp) {
-        if (csrno <= CSR_PMPCFG3) {
+        int max_pmpcfg = (env->priv_ver >= PRIV_VERSION_1_12_0) ?
++                              CSR_PMPCFG15 : CSR_PMPCFG3;
+
+        if (csrno <= max_pmpcfg) {
             uint32_t reg_index = csrno - CSR_PMPCFG0;
 
             /* TODO: RV128 restriction check */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index c97e9ce9df..1600ec44f0 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -36,8 +36,9 @@ static int pmp_post_load(void *opaque, int version_id)
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
     int i;
+    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
-    for (i = 0; i < MAX_RISCV_PMPS; i++) {
+    for (i = 0; i < pmp_regions; i++) {
         pmp_update_rule_addr(env, i);
     }
     pmp_update_rule_nums(env);
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 5af295e410..3540327c9a 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -122,7 +122,9 @@ uint32_t pmp_get_num_rules(CPURISCVState *env)
  */
 static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
 {
-    if (pmp_index < MAX_RISCV_PMPS) {
+    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
+
+    if (pmp_index < pmp_regions) {
         return env->pmp_state.pmp[pmp_index].cfg_reg;
     }
 
@@ -136,7 +138,9 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
  */
 static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
 {
-    if (pmp_index < MAX_RISCV_PMPS) {
+    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
+
+    if (pmp_index < pmp_regions) {
         if (env->pmp_state.pmp[pmp_index].cfg_reg == val) {
             /* no change */
             return false;
@@ -236,9 +240,10 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
 void pmp_update_rule_nums(CPURISCVState *env)
 {
     int i;
+    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
     env->pmp_state.num_rules = 0;
-    for (i = 0; i < MAX_RISCV_PMPS; i++) {
+    for (i = 0; i < pmp_regions; i++) {
         const uint8_t a_field =
             pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
         if (PMP_AMATCH_OFF != a_field) {
@@ -332,6 +337,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
     int pmp_size = 0;
     hwaddr s = 0;
     hwaddr e = 0;
+    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
     /* Short cut if no rules */
     if (0 == pmp_get_num_rules(env)) {
@@ -356,7 +362,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
      * 1.10 draft priv spec states there is an implicit order
      * from low to high
      */
-    for (i = 0; i < MAX_RISCV_PMPS; i++) {
+    for (i = 0; i < pmp_regions; i++) {
         s = pmp_is_in_range(env, i, addr);
         e = pmp_is_in_range(env, i, addr + pmp_size - 1);
 
@@ -527,8 +533,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
 {
     trace_pmpaddr_csr_write(env->mhartid, addr_index, val);
     bool is_next_cfg_tor = false;
+    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
-    if (addr_index < MAX_RISCV_PMPS) {
+    if (addr_index < pmp_regions) {
         if (env->pmp_state.pmp[addr_index].addr_reg == val) {
             /* no change */
             return;
@@ -538,7 +545,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
          * In TOR mode, need to check the lock bit of the next pmp
          * (if there is a next).
          */
-        if (addr_index + 1 < MAX_RISCV_PMPS) {
+        if (addr_index + 1 < pmp_regions) {
             uint8_t pmp_cfg = env->pmp_state.pmp[addr_index + 1].cfg_reg;
             is_next_cfg_tor = PMP_AMATCH_TOR == pmp_get_a_field(pmp_cfg);
 
@@ -573,8 +580,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 {
     target_ulong val = 0;
+    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
-    if (addr_index < MAX_RISCV_PMPS) {
+    if (addr_index < pmp_regions) {
         val = env->pmp_state.pmp[addr_index].addr_reg;
         trace_pmpaddr_csr_read(env->mhartid, addr_index, val);
     } else {
@@ -592,6 +600,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 {
     int i;
     uint64_t mask = MSECCFG_MMWP | MSECCFG_MML;
+    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
     /* Update PMM field only if the value is valid according to Zjpm v1.0 */
     if (riscv_cpu_cfg(env)->ext_smmpm &&
         riscv_cpu_mxl(env) == MXL_RV64 &&
@@ -603,7 +612,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 
     /* RLB cannot be enabled if it's already 0 and if any regions are locked */
     if (!MSECCFG_RLB_ISSET(env)) {
-        for (i = 0; i < MAX_RISCV_PMPS; i++) {
+        for (i = 0; i < pmp_regions; i++) {
             if (pmp_is_locked(env, i)) {
                 val &= ~MSECCFG_RLB;
                 break;
@@ -659,6 +668,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, hwaddr addr)
     hwaddr tlb_sa = addr & ~(TARGET_PAGE_SIZE - 1);
     hwaddr tlb_ea = tlb_sa + TARGET_PAGE_SIZE - 1;
     int i;
+    uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
     /*
      * If PMP is not supported or there are no PMP rules, the TLB page will not
@@ -669,7 +679,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, hwaddr addr)
         return TARGET_PAGE_SIZE;
     }
 
-    for (i = 0; i < MAX_RISCV_PMPS; i++) {
+    for (i = 0; i < pmp_regions; i++) {
         if (pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg) == PMP_AMATCH_OFF) {
             continue;
         }
-- 
2.48.1


