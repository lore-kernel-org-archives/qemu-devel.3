Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA29CAC5AA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0swe-0004KB-AV; Mon, 22 Sep 2025 22:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swR-0004GP-Us
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:44 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swG-0003gz-IQ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:43 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3322e6360bbso2276744a91.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 19:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758595167; x=1759199967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6OMk5ACCeNuXf8eKcDPF9+TwMN9mapKYv0wPDXsO4I=;
 b=FnbYQTwzmFbRmA9F3gWb/pv/rqwPVwwJOWn0ozbbRlK0Q+1hvWkB3oIXlU2gcASkGO
 hdV9/SlGmZKg0wsDa9LNkhDOg6/KdITvn0ZVXm7yvbo3K08QRhEFJd9H0A6LyJojihfp
 +qqsAbbwndeOCxbt8TIzjqqHZfSa2XfIsW3BmTcaPlmF4/h7DIRkOtHCVkvavaq83SLV
 tczAAyJdVVFqEdHLHobi7PmgePJ5jfecH4Po8Fp2U0HdfsU5fbF+CeqEr20DpACSAD8c
 MwmxmYP5MtwLxptfLWUjkWWEfKMsUcSuQUSDMKemL8TpdaiQWfYxFYT9032elCjWZD3L
 LGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758595167; x=1759199967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n6OMk5ACCeNuXf8eKcDPF9+TwMN9mapKYv0wPDXsO4I=;
 b=f8kLNL81c9dv1D4O8WEnAm/jSAvfflQCfS0jWh/aUtEM9yMOorMwCBuQsr5KAOk25j
 +UJfaiPu7LB9gMCl9zK5O8/FrG6AotIvgRfzXOlX49Y/kFjybL54eBMhExZP+HqAdTJg
 N8Mhwlok8xPMfLHs83SLcRUXrby8Vd3cufkON5pZFuS0CbvC3Zseq0vVxaUcZHcY5EWc
 LcoQ9M4WY7gEBOotuySIr7w3GgYJ908oHQdINddy4OrW4Ey5eFWfpp28n7hf32GWEPIQ
 qlLvz0Q7vQ+jzXu8Q4Y1jOToH3O8SSokPj/5mCTT1ycsStatE7mm5tOkSUD8wsb5azTo
 LZDg==
X-Gm-Message-State: AOJu0YyaGoz0O8rkqNX7WQJikbJ9S1jISTZtYZDfWAfbdD5tN/ddqs4N
 C83szPnJg835f3w/FVK29Ln6AYCrSrAnhiTZzZwqHiI1eN9OOtoDuYK2hXNIA/Ky5QvzsGcY/sg
 9hx2f
X-Gm-Gg: ASbGncsS/hXcBpFRv9Uhs62kX6IBhbXsIlbm0k4zVK7FfgLItA7JO/yxS9l6UmacMVX
 WU31pz8kvy5/FrWbKwQASa9Ohwc41uUMk2h4gZXiUENzmthknd4c2ZKYipjlCcMEGVgU6AMnq3c
 zqbzg2UzlK0aVn4GkIqj/eUxcFnkS3CMIUs3lYfl7dhWW6M1G6EUx6cT2hB79pZ/z+fuV0WPQUR
 Tsg43OAzmns10I7RFqNs/H9xB2V3x5opg9RMgkDRkAjWR569ewNOwjstIU1D7x9HFFjvVDpSA7l
 zlIAiyeigKya0MrmWmx421M4fDuJuiyzrRKPXgPqyU0xrV4WicN27Sea9HpMp8UtMVTWjuXe5uY
 sOGWdXHkK7gHprZSpUKbrESQgf1Cv
X-Google-Smtp-Source: AGHT+IFghoo6+gWcrYmlQsslGgXlGMxcfqMJmFmnJGcvtjHP/qjZwDBopV9ltsSJKYt9PvQthlUckw==
X-Received: by 2002:a17:90b:528e:b0:32d:601d:f718 with SMTP id
 98e67ed59e1d1-332a96fd5d0mr1210655a91.31.1758595167630; 
 Mon, 22 Sep 2025 19:39:27 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f0da43089sm9899622b3a.90.2025.09.22.19.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 19:39:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 05/12] accel/tcg: Move post-load tb_flush to
 vm_change_state hook
Date: Mon, 22 Sep 2025 19:39:09 -0700
Message-ID: <20250923023922.3102471-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923023922.3102471-1-richard.henderson@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

We need not call tb_flush once per cpu, only once per vmload.

By moving the call from cpu_common_post_load to a tcg-specific
vm_change_state_handler, we do even better than that: we only
flush when called from HMP triggered loadvm, when we had old
state to flush.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: Peter Xu <peterx@redhat.com>
---
 accel/tcg/tcg-all.c  | 21 +++++++++++++++++++++
 hw/core/cpu-system.c |  8 --------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 5125e1a4e2..a0bc0e58c7 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -38,6 +38,8 @@
 #include "qemu/target-info.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
+#include "exec/tb-flush.h"
+#include "system/runstate.h"
 #endif
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
@@ -82,6 +84,23 @@ static void tcg_accel_instance_init(Object *obj)
 
 bool one_insn_per_tb;
 
+#ifndef CONFIG_USER_ONLY
+static void tcg_vm_change_state(void *opaque, bool running, RunState state)
+{
+    if (state == RUN_STATE_RESTORE_VM) {
+        /*
+         * loadvm will update the content of RAM, bypassing the usual
+         * mechanisms that ensure we flush TBs for writes to memory
+         * we've translated code from, so we must flush all TBs.
+         *
+         * vm_stop() has just stopped all cpus, so we are exclusive.
+         */
+        assert(!running);
+        tb_flush__exclusive();
+    }
+}
+#endif
+
 static int tcg_init_machine(AccelState *as, MachineState *ms)
 {
     TCGState *s = TCG_STATE(as);
@@ -124,6 +143,8 @@ static int tcg_init_machine(AccelState *as, MachineState *ms)
     default:
         g_assert_not_reached();
     }
+
+    qemu_add_vm_change_state_handler(tcg_vm_change_state, NULL);
 #endif
 
     tcg_allowed = true;
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 09c928c1f9..1fd9571017 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -207,14 +207,6 @@ static int cpu_common_post_load(void *opaque, int version_id)
         cpu_reset_interrupt(cpu, 0x01);
 
         tlb_flush(cpu);
-
-        /*
-         * loadvm has just updated the content of RAM, bypassing the
-         * usual mechanisms that ensure we flush TBs for writes to
-         * memory we've translated code from. So we must flush all TBs,
-         * which will now be stale.
-         */
-        tb_flush(cpu);
     }
 
     return 0;
-- 
2.43.0


