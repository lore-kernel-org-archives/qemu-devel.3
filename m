Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C196606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ndTjtEk8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gihw5JsD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI2s-0006RQ-St; Fri, 23 Oct 2026 12:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI2Z-0005h6-DW
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:22:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI2U-000382-Nu
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:22:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5wl32109186
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cXxGEShmoR2B48JvpnW4P/rdjicgcv8ibV83usvsnMU=; b=ndTjtEk8giYQBJEl
 /VeHXf61c7nm0xOpZhf2XEc7ysjPx/7MuYm2CNaSPw+wkSh6vGWbRyGnU2BHAStG
 rPeXP+bqAM5W+CfaaElhqkpL3s4xXJlQ7OZzLCz9vhSQycmaSQoSxgmD86VBj1z5
 iZkLjadlDQoza9Egs3DpHZciTNBoNkgR6wDUSupiMGpDVhL0FAWT6zXnlacKnnuc
 rfS/wG+jxa/qe4Ja8shpap1UF/EIAo25Is/5EgJj1H8c2lVfMSNukJOYbiD65oOn
 Vmfekp1a+SyUyJYmqi9D8ZIPHwngFkO/DcvVn54u43GQrd2ucGk7MroezE6nDZgU
 W43tcg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms4h29-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:22:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f559420f3so108309385a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772560; x=1793377360; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cXxGEShmoR2B48JvpnW4P/rdjicgcv8ibV83usvsnMU=;
 b=Gihw5JsDAQ7d5A8Wze/uEmbL4KXLBn8bBCkQ2JvuL5aH80gXu3a3JbqG12vC5Xeyzr
 AdfXoj1VKnHogWrO2f8/WWI6l1sWm0jtEbqllrnZWZhvF2MnKY6hVTlO/ztpDtucdFiE
 AtOoa5ashuRpfQWJJ1prGzNMEl+jmkJp21XyTv8YDRxhb1/f2+1ToFfwv3CyTX9wSVAI
 nsTUxMpahiFr5WdAWgh2QgM9HQ0J3/fQ9BSG0iwhzaZcXQAQUQMtX702bBQqVd369pnO
 fmxde4dBlPbfFguTh6e9lMDtXOHwZJ/n7SAwLqBknhXeb/TuT1vK4aCh40pB/eyKqinh
 LvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772560; x=1793377360;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cXxGEShmoR2B48JvpnW4P/rdjicgcv8ibV83usvsnMU=;
 b=Xib3K175U52rWyNUbPgFABJgTd0IHcUBx73F8ADsHtvGTC2TBR54HKbVBYXbqfxxR7
 HXIqYYS1WFPDOEMz10Yofc0kldDgRZyhXwPQF4/hvF67fndsuwmilph1lUY+1NWjqu3e
 cSmAU175xqsY5hrcKxnwB26A0+ncvFK0ngvlBUa1ZpBgHyiPL9weoCw7CWzAiozhdimG
 Zn4AoMa908UpBgDc/k2iG9RYYr1Ewo9wjkz2tuUbVJnqtRMRn2ZASIaS1XuX0qPCxNzZ
 7UKKr+lbjhlQb1YJuVlO2F6NVA0Ye7At83JwYW4/HkroLBACGOg+AY+b81D2O74qh14D
 K40A==
X-Gm-Message-State: AFq9FYKjtcYLIxyWM9A3d27l9e0WXafqoKSZMQI1hgWijaWy88/Lfkjj
 0T6UfDcU2rgyueF6sI22g4MKv7K4Qd/aP/JfPSh20qXf1Xi96yvdxBZ9zq0S0vhbHVztbGtlLYt
 +b21QwuLPJKpknO6gBoftPAL2aZp9qfZk57+6RBJ7h083iFYwEicDHhKQkMlaJbW/xhV9
X-Gm-Gg: AYBFou34a4PNqFlB5IxZdLaa8koBOSbxWoYjoFoBJS6ZqnaSn9QtdjkSZFV3wMUyjgE
 sIRSSfDncaMBPuILKj0nxom1dFBMnWrLpyxTOayEQu8a+V3uhOrC9hB/qEfZ/SRVGw4rV6czQGf
 FK+hsxLzQ1RmSc7zAoy1DPfogk61at7UpDPxw+gyRkodB0FJvBLxOvkdKnUpagxnCECG9WQBCcC
 53JneWjfX1oCXJLCw/Q+xvZTZKWTgYtyoBBm1hgWNvyR1y5RzaB9iPjGaHISePxFRPyWC60YeZS
 760cWF6oKhj9SRBD8CvRZqUhgn8d3m5KfmspwW2TKYEXw4ucEwSfXnfAQqUVd+MeKWDtpw67qF3
 0k7kMFzFdwAQGZ98XyFXDu4aHxCQRRu3jjTujmWFn
X-Received: by 2002:a05:620a:6403:b0:93e:b729:879e with SMTP id
 af79cd13be357-93f6f908ed3mr486330285a.23.1792772559405; 
 Fri, 23 Oct 2026 09:22:39 -0700 (PDT)
X-Received: by 2002:a05:620a:6403:b0:93e:b729:879e with SMTP id
 af79cd13be357-93f6f908ed3mr486323285a.23.1792772558349; 
 Fri, 23 Oct 2026 09:22:38 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3ee6a5sm816897f8f.12.2026.10.23.09.22.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:22:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 75/83] target/tricore: define and call helpers using HELPER
 macro
Date: Fri, 23 Oct 2026 18:13:23 +0200
Message-ID: <20261023161332.60153-76-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX3iEm1JcJIOht
 D8817mPp5xnis0nhH1dCCRDHOEkZe5NIQ4xInQo7Htp+Ys2bN3TC11AQ5hhG4wdrSsMBE4RHDd/
 afE8bfv388lhhVvXDdrm24ALbJx8ZUvwpKYgTT3oq8DTprLHcKqkU20biqx1CCOPnkChA6WD+f8
 tvSmsgs7KCHF4/BS0HjZfQRcf73hvewybRUIiniwFlcr3+SqhfPC4mJF3pUJASNoz+5a4zd/xPY
 jG4BJmviygPlfibKnLtst3T9WriF8ZBKkWksQlpuDNVeJyiNC5cEJFun/bqEPLWAn18s4RX3A4t
 RsxCSS3Pd75/N/ezuwowuKPQVHhILxqqlpNX3h7E1anzgvtNYUEFS7STOUO+T5VzmX4YphMmWAu
 SsBnMetrvN2HzOyJ9UAlAH8bX3zsWs9A9mtq7krXaeTwmcKUSVbvqcplbdRoAhuTDa9w5FErjR3
 8SIHTpJ0X2sM/ODDeXg==
X-Proofpoint-GUID: Bf-pEvhwPg9MWftlCRlEI_4Yq_yonbui
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX4Ey5eGQ4ua7g
 nF5SuJ9cvKDyBWy/6ZjvktMzGZUUjDHZH2MneX3yWnODXHaMxDK1DDuksrsDYf0WLfSWW2lG0cc
 eady/aAoMaLne9egylbn3pa0IdMfKak=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb89d1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=eO6AAlOi-fcJYYpl75MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Bf-pEvhwPg9MWftlCRlEI_4Yq_yonbui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230064
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20261019212046.149572-18-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/tricore/fpu_helper.c |  32 +++---
 target/tricore/op_helper.c  | 220 ++++++++++++++++++------------------
 2 files changed, 126 insertions(+), 126 deletions(-)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index fa268a8a6bc..9d323a9b664 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -118,7 +118,7 @@ static void f_update_psw_flags(CPUTriCoreState *env, uint8_t flags)
 }
 
 #define FADD_SUB(op)                                                           \
-uint32_t helper_tricore_f##op(CPUTriCoreState *env, uint32_t r1, uint32_t r2)  \
+uint32_t HELPER(tricore_f##op)(CPUTriCoreState *env, uint32_t r1, uint32_t r2) \
 {                                                                              \
     float32 arg1 = make_float32(r1);                                           \
     float32 arg2 = make_float32(r2);                                           \
@@ -144,7 +144,7 @@ uint32_t helper_tricore_f##op(CPUTriCoreState *env, uint32_t r1, uint32_t r2)  \
 FADD_SUB(add)
 FADD_SUB(sub)
 
-uint32_t helper_tricore_fmul(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(tricore_fmul)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t flags;
     float32 arg1 = make_float32(r1);
@@ -203,7 +203,7 @@ static const uint8_t target_qseed_significand_table[128] = {
     14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2
 };
 
-uint32_t helper_qseed(CPUTriCoreState *env, uint32_t r1)
+uint32_t HELPER(qseed)(CPUTriCoreState *env, uint32_t r1)
 {
     uint32_t arg1, S, E, M, E_minus_one, m_idx;
     uint32_t new_E, new_M, new_S, result;
@@ -251,7 +251,7 @@ uint32_t helper_qseed(CPUTriCoreState *env, uint32_t r1)
     return (uint32_t) result;
 }
 
-uint32_t helper_tricore_fdiv(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(tricore_fdiv)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t flags;
     float32 arg1 = make_float32(r1);
@@ -277,7 +277,7 @@ uint32_t helper_tricore_fdiv(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return (uint32_t)f_result;
 }
 
-uint32_t helper_fmadd(CPUTriCoreState *env, uint32_t r1,
+uint32_t HELPER(fmadd)(CPUTriCoreState *env, uint32_t r1,
                       uint32_t r2, uint32_t r3)
 {
     uint32_t flags;
@@ -303,7 +303,7 @@ uint32_t helper_fmadd(CPUTriCoreState *env, uint32_t r1,
     return (uint32_t)f_result;
 }
 
-uint32_t helper_fmsub(CPUTriCoreState *env, uint32_t r1,
+uint32_t HELPER(fmsub)(CPUTriCoreState *env, uint32_t r1,
                       uint32_t r2, uint32_t r3)
 {
     uint32_t flags;
@@ -331,7 +331,7 @@ uint32_t helper_fmsub(CPUTriCoreState *env, uint32_t r1,
     return (uint32_t)f_result;
 }
 
-uint32_t helper_tricore_fcmp(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(tricore_fcmp)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t result, flags;
     float32 arg1 = make_float32(r1);
@@ -354,7 +354,7 @@ uint32_t helper_tricore_fcmp(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return result;
 }
 
-uint32_t helper_tricore_ftoi(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(tricore_ftoi)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
     int32_t result, flags;
@@ -373,7 +373,7 @@ uint32_t helper_tricore_ftoi(CPUTriCoreState *env, uint32_t arg)
     return (uint32_t)result;
 }
 
-uint32_t helper_hptof(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(hptof)(CPUTriCoreState *env, uint32_t arg)
 {
     float16 f_arg = make_float16(arg);
     uint32_t result = 0;
@@ -409,7 +409,7 @@ uint32_t helper_hptof(CPUTriCoreState *env, uint32_t arg)
     return result;
 }
 
-uint32_t helper_ftohp(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(ftohp)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
     uint32_t result = 0;
@@ -447,7 +447,7 @@ uint32_t helper_ftohp(CPUTriCoreState *env, uint32_t arg)
     return result;
 }
 
-uint32_t helper_tricore_itof(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(tricore_itof)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_result;
     uint32_t flags;
@@ -462,7 +462,7 @@ uint32_t helper_tricore_itof(CPUTriCoreState *env, uint32_t arg)
     return (uint32_t)f_result;
 }
 
-uint32_t helper_utof(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(utof)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_result;
     uint32_t flags;
@@ -478,7 +478,7 @@ uint32_t helper_utof(CPUTriCoreState *env, uint32_t arg)
     return (uint32_t)f_result;
 }
 
-uint32_t helper_ftoiz(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(ftoiz)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
     uint32_t result;
@@ -503,7 +503,7 @@ uint32_t helper_ftoiz(CPUTriCoreState *env, uint32_t arg)
     return result;
 }
 
-uint32_t helper_ftou(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(ftou)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
     uint32_t result;
@@ -535,7 +535,7 @@ uint32_t helper_ftou(CPUTriCoreState *env, uint32_t arg)
     return result;
 }
 
-uint32_t helper_ftouz(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(ftouz)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
     uint32_t result;
@@ -567,7 +567,7 @@ uint32_t helper_ftouz(CPUTriCoreState *env, uint32_t arg)
     return result;
 }
 
-void helper_updfl(CPUTriCoreState *env, uint32_t arg)
+void HELPER(updfl)(CPUTriCoreState *env, uint32_t arg)
 {
     env->FPU_FS =  extract32(arg, 7, 1) & extract32(arg, 15, 1);
     env->FPU_FI = (extract32(arg, 6, 1) & extract32(arg, 14, 1)) << 31;
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 46b17da2bc6..53837ed351f 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -43,7 +43,7 @@ void raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin
     if (class == TRAPC_CTX_MNG && tin == TIN3_FCU) {
         /* upper context cannot be saved, if the context list is empty */
     } else {
-        helper_svucx(env);
+        HELPER(svucx)(env);
     }
 
     /* The return address in a[11] is updated */
@@ -99,7 +99,7 @@ void raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin
     cpu_loop_exit(cs);
 }
 
-void helper_raise_exception_sync(CPUTriCoreState *env, uint32_t class,
+void HELPER(raise_exception_sync)(CPUTriCoreState *env, uint32_t class,
                                  uint32_t tin)
 {
     raise_exception_sync_internal(env, class, tin, 0, 0);
@@ -126,7 +126,7 @@ static uint16_t reverse16(uint16_t val)
     return (rh << 8) | rl;
 }
 
-uint32_t helper_br_update(uint32_t reg)
+uint32_t HELPER(br_update)(uint32_t reg)
 {
     uint32_t index = reg & 0xffff;
     uint32_t incr  = reg >> 16;
@@ -134,7 +134,7 @@ uint32_t helper_br_update(uint32_t reg)
     return reg - index + new_index;
 }
 
-uint32_t helper_circ_update(uint32_t reg, uint32_t off)
+uint32_t HELPER(circ_update)(uint32_t reg, uint32_t off)
 {
     uint32_t index = reg & 0xffff;
     uint32_t length = reg >> 16;
@@ -266,7 +266,7 @@ static uint32_t suov16(CPUTriCoreState *env, int32_t hw0, int32_t hw1)
     return (hw0 & 0xffff) | (hw1 << 16);
 }
 
-uint32_t helper_add_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(add_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int64_t t2 = sextract64(r2, 0, 32);
@@ -274,7 +274,7 @@ uint32_t helper_add_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ssov32(env, result);
 }
 
-uint64_t helper_add64_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
+uint64_t HELPER(add64_ssov)(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
 {
     uint64_t result;
     int64_t ovf;
@@ -299,7 +299,7 @@ uint64_t helper_add64_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
     return result;
 }
 
-uint32_t helper_add_h_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(add_h_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t ret_hw0, ret_hw1;
 
@@ -308,7 +308,7 @@ uint32_t helper_add_h_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ssov16(env, ret_hw0, ret_hw1);
 }
 
-uint32_t helper_addr_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
+uint32_t HELPER(addr_h_ssov)(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
                             uint32_t r2_h)
 {
     int64_t mul_res0 = sextract64(r1, 0, 32);
@@ -354,7 +354,7 @@ uint32_t helper_addr_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
     return (result1 & 0xffff0000ULL) | ((result0 >> 16) & 0xffffULL);
 }
 
-uint32_t helper_addsur_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
+uint32_t HELPER(addsur_h_ssov)(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
                               uint32_t r2_h)
 {
     int64_t mul_res0 = sextract64(r1, 0, 32);
@@ -401,7 +401,7 @@ uint32_t helper_addsur_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
 }
 
 
-uint32_t helper_add_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(add_suov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = extract64(r1, 0, 32);
     int64_t t2 = extract64(r2, 0, 32);
@@ -409,7 +409,7 @@ uint32_t helper_add_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return suov32_pos(env, result);
 }
 
-uint32_t helper_add_h_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(add_h_suov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t ret_hw0, ret_hw1;
 
@@ -418,7 +418,7 @@ uint32_t helper_add_h_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return suov16(env, ret_hw0, ret_hw1);
 }
 
-uint32_t helper_sub_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(sub_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int64_t t2 = sextract64(r2, 0, 32);
@@ -426,7 +426,7 @@ uint32_t helper_sub_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ssov32(env, result);
 }
 
-uint64_t helper_sub64_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
+uint64_t HELPER(sub64_ssov)(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
 {
     uint64_t result;
     int64_t ovf;
@@ -451,7 +451,7 @@ uint64_t helper_sub64_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
     return result;
 }
 
-uint32_t helper_sub_h_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(sub_h_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t ret_hw0, ret_hw1;
 
@@ -460,7 +460,7 @@ uint32_t helper_sub_h_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ssov16(env, ret_hw0, ret_hw1);
 }
 
-uint32_t helper_subr_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
+uint32_t HELPER(subr_h_ssov)(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
                             uint32_t r2_h)
 {
     int64_t mul_res0 = sextract64(r1, 0, 32);
@@ -506,7 +506,7 @@ uint32_t helper_subr_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
     return (result1 & 0xffff0000ULL) | ((result0 >> 16) & 0xffffULL);
 }
 
-uint32_t helper_subadr_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
+uint32_t HELPER(subadr_h_ssov)(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
                               uint32_t r2_h)
 {
     int64_t mul_res0 = sextract64(r1, 0, 32);
@@ -552,7 +552,7 @@ uint32_t helper_subadr_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
     return (result1 & 0xffff0000ULL) | ((result0 >> 16) & 0xffffULL);
 }
 
-uint32_t helper_sub_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(sub_suov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = extract64(r1, 0, 32);
     int64_t t2 = extract64(r2, 0, 32);
@@ -560,7 +560,7 @@ uint32_t helper_sub_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return suov32_neg(env, result);
 }
 
-uint32_t helper_sub_h_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(sub_h_suov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t ret_hw0, ret_hw1;
 
@@ -569,7 +569,7 @@ uint32_t helper_sub_h_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return suov16(env, ret_hw0, ret_hw1);
 }
 
-uint32_t helper_mul_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(mul_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int64_t t2 = sextract64(r2, 0, 32);
@@ -577,7 +577,7 @@ uint32_t helper_mul_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ssov32(env, result);
 }
 
-uint32_t helper_mul_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(mul_suov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = extract64(r1, 0, 32);
     int64_t t2 = extract64(r2, 0, 32);
@@ -586,7 +586,7 @@ uint32_t helper_mul_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return suov32_pos(env, result);
 }
 
-uint32_t helper_sha_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(sha_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int32_t t2 = sextract64(r2, 0, 6);
@@ -601,14 +601,14 @@ uint32_t helper_sha_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ssov32(env, result);
 }
 
-uint32_t helper_abs_ssov(CPUTriCoreState *env, uint32_t r1)
+uint32_t HELPER(abs_ssov)(CPUTriCoreState *env, uint32_t r1)
 {
     uint32_t result;
     result = ((int32_t)r1 >= 0) ? r1 : (0 - r1);
     return ssov32(env, result);
 }
 
-uint32_t helper_abs_h_ssov(CPUTriCoreState *env, uint32_t r1)
+uint32_t HELPER(abs_h_ssov)(CPUTriCoreState *env, uint32_t r1)
 {
     int32_t ret_h0, ret_h1;
 
@@ -621,7 +621,7 @@ uint32_t helper_abs_h_ssov(CPUTriCoreState *env, uint32_t r1)
     return ssov16(env, ret_h0, ret_h1);
 }
 
-uint32_t helper_absdif_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(absdif_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int64_t t2 = sextract64(r2, 0, 32);
@@ -635,7 +635,7 @@ uint32_t helper_absdif_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ssov32(env, result);
 }
 
-uint32_t helper_absdif_h_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(absdif_h_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t t1, t2;
     int32_t ret_h0, ret_h1;
@@ -659,7 +659,7 @@ uint32_t helper_absdif_h_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ssov16(env, ret_h0, ret_h1);
 }
 
-uint32_t helper_madd32_ssov(CPUTriCoreState *env, uint32_t r1,
+uint32_t HELPER(madd32_ssov)(CPUTriCoreState *env, uint32_t r1,
                             uint32_t r2, uint32_t r3)
 {
     int64_t t1 = sextract64(r1, 0, 32);
@@ -671,7 +671,7 @@ uint32_t helper_madd32_ssov(CPUTriCoreState *env, uint32_t r1,
     return ssov32(env, result);
 }
 
-uint32_t helper_madd32_suov(CPUTriCoreState *env, uint32_t r1,
+uint32_t HELPER(madd32_suov)(CPUTriCoreState *env, uint32_t r1,
                             uint32_t r2, uint32_t r3)
 {
     uint64_t t1 = extract64(r1, 0, 32);
@@ -683,7 +683,7 @@ uint32_t helper_madd32_suov(CPUTriCoreState *env, uint32_t r1,
     return suov32_pos(env, result);
 }
 
-uint64_t helper_madd64_ssov(CPUTriCoreState *env, uint32_t r1,
+uint64_t HELPER(madd64_ssov)(CPUTriCoreState *env, uint32_t r1,
                             uint64_t r2, uint32_t r3)
 {
     uint64_t ret, ovf;
@@ -717,7 +717,7 @@ uint64_t helper_madd64_ssov(CPUTriCoreState *env, uint32_t r1,
 }
 
 uint32_t
-helper_madd32_q_add_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
+HELPER(madd32_q_add_ssov)(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
 {
     int64_t result;
 
@@ -757,7 +757,7 @@ helper_madd32_q_add_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
     return (uint32_t)result;
 }
 
-uint64_t helper_madd64_q_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2,
+uint64_t HELPER(madd64_q_ssov)(CPUTriCoreState *env, uint64_t r1, uint32_t r2,
                               uint32_t r3, uint32_t n)
 {
     int64_t t1 = (int64_t)r1;
@@ -808,7 +808,7 @@ uint64_t helper_madd64_q_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2,
     return (uint64_t)result;
 }
 
-uint32_t helper_maddr_q_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
+uint32_t HELPER(maddr_q_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
                              uint32_t r3, uint32_t n)
 {
     int64_t t1 = sextract64(r1, 0, 32);
@@ -841,7 +841,7 @@ uint32_t helper_maddr_q_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
     return ret & 0xffff0000ll;
 }
 
-uint64_t helper_madd64_suov(CPUTriCoreState *env, uint32_t r1,
+uint64_t HELPER(madd64_suov)(CPUTriCoreState *env, uint32_t r1,
                             uint64_t r2, uint32_t r3)
 {
     uint64_t ret, mul;
@@ -866,7 +866,7 @@ uint64_t helper_madd64_suov(CPUTriCoreState *env, uint32_t r1,
     return ret;
 }
 
-uint32_t helper_msub32_ssov(CPUTriCoreState *env, uint32_t r1,
+uint32_t HELPER(msub32_ssov)(CPUTriCoreState *env, uint32_t r1,
                             uint32_t r2, uint32_t r3)
 {
     int64_t t1 = sextract64(r1, 0, 32);
@@ -878,7 +878,7 @@ uint32_t helper_msub32_ssov(CPUTriCoreState *env, uint32_t r1,
     return ssov32(env, result);
 }
 
-uint32_t helper_msub32_suov(CPUTriCoreState *env, uint32_t r1,
+uint32_t HELPER(msub32_suov)(CPUTriCoreState *env, uint32_t r1,
                             uint32_t r2, uint32_t r3)
 {
     uint64_t t1 = extract64(r1, 0, 32);
@@ -905,7 +905,7 @@ uint32_t helper_msub32_suov(CPUTriCoreState *env, uint32_t r1,
     return result;
 }
 
-uint64_t helper_msub64_ssov(CPUTriCoreState *env, uint32_t r1,
+uint64_t HELPER(msub64_ssov)(CPUTriCoreState *env, uint32_t r1,
                             uint64_t r2, uint32_t r3)
 {
     uint64_t ret, ovf;
@@ -937,7 +937,7 @@ uint64_t helper_msub64_ssov(CPUTriCoreState *env, uint32_t r1,
     return ret;
 }
 
-uint64_t helper_msub64_suov(CPUTriCoreState *env, uint32_t r1,
+uint64_t HELPER(msub64_suov)(CPUTriCoreState *env, uint32_t r1,
                             uint64_t r2, uint32_t r3)
 {
     uint64_t ret, mul;
@@ -963,7 +963,7 @@ uint64_t helper_msub64_suov(CPUTriCoreState *env, uint32_t r1,
 }
 
 uint32_t
-helper_msub32_q_sub_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
+HELPER(msub32_q_sub_ssov)(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
 {
     int64_t result;
     int64_t t1 = (int64_t)r1;
@@ -1005,7 +1005,7 @@ helper_msub32_q_sub_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
     return (uint32_t)result;
 }
 
-uint64_t helper_msub64_q_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2,
+uint64_t HELPER(msub64_q_ssov)(CPUTriCoreState *env, uint64_t r1, uint32_t r2,
                               uint32_t r3, uint32_t n)
 {
     int64_t t1 = (int64_t)r1;
@@ -1057,7 +1057,7 @@ uint64_t helper_msub64_q_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2,
     return (uint64_t)result;
 }
 
-uint32_t helper_msubr_q_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
+uint32_t HELPER(msubr_q_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
                              uint32_t r3, uint32_t n)
 {
     int64_t t1 = sextract64(r1, 0, 32);
@@ -1090,7 +1090,7 @@ uint32_t helper_msubr_q_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
     return ret & 0xffff0000ll;
 }
 
-uint32_t helper_abs_b(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(abs_b)(CPUTriCoreState *env, uint32_t arg)
 {
     int32_t b, i;
     int32_t ovf = 0;
@@ -1113,7 +1113,7 @@ uint32_t helper_abs_b(CPUTriCoreState *env, uint32_t arg)
     return ret;
 }
 
-uint32_t helper_abs_h(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(abs_h)(CPUTriCoreState *env, uint32_t arg)
 {
     int32_t h, i;
     int32_t ovf = 0;
@@ -1136,7 +1136,7 @@ uint32_t helper_abs_h(CPUTriCoreState *env, uint32_t arg)
     return ret;
 }
 
-uint32_t helper_absdif_b(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(absdif_b)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t b, i;
     int32_t extr_r2;
@@ -1160,7 +1160,7 @@ uint32_t helper_absdif_b(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_absdif_h(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(absdif_h)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t h, i;
     int32_t extr_r2;
@@ -1185,7 +1185,7 @@ uint32_t helper_absdif_h(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_addr_h(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
+uint32_t HELPER(addr_h)(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
                        uint32_t r2_h)
 {
     int64_t mul_res0 = sextract64(r1, 0, 32);
@@ -1223,7 +1223,7 @@ uint32_t helper_addr_h(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
     return (result1 & 0xffff0000ULL) | ((result0 >> 16) & 0xffffULL);
 }
 
-uint32_t helper_addsur_h(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
+uint32_t HELPER(addsur_h)(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
                          uint32_t r2_h)
 {
     int64_t mul_res0 = sextract64(r1, 0, 32);
@@ -1261,7 +1261,7 @@ uint32_t helper_addsur_h(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
     return (result1 & 0xffff0000ULL) | ((result0 >> 16) & 0xffffULL);
 }
 
-uint32_t helper_maddr_q(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
+uint32_t HELPER(maddr_q)(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
                         uint32_t r3, uint32_t n)
 {
     int64_t t1 = sextract64(r1, 0, 32);
@@ -1289,7 +1289,7 @@ uint32_t helper_maddr_q(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
     return ret & 0xffff0000ll;
 }
 
-uint32_t helper_add_b(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(add_b)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t b, i;
     int32_t extr_r1, extr_r2;
@@ -1315,7 +1315,7 @@ uint32_t helper_add_b(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_add_h(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(add_h)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t h, i;
     int32_t extr_r1, extr_r2;
@@ -1340,7 +1340,7 @@ uint32_t helper_add_h(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_subr_h(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
+uint32_t HELPER(subr_h)(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
                        uint32_t r2_h)
 {
     int64_t mul_res0 = sextract64(r1, 0, 32);
@@ -1378,7 +1378,7 @@ uint32_t helper_subr_h(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
     return (result1 & 0xffff0000ULL) | ((result0 >> 16) & 0xffffULL);
 }
 
-uint32_t helper_subadr_h(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
+uint32_t HELPER(subadr_h)(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
                          uint32_t r2_h)
 {
     int64_t mul_res0 = sextract64(r1, 0, 32);
@@ -1416,7 +1416,7 @@ uint32_t helper_subadr_h(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
     return (result1 & 0xffff0000ULL) | ((result0 >> 16) & 0xffffULL);
 }
 
-uint32_t helper_msubr_q(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
+uint32_t HELPER(msubr_q)(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
                         uint32_t r3, uint32_t n)
 {
     int64_t t1 = sextract64(r1, 0, 32);
@@ -1444,7 +1444,7 @@ uint32_t helper_msubr_q(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
     return ret & 0xffff0000ll;
 }
 
-uint32_t helper_sub_b(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(sub_b)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t b, i;
     int32_t extr_r1, extr_r2;
@@ -1470,7 +1470,7 @@ uint32_t helper_sub_b(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_sub_h(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(sub_h)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t h, i;
     int32_t extr_r1, extr_r2;
@@ -1495,7 +1495,7 @@ uint32_t helper_sub_h(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_eq_b(uint32_t r1, uint32_t r2)
+uint32_t HELPER(eq_b)(uint32_t r1, uint32_t r2)
 {
     uint32_t ret, msk;
     int32_t i;
@@ -1512,7 +1512,7 @@ uint32_t helper_eq_b(uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_eq_h(uint32_t r1, uint32_t r2)
+uint32_t HELPER(eq_h)(uint32_t r1, uint32_t r2)
 {
     int32_t ret = 0;
 
@@ -1527,7 +1527,7 @@ uint32_t helper_eq_h(uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_eqany_b(uint32_t r1, uint32_t r2)
+uint32_t HELPER(eqany_b)(uint32_t r1, uint32_t r2)
 {
     int32_t i;
     uint32_t ret = 0;
@@ -1539,7 +1539,7 @@ uint32_t helper_eqany_b(uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_eqany_h(uint32_t r1, uint32_t r2)
+uint32_t HELPER(eqany_h)(uint32_t r1, uint32_t r2)
 {
     uint32_t ret;
 
@@ -1549,7 +1549,7 @@ uint32_t helper_eqany_h(uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_lt_b(uint32_t r1, uint32_t r2)
+uint32_t HELPER(lt_b)(uint32_t r1, uint32_t r2)
 {
     int32_t i;
     uint32_t ret = 0;
@@ -1563,7 +1563,7 @@ uint32_t helper_lt_b(uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_lt_bu(uint32_t r1, uint32_t r2)
+uint32_t HELPER(lt_bu)(uint32_t r1, uint32_t r2)
 {
     int32_t i;
     uint32_t ret = 0;
@@ -1577,7 +1577,7 @@ uint32_t helper_lt_bu(uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_lt_h(uint32_t r1, uint32_t r2)
+uint32_t HELPER(lt_h)(uint32_t r1, uint32_t r2)
 {
     uint32_t ret = 0;
 
@@ -1592,7 +1592,7 @@ uint32_t helper_lt_h(uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_lt_hu(uint32_t r1, uint32_t r2)
+uint32_t HELPER(lt_hu)(uint32_t r1, uint32_t r2)
 {
     uint32_t ret = 0;
 
@@ -1608,7 +1608,7 @@ uint32_t helper_lt_hu(uint32_t r1, uint32_t r2)
 }
 
 #define EXTREMA_H_B(name, op)                                 \
-uint32_t helper_##name ##_b(uint32_t r1, uint32_t r2)         \
+uint32_t HELPER(name ##_b)(uint32_t r1, uint32_t r2)          \
 {                                                             \
     int32_t i, extr_r1, extr_r2;                              \
     uint32_t ret = 0;                                         \
@@ -1622,7 +1622,7 @@ uint32_t helper_##name ##_b(uint32_t r1, uint32_t r2)         \
     return ret;                                               \
 }                                                             \
                                                               \
-uint32_t helper_##name ##_bu(uint32_t r1, uint32_t r2)        \
+uint32_t HELPER(name ##_bu)(uint32_t r1, uint32_t r2)         \
 {                                                             \
     int32_t i;                                                \
     uint32_t extr_r1, extr_r2;                                \
@@ -1637,7 +1637,7 @@ uint32_t helper_##name ##_bu(uint32_t r1, uint32_t r2)        \
     return ret;                                               \
 }                                                             \
                                                               \
-uint32_t helper_##name ##_h(uint32_t r1, uint32_t r2)         \
+uint32_t HELPER(name ##_h)(uint32_t r1, uint32_t r2)          \
 {                                                             \
     int32_t extr_r1, extr_r2;                                 \
     uint32_t ret = 0;                                         \
@@ -1655,7 +1655,7 @@ uint32_t helper_##name ##_h(uint32_t r1, uint32_t r2)         \
     return ret;                                               \
 }                                                             \
                                                               \
-uint32_t helper_##name ##_hu(uint32_t r1, uint32_t r2)        \
+uint32_t HELPER(name ##_hu)(uint32_t r1, uint32_t r2)         \
 {                                                             \
     uint32_t extr_r1, extr_r2;                                \
     uint32_t ret = 0;                                         \
@@ -1673,7 +1673,7 @@ uint32_t helper_##name ##_hu(uint32_t r1, uint32_t r2)        \
     return ret;                                               \
 }                                                             \
                                                               \
-uint64_t helper_ix##name(uint64_t r1, uint32_t r2)            \
+uint64_t HELPER(ix##name)(uint64_t r1, uint32_t r2)           \
 {                                                             \
     int64_t r2l, r2h, r1hl;                                   \
     uint64_t ret = 0;                                         \
@@ -1695,7 +1695,7 @@ uint64_t helper_ix##name(uint64_t r1, uint32_t r2)            \
     return ret;                                               \
 }                                                             \
                                                               \
-uint64_t helper_ix##name ##_u(uint64_t r1, uint32_t r2)       \
+uint64_t HELPER(ix##name ##_u)(uint64_t r1, uint32_t r2)      \
 {                                                             \
     int64_t r2l, r2h, r1hl;                                   \
     uint64_t ret = 0;                                         \
@@ -1722,7 +1722,7 @@ EXTREMA_H_B(min, <)
 
 #undef EXTREMA_H_B
 
-uint32_t helper_clo_h(uint32_t r1)
+uint32_t HELPER(clo_h)(uint32_t r1)
 {
     uint32_t ret_hw0 = extract32(r1, 0, 16);
     uint32_t ret_hw1 = extract32(r1, 16, 16);
@@ -1740,7 +1740,7 @@ uint32_t helper_clo_h(uint32_t r1)
     return ret_hw0 | (ret_hw1 << 16);
 }
 
-uint32_t helper_clz_h(uint32_t r1)
+uint32_t HELPER(clz_h)(uint32_t r1)
 {
     uint32_t ret_hw0 = extract32(r1, 0, 16);
     uint32_t ret_hw1 = extract32(r1, 16, 16);
@@ -1758,7 +1758,7 @@ uint32_t helper_clz_h(uint32_t r1)
     return ret_hw0 | (ret_hw1 << 16);
 }
 
-uint32_t helper_cls_h(uint32_t r1)
+uint32_t HELPER(cls_h)(uint32_t r1)
 {
     uint32_t ret_hw0 = extract32(r1, 0, 16);
     uint32_t ret_hw1 = extract32(r1, 16, 16);
@@ -1776,7 +1776,7 @@ uint32_t helper_cls_h(uint32_t r1)
     return ret_hw0 | (ret_hw1 << 16);
 }
 
-uint32_t helper_sh(uint32_t r1, uint32_t r2)
+uint32_t HELPER(sh)(uint32_t r1, uint32_t r2)
 {
     int32_t shift_count = sextract32(r2, 0, 6);
 
@@ -1789,7 +1789,7 @@ uint32_t helper_sh(uint32_t r1, uint32_t r2)
     }
 }
 
-uint32_t helper_sh_h(uint32_t r1, uint32_t r2)
+uint32_t HELPER(sh_h)(uint32_t r1, uint32_t r2)
 {
     int32_t ret_hw0, ret_hw1;
     int32_t shift_count;
@@ -1809,7 +1809,7 @@ uint32_t helper_sh_h(uint32_t r1, uint32_t r2)
     }
 }
 
-uint32_t helper_sha(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(sha)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t shift_count;
     int64_t result, t1;
@@ -1847,7 +1847,7 @@ uint32_t helper_sha(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_sha_h(uint32_t r1, uint32_t r2)
+uint32_t HELPER(sha_h)(uint32_t r1, uint32_t r2)
 {
     int32_t shift_count;
     int32_t ret_hw0, ret_hw1;
@@ -1867,7 +1867,7 @@ uint32_t helper_sha_h(uint32_t r1, uint32_t r2)
     }
 }
 
-uint32_t helper_bmerge(uint32_t r1, uint32_t r2)
+uint32_t HELPER(bmerge)(uint32_t r1, uint32_t r2)
 {
     uint32_t i, ret;
 
@@ -1881,7 +1881,7 @@ uint32_t helper_bmerge(uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint64_t helper_bsplit(uint32_t r1)
+uint64_t HELPER(bsplit)(uint32_t r1)
 {
     int32_t i;
     uint64_t ret;
@@ -1898,7 +1898,7 @@ uint64_t helper_bsplit(uint32_t r1)
     return ret;
 }
 
-uint32_t helper_parity(uint32_t r1)
+uint32_t HELPER(parity)(uint32_t r1)
 {
     uint32_t ret;
     uint32_t nOnes, i;
@@ -1934,7 +1934,7 @@ uint32_t helper_parity(uint32_t r1)
     return ret;
 }
 
-uint32_t helper_pack(uint32_t carry, uint32_t r1_low, uint32_t r1_high,
+uint32_t HELPER(pack)(uint32_t carry, uint32_t r1_low, uint32_t r1_high,
                      uint32_t r2)
 {
     uint32_t ret;
@@ -1976,7 +1976,7 @@ uint32_t helper_pack(uint32_t carry, uint32_t r1_low, uint32_t r1_high,
     return ret;
 }
 
-uint64_t helper_unpack(uint32_t arg1)
+uint64_t HELPER(unpack)(uint32_t arg1)
 {
     int32_t fp_exp  = extract32(arg1, 23, 8);
     int32_t fp_frac = extract32(arg1, 0, 23);
@@ -2004,7 +2004,7 @@ uint64_t helper_unpack(uint32_t arg1)
     return ret;
 }
 
-uint64_t helper_dvinit_b_13(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint64_t HELPER(dvinit_b_13)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint64_t ret;
     int32_t abs_sig_dividend, abs_divisor;
@@ -2027,7 +2027,7 @@ uint64_t helper_dvinit_b_13(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint64_t helper_dvinit_b_131(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint64_t HELPER(dvinit_b_131)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint64_t ret = sextract32(r1, 0, 32);
 
@@ -2044,7 +2044,7 @@ uint64_t helper_dvinit_b_131(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint64_t helper_dvinit_h_13(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint64_t HELPER(dvinit_h_13)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint64_t ret;
     int32_t abs_sig_dividend, abs_divisor;
@@ -2067,7 +2067,7 @@ uint64_t helper_dvinit_h_13(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint64_t helper_dvinit_h_131(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint64_t HELPER(dvinit_h_131)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint64_t ret = sextract32(r1, 0, 32);
 
@@ -2084,7 +2084,7 @@ uint64_t helper_dvinit_h_131(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint64_t helper_dvadj(uint64_t r1, uint32_t r2)
+uint64_t HELPER(dvadj)(uint64_t r1, uint32_t r2)
 {
     int32_t x_sign = (r1 >> 63);
     int32_t q_sign = x_sign ^ (r2 >> 31);
@@ -2107,7 +2107,7 @@ uint64_t helper_dvadj(uint64_t r1, uint32_t r2)
     return remainder | quotient;
 }
 
-uint64_t helper_dvstep(uint64_t r1, uint32_t r2)
+uint64_t HELPER(dvstep)(uint64_t r1, uint32_t r2)
 {
     int32_t dividend_sign = extract64(r1, 63, 1);
     int32_t divisor_sign = extract32(r2, 31, 1);
@@ -2139,7 +2139,7 @@ uint64_t helper_dvstep(uint64_t r1, uint32_t r2)
     return ((uint64_t)remainder << 32) | (uint32_t)dividend_quotient;
 }
 
-uint64_t helper_dvstep_u(uint64_t r1, uint32_t r2)
+uint64_t HELPER(dvstep_u)(uint64_t r1, uint32_t r2)
 {
     int32_t dividend_quotient = extract64(r1, 0, 32);
     int64_t remainder = extract64(r1, 32, 32);
@@ -2157,7 +2157,7 @@ uint64_t helper_dvstep_u(uint64_t r1, uint32_t r2)
     return ((uint64_t)remainder << 32) | (uint32_t)dividend_quotient;
 }
 
-uint64_t helper_divide(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint64_t HELPER(divide)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t quotient, remainder;
     int32_t dividend = (int32_t)r1;
@@ -2186,7 +2186,7 @@ uint64_t helper_divide(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ((uint64_t)remainder << 32) | (uint32_t)quotient;
 }
 
-uint64_t helper_divide_u(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint64_t HELPER(divide_u)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t quotient, remainder;
     uint32_t dividend = r1;
@@ -2206,7 +2206,7 @@ uint64_t helper_divide_u(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ((uint64_t)remainder << 32) | quotient;
 }
 
-uint64_t helper_mul_h(uint32_t arg00, uint32_t arg01,
+uint64_t HELPER(mul_h)(uint32_t arg00, uint32_t arg01,
                       uint32_t arg10, uint32_t arg11, uint32_t n)
 {
     uint32_t result0, result1;
@@ -2228,7 +2228,7 @@ uint64_t helper_mul_h(uint32_t arg00, uint32_t arg01,
     return (((uint64_t)result1 << 32)) | result0;
 }
 
-uint64_t helper_mulm_h(uint32_t arg00, uint32_t arg01,
+uint64_t HELPER(mulm_h)(uint32_t arg00, uint32_t arg01,
                        uint32_t arg10, uint32_t arg11, uint32_t n)
 {
     uint64_t ret;
@@ -2253,7 +2253,7 @@ uint64_t helper_mulm_h(uint32_t arg00, uint32_t arg01,
     ret = ret << 16;
     return ret;
 }
-uint32_t helper_mulr_h(uint32_t arg00, uint32_t arg01,
+uint32_t HELPER(mulr_h)(uint32_t arg00, uint32_t arg01,
                        uint32_t arg10, uint32_t arg11, uint32_t n)
 {
     uint32_t result0, result1;
@@ -2276,7 +2276,7 @@ uint32_t helper_mulr_h(uint32_t arg00, uint32_t arg01,
     return (result1 & 0xffff0000) | (result0 >> 16);
 }
 
-uint32_t helper_crc32b(uint32_t arg0, uint32_t arg1)
+uint32_t HELPER(crc32b)(uint32_t arg0, uint32_t arg1)
 {
     uint8_t buf[1] = { arg0 & 0xff };
 
@@ -2284,7 +2284,7 @@ uint32_t helper_crc32b(uint32_t arg0, uint32_t arg1)
 }
 
 
-uint32_t helper_crc32_be(uint32_t arg0, uint32_t arg1)
+uint32_t HELPER(crc32_be)(uint32_t arg0, uint32_t arg1)
 {
     uint8_t buf[4];
     stl_be_p(buf, arg0);
@@ -2292,7 +2292,7 @@ uint32_t helper_crc32_be(uint32_t arg0, uint32_t arg1)
     return crc32(arg1, buf, 4);
 }
 
-uint32_t helper_crc32_le(uint32_t arg0, uint32_t arg1)
+uint32_t HELPER(crc32_le)(uint32_t arg0, uint32_t arg1)
 {
     uint8_t buf[4];
     stl_le_p(buf, arg0);
@@ -2325,7 +2325,7 @@ static uint32_t crc_div(uint32_t crc_in, uint32_t data, uint32_t gen,
     return crc_in;
 }
 
-uint32_t helper_crcn(uint32_t arg0, uint32_t arg1, uint32_t arg2)
+uint32_t HELPER(crcn)(uint32_t arg0, uint32_t arg1, uint32_t arg2)
 {
     uint32_t crc_out, crc_in;
     uint32_t n = extract32(arg0, 12, 4) + 1;
@@ -2363,7 +2363,7 @@ uint32_t helper_crcn(uint32_t arg0, uint32_t arg1, uint32_t arg2)
     return extract32(crc_out, 0, n);
 }
 
-uint32_t helper_shuffle(uint32_t arg0, uint32_t arg1)
+uint32_t HELPER(shuffle)(uint32_t arg0, uint32_t arg1)
 {
     uint32_t resb;
     uint32_t byte_select;
@@ -2532,7 +2532,7 @@ static void restore_context_lower(CPUTriCoreState *env, uint32_t ea,
     env->gpr_d[7] = cpu_ldl_le_data(env, ea + 60);
 }
 
-void helper_call(CPUTriCoreState *env, uint32_t next_pc)
+void HELPER(call)(CPUTriCoreState *env, uint32_t next_pc)
 {
     uint32_t tmp_FCX;
     uint32_t ea;
@@ -2595,7 +2595,7 @@ void helper_call(CPUTriCoreState *env, uint32_t next_pc)
     psw_write(env, psw);
 }
 
-void helper_ret(CPUTriCoreState *env)
+void HELPER(ret)(CPUTriCoreState *env)
 {
     uint32_t ea;
     uint32_t new_PCXI;
@@ -2648,7 +2648,7 @@ void helper_ret(CPUTriCoreState *env)
     }
 }
 
-void helper_bisr(CPUTriCoreState *env, uint32_t const9)
+void HELPER(bisr)(CPUTriCoreState *env, uint32_t const9)
 {
     uint32_t tmp_FCX;
     uint32_t ea;
@@ -2692,7 +2692,7 @@ void helper_bisr(CPUTriCoreState *env, uint32_t const9)
     }
 }
 
-void helper_rfe(CPUTriCoreState *env)
+void HELPER(rfe)(CPUTriCoreState *env)
 {
     uint32_t ea;
     uint32_t new_PCXI;
@@ -2736,7 +2736,7 @@ void helper_rfe(CPUTriCoreState *env)
     psw_write(env, new_PSW);
 }
 
-void helper_rfm(CPUTriCoreState *env)
+void HELPER(rfm)(CPUTriCoreState *env)
 {
     env->PC = (env->gpr_a[11] & ~0x1);
     /* ICR.IE = PCXI.PIE; */
@@ -2755,31 +2755,31 @@ void helper_rfm(CPUTriCoreState *env)
     }
 }
 
-void helper_ldlcx(CPUTriCoreState *env, uint32_t ea)
+void HELPER(ldlcx)(CPUTriCoreState *env, uint32_t ea)
 {
     uint32_t dummy;
     /* insn doesn't load PCXI and RA */
     restore_context_lower(env, ea, &dummy, &dummy);
 }
 
-void helper_lducx(CPUTriCoreState *env, uint32_t ea)
+void HELPER(lducx)(CPUTriCoreState *env, uint32_t ea)
 {
     uint32_t dummy;
     /* insn doesn't load PCXI and PSW */
     restore_context_upper(env, ea, &dummy, &dummy);
 }
 
-void helper_stlcx(CPUTriCoreState *env, uint32_t ea)
+void HELPER(stlcx)(CPUTriCoreState *env, uint32_t ea)
 {
     save_context_lower(env, ea);
 }
 
-void helper_stucx(CPUTriCoreState *env, uint32_t ea)
+void HELPER(stucx)(CPUTriCoreState *env, uint32_t ea)
 {
     save_context_upper(env, ea);
 }
 
-void helper_svlcx(CPUTriCoreState *env)
+void HELPER(svlcx)(CPUTriCoreState *env)
 {
     uint32_t tmp_FCX;
     uint32_t ea;
@@ -2822,7 +2822,7 @@ void helper_svlcx(CPUTriCoreState *env)
     }
 }
 
-void helper_svucx(CPUTriCoreState *env)
+void HELPER(svucx)(CPUTriCoreState *env)
 {
     uint32_t tmp_FCX;
     uint32_t ea;
@@ -2865,7 +2865,7 @@ void helper_svucx(CPUTriCoreState *env)
     }
 }
 
-void helper_rslcx(CPUTriCoreState *env)
+void HELPER(rslcx)(CPUTriCoreState *env)
 {
     uint32_t ea;
     uint32_t new_PCXI;
@@ -2897,12 +2897,12 @@ void helper_rslcx(CPUTriCoreState *env)
     env->PCXI = new_PCXI;
 }
 
-void helper_psw_write(CPUTriCoreState *env, uint32_t arg)
+void HELPER(psw_write)(CPUTriCoreState *env, uint32_t arg)
 {
     psw_write(env, arg);
 }
 
-uint32_t helper_psw_read(CPUTriCoreState *env)
+uint32_t HELPER(psw_read)(CPUTriCoreState *env)
 {
     return psw_read(env);
 }
-- 
2.55.0


