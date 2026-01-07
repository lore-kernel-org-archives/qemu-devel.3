Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFACD0D151
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 18:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdXvW-0001Bk-FU; Wed, 07 Jan 2026 13:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdXun-0000d9-8u
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 13:05:51 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdXuk-0001WM-VP
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 13:05:48 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so20941045e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 10:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767809137; x=1768413937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EU979OOA11vwfaGt246n4U8ewDaOQgWEOM4SzB3CSP0=;
 b=ii61CgJaVLllAOefgHv6ArQWDEjJDFmvyt5g2Ycw/Et/R/c/wel+Nz3ctsxq8oTst5
 YgZLrM3ZqvHJitjSv9U91sb/7FehaetqdUTFzDi4YChMRZNVeB3+VsfJF9uzlRXf1GdQ
 93K4y85M/iOP4RGsESZmCEie3sFYhX3p8eCfQjVf3hOipFFRyXzMHc4wHVLxSk+K7CxM
 /GzXu8OPW3p7oBAQPnubkHItNGcfE8L8FMRwQBaSi0uRHBL9xYC6dsC4e34L5yBPS27F
 B49V20qBS8aaZNPeHsORGwvD7nPWASmHX6Fq3diN15P+RxNxipd2VacLCIEQk9rX8POJ
 jiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767809137; x=1768413937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EU979OOA11vwfaGt246n4U8ewDaOQgWEOM4SzB3CSP0=;
 b=uoZCyx2wAUSBSUIK3SfP6HKNcOvp3uatrItg0hsf0NyhhCtWxffBtJmznrl8tKuBIF
 0usqEGAQGB9+J6nJj7tggG8oox9Fc7wzmON/ZJ2eb0mONb3Pm4KR0GJlGd8apd7mVxMR
 O8SRW1dCetRhaVCX8fu5n5Avf6DEN0o4XXaE68ICPa85uBOeaXbBBQHgmzPvM8G1oX0f
 l2t7yRdoLUj5GfcLHhdzB+2UvyAYjf8+mCpOIhMjG/WT+Rl6bkF+9C/BULP7t8wT1Kr8
 /FSRbvlYvQHYs1JwY84ZL/4jCL4nFnDWSIWbQKLqnyM4zbGIfIQAlW/g9ZOSRjocyC6R
 N4+g==
X-Gm-Message-State: AOJu0YwM4laFR/trZA6zZkfiyBOkTyCDtundvWk1bvmWy9IDXd3vN5V2
 XR5yDL24Pi0Gp7zv2DA5rS4qzcwb/mRj1Rp+3i11vC7kaS5y7EAdWVvSRIjUskj1AjytYNlPVcc
 N5EyrdGc=
X-Gm-Gg: AY/fxX5MgJszLqAzMMTjENDcdxcB6hu9RE90Gxr/rizc30JFkmdJAWyTgoG5qq+fwpB
 KWgUaYoGGjN18YVCEtPjKmPluGSVt1hpWd9IMpUDmGMNRxVlAFKi5hMj6BhiMpgWqPYDoY36vQM
 gZlok1G+U+ltkhpfdooq/er5BxhXsXqsBkPGJ1RSgmBOzhCwcZYYi1lfRyi8JrFx1qrtdCKaGWU
 bI6gZaJBCqqqZEi0/E2dAS1coQwboHjr+QJaE83D6OPrV7cl9vVfx/lwXYkSm6i5gI5JuoFbwFJ
 77UdA47oLcxD88NnlTH8xF0wr1MNYYhEiePImZ9SPEH4emjQKdIiwtiiFGgeLSwQjc1yBpQittU
 5RSVeDx38neVKHSDPYpmwJqOkwIT12GvW1cNhJjwHwDwCNb2rydPSlr+OaZlaBDBK/PF8eXKsnX
 Ev0nKPloykN4/vlsM0SC95lSgWlfofLKm/7hCtaxZn2LGwPzaAVhKCAy8ipuc7
X-Google-Smtp-Source: AGHT+IGqEa+zTFF8xgbeKwVtKwooYQoG+996GL0Ry8vTUKi8E5GmSsf5CEug22hZbIMekpwRimpI7g==
X-Received: by 2002:a05:600c:190e:b0:479:3a88:de60 with SMTP id
 5b1f17b1804b1-47d84b3fa79mr34558745e9.37.1767809137158; 
 Wed, 07 Jan 2026 10:05:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f4ddsm114653225e9.2.2026.01.07.10.05.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 10:05:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] dump/win_dump: Use stubs on non-Windows hosts like POSIX
Date: Wed,  7 Jan 2026 19:05:19 +0100
Message-ID: <20260107180519.50820-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107180519.50820-1-philmd@linaro.org>
References: <20260107180519.50820-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Rather than compiling the same content for all targets (unused
most of the time, i.e. qemu-system-avr ...), build it once per
POSIX hosts. Check Windows host (less likely) before x86 host.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 dump/win_dump-stubs.c | 21 +++++++++++++++++++++
 dump/win_dump.c       | 12 ++++++++----
 dump/meson.build      |  6 +++++-
 3 files changed, 34 insertions(+), 5 deletions(-)
 create mode 100644 dump/win_dump-stubs.c

diff --git a/dump/win_dump-stubs.c b/dump/win_dump-stubs.c
new file mode 100644
index 00000000000..722c66740a2
--- /dev/null
+++ b/dump/win_dump-stubs.c
@@ -0,0 +1,21 @@
+/*
+ * Windows crashdump stubs
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "win_dump.h"
+
+bool win_dump_available(Error **errp)
+{
+    error_setg(errp, "Windows dump is only available on Windows");
+
+    return false;
+}
+
+void create_win_dump(DumpState *s, Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/dump/win_dump.c b/dump/win_dump.c
index 6e07913dfb4..5b2b55d9ff7 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump.c
@@ -12,14 +12,16 @@
 #include "system/dump.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "win_dump.h"
+
+#ifdef CONFIG_WIN32
+#if defined(TARGET_X86_64)
+
 #include "exec/cpu-defs.h"
 #include "hw/core/cpu.h"
 #include "qemu/win_dump_defs.h"
-#include "win_dump.h"
 #include "cpu.h"
 
-#if defined(TARGET_X86_64)
-
 bool win_dump_available(Error **errp)
 {
     return true;
@@ -478,7 +480,9 @@ out_cr3:
     first_x86_cpu->env.cr[3] = saved_cr3;
 }
 
-#else /* !TARGET_X86_64 */
+#endif /* !TARGET_X86_64 */
+
+#else /* !CONFIG_WIN32 */
 
 bool win_dump_available(Error **errp)
 {
diff --git a/dump/meson.build b/dump/meson.build
index 4277ce9328a..0aaf3f65d9c 100644
--- a/dump/meson.build
+++ b/dump/meson.build
@@ -1,2 +1,6 @@
 system_ss.add([files('dump.c', 'dump-hmp-cmds.c'), snappy, lzo])
-specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: files('win_dump.c'))
+if host_os == 'windows'
+  system_ss.add(files('win_dump.c'))
+else
+  system_ss.add(files('win_dump-stubs.c'))
+endif
-- 
2.52.0


