Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66E8C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAdO-00062v-Dk; Tue, 12 Mar 2024 18:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAc6-0002pt-Tq
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbz-0004b4-Px
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uqNCLYNUFKo35EsbQeEwK2046y6pYoTM2WTmQ8XGtVc=;
 b=bW61fXtJUwJ3TPMd1wE/r5o2/CCdKLz5SvOC/DXFJD0I7Y3I0/aT2eay6xpY3XmIAU+VeX
 DBC/OLNyWRkHoEi9hshfQWSWwxq5lSZ0CbjJfPDC/eEiK/jrYLVlavb3LwL7UPtUvDIwJ1
 Lj/emQH6MVkk48e9R9V7NT86z9K/SeQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-dejjTPj8PBipPYfHgC-W2Q-1; Tue, 12 Mar 2024 18:28:41 -0400
X-MC-Unique: dejjTPj8PBipPYfHgC-W2Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a448cfe2266so494065866b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282520; x=1710887320;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uqNCLYNUFKo35EsbQeEwK2046y6pYoTM2WTmQ8XGtVc=;
 b=u7J9UqDd2MZQ5SgPn+JpC0lmQ0DYhmDWSzB7x3mwH4nkPucmMdygorIQa/pST8+slt
 T3gB8h/ebEcsQZQR0QuauEjZmUiUiI1ijeUnMWqVsYtPQzEatyvteCqj3Lq+JrM2R2w6
 O+bu0DzABT1yCo8q/jo8yiuSIMPC8k0h3TdaB8WuVz8C82qrD7/rp1KiWCG97SHpCfER
 N6R6n6C9vJG16YbHc9/P/x0/B5vPhh92rGWHFS1vETRxUKRnDhxJRBm02xX+S2Y8sIAv
 zHSdXlEWtrmmiuiAspEzZkXLE+2Kl+Ha5k18zpV9QmcrhPsXExftXqyMXRT1TXzghIyp
 CX+A==
X-Gm-Message-State: AOJu0YwmOvLP8Dph7uUsOjZXDn9kxVdnGlcr9Kzh4OA1ZFOCJwMyIEJv
 KnCanPfuJPhff8VSJTj4mp+4PttXtVa2u69TVRZ/Hp64aXBcNtjiRdkuMlPFyunda7UGXTjZ5cd
 0b604wIa/2PtkDkVcpAtGB5mtjyiAnnvcopZokor7uX0NtRSMJ1H1CpsdGtEkWB4vuWAnLu9oHK
 PmK5Vg6gtMZFaWkBh5tW0HCWLmpEVB89xD
X-Received: by 2002:a17:907:a0ce:b0:a45:ed7f:265c with SMTP id
 hw14-20020a170907a0ce00b00a45ed7f265cmr9062359ejc.0.1710282519585; 
 Tue, 12 Mar 2024 15:28:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/S/BqBM2V7Jrt2QdHmO7PZKEbCOG4ZawwTRy9y4f2ruoDpWpdeaAnfaxeyxperd+aZE7hBA==
X-Received: by 2002:a17:907:a0ce:b0:a45:ed7f:265c with SMTP id
 hw14-20020a170907a0ce00b00a45ed7f265cmr9062346ejc.0.1710282519093; 
 Tue, 12 Mar 2024 15:28:39 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 h16-20020a1709067cd000b00a45f63d2959sm4221145ejp.210.2024.03.12.15.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:38 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 57/68] virtio-iommu: Add a granule property
Message-ID: <294ac5fef3aa78111de07357734285744103f47c.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

This allows to choose which granule will be used by
default by the virtio-iommu. Current page size mask
default is qemu_target_page_mask so this translates
into a 4k granule on ARM and x86_64 where virtio-iommu
is supported.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Message-Id: <20240307134445.92296-3-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-iommu.h |  2 ++
 hw/virtio/virtio-iommu.c         | 28 +++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 781ebaea8f..67ea5022af 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -24,6 +24,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/pci/pci.h"
 #include "qom/object.h"
+#include "qapi/qapi-types-virtio.h"
 
 #define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
 #define TYPE_VIRTIO_IOMMU_PCI "virtio-iommu-pci"
@@ -66,6 +67,7 @@ struct VirtIOIOMMU {
     bool boot_bypass;
     Notifier machine_done;
     bool granule_frozen;
+    GranuleMode granule_mode;
 };
 
 #endif
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 86623d55a5..84d6819d3b 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -29,6 +29,7 @@
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "qemu/reserved-region.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "trace.h"
@@ -1115,8 +1116,8 @@ static int virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
 }
 
 /*
- * The default mask (TARGET_PAGE_MASK) is the smallest supported guest granule,
- * for example 0xfffffffffffff000. When an assigned device has page size
+ * The default mask depends on the "granule" property. For example, with
+ * 4k granule, it is -(4 * KiB). When an assigned device has page size
  * restrictions due to the hardware IOMMU configuration, apply this restriction
  * to the mask.
  */
@@ -1313,8 +1314,27 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
      * in vfio realize
      */
     s->config.bypass = s->boot_bypass;
-    s->config.page_size_mask = qemu_target_page_mask();
     s->config.input_range.end = UINT64_MAX;
+
+    switch (s->granule_mode) {
+    case GRANULE_MODE_4K:
+        s->config.page_size_mask = -(4 * KiB);
+        break;
+    case GRANULE_MODE_8K:
+        s->config.page_size_mask = -(8 * KiB);
+        break;
+    case GRANULE_MODE_16K:
+        s->config.page_size_mask = -(16 * KiB);
+        break;
+    case GRANULE_MODE_64K:
+        s->config.page_size_mask = -(64 * KiB);
+        break;
+    case GRANULE_MODE_HOST:
+        s->config.page_size_mask = qemu_real_host_page_mask();
+        break;
+    default:
+        error_setg(errp, "Unsupported granule mode");
+    }
     s->config.domain_range.end = UINT32_MAX;
     s->config.probe_size = VIOMMU_PROBE_SIZE;
 
@@ -1522,6 +1542,8 @@ static Property virtio_iommu_properties[] = {
     DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
                      TYPE_PCI_BUS, PCIBus *),
     DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
+    DEFINE_PROP_GRANULE_MODE("granule", VirtIOIOMMU, granule_mode,
+                             GRANULE_MODE_4K),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
MST


