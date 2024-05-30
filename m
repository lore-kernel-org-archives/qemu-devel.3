Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41906C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 17:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCjuW-0003r3-8J; Thu, 30 May 2024 13:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCjuU-0003qi-2a
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:49:54 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCjuR-0002S5-L3
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:49:53 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f4a52b9413so9981955ad.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717091390; x=1717696190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fTc09zeskly2ZP9LGBon66poI8aZTqjlUXNgpOk+s4=;
 b=RbDEzbgvE61wO2seG9hmbVbWr0KU02cr9ObQp4S8PW1llg4iWS2t8Zymkr0EG9RvhK
 tQSLK7//s6lEv8IlpK94eZlz2Mn5jKcKVYaKika3H2ZulevfXbbDFxG72UrKDH3JAbxs
 iEknsYDVaqu0pE9pha2lHzDjkt0nXQXNqsxzWEo551TwdqwUvbJCG5PGeZcy9mGRqtwV
 LY3A9VVK/rAepz/xii2zRFlha7wNTBw+L5VlpER3SLEUaFSqXtfD/7wB/VlmDCaUgDKv
 0VEFzBKrmPP15im0sr38HRFvnf2pR8+/jmrgFBCF83BUqkYBpgbpuq/L+ik6J8RbSYxT
 la7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717091390; x=1717696190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fTc09zeskly2ZP9LGBon66poI8aZTqjlUXNgpOk+s4=;
 b=D+Uw0MjeuUB8LlsKPNq6/DYZ8t5BtBhcRUNeQzdFbGxy5+JrzUwDIAVg5M5Mruj7yQ
 nKfIZwqVXRcylclaFxhQC7ys93qxJjLH7UNmvXVsOtnSD8iHWNWIXXtO3w/0v1+1fAhi
 R624yTGja84UseY5vDicfHTZIaUmN4FJXKazGADEkcEYAt/B0+mbkdBD2D/6nOF6K302
 wB7qGiNiaInOWjonfHUFdeADRzLjltxH5wHfELOV2czgjQywhNKbrNZS0M8+7Neh+5WQ
 +evd94xOy1LVrdlbATADFvV7UXF+ixb9rxhdZ330aZY2z7XEpP41nxQvLnEsUu8vJ8US
 ta4w==
X-Gm-Message-State: AOJu0YwV2hpsXD/fdQkc69mPUhav62uwLx+LhSsIKGfbDGyg298gQnMX
 E149+0CqAAKFIwFf1nJLvQzCfzce0QzOlvUzQo/jFehi8l9tU2C2s2kAOnQAcgsFsToTSWmTYo+
 ktcA=
X-Google-Smtp-Source: AGHT+IHyEjTokvLy9RZdGVePQjy2CFxs2wbvSMHqa6JQJgLgaGr6I5MWbNjOnxtv3DPvpQis8dGiHQ==
X-Received: by 2002:a17:902:d4cc:b0:1f4:5f66:895 with SMTP id
 d9443c01a7336-1f61a2e44a4mr30894645ad.68.1717091389832; 
 Thu, 30 May 2024 10:49:49 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323deb38sm590405ad.124.2024.05.30.10.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 10:49:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/6] sysemu: add set_virtual_time to accel ops
Date: Thu, 30 May 2024 10:49:34 -0700
Message-Id: <20240530174939.749163-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240530174939.749163-1-pierrick.bouvier@linaro.org>
References: <20240530174939.749163-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

We are about to remove direct calls to individual accelerators for
this information and will need a central point for plugins to hook
into time changes.

From: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/sysemu/accel-ops.h                     | 18 +++++++++++++++++-
 include/sysemu/cpu-timers.h                    |  3 ++-
 ...et-virtual-clock.c => cpus-virtual-clock.c} |  5 +++++
 system/cpus.c                                  | 11 +++++++++++
 stubs/meson.build                              |  2 +-
 5 files changed, 36 insertions(+), 3 deletions(-)
 rename stubs/{cpus-get-virtual-clock.c => cpus-virtual-clock.c} (68%)

diff --git a/include/sysemu/accel-ops.h b/include/sysemu/accel-ops.h
index ef91fc28bbd..a0886722305 100644
--- a/include/sysemu/accel-ops.h
+++ b/include/sysemu/accel-ops.h
@@ -20,7 +20,12 @@
 typedef struct AccelOpsClass AccelOpsClass;
 DECLARE_CLASS_CHECKERS(AccelOpsClass, ACCEL_OPS, TYPE_ACCEL_OPS)
 
-/* cpus.c operations interface */
+/**
+ * struct AccelOpsClass - accelerator interfaces
+ *
+ * This structure is used to abstract accelerator differences from the
+ * core CPU code. Not all have to be implemented.
+ */
 struct AccelOpsClass {
     /*< private >*/
     ObjectClass parent_class;
@@ -44,7 +49,18 @@ struct AccelOpsClass {
 
     void (*handle_interrupt)(CPUState *cpu, int mask);
 
+    /**
+     * @get_virtual_clock: fetch virtual clock
+     * @set_virtual_clock: set virtual clock
+     *
+     * These allow the timer subsystem to defer to the accelerator to
+     * fetch time. The set function is needed if the accelerator wants
+     * to track the changes to time as the timer is warped through
+     * various timer events.
+     */
     int64_t (*get_virtual_clock)(void);
+    void (*set_virtual_clock)(int64_t time);
+
     int64_t (*get_elapsed_ticks)(void);
 
     /* gdbstub hooks */
diff --git a/include/sysemu/cpu-timers.h b/include/sysemu/cpu-timers.h
index d86738a378d..7bfa960fbd6 100644
--- a/include/sysemu/cpu-timers.h
+++ b/include/sysemu/cpu-timers.h
@@ -96,8 +96,9 @@ int64_t cpu_get_clock(void);
 
 void qemu_timer_notify_cb(void *opaque, QEMUClockType type);
 
-/* get the VIRTUAL clock and VM elapsed ticks via the cpus accel interface */
+/* get/set VIRTUAL clock and VM elapsed ticks via the cpus accel interface */
 int64_t cpus_get_virtual_clock(void);
+void cpus_set_virtual_clock(int64_t new_time);
 int64_t cpus_get_elapsed_ticks(void);
 
 #endif /* SYSEMU_CPU_TIMERS_H */
diff --git a/stubs/cpus-get-virtual-clock.c b/stubs/cpus-virtual-clock.c
similarity index 68%
rename from stubs/cpus-get-virtual-clock.c
rename to stubs/cpus-virtual-clock.c
index fd447d53f3c..af7c1a1d403 100644
--- a/stubs/cpus-get-virtual-clock.c
+++ b/stubs/cpus-virtual-clock.c
@@ -6,3 +6,8 @@ int64_t cpus_get_virtual_clock(void)
 {
     return cpu_get_clock();
 }
+
+void cpus_set_virtual_clock(int64_t new_time)
+{
+    /* do nothing */
+}
diff --git a/system/cpus.c b/system/cpus.c
index f8fa78f33d4..d3640c95030 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -229,6 +229,17 @@ int64_t cpus_get_virtual_clock(void)
     return cpu_get_clock();
 }
 
+/*
+ * Signal the new virtual time to the accelerator. This is only needed
+ * by accelerators that need to track the changes as we warp time.
+ */
+void cpus_set_virtual_clock(int64_t new_time)
+{
+    if (cpus_accel && cpus_accel->set_virtual_clock) {
+        cpus_accel->set_virtual_clock(new_time);
+    }
+}
+
 /*
  * return the time elapsed in VM between vm_start and vm_stop.  Unless
  * icount is active, cpus_get_elapsed_ticks() uses units of the host CPU cycle
diff --git a/stubs/meson.build b/stubs/meson.build
index 3b9d42023cb..a1deafde08c 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -28,7 +28,7 @@ endif
 if have_block or have_ga
   stub_ss.add(files('replay-tools.c'))
   # stubs for hooks in util/main-loop.c, util/async.c etc.
-  stub_ss.add(files('cpus-get-virtual-clock.c'))
+  stub_ss.add(files('cpus-virtual-clock.c'))
   stub_ss.add(files('icount.c'))
   stub_ss.add(files('graph-lock.c'))
   if linux_io_uring.found()
-- 
2.39.2


