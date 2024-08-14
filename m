Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0CDC531DC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 18:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seIXQ-0005OQ-Mx; Wed, 14 Aug 2024 14:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1seIXP-0005Ku-TW; Wed, 14 Aug 2024 14:15:59 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1seIXN-0000Cn-Ei; Wed, 14 Aug 2024 14:15:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42803bbf842so797605e9.1; 
 Wed, 14 Aug 2024 11:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723659355; x=1724264155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=entFn+X14pilidwZtg7CSpHmLhYTeMMwnPQKUsYL44c=;
 b=Hi3vg3ufVj9bjicKU28W68YNlWrxUnYtscLJkFyfj0nqUSlXNKrPkSUf2AfhpwnUQB
 8vsE7QlCBP69KK7Qvolg1HsowKZ6Oym8MFqoW5pI0xWi12t09vttbj8uMyzmRwqzXroG
 mriskjPQJu43qHemc0njlXNuD/uUVclWDttpnZBSy3OawJ9gWfoh46SVnb/N6Lgb8tEG
 TvFmwY7n6oOTuI2gChcvQwSq1H4pVBOCpLZ1TbO0HK9MiHsY0fc7+x5ywa66ldXVs0Vy
 hbM/+096WRSh4UoiPVZsYPc4Hh93HuVYMAmXRv8I9V+HiAwhvvXbmeXtPH5FQ4j6zR+o
 XpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723659355; x=1724264155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=entFn+X14pilidwZtg7CSpHmLhYTeMMwnPQKUsYL44c=;
 b=RDfGCQz5GcHTG0pO0OVMIN5Kmwth9vGqzxx9Ox0zkEZtdmwCNBUWh4UEO6yQHuSV05
 Ndp+syh3kKGSqahOixz4ssBTiDlmmv8077cftIHwQGHyiXepSH1SQlR/YWL/f6JMivRO
 dypIJgaGWJbSIZjhrxq5K2+qxap6NBqbZqmsA0h/ckYxrybwmwhUv1ZcqTZL0ZbmNZMS
 w1pYrJd/Dn/ny3Z4On4wT2QwIAwwobTZTApavV8Qu13UfAos++W8mGtZXekA0RhW5+Se
 r2Jtxyo3VggyBW2ZI3U7fwzzIx46NN74aSxr7gHP8BAPYIFpuqnKjSIaIkSbBn3CIJ6E
 eq4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRRpMv+vrUahusuY8cueoL4z8bUPdVirfz5WtBF6QMpzO+Hytb76kJ7JkXOgZXtg46oMj+bQ7AHTRwS5rWHbU+AMcYqVXH0DkEirSFhEuTiWAfSwf/rLyRdnEmrAY5khsFdSWHu6ugj6N0/+38HMY=
X-Gm-Message-State: AOJu0YwwSANUcR/MQ/WcGZggTHfi39L2haX0H6atwE0XI+5llMdJN3pt
 G+OQ5zkmIBSI2M0g3hiykJ4rHFrVPVqppdcSHdXWB/2NRqVfD9ZK01YePA==
X-Google-Smtp-Source: AGHT+IEiPb4x4uLCy/wzq7nKHaJcCW4KONU27/ZKW8jxQ8qivG/FjVw93l6WEFQC1GJIXc+Gv94WMA==
X-Received: by 2002:a5d:54d2:0:b0:368:31c7:19da with SMTP id
 ffacd0b85a97d-371777446femr3212017f8f.13.1723659354403; 
 Wed, 14 Aug 2024 11:15:54 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-055-049-243.78.55.pool.telefonica.de. [78.55.49.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c937bb9sm13557625f8f.34.2024.08.14.11.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 11:15:54 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stafford Horne <shorne@gmail.com>,
 qemu-ppc@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Joel Stanley <joel@jms.id.au>, Eduardo Habkost <eduardo@habkost.net>,
 Sergio Lopez <slp@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jan Kiszka <jan.kiszka@web.de>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Jia Liu <proljc@gmail.com>,
 Helge Deller <deller@gmx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-riscv@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 4/5] hw/char/serial.h: Extract serial-isa.h
Date: Wed, 14 Aug 2024 20:15:33 +0200
Message-ID: <20240814181534.218964-5-shentey@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814181534.218964-1-shentey@gmail.com>
References: <20240814181534.218964-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The includes where updated based on compile errors. Now, the inclusion of the
header roughly matches Kconfig dependencies:

  # grep -r -e "select SERIAL_ISA"
  hw/ppc/Kconfig:    select SERIAL_ISA
  hw/isa/Kconfig:    select SERIAL_ISA
  hw/sparc64/Kconfig:    select SERIAL_ISA
  hw/i386/Kconfig:    select SERIAL_ISA
  hw/i386/Kconfig:    select SERIAL_ISA # for serial_hds_isa_init()

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/char/serial-isa.h | 38 ++++++++++++++++++++++++++++++++++++
 include/hw/char/serial.h     |  9 ---------
 hw/char/serial-isa.c         |  1 +
 hw/i386/microvm-dt.c         |  2 +-
 hw/i386/microvm.c            |  2 +-
 hw/i386/pc.c                 |  2 +-
 hw/isa/isa-superio.c         |  2 +-
 hw/isa/vt82c686.c            |  2 +-
 hw/ppc/pnv.c                 |  2 +-
 hw/sparc64/sun4u.c           |  1 +
 10 files changed, 46 insertions(+), 15 deletions(-)
 create mode 100644 include/hw/char/serial-isa.h

diff --git a/include/hw/char/serial-isa.h b/include/hw/char/serial-isa.h
new file mode 100644
index 0000000000..8517afa128
--- /dev/null
+++ b/include/hw/char/serial-isa.h
@@ -0,0 +1,38 @@
+/*
+ * QEMU ISA 16550A UART emulation
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ * Copyright (c) 2008 Citrix Systems, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_SERIAL_ISA_H
+#define HW_SERIAL_ISA_H
+
+#include "hw/isa/isa.h"
+
+#define MAX_ISA_SERIAL_PORTS 4
+
+#define TYPE_ISA_SERIAL "isa-serial"
+void serial_hds_isa_init(ISABus *bus, int from, int to);
+void isa_serial_set_iobase(ISADevice *serial, hwaddr iobase);
+void isa_serial_set_enabled(ISADevice *serial, bool enabled);
+
+#endif
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 40aad21df3..ccf322a031 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -104,13 +104,4 @@ SerialMM *serial_mm_init(MemoryRegion *address_space,
                          qemu_irq irq, int baudbase,
                          Chardev *chr, enum device_endian end);
 
-/* serial-isa.c */
-
-#define MAX_ISA_SERIAL_PORTS 4
-
-#define TYPE_ISA_SERIAL "isa-serial"
-void serial_hds_isa_init(ISABus *bus, int from, int to);
-void isa_serial_set_iobase(ISADevice *serial, hwaddr iobase);
-void isa_serial_set_enabled(ISADevice *serial, bool enabled);
-
 #endif
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 329b352b9a..b562ec9d37 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -29,6 +29,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/i386/microvm-dt.c b/hw/i386/microvm-dt.c
index b3049e4f9f..fc5db6ed7f 100644
--- a/hw/i386/microvm-dt.c
+++ b/hw/i386/microvm-dt.c
@@ -34,7 +34,7 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "sysemu/device_tree.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/sysbus.h"
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 40edcee7af..05c882669c 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -39,7 +39,7 @@
 #include "hw/intc/i8259.h"
 #include "hw/timer/i8254.h"
 #include "hw/rtc/mc146818rtc.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/display/ramfb.h"
 #include "hw/i386/topology.h"
 #include "hw/i386/e820_memory_layout.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c74931d577..b273d4a2e1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/i386/pc.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/char/parallel.h"
 #include "hw/hyperv/hv-balloon.h"
 #include "hw/i386/fw_cfg.h"
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index a8c8c58ef7..cff756e791 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -22,7 +22,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/input/i8042.h"
 #include "hw/char/parallel-isa.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "trace.h"
 
 static void isa_superio_realize(DeviceState *dev, Error **errp)
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 505b44c4e6..1aa5c9613f 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -17,7 +17,7 @@
 #include "hw/isa/vt82c686.h"
 #include "hw/block/fdc.h"
 #include "hw/char/parallel-isa.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
 #include "hw/ide/pci.h"
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3526852685..ffc3f2bca0 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -53,7 +53,7 @@
 #include "hw/ppc/pnv_pnor.h"
 
 #include "hw/isa/isa.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/rtc/mc146818rtc.h"
 
 #include <libfdt.h>
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 4ece1ac1ff..a839abbf5d 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -35,6 +35,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/pci-host/sabre.h"
 #include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/char/parallel-isa.h"
 #include "hw/rtc/m48t59.h"
 #include "migration/vmstate.h"
-- 
2.46.0


