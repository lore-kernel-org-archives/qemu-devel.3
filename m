Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED606C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB3tX-0001Iy-FK; Mon, 28 Sep 2026 01:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3pn-0005IP-MZ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:23:29 -0400
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3pk-00086h-92
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:23:27 -0400
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-3428f70d7e7so1367865eec.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 22:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790573003; x=1791177803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TNgf6mzQru6X+FsQqbFclqifhFUVJmTnFVxLl9vYDCg=;
 b=gFukZtxy4CH/DikcjcJiyof1Eh4++SwyhHaoCfbQfdxgZK/Ab/k4qp7bmKPVGaUbdE
 NZaS+9U2TVhmH7odhy0RmA56JwpTCcRrvsBsKTgEmYslshtXrImrNl8hd1UC0pOROs1z
 r3nJedjvVQeY5PEQtcDaAgOx5m4KXr/dYKoOi7nAwY2kMpI677393hT/EocTT93xf5EP
 2jbitzGFkDijX66cZTY0eK/rZXPGc/x7C81Td0cupWETNuURcCo+5LhrVNYBxqb3prA8
 QZgFrBqELzxzhghnuX7Nky4WVntzeq8q+3neaPrCVjwuaOFCoiTzrEOcFixDJOUIZ9pO
 hJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790573003; x=1791177803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TNgf6mzQru6X+FsQqbFclqifhFUVJmTnFVxLl9vYDCg=;
 b=YazcrM/YryBWMHPlyRpdPR2bWcLUr4WXV9YBAs4q4cE29vz+AuOTicvZqp8+CHkKXb
 A08PLyiD0ctLvFPwiKfi4QbRuxjrxIgE5GfAi0OmygswsX7UkxK+dZD71ZkmoGo15rGD
 5m/cYvyOicQuEZM+OyIckPVqe/nH7UoIC1c9lm069rY+M6AZvfc7NIjXsWRY2fy8fzaO
 ABCLPa2dYuDBjBui66Dq4iKLyFfJ0KItzf2mt8stY+MlR2+vE+5mUwqpMPLWSeZ/ysaq
 K2nkCKzKTSdX3uYKkj0Ae+zBNattiSi/Fga2UyWDAa705nlCANR97Nl6cR9Z3VNEfNsV
 v0DA==
X-Gm-Message-State: AFuF++nZScqN/WSlFUyKL4daUCfSFpSjUlOQOfd89D4QWmqPYcHNzCAA
 sGJJqzdd8HMtRLYFK6WoOXbp5QjWsNZpVFCitqwkHBRl3e9Pv/uZ25bAQ8QAXhobvvI=
X-Gm-Gg: AYBFou0bBsh1T3Prv4cJSmpdamLZZ/2bdGQqOP/TgoczkLzB4OE2WIgfjE1SugtFSfA
 gsJAQDKgQcWS8f18omaIazTt1iJL6NJ9ybk6KTheKlO5+/KxMsJE+Vmvd11eoyv0cvAXvqy08lD
 2Vog0FSBUnkUOFmlIRnbkSBP/I7E8kRKVrqY2v93fzELNnf9DNV1JIafRbU4oZ7F/9MHFDY0wUq
 qvMo5u/p394PyG0VxZXCv9tlFXmZMuMVDmJunOkDzDNJEaN6Xya6auRntM7mrTsFHRsxot4QIJu
 AQAmHYOoZ3pNGrGVp6EHsUnZRrfv2zMG7p46xd4kJgOUFhTl7qn7EL6hHhymJpPhyovengK7YBg
 vSOokCki2VLjpxdHfqbDBC/bxpfAde1qW8S26EAoay3b4lsdGUGa1d/T5EZwxn0o+o3mBFXCUGh
 n/WUx8z1SH1QylhZWGnAhAW7dX5BE/bFzlNfxQG/HUV4ZTcQE8/sIkmHYwI78DNXusnJ8ytPS0E
 3Pk7ozvXBj50tN8uLsEixooX6rPyDE=
X-Received: by 2002:a05:7022:7e85:b0:143:3242:6301 with SMTP id
 a92af1059eb24-146ce29fde5mr9588471c88.4.1790573002756; 
 Sun, 27 Sep 2026 22:23:22 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-146bb6551d9sm14726248c88.9.2026.09.27.22.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:23:22 -0700 (PDT)
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
Subject: [PATCH v2 18/24] target/xtensa: convert exception to raise_excp
Date: Mon, 28 Sep 2026 13:20:44 +0800
Message-ID: <20260928052051.251-19-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260928052051.251-1-luoyonggang@gmail.com>
References: <20260928052051.251-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0e.google.com
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

Call raise_excp from gen_yield. Drop TCG exception. Keep
exception_cause helpers. C callers use xtensa_exception for the old
helper_exception body.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/xtensa/cpu.h        |  1 +
 target/xtensa/exc_helper.c | 13 +++++--------
 target/xtensa/helper.h     |  1 -
 target/xtensa/translate.c  |  2 +-
 target/xtensa/win_helper.c | 12 ++++++------
 5 files changed, 13 insertions(+), 16 deletions(-)

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
index db48f0c562a..05c73bef99d 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -307,7 +307,7 @@ static void gen_yield(DisasContext *dc)
 {
     tcg_gen_st_i32(tcg_constant_i32(0), tcg_env,
                    offsetof(CPUXtensaState, yield_needed));
-    gen_helper_exception(tcg_env, tcg_constant_i32(EXCP_YIELD));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(EXCP_YIELD));
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


