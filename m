Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873AEC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSJ9-0004wo-MN; Mon, 14 Jul 2025 19:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHk-00081K-JB
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHi-0005jJ-HC
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mBAdJp1rqDVVs7QASn1O1zm/GNfKpJpX2cGJCvOgR1I=;
 b=HPodbNdrxD1jeXLd6Huba6SF25+7pKXciTeFPQXBylDuCrNHUrItV9uQ3wM+lL2D4i9ixq
 RbqjAGFueQmaX025yVkj+RoDOtvlxyY7JaeKX2QozmxFAJKH6lIr44zQUpCmhInQi+RAaS
 BWpIPn34eYd0R+JOKY2Ytqik9N4BtYM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-Jh5BgHvEO-m-x-tuy4Rz8g-1; Mon, 14 Jul 2025 19:08:31 -0400
X-MC-Unique: Jh5BgHvEO-m-x-tuy4Rz8g-1
X-Mimecast-MFC-AGG-ID: Jh5BgHvEO-m-x-tuy4Rz8g_1752534510
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451ac1b43c4so26268405e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534510; x=1753139310;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mBAdJp1rqDVVs7QASn1O1zm/GNfKpJpX2cGJCvOgR1I=;
 b=RwEMulzjc2TYyblIzInNWRdT285+s597+bYwLwmcdGvhv6wygto8OdbES9LATnYwXY
 +2nmJ986V+OZ7DeXTjU6vgrrw9Nyh/IeFYugR1LQ5UxgzuyFK4fcIlu2DQ+6+/7TIhiN
 mWumqrpOdoPvXlii7GKoupYAefkVOb54c8FdS02z/AvLNUTIZjPco0mfUQamHd3DRs4Z
 JhuZGRbhx2SoWelnpb2R/NI3u6+Xh7Ou8xALzAAQbN+QCjXKxAt2qDcq+kNUwDoSGiZV
 HVxPhfC4dSdaXUOr4bbSu0rOHgzbfo4Vpz/FuH/Ku7aq3KdvIGK6F1dyEA3UgRjrsA+p
 BzMw==
X-Gm-Message-State: AOJu0Yx5QPbyS0kFpbrZINCD1LOP0FgBMUBZNvPfv9MC9+Vi8Z/Lukyy
 aHhlgyPJvbBWRTpeHgPFBCFjFBRKxM+YDy2tyJFeaJ2JOnvD+4SUyQg/PgB39qp5EeZhTjwmL/Q
 mRtd5P8tqSiCE1k2FPjyNJq1lOFagrgVzioi4LfjPthNEPI61waXXLai2CrFkwOpdyY8Bj5vY7F
 FrdIcYCGKB7Buolbr+bMyubZKjPhAhiNJHrg==
X-Gm-Gg: ASbGncvGGH8NOx6CKA5J1i3gzJpu5ltAqFBogokYxQllBkzJULhekMsNqXf6MpIPy1b
 E6pvnr2JLvHrH8Xbh5+FJl7ouZXQOWDcKh/yT+2zyNIom9KTwV44JsQ6AcDojPlfyAuMzeBEIn0
 elmRsqDvQgzjU0U7HIqCz3glc0SZ2UsX8+pi/qleSNYi+WcKYTPWThqO6+EQ547+cfVmzqRnHM/
 mk/T+B+k4FCxqij+EvKaF9Ul3xA4FeUJ/dqo6snUv2/jA+QbJUDnuVGOTqcTboApq1xdozhwGjy
 4HyMwP7tGXBRJTpoRQ7n64VrIFJ38LBG
X-Received: by 2002:a05:600c:8b85:b0:456:11db:2f1e with SMTP id
 5b1f17b1804b1-45611db3291mr74629185e9.15.1752534510206; 
 Mon, 14 Jul 2025 16:08:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtRNZBp+NkAgPBPnCQ2eVEN57LAbqkm8HRfnzM5lDvCEh18Vw3xe2FdBLqhMjUx2ZZ/MgaXA==
X-Received: by 2002:a05:600c:8b85:b0:456:11db:2f1e with SMTP id
 5b1f17b1804b1-45611db3291mr74628955e9.15.1752534509783; 
 Mon, 14 Jul 2025 16:08:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560f22cd29sm74054005e9.34.2025.07.14.16.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:08:28 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:08:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 52/97] hw/acpi/ged: Add a acpi-pci-hotplug-with-bridge-support
 property
Message-ID: <9d10f71e9c4519aecf6d7465b569386d5bd5b32f.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

A new boolean property is introduced. This will be used to turn
ACPI PCI hotplug support. By default it is unset.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-7-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/generic_event_device.h | 2 ++
 hw/acpi/generic_event_device.c         | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index d2dac87b4a..f5ffa67a39 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -63,6 +63,7 @@
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/cpu.h"
+#include "hw/acpi/pcihp.h"
 #include "qom/object.h"
 
 #define ACPI_POWER_BUTTON_DEVICE "PWRB"
@@ -114,6 +115,7 @@ struct AcpiGedState {
     MemoryRegion container_memhp;
     CPUHotplugState cpuhp_state;
     MemoryRegion container_cpuhp;
+    AcpiPciHpState pcihp_state;
     GEDState ged_state;
     uint32_t ged_event_bitmap;
     qemu_irq irq;
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 7a62f8d5bc..7831db412b 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -318,6 +318,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
 
 static const Property acpi_ged_properties[] = {
     DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
+    DEFINE_PROP_BOOL(ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, AcpiGedState,
+                     pcihp_state.use_acpi_hotplug_bridge, 0),
 };
 
 static const VMStateDescription vmstate_memhp_state = {
-- 
MST


