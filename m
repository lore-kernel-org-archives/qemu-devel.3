Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECBFC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiT-0003bU-D4; Thu, 03 Jul 2025 07:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHgI-0007j7-7R
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:44 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHgF-0003v3-TH
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:41 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so47398395e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540438; x=1752145238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ToXpM4w8/5sKNrHHneMedU0DiOt+AW+hpLalmA9y/oQ=;
 b=XbZZLKJjpsYovwEv6zWJliZPhgpU+YdY2VJCHpxXpCUNQu1a5nXeIUWPbVhcjGQkdR
 T6LX7a7Y5KWAo5lLAI8dukGsDJv5I5jnjj39t7f0lTiMBqmFeyGl+B3IV6T9sXE7Y4nh
 xBEx9ndmkW1L7z7eZmGkJj+LQZ9B6s9UJKDBZltocJoD805Uj9AGqd7+81iRK8I4vYSZ
 kojmoYlDgQweC72B8b6ny9CaIY/C8osV1Rj1lVHr5VmTvAr9jlQenNxrMiGlo+04QeOz
 JINruGCeypLXFPGBnYw1N/10ggZdkSFfu5yTNVcALJZ0BJ/CeWo3daJYbIXCLf8l+vpL
 hVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540438; x=1752145238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ToXpM4w8/5sKNrHHneMedU0DiOt+AW+hpLalmA9y/oQ=;
 b=LOdu/pKuyelDCvOCfXmX63sWXDpbHYCKacHKuKn6gwoOgzMnKfPkq5wnEJcYA7Eg4w
 424xlsOaMFEnLUpY6g37Idhi/4VyYJom+UlZLcfmgSGvZFya1eqkzYSQdxURz4BI+tyc
 tFC8N+lQ7KTzj9Yfw7OvYjkuCnHkkp+LR9EeEoaIX4UpZkKD3Dzw6bB1+1GxJ8/AI4e5
 0LkLxq/1R0dHURW7Uxp7eQFGYHHZCnJhhkQgumRJNVgSoPcP9Z5E/JOCdvFr+Tucos2g
 gmsdBqdrNCuGCxq2TPfPOzCWe+esLe2GON7sjDBmlJ50aW60zObupo9XlKlAlC8DM3/o
 upMQ==
X-Gm-Message-State: AOJu0YxT6bioBoJ3UMQ74vLbHk4L3eFNqGoEjVE6TTtNLRzgrdv35bsR
 3J3RuPdLi1TDHyQD8iAsdE2Olg1Cza/FUdEi4SutdOKcwRE0RstavheN49b5bb31rqMCmFBLYsZ
 smfxo96I=
X-Gm-Gg: ASbGncteIRBDr0sGsGb4P9XJHzXd0Rcqeas6o5QWiJmXJLsceq5fI1Mo559qwDSQxzu
 9lHR8qfJIz+lwt6kpNj9jrE6Id8PHosZnDaekDetVEV5qeQvzUfA0AkEPbge+j3Wf7gCJOl0RsU
 CmdMUXYoFuGXe4ZDD51pFmLAK5i+GmVSesEof+81FmEI0I6Y2+oE5QfUFyznm6O7PSgaM1rjC+h
 2uuebd5225VQDr1ObD5lfSF9agtvrqi87BQKZ/cuZWAjY11we+f3kyjmoDtQMPj8QknubFs+2rq
 4GM3RdBC+5p/jZqcEqipeckVCdL5s/JYZvRbFVItC7oclDxVT6KiugdoAoPHlPXlUeK3MfGa8dq
 lxBb4If0+97s=
X-Google-Smtp-Source: AGHT+IEYK8CL39ld4Lpk8KjQCggVRRvPPW9KemNA8oVB4CaF2cQopLBTu2Fy1Kp1q6F5HqEp/pYaTw==
X-Received: by 2002:a05:6000:248a:b0:3a5:2ec5:35ba with SMTP id
 ffacd0b85a97d-3b1ff9f59a3mr5047430f8f.30.1751540437658; 
 Thu, 03 Jul 2025 04:00:37 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcef22sm23604935e9.19.2025.07.03.04.00.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:00:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 56/69] accel/kvm: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Thu,  3 Jul 2025 12:55:22 +0200
Message-ID: <20250703105540.67664-57-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-accel-ops.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 99f61044da5..841024148e1 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -63,16 +63,6 @@ static void *kvm_vcpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void kvm_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, kvm_vcpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 static bool kvm_vcpu_thread_is_idle(CPUState *cpu)
 {
     return !kvm_halt_in_kernel();
@@ -89,7 +79,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = kvm_start_vcpu_thread;
+    ops->cpu_thread_routine = kvm_vcpu_thread_fn;
     ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
     ops->synchronize_post_reset = kvm_cpu_synchronize_post_reset;
     ops->synchronize_post_init = kvm_cpu_synchronize_post_init;
-- 
2.49.0


