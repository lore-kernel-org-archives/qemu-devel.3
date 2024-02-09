Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BE6C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 19:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYWrH-0006Er-NQ; Fri, 09 Feb 2024 14:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqf-0005WY-1P
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:45 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqc-0005Bt-Pu
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:44 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3392b045e0aso703883f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 11:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707508061; x=1708112861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fspe01bX4KX8hKRjqhxvWfR3ZGNlHrXdv6yZvN6uP9U=;
 b=sHkbUqbAFOKAQk+xxgir4LXkbp/BHkRBfdnTYY0gmMOnpL4AVu6gNtdeDH1SAYSUhj
 gEL++t2GbMos8YUR6p58sHL6HWA9MVVtPlctKkuSNwBx7pmi+QbxXq2Z6U9xDwmjBeSv
 9rNyuekcAWIIlUxnoSYxpMI4BaLzDlPAcpvDApAINKicziQNIBTWx9nmUJpuo/Rwu0Uu
 BC3H6zT7vuBxHzc43c2X1tMG08F9UtzuICv8tMuWtuNb40LbkvuNRalkwQuV9+jT7dC/
 wL6g7vYgBxBTV95J1SPdyb1Ja5dPNKgPig1grG+TaANcnIdZak37U9N40zCeFQUwmJ84
 ZYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707508061; x=1708112861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fspe01bX4KX8hKRjqhxvWfR3ZGNlHrXdv6yZvN6uP9U=;
 b=U/iI0MzMglxgU2nta3mzl7O1pY6vAM16PoqcUSfljJk8deHUaEm7SksovbeRvSV+fg
 1OVQ7isjSIRA/NpzuZbJuOKq/8SQF5COrp0iWE5357eppB/XFO7AN9aho1W7boZUdMR3
 2kK29HnpM5vEP1DtqtemLAoiMbLlBf5wbHiguf24XsHpobqEdiwg8qTUgw/blVK4n0OK
 ZHr2f0K4g377EAAR5+4eJ4Enhoz376Bwz5Gt7K8X2NNSUv1q2qX4DEQEyJdCN7ccG4JK
 7yThMyQwJyLYlLTrtgaE/kT/p50JEnVWrMhFrcoG/hrKCNKNzSzH+WBy/NQDGZRqrmrU
 tssA==
X-Gm-Message-State: AOJu0YwyvXOVQODojLfJaND3v635xZiLtUYzCK711wwL71Sy0SdEjHas
 UsRHl48x1c363ZuutJaGzccHMX+ZmWgR36P3B1yA26k6OuEUmv+Zz8DOQbFeNfg=
X-Google-Smtp-Source: AGHT+IEx/jTvlfw+WQ3PA9YDztmdyYdrzYZF2QqC6yKX70HZvomPZYdPlu2sn1DhLGpq8+kt6CI7Ow==
X-Received: by 2002:a5d:664d:0:b0:33b:649a:19f6 with SMTP id
 f13-20020a5d664d000000b0033b649a19f6mr8397wrw.35.1707508061471; 
 Fri, 09 Feb 2024 11:47:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWmHZqaGAZO4uWzETZYAhM/YftpreNJ+82Ub/10ojXK9H/kKBD6m4VtlEfaI4CJ+9k6XiSO+D8ggz0smfe2USgGQvPLS1qBzZUSY4SmAkrPf1Hsx0RaMLL3Uw==
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m10-20020adff38a000000b0033b0d2ba3a1sm50386wro.63.2024.02.09.11.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:47:37 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E0255F8E1;
 Fri,  9 Feb 2024 19:47:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/10] gdbstub: Implement catching syscalls
Date: Fri,  9 Feb 2024 19:47:33 +0000
Message-Id: <20240209194734.3424785-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209194734.3424785-1-alex.bennee@linaro.org>
References: <20240209194734.3424785-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

GDB supports stopping on syscall entry and exit using the "catch
syscall" command. It relies on 3 packets, which are currently not
supported by QEMU:

* qSupported:QCatchSyscalls+ [1]
* QCatchSyscalls: [2]
* T05syscall_entry: and T05syscall_return: [3]

Implement generation and handling of these packets.

[1] https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Packets.html#qSupported
[2] https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Packets.html#QCatchSyscalls
[3] https://sourceware.org/gdb/current/onlinedocs/gdb.html/Stop-Reply-Packets.html

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240202152506.279476-5-iii@linux.ibm.com>
[AJB: GString -> g_strdup_printf]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240207163812.3231697-14-alex.bennee@linaro.org>

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index aeb0d9b5377..56b7c13b750 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -195,6 +195,7 @@ void gdb_handle_v_file_close(GArray *params, void *user_ctx); /* user */
 void gdb_handle_v_file_pread(GArray *params, void *user_ctx); /* user */
 void gdb_handle_v_file_readlink(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /* user */
+void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 46d752bbc2c..7e73e916bdc 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1617,6 +1617,7 @@ static void handle_query_supported(GArray *params, void *user_ctx)
     if (gdbserver_state.c_cpu->opaque) {
         g_string_append(gdbserver_state.str_buf, ";qXfer:auxv:read+");
     }
+    g_string_append(gdbserver_state.str_buf, ";QCatchSyscalls+");
 #endif
     g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
 #endif
@@ -1810,6 +1811,14 @@ static const GdbCmdParseEntry gdb_gen_set_table[] = {
         .schema = "l0"
     },
 #endif
+#if defined(CONFIG_USER_ONLY)
+    {
+        .handler = gdb_handle_set_catch_syscalls,
+        .cmd = "CatchSyscalls:",
+        .cmd_startswith = 1,
+        .schema = "s0",
+    },
+#endif
 };
 
 static void handle_gen_query(GArray *params, void *user_ctx)
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 2ba01c17faf..14918d1a217 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
 #include "exec/hwaddr.h"
@@ -21,11 +22,20 @@
 #include "trace.h"
 #include "internals.h"
 
+#define GDB_NR_SYSCALLS 1024
+typedef unsigned long GDBSyscallsMask[BITS_TO_LONGS(GDB_NR_SYSCALLS)];
+
 /* User-mode specific state */
 typedef struct {
     int fd;
     char *socket_path;
     int running_state;
+    /*
+     * Store syscalls mask without memory allocation in order to avoid
+     * implementing synchronization.
+     */
+    bool catch_all_syscalls;
+    GDBSyscallsMask catch_syscalls_mask;
 } GDBUserState;
 
 static GDBUserState gdbserver_user_state;
@@ -503,10 +513,91 @@ void gdb_syscall_handling(const char *syscall_packet)
     gdb_handlesig(gdbserver_state.c_cpu, 0);
 }
 
+static bool should_catch_syscall(int num)
+{
+    if (gdbserver_user_state.catch_all_syscalls) {
+        return true;
+    }
+    if (num < 0 || num >= GDB_NR_SYSCALLS) {
+        return false;
+    }
+    return test_bit(num, gdbserver_user_state.catch_syscalls_mask);
+}
+
 void gdb_syscall_entry(CPUState *cs, int num)
 {
+    if (should_catch_syscall(num)) {
+        g_autofree char *reason = g_strdup_printf("syscall_entry:%x;", num);
+        gdb_handlesig_reason(cs, gdb_target_sigtrap(), reason);
+    }
 }
 
 void gdb_syscall_return(CPUState *cs, int num)
 {
+    if (should_catch_syscall(num)) {
+        g_autofree char *reason = g_strdup_printf("syscall_return:%x;", num);
+        gdb_handlesig_reason(cs, gdb_target_sigtrap(), reason);
+    }
+}
+
+void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx)
+{
+    const char *param = get_param(params, 0)->data;
+    GDBSyscallsMask catch_syscalls_mask;
+    bool catch_all_syscalls;
+    unsigned int num;
+    const char *p;
+
+    /* "0" means not catching any syscalls. */
+    if (strcmp(param, "0") == 0) {
+        gdbserver_user_state.catch_all_syscalls = false;
+        memset(gdbserver_user_state.catch_syscalls_mask, 0,
+               sizeof(gdbserver_user_state.catch_syscalls_mask));
+        gdb_put_packet("OK");
+        return;
+    }
+
+    /* "1" means catching all syscalls. */
+    if (strcmp(param, "1") == 0) {
+        gdbserver_user_state.catch_all_syscalls = true;
+        gdb_put_packet("OK");
+        return;
+    }
+
+    /*
+     * "1;..." means catching only the specified syscalls.
+     * The syscall list must not be empty.
+     */
+    if (param[0] == '1' && param[1] == ';') {
+        catch_all_syscalls = false;
+        memset(catch_syscalls_mask, 0, sizeof(catch_syscalls_mask));
+        for (p = &param[2];; p++) {
+            if (qemu_strtoui(p, &p, 16, &num) || (*p && *p != ';')) {
+                goto err;
+            }
+            if (num >= GDB_NR_SYSCALLS) {
+                /*
+                 * Fall back to reporting all syscalls. Reporting extra
+                 * syscalls is inefficient, but the spec explicitly allows it.
+                 * Keep parsing in case there is a syntax error ahead.
+                 */
+                catch_all_syscalls = true;
+            } else {
+                set_bit(num, catch_syscalls_mask);
+            }
+            if (!*p) {
+                break;
+            }
+        }
+        gdbserver_user_state.catch_all_syscalls = catch_all_syscalls;
+        if (!catch_all_syscalls) {
+            memcpy(gdbserver_user_state.catch_syscalls_mask,
+                   catch_syscalls_mask, sizeof(catch_syscalls_mask));
+        }
+        gdb_put_packet("OK");
+        return;
+    }
+
+err:
+    gdb_put_packet("E00");
 }
-- 
2.39.2


