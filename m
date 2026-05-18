Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F865CD4F48
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsVA-00012c-6S; Mon, 18 May 2026 03:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUb-0000j1-CN
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:28 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUX-0000Yi-Gs
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:25 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so1006249f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779089659; x=1779694459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XT/CXfHvPxeFJmlyE6fORLT0liEeLgpzBFdfs1VHhk4=;
 b=ERhP8yo/S23hhGBJelkYaWIhrGDEKps4GeHqXx8Ymox+HFE52MHfcOUqg8J3dRKIN5
 LaIGsAY/heB3UwwdyGerQgbrS9MDdtJgsqhdLKvQtstjYnRpLgQG1p4RmOObL9Z3PSJJ
 VMFMGQGbgBItKVuQ3MjsqSarLiaTtVp35z10KXLd2teeDlUo912NbtTMONwkG8kNUv+9
 3cKiyakO+qlx+evdWPJUXSUeTd8j5Inb6/+APiAsggScYPCk/kooiMdew8M24Uu9C4TH
 2jyk90bpjn4xrzusexHNBJI867z24tQ1NVfVDlCvcbJ/VVVDaZhd2d+UIKvqlyjwVcvB
 qkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779089659; x=1779694459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XT/CXfHvPxeFJmlyE6fORLT0liEeLgpzBFdfs1VHhk4=;
 b=Jd99X7lMku5mcAKyWI4GVoIQeV+Nh7YiW+NndmGk92JsnplwC+NF3jf8N5Deztp7XQ
 wzqsHVhR0tO+Rj2E5QoUAOphuF/JH3i4ptQ2JA2kAk4uywPuh9cxIy3ycYeWX61pDgmh
 ZQa3I+3ndr8+CNm8dQ6mMChsjNWiXU6KZZPrIsMkiQ+wEg3ytNiyYNb/o0SqXlb2HKAv
 U0GW/r3wpdUY1SSg+Ehp7EJpquELTpCZF/UtB/vKXTnxV1qKBm8e2eB++A1s1e4SkN0y
 LkShYVcMFODpOfQ6ux2ZP+jGjrpEZc3uGmGL7B4k2CXsuwebe2uNW6pt1ZnE509qYScp
 Wwuw==
X-Gm-Message-State: AOJu0YzYyiH+z23dsuwFK6uj7fmAxB1TTrAlm6FPCatd+jglSLTPDRx9
 WX0LwnqJvEgu9AMDEUaWhelTigOoMWw2+sR81PUsJ/6ztjsah2jDUPVvXXz8gSxj
X-Gm-Gg: Acq92OGUlkboXlJLSyMF0UhNaFDfFUmOeiSt9ooI39j8S6aLhkYIDNqYUJxDqP1fTrg
 BodYbL7iTRjnaW0+nUb7B8ojHSs9mPNDiB98jPwUuKLGM+i5rck4a4zOlkv1KwI9ElO1RG5Aapv
 ODnKsP+ZNHhhzR5KNBl+8/q+lqLYpSKdqOAifsqZl2WLJ6tcfTbW9FYkgx8q2yOIp6gG0DecP8a
 kI/lixBCiuR+UdrgHJParT4fRovum5Uj+DXpr62Is+ANNONuAzdYHrg5An9huO1kozBXa0z5JuA
 TLm3rhY3l0xBi2XYvXaWnpeYvs8z9DZr7pfU9A2I8CDm2Ffy7n9UGw1rFxoSsUkOozbSXh0TqLQ
 pURywv+SFS8qu3EXcVQwExHWE/Kj/SuKqg+4aGqseoj/H5XdWodDejaDtMTeEOte9LMRQ5xKupX
 6SPXVGbaR0N17STEqfe0VuqAigO7rDKxJsG3SHX4gDBg4XpQ==
X-Received: by 2002:a05:6000:2503:b0:451:4d47:c9d9 with SMTP id
 ffacd0b85a97d-45e5c367265mr21505482f8f.14.1779089658737; 
 Mon, 18 May 2026 00:34:18 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc08:b284:85e6:f7f4:1a4a:4dfe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm32590222f8f.11.2026.05.18.00.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 00:34:18 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org
Subject: [PATCH v7 15/16] hw/arm: Add new machine based on xilinx-zynq-a9 for
 Beckhoff CX7200
Date: Mon, 18 May 2026 09:34:00 +0200
Message-ID: <20260518073401.11279-16-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518073401.11279-1-corvin.koehne@gmail.com>
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: YannickV <Y.Vossen@beckhoff.com>

Introduce a new machine type 'beckhoff-cx7200' that inherits from the
xilinx-zynq-a9 machine. The CX7200 is an industrial PC based on the
Xilinx Zynq-7000 SoC.
The machine preserves all standard Zynq features (boot-mode selection,
SPI, UART, Ethernet, etc.) while adding CX7200-specific hardware
components.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 MAINTAINERS              |  9 +++++
 hw/arm/Kconfig           |  7 ++++
 hw/arm/beckhoff_CX7200.c | 80 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build       |  1 +
 4 files changed, 97 insertions(+)
 create mode 100644 hw/arm/beckhoff_CX7200.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 788b815501..c0a9531bf1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1159,6 +1159,15 @@ F: include/hw/adc/zynq-xadc.h
 X: hw/ssi/xilinx_*
 F: docs/system/arm/xlnx-zynq.rst
 
+Beckhoff CX7200
+M: Yannick Vossen <Y.Vossen@beckhoff.com>
+M: Corvin Koehne <C.Koehne@beckhoff.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/beckhoff_CX7200.c
+F: hw/misc/beckhoff_ccat.c
+F: include/hw/misc/beckhoff_ccat.h
+
 Xilinx ZynqMP and Versal
 M: Alistair Francis <alistair@alistair23.me>
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index fb798ccbee..be500186ca 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -292,6 +292,13 @@ config ZYNQ
     select XLNX_ZYNQ_DDRC
     select ZYNQ_DEVCFG
 
+config BECKHOFF_CX7200
+    bool
+    default y
+    depends on TCG && ARM
+    select ZYNQ
+    select BECKHOFF_CCAT
+
 config ARM_V7M
     bool
     # currently v7M must be included in a TCG build due to translate.c
diff --git a/hw/arm/beckhoff_CX7200.c b/hw/arm/beckhoff_CX7200.c
new file mode 100644
index 0000000000..6e27515886
--- /dev/null
+++ b/hw/arm/beckhoff_CX7200.c
@@ -0,0 +1,80 @@
+
+/*
+ * Modified Xilinx Zynq Baseboard System emulation for Beckhoff CX7200.
+ *
+ * Copyright (c) 2026 Beckhoff Automation GmbH & Co. KG
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/core/boards.h"
+#include "hw/block/block.h"
+#include "hw/core/loader.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/clock.h"
+#include "qemu/error-report.h"
+#include "hw/arm/xilinx_zynq.h"  /* For ZynqMachineState */
+#include "hw/cpu/a9mpcore.h"
+#include "hw/timer/a9gtimer.h"
+#include "qom/object.h"
+
+#define TYPE_CX7200_MACHINE MACHINE_TYPE_NAME("beckhoff-cx7200")
+
+#define CX7200_PS_CLK_FREQUENCY (40 * 1000 * 1000)
+
+static void ccat_init(uint32_t base, BlockBackend *eeprom_blk)
+{
+    DeviceState *dev;
+    SysBusDevice *busdev;
+
+    dev = qdev_new("beckhoff-ccat");
+    if (eeprom_blk) {
+        qdev_prop_set_drive_err(dev, "eeprom", eeprom_blk, &error_fatal);
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, base);
+}
+
+static void beckhoff_cx7200_init(MachineState *machine)
+{
+    DriveInfo *di;
+    BlockBackend *blk;
+    MachineClass *parent_mc;
+
+    parent_mc = MACHINE_CLASS(object_class_get_parent(
+                                  object_get_class(OBJECT(machine))));
+    parent_mc->init(machine);
+
+    di = drive_get(IF_NONE, 0, 0);
+    blk = di ? blk_by_legacy_dinfo(di) : NULL;
+    ccat_init(0x40000000, blk);
+}
+
+static void beckhoff_cx7200_machine_class_init(ObjectClass *oc,
+                                               const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    ZynqMachineClass *zmc = ZYNQ_MACHINE_CLASS(oc);
+
+    mc->desc = "Beckhoff CX7200 Industrial PC (Zynq-based)";
+    mc->init = beckhoff_cx7200_init;
+    zmc->qspi_flash_type = "is25lp016d";
+    zmc->ps_clk_freq = CX7200_PS_CLK_FREQUENCY;
+}
+
+static const TypeInfo beckhoff_cx7200_machine_type = {
+    .name = TYPE_CX7200_MACHINE,
+    .parent = TYPE_ZYNQ_MACHINE,
+    .class_init = beckhoff_cx7200_machine_class_init,
+    .instance_size = sizeof(ZynqMachineState),
+};
+
+static void beckhoff_cx7200_machine_register_types(void)
+{
+    type_register_static(&beckhoff_cx7200_machine_type);
+}
+
+type_init(beckhoff_cx7200_machine_register_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 80068f70bb..46e77cb49b 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -2,6 +2,7 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
+arm_common_ss.add(when: 'CONFIG_BECKHOFF_CX7200', if_true: files('beckhoff_CX7200.c'))
 arm_common_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
 arm_common_ss.add(when: 'CONFIG_EMCRAFT_SF2', if_true: files('msf2-som.c'))
 arm_common_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
-- 
2.47.3


