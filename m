Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8B9C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 05:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN42u-0003IA-4T; Fri, 28 Jun 2024 01:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN42t-0003Ho-4M
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:21:15 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN42r-0008EH-85
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:21:14 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-376069031c7so1010535ab.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 22:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719552071; x=1720156871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzx9s/7tqo4YbR/masBSAAi0+ITK6Y2yWNbJ1lluZfs=;
 b=UixxqV6CXuedhc/nA47FrFX7TBR7AikBuPxRT6OTneXpM0HenYwM0EFFPUZ7IK0nON
 iu65h2mOSs4nRgtQ8+Ejz5C0bDhrhDWw1H7g9aG0vPcTm8ofIqi8ue+soj27X+Z3eL3r
 xtslxYh8Y9YkRQhAo9IoD4j7FQ5p8VGXPdPSuNl6PWhhgTSoYlkN5e/Z5/u7LlCugjjE
 B18czyX8a/HVl/z2EF+IYTyE5+X3C1GhCu0PyzgizdlFC/cIN9ftfNRBl6KMxMlIjKDN
 scXVvXHcLJ2FFHnktez+v74BFnMTmyv2x8jm6XcqWZn8RHqJYedYinlzYT3meCBCoPH0
 aMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719552071; x=1720156871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzx9s/7tqo4YbR/masBSAAi0+ITK6Y2yWNbJ1lluZfs=;
 b=hHQR+klX8oYnH7pNvGCYoC1natcAe7hN6ZZ1+onDtJMDSkWSJHNyPFg/B8SyN7ttQE
 9jnGIgIHKVmtRv/L16Y4kNq1jGNonwaWvJtlMv1zrSEDuUrZYqU7Ww8tlgq5t9qGGbto
 27MbFPrdhZIOrFKkA45RxXvO0Nx1wMNpp25TdJI0Wu03ZTrsdY+rbG/j5yETGraYDvfj
 Y0d1b5LGVK9cOekuOo0i5RGSA//vLMa4I4m9n1YZ1EgQp5dFS71AemSoeqUSU7BL2S0J
 3UuzDk3hM+BH1VoJ6Yh8BoVpKE6C81BL9H9VGSPi45pSsCoaZBYzrrbTn1LmHPo9CSa7
 8Paw==
X-Gm-Message-State: AOJu0YxnIdyvRXCtYYmgVXyZOuY5jhMjMfCcmywEjr+VX9Yx3dOrRhYV
 tn2jLkTq6WsPxQDj58LeKozJxBoqIT5mITLZh3r4AWIcsLrb8dbKxqlji4ZKqysqHSbqUh3Su/n
 A
X-Google-Smtp-Source: AGHT+IGtNc4lmd3qRbsGnwqqKYVf7z+F/y+KbJNlqwnGVkQS0HR70scpB6GH9YRDYCmlpajV99Z/XA==
X-Received: by 2002:a05:6e02:1c8c:b0:376:2934:f570 with SMTP id
 e9e14a558f8ab-3763df8d464mr207671565ab.9.1719552071437; 
 Thu, 27 Jun 2024 22:21:11 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:391e:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6b2a16cdsm423932a12.46.2024.06.27.22.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 22:21:10 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 06/11] target/arm: Factor out code for setting MTE TCF0
 field
Date: Fri, 28 Jun 2024 05:08:45 +0000
Message-Id: <20240628050850.536447-7-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628050850.536447-1-gustavo.romero@linaro.org>
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=gustavo.romero@linaro.org; helo=mail-il1-x135.google.com
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

Factor out the code used for setting the MTE TCF0 field from the prctl
code into a convenient function. Other subsystems, like gdbstub, need to
set this field as well, so keep it as a separate function to avoid
duplication and ensure consistency in how this field is set across the
board.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 linux-user/aarch64/meson.build       |  2 ++
 linux-user/aarch64/mte_user_helper.c | 34 ++++++++++++++++++++++++++++
 linux-user/aarch64/mte_user_helper.h | 25 ++++++++++++++++++++
 linux-user/aarch64/target_prctl.h    | 22 ++----------------
 4 files changed, 63 insertions(+), 20 deletions(-)
 create mode 100644 linux-user/aarch64/mte_user_helper.c
 create mode 100644 linux-user/aarch64/mte_user_helper.h

diff --git a/linux-user/aarch64/meson.build b/linux-user/aarch64/meson.build
index 248c578d15..f75bb3cd75 100644
--- a/linux-user/aarch64/meson.build
+++ b/linux-user/aarch64/meson.build
@@ -9,3 +9,5 @@ vdso_le_inc = gen_vdso.process('vdso-le.so',
                                extra_args: ['-r', '__kernel_rt_sigreturn'])
 
 linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [vdso_be_inc, vdso_le_inc])
+
+linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [files('mte_user_helper.c')])
diff --git a/linux-user/aarch64/mte_user_helper.c b/linux-user/aarch64/mte_user_helper.c
new file mode 100644
index 0000000000..8be6deaf03
--- /dev/null
+++ b/linux-user/aarch64/mte_user_helper.c
@@ -0,0 +1,34 @@
+/*
+ * ARM MemTag convenience functions.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#include <sys/prctl.h>
+#include "mte_user_helper.h"
+
+void arm_set_mte_tcf0(CPUArchState *env, abi_long value)
+{
+    /*
+     * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
+     *
+     * The kernel has a per-cpu configuration for the sysadmin,
+     * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
+     * which qemu does not implement.
+     *
+     * Because there is no performance difference between the modes, and
+     * because SYNC is most useful for debugging MTE errors, choose SYNC
+     * as the preferred mode.  With this preference, and the way the API
+     * uses only two bits, there is no way for the program to select
+     * ASYMM mode.
+     */
+    unsigned tcf = 0;
+    if (value & PR_MTE_TCF_SYNC) {
+        tcf = 1;
+    } else if (value & PR_MTE_TCF_ASYNC) {
+        tcf = 2;
+    }
+    env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
+}
diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mte_user_helper.h
new file mode 100644
index 0000000000..ee3f6b190a
--- /dev/null
+++ b/linux-user/aarch64/mte_user_helper.h
@@ -0,0 +1,25 @@
+/*
+ * ARM MemTag convenience functions.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef AARCH64_MTE_USER_HELPER_H
+#define AARCH64_MTE USER_HELPER_H
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+
+/**
+ * arm_set_mte_tcf0 - Set TCF0 field in SCTLR_EL1 register
+ * @env: The CPU environment
+ * @value: The value to be set for the Tag Check Fault in EL0 field.
+ *
+ * Only SYNC and ASYNC modes can be selected. If ASYMM mode is given, the SYNC
+ * mode is selected instead. So, there is no way to set the ASYMM mode.
+ */
+void arm_set_mte_tcf0(CPUArchState *env, abi_long value);
+
+#endif /* AARCH64_MTE_USER_HELPER_H */
diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
index aa8e203c15..ed75b9e4b5 100644
--- a/linux-user/aarch64/target_prctl.h
+++ b/linux-user/aarch64/target_prctl.h
@@ -7,6 +7,7 @@
 #define AARCH64_TARGET_PRCTL_H
 
 #include "target/arm/cpu-features.h"
+#include "mte_user_helper.h"
 
 static abi_long do_prctl_sve_get_vl(CPUArchState *env)
 {
@@ -173,26 +174,7 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
     env->tagged_addr_enable = arg2 & PR_TAGGED_ADDR_ENABLE;
 
     if (cpu_isar_feature(aa64_mte, cpu)) {
-        /*
-         * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
-         *
-         * The kernel has a per-cpu configuration for the sysadmin,
-         * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
-         * which qemu does not implement.
-         *
-         * Because there is no performance difference between the modes, and
-         * because SYNC is most useful for debugging MTE errors, choose SYNC
-         * as the preferred mode.  With this preference, and the way the API
-         * uses only two bits, there is no way for the program to select
-         * ASYMM mode.
-         */
-        unsigned tcf = 0;
-        if (arg2 & PR_MTE_TCF_SYNC) {
-            tcf = 1;
-        } else if (arg2 & PR_MTE_TCF_ASYNC) {
-            tcf = 2;
-        }
-        env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
+        arm_set_mte_tcf0(env, arg2);
 
         /*
          * Write PR_MTE_TAG to GCR_EL1[Exclude].
-- 
2.34.1


