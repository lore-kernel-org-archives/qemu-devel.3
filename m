Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A051606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LgunAsht;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EWDxSwoi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKegK-0000zd-Ub; Sat, 24 Oct 2026 12:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegI-0000yu-QL
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegH-0002OZ-2C
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:18 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF0AeH1863446
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n0/OSbhKzQ3DZJckJnJ9aCL700qVXKQ7+9hO37RoqUc=; b=LgunAshtRM8v2ypT
 fLUBxxbWJMf+SMIV1UNkxe3fSGKG6M3SJVi/IXsYqY2qPT2qpvR29mMre0g7zT5K
 AbbqIPjm1PiACidP1TkJDNuZbbc9tABkIhbFyI85+toAWVTxWOGjizeUAOwCpdYP
 HhM+7oJeZtppxTRUkhafD1xOiFWLpZDfZnHrjqQbhSk6+2BVRtZGR1FMjM2elqPd
 caYEgexYrYLhd6bExeXRiVyo6r8gekKLWbyVooQoVx+cw7DZxrunQaCtWLFKggeA
 RSC/ouOdJLJbbLrN/MeRbWuGE0YlT265byZpZaAZhBNYH5JVPO6Me+xkWrzAKHfB
 KaljAQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmruhb5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:16 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3aca98f01c1so1727794a91.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792859595; x=1793464395; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n0/OSbhKzQ3DZJckJnJ9aCL700qVXKQ7+9hO37RoqUc=;
 b=EWDxSwoijaKwEtYXySejAmdu8rjGZF08or54m5rpbLjg5Uk97uhI404WUImW7tGjZS
 DNYnj/pe/PlK6ZZ7bOswqXhEDzFAl+CBw1arqTvcaN4jf7dLObtRFotz3voGR1/cEAne
 sOcsrVLlqgKQn+mO5owZOK/t+ayzDOu8jW1TPzzQy2ou0+hT2L5prv7mJ9IG3JW6lWAO
 4et3JuA4PAC0oyFrPeGJHaAVdQMU7rRAn9MyWbC6uRCjF5Kzyug5kqnOnlyyW1/EStts
 8MzxtoZWahSqoJG7lNLutvnXW2MLiNLUflAhvXkFzpp7YD1imsE3c9UHbvPlPD5DljaT
 qVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792859595; x=1793464395;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n0/OSbhKzQ3DZJckJnJ9aCL700qVXKQ7+9hO37RoqUc=;
 b=tyFu9wmroCyDqwg9x0loY5LJGtT61OoTbM50m6XZhE6n4M6Scga6blyqUREf9kIpsn
 sQ31qrBGMLfudXgHXK/FyEZ8cgNHh9KPUtv+aFBndF7kt1EPBCLHCMGN0vKzyFbtmtLO
 6fwfADVTSXVTA7/EmirXRAy7uwpTbWYn3ZgSUP5kSi9sXvBQHQ7fTBjCMysxFtKIRqaW
 OwN2ALSev/FIzgSPJ6L8obSr131T2brHNsly/dCEK7blcz9KaYZmBzXlIG3pkJ/qaKRn
 1yiIe8y6rLJtUBieD690rt0/b6dXdDgKWCIDYYcC+Fdo0bwZ73RU2d7nJkFYkyt1N3qY
 4aAw==
X-Gm-Message-State: AFq9FYJkTZ3ilane79Z+3EbAQqWz50knFYszUDpvNvnGp46KMXnMB7XQ
 9WRHSr/zoNlYve9eyxpphpNcVhi9MItcVTNfzjW7Ckv0001cpixQQfLO0qF+aEZFhrTTu5/4KWz
 rEO70lvDDA9NoQ8wa2mUsp3ZBBnI5eE2sWYPtQlT9HbrJH7tX916MxXK88zOVN3Sm5g==
X-Gm-Gg: AYBFou3ZVfFopIXRmgwHUHAemNOPP+WgnidziP/dRuRQvgB/5xxpQR9hQY4ay3K3giY
 vUZBOl15KDqd3MLWJg5ynQc4QUrsBP2zjryUqfOHIOHNG2Rfi/2l+w5ByJR6gO4FcYHNqevltYD
 zFzjtxzIl7gZFFVnqbWZ6MgJ8baNPLyLgvbyC5XWe8FyEIu5I4QzwabD0PnLAlS6sXP34AXXoXV
 l1XZsv4nrYLkumAMqAQndjyAdTreUXK69Leviwl7NAigTgEJsA/PEp283thjt3SUuN39IvOJcaj
 nBqCI18twgWg351wb9aq2G0pwjF/HlilMgsXsRKKfTFAN7TsieHZqYJMyrkhMPh1ZDDL9rIp+Te
 z95XDgL/SU7QsQZsqWbawn+/Sf9PItcfYIaUk7XNYYZ3/aUWWJLhGKBEbccv7k4M=
X-Received: by 2002:a17:90b:1d05:b0:3a4:b8dd:1447 with SMTP id
 98e67ed59e1d1-3adeae76438mr2147565a91.34.1792859595065; 
 Sat, 24 Oct 2026 09:33:15 -0700 (PDT)
X-Received: by 2002:a17:90b:1d05:b0:3a4:b8dd:1447 with SMTP id
 98e67ed59e1d1-3adeae76438mr2147551a91.34.1792859594561; 
 Sat, 24 Oct 2026 09:33:14 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebad93c5sm1932270a91.2.2026.10.24.09.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:33:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2 06/11] target/hexagon: remove explicit target specific
 prefix
Date: Sat, 24 Oct 2026 16:32:44 +0000
Message-ID: <20261024163249.77855-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX1tF4PTjsS14+
 7x2M+K3TYzsAOVUNFLn88YgOsYBML5FvNjafXdbFLwEqIQ/9YN1k78TLY94Kl+qqmDw0ixFDlkI
 p29hj1Dm9Q2qi8cVm94hkJ9JDNhCdvd2xMivPtxFlEH6Lk3MFvbJKQPJsNVUIa3MwAzm4SsZoOD
 I54nz4NSRqMJcsGWsaCjKkDxRPWc2iQMIoganY5IDfoQxJlzMzp174Yr7AuclrS/qRjQHIj9wnh
 pyey8fJkGmMnkhe/My4nLNcXr1WdkYBDprT8Y9uURnrDym7Qkx5r3mq87Lmg/yb0Zsk6jnCkFwD
 /BbYQn6FW85ZGqYmDnfeT7gloIWA7k0H+CxrI5YnhlnVUA/MFUa7ymKOYuYcHlvZjZpYd70soBE
 qNBZl3FLdqWGGh8BwkOl9f8+arLHfj3OxY8XtPzW5OS05XVs/+rP6hwND9XHLjK2wn5bNMpWGjX
 fYAfQFwLxwbN6FFgpcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfXzbHXx2pI2Vzb
 EhOP4IvsNNVQWS503oHHnTUoJZX6JQ1UVJclJwaFElxz/GHOBWSMyEovu7pt5lZMfxAhEsrDMo9
 E5Fz+dj1cxNbXZvf2g55HXUKFPPYrEc=
X-Proofpoint-ORIG-GUID: 7TmAxvz-Ky4QQ10dpdRLRFaRwFchJxp9
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6adcddcc cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=xJBkFjxltbiK57tzlAwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 7TmAxvz-Ky4QQ10dpdRLRFaRwFchJxp9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
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

This reverts commit 086150a223a6dfeae85e8bb925c5df0ca3061ed5
"target/hexagon: prefix helpers conflicting with other arch"

Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/hexagon/gen_tcg.h     | 2 +-
 target/hexagon/gen_tcg_sys.h | 2 +-
 target/hexagon/helper.h      | 4 ++--
 target/hexagon/op_helper.c   | 4 ++--
 target/hexagon/translate.c   | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index ed05f97efed..80d8a7b6bac 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -1135,7 +1135,7 @@
 #define fGEN_TCG_J2_pause(SHORTCODE) \
     do { \
         uiV = uiV; \
-        gen_helper_hexagon_raise_exception(tcg_env, \
+        gen_helper_raise_exception(tcg_env, \
             tcg_constant_i32(EXCP_YIELD), \
             tcg_constant_i32(ctx->next_PC)); \
     } while (0)
diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index 3760b671adf..413ccc97f7b 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -80,7 +80,7 @@
 #define fGEN_TCG_Y2_wait(SHORTCODE) \
     do { \
         RsV = RsV; \
-        gen_helper_hexagon_wait(tcg_env); \
+        gen_helper_wait(tcg_env); \
     } while (0)
 
 #define fGEN_TCG_Y2_resume(SHORTCODE) \
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 28591417040..47958c48ea9 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -18,7 +18,7 @@
 #include "internal.h"
 #include "helper_protos_generated.h.inc"
 
-DEF_HELPER_FLAGS_3(hexagon_raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
+DEF_HELPER_FLAGS_3(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
 DEF_HELPER_2(commit_store, void, env, int)
 DEF_HELPER_3(gather_store, void, env, i32, int)
 DEF_HELPER_1(commit_hvx_stores, void, env)
@@ -138,7 +138,7 @@ DEF_HELPER_3(sreg_write_masked, void, env, i32, i32)
 DEF_HELPER_3(setprio, void, env, i32, i32)
 DEF_HELPER_2(start, void, env, i32)
 DEF_HELPER_1(stop, void, env)
-DEF_HELPER_1(hexagon_wait, void, env)
+DEF_HELPER_1(wait, void, env)
 DEF_HELPER_2(resume, void, env, i32)
 DEF_HELPER_1(resched, void, env)
 DEF_HELPER_3(modify_ssr, void, env, i32, i32)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 9850dc07289..82d38dc0b08 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -93,7 +93,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
     do_raise_exception(env, exception, pc, 0);
 }
 
-G_NORETURN void HELPER(hexagon_raise_exception)(CPUHexagonState *env, uint32_t excp,
+G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp,
                                         uint32_t PC)
 {
     hexagon_raise_exception_err(env, excp, PC);
@@ -1839,7 +1839,7 @@ void HELPER(resched)(CPUHexagonState *env)
     resched(env);
 }
 
-void HELPER(hexagon_wait)(CPUHexagonState *env)
+void HELPER(wait)(CPUHexagonState *env)
 {
     BQL_LOCK_GUARD();
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 2c18f5eebff..e2a5038a1a5 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -139,7 +139,7 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
 static void gen_precise_exception(int cause, uint32_t PC)
 {
     tcg_gen_movi_i32(hex_cause_code, cause);
-    gen_helper_hexagon_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
+    gen_helper_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
                                tcg_constant_i32(PC));
 }
 
@@ -1146,7 +1146,7 @@ static void check_imprecise_exception(DisasContext *ctx)
     TCGLabel *label = gen_new_label();
 
     tcg_gen_brcondi_tl(TCG_COND_EQ, hex_imprecise_exception, 0, label);
-    gen_helper_hexagon_raise_exception(tcg_env, hex_imprecise_exception, PC);
+    gen_helper_raise_exception(tcg_env, hex_imprecise_exception, PC);
     gen_set_label(label);
 }
 #endif
-- 
2.43.0


