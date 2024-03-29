Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556EDC6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKlR-0002gE-Jm; Fri, 29 Mar 2024 18:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKl9-0002aO-0D
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:41 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKl7-0003Xv-FA
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:38 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5d8b70b39efso1864554a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751496; x=1712356296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvYdGosSJzx/q33wx/CPl4VQF18FxpEZiKeNYnXcRT0=;
 b=uW0yAgHdKw3RL8yHmHUuVMeIb2CnAfgQLKTUWz3/Lk8NT0kc2u7170bwQOVT4UPDAO
 0EIHiQ55XPN5MZnCXiqWeDBOMlvKIVCIg4KFnegpxKGzM/rdgLaSTvgbxK++LC2xB0sO
 9p5nZtm3bQ7+C2I55nuSB+3mjb8w9fUPvEv6CMhKGnGQJDDYyeICTuZAYTHnhaDqHoM5
 7F4OSBuasxx5oZz4hn0nV9ejrzQwBwM7Y0+3qcRQWJkUZQIDwkiys3Ns3VnVXt/IeTSq
 C7O/jiiJrupnyORjsEu0ZRk63LmfQgtdqwicq6I78nUUFGVF7Bq7xNzp263r4TX/cSBY
 H6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751496; x=1712356296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvYdGosSJzx/q33wx/CPl4VQF18FxpEZiKeNYnXcRT0=;
 b=ps6e/Fa/syplU72dBjAkEWL45n0wDibo0sMdgPfG8mrADPbIJYBYbFG9CPgCv7e0Db
 SCumxjeje+/RSIMs0ntjwEDN1m6zqjqNkRiX5pVIjh/zUu2HMIQe5yr5mvUhKVuAWJsB
 e5Pj3VjFeVOiHXldJG3x0qBb0UQXP/PCFoUHLuB59gHCHmFRj0jZe3huueXi64NzuQmZ
 fyMqyPkrGyVw1r6SWRaTVX2BNQySlzSwA0fhcPrseF5I4fBQR+dBdDW/jTpZ+R0/XfRA
 C16XetZ9N7id5z+CqqkCSHGphUiBZ4WeYWoJnavs5NCd1p+D7LY8Y21HZzz59PIdY4Lg
 J5xQ==
X-Gm-Message-State: AOJu0Yzno7sK/sIizEeIxPI/1KPSxAxcxWKShxHAreW3GaEVZarVhN5+
 fZ8VrqAWu5Joy2739CN0rNaiL3xRmvlJP0DWAi/7XhQNgW1S3qEt7GrSms6FgQpCX5dAoRXBPmb
 E
X-Google-Smtp-Source: AGHT+IEzx0eKXkUhJxxXgts34Av8eqk1BrGIv1lJ9gLiwDIf9yI6p5a14UoAffntv3qNGDRQJfoo6Q==
X-Received: by 2002:a17:902:db0e:b0:1e0:fdc6:e4d3 with SMTP id
 m14-20020a170902db0e00b001e0fdc6e4d3mr4170025plx.49.1711751495975; 
 Fri, 29 Mar 2024 15:31:35 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 15/18] target/hppa: Generate getshadowregs inline
Date: Fri, 29 Mar 2024 12:31:08 -1000
Message-Id: <20240329223111.1735826-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Reviewed-by: Helge Deller <deller@gmx.de>
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


