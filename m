Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B98C982D6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7MiI-00085C-Pg; Thu, 17 Sep 2026 20:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mhk-0007jo-3J
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:43:54 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mhg-0001he-Eo
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:43:50 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-8633a38df87so128334b3a.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789692227; x=1790297027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qzd0M/4qp9vwSv2bB8bs53lJcrM5huaiJqNoXcaAAE4=;
 b=c1zwMNuxHfyrePQb1gjCcUtDb20saXrEVGssffmS6ZE87C4Hm+3kC79AyMKakp8s4R
 2WTNM4CY9P5bvVqNeUniFvB7loUC3PL6l0BcKjOlaehyLfiVtm+BzIvg8StscXFfTQbK
 gh+t69GNka7DOTQMZPWok2xiHEsch1fqGt9aYV7zG2LbmTMIh/Mah8dVGXCTA8YHZBsy
 cFzxx3gUnmo7aXzAkBWmtOmuzQLC2H6w+S8rTCXi3pCpaPrwH9YGzStmaBe2oFXoXJEj
 tCHqd+hy7fwxxU+f+OJmJxdxKA7YWNxgkXWLDQ9gnylwBKNoXrsTuLowCS0Qe+KyyTOe
 LrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789692227; x=1790297027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qzd0M/4qp9vwSv2bB8bs53lJcrM5huaiJqNoXcaAAE4=;
 b=hneOg/5tRYJNWZ6irYQMaYnVfbu8I66V3tZ3mbQPUzEHWLrHwziGnBMtMyc62DTr3Q
 rMPkj8u/DjKM0H2LKbhtMM2L4EbWTg3vCFBtJr92jLYiTNLplAylq9ECUbaD23NPelxG
 dwy3yNs845h14NrCWyGB3PjhHjyF+H8eSQd3b8jiQ5//sqJEgDE1mzIU/ikzyZWnxq8D
 Lx1K865zjczn7FoqtB2oL9WU31N1dVwK4tH3UbRPhxkfR+uMFmC6bynvuF7sAX3d+Utm
 CyeZShMdK5l/jlOZXW0q9W2n3tJt1NCVzbPSTr1txeOXsO8NG37T1Ls9LjInkr3GRSda
 urOg==
X-Gm-Message-State: AFuF++nfG8bCDq31gACj1mHzWu5pJSG9gIZaYrmnyeeEZfCF64TD8szg
 26fcmd/fVGrZwk7sdV8ysbiHbcEAL1e7FtApCFzXktpSEMVhjM86bw5kO644zOazmO0=
X-Gm-Gg: AYBFou3RD81lVA5ZA8O3ebqXnAUu+0YWQP0HtQLltKoroMcFBB3b5TKK530YkDcbIBc
 pHqB835SaaU04Qv4svdWpwur0jfxG0j/2GqBRPvCxJkJ39e3NgClOBNGlkmG7FJKGSOLB8rKUL0
 WzQak1ff8TnnTk/rkvftuwsGQfldRHE+OZnz8xcfXBywYlQv6ibN1QcF6hbcXCbk9TyEg45SckH
 4lwZptObCVSDTzJQf4fw6lIYXLPgTK6U3AzetrddCIdoIVrUs3VdJ3XKe4DfyJzc/u43iTdkhJS
 PF15Jfk4uD7XwyPQo7dujvN+/AzXKR/O100vpNot1UTkWAcFbA2ktgZvj1n9vjyhDkZd7cZASw8
 d3ts4GGt5qE4tzGlGI5I1T7ArWx7jKEKbI6ywIFe+okFJRWIG4dyDI5aVMthcaT0xkIWJhvUdJA
 yYD06dg6TViLRAGL3j6JZYZC9irRBKoWGsWUco0g40AvNhvmJ/eVm1VlKdtjS/+XkrceZwatlaw
 rOvQQUIYMA9X4pTclxTYjDdP7GG7F5j
X-Received: by 2002:a05:6a20:93a1:b0:3d3:adbf:7779 with SMTP id
 adf61e73a8af0-3dd8c49ed36mr1513962637.21.1789692227024; 
 Thu, 17 Sep 2026 17:43:47 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144cdfc3df2sm600286c88.5.2026.09.17.17.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:43:46 -0700 (PDT)
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
Subject: [PATCH 08/21] target/microblaze: convert raise_exception to raise_excp
Date: Fri, 18 Sep 2026 08:42:10 +0800
Message-ID: <20260918004225.827-9-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918004225.827-1-luoyonggang@gmail.com>
References: <20260918004225.827-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-pz2-x10.google.com
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

Translate through gen_helper_raise_excp with restore 0 after
syncing PC. Drop TCG raise_exception. Exit HW_EXCP and MMU through
cpu_loop_exit_excp.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/microblaze/helper.c    |  3 +--
 target/microblaze/helper.h    |  2 --
 target/microblaze/op_helper.c | 22 ++++------------------
 target/microblaze/translate.c |  3 ++-
 4 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 05a90f5ecb2..d092e916db4 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -146,8 +146,7 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 
     /* TLB miss.  */
-    cs->exception_index = EXCP_MMU;
-    cpu_loop_exit_restore(cs, retaddr);
+    cpu_loop_exit_excp(cs, EXCP_MMU, retaddr);
 }
 
 void mb_cpu_do_interrupt(CPUState *cs)
diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 1429c1727ef..ad9c22ed5b7 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -1,5 +1,3 @@
-DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
-
 DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
 
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 3da0c68da39..f3dc42d5bdd 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -62,25 +62,14 @@ uint32_t helper_get(uint32_t id, uint32_t ctrl)
     return 0xdead0000 | id;
 }
 
-void helper_raise_exception(CPUMBState *env, uint32_t index)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = index;
-    cpu_loop_exit(cs);
-}
-
 /* Raises ESR_EC_DIVZERO if exceptions are enabled.  */
 static void raise_divzero(CPUMBState *env, uint32_t esr, uintptr_t unwind_pc)
 {
     env->msr |= MSR_DZ;
 
     if ((env->msr & MSR_EE) && env_archcpu(env)->cfg.div_zero_exception) {
-        CPUState *cs = env_cpu(env);
-
         env->esr = esr;
-        cs->exception_index = EXCP_HW_EXCP;
-        cpu_loop_exit_restore(cs, unwind_pc);
+        cpu_loop_exit_excp(env_cpu(env), EXCP_HW_EXCP, unwind_pc);
     }
 }
 
@@ -123,8 +112,7 @@ static void raise_fpu_exception(CPUMBState *env, uintptr_t ra)
     CPUState *cs = env_cpu(env);
 
     env->esr = ESR_EC_FPU;
-    cs->exception_index = EXCP_HW_EXCP;
-    cpu_loop_exit_restore(cs, ra);
+    cpu_loop_exit_excp(cs, EXCP_HW_EXCP, ra);
 }
 
 static void update_fpu_flags(CPUMBState *env, int flags, uintptr_t ra)
@@ -390,8 +378,7 @@ void helper_stackprot(CPUMBState *env, uint32_t addr)
 
         env->ear = addr;
         env->esr = ESR_EC_STACKPROT;
-        cs->exception_index = EXCP_HW_EXCP;
-        cpu_loop_exit_restore(cs, GETPC());
+        cpu_loop_exit_excp(cs, EXCP_HW_EXCP, GETPC());
     }
 }
 
@@ -444,8 +431,7 @@ static void mb_transaction_failed_internal(CPUState *cs, hwaddr physaddr,
     if (take) {
         env->esr = esr;
         env->ear = addr;
-        cs->exception_index = EXCP_HW_EXCP;
-        cpu_loop_exit_restore(cs, retaddr);
+        cpu_loop_exit_excp(cs, EXCP_HW_EXCP, retaddr);
     }
 }
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8b219afb5dd..8893fa0d4fe 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -100,7 +100,8 @@ static void t_sync_flags(DisasContext *dc)
 
 static void gen_raise_exception(DisasContext *dc, uint32_t index)
 {
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(index));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(index),
+                          tcg_constant_i32(0));
     dc->base.is_jmp = DISAS_NORETURN;
 }
 
-- 
2.52.0.windows.1


