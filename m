Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFDEC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjiJ-00075o-Qi; Mon, 06 Jul 2026 09:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjiG-0006z1-OB
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:50:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjiE-0007VJ-Gf
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:50:20 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxNvr395420
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QXJ+iKEc00iZKot2uTOwOulYp2cnZqhisjtrv59DNu4=; b=OxiDGjTlD2gRvmtR
 Z9AY/YxOBx0vkKVAbMdBOlNV3c0b0DbUtN+RcKM1tj55fspYcGvVQ6Y79v7SMBVz
 UqoHfp2/wFe3aCu2Y7Vgv6IuKE8sqBm2aJjhfvUlYRi1XpOo4ldoueYWRBQ/jijf
 xmYt9Erx1EBmaCO4/gRtOWeyb4OPovArWPdn6197Lx0GoTD+yIrc/JPCmGym3+t/
 M7CAvX8YL7ETBURxrHwwbXItbrl133UF52WOfHjcOr5z/RaICP11enfJLnWk1yt/
 0vBaSdKxwsoPk9oA4vuNJ7tCUx3tgF/p7VWgDkWdLFBc1ZLkTrp/BD71TmNx1HXW
 NclqQg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qph0se-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:50:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91931144870so244410585a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345816; x=1783950616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QXJ+iKEc00iZKot2uTOwOulYp2cnZqhisjtrv59DNu4=;
 b=WzB/yaJsckBqtFyXEHKrGZf7IdF7eHap+sPJw54at7M/QRWEnGj3CSJ2SuxwJ+RNbP
 lq3punRsgP11jMtnrWqD0tfahrk/PWJxYndHohW1POOzuQPCTaAnhBtqluhhVSn0kWBW
 IEuW2DaJ8i2kjrGSj6kYi1Z7fnPwaVQ86CyRzX5hywwNffq2AsEJkUwnmb5STSZOsao0
 q1biv88lWUxK3bJGBCIU36bWtwbUBhed3aOP8juWpZNHNxNiePoH9loasTfpzRVznySm
 DkRLKQl8DH0h2IX67+jOPhNxJTnKXlpGIXnaoDhcTc1eDtdLbwGYr+jN9S6WBMIBNbR7
 bN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345816; x=1783950616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QXJ+iKEc00iZKot2uTOwOulYp2cnZqhisjtrv59DNu4=;
 b=lnI0OEQInDUoM5E7Eq7FY8A6BEdOpEK3jliDRJRFedNGGHDnHlCidAPXZbuTnYsz/V
 S1i3mWi+MxkvXU6XK3puXPY/bu0VZoN6hnnUrpWEFYoszF7SzDWbOGKEAzJbvgMQqUad
 gNFeLxWhbomrj+ACRX1Mk9q97FZT1TfUAZ7Vkn9+spX1bmUybuMUnYlQAfNoMrHyeBiJ
 iNujFQ+05S2g+WFxzuuIqi2gGA2Osa0eVwEl/C7YHvG7S1xJgQC5+ChHz3Dt/JrgJxT6
 m/SxBug4X8nz1xYWqCX0QSim971HFZEPzaMHvlF9JQrR3mOYBU3xJ0wb6yeIB3gYC+wG
 v1AQ==
X-Gm-Message-State: AOJu0Yz0fSpMxp7UPoq+rJVRObPgTxfCmfiQmIBMU3u8Y0Fm8MiXvJru
 pMqc6aj8u3+2pFtm0qhXAFSygINCzkOUBLouS7bNWspd0G0TKSWSbTrK9JhA1ZJ5WUzBHM/QQMP
 9Rtw2mWtBI3OEqzZBxz4wBDQ6RPjGYo6tgvgdCdAxqNonyA8fLBdjhZ58b1Bgy1D/FA==
X-Gm-Gg: AfdE7clncfcxlK7wgH7UXfff63D40MEHlySYWDkU8m+kgYjxY3OuXezCM0QDqCbUkQZ
 WjiUTfuUk3WY7T1dWG0Bbe9KJBK+IW11cJfcsDgQFxRu3QXvtofFXM7NDE0fngXkiPl5OVJkDxb
 HQbCQZtQPWuxe56YzvvMg7onRPY6A6qx7NhA3fGV279fm8F0B2f4tB4V0wmX8J/OPIAbmjQTRrV
 KGqC/mm1OqVTyH2A9M0R445sKiXJOICMWFkA1+U98If1rwYKfXPmWYtMGZOXXcy68zjW92YPt9K
 +uJsuJDfV1HlxlsxZO+KX+UE+KrW8HxPNxs9apKNiNGM9ftqkaQXbstEM0JMIQX6PmemNyIH/Dx
 ZRZh9eDpEMIFHa9n2KPr/dy3deWnMeRf4za6MiziEJ9Cn1YT0uM/JquImSA==
X-Received: by 2002:a05:620a:1a0b:b0:92e:7ba3:740d with SMTP id
 af79cd13be357-92ebb5c0dbfmr80255685a.68.1783345815667; 
 Mon, 06 Jul 2026 06:50:15 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0b:b0:92e:7ba3:740d with SMTP id
 af79cd13be357-92ebb5c0dbfmr80247085a.68.1783345814643; 
 Mon, 06 Jul 2026 06:50:14 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d91bsm28880576f8f.4.2026.07.06.06.50.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:50:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/32] cpu: Introduce cpu_single_stepping() helper
Date: Mon,  6 Jul 2026 15:45:25 +0200
Message-ID: <20260706134527.84808-31-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4bb298 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=UzDBcLQVJa3M_3ASbYsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 1A_BGLb9A4diUqUEgKJZ1RG2-2mV7pMZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX9gSlwhG0gbPK
 u9Ba1r1O1DUXhsbClGkfyY43QRLWG8BttuNgA+ro58lYlLMHmthkoC6QmVYOddNt4E9Mrl5qnXQ
 cXKXOuYEODeYTsZzw5MPlQ3Axjio7bAnLbpdvz73HYhRsbLJwVV25j9KZSZd9wtetFTcqn8xcUZ
 7PWt5yBVIQjJm8xNVLyogZG+26tSMRoeJqIIhvb5VO1BF9wkfNWVmelaY8SISp4Ke1o7aNlN6dZ
 Sm90+AFiEPKUhnPbze6a56PLLRKi3Eo0Mg2mgtEk99UlGR3+JMFFNssyAcoQ+6c3XrC5LbbM+6Z
 JxQxh5zxuLLhJZFV9Bpaoc5dBmftlIOq6d+lMYWd3vN+nCTvCkdH+rlRVjfYsk2dnXrG9j7LUTt
 0Q3MUytyMlyXYGlsi35DZavWPIzf9m4o6OUYEUpX7rlxLks+Gn7iZFk1LwZrZeOZLyiZbcXnjyX
 BJFyFQK9k4N0uUHCI6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX9PdkVJ8Ogp5F
 bu/IegclDSJD249BsksWlQtY+fAOLJiuK8TZ2tTgxJ0c/+0gwVbZOBjVbYpO9YmgU9dh6+7CfwW
 OQ7VKKlLHmMRG5EZz1jw0sY1GBrHamM=
X-Proofpoint-GUID: 1A_BGLb9A4diUqUEgKJZ1RG2-2mV7pMZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060141
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-31-philmd@oss.qualcomm.com>
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
index e5b68bced3d..00f6c5d5de7 100644
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
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
                           CPUBreakpoint **breakpoint);
 int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags);
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
index 1e09155e92c..4272b6770c7 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6250,7 +6250,7 @@ static int kvm_handle_debug(X86CPU *cpu,
 
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
index 93ec0cf6a72..19d41c8e91a 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1615,7 +1615,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
     CPUPPCState *env = &cpu->env;
     struct kvm_debug_exit_arch *arch_info = &run->debug.arch;
 
-    if (cs->singlestep_enabled) {
+    if (cpu_single_stepping(cs)) {
         return kvm_handle_singlestep();
     }
 
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 195e39df032..19ddf59e002 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1874,7 +1874,7 @@ static int kvm_arch_handle_debug_exit(S390CPU *cpu)
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


