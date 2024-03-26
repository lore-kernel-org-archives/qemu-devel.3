Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4828DC54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 18:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpBHp-0003KV-Es; Tue, 26 Mar 2024 14:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpBHo-0003Jd-1M
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 14:12:36 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpBHm-0006Zb-AY
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 14:12:35 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5a558d9c33aso1109457eaf.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711476753; x=1712081553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6HlLuZ9zAMNyBTGN/42HjZNTOLBhvdEH6OLOyzfOxk=;
 b=QShvMTn8irhj+zEn9A4urmA6coJp4gktWS8UsL4dcj219tSbS4h650vxrdQWi9jTgs
 Qi4765XMLSPmBZaoULBUUOE7pKltx7oKqlYxMHXKGGGxnCo4/BvTwTHZGa6aE2PbmGp8
 aKC/4jSlPrDWLQxlaBJGjoNEeDSf2w+QtD0x9OBze4ong/87UhKKApY9Vn8hmvCPe1A2
 Tqjojk2jKhaAQBzXo3bZdDK3jIVTBX2du1XBYAhTJqQ3UoXVzP/lAoFu3KtyqFavOquf
 N9IkeLuEtZTRkJVw4/i7mvFEtbPgI3oO55uMF/revSl2+hjL0Zugeam/UdBMQ6YO74t2
 mrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711476753; x=1712081553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m6HlLuZ9zAMNyBTGN/42HjZNTOLBhvdEH6OLOyzfOxk=;
 b=VaCFsSCg6566IGAHkp6G/3p+0j2wjuqXDvGZK30waLxtaYqKx8ZwF9ihoR6jzSy7J7
 EzQ05YfuaHc7h5vcT0suLfGIh0Nl6J6lZ0Pw6QVqEyd/zj5fi2nnHinCTYQDQm3LOj0Y
 SnGvEFGpl2W/FK2IqAnEV4GSghf1RQi0W1eYeIGSJt6Oax9I4a95wBdVf6J+m2lta6SL
 Jk0IAjIIf+X9HIOsyZjbquODSuIP/uObJGX/Ns5JmcoIgcSO35LrynnMVRHiRM0MUJhU
 ZJBTIylYmIE9AS0KiNxhFTf5fFwiRUAzg1Yx3br7NeeYu+Hov8b+94IPhyD+oeOSGmzy
 uBpA==
X-Gm-Message-State: AOJu0YwaTq+6TDrc2Uk+tcHpr1A/rLOon77aXgtPzlAwiMziLHQQxWZd
 tMmiyl3CSjgMXMhhahJjKNPHY1Au4gE0f8tAjQ4yditPhaOBGNP2/CQCicYrWO5575B1NPSDoh3
 r
X-Google-Smtp-Source: AGHT+IFpZzrzYl/Nykmqtvu4hlXXghwVOwvOEZgTNcvZOmEdO3S3kIQXztZEoLBzFIfoIVHOq4XdCw==
X-Received: by 2002:a05:6358:5782:b0:17f:58a1:12b0 with SMTP id
 m2-20020a056358578200b0017f58a112b0mr12776997rwf.9.1711476752858; 
 Tue, 26 Mar 2024 11:12:32 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 q27-20020a63751b000000b005bd980cca56sm7835336pgc.29.2024.03.26.11.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 11:12:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org
Subject: [PATCH v2 1/3] target/hppa: Generate getshadowregs inline
Date: Tue, 26 Mar 2024 08:10:26 -1000
Message-Id: <20240326181028.332867-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326181028.332867-1-richard.henderson@linaro.org>
References: <20240326181028.332867-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This operation is trivial and does not require a helper.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h     |  1 -
 target/hppa/sys_helper.c |  4 ++--
 target/hppa/translate.c  | 17 +++++++++++++----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 8fd7ba65d8..5900fd70bc 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -86,7 +86,6 @@ DEF_HELPER_FLAGS_0(read_interval_timer, TCG_CALL_NO_RWG, tl)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(halt, noreturn, env)
 DEF_HELPER_1(reset, noreturn, env)
-DEF_HELPER_1(getshadowregs, void, env)
 DEF_HELPER_1(rfi, void, env)
 DEF_HELPER_1(rfi_r, void, env)
 DEF_HELPER_FLAGS_2(write_interval_timer, TCG_CALL_NO_RWG, void, env, tl)
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index 4a31748342..208e51c086 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -95,7 +95,7 @@ void HELPER(rfi)(CPUHPPAState *env)
     cpu_hppa_put_psw(env, env->cr[CR_IPSW]);
 }
 
-void HELPER(getshadowregs)(CPUHPPAState *env)
+static void getshadowregs(CPUHPPAState *env)
 {
     env->gr[1] = env->shadow[0];
     env->gr[8] = env->shadow[1];
@@ -108,7 +108,7 @@ void HELPER(getshadowregs)(CPUHPPAState *env)
 
 void HELPER(rfi_r)(CPUHPPAState *env)
 {
-    helper_getshadowregs(env);
+    getshadowregs(env);
     helper_rfi(env);
 }
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 6da9503f33..29e4a64e40 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2385,14 +2385,23 @@ static bool trans_reset(DisasContext *ctx, arg_reset *a)
 #endif
 }
 
-static bool trans_getshadowregs(DisasContext *ctx, arg_getshadowregs *a)
+static bool do_getshadowregs(DisasContext *ctx)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
-#ifndef CONFIG_USER_ONLY
     nullify_over(ctx);
-    gen_helper_getshadowregs(tcg_env);
+    tcg_gen_ld_i64(cpu_gr[1], tcg_env, offsetof(CPUHPPAState, shadow[0]));
+    tcg_gen_ld_i64(cpu_gr[8], tcg_env, offsetof(CPUHPPAState, shadow[1]));
+    tcg_gen_ld_i64(cpu_gr[9], tcg_env, offsetof(CPUHPPAState, shadow[2]));
+    tcg_gen_ld_i64(cpu_gr[16], tcg_env, offsetof(CPUHPPAState, shadow[3]));
+    tcg_gen_ld_i64(cpu_gr[17], tcg_env, offsetof(CPUHPPAState, shadow[4]));
+    tcg_gen_ld_i64(cpu_gr[24], tcg_env, offsetof(CPUHPPAState, shadow[5]));
+    tcg_gen_ld_i64(cpu_gr[25], tcg_env, offsetof(CPUHPPAState, shadow[6]));
     return nullify_end(ctx);
-#endif
+}
+
+static bool trans_getshadowregs(DisasContext *ctx, arg_getshadowregs *a)
+{
+    return do_getshadowregs(ctx);
 }
 
 static bool trans_nop_addrx(DisasContext *ctx, arg_ldst *a)
-- 
2.34.1


