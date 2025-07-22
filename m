Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF502C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 20:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueJNR-0001m8-8m; Tue, 22 Jul 2025 16:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ueJNO-0001jW-Jm
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 16:14:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ueJNL-0001tX-Uk
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 16:14:14 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MFEE04010551
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 20:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3+z+MyEDnNC
 sK1+S5AnwPFJtgMlSFxjWlXpFGSpjaUY=; b=IOGbtG1nfG9RhSeUMkba7TJYZcy
 WCF/2mbH3sywZBn8FsEI3HKT3g4mkjipCscTsgh66KM3NSxDgOGBg0H5B8Nawr8Y
 mlcusi4N+jncFThGZC/Gt6x3j/kRO/SX8RnYo5JZpbTbkkTY1gl2jHtrWJZrLhsO
 M7HdZPpdhJkmfguQot4ktfvKqnLYt7mDsfb5LWfqADZZO7x6KpT8RMeQZwrAi3Y9
 COygXTIauuemebzAfySvItL6oBBYRDfSYh42f+ZY4H+MYnX6I8yYiXgz6YQGvUaj
 B5GItJciA33Agcs2e9z2lSA5/xHyz24pnVNm86n0LR7pD0r9i5gex6VVPjQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1a41h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 20:14:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-235e7550f7bso61189935ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 13:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753215249; x=1753820049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+z+MyEDnNCsK1+S5AnwPFJtgMlSFxjWlXpFGSpjaUY=;
 b=dX0IpSFQM250MMFDSjlIIM1YKEHxJDhZ+c/RyE0VEjZbWGglXPd73+qL2WgGrUnuMd
 lmrVUbPNLwOjCcaEEgh0zbRoPE72aChKcE8En3leX2bCILaVl8q1y0cljiypogMGHmL2
 bfriqlQPxNY8kWk2DyCb80RMcWx45do6zDUKEaoSDQ3Jr4iBGZrut/AjHzyyqrfTfajA
 eQWn4MmSEZO5QPwCbcw32r9HU+NR7GoXmMQtBHQMgi9wcmE6YoMGRojdSRJPU0H0rOHO
 pWFfMYxmsxJyWIc/9YYxfAUaTPUPnwdFo0dA56mxWoJxtTfy7ZDEN4JuB7RXZ9f8p1r9
 9j1A==
X-Gm-Message-State: AOJu0YzXPAhlyoP1F0GXJDoYIPKnzIlVYNLFpdgSIzKa1TY90M6wtn53
 3WENZWftU/cmc5pUr3+y3iJbdpLjj3H18wlLYYsv6H5dhYT06uu73RExR427gYBhllBv1rUwZdo
 sS8lrd92H2vC5yDVI10uZ5rvPoSy57K12n9Rum+FmcbvRsBN86Zp55UAn7pnoBXvoBETe
X-Gm-Gg: ASbGncuKPFUjTEhqp8WZtGx/QxMvZniZuJGj9cXTlgLKLZ3Z8xQfJWgJxhAIrkz/FcG
 b6goqV2N1jqUAewGhxrEaAQAtvOWSHl+GztvISmM4kxz0WMAm1/jn2uVEOwTdvQ4j0c0p0GJlJa
 jT2bYpUMcJJXooW/QGdiAcYC5F6D3q5kRUJv/HBkvToI3XiCx+hNHeBSRmJiHDyw4FDpidwJMV/
 pwYpcW6b5XNKtZqwjqQ4DOW0N5F8Yf3+slzYvbQLEEj4QP5WEHS+85dDJYwD/EKN2SgmTNg3uC2
 nznOKViIoAcuntCYg0n+wyLulLedOPCCkD5wPFfwPNI243XniyIujyac4gXBsfhPqETecSFPtvp
 9m4IqNr1C2D/ArQA=
X-Received: by 2002:a17:903:2444:b0:235:1b91:90a3 with SMTP id
 d9443c01a7336-23f98161932mr3639855ad.7.1753215249236; 
 Tue, 22 Jul 2025 13:14:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq+KgQQBzewVBMecKnTlcJwcB7VN/6nTomAdxGTjHaCvd3lmoe21pBn1vq5LojbqBHjSQBfw==
X-Received: by 2002:a17:903:2444:b0:235:1b91:90a3 with SMTP id
 d9443c01a7336-23f98161932mr3639585ad.7.1753215248771; 
 Tue, 22 Jul 2025 13:14:08 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6b4a9esm81917075ad.93.2025.07.22.13.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 13:14:08 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v4 2/2] target/arm: Added support for SME register exposure to
 GDB
Date: Tue, 22 Jul 2025 20:14:04 +0000
Message-Id: <20250722201404.2368507-3-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
References: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MBg7mmq1BzQ48g42TOGHAI1i0AurJD98
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE3NCBTYWx0ZWRfX6rG8LlF7HLWg
 g+qpf7WL0/dGYhJZdpnPwZ2xZbl8Aee/n3Iei7QwRbzl1SO50NybOvQTREoji0k50SqXts6Q3Wd
 B0i08scfnzJysVopY/QJFmyB/dCm9pR28O128qAtZ/xYlGKID4bcBV/GqJNR+Pm4IpYNClnTjl8
 nstoLW9VnIhCSuD5Y80WveLCQB7WimgrRZSQLmZdg5mBo3g/SuGv4TzNcEPoXXtCXQZhKq3k1ZS
 LBu7LdEpdyzykgUE7yaceb5NO+5nHU+LbRn7agTtxCn5zjsUvkZ/sO0wjYs8VktQs43ZITUP7+L
 GvUHLxUgq4JMG4IEh3l0dzfs6b2+gtWV10FCqGISkPzC5vVzNJ6rG4JFunEdaeNcybdg/ndMY2p
 TMzZJrGmJPbFPDq023OE7+TnNM4hOe9wCGVq+0AsFcsnTNFHeuLBQ4ldEmtfxyb6QPCPq7IX
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=687ff112 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=BNg5ujFbbBWOBbuzlAkA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: MBg7mmq1BzQ48g42TOGHAI1i0AurJD98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220174
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Changes since v3:
- added changes to aarch64_gdb_set_sme_reg() to address the concerns 
brought up in review regarding endianness

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
index 64ee9b3b56..3d86980bc9 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -228,6 +228,91 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
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
@@ -392,6 +477,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cs, int base_reg)
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


