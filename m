Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86362606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D5tK45Yi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KWm8NiGL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIung-0001kV-Rz; Mon, 19 Oct 2026 17:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunZ-0001it-4j
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunX-0005ib-JT
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:36 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK7ri4106627
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=aW8hSLu9LsP
 1qWn+BWxVhZy3OVLFt/L7PumrmGVCQTA=; b=D5tK45YivC8zn/1JRUQIDG155rS
 HH4rQBGNFDFpLzT7k2Jwj2gtY1ys55zCwnXI5ndzTpBhlElKmQ1R3Bn2j9gEc35I
 NUbIX9rfISTuOuIrZ1dFQzD79+6HM5xdH9JL18vabWC4/lvkwiwq0PD1L2cCAps+
 rD6pLv8StTS0lbX3uHqVRJnOLziLAUvQxQpgp/mW2sDvgcFTE0UsL54FfRXJ31Uh
 fZCBbQ+u3F2AFytlzOlbqZ97OCrjGjVCpvSISb8WRWEVRl5GmSdpzqR10s60O2A/
 Py0wxrQlRt4toYrdR2JyII/RvFYOaAICiZ8mMsfA/Wdxqg9CDRKSY7PlW+w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr780nug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab7f1efe5dso5339554a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444884; x=1793049684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aW8hSLu9LsP1qWn+BWxVhZy3OVLFt/L7PumrmGVCQTA=;
 b=KWm8NiGLr7BVkQCvzX2bGaet+CLacF0nzfLAFTis2ciuttMavHD35yzlkSdbDjD3pE
 TCpxPsijhEg6ChorbubdWTRL/z7WqUPmja7++76Qa1vj9mWZK1HDilho+yD2bJg+6+6w
 FUOzEBqu1HwCkKBRjqYWLa63pAWKdA540L07+CB3gpfuu2aKTQkH+mAY9miQlmVoCACt
 AZsY8cPzQXidabU9DZacgXI+OLmOpIoJOarF/dsjyDTZnF6vNnMEI8G59e0ia9fmdt6s
 vxyYPPQvJVNtN6ynN2gemdWIeUkLtjOLZ8FyHBtB7zQ2p98RTur/c1PF2Ya/MGo5aIVp
 NrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444884; x=1793049684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aW8hSLu9LsP1qWn+BWxVhZy3OVLFt/L7PumrmGVCQTA=;
 b=zcGmHJ2L5eyU3b8L+isz0ULKyfM5w6EUWpQinIUqd3p0LpVOMJN0E9m0LhDDS06uLl
 ka6TO1go5kymahZNli0pz1jGNOfgJvM1cyGWpRB1irxdXsVprk2ENLaPwwoLdlp+MBYz
 jnxFBZEo4MLlWE2oedaBQZllATJSEQjjk+1OBBNF2e08nR0HxMsCkqETqBUeb4DGIa4Y
 dbwhkvOnZf2QjUcdlgAae8QZgnmwIKnY9jBLHc3c6FtU+45CNFqwHjWzwtnjoPRn4ODm
 ZsEsBT5DZLDpsgFQI738ywuQ3vjoAEqabBRMbi18rQ1s8AeZXflB8nt9PaH4xYeweea5
 bByw==
X-Gm-Message-State: AFq9FYIwYfRv3BnshAWyOT0lv7ahb7TWZ+mZMrjf9mDa2jBvaWVuQowy
 ldJ/ukpV2/o8c1Av0VwZvnr0Q3sawjeQeR1brny2e+dX5qXhhuE4PDlPOkIKkmiY0NxtTgRAfGG
 gshMtN8qHO2Y3woAGh6MHc/bpK9mcjeU+PCcoVCDw9AQziS6429QKjOlsUA6jVNq+aw==
X-Gm-Gg: AYBFou0TIgYjoA0jddmpRB2kSr1VMCIl2EQdcA8WyiiWjkuOAJwkvZOtNa+urh9PeqI
 jWA7ctVIydPGTha6hfVYOeVSI+3aKhy/7h9strw81IhRXFY7LMk3XnqzAwd+HJRlqR01WXYtdml
 T+rAHpDNoU6mu0nCI3FSdN6v5yPogimbsnUdo0z2Vtcm2ULaBR6KBZ+TN1urKMDSBi7VVmHIFOr
 nvBys/n8fpTWDhmST0O6wnnvAq5ZDuo/2Lu83LeLtIzaPQ7VfVeghKi7hB++UNIxhqWDZJcY9dt
 3b3k/2UpqOwpOk4TGJOjg+MxzFJsMz40Te+3yRXrJsXVMa+taopSTZpqEliZ6JCIsD5K2oGxZAh
 ORCXuVDblZea6E7XO6ib9rz2YtOkfa+/mMAbIm56UbJ+3Ebm5b2xOqz6KoSNZLh0=
X-Received: by 2002:a17:90b:380b:b0:3ab:413:49b1 with SMTP id
 98e67ed59e1d1-3aceefb87eemr7541801a91.48.1792444883765; 
 Mon, 19 Oct 2026 14:21:23 -0700 (PDT)
X-Received: by 2002:a17:90b:380b:b0:3ab:413:49b1 with SMTP id
 98e67ed59e1d1-3aceefb87eemr7541786a91.48.1792444883263; 
 Mon, 19 Oct 2026 14:21:23 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 20/26] target/alpha: remove explicit target specific prefix
Date: Mon, 19 Oct 2026 21:20:39 +0000
Message-ID: <20261019212046.149572-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX7yiKi/ZJurVz
 ERqpeuajyeEP2ae5EDCNkKLeaygsLV6uePqMUAE3YdZ2MGVl362parooyfK5LXuWkIOzPb1Suix
 +dIOqUpunMMFhFdUIl0BJUsrMqsZASr6wHf4elzrZplsv776pJpl7oU/4igcxnGVu4I2GcBhRcr
 29Hs2UTJvhzcZlSCgZKQ66fF2h+qOUy+EwMGBRfRbfwsyQSgaaA/6zrK0GH5Vh+GORQ1rVHbz+x
 /hIf4bOXT7WLZIdwdmPYZIOFHVoYjdeAh2hWkCWknho9mA06m1x/8aV+ugYfr6BdzhiI7datmtF
 rNcaSzCLMLzCVQ5rz1t3dqwvMEVKNQTiudZs7BQKrGSuKdpdc8Sjy9P2itiK5dLe3OROvSlMyHl
 cSnL8niF6eekVwzK6E0UlLNNA9baOVvEx/IM/xZXuvzVoIayHYgzF9AlwNtO4DYfHmrzYshO6nP
 Cel+ztSBd0E9SF+pg5A==
X-Proofpoint-GUID: 7NsvG17WIG8dnIpwTw-ccMiqkTtNhhu1
X-Authority-Analysis: v=2.4 cv=LKnz05W9 c=1 sm=1 tr=0 ts=6ad689d4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=8l8H8-3bjoOVfk95vZ4A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX7oHCX2B91h3F
 ldgCOr+QBoSPPS/jXW7YTHNFzimeBriOy2zEcgOYEU/mbY2TUu/HhD5ENIGnO3UyNMyM/pTKRSr
 htGmRv1Ubq9oUQ5M1swfROZbjHPXrCo=
X-Proofpoint-ORIG-GUID: 7NsvG17WIG8dnIpwTw-ccMiqkTtNhhu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
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

Now that we have a generic mechanism to prefix all helpers, we can undo the
recent changes that fixed conflicts between targets in multi-target set.

This reverts commit e39401e0b4005389790bf847949c9e5950f5fa55
"target/alpha: prefix divs helper"

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/alpha/fpu_helper.c | 2 +-
 target/alpha/helper.h     | 2 +-
 target/alpha/translate.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 61166396f6e..9eb64058765 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -248,7 +248,7 @@ uint64_t HELPER(muls)(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float32_to_s(fr);
 }
 
-uint64_t HELPER(alpha_divs)(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t HELPER(divs)(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float32 fa, fb, fr;
 
diff --git a/target/alpha/helper.h b/target/alpha/helper.h
index e2f0b96db7c..954a5c8294c 100644
--- a/target/alpha/helper.h
+++ b/target/alpha/helper.h
@@ -47,7 +47,7 @@ DEF_HELPER_FLAGS_1(memory_to_s, TCG_CALL_NO_RWG_SE, i64, i32)
 DEF_HELPER_FLAGS_3(adds, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(subs, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(muls, TCG_CALL_NO_RWG, i64, env, i64, i64)
-DEF_HELPER_FLAGS_3(alpha_divs, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_2(sqrts, TCG_CALL_NO_RWG, i64, env, i64)
 
 DEF_HELPER_FLAGS_3(addt, TCG_CALL_NO_RWG, i64, env, i64, i64)
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index ac57e4d2623..c66e3f9c146 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -790,7 +790,7 @@ static inline void glue(gen_, name)(DisasContext *ctx,                  \
 IEEE_ARITH3(adds)
 IEEE_ARITH3(subs)
 IEEE_ARITH3(muls)
-IEEE_ARITH3(alpha_divs)
+IEEE_ARITH3(divs)
 IEEE_ARITH3(addt)
 IEEE_ARITH3(subt)
 IEEE_ARITH3(mult)
@@ -2086,7 +2086,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
         case 0x03:
             /* DIVS */
             REQUIRE_FEN;
-            gen_alpha_divs(ctx, ra, rb, rc, fn11);
+            gen_divs(ctx, ra, rb, rc, fn11);
             break;
         case 0x20:
             /* ADDT */
-- 
2.43.0


