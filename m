Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFEDE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 15:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSe2S-0001Uf-BM; Tue, 31 Dec 2024 10:20:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tSe2Q-0001Sv-Fa
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 10:20:06 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tSe2O-0004Gp-CI
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 10:20:06 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-21680814d42so116139765ad.2
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 07:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735658403; x=1736263203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ELuuWJBb1m79qHMRperTi1KM3Mna2yl7B0wFom8yxU=;
 b=j565AAu07Zc0EcGsMmXME/PPNoWpUVhJmP/nfbxmnXRSd24P/04EoG0yHHyd4dhs6Q
 1N1EWrDmU7P4q3D0JvDgzuvddQn+quIQkP88YsghMbonOLiVd0n3wmrqLRaJQ9K2HTsX
 oHNVpjel5/FSJ1X7/KpDxOhM5xQrIrz/LrThHW2LDC1dhllaUPXHZbrqaciHG8F1SDTm
 BvINQqxRxozYON3vlad84gyb+zYlVoIGxqnOp5EUhNwdU6h/gOsZkhSPU44S58GP1rtX
 JlYxm+XDe9a07i/Zdaqakdl5TVVtJ0DXnXRGc1wIsfbP7VF0ANmDZ3brwlnH0X2jUYjt
 ovTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735658403; x=1736263203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ELuuWJBb1m79qHMRperTi1KM3Mna2yl7B0wFom8yxU=;
 b=vES/AksXUlgQbTtGtvBFO2zyKEcorRAZNkyxwmJ/QFGacomxYvNcTKdcIQfSPpj4xP
 KluhWpgT7jGW1KlqgM8AGktcVD8YnSppmJE+InIAkq6eEfQePabt+XlIRwyfCbXnqz+5
 mCJqFAih7gcM9WdrSmp6uK+Mw2WTAy7kLeKOAnRwNo0rgxkoa8I7ItjR/wkV4YUOA7/i
 Zqbv4P03uROLkV5eFjzPeOSNU6yRLN6dgthAGEAT7yb1e+9RCvue8fmjepkhI58Y1xU3
 O5LjsEEvIgrWIEIkrGo7+m6si3f2VbQozYZgtHT9NhNyaFYr2+tmWZ/zp//+0tvK60n9
 qgDw==
X-Gm-Message-State: AOJu0YzXJr2dRuNV2pK6+pbJ79Mg2PgJ6aRoKDvt70byemRmnyMLE0tO
 2EWNDiHtPDCMpwMKm4K01iA3pDX1le0+cTp1vVq5HuA15zuQh/+irOPUzM0VUQ==
X-Gm-Gg: ASbGncv2ApKzcPb182Yy07rD1MvaNXQApH3Xj1W438lFiEvSfbiXnwwUFGX23vtSV//
 97jnRS1wUggk5bAigW2F9M5PFHOp26/BbU44+4Oa6sVwMvyPX34R5MRdI2AGDF7sWK8vOXgMSQd
 N9b+BDxho4vqqpjm2QvqXYBoQCH04tX1qukiyBzLJLvEQ3aaGZHgtZkQbc+3kNlLBHryREbqItV
 hhQM0rTWPpMsTCdrupQp2ybYHi5DGlQ52RXxCF/ri9pypF3uzuNlKUFbKuD1FvusirkKA==
X-Google-Smtp-Source: AGHT+IFZmmF+DgEPzdsm5Q5nKA+WRY2BiWdaX9aC4/RGyM0Y8kSkqt0qmDPuMjusdXvd3Ywtpsf0OA==
X-Received: by 2002:a05:6a00:3cc2:b0:725:90f9:daf9 with SMTP id
 d2e1a72fcca58-72abdefa86emr44106006b3a.15.1735658402652; 
 Tue, 31 Dec 2024 07:20:02 -0800 (PST)
Received: from localhost.localdomain ([58.38.120.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309e8sm20933481b3a.43.2024.12.31.07.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 07:20:02 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 1/3] vfio/pci: declare generic quirks in a new header file
Date: Tue, 31 Dec 2024 23:19:51 +0800
Message-ID: <20241231151953.59992-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241231151953.59992-1-tomitamoeko@gmail.com>
References: <20241231151953.59992-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
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

Declare generic vfio_generic_{window_address,window_data,mirror}_quirk
in newly created pci_quirks.h so that they can be used elsewhere, like
igd.c.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/pci-quirks.c | 59 ++++--------------------------------
 hw/vfio/pci-quirks.h | 71 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 53 deletions(-)
 create mode 100644 hw/vfio/pci-quirks.h

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index c8e60475d5..bb2ce1d904 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -25,6 +25,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/qdev-properties.h"
 #include "pci.h"
+#include "pci-quirks.h"
 #include "trace.h"
 
 /*
@@ -66,40 +67,6 @@ bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev)
  * Device specific region quirks (mostly backdoors to PCI config space)
  */
 
-/*
- * The generic window quirks operate on an address and data register,
- * vfio_generic_window_address_quirk handles the address register and
- * vfio_generic_window_data_quirk handles the data register.  These ops
- * pass reads and writes through to hardware until a value matching the
- * stored address match/mask is written.  When this occurs, the data
- * register access emulated PCI config space for the device rather than
- * passing through accesses.  This enables devices where PCI config space
- * is accessible behind a window register to maintain the virtualization
- * provided through vfio.
- */
-typedef struct VFIOConfigWindowMatch {
-    uint32_t match;
-    uint32_t mask;
-} VFIOConfigWindowMatch;
-
-typedef struct VFIOConfigWindowQuirk {
-    struct VFIOPCIDevice *vdev;
-
-    uint32_t address_val;
-
-    uint32_t address_offset;
-    uint32_t data_offset;
-
-    bool window_enabled;
-    uint8_t bar;
-
-    MemoryRegion *addr_mem;
-    MemoryRegion *data_mem;
-
-    uint32_t nr_matches;
-    VFIOConfigWindowMatch matches[];
-} VFIOConfigWindowQuirk;
-
 static uint64_t vfio_generic_window_quirk_address_read(void *opaque,
                                                        hwaddr addr,
                                                        unsigned size)
@@ -135,7 +102,7 @@ static void vfio_generic_window_quirk_address_write(void *opaque, hwaddr addr,
     }
 }
 
-static const MemoryRegionOps vfio_generic_window_address_quirk = {
+const MemoryRegionOps vfio_generic_window_address_quirk = {
     .read = vfio_generic_window_quirk_address_read,
     .write = vfio_generic_window_quirk_address_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
@@ -178,26 +145,12 @@ static void vfio_generic_window_quirk_data_write(void *opaque, hwaddr addr,
                       addr + window->data_offset, data, size);
 }
 
-static const MemoryRegionOps vfio_generic_window_data_quirk = {
+const MemoryRegionOps vfio_generic_window_data_quirk = {
     .read = vfio_generic_window_quirk_data_read,
     .write = vfio_generic_window_quirk_data_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-/*
- * The generic mirror quirk handles devices which expose PCI config space
- * through a region within a BAR.  When enabled, reads and writes are
- * redirected through to emulated PCI config space.  XXX if PCI config space
- * used memory regions, this could just be an alias.
- */
-typedef struct VFIOConfigMirrorQuirk {
-    struct VFIOPCIDevice *vdev;
-    uint32_t offset;
-    uint8_t bar;
-    MemoryRegion *mem;
-    uint8_t data[];
-} VFIOConfigMirrorQuirk;
-
 static uint64_t vfio_generic_quirk_mirror_read(void *opaque,
                                                hwaddr addr, unsigned size)
 {
@@ -228,7 +181,7 @@ static void vfio_generic_quirk_mirror_write(void *opaque, hwaddr addr,
                                           addr, data);
 }
 
-static const MemoryRegionOps vfio_generic_mirror_quirk = {
+const MemoryRegionOps vfio_generic_mirror_quirk = {
     .read = vfio_generic_quirk_mirror_read,
     .write = vfio_generic_quirk_mirror_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
@@ -1499,7 +1452,7 @@ static void get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
 {
-    const Property *prop = opaque;
+    Property *prop = opaque;
     uint8_t *ptr = object_field_prop_ptr(obj, prop);
 
     visit_type_uint8(v, name, ptr, errp);
@@ -1509,7 +1462,7 @@ static void set_nv_gpudirect_clique_id(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
 {
-    const Property *prop = opaque;
+    Property *prop = opaque;
     uint8_t value, *ptr = object_field_prop_ptr(obj, prop);
 
     if (!visit_type_uint8(v, name, &value, errp)) {
diff --git a/hw/vfio/pci-quirks.h b/hw/vfio/pci-quirks.h
new file mode 100644
index 0000000000..c0e96a01cc
--- /dev/null
+++ b/hw/vfio/pci-quirks.h
@@ -0,0 +1,71 @@
+/*
+ * vfio generic region quirks (mostly backdoors to PCI config space)
+ *
+ * Copyright Red Hat, Inc. 2012-2015
+ *
+ * Authors:
+ *  Alex Williamson <alex.williamson@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+#ifndef HW_VFIO_VFIO_PCI_QUIRKS_H
+#define HW_VFIO_VFIO_PCI_QUIRKS_H
+
+#include "qemu/osdep.h"
+#include "exec/memop.h"
+
+/*
+ * The generic window quirks operate on an address and data register,
+ * vfio_generic_window_address_quirk handles the address register and
+ * vfio_generic_window_data_quirk handles the data register.  These ops
+ * pass reads and writes through to hardware until a value matching the
+ * stored address match/mask is written.  When this occurs, the data
+ * register access emulated PCI config space for the device rather than
+ * passing through accesses.  This enables devices where PCI config space
+ * is accessible behind a window register to maintain the virtualization
+ * provided through vfio.
+ */
+typedef struct VFIOConfigWindowMatch {
+    uint32_t match;
+    uint32_t mask;
+} VFIOConfigWindowMatch;
+
+typedef struct VFIOConfigWindowQuirk {
+    struct VFIOPCIDevice *vdev;
+
+    uint32_t address_val;
+
+    uint32_t address_offset;
+    uint32_t data_offset;
+
+    bool window_enabled;
+    uint8_t bar;
+
+    MemoryRegion *addr_mem;
+    MemoryRegion *data_mem;
+
+    uint32_t nr_matches;
+    VFIOConfigWindowMatch matches[];
+} VFIOConfigWindowQuirk;
+
+extern const MemoryRegionOps vfio_generic_window_address_quirk;
+extern const MemoryRegionOps vfio_generic_window_data_quirk;
+
+/*
+ * The generic mirror quirk handles devices which expose PCI config space
+ * through a region within a BAR.  When enabled, reads and writes are
+ * redirected through to emulated PCI config space.  XXX if PCI config space
+ * used memory regions, this could just be an alias.
+ */
+typedef struct VFIOConfigMirrorQuirk {
+    struct VFIOPCIDevice *vdev;
+    uint32_t offset;
+    uint8_t bar;
+    MemoryRegion *mem;
+    uint8_t data[];
+} VFIOConfigMirrorQuirk;
+
+extern const MemoryRegionOps vfio_generic_mirror_quirk;
+
+#endif /* HW_VFIO_VFIO_PCI_QUIRKS_H */
-- 
2.45.2


