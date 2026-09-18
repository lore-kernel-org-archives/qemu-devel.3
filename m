Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55399C982D6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7MjN-0002lQ-Sn; Thu, 17 Sep 2026 20:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mj0-0002TZ-Eo
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:45:10 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mix-00027C-TL
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:45:09 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-398b1e63c49so1077796a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789692306; x=1790297106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uUxVakJCkBJyYyL65r7lWAG6HlYCiEtFRDKSQHbVWO4=;
 b=ZHChttBHmfdPpQC/H0dBePJuLknshbaK0jYP/Dl1JlNcI7KmAxyWloAYKXtwKXX09S
 u5Ut2bGQAP4yuPhrUpuvRh9CbOnN+2pO2cCRYYOr/zHzTbnmu8BkPeHr3bOhvHQ24SVU
 MxXKk2Z6ATVjZtrywUgmDLyWcZ+UhrX1YrcQxlZWEh05w4d9qBglwlMBJotT0unj0siM
 tuhXVK0f84zfkhcmnXnCajpKRg0AX4lv8SIdVNkiUQnVtPO1rLDZcRV0Ny3Q4YzfrVW6
 ZOi0BwURJcLviU2RXspOBj8tW4tFkg+P+SA2t4OuWRdCFZYANmFCoeuegZIDBEMkqcwk
 zqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789692306; x=1790297106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uUxVakJCkBJyYyL65r7lWAG6HlYCiEtFRDKSQHbVWO4=;
 b=ww5YzxvFCYVGTgZsR8uv/MZ7Bttv5khc8is6km8nNxtxCWoLRSLFKI+ARViyuRtYWJ
 VP9nCVWBu6VrBAd8G25gX/0uEKCHKs/N8ueyocYo1ZMISQnUKiDOKinPM3AqBQqiIkUu
 tf9riuBL2tpy9sU+/+qknAYsDqw/Yvozo3EAXOxtxJfwbiExENGXkI9tRVB1yrcoWX2i
 CyC+UtNWOaAJNSaV1scuG/T7TV5P6tGo1ywKe3w6Ch05jzg9JulrERGL5BY9M+fsQFT3
 FoU6DtgtnepcjD1f03XU1j7Dyq61KP8uyKS85k7VkSdzLoS3/GYSxHspisdK9SRk8QSY
 rwLg==
X-Gm-Message-State: AFuF++kYbT6jpmEfwOrmFapppGx08YMhgKxu3qgATl0RW1jPy9l0EFI3
 udKzZ7BaQF21jbVHFnFu+zKQt0G3zgBt3TMU8SS9WbTeQP0LBzOxLl4/wdJ3HIYwCRs=
X-Gm-Gg: AYBFou04+6G5JSxOwWpVTH5tm0HTqe75RhWZ4ZkAgzdxXkAxAr+ijmscSNnbt2YuKyj
 djbVMZuw1lpdfmOapaToUWGnIIuTFe7pmyMNwpnRCuTQl5ZNd4dpiBo/Wr7dcr+Y4Nx7q3pRYyP
 R8chsSqqDWQ2XuqcN9UsxQyYPDEuXU8ku5GMvQw6bI9GAz6+89ErIbnOMGbronJPi346wQ45qCR
 DPh5ixrPXA4ubTcG/DuVj3TsulajsH8PGea7V/a/Rb3AAHrRSDlS2PFDtyoR1V/qWOUHl7VH7jP
 Pv9G8OjHPexWTy1+30hzEZsA1jjQUsICDM6y3rj40kJKMVZMeP+8OakrjnzU1n1+BrIcWwe5/Df
 C4OKrfV6m62hSqX2deL6phtD+IPBBaN3Yjh1220SImZmN2EQRYnPyA7PKufDqWBmJDy+vR0FOGb
 T9O93fxFBB0LIB4mkkR9EMexm8Mr7Ffj2aPjXLTZWn4fptCu7Q1Hx6vJcnBDuuZuop68Ufi3PRd
 tA9k1xbo6eRmO23jj7fbaZLhkTQ4g9fBFLRrAd3kajo
X-Received: by 2002:a17:90b:1c84:b0:39e:4c97:ce09 with SMTP id
 98e67ed59e1d1-39e4c97cf02mr2389816a91.42.1789692306180; 
 Thu, 17 Sep 2026 17:45:06 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144cdfc3df2sm600286c88.5.2026.09.17.17.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:45:05 -0700 (PDT)
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
Subject: [PATCH 17/21] target/arm: convert exception_internal to raise_excp
Date: Fri, 18 Sep 2026 08:42:19 +0800
Message-ID: <20260918004225.827-18-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918004225.827-1-luoyonggang@gmail.com>
References: <20260918004225.827-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1032.google.com
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

Switch gen_exception_internal to gen_helper_raise_excp with
restore 0, and drop TCG exception_internal. Keep syndrome helpers.
Rename C raise_exception globals to arm_raise_exception*, and keep
the short names as static inline wrappers in internals.h. Fold
leftover C exits into cpu_loop_exit_excp. Keep
arm_raise_exception_ra via restore then arm_raise_exception.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/internals.h       | 27 ++++++++++++++++------
 target/arm/tcg-stubs.c       |  4 ++--
 target/arm/tcg/helper-defs.h |  1 -
 target/arm/tcg/m_helper.c    |  3 ++-
 target/arm/tcg/op_helper.c   | 43 +++++++++---------------------------
 target/arm/tcg/translate.c   |  2 +-
 6 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1775835ad50..ee8ee766327 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -333,20 +333,33 @@ FIELD(FPMR, LSCALE2, 32, 6)
 #define M_FAKE_FSR_SFAULT 0xe /* SecureFault INVTRAN, INVEP or AUVIOL */
 
 /**
- * raise_exception: Raise the specified exception.
+ * arm_raise_exception: Raise the specified exception.
  * Raise a guest exception with the specified value, syndrome register
  * and target exception level. This should be called from helper functions,
  * and never returns because we will longjump back up to the CPU main loop.
  */
-G_NORETURN void raise_exception(CPUARMState *env, uint32_t excp,
-                                uint64_t syndrome, uint32_t target_el);
-
+G_NORETURN void arm_raise_exception(CPUARMState *env, uint32_t excp,
+                                    uint64_t syndrome, uint32_t target_el);
 /*
  * Similarly, but also use unwinding to restore cpu state.
  */
-G_NORETURN void raise_exception_ra(CPUARMState *env, uint32_t excp,
-                                   uint64_t syndrome, uint32_t target_el,
-                                   uintptr_t ra);
+G_NORETURN void arm_raise_exception_ra(CPUARMState *env, uint32_t excp,
+                                       uint64_t syndrome, uint32_t target_el,
+                                       uintptr_t ra);
+
+static inline G_NORETURN
+void raise_exception(CPUARMState *env, uint32_t excp,
+                     uint64_t syndrome, uint32_t target_el)
+{
+    arm_raise_exception(env, excp, syndrome, target_el);
+}
+
+static inline G_NORETURN
+void raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
+                        uint32_t target_el, uintptr_t ra)
+{
+    arm_raise_exception_ra(env, excp, syndrome, target_el, ra);
+}
 
 /*
  * For AArch64, map a given EL to an index in the banked_spsr array.
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index aeeede80661..7f9f684ed70 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -16,8 +16,8 @@ void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
     g_assert_not_reached();
 }
 
-void raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
-                        uint32_t target_el, uintptr_t ra)
+void arm_raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
+                            uint32_t target_el, uintptr_t ra)
 {
     g_assert_not_reached();
 }
diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 269ac515065..14ef3120373 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -45,7 +45,6 @@ DEF_HELPER_FLAGS_2(usad8, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 
 DEF_HELPER_FLAGS_3(sel_flags, TCG_CALL_NO_RWG_SE,
                    i32, i32, i32, i32)
-DEF_HELPER_2(exception_internal, noreturn, env, i32)
 DEF_HELPER_3(exception_with_syndrome, noreturn, env, i32, i32)
 DEF_HELPER_4(exception_with_syndrome_el, noreturn, env, i32, i32, i32)
 DEF_HELPER_2(exception_bkpt_insn, noreturn, env, i32)
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 33c9e7c55bc..161c5460217 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -18,6 +18,7 @@
 #include "exec/page-protection.h"
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-loop.h"
 #include "semihosting/common-semi.h"
 #endif
 #if !defined(CONFIG_USER_ONLY)
@@ -575,7 +576,7 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
          */
         env->regs[15] = dest & ~1;
         env->thumb = dest & 1;
-        HELPER(exception_internal)(env, EXCP_EXCEPTION_EXIT);
+        cpu_loop_exit_excp(env_cpu(env), EXCP_EXCEPTION_EXIT, 0);
         /* notreached */
     }
 
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index c2b09176cb1..f1d1f52ccee 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -45,8 +45,8 @@ int exception_target_el(CPUARMState *env)
     return target_el;
 }
 
-void raise_exception(CPUARMState *env, uint32_t excp,
-                     uint64_t syndrome, uint32_t target_el)
+void arm_raise_exception(CPUARMState *env, uint32_t excp,
+                         uint64_t syndrome, uint32_t target_el)
 {
     CPUState *cs = env_cpu(env);
 
@@ -64,14 +64,13 @@ void raise_exception(CPUARMState *env, uint32_t excp,
     }
 
     assert(!excp_is_internal(excp));
-    cs->exception_index = excp;
     env->exception.syndrome = syndrome;
     env->exception.target_el = target_el;
-    cpu_loop_exit(cs);
+    cpu_loop_exit_excp(cs, excp, 0);
 }
 
-void raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
-                        uint32_t target_el, uintptr_t ra)
+void arm_raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
+                            uint32_t target_el, uintptr_t ra)
 {
     CPUState *cs = env_cpu(env);
 
@@ -81,7 +80,7 @@ void raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
      * the caller passed us, and cannot use cpu_loop_exit_restore().
      */
     cpu_restore_state(cs, ra);
-    raise_exception(env, excp, syndrome, target_el);
+    arm_raise_exception(env, excp, syndrome, target_el);
 }
 
 uint64_t HELPER(neon_tbl)(CPUARMState *env, uint32_t desc,
@@ -399,9 +398,8 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
     }
 
     env->halt_reason = HALT_WFI;
-    cs->exception_index = EXCP_HLT;
     cs->halted = 1;
-    cpu_loop_exit(cs);
+    cpu_loop_exit_excp(cs, EXCP_HLT, 0);
 #endif
 }
 
@@ -461,9 +459,8 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
         timer_mod(cpu->wfxt_timer, nexttick);
     }
     env->halt_reason = HALT_WFI;
-    cs->exception_index = EXCP_HLT;
     cs->halted = 1;
-    cpu_loop_exit(cs);
+    cpu_loop_exit_excp(cs, EXCP_HLT, 0);
 #endif
 }
 
@@ -630,9 +627,8 @@ void HELPER(wfe)(CPUARMState *env, uint32_t insn_len)
     }
 
     env->halt_reason = HALT_WFE;
-    cs->exception_index = EXCP_HLT;
     cs->halted = 1;
-    cpu_loop_exit(cs);
+    cpu_loop_exit_excp(cs, EXCP_HLT, 0);
 #endif
 }
 
@@ -724,9 +720,8 @@ void HELPER(wfet)(CPUARMState *env, uint32_t rd)
     }
 
     env->halt_reason = HALT_WFE;
-    cs->exception_index = EXCP_HLT;
     cs->halted = 1;
-    cpu_loop_exit(cs);
+    cpu_loop_exit_excp(cs, EXCP_HLT, 0);
 #endif
 }
 
@@ -738,23 +733,7 @@ void HELPER(yield)(CPUARMState *env)
      * that the guest is currently busy-looping. Yield control back to the
      * top level loop so that a more deserving VCPU has a chance to run.
      */
-    cs->exception_index = EXCP_YIELD;
-    cpu_loop_exit(cs);
-}
-
-/* Raise an internal-to-QEMU exception. This is limited to only
- * those EXCP values which are special cases for QEMU to interrupt
- * execution and not to be used for exceptions which are passed to
- * the guest (those must all have syndrome information and thus should
- * use exception_with_syndrome*).
- */
-void HELPER(exception_internal)(CPUARMState *env, uint32_t excp)
-{
-    CPUState *cs = env_cpu(env);
-
-    assert(excp_is_internal(excp));
-    cs->exception_index = excp;
-    cpu_loop_exit(cs);
+    cpu_loop_exit_excp(cs, EXCP_YIELD, 0);
 }
 
 /* Raise an exception with the specified syndrome register value */
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 8c56348a665..bc1dc101ff3 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -379,7 +379,7 @@ static void gen_rebuild_hflags(DisasContext *s, bool new_el)
 void gen_exception_internal(int excp)
 {
     assert(excp_is_internal(excp));
-    gen_helper_exception_internal(tcg_env, tcg_constant_i32(excp));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(excp), tcg_constant_i32(0));
 }
 
 static void gen_singlestep_exception(DisasContext *s)
-- 
2.52.0.windows.1


