Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051E1C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTgS-0006ZF-Nm; Tue, 18 Mar 2025 05:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTgI-0005lz-2p
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTgF-0002TP-B2
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aE10HwSaLKMrzeIsw/wUOQ0AxS2Fg8FfE9RKbfoPRHk=;
 b=TcX0bY3C8pkLeHBdojT39tgq+V6FQMVVEJC8khgaGR604S4Zp1NgT9kuU7gCdR88pOkp8Y
 0NN40HZIkC2QS5GirrxfvXN9Twt6bpEYIuD6mqaPxcpm1TrK4InLWSJ1iPLTYYH+7ibLd9
 4ep1DrXipyt1AXONXZX8EWAtksb5DF4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-rcfOprt6PKGmlVvUFAwvoA-1; Tue,
 18 Mar 2025 05:56:10 -0400
X-MC-Unique: rcfOprt6PKGmlVvUFAwvoA-1
X-Mimecast-MFC-AGG-ID: rcfOprt6PKGmlVvUFAwvoA_1742291769
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04A0C188EA49; Tue, 18 Mar 2025 09:56:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C2AA1828AAE; Tue, 18 Mar 2025 09:56:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 26/32] vfio: Rename vfio-common.h to vfio-device.h
Date: Tue, 18 Mar 2025 10:54:09 +0100
Message-ID: <20250318095415.670319-27-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration-multifd.h                      | 2 +-
 hw/vfio/pci.h                                    | 2 +-
 include/hw/s390x/vfio-ccw.h                      | 2 +-
 include/hw/vfio/{vfio-common.h => vfio-device.h} | 0
 include/hw/vfio/vfio-platform.h                  | 2 +-
 backends/iommufd.c                               | 2 +-
 hw/vfio/ap.c                                     | 2 +-
 hw/vfio/ccw.c                                    | 2 +-
 hw/vfio/container-base.c                         | 2 +-
 hw/vfio/container.c                              | 2 +-
 hw/vfio/cpr.c                                    | 2 +-
 hw/vfio/device.c                                 | 2 +-
 hw/vfio/dirty-tracking.c                         | 2 +-
 hw/vfio/helpers.c                                | 2 +-
 hw/vfio/iommufd.c                                | 2 +-
 hw/vfio/migration-multifd.c                      | 2 +-
 hw/vfio/migration.c                              | 2 +-
 hw/vfio/region.c                                 | 4 ++--
 18 files changed, 18 insertions(+), 18 deletions(-)
 rename include/hw/vfio/{vfio-common.h => vfio-device.h} (100%)

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
index c84bba81487136d205ca30049c812d00e832c377..d33237c275551897164878705d44e7881c372ab0 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -14,7 +14,7 @@
 
 #include "exec/memory.h"
 #include "hw/pci/pci_device.h"
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "qemu/event_notifier.h"
 #include "qemu/queue.h"
 #include "qemu/timer.h"
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
similarity index 100%
rename from include/hw/vfio/vfio-common.h
rename to include/hw/vfio/vfio-device.h
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
index c7ab4ff57ada0ed0e5a76f52b5a05c86ca4fe0b4..4fdb74e33c427595a9b0a4d28b2b5a70df951e4e 100644
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
index e5e0d9e3e7ed124f242b3eda345bc973e418a64c..a40169bc85e51406822247f5b3ef6da1f7f92881 100644
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
index 83e83ab9e67de8b004dfaf0067e4c466a6c88451..ace9de18103e8c1ed9f7a51adbf16c36be01bd7c 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -15,7 +15,7 @@
 #include "qemu/error-report.h"
 #include "system/reset.h"
 #include "hw/vfio/vfio-container-base.h"
-#include "hw/vfio/vfio-common.h" /* for vfio_device_list */
+#include "hw/vfio/vfio-device.h" /* for vfio_device_list */
 #include "trace.h"
 
 static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index e88dfe12edd6dee469c06ee2e46ab9c8b5019ae7..e300d2d90f2fbde329609b7c63245c523766fb60 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -22,7 +22,7 @@
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index e1bba1726402f41ee394f25b6e613d27f44b2a2c..43b99680f6d7db27c4d7e518520aef5ade2ebcf4 100644
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
index e6a1bbcda2297f9e6272fff9b1c228b6772457ce..0d443b53d23d392729cef84e419d3e089fe64298 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -22,7 +22,7 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
 #include "hw/hw.h"
 #include "trace.h"
diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
index 447e09ed84993e3fbe1ed9b27a8269a9f0f46339..143cc5cf62b0165565e91f8a2ca166026f16b1eb 100644
--- a/hw/vfio/dirty-tracking.c
+++ b/hw/vfio/dirty-tracking.c
@@ -22,7 +22,7 @@
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index e99d312a9f5c7462644ea3d0de2e9de38979f851..b7907aab80f8adb308ebae60baa20c911d9393d7 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -23,7 +23,7 @@
 #include <sys/ioctl.h>
 
 #include "system/kvm.h"
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/hw.h"
 #include "qapi/error.h"
 #include "helpers.h"
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 9335a17920b32dc2bf9cb4eeb2b8f57382f14ac8..7f354d86cd14270a70dc990860ad5b69f0310719 100644
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
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 285f9a9a18dd8f0847ac5ac3fdaa304779a2d0db..1ba703e595db99f3786bfc1a2edeb0e061f9e01b 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-migration.h"
 #include "migration/misc.h"
 #include "qapi/error.h"
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 6fd825e435bde96d1008ec03dfaba25db3b616fc..338fafb83f41460e0c244dcc27524198322eec67 100644
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
index 87bf5e046a432dfedf3be3c1c7e8f33e006da004..ade4466eb622248b5aa50f9df7e5c683bfa78a11 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -22,8 +22,8 @@
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
2.48.1


