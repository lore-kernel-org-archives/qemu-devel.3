Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0B0C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RVU-0000ZP-SF; Fri, 26 Apr 2024 15:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RVQ-0000O6-BQ
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:45:12 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RVM-0004UV-LN
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:45:11 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a5224dfa9adso459259966b.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160707; x=1714765507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fHVia7emVLdfn7RVXOtjmfvyr/0v1O15dG1Znnu+R50=;
 b=VD3YBFowYHVTRk8e3L62qHVwEIOEQEsQxbMsFQpb7h3ygY/AMtl2V+IYc1hJTcjuVh
 EYj8YrkW4v2IYWaS6z7GxpNGKVItl5nuMtMK0bvjdqNeKsX6VOv8QG6Rz3jqZgpDcrgQ
 FMZel/ZgcMaULcN1Zr79Nz2UMKPzmwS8O9vAYeTsT02VRfj1+4vnxuzxQ+H1Wi4v3V0F
 bjBQniObP8x7SfqCQHsww/B8VuaxyVyvGKabJwjC80N5+lWcdT5dFA8l3dOQFHTn2sz5
 bgTjSFDZgPM5I6kfUXWG2Huz/mXtFpYM2aHOShJOkkXXsPrV0i4SN197U4WFJBDXO+nK
 YQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160707; x=1714765507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fHVia7emVLdfn7RVXOtjmfvyr/0v1O15dG1Znnu+R50=;
 b=TAxK6CJlsCIbbrH/Qb/oZMEdOfmp3J/Gxpmk7EB8eY4dE5aocXtbdkxgPX6Lq0qIqZ
 sUhDAbhEX5JWf078bthltQWx+6GtLIJj7lE7sQciaExKjocxe3Xn6FtM++FFqK3a7syg
 XM/Y3e0eh2TqxI9HbQVXeZ8ZATCXNOzAOhZGHC6NyLXnnO9wFe73+K7wE1O163W0Z0FI
 QSaaO2WE1+YeRV62VAfdKh9vexUU7ORUYMLSVxulCOWvFQBAFujMhE1tfEUZ5WiqXulW
 sr75Tj+wrx7VK0QxCa+8CaTB7VqiDcdajFBosMEj/r9qkNPxKrD1F6U/iPx+YjsAEXIY
 Fb/A==
X-Gm-Message-State: AOJu0Yw9BuykF+ijp5dSaA1A7XgPRbK1ZerDEG4S8OYmtPYbAgZ9vm+V
 d2PZ8nWsdDgsqC47GYkcKjJQdAb2z+e5KCp0DyxR+K0F92NSRwGqthmKptKtGKybqddRtYiJ2RO
 4jOk=
X-Google-Smtp-Source: AGHT+IGwxX3sKiMVt+Tb+iGuFDgngNYesKSt7wg2nDlEikU8bCNCZuDDZwwjqhG0DfGij85yilw3Lg==
X-Received: by 2002:a17:906:d193:b0:a55:b2c0:a103 with SMTP id
 c19-20020a170906d19300b00a55b2c0a103mr2866142ejz.33.1714160706682; 
 Fri, 26 Apr 2024 12:45:06 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 ef15-20020a17090697cf00b00a58bcfa6610sm1863773ejb.185.2024.04.26.12.45.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:45:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 31/38] exec: Declare CPUBreakpoint/CPUWatchpoint type in
 'breakpoint.h' header
Date: Fri, 26 Apr 2024 21:41:51 +0200
Message-ID: <20240426194200.43723-32-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The CPUBreakpoint and CPUWatchpoint structures are declared
in "hw/core/cpu.h", which contains declarations related to
CPUState and CPUClass. Some source files only require the
BP/WP definitions and don't need to pull in all CPU* API.
In order to simplify, create a new "exec/breakpoint.h" header.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240418192525.97451-3-philmd@linaro.org>
---
 include/exec/breakpoint.h | 30 ++++++++++++++++++++++++++++++
 include/hw/core/cpu.h     | 16 +---------------
 target/arm/internals.h    |  1 +
 target/ppc/internal.h     |  1 +
 target/riscv/debug.h      |  2 ++
 5 files changed, 35 insertions(+), 15 deletions(-)
 create mode 100644 include/exec/breakpoint.h

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
new file mode 100644
index 0000000000..95f0482e6d
--- /dev/null
+++ b/include/exec/breakpoint.h
@@ -0,0 +1,30 @@
+/*
+ * QEMU breakpoint & watchpoint definitions
+ *
+ * Copyright (c) 2012 SUSE LINUX Products GmbH
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef EXEC_BREAKPOINT_H
+#define EXEC_BREAKPOINT_H
+
+#include "qemu/queue.h"
+#include "exec/vaddr.h"
+#include "exec/memattrs.h"
+
+typedef struct CPUBreakpoint {
+    vaddr pc;
+    int flags; /* BP_* */
+    QTAILQ_ENTRY(CPUBreakpoint) entry;
+} CPUBreakpoint;
+
+typedef struct CPUWatchpoint {
+    vaddr vaddr;
+    vaddr len;
+    vaddr hitaddr;
+    MemTxAttrs hitattrs;
+    int flags; /* BP_* */
+    QTAILQ_ENTRY(CPUWatchpoint) entry;
+} CPUWatchpoint;
+
+#endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 759c3e7d89..46b99a7ea5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -22,6 +22,7 @@
 
 #include "hw/qdev-core.h"
 #include "disas/dis-asm.h"
+#include "exec/breakpoint.h"
 #include "exec/hwaddr.h"
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
@@ -347,21 +348,6 @@ typedef struct CPUNegativeOffsetState {
     bool can_do_io;
 } CPUNegativeOffsetState;
 
-typedef struct CPUBreakpoint {
-    vaddr pc;
-    int flags; /* BP_* */
-    QTAILQ_ENTRY(CPUBreakpoint) entry;
-} CPUBreakpoint;
-
-struct CPUWatchpoint {
-    vaddr vaddr;
-    vaddr len;
-    vaddr hitaddr;
-    MemTxAttrs hitattrs;
-    int flags; /* BP_* */
-    QTAILQ_ENTRY(CPUWatchpoint) entry;
-};
-
 struct KVMState;
 struct kvm_run;
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index b53f5e8ff2..e40ec453d5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -25,6 +25,7 @@
 #ifndef TARGET_ARM_INTERNALS_H
 #define TARGET_ARM_INTERNALS_H
 
+#include "exec/breakpoint.h"
 #include "hw/registerfields.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "syndrome.h"
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 5b20ecbd33..601c0b533f 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -18,6 +18,7 @@
 #ifndef PPC_INTERNAL_H
 #define PPC_INTERNAL_H
 
+#include "exec/breakpoint.h"
 #include "hw/registerfields.h"
 
 /* PM instructions */
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index 5794aa6ee5..c347863578 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -22,6 +22,8 @@
 #ifndef RISCV_DEBUG_H
 #define RISCV_DEBUG_H
 
+#include "exec/breakpoint.h"
+
 #define RV_MAX_TRIGGERS         2
 
 /* register index of tdata CSRs */
-- 
2.41.0


