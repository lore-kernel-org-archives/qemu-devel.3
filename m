Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF008CA5FA4
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB3tm-00029E-Of; Mon, 28 Sep 2026 01:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3qb-0007O3-Er
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:24:24 -0400
Received: from mail-dl2-x28.google.com ([2607:f8b0:4864:38::28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3qU-0008EH-Mq
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:24:15 -0400
Received: by mail-dl2-x28.google.com with SMTP id
 a92af1059eb24-14373bcc010so2202442c88.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 22:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790573049; x=1791177849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+S0nIKhoE6QFG2efccnzPtAKgBQbydSBBSG3m5haZ4Q=;
 b=GatGQdh0mPNmX/8WUB7euUTxzxG5GcEkSS1HUoD9io76r0VZlNDaULaCHNZEpyww50
 /Bggv9nE0uEB0yQ7NG3W61iv263+DIhtr1ui+ndI0znFtPgAwxjbGbktsVAYCgaX0S5n
 NNCfxlU6KgMS5lLdwkFlVeeL4zDwTHdIipPHJCK9RWUMmTA7Wg2+dXVXqNv1j4jrg7Ss
 w6VIIRWaRIuIVjB2ZV0vwGHqCsI+n6oysoXOjW/IQss0wSDvK5GjGebIybeXn4RUOzUE
 m/ZCFsheqENjiHwGYZvGr+rEPPP7zr4hIknjSvboQVOUcVAPOoRT3xlZO7Mg2c80e0/l
 Qq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790573049; x=1791177849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+S0nIKhoE6QFG2efccnzPtAKgBQbydSBBSG3m5haZ4Q=;
 b=v9kfnhn3ih+uzAWEhcIPbWMxJw7O2nKLU1pTU4tHpmFUlicerX3T7GMpdDb+hyGIM+
 eZazlov2LK0P7foLL7XD9aHMFgWwO85Gz70Lvr1cvkfFFRACSlJ3ZeBl9xeHnP9RlOst
 mbw8O9SFkzXEoCa5ln0TnKcWhwBUoW0dxyHenRZeB9mI/n1VWjX/YKSRLR837oS82ZxF
 Avs6hxJ5qte6gF/shD71Vfhun9Sqh7pt6nAbhDaX9iDizZsf5OU/1g3lQPpXaNc9gJ5D
 XNVeG7MAUovr2fOjb/VtReweZNuAMveBNmrrzkbU+VgQ/RH/8Hddwscj8uUqO+2ojVa+
 1aUQ==
X-Gm-Message-State: AFuF++l+/dRDKZvS71jaSflVa/V/YrmOYU9W6zhjsMY8RxkwMbqJhE7S
 Mg3U2N7BH+tbqJu7dV4U+L/GqIVlx8p5ZMKdpnjNcs0gMmtIy6inbcCrmBQtNVypdFM=
X-Gm-Gg: AYBFou2LfSwKkgmb1U9X7RRaD2CCzlyc6TBPWyNYY7+uN5Fn67Yl+qwkjT6JRQxtnq2
 01I9gzpUBhtPuvVvTdRBcADftHL98FL96T8aWb3FtIemvHC8Stt2/3pKu3Qf26I7CI9jsVKxjP3
 IG0Q2ceJ9H/PTZHPke3TMAcsHdaq55Co1UWvVZ8HoKxWkJqywmn+OrxqPKbbv+4gxeXEh7PNnTu
 VZzZ4RL2KrhRIWE9iVk47uSzC08FjZPu+Fhz7UEHlv3q1eE6glbArrVIJ/yDPBt9pSfGk8bVrtI
 le6gbhPDQuThYCtWiCHY5QzKyDrSM8CWdbKrLNaSSxvNU1BAwe+kj7/UPpoacy1LlLvXgys4t2Z
 M7GoHhIgf8hUrvDJrPpUbwT62/5tlNZSEG2Dg3cL9aid/+brGObQmnHNOHU1jUQg5VpBu0LhWG7
 zKcYBk+esuXx4mQmJAOnMj+p5RtZnH9pZveYHTrXAuitpqR5eS9HmkTqWSNnSNHDozpGTD8GZmV
 ITx8Lel026dRQULxr40rP5cxsjAVds=
X-Received: by 2002:a05:701b:21c5:b0:145:5c4:6500 with SMTP id
 a92af1059eb24-146ce1a9f0fmr9296737c88.1.1790573048970; 
 Sun, 27 Sep 2026 22:24:08 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-146bb6551d9sm14726248c88.9.2026.09.27.22.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:24:08 -0700 (PDT)
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
Subject: [PATCH v2 24/24] target/ppc: convert raise_exception to raise_excp
Date: Mon, 28 Sep 2026 13:20:50 +0800
Message-ID: <20260928052051.251-25-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260928052051.251-1-luoyonggang@gmail.com>
References: <20260928052051.251-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::28;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x28.google.com
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

Store error_code, then call raise_excp. Drop TCG raise_exception
and raise_exception_err. Move C raise_exception_err_ra to static
inline in internal.h, and remove the cpu.h prototype. Callers
include internal.h.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/ppc/cpu.h             |  3 ---
 target/ppc/helper.h          |  2 --
 target/ppc/internal.h        |  9 +++++++++
 target/ppc/misc_helper.c     |  1 +
 target/ppc/tcg-excp_helper.c | 21 ---------------------
 target/ppc/timebase_helper.c |  1 +
 target/ppc/translate.c       | 13 ++++++-------
 7 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3fb51bbeb82..217b4f334e5 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2819,9 +2819,6 @@ void cpu_write_xer(CPUPPCState *env, target_ulong xer);
  */
 #define is_book3s_arch2x(ctx) (!!((ctx)->insns_flags & PPC_SEGMENT_64B))
 
-G_NORETURN void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
-                                       uint32_t error_code, uintptr_t raddr);
-
 /* PERFM EBB helper*/
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
 void raise_ebb_perfm_exception(CPUPPCState *env);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 80d6616bab4..8a804d326ac 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -1,5 +1,3 @@
-DEF_HELPER_FLAGS_3(raise_exception_err, TCG_CALL_NO_WG, noreturn, env, i32, i32)
-DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
 DEF_HELPER_FLAGS_4(TW, TCG_CALL_NO_WG, void, env, tl, tl, i32)
 #if defined(TARGET_PPC64)
 DEF_HELPER_FLAGS_4(TD, TCG_CALL_NO_WG, void, env, tl, tl, i32)
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index a20a0f9f7e0..14c08c23ffc 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -320,8 +320,17 @@ static inline int ger_pack_masks(int pmsk, int ymsk, int xmsk)
 
 #ifdef CONFIG_TCG
 #include "accel/tcg/tb-cpu-state.h"
+#include "accel/tcg/cpu-loop.h"
 
 TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs);
+
+static inline G_NORETURN
+void raise_exception_err_ra(CPUPPCState *env, uint32_t excp,
+                            uint32_t err, uintptr_t ra)
+{
+    env->error_code = err;
+    cpu_loop_exit_excp(env_cpu(env), excp, ra);
+}
 #endif
 
 #endif /* PPC_INTERNAL_H */
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 0e625cbb704..527af513f92 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
+#include "internal.h"
 #include "exec/cputlb.h"
 #include "exec/helper-proto.h"
 #include "qemu/error-report.h"
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 93aedb0c8e2..6289ca7dfd5 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -34,27 +34,6 @@
 /*****************************************************************************/
 /* Exceptions processing helpers */
 
-void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
-                            uint32_t error_code, uintptr_t raddr)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = exception;
-    env->error_code = error_code;
-    cpu_loop_exit_restore(cs, raddr);
-}
-
-void helper_raise_exception_err(CPUPPCState *env, uint32_t exception,
-                                uint32_t error_code)
-{
-    raise_exception_err_ra(env, exception, error_code, 0);
-}
-
-void helper_raise_exception(CPUPPCState *env, uint32_t exception)
-{
-    raise_exception_err_ra(env, exception, 0, 0);
-}
-
 #ifndef CONFIG_USER_ONLY
 
 static G_NORETURN void raise_exception_err(CPUPPCState *env, uint32_t exception,
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 7209b418fb6..d0986ff261a 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internal.h"
 #include "hw/ppc/ppc.h"
 #include "exec/helper-proto.h"
 #include "qemu/log.h"
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index f1a7039a325..767b8ed7697 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -308,12 +308,10 @@ static inline void gen_update_nip(DisasContext *ctx, target_ulong nip)
 static void gen_exception_err_nip(DisasContext *ctx, uint32_t excp,
                                   uint32_t error, target_ulong nip)
 {
-    TCGv_i32 t0, t1;
-
     gen_update_nip(ctx, nip);
-    t0 = tcg_constant_i32(excp);
-    t1 = tcg_constant_i32(error);
-    gen_helper_raise_exception_err(tcg_env, t0, t1);
+    tcg_gen_st_i32(tcg_constant_i32(error), tcg_env,
+                   offsetof(CPUPPCState, error_code));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(excp));
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
@@ -372,8 +370,9 @@ static void gen_debug_exception(DisasContext *ctx, bool rfi_type)
         gen_load_spr(t0, SPR_BOOKE_DBSR);
         tcg_gen_ori_tl(t0, t0, dbsr);
         gen_store_spr(SPR_BOOKE_DBSR, t0);
-        gen_helper_raise_exception(tcg_env,
-                                   tcg_constant_i32(POWERPC_EXCP_DEBUG));
+        tcg_gen_st_i32(tcg_constant_i32(0), tcg_env,
+                       offsetof(CPUPPCState, error_code));
+        gen_helper_raise_excp(tcg_env, tcg_constant_i32(POWERPC_EXCP_DEBUG));
         ctx->base.is_jmp = DISAS_NORETURN;
     } else {
         if (!rfi_type) { /* BookS does not single step rfi type instructions */
-- 
2.52.0.windows.1


