Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8048F8D763
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 17:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDQcz-0008LK-VN; Thu, 16 Apr 2026 13:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rafettaskindev@gmail.com>)
 id 1wDQcw-0008L7-Dc
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 13:35:42 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rafettaskindev@gmail.com>)
 id 1wDQct-0008HJ-P8
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 13:35:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so76305555e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776360937; x=1776965737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/NbbsXIB2dT+ipJ5imq6uLP4HESZka3xMa5IMCnHweI=;
 b=iHIjQx8bMnh7f+L8s1N1s0T3VcJ0jTLZlcss7UumMo3YYNKZIbjunc2jSZ0x+qHBI1
 c3CH2LWwzCnJzRhw2AGen4/R4rx2ETgv4szWqTFcMmKqseIUN23gv8xGIWo4SICnfgDi
 /b8Xr9OsHwECMzcwTzAkBMYrpmoZ50m+dxwR3NGG4aRxn+mTXYFe4VZAEAbDI2xXxujQ
 7dL1ARvOuTnD95eB03eZ6fxdfcL0O6B9fEyxXnD05Wm7rpBVmsWVxhHYxgUUik2p9Hid
 FbB3RnlcO9l3tN0t7Dei/XFjDURbmW7Yz6fcmQu084U94rBcsNzDqBhcyqiwXu/M0b5Y
 xPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776360937; x=1776965737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NbbsXIB2dT+ipJ5imq6uLP4HESZka3xMa5IMCnHweI=;
 b=B4jv/wm2GU6F1xOV/DZpSQGcrWIYulFRFqk7KYmA/qA9dDFHN9KbWr8jR1LOOAXN8D
 UbwUDInACIy1bvBTeQuR+kGISFF7k04H9l267vsuUQW7YYsR7XOusOSq2BjSe46q6Cg5
 NLEVKejUb90NwEDe3R3x1cpPYS5W4y2rG+AF+GXyoBo0n0z9lsT9skbFyR1Fw/yKDGlV
 Bb8VMETIaFx+iV2MovtgRDMLEbMyKopKJkxb/rwz3CtOLkBJFgb7wZtnRzUGjeLI88Ay
 OMYPmJiGOqXg+Utss8x58I5iiSNzcYw2fFzuMlCXGzGDcenEPhDaKwa5wFlYgKBZlHIQ
 DTGA==
X-Gm-Message-State: AOJu0YwjGOuCTR2+qnbo3vyhQ4veIWJgj7eXHk8d0VL5dIywpHWV8vXL
 Uvao+I68Daqjs0Kwpc8xnY8rMiwwU1Qx0oU30tqlD5qUD05EsXxPW60HKulhjb9p
X-Gm-Gg: AeBDievwoCHPBmHHjcXx696/SXMpodKXHiI5ehBepum34CMe8RxP8pD0wxISd4nDjDR
 1ASGO0UA5XnKCQwB6dfUUUIAVjTYbavIN8j3hBBDcnM9dc6q6NVbG+TOXVv6Qw/mT69ahtauMSG
 8S+oK+Nbm5AOt+59q8Xj0b+hcApjjYLlr55pkSGwiWcbbz5yZOUGT80JPJqa2ZXWrvZixbO4WiZ
 ccDi1DkVZhLMr1w1XXJU/fIhNrcpJOS9fEPbxcmQPW9iFTLIFm42MKznP8Psvw2H+nMLxLJ63i+
 DGTn+5kSoeW/QSGGJsB4Fg32F1kVBxO8Vz1Cyjk4jBZQ9LiOxYxAunGEHED/5f9nHHAxGl76JAI
 jXaeqTWVJUSKAln3OkOppnC9IWyNJ1XOdWFPT2C99OKOIPFnlx012wPQjgtPO2KnOmy9PWD0+AJ
 sD8Xo9ODaGHiPxEFRi/bMKJBPQMlrfDd6p8q8eLkk5BZkUN5saOxbs
X-Received: by 2002:a05:600d:d:b0:488:9e43:9690 with SMTP id
 5b1f17b1804b1-488d67dbf4amr291095435e9.10.1776360937227; 
 Thu, 16 Apr 2026 10:35:37 -0700 (PDT)
Received: from deb.cbu.edu.tr ([194.27.157.32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3e00b3sm14092796f8f.27.2026.04.16.10.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 10:35:36 -0700 (PDT)
From: rft0 <rafettaskindev@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, deller@gmx.de,
 rft0 <rafettaskindev@gmail.com>
Subject: [PATCH RFC] hw/scsi: Add SCSI tape device emulation
Date: Thu, 16 Apr 2026 20:34:48 +0300
Message-ID: <20260416173448.88831-1-rafettaskindev@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=rafettaskindev@gmail.com; helo=mail-wm1-x334.google.com
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

Add initial emulation of SCSI tape device supporting basic
INQUIRY operation for now.

Hi, I am a GSoC 2026 applicant and this is my first patch.
Any feedback or corrections appreciated.

Signed-off-by: rft0 <rafettaskindev@gmail.com>
---
 hw/scsi/meson.build |   1 +
 hw/scsi/scsi-tape.c | 334 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 335 insertions(+)
 create mode 100644 hw/scsi/scsi-tape.c

diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
index 69fde0cf84..1699b6e591 100644
--- a/hw/scsi/meson.build
+++ b/hw/scsi/meson.build
@@ -7,6 +7,7 @@ scsi_ss.add(files(
   'scsi-bus.c',
   'scsi-disk.c',
   'scsi-generic.c',
+  'scsi-tape.c',
 ))
 scsi_ss.add(when: 'CONFIG_ESP', if_true: files('esp.c'))
 scsi_ss.add(when: 'CONFIG_ESP_PCI', if_true: files('esp-pci.c'))
diff --git a/hw/scsi/scsi-tape.c b/hw/scsi/scsi-tape.c
new file mode 100644
index 0000000000..e457167649
--- /dev/null
+++ b/hw/scsi/scsi-tape.c
@@ -0,0 +1,334 @@
+/*
+ * SCSI Tape Device emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Written by Rafet Taskin <rafettaskindev@gmail.com>
+ *
+ * SCSI Tape device emulation.
+ *
+ */
+
+#include "qemu/hw-version.h"
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "qemu/memalign.h"
+#include "qemu/cutils.h"
+#include "hw/scsi/scsi.h"
+#include "scsi/constants.h"
+#include "system/block-backend.h"
+#include "hw/block/block.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "qom/object.h"
+
+#define SCSI_MAX_INQUIRY_LEN    256
+
+#define TYPE_SCSI_TAPE "scsi-tape"
+
+OBJECT_DECLARE_SIMPLE_TYPE(SCSITapeState, SCSI_TAPE)
+
+typedef struct SCSITapeReq {
+    SCSIRequest req;
+
+    uint32_t buflen;
+    struct iovec iov;
+
+    QEMUIOVector qiov;
+} SCSITapeReq;
+
+struct SCSITapeState {
+    SCSIDevice qdev;
+
+    char *vendor;
+    char *product;
+    char *version;
+    char *serial;
+};
+
+static void scsi_free_request(SCSIRequest *req)
+{
+    SCSITapeReq *r = DO_UPCAST(SCSITapeReq, req, req);
+
+    qemu_vfree(r->iov.iov_base);
+}
+
+static uint8_t *scsi_get_buf(SCSIRequest *req)
+{
+    SCSITapeReq *r = DO_UPCAST(SCSITapeReq, req, req);
+
+    return (uint8_t *)r->iov.iov_base;
+}
+
+static void scsi_init_iovec(SCSITapeReq *r, size_t size)
+{
+    if (!r->iov.iov_base) {
+        r->buflen = size;
+        r->iov.iov_base = qemu_memalign(qemu_real_host_page_size(), size);
+    }
+
+    r->iov.iov_len = size;
+    qemu_iovec_init_external(&r->qiov, &r->iov, 1);
+}
+
+static void scsi_check_condition(SCSITapeReq *r, SCSISense sense)
+{
+    scsi_req_build_sense(&r->req, sense);
+    scsi_req_complete(&r->req, CHECK_CONDITION);
+}
+
+static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
+{
+    SCSITapeState *s = DO_UPCAST(SCSITapeState, qdev, req->dev);
+    uint8_t page_code = req->cmd.buf[2];
+
+    outbuf[0] = TYPE_TAPE;
+    outbuf[1] = page_code;
+    outbuf[2] = 0x00;
+    outbuf[3] = 0x00;
+
+    switch (page_code) {
+    case 0x00: /* Supported VPD pages */
+        outbuf[4] = 0x00;   /* page 0x00 (this page) */
+        if (s->serial) {
+            outbuf[5] = 0x80;   /* page 0x80 (serial number) */
+            outbuf[3] = 2;      /* page data length */
+            return 6;
+        }
+        outbuf[3] = 1;
+        return 5;
+
+    case 0x80: /* Unit Serial Number */
+        if (!s->serial) {
+            return -1;   /* not supported, caller sends INVALID_FIELD */
+        }
+        {
+            int l = strlen(s->serial);
+            if (l > 36) {
+                l = 36;
+            }
+            outbuf[3] = l;
+            memcpy(&outbuf[4], s->serial, l);
+            return 4 + l;
+        }
+
+    default:
+        return -1;  /* unsupported VPD page */
+    }
+}
+
+static int scsi_tape_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
+{
+    SCSITapeState *s = DO_UPCAST(SCSITapeState, qdev, req->dev);
+    int buflen;
+
+    if (req->cmd.buf[1] & 0x1) {
+        return scsi_disk_emulate_vpd_page(req, outbuf);
+    }
+
+    /* Standard INQUIRY, not a VPD request */
+    if (req->cmd.buf[2] != 0) {
+        return -1;
+    }
+
+    /* PAGE_CODE == 0 */
+    buflen = req->cmd.xfer;
+    if (buflen > SCSI_MAX_INQUIRY_LEN) {
+        buflen = SCSI_MAX_INQUIRY_LEN;
+    }
+
+    outbuf[0] = TYPE_TAPE;      /* 0x01 = Tape */
+    outbuf[1] = 0x80;           /* Always removable */
+    outbuf[2] = 0x05;           /* SPC-3 */
+    outbuf[3] = 0x02 | 0x10;    /* Format 2, HiSup */
+
+    if (buflen > 36) {
+        outbuf[4] = buflen - 5;
+    } else {
+        outbuf[4] = 36 - 5;
+    }
+
+    outbuf[7] = 0x10 | (req->bus->info->tcq ? 0x02 : 0);
+
+    strpadcpy((char *)&outbuf[16], 16, s->product, ' ');
+    strpadcpy((char *)&outbuf[8], 8, s->vendor, ' ');
+
+    memset(&outbuf[32], 0, 4);
+    memcpy(&outbuf[32], s->version, MIN(4, strlen(s->version)));
+
+    return buflen;
+}
+
+/*
+ * > 0 - number of bytes from device to host
+ * < 0 - number of bytes from host to device
+ * = 0 - no data transfer, already completed
+ */
+static int32_t scsi_tape_emulate_command(SCSIRequest *req, uint8_t *buf)
+{
+    SCSITapeReq *r = DO_UPCAST(SCSITapeReq, req, req);
+    uint8_t *outbuf;
+    int32_t len = 0;
+    uint8_t command = buf[0];
+
+    if (req->cmd.xfer > 65536) {
+        scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
+        return 0;
+    }
+    r->buflen = MAX(4096, req->cmd.xfer);
+    scsi_init_iovec(r, r->buflen);
+
+    outbuf = r->iov.iov_base;
+    memset(outbuf, 0, r->buflen);
+
+    switch (command) {
+    case INQUIRY:
+        len = scsi_tape_emulate_inquiry(req, outbuf);
+        if (len < 0) {
+            scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
+            return 0;
+        }
+        break;
+
+    case TEST_UNIT_READY:
+        if (!blk_is_available(req->dev->conf.blk)) {
+            scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
+            return 0;
+        }
+
+        /* TODO: check if tape is really ready */
+        scsi_req_complete(&r->req, GOOD);
+        return 0;
+    case REQUEST_SENSE:
+        /* TODO: returning NO SENSE for now handle it later. */
+        /* 0x0: 0x70 = current errors, fixed format */
+        /* 0x2: sense key (0x00 = NO SENSE) */
+        /* 0x7: additional sense length */
+        {
+            int sense_len = MIN(buf[4], 18);
+            memset(outbuf, 0, sense_len);
+            outbuf[0] = 0x70;
+            outbuf[2] = 0x00;
+            outbuf[7] = 10;
+            len = sense_len;
+        }
+        break;
+
+    case REWIND:
+        if (!blk_is_available(req->dev->conf.blk)) {
+            scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
+            return 0;
+        }
+
+        /* TODO: reset tape position to beginning of SIMH image */
+        scsi_req_complete(&r->req, GOOD);
+        return 0;
+
+    /* Add rest later */
+    default:
+        scsi_check_condition(r, SENSE_CODE(INVALID_OPCODE));
+        return 0;
+    }
+
+    r->iov.iov_len = len;
+    return len;
+}
+
+
+/* TODO */
+static void scsi_tape_emulate_read_data(SCSIRequest *req)
+{
+    SCSITapeReq *r = DO_UPCAST(SCSITapeReq, req, req);
+    int buflen = r->iov.iov_len;
+
+    if (buflen) {
+        r->iov.iov_len = 0;
+        scsi_req_data(&r->req, buflen);
+        return;
+    }
+
+    scsi_req_complete(&r->req, GOOD);
+}
+
+/* TODO: not implemented yet */
+static void scsi_tape_emulate_write_data(SCSIRequest *req)
+{
+    scsi_req_complete(req, GOOD);
+}
+
+static const SCSIReqOps scsi_tape_reqops = {
+    .size         = sizeof(SCSITapeReq),
+    .free_req     = scsi_free_request,
+    .send_command = scsi_tape_emulate_command,
+    .read_data    = scsi_tape_emulate_read_data,
+    .write_data   = scsi_tape_emulate_write_data,
+    .get_buf      = scsi_get_buf,
+};
+
+static SCSIRequest *scsi_tape_new_request(SCSIDevice *d, uint32_t tag,
+                                          uint32_t lun, uint8_t *buf,
+                                          void *hba_private)
+{
+    return scsi_req_alloc(&scsi_tape_reqops, d, tag, lun, hba_private);
+}
+
+static void scsi_tape_realize(SCSIDevice *dev, Error **errp)
+{
+    SCSITapeState *s = DO_UPCAST(SCSITapeState, qdev, dev);
+
+    dev->type = TYPE_TAPE;
+
+    if (!s->qdev.conf.blk) {
+        error_setg(errp, "Drive property not set");
+        return;
+    }
+
+    if (!blk_is_inserted(s->qdev.conf.blk)) {
+        error_setg(errp, "Device needs media, but drive is empty");
+        return;
+    }
+
+    if (!s->vendor) {
+        s->vendor = g_strdup("QEMU");
+    }
+    if (!s->product) {
+        s->product = g_strdup("QEMU TAPE");
+    }
+    if (!s->version) {
+        s->version = g_strdup(QEMU_HW_VERSION);
+    }
+}
+
+static Property scsi_tape_properties[] = {
+    DEFINE_PROP_DRIVE("drive", SCSITapeState, qdev.conf.blk),
+    DEFINE_PROP_STRING("vendor", SCSITapeState, vendor),
+    DEFINE_PROP_STRING("product", SCSITapeState, product),
+    DEFINE_PROP_STRING("ver", SCSITapeState, version),
+    DEFINE_PROP_STRING("serial", SCSITapeState, serial),
+};
+
+static void scsi_tape_class_initfn(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SCSIDeviceClass *sc = SCSI_DEVICE_CLASS(klass);
+
+    sc->realize   = scsi_tape_realize;
+    sc->alloc_req = scsi_tape_new_request;
+    dc->desc      = "SCSI Tape";
+    device_class_set_props(dc, scsi_tape_properties);
+}
+
+static const TypeInfo scsi_tape_info = {
+    .name          = TYPE_SCSI_TAPE,
+    .parent        = TYPE_SCSI_DEVICE,
+    .instance_size = sizeof(SCSITapeState),
+    .class_init    = scsi_tape_class_initfn,
+};
+
+static void scsi_tape_register_types(void)
+{
+    type_register_static(&scsi_tape_info);
+}
+
+type_init(scsi_tape_register_types)
-- 
2.47.3


