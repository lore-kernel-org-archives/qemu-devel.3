Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B2EC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 18:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMtTl-0001B5-Oq; Thu, 27 Jun 2024 14:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMtTf-0001AB-9f
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 14:04:12 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMtTP-0001MF-Tr
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 14:04:10 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7eb5dd9f994so292552139f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 11:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719511434; x=1720116234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0iy7OmdnIv4vhHrmSzHh4pajG0G9qYEbVVtDoAkstk=;
 b=ZaugFMYcZ7claEq9OHpyKX+bjT48BmPQLLfq0DN8n3zBtGzw9dOQGLbJN3S+8a5G2k
 auBHqLBPgl983D/zaSh7+En+D1NddLtmz/8fWTcb0aZhXSLKV3rPb4FDavZSo2JULwmT
 dK/0Niv53hWues1fFLDXyq8e1sPV0A4r6z/ZOZ4JF8u8DWGX/virs1m+H9uv6LbDwDjA
 TRyHbweLoAYuDNkER3tmsZTCfeXX9BPT7c/08MVFZcfKPXTUJ2XO5Wy91LeUm4WHLzoz
 Cc6yWy61s+0R9bG35HbULfdv1vshB2MZyrrnAccbHGI4EyNjVZlYv2QSLGte80sBBXf6
 tUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719511434; x=1720116234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S0iy7OmdnIv4vhHrmSzHh4pajG0G9qYEbVVtDoAkstk=;
 b=ZgdNsfOjDC6IjE8gyfJGWz2DRwv3eif0mvbU9Hc4WofivH/xe29S4CZ1Vvm8bs1ErA
 TAwrk76zbIp9rlCqDIaAOmNtw3CVXtkIBH5YkewNA7MbSFFns+GiQG3UZBEATbuvd1db
 tThh/Juu4g9YlJ9C83JKvmz6W3V56+rXsOvd9zXfCBbhNQJbjhIeZu0BGwQVjsWypCRE
 esu6agCouvMsFql3vnY6q7hGTLYfSYmOXUYAlHiZKy8AhGQv0VU13kxTXwHnTrGGL++T
 sicHSUoHLsNeAOSGrEqrqBUgdOF/IDz4XCJVQ1x4lBhRXXgvZwJujJACTa4DKZ9v8Yin
 z6lw==
X-Gm-Message-State: AOJu0YyoDf+Lx6ARjhB5IhWlFstme8tYn3LzrudYrLBOjxkfOYEvS7Zs
 CX09/dRI0+c8p8eIj/IdyOp5JfUCKl0fjBcU6C2gwQ2Pr1Lj7mYY/n1kxOvjPkneVWuqPILP180
 S
X-Google-Smtp-Source: AGHT+IGbIDolrQN49fa5zQh9Z+vDvESl7Nr5+6iTsVqxbdzA59oot616d/eEA+1D9pZUI8qHSo83nA==
X-Received: by 2002:a05:6602:3f8a:b0:7f1:3ad1:2341 with SMTP id
 ca18e2360f4ac-7f3a13db517mr1966042139f.7.1719511434499; 
 Thu, 27 Jun 2024 11:03:54 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70803ecf764sm2170b3a.106.2024.06.27.11.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 11:03:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: brad@comstyle.com, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 qemu-riscv@nongnu.org
Subject: [PATCH 3/3] util/cpuinfo-riscv: Use linux __riscv_hwprobe syscall
Date: Thu, 27 Jun 2024 11:03:50 -0700
Message-Id: <20240627180350.128575-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627180350.128575-1-richard.henderson@linaro.org>
References: <20240627180350.128575-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

With recent linux kernels, there is a syscall to probe for various
ISA extensions.  These bits were phased in over several kernel
releases, so we still require checks for symbol availability.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build          |  6 ++++++
 util/cpuinfo-riscv.c | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/meson.build b/meson.build
index 97e00d6f59..58afd0125d 100644
--- a/meson.build
+++ b/meson.build
@@ -2837,6 +2837,12 @@ have_cpuid_h = cc.links('''
   }''')
 config_host_data.set('CONFIG_CPUID_H', have_cpuid_h)
 
+# Don't bother to advertise asm/hwprobe.h for old versions that do
+# not contain RISCV_HWPROBE_EXT_ZBA.
+config_host_data.set('CONFIG_ASM_HWPROBE_H',
+                     cc.has_header_symbol('asm/hwprobe.h',
+                                          'RISCV_HWPROBE_EXT_ZBA'))
+
 config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
   .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX2') \
   .require(cc.links('''
diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
index abf799794f..cf59ce83a3 100644
--- a/util/cpuinfo-riscv.c
+++ b/util/cpuinfo-riscv.c
@@ -6,6 +6,11 @@
 #include "qemu/osdep.h"
 #include "host/cpuinfo.h"
 
+#ifdef CONFIG_ASM_HWPROBE_H
+#include <asm/hwprobe.h>
+#include <sys/syscall.h>
+#endif
+
 unsigned cpuinfo;
 static volatile sig_atomic_t got_sigill;
 
@@ -47,6 +52,27 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 #endif
     left &= ~info;
 
+#ifdef CONFIG_ASM_HWPROBE_H
+    if (left) {
+        /*
+         * TODO: glibc 2.40 will introduce <sys/hwprobe.h>, which
+         * provides __riscv_hwprobe and __riscv_hwprobe_one,
+         * which is a slightly cleaner interface.
+         */
+        struct riscv_hwprobe pair = { .key = RISCV_HWPROBE_KEY_IMA_EXT_0 };
+        if (syscall(__NR_riscv_hwprobe, &pair, 1, 0, NULL, 0) == 0
+            && pair.key >= 0) {
+            info |= pair.value & RISCV_HWPROBE_EXT_ZBA ? CPUINFO_ZBA : 0;
+            info |= pair.value & RISCV_HWPROBE_EXT_ZBB ? CPUINFO_ZBB : 0;
+            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB);
+#ifdef RISCV_HWPROBE_EXT_ZICOND
+            info |= pair.value & RISCV_HWPROBE_EXT_ZICOND ? CPUINFO_ZICOND : 0;
+            left &= ~CPUINFO_ZICOND;
+#endif
+        }
+    }
+#endif /* CONFIG_ASM_HWPROBE_H */
+
     if (left) {
         struct sigaction sa_old, sa_new;
 
-- 
2.34.1


