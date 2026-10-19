Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E95C606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RndSzoeg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BUjP1Plb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunU-0001hr-Qh; Mon, 19 Oct 2026 17:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunO-0001h8-Hh
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunK-0005i8-AT
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:26 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKFCQ550297
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=I9aDRFBN5Wq
 +Jmha+/5JzZjp72EOkMJu6DjbXxh190k=; b=RndSzoeg1rFufr5APRP7bGUkI1b
 vJJkFpbzx/9bhboOwk133yaCfCPxdqeggiJ2Rl1R6LQKlzPaVt0we/W8YgAoF6rF
 jIhbqrQmYkqwSuHoINSHptpoQIIyC7H1GdFXNMN8KwnIoGPp/7TMefYsymwLlL+q
 ZTJJsSNxcX7xplJBXk3H07EWbjd3uh5TGlTpn6zwNr0VVduiJImZlD5raGlM8OX1
 HDFBmvymm1zEAE2ihJXt+PrkPPTKY9o+LOr8Z+plPQ4CNU7ET3opMM4xlNuK7eiI
 eMubmDBH36OcKYhhUmjpjyuoiGlrB7CRGDPpMar+yV0PcsXg99Q2Wim5csg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47kc5f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ad53f538d2so613543a91.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444880; x=1793049680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I9aDRFBN5Wq+Jmha+/5JzZjp72EOkMJu6DjbXxh190k=;
 b=BUjP1PlbfP/eRmqVb3zSixciQ1gdtSCaf3fo1F35hcewxN1XhQmZ73hVxaq0TGtnct
 Oeku6E2xDrV1nHuvH9SqxNrPwu5iHVHhMoI2ZbIwWa7ipQ1wjNdIqhbhr543usxH+nyp
 eX+DzJ2apVdz0T8fDY2YaLkh9iwodeGyjN5jFw19NrYQLWlb85WZAM/klE9p3FLovnbW
 UkzPaghXBWTYLbi/OrN6y7DZoG4Br55g0xLKog31TTKJ4ne51D0Zi4rwaKPC0vsFqlNH
 9nvAFWGUXpAteESO9dHf5KtUXifF1Su9Yk3A9kpVXQMXBmPGFf62HrRoj5H2sC3jPiH8
 LN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444880; x=1793049680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I9aDRFBN5Wq+Jmha+/5JzZjp72EOkMJu6DjbXxh190k=;
 b=HfeqiLZSqE6G3PFXLqB7hj43Y/6pqx4GxoUlq+xNJVU8AidYDFxyBORMW/+m/qbi6P
 2Ay8bfTVI9QoHaKZeEMT5diDumNM+Leul54d5xFodw+cAlRoPDQK2S7iWncT/DZ5n5OT
 51Zue17OkXhUVzqazWJQaQsXKOjBrNQa06sm0QPlYw1kzKToezlAp3kEx2J9EueqNUyG
 uay5dssmvci7JOBzmvhdmalcJUEncbQScbyMExw0km5+YwJPQq/BQxxadXdbrfzocDnB
 1QIcbrbroAKyf/XUKy+FSy3Dc5IATKIJR1fHRpmIdJolpRLfvVVhF6MNBrO3S6tqfr2o
 nCVQ==
X-Gm-Message-State: AFq9FYJbZRpEa8OID2uNBJImSX1xjwI7OE0FnH7xcCEiNjLJuuKJNuul
 EXvG52ctdx/SH7WLOlsWLgj5+zjsS9twpO+pTr0G5KhwjNcd6AppE7PqJNBExYU98exHNrBrEf5
 A+aUPt1E84iVxN2zu3sVBHXbg+LsVd2v8Wh3v6byIklDIFoRolMsP/tzSSYPKZ2dBPw==
X-Gm-Gg: AYBFou1jOaebqpz/Wow6ZtohnC9H9zB06lQTcvdDoHYXcUB4+iCp879FwOwNk1mHt1/
 G5SpqxrXtOUW5g/CvLze8bcEL0ZmIadORfOfqDKIA5oVbYMj7SB/ib1+KNuzr48/RXguHCm1Ovf
 TEN5fOgVmb/mFHEoUNSxTxvKd5HbNPtBSbSbhvGEsLRwgUNP3lT+K80mZ+P/ml+y+fP67UWU241
 08zMH2maS3QwJ0+gfmUojIlLe2XpT26etQ9GLS70xFT86G570F3b/b+nVHbZX463wryNbYlvKca
 5A6J2SZLN24hjj4IBGZYVNQ9v4j7uJV6MzoFkVPu22QVDirnJ7ShHRM5mUJh91S26+3+a686G7v
 zuKRPFjaal2SnphitwjbeK8rfIvWZC7kVll6QgxqRGU6mmikQSuE2QiUb12gDGCQ=
X-Received: by 2002:a17:90b:4c8c:b0:3a7:ecab:c4c7 with SMTP id
 98e67ed59e1d1-3acef1486bemr8436905a91.34.1792444879688; 
 Mon, 19 Oct 2026 14:21:19 -0700 (PDT)
X-Received: by 2002:a17:90b:4c8c:b0:3a7:ecab:c4c7 with SMTP id
 98e67ed59e1d1-3acef1486bemr8436857a91.34.1792444878232; 
 Mon, 19 Oct 2026 14:21:18 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 16/26] target/sparc: define and call helpers using HELPER macro
Date: Mon, 19 Oct 2026 21:20:35 +0000
Message-ID: <20261019212046.149572-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aBJ8hoRM-LN7wEKZlIARat7MKjlMV_z9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX8wr5x3NNT+bg
 rFZUWNUyApOUgdbXzupv8IKLErTglMIwN3Yih4Nzj2RAQYlHXKhUEcFh2VHyRzVTe/0HfKOHBce
 z9OfUvKANqDQXVvwTkA2lwaTQNjtiy1Pfy5ecFLGEeMZBTwSaIld8tYRnNXhDzpxIWtNMwBcWHX
 dlzexinPieO0obyvYDrb6FHcy6n1RNH9dCfWk6KF+xQxRtnD/xgxlPJkMsbFRWzwqrjekXt0rjR
 qaXsEvVbSxJJzP6DJF4QAkbGXtg5N2D+rAyGN1kJC239XeB/v5UI64YSCCWps5SRV5ivLXuOgva
 TCyVG/TvFSA9Q9Qm4GnZuwGBk6JMwPw0wSODCLmzaesGvw2UnOHk17L169QyI8jqvYdv3wYwu4/
 kw9BvD43Ld2s1tVRwoUky4LfpINVRKdDnyMrJsxrMDkMYxTnefGt1Xtm9vL/ISdKq4ZE2AIrTdD
 Xwn+JJlJIqRATlh48dg==
X-Proofpoint-GUID: aBJ8hoRM-LN7wEKZlIARat7MKjlMV_z9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX1VrV1T5ShFZI
 Wefy4EgntMiYj2uUL1bRjpfa+wAAnbCIepMQp/hxJhCfrqZSi6xo06U1B8kFhwI9ehGKuPJ7lLt
 rZBtTT177gdK1yMk1/o20wA+3deu4Dc=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad689d0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=kCVwYyrU2TdIIrcQhIEA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
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

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/sparc/fop_helper.c   | 106 ++++++++++++++++++------------------
 target/sparc/helper.c       |  22 ++++----
 target/sparc/int64_helper.c |   6 +-
 target/sparc/ldst_helper.c  |  14 ++---
 target/sparc/vis_helper.c   |  94 ++++++++++++++++----------------
 target/sparc/win_helper.c   |  38 ++++++-------
 6 files changed, 140 insertions(+), 140 deletions(-)

diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 29fd1664384..90aa93f24dc 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -84,91 +84,91 @@ static void check_ieee_exceptions(CPUSPARCState *env, uintptr_t ra)
     env->fsr_cexc_ftt = cexc;
 }
 
-float32 helper_fadds(CPUSPARCState *env, float32 src1, float32 src2)
+float32 HELPER(fadds)(CPUSPARCState *env, float32 src1, float32 src2)
 {
     float32 ret = float32_add(src1, src2, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-float32 helper_fsubs(CPUSPARCState *env, float32 src1, float32 src2)
+float32 HELPER(fsubs)(CPUSPARCState *env, float32 src1, float32 src2)
 {
     float32 ret = float32_sub(src1, src2, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-float32 helper_fmuls(CPUSPARCState *env, float32 src1, float32 src2)
+float32 HELPER(fmuls)(CPUSPARCState *env, float32 src1, float32 src2)
 {
     float32 ret = float32_mul(src1, src2, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-float32 helper_fdivs(CPUSPARCState *env, float32 src1, float32 src2)
+float32 HELPER(fdivs)(CPUSPARCState *env, float32 src1, float32 src2)
 {
     float32 ret = float32_div(src1, src2, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-float64 helper_faddd(CPUSPARCState *env, float64 src1, float64 src2)
+float64 HELPER(faddd)(CPUSPARCState *env, float64 src1, float64 src2)
 {
     float64 ret = float64_add(src1, src2, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-float64 helper_fsubd(CPUSPARCState *env, float64 src1, float64 src2)
+float64 HELPER(fsubd)(CPUSPARCState *env, float64 src1, float64 src2)
 {
     float64 ret = float64_sub(src1, src2, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-float64 helper_fmuld(CPUSPARCState *env, float64 src1, float64 src2)
+float64 HELPER(fmuld)(CPUSPARCState *env, float64 src1, float64 src2)
 {
     float64 ret = float64_mul(src1, src2, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-float64 helper_fdivd(CPUSPARCState *env, float64 src1, float64 src2)
+float64 HELPER(fdivd)(CPUSPARCState *env, float64 src1, float64 src2)
 {
     float64 ret = float64_div(src1, src2, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-Int128 helper_faddq(CPUSPARCState *env, Int128 src1, Int128 src2)
+Int128 HELPER(faddq)(CPUSPARCState *env, Int128 src1, Int128 src2)
 {
     float128 ret = float128_add(f128_in(src1), f128_in(src2), &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return f128_ret(ret);
 }
 
-Int128 helper_fsubq(CPUSPARCState *env, Int128 src1, Int128 src2)
+Int128 HELPER(fsubq)(CPUSPARCState *env, Int128 src1, Int128 src2)
 {
     float128 ret = float128_sub(f128_in(src1), f128_in(src2), &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return f128_ret(ret);
 }
 
-Int128 helper_fmulq(CPUSPARCState *env, Int128 src1, Int128 src2)
+Int128 HELPER(fmulq)(CPUSPARCState *env, Int128 src1, Int128 src2)
 {
     float128 ret = float128_mul(f128_in(src1), f128_in(src2), &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return f128_ret(ret);
 }
 
-Int128 helper_fdivq(CPUSPARCState *env, Int128 src1, Int128 src2)
+Int128 HELPER(fdivq)(CPUSPARCState *env, Int128 src1, Int128 src2)
 {
     float128 ret = float128_div(f128_in(src1), f128_in(src2), &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return f128_ret(ret);
 }
 
-float64 helper_fsmuld(CPUSPARCState *env, float32 src1, float32 src2)
+float64 HELPER(fsmuld)(CPUSPARCState *env, float32 src1, float32 src2)
 {
     float64 ret = float64_mul(float32_to_float64(src1, &env->fp_status),
                               float32_to_float64(src2, &env->fp_status),
@@ -177,7 +177,7 @@ float64 helper_fsmuld(CPUSPARCState *env, float32 src1, float32 src2)
     return ret;
 }
 
-Int128 helper_fdmulq(CPUSPARCState *env, float64 src1, float64 src2)
+Int128 HELPER(fdmulq)(CPUSPARCState *env, float64 src1, float64 src2)
 {
     float128 ret = float128_mul(float64_to_float128(src1, &env->fp_status),
                                 float64_to_float128(src2, &env->fp_status),
@@ -187,21 +187,21 @@ Int128 helper_fdmulq(CPUSPARCState *env, float64 src1, float64 src2)
 }
 
 /* Integer to float conversion.  */
-float32 helper_fitos(CPUSPARCState *env, int32_t src)
+float32 HELPER(fitos)(CPUSPARCState *env, int32_t src)
 {
     float32 ret = int32_to_float32(src, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-float64 helper_fitod(CPUSPARCState *env, int32_t src)
+float64 HELPER(fitod)(CPUSPARCState *env, int32_t src)
 {
     float64 ret = int32_to_float64(src, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-Int128 helper_fitoq(CPUSPARCState *env, int32_t src)
+Int128 HELPER(fitoq)(CPUSPARCState *env, int32_t src)
 {
     float128 ret = int32_to_float128(src, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
@@ -209,21 +209,21 @@ Int128 helper_fitoq(CPUSPARCState *env, int32_t src)
 }
 
 #ifdef TARGET_SPARC64
-float32 helper_fxtos(CPUSPARCState *env, int64_t src)
+float32 HELPER(fxtos)(CPUSPARCState *env, int64_t src)
 {
     float32 ret = int64_to_float32(src, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-float64 helper_fxtod(CPUSPARCState *env, int64_t src)
+float64 HELPER(fxtod)(CPUSPARCState *env, int64_t src)
 {
     float64 ret = int64_to_float64(src, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-Int128 helper_fxtoq(CPUSPARCState *env, int64_t src)
+Int128 HELPER(fxtoq)(CPUSPARCState *env, int64_t src)
 {
     float128 ret = int64_to_float128(src, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
@@ -232,42 +232,42 @@ Int128 helper_fxtoq(CPUSPARCState *env, int64_t src)
 #endif
 
 /* floating point conversion */
-float32 helper_fdtos(CPUSPARCState *env, float64 src)
+float32 HELPER(fdtos)(CPUSPARCState *env, float64 src)
 {
     float32 ret = float64_to_float32(src, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-float64 helper_fstod(CPUSPARCState *env, float32 src)
+float64 HELPER(fstod)(CPUSPARCState *env, float32 src)
 {
     float64 ret = float32_to_float64(src, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-float32 helper_fqtos(CPUSPARCState *env, Int128 src)
+float32 HELPER(fqtos)(CPUSPARCState *env, Int128 src)
 {
     float32 ret = float128_to_float32(f128_in(src), &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-Int128 helper_fstoq(CPUSPARCState *env, float32 src)
+Int128 HELPER(fstoq)(CPUSPARCState *env, float32 src)
 {
     float128 ret = float32_to_float128(src, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return f128_ret(ret);
 }
 
-float64 helper_fqtod(CPUSPARCState *env, Int128 src)
+float64 HELPER(fqtod)(CPUSPARCState *env, Int128 src)
 {
     float64 ret = float128_to_float64(f128_in(src), &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-Int128 helper_fdtoq(CPUSPARCState *env, float64 src)
+Int128 HELPER(fdtoq)(CPUSPARCState *env, float64 src)
 {
     float128 ret = float64_to_float128(src, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
@@ -275,21 +275,21 @@ Int128 helper_fdtoq(CPUSPARCState *env, float64 src)
 }
 
 /* Float to integer conversion.  */
-int32_t helper_fstoi(CPUSPARCState *env, float32 src)
+int32_t HELPER(fstoi)(CPUSPARCState *env, float32 src)
 {
     int32_t ret = float32_to_int32_round_to_zero(src, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-int32_t helper_fdtoi(CPUSPARCState *env, float64 src)
+int32_t HELPER(fdtoi)(CPUSPARCState *env, float64 src)
 {
     int32_t ret = float64_to_int32_round_to_zero(src, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-int32_t helper_fqtoi(CPUSPARCState *env, Int128 src)
+int32_t HELPER(fqtoi)(CPUSPARCState *env, Int128 src)
 {
     int32_t ret = float128_to_int32_round_to_zero(f128_in(src),
                                                   &env->fp_status);
@@ -298,21 +298,21 @@ int32_t helper_fqtoi(CPUSPARCState *env, Int128 src)
 }
 
 #ifdef TARGET_SPARC64
-int64_t helper_fstox(CPUSPARCState *env, float32 src)
+int64_t HELPER(fstox)(CPUSPARCState *env, float32 src)
 {
     int64_t ret = float32_to_int64_round_to_zero(src, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-int64_t helper_fdtox(CPUSPARCState *env, float64 src)
+int64_t HELPER(fdtox)(CPUSPARCState *env, float64 src)
 {
     int64_t ret = float64_to_int64_round_to_zero(src, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-int64_t helper_fqtox(CPUSPARCState *env, Int128 src)
+int64_t HELPER(fqtox)(CPUSPARCState *env, Int128 src)
 {
     int64_t ret = float128_to_int64_round_to_zero(f128_in(src),
                                                   &env->fp_status);
@@ -321,28 +321,28 @@ int64_t helper_fqtox(CPUSPARCState *env, Int128 src)
 }
 #endif
 
-float32 helper_fsqrts(CPUSPARCState *env, float32 src)
+float32 HELPER(fsqrts)(CPUSPARCState *env, float32 src)
 {
     float32 ret = float32_sqrt(src, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-float64 helper_fsqrtd(CPUSPARCState *env, float64 src)
+float64 HELPER(fsqrtd)(CPUSPARCState *env, float64 src)
 {
     float64 ret = float64_sqrt(src, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
-Int128 helper_fsqrtq(CPUSPARCState *env, Int128 src)
+Int128 HELPER(fsqrtq)(CPUSPARCState *env, Int128 src)
 {
     float128 ret = float128_sqrt(f128_in(src), &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return f128_ret(ret);
 }
 
-float32 helper_fmadds(CPUSPARCState *env, float32 s1,
+float32 HELPER(fmadds)(CPUSPARCState *env, float32 s1,
                       float32 s2, float32 s3, int32_t sc, uint32_t op)
 {
     float32 ret = float32_muladd_scalbn(s1, s2, s3, sc, op, &env->fp_status);
@@ -350,7 +350,7 @@ float32 helper_fmadds(CPUSPARCState *env, float32 s1,
     return ret;
 }
 
-float64 helper_fmaddd(CPUSPARCState *env, float64 s1,
+float64 HELPER(fmaddd)(CPUSPARCState *env, float64 s1,
                       float64 s2, float64 s3, int32_t sc, uint32_t op)
 {
     float64 ret = float64_muladd_scalbn(s1, s2, s3, sc, op, &env->fp_status);
@@ -358,7 +358,7 @@ float64 helper_fmaddd(CPUSPARCState *env, float64 s1,
     return ret;
 }
 
-float32 helper_fnadds(CPUSPARCState *env, float32 src1, float32 src2)
+float32 HELPER(fnadds)(CPUSPARCState *env, float32 src1, float32 src2)
 {
     float32 ret = float32_add(src1, src2, &env->fp_status);
 
@@ -373,7 +373,7 @@ float32 helper_fnadds(CPUSPARCState *env, float32 src1, float32 src2)
     return ret;
 }
 
-float32 helper_fnmuls(CPUSPARCState *env, float32 src1, float32 src2)
+float32 HELPER(fnmuls)(CPUSPARCState *env, float32 src1, float32 src2)
 {
     float32 ret = float32_mul(src1, src2, &env->fp_status);
 
@@ -385,7 +385,7 @@ float32 helper_fnmuls(CPUSPARCState *env, float32 src1, float32 src2)
     return ret;
 }
 
-float64 helper_fnaddd(CPUSPARCState *env, float64 src1, float64 src2)
+float64 HELPER(fnaddd)(CPUSPARCState *env, float64 src1, float64 src2)
 {
     float64 ret = float64_add(src1, src2, &env->fp_status);
 
@@ -400,7 +400,7 @@ float64 helper_fnaddd(CPUSPARCState *env, float64 src1, float64 src2)
     return ret;
 }
 
-float64 helper_fnmuld(CPUSPARCState *env, float64 src1, float64 src2)
+float64 HELPER(fnmuld)(CPUSPARCState *env, float64 src1, float64 src2)
 {
     float64 ret = float64_mul(src1, src2, &env->fp_status);
 
@@ -412,7 +412,7 @@ float64 helper_fnmuld(CPUSPARCState *env, float64 src1, float64 src2)
     return ret;
 }
 
-float64 helper_fnsmuld(CPUSPARCState *env, float32 src1, float32 src2)
+float64 HELPER(fnsmuld)(CPUSPARCState *env, float32 src1, float32 src2)
 {
     float64 ret = float64_mul(float32_to_float64(src1, &env->fp_status),
                               float32_to_float64(src2, &env->fp_status),
@@ -450,45 +450,45 @@ static uint32_t finish_fcmp(CPUSPARCState *env, FloatRelation r, uintptr_t ra)
     g_assert_not_reached();
 }
 
-uint32_t helper_fcmps(CPUSPARCState *env, float32 src1, float32 src2)
+uint32_t HELPER(fcmps)(CPUSPARCState *env, float32 src1, float32 src2)
 {
     FloatRelation r = float32_compare_quiet(src1, src2, &env->fp_status);
     return finish_fcmp(env, r, GETPC());
 }
 
-uint32_t helper_fcmpes(CPUSPARCState *env, float32 src1, float32 src2)
+uint32_t HELPER(fcmpes)(CPUSPARCState *env, float32 src1, float32 src2)
 {
     FloatRelation r = float32_compare(src1, src2, &env->fp_status);
     return finish_fcmp(env, r, GETPC());
 }
 
-uint32_t helper_fcmpd(CPUSPARCState *env, float64 src1, float64 src2)
+uint32_t HELPER(fcmpd)(CPUSPARCState *env, float64 src1, float64 src2)
 {
     FloatRelation r = float64_compare_quiet(src1, src2, &env->fp_status);
     return finish_fcmp(env, r, GETPC());
 }
 
-uint32_t helper_fcmped(CPUSPARCState *env, float64 src1, float64 src2)
+uint32_t HELPER(fcmped)(CPUSPARCState *env, float64 src1, float64 src2)
 {
     FloatRelation r = float64_compare(src1, src2, &env->fp_status);
     return finish_fcmp(env, r, GETPC());
 }
 
-uint32_t helper_fcmpq(CPUSPARCState *env, Int128 src1, Int128 src2)
+uint32_t HELPER(fcmpq)(CPUSPARCState *env, Int128 src1, Int128 src2)
 {
     FloatRelation r = float128_compare_quiet(f128_in(src1), f128_in(src2),
                                              &env->fp_status);
     return finish_fcmp(env, r, GETPC());
 }
 
-uint32_t helper_fcmpeq(CPUSPARCState *env, Int128 src1, Int128 src2)
+uint32_t HELPER(fcmpeq)(CPUSPARCState *env, Int128 src1, Int128 src2)
 {
     FloatRelation r = float128_compare(f128_in(src1), f128_in(src2),
                                        &env->fp_status);
     return finish_fcmp(env, r, GETPC());
 }
 
-uint32_t helper_flcmps(CPUSPARCState *env, float32 src1, float32 src2)
+uint32_t HELPER(flcmps)(CPUSPARCState *env, float32 src1, float32 src2)
 {
     /*
      * FLCMP never raises an exception nor modifies any FSR fields.
@@ -516,7 +516,7 @@ uint32_t helper_flcmps(CPUSPARCState *env, float32 src1, float32 src2)
     g_assert_not_reached();
 }
 
-uint32_t helper_flcmpd(CPUSPARCState *env, float64 src1, float64 src2)
+uint32_t HELPER(flcmpd)(CPUSPARCState *env, float64 src1, float64 src2)
 {
     float_status discard = env->fp_status;
     FloatRelation r;
@@ -559,7 +559,7 @@ target_ulong cpu_get_fsr(CPUSPARCState *env)
     return fsr;
 }
 
-target_ulong helper_get_fsr(CPUSPARCState *env)
+target_ulong HELPER(get_fsr)(CPUSPARCState *env)
 {
     return cpu_get_fsr(env);
 }
@@ -604,14 +604,14 @@ void cpu_put_fsr(CPUSPARCState *env, target_ulong fsr)
     set_fsr_nonsplit(env, fsr);
 }
 
-void helper_set_fsr_nofcc_noftt(CPUSPARCState *env, uint32_t fsr)
+void HELPER(set_fsr_nofcc_noftt)(CPUSPARCState *env, uint32_t fsr)
 {
     env->fsr_cexc_ftt &= FSR_FTT_MASK;
     env->fsr_cexc_ftt |= fsr & FSR_CEXC_MASK;
     set_fsr_nonsplit(env, fsr);
 }
 
-void helper_set_fsr_nofcc(CPUSPARCState *env, uint32_t fsr)
+void HELPER(set_fsr_nofcc)(CPUSPARCState *env, uint32_t fsr)
 {
     env->fsr_cexc_ftt = fsr & (FSR_CEXC_MASK | FSR_FTT_MASK);
     set_fsr_nonsplit(env, fsr);
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 8de261b0e30..f4eb78c4487 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -33,7 +33,7 @@ void cpu_raise_exception_ra(CPUSPARCState *env, int tt, uintptr_t ra)
     cpu_loop_exit_restore(cs, ra);
 }
 
-void helper_raise_exception(CPUSPARCState *env, int tt)
+void HELPER(raise_exception)(CPUSPARCState *env, int tt)
 {
     CPUState *cs = env_cpu(env);
 
@@ -41,7 +41,7 @@ void helper_raise_exception(CPUSPARCState *env, int tt)
     cpu_loop_exit(cs);
 }
 
-void helper_debug(CPUSPARCState *env)
+void HELPER(debug)(CPUSPARCState *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -50,14 +50,14 @@ void helper_debug(CPUSPARCState *env)
 }
 
 #ifdef TARGET_SPARC64
-void helper_tick_set_count(void *opaque, uint64_t count)
+void HELPER(tick_set_count)(void *opaque, uint64_t count)
 {
 #if !defined(CONFIG_USER_ONLY)
     cpu_tick_set_count(opaque, count);
 #endif
 }
 
-uint64_t helper_tick_get_count(CPUSPARCState *env, void *opaque, int mem_idx)
+uint64_t HELPER(tick_get_count)(CPUSPARCState *env, void *opaque, int mem_idx)
 {
 #if !defined(CONFIG_USER_ONLY)
     CPUTimer *timer = opaque;
@@ -74,7 +74,7 @@ uint64_t helper_tick_get_count(CPUSPARCState *env, void *opaque, int mem_idx)
 #endif
 }
 
-void helper_tick_set_limit(void *opaque, uint64_t limit)
+void HELPER(tick_set_limit)(void *opaque, uint64_t limit)
 {
 #if !defined(CONFIG_USER_ONLY)
     cpu_tick_set_limit(opaque, limit);
@@ -82,7 +82,7 @@ void helper_tick_set_limit(void *opaque, uint64_t limit)
 }
 #endif
 
-uint64_t helper_udiv(CPUSPARCState *env, target_ulong a, target_ulong b)
+uint64_t HELPER(udiv)(CPUSPARCState *env, target_ulong a, target_ulong b)
 {
     uint64_t a64 = (uint32_t)a | ((uint64_t)env->y << 32);
     uint32_t b32 = b;
@@ -100,7 +100,7 @@ uint64_t helper_udiv(CPUSPARCState *env, target_ulong a, target_ulong b)
     return r;
 }
 
-uint64_t helper_sdiv(CPUSPARCState *env, target_ulong a, target_ulong b)
+uint64_t HELPER(sdiv)(CPUSPARCState *env, target_ulong a, target_ulong b)
 {
     int64_t a64 = (uint32_t)a | ((uint64_t)env->y << 32);
     int32_t b32 = b;
@@ -130,7 +130,7 @@ uint64_t helper_sdiv(CPUSPARCState *env, target_ulong a, target_ulong b)
     return (uint32_t)r;
 }
 
-target_ulong helper_taddcctv(CPUSPARCState *env, target_ulong src1,
+target_ulong HELPER(taddcctv)(CPUSPARCState *env, target_ulong src1,
                              target_ulong src2)
 {
     target_ulong dst, v;
@@ -166,7 +166,7 @@ target_ulong helper_taddcctv(CPUSPARCState *env, target_ulong src1,
     cpu_raise_exception_ra(env, TT_TOVF, GETPC());
 }
 
-target_ulong helper_tsubcctv(CPUSPARCState *env, target_ulong src1,
+target_ulong HELPER(tsubcctv)(CPUSPARCState *env, target_ulong src1,
                              target_ulong src2)
 {
     target_ulong dst, v;
@@ -203,7 +203,7 @@ target_ulong helper_tsubcctv(CPUSPARCState *env, target_ulong src1,
 }
 
 #ifndef TARGET_SPARC64
-void helper_power_down(CPUSPARCState *env)
+void HELPER(power_down)(CPUSPARCState *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -214,7 +214,7 @@ void helper_power_down(CPUSPARCState *env)
     cpu_loop_exit(cs);
 }
 
-target_ulong helper_rdasr17(CPUSPARCState *env)
+target_ulong HELPER(rdasr17)(CPUSPARCState *env)
 {
     CPUState *cs = env_cpu(env);
     target_ulong val;
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 60ab0478fc6..5290738568b 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -289,21 +289,21 @@ static bool do_modify_softint(CPUSPARCState *env, uint32_t value)
     return false;
 }
 
-void helper_set_softint(CPUSPARCState *env, uint64_t value)
+void HELPER(set_softint)(CPUSPARCState *env, uint64_t value)
 {
     if (do_modify_softint(env, env->softint | (uint32_t)value)) {
         trace_int_helper_set_softint(env->softint);
     }
 }
 
-void helper_clear_softint(CPUSPARCState *env, uint64_t value)
+void HELPER(clear_softint)(CPUSPARCState *env, uint64_t value)
 {
     if (do_modify_softint(env, env->softint & (uint32_t)~value)) {
         trace_int_helper_clear_softint(env->softint);
     }
 }
 
-void helper_write_softint(CPUSPARCState *env, uint64_t value)
+void HELPER(write_softint)(CPUSPARCState *env, uint64_t value)
 {
     if (do_modify_softint(env, (uint32_t)value)) {
         trace_int_helper_write_softint(env->softint);
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 4ec8799d1f7..74d9cc1c966 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -580,7 +580,7 @@ static uint64_t leon3_cache_control_ld(CPUSPARCState *env, target_ulong addr,
     return ret;
 }
 
-uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
+uint64_t HELPER(ld_asi)(CPUSPARCState *env, target_ulong addr,
                        int asi, uint32_t memop)
 {
     int size = 1 << (memop & MO_SIZE);
@@ -804,7 +804,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     return ret;
 }
 
-void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
+void HELPER(st_asi)(CPUSPARCState *env, target_ulong addr, uint64_t val,
                    int asi, uint32_t memop)
 {
     int size = 1 << (memop & MO_SIZE);
@@ -1154,7 +1154,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
 #endif
 }
 
-uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi)
+uint64_t HELPER(ld_code)(CPUSPARCState *env, target_ulong addr, uint32_t oi)
 {
     MemOp mop = get_memop(oi);
     uintptr_t ra = GETPC();
@@ -1192,7 +1192,7 @@ uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi)
 #else /* TARGET_SPARC64 */
 
 #ifdef CONFIG_USER_ONLY
-uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
+uint64_t HELPER(ld_asi)(CPUSPARCState *env, target_ulong addr,
                        int asi, uint32_t memop)
 {
     int size = 1 << (memop & MO_SIZE);
@@ -1281,7 +1281,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     return ret;
 }
 
-void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
+void HELPER(st_asi)(CPUSPARCState *env, target_ulong addr, target_ulong val,
                    int asi, uint32_t memop)
 {
     int size = 1 << (memop & MO_SIZE);
@@ -1312,7 +1312,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
 
 #else /* CONFIG_USER_ONLY */
 
-uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
+uint64_t HELPER(ld_asi)(CPUSPARCState *env, target_ulong addr,
                        int asi, uint32_t memop)
 {
     int size = 1 << (memop & MO_SIZE);
@@ -1611,7 +1611,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     return ret;
 }
 
-void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
+void HELPER(st_asi)(CPUSPARCState *env, target_ulong addr, target_ulong val,
                    int asi, uint32_t memop)
 {
     int size = 1 << (memop & MO_SIZE);
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 371f5445a1f..f79e770124a 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -22,7 +22,7 @@
 #include "exec/helper-proto.h"
 #include "crypto/clmul.h"
 
-target_ulong helper_array8(target_ulong rs1, target_ulong rs2)
+target_ulong HELPER(array8)(target_ulong rs1, target_ulong rs2)
 {
     /*
      * From Oracle SPARC Architecture 2015:
@@ -98,7 +98,7 @@ typedef union {
     float32 f;
 } VIS32;
 
-uint64_t helper_fpmerge(uint32_t src1, uint32_t src2)
+uint64_t HELPER(fpmerge)(uint32_t src1, uint32_t src2)
 {
     VIS32 s1, s2;
     VIS64 d;
@@ -124,7 +124,7 @@ static inline int do_ms16b(int x, int y)
     return ((x * y) + 0x80) >> 8;
 }
 
-uint64_t helper_fmul8x16(uint32_t src1, uint64_t src2)
+uint64_t HELPER(fmul8x16)(uint32_t src1, uint64_t src2)
 {
     VIS64 d;
     VIS32 s;
@@ -140,7 +140,7 @@ uint64_t helper_fmul8x16(uint32_t src1, uint64_t src2)
     return d.ll;
 }
 
-uint64_t helper_fmul8x16a(uint32_t src1, int32_t src2)
+uint64_t HELPER(fmul8x16a)(uint32_t src1, int32_t src2)
 {
     VIS32 s;
     VIS64 d;
@@ -156,7 +156,7 @@ uint64_t helper_fmul8x16a(uint32_t src1, int32_t src2)
     return d.ll;
 }
 
-uint64_t helper_fmul8sux16(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fmul8sux16)(uint64_t src1, uint64_t src2)
 {
     VIS64 s, d;
 
@@ -171,7 +171,7 @@ uint64_t helper_fmul8sux16(uint64_t src1, uint64_t src2)
     return d.ll;
 }
 
-uint64_t helper_fmul8ulx16(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fmul8ulx16)(uint64_t src1, uint64_t src2)
 {
     VIS64 s, d;
 
@@ -186,7 +186,7 @@ uint64_t helper_fmul8ulx16(uint64_t src1, uint64_t src2)
     return d.ll;
 }
 
-uint64_t helper_fexpand(uint32_t src2)
+uint64_t HELPER(fexpand)(uint32_t src2)
 {
     VIS32 s;
     VIS64 d;
@@ -201,7 +201,7 @@ uint64_t helper_fexpand(uint32_t src2)
     return d.ll;
 }
 
-uint64_t helper_fcmpeq8(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmpeq8)(uint64_t src1, uint64_t src2)
 {
     uint64_t a = src1 ^ src2;
     uint64_t m = 0x7f7f7f7f7f7f7f7fULL;
@@ -217,12 +217,12 @@ uint64_t helper_fcmpeq8(uint64_t src1, uint64_t src2)
     return c >> 56;
 }
 
-uint64_t helper_fcmpne8(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmpne8)(uint64_t src1, uint64_t src2)
 {
-    return helper_fcmpeq8(src1, src2) ^ 0xff;
+    return HELPER(fcmpeq8)(src1, src2) ^ 0xff;
 }
 
-uint64_t helper_fcmple8(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmple8)(uint64_t src1, uint64_t src2)
 {
     VIS64 s1, s2;
     uint64_t r = 0;
@@ -236,12 +236,12 @@ uint64_t helper_fcmple8(uint64_t src1, uint64_t src2)
     return r;
 }
 
-uint64_t helper_fcmpgt8(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmpgt8)(uint64_t src1, uint64_t src2)
 {
-    return helper_fcmple8(src1, src2) ^ 0xff;
+    return HELPER(fcmple8)(src1, src2) ^ 0xff;
 }
 
-uint64_t helper_fcmpule8(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmpule8)(uint64_t src1, uint64_t src2)
 {
     VIS64 s1, s2;
     uint64_t r = 0;
@@ -255,12 +255,12 @@ uint64_t helper_fcmpule8(uint64_t src1, uint64_t src2)
     return r;
 }
 
-uint64_t helper_fcmpugt8(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmpugt8)(uint64_t src1, uint64_t src2)
 {
-    return helper_fcmpule8(src1, src2) ^ 0xff;
+    return HELPER(fcmpule8)(src1, src2) ^ 0xff;
 }
 
-uint64_t helper_fcmpeq16(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmpeq16)(uint64_t src1, uint64_t src2)
 {
     uint64_t a = src1 ^ src2;
     uint64_t m = 0x7fff7fff7fff7fffULL;
@@ -274,12 +274,12 @@ uint64_t helper_fcmpeq16(uint64_t src1, uint64_t src2)
     return c >> 60;
 }
 
-uint64_t helper_fcmpne16(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmpne16)(uint64_t src1, uint64_t src2)
 {
-    return helper_fcmpeq16(src1, src2) ^ 0xf;
+    return HELPER(fcmpeq16)(src1, src2) ^ 0xf;
 }
 
-uint64_t helper_fcmple16(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmple16)(uint64_t src1, uint64_t src2)
 {
     VIS64 s1, s2;
     uint64_t r = 0;
@@ -293,12 +293,12 @@ uint64_t helper_fcmple16(uint64_t src1, uint64_t src2)
     return r;
 }
 
-uint64_t helper_fcmpgt16(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmpgt16)(uint64_t src1, uint64_t src2)
 {
-    return helper_fcmple16(src1, src2) ^ 0xf;
+    return HELPER(fcmple16)(src1, src2) ^ 0xf;
 }
 
-uint64_t helper_fcmpule16(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmpule16)(uint64_t src1, uint64_t src2)
 {
     VIS64 s1, s2;
     uint64_t r = 0;
@@ -312,24 +312,24 @@ uint64_t helper_fcmpule16(uint64_t src1, uint64_t src2)
     return r;
 }
 
-uint64_t helper_fcmpugt16(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmpugt16)(uint64_t src1, uint64_t src2)
 {
-    return helper_fcmpule16(src1, src2) ^ 0xf;
+    return HELPER(fcmpule16)(src1, src2) ^ 0xf;
 }
 
-uint64_t helper_fcmpeq32(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmpeq32)(uint64_t src1, uint64_t src2)
 {
     uint64_t a = src1 ^ src2;
     return ((uint32_t)a == 0) | (a >> 32 ? 0 : 2);
 }
 
-uint64_t helper_fcmpne32(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmpne32)(uint64_t src1, uint64_t src2)
 {
     uint64_t a = src1 ^ src2;
     return ((uint32_t)a != 0) | (a >> 32 ? 2 : 0);
 }
 
-uint64_t helper_fcmple32(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmple32)(uint64_t src1, uint64_t src2)
 {
     VIS64 s1, s2;
     uint64_t r = 0;
@@ -343,12 +343,12 @@ uint64_t helper_fcmple32(uint64_t src1, uint64_t src2)
     return r;
 }
 
-uint64_t helper_fcmpgt32(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmpgt32)(uint64_t src1, uint64_t src2)
 {
-    return helper_fcmple32(src1, src2) ^ 3;
+    return HELPER(fcmple32)(src1, src2) ^ 3;
 }
 
-uint64_t helper_fcmpule32(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmpule32)(uint64_t src1, uint64_t src2)
 {
     VIS64 s1, s2;
     uint64_t r = 0;
@@ -362,12 +362,12 @@ uint64_t helper_fcmpule32(uint64_t src1, uint64_t src2)
     return r;
 }
 
-uint64_t helper_fcmpugt32(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fcmpugt32)(uint64_t src1, uint64_t src2)
 {
-    return helper_fcmpule32(src1, src2) ^ 3;
+    return HELPER(fcmpule32)(src1, src2) ^ 3;
 }
 
-uint64_t helper_pdist(uint64_t sum, uint64_t src1, uint64_t src2)
+uint64_t HELPER(pdist)(uint64_t sum, uint64_t src1, uint64_t src2)
 {
     int i;
     for (i = 0; i < 8; i++) {
@@ -388,7 +388,7 @@ uint64_t helper_pdist(uint64_t sum, uint64_t src1, uint64_t src2)
     return sum;
 }
 
-uint32_t helper_fpack16(uint64_t gsr, uint64_t rs2)
+uint32_t HELPER(fpack16)(uint64_t gsr, uint64_t rs2)
 {
     int scale = (gsr >> 3) & 0xf;
     uint32_t ret = 0;
@@ -409,7 +409,7 @@ uint32_t helper_fpack16(uint64_t gsr, uint64_t rs2)
     return ret;
 }
 
-uint64_t helper_fpack32(uint64_t gsr, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fpack32)(uint64_t gsr, uint64_t rs1, uint64_t rs2)
 {
     int scale = (gsr >> 3) & 0x1f;
     uint64_t ret = 0;
@@ -431,7 +431,7 @@ uint64_t helper_fpack32(uint64_t gsr, uint64_t rs1, uint64_t rs2)
     return ret;
 }
 
-uint32_t helper_fpackfix(uint64_t gsr, uint64_t rs2)
+uint32_t HELPER(fpackfix)(uint64_t gsr, uint64_t rs2)
 {
     int scale = (gsr >> 3) & 0x1f;
     uint32_t ret = 0;
@@ -452,7 +452,7 @@ uint32_t helper_fpackfix(uint64_t gsr, uint64_t rs2)
     return ret;
 }
 
-uint64_t helper_bshuffle(uint64_t gsr, uint64_t src1, uint64_t src2)
+uint64_t HELPER(bshuffle)(uint64_t gsr, uint64_t src1, uint64_t src2)
 {
     union {
         uint64_t ll[2];
@@ -481,7 +481,7 @@ uint64_t helper_bshuffle(uint64_t gsr, uint64_t src1, uint64_t src2)
     return r.ll;
 }
 
-uint64_t helper_cmask8(uint64_t gsr, uint64_t src)
+uint64_t HELPER(cmask8)(uint64_t gsr, uint64_t src)
 {
     uint32_t mask = 0;
 
@@ -497,7 +497,7 @@ uint64_t helper_cmask8(uint64_t gsr, uint64_t src)
     return deposit64(gsr, 32, 32, mask);
 }
 
-uint64_t helper_cmask16(uint64_t gsr, uint64_t src)
+uint64_t HELPER(cmask16)(uint64_t gsr, uint64_t src)
 {
     uint32_t mask = 0;
 
@@ -509,7 +509,7 @@ uint64_t helper_cmask16(uint64_t gsr, uint64_t src)
     return deposit64(gsr, 32, 32, mask);
 }
 
-uint64_t helper_cmask32(uint64_t gsr, uint64_t src)
+uint64_t HELPER(cmask32)(uint64_t gsr, uint64_t src)
 {
     uint32_t mask = 0;
 
@@ -526,7 +526,7 @@ static inline uint16_t do_fchksm16(uint16_t src1, uint16_t src2)
     return a + c;
 }
 
-uint64_t helper_fchksm16(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fchksm16)(uint64_t src1, uint64_t src2)
 {
     VIS64 r, s1, s2;
 
@@ -547,7 +547,7 @@ static inline int16_t do_fmean16(int16_t src1, int16_t src2)
     return (src1 + src2 + 1) / 2;
 }
 
-uint64_t helper_fmean16(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fmean16)(uint64_t src1, uint64_t src2)
 {
     VIS64 r, s1, s2;
 
@@ -563,7 +563,7 @@ uint64_t helper_fmean16(uint64_t src1, uint64_t src2)
     return r.ll;
 }
 
-uint64_t helper_fslas16(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fslas16)(uint64_t src1, uint64_t src2)
 {
     VIS64 r, s1, s2;
 
@@ -581,7 +581,7 @@ uint64_t helper_fslas16(uint64_t src1, uint64_t src2)
     return r.ll;
 }
 
-uint64_t helper_fslas32(uint64_t src1, uint64_t src2)
+uint64_t HELPER(fslas32)(uint64_t src1, uint64_t src2)
 {
     VIS64 r, s1, s2;
 
@@ -599,12 +599,12 @@ uint64_t helper_fslas32(uint64_t src1, uint64_t src2)
     return r.ll;
 }
 
-uint64_t helper_xmulx(uint64_t src1, uint64_t src2)
+uint64_t HELPER(xmulx)(uint64_t src1, uint64_t src2)
 {
     return int128_getlo(clmul_64(src1, src2));
 }
 
-uint64_t helper_xmulxhi(uint64_t src1, uint64_t src2)
+uint64_t HELPER(xmulxhi)(uint64_t src1, uint64_t src2)
 {
     return int128_gethi(clmul_64(src1, src2));
 }
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 9ad9d01e8b9..872bd35652f 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -121,7 +121,7 @@ int cpu_cwp_dec(CPUSPARCState *env, int cwp)
 }
 
 #ifndef TARGET_SPARC64
-void helper_rett(CPUSPARCState *env)
+void HELPER(rett)(CPUSPARCState *env)
 {
     unsigned int cwp;
 
@@ -140,7 +140,7 @@ void helper_rett(CPUSPARCState *env)
 
 /* XXX: use another pointer for %iN registers to avoid slow wrapping
    handling ? */
-void helper_save(CPUSPARCState *env)
+void HELPER(save)(CPUSPARCState *env)
 {
     uint32_t cwp;
 
@@ -151,7 +151,7 @@ void helper_save(CPUSPARCState *env)
     cpu_set_cwp(env, cwp);
 }
 
-void helper_restore(CPUSPARCState *env)
+void HELPER(restore)(CPUSPARCState *env)
 {
     uint32_t cwp;
 
@@ -162,7 +162,7 @@ void helper_restore(CPUSPARCState *env)
     cpu_set_cwp(env, cwp);
 }
 
-void helper_wrpsr(CPUSPARCState *env, target_ulong new_psr)
+void HELPER(wrpsr)(CPUSPARCState *env, target_ulong new_psr)
 {
     if ((new_psr & PSR_CWP) >= env->nwindows) {
         cpu_raise_exception_ra(env, TT_ILL_INSN, GETPC());
@@ -174,7 +174,7 @@ void helper_wrpsr(CPUSPARCState *env, target_ulong new_psr)
     }
 }
 
-target_ulong helper_rdpsr(CPUSPARCState *env)
+target_ulong HELPER(rdpsr)(CPUSPARCState *env)
 {
     return cpu_get_psr(env);
 }
@@ -182,7 +182,7 @@ target_ulong helper_rdpsr(CPUSPARCState *env)
 #else
 /* XXX: use another pointer for %iN registers to avoid slow wrapping
    handling ? */
-void helper_save(CPUSPARCState *env)
+void HELPER(save)(CPUSPARCState *env)
 {
     uint32_t cwp;
 
@@ -204,7 +204,7 @@ void helper_save(CPUSPARCState *env)
     }
 }
 
-void helper_restore(CPUSPARCState *env)
+void HELPER(restore)(CPUSPARCState *env)
 {
     uint32_t cwp;
 
@@ -221,7 +221,7 @@ void helper_restore(CPUSPARCState *env)
     }
 }
 
-void helper_flushw(CPUSPARCState *env)
+void HELPER(flushw)(CPUSPARCState *env)
 {
     if (env->cansave != env->nwindows - 2) {
         int tt = TT_SPILL | (env->otherwin != 0
@@ -231,7 +231,7 @@ void helper_flushw(CPUSPARCState *env)
     }
 }
 
-void helper_saved(CPUSPARCState *env)
+void HELPER(saved)(CPUSPARCState *env)
 {
     env->cansave++;
     if (env->otherwin == 0) {
@@ -241,7 +241,7 @@ void helper_saved(CPUSPARCState *env)
     }
 }
 
-void helper_restored(CPUSPARCState *env)
+void HELPER(restored)(CPUSPARCState *env)
 {
     env->canrestore++;
     if (env->cleanwin < env->nwindows - 1) {
@@ -294,24 +294,24 @@ void cpu_put_cwp64(CPUSPARCState *env, int cwp)
     cpu_set_cwp(env, env->nwindows - 1 - cwp);
 }
 
-target_ulong helper_rdccr(CPUSPARCState *env)
+target_ulong HELPER(rdccr)(CPUSPARCState *env)
 {
     return cpu_get_ccr(env);
 }
 
-void helper_wrccr(CPUSPARCState *env, target_ulong new_ccr)
+void HELPER(wrccr)(CPUSPARCState *env, target_ulong new_ccr)
 {
     cpu_put_ccr(env, new_ccr);
 }
 
 /* CWP handling is reversed in V9, but we still use the V8 register
    order. */
-target_ulong helper_rdcwp(CPUSPARCState *env)
+target_ulong HELPER(rdcwp)(CPUSPARCState *env)
 {
     return cpu_get_cwp64(env);
 }
 
-void helper_wrcwp(CPUSPARCState *env, target_ulong new_cwp)
+void HELPER(wrcwp)(CPUSPARCState *env, target_ulong new_cwp)
 {
     cpu_put_cwp64(env, new_cwp);
 }
@@ -355,7 +355,7 @@ void cpu_gl_switch_gregs(CPUSPARCState *env, uint32_t new_gl)
     }
 }
 
-void helper_wrgl(CPUSPARCState *env, target_ulong new_gl)
+void HELPER(wrgl)(CPUSPARCState *env, target_ulong new_gl)
 {
     cpu_gl_switch_gregs(env, new_gl & 7);
     env->gl = new_gl & 7;
@@ -390,7 +390,7 @@ void cpu_change_pstate(CPUSPARCState *env, uint32_t new_pstate)
     env->pstate = new_pstate;
 }
 
-void helper_wrpstate(CPUSPARCState *env, target_ulong new_state)
+void HELPER(wrpstate)(CPUSPARCState *env, target_ulong new_state)
 {
     cpu_change_pstate(env, new_state & 0xf3f);
 
@@ -403,7 +403,7 @@ void helper_wrpstate(CPUSPARCState *env, target_ulong new_state)
 #endif
 }
 
-void helper_wrpil(CPUSPARCState *env, target_ulong new_pil)
+void HELPER(wrpil)(CPUSPARCState *env, target_ulong new_pil)
 {
 #if !defined(CONFIG_USER_ONLY)
     trace_win_helper_wrpil(env->psrpil, (uint32_t)new_pil);
@@ -418,7 +418,7 @@ void helper_wrpil(CPUSPARCState *env, target_ulong new_pil)
 #endif
 }
 
-void helper_done(CPUSPARCState *env)
+void HELPER(done)(CPUSPARCState *env)
 {
     trap_state *tsptr = cpu_tsptr(env);
 
@@ -447,7 +447,7 @@ void helper_done(CPUSPARCState *env)
 #endif
 }
 
-void helper_retry(CPUSPARCState *env)
+void HELPER(retry)(CPUSPARCState *env)
 {
     trap_state *tsptr = cpu_tsptr(env);
 
-- 
2.43.0


