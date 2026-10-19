Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E61606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AN2xuL3a;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fycOSsRU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunq-0001n3-2e; Mon, 19 Oct 2026 17:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunW-0001iI-6Y
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunP-0005ha-OB
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:33 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLFhPB241875
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jhsy3Xpi9Ak
 aEUo/1M7Ds5MNPA9qpycaIqeSYO0K9Gg=; b=AN2xuL3aTzYLZiF8dL3GFvtZ0Rk
 MTkjNzPyGG/sDN0AOIIitt84oWw2sujgAErswGQhvA2pKN6uR6hDGWk5RI/t+xM6
 V9H7YYGR7PMqENLDYpsN/i8TXK8b5gn1zZfl3QBNcaru8AhK4SSvsjNHTauT/e38
 AEN4My+X6x0M4b1vk7TvPmtVJCoItqk8HPcm/Awzz+uAM30cHaImfsgEUObQiusz
 +BL1tvPajHkcBhf7CfBEqen885Y56EFUGpwpuSTKJbG7sm11KL15rf9SAwIIbA63
 BSbUe1kbUbZ8Zy6Gxdg5tVg5cDiXJTHXy0hXmfdu967s28ars4SdbYY4Kpw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48k929-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:16 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac8f449d1bso2390557a91.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444875; x=1793049675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jhsy3Xpi9AkaEUo/1M7Ds5MNPA9qpycaIqeSYO0K9Gg=;
 b=fycOSsRUMNymNnzJuO/b3hPU3wmc72x2WUZdlG7ydCahqXcTuuMtlK8fX1WrivPwCV
 bCqBP7ami63xPDx5Y3h1KWS10AjRs9riGlDEWMvUF+WxabVEVWLd/Ga0ZJwpnMv30Guf
 hypncbcyqhZk13M023X8ilSmIYGBmNMk4/Qya7t90qmxb48/MjfqA1klnhaeq23P3IYE
 qJj5UxnVIm8a9SLk+JtjjRlWKXURGwbTE9p4UbAJbA3AYepZVI4QJIREtWNFc9dZip5K
 RBvUY7rxr2tt/k04eOWwG6RW91ba0nxG/9gv9/V1d4OSf6y9d/U4xXiZChdL+ZeqWqhP
 3Neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444875; x=1793049675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jhsy3Xpi9AkaEUo/1M7Ds5MNPA9qpycaIqeSYO0K9Gg=;
 b=1SE0N/yBieNo0GEnE2CnWqoJY5N8AaY25w6Nen+5Zmmlud7oowmbPwKFpBTXjLA9Yh
 +YbIwVRw4pf9UcctEiVFd6hBDFToN72vz10uGRt8pyHAblLfwcWOMVSR0NEGb5Iepxip
 erqnZOia0NrjYGGpuRMR0HRK9mmqHjEkeekcADMrO2Ph7NJlToGxefKNOA9O7PDy7lvB
 q2x2CirpUQ0HGZaSHt21ZmoJk45c3/QOsPzVlHF7Gp2kSCWqdgq4x1c0vcHpVsUE2CYy
 m/DInlSz33ZA9I7NYNDTVnr8/fQTSgw68dgPgXwsjvlrH9ULoUgAY9kPbY5em8OySH+8
 DLVA==
X-Gm-Message-State: AFq9FYJG1VR3HYnOiD/TKCPAblCrjw51lxlw7m9BKM4Cau2es8/3vGuM
 B2tgzARUfwBGROtOXJ3/b1+INfusppaVKC53P17/yGwrn2QmZOCpAaQZChw1izmAkCNSTR+8Nd0
 JAV6l227FVToPSg81sj1QRBinGTQZc+R21olphFusw15ZfPXQbYW0SvlVKK2AhtUQDQ==
X-Gm-Gg: AYBFou36r4TPGqCeRfbBVvpPftmtWWIpPnpdQXOo4PnpcmdK5hLA2lXjg6iug2jR71/
 5z7kbLby9npYy8HHkxUVsREtQISreWdQn73LXStG5lW6K739GbYov4GqDUiytOZdSHsqmEA0LqO
 v+Uaa6dbIqTFCk0FzqcbCcKQSijIPDEroRGxNkyu/L4wlrXHybV4KdaJFKskkyc9zGcQVwunv4E
 sSe+1aCbY0eq9L7uObRCYQZdAs8jdMEi8KGiXjsb+WBGH7dM1yW0uFjuDYNqZFDovhXonfgSTRV
 VP1Y7yvRxWS4u8JRxNGrZw5p3WmiyTXpLJEbEnmaw0Zai5VQk9uD8j9SGSkuSF2sqBEGx8IigK+
 ToDqhAhmwjq6PviEtKsxNugdwcToXxIVeaP5/VB+rGbfjXmg1fUeRz93bqKEsKJU=
X-Received: by 2002:a17:90a:1096:b0:3ad:4bfc:1e77 with SMTP id
 98e67ed59e1d1-3ad4bfc498fmr1302078a91.66.1792444872829; 
 Mon, 19 Oct 2026 14:21:12 -0700 (PDT)
X-Received: by 2002:a17:90a:1096:b0:3ad:4bfc:1e77 with SMTP id
 98e67ed59e1d1-3ad4bfc498fmr1302019a91.66.1792444870096; 
 Mon, 19 Oct 2026 14:21:10 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 09/26] target/mips: define and call helpers using HELPER macro
Date: Mon, 19 Oct 2026 21:20:28 +0000
Message-ID: <20261019212046.149572-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX4yDJOJAEZvIt
 qpqvw+/xkMkvuOUoJeUa2wHxDZrJ0gsKVN2FS7ThnAeLjfNrWwJP30FwanHbGZ5qSM2RJ8Fwata
 PPGHrN69ogRNIoKsXpmUI3lKBrQ21DMhl5a1Q+cliPHZ+AAOnUq1k6eGbpWcEwcc+eXHDdzJXys
 juoyoFuK9mEMiYZ52XvnC2MhoWue0Lmgc+lME5KuW2QtIy8agroLDBbDLW6lq3pgsjjuveWKLJQ
 fs6YkGR7R0pjXadKD57IwIqtWtInVNZibDqyPU73Edbdq4Car3LdeUXhpDNXuISh7mSxabZntUg
 XiWuCJHKUWV8o20ToKBPs5M54AwAWBC68kmEJdKZqV7uIOhfv7X8+xAyoUQCpYDvk6crNojNq1e
 07Z8df2nZPiPyNj10KWA0Pca1pQQloO44d/I2qmh34OR6k3VJVukb8uyYfMpMwfj3geyX8z2dpz
 9PGBGkO82NvwqfRnP7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX0QtZsgoxeS/M
 d3/nU990LPbrEA6oMpreLt17GD8nv41Q1/yGrsuGciuoUxon8xcV2gyhbvgwPIKEdoBYx7ZGWip
 +fpoz4TT5H+dMmiMelX8hmvTQSN8pZw=
X-Proofpoint-ORIG-GUID: YqVyUJXh0vr6im-0KZPYSffHJX3WJsSs
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad689cc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=klSITKXZHVzXOpRTBfAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: YqVyUJXh0vr6im-0KZPYSffHJX3WJsSs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/mips/tcg/dsp_helper.c            | 187 +++----
 target/mips/tcg/exception.c             |   8 +-
 target/mips/tcg/fpu_helper.c            | 291 +++++-----
 target/mips/tcg/ldst_helper.c           |  18 +-
 target/mips/tcg/lmmi_helper.c           |  98 ++--
 target/mips/tcg/msa_helper.c            | 690 ++++++++++++------------
 target/mips/tcg/octeon_crypto.c         | 100 ++--
 target/mips/tcg/op_helper.c             |  34 +-
 target/mips/tcg/system/cp0_helper.c     | 276 +++++-----
 target/mips/tcg/system/lcsr_helper.c    |   8 +-
 target/mips/tcg/system/special_helper.c |  12 +-
 target/mips/tcg/system/tlb_helper.c     |  14 +-
 target/mips/tcg/vr54xx_helper.c         |  30 +-
 13 files changed, 892 insertions(+), 874 deletions(-)

diff --git a/target/mips/tcg/dsp_helper.c b/target/mips/tcg/dsp_helper.c
index 7a4362c8ef4..26fcfd5fb35 100644
--- a/target/mips/tcg/dsp_helper.c
+++ b/target/mips/tcg/dsp_helper.c
@@ -1094,7 +1094,7 @@ static inline int32_t mipsdsp_cmpu_lt(uint32_t a, uint32_t b)
 
 /** DSP Arithmetic Sub-class insns **/
 #define MIPSDSP32_UNOP_ENV(name, func, element)                            \
-target_ulong helper_##name(target_ulong rt, CPUMIPSState *env)             \
+target_ulong HELPER(name)(target_ulong rt, CPUMIPSState *env)              \
 {                                                                          \
     DSP32Value dt;                                                         \
     unsigned int i;                                                     \
@@ -1114,7 +1114,7 @@ MIPSDSP32_UNOP_ENV(absq_s_w, sat_abs32, sw)
 
 #if defined(TARGET_MIPS64)
 #define MIPSDSP64_UNOP_ENV(name, func, element)                            \
-target_ulong helper_##name(target_ulong rt, CPUMIPSState *env)             \
+target_ulong HELPER(name)(target_ulong rt, CPUMIPSState *env)              \
 {                                                                          \
     DSP64Value dt;                                                         \
     unsigned int i;                                                        \
@@ -1134,7 +1134,7 @@ MIPSDSP64_UNOP_ENV(absq_s_pw, sat_abs32, sw)
 #endif
 
 #define MIPSDSP32_BINOP(name, func, element)                               \
-target_ulong helper_##name(target_ulong rs, target_ulong rt)               \
+target_ulong HELPER(name)(target_ulong rs, target_ulong rt)                \
 {                                                                          \
     DSP32Value ds, dt;                                                     \
     unsigned int i;                                                        \
@@ -1161,7 +1161,7 @@ MIPSDSP32_BINOP(subqh_w, rshift1_sub_q32, sw);
 #undef MIPSDSP32_BINOP
 
 #define MIPSDSP32_BINOP_ENV(name, func, element)                           \
-target_ulong helper_##name(target_ulong rs, target_ulong rt,               \
+target_ulong HELPER(name)(target_ulong rs, target_ulong rt,                \
                            CPUMIPSState *env)                              \
 {                                                                          \
     DSP32Value ds, dt;                                                     \
@@ -1194,7 +1194,7 @@ MIPSDSP32_BINOP_ENV(subu_s_qb, satu8_sub, ub);
 
 #ifdef TARGET_MIPS64
 #define MIPSDSP64_BINOP(name, func, element)                               \
-target_ulong helper_##name(target_ulong rs, target_ulong rt)               \
+target_ulong HELPER(name)(target_ulong rs, target_ulong rt)                \
 {                                                                          \
     DSP64Value ds, dt;                                                     \
     unsigned int i;                                                        \
@@ -1215,7 +1215,7 @@ MIPSDSP64_BINOP(subuh_r_ob, rrshift1_sub_u8, ub);
 #undef MIPSDSP64_BINOP
 
 #define MIPSDSP64_BINOP_ENV(name, func, element)                           \
-target_ulong helper_##name(target_ulong rs, target_ulong rt,               \
+target_ulong HELPER(name)(target_ulong rs, target_ulong rt,                \
                            CPUMIPSState *env)                              \
 {                                                                          \
     DSP64Value ds, dt;                                                     \
@@ -1251,7 +1251,7 @@ MIPSDSP64_BINOP_ENV(subu_s_qh, satu16_sub_u16_u16, uh);
 #endif
 
 #define SUBUH_QB(name, var) \
-target_ulong helper_##name##_qb(target_ulong rs, target_ulong rt) \
+target_ulong HELPER(name##_qb)(target_ulong rs, target_ulong rt)  \
 {                                                                 \
     uint8_t rs3, rs2, rs1, rs0;                                   \
     uint8_t rt3, rt2, rt1, rt0;                                   \
@@ -1274,7 +1274,7 @@ SUBUH_QB(subuh_r, 1);
 
 #undef SUBUH_QB
 
-target_ulong helper_addsc(target_ulong rs, target_ulong rt, CPUMIPSState *env)
+target_ulong HELPER(addsc)(target_ulong rs, target_ulong rt, CPUMIPSState *env)
 {
     uint64_t temp, tempRs, tempRt;
     bool flag;
@@ -1289,7 +1289,7 @@ target_ulong helper_addsc(target_ulong rs, target_ulong rt, CPUMIPSState *env)
     return (target_long)(int32_t)(temp & MIPSDSP_LLO);
 }
 
-target_ulong helper_addwc(target_ulong rs, target_ulong rt, CPUMIPSState *env)
+target_ulong HELPER(addwc)(target_ulong rs, target_ulong rt, CPUMIPSState *env)
 {
     uint32_t rd;
     int32_t temp32, temp31;
@@ -1309,7 +1309,7 @@ target_ulong helper_addwc(target_ulong rs, target_ulong rt, CPUMIPSState *env)
     return (target_long)(int32_t)rd;
 }
 
-target_ulong helper_modsub(target_ulong rs, target_ulong rt)
+target_ulong HELPER(modsub)(target_ulong rs, target_ulong rt)
 {
     int32_t decr;
     uint16_t lastindex;
@@ -1327,7 +1327,7 @@ target_ulong helper_modsub(target_ulong rs, target_ulong rt)
     return rd;
 }
 
-target_ulong helper_raddu_w_qb(target_ulong rs)
+target_ulong HELPER(raddu_w_qb)(target_ulong rs)
 {
     target_ulong ret = 0;
     DSP32Value ds;
@@ -1341,7 +1341,7 @@ target_ulong helper_raddu_w_qb(target_ulong rs)
 }
 
 #if defined(TARGET_MIPS64)
-target_ulong helper_raddu_l_ob(target_ulong rs)
+target_ulong HELPER(raddu_l_ob)(target_ulong rs)
 {
     target_ulong ret = 0;
     DSP64Value ds;
@@ -1356,7 +1356,7 @@ target_ulong helper_raddu_l_ob(target_ulong rs)
 #endif
 
 #define PRECR_QB_PH(name, a, b)\
-target_ulong helper_##name##_qb_ph(target_ulong rs, target_ulong rt) \
+target_ulong HELPER(name##_qb_ph)(target_ulong rs, target_ulong rt)  \
 {                                                                    \
     uint8_t tempD, tempC, tempB, tempA;                              \
                                                                      \
@@ -1373,7 +1373,7 @@ PRECR_QB_PH(precrq, 24, 8);
 
 #undef PRECR_QB_OH
 
-target_ulong helper_precr_sra_ph_w(uint32_t sa, target_ulong rs,
+target_ulong HELPER(precr_sra_ph_w)(uint32_t sa, target_ulong rs,
                                    target_ulong rt)
 {
     uint16_t tempB, tempA;
@@ -1384,7 +1384,7 @@ target_ulong helper_precr_sra_ph_w(uint32_t sa, target_ulong rs,
     return MIPSDSP_RETURN32_16(tempB, tempA);
 }
 
-target_ulong helper_precr_sra_r_ph_w(uint32_t sa,
+target_ulong HELPER(precr_sra_r_ph_w)(uint32_t sa,
                                      target_ulong rs, target_ulong rt)
 {
     uint64_t tempB, tempA;
@@ -1402,7 +1402,7 @@ target_ulong helper_precr_sra_r_ph_w(uint32_t sa,
     return (target_long)(int32_t)rt;
 }
 
-target_ulong helper_precrq_ph_w(target_ulong rs, target_ulong rt)
+target_ulong HELPER(precrq_ph_w)(target_ulong rs, target_ulong rt)
 {
     uint16_t tempB, tempA;
 
@@ -1412,7 +1412,7 @@ target_ulong helper_precrq_ph_w(target_ulong rs, target_ulong rt)
     return MIPSDSP_RETURN32_16(tempB, tempA);
 }
 
-target_ulong helper_precrq_rs_ph_w(target_ulong rs, target_ulong rt,
+target_ulong HELPER(precrq_rs_ph_w)(target_ulong rs, target_ulong rt,
                                    CPUMIPSState *env)
 {
     uint16_t tempB, tempA;
@@ -1424,7 +1424,7 @@ target_ulong helper_precrq_rs_ph_w(target_ulong rs, target_ulong rt,
 }
 
 #if defined(TARGET_MIPS64)
-target_ulong helper_precr_ob_qh(target_ulong rs, target_ulong rt)
+target_ulong HELPER(precr_ob_qh)(target_ulong rs, target_ulong rt)
 {
     uint8_t rs6, rs4, rs2, rs0;
     uint8_t rt6, rt4, rt2, rt0;
@@ -1453,7 +1453,7 @@ target_ulong helper_precr_ob_qh(target_ulong rs, target_ulong rt)
  * In case sa != 0, use rt3, rt1, rs3, rs1.
  */
 #define PRECR_QH_PW(name, var)                                        \
-target_ulong helper_precr_##name##_qh_pw(target_ulong rs,             \
+target_ulong HELPER(precr_##name##_qh_pw)(target_ulong rs,            \
                                          target_ulong rt,             \
                                          uint32_t sa)                 \
 {                                                                     \
@@ -1484,7 +1484,7 @@ PRECR_QH_PW(sra_r, 1);
 
 #undef PRECR_QH_PW
 
-target_ulong helper_precrq_ob_qh(target_ulong rs, target_ulong rt)
+target_ulong HELPER(precrq_ob_qh)(target_ulong rs, target_ulong rt)
 {
     uint8_t rs6, rs4, rs2, rs0;
     uint8_t rt6, rt4, rt2, rt0;
@@ -1507,7 +1507,7 @@ target_ulong helper_precrq_ob_qh(target_ulong rs, target_ulong rt)
     return temp;
 }
 
-target_ulong helper_precrq_qh_pw(target_ulong rs, target_ulong rt)
+target_ulong HELPER(precrq_qh_pw)(target_ulong rs, target_ulong rt)
 {
     uint16_t tempD, tempC, tempB, tempA;
 
@@ -1519,7 +1519,7 @@ target_ulong helper_precrq_qh_pw(target_ulong rs, target_ulong rt)
     return MIPSDSP_RETURN64_16(tempD, tempC, tempB, tempA);
 }
 
-target_ulong helper_precrq_rs_qh_pw(target_ulong rs, target_ulong rt,
+target_ulong HELPER(precrq_rs_qh_pw)(target_ulong rs, target_ulong rt,
                                     CPUMIPSState *env)
 {
     uint32_t rs2, rs0;
@@ -1539,7 +1539,7 @@ target_ulong helper_precrq_rs_qh_pw(target_ulong rs, target_ulong rt,
     return MIPSDSP_RETURN64_16(tempD, tempC, tempB, tempA);
 }
 
-target_ulong helper_precrq_pw_l(target_ulong rs, target_ulong rt)
+target_ulong HELPER(precrq_pw_l)(target_ulong rs, target_ulong rt)
 {
     uint32_t tempB, tempA;
 
@@ -1550,7 +1550,7 @@ target_ulong helper_precrq_pw_l(target_ulong rs, target_ulong rt)
 }
 #endif
 
-target_ulong helper_precrqu_s_qb_ph(target_ulong rs, target_ulong rt,
+target_ulong HELPER(precrqu_s_qb_ph)(target_ulong rs, target_ulong rt,
                                     CPUMIPSState *env)
 {
     uint8_t  tempD, tempC, tempB, tempA;
@@ -1570,7 +1570,7 @@ target_ulong helper_precrqu_s_qb_ph(target_ulong rs, target_ulong rt,
 }
 
 #if defined(TARGET_MIPS64)
-target_ulong helper_precrqu_s_ob_qh(target_ulong rs, target_ulong rt,
+target_ulong HELPER(precrqu_s_ob_qh)(target_ulong rs, target_ulong rt,
                                     CPUMIPSState *env)
 {
     int i;
@@ -1601,7 +1601,7 @@ target_ulong helper_precrqu_s_ob_qh(target_ulong rs, target_ulong rt,
 }
 
 #define PRECEQ_PW(name, a, b) \
-target_ulong helper_preceq_pw_##name(target_ulong rt) \
+target_ulong HELPER(preceq_pw_##name)(target_ulong rt) \
 {                                                       \
     uint16_t tempB, tempA;                              \
     uint32_t tempBI, tempAI;                            \
@@ -1625,7 +1625,7 @@ PRECEQ_PW(qhra, 32, 0);
 #endif
 
 #define PRECEQU_PH(name, a, b) \
-target_ulong helper_precequ_ph_##name(target_ulong rt) \
+target_ulong HELPER(precequ_ph_##name)(target_ulong rt) \
 {                                                        \
     uint16_t tempB, tempA;                               \
                                                          \
@@ -1647,7 +1647,7 @@ PRECEQU_PH(qbra, 16, 0);
 
 #if defined(TARGET_MIPS64)
 #define PRECEQU_QH(name, a, b, c, d) \
-target_ulong helper_precequ_qh_##name(target_ulong rt)       \
+target_ulong HELPER(precequ_qh_##name)(target_ulong rt)      \
 {                                                            \
     uint16_t tempD, tempC, tempB, tempA;                     \
                                                              \
@@ -1674,7 +1674,7 @@ PRECEQU_QH(obra, 48, 32, 16, 0);
 #endif
 
 #define PRECEU_PH(name, a, b) \
-target_ulong helper_preceu_ph_##name(target_ulong rt) \
+target_ulong HELPER(preceu_ph_##name)(target_ulong rt) \
 {                                                     \
     uint16_t tempB, tempA;                            \
                                                       \
@@ -1693,7 +1693,7 @@ PRECEU_PH(qbra, 16, 0);
 
 #if defined(TARGET_MIPS64)
 #define PRECEU_QH(name, a, b, c, d) \
-target_ulong helper_preceu_qh_##name(target_ulong rt)        \
+target_ulong HELPER(preceu_qh_##name)(target_ulong rt)       \
 {                                                            \
     uint16_t tempD, tempC, tempB, tempA;                     \
                                                              \
@@ -1716,7 +1716,7 @@ PRECEU_QH(obra, 48, 32, 16, 0);
 
 /** DSP GPR-Based Shift Sub-class insns **/
 #define SHIFT_QB(name, func) \
-target_ulong helper_##name##_qb(target_ulong sa, target_ulong rt) \
+target_ulong HELPER(name##_qb)(target_ulong sa, target_ulong rt)  \
 {                                                                    \
     uint8_t rt3, rt2, rt1, rt0;                                      \
                                                                      \
@@ -1733,7 +1733,7 @@ target_ulong helper_##name##_qb(target_ulong sa, target_ulong rt) \
 }
 
 #define SHIFT_QB_ENV(name, func) \
-target_ulong helper_##name##_qb(target_ulong sa, target_ulong rt,\
+target_ulong HELPER(name##_qb)(target_ulong sa, target_ulong rt, \
                                 CPUMIPSState *env) \
 {                                                                    \
     uint8_t rt3, rt2, rt1, rt0;                                      \
@@ -1761,7 +1761,7 @@ SHIFT_QB(shra_r, rnd8_rashift);
 
 #if defined(TARGET_MIPS64)
 #define SHIFT_OB(name, func) \
-target_ulong helper_##name##_ob(target_ulong rt, target_ulong sa) \
+target_ulong HELPER(name##_ob)(target_ulong rt, target_ulong sa)  \
 {                                                                        \
     int i;                                                               \
     uint8_t rt_t[8];                                                     \
@@ -1780,7 +1780,7 @@ target_ulong helper_##name##_ob(target_ulong rt, target_ulong sa) \
 }
 
 #define SHIFT_OB_ENV(name, func) \
-target_ulong helper_##name##_ob(target_ulong rt, target_ulong sa, \
+target_ulong HELPER(name##_ob)(target_ulong rt, target_ulong sa,  \
                                 CPUMIPSState *env)                       \
 {                                                                        \
     int i;                                                               \
@@ -1811,7 +1811,7 @@ SHIFT_OB(shra_r, rnd8_rashift);
 #endif
 
 #define SHIFT_PH(name, func) \
-target_ulong helper_##name##_ph(target_ulong sa, target_ulong rt, \
+target_ulong HELPER(name##_ph)(target_ulong sa, target_ulong rt,  \
                                 CPUMIPSState *env)                \
 {                                                                 \
     uint16_t rth, rtl;                                            \
@@ -1833,7 +1833,7 @@ SHIFT_PH(shll_s, sat16_lshift);
 
 #if defined(TARGET_MIPS64)
 #define SHIFT_QH(name, func) \
-target_ulong helper_##name##_qh(target_ulong rt, target_ulong sa) \
+target_ulong HELPER(name##_qh)(target_ulong rt, target_ulong sa)  \
 {                                                                 \
     uint16_t rt3, rt2, rt1, rt0;                                  \
                                                                   \
@@ -1850,7 +1850,7 @@ target_ulong helper_##name##_qh(target_ulong rt, target_ulong sa) \
 }
 
 #define SHIFT_QH_ENV(name, func) \
-target_ulong helper_##name##_qh(target_ulong rt, target_ulong sa, \
+target_ulong HELPER(name##_qh)(target_ulong rt, target_ulong sa,  \
                                 CPUMIPSState *env)                \
 {                                                                 \
     uint16_t rt3, rt2, rt1, rt0;                                  \
@@ -1880,7 +1880,7 @@ SHIFT_QH(shra_r, rnd16_rashift);
 #endif
 
 #define SHIFT_W(name, func) \
-target_ulong helper_##name##_w(target_ulong sa, target_ulong rt) \
+target_ulong HELPER(name##_w)(target_ulong sa, target_ulong rt)  \
 {                                                                       \
     uint32_t temp;                                                      \
                                                                         \
@@ -1891,7 +1891,7 @@ target_ulong helper_##name##_w(target_ulong sa, target_ulong rt) \
 }
 
 #define SHIFT_W_ENV(name, func) \
-target_ulong helper_##name##_w(target_ulong sa, target_ulong rt, \
+target_ulong HELPER(name##_w)(target_ulong sa, target_ulong rt,  \
                                CPUMIPSState *env) \
 {                                                                       \
     uint32_t temp;                                                      \
@@ -1910,7 +1910,7 @@ SHIFT_W(shra_r, rnd32_rashift);
 
 #if defined(TARGET_MIPS64)
 #define SHIFT_PW(name, func) \
-target_ulong helper_##name##_pw(target_ulong rt, target_ulong sa) \
+target_ulong HELPER(name##_pw)(target_ulong rt, target_ulong sa)  \
 {                                                                 \
     uint32_t rt1, rt0;                                            \
                                                                   \
@@ -1924,7 +1924,7 @@ target_ulong helper_##name##_pw(target_ulong rt, target_ulong sa) \
 }
 
 #define SHIFT_PW_ENV(name, func) \
-target_ulong helper_##name##_pw(target_ulong rt, target_ulong sa, \
+target_ulong HELPER(name##_pw)(target_ulong rt, target_ulong sa,  \
                                 CPUMIPSState *env)                \
 {                                                                 \
     uint32_t rt1, rt0;                                            \
@@ -1950,7 +1950,7 @@ SHIFT_PW(shra_r, rnd32_rashift);
 #endif
 
 #define SHIFT_PH(name, func) \
-target_ulong helper_##name##_ph(target_ulong sa, target_ulong rt) \
+target_ulong HELPER(name##_ph)(target_ulong sa, target_ulong rt)  \
 {                                                                    \
     uint16_t rth, rtl;                                               \
                                                                      \
@@ -1978,7 +1978,7 @@ SHIFT_PH(shra_r, rnd16_rashift);
 #define MUL_RETURN32_16_PH(name, func, \
                            rsmov1, rsmov2, rsfilter, \
                            rtmov1, rtmov2, rtfilter) \
-target_ulong helper_##name(target_ulong rs, target_ulong rt, \
+target_ulong HELPER(name)(target_ulong rs, target_ulong rt,  \
                            CPUMIPSState *env)                \
 {                                                            \
     uint16_t rsB, rsA, rtB, rtA;                             \
@@ -2016,7 +2016,7 @@ MUL_RETURN32_16_PH(mulq_s_ph, sat16_mul_q15_q15, \
 #undef MUL_RETURN32_16_PH
 
 #define MUL_RETURN32_32_ph(name, func, movbits) \
-target_ulong helper_##name(target_ulong rs, target_ulong rt, \
+target_ulong HELPER(name)(target_ulong rs, target_ulong rt,  \
                                   CPUMIPSState *env)         \
 {                                                            \
     int16_t rsh, rth;                                        \
@@ -2035,7 +2035,7 @@ MUL_RETURN32_32_ph(muleq_s_w_phr, mul_q15_q15_overflowflag21, 0);
 #undef MUL_RETURN32_32_ph
 
 #define MUL_VOID_PH(name, use_ac_env) \
-void helper_##name(uint32_t ac, target_ulong rs, target_ulong rt,        \
+void HELPER(name)(uint32_t ac, target_ulong rs, target_ulong rt,         \
                           CPUMIPSState *env)                             \
 {                                                                        \
     int16_t rsh, rsl, rth, rtl;                                          \
@@ -2071,7 +2071,7 @@ MUL_VOID_PH(mulsa_w_ph, 0);
 #define MUL_RETURN64_16_QH(name, func, \
                            rsmov1, rsmov2, rsmov3, rsmov4, rsfilter, \
                            rtmov1, rtmov2, rtmov3, rtmov4, rtfilter) \
-target_ulong helper_##name(target_ulong rs, target_ulong rt,         \
+target_ulong HELPER(name)(target_ulong rs, target_ulong rt,          \
                            CPUMIPSState *env)                        \
 {                                                                    \
     uint16_t rs3, rs2, rs1, rs0;                                     \
@@ -2110,7 +2110,7 @@ MUL_RETURN64_16_QH(mulq_rs_qh, rndq15_mul_q15_q15, \
 #define MUL_RETURN64_32_QH(name, \
                            rsmov1, rsmov2, \
                            rtmov1, rtmov2) \
-target_ulong helper_##name(target_ulong rs, target_ulong rt, \
+target_ulong HELPER(name)(target_ulong rs, target_ulong rt,  \
                            CPUMIPSState *env)                \
 {                                                            \
     uint16_t rsB, rsA;                                       \
@@ -2133,7 +2133,7 @@ MUL_RETURN64_32_QH(muleq_s_pw_qhr, 16, 0, 16, 0);
 
 #undef MUL_RETURN64_32_QH
 
-void helper_mulsaq_s_w_qh(target_ulong rs, target_ulong rt, uint32_t ac,
+void HELPER(mulsaq_s_w_qh)(target_ulong rs, target_ulong rt, uint32_t ac,
                           CPUMIPSState *env)
 {
     int16_t rs3, rs2, rs1, rs0;
@@ -2177,7 +2177,7 @@ void helper_mulsaq_s_w_qh(target_ulong rs, target_ulong rt, uint32_t ac,
 #endif
 
 #define DP_QB(name, func, is_add, rsmov1, rsmov2, rtmov1, rtmov2) \
-void helper_##name(uint32_t ac, target_ulong rs, target_ulong rt,        \
+void HELPER(name)(uint32_t ac, target_ulong rs, target_ulong rt,         \
                    CPUMIPSState *env)                                    \
 {                                                                        \
     uint8_t rs3, rs2;                                                    \
@@ -2218,7 +2218,7 @@ DP_QB(dpsu_h_qbr, mul_u8_u8, 0, 8, 0, 8, 0);
 #define DP_OB(name, add_sub, \
               rsmov1, rsmov2, rsmov3, rsmov4, \
               rtmov1, rtmov2, rtmov3, rtmov4) \
-void helper_##name(target_ulong rs, target_ulong rt, uint32_t ac,       \
+void HELPER(name)(target_ulong rs, target_ulong rt, uint32_t ac,        \
                        CPUMIPSState *env)                               \
 {                                                                       \
     uint8_t rsD, rsC, rsB, rsA;                                         \
@@ -2281,7 +2281,7 @@ DP_OB(dpsu_h_obr, 0, 24, 16, 8, 0, 24, 16, 8, 0);
 #endif
 
 #define DP_NOFUNC_PH(name, is_add, rsmov1, rsmov2, rtmov1, rtmov2)             \
-void helper_##name(uint32_t ac, target_ulong rs, target_ulong rt,              \
+void HELPER(name)(uint32_t ac, target_ulong rs, target_ulong rt,               \
                    CPUMIPSState *env)                                          \
 {                                                                              \
     int16_t rsB, rsA, rtB, rtA;                                                \
@@ -2316,7 +2316,7 @@ DP_NOFUNC_PH(dpsx_w_ph, 0, 16, 0, 0, 16);
 #undef DP_NOFUNC_PH
 
 #define DP_HASFUNC_PH(name, is_add, rsmov1, rsmov2, rtmov1, rtmov2) \
-void helper_##name(uint32_t ac, target_ulong rs, target_ulong rt,   \
+void HELPER(name)(uint32_t ac, target_ulong rs, target_ulong rt,    \
                    CPUMIPSState *env)                      \
 {                                                          \
     int16_t rsB, rsA, rtB, rtA;                            \
@@ -2355,7 +2355,7 @@ DP_HASFUNC_PH(dpsqx_s_w_ph, 0, 16, 0, 0, 16);
 #undef DP_HASFUNC_PH
 
 #define DP_128OPERATION_PH(name, is_add) \
-void helper_##name(uint32_t ac, target_ulong rs, target_ulong rt, \
+void HELPER(name)(uint32_t ac, target_ulong rs, target_ulong rt,  \
                           CPUMIPSState *env)                             \
 {                                                                        \
     int16_t rsh, rsl, rth, rtl;                                          \
@@ -2402,7 +2402,7 @@ DP_128OPERATION_PH(dpsqx_sa_w_ph, 0);
 
 #if defined(TARGET_MIPS64)
 #define DP_QH(name, is_add, use_ac_env) \
-void helper_##name(target_ulong rs, target_ulong rt, uint32_t ac,    \
+void HELPER(name)(target_ulong rs, target_ulong rt, uint32_t ac,     \
                    CPUMIPSState *env)                                \
 {                                                                    \
     int32_t rs3, rs2, rs1, rs0;                                      \
@@ -2470,7 +2470,7 @@ DP_QH(dpsq_s_w_qh, 0, 1);
 #endif
 
 #define DP_L_W(name, is_add) \
-void helper_##name(uint32_t ac, target_ulong rs, target_ulong rt,      \
+void HELPER(name)(uint32_t ac, target_ulong rs, target_ulong rt,       \
                    CPUMIPSState *env)                                  \
 {                                                                      \
     int32_t temp63;                                                    \
@@ -2515,7 +2515,7 @@ DP_L_W(dpsq_sa_l_w, 0);
 
 #if defined(TARGET_MIPS64)
 #define DP_L_PW(name, func) \
-void helper_##name(target_ulong rs, target_ulong rt, uint32_t ac, \
+void HELPER(name)(target_ulong rs, target_ulong rt, uint32_t ac,  \
                    CPUMIPSState *env)                             \
 {                                                                 \
     int32_t rs1, rs0;                                             \
@@ -2565,7 +2565,7 @@ DP_L_PW(dpsq_sa_l_pw, sat64_acc_sub_q63);
 
 #undef DP_L_PW
 
-void helper_mulsaq_s_l_pw(target_ulong rs, target_ulong rt, uint32_t ac,
+void HELPER(mulsaq_s_l_pw)(target_ulong rs, target_ulong rt, uint32_t ac,
                           CPUMIPSState *env)
 {
     int32_t rs1, rs0;
@@ -2625,7 +2625,7 @@ void helper_mulsaq_s_l_pw(target_ulong rs, target_ulong rt, uint32_t ac,
 #endif
 
 #define MAQ_S_W(name, mov) \
-void helper_##name(uint32_t ac, target_ulong rs, target_ulong rt, \
+void HELPER(name)(uint32_t ac, target_ulong rs, target_ulong rt,  \
                    CPUMIPSState *env)                             \
 {                                                                 \
     int16_t rsh, rth;                                             \
@@ -2650,7 +2650,7 @@ MAQ_S_W(maq_s_w_phr, 0);
 #undef MAQ_S_W
 
 #define MAQ_SA_W(name, mov) \
-void helper_##name(uint32_t ac, target_ulong rs, target_ulong rt,        \
+void HELPER(name)(uint32_t ac, target_ulong rs, target_ulong rt,         \
                    CPUMIPSState *env)                                    \
 {                                                                        \
     int16_t rsh, rth;                                                    \
@@ -2673,7 +2673,7 @@ MAQ_SA_W(maq_sa_w_phr, 0);
 #undef MAQ_SA_W
 
 #define MULQ_W(name, addvar) \
-target_ulong helper_##name(target_ulong rs, target_ulong rt,   \
+target_ulong HELPER(name)(target_ulong rs, target_ulong rt,    \
                            CPUMIPSState *env)                  \
 {                                                              \
     int32_t rs_t, rt_t;                                        \
@@ -2703,7 +2703,7 @@ MULQ_W(mulq_rs_w, 0x80000000ull);
 #if defined(TARGET_MIPS64)
 
 #define MAQ_S_W_QH(name, mov) \
-void helper_##name(target_ulong rs, target_ulong rt, uint32_t ac, \
+void HELPER(name)(target_ulong rs, target_ulong rt, uint32_t ac,  \
                    CPUMIPSState *env)                             \
 {                                                                 \
     int16_t rs_t, rt_t;                                           \
@@ -2749,7 +2749,7 @@ MAQ_S_W_QH(maq_s_w_qhrr, 0);
 #undef MAQ_S_W_QH
 
 #define MAQ_SA_W(name, mov) \
-void helper_##name(target_ulong rs, target_ulong rt, uint32_t ac, \
+void HELPER(name)(target_ulong rs, target_ulong rt, uint32_t ac,  \
                    CPUMIPSState *env)                             \
 {                                                                 \
     int16_t rs_t, rt_t;                                           \
@@ -2780,7 +2780,7 @@ MAQ_SA_W(maq_sa_w_qhrr, 0);
 #undef MAQ_SA_W
 
 #define MAQ_S_L_PW(name, mov) \
-void helper_##name(target_ulong rs, target_ulong rt, uint32_t ac, \
+void HELPER(name)(target_ulong rs, target_ulong rt, uint32_t ac,  \
                    CPUMIPSState *env)                             \
 {                                                                 \
     int32_t rs_t, rt_t;                                           \
@@ -2822,7 +2822,7 @@ MAQ_S_L_PW(maq_s_l_pwr, 0);
 #undef MAQ_S_L_PW
 
 #define DM_OPERATE(name, func, is_add, sigext) \
-void helper_##name(target_ulong rs, target_ulong rt, uint32_t ac,    \
+void HELPER(name)(target_ulong rs, target_ulong rt, uint32_t ac,     \
                   CPUMIPSState *env)                                 \
 {                                                                    \
     int32_t rs1, rs0;                                                \
@@ -2900,7 +2900,7 @@ DM_OPERATE(dmsubu, mul_u32_u32, 0, 0);
 #endif
 
 /** DSP Bit/Manipulation Sub-class insns **/
-target_ulong helper_bitrev(target_ulong rt)
+target_ulong HELPER(bitrev)(target_ulong rt)
 {
     int32_t temp;
     uint32_t rd;
@@ -2917,7 +2917,7 @@ target_ulong helper_bitrev(target_ulong rt)
 }
 
 #define BIT_INSV(name, posfilter, ret_type)                     \
-target_ulong helper_##name(CPUMIPSState *env, target_ulong rs,  \
+target_ulong HELPER(name)(CPUMIPSState *env, target_ulong rs,   \
                            target_ulong rt)                     \
 {                                                               \
     uint32_t pos, size, msb, lsb;                               \
@@ -2952,7 +2952,7 @@ BIT_INSV(dinsv, 0x7F, target_long);
 
 /** DSP Compare-Pick Sub-class insns **/
 #define CMP_HAS_RET(name, func, split_num, filter, bit_size) \
-target_ulong helper_##name(target_ulong rs, target_ulong rt) \
+target_ulong HELPER(name)(target_ulong rs, target_ulong rt)  \
 {                                                       \
     uint32_t rs_t, rt_t;                                \
     uint8_t cc;                                         \
@@ -2983,7 +2983,7 @@ CMP_HAS_RET(cmpgu_le_ob, cmpu_le, 8, MIPSDSP_Q0, 8);
 
 
 #define CMP_NO_RET(name, func, split_num, filter, bit_size) \
-void helper_##name(target_ulong rs, target_ulong rt,        \
+void HELPER(name)(target_ulong rs, target_ulong rt,         \
                             CPUMIPSState *env)              \
 {                                                           \
     int##bit_size##_t rs_t, rt_t;                           \
@@ -3028,7 +3028,7 @@ CMP_NO_RET(cmp_le_pw, cmp_le, 2, MIPSDSP_LLO, 32);
 #if defined(TARGET_MIPS64)
 
 #define CMPGDU_OB(name) \
-target_ulong helper_cmpgdu_##name##_ob(target_ulong rs, target_ulong rt, \
+target_ulong HELPER(cmpgdu_##name##_ob)(target_ulong rs, target_ulong rt, \
                                        CPUMIPSState *env)  \
 {                                                     \
     int i;                                            \
@@ -3058,7 +3058,7 @@ CMPGDU_OB(le)
 #endif
 
 #define PICK_INSN(name, split_num, filter, bit_size, ret32bit) \
-target_ulong helper_##name(target_ulong rs, target_ulong rt,   \
+target_ulong HELPER(name)(target_ulong rs, target_ulong rt,    \
                             CPUMIPSState *env)                 \
 {                                                              \
     uint32_t rs_t, rt_t;                                       \
@@ -3094,7 +3094,7 @@ PICK_INSN(pick_pw, 2, MIPSDSP_LLO, 32, 0);
 #endif
 #undef PICK_INSN
 
-target_ulong helper_packrl_ph(target_ulong rs, target_ulong rt)
+target_ulong HELPER(packrl_ph)(target_ulong rs, target_ulong rt)
 {
     uint32_t rsl, rth;
 
@@ -3105,7 +3105,7 @@ target_ulong helper_packrl_ph(target_ulong rs, target_ulong rt)
 }
 
 #if defined(TARGET_MIPS64)
-target_ulong helper_packrl_pw(target_ulong rs, target_ulong rt)
+target_ulong HELPER(packrl_pw)(target_ulong rs, target_ulong rt)
 {
     uint32_t rs0, rt1;
 
@@ -3117,7 +3117,7 @@ target_ulong helper_packrl_pw(target_ulong rs, target_ulong rt)
 #endif
 
 /** DSP Accumulator and DSPControl Access Sub-class insns **/
-target_ulong helper_extr_w(target_ulong ac, target_ulong shift,
+target_ulong HELPER(extr_w)(target_ulong ac, target_ulong shift,
                            CPUMIPSState *env)
 {
     int32_t tempI;
@@ -3146,7 +3146,7 @@ target_ulong helper_extr_w(target_ulong ac, target_ulong shift,
     return (target_long)tempI;
 }
 
-target_ulong helper_extr_r_w(target_ulong ac, target_ulong shift,
+target_ulong HELPER(extr_r_w)(target_ulong ac, target_ulong shift,
                              CPUMIPSState *env)
 {
     int64_t tempDL[2];
@@ -3172,7 +3172,7 @@ target_ulong helper_extr_r_w(target_ulong ac, target_ulong shift,
     return (target_long)(int32_t)(tempDL[0] >> 1);
 }
 
-target_ulong helper_extr_rs_w(target_ulong ac, target_ulong shift,
+target_ulong HELPER(extr_rs_w)(target_ulong ac, target_ulong shift,
                               CPUMIPSState *env)
 {
     int32_t tempI, temp64;
@@ -3206,7 +3206,7 @@ target_ulong helper_extr_rs_w(target_ulong ac, target_ulong shift,
 }
 
 #if defined(TARGET_MIPS64)
-target_ulong helper_dextr_w(target_ulong ac, target_ulong shift,
+target_ulong HELPER(dextr_w)(target_ulong ac, target_ulong shift,
                             CPUMIPSState *env)
 {
     uint64_t temp[3];
@@ -3218,7 +3218,7 @@ target_ulong helper_dextr_w(target_ulong ac, target_ulong shift,
     return (int64_t)(int32_t)(temp[0] >> 1);
 }
 
-target_ulong helper_dextr_r_w(target_ulong ac, target_ulong shift,
+target_ulong HELPER(dextr_r_w)(target_ulong ac, target_ulong shift,
                               CPUMIPSState *env)
 {
     uint64_t temp[3];
@@ -3245,7 +3245,7 @@ target_ulong helper_dextr_r_w(target_ulong ac, target_ulong shift,
     return (int64_t)(int32_t)(temp[0] >> 1);
 }
 
-target_ulong helper_dextr_rs_w(target_ulong ac, target_ulong shift,
+target_ulong HELPER(dextr_rs_w)(target_ulong ac, target_ulong shift,
                                CPUMIPSState *env)
 {
     uint64_t temp[3];
@@ -3277,7 +3277,7 @@ target_ulong helper_dextr_rs_w(target_ulong ac, target_ulong shift,
     return (int64_t)(int32_t)(temp[0] >> 1);
 }
 
-target_ulong helper_dextr_l(target_ulong ac, target_ulong shift,
+target_ulong HELPER(dextr_l)(target_ulong ac, target_ulong shift,
                             CPUMIPSState *env)
 {
     uint64_t temp[3];
@@ -3289,7 +3289,7 @@ target_ulong helper_dextr_l(target_ulong ac, target_ulong shift,
     return (temp[1] << 63) | (temp[0] >> 1);
 }
 
-target_ulong helper_dextr_r_l(target_ulong ac, target_ulong shift,
+target_ulong HELPER(dextr_r_l)(target_ulong ac, target_ulong shift,
                               CPUMIPSState *env)
 {
     uint64_t temp[3];
@@ -3316,7 +3316,7 @@ target_ulong helper_dextr_r_l(target_ulong ac, target_ulong shift,
     return (temp[1] << 63) | (temp[0] >> 1);
 }
 
-target_ulong helper_dextr_rs_l(target_ulong ac, target_ulong shift,
+target_ulong HELPER(dextr_rs_l)(target_ulong ac, target_ulong shift,
                                CPUMIPSState *env)
 {
     uint64_t temp[3];
@@ -3351,7 +3351,7 @@ target_ulong helper_dextr_rs_l(target_ulong ac, target_ulong shift,
 }
 #endif
 
-target_ulong helper_extr_s_h(target_ulong ac, target_ulong shift,
+target_ulong HELPER(extr_s_h)(target_ulong ac, target_ulong shift,
                              CPUMIPSState *env)
 {
     int64_t temp, acc;
@@ -3376,7 +3376,7 @@ target_ulong helper_extr_s_h(target_ulong ac, target_ulong shift,
 
 
 #if defined(TARGET_MIPS64)
-target_ulong helper_dextr_s_h(target_ulong ac, target_ulong shift,
+target_ulong HELPER(dextr_s_h)(target_ulong ac, target_ulong shift,
                               CPUMIPSState *env)
 {
     int64_t temp[2];
@@ -3405,7 +3405,7 @@ target_ulong helper_dextr_s_h(target_ulong ac, target_ulong shift,
 
 #endif
 
-target_ulong helper_extp(target_ulong ac, target_ulong size, CPUMIPSState *env)
+target_ulong HELPER(extp)(target_ulong ac, target_ulong size, CPUMIPSState *env)
 {
     int32_t start_pos;
     int sub;
@@ -3429,7 +3429,7 @@ target_ulong helper_extp(target_ulong ac, target_ulong size, CPUMIPSState *env)
     return (target_ulong)temp;
 }
 
-target_ulong helper_extpdp(target_ulong ac, target_ulong size,
+target_ulong HELPER(extpdp)(target_ulong ac, target_ulong size,
                            CPUMIPSState *env)
 {
     int32_t start_pos;
@@ -3457,7 +3457,8 @@ target_ulong helper_extpdp(target_ulong ac, target_ulong size,
 
 
 #if defined(TARGET_MIPS64)
-target_ulong helper_dextp(target_ulong ac, target_ulong size, CPUMIPSState *env)
+target_ulong HELPER(dextp)(target_ulong ac, target_ulong size,
+                           CPUMIPSState *env)
 {
     int start_pos;
     int len;
@@ -3486,7 +3487,7 @@ target_ulong helper_dextp(target_ulong ac, target_ulong size, CPUMIPSState *env)
     return temp;
 }
 
-target_ulong helper_dextpdp(target_ulong ac, target_ulong size,
+target_ulong HELPER(dextpdp)(target_ulong ac, target_ulong size,
                             CPUMIPSState *env)
 {
     int start_pos;
@@ -3518,7 +3519,7 @@ target_ulong helper_dextpdp(target_ulong ac, target_ulong size,
 
 #endif
 
-void helper_shilo(target_ulong ac, target_ulong rs, CPUMIPSState *env)
+void HELPER(shilo)(target_ulong ac, target_ulong rs, CPUMIPSState *env)
 {
     int8_t  rs5_0;
     uint64_t temp, acc;
@@ -3544,7 +3545,7 @@ void helper_shilo(target_ulong ac, target_ulong rs, CPUMIPSState *env)
 }
 
 #if defined(TARGET_MIPS64)
-void helper_dshilo(target_ulong shift, target_ulong ac, CPUMIPSState *env)
+void HELPER(dshilo)(target_ulong shift, target_ulong ac, CPUMIPSState *env)
 {
     int8_t shift_t;
     uint64_t tempB, tempA;
@@ -3570,7 +3571,7 @@ void helper_dshilo(target_ulong shift, target_ulong ac, CPUMIPSState *env)
 }
 
 #endif
-void helper_mthlip(target_ulong ac, target_ulong rs, CPUMIPSState *env)
+void HELPER(mthlip)(target_ulong ac, target_ulong rs, CPUMIPSState *env)
 {
     int32_t tempA, tempB, pos;
 
@@ -3588,7 +3589,7 @@ void helper_mthlip(target_ulong ac, target_ulong rs, CPUMIPSState *env)
 }
 
 #if defined(TARGET_MIPS64)
-void helper_dmthlip(target_ulong rs, target_ulong ac, CPUMIPSState *env)
+void HELPER(dmthlip)(target_ulong rs, target_ulong ac, CPUMIPSState *env)
 {
     uint8_t ac_t;
     uint8_t pos;
@@ -3677,7 +3678,7 @@ void cpu_wrdsp(uint32_t rs, uint32_t mask_num, CPUMIPSState *env)
     env->active_tc.DSPControl = dsp;
 }
 
-void helper_wrdsp(target_ulong rs, target_ulong mask_num, CPUMIPSState *env)
+void HELPER(wrdsp)(target_ulong rs, target_ulong mask_num, CPUMIPSState *env)
 {
     cpu_wrdsp(rs, mask_num, env);
 }
@@ -3733,7 +3734,7 @@ uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env)
     return temp;
 }
 
-target_ulong helper_rddsp(target_ulong mask_num, CPUMIPSState *env)
+target_ulong HELPER(rddsp)(target_ulong mask_num, CPUMIPSState *env)
 {
     return cpu_rddsp(mask_num, env);
 }
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index 630b8b809fa..8f555ae9912 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -44,18 +44,18 @@ target_ulong exception_resume_pc(CPUMIPSState *env)
     return bad_pc;
 }
 
-void helper_raise_exception_err(CPUMIPSState *env, uint32_t exception,
+void HELPER(raise_exception_err)(CPUMIPSState *env, uint32_t exception,
                                 int error_code)
 {
     do_raise_exception_err(env, exception, error_code, 0);
 }
 
-void helper_raise_exception(CPUMIPSState *env, uint32_t exception)
+void HELPER(raise_exception)(CPUMIPSState *env, uint32_t exception)
 {
     do_raise_exception(env, exception, GETPC());
 }
 
-void helper_raise_exception_debug(CPUMIPSState *env)
+void HELPER(raise_exception_debug)(CPUMIPSState *env)
 {
     do_raise_exception(env, EXCP_DEBUG, 0);
 }
@@ -65,7 +65,7 @@ static void raise_exception(CPUMIPSState *env, uint32_t exception)
     do_raise_exception(env, exception, 0);
 }
 
-void helper_wait(CPUMIPSState *env)
+void HELPER(wait)(CPUMIPSState *env)
 {
     CPUState *cs = env_cpu(env);
 
diff --git a/target/mips/tcg/fpu_helper.c b/target/mips/tcg/fpu_helper.c
index 36af9808025..d6595da6482 100644
--- a/target/mips/tcg/fpu_helper.c
+++ b/target/mips/tcg/fpu_helper.c
@@ -36,7 +36,7 @@
 #define FP_TO_INT32_OVERFLOW 0x7fffffff
 #define FP_TO_INT64_OVERFLOW 0x7fffffffffffffffULL
 
-target_ulong helper_cfc1(CPUMIPSState *env, uint32_t reg)
+target_ulong HELPER(cfc1)(CPUMIPSState *env, uint32_t reg)
 {
     target_ulong arg1 = 0;
 
@@ -61,7 +61,7 @@ target_ulong helper_cfc1(CPUMIPSState *env, uint32_t reg)
             if (env->CP0_Config5 & (1 << CP0C5_UFE)) {
                 arg1 = (env->CP0_Config5 >> CP0C5_FRE) & 1;
             } else {
-                helper_raise_exception(env, EXCP_RI);
+                HELPER(raise_exception)(env, EXCP_RI);
             }
         }
         break;
@@ -84,7 +84,8 @@ target_ulong helper_cfc1(CPUMIPSState *env, uint32_t reg)
     return arg1;
 }
 
-void helper_ctc1(CPUMIPSState *env, target_ulong arg1, uint32_t fs, uint32_t rt)
+void HELPER(ctc1)(CPUMIPSState *env, target_ulong arg1, uint32_t fs,
+                  uint32_t rt)
 {
     switch (fs) {
     case 1:
@@ -120,7 +121,7 @@ void helper_ctc1(CPUMIPSState *env, target_ulong arg1, uint32_t fs, uint32_t rt)
             env->CP0_Config5 &= ~(1 << CP0C5_FRE);
             compute_hflags(env);
         } else {
-            helper_raise_exception(env, EXCP_RI);
+            HELPER(raise_exception)(env, EXCP_RI);
         }
         break;
     case 6:
@@ -132,7 +133,7 @@ void helper_ctc1(CPUMIPSState *env, target_ulong arg1, uint32_t fs, uint32_t rt)
             env->CP0_Config5 |= (1 << CP0C5_FRE);
             compute_hflags(env);
         } else {
-            helper_raise_exception(env, EXCP_RI);
+            HELPER(raise_exception)(env, EXCP_RI);
         }
         break;
     case 25:
@@ -230,21 +231,21 @@ static inline void update_fcr31(CPUMIPSState *env, uintptr_t pc)
  */
 
 /* unary operations, modifying fp status  */
-uint64_t helper_float_sqrt_d(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_sqrt_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     fdt0 = float64_sqrt(fdt0, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
     return fdt0;
 }
 
-uint32_t helper_float_sqrt_s(CPUMIPSState *env, uint32_t fst0)
+uint32_t HELPER(float_sqrt_s)(CPUMIPSState *env, uint32_t fst0)
 {
     fst0 = float32_sqrt(fst0, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
     return fst0;
 }
 
-uint64_t helper_float_cvtd_s(CPUMIPSState *env, uint32_t fst0)
+uint64_t HELPER(float_cvtd_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint64_t fdt2;
 
@@ -253,7 +254,7 @@ uint64_t helper_float_cvtd_s(CPUMIPSState *env, uint32_t fst0)
     return fdt2;
 }
 
-uint64_t helper_float_cvtd_w(CPUMIPSState *env, uint32_t wt0)
+uint64_t HELPER(float_cvtd_w)(CPUMIPSState *env, uint32_t wt0)
 {
     uint64_t fdt2;
 
@@ -262,7 +263,7 @@ uint64_t helper_float_cvtd_w(CPUMIPSState *env, uint32_t wt0)
     return fdt2;
 }
 
-uint64_t helper_float_cvtd_l(CPUMIPSState *env, uint64_t dt0)
+uint64_t HELPER(float_cvtd_l)(CPUMIPSState *env, uint64_t dt0)
 {
     uint64_t fdt2;
 
@@ -271,7 +272,7 @@ uint64_t helper_float_cvtd_l(CPUMIPSState *env, uint64_t dt0)
     return fdt2;
 }
 
-uint64_t helper_float_cvt_l_d(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_cvt_l_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint64_t dt2;
 
@@ -284,7 +285,7 @@ uint64_t helper_float_cvt_l_d(CPUMIPSState *env, uint64_t fdt0)
     return dt2;
 }
 
-uint64_t helper_float_cvt_l_s(CPUMIPSState *env, uint32_t fst0)
+uint64_t HELPER(float_cvt_l_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint64_t dt2;
 
@@ -297,7 +298,7 @@ uint64_t helper_float_cvt_l_s(CPUMIPSState *env, uint32_t fst0)
     return dt2;
 }
 
-uint64_t helper_float_cvtps_pw(CPUMIPSState *env, uint64_t dt0)
+uint64_t HELPER(float_cvtps_pw)(CPUMIPSState *env, uint64_t dt0)
 {
     uint32_t fst2;
     uint32_t fsth2;
@@ -308,7 +309,7 @@ uint64_t helper_float_cvtps_pw(CPUMIPSState *env, uint64_t dt0)
     return ((uint64_t)fsth2 << 32) | fst2;
 }
 
-uint64_t helper_float_cvtpw_ps(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_cvtpw_ps)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint32_t wt2;
     uint32_t wth2;
@@ -333,7 +334,7 @@ uint64_t helper_float_cvtpw_ps(CPUMIPSState *env, uint64_t fdt0)
     return ((uint64_t)wth2 << 32) | wt2;
 }
 
-uint32_t helper_float_cvts_d(CPUMIPSState *env, uint64_t fdt0)
+uint32_t HELPER(float_cvts_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint32_t fst2;
 
@@ -342,7 +343,7 @@ uint32_t helper_float_cvts_d(CPUMIPSState *env, uint64_t fdt0)
     return fst2;
 }
 
-uint32_t helper_float_cvts_w(CPUMIPSState *env, uint32_t wt0)
+uint32_t HELPER(float_cvts_w)(CPUMIPSState *env, uint32_t wt0)
 {
     uint32_t fst2;
 
@@ -351,7 +352,7 @@ uint32_t helper_float_cvts_w(CPUMIPSState *env, uint32_t wt0)
     return fst2;
 }
 
-uint32_t helper_float_cvts_l(CPUMIPSState *env, uint64_t dt0)
+uint32_t HELPER(float_cvts_l)(CPUMIPSState *env, uint64_t dt0)
 {
     uint32_t fst2;
 
@@ -360,7 +361,7 @@ uint32_t helper_float_cvts_l(CPUMIPSState *env, uint64_t dt0)
     return fst2;
 }
 
-uint32_t helper_float_cvts_pl(CPUMIPSState *env, uint32_t wt0)
+uint32_t HELPER(float_cvts_pl)(CPUMIPSState *env, uint32_t wt0)
 {
     uint32_t wt2;
 
@@ -369,7 +370,7 @@ uint32_t helper_float_cvts_pl(CPUMIPSState *env, uint32_t wt0)
     return wt2;
 }
 
-uint32_t helper_float_cvts_pu(CPUMIPSState *env, uint32_t wth0)
+uint32_t HELPER(float_cvts_pu)(CPUMIPSState *env, uint32_t wth0)
 {
     uint32_t wt2;
 
@@ -378,7 +379,7 @@ uint32_t helper_float_cvts_pu(CPUMIPSState *env, uint32_t wth0)
     return wt2;
 }
 
-uint32_t helper_float_cvt_w_s(CPUMIPSState *env, uint32_t fst0)
+uint32_t HELPER(float_cvt_w_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint32_t wt2;
 
@@ -391,7 +392,7 @@ uint32_t helper_float_cvt_w_s(CPUMIPSState *env, uint32_t fst0)
     return wt2;
 }
 
-uint32_t helper_float_cvt_w_d(CPUMIPSState *env, uint64_t fdt0)
+uint32_t HELPER(float_cvt_w_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint32_t wt2;
 
@@ -404,7 +405,7 @@ uint32_t helper_float_cvt_w_d(CPUMIPSState *env, uint64_t fdt0)
     return wt2;
 }
 
-uint64_t helper_float_round_l_d(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_round_l_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint64_t dt2;
 
@@ -420,7 +421,7 @@ uint64_t helper_float_round_l_d(CPUMIPSState *env, uint64_t fdt0)
     return dt2;
 }
 
-uint64_t helper_float_round_l_s(CPUMIPSState *env, uint32_t fst0)
+uint64_t HELPER(float_round_l_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint64_t dt2;
 
@@ -436,7 +437,7 @@ uint64_t helper_float_round_l_s(CPUMIPSState *env, uint32_t fst0)
     return dt2;
 }
 
-uint32_t helper_float_round_w_d(CPUMIPSState *env, uint64_t fdt0)
+uint32_t HELPER(float_round_w_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint32_t wt2;
 
@@ -452,7 +453,7 @@ uint32_t helper_float_round_w_d(CPUMIPSState *env, uint64_t fdt0)
     return wt2;
 }
 
-uint32_t helper_float_round_w_s(CPUMIPSState *env, uint32_t fst0)
+uint32_t HELPER(float_round_w_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint32_t wt2;
 
@@ -468,7 +469,7 @@ uint32_t helper_float_round_w_s(CPUMIPSState *env, uint32_t fst0)
     return wt2;
 }
 
-uint64_t helper_float_trunc_l_d(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_trunc_l_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint64_t dt2;
 
@@ -482,7 +483,7 @@ uint64_t helper_float_trunc_l_d(CPUMIPSState *env, uint64_t fdt0)
     return dt2;
 }
 
-uint64_t helper_float_trunc_l_s(CPUMIPSState *env, uint32_t fst0)
+uint64_t HELPER(float_trunc_l_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint64_t dt2;
 
@@ -495,7 +496,7 @@ uint64_t helper_float_trunc_l_s(CPUMIPSState *env, uint32_t fst0)
     return dt2;
 }
 
-uint32_t helper_float_trunc_w_d(CPUMIPSState *env, uint64_t fdt0)
+uint32_t HELPER(float_trunc_w_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint32_t wt2;
 
@@ -508,7 +509,7 @@ uint32_t helper_float_trunc_w_d(CPUMIPSState *env, uint64_t fdt0)
     return wt2;
 }
 
-uint32_t helper_float_trunc_w_s(CPUMIPSState *env, uint32_t fst0)
+uint32_t HELPER(float_trunc_w_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint32_t wt2;
 
@@ -521,7 +522,7 @@ uint32_t helper_float_trunc_w_s(CPUMIPSState *env, uint32_t fst0)
     return wt2;
 }
 
-uint64_t helper_float_ceil_l_d(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_ceil_l_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint64_t dt2;
 
@@ -536,7 +537,7 @@ uint64_t helper_float_ceil_l_d(CPUMIPSState *env, uint64_t fdt0)
     return dt2;
 }
 
-uint64_t helper_float_ceil_l_s(CPUMIPSState *env, uint32_t fst0)
+uint64_t HELPER(float_ceil_l_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint64_t dt2;
 
@@ -551,7 +552,7 @@ uint64_t helper_float_ceil_l_s(CPUMIPSState *env, uint32_t fst0)
     return dt2;
 }
 
-uint32_t helper_float_ceil_w_d(CPUMIPSState *env, uint64_t fdt0)
+uint32_t HELPER(float_ceil_w_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint32_t wt2;
 
@@ -566,7 +567,7 @@ uint32_t helper_float_ceil_w_d(CPUMIPSState *env, uint64_t fdt0)
     return wt2;
 }
 
-uint32_t helper_float_ceil_w_s(CPUMIPSState *env, uint32_t fst0)
+uint32_t HELPER(float_ceil_w_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint32_t wt2;
 
@@ -581,7 +582,7 @@ uint32_t helper_float_ceil_w_s(CPUMIPSState *env, uint32_t fst0)
     return wt2;
 }
 
-uint64_t helper_float_floor_l_d(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_floor_l_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint64_t dt2;
 
@@ -596,7 +597,7 @@ uint64_t helper_float_floor_l_d(CPUMIPSState *env, uint64_t fdt0)
     return dt2;
 }
 
-uint64_t helper_float_floor_l_s(CPUMIPSState *env, uint32_t fst0)
+uint64_t HELPER(float_floor_l_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint64_t dt2;
 
@@ -611,7 +612,7 @@ uint64_t helper_float_floor_l_s(CPUMIPSState *env, uint32_t fst0)
     return dt2;
 }
 
-uint32_t helper_float_floor_w_d(CPUMIPSState *env, uint64_t fdt0)
+uint32_t HELPER(float_floor_w_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint32_t wt2;
 
@@ -626,7 +627,7 @@ uint32_t helper_float_floor_w_d(CPUMIPSState *env, uint64_t fdt0)
     return wt2;
 }
 
-uint32_t helper_float_floor_w_s(CPUMIPSState *env, uint32_t fst0)
+uint32_t HELPER(float_floor_w_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint32_t wt2;
 
@@ -641,7 +642,7 @@ uint32_t helper_float_floor_w_s(CPUMIPSState *env, uint32_t fst0)
     return wt2;
 }
 
-uint64_t helper_float_cvt_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_cvt_2008_l_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint64_t dt2;
 
@@ -656,7 +657,7 @@ uint64_t helper_float_cvt_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
     return dt2;
 }
 
-uint64_t helper_float_cvt_2008_l_s(CPUMIPSState *env, uint32_t fst0)
+uint64_t HELPER(float_cvt_2008_l_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint64_t dt2;
 
@@ -671,7 +672,7 @@ uint64_t helper_float_cvt_2008_l_s(CPUMIPSState *env, uint32_t fst0)
     return dt2;
 }
 
-uint32_t helper_float_cvt_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
+uint32_t HELPER(float_cvt_2008_w_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint32_t wt2;
 
@@ -686,7 +687,7 @@ uint32_t helper_float_cvt_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
     return wt2;
 }
 
-uint32_t helper_float_cvt_2008_w_s(CPUMIPSState *env, uint32_t fst0)
+uint32_t HELPER(float_cvt_2008_w_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint32_t wt2;
 
@@ -701,7 +702,7 @@ uint32_t helper_float_cvt_2008_w_s(CPUMIPSState *env, uint32_t fst0)
     return wt2;
 }
 
-uint64_t helper_float_round_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_round_2008_l_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint64_t dt2;
 
@@ -719,7 +720,7 @@ uint64_t helper_float_round_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
     return dt2;
 }
 
-uint64_t helper_float_round_2008_l_s(CPUMIPSState *env, uint32_t fst0)
+uint64_t HELPER(float_round_2008_l_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint64_t dt2;
 
@@ -737,7 +738,7 @@ uint64_t helper_float_round_2008_l_s(CPUMIPSState *env, uint32_t fst0)
     return dt2;
 }
 
-uint32_t helper_float_round_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
+uint32_t HELPER(float_round_2008_w_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint32_t wt2;
 
@@ -755,7 +756,7 @@ uint32_t helper_float_round_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
     return wt2;
 }
 
-uint32_t helper_float_round_2008_w_s(CPUMIPSState *env, uint32_t fst0)
+uint32_t HELPER(float_round_2008_w_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint32_t wt2;
 
@@ -773,7 +774,7 @@ uint32_t helper_float_round_2008_w_s(CPUMIPSState *env, uint32_t fst0)
     return wt2;
 }
 
-uint64_t helper_float_trunc_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_trunc_2008_l_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint64_t dt2;
 
@@ -788,7 +789,7 @@ uint64_t helper_float_trunc_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
     return dt2;
 }
 
-uint64_t helper_float_trunc_2008_l_s(CPUMIPSState *env, uint32_t fst0)
+uint64_t HELPER(float_trunc_2008_l_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint64_t dt2;
 
@@ -803,7 +804,7 @@ uint64_t helper_float_trunc_2008_l_s(CPUMIPSState *env, uint32_t fst0)
     return dt2;
 }
 
-uint32_t helper_float_trunc_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
+uint32_t HELPER(float_trunc_2008_w_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint32_t wt2;
 
@@ -818,7 +819,7 @@ uint32_t helper_float_trunc_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
     return wt2;
 }
 
-uint32_t helper_float_trunc_2008_w_s(CPUMIPSState *env, uint32_t fst0)
+uint32_t HELPER(float_trunc_2008_w_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint32_t wt2;
 
@@ -833,7 +834,7 @@ uint32_t helper_float_trunc_2008_w_s(CPUMIPSState *env, uint32_t fst0)
     return wt2;
 }
 
-uint64_t helper_float_ceil_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_ceil_2008_l_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint64_t dt2;
 
@@ -850,7 +851,7 @@ uint64_t helper_float_ceil_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
     return dt2;
 }
 
-uint64_t helper_float_ceil_2008_l_s(CPUMIPSState *env, uint32_t fst0)
+uint64_t HELPER(float_ceil_2008_l_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint64_t dt2;
 
@@ -867,7 +868,7 @@ uint64_t helper_float_ceil_2008_l_s(CPUMIPSState *env, uint32_t fst0)
     return dt2;
 }
 
-uint32_t helper_float_ceil_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
+uint32_t HELPER(float_ceil_2008_w_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint32_t wt2;
 
@@ -884,7 +885,7 @@ uint32_t helper_float_ceil_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
     return wt2;
 }
 
-uint32_t helper_float_ceil_2008_w_s(CPUMIPSState *env, uint32_t fst0)
+uint32_t HELPER(float_ceil_2008_w_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint32_t wt2;
 
@@ -901,7 +902,7 @@ uint32_t helper_float_ceil_2008_w_s(CPUMIPSState *env, uint32_t fst0)
     return wt2;
 }
 
-uint64_t helper_float_floor_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_floor_2008_l_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint64_t dt2;
 
@@ -918,7 +919,7 @@ uint64_t helper_float_floor_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
     return dt2;
 }
 
-uint64_t helper_float_floor_2008_l_s(CPUMIPSState *env, uint32_t fst0)
+uint64_t HELPER(float_floor_2008_l_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint64_t dt2;
 
@@ -935,7 +936,7 @@ uint64_t helper_float_floor_2008_l_s(CPUMIPSState *env, uint32_t fst0)
     return dt2;
 }
 
-uint32_t helper_float_floor_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
+uint32_t HELPER(float_floor_2008_w_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint32_t wt2;
 
@@ -952,7 +953,7 @@ uint32_t helper_float_floor_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
     return wt2;
 }
 
-uint32_t helper_float_floor_2008_w_s(CPUMIPSState *env, uint32_t fst0)
+uint32_t HELPER(float_floor_2008_w_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint32_t wt2;
 
@@ -971,17 +972,17 @@ uint32_t helper_float_floor_2008_w_s(CPUMIPSState *env, uint32_t fst0)
 
 /* unary operations, not modifying fp status  */
 
-uint64_t helper_float_abs_d(uint64_t fdt0)
+uint64_t HELPER(float_abs_d)(uint64_t fdt0)
 {
    return float64_abs(fdt0);
 }
 
-uint32_t helper_float_abs_s(uint32_t fst0)
+uint32_t HELPER(float_abs_s)(uint32_t fst0)
 {
     return float32_abs(fst0);
 }
 
-uint64_t helper_float_abs_ps(uint64_t fdt0)
+uint64_t HELPER(float_abs_ps)(uint64_t fdt0)
 {
     uint32_t wt0;
     uint32_t wth0;
@@ -991,17 +992,17 @@ uint64_t helper_float_abs_ps(uint64_t fdt0)
     return ((uint64_t)wth0 << 32) | wt0;
 }
 
-uint64_t helper_float_chs_d(uint64_t fdt0)
+uint64_t HELPER(float_chs_d)(uint64_t fdt0)
 {
    return float64_chs(fdt0);
 }
 
-uint32_t helper_float_chs_s(uint32_t fst0)
+uint32_t HELPER(float_chs_s)(uint32_t fst0)
 {
     return float32_chs(fst0);
 }
 
-uint64_t helper_float_chs_ps(uint64_t fdt0)
+uint64_t HELPER(float_chs_ps)(uint64_t fdt0)
 {
     uint32_t wt0;
     uint32_t wth0;
@@ -1012,7 +1013,7 @@ uint64_t helper_float_chs_ps(uint64_t fdt0)
 }
 
 /* MIPS specific unary operations */
-uint64_t helper_float_recip_d(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_recip_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint64_t fdt2;
 
@@ -1021,7 +1022,7 @@ uint64_t helper_float_recip_d(CPUMIPSState *env, uint64_t fdt0)
     return fdt2;
 }
 
-uint32_t helper_float_recip_s(CPUMIPSState *env, uint32_t fst0)
+uint32_t HELPER(float_recip_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint32_t fst2;
 
@@ -1030,7 +1031,7 @@ uint32_t helper_float_recip_s(CPUMIPSState *env, uint32_t fst0)
     return fst2;
 }
 
-uint64_t helper_float_rsqrt_d(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_rsqrt_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint64_t fdt2;
 
@@ -1040,7 +1041,7 @@ uint64_t helper_float_rsqrt_d(CPUMIPSState *env, uint64_t fdt0)
     return fdt2;
 }
 
-uint32_t helper_float_rsqrt_s(CPUMIPSState *env, uint32_t fst0)
+uint32_t HELPER(float_rsqrt_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint32_t fst2;
 
@@ -1050,7 +1051,7 @@ uint32_t helper_float_rsqrt_s(CPUMIPSState *env, uint32_t fst0)
     return fst2;
 }
 
-uint64_t helper_float_recip1_d(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_recip1_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint64_t fdt2;
 
@@ -1059,7 +1060,7 @@ uint64_t helper_float_recip1_d(CPUMIPSState *env, uint64_t fdt0)
     return fdt2;
 }
 
-uint32_t helper_float_recip1_s(CPUMIPSState *env, uint32_t fst0)
+uint32_t HELPER(float_recip1_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint32_t fst2;
 
@@ -1068,7 +1069,7 @@ uint32_t helper_float_recip1_s(CPUMIPSState *env, uint32_t fst0)
     return fst2;
 }
 
-uint64_t helper_float_recip1_ps(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_recip1_ps)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint32_t fstl2;
     uint32_t fsth2;
@@ -1080,7 +1081,7 @@ uint64_t helper_float_recip1_ps(CPUMIPSState *env, uint64_t fdt0)
     return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
-uint64_t helper_float_rsqrt1_d(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_rsqrt1_d)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint64_t fdt2;
 
@@ -1090,7 +1091,7 @@ uint64_t helper_float_rsqrt1_d(CPUMIPSState *env, uint64_t fdt0)
     return fdt2;
 }
 
-uint32_t helper_float_rsqrt1_s(CPUMIPSState *env, uint32_t fst0)
+uint32_t HELPER(float_rsqrt1_s)(CPUMIPSState *env, uint32_t fst0)
 {
     uint32_t fst2;
 
@@ -1100,7 +1101,7 @@ uint32_t helper_float_rsqrt1_s(CPUMIPSState *env, uint32_t fst0)
     return fst2;
 }
 
-uint64_t helper_float_rsqrt1_ps(CPUMIPSState *env, uint64_t fdt0)
+uint64_t HELPER(float_rsqrt1_ps)(CPUMIPSState *env, uint64_t fdt0)
 {
     uint32_t fstl2;
     uint32_t fsth2;
@@ -1113,7 +1114,7 @@ uint64_t helper_float_rsqrt1_ps(CPUMIPSState *env, uint64_t fdt0)
     return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
-uint64_t helper_float_rint_d(CPUMIPSState *env, uint64_t fs)
+uint64_t HELPER(float_rint_d)(CPUMIPSState *env, uint64_t fs)
 {
     uint64_t fdret;
 
@@ -1122,7 +1123,7 @@ uint64_t helper_float_rint_d(CPUMIPSState *env, uint64_t fs)
     return fdret;
 }
 
-uint32_t helper_float_rint_s(CPUMIPSState *env, uint32_t fs)
+uint32_t HELPER(float_rint_s)(CPUMIPSState *env, uint32_t fs)
 {
     uint32_t fdret;
 
@@ -1171,7 +1172,7 @@ uint64_t float_class_d(uint64_t arg, float_status *status)
     }
 }
 
-uint64_t helper_float_class_d(CPUMIPSState *env, uint64_t arg)
+uint64_t HELPER(float_class_d)(CPUMIPSState *env, uint64_t arg)
 {
     return float_class_d(arg, &env->active_fpu.fp_status);
 }
@@ -1205,15 +1206,15 @@ uint32_t float_class_s(uint32_t arg, float_status *status)
     }
 }
 
-uint32_t helper_float_class_s(CPUMIPSState *env, uint32_t arg)
+uint32_t HELPER(float_class_s)(CPUMIPSState *env, uint32_t arg)
 {
     return float_class_s(arg, &env->active_fpu.fp_status);
 }
 
 /* binary operations */
 
-uint64_t helper_float_add_d(CPUMIPSState *env,
-                            uint64_t fdt0, uint64_t fdt1)
+uint64_t HELPER(float_add_d)(CPUMIPSState *env,
+                             uint64_t fdt0, uint64_t fdt1)
 {
     uint64_t dt2;
 
@@ -1222,8 +1223,8 @@ uint64_t helper_float_add_d(CPUMIPSState *env,
     return dt2;
 }
 
-uint32_t helper_float_add_s(CPUMIPSState *env,
-                            uint32_t fst0, uint32_t fst1)
+uint32_t HELPER(float_add_s)(CPUMIPSState *env,
+                             uint32_t fst0, uint32_t fst1)
 {
     uint32_t wt2;
 
@@ -1232,8 +1233,8 @@ uint32_t helper_float_add_s(CPUMIPSState *env,
     return wt2;
 }
 
-uint64_t helper_float_add_ps(CPUMIPSState *env,
-                             uint64_t fdt0, uint64_t fdt1)
+uint64_t HELPER(float_add_ps)(CPUMIPSState *env,
+                              uint64_t fdt0, uint64_t fdt1)
 {
     uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
@@ -1248,8 +1249,8 @@ uint64_t helper_float_add_ps(CPUMIPSState *env,
     return ((uint64_t)wth2 << 32) | wtl2;
 }
 
-uint64_t helper_float_sub_d(CPUMIPSState *env,
-                            uint64_t fdt0, uint64_t fdt1)
+uint64_t HELPER(float_sub_d)(CPUMIPSState *env,
+                             uint64_t fdt0, uint64_t fdt1)
 {
     uint64_t dt2;
 
@@ -1258,8 +1259,8 @@ uint64_t helper_float_sub_d(CPUMIPSState *env,
     return dt2;
 }
 
-uint32_t helper_float_sub_s(CPUMIPSState *env,
-                            uint32_t fst0, uint32_t fst1)
+uint32_t HELPER(float_sub_s)(CPUMIPSState *env,
+                             uint32_t fst0, uint32_t fst1)
 {
     uint32_t wt2;
 
@@ -1268,8 +1269,8 @@ uint32_t helper_float_sub_s(CPUMIPSState *env,
     return wt2;
 }
 
-uint64_t helper_float_sub_ps(CPUMIPSState *env,
-                             uint64_t fdt0, uint64_t fdt1)
+uint64_t HELPER(float_sub_ps)(CPUMIPSState *env,
+                              uint64_t fdt0, uint64_t fdt1)
 {
     uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
@@ -1284,8 +1285,8 @@ uint64_t helper_float_sub_ps(CPUMIPSState *env,
     return ((uint64_t)wth2 << 32) | wtl2;
 }
 
-uint64_t helper_float_mul_d(CPUMIPSState *env,
-                            uint64_t fdt0, uint64_t fdt1)
+uint64_t HELPER(float_mul_d)(CPUMIPSState *env,
+                             uint64_t fdt0, uint64_t fdt1)
 {
     uint64_t dt2;
 
@@ -1294,8 +1295,8 @@ uint64_t helper_float_mul_d(CPUMIPSState *env,
     return dt2;
 }
 
-uint32_t helper_float_mul_s(CPUMIPSState *env,
-                            uint32_t fst0, uint32_t fst1)
+uint32_t HELPER(float_mul_s)(CPUMIPSState *env,
+                             uint32_t fst0, uint32_t fst1)
 {
     uint32_t wt2;
 
@@ -1304,8 +1305,8 @@ uint32_t helper_float_mul_s(CPUMIPSState *env,
     return wt2;
 }
 
-uint64_t helper_float_mul_ps(CPUMIPSState *env,
-                             uint64_t fdt0, uint64_t fdt1)
+uint64_t HELPER(float_mul_ps)(CPUMIPSState *env,
+                              uint64_t fdt0, uint64_t fdt1)
 {
     uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
@@ -1320,8 +1321,8 @@ uint64_t helper_float_mul_ps(CPUMIPSState *env,
     return ((uint64_t)wth2 << 32) | wtl2;
 }
 
-uint64_t helper_float_div_d(CPUMIPSState *env,
-                            uint64_t fdt0, uint64_t fdt1)
+uint64_t HELPER(float_div_d)(CPUMIPSState *env,
+                             uint64_t fdt0, uint64_t fdt1)
 {
     uint64_t dt2;
 
@@ -1330,8 +1331,8 @@ uint64_t helper_float_div_d(CPUMIPSState *env,
     return dt2;
 }
 
-uint32_t helper_float_div_s(CPUMIPSState *env,
-                            uint32_t fst0, uint32_t fst1)
+uint32_t HELPER(float_div_s)(CPUMIPSState *env,
+                             uint32_t fst0, uint32_t fst1)
 {
     uint32_t wt2;
 
@@ -1340,8 +1341,8 @@ uint32_t helper_float_div_s(CPUMIPSState *env,
     return wt2;
 }
 
-uint64_t helper_float_div_ps(CPUMIPSState *env,
-                             uint64_t fdt0, uint64_t fdt1)
+uint64_t HELPER(float_div_ps)(CPUMIPSState *env,
+                              uint64_t fdt0, uint64_t fdt1)
 {
     uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
@@ -1358,7 +1359,7 @@ uint64_t helper_float_div_ps(CPUMIPSState *env,
 
 
 /* MIPS specific binary operations */
-uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
+uint64_t HELPER(float_recip2_d)(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
 {
     fdt2 = float64_mul(fdt0, fdt2, &env->active_fpu.fp_status);
     fdt2 = float64_chs(float64_sub(fdt2, float64_one,
@@ -1367,7 +1368,7 @@ uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
     return fdt2;
 }
 
-uint32_t helper_float_recip2_s(CPUMIPSState *env, uint32_t fst0, uint32_t fst2)
+uint32_t HELPER(float_recip2_s)(CPUMIPSState *env, uint32_t fst0, uint32_t fst2)
 {
     fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
     fst2 = float32_chs(float32_sub(fst2, float32_one,
@@ -1376,7 +1377,8 @@ uint32_t helper_float_recip2_s(CPUMIPSState *env, uint32_t fst0, uint32_t fst2)
     return fst2;
 }
 
-uint64_t helper_float_recip2_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
+uint64_t HELPER(float_recip2_ps)(CPUMIPSState *env, uint64_t fdt0,
+                                 uint64_t fdt2)
 {
     uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
@@ -1393,7 +1395,7 @@ uint64_t helper_float_recip2_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
     return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
-uint64_t helper_float_rsqrt2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
+uint64_t HELPER(float_rsqrt2_d)(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
 {
     fdt2 = float64_mul(fdt0, fdt2, &env->active_fpu.fp_status);
     fdt2 = float64_sub(fdt2, float64_one, &env->active_fpu.fp_status);
@@ -1403,7 +1405,7 @@ uint64_t helper_float_rsqrt2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
     return fdt2;
 }
 
-uint32_t helper_float_rsqrt2_s(CPUMIPSState *env, uint32_t fst0, uint32_t fst2)
+uint32_t HELPER(float_rsqrt2_s)(CPUMIPSState *env, uint32_t fst0, uint32_t fst2)
 {
     fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
     fst2 = float32_sub(fst2, float32_one, &env->active_fpu.fp_status);
@@ -1413,7 +1415,8 @@ uint32_t helper_float_rsqrt2_s(CPUMIPSState *env, uint32_t fst0, uint32_t fst2)
     return fst2;
 }
 
-uint64_t helper_float_rsqrt2_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
+uint64_t HELPER(float_rsqrt2_ps)(CPUMIPSState *env, uint64_t fdt0,
+                                 uint64_t fdt2)
 {
     uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
@@ -1432,7 +1435,7 @@ uint64_t helper_float_rsqrt2_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
     return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
-uint64_t helper_float_addr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
+uint64_t HELPER(float_addr_ps)(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
 {
     uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
@@ -1447,7 +1450,7 @@ uint64_t helper_float_addr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
     return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
-uint64_t helper_float_mulr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
+uint64_t HELPER(float_mulr_ps)(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
 {
     uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
@@ -1463,7 +1466,7 @@ uint64_t helper_float_mulr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
 }
 
 
-uint32_t helper_float_max_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
+uint32_t HELPER(float_max_s)(CPUMIPSState *env, uint32_t fs, uint32_t ft)
 {
     uint32_t fdret;
 
@@ -1473,7 +1476,7 @@ uint32_t helper_float_max_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
     return fdret;
 }
 
-uint64_t helper_float_max_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
+uint64_t HELPER(float_max_d)(CPUMIPSState *env, uint64_t fs, uint64_t ft)
 {
     uint64_t fdret;
 
@@ -1483,7 +1486,7 @@ uint64_t helper_float_max_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
     return fdret;
 }
 
-uint32_t helper_float_maxa_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
+uint32_t HELPER(float_maxa_s)(CPUMIPSState *env, uint32_t fs, uint32_t ft)
 {
     uint32_t fdret;
 
@@ -1493,7 +1496,7 @@ uint32_t helper_float_maxa_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
     return fdret;
 }
 
-uint64_t helper_float_maxa_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
+uint64_t HELPER(float_maxa_d)(CPUMIPSState *env, uint64_t fs, uint64_t ft)
 {
     uint64_t fdret;
 
@@ -1503,7 +1506,7 @@ uint64_t helper_float_maxa_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
     return fdret;
 }
 
-uint32_t helper_float_min_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
+uint32_t HELPER(float_min_s)(CPUMIPSState *env, uint32_t fs, uint32_t ft)
 {
     uint32_t fdret;
 
@@ -1513,7 +1516,7 @@ uint32_t helper_float_min_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
     return fdret;
 }
 
-uint64_t helper_float_min_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
+uint64_t HELPER(float_min_d)(CPUMIPSState *env, uint64_t fs, uint64_t ft)
 {
     uint64_t fdret;
 
@@ -1523,7 +1526,7 @@ uint64_t helper_float_min_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
     return fdret;
 }
 
-uint32_t helper_float_mina_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
+uint32_t HELPER(float_mina_s)(CPUMIPSState *env, uint32_t fs, uint32_t ft)
 {
     uint32_t fdret;
 
@@ -1533,7 +1536,7 @@ uint32_t helper_float_mina_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
     return fdret;
 }
 
-uint64_t helper_float_mina_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
+uint64_t HELPER(float_mina_d)(CPUMIPSState *env, uint64_t fs, uint64_t ft)
 {
     uint64_t fdret;
 
@@ -1546,8 +1549,8 @@ uint64_t helper_float_mina_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
 
 /* ternary operations */
 
-uint64_t helper_float_madd_d(CPUMIPSState *env, uint64_t fst0,
-                             uint64_t fst1, uint64_t fst2)
+uint64_t HELPER(float_madd_d)(CPUMIPSState *env, uint64_t fst0,
+                              uint64_t fst1, uint64_t fst2)
 {
     fst0 = float64_mul(fst0, fst1, &env->active_fpu.fp_status);
     fst0 = float64_add(fst0, fst2, &env->active_fpu.fp_status);
@@ -1556,8 +1559,8 @@ uint64_t helper_float_madd_d(CPUMIPSState *env, uint64_t fst0,
     return fst0;
 }
 
-uint32_t helper_float_madd_s(CPUMIPSState *env, uint32_t fst0,
-                             uint32_t fst1, uint32_t fst2)
+uint32_t HELPER(float_madd_s)(CPUMIPSState *env, uint32_t fst0,
+                              uint32_t fst1, uint32_t fst2)
 {
     fst0 = float32_mul(fst0, fst1, &env->active_fpu.fp_status);
     fst0 = float32_add(fst0, fst2, &env->active_fpu.fp_status);
@@ -1566,8 +1569,8 @@ uint32_t helper_float_madd_s(CPUMIPSState *env, uint32_t fst0,
     return fst0;
 }
 
-uint64_t helper_float_madd_ps(CPUMIPSState *env, uint64_t fdt0,
-                              uint64_t fdt1, uint64_t fdt2)
+uint64_t HELPER(float_madd_ps)(CPUMIPSState *env, uint64_t fdt0,
+                               uint64_t fdt1, uint64_t fdt2)
 {
     uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
@@ -1585,7 +1588,7 @@ uint64_t helper_float_madd_ps(CPUMIPSState *env, uint64_t fdt0,
     return ((uint64_t)fsth0 << 32) | fstl0;
 }
 
-uint64_t helper_float_msub_d(CPUMIPSState *env, uint64_t fst0,
+uint64_t HELPER(float_msub_d)(CPUMIPSState *env, uint64_t fst0,
                              uint64_t fst1, uint64_t fst2)
 {
     fst0 = float64_mul(fst0, fst1, &env->active_fpu.fp_status);
@@ -1595,7 +1598,7 @@ uint64_t helper_float_msub_d(CPUMIPSState *env, uint64_t fst0,
     return fst0;
 }
 
-uint32_t helper_float_msub_s(CPUMIPSState *env, uint32_t fst0,
+uint32_t HELPER(float_msub_s)(CPUMIPSState *env, uint32_t fst0,
                              uint32_t fst1, uint32_t fst2)
 {
     fst0 = float32_mul(fst0, fst1, &env->active_fpu.fp_status);
@@ -1605,7 +1608,7 @@ uint32_t helper_float_msub_s(CPUMIPSState *env, uint32_t fst0,
     return fst0;
 }
 
-uint64_t helper_float_msub_ps(CPUMIPSState *env, uint64_t fdt0,
+uint64_t HELPER(float_msub_ps)(CPUMIPSState *env, uint64_t fdt0,
                               uint64_t fdt1, uint64_t fdt2)
 {
     uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
@@ -1624,7 +1627,7 @@ uint64_t helper_float_msub_ps(CPUMIPSState *env, uint64_t fdt0,
     return ((uint64_t)fsth0 << 32) | fstl0;
 }
 
-uint64_t helper_float_nmadd_d(CPUMIPSState *env, uint64_t fst0,
+uint64_t HELPER(float_nmadd_d)(CPUMIPSState *env, uint64_t fst0,
                              uint64_t fst1, uint64_t fst2)
 {
     fst0 = float64_mul(fst0, fst1, &env->active_fpu.fp_status);
@@ -1635,7 +1638,7 @@ uint64_t helper_float_nmadd_d(CPUMIPSState *env, uint64_t fst0,
     return fst0;
 }
 
-uint32_t helper_float_nmadd_s(CPUMIPSState *env, uint32_t fst0,
+uint32_t HELPER(float_nmadd_s)(CPUMIPSState *env, uint32_t fst0,
                              uint32_t fst1, uint32_t fst2)
 {
     fst0 = float32_mul(fst0, fst1, &env->active_fpu.fp_status);
@@ -1646,7 +1649,7 @@ uint32_t helper_float_nmadd_s(CPUMIPSState *env, uint32_t fst0,
     return fst0;
 }
 
-uint64_t helper_float_nmadd_ps(CPUMIPSState *env, uint64_t fdt0,
+uint64_t HELPER(float_nmadd_ps)(CPUMIPSState *env, uint64_t fdt0,
                               uint64_t fdt1, uint64_t fdt2)
 {
     uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
@@ -1667,7 +1670,7 @@ uint64_t helper_float_nmadd_ps(CPUMIPSState *env, uint64_t fdt0,
     return ((uint64_t)fsth0 << 32) | fstl0;
 }
 
-uint64_t helper_float_nmsub_d(CPUMIPSState *env, uint64_t fst0,
+uint64_t HELPER(float_nmsub_d)(CPUMIPSState *env, uint64_t fst0,
                              uint64_t fst1, uint64_t fst2)
 {
     fst0 = float64_mul(fst0, fst1, &env->active_fpu.fp_status);
@@ -1678,7 +1681,7 @@ uint64_t helper_float_nmsub_d(CPUMIPSState *env, uint64_t fst0,
     return fst0;
 }
 
-uint32_t helper_float_nmsub_s(CPUMIPSState *env, uint32_t fst0,
+uint32_t HELPER(float_nmsub_s)(CPUMIPSState *env, uint32_t fst0,
                              uint32_t fst1, uint32_t fst2)
 {
     fst0 = float32_mul(fst0, fst1, &env->active_fpu.fp_status);
@@ -1689,7 +1692,7 @@ uint32_t helper_float_nmsub_s(CPUMIPSState *env, uint32_t fst0,
     return fst0;
 }
 
-uint64_t helper_float_nmsub_ps(CPUMIPSState *env, uint64_t fdt0,
+uint64_t HELPER(float_nmsub_ps)(CPUMIPSState *env, uint64_t fdt0,
                               uint64_t fdt1, uint64_t fdt2)
 {
     uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
@@ -1711,7 +1714,7 @@ uint64_t helper_float_nmsub_ps(CPUMIPSState *env, uint64_t fdt0,
 }
 
 
-uint32_t helper_float_maddf_s(CPUMIPSState *env, uint32_t fs,
+uint32_t HELPER(float_maddf_s)(CPUMIPSState *env, uint32_t fs,
                               uint32_t ft, uint32_t fd)
 {
     uint32_t fdret;
@@ -1723,7 +1726,7 @@ uint32_t helper_float_maddf_s(CPUMIPSState *env, uint32_t fs,
     return fdret;
 }
 
-uint64_t helper_float_maddf_d(CPUMIPSState *env, uint64_t fs,
+uint64_t HELPER(float_maddf_d)(CPUMIPSState *env, uint64_t fs,
                               uint64_t ft, uint64_t fd)
 {
     uint64_t fdret;
@@ -1735,7 +1738,7 @@ uint64_t helper_float_maddf_d(CPUMIPSState *env, uint64_t fs,
     return fdret;
 }
 
-uint32_t helper_float_msubf_s(CPUMIPSState *env, uint32_t fs,
+uint32_t HELPER(float_msubf_s)(CPUMIPSState *env, uint32_t fs,
                               uint32_t ft, uint32_t fd)
 {
     uint32_t fdret;
@@ -1747,7 +1750,7 @@ uint32_t helper_float_msubf_s(CPUMIPSState *env, uint32_t fs,
     return fdret;
 }
 
-uint64_t helper_float_msubf_d(CPUMIPSState *env, uint64_t fs,
+uint64_t HELPER(float_msubf_d)(CPUMIPSState *env, uint64_t fs,
                               uint64_t ft, uint64_t fd)
 {
     uint64_t fdret;
@@ -1762,7 +1765,7 @@ uint64_t helper_float_msubf_d(CPUMIPSState *env, uint64_t fs,
 
 /* compare operations */
 #define FOP_COND_D(op, cond)                                   \
-void helper_cmp_d_ ## op(CPUMIPSState *env, uint64_t fdt0,     \
+void HELPER(cmp_d_ ## op)(CPUMIPSState *env, uint64_t fdt0,    \
                          uint64_t fdt1, int cc)                \
 {                                                              \
     int c;                                                     \
@@ -1773,7 +1776,7 @@ void helper_cmp_d_ ## op(CPUMIPSState *env, uint64_t fdt0,     \
     else                                                       \
         CLEAR_FP_COND(cc, env->active_fpu);                    \
 }                                                              \
-void helper_cmpabs_d_ ## op(CPUMIPSState *env, uint64_t fdt0,  \
+void HELPER(cmpabs_d_ ## op)(CPUMIPSState *env, uint64_t fdt0, \
                             uint64_t fdt1, int cc)             \
 {                                                              \
     int c;                                                     \
@@ -1841,7 +1844,7 @@ FOP_COND_D(ngt,  float64_unordered(fdt1, fdt0,
                                        &env->active_fpu.fp_status))
 
 #define FOP_COND_S(op, cond)                                   \
-void helper_cmp_s_ ## op(CPUMIPSState *env, uint32_t fst0,     \
+void HELPER(cmp_s_ ## op)(CPUMIPSState *env, uint32_t fst0,    \
                          uint32_t fst1, int cc)                \
 {                                                              \
     int c;                                                     \
@@ -1852,7 +1855,7 @@ void helper_cmp_s_ ## op(CPUMIPSState *env, uint32_t fst0,     \
     else                                                       \
         CLEAR_FP_COND(cc, env->active_fpu);                    \
 }                                                              \
-void helper_cmpabs_s_ ## op(CPUMIPSState *env, uint32_t fst0,  \
+void HELPER(cmpabs_s_ ## op)(CPUMIPSState *env, uint32_t fst0, \
                             uint32_t fst1, int cc)             \
 {                                                              \
     int c;                                                     \
@@ -1920,7 +1923,7 @@ FOP_COND_S(ngt,  float32_unordered(fst1, fst0,
                                        &env->active_fpu.fp_status))
 
 #define FOP_COND_PS(op, condl, condh)                           \
-void helper_cmp_ps_ ## op(CPUMIPSState *env, uint64_t fdt0,     \
+void HELPER(cmp_ps_ ## op)(CPUMIPSState *env, uint64_t fdt0,    \
                           uint64_t fdt1, int cc)                \
 {                                                               \
     uint32_t fst0, fsth0, fst1, fsth1;                          \
@@ -1941,7 +1944,7 @@ void helper_cmp_ps_ ## op(CPUMIPSState *env, uint64_t fdt0,     \
     else                                                        \
         CLEAR_FP_COND(cc + 1, env->active_fpu);                 \
 }                                                               \
-void helper_cmpabs_ps_ ## op(CPUMIPSState *env, uint64_t fdt0,  \
+void HELPER(cmpabs_ps_ ## op)(CPUMIPSState *env, uint64_t fdt0, \
                              uint64_t fdt1, int cc)             \
 {                                                               \
     uint32_t fst0, fsth0, fst1, fsth1;                          \
@@ -2062,7 +2065,7 @@ FOP_COND_PS(ngt,  float32_unordered(fst1, fst0,
 
 /* R6 compare operations */
 #define FOP_CONDN_D(op, cond)                                       \
-uint64_t helper_r6_cmp_d_ ## op(CPUMIPSState *env, uint64_t fdt0,   \
+uint64_t HELPER(r6_cmp_d_ ## op)(CPUMIPSState *env, uint64_t fdt0,  \
                                 uint64_t fdt1)                      \
 {                                                                   \
     uint64_t c;                                                     \
@@ -2157,7 +2160,7 @@ FOP_CONDN_D(sne,  (float64_lt(fdt1, fdt0,
                                        &env->active_fpu.fp_status)))
 
 #define FOP_CONDN_S(op, cond)                                       \
-uint32_t helper_r6_cmp_s_ ## op(CPUMIPSState *env, uint32_t fst0,   \
+uint32_t HELPER(r6_cmp_s_ ## op)(CPUMIPSState *env, uint32_t fst0,  \
                                 uint32_t fst1)                      \
 {                                                                   \
     uint64_t c;                                                     \
diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 1b25466b496..13bf71ca228 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -32,7 +32,7 @@
 #include "exec/tlb-flags.h"
 
 #define HELPER_LD_ATOMIC(name, insn, almask, do_cast)                         \
-target_ulong helper_##name(CPUMIPSState *env, target_ulong arg,               \
+target_ulong HELPER(name)(CPUMIPSState *env, target_ulong arg,                \
                            uint32_t memop_idx)                                \
 {                                                                             \
     MemOpIdx oi = memop_idx;                                                  \
@@ -73,7 +73,7 @@ static inline target_ulong get_lmask(CPUMIPSState *env,
     return value;
 }
 
-void helper_swl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
+void HELPER(swl)(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
     target_ulong lmask = get_lmask(env, arg2, 32);
@@ -97,7 +97,7 @@ void helper_swl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
     }
 }
 
-void helper_swr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
+void HELPER(swr)(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
     target_ulong lmask = get_lmask(env, arg2, 32);
@@ -127,7 +127,7 @@ void helper_swr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
  * or fault handling won't work.
  */
 
-void helper_sdl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
+void HELPER(sdl)(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
     target_ulong lmask = get_lmask(env, arg2, 64);
@@ -171,7 +171,7 @@ void helper_sdl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
     }
 }
 
-void helper_sdr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
+void HELPER(sdr)(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
     target_ulong lmask = get_lmask(env, arg2, 64);
@@ -218,7 +218,7 @@ void helper_sdr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
 
 static const int multiple_regs[] = { 16, 17, 18, 19, 20, 21, 22, 23, 30 };
 
-void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
+void HELPER(lwm)(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
                 uint32_t memop_idx)
 {
     MemOpIdx oi = memop_idx;
@@ -239,7 +239,7 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
     }
 }
 
-void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
+void HELPER(swm)(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
                 uint32_t memop_idx)
 {
     MemOpIdx oi = memop_idx;
@@ -261,7 +261,7 @@ void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 }
 
 #if defined(TARGET_MIPS64)
-void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
+void HELPER(ldm)(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
                 uint32_t memop_idx)
 {
     MemOpIdx oi = memop_idx;
@@ -282,7 +282,7 @@ void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
     }
 }
 
-void helper_sdm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
+void HELPER(sdm)(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
                 uint32_t memop_idx)
 {
     MemOpIdx oi = memop_idx;
diff --git a/target/mips/tcg/lmmi_helper.c b/target/mips/tcg/lmmi_helper.c
index 2c8732525ce..acda1b69be7 100644
--- a/target/mips/tcg/lmmi_helper.c
+++ b/target/mips/tcg/lmmi_helper.c
@@ -53,7 +53,7 @@ typedef union {
     (x < -0x80000000ll ? -0x80000000ll : x > 0x7fffffff ? 0x7fffffff : x)
 #define SATUW(x)  (x > 0xffffffffull ? 0xffffffffull : x)
 
-uint64_t helper_paddsb(uint64_t fs, uint64_t ft)
+uint64_t HELPER(paddsb)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned int i;
@@ -67,7 +67,7 @@ uint64_t helper_paddsb(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_paddusb(uint64_t fs, uint64_t ft)
+uint64_t HELPER(paddusb)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned int i;
@@ -81,7 +81,7 @@ uint64_t helper_paddusb(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_paddsh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(paddsh)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned int i;
@@ -95,7 +95,7 @@ uint64_t helper_paddsh(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_paddush(uint64_t fs, uint64_t ft)
+uint64_t HELPER(paddush)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned int i;
@@ -109,7 +109,7 @@ uint64_t helper_paddush(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_paddb(uint64_t fs, uint64_t ft)
+uint64_t HELPER(paddb)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned int i;
@@ -122,7 +122,7 @@ uint64_t helper_paddb(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_paddh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(paddh)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned int i;
@@ -135,7 +135,7 @@ uint64_t helper_paddh(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_paddw(uint64_t fs, uint64_t ft)
+uint64_t HELPER(paddw)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned int i;
@@ -148,7 +148,7 @@ uint64_t helper_paddw(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_psubsb(uint64_t fs, uint64_t ft)
+uint64_t HELPER(psubsb)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned int i;
@@ -162,7 +162,7 @@ uint64_t helper_psubsb(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_psubusb(uint64_t fs, uint64_t ft)
+uint64_t HELPER(psubusb)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned int i;
@@ -176,7 +176,7 @@ uint64_t helper_psubusb(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_psubsh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(psubsh)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned int i;
@@ -190,7 +190,7 @@ uint64_t helper_psubsh(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_psubush(uint64_t fs, uint64_t ft)
+uint64_t HELPER(psubush)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned int i;
@@ -204,7 +204,7 @@ uint64_t helper_psubush(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_psubb(uint64_t fs, uint64_t ft)
+uint64_t HELPER(psubb)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned int i;
@@ -217,7 +217,7 @@ uint64_t helper_psubb(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_psubh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(psubh)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned int i;
@@ -230,7 +230,7 @@ uint64_t helper_psubh(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_psubw(uint64_t fs, uint64_t ft)
+uint64_t HELPER(psubw)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned int i;
@@ -243,7 +243,7 @@ uint64_t helper_psubw(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_pshufh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pshufh)(uint64_t fs, uint64_t ft)
 {
     unsigned host = BYTE_ORDER_XOR(3);
     LMIValue vd, vs;
@@ -257,7 +257,7 @@ uint64_t helper_pshufh(uint64_t fs, uint64_t ft)
     return vd.d;
 }
 
-uint64_t helper_packsswh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(packsswh)(uint64_t fs, uint64_t ft)
 {
     uint64_t fd = 0;
     int64_t tmp;
@@ -281,7 +281,7 @@ uint64_t helper_packsswh(uint64_t fs, uint64_t ft)
     return fd;
 }
 
-uint64_t helper_packsshb(uint64_t fs, uint64_t ft)
+uint64_t HELPER(packsshb)(uint64_t fs, uint64_t ft)
 {
     uint64_t fd = 0;
     unsigned int i;
@@ -300,7 +300,7 @@ uint64_t helper_packsshb(uint64_t fs, uint64_t ft)
     return fd;
 }
 
-uint64_t helper_packushb(uint64_t fs, uint64_t ft)
+uint64_t HELPER(packushb)(uint64_t fs, uint64_t ft)
 {
     uint64_t fd = 0;
     unsigned int i;
@@ -319,17 +319,17 @@ uint64_t helper_packushb(uint64_t fs, uint64_t ft)
     return fd;
 }
 
-uint64_t helper_punpcklwd(uint64_t fs, uint64_t ft)
+uint64_t HELPER(punpcklwd)(uint64_t fs, uint64_t ft)
 {
     return (fs & 0xffffffff) | (ft << 32);
 }
 
-uint64_t helper_punpckhwd(uint64_t fs, uint64_t ft)
+uint64_t HELPER(punpckhwd)(uint64_t fs, uint64_t ft)
 {
     return (fs >> 32) | (ft & ~0xffffffffull);
 }
 
-uint64_t helper_punpcklhw(uint64_t fs, uint64_t ft)
+uint64_t HELPER(punpcklhw)(uint64_t fs, uint64_t ft)
 {
     unsigned host = BYTE_ORDER_XOR(3);
     LMIValue vd, vs, vt;
@@ -344,7 +344,7 @@ uint64_t helper_punpcklhw(uint64_t fs, uint64_t ft)
     return vd.d;
 }
 
-uint64_t helper_punpckhhw(uint64_t fs, uint64_t ft)
+uint64_t HELPER(punpckhhw)(uint64_t fs, uint64_t ft)
 {
     unsigned host = BYTE_ORDER_XOR(3);
     LMIValue vd, vs, vt;
@@ -359,7 +359,7 @@ uint64_t helper_punpckhhw(uint64_t fs, uint64_t ft)
     return vd.d;
 }
 
-uint64_t helper_punpcklbh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(punpcklbh)(uint64_t fs, uint64_t ft)
 {
     unsigned host = BYTE_ORDER_XOR(7);
     LMIValue vd, vs, vt;
@@ -378,7 +378,7 @@ uint64_t helper_punpcklbh(uint64_t fs, uint64_t ft)
     return vd.d;
 }
 
-uint64_t helper_punpckhbh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(punpckhbh)(uint64_t fs, uint64_t ft)
 {
     unsigned host = BYTE_ORDER_XOR(7);
     LMIValue vd, vs, vt;
@@ -397,7 +397,7 @@ uint64_t helper_punpckhbh(uint64_t fs, uint64_t ft)
     return vd.d;
 }
 
-uint64_t helper_pavgh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pavgh)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned i;
@@ -410,7 +410,7 @@ uint64_t helper_pavgh(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_pavgb(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pavgb)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned i;
@@ -423,7 +423,7 @@ uint64_t helper_pavgb(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_pmaxsh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pmaxsh)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned i;
@@ -436,7 +436,7 @@ uint64_t helper_pmaxsh(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_pminsh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pminsh)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned i;
@@ -449,7 +449,7 @@ uint64_t helper_pminsh(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_pmaxub(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pmaxub)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned i;
@@ -462,7 +462,7 @@ uint64_t helper_pmaxub(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_pminub(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pminub)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned i;
@@ -475,7 +475,7 @@ uint64_t helper_pminub(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_pcmpeqw(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pcmpeqw)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned i;
@@ -488,7 +488,7 @@ uint64_t helper_pcmpeqw(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_pcmpgtw(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pcmpgtw)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned i;
@@ -501,7 +501,7 @@ uint64_t helper_pcmpgtw(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_pcmpeqh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pcmpeqh)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned i;
@@ -514,7 +514,7 @@ uint64_t helper_pcmpeqh(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_pcmpgth(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pcmpgth)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned i;
@@ -527,7 +527,7 @@ uint64_t helper_pcmpgth(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_pcmpeqb(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pcmpeqb)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned i;
@@ -540,7 +540,7 @@ uint64_t helper_pcmpeqb(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_pcmpgtb(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pcmpgtb)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned i;
@@ -553,7 +553,7 @@ uint64_t helper_pcmpgtb(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_psllw(uint64_t fs, uint64_t ft)
+uint64_t HELPER(psllw)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs;
     unsigned i;
@@ -569,7 +569,7 @@ uint64_t helper_psllw(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_psrlw(uint64_t fs, uint64_t ft)
+uint64_t HELPER(psrlw)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs;
     unsigned i;
@@ -585,7 +585,7 @@ uint64_t helper_psrlw(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_psraw(uint64_t fs, uint64_t ft)
+uint64_t HELPER(psraw)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs;
     unsigned i;
@@ -601,7 +601,7 @@ uint64_t helper_psraw(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_psllh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(psllh)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs;
     unsigned i;
@@ -617,7 +617,7 @@ uint64_t helper_psllh(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_psrlh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(psrlh)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs;
     unsigned i;
@@ -633,7 +633,7 @@ uint64_t helper_psrlh(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_psrah(uint64_t fs, uint64_t ft)
+uint64_t HELPER(psrah)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs;
     unsigned i;
@@ -649,7 +649,7 @@ uint64_t helper_psrah(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_pmullh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pmullh)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned i;
@@ -662,7 +662,7 @@ uint64_t helper_pmullh(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_pmulhh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pmulhh)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned i;
@@ -676,7 +676,7 @@ uint64_t helper_pmulhh(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_pmulhuh(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pmulhuh)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned i;
@@ -690,7 +690,7 @@ uint64_t helper_pmulhuh(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_pmaddhw(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pmaddhw)(uint64_t fs, uint64_t ft)
 {
     unsigned host = BYTE_ORDER_XOR(3);
     LMIValue vs, vt;
@@ -706,7 +706,7 @@ uint64_t helper_pmaddhw(uint64_t fs, uint64_t ft)
     return ((uint64_t)p1 << 32) | p0;
 }
 
-uint64_t helper_pasubub(uint64_t fs, uint64_t ft)
+uint64_t HELPER(pasubub)(uint64_t fs, uint64_t ft)
 {
     LMIValue vs, vt;
     unsigned i;
@@ -720,7 +720,7 @@ uint64_t helper_pasubub(uint64_t fs, uint64_t ft)
     return vs.d;
 }
 
-uint64_t helper_biadd(uint64_t fs)
+uint64_t HELPER(biadd)(uint64_t fs)
 {
     unsigned i, fd;
 
@@ -730,7 +730,7 @@ uint64_t helper_biadd(uint64_t fs)
     return fd & 0xffff;
 }
 
-uint64_t helper_pmovmskb(uint64_t fs)
+uint64_t HELPER(pmovmskb)(uint64_t fs)
 {
     unsigned fd = 0;
 
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index f554b3d10ee..fb76524ba08 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -96,7 +96,7 @@ static inline int64_t msa_nloc_df(uint32_t df, int64_t arg)
     return msa_nlzc_df(df, UNSIGNED((~arg), df));
 }
 
-void helper_msa_nloc_b(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+void HELPER(msa_nloc_b)(CPUMIPSState *env, uint32_t wd, uint32_t ws)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -119,7 +119,7 @@ void helper_msa_nloc_b(CPUMIPSState *env, uint32_t wd, uint32_t ws)
     pwd->b[15] = msa_nloc_df(DF_BYTE, pws->b[15]);
 }
 
-void helper_msa_nloc_h(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+void HELPER(msa_nloc_h)(CPUMIPSState *env, uint32_t wd, uint32_t ws)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -134,7 +134,7 @@ void helper_msa_nloc_h(CPUMIPSState *env, uint32_t wd, uint32_t ws)
     pwd->h[7]  = msa_nloc_df(DF_HALF, pws->h[7]);
 }
 
-void helper_msa_nloc_w(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+void HELPER(msa_nloc_w)(CPUMIPSState *env, uint32_t wd, uint32_t ws)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -145,7 +145,7 @@ void helper_msa_nloc_w(CPUMIPSState *env, uint32_t wd, uint32_t ws)
     pwd->w[3]  = msa_nloc_df(DF_WORD, pws->w[3]);
 }
 
-void helper_msa_nloc_d(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+void HELPER(msa_nloc_d)(CPUMIPSState *env, uint32_t wd, uint32_t ws)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -154,7 +154,7 @@ void helper_msa_nloc_d(CPUMIPSState *env, uint32_t wd, uint32_t ws)
     pwd->d[1]  = msa_nloc_df(DF_DOUBLE, pws->d[1]);
 }
 
-void helper_msa_nlzc_b(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+void HELPER(msa_nlzc_b)(CPUMIPSState *env, uint32_t wd, uint32_t ws)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -177,7 +177,7 @@ void helper_msa_nlzc_b(CPUMIPSState *env, uint32_t wd, uint32_t ws)
     pwd->b[15] = msa_nlzc_df(DF_BYTE, pws->b[15]);
 }
 
-void helper_msa_nlzc_h(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+void HELPER(msa_nlzc_h)(CPUMIPSState *env, uint32_t wd, uint32_t ws)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -192,7 +192,7 @@ void helper_msa_nlzc_h(CPUMIPSState *env, uint32_t wd, uint32_t ws)
     pwd->h[7]  = msa_nlzc_df(DF_HALF, pws->h[7]);
 }
 
-void helper_msa_nlzc_w(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+void HELPER(msa_nlzc_w)(CPUMIPSState *env, uint32_t wd, uint32_t ws)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -203,7 +203,7 @@ void helper_msa_nlzc_w(CPUMIPSState *env, uint32_t wd, uint32_t ws)
     pwd->w[3]  = msa_nlzc_df(DF_WORD, pws->w[3]);
 }
 
-void helper_msa_nlzc_d(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+void HELPER(msa_nlzc_d)(CPUMIPSState *env, uint32_t wd, uint32_t ws)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -228,7 +228,7 @@ static inline int64_t msa_pcnt_df(uint32_t df, int64_t arg)
     return x;
 }
 
-void helper_msa_pcnt_b(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+void HELPER(msa_pcnt_b)(CPUMIPSState *env, uint32_t wd, uint32_t ws)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -251,7 +251,7 @@ void helper_msa_pcnt_b(CPUMIPSState *env, uint32_t wd, uint32_t ws)
     pwd->b[15] = msa_pcnt_df(DF_BYTE, pws->b[15]);
 }
 
-void helper_msa_pcnt_h(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+void HELPER(msa_pcnt_h)(CPUMIPSState *env, uint32_t wd, uint32_t ws)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -266,7 +266,7 @@ void helper_msa_pcnt_h(CPUMIPSState *env, uint32_t wd, uint32_t ws)
     pwd->h[7]  = msa_pcnt_df(DF_HALF, pws->h[7]);
 }
 
-void helper_msa_pcnt_w(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+void HELPER(msa_pcnt_w)(CPUMIPSState *env, uint32_t wd, uint32_t ws)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -277,7 +277,7 @@ void helper_msa_pcnt_w(CPUMIPSState *env, uint32_t wd, uint32_t ws)
     pwd->w[3]  = msa_pcnt_df(DF_WORD, pws->w[3]);
 }
 
-void helper_msa_pcnt_d(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+void HELPER(msa_pcnt_d)(CPUMIPSState *env, uint32_t wd, uint32_t ws)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -324,7 +324,7 @@ static inline int64_t msa_binsl_df(uint32_t df,
     }
 }
 
-void helper_msa_binsl_b(CPUMIPSState *env,
+void HELPER(msa_binsl_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -349,7 +349,7 @@ void helper_msa_binsl_b(CPUMIPSState *env,
     pwd->b[15] = msa_binsl_df(DF_BYTE, pwd->b[15], pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_binsl_h(CPUMIPSState *env,
+void HELPER(msa_binsl_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -366,7 +366,7 @@ void helper_msa_binsl_h(CPUMIPSState *env,
     pwd->h[7]  = msa_binsl_df(DF_HALF, pwd->h[7],  pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_binsl_w(CPUMIPSState *env,
+void HELPER(msa_binsl_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -379,7 +379,7 @@ void helper_msa_binsl_w(CPUMIPSState *env,
     pwd->w[3]  = msa_binsl_df(DF_WORD, pwd->w[3],  pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_binsl_d(CPUMIPSState *env,
+void HELPER(msa_binsl_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -405,7 +405,7 @@ static inline int64_t msa_binsr_df(uint32_t df,
     }
 }
 
-void helper_msa_binsr_b(CPUMIPSState *env,
+void HELPER(msa_binsr_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -430,7 +430,7 @@ void helper_msa_binsr_b(CPUMIPSState *env,
     pwd->b[15] = msa_binsr_df(DF_BYTE, pwd->b[15], pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_binsr_h(CPUMIPSState *env,
+void HELPER(msa_binsr_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -447,7 +447,7 @@ void helper_msa_binsr_h(CPUMIPSState *env,
     pwd->h[7]  = msa_binsr_df(DF_HALF, pwd->h[7],  pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_binsr_w(CPUMIPSState *env,
+void HELPER(msa_binsr_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -460,7 +460,7 @@ void helper_msa_binsr_w(CPUMIPSState *env,
     pwd->w[3]  = msa_binsr_df(DF_WORD, pwd->w[3],  pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_binsr_d(CPUMIPSState *env,
+void HELPER(msa_binsr_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -471,7 +471,8 @@ void helper_msa_binsr_d(CPUMIPSState *env,
     pwd->d[1]  = msa_binsr_df(DF_DOUBLE, pwd->d[1],  pws->d[1],  pwt->d[1]);
 }
 
-void helper_msa_bmnz_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_bmnz_v)(CPUMIPSState *env, uint32_t wd, uint32_t ws,
+                        uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -483,7 +484,7 @@ void helper_msa_bmnz_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
         ((pwd->d[1] & (~pwt->d[1])) | (pws->d[1] & pwt->d[1])), DF_DOUBLE);
 }
 
-void helper_msa_bmz_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_bmz_v)(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -495,7 +496,8 @@ void helper_msa_bmz_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
         ((pwd->d[1] & pwt->d[1]) | (pws->d[1] & (~pwt->d[1]))), DF_DOUBLE);
 }
 
-void helper_msa_bsel_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_bsel_v)(CPUMIPSState *env, uint32_t wd, uint32_t ws,
+                        uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -534,7 +536,8 @@ static inline int64_t msa_bclr_df(uint32_t df, int64_t arg1, int64_t arg2)
     return UNSIGNED(arg1 & (~(1LL << b_arg2)), df);
 }
 
-void helper_msa_bclr_b(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_bclr_b)(CPUMIPSState *env, uint32_t wd, uint32_t ws,
+                        uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -558,7 +561,8 @@ void helper_msa_bclr_b(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
     pwd->b[15] = msa_bclr_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_bclr_h(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_bclr_h)(CPUMIPSState *env, uint32_t wd, uint32_t ws,
+                        uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -574,7 +578,8 @@ void helper_msa_bclr_h(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
     pwd->h[7]  = msa_bclr_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_bclr_w(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_bclr_w)(CPUMIPSState *env, uint32_t wd, uint32_t ws,
+                        uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -586,7 +591,8 @@ void helper_msa_bclr_w(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
     pwd->w[3]  = msa_bclr_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_bclr_d(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_bclr_d)(CPUMIPSState *env, uint32_t wd, uint32_t ws,
+                        uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -602,7 +608,8 @@ static inline int64_t msa_bneg_df(uint32_t df, int64_t arg1, int64_t arg2)
     return UNSIGNED(arg1 ^ (1LL << b_arg2), df);
 }
 
-void helper_msa_bneg_b(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_bneg_b)(CPUMIPSState *env, uint32_t wd, uint32_t ws,
+                        uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -626,7 +633,8 @@ void helper_msa_bneg_b(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
     pwd->b[15] = msa_bneg_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_bneg_h(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_bneg_h)(CPUMIPSState *env, uint32_t wd, uint32_t ws,
+                        uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -642,7 +650,8 @@ void helper_msa_bneg_h(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
     pwd->h[7]  = msa_bneg_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_bneg_w(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_bneg_w)(CPUMIPSState *env, uint32_t wd, uint32_t ws,
+                        uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -654,7 +663,8 @@ void helper_msa_bneg_w(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
     pwd->w[3]  = msa_bneg_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_bneg_d(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_bneg_d)(CPUMIPSState *env, uint32_t wd, uint32_t ws,
+                        uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -671,7 +681,8 @@ static inline int64_t msa_bset_df(uint32_t df, int64_t arg1,
     return UNSIGNED(arg1 | (1LL << b_arg2), df);
 }
 
-void helper_msa_bset_b(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_bset_b)(CPUMIPSState *env, uint32_t wd, uint32_t ws,
+                        uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -695,7 +706,8 @@ void helper_msa_bset_b(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
     pwd->b[15] = msa_bset_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_bset_h(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_bset_h)(CPUMIPSState *env, uint32_t wd, uint32_t ws,
+                        uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -711,7 +723,8 @@ void helper_msa_bset_h(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
     pwd->h[7]  = msa_bset_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_bset_w(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_bset_w)(CPUMIPSState *env, uint32_t wd, uint32_t ws,
+                        uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -723,7 +736,8 @@ void helper_msa_bset_w(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
     pwd->w[3]  = msa_bset_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_bset_d(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_bset_d)(CPUMIPSState *env, uint32_t wd, uint32_t ws,
+                        uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -818,7 +832,7 @@ static inline int64_t msa_add_a_df(uint32_t df, int64_t arg1, int64_t arg2)
     return abs_arg1 + abs_arg2;
 }
 
-void helper_msa_add_a_b(CPUMIPSState *env,
+void HELPER(msa_add_a_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -843,7 +857,7 @@ void helper_msa_add_a_b(CPUMIPSState *env,
     pwd->b[15] = msa_add_a_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_add_a_h(CPUMIPSState *env,
+void HELPER(msa_add_a_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -860,7 +874,7 @@ void helper_msa_add_a_h(CPUMIPSState *env,
     pwd->h[7]  = msa_add_a_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_add_a_w(CPUMIPSState *env,
+void HELPER(msa_add_a_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -873,7 +887,7 @@ void helper_msa_add_a_w(CPUMIPSState *env,
     pwd->w[3]  = msa_add_a_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_add_a_d(CPUMIPSState *env,
+void HELPER(msa_add_a_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -897,7 +911,7 @@ static inline int64_t msa_adds_a_df(uint32_t df, int64_t arg1, int64_t arg2)
     }
 }
 
-void helper_msa_adds_a_b(CPUMIPSState *env,
+void HELPER(msa_adds_a_b)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -922,7 +936,7 @@ void helper_msa_adds_a_b(CPUMIPSState *env,
     pwd->b[15] = msa_adds_a_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_adds_a_h(CPUMIPSState *env,
+void HELPER(msa_adds_a_h)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -939,7 +953,7 @@ void helper_msa_adds_a_h(CPUMIPSState *env,
     pwd->h[7]  = msa_adds_a_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_adds_a_w(CPUMIPSState *env,
+void HELPER(msa_adds_a_w)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -952,7 +966,7 @@ void helper_msa_adds_a_w(CPUMIPSState *env,
     pwd->w[3]  = msa_adds_a_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_adds_a_d(CPUMIPSState *env,
+void HELPER(msa_adds_a_d)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -975,7 +989,7 @@ static inline int64_t msa_adds_s_df(uint32_t df, int64_t arg1, int64_t arg2)
     }
 }
 
-void helper_msa_adds_s_b(CPUMIPSState *env,
+void HELPER(msa_adds_s_b)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1000,7 +1014,7 @@ void helper_msa_adds_s_b(CPUMIPSState *env,
     pwd->b[15] = msa_adds_s_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_adds_s_h(CPUMIPSState *env,
+void HELPER(msa_adds_s_h)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1017,7 +1031,7 @@ void helper_msa_adds_s_h(CPUMIPSState *env,
     pwd->h[7]  = msa_adds_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_adds_s_w(CPUMIPSState *env,
+void HELPER(msa_adds_s_w)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1030,7 +1044,7 @@ void helper_msa_adds_s_w(CPUMIPSState *env,
     pwd->w[3]  = msa_adds_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_adds_s_d(CPUMIPSState *env,
+void HELPER(msa_adds_s_d)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1050,7 +1064,7 @@ static inline uint64_t msa_adds_u_df(uint32_t df, uint64_t arg1, uint64_t arg2)
     return (u_arg1 < max_uint - u_arg2) ? u_arg1 + u_arg2 : max_uint;
 }
 
-void helper_msa_adds_u_b(CPUMIPSState *env,
+void HELPER(msa_adds_u_b)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1075,7 +1089,7 @@ void helper_msa_adds_u_b(CPUMIPSState *env,
     pwd->b[15] = msa_adds_u_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_adds_u_h(CPUMIPSState *env,
+void HELPER(msa_adds_u_h)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1092,7 +1106,7 @@ void helper_msa_adds_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_adds_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_adds_u_w(CPUMIPSState *env,
+void HELPER(msa_adds_u_w)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1105,7 +1119,7 @@ void helper_msa_adds_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_adds_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_adds_u_d(CPUMIPSState *env,
+void HELPER(msa_adds_u_d)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1122,7 +1136,7 @@ static inline int64_t msa_addv_df(uint32_t df, int64_t arg1, int64_t arg2)
     return arg1 + arg2;
 }
 
-void helper_msa_addv_b(CPUMIPSState *env,
+void HELPER(msa_addv_b)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1147,7 +1161,7 @@ void helper_msa_addv_b(CPUMIPSState *env,
     pwd->b[15] = msa_addv_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_addv_h(CPUMIPSState *env,
+void HELPER(msa_addv_h)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1164,7 +1178,7 @@ void helper_msa_addv_h(CPUMIPSState *env,
     pwd->h[7]  = msa_addv_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_addv_w(CPUMIPSState *env,
+void HELPER(msa_addv_w)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1177,7 +1191,7 @@ void helper_msa_addv_w(CPUMIPSState *env,
     pwd->w[3]  = msa_addv_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_addv_d(CPUMIPSState *env,
+void HELPER(msa_addv_d)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1207,7 +1221,7 @@ static inline int64_t msa_hadd_s_df(uint32_t df, int64_t arg1, int64_t arg2)
     return SIGNED_ODD(arg1, df) + SIGNED_EVEN(arg2, df);
 }
 
-void helper_msa_hadd_s_h(CPUMIPSState *env,
+void HELPER(msa_hadd_s_h)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1224,7 +1238,7 @@ void helper_msa_hadd_s_h(CPUMIPSState *env,
     pwd->h[7]  = msa_hadd_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_hadd_s_w(CPUMIPSState *env,
+void HELPER(msa_hadd_s_w)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1237,7 +1251,7 @@ void helper_msa_hadd_s_w(CPUMIPSState *env,
     pwd->w[3]  = msa_hadd_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_hadd_s_d(CPUMIPSState *env,
+void HELPER(msa_hadd_s_d)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1254,7 +1268,7 @@ static inline int64_t msa_hadd_u_df(uint32_t df, int64_t arg1, int64_t arg2)
     return UNSIGNED_ODD(arg1, df) + UNSIGNED_EVEN(arg2, df);
 }
 
-void helper_msa_hadd_u_h(CPUMIPSState *env,
+void HELPER(msa_hadd_u_h)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1271,7 +1285,7 @@ void helper_msa_hadd_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_hadd_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_hadd_u_w(CPUMIPSState *env,
+void HELPER(msa_hadd_u_w)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1284,7 +1298,7 @@ void helper_msa_hadd_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_hadd_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_hadd_u_d(CPUMIPSState *env,
+void HELPER(msa_hadd_u_d)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1326,7 +1340,7 @@ static inline int64_t msa_ave_s_df(uint32_t df, int64_t arg1, int64_t arg2)
     return (arg1 >> 1) + (arg2 >> 1) + (arg1 & arg2 & 1);
 }
 
-void helper_msa_ave_s_b(CPUMIPSState *env,
+void HELPER(msa_ave_s_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1351,7 +1365,7 @@ void helper_msa_ave_s_b(CPUMIPSState *env,
     pwd->b[15] = msa_ave_s_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_ave_s_h(CPUMIPSState *env,
+void HELPER(msa_ave_s_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1368,7 +1382,7 @@ void helper_msa_ave_s_h(CPUMIPSState *env,
     pwd->h[7]  = msa_ave_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_ave_s_w(CPUMIPSState *env,
+void HELPER(msa_ave_s_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1381,7 +1395,7 @@ void helper_msa_ave_s_w(CPUMIPSState *env,
     pwd->w[3]  = msa_ave_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_ave_s_d(CPUMIPSState *env,
+void HELPER(msa_ave_s_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1400,7 +1414,7 @@ static inline uint64_t msa_ave_u_df(uint32_t df, uint64_t arg1, uint64_t arg2)
     return (u_arg1 >> 1) + (u_arg2 >> 1) + (u_arg1 & u_arg2 & 1);
 }
 
-void helper_msa_ave_u_b(CPUMIPSState *env,
+void HELPER(msa_ave_u_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1425,7 +1439,7 @@ void helper_msa_ave_u_b(CPUMIPSState *env,
     pwd->b[15] = msa_ave_u_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_ave_u_h(CPUMIPSState *env,
+void HELPER(msa_ave_u_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1442,7 +1456,7 @@ void helper_msa_ave_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_ave_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_ave_u_w(CPUMIPSState *env,
+void HELPER(msa_ave_u_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1455,7 +1469,7 @@ void helper_msa_ave_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_ave_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_ave_u_d(CPUMIPSState *env,
+void HELPER(msa_ave_u_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1472,7 +1486,7 @@ static inline int64_t msa_aver_s_df(uint32_t df, int64_t arg1, int64_t arg2)
     return (arg1 >> 1) + (arg2 >> 1) + ((arg1 | arg2) & 1);
 }
 
-void helper_msa_aver_s_b(CPUMIPSState *env,
+void HELPER(msa_aver_s_b)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1497,7 +1511,7 @@ void helper_msa_aver_s_b(CPUMIPSState *env,
     pwd->b[15] = msa_aver_s_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_aver_s_h(CPUMIPSState *env,
+void HELPER(msa_aver_s_h)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1514,7 +1528,7 @@ void helper_msa_aver_s_h(CPUMIPSState *env,
     pwd->h[7]  = msa_aver_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_aver_s_w(CPUMIPSState *env,
+void HELPER(msa_aver_s_w)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1527,7 +1541,7 @@ void helper_msa_aver_s_w(CPUMIPSState *env,
     pwd->w[3]  = msa_aver_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_aver_s_d(CPUMIPSState *env,
+void HELPER(msa_aver_s_d)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1546,7 +1560,7 @@ static inline uint64_t msa_aver_u_df(uint32_t df, uint64_t arg1, uint64_t arg2)
     return (u_arg1 >> 1) + (u_arg2 >> 1) + ((u_arg1 | u_arg2) & 1);
 }
 
-void helper_msa_aver_u_b(CPUMIPSState *env,
+void HELPER(msa_aver_u_b)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1571,7 +1585,7 @@ void helper_msa_aver_u_b(CPUMIPSState *env,
     pwd->b[15] = msa_aver_u_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_aver_u_h(CPUMIPSState *env,
+void HELPER(msa_aver_u_h)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1588,7 +1602,7 @@ void helper_msa_aver_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_aver_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_aver_u_w(CPUMIPSState *env,
+void HELPER(msa_aver_u_w)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1601,7 +1615,7 @@ void helper_msa_aver_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_aver_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_aver_u_d(CPUMIPSState *env,
+void HELPER(msa_aver_u_d)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1651,7 +1665,7 @@ static inline int8_t msa_ceq_b(int8_t arg1, int8_t arg2)
     return arg1 == arg2 ? -1 : 0;
 }
 
-void helper_msa_ceq_b(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_ceq_b)(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -1680,7 +1694,7 @@ static inline int16_t msa_ceq_h(int16_t arg1, int16_t arg2)
     return arg1 == arg2 ? -1 : 0;
 }
 
-void helper_msa_ceq_h(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_ceq_h)(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -1701,7 +1715,7 @@ static inline int32_t msa_ceq_w(int32_t arg1, int32_t arg2)
     return arg1 == arg2 ? -1 : 0;
 }
 
-void helper_msa_ceq_w(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_ceq_w)(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -1718,7 +1732,7 @@ static inline int64_t msa_ceq_d(int64_t arg1, int64_t arg2)
     return arg1 == arg2 ? -1 : 0;
 }
 
-void helper_msa_ceq_d(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_ceq_d)(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -1733,7 +1747,7 @@ static inline int64_t msa_cle_s_df(uint32_t df, int64_t arg1, int64_t arg2)
     return arg1 <= arg2 ? -1 : 0;
 }
 
-void helper_msa_cle_s_b(CPUMIPSState *env,
+void HELPER(msa_cle_s_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1758,7 +1772,7 @@ void helper_msa_cle_s_b(CPUMIPSState *env,
     pwd->b[15] = msa_cle_s_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_cle_s_h(CPUMIPSState *env,
+void HELPER(msa_cle_s_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1775,7 +1789,7 @@ void helper_msa_cle_s_h(CPUMIPSState *env,
     pwd->h[7]  = msa_cle_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_cle_s_w(CPUMIPSState *env,
+void HELPER(msa_cle_s_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1788,7 +1802,7 @@ void helper_msa_cle_s_w(CPUMIPSState *env,
     pwd->w[3]  = msa_cle_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_cle_s_d(CPUMIPSState *env,
+void HELPER(msa_cle_s_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1806,7 +1820,7 @@ static inline int64_t msa_cle_u_df(uint32_t df, int64_t arg1, int64_t arg2)
     return u_arg1 <= u_arg2 ? -1 : 0;
 }
 
-void helper_msa_cle_u_b(CPUMIPSState *env,
+void HELPER(msa_cle_u_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1831,7 +1845,7 @@ void helper_msa_cle_u_b(CPUMIPSState *env,
     pwd->b[15] = msa_cle_u_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_cle_u_h(CPUMIPSState *env,
+void HELPER(msa_cle_u_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1848,7 +1862,7 @@ void helper_msa_cle_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_cle_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_cle_u_w(CPUMIPSState *env,
+void HELPER(msa_cle_u_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1861,7 +1875,7 @@ void helper_msa_cle_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_cle_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_cle_u_d(CPUMIPSState *env,
+void HELPER(msa_cle_u_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1882,7 +1896,7 @@ static inline int8_t msa_clt_s_b(int8_t arg1, int8_t arg2)
     return arg1 < arg2 ? -1 : 0;
 }
 
-void helper_msa_clt_s_b(CPUMIPSState *env,
+void HELPER(msa_clt_s_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1912,7 +1926,7 @@ static inline int16_t msa_clt_s_h(int16_t arg1, int16_t arg2)
     return arg1 < arg2 ? -1 : 0;
 }
 
-void helper_msa_clt_s_h(CPUMIPSState *env,
+void HELPER(msa_clt_s_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1934,7 +1948,7 @@ static inline int32_t msa_clt_s_w(int32_t arg1, int32_t arg2)
     return arg1 < arg2 ? -1 : 0;
 }
 
-void helper_msa_clt_s_w(CPUMIPSState *env,
+void HELPER(msa_clt_s_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1952,7 +1966,7 @@ static inline int64_t msa_clt_s_d(int64_t arg1, int64_t arg2)
     return arg1 < arg2 ? -1 : 0;
 }
 
-void helper_msa_clt_s_d(CPUMIPSState *env,
+void HELPER(msa_clt_s_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1970,7 +1984,7 @@ static inline int64_t msa_clt_u_df(uint32_t df, int64_t arg1, int64_t arg2)
     return u_arg1 < u_arg2 ? -1 : 0;
 }
 
-void helper_msa_clt_u_b(CPUMIPSState *env,
+void HELPER(msa_clt_u_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -1995,7 +2009,7 @@ void helper_msa_clt_u_b(CPUMIPSState *env,
     pwd->b[15] = msa_clt_u_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_clt_u_h(CPUMIPSState *env,
+void HELPER(msa_clt_u_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2012,7 +2026,7 @@ void helper_msa_clt_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_clt_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_clt_u_w(CPUMIPSState *env,
+void HELPER(msa_clt_u_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2025,7 +2039,7 @@ void helper_msa_clt_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_clt_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_clt_u_d(CPUMIPSState *env,
+void HELPER(msa_clt_u_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2063,7 +2077,7 @@ static inline int64_t msa_div_s_df(uint32_t df, int64_t arg1, int64_t arg2)
                 : arg1 >= 0 ? -1 : 1;
 }
 
-void helper_msa_div_s_b(CPUMIPSState *env,
+void HELPER(msa_div_s_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2088,7 +2102,7 @@ void helper_msa_div_s_b(CPUMIPSState *env,
     pwd->b[15] = msa_div_s_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_div_s_h(CPUMIPSState *env,
+void HELPER(msa_div_s_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2105,7 +2119,7 @@ void helper_msa_div_s_h(CPUMIPSState *env,
     pwd->h[7]  = msa_div_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_div_s_w(CPUMIPSState *env,
+void HELPER(msa_div_s_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2118,7 +2132,7 @@ void helper_msa_div_s_w(CPUMIPSState *env,
     pwd->w[3]  = msa_div_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_div_s_d(CPUMIPSState *env,
+void HELPER(msa_div_s_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2136,7 +2150,7 @@ static inline int64_t msa_div_u_df(uint32_t df, int64_t arg1, int64_t arg2)
     return arg2 ? u_arg1 / u_arg2 : -1;
 }
 
-void helper_msa_div_u_b(CPUMIPSState *env,
+void HELPER(msa_div_u_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2161,7 +2175,7 @@ void helper_msa_div_u_b(CPUMIPSState *env,
     pwd->b[15] = msa_div_u_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_div_u_h(CPUMIPSState *env,
+void HELPER(msa_div_u_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2178,7 +2192,7 @@ void helper_msa_div_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_div_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_div_u_w(CPUMIPSState *env,
+void HELPER(msa_div_u_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2191,7 +2205,7 @@ void helper_msa_div_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_div_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_div_u_d(CPUMIPSState *env,
+void HELPER(msa_div_u_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2253,7 +2267,7 @@ static inline int64_t msa_dotp_s_df(uint32_t df, int64_t arg1, int64_t arg2)
     return (even_arg1 * even_arg2) + (odd_arg1 * odd_arg2);
 }
 
-void helper_msa_dotp_s_h(CPUMIPSState *env,
+void HELPER(msa_dotp_s_h)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2270,7 +2284,7 @@ void helper_msa_dotp_s_h(CPUMIPSState *env,
     pwd->h[7]  = msa_dotp_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_dotp_s_w(CPUMIPSState *env,
+void HELPER(msa_dotp_s_w)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2283,7 +2297,7 @@ void helper_msa_dotp_s_w(CPUMIPSState *env,
     pwd->w[3]  = msa_dotp_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_dotp_s_d(CPUMIPSState *env,
+void HELPER(msa_dotp_s_d)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2306,7 +2320,7 @@ static inline int64_t msa_dotp_u_df(uint32_t df, int64_t arg1, int64_t arg2)
     return (even_arg1 * even_arg2) + (odd_arg1 * odd_arg2);
 }
 
-void helper_msa_dotp_u_h(CPUMIPSState *env,
+void HELPER(msa_dotp_u_h)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2323,7 +2337,7 @@ void helper_msa_dotp_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_dotp_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_dotp_u_w(CPUMIPSState *env,
+void HELPER(msa_dotp_u_w)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2336,7 +2350,7 @@ void helper_msa_dotp_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_dotp_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_dotp_u_d(CPUMIPSState *env,
+void HELPER(msa_dotp_u_d)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2360,7 +2374,7 @@ static inline int64_t msa_dpadd_s_df(uint32_t df, int64_t dest, int64_t arg1,
     return dest + (even_arg1 * even_arg2) + (odd_arg1 * odd_arg2);
 }
 
-void helper_msa_dpadd_s_h(CPUMIPSState *env,
+void HELPER(msa_dpadd_s_h)(CPUMIPSState *env,
                           uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2377,7 +2391,7 @@ void helper_msa_dpadd_s_h(CPUMIPSState *env,
     pwd->h[7]  = msa_dpadd_s_df(DF_HALF, pwd->h[7],  pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_dpadd_s_w(CPUMIPSState *env,
+void HELPER(msa_dpadd_s_w)(CPUMIPSState *env,
                           uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2390,7 +2404,7 @@ void helper_msa_dpadd_s_w(CPUMIPSState *env,
     pwd->w[3]  = msa_dpadd_s_df(DF_WORD, pwd->w[3],  pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_dpadd_s_d(CPUMIPSState *env,
+void HELPER(msa_dpadd_s_d)(CPUMIPSState *env,
                           uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2414,7 +2428,7 @@ static inline int64_t msa_dpadd_u_df(uint32_t df, int64_t dest, int64_t arg1,
     return dest + (even_arg1 * even_arg2) + (odd_arg1 * odd_arg2);
 }
 
-void helper_msa_dpadd_u_h(CPUMIPSState *env,
+void HELPER(msa_dpadd_u_h)(CPUMIPSState *env,
                           uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2431,7 +2445,7 @@ void helper_msa_dpadd_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_dpadd_u_df(DF_HALF, pwd->h[7],  pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_dpadd_u_w(CPUMIPSState *env,
+void HELPER(msa_dpadd_u_w)(CPUMIPSState *env,
                           uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2444,7 +2458,7 @@ void helper_msa_dpadd_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_dpadd_u_df(DF_WORD, pwd->w[3],  pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_dpadd_u_d(CPUMIPSState *env,
+void HELPER(msa_dpadd_u_d)(CPUMIPSState *env,
                           uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2468,7 +2482,7 @@ static inline int64_t msa_dpsub_s_df(uint32_t df, int64_t dest, int64_t arg1,
     return dest - ((even_arg1 * even_arg2) + (odd_arg1 * odd_arg2));
 }
 
-void helper_msa_dpsub_s_h(CPUMIPSState *env,
+void HELPER(msa_dpsub_s_h)(CPUMIPSState *env,
                           uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2485,7 +2499,7 @@ void helper_msa_dpsub_s_h(CPUMIPSState *env,
     pwd->h[7]  = msa_dpsub_s_df(DF_HALF, pwd->h[7],  pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_dpsub_s_w(CPUMIPSState *env,
+void HELPER(msa_dpsub_s_w)(CPUMIPSState *env,
                           uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2498,7 +2512,7 @@ void helper_msa_dpsub_s_w(CPUMIPSState *env,
     pwd->w[3]  = msa_dpsub_s_df(DF_WORD, pwd->w[3],  pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_dpsub_s_d(CPUMIPSState *env,
+void HELPER(msa_dpsub_s_d)(CPUMIPSState *env,
                           uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2522,7 +2536,7 @@ static inline int64_t msa_dpsub_u_df(uint32_t df, int64_t dest, int64_t arg1,
     return dest - ((even_arg1 * even_arg2) + (odd_arg1 * odd_arg2));
 }
 
-void helper_msa_dpsub_u_h(CPUMIPSState *env,
+void HELPER(msa_dpsub_u_h)(CPUMIPSState *env,
                           uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2539,7 +2553,7 @@ void helper_msa_dpsub_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_dpsub_u_df(DF_HALF, pwd->h[7],  pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_dpsub_u_w(CPUMIPSState *env,
+void HELPER(msa_dpsub_u_w)(CPUMIPSState *env,
                           uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2552,7 +2566,7 @@ void helper_msa_dpsub_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_dpsub_u_df(DF_WORD, pwd->w[3],  pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_dpsub_u_d(CPUMIPSState *env,
+void HELPER(msa_dpsub_u_d)(CPUMIPSState *env,
                           uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2603,7 +2617,7 @@ static inline int64_t msa_max_a_df(uint32_t df, int64_t arg1, int64_t arg2)
     return abs_arg1 > abs_arg2 ? arg1 : arg2;
 }
 
-void helper_msa_max_a_b(CPUMIPSState *env,
+void HELPER(msa_max_a_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2628,7 +2642,7 @@ void helper_msa_max_a_b(CPUMIPSState *env,
     pwd->b[15] = msa_max_a_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_max_a_h(CPUMIPSState *env,
+void HELPER(msa_max_a_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2645,7 +2659,7 @@ void helper_msa_max_a_h(CPUMIPSState *env,
     pwd->h[7]  = msa_max_a_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_max_a_w(CPUMIPSState *env,
+void HELPER(msa_max_a_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2658,7 +2672,7 @@ void helper_msa_max_a_w(CPUMIPSState *env,
     pwd->w[3]  = msa_max_a_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_max_a_d(CPUMIPSState *env,
+void HELPER(msa_max_a_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2675,7 +2689,7 @@ static inline int64_t msa_max_s_df(uint32_t df, int64_t arg1, int64_t arg2)
     return arg1 > arg2 ? arg1 : arg2;
 }
 
-void helper_msa_max_s_b(CPUMIPSState *env,
+void HELPER(msa_max_s_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2700,7 +2714,7 @@ void helper_msa_max_s_b(CPUMIPSState *env,
     pwd->b[15] = msa_max_s_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_max_s_h(CPUMIPSState *env,
+void HELPER(msa_max_s_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2717,7 +2731,7 @@ void helper_msa_max_s_h(CPUMIPSState *env,
     pwd->h[7]  = msa_max_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_max_s_w(CPUMIPSState *env,
+void HELPER(msa_max_s_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2730,7 +2744,7 @@ void helper_msa_max_s_w(CPUMIPSState *env,
     pwd->w[3]  = msa_max_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_max_s_d(CPUMIPSState *env,
+void HELPER(msa_max_s_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2749,7 +2763,7 @@ static inline int64_t msa_max_u_df(uint32_t df, int64_t arg1, int64_t arg2)
     return u_arg1 > u_arg2 ? arg1 : arg2;
 }
 
-void helper_msa_max_u_b(CPUMIPSState *env,
+void HELPER(msa_max_u_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2774,7 +2788,7 @@ void helper_msa_max_u_b(CPUMIPSState *env,
     pwd->b[15] = msa_max_u_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_max_u_h(CPUMIPSState *env,
+void HELPER(msa_max_u_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2791,7 +2805,7 @@ void helper_msa_max_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_max_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_max_u_w(CPUMIPSState *env,
+void HELPER(msa_max_u_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2804,7 +2818,7 @@ void helper_msa_max_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_max_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_max_u_d(CPUMIPSState *env,
+void HELPER(msa_max_u_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2823,7 +2837,7 @@ static inline int64_t msa_min_a_df(uint32_t df, int64_t arg1, int64_t arg2)
     return abs_arg1 < abs_arg2 ? arg1 : arg2;
 }
 
-void helper_msa_min_a_b(CPUMIPSState *env,
+void HELPER(msa_min_a_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2848,7 +2862,7 @@ void helper_msa_min_a_b(CPUMIPSState *env,
     pwd->b[15] = msa_min_a_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_min_a_h(CPUMIPSState *env,
+void HELPER(msa_min_a_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2865,7 +2879,7 @@ void helper_msa_min_a_h(CPUMIPSState *env,
     pwd->h[7]  = msa_min_a_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_min_a_w(CPUMIPSState *env,
+void HELPER(msa_min_a_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2878,7 +2892,7 @@ void helper_msa_min_a_w(CPUMIPSState *env,
     pwd->w[3]  = msa_min_a_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_min_a_d(CPUMIPSState *env,
+void HELPER(msa_min_a_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2895,7 +2909,7 @@ static inline int64_t msa_min_s_df(uint32_t df, int64_t arg1, int64_t arg2)
     return arg1 < arg2 ? arg1 : arg2;
 }
 
-void helper_msa_min_s_b(CPUMIPSState *env,
+void HELPER(msa_min_s_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2920,7 +2934,7 @@ void helper_msa_min_s_b(CPUMIPSState *env,
     pwd->b[15] = msa_min_s_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_min_s_h(CPUMIPSState *env,
+void HELPER(msa_min_s_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2937,7 +2951,7 @@ void helper_msa_min_s_h(CPUMIPSState *env,
     pwd->h[7]  = msa_min_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_min_s_w(CPUMIPSState *env,
+void HELPER(msa_min_s_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2950,7 +2964,7 @@ void helper_msa_min_s_w(CPUMIPSState *env,
     pwd->w[3]  = msa_min_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_min_s_d(CPUMIPSState *env,
+void HELPER(msa_min_s_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2969,7 +2983,7 @@ static inline int64_t msa_min_u_df(uint32_t df, int64_t arg1, int64_t arg2)
     return u_arg1 < u_arg2 ? arg1 : arg2;
 }
 
-void helper_msa_min_u_b(CPUMIPSState *env,
+void HELPER(msa_min_u_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -2994,7 +3008,7 @@ void helper_msa_min_u_b(CPUMIPSState *env,
     pwd->b[15] = msa_min_u_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_min_u_h(CPUMIPSState *env,
+void HELPER(msa_min_u_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3011,7 +3025,7 @@ void helper_msa_min_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_min_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_min_u_w(CPUMIPSState *env,
+void HELPER(msa_min_u_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3024,7 +3038,7 @@ void helper_msa_min_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_min_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_min_u_d(CPUMIPSState *env,
+void HELPER(msa_min_u_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3060,7 +3074,7 @@ static inline int64_t msa_mod_s_df(uint32_t df, int64_t arg1, int64_t arg2)
     return arg2 ? arg1 % arg2 : arg1;
 }
 
-void helper_msa_mod_s_b(CPUMIPSState *env,
+void HELPER(msa_mod_s_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3085,7 +3099,7 @@ void helper_msa_mod_s_b(CPUMIPSState *env,
     pwd->b[15] = msa_mod_s_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_mod_s_h(CPUMIPSState *env,
+void HELPER(msa_mod_s_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3102,7 +3116,7 @@ void helper_msa_mod_s_h(CPUMIPSState *env,
     pwd->h[7]  = msa_mod_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_mod_s_w(CPUMIPSState *env,
+void HELPER(msa_mod_s_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3115,7 +3129,7 @@ void helper_msa_mod_s_w(CPUMIPSState *env,
     pwd->w[3]  = msa_mod_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_mod_s_d(CPUMIPSState *env,
+void HELPER(msa_mod_s_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3133,7 +3147,7 @@ static inline int64_t msa_mod_u_df(uint32_t df, int64_t arg1, int64_t arg2)
     return u_arg2 ? u_arg1 % u_arg2 : u_arg1;
 }
 
-void helper_msa_mod_u_b(CPUMIPSState *env,
+void HELPER(msa_mod_u_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3158,7 +3172,7 @@ void helper_msa_mod_u_b(CPUMIPSState *env,
     pwd->b[15] = msa_mod_u_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_mod_u_h(CPUMIPSState *env,
+void HELPER(msa_mod_u_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3175,7 +3189,7 @@ void helper_msa_mod_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_mod_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_mod_u_w(CPUMIPSState *env,
+void HELPER(msa_mod_u_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3188,7 +3202,7 @@ void helper_msa_mod_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_mod_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_mod_u_d(CPUMIPSState *env,
+void HELPER(msa_mod_u_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3226,7 +3240,7 @@ static inline int64_t msa_maddv_df(uint32_t df, int64_t dest, int64_t arg1,
     return dest + arg1 * arg2;
 }
 
-void helper_msa_maddv_b(CPUMIPSState *env,
+void HELPER(msa_maddv_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3251,7 +3265,7 @@ void helper_msa_maddv_b(CPUMIPSState *env,
     pwd->b[15] = msa_maddv_df(DF_BYTE, pwd->b[15], pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_maddv_h(CPUMIPSState *env,
+void HELPER(msa_maddv_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3268,7 +3282,7 @@ void helper_msa_maddv_h(CPUMIPSState *env,
     pwd->h[7]  = msa_maddv_df(DF_HALF, pwd->h[7],  pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_maddv_w(CPUMIPSState *env,
+void HELPER(msa_maddv_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3281,7 +3295,7 @@ void helper_msa_maddv_w(CPUMIPSState *env,
     pwd->w[3]  = msa_maddv_df(DF_WORD, pwd->w[3],  pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_maddv_d(CPUMIPSState *env,
+void HELPER(msa_maddv_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3298,7 +3312,7 @@ static inline int64_t msa_msubv_df(uint32_t df, int64_t dest, int64_t arg1,
     return dest - arg1 * arg2;
 }
 
-void helper_msa_msubv_b(CPUMIPSState *env,
+void HELPER(msa_msubv_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3323,7 +3337,7 @@ void helper_msa_msubv_b(CPUMIPSState *env,
     pwd->b[15] = msa_msubv_df(DF_BYTE, pwd->b[15], pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_msubv_h(CPUMIPSState *env,
+void HELPER(msa_msubv_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3340,7 +3354,7 @@ void helper_msa_msubv_h(CPUMIPSState *env,
     pwd->h[7]  = msa_msubv_df(DF_HALF, pwd->h[7],  pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_msubv_w(CPUMIPSState *env,
+void HELPER(msa_msubv_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3353,7 +3367,7 @@ void helper_msa_msubv_w(CPUMIPSState *env,
     pwd->w[3]  = msa_msubv_df(DF_WORD, pwd->w[3],  pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_msubv_d(CPUMIPSState *env,
+void HELPER(msa_msubv_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3370,7 +3384,7 @@ static inline int64_t msa_mulv_df(uint32_t df, int64_t arg1, int64_t arg2)
     return arg1 * arg2;
 }
 
-void helper_msa_mulv_b(CPUMIPSState *env,
+void HELPER(msa_mulv_b)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3395,7 +3409,7 @@ void helper_msa_mulv_b(CPUMIPSState *env,
     pwd->b[15] = msa_mulv_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_mulv_h(CPUMIPSState *env,
+void HELPER(msa_mulv_h)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3412,7 +3426,7 @@ void helper_msa_mulv_h(CPUMIPSState *env,
     pwd->h[7]  = msa_mulv_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_mulv_w(CPUMIPSState *env,
+void HELPER(msa_mulv_w)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3425,7 +3439,7 @@ void helper_msa_mulv_w(CPUMIPSState *env,
     pwd->w[3]  = msa_mulv_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_mulv_d(CPUMIPSState *env,
+void HELPER(msa_mulv_d)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3487,7 +3501,7 @@ static inline int64_t msa_asub_s_df(uint32_t df, int64_t arg1, int64_t arg2)
         (uint64_t)(arg2 - arg1) : (uint64_t)(arg1 - arg2);
 }
 
-void helper_msa_asub_s_b(CPUMIPSState *env,
+void HELPER(msa_asub_s_b)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3512,7 +3526,7 @@ void helper_msa_asub_s_b(CPUMIPSState *env,
     pwd->b[15] = msa_asub_s_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_asub_s_h(CPUMIPSState *env,
+void HELPER(msa_asub_s_h)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3529,7 +3543,7 @@ void helper_msa_asub_s_h(CPUMIPSState *env,
     pwd->h[7]  = msa_asub_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_asub_s_w(CPUMIPSState *env,
+void HELPER(msa_asub_s_w)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3542,7 +3556,7 @@ void helper_msa_asub_s_w(CPUMIPSState *env,
     pwd->w[3]  = msa_asub_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_asub_s_d(CPUMIPSState *env,
+void HELPER(msa_asub_s_d)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3563,7 +3577,7 @@ static inline uint64_t msa_asub_u_df(uint32_t df, uint64_t arg1, uint64_t arg2)
         (uint64_t)(u_arg2 - u_arg1) : (uint64_t)(u_arg1 - u_arg2);
 }
 
-void helper_msa_asub_u_b(CPUMIPSState *env,
+void HELPER(msa_asub_u_b)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3588,7 +3602,7 @@ void helper_msa_asub_u_b(CPUMIPSState *env,
     pwd->b[15] = msa_asub_u_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_asub_u_h(CPUMIPSState *env,
+void HELPER(msa_asub_u_h)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3605,7 +3619,7 @@ void helper_msa_asub_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_asub_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_asub_u_w(CPUMIPSState *env,
+void HELPER(msa_asub_u_w)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3618,7 +3632,7 @@ void helper_msa_asub_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_asub_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_asub_u_d(CPUMIPSState *env,
+void HELPER(msa_asub_u_d)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3635,7 +3649,7 @@ static inline int64_t msa_hsub_s_df(uint32_t df, int64_t arg1, int64_t arg2)
     return SIGNED_ODD(arg1, df) - SIGNED_EVEN(arg2, df);
 }
 
-void helper_msa_hsub_s_h(CPUMIPSState *env,
+void HELPER(msa_hsub_s_h)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3652,7 +3666,7 @@ void helper_msa_hsub_s_h(CPUMIPSState *env,
     pwd->h[7]  = msa_hsub_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_hsub_s_w(CPUMIPSState *env,
+void HELPER(msa_hsub_s_w)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3665,7 +3679,7 @@ void helper_msa_hsub_s_w(CPUMIPSState *env,
     pwd->w[3]  = msa_hsub_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_hsub_s_d(CPUMIPSState *env,
+void HELPER(msa_hsub_s_d)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3682,7 +3696,7 @@ static inline int64_t msa_hsub_u_df(uint32_t df, int64_t arg1, int64_t arg2)
     return UNSIGNED_ODD(arg1, df) - UNSIGNED_EVEN(arg2, df);
 }
 
-void helper_msa_hsub_u_h(CPUMIPSState *env,
+void HELPER(msa_hsub_u_h)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3699,7 +3713,7 @@ void helper_msa_hsub_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_hsub_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_hsub_u_w(CPUMIPSState *env,
+void HELPER(msa_hsub_u_w)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3712,7 +3726,7 @@ void helper_msa_hsub_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_hsub_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_hsub_u_d(CPUMIPSState *env,
+void HELPER(msa_hsub_u_d)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3735,7 +3749,7 @@ static inline int64_t msa_subs_s_df(uint32_t df, int64_t arg1, int64_t arg2)
     }
 }
 
-void helper_msa_subs_s_b(CPUMIPSState *env,
+void HELPER(msa_subs_s_b)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3760,7 +3774,7 @@ void helper_msa_subs_s_b(CPUMIPSState *env,
     pwd->b[15] = msa_subs_s_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_subs_s_h(CPUMIPSState *env,
+void HELPER(msa_subs_s_h)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3777,7 +3791,7 @@ void helper_msa_subs_s_h(CPUMIPSState *env,
     pwd->h[7]  = msa_subs_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_subs_s_w(CPUMIPSState *env,
+void HELPER(msa_subs_s_w)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3790,7 +3804,7 @@ void helper_msa_subs_s_w(CPUMIPSState *env,
     pwd->w[3]  = msa_subs_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_subs_s_d(CPUMIPSState *env,
+void HELPER(msa_subs_s_d)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3809,7 +3823,7 @@ static inline int64_t msa_subs_u_df(uint32_t df, int64_t arg1, int64_t arg2)
     return (u_arg1 > u_arg2) ? u_arg1 - u_arg2 : 0;
 }
 
-void helper_msa_subs_u_b(CPUMIPSState *env,
+void HELPER(msa_subs_u_b)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3834,7 +3848,7 @@ void helper_msa_subs_u_b(CPUMIPSState *env,
     pwd->b[15] = msa_subs_u_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_subs_u_h(CPUMIPSState *env,
+void HELPER(msa_subs_u_h)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3851,7 +3865,7 @@ void helper_msa_subs_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_subs_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_subs_u_w(CPUMIPSState *env,
+void HELPER(msa_subs_u_w)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3864,7 +3878,7 @@ void helper_msa_subs_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_subs_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_subs_u_d(CPUMIPSState *env,
+void HELPER(msa_subs_u_d)(CPUMIPSState *env,
                          uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3893,7 +3907,7 @@ static inline int64_t msa_subsus_u_df(uint32_t df, int64_t arg1, int64_t arg2)
     }
 }
 
-void helper_msa_subsus_u_b(CPUMIPSState *env,
+void HELPER(msa_subsus_u_b)(CPUMIPSState *env,
                            uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3918,7 +3932,7 @@ void helper_msa_subsus_u_b(CPUMIPSState *env,
     pwd->b[15] = msa_subsus_u_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_subsus_u_h(CPUMIPSState *env,
+void HELPER(msa_subsus_u_h)(CPUMIPSState *env,
                            uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3935,7 +3949,7 @@ void helper_msa_subsus_u_h(CPUMIPSState *env,
     pwd->h[7]  = msa_subsus_u_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_subsus_u_w(CPUMIPSState *env,
+void HELPER(msa_subsus_u_w)(CPUMIPSState *env,
                            uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3948,7 +3962,7 @@ void helper_msa_subsus_u_w(CPUMIPSState *env,
     pwd->w[3]  = msa_subsus_u_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_subsus_u_d(CPUMIPSState *env,
+void HELPER(msa_subsus_u_d)(CPUMIPSState *env,
                            uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -3977,7 +3991,7 @@ static inline int64_t msa_subsuu_s_df(uint32_t df, int64_t arg1, int64_t arg2)
     }
 }
 
-void helper_msa_subsuu_s_b(CPUMIPSState *env,
+void HELPER(msa_subsuu_s_b)(CPUMIPSState *env,
                            uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4002,7 +4016,7 @@ void helper_msa_subsuu_s_b(CPUMIPSState *env,
     pwd->b[15] = msa_subsuu_s_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_subsuu_s_h(CPUMIPSState *env,
+void HELPER(msa_subsuu_s_h)(CPUMIPSState *env,
                            uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4019,7 +4033,7 @@ void helper_msa_subsuu_s_h(CPUMIPSState *env,
     pwd->h[7]  = msa_subsuu_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_subsuu_s_w(CPUMIPSState *env,
+void HELPER(msa_subsuu_s_w)(CPUMIPSState *env,
                            uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4032,7 +4046,7 @@ void helper_msa_subsuu_s_w(CPUMIPSState *env,
     pwd->w[3]  = msa_subsuu_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_subsuu_s_d(CPUMIPSState *env,
+void HELPER(msa_subsuu_s_d)(CPUMIPSState *env,
                            uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4049,7 +4063,7 @@ static inline int64_t msa_subv_df(uint32_t df, int64_t arg1, int64_t arg2)
     return arg1 - arg2;
 }
 
-void helper_msa_subv_b(CPUMIPSState *env,
+void HELPER(msa_subv_b)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4074,7 +4088,7 @@ void helper_msa_subv_b(CPUMIPSState *env,
     pwd->b[15] = msa_subv_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_subv_h(CPUMIPSState *env,
+void HELPER(msa_subv_h)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4091,7 +4105,7 @@ void helper_msa_subv_h(CPUMIPSState *env,
     pwd->h[7]  = msa_subv_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_subv_w(CPUMIPSState *env,
+void HELPER(msa_subv_w)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4104,7 +4118,7 @@ void helper_msa_subv_w(CPUMIPSState *env,
     pwd->w[3]  = msa_subv_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_subv_d(CPUMIPSState *env,
+void HELPER(msa_subv_d)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4141,7 +4155,7 @@ void helper_msa_subv_d(CPUMIPSState *env,
  */
 
 
-void helper_msa_ilvev_b(CPUMIPSState *env,
+void HELPER(msa_ilvev_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4185,7 +4199,7 @@ void helper_msa_ilvev_b(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_ilvev_h(CPUMIPSState *env,
+void HELPER(msa_ilvev_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4213,7 +4227,7 @@ void helper_msa_ilvev_h(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_ilvev_w(CPUMIPSState *env,
+void HELPER(msa_ilvev_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4233,7 +4247,7 @@ void helper_msa_ilvev_w(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_ilvev_d(CPUMIPSState *env,
+void HELPER(msa_ilvev_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4245,7 +4259,7 @@ void helper_msa_ilvev_d(CPUMIPSState *env,
 }
 
 
-void helper_msa_ilvod_b(CPUMIPSState *env,
+void HELPER(msa_ilvod_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4289,7 +4303,7 @@ void helper_msa_ilvod_b(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_ilvod_h(CPUMIPSState *env,
+void HELPER(msa_ilvod_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4317,7 +4331,7 @@ void helper_msa_ilvod_h(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_ilvod_w(CPUMIPSState *env,
+void HELPER(msa_ilvod_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4337,7 +4351,7 @@ void helper_msa_ilvod_w(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_ilvod_d(CPUMIPSState *env,
+void HELPER(msa_ilvod_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4349,7 +4363,7 @@ void helper_msa_ilvod_d(CPUMIPSState *env,
 }
 
 
-void helper_msa_ilvl_b(CPUMIPSState *env,
+void HELPER(msa_ilvl_b)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4393,7 +4407,7 @@ void helper_msa_ilvl_b(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_ilvl_h(CPUMIPSState *env,
+void HELPER(msa_ilvl_h)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4421,7 +4435,7 @@ void helper_msa_ilvl_h(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_ilvl_w(CPUMIPSState *env,
+void HELPER(msa_ilvl_w)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4441,7 +4455,7 @@ void helper_msa_ilvl_w(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_ilvl_d(CPUMIPSState *env,
+void HELPER(msa_ilvl_d)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4453,7 +4467,7 @@ void helper_msa_ilvl_d(CPUMIPSState *env,
 }
 
 
-void helper_msa_ilvr_b(CPUMIPSState *env,
+void HELPER(msa_ilvr_b)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4497,7 +4511,7 @@ void helper_msa_ilvr_b(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_ilvr_h(CPUMIPSState *env,
+void HELPER(msa_ilvr_h)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4525,7 +4539,7 @@ void helper_msa_ilvr_h(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_ilvr_w(CPUMIPSState *env,
+void HELPER(msa_ilvr_w)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4545,7 +4559,7 @@ void helper_msa_ilvr_w(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_ilvr_d(CPUMIPSState *env,
+void HELPER(msa_ilvr_d)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4570,7 +4584,7 @@ void helper_msa_ilvr_d(CPUMIPSState *env,
  */
 
 
-void helper_msa_and_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_and_v)(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -4580,7 +4594,7 @@ void helper_msa_and_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
     pwd->d[1] = pws->d[1] & pwt->d[1];
 }
 
-void helper_msa_nor_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_nor_v)(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -4590,7 +4604,7 @@ void helper_msa_nor_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
     pwd->d[1] = ~(pws->d[1] | pwt->d[1]);
 }
 
-void helper_msa_or_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_or_v)(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -4600,7 +4614,7 @@ void helper_msa_or_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
     pwd->d[1] = pws->d[1] | pwt->d[1];
 }
 
-void helper_msa_xor_v(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
+void HELPER(msa_xor_v)(CPUMIPSState *env, uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -4626,7 +4640,7 @@ static inline void msa_move_v(wr_t *pwd, wr_t *pws)
     pwd->d[1] = pws->d[1];
 }
 
-void helper_msa_move_v(CPUMIPSState *env, uint32_t wd, uint32_t ws)
+void HELPER(msa_move_v)(CPUMIPSState *env, uint32_t wd, uint32_t ws)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);
@@ -4656,7 +4670,7 @@ void helper_msa_move_v(CPUMIPSState *env, uint32_t wd, uint32_t ws)
  */
 
 
-void helper_msa_pckev_b(CPUMIPSState *env,
+void HELPER(msa_pckev_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4700,7 +4714,7 @@ void helper_msa_pckev_b(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_pckev_h(CPUMIPSState *env,
+void HELPER(msa_pckev_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4728,7 +4742,7 @@ void helper_msa_pckev_h(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_pckev_w(CPUMIPSState *env,
+void HELPER(msa_pckev_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4748,7 +4762,7 @@ void helper_msa_pckev_w(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_pckev_d(CPUMIPSState *env,
+void HELPER(msa_pckev_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4760,7 +4774,7 @@ void helper_msa_pckev_d(CPUMIPSState *env,
 }
 
 
-void helper_msa_pckod_b(CPUMIPSState *env,
+void HELPER(msa_pckod_b)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4805,7 +4819,7 @@ void helper_msa_pckod_b(CPUMIPSState *env,
 
 }
 
-void helper_msa_pckod_h(CPUMIPSState *env,
+void HELPER(msa_pckod_h)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4833,7 +4847,7 @@ void helper_msa_pckod_h(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_pckod_w(CPUMIPSState *env,
+void HELPER(msa_pckod_w)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4853,7 +4867,7 @@ void helper_msa_pckod_w(CPUMIPSState *env,
 #endif
 }
 
-void helper_msa_pckod_d(CPUMIPSState *env,
+void HELPER(msa_pckod_d)(CPUMIPSState *env,
                         uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4900,7 +4914,7 @@ static inline int64_t msa_sll_df(uint32_t df, int64_t arg1, int64_t arg2)
     return arg1 << b_arg2;
 }
 
-void helper_msa_sll_b(CPUMIPSState *env,
+void HELPER(msa_sll_b)(CPUMIPSState *env,
                       uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4925,7 +4939,7 @@ void helper_msa_sll_b(CPUMIPSState *env,
     pwd->b[15] = msa_sll_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_sll_h(CPUMIPSState *env,
+void HELPER(msa_sll_h)(CPUMIPSState *env,
                       uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4942,7 +4956,7 @@ void helper_msa_sll_h(CPUMIPSState *env,
     pwd->h[7]  = msa_sll_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_sll_w(CPUMIPSState *env,
+void HELPER(msa_sll_w)(CPUMIPSState *env,
                       uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4955,7 +4969,7 @@ void helper_msa_sll_w(CPUMIPSState *env,
     pwd->w[3]  = msa_sll_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_sll_d(CPUMIPSState *env,
+void HELPER(msa_sll_d)(CPUMIPSState *env,
                       uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4973,7 +4987,7 @@ static inline int64_t msa_sra_df(uint32_t df, int64_t arg1, int64_t arg2)
     return arg1 >> b_arg2;
 }
 
-void helper_msa_sra_b(CPUMIPSState *env,
+void HELPER(msa_sra_b)(CPUMIPSState *env,
                       uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -4998,7 +5012,7 @@ void helper_msa_sra_b(CPUMIPSState *env,
     pwd->b[15] = msa_sra_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_sra_h(CPUMIPSState *env,
+void HELPER(msa_sra_h)(CPUMIPSState *env,
                       uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5015,7 +5029,7 @@ void helper_msa_sra_h(CPUMIPSState *env,
     pwd->h[7]  = msa_sra_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_sra_w(CPUMIPSState *env,
+void HELPER(msa_sra_w)(CPUMIPSState *env,
                       uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5028,7 +5042,7 @@ void helper_msa_sra_w(CPUMIPSState *env,
     pwd->w[3]  = msa_sra_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_sra_d(CPUMIPSState *env,
+void HELPER(msa_sra_d)(CPUMIPSState *env,
                       uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5051,7 +5065,7 @@ static inline int64_t msa_srar_df(uint32_t df, int64_t arg1, int64_t arg2)
     }
 }
 
-void helper_msa_srar_b(CPUMIPSState *env,
+void HELPER(msa_srar_b)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5076,7 +5090,7 @@ void helper_msa_srar_b(CPUMIPSState *env,
     pwd->b[15] = msa_srar_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_srar_h(CPUMIPSState *env,
+void HELPER(msa_srar_h)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5093,7 +5107,7 @@ void helper_msa_srar_h(CPUMIPSState *env,
     pwd->h[7]  = msa_srar_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_srar_w(CPUMIPSState *env,
+void HELPER(msa_srar_w)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5106,7 +5120,7 @@ void helper_msa_srar_w(CPUMIPSState *env,
     pwd->w[3]  = msa_srar_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_srar_d(CPUMIPSState *env,
+void HELPER(msa_srar_d)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5125,7 +5139,7 @@ static inline int64_t msa_srl_df(uint32_t df, int64_t arg1, int64_t arg2)
     return u_arg1 >> b_arg2;
 }
 
-void helper_msa_srl_b(CPUMIPSState *env,
+void HELPER(msa_srl_b)(CPUMIPSState *env,
                       uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5150,7 +5164,7 @@ void helper_msa_srl_b(CPUMIPSState *env,
     pwd->b[15] = msa_srl_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_srl_h(CPUMIPSState *env,
+void HELPER(msa_srl_h)(CPUMIPSState *env,
                       uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5167,7 +5181,7 @@ void helper_msa_srl_h(CPUMIPSState *env,
     pwd->h[7]  = msa_srl_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_srl_w(CPUMIPSState *env,
+void HELPER(msa_srl_w)(CPUMIPSState *env,
                       uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5180,7 +5194,7 @@ void helper_msa_srl_w(CPUMIPSState *env,
     pwd->w[3]  = msa_srl_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_srl_d(CPUMIPSState *env,
+void HELPER(msa_srl_d)(CPUMIPSState *env,
                       uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5204,7 +5218,7 @@ static inline int64_t msa_srlr_df(uint32_t df, int64_t arg1, int64_t arg2)
     }
 }
 
-void helper_msa_srlr_b(CPUMIPSState *env,
+void HELPER(msa_srlr_b)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5229,7 +5243,7 @@ void helper_msa_srlr_b(CPUMIPSState *env,
     pwd->b[15] = msa_srlr_df(DF_BYTE, pws->b[15], pwt->b[15]);
 }
 
-void helper_msa_srlr_h(CPUMIPSState *env,
+void HELPER(msa_srlr_h)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5246,7 +5260,7 @@ void helper_msa_srlr_h(CPUMIPSState *env,
     pwd->h[7]  = msa_srlr_df(DF_HALF, pws->h[7],  pwt->h[7]);
 }
 
-void helper_msa_srlr_w(CPUMIPSState *env,
+void HELPER(msa_srlr_w)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5259,7 +5273,7 @@ void helper_msa_srlr_w(CPUMIPSState *env,
     pwd->w[3]  = msa_srlr_df(DF_WORD, pws->w[3],  pwt->w[3]);
 }
 
-void helper_msa_srlr_d(CPUMIPSState *env,
+void HELPER(msa_srlr_d)(CPUMIPSState *env,
                        uint32_t wd, uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5272,7 +5286,7 @@ void helper_msa_srlr_d(CPUMIPSState *env,
 
 
 #define MSA_FN_IMM8(FUNC, DEST, OPERATION)                              \
-void helper_msa_ ## FUNC(CPUMIPSState *env, uint32_t wd, uint32_t ws,   \
+void HELPER(msa_ ## FUNC)(CPUMIPSState *env, uint32_t wd, uint32_t ws,  \
         uint32_t i8)                                                    \
 {                                                                       \
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);                          \
@@ -5310,7 +5324,7 @@ MSA_FN_IMM8(bseli_b, pwd->b[i],
 
 #define SHF_POS(i, imm) (((i) & 0xfc) + (((imm) >> (2 * ((i) & 0x03))) & 0x03))
 
-void helper_msa_shf_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_shf_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                        uint32_t ws, uint32_t imm)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5341,7 +5355,7 @@ void helper_msa_shf_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 }
 
 #define MSA_BINOP_IMM_DF(helper, func)                                  \
-void helper_msa_ ## helper ## _df(CPUMIPSState *env, uint32_t df,       \
+void HELPER(msa_ ## helper ## _df)(CPUMIPSState *env, uint32_t df,      \
                         uint32_t wd, uint32_t ws, int32_t u5)           \
 {                                                                       \
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);                          \
@@ -5387,7 +5401,7 @@ MSA_BINOP_IMM_DF(mini_s, min_s)
 MSA_BINOP_IMM_DF(mini_u, min_u)
 #undef MSA_BINOP_IMM_DF
 
-void helper_msa_ldi_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_ldi_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                        int32_t s10)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5434,8 +5448,8 @@ static inline int64_t msa_sat_u_df(uint32_t df, int64_t arg, uint32_t m)
 }
 
 #define MSA_BINOP_IMMU_DF(helper, func)                                  \
-void helper_msa_ ## helper ## _df(CPUMIPSState *env, uint32_t df, uint32_t wd, \
-                       uint32_t ws, uint32_t u5)                        \
+void HELPER(msa_ ## helper ## _df)(CPUMIPSState *env, uint32_t df,      \
+                        uint32_t wd, uint32_t ws, uint32_t u5)          \
 {                                                                       \
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);                          \
     wr_t *pws = &(env->active_fpu.fpr[ws].wr);                          \
@@ -5480,7 +5494,7 @@ MSA_BINOP_IMMU_DF(srlri, srlr)
 #undef MSA_BINOP_IMMU_DF
 
 #define MSA_TEROP_IMMU_DF(helper, func)                                  \
-void helper_msa_ ## helper ## _df(CPUMIPSState *env, uint32_t df,       \
+void HELPER(msa_ ## helper ## _df)(CPUMIPSState *env, uint32_t df,      \
                                   uint32_t wd, uint32_t ws, uint32_t u5) \
 {                                                                       \
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);                          \
@@ -5587,7 +5601,7 @@ static inline int64_t msa_mulr_q_df(uint32_t df, int64_t arg1, int64_t arg2)
 }
 
 #define MSA_BINOP_DF(func) \
-void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df,         \
+void HELPER(msa_ ## func ## _df)(CPUMIPSState *env, uint32_t df,        \
                                 uint32_t wd, uint32_t ws, uint32_t wt)  \
 {                                                                       \
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);                          \
@@ -5642,7 +5656,7 @@ MSA_BINOP_DF(mul_q)
 MSA_BINOP_DF(mulr_q)
 #undef MSA_BINOP_DF
 
-void helper_msa_sld_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_sld_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                        uint32_t ws, uint32_t rt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5710,7 +5724,7 @@ static inline int64_t msa_msubr_q_df(uint32_t df, int64_t dest, int64_t arg1,
 }
 
 #define MSA_TEROP_DF(func) \
-void helper_msa_ ## func ## _df(CPUMIPSState *env, uint32_t df, uint32_t wd,  \
+void HELPER(msa_ ## func ## _df)(CPUMIPSState *env, uint32_t df, uint32_t wd, \
                                 uint32_t ws, uint32_t wt)                     \
 {                                                                             \
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);                                \
@@ -5817,7 +5831,7 @@ static inline void msa_splat_df(uint32_t df, wr_t *pwd,
     }
 }
 
-void helper_msa_splat_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_splat_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                          uint32_t ws, uint32_t rt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5849,7 +5863,7 @@ void helper_msa_splat_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     } while (0)
 
 #define MSA_FN_DF(FUNC)                                             \
-void helper_msa_##FUNC(CPUMIPSState *env, uint32_t df, uint32_t wd, \
+void HELPER(msa_##FUNC)(CPUMIPSState *env, uint32_t df, uint32_t wd, \
         uint32_t ws, uint32_t wt)                                   \
 {                                                                   \
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);                      \
@@ -5906,7 +5920,7 @@ MSA_FN_DF(vshf_df)
 #undef MSA_FN_DF
 
 
-void helper_msa_sldi_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_sldi_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t n)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5915,7 +5929,7 @@ void helper_msa_sldi_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_sld_df(df, pwd, pws, n);
 }
 
-void helper_msa_splati_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_splati_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                           uint32_t ws, uint32_t n)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -5924,7 +5938,7 @@ void helper_msa_splati_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_splat_df(df, pwd, pws, n);
 }
 
-void helper_msa_copy_s_b(CPUMIPSState *env, uint32_t rd,
+void HELPER(msa_copy_s_b)(CPUMIPSState *env, uint32_t rd,
                          uint32_t ws, uint32_t n)
 {
     n %= 16;
@@ -5938,7 +5952,7 @@ void helper_msa_copy_s_b(CPUMIPSState *env, uint32_t rd,
     env->active_tc.gpr[rd] = (int8_t)env->active_fpu.fpr[ws].wr.b[n];
 }
 
-void helper_msa_copy_s_h(CPUMIPSState *env, uint32_t rd,
+void HELPER(msa_copy_s_h)(CPUMIPSState *env, uint32_t rd,
                          uint32_t ws, uint32_t n)
 {
     n %= 8;
@@ -5952,7 +5966,7 @@ void helper_msa_copy_s_h(CPUMIPSState *env, uint32_t rd,
     env->active_tc.gpr[rd] = (int16_t)env->active_fpu.fpr[ws].wr.h[n];
 }
 
-void helper_msa_copy_s_w(CPUMIPSState *env, uint32_t rd,
+void HELPER(msa_copy_s_w)(CPUMIPSState *env, uint32_t rd,
                          uint32_t ws, uint32_t n)
 {
     n %= 4;
@@ -5966,14 +5980,14 @@ void helper_msa_copy_s_w(CPUMIPSState *env, uint32_t rd,
     env->active_tc.gpr[rd] = (int32_t)env->active_fpu.fpr[ws].wr.w[n];
 }
 
-void helper_msa_copy_s_d(CPUMIPSState *env, uint32_t rd,
+void HELPER(msa_copy_s_d)(CPUMIPSState *env, uint32_t rd,
                          uint32_t ws, uint32_t n)
 {
     n %= 2;
     env->active_tc.gpr[rd] = (int64_t)env->active_fpu.fpr[ws].wr.d[n];
 }
 
-void helper_msa_copy_u_b(CPUMIPSState *env, uint32_t rd,
+void HELPER(msa_copy_u_b)(CPUMIPSState *env, uint32_t rd,
                          uint32_t ws, uint32_t n)
 {
     n %= 16;
@@ -5987,7 +6001,7 @@ void helper_msa_copy_u_b(CPUMIPSState *env, uint32_t rd,
     env->active_tc.gpr[rd] = (uint8_t)env->active_fpu.fpr[ws].wr.b[n];
 }
 
-void helper_msa_copy_u_h(CPUMIPSState *env, uint32_t rd,
+void HELPER(msa_copy_u_h)(CPUMIPSState *env, uint32_t rd,
                          uint32_t ws, uint32_t n)
 {
     n %= 8;
@@ -6001,7 +6015,7 @@ void helper_msa_copy_u_h(CPUMIPSState *env, uint32_t rd,
     env->active_tc.gpr[rd] = (uint16_t)env->active_fpu.fpr[ws].wr.h[n];
 }
 
-void helper_msa_copy_u_w(CPUMIPSState *env, uint32_t rd,
+void HELPER(msa_copy_u_w)(CPUMIPSState *env, uint32_t rd,
                          uint32_t ws, uint32_t n)
 {
     n %= 4;
@@ -6015,7 +6029,7 @@ void helper_msa_copy_u_w(CPUMIPSState *env, uint32_t rd,
     env->active_tc.gpr[rd] = (uint32_t)env->active_fpu.fpr[ws].wr.w[n];
 }
 
-void helper_msa_insert_b(CPUMIPSState *env, uint32_t wd,
+void HELPER(msa_insert_b)(CPUMIPSState *env, uint32_t wd,
                           uint32_t rs_num, uint32_t n)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6031,7 +6045,7 @@ void helper_msa_insert_b(CPUMIPSState *env, uint32_t wd,
     pwd->b[n] = (int8_t)rs;
 }
 
-void helper_msa_insert_h(CPUMIPSState *env, uint32_t wd,
+void HELPER(msa_insert_h)(CPUMIPSState *env, uint32_t wd,
                           uint32_t rs_num, uint32_t n)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6047,7 +6061,7 @@ void helper_msa_insert_h(CPUMIPSState *env, uint32_t wd,
     pwd->h[n] = (int16_t)rs;
 }
 
-void helper_msa_insert_w(CPUMIPSState *env, uint32_t wd,
+void HELPER(msa_insert_w)(CPUMIPSState *env, uint32_t wd,
                           uint32_t rs_num, uint32_t n)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6063,7 +6077,7 @@ void helper_msa_insert_w(CPUMIPSState *env, uint32_t wd,
     pwd->w[n] = (int32_t)rs;
 }
 
-void helper_msa_insert_d(CPUMIPSState *env, uint32_t wd,
+void HELPER(msa_insert_d)(CPUMIPSState *env, uint32_t wd,
                           uint32_t rs_num, uint32_t n)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6072,7 +6086,7 @@ void helper_msa_insert_d(CPUMIPSState *env, uint32_t wd,
     pwd->d[n] = (int64_t)rs;
 }
 
-void helper_msa_insve_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_insve_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                          uint32_t ws, uint32_t n)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6096,7 +6110,7 @@ void helper_msa_insve_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     }
 }
 
-void helper_msa_ctcmsa(CPUMIPSState *env, target_ulong elm, uint32_t cd)
+void HELPER(msa_ctcmsa)(CPUMIPSState *env, target_ulong elm, uint32_t cd)
 {
     switch (cd) {
     case 0:
@@ -6113,7 +6127,7 @@ void helper_msa_ctcmsa(CPUMIPSState *env, target_ulong elm, uint32_t cd)
     }
 }
 
-target_ulong helper_msa_cfcmsa(CPUMIPSState *env, uint32_t cs)
+target_ulong HELPER(msa_cfcmsa)(CPUMIPSState *env, uint32_t cs)
 {
     switch (cs) {
     case 0:
@@ -6124,7 +6138,7 @@ target_ulong helper_msa_cfcmsa(CPUMIPSState *env, uint32_t cs)
     return 0;
 }
 
-void helper_msa_fill_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fill_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t rs)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6867,7 +6881,7 @@ static inline void compare_ne(CPUMIPSState *env, wr_t *pwd, wr_t *pws,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_fcaf_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fcaf_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6876,7 +6890,7 @@ void helper_msa_fcaf_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_af(env, pwd, pws, pwt, df, 1, GETPC());
 }
 
-void helper_msa_fcun_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fcun_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6885,7 +6899,7 @@ void helper_msa_fcun_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_un(env, pwd, pws, pwt, df, 1, GETPC());
 }
 
-void helper_msa_fceq_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fceq_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6894,7 +6908,7 @@ void helper_msa_fceq_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_eq(env, pwd, pws, pwt, df, 1, GETPC());
 }
 
-void helper_msa_fcueq_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fcueq_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                          uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6903,7 +6917,7 @@ void helper_msa_fcueq_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_ueq(env, pwd, pws, pwt, df, 1, GETPC());
 }
 
-void helper_msa_fclt_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fclt_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6912,7 +6926,7 @@ void helper_msa_fclt_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_lt(env, pwd, pws, pwt, df, 1, GETPC());
 }
 
-void helper_msa_fcult_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fcult_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                          uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6921,7 +6935,7 @@ void helper_msa_fcult_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_ult(env, pwd, pws, pwt, df, 1, GETPC());
 }
 
-void helper_msa_fcle_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fcle_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6930,7 +6944,7 @@ void helper_msa_fcle_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_le(env, pwd, pws, pwt, df, 1, GETPC());
 }
 
-void helper_msa_fcule_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fcule_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                          uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6939,7 +6953,7 @@ void helper_msa_fcule_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_ule(env, pwd, pws, pwt, df, 1, GETPC());
 }
 
-void helper_msa_fsaf_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fsaf_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6948,7 +6962,7 @@ void helper_msa_fsaf_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_af(env, pwd, pws, pwt, df, 0, GETPC());
 }
 
-void helper_msa_fsun_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fsun_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6957,7 +6971,7 @@ void helper_msa_fsun_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_un(env, pwd, pws, pwt, df, 0, GETPC());
 }
 
-void helper_msa_fseq_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fseq_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6966,7 +6980,7 @@ void helper_msa_fseq_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_eq(env, pwd, pws, pwt, df, 0, GETPC());
 }
 
-void helper_msa_fsueq_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fsueq_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                          uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6975,7 +6989,7 @@ void helper_msa_fsueq_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_ueq(env, pwd, pws, pwt, df, 0, GETPC());
 }
 
-void helper_msa_fslt_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fslt_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6984,7 +6998,7 @@ void helper_msa_fslt_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_lt(env, pwd, pws, pwt, df, 0, GETPC());
 }
 
-void helper_msa_fsult_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fsult_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                          uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -6993,7 +7007,7 @@ void helper_msa_fsult_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_ult(env, pwd, pws, pwt, df, 0, GETPC());
 }
 
-void helper_msa_fsle_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fsle_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -7002,7 +7016,7 @@ void helper_msa_fsle_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_le(env, pwd, pws, pwt, df, 0, GETPC());
 }
 
-void helper_msa_fsule_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fsule_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                          uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -7011,7 +7025,7 @@ void helper_msa_fsule_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_ule(env, pwd, pws, pwt, df, 0, GETPC());
 }
 
-void helper_msa_fcor_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fcor_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -7020,7 +7034,7 @@ void helper_msa_fcor_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_or(env, pwd, pws, pwt, df, 1, GETPC());
 }
 
-void helper_msa_fcune_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fcune_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                          uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -7029,7 +7043,7 @@ void helper_msa_fcune_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_une(env, pwd, pws, pwt, df, 1, GETPC());
 }
 
-void helper_msa_fcne_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fcne_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -7038,7 +7052,7 @@ void helper_msa_fcne_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_ne(env, pwd, pws, pwt, df, 1, GETPC());
 }
 
-void helper_msa_fsor_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fsor_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -7047,7 +7061,7 @@ void helper_msa_fsor_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_or(env, pwd, pws, pwt, df, 0, GETPC());
 }
 
-void helper_msa_fsune_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fsune_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                          uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -7056,7 +7070,7 @@ void helper_msa_fsune_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     compare_une(env, pwd, pws, pwt, df, 0, GETPC());
 }
 
-void helper_msa_fsne_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fsne_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws, uint32_t wt)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -7086,7 +7100,7 @@ void helper_msa_fsne_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
         }                                                                   \
     } while (0)
 
-void helper_msa_fadd_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fadd_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
         uint32_t ws, uint32_t wt)
 {
     wr_t wx, *pwx = &wx;
@@ -7116,7 +7130,7 @@ void helper_msa_fadd_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_fsub_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fsub_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
         uint32_t ws, uint32_t wt)
 {
     wr_t wx, *pwx = &wx;
@@ -7146,7 +7160,7 @@ void helper_msa_fsub_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_fmul_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fmul_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
         uint32_t ws, uint32_t wt)
 {
     wr_t wx, *pwx = &wx;
@@ -7177,7 +7191,7 @@ void helper_msa_fmul_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_fdiv_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fdiv_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
         uint32_t ws, uint32_t wt)
 {
     wr_t wx, *pwx = &wx;
@@ -7222,7 +7236,7 @@ void helper_msa_fdiv_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
         }                                                                   \
     } while (0)
 
-void helper_msa_fmadd_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fmadd_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
         uint32_t ws, uint32_t wt)
 {
     wr_t wx, *pwx = &wx;
@@ -7255,7 +7269,7 @@ void helper_msa_fmadd_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_fmsub_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fmsub_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
         uint32_t ws, uint32_t wt)
 {
     wr_t wx, *pwx = &wx;
@@ -7290,7 +7304,7 @@ void helper_msa_fmsub_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_fexp2_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fexp2_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
         uint32_t ws, uint32_t wt)
 {
     wr_t wx, *pwx = &wx;
@@ -7341,7 +7355,7 @@ void helper_msa_fexp2_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
         }                                                                   \
     } while (0)
 
-void helper_msa_fexdo_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fexdo_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                          uint32_t ws, uint32_t wt)
 {
     wr_t wx, *pwx = &wx;
@@ -7394,7 +7408,7 @@ void helper_msa_fexdo_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
         }                                                                   \
     } while (0)
 
-void helper_msa_ftq_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_ftq_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                        uint32_t ws, uint32_t wt)
 {
     wr_t wx, *pwx = &wx;
@@ -7463,7 +7477,7 @@ void helper_msa_ftq_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
         X = (as == at || xd == float## BITS ##_abs(xs)) ? xs : xt;  \
     } while (0)
 
-void helper_msa_fmin_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fmin_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
         uint32_t ws, uint32_t wt)
 {
     float_status *status = &env->active_tc.msa_fp_status;
@@ -7537,7 +7551,7 @@ void helper_msa_fmin_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_fmin_a_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fmin_a_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
         uint32_t ws, uint32_t wt)
 {
     float_status *status = &env->active_tc.msa_fp_status;
@@ -7565,7 +7579,7 @@ void helper_msa_fmin_a_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_fmax_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fmax_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
         uint32_t ws, uint32_t wt)
 {
      float_status *status = &env->active_tc.msa_fp_status;
@@ -7639,7 +7653,7 @@ void helper_msa_fmax_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_fmax_a_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fmax_a_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
         uint32_t ws, uint32_t wt)
 {
     float_status *status = &env->active_tc.msa_fp_status;
@@ -7667,7 +7681,7 @@ void helper_msa_fmax_a_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_fclass_df(CPUMIPSState *env, uint32_t df,
+void HELPER(msa_fclass_df)(CPUMIPSState *env, uint32_t df,
         uint32_t wd, uint32_t ws)
 {
     float_status *status = &env->active_tc.msa_fp_status;
@@ -7703,7 +7717,7 @@ void helper_msa_fclass_df(CPUMIPSState *env, uint32_t df,
         }                                                                   \
     } while (0)
 
-void helper_msa_ftrunc_s_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_ftrunc_s_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                             uint32_t ws)
 {
     wr_t wx, *pwx = &wx;
@@ -7733,7 +7747,7 @@ void helper_msa_ftrunc_s_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_ftrunc_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_ftrunc_u_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                             uint32_t ws)
 {
     wr_t wx, *pwx = &wx;
@@ -7763,7 +7777,7 @@ void helper_msa_ftrunc_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_fsqrt_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fsqrt_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                          uint32_t ws)
 {
     wr_t wx, *pwx = &wx;
@@ -7810,7 +7824,7 @@ void helper_msa_fsqrt_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
         }                                                                   \
     } while (0)
 
-void helper_msa_frsqrt_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_frsqrt_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                           uint32_t ws)
 {
     wr_t wx, *pwx = &wx;
@@ -7842,7 +7856,7 @@ void helper_msa_frsqrt_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_frcp_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_frcp_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws)
 {
     wr_t wx, *pwx = &wx;
@@ -7872,7 +7886,7 @@ void helper_msa_frcp_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_frint_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_frint_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                          uint32_t ws)
 {
     wr_t wx, *pwx = &wx;
@@ -7926,7 +7940,7 @@ void helper_msa_frint_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
         }                                                                   \
     } while (0)
 
-void helper_msa_flog2_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_flog2_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                          uint32_t ws)
 {
     wr_t wx, *pwx = &wx;
@@ -7956,7 +7970,7 @@ void helper_msa_flog2_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_fexupl_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fexupl_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                           uint32_t ws)
 {
     wr_t wx, *pwx = &wx;
@@ -7992,7 +8006,7 @@ void helper_msa_fexupl_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_fexupr_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_fexupr_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                           uint32_t ws)
 {
     wr_t wx, *pwx = &wx;
@@ -8028,7 +8042,7 @@ void helper_msa_fexupr_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_ffql_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_ffql_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws)
 {
     wr_t wx, *pwx = &wx;
@@ -8054,7 +8068,7 @@ void helper_msa_ffql_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_ffqr_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_ffqr_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                         uint32_t ws)
 {
     wr_t wx, *pwx = &wx;
@@ -8080,7 +8094,7 @@ void helper_msa_ffqr_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_ftint_s_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_ftint_s_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                            uint32_t ws)
 {
     wr_t wx, *pwx = &wx;
@@ -8110,7 +8124,7 @@ void helper_msa_ftint_s_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_ftint_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_ftint_u_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                            uint32_t ws)
 {
     wr_t wx, *pwx = &wx;
@@ -8146,7 +8160,7 @@ void helper_msa_ftint_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 #define float64_from_int64 int64_to_float64
 #define float64_from_uint64 uint64_to_float64
 
-void helper_msa_ffint_s_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_ffint_s_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                            uint32_t ws)
 {
     wr_t wx, *pwx = &wx;
@@ -8176,7 +8190,7 @@ void helper_msa_ffint_s_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     msa_move_v(pwd, pwx);
 }
 
-void helper_msa_ffint_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void HELPER(msa_ffint_u_df)(CPUMIPSState *env, uint32_t df, uint32_t wd,
                            uint32_t ws)
 {
     wr_t wx, *pwx = &wx;
@@ -8223,7 +8237,7 @@ static inline uint64_t bswap32x2(uint64_t x)
     return ror64(bswap64(x), 32);
 }
 
-void helper_msa_ld_b(CPUMIPSState *env, uint32_t wd,
+void HELPER(msa_ld_b)(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -8237,7 +8251,7 @@ void helper_msa_ld_b(CPUMIPSState *env, uint32_t wd,
     pwd->d[1] = d1;
 }
 
-void helper_msa_ld_h(CPUMIPSState *env, uint32_t wd,
+void HELPER(msa_ld_h)(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -8258,7 +8272,7 @@ void helper_msa_ld_h(CPUMIPSState *env, uint32_t wd,
     pwd->d[1] = d1;
 }
 
-void helper_msa_ld_w(CPUMIPSState *env, uint32_t wd,
+void HELPER(msa_ld_w)(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -8279,7 +8293,7 @@ void helper_msa_ld_w(CPUMIPSState *env, uint32_t wd,
     pwd->d[1] = d1;
 }
 
-void helper_msa_ld_d(CPUMIPSState *env, uint32_t wd,
+void HELPER(msa_ld_d)(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -8310,7 +8324,7 @@ static inline void ensure_writable_pages(CPUMIPSState *env,
     }
 }
 
-void helper_msa_st_b(CPUMIPSState *env, uint32_t wd,
+void HELPER(msa_st_b)(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -8324,7 +8338,7 @@ void helper_msa_st_b(CPUMIPSState *env, uint32_t wd,
     cpu_stq_le_data_ra(env, addr + 8, pwd->d[1], ra);
 }
 
-void helper_msa_st_h(CPUMIPSState *env, uint32_t wd,
+void HELPER(msa_st_h)(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -8345,7 +8359,7 @@ void helper_msa_st_h(CPUMIPSState *env, uint32_t wd,
     cpu_stq_le_data_ra(env, addr + 8, d1, ra);
 }
 
-void helper_msa_st_w(CPUMIPSState *env, uint32_t wd,
+void HELPER(msa_st_w)(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
@@ -8366,7 +8380,7 @@ void helper_msa_st_w(CPUMIPSState *env, uint32_t wd,
     cpu_stq_le_data_ra(env, addr + 8, d1, ra);
 }
 
-void helper_msa_st_d(CPUMIPSState *env, uint32_t wd,
+void HELPER(msa_st_d)(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 118397e6322..b061c91ef9c 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -1329,7 +1329,7 @@ static void octeon_aes_decrypt_common(MIPSOcteonCryptoState *crypto, bool cbc)
     }
 }
 
-void helper_octeon_cp2_mt_aes_enc_cbc1(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_aes_enc_cbc1)(CPUMIPSState *env, uint64_t value)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
 
@@ -1337,7 +1337,7 @@ void helper_octeon_cp2_mt_aes_enc_cbc1(CPUMIPSState *env, uint64_t value)
     octeon_aes_encrypt_common(crypto, true);
 }
 
-void helper_octeon_cp2_mt_aes_enc1(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_aes_enc1)(CPUMIPSState *env, uint64_t value)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
 
@@ -1345,7 +1345,7 @@ void helper_octeon_cp2_mt_aes_enc1(CPUMIPSState *env, uint64_t value)
     octeon_aes_encrypt_common(crypto, false);
 }
 
-void helper_octeon_cp2_mt_aes_dec_cbc1(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_aes_dec_cbc1)(CPUMIPSState *env, uint64_t value)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
 
@@ -1353,7 +1353,7 @@ void helper_octeon_cp2_mt_aes_dec_cbc1(CPUMIPSState *env, uint64_t value)
     octeon_aes_decrypt_common(crypto, true);
 }
 
-void helper_octeon_cp2_mt_aes_dec1(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_aes_dec1)(CPUMIPSState *env, uint64_t value)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
 
@@ -1452,7 +1452,7 @@ static void octeon_sms4_crypt_common(MIPSOcteonCryptoState *crypto,
     }
 }
 
-void helper_octeon_cp2_mt_sms4_enc_cbc1(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_sms4_enc_cbc1)(CPUMIPSState *env, uint64_t value)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
 
@@ -1460,7 +1460,7 @@ void helper_octeon_cp2_mt_sms4_enc_cbc1(CPUMIPSState *env, uint64_t value)
     octeon_sms4_crypt_common(crypto, true, true);
 }
 
-void helper_octeon_cp2_mt_sms4_enc1(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_sms4_enc1)(CPUMIPSState *env, uint64_t value)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
 
@@ -1468,7 +1468,7 @@ void helper_octeon_cp2_mt_sms4_enc1(CPUMIPSState *env, uint64_t value)
     octeon_sms4_crypt_common(crypto, true, false);
 }
 
-void helper_octeon_cp2_mt_sms4_dec_cbc1(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_sms4_dec_cbc1)(CPUMIPSState *env, uint64_t value)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
 
@@ -1476,7 +1476,7 @@ void helper_octeon_cp2_mt_sms4_dec_cbc1(CPUMIPSState *env, uint64_t value)
     octeon_sms4_crypt_common(crypto, false, true);
 }
 
-void helper_octeon_cp2_mt_sms4_dec1(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_sms4_dec1)(CPUMIPSState *env, uint64_t value)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
 
@@ -1912,32 +1912,32 @@ static void octeon_kasumi_crypt_common(MIPSOcteonCryptoState *crypto,
     crypto->des3_result = block;
 }
 
-void helper_octeon_cp2_mt_des3_enc_cbc(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_des3_enc_cbc)(CPUMIPSState *env, uint64_t value)
 {
     octeon_3des_crypt_common(&env->octeon_crypto, value, true, true);
 }
 
-void helper_octeon_cp2_mt_kas_enc_cbc(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_kas_enc_cbc)(CPUMIPSState *env, uint64_t value)
 {
     octeon_kasumi_crypt_common(&env->octeon_crypto, value, true);
 }
 
-void helper_octeon_cp2_mt_des3_enc(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_des3_enc)(CPUMIPSState *env, uint64_t value)
 {
     octeon_3des_crypt_common(&env->octeon_crypto, value, true, false);
 }
 
-void helper_octeon_cp2_mt_kas_enc(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_kas_enc)(CPUMIPSState *env, uint64_t value)
 {
     octeon_kasumi_crypt_common(&env->octeon_crypto, value, false);
 }
 
-void helper_octeon_cp2_mt_des3_dec_cbc(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_des3_dec_cbc)(CPUMIPSState *env, uint64_t value)
 {
     octeon_3des_crypt_common(&env->octeon_crypto, value, false, true);
 }
 
-void helper_octeon_cp2_mt_des3_dec(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_des3_dec)(CPUMIPSState *env, uint64_t value)
 {
     octeon_3des_crypt_common(&env->octeon_crypto, value, false, false);
 }
@@ -2053,68 +2053,68 @@ static void octeon_camellia_fl_layer(MIPSOcteonCryptoState *crypto,
         camellia_fl(state, key);
 }
 
-void helper_octeon_cp2_mt_camellia_fl(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_camellia_fl)(CPUMIPSState *env, uint64_t value)
 {
     octeon_camellia_fl_layer(&env->octeon_crypto, value, false);
 }
 
-void helper_octeon_cp2_mt_camellia_flinv(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_camellia_flinv)(CPUMIPSState *env, uint64_t value)
 {
     octeon_camellia_fl_layer(&env->octeon_crypto, value, true);
 }
 
-void helper_octeon_cp2_mt_camellia_round(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_camellia_round)(CPUMIPSState *env, uint64_t value)
 {
     octeon_camellia_round(&env->octeon_crypto, value);
 }
 
-void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_snow3g_start)(CPUMIPSState *env, uint64_t value)
 {
     octeon_snow3g_start(&env->octeon_crypto, value);
 }
 
-void helper_octeon_cp2_mt_snow3g_more(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_snow3g_more)(CPUMIPSState *env, uint64_t value)
 {
     (void)value;
     octeon_snow3g_more(&env->octeon_crypto);
 }
 
-void helper_octeon_cp2_mt_zuc_start(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_zuc_start)(CPUMIPSState *env, uint64_t value)
 {
     octeon_zuc_start(&env->octeon_crypto, value);
 }
 
-void helper_octeon_cp2_mt_zuc_more(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_zuc_more)(CPUMIPSState *env, uint64_t value)
 {
     octeon_zuc_more(&env->octeon_crypto, value);
 }
 
-void helper_octeon_cp2_mt_hsh_startsha1_compat(CPUMIPSState *env,
+void HELPER(octeon_cp2_mt_hsh_startsha1_compat)(CPUMIPSState *env,
                                                uint64_t value)
 {
     octeon_hsh_set_pair(env->octeon_crypto.hsh_dat, 7, value);
     octeon_sha1_transform(&env->octeon_crypto);
 }
 
-void helper_octeon_cp2_mt_hsh_startmd5(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_hsh_startmd5)(CPUMIPSState *env, uint64_t value)
 {
     octeon_hsh_set_pair(env->octeon_crypto.hsh_dat, 7, value);
     octeon_md5_transform(&env->octeon_crypto);
 }
 
-void helper_octeon_cp2_mt_hsh_startsha256(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_hsh_startsha256)(CPUMIPSState *env, uint64_t value)
 {
     octeon_hsh_set_pair(env->octeon_crypto.hsh_dat, 7, value);
     octeon_sha256_transform(&env->octeon_crypto);
 }
 
-void helper_octeon_cp2_mt_hsh_startsha(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_hsh_startsha)(CPUMIPSState *env, uint64_t value)
 {
     octeon_hsh_set_pair(env->octeon_crypto.hsh_dat, 7, value);
     octeon_sha1_transform(&env->octeon_crypto);
 }
 
-void helper_octeon_cp2_mt_hsh_startsha512(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_hsh_startsha512)(CPUMIPSState *env, uint64_t value)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
 
@@ -2122,7 +2122,7 @@ void helper_octeon_cp2_mt_hsh_startsha512(CPUMIPSState *env, uint64_t value)
     octeon_sha512_transform(crypto);
 }
 
-uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
+uint64_t HELPER(octeon_cp2_mf_crc_iv_reflect)(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
 }
@@ -2141,7 +2141,7 @@ static void octeon_gfm_xormul1_common(MIPSOcteonCryptoState *crypto,
     }
 }
 
-void helper_octeon_cp2_mt_gfm_xormul1_reflect(CPUMIPSState *env,
+void HELPER(octeon_cp2_mt_gfm_xormul1_reflect)(CPUMIPSState *env,
                                               uint64_t value)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
@@ -2149,84 +2149,84 @@ void helper_octeon_cp2_mt_gfm_xormul1_reflect(CPUMIPSState *env,
     octeon_gfm_xormul1_common(crypto, revbit64(value));
 }
 
-void helper_octeon_cp2_mt_gfm_xormul1(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_gfm_xormul1)(CPUMIPSState *env, uint64_t value)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
 
     octeon_gfm_xormul1_common(crypto, value);
 }
 
-void helper_octeon_cp2_mt_sha3_startop(CPUMIPSState *env)
+void HELPER(octeon_cp2_mt_sha3_startop)(CPUMIPSState *env)
 {
     octeon_sha3_permute(&env->octeon_crypto);
 }
 
-void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
+void HELPER(octeon_cp2_mt_crc_write_iv_reflect)(CPUMIPSState *env,
                                                uint64_t value)
 {
     env->octeon_crypto.crc_iv =
         octeon_crc_reflect32_by_byte((uint32_t)value);
 }
 
-void helper_octeon_cp2_mt_crc_write_polynomial_reflect(CPUMIPSState *env,
+void HELPER(octeon_cp2_mt_crc_write_polynomial_reflect)(CPUMIPSState *env,
                                                        uint64_t value)
 {
     env->octeon_crypto.crc_poly =
         octeon_crc_reflect32_by_byte((uint32_t)value);
 }
 
-void helper_octeon_cp2_mt_crc_write_byte(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_crc_write_byte)(CPUMIPSState *env, uint64_t value)
 {
     octeon_crc_update_normal(&env->octeon_crypto, value, 1);
 }
 
-void helper_octeon_cp2_mt_crc_write_half(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_crc_write_half)(CPUMIPSState *env, uint64_t value)
 {
     octeon_crc_update_normal(&env->octeon_crypto, value, 2);
 }
 
-void helper_octeon_cp2_mt_crc_write_word(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_crc_write_word)(CPUMIPSState *env, uint64_t value)
 {
     octeon_crc_update_normal(&env->octeon_crypto, value, 4);
 }
 
-void helper_octeon_cp2_mt_crc_write_dword(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_crc_write_dword)(CPUMIPSState *env, uint64_t value)
 {
     octeon_crc_update_normal(&env->octeon_crypto, value, 8);
 }
 
-void helper_octeon_cp2_mt_crc_write_var(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_crc_write_var)(CPUMIPSState *env, uint64_t value)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
 
     octeon_crc_update_normal(crypto, value, MIN(8U, crypto->crc_len & 0xf));
 }
 
-void helper_octeon_cp2_mt_crc_write_byte_reflect(CPUMIPSState *env,
+void HELPER(octeon_cp2_mt_crc_write_byte_reflect)(CPUMIPSState *env,
                                                  uint64_t value)
 {
     octeon_crc_update_reflect(&env->octeon_crypto, value, 1);
 }
 
-void helper_octeon_cp2_mt_crc_write_half_reflect(CPUMIPSState *env,
+void HELPER(octeon_cp2_mt_crc_write_half_reflect)(CPUMIPSState *env,
                                                  uint64_t value)
 {
     octeon_crc_update_reflect(&env->octeon_crypto, value, 2);
 }
 
-void helper_octeon_cp2_mt_crc_write_word_reflect(CPUMIPSState *env,
+void HELPER(octeon_cp2_mt_crc_write_word_reflect)(CPUMIPSState *env,
                                                  uint64_t value)
 {
     octeon_crc_update_reflect(&env->octeon_crypto, value, 4);
 }
 
-void helper_octeon_cp2_mt_crc_write_dword_reflect(CPUMIPSState *env,
+void HELPER(octeon_cp2_mt_crc_write_dword_reflect)(CPUMIPSState *env,
                                                   uint64_t value)
 {
     octeon_crc_update_reflect(&env->octeon_crypto, value, 8);
 }
 
-void helper_octeon_cp2_mt_crc_write_var_reflect(CPUMIPSState *env,
+void HELPER(octeon_cp2_mt_crc_write_var_reflect)(CPUMIPSState *env,
                                                 uint64_t value)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
@@ -2234,42 +2234,42 @@ void helper_octeon_cp2_mt_crc_write_var_reflect(CPUMIPSState *env,
     octeon_crc_update_reflect(crypto, value, MIN(8U, crypto->crc_len & 0xf));
 }
 
-void helper_octeon_cp2_mt_llm_read_addr0(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_llm_read_addr0)(CPUMIPSState *env, uint64_t value)
 {
     octeon_llm_read(&env->octeon_crypto, 0, value, false);
 }
 
-void helper_octeon_cp2_mt_llm_write_addr0(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_llm_write_addr0)(CPUMIPSState *env, uint64_t value)
 {
     octeon_llm_write(&env->octeon_crypto, 0, value, false);
 }
 
-void helper_octeon_cp2_mt_llm_read64_addr0(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_llm_read64_addr0)(CPUMIPSState *env, uint64_t value)
 {
     octeon_llm_read(&env->octeon_crypto, 0, value, true);
 }
 
-void helper_octeon_cp2_mt_llm_write64_addr0(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_llm_write64_addr0)(CPUMIPSState *env, uint64_t value)
 {
     octeon_llm_write(&env->octeon_crypto, 0, value, true);
 }
 
-void helper_octeon_cp2_mt_llm_read_addr1(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_llm_read_addr1)(CPUMIPSState *env, uint64_t value)
 {
     octeon_llm_read(&env->octeon_crypto, 1, value, false);
 }
 
-void helper_octeon_cp2_mt_llm_write_addr1(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_llm_write_addr1)(CPUMIPSState *env, uint64_t value)
 {
     octeon_llm_write(&env->octeon_crypto, 1, value, false);
 }
 
-void helper_octeon_cp2_mt_llm_read64_addr1(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_llm_read64_addr1)(CPUMIPSState *env, uint64_t value)
 {
     octeon_llm_read(&env->octeon_crypto, 1, value, true);
 }
 
-void helper_octeon_cp2_mt_llm_write64_addr1(CPUMIPSState *env, uint64_t value)
+void HELPER(octeon_cp2_mt_llm_write64_addr1)(CPUMIPSState *env, uint64_t value)
 {
     octeon_llm_write(&env->octeon_crypto, 1, value, true);
 }
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index df1b5c37347..c3f0c05bc31 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -40,18 +40,18 @@ static inline target_ulong bitswap(target_ulong v)
 }
 
 #ifdef TARGET_MIPS64
-target_ulong helper_dbitswap(target_ulong rt)
+target_ulong HELPER(dbitswap)(target_ulong rt)
 {
     return bitswap(rt);
 }
 #endif
 
-target_ulong helper_bitswap(target_ulong rt)
+target_ulong HELPER(bitswap)(target_ulong rt)
 {
     return (int32_t)bitswap(rt);
 }
 
-target_ulong helper_rotx(target_ulong rs, uint32_t shift, uint32_t shiftx,
+target_ulong HELPER(rotx)(target_ulong rs, uint32_t shift, uint32_t shiftx,
                         uint32_t stripe)
 {
     int i;
@@ -146,7 +146,7 @@ target_ulong helper_rotx(target_ulong rs, uint32_t shift, uint32_t shiftx,
 }
 
 /* these crc32 functions are based on target/loongarch/tcg/op_helper.c */
-target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
+target_ulong HELPER(crc32)(target_ulong val, target_ulong m, uint32_t sz)
 {
     uint8_t buf[8];
     target_ulong mask = ((sz * 8) == 64) ?
@@ -158,7 +158,7 @@ target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
     return (int32_t) (crc32(val ^ 0xffffffff, buf, sz) ^ 0xffffffff);
 }
 
-target_ulong helper_crc32c(target_ulong val, target_ulong m, uint32_t sz)
+target_ulong HELPER(crc32c)(target_ulong val, target_ulong m, uint32_t sz)
 {
     uint8_t buf[8];
     target_ulong mask = ((sz * 8) == 64) ?
@@ -169,7 +169,7 @@ target_ulong helper_crc32c(target_ulong val, target_ulong m, uint32_t sz)
     return (int32_t) (crc32c(val, buf, sz) ^ 0xffffffff);
 }
 
-void helper_fork(target_ulong arg1, target_ulong arg2)
+void HELPER(fork)(target_ulong arg1, target_ulong arg2)
 {
     /*
      * arg1 = rt, arg2 = rs
@@ -177,7 +177,7 @@ void helper_fork(target_ulong arg1, target_ulong arg2)
      */
 }
 
-target_ulong helper_yield(CPUMIPSState *env, target_ulong arg)
+target_ulong HELPER(yield)(CPUMIPSState *env, target_ulong arg)
 {
     target_long arg1 = arg;
 
@@ -216,19 +216,19 @@ static inline void check_hwrena(CPUMIPSState *env, int reg, uintptr_t pc)
     do_raise_exception(env, EXCP_RI, pc);
 }
 
-target_ulong helper_rdhwr_cpunum(CPUMIPSState *env)
+target_ulong HELPER(rdhwr_cpunum)(CPUMIPSState *env)
 {
     check_hwrena(env, 0, GETPC());
     return env->CP0_EBase & 0x3ff;
 }
 
-target_ulong helper_rdhwr_synci_step(CPUMIPSState *env)
+target_ulong HELPER(rdhwr_synci_step)(CPUMIPSState *env)
 {
     check_hwrena(env, 1, GETPC());
     return env->SYNCI_Step;
 }
 
-target_ulong helper_rdhwr_cc(CPUMIPSState *env)
+target_ulong HELPER(rdhwr_cc)(CPUMIPSState *env)
 {
     check_hwrena(env, 2, GETPC());
 #ifdef CONFIG_USER_ONLY
@@ -238,31 +238,31 @@ target_ulong helper_rdhwr_cc(CPUMIPSState *env)
 #endif
 }
 
-target_ulong helper_rdhwr_ccres(CPUMIPSState *env)
+target_ulong HELPER(rdhwr_ccres)(CPUMIPSState *env)
 {
     check_hwrena(env, 3, GETPC());
     return env->CCRes;
 }
 
-target_ulong helper_rdhwr_performance(CPUMIPSState *env)
+target_ulong HELPER(rdhwr_performance)(CPUMIPSState *env)
 {
     check_hwrena(env, 4, GETPC());
     return env->CP0_Performance0;
 }
 
-target_ulong helper_rdhwr_xnp(CPUMIPSState *env)
+target_ulong HELPER(rdhwr_xnp)(CPUMIPSState *env)
 {
     check_hwrena(env, 5, GETPC());
     return (env->CP0_Config5 >> CP0C5_XNP) & 1;
 }
 
-target_ulong helper_rdhwr_chord(CPUMIPSState *env)
+target_ulong HELPER(rdhwr_chord)(CPUMIPSState *env)
 {
     check_hwrena(env, 30, GETPC());
     return env->octeon_crypto.chord;
 }
 
-target_ulong helper_rdhwr_cvmcount(CPUMIPSState *env)
+target_ulong HELPER(rdhwr_cvmcount)(CPUMIPSState *env)
 {
     check_hwrena(env, 31, GETPC());
 #ifdef CONFIG_USER_ONLY
@@ -272,7 +272,7 @@ target_ulong helper_rdhwr_cvmcount(CPUMIPSState *env)
 #endif
 }
 
-void helper_pmon(CPUMIPSState *env, int function)
+void HELPER(pmon)(CPUMIPSState *env, int function)
 {
     function /= 2;
     switch (function) {
@@ -300,7 +300,7 @@ void helper_pmon(CPUMIPSState *env, int function)
 }
 
 #ifdef TARGET_MIPS64
-target_ulong helper_lcsr_cpucfg(CPUMIPSState *env, target_ulong rs)
+target_ulong HELPER(lcsr_cpucfg)(CPUMIPSState *env, target_ulong rs)
 {
     switch (rs) {
     case 0:
diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index ba6b487b751..ceffcc37323 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -227,35 +227,35 @@ uint32_t cpu_mips_get_random(CPUMIPSState *env)
 }
 
 /* CP0 helpers */
-target_ulong helper_mfc0_mvpcontrol(CPUMIPSState *env)
+target_ulong HELPER(mfc0_mvpcontrol)(CPUMIPSState *env)
 {
     MIPSCPU *cpu = env_archcpu(env);
     return cpu->mvp->CP0_MVPControl;
 }
 
-target_ulong helper_mfc0_mvpconf0(CPUMIPSState *env)
+target_ulong HELPER(mfc0_mvpconf0)(CPUMIPSState *env)
 {
     MIPSCPU *cpu = env_archcpu(env);
     return cpu->mvp->CP0_MVPConf0;
 }
 
-target_ulong helper_mfc0_mvpconf1(CPUMIPSState *env)
+target_ulong HELPER(mfc0_mvpconf1)(CPUMIPSState *env)
 {
     MIPSCPU *cpu = env_archcpu(env);
     return cpu->mvp->CP0_MVPConf1;
 }
 
-target_ulong helper_mfc0_random(CPUMIPSState *env)
+target_ulong HELPER(mfc0_random)(CPUMIPSState *env)
 {
     return (int32_t)cpu_mips_get_random(env);
 }
 
-target_ulong helper_mfc0_tcstatus(CPUMIPSState *env)
+target_ulong HELPER(mfc0_tcstatus)(CPUMIPSState *env)
 {
     return env->active_tc.CP0_TCStatus;
 }
 
-target_ulong helper_mftc0_tcstatus(CPUMIPSState *env)
+target_ulong HELPER(mftc0_tcstatus)(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -267,12 +267,12 @@ target_ulong helper_mftc0_tcstatus(CPUMIPSState *env)
     }
 }
 
-target_ulong helper_mfc0_tcbind(CPUMIPSState *env)
+target_ulong HELPER(mfc0_tcbind)(CPUMIPSState *env)
 {
     return env->active_tc.CP0_TCBind;
 }
 
-target_ulong helper_mftc0_tcbind(CPUMIPSState *env)
+target_ulong HELPER(mftc0_tcbind)(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -284,12 +284,12 @@ target_ulong helper_mftc0_tcbind(CPUMIPSState *env)
     }
 }
 
-target_ulong helper_mfc0_tcrestart(CPUMIPSState *env)
+target_ulong HELPER(mfc0_tcrestart)(CPUMIPSState *env)
 {
     return env->active_tc.PC;
 }
 
-target_ulong helper_mftc0_tcrestart(CPUMIPSState *env)
+target_ulong HELPER(mftc0_tcrestart)(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -301,12 +301,12 @@ target_ulong helper_mftc0_tcrestart(CPUMIPSState *env)
     }
 }
 
-target_ulong helper_mfc0_tchalt(CPUMIPSState *env)
+target_ulong HELPER(mfc0_tchalt)(CPUMIPSState *env)
 {
     return env->active_tc.CP0_TCHalt;
 }
 
-target_ulong helper_mftc0_tchalt(CPUMIPSState *env)
+target_ulong HELPER(mftc0_tchalt)(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -318,12 +318,12 @@ target_ulong helper_mftc0_tchalt(CPUMIPSState *env)
     }
 }
 
-target_ulong helper_mfc0_tccontext(CPUMIPSState *env)
+target_ulong HELPER(mfc0_tccontext)(CPUMIPSState *env)
 {
     return env->active_tc.CP0_TCContext;
 }
 
-target_ulong helper_mftc0_tccontext(CPUMIPSState *env)
+target_ulong HELPER(mftc0_tccontext)(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -335,12 +335,12 @@ target_ulong helper_mftc0_tccontext(CPUMIPSState *env)
     }
 }
 
-target_ulong helper_mfc0_tcschedule(CPUMIPSState *env)
+target_ulong HELPER(mfc0_tcschedule)(CPUMIPSState *env)
 {
     return env->active_tc.CP0_TCSchedule;
 }
 
-target_ulong helper_mftc0_tcschedule(CPUMIPSState *env)
+target_ulong HELPER(mftc0_tcschedule)(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -352,12 +352,12 @@ target_ulong helper_mftc0_tcschedule(CPUMIPSState *env)
     }
 }
 
-target_ulong helper_mfc0_tcschefback(CPUMIPSState *env)
+target_ulong HELPER(mfc0_tcschefback)(CPUMIPSState *env)
 {
     return env->active_tc.CP0_TCScheFBack;
 }
 
-target_ulong helper_mftc0_tcschefback(CPUMIPSState *env)
+target_ulong HELPER(mftc0_tcschefback)(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -369,12 +369,12 @@ target_ulong helper_mftc0_tcschefback(CPUMIPSState *env)
     }
 }
 
-target_ulong helper_mfc0_count(CPUMIPSState *env)
+target_ulong HELPER(mfc0_count)(CPUMIPSState *env)
 {
     return (int32_t)cpu_mips_get_count(env);
 }
 
-target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
+target_ulong HELPER(mftc0_entryhi)(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -382,7 +382,7 @@ target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
     return other->CP0_EntryHi;
 }
 
-target_ulong helper_mftc0_cause(CPUMIPSState *env)
+target_ulong HELPER(mftc0_cause)(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -390,7 +390,7 @@ target_ulong helper_mftc0_cause(CPUMIPSState *env)
     return other->CP0_Cause;
 }
 
-target_ulong helper_mftc0_status(CPUMIPSState *env)
+target_ulong HELPER(mftc0_status)(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -398,37 +398,37 @@ target_ulong helper_mftc0_status(CPUMIPSState *env)
     return other->CP0_Status;
 }
 
-target_ulong helper_mfc0_lladdr(CPUMIPSState *env)
+target_ulong HELPER(mfc0_lladdr)(CPUMIPSState *env)
 {
     return (int32_t)(env->CP0_LLAddr >> env->CP0_LLAddr_shift);
 }
 
-target_ulong helper_mfc0_maar(CPUMIPSState *env)
+target_ulong HELPER(mfc0_maar)(CPUMIPSState *env)
 {
     return (int32_t) env->CP0_MAAR[env->CP0_MAARI];
 }
 
-target_ulong helper_mfhc0_maar(CPUMIPSState *env)
+target_ulong HELPER(mfhc0_maar)(CPUMIPSState *env)
 {
     return env->CP0_MAAR[env->CP0_MAARI] >> 32;
 }
 
-target_ulong helper_mfc0_watchlo(CPUMIPSState *env, uint32_t sel)
+target_ulong HELPER(mfc0_watchlo)(CPUMIPSState *env, uint32_t sel)
 {
     return (int32_t)env->CP0_WatchLo[sel];
 }
 
-target_ulong helper_mfc0_watchhi(CPUMIPSState *env, uint32_t sel)
+target_ulong HELPER(mfc0_watchhi)(CPUMIPSState *env, uint32_t sel)
 {
     return (int32_t) env->CP0_WatchHi[sel];
 }
 
-target_ulong helper_mfhc0_watchhi(CPUMIPSState *env, uint32_t sel)
+target_ulong HELPER(mfhc0_watchhi)(CPUMIPSState *env, uint32_t sel)
 {
     return env->CP0_WatchHi[sel] >> 32;
 }
 
-target_ulong helper_mfc0_debug(CPUMIPSState *env)
+target_ulong HELPER(mfc0_debug)(CPUMIPSState *env)
 {
     target_ulong t0 = env->CP0_Debug;
     if (env->hflags & MIPS_HFLAG_DM) {
@@ -438,7 +438,7 @@ target_ulong helper_mfc0_debug(CPUMIPSState *env)
     return t0;
 }
 
-target_ulong helper_mftc0_debug(CPUMIPSState *env)
+target_ulong HELPER(mftc0_debug)(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     int32_t tcstatus;
@@ -456,54 +456,54 @@ target_ulong helper_mftc0_debug(CPUMIPSState *env)
 }
 
 #if defined(TARGET_MIPS64)
-target_ulong helper_dmfc0_tcrestart(CPUMIPSState *env)
+target_ulong HELPER(dmfc0_tcrestart)(CPUMIPSState *env)
 {
     return env->active_tc.PC;
 }
 
-target_ulong helper_dmfc0_tchalt(CPUMIPSState *env)
+target_ulong HELPER(dmfc0_tchalt)(CPUMIPSState *env)
 {
     return env->active_tc.CP0_TCHalt;
 }
 
-target_ulong helper_dmfc0_tccontext(CPUMIPSState *env)
+target_ulong HELPER(dmfc0_tccontext)(CPUMIPSState *env)
 {
     return env->active_tc.CP0_TCContext;
 }
 
-target_ulong helper_dmfc0_tcschedule(CPUMIPSState *env)
+target_ulong HELPER(dmfc0_tcschedule)(CPUMIPSState *env)
 {
     return env->active_tc.CP0_TCSchedule;
 }
 
-target_ulong helper_dmfc0_tcschefback(CPUMIPSState *env)
+target_ulong HELPER(dmfc0_tcschefback)(CPUMIPSState *env)
 {
     return env->active_tc.CP0_TCScheFBack;
 }
 
-target_ulong helper_dmfc0_lladdr(CPUMIPSState *env)
+target_ulong HELPER(dmfc0_lladdr)(CPUMIPSState *env)
 {
     return env->CP0_LLAddr >> env->CP0_LLAddr_shift;
 }
 
-target_ulong helper_dmfc0_maar(CPUMIPSState *env)
+target_ulong HELPER(dmfc0_maar)(CPUMIPSState *env)
 {
     return env->CP0_MAAR[env->CP0_MAARI];
 }
 
-target_ulong helper_dmfc0_watchlo(CPUMIPSState *env, uint32_t sel)
+target_ulong HELPER(dmfc0_watchlo)(CPUMIPSState *env, uint32_t sel)
 {
     return env->CP0_WatchLo[sel];
 }
 
-target_ulong helper_dmfc0_watchhi(CPUMIPSState *env, uint32_t sel)
+target_ulong HELPER(dmfc0_watchhi)(CPUMIPSState *env, uint32_t sel)
 {
     return env->CP0_WatchHi[sel];
 }
 
 #endif /* TARGET_MIPS64 */
 
-void helper_mtc0_index(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_index)(CPUMIPSState *env, target_ulong arg1)
 {
     uint32_t index_p = env->CP0_Index & 0x80000000;
     uint32_t tlb_index = arg1 & 0x7fffffff;
@@ -515,7 +515,7 @@ void helper_mtc0_index(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void helper_mtc0_mvpcontrol(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_mvpcontrol)(CPUMIPSState *env, target_ulong arg1)
 {
     MIPSCPU *cpu = env_archcpu(env);
     uint32_t mask = 0;
@@ -535,7 +535,7 @@ void helper_mtc0_mvpcontrol(CPUMIPSState *env, target_ulong arg1)
     cpu->mvp->CP0_MVPControl = newval;
 }
 
-void helper_mtc0_vpecontrol(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_vpecontrol)(CPUMIPSState *env, target_ulong arg1)
 {
     uint32_t mask;
     uint32_t newval;
@@ -554,7 +554,7 @@ void helper_mtc0_vpecontrol(CPUMIPSState *env, target_ulong arg1)
     env->CP0_VPEControl = newval;
 }
 
-void helper_mttc0_vpecontrol(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mttc0_vpecontrol)(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -570,7 +570,7 @@ void helper_mttc0_vpecontrol(CPUMIPSState *env, target_ulong arg1)
     other->CP0_VPEControl = newval;
 }
 
-target_ulong helper_mftc0_vpecontrol(CPUMIPSState *env)
+target_ulong HELPER(mftc0_vpecontrol)(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -578,7 +578,7 @@ target_ulong helper_mftc0_vpecontrol(CPUMIPSState *env)
     return other->CP0_VPEControl;
 }
 
-target_ulong helper_mftc0_vpeconf0(CPUMIPSState *env)
+target_ulong HELPER(mftc0_vpeconf0)(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -586,7 +586,7 @@ target_ulong helper_mftc0_vpeconf0(CPUMIPSState *env)
     return other->CP0_VPEConf0;
 }
 
-void helper_mtc0_vpeconf0(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_vpeconf0)(CPUMIPSState *env, target_ulong arg1)
 {
     uint32_t mask = 0;
     uint32_t newval;
@@ -604,7 +604,7 @@ void helper_mtc0_vpeconf0(CPUMIPSState *env, target_ulong arg1)
     env->CP0_VPEConf0 = newval;
 }
 
-void helper_mttc0_vpeconf0(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mttc0_vpeconf0)(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -618,7 +618,7 @@ void helper_mttc0_vpeconf0(CPUMIPSState *env, target_ulong arg1)
     other->CP0_VPEConf0 = newval;
 }
 
-void helper_mtc0_vpeconf1(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_vpeconf1)(CPUMIPSState *env, target_ulong arg1)
 {
     MIPSCPU *cpu = env_archcpu(env);
     uint32_t mask = 0;
@@ -637,20 +637,20 @@ void helper_mtc0_vpeconf1(CPUMIPSState *env, target_ulong arg1)
     env->CP0_VPEConf1 = newval;
 }
 
-void helper_mtc0_yqmask(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_yqmask)(CPUMIPSState *env, target_ulong arg1)
 {
     /* Yield qualifier inputs not implemented. */
     env->CP0_YQMask = 0x00000000;
 }
 
-void helper_mtc0_vpeopt(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_vpeopt)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_VPEOpt = arg1 & 0x0000ffff;
 }
 
 #define MTC0_ENTRYLO_MASK(env) ((env->PAMask >> 6) & 0x3FFFFFFF)
 
-void helper_mtc0_entrylo0(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_entrylo0)(CPUMIPSState *env, target_ulong arg1)
 {
     /* 1k pages not implemented */
     target_ulong rxi = arg1 & (env->CP0_PageGrain & (3u << CP0PG_XIE));
@@ -661,14 +661,14 @@ void helper_mtc0_entrylo0(CPUMIPSState *env, target_ulong arg1)
 #if defined(TARGET_MIPS64)
 #define DMTC0_ENTRYLO_MASK(env) (env->PAMask >> 6)
 
-void helper_dmtc0_entrylo0(CPUMIPSState *env, uint64_t arg1)
+void HELPER(dmtc0_entrylo0)(CPUMIPSState *env, uint64_t arg1)
 {
     uint64_t rxi = arg1 & ((env->CP0_PageGrain & (3ull << CP0PG_XIE)) << 32);
     env->CP0_EntryLo0 = (arg1 & DMTC0_ENTRYLO_MASK(env)) | rxi;
 }
 #endif
 
-void helper_mtc0_tcstatus(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_tcstatus)(CPUMIPSState *env, target_ulong arg1)
 {
     uint32_t mask = env->CP0_TCStatus_rw_bitmask;
     uint32_t newval;
@@ -679,7 +679,7 @@ void helper_mtc0_tcstatus(CPUMIPSState *env, target_ulong arg1)
     sync_c0_tcstatus(env, env->current_tc, newval);
 }
 
-void helper_mttc0_tcstatus(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mttc0_tcstatus)(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -692,7 +692,7 @@ void helper_mttc0_tcstatus(CPUMIPSState *env, target_ulong arg1)
     sync_c0_tcstatus(other, other_tc, arg1);
 }
 
-void helper_mtc0_tcbind(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_tcbind)(CPUMIPSState *env, target_ulong arg1)
 {
     MIPSCPU *cpu = env_archcpu(env);
     uint32_t mask = (1 << CP0TCBd_TBE);
@@ -705,7 +705,7 @@ void helper_mtc0_tcbind(CPUMIPSState *env, target_ulong arg1)
     env->active_tc.CP0_TCBind = newval;
 }
 
-void helper_mttc0_tcbind(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mttc0_tcbind)(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     uint32_t mask = (1 << CP0TCBd_TBE);
@@ -725,7 +725,7 @@ void helper_mttc0_tcbind(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void helper_mtc0_tcrestart(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_tcrestart)(CPUMIPSState *env, target_ulong arg1)
 {
     env->active_tc.PC = arg1;
     env->active_tc.CP0_TCStatus &= ~(1 << CP0TCSt_TDS);
@@ -734,7 +734,7 @@ void helper_mtc0_tcrestart(CPUMIPSState *env, target_ulong arg1)
     /* MIPS16 not implemented. */
 }
 
-void helper_mttc0_tcrestart(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mttc0_tcrestart)(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -754,7 +754,7 @@ void helper_mttc0_tcrestart(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void helper_mtc0_tchalt(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_tchalt)(CPUMIPSState *env, target_ulong arg1)
 {
     MIPSCPU *cpu = env_archcpu(env);
 
@@ -768,7 +768,7 @@ void helper_mtc0_tchalt(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void helper_mttc0_tchalt(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mttc0_tchalt)(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -789,12 +789,12 @@ void helper_mttc0_tchalt(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void helper_mtc0_tccontext(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_tccontext)(CPUMIPSState *env, target_ulong arg1)
 {
     env->active_tc.CP0_TCContext = arg1;
 }
 
-void helper_mttc0_tccontext(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mttc0_tccontext)(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -806,12 +806,12 @@ void helper_mttc0_tccontext(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void helper_mtc0_tcschedule(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_tcschedule)(CPUMIPSState *env, target_ulong arg1)
 {
     env->active_tc.CP0_TCSchedule = arg1;
 }
 
-void helper_mttc0_tcschedule(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mttc0_tcschedule)(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -823,12 +823,12 @@ void helper_mttc0_tcschedule(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void helper_mtc0_tcschefback(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_tcschefback)(CPUMIPSState *env, target_ulong arg1)
 {
     env->active_tc.CP0_TCScheFBack = arg1;
 }
 
-void helper_mttc0_tcschefback(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mttc0_tcschefback)(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -840,7 +840,7 @@ void helper_mttc0_tcschefback(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void helper_mtc0_entrylo1(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_entrylo1)(CPUMIPSState *env, target_ulong arg1)
 {
     /* 1k pages not implemented */
     target_ulong rxi = arg1 & (env->CP0_PageGrain & (3u << CP0PG_XIE));
@@ -849,19 +849,19 @@ void helper_mtc0_entrylo1(CPUMIPSState *env, target_ulong arg1)
 }
 
 #if defined(TARGET_MIPS64)
-void helper_dmtc0_entrylo1(CPUMIPSState *env, uint64_t arg1)
+void HELPER(dmtc0_entrylo1)(CPUMIPSState *env, uint64_t arg1)
 {
     uint64_t rxi = arg1 & ((env->CP0_PageGrain & (3ull << CP0PG_XIE)) << 32);
     env->CP0_EntryLo1 = (arg1 & DMTC0_ENTRYLO_MASK(env)) | rxi;
 }
 #endif
 
-void helper_mtc0_context(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_context)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_Context = (env->CP0_Context & 0x007FFFFF) | (arg1 & ~0x007FFFFF);
 }
 
-void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_memorymapid)(CPUMIPSState *env, target_ulong arg1)
 {
     int32_t old;
     old = env->CP0_MemoryMapID;
@@ -887,12 +887,12 @@ uint32_t compute_pagemask(uint32_t val)
     }
 }
 
-void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_pagemask)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_PageMask = compute_pagemask(arg1);
 }
 
-void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_pagegrain)(CPUMIPSState *env, target_ulong arg1)
 {
     /* SmartMIPS not implemented */
     /* 1k pages not implemented */
@@ -902,7 +902,7 @@ void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
     restore_pamask(env);
 }
 
-void helper_mtc0_segctl0(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_segctl0)(CPUMIPSState *env, target_ulong arg1)
 {
     CPUState *cs = env_cpu(env);
 
@@ -910,7 +910,7 @@ void helper_mtc0_segctl0(CPUMIPSState *env, target_ulong arg1)
     tlb_flush(cs);
 }
 
-void helper_mtc0_segctl1(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_segctl1)(CPUMIPSState *env, target_ulong arg1)
 {
     CPUState *cs = env_cpu(env);
 
@@ -918,7 +918,7 @@ void helper_mtc0_segctl1(CPUMIPSState *env, target_ulong arg1)
     tlb_flush(cs);
 }
 
-void helper_mtc0_segctl2(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_segctl2)(CPUMIPSState *env, target_ulong arg1)
 {
     CPUState *cs = env_cpu(env);
 
@@ -926,7 +926,7 @@ void helper_mtc0_segctl2(CPUMIPSState *env, target_ulong arg1)
     tlb_flush(cs);
 }
 
-void helper_mtc0_pwfield(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_pwfield)(CPUMIPSState *env, target_ulong arg1)
 {
 #if defined(TARGET_MIPS64)
     uint64_t mask = 0x3F3FFFFFFFULL;
@@ -988,7 +988,7 @@ void helper_mtc0_pwfield(CPUMIPSState *env, target_ulong arg1)
 #endif
 }
 
-void helper_mtc0_pwsize(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_pwsize)(CPUMIPSState *env, target_ulong arg1)
 {
 #if defined(TARGET_MIPS64)
     env->CP0_PWSize = arg1 & 0x3F7FFFFFFFULL;
@@ -997,7 +997,7 @@ void helper_mtc0_pwsize(CPUMIPSState *env, target_ulong arg1)
 #endif
 }
 
-void helper_mtc0_wired(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_wired)(CPUMIPSState *env, target_ulong arg1)
 {
     if (env->insn_flags & ISA_MIPS_R6) {
         if (arg1 < env->tlb->nb_tlb) {
@@ -1008,7 +1008,7 @@ void helper_mtc0_wired(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void helper_mtc0_pwctl(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_pwctl)(CPUMIPSState *env, target_ulong arg1)
 {
 #if defined(TARGET_MIPS64)
     /* PWEn = 0. Hardware page table walking is not implemented. */
@@ -1018,32 +1018,32 @@ void helper_mtc0_pwctl(CPUMIPSState *env, target_ulong arg1)
 #endif
 }
 
-void helper_mtc0_srsconf0(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_srsconf0)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_SRSConf0 |= arg1 & env->CP0_SRSConf0_rw_bitmask;
 }
 
-void helper_mtc0_srsconf1(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_srsconf1)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_SRSConf1 |= arg1 & env->CP0_SRSConf1_rw_bitmask;
 }
 
-void helper_mtc0_srsconf2(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_srsconf2)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_SRSConf2 |= arg1 & env->CP0_SRSConf2_rw_bitmask;
 }
 
-void helper_mtc0_srsconf3(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_srsconf3)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_SRSConf3 |= arg1 & env->CP0_SRSConf3_rw_bitmask;
 }
 
-void helper_mtc0_srsconf4(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_srsconf4)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_SRSConf4 |= arg1 & env->CP0_SRSConf4_rw_bitmask;
 }
 
-void helper_mtc0_hwrena(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_hwrena)(CPUMIPSState *env, target_ulong arg1)
 {
     uint32_t mask = 0x0000000F;
 
@@ -1067,12 +1067,12 @@ void helper_mtc0_hwrena(CPUMIPSState *env, target_ulong arg1)
     env->CP0_HWREna = arg1 & mask;
 }
 
-void helper_mtc0_count(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_count)(CPUMIPSState *env, target_ulong arg1)
 {
     cpu_mips_store_count(env, arg1);
 }
 
-void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_entryhi)(CPUMIPSState *env, target_ulong arg1)
 {
     target_ulong old, val, mask;
     mask = (TARGET_PAGE_MASK << 1) | env->CP0_EntryHi_ASID_mask;
@@ -1107,7 +1107,7 @@ void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void helper_mttc0_entryhi(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mttc0_entryhi)(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1116,12 +1116,12 @@ void helper_mttc0_entryhi(CPUMIPSState *env, target_ulong arg1)
     sync_c0_entryhi(other, other_tc);
 }
 
-void helper_mtc0_compare(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_compare)(CPUMIPSState *env, target_ulong arg1)
 {
     cpu_mips_store_compare(env, arg1);
 }
 
-void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_status)(CPUMIPSState *env, target_ulong arg1)
 {
     uint32_t val, old;
 
@@ -1154,7 +1154,7 @@ void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void helper_mttc0_status(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mttc0_status)(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     uint32_t mask = env->CP0_Status_rw_bitmask & ~0xf1000018;
@@ -1164,23 +1164,23 @@ void helper_mttc0_status(CPUMIPSState *env, target_ulong arg1)
     sync_c0_status(env, other, other_tc);
 }
 
-void helper_mtc0_intctl(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_intctl)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_IntCtl = (env->CP0_IntCtl & ~0x000003e0) | (arg1 & 0x000003e0);
 }
 
-void helper_mtc0_srsctl(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_srsctl)(CPUMIPSState *env, target_ulong arg1)
 {
     uint32_t mask = (0xf << CP0SRSCtl_ESS) | (0xf << CP0SRSCtl_PSS);
     env->CP0_SRSCtl = (env->CP0_SRSCtl & ~mask) | (arg1 & mask);
 }
 
-void helper_mtc0_cause(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_cause)(CPUMIPSState *env, target_ulong arg1)
 {
     cpu_mips_store_cause(env, arg1);
 }
 
-void helper_mttc0_cause(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mttc0_cause)(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1188,7 +1188,7 @@ void helper_mttc0_cause(CPUMIPSState *env, target_ulong arg1)
     cpu_mips_store_cause(other, arg1);
 }
 
-target_ulong helper_mftc0_epc(CPUMIPSState *env)
+target_ulong HELPER(mftc0_epc)(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1196,7 +1196,7 @@ target_ulong helper_mftc0_epc(CPUMIPSState *env)
     return other->CP0_EPC;
 }
 
-target_ulong helper_mftc0_ebase(CPUMIPSState *env)
+target_ulong HELPER(mftc0_ebase)(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1204,7 +1204,7 @@ target_ulong helper_mftc0_ebase(CPUMIPSState *env)
     return other->CP0_EBase;
 }
 
-void helper_mtc0_ebase(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_ebase)(CPUMIPSState *env, target_ulong arg1)
 {
     target_ulong mask = 0x3FFFF000 | env->CP0_EBaseWG_rw_bitmask;
     if (arg1 & env->CP0_EBaseWG_rw_bitmask) {
@@ -1213,7 +1213,7 @@ void helper_mtc0_ebase(CPUMIPSState *env, target_ulong arg1)
     env->CP0_EBase = (env->CP0_EBase & ~mask) | (arg1 & mask);
 }
 
-void helper_mttc0_ebase(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mttc0_ebase)(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1224,7 +1224,7 @@ void helper_mttc0_ebase(CPUMIPSState *env, target_ulong arg1)
     other->CP0_EBase = (other->CP0_EBase & ~mask) | (arg1 & mask);
 }
 
-target_ulong helper_mftc0_configx(CPUMIPSState *env, target_ulong idx)
+target_ulong HELPER(mftc0_configx)(CPUMIPSState *env, target_ulong idx)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1243,18 +1243,18 @@ target_ulong helper_mftc0_configx(CPUMIPSState *env, target_ulong idx)
     return 0;
 }
 
-void helper_mtc0_config0(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_config0)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_Config0 = (env->CP0_Config0 & 0x81FFFFF8) | (arg1 & 0x00000007);
 }
 
-void helper_mtc0_config2(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_config2)(CPUMIPSState *env, target_ulong arg1)
 {
     /* tertiary/secondary caches not implemented */
     env->CP0_Config2 = (env->CP0_Config2 & 0x8FFF0FFF);
 }
 
-void helper_mtc0_config3(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_config3)(CPUMIPSState *env, target_ulong arg1)
 {
     if (env->insn_flags & ASE_MICROMIPS) {
         env->CP0_Config3 = (env->CP0_Config3 & ~(1 << CP0C3_ISA_ON_EXC)) |
@@ -1262,13 +1262,13 @@ void helper_mtc0_config3(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void helper_mtc0_config4(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_config4)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_Config4 = (env->CP0_Config4 & (~env->CP0_Config4_rw_bitmask)) |
                        (arg1 & env->CP0_Config4_rw_bitmask);
 }
 
-void helper_mtc0_config5(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_config5)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_Config5 = (env->CP0_Config5 & (~env->CP0_Config5_rw_bitmask)) |
                        (arg1 & env->CP0_Config5_rw_bitmask);
@@ -1277,7 +1277,7 @@ void helper_mtc0_config5(CPUMIPSState *env, target_ulong arg1)
     compute_hflags(env);
 }
 
-void helper_mtc0_lladdr(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_lladdr)(CPUMIPSState *env, target_ulong arg1)
 {
     target_long mask = env->CP0_LLAddr_rw_bitmask;
     arg1 = arg1 << env->CP0_LLAddr_shift;
@@ -1287,19 +1287,19 @@ void helper_mtc0_lladdr(CPUMIPSState *env, target_ulong arg1)
 #define MTC0_MAAR_MASK(env) \
         ((0x1ULL << 63) | ((env->PAMask >> 4) & ~0xFFFull) | 0x3)
 
-void helper_mtc0_maar(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_maar)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_MAAR[env->CP0_MAARI] = arg1 & MTC0_MAAR_MASK(env);
 }
 
-void helper_mthc0_maar(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mthc0_maar)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_MAAR[env->CP0_MAARI] =
         (((uint64_t) arg1 << 32) & MTC0_MAAR_MASK(env)) |
         (env->CP0_MAAR[env->CP0_MAARI] & 0x00000000ffffffffULL);
 }
 
-void helper_mtc0_maari(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_maari)(CPUMIPSState *env, target_ulong arg1)
 {
     int index = arg1 & 0x3f;
     if (index == 0x3f) {
@@ -1317,7 +1317,7 @@ void helper_mtc0_maari(CPUMIPSState *env, target_ulong arg1)
      */
 }
 
-void helper_mtc0_watchlo(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
+void HELPER(mtc0_watchlo)(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 {
     /*
      * Watch exceptions for instructions, data loads, data stores
@@ -1326,7 +1326,7 @@ void helper_mtc0_watchlo(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
     env->CP0_WatchLo[sel] = (arg1 & ~0x7);
 }
 
-void helper_mtc0_watchhi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
+void HELPER(mtc0_watchhi)(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 {
     uint64_t mask = 0x40000FF8 | (env->CP0_EntryHi_ASID_mask << CP0WH_ASID);
     uint64_t m_bit = env->CP0_WatchHi[sel] & (1 << CP0WH_M); /* read-only */
@@ -1337,24 +1337,24 @@ void helper_mtc0_watchhi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
     env->CP0_WatchHi[sel] &= ~(env->CP0_WatchHi[sel] & arg1 & 0x7);
 }
 
-void helper_mthc0_watchhi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
+void HELPER(mthc0_watchhi)(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 {
     env->CP0_WatchHi[sel] = ((uint64_t) (arg1) << 32) |
                             (env->CP0_WatchHi[sel] & 0x00000000ffffffffULL);
 }
 
-void helper_mtc0_xcontext(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_xcontext)(CPUMIPSState *env, target_ulong arg1)
 {
     target_ulong mask = (1ULL << (env->SEGBITS - 7)) - 1;
     env->CP0_XContext = (env->CP0_XContext & mask) | (arg1 & ~mask);
 }
 
-void helper_mtc0_framemask(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_framemask)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_Framemask = arg1; /* XXX */
 }
 
-void helper_mtc0_debug(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_debug)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_Debug = (env->CP0_Debug & 0x8C03FC1F) | (arg1 & 0x13300120);
     if (arg1 & (1 << CP0DB_DM)) {
@@ -1364,7 +1364,7 @@ void helper_mtc0_debug(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void helper_mttc0_debug(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mttc0_debug)(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     uint32_t val = arg1 & ((1 << CP0DB_SSt) | (1 << CP0DB_Halt));
@@ -1381,12 +1381,12 @@ void helper_mttc0_debug(CPUMIPSState *env, target_ulong arg1)
                      (arg1 & ~((1 << CP0DB_SSt) | (1 << CP0DB_Halt)));
 }
 
-void helper_mtc0_performance0(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_performance0)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_Performance0 = arg1 & 0x000007ff;
 }
 
-void helper_mtc0_errctl(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_errctl)(CPUMIPSState *env, target_ulong arg1)
 {
     int32_t wst = arg1 & (1 << CP0EC_WST);
     int32_t spr = arg1 & (1 << CP0EC_SPR);
@@ -1401,7 +1401,7 @@ void helper_mtc0_errctl(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void helper_mtc0_taglo(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_taglo)(CPUMIPSState *env, target_ulong arg1)
 {
     if (env->hflags & MIPS_HFLAG_ITC_CACHE) {
         /*
@@ -1415,23 +1415,23 @@ void helper_mtc0_taglo(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void helper_mtc0_datalo(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_datalo)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_DataLo = arg1; /* XXX */
 }
 
-void helper_mtc0_taghi(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_taghi)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_TagHi = arg1; /* XXX */
 }
 
-void helper_mtc0_datahi(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mtc0_datahi)(CPUMIPSState *env, target_ulong arg1)
 {
     env->CP0_DataHi = arg1; /* XXX */
 }
 
 /* MIPS MT functions */
-target_ulong helper_mftgpr(CPUMIPSState *env, uint32_t sel)
+target_ulong HELPER(mftgpr)(CPUMIPSState *env, uint32_t sel)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1443,7 +1443,7 @@ target_ulong helper_mftgpr(CPUMIPSState *env, uint32_t sel)
     }
 }
 
-target_ulong helper_mftlo(CPUMIPSState *env, uint32_t sel)
+target_ulong HELPER(mftlo)(CPUMIPSState *env, uint32_t sel)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1455,7 +1455,7 @@ target_ulong helper_mftlo(CPUMIPSState *env, uint32_t sel)
     }
 }
 
-target_ulong helper_mfthi(CPUMIPSState *env, uint32_t sel)
+target_ulong HELPER(mfthi)(CPUMIPSState *env, uint32_t sel)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1467,7 +1467,7 @@ target_ulong helper_mfthi(CPUMIPSState *env, uint32_t sel)
     }
 }
 
-target_ulong helper_mftacx(CPUMIPSState *env, uint32_t sel)
+target_ulong HELPER(mftacx)(CPUMIPSState *env, uint32_t sel)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1479,7 +1479,7 @@ target_ulong helper_mftacx(CPUMIPSState *env, uint32_t sel)
     }
 }
 
-target_ulong helper_mftdsp(CPUMIPSState *env)
+target_ulong HELPER(mftdsp)(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1491,7 +1491,7 @@ target_ulong helper_mftdsp(CPUMIPSState *env)
     }
 }
 
-void helper_mttgpr(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
+void HELPER(mttgpr)(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1503,7 +1503,7 @@ void helper_mttgpr(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
     }
 }
 
-void helper_mttlo(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
+void HELPER(mttlo)(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1515,7 +1515,7 @@ void helper_mttlo(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
     }
 }
 
-void helper_mtthi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
+void HELPER(mtthi)(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1527,7 +1527,7 @@ void helper_mtthi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
     }
 }
 
-void helper_mttacx(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
+void HELPER(mttacx)(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1539,7 +1539,7 @@ void helper_mttacx(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
     }
 }
 
-void helper_mttdsp(CPUMIPSState *env, target_ulong arg1)
+void HELPER(mttdsp)(CPUMIPSState *env, target_ulong arg1)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
     CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
@@ -1552,19 +1552,19 @@ void helper_mttdsp(CPUMIPSState *env, target_ulong arg1)
 }
 
 /* MIPS MT functions */
-target_ulong helper_dmt(void)
+target_ulong HELPER(dmt)(void)
 {
     /* TODO */
     return 0;
 }
 
-target_ulong helper_emt(void)
+target_ulong HELPER(emt)(void)
 {
     /* TODO */
     return 0;
 }
 
-target_ulong helper_dvpe(CPUMIPSState *env)
+target_ulong HELPER(dvpe)(CPUMIPSState *env)
 {
     MIPSCPU *cpu = env_archcpu(env);
     target_ulong prev = cpu->mvp->CP0_MVPControl;
@@ -1584,7 +1584,7 @@ target_ulong helper_dvpe(CPUMIPSState *env)
     return prev;
 }
 
-target_ulong helper_evpe(CPUMIPSState *env)
+target_ulong HELPER(evpe)(CPUMIPSState *env)
 {
     MIPSCPU *cpu = env_archcpu(env);
     target_ulong prev = cpu->mvp->CP0_MVPControl;
@@ -1608,7 +1608,7 @@ target_ulong helper_evpe(CPUMIPSState *env)
 }
 
 /* R6 Multi-threading */
-target_ulong helper_dvp(CPUMIPSState *env)
+target_ulong HELPER(dvp)(CPUMIPSState *env)
 {
     target_ulong prev = env->CP0_VPControl;
 
@@ -1627,7 +1627,7 @@ target_ulong helper_dvp(CPUMIPSState *env)
     return prev;
 }
 
-target_ulong helper_evp(CPUMIPSState *env)
+target_ulong HELPER(evp)(CPUMIPSState *env)
 {
     target_ulong prev = env->CP0_VPControl;
 
diff --git a/target/mips/tcg/system/lcsr_helper.c b/target/mips/tcg/system/lcsr_helper.c
index 25e03572fe9..5d7e5cb5422 100644
--- a/target/mips/tcg/system/lcsr_helper.c
+++ b/target/mips/tcg/system/lcsr_helper.c
@@ -13,26 +13,26 @@
 #define GET_MEMTXATTRS(cas) \
         ((MemTxAttrs){.requester_id = env_cpu(cas)->cpu_index})
 
-uint64_t helper_lcsr_rdcsr(CPUMIPSState *env, target_ulong r_addr)
+uint64_t HELPER(lcsr_rdcsr)(CPUMIPSState *env, target_ulong r_addr)
 {
     return address_space_ldl(&env->iocsr.as, r_addr,
                              GET_MEMTXATTRS(env), NULL);
 }
 
-uint64_t helper_lcsr_drdcsr(CPUMIPSState *env, target_ulong r_addr)
+uint64_t HELPER(lcsr_drdcsr)(CPUMIPSState *env, target_ulong r_addr)
 {
     return address_space_ldq(&env->iocsr.as, r_addr,
                              GET_MEMTXATTRS(env), NULL);
 }
 
-void helper_lcsr_wrcsr(CPUMIPSState *env, target_ulong w_addr,
+void HELPER(lcsr_wrcsr)(CPUMIPSState *env, target_ulong w_addr,
                       target_ulong val)
 {
     address_space_stl(&env->iocsr.as, w_addr,
                       val, GET_MEMTXATTRS(env), NULL);
 }
 
-void helper_lcsr_dwrcsr(CPUMIPSState *env, target_ulong w_addr,
+void HELPER(lcsr_dwrcsr)(CPUMIPSState *env, target_ulong w_addr,
                       target_ulong val)
 {
     address_space_stq(&env->iocsr.as, w_addr,
diff --git a/target/mips/tcg/system/special_helper.c b/target/mips/tcg/system/special_helper.c
index b54cbe88a38..cc46542806e 100644
--- a/target/mips/tcg/system/special_helper.c
+++ b/target/mips/tcg/system/special_helper.c
@@ -26,7 +26,7 @@
 #include "internal.h"
 
 /* Specials */
-target_ulong helper_di(CPUMIPSState *env)
+target_ulong HELPER(di)(CPUMIPSState *env)
 {
     target_ulong t0 = env->CP0_Status;
 
@@ -34,7 +34,7 @@ target_ulong helper_di(CPUMIPSState *env)
     return t0;
 }
 
-target_ulong helper_ei(CPUMIPSState *env)
+target_ulong HELPER(ei)(CPUMIPSState *env)
 {
     target_ulong t0 = env->CP0_Status;
 
@@ -115,19 +115,19 @@ static inline void exception_return(CPUMIPSState *env)
     debug_post_eret(env);
 }
 
-void helper_eret(CPUMIPSState *env)
+void HELPER(eret)(CPUMIPSState *env)
 {
     exception_return(env);
     env->CP0_LLAddr = 1;
     env->lladdr = 1;
 }
 
-void helper_eretnc(CPUMIPSState *env)
+void HELPER(eretnc)(CPUMIPSState *env)
 {
     exception_return(env);
 }
 
-void helper_deret(CPUMIPSState *env)
+void HELPER(deret)(CPUMIPSState *env)
 {
     debug_pre_eret(env);
 
@@ -139,7 +139,7 @@ void helper_deret(CPUMIPSState *env)
     debug_post_eret(env);
 }
 
-void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
+void HELPER(cache)(CPUMIPSState *env, target_ulong addr, uint32_t op)
 {
     static const char *const type_name[] = {
         "Primary Instruction",
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 4398c6f80b4..0ff0c9c8717 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -273,32 +273,32 @@ static void r4k_helper_tlbr(CPUMIPSState *env)
     }
 }
 
-void helper_tlbwi(CPUMIPSState *env)
+void HELPER(tlbwi)(CPUMIPSState *env)
 {
     env->tlb->helper_tlbwi(env);
 }
 
-void helper_tlbwr(CPUMIPSState *env)
+void HELPER(tlbwr)(CPUMIPSState *env)
 {
     env->tlb->helper_tlbwr(env);
 }
 
-void helper_tlbp(CPUMIPSState *env)
+void HELPER(tlbp)(CPUMIPSState *env)
 {
     env->tlb->helper_tlbp(env);
 }
 
-void helper_tlbr(CPUMIPSState *env)
+void HELPER(tlbr)(CPUMIPSState *env)
 {
     env->tlb->helper_tlbr(env);
 }
 
-void helper_tlbinv(CPUMIPSState *env)
+void HELPER(tlbinv)(CPUMIPSState *env)
 {
     env->tlb->helper_tlbinv(env);
 }
 
-void helper_tlbinvf(CPUMIPSState *env)
+void HELPER(tlbinvf)(CPUMIPSState *env)
 {
     env->tlb->helper_tlbinvf(env);
 }
@@ -338,7 +338,7 @@ static void global_invalidate_tlb(CPUMIPSState *env,
     cpu_mips_tlb_flush(env);
 }
 
-void helper_ginvt(CPUMIPSState *env, target_ulong arg, uint32_t type)
+void HELPER(ginvt)(CPUMIPSState *env, target_ulong arg, uint32_t type)
 {
     bool invAll = type == 0;
     bool invVA = type == 1;
diff --git a/target/mips/tcg/vr54xx_helper.c b/target/mips/tcg/vr54xx_helper.c
index 2255bd11163..6c47fa7edb4 100644
--- a/target/mips/tcg/vr54xx_helper.c
+++ b/target/mips/tcg/vr54xx_helper.c
@@ -44,97 +44,97 @@ static inline target_ulong set_HI_LOT0(CPUMIPSState *env, uint64_t HILO)
 }
 
 /* Multiplication variants of the vr54xx. */
-target_ulong helper_muls(CPUMIPSState *env, target_ulong arg1,
-                         target_ulong arg2)
+target_ulong HELPER(muls)(CPUMIPSState *env, target_ulong arg1,
+                          target_ulong arg2)
 {
     return set_HI_LOT0(env, 0 - ((int64_t)(int32_t)arg1 *
                                  (int64_t)(int32_t)arg2));
 }
 
-target_ulong helper_mulsu(CPUMIPSState *env, target_ulong arg1,
+target_ulong HELPER(mulsu)(CPUMIPSState *env, target_ulong arg1,
                           target_ulong arg2)
 {
     return set_HI_LOT0(env, 0 - (uint64_t)(uint32_t)arg1 *
                                 (uint64_t)(uint32_t)arg2);
 }
 
-target_ulong helper_macc(CPUMIPSState *env, target_ulong arg1,
+target_ulong HELPER(macc)(CPUMIPSState *env, target_ulong arg1,
                          target_ulong arg2)
 {
     return set_HI_LOT0(env, (int64_t)get_HILO(env) + (int64_t)(int32_t)arg1 *
                                                      (int64_t)(int32_t)arg2);
 }
 
-target_ulong helper_macchi(CPUMIPSState *env, target_ulong arg1,
+target_ulong HELPER(macchi)(CPUMIPSState *env, target_ulong arg1,
                            target_ulong arg2)
 {
     return set_HIT0_LO(env, (int64_t)get_HILO(env) + (int64_t)(int32_t)arg1 *
                        (int64_t)(int32_t)arg2);
 }
 
-target_ulong helper_maccu(CPUMIPSState *env, target_ulong arg1,
+target_ulong HELPER(maccu)(CPUMIPSState *env, target_ulong arg1,
                           target_ulong arg2)
 {
     return set_HI_LOT0(env, (uint64_t)get_HILO(env) + (uint64_t)(uint32_t)arg1 *
                                                       (uint64_t)(uint32_t)arg2);
 }
 
-target_ulong helper_macchiu(CPUMIPSState *env, target_ulong arg1,
+target_ulong HELPER(macchiu)(CPUMIPSState *env, target_ulong arg1,
                             target_ulong arg2)
 {
     return set_HIT0_LO(env, (uint64_t)get_HILO(env) + (uint64_t)(uint32_t)arg1 *
                                                       (uint64_t)(uint32_t)arg2);
 }
 
-target_ulong helper_msac(CPUMIPSState *env, target_ulong arg1,
+target_ulong HELPER(msac)(CPUMIPSState *env, target_ulong arg1,
                          target_ulong arg2)
 {
     return set_HI_LOT0(env, (int64_t)get_HILO(env) - (int64_t)(int32_t)arg1 *
                                                      (int64_t)(int32_t)arg2);
 }
 
-target_ulong helper_msachi(CPUMIPSState *env, target_ulong arg1,
+target_ulong HELPER(msachi)(CPUMIPSState *env, target_ulong arg1,
                            target_ulong arg2)
 {
     return set_HIT0_LO(env, (int64_t)get_HILO(env) - (int64_t)(int32_t)arg1 *
                                                      (int64_t)(int32_t)arg2);
 }
 
-target_ulong helper_msacu(CPUMIPSState *env, target_ulong arg1,
+target_ulong HELPER(msacu)(CPUMIPSState *env, target_ulong arg1,
                           target_ulong arg2)
 {
     return set_HI_LOT0(env, (uint64_t)get_HILO(env) - (uint64_t)(uint32_t)arg1 *
                                                       (uint64_t)(uint32_t)arg2);
 }
 
-target_ulong helper_msachiu(CPUMIPSState *env, target_ulong arg1,
+target_ulong HELPER(msachiu)(CPUMIPSState *env, target_ulong arg1,
                             target_ulong arg2)
 {
     return set_HIT0_LO(env, (uint64_t)get_HILO(env) - (uint64_t)(uint32_t)arg1 *
                                                       (uint64_t)(uint32_t)arg2);
 }
 
-target_ulong helper_mulhi(CPUMIPSState *env, target_ulong arg1,
+target_ulong HELPER(mulhi)(CPUMIPSState *env, target_ulong arg1,
                           target_ulong arg2)
 {
     return set_HIT0_LO(env, (int64_t)(int32_t)arg1 * (int64_t)(int32_t)arg2);
 }
 
-target_ulong helper_mulhiu(CPUMIPSState *env, target_ulong arg1,
+target_ulong HELPER(mulhiu)(CPUMIPSState *env, target_ulong arg1,
                            target_ulong arg2)
 {
     return set_HIT0_LO(env, (uint64_t)(uint32_t)arg1 *
                             (uint64_t)(uint32_t)arg2);
 }
 
-target_ulong helper_mulshi(CPUMIPSState *env, target_ulong arg1,
+target_ulong HELPER(mulshi)(CPUMIPSState *env, target_ulong arg1,
                            target_ulong arg2)
 {
     return set_HIT0_LO(env, 0 - (int64_t)(int32_t)arg1 *
                                 (int64_t)(int32_t)arg2);
 }
 
-target_ulong helper_mulshiu(CPUMIPSState *env, target_ulong arg1,
+target_ulong HELPER(mulshiu)(CPUMIPSState *env, target_ulong arg1,
                             target_ulong arg2)
 {
     return set_HIT0_LO(env, 0 - (uint64_t)(uint32_t)arg1 *
-- 
2.43.0


