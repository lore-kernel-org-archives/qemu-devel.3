Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359BACAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 18:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvgc5-000814-8p; Mon, 08 Sep 2025 14:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uvgbl-0007yO-3H
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 14:28:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uvgbb-0001BB-Qp
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 14:28:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588HYUMa012376
 for <qemu-devel@nongnu.org>; Mon, 8 Sep 2025 18:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=z/urZLMPuM4
 d+XgtAOiLTf1NrHdA73jaMLOUSb5buQo=; b=SNgiq1hzmlCuC/AdZe/HnFMbOan
 PVjakUrLPRtRAXULOUQLrxc48fFtQWuY8D4YV9RhW9h/mQMboBuNO3aO3nESzP/h
 zByZiRooy+Up/xeJpaQrgolweYsrqslXlUxHxyHL+T9ZNXA4wlxik/Yl+ydmchEM
 UJgp1W3Iy7Hh0uZW8IgMYICXjsFozen7laU6SiFF2Q2COYd2EZu/RYc6OdJPmRDu
 MAA+SA58iT5zqBMbjREbHewy4hQIglThr60EYGwexIah8UAE2WKA+Jc3Upe0M2dV
 DVqWhMVuv5W1Dd7rJDQNQHEVCTGseikvcTq2Zc8gynWO0oGZR2FhYiYxjSw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0nkvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 18:28:39 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-77288e1ce43so4814210b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 11:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757356118; x=1757960918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/urZLMPuM4d+XgtAOiLTf1NrHdA73jaMLOUSb5buQo=;
 b=prfrUVjkV3hjKjd8ad/s43mep3ATz4QCl4R+a4cXZ7H5lKBvO1C1t7q85kwopW1nvx
 B/HAMk/WbMWvoM3hEHMYI/5bLTgOOATF2IKsvDlFV4G8ccQ4rhhzC9gYh6dZrCO/ggyp
 STlp9SmTEmYxlbNNkQ+i+VBAf32B14BRMohCNGVuBRkRT1mNJpaun3u5cRKzyU/39/pu
 U3yxti28fBMiHGmfHMWDruT49+Rg0u9REKEuoWwJKxbWzfxU6uOv+rC/WpQQ88jgxccx
 3zEPlcnDuZEN8Zvc09OPKQ7eKrFTvi5JJByJhic8jbjcFHKJ5yOxkuEOXhcdLetIfAQB
 MuFQ==
X-Gm-Message-State: AOJu0YyZ1BCobEKIg1qNbW4SaXwDWSqnqxRF/rH0ttWzV17Mkdbq5LXZ
 5Y+097B7yOWnilRR2Gl9mm4lCVf236DnjLK8COVIJ3krk249f/d4BkCzn4+RI9rbjGkcuIQRvjY
 5zGJl24dquZsl9KjBUNE/cgmUorCLii+LMMcVjkmKj8nuub38IlFevBPVEXXT6TkEVOI/
X-Gm-Gg: ASbGncvi8Jblcs7f39wKd8v2t2yM2oPeUzxo1g06bftXQMn4JflmzNpcXxqZ+2jwBCa
 fhbSO3qFSkX81jDzLug3TMDwTjLWlN6N2MtTNduchb1RdLVq7xa20/FrW1tEDoTE37OV9bfEHtr
 aG2lzSQU4IFLhzc7QJo4GlcVTTzEA9TnCmHhiESdgf1rR9rXjEXvzH2w1lX38oauJkx18ZryzgT
 bYTsuI8yo73W7OX6b/E64a8sDHLzSFKKUFmR2L2Gssxs0LpFWMUd+0VidfiP7b7L8Re5VQpVJC/
 6iw4BHD4g9XnizWzXr6B1HeQPB/rS0NZj3hxh1ScvcKl/VggGwe1J6AP7NOPyvCtZd0jKcbZouc
 Fdq2sznuUgjCC/og=
X-Received: by 2002:a05:6a20:244b:b0:248:ace6:7561 with SMTP id
 adf61e73a8af0-2533e94fa47mr13495000637.12.1757356118319; 
 Mon, 08 Sep 2025 11:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSfLAr7eWdvoqt3cZJv+c9sAbq+7ug3BCTWzjXPTOdJa0nTkB0ED/9L9F9kybe0qrMXDuRmw==
X-Received: by 2002:a05:6a20:244b:b0:248:ace6:7561 with SMTP id
 adf61e73a8af0-2533e94fa47mr13494961637.12.1757356117829; 
 Mon, 08 Sep 2025 11:28:37 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4f9c35f391sm15480164a12.25.2025.09.08.11.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 11:28:37 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v7 2/3] target/arm: Added support for SME register exposure to
 GDB
Date: Mon,  8 Sep 2025 18:28:33 +0000
Message-Id: <20250908182834.2476277-3-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908182834.2476277-1-vacha.bhavsar@oss.qualcomm.com>
References: <20250908182834.2476277-1-vacha.bhavsar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BI3RPajFKh4vqXNGmKEWVcCOEkz4halV
X-Proofpoint-GUID: BI3RPajFKh4vqXNGmKEWVcCOEkz4halV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX+YCA1xT+4cHk
 x9fBYvVeVy8CkY3n3C+iIHLc2KrFzFo0pzCp4EcpzYCgO2rIqpOCvtXCgh6P68WTvvVb7qYSqXC
 rKRf/+QLhJexptAJ/w08hH/0FI284ECKLviB56P3mPj3l/iZFOuqAa6NzcRaNXtmCrxx3j+VQtg
 SNJwJVnmPleDhczD2KJinIn3rl8KsD4X58Kic635Yp9hbbxWj2MhiuIqSLf5R2/ocV3w9yVFY6d
 Tp40koitFMNoDMG6OZyrYqvNXeO9RX+gqtaj/bUlcVS4IL0Yo2N3UkMVb1fATO1c0djottZjUx4
 4lT6MIwU04tDeUpLw8ySQLXzO5QcAImuwhgPBkmcocPmpyMeVg/J6+EqbHpfkJaLVJ69vs4JuxQ
 +D450tUb
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68bf2057 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=BgWsvkvSDKOZz1aDhXEA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Note that according to the GDB documentation the ZA register is defined as a
vector of bytes, however the target description xml retrieved when using gdb
natively on a host with SME capabilities represents the ZA register as a vector
of vectors of bytes. To remain consistent with this implementation this patch
also represents the ZA register as a vector of vectors of bytes as is done by
GDB here:
https://github.com/bminor/binutils-gdb/blob/5cce2b7006daa7073b98e3d1a3b176199d1381d7/gdb/features/aarch64-sme.c#L50

Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
---
Changes since v6:
- removed unnecessary comment
- corrected indentation
---
 target/arm/cpu.h       |   1 +
 target/arm/gdbstub.c   |   9 +++-
 target/arm/gdbstub64.c | 119 +++++++++++++++++++++++++++++++++++++++++
 target/arm/internals.h |   3 ++
 4 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c15d79a106..92808c2fe6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -935,6 +935,7 @@ struct ArchCPU {
 
     DynamicGDBFeatureInfo dyn_sysreg_feature;
     DynamicGDBFeatureInfo dyn_svereg_feature;
+    DynamicGDBFeatureInfo dyn_smereg_feature;
     DynamicGDBFeatureInfo dyn_m_systemreg_feature;
     DynamicGDBFeatureInfo dyn_m_secextreg_feature;
 
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index ce4497ad7c..cfde7c3a46 100644
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
+                                                                     cs->gdb_num_regs);
+            gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
+                                     aarch64_gdb_set_sme_reg, sme_feature, 0);
+        }
         /*
          * Note that we report pauth information via the feature name
          * org.gnu.gdb.aarch64.pauth_v2, not org.gnu.gdb.aarch64.pauth.
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 08e2858539..3bccde2bf2 100644
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
+                                    FIELD_EX64(env->svcr, SVCR, SM)) + 1;
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
+                                      env->za_state.za[i].d[q * 2 + 1],
+                                      env->za_state.za[i].d[q * 2]);
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
+                         R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
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
@@ -413,6 +497,41 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cs, int base_reg)
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
+                             "org.gnu.gdb.aarch64.sme", "sme-registers.xml",
+                             base_reg);
+
+
+    /* Create the sme_bv vector type. */
+    gdb_feature_builder_append_tag(
+        &builder, "<vector id=\"sme_bv\" type=\"uint8\" count=\"%d\"/>",
+        svl);
+
+    /* Create the sme_bvv vector type. */
+    gdb_feature_builder_append_tag(
+        &builder, "<vector id=\"sme_bvv\" type=\"sme_bv\" count=\"%d\"/>",
+        svl);
+
+    /* Define the svg, svcr, and za registers. */
+
+    gdb_feature_builder_append_reg(&builder, "svg", 64, reg++, "int", NULL);
+    gdb_feature_builder_append_reg(&builder, "svcr", 64, reg++, "int", NULL);
+    gdb_feature_builder_append_reg(&builder, "za", svl * svl * 8, reg++,
+                                   "sme_bvv", NULL);
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
index f5a1e75db3..df99a17448 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1820,8 +1820,11 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
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


