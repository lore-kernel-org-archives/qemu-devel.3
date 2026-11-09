Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA61606A325
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OOKRxX/I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQNfd-0005On-VW; Mon, 09 Nov 2026 06:36:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xQNfZ-0005Mo-MA
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:36:13 -0500
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xQNfX-0000Fe-Te
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:36:13 -0500
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-36e99cf7bb3so1309502eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 03:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794224170; x=1794828970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y9OcbmBQT6++Wgt2GiPCy82GPlfqJY+SVl7s/7VpF78=;
 b=OOKRxX/Iw0ZnV00c4aFrht3AHjdjd2CWPUC1eDqZXds7mlFV6ArrPGSZEX9r7cgtq+
 HBHlgx5b16eNA65HrCAtgxe1W6GP3jKhAWQPSu/QARkVkmDSboYMDBBICDHFnPIB/ufz
 Mdxfw5/XQmDH1ndeLYrs8bMRH4nuGxNJi6BHiIHnfDQBSBy5X+grGzlAh2vY4OjHAjO1
 +sWbIE4fan4bbNGcv8IYtiDbsRsjXd7qi5qg2xcIU9MMfaiNxu0RAQzyp/GQSGL8/BRH
 iMR2pBleeIDwsj3V+m69LiUvEcRcf/IlFvhMoYvKVUqq4p30ntRInWpBB5g5KdGAh3nS
 R0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794224170; x=1794828970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y9OcbmBQT6++Wgt2GiPCy82GPlfqJY+SVl7s/7VpF78=;
 b=qz9LOUH6ETj/cptkF7JuoNoGQHtO3JHWDohj+IpNzgOjv4IHnoEhaD12Bf7VdQf0Zv
 VTq0H0+sV56W1pk/v/V5W4NGjxlbUuBOUad7DB8CEWBFMnHshnWJqPaBk2G/ioNO+zFg
 Z92YpUc7TRPjIy31dnCDoQyTJwHesxkoFswogHYISP7MLbBlT41HvBCMr4gfoFVdijgh
 sPKFQjpAlzC2bZjbshh+OiOTZltVLAf0AV5ypElrEoOnWtPb0DH0mdftUI4lVPtfsSN7
 GIEVWrvvntz1R3X1Wxu8O9EoZm8fcehbUI0Ljysd8t5+twlq1obRis7HM3lLYcEN21UQ
 PtlQ==
X-Gm-Message-State: APuU4Z8gK6jHtZefiCUN4Va5SzIi86j2Ki4Rh03mjRX4VtR3j4D866Y9
 KLzN0QRsXZcId40d682QOo3vUYal2vH2aTiTvjJBYnIjExX6XqBzwhyASKud7InapuU=
X-Gm-Gg: AYBFou1JQ78ejwFMmEg0iTkxQFVKCwSuwmRa27YnXQqYq1bWjdZTCQ9tYMvyBRr2qWp
 ucLjIMRRD22ZeXH/5L/Lo9ppijCjEWwFtEUMpqxzdk8hbWCMS2TmvIt34eEsOHxjpAq6VsNC0yJ
 Wm3CuzVkiL7x/5n/gTJsRH4oEzDy/7X8iEjYBf9B/DA+QNT+H/imT5dqBWEOMoi7zWcMrhBJWJL
 is+/n6iJfGr6Ja2Ye+DmHVUNIQcjhm3BxVXD76C9BVI3B5fN7JQToXsVLx0Rwn9XuyV3Jz8nZRF
 RlJlk9969IdaMmnI9Q7PP03DJB+ZaD0tVKRWcXVbvLhJpUy8rMxFsOWMoJzaQ3x8asMugCFfTvF
 DYePwZWQ2RxkvKgBbO1Z998T36UvZe4bXLLh971Nl5hT4m7dyzZMCg95pO5n/D4eKbuo6LpuX22
 TCUwYNohPzyLez5xe408K9j6hnZunVIVe8UMmegFSkvTa0P4nPqPXojD9m412DwsPQQ5iWfXpFo
 D0hjZHHGfXUWl1ClixS9q3zDCMlcAMc/xl4Vg4S0eKSqW62ECEh9S+av7rWiD3yF7os78UJcPS/
 TUy0xDKYU9x867QYaoNeW1puePsEDDz1
X-Received: by 2002:a05:7300:d706:b0:36e:c03a:6c33 with SMTP id
 5a478bee46e88-372576bbddcmr10046226eec.29.1794224170237; 
 Mon, 09 Nov 2026 03:36:10 -0800 (PST)
Received: from ubuntu.lan ([2405:4802:913e:86f0:35c7:7294:a0c3:69b2])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372660f444csm19762941eec.19.2026.11.09.03.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 03:36:09 -0800 (PST)
From: Khai Do <dovankhai97@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com,
 strahinja.p.jankovic@gmail.com, Khai Do <dovankhai97@gmail.com>
Subject: [PATCH v2 2/8] hw/arm/orangepi-zero2w: Add Orange Pi Zero 2W machine
Date: Mon,  9 Nov 2026 18:35:30 +0700
Message-ID: <20261109113545.18561-3-dovankhai97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109113545.18561-1-dovankhai97@gmail.com>
References: <20261109113545.18561-1-dovankhai97@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=dovankhai97@gmail.com; helo=mail-dy1-x1335.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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


