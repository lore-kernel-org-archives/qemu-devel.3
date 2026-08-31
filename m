Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A546CC624CE
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12iU-0003Yz-2v; Mon, 31 Aug 2026 10:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x12iS-0003P4-AA
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x12iN-0006dQ-UO
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VBAG6F3358118
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yfXdQqf3P3p
 qApv+GltJ5vh6DxK8OZMRliAbZOpBLhY=; b=fKGG7XmaVlzoGHB5KWpaIaeBKuh
 kq2JdqkkFrsvElFj9z1FSutWhb78uib3Vg3WkbwpZwMdxu0DUevp1GnHwpETyM3/
 SMuq6JHoTKgVXUo2xrpKeU9TWo77XdrmG4V0XGDafAIxXveCYW1gDZdB/pv7xkja
 3Us32f/2tHThjlYdxWysWvkdmyemM3VgOCMqp9EkzBHQHXmqzqisSQfxVVVWNAYu
 F4eDbpl+KXva1dVLgPhTrOQfnpT4cz8uk6rsnhkCSah1oZmNmajfNrKFgOylDn+4
 NCbnryjyQn4UFlSA1Jrqg+RlZsFs6fb6RlxqNr/31m2fHjfHAT3t+62TiLA==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv7wb473-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:10:19 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-45952ce9ee0so4998851fac.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788185419; x=1788790219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yfXdQqf3P3pqApv+GltJ5vh6DxK8OZMRliAbZOpBLhY=;
 b=Eh+kSK7WNPM+E/7bDvSfqhorvY6sSUDn65VTSWFB0g/XgqPWebAHEI4g3KUhEbd9wO
 7x86eiH5ifaXFFud67byCX0aw9toHD/Xw7KKQ/glB+clG2aniFL9kE+D2L+lB8yT6sQG
 GnZYGoUkQIH7W2iwkO9zdw7QvrCqH5BVWwYvvgw0gq2BttDhcP7lYe1jK+/j8XGMO4wt
 Hs5aYoSYkeAYWqKyiA+Peb2rF6eyX+/BpT+syVURJOD94Cc4VaTLEZFaK6Wwkhi89dk3
 RRlnZUh9Z9+rco9NgV6gg7hkTgm/erqs5UhFxuPDdpbEn45aGsZUDrBCWlhnwonX4rYi
 Z3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788185419; x=1788790219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yfXdQqf3P3pqApv+GltJ5vh6DxK8OZMRliAbZOpBLhY=;
 b=f25v0TBfMef0Ex+NeoDneNIrAiSlZ/xTRgybZ8LAHqn+Tp0KLGtJbCxVgdFvA23T6s
 1dXoNPVYC2jjhwhUGPQjMe824LK4XtgKP4KIg3kXh6+Qdt5qpJ1h0vL2WBR4fQ2LjDAZ
 dFN5qBEDixwO2cUy8JmETlayOg35y5MmureCsvMjNymeNIlWC7osV4NVSy74iD4v2Qni
 XpmcT5r6bDUfWaZnxn48hyX1Zw2ikaCTU/Ne34B1TlertvSgKHNCJy0pn6U4vNVAyvGk
 YuvsYCVhLmO86VZ1/4CThJC6zTVM8AI1a3dSGzzkZr4niYxBuykd3Rt6vPjhiwp+L49O
 H4cw==
X-Gm-Message-State: AFuF++lBMDeArsL1TTqaYW/O+mJQCCHrw6R8oTxIn6ZMel1SML3A3rCN
 zViZIhCQ+CGKRpYvnm5jgevqbI/2Y690QagYb3o88mQqH14TWxApr2GyJI/RvGjO0z3li8uHLBQ
 ZfisllGad7RNsk8bXsg0vVM/WpE0tmcIjCcM1lCwZNIw5fTD6hLetDhI6jQSj3Kc7eA==
X-Gm-Gg: AYBFou3ES01PHHco9uUBDXGM1lDtrvdqCnkorgUyQfBRiRDnm2ZQ3je7B9bBL+QVinv
 6nt8NXAHtr4QQM0IJyV0h2t5zldbzeL5FAQ4MLf/dwXVpeaw6CNE3GJLF0IhCFnvyC/1xWtAHGm
 AaTFoyWDmVuIGW+dCZvBNjfHXPA2jBwXg3KqMe2lx4oiPCosycRr+aziueqXy5me3KFPqej8SfE
 fzBlDfqYTFiTVCv9uNX9uirM7n7xWz6AviC6lPBmPqpRiOPCLT/We9mRPeUhkXpuX3OyhbHZaOe
 8x0ULoblnSb+j0KdPUz3oyZLzGGQBAEL91QoUKz/oKypNSeUv1edgoUdc66mVyONY2ktCHXYGNm
 5kjUR6mFnLzE968kmVBJAvd5WsbL0kfYrjn2kbg==
X-Received: by 2002:a05:6870:788a:b0:45e:e061:162b with SMTP id
 586e51a60fabf-4683802fef4mr28399411fac.18.1788185418933; 
 Mon, 31 Aug 2026 07:10:18 -0700 (PDT)
X-Received: by 2002:a05:6870:788a:b0:45e:e061:162b with SMTP id
 586e51a60fabf-4683802fef4mr28399324fac.18.1788185418405; 
 Mon, 31 Aug 2026 07:10:18 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a3535e25sm9886129fac.5.2026.08.31.07.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 07:10:17 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v7 2/7] target/riscv: add sdext Debug Mode helpers
Date: Mon, 31 Aug 2026 11:10:01 -0300
Message-ID: <20260831141007.353854-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com>
References: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a958b4b cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=xvfqbYfxAAAA:20
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8 a=Mp8isO8jnsZoTyD_AnUA:9
 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=_Ge82aPy-h_wFa7gWU4u:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfXz2uR81HLpLB0
 r/rNAWLbyEDggnabW7Q9LalJfT8z8wHZPLjlKxl7QsgTgnsJJarwNHEl4DnKYnXceRhefbIMpGn
 ttR86cq8fs7fFErGPP1Gm3AiHbWgJfI=
X-Proofpoint-ORIG-GUID: u_qIxkdX2SpwdITJeyn_vGedvrU4-bOa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfX0W7czf5mkTl5
 r1Xeiidhhcl2iS9gXA1NGqDbsl5YOe5o7/Ydm4Xr0jTtK78elOq0OHp5H57v5svKzZ3P5oqJI1B
 Ue9vbK14UmbBwR6vfKJgPjWLkvdWsvl4q2pzb1lFYErwbUdKKzHEVaEz7CemvEw/kwfDDF+JFAM
 FDg9Rx4PHgjD1Q6i8/FJjTSqp0o0LTDSFypJolF/VOaVZ+UKVDY46QTYxMfbnvAJU4sbNiATIxM
 hMmut9BfOWDLQp4qh+HWbmI2qF9bLoKSH7LqVoQ3xLYauGdo/SFbbfd8SsmZGHjNowFKPrSo4TC
 T+Iau2NdoN3kHlfEhiwV48pQffodkdn8q7rB1u+f/zOt25eyy8SWi3yY9Q6NUgdZ8mCWyHa4dUH
 jghlfOQY/UsAZo2kx9J75zFtymBMkMBs/nBydRn0HPG4THw4Q2QNmCdqYvWL8LFAA+dfAe97gsD
 XiCKsiRm5ps4EnxsSaA==
X-Proofpoint-GUID: u_qIxkdX2SpwdITJeyn_vGedvrU4-bOa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310122
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Chao Liu <chao.liu.zevorn@gmail.com>

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Add helpers to enter/leave Debug Mode and to update dpc/dcsr.
Model resume without a Debug Module by leaving Debug Mode at
cpu_exec_enter and continuing from dpc.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 target/riscv/cpu.h            |  3 ++
 target/riscv/tcg/cpu_helper.c | 85 +++++++++++++++++++++++++++++++++++
 target/riscv/tcg/debug.c      |  5 +++
 target/riscv/tcg/tcg-cpu.c    | 14 ++++++
 4 files changed, 107 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 74bddc8415..167e913a48 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -669,6 +669,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 char *riscv_isa_string(RISCVCPU *cpu);
 int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
 bool riscv_cpu_option_set(RISCVCPU *cpu, const char *optname);
+void riscv_cpu_enter_debug_mode(CPURISCVState *env, target_ulong pc,
+                                uint32_t cause);
+void riscv_cpu_leave_debug_mode(CPURISCVState *env);
 
 #ifndef CONFIG_USER_ONLY
 void riscv_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d9222652..e6d948991c 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -132,6 +132,91 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
 #endif
 }
 
+#ifndef CONFIG_USER_ONLY
+static bool riscv_sdext_enabled(CPURISCVState *env)
+{
+    return riscv_cpu_cfg(env)->ext_sdext;
+}
+#endif
+
+void riscv_cpu_enter_debug_mode(CPURISCVState *env, target_ulong pc,
+                                uint32_t cause)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!riscv_sdext_enabled(env)) {
+        return;
+    }
+
+    env->debug_mode = true;
+    env->dpc = pc & get_xepc_mask(env);
+    env->dcsr &= ~(DCSR_CAUSE_MASK | DCSR_PRV_MASK | DCSR_V);
+    env->dcsr |= ((target_ulong)(cause & 0x7)) << DCSR_CAUSE_SHIFT;
+    env->dcsr |= env->priv & DCSR_PRV_MASK;
+    if (env->virt_enabled && riscv_has_ext(env, RVH)) {
+        env->dcsr |= DCSR_V;
+    }
+
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        if (env->elp) {
+            env->dcsr |= DCSR_PELP;
+        } else {
+            env->dcsr &= ~DCSR_PELP;
+        }
+        env->elp = false;
+    }
+#endif
+}
+
+void riscv_cpu_leave_debug_mode(CPURISCVState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!riscv_sdext_enabled(env)) {
+        return;
+    }
+
+    target_ulong new_priv = env->dcsr & DCSR_PRV_MASK;
+    bool new_virt = riscv_has_ext(env, RVH) && (env->dcsr & DCSR_V);
+
+    if (new_priv > PRV_M) {
+        new_priv = PRV_M;
+    }
+    if (new_priv == PRV_M) {
+        new_virt = false;
+    }
+
+    if (new_priv == PRV_S && !riscv_has_ext(env, RVS)) {
+        new_priv = PRV_M;
+        new_virt = false;
+    } else if (new_priv == PRV_U && !riscv_has_ext(env, RVU)) {
+        new_priv = riscv_has_ext(env, RVS) ? PRV_S : PRV_M;
+        new_virt = false;
+    }
+
+    env->debug_mode = false;
+    riscv_cpu_set_mode(env, new_priv, new_virt);
+
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+        env->elp = cpu_get_fcfien(env) && (env->dcsr & DCSR_PELP);
+        env->dcsr &= ~DCSR_PELP;
+    }
+
+    if (new_priv != PRV_M) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_MPRV, 0);
+    }
+
+    if (env_archcpu(env)->cfg.ext_smdbltrp && new_priv != PRV_M) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 0);
+    }
+    if (env_archcpu(env)->cfg.ext_ssdbltrp && (new_priv == PRV_U || new_virt)) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_SDT, 0);
+        if (new_virt && new_priv == PRV_U) {
+            env->vsstatus = set_field(env->vsstatus, MSTATUS_SDT, 0);
+        }
+    }
+#endif
+}
+
+
 /*
  * Returns the effective PMM field.
  *
diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 148201f3cb..5ab69bdc8e 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -972,6 +972,11 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
 
+    /* Triggers must not match or fire while in Debug Mode. */
+    if (env->debug_mode) {
+        return;
+    }
+
     if (cs->watchpoint_hit) {
         if (cs->watchpoint_hit->flags & BP_CPU) {
             do_trigger_action(env, DBG_ACTION_BP);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 54f1b66216..79afda28b8 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -271,6 +271,19 @@ static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
     }
     return extract64(result, 0, 64 - pm_len);
 }
+
+static void riscv_cpu_exec_enter(CPUState *cs)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
+    if (!cpu->cfg.ext_sdext || !env->debug_mode) {
+        return;
+    }
+    target_ulong pc = env->dpc;
+    riscv_cpu_leave_debug_mode(env);
+    env->pc = pc;
+}
 #endif
 
 const TCGCPUOps riscv_tcg_ops = {
@@ -287,6 +300,7 @@ const TCGCPUOps riscv_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = riscv_cpu_tlb_fill,
     .pointer_wrap = riscv_pointer_wrap,
+    .cpu_exec_enter = riscv_cpu_exec_enter,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
     .cpu_exec_halt = riscv_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.43.0


