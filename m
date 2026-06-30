Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D084DC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegc2-0004gS-Mn; Tue, 30 Jun 2026 18:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegZy-0006ol-DG
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:05:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegZv-0004f6-Lw
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:05:17 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDkl82946987
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1WKNytV/XJLd2MaJY50QKZBV9y/Pe7TY0TGhaSb2eWk=; b=nr7b03ImWeiTy6yZ
 8LS25QOtHW038qLgYU3jgU7+YXulTagJAOgANUpAu7/t9eDZMqxHLE2+oHu6cPO2
 baPq4ApsEZAWPl9wLKt2N1WB8XIQO/zT8+1QsrAb3BeIkJUaDQJGHVmcbtX5/N6k
 ek6MakkBMSWD62BOHon5+ryAltR9vREBo2M+6UIGsySGQb3SZnY1vPhASgW3dlQz
 P4WJhOR9frz/BGwx9ujp48eqNeWqp+dr/dhId4GTcjOBh9Q9rY2H+WgMGLk+1skY
 DE91DY3iui4QLdtXLZJTwomeRUlcOxdnnTUpXMafksP8CqBtmT7FoIBqe1z5irQh
 qsIfuA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4avpucxh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:05:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e695a3b28so169610085a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782857104; x=1783461904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WKNytV/XJLd2MaJY50QKZBV9y/Pe7TY0TGhaSb2eWk=;
 b=LgorO74Nb0rqnsd85lCWPCLvet5Rl1mTpInH+m90uHcoduRP+wYu2c+oWZQHub+jnu
 wCUiY9HyXS0YkRWq1edqCaBC8kGSh18zEjEeYHdXpSX1DSGTK7GasXVkkLAhxicww1+i
 JFWgIO25mdd1HHeNgxwP5JKPI7sMou/x4x5lymzokc9wXOIRQj+MP9GtcHKqcYIp5rgY
 8FmhTHmz1G6jMO4i2l55tPj4OIkbd81XCPKtLUbTEFxM53notgB3uxgwQPxsddyB9T78
 OTW6NHqcmXvvAJNuiCuYVvwpRBDcDCVVYKnrzd15jIdyfOn4J5WZyAp3fHNYRT2BzAu2
 bx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782857104; x=1783461904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1WKNytV/XJLd2MaJY50QKZBV9y/Pe7TY0TGhaSb2eWk=;
 b=IErAD5HOxETw2WvBN7mWFlgaKon6EoqzRCGjfBOGlRxRcMi/EiG8PIsdaV5zP1afoQ
 lKo392L1KgVixdAObrPp5WSa7r06KuYUsMvh5EQkYaWqoZ8ZIFTHI5OzprTN9th7L4DO
 dM6XArqZvDTbGtdgcaTd/sqf3SWQSCN/iuNXRoZvlZQ/bbr2hy0NOmebziwGDzqbuR0X
 OVvTzyomg9H6BJpMa2QkYD+in17h08c5a9YxomdgXV2YPFsvo+lkZlXhWA0513DX80j0
 71LaHh+KW3S672miez+nT+ciCjsMFlb2RNlMz2RnL6aA17Xu0THcss9vDBnZ5Kg0/wYQ
 Cu8A==
X-Gm-Message-State: AOJu0Ywkq2eX9uqMxJ1n/ZVvOo4G3kZzwJGFwZ/NDuN9ujG+D5CVqM4z
 +tiEVu2TDLmmNcZWlOeTmd58dZFy3CUq1mUb2pwWy4CAmm/fOtbw4Zsn1Zpfir9P1pVFIzFiyB0
 FjvyXJ0ueQ/uNNP3Fcznwljp/tges+PL6sfpTVmkPDpdv9xcYeN5JWWhevXmZ75GtJQ==
X-Gm-Gg: AfdE7cmi5FUZD5ujZplXOVFDzIhndkpFjJvY0GVmxVTx2clAS6Kf1GAdRrT1kPc6xWA
 uKoNTR7uNYdNCAOSmAwZm3QsWN96bmFcFxLb72TCr+Hp3pDjaxTyEkODPJ1AMlGl8Hv8nPYJsOG
 h93aW4jwQQ+/lH6fla/R08Oisqi7j+P2PkNU/0qHQNhgY13SrYSrmF/XtQwl4P7904cKLtGrK9Q
 nmIOrCcXhLqG1mDHaVirdRWV1oqyCo2BUo1K/eYKWDzn4XZY69FXsTSZY56LZavgrQA+Xm+HGOG
 d/AmSkYm6IYigHskVux7/dlxezrhroKIOhoSg81HhZ2qmzwdPwJgtPce+7/r8x2xhbxXHAs1GPK
 TAHBDBksPTIZ0jAgCoFtVXyOzS8P+KY5EGLoL/qhMyABlBrHTV4Lus1zBOgmNUHMbSb5G
X-Received: by 2002:a05:620a:4587:b0:929:7356:2e51 with SMTP id
 af79cd13be357-92e696e6c05mr507900385a.11.1782857103577; 
 Tue, 30 Jun 2026 15:05:03 -0700 (PDT)
X-Received: by 2002:a05:620a:4587:b0:929:7356:2e51 with SMTP id
 af79cd13be357-92e696e6c05mr507891585a.11.1782857102921; 
 Tue, 30 Jun 2026 15:05:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4d2945sm26265545e9.4.2026.06.30.15.05.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:05:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 32/33] cpu: Rename CPUState @singlestep_enabled ->
 @singlestep_flags
Date: Wed,  1 Jul 2026 00:00:59 +0200
Message-ID: <20260630220100.1289-33-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dn7-o5iU2QDw8ZDD1ZoPuJl_stXc1RuG
X-Authority-Analysis: v=2.4 cv=KqJ9H2WN c=1 sm=1 tr=0 ts=6a443d90 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Psl2LI6oLFdwa_E3teoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfXxpuxVNPo/vDJ
 cHxSr8NZSXLJmVDPxJPA9/XxHi21FpBM4PtAuAutUEqP20Wv/fBsc2fCqkXQt+PXur1xYFQyD8N
 CIMbBbNnBo/P0vJ12qn+3lXAYv+tkGj8tuL2GCz7D2kbblVEahu0VDOHDaIJpZk50JX+KNvnrJU
 jndO8JBym7FhQdynPLpaC7RcZKLOSFE2cn52ay/m09eOyg/9zVQWdaRG5/xQhy73FpFiTRJfUc4
 yN1m4vIVga9qv1uBXlsDV1nWypyaSe1z4DqpyDHPSwSRvRUemcLaGGJhRiZ4eoHRResdE6m4AV3
 O5IMVuZI1qk4w1Vh+VR5gklg/WV3rEaWeXdH066MkZYYP8pduJqFkwuMKLg7TIBU+UCntlfQqbb
 6aLXNpLUpHM5TNoMyOWXLnymbaadjnmYV6jl3rdzDPLgEn6Eg0LmGxUHD+OOM8WRiYkPBEjkpKO
 vWnYzCUwLSajUOgNN2A==
X-Proofpoint-ORIG-GUID: dn7-o5iU2QDw8ZDD1ZoPuJl_stXc1RuG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX4ULZE3h44CTV
 hFN9gEl9Zjgg7+87Zo5vDgqd2HkmhHpfidMABz6sMQrDpkIE8hj6PzNcsmwn8Q16xHf/kmz+D6/
 DzskwENa7H+k2O/K5VU849mQhpxkPvw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
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

CPUState::singlestep_enabled contains multiple flags since
commit 60897d369f1 ("Debugger single step without interrupts").
Rename to avoid mistakes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h        |  8 ++++----
 accel/kvm/kvm-all.c          |  2 +-
 accel/tcg/cpu-exec.c         |  2 +-
 accel/tcg/tcg-accel-ops-rr.c |  2 +-
 cpu-target.c                 |  8 ++++----
 target/arm/hvf/hvf.c         |  2 +-
 target/ppc/translate.c       | 16 ++++++++--------
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 37ac218bda3..27ee0e54327 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -440,7 +440,7 @@ struct qemu_work_item;
  * @stopped: Indicates the CPU has been artificially stopped.
  * @unplug: Indicates a pending CPU unplug request.
  * @crash_occurred: Indicates the OS reported a crash (panic) for this CPU
- * @singlestep_enabled: Flags for single-stepping.
+ * @singlestep_flags: Flags for single-stepping.
  * @icount_extra: Instructions until next timer event.
  * @cpu_ases: Pointer to array of CPUAddressSpaces (which define the
  *            AddressSpaces this CPU has)
@@ -505,7 +505,7 @@ struct CPUState {
     int exclusive_context_count;
     uint32_t cflags_next_tb;
     uint32_t interrupt_request;
-    int singlestep_enabled;
+    int singlestep_flags;
     int64_t icount_budget;
     int64_t icount_extra;
     uint64_t random_seed;
@@ -1136,7 +1136,7 @@ void qemu_init_vcpu(CPUState *cpu);
  *
  * Enables or disables single-stepping for @cpu.
  */
-void cpu_single_step(CPUState *cpu, int enabled);
+void cpu_single_step(CPUState *cpu, int flags);
 
 /**
  * cpu_single_stepping:
@@ -1146,7 +1146,7 @@ void cpu_single_step(CPUState *cpu, int enabled);
  */
 static inline bool cpu_single_stepping(const CPUState *cpu)
 {
-    return cpu->singlestep_enabled;
+    return cpu->singlestep_flags;
 }
 
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c436b1f3751..30aab1cf49e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3820,7 +3820,7 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
     if (cpu_single_stepping(cpu)) {
         data.dbg.control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP;
 
-        if (cpu->singlestep_enabled & SSTEP_NOIRQ) {
+        if (cpu->singlestep_flags & SSTEP_NOIRQ) {
             data.dbg.control |= KVM_GUESTDBG_BLOCKIRQ;
         }
     }
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 0386ac49551..257211235db 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -828,7 +828,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
                 return true;
             }
 
-            if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
+            if (unlikely(cpu->singlestep_flags & SSTEP_NOIRQ)) {
                 /* Mask out external interrupts for this step. */
                 interrupt_request &= ~CPU_INTERRUPT_SSTEP_MASK;
             }
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 5b132d3d5d8..cdaa3e11808 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -274,7 +274,7 @@ static void *rr_cpu_thread_fn(void *arg)
             current_cpu = cpu;
 
             qemu_clock_enable(QEMU_CLOCK_VIRTUAL,
-                              (cpu->singlestep_enabled & SSTEP_NOTIMER) == 0);
+                              (cpu->singlestep_flags & SSTEP_NOTIMER) == 0);
 
             if (cpu_can_run(cpu)) {
                 int r;
diff --git a/cpu-target.c b/cpu-target.c
index 019906b32eb..a504540c939 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -28,12 +28,12 @@
 
 /* enable or disable single step mode. EXCP_DEBUG is returned by the
    CPU loop after each instruction */
-void cpu_single_step(CPUState *cpu, int enabled)
+void cpu_single_step(CPUState *cpu, int flags)
 {
-    if (cpu->singlestep_enabled != enabled) {
+    if (cpu->singlestep_flags != flags) {
         trace_cpu_change_singlestep_flags(cpu->cpu_index,
-                                          cpu->singlestep_enabled, enabled);
-        cpu->singlestep_enabled = enabled;
+                                          cpu->singlestep_flags, flags);
+        cpu->singlestep_flags = flags;
 
 #if !defined(CONFIG_USER_ONLY)
         const AccelOpsClass *ops = cpus_get_accel();
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index e7550cb3b58..3cfa8dd2445 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2603,7 +2603,7 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
     flush_cpu_state(cpu);
 
     do {
-        if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
+        if (!(cpu->singlestep_flags & SSTEP_NOIRQ) &&
             hvf_inject_interrupts(cpu)) {
             return EXCP_INTERRUPT;
         }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3f6d326cef3..06ed2adf105 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -198,7 +198,7 @@ struct DisasContext {
     bool pmu_insn_cnt;
     bool bhrb_enable;
     ppc_spr_t *spr_cb; /* Needed to check rights for mfspr/mtspr */
-    int singlestep_enabled;
+    int singlestep_flags;
     uint32_t flags;
     uint64_t insns_flags;
     uint64_t insns_flags2;
@@ -367,7 +367,7 @@ static void gen_debug_exception(DisasContext *ctx, bool rfi_type)
 #if !defined(CONFIG_USER_ONLY)
     if (ctx->flags & POWERPC_FLAG_DE) {
         target_ulong dbsr = 0;
-        if (ctx->singlestep_enabled & CPU_SINGLE_STEP) {
+        if (ctx->singlestep_flags & CPU_SINGLE_STEP) {
             dbsr = DBCR0_ICMP;
         } else {
             /* Must have been branch */
@@ -3645,7 +3645,7 @@ static void pmu_count_insns(DisasContext *ctx)
 
 static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 {
-    if (unlikely(ctx->singlestep_enabled)) {
+    if (unlikely(ctx->singlestep_flags)) {
         return false;
     }
     return translator_use_goto_tb(&ctx->base, dest);
@@ -3653,7 +3653,7 @@ static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 
 static void gen_lookup_and_goto_ptr(DisasContext *ctx)
 {
-    if (unlikely(ctx->singlestep_enabled)) {
+    if (unlikely(ctx->singlestep_flags)) {
         gen_debug_exception(ctx, false);
     } else {
         /*
@@ -6559,13 +6559,13 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->pmu_insn_cnt = (hflags >> HFLAGS_INSN_CNT) & 1;
     ctx->bhrb_enable = (hflags >> HFLAGS_BHRB_ENABLE) & 1;
 
-    ctx->singlestep_enabled = 0;
+    ctx->singlestep_flags = 0;
     if ((hflags >> HFLAGS_SE) & 1) {
-        ctx->singlestep_enabled |= CPU_SINGLE_STEP;
+        ctx->singlestep_flags |= CPU_SINGLE_STEP;
         ctx->base.max_insns = 1;
     }
     if ((hflags >> HFLAGS_BE) & 1) {
-        ctx->singlestep_enabled |= CPU_BRANCH_STEP;
+        ctx->singlestep_flags |= CPU_BRANCH_STEP;
     }
 }
 
@@ -6641,7 +6641,7 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     }
 
     /* Honor single stepping. */
-    if (unlikely(ctx->singlestep_enabled & CPU_SINGLE_STEP)) {
+    if (unlikely(ctx->singlestep_flags & CPU_SINGLE_STEP)) {
         bool rfi_type = false;
 
         switch (is_jmp) {
-- 
2.53.0


