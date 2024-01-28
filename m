Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB323C47DDB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0r-00051U-Em; Sat, 27 Jan 2024 23:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0p-0004yE-ON
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:19 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0o-0004No-67
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:19 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-59a146e8c85so791279eaf.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416996; x=1707021796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeBfHlDAifxu4F1/UNQzzGCEUArq4HbYf2mScaRZKZ4=;
 b=f7FzQJha1UfDYDFRCNrnaD3VeweiPjO/5FeGsz/F+3eUdoWLc2ZRvzz4JcaQFkywXy
 MWw7ae606x3e9OId4KlSfF7a/h+mZfKvtY+PxKOHEelY4llYIoxq6SxqSUd6tNm10S6m
 unbWAalSfDwgtPgbjMEmwOahddDDb0yVy7lexXmpHxXfhvixYXhrsxfb9v1geXqOah3X
 34EVUO2gpmYoj/M+GRD3wRB9kSWyR+3xnuKS+ExKHdikRZG4aCmFEER/VUpcd+2WqhsJ
 fHpQgFbjtwdfqdsYq14mO8Bbb2+ZQvPi3CQJYW8SUh07KkQR13xuJEFZ32ZlZRmDVEMl
 LvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416996; x=1707021796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeBfHlDAifxu4F1/UNQzzGCEUArq4HbYf2mScaRZKZ4=;
 b=RXfF5z0FCuy7TXP6qjVy8UmT4Qghp1oXgDpfYOoawDsDFqHH/oxnNoS3U43t5sGd2T
 JD1B0WJITGgjsc5TPVoQKN4hOQaNfXlKlenldC+5SqikOB3i/rhNQryKgNZvC2U5mvkG
 zf/9n2045WYnfIS+43xit3EbDkT//H99Suuu9oocDkIGR5MSvHS3lWG6t9VA9vR0j7UI
 6nPD9/w/N2xobWPRZUEVDwP4TSdCcMrLkzK6MMMyHHAASYpX74/hMwYF3GvFkk4KPMII
 QxLRUObBC76ZlfMqd6jwbuqleZZYKYdTKAZuFT3c54Cw7mcoQk0sQl7bxqYwhVrL1D3s
 oU/w==
X-Gm-Message-State: AOJu0YzBeobvUNyDjV9iLFXMDY0G9nhNNDQDTDE2Dw3WmIx5PUmzqaor
 q9tMxww7epTZNZ6/+aCQTOMDHDW3cQXK+L7my5KuCeD6mivA94sz7YYB0yiaBebdMh4xSr+oqYh
 p6e12+w==
X-Google-Smtp-Source: AGHT+IFIsbMAm27bHgb/fNYmCECZyibW1Is462S9l3popKVjMfdcT4tGfggiA1O1MgCZiQc5lq2ePg==
X-Received: by 2002:a05:6358:3a14:b0:176:cf6e:51fc with SMTP id
 g20-20020a0563583a1400b00176cf6e51fcmr3089000rwe.53.1706416996717; 
 Sat, 27 Jan 2024 20:43:16 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:43:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 23/33] accel/tcg: Rename tcg_cpus_destroy() ->
 tcg_cpu_destroy()
Date: Sun, 28 Jan 2024 14:42:03 +1000
Message-Id: <20240128044213.316480-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

tcg_cpus_destroy() operates on a single vCPU, rename it
as 'tcg_cpu_destroy'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240124101639.30056-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops.h       | 2 +-
 accel/tcg/tcg-accel-ops-mttcg.c | 2 +-
 accel/tcg/tcg-accel-ops-rr.c    | 2 +-
 accel/tcg/tcg-accel-ops.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index f9bc6330e2..17c7ed00eb 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -14,7 +14,7 @@
 
 #include "sysemu/cpus.h"
 
-void tcg_cpus_destroy(CPUState *cpu);
+void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpus_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
 void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index af7307013a..bcba314a65 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -118,7 +118,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
-    tcg_cpus_destroy(cpu);
+    tcg_cpu_destroy(cpu);
     bql_unlock();
     rcu_remove_force_rcu_notifier(&force_rcu.notifier);
     rcu_unregister_thread();
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 3208035d85..0617f66b5b 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -131,7 +131,7 @@ static void rr_deal_with_unplugged_cpus(void)
 
     CPU_FOREACH(cpu) {
         if (cpu->unplug && !cpu_can_run(cpu)) {
-            tcg_cpus_destroy(cpu);
+            tcg_cpu_destroy(cpu);
             break;
         }
     }
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 813065c0ec..9b84b84218 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -63,7 +63,7 @@ void tcg_cpu_init_cflags(CPUState *cpu, bool parallel)
     cpu->tcg_cflags |= cflags;
 }
 
-void tcg_cpus_destroy(CPUState *cpu)
+void tcg_cpu_destroy(CPUState *cpu)
 {
     cpu_thread_signal_destroyed(cpu);
 }
-- 
2.34.1


