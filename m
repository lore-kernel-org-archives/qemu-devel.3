Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF038CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 18:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChWu-000495-2u; Fri, 02 Oct 2026 13:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChRw-0005iU-2e
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:53:44 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChRs-0007mk-BN
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:53:34 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-34bb8b31647so246238eec.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963611; x=1791568411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xeh4/8nThzjkfpGh7OB2SbQr/xd31Pe82F8UwgQHt9w=;
 b=DlkS/7PtFwdnoEBQnWSAqD7jmQhM/9G1YfsC0nz0C4sgmLvYbSYMEi7s4p1xS1WgA6
 M/VpqYgeNgY5IrgqQ7ROZQuZH4vsVDUHC7xbD1stql0VI6SaxQfGLEzWf/NhJ8A4wAvd
 rafB0mJan8ZIkQHTSinqTfWlUAl4JNL3J6v959fqCYzyJQHTmbz9EGiumgJMgtYme4Vo
 93Gylzm8gOJ3o5vRAqohzv1FmWlo2YyY9hAdO5U+ZzY4mPzZT8+jnZTg3YoyudfK1r7a
 eb5oTX1IvUXV2HxmehPxEVSao1a/J4Cklqoc69mZqqGKiiPwpLv9j5ODr+EoKIm7/CVB
 JuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963611; x=1791568411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xeh4/8nThzjkfpGh7OB2SbQr/xd31Pe82F8UwgQHt9w=;
 b=d+vUPMhG+exAiPY4OMP/UXuGGdbIjOgaJGjpo38ZphS3cY0QZEG15SZaR9Cg5HNkzf
 LZ9qLElj9SKAS6+xKqR1ewLCq8U98mFwSSTeiWgcVclWfia/CLBTyux8OljTVWEZhjbp
 9qkXgUEW5ECZdpSQ7juBx/ZqDuWNuzE9NmVMqmWC3w2v5PqqUAExLUJsvaQssF7fUBMR
 h0urdrQ4zRMe5b/1kubCytbMUN/HnpMk+h2hpV3CaK4FUhzclWZ0U8ssgAM8iqYlBWKh
 gvDhydWKZSlRlOgGXEGfiV5chCqFJ1XkChuJpnCgAwom7GDmRFxbOcdMzFGA70nmzwp+
 KIkA==
X-Gm-Message-State: AFuF++nLoqQp37ZsU20xPLo/3KTap4qZcMeBdBlNncdoWADsDog2YMxl
 jSbj/kMnx/cty9NJd6+Q5HlLk7avc3fbs1pSlgQZqL14UHpwWJd9OAKdGvr/BnugCD4=
X-Gm-Gg: AYBFou1CUK+bQJE4dCOSXxCsQ92h5erl1+1LSq7zUMSkYeHjPUnAKgHL3LVarWd4T8P
 0JNGeqrbAlDNbQfz3HycXAsjiymlIeeyEjpNpk6LETiTxvREC5HU6Hnwuc2WYlAI8ZxGmqvQq3V
 BcgfDMLCoN/adFw8hjuyHd84+lgSLS5PWUTfQ7kYE+4rj9B6um59Qhz2bcr9UCc5CioX3hwmWA4
 ai1vDTCtW0ab/nClcgvTG8HUro0ASJt7oCmLRICBzdfALaFqA74bseI+hPV+EVHXj9/27vY5pjo
 u2R3DnFUfDoVZFeWMYDWbfQzChhiqZRGbaP8pSZ0AFs5AOQIfOAk6obKGgWErMdfrbLQPwxLCKQ
 MvnaxWiy8IndL/jx0lVTMVdGsi17hInpPgsIAxUv9jywN/QrH8sKPv/ECtzLLLZqU+Tw9W9d4et
 wRVTgC3NOumVgbhE/U4GxneXZxXZgAGWE7BZuvlgWNQfcvPskBXEZDPSlo+BU9fqf8j5XujovWu
 d4PrlLZ34RpefLPFGReDGjl1N0lwt0=
X-Received: by 2002:a05:7300:d519:b0:340:e422:fd40 with SMTP id
 5a478bee46e88-3511141b58amr520456eec.16.1790963610844; 
 Fri, 02 Oct 2026 10:53:30 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34f14f9f2afsm18027361eec.18.2026.10.02.10.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:53:30 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Rolnik <mrolnik@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Helge Deller <deller@gmx.de>, Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 21/27] target/avr: convert debug/break/sleep to raise_excp
Date: Sat,  3 Oct 2026 01:50:29 +0800
Message-ID: <20261002175037.1747-22-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261002175037.1747-1-luoyonggang@gmail.com>
References: <20261002175037.1747-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use the shared raise_excp helper for AVR debug, break, and sleep
exceptions while preserving target-specific unsupported handling.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/avr/helper.c    | 24 ------------------------
 target/avr/helper.h    |  3 ---
 target/avr/translate.c |  4 ++--
 3 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index f452c9d9040..ca58a0191fd 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -152,14 +152,6 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
  *  helpers
  */
 
-void helper_sleep(CPUAVRState *env)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = EXCP_HLT;
-    cpu_loop_exit(cs);
-}
-
 void helper_unsupported(CPUAVRState *env)
 {
     CPUState *cs = env_cpu(env);
@@ -176,22 +168,6 @@ void helper_unsupported(CPUAVRState *env)
     cpu_loop_exit(cs);
 }
 
-void helper_debug(CPUAVRState *env)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = EXCP_DEBUG;
-    cpu_loop_exit(cs);
-}
-
-void helper_break(CPUAVRState *env)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = EXCP_DEBUG;
-    cpu_loop_exit(cs);
-}
-
 void helper_wdr(CPUAVRState *env)
 {
     qemu_log_mask(LOG_UNIMP, "WDG reset (not implemented)\n");
diff --git a/target/avr/helper.h b/target/avr/helper.h
index e8d13e925f4..09ce0624915 100644
--- a/target/avr/helper.h
+++ b/target/avr/helper.h
@@ -19,8 +19,5 @@
  */
 
 DEF_HELPER_1(wdr, void, env)
-DEF_HELPER_1(debug, noreturn, env)
-DEF_HELPER_1(break, noreturn, env)
-DEF_HELPER_1(sleep, noreturn, env)
 DEF_HELPER_1(unsupported, noreturn, env)
 DEF_HELPER_3(fullwr, void, env, i32, i32)
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 3c576060970..477610cd349 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2554,7 +2554,7 @@ static bool trans_BREAK(DisasContext *ctx, arg_BREAK *a)
 
 #ifdef BREAKPOINT_ON_BREAK
     tcg_gen_movi_tl(cpu_pc, ctx->npc - 1);
-    gen_helper_debug(tcg_env);
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(EXCP_DEBUG));
     ctx->base.is_jmp = DISAS_EXIT;
 #else
     /* NOP */
@@ -2580,7 +2580,7 @@ static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
  */
 static bool trans_SLEEP(DisasContext *ctx, arg_SLEEP *a)
 {
-    gen_helper_sleep(tcg_env);
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(EXCP_HLT));
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
-- 
2.52.0.windows.1


