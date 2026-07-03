Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C875C44501
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgxz-0006Kp-VA; Fri, 03 Jul 2026 12:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgxw-0006It-Ry
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:42:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgxu-0001wH-Mu
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:42:12 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIZFL489304
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qw4cCSv0OfNGNoPPLFfy1LxGtAqB0K1HAPyDpQ8GAco=; b=dXqT2CTiU8EETd2O
 QkkeAAJ67NritPQ9nJvjVWYGw7EKqz0oPh14oEWoD2J+wYfQuAORQWjL8ypZHNgv
 ssvy1QJFAidv3WZv4JEWF5YCDmbC4d2TIdy0qk0y8+GxQCzdNc+0S63TD4+gSecZ
 jcSBt1D2PQ9zfORlYlKpRLzA0nank3SqcdEKFVMPGoNns2MYnobMDAGzOH5qtIwQ
 P3GaQi4YaAD6fKBK7b/ie18EN2VNfz3nTztoFiGKgCfgUmk7+gV6P0RArNJz7pdv
 LyCmg/NoBAAaIya9UNs4sEh/waS9NnWQimB1pXuhaDBbCxAe1HQbMrn3pAh7Vv9f
 3jbeJQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj101s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:41:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92158791d14so64952785a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096919; x=1783701719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qw4cCSv0OfNGNoPPLFfy1LxGtAqB0K1HAPyDpQ8GAco=;
 b=MVzxHNshWS5je7xzk68JdpNDXCj4L+tUT5zqWVI7B+rVrKop1v3GllScnpKFci48Li
 HWRD8L+JfX+Miwev+CYQrsWqoqSmbSsivp/+ALi8lK7+q5BIGQBOKyKvIhmisVyCBZEH
 afbxGfr64D5HvMlOnmqHseCLao9zleu6hr4pxzE/12mswmdieyxZ+CFn4K4Ekye0fRrS
 Sxmp/Dioe2SfScLvP4WKWj/5eDxtMkIojQrXTYT7TksxIsGE4gXbgo8ftZxW2ddTpZ1b
 TxhbzQYK8IOqdppg0iVxrr/4C2PQOViFhMX2UIO9XBEQGEP+nVOzXDlzKtD2Sch8bkXT
 DUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096919; x=1783701719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qw4cCSv0OfNGNoPPLFfy1LxGtAqB0K1HAPyDpQ8GAco=;
 b=gcdBKHD9zn2LTflvTR6WLTnEbAdx6UHX3JBpNqxroy7cLvm7XmP6yGUAlpDAEEhBOe
 N2JHNof/cPbI2cdh5Cnu87V9NILGscPkxLG/xGAmFz5c3DFNEEscKXfGWQ8LkgHeNFQs
 G5VujDsTcx4LZgiDUOq+XvrRcfSIB/veg62lGw6/lVirTO7pLOYzDr8JAHDuf+/38P20
 Bl2FyYrghxMjMWPd/VzkNCvbZI4BbbBi7dTC4FRygMmPN4ziuL7eqopeykFAQ06ejX3B
 VV3Fj58M4SrJ+RqQ4P73qN4wdlJIhLm2yQnxdYKUDDAtkFOvATIBUuRA1piL1gDtppZ8
 NxXQ==
X-Gm-Message-State: AOJu0YzXSxAF41KqO40sqyXJ4XSK8GLRnZa+ZA+TUO0HIn9bJxtjJIWs
 em58P6tMa0mzJvRq0cLVUULfYHp3CBp6ZD3ocFHh1gbyZlsy6BsDXZeJaDQFx7Ju7WOOcPmEjIC
 B/4KwPcoeqI4zSHsCMY4vNt2qLX+Ttx9wnIjDlYXFwZDaTGb1y2mJaF7bPmg85VXPhw==
X-Gm-Gg: AfdE7cnSXr6ac7VD9bUUoMBDKEEK31IcFYZOGvdZERfRTB0lQKAwpltuDA2uuH+cUwX
 E3mRxpzeWKcJR64lN5udNYr/f84vish5dS5QtfGz3DCC8b5ob2sAD7xgh7i49AHir19I39Ar4lh
 DcFrCdRCV1aMNn0gLL95CjomuxYMxqgNRbMo2GHJD+izCPoMBOOt+Ytn/8cUNCNjYDJIxAQNXET
 SeqdSfqbyyJyYKRA8F29iPq3jc/sO1VUw4iqVkDg2PusO8XTeJrR6dPXwHaJhrI4fzacs7yNXiB
 +f4EitBDOYaTFgl3XQICH9QYhjX4osxLW5b1cKD3yGw/s8/qg64DxCTy8QpOfdJYwC/mLpnqzMV
 6iowJzMtoAcxEdgZGIo/VyglbgQpbzWy+Z4py/kHBIQFtsRYiCcTkrzXpsRWBcL8T7xOo
X-Received: by 2002:a05:620a:6847:b0:92b:67e6:8acc with SMTP id
 af79cd13be357-92e9a535a8bmr20662085a.70.1783096918949; 
 Fri, 03 Jul 2026 09:41:58 -0700 (PDT)
X-Received: by 2002:a05:620a:6847:b0:92b:67e6:8acc with SMTP id
 af79cd13be357-92e9a535a8bmr20658485a.70.1783096918412; 
 Fri, 03 Jul 2026 09:41:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9b4d850dsm764306f8f.0.2026.07.03.09.41.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:41:57 -0700 (PDT)
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
Subject: [PATCH v2 32/33] cpu: Rename CPUState @singlestep_enabled ->
 @singlestep_flags
Date: Fri,  3 Jul 2026 18:37:55 +0200
Message-ID: <20260703163757.55500-33-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXyZ5rk4IJNvFz
 6febD/tFwSqdLcN/V1e4qnvHNoYQGCVbLs699LJHL1nHw+Lxj3Yd7dsvtuQMW+5DLff4565+mJD
 Tsxo3JIWqb0w4to5BY0ds+N0j2Uurcs=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a47e657 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Psl2LI6oLFdwa_E3teoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Mgz6nrBEtkMhRpMQ2E9PH-kKgzaT8AyM
X-Proofpoint-GUID: Mgz6nrBEtkMhRpMQ2E9PH-kKgzaT8AyM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX+6vteSt3TgTl
 aZEcQq2q0EuyWABy9jratvroiI1SN23GfVyTHcclgcSVmjSbHA/66MQVk+OxsfI5iV3AeBYLv4x
 VMDoTXZ5iLsvyKuJh+Vu0A0dFkQScYrlLUqDiBgVfVUlU+kQYdsSK3HXsDZpZDdcpNm9dVNr+Gv
 TGfD1LEu4iVLhuSesxfIXSauGWdON8UrZsGxg2BK1OJNLlS6hLtf1DYp74weNw/Yq20eNtYimOA
 eFg699nrSCldRXLSMtiC8+pZ7G1VuUFRgGNcjXEbdOSb3BiVKR46mFTmqENU6J4yk0gPK2cDMMI
 zPoAh5akc/o0QSaFsgCJYv9tgZOJXMdTSrz9ziB6XJngKrs80wNj2zxqUsF+w1bRn0N2m9wv5Ma
 6pQo+QeDUIsP/Fy3kKj+u04mj4ClEa4ViA+vBIn6KF60cVNduXIvRvfi05qfx76Zo3xsTBzxi8B
 Y6shDSNXB9NP03zpR3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
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
index b8384639141..31f1d787352 100644
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


