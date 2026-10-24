Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0625606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XU+jYQH+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RkXiaz88
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgB-00040D-Kl; Sat, 24 Oct 2026 13:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg2-0003xw-L5
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKffz-0008Gy-5W
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:05 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF02Zt839093
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AvveQFU/T9gzmMthRCyRMfcRFDjM6fChdp64j30Y14g=; b=XU+jYQH+TNomJQRN
 srXoTV4FWpjJg7PifNTslYnpzgdNf2PmCiTJeQKq6nGsMKl7J3l0X9Ta7diOB5On
 62pKiijfH6mbxzQeUJIcf0gCiJ7VI5xqNw3JpyV7An9gwJ++crLNgfo584N9Kw5o
 OwqHzMS/hU1SNWzZn/9Ftf4cdS1PHkyy75osRzPIkQRCGlaVdf+t/AvIJP7l/NZT
 TgyqE10WEt2UftiVRAVv4JWpBpDjkaFSqKRAh5fUchrWHSUKuRkn9js4PO3QckL+
 d3L5pgFmn3BLyL0tYeWUrxgNLZhZrSEdlilRpfb9Q2sH1oGpreYD+jAKl2N715nd
 UZmrRQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27se56-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3adeba76cadso525696a91.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863420; x=1793468220; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AvveQFU/T9gzmMthRCyRMfcRFDjM6fChdp64j30Y14g=;
 b=RkXiaz88RoDh0g1836q2Mv4DCVFdxhHL14pAF0qWWoBJU/aLAmqloDqBaIDrzWDhXx
 7M+OGiPQYJyMAy1Cp1CsBSWcYi5uhsFFAAr+GZgYOq0NVE8qcB3f9H9odwLK89JMZQqf
 QhbFIRyvqdbBLDxW/VMGQrt0mklPhoTDKHRJWT1SHUtPRLMAI+fXjEg+FYbY2Syd6VJ+
 gndtpov/jfVgekmVNGOIG/yHcJ1YNw2i02vgYV13zfziqhgBXxMKZsOi5n3FSODpjAAP
 mIqM6Tv1E2yWnaTLOi7kCP3aYMt6yQvxWI9HVmozXRkybVT+SwF/ELmpmyNv/wgqlzdG
 ru9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863420; x=1793468220;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AvveQFU/T9gzmMthRCyRMfcRFDjM6fChdp64j30Y14g=;
 b=WLjR1d79Tloz3n0OMZkx1kNc+xLr2ICaxjG6f0et8oDPlCFZBSPeFhNrFp7WZAM0TN
 z/c/x+YlpRqYWi+JQD9vkYiX0iv4KQQ5WmOF0DpQVEAZG8Q4bl9dztc2LymfaFPRsg6Y
 TB341GAYrS6eScSKss5P8k7F7HMvtH00pCWcBNP9v+TXBdOUu0JuQhiwDRH1hAeM26Ne
 aAIjB7QkHgUOvzSQlkxnPWTadYG/m/4yzITfHD3BhwUlkZtc7UWdmKXs3uMt8ZHREO18
 cEcgfBH5QI/3xempHzj05qmANi6kMnXVoufYkHvbdQ3xUkB115ijhSYgnGmIlRGtEN1U
 Ta9g==
X-Gm-Message-State: AFq9FYLiuBvi8M+qIOHZVXFQwET1DiN0QpBDoPI+TTMOmZTxTM8TM7MN
 lAEUEpvnR/6FAGJpZrWf8hsV2zUgHH+Wc7YfFUcg4sC0RVHS4w6ro7lH0omvpNgkdfnNRsEg4Ix
 yB+XRaKLsXm5vZ/wEgAf7qzrv3k/ZQR0+0csm+XmAZF/i92iBlJyE1Nn9VYaY6k8YMg==
X-Gm-Gg: AYBFou0ySfR+j8iJfJNTXdjijukrjzKfYT8A1DhNJ4rKNc7xLC3/9ds8WFfPoWMxSZt
 mO3mHxAM6UGbj1nVrc970vvwBMV9eyl9TB1IecFKWf2nXv53ZIHIJPNeNgwMlFlFxj5Guvcc6WE
 F351GjKZ0A74PmLTRQ+7XsVvJxIGk3aRiUwjSBYG9h24oeJslqF3YPnfVN/Op6WnAFYmzriKdQb
 57Xg2JOPRDhO5TqYKz8xM/uzwIF61tdkeXHzDjzSWjl+WJljDkhzvPm5sbgUJABzlgbZeIeVHQA
 Cheutt0bj1b0wNt609lgWGKXfs4l9rAX306e8yF3hlY1Fi9qRFaXgYlbuHlcYEyqLbM7iquJcf7
 qz0/YsmDOTRkTDfpXhLv4tyh/taae4kbSakKKVRSGMmP+J/83ajQA31f8GmJEh5c=
X-Received: by 2002:a17:90b:55c4:b0:3ac:9785:4c32 with SMTP id
 98e67ed59e1d1-3adeae753b7mr2082460a91.30.1792863419593; 
 Sat, 24 Oct 2026 10:36:59 -0700 (PDT)
X-Received: by 2002:a17:90b:55c4:b0:3ac:9785:4c32 with SMTP id
 98e67ed59e1d1-3adeae753b7mr2082438a91.30.1792863419108; 
 Sat, 24 Oct 2026 10:36:59 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:36:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 01/20] target/rx: define and call helpers using HELPER macro
Date: Sat, 24 Oct 2026 17:36:30 +0000
Message-ID: <20261024173649.7405-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adcecbc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=itqY9gs7vbMVEQc_hZoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: nJcB9riztzsxMm8ttKlsWvvu-CfqeDJd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX/8mlTaQTErt+
 yA5tiNswAh7f37U0X6qi3w3HSoklbYR3c2HjxJLLDvB8DCbDZL41gJ+svmpE/GgtBojv/9ChQM4
 by1+DqNPV1XvyaQPfFEivd9Z97zs/O8=
X-Proofpoint-GUID: nJcB9riztzsxMm8ttKlsWvvu-CfqeDJd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX/euNvxq1VCGo
 T9/LYP1eyHYviTwKzoKMDbkh5RqAM0FFhCluqeIw+Bfq8o9RE3QRcMq9uaSAZZ+GBiT+aqJXIeH
 CkYESGYCCjkGQ/yTtKTFhoaa9sPiowlavgz6nIUEeGIXPu6eRlgKSV4SREwTRDKUxzRK7Fm3z8j
 kUt1WF3NWEGi7gTerbFtj+TYLRgxW9DO+B5Pz7JeJhOEOohosGg2ykpJADQKp848s8nox9p3P20
 u7nmcOwJPZsp6GAhILv45Li7j4w4YRCAeqnK1R0oCHskshDKNQQkCALf7nmWMNLwGmwXSzjoyft
 2ZILheBlsEsvX5TIvu9CPRME2FTEhFrkK/yRzhODy+FitetDRLOKTLODHaw1IZW6fCLEyBZHb41
 B8m51ZS6nIc+vOjDG4LbXBKcHWuKhSmSpqF6rx4XcKNhOaHm9ER3nx/1/pcShd5p+0924nMuDC/
 9wib3orBcNf9xymoDdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240070
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20261024163249.77855-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/rx/op_helper.c | 52 +++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 06841088ac0..5f4f0a14027 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -46,17 +46,17 @@ static void _set_psw(CPURXState *env, uint32_t psw, uint32_t rte)
     }
 }
 
-void helper_set_psw(CPURXState *env, uint32_t psw)
+void HELPER(set_psw)(CPURXState *env, uint32_t psw)
 {
     _set_psw(env, psw, 0);
 }
 
-void helper_set_psw_rte(CPURXState *env, uint32_t psw)
+void HELPER(set_psw_rte)(CPURXState *env, uint32_t psw)
 {
     _set_psw(env, psw, 1);
 }
 
-uint32_t helper_pack_psw(CPURXState *env)
+uint32_t HELPER(pack_psw)(CPURXState *env)
 {
     return rx_cpu_pack_psw(env);
 }
@@ -120,7 +120,7 @@ static void update_fpsw(CPURXState *env, float32 ret, uintptr_t retaddr)
     }
 }
 
-void helper_set_fpsw(CPURXState *env, uint32_t val)
+void HELPER(set_fpsw)(CPURXState *env, uint32_t val)
 {
     static const int roundmode[] = {
         float_round_nearest_even,
@@ -139,7 +139,7 @@ void helper_set_fpsw(CPURXState *env, uint32_t val)
 }
 
 #define FLOATOP(op, func)                                           \
-    float32 helper_##op(CPURXState *env, float32 t0, float32 t1)    \
+    float32 HELPER(op)(CPURXState *env, float32 t0, float32 t1)     \
     {                                                               \
         float32 ret;                                                \
         ret = func(t0, t1, &env->fp_status);                        \
@@ -152,7 +152,7 @@ FLOATOP(rx_fsub, float32_sub)
 FLOATOP(rx_fmul, float32_mul)
 FLOATOP(rx_fdiv, float32_div)
 
-void helper_rx_fcmp(CPURXState *env, float32 t0, float32 t1)
+void HELPER(rx_fcmp)(CPURXState *env, float32 t0, float32 t1)
 {
     int st;
     st = float32_compare(t0, t1, &env->fp_status);
@@ -172,7 +172,7 @@ void helper_rx_fcmp(CPURXState *env, float32 t0, float32 t1)
     }
 }
 
-uint32_t helper_ftoi(CPURXState *env, float32 t0)
+uint32_t HELPER(ftoi)(CPURXState *env, float32 t0)
 {
     uint32_t ret;
     ret = float32_to_int32_round_to_zero(t0, &env->fp_status);
@@ -180,7 +180,7 @@ uint32_t helper_ftoi(CPURXState *env, float32 t0)
     return ret;
 }
 
-uint32_t helper_round(CPURXState *env, float32 t0)
+uint32_t HELPER(round)(CPURXState *env, float32 t0)
 {
     uint32_t ret;
     ret = float32_to_int32(t0, &env->fp_status);
@@ -188,7 +188,7 @@ uint32_t helper_round(CPURXState *env, float32 t0)
     return ret;
 }
 
-float32 helper_itof(CPURXState *env, uint32_t t0)
+float32 HELPER(itof)(CPURXState *env, uint32_t t0)
 {
     float32 ret;
     ret = int32_to_float32(t0, &env->fp_status);
@@ -197,7 +197,7 @@ float32 helper_itof(CPURXState *env, uint32_t t0)
 }
 
 /* string operations */
-void helper_scmpu(CPURXState *env)
+void HELPER(scmpu)(CPURXState *env)
 {
     uint8_t tmp0, tmp1;
     if (env->regs[3] == 0) {
@@ -234,7 +234,7 @@ static void (* const cpu_stfn[])(CPUArchState *env,
     cpu_stb_data_ra, cpu_stw_le_data_ra, cpu_stl_le_data_ra,
 };
 
-void helper_sstr(CPURXState *env, uint32_t sz)
+void HELPER(sstr)(CPURXState *env, uint32_t sz)
 {
     tcg_debug_assert(sz < 3);
     while (env->regs[3] != 0) {
@@ -266,23 +266,23 @@ static void smov(uint32_t mode, CPURXState *env)
     }
 }
 
-void helper_smovu(CPURXState *env)
+void HELPER(smovu)(CPURXState *env)
 {
     smov(OP_SMOVU, env);
 }
 
-void helper_smovf(CPURXState *env)
+void HELPER(smovf)(CPURXState *env)
 {
     smov(OP_SMOVF, env);
 }
 
-void helper_smovb(CPURXState *env)
+void HELPER(smovb)(CPURXState *env)
 {
     smov(OP_SMOVB, env);
 }
 
 
-void helper_suntil(CPURXState *env, uint32_t sz)
+void HELPER(suntil)(CPURXState *env, uint32_t sz)
 {
     uint32_t tmp;
     tcg_debug_assert(sz < 3);
@@ -301,7 +301,7 @@ void helper_suntil(CPURXState *env, uint32_t sz)
     env->psw_c = (tmp <= env->regs[2]);
 }
 
-void helper_swhile(CPURXState *env, uint32_t sz)
+void HELPER(swhile)(CPURXState *env, uint32_t sz)
 {
     uint32_t tmp;
     tcg_debug_assert(sz < 3);
@@ -321,7 +321,7 @@ void helper_swhile(CPURXState *env, uint32_t sz)
 }
 
 /* accumulator operations */
-void helper_rmpa(CPURXState *env, uint32_t sz)
+void HELPER(rmpa)(CPURXState *env, uint32_t sz)
 {
     uint64_t result_l, prev;
     int32_t result_h;
@@ -363,7 +363,7 @@ void helper_rmpa(CPURXState *env, uint32_t sz)
     env->regs[4] = result_l & 0xffffffff;
 }
 
-void helper_racw(CPURXState *env, uint32_t imm)
+void HELPER(racw)(CPURXState *env, uint32_t imm)
 {
     int64_t acc;
     acc = env->acc;
@@ -379,7 +379,7 @@ void helper_racw(CPURXState *env, uint32_t imm)
     env->acc = acc;
 }
 
-void helper_satr(CPURXState *env)
+void HELPER(satr)(CPURXState *env)
 {
     if (env->psw_o >> 31) {
         if ((int)env->psw_s < 0) {
@@ -395,7 +395,7 @@ void helper_satr(CPURXState *env)
 }
 
 /* div */
-uint32_t helper_div(CPURXState *env, uint32_t num, uint32_t den)
+uint32_t HELPER(div)(CPURXState *env, uint32_t num, uint32_t den)
 {
     uint32_t ret = num;
     if (!((num == INT_MIN && den == -1) || den == 0)) {
@@ -407,7 +407,7 @@ uint32_t helper_div(CPURXState *env, uint32_t num, uint32_t den)
     return ret;
 }
 
-uint32_t helper_rx_divu(CPURXState *env, uint32_t num, uint32_t den)
+uint32_t HELPER(rx_divu)(CPURXState *env, uint32_t num, uint32_t den)
 {
     uint32_t ret = num;
     if (den != 0) {
@@ -430,22 +430,22 @@ void raise_exception(CPURXState *env, int index,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-G_NORETURN void helper_raise_privilege_violation(CPURXState *env)
+G_NORETURN void HELPER(raise_privilege_violation)(CPURXState *env)
 {
     raise_exception(env, RX_EXCP_PRIVILEGE_VIOLATION, GETPC());
 }
 
-G_NORETURN void helper_raise_access_fault(CPURXState *env)
+G_NORETURN void HELPER(raise_access_fault)(CPURXState *env)
 {
     raise_exception(env, RX_EXCP_ACCESS, GETPC());
 }
 
-G_NORETURN void helper_raise_illegal_instruction(CPURXState *env)
+G_NORETURN void HELPER(raise_illegal_instruction)(CPURXState *env)
 {
     raise_exception(env, RX_EXCP_ILLEGAL_INSTRUCTION, GETPC());
 }
 
-G_NORETURN void helper_wait(CPURXState *env)
+G_NORETURN void HELPER(wait)(CPURXState *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -455,7 +455,7 @@ G_NORETURN void helper_wait(CPURXState *env)
     raise_exception(env, EXCP_HLT, 0);
 }
 
-G_NORETURN void helper_trap(CPURXState *env, uint32_t vec)
+G_NORETURN void HELPER(trap)(CPURXState *env, uint32_t vec)
 {
     raise_exception(env, RX_EXCP_TRAP_BASE + vec, 0);
 }
-- 
2.43.0


