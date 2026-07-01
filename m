Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87506C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welG3-0005pG-Py; Tue, 30 Jun 2026 23:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFu-0005gw-2o
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:04:56 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFq-0002ns-Lc
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:04:53 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2c7ebfb63c6so1375655ad.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782875088; x=1783479888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYQVNWpWGwmaVZc4jT8q1D8DLBPAuVdV88yXOr2IM3U=;
 b=iabYDam/BRf1WY0sPLi64df++03gX1uJoSxWj+aPpA71NYglojakXsun5X1xPb48OU
 /z6+FgRhHhroZiZAvSAVy8TrYB6wfUWJI7Um4NvdwoYfaAZhXnoCRPBFEmAK2Exz90fV
 iswi1wCTtqg0Sa6sNOpa3vASyUEyEuA3+JcDXptd/mIBrr3Zjd2Rxs8bEEz8sDqpUsou
 DivJh+8QwEpEP1lC6/Cr4XvZ1RVgxw/j5HdK7+zVTinm6Kza5bbA+5knuHFhyaLvG4xz
 gnO5J6dEXXXF9vAetnAB/Ym8CEHwJQd0dPVKnhwwgvZ56I1/0OPuz+oIM/VOBz119Ipu
 15Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782875088; x=1783479888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QYQVNWpWGwmaVZc4jT8q1D8DLBPAuVdV88yXOr2IM3U=;
 b=PsdizAK/35GScQk6/ab1uAPip6sJM+PkaWDNQ48S+tW5QDfQYcCl827isWmg5Ifn7X
 v6VGSApoqK8mz+Roc6RSBCvKMxgivW+FGY8ZzILjGfolT+FJwKWB4zjPScX6h4b8qy2X
 bipcBFCkFA44CaJSvV/twh9x5zcjnchrxWpRvQIEpceqLZRr2U6UIqD3fzalB22tn24L
 8W/hdFXliVjMMljMb+kHVU+yvaG8QjBRQ3/5muW+7zVGzJjhmPcLGQ4jAdu+s50jj+l4
 6vd2anvUGuQOtJe6Qk5NIxYiZJ6vwNCVFVb59FR56YtEWduqmlDUAJOhrXW0WLbREHb5
 R/oQ==
X-Gm-Message-State: AOJu0Ywbs8RIEBNRBbAyLAyNRSGwQlwVC6aAHil9O/UGz6ePaSEaEagJ
 xFdjarzynptz51XsN2Vat1Q0+sBU2TTyi0EIAJ7r/875CVlNuIZFr8yHUYFe6SpopIJ0gNJJOjd
 L7CBk
X-Gm-Gg: AfdE7cklM2NUq5x287v+yqianStP+nsiF4uVjiQWZNKQvyvVCBNktfvfL+Af4QdJrQs
 1qXE+8B8VR7fSsZRIAfAMSOn9BWgkWfmH8WN8etdVY97x29+UZhubpRAG+glnYP9YrUY5TeRuH6
 rL2RE9KLV60a1n6nmtluY0kXSgnH4hEsXSqhWxxu0WMYnhPH86swHGuQy/gAkFgYDnxUJ62PBgL
 4HDdfsv5u/C2+WlogW1LnldIAuwxK9VW1LFDVOu15jcY/y1GeSWULaEn+ofVBP7Zkvx4eB+/o5F
 /LqvHBkH/5uU9fTzoyINvrWaELo7DoVZdL2J3ZP3NRY5AG9z7Z7aB1iQ3CRHH6tFZ9ML8wNrIJm
 IEcwiBVsBHMkjQrO/ReXOY4s4B7CmLdR/qCvmzx6ynM+PYcknnisTCfy4FVrxKbhhMoDaq3MsX+
 cMpS29JjZU43GAHS9KXiRs9VVJbtrjJqywJTYicQkXg8YR7MPGjg==
X-Received: by 2002:a17:903:41c8:b0:2c9:c952:6e9 with SMTP id
 d9443c01a7336-2ca2d52ad0amr52835295ad.2.1782875088326; 
 Tue, 30 Jun 2026 20:04:48 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37c74261sm23758085ad.22.2026.06.30.20.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 20:04:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 04/17] exec/breakpoint: Move BP declarations from hw/core/cpu.h
Date: Tue, 30 Jun 2026 20:04:30 -0700
Message-ID: <20260701030443.1382447-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701030443.1382447-1-richard.henderson@linaro.org>
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/breakpoint.h | 21 +++++++++++++++++++++
 include/hw/core/cpu.h     | 21 ---------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index 95f0482e6d..4013d9a07c 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -12,6 +12,20 @@
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
 
+/* Breakpoint/watchpoint flags */
+#define BP_MEM_READ           0x01
+#define BP_MEM_WRITE          0x02
+#define BP_MEM_ACCESS         (BP_MEM_READ | BP_MEM_WRITE)
+#define BP_STOP_BEFORE_ACCESS 0x04
+/* 0x08 currently unused */
+#define BP_GDB                0x10
+#define BP_CPU                0x20
+#define BP_ANY                (BP_GDB | BP_CPU)
+#define BP_HIT_SHIFT          6
+#define BP_WATCHPOINT_HIT_READ  (BP_MEM_READ << BP_HIT_SHIFT)
+#define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
+#define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
+
 typedef struct CPUBreakpoint {
     vaddr pc;
     int flags; /* BP_* */
@@ -27,4 +41,11 @@ typedef struct CPUWatchpoint {
     QTAILQ_ENTRY(CPUWatchpoint) entry;
 } CPUWatchpoint;
 
+int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
+                          CPUBreakpoint **breakpoint);
+int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags);
+void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
+void cpu_breakpoint_remove_all(CPUState *cpu, int mask);
+bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask);
+
 #endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b853824e47..e05e261883 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1138,27 +1138,6 @@ void qemu_init_vcpu(CPUState *cpu);
  */
 void cpu_single_step(CPUState *cpu, int enabled);
 
-/* Breakpoint/watchpoint flags */
-#define BP_MEM_READ           0x01
-#define BP_MEM_WRITE          0x02
-#define BP_MEM_ACCESS         (BP_MEM_READ | BP_MEM_WRITE)
-#define BP_STOP_BEFORE_ACCESS 0x04
-/* 0x08 currently unused */
-#define BP_GDB                0x10
-#define BP_CPU                0x20
-#define BP_ANY                (BP_GDB | BP_CPU)
-#define BP_HIT_SHIFT          6
-#define BP_WATCHPOINT_HIT_READ  (BP_MEM_READ << BP_HIT_SHIFT)
-#define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
-#define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
-
-int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
-                          CPUBreakpoint **breakpoint);
-int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags);
-void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
-void cpu_breakpoint_remove_all(CPUState *cpu, int mask);
-bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask);
-
 /**
  * cpu_get_address_space:
  * @cpu: CPU to get address space from
-- 
2.43.0


