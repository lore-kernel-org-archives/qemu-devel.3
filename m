Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FC1606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OCfSqMTA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RNDIp9EC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKegL-0000zf-Fe; Sat, 24 Oct 2026 12:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegK-0000zH-C0
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegI-0002Op-NY
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF0BP72450776
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XzFQ1RcHeXNBr18shSueqc4AYkRUJOl6+5D2bFMv8QA=; b=OCfSqMTAodexBH0h
 z8mUg1nSAQaNeW5FIAfzYhS2hHafLDy9pt4IOqmOmwBddTuGTf0MAPRSqPUsHX0y
 QbgxvR47j+lSs1m76sa4ZEsH+HzM2onwmllIYWRGlcqGKMGZdsfaCRs5Mm2sLofb
 UfVwL1Fl02z5RHxGJRAq6rKKwCs8vgMQ93QalW+0lVFwHI5ZaVrPcezDBv0UBJOK
 yghRCak7BApkS6ZuzDLeZx1FUxsstdNuycoPPjJe1bwcPQ5kRvDEBhxVMWuG6ShI
 l05BVM0HFQHh3tSFuMjtkwP4aBhrbLfpS8KO+zkt/a841A8msX7aTSTtE8bQfV6e
 v54Ipw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xhd4q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a6d30f66c9so2012131a91.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792859597; x=1793464397; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XzFQ1RcHeXNBr18shSueqc4AYkRUJOl6+5D2bFMv8QA=;
 b=RNDIp9ECvOnHhPY/a5U1mG/DYB2co7xLzexs6dluE2pQ8sTSFTghWau7/XCgEq7nh1
 zRdiQZ2C5l0NBEwTrFDHaplj7NvCW8s9JcNHkHra5Ovjc/TPqxraGRmIoYDc1Q+MVWHL
 6xktFdqUcBPQIsIwtJgUG/JrhT6gctjNce0dEU1q3NmanrzQSvh8AYzF++tgL1dau2SN
 xVTgS9H61ELhDIdpyQBwSnJS9PJ6tV3rz9tmSudb9xOFFIoZCEkRLx3QfD34Tz0TDlja
 J9er2l9j5GazS8aay6k1wJrvVqar2ZlbU/lFeDmppYUyg77ZaDPgb8IDSVWTcoRogIlg
 xlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792859597; x=1793464397;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XzFQ1RcHeXNBr18shSueqc4AYkRUJOl6+5D2bFMv8QA=;
 b=G5s1CqEDOnJxSBhKRbip/YLBxUKX/DnH5iGMjnmbs8j0LuySefbBUs0vvZ3Krw3U/+
 RjA7HOzpv424qOCO1zJYlPqVhYnnOJL04UERmidKhcmm6DqSrEIrrFUkIHyaR13WTayY
 ChErTvkRl+9ybUs/EqZHg99fR2GIt2XeNYb0sx/AtGCUi2X78ei9wxLp0uRF2Fj8ZI4B
 ylYKZ3zpklJcm8TU74x+R12iXYD1Jhz0EXFSXSnwC6Ml976NliWoyhjGHdmHycz8wt6S
 O2DMh8n0EpwaPoybAdhwaTzv1Cyd4XV2zdvZUfL7JGZMyVnUFWQdhAFHKWs1hkiKxnBl
 5gjA==
X-Gm-Message-State: AFq9FYIVoGUkDqAg77vvrzzVv77bt3dpO85jOlk2ggFrROd5Q/Sj/WIy
 IsbxmDwK5BcmSDMZ9+NkH/7D1jEvD7gWxsXC100lmhYgeLrezW1dLRVVPPav57nWcGT0gBYNAMt
 Gdx43715VKqFdqe3N3cajjSmJ3rTUQnMa8jUqV8Qg29UXtB0BCjYi/zrDcb8A5fp0/A==
X-Gm-Gg: AYBFou05QnKfQl7dALiS9cf03eOn3A8CijAJiqcVA99nBa6jmb3QNXzaZ0Dy4Q5g5dK
 jdD3BlHiKX4SdXjft9tMLNWffO9T2TnouLlY++U9aqjXCfpWgAgVzIM8URm1f/FQ/148ozHi+tN
 ndqxn8xytCh0nofjfWSXVrmXtNWdBJ9IzpdoSFqunQ3yTYp9CXNgmMKwkwlzj1jrVwqHCC6+ulp
 jR5kIqvzYjKQpfKnPJeRwKH6vJBwexpIEOHLIpVrkskgRmmm5609DTX+PeSrHg+JbjjtdCqDGWW
 FSSiK1NnFUS/EQzO+G8VRbUCd7rWINomq6eUMyvRtJ3aTw7FWvYnroowYeNbpJDN5y4f/gWKR7G
 SsdlRw02XDPLJAth94l6CccCFuqMjjztT+TZ65L9CUSaI7Pq3JlEpYj7I0kLk+Sk=
X-Received: by 2002:a17:90b:3c05:b0:3ac:36c7:c144 with SMTP id
 98e67ed59e1d1-3adeb5e3aa7mr1280352a91.28.1792859596383; 
 Sat, 24 Oct 2026 09:33:16 -0700 (PDT)
X-Received: by 2002:a17:90b:3c05:b0:3ac:36c7:c144 with SMTP id
 98e67ed59e1d1-3adeb5e3aa7mr1280343a91.28.1792859595888; 
 Sat, 24 Oct 2026 09:33:15 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebad93c5sm1932270a91.2.2026.10.24.09.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:33:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2 07/11] target/hppa: remove explicit target specific prefix
Date: Sat, 24 Oct 2026 16:32:45 +0000
Message-ID: <20261024163249.77855-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WFiTd1bIgOfDVLHn2M35QrCGyGhUW_Lv
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adcddcd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=xJBkFjxltbiK57tzlAwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX0EkDOE80g60M
 WFY4TBBssGw1Q6wsx4DqeyXkh0Cc5bY4KUO66Ctn4UXl9BJ4oQhiMUskECW4N5/g1dySsks2jk0
 UPRd2Ot02zGe4gkG4qeAya7T4nYY31E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX+jpNbJNC1G81
 m5oR4UDK/th9eHWKhuvkLWYm9Qqqqk2823Qd/6gV/Zy03ADkQ6GG9hqOQD5u0REaiVpvQsfI0XA
 SIRrCKR1c2UqDgT2yM4MqKwcQtaPVTUCUK7e4O8vbaEsd7zDQlX4/HjQNeYKMRZHSviEgJeD7/b
 Gk5okn7B/vikRlBWHzWv5vwWy2yIr2UzaY7usnl+lA5bSVBrEH11HZ+enMb44ZPJ8UvtVWuuXFw
 QyUgLNAkToC5FWN/loDoKlg2kTvSmZgbNgaGc9t2/+IoNFDP2ayGfS8wycEIwSsDtfxocc0mmZE
 U5K/30/txKjoRomQ+9dxdEVwGeEuS3KmYi4DF5AOJcQz4pIi3CqmiOjEht/SZpP/I4ZxPiHKMUO
 RGW5K4FNF7vbxaFRAWzGwKvY8FPbB4menGmdobrwlVTZomNeHxy3JTIDiDShFocun2MZU0JesZ5
 pe3A+dBjXbuHNpKIGyg==
X-Proofpoint-ORIG-GUID: WFiTd1bIgOfDVLHn2M35QrCGyGhUW_Lv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240065
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

This reverts commit cd095f35b148f3fa0b2000a36af0c9efe2299806
"target/hppa: prefix helpers conflicting with other arch"

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/hppa/helper.h     | 6 +++---
 target/hppa/op_helper.c  | 4 ++--
 target/hppa/sys_helper.c | 8 ++++----
 target/hppa/translate.c  | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 8d7fa1ae348..8369855d78e 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -1,4 +1,4 @@
-DEF_HELPER_2(hppa_excp, noreturn, env, int)
+DEF_HELPER_2(excp, noreturn, env, int)
 
 DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
@@ -82,8 +82,8 @@ DEF_HELPER_FLAGS_4(fmpynfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_0(read_interval_timer, TCG_CALL_NO_RWG, tl)
 
 #ifndef CONFIG_USER_ONLY
-DEF_HELPER_1(hppa_halt, noreturn, env)
-DEF_HELPER_1(hppa_reset, noreturn, env)
+DEF_HELPER_1(halt, noreturn, env)
+DEF_HELPER_1(reset, noreturn, env)
 DEF_HELPER_1(rfi, void, env)
 DEF_HELPER_1(rfi_r, void, env)
 DEF_HELPER_FLAGS_2(b_gate_priv, TCG_CALL_NO_WG, i64, env, i64)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index ea0680aa9eb..ec7f2a48e4d 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -30,7 +30,7 @@
 #include "user/page-protection.h"
 #endif
 
-G_NORETURN void HELPER(hppa_excp)(CPUHPPAState *env, int excp)
+G_NORETURN void HELPER(excp)(CPUHPPAState *env, int excp)
 {
     CPUState *cs = env_cpu(env);
 
@@ -341,7 +341,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
         if (excp == EXCP_DTLB_MISS) {
             excp = EXCP_NA_DTLB_MISS;
         }
-        HELPER(hppa_excp)(env, excp);
+        HELPER(excp)(env, excp);
     }
     return (want & prot) != 0;
 #endif
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index ccfc2b48816..4a8bbf32591 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -48,16 +48,16 @@ void HELPER(write_interval_timer)(CPUHPPAState *env, target_ulong val)
     timer_mod(cpu->alarm_timer, timeout);
 }
 
-void HELPER(hppa_halt)(CPUHPPAState *env)
+void HELPER(halt)(CPUHPPAState *env)
 {
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-    HELPER(hppa_excp)(env, EXCP_HLT);
+    HELPER(excp)(env, EXCP_HLT);
 }
 
-void HELPER(hppa_reset)(CPUHPPAState *env)
+void HELPER(reset)(CPUHPPAState *env)
 {
     qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    HELPER(hppa_excp)(env, EXCP_HLT);
+    HELPER(excp)(env, EXCP_HLT);
 }
 
 target_ulong HELPER(swap_system_mask)(CPUHPPAState *env, target_ulong nsm)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index befdb58e9a6..41300c0dd73 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -726,7 +726,7 @@ static void install_link(DisasContext *ctx, unsigned link, bool with_sr0)
 
 static void gen_excp_1(int exception)
 {
-    gen_helper_hppa_excp(tcg_env, tcg_constant_i32(exception));
+    gen_helper_excp(tcg_env, tcg_constant_i32(exception));
 }
 
 static void gen_excp(DisasContext *ctx, int exception)
@@ -2450,7 +2450,7 @@ static bool trans_halt(DisasContext *ctx, arg_halt *a)
 #ifndef CONFIG_USER_ONLY
     set_psw_xb(ctx, 0);
     nullify_over(ctx);
-    gen_helper_hppa_halt(tcg_env);
+    gen_helper_halt(tcg_env);
     ctx->base.is_jmp = DISAS_NORETURN;
     return nullify_end(ctx);
 #endif
@@ -2462,7 +2462,7 @@ static bool trans_reset(DisasContext *ctx, arg_reset *a)
 #ifndef CONFIG_USER_ONLY
     set_psw_xb(ctx, 0);
     nullify_over(ctx);
-    gen_helper_hppa_reset(tcg_env);
+    gen_helper_reset(tcg_env);
     ctx->base.is_jmp = DISAS_NORETURN;
     return nullify_end(ctx);
 #endif
-- 
2.43.0


