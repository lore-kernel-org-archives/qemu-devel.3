Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD397C98332
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 11:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAQH1-000846-Pq; Sat, 26 Sep 2026 07:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAQGu-00082v-Lz
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 07:08:50 -0400
Received: from mail-dl2-x0f.google.com ([2607:f8b0:4864:38::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAQGt-0002kf-2v
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 07:08:48 -0400
Received: by mail-dl2-x0f.google.com with SMTP id
 a92af1059eb24-1460bcc512eso791141c88.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 04:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790420926; x=1791025726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=guuk/GU2+6svkxqusCAEMJJEdeLkWutsxCBXdBcfQM0=;
 b=KbzpJANR2X4BdWMVG0sJeiF8+TfaXtbJZ2ETcfziNfVV8i2Bu99jTfJoLUtSefrrmt
 0pRq3lONT4WI3g79kofEUZecc4fg1JUxRLNg+h3AeLSo5OhU60qIpc6oJPx0U4pT5AHz
 qcUiRqNgCr9wZWNa3aVAtlOUftEtDG9UA+TRjEhqPbQHsGsZ4+pk3xnN6qthlPO1RQ87
 j1n9C7ix+TLfwLqGzuE10CD6NqrzVjTBEvdwwwXxRH6uXQzXAPgz62it5baMVFepqVJD
 kzRbeLFBHBaWdhj6FdFXs9GxgSzA5/ytfUwIgHenlzsK0wCnMuD1gQnarzL1tPEuy3Az
 Actg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790420926; x=1791025726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=guuk/GU2+6svkxqusCAEMJJEdeLkWutsxCBXdBcfQM0=;
 b=THULtvGlHWtGIAGQfMaJpzRAQMr/g1O/BOr0JCDKdRTu0PUJ9FgToUp9+K4ZUYbIwN
 aFpONOyp9Y+qa4NewQof/CSGv2mRASszC0vZg0YT7qxk+8zzatTlQDi1903IX/43aDLR
 u9RqYvdsexLT+UpttEr4yLP+zyqv2R38BVBNKvbpML8+BCa4fXO/gF8eNIbaUSn3O3Ck
 EBkXgJyL+5eMQBgq6W+JRf/0DW9EKqk0uGCoPi34dMqmI4wp1OSkwlZcTPmdKPJYeOr/
 vUPupgLiph96AM3Q4xzxJ6pnP6oAToqDnRXGZ6Z0U8caFAlnOmZqjwe6bdAKnQH+IR13
 q1jQ==
X-Gm-Message-State: AFuF++nEx9HVBj+Q1GAJYN+KBUq87Ew51MBNOty1rrIfcfgUg+FA2KZM
 Ha8r9FecKYecwv/us2NJtFCX+FuUHvlTubI7xLQSP6LrvxH4S6Cbpwnynlhj8QZe+TA=
X-Gm-Gg: AYBFou2VyoFC0padlO1nQVkDIhZyDajbP9DmSQUFa96UXcWPTdWB6x90zQ45QUtkJbX
 TeQZnKAk9eRXGx2hEqDs4wirNMDKJPkOSlKSkmbjHjWku3Vxhm6uJ5Zo/HXx8SU4CCXnPTixyxM
 ml3nHwy+MUn3s43ESL5EeBNhbm21ZnrWJK3azILT+q8Dzf+A6F/be/KzYl/gQTkXnwD7kstlSGn
 f8bleu6OzmTMlgIvbmux0FpU/35DFEK4a7h+f8OWiYOrDqTgzBHO4F1cNrHCjvcLxZA7eUszYLw
 WrQbFffpi4JzPHw3xX+o0FKodVf/6bbnCDiXJgzVsXPtkRy/cYBnDXnVGBEGxbabWemMAq7TMBi
 VOc9IicXhiRzoQhaoeE4gcFiuh9N5dkVuvPwU4dbU9wO4nZ8dMZo+lT221wkfZLoOZH7p/jHFAE
 22RuHQoSmUWpUzAXZhu6Ic2BOahkCV82OIuw0Hj1/tCra9mSxJeQC7xFmAZNXWpyNQQT6Fwk5X5
 CeDtDzW+0Ukauhuk0kxAv49z42xAKQ=
X-Received: by 2002:a05:701b:4343:b0:143:26ed:2dd4 with SMTP id
 a92af1059eb24-146cfcd91c7mr2281470c88.30.1790420925630; 
 Sat, 26 Sep 2026 04:08:45 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-145a7318afcsm11414045c88.0.2026.09.26.04.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 04:08:44 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Song Gao <17746591750@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>, Ani Sinha <anisinha@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chao Liu <chao.liu@processmission.com>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 3/9] target/hexagon: rename helper_wait to helper_hexagon_wait
Date: Sat, 26 Sep 2026 19:08:11 +0800
Message-ID: <20260926110818.1912-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926110818.1912-1-luoyonggang@gmail.com>
References: <20260926110818.1912-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0f.google.com
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

helper_wait is a global C symbol. Prefix it and take the resume PC
as vaddr.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/hexagon/gen_tcg_sys.h | 2 +-
 target/hexagon/helper.h      | 2 +-
 target/hexagon/op_helper.c   | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index af5032214c4..489d2780470 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -80,7 +80,7 @@
 #define fGEN_TCG_Y2_wait(SHORTCODE) \
     do { \
         RsV = RsV; \
-        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt.pc)); \
+        gen_helper_hexagon_wait(tcg_env, tcg_constant_vaddr(ctx->pkt.pc)); \
     } while (0)
 
 #define fGEN_TCG_Y2_resume(SHORTCODE) \
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 71c8da4c46d..030ed6dcef5 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -136,7 +136,7 @@ DEF_HELPER_3(sreg_write_masked, void, env, i32, i32)
 DEF_HELPER_3(setprio, void, env, i32, i32)
 DEF_HELPER_2(start, void, env, i32)
 DEF_HELPER_1(stop, void, env)
-DEF_HELPER_2(wait, void, env, i32)
+DEF_HELPER_2(hexagon_wait, void, env, vaddr)
 DEF_HELPER_2(resume, void, env, i32)
 DEF_HELPER_1(resched, void, env)
 DEF_HELPER_3(modify_ssr, void, env, i32, i32)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 4f00ca773f3..7f026292ce8 100644
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
+void HELPER(hexagon_wait)(CPUHexagonState *env, vaddr pc)
 {
     BQL_LOCK_GUARD();
 
     if (!fIN_DEBUG_MODE(env->threadId)) {
-        hexagon_wait_thread(env, PC);
+        hexagon_wait_thread(env, pc);
     }
 }
 
-- 
2.52.0.windows.1


