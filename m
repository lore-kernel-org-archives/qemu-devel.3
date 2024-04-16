Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E431C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 04:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwa5M-0008AO-Oq; Tue, 16 Apr 2024 00:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa5K-0007wS-27
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:06:18 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa5I-0007A5-3f
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:06:17 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e220e40998so25203965ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 21:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713240375; x=1713845175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zbqcgu18SLn9cjl7+e/QBG9Rh9IFLtqhM10K4KhEsKw=;
 b=EQdhEDTUckWVosXGgfbcekjkCjcxtIo0BHjQJcwU6TkcehlWCo3LyQieWGnzBJwR3M
 XLFnP7VQJoxJp50EFK/Ub+Mb2cCy4wyhM1CyKgDzs753fHVN5A2we5hxajyPi65b9iHg
 rJBhofBVIvB0dA4tkW9lZpp01aCFy/kfDHgEElJ0hluFrW975+GfC/JGFeYHrdK8nTyL
 UW0gm+3d4UWYgQFex2toPbH4TrEO0eH5s6s3UtOpaL6sBrlTkyT+KvSwRA5JgdFiIkZC
 ziBl64Hjgh/OK7lic16V30mAtsi75A2e2qd+LDiVTYML4upQE/cXEnmwu66kmwWHGGPr
 EHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713240375; x=1713845175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zbqcgu18SLn9cjl7+e/QBG9Rh9IFLtqhM10K4KhEsKw=;
 b=jQwz6nAW1gGze/7fTpBeAtDfQRvRh+S5ujaEz3mHjM6qldSqcv5I1rCzQNf4xIsIn2
 Cifx4XMLAeDWtNaKQ4WMHqa2dhddhMJODKqBZBtQcTwbU2HJLnhy/Zk93DjA4ER4iG4p
 Qkspwo3jgnkyBIQ1ZErcm1YsjReC2Nxbxp4WMun+DfZLEM00JFJj9Xg/Tpc/+wpIBV3M
 XOmY4aX67fPa6qmH04YETcM/dSgRkVaUwBQDdITEhD/n6DEprhZWYQN0rjgfleBg57X5
 XKJxxnfTNBR8BZDDX/DmmguSAAkZWe6bNMkPBZGO7ZaeZR2MSIQxDRwqiBYjEY8+ws01
 QeHw==
X-Gm-Message-State: AOJu0YzFNg4TeWDaW6QAAwuh3KhvU7VVA0CSRfB0ZhtkSQFDKolnDjtM
 k1R1LWtk4SNV3XHqPHGWndevoob87s1K18lstMXrmcUW85M7PJ3ULBuf4eC0VREHHvK7SIK8p1p
 z
X-Google-Smtp-Source: AGHT+IFRbQtj+sH6emYDvOVpOSePzRCOpPO5wtjr9NuKJB6G096d6lFKerSUb0BhozPjpFkmzvrQMw==
X-Received: by 2002:a17:902:f785:b0:1e5:4f69:15eb with SMTP id
 q5-20020a170902f78500b001e54f6915ebmr15578523pln.7.1713240374674; 
 Mon, 15 Apr 2024 21:06:14 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a170902f68100b001e3e244e5c0sm8694439plg.78.2024.04.15.21.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 21:06:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
Subject: [PATCH 4/7] plugins: Introduce TCGCPUOps callbacks for mid-tb
 register reads
Date: Mon, 15 Apr 2024 21:06:06 -0700
Message-Id: <20240416040609.1313605-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416040609.1313605-1-richard.henderson@linaro.org>
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Certain target registers are not updated continuously within
the translation block.  For normal exception handling we use
unwind info to re-generate the correct value when required.
Leverage that same info for reading those registers for plugins.

All targets will need updating for these new callbacks.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 13 +++++++++++++
 plugins/api.c                 | 36 +++++++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index bf8ff8e3ee..e954d83edf 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -49,6 +49,19 @@ struct TCGCPUOps {
     /** @debug_excp_handler: Callback for handling debug exceptions */
     void (*debug_excp_handler)(CPUState *cpu);
 
+    /**
+     * @plugin_need_unwind_for_reg:
+     * True if unwind info needed for reading reg.
+     */
+    bool (*plugin_need_unwind_for_reg)(CPUState *cpu, int reg);
+    /**
+     * @plugin_unwind_read_reg:
+     * Like CPUClass.gdb_read_register, but for registers that require
+     * regeneration using unwind info, like in @restore_state_to_opc.
+     */
+    int (*plugin_unwind_read_reg)(CPUState *cpu, GByteArray *buf, int reg,
+                                  const TranslationBlock *tb,
+                                  const uint64_t *data);
 #ifdef NEED_CPU_H
 #ifdef CONFIG_USER_ONLY
     /**
diff --git a/plugins/api.c b/plugins/api.c
index 3912c9cc8f..3543647a89 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -40,10 +40,12 @@
 #include "qemu/plugin.h"
 #include "qemu/log.h"
 #include "tcg/tcg.h"
+#include "tcg/insn-start-words.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "exec/ram_addr.h"
 #include "disas/disas.h"
+#include "hw/core/tcg-cpu-ops.h"
 #include "plugin.h"
 #ifndef CONFIG_USER_ONLY
 #include "qemu/plugin-memory.h"
@@ -454,9 +456,39 @@ GArray *qemu_plugin_get_registers(void)
 
 int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
 {
-    g_assert(current_cpu);
+    CPUState *cs;
+    uintptr_t ra;
+    int regno;
 
-    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg));
+    assert(current_cpu);
+    cs = current_cpu;
+    ra = cs->neg.plugin_ra;
+    regno = GPOINTER_TO_INT(reg);
+
+    /*
+     * When plugin_ra is 0, we have no unwind info.  This will be true for
+     * TB callbacks that happen before any insns of the TB have started.
+     */
+    if (ra) {
+        const TCGCPUOps *tcg_ops = cs->cc->tcg_ops;
+
+        /*
+         * For plugins in the middle of the TB, we may need to locate
+         * and use unwind data to reconstruct a register value.
+         * Usually this required for the PC, but there may be others.
+         */
+        if (tcg_ops->plugin_need_unwind_for_reg &&
+            tcg_ops->plugin_need_unwind_for_reg(cs, regno)) {
+            uint64_t data[TARGET_INSN_START_WORDS];
+            const TranslationBlock *tb;
+
+            tb = cpu_unwind_state_data(cs, ra, data);
+            assert(tb);
+            return tcg_ops->plugin_unwind_read_reg(cs, buf, regno, tb, data);
+        }
+    }
+
+    return gdb_read_register(cs, buf, regno);
 }
 
 struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
-- 
2.34.1


