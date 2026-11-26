Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38292606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ou18ziRW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V8p58hZ6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj38-0000rS-0C; Thu, 26 Nov 2026 18:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj2y-0008Nq-WA
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:38:37 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj2w-00017N-Vs
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:38:36 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwYtx161843
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OmX6UXNc7YcfSJlgH4ynjsZk/6keJPYOjklpmBK4urc=; b=ou18ziRW1/+/9ZUB
 ejhxmIpCZ6r6r2EkG+te2hz/l3w8aYnd2YQzPt5SQMGSA/8xnjvLW/v+BS0L9pEu
 YyF92OsKoDygwsyI5dVq3vHLpm51y2lsm9jF2hLNOPkpCq1gNRCdIL83zKI8eMlN
 sh43UdMXn11mRxt2wO+BFuG7C7uY7d3RDjP7dTtBJiJrHk4F84RRiXrz4MH8b9MP
 DWeKHDeAkHExZYpHh2/9mactT/Ejyf70L0lBtjCBJY/WY5aD9MEgLPbpkmH+OSiZ
 vV3YKCeXoMb6WMFyf51DiMc6DJDO63WRlPZ3TjqZzw1t1sEMb5XGk80ehBvoV1i6
 OgnSIw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6h7garhr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:38:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f32050e72so1627444585a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795736303; x=1796341103; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OmX6UXNc7YcfSJlgH4ynjsZk/6keJPYOjklpmBK4urc=;
 b=V8p58hZ6t2IQYAQjsR67WgTFk1UHO5S/hr+ndyAoFPL3cK8QkEleTFZnoUEyC1cXiD
 zyf8fP1pDMxJSQmP8jFDduCzhh+ZrkIBAFL1hBegNho6ev7YsMetMSnE3zWg8LlepNIQ
 a2kqXs/FNobqYp0pasobM3hYq7avJm+5humcLqsySySWvlF91o9/hnuUokg6QUibrhYE
 guqXdYHDLbgEdM/VtIu65sNNB1b6lqfA4Zz6rV2zKUUo7wV1cyqIruI+46OcZXAdX0XR
 ta0DNMPprQNOcQsXdH1/z7kg4kA28ZOaNnet7p58QdoGaPglqZ3ALkRPyKa7EPSDCKAQ
 SU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795736303; x=1796341103;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OmX6UXNc7YcfSJlgH4ynjsZk/6keJPYOjklpmBK4urc=;
 b=MdQH7JheqLHIKen5SrmH1aHkmtinXX+G220uUIQdD6UEYNaBHqr+vp8k14FTCqUTqa
 qLIgiQeg7bOBU1yHxm+b/9Yyj2fj5QKeXeehu0V1Ei2I9UcVm12WZ3PACxk2imbWgtzG
 R2TlV+Ozin5pT2l5tEbuiWUJaSNLfOfjwGsS34IcjdIi5SQ4kByTCNYxnwHTJYKbzPg4
 wmSIdRem43piAYwx7Z9YlwCmx7D2YRjv/dSvhTTa74hVcFx2dmpy/dZWioiURuxAfuWD
 MNqAwr0RdOKyYpMPf6cIrIPDndy8C/zlZ8gJQ0sSwbw6ujvnweY3h33m/E3YmATfwFIP
 Jx1w==
X-Gm-Message-State: APuU4Z9qpsMPHhgLybXqNlnzrpRF1/MbQb1ckIQ9cH8LSYnIHo/Wg/kA
 knBukHLJxpjbUuOKs/mmjwdp7TkWViepUxXw8tqbS7bDcl96vqF2OhCN6EE0tLFlrDsgZ+N28gh
 FxQGlJTdUulutbQJSI5fVsYyTMzM9jA+p8BgyrhlkSiHbwmhrE4UJ03y+oxa3c7txog==
X-Gm-Gg: AZFdTZeHdOqRvMB+zqzA0KfGVf6OJMCUc/+1QS9DkGYdbeDIaKc6uF1jphG1GnzWIkP
 kgu0kwQWeKhFxjcQgeJI/tW2XMNAjAVeILUzRUfJlet1+a4swhRsOB1isevQLJB3ACOMyikEHA7
 MqbOkCd+ZntDnQR09pBKlXpLQvg/FfwZRATDMHT1iUnfG0KBxOvPu7JUokgdxKYgNouiwUOrtS6
 U2Lg9reRV5u5vd4F9GLjibNts5CYrUJ2Q6ou/bw7kv8FMY+Pc7Ndc+fQyIN1ntAJJw/xlv30DI4
 cVfoKJcIQK+QktHComPAX5WFNmbNxEnl7G4wZc+uwdb2lssm/N3/x+6+HKLDKw+T+QVvJTZnQ27
 hcb+4HddfDzjbhKFacJ9MT660gN0CjOx3OTMKxMwbvMevWQxL5WVB8ijBxAIHFyIJ8iuumZjkwY
 MafhPJlmWiM82Uuw==
X-Received: by 2002:a05:620a:4408:b0:949:9cf0:bae5 with SMTP id
 af79cd13be357-949bab3d2f2mr4079857285a.69.1795736303235; 
 Thu, 26 Nov 2026 15:38:23 -0800 (PST)
X-Received: by 2002:a05:620a:4408:b0:949:9cf0:bae5 with SMTP id
 af79cd13be357-949bab3d2f2mr4079851485a.69.1795736302665; 
 Thu, 26 Nov 2026 15:38:22 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8960068fsm247399985e9.4.2026.11.26.15.38.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 15:38:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH 17/24] target/riscv: Partially revert use of tb->cs_base
Date: Fri, 27 Nov 2026 00:35:55 +0100
Message-ID: <20261126233604.67722-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126233604.67722-1-philmd@oss.qualcomm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NgObe1GYqm8Y5w1lPsmX6abfgEa_ZdBq
X-Proofpoint-GUID: NgObe1GYqm8Y5w1lPsmX6abfgEa_ZdBq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfXzM0hwKJHonIv
 CeyDYjkpR+kzDycngWlZCE6wnBkS3XCiSzlGSVyumQds0yMDgH7Z6Nq9yrcPSm1zJ9cM+A6GonX
 5G89tG8q+8y0rJ12TrpqBnAua30aWV9eEKhF06cK2TopzBfoymanlyTGgBEzIzjMH62UWFQNMxw
 8+SMvbcGT8gwmVFLrVPxGs2bZ/lnl69fNv6/4L/K2DYVC7V6DOA9UtceDpTqIyHaQCWLHQIgnW4
 Dt1iEZbIH6rNuLliGWNWw44Um5sogIo2ehj+NcD959xPjEHf5vSdp6CstDjplEbI2RXAhT3CCox
 nlNnoj3rQN1lesXHKdyTT/nZFAfHITPxF7P1h57UKXYXtOxIPxklxw2ZLQnR+RHZlkxOJVPqQCF
 FayJNgB97kbh76PE1gcIK9ZZ6QGFh92Iqfzmr0mRmFPVeHGkUSRdnbH88YeZhCKiUBpBZoQAnjx
 dJR3ryy0vrRFH1H50jg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfXz285RFANHU/Z
 0kIHiyY0Wz4/E9n6fTNNTC3TcLYoCjqt4GLe+SUoqq26Y6XTP7NWW8RkS3guVNUuE8wsXySDdZD
 xQ5Lyfdr6NRVS/NW0YKXsQKLaYQP/xE=
X-Authority-Analysis: v=2.4 cv=L4GI0OT8 c=1 sm=1 tr=0 ts=6b08c2ef cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1BkA0Nfa3nvqpVMZXUcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260093
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Partially revert commit 1c88ab9e77bd ("target/riscv: Use the
tb->cs_base as the extend tb flags"): now that TranslationBlock::flags
is 64-bit, keep only misa_ext in tb->cs_base (as in 55b490b58fbf) and
move the other extended flags (ALTFMT, BIG_ENDIAN, SDEXT_STEP) into
TB_FLAGS at bits 32+.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/exec/translation-block.h |  2 +-
 target/riscv/cpu.h               |  8 +++-----
 target/riscv/tcg/tcg-cpu.c       | 12 +++++-------
 target/riscv/tcg/translate.c     |  7 +++----
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index f9f4876e6dd3..491de24d71b9 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -65,7 +65,7 @@ struct TranslationBlock {
      * arm: an extension of tb->flags,
      * s390x: instruction data for EXECUTE,
      * sparc: the next pc of the instruction queue (for delay slots),
-     * riscv: an extension of tb->flags.
+     * riscv: misa_ext.
      */
     uint64_t cs_base;
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 49a1186bdbb2..be5d520e200b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -777,12 +777,10 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
 /* If pointer masking should be applied and address sign extended */
 FIELD(TB_FLAGS, PM_PMM, 29, 2)
 FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
-
-FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
-FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
-FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
+FIELD(TB_FLAGS, ALTFMT, 32, 1)
+FIELD(TB_FLAGS, BIG_ENDIAN, 33, 1)
 /* sdext single-step needs a TB flag to build 1-insn TBs */
-FIELD(EXT_TB_FLAGS, SDEXT_STEP, 34, 1)
+FIELD(TB_FLAGS, SDEXT_STEP, 34, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 362471d7c8e4..7a06979f9bee 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -105,7 +105,6 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     RISCVCPU *cpu = env_archcpu(env);
     RISCVExtStatus fs, vs;
     uint64_t flags = 0;
-    uint64_t ext_flags = 0;
     bool pm_signext = riscv_cpu_virt_mem_enabled(env, false);
 
     if (cpu->cfg.ext_zve32x) {
@@ -136,7 +135,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
         flags = FIELD_DP64(flags, TB_FLAGS, VMA,
                            FIELD_EX64(env->vtype, VTYPE, VMA));
         flags = FIELD_DP64(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstart == 0);
-        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, ALTFMT, altfmt);
+        flags = FIELD_DP64(flags, TB_FLAGS, ALTFMT, altfmt);
     } else {
         flags = FIELD_DP64(flags, TB_FLAGS, VILL, 1);
     }
@@ -194,19 +193,18 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     flags = FIELD_DP64(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
     flags = FIELD_DP64(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
 
-    ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
-    ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, BIG_ENDIAN,
-                           mo_endian_env(env) == MO_BE);
+    flags = FIELD_DP64(flags, TB_FLAGS, BIG_ENDIAN,
+                       mo_endian_env(env) == MO_BE);
 #ifndef CONFIG_USER_ONLY
     if (cpu->cfg.ext_sdext && !env->debug_mode && (env->dcsr & DCSR_STEP)) {
-        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, SDEXT_STEP, 1);
+        flags = FIELD_DP64(flags, TB_FLAGS, SDEXT_STEP, 1);
     }
 #endif
 
     return (TCGTBCPUState){
         .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
         .flags = flags,
-        .cs_base = ext_flags,
+        .cs_base = env->misa_ext,
     };
 }
 
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index 255433593dd9..b810b91dc26a 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -1324,7 +1324,6 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     uint64_t tb_flags = ctx->base.tb->flags;
-    uint64_t ext_tb_flags = ctx->base.tb->cs_base;
 
     ctx->pc_save = ctx->base.pc_first;
     ctx->priv = FIELD_EX64(tb_flags, TB_FLAGS, PRIV);
@@ -1344,7 +1343,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cfg_vta_all_1s = cpu->cfg.rvv_ta_all_1s;
     ctx->vstart_eq_zero = FIELD_EX64(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
     ctx->vl_eq_vlmax = FIELD_EX64(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
-    ctx->altfmt = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, ALTFMT);
+    ctx->altfmt = FIELD_EX64(tb_flags, TB_FLAGS, ALTFMT);
     ctx->misa_mxl_max = mcc->def->misa_mxl_max;
     ctx->xl = FIELD_EX64(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX64(tb_flags, TB_FLAGS, AXL);
@@ -1362,11 +1361,11 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->bcfi_enabled = FIELD_EX64(tb_flags, TB_FLAGS, BCFI_ENABLED);
     ctx->fcfi_lp_expected = FIELD_EX64(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
     ctx->fcfi_enabled = FIELD_EX64(tb_flags, TB_FLAGS, FCFI_ENABLED);
-    ctx->sdext_step = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, SDEXT_STEP);
+    ctx->sdext_step = FIELD_EX64(tb_flags, TB_FLAGS, SDEXT_STEP);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
     ctx->decoders = cpu->decoders;
-    ctx->mo_endianness = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, BIG_ENDIAN)
+    ctx->mo_endianness = FIELD_EX64(tb_flags, TB_FLAGS, BIG_ENDIAN)
                          ? MO_BE : MO_LE;
 }
 
-- 
2.55.0


