Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21790C369CF
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pWn-00028B-OI; Fri, 18 Apr 2025 13:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pWl-00027s-He
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pWj-0008J0-CP
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso15472265e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997359; x=1745602159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHO81WMTDdR6HpW0S2Vp1ELnicrpI5yyRuKdwopAMDM=;
 b=mqtAv8UXgJvgrxoWr3OyPdfwEPVYfRH72X29A/AxYdwxDO0ZfssxQfCJQBGR4/elQ+
 l6l8SEAqlAM2zmqF7MYOwGfgFTI7vK0kNSMgR+9Pxded1o2FDujooB/Mnwjt4mAoGqst
 7N4FVIi9aCheToHyYhRT9L+lVKshPHO8JUwh72BOnEXFFfU3g0vwgLEHaQQvFzarahiE
 SQLd5Zh0lgy7FKWhu6lbjOBkViPcGH7O/dq1T4+p4tqLBCd1mIe+vTZE9PHX/iBv9aUq
 8/o2yN4o234TSAIHThwdmGvP6+IHi6jv63JLCKWXVdGCYorMPwVuw+MfD+0yiVzrRjCi
 0mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997359; x=1745602159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eHO81WMTDdR6HpW0S2Vp1ELnicrpI5yyRuKdwopAMDM=;
 b=iD/LxcniG8ExA3UOhAxOlhbQmRroxNGpJ3i/hKITTc30SJNr684CLPrLX1gC/jwm9Y
 gufCtCp9z9BQY6lzTN/hVgCrDqypBkOAgsG6H6wateN3UOw6d/6LL26rz9e0Z6Vj4WBv
 x51Hh5z+vNLnzlIGoOqxfpx1cuctYmtYnFwVXfA1ncEh3kRprxEWP1MewiiUGGdunzkr
 VGlYZ+IO3KxzUUcqCoo5X255Wh/LBXtxQdc8rK3Mnz7tca/xWlfbHVm3nXlrReOAfwQr
 IzRpWZaSgQ6uwa+zYhvLlQgB4gSlya5qOk6vpUDLb81CqwuV3RowpvbKB2y6XthfHu6B
 mLnQ==
X-Gm-Message-State: AOJu0YwahBUxkw3X4YAoetBBFEuR2/uenUUswkXZ076QM2KzaBdH+qn4
 LmVjGvUBWdcoxK3iLz3aq2Fv05DQlCdUw8yAVjo/XNNXOfsIB9GUar5G1Vs5ptqbtvMiqi1sItl
 A
X-Gm-Gg: ASbGncutxVkHhBC6U1Kgfy6Ugh8iWZ1KBO4mRs6dwFeH5WgfJOPq45aEmL/ze4VKQ4f
 0xVY5sdJvQsGKt0NPua3m9xkJRqt8/pQ9LQw7TLgK6U6KCVH9aef+R9Tv+qCALGKYuAiTR9zKfs
 qyYAuYdGfrqyopt3Gc2f49O7fP23/+70FIWAeC1QXkP5SYnuIs2z3ExDdt8VtaLC0Zz9AZBm5LP
 DqgACF0tvHQYugqOw1Gh2sAr4+USrj2h38AzeU9C3pCsnd5t0hBbK6msIojR/Mwt3BNtYYrIZiq
 M3nz7HDZkC5vc1RnCMu5eFyIbl7zBw70lXd5vqbqpLqZLISY0gVuRH6pN38gLpm2/X3LZFbNyz3
 tKV5yVNbZzhQBC8I=
X-Google-Smtp-Source: AGHT+IGVTMzbz9FnpIBVbpITnXyXDwNZNW2re5BkYZ5lcMpUfBA/gS3nJh4sP2A7LS+MEGJ02ETSmg==
X-Received: by 2002:a05:600c:1d02:b0:439:86fb:7340 with SMTP id
 5b1f17b1804b1-4406ac412c4mr32987255e9.30.1744997359450; 
 Fri, 18 Apr 2025 10:29:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4332f8sm3275516f8f.40.2025.04.18.10.29.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Apr 2025 10:29:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v3 02/14] qemu: Convert target_name() to TargetInfo API
Date: Fri, 18 Apr 2025 19:28:56 +0200
Message-ID: <20250418172908.25147-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418172908.25147-1-philmd@linaro.org>
References: <20250418172908.25147-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Have target_name() be a target-agnostic method, dispatching
to a per-target TargetInfo singleton structure.
By default a stub singleton is used. No logical change
expected.

Inspired-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                     |  3 +++
 include/hw/core/cpu.h           |  2 --
 include/qemu/target_info-impl.h | 23 +++++++++++++++++++++++
 include/qemu/target_info.h      | 19 +++++++++++++++++++
 cpu-target.c                    |  5 -----
 hw/core/machine-qmp-cmds.c      |  1 +
 plugins/loader.c                |  2 +-
 system/vl.c                     |  2 +-
 target_info-stub.c              | 19 +++++++++++++++++++
 target_info.c                   | 16 ++++++++++++++++
 10 files changed, 83 insertions(+), 9 deletions(-)
 create mode 100644 include/qemu/target_info-impl.h
 create mode 100644 include/qemu/target_info.h
 create mode 100644 target_info-stub.c
 create mode 100644 target_info.c

diff --git a/meson.build b/meson.build
index bcb9d39a387..49a050a28a3 100644
--- a/meson.build
+++ b/meson.build
@@ -3807,6 +3807,9 @@ endif
 common_ss.add(pagevary)
 specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
+common_ss.add(files('target_info.c'))
+specific_ss.add(files('target_info-stub.c'))
+
 subdir('backends')
 subdir('disas')
 subdir('migration')
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5b645df59f5..9d9448341d1 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1115,8 +1115,6 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
 
-const char *target_name(void);
-
 #ifdef COMPILING_PER_TARGET
 
 extern const VMStateDescription vmstate_cpu_common;
diff --git a/include/qemu/target_info-impl.h b/include/qemu/target_info-impl.h
new file mode 100644
index 00000000000..11b92796b28
--- /dev/null
+++ b/include/qemu/target_info-impl.h
@@ -0,0 +1,23 @@
+/*
+ * QEMU binary/target API ...
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_INFO_IMPL_H
+#define QEMU_TARGET_INFO_IMPL_H
+
+#include "qemu/target_info.h"
+
+typedef struct TargetInfo {
+
+    /* runtime equivalent of TARGET_NAME definition */
+    const char *const target_name;
+
+} TargetInfo;
+
+const TargetInfo *target_info(void);
+
+#endif
diff --git a/include/qemu/target_info.h b/include/qemu/target_info.h
new file mode 100644
index 00000000000..3f6cbbbd300
--- /dev/null
+++ b/include/qemu/target_info.h
@@ -0,0 +1,19 @@
+/*
+ * QEMU binary/target API
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_INFO_H
+#define QEMU_TARGET_INFO_H
+
+/**
+ * target_name:
+ *
+ * Returns: Canonical target name (i.e. "i386").
+ */
+const char *target_name(void);
+
+#endif
diff --git a/cpu-target.c b/cpu-target.c
index c99d208a7c4..3f82d3ea444 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -165,8 +165,3 @@ bool target_words_bigendian(void)
 {
     return TARGET_BIG_ENDIAN;
 }
-
-const char *target_name(void)
-{
-    return TARGET_NAME;
-}
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 408994b67d7..b317aec234f 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -19,6 +19,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
+#include "qemu/target_info.h"
 #include "qom/qom-qobject.h"
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
diff --git a/plugins/loader.c b/plugins/loader.c
index 7523d554f03..36a4e88d4db 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -29,7 +29,7 @@
 #include "qemu/xxhash.h"
 #include "qemu/plugin.h"
 #include "qemu/memalign.h"
-#include "hw/core/cpu.h"
+#include "qemu/target_info.h"
 #include "exec/tb-flush.h"
 
 #include "plugin.h"
diff --git a/system/vl.c b/system/vl.c
index c17945c4939..d8a0fe713c9 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -40,6 +40,7 @@
 #include "qemu/help_option.h"
 #include "qemu/hw-version.h"
 #include "qemu/uuid.h"
+#include "qemu/target_info.h"
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/runstate-action.h"
@@ -79,7 +80,6 @@
 #include "hw/block/block.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
-#include "hw/core/cpu.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
diff --git a/target_info-stub.c b/target_info-stub.c
new file mode 100644
index 00000000000..f15972c5b22
--- /dev/null
+++ b/target_info-stub.c
@@ -0,0 +1,19 @@
+/*
+ * QEMU target info stubs
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target_info-impl.h"
+
+static const TargetInfo target_info_stub = {
+    .target_name = TARGET_NAME,
+};
+
+const TargetInfo *target_info(void)
+{
+    return &target_info_stub;
+}
diff --git a/target_info.c b/target_info.c
new file mode 100644
index 00000000000..48c4a413326
--- /dev/null
+++ b/target_info.c
@@ -0,0 +1,16 @@
+/*
+ * QEMU binary/target helpers
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target_info-impl.h"
+#include "qemu/target_info.h"
+
+const char *target_name(void)
+{
+    return target_info()->target_name;
+}
-- 
2.47.1


