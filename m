Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E503C3271F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 17:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP40G-0003Kx-Rf; Wed, 03 Jul 2024 13:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP40A-0003Iz-IM
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:42:42 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP404-0005Lg-Ue
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:42:39 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c983d8bdc7so496366a91.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720028554; x=1720633354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7R7OJJiu7/4ltitIhcOKEZN8yuDpc4Bx0+hw02RzbL8=;
 b=gpC6xX1tTOi4L1sgLfED/zN96kolyJ6bY67FuzYRZPbhDC8tsDTQH9mOnemaJ0oDSY
 nX/1Zh00YB6BD7o+FK6qkiagA+QJC59x4CVMjjbFC/k/jtSUtsYOkOzFt+mYwCDuMAZi
 L6ULgRMGAMqdod8TGD1dzyHjcOVhYBbXfRjVPw+kdgTK0UTlgiCen+mi5giGzZNILApm
 yq/BdaYQmCJNPF0bah4ss/RM4YbKz8oWauNLaNH8eFgdqz/+kpQ1+MKGMam78c+sjnBE
 aUmMPy9R6kXaRKohlCqG8RvVb4IbotyHn0nZxRp1xEZgp3HzEEqXMvlXRsm1GOg7D3UE
 qNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720028554; x=1720633354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7R7OJJiu7/4ltitIhcOKEZN8yuDpc4Bx0+hw02RzbL8=;
 b=Flmu8GRMcGDPGcE7eLxPjf4hW7lyxMCfdwGpyOJapfve2cEZfUKiiP89wfV2n0SDNT
 MzsJqoenRzrf/qIPh+HgDHi6GJRVVCvyerIdB5ouah4pcOqqBHq0TGwXNB7ev7Pnd7OC
 goJL0p3gVBTzQmB7QZV5K8cKLmIDz0Fq6mZtoTLnwg0pjF2yAhX3fdoWDZ0az/ldrFgz
 w69XZjhVIbQO0wGl8DXY2ueJI/wQlGhRI9jja3VYSvcZFpwv0djoNEDXmBRkHrZG2f+G
 cOjoqRLSPklVEKitCtDcTMwREOc2rIMnc2OFZVmFFcCDswTj0kqrwC+tXU8m073nRqCi
 TXeA==
X-Gm-Message-State: AOJu0YzvGxI8JbcaERcXg634qbs//qi2HR7ahiuBniPSH4zbC94haWHh
 5NdNzDzYOuwktnY2NyEF0r4drXEak4awww5WgbmCZw4kAN/LgQhbn/UmK+m5kmC9zPvTJa/ll0g
 J
X-Google-Smtp-Source: AGHT+IH4O6Ox6Tjv9UwQa7S+1l4zWKCK3ZDUE2Ur1X7Pu6I3DBqk5WhyLZTkgMnFePao8lQF4WfpFQ==
X-Received: by 2002:a17:90a:9204:b0:2c9:6d07:18f4 with SMTP id
 98e67ed59e1d1-2c96d071921mr3089793a91.35.1720028553579; 
 Wed, 03 Jul 2024 10:42:33 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7d7bsm11070030a91.47.2024.07.03.10.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 10:42:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 6/7] util/cpuinfo-riscv: Use linux __riscv_hwprobe syscall
Date: Wed,  3 Jul 2024 10:42:25 -0700
Message-Id: <20240703174226.2117169-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703174226.2117169-1-richard.henderson@linaro.org>
References: <20240703174226.2117169-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

With recent linux kernels, there is a syscall to probe for various
ISA extensions.  These bits were phased in over several kernel
releases, so we still require checks for symbol availability.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build          |  6 ++++++
 util/cpuinfo-riscv.c | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/meson.build b/meson.build
index 54e6b09f4f..2f981f936e 100644
--- a/meson.build
+++ b/meson.build
@@ -2862,6 +2862,12 @@ have_cpuid_h = cc.links('''
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
index 7dcfbee2ab..497ce12680 100644
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


