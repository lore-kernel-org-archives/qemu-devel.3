Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7998EE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMZ1-0002gb-G7; Wed, 11 Sep 2024 08:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMYS-00008g-4P
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMYO-000177-8B
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726058075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHkuky0731oI/nDRu2aiRQJHc/WkWZGbAcZFCyeHcHw=;
 b=fLg/2esXy2MDq162tDlxDH+oUKIi2xx7xvy1mmjGmKW23E78BVIiJWrdUe2x0yTIMCi1G6
 C1fSlTnpvVAaBIAuPdLNty5w8SCm83X6xKM4Aec3HvIzbDKnbWg1MDwQgiO7rbsLIHPJls
 Hf98MnK9+uYJzEgq8vKmDy5MKG0dZaU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-hWNtp6RaNdGiAGD5kHWhVw-1; Wed, 11 Sep 2024 08:34:33 -0400
X-MC-Unique: hWNtp6RaNdGiAGD5kHWhVw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374c9b0daf3so3352364f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726058072; x=1726662872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHkuky0731oI/nDRu2aiRQJHc/WkWZGbAcZFCyeHcHw=;
 b=i/Xo4L7xj+39JPLX2ul8lwP7/q8V5dacI+teeBbQY+zod42f/2JN0wiQ3nEQfi3Xff
 HwCtAewVx6PqB/qmoQATFcKpjFknyw4S9LxNkpdCIWV4SxyoaV2kPypJ2Hyjt9LZ3iuW
 tVRPSOG6RK7izzp+Bg2zTpkr9HRQdE8WE6rMw0oFNOSa/HBcVi/c3+c91NX99z8o0IT1
 4mhS6PNuIAaYgnN06Vk/i8atgVco7nzey0yfbcfv505Cn6tdDLpBjgJ3gEIwNRwVcQeU
 cfL1tJhj/UcF3RjTrTovhABabhhvofdEGArdCRdj92xolq3/29yZHM6aHx+RPfKJDXzn
 Fc1w==
X-Gm-Message-State: AOJu0YzzmNEeQbI07UTwQNrbzGr6uLx95hGUNxuRtZA1XK6+bBKGgpMq
 8FLdfTR4ZBWjtwQS2dfQ/vPZIxGijOHL5Q21VoYAtG08+27GrcVdE0qxzf+H/VcMYbuy+gqBsGz
 K4QLUWB/ENAxakWbHzhHjnWRWb2IvqusC8X/2VlmvpOMvRYIYfBEm9sQ47OmwQ8G/7SvERDIkGD
 aHWbXqxJOb2vkZcqYuamN2IchLKbAzQR+uucSnOHs=
X-Received: by 2002:a5d:6742:0:b0:371:8db9:939e with SMTP id
 ffacd0b85a97d-37894a6b0aemr9172495f8f.51.1726058071046; 
 Wed, 11 Sep 2024 05:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZnVTU8SCa2h1hNzzJTz1gA9T/fXYsu02jORaiSrzDQWbL5i5qMJcuONoyB+x4fmK9kK6fHQ==
X-Received: by 2002:a5d:6742:0:b0:371:8db9:939e with SMTP id
 ffacd0b85a97d-37894a6b0aemr9172463f8f.51.1726058070210; 
 Wed, 11 Sep 2024 05:34:30 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3789564a340sm11459509f8f.24.2024.09.11.05.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 05:34:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 15/17] hw/char: Extract serial-mm
Date: Wed, 11 Sep 2024 14:33:40 +0200
Message-ID: <20240911123342.339482-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911123342.339482-1-pbonzini@redhat.com>
References: <20240911123342.339482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

hw/char/serial currently contains the implementation of both TYPE_SERIAL and
TYPE_SERIAL_MM. According to serial_class_init(), TYPE_SERIAL is an internal
class while TYPE_SERIAL_MM is used by numerous machine types directly. Let's
move the latter into its own module which makes the dependencies more obvious
and the code more tidy.

The includes and the dependencies have been converted mechanically except in the
hw/char directories which were updated manually. The result was compile-tested.
Now, only hw/char makes direct use of TYPE_SERIAL:

  # grep -r -e "select SERIAL" | grep -v SERIAL_
  hw/char/Kconfig:    select SERIAL
  hw/char/Kconfig:    select SERIAL
  hw/char/Kconfig:    select SERIAL
  hw/char/Kconfig:    select SERIAL
  hw/char/Kconfig:    select SERIAL

  # grep -r -e "/serial\\.h"
  include/hw/char/serial-mm.h:#include "hw/char/serial.h"
  hw/char/serial-pci-multi.c:#include "hw/char/serial.h"
  hw/char/serial.c:#include "hw/char/serial.h"
  hw/char/serial-isa.c:#include "hw/char/serial.h"
  hw/char/serial-pci.c:#include "hw/char/serial.h"

Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Link: https://lore.kernel.org/r/20240905073832.16222-4-shentey@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/arm/aspeed_soc.h         |   2 +-
 include/hw/char/mchp_pfsoc_mmuart.h |   2 +-
 include/hw/char/serial-mm.h         |  52 +++++++++
 include/hw/char/serial.h            |  19 ----
 hw/arm/allwinner-a10.c              |   2 +-
 hw/arm/allwinner-h3.c               |   2 +-
 hw/arm/allwinner-r40.c              |   2 +-
 hw/arm/aspeed_ast2400.c             |   2 +-
 hw/arm/aspeed_soc_common.c          |   2 +-
 hw/arm/kzm.c                        |   2 +-
 hw/arm/msf2-soc.c                   |   2 +-
 hw/arm/musicpal.c                   |   2 +-
 hw/arm/npcm7xx.c                    |   2 +-
 hw/arm/pxa2xx.c                     |   2 +-
 hw/char/omap_uart.c                 |   2 +-
 hw/char/serial-mm.c                 | 157 ++++++++++++++++++++++++++++
 hw/char/serial.c                    | 126 ----------------------
 hw/display/sm501.c                  |   2 +-
 hw/hppa/machine.c                   |   2 +-
 hw/loongarch/virt.c                 |   2 +-
 hw/microblaze/petalogix_ml605_mmu.c |   2 +-
 hw/mips/boston.c                    |   2 +-
 hw/mips/jazz.c                      |   2 +-
 hw/mips/loongson3_virt.c            |   2 +-
 hw/mips/malta.c                     |   2 +-
 hw/mips/mipssim.c                   |   2 +-
 hw/openrisc/openrisc_sim.c          |   2 +-
 hw/openrisc/virt.c                  |   2 +-
 hw/ppc/e500.c                       |   2 +-
 hw/ppc/ppc405_uc.c                  |   2 +-
 hw/ppc/ppc440_bamboo.c              |   2 +-
 hw/ppc/sam460ex.c                   |   2 +-
 hw/ppc/virtex_ml507.c               |   2 +-
 hw/riscv/virt.c                     |   2 +-
 hw/sparc64/niagara.c                |   2 +-
 hw/sparc64/sun4u.c                  |   2 +-
 hw/xtensa/xtfpga.c                  |   2 +-
 hw/arm/Kconfig                      |  20 ++--
 hw/char/Kconfig                     |   4 +
 hw/char/meson.build                 |   1 +
 hw/display/Kconfig                  |   2 +-
 hw/hppa/Kconfig                     |   2 +-
 hw/loongarch/Kconfig                |   2 +-
 hw/microblaze/Kconfig               |   2 +-
 hw/mips/Kconfig                     |  10 +-
 hw/openrisc/Kconfig                 |   4 +-
 hw/ppc/Kconfig                      |  10 +-
 hw/riscv/Kconfig                    |   2 +-
 hw/sparc64/Kconfig                  |   1 +
 hw/xtensa/Kconfig                   |   2 +-
 50 files changed, 276 insertions(+), 206 deletions(-)
 create mode 100644 include/hw/char/serial-mm.h
 create mode 100644 hw/char/serial-mm.c

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 624d489e0d6..689f52dae8f 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -39,7 +39,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/misc/aspeed_peci.h"
 #include "hw/fsi/aspeed_apb2opb.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/intc/arm_gicv3.h"
 
 #define ASPEED_SPIS_NUM  2
diff --git a/include/hw/char/mchp_pfsoc_mmuart.h b/include/hw/char/mchp_pfsoc_mmuart.h
index b0e14ca3554..a7b8b1b08b3 100644
--- a/include/hw/char/mchp_pfsoc_mmuart.h
+++ b/include/hw/char/mchp_pfsoc_mmuart.h
@@ -29,7 +29,7 @@
 #define HW_MCHP_PFSOC_MMUART_H
 
 #include "hw/sysbus.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 
 #define MCHP_PFSOC_MMUART_REG_COUNT 13
 
diff --git a/include/hw/char/serial-mm.h b/include/hw/char/serial-mm.h
new file mode 100644
index 00000000000..62a8489d694
--- /dev/null
+++ b/include/hw/char/serial-mm.h
@@ -0,0 +1,52 @@
+/*
+ * QEMU 16550A UART emulation
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
+#ifndef HW_SERIAL_MM_H
+#define HW_SERIAL_MM_H
+
+#include "hw/char/serial.h"
+#include "exec/memory.h"
+#include "chardev/char.h"
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_SERIAL_MM "serial-mm"
+OBJECT_DECLARE_SIMPLE_TYPE(SerialMM, SERIAL_MM)
+
+struct SerialMM {
+    SysBusDevice parent;
+
+    SerialState serial;
+
+    uint8_t regshift;
+    uint8_t endianness;
+};
+
+SerialMM *serial_mm_init(MemoryRegion *address_space,
+                         hwaddr base, int regshift,
+                         qemu_irq irq, int baudbase,
+                         Chardev *chr, enum device_endian end);
+
+#endif
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index fca32a532b9..18952e2942b 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -29,8 +29,6 @@
 #include "chardev/char-fe.h"
 #include "exec/memory.h"
 #include "qemu/fifo8.h"
-#include "chardev/char.h"
-#include "hw/sysbus.h"
 #include "qom/object.h"
 
 #define UART_FIFO_LENGTH    16      /* 16550A Fifo Length */
@@ -81,15 +79,6 @@ struct SerialState {
 };
 typedef struct SerialState SerialState;
 
-struct SerialMM {
-    SysBusDevice parent;
-
-    SerialState serial;
-
-    uint8_t regshift;
-    uint8_t endianness;
-};
-
 extern const VMStateDescription vmstate_serial;
 extern const MemoryRegionOps serial_io_ops;
 
@@ -98,12 +87,4 @@ void serial_set_frequency(SerialState *s, uint32_t frequency);
 #define TYPE_SERIAL "serial"
 OBJECT_DECLARE_SIMPLE_TYPE(SerialState, SERIAL)
 
-#define TYPE_SERIAL_MM "serial-mm"
-OBJECT_DECLARE_SIMPLE_TYPE(SerialMM, SERIAL_MM)
-
-SerialMM *serial_mm_init(MemoryRegion *address_space,
-                         hwaddr base, int regshift,
-                         qemu_irq irq, int baudbase,
-                         Chardev *chr, enum device_endian end);
-
 #endif
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 57d5d80159c..08cdff61e46 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/sysbus.h"
 #include "hw/arm/allwinner-a10.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 6870c3fe963..9bc57cd2666 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -24,7 +24,7 @@
 #include "qemu/units.h"
 #include "hw/qdev-core.h"
 #include "hw/sysbus.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
 #include "hw/usb/hcd-ehci.h"
 #include "hw/loader.h"
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index b8c72021334..ced73009d63 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -26,7 +26,7 @@
 #include "hw/boards.h"
 #include "hw/qdev-core.h"
 #include "hw/sysbus.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
 #include "hw/usb/hcd-ehci.h"
 #include "hw/loader.h"
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index d1258862075..ecc81ecc79c 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -15,7 +15,7 @@
 #include "qapi/error.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "hw/i2c/aspeed_i2c.h"
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 05551461aea..a5ff33c46d7 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -15,7 +15,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 
 
 const char *aspeed_soc_cpu_type(AspeedSoCClass *sc)
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 2ccd6f8a768..fbd140e3833 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -22,7 +22,7 @@
 #include "exec/address-spaces.h"
 #include "net/net.h"
 #include "hw/net/lan9118.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "sysemu/qtest.h"
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index a94a10adcca..c4999ebce38 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -26,7 +26,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/arm/msf2-soc.h"
 #include "hw/misc/unimp.h"
 #include "hw/qdev-clock.h"
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 2020f73a576..940e4437d91 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -18,7 +18,7 @@
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index cb7791301b4..af04c4b7ec4 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -18,7 +18,7 @@
 
 #include "hw/arm/boot.h"
 #include "hw/arm/npcm7xx.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/loader.h"
 #include "hw/misc/unimp.h"
 #include "hw/qdev-clock.h"
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 6b2e54473b3..c1448e670ec 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -17,7 +17,7 @@
 #include "migration/vmstate.h"
 #include "hw/arm/pxa.h"
 #include "sysemu/sysemu.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index c2ef4c137e1..6ec04299960 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "chardev/char.h"
 #include "hw/arm/omap.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "exec/address-spaces.h"
 
 /* UARTs */
diff --git a/hw/char/serial-mm.c b/hw/char/serial-mm.c
new file mode 100644
index 00000000000..2f67776b190
--- /dev/null
+++ b/hw/char/serial-mm.c
@@ -0,0 +1,157 @@
+/*
+ * QEMU 16550A UART emulation
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
+#include "qemu/osdep.h"
+#include "hw/char/serial-mm.h"
+#include "exec/cpu-common.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+
+static uint64_t serial_mm_read(void *opaque, hwaddr addr, unsigned size)
+{
+    SerialMM *s = SERIAL_MM(opaque);
+    return serial_io_ops.read(&s->serial, addr >> s->regshift, 1);
+}
+
+static void serial_mm_write(void *opaque, hwaddr addr,
+                            uint64_t value, unsigned size)
+{
+    SerialMM *s = SERIAL_MM(opaque);
+    value &= 255;
+    serial_io_ops.write(&s->serial, addr >> s->regshift, value, 1);
+}
+
+static const MemoryRegionOps serial_mm_ops[3] = {
+    [DEVICE_NATIVE_ENDIAN] = {
+        .read = serial_mm_read,
+        .write = serial_mm_write,
+        .endianness = DEVICE_NATIVE_ENDIAN,
+        .valid.max_access_size = 8,
+        .impl.max_access_size = 8,
+    },
+    [DEVICE_LITTLE_ENDIAN] = {
+        .read = serial_mm_read,
+        .write = serial_mm_write,
+        .endianness = DEVICE_LITTLE_ENDIAN,
+        .valid.max_access_size = 8,
+        .impl.max_access_size = 8,
+    },
+    [DEVICE_BIG_ENDIAN] = {
+        .read = serial_mm_read,
+        .write = serial_mm_write,
+        .endianness = DEVICE_BIG_ENDIAN,
+        .valid.max_access_size = 8,
+        .impl.max_access_size = 8,
+    },
+};
+
+static void serial_mm_realize(DeviceState *dev, Error **errp)
+{
+    SerialMM *smm = SERIAL_MM(dev);
+    SerialState *s = &smm->serial;
+
+    if (!qdev_realize(DEVICE(s), NULL, errp)) {
+        return;
+    }
+
+    memory_region_init_io(&s->io, OBJECT(dev),
+                          &serial_mm_ops[smm->endianness], smm, "serial",
+                          8 << smm->regshift);
+    sysbus_init_mmio(SYS_BUS_DEVICE(smm), &s->io);
+    sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial.irq);
+}
+
+static const VMStateDescription vmstate_serial_mm = {
+    .name = "serial",
+    .version_id = 3,
+    .minimum_version_id = 2,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(serial, SerialMM, 0, vmstate_serial, SerialState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+SerialMM *serial_mm_init(MemoryRegion *address_space,
+                         hwaddr base, int regshift,
+                         qemu_irq irq, int baudbase,
+                         Chardev *chr, enum device_endian end)
+{
+    SerialMM *smm = SERIAL_MM(qdev_new(TYPE_SERIAL_MM));
+    MemoryRegion *mr;
+
+    qdev_prop_set_uint8(DEVICE(smm), "regshift", regshift);
+    qdev_prop_set_uint32(DEVICE(smm), "baudbase", baudbase);
+    qdev_prop_set_chr(DEVICE(smm), "chardev", chr);
+    qdev_set_legacy_instance_id(DEVICE(smm), base, 2);
+    qdev_prop_set_uint8(DEVICE(smm), "endianness", end);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(smm), &error_fatal);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(smm), 0, irq);
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(smm), 0);
+    memory_region_add_subregion(address_space, base, mr);
+
+    return smm;
+}
+
+static void serial_mm_instance_init(Object *o)
+{
+    SerialMM *smm = SERIAL_MM(o);
+
+    object_initialize_child(o, "serial", &smm->serial, TYPE_SERIAL);
+
+    qdev_alias_all_properties(DEVICE(&smm->serial), o);
+}
+
+static Property serial_mm_properties[] = {
+    /*
+     * Set the spacing between adjacent memory-mapped UART registers.
+     * Each register will be at (1 << regshift) bytes after the previous one.
+     */
+    DEFINE_PROP_UINT8("regshift", SerialMM, regshift, 0),
+    DEFINE_PROP_UINT8("endianness", SerialMM, endianness, DEVICE_NATIVE_ENDIAN),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void serial_mm_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    device_class_set_props(dc, serial_mm_properties);
+    dc->realize = serial_mm_realize;
+    dc->vmsd = &vmstate_serial_mm;
+}
+
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_SERIAL_MM,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .class_init = serial_mm_class_init,
+        .instance_init = serial_mm_instance_init,
+        .instance_size = sizeof(SerialMM),
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/char/serial.c b/hw/char/serial.c
index d8b2db50829..1e972950e88 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -996,135 +996,9 @@ static const TypeInfo serial_info = {
     .class_init = serial_class_init,
 };
 
-/* Memory mapped interface */
-static uint64_t serial_mm_read(void *opaque, hwaddr addr,
-                               unsigned size)
-{
-    SerialMM *s = SERIAL_MM(opaque);
-    return serial_ioport_read(&s->serial, addr >> s->regshift, 1);
-}
-
-static void serial_mm_write(void *opaque, hwaddr addr,
-                            uint64_t value, unsigned size)
-{
-    SerialMM *s = SERIAL_MM(opaque);
-    value &= 255;
-    serial_ioport_write(&s->serial, addr >> s->regshift, value, 1);
-}
-
-static const MemoryRegionOps serial_mm_ops[3] = {
-    [DEVICE_NATIVE_ENDIAN] = {
-        .read = serial_mm_read,
-        .write = serial_mm_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
-        .valid.max_access_size = 8,
-        .impl.max_access_size = 8,
-    },
-    [DEVICE_LITTLE_ENDIAN] = {
-        .read = serial_mm_read,
-        .write = serial_mm_write,
-        .endianness = DEVICE_LITTLE_ENDIAN,
-        .valid.max_access_size = 8,
-        .impl.max_access_size = 8,
-    },
-    [DEVICE_BIG_ENDIAN] = {
-        .read = serial_mm_read,
-        .write = serial_mm_write,
-        .endianness = DEVICE_BIG_ENDIAN,
-        .valid.max_access_size = 8,
-        .impl.max_access_size = 8,
-    },
-};
-
-static void serial_mm_realize(DeviceState *dev, Error **errp)
-{
-    SerialMM *smm = SERIAL_MM(dev);
-    SerialState *s = &smm->serial;
-
-    if (!qdev_realize(DEVICE(s), NULL, errp)) {
-        return;
-    }
-
-    memory_region_init_io(&s->io, OBJECT(dev),
-                          &serial_mm_ops[smm->endianness], smm, "serial",
-                          8 << smm->regshift);
-    sysbus_init_mmio(SYS_BUS_DEVICE(smm), &s->io);
-    sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial.irq);
-}
-
-static const VMStateDescription vmstate_serial_mm = {
-    .name = "serial",
-    .version_id = 3,
-    .minimum_version_id = 2,
-    .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT(serial, SerialMM, 0, vmstate_serial, SerialState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-SerialMM *serial_mm_init(MemoryRegion *address_space,
-                         hwaddr base, int regshift,
-                         qemu_irq irq, int baudbase,
-                         Chardev *chr, enum device_endian end)
-{
-    SerialMM *smm = SERIAL_MM(qdev_new(TYPE_SERIAL_MM));
-    MemoryRegion *mr;
-
-    qdev_prop_set_uint8(DEVICE(smm), "regshift", regshift);
-    qdev_prop_set_uint32(DEVICE(smm), "baudbase", baudbase);
-    qdev_prop_set_chr(DEVICE(smm), "chardev", chr);
-    qdev_set_legacy_instance_id(DEVICE(smm), base, 2);
-    qdev_prop_set_uint8(DEVICE(smm), "endianness", end);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(smm), &error_fatal);
-
-    sysbus_connect_irq(SYS_BUS_DEVICE(smm), 0, irq);
-    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(smm), 0);
-    memory_region_add_subregion(address_space, base, mr);
-
-    return smm;
-}
-
-static void serial_mm_instance_init(Object *o)
-{
-    SerialMM *smm = SERIAL_MM(o);
-
-    object_initialize_child(o, "serial", &smm->serial, TYPE_SERIAL);
-
-    qdev_alias_all_properties(DEVICE(&smm->serial), o);
-}
-
-static Property serial_mm_properties[] = {
-    /*
-     * Set the spacing between adjacent memory-mapped UART registers.
-     * Each register will be at (1 << regshift) bytes after the
-     * previous one.
-     */
-    DEFINE_PROP_UINT8("regshift", SerialMM, regshift, 0),
-    DEFINE_PROP_UINT8("endianness", SerialMM, endianness, DEVICE_NATIVE_ENDIAN),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void serial_mm_class_init(ObjectClass *oc, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-
-    device_class_set_props(dc, serial_mm_properties);
-    dc->realize = serial_mm_realize;
-    dc->vmsd = &vmstate_serial_mm;
-}
-
-static const TypeInfo serial_mm_info = {
-    .name = TYPE_SERIAL_MM,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .class_init = serial_mm_class_init,
-    .instance_init = serial_mm_instance_init,
-    .instance_size = sizeof(SerialMM),
-};
-
 static void serial_register_types(void)
 {
     type_register_static(&serial_info);
-    type_register_static(&serial_mm_info);
 }
 
 type_init(serial_register_types)
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 26dc8170d89..ad47fb60104 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -29,7 +29,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/usb/hcd-ohci.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "ui/console.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 5d0a8739deb..0ab54b06762 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -17,7 +17,7 @@
 #include "sysemu/runstate.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/timer/i8254.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/char/parallel.h"
 #include "hw/intc/i8259.h"
 #include "hw/input/lasips2.h"
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 29040422aa8..e3a6a252be2 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -9,7 +9,7 @@
 #include "qemu/datadir.h"
 #include "qapi/error.h"
 #include "hw/boards.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 0f5fabc32e3..b4183c5267d 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -34,7 +34,7 @@
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/qdev-properties.h"
 #include "exec/address-spaces.h"
 #include "hw/ssi/ssi.h"
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 1b44fb354c4..1ced1e337aa 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -22,7 +22,7 @@
 
 #include "elf.h"
 #include "hw/boards.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
 #include "hw/loader.h"
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 1bc17e69d3a..a3b39c86633 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -28,7 +28,7 @@
 #include "hw/mips/mips.h"
 #include "hw/intc/i8259.h"
 #include "hw/dma/i8257.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/char/parallel.h"
 #include "hw/isa/isa.h"
 #include "hw/block/fdc.h"
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 2067b4fecb5..a2db98665df 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -29,7 +29,7 @@
 #include "qemu/datadir.h"
 #include "qapi/error.h"
 #include "elf.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/intc/loongson_liointc.h"
 #include "hw/mips/mips.h"
 #include "hw/mips/fw_cfg.h"
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 664a2ae0a9e..1df00c4bf99 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -31,7 +31,7 @@
 #include "hw/clock.h"
 #include "hw/southbridge/piix.h"
 #include "hw/isa/superio.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "net/net.h"
 #include "hw/boards.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 9170d6c474b..a07732d3dc5 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -31,7 +31,7 @@
 #include "exec/address-spaces.h"
 #include "hw/clock.h"
 #include "hw/mips/mips.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index bffd6f721f7..9fb63515ef1 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -24,7 +24,7 @@
 #include "cpu.h"
 #include "hw/irq.h"
 #include "hw/boards.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "net/net.h"
 #include "hw/openrisc/boot.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index f8a68a6a6b1..47d2c9bd3c7 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -14,7 +14,7 @@
 #include "exec/address-spaces.h"
 #include "hw/irq.h"
 #include "hw/boards.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/core/split-irq.h"
 #include "hw/openrisc/boot.h"
 #include "hw/misc/sifive_test.h"
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 3bd12b54ab9..b760c6d6a25 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -24,7 +24,7 @@
 #include "net/net.h"
 #include "qemu/config-file.h"
 #include "hw/block/flash.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/pci/pci.h"
 #include "sysemu/block-backend-io.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 0cc68178adf..36b18d66948 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -32,7 +32,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "ppc405.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "qemu/timer.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 73f80cf7065..96d9ce65c26 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -23,7 +23,7 @@
 #include "sysemu/device_tree.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/ppc/ppc.h"
 #include "hw/pci-host/ppc4xx.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 8dc75fb9f08..1fce093ac8a 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -31,7 +31,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/reset.h"
 #include "hw/sysbus.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/i2c/ppc4xx_i2c.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/ide/pci.h"
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index c49da1f46f7..235281e9392 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -28,7 +28,7 @@
 #include "exec/page-protection.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/reset.h"
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cef41c150aa..105c20a5ff9 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -27,7 +27,7 @@
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-properties.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "target/riscv/cpu.h"
 #include "hw/core/sysbus-fdt.h"
 #include "target/riscv/pmu.h"
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index ab3c4ec3463..67ec403e1d4 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -27,7 +27,7 @@
 #include "qemu/units.h"
 #include "cpu.h"
 #include "hw/boards.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
 #include "hw/loader.h"
 #include "hw/sparc/sparc64.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index a839abbf5d0..541c7f74fa0 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -34,8 +34,8 @@
 #include "hw/pci/pci_host.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci-host/sabre.h"
-#include "hw/char/serial.h"
 #include "hw/char/serial-isa.h"
+#include "hw/char/serial-mm.h"
 #include "hw/char/parallel-isa.h"
 #include "hw/rtc/m48t59.h"
 #include "migration/vmstate.h"
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 955e8867a36..45b29d3b4e8 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -35,7 +35,7 @@
 #include "hw/qdev-properties.h"
 #include "elf.h"
 #include "exec/memory.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-mm.h"
 #include "net/net.h"
 #include "hw/sysbus.h"
 #include "hw/block/flash.h"
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1ad60da7aa2..ecde52f4a4a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -136,7 +136,7 @@ config MUSICPAL
     select MARVELL_88W8618
     select PTIMER
     select PFLASH_CFI02
-    select SERIAL
+    select SERIAL_MM
     select WM8750
 
 config NETDUINO2
@@ -179,13 +179,13 @@ config OMAP
     select NAND
     select PFLASH_CFI01
     select SD
-    select SERIAL
+    select SERIAL_MM
 
 config PXA2XX
     bool
     select FRAMEBUFFER
     select I2C
-    select SERIAL
+    select SERIAL_MM
     select SD
     select SSI
     select USB_OHCI_SYSBUS
@@ -399,7 +399,7 @@ config ALLWINNER_A10
     select ALLWINNER_EMAC
     select ALLWINNER_I2C
     select AXP2XX_PMU
-    select SERIAL
+    select SERIAL_MM
     select UNIMP
     select USB_OHCI_SYSBUS
 
@@ -411,7 +411,7 @@ config ALLWINNER_H3
     select ALLWINNER_SUN8I_EMAC
     select ALLWINNER_I2C
     select ALLWINNER_WDT
-    select SERIAL
+    select SERIAL_MM
     select ARM_TIMER
     select ARM_GIC
     select UNIMP
@@ -427,7 +427,7 @@ config ALLWINNER_R40
     select ALLWINNER_A10_PIT
     select ALLWINNER_WDT
     select AXP2XX_PMU
-    select SERIAL
+    select SERIAL_MM
     select ARM_TIMER
     select ARM_GIC
     select UNIMP
@@ -542,7 +542,7 @@ config NPCM7XX
     select ISL_PMBUS_VR
     select PL310  # cache controller
     select PMBUS
-    select SERIAL
+    select SERIAL_MM
     select SSI
     select UNIMP
     select PCA954X
@@ -564,7 +564,7 @@ config FSL_IMX31
     default y
     depends on TCG && ARM
     imply I2C_DEVICES
-    select SERIAL
+    select SERIAL_MM
     select IMX
     select IMX_I2C
     select WDT_IMX2
@@ -593,7 +593,7 @@ config ASPEED_SOC
     select I2C
     select DPS310
     select PCA9552
-    select SERIAL
+    select SERIAL_MM
     select SMBUS_EEPROM
     select PCA954X
     select SSI
@@ -681,7 +681,7 @@ config MSF2
     bool
     select ARM_V7M
     select PTIMER
-    select SERIAL
+    select SERIAL_MM
     select SSI
     select UNIMP
 
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 4fd74ea8788..4b73a803bf3 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -21,6 +21,10 @@ config SERIAL_ISA
     depends on ISA_BUS
     select SERIAL
 
+config SERIAL_MM
+    bool
+    select SERIAL
+
 config SERIAL_PCI
     bool
     default y if PCI_DEVICES
diff --git a/hw/char/meson.build b/hw/char/meson.build
index e5b13b69580..b99938f756a 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -14,6 +14,7 @@ system_ss.add(when: 'CONFIG_PL011', if_true: files('pl011.c'))
 system_ss.add(when: 'CONFIG_SCLPCONSOLE', if_true: files('sclpconsole.c', 'sclpconsole-lm.c'))
 system_ss.add(when: 'CONFIG_SERIAL', if_true: files('serial.c'))
 system_ss.add(when: 'CONFIG_SERIAL_ISA', if_true: files('serial-isa.c'))
+system_ss.add(when: 'CONFIG_SERIAL_MM', if_true: files('serial-mm.c'))
 system_ss.add(when: 'CONFIG_SERIAL_PCI', if_true: files('serial-pci.c'))
 system_ss.add(when: 'CONFIG_SERIAL_PCI_MULTI', if_true: files('serial-pci-multi.c'))
 system_ss.add(when: 'CONFIG_SHAKTI_UART', if_true: files('shakti_uart.c'))
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index a4552c8ed78..5fde4855e3f 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -76,7 +76,7 @@ config SM501
     bool
     select I2C
     select DDC
-    select SERIAL
+    select SERIAL_MM
     select USB_OHCI_SYSBUS
 
 config TCX
diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index d4d457f4ab4..9312c4294a4 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -9,7 +9,7 @@ config HPPA_B160L
     select ASTRO
     select DINO
     select LASI
-    select SERIAL
+    select SERIAL_MM
     select SERIAL_PCI
     select ISA_BUS
     select I8259
diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index 0de713a439e..6b67b34b7a6 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -9,7 +9,7 @@ config LOONGARCH_VIRT
     imply PCI_DEVICES
     imply NVDIMM
     imply TPM_TIS_SYSBUS
-    select SERIAL
+    select SERIAL_MM
     select VIRTIO_PCI
     select PLATFORM_BUS
     select LOONGARCH_IPI
diff --git a/hw/microblaze/Kconfig b/hw/microblaze/Kconfig
index d78ba843fac..b0214b2c8b2 100644
--- a/hw/microblaze/Kconfig
+++ b/hw/microblaze/Kconfig
@@ -13,7 +13,7 @@ config PETALOGIX_ML605
     default y
     depends on MICROBLAZE
     select PFLASH_CFI01
-    select SERIAL
+    select SERIAL_MM
     select SSI_M25P80
     select XILINX
     select XILINX_AXI
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 692bede538e..b09c89a0175 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -10,14 +10,14 @@ config MALTA
     select MIPS_CPS
     select PIIX
     select PFLASH_CFI01
-    select SERIAL
+    select SERIAL_MM
     select SMBUS_EEPROM
 
 config MIPSSIM
     bool
     default y
     depends on MIPS
-    select SERIAL
+    select SERIAL_MM
     select MIPSNET
 
 config JAZZ
@@ -37,7 +37,7 @@ config JAZZ
     select FDC_SYSBUS
     select MC146818RTC
     select PCKBD
-    select SERIAL
+    select SERIAL_MM
     select PARALLEL
     select DS1225Y
     select JAZZ_LED
@@ -65,7 +65,7 @@ config LOONGSON3V
     imply VIRTIO_VGA
     imply QXL if SPICE
     imply USB_OHCI_PCI
-    select SERIAL
+    select SERIAL_MM
     select GOLDFISH_RTC
     select LOONGSON_IPI
     select LOONGSON_LIOINTC
@@ -89,7 +89,7 @@ config MIPS_BOSTON
     select MIPS_CPS
     select PCI_EXPRESS_XILINX
     select AHCI_ICH9
-    select SERIAL
+    select SERIAL_MM
 
 config FW_CFG_MIPS
     bool
diff --git a/hw/openrisc/Kconfig b/hw/openrisc/Kconfig
index 76b953c62c2..0702f622a55 100644
--- a/hw/openrisc/Kconfig
+++ b/hw/openrisc/Kconfig
@@ -3,7 +3,7 @@ config OR1K_SIM
     default y
     depends on OPENRISC
     select DEVICE_TREE
-    select SERIAL
+    select SERIAL_MM
     select OPENCORES_ETH
     select OMPIC
     select SPLIT_IRQ
@@ -19,6 +19,6 @@ config OR1K_VIRT
     select PCI
     select PCI_EXPRESS_GENERIC_BRIDGE
     select GOLDFISH_RTC
-    select SERIAL
+    select SERIAL_MM
     select SIFIVE_TEST
     select VIRTIO_MMIO
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 5addad11240..b44d91bebb2 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -51,7 +51,7 @@ config PPC405
     select M48T59
     select PFLASH_CFI02
     select PPC4XX
-    select SERIAL
+    select SERIAL_MM
 
 config PPC440
     bool
@@ -63,7 +63,7 @@ config PPC440
     select PCI_EXPRESS
     select PPC440_PCIX
     select PPC4XX
-    select SERIAL
+    select SERIAL_MM
     select FDT_PPC
 
 config PPC4XX
@@ -80,7 +80,7 @@ config SAM460EX
     select IDE_SII3112
     select M41T80
     select PPC440
-    select SERIAL
+    select SERIAL_MM
     select SM501
     select SMBUS_EEPROM
     select USB_EHCI_SYSBUS
@@ -163,7 +163,7 @@ config E500
     select PLATFORM_BUS
     select PPCE500_PCI
     select SDHCI
-    select SERIAL
+    select SERIAL_MM
     select MPC_I2C
     select FDT_PPC
     select DS1338
@@ -187,7 +187,7 @@ config VIRTEX
     depends on PPC && FDT
     select PPC4XX
     select PFLASH_CFI01
-    select SERIAL
+    select SERIAL_MM
     select XILINX
     select XILINX_ETHLITE
     select FDT_PPC
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index a2030e3a6ff..44695ff9f2c 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -44,7 +44,7 @@ config RISCV_VIRT
     select PCI
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PFLASH_CFI01
-    select SERIAL
+    select SERIAL_MM
     select RISCV_ACLINT
     select RISCV_APLIC
     select RISCV_IMSIC
diff --git a/hw/sparc64/Kconfig b/hw/sparc64/Kconfig
index 3b948a22907..f764c8a219d 100644
--- a/hw/sparc64/Kconfig
+++ b/hw/sparc64/Kconfig
@@ -10,6 +10,7 @@ config SUN4U
     select ISA_BUS
     select FDC_ISA
     select SERIAL_ISA
+    select SERIAL_MM
     select PCI_SABRE
     select IDE_CMD646
     select PCKBD
diff --git a/hw/xtensa/Kconfig b/hw/xtensa/Kconfig
index fc5c785cfac..1f0492d89c0 100644
--- a/hw/xtensa/Kconfig
+++ b/hw/xtensa/Kconfig
@@ -18,4 +18,4 @@ config XTENSA_XTFPGA
     select DEVICE_TREE
     select OPENCORES_ETH
     select PFLASH_CFI01
-    select SERIAL
+    select SERIAL_MM
-- 
2.46.0


