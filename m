Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84599CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf97-0007FW-37; Mon, 08 Sep 2025 12:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8c-0006fl-3P
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8Y-0001bC-99
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S92+nlsO4FvoezEykD/GekIndRhl9sPOpetgVoPS+TU=;
 b=heSqrfyvAhSrRI5HM5fWEWWFHbdX0mh3W8G95Bb9FbEx16F5t86zO+ZiFVeUJVV6/kvlVJ
 GwhEPDARHJpDDUSLBnBXFUrletZe/6OqdlY++Eu4livDNvPAgNjYG7FcxFSnK52satN2Mw
 N0efy4Y1qYTcuo0HIlxwU6HdV1eQ+u8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-N2pPgd9_P6uTPU1mWjOaUg-1; Mon,
 08 Sep 2025 12:54:30 -0400
X-MC-Unique: N2pPgd9_P6uTPU1mWjOaUg-1
X-Mimecast-MFC-AGG-ID: N2pPgd9_P6uTPU1mWjOaUg_1757350469
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5C99195609F; Mon,  8 Sep 2025 16:54:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31AA130001B5; Mon,  8 Sep 2025 16:54:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/31] vfio/vfio-container-base.h: update VFIOContainerBase
 declaration
Date: Mon,  8 Sep 2025 18:53:34 +0200
Message-ID: <20250908165354.1731444-12-clg@redhat.com>
In-Reply-To: <20250908165354.1731444-1-clg@redhat.com>
References: <20250908165354.1731444-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Update the VFIOContainerBase declaration to match our current coding
guidelines: remove the explicit typedef (this is already handled by the
OBJECT_DECLARE_TYPE() macro), add a blank line after the parent object,
rename parent to parent_obj, and move the macro declaration next to the
VFIOContainerBase struct declaration.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250715093110.107317-2-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index bded6e993ffd34910f5583bf8e94c81c41f4885f..acbd48a18a3a35ba6c5484d6d0fb12c23a983f77 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -33,8 +33,9 @@ typedef struct VFIOAddressSpace {
 /*
  * This is the base object for vfio container backends
  */
-typedef struct VFIOContainerBase {
-    Object parent;
+struct VFIOContainerBase {
+    Object parent_obj;
+
     VFIOAddressSpace *space;
     MemoryListener listener;
     Error *error;
@@ -51,7 +52,10 @@ typedef struct VFIOContainerBase {
     QLIST_HEAD(, VFIODevice) device_list;
     GList *iova_ranges;
     NotifierWithReturn cpr_reboot_notifier;
-} VFIOContainerBase;
+};
+
+#define TYPE_VFIO_IOMMU "vfio-iommu"
+OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 
 typedef struct VFIOGuestIOMMU {
     VFIOContainerBase *bcontainer;
@@ -105,14 +109,11 @@ vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
     return bcontainer->pgsizes;
 }
 
-#define TYPE_VFIO_IOMMU "vfio-iommu"
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
 #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
 #define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
 
-OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
-
 struct VFIOIOMMUClass {
     ObjectClass parent_class;
 
-- 
2.51.0


