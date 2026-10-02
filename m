Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186E4CA5FE0
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChRA-0004oK-4Y; Fri, 02 Oct 2026 13:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChPr-0003sZ-SP
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:51:30 -0400
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChPn-0007KZ-El
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:51:26 -0400
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-33fb4680717so6794108eec.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963481; x=1791568281; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NztR+mMu/kxVkbQISDdOFa5VSRkwOwOsIq56cZDD+0s=;
 b=dlxvVWh5HxWkzqPDJMZFreb2z4rwm+4neF8E0k6xYL36ZZhplD+WONvNnBly8gCPi9
 kuG1wp1bcAR/1HKTo4gjgGQlBmT9k9L+dJACH8Ia3/tWXmw6GZPSbXL7Nbxui8OIrxIL
 OB4mk72qlHa7ZjGt4sfCH8lEqnmX/4bagK1WkggX+37iMMerLbBPkEG4S2WcOJvqT7s5
 TWgEWUUdCJVZtcuq1MyppDlKoWQIPQPFhFfen1uvQe+axL09Vf/T/fMLb+VdG/+Cvdcb
 sNUTKtEv4dYQEC1lB+CD8yjayixFXlScbHTJxm0Qd7ARVvszzmYRAL0/ZTq+rLLL0Cd+
 549w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963481; x=1791568281;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NztR+mMu/kxVkbQISDdOFa5VSRkwOwOsIq56cZDD+0s=;
 b=E4C1gQuT1p/dlHqNErDONNoLqWv7ObJ4dVS0g2FbjDqL15UIQn4sopKipDofKM7GEE
 bZzuanHCeElKcYTw/iqpAVrVTgetC8vEw+PIXigve5dcRkc6PzEvgG9mBQ8+pEqCo9+H
 hZGJVhd+VJu9i62+AMOzQPzE2GYy/x+8bmN7xxyRPzQeeWNuLVd29e5pbVM8ISQVSSuK
 YCB/wst7NYQzsGs8zLDl5O3L7vMCJAwTkT3Ox+FUk8b03H5mWJv5Cy5yHI8jhJLNqQkk
 e7G5gTshY9yHyNvXCHYYDcWad2DcHqKurCsoQm+StTvVJ6fUJgE29uVRxrbAovC8bLLr
 A/jg==
X-Gm-Message-State: AFq9FYIirV52F6KFydhdlcOEIt+4bY+2orTaPobBuHD5UE21w+QntY3y
 Q64prOdkkpqdIo/oZkHf17TsBX+ewT/pZIjlwNGAQdMSCZk8NnpmVcINYT3sdRdbArQ=
X-Gm-Gg: AYBFou0PMNTycU5zs3d21pG3DEIddg0MH455rQA3fhmwihA9k1UvpCZKWFVuSkfuIDM
 YMOF9JhmPA6p2xZ+YoxZ0sCVkbjY5MOC31vfWClMEH+vXMG/kTkWdbx4PWLcME4PiUAMUpWEIoX
 itaxN4W3ToUcE8ODdbVQUGrxkJQEO9bTcC9aHcIJAtg9pmlmkLgyXUo2Rn2+mE5LrDUJVyaTHyj
 J00mNHi5ZH1KBg1TTRcJ5Jr7Y+Nkv2g+mZzG5uSGxbNhX4Nyj3CJheI2ZaEHDMC+/6BTGD9qAKC
 vChX6M6OPDDdxX/hdwR0TFa3RECtIVWmmM9UjY7xjO3Zkept3rq28lIP0ZYkWAejk2jgDda8A2n
 Gv2zbghoSp0BTDHG9ggCmZY5v0W1qQmrMgdVIcI8uHxt55lD76EoMtoU92s/Em8AHBCteGqrvgd
 glEclcIMOQ26kMMUtwKRCqJ3fBmHp424nsyElCxyiYJRw9PusFifyVj1BmTt+/xG0EyLn6bLqjP
 Znw2VAFjnw0JRjgX4fW46BBZUzRNu8=
X-Received: by 2002:a05:693c:88cd:20b0:342:d7a0:2f40 with SMTP id
 5a478bee46e88-3511162fa7emr336824eec.7.1790963480670; 
 Fri, 02 Oct 2026 10:51:20 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34f14f9f2afsm18027361eec.18.2026.10.02.10.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:51:20 -0700 (PDT)
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
Subject: [PATCH v3 04/27] target/rx: Unify BRK and INT trap handling
Date: Sat,  3 Oct 2026 01:50:12 +0800
Message-ID: <20261002175037.1747-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261002175037.1747-1-luoyonggang@gmail.com>
References: <20261002175037.1747-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132c.google.com
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

BRK is equivalent to INT #0, so route both instructions
through the same trap helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/rx/helper.h    |  3 +--
 target/rx/op_helper.c |  7 +------
 target/rx/translate.c | 19 +++++++++----------
 3 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/target/rx/helper.h b/target/rx/helper.h
index 8cc38b0cb71..f3897ce7619 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -2,8 +2,7 @@ DEF_HELPER_1(raise_illegal_instruction, noreturn, env)
 DEF_HELPER_1(raise_access_fault, noreturn, env)
 DEF_HELPER_1(raise_privilege_violation, noreturn, env)
 DEF_HELPER_1(wait, noreturn, env)
-DEF_HELPER_2(rxint, noreturn, env, i32)
-DEF_HELPER_1(rxbrk, noreturn, env)
+DEF_HELPER_2(trap, noreturn, env, i32)
 DEF_HELPER_3(fadd, f32, env, f32, f32)
 DEF_HELPER_3(fsub, f32, env, f32, f32)
 DEF_HELPER_3(fmul, f32, env, f32, f32)
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 36df7d377e5..6782912247e 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -455,12 +455,7 @@ G_NORETURN void helper_wait(CPURXState *env)
     raise_exception(env, EXCP_HLT, 0);
 }
 
-G_NORETURN void helper_rxint(CPURXState *env, uint32_t vec)
+G_NORETURN void helper_trap(CPURXState *env, uint32_t vec)
 {
     raise_exception(env, 0x100 + vec, 0);
 }
-
-G_NORETURN void helper_rxbrk(CPURXState *env)
-{
-    raise_exception(env, 0x100, 0);
-}
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 132d495710c..d0910fbf8e7 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2170,26 +2170,25 @@ static bool trans_RTE(DisasContext *ctx, arg_RTE *a)
     return true;
 }
 
-/* brk */
-static bool trans_BRK(DisasContext *ctx, arg_BRK *a)
+static bool do_trap(DisasContext *ctx, uint8_t vec)
 {
     tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
-    gen_helper_rxbrk(tcg_env);
+    gen_helper_trap(tcg_env, tcg_constant_i32(vec));
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
 
+/* brk */
+static bool trans_BRK(DisasContext *ctx, arg_BRK *a)
+{
+    return do_trap(ctx, 0);
+}
+
 /* int #imm */
 static bool trans_INT(DisasContext *ctx, arg_INT *a)
 {
-    TCGv_i32 vec;
-
     tcg_debug_assert(a->imm < 0x100);
-    vec = tcg_constant_i32(a->imm);
-    tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
-    gen_helper_rxint(tcg_env, vec);
-    ctx->base.is_jmp = DISAS_NORETURN;
-    return true;
+    return do_trap(ctx, a->imm);
 }
 
 /* wait */
-- 
2.52.0.windows.1


