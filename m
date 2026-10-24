Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8F606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LoNqEERg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MFSNk0pA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKegp-00019q-Ui; Sat, 24 Oct 2026 12:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegZ-00011f-N1
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegX-0002Pf-J2
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:35 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF03JU1863190
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QBZWEsOiOAO8xCGEIt1J/LrhnexOTGLVI+AvLXOkU2E=; b=LoNqEERgBiHNm2KX
 h4Qw9dzk/82pZWLsJ1WYuVp2N6ocDYW4SDA//LbXUkgzSUCRaMygKXSO4A/xCLwl
 TZ+eBwHoTmUQTX8r1xW4AeqfteQF+0xmmzavEkXynlTihKdhosx8nWrizQYaAE5C
 EtSQvpmhc9KpQESkkVC4+AtGyO+eAUDDMZtq1lYFazqNwcCaDSbNOzmQVSWrMGO/
 compdTkQ3ETC5MvaPQ/LQ9iei2PI3JyJEdt80n3OzRtgTq2gMJKjVxnplSXlxJg1
 0GFtX+A4qhjj8GY3vIRZy3vRtpDlgu1cZ7c58hLExtClVC2zJ9mGtDbMAIDDAM/Z
 JLlaUQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmruhb64-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab926c236aso1749064a91.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792859602; x=1793464402; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QBZWEsOiOAO8xCGEIt1J/LrhnexOTGLVI+AvLXOkU2E=;
 b=MFSNk0pAu99Fi7qzCHN4yllyDLiE8KkY9ricPH6ZfP/XqAt2xaZgf9uJrTzdEmWwr2
 GviP6MyJLHn/Zc2hq8beancYmv1ahcx0R4jWw2sGOLQEj1hm2TYduvNtLRTOAucYTarZ
 Qp/zqtIcz8wuU53m1ynoq63DaPnhG3GOETtNDfiwA2PoSrUiQ11Uq2drPOlC/EyJKraX
 GBSfC8qedvVDhy/PZBBnEI0Y9/I1jqDHUseyrbzs8vpQKF+cmY1u6IPJSYM9OFSaw349
 YTTqWps3L+BZRbi96RRabnvE6XLEgfXcutcE5KuB+32+wDr0Qn/zzCip02OoUZWQJQj0
 vn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792859602; x=1793464402;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QBZWEsOiOAO8xCGEIt1J/LrhnexOTGLVI+AvLXOkU2E=;
 b=dbr/HQvcMzYlALcC5jbkbHKgyMVeIbesTtu7M9vHvGNZs51IKsuTh3IzLvNLSJtWxy
 DM19l0BaOz5ihYZGkXwAjgnTXeZajI6VN7BIgHe0dWG8hgqufsMz9awHVGk9O+NmM30W
 575gXVarxoiRGPf4DN0PSL0ljJGXacnCacGwy51Zl5GCCa8geGGF3Zu2512khiKDGdjV
 ho/dXax6RalaMUbLXWIMXIeoVoSs1EGPmsSc8E1BTuA7rdX0FAAwGsHTFQ1chrkvi5rm
 UXvTE/qZgjlttLjsZ6PySngeoS25o8t0zh0Eij8h4hIty+zUjD8olg2Brf3zk40NlFkl
 jwYw==
X-Gm-Message-State: AFq9FYJ7ZGh+tK9lQjajTmppgSzGTVG5KctT3r08mK1NdS/rxulN52wv
 ylFM0D05e/6AL+YTJvluCHKESJQQgbIrPJFumJEqs1NixFbK/Ss2mx6MzgmGIfpzBLVFz0tUEcq
 dl3eJ8eBXTXpkhwT+FIzwlKykLcfSkvkh6gp74ts5av7TTIQDjdwWM+Ub76qVXdeJQg==
X-Gm-Gg: AYBFou0e90sJmjijzOem3Uf7hrSJdUKwsSmEjq7Ie9pVpOvm4+0ZBzzwHZlTlWcxi64
 KN/qMwOAUyLel5F+aVpxLIuP/OYUZv9ZY3RhaMyD5S3SGKdwD6p/ziYzB8IdjWHSRbAWRr8RO0I
 R6tIN5Ce7uAaHN2RpU2gjXECMIiA1olWpNJsRI0n9R7+SgCUfZeLiZ+MEgV1/lnlwLx/AP5JS9U
 dJdUmqHC97U6Rdv66jkM1KkxyvBE7eRAmAhqZpkdsCrOUcRz/bYMW372G1G3MZFxv74m+bnIxDV
 tBLUqXEzQPNl0e3TwEai0qpCEbUxtC5Z5vvOmI5Uh9WKhiYTIkUcgN2CgBJMwJZC/QTnLhBJVKm
 YMloHbIz5gJG4QxIgJRbMELUqNdJ0LA5Qv/Lm74JV240uR9NGLK265wdG6MiT/rM=
X-Received: by 2002:a17:90b:4a84:b0:3ac:ad90:7090 with SMTP id
 98e67ed59e1d1-3adeb15557amr2226286a91.67.1792859601606; 
 Sat, 24 Oct 2026 09:33:21 -0700 (PDT)
X-Received: by 2002:a17:90b:4a84:b0:3ac:ad90:7090 with SMTP id
 98e67ed59e1d1-3adeb15557amr2226271a91.67.1792859601145; 
 Sat, 24 Oct 2026 09:33:21 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebad93c5sm1932270a91.2.2026.10.24.09.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:33:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2 11/11] target/tricore: remove explicit target specific
 prefix
Date: Sat, 24 Oct 2026 16:32:49 +0000
Message-ID: <20261024163249.77855-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX77Lck4yr5hum
 GDsK6P5aQxLILUudTvUJVt/AE1s36x3Qa3mTJyGmR8nRnx6l7Mnnd8WbLUgrZDB42oyZ0yaHUBM
 eXlb+WLv6fYRnhYAzk/uuRCapl/s7OvpTtbD3yVHJEEnKkzw03pqx/3niF0bOg5MllxfBYlBD9w
 YQrP2yeX67FFoYzmOVhG66fnPcl2gcMYyM1DZTVFa4n8lLXQTVYEARTur8yo7DI3Q2CXdxYFT7K
 4e/LmgPR7g5vWS8otpTeLQZGXYHqJ9Dor8ppifCfJXuCvojoyU7I6xj5R42KEikqjZ9sHoWyIEa
 s5VIGciSFGyUiIdZStQjPWhiMY9KtjHkk1ZIK2D8GDWt020kngug2tGxDJQcXN9YvVx17LOggUh
 lsaQhc74b4MAeOy2aWcKqKIUDiwZ2T7gfGOGO+ZCI4udeB78pA6of8WccYFv8p+DYw/aSWFV3zP
 VZiSWm43ASC9TwA+pAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX98gmE5FZfbIx
 Qa350OybcT37NVKLLvGgVV+kaTORXVsnkKs0rKjOPg9iUsz94AeD9NljgyW1kM3ylJ3Y+I5NfM3
 5egI5N8pDFxgnEBnPgpVjUI2oMo8CfM=
X-Proofpoint-ORIG-GUID: 0uxcQjtPBSsAkzEMiAyeHSSJ8gFJmpdX
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6adcddd2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=jgB6yt7H7Q370FkDtF8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 0uxcQjtPBSsAkzEMiAyeHSSJ8gFJmpdX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240065
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

Now that we have a generic mechanism to prefix all helpers, we can undo the
recent changes that fixed conflicts between targets in multi-target set.

This reverts commit 7858012634be7b987d9cb4c4520e55ccffedb2db
"target/tricore: prefix helpers conflicting with other arch"

Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/tricore/fpu_helper.c | 12 ++++++------
 target/tricore/helper.h     | 14 +++++++-------
 target/tricore/translate.c  | 14 +++++++-------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index 9d323a9b664..81fec300ff9 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -118,7 +118,7 @@ static void f_update_psw_flags(CPUTriCoreState *env, uint8_t flags)
 }
 
 #define FADD_SUB(op)                                                           \
-uint32_t HELPER(tricore_f##op)(CPUTriCoreState *env, uint32_t r1, uint32_t r2) \
+uint32_t HELPER(f##op)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)         \
 {                                                                              \
     float32 arg1 = make_float32(r1);                                           \
     float32 arg2 = make_float32(r2);                                           \
@@ -144,7 +144,7 @@ uint32_t HELPER(tricore_f##op)(CPUTriCoreState *env, uint32_t r1, uint32_t r2) \
 FADD_SUB(add)
 FADD_SUB(sub)
 
-uint32_t HELPER(tricore_fmul)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(fmul)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t flags;
     float32 arg1 = make_float32(r1);
@@ -251,7 +251,7 @@ uint32_t HELPER(qseed)(CPUTriCoreState *env, uint32_t r1)
     return (uint32_t) result;
 }
 
-uint32_t HELPER(tricore_fdiv)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(fdiv)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t flags;
     float32 arg1 = make_float32(r1);
@@ -331,7 +331,7 @@ uint32_t HELPER(fmsub)(CPUTriCoreState *env, uint32_t r1,
     return (uint32_t)f_result;
 }
 
-uint32_t HELPER(tricore_fcmp)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(fcmp)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t result, flags;
     float32 arg1 = make_float32(r1);
@@ -354,7 +354,7 @@ uint32_t HELPER(tricore_fcmp)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return result;
 }
 
-uint32_t HELPER(tricore_ftoi)(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(ftoi)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
     int32_t result, flags;
@@ -447,7 +447,7 @@ uint32_t HELPER(ftohp)(CPUTriCoreState *env, uint32_t arg)
     return result;
 }
 
-uint32_t HELPER(tricore_itof)(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(itof)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_result;
     uint32_t flags;
diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index 6073fd70379..1d97d078b00 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -102,18 +102,18 @@ DEF_HELPER_FLAGS_1(parity, TCG_CALL_NO_RWG_SE, i32, i32)
 /* float */
 DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32, i32)
 DEF_HELPER_1(unpack, i64, i32)
-DEF_HELPER_3(tricore_fadd, i32, env, i32, i32)
-DEF_HELPER_3(tricore_fsub, i32, env, i32, i32)
-DEF_HELPER_3(tricore_fmul, i32, env, i32, i32)
-DEF_HELPER_3(tricore_fdiv, i32, env, i32, i32)
+DEF_HELPER_3(fadd, i32, env, i32, i32)
+DEF_HELPER_3(fsub, i32, env, i32, i32)
+DEF_HELPER_3(fmul, i32, env, i32, i32)
+DEF_HELPER_3(fdiv, i32, env, i32, i32)
 DEF_HELPER_4(fmadd, i32, env, i32, i32, i32)
 DEF_HELPER_4(fmsub, i32, env, i32, i32, i32)
-DEF_HELPER_3(tricore_fcmp, i32, env, i32, i32)
+DEF_HELPER_3(fcmp, i32, env, i32, i32)
 DEF_HELPER_2(qseed, i32, env, i32)
-DEF_HELPER_2(tricore_ftoi, i32, env, i32)
+DEF_HELPER_2(ftoi, i32, env, i32)
 DEF_HELPER_2(ftohp, i32, env, i32)
 DEF_HELPER_2(hptof, i32, env, i32)
-DEF_HELPER_2(tricore_itof, i32, env, i32)
+DEF_HELPER_2(itof, i32, env, i32)
 DEF_HELPER_2(utof, i32, env, i32)
 DEF_HELPER_2(ftoiz, i32, env, i32)
 DEF_HELPER_2(ftou, i32, env, i32)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 81db388e5ee..8cd6b58f66b 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6290,10 +6290,10 @@ static void decode_rr_divide(DisasContext *ctx)
         }
         break;
     case OPC2_32_RR_MUL_F:
-        gen_helper_tricore_fmul(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        gen_helper_fmul(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_DIV_F:
-        gen_helper_tricore_fdiv(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        gen_helper_fdiv(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_FTOHP:
         if (has_feature(ctx, TRICORE_FEATURE_162)) {
@@ -6310,13 +6310,13 @@ static void decode_rr_divide(DisasContext *ctx)
         }
         break;
     case OPC2_32_RR_CMP_F:
-        gen_helper_tricore_fcmp(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        gen_helper_fcmp(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_FTOI:
-        gen_helper_tricore_ftoi(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
+        gen_helper_ftoi(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_ITOF:
-        gen_helper_tricore_itof(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
+        gen_helper_itof(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_FTOU:
         gen_helper_ftou(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
@@ -6725,10 +6725,10 @@ static void decode_rrr_divide(DisasContext *ctx)
         }
         break;
     case OPC2_32_RRR_ADD_F:
-        gen_helper_tricore_fadd(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
+        gen_helper_fadd(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
         break;
     case OPC2_32_RRR_SUB_F:
-        gen_helper_tricore_fsub(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
+        gen_helper_fsub(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
         break;
     case OPC2_32_RRR_MADD_F:
         gen_helper_fmadd(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1],
-- 
2.43.0


