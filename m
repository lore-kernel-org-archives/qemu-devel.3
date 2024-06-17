Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C774BC27C77
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 06:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ5rv-0003oE-2T; Mon, 17 Jun 2024 02:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ5rt-0003nY-E9
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:29:29 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ5rr-0003TY-Nr
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:29:29 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70599522368so2779728b3a.2
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 23:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718605766; x=1719210566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nd0arIutfBDSvvt+flGv2i8x1ts6dfIDGNUcyWMohdI=;
 b=VxGMxv/OYpdnzES8/scfNCxztBPMY6UP+TpvFDEVskSJ1Yqg3j4CEb/XH8bshZLKqm
 iuK3jiVl+FOmNc949PNPyfpS+IgutBBVZoO0/a/yr58b+xMqFhWxjxv1pvGTjgTaRIiv
 u536P27OYChLagKFPXIvt/zqjIL3xI7HwqeSk0R8lS3gDuqvWkaVUpQF+9P0tYVl/K1T
 YGnvvIkoWHE0Dqn3dHVgZ2awg6kJBmXOIFhhy3KOX7KeqkGmr31F+sGaQmAsL6EYtKAd
 7CeEZ2PCiDzfm5UQnBfv4KExh9wE7tvq2fB+zuj9iV4YTySiDpb6on1jmWNeQK/x23qd
 Q7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718605766; x=1719210566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nd0arIutfBDSvvt+flGv2i8x1ts6dfIDGNUcyWMohdI=;
 b=KXZUhbaGemDN1fqVpMUXpQqB8X4p9yYU0EpjhWZ0PghztzVLhF1ybTwlfH5FWsSI/i
 RrqPZkmxgT/LpPsvElA3V9mS57Y+7fmLP606XYWSMeRkrtGIryXnind6PvJlrP0BnOuQ
 847A5/BWRJWC8LkdZu7Ik8/aU2TY5kALiMcazjfwANsC0Z5RJnqpb4XNeAzz7cxNxvPL
 QTnqSQiYdo1uIIfeQxOk5dhmoMvAYlc1l6nazWZlUTMbciT8HKWxScdTL/kqSFimyOO0
 sBGs3leD8aX0m9x4WqKXT2EUsji7QGqpawtsdXhbrxUVhGPIz3gv3Io3T1rOdd0liTtn
 5uxA==
X-Gm-Message-State: AOJu0YwN9KTEompBbVYQOmKExFP2zIBGPLYq0CIY5gU8RjFsDF8em1AF
 JUsEZrYf794D6XRCZM4PC8Kw+J7BgWOsWuOrIBWn1mdQqPxMEEgtOukNQB97q5a+DOKzbl1xxDd
 E
X-Google-Smtp-Source: AGHT+IH5+tMe2owX2I5fIBlGuAW8LRb8XyhMJ2ynclYImrcNiWsJY+QlI7n5Zg1qixFwH7VjnNoOkw==
X-Received: by 2002:a05:6a20:6f8e:b0:1b5:d36a:5d6e with SMTP id
 adf61e73a8af0-1bae8214a4amr8881310637.43.1718605765907; 
 Sun, 16 Jun 2024 23:29:25 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:8dcb:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4a75ed69csm10641863a91.14.2024.06.16.23.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Jun 2024 23:29:25 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v3 6/9] target/arm: Factor out code for setting MTE TCF0 field
Date: Mon, 17 Jun 2024 06:28:46 +0000
Message-Id: <20240617062849.3531745-7-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617062849.3531745-1-gustavo.romero@linaro.org>
References: <20240617062849.3531745-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42c.google.com
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

Factor out the code used for setting the MTE TCF0 field from the prctl
code into a convenient function. Other subsystems, like gdbstub, need to
set this field as well, so keep it as a separate function to avoid
duplication and ensure consistency in how this field is set across the
board.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 linux-user/aarch64/target_prctl.h | 22 ++---------------
 target/arm/tcg/mte_user_helper.h  | 40 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 20 deletions(-)
 create mode 100644 target/arm/tcg/mte_user_helper.h

diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
index aa8e203c15..cfc8567eac 100644
--- a/linux-user/aarch64/target_prctl.h
+++ b/linux-user/aarch64/target_prctl.h
@@ -7,6 +7,7 @@
 #define AARCH64_TARGET_PRCTL_H
 
 #include "target/arm/cpu-features.h"
+#include "target/arm/tcg/mte_user_helper.h"
 
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
diff --git a/target/arm/tcg/mte_user_helper.h b/target/arm/tcg/mte_user_helper.h
new file mode 100644
index 0000000000..dee74d0923
--- /dev/null
+++ b/target/arm/tcg/mte_user_helper.h
@@ -0,0 +1,40 @@
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
+#ifdef CONFIG_USER_ONLY
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
+#endif /* CONFIG_USER_ONLY */
+
+#endif /* MTE_H */
-- 
2.34.1


