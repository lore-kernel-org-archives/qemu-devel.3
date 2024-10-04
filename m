Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDE4CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlIt-00030C-A8; Fri, 04 Oct 2024 12:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGm-0007DX-WA
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGk-0006Oc-Rm
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jdVFzb9L18j2pnmUeuxlHxonmR/Z1HZ0HNAjMMPuaSg=;
 b=Ac6Qso1D5b/kVjhj5VIPbbat1Ntx/JO+ylu6NK9J1qD8r5bUZXg2sqTe204wTMvUgr5YWZ
 xe0ayuPdLfOMkZkRf9FKa50rfI0k6ZL9tBswvGeIqVt2ZYHpdjBZCs5AXTE+lUWuDnVEvM
 CuLr6PRrBBuzrRwepfghQOls4GNz/YY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-Nw1ZTLxCPqyZjQtG51mlhQ-1; Fri, 04 Oct 2024 12:35:04 -0400
X-MC-Unique: Nw1ZTLxCPqyZjQtG51mlhQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb940cd67so22349215e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059702; x=1728664502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdVFzb9L18j2pnmUeuxlHxonmR/Z1HZ0HNAjMMPuaSg=;
 b=KNykf51Dqk9v3UFSzQK0XK+TftS3RTqN7nMz3RpguhG/PtjP8a8CEhBADFE8D2tBc0
 ZGhIqV3wwv9Z5LFBmBC7rf9i7fxRog6os3CslTJP3H9mug9NJmoK9cAb4ReXpdxd7StX
 ZwQQCMJAywBTUGCntlqzHfnL6AJHXtpfA0CqyrxI2LBqNsoIOVcqVNDwQKhjqR2a1fdj
 Kc3bqrx/gwrtT+Y5Yg3axfE8eIeXUV47aevS3Nv4diSmlLucxSuCg9RfVYjl6oiTG29e
 4N+oRhCB2m5UVQk1aeh6wBtMgCwi14VBCTyPlEX03fbbMG+s3FzUtHofhJiopeFDMZHW
 Z4Iw==
X-Gm-Message-State: AOJu0YwWlTRdkDgLtHWPSPkiyvOVOf8eYwrjwrEiQgLq2FQJrd2FbdCT
 XGSf/4ai6fiAwreQwGp4hHgFQ9C6PisTgIl5mGc2Pk3HqvzRU6WrEI2dmeY4IPBsm0HggzIdoR5
 /XUVvryn1GZ5UcaDUpCS+lgheXBvhSSgSahimNul3DH2cSjyauiDPKJ8aPZ0ddD+PbfzqcGwmjT
 s13aqtB1GDHEQlcu5cN+987PIInRJZH21FoqyhYTY=
X-Received: by 2002:a05:600c:3c9c:b0:42c:bae0:f05f with SMTP id
 5b1f17b1804b1-42f85aa98ddmr31420915e9.13.1728059701999; 
 Fri, 04 Oct 2024 09:35:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZZa22lqBVXcpeHJXVydGQTXKXOsXPzc7gIIiU1Aof+3bfmxWpQ+l8bBH+QH7fRuZwwpA6tQ==
X-Received: by 2002:a05:600c:3c9c:b0:42c:bae0:f05f with SMTP id
 5b1f17b1804b1-42f85aa98ddmr31420615e9.13.1728059701389; 
 Fri, 04 Oct 2024 09:35:01 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d16972b2esm23580f8f.105.2024.10.04.09.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:35:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 14/23] hw/char/serial.h: Extract serial-isa.h
Date: Fri,  4 Oct 2024 18:34:06 +0200
Message-ID: <20241004163415.951106-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The includes where updated based on compile errors. Now, the inclusion of the
header roughly matches Kconfig dependencies:

  # grep -r -e "select SERIAL_ISA"
  hw/ppc/Kconfig:    select SERIAL_ISA
  hw/isa/Kconfig:    select SERIAL_ISA
  hw/sparc64/Kconfig:    select SERIAL_ISA
  hw/i386/Kconfig:    select SERIAL_ISA
  hw/i386/Kconfig:    select SERIAL_ISA # for serial_hds_isa_init()

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Link: https://lore.kernel.org/r/20240905073832.16222-3-shentey@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
index 00000000000..8517afa128a
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
index 6e14099ee7f..fca32a532b9 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -106,13 +106,4 @@ SerialMM *serial_mm_init(MemoryRegion *address_space,
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
index 329b352b9a8..b562ec9d37c 100644
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
index b3049e4f9f2..fc5db6ed7ff 100644
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
index 8ae4dff7f2e..693099f2256 100644
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
index 67a921779ca..2047633e4cf 100644
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
index a8c8c58ef7f..cff756e791b 100644
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
index 4ad8e1293cf..6f44b381a5f 100644
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
index 988fd55d880..795acc289fa 100644
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
index 4ece1ac1ffc..a839abbf5d0 100644
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
2.46.1


