Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C99CF6493
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 10:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suUK3-0005ki-I1; Sat, 28 Sep 2024 06:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suUK1-0005jy-6Z
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 06:05:05 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suUJy-0003kv-Em
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 06:05:04 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cb8dac900so27491145e9.3
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 03:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1727517900; x=1728122700;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RNQxvE8WZGw6V+rm60m0nnsO2Elk2meTcImZqxrGrWg=;
 b=ifXQvY8bTCEG7PlMuta7rZ3bjJkkk3+jYmHsyDcPoOuv0oN1DGuv+/yK/vKtDXXPgN
 bH5t+nuiwlEmbNBoKFtsq/EUe1hPTSBZsVS5oO6gMi8/MT3nnVtVuaQKNyrw7Bxg7oKJ
 6A1cWjbGsRb4y3P5+2ARaLZB+l+HNCF4bulhAV5CfFI7J0PUEYy7c8mPGpdIHI4tOYDd
 kXH7gM8UOKt5RTwntu/+lQLEKZn/VQqva5rDR2kP/evzb7Sc+qd8ArRb3En9Ya23V/4W
 YdZUIaBvMFFXQ+mlJEZYreZpx4lgJct9ov59Ayh6YELYLFPA6IFwN0Fn96XsXM4wCrrW
 MvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727517900; x=1728122700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RNQxvE8WZGw6V+rm60m0nnsO2Elk2meTcImZqxrGrWg=;
 b=kvqoYRwTxzI0aWF/gWUtCAWNfBBpBJcEKrHRxiVyiVmYW4cdXU16CUwPGHPKrjo+zy
 /gMFoh6yXluw8zDcyUXR6IizFcCtppoPlpix2tiyeQhF4tv9pkF3YtETMR6/AWcn+hj6
 +UroNhtynxqnAy0lv1+EJK8zwpH6VrX6rGARrGqnL8JvcDwWwlLmiV6AVDIN76gAl+wp
 p+wF4hePEt5kRLLbE5COgdNOi1o7ptZqe1S8z17vbqWXj8sl9PZi5eYh1bH6tgpxFW3a
 CO4Z+bggIg8Risj0B8et9G+Uep2oqXCXOLFrnQccT8cX7ws2f8FTH4uf6I4sXwcmAo+5
 iiBw==
X-Gm-Message-State: AOJu0YyxfQKAr8wDPQ6NNrM/IxJD2wivazFxwR4GVk7GE2IK4nqU38ip
 AAW0p0c+Glo0ape/daX+B9E0W6vmtLMOjDHFz4auV/Rx/0qU0tRjxobk6+tW1PAftIxM7Xkb9fD
 CCA==
X-Google-Smtp-Source: AGHT+IHOo17TyP/2evU3KAhkhFzidvuzdcBBDAY/dK2tOLcGmS4ESE9Btxjti9Ag/fSgBd3/cfl1vA==
X-Received: by 2002:a05:600c:a4b:b0:42c:b6e4:e3aa with SMTP id
 5b1f17b1804b1-42f5840d0e8mr45267825e9.5.1727517899739; 
 Sat, 28 Sep 2024 03:04:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bb8:2ae:e42d:d5c5:e3c:35e8:188b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a56fd1sm95434715e9.48.2024.09.28.03.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 03:04:59 -0700 (PDT)
From: phil@philjordan.eu
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu,
 philmd@linaro.org, minhquangbui99@gmail.com, akihiko.odaki@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2] i386/hvf: Integrates x2APIC support with hvf accel
Date: Sat, 28 Sep 2024 12:04:50 +0200
Message-Id: <20240928100450.1666-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::32e;
 envelope-from=phil@philjordan.eu; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

Support for x2APIC mode was recently introduced in the software emulated
APIC implementation for TCG. Enabling it when using macOS’s hvf
accelerator is useful and significantly helps performance, as Qemu
currently uses the emulated APIC when running on hvf as well.

This change wires up the read & write operations for the MSR VM exits
and allow-lists the CPUID flag in the x86 hvf runtime.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Acked-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
v2:
 * Rebased on latest upstream post v9.1 release
 * Minor cleanup in x2APIC MSR index calculation

 target/i386/hvf/x86_cpuid.c |  4 ++--
 target/i386/hvf/x86_emu.c   | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index e56cd8411b..4f260d46a8 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -64,8 +64,8 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
              CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX |
              CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS;
         ecx &= CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
-             CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID |
-             CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_MOVBE |
+             CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID | CPUID_EXT_SSE41 |
+             CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
              CPUID_EXT_POPCNT | CPUID_EXT_AES | CPUID_EXT_XSAVE |
              CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND;
         ecx |= CPUID_EXT_HYPERVISOR;
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 38c782b8e3..f90c79e083 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -663,6 +663,15 @@ static void exec_lods(CPUX86State *env, struct x86_decode *decode)
     env->eip += decode->len;
 }
 
+static void raise_exception(CPUX86State *env, int exception_index,
+                            int error_code)
+{
+    env->exception_nr = exception_index;
+    env->error_code = error_code;
+    env->has_error_code = true;
+    env->exception_injected = 1;
+}
+
 void simulate_rdmsr(CPUX86State *env)
 {
     X86CPU *cpu = env_archcpu(env);
@@ -677,6 +686,16 @@ void simulate_rdmsr(CPUX86State *env)
     case MSR_IA32_APICBASE:
         val = cpu_get_apic_base(cpu->apic_state);
         break;
+    case MSR_APIC_START ... MSR_APIC_END: {
+        int ret;
+        int index = msr - MSR_APIC_START;
+
+        ret = apic_msr_read(index, &val);
+        if (ret < 0) {
+            raise_exception(env, EXCP0D_GPF, 0);
+        }
+        break;
+    }
     case MSR_IA32_UCODE_REV:
         val = cpu->ucode_rev;
         break;
@@ -777,6 +796,16 @@ void simulate_wrmsr(CPUX86State *env)
     case MSR_IA32_APICBASE:
         cpu_set_apic_base(cpu->apic_state, data);
         break;
+    case MSR_APIC_START ... MSR_APIC_END: {
+        int ret;
+        int index = msr - MSR_APIC_START;
+
+        ret = apic_msr_write(index, data);
+        if (ret < 0) {
+            raise_exception(env, EXCP0D_GPF, 0);
+        }
+        break;
+    }
     case MSR_FSBASE:
         wvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE, data);
         break;
-- 
2.39.3 (Apple Git-146)


