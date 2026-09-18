Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20F0C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Min-00017m-BW; Thu, 17 Sep 2026 20:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mii-0000m1-4T
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:44:52 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mie-0001s5-SV
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:44:51 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cea4c79fso41286a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789692287; x=1790297087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EiZRDF3MvqH/zyAQIwrejC3deTg3BSLMstyg6mUml+k=;
 b=VbyHG7Hw8wQVGcTcamhWLUnulZGSeRfozFbvFSxPShAaojZQrGPxiZWEX5Ohc9shYA
 o6alFQ2h8HHUDqHhC2wsY9LLeLYdG8pjPQXknhrH3FMstdQxC4QdCHgelU4SKffS7kJx
 0LFBVhws4nDHmnNe8DJlGW3ofBqv6eTDrqvy+GChVZmO3Q+lI222aebL42gyMHPHitFf
 wFECt0wKI3CDGSyXnvIY59Wr9nvqXbPDawTcxOwlIOJxDqwUzO1U1IiucvHaiFC+xhPI
 bPhGIbllcryj7eEhzwRyUidOOFLrAheQJTHyGsTiZujYfcspjIetioliDLa9bTaimKeE
 DS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789692287; x=1790297087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EiZRDF3MvqH/zyAQIwrejC3deTg3BSLMstyg6mUml+k=;
 b=G2VuE1Nqs3w+Si0ol0dZp4KDTpf99hY+vDMC+XA2jd5ml+FMlwiA8fnZB5tG4KzFUG
 ZH7ABB83QI3LDOyhTEWBvzCKnklxNBBZSJ8/Utt8uqC+drRX48+0Rl0LQm57lbPqPAHJ
 HsH31BRDLW5KMNGmQQoiIJ0UPHxFeKlMvhR+EpzKOUfzwRNujOqUFKyrGNY0BTs+ukqs
 lOYE3e/jh8CXYULeVjjwm9wyxDg4a1LTZURMA0X6UumHFqEhuqwMc3ibHdiUttXxAk67
 84axX8z0m+5o4mFVppkTSg7AMuywmfuv4uJzCyg+WIOtbBO8RRZhJ2+V59QzTTVAfVgm
 J0qA==
X-Gm-Message-State: AFuF++mo1N7AN1IcxZ5yEt0co7UmS6SBfQ70AF1oWrxeCnukiiB9hGWM
 tLvg1exyQF6O9tOIgOZlr5SHYbBnu9ZcN08mIzmi041cdVXU2hms1zpeGhjXZ1Ii
X-Gm-Gg: AYBFou0OW0l37i+w0fpQXfCdPtg10d2uMrrw2xwHbpWniB49aQfc6rPTp1i1AyIMRDs
 nQnvrIt7XdcjnLUls99zafhG+5uJBuP0nfH+qMEx9i6oMvQAqKEJSa5Sefh4yMTWmzb0VNS2VHP
 yFEnu8jQ5lK0DiIhL51KLXOmG/BRE7ArXCmK29WxN8ZQfGMVla2FTZLN612bC+4jUv1fCqsUCxs
 o7o0bAR8ZEEVcMs6+M9xlolvmSpZhTHDDxMCWCtf+qxyN1SC1N0WuqC75134Gw5MZPDLTOJcl2i
 PYooo2xGMCJiOAuo5Os6FqMiZI3I3QbePQ1G+5M+/Eng9psV1S7MbI2d/uZryHCmNmWPj+zArZq
 3IjUEGj3BFKygPDy9HmMXQNamTf/PDg4YiojxIW8B3hzbbvuQVvd/4+IDNZ4ygfkCC+JJ/mU3Gv
 UMD950kez5sF7AlfRlbxX9crzIW30RuhX3vMkFkR3P+WMu0UMie5JbOlaJqjpph8s5P1GKctqNN
 +0jI41ZQaE+Q52/yu3S8sSpSUb4A+1Z
X-Received: by 2002:a05:6a21:8cc8:b0:3d1:60d3:99f8 with SMTP id
 adf61e73a8af0-3dd8c3fbc65mr1606408637.5.1789692287471; 
 Thu, 17 Sep 2026 17:44:47 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144cdfc3df2sm600286c88.5.2026.09.17.17.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:44:46 -0700 (PDT)
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
Subject: [PATCH 15/21] target/xtensa: convert exception to raise_excp
Date: Fri, 18 Sep 2026 08:42:17 +0800
Message-ID: <20260918004225.827-16-luoyonggang@gmail.com>
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

Store yield_needed = 0 when raising YIELD, then call
gen_helper_raise_excp with restore 0. Drop TCG exception. Keep
exception_cause helpers. C callers use xtensa_exception for the
old helper_exception body.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/xtensa/cpu.h        |  1 +
 target/xtensa/exc_helper.c | 13 +++++--------
 target/xtensa/helper.h     |  1 -
 target/xtensa/translate.c  |  7 ++++++-
 target/xtensa/win_helper.c | 12 ++++++------
 5 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 49d6ad9083d..0b2cb5a250d 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -601,6 +601,7 @@ int xtensa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 G_NORETURN void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                                MMUAccessType access_type, int mmu_idx,
                                                uintptr_t retaddr);
+G_NORETURN void xtensa_exception(CPUXtensaState *env, uint32_t excp);
 
 #define CPU_RESOLVING_TYPE TYPE_XTENSA_CPU
 
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 7cb67d179a8..3049432f4c4 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -35,15 +35,12 @@
 #include "qemu/atomic.h"
 #include "qemu/plugin.h"
 
-void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
+void xtensa_exception(CPUXtensaState *env, uint32_t excp)
 {
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = excp;
     if (excp == EXCP_YIELD) {
         env->yield_needed = 0;
     }
-    cpu_loop_exit(cs);
+    cpu_loop_exit_excp(env_cpu(env), excp, 0);
 }
 
 void HELPER(exception_cause)(CPUXtensaState *env, uint32_t pc, uint32_t cause)
@@ -66,7 +63,7 @@ void HELPER(exception_cause)(CPUXtensaState *env, uint32_t pc, uint32_t cause)
     env->sregs[EXCCAUSE] = cause;
     env->sregs[PS] |= PS_EXCM;
 
-    HELPER(exception)(env, vector);
+    xtensa_exception(env, vector);
 }
 
 void HELPER(exception_cause_vaddr)(CPUXtensaState *env,
@@ -93,7 +90,7 @@ void HELPER(debug_exception)(CPUXtensaState *env, uint32_t pc, uint32_t cause)
     env->sregs[EPS2 + level - 2] = env->sregs[PS];
     env->sregs[PS] = (env->sregs[PS] & ~PS_INTLEVEL) | PS_EXCM |
         (level << PS_INTLEVEL_SHIFT);
-    HELPER(exception)(env, EXC_DEBUG);
+    xtensa_exception(env, EXC_DEBUG);
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -116,7 +113,7 @@ void HELPER(waiti)(CPUXtensaState *env, uint32_t pc, uint32_t intlevel)
     }
 
     cpu->halted = 1;
-    HELPER(exception)(env, EXCP_HLT);
+    xtensa_exception(env, EXCP_HLT);
 }
 
 void HELPER(check_interrupts)(CPUXtensaState *env)
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index ae938ceedb8..4640d0da59a 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -1,4 +1,3 @@
-DEF_HELPER_2(exception, noreturn, env, i32)
 DEF_HELPER_3(exception_cause, noreturn, env, i32, i32)
 DEF_HELPER_4(exception_cause_vaddr, noreturn, env, i32, i32, i32)
 DEF_HELPER_3(debug_exception, noreturn, env, i32, i32)
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 175fd4b5cfc..58fbe8496aa 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -305,7 +305,12 @@ static void gen_left_shift_sar(DisasContext *dc, TCGv_i32 sa)
 
 static void gen_exception(DisasContext *dc, int excp)
 {
-    gen_helper_exception(tcg_env, tcg_constant_i32(excp));
+    if (excp == EXCP_YIELD) {
+        tcg_gen_st_i32(tcg_constant_i32(0), tcg_env,
+                       offsetof(CPUXtensaState, yield_needed));
+    }
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(excp),
+                         tcg_constant_i32(0));
 }
 
 static void gen_exception_cause(DisasContext *dc, uint32_t cause)
diff --git a/target/xtensa/win_helper.c b/target/xtensa/win_helper.c
index 4b25f8f4de7..3e4d7c0f768 100644
--- a/target/xtensa/win_helper.c
+++ b/target/xtensa/win_helper.c
@@ -125,13 +125,13 @@ void HELPER(window_check)(CPUXtensaState *env, uint32_t pc, uint32_t w)
 
     switch (ctz32(windowstart >> n)) {
     case 0:
-        HELPER(exception)(env, EXC_WINDOW_OVERFLOW4);
+        xtensa_exception(env, EXC_WINDOW_OVERFLOW4);
         break;
     case 1:
-        HELPER(exception)(env, EXC_WINDOW_OVERFLOW8);
+        xtensa_exception(env, EXC_WINDOW_OVERFLOW8);
         break;
     default:
-        HELPER(exception)(env, EXC_WINDOW_OVERFLOW12);
+        xtensa_exception(env, EXC_WINDOW_OVERFLOW12);
         break;
     }
 }
@@ -174,11 +174,11 @@ void HELPER(test_underflow_retw)(CPUXtensaState *env, uint32_t pc)
         env->sregs[EPC1] = env->pc = pc;
 
         if (n == 1) {
-            HELPER(exception)(env, EXC_WINDOW_UNDERFLOW4);
+            xtensa_exception(env, EXC_WINDOW_UNDERFLOW4);
         } else if (n == 2) {
-            HELPER(exception)(env, EXC_WINDOW_UNDERFLOW8);
+            xtensa_exception(env, EXC_WINDOW_UNDERFLOW8);
         } else if (n == 3) {
-            HELPER(exception)(env, EXC_WINDOW_UNDERFLOW12);
+            xtensa_exception(env, EXC_WINDOW_UNDERFLOW12);
         }
     }
 }
-- 
2.52.0.windows.1


