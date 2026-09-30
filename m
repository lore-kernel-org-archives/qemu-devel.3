Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF79CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBje4-0007bs-Ft; Tue, 29 Sep 2026 22:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBje2-0007ak-V1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBje1-000372-2H
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:06 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNQHcK484428
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HE7XlXpsGXZ
 wLqu7xkc7+H0x92+GHVv2H2bPnlzV4rc=; b=HIwndWZeqe8DTLvFwp9aCbMhZV3
 C2qf2M2F6f1Y+lx9gt/nenbfTLuqvkO7h59e42LItIJysYcz0hDimMELEhSkck80
 kVZy8B0vA/Wb9VILgq+X3hX5T558xLI69qpDsKRepVeASkbIW2D0Ah8oOTkQQQfy
 hDVlXviA+5cCqaUYPmNDgQUTWjRV8/h9rolTMqUmIRs96FSrvX+JK3ke6slLQKbY
 G/T/qfHPAkVyFkOXst/pmxIy18lfpTvzDML34E6ybB6CmbrbijOESmqnqZIvTsMb
 D6B0MqoFyGy2DyO73hG9ZrMUkcPzDvlgB215uvNXqY0iXWPlP9l3+2Zis9g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0dsx32g4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:02:03 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34bbf2e3c5cso3607962eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733723; x=1791338523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HE7XlXpsGXZwLqu7xkc7+H0x92+GHVv2H2bPnlzV4rc=;
 b=FxUzwCNZRo7r+hTLMEfcIAnLQSMy1t9vN7tWNofjcJoNLYG4KotS7ky1zsejdCRirF
 0upUqaMQvNOXPVC0vOiYC5BsS6udMg/4NBWT4P7yZ8uwmJwQ+4nvWx/HLjjY7h6w/fcd
 jqVylPnF8ZqHKod5SpA7dNJCjDX/NAUBUEQdMUy8jaluyKnYc733fwDxE/3WXhK2Qs3K
 gRyLL0FUuXWb4XWvSGjGUwiGk8Ounu+/0YpBS/zlXkK79+ZhCiX2wCjR1tvGPKNaf8MV
 T0BHFL8FMvfNm8ASZ6561P/D6TYunkoMvwW9fnjC0KxJd+04475PfWvqbJ0MZFGPL75X
 e0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733723; x=1791338523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HE7XlXpsGXZwLqu7xkc7+H0x92+GHVv2H2bPnlzV4rc=;
 b=rpxVn/l3VUk2IKkZTcW8bhKoKaiPLt8Ccb5fQtsaHD2+uAI8tAC1h8QDqpVzVy6qmf
 M9mxMUcjhzdV2O3rlQAq5OmE6UKundYVBex67VTTrgGZVQblPcV8ppFQ4pc9ZkXyFqsK
 wX/AF8DA5KNnV/v+aGS7t459zeDLw/yfJ5Z6PtbyNLLgz6WLKAVlxP30DC4CESnw33d+
 vfFGQYRWOKhAkNiktEtVqrAW1vd+bKkJjsCFCUfit6GPdwVqOhM9DJzwuYWtopcEgfmc
 lW4z+pE6odZuWTuOzwQvR5K0vlU8JlKLKE553aIIfdpupjxSvEvej7dafXSats16+6KY
 Q89g==
X-Gm-Message-State: AFq9FYIP6Y4YhFmJgnHlKb/Mz7K9vM8ecv93uqrv2xoRnuyit846gEzB
 hMxOaaijWygOro2o/Q0sx0zk7ALgofW54xTIrpr5iDV3+evDOkUrbPVdIzHKD4jEltjkIqXoMR6
 55X2GCLnPwqlk3b1KbGMp5hMaAMDvIPnt7xDwolo5Sn1ckKB6zRVBdewjX71xm9kE2Q==
X-Gm-Gg: AYBFou1jCkjggv83mTyEslMcVC7NkgRl96jzPZjEeE2Qej/aRGG/bfCuRLDudZTcHMs
 ZnKUpkOvyvwxVwyBHKb6ZnMvMDXhLjadQXYP6drS6YrbGzNmnYDdoKEAYoPn/XmdtShxpAK6VF+
 kDeMPfHmIFHATTrV1OJWJKE8OmVkLLtI9ImTyPRQ9YIvCRarJJs2rzJyy8cjPqHiyiTuRsAUBEd
 SgIpkl/Omqg543nqFTVkJsNsQZvsQ7uWxrfw6zNpsL1FQg3cl9fr3HQ7iPfinb8vP6kLWggfGYA
 JUZmdZD/8I9LwBtIR034AyoUEzf2VwGNxdH7X9lgyDI1krKeP5C/vDx+TMz/HksJ9OTyrZtcFT9
 Y+4SPo1KfNMrBO9CBZgKbXLa65RgA0DnQjJE8hOWLq8GkcaFTg1a0h9ZNhPwT
X-Received: by 2002:a05:7300:d186:b0:343:9eb1:9940 with SMTP id
 5a478bee46e88-34ce0836f0emr70353eec.26.1790733722497; 
 Tue, 29 Sep 2026 19:02:02 -0700 (PDT)
X-Received: by 2002:a05:7300:d186:b0:343:9eb1:9940 with SMTP id
 5a478bee46e88-34ce0836f0emr70337eec.26.1790733721908; 
 Tue, 29 Sep 2026 19:02:01 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:02:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 16/21] target/tricore: prefix helpers conflicting with
 other arch
Date: Wed, 30 Sep 2026 02:01:03 +0000
Message-ID: <20260930020108.217892-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX3o2FBHoPgAVW
 u0F0Kq2vuQ1vXGmYPQb124Znxs8jtY+5lEgAnPIkYe/c+Qivx+lVeosANDchDl5EHlT/JuaZWcF
 g4U9ziAwCHiKySQXsyxe8QnS9BxIN2DHlCwIXsVHZGY8iB7+GRmvT+pF+e6zMa1TWnsEmEhZKMy
 TlyZkQEsuh7rgcrsJA/E7dYm1r/Pkbylu10OiJCsnpFmAm3whdy6+jfGrLKmpMtySa8GhSvvEB7
 GZPtW7t9JGfec3TGt5GFCV2xale9EhCv6s97r5mCKn365vEaBqBs8gKC0giL114/+wjnBr4BfRn
 gvuk0Q32Eywte/c4h5Hje8tqzBdNjAaWbJsfj08jUxhsR05kedQn534LPrJNKDAK98XFiuhtc4n
 R4Mvfq/CH0Ewopr5z8VNgWV5VE9/uNXfpgHqJ4Ry/UhvWPyZCS+Lu375N8ONbvgPMDWIhSadeJB
 ZVJ5X14/2QZdfrps5dA==
X-Proofpoint-ORIG-GUID: ZZv1Z267rHtVddI1L9aJjCdTofh2HpS3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfXwhNKDuA6xxvJ
 ViRv8p1xuc/1yQ4LRKX2KuxXYEE1ugYbjn0WE47DFKtCkLrpKF95Po4tFMfqkGipya1fdDku+Eo
 OhhYnsWQ23XaPG224Q/pR8uZIuuEUGk=
X-Proofpoint-GUID: ZZv1Z267rHtVddI1L9aJjCdTofh2HpS3
X-Authority-Analysis: v=2.4 cv=DqvDa2/+ c=1 sm=1 tr=0 ts=6abc6d9b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=JOp_Co3xa00q_CoykhsA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300007
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/tricore/fpu_helper.c | 12 ++++++------
 target/tricore/helper.h     | 14 +++++++-------
 target/tricore/translate.c  | 14 +++++++-------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index 1b72dcc5f5c..fa268a8a6bc 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -118,7 +118,7 @@ static void f_update_psw_flags(CPUTriCoreState *env, uint8_t flags)
 }
 
 #define FADD_SUB(op)                                                           \
-uint32_t helper_f##op(CPUTriCoreState *env, uint32_t r1, uint32_t r2)          \
+uint32_t helper_tricore_f##op(CPUTriCoreState *env, uint32_t r1, uint32_t r2)  \
 {                                                                              \
     float32 arg1 = make_float32(r1);                                           \
     float32 arg2 = make_float32(r2);                                           \
@@ -144,7 +144,7 @@ uint32_t helper_f##op(CPUTriCoreState *env, uint32_t r1, uint32_t r2)          \
 FADD_SUB(add)
 FADD_SUB(sub)
 
-uint32_t helper_fmul(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t helper_tricore_fmul(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t flags;
     float32 arg1 = make_float32(r1);
@@ -251,7 +251,7 @@ uint32_t helper_qseed(CPUTriCoreState *env, uint32_t r1)
     return (uint32_t) result;
 }
 
-uint32_t helper_fdiv(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t helper_tricore_fdiv(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t flags;
     float32 arg1 = make_float32(r1);
@@ -331,7 +331,7 @@ uint32_t helper_fmsub(CPUTriCoreState *env, uint32_t r1,
     return (uint32_t)f_result;
 }
 
-uint32_t helper_fcmp(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t helper_tricore_fcmp(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t result, flags;
     float32 arg1 = make_float32(r1);
@@ -354,7 +354,7 @@ uint32_t helper_fcmp(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return result;
 }
 
-uint32_t helper_ftoi(CPUTriCoreState *env, uint32_t arg)
+uint32_t helper_tricore_ftoi(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
     int32_t result, flags;
@@ -447,7 +447,7 @@ uint32_t helper_ftohp(CPUTriCoreState *env, uint32_t arg)
     return result;
 }
 
-uint32_t helper_itof(CPUTriCoreState *env, uint32_t arg)
+uint32_t helper_tricore_itof(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_result;
     uint32_t flags;
diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index 1d97d078b00..6073fd70379 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -102,18 +102,18 @@ DEF_HELPER_FLAGS_1(parity, TCG_CALL_NO_RWG_SE, i32, i32)
 /* float */
 DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32, i32)
 DEF_HELPER_1(unpack, i64, i32)
-DEF_HELPER_3(fadd, i32, env, i32, i32)
-DEF_HELPER_3(fsub, i32, env, i32, i32)
-DEF_HELPER_3(fmul, i32, env, i32, i32)
-DEF_HELPER_3(fdiv, i32, env, i32, i32)
+DEF_HELPER_3(tricore_fadd, i32, env, i32, i32)
+DEF_HELPER_3(tricore_fsub, i32, env, i32, i32)
+DEF_HELPER_3(tricore_fmul, i32, env, i32, i32)
+DEF_HELPER_3(tricore_fdiv, i32, env, i32, i32)
 DEF_HELPER_4(fmadd, i32, env, i32, i32, i32)
 DEF_HELPER_4(fmsub, i32, env, i32, i32, i32)
-DEF_HELPER_3(fcmp, i32, env, i32, i32)
+DEF_HELPER_3(tricore_fcmp, i32, env, i32, i32)
 DEF_HELPER_2(qseed, i32, env, i32)
-DEF_HELPER_2(ftoi, i32, env, i32)
+DEF_HELPER_2(tricore_ftoi, i32, env, i32)
 DEF_HELPER_2(ftohp, i32, env, i32)
 DEF_HELPER_2(hptof, i32, env, i32)
-DEF_HELPER_2(itof, i32, env, i32)
+DEF_HELPER_2(tricore_itof, i32, env, i32)
 DEF_HELPER_2(utof, i32, env, i32)
 DEF_HELPER_2(ftoiz, i32, env, i32)
 DEF_HELPER_2(ftou, i32, env, i32)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 8cd6b58f66b..81db388e5ee 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6290,10 +6290,10 @@ static void decode_rr_divide(DisasContext *ctx)
         }
         break;
     case OPC2_32_RR_MUL_F:
-        gen_helper_fmul(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        gen_helper_tricore_fmul(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_DIV_F:
-        gen_helper_fdiv(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        gen_helper_tricore_fdiv(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_FTOHP:
         if (has_feature(ctx, TRICORE_FEATURE_162)) {
@@ -6310,13 +6310,13 @@ static void decode_rr_divide(DisasContext *ctx)
         }
         break;
     case OPC2_32_RR_CMP_F:
-        gen_helper_fcmp(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        gen_helper_tricore_fcmp(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_FTOI:
-        gen_helper_ftoi(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
+        gen_helper_tricore_ftoi(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_ITOF:
-        gen_helper_itof(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
+        gen_helper_tricore_itof(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_FTOU:
         gen_helper_ftou(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
@@ -6725,10 +6725,10 @@ static void decode_rrr_divide(DisasContext *ctx)
         }
         break;
     case OPC2_32_RRR_ADD_F:
-        gen_helper_fadd(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
+        gen_helper_tricore_fadd(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
         break;
     case OPC2_32_RRR_SUB_F:
-        gen_helper_fsub(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
+        gen_helper_tricore_fsub(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
         break;
     case OPC2_32_RRR_MADD_F:
         gen_helper_fmadd(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1],
-- 
2.43.0


