Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3B8C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XoQ-0002ra-2t; Mon, 07 Sep 2026 07:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3XoD-0002jI-T9
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:46:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Xo8-0003GD-Ka
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:46:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AnE9e2652808
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 11:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6xDJVLNp6v1
 diqmwXjAJksBLyIgVcOAjgYvoDlVpeOc=; b=YUThA84lfFAJtzkLYpaYJB12znH
 TQmY5UYK4uZPDlOU7QATcCXxer1unzQRNEJMg3uqWk901GtOMN6KxhYeKgHh1Oh2
 vf2lbWJDcXRboRDrcwKl2SOfWairsWilf3asK2eIUObSyWklPAfFB2uVGOrAldcz
 1oxslQX6pm5oGDbah0BszzxNur/E1S0IbvI8qtMn/rNNb3Tw6RI8V1HvANZoOCfh
 mZO3WH/W4bWO7Wg0JsVSNpKeZ2Clz39YskfYWofUB+6xBbL8yUwQALF74TfcB7m3
 A3hsMNJb+C2jkMcxecenzlVyvXMkhYm3SsEhjLF7xv87EVYXdbb5jhTxJzw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtty0fjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 11:46:38 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90e853561c5so33116666d6.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788781598; x=1789386398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6xDJVLNp6v1diqmwXjAJksBLyIgVcOAjgYvoDlVpeOc=;
 b=kCKvqtGojcUhx7Oo5LmtPxdYyMvlpLT0TbIMZyGRS902AYSO5XFBuJwrhw3oQjdjpf
 TtBkuwTyHdursLXGMJwHDvHDKHKWyUEtgT89SCDeMOoCz11P/IxPJZz/ei8DCn7pu0eo
 xEkuK9PnffHCdvy4+MzNqQkmWjbO0nC7Hf8vyuwOjFeeQmrAkFfZBBikd5uX+GYQcbQa
 qyWNT6GdGWPuJT1WqViNP4iDJZ2QLPRgY5506x4hP20Ln+JQNMLXkmgMGhPp8qOcoHEN
 Jjt/9cw8/aIiqrB/WvCVuNkMFe+ScOXgOO8bZuKxJt6Jj81SrshzPNPZ9s3nUeSU2Nqn
 0rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781598; x=1789386398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6xDJVLNp6v1diqmwXjAJksBLyIgVcOAjgYvoDlVpeOc=;
 b=lAkjDw836xgi7BJdj0TlXLAmBuvML/+9nHttlCjYUPjyXCoM4QuhOeQiGN5kMLopX5
 Rtsg6uo9OlxiM67OaK3ICjp1+JFgnxmL1IfaShiiEUgp0/udW3WrH2AA1EW7EYS4+A0f
 5fs+keCg2LlIMFLPBaTMoZmxStdBP48eQxDgYLstvEPtDndDzsMiBSuo09jz/HcEkYpQ
 /bRvJ54pdGNSHXF/QuQS4zFuF6BAiADMm5uZIc1EcMVdcXMlj27lu2l4MSLesZkIwhSF
 WmawPGHRG9vOFsGxMj88GwwVW+/pBhIeOvdjo6yRoWJjeCI+Rdod4Q+VC0Sw3EyNXY0J
 PqAg==
X-Gm-Message-State: AFuF++kT/CEYc3MZkMMsDBdF6Ty02AQy3u4hGXkmrsou+B/YC71wEz/U
 M92meCQfEt8NUCAHfVNHoHiTUTWGtcu8Jcwj46dasm/JaWEr08+A3uJl2+owG5y5jeuaI7SQMyN
 p1eY7e+N+GlUWbAf6RWIfLHg2CdXo776aguXmFeeXS9+ccuJeCWWgbRSfde1Oem95Wg==
X-Gm-Gg: AYBFou3iBlM/o3bddNnitIw6KOc8dEsSMmIkperrMPLhcQwqDXOou0f6f+KpSw0Sjf1
 dEFLPI25HR7/hVBpYL8BF+2arSyN+b9EvB9iIzSr86h8rai3+yZY5n6bL7260KloGjAbbcdl+hl
 uRzlmKMDwTItotxPjCQSyG7po5SzxNyWjNOUbKTJ7C+cLgmY26ZVcjGI1GQAj8HTFeGs+Pmz/oe
 4Dnk3QpCgyPLW5VRhmozrmSN2UF+MbrF3OYvMwvJDOOjHrLnnz2TaKrBF+ipIcnpZQukQns6Iz4
 SpChyJOFm0zEcXj2ZZMG8xxrpPdu7OODK2BUqcDVro08yc5NgyO79yNisAQYPaV5pJ516RsOveZ
 KCcmfN3myy4fchzzmXDXGlvJbQxw6/WOP0W9M
X-Received: by 2002:a05:6214:202b:b0:910:cd4:23a with SMTP id
 6a1803df08f44-9103ef980c2mr284321246d6.20.1788781597839; 
 Mon, 07 Sep 2026 04:46:37 -0700 (PDT)
X-Received: by 2002:a05:6214:202b:b0:910:cd4:23a with SMTP id
 6a1803df08f44-9103ef980c2mr284320576d6.20.1788781597310; 
 Mon, 07 Sep 2026 04:46:37 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040679e13sm89834876d6.26.2026.09.07.04.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:46:36 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v8 5/7] target/riscv: add sdext single-step support
Date: Mon,  7 Sep 2026 08:46:12 -0300
Message-ID: <20260907114615.1609913-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907114615.1609913-1-daniel.barboza@oss.qualcomm.com>
References: <20260907114615.1609913-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QNBYgALL c=1 sm=1 tr=0 ts=6a9ea41e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=xvfqbYfxAAAA:20
 a=VwQbUJbxAAAA:8 a=pFyQfRViAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=fgrLqfBXAAAA:8 a=tgk7fgI0p9FEwYF5lhYA:9 a=iYH6xdkBrDN1Jqds4HTS:22
 a=oJz5jJLG1JtSoe7EL652:22 a=_Ge82aPy-h_wFa7gWU4u:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: IjX30WvlPrnroAK2alwBL9VtMV0PejO_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzMCBTYWx0ZWRfX1acaG1N8s4d7
 /3rvRUa1Sp8y76RWZNWmmq7SI5mOTZMjogfaHKbpsaueykuGWFf1mIHoQ2otlB7bF1tcW/0sX4h
 UUa33TDb1VsjL5tl5/bU02eiAu/gMUo=
X-Proofpoint-GUID: IjX30WvlPrnroAK2alwBL9VtMV0PejO_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzMCBTYWx0ZWRfXxAMVnOaey5Hz
 CqZ3oLhAg29haNExkLsh1SqJ9j1dMOFSYyuqg9dVPVzlxTd/0R6ZGnu8H5QEJY/BC7w8eIVSN9j
 aWFF9mgw5p0s1mRsK4/4gKUynZREg5SMdFRwBfXSJ81cCSJd1WYOQkA+lnu2/G/9MZVUdtMT2ed
 e2RaxPpXpNnxeVETwkKJeQ/i1suXffLL0PL9czFAxkZM1fZn7Y4GIWEzdUWNRDS0YgKkMdE+R7W
 fQEdAYrlnGlysWDlJ6ECx18z9KGXR5YHkpnLZ7IL0r0xeKr3c7Bgc8UNhFE88v7x7GawRPRFfYV
 0jv3CqVlY4dadu/z2Llg8Q1cq+wDHDlF6Z7Od+MKJHVJoeS1mgtRuQZHk3jq6f/qZWeemWf+5KG
 7mfZHXd3+3Yo+5oQwUstqKeQj+RS1qqNm0EPRxiwsUuGUSnW71oT9qYkX22Ejzuti17p30v8bBr
 Gupwnf3jWVU5F0r7Q8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070130
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
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
index 82eb61a18c..db49ad7682 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -755,6 +755,8 @@ FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
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
index 959a1e89c8..16d26cee5c 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -196,6 +196,11 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
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


