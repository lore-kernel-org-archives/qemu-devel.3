Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F673C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIFW-00029v-32; Fri, 10 Jul 2026 16:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFH-0001pY-E9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:51 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEz-0000v2-Uq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:50 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-848882fdb18so343535b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716873; x=1784321673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fJfbDIS/fYFApYI9j0z0r2WuLwyv5LpJL3k4ywDcnyc=;
 b=xfQLdlOoDzBQSUC6XOf0uckCFr4iPsauhgbkpADz8Z3/mvQ17JNM1ZB90VjSNtwhBI
 g/FtlchyIpHf87ObdOJsdXxcBGzIi87gN5tj2ds5eI0jkDcqqUqHi6JJKeFShJalaLpU
 rz/Itxbx5tlW4ScT3SjjP//4J3MEXSwOKiDMlvCUmedgVXUnunu4SaYKzx5SmZ8MUJrd
 8ZSkJlikMVYCkhm5B76CAVo05bSwjx3WmPOO7J1fTTrIP/PBiEIAXL+iATYoB0ztYdka
 QguZ13tEUV/6Gzi7hvaw9ilGizOdE9lqzjFvwkR2X1eI102SWiwEO99CW3Icuo4eoTTW
 nWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716873; x=1784321673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fJfbDIS/fYFApYI9j0z0r2WuLwyv5LpJL3k4ywDcnyc=;
 b=gBg3SUNWtKqgDtRtWIRPPK/RbSA0T8yr9nuRTYzbo+a88ADzNRjTQ7RuDqWYWACclG
 FkItB77seDR9tRfKOppznrOgqUYA9MsDgSE/SZ+vyB5JC1TIoWj8yxG3qtRnsiPeAMwR
 y95Fy2YHK1bW5Xtd9zwXEDk2UzivuJ1SOGUtk/fi9XBhl8+yOJtzx9Kf2DUk8V7wru/q
 y6IQ9gFQcJnUe1Kxa3BUL6LsDOoICPH/SLJdjojviBCCtOaK6rnnhOA5H7fJPMpbKB5b
 QSFyo/QDJn6RIwI1PEoYaf5FlNl465Q3L4NkUwpwu6b+XCmP9MaThTDpI5Y8SA82mkeR
 aK+A==
X-Gm-Message-State: AOJu0YxhH7c1PNP9flinhmbvLymkrXdbOtyuEWNuV4IHMrLHWa4o1fy2
 j6rS1qhf1AsjYHgaFavFTTJGDYfrCZI+LDtV99nCqG/TH+zo/A7OdPEfgoJMyEFEfq+Yzl/BFZO
 +gNcf
X-Gm-Gg: AfdE7ckY7MCwn1df4BNkzgBHsfBl6QKBlqK/RMTgWMykxoB3Cxy0vLfCMM4DiW8GOTw
 Q/k+0pvx6ExfwTMuu26jiXl+kBHf0pIiIFRZrH1Oo7/Z7vmukcLY1mxcpNEP/HP5MbSFC2w0uLy
 NznDjEZaj9X7Hm6WUBDhQH+jTcO2uCYyT2dUX8hKK3xcu5CvpCQ1rlq6vasP4eEgfLOLfK9eXvD
 daBXszd1qxoETUVG7cd8WhPOiqK8UV7mJBN/gdYZLQrVlIcCPNSldQ8WerQ1/M3EUWSAMxlHLiG
 A2MYmvUZfePzRDxtCtE0hs4KXDprSWNZNlJPTW66uB81B+wNZiKaIBNl4w0LiXRXCfuEpCalOGA
 hbkaXEUjaoMNn+7jvpxoO/i3cpkxt+kIlO4fVFLpUJtmJdg9Pg0aDM7JtUtYiK7xI7v3C+ls96X
 on9a0A3+TST4JNN4HyPLvv1r58Qcbt
X-Received: by 2002:a05:6a00:18a0:b0:848:6720:6fec with SMTP id
 d2e1a72fcca58-8488965c1fbmr568684b3a.28.1783716872552; 
 Fri, 10 Jul 2026 13:54:32 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 27/51] accel/tcg: Pass breakpoint hit to debug_excp_handler
Date: Fri, 10 Jul 2026 13:53:37 -0700
Message-ID: <20260710205401.836304-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Record the CPUBreakpoint in check_for_breakpoints_slow,
into a new CPUState field, so that the as-yet unconverted
target debug_excp_handler functions won't see it.

Only call debug_excp_handler for BP_CPU, and clear the
CPUState fields after the call.  This will allow these
actions to be dropped from the target hook.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h |  1 +
 accel/tcg/cpu-exec.c  | 32 +++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 3986e43f84..1a42940d92 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -526,6 +526,7 @@ struct CPUState {
     /* ice debug support */
     IntervalTreeRoot breakpoints;
     IntervalTreeRoot watchpoints;
+    CPUBreakpoint *breakpoint_hit;
     CPUBreakpoint *watchpoint_hit;
 
     void *opaque;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 3205f365e5..a4eb1f1c31 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -363,6 +363,10 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
     return false;
 
  found:
+    bp->hitaddr = pc;
+    bp->hitlast = pc;
+    bp->hitattrs = MEMTXATTRS_UNSPECIFIED;
+    cpu->breakpoint_hit = bp;
     cpu->exception_index = EXCP_DEBUG;
     return true;
 }
@@ -681,19 +685,29 @@ static inline bool cpu_handle_halt(CPUState *cpu)
 
 static inline void cpu_handle_debug_exception(CPUState *cpu)
 {
-    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-    IntervalTreeNode *n;
+    CPUBreakpoint *hit = cpu->watchpoint_hit;
 
-    for (n = interval_tree_iter_first(&cpu->watchpoints, 0, -1); n;
-         n = interval_tree_iter_next(n, 0, -1)) {
-        CPUBreakpoint *wp = container_of(n, CPUBreakpoint, itree);
-        if (wp != cpu->watchpoint_hit) {
-            wp->flags &= ~BP_WATCHPOINT_HIT;
+    if (hit) {
+        IntervalTreeNode *n;
+
+        for (n = interval_tree_iter_first(&cpu->watchpoints, 0, -1); n;
+             n = interval_tree_iter_next(n, 0, -1)) {
+            CPUBreakpoint *wp = container_of(n, CPUBreakpoint, itree);
+            if (wp != hit) {
+                wp->flags &= ~BP_WATCHPOINT_HIT;
+            }
+        }
+    } else {
+        hit = cpu->breakpoint_hit;
+        if (!hit) {
+            return;
         }
     }
 
-    if (tcg_ops->debug_excp_handler) {
-        tcg_ops->debug_excp_handler(cpu, cpu->watchpoint_hit);
+    if (hit->flags & BP_CPU) {
+        cpu->cc->tcg_ops->debug_excp_handler(cpu, hit);
+        cpu->watchpoint_hit = NULL;
+        cpu->breakpoint_hit = NULL;
     }
 }
 
-- 
2.43.0


