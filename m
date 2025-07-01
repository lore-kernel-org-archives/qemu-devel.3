Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C14C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcC7-000058-Fo; Tue, 01 Jul 2025 10:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBr-0008JB-Kk
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBe-0006yo-3Y
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so22563115e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380930; x=1751985730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axJArW7R6hoHyM0cZ+bFREhZztYbwYGa0vAn/8d4yVk=;
 b=ddBPGMpJjRoa52iNEgp0I54wHuKlov9N5SdxnxWMvsRhaoXnPgOJm+k0AIrod2rHjW
 D3Uz9ucHwPLhPN3E8xA2wePR0Ikp8t9QbFYDHXJn33Yr7L5Of9VJ3mCZ6TwuNgYEDtrp
 3q1JlKvA4Lg2J8J9JG8lyO2Sufog8zFWZYPs8nUwIfL+zLDtTnGMRrcmK5MCAWN7aBsQ
 wl5EmHOz7PGAq6sHrjpBAu+Rhhy/lE+nk67BnzwY5Bs4dN0z0t6GO0uOZB/rCcbZHv9g
 Bt4GH48yIiB+4k2/4+Hz/Shlf3uR4pct50iRazVWL5sLaUu4bpTLu8GF2hRtr+vqSp9o
 A09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380930; x=1751985730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axJArW7R6hoHyM0cZ+bFREhZztYbwYGa0vAn/8d4yVk=;
 b=oHwKRa6DqXzBV1spNlYDW4QIGZrg1aBJYEvGWVtBbM9gHEbTqIFMnT0w6hqwoN0eTb
 W+3Nf2+cYZkJKwRrvQ4WLTGkk3pvel2ZiZZv7ze1GsE3AQtLERKXDWmTuI5TZutrEFe5
 z55ydqHV32mFcmzNBRRPRgeha+41A6K9zIXexvmLyYpoSdOLAOjr8zl4y7siUu+UvPST
 +yhHFiNnXDCSng+1djcs8dRWNtZAgJgrg+K8jYNQCVeiD/7k8MNz0Vt8GLCngIdiy53x
 ClaFt/xTLBa1nfPaKzxqLh3t0kuecSKsDGcnYmwrpHO7DQEnOu+95wmCkqIA0K/VXMZz
 g8Ng==
X-Gm-Message-State: AOJu0YzkBUacbFTFFIsrANuDWygU8jLxqfgczN20RfZkM9qXBHApkHB7
 bIYfFz9xDjR7Kgs3oqaGXK5rUjprCyI+oZMY+DolrJAdopDML4GnZFxHZRzMNK5cJiGSHM3vUin
 hGFBd
X-Gm-Gg: ASbGnctamQXvP3UGclRnJn+PqD3PdGBwPuW2iI0mANws6jDVnDh+TCTtQ2QUGkvRYSx
 BGfqT1eABbSQoBfnMPDbUkWTRYs0sw6MKBJc1SwgBiRpKZ4SbfE8zlyrTcgetRZalD74cdCAyor
 2DtIvXi9FsnF1+bPZPuC5rhOzpfoRdEKC/BuLOKE0Rt/hZ6DUFjqXjejsTw7PAyRscto/jIHDY1
 U8/tHK641HcPP4T9ixe/odThR2015UViAP4PCZ1HMlvaP3FwWkePrAZ8lHdVqmgP+OipCluINR3
 BdHiD4J5cgRo1m1hPDwfDx0/iG0TZgN7aIDsrAAVjcQsLeer6ex9b3iKIH03WhKGzjGjOdKXO3b
 5E3Z2YyC/wuuzZOc59MiMKsPZDLnaeHAFc8k8
X-Google-Smtp-Source: AGHT+IGOED0ImNa5ldjUFK5Zrb55YA5GMnIZJ6zfdkIvh7Q7j7YNibEgUM3rgWPHtSZPSq5MA4Ea2A==
X-Received: by 2002:a05:600c:138d:b0:442:f482:c429 with SMTP id
 5b1f17b1804b1-453a84069b7mr34476825e9.8.1751380930116; 
 Tue, 01 Jul 2025 07:42:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3fe592sm164217925e9.21.2025.07.01.07.42.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:42:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 20/68] accel/system: Introduce AccelClass::pre_resume_vm()
 handler
Date: Tue,  1 Jul 2025 16:39:28 +0200
Message-ID: <20250701144017.43487-21-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h | 3 +++
 accel/accel-system.c | 9 +++++++++
 system/cpus.c        | 1 +
 3 files changed, 13 insertions(+)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 518c99ab643..065de80a87b 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -47,6 +47,7 @@ typedef struct AccelClass {
     bool (*has_memory)(AccelState *accel, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
     bool (*cpus_are_resettable)(AccelState *as);
+    void (*pre_resume_vm)(AccelState *as, bool step_pending);
 
     /* gdbstub related hooks */
     bool (*supports_guest_debug)(AccelState *as);
@@ -86,6 +87,8 @@ int accel_init_machine(AccelState *accel, MachineState *ms);
 /* Called just before os_setup_post (ie just before drop OS privs) */
 void accel_setup_post(MachineState *ms);
 
+void accel_pre_resume(MachineState *ms, bool step_pending);
+
 /**
  * accel_cpu_instance_init:
  * @cpu: The CPU that needs to do accel-specific object initializations.
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 637e2390f35..11ba8e24d60 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -62,6 +62,15 @@ void accel_setup_post(MachineState *ms)
     }
 }
 
+void accel_pre_resume(MachineState *ms, bool step_pending)
+{
+    AccelState *accel = ms->accelerator;
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    if (acc->pre_resume_vm) {
+        acc->pre_resume_vm(accel, step_pending);
+    }
+}
+
 bool cpus_are_resettable(void)
 {
     AccelState *accel = current_accel();
diff --git a/system/cpus.c b/system/cpus.c
index 4fb764ac880..98ae8b1e271 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -765,6 +765,7 @@ int vm_prepare_start(bool step_pending)
     if (cpus_accel->synchronize_pre_resume) {
         cpus_accel->synchronize_pre_resume(step_pending);
     }
+    accel_pre_resume(MACHINE(qdev_get_machine()), step_pending);
 
     /* We are sending this now, but the CPUs will be resumed shortly later */
     qapi_event_send_resume();
-- 
2.49.0


