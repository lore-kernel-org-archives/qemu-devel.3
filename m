Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6A4606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yas8BSLE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UtPJ/z0f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunI-0001el-BJ; Mon, 19 Oct 2026 17:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunG-0001eD-KO
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunE-0005hO-Mf
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:18 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK1Sv3627888
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lwLAG+uHR9d
 97gLVn6kHR8ijOephm3u/lTqpGfap2fE=; b=Yas8BSLERfsEXTkR4M/ZxnTMnqM
 BHKEtmm7GNEesxSRz4KvXVFHdtitiOMerQcJ7X+x6EB2Yra2AtL6YcA8wk12vHzn
 b/L9b3rojd+EV1wCEuDrubeo7WeMU1IhzGStlw8v5WUKaY1OGL3VRIWeHyTFcD2n
 gyoxLbDyzHhOHmCyafCYC0qhbppF48AtsAkz2V0TZYyrZS12P2mPq0SW+yE4ldjw
 ZCyOLdfaj+0YlnW73gRE4bB4P/o6fw9A3V+kAKPgZxXSLQVidUFKpvb6ARqGW2ea
 5Em7YbRzLwmi9l0u0MqrBQCDFKkAcCXOU8P7VqFxcxj7Vl0HzMJQTs2acBw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr42gpu7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a47617a0b3so3283964a91.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444875; x=1793049675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lwLAG+uHR9d97gLVn6kHR8ijOephm3u/lTqpGfap2fE=;
 b=UtPJ/z0fTOVW+O2JaQYHhEu/W3ExoASXW9jw12IEMN2onYho4ER9gdts4ECC2U4vFA
 4r0LWHZmMytji8GuE/DfUTFYCAhsyC0Hk8MjkQVfpgbbo8ABIUwNdexuMfBguNl1MJmi
 ujAtyUAf1CpJITYuK8gfGgQs9BlYQ/MpEfrm1PrGvto8eSdp4LWg+SlWudNJoK4PGEQy
 NiiiH/4YSJWF9RSB8+FKsHlHiRZb+Q8vPc/LqvgggqNpLW+p4OObrh2DkudQKfbbZe02
 D0Otyipwe60/gvhZRRpzorDX699QmMDXLZfR4yleTJN3RKTUd28igU+5BA9Fo2+XKGPm
 dcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444875; x=1793049675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lwLAG+uHR9d97gLVn6kHR8ijOephm3u/lTqpGfap2fE=;
 b=HBPugIzIxZ3JwMfjOrsHPwZLDSP3evxlIGHFcxLrT3tkfPtxibdYNPRokvSygkyK1O
 5txFPwL2dXOD7yw38AOXfQ6JODXF1zVg49FYWUk7yxlXBnQnLATBsZh/bn+xtQQ6Y20b
 u8KLWIjdYojjWRsy7tyme0kqg8472QWjWXaaCPXV2Se6HWQVaEpyvwxrQUfzPQjFQn/L
 ng0V7VZVs8MSXTmdaihYsElv0zCN/GHW0KspQzV5TlrXrMlslHDTRQPlwuKecarc90/x
 GQBc4nDl8FKL25gQlYDda7uzXqIjYHEJQemHEHwGSoL3UCoEifUFo2KjD2FTna2ex8o3
 z1tg==
X-Gm-Message-State: AFq9FYJE8gFHWuQliAXDyYMq5VDO27g4RQLN3LfPVDuxkHbQ/MzI70hd
 +hUBUxQGxa2i426nkiFvn9Fjar+Ln5b4WeezGNIi6XEBuuIL5DQhx/tCrG1ADbbPsMpZA05ORNv
 l4yhyV5myJek0Q7xqiNNTLI99X3S1zxEZO5NCDOJ562+V536PWOhF6veDax0YPslJow==
X-Gm-Gg: AYBFou0whOZEg/klWrOFcdfV9ZaSE4E3p5Q9UH9NV/cStRGepEzEBiJCeynffZADTWe
 LpwU2q89AuQh870SFVSaGovkvYmuh4ZTtmaqq02V8zXSho39ZGO+fZdkSYa8YtXkjTNYs6Ay9rE
 OghVahaQwmKSvPGRAr2OcwDTYl88elUN3i+pt218/haDzPkLyxBCNMFDXHyGerOOxfz/fr71m2l
 zXc2jOBRGpSW8AaxdlGT/7kjYRP2szwREB2NbUoE2mkawG9KIuuLWwIK983gtCxzK1BFH1YLEu3
 etF9Ng+hM8aE5QmEESNIMsmFdbe37goBNBbx+NIrbAiwp+rHxJM7lQ+XtLmM5hLLEGMUKNfYBPY
 0xl93I0X3odsQf2vq15kVBAPiOjD5MoSz2GIoVRPWTHTeFyFf/lEZNrWj9NdueyY=
X-Received: by 2002:a17:90b:580f:b0:3ac:a203:e095 with SMTP id
 98e67ed59e1d1-3acee2779aemr7358349a91.7.1792444874678; 
 Mon, 19 Oct 2026 14:21:14 -0700 (PDT)
X-Received: by 2002:a17:90b:580f:b0:3ac:a203:e095 with SMTP id
 98e67ed59e1d1-3acee2779aemr7358330a91.7.1792444874157; 
 Mon, 19 Oct 2026 14:21:14 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 13/26] target/rx: define and call helpers using HELPER macro
Date: Mon, 19 Oct 2026 21:20:32 +0000
Message-ID: <20261019212046.149572-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX5Ma+VpCpaWhC
 mSj3RMo22y/lI9qf4jpG6XlIM7p+pPnO92CRH7RveErzAU5elHBtkMWkDWXJsTccpwnP03n+zxj
 gVmzQ6jV6ynO8POgNq9HO46yp7gjCnlvGKjPeUqSBdzFew7k/4dggf77OcFirMZcjnV7hcWYsnB
 IPc1qKPE4qnfaVgGxtWTbzp1ngqLWIRAy17vjWB3gauukfOoSrfTa+sorDhxBE/af+nfYp6FsvY
 ZrNeW/ix+d3S2ElK5IRU9QvOBIrl/PhBv1b5gOige0x7tnyKPLZHQ5lDqziU2a+84pYDg8ObU0b
 1hNEn+Q7wNn+sVwjY955CZzFfZq8a3bM6tcVZCpgNWi4gQI5pJ2oNFewY5A9LFb0xN2yRE+1Bdn
 qBkNOlTeOWdFT1fvldZOmuhgD3SaFmuAuP7V0j4uTwmYFwrFmIX3fxvLz5L8ii73c8S6ek4fiW9
 NDIgh7zCekpdzSgyNZw==
X-Authority-Analysis: v=2.4 cv=Ve9ir1p9 c=1 sm=1 tr=0 ts=6ad689cb cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=OZx_OYey5Kulg9_gRGgA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX4LzsErO5C6bV
 n7Cb07mUvetm77ohN+3xrwIZzf4yS8gmWsM5+cBi7Ocuk5MV3XWfzIFJNayuDxnGUZZLLOzaa3H
 w3a6r2ZEHPatC3KnMHnzFf90XxfMQYI=
X-Proofpoint-ORIG-GUID: AvZvWST7k3Q43c1ckla3GD7rzZlhe1-C
X-Proofpoint-GUID: AvZvWST7k3Q43c1ckla3GD7rzZlhe1-C
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
 target/rx/op_helper.c | 54 +++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 5a7a87943fe..3c64014db6d 100644
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
     raise_exception(env, 20, GETPC());
 }
 
-G_NORETURN void helper_raise_access_fault(CPURXState *env)
+G_NORETURN void HELPER(raise_access_fault)(CPURXState *env)
 {
     raise_exception(env, 21, GETPC());
 }
 
-G_NORETURN void helper_raise_illegal_instruction(CPURXState *env)
+G_NORETURN void HELPER(raise_illegal_instruction)(CPURXState *env)
 {
     raise_exception(env, 23, GETPC());
 }
 
-G_NORETURN void helper_wait(CPURXState *env)
+G_NORETURN void HELPER(wait)(CPURXState *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -455,12 +455,12 @@ G_NORETURN void helper_wait(CPURXState *env)
     raise_exception(env, EXCP_HLT, 0);
 }
 
-G_NORETURN void helper_rxint(CPURXState *env, uint32_t vec)
+G_NORETURN void HELPER(rxint)(CPURXState *env, uint32_t vec)
 {
     raise_exception(env, 0x100 + vec, 0);
 }
 
-G_NORETURN void helper_rxbrk(CPURXState *env)
+G_NORETURN void HELPER(rxbrk)(CPURXState *env)
 {
     raise_exception(env, 0x100, 0);
 }
-- 
2.43.0


