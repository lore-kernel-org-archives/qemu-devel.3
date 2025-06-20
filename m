Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E18AC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk59-00027i-QF; Fri, 20 Jun 2025 18:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLu-0003MY-Nt
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:35 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLs-0004fX-Uu
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:34 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4f71831abso1780261f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439791; x=1751044591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pwFDlvrd+vb4/dGkDyGi9U1PysLhBqAntF0fNqeB3k=;
 b=Xqt/ltOdLFWAfoaURaz8fULKvmbuXM+ar1EdxMQo75xIKjujmt3zG2Iskjcc7i/l/7
 Qx/mr9S3T0s4+wuIVMCeOFf2Qn49iYElL9kCtxjVJ60e/5ojFWSsGDhx4xVi7snD3fxz
 PgzoPB0GRL4SrdFW+Y31No9TYJA4iEQWg2HoIoZ6S1NRwNTLFKloHuvjNr8KhEaKhjz0
 imUz9iv2AJx0NbdBmXS/+1JyYkOo6tsDaaMYoxH/h/ycRvsh75Usya2pJXeCxpV9T1O4
 VLAI2kwuv/L7mKGIAoyQINn07qi0aYr7q9eWn/v2NwLhcPnZqdNlcic/LORBIzcHNe8a
 bJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439791; x=1751044591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6pwFDlvrd+vb4/dGkDyGi9U1PysLhBqAntF0fNqeB3k=;
 b=GCONmWLs2Irn/AiAGO975KIYU7AV71uF4Wf7D/HGNkEQpn00+wjH3fRcGIkcfFIeOl
 sz87BPdclAfezvDvToIuPj1raoJ2J2UYVRYIncXl9rT6DU46gTyZa7M9bm+WPWJJaNOU
 VIPny4+JOfxbPRsui0QEETydDBedxRZYU2BmzrpztmD83A1SxPLZfPF1w4hMPOqRIBba
 bBK6V5nCcER1IdT4Y8Yml063Mmd4czuvUcf5bqfCjbg3nMfAwRZE/yAmxCMN49cZ91t7
 4B5mfWmVKL3FGB9yMKX740uoxjyIqlKbdLlclgn3hJcG3cDLVcXZgekVFQxNurq04Hmk
 66dQ==
X-Gm-Message-State: AOJu0YxXU1IpTmcYjGOi0EMkrTaYbgsJJFibF6CM2/BXPQGVmjDxeKwz
 Iipx4EX3oud5IJE47+qGkR1AVhn11GunwILK0NM96TpSBHjgsHAvo35PxobV2cBbBbunVqFv7z8
 3TNOd4I0=
X-Gm-Gg: ASbGncvTIvurmxN0gHGt8jMKaIeSY7IwwmU2TFHpETAsohadSb2FIvYKnklaa3Wz1Jo
 6XdQlJCVM5yuQHOF5/4Pl+bT2JLgLf3afC0bKRDGRX1ACXOT3xfOiQJPglozHuvs1FpxJJhuCpg
 R9G5TEZfuFQ8uk+/Ar77Xb6EEiH9CgP7xTAD2nATpOJG6UUAG/vKQ0c4Q6lKJQY7ixPcyJ+FP50
 yzq5dqxx7rwuG6TXWyOVzlzvKFyy1r5Fo+NZoTdoNzIT/kSnR4/AA4Qj2/DSx6+bUY7nmLUo5q6
 EEvGxxfYHA4gJ4COyqK2HejIHErVpGPY7+QEgPcFwFb1FYtCOCzstN+PwcnY3y+shaCTuuZb8Kt
 J681yXGT+jgU6IntjlxP/NuBm8owh1/FyN3CM
X-Google-Smtp-Source: AGHT+IHcBoN+k9YlBvaTJrjhHSXLzpgblpnHT639b7DRYHPWBoOjrNqRDk1g3aMh1kr3+PCebNTWNA==
X-Received: by 2002:a05:6000:4109:b0:3a4:f892:de7f with SMTP id
 ffacd0b85a97d-3a6d13071e8mr3073816f8f.36.1750439791043; 
 Fri, 20 Jun 2025 10:16:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45369eae840sm4090215e9.38.2025.06.20.10.16.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:16:30 -0700 (PDT)
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
Subject: [RFC PATCH v2 34/48] accel/kvm: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Fri, 20 Jun 2025 19:13:27 +0200
Message-ID: <20250620171342.92678-35-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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


