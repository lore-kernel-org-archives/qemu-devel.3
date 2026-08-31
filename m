Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F4DC624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12iX-0003mg-IJ; Mon, 31 Aug 2026 10:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x12iV-0003gg-TL
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x12iT-0006fX-PD
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:31 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VBABTf2848922
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=p8sB450gfwS
 TJk/dow8aMrrz18L+OqJy71sxYp/eiTQ=; b=pCIgA6qzM5w+XDLaTMdDS04GiA4
 UBX96QiZli3zuABEcQOnLB6WYypSTDjngUrVz4AKk2fNBWC/SG5PwLQnhAZvQwtr
 /vQv0CDPJCVdd5MHzGLXo1AGYrjXGf7KLBlkIJKosa5PKLMARGrssx4FPyWPxVMv
 rWWKQ4cDLBYIHKa4NRTtY/s1uKWpFeocIgvX4GynMlFVa7VEeR3db1AsAvSUfjk4
 JfDq9JgVo0kOTZ78wstlRpMJC+KwoZr0HYl743nbARa9y3TpbYaX8PxMqh6TXELG
 h1zTqMWCJ4eCZiNA4XkEpav/hpQpiCl74lMPb0us1Y5E84q1+UE1Sqr2MGA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6ayhb11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:10:28 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7f36427abfdso4523950a34.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788185428; x=1788790228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p8sB450gfwSTJk/dow8aMrrz18L+OqJy71sxYp/eiTQ=;
 b=T4yYGTNmGqm4aIISzvcYxZEES7tYJsswBKoJERzNMzQvHq4qD+Ldt1detopRjqjDK9
 Gni7HFB/YEHyOAUANNts/ajwBTHvEHVkkIQ0/tgBQBP5imy19wPl7KsY7oblsTAnk/j/
 Mm+GndqX5IJLSpMnBLlgfQT4i87LZt6wlzf98vylKGiNHpUCzqD1oiIEgCqbZH085yuK
 c6ozHcDc7SzKAVacc6KOB8vIRkIjn28TVUGi7JkNDLJ+Mec5ZMp7OhI7H2RjcDba3llI
 gjqmWfTc2QbYDeP+Dc4U50V1/xygEvHcEARosm1034pG+WkOjC5ABS62oYMoDIMajyqW
 ksVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788185428; x=1788790228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p8sB450gfwSTJk/dow8aMrrz18L+OqJy71sxYp/eiTQ=;
 b=jL4pjq87DkRnaGnleTixPzm5TJrcpbwr85XAT3fRmYgP/zjIG4keBrwppYoj7cBo7t
 ryBjKEcP4VT2rCNRwTfJFiCgnun6eaLW+jm9DPRJJUj7cdPbj3LEe0YNvLR2WsyzZP8e
 gPcUAtJi5DLRLv5HLhj2p1/mZKumXMXw3PxRl/XYDWxrDcEa7DPGzaN/Cjsa2tRNerR9
 kGew2jh587jYay8b9nxUd39JedFm9uKxfW5RhNaYw/lWzCUjOdSBMc70ITc8QXiHpchS
 ynT6fUZ4jwwatCVVpf/RYaYByaYt9uFJDCmlD4q7mcWJx5jS6j5h82/vliBrAtDuDIkl
 Zk9Q==
X-Gm-Message-State: AFuF++keexMfPzea03vEge3kKu08TU+ryIG0EMDYZZvRwXlZ+k4xiXrb
 dLZKPjUxHyVDQKWLFHyaRVPu3C2YnPLq7qVdvGp9HMlxgQkS8RUqutCXAb4BtviZ+EFCqsYtQHO
 6nUFN04r2ePUaW4BdG9cTizQz5goc4BQ9emr06/+vRbbsjcZjyglVz2pMP9s/FlWQEA==
X-Gm-Gg: AR+sD10FDyuD8J9LvJdyi6PSa72oGa0oqTaYaSu9j+Lkb4nUCBTVCnGMM+rlVz2sUL/
 h64OZnrAZWK9odj73E8RsKHC9ztNNnBFINUEgAPCCrleMhCQTfZtaaeCMpKCEonOmUQ4fJKIn6j
 i0a9yoRPsyOQ7TlWAz2xujfpXXn+wMQs+VfoGO4C2OMXirfqpCqMxBPz1isucw/M2laoyX454w1
 FJvNqhdVQeVff+69zbNN+WZG4OkeDUQubqnWxTTCFUfB9ANMOYaMiOR6YHZcG6dd71wdLvgyAt9
 JPFva3Qk+ma8eJcV0ZEFwQMP8BVei6sv893RH5O9h3z7kdCkbXuuGLMTznYopxggF3hyefDE6GP
 YAFe9drGd3e3F6gTZWyejVu35bkLXQwtf4BKcSA==
X-Received: by 2002:a05:6820:1625:b0:6b3:5475:4861 with SMTP id
 006d021491bc7-6b35475fb32mr8475504eaf.18.1788185427903; 
 Mon, 31 Aug 2026 07:10:27 -0700 (PDT)
X-Received: by 2002:a05:6820:1625:b0:6b3:5475:4861 with SMTP id
 006d021491bc7-6b35475fb32mr8475447eaf.18.1788185427257; 
 Mon, 31 Aug 2026 07:10:27 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a3535e25sm9886129fac.5.2026.08.31.07.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 07:10:26 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v7 5/7] target/riscv: add sdext single-step support
Date: Mon, 31 Aug 2026 11:10:04 -0300
Message-ID: <20260831141007.353854-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com>
References: <20260831141007.353854-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfX/Dw9IAZ0fV1p
 mKbEjInGPJymlNspQlZ2Ec7bcYzWX7fGUUbnhwwVO2RkDAt8WhapXAnxEpaUE9Uqvm6BaCZdbcR
 hPZsIz8O+DGNsf+7dxq4qiV27rD9g7E=
X-Proofpoint-GUID: sA_OgFoDE3XO0YPvcOCbOy68YKTZPHSF
X-Authority-Analysis: v=2.4 cv=CYE4Irrl c=1 sm=1 tr=0 ts=6a958b54 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=xvfqbYfxAAAA:20
 a=VwQbUJbxAAAA:8 a=pFyQfRViAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=fgrLqfBXAAAA:8 a=tgk7fgI0p9FEwYF5lhYA:9 a=EyFUmsFV_t8cxB2kMr4A:22
 a=oJz5jJLG1JtSoe7EL652:22 a=_Ge82aPy-h_wFa7gWU4u:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: sA_OgFoDE3XO0YPvcOCbOy68YKTZPHSF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfX8muNPHQJnYEp
 UU0fLSThIPRE9yGRk0PcYOB/C/pZl39siGsGrU0bbkirqP0IJ7dFx8LQwYA3lvpYYXcqMYQYmN2
 d4px6Tr2L1SXKFtxfy99pQ7EW/pzUZNrQvKP1rwqeaT38lqZ+SHUnbMluammANyFWCW8i4dYrDd
 wDh2c+bknGTXeR/6pYsT6qsLdvjH9F7IOZ2CBBQh/MCzSF/FwkicEQCrnjvSYvzYxLu463S8mEc
 RzovWkj/8LlcjvVozXwylFPqdvlf70weBOJ/AcU2O+fHLxLUDh3aWygTUcAc6Z2CBadzHhrDVKB
 zwKuFoTadVSv8ThGPM9NipsiHn2Ygrf485b26AeKcBVZCOWBs3NEWjf8krZYjN3KveJR5oM3C/p
 bIW/G1i0kg1akZ7YrWP338Cuy489Km18Orwna6kINuWen189/GrHVgwDv/dNaSS2vQwAwFR3X+0
 jwv6q2edBzDNyccODiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310122
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

Use a TB flag when dcsr.step is set (and we are not in Debug Mode).
When the flag is on, build 1-insn TBs and do not chain to the next TB.
Add a TB-exit helper that enters Debug Mode with cause=step and sets
dpc to the next pc, then stops with EXCP_DEBUG.

If dcsr.stepie is 0, do not take interrupts while stepping. Treat WFI
as a nop so the hart does not sleep during a step.

PS: This patch references Max Chou's handling of ext_tb_flags.
https://lore.kernel.org/qemu-devel/20260108132631.9429-6-max.chou@sifive.com/

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 include/exec/translation-block.h |  4 ++--
 target/riscv/cpu.h               |  2 ++
 target/riscv/helper.h            |  1 +
 target/riscv/tcg/cpu_helper.c    |  6 ++++++
 target/riscv/tcg/op_helper.c     | 20 ++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c       |  5 +++++
 target/riscv/tcg/translate.c     | 15 +++++++++++++--
 7 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 40cc699031..ee15608c89 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -64,8 +64,8 @@ struct TranslationBlock {
      * x86: the original user, the Code Segment virtual base,
      * arm: an extension of tb->flags,
      * s390x: instruction data for EXECUTE,
-     * sparc: the next pc of the instruction queue (for delay slots).
-     * riscv: an extension of tb->flags,
+     * sparc: the next pc of the instruction queue (for delay slots),
+     * riscv: an extension of tb->flags.
      */
     uint64_t cs_base;
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 167e913a48..37ba5be872 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -753,6 +753,8 @@ FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
 FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
 FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
 FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
+/* sdext single-step needs a TB flag to build 1-insn TBs */
+FIELD(EXT_TB_FLAGS, SDEXT_STEP, 34, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 0d9ae15e3e..5193440e1c 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -142,6 +142,7 @@ DEF_HELPER_1(tlb_flush_all, void, env)
 DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
 /* Native Debug */
 DEF_HELPER_1(itrigger_match, void, env)
+DEF_HELPER_1(sdext_step, void, env)
 DEF_HELPER_2(sdext_ebreak, void, env, tl)
 #endif
 
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index e6d948991c..a7344b1be2 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -500,6 +500,12 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & mask) {
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
+
+        if (cpu->cfg.ext_sdext && !env->debug_mode &&
+            (env->dcsr & DCSR_STEP) && !(env->dcsr & DCSR_STEPIE)) {
+            return false;
+        }
+
         int interruptno = riscv_cpu_local_irq_pending(env);
         if (interruptno >= 0) {
             cs->exception_index = RISCV_EXCP_INT_FLAG | interruptno;
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index 5db4f6aacd..489aac28e7 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -489,6 +489,22 @@ target_ulong helper_dret(CPURISCVState *env)
 #endif
 }
 
+void helper_sdext_step(CPURISCVState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    CPUState *cs = env_cpu(env);
+
+    if (!riscv_cpu_cfg(env)->ext_sdext || env->debug_mode ||
+        !(env->dcsr & DCSR_STEP)) {
+        return;
+    }
+
+    riscv_cpu_enter_debug_mode(env, env->pc, DCSR_CAUSE_STEP);
+    cs->exception_index = EXCP_DEBUG;
+    cpu_loop_exit_restore(cs, GETPC());
+#endif
+}
+
 void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
 {
     CPUState *cs = env_cpu(env);
@@ -621,6 +637,10 @@ void helper_wfi(CPURISCVState *env)
                (prv_u || (prv_s && get_field(env->hstatus, HSTATUS_VTW)))) {
         riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
     } else {
+        if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode &&
+            (env->dcsr & DCSR_STEP)) {
+            return;
+        }
         cs->halted = 1;
         cs->exception_index = EXCP_HLT;
         cpu_loop_exit(cs);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 79afda28b8..d90861d93f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -198,6 +198,11 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
     ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, BIG_ENDIAN,
                            mo_endian_env(env) == MO_BE);
+#ifndef CONFIG_USER_ONLY
+    if (cpu->cfg.ext_sdext && !env->debug_mode && (env->dcsr & DCSR_STEP)) {
+        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, SDEXT_STEP, 1);
+    }
+#endif
 
     return (TCGTBCPUState){
         .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index 9684dbe752..1a38d6aeb5 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -112,6 +112,8 @@ typedef struct DisasContext {
     bool ztso;
     /* Use icount trigger for native debug */
     bool itrigger;
+    /* Enter Debug Mode after next instruction (sdext single-step). */
+    bool sdext_step;
     /* FRM is known to contain a valid value. */
     bool frm_valid;
     bool insn_start_updated;
@@ -286,6 +288,9 @@ static void lookup_and_goto_ptr(DisasContext *ctx)
     if (ctx->itrigger) {
         gen_helper_itrigger_match(tcg_env);
     }
+    if (ctx->sdext_step) {
+        gen_helper_sdext_step(tcg_env);
+    }
 #endif
     tcg_gen_lookup_and_goto_ptr();
 }
@@ -296,6 +301,9 @@ static void exit_tb(DisasContext *ctx)
     if (ctx->itrigger) {
         gen_helper_itrigger_match(tcg_env);
     }
+    if (ctx->sdext_step) {
+        gen_helper_sdext_step(tcg_env);
+    }
 #endif
     tcg_gen_exit_tb(NULL, 0);
 }
@@ -309,7 +317,8 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
       * Under itrigger, instruction executes one by one like singlestep,
       * direct block chain benefits will be small.
       */
-    if (translator_use_goto_tb(&ctx->base, dest) && !ctx->itrigger) {
+    if (translator_use_goto_tb(&ctx->base, dest) &&
+        !ctx->itrigger && !ctx->sdext_step) {
         /*
          * For pcrel, the pc must always be up-to-date on entry to
          * the linked TB, so that it can use simple additions for all
@@ -1350,6 +1359,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->bcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
     ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
     ctx->fcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
+    ctx->sdext_step = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, SDEXT_STEP);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
     ctx->decoders = cpu->decoders;
@@ -1402,7 +1412,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 
     /* Only the first insn within a TB is allowed to cross a page boundary. */
     if (ctx->base.is_jmp == DISAS_NEXT) {
-        if (ctx->itrigger || !translator_is_same_page(&ctx->base, ctx->base.pc_next)) {
+        if (ctx->itrigger || ctx->sdext_step ||
+            !translator_is_same_page(&ctx->base, ctx->base.pc_next)) {
             ctx->base.is_jmp = DISAS_TOO_MANY;
         } else {
             unsigned page_ofs = ctx->base.pc_next & ~TARGET_PAGE_MASK;
-- 
2.43.0


