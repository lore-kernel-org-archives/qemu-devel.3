Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5CEC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7G9n-0004FZ-4k; Tue, 22 Apr 2025 12:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G6X-0000ZW-KF
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G6U-0005A2-UM
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745337850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BahgtKlK1IlJCugx0QgheOZDr3L3Ny7HGu0mBPojqYk=;
 b=XzpupNiZuHy/prskxzXaeOexZH/WpQdZe2rUVAl7kd+e8Y6Fx0bHF8Qjn/VNft5x4SZqlP
 HeZ0eyceg6OEJtjMGoXIZ/QChTaqwD5GF97QZot9BSp/w021G9AzgZND4G0P7Gpu4Vv5IO
 nna0K5p+SNpRI3/b7jrguxw4KnXeMpE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-UGNIWepqMG2IQkuXleyvZQ-1; Tue,
 22 Apr 2025 12:04:06 -0400
X-MC-Unique: UGNIWepqMG2IQkuXleyvZQ-1
X-Mimecast-MFC-AGG-ID: UGNIWepqMG2IQkuXleyvZQ_1745337845
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A40CA1800264; Tue, 22 Apr 2025 16:04:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C73318001DA; Tue, 22 Apr 2025 16:04:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 27/37] vfio: Make vfio_devices_query_dirty_bitmap() static
Date: Tue, 22 Apr 2025 18:02:14 +0200
Message-ID: <20250422160224.199714-28-clg@redhat.com>
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

vfio_devices_query_dirty_bitmap() is only used in "container-base.c".
Also, rename to vfio_container_devices_query_dirty_bitmap() to reflect
with the prefix 'vfio_container_devices_' that it simply loops over
the container's device list.

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-28-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 3 ---
 hw/vfio/container-base.c              | 6 +++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 8575cdcb587dfe803808d452c7dc6c81241a47cf..1227771dd896b5917366ef578109b0ad92da2375 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -93,9 +93,6 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
 bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
 bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
-int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-                                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
-                                    Error **errp);
 int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp);
 
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 2844c5325efffade43022bfb517a43ac372c4125..4edbd39185375dee42ee6e6410da7b94635b5ab8 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -214,7 +214,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     return 0;
 }
 
-int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+static int vfio_container_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                  VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
 {
     VFIODevice *vbasedev;
@@ -260,8 +260,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
     }
 
     if (all_device_dirty_tracking) {
-        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
-                                              errp);
+        ret = vfio_container_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
+                                                        errp);
     } else {
         ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
                                                 errp);
-- 
2.49.0


