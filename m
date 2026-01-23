Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D67D74EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIob-0008Qj-97; Fri, 23 Jan 2026 10:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInP-00077M-UV
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:05 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInM-00035d-Mq
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:59 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4359a16a400so2160824f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180995; x=1769785795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B4a7e8a1Ek2vHXva6lSoEeVRPpCC/Zyr9kF8XLCIMcc=;
 b=D4GkSk9IHsXhGU5XdVh6Rz8dmbM3eCGz7+Zpi/BOVerSGYDJkJJrqfMYQmsycrKy60
 G2XPHNHM8h2Zqft4Pjz7xQQKPlF6D43AD34yCTNgRBg+7U3u1QUPvtjL9ob207LfFfw0
 AOFIEj3CeKMMCEcHj6v4H1c6TSgZGAP/swsooy3OOaTwHEen/6z7Jc83UIwWZC28Mhfw
 pexOpAvHk85omTf4PGQk8wdclXKqiHJhxMJNoJrMM9ormFKKBWAbbKCGK5XK2ro/SOzC
 5ldIt9LUQjBIPFTRgc8DXjOSD/3ZdLC+oMT23yV5Xexmrnk4UDuziy9OuCMxS4w5dSKW
 DB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180995; x=1769785795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B4a7e8a1Ek2vHXva6lSoEeVRPpCC/Zyr9kF8XLCIMcc=;
 b=bBZRof/Oufx0qK6ioCi6Z6uH0qfK6ebRSlTGxdTmnN0nFIMtTum0bqz7wDZvvf2bnr
 HrQ0qQb5Dn4cG+BaQBHuRmr17Vv/rFV8Y2OQ1BHYNRbIU05/9SQ700hsWgzA8KndpKbn
 yqMsYjT5EppVRKHzu3SVqgnokjJyI0AwgxZP6Vk8L3b+2DADiyA0fOg3sxSn+yQmXCCf
 DZ2ypM4ngA6FAJyLhma7L9XE9c3sfuyI5J9TuJmBErTP2XGmp+GlruWBeta4VJ5epZhS
 amUdJ+rMLOIV4dGhMb1g3TWP7R9Y0PYy2/uk5FgDKucMKK7g5LqleiwjTZ9by9nY2TVK
 +Vgg==
X-Gm-Message-State: AOJu0YynoKcSqVZwWNtRtfKUPk+TSDRxrjkQ2MyhpBFOyDUafsYmeMGK
 HYWgdreVk0BkA89Dx135e21mq5qz42IUv6tdZ2wfGCz/3HTEzvfQyWkitvw5aMSbdJPtXbBBO0g
 wcFgE1QY=
X-Gm-Gg: AZuq6aKhMV2MSELEoGy+eiYA6TeztMnGPP8c4XsGhxh7dNrE7cqHkA2/zSxq51BT1hB
 H96L65WV/uVfnwlesNXitYAsPVkr9JEwkJ1jnf+yu+qBOpisVOIGyyDxWOmTCbdNKYeygekaZY/
 hQX80l7FQfpy8qOUKTbCkHu6NgfxPybEYcRRI0jR947krcsyYSwANhdmAV01PNZrTD8/k7sDR89
 JSHeRojlYITaOpBXvBRxd5SngMxE38k85+V0oXtWkVnwjl/rSIehTZ5l7ujbJbQI85X6mxAdE1A
 Q7jd1utwPz71dAujZH15VZ5UOar/zH1r2nZwjCgngSQOAFmsGQzjq3K4pyfGHPpnf/C3CYAztCn
 bT7Oi1L0oE1pBbjrcrUgK2zC7to8QAIpu9tMM/hTbEUf3165qs0y/tLb7glmHa1oQAJtP+oudST
 cHW/hGmRf4k7VLFweZU6XgDkcDn113R1o8zWv84D20HiZrL688410m
X-Received: by 2002:a05:6000:184f:b0:435:a287:82c with SMTP id
 ffacd0b85a97d-435b1589573mr5616219f8f.1.1769180994882; 
 Fri, 23 Jan 2026 07:09:54 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/22] misc: Clean up includes
Date: Fri, 23 Jan 2026 15:09:31 +0000
Message-ID: <20260123150941.1877768-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260116125830.926296-4-peter.maydell@linaro.org
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


