Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA58CC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKFm-0004r8-5m; Tue, 06 May 2025 11:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFa-0004RS-6v
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFV-0002EO-Iw
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EOk7E3jXrTNmvHQgJjLleEZWPPeiGG5OI/Gf9wMaJXg=;
 b=EvQgh2Q5G3g/w8ln3fiPq6Ra206yysSKMZ2VqK8rwwu76HjEa9dnBGlRas6eJgG8hI921q
 gGHmbx8GkUDzMNLeRqSwjloG5WM7/WvFDjm5UNHJeW6RccnzGwxXK1S8BEs2du7bX7XfjH
 SEP8DXxn9P3aWJ717jws1Mgc5yvvjBc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-r3PSNPrqOzWxAq4q-S18HA-1; Tue, 06 May 2025 11:30:22 -0400
X-MC-Unique: r3PSNPrqOzWxAq4q-S18HA-1
X-Mimecast-MFC-AGG-ID: r3PSNPrqOzWxAq4q-S18HA_1746545421
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ceeaf1524so24605055e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545420; x=1747150220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOk7E3jXrTNmvHQgJjLleEZWPPeiGG5OI/Gf9wMaJXg=;
 b=K2UIWGrIr4l4sRurxiCcLIfSaYr5n8zsc4+DA71+hZVHhFFLDJ1SOMmMA9iuoeJBAo
 dQ6IsOec51EMO7Ldz+hm8GvCmqj7haAJpGtgbG0Xc4gaCNDwc32/BaaAox719+zUn8lT
 GwUkVklYImaQpKvmISADhJyMm8jGg9nwe9rMbmeCirldy1dF95jbttd5yx8biGZeLMcy
 19lZcA0Gva40yI3cSbIEt8OUvWWJoMi3YJwrZ0zIbUYfrVfCUAED3DWgwlF4MEy0M8HZ
 6JLyRwow2Z8llJJfO5v27Nv+KaW3RYyQ4wywp4TXhxYyR9xJxEl48eK3/zQFcSh/t4cL
 pCFQ==
X-Gm-Message-State: AOJu0YxecChBI5jCOMsDs2ymMj8j9TcXl7LHa3moSv5Kkc55p0+rW08o
 QFmmaZxwmCDlULo3WGPkl4qGr3vIj7Nm7SEEjZbvhpcyzcms0/m/2XGFwiwPCe+ZXjAdcCvZ/uV
 Jh0Ih8cHZv3lFoH29XrJug2OD+cC82wqhGpwb6HBirLPIHJQxyg12nwfl/7/JhN6+PkupFB5e+z
 zrjWCTcSG4fqyHGd0wEQO8eWp/rolrn+qYqRXe
X-Gm-Gg: ASbGncvnHB/fx5Q1eC/6mMcDIji+QwkwhYmPHY6gqjD+rKXAbq6s7jiS0HrxS+ReiA0
 g9qTZPlfdHcwvoC/ohaPncYZshzOcIbqDNfvKZ8NH2AnovdeqNZ92CZsbDSMN7zXMVPunnQPbTp
 waaJuNdtDO2VktaBjG9LII5GzM1Roupqf06xlJWf6Wt0mkmf4SWcLk1LAYvfP/qZ84JjYTRPDfU
 5dnX2WX5mqLmfWMz6HG9AEgikXEpWEw09wfW/iS+0FFreJJCRMfpaHvRBAxvxunSrqq8+VJC+E9
 RUyMVqwJmGq95hc=
X-Received: by 2002:a05:600c:1d06:b0:43b:c7f0:6173 with SMTP id
 5b1f17b1804b1-441d3b240b6mr1225165e9.4.1746545420167; 
 Tue, 06 May 2025 08:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzDMfXEgEibPSyq+PWcmdwnUH45PaP5cLIqlry7/mtCAmncphn/faQUodoKHrl0Ts3CkXr+g==
X-Received: by 2002:a05:600c:1d06:b0:43b:c7f0:6173 with SMTP id
 5b1f17b1804b1-441d3b240b6mr1224885e9.4.1746545419670; 
 Tue, 06 May 2025 08:30:19 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2ad78f6sm220890455e9.2.2025.05.06.08.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:30:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PULL 24/30] include/qemu/osdep.h: Add Emscripten-specific OS
 dependencies
Date: Tue,  6 May 2025 17:29:19 +0200
Message-ID: <20250506152927.222671-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

On emscripten, some implementations in os-posix.c can't be used such as
daemonizing and changing user. This commit introduces os-wasm.c and
os-wasm.h which are forked from os-posix.c and os-posix.h and patched for
targetting Emscripten.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Link: https://lore.kernel.org/r/9fc7b106ecf86675b4532bd6778b7b5945442f89.1745820062.git.ktokunaga.mail@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS              |   6 ++
 include/qemu/osdep.h     |   8 ++-
 include/system/os-wasm.h | 104 ++++++++++++++++++++++++++++++++++
 os-wasm.c                | 119 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 235 insertions(+), 2 deletions(-)
 create mode 100644 include/system/os-wasm.h
 create mode 100644 os-wasm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e748b6375ee..2e23dad4bc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -628,6 +628,12 @@ F: .gitlab-ci.d/cirrus/macos-*
 F: */*.m
 F: scripts/entitlement.sh
 
+WebAssembly
+M: Kohei Tokunaga <ktokunaga.mail@gmail.com>
+S: Maintained
+F: include/system/os-wasm.h
+F: os-wasm.c
+
 Alpha Machines
 --------------
 M: Richard Henderson <richard.henderson@linaro.org>
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 4397a906807..96fe51bc390 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -8,7 +8,7 @@
  * To avoid getting into possible circular include dependencies, this
  * file should not include any other QEMU headers, with the exceptions
  * of config-host.h, config-target.h, qemu/compiler.h,
- * system/os-posix.h, system/os-win32.h, glib-compat.h and
+ * system/os-posix.h, system/os-win32.h, system/os-wasm.h, glib-compat.h and
  * qemu/typedefs.h, all of which are doing a similar job to this file
  * and are under similar constraints.
  *
@@ -164,10 +164,14 @@ QEMU_EXTERN_C int daemon(int, int);
 #include "system/os-win32.h"
 #endif
 
-#ifdef CONFIG_POSIX
+#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 #include "system/os-posix.h"
 #endif
 
+#if defined(EMSCRIPTEN)
+#include "system/os-wasm.h"
+#endif
+
 #ifdef __cplusplus
 extern "C" {
 #endif
diff --git a/include/system/os-wasm.h b/include/system/os-wasm.h
new file mode 100644
index 00000000000..3abb3aaa03b
--- /dev/null
+++ b/include/system/os-wasm.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * posix specific declarations forked from os-posix.h, removing functions not
+ * working on Emscripten
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2010 Jes Sorensen <Jes.Sorensen@redhat.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef QEMU_OS_WASM_H
+#define QEMU_OS_WASM_H
+
+#include <sys/mman.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <netinet/tcp.h>
+#include <arpa/inet.h>
+#include <netdb.h>
+#include <sys/un.h>
+
+#ifdef CONFIG_SYSMACROS
+#include <sys/sysmacros.h>
+#endif
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+void os_set_line_buffering(void);
+void os_setup_early_signal_handling(void);
+void os_set_proc_name(const char *s);
+void os_setup_signal_handling(void);
+void os_setup_limits(void);
+void os_setup_post(void);
+int os_mlock(bool on_fault);
+static inline int os_set_daemonize(bool d)
+{
+    return -1;
+};
+bool is_daemonized(void);
+static inline void os_daemonize(void) {}
+
+/**
+ * qemu_alloc_stack:
+ * @sz: pointer to a size_t holding the requested usable stack size
+ *
+ * Allocate memory that can be used as a stack, for instance for
+ * coroutines. If the memory cannot be allocated, this function
+ * will abort (like g_malloc()). This function also inserts an
+ * additional guard page to catch a potential stack overflow.
+ * Note that the memory required for the guard page and alignment
+ * and minimal stack size restrictions will increase the value of sz.
+ *
+ * The allocated stack must be freed with qemu_free_stack().
+ *
+ * Returns: pointer to (the lowest address of) the stack memory.
+ */
+void *qemu_alloc_stack(size_t *sz);
+
+/**
+ * qemu_free_stack:
+ * @stack: stack to free
+ * @sz: size of stack in bytes
+ *
+ * Free a stack allocated via qemu_alloc_stack(). Note that sz must
+ * be exactly the adjusted stack size returned by qemu_alloc_stack.
+ */
+void qemu_free_stack(void *stack, size_t sz);
+
+/* POSIX and Mingw32 differ in the name of the stdio lock functions.  */
+
+static inline void qemu_flockfile(FILE *f)
+{
+    flockfile(f);
+}
+
+static inline void qemu_funlockfile(FILE *f)
+{
+    funlockfile(f);
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/os-wasm.c b/os-wasm.c
new file mode 100644
index 00000000000..d240c180c5f
--- /dev/null
+++ b/os-wasm.c
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * os-wasm.c
+ * Forked from os-posix.c, removing functions not working on Emscripten
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2010 Red Hat, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include <sys/resource.h>
+#include <sys/wait.h>
+#include <pwd.h>
+#include <grp.h>
+#include <libgen.h>
+
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "system/runstate.h"
+#include "qemu/cutils.h"
+
+void os_setup_post(void){}
+void os_set_line_buffering(void)
+{
+    setvbuf(stdout, NULL, _IOLBF, 0);
+}
+void os_setup_early_signal_handling(void)
+{
+    struct sigaction act;
+    sigfillset(&act.sa_mask);
+    act.sa_flags = 0;
+    act.sa_handler = SIG_IGN;
+    sigaction(SIGPIPE, &act, NULL);
+}
+void os_set_proc_name(const char *s)
+{
+    error_report("Change of process name not supported by your OS");
+    exit(1);
+}
+static void termsig_handler(int signal, siginfo_t *info, void *c)
+{
+    qemu_system_killed(info->si_signo, info->si_pid);
+}
+
+void os_setup_signal_handling(void)
+{
+    struct sigaction act;
+
+    memset(&act, 0, sizeof(act));
+    act.sa_sigaction = termsig_handler;
+    act.sa_flags = SA_SIGINFO;
+    sigaction(SIGINT,  &act, NULL);
+    sigaction(SIGHUP,  &act, NULL);
+    sigaction(SIGTERM, &act, NULL);
+}
+void os_setup_limits(void)
+{
+    struct rlimit nofile;
+
+    if (getrlimit(RLIMIT_NOFILE, &nofile) < 0) {
+        warn_report("unable to query NOFILE limit: %s", strerror(errno));
+        return;
+    }
+
+    if (nofile.rlim_cur == nofile.rlim_max) {
+        return;
+    }
+
+    nofile.rlim_cur = nofile.rlim_max;
+
+    if (setrlimit(RLIMIT_NOFILE, &nofile) < 0) {
+        warn_report("unable to set NOFILE limit: %s", strerror(errno));
+        return;
+    }
+}
+int os_mlock(bool on_fault)
+{
+#ifdef HAVE_MLOCKALL
+    int ret = 0;
+    int flags = MCL_CURRENT | MCL_FUTURE;
+
+    if (on_fault) {
+#ifdef HAVE_MLOCK_ONFAULT
+        flags |= MCL_ONFAULT;
+#else
+        error_report("mlockall: on_fault not supported");
+        return -EINVAL;
+#endif
+    }
+
+    ret = mlockall(flags);
+    if (ret < 0) {
+        error_report("mlockall: %s", strerror(errno));
+    }
+
+    return ret;
+#else
+    (void)on_fault;
+    return -ENOSYS;
+#endif
+}
-- 
2.49.0


