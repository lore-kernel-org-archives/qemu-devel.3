Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3A8C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 22:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubRcI-0005AQ-4u; Mon, 14 Jul 2025 18:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ubQ8B-0003A3-Re
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 16:50:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ubQ87-0002Mj-KA
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 16:50:35 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EKavAD002934
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 20:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=pxx2c/NW4zMEvhAJXdFJXHOVNFgTmC2vPnF
 rfmF7+8M=; b=OUzVN/i2aM3mp2QojUNYkwTXRWkFzrKIUpW10e176r/wzJMCBvC
 GNST/qL5ILwkSq2XRAlaRmeJMN/5GBJf6UbafGZho7ge6kbkfqtFrI+nOzh4g1eg
 u8SFPuqzKv0Z6+7Frq2wopUl+fp+cv+aEo3Y3poIZFelJUjyUA9kb5db4Ch3XO7/
 rb8E6GMdFE3fwOQrYU2j0SSmSCUUBjyjX6mPtiCkPjQXGp8Evj8xSX1+w6i7TSiq
 dW7rFhng/9iDXrO66C+pJh32TdV7VydaVQ0QDadXHLNb6rxoV+2Pbr1X4rCz+5+j
 IyYnFtKmsBJy9vUJC0O1Ll6LPabt7lhYl0w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufut5sv0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 20:50:25 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-74913385dd8so6831573b3a.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752526213; x=1753131013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pxx2c/NW4zMEvhAJXdFJXHOVNFgTmC2vPnFrfmF7+8M=;
 b=P7eH8IK1tDbx12slpRnMu19qWEPV8+uzHBtkM0yaHZzbMKM/HNdd+e9aZF+n8QonR7
 vcW9w4gSosjdLppD1LzEomEWrvNfSP/0OdB65A5k7mpzi+QopjLclL5Y4coKpr6bFnoj
 SVA6gWzC2p9LCtJuTlyI3ruKqi9enE/M90qZaO+G9BXE12Ip04EcRuYzh9lXOiuPPuAp
 nd2G3klvqbfI9oLIFUkWcChlqbnsNJouLgyUQdYR4TAmyUtQ5JY2IDDnOxzUbS4CePxA
 yeFxbl3hwdOeiYyowBQFtIE+jWz4300aNzZbS4b4pZsLcp7wyYlJ9l9I0p7qrhDCMOc9
 kUrg==
X-Gm-Message-State: AOJu0YzY/PmZC8Tp4IYKZWwhxQo0mjvf18CKfYB8MdlBdtOXjZWyxKX4
 ZshRzG/6ogpI8yRDwhEl8aU8Q7oIsLQ9aqplFMpEqKHsR3yzjHxijBLVmTtS1dQ7M4Icgj5EVBt
 DWovC5IAuXesVCyDfidiwJYVD1BxY4vQIkjslDsNdOr7D/B9eFR8ccj1JbS758bxG+Wxn
X-Gm-Gg: ASbGncu3Q32eRPaBqmX/OpIAUwp5PKb0Ecar2Tj3+VpgEFZbOqA8dBAyTWowoLdskr4
 eDkz5AVm+AGJCYKoeGEEUXV1sVhwkZffBiurW+dNhPbc3M742EEkOn1pzHGqSgUD90XVC3CS5ac
 BH/UVLrVKTK6ZF1ypl2sntOzGjjOXWZEvRI9tA/sqlDYA7LZSbWrQAegntsijm35swkULdW1IDS
 7QA8XuZ6/ri3kOoO+hHyyo3oOFJ5iXWBAXEauEam+P+xQgEQ9NLAdFfbwcYlkZOmfJzK6sLCsRo
 +fU2J++PGhquc0cGdKS6d1mVGuOsGSzn2pPN1fSM7A4J4sQ1sQ3UBrMC8h+rhtCMp3PRn3bMxz+
 CPmT7ahcSnlLXTjI=
X-Received: by 2002:a05:6a00:14ca:b0:748:eedb:902a with SMTP id
 d2e1a72fcca58-74ee2d5d7e8mr15675143b3a.17.1752526212970; 
 Mon, 14 Jul 2025 13:50:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrKZjYCIq85br5O3z4hRWG3ioyf+U7l5uZEMH/Y8jgIbXIrpYSSSvHfdckzVswEa7fM5GyDA==
X-Received: by 2002:a05:6a00:14ca:b0:748:eedb:902a with SMTP id
 d2e1a72fcca58-74ee2d5d7e8mr15675119b3a.17.1752526212464; 
 Mon, 14 Jul 2025 13:50:12 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f90d66sm10824034b3a.173.2025.07.14.13.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 13:50:12 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v3] target/arm: Added support for SME register exposure to GDB
Date: Mon, 14 Jul 2025 20:50:11 +0000
Message-Id: <20250714205011.955688-1-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e7gGSbp/ c=1 sm=1 tr=0 ts=68756d91 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=cPBEBSeHtjnCkXsRAdUA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: nyrutAYakjphIZjhuFeaZtUAXyd7uTrl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE0MCBTYWx0ZWRfX7nj+ihv8Jg+m
 MGfzyzLN6DQ+jSF8t8c+Y9xO3Q1pijQ936RETSBLpb7U/CVGFOLcvxn22KtU4suzZOCdnsBLSHJ
 W7IigBZprVc+tcod9N3KR5pzvSlN43PdPOEbr2nGARCWwjxNiQwz0o5ZNPB+WKaxM6KbrWOnEcX
 F2ZzhnI16BYDmSlIGf2BW8qYumvkXQaBjC03jQIUgmOE6D/fMUEAQC5Nw1HJbbNPEOntRbSoubs
 slcGru3+d+jgkcEUp9vODsh6376iTibqAZ/y4Cp+5glVwcfW6adpFquGdCIjEkeSUc2G8EP5Teq
 7qefzv5slRdO7891+h+7sRAhqGOIVBMyMMaFrYtK3gMcOG7y6wMwzlF1nGsTgxZg3H7ESKkYIjV
 Qkdsb+FI4DwKbuA0qS8ObST/MiJE6IfCkje8IVpFG7HE/G+ZK6obTRbPCzCbYa5GWJgrCRGV
X-Proofpoint-ORIG-GUID: nyrutAYakjphIZjhuFeaZtUAXyd7uTrl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
Changes since v2:
- Used FIELD_EX64(env->svcr, SVCR, SM) to determine streaming mode to set
value of vq in aarch64_gdb_get_sme_reg()
- Changed occurrences of sve_max_vq in the new sme functions to sme_max_vq
- Changed 'for (q = 0' to 'for (int q = 0' in the loop in case 2 in
aarch64_gdb_get_sme_reg()
- Returned 8, instead of 0, in case 0 (setting svg) in 
aarch64_gdb_set_sme_reg()
- Used ldq_le_p(buf) in the call to aarch64_set_svcr in case 1 (setting
svcr) in aarch64_gdb_set_sme_reg()
- Mirrored the q/vq loop from aarch64_gdb_get_sme_reg() in
aarch64_gdb_set_sme_reg()

 target/arm/cpu.h       |   1 +
 target/arm/gdbstub.c   |   6 +++
 target/arm/gdbstub64.c | 115 +++++++++++++++++++++++++++++++++++++++++
 target/arm/internals.h |   3 ++
 4 files changed, 125 insertions(+)

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
index 64ee9b3b56..c0fdac7e93 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -228,6 +228,84 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
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
+        uint64_t *p = (uint64_t *) buf;
+        for (int i = 0; i < svl; i++) {
+            for (int q = 0; q < vq; q++) {
+                env->za_state.za[i].d[q * 2 + 1] = *p++;
+                env->za_state.za[i].d[q * 2] = *p++;
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
@@ -392,6 +470,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cs, int base_reg)
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


