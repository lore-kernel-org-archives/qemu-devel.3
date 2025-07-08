Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7A4C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGre-0001sS-Dt; Tue, 08 Jul 2025 18:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uZGaO-0000ii-H3
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 18:14:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uZGaL-0008UZ-SI
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 18:14:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568IOVUL030305
 for <qemu-devel@nongnu.org>; Tue, 8 Jul 2025 22:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ok8XiX3IV7A8vcUvVzN7/8/bYYud7Dm6dvm
 lIMUbwec=; b=Tuz3xH4uHEA4DYKq/hV1b40bnTxJlDUIU5L3M2gnm6A7XUlg3U1
 m3gTsLSzer81AwIZP5c8mBrZy5368u95ZWvftgsEzuDOsYNuaM+J3pAH/p68uVfV
 BhwR/6Rz/ktQuPVkNv4/TomglLhDktgqjkLD3G4Pa6A7gnNwgxJwau+yXNctFbLR
 Ofz8SUZ9zGz2pMt2hYF/rJW10FpXpwLeBbMdvKsd4ieT6YXMU0aL0F2OlNd3PBb8
 LwYsz/2FMzOSLmVCV4lg4KbDGMLZUhpWtnFH/18ycx8OdoBs4XTnZxU5yYWnXqyX
 n/kNPRk2irWRhSWT2lXuHSitcn4htj9qasw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b0ymhr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 22:14:41 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-31218e2d5b0so7898199a91.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 15:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752012881; x=1752617681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ok8XiX3IV7A8vcUvVzN7/8/bYYud7Dm6dvmlIMUbwec=;
 b=e7DK+Rhp33/wAqoT6x+gwMSc5p8NqbPjvD+OqfytFxQZRkh+q9HNyVQJAoz2+qPce9
 f2H68NQEfZRcfjuVGPWDeeYNkrOhA3NF7jy6B2duQF29bqqOWoL+h7Q0GgBKCNEWmGKF
 fvhlgocBWCiDFTYP21p5E1VM9YFj6aZ0UAxaFz9C9g+nLt5Pjj6YrF8QLBbXDn4tbCTB
 +0+7sJEgddmj5UqhuSwV7LgpJ+lkx0ZTKhPeKaviMWSGvoeOK7YKmBfjWdSTRD//vJ3z
 soBjqiPYh9/rEWwnhJUhJNAy5zL7hlJXXt1kBg4WgPsv2+VbkdrVmlzpuXlZwE+LCrOI
 Q2bQ==
X-Gm-Message-State: AOJu0Yy98ewn/9QWebD3ZjZg/yM1MXlqsSNujGoJyXBL3KHC3O23AB/J
 em2If9xTTWC/owmMEAZmt3REtZkgZ6HCKGgzroi4RiT9Vxd7KvGetm0L7K4bPar3QjNGrF43gXz
 VIQ4K8nWkvJDtGoGRbVmDCXq9S47EO4Z/BVxFOoOi1iiyPLZ4iGoZOFCL6/BKFsuk3PF/vMU=
X-Gm-Gg: ASbGncvLfpgv1/TK1l2r865D5ACFzeky44MYi1FYAAIiBOBq5M1o7YM7U1Oeynz6Kgt
 KUd7SNxO41fiC71psN7xTFvDVqONtG4wADiNZ4Hu1JQQJTqTDEvgNq8sz0VTrzECoR+ucwR4zU+
 dOwRcuc/vOpVMf4yJRr2WhSWUYlnyyYNIPCEMShSlNpHNVtJDigPLRQGDOc8kKDRw65Gg7+d5KV
 yrDiPbz0EaPJf3H9wle5CUAcqhvccNPASKVoEVlQbr0pDKio37mOHTYTX90DRCG8zBCyrfkZ4dn
 ObTcpZ6OgByl7QVkGGoGTMDFF/KMWAdeP4UJoxKoOM71rnJlzPWkd8NJNEVTK7cjUQSPpGpnRg=
 =
X-Received: by 2002:a17:90b:1c83:b0:312:1d2d:18e2 with SMTP id
 98e67ed59e1d1-31c2fda93a0mr307840a91.20.1752012880629; 
 Tue, 08 Jul 2025 15:14:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbSHqFCLpp/0YgYmGgGyznE73qL+QWzosscInxfq9rXBPUJh1XbCioyb5CczOmfX9jcOasgg==
X-Received: by 2002:a17:90b:1c83:b0:312:1d2d:18e2 with SMTP id
 98e67ed59e1d1-31c2fda93a0mr307817a91.20.1752012880144; 
 Tue, 08 Jul 2025 15:14:40 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c30037b57sm97921a91.8.2025.07.08.15.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 15:14:39 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH] target/arm: Added support for SME register exposure to GDB
Date: Tue,  8 Jul 2025 22:14:38 +0000
Message-Id: <20250708221438.347643-1-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686d9851 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=sqGZG02I1155U8WzEIEA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE4OCBTYWx0ZWRfXwb3nUizPuXss
 sfn7DZVsfn3Q7UqwUQERTUh6GyEoDrZIla7p4AReU3NeOD/9/5IUtKkVCHCueeNETpFBzCvRjy9
 aWuLrAQd29xyZt4a0YQ/9YcO32AA0sf2YkdF//f3IokrB5ykBEaS+KqAxprD9Llb4BGJBDElRR+
 BRQubvNl/CSh6y7Ldojoj8nvQTgMbT5UMfI651VRxtyoMfffPEr40zKp4KlosLS4lkinZKPO+ff
 hWl1X8gBMm+fsw0+jfVG+HOMVC/fbUXv3015k5TqWxl7xTjG/5pEkmdEkv/D7J1wEAkY4qbWYfa
 C88ZbFwbV9Z78NxJVjvMckqRGrQA8S/6zMGITQtSEvzRBzGNha4Mm28u0GMA4bobARcCCKUcTzg
 mS1VdvxAgm9gq4NA1764+9kYGdXeN1b9H0cbWzIkrUqwgPnnFYws7NKbL2izXUgDDlpLKkbG
X-Proofpoint-GUID: fvDjFcNiceabnBpC8fSeqhnhIIfy8qGb
X-Proofpoint-ORIG-GUID: fvDjFcNiceabnBpC8fSeqhnhIIfy8qGb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_06,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080188
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 08 Jul 2025 18:32:29 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The QEMU GDB stub does not expose the ZA storage SME register to GDB via
the remote serial protocol, which can be a useful functionality to debug SME
code. To provide this functionality in Aarch64 target, this patch registers the
SME register set with the GDB stub. To do so, this patch implements the
aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() functions to
specify how to get and set the SME registers, and the
arm_gen_dynamic_smereg_feature() function to generate the target
description in XML format to indicate the target architecture supports SME.
Finally, this patch includes a dyn_smereg_feature structure to hold this
GDB XML description of the SME registers for each CPU.

Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
---
 target/arm/cpu.h       |   1 +
 target/arm/gdbstub.c   |   6 +++
 target/arm/gdbstub64.c | 119 +++++++++++++++++++++++++++++++++++++++++
 target/arm/internals.h |   3 ++
 4 files changed, 129 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c8cf0ab417..c37ea7dcd2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -933,6 +933,7 @@ struct ArchCPU {
 
     DynamicGDBFeatureInfo dyn_sysreg_feature;
     DynamicGDBFeatureInfo dyn_svereg_feature;
+    DynamicGDBFeatureInfo dyn_smereg_feature;
     DynamicGDBFeatureInfo dyn_m_systemreg_feature;
     DynamicGDBFeatureInfo dyn_m_secextreg_feature;
 
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index ce4497ad7c..9c942c77cc 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -531,6 +531,12 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
             GDBFeature *feature = arm_gen_dynamic_svereg_feature(cs, cs->gdb_num_regs);
             gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
                                      aarch64_gdb_set_sve_reg, feature, 0);
+            if (isar_feature_aa64_sme(&cpu->isar)) {
+                GDBFeature *sme_feature = arm_gen_dynamic_smereg_feature(cs,
+                                             cs->gdb_num_regs);
+                gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
+                    aarch64_gdb_set_sme_reg, sme_feature, 0);
+            }
         } else {
             gdb_register_coprocessor(cs, aarch64_gdb_get_fpu_reg,
                                      aarch64_gdb_set_fpu_reg,
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 64ee9b3b56..e2fc874b38 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -228,6 +228,88 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
     return 0;
 }
 
+int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    bool streaming_mode = ((env->svcr & 0x01) != 0);
+
+    switch (reg) {
+    /* Svg register */
+    case 0:
+    {
+        int vq;
+        if (streaming_mode) {
+            vq = sve_vqm1_for_el_sm(env, arm_current_el(env),
+                     streaming_mode) + 1;
+        } else {
+            vq = 0;
+        }
+        /* svg = vector granules (2 * vector quardwords) in streaming mode */
+        return gdb_get_reg64(buf, vq * 2);
+    }
+    case 1:
+        return gdb_get_reg64(buf, env->svcr);
+    case 2:
+    {
+        int q;
+        int len = 0;
+        int vq = cpu->sve_max_vq;
+        int svl = vq * 16;
+        for (int i = 0; i < svl; i++) {
+            for (q = 0; q < vq; q++) {
+                len += gdb_get_reg128(buf,
+                           env->za_state.za[i].d[q * 2 + 1],
+                           env->za_state.za[i].d[q * 2]);
+            }
+        }
+        return len;
+    }
+    default:
+        /* gdbstub asked for something out our range */
+        qemu_log_mask(LOG_UNIMP, "%s: out of range register %d", __func__, reg);
+        break;
+    }
+
+    return 0;
+}
+
+int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    /* The first 32 registers are the zregs */
+    switch (reg) {
+    /* The first 32 registers are the zregs */
+    case 0:
+    {
+        /* cannot set svg via gdbstub */
+        return 0;
+    }
+    case 1:
+        env->svcr = *buf & 0x03;
+        return 8;
+    case 2:
+        int vq, len = 0;
+        int svl = cpu->sve_max_vq * 16;
+        uint64_t *p = (uint64_t *) buf;
+        for (int i = 0; i < svl; i++) {
+            for (vq = 0; vq < cpu->sve_max_vq; vq++) {
+                env->za_state.za[i].d[vq * 2 + 1] = *p++;
+                env->za_state.za[i].d[vq * 2] = *p++;
+                len += 16;
+            }
+        }
+        return len;
+    default:
+        /* gdbstub asked for something out our range */
+        break;
+    }
+
+    return 0;
+}
+
 int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -392,6 +474,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cs, int base_reg)
     return &cpu->dyn_svereg_feature.desc;
 }
 
+GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, int base_reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    int vq = cpu->sve_max_vq;
+    int svl = vq * 16;
+    GDBFeatureBuilder builder;
+    int reg = 0;
+
+    gdb_feature_builder_init(&builder, &cpu->dyn_smereg_feature.desc,
+        "org.gnu.gdb.aarch64.sme", "sme-registers.xml", base_reg);
+
+
+    /* Create the sme_bv vector type. */
+    gdb_feature_builder_append_tag(&builder,
+        "<vector id=\"sme_bv\" type=\"uint8\" count=\"%d\"/>",
+        svl);
+
+    /* Create the sme_bvv vector type. */
+    gdb_feature_builder_append_tag(
+        &builder, "<vector id=\"sme_bvv\" type=\"sme_bv\" count=\"%d\"/>",
+        svl);
+
+    /* Define the svg, svcr, and za registers. */
+
+    /* fpscr & status registers */
+    gdb_feature_builder_append_reg(&builder, "svg", 64, reg++,
+        "int", NULL);
+    gdb_feature_builder_append_reg(&builder, "svcr", 64, reg++,
+        "int", NULL);
+    gdb_feature_builder_append_reg(&builder, "za", svl * svl * 8, reg++,
+        "sme_bvv", NULL);
+
+    gdb_feature_builder_end(&builder);
+
+    return &cpu->dyn_smereg_feature.desc;
+}
+
 #ifdef CONFIG_USER_ONLY
 int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg)
 {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 21a8d67edd..af090b9b8e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1808,8 +1808,11 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
 }
 
 GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg);
+GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cpu, int base_reg);
 int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
+int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg);
+int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg);
-- 
2.34.1


