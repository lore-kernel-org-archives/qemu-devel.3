Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300F606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fQCQ+//m;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TY5dIbvm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgF-00041d-ON; Sat, 24 Oct 2026 13:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg4-0003yE-1L
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg0-0008HI-RX
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:07 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OHRs5x3258205
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VvM4kU6NiiPImnLuuHCMCkKSVWPSGo0/prQ+zq61KkE=; b=fQCQ+//mGy7NP56i
 nrf0HdV2l5S4I9d7VXwNCan6fzIZhNgXCX2pGMguOZTM+Ck843skba+J+om5lueK
 Qe/r1MnfHaM1hq4Ru4tCPLqXqwuiaoai67CQivydoguVmVHRn2JaUPOlHsJpiSE+
 oBr7qpj6G1v1NHIAJQpvyk/KWCHMauN1yOwfB7gQjm4sk3lf3jYCwlkjPRLaIPy+
 TZ83vGu2Fuv+49oot1g8yK5I5/B10xvm1Uw8Vre7dYqVznQOeu3rCVi8PekMLeu2
 DG+00cCp7TORHXTtOfHDuW/INzgQM8ii5xlGMPZ8wCFwT4p/1TLldL/OSxDPJqGd
 jjXk5w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgjcgssf4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d5dbso1513153a91.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863422; x=1793468222; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VvM4kU6NiiPImnLuuHCMCkKSVWPSGo0/prQ+zq61KkE=;
 b=TY5dIbvmZnlUwXUxro9U9E7vEo4TiO9p9X560zZjn1J8TUUoW6/lVeM1nm51Roqsbu
 GrJAwMKK5gOqYA0baLs+SzxAETk++NXaU14QiOgsB0zzowb4LC7YutzeEvxtcKc6Z7BJ
 SHmZrcjVFNHaYwetJau064uEB8Vj1U3DQuen5UqFhMq2fTr6iw82VeUo4gWMSogm5etQ
 hYN7ncCRswPArxRcF2os7XNkjTuOYMw9jikwnKu/UoCgcgjo76Dw9dZ4lmrMJ0J3oBpj
 E1KUKmgUyqfLRt1fBYysJTvmfJe/gWbOiO6Rq1mHSMOXvPYSRO5Zgva2f80YIrMLnpXj
 5ZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863422; x=1793468222;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VvM4kU6NiiPImnLuuHCMCkKSVWPSGo0/prQ+zq61KkE=;
 b=ndcQoZF6SVZPhR4JDC+HgEtjsieIJ+cxzlMfAgvjIHpNV7WW9OhfXE1oeaV+KZW+sy
 FXiA9D5BeDvGUY1UOO8Vqv7TPw0r09KzU2ApPTa5UMRl6Bfi8Xe4gG9Yb7r360tBMKtw
 RCDk0BQKGY60zjphe9ulaJXjRwnI6sWSw6BUNmLchdSzLGL5YqkWKP8jdEpnwLmz71nx
 3i+5DplmnzPTtzYcJ4K2CLoX55Cwoja/HeC0FSaSG9sccxfy6SJK94B0cSjAJGupXr4u
 3YBQs/HYlZgyLFubVfI41uMMBQ3Jd0m36uJ9l286R+IEOGJ8pApa6CGWbCtaozitRd2q
 QbTA==
X-Gm-Message-State: AFq9FYKn5LE4Egy86+rTTlh8lnAAdR+U9rnPXsMeN8XKeu90tK/35nec
 6wuq/P/GYtFy5feX99WdLhuUMhL3RaLkoZAgdbW8jbYpuvGLvsIJqNKlWm1SnGAguT5mx1QRnHP
 4J0x+MUCXh5aeYUDWtw5NR2BkzTaZV9wHip6qzvxtuqiHEL4/8rj7uXIk9BWeMUSgtg==
X-Gm-Gg: AYBFou37giJETHd+CICYJqq4pU6Y03+8L/LvjPzeVMC+1HBDDZsbmI/3oioLDJmeTnh
 ceuNLxBfg7r5eiRbn+7NaKiQMVU6Y7M6I0EVtdHFbtJw4O1s1MjBkJ776FEckEshT1wT5/OyZlb
 HqcYI4GfKMk57c09mhr9IiVEC91HsNxbVG5piu5GVMRhWPYx93iiiz4GeAh+FAgXw+1Iv+VwEP+
 S3fNbRJk62YLWaheRkYy3BequnhrWQoIRG//LI4G4nmYatcGxMaxtKdufttPvy3W0jdvYLfFwjD
 fPdR188q9szT203ChNTJp6oRAcqdGwLwiJXWUvZQ4+ApOIJ0LVNo3o5RV7EIGQxVFuK4kwsn5pT
 YcBLclk7ToV0M/VHSGEmfaPpB1WeH+krtsIJcPkn3fpvyrA91lljv1zkoKHVRIsc=
X-Received: by 2002:a17:90b:4a49:b0:3ac:9d83:8861 with SMTP id
 98e67ed59e1d1-3adeb0f8d94mr2379369a91.67.1792863422072; 
 Sat, 24 Oct 2026 10:37:02 -0700 (PDT)
X-Received: by 2002:a17:90b:4a49:b0:3ac:9d83:8861 with SMTP id
 98e67ed59e1d1-3adeb0f8d94mr2379360a91.67.1792863421608; 
 Sat, 24 Oct 2026 10:37:01 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 05/20] target/alpha: remove explicit target specific prefix
Date: Sat, 24 Oct 2026 17:36:34 +0000
Message-ID: <20261024173649.7405-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX5+5udirAa664
 BTGXbm0iS9hJYXRoO9c7TVmlq2lOt/rdqafONY/zcb9IuZl2+xYK09oENJgix8M+xn/PfftUn8n
 SJWdtA9hoMC6Zw4gs/GJY7n7QHnULRM=
X-Proofpoint-GUID: JMQA-GMmwhd7cqwg2IZ9FkI6s-2Ux_Ng
X-Authority-Analysis: v=2.4 cv=JvhkP84C c=1 sm=1 tr=0 ts=6adcecbe cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=8l8H8-3bjoOVfk95vZ4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX32pw6LYWjeJS
 9rxtneAkH6u056eE2xmMT/w4oGhiDSn6F7HEpcykVzru5ACPuB8NOGd+tkJE+eGSGephh3q3aAV
 tAY0tT10wLag9uhoor4Rboe200WJZH5QZTIBdYTPOTrqNbDDhi3P7/feSFdtHdTSMpuiijB7xl9
 JofDCe9BMU45EgRFBoMVitxzaY4I3Id/CnnDhCB58yER7CCdJaHmQo4Tx/0BGHZyBHb3GIWmBhv
 hwjC0aYlGvA9Ibi/rxOVmUcZ+RGsuvEwRVBuR/u+bz/vVoinS5H2zGFaa9VrwIS6BOmtFOEf6fN
 Dv1yljfjXv/NR/MxQIyOTS7vi65Te5bs6moXmt3uNn7wlNzBhZoVoIYKqaQ1rabP4A0P8GnDiuk
 5Il65/RZs4nF/JHE+3uUtkWz9WYhEXt9vO8wkmETTBfroZuP6C1mfS9K2muFwJ5WnQQAPPrhW5n
 mbWukDKTkDepHfHZx2g==
X-Proofpoint-ORIG-GUID: JMQA-GMmwhd7cqwg2IZ9FkI6s-2Ux_Ng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
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

This reverts commit e39401e0b4005389790bf847949c9e5950f5fa55
"target/alpha: prefix divs helper"

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20261024163249.77855-6-pierrick.bouvier@oss.qualcomm.com
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


