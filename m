Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F563CEFD0C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 23:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdGLB-0005Y6-Mo; Tue, 06 Jan 2026 18:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGL5-0005Rz-7i
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:19:47 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGL1-0001Ij-Sl
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:19:46 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so1013179f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 15:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767741582; x=1768346382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ky6fRx4jS/naL2rgxALVm23duns6ZzU/emXyduZp6IE=;
 b=wl7q9E6KB3ikL7RFqguo7D19zvpVIe+Ak7HmtynYGfrC/KXJ1NyTDp0G7pJWz2Juqt
 oQDKXL+2nIqN/bow/bqsfrG5aDsqgcSt0bUT52hfW51gHZTHl0Q36J/v7I9XNtD9d20A
 74pXOVIr0izdqLvZFDAX0ujofombw8y4iHNgsmpdbnKyWtAIVYUhvoVjsjmLUGwzo88k
 IROptQ+mwqjRibytSfpTdX51yp3vYQrBNWcjHCpNmh+L5k4ltYfhtJCpB0UYtgsJlQP3
 W4RN6GGLbPR4i0zhs24tzLawtQe6zss069Qe44SDce50bTeQVuBLJSYGVYKtt4d5AcbP
 eZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767741582; x=1768346382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ky6fRx4jS/naL2rgxALVm23duns6ZzU/emXyduZp6IE=;
 b=LTAoIIGlckAqLTzQOxtKCDPkc7KvyZNb6iUsfc+0NwcP3HTdUqxF0QKvAlN8tZP3Qh
 536kteZ673rB4OVC3LjlmINHZVAH5nezwMX2x0B5GngqdyJ44GwT80uK7XDYxozXS3BR
 NY0ooWNbwHgwKYjtUyRHU/uvOKBvUh9yzkVt/3HvlxkQrJ7HjiA/nZnoupDMuvTUPyI6
 Yq/GvCAeBhZY6h+OFK3i72HcwGOctTl7MREWwIu2f9qrPoFgLIGHcmbMI68ygNohHMoK
 Uog5I1oBeG/ANLLqaXxmYgewVhJnPWkPQhuWz6jy8XR+D8qlpp5HZum20Uy4MlNwW2OL
 WXTg==
X-Gm-Message-State: AOJu0YwnNlGRWCPWHS0QHARLlZOfh2y901TVsWamEboU1kIeKcTPai/B
 hq6ouzEIr2vlFIwTe02F0R5zvS6fuyCrCATwUk5ZOosVbTC6KdzY1dI4Qn4OmobYwPzxBMCF8e/
 8iZ4puxc=
X-Gm-Gg: AY/fxX6GpeHZzYIHjy2aKVuGgYEnaFWCJcWZ+0jRvOCTpeASuS4b5ErBhDkDFhP+qpx
 XGChUWAH9h2vo324LEq/4MgGV9RYqWaMSdkqDWClXezBJKHP6xSn7UzLUOD3BH5potRMO5JMO0n
 7DZoU/CTUzJwOHk53fTFSJCT1rLFaOPvZIfZPCTco0wRxv1Shtl5Q+u8LXY/2kjfhD4hFo1MWrN
 YOINpWVKSTYf4x/C83nov9oWLlHK7tkeuigQqg52UFr7zZrVL9vKdM9F5h4+8uSrjPYYDGJmidF
 /nbEO02ufHbKpjxyEnDoJRJ1Gb10SfitVbw8wAHDu9g1vvoetsVI1z8PmATDu9k1P+B0qEBC8pY
 HT6s7/FEX7XD+DSdm3PQaD78lv/+kjT+6VyCAFHw+C0g6RK1f4Ve1IrU42tHRwVfoSB79l5yC5e
 4EcNXlcD3oVClRklnlvSxLlJYUk5NWgORd9kc5WctB3kk8bsu2EjIQY9C+1tSN
X-Google-Smtp-Source: AGHT+IGIiCiXpG2WaQJ5VIHH5OE6VgwgnzSN69eb9AaCkABhaOwO7NBWCFVg4YBbHBAv3ZGd1bBlxg==
X-Received: by 2002:a05:6000:2509:b0:431:54c:6f0 with SMTP id
 ffacd0b85a97d-432c3760eb9mr688325f8f.4.1767741581878; 
 Tue, 06 Jan 2026 15:19:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ede7esm6874757f8f.32.2026.01.06.15.19.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 15:19:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>
Subject: [PATCH 4/5] accel/tcg: Un-inline WatchPoint API user-emulation stubs
Date: Wed,  7 Jan 2026 00:19:06 +0100
Message-ID: <20260106231908.16756-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106231908.16756-1-philmd@linaro.org>
References: <20260106231908.16756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Currently we can not build files including "exec/watchpoint.h"
as meson common objects because the CONFIG_USER_ONLY definition
is poisoned. We can easily fix that by un-inlining the
user-emulation stubs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/cpu-ops.h | 17 -----------------
 include/exec/watchpoint.h   | 23 -----------------------
 accel/tcg/user-exec-stub.c  | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index dd8ea300168..5950cdcaab1 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -281,21 +281,6 @@ struct TCGCPUOps {
 #endif /* !CONFIG_USER_ONLY */
 };
 
-#if defined(CONFIG_USER_ONLY)
-
-static inline void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
-                                        MemTxAttrs atr, int fl, uintptr_t ra)
-{
-}
-
-static inline int cpu_watchpoint_address_matches(CPUState *cpu,
-                                                 vaddr addr, vaddr len)
-{
-    return 0;
-}
-
-#else
-
 /**
  * cpu_check_watchpoint:
  * @cpu: cpu context
@@ -328,6 +313,4 @@ int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
 vaddr cpu_pointer_wrap_notreached(CPUState *, int, vaddr, vaddr);
 vaddr cpu_pointer_wrap_uint32(CPUState *, int, vaddr, vaddr);
 
-#endif
-
 #endif /* TCG_CPU_OPS_H */
diff --git a/include/exec/watchpoint.h b/include/exec/watchpoint.h
index 4b6668826c7..c4d069425ba 100644
--- a/include/exec/watchpoint.h
+++ b/include/exec/watchpoint.h
@@ -8,34 +8,11 @@
 #ifndef EXEC_WATCHPOINT_H
 #define EXEC_WATCHPOINT_H
 
-#if defined(CONFIG_USER_ONLY)
-static inline int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                                        int flags, CPUWatchpoint **watchpoint)
-{
-    return -ENOSYS;
-}
-
-static inline int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
-                                        vaddr len, int flags)
-{
-    return -ENOSYS;
-}
-
-static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
-                                                CPUWatchpoint *wp)
-{
-}
-
-static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
-{
-}
-#else
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           int flags, CPUWatchpoint **watchpoint);
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
                           vaddr len, int flags);
 void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
-#endif
 
 #endif /* EXEC_WATCHPOINT_H */
diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 1d52f48226a..28286e11a60 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -1,6 +1,8 @@
 #include "qemu/osdep.h"
 #include "hw/core/cpu.h"
+#include "accel/tcg/cpu-ops.h"
 #include "exec/replay-core.h"
+#include "exec/watchpoint.h"
 #include "internal-common.h"
 
 void cpu_resume(CPUState *cpu)
@@ -19,6 +21,37 @@ void cpu_exec_reset_hold(CPUState *cpu)
 {
 }
 
+int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+                          int flags, CPUWatchpoint **watchpoint)
+{
+    return -ENOSYS;
+}
+
+int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
+                          vaddr len, int flags)
+{
+    return -ENOSYS;
+}
+
+void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *wp)
+{
+}
+
+void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
+{
+}
+
+int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
+{
+    return 0;
+}
+
+void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
+                          MemTxAttrs atr, int fl, uintptr_t ra)
+{
+}
+
+
 /* User mode emulation does not support softmmu yet.  */
 
 void tlb_init(CPUState *cpu)
-- 
2.52.0


