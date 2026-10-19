Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74726606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i+aTDN76;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E/FI2C1U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuni-0001lV-A1; Mon, 19 Oct 2026 17:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunT-0001hw-Ln
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunQ-0005jA-FG
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK0Jo501089
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PEet8fcpJ7p
 41p5X98UE1t3J4pyXZ7NQqpPgThPj32c=; b=i+aTDN76xKdlf3O2eW1+cb826XI
 +MqJ9erveCtw2NOqUfD2AXSd1BBuEvs+iVGa6anZkRDXjhhTVu02l3srRzOeBGp1
 VynnM+GkIoKz0wG0hf1bEu29fOH1mYjfxLpY7Y719oonB+vcUgtKb1stTnLxoYZ2
 dZTu/1YWGOr+j5A/UJxpLpkKlB5u1l6aoVeCFdCC/wVIzcCwdCCyRgRwrzgQ79/J
 PnUhR0uWvpBXdKcu3VU4B5dOuNIGqVyHid4RZvaYPpgb31s6juOP5rkrkMIqmyV+
 RaQ2XCgwLF84ZPL+q+k1T6ipXzKfwjwb/tD2uM1QGUzvY2VShogAY2M0PTQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3fbaqc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab1e771632so80213a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444886; x=1793049686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PEet8fcpJ7p41p5X98UE1t3J4pyXZ7NQqpPgThPj32c=;
 b=E/FI2C1UreUs8AEKhYCvq44zJMwFFIhXzrRAUxgBkVJ2vc4ONSd8QQT0xu6B6ElY00
 bw3ftXrRfdkZMWNsTkpDuw41RS1PNeZ3sWqFOvwl6fbGAAY/EkKMLehKxwn9Xvz/tFQb
 n0oqnxm/ceb2dqw3/oLIrPm9UH1OBAEEEk8E70G3l9i1a96wo7P1oJI+QPAi6l8nh4uw
 weC8CkASRvZqw1HERUA/7+/yzgD3FvUAWShj3N7Me+F+69PlGeDcOPbk/Bq38zBkdHPI
 tVgkx/Rb0x8rdj+cZFSnrlmqkvWrC/lQkz9JyGqGs7JDU4AbK+qlkxxr26dWWoyGkL/L
 22vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444886; x=1793049686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PEet8fcpJ7p41p5X98UE1t3J4pyXZ7NQqpPgThPj32c=;
 b=wb5KdxkgHja8tncH0a2hb6AOFdimhBahYRJKaFbiK/kivYLi2QHNX/ZqGU1apE4KiN
 kjhIJ719BZWM2lAWHIWkkR7xFda1WhZSMhfUda+COFg7YoIjx1kGf6QJTac2ZhyRQ4Sa
 5fJlhT3OnQ2Zj2FbLfGxPZPmNN7oiGurILPNnPjXZwTHVw9N2kTBJmY+SyZltDAEEwks
 cZtUC+ogCx78KyetH9seKkqxCK9+WMVVtzFIwCUsGaUqxa07xXsaFqqQgwEgcd04cGWs
 cIQTyeHmLFzUNWZhaOzmSSZrSh4i3OJlP/SOE4T5Pvq8KVs7YQYRfvwGU9zNDPH34JoY
 sJdQ==
X-Gm-Message-State: AFq9FYKYACJzdV7P895SbQUdiY6eURzEGgC4qfqYCeyoLc7oeh1rJlDv
 gOSH66KQQr1oUqLPQA5plIF9A6rU1zM1o3uiZ9pPu32QzsSjkeGo9rMSaINJ42uBk2/qxoUAMMH
 SIV9JNfq9qWNkfwr9MPMRBLi1CuGszjEIohKEbC06hJ/HWiHhkKIovdTc4Xe3Ej1DJA==
X-Gm-Gg: AYBFou3A/smgNe6JqG0zh4QnKxZu2OnJladtrjHjwKmGBUuz59WYvYkauyHlTTalV8L
 Jm82nAIribHYr5OT8YhcN+/ca1EC0lPLLpr+g9ZWVApg/Sa+kZVYcMc/0FoPplEn2t1nVhuOXKX
 +FEF1nwGkbX6bdjzsajZYMSXRWqw5da//5fNG3ZsePTnU73IbHBpTtoyMqjaJfAOvEpjKjyiB53
 W/OK7Q3zjeFGirAk0Q0CQPbUK/S3OarAFVM2aP/dMuRl9B7ONTZnQjWzR+HgzdB9wwOYN6EJwHD
 b1dGnlQ3rSMhDxgfgJ1fnw4PtwuGdcLgwGQtT9lDF88o9NZICIQtwwauz9GMJ533XW2fyCAxclr
 oUuXOllKLUtSG/HJeHg0xn9LqAmuinHjgMkablrvagpFRekPvTvwUZ8f5la8DC6Y=
X-Received: by 2002:a17:90b:3ec8:b0:3a0:eec6:b065 with SMTP id
 98e67ed59e1d1-3ad64ba5d2emr187647a91.13.1792444886178; 
 Mon, 19 Oct 2026 14:21:26 -0700 (PDT)
X-Received: by 2002:a17:90b:3ec8:b0:3a0:eec6:b065 with SMTP id
 98e67ed59e1d1-3ad64ba5d2emr187637a91.13.1792444885728; 
 Mon, 19 Oct 2026 14:21:25 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 23/26] target/microblaze: remove explicit target specific
 prefix
Date: Mon, 19 Oct 2026 21:20:42 +0000
Message-ID: <20261019212046.149572-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rOAw_yJa-anMDz8rUUHwh1D46-78Cuqw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX9y3uj92+GYZX
 8xMYoC1qnhld+WfkJyBCENVFX+Rf4FIRVRNoUPF1s22dCD6DbW4xql56I/jlrMC4dgN8BLPNDxQ
 MghWMOYmxg9y3fWAHMOtWMIoBXfg1OJt6zNrExyV06qQZ0SaYOL58+ZiVnGsO8H0wPc09b8ONWI
 yNuDdX9u+RjF6eQYO8vgKiczKiDCEkkopLkE1CU/Ll5RSuarw7LuI/IkGaPli0spABpOJY4lljg
 EkIFW18kibjf341qPX0SFclzZrgdKLZS/32AISPL58x0dsypyBh7C+SsTfV7I+g5TlpWLRTKp9T
 v61hNRK2b047NaNDSmhkn8WGWl/J9/D+XK7qTx/XruHjegYIJbPGidB9s3nuTSNUtArTMWvsHWu
 6Pz13yMJmN0mkdoKwandUJwfyImRHxmlhLbH+bQkmPlmgCTwGLih7A8YxzY7SxD1AAV++fnX55I
 fUUhCKlhjSCzYgwTbrw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX5wDbRhLAHeIY
 1P9PoiqS9B7egJYMV0FjTfDk+aEiqPfu6OFqDtZHNT1i5VT3JC+GCTP0deeDs/0UXzPRA1Lxrdm
 G6X/C/tXmtCqUHH4AGxcdp08rWg6EQ0=
X-Proofpoint-GUID: rOAw_yJa-anMDz8rUUHwh1D46-78Cuqw
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad689d6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=xJBkFjxltbiK57tzlAwA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
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

This reverts commit 4da3423973e8faa544744777f629ac82dedc0869
"target/microblaze: prefix helper conflicting with other arch"

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/microblaze/helper.h    | 10 +++++-----
 target/microblaze/op_helper.c | 10 +++++-----
 target/microblaze/translate.c | 10 +++++-----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 63a94ac4bbc..1429c1727ef 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -1,15 +1,15 @@
-DEF_HELPER_FLAGS_2(microblaze_raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
+DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
 
 DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
 
-DEF_HELPER_FLAGS_3(microblaze_fadd, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fadd, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(frsub, TCG_CALL_NO_WG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(microblaze_fmul, TCG_CALL_NO_WG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(microblaze_fdiv, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fmul, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fdiv, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_2(flt, TCG_CALL_NO_WG, i32, env, i32)
 DEF_HELPER_FLAGS_2(fint, TCG_CALL_NO_WG, i32, env, i32)
-DEF_HELPER_FLAGS_2(microblaze_fsqrt, TCG_CALL_NO_WG, i32, env, i32)
+DEF_HELPER_FLAGS_2(fsqrt, TCG_CALL_NO_WG, i32, env, i32)
 
 DEF_HELPER_FLAGS_3(fcmp_un, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(fcmp_lt, TCG_CALL_NO_WG, i32, env, i32, i32)
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index c53103ecd79..eb244faa7ee 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -62,7 +62,7 @@ uint32_t HELPER(get)(uint32_t id, uint32_t ctrl)
     return 0xdead0000 | id;
 }
 
-void HELPER(microblaze_raise_exception)(CPUMBState *env, uint32_t index)
+void HELPER(raise_exception)(CPUMBState *env, uint32_t index)
 {
     CPUState *cs = env_cpu(env);
 
@@ -154,7 +154,7 @@ static void update_fpu_flags(CPUMBState *env, int flags, uintptr_t ra)
     }
 }
 
-uint32_t HELPER(microblaze_fadd)(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fadd)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -183,7 +183,7 @@ uint32_t HELPER(frsub)(CPUMBState *env, uint32_t a, uint32_t b)
     return fd.l;
 }
 
-uint32_t HELPER(microblaze_fmul)(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fmul)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -198,7 +198,7 @@ uint32_t HELPER(microblaze_fmul)(CPUMBState *env, uint32_t a, uint32_t b)
     return fd.l;
 }
 
-uint32_t HELPER(microblaze_fdiv)(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fdiv)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -352,7 +352,7 @@ uint32_t HELPER(fint)(CPUMBState *env, uint32_t a)
     return r;
 }
 
-uint32_t HELPER(microblaze_fsqrt)(CPUMBState *env, uint32_t a)
+uint32_t HELPER(fsqrt)(CPUMBState *env, uint32_t a)
 {
     CPU_FloatU fd, fa;
     int flags;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 16794059a22..8b219afb5dd 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -100,7 +100,7 @@ static void t_sync_flags(DisasContext *dc)
 
 static void gen_raise_exception(DisasContext *dc, uint32_t index)
 {
-    gen_helper_microblaze_raise_exception(tcg_env, tcg_constant_i32(index));
+    gen_helper_raise_exception(tcg_env, tcg_constant_i32(index));
     dc->base.is_jmp = DISAS_NORETURN;
 }
 
@@ -421,10 +421,10 @@ static void gen_cmpu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 DO_TYPEA(cmp, false, gen_cmp)
 DO_TYPEA(cmpu, false, gen_cmpu)
 
-ENV_WRAPPER3(gen_fadd, gen_helper_microblaze_fadd)
+ENV_WRAPPER3(gen_fadd, gen_helper_fadd)
 ENV_WRAPPER3(gen_frsub, gen_helper_frsub)
-ENV_WRAPPER3(gen_fmul, gen_helper_microblaze_fmul)
-ENV_WRAPPER3(gen_fdiv, gen_helper_microblaze_fdiv)
+ENV_WRAPPER3(gen_fmul, gen_helper_fmul)
+ENV_WRAPPER3(gen_fdiv, gen_helper_fdiv)
 ENV_WRAPPER3(gen_fcmp_un, gen_helper_fcmp_un)
 ENV_WRAPPER3(gen_fcmp_lt, gen_helper_fcmp_lt)
 ENV_WRAPPER3(gen_fcmp_eq, gen_helper_fcmp_eq)
@@ -447,7 +447,7 @@ DO_TYPEA_CFG(fcmp_ge, use_fpu, true, gen_fcmp_ge)
 
 ENV_WRAPPER2(gen_flt, gen_helper_flt)
 ENV_WRAPPER2(gen_fint, gen_helper_fint)
-ENV_WRAPPER2(gen_fsqrt, gen_helper_microblaze_fsqrt)
+ENV_WRAPPER2(gen_fsqrt, gen_helper_fsqrt)
 
 DO_TYPEA0_CFG(flt, use_fpu >= 2, true, gen_flt)
 DO_TYPEA0_CFG(fint, use_fpu >= 2, true, gen_fint)
-- 
2.43.0


