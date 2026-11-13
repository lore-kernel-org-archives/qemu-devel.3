Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE2606BDFC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P+6h2SPk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwFV-0007Pq-CL; Fri, 13 Nov 2026 13:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwF1-0007C9-3h
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwEz-0005O2-A8
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794595392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qHqMyF+EsUpuhc/umHMaBn21/oZRB5bPH9WTaH8/ks=;
 b=P+6h2SPk04z7JDekb7gQGEm9gZxTMyUolr2Vrb7MW3Vpq5nIm8tOfVLWGitoQ0q3qugXBd
 sqIQGfECJFNCmKSp5Dpm99OBfZE8nH8rhiZttnl4qzKblM1BvXenvtjVcV4BuE40wrzdlA
 ttBO+mGUk0fy8nDxIoivgBL4rA5Zz3U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-isNqCI_sOPuBgnoIMLzL8Q-1; Fri,
 13 Nov 2026 13:43:10 -0500
X-MC-Unique: isNqCI_sOPuBgnoIMLzL8Q-1
X-Mimecast-MFC-AGG-ID: isNqCI_sOPuBgnoIMLzL8Q_1794595389
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAE42195606F
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 18:43:08 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C2BB1955DB9; Fri, 13 Nov 2026 18:43:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 06/26] hw/xen: mark all Xen related object types as being
 secure
Date: Fri, 13 Nov 2026 18:42:34 +0000
Message-ID: <20261113184254.2524253-7-berrange@redhat.com>
In-Reply-To: <20261113184254.2524253-1-berrange@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All Xen paravirtualized devices are intended to provide a host /
guest security barrier, so mark all Xen object types as scure.

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/block/xen-block.c        | 2 ++
 hw/char/xen_console.c       | 1 +
 hw/i386/xen/xen-hvm.c       | 1 +
 hw/i386/xen/xen_platform.c  | 1 +
 hw/i386/xen/xen_pvdevice.c  | 1 +
 hw/net/xen_nic.c            | 1 +
 hw/xen/xen-bus.c            | 2 ++
 hw/xen/xen-legacy-backend.c | 3 +++
 hw/xen/xen_pt.c             | 1 +
 9 files changed, 13 insertions(+)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index ffdb0806573..e04190cd26f 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -742,6 +742,7 @@ static const TypeInfo xen_disk_type_info = {
     .parent = TYPE_XEN_BLOCK_DEVICE,
     .instance_size = sizeof(XenDiskDevice),
     .class_init = xen_disk_class_init,
+    .secure = true,
 };
 
 static void xen_cdrom_unrealize(XenBlockDevice *blockdev)
@@ -789,6 +790,7 @@ static const TypeInfo xen_cdrom_type_info = {
     .parent = TYPE_XEN_BLOCK_DEVICE,
     .instance_size = sizeof(XenCDRomDevice),
     .class_init = xen_cdrom_class_init,
+    .secure = true,
 };
 
 static void xen_block_register_types(void)
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index bdeb76dc870..df6a708494d 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -513,6 +513,7 @@ static const TypeInfo xen_console_type_info = {
     .parent = TYPE_XEN_DEVICE,
     .instance_size = sizeof(XenConsole),
     .class_init = xen_console_class_init,
+    .secure = true,
 };
 
 static void xen_console_register_types(void)
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index b2378fe3f05..f7a154b8307 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -792,6 +792,7 @@ static const TypeInfo xen_i8259_type_infos[] = {
         .name = TYPE_XEN_I8259_PIC,
         .parent = TYPE_DEVICE,
         .instance_init = xen_i8259_pic_init,
+        .secure = true,
     },
 };
 
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index c8b852be0cc..ec0084d6fb8 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -604,6 +604,7 @@ static const TypeInfo xen_platform_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIXenPlatformState),
     .class_init    = xen_platform_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index fab26a06af1..74636046d0c 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -139,6 +139,7 @@ static const TypeInfo xen_pv_type_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(XenPVDevice),
     .class_init    = xen_pv_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index f4d0b060130..e615303da6a 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -579,6 +579,7 @@ static const TypeInfo xen_net_type_info = {
     .parent = TYPE_XEN_DEVICE,
     .instance_size = sizeof(XenNetDev),
     .class_init = xen_netdev_class_init,
+    .secure = true,
 };
 
 static void xen_net_register_types(void)
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 8def3bb68bc..17bbbe2ea71 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -404,6 +404,7 @@ static const TypeInfo xen_bus_type_info = {
     .instance_size = sizeof(XenBus),
     .class_size = sizeof(XenBusClass),
     .class_init = xen_bus_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
@@ -1141,6 +1142,7 @@ static const TypeInfo xen_bridge_type_info = {
     .name = TYPE_XEN_BRIDGE,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(XenBridge),
+    .secure = true,
 };
 
 static void xen_register_types(void)
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 7977b527127..75f8ac7efde 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -648,6 +648,7 @@ static const TypeInfo xendev_type_info = {
     .parent        = TYPE_DYNAMIC_SYS_BUS_DEVICE,
     .class_init    = xendev_class_init,
     .instance_size = sizeof(XenLegacyDevice),
+    .secure        = true,
 };
 
 static void xen_sysbus_class_init(ObjectClass *klass, const void *data)
@@ -661,6 +662,7 @@ static const TypeInfo xensysbus_info = {
     .name       = TYPE_XENSYSBUS,
     .parent     = TYPE_BUS,
     .class_init = xen_sysbus_class_init,
+    .secure     = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
@@ -670,6 +672,7 @@ static const TypeInfo xensysbus_info = {
 static const TypeInfo xensysdev_info = {
     .name          = TYPE_XENSYSDEV,
     .parent        = TYPE_SYS_BUS_DEVICE,
+    .secure        = true,
 };
 
 static void xenbe_register_types(void)
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 0fe9c0aada8..504c5593188 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -1079,6 +1079,7 @@ static const TypeInfo xen_pci_passthrough_info = {
     .instance_finalize = xen_pci_passthrough_finalize,
     .class_init = xen_pci_passthrough_class_init,
     .class_size = sizeof(XenPTDeviceClass),
+    .secure = true,
     .instance_init = xen_pci_passthrough_instance_init,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-- 
2.56.1


