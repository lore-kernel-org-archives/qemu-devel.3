Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F91CC54E58
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 03:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rin6r-0000yC-7b; Fri, 08 Mar 2024 22:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rin6b-0000to-Rp
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 22:10:39 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rin6Y-00047l-MN
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 22:10:37 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dd0d46ecc3so19863115ad.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 19:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709953830; x=1710558630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sDSh+jXFo2Wr9YtYdh0sZ1LM65dfvglJvDrANjjOKdw=;
 b=kHfzrzxc5UlQqq7t2Gp3pKEHVdNnSeKXfGWTenUkiJ+PPoObwvXl4arEE2UZ94Sz+H
 DnpqH6mVWjPxZTqGObluFnlKHDpba3BNGx7/gYIzOhk2/rfh3gU6v84KC9+vW9QJudLt
 39AmyB03xluGGF3wwxnOTf/ud6GcJMERiT/kjhdcQQ8fF85c90uEeXH0KFj9oMFQM1bS
 t5YLX4BKZwtXGiaBOcR3yRToHCazF+oB8ekeDXNLOysbHca4u3ot22eYNKgQfX2l3Ump
 IAz36j5Wp208fII4iiS5MV3yj74auIGCAXEyL7HIbgfOG3YZVR/mgUO5NCYhwpm7qQgV
 ppTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709953830; x=1710558630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sDSh+jXFo2Wr9YtYdh0sZ1LM65dfvglJvDrANjjOKdw=;
 b=B/UM+w54Z2R9nBOz11qhGrPvODBArOC9YPu8EKL+LW9Z0AB2RVfgfcj9JO99SwQl07
 feaAtTHidngELs54qWzyofNAAF+q1v6pLXENDFP7YibQNDrnBjOBeOnexZAvgZzhCGej
 viM3WZS4U43qPV8JajiiKfZ9sBARJT7nDARq48BbDQlHwb28/Fqwa8+sYyYFdT/X79d1
 a8Ws5AP/PRog2GyHiLdKepyiwi5PTIjS6smUVxMZfXl1DDcIB/xcmO8DEEjmHjl67IMJ
 LhPRh2U8IB7HdNjIz5fUcnXIy4v+iKrcFVApQD3AqDltj6lYN+30lJoG7ezn+m9mgVL4
 +XTA==
X-Gm-Message-State: AOJu0Yx0JRSGAmds91wOiJWodRDEvGUXajpQ+1er4N1w62vrHXfsOw2t
 OJwtaF6LONMFoA3rETZL5AsTI/JtohzhTITXyezjiSWT+da/WhMPWi01TYKXMdAo/ED2FVuAIDP
 SSag=
X-Google-Smtp-Source: AGHT+IGXnqbW/hVpTPNCoNmyG+0SV0TPfayWQYMcQmUj8bGc6hKGjURkBASSX3eFY4O7o596EzwUGg==
X-Received: by 2002:a17:902:dacc:b0:1dd:758f:2d33 with SMTP id
 q12-20020a170902dacc00b001dd758f2d33mr794780plx.4.1709953830375; 
 Fri, 08 Mar 2024 19:10:30 -0800 (PST)
Received: from amd.. ([2804:7f0:b401:7e8e:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a170902d3cd00b001dd707d5fe6sm349566plb.158.2024.03.08.19.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 19:10:29 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org, gustavo.romero@linaro.org
Subject: [PATCH v3 3/5] gdbstub: Save target's siginfo
Date: Sat,  9 Mar 2024 03:08:59 +0000
Message-Id: <20240309030901.1726211-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240309030901.1726211-1-gustavo.romero@linaro.org>
References: <20240309030901.1726211-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Save target's siginfo into gdbserver_state so it can be used later, for
example, in any stub that requires the target's si_signo and si_code.

This change affects only linux-user mode.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/main.c        |  2 +-
 bsd-user/signal.c      |  5 ++++-
 gdbstub/user.c         | 23 +++++++++++++++++++----
 include/gdbstub/user.h |  6 +++++-
 linux-user/main.c      |  2 +-
 linux-user/signal.c    |  5 ++++-
 6 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 512d4ab69f..04b18eee27 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -601,7 +601,7 @@ int main(int argc, char **argv)
 
     if (gdbstub) {
         gdbserver_start(gdbstub);
-        gdb_handlesig(cpu, 0);
+        gdb_handlesig(cpu, 0, NULL, NULL, 0);
     }
     cpu_loop(env);
     /* never exits */
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index f4352e4530..ad738def70 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -27,6 +27,9 @@
 #include "hw/core/tcg-cpu-ops.h"
 #include "host-signal.h"
 
+/* target_siginfo_t must fit in gdbstub's siginfo save area. */
+QEMU_BUILD_BUG_ON(sizeof(target_siginfo_t) > MAX_SIGINFO_LENGTH);
+
 static struct target_sigaction sigact_table[TARGET_NSIG];
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc);
 static void target_to_host_sigset_internal(sigset_t *d,
@@ -890,7 +893,7 @@ static void handle_pending_signal(CPUArchState *env, int sig,
 
     k->pending = 0;
 
-    sig = gdb_handlesig(cpu, sig);
+    sig = gdb_handlesig(cpu, sig, NULL, &k->info, sizeof(k->info));
     if (!sig) {
         sa = NULL;
         handler = TARGET_SIG_IGN;
diff --git a/gdbstub/user.c b/gdbstub/user.c
index a157e67f95..df040c6ffa 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -36,6 +36,8 @@ typedef struct {
      */
     bool catch_all_syscalls;
     GDBSyscallsMask catch_syscalls_mask;
+    uint8_t siginfo[MAX_SIGINFO_LENGTH];
+    unsigned long siginfo_len;
 } GDBUserState;
 
 static GDBUserState gdbserver_user_state;
@@ -131,7 +133,8 @@ void gdb_qemu_exit(int code)
     exit(code);
 }
 
-int gdb_handlesig(CPUState *cpu, int sig, const char *reason)
+int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
+                  int siginfo_len)
 {
     char buf[256];
     int n;
@@ -140,6 +143,18 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason)
         return sig;
     }
 
+    if (siginfo) {
+        /*
+         * Save target-specific siginfo.
+         *
+         * siginfo size, i.e. siginfo_len, is asserted at compile-time to fit in
+         * gdbserver_user_state.siginfo, usually in the source file calling
+         * gdb_handlesig. See, for instance, {linux,bsd}-user/signal.c.
+         */
+        memcpy(gdbserver_user_state.siginfo, siginfo, siginfo_len);
+        gdbserver_user_state.siginfo_len = siginfo_len;
+    }
+
     /* disable single step if it was enabled */
     cpu_single_step(cpu, 0);
     tb_flush(cpu);
@@ -510,7 +525,7 @@ void gdb_breakpoint_remove_all(CPUState *cs)
 void gdb_syscall_handling(const char *syscall_packet)
 {
     gdb_put_packet(syscall_packet);
-    gdb_handlesig(gdbserver_state.c_cpu, 0, NULL);
+    gdb_handlesig(gdbserver_state.c_cpu, 0, NULL, NULL, 0);
 }
 
 static bool should_catch_syscall(int num)
@@ -528,7 +543,7 @@ void gdb_syscall_entry(CPUState *cs, int num)
 {
     if (should_catch_syscall(num)) {
         g_autofree char *reason = g_strdup_printf("syscall_entry:%x;", num);
-        gdb_handlesig(cs, gdb_target_sigtrap(), reason);
+        gdb_handlesig(cs, gdb_target_sigtrap(), reason, NULL, 0);
     }
 }
 
@@ -536,7 +551,7 @@ void gdb_syscall_return(CPUState *cs, int num)
 {
     if (should_catch_syscall(num)) {
         g_autofree char *reason = g_strdup_printf("syscall_return:%x;", num);
-        gdb_handlesig(cs, gdb_target_sigtrap(), reason);
+        gdb_handlesig(cs, gdb_target_sigtrap(), reason, NULL, 0);
     }
 }
 
diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 6647af2123..0ec9a7e596 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -9,11 +9,15 @@
 #ifndef GDBSTUB_USER_H
 #define GDBSTUB_USER_H
 
+#define MAX_SIGINFO_LENGTH 128
+
 /**
  * gdb_handlesig() - yield control to gdb
  * @cpu: CPU
  * @sig: if non-zero, the signal number which caused us to stop
  * @reason: stop reason for stop reply packet or NULL
+ * @siginfo: target-specific siginfo struct
+ * @siginfo_len: target-specific siginfo struct length
  *
  * This function yields control to gdb, when a user-mode-only target
  * needs to stop execution. If @sig is non-zero, then we will send a
@@ -25,7 +29,7 @@
  * or 0 if no signal should be delivered, ie the signal that caused
  * us to stop should be ignored.
  */
-int gdb_handlesig(CPUState *, int, const char *);
+int gdb_handlesig(CPUState *, int, const char *, void *, int);
 
 /**
  * gdb_signalled() - inform remote gdb of sig exit
diff --git a/linux-user/main.c b/linux-user/main.c
index 049fd85a2a..3187be48d6 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1014,7 +1014,7 @@ int main(int argc, char **argv, char **envp)
                     gdbstub);
             exit(EXIT_FAILURE);
         }
-        gdb_handlesig(cpu, 0, NULL);
+        gdb_handlesig(cpu, 0, NULL, NULL, 0);
     }
 
 #ifdef CONFIG_SEMIHOSTING
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 7a4c8e416e..98d1eacffe 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -34,6 +34,9 @@
 #include "user/safe-syscall.h"
 #include "tcg/tcg.h"
 
+/* target_siginfo_t must fit in gdbstub's siginfo save area. */
+QEMU_BUILD_BUG_ON(sizeof(target_siginfo_t) > MAX_SIGINFO_LENGTH);
+
 static struct target_sigaction sigact_table[TARGET_NSIG];
 
 static void host_signal_handler(int host_signum, siginfo_t *info,
@@ -1186,7 +1189,7 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
      */
     tswap_siginfo(&k->info, &k->info);
 
-    sig = gdb_handlesig(cpu, sig, NULL);
+    sig = gdb_handlesig(cpu, sig, NULL, &k->info, sizeof(k->info));
     if (!sig) {
         sa = NULL;
         handler = TARGET_SIG_IGN;
-- 
2.34.1


