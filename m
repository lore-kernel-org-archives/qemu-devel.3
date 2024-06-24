Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DACC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcIf-00035Q-CL; Mon, 24 Jun 2024 01:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIc-00034T-05
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:30 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIZ-0004bD-TU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:29 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5bfa5f9bbe6so1948217eaf.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719207086; x=1719811886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yW6AGmqZg/Umn21wD61FD4HlSpwe58RxaApVtS3jS0Y=;
 b=BzDPyHsygGp4JzmQB9B87UMD3x+7/OEisMPQhm4MeBfqdEJA+18Co+JqPexSwZm0ge
 WttEB63JVCmV+wFPEy+ztM/jzzNCQ+gsU2XX0P7c8bMEUrnN4PJ9hS43bNak9ihXlCit
 TU1BK2fkQiKKWDwMgQDXLJS/Fo0YWHTi7xM5fs+dmiYtD5OnD+ju9N9arDEdXvid8XVG
 J6bPaJOKtQ0Oa52kdF3gG9DAvUU/NXiHXZ3X7YuE48e435LfDaalDRhtubo2KPCtm4Et
 n7UOBtM3CS8lwygOLaFwMyH0/duAybnHikYUCXZJ4Th/W0E6LxBsxpK7m4Z+DjzgAa0r
 W0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207086; x=1719811886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yW6AGmqZg/Umn21wD61FD4HlSpwe58RxaApVtS3jS0Y=;
 b=DwWoKMs1ohv8239o47cz66W0ytjTLnWLmjRSnjV5Z+kDbRTNW0vnWqo5p8s+lnlZU0
 BGUQHwKO7lcwpHemCCy/Kq1Gc89tLJtIjt36E5KY5qEFnReFWUc0w/+eRCp8CibXNSjd
 WUlMQrI5nUEtx5I/mUkGd1hW/OfDfKdgtEYob+YUW/TzxQ2b4O2FLx7SUnZjezKCWjXn
 XRoI5rhQGKKAjIoELLx+oCECM/wtFRcXx3i+wKzTDxRybd8PmZj7w1Lw0CZKQRf3Eemn
 6/K+iiFyTTE1glRZ2JUpjrXXhueCR3zLqQgZF2J5vfz3K6X9qO582vNKo6fzibW/W8YH
 kBtg==
X-Gm-Message-State: AOJu0YytE+teJ1ctgAMpuLSAi8/Zot+ykZl5fo2ZL0DaWnN+D7NPR5XE
 bb2y7nnyoIhlXxS+98qtwbuf7DlFuSSfRDqJtZ6n4/luZ6jdEpkwSTtMelhU2zaE6+KxgS5/ljT
 LpBI=
X-Google-Smtp-Source: AGHT+IGaKFzw8ochNjV4BIJrIVZRS8hdT3fA0tQ1OmwU93h44sejt3+S0AyAGqTpqzQS2eEUvrg02w==
X-Received: by 2002:a05:6358:5e15:b0:19f:4ca6:86bf with SMTP id
 e5c5f4694b2df-1a23c1ccdfdmr483884055d.32.1719207085733; 
 Sun, 23 Jun 2024 22:31:25 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:1758:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716b4a73183sm3953601a12.39.2024.06.23.22.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 22:31:24 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 6/9] target/arm: Factor out code for setting MTE TCF0 field
Date: Mon, 24 Jun 2024 05:30:43 +0000
Message-Id: <20240624053046.221802-7-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624053046.221802-1-gustavo.romero@linaro.org>
References: <20240624053046.221802-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oo1-xc2f.google.com
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
 linux-user/aarch64/mte_user_helper.h | 38 ++++++++++++++++++++++++++++
 linux-user/aarch64/target_prctl.h    | 22 ++--------------
 2 files changed, 40 insertions(+), 20 deletions(-)
 create mode 100644 linux-user/aarch64/mte_user_helper.h

diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mte_user_helper.h
new file mode 100644
index 0000000000..fd92e71c00
--- /dev/null
+++ b/linux-user/aarch64/mte_user_helper.h
@@ -0,0 +1,38 @@
+/*
+ * ARM MemTag convenience functions.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef MTE_H
+#define MTE_H
+
+#include "sys/prctl.h"
+
+static inline void arm_set_mte_tcf0(CPUArchState *env, abi_long value)
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
+
+#endif /* MTE_H */
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


