Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DC7C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf7BZ-0004DE-HW; Wed, 01 Jul 2026 22:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wf7BX-0004CS-R0
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 22:29:51 -0400
Received: from ms-2002f-snip4-11.eps.apple.com ([57.103.74.63]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wf7BU-0002dw-Dg
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 22:29:51 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 28FDC1800108; Thu, 02 Jul 2026 02:29:41 +0000 (UTC)
X-ICL-RepId: 019f20a9-1e33-7107-a32c-fec4d6d50bf0
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5JHVoHRQNGD1YCWgZLVxQEFVsHVghdEkoXXS1aDhwTVhUTC1NWXxUXG1wAFxlRTQhIEwVSB11NVg1HD1geXBQXFUBDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FXggZCF0dGRVaCQpXAEALTgNaB1kCQgtBAVoZXwRFCEgeWxoGWhpYG1wPRARcMFQdHQ5YBgxQTQFDCAoCURxWDVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1782959385; x=1785551385; bh=Eu3SVbJYY/o3DOHB5BtYg9ft3oXxE4t6MxAZkiuoT9o=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=GNT3kU/O46AHDuFVbheIuhFVSRm1r9ccHGal9z9v8bKLTM1JMNl41MXkSP7mVCr/qZrQq2KY2rMxE8aKY6T34qZL3dLosaNK6VnDeF2vOj3Rk+SnNW+9sPiMQvmMzPaa2mhbkOTDXuuYZ+WynyotgCUxmfsbXgnMk08wG60jy3A190lmFnoH2v8Z499UWAWCUNJ21ThMuFnhcImKj0IyyUuLNoi/q1gESKVDsTlvTB62fCcUKjCD92K4otQy+lDP1hIpnZR6fiAYmuq3UexFbTGSrSNkiwrU2CdK6skz9q1S1lk+eBbJF7Fyln6ZoyqQPOw+Vv8Juhs9GMhYtxeWew==
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 56C19180011C; Thu, 02 Jul 2026 02:29:40 +0000 (UTC)
From: Matt Jacobson <mhjacobson@me.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Matt Jacobson <mhjacobson@me.com>
Subject: [PATCH v3 5/5] hw/block: remove unused SWIM1 floppy controller stub
Date: Wed,  1 Jul 2026 22:29:27 -0400
Message-ID: <20260702022927.46510-6-mhjacobson@me.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702022927.46510-1-mhjacobson@me.com>
References: <20260702022927.46510-1-mhjacobson@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Gde-rbctyKRdPvhq9dwg_O7Yf-whdtbn
X-Proofpoint-ORIG-GUID: Gde-rbctyKRdPvhq9dwg_O7Yf-whdtbn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyMyBTYWx0ZWRfX643Zvl68tH0J
 e909MzL4Jt1xbf1fwV5oB/mPGQJTixQJbVVtWPQMSiadCJPh24rkXeV8+CKrHZBDXjDdIuXKBLl
 7VKjUotdO1QE/lNOKtSeZLewgyMoYjHVq4pY0uLYK6Rbzg5X600Y/WpuzFnA8lCxQ4f+/XDxST6
 OMgQhwditUuQDkAw6H2DzXl0/pPk59A8mMJmZQvEzl/Uhfg/vmArvso9Sfj+p40MjNbgpeUeo6l
 VbnyeAD8tUwzQo56Gsa3nAtkcrlCoIh6v3jIg72LnoVHFfaFIIeToYwYrUo6xPeG5gdumZpUj/C
 X2SqIniHvILyhOcH3/+
Received-SPF: pass client-ip=57.103.74.63; envelope-from=mhjacobson@me.com;
 helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This was formerly used in the q800 machine; it's been replaced by a
functional SWIM2.

Signed-off-by: Matt Jacobson <mhjacobson@me.com>
---
 MAINTAINERS             |   2 -
 hw/block/meson.build    |   2 +-
 hw/block/swim.c         | 577 ----------------------------------------
 hw/block/trace-events   |   8 -
 include/hw/block/swim.h |  72 -----
 5 files changed, 1 insertion(+), 660 deletions(-)
 delete mode 100644 hw/block/swim.c
 delete mode 100644 include/hw/block/swim.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 93df53d87f..55da29e0cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1394,7 +1394,6 @@ F: hw/m68k/q800-glue.c
 F: hw/misc/mac_via.c
 F: hw/nubus/*
 F: hw/display/macfb.c
-F: hw/block/swim.c
 F: hw/misc/djmemc.c
 F: hw/misc/iosb.c
 F: hw/audio/asc.c
@@ -1404,7 +1403,6 @@ F: include/standard-headers/asm-m68k/bootinfo-mac.h
 F: include/hw/misc/mac_via.h
 F: include/hw/nubus/*
 F: include/hw/display/macfb.h
-F: include/hw/block/swim.h
 F: include/hw/m68k/q800.h
 F: include/hw/m68k/q800-glue.h
 F: include/hw/misc/djmemc.h
diff --git a/hw/block/meson.build b/hw/block/meson.build
index 733e9ffb47..2a9a0b9b13 100644
--- a/hw/block/meson.build
+++ b/hw/block/meson.build
@@ -10,7 +10,7 @@ system_ss.add(when: 'CONFIG_PFLASH_CFI01', if_true: files('pflash_cfi01.c'))
 system_ss.add(when: 'CONFIG_PFLASH_CFI02', if_true: files('pflash_cfi02.c'))
 system_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80.c'))
 system_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80_sfdp.c'))
-system_ss.add(when: 'CONFIG_SWIM', if_true: files('swim.c', 'swim2.c', 'sony_superdrive.c'))
+system_ss.add(when: 'CONFIG_SWIM', if_true: files('swim2.c', 'sony_superdrive.c'))
 system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-block.c'))
 
 system_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
diff --git a/hw/block/swim.c b/hw/block/swim.c
deleted file mode 100644
index 54b63bfbb5..0000000000
--- a/hw/block/swim.c
+++ /dev/null
@@ -1,577 +0,0 @@
-/*
- * QEMU Macintosh floppy disk controller emulator (SWIM)
- *
- * Copyright (c) 2014-2018 Laurent Vivier <laurent@vivier.eu>
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- * Only the basic support: it allows to switch from IWM (Integrated WOZ
- * Machine) mode to the SWIM mode and makes the linux driver happy.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/main-loop.h"
-#include "qapi/error.h"
-#include "system/block-backend.h"
-#include "hw/core/sysbus.h"
-#include "migration/vmstate.h"
-#include "hw/block/block.h"
-#include "hw/block/swim.h"
-#include "hw/core/qdev-properties.h"
-#include "trace.h"
-
-
-/* IWM latch bits */
-
-#define IWMLB_PHASE0            0
-#define IWMLB_PHASE1            1
-#define IWMLB_PHASE2            2
-#define IWMLB_PHASE3            3
-#define IWMLB_MOTORON           4
-#define IWMLB_DRIVESEL          5
-#define IWMLB_L6                6
-#define IWMLB_L7                7
-
-/* IWM registers */
-
-#define IWM_READALLONES         0
-#define IWM_READDATA            1
-#define IWM_READSTATUS0         2
-#define IWM_READSTATUS1         3
-#define IWM_READWHANDSHAKE0     4
-#define IWM_READWHANDSHAKE1     5
-#define IWM_WRITESETMODE        6
-#define IWM_WRITEDATA           7
-
-/* SWIM registers */
-
-#define SWIM_WRITE_DATA         0
-#define SWIM_WRITE_MARK         1
-#define SWIM_WRITE_CRC          2
-#define SWIM_WRITE_PARAMETER    3
-#define SWIM_WRITE_PHASE        4
-#define SWIM_WRITE_SETUP        5
-#define SWIM_WRITE_MODE0        6
-#define SWIM_WRITE_MODE1        7
-
-#define SWIM_READ_DATA          8
-#define SWIM_READ_MARK          9
-#define SWIM_READ_ERROR         10
-#define SWIM_READ_PARAMETER     11
-#define SWIM_READ_PHASE         12
-#define SWIM_READ_SETUP         13
-#define SWIM_READ_STATUS        14
-#define SWIM_READ_HANDSHAKE     15
-
-#define REG_SHIFT               9
-
-#define SWIM_MODE_STATUS_BIT    6
-#define SWIM_MODE_IWM           0
-#define SWIM_MODE_ISM           1
-
-/* bits in phase register */
-
-#define SWIM_SEEK_NEGATIVE   0x074
-#define SWIM_STEP            0x071
-#define SWIM_MOTOR_ON        0x072
-#define SWIM_MOTOR_OFF       0x076
-#define SWIM_INDEX           0x073
-#define SWIM_EJECT           0x077
-#define SWIM_SETMFM          0x171
-#define SWIM_SETGCR          0x175
-#define SWIM_RELAX           0x033
-#define SWIM_LSTRB           0x008
-#define SWIM_CA_MASK         0x077
-
-/* Select values for swim_select and swim_readbit */
-
-#define SWIM_READ_DATA_0     0x074
-#define SWIM_TWOMEG_DRIVE    0x075
-#define SWIM_SINGLE_SIDED    0x076
-#define SWIM_DRIVE_PRESENT   0x077
-#define SWIM_DISK_IN         0x170
-#define SWIM_WRITE_PROT      0x171
-#define SWIM_TRACK_ZERO      0x172
-#define SWIM_TACHO           0x173
-#define SWIM_READ_DATA_1     0x174
-#define SWIM_MFM_MODE        0x175
-#define SWIM_SEEK_COMPLETE   0x176
-#define SWIM_ONEMEG_MEDIA    0x177
-
-/* Bits in handshake register */
-
-#define SWIM_MARK_BYTE       0x01
-#define SWIM_CRC_ZERO        0x02
-#define SWIM_RDDATA          0x04
-#define SWIM_SENSE           0x08
-#define SWIM_MOTEN           0x10
-#define SWIM_ERROR           0x20
-#define SWIM_DAT2BYTE        0x40
-#define SWIM_DAT1BYTE        0x80
-
-/* bits in setup register */
-
-#define SWIM_S_INV_WDATA     0x01
-#define SWIM_S_3_5_SELECT    0x02
-#define SWIM_S_GCR           0x04
-#define SWIM_S_FCLK_DIV2     0x08
-#define SWIM_S_ERROR_CORR    0x10
-#define SWIM_S_IBM_DRIVE     0x20
-#define SWIM_S_GCR_WRITE     0x40
-#define SWIM_S_TIMEOUT       0x80
-
-/* bits in mode register */
-
-#define SWIM_CLFIFO          0x01
-#define SWIM_ENBL1           0x02
-#define SWIM_ENBL2           0x04
-#define SWIM_ACTION          0x08
-#define SWIM_WRITE_MODE      0x10
-#define SWIM_HEDSEL          0x20
-#define SWIM_MOTON           0x80
-
-static const char *iwm_reg_names[] = {
-    "READALLONES", "READDATA", "READSTATUS0", "READSTATUS1",
-    "READWHANDSHAKE0", "READWHANDSHAKE1", "WRITESETMODE", "WRITEDATA"
-};
-
-static const char *ism_reg_names[] = {
-    "WRITE_DATA", "WRITE_MARK", "WRITE_CRC", "WRITE_PARAMETER",
-    "WRITE_PHASE", "WRITE_SETUP", "WRITE_MODE0", "WRITE_MODE1",
-    "READ_DATA", "READ_MARK", "READ_ERROR", "READ_PARAMETER",
-    "READ_PHASE", "READ_SETUP", "READ_STATUS", "READ_HANDSHAKE"
-};
-
-static void fd_recalibrate(FDrive *drive)
-{
-}
-
-static void swim_change_cb(void *opaque, bool load, Error **errp)
-{
-    FDrive *drive = opaque;
-
-    if (!load) {
-        blk_set_perm(drive->blk, 0, BLK_PERM_ALL, &error_abort);
-    } else {
-        if (!blkconf_apply_backend_options(drive->conf,
-                                           !blk_supports_write_perm(drive->blk),
-                                           false, errp)) {
-            return;
-        }
-    }
-}
-
-static const BlockDevOps swim_block_ops = {
-    .change_media_cb = swim_change_cb,
-};
-
-static const Property swim_drive_properties[] = {
-    DEFINE_PROP_INT32("unit", SWIMDrive, unit, -1),
-    DEFINE_BLOCK_PROPERTIES(SWIMDrive, conf),
-};
-
-static void swim_drive_realize(DeviceState *qdev, Error **errp)
-{
-    SWIMDrive *dev = SWIM_DRIVE(qdev);
-    SWIMBus *bus = SWIM_BUS(qdev->parent_bus);
-    FDrive *drive;
-    int ret;
-
-    if (dev->unit == -1) {
-        for (dev->unit = 0; dev->unit < SWIM_MAX_FD; dev->unit++) {
-            drive = &bus->ctrl->drives[dev->unit];
-            if (!drive->blk) {
-                break;
-            }
-        }
-    }
-
-    if (dev->unit >= SWIM_MAX_FD) {
-        error_setg(errp, "Can't create floppy unit %d, bus supports "
-                   "only %d units", dev->unit, SWIM_MAX_FD);
-        return;
-    }
-
-    drive = &bus->ctrl->drives[dev->unit];
-    if (drive->blk) {
-        error_setg(errp, "Floppy unit %d is in use", dev->unit);
-        return;
-    }
-
-    if (!dev->conf.blk) {
-        /* Anonymous BlockBackend for an empty drive */
-        dev->conf.blk = blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
-        ret = blk_attach_dev(dev->conf.blk, qdev);
-        assert(ret == 0);
-    }
-
-    if (!blkconf_blocksizes(&dev->conf, errp)) {
-        return;
-    }
-
-    if (dev->conf.logical_block_size != 512 ||
-        dev->conf.physical_block_size != 512)
-    {
-        error_setg(errp, "Physical and logical block size must "
-                   "be 512 for floppy");
-        return;
-    }
-
-    /*
-     * rerror/werror aren't supported by fdc and therefore not even registered
-     * with qdev. So set the defaults manually before they are used in
-     * blkconf_apply_backend_options().
-     */
-    dev->conf.rerror = BLOCKDEV_ON_ERROR_AUTO;
-    dev->conf.werror = BLOCKDEV_ON_ERROR_AUTO;
-
-    if (!blkconf_apply_backend_options(&dev->conf,
-                                       !blk_supports_write_perm(dev->conf.blk),
-                                       false, errp)) {
-        return;
-    }
-
-    /*
-     * 'enospc' is the default for -drive, 'report' is what blk_new() gives us
-     * for empty drives.
-     */
-    if (blk_get_on_error(dev->conf.blk, 0) != BLOCKDEV_ON_ERROR_ENOSPC &&
-        blk_get_on_error(dev->conf.blk, 0) != BLOCKDEV_ON_ERROR_REPORT) {
-        error_setg(errp, "fdc doesn't support drive option werror");
-        return;
-    }
-    if (blk_get_on_error(dev->conf.blk, 1) != BLOCKDEV_ON_ERROR_REPORT) {
-        error_setg(errp, "fdc doesn't support drive option rerror");
-        return;
-    }
-
-    drive->conf = &dev->conf;
-    drive->blk = dev->conf.blk;
-    drive->swimctrl = bus->ctrl;
-
-    blk_set_dev_ops(drive->blk, &swim_block_ops, drive);
-}
-
-static void swim_drive_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *k = DEVICE_CLASS(klass);
-    k->realize = swim_drive_realize;
-    set_bit(DEVICE_CATEGORY_STORAGE, k->categories);
-    k->bus_type = TYPE_SWIM_BUS;
-    device_class_set_props(k, swim_drive_properties);
-    k->desc = "virtual SWIM drive";
-}
-
-static const TypeInfo swim_drive_info = {
-    .name = TYPE_SWIM_DRIVE,
-    .parent = TYPE_DEVICE,
-    .instance_size = sizeof(SWIMDrive),
-    .class_init = swim_drive_class_init,
-};
-
-static const TypeInfo swim_bus_info = {
-    .name = TYPE_SWIM_BUS,
-    .parent = TYPE_BUS,
-    .instance_size = sizeof(SWIMBus),
-};
-
-static void iwmctrl_write(void *opaque, hwaddr addr, uint64_t value,
-                          unsigned size)
-{
-    SWIMCtrl *swimctrl = opaque;
-    uint8_t latch, reg, ism_bit;
-
-    addr >>= REG_SHIFT;
-
-    /* A3-A1 select a latch, A0 specifies the value */
-    latch = (addr >> 1) & 7;
-    if (addr & 1) {
-        swimctrl->iwm_latches |= (1 << latch);
-    } else {
-        swimctrl->iwm_latches &= ~(1 << latch);
-    }
-
-    reg = (swimctrl->iwm_latches & 0xc0) >> 5 |
-          (swimctrl->iwm_latches & 0x10) >> 4;
-
-    swimctrl->iwmregs[reg] = value;
-    trace_swim_iwmctrl_write(reg, iwm_reg_names[reg], size, value);
-
-    switch (reg) {
-    case IWM_WRITESETMODE:
-        /* detect sequence to switch from IWM mode to SWIM mode */
-        ism_bit = (value & (1 << SWIM_MODE_STATUS_BIT));
-
-        switch (swimctrl->iwm_switch) {
-        case 0:
-            if (ism_bit) {    /* 1 */
-                swimctrl->iwm_switch++;
-            }
-            break;
-        case 1:
-            if (!ism_bit) {   /* 0 */
-                swimctrl->iwm_switch++;
-            }
-            break;
-        case 2:
-            if (ism_bit) {    /* 1 */
-                swimctrl->iwm_switch++;
-            }
-            break;
-        case 3:
-            if (ism_bit) {    /* 1 */
-                swimctrl->iwm_switch++;
-
-                swimctrl->mode = SWIM_MODE_ISM;
-                swimctrl->swim_mode |= (1 << SWIM_MODE_STATUS_BIT);
-                swimctrl->iwm_switch = 0;
-                trace_swim_switch_to_ism();
-
-                /* Switch to ISM registers */
-                memory_region_del_subregion(&swimctrl->swim, &swimctrl->iwm);
-                memory_region_add_subregion(&swimctrl->swim, 0x0,
-                                            &swimctrl->ism);
-            }
-            break;
-        }
-        break;
-    default:
-        break;
-    }
-}
-
-static uint64_t iwmctrl_read(void *opaque, hwaddr addr, unsigned size)
-{
-    SWIMCtrl *swimctrl = opaque;
-    uint8_t latch, reg, value;
-
-    addr >>= REG_SHIFT;
-
-    /* A3-A1 select a latch, A0 specifies the value */
-    latch = (addr >> 1) & 7;
-    if (addr & 1) {
-        swimctrl->iwm_latches |= (1 << latch);
-    } else {
-        swimctrl->iwm_latches &= ~(1 << latch);
-    }
-
-    reg = (swimctrl->iwm_latches & 0xc0) >> 5 |
-          (swimctrl->iwm_latches & 0x10) >> 4;
-
-    switch (reg) {
-    case IWM_READALLONES:
-        value = 0xff;
-        break;
-    default:
-        value = 0;
-        break;
-    }
-
-    trace_swim_iwmctrl_read(reg, iwm_reg_names[reg], size, value);
-    return value;
-}
-
-static const MemoryRegionOps swimctrl_iwm_ops = {
-    .write = iwmctrl_write,
-    .read = iwmctrl_read,
-    .endianness = DEVICE_BIG_ENDIAN,
-};
-
-static void ismctrl_write(void *opaque, hwaddr reg, uint64_t value,
-                          unsigned size)
-{
-    SWIMCtrl *swimctrl = opaque;
-
-    reg >>= REG_SHIFT;
-
-    trace_swim_ismctrl_write(reg, ism_reg_names[reg], size, value);
-
-    switch (reg) {
-    case SWIM_WRITE_PHASE:
-        swimctrl->swim_phase = value;
-        break;
-    case SWIM_WRITE_MODE0:
-        swimctrl->swim_mode &= ~value;
-        /* Any access to MODE0 register resets PRAM index */
-        swimctrl->pram_idx = 0;
-
-        if (!(swimctrl->swim_mode & (1 << SWIM_MODE_STATUS_BIT))) {
-            /* Clearing the mode bit switches to IWM mode */
-            swimctrl->mode = SWIM_MODE_IWM;
-            swimctrl->iwm_latches = 0;
-            trace_swim_switch_to_iwm();
-
-            /* Switch to IWM registers */
-            memory_region_del_subregion(&swimctrl->swim, &swimctrl->ism);
-            memory_region_add_subregion(&swimctrl->swim, 0x0,
-                                        &swimctrl->iwm);
-        }
-        break;
-    case SWIM_WRITE_MODE1:
-        swimctrl->swim_mode |= value;
-        break;
-    case SWIM_WRITE_PARAMETER:
-        swimctrl->pram[swimctrl->pram_idx++] = value;
-        swimctrl->pram_idx &= 0xf;
-        break;
-    case SWIM_WRITE_DATA:
-    case SWIM_WRITE_MARK:
-    case SWIM_WRITE_CRC:
-    case SWIM_WRITE_SETUP:
-        break;
-    }
-}
-
-static uint64_t ismctrl_read(void *opaque, hwaddr reg, unsigned size)
-{
-    SWIMCtrl *swimctrl = opaque;
-    uint32_t value = 0;
-
-    reg >>= REG_SHIFT;
-
-    switch (reg) {
-    case SWIM_READ_PHASE:
-        value = swimctrl->swim_phase;
-        break;
-    case SWIM_READ_HANDSHAKE:
-        if (swimctrl->swim_phase == SWIM_DRIVE_PRESENT) {
-            /* always answer "no drive present" */
-            value = SWIM_SENSE;
-        }
-        break;
-    case SWIM_READ_PARAMETER:
-        value = swimctrl->pram[swimctrl->pram_idx++];
-        swimctrl->pram_idx &= 0xf;
-        break;
-    case SWIM_READ_STATUS:
-        value = swimctrl->swim_status & ~(1 << SWIM_MODE_STATUS_BIT);
-        if (swimctrl->swim_mode == SWIM_MODE_ISM) {
-            value |= (1 << SWIM_MODE_STATUS_BIT);
-        }
-        break;
-    case SWIM_READ_DATA:
-    case SWIM_READ_MARK:
-    case SWIM_READ_ERROR:
-    case SWIM_READ_SETUP:
-        break;
-    }
-
-    trace_swim_ismctrl_read(reg, ism_reg_names[reg], size, value);
-    return value;
-}
-
-static const MemoryRegionOps swimctrl_ism_ops = {
-    .write = ismctrl_write,
-    .read = ismctrl_read,
-    .endianness = DEVICE_BIG_ENDIAN,
-};
-
-static void sysbus_swim_reset(DeviceState *d)
-{
-    Swim *sys = SWIM(d);
-    SWIMCtrl *ctrl = &sys->ctrl;
-    int i;
-
-    ctrl->mode = 0;
-    ctrl->iwm_switch = 0;
-    memset(ctrl->iwmregs, 0, sizeof(ctrl->iwmregs));
-
-    ctrl->swim_phase = 0;
-    ctrl->swim_mode = 0;
-    memset(ctrl->ismregs, 0, sizeof(ctrl->ismregs));
-    for (i = 0; i < SWIM_MAX_FD; i++) {
-        fd_recalibrate(&ctrl->drives[i]);
-    }
-}
-
-static void sysbus_swim_init(Object *obj)
-{
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    Swim *sbs = SWIM(obj);
-    SWIMCtrl *swimctrl = &sbs->ctrl;
-
-    memory_region_init(&swimctrl->swim, obj, "swim", 0x2000);
-    memory_region_init_io(&swimctrl->iwm, obj, &swimctrl_iwm_ops, swimctrl,
-                          "iwm", 0x2000);
-    memory_region_init_io(&swimctrl->ism, obj, &swimctrl_ism_ops, swimctrl,
-                          "ism", 0x2000);
-    sysbus_init_mmio(sbd, &swimctrl->swim);
-}
-
-static void sysbus_swim_realize(DeviceState *dev, Error **errp)
-{
-    Swim *sys = SWIM(dev);
-    SWIMCtrl *swimctrl = &sys->ctrl;
-
-    qbus_init(&swimctrl->bus, sizeof(SWIMBus), TYPE_SWIM_BUS, dev, NULL);
-    swimctrl->bus.ctrl = swimctrl;
-
-    /* Default register set is IWM */
-    memory_region_add_subregion(&swimctrl->swim, 0x0, &swimctrl->iwm);
-}
-
-static const VMStateDescription vmstate_fdrive = {
-    .name = "fdrive",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_END_OF_LIST()
-    },
-};
-
-static const VMStateDescription vmstate_swim = {
-    .name = "swim",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_INT32(mode, SWIMCtrl),
-        /* IWM mode */
-        VMSTATE_INT32(iwm_switch, SWIMCtrl),
-        VMSTATE_UINT8(iwm_latches, SWIMCtrl),
-        VMSTATE_UINT8_ARRAY(iwmregs, SWIMCtrl, 8),
-        /* SWIM mode */
-        VMSTATE_UINT8_ARRAY(ismregs, SWIMCtrl, 16),
-        VMSTATE_UINT8(swim_phase, SWIMCtrl),
-        VMSTATE_UINT8(swim_mode, SWIMCtrl),
-        /* Drives */
-        VMSTATE_STRUCT_ARRAY(drives, SWIMCtrl, SWIM_MAX_FD, 1,
-                             vmstate_fdrive, FDrive),
-        VMSTATE_END_OF_LIST()
-    },
-};
-
-static const VMStateDescription vmstate_sysbus_swim = {
-    .name = "SWIM",
-    .version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT(ctrl, Swim, 0, vmstate_swim, SWIMCtrl),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void sysbus_swim_class_init(ObjectClass *oc, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-
-    dc->realize = sysbus_swim_realize;
-    device_class_set_legacy_reset(dc, sysbus_swim_reset);
-    dc->vmsd = &vmstate_sysbus_swim;
-}
-
-static const TypeInfo sysbus_swim_info = {
-    .name          = TYPE_SWIM,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(Swim),
-    .instance_init = sysbus_swim_init,
-    .class_init    = sysbus_swim_class_init,
-};
-
-static void swim_register_types(void)
-{
-    type_register_static(&sysbus_swim_info);
-    type_register_static(&swim_bus_info);
-    type_register_static(&swim_drive_info);
-}
-
-type_init(swim_register_types)
diff --git a/hw/block/trace-events b/hw/block/trace-events
index c5793c7da8..47c4e663ef 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -104,14 +104,6 @@ m25p80_read_sfdp(void *s, uint32_t addr, uint8_t v) "[%p] Read SFDP 0x%"PRIx32"=
 m25p80_binding(void *s) "[%p] Binding to IF_MTD drive"
 m25p80_binding_no_bdrv(void *s) "[%p] No BDRV - binding to RAM"
 
-# swim.c
-swim_ismctrl_read(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
-swim_ismctrl_write(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
-swim_iwmctrl_read(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
-swim_iwmctrl_write(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
-swim_switch_to_ism(void) "switch from IWM to ISM mode"
-swim_switch_to_iwm(void) "switch from ISM to IWM mode"
-
 # swim2.c
 swim2_mmio_read(uint64_t addr, unsigned size, int reg, const char *name, uint64_t value, uint8_t mode, uint8_t setup, uint8_t phase, uint32_t fifo_count) "addr=0x%"PRIx64" size=%u reg=%d [%s] value=0x%"PRIx64" mode=0x%02x setup=0x%02x phase=0x%02x fifo=%u"
 swim2_mmio_write(uint64_t addr, unsigned size, int reg, const char *name, uint64_t value, uint8_t mode, uint8_t setup, uint8_t phase, uint32_t fifo_count) "addr=0x%"PRIx64" size=%u reg=%d [%s] value=0x%"PRIx64" mode=0x%02x setup=0x%02x phase=0x%02x fifo=%u"
diff --git a/include/hw/block/swim.h b/include/hw/block/swim.h
deleted file mode 100644
index e8998f57c4..0000000000
--- a/include/hw/block/swim.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * QEMU Macintosh floppy disk controller emulator (SWIM)
- *
- * Copyright (c) 2014-2018 Laurent Vivier <laurent@vivier.eu>
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- */
-
-#ifndef SWIM_H
-#define SWIM_H
-
-#include "hw/block/block.h"
-#include "hw/core/sysbus.h"
-#include "qom/object.h"
-
-#define SWIM_MAX_FD            2
-
-typedef struct SWIMCtrl SWIMCtrl;
-
-#define TYPE_SWIM_DRIVE "swim-drive"
-OBJECT_DECLARE_SIMPLE_TYPE(SWIMDrive, SWIM_DRIVE)
-
-struct SWIMDrive {
-    DeviceState qdev;
-    int32_t     unit;
-    BlockConf   conf;
-};
-
-#define TYPE_SWIM_BUS "swim-bus"
-OBJECT_DECLARE_SIMPLE_TYPE(SWIMBus, SWIM_BUS)
-
-struct SWIMBus {
-    BusState bus;
-    struct SWIMCtrl *ctrl;
-};
-
-typedef struct FDrive {
-    SWIMCtrl *swimctrl;
-    BlockBackend *blk;
-    BlockConf *conf;
-} FDrive;
-
-struct SWIMCtrl {
-    MemoryRegion swim;
-    MemoryRegion iwm;
-    MemoryRegion ism;
-    FDrive drives[SWIM_MAX_FD];
-    int mode;
-    /* IWM mode */
-    int iwm_switch;
-    uint8_t iwm_latches;
-    uint8_t iwmregs[8];
-    /* SWIM mode */
-    uint8_t ismregs[16];
-    uint8_t swim_phase;
-    uint8_t swim_mode;
-    uint8_t swim_status;
-    uint8_t pram[16];
-    uint8_t pram_idx;
-    SWIMBus bus;
-};
-
-#define TYPE_SWIM "swim"
-OBJECT_DECLARE_SIMPLE_TYPE(Swim, SWIM)
-
-struct Swim {
-    SysBusDevice parent_obj;
-    SWIMCtrl     ctrl;
-};
-#endif
-- 
2.54.0


