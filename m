Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8B1CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnrI-0008JS-K2; Mon, 05 Oct 2026 14:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqf-0007e3-Hv
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqd-0005n8-NR
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:41 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLwjb2207552
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qg7+5KQ/iu7wwjJMv1unmHfU6kdQYPa7UxbzroAesjE=; b=RelYnqSbUtO8hBIu
 DbpA/EoejhijsL8+tg+u0Bh/QyS/jdVmRnaThEViQm04Z/sC3o4H4UeACz2Qf5ze
 S0R+ouNi7JPAVMBEnHB6KWZ8p2DGIsmqAHeNSQNPXfOKB3zjFxvNAo76BBa8cuXr
 rRf3Tg1q4HMSUU9FrGgeZAJzogyMa+Qj6WwqPPutG/Do09UDRdyVg63wb7vWYfIf
 Cbno/G8G55op4UZuvwDkdJ+2vGiPOXpZTsISkU+2lcT2kXybUqPe8nr2Xu55ii+2
 RIN3tSQGvJRQ2k5n7qzkG520IfJZf+IoTT1xsQl8YMXa6QVcuc2ob38Q97/DqqZB
 8v8kDA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4a7dsww7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:27 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34d80ca2184so2766950eec.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226527; x=1791831327; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Qg7+5KQ/iu7wwjJMv1unmHfU6kdQYPa7UxbzroAesjE=;
 b=URTyu01auWz+po7/xsyhQPXu/EUWPFqjK0M2x0Tv2OYSAoCB8d3U8+L+sFkl2J/8Ma
 jgHdjqzJ+oQSbW+IQqx8QQEP/CX7yuPt00erD2zSvMiW2OV7a5wu6AHtSvM1+1/8eOJT
 LXMHBo1SQkZlOU7ZvXJiKbP7yUL3t7sMhzVTsehq7mph+dkvr/UKY9FA6GDYRYG9xwJt
 30plUBLQfl1ILLPIwQTSXURHQuwjliGGXVqewdm2iXo4Z7JBpujvCckjUUw2QVe1o6P3
 ePofCLO83HcCXcoN+DFQXYs2ax7XRGvn7+4R3sBhKxm+NTi2bZs2Mlb3GegZfbx5Wlgv
 H+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226527; x=1791831327;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qg7+5KQ/iu7wwjJMv1unmHfU6kdQYPa7UxbzroAesjE=;
 b=omizoDM6UALjlOyA834CsFK47UkQpm5VhibTs+3AYuJdi7w/5RqzbJxdRo0Ss74edH
 povxSL+4wSh0UuoPSy2xy/RRQMKXIiINtfjp5eRVCgGe6CnTlFGU3RYa9ixnl1YpeHB6
 qz4XRpEGTNtdIHyvgso8kTNveC/ORrnfRk8EkmeWvlSHgIYrRPuv0+0tnsrWjui8yvyi
 hTv0Vrh/vdm2bNmTRlpKA0iCu3bE3CPNIiDz3/IfLrRpnkHs18cXSRl3Q5WB2UP5b2AI
 5zVtFf6i6dV6P6jly+3mnf3/lxqYU+9YlotGELsDTgltrxpkRiqg2zhMAfcG8jQxxOSO
 KoOg==
X-Gm-Message-State: AFuF++kEZiM+O8uOk/sH3v9Gy9AE41YVohsAiosJxEP6fsfT/tD5xDc5
 VYjywA0L0zVhW0vd6182tm9XWIfIRBN6ekv7jYtJMS4sTRPYa+3Hq5d0JMaRuFLz8J7kWceRprR
 7Q89DMIqWvZTQgmH/OISqeo5zoZOprj1zz1f+/XiHJZfLg8nnDPODSK5vzrHzlnYf8g==
X-Gm-Gg: AYBFou1J+vsoftbMmjosI9+UufY8AdB6sFsbQbyj4zjQbFHSLtPUZHBeZ0k2QMUh87q
 cMf4476H+1wAhddxXDU+S3e9y4gNepn7zFe/+GKf65a69a+gw0GUjEcKHeNzcaSANrD1LpHDrRV
 20t1Ck3nohpYKuz/vFx+V9a8rooNHshAiFk4afQPBD7bHFSD6y9fVJ2L2/ma7guMzwevWoUoGvV
 1p+JsCeks5kgSNyc7pVuceDmC5qxCaGLS0ygHHXAR4NqBierkx14H6ajjURoJwsNci5MTSsu1C8
 prU7++V+T8sLtSf+MMpgxYh1WzaS3ZxHJs7PMKRuE4DYZyybLmXaG5oHGqnaTIjELDbglzRRkr3
 9dZczmEKQnKBlAh/v3qOBuT4KK0F+Nvm1qzw3aHdNVenNTWunwOaZnt/dvsUa
X-Received: by 2002:a05:701b:2051:20b0:147:9ad0:cf25 with SMTP id
 a92af1059eb24-151c435c1eemr11392095c88.46.1791226526780; 
 Mon, 05 Oct 2026 11:55:26 -0700 (PDT)
X-Received: by 2002:a05:701b:2051:20b0:147:9ad0:cf25 with SMTP id
 a92af1059eb24-151c435c1eemr11392065c88.46.1791226526214; 
 Mon, 05 Oct 2026 11:55:26 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 12/22] target/hppa: prefix helpers conflicting with other arch
Date: Mon,  5 Oct 2026 11:54:48 -0700
Message-ID: <20261005185458.405929-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfXzFgoMvSNdsMO
 jBX9WHjMyqIMDBq7c2iTm6gomZOK7TmVygy8+o6+klrgNwqFsEO1Tq7CO/qYqR/Xi/Z7/xOztyZ
 +hsWhN8di4DKlImcZTs8+6vdgpca7oA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX9jrhHStjAABP
 t70WeKgSZsMFAF9Bd0AJFaH3yWG8aMwcnkcs37Tt0wshqeTVE+x/NixwvJn3oQFnfkmWkROxUbA
 mXi2RSZFWDVEBLUN/qUlueJOIdxCMJkyZX8Iqce884lLGNz37aOn/Jw8VoXDEbc69EpIeDsozRA
 bEMRuv1/IjNI5kyh1N/2RtImxmaYyCyD35bwQhQVpOJnhkSfI6E0oCqZCwQ84/6KuW10Sq/PgBp
 eD5bdK8b44dBc4rKZE67i0FGePNzdMNUZ2IlRUpszZUMXvCBaPXg/Q+h53Lom17rH8vBqYj/ThE
 KqJ7wPmAm8TIvo41/P2kWVUJpBcvIBaJZA+jtaqQY3pJS3Cve4P+8Ffg6hjJsIu+TxdGDw/UFcR
 xlZdXVKrV1JCU1Bjg1SwfQntJ/xNYL28Tc+uwpfJu2wFB9Lc71cFIICCxBtOnX0pdEBsPPh14UJ
 6fP0AreQmQzAQpN/L+g==
X-Proofpoint-GUID: CkEGyYXxzfjPI5ans8gZFQ22z-a-ojAe
X-Authority-Analysis: v=2.4 cv=SvwFe/O0 c=1 sm=1 tr=0 ts=6ac3f29f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=O6_tSJhFkAU4UwOEi8cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: CkEGyYXxzfjPI5ans8gZFQ22z-a-ojAe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050074
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
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-13-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/hppa/helper.h     | 6 +++---
 target/hppa/op_helper.c  | 4 ++--
 target/hppa/sys_helper.c | 8 ++++----
 target/hppa/translate.c  | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 8369855d78e..8d7fa1ae348 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -1,4 +1,4 @@
-DEF_HELPER_2(excp, noreturn, env, int)
+DEF_HELPER_2(hppa_excp, noreturn, env, int)
 
 DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
@@ -82,8 +82,8 @@ DEF_HELPER_FLAGS_4(fmpynfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_0(read_interval_timer, TCG_CALL_NO_RWG, tl)
 
 #ifndef CONFIG_USER_ONLY
-DEF_HELPER_1(halt, noreturn, env)
-DEF_HELPER_1(reset, noreturn, env)
+DEF_HELPER_1(hppa_halt, noreturn, env)
+DEF_HELPER_1(hppa_reset, noreturn, env)
 DEF_HELPER_1(rfi, void, env)
 DEF_HELPER_1(rfi_r, void, env)
 DEF_HELPER_FLAGS_2(b_gate_priv, TCG_CALL_NO_WG, i64, env, i64)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 76a8d8a0d34..3542c275663 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -30,7 +30,7 @@
 #include "user/page-protection.h"
 #endif
 
-G_NORETURN void HELPER(excp)(CPUHPPAState *env, int excp)
+G_NORETURN void HELPER(hppa_excp)(CPUHPPAState *env, int excp)
 {
     CPUState *cs = env_cpu(env);
 
@@ -341,7 +341,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
         if (excp == EXCP_DTLB_MISS) {
             excp = EXCP_NA_DTLB_MISS;
         }
-        helper_excp(env, excp);
+        helper_hppa_excp(env, excp);
     }
     return (want & prot) != 0;
 #endif
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index 88109f0181a..f7fd80b5830 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -48,16 +48,16 @@ void HELPER(write_interval_timer)(CPUHPPAState *env, target_ulong val)
     timer_mod(cpu->alarm_timer, timeout);
 }
 
-void HELPER(halt)(CPUHPPAState *env)
+void HELPER(hppa_halt)(CPUHPPAState *env)
 {
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-    helper_excp(env, EXCP_HLT);
+    helper_hppa_excp(env, EXCP_HLT);
 }
 
-void HELPER(reset)(CPUHPPAState *env)
+void HELPER(hppa_reset)(CPUHPPAState *env)
 {
     qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    helper_excp(env, EXCP_HLT);
+    helper_hppa_excp(env, EXCP_HLT);
 }
 
 target_ulong HELPER(swap_system_mask)(CPUHPPAState *env, target_ulong nsm)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 41300c0dd73..befdb58e9a6 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -726,7 +726,7 @@ static void install_link(DisasContext *ctx, unsigned link, bool with_sr0)
 
 static void gen_excp_1(int exception)
 {
-    gen_helper_excp(tcg_env, tcg_constant_i32(exception));
+    gen_helper_hppa_excp(tcg_env, tcg_constant_i32(exception));
 }
 
 static void gen_excp(DisasContext *ctx, int exception)
@@ -2450,7 +2450,7 @@ static bool trans_halt(DisasContext *ctx, arg_halt *a)
 #ifndef CONFIG_USER_ONLY
     set_psw_xb(ctx, 0);
     nullify_over(ctx);
-    gen_helper_halt(tcg_env);
+    gen_helper_hppa_halt(tcg_env);
     ctx->base.is_jmp = DISAS_NORETURN;
     return nullify_end(ctx);
 #endif
@@ -2462,7 +2462,7 @@ static bool trans_reset(DisasContext *ctx, arg_reset *a)
 #ifndef CONFIG_USER_ONLY
     set_psw_xb(ctx, 0);
     nullify_over(ctx);
-    gen_helper_reset(tcg_env);
+    gen_helper_hppa_reset(tcg_env);
     ctx->base.is_jmp = DISAS_NORETURN;
     return nullify_end(ctx);
 #endif
-- 
2.47.3


