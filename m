Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E0BCD484C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 02:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMziK-0000oT-8D; Tue, 12 May 2026 22:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuelugwu121@gmail.com>)
 id 1wMziG-0000o6-Fd
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:52:46 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <emmanuelugwu121@gmail.com>)
 id 1wMziA-0006Wo-Pp
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:52:44 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488d2079582so65186585e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 19:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778640756; x=1779245556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0il8I1NSzjBevH0Q82iW8yc77Cdpz3zXMtMMq2hRGjQ=;
 b=JBzcsPNnyAjn/O3HxeE4yKq+UKKHNOrsukR4f1CVYXcL6YvV1b/UzmjwPBWF7HNc8/
 WIgRZ/2KIUCdz4xMEJkPrLpWvwt8UTw+mFEK16ekcoMFVVPONum7DC0uwbzAl+ncr3ZC
 aq4p6G6vGPfPzzSqc5oUOBg0A2lh6J+4/OuMiNdP+lqyxSevtBN7W6VTl90ZdMqOHWMm
 Axn73p5lfTO6L+75V/WPFFmyR6DRxlTyqPiGGcP9roY+qb9ZRWlGnpYWifNoYVs7zwcm
 FJDPP4tRnd5uTogLuHDE9slzQmFtKag7S+Cbn7aDW3OE5B1ZWIQsqe+j+7LHIdTwOYGF
 qg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778640756; x=1779245556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0il8I1NSzjBevH0Q82iW8yc77Cdpz3zXMtMMq2hRGjQ=;
 b=hfNxN3xBC52rCfTaluNtet6pXKze8GYK/QhVaTt49qCKX2c75gZ9d1bDt0C7qSdpis
 YiSX/C6wjjYJd7lbk2BOGEb3i/YGFw+EfXH5qRiqdAmBIyPkvLxuf7tgYJ3QQWGAgFf+
 zwfRKgZBNBb3LsJQHAsSRXnthm+rwwGWrzNpEyR84AIouAEEqTd70T9NngMGgoy10rbY
 hJznH71aHBgu/K/Gfe9HEuOGdluyAa2RyZTFa664mgYKlxFNhgIVI0icKhWpmwrmu3e6
 lMoDIOi9H24OvLk3rySqE9xth2wK0raYKODRRCxSfgktfm4aasAMzXQkFIew95AqxzB3
 y3TQ==
X-Gm-Message-State: AOJu0Yz1pjY3ydxtI5+VGrZ02FjOyzkWxMYq2dAuzRAoxobuM6JGyhxz
 lqxWcYkYjC/QXVRtyX8HA37zdrE8aI/ItH7K7rsxySQX2BCZHHMhM24U4YZ0Rr2Q2IYZkQ==
X-Gm-Gg: Acq92OGVHEdEWriQ8oWL6kDdwwYi84n06O0Sxmp34YpaOdmOMh1WrawolH+wKP0B0hh
 OcEl05Po5X8jbqv7fXcQbOQj7F/Edg0uAb5P3DmgfrQ5bcJQs0YQrO6h0pfHM3AGaRg0/ddxtrb
 VDHg2cLYF2m2clfADe1fK72BYt/XLlVsYh86ii7NCA9BDQCiqc2c4myqEtA5R1d/aubykVo93gy
 l6zUo1PGefh32q/IO516b0gYwT/yIwN1lpjs3LcEVJDQWtz52vsW1TO3YGP1b7DbS2fmR7X/K9V
 zgJn1NThgYkagP2muwt16DetvVzGQdDFWATQTjTipC/PCCXMNweUHFag0EHnEUtdmivhrHV5/43
 rJ2oZMg/eMJBmlZ9AxuqUZOpzIH6kSMt4fNhAJvRB+bgz2B8C0rWlDEOrgvlc7nsHEwbxvsBGdl
 UCF3M1xY/o2nouUJVtRaPyHX8JEbA=
X-Received: by 2002:a05:6000:1acc:b0:43d:7af0:3a7c with SMTP id
 ffacd0b85a97d-45c7a4ef3e4mr1185447f8f.29.1778640755832; 
 Tue, 12 May 2026 19:52:35 -0700 (PDT)
Received: from fedora ([197.211.52.69]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45c7f27762csm1592380f8f.31.2026.05.12.19.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 19:52:34 -0700 (PDT)
From: kantnero <emmanuelugwu121@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, deller@gmx.de,
 kantnero <emmanuelugwu121@gmail.com>
Subject: [PATCH 1/1] hw/scsi: add initial SCSI tape device emulation
Date: Wed, 13 May 2026 03:44:54 +0100
Message-ID: <20260513024454.75840-2-emmanuelugwu121@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513024454.75840-1-emmanuelugwu121@gmail.com>
References: <20260513024454.75840-1-emmanuelugwu121@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=emmanuelugwu121@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL=0.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add a new scsi-tape device that attaches to a VirtIO SCSI bus.
Implements realize and unrealize lifecycle only. SCSI command
handling will follow in subsequent patches.

Signed-off-by: Emmanuel Ugwu <emmanuelugwu121@gmail.com>
Signed-off-by: kantnero <emmanuelugwu121@gmail.com>
---
 hw/scsi/meson.build |   1 +
 hw/scsi/scsi-tape.c | 221 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 222 insertions(+)
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
index 0000000000..650f75471f
--- /dev/null
+++ b/hw/scsi/scsi-tape.c
@@ -0,0 +1,221 @@
+/*
+ *  SCSI Tape Device Emulation
+ *
+ *  Copyright (c) Emmanuel Ugwu <emmanuelugwu121@gmail.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/scsi/scsi.h"
+#include "qemu/hw-version.h"
+#include "qemu/memalign.h"
+#include "scsi/constants.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "system/block-backend.h"
+#include "qemu/cutils.h"
+#include "qom/object.h"
+
+
+
+#define MAX_SERIAL_LEN           36
+#define MAX_SERIAL_LEN_FOR_DEVID 20
+#define TYPE_SCSI_TAPE_BASE      "scsi-tape"
+
+OBJECT_DECLARE_TYPE(SCSITapeState, SCSITapeClass, SCSI_TAPE_BASE)
+
+typedef struct SCSITapeClass {
+    SCSIDeviceClass parent_class;
+} SCSITapeClass;
+
+
+typedef struct SCSITapeReq {
+    SCSIRequest req;
+    struct iovec iov;
+    uint32_t buflen;
+    QEMUIOVector qiov;
+    BlockAcctCookie acct;
+} SCSITapeReq;
+
+typedef struct SCSITapeState {
+    SCSIDevice qdev;
+    uint32_t position;
+    bool at_filemark;
+    bool eof;
+    bool bot;
+    bool eot;
+    char *vendor;
+    char *version;
+    char *serial;
+    char *product;
+    char *device_id;
+} SCSITapeState;
+
+
+
+/*
+ * scsi_free_request() will be enabled once scsi_init_iovec() is
+ * implemented. It frees the buffer allocated by qemu_memalign().
+ * static void scsi_free_request(SCSIRequest *req)
+ * {
+ *     SCSITapeReq *r = DO_UPCAST(SCSITapeReq, req, req);
+ *     static void scsi_free_request(SCSIRequest *req)
+ * {
+ *     SCSITapeReq *r = DO_UPCAST(SCSITapeReq, req, req);
+ *     qemu_vfree(r->iov.iov_base);
+ * }
+ */
+
+/* TODO: finish implementation for testing realize function for now */
+static int32_t scsi_tape_send_command(SCSIRequest *req, uint8_t *buf)
+{
+    scsi_req_complete(req, GOOD);
+    return 0;
+}
+
+/*TODO: Add elements when commands are implemented*/
+static const SCSIReqOps *const scsi_tape_reqops_dispatch[256] = {
+
+};
+static const SCSIReqOps scsi_tape_emulate_reqops = {
+    .size         = sizeof(SCSITapeReq),
+    /* required to test if tape is detected by QEMU*/
+    .send_command = scsi_tape_send_command
+};
+
+
+static SCSIRequest *scsi_tape_new_request(SCSIDevice *dev, uint32_t tag,
+                                          uint32_t lun, uint8_t *buf,
+                                          void *hba_private)
+{
+    SCSITapeState *s = DO_UPCAST(SCSITapeState, qdev, dev);
+    SCSIRequest *req;
+    const SCSIReqOps *ops = scsi_tape_reqops_dispatch[buf[0]];
+    if (!ops) {
+        ops = &scsi_tape_emulate_reqops;
+    }
+    req = scsi_req_alloc(ops, &s->qdev, tag, lun, hba_private);
+
+    return req;
+}
+
+static void scsi_tape_init(SCSITapeState *s)
+{
+    s->position = 0;
+    s->at_filemark = false;
+    s->eof = false;
+    s->bot = true;
+    s->eot = false;
+}
+
+
+
+static void scsi_tape_realize(SCSIDevice *dev, Error **errp)
+{
+    SCSITapeState *s = DO_UPCAST(SCSITapeState, qdev, dev);
+
+    s->qdev.type = TYPE_TAPE;
+
+    if (!s->qdev.conf.blk) {
+        error_setg(errp, "drive property not set");
+        return;
+    }
+
+    if (!blk_attach_dev(s->qdev.conf.blk, &dev->qdev)) {
+        error_setg(errp, "failed to attach block backend");
+        return;
+    }
+
+    if (!s->vendor) {
+        s->vendor = g_strdup("QEMU TAPE");
+    }
+    if (!s->version) {
+        s->version = g_strdup(QEMU_HW_VERSION);
+    }
+
+    if (s->serial && strlen(s->serial) > MAX_SERIAL_LEN) {
+        error_setg(errp, "The serial number can't be longer than %d characters",
+                   MAX_SERIAL_LEN);
+        goto fail;
+    }
+
+    if (!s->device_id) {
+        if (s->serial) {
+            if (strlen(s->serial) > MAX_SERIAL_LEN_FOR_DEVID) {
+                error_setg(errp, "The serial number can't be longer than %d "
+                           "characters when it is also used as the default for "
+                           "device_id", MAX_SERIAL_LEN_FOR_DEVID);
+                goto fail;
+            }
+            s->device_id = g_strdup(s->serial);
+        }
+    }
+
+    scsi_tape_init(s);
+    return;
+
+fail:
+    g_free(s->vendor);
+    s->vendor = NULL;
+    g_free(s->version);
+    s->version = NULL;
+    blk_detach_dev(s->qdev.conf.blk, &dev->qdev);
+}
+
+static void scsi_tape_unrealize(SCSIDevice *dev)
+{
+    SCSITapeState *s = DO_UPCAST(SCSITapeState, qdev, dev);
+
+    g_free(s->vendor);
+    g_free(s->serial);
+    g_free(s->product);
+    g_free(s->device_id);
+    g_free(s->version);
+    if (s->qdev.conf.blk) {
+        blk_detach_dev(s->qdev.conf.blk, &dev->qdev);
+    }
+}
+
+#define DEFINE_SCSI_TAPE_PROPERTIES()                                   \
+    DEFINE_PROP_DRIVE_IOTHREAD("drive", SCSITapeState, qdev.conf.blk),  \
+    DEFINE_BLOCK_PROPERTIES_BASE(SCSITapeState, qdev.conf),             \
+    DEFINE_BLOCK_ERROR_PROPERTIES(SCSITapeState, qdev.conf),            \
+    DEFINE_PROP_STRING("ver", SCSITapeState, version),                  \
+    DEFINE_PROP_STRING("serial", SCSITapeState, serial),                \
+    DEFINE_PROP_STRING("vendor", SCSITapeState, vendor),                \
+    DEFINE_PROP_STRING("product", SCSITapeState, product),              \
+    DEFINE_PROP_STRING("device_id", SCSITapeState, device_id)
+
+static const Property scsi_tape_properties[] = {
+        DEFINE_SCSI_TAPE_PROPERTIES(),
+};
+static void scsi_tape_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SCSIDeviceClass *sc = SCSI_DEVICE_CLASS(klass);
+
+    sc->realize   = scsi_tape_realize;
+    sc->unrealize = scsi_tape_unrealize;
+    sc->alloc_req = scsi_tape_new_request;
+    dc->desc = "virtual SCSI tape";
+    device_class_set_props(dc, scsi_tape_properties);
+}
+static const TypeInfo scsi_tape_info = {
+    .name          = TYPE_SCSI_TAPE_BASE,
+    .parent        = TYPE_SCSI_DEVICE,
+    .instance_size = sizeof(SCSITapeState),
+    .class_size    = sizeof(SCSITapeClass),
+    .class_init    = scsi_tape_class_init,
+};
+
+static void scsi_tape_register_types(void)
+{
+    type_register_static(&scsi_tape_info);
+}
+
+type_init(scsi_tape_register_types)
+
-- 
2.54.0


