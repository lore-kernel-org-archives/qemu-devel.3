Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE456FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO87-0001OP-NX; Wed, 25 Feb 2026 18:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO7m-0000E6-Bb
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:04 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO7k-0002uy-DE
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:16:57 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48375f10628so1975835e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061414; x=1772666214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8d2psbmGyOVphBVX1NfJBGYgRY3I8LcfiQSJmuK6PWg=;
 b=a9RM7G5XslP1qWzIutunfr0y0YwI7RZuew7Qn3HHn5yFFow9RbAdPKe4EL77g8nlHX
 7tRdrf7sczKpm91Vb2GOtJWZxed+aE4bPJhBq+oGu9YHmxKjVCHxuXqhDD5jITSTJLq3
 QmyFxHOvyvmo7tRE4sD1kJp1VPx7mQXXUlymHepXJbvWhIcb8BF1lG7aVa+8k4nW70wT
 N67QQUHgGGmH2uFt8lgydhD7yYvuWHNvruXQUOn5goedCbvEt61E3rkD5jB6zNA3DQja
 kHPVFQ5SqG9DkuH0tH6BDvEyP0heSBOHE/PC4om5ROVncr/xBk4k15E+1J6LSONRZwK2
 gT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061414; x=1772666214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8d2psbmGyOVphBVX1NfJBGYgRY3I8LcfiQSJmuK6PWg=;
 b=oB4RE1vVEujkPAXHhklw9LxZeOGNQMPqCY031dmqzRgYKzyt0V6mODvJ8r4ncfzHHY
 9PhyHVyeWRFd3JlT+QTKRFYj9vzLriX6SjxgwpP1eV9qMoAuvhlS0MJaVeFESckC2ZsN
 wLlWBI3lqCeGJp70Rw+tUfQdV/HlCI5rHy63gxELxOge7UMoZMcZZtLFuQ8pBYr2FAaH
 HAmLm8fo78wN/fMHYIkpZ3M++YixU8WEjdwxYH/z4O9EHqiGLy4yd3i6RFQo+xdAzWm4
 1dmwPcQ4oWLYth1Rp52YcVjB2LoOLuQT2I0odp0Z5o45B0LLpXQG9HUWnVDAdIZ3NoEv
 XIKw==
X-Gm-Message-State: AOJu0YwAxdf46zqadrqbx9VYVPZefGgGznFnURyCT+4xmUPQUyWTP0eN
 C8g7m5QbPbR82hTk4SGoeXTmOl+YMh44sGJ2ANsdlJpCrW6FbO6ruCUUakWv2FlaL7iJBs2E+7U
 8WY3ZV4E=
X-Gm-Gg: ATEYQzyGMv6edfuOxPRHe6aCvDqxzgbc0sFzcMcmzYJP5RUmvRfrLPrzL3ZFd2TyQkH
 HOVjsmkuLkYBZVMScy+PmEUIbzj3+lIGdgi/07nan717wAGGjks43drIdsQ46rFszt5pSdSDlsp
 GC/rCplIrWJsMU/l28XFWAKgVe+UMqWWokt9/sl5LUk2V1kBEt/85LkwGe0GDOs5l8oIoIjkLtA
 6P042jFAh4zQHUE9Jx2XyagEU/UIC+ExknUEJuE3R0vF4SqbDDbekoXpS4AZn0N2LeXhjyvBL4/
 N9kT2DeKqSpXGZDbyWeG3aXB2RNsbF2O7UGvX4f5IYeK4LdSN6ZRXxoXZvPcH7yDiM8GIJBPUbO
 hkoy3uWmQZ35c7Gid41qnLSOlX+RUbAI/vT3A+ZIA8pizJL/Cc1erfJQuCmzhbrnlTG2WvhIDgQ
 I3d8vG8uasuiTBKZ5omWHCZg0xGrI62ZNGEbAJiPU7BYUknW0yC1Dt7oejuDV7g9aagq2hhFJo
X-Received: by 2002:a05:600c:4f94:b0:480:4a4f:c36f with SMTP id
 5b1f17b1804b1-483a95e2488mr288125315e9.21.1772061414293; 
 Wed, 25 Feb 2026 15:16:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd70e692sm98457885e9.7.2026.02.25.15.16.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:16:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/70] monitor/hmp: Handle gdb-xml exposed registers via
 gdb_get_register()
Date: Thu, 26 Feb 2026 00:13:24 +0100
Message-ID: <20260225231411.96482-25-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Implement the gdb_get_register() helper and call it before the
regular get_monitor_def() one. Registers is exposed via the
GDB XML files will be directly handled, possibily allowing new
registers added to XML files to be automatically accessible in
QEMU monitor. All targets having GDB XML files can now be used
within the monitor.

For example with Loongarch, before:

  $ qemu-system-loongarch64 -M virt -S -monitor stdio
  QEMU 10.2.0 monitor - type 'help' for more information

  (qemu) info registers

  CPU#0
   PC=000000001c000000  FCSR0 0x00000000
   ...

  (qemu) p/x $pc
  unknown register
  Try "help p" for more information
  (qemu)

and after:

  $ ./qemu-system-loongarch64 -M virt -S -monitor stdio
  QEMU 10.2.50 monitor - type 'help' for more information
  (qemu) p/x $pc
  0x1c000000
  (qemu)

Similarly RISC-V:

  QEMU 10.2.0 monitor - type 'help' for more information
  (qemu) p/x $pc
  unknown register
  Try "help p" for more information

VS

  QEMU 10.2.50 monitor - type 'help' for more information
  (qemu) p/x $pc
  0x1000
  (qemu)

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-17-philmd@linaro.org>
---
 monitor/hmp.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 0a5bbf82197..0e5913fabb1 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -27,14 +27,18 @@
 #include "hw/core/qdev.h"
 #include "monitor-internal.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-target.h"
 #include "qobject/qdict.h"
 #include "qobject/qnum.h"
+#include "qemu/bswap.h"
 #include "qemu/config-file.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/option.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
+#include "exec/gdbstub.h"
 #include "system/block-backend.h"
 #include "trace.h"
 
@@ -306,6 +310,46 @@ void hmp_help_cmd(Monitor *mon, const char *name)
     free_cmdline_args(args, nb_args);
 }
 
+/*
+ * Set @pval to the value in the register identified by @name.
+ * return %true if the register is found, %false otherwise.
+ */
+static bool gdb_get_register(Monitor *mon, int64_t *pval, const char *name)
+{
+    g_autoptr(GArray) regs = NULL;
+    CPUState *cs = mon_get_cpu(mon);
+
+    if (cs == NULL) {
+        return false;
+    }
+
+    regs = gdb_get_register_list(cs);
+
+    for (int i = 0; i < regs->len; i++) {
+        GDBRegDesc *reg = &g_array_index(regs, GDBRegDesc, i);
+        g_autoptr(GByteArray) buf = NULL;
+        int reg_size;
+
+        if (!reg->name || g_strcmp0(name, reg->name)) {
+            continue;
+        }
+
+        buf = g_byte_array_new();
+        reg_size = gdb_read_register(cs, buf, reg->gdb_reg);
+        if (reg_size > sizeof(*pval)) {
+            return false;
+        }
+
+        if (target_big_endian()) {
+            *pval = ldn_be_p(buf->data, reg_size);
+        } else {
+            *pval = ldn_le_p(buf->data, reg_size);
+        }
+        return true;
+    }
+    return false;
+}
+
 /*******************************************************************/
 
 static const char *pch;
@@ -338,7 +382,6 @@ static int64_t expr_unary(Monitor *mon)
 {
     int64_t n;
     char *p;
-    int ret;
 
     switch (*pch) {
     case '+':
@@ -393,8 +436,8 @@ static int64_t expr_unary(Monitor *mon)
                 pch++;
             }
             *q = 0;
-            ret = get_monitor_def(mon, &reg, buf);
-            if (ret < 0) {
+            if (!gdb_get_register(mon, &reg, buf)
+                && get_monitor_def(mon, &reg, buf) < 0) {
                 expr_error(mon, "unknown register");
             }
             n = reg;
-- 
2.52.0


