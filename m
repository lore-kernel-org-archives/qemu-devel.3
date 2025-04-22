Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58422C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GBX-0006BF-R8; Tue, 22 Apr 2025 12:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G6s-0000ud-Hu
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G6o-0005Aq-U7
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745337861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Z5T83DrZc8B6PEJTc7EM83nKhdmbq32cWCLUdAqdI8=;
 b=J33Iaa5SulAvPcTK7bigvt7yOOJEih1B6ECkUqzCrrUnOA3d7FhSchDy9mw3Gt8b/pTBoN
 04xQlsQnVeFaVchvKX02JZD3bdo9b0m2m+mH90QnfvLsEhIsXxUKiwjbVeTCD8ypLwRvMQ
 TL2P3fZQ8SeTegurLJzRcDNs+kW/OzQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-CI4dzbwAN0aWzsPThObs8g-1; Tue,
 22 Apr 2025 12:04:17 -0400
X-MC-Unique: CI4dzbwAN0aWzsPThObs8g-1
X-Mimecast-MFC-AGG-ID: CI4dzbwAN0aWzsPThObs8g_1745337855
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C15DC180087A; Tue, 22 Apr 2025 16:04:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85746180087C; Tue, 22 Apr 2025 16:04:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 30/37] vfio: Rename vfio_devices_all_device_dirty_tracking()
Date: Tue, 22 Apr 2025 18:02:17 +0200
Message-ID: <20250422160224.199714-31-clg@redhat.com>
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

Use the prefix 'vfio_container_devices_' to reflect the routine simply
loops over the container's device list.

Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-31-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 3 ++-
 hw/vfio/common.c                      | 4 ++--
 hw/vfio/container-base.c              | 5 +++--
 hw/vfio/container.c                   | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index d00db365991aabf7fdee0c9306197920d9524ed8..163d9b3c30b3093d2f40bb3d3ffc0314519ac285 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -91,7 +91,8 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start, Error **errp);
 bool vfio_container_dirty_tracking_is_started(
     const VFIOContainerBase *bcontainer);
-bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
+bool vfio_container_devices_dirty_tracking_is_supported(
+    const VFIOContainerBase *bcontainer);
 int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index fae8756ade1f85c29a8567adef87135ee111baba..d063ea03c1cb4f475d421e626c703875fecd97a8 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -936,7 +936,7 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
                                                  listener);
     bool ret;
 
-    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
+    if (vfio_container_devices_dirty_tracking_is_supported(bcontainer)) {
         ret = vfio_devices_dma_logging_start(bcontainer, errp);
     } else {
         ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp) == 0;
@@ -955,7 +955,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
     Error *local_err = NULL;
     int ret = 0;
 
-    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
+    if (vfio_container_devices_dirty_tracking_is_supported(bcontainer)) {
         vfio_devices_dma_logging_stop(bcontainer);
     } else {
         ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index d0b100d1294a3874139b9dc0df949ab00737408a..a094872fe44e90f345328f65795b0b64a090c1b1 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -162,7 +162,8 @@ bool vfio_container_dirty_tracking_is_started(
            bcontainer->dirty_pages_started;
 }
 
-bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
+bool vfio_container_devices_dirty_tracking_is_supported(
+    const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
@@ -240,7 +241,7 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp)
 {
     bool all_device_dirty_tracking =
-        vfio_devices_all_device_dirty_tracking(bcontainer);
+        vfio_container_devices_dirty_tracking_is_supported(bcontainer);
     uint64_t dirty_pages;
     VFIOBitmap vbmap;
     int ret;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index e827ae9167b780ec9776ab98974245defb57590d..9ea03ed618f6aefe35f966c644cbbc127ce7bf06 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -138,7 +138,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     Error *local_err = NULL;
 
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
-        if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
+        if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
             return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
         }
-- 
2.49.0


