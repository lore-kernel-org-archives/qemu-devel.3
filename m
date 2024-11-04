Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6F8D1BDF5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84IA-0007EW-60; Mon, 04 Nov 2024 16:07:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84I4-0006sN-NS
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84I1-0005Mx-Ek
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FqQ0aa3x0u9CKa8kr4LeoMUuDzdYhl7I/Bsp+7L/OPI=;
 b=ZAm9tMipetzAUI/0E56nQHWicWBkV9XGI+c3Mnw6zZ0HNRZPHPsJUfzpWdw/rGgoL2EU+i
 BGTvvnRGAKTmRYwMqRdGH3kdmszz/NftCra0YR4IVnefx73hrNpyuE21QBkhPATCjZayOl
 y/sDEGo1bvCMqO+modw+9qRYz2MSnJE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-vdaga5M8Os-Wl2SvGbTxKA-1; Mon, 04 Nov 2024 16:07:07 -0500
X-MC-Unique: vdaga5M8Os-Wl2SvGbTxKA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43157cff1d1so34454505e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754426; x=1731359226;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FqQ0aa3x0u9CKa8kr4LeoMUuDzdYhl7I/Bsp+7L/OPI=;
 b=S2cFXX+eye87Hld0n0mKgFWqRFR3FB+gr8qic/M9hK6f9iFp0eMDY11EHyPtAUheUZ
 7V//KJ1rM/BO2ZFuQQt2IgcYRXMORdtSdcwszR0VUzT9Lezg6amPfefAYrWgvRbD9uTB
 vKSbfYyhAOVH4yOm2GKF747zE8/OMTOpcirTAItLNSB6/n1v9FbgFRQ6VUfttXu3/65A
 MnfYVFpBzm/cDPk+yWoE1vQpA+O1+lCWpqIg/iRoOpwU4fOK7TJ/rlmGfKahjYioFnad
 IMFRXhcWogOWG5kzTdpC1qkVhCA9cGROc2taYtl9eGyfwRl0Ku2zw+yjjF3fgclqpg2Z
 ChZQ==
X-Gm-Message-State: AOJu0Yy4XfcLcBbtfdVYkjq4dIS3s67YZD+kYt9rIjcY5A98CdKF6HGY
 1Mz4cphiEZL3JUJcpkKRQMRc64X5b/zutLg70YwWRdFFcmbTvZptw5WmdeuwGJlm6gvcZ2Bd2Go
 LHaDz0Yg+ANgtMpQZ9FvBfaFccpYBwHNoJQfq6AC5MJh0hyz8qclVjdaxJ4jPS40IDrkFZZVEXK
 C/3TROztq7datcYbxCZejLh6Pimq9I5A==
X-Received: by 2002:a05:600c:3b14:b0:42c:de34:34c1 with SMTP id
 5b1f17b1804b1-4327b6f9590mr147925585e9.2.1730754425667; 
 Mon, 04 Nov 2024 13:07:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjC15QGZ9Uy0JogRL8BAjsl6HqOej3zVNSKEc+aSuedQkCiBQAURBevu4aSb5UQvVxEm0ItQ==
X-Received: by 2002:a05:600c:3b14:b0:42c:de34:34c1 with SMTP id
 5b1f17b1804b1-4327b6f9590mr147925265e9.2.1730754425189; 
 Mon, 04 Nov 2024 13:07:05 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9ca704sm194495995e9.41.2024.11.04.13.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:07:04 -0800 (PST)
Date: Mon, 4 Nov 2024 16:07:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Subject: [PULL 23/65] qapi: introduce device-sync-config
Message-ID: <3f98408e2e4fb1792102aed2cd5425aa0e34cc9c.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Add command to sync config from vhost-user backend to the device. It
may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
triggered interrupt to the guest or just not available (not supported
by vhost-user server).

Command result is racy if allow it during migration. Let's not allow
that.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Raphael Norwitz <raphael@enfabrica.net>
Message-Id: <20240920094936.450987-4-vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/qdev.json            | 24 ++++++++++++++++++++++++
 include/hw/qdev-core.h    |  6 ++++++
 hw/block/vhost-user-blk.c |  1 +
 hw/virtio/virtio-pci.c    |  9 +++++++++
 system/qdev-monitor.c     | 38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 78 insertions(+)

diff --git a/qapi/qdev.json b/qapi/qdev.json
index 53d147c7b4..2a581129c9 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -163,3 +163,27 @@
 ##
 { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
   'data': { '*device': 'str', 'path': 'str' } }
+
+##
+# @device-sync-config:
+#
+# Synchronize device configuration from host to guest part.  First,
+# copy the configuration from the host part (backend) to the guest
+# part (frontend).  Then notify guest software that device
+# configuration changed.
+#
+# The command may be used to notify the guest about block device
+# capcity change.  Currently only vhost-user-blk device supports
+# this.
+#
+# @id: the device's ID or QOM path
+#
+# Features:
+#
+# @unstable: The command is experimental.
+#
+# Since: 9.1
+##
+{ 'command': 'device-sync-config',
+  'features': [ 'unstable' ],
+  'data': {'id': 'str'} }
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index aa97c34a4b..94914858d8 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -95,6 +95,7 @@ typedef void (*DeviceUnrealize)(DeviceState *dev);
 typedef void (*DeviceReset)(DeviceState *dev);
 typedef void (*BusRealize)(BusState *bus, Error **errp);
 typedef void (*BusUnrealize)(BusState *bus);
+typedef int (*DeviceSyncConfig)(DeviceState *dev, Error **errp);
 
 /**
  * struct DeviceClass - The base class for all devices.
@@ -103,6 +104,9 @@ typedef void (*BusUnrealize)(BusState *bus);
  * property is changed to %true.
  * @unrealize: Callback function invoked when the #DeviceState:realized
  * property is changed to %false.
+ * @sync_config: Callback function invoked when QMP command device-sync-config
+ * is called. Should synchronize device configuration from host to guest part
+ * and notify the guest about the change.
  * @hotpluggable: indicates if #DeviceClass is hotpluggable, available
  * as readonly "hotpluggable" property of #DeviceState instance
  *
@@ -162,6 +166,7 @@ struct DeviceClass {
     DeviceReset legacy_reset;
     DeviceRealize realize;
     DeviceUnrealize unrealize;
+    DeviceSyncConfig sync_config;
 
     /**
      * @vmsd: device state serialisation description for
@@ -547,6 +552,7 @@ bool qdev_hotplug_allowed(DeviceState *dev, Error **errp);
  */
 HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
 void qdev_unplug(DeviceState *dev, Error **errp);
+int qdev_sync_config(DeviceState *dev, Error **errp);
 void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
                                   DeviceState *dev, Error **errp);
 void qdev_machine_creation_done(void);
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 48b3dabb8d..7996e49821 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -591,6 +591,7 @@ static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
 
     device_class_set_props(dc, vhost_user_blk_properties);
     dc->vmsd = &vmstate_vhost_user_blk;
+    dc->sync_config = vhost_user_blk_sync_config;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize = vhost_user_blk_device_realize;
     vdc->unrealize = vhost_user_blk_device_unrealize;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4d832fe845..c5a809b956 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2385,6 +2385,14 @@ static void virtio_pci_dc_realize(DeviceState *qdev, Error **errp)
     vpciklass->parent_dc_realize(qdev, errp);
 }
 
+static int virtio_pci_sync_config(DeviceState *dev, Error **errp)
+{
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+
+    return qdev_sync_config(DEVICE(vdev), errp);
+}
+
 static void virtio_pci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -2401,6 +2409,7 @@ static void virtio_pci_class_init(ObjectClass *klass, void *data)
     device_class_set_parent_realize(dc, virtio_pci_dc_realize,
                                     &vpciklass->parent_dc_realize);
     rc->phases.hold = virtio_pci_bus_reset_hold;
+    dc->sync_config = virtio_pci_sync_config;
 }
 
 static const TypeInfo virtio_pci_info = {
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 6671137a91..127456080b 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -23,6 +23,7 @@
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
 #include "sysemu/arch_init.h"
+#include "sysemu/runstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
 #include "qapi/qmp/dispatch.h"
@@ -977,6 +978,43 @@ void qmp_device_del(const char *id, Error **errp)
     }
 }
 
+int qdev_sync_config(DeviceState *dev, Error **errp)
+{
+    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+
+    if (!dc->sync_config) {
+        error_setg(errp, "device-sync-config is not supported for '%s'",
+                   object_get_typename(OBJECT(dev)));
+        return -ENOTSUP;
+    }
+
+    return dc->sync_config(dev, errp);
+}
+
+void qmp_device_sync_config(const char *id, Error **errp)
+{
+    DeviceState *dev;
+
+    /*
+     * During migration there is a race between syncing`configuration
+     * and migrating it (if migrate first, that target would get
+     * outdated version), so let's just not allow it.
+     */
+
+    if (migration_is_running()) {
+        error_setg(errp, "Config synchronization is not allowed "
+                   "during migration");
+        return;
+    }
+
+    dev = find_device_state(id, true, errp);
+    if (!dev) {
+        return;
+    }
+
+    qdev_sync_config(dev, errp);
+}
+
 void hmp_device_add(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
-- 
MST


