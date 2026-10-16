Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF9ACC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWPC-0004ll-Vv; Thu, 15 Oct 2026 21:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMQ-0000Vh-Mk
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:56 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMM-0004Ix-07
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:48 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3acb11973c3so762786a91.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112624; x=1792717424; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tJfLxSrZH/zEvQTCiw5doUQIpEANR5hXpDeQCyBhDV8=;
 b=osc4b5H+GyhGVMoNN6BgSih5waDh+MfeM3LRwV84RsO/ItY7uv2F5GU+HHsnN7r4/Y
 8/k1QqzyX/voTgZ0g+t1upWHHNA+ES43mHjWFfEvwosTbzNME6xGcipAATEK2U1sfSx8
 6UGaFgTlZ0uTeWFv97OqhBvkFsLEAcc7bBzs5OAcS2TrOCLmbonSZ9rHIbRi4kdWOV0u
 zJG3/2mohbtSY4A+1zzkwfUb1ybE7QhdEkGZwDZ3cJ5GtFPu9qgY4nPgAKf2MkaPIFmF
 V5nlxBNMoc28nPvR75P4W1vGtmWyQClvngS/2IYPF0JLzhAVCfl2nNS6YC0+yrUmFazK
 qPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112624; x=1792717424;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tJfLxSrZH/zEvQTCiw5doUQIpEANR5hXpDeQCyBhDV8=;
 b=O2NvIbiogTV56dPv99aKuYpBYOqwxGWu9Tq9Do2IEgBZahIH7TUbUcsYqj21wvDh0e
 ojmuWerUONeaYqmQN7TQDBMWTI6xCkuCckigqcFXwp5EdTDmKBHxOWnp4h2MmOwMh5d3
 I4Y4R4JNINyxEUEhwiwd+GgyQtVPuu/cE6VBueoIIoBJTAGnxe/MNXojRUBfdEauo2ja
 uatLj+uC9F8gzHLyIXqxaQyBW0gn8HzK1Y1YV5toc1z1fSvwWHXLUfnLBdFhOzZUnX9c
 MiWTTxgaqhWlOYXHIC0yhciFfPqQ9YquTlUzLHd6ZKw91yfqNeuKJuX2NjKCNfNSO3bJ
 48aw==
X-Gm-Message-State: AFq9FYL8kKBzXRlEcdm5L4uSNbW2HsTyfcpI+izzvdCaXyyQTfks6QPE
 i0sV+5FrXLc8HqK6ZwKFEDunVQcEKvxrWp2n1hoTJsNHtrFUX7f5IW4zNb+B8g==
X-Gm-Gg: AYBFou0qh7ptrXtYyLhl+ITWoPvLWLVHqhr2S3YidhFvxPxBLVVNfyUK6FtlBTExR/f
 a9BncWapY+VhdWEIXeCOAHmLfq2h9/JFuv0xMi2vol7cZ2eJ+0Sk9qPxe7H7x/FXoY6Z9vpJfqi
 1ogVMNAK6rXIXx2drnHq/KaGxaGkcfJeaApoorSLUuJKt+jYtImPYCoSCMAaLE8DOyz3wrRgwxX
 GbvXHDmcUHFqDVG9xcU38q17oh02e2CPQup+wvEhzFVMHIN992b2LbQU6zzptOFH3g1qtws/X6j
 8YK1/elgkyRl4YCPI1EgGWO0d+W+/uLQU7tU0hxl443vcJYR/nWdVyi2Rs2QUaCRYbuoMJnPDa0
 uO45XxJ+5bHep9msU+W8iujrp/7rBCzELmiYSkDRmQltS8edx7xFxLSGStm3ZFQQipoYD4pcJrb
 dpQBLBAgow/Hbf6wc9BM6CocyvVZ6jT0qEsm17RRllV16b6Uw+GF6jbpBEosuQWWNfbHJPkiPBT
 MM+EAZR/uNE4igy
X-Received: by 2002:a17:90b:17c4:b0:3ac:adce:60bb with SMTP id
 98e67ed59e1d1-3acadce6700mr2369193a91.23.1792112623953; 
 Thu, 15 Oct 2026 18:03:43 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:03:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 20/50] target/riscv: Add riscv_cpu_get_mip()
Date: Fri, 16 Oct 2026 11:02:07 +1000
Message-ID: <20261016010237.1102834-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
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
index da4c1a090b..b8d6f992ba 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -916,8 +916,9 @@ uint64_t riscv_cpu_all_pending(CPURISCVState *env)
     uint32_t gein = get_field(env->hstatus, HSTATUS_VGEIN);
     uint64_t vsgein = (env->hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
     uint64_t vstip = (env->vstime_irq) ? MIP_VSTIP : 0;
+    uint64_t mip = riscv_cpu_get_mip(env);
 
-    return (env->mip | vsgein | vstip) & env->mie;
+    return (mip | vsgein | vstip) & env->mie;
 }
 
 int riscv_cpu_mirq_pending(CPURISCVState *env)
@@ -953,6 +954,11 @@ int riscv_cpu_vsirq_pending(CPURISCVState *env)
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
index 6a8533ee31..f03f149a66 100644
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


