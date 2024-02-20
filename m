Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F18C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLv7-00085G-98; Tue, 20 Feb 2024 03:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcLuf-0007IP-Gn
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:55:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcLuO-0000Gf-To
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708419324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HM6U0LU35a+2Z/yPJC0ehYwMCB1ei2vXBUN8XgWAe2Y=;
 b=YSCb7lq5kA4FWUlsbAdmdcU2OTPzgWG403h2X4eIfa8oyKOlIDrfSdR0Po347+BXRoiYO2
 xK6gJB9a+qP6+puFzS+ZOxxEJlvO0vedYnIVBuLSPAll1duJMp4K8zAeRh/dRi6CQmgmja
 JrYEz/N8vxRFdf6aNEzBU9RPlFbiRw8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328--D1aPyTCOFK__AlX410bMg-1; Tue, 20 Feb 2024 03:55:19 -0500
X-MC-Unique: -D1aPyTCOFK__AlX410bMg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69205867948;
 Tue, 20 Feb 2024 08:55:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E625492BE2;
 Tue, 20 Feb 2024 08:55:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH v2 5/7] hw/ide: Move IDE bus related definitions to a new
 header ide-bus.h
Date: Tue, 20 Feb 2024 09:55:03 +0100
Message-ID: <20240220085505.30255-6-thuth@redhat.com>
In-Reply-To: <20240220085505.30255-1-thuth@redhat.com>
References: <20240220085505.30255-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Let's consolidate the public IDE bus related functions in a separate
header.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/ide/ide-bus.h  | 42 +++++++++++++++++++++++++++++++++++++++
 include/hw/ide/internal.h | 40 +------------------------------------
 2 files changed, 43 insertions(+), 39 deletions(-)
 create mode 100644 include/hw/ide/ide-bus.h

diff --git a/include/hw/ide/ide-bus.h b/include/hw/ide/ide-bus.h
new file mode 100644
index 0000000000..4841a7dcd6
--- /dev/null
+++ b/include/hw/ide/ide-bus.h
@@ -0,0 +1,42 @@
+#ifndef HW_IDE_BUS_H
+#define HW_IDE_BUS_H
+
+#include "exec/ioport.h"
+#include "hw/ide/ide-dev.h"
+#include "hw/ide/ide-dma.h"
+
+struct IDEBus {
+    BusState qbus;
+    IDEDevice *master;
+    IDEDevice *slave;
+    IDEState ifs[2];
+    QEMUBH *bh;
+
+    int bus_id;
+    int max_units;
+    IDEDMA *dma;
+    uint8_t unit;
+    uint8_t cmd;
+    qemu_irq irq; /* bus output */
+
+    int error_status;
+    uint8_t retry_unit;
+    int64_t retry_sector_num;
+    uint32_t retry_nsector;
+    PortioList portio_list;
+    PortioList portio2_list;
+    VMChangeStateEntry *vmstate;
+};
+
+#define TYPE_IDE_BUS "IDE"
+OBJECT_DECLARE_SIMPLE_TYPE(IDEBus, IDE_BUS)
+
+void ide_bus_init(IDEBus *idebus, size_t idebus_size, DeviceState *dev,
+                  int bus_id, int max_units);
+IDEDevice *ide_bus_create_drive(IDEBus *bus, int unit, DriveInfo *drive);
+
+int ide_get_geometry(BusState *bus, int unit,
+                     int16_t *cyls, int8_t *heads, int8_t *secs);
+int ide_get_bios_chs_trans(BusState *bus, int unit);
+
+#endif
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 1aab89b27b..d3ec16a945 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -8,16 +8,10 @@
  */
 
 #include "hw/ide.h"
-#include "exec/ioport.h"
-#include "hw/ide/ide-dma.h"
-#include "hw/ide/ide-dev.h"
+#include "hw/ide/ide-bus.h"
 
 /* debug IDE devices */
 #define USE_DMA_CDROM
-#include "qom/object.h"
-
-#define TYPE_IDE_BUS "IDE"
-OBJECT_DECLARE_SIMPLE_TYPE(IDEBus, IDE_BUS)
 
 /* Device/Head ("select") Register */
 #define ATA_DEV_SELECT          0x10
@@ -338,29 +332,6 @@ typedef struct IDEBufferedRequest {
     bool orphaned;
 } IDEBufferedRequest;
 
-struct IDEBus {
-    BusState qbus;
-    IDEDevice *master;
-    IDEDevice *slave;
-    IDEState ifs[2];
-    QEMUBH *bh;
-
-    int bus_id;
-    int max_units;
-    IDEDMA *dma;
-    uint8_t unit;
-    uint8_t cmd;
-    qemu_irq irq; /* bus output */
-
-    int error_status;
-    uint8_t retry_unit;
-    int64_t retry_sector_num;
-    uint32_t retry_nsector;
-    PortioList portio_list;
-    PortioList portio2_list;
-    VMChangeStateEntry *vmstate;
-};
-
 /* These are used for the error_status field of IDEBus */
 #define IDE_RETRY_MASK 0xf8
 #define IDE_RETRY_DMA  0x08
@@ -477,15 +448,6 @@ void ide_cancel_dma_sync(IDEState *s);
 void ide_atapi_cmd(IDEState *s);
 void ide_atapi_cmd_reply_end(IDEState *s);
 
-/* hw/ide/qdev.c */
-void ide_bus_init(IDEBus *idebus, size_t idebus_size, DeviceState *dev,
-                  int bus_id, int max_units);
-IDEDevice *ide_bus_create_drive(IDEBus *bus, int unit, DriveInfo *drive);
-
-int ide_get_geometry(BusState *bus, int unit,
-                     int16_t *cyls, int8_t *heads, int8_t *secs);
-int ide_get_bios_chs_trans(BusState *bus, int unit);
-
 int ide_handle_rw_error(IDEState *s, int error, int op);
 
 #endif /* HW_IDE_INTERNAL_H */
-- 
2.43.2


