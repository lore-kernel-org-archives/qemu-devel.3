Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBA5C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl2Y-0004MC-Hg; Tue, 16 Jul 2024 12:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1f-0007RU-Ml; Tue, 16 Jul 2024 12:27:40 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1b-0006dq-Cz; Tue, 16 Jul 2024 12:27:39 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70af8128081so3885564b3a.1; 
 Tue, 16 Jul 2024 09:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721147245; x=1721752045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbl1GeXwoz46Altpg40xcQTbbbBXwRHlgtS1l83HdP8=;
 b=QXZwGBtaT+45R4VKUAZ0xVb+skyDG+1Y8xuoGxS4MtuQDNeiQONvNl6gFhKYmohJ+9
 uJFDpAKLt1Cc/sAy7wLHmzRTFMX7yXZH6/WstcALUmxpbcIbq0+MrdVsgHegt/mZIx/r
 Dyu9sJNOA1Bep7FC+QM7bTonKtyDqAIrw3serSD+X/ym+EE1nOUj1Vic5A1Bb20nVwXP
 KxEk8dCBqCTSrIqDwH0A/K/8Re0zFKE4RA5/f50T4bd9hUU/8V+KhBJQ7zs+J31QoWZa
 XGCd++n0Au024uR97KZzfEoQBWRZB5qI1fUCEkrJ/5FjholgE2aggWRHzMs9N0c6WkBp
 BysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147245; x=1721752045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbl1GeXwoz46Altpg40xcQTbbbBXwRHlgtS1l83HdP8=;
 b=tvIwMR2+eL77VvhwFtXuqUOwo6CGzu41cd3J14CfGSQ2OR1ummoRu+jKrHTGwx+e0E
 wpCXPOL7bVrTaJmfMVFHPmSRs1Nv+a9mXuGUB1sHvgKodAZSJYNmeweDfbyawmageb1f
 +3Sg4vzGvDbSHzx+i0XF7W/7KPtk3emdAR2hjnwpFlFYbZj5VMvS8PaAyoQSz+f7a1a/
 jJdD6oTW8h+AxaO7BIbSA4ws8n/grWXY4xtK0it/az3PlkTwOcEHKDuNsjI52v8taVl0
 A3R6biUjjYUoADhFfjSECVzuWsGZsyCTj5Rib3O4QQRT+Cx8s9EQWEWinem2UtiSD4hM
 +QlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsFkxyqBbEQ3jqldymsoexXm1cw3z/v0liMJ2EKpkF4ric7TskuPhAvDmCGFPvVELCxttiR7ydutpm3wTYgvbSo9jf2+8=
X-Gm-Message-State: AOJu0YwNkZPE4WVqpVoBeJy6wtjOh8nJU9411O3KSA7I17rXlYJLFUG4
 bNSl3GWiQ3stphXofpzB1sFx3W2+U17bTp9mcRVSFEhpr5zYHaEbQMMilA==
X-Google-Smtp-Source: AGHT+IER5tSaxQNurxyWXwAWjSOCzVkPwWUzt6g/jxQBh+Ck87c7L3XoiXqzOCadJSPWSmaUa6DPJA==
X-Received: by 2002:a05:6a00:3916:b0:706:6af8:e088 with SMTP id
 d2e1a72fcca58-70c1fb4a270mr3396133b3a.3.1721147245053; 
 Tue, 16 Jul 2024 09:27:25 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca86d6sm6722161b3a.179.2024.07.16.09.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:27:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 16/19] system/cpus: Add cpu_pause() function
Date: Wed, 17 Jul 2024 02:26:12 +1000
Message-ID: <20240716162617.32161-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716162617.32161-1-npiggin@gmail.com>
References: <20240716162617.32161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This factors the CPU pause function from pause_all_vcpus() into a
new cpu_pause() function, similarly to cpu_resume(). cpu_resume()
is moved to keep it next to cpu_pause().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
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
2.45.1


