Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF33ACC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6Ag-0001Oi-Sj; Wed, 14 Oct 2026 17:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Ae-0001OK-Qh
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6Ad-0000iH-1z
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:56 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEafRj500299
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=W8nBezmzzAk
 kkBCqygEuLSSG71q39R4q1THhIr+ZwVM=; b=GvOzBjUZetp0d19jIIJ6yHgB55x
 fpF3yVvREff7PsEAKuAxlECgf1UYBD6UKZ/1jeySIa/dKgfdkwVWjaL4BsrVTZnx
 QlJBY0bmHDskbGDX6BlcLZqLSUWDR3KPesDcpz+5BNMXCwYfOqvokzxK5R1vcymK
 gBegS6gQcDFl3ysKYQycNRJeiNClmDFYPIu6lmbXoNA6I3wmT0r/uQSJQLtpuOW5
 Cl4maFzcjydGvLNLLko2eBEKDudGOfEDgj/ldGxjhSjpp8btlWdXoBTAAxq4QH+N
 qgCAWRUB1VdMfOUnF5AgG/k/pfUJlBE1qMkpj5WaCK3B1AFfDeplLU4/n4Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf1ryk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35a4d2e39acso355715eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792011953; x=1792616753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W8nBezmzzAkkkBCqygEuLSSG71q39R4q1THhIr+ZwVM=;
 b=Jrm64oVzlfLv0Jjiepq5zZayn58xT17n8bxDGiyhzzVzZGP/J8U768NmIcpl35wQLf
 Wu/9/gtYwcvSdC0kHsNemilzsoiBuSCsH3YFloBFoi65BUnX/qXTTYz5O8AppnME2Wa8
 1oRkFYd6ocOkKPagJSN50XB6UgxPE78OOZcDuCBHz71OqFZpayQfnyeDqdaePTo+2cID
 djgYxEHPPWgxCrKf8QQ5P/5B6SoiVRDNKRGIYVCxDraw4kUzdihm0bZssmtdxQSdlVeB
 XJKM2GLxO38vDSC1ZcTjbz+PLylBmcBok4EcKDFnAY0dCYDrzgFe/0eA/UMD8q3TUCZq
 BHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011953; x=1792616753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W8nBezmzzAkkkBCqygEuLSSG71q39R4q1THhIr+ZwVM=;
 b=gWVT7/6LRTpwAApgWLaWdmnmP+RrlYsNdtzoxNJQEd6K3HCTZ+vfjcTQl07qE/GpCL
 hh+DT0fHMcLxq9flqCvEnQ86fj2VZRO4zXoUxu/P6CFwnuwWB5vLBRYuYD4UnCNXKoIh
 mNmDtmQB+TofvQbp7poP0SPW4g2HqFQcQBQgNdBESkGTiV2Rn3lgp0us+Rnb4uf8rVSt
 hysPtyhgR5kafP3kH+v4KSWUnFinNHC9XibM0PIoKsQoKm37u8bvMAGAMaLJujqY3MQb
 TIPEd2Wn7cG1fLqobyCeHpLFjXshevIp8dLryxl8O9DPaTy+qkBWEk42A2n0075LKjQP
 2Elw==
X-Gm-Message-State: AFq9FYLkWEJ5WxqoSTbQbG/Qs6C5QxYHxkHjZp36BCLFu9wrxlAcrw/r
 OYIvDrmXQUTXjmGzg5pkl8fU75/dIeQm96ZKFwtYYfNzR+LKiPXzY50YJIl+Qe3eF6Ebk2pUluI
 4g+OyLoibLu7Wa79rUP4473V3E5zQrPnXFujR831GzeF8DbaNXEMeYzSWzKeUWehEHA==
X-Gm-Gg: AYBFou2ocri4M+hOU6Y8uE+ev+rVm0ytD4+Let3wRuPFoRjAV+D0PljnILmxzlmeji4
 ZToxgrvtBL0K62CYq1GVL1UUtPcspXSCRO0py88x2ivr5OVMb/PMDe1lYdshKc2Qt53qgOiFjoa
 5n37VgbZeApFrqerE/E9OImO+TZzH+njPXxRsYmIU+97ewq7rxrh4nyW0WF/RSp5TbhDyQlgZro
 6QETi77h6zsuolwy4DWYCWmmer7cKGST2c+VF1pPZwrjz9xGCfc46Mltq7yfaQZAnTrk2EknElq
 aGJ4Q/8euASUdv9VO2qfs378wuAe1iDeHD8jzdZhW1xaOSYlYxMYR0mA9kBBkVnlpgsnuvp1tnT
 /ItrILQEd9BiDC3LulgOv04a+OMTckgBSkBIl17zepaibZg8J4GuWvbtpnSLL
X-Received: by 2002:a05:7301:2a8:b0:358:cc1e:e23e with SMTP id
 5a478bee46e88-358cc1ee683mr18820297eec.38.1792011952718; 
 Wed, 14 Oct 2026 14:05:52 -0700 (PDT)
X-Received: by 2002:a05:7301:2a8:b0:358:cc1e:e23e with SMTP id
 5a478bee46e88-358cc1ee683mr18820263eec.38.1792011952005; 
 Wed, 14 Oct 2026 14:05:52 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358ee8a3387sm46562092eec.15.2026.10.14.14.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 14:05:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 07/12] target/riscv: declare semihosting ops
Date: Wed, 14 Oct 2026 21:05:21 +0000
Message-ID: <20261014210526.104215-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX6BD9oKznOYER
 nlMLQtKqS8bIx1do/wN8LuFEOSxdTE7ikzRbaDJ92BCUmvdth1hNB9z3TfL8eRHUJYWOxQ+4XJm
 bmxbfMV6he8v5GiFfpoMQ9e4oBcs/t/4c4vEjPMldKJ7qDbwkg/PuQG/HJYUgJ92bKDcBE/YjrO
 Z0J9gtx5ZamNMTxIdWir2Jcgg8UAJyp77C+rvhxXIM/mdw9m+O3/pJOqsGL3T7DZFKCwqp7TqAe
 DqCV/0nTE+dNQ32n+9KEzdvO1X7T2+/x2ujXIKiygSXDmTnWv3Yv9Gowhm1JQKp/uaiw3Gkhtf4
 mLUG8UUiihvDRGGFWM4TXunXX/41h8g959TUHzPu6XqGCbJRseyB+z6pK8xMd8vm7DwM6BfaS65
 Cy4E8n4v7kiZG6AYfWj4HZEZ9UlRWnhb+Dsv3GBX5cm4SEnzu3BGumEyk0t43+qRsM3kxDEyTLy
 fpUXoIa0MLW9tzDBudw==
X-Proofpoint-GUID: KR3jKApjku9yF2LFcetW2RX9rHGLxzDh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX3UfizRTMnK7j
 gBESbdjkeU1Nifa+KwfYJ3YTPlJstvK6tgRRefgCwnj3nTDmHayW8ZTAyGY92ruBdqn8bsfF0x2
 wQJSkoysbK7ZAZiA/gP+Ht176mQ247Y=
X-Proofpoint-ORIG-GUID: KR3jKApjku9yF2LFcetW2RX9rHGLxzDh
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6acfeeb1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=LEcTRzdMclfuOSi9gY0A:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140084
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
 target/riscv/common-semi-target.c | 66 ++++++++++++++++++++++++++-----
 target/riscv/cpu.c                |  4 ++
 target/riscv/internals.h          |  2 +
 3 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/target/riscv/common-semi-target.c b/target/riscv/common-semi-target.c
index 38a00e160c3..f0f9e29dc4c 100644
--- a/target/riscv/common-semi-target.c
+++ b/target/riscv/common-semi-target.c
@@ -11,43 +11,89 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "semihosting/common-semi.h"
+#include "internals.h"
 
-uint64_t common_semi_arg(CPUState *cs, int argno)
+static uint64_t riscv_semi_arg(const CPUState *cs, int argno)
 {
-    RISCVCPU *cpu = RISCV_CPU(cs);
-    CPURISCVState *env = &cpu->env;
+    const RISCVCPU *cpu = RISCV_CPU(cs);
+    const CPURISCVState *env = &cpu->env;
     return env->gpr[xA0 + argno];
 }
 
-void common_semi_set_ret(CPUState *cs, uint64_t ret)
+static void riscv_semi_set_ret(CPUState *cs, uint64_t ret)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     env->gpr[xA0] = ret;
 }
 
+static void riscv_semi_set_err(CPUState *cs, int err)
+{
+}
+
+static bool riscv_semi_is_64bit(const CPUState *cs)
+{
+    return riscv_cpu_mxl(cpu_env(cs)) != MXL_RV32;
+}
+
+static bool riscv_semi_sys_exit_is_extended(const CPUState *cs)
+{
+    return riscv_semi_is_64bit(cs);
+}
+
+static uint64_t riscv_semi_stack_bottom(const CPUState *cs)
+{
+    const RISCVCPU *cpu = RISCV_CPU(cs);
+    const CPURISCVState *env = &cpu->env;
+    return env->gpr[xSP];
+}
+
+static bool riscv_semi_has_synccache(const CPUState *cs)
+{
+    return true;
+}
+
+const SemihostingCPUOps riscv_semihosting_ops = {
+    .arg = riscv_semi_arg,
+    .set_ret = riscv_semi_set_ret,
+    .set_err = riscv_semi_set_err,
+    .is_64bit = riscv_semi_is_64bit,
+    .sys_exit_is_extended = riscv_semi_sys_exit_is_extended,
+    .stack_bottom = riscv_semi_stack_bottom,
+    .has_synccache = riscv_semi_has_synccache,
+};
+
+uint64_t common_semi_arg(CPUState *cs, int argno)
+{
+    return riscv_semi_arg(cs, argno);
+}
+
+void common_semi_set_ret(CPUState *cs, uint64_t ret)
+{
+    riscv_semi_set_ret(cs, ret);
+}
+
 void common_semi_set_err(CPUState *cs, int err)
 {
+    riscv_semi_set_err(cs, err);
 }
 
 bool is_64bit_semihosting(CPUArchState *env)
 {
-    return riscv_cpu_mxl(env) != MXL_RV32;
+    return riscv_semi_is_64bit(env_cpu(env));
 }
 
 bool common_semi_sys_exit_is_extended(CPUState *cs)
 {
-    return is_64bit_semihosting(cpu_env(cs));
+    return riscv_semi_sys_exit_is_extended(cs);
 }
 
 uint64_t common_semi_stack_bottom(CPUState *cs)
 {
-    RISCVCPU *cpu = RISCV_CPU(cs);
-    CPURISCVState *env = &cpu->env;
-    return env->gpr[xSP];
+    return riscv_semi_stack_bottom(cs);
 }
 
 bool common_semi_has_synccache(CPUArchState *env)
 {
-    return true;
+    return riscv_semi_has_synccache(env_cpu(env));
 }
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index da4c1a090b9..63c709ac738 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3053,6 +3053,10 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
     cc->gdb_arch_name = riscv_gdb_arch_name;
 #ifdef CONFIG_TCG
     cc->tcg_ops = &riscv_tcg_ops;
+#if !defined(CONFIG_USER_ONLY) || defined(CONFIG_LINUX)
+    /* semihosting is not supported for bsd-user */
+    cc->semi_ops = &riscv_semihosting_ops;
+#endif
 #endif /* CONFIG_TCG */
 
     device_class_set_props(dc, riscv_cpu_properties);
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 5d84e4de960..f17d011d22f 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -206,6 +206,8 @@ static inline target_ulong get_xepc_mask(CPURISCVState *env)
 bool riscv_cpu_has_work(CPUState *cs);
 #endif
 
+extern const struct SemihostingCPUOps riscv_semihosting_ops;
+
 /* Zjpm addr masking routine */
 static inline target_ulong adjust_addr_body(CPURISCVState *env,
                                             target_ulong addr,
-- 
2.43.0


