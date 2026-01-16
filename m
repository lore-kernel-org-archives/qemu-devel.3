Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50B3D4899E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 12:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgjPn-0003ie-O6; Fri, 16 Jan 2026 07:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgjPU-0003fS-7I
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:58:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgjPR-0000A4-AZ
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:58:39 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so10315935e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 04:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768568316; x=1769173116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPhwWhZ7coRvcHGO4gjyXrn9e//3gG9lVCn8wwawJZQ=;
 b=PJMnAsBG3F6tQQNQzE9Ml6dIpm2r6yVZdTcvDJ9KcZa1SmEr2xr0reGpbFb7hF91+0
 JQ6/DfvdI+LGdFiq5oG+r3eScSLp81ZUTnZGffbY8WqtWGwzQpGdK0hbY4sRHpCmPEAg
 eVW02LcyF2BSbaiytNveFk1J86YAPhNdnFupfxCPBr74weDEXciXs9eFIRHtqtYjg6Kh
 Or1qPRFItOqFnu6VI+dAENf5HRBnu9GOJ4K4V6l3r3tS/RjeELxlZNrIRF6jIAsZn1Qj
 2v2ckGcS4VGK9Qg8ID9hcOYNyl5V4fNPt5vMD0C4QX17cBoQ+NatOZK8FUKwMRzNK1eO
 hAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768568316; x=1769173116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BPhwWhZ7coRvcHGO4gjyXrn9e//3gG9lVCn8wwawJZQ=;
 b=dyeRRjN87b8hx5D10I8ephRcG+kCx97g9x90Y7SLsOEVjxbbwt3HKKEuss9VXnicqW
 IZQa77Wly1bRJlMyDaInlgIsmahmSNbyku/yno9Olc67Leos4kQMwUjPzGodedUgK+Ui
 4yAL5g8SJvnXaGF8khjI1oOwwJYpLh4R9v6Kze2nQXU/hNHbaXRXYtq4pUYzSn7oJplO
 Qirt2cFItRfBFBI4Z7f08/c8IaeJ/M+2B/HKPglPDD/nBE8Ymq/Xn1jkgYgdu5F74JOW
 Q9LgwqEpMeVbQKOUBvzL6GFHvps1tU1GsjXeI1dVHO7zCteuvhplsGAUNzdR1lHk2xVC
 C5KA==
X-Gm-Message-State: AOJu0YwDzRSXhOFUxrD/3mQiZJWPDetEF5ofUmNO2g2Gs804R1B4+H+B
 hSiMqrbEfEPwYP3RKCetFLPHc9TfelxNuXTqSCSaA4PgNdpE8wbEWts5FZQC6zxT16nS0M5Cbsv
 L6THR
X-Gm-Gg: AY/fxX53dickmCN/QorANMRpCQRSga70wbgEUeeJagfjuIZhBRb0ZAYC48B2mUnKoFm
 +UAdo6zKtp2GVBmKEKPbZb64Cw4375V2OvUC7TaaXa1505jRYD7291X8z7EjvDxYdVCUUXuTMFC
 0FHKQMryK8spfeJx0R4YJNJSoNdH3egWiYAQTo7wWiQdULWkqjH95N/vPBGWnE+MBABxCwBzdQ5
 v9uepguuFW/BKCdbUMkmK1tujLhdhtTpgc/A8FyaSxRZ8qmi/sw3omiidINhjPBmJ5nazROuZRS
 KchQEfEVThZc4Bcv8t5FkvdVGoQc6aNwMnC0ROaJAfFuU14DUAfblrX+1Ru56NfBekf6yYRM/Bo
 ycOEYDCed5UvmTKP7hzFr3Ebu2I2nb8lqRdZB80FjaBXXVNfIGsF5MdV93j5bM76yeG8gtuuTMZ
 HIM3fEgXe3V6G83c/OJh92UPbLlQkaEj3MnhQMhJjksM7PkwRQ9Dn1OhAe1BdvdSnnBfzM9rCPs
 qSttVaWVQyjuDH3uNeeKjc4L1Av05AQA2AG/PPvOmUeEA==
X-Received: by 2002:a05:600c:820e:b0:477:6d96:b3c8 with SMTP id
 5b1f17b1804b1-480259d35d7mr2472925e9.23.1768568315685; 
 Fri, 16 Jan 2026 04:58:35 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe67780sm15387565e9.16.2026.01.16.04.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 04:58:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 3/4] misc: Clean up includes
Date: Fri, 16 Jan 2026 12:58:29 +0000
Message-ID: <20260116125830.926296-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116125830.926296-1-peter.maydell@linaro.org>
References: <20260116125830.926296-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This commit deals with various .c files that included system
headers that are already pulled in by osdep.h, where the .c
file includes osdep.h already itself.

This commit was created with scripts/clean-includes:
 ./scripts/clean-includes '--git' 'misc' 'hw/core' 'semihosting' 'target/arm' 'target/i386/kvm/kvm.c' 'target/loongarch' 'target/riscv' 'tools' 'util'

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/machine-qmp-cmds.c         | 1 -
 semihosting/arm-compat-semi-stub.c | 1 -
 target/arm/cpu32-stubs.c           | 1 -
 target/i386/kvm/kvm.c              | 1 -
 target/loongarch/csr.c             | 1 -
 target/riscv/csr.c                 | 1 -
 tools/i386/qemu-vmsr-helper.c      | 1 -
 util/cpuinfo-aarch64.c             | 1 -
 8 files changed, 8 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 79cbcdd63e..e62cb4ec88 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -30,7 +30,6 @@
 #include "system/runstate.h"
 #include "system/system.h"
 #include "hw/s390x/storage-keys.h"
-#include <sys/stat.h>
 
 /*
  * QMP query for enabled and present accelerators
diff --git a/semihosting/arm-compat-semi-stub.c b/semihosting/arm-compat-semi-stub.c
index bfa3681e26..40199c9842 100644
--- a/semihosting/arm-compat-semi-stub.c
+++ b/semihosting/arm-compat-semi-stub.c
@@ -6,7 +6,6 @@
 
 #include "qemu/osdep.h"
 #include "semihosting/semihost.h"
-#include <glib.h>
 
 bool semihosting_arm_compatible(void)
 {
diff --git a/target/arm/cpu32-stubs.c b/target/arm/cpu32-stubs.c
index f0ce159572..9e50bb1b0b 100644
--- a/target/arm/cpu32-stubs.c
+++ b/target/arm/cpu32-stubs.c
@@ -3,7 +3,6 @@
 #include "qemu/osdep.h"
 #include "target/arm/cpu.h"
 #include "target/arm/internals.h"
-#include <glib.h>
 
 void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
 {
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7b9b740a8e..0c940d4b64 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -21,7 +21,6 @@
 #include <sys/utsname.h>
 #include <sys/syscall.h>
 #include <sys/resource.h>
-#include <sys/time.h>
 
 #include <linux/kvm.h>
 #include <linux/kvm_para.h>
diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index 332a1396cc..fff2312f87 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (c) 2025 Loongson Technology Corporation Limited
  */
-#include <stddef.h>
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "csr.h"
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 05c7ec8352..5064483917 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -31,7 +31,6 @@
 #include "qapi/error.h"
 #include "tcg/insn-start-words.h"
 #include "internals.h"
-#include <stdbool.h>
 
 /* CSR function table public API */
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
index 6c0f4fe870..f12fd3c3e8 100644
--- a/tools/i386/qemu-vmsr-helper.c
+++ b/tools/i386/qemu-vmsr-helper.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include <getopt.h>
-#include <stdbool.h>
 #include <sys/ioctl.h>
 #ifdef CONFIG_LIBCAP_NG
 #include <cap-ng.h>
diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index 57468890c3..288074c08f 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -26,7 +26,6 @@
 #if defined(__OpenBSD__) && !defined(CONFIG_ELF_AUX_INFO)
 # include <machine/armreg.h>
 # include <machine/cpu.h>
-# include <sys/types.h>
 # include <sys/sysctl.h>
 #endif
 
-- 
2.47.3


