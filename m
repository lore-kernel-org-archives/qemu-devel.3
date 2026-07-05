Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A7FC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUuV-0004Lk-34; Sun, 05 Jul 2026 18:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUuB-00047X-TV
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:01:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUu8-00019a-Uo
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:01:39 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LxUc92684051
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 22:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0pnJFY92vkiBpIgSkxERSxVszNDdJxKv8ZacUkDM7sM=; b=laFuuHw5RoLrjD6b
 BpGt0kM6800hfz2aMBJ8wbS7kaW54jwZIauIx77ZZlIF10gOOhAchHyh7WZ0w0dP
 +BYtAOQQy8SM34G/3GRWsnR8kDA6soL4mv2GBO6KvB8gcvrWX2O1oZM8fABCCmRN
 CzBd14zGK83Vfbchbp6UQVjexnovmAOPmObk7M6zp47ybDplLvS3IaK+r5KvBSi3
 zgi0Jckd+YaUPHfgBlY/J5sz5mz2IOSSPOPo6Gy2Q2mlrdYESzSPj3z4myf4E+s9
 cEuWWXdnlrK6pSx2WWnImIB7zilC4VfV0wXPOSjPEo84f4XABL3fBOEmZ8+WtVNH
 c96H2A==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6tj8kfmt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 22:01:25 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5ab036818efso615960e0c.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288885; x=1783893685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0pnJFY92vkiBpIgSkxERSxVszNDdJxKv8ZacUkDM7sM=;
 b=BBdMk0HwCpnijy2BILJIS3bkpQzBFzErXLLiO6wRdJn3vIh9mGwuAYGtjXWQcY94qE
 lZ3LtbeZOR+EW2G9HNRvVHdnQFhjAZ8AfRw5cwfFQa0mqU4Lp0851SF4dqmtqsY4kM81
 YfskUT5U/TWHMLDo7dJJK0gFC4/OML1pcilFMW1QOKsP+vh5XTwypVXbJ916yKgpfoa2
 k4LBCZxPMebPOmGdgZb+U/IrCfbcixKU6jDRWVIiqBGD9POnYBMiStT2mUcZkEErJxbK
 GOcm54EI0J3pXZhj1S/sdZbFhXdB2XqWEGOJ4ztj4nREZYpIF6mWOw9RGzGxV8gCcbIO
 Z1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288885; x=1783893685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0pnJFY92vkiBpIgSkxERSxVszNDdJxKv8ZacUkDM7sM=;
 b=CX8DVcU1plgioUPTrAsLRoXU4pf8S5QaEHb47iOmRv6IZxUWmOVnF9BTuMXSHG3WuR
 kf2ig9FC6RYSiCQ2kEQyg8zaodqA2nduauaOmmhe1JCQKH+dj7lbMdmDvNF+LR1gD2KZ
 RVFcSK+/kU3LPoY0cYZ8Ui1/+DShKlDCPasbZVTjJkdhRTHW7JN+v6hvTXi+cOYfgXJW
 yLti6IYm41rdYH+tbWSjjgTBde/uBWRteEJuqmqWrMmeQZ2uGLKMu/QYzcsZu5znV6SM
 i/QthXdpZ7a1Dqo2DpWuAko3gcuhgbP8uSjB7NSjuhlcxPp7oUYLO9Y2kzBu27vVjuO5
 JZPA==
X-Gm-Message-State: AOJu0YzYLGzxwPJBD42qPubBO3FJXvZR53vImXSA4b3h68Xex38kV4I5
 OT5F6GUBDju5HDSwU0+TQPEsD0GpStrIDhT/G3FvALlKJXbsNeye5qsdFM3ytQ/D1t2QamhRisU
 lT1uL9scZlfnuJoMWUDHP4KZ9yAfr98el7Vtqb4cI2OqNvgT34y5x8mkz1v7HTyEd5Q==
X-Gm-Gg: AfdE7ckcdyY9VqUkNlLep5ZwpXQx47TLOnv/7SguLqkeqJxXB9HfMZtmh3UyywCO/kA
 Nd5nDRMr3221/WqqeYAN8VFB4mAnzQVu4ulJA6si4ANUrCc7UmtJfHVViHf1s8O4oSy/pdKUcqc
 sa1SxYh6NcJXiR+cWHbcEi3AoQ/NcAjCZ7wv+GdUZqhhoMbHAKj73jos8/C7AHRwcczL5Zs3wJy
 mxAnopHDCwD1c33UPbIFz85sFPrmjEvGUjaaEPVAQ7CoG0R2IHqXU0NBFUoX+LmaJm2sDToA7Am
 FgcM8VpkeZVegAIZHwG0sKWIwRbTcho4QJmzHVMwPQ6xa4wBv7brb1Bj1sdL/h/u7vwyTmAcwAG
 ltrl0txJgkBlaAMulnMIOVP7DRjXDCstWUxebQQdhzuzCrhG/RGqmQmff1ecz2kIP7Nk/
X-Received: by 2002:a05:6123:2e2:b0:5bd:9d5f:d568 with SMTP id
 71dfb90a1353d-5be1035a483mr2226045e0c.13.1783288884555; 
 Sun, 05 Jul 2026 15:01:24 -0700 (PDT)
X-Received: by 2002:a05:6123:2e2:b0:5bd:9d5f:d568 with SMTP id
 71dfb90a1353d-5be1035a483mr2225949e0c.13.1783288883804; 
 Sun, 05 Jul 2026 15:01:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccd9d607sm294448175e9.2.2026.07.05.15.01.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 15:01:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 30/32] cpu: Introduce cpu_single_stepping() helper
Date: Sun,  5 Jul 2026 23:57:26 +0200
Message-ID: <20260705215729.62196-31-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX6qduQXzb8RgV
 yUA19Ucc/dXdYbHGTAzLfrAMeTUxcRC2vUuIfuE6avGNf/1D6OUbVwJNC+OZ9NpXpBNWuSiqsDU
 BeOQ96aha53hmaiPelV34RP1QdhiLd0Te3lQeQKRNFUs1HkyIEYPVZrB9eWcncYg8cx7VghlC6J
 PUJZTT/wmBP5R61xpstHTfr/43YH4QfaGaabFukJBWp8/bcKhtNCzEnQOJ30w68IvA1o02YuY4R
 rG/J6N7IDwjAylTPyyc5yf9Tnd/MHm8JUwUXbxwoxO70IPmkaUz7XgcLrdfkKbTRG9a0XhE2sSN
 Q1Ojiu3n4PUMDQjBuS7aeV5RNU3A53Yl/xLEo1XRwkST71MWpPHRsEuqImAZOGAZuc4fD5uuGLE
 WCWzen34pdUJxIUU5WkbTE/LDoQVJeURP8oLdW3hJ3eNb4ciP7EEGmjdNs+zHt7z6Lq5bf+cPjT
 MB+usEL7hXerZqCSdtA==
X-Proofpoint-ORIG-GUID: O7VqmvKoZS56SN9WBHTbWvGjrtazq-CN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX/fWPyBhqLu8b
 enGrS1XggK/05BIVMokxN23m2Msz5YUfTrXVG/p2OqbbraY089i3TUvTAtSCiQAX1UvouJauqFu
 AqjzDcBA+NILXuNl/fi8K5zOcVivpdo=
X-Proofpoint-GUID: O7VqmvKoZS56SN9WBHTbWvGjrtazq-CN
X-Authority-Analysis: v=2.4 cv=H6TrBeYi c=1 sm=1 tr=0 ts=6a4ad435 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=UzDBcLQVJa3M_3ASbYsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050238
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
index e70cd8239fb..e53e90ddc76 100644
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
index 6bdfbbd68d6..860fb101e50 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1616,7 +1616,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
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


