Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC184CA5FAD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjdr-0007VY-0c; Tue, 29 Sep 2026 22:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdo-0007UR-7t
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdm-00035P-G7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:51 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNQ01A2011736
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3pV427Mchku
 sj2It7B+MiP6xeSSbA8STxdhsRb8sQZ8=; b=EULyv6DQRjYPMCtHzSKR3Vt+7Xh
 hvcuELlJjCjiuvtk9bA6U62Vn9z5vLx/S9iSPJYV3oChLK8WV6Q2oVfj3ZIZzXcc
 JIcVWjHWxl9npFqKlr5d9GWiVFrQa96iVhBbNqQt/7FSvrTl77SDdLhx9uG3paoS
 mggR9oYn0k4bqs+AiMd6dLNybcS1Ywvfe3wv1pkJTKVDOHezu+CZv6Asyhvt5hr6
 cYk4yiAPTcoRMHSe7yKdLzsbOVXKKmsGrie/aJ/XAU53fPoajkj2Ae9XoMEncFkN
 1fc6d9IFetjystjQ2zwPFRDGX4S79OaD3NhbWXHM8RHLLCSXxrCgz/QyAqw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j0ehq4p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:49 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-313d1015161so1277491eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733709; x=1791338509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3pV427Mchkusj2It7B+MiP6xeSSbA8STxdhsRb8sQZ8=;
 b=ZnXnO5Si1CT83LS32wGkQuS3aTFFXYda+LhR9viJJLFNTeL+FF1oS3e2PeIPN0ew0k
 mMoI5CdSoHSPJLtvzVWb1pr08kZ8VTPO1vaoR+Idca3OAQpIy6nYiKUHkksfG1XffTjL
 mA90rMurIkTkmbYR1/2z3ybf0GINIgt4rJw5mKAlLNkaiSLpJUXRDPXikUQrc5BEYG0j
 Fu/jbawhoAi6tQHbdNvN/PU6kRlPGz99q7nvlk84YS52hB3SYofQFf7zse6FIXRW94H3
 KWZjYceZm+X8deWtK47imlVYdTbZahKamYCO3HWpSv9yFidfSsoKny7GSfyAa9qU5Ti1
 xUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733709; x=1791338509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3pV427Mchkusj2It7B+MiP6xeSSbA8STxdhsRb8sQZ8=;
 b=dt26vmYqcyW6Tyzw5xFgnAozSasGSH8h9YNZRJJ4Tdts2YuhYUBjQAYX7nxmrGrHnl
 L67bAqchDLJPVOPSoL2KXgs0EKeAMHYklvnEIpWyy+dNSYu6cSaANNSi6oo1ixVKnHom
 L5FRdEnEul0AoiURqAxasGVTuwD7i0RJFbj/vKxwRzNlyu/4orbP0KVHPqVTjAvIFJ+s
 pHgvxJ3D0h8X7VJ/tYJxASe0WC3mXjH338wHiYzDHF8FQ0QTLaQtq0AkLqugFi/2COjH
 qAWo4mMLmZ4/3Fh7Wbv6M98+x98Kr/64FKiYkIjNetkCQDNON4W1L1cfMOp/T5+jOXIl
 eSzQ==
X-Gm-Message-State: AFq9FYK3jWOctQeTq0VG3Kz1tJvNlHbvWbQgFOLQ2ZBodY3Im0Rd7T67
 aGAmDz293EHwAokpJwKcBzEgwGLGiBPI17gHMIQs04B+J+7CezRSvFclUP8xhvEt66HvXLs6QDV
 cX+XYNw9Ln++51CMyBYXhmu71p1ZagWjvxZJDkblKA8ZhZ60BY/GXmJ2ZfktUpTn5eQ==
X-Gm-Gg: AYBFou1XwFki4k+vc532ioeftCdp+fMzRpN28YG874HOIbYQVVV8AYhobUk5pcwughq
 Yy3/QMlht9hPQmaBlv08FCI9n3R2V5VoBp/0jrishgtOBJ6eDeAyjOz47OYWCa6WT2fOJvr1Flm
 fHXLGa/WwWUPvoqd34+VBxgAD+wEJzYDNvMVwAujW6DAYUz8QaJmkFZl98/dWouPqDeJ+Q163F+
 p7Wz9kBtqIVL39ZktAr/sWizb5AOplbPggrt1Rg+qmPpmgGf1/gcdcCfsL6guzclGmSxJlipBHb
 k2ZmcFFqncQAOOzPc9HHOuN8B/XeTdjR2jPSCsnx7oLxOvzXfhor+marQXwwcX9c1CFgz1nvnyi
 tMoCNML4IwJEGBHloPFT5qudcHtyLdJLuBVMcVwx7SjuYqPzYdsxf2fe5RIP6
X-Received: by 2002:a05:693c:6385:20b0:346:7c2c:1d19 with SMTP id
 5a478bee46e88-34cdb8e5521mr133258eec.16.1790733708600; 
 Tue, 29 Sep 2026 19:01:48 -0700 (PDT)
X-Received: by 2002:a05:693c:6385:20b0:346:7c2c:1d19 with SMTP id
 5a478bee46e88-34cdb8e5521mr133237eec.16.1790733707978; 
 Tue, 29 Sep 2026 19:01:47 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:01:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 09/21] target/alpha: prefix divs helper
Date: Wed, 30 Sep 2026 02:00:56 +0000
Message-ID: <20260930020108.217892-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cqgOAF4i c=1 sm=1 tr=0 ts=6abc6d8d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=35vY_6FmrPXj7qabJgoA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: gW_2wRLVL-Mw-GMgQ3shO9VJgN2zGYhI
X-Proofpoint-ORIG-GUID: gW_2wRLVL-Mw-GMgQ3shO9VJgN2zGYhI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX/9UMuUoI5g1n
 7DX2imf+T+gyK9r8pswPjB8i9NidtgFf+EkwbVCANasDVvURJmkelL/7saq3yEP8jxipV7rRUHZ
 IR0hvvd8GUcljXNjUNkMK9RxlCZPx/0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX8akPFYJaBGQm
 5FaLEcdKG8FCT4YYnkLS8w7xho0NCAq6AScqArVgR8ohnHOfstqZV/qLqrrEoWoY14+lTNvK1qu
 iFTUUXqwRurI9AfOIpAEJuuuiL+b2iTuAyRFCBAZ1CfYecMxEf624lbMNuBgBePMfikRQLwN/2h
 TW7AYkvxIO8x0ompmowOS/SjZCoiRHOmxck/EY+nk3D/lEo4pAD8w6yonI4tU0TGuZ+97ME+nrF
 a9y9aeGSqsA4w0UJC8GW/NjigwOQyXcefd1BhoVHa9z/HXk6psQLMbuL7r1JZC3CZvOYJwiQniR
 svjQkBaDhF6duQ08w1w5rsL9Su5+FY21zOCzKdPp1Sj52K0GjTGssps1+UfGZSN5b/pEWbUNGnr
 yq4RuGKzNnW9AE1mTx2RmGfcsEcsLWvIlQ2/gZsBBhIIg11XpKTJqr+YnFHoyGIGiS8ui0alIpj
 J7ssa+UzfCcT87ZHNcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300007
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
 target/alpha/fpu_helper.c | 2 +-
 target/alpha/helper.h     | 2 +-
 target/alpha/translate.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 5b7e4bd5eb9..529eadca9f2 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -248,7 +248,7 @@ uint64_t helper_muls(CPUAlphaState *env, uint64_t a, uint64_t b)
     return float32_to_s(fr);
 }
 
-uint64_t helper_divs(CPUAlphaState *env, uint64_t a, uint64_t b)
+uint64_t helper_alpha_divs(CPUAlphaState *env, uint64_t a, uint64_t b)
 {
     float32 fa, fb, fr;
 
diff --git a/target/alpha/helper.h b/target/alpha/helper.h
index 954a5c8294c..e2f0b96db7c 100644
--- a/target/alpha/helper.h
+++ b/target/alpha/helper.h
@@ -47,7 +47,7 @@ DEF_HELPER_FLAGS_1(memory_to_s, TCG_CALL_NO_RWG_SE, i64, i32)
 DEF_HELPER_FLAGS_3(adds, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(subs, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(muls, TCG_CALL_NO_RWG, i64, env, i64, i64)
-DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(alpha_divs, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_2(sqrts, TCG_CALL_NO_RWG, i64, env, i64)
 
 DEF_HELPER_FLAGS_3(addt, TCG_CALL_NO_RWG, i64, env, i64, i64)
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index c66e3f9c146..ac57e4d2623 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -790,7 +790,7 @@ static inline void glue(gen_, name)(DisasContext *ctx,                  \
 IEEE_ARITH3(adds)
 IEEE_ARITH3(subs)
 IEEE_ARITH3(muls)
-IEEE_ARITH3(divs)
+IEEE_ARITH3(alpha_divs)
 IEEE_ARITH3(addt)
 IEEE_ARITH3(subt)
 IEEE_ARITH3(mult)
@@ -2086,7 +2086,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
         case 0x03:
             /* DIVS */
             REQUIRE_FEN;
-            gen_divs(ctx, ra, rb, rc, fn11);
+            gen_alpha_divs(ctx, ra, rb, rc, fn11);
             break;
         case 0x20:
             /* ADDT */
-- 
2.43.0


