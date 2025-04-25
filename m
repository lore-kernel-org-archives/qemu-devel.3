Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9914CC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8EkR-0006wx-FY; Fri, 25 Apr 2025 04:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ek5-0006Na-0w
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ek2-0003L2-BB
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IIz689r5PFmYy+Qt7ydR21v1FHIGWz8plMYyRi3FtWw=;
 b=DjQAqBMrERFTc4CGHNse4Cqc9GnGfFCPPVG+PiGw2gfOF40cupMe6WVRlWPE5wXMDI1zig
 BfdSpcoHeD5cEn1FQlnNicN31Txyn7UGmXJ4KbNhEAO3xpDTVXB+SW+o+bPqWvKtnZN1OF
 nNXDqTlTNy1vx6oP1TSSmEfWGBASHtw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-TtdTBxSZOTGwuBms_ZjWbA-1; Fri,
 25 Apr 2025 04:48:57 -0400
X-MC-Unique: TtdTBxSZOTGwuBms_ZjWbA-1
X-Mimecast-MFC-AGG-ID: TtdTBxSZOTGwuBms_ZjWbA_1745570936
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC2911800ECB; Fri, 25 Apr 2025 08:48:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C38C30001AB; Fri, 25 Apr 2025 08:48:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 39/50] vfio: Rename vfio-common.h to vfio-device.h
Date: Fri, 25 Apr 2025 10:46:32 +0200
Message-ID: <20250425084644.102196-40-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

"hw/vfio/vfio-common.h" has been emptied of most of its declarations
by the previous changes and the only declarations left are related to
VFIODevice. Rename it to "hw/vfio/vfio-device.h" and make the
necessary adjustments.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-36-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration-multifd.h                      | 2 +-
 hw/vfio/pci.h                                    | 2 +-
 include/hw/s390x/vfio-ccw.h                      | 2 +-
 include/hw/vfio/{vfio-common.h => vfio-device.h} | 2 +-
 include/hw/vfio/vfio-platform.h                  | 2 +-
 backends/iommufd.c                               | 2 +-
 hw/vfio/ap.c                                     | 2 +-
 hw/vfio/ccw.c                                    | 2 +-
 hw/vfio/container-base.c                         | 2 +-
 hw/vfio/container.c                              | 2 +-
 hw/vfio/cpr.c                                    | 2 +-
 hw/vfio/device.c                                 | 2 +-
 hw/vfio/helpers.c                                | 2 +-
 hw/vfio/iommufd.c                                | 2 +-
 hw/vfio/listener.c                               | 2 +-
 hw/vfio/migration-multifd.c                      | 2 +-
 hw/vfio/migration.c                              | 2 +-
 hw/vfio/region.c                                 | 4 ++--
 18 files changed, 19 insertions(+), 19 deletions(-)
 rename include/hw/vfio/{vfio-common.h => vfio-device.h} (98%)

diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
index a664051eb8ae03bc41cb7f9362ace840f41066ff..0bab63211d30cef04c50e50b3ea57840915ffc2a 100644
--- a/hw/vfio/migration-multifd.h
+++ b/hw/vfio/migration-multifd.h
@@ -12,7 +12,7 @@
 #ifndef HW_VFIO_MIGRATION_MULTIFD_H
 #define HW_VFIO_MIGRATION_MULTIFD_H
 
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 
 bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp);
 void vfio_multifd_cleanup(VFIODevice *vbasedev);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 801ea445b8c9f7b11fb209146aa54349fe29ccf4..f835b1dbc2b1e8aab820924900e1eb6c36613d16 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -14,7 +14,7 @@
 
 #include "system/memory.h"
 #include "hw/pci/pci_device.h"
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-region.h"
 #include "qemu/event_notifier.h"
 #include "qemu/queue.h"
diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.h
index 4209d27657c1fbde44c160445396bcab3f3fd2b0..1e0922dca11e6caada08c2aae82bd3462ace35f5 100644
--- a/include/hw/s390x/vfio-ccw.h
+++ b/include/hw/s390x/vfio-ccw.h
@@ -14,7 +14,7 @@
 #ifndef HW_VFIO_CCW_H
 #define HW_VFIO_CCW_H
 
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/s390x/s390-ccw.h"
 #include "hw/s390x/ccw-device.h"
 #include "qom/object.h"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-device.h
similarity index 98%
rename from include/hw/vfio/vfio-common.h
rename to include/hw/vfio/vfio-device.h
index 92381c6160925613dfc1d1de678479f70976c796..cfbe254e31545818733c1b7f4f5607091fc4d871 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-device.h
@@ -1,5 +1,5 @@
 /*
- * common header for vfio based device assignment support
+ * VFIO Device interface
  *
  * Copyright Red Hat, Inc. 2012
  *
diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
index 3191545717da51abc41d10cd3646cd047b4a676c..256d8500b70a2e985e975b0895e3cfca435ed8ed 100644
--- a/include/hw/vfio/vfio-platform.h
+++ b/include/hw/vfio/vfio-platform.h
@@ -17,7 +17,7 @@
 #define HW_VFIO_VFIO_PLATFORM_H
 
 #include "hw/sysbus.h"
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "qemu/event_notifier.h"
 #include "qemu/queue.h"
 #include "qom/object.h"
diff --git a/backends/iommufd.c b/backends/iommufd.c
index d57da44755be3d7fdba74f7dbecfe6d1c89921ba..9587e4d99b131e88674326a5196cfd2079560430 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -18,7 +18,7 @@
 #include "qemu/error-report.h"
 #include "monitor/monitor.h"
 #include "trace.h"
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include <sys/ioctl.h>
 #include <linux/iommufd.h>
 
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index d6575d7c44c30e4b6731751f91c0685ceb26d85b..9e2251437e639af64be4040bc82b34430b492640 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -15,7 +15,7 @@
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 #include "qapi/error.h"
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "system/iommufd.h"
 #include "hw/s390x/ap-device.h"
 #include "qemu/error-report.h"
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 29e804e1222293e20fbbdfe29889eb796191b25b..d0713ca4c76b31b3fe03b558c310f0455d40b97c 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -21,7 +21,7 @@
 #include <sys/ioctl.h>
 
 #include "qapi/error.h"
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "system/iommufd.h"
 #include "hw/s390x/s390-ccw.h"
 #include "hw/s390x/vfio-ccw.h"
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index fb86bc41bf81f38549c56663861516d99056b53e..c037bafe2162d864c42e059d7630d579fde0d251 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -19,7 +19,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/vfio/vfio-container-base.h"
-#include "hw/vfio/vfio-common.h" /* vfio_reset_handler */
+#include "hw/vfio/vfio-device.h" /* vfio_reset_handler */
 #include "system/reset.h"
 #include "vfio-helpers.h"
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index e4fcb1ad8bee80136fedcdc07cd68d56b5eeae04..ef1404607253cd5279c89af5d31add3c88b01aed 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -22,7 +22,7 @@
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
 #include "system/ram_addr.h"
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 696987006b853227e76caedb3c7f4e4be31cfa06..3214184f97421a17b4d981facdcadde3a1fcec9a 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -6,7 +6,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "migration/misc.h"
 #include "qapi/error.h"
 #include "system/runstate.h"
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index e122c797c206c285ef26c3a56d841d8c3be8b58b..543750c3b13b53dbd6705d08ac8cead0ebe49ed7 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
 #include "hw/hw.h"
 #include "trace.h"
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 48bd61d5280967dffa509dcbaeeee7a1ba01335a..d0dbab1d17132743ea5f5ed0f25701436be11945 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -23,7 +23,7 @@
 #include <sys/ioctl.h>
 
 #include "system/kvm.h"
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/hw.h"
 #include "qapi/error.h"
 #include "vfio-helpers.h"
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index e47720247d6acfd6ea0e5a2e2a2eecabfa62dce3..48db10542269111804643713270199657145accc 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -15,7 +15,7 @@
 #include <linux/vfio.h>
 #include <linux/iommufd.h>
 
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "qapi/error.h"
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index d19674503c5dfc6b61671db316a186d18ae6f865..6f77e18a7a2f9437d50976eeb9847f99bfe4a739 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -25,7 +25,7 @@
 #endif
 #include <linux/vfio.h>
 
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index a3005226b9ca22ff27d9d49339d9828a43713932..850a319488786d1b66e40789ae54a0c73ac9137a 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "migration/misc.h"
 #include "qapi/error.h"
 #include "qemu/bswap.h"
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 4da05263255b9f858539a55d03d1b35609a4c697..1dceab1b192e6430a01ae8813a302d37a0c3e21d 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -16,7 +16,7 @@
 #include <sys/ioctl.h>
 
 #include "system/runstate.h"
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-migration.h"
 #include "migration/misc.h"
 #include "migration/savevm.h"
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 9049143abffa28bed333d110d1e01d68ad7f83be..010b5241e15c2063051fd780c335fef80f214dc1 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -21,8 +21,8 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
-#include "hw/vfio/vfio-common.h"
-#include "hw/vfio/pci.h"
+#include "hw/vfio/vfio-region.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/hw.h"
 #include "trace.h"
 #include "qapi/error.h"
-- 
2.49.0


