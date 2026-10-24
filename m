Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9A606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P0MPWiBn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UTFN4ztO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKegA-0000wt-Go; Sat, 24 Oct 2026 12:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKeg9-0000wg-DH
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKeg7-0002NA-B8
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:09 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExrv8838761
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2CT7V/+xFGL75CvoUfJaKXjNO2Zt51LHLVo8biH8jDY=; b=P0MPWiBnFDsPy3BB
 7+f0aQz6SY+rZ6BUv4ctx60nuzKkahXgihN9FwwF8R7q3N2Qu+tB6tqw4wIJuoZN
 3FQZLpdFBcvnf4MwJBhd4JtSN80hA9tyGmye8InulH6ha7Gb2JcVc9epPj6OvDRw
 2/4zDo6SXJ3uFn3jg8lNRH61luNpbWDrKgEoMyxbMbre9DbGl2vdmSuzBQMgRPUw
 UZPGzyGuJLdAlTse3JsQubKEI0Ocxis+urGZFPzw2BHqKOjH9qXST1sbuSPwwyXJ
 vZ+9QutkrheGjHgqiwfiUBAF4YzUVwtzllhE1p0Yk4jmqlvIogP+SsuSMQROXJ7X
 x1VA6g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27sah6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3aca98f01c1so1727677a91.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792859585; x=1793464385; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2CT7V/+xFGL75CvoUfJaKXjNO2Zt51LHLVo8biH8jDY=;
 b=UTFN4ztOGQH80nC5s3wGKySVkLpIexyRxWLCPluGgETCtr33jwoGEZr7fvuKM+daLj
 8SkKhNtmca6b+b//QsffyH3Sq0AfgYKd28yWDe/oWGmPREIauT79u/VwlKqQ7ZAO4MS+
 E5HZ5mAiChy/iIJKLqu61jWSX9wXIScklvCYU+CDdLjxKITshOyGR21SpxReO8Fvaw6c
 66ZuxMgBo8PirWt/Fy1m6zN/aMCwJOcxPTcxVS3Cx00jZaxq6lu3BKxcZACOK7tWv5P+
 gTuZ7COg2InEaL6yMgkX0fNOhlkBJshrga8hVwQX/THdOU7Twx7mQ7maaggGfV19VY9+
 JJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792859585; x=1793464385;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2CT7V/+xFGL75CvoUfJaKXjNO2Zt51LHLVo8biH8jDY=;
 b=jBuLGgEnwcAPa3jy5B0rB5INil5ybvYZcdXu8Ir9QY7wyjQWtZtTszwdgjB+X3oNGD
 id85o10kbvAcGxwlqO29pQtIM0zjRDP/v3RBTlDkW4zHH9Th7/ZWVy2d1oS8SKQ3c4mO
 ApBoL7Cja+UcI3mbxHh+dY6TnJ3CMlTHEky6KLatbZ1crw5IinUd7RkFlqFh2Qtvs71C
 6GvHEgh1yCJ1ofOSWECJir8fGIfwbyhJMHYAdI6KWHYgANRwIe6jtal2Gfs3GEeMVvox
 2UQ8DLCMZNNyOeP1rdPzoWN4TH7sUb6YAVsodmD6sQzdgAdCxNWZwdE2xHR9gENPkYpu
 4vSg==
X-Gm-Message-State: AFq9FYKbhcTWpN2O4bD7UmiV3pVAL27iPfP32qkxYqC7gqlmDk8wbNid
 x9zlztqpLMZvzsWZSMpkM+HPCjjxG0Gq86kRQyXCh4JahWuDwjODOR4szlTRiRwdRz1a6cd6sn1
 q6N1NqjnsSE4yFMHHUQGKjRdOUU53TOZD72sykeo7ZSke8TuV4xGzbwUKzM/KLpkwZg==
X-Gm-Gg: AYBFou3eRPERUSb2o8Ldz4qmAHHHvoZJeUgaUCvzCQn+gX9ezp65rU5oscJCW6/mBum
 +wFKzKAS3ZeNROBYPKpaApLwfa+gt18dl7bRi9MAMRa6Qao8oe+1ziUjf7kQlJnhAlE2mjjQbI3
 RH2P1k1Xn8+7s7mXywMBfGiSJ2olC1WmMCN6o77/+fgNSTD9qRueXPK0JJWAZHuw5EvjZhKqx6j
 qUDiMX6ADUDbtB5Vhp2z8gjWouKZjWFp2ibxIGfG+2Magsgb9gwLZZg4BiLs1CCjgAoAWZ0bdbn
 HYFfwgLhTGGaZfA+92le0lPTMSNZSXs7pp9eGhfVbi7tgJDKdJEmhtsn8IYB2oE6u0/j2hIbcBg
 5QthUr0+XEBeh10eQSwgtMJWRJuYu/GMQW/GYHqWVsp2B2AaZFed4oEQn4KFUkI8=
X-Received: by 2002:a17:90b:5186:b0:3ad:5c64:c7ae with SMTP id
 98e67ed59e1d1-3adeb0ffbaemr2067694a91.57.1792859584916; 
 Sat, 24 Oct 2026 09:33:04 -0700 (PDT)
X-Received: by 2002:a17:90b:5186:b0:3ad:5c64:c7ae with SMTP id
 98e67ed59e1d1-3adeb0ffbaemr2067666a91.57.1792859584115; 
 Sat, 24 Oct 2026 09:33:04 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebad93c5sm1932270a91.2.2026.10.24.09.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:33:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2 01/11] target/rx: define and call helpers using HELPER macro
Date: Sat, 24 Oct 2026 16:32:39 +0000
Message-ID: <20261024163249.77855-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adcddc2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=OZx_OYey5Kulg9_gRGgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: g2uDLHV4DtBZN1OGYDwhsfShyk-kAVhB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX+0XRI+0dOIta
 MEMiOX0NJcivSKqF1YeGZ6H10tEWyjFzzLyEMPPyP+3D/+hxq0tEfOxGpFgHcGfsPfJChzxoHtQ
 6F6kFZyq6VDmaAXg8HxXrQ8mSglMHC4=
X-Proofpoint-GUID: g2uDLHV4DtBZN1OGYDwhsfShyk-kAVhB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX9ICev+9erNz7
 LZw6IAEbJ830DkRe2eFjHP3RY9GAzMgpNAf+S3EGUFy6n0IEXCOREfJNSqncT4BC3KrwddBSNJp
 XIbeIpJWROiygFH8AzUTSX825czpesbR3JbqylxaLiC3yar2CrcAAQJNksny7Jt9mRP3GcdKmDV
 8YVIngADPQos6utWvgy49OJwYbSMLek7OukBVa5zMDZNDmdF5rgKZD7Nxx+GlsIriglCXu3ufDi
 8PFQ+Yf2d4ib62gs/egZw99J1sfaz9C8XILIa4I9nmfKvq8RyM7RTjYH/qM+BJtonF70ibPKES8
 NbNAJo4jIsl0E8BRG7gJXzIZnk98bZ5qVrhf4ZCQcoOY65ZKkgBx19YnJMw5UR4TJdMV0i2aFtw
 QWLl/AC/uj8Vhuudu3QAXblYmElcfRDIt6fS8HiQqFCFDDHHsorFxIs9qmFNbE1Z9eOFOvhtoUL
 RezaFUfZOfiLW8namOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240065
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/rx/op_helper.c | 52 +++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 06841088ac0..5f4f0a14027 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -46,17 +46,17 @@ static void _set_psw(CPURXState *env, uint32_t psw, uint32_t rte)
     }
 }
 
-void helper_set_psw(CPURXState *env, uint32_t psw)
+void HELPER(set_psw)(CPURXState *env, uint32_t psw)
 {
     _set_psw(env, psw, 0);
 }
 
-void helper_set_psw_rte(CPURXState *env, uint32_t psw)
+void HELPER(set_psw_rte)(CPURXState *env, uint32_t psw)
 {
     _set_psw(env, psw, 1);
 }
 
-uint32_t helper_pack_psw(CPURXState *env)
+uint32_t HELPER(pack_psw)(CPURXState *env)
 {
     return rx_cpu_pack_psw(env);
 }
@@ -120,7 +120,7 @@ static void update_fpsw(CPURXState *env, float32 ret, uintptr_t retaddr)
     }
 }
 
-void helper_set_fpsw(CPURXState *env, uint32_t val)
+void HELPER(set_fpsw)(CPURXState *env, uint32_t val)
 {
     static const int roundmode[] = {
         float_round_nearest_even,
@@ -139,7 +139,7 @@ void helper_set_fpsw(CPURXState *env, uint32_t val)
 }
 
 #define FLOATOP(op, func)                                           \
-    float32 helper_##op(CPURXState *env, float32 t0, float32 t1)    \
+    float32 HELPER(op)(CPURXState *env, float32 t0, float32 t1)     \
     {                                                               \
         float32 ret;                                                \
         ret = func(t0, t1, &env->fp_status);                        \
@@ -152,7 +152,7 @@ FLOATOP(rx_fsub, float32_sub)
 FLOATOP(rx_fmul, float32_mul)
 FLOATOP(rx_fdiv, float32_div)
 
-void helper_rx_fcmp(CPURXState *env, float32 t0, float32 t1)
+void HELPER(rx_fcmp)(CPURXState *env, float32 t0, float32 t1)
 {
     int st;
     st = float32_compare(t0, t1, &env->fp_status);
@@ -172,7 +172,7 @@ void helper_rx_fcmp(CPURXState *env, float32 t0, float32 t1)
     }
 }
 
-uint32_t helper_ftoi(CPURXState *env, float32 t0)
+uint32_t HELPER(ftoi)(CPURXState *env, float32 t0)
 {
     uint32_t ret;
     ret = float32_to_int32_round_to_zero(t0, &env->fp_status);
@@ -180,7 +180,7 @@ uint32_t helper_ftoi(CPURXState *env, float32 t0)
     return ret;
 }
 
-uint32_t helper_round(CPURXState *env, float32 t0)
+uint32_t HELPER(round)(CPURXState *env, float32 t0)
 {
     uint32_t ret;
     ret = float32_to_int32(t0, &env->fp_status);
@@ -188,7 +188,7 @@ uint32_t helper_round(CPURXState *env, float32 t0)
     return ret;
 }
 
-float32 helper_itof(CPURXState *env, uint32_t t0)
+float32 HELPER(itof)(CPURXState *env, uint32_t t0)
 {
     float32 ret;
     ret = int32_to_float32(t0, &env->fp_status);
@@ -197,7 +197,7 @@ float32 helper_itof(CPURXState *env, uint32_t t0)
 }
 
 /* string operations */
-void helper_scmpu(CPURXState *env)
+void HELPER(scmpu)(CPURXState *env)
 {
     uint8_t tmp0, tmp1;
     if (env->regs[3] == 0) {
@@ -234,7 +234,7 @@ static void (* const cpu_stfn[])(CPUArchState *env,
     cpu_stb_data_ra, cpu_stw_le_data_ra, cpu_stl_le_data_ra,
 };
 
-void helper_sstr(CPURXState *env, uint32_t sz)
+void HELPER(sstr)(CPURXState *env, uint32_t sz)
 {
     tcg_debug_assert(sz < 3);
     while (env->regs[3] != 0) {
@@ -266,23 +266,23 @@ static void smov(uint32_t mode, CPURXState *env)
     }
 }
 
-void helper_smovu(CPURXState *env)
+void HELPER(smovu)(CPURXState *env)
 {
     smov(OP_SMOVU, env);
 }
 
-void helper_smovf(CPURXState *env)
+void HELPER(smovf)(CPURXState *env)
 {
     smov(OP_SMOVF, env);
 }
 
-void helper_smovb(CPURXState *env)
+void HELPER(smovb)(CPURXState *env)
 {
     smov(OP_SMOVB, env);
 }
 
 
-void helper_suntil(CPURXState *env, uint32_t sz)
+void HELPER(suntil)(CPURXState *env, uint32_t sz)
 {
     uint32_t tmp;
     tcg_debug_assert(sz < 3);
@@ -301,7 +301,7 @@ void helper_suntil(CPURXState *env, uint32_t sz)
     env->psw_c = (tmp <= env->regs[2]);
 }
 
-void helper_swhile(CPURXState *env, uint32_t sz)
+void HELPER(swhile)(CPURXState *env, uint32_t sz)
 {
     uint32_t tmp;
     tcg_debug_assert(sz < 3);
@@ -321,7 +321,7 @@ void helper_swhile(CPURXState *env, uint32_t sz)
 }
 
 /* accumulator operations */
-void helper_rmpa(CPURXState *env, uint32_t sz)
+void HELPER(rmpa)(CPURXState *env, uint32_t sz)
 {
     uint64_t result_l, prev;
     int32_t result_h;
@@ -363,7 +363,7 @@ void helper_rmpa(CPURXState *env, uint32_t sz)
     env->regs[4] = result_l & 0xffffffff;
 }
 
-void helper_racw(CPURXState *env, uint32_t imm)
+void HELPER(racw)(CPURXState *env, uint32_t imm)
 {
     int64_t acc;
     acc = env->acc;
@@ -379,7 +379,7 @@ void helper_racw(CPURXState *env, uint32_t imm)
     env->acc = acc;
 }
 
-void helper_satr(CPURXState *env)
+void HELPER(satr)(CPURXState *env)
 {
     if (env->psw_o >> 31) {
         if ((int)env->psw_s < 0) {
@@ -395,7 +395,7 @@ void helper_satr(CPURXState *env)
 }
 
 /* div */
-uint32_t helper_div(CPURXState *env, uint32_t num, uint32_t den)
+uint32_t HELPER(div)(CPURXState *env, uint32_t num, uint32_t den)
 {
     uint32_t ret = num;
     if (!((num == INT_MIN && den == -1) || den == 0)) {
@@ -407,7 +407,7 @@ uint32_t helper_div(CPURXState *env, uint32_t num, uint32_t den)
     return ret;
 }
 
-uint32_t helper_rx_divu(CPURXState *env, uint32_t num, uint32_t den)
+uint32_t HELPER(rx_divu)(CPURXState *env, uint32_t num, uint32_t den)
 {
     uint32_t ret = num;
     if (den != 0) {
@@ -430,22 +430,22 @@ void raise_exception(CPURXState *env, int index,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-G_NORETURN void helper_raise_privilege_violation(CPURXState *env)
+G_NORETURN void HELPER(raise_privilege_violation)(CPURXState *env)
 {
     raise_exception(env, RX_EXCP_PRIVILEGE_VIOLATION, GETPC());
 }
 
-G_NORETURN void helper_raise_access_fault(CPURXState *env)
+G_NORETURN void HELPER(raise_access_fault)(CPURXState *env)
 {
     raise_exception(env, RX_EXCP_ACCESS, GETPC());
 }
 
-G_NORETURN void helper_raise_illegal_instruction(CPURXState *env)
+G_NORETURN void HELPER(raise_illegal_instruction)(CPURXState *env)
 {
     raise_exception(env, RX_EXCP_ILLEGAL_INSTRUCTION, GETPC());
 }
 
-G_NORETURN void helper_wait(CPURXState *env)
+G_NORETURN void HELPER(wait)(CPURXState *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -455,7 +455,7 @@ G_NORETURN void helper_wait(CPURXState *env)
     raise_exception(env, EXCP_HLT, 0);
 }
 
-G_NORETURN void helper_trap(CPURXState *env, uint32_t vec)
+G_NORETURN void HELPER(trap)(CPURXState *env, uint32_t vec)
 {
     raise_exception(env, RX_EXCP_TRAP_BASE + vec, 0);
 }
-- 
2.43.0


