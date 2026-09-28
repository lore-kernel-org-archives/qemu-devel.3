Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF43FC98328
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB3qF-0006cQ-1A; Mon, 28 Sep 2026 01:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3pI-0004dp-J2
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:22:59 -0400
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3pF-00080o-Pk
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:22:56 -0400
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-13fc403e373so3619153c88.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 22:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790572972; x=1791177772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jpkLTvTgBgGnWurAPOow78Me06rebiMfwPT2zkt0F0A=;
 b=JLvSY6tCoLsc54aCegAqWDzdlH8bSpMMEiS6AyMY7hJZgWpik+fAP1cawYYnoII+VN
 9PeicaeqShJf3WXcuqQ1mqIVY6Pk39Vuo9T2NDqA2H8HQEo4DoFKVZfD7c4MGI3nIyaK
 gUS99RcJ4PVYJTrggI3T33RjZCdjOymJJ4wsyCd06Y4z2lMuQooPX3NcM4n7UziwPYW+
 h+jmzuhW2NqetSPf6SMoMmmQb+KkVTrliddrj0mOA5ymV2bYXrm+2vS2adWtylZPzZjG
 xZWpAW/prD6LTqQr28AbHCcu//qhlZOBdrvaerSFWy8ZIBI2FN9Kx9qIbRIjAv55hMPD
 GDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790572972; x=1791177772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jpkLTvTgBgGnWurAPOow78Me06rebiMfwPT2zkt0F0A=;
 b=kn8Cih8eoQNukiSACsbgr/4UGf0nXtugk3ZrwB5oCxLu7u0WEu9d9rBD01UB3CM+Gn
 WIXIFo9yEOou0cAnVT5WaTIkc8t5lLajw4vfOtMnMyd6C0CST7HDt/snz5EVAR8686cL
 iwLRYkbEwRUZr6CI4H3/9ewuJTIWP9MVjSw8SZlbWdNKWKmyvNBHa+FgdnrU8WthiChK
 vZTQ3AkYf9qFGs7LHkv0HDjh4Xb+cTL3CF+EMmlTKAahN0K6TiHxVyyvrhdxMbSpF8S+
 mnYOv3if3jQTZorplV6+lKmqBcCrVErbt4NqecwJdDgYa403NFjU2iHbmM3K6y0Jo514
 +XbA==
X-Gm-Message-State: AFuF++laKz27hwz2BzbZ1aNU9mDykqvStJlBfzVnwwkmmBfI1GgmbeyR
 nfMvRpUFeo1FogXYLz2fgMTIZTttr/FucGqYi67Qg5ZA79rwsCCiISpLoRrvWFHyk1M=
X-Gm-Gg: AYBFou1bDdx6lPUO3rNjuM+Oscb7UKk8dCJzsuV1FBMSRPMKksJujlWKSLp2aJEOeqI
 MJnINJuMWQgRbdE2rCkglIx2GJrl32YZCcYb2Rs51ff3+2/vhw3ga5unV86TNsQ75LW44ZlJDPX
 3LHxCwN6yb1z2b3uC9z9+DdlAERGxkAcnHQlJ+/zFzZtrrcprQEY7P4RwkXvHrvb/YOtoVvzRIn
 cHEVYAuZzU3wCnge4WLlMgfU0rq/eoepbay74msT5f7J4aqamNr9n7Cj2jEihOCzwdVrxhpYWCl
 5Oc65ZXh6iS9baJFwZ0Okdx4Wa3VRR1Ck5qHl5dtOfwvurw1a+M4Oh7tczSG/RcKbEx1SvQzP+K
 pNaks65kNpmb49Yxbop2YM7lIICVfrGKUgrcCOmJjC2Zlw9w8ZwrisM0I2seZYtNmHcuG82+pGv
 AXwzY6jf5DtMgOlVIuLML0vbhuCf3j9BPpXRRL4ok3jaCgvlQBFJT1UiwfafObvhuvqxIbwR6H7
 rzt3abu9CE4/voHNJDIu0C5i75BNQc=
X-Received: by 2002:a05:7022:504:b0:143:1bb1:3300 with SMTP id
 a92af1059eb24-146d02a9edbmr12364539c88.17.1790572972013; 
 Sun, 27 Sep 2026 22:22:52 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-146bb6551d9sm14726248c88.9.2026.09.27.22.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:22:51 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Chao Liu <chao.liu@processmission.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, Glenn Miles <milesg@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Song Gao <17746591750@163.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org
Subject: [PATCH v2 14/24] target/hppa: convert excp to raise_excp
Date: Mon, 28 Sep 2026 13:20:40 +0800
Message-ID: <20260928052051.251-15-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260928052051.251-1-luoyonggang@gmail.com>
References: <20260928052051.251-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Drop TCG excp and call raise_excp. Keep C hppa_dynamic_excp and use
cpu_loop_exit_excp. Route leftover C callers through
hppa_dynamic_excp instead of helper_excp.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/hppa/helper.h     |  2 --
 target/hppa/op_helper.c  | 15 ++-------------
 target/hppa/sys_helper.c |  4 ++--
 target/hppa/translate.c  |  2 +-
 4 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 8369855d78e..5ed39e01e31 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -1,5 +1,3 @@
-DEF_HELPER_2(excp, noreturn, env, int)
-
 DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tl)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 76a8d8a0d34..c4651f0d85a 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -30,20 +30,9 @@
 #include "user/page-protection.h"
 #endif
 
-G_NORETURN void HELPER(excp)(CPUHPPAState *env, int excp)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = excp;
-    cpu_loop_exit(cs);
-}
-
 G_NORETURN void hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra)
 {
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = excp;
-    cpu_loop_exit_restore(cs, ra);
+    cpu_loop_exit_excp(env_cpu(env), excp, ra);
 }
 
 static void atomic_store_mask32(CPUHPPAState *env, target_ulong addr,
@@ -341,7 +330,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
         if (excp == EXCP_DTLB_MISS) {
             excp = EXCP_NA_DTLB_MISS;
         }
-        helper_excp(env, excp);
+        hppa_dynamic_excp(env, excp, 0);
     }
     return (want & prot) != 0;
 #endif
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index 88109f0181a..dd3be1bfc90 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -51,13 +51,13 @@ void HELPER(write_interval_timer)(CPUHPPAState *env, target_ulong val)
 void HELPER(halt)(CPUHPPAState *env)
 {
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-    helper_excp(env, EXCP_HLT);
+    hppa_dynamic_excp(env, EXCP_HLT, 0);
 }
 
 void HELPER(reset)(CPUHPPAState *env)
 {
     qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    helper_excp(env, EXCP_HLT);
+    hppa_dynamic_excp(env, EXCP_HLT, 0);
 }
 
 target_ulong HELPER(swap_system_mask)(CPUHPPAState *env, target_ulong nsm)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 41300c0dd73..35766e6ee06 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -726,7 +726,7 @@ static void install_link(DisasContext *ctx, unsigned link, bool with_sr0)
 
 static void gen_excp_1(int exception)
 {
-    gen_helper_excp(tcg_env, tcg_constant_i32(exception));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(exception));
 }
 
 static void gen_excp(DisasContext *ctx, int exception)
-- 
2.52.0.windows.1


