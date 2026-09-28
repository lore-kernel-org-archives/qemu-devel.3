Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E840AC9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB3qI-0006sj-0q; Mon, 28 Sep 2026 01:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3pB-0004TR-Sv
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:22:51 -0400
Received: from mail-dl2-x0e.google.com ([2607:f8b0:4864:38::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3p8-0007zj-6q
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:22:49 -0400
Received: by mail-dl2-x0e.google.com with SMTP id
 a92af1059eb24-144efd1ea76so1368930c88.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 22:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790572964; x=1791177764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ids5FxiCP1WVUY4p2e0+a3JG0y7cRkgnrvmrK4lA6nA=;
 b=dPBn48TPPmgbvA6/XmvyWooHWLaCTiRBU/RYiNLA6pmbI48GfPN84sDEyXizAcxr52
 aYrVqtv0yJTtUaI+s9ld4QckAlIGU/C9X2NfPK/OjnEQwhGmGOQ630vGas6udjQvEVeg
 EGUxf2DlUH9GxeAE1KWjc3yfdd+kIupB7avuzfN7W8CFJxbr9rMc2brOR8ZfgjM/fwYh
 Im03k282qx79CNBZsluVj07Re0GBvbdnQErh3nZhBuyN6Nthdnz+H/iS+7N2Tn2Y0nXt
 Byrrcza52Bk6R/ICSouCJq/afYdQglnT+/1XQ3Sx8aPWTXNijIduBY57xvGBpYhomWre
 aZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790572964; x=1791177764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ids5FxiCP1WVUY4p2e0+a3JG0y7cRkgnrvmrK4lA6nA=;
 b=axDuG3oFbnAy8tPrcw3kauD99nLm0yL/l5c7fsPpX4isod/iL/549tb6mUTtb3AuWT
 rwspSBSr0SP2LY8eBICK4zixepBN7clIgfBOXQk8gf2IjwmI669J9XVbu758wLb9xCI7
 kXmEI3FG5wvoRWKtdfipgjZxsZLwZ1eRt0ep+44MIpy9I6lIelv7NLuqf1KIUI5ySlto
 lIM8EYyBPyWhDevT1rmKelKOPAw+8igmmPLO1mKcW9yuYQ89I+xBs7R4ANOSdwlIYz2y
 j9lmT12hc2feuH3wFkXMzLYhs94nVYjWjizUxoc5eiJcnrZHyx1oW9DQgN4VYP2d7H1W
 /sOA==
X-Gm-Message-State: AFuF++l5vFpa9Te+go6d00exSTaZewZq25zvW6ev6vRao6HaCDB7RSVB
 utqWctnBW4kxWTnl+4m8xfyZdz7ZxaNdHv7fYiWLZcMbBdTospESSgzfz1aG7ncqPks=
X-Gm-Gg: AYBFou1oCiWZMmx4emiF3LpWkkh+WDdaTgqN2QDhaag9Lcf5UD5UPsgANvAiyJqbUM1
 RRDAwSw6m1E+iprKUAEaCg6tYkqV07rY6RIyHWWFCz/AjdmXCReRPJUPUqghMEIW9NxgAWOQqzX
 zcFXGWR5RNpDhkAgL77P5izh7NVHF7Oeq8xhmJ4VNFpDepVJ7Voc5PhkVGK+PWd5ijua840mG3o
 mfNqqSDP5VUluDew/83Ew26tnaadhWodNdjbN7Ivr0UeF/yX4VwmDZzcSGh6tzVWmwIjFLEn6tb
 z3GhdKyBrhuyoUy5NKSkNK+5f8l4Wa9btVmhQIKtv0QD4iaZ/cQKaDB1iiiYBo6v6MfRR+IIHli
 vhaifXhqTceBSCutlf9ApcbEwiG5kjeOyw8UxcXyc6gPoDsqoADyvLvlqiVAcDq3oMAE3N1/S9J
 SGJ7uW5XEkJz4E3u7ak4aNSijGsVDOJE6rMdYqrbtUkej1qg/CiSrPosY8Q8VNv4Z4J2eCfUHmQ
 97jrEFEs6Rzg/tKenzXMCIpDFAeY4A=
X-Received: by 2002:a05:7022:f902:10b0:144:eab0:9cbc with SMTP id
 a92af1059eb24-146d0495644mr8711535c88.37.1790572964367; 
 Sun, 27 Sep 2026 22:22:44 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-146bb6551d9sm14726248c88.9.2026.09.27.22.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:22:43 -0700 (PDT)
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
Subject: [PATCH v2 13/24] target/hexagon: convert raise_exception to
 hexagon_raise_exception
Date: Mon, 28 Sep 2026 13:20:39 +0800
Message-ID: <20260928052051.251-14-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260928052051.251-1-luoyonggang@gmail.com>
References: <20260928052051.251-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0e.google.com
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

Fold C do_raise_exception into hexagon_raise_exception_err with
vaddr pc and a retaddr parameter, and exit via cpu_loop_exit_excp.
Prefix leftover TCG raise_exception to hexagon_raise_exception so
translate keeps the CPU_LOG_INT log and ASSERT_DIRECT_TO_GUEST_UNSET.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/hexagon/cpu.c       | 13 +++++++------
 target/hexagon/cpu.h       |  2 +-
 target/hexagon/helper.h    |  3 ++-
 target/hexagon/internal.h  |  5 -----
 target/hexagon/macros.h    |  2 +-
 target/hexagon/op_helper.c | 29 +++++++++++------------------
 target/hexagon/translate.c | 11 ++++++-----
 7 files changed, 28 insertions(+), 37 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 1f7d8a8df70..3739f3f4561 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -342,7 +342,7 @@ static TCGTBCPUState hexagon_get_tb_cpu_state(CPUState *cs)
     }
     if (pc & PCALIGN_MASK) {
         env->cause_code = HEX_CAUSE_PC_NOT_ALIGNED;
-        hexagon_raise_exception_err(env, HEX_EVENT_PRECISE, pc);
+        hexagon_raise_exception_err(env, HEX_EVENT_PRECISE, pc, 0);
     }
 
 #ifndef CONFIG_USER_ONLY
@@ -734,14 +734,15 @@ static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
             return false;
         }
         raise_perm_exception(cs, address, slot, access_type, excp);
-        do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC],
-                           retaddr);
+        hexagon_raise_exception_err(env, cs->exception_index,
+                                    env->gpr[HEX_REG_PC], retaddr);
     }
     if (probe) {
         return false;
     }
     raise_tlbmiss_exception(cs, address, slot, access_type);
-    do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC], retaddr);
+    hexagon_raise_exception_err(env, cs->exception_index,
+                                env->gpr[HEX_REG_PC], retaddr);
 }
 
 #include "hw/core/sysemu-cpu-ops.h"
@@ -784,8 +785,8 @@ void hexagon_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     CPUHexagonState *env = cpu_env(cs);
 
     raise_misaligned_exception(cs, addr, 0, access_type);
-    do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC],
-                       retaddr);
+    hexagon_raise_exception_err(env, cs->exception_index,
+                                env->gpr[HEX_REG_PC], retaddr);
 }
 
 #endif
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index df4c0182247..1edcc3ef6c3 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -232,7 +232,7 @@ FIELD(TB_FLAGS, HVX_COPROC_ENABLED, 5, 1)
 
 G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
                                             uint32_t exception,
-                                            uintptr_t pc);
+                                            vaddr pc, uintptr_t retaddr);
 
 #ifndef CONFIG_USER_ONLY
 /*
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 71c8da4c46d..6cd63f631b7 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -18,7 +18,8 @@
 #include "internal.h"
 #include "helper_protos_generated.h.inc"
 
-DEF_HELPER_FLAGS_3(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
+DEF_HELPER_FLAGS_3(hexagon_raise_exception, TCG_CALL_NO_RETURN, noreturn,
+                   env, i32, vaddr)
 DEF_HELPER_2(commit_store, void, env, int)
 DEF_HELPER_3(gather_store, void, env, i32, int)
 DEF_HELPER_1(commit_hvx_stores, void, env)
diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 05d1129916e..4b7a784fbc7 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -36,11 +36,6 @@ extern const char * const hexagon_sregnames[];
 extern const char * const hexagon_gregnames[];
 #endif
 
-void G_NORETURN do_raise_exception(CPUHexagonState *env,
-        uint32_t exception,
-        uint32_t PC,
-        uintptr_t retaddr);
-
 #define hexagon_cpu_mmu_enabled(env) ({ \
     HexagonCPU *cpu = env_archcpu(env); \
     cpu->globalregs ? \
diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index a5b9c24c6bb..4a87f6d72f1 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -637,7 +637,7 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
 #ifdef CONFIG_USER_ONLY
 #define fTRAP(TRAPTYPE, IMM) \
     do { \
-        hexagon_raise_exception_err(env, HEX_EVENT_TRAP0, PC); \
+        hexagon_raise_exception_err(env, HEX_EVENT_TRAP0, PC, 0); \
     } while (0)
 #endif
 
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 4f00ca773f3..dfdb597f3fc 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -72,31 +72,24 @@ uint64_t HELPER(utimer)(void)
 #define SF_MANTBITS    23
 
 /* Exceptions processing helpers */
-G_NORETURN
-void do_raise_exception(CPUHexagonState *env, uint32_t exception,
-                        uint32_t PC, uintptr_t retaddr)
+G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
+                                            uint32_t exception,
+                                            vaddr pc, uintptr_t retaddr)
 {
     CPUState *cs = env_cpu(env);
-    qemu_log_mask(CPU_LOG_INT, "%s: 0x%08" PRIx32 ", @ %08" PRIx32 "\n",
-                  __func__, exception, PC);
+    qemu_log_mask(CPU_LOG_INT, "%s: 0x%08" PRIx32 ", @ %08" VADDR_PRIx "\n",
+                  __func__, exception, pc);
     ASSERT_DIRECT_TO_GUEST_UNSET(env, exception);
 
-    env->gpr[HEX_REG_PC] = PC;
-    cs->exception_index = exception;
-    cpu_loop_exit_restore(cs, retaddr);
-}
-
-G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
-                                            uint32_t exception,
-                                            uintptr_t pc)
-{
-    do_raise_exception(env, exception, pc, 0);
+    env->gpr[HEX_REG_PC] = pc;
+    cpu_loop_exit_excp(cs, exception, retaddr);
 }
 
-G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp,
-                                        uint32_t PC)
+G_NORETURN void HELPER(hexagon_raise_exception)(CPUHexagonState *env,
+                                                uint32_t exception,
+                                                vaddr pc)
 {
-    hexagon_raise_exception_err(env, excp, PC);
+    hexagon_raise_exception_err(env, exception, pc, 0);
 }
 
 void log_store32(CPUHexagonState *env, target_ulong addr,
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 827859e052c..3bef721d7d8 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -138,11 +138,12 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
     return offset;
 }
 
-static void gen_precise_exception(int cause, uint32_t PC)
+static void gen_precise_exception(int cause, vaddr pc)
 {
     tcg_gen_movi_i32(hex_cause_code, cause);
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
-                               tcg_constant_i32(PC));
+    gen_helper_hexagon_raise_exception(tcg_env,
+                                       tcg_constant_i32(HEX_EVENT_PRECISE),
+                                       tcg_constant_vaddr(pc));
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -1139,11 +1140,11 @@ static void update_exec_counters(DisasContext *ctx)
  */
 static void check_imprecise_exception(DisasContext *ctx)
 {
-    TCGv PC = tcg_constant_tl(ctx->pkt.pc);
     TCGLabel *label = gen_new_label();
 
     tcg_gen_brcondi_tl(TCG_COND_EQ, hex_imprecise_exception, 0, label);
-    gen_helper_raise_exception(tcg_env, hex_imprecise_exception, PC);
+    gen_helper_hexagon_raise_exception(tcg_env, hex_imprecise_exception,
+                                       tcg_constant_vaddr(ctx->pkt.pc));
     gen_set_label(label);
 }
 #endif
-- 
2.52.0.windows.1


