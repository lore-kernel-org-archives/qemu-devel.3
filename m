Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA086C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mbE-0006G0-36; Tue, 30 Apr 2024 08:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbC-0006FW-G2
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:42 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbA-0001mI-Oa
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:42 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56e1bbdb362so6035640a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714480119; x=1715084919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yEYkKsw4zhtRR56kF5ijigZ4qIRFvAlOOJdkN8sEkM=;
 b=FDsdpwYuc1ksLXcUu5WAgZxg8FYVYXgioenZoKRWSWvm+BXIdYUiUaxs1oIBFI6h3r
 j6Xjzmn9z/nv5pn9m+p+IyhH8fjPSw8bEG1MtRfZQ7rIo1z40eWOQBrrojmeaUqkD3Wm
 bKdHw/K+wGqfbtAxBNKgndYhfit8fHqWZSED7tNQ5SbwbJ856Os57BRySmD6jgrEUtOL
 W4YkqZFz3pERrbJzl+yVcGqwIZ1mSJ+XCFZmMQlQHEEw7JQNaQqBVhDAx+s4dogpAn5a
 i0YgYVs+8T8UXZ1gT86Uf3CUxel2QE//vmUZfCJIcqLpp3LyEvVhwydPoS9NLsfnJABk
 miXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714480119; x=1715084919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9yEYkKsw4zhtRR56kF5ijigZ4qIRFvAlOOJdkN8sEkM=;
 b=s8Szr1TFtQa49eQNyBzSqlQavLKW9nmu5JYWvB8qtcy5hwWJZxT2OmNXus1IFM438x
 MeD0+FysmGNTmWeISHE4qwysL9VuBQ8CB63xQq0dC9OxkKXLbJkqW3FHZBvek1XhWJaQ
 Yo4tw4CqXwDVHbcCxtfYGVwTVRdDvHMcvhIvLY59QWuMm/EX0r2+1n2e6FBj5x/opD08
 pwqZ3CLjQ9lyCzY1HyGLRPfJucdS2qCMvzw3Eo96JKb9/IIemLjnLFiDZH1PSo0hBBiq
 8NDVdUpG0aZMLdacsJMkapq/Gm6FboKOoc769DS+PssSK6UQFIzQDkSw0G/JtIhDxw9J
 0YtA==
X-Gm-Message-State: AOJu0YyHnKEJnEwfvHtSYNENlgJkUlsIzdHun9uZZtqt3RjonIBdBk7s
 JvyPT6PGeoyRSY3U/nOL14zwDM+xnsBRd2YjNLXHeBgFaBVOq+jmhAbp2zNLXO4AW25dfbDQh8d
 C
X-Google-Smtp-Source: AGHT+IHP/Rk64KVTigc6owxsEUulEALFzfOTXFddiC/CUFPFAoZPSVIjg13/p0hLUBb3qz5Sj276fg==
X-Received: by 2002:a17:906:2318:b0:a59:2e36:16ce with SMTP id
 l24-20020a170906231800b00a592e3616cemr1330654eja.34.1714480119016; 
 Tue, 30 Apr 2024 05:28:39 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 ku2-20020a170907788200b00a58c0c48756sm5674974ejc.32.2024.04.30.05.28.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 05:28:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 05/13] accel/tcg: Restrict cpu_loop_exit_requested() to TCG
Date: Tue, 30 Apr 2024 14:27:59 +0200
Message-ID: <20240430122808.72025-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430122808.72025-1-philmd@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

Next commit will restrict IcountDecr to TCG, so the
inlined cpu_loop_exit_requested(), which is specific
to TCG, won't compile when TCG is disabled. Move it
to the new "exec/cpu-loop.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-12-philmd@linaro.org>
---
 include/exec/cpu-loop.h       | 35 +++++++++++++++++++++++++++++++++++
 include/exec/exec-all.h       | 17 -----------------
 accel/tcg/cpu-exec.c          |  1 +
 target/arm/tcg/helper-a64.c   |  1 +
 target/s390x/tcg/mem_helper.c |  1 +
 5 files changed, 38 insertions(+), 17 deletions(-)
 create mode 100644 include/exec/cpu-loop.h

diff --git a/include/exec/cpu-loop.h b/include/exec/cpu-loop.h
new file mode 100644
index 0000000000..36ce4064fd
--- /dev/null
+++ b/include/exec/cpu-loop.h
@@ -0,0 +1,35 @@
+/*
+ *  Translation CPU loop (target agnostic)
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+#ifndef TRANSLATION_CPU_LOOP_H
+#define TRANSLATION_CPU_LOOP_H
+
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
+#include "qemu/atomic.h"
+#include "hw/core/cpu.h"
+
+/**
+ * cpu_loop_exit_requested:
+ * @cpu: The CPU state to be tested
+ *
+ * Indicate if somebody asked for a return of the CPU to the main loop
+ * (e.g., via cpu_exit() or cpu_interrupt()).
+ *
+ * This is helpful for architectures that support interruptible
+ * instructions. After writing back all state to registers/memory, this
+ * call can be used to check if it makes sense to return to the main loop
+ * or to continue executing the interruptible instruction.
+ */
+static inline bool cpu_loop_exit_requested(CPUState *cpu)
+{
+    return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
+}
+
+#endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 2cd7b8f61b..544e35dd24 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -29,23 +29,6 @@
 #include "exec/translation-block.h"
 #include "qemu/clang-tsa.h"
 
-/**
- * cpu_loop_exit_requested:
- * @cpu: The CPU state to be tested
- *
- * Indicate if somebody asked for a return of the CPU to the main loop
- * (e.g., via cpu_exit() or cpu_interrupt()).
- *
- * This is helpful for architectures that support interruptible
- * instructions. After writing back all state to registers/memory, this
- * call can be used to check if it makes sense to return to the main loop
- * or to continue executing the interruptible instruction.
- */
-static inline bool cpu_loop_exit_requested(CPUState *cpu)
-{
-    return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
-}
-
 #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
 /* cputlb.c */
 /**
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 9af66bc191..eedba056ba 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -32,6 +32,7 @@
 #include "qemu/main-loop.h"
 #include "sysemu/cpus.h"
 #include "exec/cpu-all.h"
+#include "exec/cpu-loop.h"
 #include "sysemu/cpu-timers.h"
 #include "exec/replay-core.h"
 #include "sysemu/tcg.h"
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 0ea8668ab4..b294f6bfd0 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -29,6 +29,7 @@
 #include "internals.h"
 #include "qemu/crc32c.h"
 #include "exec/exec-all.h"
+#include "exec/cpu-loop.h"
 #include "exec/cpu_ldst.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 6a308c5553..8435825fa5 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -26,6 +26,7 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/cpu-loop.h"
 #include "exec/cpu_ldst.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "qemu/int128.h"
-- 
2.41.0


