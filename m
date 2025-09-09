Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CF5CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 16:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw0vz-0007TE-JK; Tue, 09 Sep 2025 12:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uw0vb-0007Oe-9u
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:10:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uw0vM-0001eV-Pj
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:10:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LT07030510
 for <qemu-devel@nongnu.org>; Tue, 9 Sep 2025 16:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=z/urZLMPuM4
 d+XgtAOiLTf1NrHdA73jaMLOUSb5buQo=; b=g9SZY5KZDIJrVu7JAShD2h37WaQ
 2lJVOeJNiYOItU1PY72AKftY9d57p8P+U9VGUnej48KeQKxHZ0uY5RV5uNjfOWum
 uKQxmCoKLuK6oHtC7e9b8PX6PCrAHj2eQGIZdGHZOiBUikQRhX0p4XgrB4gTWGe0
 t2Mc4r8EMjOiSdomNCoEfpNCfcg2S0248jczsofk3kmZ4E8FINr8Fm/zMlAiW2KZ
 EgWx6P4uXCFh53z53LAWS7roDr144zO45I0GPipekfIuM7uj4+rSnoh5uaKHOhkY
 1IPszAs8KSomLacytjTYEvCirB/F2R9Nj+597l0B+hWRC9IPLfvkREEvY4Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j8wvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 16:10:24 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b4f87c691a7so11205760a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 09:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757434217; x=1758039017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/urZLMPuM4d+XgtAOiLTf1NrHdA73jaMLOUSb5buQo=;
 b=kBovytK4rcF8dWxNZyqj9zhsNfa/dO7byZ7yx5UrweG9DIMdW0ez4DGzdGj0r2F5cl
 0OgATMdAYaix6dgFjkoYUX+rnl/rAbJ5SXMv0/aYPr1VhjV2AQeWe6LEcGcktHir9he7
 6xVZ3CJsDfAl90+0GKWUJVGGTOBytS2Kx5WrpMC6aK/6mee/CdCGN5ayJNSGSL2MhWH9
 /s9xbQ6AHjkIaaLHHAT1SX4gYl28ZdhT2j9N6XHU2yAN7wCWLKHmVz4ejqs+2mXOaJD/
 up7NBOO0SE8bf2MKC43aQAFfAQPWgcvuAovDjxQMD5plm3X4HT2/AHrmNLJYyXzkLZo3
 Cfiw==
X-Gm-Message-State: AOJu0YzKkQswoxm1c4eXg3mgxFwruGXVZaoMBG2VlMQ4mANXNrpaw9CA
 kC7W2SR/AK88J3/83rgQGAENts8cYAXNDQ6oeoJhhYJMgBzkfEaBYVMVJQzfGbp51x48xPhA57W
 /Ja1RhJ3xIv1XjornTxnEM3aH+xvJj5dJWV8KxeEs961ozuKk/d9CmR5hTL1CXQlo9WCX
X-Gm-Gg: ASbGncuKF67/118ZkJ/KztB0dtchiQsXxu02duQfvBJq1Y/s8FU+O+IQKnmx+hmmtA2
 H9dJww6bXlDHGWM2PO96aJIqWn0QeuaskbY/v4hgxGcvkscSCT8zT8d5OsjZ8N/jbnzsllDWhKg
 zPZxwAvA6EDhmZ64YlafvbWo+fTT5uhEyOCvZRAERkK1I3qyXsVRyJDalHG3lk5AQlfwVnH+fsM
 v4DIw8+B9EVkAwi666c1GV93oYA8IReP8TJxgfPrkQYcfyilYL4Fu/Pabw2sHYFWH7hMuMBe/Ff
 ruAN3bW2YqRyGoFjrniwHml3OxXOojrXWzYhxJMAzoEurxDc5J9mKZmorrEvhv1H6iCpl5yY/YY
 AByWFJVKAk0Q1LjQ=
X-Received: by 2002:a17:902:ecc8:b0:24d:a82d:cbec with SMTP id
 d9443c01a7336-2516d81a17emr200743515ad.5.1757434217164; 
 Tue, 09 Sep 2025 09:10:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXUZ0B85u70sgpyVNr3d0e9E0VVeMeuQ/UsCske3GSUNFZsvVu+hL5jDqnWwtZU4crbeLGfA==
X-Received: by 2002:a17:902:ecc8:b0:24d:a82d:cbec with SMTP id
 d9443c01a7336-2516d81a17emr200742905ad.5.1757434216666; 
 Tue, 09 Sep 2025 09:10:16 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25a2a43a9bcsm1794975ad.89.2025.09.09.09.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 09:10:16 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v8 2/3] target/arm: Added support for SME register exposure to
 GDB
Date: Tue,  9 Sep 2025 16:10:11 +0000
Message-Id: <20250909161012.2561593-3-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909161012.2561593-1-vacha.bhavsar@oss.qualcomm.com>
References: <20250909161012.2561593-1-vacha.bhavsar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX1jjhY+ywKi4m
 TBf23M/qCN5Y9Nl2WcZrN1RAqwl8hD7h8iCcPBK4jEE6vaGD4zP7P6xL5rQzneAr6JjMn+hJmPx
 8a4KzbbZ0TqTrhwictWX49zSO1Rjs69TwxNZ+uLwLRE4IS8wRXOmJhbjlFf85CzYUJGpVMRIE4A
 g9kIhyampEq4zeNXegucfLDz8eEPFROIp+nyl8Q20vKgHutdHjQlPC233ggATIoclfYDdMQTJBB
 dOtTLfLqEHzbUOeJKiLrm5oEBPxi/g6QJDwQzYc+/YyMWIUi6NhNyAWyFtlTgKftT/yIlTkYjHl
 Nc/LSTeuq77vuyMqhP1H/S2HidN36dmunwU24MPQegvxAUV7WOMve3yk6klm3jy8uVstWrleYD1
 7Y4As2qV
X-Proofpoint-ORIG-GUID: lH0Lu5gXCcnaxruJ0_hJoIZ96w1qQ2au
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68c05170 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=BgWsvkvSDKOZz1aDhXEA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: lH0Lu5gXCcnaxruJ0_hJoIZ96w1qQ2au
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


