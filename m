Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9EB606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GFImLZz5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kHisV16g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgD-00040s-H6; Sat, 24 Oct 2026 13:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg4-0003z3-U4
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg2-0008Hf-RL
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:08 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExtfV2960342
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZRuBzKxuJS9h47GKIU4qbgq4o0i1bcZm4+3GaJWjv4g=; b=GFImLZz5lau2cYdL
 cdFLBE4fvizXPdwQnDulbOq2sR9m9ofp8aIk84xwHONnlS1NU5kM/fHMaxHlj72r
 +VHDXSkQ131WF2JKn9o7wPessgAAYZdisEpJxe4dJJgvnUKXbDgBEzkQu2yf/REw
 5X+Za+4I5kuxPBOW5OKpEyeYgVXmEnFqB5JOT76f/oWfCy11ug3xWwUVnB1+kroj
 MxKG1wz0tQRhRmCeOn3eCzVWl0I012aWrfsOOcoKIZzBeYz0DRNsEErPWMB0QO6S
 JxtSuDeHC5P4oW29hJ9s3/576DSl95Fs6irwr6o3485wh7thH6L4sPGnontkepAH
 UIG4Yw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgjcgssfa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3aca98f01c1so1754887a91.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863424; x=1793468224; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZRuBzKxuJS9h47GKIU4qbgq4o0i1bcZm4+3GaJWjv4g=;
 b=kHisV16gAfKxto7pu1TxJ8TU/p6ulejaHKMw5+RIfzmLZSAu980c2qubdqYJgpm653
 drSxFROQ8nOLz1PMli3znjydST11f5R/ym1fr22DwB2T0M29ESO7u8f5a0ZYZKC8HC2R
 BUsmAk2XT9T1XurhGYrnMcJeyvRpmNHZ1Zn/dRvLwFagSg1dJlvvAOhaFB2UzRSNRL7+
 ISrTdiwg3U5N9gF6fo89K0fNU/idMl3ZfcUv1Yua0HwjqLVsxB4DiBL13yWL1JWo0hp/
 /6r4Wuc02wbMfLb0DqcQCRcmyi74V2Axuy3Hmy/p9iFfHpix1QE9MdhdBkfz0mzoXCmI
 DvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863424; x=1793468224;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZRuBzKxuJS9h47GKIU4qbgq4o0i1bcZm4+3GaJWjv4g=;
 b=cirjSlDdQdqpezVW7tUiiBzMwQqvd3Le09FX8NfP8X9xqYQMxa8kME9ujzEdSwuSop
 8ba1m2k3bXZIiOUXh3L5H9N/p5Txqd7oo/ZxoLNIMgFYs+15fbh55e7B797PnHNpKvEX
 Llo0UEY4ZRKv7ZnWPlJPNOg52NNL+fy6I9O45s2ktWz/RfRJTN+u2vuf8Z1hM+mLPfre
 hAPuCmrLvnX5IVBAtyjONHnWD8HxOCjjPoVjMpnL+fBEdRXxpt9tEWYV4/99p9xX1yOd
 ygSKbvHo9iyujcLbXAZ2xteURuZmEp/DnQhgFdWOHMqXjFMMq/XyVTYG2cBmB79WwOcZ
 FTIA==
X-Gm-Message-State: AFq9FYKeKXXn3gYj09FD4k+z8Klt98GCTOVXhajCHkUrhl5jkS+/++UF
 7iPYqNZLW5903BLTeUiytYfsdxZIl4zDr+EmsKMhLWEyqhZhe2lB7XE+YgtIxRRYMOOTuGbCRgu
 ro3wev6KhC1vP7T45c+CwNmcdGB37WAwrlomgqh9k6xfrnX9zhv0cEOJXTN9Ohyk9SA==
X-Gm-Gg: AYBFou3/mTsedz84k6n/efzoZN86u7aZTGmfcpqEwwEQ3aG0mvW/BD0+0AFNKGU+Rmz
 tR/06mrkGlAhD3jecHU7LxuGViZk5bdhr1uHHia1RvVgBWpSsZhhjtcadYDrJDeCyx3wAhOih+j
 TuE+lC1/jnQVBfHM1ryn3wJTS2VAJWvc4qKZCDO64AqAA627ixpQXKn0DQtD1ECMqkUyNj8LJvt
 E5QeTtrWwchjeiqPylWmvOJUNniYn3775m80gwzgt9fR2L67kB4M3Ut4xsYp5S6bXyUe/+QErov
 e1YeJSnZxWUVan+l0ztb1rsmpnUnU3wVftGwYGujd/3X2YZ2RP9myAU6HkfRNrt92Ft6U/D9iiB
 WUcbHfhM9OVMZrOIbIBOMwfoIZW+0NlDPTD6aI6a/ZDB7cV596to5KhxZZyPjPv4=
X-Received: by 2002:a17:90b:5647:b0:3a5:1b:34a5 with SMTP id
 98e67ed59e1d1-3adeafcf067mr2467391a91.49.1792863424309; 
 Sat, 24 Oct 2026 10:37:04 -0700 (PDT)
X-Received: by 2002:a17:90b:5647:b0:3a5:1b:34a5 with SMTP id
 98e67ed59e1d1-3adeafcf067mr2467373a91.49.1792863423782; 
 Sat, 24 Oct 2026 10:37:03 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 08/20] target/microblaze: remove explicit target specific prefix
Date: Sat, 24 Oct 2026 17:36:37 +0000
Message-ID: <20261024173649.7405-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX0JZxZmNjXwHs
 K6J7ZX4yN6pkp0/SUv9S1a0wMVCw00yqCRSxhY3M6DZ9gVVlviT+69deWh6MSm/EQOfV0u2tCge
 V1xuLsOUBVqAXk62wlB/hkK2oE6wkh4=
X-Proofpoint-GUID: EaPQt8kQZaMTErdfSUFAaJmEE6AKIpl-
X-Authority-Analysis: v=2.4 cv=JvhkP84C c=1 sm=1 tr=0 ts=6adcecc1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=4ilfOIZX6_xEahZvDhkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX9DcgZVWgrMZv
 EygnCmebRBa5MUqkp7pbNt4byWlbAGb0nhdLQCxZJT6dZ8Y9aIhjGb6UaOJF0TGTVWGyhtJjChN
 4isRx/i3gr6lQ1dyM4jAUT91H9azxwDirYjFMgxSPfBnW6pt8sQf4B+KChSU8oNI5NDUC5DgC4H
 SFJ0MBPzGuwL9O98YtSZU0omYFlFFl7beMKGGkx+bH4SkTM6eQbgxtECwowt/aK2tqyXnYQPQF3
 tAWZwChXOQ0OESd4015WXZwVntnBwq+YdIX08lBq1Cqhb5rPLts6N1gzovx//7TGb3oS0o4AoEs
 NYimyKV+JDgQPIpNmBYW5Brk3EHvYr5E2lbh2Y4lzMrHTWyiRt2eZSSbDFIAM6cNQwep5LGL0bq
 EhcNLiIDnBrJOa1cS6Ybobe6mcHC+6Rhrto1Sx1XAuq2mWWafAaWDFLDPKfoDq6T9zf00H/p6dH
 KQ5zUogk/Uen2Rw7xuQ==
X-Proofpoint-ORIG-GUID: EaPQt8kQZaMTErdfSUFAaJmEE6AKIpl-
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

This reverts commit 4da3423973e8faa544744777f629ac82dedc0869
"target/microblaze: prefix helper conflicting with other arch"

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20261024163249.77855-9-pierrick.bouvier@oss.qualcomm.com
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


