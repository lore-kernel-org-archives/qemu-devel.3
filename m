Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BF9C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7sL-0007H2-Ts; Wed, 15 Jan 2025 13:12:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7rB-00018L-OX
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:11:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7r9-00078p-SW
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BEGdjo90qqstcjYDzVJsyocDHaSy9bqqB/C1TwUZ5n8=;
 b=VWgSJnGcpdytGHcWBgh9IesEXsGZDhTfr+VtMU9Yj43k97FltUI3wpCvXbl228VTcEx2RE
 gSlCdl2ZPjtoSzmZ0el5WhuyeCpTLmJ/nDt9GVgmM5NnK6+BJ9FCtUzafQh/YDcU6hCGv1
 0xyAvGJ2ONjhqjuL7ZKL/iHNn6jL6Mc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-lXlZ7V0zPDmaN1bTpWk4gA-1; Wed, 15 Jan 2025 13:11:05 -0500
X-MC-Unique: lXlZ7V0zPDmaN1bTpWk4gA-1
X-Mimecast-MFC-AGG-ID: lXlZ7V0zPDmaN1bTpWk4gA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361ecebc5bso36870885e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964664; x=1737569464;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEGdjo90qqstcjYDzVJsyocDHaSy9bqqB/C1TwUZ5n8=;
 b=JnIzb87/z0J2Qpuln8NtOInGf8OTJTT3Mg1Z3/1b+2J2+YwW40t3/VQQRAFp7KL+Kr
 EM7YAS3JYVSCW6f144nfQiuFSxZ0LsOD2Sz5u0YD5Vz9tXeOvoDdKvNS7yOY8Cj7kD/s
 mc9AkZ36Fsvx6j6XBcCq00TDC/fyC9UsMxQe1wkTb/5sjwKBV9LjQcT8zUrtrwF+cWhw
 jVYzRaqxhJbdQ0rw7UZyRRP1Xq2ONpDjISfujU9zyrBaO8xQsH9b9cIR7DmxTjE4m0LJ
 8UDl1muXPtW3D3YMroeMAbkUMyXkYfdfru7EcS/A2bzFSoyhV3lSVgj5SdyPUxH2XJhi
 f6Wg==
X-Gm-Message-State: AOJu0YxPFZjytznZ/biLfC5wKFesxnsrd/jQw9BxQXOrmDbJaXYcwq1a
 HRnrM/AY1Ggo6nts3TETR3b1M542eRifie0lLuo5RuQaKb+/yWGaWet8KEF0pN9TEj0kACs7Fs4
 HwjcRoiGrB2au1wT8TBEE7smFfxfv/XEswGql2HNEhiPHCd+4cJn4XVhOBqbL1upt1+YDsRRXCZ
 zDt7vv94yIktFJL4vfpKE4lcUCnHc5ug==
X-Gm-Gg: ASbGncv+SpyZt5gXJb6fASGvdYKdG2GwqOtu+9jRn4wKdP1pokMbeJgR5s3dn7D9ysj
 sXXjGkA+lSdxBzOzjb6LYIjcpRgLbOhSI6YHzKhPpwroyi60CE3I+pveoY8JAQzz9s4E+oYEWj8
 S0WPBs0OfomG4CTOOt0Vfa+9VGfh3CBOv4adsYzz1im36TmnW78oh/jbdTutymqlw3wC24Tnkdj
 m1d/oUR3i3tVxgFR8FDAPFdC+iV7yMEoFPv9VvNADk4ybXWKQGQ
X-Received: by 2002:a05:600c:4586:b0:431:44fe:fd9f with SMTP id
 5b1f17b1804b1-436e26f041bmr246316635e9.23.1736964664352; 
 Wed, 15 Jan 2025 10:11:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+V2hQZZ9f5rOnSH6Sk4dEveyDzjCfNx8NCFMjPNHi2wdKyOzMNhGHuNbivQsZb3eiaxAPNg==
X-Received: by 2002:a05:600c:4586:b0:431:44fe:fd9f with SMTP id
 5b1f17b1804b1-436e26f041bmr246316375e9.23.1736964663942; 
 Wed, 15 Jan 2025 10:11:03 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74e5e69sm31081175e9.37.2025.01.15.10.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:11:03 -0800 (PST)
Date: Wed, 15 Jan 2025 13:11:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 48/48] virtio-net: vhost-user: Implement internal migration
Message-ID: <60f543ad917fad731e39ff8ce2ca83b9a9cc9d90.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Laurent Vivier <lvivier@redhat.com>

Add support of VHOST_USER_PROTOCOL_F_DEVICE_STATE in virtio-net
with vhost-user backend.

Cc: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20250115135044.799698-3-lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 135 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 112 insertions(+), 23 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 06f096abf6..85e14b788c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3337,6 +3337,117 @@ static const VMStateDescription vmstate_virtio_net_rss = {
     },
 };
 
+static struct vhost_dev *virtio_net_get_vhost(VirtIODevice *vdev)
+{
+    VirtIONet *n = VIRTIO_NET(vdev);
+    NetClientState *nc;
+    struct vhost_net *net;
+
+    if (!n->nic) {
+        return NULL;
+    }
+
+    nc = qemu_get_queue(n->nic);
+    if (!nc) {
+        return NULL;
+    }
+
+    net = get_vhost_net(nc->peer);
+    if (!net) {
+        return NULL;
+    }
+
+    return &net->dev;
+}
+
+static int vhost_user_net_save_state(QEMUFile *f, void *pv, size_t size,
+                                     const VMStateField *field,
+                                     JSONWriter *vmdesc)
+{
+    VirtIONet *n = pv;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    struct vhost_dev *vhdev;
+    Error *local_error = NULL;
+    int ret;
+
+    vhdev = virtio_net_get_vhost(vdev);
+    if (vhdev == NULL) {
+        error_reportf_err(local_error,
+                          "Error getting vhost back-end of %s device %s: ",
+                          vdev->name, vdev->parent_obj.canonical_path);
+        return -1;
+    }
+
+    ret = vhost_save_backend_state(vhdev, f, &local_error);
+    if (ret < 0) {
+        error_reportf_err(local_error,
+                          "Error saving back-end state of %s device %s: ",
+                          vdev->name, vdev->parent_obj.canonical_path);
+        return ret;
+    }
+
+    return 0;
+}
+
+static int vhost_user_net_load_state(QEMUFile *f, void *pv, size_t size,
+                                     const VMStateField *field)
+{
+    VirtIONet *n = pv;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    struct vhost_dev *vhdev;
+    Error *local_error = NULL;
+    int ret;
+
+    vhdev = virtio_net_get_vhost(vdev);
+    if (vhdev == NULL) {
+        error_reportf_err(local_error,
+                          "Error getting vhost back-end of %s device %s: ",
+                          vdev->name, vdev->parent_obj.canonical_path);
+        return -1;
+    }
+
+    ret = vhost_load_backend_state(vhdev, f, &local_error);
+    if (ret < 0) {
+        error_reportf_err(local_error,
+                          "Error loading  back-end state of %s device %s: ",
+                          vdev->name, vdev->parent_obj.canonical_path);
+        return ret;
+    }
+
+    return 0;
+}
+
+static bool vhost_user_net_is_internal_migration(void *opaque)
+{
+    VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    struct vhost_dev *vhdev;
+
+    vhdev = virtio_net_get_vhost(vdev);
+    if (vhdev == NULL) {
+        return false;
+    }
+
+    return vhost_supports_device_state(vhdev);
+}
+
+static const VMStateDescription vhost_user_net_backend_state = {
+    .name = "virtio-net-device/backend",
+    .version_id = 0,
+    .needed = vhost_user_net_is_internal_migration,
+    .fields = (const VMStateField[]) {
+        {
+            .name = "backend",
+            .info = &(const VMStateInfo) {
+                .name = "virtio-net vhost-user backend state",
+                .get = vhost_user_net_load_state,
+                .put = vhost_user_net_save_state,
+            },
+         },
+         VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio_net_device = {
     .name = "virtio-net-device",
     .version_id = VIRTIO_NET_VM_VERSION,
@@ -3389,6 +3500,7 @@ static const VMStateDescription vmstate_virtio_net_device = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_virtio_net_rss,
+        &vhost_user_net_backend_state,
         NULL
     }
 };
@@ -3950,29 +4062,6 @@ static bool dev_unplug_pending(void *opaque)
     return vdc->primary_unplug_pending(dev);
 }
 
-static struct vhost_dev *virtio_net_get_vhost(VirtIODevice *vdev)
-{
-    VirtIONet *n = VIRTIO_NET(vdev);
-    NetClientState *nc;
-    struct vhost_net *net;
-
-    if (!n->nic) {
-        return NULL;
-    }
-
-    nc = qemu_get_queue(n->nic);
-    if (!nc) {
-        return NULL;
-    }
-
-    net = get_vhost_net(nc->peer);
-    if (!net) {
-        return NULL;
-    }
-
-    return &net->dev;
-}
-
 static const VMStateDescription vmstate_virtio_net = {
     .name = "virtio-net",
     .minimum_version_id = VIRTIO_NET_VM_VERSION,
-- 
MST


