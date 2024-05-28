Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0FDC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByJQ-0000hv-6s; Tue, 28 May 2024 11:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sByJM-0000gM-DF
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:00:24 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sByJJ-000761-OP
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:00:24 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57883b25b50so1110572a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716908418; x=1717513218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWdKhFl+Kfc9kH+fAvMfcLuu2N/gX3v3c37S9xvC8gk=;
 b=AANWsm1+yRse2UmaT4asy9nzleVIFfbw0PmSIUfPAFLgDwrSgmFlHRRBlM3YeG3J7r
 qXQr/15yxUdgY9hJa3MJOAyeCDYSwywRIqLTQOFeckaAJlW7MhcVa4CyNGyy7aPhN2ho
 SljMbompI8WEiLHueycMXdBF+Fi/asPJNPSYE7DCq41cHmNgev5SPXhQ59J519mODvAf
 j65uOwjlZ1UcM2DMUKx09Hr5PAcufNM6GwK7eZxMrpC3ZsvbKvLei+X9fAkqp8MYrro6
 P0hHO6yRtOHC13zrwDe/0W01tCG6XRTX41FaDT8hnsHwPHmGxwk9y65IQHk4LRFpoznz
 HM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716908418; x=1717513218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iWdKhFl+Kfc9kH+fAvMfcLuu2N/gX3v3c37S9xvC8gk=;
 b=TZdDQ6ZGkO7QMNxAnW762wkZ6hLYLdf4YuJUOTM0Yosul0bbEBVwTOj4/4U0rHgTFq
 sm/8Epqd/lZXvnbThmSeGlHb0X5/P5XlvsWwL40OhocfviDbrypR/nzfGnQt5jMYkbJF
 8PNrpyFhfk/itD+n/2eOioXVbivyj327/0QxCikp5CPN7jrkeKjTr7++pHFdiBAaGOTC
 PrnE4q4i1g51F6ireMURYvk1IB0vuzAv+bQyfcVHGbXsDFbVXqUo1xLpZjw8JtqQDqjN
 zwCK2eGJbj+Az2ETX+4P8NUQl+vrBL/Ti2F171xI8rEkH7nkQe3aT9+tQCAw960Ozp99
 9YlA==
X-Gm-Message-State: AOJu0YwlsBi3YC74PMYBHR3bIoBBPUls9GnQGJ1ioh2n6pK0V/W9/4Fl
 RerBB8NTo0ebwo78FgZ8FZG7z7ZQZZQ0+mdZB++Ba1/OAintG4vYHEh+lTCBYvwhQtSU+sWRHnC
 H
X-Google-Smtp-Source: AGHT+IHxwhWccnUxe3wniBKj9XUPnBr37FOvbrJuqFFxU3mwB+71MnSBGQo9+4DPLCy6IBXB7Bh0ug==
X-Received: by 2002:a50:870d:0:b0:573:5c1c:4f5e with SMTP id
 4fb4d7f45d1cf-578517a4197mr7201696a12.0.1716908417963; 
 Tue, 28 May 2024 08:00:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.214.26])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5798d861b05sm4772771a12.25.2024.05.28.08.00.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 08:00:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 4/6] accel: Introduce accel_cpu_common_[un]realize_assigned()
 handlers
Date: Tue, 28 May 2024 16:59:50 +0200
Message-ID: <20240528145953.65398-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240528145953.65398-1-philmd@linaro.org>
References: <20240528145953.65398-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

Introduce handlers called while the vCPU has an assigned
index and is still in the global %cpus_queue.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h | 20 ++++++++++++++++++++
 accel/accel-target.c | 23 +++++++++++++++++++++++
 cpu-target.c         |  6 ++++++
 3 files changed, 49 insertions(+)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index dd18c41dc0..f828d32204 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -44,6 +44,8 @@ typedef struct AccelClass {
                        hwaddr start_addr, hwaddr size);
 #endif
     bool (*cpu_common_realize_unassigned)(CPUState *cpu, Error **errp);
+    bool (*cpu_common_realize_assigned)(CPUState *cpu, Error **errp);
+    void (*cpu_common_unrealize_assigned)(CPUState *cpu);
     void (*cpu_common_unrealize_unassigned)(CPUState *cpu);
 
     /* gdbstub related hooks */
@@ -100,6 +102,24 @@ void accel_cpu_instance_init(CPUState *cpu);
  */
 bool accel_cpu_common_realize_unassigned(CPUState *cpu, Error **errp);
 
+/**
+ * accel_cpu_common_realize_assigned:
+ * @cpu: The CPU that needs to call accel-specific cpu realization.
+ * @errp: currently unused.
+ *
+ * The @cpu index is assigned, @cpu is added to the global #cpus_queue.
+ */
+bool accel_cpu_common_realize_assigned(CPUState *cpu, Error **errp);
+
+/**
+ * accel_cpu_common_unrealize_unassigned:
+ * @cpu: The CPU that needs to call accel-specific cpu unrealization.
+ *
+ * The @cpu index is still assigned, @cpu is still part of the global
+ * #cpus_queue.
+ */
+void accel_cpu_common_unrealize_assigned(CPUState *cpu);
+
 /**
  * accel_cpu_common_unrealize_unassigned:
  * @cpu: The CPU that needs to call accel-specific cpu unrealization.
diff --git a/accel/accel-target.c b/accel/accel-target.c
index e0a79c0fce..b2ba219a44 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -140,6 +140,29 @@ bool accel_cpu_common_realize_unassigned(CPUState *cpu, Error **errp)
     return true;
 }
 
+bool accel_cpu_common_realize_assigned(CPUState *cpu, Error **errp)
+{
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+
+    if (acc->cpu_common_realize_assigned
+            && !acc->cpu_common_realize_assigned(cpu, errp)) {
+        return false;
+    }
+
+    return true;
+}
+
+void accel_cpu_common_unrealize_assigned(CPUState *cpu)
+{
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+
+    if (acc->cpu_common_unrealize_assigned) {
+        acc->cpu_common_unrealize_assigned(cpu);
+    }
+}
+
 void accel_cpu_common_unrealize_unassigned(CPUState *cpu)
 {
     AccelState *accel = current_accel();
diff --git a/cpu-target.c b/cpu-target.c
index 9ab5a28cb5..de903f30cb 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -143,6 +143,10 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
     /* Wait until cpu initialization complete before exposing cpu. */
     cpu_list_add(cpu);
 
+    if (!accel_cpu_common_realize_assigned(cpu, errp)) {
+        return false;
+    }
+
 #ifdef CONFIG_USER_ONLY
     assert(qdev_get_vmsd(DEVICE(cpu)) == NULL ||
            qdev_get_vmsd(DEVICE(cpu))->unmigratable);
@@ -171,6 +175,8 @@ void cpu_exec_unrealizefn(CPUState *cpu)
     }
 #endif
 
+    accel_cpu_common_unrealize_assigned(cpu);
+
     cpu_list_remove(cpu);
     /*
      * Now that the vCPU has been removed from the RCU list, we can call
-- 
2.41.0


