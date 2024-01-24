Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7812C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 15:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSfac-0003g5-Ol; Wed, 24 Jan 2024 10:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSfaP-0003bu-4s
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 10:54:46 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSfaN-0002P7-J0
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 10:54:44 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e775695c6so54824025e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 07:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706111681; x=1706716481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v3Z0Jq1OM+053LyGdHXwEFjN+ojKTQFR08GCVhW4ybo=;
 b=zsihVpruycjU1JIQURwG+6A4eTLvnwD5oMzhCBPQxO3hdiv+DDfYxOG74jjihbU1j/
 Amt/YICWuNzoIpJWA/M8KL6Ab+hnfX76zB0WTE0I6UCqHC9z9rCLr1rDTKneIrL9B25b
 JSGx69+DZnPSO+mY63GUTJPDBzAZ+pky4Plkq20fBOGDNO5UZlkESmp5j0tB1x4O51Gr
 F4Cz6RY9xHvO0bXg2eguAf1pU79wxVmnpfejo6VbECWOhA6MNcSHAHgKEptEV3moYC2k
 az/Tzs7H4rq2bfSNoko2yvNZcMMyiStzPs90qioFuLwtO1h8KdZGrDhHaWjPWqUdtECd
 r6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706111681; x=1706716481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v3Z0Jq1OM+053LyGdHXwEFjN+ojKTQFR08GCVhW4ybo=;
 b=TtXu1occJriRU0SeA4OMTLPH/nZbe4wYZJcN1AEFBsfLezdtO3Zof7lcaFRoI5lAzS
 swotXwrHZ7Imi/7idCF5LbfrfSlp2Cvrs+UpxM9jzCBEdXJ5ZZmsHZb+OuquZj+zF9iu
 AajJNrWC/JbX2cjukj/fAazLvfFS7sBamYB/nnIjRqIpzffORQ3PrWyL+oF1qfAgvvZB
 uEHO3SyGq5cUl7jM85i+9LQqgRaz5Lx2mWpf8dbEFvS9weHc/rlStG9HIf52kITj+oHJ
 tqntQHiK6lREg8WW38GgSlPhNxlvpeKEGCBPNFSMbLw/mqLCtUno7k5S9ZRBPS7f2Bit
 9fTQ==
X-Gm-Message-State: AOJu0Yw7bITWcorskspEff9TAde1+JzfEou3hwNNwVVFWM9EXLmBT1xF
 RS9Jj2S7Lf//CgRIDUcMkW/1Sw0LiS1M7jWbnOlDAvoK+y/MRgJtf6V7m26HCngNq4FkpXAZmWB
 A
X-Google-Smtp-Source: AGHT+IHKTp1SuOzIsHw5nkqILY05RVW6D4Zl2jPs9OD7SWzZf+XP/XIOGWgID01b2/sofwnHFo0tPA==
X-Received: by 2002:a05:600c:4f87:b0:40d:8810:468b with SMTP id
 n7-20020a05600c4f8700b0040d8810468bmr1763339wmq.88.1706111681634; 
 Wed, 24 Jan 2024 07:54:41 -0800 (PST)
Received: from localhost.localdomain
 (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr. [176.184.8.67])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a05600c4f0700b0040d5f466deesm57530wmq.38.2024.01.24.07.54.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 07:54:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] accel/kvm: Directly check KVM_ARCH_HAVE_MCE_INJECTION
 value in place
Date: Wed, 24 Jan 2024 16:54:25 +0100
Message-ID: <20240124155425.73195-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124155425.73195-1-philmd@linaro.org>
References: <20240124155425.73195-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Directly use KVM_ARCH_HAVE_MCE_INJECTION instead of
KVM_HAVE_MCE_INJECTION.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/kvm.h |  6 +++---
 accel/kvm/kvm-all.c  | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 2e9aa2fc53..4107678233 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -350,11 +350,11 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
 /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
 unsigned long kvm_arch_vcpu_id(CPUState *cpu);
 
-#if KVM_ARCH_HAVE_MCE_INJECTION
-#define KVM_HAVE_MCE_INJECTION
+#ifndef KVM_ARCH_HAVE_MCE_INJECTION
+#error Missing KVM_ARCH_HAVE_MCE_INJECTION definition in "cpu.h"
 #endif
 
-#ifdef KVM_HAVE_MCE_INJECTION
+#if KVM_ARCH_HAVE_MCE_INJECTION
 void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 #endif
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 49e755ec4a..b98c0843b1 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2750,7 +2750,7 @@ void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu)
     run_on_cpu(cpu, do_kvm_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);
 }
 
-#ifdef KVM_HAVE_MCE_INJECTION
+#if KVM_ARCH_HAVE_MCE_INJECTION
 static __thread void *pending_sigbus_addr;
 static __thread int pending_sigbus_code;
 static __thread bool have_sigbus_pending;
@@ -2855,7 +2855,7 @@ int kvm_cpu_exec(CPUState *cpu)
 
         attrs = kvm_arch_post_run(cpu, run);
 
-#ifdef KVM_HAVE_MCE_INJECTION
+#if KVM_ARCH_HAVE_MCE_INJECTION
         if (unlikely(have_sigbus_pending)) {
             bql_lock();
             kvm_arch_on_sigbus_vcpu(cpu, pending_sigbus_code,
@@ -3339,7 +3339,7 @@ void kvm_init_cpu_signals(CPUState *cpu)
     sigaction(SIG_IPI, &sigact, NULL);
 
     pthread_sigmask(SIG_BLOCK, NULL, &set);
-#if defined KVM_HAVE_MCE_INJECTION
+#if KVM_ARCH_HAVE_MCE_INJECTION
     sigdelset(&set, SIGBUS);
     pthread_sigmask(SIG_SETMASK, &set, NULL);
 #endif
@@ -3358,7 +3358,7 @@ void kvm_init_cpu_signals(CPUState *cpu)
 /* Called asynchronously in VCPU thread.  */
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
 {
-#ifdef KVM_HAVE_MCE_INJECTION
+#if KVM_ARCH_HAVE_MCE_INJECTION
     if (have_sigbus_pending) {
         return 1;
     }
@@ -3375,7 +3375,7 @@ int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
 /* Called synchronously (via signalfd) in main thread.  */
 int kvm_on_sigbus(int code, void *addr)
 {
-#ifdef KVM_HAVE_MCE_INJECTION
+#if KVM_ARCH_HAVE_MCE_INJECTION
     /* Action required MCE kills the process if SIGBUS is blocked.  Because
      * that's what happens in the I/O thread, where we handle MCE via signalfd,
      * we can only get action optional here.
-- 
2.41.0


