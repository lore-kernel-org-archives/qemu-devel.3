Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9998C982D6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Mid-0000W2-67; Thu, 17 Sep 2026 20:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mi0-0007vP-9v
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:44:09 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mhx-0001kg-Fg
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:44:08 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc1so62466a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789692244; x=1790297044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lulph+1uLiSsZprj2WnOvAAVxiVP07eJais76hf0yd8=;
 b=dNm/fQlj0DvQHlDCIxoqLggwufXm/0metJBY+I8/lA0Nvdt+a5eFnmloumiehIq49A
 76ff0TkFWbfqgyzTKECacVdXduna3w1V5wpdD924kVFaNTnf+ETGS/GjwV8KQD8qKgFE
 jouB88FeW/KiGKqNgg0U0W9zAbHyJpOY0oyw76N24HWQ1f9sxDzE9ZbzOZveC14lC5/d
 HaCKxjQfZ0M63sl7jWaoQ207br5G8uiC3bHXIBqbnBE0PtEG6sCH4xmT0XyXhLpK9HcT
 yjKuLAr6P/88z+7ndHNlCbOrlTV9MYwoGBwdL+F/577LMGOMt0Q8ysGdX8bQJDeK7nLq
 j6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789692244; x=1790297044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lulph+1uLiSsZprj2WnOvAAVxiVP07eJais76hf0yd8=;
 b=i1HYBezK1379oWpslLUQKqpo/INklohF3bfLBuYZk1emkMyBnIMx4fxWtiya3PH279
 iRpGgulENmk0sD+QMsgB65e+GIq9v4N5wvLWF3bA9zRSMjcVL6xKcWTeiUnIu+g/Ecmq
 jxax4uoPde5XjeUG5U9mxLDE5AJkVinsedt3nQEqUq9JTUCsz7/Pw7VzNNssLiHus5g9
 8QSc/2xWBfIassvfWBo/4f//kGTXvRQunxbF4apszIMQ5V8IwSdXKqUTLywD1ygOijWn
 OHvX3570CyIQg7ZD2xbalF3//algfeXSBWKAC9mFJqGpyj+2XzkmC87ZfdlEqnQOee86
 xduw==
X-Gm-Message-State: AFuF++n2/Yy0rdbZZ9wzqN2/z1XP9CmlPoj0cBmAFYrjGhbwjMEZb0D4
 Mj2+qumcu2EV2NwXM9u0i/Bxa2l3RsqK3e0EwnAIwYxm6XOhvlfjgN1Z2ivZ3rlHXI0=
X-Gm-Gg: AYBFou3dka3A3rBf+B246xvL6YnSVkWmVZe6E7nMZKJMG4XQWOAhl3EI0HI3QLWnSHd
 EYMYxiz3z+kzCblaAzC4iHCSt0P20P8GFnuH5RlraTkSRsXSEnNanSbmDGw+tSXf//a71pOFnu5
 l0F5uSeoMbcBKZ28RoTz9hUrNh/K+V7V4y+Rh2a5k/jHMNIzxXLy8DWpJqGqoZuThkyy/Jlyta1
 +3P+WnhXjSaqJAuXe7IWLtvVSVk42L9jF6UQ55nuPwWWdzv9m4DM34u6WTzBRhTpA02JurZUs4b
 RHptm6ubHy6j/IgtvIA0woC5OvIWBrbh4oSNWzNk3LvSNzI1s3yeu5j5rRY3YL9NU8VYSoP5rww
 g46n6/A7ICetw3Ae/DZPU3UrmA4vh6N5jUm/ptVwq2tF/2s6UZ8io9/BIVO3KuCceTKP1LsqRyj
 JPtmjfX+MrpRyq/Q/iskOK4Su2Nj/SY540AHcZGaZfnxkRuETJinXnSXp2+lUummLbM/Lo2iUew
 YNaTCNJzVEYUCuiOpP65NxkXQ6DBGmH
X-Received: by 2002:a05:6a20:3d8d:b0:3d3:ad3c:49a9 with SMTP id
 adf61e73a8af0-3dd8c516adbmr1396998637.23.1789692244095; 
 Thu, 17 Sep 2026 17:44:04 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144cdfc3df2sm600286c88.5.2026.09.17.17.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:44:03 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Nicholas Piggin <npiggin@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Stafford Horne <shorne@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 10/21] target/loongarch: convert raise_exception to raise_excp
Date: Fri, 18 Sep 2026 08:42:12 +0800
Message-ID: <20260918004225.827-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918004225.827-1-luoyonggang@gmail.com>
References: <20260918004225.827-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Translate through gen_helper_raise_excp with restore 1 after
storing PC. Drop TCG raise_exception. Keep C do_raise_exception
and use cpu_loop_exit_excp.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/loongarch/tcg/helper.h    | 2 --
 target/loongarch/tcg/op_helper.c | 6 ------
 target/loongarch/tcg/tcg_cpu.c   | 4 +---
 target/loongarch/tcg/translate.c | 3 ++-
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index e76c73c7755..e3a7bc9e9da 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -3,8 +3,6 @@
  * Copyright (c) 2021 Loongson Technology Corporation Limited
  */
 
-DEF_HELPER_2(raise_exception, noreturn, env, i32)
-
 DEF_HELPER_FLAGS_3(asrtle_d, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(asrtgt_d, TCG_CALL_NO_WG, void, env, tl, tl)
 
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index f41f0cb1e6e..36719617b85 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -16,12 +16,6 @@
 #include <zlib.h> /* for crc32 */
 #include "cpu-csr.h"
 
-/* Exceptions helpers */
-void helper_raise_exception(CPULoongArchState *env, uint32_t exception)
-{
-    do_raise_exception(env, exception, GETPC());
-}
-
 /* loongarch assert op */
 void helper_asrtle_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
 {
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 4b1d44a1644..56ef0d912cc 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -69,9 +69,7 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
                   __func__,
                   exception,
                   loongarch_exception_name(exception));
-    cs->exception_index = exception;
-
-    cpu_loop_exit_restore(cs, pc);
+    cpu_loop_exit_excp(cs, exception, pc);
 }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 124dce62695..ddadfb84285 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -95,7 +95,8 @@ static void gen_nanbox_s(TCGv_i64 out, TCGv_i64 in)
 void generate_exception(DisasContext *ctx, int excp)
 {
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(excp),
+                          tcg_constant_i32(1));
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-- 
2.52.0.windows.1


