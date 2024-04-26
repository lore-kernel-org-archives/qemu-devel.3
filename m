Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32F8C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RUb-0004Eo-5d; Fri, 26 Apr 2024 15:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RTw-000294-N8
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:43:41 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RTq-0003BT-Aj
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:43:40 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56e48d0a632so3784688a12.2
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160612; x=1714765412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ledkbh8k2HTuIvDABWBQUBebX3R5+DXtp/0ED5fWzA=;
 b=YDpF/XGp+M9BknmM5aeV92FaUZY+j0g8hSbONhONijwA12TaFNGex9mLxFfQAe5G9c
 ySMduJHjAuLN2zvjLpb31xn3EvxD4IZ59qD5Q+sp7IMTVb+PHVjqUW7aFyyBuxKlKS5H
 ASYC88Imx1YX0chAvDG86J72dZkm88ts54BVookVk+QAAeXLyh+aQmNqEmNw34lV4Jlt
 EewiQ6aM+A4UZ/FTweCiEwary/pKV5jyNujNpl4Eb2UVtWgjzZFcwh90Ymn/cE5B7c3i
 A/ikPaD3i7J7Ivf4o5sPLr8nACNlsg2ih+7ZvYUroFnPiZxNXVERfxuyeM1dPAtbaK7A
 ugpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160612; x=1714765412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ledkbh8k2HTuIvDABWBQUBebX3R5+DXtp/0ED5fWzA=;
 b=NOhwacle6J+1KWRSHPTrK0GKftefyWGOrIFWKrQHGxHaBi9jEHlBLHbnJjSmAIr6so
 RkUd23MeoA00FxUV/CIDLdTrAwN+6bqrRqdNMcw1vm9rPJyDmWzLFSY7X2LQ1USTBb3D
 HvrORUjcaKi+KoMuun9iYjVzUrCpKkRzilMRi68Ag93F7J24+HZsUrtYiib+GV+0akjC
 kVkw5AHTuNhzhofgJCDRRis1Hot465Js13p7NgK0PEuZ/Uhomy0209nH8o+OvwqsuSzu
 GKR6/yr59aWoMHtIrG3kTYb60KF6YYWiqUE11zUNB8vBTgrkZsYu/S8kTEew3Sopoa8t
 KrxA==
X-Gm-Message-State: AOJu0YzK2Aa47RrZH9GDtGf6Sm66Lr5jYImJbUvC297ybw6S8YZF6I1P
 6b8Lj6EN64VqhNTp+XHEqY78vv5A3NeBsSpahpKwzVEMmFPl8TN6L7F/CT5ceOulJmx/zf4L0/+
 p0d8=
X-Google-Smtp-Source: AGHT+IFaNie4351cxQ1jjTm+AA+xkAzxC2c9vg5NMcqycaPkVZmd/j8wB9L9GrQ6crtroyZ0xLvBBg==
X-Received: by 2002:aa7:cb8c:0:b0:572:637b:c7e1 with SMTP id
 r12-20020aa7cb8c000000b00572637bc7e1mr1039807edt.21.1714160612244; 
 Fri, 26 Apr 2024 12:43:32 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 be12-20020a0564021a2c00b0056bf7f92346sm10310057edb.50.2024.04.26.12.43.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:43:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Subject: [PULL 15/38] accel/tcg: Un-inline retaddr helpers to 'user-retaddr.h'
Date: Fri, 26 Apr 2024 21:41:35 +0200
Message-ID: <20240426194200.43723-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

set_helper_retaddr() is only used in accel/tcg/user-exec.c.

clear_helper_retaddr() is only used in accel/tcg/cpu-exec.c
and accel/tcg/user-exec.c.

No need to expose their definitions to all user-emulation
files including "exec/cpu_ldst.h", move them to a new
"user-retaddr.h" header (restricted to accel/tcg/).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231211212003.21686-19-philmd@linaro.org>
---
 accel/tcg/user-retaddr.h | 28 ++++++++++++++++++++++++++++
 include/exec/cpu_ldst.h  | 28 ++--------------------------
 accel/tcg/cpu-exec.c     |  3 +++
 accel/tcg/user-exec.c    |  1 +
 4 files changed, 34 insertions(+), 26 deletions(-)
 create mode 100644 accel/tcg/user-retaddr.h

diff --git a/accel/tcg/user-retaddr.h b/accel/tcg/user-retaddr.h
new file mode 100644
index 0000000000..e0f57e1994
--- /dev/null
+++ b/accel/tcg/user-retaddr.h
@@ -0,0 +1,28 @@
+#ifndef ACCEL_TCG_USER_RETADDR_H
+#define ACCEL_TCG_USER_RETADDR_H
+
+#include "qemu/atomic.h"
+
+extern __thread uintptr_t helper_retaddr;
+
+static inline void set_helper_retaddr(uintptr_t ra)
+{
+    helper_retaddr = ra;
+    /*
+     * Ensure that this write is visible to the SIGSEGV handler that
+     * may be invoked due to a subsequent invalid memory operation.
+     */
+    signal_barrier();
+}
+
+static inline void clear_helper_retaddr(void)
+{
+    /*
+     * Ensure that previous memory operations have succeeded before
+     * removing the data visible to the signal handler.
+     */
+    signal_barrier();
+    helper_retaddr = 0;
+}
+
+#endif
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index eb8f3f0595..82690d3947 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -300,31 +300,7 @@ Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, abi_ptr addr,
                                   Int128 cmpv, Int128 newv,
                                   MemOpIdx oi, uintptr_t retaddr);
 
-#if defined(CONFIG_USER_ONLY)
-
-extern __thread uintptr_t helper_retaddr;
-
-static inline void set_helper_retaddr(uintptr_t ra)
-{
-    helper_retaddr = ra;
-    /*
-     * Ensure that this write is visible to the SIGSEGV handler that
-     * may be invoked due to a subsequent invalid memory operation.
-     */
-    signal_barrier();
-}
-
-static inline void clear_helper_retaddr(void)
-{
-    /*
-     * Ensure that previous memory operations have succeeded before
-     * removing the data visible to the signal handler.
-     */
-    signal_barrier();
-    helper_retaddr = 0;
-}
-
-#else
+#if !defined(CONFIG_USER_ONLY)
 
 #include "tcg/oversized-guest.h"
 
@@ -376,7 +352,7 @@ static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
     return &cpu->neg.tlb.f[mmu_idx].table[tlb_index(cpu, mmu_idx, addr)];
 }
 
-#endif /* defined(CONFIG_USER_ONLY) */
+#endif /* !defined(CONFIG_USER_ONLY) */
 
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5c70748060..225e5fbd3e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -41,6 +41,9 @@
 #include "tb-context.h"
 #include "internal-common.h"
 #include "internal-target.h"
+#if defined(CONFIG_USER_ONLY)
+#include "user-retaddr.h"
+#endif
 
 /* -icount align implementation. */
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 3cac3a78c4..1c621477ad 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -31,6 +31,7 @@
 #include "tcg/tcg-ldst.h"
 #include "internal-common.h"
 #include "internal-target.h"
+#include "user-retaddr.h"
 
 __thread uintptr_t helper_retaddr;
 
-- 
2.41.0


