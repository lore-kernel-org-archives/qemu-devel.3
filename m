Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3632ACCF9E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 06:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBovS-0002eF-Jj; Thu, 23 Oct 2025 02:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vBovO-0002dH-5G
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:35:50 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vBovJ-0001PX-Jf
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:35:48 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7a2754a7f6aso565353b3a.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 23:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761201342; x=1761806142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O26TJJk9LEyMt5YJwhyM38ewlGmWhdC1le3aA1Yseo8=;
 b=B4axlJ7xQVxTnO2cRBCvdvI7NLXuYv3wj1qwogO/rinxBNinInqvAcY0jQFIg+mMsC
 zk3ULseYo8/kHC/w/IxMkJ8k/6dEVgL6Ff43xABz8AqdqPM8V7q/wyDC0NDBZaIHFpQh
 QhOZ/kzwXtnKhO7nkGGbDKI7xbefpU5kAt65YlZ7bToZu15N9O7hYw+h+iHWuzwx4jzL
 PY0uMw7QxzmjjsrWBlJvA4pLil1gLYC2z/5ORIUm2SbwMHAelDGwSLgmvH+gGesAfVm8
 k1XNfAPeO/4u/XYMxfCa0wDizuTsY8TquKLljCJkETJZN9PzJNHee5uBEkOuahkFcZPO
 7U3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761201342; x=1761806142;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O26TJJk9LEyMt5YJwhyM38ewlGmWhdC1le3aA1Yseo8=;
 b=dX1azvydcw121sUuMMsYAcK2zPIqTQIjHzvd0KtvwxpdGxfHNA/UeTtqeC85XQ55rp
 4YAJpYuTm+9SDZlH9JrkDYLXsYA0BEj5Mr8VKJVpRMmFyouu55C6uz5HhMz1uTdXwnEI
 SSu+ihMszu85b73dM8WM5NTO7sxbspD7KG5tywH0gujLP4eIY7nVQmKk7SJq0GH5Q0qr
 0AWn2pTLP3drzzR7nC3E58q4wx1XJ0Q0wo21nDIGqURhjoPNjJ83Rl7Rlna4kAuMLnx9
 gm4mkU+oFFHFxHULNFc5hQkm6IWJsFgSIm52fGDqjaWbxFI3nxphCmeWzy1EWdwUnNDC
 wpFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/9XcI85GLnKvAGjncE41aMbaZe5jEH5g1MXw9dxKQnuTTiEDg23M8poAoJhHUfQ5W7Pw83GurJbqd@nongnu.org
X-Gm-Message-State: AOJu0YwOGNQYSrwMO+WwE0F6FhnFPb3bCsC4v6l7evlHTTBSFE8A7NuN
 RUhbee5H8F9PnK/m1TrtN5Jwd4I/NoZR248GffJIECiCQM0gbQJkz4Du
X-Gm-Gg: ASbGnctlElKGDQqxUvdwr++gET4yGE/xDG+3BtpPN04rksE82BMEei0GdMcjHOhaIVr
 /VN4i76qMe7ukxwEVEewa3fQRoUw//4aq4mc8W5wZrirGwNfT53DyXgmfB4qa47KxhkZhuVYFpD
 oRKd4XJpgJ8H0FOP6UkLk2cOGqtDqrijgmEqe0Pb9czXuQYcZtfpRZUK5DirhwrXRR++a5j7g1z
 WcslwqI/MEgU0UPh4vAYBTLpfAWlOyRWcBC3hvJq1hUo+J+CB6Kube6zqKWjJtZltmOQGWGQYWZ
 pgJavb6Vhl1eLzvjSj3+UqunoCcNL7zzbCMbD6o1WFo9MLLvRihmIC9LXFO2l/vsa/CR3tG8ejD
 1CLAPs5C/YOetuACVMDDd0DJFzCo7iHLrJF5VB/h2pXFuABp+mGORKEJSPL5TUgDP6WM6Ch5j9A
 /+riUApn8LtdATkqvDIQClwtFQwjoExy2WZ4lp3C0=
X-Google-Smtp-Source: AGHT+IEufHEgcImr1cB80v1RKMizy24lWngDNJvPq4U9Y2lHUkpAjMHeQBT/J9aq+3tfP/b1UNDLtQ==
X-Received: by 2002:a05:6a21:9986:b0:320:3da8:34d7 with SMTP id
 adf61e73a8af0-334a85661b7mr29758983637.22.1761201341733; 
 Wed, 22 Oct 2025 23:35:41 -0700 (PDT)
Received: from ubuntu-VirtualBox.. ([122.11.166.8])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7a274bb22f6sm1355474b3a.56.2025.10.22.23.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 23:35:41 -0700 (PDT)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Alberto Garcia <berto@igalia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
Cc: qemu-trivial@nongnu.org, Nguyen Dinh Phi <phind.uet@gmail.com>,
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH] remove redundant typedef when use OBJECT_DECLARE_SIMPLE_TYPE
Date: Thu, 23 Oct 2025 14:34:28 +0800
Message-Id: <20251023063429.1400398-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=phind.uet@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

When OBJECT_DECLARE_SIMPLE_TYPE is used, it automatically provides
the typedef, so we don’t have to define it ourselves.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 backends/cryptodev-lkcf.c               | 1 -
 hw/char/ipoctal232.c                    | 9 ++++-----
 hw/char/xen_console.c                   | 1 -
 hw/dma/pl330.c                          | 6 ++----
 hw/net/fsl_etsec/etsec.h                | 1 -
 hw/net/xen_nic.c                        | 2 --
 hw/pci-host/bonito.c                    | 7 +++----
 hw/ppc/pef.c                            | 1 -
 hw/usb/dev-mtp.c                        | 7 +++----
 hw/usb/dev-uas.c                        | 7 +++----
 include/hw/char/serial.h                | 1 -
 include/hw/input/lasips2.h              | 6 ++----
 include/hw/misc/auxbus.h                | 7 +++----
 include/hw/misc/bcm2835_mphi.h          | 7 ++-----
 include/hw/misc/npcm7xx_pwm.h           | 7 ++-----
 include/hw/pci-host/pnv_phb3.h          | 6 ++----
 include/hw/pci-host/pnv_phb4.h          | 8 ++++----
 include/hw/ppc/mac_dbdma.h              | 7 +++----
 include/hw/riscv/iommu.h                | 3 ---
 include/hw/scsi/scsi.h                  | 7 +++----
 include/hw/vfio/vfio-container-legacy.h | 5 ++---
 include/hw/virtio/virtio-serial.h       | 5 ++---
 include/net/can_emu.h                   | 7 +++----
 23 files changed, 43 insertions(+), 75 deletions(-)

diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
index bb7a81d5d0..97a8a8812c 100644
--- a/backends/cryptodev-lkcf.c
+++ b/backends/cryptodev-lkcf.c
@@ -68,7 +68,6 @@ typedef struct CryptoDevBackendLKCFSession {
     QCryptoAkCipherOptions akcipher_opts;
 } CryptoDevBackendLKCFSession;
 
-typedef struct CryptoDevBackendLKCF CryptoDevBackendLKCF;
 typedef struct CryptoDevLKCFTask CryptoDevLKCFTask;
 struct CryptoDevLKCFTask {
     CryptoDevBackendLKCFSession *sess;
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 752c6c818a..0a7ffcd0b7 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -93,7 +93,10 @@
 #define ISR_RXRDY(CH) (((CH) & 1) ? BIT(5) : BIT(1))
 #define ISR_BREAK(CH) (((CH) & 1) ? BIT(6) : BIT(2))
 
-typedef struct IPOctalState IPOctalState;
+#define TYPE_IPOCTAL "ipoctal232"
+
+OBJECT_DECLARE_SIMPLE_TYPE(IPOctalState, IPOCTAL)
+
 typedef struct SCC2698Channel SCC2698Channel;
 typedef struct SCC2698Block SCC2698Block;
 
@@ -122,10 +125,6 @@ struct IPOctalState {
     uint8_t irq_vector;
 };
 
-#define TYPE_IPOCTAL "ipoctal232"
-
-OBJECT_DECLARE_SIMPLE_TYPE(IPOctalState, IPOCTAL)
-
 static const VMStateDescription vmstate_scc2698_channel = {
     .name = "scc2698_channel",
     .version_id = 1,
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index 9c34a554bf..0e73c2aee4 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -56,7 +56,6 @@ struct XenConsole {
     CharBackend       chr;
     int               backlog;
 };
-typedef struct XenConsole XenConsole;
 
 #define TYPE_XEN_CONSOLE_DEVICE "xen-console"
 OBJECT_DECLARE_SIMPLE_TYPE(XenConsole, XEN_CONSOLE_DEVICE)
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index a570bb08ec..f9c91f924b 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -111,7 +111,8 @@ typedef enum  {
     pl330_chan_fault = 15,
 } PL330ChanState;
 
-typedef struct PL330State PL330State;
+#define TYPE_PL330 "pl330"
+OBJECT_DECLARE_SIMPLE_TYPE(PL330State, PL330)
 
 typedef struct PL330Chan {
     uint32_t src;
@@ -274,9 +275,6 @@ struct PL330State {
     AddressSpace *mem_as;
 };
 
-#define TYPE_PL330 "pl330"
-OBJECT_DECLARE_SIMPLE_TYPE(PL330State, PL330)
-
 static const VMStateDescription vmstate_pl330 = {
     .name = "pl330",
     .version_id = 2,
diff --git a/hw/net/fsl_etsec/etsec.h b/hw/net/fsl_etsec/etsec.h
index 3860864a3f..bd2de3f99c 100644
--- a/hw/net/fsl_etsec/etsec.h
+++ b/hw/net/fsl_etsec/etsec.h
@@ -130,7 +130,6 @@ struct eTSEC {
     /* Whether we should flush the rx queue when buffer becomes available. */
     bool need_flush;
 };
-typedef struct eTSEC eTSEC;
 
 #define TYPE_ETSEC_COMMON "eTSEC"
 OBJECT_DECLARE_SIMPLE_TYPE(eTSEC, ETSEC_COMMON)
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 34c6a1d0b0..e7bdc732de 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -62,8 +62,6 @@ struct XenNetDev {
     NICState              *nic;
 };
 
-typedef struct XenNetDev XenNetDev;
-
 #define TYPE_XEN_NET_DEVICE "xen-net-device"
 OBJECT_DECLARE_SIMPLE_TYPE(XenNetDev, XEN_NET_DEVICE)
 
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 7d6251a78d..cbda068ef7 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -230,7 +230,9 @@ struct PCIBonitoState {
     MemoryRegion bonito_localio;
 
 };
-typedef struct PCIBonitoState PCIBonitoState;
+
+#define TYPE_PCI_BONITO "Bonito"
+OBJECT_DECLARE_SIMPLE_TYPE(PCIBonitoState, PCI_BONITO)
 
 struct BonitoState {
     PCIHostState parent_obj;
@@ -239,9 +241,6 @@ struct BonitoState {
     MemoryRegion pci_mem;
 };
 
-#define TYPE_PCI_BONITO "Bonito"
-OBJECT_DECLARE_SIMPLE_TYPE(PCIBonitoState, PCI_BONITO)
-
 static void bonito_writel(void *opaque, hwaddr addr,
                           uint64_t val, unsigned size)
 {
diff --git a/hw/ppc/pef.c b/hw/ppc/pef.c
index 254f570787..39b4ce94f1 100644
--- a/hw/ppc/pef.c
+++ b/hw/ppc/pef.c
@@ -19,7 +19,6 @@
 #define TYPE_PEF_GUEST "pef-guest"
 OBJECT_DECLARE_SIMPLE_TYPE(PefGuest, PEF_GUEST)
 
-typedef struct PefGuest PefGuest;
 typedef struct PefGuestClass PefGuestClass;
 
 struct PefGuestClass {
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index ce45c9cd06..afd7944b73 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -123,11 +123,13 @@ typedef struct {
 
 /* ----------------------------------------------------------------------- */
 
-typedef struct MTPState MTPState;
 typedef struct MTPControl MTPControl;
 typedef struct MTPData MTPData;
 typedef struct MTPObject MTPObject;
 
+#define TYPE_USB_MTP "usb-mtp"
+OBJECT_DECLARE_SIMPLE_TYPE(MTPState, USB_MTP)
+
 enum {
     EP_DATA_IN = 1,
     EP_DATA_OUT,
@@ -236,9 +238,6 @@ typedef struct {
     /* string and other data follows */
 } QEMU_PACKED ObjectInfo;
 
-#define TYPE_USB_MTP "usb-mtp"
-OBJECT_DECLARE_SIMPLE_TYPE(MTPState, USB_MTP)
-
 #define QEMU_STORAGE_ID 0x00010001
 
 #define MTP_FLAG_WRITABLE 0
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 21cc2835c6..18ebe15d0c 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -109,10 +109,12 @@ typedef struct {
 #define UAS_STREAM_BM_ATTR  4
 #define UAS_MAX_STREAMS     (1 << UAS_STREAM_BM_ATTR)
 
-typedef struct UASDevice UASDevice;
 typedef struct UASRequest UASRequest;
 typedef struct UASStatus UASStatus;
 
+#define TYPE_USB_UAS "usb-uas"
+OBJECT_DECLARE_SIMPLE_TYPE(UASDevice, USB_UAS)
+
 struct UASDevice {
     USBDevice                 dev;
     SCSIBus                   bus;
@@ -133,9 +135,6 @@ struct UASDevice {
     USBPacket                 *status3[UAS_MAX_STREAMS + 1];
 };
 
-#define TYPE_USB_UAS "usb-uas"
-OBJECT_DECLARE_SIMPLE_TYPE(UASDevice, USB_UAS)
-
 struct UASRequest {
     uint16_t     tag;
     uint64_t     lun;
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 4bf90a46f3..2cfeaed7fb 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -77,7 +77,6 @@ struct SerialState {
     QEMUTimer *modem_status_poll;
     MemoryRegion io;
 };
-typedef struct SerialState SerialState;
 
 extern const VMStateDescription vmstate_serial;
 extern const MemoryRegionOps serial_io_ops;
diff --git a/include/hw/input/lasips2.h b/include/hw/input/lasips2.h
index 01911c50f9..fd74883073 100644
--- a/include/hw/input/lasips2.h
+++ b/include/hw/input/lasips2.h
@@ -32,7 +32,8 @@ struct LASIPS2PortDeviceClass {
     DeviceRealize parent_realize;
 };
 
-typedef struct LASIPS2State LASIPS2State;
+#define TYPE_LASIPS2 "lasips2"
+OBJECT_DECLARE_SIMPLE_TYPE(LASIPS2State, LASIPS2)
 
 struct LASIPS2Port {
     DeviceState parent_obj;
@@ -74,7 +75,4 @@ struct LASIPS2State {
     qemu_irq irq;
 };
 
-#define TYPE_LASIPS2 "lasips2"
-OBJECT_DECLARE_SIMPLE_TYPE(LASIPS2State, LASIPS2)
-
 #endif /* HW_INPUT_LASIPS2_H */
diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index ccd18ce209..0051e03947 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -29,13 +29,15 @@
 #include "hw/qdev-core.h"
 #include "qom/object.h"
 
-typedef struct AUXSlave AUXSlave;
 typedef enum AUXCommand AUXCommand;
 typedef enum AUXReply AUXReply;
 
 #define TYPE_AUXTOI2C "aux-to-i2c-bridge"
 OBJECT_DECLARE_SIMPLE_TYPE(AUXTOI2CState, AUXTOI2C)
 
+#define TYPE_AUX_SLAVE "aux-slave"
+OBJECT_DECLARE_SIMPLE_TYPE(AUXSlave, AUX_SLAVE)
+
 enum AUXCommand {
     WRITE_I2C = 0,
     READ_I2C = 1,
@@ -73,9 +75,6 @@ struct AUXBus {
     AddressSpace aux_addr_space;
 };
 
-#define TYPE_AUX_SLAVE "aux-slave"
-OBJECT_DECLARE_SIMPLE_TYPE(AUXSlave, AUX_SLAVE)
-
 struct AUXSlave {
     /* < private > */
     DeviceState parent_obj;
diff --git a/include/hw/misc/bcm2835_mphi.h b/include/hw/misc/bcm2835_mphi.h
index 751363f496..3f1997e5f2 100644
--- a/include/hw/misc/bcm2835_mphi.h
+++ b/include/hw/misc/bcm2835_mphi.h
@@ -23,7 +23,8 @@
 
 #define MPHI_MMIO_SIZE      0x1000
 
-typedef struct BCM2835MphiState BCM2835MphiState;
+#define TYPE_BCM2835_MPHI   "bcm2835-mphi"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2835MphiState, BCM2835_MPHI)
 
 struct BCM2835MphiState {
     SysBusDevice parent_obj;
@@ -37,8 +38,4 @@ struct BCM2835MphiState {
     uint32_t swirq;
 };
 
-#define TYPE_BCM2835_MPHI   "bcm2835-mphi"
-
-OBJECT_DECLARE_SIMPLE_TYPE(BCM2835MphiState, BCM2835_MPHI)
-
 #endif
diff --git a/include/hw/misc/npcm7xx_pwm.h b/include/hw/misc/npcm7xx_pwm.h
index bf953440ac..df92726620 100644
--- a/include/hw/misc/npcm7xx_pwm.h
+++ b/include/hw/misc/npcm7xx_pwm.h
@@ -35,8 +35,8 @@
  * value of 100,000 the duty cycle for that PWM is 10%.
  */
 #define NPCM7XX_PWM_MAX_DUTY 1000000
-
-typedef struct NPCM7xxPWMState NPCM7xxPWMState;
+#define TYPE_NPCM7XX_PWM "npcm7xx-pwm"
+OBJECT_DECLARE_SIMPLE_TYPE(NPCM7xxPWMState, NPCM7XX_PWM)
 
 /**
  * struct NPCM7xxPWM - The state of a single PWM channel.
@@ -100,7 +100,4 @@ struct NPCM7xxPWMState {
     uint32_t    piir;
 };
 
-#define TYPE_NPCM7XX_PWM "npcm7xx-pwm"
-OBJECT_DECLARE_SIMPLE_TYPE(NPCM7xxPWMState, NPCM7XX_PWM)
-
 #endif /* NPCM7XX_PWM_H */
diff --git a/include/hw/pci-host/pnv_phb3.h b/include/hw/pci-host/pnv_phb3.h
index 24ca3dddaa..682f62a638 100644
--- a/include/hw/pci-host/pnv_phb3.h
+++ b/include/hw/pci-host/pnv_phb3.h
@@ -14,7 +14,8 @@
 #include "qom/object.h"
 #include "hw/pci-host/pnv_phb.h"
 
-typedef struct PnvPHB3 PnvPHB3;
+#define TYPE_PNV_PHB3 "pnv-phb3"
+OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB3, PNV_PHB3)
 
 /*
  * PHB3 XICS Source for MSIs
@@ -115,9 +116,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB3RootBus, PNV_PHB3_ROOT_BUS)
 /*
  * PHB3 PCIe Host Bridge for PowerNV machines (POWER8)
  */
-#define TYPE_PNV_PHB3 "pnv-phb3"
-OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB3, PNV_PHB3)
-
 #define PNV_PHB3_NUM_M64      16
 #define PNV_PHB3_NUM_REGS     (0x1000 >> 3)
 #define PNV_PHB3_NUM_LSI      8
diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
index 8a80c0c667..de996e718b 100644
--- a/include/hw/pci-host/pnv_phb4.h
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -17,8 +17,11 @@
 #include "hw/ppc/xive.h"
 #include "qom/object.h"
 
+
+#define TYPE_PNV_PHB4 "pnv-phb4"
+OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4, PNV_PHB4)
+
 typedef struct PnvPhb4PecStack PnvPhb4PecStack;
-typedef struct PnvPHB4 PnvPHB4;
 
 /*
  * We have one such address space wrapper per possible device under
@@ -59,9 +62,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4RootBus, PNV_PHB4_ROOT_BUS)
 /*
  * PHB4 PCIe Host Bridge for PowerNV machines (POWER9)
  */
-#define TYPE_PNV_PHB4 "pnv-phb4"
-OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4, PNV_PHB4)
-
 #define PNV_PHB4_MAX_LSIs          8
 #define PNV_PHB4_MAX_INTs          4096
 #define PNV_PHB4_MAX_MIST          (PNV_PHB4_MAX_INTs >> 2)
diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
index 896ee4a2b1..7676488245 100644
--- a/include/hw/ppc/mac_dbdma.h
+++ b/include/hw/ppc/mac_dbdma.h
@@ -164,7 +164,9 @@ struct DBDMAState {
     DBDMA_channel channels[DBDMA_CHANNELS];
     QEMUBH *bh;
 };
-typedef struct DBDMAState DBDMAState;
+
+#define TYPE_MAC_DBDMA "mac-dbdma"
+OBJECT_DECLARE_SIMPLE_TYPE(DBDMAState, MAC_DBDMA)
 
 /* Externally callable functions */
 
@@ -173,7 +175,4 @@ void DBDMA_register_channel(void *dbdma, int nchan, qemu_irq irq,
                             void *opaque);
 void DBDMA_kick(DBDMAState *dbdma);
 
-#define TYPE_MAC_DBDMA "mac-dbdma"
-OBJECT_DECLARE_SIMPLE_TYPE(DBDMAState, MAC_DBDMA)
-
 #endif
diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
index 8a8acfc3f0..25f1a8b159 100644
--- a/include/hw/riscv/iommu.h
+++ b/include/hw/riscv/iommu.h
@@ -24,18 +24,15 @@
 
 #define TYPE_RISCV_IOMMU "riscv-iommu"
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUState, RISCV_IOMMU)
-typedef struct RISCVIOMMUState RISCVIOMMUState;
 
 #define TYPE_RISCV_IOMMU_MEMORY_REGION "riscv-iommu-mr"
 typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
 
 #define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
-typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
 
 #define TYPE_RISCV_IOMMU_SYS "riscv-iommu-device"
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStateSys, RISCV_IOMMU_SYS)
-typedef struct RISCVIOMMUStateSys RISCVIOMMUStateSys;
 
 #define FDT_IRQ_TYPE_EDGE_LOW 1
 
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 90ee192b4d..044bd048b4 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -10,7 +10,9 @@
 
 #define MAX_SCSI_DEVS 255
 
-typedef struct SCSIBus SCSIBus;
+#define TYPE_SCSI_BUS "SCSI"
+OBJECT_DECLARE_SIMPLE_TYPE(SCSIBus, SCSI_BUS)
+
 typedef struct SCSIBusInfo SCSIBusInfo;
 typedef struct SCSIDevice SCSIDevice;
 typedef struct SCSIRequest SCSIRequest;
@@ -151,9 +153,6 @@ struct SCSIBusInfo {
     void (*drained_end)(SCSIBus *bus);
 };
 
-#define TYPE_SCSI_BUS "SCSI"
-OBJECT_DECLARE_SIMPLE_TYPE(SCSIBus, SCSI_BUS)
-
 struct SCSIBus {
     BusState qbus;
     int busnr;
diff --git a/include/hw/vfio/vfio-container-legacy.h b/include/hw/vfio/vfio-container-legacy.h
index ffd594e80d..fe82212526 100644
--- a/include/hw/vfio/vfio-container-legacy.h
+++ b/include/hw/vfio/vfio-container-legacy.h
@@ -12,7 +12,8 @@
 #include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-cpr.h"
 
-typedef struct VFIOLegacyContainer VFIOLegacyContainer;
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOLegacyContainer, VFIO_IOMMU_LEGACY);
+
 typedef struct VFIODevice VFIODevice;
 
 typedef struct VFIOGroup {
@@ -35,6 +36,4 @@ struct VFIOLegacyContainer {
     VFIOContainerCPR cpr;
 };
 
-OBJECT_DECLARE_SIMPLE_TYPE(VFIOLegacyContainer, VFIO_IOMMU_LEGACY);
-
 #endif /* HW_VFIO_CONTAINER_LEGACY_H */
diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
index d87c62eab7..60641860bf 100644
--- a/include/hw/virtio/virtio-serial.h
+++ b/include/hw/virtio/virtio-serial.h
@@ -29,7 +29,8 @@ struct virtio_serial_conf {
 OBJECT_DECLARE_TYPE(VirtIOSerialPort, VirtIOSerialPortClass,
                     VIRTIO_SERIAL_PORT)
 
-typedef struct VirtIOSerial VirtIOSerial;
+#define TYPE_VIRTIO_SERIAL "virtio-serial-device"
+OBJECT_DECLARE_SIMPLE_TYPE(VirtIOSerial, VIRTIO_SERIAL)
 
 #define TYPE_VIRTIO_SERIAL_BUS "virtio-serial-bus"
 OBJECT_DECLARE_SIMPLE_TYPE(VirtIOSerialBus, VIRTIO_SERIAL_BUS)
@@ -221,7 +222,5 @@ size_t virtio_serial_guest_ready(VirtIOSerialPort *port);
  */
 void virtio_serial_throttle_port(VirtIOSerialPort *port, bool throttle);
 
-#define TYPE_VIRTIO_SERIAL "virtio-serial-device"
-OBJECT_DECLARE_SIMPLE_TYPE(VirtIOSerial, VIRTIO_SERIAL)
 
 #endif
diff --git a/include/net/can_emu.h b/include/net/can_emu.h
index 6f9b206bb5..777281bad9 100644
--- a/include/net/can_emu.h
+++ b/include/net/can_emu.h
@@ -85,7 +85,9 @@ typedef struct qemu_can_filter {
 #define QEMU_CAN_INV_FILTER 0x20000000U
 
 typedef struct CanBusClientState CanBusClientState;
-typedef struct CanBusState CanBusState;
+
+#define TYPE_CAN_BUS "can-bus"
+OBJECT_DECLARE_SIMPLE_TYPE(CanBusState, CAN_BUS)
 
 typedef struct CanBusClientInfo {
     bool (*can_receive)(CanBusClientState *);
@@ -105,9 +107,6 @@ struct CanBusClientState {
     bool fd_mode;
 };
 
-#define TYPE_CAN_BUS "can-bus"
-OBJECT_DECLARE_SIMPLE_TYPE(CanBusState, CAN_BUS)
-
 int can_bus_filter_match(struct qemu_can_filter *filter, qemu_canid_t can_id);
 
 int can_bus_insert_client(CanBusState *bus, CanBusClientState *client);
-- 
2.39.2


