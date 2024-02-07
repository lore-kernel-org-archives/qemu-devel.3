Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862F5C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkwT-00030Z-R6; Wed, 07 Feb 2024 11:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwS-0002zp-Cx
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:32 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwP-0006CO-9M
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:32 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33b0e5d1e89so735567f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 08:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707323908; x=1707928708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2vgt/WjJf2HA0KugTv1vBfaaG9X3Kl8endzGiNtDT8=;
 b=Rger1u/EA5hB/OPg2o7wlBnAcehbs/KAx/zLTduzfZafJEs6DB9/oc8qVhdW8kvV7c
 KO4UugWVRYcku7q5HwRZBENFfyD/LVMqFzpXexKtfs71rZn5fihPz8IC1TyqRORti0Yu
 GuQWU37dV0Qs2X54ore7gJp83PJ3El/56+ZJnSzuf32SSsKuUR0+S7X1lceR6qHTq33n
 LXGhlzfW7YTHqYqdvVsCQtBnZJ48NSfNTbv38GRYVZ7Maw7+84S2Pie1pmkgWLHfGZ+G
 8K0kBlcaBP/yVnH5KDcFpZ5nIex+ZaQS5EJhBuA+L/bRjDy3iS1krD+fvFv3WvbG7S/y
 RYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707323908; x=1707928708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z2vgt/WjJf2HA0KugTv1vBfaaG9X3Kl8endzGiNtDT8=;
 b=hKy4OYw33327U6uMpqSgVF+1S3uG+CzeNxcGpjhQ4bjjKC+r/+HMH0AamllGGsupfH
 AzzdIe9e27nNQ0K+ZNgiHEuZ3YUUu+1+YQD/hbeDEJWlUQL96FvtBDNhvwj33W07xrlo
 NRKt15zaQTMnFF4wKOGUrQlQtzJYmwh5Kz355wybuzJe2xOBTE24EuAjR/d6cmISXFE7
 mCxigxjqdE4mfn/X4L5q4oWQ5/4MELK1rsWPblsNNYRLzEhMIEyI1w0AS0SIdcILmdoH
 vsEgntxQoT3Wlxqg3J/efofWHSNJZjujr8qoYWqrXLB2MaMNxueNVrdFmiKrXXc7kABY
 cOJw==
X-Gm-Message-State: AOJu0YzGB/d2RfBxh8BxNIUrvcu7B36tX9do7ma1ZbMI1xQ4wO3NCFiZ
 9D+YjOkHRhNAiYSxknJrXxZDrx5/wNXEZSqR7siAUQXCpc/Dsmrxwhm1lMaV+p4=
X-Google-Smtp-Source: AGHT+IEKKrSH9TvE15V4DeeR704L/Bk2TeAzEHO0Yq3f62/MiSfujIaWP0z45XJEoBodYKePZS99pQ==
X-Received: by 2002:a5d:4523:0:b0:33b:1ac8:aebe with SMTP id
 j3-20020a5d4523000000b0033b1ac8aebemr4863574wra.44.1707323907793; 
 Wed, 07 Feb 2024 08:38:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUgaPKcBeGwVcF6F+SJ0hnc3uIR62pO2+ap1TjSypdzohrcatPumrhMX0akevBZfKLOfqcrDRzsQIQjrFGyyNlrG7SAcJZXQMoDCcMReckIaeAV8Z//SGrX0AHMjt7RW7q2xOws8W5fKApdCc4o9woSEsq8F98zbeBAUtxWMcBOVjK3rHrxSd2ueaOT6AzEOcpkGhcBUdXtH2uy8Mo82p0Z9SJ/yivEjR5YWtfcJ2M6hnR+SBQ4YhsFWJwurXcSXeJto8KRGLlqZBuaQmLqklmhaJ128nbNu/UomVUd+29BYe9aBe9EfCaL3DL2WiOjeJUEQQ5jbddFRfsWWBWdWvDuV0fm3SqajHpb/1uNbU3NktxQVK8j4aZ+9z+H8PeNPVUytM14riF1MpNEQbs4DLmDJsNTyefVQm9VOfCjZcNBJ5Qrh/NNx8sXqn1F5QLzP/lopJCu0pkqVx/GMmeSHmBOjc//pqStLNe8s2JBtdK43q+2lLwsOvFpL4RZnG6N2X8fd5cvLUIhHyGvGm1aYvC6Wb6a27UoNoCHwmaK89VH/AST6QuZubu2FNFT31j5L9I9+bvV9CxJxZgwrt8MfuQvY2OoFqids2x2v0q1tpzyGmMX6KWNJao940ZKguac0uKBZ0+YKhKQjPS5mlM7/9vC3pXZzU+Z3GgFL9xQ+mf+OF5DxTyciLF/82OZkJ3sM6TU2CSQ4ojpE78WblY33uOt/l3Mr6k/YwoTSDlJ+ZhXBvAb5AgVBFUbBlMVyixS7wCfqP6PRnqeB77Mfm0ZbEX2YugAcUrqEnr+YccYcsthugdgLC4Q/+jBOptYfFbOktfRhhnFwW1P/JlgCtK/QJk4+tPJ1srbDPQ2k61Y
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 y16-20020a5d6150000000b0033b443a7aa7sm1829371wrt.97.2024.02.07.08.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 08:38:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5A4ED5F951;
 Wed,  7 Feb 2024 16:38:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 13/14] gdbstub: Implement catching syscalls
Date: Wed,  7 Feb 2024 16:38:11 +0000
Message-Id: <20240207163812.3231697-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207163812.3231697-1-alex.bennee@linaro.org>
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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
---
 gdbstub/internals.h |  1 +
 gdbstub/gdbstub.c   |  9 +++++
 gdbstub/user.c      | 91 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

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


