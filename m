Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C15BC3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmd5-0008DD-8W; Tue, 16 Jul 2024 14:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmd2-0007ys-Na
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:20 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmd0-0001AY-U9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:20 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so46453835e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721153417; x=1721758217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J/fWelIsDk94bV5CUZ155GFV3Kb2G+dluPKM584VupM=;
 b=I2n9uXesiILmZMw4DqEKU37v8iPPPG90TR2n/IPhfnEEeYO64uPxQVO/T89VR7HoI2
 FpLIvBycJhuMrBlInrhGOxcHuIiu/iqULdm9Sb3IZLVTtHWGxEWSp9O4eoqpOuRzs+9U
 3ataOTTFWMgkbin+GQmtH//MzMPL8craq9cArUwYMgUpxw75yfn0bXBpV2ywZe4OaU5m
 A6nZd14cr9T6qkJgJC2jW05Y1uM8SQCXJy6GYw2eQ3Fsq6mkU2T/bZBzy4rwlts0bKJn
 2lVb4sJoihBZvW3F2vLs0D1uHMSLbpYBCqh2xqnR5m1dfU6zo61Qjkl2ualZKQTqSs3m
 Fgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721153417; x=1721758217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J/fWelIsDk94bV5CUZ155GFV3Kb2G+dluPKM584VupM=;
 b=wutjvGfOZt1ZLWiCIsiJE4Lv/Tdsyf39fEoHo4xEhmYq2/GwcbIH9LCSZaaQ8/qyXC
 0YQvkjcM5iG4Tsm/fOFO/lV7skx1Q20ir/3fdOHzVCFTZLdTs2ed/VHm091g4A7Qp2iD
 RD9bWQoSYe5mjw31ByPWaVaIysPVWZz4tIB7GG0/dCdEpj73LGtqEv8ba9CN8hInPmnH
 M13HEy3nt9qneJ6lBoBC59ur+UVmnYI/9sQBg9kemiBbV8QT+Vdf6uZsNDGAqg+uzByN
 8at0lHXWa1MjTCi7svCTA6IRzGuM2WWqoVUtRxlpXghdI8KLVJgH+NikrhXhJEJlq95k
 D9Gw==
X-Gm-Message-State: AOJu0YwAi6lgzinvWvqyaZjSG6yeBOdcA+v2QGTdipxsZ73usx8Pk8jW
 AVg7aHOfQGRMfZFNBdX+0WE+hAAjskG0BkiD1FzQEuqyiviHR/ewuNUuz4T9HVU9uLEgyV86cR1
 9zItL2g==
X-Google-Smtp-Source: AGHT+IG7hb9GySRVSkBP7ow1KqrpAE8f5R/t8WpXPajvnPY9tJMGGUSQlUMbV4rgB+uDvn+Jj1GhYw==
X-Received: by 2002:a05:600c:198e:b0:426:52a5:1ca4 with SMTP id
 5b1f17b1804b1-427ba69ae4emr23743705e9.21.1721153417039; 
 Tue, 16 Jul 2024 11:10:17 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabf133sm9532426f8f.37.2024.07.16.11.10.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:10:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/13] system/cpus: Add cpu_pause() function
Date: Tue, 16 Jul 2024 20:09:33 +0200
Message-ID: <20240716180941.40211-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716180941.40211-1-philmd@linaro.org>
References: <20240716180941.40211-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

This factors the CPU pause function from pause_all_vcpus() into a
new cpu_pause() function, similarly to cpu_resume(). cpu_resume()
is moved to keep it next to cpu_pause().

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20240712120247.477133-17-npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h |  8 ++++++++
 system/cpus.c         | 30 +++++++++++++++++-------------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a2c8536943..e6acfcb59a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -984,6 +984,14 @@ void cpu_reset_interrupt(CPUState *cpu, int mask);
  */
 void cpu_exit(CPUState *cpu);
 
+/**
+ * cpu_pause:
+ * @cpu: The CPU to pause.
+ *
+ * Pauses CPU, i.e. puts CPU into stopped state.
+ */
+void cpu_pause(CPUState *cpu);
+
 /**
  * cpu_resume:
  * @cpu: The CPU to resume.
diff --git a/system/cpus.c b/system/cpus.c
index d3640c9503..5e3a988a0a 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -568,6 +568,22 @@ void cpu_thread_signal_destroyed(CPUState *cpu)
     qemu_cond_signal(&qemu_cpu_cond);
 }
 
+void cpu_pause(CPUState *cpu)
+{
+    if (qemu_cpu_is_self(cpu)) {
+        qemu_cpu_stop(cpu, true);
+    } else {
+        cpu->stop = true;
+        qemu_cpu_kick(cpu);
+    }
+}
+
+void cpu_resume(CPUState *cpu)
+{
+    cpu->stop = false;
+    cpu->stopped = false;
+    qemu_cpu_kick(cpu);
+}
 
 static bool all_vcpus_paused(void)
 {
@@ -588,12 +604,7 @@ void pause_all_vcpus(void)
 
     qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
     CPU_FOREACH(cpu) {
-        if (qemu_cpu_is_self(cpu)) {
-            qemu_cpu_stop(cpu, true);
-        } else {
-            cpu->stop = true;
-            qemu_cpu_kick(cpu);
-        }
+        cpu_pause(cpu);
     }
 
     /* We need to drop the replay_lock so any vCPU threads woken up
@@ -613,13 +624,6 @@ void pause_all_vcpus(void)
     bql_lock();
 }
 
-void cpu_resume(CPUState *cpu)
-{
-    cpu->stop = false;
-    cpu->stopped = false;
-    qemu_cpu_kick(cpu);
-}
-
 void resume_all_vcpus(void)
 {
     CPUState *cpu;
-- 
2.41.0


