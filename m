Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF6ECC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBT-0008OL-Vz; Thu, 15 Oct 2026 15:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBI-0008Lj-PL
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBC-0000XV-F5
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:31:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFcWER2416877
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 02bvB7Z4LY/1eHvsMdSAee1XUAj9Tw4I/khJHs83o9M=; b=YxDEbrtnDVl9Paoi
 LqhcInPXXvP4bo1WG5bGd7I+bBxoct6LOhuj3nLqR7ase/fK9DxJYjrTa0kzrahq
 TkQ6+uIoaw5WLBjrXAd7wDdgYT9oSgfZDvhRHOjOh/VugjOdvTQTiXqXqcYjIjq0
 gfWE+XKvO6CrAHfPXO8Sym9bf/Hg8LchGKP0W+AjpHwW/tZQJ1NOdOPDxHycE+90
 1KLsQWuy8YHIybStv0xJ3teedOTvYyX2TTTHZTupj/dUDKpIoR4oiK485rEqPkie
 1y5adWKq85nL14BUUIXTC0pxiMfSwvRRtGv4vk8Tc7h0cLgcQBzHUmK13SolT6LI
 i71Fww==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhkrvb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso8406930eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092710; x=1792697510; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=02bvB7Z4LY/1eHvsMdSAee1XUAj9Tw4I/khJHs83o9M=;
 b=Adgk/CIeA9Go20GIKWBlMh0QuVaKdULjVMdEfdR+XiU3vKnC9DgcGJMjtOHkXFt3+Z
 w93tzF3A8inf6cZoUAoTySzCvHqNuOneXDMeUF74ib3PpE4CdWd4DPItQtdELkUDdrPE
 p/W8GrYFux1RRePRTfyA/z9D6K437JEZ/B5GS3nsaKo7a18FcVrE0hTlWpuuRR9VeRKY
 aHUhrTXvqmeSkOpcl/qGNdwVEQAcgPz9dpIlJaipw1MDedWatskNKaeNHa9eONYt9bLf
 w7lezoitFBLNnA6M0MLlSC+tPuaxQ76K9FjnRgBt4bduh7zQ8RvZhSXM3EG2W49La0b7
 SIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092710; x=1792697510;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=02bvB7Z4LY/1eHvsMdSAee1XUAj9Tw4I/khJHs83o9M=;
 b=VrPTXNh8mN/yr65QW6Fgfc7tChYA6wOD6nmufRmBNsVitZJlgzmmMBwjZVLzPmmT26
 bhjYGW3KPLCwM1RNP2NuxDPrCEk/lDfxJmclr/i9qCuSvAmTN5K+bHlNudk1N7L+Qzjs
 HlgLIfKHQIwQAni9NRSI4nDPmHx6eDe4EGekf/apCm/W9/7Q5NAsyIYCRMuB2Ggu1tPf
 56v0XRmFW6y0BMnHucVSLI6rFg7eysYrDs4xEAnqaPaOwBwtz1aQcCR3cdGKrZTf0nnN
 9GBl9dOXRo/OoWORQX1eF6+4H4CHZSlxJ02RND2t3mgjdwMwwQYOSGVKpu/yTRQ/qjsg
 4UrQ==
X-Gm-Message-State: AFq9FYKYg5v6k3Vgam2+QYJaTyD0GEppxzaBJVfTd2NCJoAK8gzs2tWw
 yt++WJIZKbSXFFbAxubHUjEshKKOd5gafavo0Iu3BasgiKDtOLa8pMupvT+R5o2iw832lcaZnUC
 HBR399MG/PtM8xzsgS3cJGV+C0BDTq+7ctU9Xe049BiPEPnk/f0kr/wolasNbpqQWSA==
X-Gm-Gg: AYBFou1kmGECobdBEm2u6/ebPcVRRn5ghYV++zePwf4i3PFH0Snse/xrQTfglDHmrVn
 Dwl7dEV6/euYi2Uge+s+15HJsrm+CbJ2zMEae20ZKLv+q5hYioK1VgSDT3ETKC87Xty7B/Pn6/4
 jcb2XsFdc795e+HbBB08lEwlSr5ls9vAhho1dx1CTLrqujTCbpRk2vLnQt3aRVCk1MJgKNNx/jY
 hP8cqw49ajXpCHn52tHquxsKnlImHhFgTqW3stZXO7RlLQNjasLyeBeqrsLJI+REYAyGD+57pH3
 MjZkeLbpKFyvrMuFj94dU+LSoA2oF95befOq+uePaSzcapiYffngYVrlcacfc1O+0RaC2x20nB1
 bq2SF2yjDXB8akDNTZIpI34sH2qW9HCCGY6XVGoSs7XB5OiyTsyJE+MKVlNHG
X-Received: by 2002:a05:7300:fe46:b0:35d:b44:a52 with SMTP id
 5a478bee46e88-35d0b440cc5mr9570588eec.24.1792092710387; 
 Thu, 15 Oct 2026 12:31:50 -0700 (PDT)
X-Received: by 2002:a05:7300:fe46:b0:35d:b44:a52 with SMTP id
 5a478bee46e88-35d0b440cc5mr9570550eec.24.1792092709839; 
 Thu, 15 Oct 2026 12:31:49 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:31:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 09/20] target/arm: declare semihosting ops
Date: Thu, 15 Oct 2026 19:31:01 +0000
Message-ID: <20261015193112.145326-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfXz0SjIl4JLRQk
 xoNfKV4j8NratWQRkFjGM9LF98p8l2qUR7Qie/IJ5wZddK3tc+bW6JS3XG3wmw7Ndiuzt6X2zBa
 tRaPXUr9aDnHksiJsV72fp/geKcwk9MTJYsbAZ10vYuKXSbdov/a341k53y5pw0Acgs8HNqnTyC
 ctDWTRNLJnmInb7ul5zfUcb7xFPZ2FmeTUXsZajk8Mm82HpFkKhGNrxnEa2aL96D+5R5obqck4p
 dH0bAxUIDQLxnj3wO22zIU3toHj6q8VHD/QsqZa54IvelUjdk7XSZY09sXQ11NwH4IsNo+EJ96o
 K5JpMOEQvhULDR3J1RQmFp4wVinW4ojG3mI4FKPiA4OqGzU1Hxgmch7eUI3LZnwHF1dTfsnGJz4
 nnCqO2HtkJtpsmgYKcMulVpcCT8wHFj/k1LtL/4/4jczXJJZLi6+Mdah1zJB+Cpq+AAXJpsAPPn
 dUUuggrVDLinLZ5nSXw==
X-Proofpoint-GUID: CL_rfNXJ_WmrCRNlnEYjziNncNHW4VG-
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad12a27 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=891gjW5_EiFNocZM0noA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX0KcTQnDBKug6
 gZTrcNWITDQpZK2utm4t9Q2L9EWZETc68Hqek8QXk6AJeDXuN331E1UR7Fp20pPeAPOfZCCRCSg
 Xh3Sv/lu0I4aC7Nz75bKtGmdrFQAz7M=
X-Proofpoint-ORIG-GUID: CL_rfNXJ_WmrCRNlnEYjziNncNHW4VG-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150077
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261014210526.104215-10-pierrick.bouvier@oss.qualcomm.com
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


