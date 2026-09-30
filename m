Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC70CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoca-0000Pi-Gb; Wed, 30 Sep 2026 03:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBocQ-0000Of-1F
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:20:46 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBocO-0001PL-5N
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:20:45 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-33c11ef641aso5311091eec.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790752841; x=1791357641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TRatLaPQvOk/I+602pw0urCGh8xtaMsBOH7rQwhjs10=;
 b=DUx4Jce3ivymJK3g6Mjj/hQ4bdr+IAiRmQIzpSu6MpRGHwkRdfvjWC3wPUB8WS1hE3
 lsQaJ5lTo2DsyNhM+zAGjmul9FN3CZPjzl4OxfY7c9sABzmTG/CuN3Xx/TcC88/cWrLH
 NDGlcdv4ShiMgBPaosN9mfvbJ4NdRGYtmyDiiLGje2XpufeJAmsgMcMtOdWrjI5ieFC3
 /sJTeLeyvs2mJUxmB3+EN4MtUEQy7qsYklTkK+/35YCsFbTItis0uCdl7CxsCMSukMPY
 ziz1YxaIN7FetLKVslxi/ZrKs8FbLUqOOFn6+nqjAXmp7GM7VqEPO8iySk8ybY5zVjaF
 INcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790752841; x=1791357641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TRatLaPQvOk/I+602pw0urCGh8xtaMsBOH7rQwhjs10=;
 b=g3snB0k5tDWzEoL/z3ZutR0J2e1CzE8u2xeQ/wqF/HI5HGrFz1eX0WbKnuagvarNl8
 iteXF06xdrfgtyPw7lCDYJ6NMYHihqqIc21MbSIzC6MwVVQreA6l794cdCV26Bp6tmet
 SwC/+ocJGq6O9rJ8E22jSzttXnOt5hZ3VVYxOXNlIr3/kjSZWMzGucFGNlOzoN8jkA+D
 ThlL7MesfBGN+t1obl0P9k6F0fGTC25HID+jl6yDY3szpJzQeV5VPzH3+a74/XDVE7bN
 EYLXQawM3E9hXpk/ir+dKN0prGR9tQdmneY2XqY9wVMJ6XGUh4PhklBasdX2vrM9lQHJ
 t6bg==
X-Gm-Message-State: AFq9FYI/KmKqE/diHZbjx59IgU3vLQKzxIxnZ+ni/ZMRPB23rzbfpBZV
 aYiDBqBV/RBKv8194v9MgIlWlieUpmxEaoteqm/czcfdancpPkBiESLbCPmCiJ+v
X-Gm-Gg: AYBFou0V0jmf5QbYueW+N8jCSaBcTi++cLERU+qMovnEj3hTlvb9XOILgnXlNAbqu0W
 ngJD483f5RE43IouTL4ykhiGuQ2XGjtoJwgw8lioIK9RUGmWimF4ZGMt+ex8Oou9UCmCyD4ZHpY
 8MyYUTubbOxTSTkmbWKqcsTH5ds+ek+/P4XSJljvxZwW493jaxGWdJLV1+h59+hvCr8IEGIwEoM
 7SQRT+97+swVuf08cyuYpaK93OlG81vGpolFg4jBDX0a1eEOEg6jmwn8s2rzd+Wn8xjn4wjy/Gn
 9HK2Y6qSQRJfYNsTrBdn3ghCna1ll+0Z0iTzg6qJQ6KFXFxVKhSj/9Lj+xbw94NM7Fv6wzafLtv
 3BIPI038iM5UUhU5fAwWx+POwmCdNAGVu+pkXeTM+Bx6QhCeTXJ3etbl6BNQA2oqmWgroY2Bood
 xhP4UqSLanSJRy1gWrEdjKJN3hJr5k7XSo2N0invpre5sq7iETjLPZJji+1lfX/0UNVPs4gmqe3
 B682vuU+aeawCre2/5nZ30RZ+t2
X-Received: by 2002:a05:693c:6385:20b0:346:7c2c:1d19 with SMTP id
 5a478bee46e88-34cdb8e5521mr941521eec.16.1790752841042; 
 Wed, 30 Sep 2026 00:20:41 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34cf5e423fasm1947517eec.26.2026.09.30.00.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:20:40 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] target/hexagon: use vaddr for wait PC
Date: Wed, 30 Sep 2026 15:20:33 +0800
Message-ID: <20260930072033.603-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
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

Pass the wait-instruction resume PC as vaddr through the helper
interface and implementation.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/hexagon/gen_tcg_sys.h | 2 +-
 target/hexagon/helper.h      | 2 +-
 target/hexagon/op_helper.c   | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index af5032214c..de66b85b49 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -80,7 +80,7 @@
 #define fGEN_TCG_Y2_wait(SHORTCODE) \
     do { \
         RsV = RsV; \
-        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt.pc)); \
+        gen_helper_wait(tcg_env, tcg_constant_vaddr(ctx->pkt.pc)); \
     } while (0)
 
 #define fGEN_TCG_Y2_resume(SHORTCODE) \
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 71c8da4c46..18cff7f4d2 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -136,7 +136,7 @@ DEF_HELPER_3(sreg_write_masked, void, env, i32, i32)
 DEF_HELPER_3(setprio, void, env, i32, i32)
 DEF_HELPER_2(start, void, env, i32)
 DEF_HELPER_1(stop, void, env)
-DEF_HELPER_2(wait, void, env, i32)
+DEF_HELPER_2(wait, void, env, vaddr)
 DEF_HELPER_2(resume, void, env, i32)
 DEF_HELPER_1(resched, void, env)
 DEF_HELPER_3(modify_ssr, void, env, i32, i32)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 4f00ca773f..0785f1a127 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1741,7 +1741,7 @@ static void set_wait_mode(CPUHexagonState *env)
     SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_W, thread_wait_mask);
 }
 
-static void hexagon_wait_thread(CPUHexagonState *env, uint32_t PC)
+static void hexagon_wait_thread(CPUHexagonState *env, vaddr pc)
 {
     CPUState *cs;
 
@@ -1768,7 +1768,7 @@ static void hexagon_wait_thread(CPUHexagonState *env, uint32_t PC)
         return;
     }
     set_wait_mode(env);
-    env->wait_next_pc = PC + 4;
+    env->wait_next_pc = pc + 4;
 
     cpu_interrupt(cs, CPU_INTERRUPT_HALT);
 }
@@ -1836,12 +1836,12 @@ void HELPER(resched)(CPUHexagonState *env)
     resched(env);
 }
 
-void HELPER(wait)(CPUHexagonState *env, uint32_t PC)
+void HELPER(wait)(CPUHexagonState *env, vaddr pc)
 {
     BQL_LOCK_GUARD();
 
     if (!fIN_DEBUG_MODE(env->threadId)) {
-        hexagon_wait_thread(env, PC);
+        hexagon_wait_thread(env, pc);
     }
 }
 
-- 
2.55.0.windows.3


