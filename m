Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CCAC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ShK-00022w-HG; Thu, 03 Apr 2025 18:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sh2-0001mS-5u
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:48 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sh0-00041Q-9L
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so14085115e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 15:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743717944; x=1744322744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0hPjVpMeOEGtb5tikd80FZUadFKvG8IWWz5+z4zreQ=;
 b=An8OTESjKBxgKCUy0ILV/V/2wCFQYReoCMwDHdvTHXmxjz5PNXDnZNr0UbYEg+DmAV
 rqsiXEDwdFBoqbeZmvSdy6DDrRZkNTbXxqtMGj3YRVPgfwrJEZ+ODV/K8nKMt8QjXdKD
 SKIhzaTfMGfGyrIXaG6tXSOxmXmu5RMnf1HN/PHaAHsE0GuD+1Vr5LdG22K9nrgljPx9
 DnApTSnNzOORp4206F5daL8/zQS7zK68xEgnw4xmrhTWHNYVIgp12ez6TXF5oEV+hegv
 uJhyXs68bvAIn+z7qpN/RUwKSZhNTjVkDxL1lm9/RPrqrwuF+i28g/30nwEsg03M/2O0
 nKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717944; x=1744322744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0hPjVpMeOEGtb5tikd80FZUadFKvG8IWWz5+z4zreQ=;
 b=dGTP6YffR5WzJ/7E+bH2Nrd8n2wB0uDGR82IFRbFViyaNL/gUPoVQY6OX8rg8bysGz
 DG0iMkm7k5kbjgeitMHm6yRU+oOdPW/PTtFOlBVGgajHVfyGGLhZSlSp4PJ9f8MB/6gO
 KhXeR8Ow/iSWSRmqLj4cAaOA/NjO/YCjh2aMAWn61pxL3dA93O+pHMgT13lk52ALCTmq
 y9VivjUZUuUmuvmKx17yUdoRv0B1yDtn9sxhLBLdhfIbiO1VnyeGYZlhPqfLmqzMtSMY
 Wtu97HCgQWmqUTJXey+3DBf5yw4vSm7Az+cTYXCLDSX4PH3CX8iOerIQ4xl4eLAxCHto
 +rXw==
X-Gm-Message-State: AOJu0Yylj5hYlXQ8ipfLMhRSD9L4LiS6IA5tvSsy9XZEr+BE5eHwdLep
 s6X1mEiBhIfSZ5AAJFWj8yygqFA+axtczxXjJt4sbmWg9aDjjuJVuZiK/ep7DQjIn+aX/v2Angg
 K
X-Gm-Gg: ASbGncv70yCsH5WuY1Dq9rWemqujiTWaYVpzqLo2r0NAZ88h3teCKnp2UCtewCT+koW
 +E2btk7GHdL63eLvssMUSGn9wdC7yNMhbaDd8sct/tAB2ybNQU3As4ddOs8Q9Rxj6BCJn4Kk9gy
 qTx5Npa5hUpCRLCr4YKdYsbtEQk2YNHLr5j7XwcriaWkgGovnbefjgoiUlYvO/ejNn26m00h+e8
 WNU2K8x3NxjAsB2fkIy9nckTtUIHMnkAtv8KOKL0DPTqiauKEHyT19zqD33s5kDpUmpzDYsHgyu
 gBr/GxE5PLOhzTrMCLjvKvkinku6eAhDe++ounN2XY0nkstUjfxCmunDILp2vboBsTjXHU5hK1M
 TMT732T4M849rU32oh8vd7HVP
X-Google-Smtp-Source: AGHT+IF1kjnQ3a7qpml9Oy4IrAFXFGwNzma5rW6C+2Dg9pimAozyzKBpNLpGq/s/9H3jUxbLk7w2oQ==
X-Received: by 2002:a05:6000:2210:b0:39a:c832:4f46 with SMTP id
 ffacd0b85a97d-39cba93c081mr754122f8f.26.1743717944183; 
 Thu, 03 Apr 2025 15:05:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b6a1esm2841726f8f.45.2025.04.03.15.05.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 15:05:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v3 16/19] tcg: Move qemu_tcg_mttcg_enabled() to
 'system/tcg.h'
Date: Fri,  4 Apr 2025 00:04:16 +0200
Message-ID: <20250403220420.78937-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403220420.78937-1-philmd@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
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

qemu_tcg_mttcg_enabled() is specific to 1/ TCG and
2/ system emulation. Move the prototype declaration
to "system/tcg.h", reducing 'mttcg_enabled' variable
scope.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h      |  9 ---------
 include/system/tcg.h       |  8 ++++++++
 accel/tcg/tcg-all.c        | 16 ++++++++++++++--
 target/riscv/tcg/tcg-cpu.c |  1 +
 tcg/region.c               |  4 +++-
 5 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 10b6b25b344..c8d6abff19a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -594,15 +594,6 @@ extern CPUTailQ cpus_queue;
 
 extern __thread CPUState *current_cpu;
 
-/**
- * qemu_tcg_mttcg_enabled:
- * Check whether we are running MultiThread TCG or not.
- *
- * Returns: %true if we are in MTTCG mode %false otherwise.
- */
-extern bool mttcg_enabled;
-#define qemu_tcg_mttcg_enabled() (mttcg_enabled)
-
 /**
  * cpu_paging_enabled:
  * @cpu: The CPU whose state is to be inspected.
diff --git a/include/system/tcg.h b/include/system/tcg.h
index 73229648c63..7622dcea302 100644
--- a/include/system/tcg.h
+++ b/include/system/tcg.h
@@ -17,4 +17,12 @@ extern bool tcg_allowed;
 #define tcg_enabled() 0
 #endif
 
+/**
+ * qemu_tcg_mttcg_enabled:
+ * Check whether we are running MultiThread TCG or not.
+ *
+ * Returns: %true if we are in MTTCG mode %false otherwise.
+ */
+bool qemu_tcg_mttcg_enabled(void);
+
 #endif
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index a5a1fd6a11e..b8874430d30 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -38,6 +38,7 @@
 #include "hw/qdev-core.h"
 #else
 #include "hw/boards.h"
+#include "system/tcg.h"
 #endif
 #include "internal-common.h"
 #include "cpu-param.h"
@@ -58,6 +59,17 @@ typedef struct TCGState TCGState;
 DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
                          TYPE_TCG_ACCEL)
 
+#ifndef CONFIG_USER_ONLY
+
+static bool mttcg_enabled;
+
+bool qemu_tcg_mttcg_enabled(void)
+{
+    return mttcg_enabled;
+}
+
+#endif /* !CONFIG_USER_ONLY */
+
 /*
  * We default to false if we know other options have been enabled
  * which are currently incompatible with MTTCG. Otherwise when each
@@ -97,7 +109,6 @@ static void tcg_accel_instance_init(Object *obj)
 #endif
 }
 
-bool mttcg_enabled;
 bool one_insn_per_tb;
 
 static int tcg_init_machine(MachineState *ms)
@@ -107,10 +118,11 @@ static int tcg_init_machine(MachineState *ms)
     unsigned max_cpus = 1;
 #else
     unsigned max_cpus = ms->smp.max_cpus;
+
+    mttcg_enabled = s->mttcg_enabled;
 #endif
 
     tcg_allowed = true;
-    mttcg_enabled = s->mttcg_enabled;
 
     page_init();
     tb_htable_init();
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 50e81b2e521..88f7cdb887c 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -36,6 +36,7 @@
 #include "tcg/tcg.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
+#include "system/tcg.h"
 #endif
 
 /* Hash that stores user set extensions */
diff --git a/tcg/region.c b/tcg/region.c
index 478ec051c4b..56d2e988719 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -34,7 +34,9 @@
 #include "exec/translation-block.h"
 #include "tcg-internal.h"
 #include "host/cpuinfo.h"
-
+#ifndef CONFIG_USER_ONLY
+#include "system/tcg.h"
+#endif
 
 /*
  * Local source-level compatibility with Unix.
-- 
2.47.1


