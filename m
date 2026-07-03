Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC63C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgxr-000635-OL; Fri, 03 Jul 2026 12:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgxp-0005zC-P4
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:42:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgxn-0001tV-IR
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:42:05 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIpmG498312
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mzmsO7JiXjHm5ztXYmS9Sqi5Qiq4YANCLL9fM38eAL8=; b=ITOLgYnjyfUKvkVY
 eolkXReOeqgiPgFCM06RtwLhxLgASVq4Lm8+0Ua1/RUc1Tv+2L7MIEf3Wpg8LWIF
 0/8WqeNepjFL4xu/ng7MBP09ERfFf7CwXDfEmL9Ez/JrQCekMfJI/raOvUT28CHl
 l388wk4V7XqJgSqIDGnhgmm8Q2uBOYa9+ztYkQElpbBXQeCOVlldlivusaSRSwir
 /zEHyTyMRWl8MoYPWEkLSk89/z4zY4fTA1icFtJwfc7xZLmqBJr3tWkOnyHQ4cEj
 MXkxruI3+N/c7wX1xXylqMvToXnaUMcyrBLvUGqgnnAc6zywEpuu5X6XVlBqN0Kd
 wxJ7VA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qcjx4p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:41:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92ac0a54110so82263785a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096912; x=1783701712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mzmsO7JiXjHm5ztXYmS9Sqi5Qiq4YANCLL9fM38eAL8=;
 b=A0Fjbvx3h392qKlrU9sYtXQ5mSyVLSysuq5esy5npTrPLFrY02ek1y1XeRccfyrfc5
 qW0QAqWiLSmz4BxXxIzEF5+K1rGfR8cXh6ZXd/LQdAIikhFdmOqof6e5tjv2YcXnT4JV
 Pb7GeqpVHlCNOirbHpiCic6llwRSqLvAkhun5Q71g7wKwIjMrZW6O+xJ6ys69bX+7q5L
 xu+BOSdJ0RXxdv2Jv43eok4Av6leVN4+e996dAHOOD1EfX+nisqDAoAn4eam5YRujgzP
 NiXpVy+GTZ7jpe6Y69zfMlUajaSUokIzXMB3/PXObCd3m0b6OOCFCAkQPHPTx/2GGHjl
 9btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096912; x=1783701712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mzmsO7JiXjHm5ztXYmS9Sqi5Qiq4YANCLL9fM38eAL8=;
 b=fpXx33VFVY/pZWszXXxaMxDRQqSPxpv7ceBVTny8diyK03Mg90peqV/JEvMbAEOPrj
 iS7X1pAX7gQbj9Np1E/rly+feTysJONUIMKPZJ9Z3plNQjo3jiREcvGLdF1F1sy7d4r2
 g4wI70wOtVQnaxW8FiKuJ0tO/h4srBZQSURA824RgQR2Y9j0AO1EOm6T8MjX3lGPbela
 neb63tyceLcsbjCQVMfpDaYtkV714iXIBe5TMFX9VvIYchA45zwo7L6XxSh9y/5Gs2PG
 pacKXqRqhQ4gcifdcNdTJLUythOkTF9vGS7WOejbibHEq36kS31JvlG7divImIITJANV
 KwZA==
X-Gm-Message-State: AOJu0Yz8bl87VqXW1/9q/R+Q8ILFT8dEqILCcGiEI/VUpEK1mcs2Hrbx
 8hSr/1M2O3X03+jI8LVkYqp/kL6/uPOjcjo1i2JdrCUsYZGthviU0rA2/IZxs4Q1EBMlRTwIXd3
 Iagcofz+rkuMwxMiWPCgaQcMap0P+WBi9BZWf8zdPTr1f+3Oeh9JIQDxWXBrjPMtJ4w==
X-Gm-Gg: AfdE7clALleO5oFpBO0r/gCW9gZXFOy6Qg3I8KRW0EDwSh2+X7T/iE7nI6QROWZg829
 D1L7yes/MtWRlQSKO6umfGeSF/Jns4mZDJsXl7bF52GMcN4++B8k0AJMrOFjfrxQ4PdnvRL6ZnA
 HbEtYsTnzpTH7g9dTruQAkTfN/EG49QLGu5SQuKdRhryJfu8JJvVRcMerGz7ca67NiL13B5Ovg4
 uP94PuqVrWXaKn1/3EgCOubE4ktvU0w4x2OleGZ1FYnlPF674f3mWkflhQDUpF2rs2Nznnv2Y4Y
 SGMNqNzTRYB+JiNLvL7rl7At9Lq8fDglNOZHDfv5+b63C4WKUlhaqAGC4m838x8uW3CQ7umk6H/
 tDXZ4reMfzqXTTt+xYfE/gLDjNvbb6Xoym0ChCMCy7IrmHAGMQo3V7eMuD5nrAVK167y0
X-Received: by 2002:a05:620a:372a:b0:915:9125:e652 with SMTP id
 af79cd13be357-92e9a481185mr25490985a.48.1783096911663; 
 Fri, 03 Jul 2026 09:41:51 -0700 (PDT)
X-Received: by 2002:a05:620a:372a:b0:915:9125:e652 with SMTP id
 af79cd13be357-92e9a481185mr25487185a.48.1783096911143; 
 Fri, 03 Jul 2026 09:41:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039bcdasm582623f8f.21.2026.07.03.09.41.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:41:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 31/33] cpu: Introduce cpu_single_stepping() helper
Date: Fri,  3 Jul 2026 18:37:54 +0200
Message-ID: <20260703163757.55500-32-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nEfHu10GUVQ7BypA2CmAIUEsMMsQIVuB
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47e650 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=UzDBcLQVJa3M_3ASbYsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nEfHu10GUVQ7BypA2CmAIUEsMMsQIVuB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXzQhNpmGajA3f
 zdNwrLGOWuWe4Lbpa/9o62Qho+Cc3PScY11R5DB/dE/KkO0TNn5yDBXkU+BvR12ybfytVB/HntL
 t/ypOYFwOsMiaCIPNeecVFMpxTKNEYQBbQsh2Gq51MSbo+5CA+IM5kHQqLaO0TR2GN0wu6fHYLw
 s7aMj7tjwMmpeUl5y0/wOxx0SD+7iAuy/wQxH3Y+pimrDsboTUv8xYo+E7iW4zdvtn8KVmmRQlj
 PmvEtplhwA4+hwFFEOlHuvnzCZzXJ2Cwg98Vbtsw9ZHLFiEvdZLoZ/QQvSzhY4dpTxKzNy6Sp4x
 XcABYaxzxza4jpA88mQPCUpnn1RDBSz5rO4PKh5x/6kOmi9+I10eb5/Mz3aJyt9GgTTEq+dX2bR
 XGAay+RvCWGXZB996jnEOCeH7pfwXUNLXQtphcc4OzG0Cti3z3I3iG9IAtyM0hrbvkIlu75JzcD
 YtvQAmbd6UVvcuikKGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX2g1Hp3GVxydw
 rvmvai6tA6DE1WzJnL36ZJ1c7T4b+58IJASlzmGJFPtHxHxS9giKafUbdlwH0hZuTP21ipVmqqe
 u0kWf3kewIxO+4+IvnkMiie9Of15yds=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Access CPUState::@singlestep_enabled field with a helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h         | 11 +++++++++++
 accel/kvm/kvm-all.c           |  2 +-
 accel/tcg/cpu-exec-common.c   |  2 +-
 accel/tcg/cpu-exec.c          |  8 ++++----
 linux-user/riscv/cpu_loop.c   |  2 +-
 linux-user/s390x/cpu_loop.c   |  2 +-
 system/cpus.c                 |  2 +-
 target/arm/hvf/hvf.c          |  8 ++++----
 target/arm/kvm.c              |  2 +-
 target/i386/kvm/kvm.c         |  2 +-
 target/i386/whpx/whpx-all.c   |  6 +++---
 target/loongarch/kvm/kvm.c    |  2 +-
 target/microblaze/translate.c |  2 +-
 target/ppc/kvm.c              |  2 +-
 target/s390x/kvm/kvm.c        |  2 +-
 15 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 77884b827aa..b8384639141 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1138,6 +1138,17 @@ void qemu_init_vcpu(CPUState *cpu);
  */
 void cpu_single_step(CPUState *cpu, int enabled);
 
+/**
+ * cpu_single_stepping:
+ * @cpu: The vCPU to check
+ *
+ * Returns whether the vCPU has single-stepping enabled.
+ */
+static inline bool cpu_single_stepping(const CPUState *cpu)
+{
+    return cpu->singlestep_enabled;
+}
+
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
                           CPUBreakpoint **breakpoint);
 int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, BreakpointFlags flags);
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index feffca0d82d..963a4edd262 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3812,7 +3812,7 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
 
     data.dbg.control = reinject_trap;
 
-    if (cpu->singlestep_enabled) {
+    if (cpu_single_stepping(cpu)) {
         data.dbg.control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP;
 
         if (cpu->singlestep_enabled & SSTEP_NOIRQ) {
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index e48ea31373f..44e84344f3b 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -47,7 +47,7 @@ uint32_t curr_cflags(CPUState *cpu)
      * For singlestep and -d nochain, suppress goto_tb so that
      * we can log -d cpu,exec after every TB.
      */
-    if (unlikely(cpu->singlestep_enabled)) {
+    if (unlikely(cpu_single_stepping(cpu))) {
         cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR | CF_SINGLE_STEP | 1;
     } else if (qatomic_read(&one_insn_per_tb)) {
         cflags |= CF_NO_GOTO_TB | 1;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d7f91dce9db..0386ac49551 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -308,7 +308,7 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
      * so that one could (gdb) singlestep into the guest kernel's
      * architectural breakpoint handler.
      */
-    if (cpu->singlestep_enabled) {
+    if (cpu_single_stepping(cpu)) {
         return false;
     }
 
@@ -485,7 +485,7 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
      * raise a debug exception.  Single-step with another exception
      * is handled in cpu_handle_exception.
      */
-    if (unlikely(cpu->singlestep_enabled) && cpu->exception_index == -1) {
+    if (unlikely(cpu_single_stepping(cpu)) && cpu->exception_index == -1) {
         cpu->exception_index = EXCP_DEBUG;
         cpu_loop_exit(cpu);
     }
@@ -732,7 +732,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
         bql_unlock();
         cpu->exception_index = -1;
 
-        if (unlikely(cpu->singlestep_enabled)) {
+        if (unlikely(cpu_single_stepping(cpu))) {
             /*
              * After processing the exception, ensure an EXCP_DEBUG is
              * raised when single-stepping so that GDB doesn't miss the
@@ -849,7 +849,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
                  * raised when single-stepping so that GDB doesn't miss the
                  * next instruction.
                  */
-                if (unlikely(cpu->singlestep_enabled)) {
+                if (unlikely(cpu_single_stepping(cpu))) {
                     cpu->exception_index = EXCP_DEBUG;
                     bql_unlock();
                     return true;
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index eecc8d15178..6f27a06da49 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -68,7 +68,7 @@ void cpu_loop(CPURISCVState *env)
             } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gpr[xA0] = ret;
             }
-            if (cs->singlestep_enabled) {
+            if (cpu_single_stepping(cs)) {
                 goto gdbstep;
             }
             break;
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 67d2a803fbc..25f19f725e7 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -87,7 +87,7 @@ void cpu_loop(CPUS390XState *env)
                 env->regs[2] = ret;
             }
 
-            if (unlikely(cs->singlestep_enabled)) {
+            if (unlikely(cpu_single_stepping(cs))) {
                 /*
                  * cpu_tb_exec() did not raise EXCP_DEBUG, because it has seen
                  * that EXCP_SVC was already pending.
diff --git a/system/cpus.c b/system/cpus.c
index b31c825b464..97e5a5edee2 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -344,7 +344,7 @@ bool cpu_can_run(CPUState *cpu)
 void cpu_handle_guest_debug(CPUState *cpu)
 {
     if (replay_running_debug()) {
-        if (!cpu->singlestep_enabled) {
+        if (!cpu_single_stepping(cpu)) {
             /*
              * Report about the breakpoint and
              * make a single step to skip it
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d5b1966a867..640ef665593 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2340,7 +2340,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
     case EC_SOFTWARESTEP: {
         ret = EXCP_DEBUG;
 
-        if (!cpu->singlestep_enabled) {
+        if (!cpu_single_stepping(cpu)) {
             error_report("EC_SOFTWARESTEP but single-stepping not enabled");
         }
         break;
@@ -2549,7 +2549,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         assert_hvf_ok(r);
 
         /* Handle single-stepping over instructions which trigger a VM exit */
-        if (cpu->singlestep_enabled) {
+        if (cpu_single_stepping(cpu)) {
             ret = EXCP_DEBUG;
         }
     }
@@ -2868,7 +2868,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
     CPUARMState *env = &arm_cpu->env;
 
     /* Check whether guest debugging is enabled */
-    cpu->accel->guest_debug_enabled = cpu->singlestep_enabled ||
+    cpu->accel->guest_debug_enabled = cpu_single_stepping(cpu) ||
                                     hvf_sw_breakpoints_active(cpu) ||
                                     hvf_arm_hw_debug_active(cpu);
 
@@ -2882,7 +2882,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
     cpu_synchronize_state(cpu);
 
     /* Enable/disable single-stepping */
-    if (cpu->singlestep_enabled) {
+    if (cpu_single_stepping(cpu)) {
         env->cp15.mdscr_el1 =
             deposit64(env->cp15.mdscr_el1, MDSCR_EL1_SS_SHIFT, 1, 1);
         pstate_write(env, pstate_read(env) | PSTATE_SS);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 01f42f42538..d40a6a98591 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1492,7 +1492,7 @@ static bool kvm_arm_handle_debug(ARMCPU *cpu,
 
     switch (hsr_ec) {
     case EC_SOFTWARESTEP:
-        if (cs->singlestep_enabled) {
+        if (cpu_single_stepping(cs)) {
             return true;
         } else {
             /*
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 372781ae715..aef981f023f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6251,7 +6251,7 @@ static int kvm_handle_debug(X86CPU *cpu,
 
     if (arch_info->exception == EXCP01_DB) {
         if (arch_info->dr6 & DR6_BS) {
-            if (cs->singlestep_enabled) {
+            if (cpu_single_stepping(cs)) {
                 ret = EXCP_DEBUG;
             }
         } else {
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 11b5d1fc607..634d5428219 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2266,7 +2266,7 @@ int whpx_vcpu_run(CPUState *cpu)
             }
         }
 
-        if (exclusive_step_mode != WHPX_STEP_NONE || cpu->singlestep_enabled) {
+        if (exclusive_step_mode != WHPX_STEP_NONE || cpu_single_stepping(cpu)) {
             whpx_vcpu_configure_single_stepping(cpu, true, NULL);
         }
 
@@ -2283,7 +2283,7 @@ int whpx_vcpu_run(CPUState *cpu)
             break;
         }
 
-        if (exclusive_step_mode != WHPX_STEP_NONE || cpu->singlestep_enabled) {
+        if (exclusive_step_mode != WHPX_STEP_NONE || cpu_single_stepping(cpu)) {
             whpx_vcpu_configure_single_stepping(cpu,
                 false,
                 &vcpu->exit_ctx.VpContext.Rflags);
@@ -2648,7 +2648,7 @@ int whpx_vcpu_run(CPUState *cpu)
                 cpu->exception_index = EXCP_DEBUG;
             } else if ((vcpu->exit_ctx.VpException.ExceptionType ==
                         WHvX64ExceptionTypeDebugTrapOrFault) &&
-                       !cpu->singlestep_enabled) {
+                       !cpu_single_stepping(cpu)) {
                 /*
                  * Just finished stepping over a breakpoint, but the
                  * gdb does not expect us to do single-stepping.
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index beda6965f8c..48cdb78a4ca 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1440,7 +1440,7 @@ static bool kvm_loongarch_handle_debug(CPUState *cs, struct kvm_run *run)
     CPULoongArchState *env = &cpu->env;
 
     kvm_cpu_synchronize_state(cs);
-    if (cs->singlestep_enabled) {
+    if (cpu_single_stepping(cs)) {
         return true;
     }
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a93f14d6e09..8b219afb5dd 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1772,7 +1772,7 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
     }
 
     /* Finish DISAS_EXIT_* */
-    if (unlikely(cs->singlestep_enabled)) {
+    if (unlikely(cpu_single_stepping(cs))) {
         gen_raise_exception(dc, EXCP_DEBUG);
     } else {
         tcg_gen_exit_tb(NULL, 0);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 85b15602396..b0c446eea7f 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1617,7 +1617,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
     CPUPPCState *env = &cpu->env;
     struct kvm_debug_exit_arch *arch_info = &run->debug.arch;
 
-    if (cs->singlestep_enabled) {
+    if (cpu_single_stepping(cs)) {
         return kvm_handle_singlestep();
     }
 
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index bb329883c97..70f450c71ab 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1875,7 +1875,7 @@ static int kvm_arch_handle_debug_exit(S390CPU *cpu)
         }
         break;
     case KVM_SINGLESTEP:
-        if (cs->singlestep_enabled) {
+        if (cpu_single_stepping(cs)) {
             ret = EXCP_DEBUG;
         }
         break;
-- 
2.53.0


