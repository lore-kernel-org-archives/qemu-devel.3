Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA92C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUuf-0004xd-PK; Sun, 05 Jul 2026 18:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUuK-0004E1-3n
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:01:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUuG-0001C1-OV
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:01:47 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LxKTR2868130
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 22:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A98+kNoKiQmJ3J78jzxhhEi7R/pYLCHQmvT66NHP/Xc=; b=W5jYPr5EoSIWDMGP
 VKXUsD3ZdF0mw2zrusgXXQRl4UCvw56xLoOO/sjcwzvZbB9kuTC9NW1fUuvdnn3n
 yC3fT5EQpE+yE1/GCa+95K2V005WmDxJcNTT1vlYh8+FCTX/Fvg7s1X0cHxe/TGB
 Ycw/dxlH4+mSdXuxkA5JWalUVn/yQ8yrgxxn3bJOPED6+AfLHAPnTMt/PLfp58BX
 hwlsP1fgDWzfl02k+c9FZUjzbYWCXCKS8XbhW47jLKt452GsZoxY/f6LxH7cPS1W
 Cjrm8wRGJdwqXDmlogKGOOpyA/KG5f1iCKSKRtuhmoHxvg9g33uueRA60qcI5Q2A
 SZlPdw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4sumbp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 22:01:33 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5a83b662fb8so3654756e0c.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288892; x=1783893692; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A98+kNoKiQmJ3J78jzxhhEi7R/pYLCHQmvT66NHP/Xc=;
 b=Te3X5JBFEniDpqI9/zcN/j18YHQ8FmNbUg7YIRexQGgvT0lJ9VDyOLjT4tv5R3x0KN
 /FJ6678CbaXE5Xh7XLh5d3uGmASmHF9EXNsbDWAluIVi6yFfy1zIcbkVIxLyr7ywIiTl
 TBRXF9/89c0/HI4RGieX33vD/0yLm7zeZXaB2IleR/I6VAB0Hl3We+/ORuCRA21a+OV4
 M76OhSiCWtYJH5tmaA44YJgFTUvHLNdhdmSUMPdnX9oH5SwaE/BjoFIVps3hE+wUERfo
 ddyrUIh625nf4kdd9u1Zu/8y9R2oSigy7zEx5vzcmbMLEgrbSyCIma0zCYQ/erFGwO0V
 0Yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288892; x=1783893692;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A98+kNoKiQmJ3J78jzxhhEi7R/pYLCHQmvT66NHP/Xc=;
 b=l2LlsJ+dcPXiqTyRs3iMv4vLXAi/05uYXpW6gj7YZd98PtQGiHTv1/fsMN7547Dj6c
 1uXp4+Q9LKk2E0F/sHoeD3Gu7WYcfPciF7gfIjYxRQN4QyT2f1z0IXMrSJ6sOFW9tsz0
 /d62QHkEkzumunvRRU+lMxiQ1lwG/2hjZcnsMt5wz/Gf5rEcC/0Vv3kr/rj++icOq0s1
 7VAzD2mKA7/Dk5hGDGBjpPuwkmUs90UFsw3COgDA9L1qkbfDpcM4uQgxEvTLPKSGDHUq
 /GKa7BbTwt7CNZanrRd5cGwi/ejetkxyJaQKgaZko8cKDCYLYKvWTPkpLQCz0hphPeqe
 pYYg==
X-Gm-Message-State: AOJu0YyCGkOU64vy/uMKBTUSlJ08pFCUMKj6tfXzYxw2fCnTcxhLQiAQ
 Z3YQ4W88+70tDRSZ/iDbrJRgS4GVUm57vknZXm8KTz8WQZLBuxLg+8uaba4ywYnoRUJT4xkQtZU
 UfzJQqxkZ+ZCRowi8y4i2YWK8z9qUUGXAk0FK0ec8leHbVw3flotDhJDv/wW8al/VYQ==
X-Gm-Gg: AfdE7cmnO10/qbUE+L0i7/ai8WqRwXWHCpSng024LStPzTeIeydWzQ1aE6cEZqcl6m0
 LNi9VohLBU3NmLioKW/PAw9B2r9BCyFlTJm+AyT6UjYz4D0da/f4geAt+4VEIcqB9MDZg7mSBlQ
 LRfvm8gCoNbw/vFqX6+6vfDuLpyAeDTca3LubIcNjEsU2it7HTg8V7usDEs6tSmPjadqTC6Dda9
 h8d04CFoa8y184HTx7V4NEXjoD/y3KFBnTaI8llYd5ZeDhhpgrjZjwnwkz8ecJqo7p5+Fzw1Fex
 KLy7uklbPgu2mKE3lOncJ6E8De5TlEbhGRh4s/3uc33LoGQVFVOd7/l1h5QUlY4qwhE4tL+iMQW
 0cTG1pp4cdvnnc/ASYxdRnLBSZkvsw+C/c5jdjQ0HOHYVlJc7Q60KnHEWSaQE/9VxS7cI
X-Received: by 2002:a05:6122:8291:b0:5bd:bcb1:453b with SMTP id
 71dfb90a1353d-5be102a3204mr2978120e0c.10.1783288892067; 
 Sun, 05 Jul 2026 15:01:32 -0700 (PDT)
X-Received: by 2002:a05:6122:8291:b0:5bd:bcb1:453b with SMTP id
 71dfb90a1353d-5be102a3204mr2978034e0c.10.1783288891395; 
 Sun, 05 Jul 2026 15:01:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm19507548f8f.37.2026.07.05.15.01.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 15:01:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 31/32] cpu: Rename CPUState @singlestep_enabled ->
 @singlestep_flags
Date: Sun,  5 Jul 2026 23:57:27 +0200
Message-ID: <20260705215729.62196-32-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfXxz9phlI+t0oD
 uhF4diS3pid1eEaZ0V64xPZnyx0uJnTP2exKP8rc32zDl30SzKOPNfSW6kMvmW87Ct8X9ChF3Sz
 kgZjDOBTTyRci6UpbRwN5MxkvbJbSPk=
X-Proofpoint-ORIG-GUID: g8BWLjFHsrRSuMcxFj1zO2kMzcFPk_Ki
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfXwDWi4cnH7dav
 ZttHF24ZnFI36TR8B06HOZOw9LxHlbkUmrBE8tEiqZKKTBUH+ld8W9DBvy00N71S8X9X190Dq4z
 /nHwT8e6/mkQM9l4wZAlolwJ33NWszAQC4KyY289n6/OZtYGNthzCY4ihFgzzqZimH6pl7ttEm1
 /NefRB9icb/i7Lrj1bLH0YllSnd2IR7qEkOh7/xqomApfoBQwMwDMoouBTG47y4fvHWO2QW2OHr
 ygC4YUr7m0sLz9yN9tM8SxwJfi4ZZYJXr2VBzsOkHqWujk76vMmE99CphXyQiXop8F/G1il+MzV
 1Yy9oTHCXmFwEaVKNipV5GT3cQZP16ai1dCOwmGGhC355WqkRe8BjUZTPSd6+23jduAeeshBZ/y
 EQ8rn5V2t5mrr1xg0dEecb0byv3GAcTrRMumOwmjRruJnngD+4WwTFoBN6ydogSUR6krZr6afJb
 yniXha6U6K+gbths5sg==
X-Proofpoint-GUID: g8BWLjFHsrRSuMcxFj1zO2kMzcFPk_Ki
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4ad43d cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Psl2LI6oLFdwa_E3teoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=XD7yVLdPMpWraOa8Un9W:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050238
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Use an unsigned type and rename the field to avoid mistakes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index e53e90ddc76..a841dd4dd96 100644
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
 
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
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


