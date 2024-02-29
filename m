Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5339BC54E49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 03:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfXH5-0008A3-Ke; Wed, 28 Feb 2024 22:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rfXH2-00089W-QI
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:39:56 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rfXH0-0001yV-DF
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:39:56 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Axz+t8_N9lCbASAA--.47586S3;
 Thu, 29 Feb 2024 11:39:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTs18_N9lmVFKAA--.64709S2; 
 Thu, 29 Feb 2024 11:39:40 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] target/loongarch: Add TCG macro in structure CPUArchState
Date: Thu, 29 Feb 2024 11:39:40 +0800
Message-Id: <20240229033940.228089-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTs18_N9lmVFKAA--.64709S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtrWxGFWxGFyfGF18GF18CrX_yoW7GrW5pr
 y3CF47KF48JrZ3Xas7Z3s8WFn8Xr4xG342va17KryIka18Jr15ur18twsFvFZ8J345WryI
 9F10yw1UuF4UX3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

In structure CPUArchState some struct elements are only used in TCG
mode, and it is not used in KVM mode. Macro CONFIG_TCG is added to
make it simpiler in KVM mode, also there is the same modification
in c code when these struct elements are used.

When VM is migrated in KVM mode, TLB entries are not necessary to save
in VMState. It is only useful when it runs in TCG mode, macro CONFIG_TCG
is also added.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c        | 14 +++++++++++---
 target/loongarch/cpu.h        | 16 ++++++++++------
 target/loongarch/cpu_helper.c |  9 +++++++++
 target/loongarch/machine.c    |  4 ++++
 4 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index bc2684179f..35db8e244d 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -517,7 +517,9 @@ static void loongarch_cpu_reset_hold(Object *obj)
         lacc->parent_phases.hold(obj);
     }
 
+#ifdef CONFIG_TCG
     env->fcsr0_mask = FCSR0_M1 | FCSR0_M2 | FCSR0_M3;
+#endif
     env->fcsr0 = 0x0;
 
     int n;
@@ -562,7 +564,9 @@ static void loongarch_cpu_reset_hold(Object *obj)
 
 #ifndef CONFIG_USER_ONLY
     env->pc = 0x1c000000;
+#ifdef CONFIG_TCG
     memset(env->tlb, 0, sizeof(env->tlb));
+#endif
     if (kvm_enabled()) {
         kvm_arch_reset_vcpu(env);
     }
@@ -696,11 +700,15 @@ void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
     CPULoongArchState *env = &cpu->env;
-    int i;
+    int i, fp_status;
 
+#ifdef CONFIG_TCG
+    fp_status = get_float_exception_flags(&env->fp_status);
+#else
+    fp_status = 0;
+#endif
     qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
-    qemu_fprintf(f, " FCSR0 0x%08x  fp_status 0x%02x\n", env->fcsr0,
-                 get_float_exception_flags(&env->fp_status));
+    qemu_fprintf(f, " FCSR0 0x%08x  fp_status 0x%02x\n", env->fcsr0, fp_status);
 
     /* gpr */
     for (i = 0; i < 32; i++) {
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ec37579fd6..c25ad112b1 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -272,6 +272,7 @@ union fpr_t {
     VReg  vreg;
 };
 
+#ifdef CONFIG_TCG
 struct LoongArchTLB {
     uint64_t tlb_misc;
     /* Fields corresponding to CSR_TLBELO0/1 */
@@ -279,23 +280,18 @@ struct LoongArchTLB {
     uint64_t tlb_entry1;
 };
 typedef struct LoongArchTLB LoongArchTLB;
+#endif
 
 typedef struct CPUArchState {
     uint64_t gpr[32];
     uint64_t pc;
 
     fpr_t fpr[32];
-    float_status fp_status;
     bool cf[8];
-
     uint32_t fcsr0;
-    uint32_t fcsr0_mask;
 
     uint32_t cpucfg[21];
 
-    uint64_t lladdr; /* LL virtual address compared against SC */
-    uint64_t llval;
-
     /* LoongArch CSRs */
     uint64_t CSR_CRMD;
     uint64_t CSR_PRMD;
@@ -352,8 +348,16 @@ typedef struct CPUArchState {
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
 
+#ifdef CONFIG_TCG
+    float_status fp_status;
+    uint32_t fcsr0_mask;
+    uint64_t lladdr; /* LL virtual address compared against SC */
+    uint64_t llval;
+#endif
 #ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_TCG
     LoongArchTLB  tlb[LOONGARCH_TLB_MAX];
+#endif
 
     AddressSpace *address_space_iocsr;
     bool load_elf;
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 45f821d086..d1cdbe30ba 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -11,6 +11,7 @@
 #include "internals.h"
 #include "cpu-csr.h"
 
+#ifdef CONFIG_TCG
 static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
                                    int *prot, target_ulong address,
                                    int access_type, int index, int mmu_idx)
@@ -154,6 +155,14 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
 
     return TLBRET_NOMATCH;
 }
+#else
+static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
+                                 int *prot, target_ulong address,
+                                 MMUAccessType access_type, int mmu_idx)
+{
+    return TLBRET_NOMATCH;
+}
+#endif
 
 static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
                         target_ulong dmw)
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index c7029fb9b4..eb6f878789 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -109,6 +109,7 @@ static const VMStateDescription vmstate_lasx = {
     },
 };
 
+#ifdef CONFIG_TCG
 /* TLB state */
 const VMStateDescription vmstate_tlb = {
     .name = "cpu/tlb",
@@ -121,6 +122,7 @@ const VMStateDescription vmstate_tlb = {
         VMSTATE_END_OF_LIST()
     }
 };
+#endif
 
 /* LoongArch CPU state */
 const VMStateDescription vmstate_loongarch_cpu = {
@@ -187,9 +189,11 @@ const VMStateDescription vmstate_loongarch_cpu = {
         VMSTATE_UINT64(env.CSR_DBG, LoongArchCPU),
         VMSTATE_UINT64(env.CSR_DERA, LoongArchCPU),
         VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
+#ifdef CONFIG_TCG
         /* TLB */
         VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
                              0, vmstate_tlb, LoongArchTLB),
+#endif
 
         VMSTATE_END_OF_LIST()
     },
-- 
2.39.3


