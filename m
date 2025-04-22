Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A38C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GCP-0007tQ-8D; Tue, 22 Apr 2025 12:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G6x-00010A-96
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:04:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G6t-0005Bw-W1
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745337875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IB9IjcroDnvZm6pc7jkB2R2UuEtIODGtgF5qw20fWnE=;
 b=X5xi/q8yrBvC7R4LELRaNaaC4oR32sEIJrfnCqFuqsEHvTzTChvIzh6VBmtODBZMRaBHSX
 qBT63fCZbzCQvWruH4jJZFD20Xw1MamEiwujovZD0UMT2WhSF0fHTj7Z7NYmWBi76iRUZB
 wITaY9GSdk1ykll4pO2XJywpmM5x0w0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-iSmmSC-EO-mkMG-oLZyaxg-1; Tue,
 22 Apr 2025 12:04:33 -0400
X-MC-Unique: iSmmSC-EO-mkMG-oLZyaxg-1
X-Mimecast-MFC-AGG-ID: iSmmSC-EO-mkMG-oLZyaxg_1745337872
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 683321956094; Tue, 22 Apr 2025 16:04:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0CC4718001DA; Tue, 22 Apr 2025 16:04:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 35/37] vfio: Rename vfio-common.h to vfio-device.h
Date: Tue, 22 Apr 2025 18:02:22 +0200
Message-ID: <20250422160224.199714-36-clg@redhat.com>
In-Reply-To: <20250422160224.199714-1-clg@redhat.com>
References: <20250422160224.199714-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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
index 9383a52a3f4e40f965cbd7d53c654acbaa309297..cbea3be02902a60bd4aec24ade1a6c59617d46e9 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -14,7 +14,7 @@
 
 #include "exec/memory.h"
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
index 4ab6e18d3c798ab379b98a0a16504814ec0556b1..0bd3d607f30475dfaa55b6f35a7d7873d3ea3c4f 100644
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
index 4c39b6645464445255bd27342f2e2c2b8c16a6ce..3ec7166ff24f4a4ff2b64a56d1cfbc8dca8e3c36 100644
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
index f086e5c802f058c01ca740de338538106874fb03..86a1a8e4e816d3605d406d76cbb0663112c3976b 100644
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
index d0cd21ef6156471b93a69d29c6c52d49a58056a9..285ca97a8c5de492d0d869c6ef3209f30e2ba072 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -25,7 +25,7 @@
 #endif
 #include <linux/vfio.h>
 
-#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
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
index 8d69de3c80eaedf9bf4b8bc9b25f6d722ae619b2..bda514b91969156491c0cd8c5c0d1ac47ae8c45f 100644
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


