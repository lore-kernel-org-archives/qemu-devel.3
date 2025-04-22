Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722BBC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7G6f-0000ZV-Pe; Tue, 22 Apr 2025 12:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G5G-0006o9-Ds
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G5E-0004zh-Dg
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745337771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVxpEwbfR8RMN8GIA+Wvc7hhT66GXAhM3XxBljXCbMM=;
 b=IZ2rBq5ZxsnLRHKv+dy7QgSPDYgcuMfevCApIdJXn4iUGm/NlQXDbUTJwO9dz4FrvGRypi
 MoqMZYe+xBxHGEC8WubvPj4h3pX9lkDDbY5nDB08QorLUOepVHPEwVdXHzdD0NHP1ZltU5
 2+IeQkEvkYkuDLk4MWcyQUnjDTymIX8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-UxmO-HDJP0amcROuYstIdQ-1; Tue,
 22 Apr 2025 12:02:46 -0400
X-MC-Unique: UxmO-HDJP0amcROuYstIdQ-1
X-Mimecast-MFC-AGG-ID: UxmO-HDJP0amcROuYstIdQ_1745337765
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BA82180010A; Tue, 22 Apr 2025 16:02:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE1B218001DA; Tue, 22 Apr 2025 16:02:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 04/37] vfio: Make
 vfio_un/block_multiple_devices_migration() static
Date: Tue, 22 Apr 2025 18:01:51 +0200
Message-ID: <20250422160224.199714-5-clg@redhat.com>
In-Reply-To: <20250422160224.199714-1-clg@redhat.com>
References: <20250422160224.199714-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

Both of these routines are only used in file "migration.c". Move them
there.

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-5-clg@redhat.com
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-5-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  2 --
 hw/vfio/common.c              | 62 -----------------------------------
 hw/vfio/migration.c           | 62 +++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 64 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index fd424a4a3d40132e940f457f9250458e50ea0b71..32b816fa122aee00840c70d2e208310a845ad831 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -290,8 +290,6 @@ extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
 extern int vfio_kvm_device_fd;
 
-int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
-void vfio_unblock_multiple_devices_migration(void);
 bool vfio_viommu_preset(VFIODevice *vbasedev);
 void vfio_migration_add_bytes_transferred(unsigned long val);
 bool vfio_device_state_is_running(VFIODevice *vbasedev);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e0482a796ff89afae2f017ae4e87f6f4056328fe..f78fff41639b83b82eeadf4e40b7ca2cf6bd64dd 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -41,7 +41,6 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "migration/misc.h"
-#include "migration/blocker.h"
 #include "migration/qemu-file.h"
 #include "system/tcg.h"
 #include "system/tpm.h"
@@ -66,67 +65,6 @@ int vfio_kvm_device_fd = -1;
  * Device state interfaces
  */
 
-static Error *multiple_devices_migration_blocker;
-
-/*
- * Multiple devices migration is allowed only if all devices support P2P
- * migration. Single device migration is allowed regardless of P2P migration
- * support.
- */
-static bool vfio_multiple_devices_migration_is_supported(void)
-{
-    VFIODevice *vbasedev;
-    unsigned int device_num = 0;
-    bool all_support_p2p = true;
-
-    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
-        if (vbasedev->migration) {
-            device_num++;
-
-            if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
-                all_support_p2p = false;
-            }
-        }
-    }
-
-    return all_support_p2p || device_num <= 1;
-}
-
-int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
-{
-    int ret;
-
-    if (vfio_multiple_devices_migration_is_supported()) {
-        return 0;
-    }
-
-    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
-        error_setg(errp, "Multiple VFIO devices migration is supported only if "
-                         "all of them support P2P migration");
-        return -EINVAL;
-    }
-
-    if (multiple_devices_migration_blocker) {
-        return 0;
-    }
-
-    error_setg(&multiple_devices_migration_blocker,
-               "Multiple VFIO devices migration is supported only if all of "
-               "them support P2P migration");
-    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
-
-    return ret;
-}
-
-void vfio_unblock_multiple_devices_migration(void)
-{
-    if (!multiple_devices_migration_blocker ||
-        !vfio_multiple_devices_migration_is_supported()) {
-        return;
-    }
-
-    migrate_del_blocker(&multiple_devices_migration_blocker);
-}
 
 bool vfio_viommu_preset(VFIODevice *vbasedev)
 {
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 582d65932a6c590eaecd8bf0b765f27d93896c72..db2525fcb926bd228ae2d4dca5eeb2de28041660 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1022,6 +1022,68 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     return 0;
 }
 
+static Error *multiple_devices_migration_blocker;
+
+/*
+ * Multiple devices migration is allowed only if all devices support P2P
+ * migration. Single device migration is allowed regardless of P2P migration
+ * support.
+ */
+static bool vfio_multiple_devices_migration_is_supported(void)
+{
+    VFIODevice *vbasedev;
+    unsigned int device_num = 0;
+    bool all_support_p2p = true;
+
+    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
+        if (vbasedev->migration) {
+            device_num++;
+
+            if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
+                all_support_p2p = false;
+            }
+        }
+    }
+
+    return all_support_p2p || device_num <= 1;
+}
+
+static int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
+{
+    int ret;
+
+    if (vfio_multiple_devices_migration_is_supported()) {
+        return 0;
+    }
+
+    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
+        error_setg(errp, "Multiple VFIO devices migration is supported only if "
+                         "all of them support P2P migration");
+        return -EINVAL;
+    }
+
+    if (multiple_devices_migration_blocker) {
+        return 0;
+    }
+
+    error_setg(&multiple_devices_migration_blocker,
+               "Multiple VFIO devices migration is supported only if all of "
+               "them support P2P migration");
+    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
+
+    return ret;
+}
+
+static void vfio_unblock_multiple_devices_migration(void)
+{
+    if (!multiple_devices_migration_blocker ||
+        !vfio_multiple_devices_migration_is_supported()) {
+        return;
+    }
+
+    migrate_del_blocker(&multiple_devices_migration_blocker);
+}
+
 static void vfio_migration_deinit(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
-- 
2.49.0


