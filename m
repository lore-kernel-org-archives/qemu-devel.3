Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9007C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIEw-0001S6-A0; Fri, 10 Jul 2026 16:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEt-0001NV-VZ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:28 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEk-0000hh-5H
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:27 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-84862b0d5aeso1441142b3a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716857; x=1784321657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k40Ct/scLRA6POY4s+1/g3ylMfrjfxUVUANTHep1r88=;
 b=FBeOsRyLde+iffSRs1nbHx263W5LfQKpNFzTdO+EoG6D5zDH0rLgK6WHdUpaXmG9xN
 ZB4yy3qwYA+Lt+1iPQLXdKx+jJT8LMP7mob3imLKSmx4+v8t0AQuwBIebHuiwI3tNtZL
 pqwtz+P5Voeb/bMhy1uIv8Ijfk5/FAWJXJ6tHYcqIwB1Yd0jltfehRgztjV0W8TYKs4n
 SbZZnBH8WeEraOkuAWU+YUZzwHM8GHnCbSbx0x/YL03reyCq1nzrVjvB6v0s202EV8o4
 ZFQb5Tu6A4YsjUHtRQADicZeEueaSqjAOAn9tLjXVc/mGVXYKUBa79HkqD0zy6VhSaWg
 1y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716857; x=1784321657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k40Ct/scLRA6POY4s+1/g3ylMfrjfxUVUANTHep1r88=;
 b=IzwTsmzcaC9BUAWmI7pe5QYhUmgqjvJvYKBQ9EgQj6bpSr4SNPy+n8zHHWmJy5YUnf
 1rGBfIButEwY+yEBAwwxP8Xlenqf+Wc7TY7OiIdjHzyAUOjsjD8zK/ZRwjCu1H/Ot8fz
 SUxYnsbyZMlvZmg5Z8i0ESjfVvsqgwE6EZmV/Th+x1dqH6VZMadJ7ce+B1RFPfDi9v4G
 zw3XrrQ3UfxIkDmnZjZLVaHQ6Ze2bBhcKjwvae92bp2qsLygci3uUM5RtgChVwt6PD+P
 hTWClIXsGOI9gG3oDcu/qXrqw2yhYeaUk8nsz/EnIuR2vfQYhDVlYso6GGneLJ59EZut
 Arxg==
X-Gm-Message-State: AOJu0YyBxtEv7ECkZnFQhfIEV4E2UCWs4xqAhSIK33jWnxP0au/x4VuD
 0hlGuTjsPV9fKHSMNQ3gWLvgKh2cIxo6APBUFitCCzxILHINmradLd6xu9Q1I3CZT6W1Fe68X5j
 dTu3I
X-Gm-Gg: AfdE7ckHYUo88AMBPVYK0Tx8K34R2zMS/mxfjfDK/G/fGutzfpoU8mEHY47+polYozG
 fn2n7ToeaMG5xgdML9p5umN3f/ZawNE3RQy53CIDPi3/icWuNl5oNAnzouTrxcaxrzJY6NdEmPS
 AQQ9F+HN6h6tZXLSFWFx3LhNcEQvvg05a7cLPYWmAn50TaqfrlapYz7gllGYmo3pBZsndaYOJsm
 I2zEFZ/Y6BwZsWaIAkyZQEtUPTZk3zQWe4AMu4nlMnn74fTo70JB8P93Qjib+gztkk3tkYAhRkU
 K3UrsKUW108OvqT4x7U6I8fAAMvLIsiIYwIsv9pTFx8ns6a5NHWu2XzF+NRpNPXZKkXmRaHmDtZ
 tEyYg7YdtxQ4Qqc4GpGNJWOicf+93t9GQpMPmowKipFINPDei/vTM+tP3v7jFxXTaTYRzZlsCi3
 lGnOce7UmjqL22emheXg==
X-Received: by 2002:a05:6a00:c84:b0:847:7ece:3426 with SMTP id
 d2e1a72fcca58-8488979782emr487915b3a.58.1783716856628; 
 Fri, 10 Jul 2026 13:54:16 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 12/51] target/riscv: Use bp argument in
 riscv_cpu_debug_check_breakpoint
Date: Fri, 10 Jul 2026 13:53:22 -0700
Message-ID: <20260710205401.836304-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Use the ID of the breakpoint instead of a loop over all.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/debug.c | 44 ++++++--------------------------------------
 1 file changed, 6 insertions(+), 38 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 5c378dd2e8..511a69c28d 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -941,48 +941,16 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
     }
 }
 
-bool riscv_cpu_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *ignore)
+bool riscv_cpu_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-    CPUBreakpoint *bp;
-    target_ulong ctrl;
-    target_ulong pc;
-    int trigger_type;
-    int i;
+    int i = bp->id;
+    trigger_type_t trigger_type = get_trigger_type(env, i);
 
-    QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-        for (i = 0; i < env->num_triggers; i++) {
-            trigger_type = get_trigger_type(env, i);
-
-            if (!trigger_common_match(env, trigger_type, i)) {
-                continue;
-            }
-
-            switch (trigger_type) {
-            case TRIGGER_TYPE_AD_MATCH:
-                ctrl = env->tdata1[i];
-                pc = env->tdata2[i];
-
-                if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
-                    env->badaddr = pc;
-                    return true;
-                }
-                break;
-            case TRIGGER_TYPE_AD_MATCH6:
-                ctrl = env->tdata1[i];
-                pc = env->tdata2[i];
-
-                if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
-                    env->badaddr = pc;
-                    return true;
-                }
-                break;
-            default:
-                /* other trigger types are not supported or irrelevant */
-                break;
-            }
-        }
+    if (trigger_common_match(env, trigger_type, i)) {
+        env->badaddr = env->tdata2[i];
+        return true;
     }
 
     return false;
-- 
2.43.0


