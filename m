Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DA9C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 18:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubOEM-0002DP-Vd; Mon, 14 Jul 2025 14:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ubNDI-0007Te-HZ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:43:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ubNDF-0007P7-Sk
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:43:40 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGRaCA020898
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 17:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=nWuhbGQ4L8L8dZIDxi6otT/rZkte7mqTMVg
 FxXbAdnc=; b=hBGwdNMv3dJPxefLRBGLT6B/q/JrJ2RBWCKpHtAjQrBqKXnqm8M
 2oHw8CMgGsDotiYOO9rhDiyjykorbKI6UQFdiPG/xPVewUzE7bAbGvmIQ+9jYSYD
 LHbMJuvSsf7jBNfrlezr9ZA1iakmBISXNRl69LE4BnO3etDFhzuXkFOaLAGW/Vpf
 CHwcetPpjBCO8JyRnEajqc69VWO5Dvj96wX1SBwsitJ1XBlTXlYugPGoKGWd8wBs
 mK0jBAFS+LvwaKqtUxM/xoraLU4bzIG4bedNaDkOxz34jtOnfEnitSxRqnPwKYKp
 F+BCzH6YSF5sK35tBPRlOZCHoBdUfuqPE+A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dw07ca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 17:43:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3132c1942a1so7614203a91.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 10:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752515013; x=1753119813;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nWuhbGQ4L8L8dZIDxi6otT/rZkte7mqTMVgFxXbAdnc=;
 b=N/CcrxgJTEsddSwA7Lor0LtdEwjoS7wtNrJfu7hrWqxtsDH9NVYcn9HALcmaN0fN4Z
 KJmmY5I37s/eUAxpXNvgP9cYX9nJF766dfl1hhUdrmKSLDWxJmzAY1BcOy7ZABP4SJvH
 BO5bZA06sqY3lggG92JSRFumDWKowHgI4B9is8jSNboVJ6AGAwcNmGgZ/WkoTqsVZ0fm
 2/epLY4cojqKDhz05KWAbPyRoggPQ+C8smZ1pycERUv6GN3DGGmeWevqSkoCKUCGxAg/
 j1qQ6pSrz6XC+xYbcNq4XdHusm8D7XOYutYiv39huk7nmmuXAfc+HnSUlOlrWSswaZYJ
 GOqg==
X-Gm-Message-State: AOJu0Yzsk22Ay12r5eG0LTdXy/thOwSpFwm8c2t80hUOW9ibRAFVKEKL
 xs/qU75zh0NjPvvndYofr6FwLskcaZZUmmIO59Pf3Y09WG1EH8d5TQ9DBBklAkifgM8Ed0Veh7W
 gv+cxs2AjyAifnX61F/SM7OjaeEDVKN5ZT/y4F7/J2gMyYO2hhux7rQ/6DTaUg6b6spVX
X-Gm-Gg: ASbGncsI+rpB5QFQCZSVat4JHXbUBEmkfVy/VnDQuG62gl02BhvTQ5iBoWv6VwpvezV
 /CrMds7+IYp2H2k8iOr86oQnntzShBAWZRDbIumfzBrWjUWfDyev1l/fku4144wUI+0TnIfbSpJ
 SRe4Hug93qvm/KKHQlXezxJJMxzvlRV+893hmpPaeZxnKyP6y42kzd61zKcnPMjgfEgD+9x1hXt
 5NS3Tivcr+DInP9Q8yrROibdwTpCwbh51TxEJ7T4kDJ99aCxVFISNwAbJcE+Hn7ZBHxivKPtVIF
 UYPlWKdUE9qw6Tu4KmohYv5d3RmtAuCwpLI3+XsGrj5XpN4PVUElL+leKvOdnrvuQHVuu3P7MzU
 3ZyhgbOfgZl3sEVs=
X-Received: by 2002:a17:90b:1810:b0:314:2840:8b21 with SMTP id
 98e67ed59e1d1-31c4f5d022emr18442926a91.32.1752515012960; 
 Mon, 14 Jul 2025 10:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgPRXPdMd8rnB8WmwXQYQipR2GPMZ/h3cUU3WLJnu/mMSz8pjkaE6FwaDzeA6y6fHZIR5Ukw==
X-Received: by 2002:a17:90b:1810:b0:314:2840:8b21 with SMTP id
 98e67ed59e1d1-31c4f5d022emr18442886a91.32.1752515012336; 
 Mon, 14 Jul 2025 10:43:32 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c3003d504sm13548679a91.10.2025.07.14.10.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 10:43:32 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v2] target/arm: Added support for SME register exposure to GDB
Date: Mon, 14 Jul 2025 17:43:30 +0000
Message-Id: <20250714174330.913636-1-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: D6VCOPPq1caM1QR9MgVKy9X6Bgugi42r
X-Proofpoint-ORIG-GUID: D6VCOPPq1caM1QR9MgVKy9X6Bgugi42r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDExMSBTYWx0ZWRfX079Ea8XWVSvi
 7xwra1b82Ktzi+oUw67ZTekIQpRrYdKwBvSjZeGDYna1tnFpRq2u68nIWD/GAVpjKybN4TQw8ur
 0SXUX8LGOU/KnTpTg7zy9elwit4ll6ZqL3HosLpIUOpKF0qu/o9BFT6nUuADIVeADRWUaa327I3
 vSiLyZybMxJ2ZRWCCp5ZsMtTwBSIZXk6s5mdJbdkmrH/Jyo042ODPAcWpODLmvGff760z9v24TH
 2vOp1MkSVhB+6lV9TkrYyHA+MLN0gE7WfFZHGEY74304EjKvsaX5/GL7bmxitBlCbQ4Q31AFEBE
 WoSRmAR/milky93AtfGHXC/OL+HuMl+sjqRBMFFkr5wJezvuDo8XYcMiUGYYil5QaqRBE1E5nvd
 jww8AN0jNX2djr4WJ4qeve60aNki2vTPOXIIEZzxmMVP8j2K2vG/ZfJugsv3KgoB33mfML6p
X-Authority-Analysis: v=2.4 cv=CJQqXQrD c=1 sm=1 tr=0 ts=687541c6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=n8XNFov0HLMR1bPcp6wA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140111
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Changes since v1:
- Removed unnecessary comments in aarch64_gdb_set_sme_reg() regarding the zregs
- Used aarch64_set_svcr to correctly set the 64 bit SVCR in aarch64_gdb_set_sme_reg()
- Corrected typo in comment in aarch64_gdb_set_sme_reg() and aarch64_gdb_get_sme_reg()

 target/arm/cpu.h       |   1 +
 target/arm/gdbstub.c   |   6 +++
 target/arm/gdbstub64.c | 118 +++++++++++++++++++++++++++++++++++++++++
 target/arm/internals.h |   3 ++
 4 files changed, 128 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index dc9b6dce4c..8bd66d7049 100644
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
index 64ee9b3b56..c39d636caa 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -228,6 +228,87 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
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
+        /* gdbstub asked for something out of range */
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
+    switch (reg) {
+    case 0:
+    {
+        /* cannot set svg via gdbstub */
+        return 0;
+    }
+    case 1:
+        aarch64_set_svcr(env, *(uint64_t *)buf,
+            R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
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
+        /* gdbstub asked for something out of range */
+        break;
+    }
+
+    return 0;
+}
+
 int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -392,6 +473,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cs, int base_reg)
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
index c4765e4489..760e1c6490 100644
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


