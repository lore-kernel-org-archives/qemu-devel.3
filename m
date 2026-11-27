Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033E7606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V7OMnHXR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX4XW-0000OC-In; Fri, 27 Nov 2026 17:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleszlucero@gmail.com>)
 id 1xX4XU-0000Kv-Sw
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 17:35:32 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleszlucero@gmail.com>)
 id 1xX4XT-0008So-3c
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 17:35:32 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3b3d4d3bba3so4201120a91.3
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 14:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795818930; x=1796423730; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vvf+mn+5pB9P/zNGPpCeuOO6ANmRnZp8Rsip/AM57eE=;
 b=V7OMnHXRJ8DMIXcyXiCdH1h7gBDTfVU+puNF7bfl9+m56QF9K2QLnAG3wDpZ8QsxNA
 SSFqeKuyXNXSVP4YeLMdvhk8rknCasd/mrxIcJmGUkM6ylyUKPBb7LmV+3omex+5H4g7
 3dxuLI/8AFuiwHO2TKyk/WTyYn/iaPEU2Zx4zJGhi8ZocjvkmnrbDJpi4s++qFfo4Y/l
 kPhq6F9AIJ2vwkgeifY9BrZEkLPr5Kx+yGplNwZTizse9h8SA9ow24+J1RAdn5jYw6E/
 wouaibhf22AhX72WuYNQOf4c/XucDTas9xs6/IDRa0oJnrmZCyNcDS+6gqjYX96gUFwb
 3COg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795818930; x=1796423730;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vvf+mn+5pB9P/zNGPpCeuOO6ANmRnZp8Rsip/AM57eE=;
 b=hNz8sRxh8XkgDafYK7ussNuAhWbxF1msvECOOUl8GZLX0MjpS+B0iU2w+dMnZwQQV3
 iPkiid5I7vGJvTrhFRQ7UQnqw8zYHH5zKWpVHXmQPvtQV5ULgrxicSKjEdPbNvxCdPEO
 k7z3uhsUP5jk0MSW+ftHnwMekbk+xRPgygY6mLXHo3/m8R8MjjTzU+ikw0yVjI40nMKr
 C9yQfNyk4C3Pgxjq0AQDOg8w4sfBucbmaS0MWw6KZDeZUPYWF1Og/crE/mSoPNyLYfyb
 UrbY0BfvB8wSAk5K+BpfCNs+HmFvXIlQMYhFm0C83n2dLvEYq563QvkRsC3D0B6lNH3+
 2Olw==
X-Gm-Message-State: APuU4Z/a8GcRbCcwwtpnjgNDmPD91M1zsiu0uOnbPKFtlMb0X7IZgvve
 G8zZZRtjbTnjycB4MZCtiUMxdhAFWGanSa34yPv4G1Tb5ZZvf+obYYobQYV7prweW0Y=
X-Gm-Gg: AZFdTZdO4db0yN+G0b0Vbhup0LFDHmMQnThDsSHDSjlxUAMNm9df3tqX1F1oztR2hun
 RNC9iuVT50aPo8L+HhMpxH7fEDllXGVcPvrCUBcHHB3dWmZYGzOWFjlPfrBoabIG/7Y/aRPPdxg
 StpVAfVjowjYNwucCy7aXLnjXxGTbrBky9v8rOLjtrCh96jLBFoj3AlEKiXVsRTsnaUnnFXkbHm
 17RULrZeTBp46HU5izLNALp8Z9FoaqI0NR7CTJiCcQWy4SxqNtw4SVzZ1jxOoekv9ZisHNpLnGF
 h0QsV2W2DBsbW8iukGzOX4E+REl48OjaUN6sLa3bu8FIXE0LXcY1hPj3iaWcOm1nccTC8Ehf02/
 +0dcYEEUQe0QlEfat/JoZ9ir6k1zx4LGozuWvCE/xAG7Ae5bXrgn2c6qqBoIRhA13MsCPP/LEe9
 qcPovRcRSUslno6pHhssMgS0C0pVB+3hlxTbQ/UbimwcXG2+YOJ0ps80MbxEnqx/MzP39ZtHdOv
 HS0yLXLACV3YgdZz4RarZkPfgDShBfrsX9ufW1XkR4S5JHBKmakJXpV6h7YnjA0ySwuUdXdc6ZT
 gWiG+xDih2WmcT/t7PTz6T9i6VeLBzLPI2xud0f8P4znzlLubRRJr7alCRlMpLxX8QfIEwjdETW
 zCpjGHn8jqNMZ+tbS6qOmX/m+jIanBnc=
X-Received: by 2002:a17:90b:3d4d:b0:3ac:7556:8eed with SMTP id
 98e67ed59e1d1-3b41c956552mr22877943a91.44.1795818929607; 
 Fri, 27 Nov 2026 14:35:29 -0800 (PST)
Received: from cfarm136.osuosl.org (cfarm136.osuosl.org.
 [2605:bc80:3010:104:21e:67ff:fefd:7034])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41ad0b2c4sm39880831a91.4.2026.11.27.14.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 14:35:29 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Date: Fri, 27 Nov 2026 22:35:17 +0000
Subject: [PATCH 3/4] hw/pci-bridge: Convert xio3130_downstream to
 Resettable interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261127-pci-bridge-resettable-v1-3-cdf15c9252c5@gmail.com>
References: <20261127-pci-bridge-resettable-v1-0-cdf15c9252c5@gmail.com>
In-Reply-To: <20261127-pci-bridge-resettable-v1-0-cdf15c9252c5@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=aleszlucero@gmail.com; helo=mail-pj1-x102e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the deprecated device_class_set_legacy_reset() in
xio3130_downstream.c with the ResettableClass hold phase.

Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
 hw/pci-bridge/xio3130_downstream.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index ded948e..81893e6 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -25,6 +25,7 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/core/qdev-properties.h"
+#include "hw/core/resettable.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
@@ -53,14 +54,14 @@ static void xio3130_downstream_write_config(PCIDevice *d, uint32_t address,
     pcie_aer_write_config(d, address, val, len);
 }
 
-static void xio3130_downstream_reset(DeviceState *qdev)
+static void xio3130_downstream_reset_hold(Object *obj, ResetType type)
 {
-    PCIDevice *d = PCI_DEVICE(qdev);
+    PCIDevice *d = PCI_DEVICE(obj);
 
     pcie_cap_deverr_reset(d);
     pcie_cap_slot_reset(d);
     pcie_cap_arifwd_reset(d);
-    pci_bridge_reset(qdev);
+    pci_bridge_reset(DEVICE(obj));
 }
 
 static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
@@ -157,6 +158,7 @@ static void xio3130_downstream_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     k->config_write = xio3130_downstream_write_config;
     k->realize = xio3130_downstream_realize;
@@ -166,7 +168,7 @@ static void xio3130_downstream_class_init(ObjectClass *klass, const void *data)
     k->revision = XIO3130_REVISION;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "TI X3130 Downstream Port of PCI Express Switch";
-    device_class_set_legacy_reset(dc, xio3130_downstream_reset);
+    rc->phases.hold = xio3130_downstream_reset_hold;
     dc->vmsd = &vmstate_xio3130_downstream;
     device_class_set_props(dc, xio3130_downstream_props);
 }

-- 
2.53.0


