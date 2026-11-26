Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108BE606A33B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I7YQz6x9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWaXh-0003mJ-Mu; Thu, 26 Nov 2026 09:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.mehnert@gmail.com>)
 id 1xWaXQ-0003Dg-JR
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:33:31 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.mehnert@gmail.com>)
 id 1xWaXI-0001B2-QY
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 09:33:28 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so44185205e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 06:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795703588; x=1796308388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hSzWdqovOS7zanPgxojJ0emViJPJpi0/B9Bvq88rSEI=;
 b=I7YQz6x92Aks03iT1yg8eZLqg8KIctKrP7+SIsm6xd7U2NztmLchDO3f8BHsGZrUk7
 g/vae0by+TqbZNTWmQRWxNdbx5DOwZpT8XnLu00R8ruj8bP9u4DFhTT7ne+7KC/7j3wm
 Go5EcNF/zcz5EIE2KR/QKrJEQqGZHtRvF+VGNhmwbcd8lv0f2FZNH14rpgIIsyNDwEhs
 0liouKRi9iY5QN/1qB4RYuLxrGBy+k86lj6xd1OQwHyZ89ShXmYVmaKMUcAGJru5AGTj
 6/kn+iclrI1BKVdoFyyvpytoccvmZcu5KAlm1+JULfY+X0u+1xUpaueHdB7FfeFw3vPF
 08vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703588; x=1796308388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hSzWdqovOS7zanPgxojJ0emViJPJpi0/B9Bvq88rSEI=;
 b=C3bAqOLTgXFRVZNvPNq/v6Q8oF5kK0jV4GKhO5zXSKs6+CjHmqiUWLOV/Zbz2hZGNs
 YG2rWKOb3asBUuusoIbT/jGpEmW3tzjYQwiPomUN/YXXzGX63T6GTmNAzesaMGu7c5mm
 SiYk+myp+yb4FP1I/OJZ6NPEL83DQ65tdZIhvJCsKiqpIvtJGQ2F7nNB3pZ/SGwKDpv+
 J/qxeF5ojDJ4s3I5UinZdY7HHPOkbVt5dxhnCt3EeVBDPI9nnG7MtkKjq9OeyOqJaVQM
 I7krwIE9/fv+73ne8g2jpk+2DqZNYmCibLv2tflVGGBMdtnDvjxEe09ZigS6ASLrpSvU
 If1Q==
X-Gm-Message-State: APuU4Z+4u72vFYQmeBnPpz0KhuodqCE5xQmRrzOy5u/weWKXtONLaTGB
 YN4zjg+L6w0oLPr3ufAY/iLoyqHDfE0LLFIA755ev4SHH5mh+hPzQDNhRIJFAPGp
X-Gm-Gg: AZFdTZfid6h1hAKLAKqsf1/gLwtJ5wpVvBU6YCPyi41+Urcyc+0u1LQUEfi/9U6Q6Rp
 SAUG8FI5n6Lx/aN7wPi/8QUpGX+XraG638xBrGFk54gReP3WDFPHbGQkeM9GPwAq3PrWYfelOYy
 5AgTGbOxoih1GGhl6RbVwFlHczW4WoG//fdyAbj9Y52pjWBRn2XT3LE2+cAfR/20l8n2CwcPafW
 JAe/DQ3wdu9FM+tm4TWPq0jTN6lukGv6AtZTtmkbVSewKEKEIqYXHEIf/MYLiSlcipF932xuSIj
 dx19y9pxTrlSn1CjESeXRYm6At6Vk6v7rCkmv4Y1aThf9Swbsj3odZrj3iLi8DvbfwUv5ez32qg
 /EbT2Xa8FaSqUbMLr1NOCQdCxni6ArtPfTzd1UFndcISy/35NLTDMFXUcKcegta5pR8kWEcnE7a
 M6ssvPmj4F7ucWRXp27xlU9m8cCCOsnmRlHaSM5JTu/BoQQG8BN54oukiFicRC1auO8pQLNMPCp
 lyg8W2Iag71LddHNbeWiElFl820P5f0EphHTNXTvYqCZ9DjBh6lKMrtYAoZmH2lSwmYZojIj5Tw
 GyT6+HeuhAIpretur2cHVwUttF2Y6ghs676+HDrhkjpfGcsWyP8hRZhc9yEXikj16JAo+u5Y9iQ
 BiY/2fxKKpGWL078SPR3PPKKtLG9YGCUjwDEu5lP3KA==
X-Received: by 2002:a05:600c:828e:b0:4a2:526b:d40f with SMTP id
 5b1f17b1804b1-4bb88785898mr442947595e9.0.1795703587785; 
 Thu, 26 Nov 2026 06:33:07 -0800 (PST)
Received: from noys4.dd1.int.kernkonzept.com
 (ip-178-026-066-148.vkd85.pools.vodafone-ip.de. [178.26.66.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm849925415e9.13.2026.11.26.06.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:33:07 -0800 (PST)
From: Frank Mehnert <frank.mehnert@gmail.com>
X-Google-Original-From: Frank Mehnert <frank.mehnert@kernkonzept.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 Frank Mehnert <frank.mehnert@kernkonzept.com>
Subject: [PATCH for-11.2 v2 2/2] tests/tcg/aarch64: test WFE after a failed
 store-exclusive
Date: Thu, 26 Nov 2026 15:32:58 +0100
Message-ID: <20261126143258.1056688-3-frank.mehnert@kernkonzept.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126143258.1056688-1-frank.mehnert@kernkonzept.com>
References: <20261126143258.1056688-1-frank.mehnert@kernkonzept.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=frank.mehnert@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a test case for the common spin lock pattern "WFE, load-exclusive,
store-exclusive, on failure back to WFE", where the lock is released by
a plain store and without SEV.

CPU 0 executes LDAXR on the free lock, then CPU 1 takes the lock with
a plain store. The following STXR of CPU 0 must fail, and the WFE after
it must complete at once because the store of CPU 1 cleared the global
monitor of CPU 0, which generates a WFE wakeup event. The virtual
timer interrupt, 1s out, ends a WFE that misses the event, so the test
fails instead of hanging.

The test starts CPU 1 through PSCI and therefore needs two CPUs.

Signed-off-by: Frank Mehnert <frank.mehnert@kernkonzept.com>
---
 tests/tcg/aarch64/system/meson.build |   2 +-
 tests/tcg/aarch64/system/wfxt.c      | 103 ++++++++++++++++++++++++++-
 2 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index 8710ebfdad..a3cc77c1a0 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -75,7 +75,7 @@ tests += {
   'wfxt.c': {
     'cflags': cflags,
     'qemu_args': ['-M', 'virt,virtualization=on,gic-version=2',
-                  '-cpu', 'max', '-smp', '1',
+                  '-cpu', 'max', '-smp', '2',
                   '-semihosting-config', 'enable=on,arg=2',
                   qemu_base_args]
   },
diff --git a/tests/tcg/aarch64/system/wfxt.c b/tests/tcg/aarch64/system/wfxt.c
index 9d50590a68..2cec6cfbbe 100644
--- a/tests/tcg/aarch64/system/wfxt.c
+++ b/tests/tcg/aarch64/system/wfxt.c
@@ -1,5 +1,5 @@
 /*
- * WFIT/WFET timeout test
+ * WFIT/WFET timeout test, WFE wakeup after a failed store-exclusive
  *
  * Copyright (c) 2026 Google LLC
  * Author: Fuad Tabba <fuad.tabba@linux.dev>
@@ -91,6 +91,106 @@ static int test_one(const char *name, void (*wait)(uint64_t), uint64_t freq)
     return 0;
 }
 
+/*
+ * At EL2 with virtualization enabled, QEMU's PSCI implementation uses the
+ * SMC conduit.
+ */
+#define PSCI_CPU_ON 0xc4000003UL
+
+static uint64_t psci_cpu_on(uint64_t mpidr, uint64_t entry)
+{
+    register uint64_t x0 asm("x0") = PSCI_CPU_ON;
+    register uint64_t x1 asm("x1") = mpidr;
+    register uint64_t x2 asm("x2") = entry;
+    register uint64_t x3 asm("x3") = 0;
+
+    asm volatile("smc #0" : "+r" (x0) : "r" (x1), "r" (x2), "r" (x3)
+                 : "memory");
+    return x0;
+}
+
+static uint32_t lock_word;
+static uint32_t lock_step;
+
+asm(".pushsection .bss\n"
+    ".balign 16\n"
+    "secondary_stack:\n"
+    ".space 4096\n"
+    "secondary_stack_end:\n"
+    ".popsection\n"
+    ".global secondary_entry\n"
+    "secondary_entry:\n"
+    "adrp x0, secondary_stack_end\n"
+    "add x0, x0, :lo12:secondary_stack_end\n"
+    "mov sp, x0\n"
+    "b secondary_main\n");
+
+/* CPU 1 takes the lock while CPU 0 is between LDAXR and STXR. */
+static void __attribute__((used)) secondary_main(void)
+{
+    while (__atomic_load_n(&lock_step, __ATOMIC_ACQUIRE) != 1) {
+    }
+    __atomic_store_n(&lock_word, 1, __ATOMIC_RELAXED);
+    __atomic_store_n(&lock_step, 2, __ATOMIC_RELEASE);
+
+    for (;;) {
+        asm volatile("wfi");
+    }
+}
+
+/*
+ * Spin lock pattern: "LDAXR, STXR, on failure WFE" with a lock released
+ * by a plain store and without SEV. The store-exclusive fails because
+ * another CPU took the lock. That store cleared the global monitor of
+ * this CPU, which generates a WFE wakeup event, so the following WFE
+ * must complete at once.
+ */
+static int test_wfe_lock(uint64_t freq)
+{
+    uint64_t entry, now, elapsed;
+    uint32_t val, status;
+
+    asm("adrp %0, secondary_entry\n"
+        "add %0, %0, :lo12:secondary_entry" : "=r" (entry));
+    if (psci_cpu_on(1, entry) != 0) {
+        ml_printf("FAIL: cannot start CPU 1\n");
+        return 1;
+    }
+
+    /* Clear the event register */
+    asm volatile("sevl; wfe");
+
+    asm volatile("ldaxr %w0, [%1]" : "=r" (val) : "r" (&lock_word)
+                 : "memory");
+    __atomic_store_n(&lock_step, 1, __ATOMIC_RELEASE);
+    while (__atomic_load_n(&lock_step, __ATOMIC_ACQUIRE) != 2) {
+    }
+    asm volatile("stxr %w0, %w2, [%1]" : "=&r" (status)
+                 : "r" (&lock_word), "r" (1) : "memory");
+
+    if (val != 0 || status == 0) {
+        ml_printf("FAIL: store-exclusive succeeded on a taken lock\n");
+        return 1;
+    }
+
+    /* The virtual timer interrupt, 1s out, wakes the CPU if WFE sleeps */
+    now = read_sysreg(cntvct_el0);
+    write_sysreg(cntv_cval_el0, now + freq);
+    write_sysreg(cntv_ctl_el0, 1);
+
+    asm volatile("wfe");
+
+    elapsed = read_sysreg(cntvct_el0) - now;
+    write_sysreg(cntv_ctl_el0, 0);
+
+    ml_printf("wfe after failed stxr: woke after %ld ticks\n", elapsed);
+    if (elapsed > freq / 2) {
+        ml_printf("FAIL: wfe missed the event of the failed stxr\n");
+        return 1;
+    }
+    return 0;
+}
+
 int main(void)
 {
     uint64_t freq;
@@ -113,6 +213,7 @@ int main(void)
 
     ret = test_one("wfit", wfit, freq);
     ret |= test_one("wfet", wfet, freq);
+    ret |= test_wfe_lock(freq);
 
     return ret;
 }
-- 
2.55.0


