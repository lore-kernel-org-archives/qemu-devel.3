Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2094CF45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHxt-0000ZI-Go; Fri, 10 Apr 2026 15:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHxr-0000Sk-IV
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:56:27 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHxm-0004MA-7S
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:56:27 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488b8efed61so22044685e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850978; x=1776455778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ow/eQWa3P4KDoGEVMogN/Isn8lewWO8ymg/RYy5QKo0=;
 b=fH59SpcGllwzOEpfjLuaPIBCj3Cgsdul6H54+fp22YXR2fk5oWk9ZA/XSLJTX/CETB
 9AxmohhADUximrB48xjYHgj3bfNanUXXyIhuexjuDdEWqbrfArg4nZQqcz4yxqOL8O4o
 paErOSJOx/cg/IM126/pi4qLd0rhbnbx0rlSwk/iSljKg3FxrbJIyGYAkQD8GHBRp3Y1
 h1xGc1X0/1BGlFODPjJaUp2SuYqqa3pDx3udYxxJZMHvJWSWiz9Bhw8vLayP9XJynSwN
 OoxqFh7s34jx1bbi/obQu58UE82odyXuKBgvvtH0Q6xcL4SzieKRESDQ+1azqRYy2JcB
 dNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850978; x=1776455778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ow/eQWa3P4KDoGEVMogN/Isn8lewWO8ymg/RYy5QKo0=;
 b=G/hvClqLCYlXFFbfP5h3c0Qtn44LX5/iffwaUNfXOELBR/0NXgBTCs3QoE89Hgvy7z
 oHcXvjVPLtFtgQdzUWSLdVxAsgYm71q1uV5FO0d0+uggiosQKpOOkqFRTQmtpKLKz4B9
 bP0l+uvoHUNHv1qpSVD/BpZTADpYwqfoScAO9uWzmFlFUoJJdjqzgvN5FfqVGXjun5K+
 S6wsaTD5TyWp9RzupgHhyqj/OnfD0STt8R0W9kTRxcALkZEof38x38SYyKeazfe+59Ja
 CydidZ7QzSoIEQArKKKbCaRVZbuPEYkYYWmHFpxVzWaQN5iaVIlCPlvQuDBcaAOZdWma
 JSKg==
X-Gm-Message-State: AOJu0YxVqeeB9eCMl7vYb35Xk1t6l091L8zvm5qQIId0N4BAP05ftMq1
 7NydWBlXGkWp3496QIGXGf+4I/vGw6e9B6zqT6eHd1PnX5LFCH5uK9OdRbphVQYrzHwjE1UxJjH
 1XzUkxjw=
X-Gm-Gg: AeBDieu/G+Dy0WIRLfePQVrOtl7/W9MVRL7Qt0pbyascgYWT6jW+xTLtMdxQEJXlyx2
 CuvaUatV4fRrzubZXKtEu1L042QBC6V9PlhH9aRuKWngpbHnzI4EeAR8c7qe5nqnp1nt+jGUe5n
 +Xp/C6Fk2Wqi8C5jN28d/zkAAAtj9pa9EWvL0XpAHe8cK21pgz97U1XnUfuZX0s7xmXbd+w9Snp
 FJM1s2Bq22fC/QlNA28HEWzwJUTiklmgOrWd8qHTkB3TLjKhV/3JWYwhyKQTkYJ3ybY4GNhYrCC
 Bm4NmtNrzt41qzmx2gnJ24G/lWEwumLN7QHIcCeEq2nzxsZcI/7ZKKw3ZsAwi5VCAGYEmt2qzws
 +3BRrb5kDDWqFy2u00GC88ZyZbJjXDa/53TYAY7ZV6d0pEo+LRzm9r160ndMQ0ca2Fo3brbgczp
 o3nMwQMQjvHayLn39V64puVQECpsSh+8Vb9tWricxdJECanQmJ6kAPy5grl/+hsbT0EVSWMCI7m
 q8Qti3qivU=
X-Received: by 2002:a7b:cd05:0:b0:488:a9c3:44a3 with SMTP id
 5b1f17b1804b1-488cd4f463dmr84378015e9.2.1775850977577; 
 Fri, 10 Apr 2026 12:56:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e5c981sm10026977f8f.33.2026.04.10.12.56.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:56:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 24/27] monitor: Do not check TARGET_I386 to build 'info
 sev' command
Date: Fri, 10 Apr 2026 21:53:18 +0200
Message-ID: <20260410195323.17937-25-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This command is filtered at build-time for i386/x86_64 binaries.
By using the recently introduced HMPCommand::arch_bitmask flag
we can filter it at runtime, making it possible to compile
hmp-commands-info.hx once.

Since the method depends on the CONFIG_SEV definition, define it
in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                   |  1 +
 stubs/hmp-cmd-info_sev.c      | 16 ++++++++++++++++
 target/i386/sev-system-stub.c |  5 -----
 hmp-commands-info.hx          |  3 +--
 stubs/meson.build             |  1 +
 5 files changed, 19 insertions(+), 7 deletions(-)
 create mode 100644 stubs/hmp-cmd-info_sev.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 31e973fdeb0..5dcd24a8a89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -515,6 +515,7 @@ S: Supported
 F: docs/system/i386/amd-memory-encryption.rst
 F: docs/system/i386/sgx.rst
 F: hw/i386/sgx*
+F: stubs/hmp-cmd-info_sev.c
 F: stubs/qmp-i386-sev.c
 F: stubs/qmp-i386-sgx.c
 F: target/i386/kvm/
diff --git a/stubs/hmp-cmd-info_sev.c b/stubs/hmp-cmd-info_sev.c
new file mode 100644
index 00000000000..f3624423a33
--- /dev/null
+++ b/stubs/hmp-cmd-info_sev.c
@@ -0,0 +1,16 @@
+/*
+ * Human Monitor 'info sev' stub (CONFIG_SEV)
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
+
+void hmp_info_sev(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "SEV is not available in this QEMU\n");
+}
diff --git a/target/i386/sev-system-stub.c b/target/i386/sev-system-stub.c
index f799a338d60..d97536cca1c 100644
--- a/target/i386/sev-system-stub.c
+++ b/target/i386/sev-system-stub.c
@@ -31,11 +31,6 @@ int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size)
     g_assert_not_reached();
 }
 
-void hmp_info_sev(Monitor *mon, const QDict *qdict)
-{
-    monitor_printf(mon, "SEV is not available in this QEMU\n");
-}
-
 void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size)
 {
 }
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index da9fdc0ab7b..336ab870a2c 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -812,15 +812,14 @@ SRST
     enabled) memory in bytes.
 ERST
 
-#if defined(TARGET_I386)
     {
         .name       = "sev",
         .args_type  = "",
         .params     = "",
         .help       = "show SEV information",
         .cmd        = hmp_info_sev,
+        .arch_bitmask = QEMU_ARCH_I386,
     },
-#endif
 
 SRST
   ``info sev``
diff --git a/stubs/meson.build b/stubs/meson.build
index dc289e3a482..09e73ef8b73 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -84,6 +84,7 @@ if have_system
   stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
+  stub_ss.add(files('hmp-cmd-info_sev.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
   stub_ss.add(files('hmp-cmds-target-i386.c'))
 endif
-- 
2.53.0


