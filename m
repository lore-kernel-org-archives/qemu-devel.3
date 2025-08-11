Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6387CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 19:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulYKv-0007HK-Kh; Mon, 11 Aug 2025 15:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ulYKj-0007E1-2r
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:37:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ulYKS-0003rz-Vh
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:37:24 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BGwLmv018342
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 19:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7rQftNpdawu
 un3GG01df+hVC7NJaB4/u1DcHDd2SFC8=; b=pE4gYxzd/VwzSgneXnLHIm0YRPs
 CLGweaQX1Rsr6tGvSl99e85nJdhMzSufSXSNVDinZRydbTkDdOSg5JTef0cuNHJI
 ufUHTPfggEe6tgIdd/KxFsE4O515UvtXKZrLdupQQjp/QXNi8+akCUt/8nFnSr02
 TWykuNoO2dO6xf5QkztvLiKEZOf8sVEmAu5BAxDGb/Hr0gGSZvplaK54npgu2zv+
 eQpTzeyOIaSDtGCh65aroJbgO1OFiYMGUBwpHuIYijfkTcG+PjsOMwYZ3wu5OJTq
 Hf8OeVSKYdSuXF7htWSvuECfefSrfwR3ZTwS4nr1A+yeC2k1RbtpRK+/IQA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g5jj7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 19:37:02 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-76be6f0bbfdso6123680b3a.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 12:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754941021; x=1755545821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7rQftNpdawuun3GG01df+hVC7NJaB4/u1DcHDd2SFC8=;
 b=qxTiEDQ1+E1BRKS8bWenGos+QVrQWhD/MRw8OvtmELPNIWUVb8kCb/Sb4x01sFax3D
 7UKMNiVah3GRs5NulUZRS+NywAILfjJAZ+VG1R7FHtNSqSwDuSwpoom9g5KZCcKjS/qu
 Nfp2XeW0wPsIraYCXWxUMelOzU6bWj9sCidrEwSRoI/XquqGZTH08cP4KDHDt36zZm+t
 BZd1c1X6tgZb/hyguDLrDDGh9A5gOI+5yrv7sfzStgaLTwlBR4vAMfA1aoq9TleYwQrU
 /e1El1CDBfX8KUmTW2FMdITsgO2MvH0d8W3vMUH4588YZtR7s//B/1Fhr3DeyXT3zv2J
 8gig==
X-Gm-Message-State: AOJu0YzfM3+wc2nqlQ3qlQhzqzM12K7Kt4528mubgehNwujHdrRtIjfJ
 7ULqgUyFBUPRTRAKTF36p+j9zsfCbKfl5zdx7d+repr33tLmQaJoxnjP/amyHOUIw9S0YgP46zC
 uq1dnSPtt48CRkT/1lLNdGy6JEMhFYdHRv/c0cwSv0sg7NcLSSvhpR3x3nGCssi0DZlBV
X-Gm-Gg: ASbGncusDlbHIg1RrP+LNRHGN2zyFNuOVNtH9QliLy2Td2yX+u23tH/qGY3y54OUEsf
 XvEfbdEqxiFCD/XhviQg0LnGKBxNp7aDRMqkMmDEsEM9cyUW+LbRFV6grfTrL8lj2h3QDO5xU0d
 0KWNJ1VrTDd+AFSZz25cOjYlt3wsde7NMdOyH/mH35SjRAOJG+FNPtH1Skwun2D6OqyispHUyGY
 oz/ObmEVNJdB4FsOv3uWTPYKeHMZsDBPyXGsKoO8oYlv/+OirdTiLizJX2KoapCYMOljD91rndN
 yVKOhX3aA+aYvkn0q1gV6826/uKLSaM8WKLPOh0dy/YLy5LW+y2otzygI6ridHs5aOoSwZkwkup
 FDlK8mL1kd4looyg=
X-Received: by 2002:a05:6a00:852:b0:76b:42e5:fa84 with SMTP id
 d2e1a72fcca58-76c460af27bmr18420228b3a.7.1754941020997; 
 Mon, 11 Aug 2025 12:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdfQOSV/vy73V1stugvh+APrpPn3MN/3GDT0yWkuig7fCUn3k2T3W3oxzQzrTDLpAWt2Q1Mg==
X-Received: by 2002:a05:6a00:852:b0:76b:42e5:fa84 with SMTP id
 d2e1a72fcca58-76c460af27bmr18420199b3a.7.1754941020521; 
 Mon, 11 Aug 2025 12:37:00 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbcef6sm27677171b3a.85.2025.08.11.12.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 12:37:00 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v5 3/4] target/arm: Added support for SME register exposure to
Date: Mon, 11 Aug 2025 19:36:53 +0000
Message-Id: <20250811193654.4012878-4-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811193654.4012878-1-vacha.bhavsar@oss.qualcomm.com>
References: <20250811193654.4012878-1-vacha.bhavsar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689a465e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=BNg5ujFbbBWOBbuzlAkA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX7F8So1zjpcBG
 XYqjHAw3x9uyuOvDcLgpQsYXW1BqG4zI2NVptKl6fleKvIO+BsmYEP6yLgC47OU11xQkfkpWt9I
 Uc/ASeIjU0c0U14qOsQd7k7qkojtKPgZnq8GvaYx1OYCQEaua7RzjJF+HWpkBJA2EfFkhdOtt5k
 u9nWTw6doak1gJbvC2yd6sNuXZCcm7V6kOHgPSlfvzu3xPbwOk5bmdzPOwT7/oODfeM+Xs6Wa9L
 LAcqdJnIXIcO1iIaiHSmPJb9MYpA6T3gkg+plGwLDufKcvMHtWcaIvd5xOEcnKdSdExPopLRrQP
 h2IGjJppw7n/FnGQZ+kbxE0zU72yY/PmsUCAyerAbo6pTDFtajTkbOtAenk6sXQV5VKWtkwJjJ7
 T4gg+wbu
X-Proofpoint-GUID: m3jtNUtG5yBkoRZcxdN6EEyhtKlXzu2K
X-Proofpoint-ORIG-GUID: m3jtNUtG5yBkoRZcxdN6EEyhtKlXzu2K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 target/arm/cpu.h       |   1 +
 target/arm/gdbstub.c   |   6 ++
 target/arm/gdbstub64.c | 122 +++++++++++++++++++++++++++++++++++++++++
 target/arm/internals.h |   3 +
 4 files changed, 132 insertions(+)

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
index ce4497ad7c..4371a367a0 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -531,6 +531,12 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
             GDBFeature *feature = arm_gen_dynamic_svereg_feature(cs, cs->gdb_num_regs);
             gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
                                      aarch64_gdb_set_sve_reg, feature, 0);
+            if (isar_feature_aa64_sme(&cpu->isar)) {
+                GDBFeature *sme_feature = arm_gen_dynamic_smereg_feature(cs,
+                    cs->gdb_num_regs);
+                gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
+                    aarch64_gdb_set_sme_reg, sme_feature, 0);
+            }
         } else {
             gdb_register_coprocessor(cs, aarch64_gdb_get_fpu_reg,
                                      aarch64_gdb_set_fpu_reg,
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 08e2858539..047b1f8133 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -249,6 +249,91 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
     return 0;
 }
 
+int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    switch (reg) {
+    /* Svg register */
+    case 0:
+    {
+        int vq = 0;
+        if (FIELD_EX64(env->svcr, SVCR, SM)) {
+            vq = sve_vqm1_for_el_sm(env, arm_current_el(env),
+                     FIELD_EX64(env->svcr, SVCR, SM)) + 1;
+        }
+        /* svg = vector granules (2 * vector quardwords) in streaming mode */
+        return gdb_get_reg64(buf, vq * 2);
+    }
+    case 1:
+        return gdb_get_reg64(buf, env->svcr);
+    case 2:
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
+    case 0:
+    {
+        /* cannot set svg via gdbstub */
+        return 8;
+    }
+    case 1:
+        aarch64_set_svcr(env, ldq_le_p(buf),
+            R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
+        return 8;
+    case 2:
+        int len = 0;
+        int vq = cpu->sme_max_vq;
+        int svl = vq * 16;
+        for (int i = 0; i < svl; i++) {
+            for (int q = 0; q < vq; q++) {
+                if (target_big_endian()){
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
@@ -413,6 +498,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cs, int base_reg)
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


