Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6309FCA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 18:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqyl9-0000Vd-Th; Tue, 26 Aug 2025 14:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uqyl8-0000V0-2U
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 14:51:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uqyl4-00012G-Gz
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 14:51:05 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCKrGP010931
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=N/cJ1VigX5TamwRxQg27K5ECt0YK3rjIAfl
 QIFqgDpE=; b=dmxBc7C/eHAOTEILqWdT4gpUezVXh5SRUDl3k8cpl5ibPGmfVvY
 zkAXsR03xb+N3CRvQn0n/yGO5d1CPkHlZTIXa8G7huVraPNtH2nT6ZGXF+6dDw+K
 1o47M/B82MxHZ/9oe8mG4nt4gsJKQ4Yyrgb/i1unxW4v2Z8/yb3iuDEGRv3dZBRG
 gAmVUISf5qaNeWcjFslc8FORm00O2jIN9trfInYeX4gX76eTNzMJ2xQ1QGqzZzHC
 x18ZrcY8Aghvx9Mi7x1jbnGUs79DFGCRjvPzFRnOEtraodb/ca+31nQCrQtF3c9B
 DQx8F33BfEnBulQRaYJ9GhwqTvU1bZfIbsg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unsx64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:50:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2465bc6da05so54448055ad.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 11:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756234255; x=1756839055;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N/cJ1VigX5TamwRxQg27K5ECt0YK3rjIAflQIFqgDpE=;
 b=aU9mdhyA5/JGTqMsGyD7ctlTvp7xXlZ5/HK8EamL+7uch5rp33IA0mjNgSMorTT69q
 9uv9Q1nIL/0jup3jf1WsqGBK7fbI5PJvk4Lgw654/vh4t6IuD2+sMef9h2ueLweIfvxJ
 +x2hgovi0mUfV2pJxLlGY3kY2NnnU48V0H+cFPgV8jo7LhtIfD8VX9F7KuguiKvaneU7
 q+R8ziNSCoMBr3PKy5x9w/EzSE8qsYcCgBllzW6g+zCv1qtACPtmtLg/442dMQjiZu8y
 6gLO8o+3rxVCar1pw/Xg9HW135il7ZTKUWLoS1oJRKf6hMJUJVfbo/7OzMDl2RRlq9es
 +aQA==
X-Gm-Message-State: AOJu0Yy9xRlGKiu6w/yd9CajW1iOxWYbSeBtd4ZUbh2LBRMUlK1cHlO0
 UBGKxKGDGV1b3s9Ib9/zzhOqaCkE1n4hPaWMLimXZp9Z8dsoD3V8dSUDcj6PBkVWoWqfkickmou
 jcgrd1700FnDdIUfRQgQRu0/ZpCxhxb8KjnWi+dRAO2XqTB+YqhaHwH0ooGO/cwx5JswR
X-Gm-Gg: ASbGncvLmLw910tes0eJms4iB/EFfu+6nldDgBKK3bMxZMikq+sebGyn4JF/DBn4Ptk
 7nX1GWz+TcmhKD3nWitKA1CW7PIOr8gYi5GrlwIsskugVjBKNjJ076EAk0ZU5ximbQOP8wQyo5m
 tKFNw58HcipHT9dLkV8vEJOELeP6V8a2Gf2bvqdxUE8YowDxseozt8IkADBYQ0lajj2NiAlLLy7
 y1VrDdUOCBnslZj+xcgaq5P/KBdwqVP2LLbUe+vF2FNHuuYNahIR1RlWJfPSZRZkvXPXzzjTO/r
 hzrVi0OSTaf04C/9zorHHLJJYcnX0IcDOkiVZdyMCCZTjqye6U2yV549Ff5P1/jI9hp7vt7Lrfx
 i7HC4xTxiv3lj6iQ=
X-Received: by 2002:a17:903:1107:b0:242:a1ee:6c3f with SMTP id
 d9443c01a7336-2462ee246bfmr231391425ad.4.1756234255056; 
 Tue, 26 Aug 2025 11:50:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELK4LETRbY8VGJ/UMoJ0hSMXhx9pFx6tPpVlL2sUIK/AK/7jHLjFbFKom+SNebjGO/ChDtRA==
X-Received: by 2002:a17:903:1107:b0:242:a1ee:6c3f with SMTP id
 d9443c01a7336-2462ee246bfmr231391245ad.4.1756234254534; 
 Tue, 26 Aug 2025 11:50:54 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2466885ed51sm101674215ad.85.2025.08.26.11.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 11:50:54 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v6 2/3] target/arm: Added support for SME register exposure to
 GDB
Date: Tue, 26 Aug 2025 18:50:52 +0000
Message-Id: <20250826185052.511223-1-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LlpcMrfvzTEKaOkNbRRB6vnO0eSf3SA6
X-Proofpoint-ORIG-GUID: LlpcMrfvzTEKaOkNbRRB6vnO0eSf3SA6
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68ae0210 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=JRRW1ReKSft4RaJC_60A:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfXzsZ2Ig7wD9wd
 9IbDPZDt+v1wVdNfznIJtaMDWVfoBKyiSstHBnCKOZJIC1DlFP/sWqKvwVPTyR2177OXDWdSEpP
 Hombhcxn1XVyUXmcupFFGaJG0DU6w5RoN74bvFxlVNjWV6rP4dgVVZz0A1fdnHBKd5ApR6atBdF
 PV1xezG+BabyicFulUr97TqIED4bXKCca6Dkgbuw4dXmjD3GxzFFVTDxpLdeZBHoE1rzYpdB0+W
 mHdkLhP3IalnyRwHsEnlSWNSYbk+4EsjYo87MQh6aK5jCvtynXs4QR177apVSIaS6ZS6Z8oeUDc
 OqsyNpIcxDRtuQdPE0WpNnaIQvAOgq0n88ZtHde5NAjxINrXUVD3fW2502KB5HTN9QfvoCJpC+a
 3f3V11N7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Changes since v5:
- added code to handle the case when we have SME without SVE
- added comments to indicate th cases in aarch64_gdb_get/set_sme_reg
- added/removed braces where necessary
- corrected capitalization in comments
---
 target/arm/cpu.h       |   1 +
 target/arm/gdbstub.c   |   9 ++-
 target/arm/gdbstub64.c | 121 +++++++++++++++++++++++++++++++++++++++++
 target/arm/internals.h |   3 +
 4 files changed, 133 insertions(+), 1 deletion(-)

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
index ce4497ad7c..110258ec18 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -527,7 +527,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
          * registers so we don't need to include both.
          */
 #ifdef TARGET_AARCH64
-        if (isar_feature_aa64_sve(&cpu->isar)) {
+        if (isar_feature_aa64_sve(&cpu->isar) || isar_feature_aa64_sme(&cpu->isar)) {
             GDBFeature *feature = arm_gen_dynamic_svereg_feature(cs, cs->gdb_num_regs);
             gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
                                      aarch64_gdb_set_sve_reg, feature, 0);
@@ -537,6 +537,13 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                      gdb_find_static_feature("aarch64-fpu.xml"),
                                      0);
         }
+
+        if (isar_feature_aa64_sme(&cpu->isar)) {
+            GDBFeature *sme_feature = arm_gen_dynamic_smereg_feature(cs,
+                cs->gdb_num_regs);
+            gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
+                aarch64_gdb_set_sme_reg, sme_feature, 0);
+        }
         /*
          * Note that we report pauth information via the feature name
          * org.gnu.gdb.aarch64.pauth_v2, not org.gnu.gdb.aarch64.pauth.
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 08e2858539..d3fd94b93d 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -249,6 +249,90 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
     return 0;
 }
 
+int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    switch (reg) {
+    case 0: /* svg register */
+    {
+        int vq = 0;
+        if (FIELD_EX64(env->svcr, SVCR, SM)) {
+            vq = sve_vqm1_for_el_sm(env, arm_current_el(env),
+                     FIELD_EX64(env->svcr, SVCR, SM)) + 1;
+        }
+        /* svg = vector granules (2 * vector quardwords) in streaming mode */
+        return gdb_get_reg64(buf, vq * 2);
+    }
+    case 1: /* svcr register */
+        return gdb_get_reg64(buf, env->svcr);
+    case 2: /* za register */
+    {
+        int len = 0;
+        int vq = cpu->sme_max_vq;
+        int svl = vq * 16;
+        for (int i = 0; i < svl; i++) {
+            for (int q = 0; q < vq; q++) {
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
+    case 0: /* svg register */
+        /* cannot set svg via gdbstub */
+        return 8;
+    case 1: /* svcr register */
+        aarch64_set_svcr(env, ldq_le_p(buf),
+            R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
+        return 8;
+    case 2: /* za register */
+    {
+        int len = 0;
+        int vq = cpu->sme_max_vq;
+        int svl = vq * 16;
+        for (int i = 0; i < svl; i++) {
+            for (int q = 0; q < vq; q++) {
+                if (target_big_endian()) {
+                    env->za_state.za[i].d[q * 2 + 1] = ldq_p(buf);
+                    buf += 8;
+                    env->za_state.za[i].d[q * 2] = ldq_p(buf);
+                } else{
+                    env->za_state.za[i].d[q * 2] = ldq_p(buf);
+                    buf += 8;
+                    env->za_state.za[i].d[q * 2 + 1] = ldq_p(buf);
+                }
+                buf += 8;
+                len += 16;
+            }
+        }
+        return len;
+    }
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
@@ -413,6 +497,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cs, int base_reg)
     return &cpu->dyn_svereg_feature.desc;
 }
 
+GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, int base_reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    int vq = cpu->sme_max_vq;
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
index 1b3d0244fd..41e05066b9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1802,8 +1802,11 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
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


