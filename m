Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C74DC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMGj-0005CC-Js; Wed, 13 Mar 2024 06:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rkMGb-00059F-VU
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:55:26 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rkMGa-000796-20
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:55:25 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-513c847c24dso610598e87.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327321; x=1710932121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5oT1XKXBFQsUGk4QG2qYw4iHv7mWal+0jdHBO1XvE/8=;
 b=VpaSVLkaOmbmm7LsPaZYn6MVTvDU1Mv73nm/9clRz68mIAeuy8Jm/Jjjw7Wydilsl+
 KtrOeQN1uu6POuT6fOzXxE0LlqsatV9kZkMhk84U/Dq3oy7dHqAy6NCcmw2Ynxynsa/S
 MQZYTCcG8YVzIcXweCm10bqmvcCYRCPfdH06yA25HQzudCpc6c7KmhnCHb4hfeFmnhdJ
 vMHfZyJny2ZhVM+9aQCkck26uxsx839ekEKjasHRCdNX6IcyQOFSD2abqPMrW9KV3Zh3
 7bUuOlh+9U46KsBdc/xMTFD+cfqur6qRLxb9np4XI6fy5rg0HBcMEuaIqYLRNunR/keb
 kJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327321; x=1710932121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5oT1XKXBFQsUGk4QG2qYw4iHv7mWal+0jdHBO1XvE/8=;
 b=Sf07XxGJwMadPgFfTCdRoba5NI4fS0tQBhdc7xtdbwbD9HmzJLoMXFiuZXbYgHXD+M
 +5cB4mLN1Cxpbczt8aKF7M/T1O55t0kwUTbbPUdYokODXe+0er1TY9DQyoV5onfMUI/O
 xPNnXjqHq8+P6EULB0G187+g5mCbLHNul03EkEBmtjLUDqKAKieD7DDq114nSVAZfhfk
 HtiwLgyT4cDIdA4aSncwn58Ct3dGOy9BVBC8kWG2ARs9+a5izBVXK/jIGh7W6qQbSFCw
 mvM0JsAT2X0VZQhiIEnci887yJaQmnn4TE/ebp+Ipg8G2MxA8wPLPOobzPNW5rmJbkUx
 lvIA==
X-Gm-Message-State: AOJu0Yxp86il+o8JrJP11z1He3kFEGX2CvpBe9AYSfztKEVTVotZC/ae
 n6FXPAJCZcww2DiHZGPbjfnVABbUyUbQ8ZrWm0gOOXjpWgQoa4KLfo1gOrERaADWgDSY1tkBF7p
 n4Gs=
X-Google-Smtp-Source: AGHT+IGW8eag6E9K9MiCk7cY3Xd6Y4/xgoeq/RbYeXS/vtpaOMAGxd9pJ+BXuW9w+qR9GQQQuEK3Fg==
X-Received: by 2002:ac2:4c42:0:b0:513:2004:43e4 with SMTP id
 o2-20020ac24c42000000b00513200443e4mr4071069lfk.36.1710327321112; 
 Wed, 13 Mar 2024 03:55:21 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 w17-20020adfee51000000b0033e1be7f3d8sm11390338wro.70.2024.03.13.03.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 03:55:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 1/5] sysemu: add set_virtual_time to accel ops
Date: Wed, 13 Mar 2024 14:55:00 +0400
Message-Id: <20240313105504.341875-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313105504.341875-1-pierrick.bouvier@linaro.org>
References: <20240313105504.341875-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x12c.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 68d161d96b7..03ba026667c 100644
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
index 0bf25e6ca53..1a7957352b1 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -5,7 +5,7 @@ stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
 stub_ss.add(files('change-state-handler.c'))
 stub_ss.add(files('cmos.c'))
 stub_ss.add(files('cpu-get-clock.c'))
-stub_ss.add(files('cpus-get-virtual-clock.c'))
+stub_ss.add(files('cpus-virtual-clock.c'))
 stub_ss.add(files('qemu-timer-notify-cb.c'))
 stub_ss.add(files('icount.c'))
 stub_ss.add(files('dump.c'))
-- 
2.39.2


