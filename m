Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6BFC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHJ-0002NE-Pr; Fri, 26 Jan 2024 09:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHH-0002K6-9L
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:55 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHE-0007wO-1n
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:55 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33ade380b9fso569673f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279630; x=1706884430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gl5mdL8o4tkULNtVB7E10+lX7Lfh3f3aHXrBpGvFwCw=;
 b=l2qwh0WBfH1JVfdtAgS3H8IvDTYxbqBXhwxQTZhL1EGY3JHnYq0CzGNH3O/xq6lV8h
 L5UDeQc9psbER8/uK2yxms8xzU50oqOa1utlvOuiBxZ9SU1aw/mflvTO5WfdBSN58LXr
 NyhiQ2vJ16e7uc+vvQCHWSU8BzZIz76nCHKubreRpopNoqC12YNvbzNhg028Qe2N5RWs
 IRETHdHAJthE8yUTlYF+FpXz9ClC9kLXBpcbjokpzF/EuIvf2J/FpyoXj8OJH5tPozhp
 kNmDpOjVQyVB5r2c/+bdbzpUfM1Hi5VOcptOAhsSttOsZD7xdgEy/XzE7eKY2c+02Iqs
 fUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279630; x=1706884430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gl5mdL8o4tkULNtVB7E10+lX7Lfh3f3aHXrBpGvFwCw=;
 b=itMiomyeHM9kfKqkde5nHgcG7x8uMc1N4PIT5A0YV9BehfWWkTVpYxPjjbEaNYXueW
 lRrDszUphC7oHQbOdYV4Vz6B78Fh3C+F6hUnueRYEZ6BgRk6r1KN2foPtoZOcLE+k2aO
 h6Kmf+DMfBsOMLLrZHCc+LV+affJCIQJZVr+4rE9jJU4HPTpQogIuW+gvggsvLN9yTdx
 BBcsPx17M4Bb9O7Vyv/59QHWxZFY4iw+JdvjZUBn/WGHujGgTXaWtpKEfxDg3XlejVND
 KqfPGZ1AKXOsez+p2VhA5Qjiq31e7shd1TqOS7gV5cBjA/mjlDd+U93y2Pao5OVET4+O
 6Piw==
X-Gm-Message-State: AOJu0Yy3MA5x2MaK5T2fi9nblIiWBVmKRU1uZn0E7efGqTFOt8+qX0OM
 B73rUU8e3Mw05jkc6h08zWW8eiSS8FPAsfDb2Or2yJCogVLWkYhMP9mzntCuKMSw0O094syugOF
 W
X-Google-Smtp-Source: AGHT+IHFOH8mAEtP2w4qdoPCzIcRF+mw7DSaZ9w2IKxVNs+hBYdzxSgMfELwBgP0ZZLMoBMqsf0R7Q==
X-Received: by 2002:adf:ee8a:0:b0:337:b74b:492c with SMTP id
 b10-20020adfee8a000000b00337b74b492cmr486377wro.234.1706279630638; 
 Fri, 26 Jan 2024 06:33:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/36] target/arm: Expose arm_cpu_mp_affinity() in
 'multiprocessing.h' header
Date: Fri, 26 Jan 2024 14:33:24 +0000
Message-Id: <20240126143341.2101237-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Declare arm_cpu_mp_affinity() prototype in the new
 "target/arm/multiprocessing.h" header so units in
hw/arm/ can use it without having to include the huge
target-specific "cpu.h".

File list to include the new header generated using:

  $ git grep -lw arm_cpu_mp_affinity

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-11-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  6 +-----
 target/arm/multiprocessing.h | 16 ++++++++++++++++
 hw/arm/virt-acpi-build.c     |  1 +
 hw/arm/virt.c                |  1 +
 hw/arm/xlnx-versal-virt.c    |  1 +
 hw/misc/xlnx-versal-crl.c    |  1 +
 target/arm/arm-powerctl.c    |  1 +
 target/arm/cpu.c             |  5 +++++
 target/arm/hvf/hvf.c         |  1 +
 target/arm/tcg/psci.c        |  1 +
 10 files changed, 29 insertions(+), 5 deletions(-)
 create mode 100644 target/arm/multiprocessing.h

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d1584bdb3b5..cecac4c0a12 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -26,6 +26,7 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #include "qapi/qapi-types-common.h"
+#include "target/arm/multiprocessing.h"
 
 /* ARM processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
@@ -1173,11 +1174,6 @@ void arm_cpu_post_init(Object *obj);
 
 uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz);
 
-static inline uint64_t arm_cpu_mp_affinity(ARMCPU *cpu)
-{
-    return cpu->mp_affinity;
-}
-
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_arm_cpu;
 
diff --git a/target/arm/multiprocessing.h b/target/arm/multiprocessing.h
new file mode 100644
index 00000000000..81715d345c2
--- /dev/null
+++ b/target/arm/multiprocessing.h
@@ -0,0 +1,16 @@
+/*
+ * ARM multiprocessor CPU helpers
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef TARGET_ARM_MULTIPROCESSING_H
+#define TARGET_ARM_MULTIPROCESSING_H
+
+#include "target/arm/cpu-qom.h"
+
+uint64_t arm_cpu_mp_affinity(ARMCPU *cpu);
+
+#endif
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 2127778c1ea..43ccc60f43c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -59,6 +59,7 @@
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/viot.h"
 #include "hw/virtio/virtio-acpi.h"
+#include "target/arm/multiprocessing.h"
 
 #define ARM_SPI_BASE 32
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b3592798ea9..1e0df6ea3ad 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -74,6 +74,7 @@
 #include "hw/arm/smmuv3.h"
 #include "hw/acpi/acpi.h"
 #include "target/arm/internals.h"
+#include "target/arm/multiprocessing.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/generic_event_device.h"
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 841ef69df66..29f4d2c2dce 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -20,6 +20,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/xlnx-versal.h"
 #include "hw/arm/boot.h"
+#include "target/arm/multiprocessing.h"
 #include "qom/object.h"
 
 #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("xlnx-versal-virt")
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 9bfa9baa157..1f1762ef163 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -19,6 +19,7 @@
 #include "hw/resettable.h"
 
 #include "target/arm/arm-powerctl.h"
+#include "target/arm/multiprocessing.h"
 #include "hw/misc/xlnx-versal-crl.h"
 
 #ifndef XLNX_VERSAL_CRL_ERR_DEBUG
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 6c86e901028..2b2055c6acc 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -16,6 +16,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "sysemu/tcg.h"
+#include "target/arm/multiprocessing.h"
 
 #ifndef DEBUG_ARM_POWERCTL
 #define DEBUG_ARM_POWERCTL 0
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5b5af7d4e1e..04296f2928f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1314,6 +1314,11 @@ uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz)
     return (Aff1 << ARM_AFF1_SHIFT) | Aff0;
 }
 
+uint64_t arm_cpu_mp_affinity(ARMCPU *cpu)
+{
+    return cpu->mp_affinity;
+}
+
 static void arm_cpu_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 659401e12c7..71a26db1886 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -28,6 +28,7 @@
 #include "arm-powerctl.h"
 #include "target/arm/cpu.h"
 #include "target/arm/internals.h"
+#include "target/arm/multiprocessing.h"
 #include "trace/trace-target_arm_hvf.h"
 #include "migration/vmstate.h"
 
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index 50d4b23d26b..51d2ca3d30d 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -24,6 +24,7 @@
 #include "sysemu/runstate.h"
 #include "internals.h"
 #include "arm-powerctl.h"
+#include "target/arm/multiprocessing.h"
 
 bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
 {
-- 
2.34.1


