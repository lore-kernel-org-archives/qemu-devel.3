Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E33FCEFD0C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 23:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdGL2-0005Mb-8Q; Tue, 06 Jan 2026 18:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGKq-0005DS-Dh
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:19:33 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdGKn-0001E4-LK
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 18:19:32 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso2601655e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 15:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767741568; x=1768346368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pD7Mewu4hIr0e5mQRsO3Q7vuGfas+TRDeUMaumdJ2i8=;
 b=zqlJY8J11XygWbrubH0Nl9791TmzdUAFMWub8Y3scWjKxIJK4IwjDng4XaknIbNHst
 E1Ws3U+oM2rcO7F+MXcoiWrTmsSyJYuJJ1fT8sjnoyaNqq5V9G/wOIuakuOuIifgaPXb
 Y6jcOajI2Ynux8YQbCWqNH+kyYajsxT+dQIGVxsXj4fh3hE0JzK9b36RQ20sGjVwmikB
 A/HOskHgacZIw4Lo/eFYAIVnmzf6LLD/y7XuMK5j9PjmLLymujFOwWKqWyMlRSX7JDMw
 tdSXmwBSXIvR2Pdv0WwGNWBuXRjBWga7WMscWz50vk2CbUhVW7nNmH/zwkXV+CkJoS5v
 RBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767741568; x=1768346368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pD7Mewu4hIr0e5mQRsO3Q7vuGfas+TRDeUMaumdJ2i8=;
 b=b/75BeLl32d4v/83pY3inkHPak+7ZXQQXwqgdEQ0qodS736Hc0caqxpx97MhANxc2h
 jSc1c164DgTOXgEp9yLc6SSgMzTjCRkIR/dIdUlMMUZRD4ybdpp1+NxgrHcrnkZbsyIU
 0z6IejPqqKkaYs6RNACzP2wCaHywPSvzxTQtSOILnmsmRe4ddZ37a5umCQYGvMVPKBhC
 Glve6CJIvPtJRTxB+cGxnM2WbFk/jhXH3vft9o4ATDvkzTesTcgKKn7BpVEsO8iGIj8O
 dkbJpbF4S7hVDtlnOvEqC3Vx0QqSi5f7rQqlUzMQzf5xIAl39adG6exFgpcI+83jwW6k
 jwLg==
X-Gm-Message-State: AOJu0YxvrHofGbjBAR80avAi/HP3aDMMk7mWoWASfvLj3wPqqTkx/Z+q
 XDnmk7egagflCQqTfC61Hmbawy68H57EFeAU5mumwE047zJjB5bISX4DdydGpZh6px4a99d8qQc
 y9v40LHxJCQ==
X-Gm-Gg: AY/fxX4qitVBW5UtLU0kqfniIPnkQdwFJAPxkQ1gWNLRFfNKev3X2Ucm41RV4TqiOZ1
 wLJBLd/p4ZOdIvA4dE7f7455N7yKU371/s4GIQl8JxmCbmNjWP/OFCxIOL9elGoiyDNHeyqFHAr
 VItW87eQY1mEB/iI2zlsNoJdHNiUak0efs4k0Zh2kXtsFQZoDZYTBaQVFngto36flCv3P/d3MX3
 1sId2jj//zqrc48v/zy3bZH71zxSUuEL4hYj285nywOu3KVlL9yqvjPpj319+BNXM60c3kf7rQU
 jb5PdnPc+f0zYQ2AzHnQBHtdZUF1timfKeobkMmchp6jHUfxnk8gO39RCQzhX0D2mbBargoKUXG
 9kAVFu53dYy+4u9ZBFsq6yWZs2bu1ZOAbh90BxuFXMrrCGHz4KDNw3D2mmrpFPlMvdhvRRhcLKt
 WS6E+iwqmTWWXUEtRd2M2MTLLK6ErOy+ImopFZaPabBi+MzCbyhEsjxzEzD3t/
X-Google-Smtp-Source: AGHT+IECKEgzr3dFU2uBOsccVLYHAGq2i0VVMFPo8p+dDkAVSg+JZ8APSzHetbY3BlHIFmu7xBbk5Q==
X-Received: by 2002:a05:600c:3ba9:b0:477:9d88:2da6 with SMTP id
 5b1f17b1804b1-47d847d0f30mr8777615e9.0.1767741567887; 
 Tue, 06 Jan 2026 15:19:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7fb2a0fbsm28778325e9.8.2026.01.06.15.19.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 15:19:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 2/5] target/ppc: Restrict WatchPoint API to TCG
Date: Wed,  7 Jan 2026 00:19:04 +0100
Message-ID: <20260106231908.16756-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106231908.16756-1-philmd@linaro.org>
References: <20260106231908.16756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

Watchpoints are specific to the TCG accelerator. Since the
Data Address Watchpoint helpers are only called from
translated code, move them to a new 'watchpoint.c' file,
specific to TCG. Thus restricting the WatchPoint API to TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.c        | 81 +----------------------------------
 target/ppc/watchpoint.c | 93 +++++++++++++++++++++++++++++++++++++++++
 target/ppc/meson.build  |  1 +
 3 files changed, 96 insertions(+), 79 deletions(-)
 create mode 100644 target/ppc/watchpoint.c

diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 4d8faaddee2..9cb3f00aa88 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -131,85 +131,8 @@ void ppc_store_ciabr(CPUPPCState *env, target_ulong val)
     ppc_update_ciabr(env);
 }
 
-void ppc_update_daw(CPUPPCState *env, int rid)
-{
-    CPUState *cs = env_cpu(env);
-    int spr_dawr = rid ? SPR_DAWR1 : SPR_DAWR0;
-    int spr_dawrx = rid ? SPR_DAWRX1 : SPR_DAWRX0;
-    target_ulong deaw = env->spr[spr_dawr] & PPC_BITMASK(0, 60);
-    uint32_t dawrx = env->spr[spr_dawrx];
-    int mrd = extract32(dawrx, PPC_BIT_NR(48), 54 - 48);
-    bool dw = extract32(dawrx, PPC_BIT_NR(57), 1);
-    bool dr = extract32(dawrx, PPC_BIT_NR(58), 1);
-    bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
-    bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
-    bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
-    vaddr len;
-    int flags;
-
-    if (env->dawr_watchpoint[rid]) {
-        cpu_watchpoint_remove_by_ref(cs, env->dawr_watchpoint[rid]);
-        env->dawr_watchpoint[rid] = NULL;
-    }
-
-    if (!dr && !dw) {
-        return;
-    }
-
-    if (!hv && !sv && !pr) {
-        return;
-    }
-
-    len = (mrd + 1) * 8;
-    flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
-    if (dr) {
-        flags |= BP_MEM_READ;
-    }
-    if (dw) {
-        flags |= BP_MEM_WRITE;
-    }
-
-    cpu_watchpoint_insert(cs, deaw, len, flags, &env->dawr_watchpoint[rid]);
-}
-
-void ppc_store_dawr0(CPUPPCState *env, target_ulong val)
-{
-    env->spr[SPR_DAWR0] = val;
-    ppc_update_daw(env, 0);
-}
-
-static void ppc_store_dawrx(CPUPPCState *env, uint32_t val, int rid)
-{
-    int hrammc = extract32(val, PPC_BIT_NR(56), 1);
-
-    if (hrammc) {
-        /* This might be done with a second watchpoint at the xor of DEAW[0] */
-        qemu_log_mask(LOG_UNIMP, "%s: DAWRX%d[HRAMMC] is unimplemented\n",
-                      __func__, rid);
-    }
-
-    env->spr[rid ? SPR_DAWRX1 : SPR_DAWRX0] = val;
-    ppc_update_daw(env, rid);
-}
-
-void ppc_store_dawrx0(CPUPPCState *env, uint32_t val)
-{
-    ppc_store_dawrx(env, val, 0);
-}
-
-void ppc_store_dawr1(CPUPPCState *env, target_ulong val)
-{
-    env->spr[SPR_DAWR1] = val;
-    ppc_update_daw(env, 1);
-}
-
-void ppc_store_dawrx1(CPUPPCState *env, uint32_t val)
-{
-    ppc_store_dawrx(env, val, 1);
-}
-
-#endif
-#endif
+#endif /* TARGET_PPC64 */
+#endif /* !CONFIG_USER_ONLY */
 
 static inline void fpscr_set_rounding_mode(CPUPPCState *env)
 {
diff --git a/target/ppc/watchpoint.c b/target/ppc/watchpoint.c
new file mode 100644
index 00000000000..c71dd4550b7
--- /dev/null
+++ b/target/ppc/watchpoint.c
@@ -0,0 +1,93 @@
+/*
+ * PowerPC watchpoint routines for QEMU
+ *
+ * Copyright (c) 2017 Nikunj A Dadhania, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "exec/log.h"
+#include "accel/tcg/watchpoint.h"
+#include "target/ppc/cpu.h"
+
+#if defined(TARGET_PPC64)
+
+void ppc_update_daw(CPUPPCState *env, int rid)
+{
+    CPUState *cs = env_cpu(env);
+    int spr_dawr = rid ? SPR_DAWR1 : SPR_DAWR0;
+    int spr_dawrx = rid ? SPR_DAWRX1 : SPR_DAWRX0;
+    target_ulong deaw = env->spr[spr_dawr] & PPC_BITMASK(0, 60);
+    uint32_t dawrx = env->spr[spr_dawrx];
+    int mrd = extract32(dawrx, PPC_BIT_NR(48), 54 - 48);
+    bool dw = extract32(dawrx, PPC_BIT_NR(57), 1);
+    bool dr = extract32(dawrx, PPC_BIT_NR(58), 1);
+    bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
+    bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
+    bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
+    vaddr len;
+    int flags;
+
+    if (env->dawr_watchpoint[rid]) {
+        cpu_watchpoint_remove_by_ref(cs, env->dawr_watchpoint[rid]);
+        env->dawr_watchpoint[rid] = NULL;
+    }
+
+    if (!dr && !dw) {
+        return;
+    }
+
+    if (!hv && !sv && !pr) {
+        return;
+    }
+
+    len = (mrd + 1) * 8;
+    flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
+    if (dr) {
+        flags |= BP_MEM_READ;
+    }
+    if (dw) {
+        flags |= BP_MEM_WRITE;
+    }
+
+    cpu_watchpoint_insert(cs, deaw, len, flags, &env->dawr_watchpoint[rid]);
+}
+
+void ppc_store_dawr0(CPUPPCState *env, target_ulong val)
+{
+    env->spr[SPR_DAWR0] = val;
+    ppc_update_daw(env, 0);
+}
+
+static void ppc_store_dawrx(CPUPPCState *env, uint32_t val, int rid)
+{
+    int hrammc = extract32(val, PPC_BIT_NR(56), 1);
+
+    if (hrammc) {
+        /* This might be done with a second watchpoint at the xor of DEAW[0] */
+        qemu_log_mask(LOG_UNIMP, "%s: DAWRX%d[HRAMMC] is unimplemented\n",
+                      __func__, rid);
+    }
+
+    env->spr[rid ? SPR_DAWRX1 : SPR_DAWRX0] = val;
+    ppc_update_daw(env, rid);
+}
+
+void ppc_store_dawrx0(CPUPPCState *env, uint32_t val)
+{
+    ppc_store_dawrx(env, val, 0);
+}
+
+void ppc_store_dawr1(CPUPPCState *env, target_ulong val)
+{
+    env->spr[SPR_DAWR1] = val;
+    ppc_update_daw(env, 1);
+}
+
+void ppc_store_dawrx1(CPUPPCState *env, uint32_t val)
+{
+    ppc_store_dawrx(env, val, 1);
+}
+
+#endif
diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index 8eed1fa40ca..d354c3240a2 100644
--- a/target/ppc/meson.build
+++ b/target/ppc/meson.build
@@ -43,6 +43,7 @@ ppc_system_ss.add(files(
   'ppc-qmp-cmds.c',
 ))
 ppc_system_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'watchpoint.c',
   'mmu_helper.c',
 ), if_false: files(
   'tcg-stub.c',
-- 
2.52.0


