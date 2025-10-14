Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CCECCD185
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 00:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Svy-0004LK-Qx; Mon, 13 Oct 2025 20:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3nJntaAcKCtMCzK723B5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--navidem.bounces.google.com>)
 id 1v8Svp-0004Kh-HS
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 20:30:27 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3nJntaAcKCtMCzK723B5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--navidem.bounces.google.com>)
 id 1v8Svn-0005lq-9r
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 20:30:25 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-3304def7909so8665570a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 17:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1760401821; x=1761006621; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cfki/HXSz/Z8fTUdxPK9o7z97WjR7wseulnXShHtCGE=;
 b=0l2wJtVsKy7U+6FfwMXzXLHIDQgiwXQ2tcWBZynCJYfEIsTh5Uh8daz06RW6h1CuMk
 LvLOWWyY0/KsCvWtK7wlGGQFnn8NLgZJGX4of1/zF9tDmKxILr5H7VfCaUl56im8k40m
 a6jGiElg2Oe0qx8i9lIQWLchp9Jvt0X4qb+Y4lLBJJWgjN9PWaiNzE2+ACkATWG+D1Re
 rCLi0e8XbE6y6skaseZ5pqUhBMx312J40DnY+6vO8Eh45oBGS6rfnQIko2XLeuE3n4UE
 ZkPh/HgQATeA1oEPXp+IN52o1VykL0SwIrq1rMeWBv5B6AAlxe5wiEXpmRYDwMCmfee4
 +F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760401821; x=1761006621;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cfki/HXSz/Z8fTUdxPK9o7z97WjR7wseulnXShHtCGE=;
 b=r5z/oZzPwGA49QljDujYXpc39L08we+NDahMjSR3fqaodobUaAib2Dlyis/mQjDlk/
 GZ8xF/4wt1OOZcIyNuwSO6WqV8MzlLBo1ZjoA4NM78NtUkKi5Eoq7Twt8g66yz3YJZMl
 hU9fpZ5I01xIjfqEdR/8oLVS5gMRo8njY2tyVInbgl+62pDZKmcva24OLAru5bz6oviP
 rOreCxJgXQvBi80S4Wln+aSQ177aYu34SogOOcLBBhtC2gQaITBqbeHiztqhTP0dX3+4
 gSCgt8JFpCUDskF5SP0FwMbCSPI72VJC3vi9G+4fbZOV6JxzJ0PIXb/kq5S2sKaN8g/Y
 H1FA==
X-Gm-Message-State: AOJu0YyyIAelwWqUuHmmb7BSTuHzOPJGg1POVihgQ9xmFIFrUGj6afey
 wrmLBmmpyyt9OPqPRDNyS8NJ/rQYKpe5CJbB94NedecelRi6yfIVDviHzvmlC38kHd8p9s1wAlE
 I5s8iRSIVy8DAP1SpRHlxKKmEKST2qDhfUilibUpcCh0KFwdGugEtzFe5qN3icPEqAfYOc8X/Rt
 JqEgc2/372VzX7DE8w7yup5loeUdudFmANxwiK0SQU
X-Google-Smtp-Source: AGHT+IEIxb2s+q4nNtCTxp2C1cg/I10gdXJ3+VIwzaq+s20Bc/Y1NWMWgWmonPUMzv9W57UxVQdoN7cCWuUD
X-Received: from pjuy5.prod.google.com ([2002:a17:90a:d705:b0:33b:51fe:1a90])
 (user=navidem job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1c0a:b0:32d:e75a:5009
 with SMTP id 98e67ed59e1d1-33b5114d4f2mr32136527a91.1.1760401820802; Mon, 13
 Oct 2025 17:30:20 -0700 (PDT)
Date: Tue, 14 Oct 2025 00:30:07 +0000
In-Reply-To: <20251014003008.2520701-1-navidem@google.com>
Mime-Version: 1.0
References: <CAHUE=o-aypvXPxZXssD8nMJm+Qa9Nsp1HRcNVbC27tNkpV75fg@mail.gmail.com>
 <20251014003008.2520701-1-navidem@google.com>
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Message-ID: <20251014003008.2520701-2-navidem@google.com>
Subject: [PATCH v2 1/1] tests/qtest/fuzz: Add generic fuzzer for VNC
From: Navid Emamdoost <navidem@google.com>
To: qemu-devel@nongnu.org
Cc: alxndr@bu.edu, berrange@redhat.com, Navid Emamdoost <navidem@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3nJntaAcKCtMCzK723B5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--navidem.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -98
X-Spam_score: -9.9
X-Spam_bar: ---------
X-Spam_report: (-9.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.268,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add a new generic fuzz target for the QEMU VNC server. This target
exercises both the standard VNC protocol and the VNC-over-WebSocket
transport layer, increasing coverage of a primary remote attack surface.

To support parallel fuzzing (e.g., with oss-fuzz), the VNC unix
socket paths are generated dynamically. The fuzzer harness inspects the
command line for placeholders and replaces them with unique paths
created by mkstemp() before execution.

---

This new target increases code coverage in the VNC subsystem
and related networking and I/O code.
The baseline coverage below was generated by running all existing fuzz
targets with the oss-fuzz corpus. The new target shows significant gains:

----------------------------------------------------------------------------
File                       New Target                Baseline        Change
----------------------------------------------------------------------------
vnc.c                      339/3212 (10.6%)     3/3212 (0.1%)        +336
keymaps.c                  91/184 (49.5%)       0/184 (0.0%)         +91
net-listener.c             76/198 (38.4%)       3/198 (1.5%)         +73
channel-socket.c           73/575 (12.7%)       19/575 (3.3%)        +54
qemu-sockets.c             44/1019 (4.3%)       0/1019 (0.0%)        +44
vnc-jobs.c                 41/219 (18.7%)       0/219 (0.0%)         +41
dns-resolver.c             28/145 (19.3%)       3/145 (2.1%)         +25

Signed-off-by: Navid Emamdoost <navidem@google.com>
---
 tests/qtest/fuzz/fuzz.c                 | 65 +++++++++++++++++++++++++
 tests/qtest/fuzz/generic_fuzz_configs.h |  5 ++
 2 files changed, 70 insertions(+)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index ca248a51a6..b77c3ceb2b 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -126,6 +126,46 @@ static FuzzTarget *fuzz_get_target(char* name)
     return NULL;
 }
 
+/*
+ * Global variables to hold the unique socket paths for cleanup.
+ */
+static char g_vnc_socket_path[sizeof("/tmp/qemu-vnc.XXXXXX")];
+static char g_vnc_ws_socket_path[sizeof("/tmp/qemu-vnc-ws.XXXXXX")];
+
+/*
+ * atexit() handler to clean up both socket files.
+ */
+static void cleanup_vnc_sockets(void)
+{
+    if (g_vnc_socket_path[0] != '\0') {
+        unlink(g_vnc_socket_path);
+    }
+    if (g_vnc_ws_socket_path[0] != '\0') {
+        unlink(g_vnc_ws_socket_path);
+    }
+}
+
+/* Helper function to find and replace a placeholder in a GString */
+static bool replace_socket_placeholder(GString *cmd_line, const char *placeholder,
+                                       const char *path_template, char *global_path_out)
+{
+    char *placeholder_ptr = strstr(cmd_line->str, placeholder);
+    if (placeholder_ptr) {
+        int fd;
+        strcpy(global_path_out, path_template);
+        fd = mkstemp(global_path_out);
+        if (fd == -1) {
+            perror("mkstemp failed");
+            return false;
+        }
+        close(fd);
+
+        gssize pos = placeholder_ptr - cmd_line->str;
+        g_string_erase(cmd_line, pos, strlen(placeholder));
+        g_string_insert(cmd_line, pos, global_path_out);
+    }
+    return true;
+}
 
 /* Sometimes called by libfuzzer to mutate two inputs into one */
 size_t LLVMFuzzerCustomCrossOver(const uint8_t *data1, size_t size1,
@@ -213,6 +253,31 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
     g_string_append_printf(cmd_line, " %s -qtest /dev/null ",
                            getenv("QTEST_LOG") ? "" : "-qtest-log none");
 
+    /*
+     * For the VNC fuzzer, we replace placeholders for both the standard
+     * and WebSocket VNC listeners with unique socket paths.
+     */
+    if (strcmp(fuzz_target->name, "generic-fuzz-vnc") == 0) {
+        bool success = true;
+        success &= replace_socket_placeholder(cmd_line, "VNC_SOCKET_PATH",
+                                              "/tmp/qemu-vnc.XXXXXX", g_vnc_socket_path);
+        success &= replace_socket_placeholder(cmd_line, "VNC_WS_SOCKET_PATH",
+                                              "/tmp/qemu-vnc-ws.XXXXXX", g_vnc_ws_socket_path);
+
+        if (!success) {
+            exit(1);
+        }
+
+        /* Check that placeholders were actually found and replaced */
+        if (g_vnc_socket_path[0] == '\0' || g_vnc_ws_socket_path[0] == '\0') {
+            fprintf(stderr, "ERROR: VNC fuzzer is missing a socket placeholder\n");
+            exit(1);
+        }
+
+        /* Register a single cleanup handler for both sockets */
+        atexit(cleanup_vnc_sockets);
+    }
+
     /* Split the runcmd into an argv and argc */
     wordexp_t result;
     wordexp(cmd_line->str, &result, 0);
diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
index ef0ad95712..bd2d875dd8 100644
--- a/tests/qtest/fuzz/generic_fuzz_configs.h
+++ b/tests/qtest/fuzz/generic_fuzz_configs.h
@@ -247,6 +247,11 @@ const generic_fuzz_config predefined_configs[] = {
         .args = "-machine q35 -nodefaults "
         "-parallel file:/dev/null",
         .objects = "parallel*",
+    },{
+        .name = "vnc",
+        .args = "-machine q35 -nodefaults "
+		"-vnc vnc=unix:VNC_SOCKET_PATH,websocket=unix:VNC_WS_SOCKET_PATH",
+        .objects = "*",
     }
 };
 
-- 
2.51.0.760.g7b8bcc2412-goog


