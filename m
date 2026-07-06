Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED35C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjid-0007Dx-Rn; Mon, 06 Jul 2026 09:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjiR-0007Bc-28
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:50:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjiO-0007Vo-HW
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:50:30 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxCMw238115
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n18gPC503RK0pfaPq6yq6U0ElgmpWQclc/luG/elbEs=; b=HkLV8azwOC+j7oMK
 XLimiNaKYjQqhxRFaWocVqrf5DtdDD7v0VHW5uC5Vm0j+tbVHhHDx9WD31eMIS9Y
 yL4FWUCF1+zBiaqha58oeu3UVUwEHvwnq8hz2WR17oY6wWfqaB9JJcoDmIBnWJtH
 ugXYcLvqrE+zpVuCkgSbOLq5TDeHLNi879G0tuvzmwp+BZM6vnwiVZ/EyMkpnGY0
 s7T/gO3qWgov2fQIdDea6/0N/jNs/7p0Cy9kMSeA4Lx9WKtiAM2+keFWeNMKMpK1
 OIPCd0PuPXBr9SR65nJKwwVw6Rh0tKQrUqGOan/xKUSHuKYRAclmdCavxFyrUIBI
 evzUMg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t8991n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:50:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e55721a8cso312799485a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345826; x=1783950626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n18gPC503RK0pfaPq6yq6U0ElgmpWQclc/luG/elbEs=;
 b=V9D8QDt9yZpH+fRqxfYzutZkYNG6w1R2ZqMFzuZpO86/kAdorqu2vKn8YRh2iqUEcu
 xjELe4mFEtAoQQBqwQJjdX3jDwO5nHERW3SFbS86ELj2qA88Idv5LZwQjzS5egZWFM7i
 VhjK5momwdr68T++mzBRs5O39JsVdCgFDHLP2n7yfEdDoN/+thKLJxLGb7rO8D1ls8ZZ
 eVM43t2JyXByLV3ysx8uHbQe0zpFrNq2iLpoYnm1fUp6s2vh7jCkOYbTZ/22dme3YMtj
 9XXVE3s26/WnqhCYTgORhB6JM9iEHFFG9ZRuGBRJWfV+CgI17xmQT95DDW/ECQj30n/C
 sxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345826; x=1783950626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n18gPC503RK0pfaPq6yq6U0ElgmpWQclc/luG/elbEs=;
 b=neuIl4WzdjI6uITk01MwINF84agI7OWM2xvVZny3DPQAE8VoPM2Y+GC8A4N4IQTwvJ
 TNN0Zr0GzAVDXQ1CP22+C4Hq9485HJYie6Ab1qt4noVrWvzinlV5R9tK5oKP5TORyB1H
 Z9D/QjA3OZxFauA8X4LytI7FF0LCRK/NtLNUVR2MdAsMpSsfsWhLath9/y2upzVlEAq1
 CN5wlLgXwNkDO8h0pzUWt9Vqbq/WoiFP1m8F3X7STJ77NTMksI+Lp35DMdpg+OXW7ZkA
 uTUaHL1G36491o+bd+L/bIpB2CZX4aAdzJyNaEObmEM+rtWwfNXT6aHlMnK2JPPspNMW
 wwJg==
X-Gm-Message-State: AOJu0Yw6NhjNDJY+PACji+pvHGo3+oN01ypZxQ0YZM1QkeisawN+cLA9
 XLiieMKGwBhnP0bqHepLyyDF2NST2l8bmz7E2ZSOqJJ6FtvJ/SXFz8ob8UCr7z2Cii0ZkqLSJwm
 m2VbvGwdyITUFahXjRe5idqui+lJT2sSWmIX4tTuL0tkRzVakWwIGUB3x9zC04AhUjA==
X-Gm-Gg: AfdE7cnsX/gDDgHqMWbbmN/H7p0ohfQY7QokOuzfsYtCbi/+tJCXa9D8I1FB4Z43+V7
 HN9Ed5Q3gR3V3HtX9EfiGuOiicHLWto6PGHvWhi7XqoZ9L3qLl6hnAPxh3niss7bka80IHuRc5x
 oxUBabZFIWJoX6Od9iySUg5EcMJFDY+cW2wlPzKoPx7pyd2cb1legHI5tkNyb4baA05rKlZ19o/
 1AEAmXzVq5Xx4rh3hoi5xf83TvPS9BHoOPja72u8oH/c0dcg4gLfSuhXb+/h+MTkLHgV0YiJyqU
 FIPsrXp9KU04SqLKd8rG8v5YEGSSi6oAmBp/R5pyTy35S4lx+SQPoftsPHTuGqi99UIqBDC/X3p
 mmbuvljbLednb4zAiaao2F1yss2s5Jx8bfIjJPtO0Vzx0xxU4rejFnoMemA==
X-Received: by 2002:a05:620a:31aa:b0:915:40ff:4e10 with SMTP id
 af79cd13be357-92ebb4bf0a6mr94489985a.4.1783345826184; 
 Mon, 06 Jul 2026 06:50:26 -0700 (PDT)
X-Received: by 2002:a05:620a:31aa:b0:915:40ff:4e10 with SMTP id
 af79cd13be357-92ebb4bf0a6mr94485385a.4.1783345825547; 
 Mon, 06 Jul 2026 06:50:25 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef17c82sm289049935e9.1.2026.07.06.06.50.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:50:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/32] cpu: Rename CPUState @singlestep_enabled ->
 @singlestep_flags
Date: Mon,  6 Jul 2026 15:45:26 +0200
Message-ID: <20260706134527.84808-32-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX3ED1tcv9Apd5
 2uhDEqPiAlB+Xbmwa84Waqb22TL2+8jmGFFQsNfqLxOh4dgozlPtK5ZFYOxo4G2OkXCF55IrZ20
 wIjCzJsEy+79jKPQjnO1h3IQo25B1Sk=
X-Proofpoint-GUID: sceULXLdYPXelG8MK82muVrrbirzPUEL
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4bb2a3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Psl2LI6oLFdwa_E3teoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: sceULXLdYPXelG8MK82muVrrbirzPUEL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX59SCo/E4EKVn
 xSp/35M1CGJ/jwcFHzuk3uZsU0No/GZowfp9sWMOOQPpSrJ0wsANcEk12a/lgUZ6qIsXohGNWQm
 9nzP5R8ZW0zXAlaxcpcMIObdWoFdJEFr9m8IfV1apK5VI0fX2DsnfmQXIJptbfiuhzISzAq7kCE
 4yzICF4uNn8yzLD8gxqQK1FSca2LCmMknQt7K9nj2GXgz5B1v9KdCaunvdlJkxuiEbYwjH6mH2c
 BjyU03qO0HZGmzR7r2Govmh5oFeegbUdyeaIiUnS+NEwoo+ooHvPSaDYK/N9DnGqvPyQq774jp+
 tCYFSxvvLNg9YsjvcgQRoqwuY3GJp4GDtX81JOYXzJzqe4QSToYNsw3Hase8f/zOTy0KsOhk/s0
 13o0HOD8Blgk2HwUcpJwkthwJrs4EGj7ptStXYqMb/vJXJGPIYZU95iCeSes5FXTr6gkqIHeuG2
 weAYL9P7KnLDyTyUJVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060141
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

CPUState::singlestep_enabled contains multiple flags since
commit 60897d369f1 ("Debugger single step without interrupts").
Use an unsigned type and rename the field to avoid mistakes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-32-philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h        | 10 +++++-----
 accel/kvm/kvm-all.c          |  2 +-
 accel/tcg/cpu-exec.c         |  2 +-
 accel/tcg/tcg-accel-ops-rr.c |  2 +-
 cpu-target.c                 |  8 ++++----
 target/arm/hvf/hvf.c         |  2 +-
 target/ppc/translate.c       | 16 ++++++++--------
 7 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 00f6c5d5de7..db4865bd63d 100644
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
+    unsigned singlestep_flags;
     int64_t icount_budget;
     int64_t icount_extra;
     uint64_t random_seed;
@@ -1132,11 +1132,11 @@ void qemu_init_vcpu(CPUState *cpu);
 /**
  * cpu_single_step:
  * @cpu: CPU to the flags for.
- * @enabled: Flags to enable.
+ * @flags: Flags to enable.
  *
  * Enables or disables single-stepping for @cpu.
  */
-void cpu_single_step(CPUState *cpu, int enabled);
+void cpu_single_step(CPUState *cpu, unsigned flags);
 
 /**
  * cpu_single_stepping:
@@ -1146,7 +1146,7 @@ void cpu_single_step(CPUState *cpu, int enabled);
  */
 static inline bool cpu_single_stepping(const CPUState *cpu)
 {
-    return cpu->singlestep_enabled;
+    return cpu->singlestep_flags;
 }
 
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 963a4edd262..83cbd120a84 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3815,7 +3815,7 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
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
index 019906b32eb..4783845c9bf 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -28,12 +28,12 @@
 
 /* enable or disable single step mode. EXCP_DEBUG is returned by the
    CPU loop after each instruction */
-void cpu_single_step(CPUState *cpu, int enabled)
+void cpu_single_step(CPUState *cpu, unsigned flags)
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
index 640ef665593..f5dd7e8e029 100644
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


