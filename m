Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786BAD64062
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 06:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVlCk-00078K-7K; Wed, 17 Dec 2025 01:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vVlCh-00077H-5U
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 01:40:07 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vVlCe-0006uA-8s
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 01:40:06 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34cf1e31f85so807138a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 22:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765953601; x=1766558401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t3iwmbOYCjXdXUNhd7VjiSslObz2RgyQrl9ndYDPsIA=;
 b=I5y8GSlf/hKFrNwa5VZ5/1gtdSVa85lqY6x9ARytyV5q5Rz9vLa/OswAtIDhg2T/P3
 YYLUBwJ/ubz8WS0VyzXp1DFIB2WR9fqNBejWZ5uHfoyKHbwOWDi5hfJEm9xzi6OduA3P
 /BCLsq5QAtrNxGKTrF3P6PzvPKYubMhj0Q3mux1srhuMBTto3eyqdDWgn+FAOk1BS4vN
 myL1uS5fUdIXdWLh5qBA6X5uBzZmZeZUl7ZwZVzX6+DTqlj0mh53xIMPmoJRsiq580cy
 18b+NLPI8ooBII46vNdPIIL76mGGzor+nlZiTAahPHpVz3z5MWHnYZPIaHPJSKDnng4s
 S6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765953602; x=1766558402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3iwmbOYCjXdXUNhd7VjiSslObz2RgyQrl9ndYDPsIA=;
 b=MEoShCBxhhHyQPGTveLuj4E/4Y2XJ/xsqSliLE5OLdd/goNsCEaA7yh6cWGeQGvNu+
 0c9DwfD4oPK5dwcgHOocz9gTLb67R28rjs4ICr2MJUZiwFZBBstNDPF+Lr2SqCQLU2i5
 ryEiIqod1FtLVWOo+5lbyjgjhvWpVguqzEN7oA+Uf5ZwIbDv7X1+KvAEBd87XiNzh9gL
 BTxPhZ+f0tq1jDxvMdoU4NHQ29glQB3KZ9AXTvmbYwo/fayvgfM0Lm92340QtP+b54L7
 p4jP8z2pqN0uN3+CqUt3czlADzAUsFYi4VYbYHBIc+RbZ5+4HC+jjv27v+N5VMNeIMZK
 DxwQ==
X-Gm-Message-State: AOJu0YwOPOK24riIvtKR0NXH9KSXiN+IsexcrHDok3IvTgE1bh8/1pY5
 dLLpWKdFTMgtKBaLHXvqPjBnfpXavcYWpc/0Ay+ltvpSKpqOB60j9R/qAec64S1QO10nCYHmIHC
 /U/yZhOq9DoAOCwS2gAnOEGu2U9pAMlVqJyJqX/KAbQPpSjP0UBrEZBtlj9mKeqtYcHmXDxT8UE
 3WqBtEDIkjWgtxsB+CJl0C/+YNVt7li5RuPSVV528yph8=
X-Gm-Gg: AY/fxX6xxIobF016RQAtC7jH0MC2VHOW0LaUHmuou8h1MbqJZyCc6fjFfubxt12x2bm
 DWcX2QZ6hKanMqQ7pjNGUZpDFgiE4Nl7WrEHWY3yNDSbQ0Og7Mk90DeVMq7xq69wYjtRYdOs8j1
 SYk1CwXvxP+LhLlUeuVPQvTvdvTbKDJyH5Wh0rFOleLFgRJj8wfc3Y5px0HfbBB4P0A1Yif9Szg
 TLgZib0oYqn18ySHWjKp2nBpML/E5ftZ0opUXcsM5JYE6zufRF0Ck+L0bjNWKgHzOhJQoeWKXmm
 33pYfNqARt8W4W1FzP6962JhjpBU+rFv4KawrlOAEoIiceBrM9bHnfpaYE66fMbN4QX1JRXOwFa
 YtofBp+OsLIqAoMcqqiL62aa7DjdhuHyPaPlGmU+Jo17Wj4vzsZEt3FDK0DtsWuVPheQPcHCIea
 b7r/TaZs5jphXdnTTBBvOR/F+gUccY2oinr+/7EQ==
X-Google-Smtp-Source: AGHT+IH4htit06dL6FFJWyBBYjSQpV0OVEA8xN2Mv28ZkCAe5tYXlS/nT9PhB2w40shlrQU28aQMUw==
X-Received: by 2002:a17:90b:1806:b0:343:7714:4ca6 with SMTP id
 98e67ed59e1d1-34abd7617b6mr14428803a91.22.1765953601330; 
 Tue, 16 Dec 2025 22:40:01 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34cd40eb2b9sm1488879a91.2.2025.12.16.22.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 22:40:00 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH] target/riscv: Initialize riscv_excp_names[] and
 riscv_intr_names[] using designated initializer
Date: Wed, 17 Dec 2025 14:39:55 +0800
Message-ID: <20251217063955.1037737-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x102a.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Use designated initializers to initialize riscv_excp_names[] and
riscv_intr_names[] so that we don't have to explicitly add "reserved"
items.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 89 +++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index aa58ba8b99a..ee859093f78 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -305,60 +305,61 @@ const char * const riscv_rvv_regnames[] = {
 };
 
 static const char * const riscv_excp_names[] = {
-    "misaligned_fetch",
-    "fault_fetch",
-    "illegal_instruction",
-    "breakpoint",
-    "misaligned_load",
-    "fault_load",
-    "misaligned_store",
-    "fault_store",
-    "user_ecall",
-    "supervisor_ecall",
-    "hypervisor_ecall",
-    "machine_ecall",
-    "exec_page_fault",
-    "load_page_fault",
-    "reserved",
-    "store_page_fault",
-    "double_trap",
-    "reserved",
-    "reserved",
-    "reserved",
-    "guest_exec_page_fault",
-    "guest_load_page_fault",
-    "reserved",
-    "guest_store_page_fault",
+    [RISCV_EXCP_INST_ADDR_MIS] = "misaligned_fetch",
+    [RISCV_EXCP_INST_ACCESS_FAULT] = "fault_fetch",
+    [RISCV_EXCP_ILLEGAL_INST] = "illegal_instruction",
+    [RISCV_EXCP_BREAKPOINT] = "breakpoint",
+    [RISCV_EXCP_LOAD_ADDR_MIS] = "misaligned_load",
+    [RISCV_EXCP_LOAD_ACCESS_FAULT] = "fault_load",
+    [RISCV_EXCP_STORE_AMO_ADDR_MIS] = "misaligned_store",
+    [RISCV_EXCP_STORE_AMO_ACCESS_FAULT] = "fault_store",
+    [RISCV_EXCP_U_ECALL] = "user_ecall",
+    [RISCV_EXCP_S_ECALL] = "supervisor_ecall",
+    [RISCV_EXCP_VS_ECALL] = "hypervisor_ecall",
+    [RISCV_EXCP_M_ECALL] = "machine_ecall",
+    [RISCV_EXCP_INST_PAGE_FAULT] = "exec_page_fault",
+    [RISCV_EXCP_LOAD_PAGE_FAULT] = "load_page_fault",
+    [RISCV_EXCP_STORE_PAGE_FAULT] = "store_page_fault",
+    [RISCV_EXCP_DOUBLE_TRAP] = "double_trap",
+    [RISCV_EXCP_SW_CHECK] = "sw_check",
+    [RISCV_EXCP_HW_ERR] = "hw_error",
+    [RISCV_EXCP_INST_GUEST_PAGE_FAULT] = "guest_exec_page_fault",
+    [RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT] = "guest_load_page_fault",
+    [RISCV_EXCP_VIRT_INSTRUCTION_FAULT] = "virt_illegal_instruction",
+    [RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT] = "guest_store_page_fault",
+    [RISCV_EXCP_SEMIHOST] = "semihost",
 };
 
 static const char * const riscv_intr_names[] = {
-    "u_software",
-    "s_software",
-    "vs_software",
-    "m_software",
-    "u_timer",
-    "s_timer",
-    "vs_timer",
-    "m_timer",
-    "u_external",
-    "s_external",
-    "vs_external",
-    "m_external",
-    "reserved",
-    "reserved",
-    "reserved",
-    "reserved"
+    [IRQ_U_SOFT] = "u_software",
+    [IRQ_S_SOFT] = "s_software",
+    [IRQ_VS_SOFT] = "vs_software",
+    [IRQ_M_SOFT] = "m_software",
+    [IRQ_U_TIMER] = "u_timer",
+    [IRQ_S_TIMER] = "s_timer",
+    [IRQ_VS_TIMER] = "vs_timer",
+    [IRQ_M_TIMER] = "m_timer",
+    [IRQ_U_EXT] = "u_external",
+    [IRQ_S_EXT] = "s_external",
+    [IRQ_VS_EXT] = "vs_external",
+    [IRQ_M_EXT] = "m_external",
+    [IRQ_S_GEXT] = "s_guest_external",
+    [IRQ_PMU_OVF] = "counter_overflow",
 };
 
 const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
 {
     if (async) {
-        return (cause < ARRAY_SIZE(riscv_intr_names)) ?
-               riscv_intr_names[cause] : "(unknown)";
+        if ((cause < ARRAY_SIZE(riscv_intr_names)) && riscv_intr_names[cause]) {
+            return riscv_intr_names[cause];
+        }
     } else {
-        return (cause < ARRAY_SIZE(riscv_excp_names)) ?
-               riscv_excp_names[cause] : "(unknown)";
+        if ((cause < ARRAY_SIZE(riscv_excp_names)) && riscv_excp_names[cause]) {
+            return riscv_excp_names[cause];
+        }
     }
+
+    return "(unknown)";
 }
 
 void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
-- 
2.43.0


