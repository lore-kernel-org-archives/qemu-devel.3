Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB77CC9831E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMRR-0004a2-6Z; Sat, 26 Sep 2026 03:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMR2-0003lz-5y
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:03:03 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMR0-0000Zz-F8
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:02:59 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-340fbf9c1c6so928476eec.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406177; x=1791010977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=awp3H7a2O80uyPRL2fhVcR6Bx9g9YW6vpgBv8R062bc=;
 b=FxwZOAbWXipUxV2X1xt6jXkNHuimGnt6IeuKRuqSoSRDsJf3IwbcQLgKgW6nwTqI+e
 YvuvYbbxmlPGjpK6qqq9hGhwL1Q1KA3apYv0zimwZE0gYz96DDsvRali+W5/8cwf5k1d
 fH60WPBmpa41Yaxz+eLBtRMiA1wdK/RBOpXJPFPuISxHsSfT6GA89YGpPNNMinm0ktl2
 s8YTVVroRaBO5W45oZdStLVEmjrytnw8CpOpiFeGXRH22Y0mWkY07D2soZuM6nibLyRm
 sAIw0q6w6dj3l4iJYdTthrrH39FII/qOOGyXRohhxfd1AP5zo+YH0HSAYlR7gQo1Y7Ij
 drlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406177; x=1791010977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=awp3H7a2O80uyPRL2fhVcR6Bx9g9YW6vpgBv8R062bc=;
 b=hu7gDejC+mLp8FUYz5N4Aaq1wa3znh97ZSwi+hLZCggDlNEK0Xhu4eSddoTrV4ELp9
 H017OtY1D/YbDm+tT7ASto/IlY3n2o3dojLXtnlq+uxNc3gdJUGaMZg6wIYqvcA26ZNL
 VB51qOSLmIlxdIvNjlUfofQhTgz0fLujnr6i+T2qXnSnpdH7UqFlHcQrzO3RF+82VNfR
 jxRxPxo9S4B+lN+DymvvayLfJXrdbupydncBPlnokQ45TPsX9o7qaYg2YGCI5lnabDrC
 6dny7LnqVE+Radakzf0SoF8WtheXMYwNdq7VXxzIs9ouUBBWCtzhMHKIPX7Y4aYqbMAO
 GrsQ==
X-Gm-Message-State: AFuF++nKVBE1IyQtN7JTBFbhdOKSpha94zl4sXj4q+UJMlj0TeBuJZTY
 GFqQmEgtILcSWmKxsp1dODhGr1Ov+zmrYlOD6gHzJzkIMLU4LGO7o2pjArZ0UWH9
X-Gm-Gg: AYBFou03WFCTc3CM57zEOf476S8jelz0Y44Yv9ebcE0G9P7qqFxJhw0QNj/ubT9Rllu
 FxIbzN2IxGOdkLipckXJ25uLOLxitWJqvDbtN0MBu5ERmzV2P0Z+CXGsAyqtwAFfWszrV2bdAYp
 yx6lx8AU+NILQ7E6yRunJZSieUTWeOcrjvQL+dwjWQtewnCu3gHlydCURv5r8zuSkV9ROl1Fcd1
 mxRxcTLXP6VbNjb3H4mQ4vMJR7YoibtNLWoJyQGW+rkBFBXNH7XxiYhZwxY0vS+wntwCnrEzxgA
 1qKMFjqXKKD0LrswfF2/vvqox/36sjK8t1BOSsKi3RefChEAk9KTJ035/6gQgSSe/4ovUMyFshF
 EFT37E80qvRPH3j8xVf3nH1ia3KzoE03PTEy31lnAjYW0mX98NbaEpURi6vgtP8nK/2PmQKNrNE
 xSw548kBfYnCLNk3+yBiBjfUnzqn+9RnBwzBBVIDnL/DUbp+azeL/TEdQ40MZ3ql0d86whTKvvz
 vu4joZoy5OVJKURGambltEQQ6/Rqug=
X-Received: by 2002:a05:7300:d10a:b0:33b:e1f2:fa10 with SMTP id
 5a478bee46e88-34271d8d2fbmr1860726eec.24.1790406176444; 
 Sat, 26 Sep 2026 00:02:56 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:02:54 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 28/55] tcg: move goto_tb helpers into tcg-op-ldst.c
Date: Sat, 26 Sep 2026 15:00:27 +0800
Message-ID: <20260926070057.1234-29-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

tcg_gen_goto_tb and tcg_gen_lookup_and_goto_ptr call plugin and
lookup_tb_ptr helpers. Define them in tcg-op-ldst.c. tcg_gen_op1i is
static in tcg-op.c, so the moved calls use tcg_gen_op1.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tcg/tcg-op-ldst.c | 31 +++++++++++++++++++++++++++++++
 tcg/tcg-op.c      | 32 --------------------------------
 2 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 22211ccb452..fb13c2f1523 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -1346,3 +1346,34 @@ GEN_ATOMIC_HELPER128(xchg, mov2, 0)
 
 #undef GEN_ATOMIC_HELPER
 #undef GEN_ATOMIC_HELPER128
+
+void tcg_gen_goto_tb(unsigned idx)
+{
+    /* We tested CF_NO_GOTO_TB in translator_use_goto_tb. */
+    tcg_debug_assert(!(tcg_ctx->gen_tb->cflags & CF_NO_GOTO_TB));
+    /* We only support two chained exits.  */
+    tcg_debug_assert(idx <= TB_EXIT_IDXMAX);
+#ifdef CONFIG_DEBUG_TCG
+    /* Verify that we haven't seen this numbered exit before.  */
+    tcg_debug_assert((tcg_ctx->goto_tb_issue_mask & (1 << idx)) == 0);
+    tcg_ctx->goto_tb_issue_mask |= 1 << idx;
+#endif
+    plugin_gen_disable_mem_helpers();
+    tcg_gen_op1(INDEX_op_goto_tb, 0, idx);
+}
+
+void tcg_gen_lookup_and_goto_ptr(void)
+{
+    TCGv_ptr ptr;
+
+    if (tcg_ctx->gen_tb->cflags & CF_NO_GOTO_PTR) {
+        tcg_gen_exit_tb(NULL, 0);
+        return;
+    }
+
+    plugin_gen_disable_mem_helpers();
+    ptr = tcg_temp_ebb_new_ptr();
+    gen_helper_lookup_tb_ptr(ptr, tcg_env);
+    tcg_gen_op1(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
+    tcg_temp_free_ptr(ptr);
+}
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2c88f4f7ca9..bd3bae37500 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -27,7 +27,6 @@
 #include "tcg/tcg-temp-internal.h"
 #include "tcg/tcg-op-common.h"
 #include "exec/translation-block.h"
-#include "exec/plugin-gen.h"
 #include "tcg-internal.h"
 #include "tcg-has.h"
 
@@ -2699,34 +2698,3 @@ void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx)
 
     tcg_gen_op1i(INDEX_op_exit_tb, 0, val);
 }
-
-void tcg_gen_goto_tb(unsigned idx)
-{
-    /* We tested CF_NO_GOTO_TB in translator_use_goto_tb. */
-    tcg_debug_assert(!(tcg_ctx->gen_tb->cflags & CF_NO_GOTO_TB));
-    /* We only support two chained exits.  */
-    tcg_debug_assert(idx <= TB_EXIT_IDXMAX);
-#ifdef CONFIG_DEBUG_TCG
-    /* Verify that we haven't seen this numbered exit before.  */
-    tcg_debug_assert((tcg_ctx->goto_tb_issue_mask & (1 << idx)) == 0);
-    tcg_ctx->goto_tb_issue_mask |= 1 << idx;
-#endif
-    plugin_gen_disable_mem_helpers();
-    tcg_gen_op1i(INDEX_op_goto_tb, 0, idx);
-}
-
-void tcg_gen_lookup_and_goto_ptr(void)
-{
-    TCGv_ptr ptr;
-
-    if (tcg_ctx->gen_tb->cflags & CF_NO_GOTO_PTR) {
-        tcg_gen_exit_tb(NULL, 0);
-        return;
-    }
-
-    plugin_gen_disable_mem_helpers();
-    ptr = tcg_temp_ebb_new_ptr();
-    gen_helper_lookup_tb_ptr(ptr, tcg_env);
-    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
-    tcg_temp_free_ptr(ptr);
-}
-- 
2.52.0.windows.1


