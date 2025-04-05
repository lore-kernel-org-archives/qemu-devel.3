Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B7BC3601A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u16AE-0001CW-2X; Sat, 05 Apr 2025 12:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u16A8-00010U-Gn
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:29 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u16A6-0005IJ-MF
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:28 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c1efc457bso1760124f8f.2
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869664; x=1744474464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/LTVfYsOIJ5re5/xeDsdKiBrQeXn6HocLb4nBW7R3Q=;
 b=gqf/1rffEbG3fBdaHZNEBsUSwuEGRxoI6+eYZlHwSicK2s6r49J0+vxdXs1YBNdvFY
 XAglZtH9ZCdSBOvAX1mXWkujoOQeXE9PNDPoXl+pb9pKzWSHFP0cGksUV0Tw/z1ky4za
 JGtZVvoO1VCIYBOPrxDeEVVylI90bRFj8sPoxUm7sIlbAtGDHKue9Bg9Ihoy9NPiuD3E
 ZNWaucWivGTRisxhW2+PbsQ63b2/qjVFk45pkl1tOGCMfwJ96+ezemEN1WppWm/ZKmyW
 Sld9nPsgmUGflIW5sHqPMVKCot2CbA1buegF8LeeQ9XHs8O92jBQ9gLxTKhx1ronHLDB
 Qm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869664; x=1744474464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G/LTVfYsOIJ5re5/xeDsdKiBrQeXn6HocLb4nBW7R3Q=;
 b=Lrfv7dzS5m0e0NDlFxnW8jPiJRzVKgH4BkXyrgQDtr9n2yfvbo8FjEkaIeldIBgeCa
 sRAUr1ZIS1NPc6DPynWfbNeRkr4zeXhTZfmHbymOFC6LMcKxqxRkeojuPsc+w6DoJwrp
 vzUFWNNeLpeKCqvfVZBvcd6Meijver5IJ2FjBFmSk9Rb/BGbH4aHf8jfDgS3sJgIV9yI
 UyLXnSashdexBf5Ala2EBfcGO9IXJ64kE50dWi0qTz3NZkRbF1noPPh7Qu3qLjDU7cPa
 NfwHKbmmLn60uX16YZ9VIS8dE0kKZ0S0G530h2Fidsrwf8mFRvZNKfbUuVqwb1gFsQcD
 nE8g==
X-Gm-Message-State: AOJu0YxOQ2hnt33lo6LDH3DimD4BoYjv5AcAQ1WhqisnhJJVfiLA2VyQ
 PrT4Ld+xINSikXHSKeX0H0/DAKuzkGldm2cp2jPAqv3SfOfmilkc72/nTeDx8X8Bg3mRfQ7EwRD
 J
X-Gm-Gg: ASbGncuYOq8lq9FUvLzi5NXWACwf80Z+k63pl9XxcQHOWfG7nxLXUgo5dn9eDTxTlDg
 1yWZY6xdjvCxjrXtaYGRjnI6i1i4ctbGyIil3n2Z3Hv+QFV7GyKyC5LfKVq3+PSM/t80Lcu6AfZ
 eiW/9oiIHrwPp1qay+6zkD1mTfmwYn24CUYXdUohsUxu7JfUBeqrBrLlz92ol9VI7CuxyUnFfj7
 j3FWWvwAnZ5D5j56+hm3KJrLvhqJpf/yTE5/vynpjAp+4JipN1aZfxipq/6IxJYRKAWGrUADKRb
 Qg/KOHV0jifVSBv8Cz+fZEezWXQTapG1u1W2XnQQgNvxMTbxlSD1UHnGlie7PZ/Ik/z+gN+7NLQ
 N0P7fdIs038kUeBRK9zxkpB6a
X-Google-Smtp-Source: AGHT+IFKOYw0um4cvwg8CFrVDq63ghBopicARmqwLR0mGQkHnCBFWSNo4vFO189tXh3Zu6xkULuBpg==
X-Received: by 2002:a05:6000:440e:b0:39c:266c:d82 with SMTP id
 ffacd0b85a97d-39cb3575971mr4271768f8f.10.1743869664362; 
 Sat, 05 Apr 2025 09:14:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b3572sm80270355e9.39.2025.04.05.09.14.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Apr 2025 09:14:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v4 13/16] tcg: Move qemu_tcg_mttcg_enabled() to
 'system/tcg.h'
Date: Sat,  5 Apr 2025 18:13:17 +0200
Message-ID: <20250405161320.76854-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250405161320.76854-1-philmd@linaro.org>
References: <20250405161320.76854-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
index e146c76e6aa..44fdf6c4cf1 100644
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


