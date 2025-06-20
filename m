Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD79C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfOh-0007pm-Ql; Fri, 20 Jun 2025 13:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLk-00032E-UP
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:28 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLj-0004dM-8H
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so16731745e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439781; x=1751044581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OeMttFNHwCeQPAcqGb56M6LDjrMo8+04+qvCxL+KWeo=;
 b=NwG5zyvmOUubSF3HucZX2+lA8537sGMUX1W0UVXD6zlTI+F9MUdkceB1z4BwFFGZdr
 Gye5NyDSKGLPst0kSzOsxgDpzRCf1hDpVemjAozULd/73V6KnfUJayhU8D7weihyFYBv
 gDopU9uooU2f9RBvHD2nb3qJG0xf5JDZF5YBdGJmrZQgi5OsK4ZHAvp8bTwTMg9UynZj
 zYNwDKP3grWWo61WDFs04bkBUwau+Q4EmhXu6W8bS6Z+n+Co2SC8pLrl+Th53yp35SSv
 gwBajGyNPyr/8hiZYSn1Gq6Wqhgc65ANqh58he3IzMKfieFO0mvoU3/Xkp2qqWf4v7kY
 Vjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439781; x=1751044581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OeMttFNHwCeQPAcqGb56M6LDjrMo8+04+qvCxL+KWeo=;
 b=n3uEQhngwdfhRYe4wELkBkdFI/b6Mcqe9PdLk4PEnGwkNyLleAEYrglgPnwCTaZBlU
 B5iiC84i7XBKnfE2mJiRGlVVs75NAoC38XrsfeNMNE511q4gBLqQwQOatow8WO/egz9A
 qQCH2JUM8GJc0qbC+6vHEJgYYyTYohs4YjPt1jJZaf9QQAPaexY4HGSG+KJgKtScjrCW
 W2isD6fg8tOK3qUMHxbPKB6RG15ITUjvgR/QproiE4pFznYSzpJr2VsyUiVb8zEdjnRA
 ED06X6hdEBKcC23kMyKDfs19oJmjMacpFR6jOKGdiEHF9yCy4yh3GOlo1XQG/hbZhBeU
 NjoQ==
X-Gm-Message-State: AOJu0YySDgmmYJg7jBPDcce0JgZrUDryXOqRfmNQnN8p9nRqj8YZyIMT
 lsLBEiBdM5eXpAm5RAnhQPVBwnObifcP7aElXEwv3p5dp3/U7j8G004naWY4Px9WKRlDRDdOA3T
 0cqT9qPk=
X-Gm-Gg: ASbGncu/olLyOLCvs4gmDf8IM3aDMQN3imnBjf+AOtA0y8ewLz0g1WRydP3NW08p8OJ
 rudtcM/ePQKFGPVI9kxx1Vh9SRlorbCvLtlAHWvGESPazTHQrrOE3NXAnwgiyHC0PPbVwzsg02Q
 15BXxCysXrHeYUoT1UaWCfMbihgUSwRDqHpTg/hd2T8j92CvIdIVVrRmtRIXTKLHppNVZUM9Cz6
 uwbBXa90gDKzGVNMqU4FEkSfU8YHzGGGbVP/tlY5X0t9VeYmZFxY2PfTc3P6G+NYjNxadnKhWJH
 XvInsIc7vSDn1CNWFLofaOPOHoIWzyZHRhQDiO7LZDhg7zbbeQbDQUVN/o/QqfzswRJBz5j8RBM
 aSXKvpdpJ9AetipwmlCJWieLQFWR6pju1mvCY
X-Google-Smtp-Source: AGHT+IE0VY3QUekfpXz4Iu2ALicWylOPxF3lHwn4l21F8SFUEcOrWwqoY6tGlag/vGQB9igvOk4OWA==
X-Received: by 2002:a05:600c:c103:b0:43c:fffc:786c with SMTP id
 5b1f17b1804b1-45368787924mr13935475e9.19.1750439781406; 
 Fri, 20 Jun 2025 10:16:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4536470903asm31693965e9.40.2025.06.20.10.16.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:16:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 32/48] accel/tcg: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Fri, 20 Jun 2025 19:13:25 +0200
Message-ID: <20250620171342.92678-33-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops-mttcg.h |  3 +--
 accel/tcg/tcg-accel-ops-mttcg.c | 16 +---------------
 accel/tcg/tcg-accel-ops.c       |  3 ++-
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.h b/accel/tcg/tcg-accel-ops-mttcg.h
index 8ffa7a9a9fe..8bf2452c886 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.h
+++ b/accel/tcg/tcg-accel-ops-mttcg.h
@@ -13,7 +13,6 @@
 /* kick MTTCG vCPU thread */
 void mttcg_kick_vcpu_thread(CPUState *cpu);
 
-/* start an mttcg vCPU thread */
-void mttcg_start_vcpu_thread(CPUState *cpu);
+void *mttcg_cpu_thread_routine(void *arg);
 
 #endif /* TCG_ACCEL_OPS_MTTCG_H */
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 462be7596b9..96ce065eb59 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -61,7 +61,7 @@ static void mttcg_force_rcu(Notifier *notify, void *data)
  * current CPUState for a given thread.
  */
 
-static void *mttcg_cpu_thread_fn(void *arg)
+void *mttcg_cpu_thread_routine(void *arg)
 {
     MttcgForceRcuNotifier force_rcu;
     CPUState *cpu = arg;
@@ -128,17 +128,3 @@ void mttcg_kick_vcpu_thread(CPUState *cpu)
 {
     cpu_exit(cpu);
 }
-
-void mttcg_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    tcg_vcpu_thread_precreate(cpu);
-
-    /* create a thread per vCPU with TCG (MTTCG) */
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
-             cpu->cpu_index);
-
-    qemu_thread_create(cpu->thread, thread_name, mttcg_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 861996649b7..4931e536beb 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -204,7 +204,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
     AccelOpsClass *ops = ac->ops;
 
     if (qemu_tcg_mttcg_enabled()) {
-        ops->create_vcpu_thread = mttcg_start_vcpu_thread;
+        ops->cpu_thread_routine = mttcg_cpu_thread_routine;
         ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
         ops->handle_interrupt = tcg_handle_interrupt;
     } else {
@@ -222,6 +222,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
 
     ops->cpu_common_realize = tcg_exec_realizefn;
     ops->cpu_common_unrealize = tcg_exec_unrealizefn;
+    ops->thread_precreate = tcg_vcpu_thread_precreate;
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
     ops->insert_breakpoint = tcg_insert_breakpoint;
     ops->remove_breakpoint = tcg_remove_breakpoint;
-- 
2.49.0


