Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B48CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBT-0008O6-GG; Thu, 15 Oct 2026 15:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBI-0008Le-JI
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBA-0000XE-Tf
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:31:56 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI0sP13202333
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wsZkD3/qf0Pfaf+1ovqLjlWaLB7XrA2fr4rjKRER+wk=; b=PfVKuZyzQzRiJrup
 ZYyBahGXwjU+DEf/q+lHf/UK3VZq+mhh5pl5dsWdVawq9aZMoZybiDye/OBy+hEr
 LLfzeGKwkiLacmJrlfsMhdlEpHUaHYdP0WzHxrGy/ELLNoubLL33zXCEUYbEHVPj
 HJiRZhz7hgwZfea8B5y514mWbDt3MpMxjmuxyl0KajA77m38dfABKc/XeEsGbilb
 SBLONzu2ksoAGtniEx96KrnZ2rm42rIB6UkfPpAgLqDE/W8+tcgDd9EmSMmArfcc
 VrFV+D6yMRh3+99TAojZC44VLEsfMfAPF+8qdGBOkXv8y9b9CS6AWmd7sEfSas7B
 +e7Rig==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3r389wg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:49 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3552883bd19so12229775eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092709; x=1792697509; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wsZkD3/qf0Pfaf+1ovqLjlWaLB7XrA2fr4rjKRER+wk=;
 b=GpNpydE750AjipTYVrAwijYWbbbbjALoPe9vqQEiJc3fWSHEwsiyGoTsANoo+dAuOW
 6EK2qxophw7UWkp23P7abaYmGvAni5XbsrVWAY4QOnH6pgdq0SpJ0CrwIoybblZDs+X5
 Wp6ztCGXT39K24Sze8V8U2Rqe4SBl+KMnH80LJ/dlqM4IrfPF/x2tH/Okkt0hV0JDJDy
 pliUY5YIVhWYbt+t8j0vz0A8OO/IGnphXeLw3f5Mj1bx3KaWaZ3m4I9g5nchL40QZaf3
 OKhqU0Z84srwPc4vOFrHQtcxDu3jIObNrDm//UPh2gPXZlMJoIKAFtttdayu4KsZA4y2
 yUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092709; x=1792697509;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wsZkD3/qf0Pfaf+1ovqLjlWaLB7XrA2fr4rjKRER+wk=;
 b=nJc4zNTyRitzHalR9smLR4G5WhSaiZeqnoAjjJFrIXjKYarBabwvxl1hqSnypdsuWK
 cPwj4Z8wDJjz8SwjT4tgWbKQx0YMcqjFMqkw0pnJO81Vd6RG0k6Dzaj7ej42ncVyNcQN
 t8edddkJbuyT2C7U6MLVKJ1GLjdqj3Z+CO/hTdmiAdQ4wcFT741qdgBmjJVvfSqmgIQi
 z5nYIeqakTZmYj++OS49JQwlZbxoekxvx7UySa1X5VxPBbyJsYzTUbc76f/b2ToruINp
 XMt8zV22mRkVXs1NnsoWZFv3XCV8rFuwEBzi0PCkcPV79rD/0jw5t2gFcGR/fQt0umUJ
 V98A==
X-Gm-Message-State: AFq9FYI3R+6lC+DrXQrSeVzelmP4Wc7V7SbdjlkoPLGpMB54gRtdpjhi
 vUU225zAzCr0cPkHZNIfRXC29kuUHTk+WCwziGytxUmGUvLwO0bF3ZkKECq56Ttdm9WGHPLzBd1
 LJZ/EdupqtWQRVcazSmZg1na32P4fDc+1r8BuN6jFcHgSTI4lnoJXEcBiwRg6vVdsNg==
X-Gm-Gg: AYBFou11eG1mhCCnbH5BP/CzKMZ6tj5VXOyc3lrCo48L6mGtwMTwii9FZZxBpouEMMy
 cg7kADs8PM69exNf2JvRX1nO8XbwLD3JnuyrRJZYWHajHncpAO6Mi6Nr0OIQmdwtsknk+oPmBB1
 48SLjjmhOWHsB2uJ8raP+ptkvyy4eRGipMsmL9X00SWzGGy7I6tK1QsjH62P9i7OpTJJHoqVtZe
 qB+mlEt0+SiqYfnK/gmDxHaqAZg/CWjYMNJoAg4OLy230MrJ6A++i4H4atx/WbjfpVN3xGqVGL5
 mfgWSCIlYvSuHGzwz7AQHk9mOs/5CgtJ3rjy1HqzQwIcT6++HlsXR+AdwKMUKPPJgcF3BWxkHzX
 Qr2Gh1VaqXpqgeatVrHlsyupAXfUwg4dzbNK8nRWi2Y0fGtcKnzyTo7yZu/ZN
X-Received: by 2002:a05:7301:305:b0:35c:4800:4da with SMTP id
 5a478bee46e88-35c48000c80mr13838266eec.41.1792092708624; 
 Thu, 15 Oct 2026 12:31:48 -0700 (PDT)
X-Received: by 2002:a05:7301:305:b0:35c:4800:4da with SMTP id
 5a478bee46e88-35c48000c80mr13838176eec.41.1792092707152; 
 Thu, 15 Oct 2026 12:31:47 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:31:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 07/20] target/riscv: declare semihosting ops
Date: Thu, 15 Oct 2026 19:30:59 +0000
Message-ID: <20261015193112.145326-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfXxr1QuKNMQ1mH
 vtkGfYY/r8JBOz/Nqv813xonUyDV1GAdgmVqeWCXBdXtd1IOSxsY5H9JMptf0GGO47LrBE1Gz+R
 6jsL02gWxoI0J+ZvEY1Ks8F8YQ6Gz2IhRarRbLWyMWWTW3+lWBFq94TFT2n3+ikYDlcFAhBXLhl
 6TCr9DxYZSwXPLrH413iyIUe/oo/uByciyRCGObQ0HFv0LuhAdEj6AJ99NuDZg/HtO0kzyj64K1
 j3O1roHpXHIcsv8Du7F3tlANkM/4s3fAS3qWCFtc3bo8rZ8wrlDgL4b0YTERp/z9m0rgvxefeyA
 xRB59p1B27apMOBKEQPGNzcrOvXFpqZ3SmWLa5T+FG3MITzM6pT4UWh73j4Y4HGcR0c8OvAP5WL
 KFjv4mxnbMOu7ffMFjT6BE3lCPTodB1noe38IkHvK4tUZlW72oO+QfdmRGs5+Jg7IcqXGCl/RjE
 ujqidJlszUJGWjyWGWQ==
X-Proofpoint-GUID: yx69h416yp5I23pmIcQtWr9yTUIpjS0p
X-Proofpoint-ORIG-GUID: yx69h416yp5I23pmIcQtWr9yTUIpjS0p
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfXzJCYaj+JQcel
 k2R/wGaUD81qkL56j3+y+tRlf8iANphsw8j9+dF5I/qrRN2iazPoFdNmjqmZk871RG4o9uiSwNj
 XD+rG5XEgkPwxG3T+V+Mb8JRkXgAr04=
X-Authority-Analysis: v=2.4 cv=INGXmQvG c=1 sm=1 tr=0 ts=6ad12a25 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LEcTRzdMclfuOSi9gY0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
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
Link: https://lore.kernel.org/qemu-devel/20261014210526.104215-8-pierrick.bouvier@oss.qualcomm.com
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


