Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC41606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QNy+O04L;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dWagQM5T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunH-0001eS-GS; Mon, 19 Oct 2026 17:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunD-0001dM-P3
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunC-0005h0-26
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJJuRI2604726
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=irSmgaM/rsi
 PlEIkAridA2WskR48AC2QOOh7qcVX+Rw=; b=QNy+O04LlSmY5DPrLlZm+0CIsXt
 cMLtBi0UsWe/aWXHuP9hHBEogsodS472EN3obDy77yyaxVG99Zmn+ljN+VzVkypv
 l8cAx14Zzn5TueB90HaL+gch1mRb42y3S1u4s8F+LM/9+d1HHpWSN4QCLSkK6pr4
 6J9mzGNEnAp2Y4IitSjmlWwU//0YxEZLlX305i6JG+pMWEHoop+rlUFsZKTBDO3w
 hZOztGvZg7p7gFunGP0sebtvQf7S332S+0PCoPChFTkBgfzaQtcxLQznqWkufhyC
 ul72I3CZFIkUw3z+rRJHypGFAPBw765vIty4wMFPDZhhJ4L+BRu0tSUtxMA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4a0psj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ac0ae43900so2371291a91.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444872; x=1793049672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=irSmgaM/rsiPlEIkAridA2WskR48AC2QOOh7qcVX+Rw=;
 b=dWagQM5TxhV9PfYIRFaS+AOPHDv6/hNG81fG/1fd8+GTljOqK92AWEgn693Vlm9XRf
 wIAWdwvwJiM3oYcERSdcQxusnS6NHpdbJtgdX430WL9DBrjPjDkaVBcUMlNRET/n5tvf
 gcjXUnMU09eUWMFSN7TLAiiynQGsoa0o1z2yBZNJ7PiYmGV0OkdDXjicMa6wAy/8B2Kl
 P4b+xXrb4Vbp53PcmMUB5WmiZ4dXHGqubWWKEOukMY9WuW0ihNqOqMNiuE41YW1b4q7H
 u1yh5hRguP8EqwPY46JA9igoMZBTCga51t70HithBBYh8qq3PHSH0L8/BDQ73z9Kn/aW
 MmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444872; x=1793049672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=irSmgaM/rsiPlEIkAridA2WskR48AC2QOOh7qcVX+Rw=;
 b=06vFSMZ2LP+vYQIPKKF86/FgZKRn0gCMbhNZxXotH+e7PV41iGgcQT0WSrdYYTM5Lf
 zbUvRiQF4RqYLO7swLlkuLDNWhK7V3yKTPIVsiws/XQXxNctorjBrIbqqvvw+xQh3Oja
 OT8l4eQ8zP9LtCelMDyV4Jz4XM5y8SUrcQsyhWaob4dRL56ME4tzFnF+pdghQ2pvwsLd
 MXi2OsiNV6KdI77qvgavzDRa4u9Q3II/CKCx8pGyU0dTA92onSMhaX+o9cGB+Xw1yeDZ
 X9aoP4P7gWzCcM3ACOkzzcQZl8rJiU+/pkz7USZMZLW0riQ10DOwJx8ZENLgDDt+52vN
 hoaQ==
X-Gm-Message-State: AFq9FYKI72wwLwncg/ZpRFP7aengppx/bWXY641ME6ZuQT+DZGP557kI
 iMBMzkGbJ5ntChn3/AthIB+D2u8JwkHQt6rf+/Qev5e262i70D51oyxbUM+eYQPU8nm6+uUnv9h
 3mglANzrNIhlPiTJhePZNrU+JR42rCN7QyRihFg0rZ0mwKQlNtFmuopYTMTG5is0/IA==
X-Gm-Gg: AYBFou0ApdZpfLJG+koqvq9mP6GVZ3Jhe8l+7/euq7p/dfD4VVzkY25Zj/PYdaMD3ui
 qi02PkTYujnh/pjhDDzm754gtFMAvXOblYtIrB+xlg5k/ks0WfLchM0Zj3P6ByhwpIt4yYjkQPL
 G0eP4aDCEkn+IcJJl7Zo2kjdihehi/Uqcgx8Hq4z1b4EPut5R4jzImn4fGNLcuJXxE1euFLdU8X
 ghKLjGmp9aMpiJMy7Uje7SPPcNmXeiPX+pBb9XQ/HY/g3qpJIuGp66HUBAIIapKB3v6PVZM4umY
 N/0KPL7leQaSNasmv5hP7G2OCUJV0U1Ol82HZ0DFIxUcLt8TtE6OSehLf9ymHhyTMdjYCftU1st
 r2Jh3vK7SkUEyeE09X9Q04s/B3/EIovVA+HogFGnQKiirZ1VW/2BpAlQXVzLtFko=
X-Received: by 2002:a17:90b:164c:b0:3ac:9259:1234 with SMTP id
 98e67ed59e1d1-3aceefae3d2mr6717778a91.39.1792444872001; 
 Mon, 19 Oct 2026 14:21:12 -0700 (PDT)
X-Received: by 2002:a17:90b:164c:b0:3ac:9259:1234 with SMTP id
 98e67ed59e1d1-3aceefae3d2mr6717763a91.39.1792444871564; 
 Mon, 19 Oct 2026 14:21:11 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 10/26] target/or1k: define and call helpers using HELPER macro
Date: Mon, 19 Oct 2026 21:20:29 +0000
Message-ID: <20261019212046.149572-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX7+eu7DAIS5g9
 JHTdRYUXlpD3HEzc27rMkzKb1xPFoDz5KuSjoMoHUuf2RfGg4DWEcMFKBzKTLw6kA6vA+H29/gX
 QUSDrPm6ywJIN8UPuWAX326MOWXGoyo=
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6ad689c9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=2zBZdOuuqlq0y1Zj7RQA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: t3eviD__z5ts1OZs8K6LWgc0N_hRr0R1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXyFZFbIiqNidY
 derVjQg7amRlp7m51vJp7UKkPdeddKqW2VBrIQvT0JAtQ4Qq8yLuJ1ECANj/N+a93nuTYK3VafL
 Xo8bKar4v5XrfxBDiJtCPP+/zLOc42iTGZ78+8esPQ9P8pUe8SlJiHR3GjFyRIJKN4UgAlLak8W
 +HjlcmLwUvpYH98qU6lKRMi2i+DySVEa5jwNZOPtrk0S+9lcD5wh9RYgXKXut+y2l29xTLeHKh8
 LNpLvdbb94ELlzY5tuP8vRmhdfEKAxSbz3gbCxvcKLPqJAw3a03ypSyJc3P7c7mvVLAZ7P51PvA
 ZoECDYleai2NpQKEcpP/b3CUMM7lFQFuQfDRTVLICto61+gpzUy2L33h7JKK4UZK8nxpGCpYGFg
 ZZ9mQ4bUaQeUN0puNyEL+W7OhgXeUNdBjnP5qHRoNcu2SAVTcE4upxOzr/2yAYWeVNf0aBceo3E
 LcduiOVt94/rniv8U+w==
X-Proofpoint-GUID: t3eviD__z5ts1OZs8K6LWgc0N_hRr0R1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
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
 target/or1k/fpu_helper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/or1k/fpu_helper.c b/target/or1k/fpu_helper.c
index e680606d4da..3c2aff64e9a 100644
--- a/target/or1k/fpu_helper.c
+++ b/target/or1k/fpu_helper.c
@@ -114,10 +114,10 @@ uint32_t HELPER(dtos)(CPUOpenRISCState *env, uint64_t val)
 }
 
 #define FLOAT_CALC(name)                                                  \
-uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
+uint64_t HELPER(float_ ## name ## _d)(CPUOpenRISCState *env,              \
                                      uint64_t fdt0, uint64_t fdt1)        \
 { return float64_ ## name(fdt0, fdt1, &env->fp_status); }                 \
-uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
+uint32_t HELPER(float_ ## name ## _s)(CPUOpenRISCState *env,              \
                                      uint32_t fdt0, uint32_t fdt1)        \
 { return float32_ ## name(fdt0, fdt1, &env->fp_status); }
 
@@ -129,7 +129,7 @@ FLOAT_CALC(rem)
 #undef FLOAT_CALC
 
 
-uint64_t helper_float_madd_d(CPUOpenRISCState *env, uint64_t a,
+uint64_t HELPER(float_madd_d)(CPUOpenRISCState *env, uint64_t a,
                              uint64_t b, uint64_t c)
 {
     /* Note that or1ksim doesn't use fused operation.  */
@@ -137,7 +137,7 @@ uint64_t helper_float_madd_d(CPUOpenRISCState *env, uint64_t a,
     return float64_add(a, b, &env->fp_status);
 }
 
-uint32_t helper_float_madd_s(CPUOpenRISCState *env, uint32_t a,
+uint32_t HELPER(float_madd_s)(CPUOpenRISCState *env, uint32_t a,
                              uint32_t b, uint32_t c)
 {
     /* Note that or1ksim doesn't use fused operation.  */
@@ -147,10 +147,10 @@ uint32_t helper_float_madd_s(CPUOpenRISCState *env, uint32_t a,
 
 
 #define FLOAT_CMP(name, impl)                                             \
-uint32_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
+uint32_t HELPER(float_ ## name ## _d)(CPUOpenRISCState *env,              \
                                          uint64_t fdt0, uint64_t fdt1)    \
 { return float64_ ## impl(fdt0, fdt1, &env->fp_status); }                 \
-uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
+uint32_t HELPER(float_ ## name ## _s)(CPUOpenRISCState *env,              \
                                          uint32_t fdt0, uint32_t fdt1)    \
 { return float32_ ## impl(fdt0, fdt1, &env->fp_status); }
 
@@ -161,13 +161,13 @@ FLOAT_CMP(un, unordered_quiet)
 #undef FLOAT_CMP
 
 #define FLOAT_UCMP(name, expr) \
-uint32_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
+uint32_t HELPER(float_ ## name ## _d)(CPUOpenRISCState *env,              \
                                          uint64_t fdt0, uint64_t fdt1)    \
 {                                                                         \
     FloatRelation r = float64_compare_quiet(fdt0, fdt1, &env->fp_status); \
     return expr;                                                          \
 }                                                                         \
-uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
+uint32_t HELPER(float_ ## name ## _s)(CPUOpenRISCState *env,              \
                                          uint32_t fdt0, uint32_t fdt1)    \
 {                                                                         \
     FloatRelation r = float32_compare_quiet(fdt0, fdt1, &env->fp_status); \
-- 
2.43.0


