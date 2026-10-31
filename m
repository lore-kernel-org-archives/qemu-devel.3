Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92FC606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JDfxgXce
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNAWv-00012G-BR; Sat, 31 Oct 2026 10:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xNAR9-0008OI-Ri
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 10:52:05 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xNAR7-0006Yl-0C
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 10:52:03 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-36a18fc7a38so1640654eec.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793458319; x=1794063119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y9OcbmBQT6++Wgt2GiPCy82GPlfqJY+SVl7s/7VpF78=;
 b=JDfxgXceiJzKwS73RKGpG9GK67PRkGq7lr6SwbkpvQ/Dzdi7iVuziQBngS0TJ6Y/TR
 xVxP4Z0GyU2YWXpWcIJB02C1QiDzRSsc8LOicqCMVI6NmKNyfNqiMgYeXaSE2xoIY8i1
 LbcZ9rxYdcPzOJYbFukMQcZ5/H552GJ4RVK3KhV+MUlrUVS3Ng7loZP95ZPUQOE51lmb
 1Io3iBeRdQPcwwHfGIGG2C9nVgjhUzIoUEikBDcSwwzeH+WX2413NI7bfO5CXZee/ywq
 0rejewAu1I64TT+96DG/c53e+FH8BNwBXqtziBkPWiFVxBML6e+U8yFiIwnBg9x0vHR7
 oTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793458319; x=1794063119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y9OcbmBQT6++Wgt2GiPCy82GPlfqJY+SVl7s/7VpF78=;
 b=b5/PoBmfrZYnUZqC66w2fJNsnlVitBmLjFpUCsuY2ybDf3TrIywK2+8MtVABFLqVOO
 Yqhz277712vJjZ1j1rWQw8ZHNNAmJ0zw8v1b6dch3ubXKUti9XjmVrBzR7jUSbGmJBJH
 8GFyIXJYuPca/JmVG0jquZInZ2e+DRDdU7lMJ9uI9eTC2WfvSATlxFAXEcn+j2IaBZ8h
 xVUJ7TkVHdp2VcHAmYTY3nItkr9eC6zjEQZBEHmfJdXABWpe3vkr0eXiOC1e/uFb42Bb
 52ImFqVGooVWxUS3RwKRW4dtf0d+Qqc13vWLnKfBlidrSZcwdUapSQwOKq31aHFdK7V3
 g3Xw==
X-Gm-Message-State: AFq9FYLLCHTje98eYycOjt8XCtYi0STA3ggqCeuw/VwqllZWDHsiZ3mt
 3ahdlnYxpxXHpRbXtRnKZ/9XIoRgeXxTZXaHY07vXpwlzQPQVDfHi83touROHEz/
X-Gm-Gg: AYBFou1B0scaf/BP5cVYZUPZEYkz/3s/UurRM2VFltL6IDUOqhyxfTAWkMuXSA5SZFp
 AQvvtzyz6EaQCpVhZW5HVIKPMmfGKhUnVu/8Vl6FV3Rgj8K8lmjOBKSKje+XOEQUSxCpjvZHP6I
 jLW0ZbotgOm1GdLi/jiiC6nNI7XnHN6Kccv8TxOaDZuMU40JPOMzEoRsNFVbYSuHLBX4tmcphdo
 0ZVT89jWMQ6JTLPRCpHaC1MGt5hF3mDRIBtSbGEsTwrTYs29SJxUF3Mxnix/CC6TCU2HczxCo7k
 RBwGGlVW0s7Ac4B5pT+qtgXI+f9TjNQU4JgPbDeGXNUIRDNwUlPv+SgtgqsEL1i/ekvaaxg4cBm
 B6wQLSv1EUzUpVCaoYyH46BjMTNl3qWLjTdKvrO1I6thfkyeE+nfKzFhFB6Wq5FBLGbfHD6cdqt
 xrq9hyxzNdbsHjm55a14jG3ebs5VXzH2zc6gzTFFlbzTFTXmMhYRa8aZfo82Ar/ttSrpqP083Gy
 gDi4qPj6KSCFlyteqJJfmsAbpKD9ICpSPUi5Ty0suRTb60W03qqE0EBDr4MLYMg00n8ux8BOYic
 C6PKnrNKi2OtcwiCIC+bYqG+VkVQ5q6B
X-Received: by 2002:a05:7300:6ca2:b0:366:fabf:6273 with SMTP id
 5a478bee46e88-36a423e35famr11757472eec.22.1793458319364; 
 Sat, 31 Oct 2026 07:51:59 -0700 (PDT)
Received: from ubuntu.lan ([2405:4802:913e:86f0:fc32:76b2:b6d6:a3f6])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428c17bdsm17541006eec.6.2026.10.31.07.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 07:51:59 -0700 (PDT)
From: Khai Do <dovankhai97@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 strahinja.p.jankovic@gmail.com, Khai Do <dovankhai97@gmail.com>
Subject: [PATCH 2/5] hw/arm/orangepi-zero2w: Add Orange Pi Zero 2W machine
Date: Sat, 31 Oct 2026 21:51:44 +0700
Message-ID: <20261031145147.32683-3-dovankhai97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031145147.32683-1-dovankhai97@gmail.com>
References: <20261031145147.32683-1-dovankhai97@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=dovankhai97@gmail.com; helo=mail-dy1-x1329.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 31 Oct 2026 10:57:53 -0400
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Orange Pi Zero 2W is a single-board computer powered by the
Allwinner H618 SoC. This commit adds machine emulation with:
- Allwinner H618 SoC instance
- 1 GiB default system SDRAM at 0x40000000
- Kernel and firmware loading via arm_load_kernel

Signed-off-by: Khai Do <dovankhai97@gmail.com>
---
 MAINTAINERS              |  1 +
 hw/arm/meson.build       |  2 +-
 hw/arm/orangepi-zero2w.c | 77 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/orangepi-zero2w.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f1c31d60..d5f60db054 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -785,6 +785,7 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/allwinner-h618*
 F: include/hw/*/allwinner-h618*
+F: hw/arm/orangepi-zero2w.c
 
 ARM PrimeCell and CMSDK devices
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 42ed065b17..947ee2c7b4 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -24,7 +24,7 @@ arm_common_ss.add(when: 'CONFIG_OMAP', if_true: files('omap1.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubieboard.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
-arm_common_ss.add(when: 'CONFIG_ALLWINNER_H618', if_true: files('allwinner-h618.c'))
+arm_common_ss.add(when: 'CONFIG_ALLWINNER_H618', if_true: files('allwinner-h618.c', 'orangepi-zero2w.c'))
 arm_common_ss.add(when: 'CONFIG_MAX78000_SOC', if_true: files('max78000_soc.c'))
 arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2836.c',
diff --git a/hw/arm/orangepi-zero2w.c b/hw/arm/orangepi-zero2w.c
new file mode 100644
index 0000000000..fe87a98efc
--- /dev/null
+++ b/hw/arm/orangepi-zero2w.c
@@ -0,0 +1,77 @@
+/*
+ * Orange Pi Zero 2W machine emulation
+ *
+ * Copyright (C) 2026 Khai Do <dovankhai97@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "system/address-spaces.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/core/boards.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/arm/allwinner-h618.h"
+#include "hw/arm/boot.h"
+
+#define TYPE_ORANGEPI_ZERO2W_MACHINE MACHINE_TYPE_NAME("orangepi-zero2w")
+OBJECT_DECLARE_SIMPLE_TYPE(OrangePiZero2WMachineState, ORANGEPI_ZERO2W_MACHINE)
+
+struct OrangePiZero2WMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+};
+
+static void orangepi_zero2w_init(MachineState *machine)
+{
+    OrangePiZero2WMachineState *opms = ORANGEPI_ZERO2W_MACHINE(machine);
+    AwH618State *h618;
+
+    /* BIOS is not supported by this board */
+    if (machine->firmware) {
+        error_report("BIOS not supported for this machine");
+        exit(1);
+    }
+
+    h618 = AW_H618(object_new(TYPE_AW_H618));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(h618));
+    object_unref(OBJECT(h618));
+
+    /* Mark H618 object realized */
+    qdev_realize(DEVICE(h618), NULL, &error_abort);
+
+    /* SDRAM */
+    memory_region_add_subregion(get_system_memory(),
+                                h618->memmap[AW_H618_DEV_SDRAM],
+                                machine->ram);
+
+    opms->bootinfo.loader_start = h618->memmap[AW_H618_DEV_SDRAM];
+    opms->bootinfo.ram_size = machine->ram_size;
+    opms->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    arm_load_kernel(&h618->cpus[0], machine, &opms->bootinfo);
+}
+
+static void orangepi_zero2w_machine_init(MachineClass *mc)
+{
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a53"),
+        NULL
+    };
+
+    mc->desc = "Orange Pi Zero 2W (Cortex-A53)";
+    mc->init = orangepi_zero2w_init;
+    mc->min_cpus = AW_H618_NUM_CPUS;
+    mc->max_cpus = AW_H618_NUM_CPUS;
+    mc->default_cpus = AW_H618_NUM_CPUS;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
+    mc->valid_cpu_types = valid_cpu_types;
+    mc->default_ram_size = 1 * GiB;
+    mc->default_ram_id = "orangepi-zero2w.ram";
+}
+
+DEFINE_MACHINE_EXTENDED("orangepi-zero2w", MACHINE, OrangePiZero2WMachineState,
+                        orangepi_zero2w_machine_init, false, false,
+                        NULL)
-- 
2.43.0


