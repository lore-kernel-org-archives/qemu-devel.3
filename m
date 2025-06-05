Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B67C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6CW-00079Y-Fo; Thu, 05 Jun 2025 04:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6CM-0006kU-Jz
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6CK-0008JX-SR
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749113020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DUtLCVufp7+8GGCVRq4+MWg2KcPEURnZ5YAKCaO5JYA=;
 b=djGJf9OJDXducR+PBAer8h0F2Z4QfccYB+S9XPlriSsJ1VvblK0chwTNPsAdiUCnidzsnP
 oa+dYAhY9/Xv+9cjfot9N3CkKghRYzxx5VjpuZAl8MfnBxDtej0R5KSwGtJk4ysAxTctF8
 F7mfTDNS0skHP+yM9QjghaEvnt5JnZM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-et5Mto6YM-6fRJsbIo18NA-1; Thu,
 05 Jun 2025 04:43:35 -0400
X-MC-Unique: et5Mto6YM-6fRJsbIo18NA-1
X-Mimecast-MFC-AGG-ID: et5Mto6YM-6fRJsbIo18NA_1749113014
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCFB21800773; Thu,  5 Jun 2025 08:43:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2A751954B33; Thu,  5 Jun 2025 08:43:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 16/16] vfio: move vfio-cpr.h
Date: Thu,  5 Jun 2025 10:42:45 +0200
Message-ID: <20250605084245.1520562-17-clg@redhat.com>
In-Reply-To: <20250605084245.1520562-1-clg@redhat.com>
References: <20250605084245.1520562-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

From: Steve Sistare <steven.sistare@oracle.com>

Move vfio-cpr.h to include/hw/vfio, because it will need to be included by
other files there.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/1748546679-154091-9-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS                |  1 +
 hw/vfio/vfio-cpr.h         | 15 ---------------
 include/hw/vfio/vfio-cpr.h | 18 ++++++++++++++++++
 hw/vfio/container.c        |  2 +-
 hw/vfio/cpr.c              |  2 +-
 hw/vfio/iommufd.c          |  2 +-
 6 files changed, 22 insertions(+), 18 deletions(-)
 delete mode 100644 hw/vfio/vfio-cpr.h
 create mode 100644 include/hw/vfio/vfio-cpr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b189701357ccf1010d60c88916a8e1be42d2a615..aa6763077ea87af0d527319f1cb13e4468b1f299 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3036,6 +3036,7 @@ CheckPoint and Restart (CPR)
 R: Steve Sistare <steven.sistare@oracle.com>
 S: Supported
 F: hw/vfio/cpr*
+F: include/hw/vfio/vfio-cpr.h
 F: include/migration/cpr.h
 F: migration/cpr*
 F: tests/qtest/migration/cpr*
diff --git a/hw/vfio/vfio-cpr.h b/hw/vfio/vfio-cpr.h
deleted file mode 100644
index 134b83a62461cbe9409bbe42057fb4134d84dcd1..0000000000000000000000000000000000000000
--- a/hw/vfio/vfio-cpr.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * VFIO CPR
- *
- * Copyright (c) 2025 Oracle and/or its affiliates.
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef HW_VFIO_CPR_H
-#define HW_VFIO_CPR_H
-
-bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
-void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
-
-#endif /* HW_VFIO_CPR_H */
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
new file mode 100644
index 0000000000000000000000000000000000000000..750ea5bcea38a953c781817f7e76a64422b79d4c
--- /dev/null
+++ b/include/hw/vfio/vfio-cpr.h
@@ -0,0 +1,18 @@
+/*
+ * VFIO CPR
+ *
+ * Copyright (c) 2025 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_VFIO_CPR_H
+#define HW_VFIO_VFIO_CPR_H
+
+struct VFIOContainerBase;
+
+bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
+                                 Error **errp);
+void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
+
+#endif /* HW_VFIO_VFIO_CPR_H */
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index a8c76eb48165405e2b41186a266dbc69ae1b782a..0f948d024711062e2facf44b4d4694a0f1e59b83 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -33,8 +33,8 @@
 #include "qapi/error.h"
 #include "pci.h"
 #include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-cpr.h"
 #include "vfio-helpers.h"
-#include "vfio-cpr.h"
 #include "vfio-listener.h"
 
 #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 3214184f97421a17b4d981facdcadde3a1fcec9a..0210e76a10993e0c01403fec51918cc9fca7b636 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -8,9 +8,9 @@
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-device.h"
 #include "migration/misc.h"
+#include "hw/vfio/vfio-cpr.h"
 #include "qapi/error.h"
 #include "system/runstate.h"
-#include "vfio-cpr.h"
 
 static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
                                     MigrationEvent *e, Error **errp)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index c4bbf36241d3ee5c46bca9601688afd742e471f7..d3efef71afd4fd9e68455cefe7666c9f70e8c61e 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -21,13 +21,13 @@
 #include "qapi/error.h"
 #include "system/iommufd.h"
 #include "hw/qdev-core.h"
+#include "hw/vfio/vfio-cpr.h"
 #include "system/reset.h"
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
 #include "vfio-iommufd.h"
 #include "vfio-helpers.h"
-#include "vfio-cpr.h"
 #include "vfio-listener.h"
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
-- 
2.49.0


