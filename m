Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65ED606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=csbASeYH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A9+edqvA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunG-0001eC-Ja; Mon, 19 Oct 2026 17:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunB-0001cH-JM
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIun9-0005ge-Ll
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:13 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JKZch6156439
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RF8BdSBoaNe
 /B3LbHLEcnJyqHjo1xI0wir3OwjOw0g0=; b=csbASeYHpSEbAjl3WGEYoP69Fga
 5rOqiczfKSHMc8Bvqq7GLJFvCzXd7heSkp0rv+MtCcBAKT+ZqafonDyPQ2jWLODR
 gGZFgdy/HEXPkreLJwwiB0qV5DvRQ6BGOEJVxuVojYV3kX+0/kLi6gU+ZllK+XIK
 8pfLbAIjRa4uHCxM3EN2x+I5fsAx1vlk8fThursLaCVkadHsqxyqv+1ds6P3L6eC
 XzQrvYiveyP/9O+d2hdI9LLDvaNpRhqzAuOB6uoYS5kCTnbjGaGlR+oReh2+aww3
 /yfkJvNIo4zBMbFsLchazD00nDmDQsT0PQpC/bDGMKxn15OJSiAT4wAAKdg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48k920-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so3469189a91.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444869; x=1793049669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RF8BdSBoaNe/B3LbHLEcnJyqHjo1xI0wir3OwjOw0g0=;
 b=A9+edqvAQZCLzez5NujQn0aXzVS3l3aTSJGJKm9ThSwo/I0laYJEr2SHSP/IVAUGUX
 OO4h5Peyo0W0kXArjy6ruUjN6ZC4tLUGV20cKc2Nwd75906mUPOKqCPsC9tC76FRNLVd
 GQkxE6NDqIStuh2vBgZmcuIGSsak8ckhX6X9TEhFGrKaqO/sCaMlOyFQQleM08U7HE3N
 iTEgC9YyR5fvNwTQJKS8cq4Co/XCeMZQQsSqZCwuVFlOpmEsH1QjYbiSFsB2vf4LXSjn
 wprHhMzvAMhGsaYI95uvEnSU/BnO50F929mHGL5S4PwHd+Ub92mU1hqbqfnJiyrZ2Sut
 ynSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444869; x=1793049669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RF8BdSBoaNe/B3LbHLEcnJyqHjo1xI0wir3OwjOw0g0=;
 b=q4JnSoW60eTyb6nJUDR+asT5wBHLmWcgMzc/g/pjk6NQ0CZmURqdQTUxCIbxBy2sKp
 XybMGusUbeyQVkCmDohQpVVdnoqVjg5eo4725shF2Lhn1d/6rRLCqZihQKORION3nepK
 e7yHzNVxXnvF37EW71ydaN9pu2jjkrqzWAWGA65RM7wv73AabR/4IVkGEFY9eFgcHMu8
 Y78rQJNJCDK6UwHEtv0+qDzmcnNMcz8z1zkIMxXbsO1uCU1SHwoL4e6uSbu9gpTpEsjY
 46plBTnpU/mYFdN+pXFXwS6D2VMfRVErrr/uCTtNT7oYCEBoVvZb0DLppSINK4FiQmxq
 4idg==
X-Gm-Message-State: AFq9FYIOvXNGE46B3DxIKtV3VsFRQq9QRplIohfdYeVW6oeuXj2sY8nn
 RVwo0rslhOeEbEb4ExAkhbP8Y7xdMTjUc9uZGkqr/ziAJLSr/CXUU4ls5mhuq8XYnojL3YqpAVX
 g0dH9QWhL/oxo8sf+TAUItomyEFI/X7P2FRWpZCmsyDdHCpWIKtoBTfqFKivi1V7EMg==
X-Gm-Gg: AYBFou0AJWOlxoPtbuukwtCvp72lPUWT/LbC4ycYL3cA1KbQszzHUbipooT3y0+GfQh
 OQdtfFF+YEJAHRM5Rda4wRBd+SiARMXO4gFWh1rJCkHOjVML19CWXM664M0rqGOm/DioV6Xomjs
 /MdDoCPJY+cwpFx56cg9Kd45ayfnzHSTJ8ID6YroGC7QHdq7OBMURG+oFt+aPcvvRL4piMJHd/Q
 RYxwToML4+27UkrWO4qMirtZ33f6UrfGhukGaCxyRlH/sP8r7+S5/Vxhbp7ObxGakE8Qn9RJhVs
 JHWAkSYnxGwK8EvK6+UejykZfOjGt4nyDWNvvFYX3S6NkXofPYw0Nsvv7Wj5AvL3HGKMtCvzdIL
 8U96y+w30PWpSvw8sUj6Vf47V+CeAWQwSWpNBA8y5MicWUOdtiVvmaM0/M4HWkHc=
X-Received: by 2002:a17:90a:f0f:b0:3ad:4a8b:c701 with SMTP id
 98e67ed59e1d1-3ad4a8be023mr1649315a91.45.1792444869268; 
 Mon, 19 Oct 2026 14:21:09 -0700 (PDT)
X-Received: by 2002:a17:90a:f0f:b0:3ad:4a8b:c701 with SMTP id
 98e67ed59e1d1-3ad4a8be023mr1649308a91.45.1792444868816; 
 Mon, 19 Oct 2026 14:21:08 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 08/26] target/microblaze: define and call helpers using HELPER
 macro
Date: Mon, 19 Oct 2026 21:20:27 +0000
Message-ID: <20261019212046.149572-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX5kM0D/K4jZ2B
 ER3xZeR8bDnN5WlmxAxnKsR3tkzMfR+7x/6tW0WDEeBS3EUM3gUh9nMY9yZMVeqpD/ZP53rIFuV
 xRcY9x5VLnVC0rB+tgDN0whVcUGYV6CTyqQfMkdc5wd4EkJeZ/FRL1aylf3omdgR4NCM5cp5srO
 FFNc0AKLH5jSwCh9YCfIGoua68dSqoa4hefG8FjmUVuetKd2vgcs6ARN3YRNispvZSSJgGbnWXn
 2MPsC+OEP/p0ltkWVjAOWG+zArV0AKqAGjlc/Iq2VozdGJEFPiQ9nWzUJ0Ztw3WyBfi9jVPFE6H
 HBIWJCQ16lWTUF+r0sSwP99s36+Q5NvfV8u4Wdvi443M0+9DycCcuQMAB3nP/8mdDJEQOxzCvZy
 wtDeZs6rqHnKIaSZlSTxjTirnsdQIptZfbVRVyAUlOw2zb1iLVZFqaGDwX9xxTQ+Z8rxvAfz65O
 19/rDNzoBVOq6h+xAcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX3URE4XL+A2CZ
 1kzoCghYZvLDFxZF49g+zAMhGB26KHZAexKKN1slXQGf6V5ERAGkgWi3fZ9QO7ZvpvDnRF3Vro+
 deVKi6NnjItQDpDnObdhZw9tASXuEDI=
X-Proofpoint-ORIG-GUID: JCbQUYKuJ_MSlA3Z7JTPQZuRo7KwK76M
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad689c6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=itqY9gs7vbMVEQc_hZoA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: JCbQUYKuJ_MSlA3Z7JTPQZuRo7KwK76M
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/microblaze/op_helper.c | 46 +++++++++++++++++------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index c169312e954..c53103ecd79 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -27,7 +27,7 @@
 #include "accel/tcg/cpu-loop.h"
 #include "fpu/softfloat.h"
 
-void helper_put(uint32_t id, uint32_t ctrl, uint32_t data)
+void HELPER(put)(uint32_t id, uint32_t ctrl, uint32_t data)
 {
     int test = ctrl & STREAM_TEST;
     int atomic = ctrl & STREAM_ATOMIC;
@@ -44,7 +44,7 @@ void helper_put(uint32_t id, uint32_t ctrl, uint32_t data)
              atomic ? "a" : "");
 }
 
-uint32_t helper_get(uint32_t id, uint32_t ctrl)
+uint32_t HELPER(get)(uint32_t id, uint32_t ctrl)
 {
     int test = ctrl & STREAM_TEST;
     int atomic = ctrl & STREAM_ATOMIC;
@@ -62,7 +62,7 @@ uint32_t helper_get(uint32_t id, uint32_t ctrl)
     return 0xdead0000 | id;
 }
 
-void helper_microblaze_raise_exception(CPUMBState *env, uint32_t index)
+void HELPER(microblaze_raise_exception)(CPUMBState *env, uint32_t index)
 {
     CPUState *cs = env_cpu(env);
 
@@ -84,7 +84,7 @@ static void raise_divzero(CPUMBState *env, uint32_t esr, uintptr_t unwind_pc)
     }
 }
 
-uint32_t helper_divs(CPUMBState *env, uint32_t ra, uint32_t rb)
+uint32_t HELPER(divs)(CPUMBState *env, uint32_t ra, uint32_t rb)
 {
     if (!ra) {
         raise_divzero(env, ESR_EC_DIVZERO, GETPC());
@@ -108,7 +108,7 @@ uint32_t helper_divs(CPUMBState *env, uint32_t ra, uint32_t rb)
     return (int32_t)rb / (int32_t)ra;
 }
 
-uint32_t helper_divu(CPUMBState *env, uint32_t ra, uint32_t rb)
+uint32_t HELPER(divu)(CPUMBState *env, uint32_t ra, uint32_t rb)
 {
     if (!ra) {
         raise_divzero(env, ESR_EC_DIVZERO, GETPC());
@@ -154,7 +154,7 @@ static void update_fpu_flags(CPUMBState *env, int flags, uintptr_t ra)
     }
 }
 
-uint32_t helper_microblaze_fadd(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(microblaze_fadd)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -169,7 +169,7 @@ uint32_t helper_microblaze_fadd(CPUMBState *env, uint32_t a, uint32_t b)
     return fd.l;
 }
 
-uint32_t helper_frsub(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(frsub)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -183,7 +183,7 @@ uint32_t helper_frsub(CPUMBState *env, uint32_t a, uint32_t b)
     return fd.l;
 }
 
-uint32_t helper_microblaze_fmul(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(microblaze_fmul)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -198,7 +198,7 @@ uint32_t helper_microblaze_fmul(CPUMBState *env, uint32_t a, uint32_t b)
     return fd.l;
 }
 
-uint32_t helper_microblaze_fdiv(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(microblaze_fdiv)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -213,7 +213,7 @@ uint32_t helper_microblaze_fdiv(CPUMBState *env, uint32_t a, uint32_t b)
     return fd.l;
 }
 
-uint32_t helper_fcmp_un(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fcmp_un)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fa, fb;
     uint32_t r = 0;
@@ -235,7 +235,7 @@ uint32_t helper_fcmp_un(CPUMBState *env, uint32_t a, uint32_t b)
     return r;
 }
 
-uint32_t helper_fcmp_lt(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fcmp_lt)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fa, fb;
     int r;
@@ -251,7 +251,7 @@ uint32_t helper_fcmp_lt(CPUMBState *env, uint32_t a, uint32_t b)
     return r;
 }
 
-uint32_t helper_fcmp_eq(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fcmp_eq)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fa, fb;
     int flags;
@@ -267,7 +267,7 @@ uint32_t helper_fcmp_eq(CPUMBState *env, uint32_t a, uint32_t b)
     return r;
 }
 
-uint32_t helper_fcmp_le(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fcmp_le)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fa, fb;
     int flags;
@@ -284,7 +284,7 @@ uint32_t helper_fcmp_le(CPUMBState *env, uint32_t a, uint32_t b)
     return r;
 }
 
-uint32_t helper_fcmp_gt(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fcmp_gt)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fa, fb;
     int flags, r;
@@ -298,7 +298,7 @@ uint32_t helper_fcmp_gt(CPUMBState *env, uint32_t a, uint32_t b)
     return r;
 }
 
-uint32_t helper_fcmp_ne(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fcmp_ne)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fa, fb;
     int flags, r;
@@ -313,7 +313,7 @@ uint32_t helper_fcmp_ne(CPUMBState *env, uint32_t a, uint32_t b)
     return r;
 }
 
-uint32_t helper_fcmp_ge(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fcmp_ge)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fa, fb;
     int flags, r;
@@ -328,7 +328,7 @@ uint32_t helper_fcmp_ge(CPUMBState *env, uint32_t a, uint32_t b)
     return r;
 }
 
-uint32_t helper_flt(CPUMBState *env, uint32_t a)
+uint32_t HELPER(flt)(CPUMBState *env, uint32_t a)
 {
     CPU_FloatU fd, fa;
 
@@ -337,7 +337,7 @@ uint32_t helper_flt(CPUMBState *env, uint32_t a)
     return fd.l;
 }
 
-uint32_t helper_fint(CPUMBState *env, uint32_t a)
+uint32_t HELPER(fint)(CPUMBState *env, uint32_t a)
 {
     CPU_FloatU fa;
     uint32_t r;
@@ -352,7 +352,7 @@ uint32_t helper_fint(CPUMBState *env, uint32_t a)
     return r;
 }
 
-uint32_t helper_microblaze_fsqrt(CPUMBState *env, uint32_t a)
+uint32_t HELPER(microblaze_fsqrt)(CPUMBState *env, uint32_t a)
 {
     CPU_FloatU fd, fa;
     int flags;
@@ -366,7 +366,7 @@ uint32_t helper_microblaze_fsqrt(CPUMBState *env, uint32_t a)
     return fd.l;
 }
 
-uint32_t helper_pcmpbf(uint32_t a, uint32_t b)
+uint32_t HELPER(pcmpbf)(uint32_t a, uint32_t b)
 {
     unsigned int i;
     uint32_t mask = 0xff000000;
@@ -379,7 +379,7 @@ uint32_t helper_pcmpbf(uint32_t a, uint32_t b)
     return 0;
 }
 
-void helper_stackprot(CPUMBState *env, uint32_t addr)
+void HELPER(stackprot)(CPUMBState *env, uint32_t addr)
 {
     if (addr < env->slr || addr > env->shr) {
         CPUState *cs = env_cpu(env);
@@ -399,12 +399,12 @@ void helper_stackprot(CPUMBState *env, uint32_t addr)
 #include "system/memory.h"
 
 /* Writes/reads to the MMU's special regs end up here.  */
-uint32_t helper_mmu_read(CPUMBState *env, uint32_t ext, uint32_t rn)
+uint32_t HELPER(mmu_read)(CPUMBState *env, uint32_t ext, uint32_t rn)
 {
     return mmu_read(env, ext, rn);
 }
 
-void helper_mmu_write(CPUMBState *env, uint32_t ext, uint32_t rn, uint32_t v)
+void HELPER(mmu_write)(CPUMBState *env, uint32_t ext, uint32_t rn, uint32_t v)
 {
     mmu_write(env, ext, rn, v);
 }
-- 
2.43.0


