Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A97C9830D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA2Ob-0000QG-Qe; Fri, 25 Sep 2026 05:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OY-0000PM-AP
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:39:06 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OW-0006FE-Gb
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:39:05 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 834B143AA2;
 Fri, 25 Sep 2026 09:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5C61F000FF;
 Fri, 25 Sep 2026 09:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790329143;
 bh=tS0YcDzVifwFGi/tdYBQPi2c6igEc0t6JH9tkfzpQIE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LfPnHwxEKNuTdpWrB1jPm4PpaVoOvOVDrO2pdCfi2g7ib5t3O59zyO2Q1an4oQnJm
 C0jE7UPFrAQghZbVuaWoonEKOY/xgweGnTyxdyp4vWADTozcJ7c+905P+Uq2fpDTCN
 L9v2w/NZAabfGIUYVPNxJM97rn5FQcsoowbVKdFi3FcgstS9Juuk2T4iTFHW4eKNX2
 OuBKXWCD7bTZQEHAFZHot0b82mVTFRTXhDsYRF8L2qBIWs15+8bBtv4SwnEFJp44+J
 ybeCc/3FAVa8J/HDQ0lZEMyAtsVTuLFPbTHxWh60yc+FmUXozxCcOlgdnONXsQta+5
 cpTuu6/IWNQtw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 8/8] target/sh4: Drop use_exit_tb
Date: Fri, 25 Sep 2026 11:38:44 +0200
Message-ID: <20260925093844.5685-9-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925093844.5685-1-deller@kernel.org>
References: <20260925093844.5685-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Rely on cpu_exec_step_atomic setting CF_NO_GOTO_TB and
CF_NO_GOTO_PTR, which will cause exit_tb to be used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/sh4/translate.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index c15c0802f7..5729a757f1 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -221,20 +221,8 @@ static inline void gen_save_cpu_state(DisasContext *ctx, bool save_pc)
     }
 }
 
-static inline bool use_exit_tb(DisasContext *ctx)
-{
-#ifdef CONFIG_USER_ONLY
-    return ctx->in_gusa_exclusive;
-#else
-    return false;
-#endif
-}
-
 static bool use_goto_tb(DisasContext *ctx, vaddr dest)
 {
-    if (use_exit_tb(ctx)) {
-        return false;
-    }
     return translator_use_goto_tb(&ctx->base, dest);
 }
 
@@ -246,11 +234,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, vaddr dest)
         tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
-        if (use_exit_tb(ctx)) {
-            tcg_gen_exit_tb(NULL, 0);
-        } else {
-            tcg_gen_lookup_and_goto_ptr();
-        }
+        tcg_gen_lookup_and_goto_ptr();
     }
     ctx->base.is_jmp = DISAS_NORETURN;
 }
@@ -262,11 +246,7 @@ static void gen_jump(DisasContext * ctx)
            delayed jump as immediate jump are conditinal jumps */
         tcg_gen_mov_i32(cpu_pc, cpu_delayed_pc);
         tcg_gen_discard_i32(cpu_delayed_pc);
-        if (use_exit_tb(ctx)) {
-            tcg_gen_exit_tb(NULL, 0);
-        } else {
-            tcg_gen_lookup_and_goto_ptr();
-        }
+        tcg_gen_lookup_and_goto_ptr();
         ctx->base.is_jmp = DISAS_NORETURN;
     } else {
         gen_goto_tb(ctx, 0, ctx->delayed_pc);
-- 
2.54.0


