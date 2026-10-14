Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF405CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3g6-0003xV-IY; Wed, 14 Oct 2026 14:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3g0-0003wM-1J
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:26:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fy-00020S-4Q
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:26:07 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEag0c500329
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UVa87dixBlp
 Rh2Au1pn+bsU4tU0Ggl/KycsMUOQx4UA=; b=ISq8bf4Tn7fTPpzPZEOK5/hbP+H
 bVGq+GLC0FbCLwuSKbSIvACPI6Ld/KlaPL3tvO1lvZIN1tIe4DiH6Oa6L9A2WArj
 aPKj8PtYwEjUcJfeR6bkG46ItvcW2cQIziWEQOu19NQujkcY1X/zimlfFbe/1EgO
 6zNAyYmH0932BKe8B/Z/ODvXrz/m2P1Y5dKWOZRMJn+qSWyrPocbwP8NyWkyDkNJ
 7NgbSgE+YcKx/hU5CULRiUPVKcrVnxa/u7n/B42xrnpqKaPcJmBTHz9/WmQ9pAhi
 9tmDuDjyjil7F6UH+Pu7NDT4pwH3FFsE6B2PzFC/RATj+8I66MvlslGeCkQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf186c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:26:04 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3425098ae4bso1867842eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792002363; x=1792607163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UVa87dixBlpRh2Au1pn+bsU4tU0Ggl/KycsMUOQx4UA=;
 b=FayDBPlLo7u2sYuH3Q9yWv/CEL+7dmGxjeKc+r1n0Z2Djkv/PHAxX6bVh4UT+KSYQk
 sClXu4SPT8vmw32kwGkrWB/82XUjwKzVGHD2s8Tbi1ZpV2cJYoSJWMpiQTt6f0EOeZD2
 O802CTwEbZVKxyzaDLX4Qd1070a3dulKYAM2ocITZGTVCe7WilbeeXlFVA/sodnWY0tN
 ltwTQr7M0FYnnU5jqYhA14yZrmsOf3Ud/v+YfMNO6CtVGUqD53iGlJbvZNiClDkrhdG5
 fSDAwqBl45Z41EDM5c/ubS+vozZFR4fCC74t5jif967NwbUNm0RMb9DD/BmWvS0huEb1
 yitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002363; x=1792607163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UVa87dixBlpRh2Au1pn+bsU4tU0Ggl/KycsMUOQx4UA=;
 b=X88InknW0QQvSNR2SFluu+msMiOTxujR0o5KDS+CVkMYEXyU/RsidhOa8HFiJI+1o0
 4UW5xBVqlE5Dg6ACczvCPaOSlQgbN2DEPG6rFmu8SF+SN59obEQZgAWoCg09trIQZslf
 Xii4uzMi29tfA8HeNlITIEPSi/TiqXM5iHTSPC554uhw2WOdNRqSRFo3T/DPngE+hWTR
 wdiFIqSxf9GTYS3s5DhTd2Nrl7TaYo+IyRqQtXsVU65bN5kcWpDqGl8YE+4V/13XsSOt
 yYFjtcNajM6VHI9kSVCKWMRD9ga4CsrekCcYN+/lXfpe5oj8bofxZQrTr5K1WImRp7Xh
 5Lgg==
X-Gm-Message-State: AFq9FYLjYbi1UcPNpY0GoELm7WHv1OOw66f2Sj8hge3ypfu7Bx3U5yqx
 cvfQBvjLCDnpDeCCutaTb3JO6EmbVGvAuxV247xJ/N4MCG8PqGi5hI5m8KTApCwlTm4mvbzV1dS
 /7WW4hJkOZxYSbGb1VK5U9x2L23E1Pi85Hu7jhMneVyfxTxDhtRhjSleLoZVVptFx4Q==
X-Gm-Gg: AYBFou2XiM2ufdxMDKraU7YirLiLdS+8tMzJtZHdv7fFu8qLSbbhD1wRWVJen1Prmoq
 JVNjYEyCrWW5/jj1t35onnQHYtKiXp0x4X5/Zw3WnCnyav98lfvIDAhwXu6E4oyciQ+oIJoDL1e
 bWiKl63Ww4vGHxITTsJdpVBtR0WEPqLlno0qBceekvbmxYzTGVk4WdprFoMaoOY7zzjR5gApxm4
 133yxo/igWwDLDg/GnhUsudVHMiysHAr/68ks5j4VLlk/R4cuRfX3JLpB1eX5YAQC8vt7sNB0pk
 O1kUMEf9Jlpn59WLhM8G8xqLoYsdKdPcqtGR19ZruPtNXVrCHkqEUkgzr+vwNLzhSsS+cJya0z7
 WciHmhnbYVnLMq4PeO2yrxcaNXOaoA/ZQ5aySQJnmpGMqXBg3ywgwJLOteLrz
X-Received: by 2002:a05:701b:4284:10b0:146:84fd:7b58 with SMTP id
 a92af1059eb24-16a10f2a74fmr22708592c88.9.1792002363278; 
 Wed, 14 Oct 2026 11:26:03 -0700 (PDT)
X-Received: by 2002:a05:701b:4284:10b0:146:84fd:7b58 with SMTP id
 a92af1059eb24-16a10f2a74fmr22708556c88.9.1792002362322; 
 Wed, 14 Oct 2026 11:26:02 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm62348223c88.16.2026.10.14.11.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 11:26:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 08/11] target/arm: declare semihosting ops
Date: Wed, 14 Oct 2026 18:25:40 +0000
Message-ID: <20261014182543.135965-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfXxrxOnW3ZS4bY
 B2LGhxQokGLDvxL5fJFgeZ/yrzyPMIwvb2Z6huQj2kJbXVmmdtgc1NOZ3pXE/ALG5GgLNGXU242
 r/VA6IabrYyfWeVMHvRjB3zeXA2+RgMvZWgpjyo0pdi07H+RR4EnEOy41Ei5pqE7Jbrtv9cGiq/
 A0enRgwQYcLFd2kVR9uUm1MrZIrwSnqbnOpIJr4TEhN23I4rwl0Kcu9HZfbdaW/SJNjtjRDxprc
 ywqOQH/C3xxmJMQDxF+jisfXSYvGW3Lyst5tsU5t8O/AobkeqOa8qJk6oMzJ8NUzcPCtg/hVLOk
 XbJ7147/lAcZBhn/IuPhpqvtuUQPVwut6ulwSYnKESQSezylHemPLZteXEavmvE275E+GBXa6TO
 wszeNYm05gppMEaiBChP5ZW3Ahv7yNQp/yi0fI8Z+y2EHAXXhizhjybcwLWjpLU4nEdJu8SkzfT
 KNCksAEb5CToCFRPCIw==
X-Proofpoint-GUID: 5dxkRELhmrcW41P4r5acso9MmXJXTs0z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX/g76lamkwPTL
 VFXiYya3k5rsvfC6foXL2eNY1gWJ3CaH4b/D4VYf4SMW8zmO4tYTdtwDP4mHBFuxFIvtw/Joerf
 sWR3BPSdyDQwwsP5+HN+hZiu7ToUXhw=
X-Proofpoint-ORIG-GUID: 5dxkRELhmrcW41P4r5acso9MmXJXTs0z
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6acfc93c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=891gjW5_EiFNocZM0noA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
index 38d52deb3d6..5263c0435a8 100644
--- a/target/arm/common-semi-target.c
+++ b/target/arm/common-semi-target.c
@@ -10,9 +10,10 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "semihosting/common-semi.h"
+#include "internals.h"
 #include "target/arm/cpu-qom.h"
 
-uint64_t common_semi_arg(CPUState *cs, int argno)
+static uint64_t arm_semi_arg(CPUState *cs, int argno)
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
+static bool arm_semi_is_64bit(CPUState *cs)
+{
+    return is_a64(cpu_env(cs));
+}
+
+static bool arm_semi_sys_exit_is_extended(CPUState *cs)
+{
+    return is_a64(cpu_env(cs));
+}
+
+static uint64_t arm_semi_stack_bottom(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    return is_a64(env) ? env->xregs[31] : env->regs[13];
+}
+
+static bool arm_semi_has_synccache(CPUState *cs)
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


