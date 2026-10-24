Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63097606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ihEpkc6A;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j9U8pI8s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgC-00040h-GZ; Sat, 24 Oct 2026 13:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg5-0003zE-MZ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg3-0008ID-Qg
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:09 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF0BRW2450776
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 54ye6mWRI8jd8uPHkm4GyC5Cue6h8uIpQSo10iqkHOw=; b=ihEpkc6ARLtlU9Bj
 cxT4+/kq911J/81NBVOqwzso6WDmWLCQb4OvEN+X7WoYNmksoY/kPHp/avgmuIkm
 zr1wT7rf76ji0YVg1bdTmr6xJZRihKL1q/EeAUIPLv9LgoNO92SGXZX97j0v3YOf
 t/hynhqjKsp9hczphwRF6hEwQhK5BAb3P/H99k/b2lya4HLuth4MPwL5KoJi6I6E
 pqiPjxUy2RMBpN3WSV71jiXH4FwtOCFFs13gly4JxXuEN4N7Vos8JUKeyo8OM7Yq
 g3u5Xr+4drWaSAjKd7e0wjpHClu7vyTKAB18D1HQlmREjOK7MzuNHRn2tQlIYSLO
 T0fFZA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xhgn2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3adcb81f487so2832731a91.3
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863426; x=1793468226; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=54ye6mWRI8jd8uPHkm4GyC5Cue6h8uIpQSo10iqkHOw=;
 b=j9U8pI8soePrXVoDfYN8foSglVg4ect/OmNywRNFlrv/it1EsV3qlRQZWz7yyfjrLR
 VZ8/VfvP7DYTBGk56Or91kG6oHhto/JzZHwHxC64XWMzyBQvjdRT3Ou91CBsi0kGCKxA
 K9iyiLhBuKWSRB08gVoqKAfkBzPnFH1VkHpdRqbx0hp4/D/J1C9gnbBFSkhnQ7W5j8lR
 KJ/PwAlU+dMSANj1WIu0zrGp1uQEw0qOpAao/cf0k3AFFCE3DXWSRX2qPvbYTlyIVxqT
 O5YF6CvuLK830yh26QYXj687+RmJip7eP5PuCmzAHQCj8ZYQFjYGZL3Rmc4DMB0afTYq
 J4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863426; x=1793468226;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=54ye6mWRI8jd8uPHkm4GyC5Cue6h8uIpQSo10iqkHOw=;
 b=C0CFJvVoWs7zY1G/kMjx9+l1UJR6EfCT4SnSasnhSaL3x8ZUyNkx87PYCxk21oj4oh
 s1X77TtzkzjyGllbhkzgSiPNidtjm3R/ltU6bb6tr1foHDweubfIGOVzj7PBB8fZuCKO
 rJSFMyx6YzCGS88yCDCT6m89BnMLwRFjdB7AMu5N0rDdyEtAFU5xyH93kkT568ZQnYUR
 ZNBk7SzaYdzQEE9iD2PyP1t0tqbqBUTXmXCi5xkVjRK/G7n4ejWQvVrYMvSlj8x47+iy
 WhZ+8nF0lq0W/CDx8HDrI3H8DVWPbdNQ6I5l8eA+BoYtQnJAuClmfo/U9qX/MC5h+q4C
 +yMg==
X-Gm-Message-State: AFq9FYINfTziRvhvYmZAJ+7W3m707aRdYe1OKT3mX/U+fi/rA63hDivK
 EeQzH9zHUuznQdacH6iE1LA5DQBtCIp5QKWeUMmZCbSIti1IqWOb2h5sx2gyj3nhkO4NbsIBEKP
 y279urjzJwTCKa77SIJSVhVN3ajrdogbgXiTB4dWGtBU7fNW+wDnKZlMlSk+I8D/ZZA==
X-Gm-Gg: AYBFou25Pv+MfizX81aPOBBpSsIbP0AvT7xCxEg6FJk0ADy0ZH9mWB1ITaN4TwcXd44
 H4CrGcDlY1sP8bCBcMt9ENfPabfBpOoilp3Nnw0KkzHl1tPnOTXWFEh6jOX6klmBbPsXdKU26Tx
 8iCcsvWp6LQEC7yrzkV7sw/sxY7b1TYmkUMx8Gf67YJb7Ft6n1uzXQbSxljVHUgjjTn292/4Mqb
 on4JkTBkrGbdzBsSU2l2cK7AjImq9xAHvQ0k9xXyJTU4RXX26E+ECyaciaK709YpPkH5PUJzwYk
 nmHk0n3N5lH9jluoIRYSbEE4KmuDRieivRv8AfPdkponfKTUhcfc8rxpMmtf91j0S0hCBrDqKP1
 a22ysZfG2NbzZWIeHputkH7FI4syi1yF42wMD3p54okya1+ZiPxEic1ji8dU8qmE=
X-Received: by 2002:a17:90b:5888:b0:3ac:74b3:a8f3 with SMTP id
 98e67ed59e1d1-3adeaea14fbmr2287992a91.44.1792863425749; 
 Sat, 24 Oct 2026 10:37:05 -0700 (PDT)
X-Received: by 2002:a17:90b:5888:b0:3ac:74b3:a8f3 with SMTP id
 98e67ed59e1d1-3adeaea14fbmr2287985a91.44.1792863425244; 
 Sat, 24 Oct 2026 10:37:05 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 10/20] target/rx: remove explicit target specific prefix
Date: Sat, 24 Oct 2026 17:36:39 +0000
Message-ID: <20261024173649.7405-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dT2GvAzrb3Hzdv2W3ZMkmMgNHj65uL8l
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adcecc2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=xJBkFjxltbiK57tzlAwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX/niANQb/rpsl
 HxqQEaazx6yvA40G18ycpZvS5j9dlG9VcM5DNyMus8yoR68ynu/uoHv7GV1Z/FLhGwDyZAMj2I8
 UuQwwAR5YVY7PjUCswfVUM2Iz1Fheek=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfXztFUEYxRNIrM
 097HVyff4LX1NlITA4ZFC0/X0yh7s19Q+XFCNXE9rMGrhR1idzQ1JSQ+TpwQEWYp7qLCPzrYLyb
 Ys9NTyW7+aWHaR5wbj2LgBmgVmjIWE4TQDPbCQNIJ11yg+F93ZVop8IowycrFKlaODv0+FCJ5qj
 8ULuQzn62KSV1BXZuxIvj2pBZ7FisOTwZ9r8/VDHz7+N3TS7rW9RiDiesJpCwutvHbS0kbRbbAN
 oFlnP6TCfUwthBIokT2GBGPXgNcKk8P7alLqL8Hd6PoWYbW8aa+lWtSAP3ezkDP7QUeztzpNSkD
 xJyG2a7VUwELWzNRYugkyZd4IZG1Hvuflon19cSRjdtw7ygD9Hs/ZJFNh4VAzG+xJ8NO8EXkJIw
 HX6A1qDWUR0QphB+1WyjYxh+iNvo1t6KXjfFB67kzmxs+2/f3GmFG4oHEj8dwJ+2ajJNWokAYm/
 k/xjTnpMsZNW9qQWguw==
X-Proofpoint-ORIG-GUID: dT2GvAzrb3Hzdv2W3ZMkmMgNHj65uL8l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
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

This reverts commit 5490e0e4a5dcada1aabfc7df772ddee54f9022c5
"target/rx: prefix helpers conflicting with other arch"

Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261024163249.77855-11-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/rx/helper.h    | 12 ++++++------
 target/rx/op_helper.c | 12 ++++++------
 target/rx/translate.c | 14 +++++++-------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/target/rx/helper.h b/target/rx/helper.h
index 13f019ff81a..f3897ce7619 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -3,11 +3,11 @@ DEF_HELPER_1(raise_access_fault, noreturn, env)
 DEF_HELPER_1(raise_privilege_violation, noreturn, env)
 DEF_HELPER_1(wait, noreturn, env)
 DEF_HELPER_2(trap, noreturn, env, i32)
-DEF_HELPER_3(rx_fadd, f32, env, f32, f32)
-DEF_HELPER_3(rx_fsub, f32, env, f32, f32)
-DEF_HELPER_3(rx_fmul, f32, env, f32, f32)
-DEF_HELPER_3(rx_fdiv, f32, env, f32, f32)
-DEF_HELPER_3(rx_fcmp, void, env, f32, f32)
+DEF_HELPER_3(fadd, f32, env, f32, f32)
+DEF_HELPER_3(fsub, f32, env, f32, f32)
+DEF_HELPER_3(fmul, f32, env, f32, f32)
+DEF_HELPER_3(fdiv, f32, env, f32, f32)
+DEF_HELPER_3(fcmp, void, env, f32, f32)
 DEF_HELPER_2(ftoi, i32, env, f32)
 DEF_HELPER_2(round, i32, env, f32)
 DEF_HELPER_2(itof, f32, env, i32)
@@ -17,7 +17,7 @@ DEF_HELPER_2(set_psw_rte, void, env, i32)
 DEF_HELPER_2(set_psw, void, env, i32)
 DEF_HELPER_1(pack_psw, i32, env)
 DEF_HELPER_3(div, i32, env, i32, i32)
-DEF_HELPER_3(rx_divu, i32, env, i32, i32)
+DEF_HELPER_3(divu, i32, env, i32, i32)
 DEF_HELPER_1(scmpu, void, env)
 DEF_HELPER_1(smovu, void, env)
 DEF_HELPER_1(smovf, void, env)
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 5f4f0a14027..1281d69c461 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -147,12 +147,12 @@ void HELPER(set_fpsw)(CPURXState *env, uint32_t val)
         return ret;                                                 \
     }
 
-FLOATOP(rx_fadd, float32_add)
-FLOATOP(rx_fsub, float32_sub)
-FLOATOP(rx_fmul, float32_mul)
-FLOATOP(rx_fdiv, float32_div)
+FLOATOP(fadd, float32_add)
+FLOATOP(fsub, float32_sub)
+FLOATOP(fmul, float32_mul)
+FLOATOP(fdiv, float32_div)
 
-void HELPER(rx_fcmp)(CPURXState *env, float32 t0, float32 t1)
+void HELPER(fcmp)(CPURXState *env, float32 t0, float32 t1)
 {
     int st;
     st = float32_compare(t0, t1, &env->fp_status);
@@ -407,7 +407,7 @@ uint32_t HELPER(div)(CPURXState *env, uint32_t num, uint32_t den)
     return ret;
 }
 
-uint32_t HELPER(rx_divu)(CPURXState *env, uint32_t num, uint32_t den)
+uint32_t HELPER(divu)(CPURXState *env, uint32_t num, uint32_t den)
 {
     uint32_t ret = num;
     if (den != 0) {
diff --git a/target/rx/translate.c b/target/rx/translate.c
index a350f6b4d26..1bacc7adf92 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -1252,7 +1252,7 @@ static void rx_div(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 static void rx_divu(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    gen_helper_rx_divu(ret, tcg_env, arg1, arg2);
+    gen_helper_divu(ret, tcg_env, arg1, arg2);
 }
 
 /* div #imm, rd */
@@ -1864,16 +1864,16 @@ static bool trans_SATR(DisasContext *ctx, arg_SATR *a)
         return true;                                            \
     }
 
-FOP(FADD, rx_fadd)
-FOP(FSUB, rx_fsub)
-FOP(FMUL, rx_fmul)
-FOP(FDIV, rx_fdiv)
+FOP(FADD, fadd)
+FOP(FSUB, fsub)
+FOP(FMUL, fmul)
+FOP(FDIV, fdiv)
 
 /* fcmp #imm, rd */
 static bool trans_FCMP_ir(DisasContext *ctx, arg_FCMP_ir * a)
 {
     TCGv_i32 imm = tcg_constant_i32(li(ctx, 0));
-    gen_helper_rx_fcmp(tcg_env, cpu_regs[a->rd], imm);
+    gen_helper_fcmp(tcg_env, cpu_regs[a->rd], imm);
     return true;
 }
 
@@ -1884,7 +1884,7 @@ static bool trans_FCMP_mr(DisasContext *ctx, arg_FCMP_mr *a)
     TCGv_i32 val, mem;
     mem = tcg_temp_new_i32();
     val = rx_load_source(ctx, mem, a->ld, MO_32, a->rs);
-    gen_helper_rx_fcmp(tcg_env, cpu_regs[a->rd], val);
+    gen_helper_fcmp(tcg_env, cpu_regs[a->rd], val);
     return true;
 }
 
-- 
2.43.0


