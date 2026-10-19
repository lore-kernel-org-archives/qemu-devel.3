Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C74C606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=arTdp3Si;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nx1uiYA7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIung-0001km-VB; Mon, 19 Oct 2026 17:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunR-0001hZ-4V
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunP-0005iw-G7
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:28 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJJuAo3672236
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kYCjosJDbOV
 u3JKFRh2Q9ZFgFXtqELeu0Md1O5c0fwQ=; b=arTdp3SiBZ6L6RgDg/aACMzMvWN
 6WaTu+Y3SVWqO4/10gkb6dVbAB48Mm0DZKk7HBj8q01Rrg7ldk+WkY9aM9dswo/E
 JiRqKCXcjiASIzrsukyXKCtxfnnPkGs4TZngLjrIgPpy46z2D3gTAtuPCMTHOnxV
 sJayAvkcogrnTWpu+u0b2XDCXOMejpprgkdkoLgHIL3kAscVpyVhmUgsIdOMtmOh
 XCo9npUsYAkIykOsT72Ob1CmlXKokITQrH7oN6lGx6CdZsI8Ee0VTzSCBh3o2ALS
 4wkX9DinZF76g7kNJ7tnMIOwgsE6HOOaowMrg+0JmdKguxwCrChZrmlzSlA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3xbb32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab926c236aso2465544a91.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444885; x=1793049685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kYCjosJDbOVu3JKFRh2Q9ZFgFXtqELeu0Md1O5c0fwQ=;
 b=Nx1uiYA7RXDF6gHAXiy7jPIHDpKiW4NIuOB41qSMvB44Mly8SLd3eWGyzURhvXi+hI
 IYVmkr2eXmjG5DQMVnFbnkP4/dJFQPP/thEZEzSbytRJtHWNZyIYfWaHAubqaF70vXu1
 BuadUW7H+0Ny42yJenFEs17KhHbllsniV7oW9+0dQ7Iv+9gzdzn1pGXMV27jgs38QVK+
 nGSjgafH9ZauTR6oQcJBsm00KP3LBEfFqCSPhvzApJGGFFfBUGnoRnj8iecT/ZKBbri1
 o05b3qUjWBYjBluvkR4uNZF9Op73BhMJ5EG5abEFlCgXyPxHzHkj0FsPdtAK46M0hed8
 uTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444885; x=1793049685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kYCjosJDbOVu3JKFRh2Q9ZFgFXtqELeu0Md1O5c0fwQ=;
 b=iYlcrq3eDAIkF48jXzTWwAKyfmXkvsOtD6qkxQ1imeylElm+dFBv3tx33XgMMNTx+T
 OEoTszXmjMTAdwhKJLcsRG9KuJ3CGK9xAGPtr4pJXkTyv1f/gU9v7Tir2E907RGrHZfG
 +0ydnVv9xyi+dRtXue/5A0sO+jjIAUe/8TBauXd6BxzC9a6HPT8RXebsG9paXGnKsjJp
 JyJicEVl3aCDx4brTOa8w2Oq3COG7GOPkNQ1KbOoEOge14+Vs6AXMF8dMbpyEGgW4iOK
 l1SsQsb3zKwLK1ZG6jcTvRWa3n91cDO+EVojCK3nhKCwhY3SNDjVfj+qL10RI8puZ8XQ
 Yckw==
X-Gm-Message-State: AFq9FYKUx45eobYl5O09lpxCyqCo/7ae6vnBjsMHv/u6KksOnlZjI6PF
 0EbMNCEdEShmbepHdmhvtmpFwz+mP6CDYUNRrrqtTwLKMFnETNqT8823IX7EO6QojqVO3+gos9M
 4rx1/T/Qw56wKPliM74LZfN6Szy5GlyGVEmyQTdF/J8Qk5Z2NbUoQE4j6iCB8stNRLQ==
X-Gm-Gg: AYBFou1g5ImbbTnyxrh1IRXZu0qHhMHEuKWVE6lENVieoA5MVFHhG18MJs/qoyHPjrH
 EuV6JbGXbbfNFJs0sMYiVnZp0dOSyDQ1UjmWDjUH/8ZgO1h/l275632eDXd/jT9Cov+ngNcAnLL
 VoqWaFZ0StXAZ9jaFc7R5vxa0PA6iRiDz9jaeZXQPEoXyfILKmz5MOm9DiOJPKx1EMkNVCNifvk
 VOMPklGZ5dqXJz6HKRJB7b+M5bQNAEO08IBZDLscEVBN8yQc0aLHhvFpOMSESGnIEwdilhRQe5l
 sOYMOgYCzOSP5M3GkOT4AZUzzsAeAkyT7n4ERTMgmQ1nsCEkF9RxYQi/QmmSVil7XREkQiODYC4
 RO3PhueAwiu4WCM03dKpN3theBjuAoixXdgMA1LJFvngE1NNj3fJzMW5MaU1bPek=
X-Received: by 2002:a17:90b:1645:b0:3ac:7842:bd50 with SMTP id
 98e67ed59e1d1-3aceefc5395mr8093985a91.15.1792444885481; 
 Mon, 19 Oct 2026 14:21:25 -0700 (PDT)
X-Received: by 2002:a17:90b:1645:b0:3ac:7842:bd50 with SMTP id
 98e67ed59e1d1-3aceefc5395mr8093969a91.15.1792444885058; 
 Mon, 19 Oct 2026 14:21:25 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 22/26] target/hppa: remove explicit target specific prefix
Date: Mon, 19 Oct 2026 21:20:41 +0000
Message-ID: <20261019212046.149572-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jXsD453dlCA33wghXgDxiZPiTeOdMMC4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXyi6gHTeELqGr
 n0WWKZiucy7OTMwLC9p5XHJMOocYc4BAA+JUXzCmcbp1ySaMuZdxdqpTdIwuYOk0kRGxAn8ZLDS
 7FY3U8eAvonfF7N/VQMA1gQemNeoCb4=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad689d6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=sRxLrGkicsVQIPpmWPIA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: jXsD453dlCA33wghXgDxiZPiTeOdMMC4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX+bBAhP9nMrhf
 nJe/pbNpgTJLLv35CkzLUc47kFUvzFjkpl1aTnFhzNffKaKGYGIL1atB7d87eX9/QLeOTNdEJaQ
 lSN8gvwRmwqWcLEZ5BzJRJ2sMXtjs8lZ8XW2HhiRXBgk8YOGfNKU9TvRLjUBP6nWsKrtMC/iaGH
 4DMtDDR8Pnsl198w+D5+Ps5bXzbr37P9JVk6uIrdSmOdk0XIqmoxdKeH2qdtnjscVaVHm7VvY9O
 Yl/GbGMsVyj5JjhUasBMnLc86DOKEkBzUNa7NiFaTt7PheVulvZtR7CUGh3H/zhTKzSvfEFumo7
 jSieJuDt09qdefXC/wbHgOoGAwkNq2wg1MAOooaVztsXPtXxqW7Cw8iACGE2hafF/A+F+0IOWNu
 xi6CV3EfTkxy+Op3r0H/DQMZxYgucxjTzQpNvKdYYYh/zZCHNOh/Rsq6Wp1AmHRJ4Eef/iu28sK
 xpINizbAYw8jylCS1sQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

This reverts commit cd095f35b148f3fa0b2000a36af0c9efe2299806
"target/hppa: prefix helpers conflicting with other arch"

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


