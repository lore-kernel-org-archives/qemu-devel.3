Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8608AC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhD8-0007n0-GM; Fri, 21 Mar 2025 14:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvhD1-0007h1-OR
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:35:08 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvhCz-0006SD-Uq
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:35:07 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso21714865e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742582103; x=1743186903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjwZgCIi2jBsPZIag25qd8ZTCLcuQDiSa/Kk3V0wr/4=;
 b=gW4DFREWmmBwOo9lwo7jV0e9YfdirGQ9Hd+SkEP0oZyaTF0uGhL7yW7uSIpo26i/iz
 WuWu/QjbPt5J79PduD27+90FUAEaMM9DgJCgagRgE+HixCSPW013s2Fqa3r7PIOAJ3yM
 MPSkWiBJe/2dtg7+A0qzHMvmX7G1UaMJl7wPVthBx+TnXjK/dvCtFUK1eYB9CM3tzQKi
 euHZ2oMHzvIXNhbJ0jhACMQ8sWD6Rz8jf+UTkgr37XErfuY8TczeEqX8c1+b51NEs4EV
 2X4ucFRVjI8fRuaojgqi6ZD5oMW44nJWkBQyEAM55aTk9EQIcDrfHdq8gPP3KOmDE/9J
 MGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582103; x=1743186903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjwZgCIi2jBsPZIag25qd8ZTCLcuQDiSa/Kk3V0wr/4=;
 b=orVlKijQ6bkWlWPXuHjZHRb33rCGAFSbXXb6M7SKr/60GShfgas3VRPxmkQ8/aOZAt
 lFbSZdj4gv3Fr/gP3drzGvV9712ApjOwee05V4GoaA6y6h1bhJsDAOfsgU7QVcFrFO//
 nQlYFyrwcwhmBiaPo9xqury9Ul8dO2ylWsDiO3DfdZM09hxbcTBKiW5zsGAQhNR47NC5
 qz8F4/EzBQcGBPGQhDEJGC+9ZdMCmGDYtidZYDjMG1JhErv1Zy113aIV2vzBYwSTLne0
 WPM5hjd9m8lnV7EUUnmuj+4FILd07dSGMY91Q4sG756NtGGgbXfZX1ifC06DTfwnzPAE
 vxrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmKHEdq7+iUWMt/llWuCJKWLZfJaHgi6W/NBywcqTic64ehWuGashaEhQhMvlAgwltNesuhfMeFnyT@nongnu.org
X-Gm-Message-State: AOJu0Yy5xJHRGnqzqzaHDGB1N3w3/PCf/LfnkL+FkamEI/nt/+M0o0NN
 qXJcvxWX5OAjftYreL9CogGbZevuYGK5nnOU4W5G9CD4oHA8mHGKoyf8D3ChKdQ=
X-Gm-Gg: ASbGncu/TMegFAC2jRu5uxBM3lyVj/99sPTUunPVRwpbIdeZkIl59cUu0J7fhuUnRcH
 TmiFiPX7Wv/qCecRk2gJt9q74sNSNLSsprD8rg0H/KGra42weX8t1jUANuI5U3G/wWs5CBy88P1
 hb0E47tykIV61H5Q9o/NaAevrQFQ4pJBIPEzh4tGo5LJ+gLexKOZPScbkY6HstzEw7hX9VWhlII
 l1D6/f+ltL6S0ITCt9YVtSD/evT4NuoBOVkcuflDCZ/3H0JOoRvb2yq43GtVY2kBtekL0zk43ow
 7uyAYeyRVyJ30ytQ4XBAck7FIhaA7jtrIJgdp7uG18NA0lX7S+f5A16M858hbYWQb5Sx4t39p81
 M3ko8nsCt5juwcq9UGXQ=
X-Google-Smtp-Source: AGHT+IGIRF0Z2mItNPVVgWt/S8MumscOh8gAwsUfzuWNDwS+C8R8U6P1GE+JL22fyxVt/NT+ZZSbPA==
X-Received: by 2002:a05:600c:4f85:b0:43c:e481:3353 with SMTP id
 5b1f17b1804b1-43d50a13947mr41133405e9.17.1742582102694; 
 Fri, 21 Mar 2025 11:35:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d3cf2e1ffsm49736555e9.3.2025.03.21.11.35.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 11:35:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 2/4] tcg: Move qemu_tcg_mttcg_enabled() to
 'system/tcg.h'
Date: Fri, 21 Mar 2025 19:34:47 +0100
Message-ID: <20250321183450.3970-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321183450.3970-1-philmd@linaro.org>
References: <20250321183450.3970-1-philmd@linaro.org>
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
---
 include/hw/core/cpu.h      |  9 ---------
 include/system/tcg.h       |  8 ++++++++
 accel/tcg/tcg-all.c        | 11 ++++++++++-
 target/riscv/tcg/tcg-cpu.c |  1 +
 tcg/region.c               |  4 +++-
 5 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5d11d26556a..54570d21aea 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -597,15 +597,6 @@ extern CPUTailQ cpus_queue;
 
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
index cb632cc8cc7..d75ecf531b6 100644
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
@@ -58,6 +59,15 @@ typedef struct TCGState TCGState;
 DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
                          TYPE_TCG_ACCEL)
 
+static bool mttcg_enabled;
+
+#ifndef CONFIG_USER_ONLY
+bool qemu_tcg_mttcg_enabled(void)
+{
+    return mttcg_enabled;
+}
+#endif
+
 /*
  * We default to false if we know other options have been enabled
  * which are currently incompatible with MTTCG. Otherwise when each
@@ -97,7 +107,6 @@ static void tcg_accel_instance_init(Object *obj)
 #endif
 }
 
-bool mttcg_enabled;
 bool one_insn_per_tb;
 
 static int tcg_init_machine(MachineState *ms)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 60a26acc503..5ccd7b9dc07 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -35,6 +35,7 @@
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


