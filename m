Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992D1CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v216E-0008Cm-2O; Fri, 26 Sep 2025 01:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v216C-0008Bu-WA
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v2166-0000kT-R4
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758864857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zs8DV9S9EBu4KwMxL4Gn3/doWA0m3P/pLkeyRYvOciw=;
 b=QQgFCY9mr5R39lTdzeEJHC5bRxiBjm7jaiRIZzpdGZvWJfTcJ5X0EG2Qnyd1C9V6I/72T5
 2nSLOL2G1xY/RzOdRaumJ9OVsue2KLqS+iAVhJ4S/SpBi+RybvWA7dhWFfcDyEj5M+Nfj9
 NQB05UD1AYrrPraXPhk+JbNqNmGedtE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-DN4SXsMkO1235RLXxEDJBg-1; Fri,
 26 Sep 2025 01:34:14 -0400
X-MC-Unique: DN4SXsMkO1235RLXxEDJBg-1
X-Mimecast-MFC-AGG-ID: DN4SXsMkO1235RLXxEDJBg_1758864854
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AB271977309; Fri, 26 Sep 2025 05:34:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2648D1800452; Fri, 26 Sep 2025 05:34:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/29] include/hw/vfio/vfio-container.h: rename file to
 vfio-container-legacy.h
Date: Fri, 26 Sep 2025 07:33:33 +0200
Message-ID: <20250926053358.308198-5-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With the rename of VFIOContainer to VFIOLegacyContainer, the vfio-container.h
header file containing the struct definition is misleading. Rename it from
vfio-container.h to vfio-container-legacy.h accordingly, fixing up the name
of the include guard at the same time.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250925113159.1760317-4-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 .../hw/vfio/{vfio-container.h => vfio-container-legacy.h}   | 6 +++---
 hw/ppc/spapr_pci_vfio.c                                     | 2 +-
 hw/s390x/s390-pci-vfio.c                                    | 2 +-
 hw/vfio/container.c                                         | 2 +-
 hw/vfio/cpr-legacy.c                                        | 2 +-
 hw/vfio/spapr.c                                             | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)
 rename include/hw/vfio/{vfio-container.h => vfio-container-legacy.h} (88%)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container-legacy.h
similarity index 88%
rename from include/hw/vfio/vfio-container.h
rename to include/hw/vfio/vfio-container-legacy.h
index a84dfb0dee79d8d9e310cbcd84166c269a877b4a..ab5130d26eaa0e9fe586e49efe78aef6c0450540 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container-legacy.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef HW_VFIO_CONTAINER_H
-#define HW_VFIO_CONTAINER_H
+#ifndef HW_VFIO_CONTAINER_LEGACY_H
+#define HW_VFIO_CONTAINER_LEGACY_H
 
 #include "hw/vfio/vfio-container-base.h"
 #include "hw/vfio/vfio-cpr.h"
@@ -36,4 +36,4 @@ struct VFIOLegacyContainer {
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOLegacyContainer, VFIO_IOMMU_LEGACY);
 
-#endif /* HW_VFIO_CONTAINER_H */
+#endif /* HW_VFIO_CONTAINER_LEGACY_H */
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index c8175dd8a89b16e04f464e535306abe83a4ca74f..a748a0bf4c987e604a4a8c5bea3148bcdc7d2db0 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -24,7 +24,7 @@
 #include "hw/pci-host/spapr.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_device.h"
-#include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-container-legacy.h"
 #include "qemu/error-report.h"
 #include CONFIG_DEVICES /* CONFIG_VFIO_PCI */
 
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 938a5511713dade46740dca79a8c4c738799a1ce..7760780aff7ae18034d8cbbb77c4d41ea95a6be5 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -20,7 +20,7 @@
 #include "hw/s390x/s390-pci-clp.h"
 #include "hw/s390x/s390-pci-vfio.h"
 #include "hw/vfio/pci.h"
-#include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-container-legacy.h"
 #include "hw/vfio/vfio-helpers.h"
 
 /*
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index dc8425efb1f68eb80b17ec2ba4baa8f7cb258d36..c0f87f774a00805cab4a8f3b3386ddd99c3d9111 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -34,7 +34,7 @@
 #include "migration/cpr.h"
 #include "migration/blocker.h"
 #include "pci.h"
-#include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-container-legacy.h"
 #include "vfio-helpers.h"
 #include "vfio-listener.h"
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index bd3f6fc3d3936e7798df6a3c9f3b893e428ec771..bbf7a0d35f0ba2b78fd40a60b6e47337665dcbb9 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -7,7 +7,7 @@
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 #include "qemu/osdep.h"
-#include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-container-legacy.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-listener.h"
 #include "migration/blocker.h"
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 6d462aa13caecb3e91de503ca4bb2bc60c9d262a..acaa9c141916f127a87440d239facf285f9e34e0 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -15,7 +15,7 @@
 #include "system/hostmem.h"
 #include "system/address-spaces.h"
 
-#include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-container-legacy.h"
 #include "hw/hw.h"
 #include "system/ram_addr.h"
 #include "qemu/error-report.h"
-- 
2.51.0


