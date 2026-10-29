Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18723606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMLwY-0000d8-Sb; Thu, 29 Oct 2026 04:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xMLwX-0000cz-Kb
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 04:57:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xMLwU-0003Dc-Ig
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 04:57:05 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8CxPNL+CeNqVWUaAA--.11339S3;
 Thu, 29 Oct 2026 16:55:26 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJBx5cz8CeNqczAxAA--.10051S3;
 Thu, 29 Oct 2026 16:55:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/loongarch: Replace kvm_cpu_has_msgint() with
 cpu_has_msgint()
Date: Thu, 29 Oct 2026 16:56:53 +0800
Message-ID: <20261029085654.78806-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029085654.78806-1-maobibo@loongson.cn>
References: <20261029085654.78806-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx5cz8CeNqczAxAA--.10051S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr1xXr45ZF4rCF1DKF4fXrc_yoW5Xrykpr
 W3CFWUtFW8KrZ7A3Z5Xa98Xr9xZr47Kw42vaySkryvkF45Gry8Xr18t39rtF15Aay8Wr10
 gF1Fy3W5WF47Z3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0FALUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

target/loongarch: Use cpu_has_msgint() and FIELD_EX32 for cpucfg

cpu_has_msgint() is more generic and can be used in TCG mode, so use it
instead of the KVM-specific feature check.

The cpucfg register is 32 bits wide; use FIELD_EX32() rather than
FIELD_EX64() when extracting its fields.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.h     |  6 ++++++
 target/loongarch/kvm/kvm.c | 11 ++---------
 target/loongarch/machine.c |  2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 5cc2370da2..e8867ea2a7 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -540,6 +540,12 @@ static inline bool is_va32(CPULoongArchState *env)
     return va32;
 }
 
+static inline bool cpu_has_msgint(CPULoongArchState *env)
+{
+
+    return FIELD_EX32(env->cpucfg[1], CPUCFG1, MSG_INT);
+}
+
 static inline void set_pc(CPULoongArchState *env, uint64_t value)
 {
     if (is_va32(env)) {
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 7ca95181a1..8732f55e06 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -36,13 +36,6 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
 
-static bool kvm_cpu_has_msgint(CPUState *cs)
-{
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-
-    return FIELD_EX64(cpu->env.cpucfg[1], CPUCFG1, MSG_INT);
-}
-
 static int kvm_get_stealtime(CPUState *cs)
 {
     CPULoongArchState *env = cpu_env(cs);
@@ -374,7 +367,7 @@ static int kvm_loongarch_get_csr(CPUState *cs)
      * Since register CSR_ESTAT will sync software pending MSGINT status to
      * hardware register and modify HW CSR MSGIS registers.
      */
-    if (kvm_cpu_has_msgint(cs)) {
+    if (cpu_has_msgint(env)) {
         ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(0)),
                                &sys->CSR_MSGIS[0]);
 
@@ -564,7 +557,7 @@ static int kvm_loongarch_put_csr(CPUState *cs, KvmPutState level)
 
     ret |= kvm_loongarch_put_pmu(cs);
 
-    if (kvm_cpu_has_msgint(cs)) {
+    if (cpu_has_msgint(env)) {
         ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(0)),
                                &sys->CSR_MSGIS[0]);
 
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 952c5497af..4acab2a4a3 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -49,7 +49,7 @@ static bool msgint_needed(void *opaque)
 {
     LoongArchCPU *cpu = opaque;
 
-    return FIELD_EX64(cpu->env.cpucfg[1], CPUCFG1, MSG_INT);
+    return cpu_has_msgint(&cpu->env);
 }
 
 static const VMStateDescription vmstate_msgint = {
-- 
2.54.0


