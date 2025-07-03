Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2206AC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiQ-0003Ka-Ur; Thu, 03 Jul 2025 07:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHg5-0007JG-DR
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:32 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHg3-0003qa-Gb
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:29 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so556684f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540422; x=1752145222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VtcgYIv7cyhzlknrW2Wv+nYV1/8CFpZnM220DOT3U/s=;
 b=EAeRMRAuYKIW3iBGNivv7RbeAOy1wY/o6wfeEMuQA1ZO6pTeITsfq6DHSsMUw3LyjD
 nxe4ZkCqoDR4WTHPHfBJocbKEYnKHYy1Zisa0IBnLxiJbCrXdzaat5hq2/BDeAvDEC7I
 NGCB0pB/AfE2luy/6MxpCmHyj+GYIo4xeo2A/ydg9HMtpS8R+yAwXkT8fFmcWEpWsEcl
 oeVvTrlTbX+voSYk3HS+UaNDRSDkhfjw161WfW96KR4+jKkwX79H154oeRLqIIZo5pLG
 wdNKHaU1UF+0tonWT02qfaJa1jfSQO+KZxVk6eHy1UjlJqYA0ZZKIpkM1s4GU2GT9AYT
 SNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540422; x=1752145222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VtcgYIv7cyhzlknrW2Wv+nYV1/8CFpZnM220DOT3U/s=;
 b=k11fitsWKELDSAIg8AQFwF7MUWvDK+OboxbpQ2q8/R7UwdPbNUV093YshWC+II7sqo
 C9E6YLEHNtzKKU8nOmlYcwUmXfj+AtnHFhG1S3i2h3W9Ow9PTiAI0e7hOXviVTgUstF5
 QMWD+KOiOBR5/tFBtVQgz474dHRZgT3q/dZO2U9Tczkp+jIQrz6G81q0qLzcpBTs1i3o
 iToeoHyrGcweEznOgDdRqdPDLa1dDJPCt55bWL2jKkhSJmZvoUyf2T9glMFrxyN9aTo0
 rE1n6cFi/GxSJrRcxeZ0g6Jk9JPCjlQzAYc/wxjV9NucWRMgHU66nTzIzTPbNuksLA2Z
 cS4g==
X-Gm-Message-State: AOJu0Yx8RcresajkKyA/WS4+R3PUYXOtwWib4Rwtlj3URcDEW9tVf3vd
 Dd5o3N+s/iBM6N5CsXfOeX1ZmOWydHGIbooNPdodrkRseXrm4XP1rLg5QgqCMQw/pqHARrpjjAy
 hpEv2pcI=
X-Gm-Gg: ASbGncvS8epfRUDfTsc5FF9sIZkUtRUOh4/0GhXYzvVC4W3ggfk1jTbd0I/u6n7oXTM
 COTI571/cGYUeEKSeODwIQFMwFIHQcfhbZZ8eA+efCrI0rB116TReBotNLVn5aWBUsxa5zfw8xj
 /VESYW6GWnAb3lBN8aNrlXfUbpIQVeB/3XtGu6VrAzWGUXq5faQ66H7c+uQAD4pA7m++BpKSXOz
 Kaj3v86FRnct/HjjyVaYjfgccCYagAbYHZumNugg1GNO6BUAgLVAv2m/XWd8LMA2Hu4zLuiLnXa
 06DYgcqk6151oLLrJvd1yprW6l8J8WCPOBm579JqbGdH1EoQYSSuZY+vMhNwDz6ZVk95SjzQS3z
 JvtDR0jj/0Wk=
X-Google-Smtp-Source: AGHT+IGD7TC9O4oxqN4AXMXx4fT0V4Qtg0hQBWZhDby2s+AzbNTf4+ZNgcj1dYa/jzmx9avOyZc4UA==
X-Received: by 2002:a05:6000:987:b0:3a3:7ba5:9a68 with SMTP id
 ffacd0b85a97d-3b343889c82mr1880924f8f.18.1751540421981; 
 Thu, 03 Jul 2025 04:00:21 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52c99sm18125528f8f.49.2025.07.03.04.00.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:00:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v5 53/69] accel/dummy: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Thu,  3 Jul 2025 12:55:19 +0200
Message-ID: <20250703105540.67664-54-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Fabiano Rosas <farosas@suse.de>
---
 accel/dummy-cpus.h  |  2 +-
 accel/dummy-cpus.c  | 14 +-------------
 accel/qtest/qtest.c |  3 ++-
 accel/xen/xen-all.c |  3 ++-
 4 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/accel/dummy-cpus.h b/accel/dummy-cpus.h
index c3af710ee8c..c2f9fee164c 100644
--- a/accel/dummy-cpus.h
+++ b/accel/dummy-cpus.h
@@ -10,6 +10,6 @@
 #define ACCEL_DUMMY_CPUS_H
 
 void dummy_thread_precreate(CPUState *cpu);
-void dummy_start_vcpu_thread(CPUState *cpu);
+void *dummy_cpu_thread_routine(void *arg);
 
 #endif
diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index 2cbc3fecc93..f637ab05e32 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -19,7 +19,7 @@
 #include "hw/core/cpu.h"
 #include "accel/dummy-cpus.h"
 
-static void *dummy_cpu_thread_fn(void *arg)
+void *dummy_cpu_thread_routine(void *arg)
 {
     CPUState *cpu = arg;
 
@@ -71,15 +71,3 @@ void dummy_thread_precreate(CPUState *cpu)
     qemu_sem_init(&cpu->sem, 0);
 #endif
 }
-
-void dummy_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    dummy_thread_precreate(cpu);
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, dummy_cpu_thread_fn, cpu,
-                       QEMU_THREAD_JOINABLE);
-}
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 2606fe97b49..9f30098d133 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -64,7 +64,8 @@ static void qtest_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = dummy_start_vcpu_thread;
+    ops->thread_precreate = dummy_thread_precreate;
+    ops->cpu_thread_routine = dummy_cpu_thread_routine;
     ops->get_virtual_clock = qtest_get_virtual_clock;
     ops->set_virtual_clock = qtest_set_virtual_clock;
 };
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index f412ea346bb..e2ad42c0d18 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -152,7 +152,8 @@ static void xen_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = dummy_start_vcpu_thread;
+    ops->thread_precreate = dummy_thread_precreate;
+    ops->cpu_thread_routine = dummy_cpu_thread_routine;
 }
 
 static const TypeInfo xen_accel_ops_type = {
-- 
2.49.0


