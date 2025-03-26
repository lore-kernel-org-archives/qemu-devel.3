Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67631C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 07:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLYT-0007qO-9w; Wed, 26 Mar 2025 03:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLYR-0007px-Q9
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLYQ-0006FJ-4o
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742975521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5voEmL3VrID2AfGqms7hdXfoSDUgkeW7F9KP0Cn3exo=;
 b=FwRjuCNZOlKkh3KlBNG9YJEC7aXh4y9eC7YUqOLuJ6EYM0T8IvSTRYqrusO1oVgMB2A4OC
 epja+TubZ8rvzqo5LbN0j1RVM0NqOcM9/iw5HtMcp3TVonXSlugSpirPCs4PszSgkJZ6Lx
 dyCMEfiXG1QklAeHAwKVhe3ZBkprKlM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-Jo30luZdP0Cyq7p6pK-Pjw-1; Wed,
 26 Mar 2025 03:51:58 -0400
X-MC-Unique: Jo30luZdP0Cyq7p6pK-Pjw-1
X-Mimecast-MFC-AGG-ID: Jo30luZdP0Cyq7p6pK-Pjw_1742975517
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0088D19560BC; Wed, 26 Mar 2025 07:51:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.180])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C71619560AB; Wed, 26 Mar 2025 07:51:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 v2 05/37] vfio: Make vfio_viommu_preset() static
Date: Wed, 26 Mar 2025 08:50:50 +0100
Message-ID: <20250326075122.1299361-6-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-1-clg@redhat.com>
References: <20250326075122.1299361-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This routine is only used in file "migration.c". Move it there.

Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-6-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 1 -
 hw/vfio/common.c              | 5 -----
 hw/vfio/migration.c           | 5 +++++
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 32b816fa122aee00840c70d2e208310a845ad831..8bb206d755adab4efee32a173c920d9aa4833685 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -290,7 +290,6 @@ extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
 extern int vfio_kvm_device_fd;
 
-bool vfio_viommu_preset(VFIODevice *vbasedev);
 void vfio_migration_add_bytes_transferred(unsigned long val);
 bool vfio_device_state_is_running(VFIODevice *vbasedev);
 bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f78fff41639b83b82eeadf4e40b7ca2cf6bd64dd..a4ec60e018df7dc9bbbeac27120907b0f7bf2f83 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -66,11 +66,6 @@ int vfio_kvm_device_fd = -1;
  */
 
 
-bool vfio_viommu_preset(VFIODevice *vbasedev)
-{
-    return vbasedev->bcontainer->space->as != &address_space_memory;
-}
-
 bool vfio_device_state_is_running(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index db2525fcb926bd228ae2d4dca5eeb2de28041660..96d294794bc3056baa3b0b4e23488402db5de797 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1141,6 +1141,11 @@ bool vfio_migration_active(void)
     return true;
 }
 
+static bool vfio_viommu_preset(VFIODevice *vbasedev)
+{
+    return vbasedev->bcontainer->space->as != &address_space_memory;
+}
+
 /*
  * Return true when either migration initialized or blocker registered.
  * Currently only return false when adding blocker fails which will
-- 
2.49.0


