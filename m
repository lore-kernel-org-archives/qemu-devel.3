Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FEEC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 07:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSY7o-0001df-0u; Wed, 24 Jan 2024 02:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSY7j-0001Z5-1t
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:56:40 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSY7g-0005Ur-WA
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:56:38 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a31092083acso62205366b.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 23:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706082995; x=1706687795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prVP50+y3lyE2N1LPnQRqeEggvTqD8gqLUeNHLmJDyg=;
 b=nQRqEQTz4S2r/v8wQjdX42JGYpkO+Z5x4jpj/6mN0P4P5bi1cDyJKHXt9M2CwXAY/f
 zTXMAQzeXjE8uMc59rlsnNjlZ09LKn2IkRpM0ovbqUABTAejTx5B0br/qa/y4qE317kP
 wfJ6ORcnI529aaO2GNRapVgcF6lg23E2Dg0Cttpi32ObCeRwm4qKAtLFkLWnSkT5d7uP
 XT3fS+tYhTUwU0KU+d3aWGu43xRtpc8wfDes6J6b+/rjx3QcZ9kSJLaKhr3Ck3CxKfpb
 bsfiJLhRX5tulczKb+lXpmcUxh+RhbCKNagaUW718DJusCXveizDhdDPlsND1WcnIqvA
 OWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706082995; x=1706687795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prVP50+y3lyE2N1LPnQRqeEggvTqD8gqLUeNHLmJDyg=;
 b=awPIDSnXXjqMxrzSfDksdWx8xh7hMxMU9W2NURK8npGN30liCm5L6fU+/ENSJLISdg
 ZCfm9k+gYkiRVtOnOXFWFhLOb1Z2Qch1np7XqiSqfd0YzBUcuCngF83mJibTDOi36UUH
 WF7xlQO9AYuQftSUDQ3TDKnrTMmEYP8XhmQDzTX/ebaJE+s+AcWp8/talPKMsDFPC7SJ
 CvIvhOOA2tigEiSQ8pWhF9I1qhC7gVSk1PqoC1WBV1p2ViVzK0EnoVNmKfpo1ASwOfFk
 2eiC8cEGZHKMUIe8gT0uX0KXZK6LyMsCXObXfkIAeyOKDF6LYS7XzYWWLMR8pih8oIJ9
 yxxA==
X-Gm-Message-State: AOJu0YzF+33vogr75p78/5QhRSp6y6Xs3V/VelxiLcNucW8aSLDXlh7Z
 ZQjoXF8mM1icTsGG5+0pyxs8WA7LHph6++JWYtVKG4ti16uwPtVkC2V1JNAmzr7eSlj6867H2Yk
 l
X-Google-Smtp-Source: AGHT+IFiyn0aTqu6bug+ATPhglyTwiilOR3hOgGWHJBqF+lOyQIPJ/XXPS4icyfPlNv21wF7kg4Dfg==
X-Received: by 2002:a17:907:1250:b0:a30:ebfd:581c with SMTP id
 wc16-20020a170907125000b00a30ebfd581cmr491505ejb.78.1706082994823; 
 Tue, 23 Jan 2024 23:56:34 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 vx6-20020a170907a78600b00a311a360433sm395865ejc.143.2024.01.23.23.56.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 23:56:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v5 4/4] accel/tcg: Move perf and debuginfo support to tcg
Date: Wed, 24 Jan 2024 08:56:09 +0100
Message-ID: <20240124075609.14756-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124075609.14756-1-philmd@linaro.org>
References: <20240124075609.14756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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
Message-ID: <20231208003754.3688038-5-iii@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 {accel/tcg => tcg}/debuginfo.h | 4 ++--
 {accel/tcg => tcg}/perf.h      | 4 ++--
 accel/tcg/translate-all.c      | 2 +-
 hw/core/loader.c               | 2 +-
 linux-user/elfload.c           | 2 +-
 linux-user/exit.c              | 2 +-
 linux-user/main.c              | 2 +-
 system/vl.c                    | 2 +-
 {accel/tcg => tcg}/debuginfo.c | 0
 {accel/tcg => tcg}/perf.c      | 2 +-
 tcg/tcg.c                      | 2 +-
 accel/tcg/meson.build          | 4 ----
 tcg/meson.build                | 5 +++++
 13 files changed, 17 insertions(+), 16 deletions(-)
 rename {accel/tcg => tcg}/debuginfo.h (96%)
 rename {accel/tcg => tcg}/perf.h (95%)
 rename {accel/tcg => tcg}/debuginfo.c (100%)
 rename {accel/tcg => tcg}/perf.c (99%)

diff --git a/accel/tcg/debuginfo.h b/tcg/debuginfo.h
similarity index 96%
rename from accel/tcg/debuginfo.h
rename to tcg/debuginfo.h
index f064e1c144..858535b5da 100644
--- a/accel/tcg/debuginfo.h
+++ b/tcg/debuginfo.h
@@ -4,8 +4,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef ACCEL_TCG_DEBUGINFO_H
-#define ACCEL_TCG_DEBUGINFO_H
+#ifndef TCG_DEBUGINFO_H
+#define TCG_DEBUGINFO_H
 
 #include "qemu/bitops.h"
 
diff --git a/accel/tcg/perf.h b/tcg/perf.h
similarity index 95%
rename from accel/tcg/perf.h
rename to tcg/perf.h
index f92dd52c69..c96b5920a3 100644
--- a/accel/tcg/perf.h
+++ b/tcg/perf.h
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
similarity index 100%
rename from accel/tcg/debuginfo.c
rename to tcg/debuginfo.c
diff --git a/accel/tcg/perf.c b/tcg/perf.c
similarity index 99%
rename from accel/tcg/perf.c
rename to tcg/perf.c
index 68a46b1b52..de34248d92 100644
--- a/accel/tcg/perf.c
+++ b/tcg/perf.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "elf.h"
 #include "exec/target_page.h"
-#include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "qemu/timer.h"
 #include "tcg/tcg.h"
 
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


