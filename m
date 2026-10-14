Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00528CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3g4-0003xA-WF; Wed, 14 Oct 2026 14:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fw-0003vu-TA
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:26:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fu-000205-AC
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:26:04 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EF4Jmm4167137
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=R9EiadauAaY
 chkHKy/CHXApKsF1BiV5VAWD66i+wNXs=; b=AcbZCMzmpUoZkw2AxJjLU7fXMfb
 6p4cvRLHOefraOPX7Nfes01TgXteNHvdxQ73sAUfALl2dM1DcScH63m0nBylFGCR
 4Di0eYGDH7drmaZWgjHhHVKq6gewNRfVTz3IAMHqSd1iQt7sP8RqLgBMeamh7tNc
 ym02W8P3b5OSjaxSbkt8XbBKl8EXOqHWKefeSUVGLeMpMH4FfDlvnZvZHxLgwu86
 m/kiBuIj8uxmPj+WeWGzrbcpk0EYibhefOeg7rj0RjPD2AvbMlSHEQve/pJWq3H8
 c5CKRyNiKHaIWKZEv5/oBtXuUmrqSoHXwigjWSkk2bkusa8zmt4+Bn01n8Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hac230thw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:26:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510d0baf63so3989819eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 11:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792002360; x=1792607160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R9EiadauAaYchkHKy/CHXApKsF1BiV5VAWD66i+wNXs=;
 b=DJzomzZav006OHt1movEnyNwNLcTuopnhCdrBmNCJVIZGNiiTNjK4M65SgeyrA8LRD
 B7Ij7dE8eHl3mOvu/WolNE1zqEIGuKo2sb+hOPGdA8/+9/J0Ar+MGm1z35sINgoQDLt0
 ocibXcHz05RfwmFneTMQRywoaI6yKD6xFG2cNngm8ZJkfOkBmOufFSyvOkvvl88OWXIP
 dxTR6IHQ2/uPYXVWrtQM2HuprsgKkPeRn+Ajxm4JG4ZwV4Brr7URJatSBYD/OYj5y0po
 lmxmnEt8vz/8hHQCd5Hr42gHfFbkPJSE2rwmvirEZzgiwnpxRYqwa7Ne9gOorSg8FAp5
 J8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002360; x=1792607160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R9EiadauAaYchkHKy/CHXApKsF1BiV5VAWD66i+wNXs=;
 b=n0GIiWMzRyU/G9/XYjW/vFvC3cAAmzSVnSDL0GRuH3Tg1wDURC99q5L32nsJa2xByb
 vCFUvBBQhTuKrjmmkU5ULAGrCbC2inEqx2R14vpYin/uOaXMpB5ZeQygctOJDX7bOLxI
 xAcMluVECl5V0IZBQKAw1M6VTk0eY2vbFrqPbwWvkeMWXJl66ruMf4x8Q+FNdqMpmyA4
 hfrdFEh0Jf3LsoTO52szHRjaZRUWMjTTBZaYC/Uykfr2Rge/vqCdu9/ofQelyARg1f84
 BpluRO2EFWZdL0UOtCs0An9nldSoKUwmfysBcrHl+UK1JXrsup1hT9EueqoH1FCeOD6s
 wROg==
X-Gm-Message-State: AFq9FYLSnVAiHO+klPEGImgzfwnucFIcSeSb595q3XHd0R2WcxxywlQ5
 hG9NPeiFHgrvchSSMkyMLdTFT1JGgDhF9erPL2qnGXJJct/MP+RJjXO2YlMYWcT00yOKYcvqRnl
 xnuFm07ioQ69iQ8x0nhZKJRv63sPcxTTPfxZea1oOm9gis//TCI8kqc6xmWm5vlqY0g==
X-Gm-Gg: AYBFou2Zi/a5SGqmw8duuZiwrHgFBF6dhlnk5PPGeGhWsvj4Yu5/Z1Mf6OwRkZeyYcu
 Qq6RIDdpoBlWzGmUbKKEt/rjSn8NaYLw4GkHF871vwvyFM14midimHIAAbsmzoXUnqM8T+TlHll
 Airv8AK406XQaMOhBDBlYEJOx5xRYwdWmSsH9j9/hpeytyf/x8N5L25yeRtCfuzNU/JYxLZjjrW
 QceaaxrKwpvyilCLogNOtVsSwdCPnijY4UZHhXXDXGvXPOGTJ0V0SoCS3AkHPCJnQvwblWUf6Sd
 A5Iu977uOytdyI+sRzznnf2LOQGCC3zewT/czN/aWe6QI3ElDINXbcDkfuOFNZ/TjUbYLEnphdi
 FSPyNmPrp1XbNRF/7BXMau8b9ZKY918TM8xC7Tkp3qP2yUG32lDNPrmw2OYNQ
X-Received: by 2002:a05:701b:2509:b0:16e:7155:98cb with SMTP id
 a92af1059eb24-16e71559b6fmr18450652c88.15.1792002359882; 
 Wed, 14 Oct 2026 11:25:59 -0700 (PDT)
X-Received: by 2002:a05:701b:2509:b0:16e:7155:98cb with SMTP id
 a92af1059eb24-16e71559b6fmr18450631c88.15.1792002359251; 
 Wed, 14 Oct 2026 11:25:59 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm62348223c88.16.2026.10.14.11.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 11:25:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 06/11] target/riscv: declare semihosting ops
Date: Wed, 14 Oct 2026 18:25:38 +0000
Message-ID: <20261014182543.135965-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PYJqFShd c=1 sm=1 tr=0 ts=6acfc938 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=LEcTRzdMclfuOSi9gY0A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX2FkQ85I6YfTg
 //UeXV+sin//uahFOuRyoQVrW/xYC7qHL8O6tJgTIdvoZg7riseL/W22ocvE1C0FcDhiS5Z/o9K
 lOj7f/QZFVkCeMTKCaXROHl3mNC5iPQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX0wNzf8osPavO
 q0o/nEn9a2IGfvV40Yvt7eVP7dALSyzywH6WqdWeLHHFCicJpfzahAiO7BgMfF3gw1F2U4rCT7f
 A816kLcsh6ISOs/peLBknoHU2Rku90AbH8DsMTBmWYY9dUIM/etJJfKYTtEjZEdof3Id477i+Ue
 AO8bAR7v/vH9KkwMJr3M6YhU2L92AShjg1Sb0sQZbdYJynEGNaD6Y7yVn65rzWfd4ihl93rctaZ
 VWpIPjvmqD4NGMsRWrlpIMoOrFjGPcSzRxZOOvSe5H1prX7RcIkO9i1cSKR4/khzB0X1fuI5/TM
 EvZFqBYB1bqcY5AjOK1R0QsXtMHU/mw1vjxFq/y6wfpkBu3ZvDxvERtJ261sLhmT2gq+o5EHnT1
 nHV8kViQu55WLJSUljjtj3g2hs0767doDMYf8xa7M8oWfPG7+q55oKh++YXQ6TuDEfAdWIjn/K5
 z0GP8099IiHf3feiuJQ==
X-Proofpoint-GUID: TSZGkvdZeAA3nihKnO2BMqvQReik8GNc
X-Proofpoint-ORIG-GUID: TSZGkvdZeAA3nihKnO2BMqvQReik8GNc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
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
 target/riscv/common-semi-target.c | 62 +++++++++++++++++++++++++++----
 target/riscv/cpu.c                |  4 ++
 target/riscv/internals.h          |  2 +
 3 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/target/riscv/common-semi-target.c b/target/riscv/common-semi-target.c
index 38a00e160c3..7fa3bef6883 100644
--- a/target/riscv/common-semi-target.c
+++ b/target/riscv/common-semi-target.c
@@ -11,43 +11,89 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "semihosting/common-semi.h"
+#include "internals.h"
 
-uint64_t common_semi_arg(CPUState *cs, int argno)
+static uint64_t riscv_semi_arg(CPUState *cs, int argno)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
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
+static bool riscv_semi_is_64bit(CPUState *cs)
+{
+    return riscv_cpu_mxl(cpu_env(cs)) != MXL_RV32;
+}
+
+static bool riscv_semi_sys_exit_is_extended(CPUState *cs)
+{
+    return riscv_semi_is_64bit(cs);
+}
+
+static uint64_t riscv_semi_stack_bottom(CPUState *cs)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+    return env->gpr[xSP];
+}
+
+static bool riscv_semi_has_synccache(CPUState *cs)
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


