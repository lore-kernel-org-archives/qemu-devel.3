Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B78C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 05:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSsZp-0007qQ-K8; Thu, 25 Jan 2024 00:47:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSsZo-0007qG-FM
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 00:47:00 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSsZm-0008C8-C5
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 00:47:00 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e9101b5f9so69802385e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 21:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706161617; x=1706766417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AgoSHvj3ItDsNB7xFCor4QnrVXlVBkw1Thjsp8Wtfjk=;
 b=gB472eggtugrdtFfXOJbeMGTw0ff5kTewRCsTJB6t8CuB6Tek1ou0VpsPJZqjWwfDZ
 3YZv0Ndr5UA8qYZAcug+rxfKbWr3H3sq9fHAyfQGO98qX7gDLGwL4tyiGCBd+zASiKqo
 dZm5lVz3at/cU10tPDaH8hB065oThtAwp47l5B+PAdGy/k6QVSQQOMN8xq4V1iea6K2c
 DBUTruo2q8RY2LRp7qqNW9Crsam8pj6krp6ytPlR4f66gH0jx985Elmh/2nT8jUv+Ew5
 c8Tz26M3ccpkgyyy+y/Zxm3cNZFR1vMXOBC8BkqasDemX7Vz83AiaazuPpKVNAFu3mKU
 1Ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706161617; x=1706766417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AgoSHvj3ItDsNB7xFCor4QnrVXlVBkw1Thjsp8Wtfjk=;
 b=M9WahJfyUE7/tOftMnJpo0jAGhJIjABK1sbfG6zzkd2ZA+JSzkLrmv423qkUFUVj7v
 qERaDUNQA2RlJXnqxv7yQIqLFO47DDqC7wo2SigyjHC6jbwB0hodBKfTPzTLkF/nf5t6
 45qgsob+ysD3bxLZVz+Tc8z4+Ca9/ftQIIjmj6gRpTC3cQ+Z9q1HqNQQPduBgwc00/h4
 f8Zv6EdmtOds3gmJaM7dPPqmSHTevuqEfTD5e4WYsjVsboEm6RX6R4pSvroK//owSbqM
 TphvpIVFnuVdteKMF8SiSls3SyZLHOZ/b12vFLcQd8OKLGcFRQ0S4oyhJfSVTWLW5Fzu
 Kiew==
X-Gm-Message-State: AOJu0YzkdwMYMBoMrspwpy0cwEfAniAijT+WY9fx53xLVqEBPSqOmUq8
 EBlxZYIBUvvVxj2ntysFN8c+sq5j/LX1UMOaM+vUjrqVuCa/GVq/mNIkKIseVjf4PVCpz9KHdv+
 0
X-Google-Smtp-Source: AGHT+IFdbvvGiMKYLY3agfYm8GefUuSGH2OMVqpZG+2xWFEHK7On+jjot4mmTZp3SUYmB50WBmCcog==
X-Received: by 2002:a05:600c:4694:b0:40d:271e:67bc with SMTP id
 p20-20020a05600c469400b0040d271e67bcmr170448wmo.112.1706161616842; 
 Wed, 24 Jan 2024 21:46:56 -0800 (PST)
Received: from m1x-phil.lan (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 iv16-20020a05600c549000b0040e3635ca65sm1242378wmb.2.2024.01.24.21.46.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 21:46:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 4/4] accel/tcg: Move perf and debuginfo support to tcg/
Date: Thu, 25 Jan 2024 06:46:30 +0100
Message-ID: <20240125054631.78867-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240125054631.78867-1-philmd@linaro.org>
References: <20240125054631.78867-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
index cf9e74468b..62120c7615 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -21,7 +21,7 @@
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
2.41.0


