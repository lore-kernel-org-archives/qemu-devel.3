Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAF5CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v216J-0008Ei-9l; Fri, 26 Sep 2025 01:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v216F-0008Cz-Dd
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v2167-0000lr-VO
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758864860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TK5jfeOstzGjQhv24HnpSnyYveNLECM2e/1RdzHLfJA=;
 b=XTVOOAEwWH8V4wd6DMVGovPm2HPKCulr8rNku+LdPensZkvwYstTfBL3q5IwadnFxd5M0K
 sgpV9O5VBc8GUK5OwY7FvPERZ2s4PVLzP6+47p7xt0wA4eWs2NhQo/AZqNWwCAKTveqTBT
 kLVQQrENb6j/eeQN8u1zKNVZ2BBuRRY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-_Yb3vEXwP6-1_ZAz54duJg-1; Fri,
 26 Sep 2025 01:34:18 -0400
X-MC-Unique: _Yb3vEXwP6-1_ZAz54duJg-1
X-Mimecast-MFC-AGG-ID: _Yb3vEXwP6-1_ZAz54duJg_1758864857
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4760F19560AE; Fri, 26 Sep 2025 05:34:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9CB761800579; Fri, 26 Sep 2025 05:34:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/29] include/hw/vfio/vfio-container-base.h: rename file to
 vfio-container.h
Date: Fri, 26 Sep 2025 07:33:34 +0200
Message-ID: <20250926053358.308198-6-clg@redhat.com>
In-Reply-To: <20250926053358.308198-1-clg@redhat.com>
References: <20250926053358.308198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

With the rename of VFIOContainerBase to VFIOContainer, the vfio-container-base.h
header file containing the struct definition is misleading. Rename it from
vfio-container-base.h to vfio-container.h accordingly, fixing up the name
of the include guard at the same time.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250925113159.1760317-5-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/container.h                                    | 2 +-
 hw/vfio/vfio-iommufd.h                                      | 2 +-
 include/hw/vfio/vfio-container-legacy.h                     | 2 +-
 include/hw/vfio/{vfio-container-base.h => vfio-container.h} | 6 +++---
 include/hw/vfio/vfio-device.h                               | 2 +-
 hw/vfio/container-base.c                                    | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)
 rename include/hw/vfio/{vfio-container-base.h => vfio-container.h} (98%)

diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
index 241863ef976f5a437755358c3949dd02f7820726..a2b42e3169dfba173308cb69404fc3b0fa98e99a 100644
--- a/hw/vfio-user/container.h
+++ b/hw/vfio-user/container.h
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-container.h"
 #include "hw/vfio-user/proxy.h"
 
 /* MMU container sub-class for vfio-user. */
diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
index 6c049d925763848b25b25cea632cf9d1874f83e9..13f412aad79abfea2e591ee0e3e6d7a5b2c9f68c 100644
--- a/hw/vfio/vfio-iommufd.h
+++ b/hw/vfio/vfio-iommufd.h
@@ -9,7 +9,7 @@
 #ifndef HW_VFIO_VFIO_IOMMUFD_H
 #define HW_VFIO_VFIO_IOMMUFD_H
 
-#include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-container.h"
 
 typedef struct VFIODevice VFIODevice;
 
diff --git a/include/hw/vfio/vfio-container-legacy.h b/include/hw/vfio/vfio-container-legacy.h
index ab5130d26eaa0e9fe586e49efe78aef6c0450540..74a72df018b50490b95d80044a31247ba7c9fc3b 100644
--- a/include/hw/vfio/vfio-container-legacy.h
+++ b/include/hw/vfio/vfio-container-legacy.h
@@ -9,7 +9,7 @@
 #ifndef HW_VFIO_CONTAINER_LEGACY_H
 #define HW_VFIO_CONTAINER_LEGACY_H
 
-#include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-cpr.h"
 
 typedef struct VFIOLegacyContainer VFIOLegacyContainer;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container.h
similarity index 98%
rename from include/hw/vfio/vfio-container-base.h
rename to include/hw/vfio/vfio-container.h
index b580f4a02df92276ef82c953eaf6942e1bf31413..b8fb2b8b5d72b1d2a4c00dc89b214b48a371f555 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container.h
@@ -10,8 +10,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef HW_VFIO_VFIO_CONTAINER_BASE_H
-#define HW_VFIO_VFIO_CONTAINER_BASE_H
+#ifndef HW_VFIO_VFIO_CONTAINER_H
+#define HW_VFIO_VFIO_CONTAINER_H
 
 #include "system/memory.h"
 
@@ -276,4 +276,4 @@ VFIORamDiscardListener *vfio_find_ram_discard_listener(
 void vfio_container_region_add(VFIOContainer *bcontainer,
                                MemoryRegionSection *section, bool cpr_remap);
 
-#endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
+#endif /* HW_VFIO_VFIO_CONTAINER_H */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 67b9fcdd2c011234d250bcdd23fdcdfb259aba2f..ed19e2e1e5859a0e9d3910d54d6ba2ad61f551d9 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -27,7 +27,7 @@
 #include <linux/vfio.h>
 #endif
 #include "system/system.h"
-#include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "system/host_iommu_device.h"
 #include "system/iommufd.h"
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 98c5198e5043b0ecb679060116bbac240ac76747..250b20f424522f4b6a4e864906eed2d8d13efbcd 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -18,7 +18,7 @@
 #include "system/ram_addr.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-device.h" /* vfio_device_reset_handler */
 #include "system/reset.h"
 #include "vfio-helpers.h"
-- 
2.51.0


