Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A12E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 08:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWAHZ-0000V2-0v; Fri, 10 Jan 2025 03:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tWAHH-0000ON-OS
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:22:03 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tWAHF-0008NM-Pq
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:21:59 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2166651f752so37422015ad.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 00:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736497316; x=1737102116;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oDMxaEN+5KX9KfszmXfML4ADMBcVgDLcmtLYe7w3gJ8=;
 b=IWOUYJLIQHubHIvZB72hyqkMbSvg9G8EwiT3AoQwAx0j8BEuef5XAqGcJTwmiqF2N8
 U9rDw8TQnOjfSrGa6REQHUKqQH4cSskHY5a22Ko44mVW3A3HuHjRP5MWtKrV0yl8qNFU
 ymNIoEfU17z0vQWTjhGU+o/QpOhJ3g89zjXzNJzgtoQzBEWOt5/w5+E/EU31uLHk3AoO
 v5+tzrj0PVk0rCasC9Ad+uJZmxEtMvSk3RtgPhcQP0h8pW6EKQOzmvQu6RqYZcqiB1jw
 TLg91bb2ABAceo9M4W6NCD+oZE+p1Zd5mAofgdBazdxfbn9FcbOS5MQuwenK2Ida9d2j
 S/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736497316; x=1737102116;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oDMxaEN+5KX9KfszmXfML4ADMBcVgDLcmtLYe7w3gJ8=;
 b=rkGbvD1VYnTzP7bK0pKqbWrHb9cGa1bFsaQGV/FtdZqN9R21lEtuADwJUb29gv6NCl
 uXO0Vp5Jp46NX3/ZCSsWTdqZs3Fjz1AZdjU0Yo6OcWucXVpe5u/RFTIX5766EQPfqpjn
 f4+ufVkct+M4i4TG+WeDon7NhuRrc1giMJLQaLSXoNeD4dReSzztNuczBkU6niYyGNlc
 vmACbFtZmxW5aD7F08Qfj0Kxph6pRNriSbhRXMgkl3LnRZolHQumJUwSoTiWX7hjASUN
 ZcK1h1zVGzAC6CaHDiGwmYGT5872Lg7ql36emlAgP0n2ZylfK9AIiYA4N+ZEtV2VlTm8
 UbzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY0jAISGYZd2hO4btoW0FVnnTz1yaRuZo9zSVWpUoTV/lfZkG+1sRJpnmTu2yALD3Ff5MlREzBa8N9@nongnu.org
X-Gm-Message-State: AOJu0YzfJTilXSn9BaKRdP0xRPTDssRkVXVPiU8cYsjIBAB37Y8mB7VF
 SqFYif+zt70IOWbCZbfsSHVaXijtgLHxfApE1hZh/Ixo7Mf3KiBSSmuWWXrvZxw=
X-Gm-Gg: ASbGncu+IhNQ0HIK+RnIapnacAjOL/E77puy+vhq/824V5HA+HAVuu+dGFzPCRkwsre
 SbAM2NF41+u0QFeg109BVcek+58QTlakE98sEBU2t1ZpTvk7Pey3dBHFKkHZSK+4Dy9m2JCqPnn
 R3ASLs6wtsmHI0IVesmRnZnLxrQHIh9lsIMMmck6WDTpdnCeLsboZPjC+exiPR/9sW4caVLf0GV
 XHAzCXAqW8oG/+CtagJ8ZZRRmnTmrdh0fkpPWV6IO5CouAmQgIMPLrZdEO5f4CKJBgY4Q==
X-Google-Smtp-Source: AGHT+IEf0TW49kooIwsB4ItF1NZ0FiuLg/91wrzwhyn+zEDALDf5xTmkIqcYRz3NeERyi7zCn8Z8pg==
X-Received: by 2002:a17:903:1245:b0:216:48f4:4f20 with SMTP id
 d9443c01a7336-21a83f56f58mr140513715ad.16.1736497316647; 
 Fri, 10 Jan 2025 00:21:56 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f22ee09sm9278715ad.200.2025.01.10.00.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 00:21:56 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Fri, 10 Jan 2025 00:21:37 -0800
Subject: [PATCH v5 09/11] target/riscv: Invoke pmu init after feature
 enable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-counter_delegation-v5-9-e83d797ae294@rivosinc.com>
References: <20250110-counter_delegation-v5-0-e83d797ae294@rivosinc.com>
In-Reply-To: <20250110-counter_delegation-v5-0-e83d797ae294@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The dependant ISA features are enabled at the end of cpu_realize
in finalize_features. Thus, PMU init should be invoked after that
only. Move the init invocation to riscv_tcg_cpu_finalize_features.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/tcg/tcg-cpu.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f94aa9f29e75..48be24bbbe2a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -963,6 +963,20 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
+#ifndef CONFIG_USER_ONLY
+    if (cpu->cfg.pmu_mask) {
+        riscv_pmu_init(cpu, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+
+        if (cpu->cfg.ext_sscofpmf) {
+            cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                          riscv_pmu_timer_cb, cpu);
+        }
+    }
+#endif
 }
 
 void riscv_tcg_cpu_finalize_dynamic_decoder(RISCVCPU *cpu)
@@ -1010,7 +1024,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
-    Error *local_err = NULL;
 
     tcg_cflags_set(CPU(cs), CF_PCREL);
 
@@ -1018,19 +1031,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         riscv_timer_init(cpu);
     }
 
-    if (cpu->cfg.pmu_mask) {
-        riscv_pmu_init(cpu, &local_err);
-        if (local_err != NULL) {
-            error_propagate(errp, local_err);
-            return false;
-        }
-
-        if (cpu->cfg.ext_sscofpmf) {
-            cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                          riscv_pmu_timer_cb, cpu);
-        }
-    }
-
     /* With H-Ext, VSSIP, VSTIP, VSEIP and SGEIP are hardwired to one. */
     if (riscv_has_ext(env, RVH)) {
         env->mideleg = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP | MIP_SGEIP;

-- 
2.34.1


