Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F59EC47DDB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0K-0004jy-Ah; Sat, 27 Jan 2024 23:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0I-0004jm-IX
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:46 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0H-0004J4-0J
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:46 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d746ce7d13so15818885ad.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416964; x=1707021764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XtUAEvtZlEFe6xSkMZOBhFgppz0gGYIST8afKDqnszc=;
 b=crpLBow+lgRWgjMyPIqbGTsIDiIk4vLB7QRA61wclq/DT6BiTJzyK4n3lp4buvhOQ8
 oEJYsmqVrvAE1xe64tNAk03SlWvy/HwJmBnMnwxqcrwd+fAPXDjQzbMK0yS90lRomnEp
 Zgmz7J6gwwfRy2IppW71SYGXaQgRbzzOoGrJ0v5BawcnUyflt8ChyK4PTqJ3c1JZV750
 wNrGV44tt0LCklw0YGXDaVSwlKv69hgVOUuEvd1wa2SJ/JJLKUg5tGz4kVSOftqdGE80
 X1zPm3j+n0w3WjqMWayzlRD9QZOZMNpq0vQXLG7Uiy0qq+EBXsZQa9yHTaF1GtViwnQZ
 6XGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416964; x=1707021764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XtUAEvtZlEFe6xSkMZOBhFgppz0gGYIST8afKDqnszc=;
 b=G4tyRWFSLea60CPUwiL4Dql7Hpfv7maTYnb3P0dN1XJ0VMAtT6IPvDG0DTnbdMNxfQ
 rFfOMgDLUAhj2Ss8QIVhhdj6NDNVKCO3WQ8L4vr1kHIMMJHLSdBVnhCrbuBF6mYYO7mE
 zXtFMFU3EDwU/d6yLM93nicNdTPudoPoFy7+r8zbsHl/VEPyJFmrJrPzWjgwnpLSrGMD
 0AZZLMLvYUgE+lADb5ieEQ13293jGqqB3nW0JdvfFBjkWDOx45G6AHgf1NI/zjfLEmov
 76pdoZyoVVrxsi8FaCtC4SBhAm/X9bTXKPWw4TS/XR+m0E/E9kzcjYcA+uFe+LLiQXyb
 W80g==
X-Gm-Message-State: AOJu0Yx+ItyTi4WQLrkBwUtdWe5HN5WhVn8QZYBeLJbTMytzs8ROYF01
 nWKxcSmc8SbS+S/vnj6BUaHhZ+pm5BZzs95JO4cGE89faWZSP7yCEjcn0hFQEEjAGkjwCiShu2S
 2f/UkRQ==
X-Google-Smtp-Source: AGHT+IEqoXUMbDRfq9zvPJMnm+rGsQYvSdXTOb7OoHIYYKSxF0pbRiw3MmBjRnVMzTbZX+FFHfKx8A==
X-Received: by 2002:a17:902:c412:b0:1d8:d6c1:fcb9 with SMTP id
 k18-20020a170902c41200b001d8d6c1fcb9mr139840plk.100.1706416963770; 
 Sat, 27 Jan 2024 20:42:43 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PATCH 10/33] include/exec: Move cpu_*()/cpu_env() to common header
Date: Sun, 28 Jan 2024 14:41:50 +1000
Message-Id: <20240128044213.316480-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

From: Anton Johansson <anjo@rev.ng>

Functions are target independent.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-17-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h    | 25 -------------------------
 include/exec/cpu-common.h | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index edee87d3f4..8501a33dbf 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -384,33 +384,8 @@ static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
 
 #endif /* !CONFIG_USER_ONLY */
 
-/* accel/tcg/cpu-exec.c */
-int cpu_exec(CPUState *cpu);
-
 /* Validate correct placement of CPUArchState. */
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 
-/**
- * env_archcpu(env)
- * @env: The architecture environment
- *
- * Return the ArchCPU associated with the environment.
- */
-static inline ArchCPU *env_archcpu(CPUArchState *env)
-{
-    return (void *)env - sizeof(CPUState);
-}
-
-/**
- * env_cpu(env)
- * @env: The architecture environment
- *
- * Return the CPUState associated with the environment.
- */
-static inline CPUState *env_cpu(CPUArchState *env)
-{
-    return (void *)env - sizeof(CPUState);
-}
-
 #endif /* CPU_ALL_H */
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index ba10351576..7e1a4afad8 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -7,6 +7,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "exec/hwaddr.h"
 #endif
+#include "hw/core/cpu.h"
 
 #define EXCP_INTERRUPT  0x10000 /* async interruption */
 #define EXCP_HLT        0x10001 /* hlt instruction reached */
@@ -249,4 +250,29 @@ G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
  */
 #define PAGE_PASSTHROUGH 0x0800
 
+/* accel/tcg/cpu-exec.c */
+int cpu_exec(CPUState *cpu);
+
+/**
+ * env_archcpu(env)
+ * @env: The architecture environment
+ *
+ * Return the ArchCPU associated with the environment.
+ */
+static inline ArchCPU *env_archcpu(CPUArchState *env)
+{
+    return (void *)env - sizeof(CPUState);
+}
+
+/**
+ * env_cpu(env)
+ * @env: The architecture environment
+ *
+ * Return the CPUState associated with the environment.
+ */
+static inline CPUState *env_cpu(CPUArchState *env)
+{
+    return (void *)env - sizeof(CPUState);
+}
+
 #endif /* CPU_COMMON_H */
-- 
2.34.1


