Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2717CCA465
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBY-0008Vi-EI; Thu, 15 Oct 2026 15:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBV-0008Ot-Ax
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBL-0000XH-Dk
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:12 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI0qhl3202292
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XimM5lZfMGEgOEeia9P1b84F9AmvWl0mcleuI68xFVE=; b=AKP8EwZD14m8EzQH
 z5cDWNBc/kj8rfu7snnhLjUhQ2cjtkbqvVjd3DlNpCNh+v7DhmcohpLY7jROXUbM
 uodQTQ2kgT5wao2jX0GhGDu6j+qVZKq4sDeofVi5SWvl4s8ZPLWPV+DmxqOfN4rh
 NzQ+B9oVNZICUeyFYkxY4rAyO6YESLV6w0u5WYk8Qc1AkF7/5OhB+JetfZzV9ZOp
 ZbYvy0KdSI166R4YLffcCAmjDBDOdDD+OxmaUrYd7u+fVNRy/+6FWdlVsIrUu39T
 zAzFi9eTucKGwOGw07gTjEKxgkDAjrLoSZ1N72RBHMJ1chv5WRAz9yR+ZDkcgqF0
 xb/MrA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3r389wj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so3511607eec.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092709; x=1792697509; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XimM5lZfMGEgOEeia9P1b84F9AmvWl0mcleuI68xFVE=;
 b=bXuESqwSDXqLkBmB2Lwf9NUkdee0EwgBcAbT8nM2Ix9xav0/VmfmTRHM2Vpx/+0PGP
 3Qc42xXh65EeUZs7UU41mydcNjZSEEtlXqDx1c15vFVmAHA7cM13Qcld3cefKz28hLDB
 utLy/ZdiqJeR8WL8Ib08Y7hWdQH8CiuAEcf0HZOB/zhPHQcFg3XySAYeCF4klqrvUNNk
 Np7fiDBitAaUYuAt053BnBXKj/dX8NiwKfCkWcMuNHOzj/3Npxd2XQbJW45z8abb0PgU
 RLR1DIUJiUzV8mV98tCrnWqRcoHPA9/j1Gn30u4Re1+EdbuFKgCKhuqfc5GohOxjH2U4
 m1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092709; x=1792697509;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XimM5lZfMGEgOEeia9P1b84F9AmvWl0mcleuI68xFVE=;
 b=dSJou5vjKwxLIuGx2ObbMZ5WLP0Uaw5R3ZNqyMzaN2ZSGifqVH2pGUGMzUNOvr5vbW
 meJG90Kd2DoTsFMP6vsimMPu9WYsuqRBDRHN6RBCn9wh7LjtpDwMHfL4OKMvgPaeDcpe
 smLcznY3PQgF9LRUQYW471LT4o1wAmn5okMf46JfH/HohZq1b56/aL+KOVx9Sef6uxMS
 95TJ8q8+Ba6ij5SjliPOgSGu4zsvxFS38txWYm2DiaACsLcvuhSNSTIo8trTa5gk403Q
 fDXRlZxOnlgLCB7XCUFZFmxhUVkhwrS0HBeoqZGLxPxi0dx9zh5+gx/nfU5kqpIm4GMu
 DgKQ==
X-Gm-Message-State: AFq9FYKzGzjxn4Hv8pb/1TB2DxWmbslMd6IsrZYeUn2B84JLPLCKc2tf
 Td6OaT6kXL3fwr+J5uZVnuUdErZZmHEUWU0XN9HNIn2IxMDiesaPeG0we3vPf9C9eUqQzpP/zqz
 dxrbnKZhcmOm9d784+08jW/39L4M2fELabJAftHgOnUR3fsCDXl8RENIgNf9CLMViMQ==
X-Gm-Gg: AYBFou3G7QeTJvy+yePKSAHrGgfJBqScm9DEXdonSj8mIX6jWkisKXy9cEDUbT5EzJ0
 SaWNyqZtuLiuZnTI+lWZre9uWVEjsaxTV0CSjYzRrCYC/grxzgVtHWixgU9lrIjk9lTpNNgfQ2R
 75M2iYnbJp3BkvzgpBbdncNPwBsgGpD/rSPS1Ebc7jBSbLXFQr1/ll/XgMuoBew6g04ESLZnpZ+
 l1W2domqSVTyhSqDKn/N2Z3owSTtuMGGOJK++4mH+3DST94a+WYtY4m4mPGV6HDwIkPocP0V0CA
 J9HDnO2pbvkxDIn5+MJFIW/Y79GVVqCpNdk3KTXjFCfU6YmIIyCPccHoYvR7Tr7BSTgnpXzDdZA
 fS2WYAtYdx1tySJznIr1tXAUloKowhWoSS8TjaoyCEER//TzFVH+roYPbeixD
X-Received: by 2002:a05:7301:797:b0:353:7e28:9c58 with SMTP id
 5a478bee46e88-3537e289d93mr24909114eec.41.1792092709232; 
 Thu, 15 Oct 2026 12:31:49 -0700 (PDT)
X-Received: by 2002:a05:7301:797:b0:353:7e28:9c58 with SMTP id
 5a478bee46e88-3537e289d93mr24909059eec.41.1792092708516; 
 Thu, 15 Oct 2026 12:31:48 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:31:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 08/20] target/hexagon: declare semihosting ops
Date: Thu, 15 Oct 2026 19:31:00 +0000
Message-ID: <20261015193112.145326-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX7AUQB0CUOE3l
 GT0lH1dcwXuST9YeC7dlc8G8gkK9lcBzlfi0khjEoInjF2xdzKYEZ3/v9OKbUCRPVvLMnYbpb+j
 WGPyJ7ORwyGbNCFApey4nfx1la6jT/AApXVB7FVIA1790e3ruRsHaOvVB0d97GUhItEzoCmJmf8
 HG2+ABJ6Sb6tRsON99d4cW6KhEI06jKwDOIYCHb37H3hnItZgcLDLqzQb2iiOE+DEkP2ficBiVI
 zzU2lmgfjASKn3nH/STBa39bFkntfGzlQHKirDBaszhUEyjk5ephKrQoIoZG20VpEDjJNNJg5Ke
 EFI2xariYeuQPVuHQIkWPHdtA5jdLWUm1dSTz1tRusi33xI+BvNg0yDTCdkdMjnR5yCLibwpJh/
 aieHk5LA2aXvyBPZa42T1dpB/tNZ/EGv005yV34vB0ggY+JXYWEaPhhi6mBpVj/cJ0Vc11ZBJ/b
 E54TH90WuL9FMmDvRGQ==
X-Proofpoint-GUID: FrgBaAHuACI-jiYkDo3KsffkHb6gFRGp
X-Proofpoint-ORIG-GUID: FrgBaAHuACI-jiYkDo3KsffkHb6gFRGp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX8qbazJ2sYI07
 i6el2YnBs6Nq8ZsOPSfhTqws0DRL03XutYf6mbzTsDDzWKWomnyUxiPjjqhBcILbg/OTHWg9Eur
 rN5oxn9X+fCjRXVcq07eNjX9V80Fms8=
X-Authority-Analysis: v=2.4 cv=INGXmQvG c=1 sm=1 tr=0 ts=6ad12a26 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RKMH5O5a7-KqqQVN41YA:9 a=3ZKOabzyN94A:10
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
Link: https://lore.kernel.org/qemu-devel/20261014210526.104215-9-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/hexagon/common-semi-target.c | 65 ++++++++++++++++++++++++-----
 target/hexagon/cpu.c                |  2 +
 target/hexagon/internal.h           |  2 +
 3 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/target/hexagon/common-semi-target.c b/target/hexagon/common-semi-target.c
index 210d33e54e2..da92ff298a2 100644
--- a/target/hexagon/common-semi-target.c
+++ b/target/hexagon/common-semi-target.c
@@ -8,44 +8,89 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "cpu_helper.h"
 #include "semihosting/common-semi.h"
+#include "internal.h"
 
-uint64_t common_semi_arg(CPUState *cs, int argno)
+static uint64_t hexagon_semi_arg(const CPUState *cs, int argno)
 {
-    CPUHexagonState *env = cpu_env(cs);
+    const CPUHexagonState *env = cpu_env(cs);
     return env->gpr[HEX_REG_R00 + argno];
 }
 
-void common_semi_set_ret(CPUState *cs, uint64_t ret)
+static void hexagon_semi_set_ret(CPUState *cs, uint64_t ret)
 {
     CPUHexagonState *env = cpu_env(cs);
     env->gpr[HEX_REG_R00] = ret;
 }
 
-void common_semi_set_err(CPUState *cs, int err)
+static void hexagon_semi_set_err(CPUState *cs, int err)
 {
     CPUHexagonState *env = cpu_env(cs);
     env->gpr[HEX_REG_R01] = err;
 }
 
-bool common_semi_sys_exit_is_extended(CPUState *cs)
+static bool hexagon_semi_is_64bit(const CPUState *cs)
 {
     return false;
 }
 
+static bool hexagon_semi_sys_exit_is_extended(const CPUState *cs)
+{
+    return false;
+}
+
+static uint64_t hexagon_semi_stack_bottom(const CPUState *cs)
+{
+    const CPUHexagonState *env = cpu_env(cs);
+    return env->gpr[HEX_REG_SP];
+}
+
+static bool hexagon_semi_has_synccache(const CPUState *cs)
+{
+    return false;
+}
+
+const SemihostingCPUOps hexagon_semihosting_ops = {
+    .arg = hexagon_semi_arg,
+    .set_ret = hexagon_semi_set_ret,
+    .set_err = hexagon_semi_set_err,
+    .is_64bit = hexagon_semi_is_64bit,
+    .sys_exit_is_extended = hexagon_semi_sys_exit_is_extended,
+    .stack_bottom = hexagon_semi_stack_bottom,
+    .has_synccache = hexagon_semi_has_synccache,
+};
+
+uint64_t common_semi_arg(CPUState *cs, int argno)
+{
+    return hexagon_semi_arg(cs, argno);
+}
+
+void common_semi_set_ret(CPUState *cs, uint64_t ret)
+{
+    hexagon_semi_set_ret(cs, ret);
+}
+
+void common_semi_set_err(CPUState *cs, int err)
+{
+    hexagon_semi_set_err(cs, err);
+}
+
 bool is_64bit_semihosting(CPUArchState *env)
 {
-    return false;
+    return hexagon_semi_is_64bit(env_cpu(env));
+}
+
+bool common_semi_sys_exit_is_extended(CPUState *cs)
+{
+    return hexagon_semi_sys_exit_is_extended(cs);
 }
 
 uint64_t common_semi_stack_bottom(CPUState *cs)
 {
-    CPUHexagonState *env = cpu_env(cs);
-    return env->gpr[HEX_REG_SP];
+    return hexagon_semi_stack_bottom(cs);
 }
 
 bool common_semi_has_synccache(CPUArchState *env)
 {
-    return false;
+    return hexagon_semi_has_synccache(env_cpu(env));
 }
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 6550e7fa800..8bbd4647968 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -851,6 +851,8 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
 #ifndef CONFIG_USER_ONLY
     cc->sysemu_ops = &hexagon_sysemu_ops;
     dc->vmsd = &vmstate_hexagon_cpu;
+    /* semihosting is only supported in system mode for Hexagon */
+    cc->semi_ops = &hexagon_semihosting_ops;
 #endif
 #ifdef CONFIG_TCG
     cc->tcg_ops = &hexagon_tcg_ops;
diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 3ed83904eb7..073de10284e 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -34,6 +34,8 @@ void hexagon_debug_qreg(CPUHexagonState *env, int regnum);
 void hexagon_debug(CPUHexagonState *env);
 void hexagon_dump(CPUHexagonState *env, FILE *f, int flags);
 
+extern const struct SemihostingCPUOps hexagon_semihosting_ops;
+
 extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
 #ifndef CONFIG_USER_ONLY
 extern const char * const hexagon_sregnames[];
-- 
2.43.0


