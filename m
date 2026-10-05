Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C43CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnqb-0007bI-Sh; Mon, 05 Oct 2026 14:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqR-0007Rv-1p
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqP-0005lG-8f
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:26 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLENT2567954
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lGuCZ0sTNbz+rxWlhFICl/GNhyThLvzac7S6gj+Imug=; b=IURZUhynwi6YpnVK
 ojJMhTRqaxuC80KXSlk/pe8mGa4RwxHE1C+dtKs3zcSDTyhto0QW5pJRIW/Wb0tz
 x81niN0g1n05fzonQJQI4Muj2RUZyrwWBYHtdLlYzJONFJ63iNQT6zSol2U7wDZt
 SQWAUcQjjwQJqwz9hWzvpuk1G8VwlkeF6oPV0NqpKXHR3pG/FnCHn2N+z1OnJAZY
 L1tnUN/gPEE76CiWVflR6rgauNmy2xdqzIWWwmnIZd+uD02UsNkN5yBwyWoMPaQR
 vJEwY268DWjYc4vX0+0sBJi4AHGo51jcfJzadSSpJTiwHq6lTfIe8yOkWWJFRAOH
 mXNgsw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cj61ey1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3425098ae4bso1465902eec.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226523; x=1791831323; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lGuCZ0sTNbz+rxWlhFICl/GNhyThLvzac7S6gj+Imug=;
 b=YHOn+bvjt4KRXjnfYh25YKWnFWGqScmRMVIVXXFrJOGumgYzcpTVEoh0xUmJscQilJ
 rYL9+Lixa+2Rc9GjgqYQMGqklKbjYmAaVnQhWXShcMfZVfKUCF8rtpdLyfo45o+4uxvP
 HqFQA9YYruAqcRFbTRY8LiQFdAg+ct3x1CYKWFCZjad7zr5C8zVnUYezeghXX72+yZD9
 u1mdpZWwFKUgxk3KUcELtQ/4FKCZAXOHrVPD76XZMHTCzy35AGnnrT4OJyEuKo46ioD5
 wQFfF17jvWDswSnPWX8K3QRFQGjqoO1JIPfsEXMKrZoAXMqyj8hABOqpSmZe1xtDGP5H
 TEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226523; x=1791831323;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lGuCZ0sTNbz+rxWlhFICl/GNhyThLvzac7S6gj+Imug=;
 b=K282Prw5y5NOyAM4UU1oW4TmMxHekuBEoZ0D0MIL9a35TzDwMhgbIhNemR+OBpaRlC
 IFB7MXU0p6o8R9NulwtAD+doQaU4NTftS3B6WQ6wy76O1QqLWuMXVsjBrgE6ys0omqpg
 1N3expz2dYtNRqWSDMq3Ok4uxmkHtDRYU3p54+qY03rzAtnRMiepWqeDGG+RnN2N4NOZ
 WC4kSohicBrFkibS6Bm+0huwkaWJpu5aZYmvhF3ZT4V8ssiqhAUBYtS2p6SLLGWm1MAr
 fEPN2Nsbwuz0AEutpLt3lBheEqnozVdl0MJIrXUa/ePqvZinWq0gKB2rjlNHkrYQV6ZH
 dhYw==
X-Gm-Message-State: AFuF++mmWhs44zJm2NL/xkfd1faDnHHdz5lCEVBqCXD4R4tH1TNNLPaO
 b7SN8ewOE/Id2BL0WrnWxr0W+Pe6NfTJ+kaZ1XGrzX+ASvVFdAFglCveFmHITN5UwepNRwS6vMt
 RdbZHDDVR3t3JDUeM68etzBDTO8sytypK6nWxzhncNkO5HgWiyZpENpd9UmEk5XnoTw==
X-Gm-Gg: AYBFou3yl3oIbDfp/s2WRx5bkWeLVStgFqWK2JwrUpWio9Zw0PY0bejjFdRYJMKOj3s
 R24aawtZf5U3HxCansh1iXSukn0XBtFpAuveZXRBgF32gPkuZ0f8hn32UXI1e5MVAZGYSqy/9Qd
 PCtK1vNOJErML0/fGyZP+MMypC0HtZjZN6XIdmoNWa8gwnOPdUAc2AU4KLcLvg3higYJMjMMdKI
 PhqOPUrQ15/QFtRkHcAVwEZnafMBq5rYaHPFEGep45aqiYFQOy1RH2o5xZb6q2RII0j+9JRRv5/
 B7Hp3PT1N8KujX/MQVSLDdPPQBHCAWAt+lDeuIey1WyEMJykrcvQGrRTmnSabP8dejoDv20tEO4
 c7WsnjpMKY0WWdcU1IO2rx9rmIdr2GDZconhm/R6Z7T9sfTO2WiDJ8pTtyTbO
X-Received: by 2002:a05:701b:2407:b0:143:1bb1:b3c3 with SMTP id
 a92af1059eb24-15d27920d73mr632369c88.14.1791226522917; 
 Mon, 05 Oct 2026 11:55:22 -0700 (PDT)
X-Received: by 2002:a05:701b:2407:b0:143:1bb1:b3c3 with SMTP id
 a92af1059eb24-15d27920d73mr632331c88.14.1791226522286; 
 Mon, 05 Oct 2026 11:55:22 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 09/22] target/alpha: prefix divs helper
Date: Mon,  5 Oct 2026 11:54:45 -0700
Message-ID: <20261005185458.405929-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX1+A+WlvF0gbq
 OyKqFAiwYMxNLvV3IH9J4uPmQAdJ43LCLLm1O/OUnSlcKoeLGLz/xQ4u15XtFrICgtNBU3kDUKT
 UVcU9E4NvdD8FRxZQ7Ma+RU7vtYS8QWIRwjJNzA7PTLqG0FwAQAhaOxIwEsfWH8BOyREpnVtCli
 edLVRTn6YW8tEYlKtP9tAogdp/GXl52c5VydDqAYFc6RPSYJSEXJ8qAAEu0m7SREzRIDGW6uERW
 lix2j7GNE7UP+LiW8MsdfnfUA/kpJdgpWRl/GGOl1efiHxPpPJjv8oGI0gUY6Vq6NJQDw+5gEBg
 MWRuC+MQgAKQnLsk9QZK9TryG9WocvOps2nT99GQ3bw8bpK5enaRJBHB71AMc3H+QOykNL+E0DH
 fOK17ONR50eEf1Osn2NG4ZHOHUxgOpvECYF4PHh52Z94H/vAP+f8WvipNe4RoN+/qWOvZnTa3VI
 x3L9OM4WhgFGwR7otRw==
X-Proofpoint-GUID: e3X1damTIcGzlBD1ypS47qjB6GXT_AjF
X-Proofpoint-ORIG-GUID: e3X1damTIcGzlBD1ypS47qjB6GXT_AjF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX7ROdDi2wGKrp
 tt0rJGwLzz8SWyHsbc3M5vsGxDVcf+TfCBFPwrXJD4Cn/FDfHeF1DCRgkD0+VC5/qwlr3TIPztF
 Uy47uklTy5iux1JBEF3qwvgjtkwniIY=
X-Authority-Analysis: v=2.4 cv=bpTZl0ai c=1 sm=1 tr=0 ts=6ac3f29b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=35vY_6FmrPXj7qabJgoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050074
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-10-pierrick.bouvier@oss.qualcomm.com
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
2.47.3


