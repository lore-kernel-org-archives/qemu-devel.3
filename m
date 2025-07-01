Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B505C8303D
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcFG-0005kk-9u; Tue, 01 Jul 2025 10:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcEE-0004n3-Jv
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:45:00 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcE6-0007Bw-Uq
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:54 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so35425245e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381087; x=1751985887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUEmSjw9TnyTWyYzMckbm1pP3ygwwt9KUL3EslPLnFA=;
 b=mc7qFV16SfDe2pnW8B4o4DGIHHHltAQnP9zAvfOSyW4ekCCLIArRQsxdi/umopds9D
 //nkmhe7XGsCeVJcwDPgc8qAtcFflbDnnk2C/hGC2q6nVt6g9ribYw/4/Gup+6Us+fD4
 NyTfmtC1kv7srngwtgJRiSi/P/LUttBuGkDAQtW/xVbYFwE1Mv1xvQ70sE6S26GJBw6p
 /oZpYEEihJ5zLihDsv9letSqEXT00zdJQzcxnduoBex057E3FIUe/DpV3sSQner6W6oy
 +6EaszS9ukEZAaCQJ4kQqCotVMfOum6XtQaX0C6gtQw6Z2adP3Yud2odGLOjdRvf8I2G
 zaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381087; x=1751985887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUEmSjw9TnyTWyYzMckbm1pP3ygwwt9KUL3EslPLnFA=;
 b=RnsMjLY4PbMSGI+fdnH35ac5NfDIsmz9InyTAJWbbL5iPpJCCdDy9WpOt7dtbve8qN
 Ms7/piPBmJLWyb5iefuY0hRVEaEFRewNiHzuO9b8qW+M54B8eU2sgl84ucNq82L+Xy60
 eK7H5nevrIESGmnZXOi69DaUFZufG5W0Z43tks+/SyZ+AlY2EFupuGfpWLUdu1s/GUmi
 MIqkirg0E/KrnwAL/Fq2eQVkUjF5A6+iOnQyrEetSnSFf4AJ6A0VNhdV2ffPjjRGWznK
 uyDHSOOb22JKp2tewpTzWIcpVxrtE2p7vBINuRK9ZIUwrThfwajjCT/915g9KJJjRteD
 thEA==
X-Gm-Message-State: AOJu0YzplVyi3GAW5K5IWhCK2miWlu+DMNAi6HSRiQ9QhbTf0ia2qbKA
 b7OilOz1lQrFIC0VsNIrCLgn73cRU6ON+bSE9OM+6b8VtfbZ/Zd96fgQ3nDlIoPvGeQhKkre2mn
 nFCH6
X-Gm-Gg: ASbGncvIvQvfEkGunMZ/Z4XdjhztDOT0Ibpx3JieMrKN9p1KDZhdqlO1XE78GUYYocD
 JCUABwhgIazIClCb3i4U0FBEXEtScKLIBwZrTPuSheQbfukQTnAAFQ8YAaX0Z5caYkqlUGEiXT1
 xdxpqx8SK/yxuX+RNk7ZIO0xe1bM1W1QbVbN4GqJCsjDp7qppdRZHKt3k0KzVWCKBP7ioFQuPWB
 y4G896WyWqVblJKYPLLgSCCU+oaW+ggtVTlJLjWkuLsXbLXyaISFqGbF2aXE3RjjNswGJyrf/c8
 KS9vqXK7DtqNRb+plMCzwIEV2AkSXHn6/kl3m8b2BMWWxqVVIE3WOojoJe66XA9ewFnzrT5JxIw
 Ai9GHCQw6TyJPPyZ5yeHAiCSIBAgAxen/x67XrPuC5Ou/x/4=
X-Google-Smtp-Source: AGHT+IECA0vGA6TjD6CfwEHllBF3xq/kheIyylk4J7Ga1buSmYaLFLYKaY91QWHYhA4lg+7jzm0qwA==
X-Received: by 2002:a05:6000:440f:b0:3a4:efbb:6df3 with SMTP id
 ffacd0b85a97d-3a8f454904fmr11861857f8f.10.1751381086625; 
 Tue, 01 Jul 2025 07:44:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13163736f8f.43.2025.07.01.07.44.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:44:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 51/68] accel/kvm: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Tue,  1 Jul 2025 16:39:59 +0200
Message-ID: <20250701144017.43487-52-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
index be960bde5c4..21ff3af306f 100644
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


