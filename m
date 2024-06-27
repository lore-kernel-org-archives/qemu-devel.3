Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A3FC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 04:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMgXE-0006qu-Eg; Thu, 27 Jun 2024 00:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sMgWj-0006Hv-E3
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:14:34 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sMgWg-0000Af-V7
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:14:28 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-375f713a099so28310455ab.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 21:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719461664; x=1720066464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzx9s/7tqo4YbR/masBSAAi0+ITK6Y2yWNbJ1lluZfs=;
 b=n2OKgKnwsj7o8ULAcX5Wt07+06L0tKV2y38SEWEU/NlQiBx5rZy7HjaKDGUt128YsS
 Jj/rfIGcpargafGj9cbPhpuWNKM60tjGv+ro6FwxkiWsF2oiNx3ysiAa8OLNCcsTaqTY
 kqmmTb9dip6WvoJ8eL+E40ZFXn8Xv9ZgYbGSyyQOI8tdAldJS+zvM4uiSFMh1N9x22G3
 5CxGgjbqg3CfWf9mxt9JNFBTTnr7YRguZD7C9CLrh1x3MJHnWqIftKD6opF0ZMFWWB1/
 UVElZGKDEzGZgVNKFv+dh5MkevoIUPadCTvfjJg5GwS20LdD+GNf6cBl3qhvh1hOT7jp
 qGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719461664; x=1720066464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzx9s/7tqo4YbR/masBSAAi0+ITK6Y2yWNbJ1lluZfs=;
 b=fcmybRtTz4T2HeVjAJ3JC+ImKGfPr60cfysqIX9P7TeavKDktCHLCRrKNeJY346jO4
 OSs5qwzVeEpLnGtQaHtCHvTF8+vy72fu3hWXvdqv9TepGlCWfiXftu8Y9l6dw6ZeaBMo
 4vcQJL8LwgsEil08U0HtQ1m9oGxsWQXxzuTghPLLYwzlae982jHjOVlWleekVDgiao6A
 OZR7KpeA0y2x7gltJigF4Xaa9J85e7nuyo6b7a+iAE81tybVPeV9XCKKV3skuHJFPIiZ
 4eMVZjkUmozgK2yDfdY9Q8Mww1hWd+GBzG6atjw4QqtCTYoNwiBROX0Rt6yOAVXsIPoq
 aPEg==
X-Gm-Message-State: AOJu0YzFrhb4jVBmUtxxhNYEkYKbw14C9+/Dc5YxiXXSPjeGAPUFw3NE
 ZLCEPTQxzjWofXLSXY94HNLSPZLsrX+aKkqMI9c9ZuXuDZw4zZejIegtFf7jrDzCWx0THEKsgjI
 HIA8=
X-Google-Smtp-Source: AGHT+IEe5A0rqdIuCBbYgsmHsoqvfbkxFoJvtw3KKA8QMelJPRgRZTFd544b02cXOhIFF6WpxM2oGA==
X-Received: by 2002:a05:6e02:214c:b0:375:aa46:4a30 with SMTP id
 e9e14a558f8ab-3763e0600f9mr184672505ab.23.1719461663656; 
 Wed, 26 Jun 2024 21:14:23 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:391e:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72748e8539fsm273045a12.66.2024.06.26.21.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 21:14:23 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 6/9] target/arm: Factor out code for setting MTE TCF0 field
Date: Thu, 27 Jun 2024 04:13:46 +0000
Message-Id: <20240627041349.356704-7-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627041349.356704-1-gustavo.romero@linaro.org>
References: <20240627041349.356704-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-il1-x12e.google.com
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


