Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1011C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIHF-00057L-Lf; Fri, 10 Jul 2026 16:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFP-00021l-2h
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:59 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIF8-0000zY-BU
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:58 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-845c92bc464so1259845b3a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716881; x=1784321681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zEoEbldckN16OhTsR6Zaa+zbm5X/cyDm4W7LiW18RHY=;
 b=VYTlhnARxmlw5k8I3xYPU9OMaokf2nMP227KKz4mvQtjTPuaZmxTavwzU/lvsW4Kb1
 9LK0EHeCA9Y92HNseFLkfvsazTlZ2UdzGwH9hzVtG8LByl0AphQ6G1FvzQnGnHXSMX2r
 Lx8ZTkObBNiLhtOYZ5XcbtfxKAEzi8Em+5XQjR+5dJTrvCoR/8YQbmgpnBHphb9JYwlE
 8iiqOWTyKQCulMjVFOy6o+45sB3lyLrS8P1M5zV4w7UL6e9w+hB87XOp0OnB7bUIziKm
 bu5wzCC+oQ/CMoiNlFarSsLLaQXjvjpCHUaDa9zepd16vxVVHLq/n1xPsriOdLDy1L8Q
 q7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716881; x=1784321681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zEoEbldckN16OhTsR6Zaa+zbm5X/cyDm4W7LiW18RHY=;
 b=JxupJS/h48k0C7a7VY+lEvUZyvKsT0lNZ8lh86ION6pO9Bo3toem+RuAqXSHtoMqpQ
 MxCumvDWGtx5qT78IwJ4pmIWFuH9lbVvbxIX7rnxrggThLn1O5eGcChpzJMezMB2iKyb
 40eUy2lm+04EyNlMb0PpSyy6YjgbU41ScLsB4X/kY/nlTtZse06g6TMNjYT8zAGhzOFA
 Cug4tNDI2SFYVLFN+DME367tu+pFFNbgKeGCx4B51pr1n1qz3pcFuAUkgis0r57OYG0y
 iLAsElliKeSctKS0dy6kfS//wMTJBfw5yGiwfm7qMEXwPmsm2guXYwUw6tveqCLHue/l
 9hVg==
X-Gm-Message-State: AOJu0YxUnUSHzfp6VIksUVjoo+iSDKXluYkynjy4VD9MnA3yho793v9c
 AHH0bmBj2y+E5cVGiA/nWC303Vp5tKFOGqz8435ekg3mq7gEEATfdnOyu98hadDNI33Ym3FIaV7
 KyhM3
X-Gm-Gg: AfdE7cmT4LqFggow1v7iw0yYWVy/rnjIMVQ1iVM0ZuIjhr7ZuudqaBfKlPoqbLgh3v0
 1meo9F6QoCTDuO7imuUPpU/2/gjB2NwOV9z1jbbcwEgs9OvHxnNyP4VYka0bq+TzEABc5x/s48w
 rKmczdOA6ekIoUodpJRITp1308m+gllFC/PgcYGC3wf9oXcI1fjVVzbDHyFvmwkGTCWh7wcy5Ro
 no18xJARbGh39o8rY9r8e1z97Set9xzrOiELlw5V/AoH/XeBIb1UyuGZfGecIvOEuQF/UQKeGNL
 G45sfJu+EddfMffrjEaFwPo/AMRd0AqRIpEdY7zh2WKq9qVkRbPGr9cnEleL54QDkdhPkAjbYpY
 DzW/qAUMphOt9nb6k69e3Q9I8O9ofS7o+wFq2AMo276UgxTodwrULxfWRf19SiPwomupDSnDcnU
 qYJUu7CDrDhWvX3N9dow==
X-Received: by 2002:a05:6a00:3691:b0:848:5935:2e11 with SMTP id
 d2e1a72fcca58-848896b9a7cmr617803b3a.48.1783716880557; 
 Fri, 10 Jul 2026 13:54:40 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 35/51] target/riscv: Simplify riscv_cpu_debug_excp_handler
Date: Fri, 10 Jul 2026 13:53:45 -0700
Message-ID: <20260710205401.836304-36-richard.henderson@linaro.org>
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

We no longer need to test for BP_CPU.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/debug.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index a8429778f6..994a77fd31 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -919,15 +919,7 @@ void riscv_cpu_debug_excp_handler(CPUState *cs, CPUBreakpoint *hit)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
 
-    if (cs->watchpoint_hit) {
-        if (cs->watchpoint_hit->flags & BP_CPU) {
-            do_trigger_action(env, DBG_ACTION_BP);
-        }
-    } else {
-        if (cpu_breakpoint_test(cs, env->pc, BP_CPU)) {
-            do_trigger_action(env, DBG_ACTION_BP);
-        }
-    }
+    do_trigger_action(env, DBG_ACTION_BP);
 }
 
 bool riscv_cpu_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
-- 
2.43.0


