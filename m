Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D5BCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v217G-0000NX-6l; Fri, 26 Sep 2025 01:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v217E-0000MA-4Q
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v216y-00019w-R0
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758864909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VTd0HBOnVlMx9kQ3XHypHuH/L0Yt23pMNKs+dB7pes=;
 b=YlzSakeiEOHYMjQ+8//Qx7+7Y/+Gxv4OLsD1H7JZ1G7sXUjkJDSYJe0LQjvA60UZl1M6hf
 H4YZEeHdaI04zORj8XTr+acDrRtAnRsRe+tjvuPNSd6eG40EEmdfvD8amuY2O7dkdCp5LD
 A7N0qdi/kGO/gdjsfVJzSTdr/FHZMrA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-2DpHJvQiPPe_WC7PaIzbwQ-1; Fri,
 26 Sep 2025 01:35:08 -0400
X-MC-Unique: 2DpHJvQiPPe_WC7PaIzbwQ-1
X-Mimecast-MFC-AGG-ID: 2DpHJvQiPPe_WC7PaIzbwQ_1758864907
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F5611800366; Fri, 26 Sep 2025 05:35:07 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2AC4B180057C; Fri, 26 Sep 2025 05:35:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 25/29] vfio-user/pci.c: rename vfio_user_pci_dev_properties[]
 to vfio_user_pci_properties[]
Date: Fri, 26 Sep 2025 07:33:54 +0200
Message-ID: <20250926053358.308198-26-clg@redhat.com>
In-Reply-To: <20250926053358.308198-1-clg@redhat.com>
References: <20250926053358.308198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250925113159.1760317-25-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index e2c5b5744c410d2bb532fb68075a4c4ba93fde43..30f485fdbb12a8e45dbadff4d24ed5e58e093d8a 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -400,7 +400,7 @@ static void vfio_user_pci_reset(DeviceState *dev)
     vfio_pci_post_reset(vdev);
 }
 
-static const Property vfio_user_pci_dev_properties[] = {
+static const Property vfio_user_pci_properties[] = {
     DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
                        vendor_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice,
@@ -452,7 +452,7 @@ static void vfio_user_pci_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, vfio_user_pci_reset);
-    device_class_set_props(dc, vfio_user_pci_dev_properties);
+    device_class_set_props(dc, vfio_user_pci_properties);
 
     object_class_property_add(klass, "socket", "SocketAddress", NULL,
                               vfio_user_pci_set_socket, NULL, NULL);
-- 
2.51.0


