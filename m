Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0013B606A31E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S87Jxa0N;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=No1qk0Oe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKegM-00010J-Uf; Sat, 24 Oct 2026 12:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegL-0000zv-Qa
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegJ-0002P1-J1
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:21 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF0h4I2373955
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1Oh5fkfCRf2hNtVz9A7d+QGrEttBgP9G6hlJJI9F/2w=; b=S87Jxa0Nn8qCTV5C
 ovEJslxgaGcZKHUL+GdK1/SSGAm2MoZjx9iR8GLH8xzW34rLn5YpN6OfGUwveDTB
 BWz0MyZISqBok/0NBDH4EulewM3pKtQmVLcw7Q0migh5aohV9Myeh5HFa82/8dwu
 +BXfjs/1xy+1y3eM7ljlTC6nMgVvRZaUg6l6WQ8YDmsFLIQNMp6i70P1Hk9HTQWk
 CtZerPuzPtv4yfNPQcpsbXJHd7CK1oK2n/dGuuw3mpEhu/VRjTx1qwYaCYwNx6UF
 xKpMUGs0cQ/1DegGIqKA6OzAN3PrWZJDNY09/t9O+Taxf1awSzzbELaHpFqJpdu9
 MIxmHA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6hfrf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ea0fe07201so11843065ad.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792859598; x=1793464398; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1Oh5fkfCRf2hNtVz9A7d+QGrEttBgP9G6hlJJI9F/2w=;
 b=No1qk0OeJvn9+YrU8enIvFUcvqc9grfEC8fd523hBm05aXTX59bSBwc7hpT+ek3oyF
 6owT7LNeZ4UtfqLgYbAHiHQGQ8JQXPfGVjdALeLDURxjIyexaSBioXHTmv7s2ZitFbtD
 u5HrjVN2ixGZhQIRULsR+E1WMYmbyq4NtSTAI1Nsc3Ek/EysEzuoACNzhxMWXF0Q/wwo
 plrAiUOHlrIw3bmiVYtj0g1OoDKLcFbhDaReMcw791BUcqvWSCPpSX90KJlU1avDGGOw
 z52JXfTgwx3PtlVihAfKSp4AtIdHkqkaoWLP3q3dNabrFrUSzLtNSGki8O1QRcteDJkX
 DKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792859598; x=1793464398;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1Oh5fkfCRf2hNtVz9A7d+QGrEttBgP9G6hlJJI9F/2w=;
 b=C7gNZbIOOaFMJ3b29Vb+T7/7LrrtcYgLhnFvbkSIqMsbmjGrHDj4XSBWj/GKLofYWK
 OV+cmBFuXUc+grFZWaZLJla9hQKRPR02wHuBpXWGGO/xIF73ecrM5ci0ShSOiK5BUMqR
 o9mMGfITmfvUdMtcb+GuPdh7u3sFKrDZ9ECzGClWdK/6lwSgW77thS3qzMR1bV/LqrNx
 6+u+Pqc85Go43lVeS4I2PdUXkpSD8ZcZILlV76pbCLHd92eleEXT7cyf79rY8pImXkcq
 Rt2P4K0WsKwLPQeWpNlOVv9WbgSgyZQhyNe3/aXK6/9/uoz8Z6evP2rCaWAipsVCgbx9
 AH2A==
X-Gm-Message-State: AFq9FYK49/HvC40742fa9dpo0JaLaZ4dWLP3MhzMLboz1HUDpoc1Dztz
 eP3vRtAWZ2Aj3fh2229e7KQbmTuF1S0QW9RV3/EdjX4fXYPJ5F9Lsi6d4ahJ8P+7xKZSPvDATw9
 xFjmmrkekKHY0UniLxh25mDZ+7awqKKRLqxVqfFhwwoTIJYSJ+bzbJUE71cgtDYDmug==
X-Gm-Gg: AYBFou3inUGrhUlYQIZNdxHAaHBXqs5un0tL6/EIXbek7PF61tSqu+GJUMrmXDWdGB6
 THVDDM9Sq/TzWGCPyeDIun8LI3DsvZ3gqQ1WuPwq7K9SZEbUgQfuahU7jkXt1cFVhfXYLYVAOwo
 WPPfkiq5Pt+omQRwxQYPwfwHS/c26ET9q8LFmODyUi10qKJRMhKMu3rFsuvco/PsyRaRi62r7Dz
 PMGKJtgSgukK0CRhPEzPekVUAlm54obFTtRjOlqk/3Uh6fHgI5+25f6eQMj/ah77kqMpP9SSJR7
 3scbLjZB5GEdUuiRmt+5aNUkKTSlL5AawjhrxPXpwImlGQtTuGkXoSzr4p3s7TR9Rod0E+oopKf
 175gML93OMRVDFLLzaVG0gBCKq4NrXnk8n5bZkG6szbFPP2UNvPs0wsTABs97vcE=
X-Received: by 2002:a17:90b:4e83:b0:3a8:6a04:80ef with SMTP id
 98e67ed59e1d1-3ade9b2cf01mr2023421a91.6.1792859597606; 
 Sat, 24 Oct 2026 09:33:17 -0700 (PDT)
X-Received: by 2002:a17:90b:4e83:b0:3a8:6a04:80ef with SMTP id
 98e67ed59e1d1-3ade9b2cf01mr2023403a91.6.1792859597049; 
 Sat, 24 Oct 2026 09:33:17 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebad93c5sm1932270a91.2.2026.10.24.09.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:33:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2 08/11] target/microblaze: remove explicit target specific
 prefix
Date: Sat, 24 Oct 2026 16:32:46 +0000
Message-ID: <20261024163249.77855-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wTTrw-3kmCYOhY5G-nPyPA6vynW0F9xO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfXxx2+2wDixu5o
 WYZnrj33kHNR+XsWbD0Yuy6GNLc0d7+8CD1/BdUIu4+0xWRcu3dTctN9lYZVUbYTKCKnAb/iv+D
 L+huHGA8uUhQRpmRndgL47XWxYd+QMo=
X-Proofpoint-GUID: wTTrw-3kmCYOhY5G-nPyPA6vynW0F9xO
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adcddce cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=4ilfOIZX6_xEahZvDhkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfXwueu69qpRplo
 vB4Pm/qvIb6lkLsfqhwCrijNSY4BBOrumB//F0rHGDlHwsSFxAynwppejL4pig+WiyY0VuOdpRN
 x2oWpfrbpI3UG/E4uoduX1WL6+C4WKi/29dM+8WMugxD9ljW0ES9a5l3Ai7alHca6WL4Qtl15nQ
 H8Nxn1DvGHj3gOUKaCYmFZVv5+flNzis4sc+1F1/ON/fB8QTGVlwQgcp7gb7HLXUxde8SND/L5+
 c5tmO6cx33TQqyUt0HUQ4oBY4z9wnRvchZCrLnp01Ll4UO2Wws9QRXhaanbp537MQxynauy/ccj
 a/aHSwcBECtFIKqrBPHysH04xSpWdYhN2Hc5K+VAk+vEoKZUuVw3/XWuYqRPYRYl+VhPvjINYey
 xLEUEbIpgDKPZ0wSUpsfz1TuRLZ4YkYw7E+9TK8aZJnUFaMeykzMoV4yVbVSYcu9rIqltMTvz83
 V4f7CtbD86EsWnylujQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240065
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

This reverts commit 4da3423973e8faa544744777f629ac82dedc0869
"target/microblaze: prefix helper conflicting with other arch"

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
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


