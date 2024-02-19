Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7EBC54764
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 10:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc1DU-00041n-Sr; Mon, 19 Feb 2024 05:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc1DE-0003tG-1Q
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:49:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc1DC-00017e-62
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708339765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qzo4v6fCKfQ/jWydL37MxupLQN9udl7GMivX/kfG0Nw=;
 b=QIwJQjkTDm3Wxrxgs8Bjel8JMdXdIvNcC9XCDbbnHnJTpgrji5v9hKCklJu6+dNiMGIB2P
 aWEMOjn4Q8qvpNKBn0cv429t7FepNfSNoCZv7hRt1pNlyVtaXOPz7epFxCQsTKmg7Zk36y
 GDfII6mLRDPYgz0+AImmU0FFxMHCN1U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-pJ3Z13mHO4Ssv-hXNTSp7w-1; Mon, 19 Feb 2024 05:49:21 -0500
X-MC-Unique: pJ3Z13mHO4Ssv-hXNTSp7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64BF4848D60;
 Mon, 19 Feb 2024 10:49:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 115DE1C060BC;
 Mon, 19 Feb 2024 10:49:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH 3/7] hw/ide: Move IDE device related definitions to ide-dev.h
Date: Mon, 19 Feb 2024 11:49:08 +0100
Message-ID: <20240219104912.378211-4-thuth@redhat.com>
In-Reply-To: <20240219104912.378211-1-thuth@redhat.com>
References: <20240219104912.378211-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Let's start to unentangle internal.h by moving public IDE device
related definitions to ide-dev.h.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/ide/ide-dev.h  | 145 +++++++++++++++++++++++++++++++++++++-
 include/hw/ide/internal.h | 145 +-------------------------------------
 hw/ide/ide-dev.c          |   1 +
 3 files changed, 146 insertions(+), 145 deletions(-)

diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
index 7e9663cda9..de88784a25 100644
--- a/include/hw/ide/ide-dev.h
+++ b/include/hw/ide/ide-dev.h
@@ -20,9 +20,152 @@
 #ifndef IDE_DEV_H
 #define IDE_DEV_H
 
+#include "sysemu/dma.h"
 #include "hw/qdev-properties.h"
 #include "hw/block/block.h"
-#include "hw/ide/internal.h"
+
+typedef struct IDEDevice IDEDevice;
+typedef struct IDEState IDEState;
+typedef struct IDEDMA IDEDMA;
+typedef struct IDEDMAOps IDEDMAOps;
+typedef struct IDEBus IDEBus;
+
+typedef void EndTransferFunc(IDEState *);
+
+#define MAX_IDE_DEVS 2
+
+#define TYPE_IDE_DEVICE "ide-device"
+OBJECT_DECLARE_TYPE(IDEDevice, IDEDeviceClass, IDE_DEVICE)
+
+typedef enum { IDE_HD, IDE_CD, IDE_CFATA } IDEDriveKind;
+
+struct unreported_events {
+    bool eject_request;
+    bool new_media;
+};
+
+enum ide_dma_cmd {
+    IDE_DMA_READ = 0,
+    IDE_DMA_WRITE,
+    IDE_DMA_TRIM,
+    IDE_DMA_ATAPI,
+    IDE_DMA__COUNT
+};
+
+/* NOTE: IDEState represents in fact one drive */
+struct IDEState {
+    IDEBus *bus;
+    uint8_t unit;
+    /* ide config */
+    IDEDriveKind drive_kind;
+    int drive_heads, drive_sectors;
+    int cylinders, heads, sectors, chs_trans;
+    int64_t nb_sectors;
+    int mult_sectors;
+    int identify_set;
+    uint8_t identify_data[512];
+    int drive_serial;
+    char drive_serial_str[21];
+    char drive_model_str[41];
+    uint64_t wwn;
+    /* ide regs */
+    uint8_t feature;
+    uint8_t error;
+    uint32_t nsector;
+    uint8_t sector;
+    uint8_t lcyl;
+    uint8_t hcyl;
+    /* other part of tf for lba48 support */
+    uint8_t hob_feature;
+    uint8_t hob_nsector;
+    uint8_t hob_sector;
+    uint8_t hob_lcyl;
+    uint8_t hob_hcyl;
+
+    uint8_t select;
+    uint8_t status;
+
+    bool io8;
+    bool reset_reverts;
+
+    /* set for lba48 access */
+    uint8_t lba48;
+    BlockBackend *blk;
+    char version[9];
+    /* ATAPI specific */
+    struct unreported_events events;
+    uint8_t sense_key;
+    uint8_t asc;
+    bool tray_open;
+    bool tray_locked;
+    uint8_t cdrom_changed;
+    int packet_transfer_size;
+    int elementary_transfer_size;
+    int32_t io_buffer_index;
+    int lba;
+    int cd_sector_size;
+    int atapi_dma; /* true if dma is requested for the packet cmd */
+    BlockAcctCookie acct;
+    BlockAIOCB *pio_aiocb;
+    QEMUIOVector qiov;
+    QLIST_HEAD(, IDEBufferedRequest) buffered_requests;
+    /* ATA DMA state */
+    uint64_t io_buffer_offset;
+    int32_t io_buffer_size;
+    QEMUSGList sg;
+    /* PIO transfer handling */
+    int req_nb_sectors; /* number of sectors per interrupt */
+    EndTransferFunc *end_transfer_func;
+    uint8_t *data_ptr;
+    uint8_t *data_end;
+    uint8_t *io_buffer;
+    /* PIO save/restore */
+    int32_t io_buffer_total_len;
+    int32_t cur_io_buffer_offset;
+    int32_t cur_io_buffer_len;
+    uint8_t end_transfer_fn_idx;
+    QEMUTimer *sector_write_timer; /* only used for win2k install hack */
+    uint32_t irq_count; /* counts IRQs when using win2k install hack */
+    /* CF-ATA extended error */
+    uint8_t ext_error;
+    /* CF-ATA metadata storage */
+    uint32_t mdata_size;
+    uint8_t *mdata_storage;
+    int media_changed;
+    enum ide_dma_cmd dma_cmd;
+    /* SMART */
+    uint8_t smart_enabled;
+    uint8_t smart_autosave;
+    int smart_errors;
+    uint8_t smart_selftest_count;
+    uint8_t *smart_selftest_data;
+    /* AHCI */
+    int ncq_queues;
+};
+
+struct IDEDeviceClass {
+    DeviceClass parent_class;
+    void (*realize)(IDEDevice *dev, Error **errp);
+};
+
+struct IDEDevice {
+    DeviceState qdev;
+    uint32_t unit;
+    BlockConf conf;
+    int chs_trans;
+    char *version;
+    char *serial;
+    char *model;
+    uint64_t wwn;
+    /*
+     * 0x0000        - rotation rate not reported
+     * 0x0001        - non-rotating medium (SSD)
+     * 0x0002-0x0400 - reserved
+     * 0x0401-0xffe  - rotations per minute
+     * 0xffff        - reserved
+     */
+    uint16_t rotation_rate;
+};
 
 typedef struct IDEDrive {
     IDEDevice dev;
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 3bdcc75597..5cc109fe82 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -8,24 +8,16 @@
  */
 
 #include "hw/ide.h"
-#include "sysemu/dma.h"
-#include "hw/block/block.h"
 #include "exec/ioport.h"
+#include "hw/ide/ide-dev.h"
 
 /* debug IDE devices */
 #define USE_DMA_CDROM
 #include "qom/object.h"
 
-typedef struct IDEDevice IDEDevice;
-typedef struct IDEState IDEState;
-typedef struct IDEDMA IDEDMA;
-typedef struct IDEDMAOps IDEDMAOps;
-
 #define TYPE_IDE_BUS "IDE"
 OBJECT_DECLARE_SIMPLE_TYPE(IDEBus, IDE_BUS)
 
-#define MAX_IDE_DEVS 2
-
 /* Device/Head ("select") Register */
 #define ATA_DEV_SELECT          0x10
 /* ATA1,3: Defined as '1'.
@@ -328,10 +320,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(IDEBus, IDE_BUS)
 #define SMART_DISABLE         0xd9
 #define SMART_STATUS          0xda
 
-typedef enum { IDE_HD, IDE_CD, IDE_CFATA } IDEDriveKind;
-
-typedef void EndTransferFunc(IDEState *);
-
 typedef void DMAStartFunc(const IDEDMA *, IDEState *, BlockCompletionFunc *);
 typedef void DMAVoidFunc(const IDEDMA *);
 typedef int DMAIntFunc(const IDEDMA *, bool);
@@ -339,19 +327,6 @@ typedef int32_t DMAInt32Func(const IDEDMA *, int32_t len);
 typedef void DMAu32Func(const IDEDMA *, uint32_t);
 typedef void DMAStopFunc(const IDEDMA *, bool);
 
-struct unreported_events {
-    bool eject_request;
-    bool new_media;
-};
-
-enum ide_dma_cmd {
-    IDE_DMA_READ = 0,
-    IDE_DMA_WRITE,
-    IDE_DMA_TRIM,
-    IDE_DMA_ATAPI,
-    IDE_DMA__COUNT
-};
-
 extern const char *IDE_DMA_CMD_lookup[IDE_DMA__COUNT];
 
 extern const MemoryRegionPortio ide_portio_list[];
@@ -369,97 +344,6 @@ typedef struct IDEBufferedRequest {
     bool orphaned;
 } IDEBufferedRequest;
 
-/* NOTE: IDEState represents in fact one drive */
-struct IDEState {
-    IDEBus *bus;
-    uint8_t unit;
-    /* ide config */
-    IDEDriveKind drive_kind;
-    int drive_heads, drive_sectors;
-    int cylinders, heads, sectors, chs_trans;
-    int64_t nb_sectors;
-    int mult_sectors;
-    int identify_set;
-    uint8_t identify_data[512];
-    int drive_serial;
-    char drive_serial_str[21];
-    char drive_model_str[41];
-    uint64_t wwn;
-    /* ide regs */
-    uint8_t feature;
-    uint8_t error;
-    uint32_t nsector;
-    uint8_t sector;
-    uint8_t lcyl;
-    uint8_t hcyl;
-    /* other part of tf for lba48 support */
-    uint8_t hob_feature;
-    uint8_t hob_nsector;
-    uint8_t hob_sector;
-    uint8_t hob_lcyl;
-    uint8_t hob_hcyl;
-
-    uint8_t select;
-    uint8_t status;
-
-    bool io8;
-    bool reset_reverts;
-
-    /* set for lba48 access */
-    uint8_t lba48;
-    BlockBackend *blk;
-    char version[9];
-    /* ATAPI specific */
-    struct unreported_events events;
-    uint8_t sense_key;
-    uint8_t asc;
-    bool tray_open;
-    bool tray_locked;
-    uint8_t cdrom_changed;
-    int packet_transfer_size;
-    int elementary_transfer_size;
-    int32_t io_buffer_index;
-    int lba;
-    int cd_sector_size;
-    int atapi_dma; /* true if dma is requested for the packet cmd */
-    BlockAcctCookie acct;
-    BlockAIOCB *pio_aiocb;
-    QEMUIOVector qiov;
-    QLIST_HEAD(, IDEBufferedRequest) buffered_requests;
-    /* ATA DMA state */
-    uint64_t io_buffer_offset;
-    int32_t io_buffer_size;
-    QEMUSGList sg;
-    /* PIO transfer handling */
-    int req_nb_sectors; /* number of sectors per interrupt */
-    EndTransferFunc *end_transfer_func;
-    uint8_t *data_ptr;
-    uint8_t *data_end;
-    uint8_t *io_buffer;
-    /* PIO save/restore */
-    int32_t io_buffer_total_len;
-    int32_t cur_io_buffer_offset;
-    int32_t cur_io_buffer_len;
-    uint8_t end_transfer_fn_idx;
-    QEMUTimer *sector_write_timer; /* only used for win2k install hack */
-    uint32_t irq_count; /* counts IRQs when using win2k install hack */
-    /* CF-ATA extended error */
-    uint8_t ext_error;
-    /* CF-ATA metadata storage */
-    uint32_t mdata_size;
-    uint8_t *mdata_storage;
-    int media_changed;
-    enum ide_dma_cmd dma_cmd;
-    /* SMART */
-    uint8_t smart_enabled;
-    uint8_t smart_autosave;
-    int smart_errors;
-    uint8_t smart_selftest_count;
-    uint8_t *smart_selftest_data;
-    /* AHCI */
-    int ncq_queues;
-};
-
 struct IDEDMAOps {
     DMAStartFunc *start_dma;
     DMAVoidFunc *pio_transfer;
@@ -502,33 +386,6 @@ struct IDEBus {
     VMChangeStateEntry *vmstate;
 };
 
-#define TYPE_IDE_DEVICE "ide-device"
-OBJECT_DECLARE_TYPE(IDEDevice, IDEDeviceClass, IDE_DEVICE)
-
-struct IDEDeviceClass {
-    DeviceClass parent_class;
-    void (*realize)(IDEDevice *dev, Error **errp);
-};
-
-struct IDEDevice {
-    DeviceState qdev;
-    uint32_t unit;
-    BlockConf conf;
-    int chs_trans;
-    char *version;
-    char *serial;
-    char *model;
-    uint64_t wwn;
-    /*
-     * 0x0000        - rotation rate not reported
-     * 0x0001        - non-rotating medium (SSD)
-     * 0x0002-0x0400 - reserved
-     * 0x0401-0xffe  - rotations per minute
-     * 0xffff        - reserved
-     */
-    uint16_t rotation_rate;
-};
-
 /* These are used for the error_status field of IDEBus */
 #define IDE_RETRY_MASK 0xf8
 #define IDE_RETRY_DMA  0x08
diff --git a/hw/ide/ide-dev.c b/hw/ide/ide-dev.c
index 15d088fd06..c8e2033469 100644
--- a/hw/ide/ide-dev.c
+++ b/hw/ide/ide-dev.c
@@ -23,6 +23,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/ide/ide-dev.h"
+#include "hw/ide/internal.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
-- 
2.43.2


