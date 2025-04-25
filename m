Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27D3C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ejv-0005Za-HX; Fri, 25 Apr 2025 04:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ejo-00059Z-9J
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ejm-0003Ji-AH
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8prw8ArUl08z4p7fMvLq1bYbVkoyHkBoERWS4TBqkVk=;
 b=JLTljBd81ZHmJSBVxRhS33wgp2yvD44ngUIvtf3t1dq3f2FKtGnaB65sc88xKIayWw++Gz
 yDrCvkcNVdXlFip4gnbg34fPpI6HRc2zeu7pE5zGfAbvbBvbzYnXkTNwlBxdbDhNHltA+w
 iNBcaJ69sN1z61Hojp9uzsc3IpvKiOw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-Wcxcg3mEOGCoGcl-NLjkJw-1; Fri,
 25 Apr 2025 04:48:39 -0400
X-MC-Unique: Wcxcg3mEOGCoGcl-NLjkJw-1
X-Mimecast-MFC-AGG-ID: Wcxcg3mEOGCoGcl-NLjkJw_1745570918
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 629FA1954B0D; Fri, 25 Apr 2025 08:48:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C08730001A2; Fri, 25 Apr 2025 08:48:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 John Levon <john.levon@nutanix.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 33/50] vfio: Rename vfio_devices_all_dirty_tracking_started()
Date: Fri, 25 Apr 2025 10:46:26 +0200
Message-ID: <20250425084644.102196-34-clg@redhat.com>
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

Also rename vfio_devices_all_device_dirty_tracking_started() while at
it and use the prefix 'vfio_container_devices_' for routines simply
looping over the container's device list.

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-30-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 3 ++-
 hw/vfio/common.c                      | 2 +-
 hw/vfio/container-base.c              | 6 +++---
 hw/vfio/container.c                   | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 69fb698bc19a693de92d361097413557e3cc2b62..9b33e71f59bba1f3cbe10c307172422ca4e4c2ce 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -89,7 +89,8 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
                                        MemoryRegionSection *section);
 int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start, Error **errp);
-bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
+bool vfio_container_dirty_tracking_is_started(
+    const VFIOContainerBase *bcontainer);
 bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
 int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index ed49ef88a865521e16584844721b6ffa09427f18..89b7a71385abfff888c5208a6b4c588b4217716a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -55,7 +55,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
-    if (!vfio_devices_all_dirty_tracking_started(bcontainer)) {
+    if (!vfio_container_dirty_tracking_is_started(bcontainer)) {
         return false;
     }
 
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 3c8039d52aa1838ca942a7ac29ebbd61fa074e67..1beba37a7739d76630c3e7db16a8d04926cb1aee 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -141,7 +141,7 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
     return ret;
 }
 
-static bool vfio_devices_all_device_dirty_tracking_started(
+static bool vfio_container_devices_dirty_tracking_is_started(
     const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
@@ -155,10 +155,10 @@ static bool vfio_devices_all_device_dirty_tracking_started(
     return true;
 }
 
-bool vfio_devices_all_dirty_tracking_started(
+bool vfio_container_dirty_tracking_is_started(
     const VFIOContainerBase *bcontainer)
 {
-    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
+    return vfio_container_devices_dirty_tracking_is_started(bcontainer) ||
            bcontainer->dirty_pages_started;
 }
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c55fe8e4bede9d7e228af2472242efb48bc7d037..e8cd9271365e4b2f55fac9ec402c292607f7fc1d 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -137,7 +137,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
-    if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
+    if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
             bcontainer->dirty_pages_supported) {
             return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
-- 
2.49.0


