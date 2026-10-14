Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEC0CC6B1C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGprC-0006sC-1B; Tue, 13 Oct 2026 23:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpr7-0006ZN-A8
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:41 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpr5-0001f2-G9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:41 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2e8fe8e343fso11952105ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949238; x=1792554038; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xFNjfPuUAVqU31Pm7ELh8jcYlJfnMJdLu8Ehq+rkfgU=;
 b=FIIiFoRLpteLbGIdoCuiYt2Fktreih9ECDkLShcPb4h8H6Rm25996amTZtYasey0jp
 snF6wtT3VGQKFvpaIeNOcP8vtO1RSobTzLlT3uFoVPJ/ssIZtpM4JgiDE3kATGQg3yjM
 ceWSifLudRDAWKNEt9vdpjAVVBTF9O2V2n/KhREr/7CrJNpF7X68+9gmnBSs2rSdFX25
 BjAlhbtWBv8YcBgfzwRkyINsKa/sxdLPubrzHGtJVUi40stfcdH+DCnaxANHErUTWIf0
 eBAnO7UHE/OuIZ+K3UlmX/ezvuysdvsEFgX6hf1sn8wY0RbDa4EFANVp1YAtmSvZfHXL
 fRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949238; x=1792554038;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xFNjfPuUAVqU31Pm7ELh8jcYlJfnMJdLu8Ehq+rkfgU=;
 b=MIH2C/Yg9DnV2CyjpY7xRkdNC7/YoL3F7xVR8WOidNeqrcwf552vydjNDlVf9Ptz4f
 WXOIiIc7hRmyKL7yPVHc7e35EriLnwFZ4QWZ/CXtRWKVwKM322u9bZOBF437V8E6Fx+w
 fDgXPsH8pco0xRnJoD6ti+LulDtgNga0ATk/x4lku0cs8m7r9ybWKXjHig+A50CFuFhC
 WXNmgsHZjTltfDmZzuz+p+rgHh/CoyLRXKnBmJywjibXaVe4Y1Bi2Xrsg0/p8nj+sWWK
 sTjmY5Ci6KDElzbtMlKVXpjMs9bETHY65nhasRczNUOtHhll6gvv6wzFJJVG3GqSABDu
 8KEQ==
X-Gm-Message-State: AFq9FYI9YLYGm8IyaREFcRG+i9DKWgPPMZGww4Kp/qyewWIFwdRUpQ1H
 rcheJMrQUOhEfrzRhjgNgFg85uTlJ2TZClyzjpV6pdnoptcYhwFJSDluv/u5XA==
X-Gm-Gg: AYBFou0ZWe4zDEC5lCLXZMYBgzBbBF3qL8kezaMUDs+wWkD2X9pmYnZjkxsWfpNrhmA
 eTz+bqhnPaigyCZM3glctdhvWUyHr9jEHUQR0Ez1I+cwcVKOtWFE9PwcTN7YmgDnHLU50uYUh+k
 UurWa/oSUxoq2hZx5mE7la/rZuD/brrXzt+nCwMzgYcjDqROZh9xg7T6dKd0a6mRwRFdy3yWlYD
 sZFH35duobT5NBrTYGusR6kFg/2TDhSbtCHV3ggFYvrhxET4a484aI2RVDpeCsGykVHcuZyfCsE
 886LnKxbpm4/fpCbFWPOGwTfyR3ZGs/yvdf3A8p4qHrhs/e97+31j7SVbDEMuHyrUpvIFB/EMAc
 tfGmiYcNZjU/schUSchxqzwMwjtgTpnuJvPBYX/sAyZ7bAqWQh5ezsG4sU4Uw0M294Nk+nzvmi9
 nLMbznIhIugRFWLpbag+3JSYp0ycHkA5gjP/lkZsIhATdvnA7//fHFJq1RsXuxtHEzOjURYggif
 dk2zpHnWtCJUox0
X-Received: by 2002:a17:90b:28c8:b0:3a7:a463:54bf with SMTP id
 98e67ed59e1d1-3ab3a99825cmr10376536a91.33.1791949238058; 
 Tue, 13 Oct 2026 20:40:38 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/52] target/riscv: Add riscv_cpu_get_mip()
Date: Wed, 14 Oct 2026 13:38:40 +1000
Message-ID: <20261014033907.3332383-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Route MIP reads in the interrupt, CSR, ACLINT and pending-IRQ
code through a single riscv_cpu_get_mip() accessor, so the
implementation can change in one place.

riscv_cpu_update_mip() now reads the old value under the BQL,
so the returned value matches the one written.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260930174508.81497-6-philmd@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h            |  7 +++++++
 hw/intc/riscv_aclint.c        |  2 +-
 target/riscv/cpu.c            |  8 +++++++-
 target/riscv/tcg/cpu_helper.c | 12 +++++++-----
 target/riscv/tcg/csr.c        |  6 ++++--
 5 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 24b22032e1..f9f0146f56 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -688,6 +688,13 @@ bool riscv_cpu_translate_for_debug(CPUState *cs, vaddr addr,
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
+/**
+ * riscv_cpu_get_mip:
+ * @env: CPURISCVState
+ *
+ * Returns: the current value of the Machine Interrupt Pending (MIP) register.
+ */
+uint64_t riscv_cpu_get_mip(const CPURISCVState *env);
 /**
  * riscv_cpu_update_mip:
  * @env: CPURISCVState
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 2d133d0dcf..4bd359c338 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -438,7 +438,7 @@ static uint64_t riscv_aclint_swi_read(void *opaque, hwaddr addr,
             qemu_log_mask(LOG_GUEST_ERROR,
                           "aclint-swi: invalid hartid: %zu", hartid);
         } else if ((addr & 0x3) == 0) {
-            return (swi->sswi) ? 0 : ((env->mip & MIP_MSIP) > 0);
+            return (swi->sswi) ? 0 : ((riscv_cpu_get_mip(env) & MIP_MSIP) > 0);
         }
     }
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e08cb2f356..3e1fde207e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -917,8 +917,9 @@ uint64_t riscv_cpu_all_pending(CPURISCVState *env)
     uint32_t gein = get_field(env->hstatus, HSTATUS_VGEIN);
     uint64_t vsgein = (env->hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
     uint64_t vstip = (env->vstime_irq) ? MIP_VSTIP : 0;
+    uint64_t mip = riscv_cpu_get_mip(env);
 
-    return (env->mip | vsgein | vstip) & env->mie;
+    return (mip | vsgein | vstip) & env->mie;
 }
 
 int riscv_cpu_mirq_pending(CPURISCVState *env)
@@ -954,6 +955,11 @@ int riscv_cpu_vsirq_pending(CPURISCVState *env)
                                     (irqs | irqs_f_vs), env->hviprio);
 }
 
+uint64_t riscv_cpu_get_mip(const CPURISCVState *env)
+{
+    return env->mip;
+}
+
 bool riscv_cpu_has_work(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 6b44be4df8..7ffee54777 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -567,7 +567,7 @@ void riscv_cpu_interrupt(CPURISCVState *env)
 
     vstip = env->vstime_irq ? MIP_VSTIP : 0;
 
-    if (env->mip | vsgein | vstip | irqf) {
+    if (riscv_cpu_get_mip(env) | vsgein | vstip | irqf) {
         cpu_interrupt(cs, CPU_INTERRUPT_HARD);
     } else {
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
@@ -576,14 +576,15 @@ void riscv_cpu_interrupt(CPURISCVState *env)
 
 uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
 {
-    uint64_t old = env->mip;
+    uint64_t old;
 
     /* No need to update mip for VSTIP */
     mask = ((mask == MIP_VSTIP) && env->vstime_irq) ? 0 : mask;
 
     BQL_LOCK_GUARD();
 
-    env->mip = (env->mip & ~mask) | (value & mask);
+    old = riscv_cpu_get_mip(env);
+    env->mip = (old & ~mask) | (value & mask);
 
     riscv_cpu_interrupt(env);
 
@@ -2085,10 +2086,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     bool async = !!(cs->exception_index & RISCV_EXCP_INT_FLAG);
     target_ulong cause = cs->exception_index & RISCV_EXCP_INT_MASK;
     uint64_t deleg = async ? env->mideleg : env->medeleg;
+    uint64_t mip = riscv_cpu_get_mip(env);
     bool s_injected = env->mvip & (1ULL << cause) & env->mvien &&
-        !(env->mip & (1ULL << cause));
+                                   !(mip & (1ULL << cause));
     bool vs_injected = env->hvip & (1ULL << cause) & env->hvien &&
-        !(env->mip & (1ULL << cause));
+                                    !(mip & (1ULL << cause));
     bool smode_double_trap = false;
     uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
     const bool prev_virt = env->virt_enabled;
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index a3351428cb..a030614434 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3861,7 +3861,7 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
     if (mask) {
         old_mip = riscv_cpu_update_mip(env, mask, (new_val & mask));
     } else {
-        old_mip = env->mip;
+        old_mip = riscv_cpu_get_mip(env);
     }
 
     if (csrno != CSR_HVIP) {
@@ -4604,8 +4604,10 @@ static RISCVException read_vstopi(CPURISCVState *env, int csrno,
     hviprio = get_field(env->hvictl, HVICTL_IPRIO);
 
     if (gein) {
+        uint64_t mip = riscv_cpu_get_mip(env);
+
         vsgein = (env->hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
-        vseip = env->mie & (env->mip | vsgein) & MIP_VSEIP;
+        vseip = env->mie & (mip | vsgein) & MIP_VSEIP;
         if (gein <= env->geilen && vseip) {
             siid[scount] = IRQ_S_EXT;
             siprio[scount] = IPRIO_MMAXIPRIO + 1;
-- 
2.55.0


