Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A6EC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0n-0004rO-8G; Sat, 27 Jan 2024 23:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0m-0004r8-6A
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:16 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0i-0004N9-Pr
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:15 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-59a1a03d09aso456711eaf.3
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416991; x=1707021791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmzrBNQK2eDwb+/K0EzCDtsTU1SD4iiHNXZIgeBMj8o=;
 b=vRjIfXPxMyRLJTNekl6NbOsj9QO9j8qwiupc70GQDG+iuEWrC/UPeqTlMjqvD9g4Fa
 36RIFoODWN/mYaLKygNxSOh07EuYJ0D/7jJ6qNuqmSEbKcJgocKLGtbjX7zzPw8epU9M
 QUooiGMt7AT/yYbpTVVjYz6axtcEv09kRbtEGeSHOeAXVMdhwfhswQKwXjpjddI2SpgP
 Xk5YDPKj3J26M71lGMsXHNR3PXTsTH2FRBqkoyvXX8Ya/In0t518e20uC0Ek4ZNnKuVT
 n7gO4a0J3A/XfrSZ9Sqyux6yAYF4ZSXDBy1WXXuAqIbuixAd2mBvp0wNyxid5J4Nsuxl
 IvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416991; x=1707021791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmzrBNQK2eDwb+/K0EzCDtsTU1SD4iiHNXZIgeBMj8o=;
 b=l+VWmQSW3c23ZSdR0pjbP651aYSHNK0RRUaADLXVTwz6TfRaufmsEcg56lsVPXzXRv
 TLT3tmw9KfSzvb0jvh6wRvAwzrc7rWpeoUs1zLobuCSEajCX+qwp57y62cdH0X/5mOdO
 hssW/M9alYJECL1lQ4dr/4VyE08bpNpBknn/NHcxOFtSKlFUrgiqfohY41ftxv9IYLak
 J4Mrb0sp5GDdG5OPTTNYDKN3ccfI0pUHOgXb+nmxtzJ8okoZNIwVlw1jWfOkJJzMdg9z
 DtQfmbkzlr/LVSV2QA4ujSjcKm/bx0JvVJE/3B0V3O0VnOGFNXPgoq+za6FJo/pAIX2P
 K83A==
X-Gm-Message-State: AOJu0Yz1GOzzzHpWPxek+4Suuyt4O9CjjiEzH48hgVQD+iJ9anoVCDJa
 bS5rM2g8OFKK1jmcUX1zDIMPZdeTezjJ5SZXrZAsPXQXuTVpRBspppP0mwQ2Rm3Z5Ed12g6r9z6
 3tTWUTg==
X-Google-Smtp-Source: AGHT+IEIwfPUza5qgF0gE06/OTfMMSTGPHQwndJayvLAPrpArArD0DCVNMgMHD01RYIe+YdmmHI/jA==
X-Received: by 2002:a05:6358:16c7:b0:176:8447:63be with SMTP id
 r7-20020a05635816c700b00176844763bemr3324212rwl.55.1706416991424; 
 Sat, 27 Jan 2024 20:43:11 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:43:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 21/33] accel/tcg: Move perf and debuginfo support to tcg/
Date: Sun, 28 Jan 2024 14:42:01 +1000
Message-Id: <20240128044213.316480-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

tcg/ should not depend on accel/tcg/, but perf and debuginfo
support provided by the latter are being used by tcg/tcg.c.

Since that's the only user, move both to tcg/.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231212003837.64090-5-iii@linux.ibm.com>
Message-Id: <20240125054631.78867-5-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 {accel => include}/tcg/debuginfo.h | 4 ++--
 {accel => include}/tcg/perf.h      | 4 ++--
 accel/tcg/translate-all.c          | 2 +-
 hw/core/loader.c                   | 2 +-
 linux-user/elfload.c               | 2 +-
 linux-user/exit.c                  | 2 +-
 linux-user/main.c                  | 2 +-
 system/vl.c                        | 2 +-
 {accel/tcg => tcg}/debuginfo.c     | 3 +--
 {accel/tcg => tcg}/perf.c          | 7 +++----
 tcg/tcg.c                          | 2 +-
 accel/tcg/meson.build              | 4 ----
 tcg/meson.build                    | 5 +++++
 13 files changed, 20 insertions(+), 21 deletions(-)
 rename {accel => include}/tcg/debuginfo.h (96%)
 rename {accel => include}/tcg/perf.h (95%)
 rename {accel/tcg => tcg}/debuginfo.c (98%)
 rename {accel/tcg => tcg}/perf.c (99%)

diff --git a/accel/tcg/debuginfo.h b/include/tcg/debuginfo.h
similarity index 96%
rename from accel/tcg/debuginfo.h
rename to include/tcg/debuginfo.h
index f064e1c144..858535b5da 100644
--- a/accel/tcg/debuginfo.h
+++ b/include/tcg/debuginfo.h
@@ -4,8 +4,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef ACCEL_TCG_DEBUGINFO_H
-#define ACCEL_TCG_DEBUGINFO_H
+#ifndef TCG_DEBUGINFO_H
+#define TCG_DEBUGINFO_H
 
 #include "qemu/bitops.h"
 
diff --git a/accel/tcg/perf.h b/include/tcg/perf.h
similarity index 95%
rename from accel/tcg/perf.h
rename to include/tcg/perf.h
index f92dd52c69..c96b5920a3 100644
--- a/accel/tcg/perf.h
+++ b/include/tcg/perf.h
@@ -4,8 +4,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef ACCEL_TCG_PERF_H
-#define ACCEL_TCG_PERF_H
+#ifndef TCG_PERF_H
+#define TCG_PERF_H
 
 #if defined(CONFIG_TCG) && defined(CONFIG_LINUX)
 /* Start writing perf-<pid>.map. */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 1737bb3da5..1c695efe02 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -63,7 +63,7 @@
 #include "tb-context.h"
 #include "internal-common.h"
 #include "internal-target.h"
-#include "perf.h"
+#include "tcg/perf.h"
 #include "tcg/insn-start-words.h"
 
 TBContext tb_ctx;
diff --git a/hw/core/loader.c b/hw/core/loader.c
index e7a9b3775b..b8e52f3fb0 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -62,7 +62,7 @@
 #include "hw/boards.h"
 #include "qemu/cutils.h"
 #include "sysemu/runstate.h"
-#include "accel/tcg/debuginfo.h"
+#include "tcg/debuginfo.h"
 
 #include <zlib.h>
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index daf7ef8435..b8eef893d0 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "target_signal.h"
-#include "accel/tcg/debuginfo.h"
+#include "tcg/debuginfo.h"
 
 #ifdef TARGET_ARM
 #include "target/arm/cpu-features.h"
diff --git a/linux-user/exit.c b/linux-user/exit.c
index 50266314e0..1ff8fe4f07 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -17,7 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "accel/tcg/perf.h"
+#include "tcg/perf.h"
 #include "gdbstub/syscalls.h"
 #include "qemu.h"
 #include "user-internals.h"
diff --git a/linux-user/main.c b/linux-user/main.c
index c9470eeccf..74b2fbb393 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -54,7 +54,7 @@
 #include "signal-common.h"
 #include "loader.h"
 #include "user-mmap.h"
-#include "accel/tcg/perf.h"
+#include "tcg/perf.h"
 
 #ifdef CONFIG_SEMIHOSTING
 #include "semihosting/semihost.h"
diff --git a/system/vl.c b/system/vl.c
index 788d88ea03..60fd1e56b6 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -96,7 +96,7 @@
 #endif
 #include "sysemu/qtest.h"
 #ifdef CONFIG_TCG
-#include "accel/tcg/perf.h"
+#include "tcg/perf.h"
 #endif
 
 #include "disas/disas.h"
diff --git a/accel/tcg/debuginfo.c b/tcg/debuginfo.c
similarity index 98%
rename from accel/tcg/debuginfo.c
rename to tcg/debuginfo.c
index 71c66d04d1..3753f7ef67 100644
--- a/accel/tcg/debuginfo.c
+++ b/tcg/debuginfo.c
@@ -6,11 +6,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu/lockable.h"
+#include "tcg/debuginfo.h"
 
 #include <elfutils/libdwfl.h>
 
-#include "debuginfo.h"
-
 static QemuMutex lock;
 static Dwfl *dwfl;
 static const Dwfl_Callbacks dwfl_callbacks = {
diff --git a/accel/tcg/perf.c b/tcg/perf.c
similarity index 99%
rename from accel/tcg/perf.c
rename to tcg/perf.c
index 68a46b1b52..412a987d95 100644
--- a/accel/tcg/perf.c
+++ b/tcg/perf.c
@@ -11,13 +11,12 @@
 #include "qemu/osdep.h"
 #include "elf.h"
 #include "exec/target_page.h"
-#include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "qemu/timer.h"
+#include "tcg/debuginfo.h"
+#include "tcg/perf.h"
 #include "tcg/tcg.h"
 
-#include "debuginfo.h"
-#include "perf.h"
-
 static FILE *safe_fopen_w(const char *path)
 {
     int saved_errno;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e2c38f6d11..eeff4c1d51 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -55,7 +55,7 @@
 #include "tcg/tcg-ldst.h"
 #include "tcg/tcg-temp-internal.h"
 #include "tcg-internal.h"
-#include "accel/tcg/perf.h"
+#include "tcg/perf.h"
 #ifdef CONFIG_USER_ONLY
 #include "exec/user/guest-base.h"
 #endif
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index c15ac9ac8f..46f7d53eeb 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -16,10 +16,6 @@ tcg_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
 if get_option('plugins')
   tcg_ss.add(files('plugin-gen.c'))
 endif
-tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
-if host_os == 'linux'
-  tcg_ss.add(files('perf.c'))
-endif
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
diff --git a/tcg/meson.build b/tcg/meson.build
index 5afdec1e1a..8251589fd4 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -22,6 +22,11 @@ if get_option('tcg_interpreter')
   tcg_ss.add(files('tci.c'))
 endif
 
+tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
+if host_os == 'linux'
+  tcg_ss.add(files('perf.c'))
+endif
+
 tcg_ss = tcg_ss.apply({})
 
 libtcg_user = static_library('tcg_user',
-- 
2.34.1


