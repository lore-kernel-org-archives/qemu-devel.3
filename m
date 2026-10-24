Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EBA606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fel3eXP4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WDdGjHO6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgJ-000436-2P; Sat, 24 Oct 2026 13:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg7-0003zX-1l
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg4-0008IU-Sq
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:10 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExraL1907255
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sKvSx5MVd9kxpLaclewfnCA3HGUYuhIGmwOv10hE2kA=; b=fel3eXP4mTckOU0t
 Us3HxhNQ4BZmSKUyWiQh52f+ohJhbPcucCsRHwYd8T5urIHN3uTgS8hQ5XyGwCD4
 g/TPlLuFlGHNsxWtcX79zsGFBAnAEvTI6mUNYR7b2nNRCATDlZ3X7Ao98qdzn7Qp
 jLi1FVXOaNFfKYajMcXbv5mOPRxVV3Nn1JKZMitm2Z9UPozqPUGpWZfzzJefZ106
 A2i4buImsGtbCY99pw5QrGEuozpDezz2mLMFAU3ObzDjScKYspTrNaicVxOi4tN6
 r03/CKuIUxQrNgN/VKZB0EYhlxtjNayc+b4ye5werpj0yEZgLMmGkKH8uFMhLm1l
 oCg7Rw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3hekp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:07 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ac450b74b0so2815658a91.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863427; x=1793468227; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sKvSx5MVd9kxpLaclewfnCA3HGUYuhIGmwOv10hE2kA=;
 b=WDdGjHO6L8M+dv9geSoDnxxnVT162qlNtN4EAAi0UGXcOETKkU3qJx6qpXL0qQhGRQ
 lBxNNAy5Y6scFWa0Ul8qOpaggqFYCQB+TWBHLEFL803jhmdtEI3QYJ3A5a2vA8k+n+T8
 7RD5dbaljlSV7n7oMjqobMdcZb3r/QVi0gY6KXz3tLoyG6aqeDPd35J7s/j6r7rsujky
 HV938k/hd10c5MU4VkVTNmKihFs4E99mS+H/UuAL0Gqk8UHy+RH8rsu3iLY1pCfwxpRF
 v1W8FRWM+uQ5bXPTxf0wHU/VpTiD6zeekKsSUdeC9qhkghP1d4uW6a53MDg8A3RNa8Dw
 l0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863427; x=1793468227;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sKvSx5MVd9kxpLaclewfnCA3HGUYuhIGmwOv10hE2kA=;
 b=mH7iPcdp7ETZ9Wf31ZFoJgezUpUU+6ZYQjQqkKzsyVUeYhNER0uCkSoY4SeufezvkD
 NkONR9JJSIhA3g17WbJq1iNN6Ebe4bd+gQOt/cRKSObM5nuP6r0IP9ow5Ayp4U+DGncE
 FMwI473CUhtwpE4jojivL1V1JBo2EyUkRQ6fDMgQEslF2LGGHCDpEcVVaFUdb/dZeMax
 IXkYFiMbrcy5DsHYYiwSfNHU1sKI5YMArIt3lMTD9tTACvsrjJ88hJY0vtM6e6lxJDeH
 68VGk94l1Pv/YG51VvZch6Y9DY/mVhTlcOgJeTA8e0B81pF2MpQJPUZrfajJXrEXRkFb
 anqw==
X-Gm-Message-State: AFq9FYJp3iHOvvsZjiAVuzYuRY0aOfiKyGioMwmgZ00Azg4YR1J2X1Dw
 aUJV9h8oDlwKehAX10ZbCk41tXpPMTQt0OsxrTvagM6+FM4He2xCLnkfkBpQmbcNWKGPEepo+uB
 ycx9C5rvpsVDCzJqsZVGjuxkMKrVkLQCiDFOGHu0Dbm8ZI0QWAINF5jDhcKpQaYNTjw==
X-Gm-Gg: AYBFou1I2GaGV6DGhpTGpNojSAbHEjVNvsSRcVVpOlOjuQ5wbuKGfnvA2cXNLRdfDXj
 Djpex2jBEyiWyvlBrz1/Ygir+KZwsMMiGDZgGM0uRrp8CyfEopcOyXxmuJMPseJZ0y46gjJHTkh
 JWPcoeIZLcg1/pfPFIxUYRB8t96HVyugnwSQ52e8N2urGsyMk2KNX6YxPg45Ogt0Crggbjclw8+
 Hoz/vr4/z3UPUL+0mmiyp49aGpI5R1mcFQnzVBreSlGzn7/pTDz0TeHfKm+Z4KFn4VnprnR0Htf
 8vl/MKnvBhO3AiQCSCUsj4JTOghUdE6M0Xs1vfp2ekk9xOZkIJ+9v7nEMO4Rolg8mNFgNw88Lwj
 GMzjSjPeKfXR+aq4AsNNatomgLqCdyhcsi54jQltG5Z++kZdogeLGaaaJv+4NOeA=
X-Received: by 2002:a17:90b:57cb:b0:3a4:b74a:795c with SMTP id
 98e67ed59e1d1-3adea9d7510mr2326045a91.16.1792863426791; 
 Sat, 24 Oct 2026 10:37:06 -0700 (PDT)
X-Received: by 2002:a17:90b:57cb:b0:3a4:b74a:795c with SMTP id
 98e67ed59e1d1-3adea9d7510mr2326034a91.16.1792863426294; 
 Sat, 24 Oct 2026 10:37:06 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 11/20] target/tricore: remove explicit target specific prefix
Date: Sat, 24 Oct 2026 17:36:40 +0000
Message-ID: <20261024173649.7405-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ORq3HUmW3jztazWkx98_BT-NEfac-So6
X-Proofpoint-ORIG-GUID: ORq3HUmW3jztazWkx98_BT-NEfac-So6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX9k8W2TRqh8Bs
 KUfx0cQRAHCt7vllRtZt4M2pkuELh3doKpk0T6IHRlf8xfaXSrs9c8ozEfwQsN/7P/BJYfkYsgP
 6ttr77qEt1MXWvV/AKv+5egs8+YPLXM=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adcecc3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=jgB6yt7H7Q370FkDtF8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX+Pr6GIuZhR8m
 VwDp2JIUpEW5ZkhSyz+PB3RgCgolSVhuOVjqHr5BZLT/2ysg1ioEGkEJGwOG5juirjsE1eaqtOq
 qYRPwZNxI7oW6W5P58Dzoj0flN2t7y6z9XAC6bpM/hcgrQhU/LHH7BCV78IHviY+qoJUsDBC+q6
 au6V/1asDgLBUrE16gTM0od74XIUr8+KjJh4WReSQsPa8Bm/mW1zJdB5LERnrG2m2UPUlszDlBm
 riky+7QSEkS0nFvREW7RYqwy1dLO68YlfCCDIQf98+jCbjM+3INu0uo0TS3MVn8hxswsMdQ90PP
 qHLxgFePN7k3VNg0N/4wKsD1ESU/cArs4ODUOHQGu7NX1JMTHyVnxP/YLlyJC8KMjSq4UaGK3Sp
 SOA2S9He+2BjNq5yxJQ0zeK0jLW1yE6WJ0bjGHxJsNJgFbwWYhYv4nccz1OzW2H5yKCIgCY3lnw
 G8G9UNlYWoTM4v3V+mA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
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
Link: https://lore.kernel.org/qemu-devel/20261024163249.77855-12-pierrick.bouvier@oss.qualcomm.com
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


