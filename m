Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A224CC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6Ai-0001PC-Ep; Wed, 14 Oct 2026 17:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Ag-0001Ok-S5
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Af-0000iX-6S
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:58 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbEiP301154
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mZSsHV2acar
 VtMJ9kUWF/qsX5yLpbM82FWoGZN6JASM=; b=WGNhOcAq+0uoUpqQlpgY8OxlYKJ
 vdNYPXbJbRwNq/G7+7lymAzugDGxT3EgR4Ep+wfO5zKyVyaWLTNHMYWbMd6Cmxk+
 jzXb3IDPamaIcndRmdKNlb1JiEP49/K1dtdHuoP3FxshevMCZwkeKjztsmg9ZOis
 6nDr98z/Vyq36PuOHg0wJWEW7CIm9gLanJL+UEu41AmUZNwP84cPKaz7832RXMyq
 1SPtL1GFG2Z7WkGuabHya8whzrBRWaMUNUQRcHCu8rlL69x2j9UXz5hyOulEGU4j
 Z4HHvIkotAudtAUSpkJjh3VNblZI+6fn53qoRSwiBZcaEuZkQGe2ZbA3wXg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4623gqv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:56 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so9338213eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792011955; x=1792616755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mZSsHV2acarVtMJ9kUWF/qsX5yLpbM82FWoGZN6JASM=;
 b=jlKABKLCi1Rg+8oEOCwfOn+subLJ0cAS0hpdUWYRBankUE5Ly7dxw2maZRO9UrPy+p
 rsYBc2Gs24ydXE83+UqdAu2k/kRvS0XDARgApOHFpN3C0gyZRnU1B0+zCiPDkrcaW0KW
 plOmZ3/VZhU2hebWnNK2mBWUpY26wvAVsADa/3DiseT/r6i+HRm5ejRW/3k7bOTQlR/7
 Tg48g8B4EyqsXX45w8tQ5BDwXwGy3mEMRYOL6rlJX6lCbWv9dqhrxOlayu38QP1x7sWM
 8NKqZP1sp9M+snp+gFaHDZZV+c1//LR5MWdvfg0V/j/YSEbUWwMRWNIDUXS1gAVBe2uO
 0Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011955; x=1792616755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mZSsHV2acarVtMJ9kUWF/qsX5yLpbM82FWoGZN6JASM=;
 b=j3a1LoqBKsvwnwjuEhiOboWSf5NXlUceWGxXCPTiT7L+p6okaCOdnHbvfasKQ1LOm8
 WNr9cmVwJmNinRX/OFC2ZwbLEhFaCD8tnisOKFIa/3lTupXQPrGPlU38gxuau+rndjwF
 HgwcJq90HGC8XpwENwse0m512A72ztx2Zm+T+gYlQFOn2TzNEl7PZugvFdwc0Lz2ogXn
 jCkVhorXMyLNKYGJBGEQEaLUY3Bt+gRi94dwCmcnxGxsAipF+GcBY266/U9pOpQgo13J
 aQtNLtRmfHvSU639NfKa0dcrZmMtAnzVQeWnfFSHW1/srPd4qQfefdcFw1+tlMc7C3tl
 sZHQ==
X-Gm-Message-State: AFq9FYIdHYnFD0ax3D0S2BpootZs3WADXQ1jcCuLhzesiywXMRbHX4Cb
 K/cGEvyBtv5i11sSdzXl/bCCxkxtvHw1SHbE3r+euNGhRLyHP9nAStSeL+NkBgOh39XnI3gGxSx
 bFfMTv+lOhvcxWhp1c6521vMjD0UQhSU4VnJxzvPV/zdb+fRRQMHNzHuBIsSbmQ6wrQ==
X-Gm-Gg: AYBFou3dG4tBmIutXAakk+7qJr6tQ67iu5vZGYVrUbgWc7QzeqQlC0UatJFH+knwsqE
 JFRhO6EE/f5nKQMhOFCa0eOSkxcoeNKuOQ8LzXzgRAm0Z/PJ4o5gPKc1M+QL0ng6LICaoO0OP7/
 q4YoH4HVUmzST5ZC6o2LZQU6t3wAzd2oeG5IkHxkfr9H64P+GkP/BMzbUhXR2J8x/lTx3DlRl/e
 3ZZl8YkmUUNwRTFK/kbPMXoqh8o6uVO7Re2i1YSXGQF8ikQr/e602YEcCQTeynAQc7ZwNXd5Uxp
 9ihMkgvhKz9hY/BqIwhyE+cvc2aGmuBOggk+0GFAOTg9wDEvEiaplSrJ5k/KBtSfmpCJ4+D7Cc/
 B+JvGBy26IQT4DDK9Q477Sf87O0sYbkNwHsv4IWR9w7WzfQXo/U1iP6ZEvx/B
X-Received: by 2002:a05:7301:53c1:b0:351:5cb5:53f7 with SMTP id
 5a478bee46e88-3537dedd531mr23835744eec.3.1792011955102; 
 Wed, 14 Oct 2026 14:05:55 -0700 (PDT)
X-Received: by 2002:a05:7301:53c1:b0:351:5cb5:53f7 with SMTP id
 5a478bee46e88-3537dedd531mr23835720eec.3.1792011954497; 
 Wed, 14 Oct 2026 14:05:54 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358ee8a3387sm46562092eec.15.2026.10.14.14.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 14:05:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 09/12] target/arm: declare semihosting ops
Date: Wed, 14 Oct 2026 21:05:23 +0000
Message-ID: <20261014210526.104215-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: M9qoIsyo8OaeYqztxe6rEeGhz-gP-oBZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX5rYCUpr2V9M+
 wMWvGJJlOfIScPwEeADf6kSkZfWbeBh8BMijWw4HjqE76TnyGgIQ7mRjbPXQyQMc96KdOyqoChy
 doUaGA82M38hn55AbOx6SDH4IpTPxjGM8QOC5nbuHCCMInWb9fSpXstqZ2oJCoqWovP5VtD0108
 w51I9oOnlaxtGnbX9OPm7G94f/KpXa4E/GFNfjdg+/KYC78oq3EaZPs8uf9Cb0Fdf3gxgMQhEDU
 0YaGaA2h1/B3wbBrnP5JwIOwQKvymRJBEYvHC0N9mLv2kBYdFGgVZMfuvqUnHQZFhgxLN6QU8cz
 y14RTXW2Eqq1F9DyfXLFfgVJSW8L3PQ+wwb8M4eFG50Dcl6sT0EhpugotMqTL4CmSil4mE90hdv
 x/4GQo/hgzxJTUUF3CQ+CfiuQWTf6Kkr9EHj1quI5yk5AN9U1QH3jbTGnWIHJvuOBpau8V9xuy9
 FPPs+psui7rm/pf5YyQ==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acfeeb4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=891gjW5_EiFNocZM0noA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfXwZYGAV0yCp2B
 qOMp4sbgSUvRb3qgP4RsDUEWnbrLaDJ/4pwcykrdBCv5bOcYqfXEaUIsXv0ClKXQQbAqrxth4ks
 fV+odN45EernnCwf/I5s8al0753FBRA=
X-Proofpoint-GUID: M9qoIsyo8OaeYqztxe6rEeGhz-gP-oBZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140084
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For now, we keep the global common_* symbols defined.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/common-semi-target.c | 72 +++++++++++++++++++++++++++------
 target/arm/cpu.c                |  4 ++
 target/arm/internals.h          |  2 +
 3 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/target/arm/common-semi-target.c b/target/arm/common-semi-target.c
index 38d52deb3d6..dc5f277a59e 100644
--- a/target/arm/common-semi-target.c
+++ b/target/arm/common-semi-target.c
@@ -10,9 +10,10 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "semihosting/common-semi.h"
+#include "internals.h"
 #include "target/arm/cpu-qom.h"
 
-uint64_t common_semi_arg(CPUState *cs, int argno)
+static uint64_t arm_semi_arg(const CPUState *cs, int argno)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -23,7 +24,7 @@ uint64_t common_semi_arg(CPUState *cs, int argno)
     }
 }
 
-void common_semi_set_ret(CPUState *cs, uint64_t ret)
+static void arm_semi_set_ret(CPUState *cs, uint64_t ret)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -34,29 +35,74 @@ void common_semi_set_ret(CPUState *cs, uint64_t ret)
     }
 }
 
+static void arm_semi_set_err(CPUState *cs, int err)
+{
+}
+
+static bool arm_semi_is_64bit(const CPUState *cs)
+{
+    return is_a64(cpu_env(cs));
+}
+
+static bool arm_semi_sys_exit_is_extended(const CPUState *cs)
+{
+    return is_a64(cpu_env(cs));
+}
+
+static uint64_t arm_semi_stack_bottom(const CPUState *cs)
+{
+    const ARMCPU *cpu = ARM_CPU(cs);
+    const CPUARMState *env = &cpu->env;
+    return is_a64(env) ? env->xregs[31] : env->regs[13];
+}
+
+static bool arm_semi_has_synccache(const CPUState *cs)
+{
+    /* Ok for A64, invalid for A32/T32 */
+    return is_a64(cpu_env(cs));
+}
+
+const SemihostingCPUOps arm_semihosting_ops = {
+    .arg = arm_semi_arg,
+    .set_ret = arm_semi_set_ret,
+    .set_err = arm_semi_set_err,
+    .is_64bit = arm_semi_is_64bit,
+    .sys_exit_is_extended = arm_semi_sys_exit_is_extended,
+    .stack_bottom = arm_semi_stack_bottom,
+    .has_synccache = arm_semi_has_synccache,
+};
+
+uint64_t common_semi_arg(CPUState *cs, int argno)
+{
+    return arm_semi_arg(cs, argno);
+}
+
+void common_semi_set_ret(CPUState *cs, uint64_t ret)
+{
+    arm_semi_set_ret(cs, ret);
+}
+
 void common_semi_set_err(CPUState *cs, int err)
 {
-}
-
-bool common_semi_sys_exit_is_extended(CPUState *cs)
-{
-    return is_a64(cpu_env(cs));
+    arm_semi_set_err(cs, err);
 }
 
 bool is_64bit_semihosting(CPUArchState *env)
 {
-    return is_a64(env);
+    return arm_semi_is_64bit(env_cpu(env));
+}
+
+bool common_semi_sys_exit_is_extended(CPUState *cs)
+{
+    return arm_semi_sys_exit_is_extended(cs);
 }
 
 uint64_t common_semi_stack_bottom(CPUState *cs)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    return is_a64(env) ? env->xregs[31] : env->regs[13];
+    return arm_semi_stack_bottom(cs);
 }
 
 bool common_semi_has_synccache(CPUArchState *env)
 {
-    /* Ok for A64, invalid for A32/T32 */
-    return is_a64(env);
+    return arm_semi_has_synccache(env_cpu(env));
 }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 10ac6c98318..81ec1ce21c6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2663,6 +2663,10 @@ static void arm_cpu_class_init(ObjectClass *oc, const void *data)
 
 #ifdef CONFIG_TCG
     cc->tcg_ops = &arm_tcg_ops;
+#if !defined(CONFIG_USER_ONLY) || defined(CONFIG_LINUX)
+    /* semihosting is not supported for bsd-user */
+    cc->semi_ops = &arm_semihosting_ops;
+#endif
 #endif /* CONFIG_TCG */
 }
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index c41fa5225c7..e849e357cfe 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -437,6 +437,8 @@ bool arm_cpu_exec_halt(CPUState *cs);
 int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 #endif /* CONFIG_TCG */
 
+extern const struct SemihostingCPUOps arm_semihosting_ops;
+
 typedef enum ARMFPRounding {
     FPROUNDING_TIEEVEN,
     FPROUNDING_POSINF,
-- 
2.43.0


