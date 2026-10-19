Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE1606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ehjf4aKe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fB7N4d5J
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunI-0001en-QH; Mon, 19 Oct 2026 17:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunD-0001dR-Tf
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIun8-0005ga-W0
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:15 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK1ge3627863
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3zL45DOXzeC
 th8NreUKbhL+6nxVmFdWksCResfM8aFo=; b=Ehjf4aKed+jK8aVGRTvb3i174ZJ
 6duSoPKhsPwF+5AwRz2JmgecRsw3UUJzLPwb+9jyfL49mdzUgNTjnNIdv+r8pkuQ
 egkqxkTTL8/39CFbxl+iuaeZMv1A6g9fhOTZrOscU1el+khrvYHyN1BxQbyMDDXX
 GhpzbilKNl47Up1/8VtC8JXuzVyf+ZXtZF4S28OmYfgNIEbNMOGL+7vDQ+3c7Jxq
 7WX8QBVGl0NLMB+Cd1OJKjbeg14S6WlEj37WuTffO7zIcTt0kYccZ1Ma30mBzWl8
 v3ttWYidBhwgCTKXr9hWu+lFQKaKYbD8QsNh31eNgusC1TKwGiDJ4Ahy8iw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr42gptw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so3469178a91.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444869; x=1793049669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3zL45DOXzeCth8NreUKbhL+6nxVmFdWksCResfM8aFo=;
 b=fB7N4d5Jrb1CoBEbCpk2XU4AEFfbzOeSWwzAjYGxIYHxKtZ4nMuj7FU6PADCAEECZ6
 TrktegzDq5316RSu6CsSVqxkMpow4iybPDwWPIV3UZ5c2R4oK3gf09lLAM06UJSZ9n+f
 lwoonzLt8XzAimAM6hhVRUAm8dRNk5MA9KsLpDsr7EzIIdj27qAvIyrDPrj0EIEHsnct
 h4ut6eqpEkTqklNAIJm9UkPLhm09OWa/IqfvETcmMo54hCwOBhMzrAHPFRs2IktZFJdE
 ImbZzGXn/W5BbK0GZgNHO7WErGr9dJhY6ohmheofgJ1+T847qHTOBVMvAs6NAGkvGM+t
 tDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444869; x=1793049669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3zL45DOXzeCth8NreUKbhL+6nxVmFdWksCResfM8aFo=;
 b=0lukLGOYRMNstcCXtTdAhlmymfH+nL+3Z6PJi59AsryfMjbHjBNa3nQzM20RZU6Agj
 17vJowLr6IrjQEYQZ6ioYpm2OvNoZYlZhjhALj0dsYppuAw6yZYJtqmQapNXia0K6s/p
 T0eYiXky23tXi1wIonyJkoB3FhYvRY3EESrnO/tHhVUL7FRsAUJY1Ynuta9l1uf/NPzZ
 oXyI+pdy8gWF/7I9x7TUDUYC3Zvv6lg0YjZXgUDdosvCBSX3ONFt1xUXDZISEO4GkVZt
 GcM5LHEMVqKPvza1Spd0dEOjXIppFyALFF12M3BRNm8T7wyXcI+XXdclKNQaQpbXbB5e
 GNLQ==
X-Gm-Message-State: AFq9FYKlabN09uHL+P3kdMinMWaqiF0WmLB/nIs03jRmOFe5NCiAdv+j
 MhiPCuqQT6KdakYWSetbTFjQdf4B3hrMeLzRdCZXkFYFcsW2isIsYw3vW1eeyCqFy/pSJH12Irn
 VbSrKz1QzuPI/WXAz5UzYTdzMnHeJ5cEpdfDGaxiR/4Vqfv8W54F1q8QP3mPdPWkm5Q==
X-Gm-Gg: AYBFou3Peef4oogXgfvF1XIwscOr/24gHUPPymthb8RA1so2SI53/lDh+uf4RvnqA38
 NTKL8ddP4LsvjVpSoZ6bYm7bKCv51eUcd4DymeKodHyEZP9/Eexn0ojQcjzDu+2zO8OjREqS+f0
 Hfr252iaJ16Xc9ykhq04utg0xLWcvv5JFsUPbFgV9vrY8JIIF6qM9ymEs8yQ63zMsDhTdDjUCON
 CQu1iApaIkIH6j8WMW5plmF8NDsBcmjBZVL9ueWKL8T14q6KPlemTkIN65cR89GqO/9bJxoXyzY
 data+M8g1agGAB1P4Wib3DTblKvh3JQqn00wzBaRv13WU8XARYgl1Pwcl6hUc0eKOix2pBqxsC6
 apO7On6t5PnN84c+ktwcZ5ZxKNT/du81SG4SczwmvmV2TqZ/FYfttFWsHRWtFeQc=
X-Received: by 2002:a17:90b:2e03:b0:3ac:adce:60bb with SMTP id
 98e67ed59e1d1-3aceeb95d84mr6226739a91.23.1792444867510; 
 Mon, 19 Oct 2026 14:21:07 -0700 (PDT)
X-Received: by 2002:a17:90b:2e03:b0:3ac:adce:60bb with SMTP id
 98e67ed59e1d1-3aceeb95d84mr6226679a91.23.1792444865639; 
 Mon, 19 Oct 2026 14:21:05 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 05/26] target/i386: define and call helpers using HELPER macro
Date: Mon, 19 Oct 2026 21:20:24 +0000
Message-ID: <20261019212046.149572-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXzu5a+KCa0YtH
 DSTgovnvcsJYHR4j5K/t+e3YVcaqxG/m/Dq6wVIWviIXd2jLboBqaN1rEJYoA7+ac4iVZm9H5vE
 V9x6oOhlZiHPMI3bEMzAF0fvQU95SmV3F/Oa9su4K59zrGnLSMMJ2LuhCSny1BvGJYDQlkolHnE
 uGho2gtBJozN7neMkG+WPFe63c1Tkj8vWLK44jE9ZViz9yepOW2xC1XjRdIpMSrF+H5JhPsHCfX
 pmS6ayd3AtwlMJ0/qVUA/PjSqdOBFV4NXseP6xFc34dz7AYFwRvXppYhRjeP4bQU5Vh32q0mZrt
 BYk47pAG09/1f9E8wiOKBqdZvAjIPxUFnjLt91cNWsDE09EMHUYtGkckp/4sxCedhfnhaQJ2AaQ
 NZbucQX2xNyxTq2qOS5EUI7VJsr4NsnWYGi25ghB/tDHg4PMnAeCqzbTAYzOc93m440r7lA74ae
 U92vH68EL51g35/cB4A==
X-Authority-Analysis: v=2.4 cv=Ve9ir1p9 c=1 sm=1 tr=0 ts=6ad689c6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=xYhcjry6s8sSYopFNbsA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX+8+q5R+iW9YY
 hm0nI3fSI/mn6XblWPivOtm0JDrJu+7JxVnETx+ke6jpV3B1X1j/2EsmM+ckdqYnE4qK7TTL/MX
 McS8A5MP/QDSP5R6gumu1FpkVhILKkI=
X-Proofpoint-ORIG-GUID: 5ZD6rsaPYI8HyAEywSgZ3HPkkHS4eh2U
X-Proofpoint-GUID: 5ZD6rsaPYI8HyAEywSgZ3HPkkHS4eh2U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
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
 target/i386/ops_sse.h                | 401 ++++++++++++++-------------
 target/i386/tcg/bpt_helper.c         |   6 +-
 target/i386/tcg/cc_helper.c          |  14 +-
 target/i386/tcg/excp_helper.c        |   8 +-
 target/i386/tcg/fpu_helper.c         | 182 ++++++------
 target/i386/tcg/int_helper.c         |  34 +--
 target/i386/tcg/mem_helper.c         |   4 +-
 target/i386/tcg/misc_helper.c        |  16 +-
 target/i386/tcg/mpx_helper.c         |  12 +-
 target/i386/tcg/seg_helper.c         |  32 +--
 target/i386/tcg/system/bpt_helper.c  |   6 +-
 target/i386/tcg/system/misc_helper.c |  32 +--
 target/i386/tcg/system/seg_helper.c  |   4 +-
 target/i386/tcg/system/smm_helper.c  |  12 +-
 target/i386/tcg/system/svm_helper.c  |  16 +-
 target/i386/tcg/user/seg_helper.c    |   4 +-
 16 files changed, 392 insertions(+), 391 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 5176a9f9e35..b39fcde3539 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -54,7 +54,7 @@
 #define FPSLL(x, c) ((x) << shift)
 #endif
 
-void glue(helper_psrlw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
+void glue(HELPER(psrlw), SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
 {
     int shift;
     if (c->Q(0) > 15) {
@@ -69,7 +69,7 @@ void glue(helper_psrlw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
     }
 }
 
-void glue(helper_psllw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
+void glue(HELPER(psllw), SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
 {
     int shift;
     if (c->Q(0) > 15) {
@@ -84,7 +84,7 @@ void glue(helper_psllw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
     }
 }
 
-void glue(helper_psraw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
+void glue(HELPER(psraw), SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
 {
     int shift;
     if (c->Q(0) > 15) {
@@ -97,7 +97,7 @@ void glue(helper_psraw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
     }
 }
 
-void glue(helper_psrld, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
+void glue(HELPER(psrld), SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
 {
     int shift;
     if (c->Q(0) > 31) {
@@ -112,7 +112,7 @@ void glue(helper_psrld, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
     }
 }
 
-void glue(helper_pslld, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
+void glue(HELPER(pslld), SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
 {
     int shift;
     if (c->Q(0) > 31) {
@@ -127,7 +127,7 @@ void glue(helper_pslld, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
     }
 }
 
-void glue(helper_psrad, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
+void glue(HELPER(psrad), SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
 {
     int shift;
     if (c->Q(0) > 31) {
@@ -140,7 +140,7 @@ void glue(helper_psrad, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
     }
 }
 
-void glue(helper_psrlq, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
+void glue(HELPER(psrlq), SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
 {
     int shift;
     if (c->Q(0) > 63) {
@@ -155,7 +155,7 @@ void glue(helper_psrlq, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
     }
 }
 
-void glue(helper_psllq, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
+void glue(HELPER(psllq), SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
 {
     int shift;
     if (c->Q(0) > 63) {
@@ -171,7 +171,7 @@ void glue(helper_psllq, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
 }
 
 #if SHIFT >= 1
-void glue(helper_psrldq, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
+void glue(HELPER(psrldq), SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
 {
     int shift, i, j;
 
@@ -189,7 +189,7 @@ void glue(helper_psrldq, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
     }
 }
 
-void glue(helper_pslldq, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
+void glue(HELPER(pslldq), SUFFIX)(CPUX86State *env, Reg *d, Reg *s, Reg *c)
 {
     int shift, i, j;
 
@@ -306,11 +306,11 @@ static inline int satsw(int x)
 #define FAVG(a, b) (((a) + (b) + 1) >> 1)
 #endif
 
-SSE_HELPER_W(helper_pmulhuw, FMULHUW)
-SSE_HELPER_W(helper_pmulhw, FMULHW)
+SSE_HELPER_W(HELPER(pmulhuw), FMULHUW)
+SSE_HELPER_W(HELPER(pmulhw), FMULHW)
 
 #if SHIFT == 0
-void glue(helper_pmulhrw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(HELPER(pmulhrw), SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
     d->W(0) = FMULHRW(d->W(0), s->W(0));
     d->W(1) = FMULHRW(d->W(1), s->W(1));
@@ -319,10 +319,10 @@ void glue(helper_pmulhrw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 }
 #endif
 
-SSE_HELPER_B(helper_pavgb, FAVG)
-SSE_HELPER_W(helper_pavgw, FAVG)
+SSE_HELPER_B(HELPER(pavgb), FAVG)
+SSE_HELPER_W(HELPER(pavgw), FAVG)
 
-void glue(helper_pmuludq, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(pmuludq), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     int i;
 
@@ -331,7 +331,7 @@ void glue(helper_pmuludq, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
     }
 }
 
-void glue(helper_pmaddwd, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(pmaddwd), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     int i;
 
@@ -351,7 +351,7 @@ static inline int abs1(int a)
     }
 }
 #endif
-void glue(helper_psadbw, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(psadbw), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     int i;
 
@@ -370,7 +370,7 @@ void glue(helper_psadbw, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 }
 
 #if SHIFT < 2
-void glue(helper_maskmov, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
+void glue(HELPER(maskmov), SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                   target_ulong a0)
 {
     int i;
@@ -395,14 +395,14 @@ void glue(helper_maskmov, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
     } while (0)
 
 #if SHIFT == 0
-void glue(helper_pshufw, SUFFIX)(Reg *d, Reg *s, int order)
+void glue(HELPER(pshufw), SUFFIX)(Reg *d, Reg *s, int order)
 {
     uint16_t r0, r1, r2, r3;
 
     SHUFFLE4(W, s, s, 0);
 }
 #else
-void glue(helper_shufps, SUFFIX)(Reg *d, Reg *v, Reg *s, int order)
+void glue(HELPER(shufps), SUFFIX)(Reg *d, Reg *v, Reg *s, int order)
 {
     uint32_t r0, r1, r2, r3;
     int i;
@@ -412,7 +412,7 @@ void glue(helper_shufps, SUFFIX)(Reg *d, Reg *v, Reg *s, int order)
     }
 }
 
-void glue(helper_shufpd, SUFFIX)(Reg *d, Reg *v, Reg *s, int order)
+void glue(HELPER(shufpd), SUFFIX)(Reg *d, Reg *v, Reg *s, int order)
 {
     uint64_t r0, r1;
     int i;
@@ -426,7 +426,7 @@ void glue(helper_shufpd, SUFFIX)(Reg *d, Reg *v, Reg *s, int order)
     }
 }
 
-void glue(helper_pshufd, SUFFIX)(Reg *d, Reg *s, int order)
+void glue(HELPER(pshufd), SUFFIX)(Reg *d, Reg *s, int order)
 {
     uint32_t r0, r1, r2, r3;
     int i;
@@ -436,7 +436,7 @@ void glue(helper_pshufd, SUFFIX)(Reg *d, Reg *s, int order)
     }
 }
 
-void glue(helper_pshuflw, SUFFIX)(Reg *d, Reg *s, int order)
+void glue(HELPER(pshuflw), SUFFIX)(Reg *d, Reg *s, int order)
 {
     uint16_t r0, r1, r2, r3;
     int i, j;
@@ -447,7 +447,7 @@ void glue(helper_pshuflw, SUFFIX)(Reg *d, Reg *s, int order)
     }
 }
 
-void glue(helper_pshufhw, SUFFIX)(Reg *d, Reg *s, int order)
+void glue(HELPER(pshufhw), SUFFIX)(Reg *d, Reg *s, int order)
 {
     uint16_t r0, r1, r2, r3;
     int i, j;
@@ -464,7 +464,7 @@ void glue(helper_pshufhw, SUFFIX)(Reg *d, Reg *s, int order)
 /* XXX: not accurate */
 
 #define SSE_HELPER_P(name, F)                                           \
-    void glue(helper_ ## name ## ps, SUFFIX)(CPUX86State *env,          \
+    void HELPER(glue(name ## ps, SUFFIX))(CPUX86State *env,             \
             Reg *d, Reg *v, Reg *s)                                     \
     {                                                                   \
         int i;                                                          \
@@ -473,7 +473,7 @@ void glue(helper_pshufhw, SUFFIX)(Reg *d, Reg *s, int order)
         }                                                               \
     }                                                                   \
                                                                         \
-    void glue(helper_ ## name ## pd, SUFFIX)(CPUX86State *env,          \
+    void HELPER(glue(name ## pd, SUFFIX))(CPUX86State *env,             \
             Reg *d, Reg *v, Reg *s)                                     \
     {                                                                   \
         int i;                                                          \
@@ -487,7 +487,7 @@ void glue(helper_pshufhw, SUFFIX)(Reg *d, Reg *s, int order)
 #define SSE_HELPER_S(name, F)                                           \
     SSE_HELPER_P(name, F)                                               \
                                                                         \
-    void helper_ ## name ## ss(CPUX86State *env, Reg *d, Reg *v, Reg *s)\
+    void HELPER(name ## ss)(CPUX86State *env, Reg *d, Reg *v, Reg *s)   \
     {                                                                   \
         int i;                                                          \
         d->ZMM_S(0) = F(32, v->ZMM_S(0), s->ZMM_S(0));                  \
@@ -496,7 +496,7 @@ void glue(helper_pshufhw, SUFFIX)(Reg *d, Reg *s, int order)
         }                                                               \
     }                                                                   \
                                                                         \
-    void helper_ ## name ## sd(CPUX86State *env, Reg *d, Reg *v, Reg *s)\
+    void HELPER(name ## sd)(CPUX86State *env, Reg *d, Reg *v, Reg *s)   \
     {                                                                   \
         int i;                                                          \
         d->ZMM_D(0) = F(64, v->ZMM_D(0), s->ZMM_D(0));                  \
@@ -532,7 +532,7 @@ SSE_HELPER_S(div, FPU_DIV)
 SSE_HELPER_S(min, FPU_MIN)
 SSE_HELPER_S(max, FPU_MAX)
 
-void glue(helper_sqrtps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(HELPER(sqrtps), SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
     int i;
     for (i = 0; i < 2 << SHIFT; i++) {
@@ -540,7 +540,7 @@ void glue(helper_sqrtps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
     }
 }
 
-void glue(helper_sqrtpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(HELPER(sqrtpd), SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
     int i;
     for (i = 0; i < 1 << SHIFT; i++) {
@@ -549,7 +549,7 @@ void glue(helper_sqrtpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 }
 
 #if SHIFT == 1
-void helper_sqrtss(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void HELPER(sqrtss)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     int i;
     d->ZMM_S(0) = float32_sqrt(s->ZMM_S(0), &env->sse_status);
@@ -558,7 +558,7 @@ void helper_sqrtss(CPUX86State *env, Reg *d, Reg *v, Reg *s)
     }
 }
 
-void helper_sqrtsd(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void HELPER(sqrtsd)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     int i;
     d->ZMM_D(0) = float64_sqrt(s->ZMM_D(0), &env->sse_status);
@@ -569,7 +569,7 @@ void helper_sqrtsd(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 #endif
 
 /* float to float conversions */
-void glue(helper_cvtps2pd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(HELPER(cvtps2pd), SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
     int i;
     for (i = 1 << SHIFT; --i >= 0; ) {
@@ -577,7 +577,7 @@ void glue(helper_cvtps2pd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
     }
 }
 
-void glue(helper_cvtpd2ps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(HELPER(cvtpd2ps), SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
     int i;
     for (i = 0; i < 1 << SHIFT; i++) {
@@ -589,7 +589,7 @@ void glue(helper_cvtpd2ps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 }
 
 #if SHIFT >= 1
-void glue(helper_cvtph2ps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(HELPER(cvtph2ps), SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
     int i;
 
@@ -598,7 +598,7 @@ void glue(helper_cvtph2ps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
     }
 }
 
-void glue(helper_cvtps2ph, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, int mode)
+void glue(HELPER(cvtps2ph), SUFFIX)(CPUX86State *env, Reg *d, Reg *s, int mode)
 {
     int i;
     FloatRoundMode prev_rounding_mode = get_float_rounding_mode(&env->sse_status);
@@ -618,7 +618,7 @@ void glue(helper_cvtps2ph, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, int mode)
 #endif
 
 #if SHIFT == 1
-void helper_cvtss2sd(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void HELPER(cvtss2sd)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     int i;
     d->ZMM_D(0) = float32_to_float64(s->ZMM_S(0), &env->sse_status);
@@ -627,7 +627,7 @@ void helper_cvtss2sd(CPUX86State *env, Reg *d, Reg *v, Reg *s)
     }
 }
 
-void helper_cvtsd2ss(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void HELPER(cvtsd2ss)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     int i;
     d->ZMM_S(0) = float64_to_float32(s->ZMM_D(0), &env->sse_status);
@@ -638,7 +638,7 @@ void helper_cvtsd2ss(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 #endif
 
 /* integer to float */
-void glue(helper_cvtdq2ps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(HELPER(cvtdq2ps), SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
     int i;
     for (i = 0; i < 2 << SHIFT; i++) {
@@ -646,7 +646,7 @@ void glue(helper_cvtdq2ps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
     }
 }
 
-void glue(helper_cvtdq2pd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(HELPER(cvtdq2pd), SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
     int i;
     for (i = 1 << SHIFT; --i >= 0; ) {
@@ -656,35 +656,35 @@ void glue(helper_cvtdq2pd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 }
 
 #if SHIFT == 1
-void helper_cvtpi2ps(CPUX86State *env, ZMMReg *d, MMXReg *s)
+void HELPER(cvtpi2ps)(CPUX86State *env, ZMMReg *d, MMXReg *s)
 {
     d->ZMM_S(0) = int32_to_float32(s->MMX_L(0), &env->sse_status);
     d->ZMM_S(1) = int32_to_float32(s->MMX_L(1), &env->sse_status);
 }
 
-void helper_cvtpi2pd(CPUX86State *env, ZMMReg *d, MMXReg *s)
+void HELPER(cvtpi2pd)(CPUX86State *env, ZMMReg *d, MMXReg *s)
 {
     d->ZMM_D(0) = int32_to_float64(s->MMX_L(0), &env->sse_status);
     d->ZMM_D(1) = int32_to_float64(s->MMX_L(1), &env->sse_status);
 }
 
-void helper_cvtsi2ss(CPUX86State *env, ZMMReg *d, uint32_t val)
+void HELPER(cvtsi2ss)(CPUX86State *env, ZMMReg *d, uint32_t val)
 {
     d->ZMM_S(0) = int32_to_float32(val, &env->sse_status);
 }
 
-void helper_cvtsi2sd(CPUX86State *env, ZMMReg *d, uint32_t val)
+void HELPER(cvtsi2sd)(CPUX86State *env, ZMMReg *d, uint32_t val)
 {
     d->ZMM_D(0) = int32_to_float64(val, &env->sse_status);
 }
 
 #ifdef TARGET_X86_64
-void helper_cvtsq2ss(CPUX86State *env, ZMMReg *d, uint64_t val)
+void HELPER(cvtsq2ss)(CPUX86State *env, ZMMReg *d, uint64_t val)
 {
     d->ZMM_S(0) = int64_to_float32(val, &env->sse_status);
 }
 
-void helper_cvtsq2sd(CPUX86State *env, ZMMReg *d, uint64_t val)
+void HELPER(cvtsq2sd)(CPUX86State *env, ZMMReg *d, uint64_t val)
 {
     d->ZMM_D(0) = int64_to_float64(val, &env->sse_status);
 }
@@ -727,7 +727,7 @@ WRAP_FLOATCONV(int64_t, float64_to_int64, float64, INT64_MIN)
 WRAP_FLOATCONV(int64_t, float64_to_int64_round_to_zero, float64, INT64_MIN)
 #endif
 
-void glue(helper_cvtps2dq, SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
+void glue(HELPER(cvtps2dq), SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
     int i;
     for (i = 0; i < 2 << SHIFT; i++) {
@@ -735,7 +735,7 @@ void glue(helper_cvtps2dq, SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
     }
 }
 
-void glue(helper_cvtpd2dq, SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
+void glue(HELPER(cvtpd2dq), SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
     int i;
     for (i = 0; i < 1 << SHIFT; i++) {
@@ -747,35 +747,35 @@ void glue(helper_cvtpd2dq, SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 }
 
 #if SHIFT == 1
-void helper_cvtps2pi(CPUX86State *env, MMXReg *d, ZMMReg *s)
+void HELPER(cvtps2pi)(CPUX86State *env, MMXReg *d, ZMMReg *s)
 {
     d->MMX_L(0) = x86_float32_to_int32(s->ZMM_S(0), &env->sse_status);
     d->MMX_L(1) = x86_float32_to_int32(s->ZMM_S(1), &env->sse_status);
 }
 
-void helper_cvtpd2pi(CPUX86State *env, MMXReg *d, ZMMReg *s)
+void HELPER(cvtpd2pi)(CPUX86State *env, MMXReg *d, ZMMReg *s)
 {
     d->MMX_L(0) = x86_float64_to_int32(s->ZMM_D(0), &env->sse_status);
     d->MMX_L(1) = x86_float64_to_int32(s->ZMM_D(1), &env->sse_status);
 }
 
-int32_t helper_cvtss2si(CPUX86State *env, ZMMReg *s)
+int32_t HELPER(cvtss2si)(CPUX86State *env, ZMMReg *s)
 {
     return x86_float32_to_int32(s->ZMM_S(0), &env->sse_status);
 }
 
-int32_t helper_cvtsd2si(CPUX86State *env, ZMMReg *s)
+int32_t HELPER(cvtsd2si)(CPUX86State *env, ZMMReg *s)
 {
     return x86_float64_to_int32(s->ZMM_D(0), &env->sse_status);
 }
 
 #ifdef TARGET_X86_64
-int64_t helper_cvtss2sq(CPUX86State *env, ZMMReg *s)
+int64_t HELPER(cvtss2sq)(CPUX86State *env, ZMMReg *s)
 {
     return x86_float32_to_int64(s->ZMM_S(0), &env->sse_status);
 }
 
-int64_t helper_cvtsd2sq(CPUX86State *env, ZMMReg *s)
+int64_t HELPER(cvtsd2sq)(CPUX86State *env, ZMMReg *s)
 {
     return x86_float64_to_int64(s->ZMM_D(0), &env->sse_status);
 }
@@ -783,7 +783,7 @@ int64_t helper_cvtsd2sq(CPUX86State *env, ZMMReg *s)
 #endif
 
 /* float to integer truncated */
-void glue(helper_cvttps2dq, SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
+void glue(HELPER(cvttps2dq), SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
     int i;
     for (i = 0; i < 2 << SHIFT; i++) {
@@ -792,7 +792,7 @@ void glue(helper_cvttps2dq, SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
     }
 }
 
-void glue(helper_cvttpd2dq, SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
+void glue(HELPER(cvttpd2dq), SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
     int i;
     for (i = 0; i < 1 << SHIFT; i++) {
@@ -805,42 +805,42 @@ void glue(helper_cvttpd2dq, SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 }
 
 #if SHIFT == 1
-void helper_cvttps2pi(CPUX86State *env, MMXReg *d, ZMMReg *s)
+void HELPER(cvttps2pi)(CPUX86State *env, MMXReg *d, ZMMReg *s)
 {
     d->MMX_L(0) = x86_float32_to_int32_round_to_zero(s->ZMM_S(0), &env->sse_status);
     d->MMX_L(1) = x86_float32_to_int32_round_to_zero(s->ZMM_S(1), &env->sse_status);
 }
 
-void helper_cvttpd2pi(CPUX86State *env, MMXReg *d, ZMMReg *s)
+void HELPER(cvttpd2pi)(CPUX86State *env, MMXReg *d, ZMMReg *s)
 {
     d->MMX_L(0) = x86_float64_to_int32_round_to_zero(s->ZMM_D(0), &env->sse_status);
     d->MMX_L(1) = x86_float64_to_int32_round_to_zero(s->ZMM_D(1), &env->sse_status);
 }
 
-int32_t helper_cvttss2si(CPUX86State *env, ZMMReg *s)
+int32_t HELPER(cvttss2si)(CPUX86State *env, ZMMReg *s)
 {
     return x86_float32_to_int32_round_to_zero(s->ZMM_S(0), &env->sse_status);
 }
 
-int32_t helper_cvttsd2si(CPUX86State *env, ZMMReg *s)
+int32_t HELPER(cvttsd2si)(CPUX86State *env, ZMMReg *s)
 {
     return x86_float64_to_int32_round_to_zero(s->ZMM_D(0), &env->sse_status);
 }
 
 #ifdef TARGET_X86_64
-int64_t helper_cvttss2sq(CPUX86State *env, ZMMReg *s)
+int64_t HELPER(cvttss2sq)(CPUX86State *env, ZMMReg *s)
 {
     return x86_float32_to_int64_round_to_zero(s->ZMM_S(0), &env->sse_status);
 }
 
-int64_t helper_cvttsd2sq(CPUX86State *env, ZMMReg *s)
+int64_t HELPER(cvttsd2sq)(CPUX86State *env, ZMMReg *s)
 {
     return x86_float64_to_int64_round_to_zero(s->ZMM_D(0), &env->sse_status);
 }
 #endif
 #endif
 
-void glue(helper_rsqrtps, SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
+void glue(HELPER(rsqrtps), SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
     int old_flags = get_float_exception_flags(&env->sse_status);
     int i;
@@ -853,7 +853,7 @@ void glue(helper_rsqrtps, SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 }
 
 #if SHIFT == 1
-void helper_rsqrtss(CPUX86State *env, ZMMReg *d, ZMMReg *v, ZMMReg *s)
+void HELPER(rsqrtss)(CPUX86State *env, ZMMReg *d, ZMMReg *v, ZMMReg *s)
 {
     int old_flags = get_float_exception_flags(&env->sse_status);
     int i;
@@ -867,7 +867,7 @@ void helper_rsqrtss(CPUX86State *env, ZMMReg *d, ZMMReg *v, ZMMReg *s)
 }
 #endif
 
-void glue(helper_rcpps, SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
+void glue(HELPER(rcpps), SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
     int old_flags = get_float_exception_flags(&env->sse_status);
     int i;
@@ -878,7 +878,7 @@ void glue(helper_rcpps, SUFFIX)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 }
 
 #if SHIFT == 1
-void helper_rcpss(CPUX86State *env, ZMMReg *d, ZMMReg *v, ZMMReg *s)
+void HELPER(rcpss)(CPUX86State *env, ZMMReg *d, ZMMReg *v, ZMMReg *s)
 {
     int old_flags = get_float_exception_flags(&env->sse_status);
     int i;
@@ -903,12 +903,12 @@ static inline uint64_t helper_extrq(uint64_t src, int shift, int len)
     return (src >> shift) & mask;
 }
 
-void helper_extrq_r(CPUX86State *env, ZMMReg *d, ZMMReg *s)
+void HELPER(extrq_r)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
     d->ZMM_Q(0) = helper_extrq(d->ZMM_Q(0), s->ZMM_B(1) & 63, s->ZMM_B(0) & 63);
 }
 
-void helper_extrq_i(CPUX86State *env, ZMMReg *d, int index, int length)
+void HELPER(extrq_i)(CPUX86State *env, ZMMReg *d, int index, int length)
 {
     d->ZMM_Q(0) = helper_extrq(d->ZMM_Q(0), index, length);
 }
@@ -925,19 +925,20 @@ static inline uint64_t helper_insertq(uint64_t dest, uint64_t src, int shift, in
     return (dest & ~(mask << shift)) | ((src & mask) << shift);
 }
 
-void helper_insertq_r(CPUX86State *env, ZMMReg *d, ZMMReg *s)
+void HELPER(insertq_r)(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
     d->ZMM_Q(0) = helper_insertq(d->ZMM_Q(0), s->ZMM_Q(0), s->ZMM_B(9) & 63, s->ZMM_B(8) & 63);
 }
 
-void helper_insertq_i(CPUX86State *env, ZMMReg *d, ZMMReg *s, int index, int length)
+void HELPER(insertq_i)(CPUX86State *env, ZMMReg *d, ZMMReg *s, int index,
+                       int length)
 {
     d->ZMM_Q(0) = helper_insertq(d->ZMM_Q(0), s->ZMM_Q(0), index, length);
 }
 #endif
 
 #define SSE_HELPER_HPS(name, F)  \
-void glue(helper_ ## name, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s) \
+void HELPER(glue(name, SUFFIX))(CPUX86State *env, Reg *d, Reg *v, Reg *s)    \
 {                                                                 \
     float32 r[2 << SHIFT];                                        \
     int i, j, k;                                                  \
@@ -958,7 +959,7 @@ SSE_HELPER_HPS(haddps, float32_add)
 SSE_HELPER_HPS(hsubps, float32_sub)
 
 #define SSE_HELPER_HPD(name, F)  \
-void glue(helper_ ## name, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s) \
+void HELPER(glue(name, SUFFIX))(CPUX86State *env, Reg *d, Reg *v, Reg *s)    \
 {                                                                 \
     float64 r[1 << SHIFT];                                        \
     int i, j, k;                                                  \
@@ -978,7 +979,7 @@ void glue(helper_ ## name, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s) \
 SSE_HELPER_HPD(haddpd, float64_add)
 SSE_HELPER_HPD(hsubpd, float64_sub)
 
-void glue(helper_addsubps, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(addsubps), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     int i;
     for (i = 0; i < 2 << SHIFT; i += 2) {
@@ -987,7 +988,7 @@ void glue(helper_addsubps, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
     }
 }
 
-void glue(helper_addsubpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(addsubpd), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     int i;
     for (i = 0; i < 1 << SHIFT; i += 2) {
@@ -997,7 +998,7 @@ void glue(helper_addsubpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 }
 
 #define SSE_HELPER_CMP_P(name, F, C)                                    \
-    void glue(helper_ ## name ## ps, SUFFIX)(CPUX86State *env,          \
+    void HELPER(glue(name ## ps, SUFFIX))(CPUX86State *env,             \
                                              Reg *d, Reg *v, Reg *s)    \
     {                                                                   \
         int i;                                                          \
@@ -1006,7 +1007,7 @@ void glue(helper_addsubpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
         }                                                               \
     }                                                                   \
                                                                         \
-    void glue(helper_ ## name ## pd, SUFFIX)(CPUX86State *env,          \
+    void HELPER(glue(name ## pd, SUFFIX))(CPUX86State *env,             \
                                              Reg *d, Reg *v, Reg *s)    \
     {                                                                   \
         int i;                                                          \
@@ -1018,7 +1019,7 @@ void glue(helper_addsubpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 #if SHIFT == 1
 #define SSE_HELPER_CMP(name, F, C)                                          \
     SSE_HELPER_CMP_P(name, F, C)                                            \
-    void helper_ ## name ## ss(CPUX86State *env, Reg *d, Reg *v, Reg *s)    \
+    void HELPER(name ## ss)(CPUX86State *env, Reg *d, Reg *v, Reg *s)       \
     {                                                                       \
         int i;                                                              \
         d->ZMM_L(0) = C(F(32, v->ZMM_S(0), s->ZMM_S(0))) ? -1 : 0;          \
@@ -1027,7 +1028,7 @@ void glue(helper_addsubpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
         }                                                                   \
     }                                                                       \
                                                                             \
-    void helper_ ## name ## sd(CPUX86State *env, Reg *d, Reg *v, Reg *s)    \
+    void HELPER(name ## sd)(CPUX86State *env, Reg *d, Reg *v, Reg *s)       \
     {                                                                       \
         int i;                                                              \
         d->ZMM_Q(0) = C(F(64, v->ZMM_D(0), s->ZMM_D(0))) ? -1 : 0;          \
@@ -1102,7 +1103,7 @@ SSE_HELPER_CMP(cmptrues, FPU_CMPS,  !FPU_FALSE)
 #if SHIFT == 1
 static const int comis_eflags[4] = {CC_C, CC_Z, 0, CC_Z | CC_P | CC_C};
 
-void helper_ucomiss(CPUX86State *env, Reg *d, Reg *s)
+void HELPER(ucomiss)(CPUX86State *env, Reg *d, Reg *s)
 {
     FloatRelation ret;
     float32 s0, s1;
@@ -1114,7 +1115,7 @@ void helper_ucomiss(CPUX86State *env, Reg *d, Reg *s)
     CC_OP = CC_OP_EFLAGS;
 }
 
-void helper_comiss(CPUX86State *env, Reg *d, Reg *s)
+void HELPER(comiss)(CPUX86State *env, Reg *d, Reg *s)
 {
     FloatRelation ret;
     float32 s0, s1;
@@ -1126,7 +1127,7 @@ void helper_comiss(CPUX86State *env, Reg *d, Reg *s)
     CC_OP = CC_OP_EFLAGS;
 }
 
-void helper_ucomisd(CPUX86State *env, Reg *d, Reg *s)
+void HELPER(ucomisd)(CPUX86State *env, Reg *d, Reg *s)
 {
     FloatRelation ret;
     float64 d0, d1;
@@ -1138,7 +1139,7 @@ void helper_ucomisd(CPUX86State *env, Reg *d, Reg *s)
     CC_OP = CC_OP_EFLAGS;
 }
 
-void helper_comisd(CPUX86State *env, Reg *d, Reg *s)
+void HELPER(comisd)(CPUX86State *env, Reg *d, Reg *s)
 {
     FloatRelation ret;
     float64 d0, d1;
@@ -1151,7 +1152,7 @@ void helper_comisd(CPUX86State *env, Reg *d, Reg *s)
 }
 #endif
 
-uint32_t glue(helper_movmskps, SUFFIX)(CPUX86State *env, Reg *s)
+uint32_t glue(HELPER(movmskps), SUFFIX)(CPUX86State *env, Reg *s)
 {
     uint32_t mask;
     int i;
@@ -1163,7 +1164,7 @@ uint32_t glue(helper_movmskps, SUFFIX)(CPUX86State *env, Reg *s)
     return mask;
 }
 
-uint32_t glue(helper_movmskpd, SUFFIX)(CPUX86State *env, Reg *s)
+uint32_t glue(HELPER(movmskpd), SUFFIX)(CPUX86State *env, Reg *s)
 {
     uint32_t mask;
     int i;
@@ -1178,7 +1179,7 @@ uint32_t glue(helper_movmskpd, SUFFIX)(CPUX86State *env, Reg *s)
 #endif
 
 #define PACK_HELPER_B(name, F) \
-void glue(helper_pack ## name, SUFFIX)(CPUX86State *env,      \
+void HELPER(glue(pack ## name, SUFFIX))(CPUX86State *env,     \
         Reg *d, Reg *v, Reg *s)                               \
 {                                                             \
     uint8_t r[PACK_WIDTH * 2];                                \
@@ -1199,7 +1200,7 @@ void glue(helper_pack ## name, SUFFIX)(CPUX86State *env,      \
 PACK_HELPER_B(sswb, satsb)
 PACK_HELPER_B(uswb, satub)
 
-void glue(helper_packssdw, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(packssdw), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     uint16_t r[PACK_WIDTH];
     int j, k;
@@ -1219,7 +1220,7 @@ void glue(helper_packssdw, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 
 #define UNPCK_OP(base_name, base)                                       \
                                                                         \
-    void glue(helper_punpck ## base_name ## bw, SUFFIX)(CPUX86State *env,\
+    void HELPER(glue(punpck ## base_name ## bw, SUFFIX))(CPUX86State *env, \
                                                 Reg *d, Reg *v, Reg *s) \
     {                                                                   \
         uint8_t r[PACK_WIDTH * 2];                                      \
@@ -1237,7 +1238,7 @@ void glue(helper_packssdw, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
         }                                                               \
     }                                                                   \
                                                                         \
-    void glue(helper_punpck ## base_name ## wd, SUFFIX)(CPUX86State *env,\
+    void HELPER(glue(punpck ## base_name ## wd, SUFFIX))(CPUX86State *env, \
                                                 Reg *d, Reg *v, Reg *s) \
     {                                                                   \
         uint16_t r[PACK_WIDTH];                                         \
@@ -1255,7 +1256,7 @@ void glue(helper_packssdw, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
         }                                                               \
     }                                                                   \
                                                                         \
-    void glue(helper_punpck ## base_name ## dq, SUFFIX)(CPUX86State *env,\
+    void HELPER(glue(punpck ## base_name ## dq, SUFFIX))(CPUX86State *env, \
                                                 Reg *d, Reg *v, Reg *s) \
     {                                                                   \
         uint32_t r[PACK_WIDTH / 2];                                     \
@@ -1274,7 +1275,7 @@ void glue(helper_packssdw, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
     }                                                                   \
                                                                         \
     XMM_ONLY(                                                           \
-             void glue(helper_punpck ## base_name ## qdq, SUFFIX)(      \
+             void HELPER(glue(punpck ## base_name ## qdq, SUFFIX))(     \
                         CPUX86State *env, Reg *d, Reg *v, Reg *s)       \
              {                                                          \
                  uint64_t r[2];                                         \
@@ -1299,25 +1300,25 @@ UNPCK_OP(h, 1)
 
 /* 3DNow! float ops */
 #if SHIFT == 0
-void helper_pi2fd(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pi2fd)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     d->MMX_S(0) = int32_to_float32(s->MMX_L(0), &env->mmx_status);
     d->MMX_S(1) = int32_to_float32(s->MMX_L(1), &env->mmx_status);
 }
 
-void helper_pi2fw(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pi2fw)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     d->MMX_S(0) = int32_to_float32((int16_t)s->MMX_W(0), &env->mmx_status);
     d->MMX_S(1) = int32_to_float32((int16_t)s->MMX_W(2), &env->mmx_status);
 }
 
-void helper_pf2id(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pf2id)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     d->MMX_L(0) = float32_to_int32_round_to_zero(s->MMX_S(0), &env->mmx_status);
     d->MMX_L(1) = float32_to_int32_round_to_zero(s->MMX_S(1), &env->mmx_status);
 }
 
-void helper_pf2iw(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pf2iw)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     d->MMX_L(0) = satsw(float32_to_int32_round_to_zero(s->MMX_S(0),
                                                        &env->mmx_status));
@@ -1325,7 +1326,7 @@ void helper_pf2iw(CPUX86State *env, MMXReg *d, MMXReg *s)
                                                        &env->mmx_status));
 }
 
-void helper_pfacc(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pfacc)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     float32 r;
 
@@ -1334,13 +1335,13 @@ void helper_pfacc(CPUX86State *env, MMXReg *d, MMXReg *s)
     d->MMX_S(0) = r;
 }
 
-void helper_pfadd(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pfadd)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     d->MMX_S(0) = float32_add(d->MMX_S(0), s->MMX_S(0), &env->mmx_status);
     d->MMX_S(1) = float32_add(d->MMX_S(1), s->MMX_S(1), &env->mmx_status);
 }
 
-void helper_pfcmpeq(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pfcmpeq)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     d->MMX_L(0) = float32_eq_quiet(d->MMX_S(0), s->MMX_S(0),
                                    &env->mmx_status) ? -1 : 0;
@@ -1348,7 +1349,7 @@ void helper_pfcmpeq(CPUX86State *env, MMXReg *d, MMXReg *s)
                                    &env->mmx_status) ? -1 : 0;
 }
 
-void helper_pfcmpge(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pfcmpge)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     d->MMX_L(0) = float32_le(s->MMX_S(0), d->MMX_S(0),
                              &env->mmx_status) ? -1 : 0;
@@ -1356,7 +1357,7 @@ void helper_pfcmpge(CPUX86State *env, MMXReg *d, MMXReg *s)
                              &env->mmx_status) ? -1 : 0;
 }
 
-void helper_pfcmpgt(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pfcmpgt)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     d->MMX_L(0) = float32_lt(s->MMX_S(0), d->MMX_S(0),
                              &env->mmx_status) ? -1 : 0;
@@ -1364,7 +1365,7 @@ void helper_pfcmpgt(CPUX86State *env, MMXReg *d, MMXReg *s)
                              &env->mmx_status) ? -1 : 0;
 }
 
-void helper_pfmax(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pfmax)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     if (float32_lt(d->MMX_S(0), s->MMX_S(0), &env->mmx_status)) {
         d->MMX_S(0) = s->MMX_S(0);
@@ -1374,7 +1375,7 @@ void helper_pfmax(CPUX86State *env, MMXReg *d, MMXReg *s)
     }
 }
 
-void helper_pfmin(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pfmin)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     if (float32_lt(s->MMX_S(0), d->MMX_S(0), &env->mmx_status)) {
         d->MMX_S(0) = s->MMX_S(0);
@@ -1384,13 +1385,13 @@ void helper_pfmin(CPUX86State *env, MMXReg *d, MMXReg *s)
     }
 }
 
-void helper_pfmul(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pfmul)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     d->MMX_S(0) = float32_mul(d->MMX_S(0), s->MMX_S(0), &env->mmx_status);
     d->MMX_S(1) = float32_mul(d->MMX_S(1), s->MMX_S(1), &env->mmx_status);
 }
 
-void helper_pfnacc(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pfnacc)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     float32 r;
 
@@ -1399,7 +1400,7 @@ void helper_pfnacc(CPUX86State *env, MMXReg *d, MMXReg *s)
     d->MMX_S(0) = r;
 }
 
-void helper_pfpnacc(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pfpnacc)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     float32 r;
 
@@ -1408,13 +1409,13 @@ void helper_pfpnacc(CPUX86State *env, MMXReg *d, MMXReg *s)
     d->MMX_S(0) = r;
 }
 
-void helper_pfrcp(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pfrcp)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     d->MMX_S(0) = float32_div(float32_one, s->MMX_S(0), &env->mmx_status);
     d->MMX_S(1) = d->MMX_S(0);
 }
 
-void helper_pfrsqrt(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pfrsqrt)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     d->MMX_L(1) = s->MMX_L(0) & 0x7fffffff;
     d->MMX_S(1) = float32_div(float32_one,
@@ -1424,19 +1425,19 @@ void helper_pfrsqrt(CPUX86State *env, MMXReg *d, MMXReg *s)
     d->MMX_L(0) = d->MMX_L(1);
 }
 
-void helper_pfsub(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pfsub)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     d->MMX_S(0) = float32_sub(d->MMX_S(0), s->MMX_S(0), &env->mmx_status);
     d->MMX_S(1) = float32_sub(d->MMX_S(1), s->MMX_S(1), &env->mmx_status);
 }
 
-void helper_pfsubr(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pfsubr)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     d->MMX_S(0) = float32_sub(s->MMX_S(0), d->MMX_S(0), &env->mmx_status);
     d->MMX_S(1) = float32_sub(s->MMX_S(1), d->MMX_S(1), &env->mmx_status);
 }
 
-void helper_pswapd(CPUX86State *env, MMXReg *d, MMXReg *s)
+void HELPER(pswapd)(CPUX86State *env, MMXReg *d, MMXReg *s)
 {
     uint32_t r;
 
@@ -1447,7 +1448,7 @@ void helper_pswapd(CPUX86State *env, MMXReg *d, MMXReg *s)
 #endif
 
 /* SSSE3 op helpers */
-void glue(helper_pshufb, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(pshufb), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     int i;
 #if SHIFT == 0
@@ -1473,7 +1474,7 @@ void glue(helper_pshufb, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 }
 
 #define SSE_HELPER_HW(name, F)  \
-void glue(helper_ ## name, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s) \
+void HELPER(glue(name, SUFFIX))(CPUX86State *env, Reg *d, Reg *v, Reg *s)    \
 {                                                          \
     uint16_t r[4 << SHIFT];                                \
     int i, j, k;                                           \
@@ -1491,7 +1492,7 @@ void glue(helper_ ## name, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s) \
 }
 
 #define SSE_HELPER_HL(name, F)  \
-void glue(helper_ ## name, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s) \
+void HELPER(glue(name, SUFFIX))(CPUX86State *env, Reg *d, Reg *v, Reg *s)    \
 {                                                          \
     uint32_t r[2 << SHIFT];                                \
     int i, j, k;                                           \
@@ -1518,7 +1519,7 @@ SSE_HELPER_HL(phsubd, FSUB)
 #undef SSE_HELPER_HW
 #undef SSE_HELPER_HL
 
-void glue(helper_pmaddubsw, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(pmaddubsw), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     int i;
     for (i = 0; i < 4 << SHIFT; i++) {
@@ -1528,16 +1529,16 @@ void glue(helper_pmaddubsw, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 }
 
 #define FMULHRSW(d, s) (((int16_t) d * (int16_t)s + 0x4000) >> 15)
-SSE_HELPER_W(helper_pmulhrsw, FMULHRSW)
+SSE_HELPER_W(HELPER(pmulhrsw), FMULHRSW)
 
 #define FSIGNB(d, s) (s <= INT8_MAX  ? s ? d : 0 : -(int8_t)d)
 #define FSIGNW(d, s) (s <= INT16_MAX ? s ? d : 0 : -(int16_t)d)
 #define FSIGNL(d, s) (s <= INT32_MAX ? s ? d : 0 : -(int32_t)d)
-SSE_HELPER_B(helper_psignb, FSIGNB)
-SSE_HELPER_W(helper_psignw, FSIGNW)
-SSE_HELPER_L(helper_psignd, FSIGNL)
+SSE_HELPER_B(HELPER(psignb), FSIGNB)
+SSE_HELPER_W(HELPER(psignw), FSIGNW)
+SSE_HELPER_L(HELPER(psignd), FSIGNL)
 
-void glue(helper_palignr, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
+void glue(HELPER(palignr), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
                                   uint32_t imm)
 {
     int i;
@@ -1600,11 +1601,11 @@ void glue(helper_palignr, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
 #define FBLENDVB(v, s, m) ((m & 0x80) ? s : v)
 #define FBLENDVPS(v, s, m) ((m & 0x80000000) ? s : v)
 #define FBLENDVPD(v, s, m) ((m & 0x8000000000000000LL) ? s : v)
-SSE_HELPER_V(helper_pblendvb, B, 8 << SHIFT, FBLENDVB)
-SSE_HELPER_V(helper_blendvps, L, 2 << SHIFT, FBLENDVPS)
-SSE_HELPER_V(helper_blendvpd, Q, 1 << SHIFT, FBLENDVPD)
+SSE_HELPER_V(HELPER(pblendvb), B, 8 << SHIFT, FBLENDVB)
+SSE_HELPER_V(HELPER(blendvps), L, 2 << SHIFT, FBLENDVPS)
+SSE_HELPER_V(HELPER(blendvpd), Q, 1 << SHIFT, FBLENDVPD)
 
-void glue(helper_ptest, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(HELPER(ptest), SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
     uint64_t zf = 0, cf = 0;
     int i;
@@ -1631,24 +1632,24 @@ void glue(helper_ptest, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
     }
 
 #if SHIFT > 0
-SSE_HELPER_F(helper_pmovsxbw, W, 4 << SHIFT, (int8_t) s->B)
-SSE_HELPER_F(helper_pmovsxbd, L, 2 << SHIFT, (int8_t) s->B)
-SSE_HELPER_F(helper_pmovsxbq, Q, 1 << SHIFT, (int8_t) s->B)
-SSE_HELPER_F(helper_pmovsxwd, L, 2 << SHIFT, (int16_t) s->W)
-SSE_HELPER_F(helper_pmovsxwq, Q, 1 << SHIFT, (int16_t) s->W)
-SSE_HELPER_F(helper_pmovsxdq, Q, 1 << SHIFT, (int32_t) s->L)
-SSE_HELPER_F(helper_pmovzxbw, W, 4 << SHIFT, s->B)
-SSE_HELPER_F(helper_pmovzxbd, L, 2 << SHIFT, s->B)
-SSE_HELPER_F(helper_pmovzxbq, Q, 1 << SHIFT, s->B)
-SSE_HELPER_F(helper_pmovzxwd, L, 2 << SHIFT, s->W)
-SSE_HELPER_F(helper_pmovzxwq, Q, 1 << SHIFT, s->W)
-SSE_HELPER_F(helper_pmovzxdq, Q, 1 << SHIFT, s->L)
-SSE_HELPER_F(helper_pmovsldup, L, 2 << SHIFT, FMOVSLDUP)
-SSE_HELPER_F(helper_pmovshdup, L, 2 << SHIFT, FMOVSHDUP)
-SSE_HELPER_F(helper_pmovdldup, Q, 1 << SHIFT, FMOVDLDUP)
+SSE_HELPER_F(HELPER(pmovsxbw), W, 4 << SHIFT, (int8_t) s->B)
+SSE_HELPER_F(HELPER(pmovsxbd), L, 2 << SHIFT, (int8_t) s->B)
+SSE_HELPER_F(HELPER(pmovsxbq), Q, 1 << SHIFT, (int8_t) s->B)
+SSE_HELPER_F(HELPER(pmovsxwd), L, 2 << SHIFT, (int16_t) s->W)
+SSE_HELPER_F(HELPER(pmovsxwq), Q, 1 << SHIFT, (int16_t) s->W)
+SSE_HELPER_F(HELPER(pmovsxdq), Q, 1 << SHIFT, (int32_t) s->L)
+SSE_HELPER_F(HELPER(pmovzxbw), W, 4 << SHIFT, s->B)
+SSE_HELPER_F(HELPER(pmovzxbd), L, 2 << SHIFT, s->B)
+SSE_HELPER_F(HELPER(pmovzxbq), Q, 1 << SHIFT, s->B)
+SSE_HELPER_F(HELPER(pmovzxwd), L, 2 << SHIFT, s->W)
+SSE_HELPER_F(HELPER(pmovzxwq), Q, 1 << SHIFT, s->W)
+SSE_HELPER_F(HELPER(pmovzxdq), Q, 1 << SHIFT, s->L)
+SSE_HELPER_F(HELPER(pmovsldup), L, 2 << SHIFT, FMOVSLDUP)
+SSE_HELPER_F(HELPER(pmovshdup), L, 2 << SHIFT, FMOVSHDUP)
+SSE_HELPER_F(HELPER(pmovdldup), Q, 1 << SHIFT, FMOVDLDUP)
 #endif
 
-void glue(helper_pmuldq, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(pmuldq), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     int i;
 
@@ -1657,7 +1658,7 @@ void glue(helper_pmuldq, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
     }
 }
 
-void glue(helper_packusdw, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(packusdw), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     uint16_t r[8];
     int i, j, k;
@@ -1678,7 +1679,7 @@ void glue(helper_packusdw, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 }
 
 #if SHIFT == 1
-void glue(helper_phminposuw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(HELPER(phminposuw), SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
     int idx = 0;
 
@@ -1711,7 +1712,7 @@ void glue(helper_phminposuw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 }
 #endif
 
-void glue(helper_roundps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
+void glue(HELPER(roundps), SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                   uint32_t mode)
 {
     int old_flags = get_float_exception_flags(&env->sse_status);
@@ -1734,7 +1735,7 @@ void glue(helper_roundps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
     set_float_rounding_mode(prev_rounding_mode, &env->sse_status);
 }
 
-void glue(helper_roundpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
+void glue(HELPER(roundpd), SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                   uint32_t mode)
 {
     int old_flags = get_float_exception_flags(&env->sse_status);
@@ -1758,7 +1759,7 @@ void glue(helper_roundpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
 }
 
 #if SHIFT == 1
-void glue(helper_roundss, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
+void glue(HELPER(roundss), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
                                   uint32_t mode)
 {
     int old_flags = get_float_exception_flags(&env->sse_status);
@@ -1782,7 +1783,7 @@ void glue(helper_roundss, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
     set_float_rounding_mode(prev_rounding_mode, &env->sse_status);
 }
 
-void glue(helper_roundsd, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
+void glue(HELPER(roundsd), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
                                   uint32_t mode)
 {
     int old_flags = get_float_exception_flags(&env->sse_status);
@@ -1808,11 +1809,11 @@ void glue(helper_roundsd, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
 #endif
 
 #define FBLENDP(v, s, m) (m ? s : v)
-SSE_HELPER_I(helper_blendps, L, 2 << SHIFT, FBLENDP)
-SSE_HELPER_I(helper_blendpd, Q, 1 << SHIFT, FBLENDP)
-SSE_HELPER_I(helper_pblendw, W, 4 << SHIFT, FBLENDP)
+SSE_HELPER_I(HELPER(blendps), L, 2 << SHIFT, FBLENDP)
+SSE_HELPER_I(HELPER(blendpd), Q, 1 << SHIFT, FBLENDP)
+SSE_HELPER_I(HELPER(pblendw), W, 4 << SHIFT, FBLENDP)
 
-void glue(helper_dpps, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
+void glue(HELPER(dpps), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
                                uint32_t mask)
 {
     float32 prod1, prod2, temp2, temp3, temp4;
@@ -1856,7 +1857,7 @@ void glue(helper_dpps, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
 
 #if SHIFT == 1
 /* Oddly, there is no ymm version of dppd */
-void glue(helper_dppd, SUFFIX)(CPUX86State *env,
+void glue(HELPER(dppd), SUFFIX)(CPUX86State *env,
                                Reg *d, Reg *v, Reg *s, uint32_t mask)
 {
     float64 prod1, prod2, temp2;
@@ -1877,7 +1878,7 @@ void glue(helper_dppd, SUFFIX)(CPUX86State *env,
 }
 #endif
 
-void glue(helper_mpsadbw, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
+void glue(HELPER(mpsadbw), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
                                   uint32_t offset)
 {
     int i, j;
@@ -2033,7 +2034,7 @@ static inline unsigned pcmpxstrx(CPUX86State *env, Reg *d, Reg *s,
     return res;
 }
 
-void glue(helper_pcmpestri, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
+void glue(HELPER(pcmpestri), SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                     uint32_t ctrl)
 {
     unsigned int res = pcmpxstrx(env, d, s, ctrl,
@@ -2047,7 +2048,7 @@ void glue(helper_pcmpestri, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
     }
 }
 
-void glue(helper_pcmpestrm, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
+void glue(HELPER(pcmpestrm), SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                     uint32_t ctrl)
 {
     int i;
@@ -2071,7 +2072,7 @@ void glue(helper_pcmpestrm, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
     }
 }
 
-void glue(helper_pcmpistri, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
+void glue(HELPER(pcmpistri), SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                     uint32_t ctrl)
 {
     unsigned int res = pcmpxstrx(env, d, s, ctrl,
@@ -2085,7 +2086,7 @@ void glue(helper_pcmpistri, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
     }
 }
 
-void glue(helper_pcmpistrm, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
+void glue(HELPER(pcmpistrm), SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                     uint32_t ctrl)
 {
     int i;
@@ -2111,7 +2112,7 @@ void glue(helper_pcmpistrm, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
 
 #define CRCPOLY        0x1edc6f41
 #define CRCPOLY_BITREV 0x82f63b78
-target_ulong helper_crc32(uint32_t crc1, target_ulong msg, uint32_t len)
+target_ulong HELPER(crc32)(uint32_t crc1, target_ulong msg, uint32_t len)
 {
     target_ulong crc = (msg & ((target_ulong) -1 >>
                                (TARGET_LONG_BITS - len))) ^ crc1;
@@ -2125,7 +2126,7 @@ target_ulong helper_crc32(uint32_t crc1, target_ulong msg, uint32_t len)
 
 #endif
 
-void glue(helper_pclmulqdq, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
+void glue(HELPER(pclmulqdq), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
                                     uint32_t ctrl)
 {
     int a_idx = (ctrl & 1) != 0;
@@ -2140,7 +2141,7 @@ void glue(helper_pclmulqdq, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
     }
 }
 
-void glue(helper_aesdec, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(aesdec), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     for (int i = 0; i < SHIFT; i++) {
         AESState *ad = (AESState *)&d->ZMM_X(i);
@@ -2151,7 +2152,7 @@ void glue(helper_aesdec, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
     }
 }
 
-void glue(helper_aesdeclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(aesdeclast), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     for (int i = 0; i < SHIFT; i++) {
         AESState *ad = (AESState *)&d->ZMM_X(i);
@@ -2162,7 +2163,7 @@ void glue(helper_aesdeclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
     }
 }
 
-void glue(helper_aesenc, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(aesenc), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     for (int i = 0; i < SHIFT; i++) {
         AESState *ad = (AESState *)&d->ZMM_X(i);
@@ -2173,7 +2174,7 @@ void glue(helper_aesenc, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
     }
 }
 
-void glue(helper_aesenclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(aesenclast), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     for (int i = 0; i < SHIFT; i++) {
         AESState *ad = (AESState *)&d->ZMM_X(i);
@@ -2185,7 +2186,7 @@ void glue(helper_aesenclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 }
 
 #if SHIFT == 1
-void glue(helper_aesimc, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(HELPER(aesimc), SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
     AESState *ad = (AESState *)&d->ZMM_X(0);
     AESState *st = (AESState *)&s->ZMM_X(0);
@@ -2193,7 +2194,7 @@ void glue(helper_aesimc, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
     aesdec_IMC(ad, st, false);
 }
 
-void glue(helper_aeskeygenassist, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
+void glue(HELPER(aeskeygenassist), SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                           uint32_t ctrl)
 {
     int i;
@@ -2210,7 +2211,7 @@ void glue(helper_aeskeygenassist, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
 #endif
 
 #if SHIFT >= 1
-void glue(helper_vpermilpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(vpermilpd), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     uint64_t r0, r1;
     int i;
@@ -2223,7 +2224,7 @@ void glue(helper_vpermilpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
     }
 }
 
-void glue(helper_vpermilps, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(vpermilps), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     uint32_t r0, r1, r2, r3;
     int i;
@@ -2240,7 +2241,7 @@ void glue(helper_vpermilps, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
     }
 }
 
-void glue(helper_vpermilpd_imm, SUFFIX)(Reg *d, Reg *s, uint32_t order)
+void glue(HELPER(vpermilpd_imm), SUFFIX)(Reg *d, Reg *s, uint32_t order)
 {
     uint64_t r0, r1;
     int i;
@@ -2255,7 +2256,7 @@ void glue(helper_vpermilpd_imm, SUFFIX)(Reg *d, Reg *s, uint32_t order)
     }
 }
 
-void glue(helper_vpermilps_imm, SUFFIX)(Reg *d, Reg *s, uint32_t order)
+void glue(HELPER(vpermilps_imm), SUFFIX)(Reg *d, Reg *s, uint32_t order)
 {
     uint32_t r0, r1, r2, r3;
     int i;
@@ -2281,15 +2282,15 @@ void glue(helper_vpermilps_imm, SUFFIX)(Reg *d, Reg *s, uint32_t order)
 #define FPSLLVQ(x, c) (c < 64 ? ((x) << c) : 0)
 #endif
 
-SSE_HELPER_L(helper_vpsrlvd, FPSRLVD)
-SSE_HELPER_L(helper_vpsravd, FPSRAVD)
-SSE_HELPER_L(helper_vpsllvd, FPSLLVD)
+SSE_HELPER_L(HELPER(vpsrlvd), FPSRLVD)
+SSE_HELPER_L(HELPER(vpsravd), FPSRAVD)
+SSE_HELPER_L(HELPER(vpsllvd), FPSLLVD)
 
-SSE_HELPER_Q(helper_vpsrlvq, FPSRLVQ)
-SSE_HELPER_Q(helper_vpsravq, FPSRAVQ)
-SSE_HELPER_Q(helper_vpsllvq, FPSLLVQ)
+SSE_HELPER_Q(HELPER(vpsrlvq), FPSRLVQ)
+SSE_HELPER_Q(HELPER(vpsravq), FPSRAVQ)
+SSE_HELPER_Q(HELPER(vpsllvq), FPSLLVQ)
 
-void glue(helper_vtestps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(HELPER(vtestps), SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
     uint32_t zf = 0, cf = 0;
     int i;
@@ -2302,7 +2303,7 @@ void glue(helper_vtestps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
     CC_OP = CC_OP_EFLAGS;
 }
 
-void glue(helper_vtestpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
+void glue(HELPER(vtestpd), SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
     uint64_t zf = 0, cf = 0;
     int i;
@@ -2315,7 +2316,7 @@ void glue(helper_vtestpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
     CC_OP = CC_OP_EFLAGS;
 }
 
-void glue(helper_vpmaskmovd_st, SUFFIX)(CPUX86State *env,
+void glue(HELPER(vpmaskmovd_st), SUFFIX)(CPUX86State *env,
                                         Reg *v, Reg *s, target_ulong a0)
 {
     int i;
@@ -2327,7 +2328,7 @@ void glue(helper_vpmaskmovd_st, SUFFIX)(CPUX86State *env,
     }
 }
 
-void glue(helper_vpmaskmovq_st, SUFFIX)(CPUX86State *env,
+void glue(HELPER(vpmaskmovq_st), SUFFIX)(CPUX86State *env,
                                         Reg *v, Reg *s, target_ulong a0)
 {
     int i;
@@ -2339,7 +2340,7 @@ void glue(helper_vpmaskmovq_st, SUFFIX)(CPUX86State *env,
     }
 }
 
-void glue(helper_vpmaskmovd, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(vpmaskmovd), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     int i;
 
@@ -2348,7 +2349,7 @@ void glue(helper_vpmaskmovd, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
     }
 }
 
-void glue(helper_vpmaskmovq, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
+void glue(HELPER(vpmaskmovq), SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
     int i;
 
@@ -2357,7 +2358,7 @@ void glue(helper_vpmaskmovq, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
     }
 }
 
-void glue(helper_vpgatherdd, SUFFIX)(CPUX86State *env,
+void glue(HELPER(vpgatherdd), SUFFIX)(CPUX86State *env,
         Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale, target_ulong amask)
 {
     int i;
@@ -2371,7 +2372,7 @@ void glue(helper_vpgatherdd, SUFFIX)(CPUX86State *env,
     }
 }
 
-void glue(helper_vpgatherdq, SUFFIX)(CPUX86State *env,
+void glue(HELPER(vpgatherdq), SUFFIX)(CPUX86State *env,
         Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale, target_ulong amask)
 {
     int i;
@@ -2385,7 +2386,7 @@ void glue(helper_vpgatherdq, SUFFIX)(CPUX86State *env,
     }
 }
 
-void glue(helper_vpgatherqd, SUFFIX)(CPUX86State *env,
+void glue(HELPER(vpgatherqd), SUFFIX)(CPUX86State *env,
         Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale, target_ulong amask)
 {
     int i;
@@ -2403,7 +2404,7 @@ void glue(helper_vpgatherqd, SUFFIX)(CPUX86State *env,
     }
 }
 
-void glue(helper_vpgatherqq, SUFFIX)(CPUX86State *env,
+void glue(HELPER(vpgatherqq), SUFFIX)(CPUX86State *env,
         Reg *d, Reg *v, Reg *s, target_ulong a0, unsigned scale, target_ulong amask)
 {
     int i;
@@ -2419,7 +2420,7 @@ void glue(helper_vpgatherqq, SUFFIX)(CPUX86State *env,
 #endif
 
 #if SHIFT >= 2
-void helper_vpermdq_ymm(Reg *d, Reg *v, Reg *s, uint32_t order)
+void HELPER(vpermdq_ymm)(Reg *d, Reg *v, Reg *s, uint32_t order)
 {
     uint64_t r0, r1, r2, r3;
 
@@ -2477,7 +2478,7 @@ void helper_vpermdq_ymm(Reg *d, Reg *v, Reg *s, uint32_t order)
     }
 }
 
-void helper_vpermq_ymm(Reg *d, Reg *s, uint32_t order)
+void HELPER(vpermq_ymm)(Reg *d, Reg *s, uint32_t order)
 {
     uint64_t r0, r1, r2, r3;
     r0 = s->Q(order & 3);
@@ -2490,7 +2491,7 @@ void helper_vpermq_ymm(Reg *d, Reg *s, uint32_t order)
     d->Q(3) = r3;
 }
 
-void helper_vpermd_ymm(Reg *d, Reg *v, Reg *s)
+void HELPER(vpermd_ymm)(Reg *d, Reg *v, Reg *s)
 {
     uint32_t r[8];
     int i;
@@ -2522,13 +2523,13 @@ void helper_vpermd_ymm(Reg *d, Reg *v, Reg *s)
         }                                                                      \
     }
 
-SSE_HELPER_FMAS(helper_fma4ss,  ZMM_S, float32_muladd)
-SSE_HELPER_FMAS(helper_fma4sd,  ZMM_D, float64_muladd)
+SSE_HELPER_FMAS(HELPER(fma4ss),  ZMM_S, float32_muladd)
+SSE_HELPER_FMAS(HELPER(fma4sd),  ZMM_D, float64_muladd)
 #endif
 
 #if SHIFT >= 1
-SSE_HELPER_FMAP(helper_fma4ps,  ZMM_S, 2 << SHIFT, float32_muladd)
-SSE_HELPER_FMAP(helper_fma4pd,  ZMM_D, 1 << SHIFT, float64_muladd)
+SSE_HELPER_FMAP(HELPER(fma4ps),  ZMM_S, 2 << SHIFT, float32_muladd)
+SSE_HELPER_FMAP(HELPER(fma4pd),  ZMM_D, 1 << SHIFT, float64_muladd)
 #endif
 
 #if SHIFT == 1
@@ -2562,12 +2563,12 @@ SSE_HELPER_FMAP(helper_fma4pd,  ZMM_D, 1 << SHIFT, float64_muladd)
 #define SHA1_F1(b, c, d) ((b) ^ (c) ^ (d))
 #define SHA1_F2(b, c, d) (((b) & (c)) ^ ((b) & (d)) ^ ((c) & (d)))
 
-SSE_HELPER_SHA1RNDS4(helper_sha1rnds4_f0, SHA1_F0, 0x5A827999)
-SSE_HELPER_SHA1RNDS4(helper_sha1rnds4_f1, SHA1_F1, 0x6ED9EBA1)
-SSE_HELPER_SHA1RNDS4(helper_sha1rnds4_f2, SHA1_F2, 0x8F1BBCDC)
-SSE_HELPER_SHA1RNDS4(helper_sha1rnds4_f3, SHA1_F1, 0xCA62C1D6)
+SSE_HELPER_SHA1RNDS4(HELPER(sha1rnds4_f0), SHA1_F0, 0x5A827999)
+SSE_HELPER_SHA1RNDS4(HELPER(sha1rnds4_f1), SHA1_F1, 0x6ED9EBA1)
+SSE_HELPER_SHA1RNDS4(HELPER(sha1rnds4_f2), SHA1_F2, 0x8F1BBCDC)
+SSE_HELPER_SHA1RNDS4(HELPER(sha1rnds4_f3), SHA1_F1, 0xCA62C1D6)
 
-void helper_sha1nexte(Reg *d, Reg *a, Reg *b)
+void HELPER(sha1nexte)(Reg *d, Reg *a, Reg *b)
 {
     d->L(3) = b->L(3) + rol32(a->L(3), 30);
     d->L(2) = b->L(2);
@@ -2575,7 +2576,7 @@ void helper_sha1nexte(Reg *d, Reg *a, Reg *b)
     d->L(0) = b->L(0);
 }
 
-void helper_sha1msg1(Reg *d, Reg *a, Reg *b)
+void HELPER(sha1msg1)(Reg *d, Reg *a, Reg *b)
 {
     /* These could be overwritten by the first two assignments, save them.  */
     uint32_t b3 = b->L(3);
@@ -2587,7 +2588,7 @@ void helper_sha1msg1(Reg *d, Reg *a, Reg *b)
     d->L(0) = a->L(0) ^ b2;
 }
 
-void helper_sha1msg2(Reg *d, Reg *a, Reg *b)
+void HELPER(sha1msg2)(Reg *d, Reg *a, Reg *b)
 {
     d->L(3) = rol32(a->L(3) ^ b->L(2), 1);
     d->L(2) = rol32(a->L(2) ^ b->L(1), 1);
@@ -2603,7 +2604,7 @@ void helper_sha1msg2(Reg *d, Reg *a, Reg *b)
 #define SHA256_MSGS0(w) (ror32((w), 7) ^ ror32((w), 18) ^ ((w) >> 3))
 #define SHA256_MSGS1(w) (ror32((w), 17) ^ ror32((w), 19) ^ ((w) >> 10))
 
-void helper_sha256rnds2(Reg *d, Reg *a, Reg *b, uint32_t wk0, uint32_t wk1)
+void HELPER(sha256rnds2)(Reg *d, Reg *a, Reg *b, uint32_t wk0, uint32_t wk1)
 {
     uint32_t t, AA, EE;
 
@@ -2637,7 +2638,7 @@ void helper_sha256rnds2(Reg *d, Reg *a, Reg *b, uint32_t wk0, uint32_t wk1)
     d->L(1) = EE;
 }
 
-void helper_sha256msg1(Reg *d, Reg *a, Reg *b)
+void HELPER(sha256msg1)(Reg *d, Reg *a, Reg *b)
 {
     /* b->L(0) could be overwritten by the first assignment, save it.  */
     uint32_t b0 = b->L(0);
@@ -2648,7 +2649,7 @@ void helper_sha256msg1(Reg *d, Reg *a, Reg *b)
     d->L(3) = a->L(3) + SHA256_MSGS0(b0);
 }
 
-void helper_sha256msg2(Reg *d, Reg *a, Reg *b)
+void HELPER(sha256msg2)(Reg *d, Reg *a, Reg *b)
 {
     /* Earlier assignments cannot overwrite any of the two operands.  */
     d->L(0) = a->L(0) + SHA256_MSGS1(b->L(2));
diff --git a/target/i386/tcg/bpt_helper.c b/target/i386/tcg/bpt_helper.c
index bc34ac27fea..573f74bcb45 100644
--- a/target/i386/tcg/bpt_helper.c
+++ b/target/i386/tcg/bpt_helper.c
@@ -22,7 +22,7 @@
 #include "exec/helper-proto.h"
 #include "helper-tcg.h"
 
-G_NORETURN void helper_single_step(CPUX86State *env)
+G_NORETURN void HELPER(single_step)(CPUX86State *env)
 {
 #ifndef CONFIG_USER_ONLY
     check_hw_breakpoints(env, true);
@@ -31,9 +31,9 @@ G_NORETURN void helper_single_step(CPUX86State *env)
     raise_exception(env, EXCP01_DB);
 }
 
-void helper_rechecking_single_step(CPUX86State *env)
+void HELPER(rechecking_single_step)(CPUX86State *env)
 {
     if ((env->eflags & TF_MASK) != 0) {
-        helper_single_step(env);
+        HELPER(single_step)(env);
     }
 }
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index b868ef2949f..d9fcd2d9203 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -60,7 +60,7 @@ static target_ulong compute_all_adcox(target_ulong dst, target_ulong src1,
     return (src1 & ~(CC_C | CC_O)) | (dst * CC_C) | (src2 * CC_O);
 }
 
-target_ulong helper_cc_compute_nz(target_ulong dst, target_ulong src1,
+target_ulong HELPER(cc_compute_nz)(target_ulong dst, target_ulong src1,
                                   int op)
 {
     if (CC_OP_HAS_EFLAGS(op)) {
@@ -86,7 +86,7 @@ static inline uint32_t compute_aco_mul(target_long src1)
     return cf + af + of;
 }
 
-target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
+target_ulong HELPER(cc_compute_all)(target_ulong dst, target_ulong src1,
                                    target_ulong src2, int op)
 {
     uint32_t flags = 0;
@@ -300,10 +300,10 @@ psz_q:
 
 uint32_t cpu_cc_compute_all(CPUX86State *env)
 {
-    return helper_cc_compute_all(CC_DST, CC_SRC, CC_SRC2, CC_OP);
+    return HELPER(cc_compute_all)(CC_DST, CC_SRC, CC_SRC2, CC_OP);
 }
 
-target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
+target_ulong HELPER(cc_compute_c)(target_ulong dst, target_ulong src1,
                                  target_ulong src2, int op)
 {
     switch (op) {
@@ -418,13 +418,13 @@ target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
     }
 }
 
-void helper_write_eflags(CPUX86State *env, target_ulong t0,
+void HELPER(write_eflags)(CPUX86State *env, target_ulong t0,
                          uint32_t update_mask)
 {
     cpu_load_eflags(env, t0, update_mask);
 }
 
-target_ulong helper_read_eflags(CPUX86State *env)
+target_ulong HELPER(read_eflags)(CPUX86State *env)
 {
     uint32_t eflags;
 
@@ -436,7 +436,7 @@ target_ulong helper_read_eflags(CPUX86State *env)
     return eflags;
 }
 
-void helper_clts(CPUX86State *env)
+void HELPER(clts)(CPUX86State *env)
 {
     env->cr[0] &= ~CR0_TS_MASK;
     env->hflags &= ~HF_TS_MASK;
diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index d6410d6fc11..bff67a35fec 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -26,18 +26,18 @@
 #include "helper-tcg.h"
 #include "qemu/plugin.h"
 
-G_NORETURN void helper_raise_interrupt(CPUX86State *env, int intno,
+G_NORETURN void HELPER(raise_interrupt)(CPUX86State *env, int intno,
                                           int next_eip_addend)
 {
     raise_interrupt(env, intno, next_eip_addend);
 }
 
-G_NORETURN void helper_raise_exception(CPUX86State *env, int exception_index)
+G_NORETURN void HELPER(raise_exception)(CPUX86State *env, int exception_index)
 {
     raise_exception(env, exception_index);
 }
 
-G_NORETURN void helper_raise_gpf(CPUX86State *env)
+G_NORETURN void HELPER(raise_gpf)(CPUX86State *env)
 {
     raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
 }
@@ -148,7 +148,7 @@ G_NORETURN void raise_exception_ra(CPUX86State *env, int exception_index,
     raise_interrupt2(env, exception_index, 0, 0, 0, retaddr);
 }
 
-G_NORETURN void helper_icebp(CPUX86State *env)
+G_NORETURN void HELPER(icebp)(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
 
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 4bbac996326..ef4ca2a0c46 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -238,7 +238,7 @@ static void fpu_raise_exception(CPUX86State *env, uintptr_t retaddr)
 #endif
 }
 
-void helper_flds_FT0(CPUX86State *env, uint32_t val)
+void HELPER(flds_FT0)(CPUX86State *env, uint32_t val)
 {
     int old_flags = save_exception_flags(env);
     union {
@@ -251,7 +251,7 @@ void helper_flds_FT0(CPUX86State *env, uint32_t val)
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fldl_FT0(CPUX86State *env, uint64_t val)
+void HELPER(fldl_FT0)(CPUX86State *env, uint64_t val)
 {
     int old_flags = save_exception_flags(env);
     union {
@@ -264,12 +264,12 @@ void helper_fldl_FT0(CPUX86State *env, uint64_t val)
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fildl_FT0(CPUX86State *env, int32_t val)
+void HELPER(fildl_FT0)(CPUX86State *env, int32_t val)
 {
     FT0 = int32_to_floatx80(val, &env->fp_status);
 }
 
-void helper_flds_ST0(CPUX86State *env, uint32_t val)
+void HELPER(flds_ST0)(CPUX86State *env, uint32_t val)
 {
     int old_flags = save_exception_flags(env);
     int new_fpstt;
@@ -286,7 +286,7 @@ void helper_flds_ST0(CPUX86State *env, uint32_t val)
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fldl_ST0(CPUX86State *env, uint64_t val)
+void HELPER(fldl_ST0)(CPUX86State *env, uint64_t val)
 {
     int old_flags = save_exception_flags(env);
     int new_fpstt;
@@ -310,7 +310,7 @@ static FloatX80RoundPrec tmp_maximise_precision(float_status *st)
     return old;
 }
 
-void helper_fildl_ST0(CPUX86State *env, int32_t val)
+void HELPER(fildl_ST0)(CPUX86State *env, int32_t val)
 {
     int new_fpstt;
     FloatX80RoundPrec old = tmp_maximise_precision(&env->fp_status);
@@ -323,7 +323,7 @@ void helper_fildl_ST0(CPUX86State *env, int32_t val)
     set_floatx80_rounding_precision(old, &env->fp_status);
 }
 
-void helper_fildll_ST0(CPUX86State *env, int64_t val)
+void HELPER(fildll_ST0)(CPUX86State *env, int64_t val)
 {
     int new_fpstt;
     FloatX80RoundPrec old = tmp_maximise_precision(&env->fp_status);
@@ -336,7 +336,7 @@ void helper_fildll_ST0(CPUX86State *env, int64_t val)
     set_floatx80_rounding_precision(old, &env->fp_status);
 }
 
-uint32_t helper_fsts_ST0(CPUX86State *env)
+uint32_t HELPER(fsts_ST0)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     union {
@@ -349,7 +349,7 @@ uint32_t helper_fsts_ST0(CPUX86State *env)
     return u.i;
 }
 
-uint64_t helper_fstl_ST0(CPUX86State *env)
+uint64_t HELPER(fstl_ST0)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     union {
@@ -362,7 +362,7 @@ uint64_t helper_fstl_ST0(CPUX86State *env)
     return u.i;
 }
 
-int32_t helper_fist_ST0(CPUX86State *env)
+int32_t HELPER(fist_ST0)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     int32_t val;
@@ -376,7 +376,7 @@ int32_t helper_fist_ST0(CPUX86State *env)
     return val;
 }
 
-int32_t helper_fistl_ST0(CPUX86State *env)
+int32_t HELPER(fistl_ST0)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     int32_t val;
@@ -389,7 +389,7 @@ int32_t helper_fistl_ST0(CPUX86State *env)
     return val;
 }
 
-int64_t helper_fistll_ST0(CPUX86State *env)
+int64_t HELPER(fistll_ST0)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     int64_t val;
@@ -402,7 +402,7 @@ int64_t helper_fistll_ST0(CPUX86State *env)
     return val;
 }
 
-int32_t helper_fistt_ST0(CPUX86State *env)
+int32_t HELPER(fistt_ST0)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     int32_t val;
@@ -416,7 +416,7 @@ int32_t helper_fistt_ST0(CPUX86State *env)
     return val;
 }
 
-int32_t helper_fisttl_ST0(CPUX86State *env)
+int32_t HELPER(fisttl_ST0)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     int32_t val;
@@ -429,7 +429,7 @@ int32_t helper_fisttl_ST0(CPUX86State *env)
     return val;
 }
 
-int64_t helper_fisttll_ST0(CPUX86State *env)
+int64_t HELPER(fisttll_ST0)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     int64_t val;
@@ -442,7 +442,7 @@ int64_t helper_fisttll_ST0(CPUX86State *env)
     return val;
 }
 
-void helper_fldt_ST0(CPUX86State *env, target_ulong ptr)
+void HELPER(fldt_ST0)(CPUX86State *env, target_ulong ptr)
 {
     int new_fpstt;
     X86Access ac;
@@ -455,7 +455,7 @@ void helper_fldt_ST0(CPUX86State *env, target_ulong ptr)
     env->fptags[new_fpstt] = 0; /* validate stack entry */
 }
 
-void helper_fstt_ST0(CPUX86State *env, target_ulong ptr)
+void HELPER(fstt_ST0)(CPUX86State *env, target_ulong ptr)
 {
     X86Access ac;
 
@@ -463,23 +463,23 @@ void helper_fstt_ST0(CPUX86State *env, target_ulong ptr)
     do_fstt(&ac, ptr, ST0);
 }
 
-void helper_fpush(CPUX86State *env)
+void HELPER(fpush)(CPUX86State *env)
 {
     fpush(env);
 }
 
-void helper_fpop(CPUX86State *env)
+void HELPER(fpop)(CPUX86State *env)
 {
     fpop(env);
 }
 
-void helper_fdecstp(CPUX86State *env)
+void HELPER(fdecstp)(CPUX86State *env)
 {
     env->fpstt = (env->fpstt - 1) & 7;
     env->fpus &= ~0x4700;
 }
 
-void helper_fincstp(CPUX86State *env)
+void HELPER(fincstp)(CPUX86State *env)
 {
     env->fpstt = (env->fpstt + 1) & 7;
     env->fpus &= ~0x4700;
@@ -487,33 +487,33 @@ void helper_fincstp(CPUX86State *env)
 
 /* FPU move */
 
-void helper_ffree_STN(CPUX86State *env, int st_index)
+void HELPER(ffree_STN)(CPUX86State *env, int st_index)
 {
     env->fptags[(env->fpstt + st_index) & 7] = 1;
 }
 
-void helper_fmov_ST0_FT0(CPUX86State *env)
+void HELPER(fmov_ST0_FT0)(CPUX86State *env)
 {
     ST0 = FT0;
 }
 
-void helper_fmov_FT0_STN(CPUX86State *env, int st_index)
+void HELPER(fmov_FT0_STN)(CPUX86State *env, int st_index)
 {
     FT0 = ST(st_index);
 }
 
-void helper_fmov_ST0_STN(CPUX86State *env, int st_index)
+void HELPER(fmov_ST0_STN)(CPUX86State *env, int st_index)
 {
     ST0 = ST(st_index);
 }
 
-void helper_fmov_STN_ST0(CPUX86State *env, int st_index)
+void HELPER(fmov_STN_ST0)(CPUX86State *env, int st_index)
 {
     ST(st_index) = ST0;
     env->fptags[(env->fpstt + st_index) & 7] = 0;
 }
 
-void helper_fxchg_ST0_STN(CPUX86State *env, int st_index)
+void HELPER(fxchg_ST0_STN)(CPUX86State *env, int st_index)
 {
     floatx80 tmp;
 
@@ -532,7 +532,7 @@ void helper_fxchg_ST0_STN(CPUX86State *env, int st_index)
 
 static const int fcom_ccval[4] = {0x0100, 0x4000, 0x0000, 0x4500};
 
-void helper_fcom_ST0_FT0(CPUX86State *env)
+void HELPER(fcom_ST0_FT0)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     FloatRelation ret;
@@ -543,7 +543,7 @@ void helper_fcom_ST0_FT0(CPUX86State *env)
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fucom_ST0_FT0(CPUX86State *env)
+void HELPER(fucom_ST0_FT0)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     FloatRelation ret;
@@ -556,7 +556,7 @@ void helper_fucom_ST0_FT0(CPUX86State *env)
 
 static const int fcomi_ccval[4] = {CC_C, CC_Z, 0, CC_Z | CC_P | CC_C};
 
-void helper_fcomi_ST0_FT0(CPUX86State *env)
+void HELPER(fcomi_ST0_FT0)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     FloatRelation ret;
@@ -568,7 +568,7 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fucomi_ST0_FT0(CPUX86State *env)
+void HELPER(fucomi_ST0_FT0)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     FloatRelation ret;
@@ -580,75 +580,75 @@ void helper_fucomi_ST0_FT0(CPUX86State *env)
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fadd_ST0_FT0(CPUX86State *env)
+void HELPER(fadd_ST0_FT0)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     ST0 = floatx80_add(ST0, FT0, &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fmul_ST0_FT0(CPUX86State *env)
+void HELPER(fmul_ST0_FT0)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     ST0 = floatx80_mul(ST0, FT0, &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fsub_ST0_FT0(CPUX86State *env)
+void HELPER(fsub_ST0_FT0)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     ST0 = floatx80_sub(ST0, FT0, &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fsubr_ST0_FT0(CPUX86State *env)
+void HELPER(fsubr_ST0_FT0)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     ST0 = floatx80_sub(FT0, ST0, &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fdiv_ST0_FT0(CPUX86State *env)
+void HELPER(fdiv_ST0_FT0)(CPUX86State *env)
 {
     ST0 = helper_fdiv(env, ST0, FT0);
 }
 
-void helper_fdivr_ST0_FT0(CPUX86State *env)
+void HELPER(fdivr_ST0_FT0)(CPUX86State *env)
 {
     ST0 = helper_fdiv(env, FT0, ST0);
 }
 
 /* fp operations between STN and ST0 */
 
-void helper_fadd_STN_ST0(CPUX86State *env, int st_index)
+void HELPER(fadd_STN_ST0)(CPUX86State *env, int st_index)
 {
     int old_flags = save_exception_flags(env);
     ST(st_index) = floatx80_add(ST(st_index), ST0, &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fmul_STN_ST0(CPUX86State *env, int st_index)
+void HELPER(fmul_STN_ST0)(CPUX86State *env, int st_index)
 {
     int old_flags = save_exception_flags(env);
     ST(st_index) = floatx80_mul(ST(st_index), ST0, &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fsub_STN_ST0(CPUX86State *env, int st_index)
+void HELPER(fsub_STN_ST0)(CPUX86State *env, int st_index)
 {
     int old_flags = save_exception_flags(env);
     ST(st_index) = floatx80_sub(ST(st_index), ST0, &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fsubr_STN_ST0(CPUX86State *env, int st_index)
+void HELPER(fsubr_STN_ST0)(CPUX86State *env, int st_index)
 {
     int old_flags = save_exception_flags(env);
     ST(st_index) = floatx80_sub(ST0, ST(st_index), &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fdiv_STN_ST0(CPUX86State *env, int st_index)
+void HELPER(fdiv_STN_ST0)(CPUX86State *env, int st_index)
 {
     floatx80 *p;
 
@@ -656,7 +656,7 @@ void helper_fdiv_STN_ST0(CPUX86State *env, int st_index)
     *p = helper_fdiv(env, *p, ST0);
 }
 
-void helper_fdivr_STN_ST0(CPUX86State *env, int st_index)
+void HELPER(fdivr_STN_ST0)(CPUX86State *env, int st_index)
 {
     floatx80 *p;
 
@@ -665,22 +665,22 @@ void helper_fdivr_STN_ST0(CPUX86State *env, int st_index)
 }
 
 /* misc FPU operations */
-void helper_fchs_ST0(CPUX86State *env)
+void HELPER(fchs_ST0)(CPUX86State *env)
 {
     ST0 = floatx80_chs(ST0);
 }
 
-void helper_fabs_ST0(CPUX86State *env)
+void HELPER(fabs_ST0)(CPUX86State *env)
 {
     ST0 = floatx80_abs(ST0);
 }
 
-void helper_fld1_ST0(CPUX86State *env)
+void HELPER(fld1_ST0)(CPUX86State *env)
 {
     ST0 = floatx80_one;
 }
 
-void helper_fldl2t_ST0(CPUX86State *env)
+void HELPER(fldl2t_ST0)(CPUX86State *env)
 {
     switch (env->fpuc & FPU_RC_MASK) {
     case FPU_RC_UP:
@@ -692,7 +692,7 @@ void helper_fldl2t_ST0(CPUX86State *env)
     }
 }
 
-void helper_fldl2e_ST0(CPUX86State *env)
+void HELPER(fldl2e_ST0)(CPUX86State *env)
 {
     switch (env->fpuc & FPU_RC_MASK) {
     case FPU_RC_DOWN:
@@ -705,7 +705,7 @@ void helper_fldl2e_ST0(CPUX86State *env)
     }
 }
 
-void helper_fldpi_ST0(CPUX86State *env)
+void HELPER(fldpi_ST0)(CPUX86State *env)
 {
     switch (env->fpuc & FPU_RC_MASK) {
     case FPU_RC_DOWN:
@@ -718,7 +718,7 @@ void helper_fldpi_ST0(CPUX86State *env)
     }
 }
 
-void helper_fldlg2_ST0(CPUX86State *env)
+void HELPER(fldlg2_ST0)(CPUX86State *env)
 {
     switch (env->fpuc & FPU_RC_MASK) {
     case FPU_RC_DOWN:
@@ -731,7 +731,7 @@ void helper_fldlg2_ST0(CPUX86State *env)
     }
 }
 
-void helper_fldln2_ST0(CPUX86State *env)
+void HELPER(fldln2_ST0)(CPUX86State *env)
 {
     switch (env->fpuc & FPU_RC_MASK) {
     case FPU_RC_DOWN:
@@ -744,22 +744,22 @@ void helper_fldln2_ST0(CPUX86State *env)
     }
 }
 
-void helper_fldz_ST0(CPUX86State *env)
+void HELPER(fldz_ST0)(CPUX86State *env)
 {
     ST0 = floatx80_zero;
 }
 
-void helper_fldz_FT0(CPUX86State *env)
+void HELPER(fldz_FT0)(CPUX86State *env)
 {
     FT0 = floatx80_zero;
 }
 
-uint32_t helper_fnstsw(CPUX86State *env)
+uint32_t HELPER(fnstsw)(CPUX86State *env)
 {
     return (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11;
 }
 
-uint32_t helper_fnstcw(CPUX86State *env)
+uint32_t HELPER(fnstcw)(CPUX86State *env)
 {
     return env->fpuc;
 }
@@ -800,17 +800,17 @@ void update_fp_status(CPUX86State *env)
     set_floatx80_rounding_precision(rnd_prec, &env->fp_status);
 }
 
-void helper_fldcw(CPUX86State *env, uint32_t val)
+void HELPER(fldcw)(CPUX86State *env, uint32_t val)
 {
     cpu_set_fpuc(env, val);
 }
 
-void helper_fclex(CPUX86State *env)
+void HELPER(fclex)(CPUX86State *env)
 {
     env->fpus &= 0x7f00;
 }
 
-void helper_fwait(CPUX86State *env)
+void HELPER(fwait)(CPUX86State *env)
 {
     if (env->fpus & FPUS_SE) {
         fpu_raise_exception(env, GETPC());
@@ -836,14 +836,14 @@ static void do_fninit(CPUX86State *env)
     env->fptags[7] = 1;
 }
 
-void helper_fninit(CPUX86State *env)
+void HELPER(fninit)(CPUX86State *env)
 {
     do_fninit(env);
 }
 
 /* BCD ops */
 
-void helper_fbld_ST0(CPUX86State *env, target_ulong ptr)
+void HELPER(fbld_ST0)(CPUX86State *env, target_ulong ptr)
 {
     X86Access ac;
     floatx80 tmp;
@@ -866,7 +866,7 @@ void helper_fbld_ST0(CPUX86State *env, target_ulong ptr)
     ST0 = tmp;
 }
 
-void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
+void HELPER(fbst_ST0)(CPUX86State *env, target_ulong ptr)
 {
     int old_flags = save_exception_flags(env);
     int v;
@@ -1141,7 +1141,7 @@ static const struct f2xm1_data f2xm1_table[65] = {
       make_floatx80_init(0x3fff, 0x8000000000000000ULL) },
 };
 
-void helper_f2xm1(CPUX86State *env)
+void HELPER(f2xm1)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     uint64_t sig = extractFloatx80Frac(ST0);
@@ -1302,7 +1302,7 @@ void helper_f2xm1(CPUX86State *env)
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fptan(CPUX86State *env)
+void HELPER(fptan)(CPUX86State *env)
 {
     double fptemp = floatx80_to_double(env, ST0);
 
@@ -1374,7 +1374,7 @@ static const struct fpatan_data fpatan_table[9] = {
       make_floatx80_init(0xbfbc, 0xece675d1fc8f8cbcULL) },
 };
 
-void helper_fpatan(CPUX86State *env)
+void HELPER(fpatan)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     uint64_t arg0_sig = extractFloatx80Frac(ST0);
@@ -1821,7 +1821,7 @@ static inline void fpush_fxtract(CPUX86State *env)
     env->fptags[(env->fpstt + 1) & 7] = 0;
 }
 
-void helper_fxtract(CPUX86State *env)
+void HELPER(fxtract)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     CPU_LDoubleU temp;
@@ -1921,12 +1921,12 @@ static void helper_fprem_common(CPUX86State *env, bool mod)
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fprem1(CPUX86State *env)
+void HELPER(fprem1)(CPUX86State *env)
 {
     helper_fprem_common(env, false);
 }
 
-void helper_fprem(CPUX86State *env)
+void HELPER(fprem)(CPUX86State *env)
 {
     helper_fprem_common(env, true);
 }
@@ -2066,7 +2066,7 @@ static void helper_fyl2x_common(CPUX86State *env, floatx80 arg, int32_t *exp,
     *sig1 = asig1;
 }
 
-void helper_fyl2xp1(CPUX86State *env)
+void HELPER(fyl2xp1)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     uint64_t arg0_sig = extractFloatx80Frac(ST0);
@@ -2164,7 +2164,7 @@ void helper_fyl2xp1(CPUX86State *env)
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fyl2x(CPUX86State *env)
+void HELPER(fyl2x)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     uint64_t arg0_sig = extractFloatx80Frac(ST0);
@@ -2311,7 +2311,7 @@ void helper_fyl2x(CPUX86State *env)
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fsqrt(CPUX86State *env)
+void HELPER(fsqrt)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     if (floatx80_is_neg(ST0)) {
@@ -2322,7 +2322,7 @@ void helper_fsqrt(CPUX86State *env)
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fsincos(CPUX86State *env)
+void HELPER(fsincos)(CPUX86State *env)
 {
     double fptemp = floatx80_to_double(env, ST0);
 
@@ -2337,14 +2337,14 @@ void helper_fsincos(CPUX86State *env)
     }
 }
 
-void helper_frndint(CPUX86State *env)
+void HELPER(frndint)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     ST0 = floatx80_round_to_int(ST0, &env->fp_status);
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fscale(CPUX86State *env)
+void HELPER(fscale)(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
     if (floatx80_invalid_encoding(ST1, &env->fp_status) ||
@@ -2395,7 +2395,7 @@ void helper_fscale(CPUX86State *env)
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fsin(CPUX86State *env)
+void HELPER(fsin)(CPUX86State *env)
 {
     double fptemp = floatx80_to_double(env, ST0);
 
@@ -2408,7 +2408,7 @@ void helper_fsin(CPUX86State *env)
     }
 }
 
-void helper_fcos(CPUX86State *env)
+void HELPER(fcos)(CPUX86State *env)
 {
     double fptemp = floatx80_to_double(env, ST0);
 
@@ -2421,7 +2421,7 @@ void helper_fcos(CPUX86State *env)
     }
 }
 
-void helper_fxam_ST0(CPUX86State *env)
+void HELPER(fxam_ST0)(CPUX86State *env)
 {
     CPU_LDoubleU temp;
     int expdif;
@@ -2504,7 +2504,7 @@ static void do_fstenv(X86Access *ac, target_ulong ptr, int data32)
     }
 }
 
-void helper_fstenv(CPUX86State *env, target_ulong ptr, int data32)
+void HELPER(fstenv)(CPUX86State *env, target_ulong ptr, int data32)
 {
     X86Access ac;
 
@@ -2544,7 +2544,7 @@ static void do_fldenv(X86Access *ac, target_ulong ptr, int data32)
     }
 }
 
-void helper_fldenv(CPUX86State *env, target_ulong ptr, int data32)
+void HELPER(fldenv)(CPUX86State *env, target_ulong ptr, int data32)
 {
     X86Access ac;
 
@@ -2570,7 +2570,7 @@ static void do_fsave(X86Access *ac, target_ulong ptr, int data32)
     }
 }
 
-void helper_fsave(CPUX86State *env, target_ulong ptr, int data32)
+void HELPER(fsave)(CPUX86State *env, target_ulong ptr, int data32)
 {
     int size = (14 << data32) + 80;
     X86Access ac;
@@ -2594,7 +2594,7 @@ static void do_frstor(X86Access *ac, target_ulong ptr, int data32)
     }
 }
 
-void helper_frstor(CPUX86State *env, target_ulong ptr, int data32)
+void HELPER(frstor)(CPUX86State *env, target_ulong ptr, int data32)
 {
     int size = (14 << data32) + 80;
     X86Access ac;
@@ -2741,7 +2741,7 @@ static void do_fxsave(X86Access *ac, target_ulong ptr)
     }
 }
 
-void helper_fxsave(CPUX86State *env, target_ulong ptr)
+void HELPER(fxsave)(CPUX86State *env, target_ulong ptr)
 {
     uintptr_t ra = GETPC();
     X86Access ac;
@@ -2839,12 +2839,12 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
     do_xsave_access(&ac, ptr, rfbm, inuse, opt);
 }
 
-void helper_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
+void HELPER(xsave)(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
     do_xsave(env, ptr, rfbm, get_xinuse(env), rfbm, GETPC());
 }
 
-void helper_xsaveopt(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
+void HELPER(xsaveopt)(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
     uint64_t inuse = get_xinuse(env);
     do_xsave(env, ptr, rfbm, inuse, inuse, GETPC());
@@ -3018,7 +3018,7 @@ static void do_clear_apx(X86Access *ac)
 }
 #endif
 
-void helper_fxrstor(CPUX86State *env, target_ulong ptr)
+void HELPER(fxrstor)(CPUX86State *env, target_ulong ptr)
 {
     uintptr_t ra = GETPC();
     X86Access ac;
@@ -3129,7 +3129,7 @@ static void do_xrstor(X86Access *ac, target_ulong ptr,
 
 #undef XO
 
-void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
+void HELPER(xrstor)(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
     uintptr_t ra = GETPC();
     X86Access ac;
@@ -3251,7 +3251,7 @@ bool cpu_x86_xrstor(CPUX86State *env, void *host, size_t len, uint64_t rfbm)
 }
 #endif
 
-uint64_t helper_xgetbv(CPUX86State *env, uint32_t ecx)
+uint64_t HELPER(xgetbv)(CPUX86State *env, uint32_t ecx)
 {
     /* The OS must have enabled XSAVE.  */
     if (!(env->cr[4] & CR4_OSXSAVE_MASK)) {
@@ -3270,7 +3270,7 @@ uint64_t helper_xgetbv(CPUX86State *env, uint32_t ecx)
     raise_exception_ra(env, EXCP0D_GPF, GETPC());
 }
 
-void helper_xsetbv(CPUX86State *env, uint32_t ecx, uint64_t mask)
+void HELPER(xsetbv)(CPUX86State *env, uint32_t ecx, uint64_t mask)
 {
     uint32_t dummy, ena_lo, ena_hi;
     uint64_t ena;
@@ -3359,24 +3359,24 @@ void update_mxcsr_from_sse_status(CPUX86State *env)
                     0));
 }
 
-void helper_update_mxcsr(CPUX86State *env)
+void HELPER(update_mxcsr)(CPUX86State *env)
 {
     update_mxcsr_from_sse_status(env);
 }
 
-void helper_ldmxcsr(CPUX86State *env, uint32_t val)
+void HELPER(ldmxcsr)(CPUX86State *env, uint32_t val)
 {
     cpu_set_mxcsr(env, val);
 }
 
-void helper_enter_mmx(CPUX86State *env)
+void HELPER(enter_mmx)(CPUX86State *env)
 {
     env->fpstt = 0;
     *(uint32_t *)(env->fptags) = 0;
     *(uint32_t *)(env->fptags + 4) = 0;
 }
 
-void helper_emms(CPUX86State *env)
+void HELPER(emms)(CPUX86State *env)
 {
     /* set to empty state */
     *(uint32_t *)(env->fptags) = 0x01010101;
diff --git a/target/i386/tcg/int_helper.c b/target/i386/tcg/int_helper.c
index 46741d9f68a..772e6adcc86 100644
--- a/target/i386/tcg/int_helper.c
+++ b/target/i386/tcg/int_helper.c
@@ -30,7 +30,7 @@
 
 /* division, flags are undefined */
 
-void helper_divb_AL(CPUX86State *env, target_ulong t0)
+void HELPER(divb_AL)(CPUX86State *env, target_ulong t0)
 {
     unsigned int num, den, q, r;
 
@@ -48,7 +48,7 @@ void helper_divb_AL(CPUX86State *env, target_ulong t0)
     env->regs[R_EAX] = (env->regs[R_EAX] & ~0xffff) | (r << 8) | q;
 }
 
-void helper_idivb_AL(CPUX86State *env, target_ulong t0)
+void HELPER(idivb_AL)(CPUX86State *env, target_ulong t0)
 {
     int num, den, q, r;
 
@@ -66,7 +66,7 @@ void helper_idivb_AL(CPUX86State *env, target_ulong t0)
     env->regs[R_EAX] = (env->regs[R_EAX] & ~0xffff) | (r << 8) | q;
 }
 
-void helper_divw_AX(CPUX86State *env, target_ulong t0)
+void HELPER(divw_AX)(CPUX86State *env, target_ulong t0)
 {
     unsigned int num, den, q, r;
 
@@ -85,7 +85,7 @@ void helper_divw_AX(CPUX86State *env, target_ulong t0)
     env->regs[R_EDX] = (env->regs[R_EDX] & ~0xffff) | r;
 }
 
-void helper_idivw_AX(CPUX86State *env, target_ulong t0)
+void HELPER(idivw_AX)(CPUX86State *env, target_ulong t0)
 {
     int num, den, q, r;
 
@@ -104,7 +104,7 @@ void helper_idivw_AX(CPUX86State *env, target_ulong t0)
     env->regs[R_EDX] = (env->regs[R_EDX] & ~0xffff) | r;
 }
 
-void helper_divl_EAX(CPUX86State *env, target_ulong t0)
+void HELPER(divl_EAX)(CPUX86State *env, target_ulong t0)
 {
     unsigned int den, r;
     uint64_t num, q;
@@ -123,7 +123,7 @@ void helper_divl_EAX(CPUX86State *env, target_ulong t0)
     env->regs[R_EDX] = (uint32_t)r;
 }
 
-void helper_idivl_EAX(CPUX86State *env, target_ulong t0)
+void HELPER(idivl_EAX)(CPUX86State *env, target_ulong t0)
 {
     int den, r;
     int64_t num, q;
@@ -144,7 +144,7 @@ void helper_idivl_EAX(CPUX86State *env, target_ulong t0)
 
 /* bcd */
 
-target_ulong helper_aam(target_ulong al, target_ulong base)
+target_ulong HELPER(aam)(target_ulong al, target_ulong base)
 {
     int ah;
 
@@ -154,7 +154,7 @@ target_ulong helper_aam(target_ulong al, target_ulong base)
     return al | (ah << 8);
 }
 
-target_ulong helper_aad(target_ulong ax, target_ulong base)
+target_ulong HELPER(aad)(target_ulong ax, target_ulong base)
 {
     int al, ah;
 
@@ -164,7 +164,7 @@ target_ulong helper_aad(target_ulong ax, target_ulong base)
     return al;
 }
 
-void helper_aaa(CPUX86State *env)
+void HELPER(aaa)(CPUX86State *env)
 {
     int icarry;
     int al, ah, af;
@@ -189,7 +189,7 @@ void helper_aaa(CPUX86State *env)
     CC_OP = CC_OP_EFLAGS;
 }
 
-void helper_aas(CPUX86State *env)
+void HELPER(aas)(CPUX86State *env)
 {
     int icarry;
     int al, ah, af;
@@ -214,7 +214,7 @@ void helper_aas(CPUX86State *env)
     CC_OP = CC_OP_EFLAGS;
 }
 
-void helper_daa(CPUX86State *env)
+void HELPER(daa)(CPUX86State *env)
 {
     int old_al, al, af, cf;
     int eflags;
@@ -242,7 +242,7 @@ void helper_daa(CPUX86State *env)
     CC_OP = CC_OP_EFLAGS;
 }
 
-void helper_das(CPUX86State *env)
+void HELPER(das)(CPUX86State *env)
 {
     int al, al1, af, cf;
     int eflags;
@@ -364,7 +364,7 @@ static int idiv64(uint64_t *plow, uint64_t *phigh, int64_t b)
     return 0;
 }
 
-void helper_divq_EAX(CPUX86State *env, target_ulong t0)
+void HELPER(divq_EAX)(CPUX86State *env, target_ulong t0)
 {
     uint64_t r0, r1;
 
@@ -380,7 +380,7 @@ void helper_divq_EAX(CPUX86State *env, target_ulong t0)
     env->regs[R_EDX] = r1;
 }
 
-void helper_idivq_EAX(CPUX86State *env, target_ulong t0)
+void HELPER(idivq_EAX)(CPUX86State *env, target_ulong t0)
 {
     uint64_t r0, r1;
 
@@ -405,7 +405,7 @@ void helper_idivq_EAX(CPUX86State *env, target_ulong t0)
 # define clztl  clz64
 #endif
 
-target_ulong helper_pdep(target_ulong src, target_ulong mask)
+target_ulong HELPER(pdep)(target_ulong src, target_ulong mask)
 {
     target_ulong dest = 0;
     int i, o;
@@ -418,7 +418,7 @@ target_ulong helper_pdep(target_ulong src, target_ulong mask)
     return dest;
 }
 
-target_ulong helper_pext(target_ulong src, target_ulong mask)
+target_ulong HELPER(pext)(target_ulong src, target_ulong mask)
 {
     target_ulong dest = 0;
     int i, o;
@@ -434,7 +434,7 @@ target_ulong helper_pext(target_ulong src, target_ulong mask)
 /* Test that BIT is enabled in CR4.  If not, raise an illegal opcode
    exception.  This reduces the requirements for rare CR4 bits being
    mapped into HFLAGS.  */
-void helper_cr4_testbit(CPUX86State *env, uint32_t bit)
+void HELPER(cr4_testbit)(CPUX86State *env, uint32_t bit)
 {
     if (unlikely((env->cr[4] & bit) == 0)) {
         raise_exception_ra(env, EXCP06_ILLOP, GETPC());
diff --git a/target/i386/tcg/mem_helper.c b/target/i386/tcg/mem_helper.c
index c15a32d60ad..1ed75a34920 100644
--- a/target/i386/tcg/mem_helper.c
+++ b/target/i386/tcg/mem_helper.c
@@ -26,7 +26,7 @@
 #include "tcg/tcg.h"
 #include "helper-tcg.h"
 
-void helper_boundw(CPUX86State *env, target_ulong a0, int v)
+void HELPER(boundw)(CPUX86State *env, target_ulong a0, int v)
 {
     int low, high;
 
@@ -41,7 +41,7 @@ void helper_boundw(CPUX86State *env, target_ulong a0, int v)
     }
 }
 
-void helper_boundl(CPUX86State *env, target_ulong a0, int v)
+void HELPER(boundl)(CPUX86State *env, target_ulong a0, int v)
 {
     int low, high;
 
diff --git a/target/i386/tcg/misc_helper.c b/target/i386/tcg/misc_helper.c
index f7342871ded..7c1f15953ac 100644
--- a/target/i386/tcg/misc_helper.c
+++ b/target/i386/tcg/misc_helper.c
@@ -38,7 +38,7 @@ void cpu_load_eflags(CPUX86State *env, int eflags, int update_mask)
         (eflags & update_mask) | 0x2;
 }
 
-void helper_into(CPUX86State *env, int next_eip_addend)
+void HELPER(into)(CPUX86State *env, int next_eip_addend)
 {
     int eflags;
 
@@ -48,7 +48,7 @@ void helper_into(CPUX86State *env, int next_eip_addend)
     }
 }
 
-void helper_cpuid(CPUX86State *env)
+void HELPER(cpuid)(CPUX86State *env)
 {
     uint32_t eax, ebx, ecx, edx;
 
@@ -62,7 +62,7 @@ void helper_cpuid(CPUX86State *env)
     env->regs[R_EDX] = edx;
 }
 
-void helper_rdtsc(CPUX86State *env)
+void HELPER(rdtsc)(CPUX86State *env)
 {
     uint64_t val;
 
@@ -76,7 +76,7 @@ void helper_rdtsc(CPUX86State *env)
     env->regs[R_EDX] = (uint32_t)(val >> 32);
 }
 
-G_NORETURN void helper_rdpmc(CPUX86State *env)
+G_NORETURN void HELPER(rdpmc)(CPUX86State *env)
 {
     if (((env->cr[4] & CR4_PCE_MASK) == 0 ) &&
         ((env->hflags & HF_CPL_MASK) != 0)) {
@@ -89,20 +89,20 @@ G_NORETURN void helper_rdpmc(CPUX86State *env)
     raise_exception_err(env, EXCP06_ILLOP, 0);
 }
 
-G_NORETURN void helper_pause(CPUX86State *env)
+G_NORETURN void HELPER(pause)(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
 
     /* Do gen_eob() tasks before going back to the main loop.  */
     do_end_instruction(env);
-    helper_rechecking_single_step(env);
+    HELPER(rechecking_single_step)(env);
 
     /* Just let another CPU run.  */
     cs->exception_index = EXCP_INTERRUPT;
     cpu_loop_exit(cs);
 }
 
-uint64_t helper_rdpkru(CPUX86State *env, uint32_t ecx)
+uint64_t HELPER(rdpkru)(CPUX86State *env, uint32_t ecx)
 {
     if ((env->cr[4] & CR4_PKE_MASK) == 0) {
         raise_exception_err_ra(env, EXCP06_ILLOP, 0, GETPC());
@@ -114,7 +114,7 @@ uint64_t helper_rdpkru(CPUX86State *env, uint32_t ecx)
     return env->pkru;
 }
 
-void helper_wrpkru(CPUX86State *env, uint32_t ecx, uint64_t val)
+void HELPER(wrpkru)(CPUX86State *env, uint32_t ecx, uint64_t val)
 {
     CPUState *cs = env_cpu(env);
 
diff --git a/target/i386/tcg/mpx_helper.c b/target/i386/tcg/mpx_helper.c
index 73d33bf5e4a..bbe2c824be2 100644
--- a/target/i386/tcg/mpx_helper.c
+++ b/target/i386/tcg/mpx_helper.c
@@ -25,7 +25,7 @@
 #include "helper-tcg.h"
 
 
-void helper_bndck(CPUX86State *env, uint32_t fail)
+void HELPER(bndck)(CPUX86State *env, uint32_t fail)
 {
     if (unlikely(fail)) {
         env->bndcs_regs.sts = 1;
@@ -73,7 +73,7 @@ static uint32_t lookup_bte32(CPUX86State *env, uint32_t base, uintptr_t ra)
     return (extract32(base, 2, 10) << 4) + (bt & ~3);
 }
 
-uint64_t helper_bndldx64(CPUX86State *env, target_ulong base, target_ulong ptr)
+uint64_t HELPER(bndldx64)(CPUX86State *env, target_ulong base, target_ulong ptr)
 {
     uintptr_t ra = GETPC();
     uint64_t bte, lb, ub, pt;
@@ -90,7 +90,7 @@ uint64_t helper_bndldx64(CPUX86State *env, target_ulong base, target_ulong ptr)
     return lb;
 }
 
-uint64_t helper_bndldx32(CPUX86State *env, target_ulong base, target_ulong ptr)
+uint64_t HELPER(bndldx32)(CPUX86State *env, target_ulong base, target_ulong ptr)
 {
     uintptr_t ra = GETPC();
     uint32_t bte, lb, ub, pt;
@@ -106,7 +106,7 @@ uint64_t helper_bndldx32(CPUX86State *env, target_ulong base, target_ulong ptr)
     return ((uint64_t)ub << 32) | lb;
 }
 
-void helper_bndstx64(CPUX86State *env, target_ulong base, target_ulong ptr,
+void HELPER(bndstx64)(CPUX86State *env, target_ulong base, target_ulong ptr,
                      uint64_t lb, uint64_t ub)
 {
     uintptr_t ra = GETPC();
@@ -118,7 +118,7 @@ void helper_bndstx64(CPUX86State *env, target_ulong base, target_ulong ptr,
     cpu_stq_le_data_ra(env, bte + 16, ptr, ra);
 }
 
-void helper_bndstx32(CPUX86State *env, target_ulong base, target_ulong ptr,
+void HELPER(bndstx32)(CPUX86State *env, target_ulong base, target_ulong ptr,
                      uint64_t lb, uint64_t ub)
 {
     uintptr_t ra = GETPC();
@@ -130,7 +130,7 @@ void helper_bndstx32(CPUX86State *env, target_ulong base, target_ulong ptr,
     cpu_stl_le_data_ra(env, bte + 8, ptr, ra);
 }
 
-void helper_bnd_jmp(CPUX86State *env)
+void HELPER(bnd_jmp)(CPUX86State *env)
 {
     if (!(env->hflags2 & HF2_MPX_PR_MASK)) {
         memset(env->bnd_regs, 0, sizeof(env->bnd_regs));
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index cad19f9ca6b..f1db415be7f 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1082,7 +1082,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
 }
 #endif /* TARGET_X86_64 */
 
-void helper_sysret(CPUX86State *env, int dflag)
+void HELPER(sysret)(CPUX86State *env, int dflag)
 {
     int cpl, selector;
 
@@ -1283,7 +1283,7 @@ void do_interrupt_x86_hardirq(CPUX86State *env, int intno, int is_hw)
     do_interrupt_all(env_archcpu(env), intno, 0, 0, 0, is_hw);
 }
 
-void helper_lldt(CPUX86State *env, int selector)
+void HELPER(lldt)(CPUX86State *env, int selector)
 {
     SegmentCache *dt;
     uint32_t e1, e2;
@@ -1337,7 +1337,7 @@ void helper_lldt(CPUX86State *env, int selector)
     env->ldt.selector = selector;
 }
 
-void helper_ltr(CPUX86State *env, int selector)
+void HELPER(ltr)(CPUX86State *env, int selector)
 {
     SegmentCache *dt;
     uint32_t e1, e2;
@@ -1401,7 +1401,7 @@ void helper_ltr(CPUX86State *env, int selector)
 }
 
 /* only works if protected mode and not VM86. seg_reg must be != R_CS */
-void helper_load_seg(CPUX86State *env, int seg_reg, int selector)
+void HELPER(load_seg)(CPUX86State *env, int seg_reg, int selector)
 {
     uint32_t e1, e2;
     int cpl, dpl, rpl;
@@ -1489,7 +1489,7 @@ void helper_load_seg(CPUX86State *env, int seg_reg, int selector)
 }
 
 /* protected mode jump */
-void helper_ljmp_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
+void HELPER(ljmp_protected)(CPUX86State *env, int new_cs, target_ulong new_eip,
                            target_ulong next_eip)
 {
     int gate_cs, type;
@@ -1630,7 +1630,7 @@ void helper_ljmp_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 }
 
 /* real mode call */
-void helper_lcall_real(CPUX86State *env, uint32_t new_cs, uint32_t new_eip,
+void HELPER(lcall_real)(CPUX86State *env, uint32_t new_cs, uint32_t new_eip,
                        int shift, uint32_t next_eip)
 {
     StackAccess sa;
@@ -1657,7 +1657,7 @@ void helper_lcall_real(CPUX86State *env, uint32_t new_cs, uint32_t new_eip,
 }
 
 /* protected mode call */
-void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
+void HELPER(lcall_protected)(CPUX86State *env, int new_cs, target_ulong new_eip,
                             int shift, target_ulong next_eip)
 {
     int new_stack, i;
@@ -1964,7 +1964,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 }
 
 /* real and vm86 mode iret */
-void helper_iret_real(CPUX86State *env, int shift)
+void HELPER(iret_real)(CPUX86State *env, int shift)
 {
     uint32_t new_cs, new_eip, new_eflags;
     int eflags_mask;
@@ -2256,7 +2256,7 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
     env->regs[R_ESP] = new_esp;
 }
 
-void helper_iret_protected(CPUX86State *env, int shift, int next_eip)
+void HELPER(iret_protected)(CPUX86State *env, int shift, int next_eip)
 {
     int tss_selector, type;
     uint32_t e1, e2;
@@ -2288,12 +2288,12 @@ void helper_iret_protected(CPUX86State *env, int shift, int next_eip)
     env->hflags2 &= ~HF2_NMI_MASK;
 }
 
-void helper_lret_protected(CPUX86State *env, int shift, int addend)
+void HELPER(lret_protected)(CPUX86State *env, int shift, int addend)
 {
     helper_ret_protected(env, shift, 0, addend, GETPC());
 }
 
-void helper_sysenter(CPUX86State *env)
+void HELPER(sysenter)(CPUX86State *env)
 {
     if (env->sysenter_cs == 0) {
         raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
@@ -2326,7 +2326,7 @@ void helper_sysenter(CPUX86State *env)
     env->eip = env->sysenter_eip;
 }
 
-void helper_sysexit(CPUX86State *env, int dflag)
+void HELPER(sysexit)(CPUX86State *env, int dflag)
 {
     int cpl;
 
@@ -2365,7 +2365,7 @@ void helper_sysexit(CPUX86State *env, int dflag)
     env->eip = env->regs[R_EDX];
 }
 
-target_ulong helper_lsl(CPUX86State *env, target_ulong selector1)
+target_ulong HELPER(lsl)(CPUX86State *env, target_ulong selector1)
 {
     unsigned int limit;
     uint32_t e1, e2, selector;
@@ -2413,7 +2413,7 @@ target_ulong helper_lsl(CPUX86State *env, target_ulong selector1)
     return limit;
 }
 
-target_ulong helper_lar(CPUX86State *env, target_ulong selector1)
+target_ulong HELPER(lar)(CPUX86State *env, target_ulong selector1)
 {
     uint32_t e1, e2, selector;
     int rpl, dpl, cpl, type;
@@ -2462,7 +2462,7 @@ target_ulong helper_lar(CPUX86State *env, target_ulong selector1)
     return e2 & 0x00f0ff00;
 }
 
-void helper_verr(CPUX86State *env, target_ulong selector1)
+void HELPER(verr)(CPUX86State *env, target_ulong selector1)
 {
     uint32_t e1, e2, eflags, selector;
     int rpl, dpl, cpl;
@@ -2500,7 +2500,7 @@ void helper_verr(CPUX86State *env, target_ulong selector1)
     CC_OP = CC_OP_EFLAGS;
 }
 
-void helper_verw(CPUX86State *env, target_ulong selector1)
+void HELPER(verw)(CPUX86State *env, target_ulong selector1)
 {
     uint32_t e1, e2, eflags, selector;
     int rpl, dpl, cpl;
diff --git a/target/i386/tcg/system/bpt_helper.c b/target/i386/tcg/system/bpt_helper.c
index 2feea69c8a1..5ea229d3b32 100644
--- a/target/i386/tcg/system/bpt_helper.c
+++ b/target/i386/tcg/system/bpt_helper.c
@@ -235,7 +235,7 @@ void breakpoint_handler(CPUState *cs)
     }
 }
 
-target_ulong helper_get_dr(CPUX86State *env, int reg)
+target_ulong HELPER(get_dr)(CPUX86State *env, int reg)
 {
     if (reg >= 4 && reg < 6) {
         if (env->cr[4] & CR4_DE_MASK) {
@@ -254,7 +254,7 @@ target_ulong helper_get_dr(CPUX86State *env, int reg)
     return env->dr[reg];
 }
 
-void helper_set_dr(CPUX86State *env, int reg, target_ulong t0)
+void HELPER(set_dr)(CPUX86State *env, int reg, target_ulong t0)
 {
     if (reg >= 4 && reg < 6) {
         if (env->cr[4] & CR4_DE_MASK) {
@@ -292,7 +292,7 @@ void helper_set_dr(CPUX86State *env, int reg, target_ulong t0)
 }
 
 /* Check if Port I/O is trapped by a breakpoint.  */
-void helper_bpt_io(CPUX86State *env, uint32_t port,
+void HELPER(bpt_io)(CPUX86State *env, uint32_t port,
                    uint32_t size, target_ulong next_eip)
 {
     target_ulong dr7 = env->dr[7];
diff --git a/target/i386/tcg/system/misc_helper.c b/target/i386/tcg/system/misc_helper.c
index 2998b1aae75..a77da599da8 100644
--- a/target/i386/tcg/system/misc_helper.c
+++ b/target/i386/tcg/system/misc_helper.c
@@ -29,43 +29,43 @@
 #include "tcg/helper-tcg.h"
 #include "hw/i386/apic.h"
 
-void helper_outb(CPUX86State *env, uint32_t port, uint32_t data)
+void HELPER(outb)(CPUX86State *env, uint32_t port, uint32_t data)
 {
     address_space_stb(&address_space_io, port, data,
                       cpu_get_mem_attrs(env), NULL);
 }
 
-target_ulong helper_inb(CPUX86State *env, uint32_t port)
+target_ulong HELPER(inb)(CPUX86State *env, uint32_t port)
 {
     return address_space_ldub(&address_space_io, port,
                               cpu_get_mem_attrs(env), NULL);
 }
 
-void helper_outw(CPUX86State *env, uint32_t port, uint32_t data)
+void HELPER(outw)(CPUX86State *env, uint32_t port, uint32_t data)
 {
     address_space_stw_le(&address_space_io, port, data,
                          cpu_get_mem_attrs(env), NULL);
 }
 
-target_ulong helper_inw(CPUX86State *env, uint32_t port)
+target_ulong HELPER(inw)(CPUX86State *env, uint32_t port)
 {
     return address_space_lduw_le(&address_space_io, port,
                                  cpu_get_mem_attrs(env), NULL);
 }
 
-void helper_outl(CPUX86State *env, uint32_t port, uint32_t data)
+void HELPER(outl)(CPUX86State *env, uint32_t port, uint32_t data)
 {
     address_space_stl_le(&address_space_io, port, data,
                          cpu_get_mem_attrs(env), NULL);
 }
 
-target_ulong helper_inl(CPUX86State *env, uint32_t port)
+target_ulong HELPER(inl)(CPUX86State *env, uint32_t port)
 {
     return address_space_ldl_le(&address_space_io, port,
                                 cpu_get_mem_attrs(env), NULL);
 }
 
-target_ulong helper_read_cr8(CPUX86State *env)
+target_ulong HELPER(read_cr8)(CPUX86State *env)
 {
     if (!(env->hflags2 & HF2_VINTR_MASK)) {
         return cpu_get_apic_tpr(env_archcpu(env)->apic_state);
@@ -74,7 +74,7 @@ target_ulong helper_read_cr8(CPUX86State *env)
     }
 }
 
-void helper_write_crN(CPUX86State *env, int reg, target_ulong t0)
+void HELPER(write_crN)(CPUX86State *env, int reg, target_ulong t0)
 {
     switch (reg) {
     case 0:
@@ -130,7 +130,7 @@ void helper_write_crN(CPUX86State *env, int reg, target_ulong t0)
     }
 }
 
-void helper_wrmsr(CPUX86State *env)
+void HELPER(wrmsr)(CPUX86State *env)
 {
     uint64_t val;
     CPUState *cs = env_cpu(env);
@@ -327,7 +327,7 @@ error:
     raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
 }
 
-void helper_rdmsr(CPUX86State *env)
+void HELPER(rdmsr)(CPUX86State *env)
 {
     X86CPU *x86_cpu = env_archcpu(env);
     uint64_t val;
@@ -502,12 +502,12 @@ void helper_rdmsr(CPUX86State *env)
     env->regs[R_EDX] = (uint32_t)(val >> 32);
 }
 
-void helper_flush_page(CPUX86State *env, target_ulong addr)
+void HELPER(flush_page)(CPUX86State *env, target_ulong addr)
 {
     tlb_flush_page(env_cpu(env), addr);
 }
 
-G_NORETURN void helper_hlt(CPUX86State *env)
+G_NORETURN void HELPER(hlt)(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -517,7 +517,7 @@ G_NORETURN void helper_hlt(CPUX86State *env)
     cpu_loop_exit(cs);
 }
 
-void helper_monitor(CPUX86State *env, target_ulong ptr)
+void HELPER(monitor)(CPUX86State *env, target_ulong ptr)
 {
     if ((uint32_t)env->regs[R_ECX] != 0) {
         raise_exception_ra(env, EXCP0D_GPF, GETPC());
@@ -526,7 +526,7 @@ void helper_monitor(CPUX86State *env, target_ulong ptr)
     cpu_svm_check_intercept_param(env, SVM_EXIT_MONITOR, 0, GETPC());
 }
 
-G_NORETURN void helper_mwait(CPUX86State *env, int next_eip_addend)
+G_NORETURN void HELPER(mwait)(CPUX86State *env, int next_eip_addend)
 {
     CPUState *cs = env_cpu(env);
 
@@ -538,8 +538,8 @@ G_NORETURN void helper_mwait(CPUX86State *env, int next_eip_addend)
 
     /* XXX: not complete but not completely erroneous */
     if (cs->cpu_index != 0 || CPU_NEXT(cs) != NULL) {
-        helper_pause(env);
+        HELPER(pause)(env);
     } else {
-        helper_hlt(env);
+        HELPER(hlt)(env);
     }
 }
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 8c7856be81e..8e038c79267 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -27,7 +27,7 @@
 #include "tcg/helper-tcg.h"
 #include "../seg_helper.h"
 
-void helper_syscall(CPUX86State *env, int next_eip_addend)
+void HELPER(syscall)(CPUX86State *env, int next_eip_addend)
 {
     int selector;
 
@@ -225,7 +225,7 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 }
 
 /* check if Port I/O is allowed in TSS */
-void helper_check_io(CPUX86State *env, uint32_t addr, uint32_t size)
+void HELPER(check_io)(CPUX86State *env, uint32_t addr, uint32_t size)
 {
     uintptr_t retaddr = GETPC();
     uint32_t io_offset, val, mask;
diff --git a/target/i386/tcg/system/smm_helper.c b/target/i386/tcg/system/smm_helper.c
index 4bbe18a86fb..ae705752632 100644
--- a/target/i386/tcg/system/smm_helper.c
+++ b/target/i386/tcg/system/smm_helper.c
@@ -178,7 +178,7 @@ void do_smm_enter(X86CPU *cpu)
                        env->cr[0] & ~(CR0_PE_MASK | CR0_EM_MASK | CR0_TS_MASK |
                                       CR0_PG_MASK));
     cpu_x86_update_cr4(env, 0);
-    helper_set_dr(env, 7, 0x00000400);
+    HELPER(set_dr)(env, 7, 0x00000400);
 
     cpu_x86_load_seg_cache(env, R_CS, (env->smbase >> 4) & 0xffff, env->smbase,
                            0xffffffff,
@@ -243,8 +243,8 @@ static void rsm_load_regs_64(CPUX86State *env)
     env->eip = x86_ldq_phys(cs, sm_state + 0x7f78);
     cpu_load_eflags(env, x86_ldl_phys(cs, sm_state + 0x7f70),
                     ~(CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C | DF_MASK));
-    helper_set_dr(env, 6, x86_ldl_phys(cs, sm_state + 0x7f68));
-    helper_set_dr(env, 7, x86_ldl_phys(cs, sm_state + 0x7f60));
+    HELPER(set_dr)(env, 6, x86_ldl_phys(cs, sm_state + 0x7f68));
+    HELPER(set_dr)(env, 7, x86_ldl_phys(cs, sm_state + 0x7f60));
 
     cpu_x86_update_cr4(env, x86_ldl_phys(cs, sm_state + 0x7f48));
     cpu_x86_update_cr3(env, x86_ldq_phys(cs, sm_state + 0x7f50));
@@ -291,8 +291,8 @@ static void rsm_load_regs_32(CPUX86State *env)
     env->regs[R_EDX] = x86_ldl_phys(cs, sm_state + 0x7fd8);
     env->regs[R_ECX] = x86_ldl_phys(cs, sm_state + 0x7fd4);
     env->regs[R_EAX] = x86_ldl_phys(cs, sm_state + 0x7fd0);
-    helper_set_dr(env, 6, x86_ldl_phys(cs, sm_state + 0x7fcc));
-    helper_set_dr(env, 7, x86_ldl_phys(cs, sm_state + 0x7fc8));
+    HELPER(set_dr)(env, 6, x86_ldl_phys(cs, sm_state + 0x7fcc));
+    HELPER(set_dr)(env, 7, x86_ldl_phys(cs, sm_state + 0x7fc8));
 
     env->tr.selector = x86_ldl_phys(cs, sm_state + 0x7fc4) & 0xffff;
     env->tr.base = x86_ldl_phys(cs, sm_state + 0x7f64);
@@ -332,7 +332,7 @@ static void rsm_load_regs_32(CPUX86State *env)
     }
 }
 
-void helper_rsm(CPUX86State *env)
+void HELPER(rsm)(CPUX86State *env)
 {
     X86CPU *cpu = env_archcpu(env);
 
diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index 52a234e7fac..9c040422c1f 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -153,7 +153,7 @@ static inline bool virtual_gif_set(CPUX86State *env)
     return !virtual_gif_enabled(env) || (env->int_ctl & V_GIF_MASK);
 }
 
-void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
+void HELPER(vmrun)(CPUX86State *env, int aflag, int next_eip_addend)
 {
     CPUState *cs = env_cpu(env);
     X86CPU *cpu = env_archcpu(env);
@@ -469,13 +469,13 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
     }
 }
 
-void helper_vmmcall(CPUX86State *env)
+void HELPER(vmmcall)(CPUX86State *env)
 {
     cpu_svm_check_intercept_param(env, SVM_EXIT_VMMCALL, 0, GETPC());
     raise_exception(env, EXCP06_ILLOP);
 }
 
-void helper_vmload(CPUX86State *env, int aflag)
+void HELPER(vmload)(CPUX86State *env, int aflag)
 {
     int mmu_idx = MMU_PHYS_IDX;
     target_ulong addr;
@@ -539,7 +539,7 @@ void helper_vmload(CPUX86State *env, int aflag)
                              mmu_idx, 0);
 }
 
-void helper_vmsave(CPUX86State *env, int aflag)
+void HELPER(vmsave)(CPUX86State *env, int aflag)
 {
     int mmu_idx = MMU_PHYS_IDX;
     target_ulong addr;
@@ -590,7 +590,7 @@ void helper_vmsave(CPUX86State *env, int aflag)
                       env->sysenter_eip, mmu_idx, 0);
 }
 
-void helper_stgi(CPUX86State *env)
+void HELPER(stgi)(CPUX86State *env)
 {
     cpu_svm_check_intercept_param(env, SVM_EXIT_STGI, 0, GETPC());
 
@@ -602,7 +602,7 @@ void helper_stgi(CPUX86State *env)
     }
 }
 
-void helper_clgi(CPUX86State *env)
+void HELPER(clgi)(CPUX86State *env)
 {
     cpu_svm_check_intercept_param(env, SVM_EXIT_CLGI, 0, GETPC());
 
@@ -701,12 +701,12 @@ void cpu_svm_check_intercept_param(CPUX86State *env, uint32_t type,
     cpu_vmexit(env, type, param, retaddr);
 }
 
-void helper_svm_check_intercept(CPUX86State *env, uint32_t type)
+void HELPER(svm_check_intercept)(CPUX86State *env, uint32_t type)
 {
     cpu_svm_check_intercept_param(env, type, 0, GETPC());
 }
 
-void helper_svm_check_io(CPUX86State *env, uint32_t port, uint32_t param,
+void HELPER(svm_check_io)(CPUX86State *env, uint32_t port, uint32_t param,
                          uint32_t next_eip_addend)
 {
     CPUState *cs = env_cpu(env);
diff --git a/target/i386/tcg/user/seg_helper.c b/target/i386/tcg/user/seg_helper.c
index 3a4a6d5a745..d085b5709b1 100644
--- a/target/i386/tcg/user/seg_helper.c
+++ b/target/i386/tcg/user/seg_helper.c
@@ -26,7 +26,7 @@
 #include "tcg/helper-tcg.h"
 #include "tcg/seg_helper.h"
 
-void helper_syscall(CPUX86State *env, int next_eip_addend)
+void HELPER(syscall)(CPUX86State *env, int next_eip_addend)
 {
     CPUState *cs = env_cpu(env);
 
@@ -102,6 +102,6 @@ void cpu_x86_load_seg(CPUX86State *env, X86Seg seg_reg, int selector)
                                DESC_P_MASK | DESC_S_MASK | DESC_W_MASK |
                                DESC_A_MASK | (dpl << DESC_DPL_SHIFT));
     } else {
-        helper_load_seg(env, seg_reg, selector);
+        HELPER(load_seg)(env, seg_reg, selector);
     }
 }
-- 
2.43.0


