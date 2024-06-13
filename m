Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A545C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHo8x-0000il-2v; Thu, 13 Jun 2024 13:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHo8t-0000hF-5w
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:21:44 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHo8r-0005r4-CX
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:21:42 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70436ac8882so1014415b3a.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718299299; x=1718904099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I8/Wixo704I9fR54FMLOa8feLRsS1yC83cftMeEAmA4=;
 b=QK+caPCXRkJWlBoyioiglzI5J5SsC/RwbDX8loSj3BTUc4Z5yE/BsK7RNfD/2LKJfz
 QognfbRa+4Q1aHq3z81JeyCP15/51JIk4mI1l4yGmEggUeZJ4wu3Ea7PuDFfqKYzgwJM
 hJDUedd78jNoKLL9w5gEGMb2IzPeDXZEHY8iqSxKGMdmjxAeaGgDqkOYVCZ0O1cBBBdO
 BeFsorCx6ywsiloYNDzeEbohacJhyOX9Z4jO15nsUdv9VhGUjS4nMPk2ywMkAV9tycCT
 oKo2xy2EfaNaPBFxLzDrFxAM5yWVS0w/r9dgsVLFIYFZCoPN4qSspS9JF5ueMnyMlY8x
 V91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718299299; x=1718904099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I8/Wixo704I9fR54FMLOa8feLRsS1yC83cftMeEAmA4=;
 b=NZxvRsXPWx5/M1otsouAbRqZD5XR8wHINOChRVloCU3gH1Z3BtfUQ0fpykpaL5Gvt6
 /4BP+bMgn2oqy1iyo0MtqVbcILg8mRlesekcRuEw/A5qG5GzHFdxsF/O0seziXgNWdwy
 4zYkEe27y5qw6HdIqVHZdq76bu93ctj+0C5SAMRLNpdh07cZiK3gE8tr/WOjiP8B+GHq
 wmzmovkK+cNxdd7PE7l0rD7ARF3MSYuf4m/HQcoz1gwABwMHmZvPP3RBvNEiltPiBIae
 1ZFBxbly/EUOGATvtT62MuCBdM/AqdYV8n6rUBgzdg0w4r0Xl/PhYIA3ah7QCsN8wf2U
 y+wg==
X-Gm-Message-State: AOJu0YzCo2IbOLsNHR9h6HsmJySUYuO4cCrXYty+/iiwviGA4dJ3QjrZ
 Y/FXcT2GwDPUUjP8mmdhq9jYtt5YXaldrIhdOkRGXoy3BP7ri836uKojhCcULfacqJcRuUDMOhW
 d
X-Google-Smtp-Source: AGHT+IFfA+/f5aw39B80kOLyRRQSNQ42qnAPqfXbGt3f5i4eCxWK7SbsMmmtdTRhLGUvNvO7NysykQ==
X-Received: by 2002:a05:6a20:9499:b0:1b8:1be8:7ff5 with SMTP id
 adf61e73a8af0-1bae82900a0mr393960637.50.1718299299592; 
 Thu, 13 Jun 2024 10:21:39 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:8dcb:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e5b85bsm16443885ad.32.2024.06.13.10.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 10:21:39 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v2 6/9] target/arm: Factor out code for setting MTE TCF0 field
Date: Thu, 13 Jun 2024 17:21:00 +0000
Message-Id: <20240613172103.2987519-7-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613172103.2987519-1-gustavo.romero@linaro.org>
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x434.google.com
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
 linux-user/aarch64/target_prctl.h | 22 ++-----------
 target/arm/mte.h                  | 53 +++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 20 deletions(-)
 create mode 100644 target/arm/mte.h

diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
index aa8e203c15..8a11404222 100644
--- a/linux-user/aarch64/target_prctl.h
+++ b/linux-user/aarch64/target_prctl.h
@@ -7,6 +7,7 @@
 #define AARCH64_TARGET_PRCTL_H
 
 #include "target/arm/cpu-features.h"
+#include "target/arm/mte.h"
 
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
+        set_mte_tcf0(env, arg2);
 
         /*
          * Write PR_MTE_TAG to GCR_EL1[Exclude].
diff --git a/target/arm/mte.h b/target/arm/mte.h
new file mode 100644
index 0000000000..89712aad70
--- /dev/null
+++ b/target/arm/mte.h
@@ -0,0 +1,53 @@
+/*
+ * ARM MemTag convenience functions.
+ *
+ * Copyright (c) 2024 Linaro, Ltd.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef MTE_H
+#define MTE_H
+
+#ifdef CONFIG_TCG
+#ifdef CONFIG_USER_ONLY
+#include "sys/prctl.h"
+
+static void set_mte_tcf0(CPUArchState *env, abi_long value)
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
+#endif /* CONFIG_TCG */
+
+#endif /* MTE_H */
-- 
2.34.1


