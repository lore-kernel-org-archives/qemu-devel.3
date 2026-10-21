Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD30606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G9oDrP3/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ifwXBXph
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfW5-0007eN-QX; Wed, 21 Oct 2026 19:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVy-0007bS-8U
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVv-0004zB-A3
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:33 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKe96o1501680
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=imggVMD/TaZ
 WMeer1ygFhdYQWn4q+sa8kaNN50YrEb8=; b=G9oDrP3/ohn/HUiWfWtMARx1bK1
 rE2zABr4Mam3f+/Pwl1R18PGlTGvA2UjoRNzBRAL72tK/MfROKondWUTUMMm/fdj
 KFTnqbX+9v8dyNehGnSOpqNJ6mVrTvNDjX0kU4rOX2sDZeAtn+ZuvlrVmeYQR8et
 xckEfUr1wuJoZYgv6eS9A6ZryYf+Bp1jklI9Sfk9rJ+YHJkSwY/ySJ3tCKlR8nkm
 LgKI0fuV5I+DYv1X1sSPUynTiCNENOc51dKK93mp/AFls0uY816oFs+IBE1Btfb3
 cZp3BSc4COeueiDrOlqQ0QVr5IA2IIlceZwg/KA8EQ1beB/wig1fkf44c8w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0k2hg9d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-535066512b0so37115591cf.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624460; x=1793229260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=imggVMD/TaZWMeer1ygFhdYQWn4q+sa8kaNN50YrEb8=;
 b=ifwXBXphcW4MQzvW4IUb8AaNosG+Nlar5AFQPGnC1yFLVKwDyRWLEI6YBnQQwYn5qZ
 J7Z1PrApKCVNyJfaMfW6mKCiTE8IGWpjY/H6RXI0Fy8BFMhS8hXafTagpGmqKxASDCNq
 Ijywe2/YjofEAWdqHuICilbyW6ri8IqmiQEeCf4Rx9+U49JjFfhUXr/GDCzvcAg9z4fE
 9pt8bEwBSPniUh/mI6pKODRSfoMxJuTYtesmytrA0JSzz9MqwP02wfa+q6wHMaqF2SYS
 qzrMBEHTAQ1cR856RRImTMjwpSw9Y7MKfiLHzBqas/M5gA1/eEHwTWp5c+jpQn7hERqW
 rbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624460; x=1793229260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=imggVMD/TaZWMeer1ygFhdYQWn4q+sa8kaNN50YrEb8=;
 b=Qj4NXqC948qEr+SZIQ6q61CR9uDrf4BbVJrxs/bgabfnIKV2bUHgcK2hrPco/AiaPz
 +OW30qGE60d+I4JJi5QlW49oco9L9jZ3igkIVjFpJwPJ+7qq5Ll0Z8uu+7gPBk6oI80e
 X166y8CHBiMMAnfx+9OJq3F15SOUWRukLaN07bbNzwHoGrCVP+bBk7twx8ssrQqgRrL6
 rzwe0EGDdLCKn4dJ9YLUvAUpuCwjTwHujqrjVW2enrChOs3rWDA3OGgftf2kpg+hAUxf
 aqgpiJSnb2E/I63R9KMTMRICSjuIUAJ70+dXVq2GB4sYpkIty7UUzesuN84eprV+nPrk
 r/6g==
X-Gm-Message-State: AFq9FYJQzZe8fILKmrD9FmUvx48Z5OGvYlfcGp0F+nt0CqLUU5YUlgUC
 xry0ArvjsgVAo8wYpSfhpDYRD+5WS0WjU+mKsHGwy2o9anxiT8Vf23mp+YGy6Yq9YEEYLeWT1RZ
 ShwSTjQD3IOWy2r0sfR8q+iIQ+DKylEvW621GCks0oWRELgSAvzieLUvR5B5mRY365A==
X-Gm-Gg: AYBFou1ctEqUoEriQ6xs79dHWCKH0Oickvt93oVboyyQx5HfnevC0Bi79JuaDmvD4aW
 vZvmkiDYnOq/ysItwxfdf/wP2dUPxJjRF0D5179VMDb29zbWydHpDSRIxNUVO3TY6H5VrctnO/s
 YIhT8+it7Ove6JjoZZv3fP9srq43Rx/GBIWUWGjQt0yIx7P9xW32TbX26A6jfig58U4A1ip+cDW
 F+RrQ900CzStTMTDFdKi3RLfulRStXLp/LKTa1sDckzzD9kdlbxYVciCmFCNhEmbt5HIpaeqhZD
 SceonoDLW0U2X1QpldYgC+sWPy71GROqIDewmXhY/WA9EPChLDJxzWqutD42ib8ozPDR+dpPJfZ
 Z8gu67P9CsrMGc61AwoS9CoQFop0ukVFgc2Jjwxs7AbbANZ1eZz/zRE8V2qoOg3TGvvOWQxKiyg
 ==
X-Received: by 2002:a05:622a:a58c:b0:536:26db:d4e2 with SMTP id
 d75a77b69052e-5369b67306cmr51927291cf.15.1792624459418; 
 Wed, 21 Oct 2026 16:14:19 -0700 (PDT)
X-Received: by 2002:a05:622a:a58c:b0:536:26db:d4e2 with SMTP id
 d75a77b69052e-5369b67306cmr51926871cf.15.1792624458668; 
 Wed, 21 Oct 2026 16:14:18 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:18 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 07/18] target/riscv: add initial trace instrumentation
Date: Wed, 21 Oct 2026 20:13:34 -0300
Message-ID: <20261021231346.2452179-8-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX6iw+LL7nKXns
 UdaeTeF76PcmkputC2upMg+vxn6G2X+3lVAXsrd/G3ZQgBZEV5aaY7PzFVCPS0lWLG85nW7xUgl
 RCQ++LerLi0yiwc+aBoTIFCbUYvAsT4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfXwvcDcKNEGhz4
 YoaINH3BnQ0dR6hGoZMuNmH9ZbdfQwA2qTiFp4ejw2GXDUo37ltb93LxJPRgfKkn40NG8iyjZRH
 NipZlu20cEPMCP4wow7CxI98TzOkEQmQQOhUvIqPscZDBR+RyJtLRAGDQaMwHzuWDoHkujEjJgU
 NnHJqdnczR6ogZ/mysZz9oHCJq639wWtnnzP0xibdpIBG8G4Sk1XjJRUrQfd2iyCKBtaT+1gOkR
 H5Enh/7k1uHsdI6XLn29AYL1Bi/DzJKt5gFH3fuVmnTlwSpfe1ooJMDrdr3wNSQtw3mmldUQzbn
 FUW8VjX79n1dP2v7xX6v7wCUCraoXZUHAPMlqOLFoMQYaTcOxz94/BMEUSVZsOJPj6pSaXKiog1
 rV4ZAOYRH28bUHFP6EJd2hiiN/3LDPncsN3i05yhUGgvY4QBCp/00DzQhZC2hglXmQ3S58V2Uqm
 yqYV3M0lXH6FvJOz84w==
X-Proofpoint-ORIG-GUID: o6oNF4_lsx2_D2EUk3ywwOzSoLZ7j0e5
X-Proofpoint-GUID: o6oNF4_lsx2_D2EUk3ywwOzSoLZ7j0e5
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad9474c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=-Icm0ttqH3C302nBProA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210092
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

We'll have to instrument some RISC-V translations, as well as the start
of a translation block, communicating with the associated trace encoder
in case we're running a trace session. The trace encoder needs to report
the first insn of the session so we'll start with that.

Add a new EXT_TB_FLAGS called CPU_TRACE_RUNNING, along with its
ctx->cpu_trace_running boolean, to track when we should call the hwtrace
helpers.  For now we care about just the first insn of the trace
session.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/trace-encoder.c        | 17 ++++++++++++++++
 hw/riscv/trace-encoder.h        |  4 ++++
 hw/riscv/trace-events           |  1 +
 target/riscv/cpu.h              |  3 +++
 target/riscv/helper.h           |  4 ++++
 target/riscv/tcg/meson.build    |  6 ++++++
 target/riscv/tcg/tcg-cpu.c      |  4 ++++
 target/riscv/tcg/trace_helper.c | 36 +++++++++++++++++++++++++++++++++
 target/riscv/tcg/translate.c    |  9 +++++++++
 9 files changed, 84 insertions(+)
 create mode 100644 target/riscv/tcg/trace_helper.c

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 99399a55e1..1f89dc24fc 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -150,11 +150,15 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
     uint32_t trTeEnable = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL, ENABLE);
     uint32_t trTeInstTracing = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
                                                 INST_TRACING);
+    RISCVCPU *cpu = te->cpu;
+    CPURISCVState *env = &cpu->env;
 
     if (!trTeActive) {
         te->enabled = false;
         te->trace_running = false;
         te->trace_next_insn = false;
+
+        env->trace_running = false;
         return;
     }
 
@@ -170,6 +174,7 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
     }
 
     te->trace_running = trTeInstTracing ? true : false;
+    env->trace_running = te->trace_running;
 }
 
 static RegisterAccessInfo trencoder_regs_info[] = {
@@ -231,6 +236,8 @@ static const MemoryRegionOps trencoder_ops = {
 static void trencoder_reset(DeviceState *dev)
 {
     TraceEncoder *te = TRACE_ENCODER(dev);
+    RISCVCPU *cpu = te->cpu;
+    CPURISCVState *env = &cpu->env;
 
     for (int i = 0; i < ARRAY_SIZE(te->regs_info); i++) {
         register_reset(&te->regs_info[i]);
@@ -239,6 +246,7 @@ static void trencoder_reset(DeviceState *dev)
     te->enabled = false;
     te->trace_running = false;
     te->trace_next_insn = false;
+    env->trace_running = false;
 }
 
 static void trencoder_realize(DeviceState *dev, Error **errp)
@@ -266,6 +274,14 @@ static void trencoder_realize(DeviceState *dev, Error **errp)
     }
 }
 
+void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
+{
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+
+    trencoder->first_pc = pc;
+    trace_trencoder_first_trace_insn(pc);
+}
+
 static const Property trencoder_props[] = {
     /*
      * We need a link to the associated CPU to
@@ -294,6 +310,7 @@ static const VMStateDescription vmstate_trencoder = {
         VMSTATE_UINT64(ramsink_ramstart, TraceEncoder),
         VMSTATE_UINT64(ramsink_ramlimit, TraceEncoder),
         VMSTATE_INT32(cpu_id, TraceEncoder),
+        VMSTATE_UINT64(first_pc, TraceEncoder),
         VMSTATE_END_OF_LIST(),
     }
 };
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 30d118be1e..1801193e15 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -27,6 +27,8 @@ struct TraceEncoder {
     MemoryRegion reg_mem;
     uint32_t reg_mem_size;
 
+    uint64_t first_pc;
+
     hwaddr baseaddr;
     hwaddr dest_baseaddr;
     hwaddr ramsink_ramstart;
@@ -43,4 +45,6 @@ struct TraceEncoder {
 
 OBJECT_DECLARE_SIMPLE_TYPE(TraceEncoder, TRACE_ENCODER)
 
+void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc);
+
 #endif
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 14e333fd9e..dc25377acf 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -28,6 +28,7 @@ riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx
 # trace-encoder.c
 trencoder_read_error(uint64_t addr) "addr 0x%" PRIx64
 trencoder_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
+trencoder_first_trace_insn(uint64_t pc) "pc 0x%" PRIx64
 
 # trace-ram-sink.c
 tr_ramsink_read_error(uint64_t addr) "addr 0x%" PRIx64
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e2ded4c257..e9a80365bf 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -551,6 +551,8 @@ struct CPUArchState {
     uint32_t kvm_mp_state;
     bool kvm_mp_state_loaded;
 #endif /* CONFIG_KVM */
+
+    bool trace_running;
 };
 
 /*
@@ -791,6 +793,7 @@ FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
 FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
 /* sdext single-step needs a TB flag to build 1-insn TBs */
 FIELD(EXT_TB_FLAGS, SDEXT_STEP, 34, 1)
+FIELD(EXT_TB_FLAGS, CPU_TRACE_RUNNING, 35, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 372f104972..0832159adc 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -129,6 +129,10 @@ DEF_HELPER_4(csrrw, tl, env, int, tl, tl)
 DEF_HELPER_2(csrr_i128, tl, env, int)
 DEF_HELPER_4(csrw_i128, void, env, int, tl, tl)
 DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
+
+/* Trace helpers (should be put inside ifdef) */
+DEF_HELPER_2(trace_insn, void, env, i64)
+
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index 86805b30cb..e5c72889eb 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -10,6 +10,12 @@ riscv_ss.add(files(
   'fpu_helper.c',
   'm128_helper.c',
   'op_helper.c',
+
+  # In theory the RISC-V HW e-trace support is system_ss only,
+  # but we're instrumeting TCG code that is visible to riscv_ss
+  # ae well, ergo the helper needs to be visible in user-mode too.
+  'trace_helper.c',
+
   'translate.c',
   'tcg-cpu.c',
   'vcrypto_helper.c',
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 6e74d6a4de..8419eeca5f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -201,6 +201,10 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     if (cpu->cfg.ext_sdext && !env->debug_mode && (env->dcsr & DCSR_STEP)) {
         ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, SDEXT_STEP, 1);
     }
+
+    if (env->trace_running) {
+        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, CPU_TRACE_RUNNING, 1);
+    }
 #endif
 
     return (TCGTBCPUState){
diff --git a/target/riscv/tcg/trace_helper.c b/target/riscv/tcg/trace_helper.c
new file mode 100644
index 0000000000..5a6d725f56
--- /dev/null
+++ b/target/riscv/tcg/trace_helper.c
@@ -0,0 +1,36 @@
+/*
+ * RISC-V Trace Support TCG helpers
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "trace.h"
+#include "exec/helper-proto.h"
+
+#ifndef CONFIG_USER_ONLY
+#include "hw/riscv/trace-encoder.h"
+#endif
+
+#ifndef CONFIG_USER_ONLY
+void helper_trace_insn(CPURISCVState *env, uint64_t pc)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
+
+    if (te->trace_next_insn) {
+        trencoder_set_first_trace_insn(cpu->trencoder, pc);
+        te->trace_next_insn = false;
+    }
+}
+#else /* #ifndef CONFIG_USER_ONLY */
+void helper_trace_insn(CPURISCVState *env, uint64_t pc)
+{
+    return;
+}
+#endif /* #ifndef CONFIG_USER_ONLY*/
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index ede9c2563f..fb82a6b2fa 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -125,6 +125,8 @@ typedef struct DisasContext {
     bool bcfi_enabled;
     /* Data endianness from MSTATUS UBE/SBE/MBE */
     MemOp mo_endianness;
+    /* Detect if we're in the middle of a CPU trace session.   */
+    bool cpu_trace_running;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -1368,10 +1370,17 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->decoders = cpu->decoders;
     ctx->mo_endianness = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, BIG_ENDIAN)
                          ? MO_BE : MO_LE;
+    ctx->cpu_trace_running = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS,
+                                        CPU_TRACE_RUNNING);
 }
 
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
 {
+    DisasContext *ctx = container_of(db, DisasContext, base);
+
+    if (ctx->cpu_trace_running) {
+        gen_helper_trace_insn(tcg_env, tcg_constant_i64(db->pc_first));
+    }
 }
 
 static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.43.0


