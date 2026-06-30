Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82841C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegbv-0003zr-4P; Tue, 30 Jun 2026 18:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegZq-00066X-Ou
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:05:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegZo-0004d0-5K
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:05:10 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDmm72937291
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iZDYyBNnEfPj66ZQ9jk/9Zd6IeYUHE+uzrWFiFgMvNs=; b=IHjqzcOB9JF+6iCQ
 KmWAN1iMNJDExweGRzPsWW6FAZDH6dGOS6fxxJKZq/raMjCkgZj4lFNJCL9CZMTC
 BcJ64TzhnLDt78aA0FVhXkYFl6HKRqlrc+lI69D6cZaumVZJbsVKtSc8HXRofdzh
 7CYqEOv8aMTKEjBKr9w5yeQQFQfmNlMQpZGFEvJ89UgyfsR8efFA7isjtuaRRJg/
 S6vWwK+8M3FDvfKABY7wlGbpoDbyavh9KCZnZkKi9WH9GusPemZCQ8n/FirwhDK2
 3f6/qTUu7EIoWLTWSHG4ukcRpWYxxYrO48yOlH/O2LLDyg+IEnjIGuFK3l5Uc7mv
 TBc6vA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4fc0a46a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:04:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92ac0a54110so945923785a.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782857096; x=1783461896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZDYyBNnEfPj66ZQ9jk/9Zd6IeYUHE+uzrWFiFgMvNs=;
 b=b2SaZ8EZWlhR/SRjQO67r5JVvGgheZQjAgotz0bYt5yFxlke4yfbz2gzvMyzw/8/yd
 6h2XaunbaEIFSAcE5ApzFVNNCtifOknzGdeV2j5Tam1I8fHmYiDRyx2ttga81pCz/2/k
 N8fFNQTdmALdaM2Pk8/wRe1hNzeKOaz6JSoWNLdSD2v37YKTe21eUq/pOTpngkNQ/6lL
 xm6+g1cTrmP8ccAyd29PwxgVNkKkClW9Uqb8oY8r1XNJm2FcYHmMjCv0TZVqy1cCcKQh
 9zx9gee2K3oGntagA9avr73Clefh82/2SonNUV9gT53zadQUVTQdnBLpK5Jg/A4L6h93
 TJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782857096; x=1783461896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iZDYyBNnEfPj66ZQ9jk/9Zd6IeYUHE+uzrWFiFgMvNs=;
 b=CrTZ51MkCVwFZl47/2s46tJsV1WouAZcyH6e66SD06nOEM/1lqF8YoevtPNYP0gPjG
 ntm+JXONUfEgPrBCHJhi609qhye9Kmog/ZF6y5pzjpCPjVmkiXEgjDKBT1lPkK9ov2gO
 lN8cf+d7jwXNPLeqKGmYMpLCfvYkkecxRHGnknvyE0Hr0M36P7ty4VFW5/LKWGPhHCrq
 l3eKg99493cfx17A3dlDg2kfufYFe2VNorsOnWYNMfcSc6PmIgQrmcXEPgW17azD8geR
 KDxlYGeo3OWd2jeRoZJyaS8WSpJ8AVtfI6Y/AVwuYPqptxaA2XYG2a88AScX3MxZykHp
 W4ag==
X-Gm-Message-State: AOJu0YzwllujpanOYUQNUvZOzhiQoJaap8P9xdS42xrhyw3iebALGtR1
 +gDm27ABowSxBf2K1B2gF54t3XprcQbEkJYfXo0wYc3VNQGwf9Ka0ZFFIZ+ELzUxCeNMXYlzTLn
 xVSY1Ia7lxgfI10MvNV8XLzN6G39UPM/IcDzlTlcawjpvcclJBhyVC/EYn3mT/uht6g==
X-Gm-Gg: AfdE7cmhrqqYbWNYA8TAVrI7TzJSLhPdW7+saRnCFhPhb58EgggONvobOlfo+mT9W83
 0bMUtvwnveA7k93WQa/zs8d8yC6a4Vcvl9FJpfI8oLZSCZQRLnCmRJXZw6ymfpyvz+RVh+Fq4Ue
 eElp4D/xoS6pJ+2tscBOBS/gTKuQmma9DQmeJOIHJo2nLfwl9TyaOdBE4xMc0g6t4qIRQfF/Vzo
 y8q0y9YfHM4JN7YQnDGOiWvTV31sGq1tU/Nb6pwJG5TCwfx9QVCkKET0D825CyVx0UmyxYMYGot
 0RaTgeBVgx+Hg1Swn/PFlW40pfEBi8MTA0LC3mOrmQz1QggfOS3b1y28zWR084yg1NZ+MPusa5W
 V6QnYm6tDBfALlUHUF1nZehDorJ5GLA4pS1xgkjG8LYujaldzStrTGgkWu9uiA8Fd2q5p
X-Received: by 2002:a05:620a:1b9b:b0:92e:5f90:c0de with SMTP id
 af79cd13be357-92e6d813d7emr391211485a.22.1782857096106; 
 Tue, 30 Jun 2026 15:04:56 -0700 (PDT)
X-Received: by 2002:a05:620a:1b9b:b0:92e:5f90:c0de with SMTP id
 af79cd13be357-92e6d813d7emr391205085a.22.1782857095609; 
 Tue, 30 Jun 2026 15:04:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756636cf65sm12007815f8f.21.2026.06.30.15.04.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:04:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 31/33] cpu: Introduce cpu_single_stepping() helper
Date: Wed,  1 Jul 2026 00:00:58 +0200
Message-ID: <20260630220100.1289-32-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX3tpkTZiUnc0E
 3zPUiCdMcvNBoD8wp/3GfKr1iKUx6d7oieaCr/EvoNrC4DIJb5DDbFpGL8Ehi51H4mY4YlnRREX
 jNRXnb41OLyn6kGcMzSaJriX/mvtv+ttiJu7E922LOU1VPimGkDW2znaq9cZpJQS6aZ7Ojl9yna
 7+2lYMr1FO+f9Z+fFi0No6MroMzpp4sUXuwjb5XW3M/KQOV/aZLrspmaKteorXO9FHhS4ir6elz
 ASCEIiDS3CYbokBndBv6LYjviEgiX3yQLPodxwcha3pa34MlNVOe8S+QYYdybnSJ+DQQlVAmPyg
 yNb3Twm4unxFyV0RdKHxMCcqZrVegDVffPDbnYyMHO8dgqZBTvluzQaBtJCx65TWUzUyIKPzV/3
 /HziUvJNkvQiEbPvWhlLvr99Q7fSYo/8eQFH/odRko/Z1EGRdm9CSulHBe7pruet7fVPngMKROZ
 3gsgLcG+oRsw4dIFcGw==
X-Proofpoint-GUID: 9E5qE9jZA9BekDk7sU9ovK9AYV7YVivn
X-Proofpoint-ORIG-GUID: 9E5qE9jZA9BekDk7sU9ovK9AYV7YVivn
X-Authority-Analysis: v=2.4 cv=Ivkutr/g c=1 sm=1 tr=0 ts=6a443d88 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=UzDBcLQVJa3M_3ASbYsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX9yVihUV8vLyn
 9CK+Lv8DsXSJTddKiv/dpy+akbo1/UMhc3lT9aYfOZ/eW5Gl3xWWcOcEqtPCwzpGfOXWfriNU6Y
 lTZe9nTBf1QjzTOctbdkKWa7WDcpdBQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300215
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Access CPUState::@singlestep_enabled field with a helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
index bea8e509a19..37ac218bda3 100644
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
index e8ed85f9a3d..c436b1f3751 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3817,7 +3817,7 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
 
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
index 49f6daec3cd..2270e58d9cf 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -343,7 +343,7 @@ bool cpu_can_run(CPUState *cpu)
 void cpu_handle_guest_debug(CPUState *cpu)
 {
     if (replay_running_debug()) {
-        if (!cpu->singlestep_enabled) {
+        if (!cpu_single_stepping(cpu)) {
             /*
              * Report about the breakpoint and
              * make a single step to skip it
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 530af305efd..e7550cb3b58 100644
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
index 95705522e04..c87bd1d714d 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2271,7 +2271,7 @@ int whpx_vcpu_run(CPUState *cpu)
             }
         }
 
-        if (exclusive_step_mode != WHPX_STEP_NONE || cpu->singlestep_enabled) {
+        if (exclusive_step_mode != WHPX_STEP_NONE || cpu_single_stepping(cpu)) {
             whpx_vcpu_configure_single_stepping(cpu, true, NULL);
         }
 
@@ -2288,7 +2288,7 @@ int whpx_vcpu_run(CPUState *cpu)
             break;
         }
 
-        if (exclusive_step_mode != WHPX_STEP_NONE || cpu->singlestep_enabled) {
+        if (exclusive_step_mode != WHPX_STEP_NONE || cpu_single_stepping(cpu)) {
             whpx_vcpu_configure_single_stepping(cpu,
                 false,
                 &vcpu->exit_ctx.VpContext.Rflags);
@@ -2653,7 +2653,7 @@ int whpx_vcpu_run(CPUState *cpu)
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


