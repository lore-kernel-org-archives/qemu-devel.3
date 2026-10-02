Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A10CA5FE0
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 18:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChWz-0004qg-L0; Fri, 02 Oct 2026 13:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChSf-0006Oz-HT
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:54:32 -0400
Received: from mail-dl2-x10.google.com ([2607:f8b0:4864:38::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChSc-0007t9-5q
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:54:21 -0400
Received: by mail-dl2-x10.google.com with SMTP id
 a92af1059eb24-142dd04f7f6so224334c88.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963657; x=1791568457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ppUhyKk2KJwdv1lKi3ysuIQtsrve0MU7LeCIa3mu2kU=;
 b=HAG9RBX08/NLbbDt0Y/xXuGpV0bpCZuVBRwzHhhEgmmmyYBT8RDMYHCuQ2efX8tCtC
 m01VoarBnfHWdWAhIobdnG/uh7hUAsDInSBh7IcztvT6HsXoQ+320vRV+vjRMORDEWZ4
 dSxN53soOFb/0BeuFqB0rwoRd3erqwtGexD7cTHlnWPVUOZ6vB9OTnbfnYYYfcZPtaRA
 4NNgx8zMK4KD5z6RYYvDe+pFbiBW1xEdh/95modsmCCDmZ5ywdnRCI0SU3H4he5Le4dq
 KzxkIDJBVbutyvuZubv8ccAzmGFd5/YtoB2zKvYnxVeq5t85wC70SzcCY28ryIEX5Vf7
 Uh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963657; x=1791568457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ppUhyKk2KJwdv1lKi3ysuIQtsrve0MU7LeCIa3mu2kU=;
 b=tE6hVWe3azBqbGJrElDItT1Duk1CCzV0LSEHaBGsUTGVmgF/m1d/QZIUNj2FIghvW+
 goLbS7ZGnkwczw4YBsx5SlpBbLlNSCMeH9DqkJM04OYG5UZBV4H9Rj4bTXNHmE26FAcH
 I4rmPRYjk6+GZlIkGKQN5z3LCMTlP1gsftRj/SfURxal/GZw5Tj9GNQx10kiUZgmKmGr
 x0ypWQ1ErQM0ukx2wDLYfS5xwtrew9YmnsWreAYx0yMFFVzNLQbpU3byf4oH3VFiDHdR
 MBTgr+vhPdBcmvD2YbOPPa5Ob71Pg5f1F5GEnqCXScWbkiiCbLfjVR0hXtqpHcXjSUWn
 xFQw==
X-Gm-Message-State: AFuF++kuJTeRMP+YkezH1snyZXVaYrrfvOPlH7AZiCHtIyh0lFUrn+/Z
 ayI5K8j7Alc4q/WDx4XeFGF8i7WcMN2DQmOCtTmSSE71mlcljza3PYwTTvkX77HNlPg=
X-Gm-Gg: AYBFou0fwBNRHPgReTPNffXcylZHWnslVGLh4FE06XwNft+LurYfXLgGbgDu9JDI4ix
 +gC4p02iGwyzHuE93dmUVtBu0Tz9/KN1yy9VtWJqwFc51inc55gZrvBRqx/zPlP0IXE13KBMnvC
 NdE7xPB+18K5d4cC0V76SsPUSNGQgV/DYwlLjYMchxNAmXrL7pdnTNBq645pYjVtU8WzE8Rwazo
 fKm1qQtaMvxHe/EJFYfBmd9CKobf2CtZAT4izufv93jjhAGGPwe3xjI7/AgWodhDzjEmyMjxhrZ
 jiX8KwKkBnpGEOdDS0qs2Dmu80jMbUoFICfYlxhPIYc3EU3b15OYAmvm50v9HIz9wytydw2fZlY
 ttafcWwHVXb1B+R0hRHjiZar/2f1COfJAcSz/cVg+s0sxWZWhJozynTW9LvqnAftMSXBuUS7z+0
 E/yaz8d20trI4LJpxyMZuIpFOpcFYdy4kP/rqvJL+kzS0ocqFVk31wX5VbPjTyWwhXCqWQoLlXT
 4ObGC0djz1ZYc0jOEidVzloUpXyDLk=
X-Received: by 2002:a05:7022:3b88:b0:144:ddf7:2570 with SMTP id
 a92af1059eb24-14f5cec202amr4422608c88.39.1790963656699; 
 Fri, 02 Oct 2026 10:54:16 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34f14f9f2afsm18027361eec.18.2026.10.02.10.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:54:16 -0700 (PDT)
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
Subject: [PATCH v3 27/27] target/ppc: use shared helpers for translated
 exceptions
Date: Sat,  3 Oct 2026 01:50:35 +0800
Message-ID: <20261002175037.1747-28-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261002175037.1747-1-luoyonggang@gmail.com>
References: <20261002175037.1747-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x10.google.com
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

Store error_code before gen_helper_raise_excp() and define
raise_exception_err_ra() inline in internal.h to preserve PPC error-code
handling while using cpu_raise_excp_restore(). Remove the obsolete TCG
exception helpers.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/ppc/cpu.h             |  5 +----
 target/ppc/helper.h          |  2 --
 target/ppc/internal.h        |  9 +++++++++
 target/ppc/misc_helper.c     |  1 +
 target/ppc/tcg-excp_helper.c | 21 ---------------------
 target/ppc/timebase_helper.c |  1 +
 target/ppc/translate.c       | 13 ++++++-------
 7 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3fb51bbeb82..f1b1cf94331 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1392,7 +1392,7 @@ struct CPUArchState {
     uint64_t insns_flags;
     uint64_t insns_flags2;
 
-    int error_code;
+    int32_t error_code;
     uint32_t pending_interrupts;
 #if !defined(CONFIG_USER_ONLY)
     uint64_t excp_stats[POWERPC_EXCP_NB];
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
index a20a0f9f7e0..66e017be74b 100644
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
+    cpu_raise_excp_restore(env_cpu(env), excp, ra);
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


