Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB46CD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAm-0000oE-JC; Sun, 14 Jun 2026 15:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAl-0000e1-4H
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAi-0001tC-Qh
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sAlejr7MstV5eT+ruLrczEJBZFqQUgP8BOOtIwWsurw=;
 b=dzfhCtySGytN1B2t4CT4lPv3mvJoXERm+tt/I/MrHOeaciVnJNucpAXhRNm2zotj+oS6Vv
 8xjNXhlLmAzLjWAx0WRxKCj5cck+IvPNSbc/DSelZu/c0ybZVkh5VsmYad2OJTZUyg1oMl
 NaXxlckd40RNhsNE4VwmIbO9ppKXhI4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-XpelZ23GPkKH3yCc-A2Yyg-1; Sun, 14 Jun 2026 15:07:02 -0400
X-MC-Unique: XpelZ23GPkKH3yCc-A2Yyg-1
X-Mimecast-MFC-AGG-ID: XpelZ23GPkKH3yCc-A2Yyg_1781464021
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b2f22ea2so22519385e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464021; x=1782068821; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sAlejr7MstV5eT+ruLrczEJBZFqQUgP8BOOtIwWsurw=;
 b=hTmCIp0KfqZuRNiCP2EOlsiR/6Ozn/cyagxUS5go0ONIyYyCIcX4oAYH8l2hi5m+q0
 5jwBAw04Q9X+nEJTGCbzEF6q3HvuVwuk1RAXFcLYJc3254IpgzygKPNFoq+13aCnimAX
 YdD0T2kZ635vRc2LAXY1nPbsD1fZJ0mr+SSrq06M56JSsIBVqU4qjgeAndLxDJwFwcL+
 EO0//837SGwjERyZPIaGVs9dNQgFgSUQJMitjMUhQXZqzMWHvYw2bOnvNM6ZOci9L3Td
 hAMFsiebayr1uQNeSdK3Fo5FvKZdgWxpNN0yhNHdqYY8LeGIwDxdb/RZE36pF7JK3HV0
 33Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464021; x=1782068821;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sAlejr7MstV5eT+ruLrczEJBZFqQUgP8BOOtIwWsurw=;
 b=h3eH3oRkvwvE2kKCKchPfS4td3pG9V6c5AfGcY3wLgaUAcduxSfrSuWQgUCM3LR5XN
 CmeFmko1Jrr7RPI7t9/i6UJmihHwdU2dzXFg4IeUjYnvEjcs4w9XM7tIkMmSQIZEyBDA
 VBxj0OyBxIso90vKNoU1cIHSqoDNfFSqRl8JelHn57AetU1H/T80lNFRXZVoFjLACxfB
 EZ2egEhtKYRDjin80nlw5Xalv3q9JfAaVGl8fFqDqHz9Etpsd0qW0x6/4AntThbXCoqY
 E0Qk2QoN2mz0/FzflAH5BOtFii3W82vRV82yCoJvXKHsZjZlr5nvVUHToAjAx5uC8Xja
 Ljag==
X-Gm-Message-State: AOJu0YxItI20gD0mFY5KkQmIkU5d+crm1fXcYhMmp8nwReAKEUatsRst
 HIUI7EINub9qrrMHdI9QYQH0Ke9FNjD9HK15uRG2ra8/DVrY4Na/FnHazXbpmfQNXyNvkB0OT4D
 sT7Fl5nx2LPvJz+fcNrFgydShhfMKqTqBeEOyuEJ7hU+ysQdJjz4yhM7pZ+jo3E/bCUpXS9y0w0
 WXL/EIiaRyHO5TJy4eSO6DBBJxn1rh65tqUQ==
X-Gm-Gg: Acq92OGHMrkIu8YPkYpJbEB1/8fLJeCq+adIw/ZMSJTGBxIeWKJ4DJo1l6xhSWU+Jna
 v2DPFEiJLeeWsxQv9zjfhR0eT5Bi4BrMw/75fdUMoc8FKX374BtvlCn50GqP7uczoFLwOmrc61h
 ZfPAJuTge9MPacCHnxak5SWMl30pKtEWVIVDuOq0UOsREPOwdjpVe0N1OpT2IhZB3goiJ5kyoz6
 t35ggpQm3VrfylCC8wn94SLaKkfmpsQT4hugiVpvwZCaxrZQp+RksozUavKkN/tr3VUN6hsVBgG
 D2Xh7/LWDuac+eiMv7svn5zOuLbv0/rQZ6jzaP12AXMkM8k1CxwRWAhqzflCYnzvRU6PIw5fekw
 R64o5IhtB2PJAW3KseRlv949HAWls1AHoWaLcIugC3Rs=
X-Received: by 2002:a05:600c:528c:b0:490:bbc1:d508 with SMTP id
 5b1f17b1804b1-4922005e290mr95373995e9.1.1781464021174; 
 Sun, 14 Jun 2026 12:07:01 -0700 (PDT)
X-Received: by 2002:a05:600c:528c:b0:490:bbc1:d508 with SMTP id
 5b1f17b1804b1-4922005e290mr95373695e9.1.1781464020632; 
 Sun, 14 Jun 2026 12:07:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220345528sm209727415e9.8.2026.06.14.12.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:59 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Lei Yang <leiyang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 029/106] vhost-user: introduce
 vhost_user_has_protocol_feature() helper
Message-ID: <be9ecc9df07d8daef364f43798e78be6282c6b5f.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Make all protocol feature checks in the same way.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-4-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 120 +++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 58 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 7ce17c5b2d..72aeed26ca 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -267,6 +267,12 @@ struct scrub_regions {
     int fd_idx;
 };
 
+static bool vhost_user_has_protocol_feature(struct vhost_dev *dev,
+                                            uint64_t feature)
+{
+    return virtio_has_feature(dev->protocol_features, feature);
+}
+
 static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
 {
     struct vhost_user *u = dev->opaque;
@@ -430,8 +436,8 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
 {
     int fds[VHOST_USER_MAX_RAM_SLOTS];
     size_t fd_num = 0;
-    bool shmfd = virtio_has_feature(dev->protocol_features,
-                                    VHOST_USER_PROTOCOL_F_LOG_SHMFD);
+    bool shmfd =
+        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_LOG_SHMFD);
     int ret;
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_SET_LOG_BASE,
@@ -1001,11 +1007,11 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
     int fds[VHOST_MEMORY_BASELINE_NREGIONS];
     size_t fd_num = 0;
     bool do_postcopy = u->postcopy_listen && u->postcopy_fd.handler;
-    bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
+    bool reply_supported =
+        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
     bool config_mem_slots =
-        virtio_has_feature(dev->protocol_features,
-                           VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS);
+        vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS);
     int ret;
 
     if (do_postcopy) {
@@ -1053,8 +1059,9 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
 static int vhost_user_set_vring_endian(struct vhost_dev *dev,
                                        struct vhost_vring_state *ring)
 {
-    bool cross_endian = virtio_has_feature(dev->protocol_features,
-                                           VHOST_USER_PROTOCOL_F_CROSS_ENDIAN);
+    bool cross_endian =
+        vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_CROSS_ENDIAN);
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_SET_VRING_ENDIAN,
         .hdr.flags = VHOST_USER_VERSION,
@@ -1124,8 +1131,9 @@ static int vhost_user_write_sync(struct vhost_dev *dev, VhostUserMsg *msg,
     int ret;
 
     if (wait_for_reply) {
-        bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                          VHOST_USER_PROTOCOL_F_REPLY_ACK);
+        bool reply_supported =
+            vhost_user_has_protocol_feature(
+                dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
         if (reply_supported) {
             msg->hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
         }
@@ -1475,8 +1483,7 @@ static int vhost_user_set_features(struct vhost_dev *dev,
     ret = vhost_user_set_u64(dev, VHOST_USER_SET_FEATURES, features,
                              log_enabled);
 
-    if (virtio_has_feature(dev->protocol_features,
-                           VHOST_USER_PROTOCOL_F_STATUS)) {
+    if (vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_STATUS)) {
         if (!ret) {
             return vhost_user_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
         }
@@ -1530,8 +1537,8 @@ static int vhost_user_reset_device(struct vhost_dev *dev)
      * Historically, reset was not implemented so only reset devices
      * that are expecting it.
      */
-    if (!virtio_has_feature(dev->protocol_features,
-                            VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
+    if (!vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
         return -ENOSYS;
     }
 
@@ -1588,8 +1595,8 @@ static int vhost_user_backend_handle_vring_host_notifier(struct vhost_dev *dev,
     void *addr;
     char *name;
 
-    if (!virtio_has_feature(dev->protocol_features,
-                            VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) ||
+    if (!vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) ||
         vdev == NULL || queue_idx >= virtio_get_num_queues(vdev)) {
         return -EINVAL;
     }
@@ -1887,13 +1894,13 @@ static int vhost_setup_backend_channel(struct vhost_dev *dev)
     };
     struct vhost_user *u = dev->opaque;
     int sv[2], ret = 0;
-    bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
+    bool reply_supported =
+        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
     Error *local_err = NULL;
     QIOChannel *ioc;
 
-    if (!virtio_has_feature(dev->protocol_features,
-                            VHOST_USER_PROTOCOL_F_BACKEND_REQ)) {
+    if (!vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_BACKEND_REQ)) {
         return 0;
     }
 
@@ -2141,8 +2148,8 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
 
     switch (pnd->reason) {
     case POSTCOPY_NOTIFY_PROBE:
-        if (!virtio_has_feature(dev->protocol_features,
-                                VHOST_USER_PROTOCOL_F_PAGEFAULT)) {
+        if (!vhost_user_has_protocol_feature(
+                dev, VHOST_USER_PROTOCOL_F_PAGEFAULT)) {
             /* TODO: Get the device name into this error somehow */
             error_setg(errp,
                        "vhost-user backend not capable of postcopy");
@@ -2240,7 +2247,7 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
         }
 
         /* query the max queues we support if backend supports Multiple Queue */
-        if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MQ)) {
+        if (vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_MQ)) {
             err = vhost_user_get_u64(dev, VHOST_USER_GET_QUEUE_NUM,
                                      &dev->max_queues);
             if (err < 0) {
@@ -2258,18 +2265,18 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
         }
 
         if (virtio_has_feature(features, VIRTIO_F_IOMMU_PLATFORM) &&
-                !(virtio_has_feature(dev->protocol_features,
-                    VHOST_USER_PROTOCOL_F_BACKEND_REQ) &&
-                 virtio_has_feature(dev->protocol_features,
-                    VHOST_USER_PROTOCOL_F_REPLY_ACK))) {
+            !(vhost_user_has_protocol_feature(
+                dev, VHOST_USER_PROTOCOL_F_BACKEND_REQ) &&
+            vhost_user_has_protocol_feature(
+                dev, VHOST_USER_PROTOCOL_F_REPLY_ACK))) {
             error_setg(errp, "IOMMU support requires reply-ack and "
                        "backend-req protocol features.");
             return -EINVAL;
         }
 
         /* get max memory regions if backend supports configurable RAM slots */
-        if (!virtio_has_feature(dev->protocol_features,
-                                VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS)) {
+        if (!vhost_user_has_protocol_feature(
+                dev, VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS)) {
             u->user->memory_slots = VHOST_MEMORY_BASELINE_NREGIONS;
         } else {
             err = vhost_user_get_max_memslots(dev, &ram_slots);
@@ -2293,8 +2300,8 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
     }
 
     if (dev->migration_blocker == NULL &&
-        !virtio_has_feature(dev->protocol_features,
-                            VHOST_USER_PROTOCOL_F_LOG_SHMFD)) {
+        !vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_LOG_SHMFD)) {
         error_setg(&dev->migration_blocker,
                    "Migration disabled: vhost-user backend lacks "
                    "VHOST_USER_PROTOCOL_F_LOG_SHMFD feature.");
@@ -2363,8 +2370,8 @@ static bool vhost_user_requires_shm_log(struct vhost_dev *dev)
 {
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
 
-    return virtio_has_feature(dev->protocol_features,
-                              VHOST_USER_PROTOCOL_F_LOG_SHMFD);
+    return vhost_user_has_protocol_feature(
+        dev, VHOST_USER_PROTOCOL_F_LOG_SHMFD);
 }
 
 static int vhost_user_migration_done(struct vhost_dev *dev, char* mac_addr)
@@ -2379,8 +2386,7 @@ static int vhost_user_migration_done(struct vhost_dev *dev, char* mac_addr)
     }
 
     /* if backend supports VHOST_USER_PROTOCOL_F_RARP ask it to send the RARP */
-    if (virtio_has_feature(dev->protocol_features,
-                           VHOST_USER_PROTOCOL_F_RARP)) {
+    if (vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_RARP)) {
         msg.hdr.request = VHOST_USER_SEND_RARP;
         msg.hdr.flags = VHOST_USER_VERSION;
         memcpy((char *)&msg.payload.u64, mac_addr, 6);
@@ -2394,11 +2400,11 @@ static int vhost_user_migration_done(struct vhost_dev *dev, char* mac_addr)
 static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
 {
     VhostUserMsg msg;
-    bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
+    bool reply_supported =
+        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
     int ret;
 
-    if (!(dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_NET_MTU))) {
+    if (!vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_NET_MTU)) {
         return 0;
     }
 
@@ -2458,8 +2464,7 @@ static int vhost_user_get_config(struct vhost_dev *dev, uint8_t *config,
         .hdr.size = VHOST_USER_CONFIG_HDR_SIZE + config_len,
     };
 
-    if (!virtio_has_feature(dev->protocol_features,
-                VHOST_USER_PROTOCOL_F_CONFIG)) {
+    if (!vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_CONFIG)) {
         error_setg(errp, "VHOST_USER_PROTOCOL_F_CONFIG not supported");
         return -EINVAL;
     }
@@ -2502,8 +2507,8 @@ static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *data,
 {
     int ret;
     uint8_t *p;
-    bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
+    bool reply_supported =
+        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
 
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_SET_CONFIG,
@@ -2511,8 +2516,7 @@ static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *data,
         .hdr.size = VHOST_USER_CONFIG_HDR_SIZE + size,
     };
 
-    if (!virtio_has_feature(dev->protocol_features,
-                VHOST_USER_PROTOCOL_F_CONFIG)) {
+    if (!vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_CONFIG)) {
         return -ENOTSUP;
     }
 
@@ -2547,8 +2551,9 @@ static int vhost_user_crypto_create_session(struct vhost_dev *dev,
                                             uint64_t *session_id)
 {
     int ret;
-    bool crypto_session = virtio_has_feature(dev->protocol_features,
-                                       VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
+    bool crypto_session =
+        vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
     CryptoDevBackendSessionInfo *backend_info = session_info;
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_CREATE_CRYPTO_SESSION,
@@ -2649,8 +2654,9 @@ static int
 vhost_user_crypto_close_session(struct vhost_dev *dev, uint64_t session_id)
 {
     int ret;
-    bool crypto_session = virtio_has_feature(dev->protocol_features,
-                                       VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
+    bool crypto_session =
+        vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_CLOSE_CRYPTO_SESSION,
         .hdr.flags = VHOST_USER_VERSION,
@@ -2695,8 +2701,8 @@ static int vhost_user_get_inflight_fd(struct vhost_dev *dev,
         .hdr.size = sizeof(msg.payload.inflight),
     };
 
-    if (!virtio_has_feature(dev->protocol_features,
-                            VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+    if (!vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
         return 0;
     }
 
@@ -2763,8 +2769,8 @@ static int vhost_user_set_inflight_fd(struct vhost_dev *dev,
         .hdr.size = sizeof(msg.payload.inflight),
     };
 
-    if (!virtio_has_feature(dev->protocol_features,
-                            VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+    if (!vhost_user_has_protocol_feature(
+            dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
         return 0;
     }
 
@@ -2863,8 +2869,7 @@ void vhost_user_async_close(DeviceState *d,
 
 static int vhost_user_dev_start(struct vhost_dev *dev, bool started)
 {
-    if (!virtio_has_feature(dev->protocol_features,
-                            VHOST_USER_PROTOCOL_F_STATUS)) {
+    if (!vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_STATUS)) {
         return 0;
     }
 
@@ -2889,16 +2894,15 @@ static void vhost_user_reset_status(struct vhost_dev *dev)
         return;
     }
 
-    if (virtio_has_feature(dev->protocol_features,
-                           VHOST_USER_PROTOCOL_F_STATUS)) {
+    if (vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_STATUS)) {
         vhost_user_set_status(dev, 0);
     }
 }
 
 static bool vhost_user_supports_device_state(struct vhost_dev *dev)
 {
-    return virtio_has_feature(dev->protocol_features,
-                              VHOST_USER_PROTOCOL_F_DEVICE_STATE);
+    return vhost_user_has_protocol_feature(
+        dev, VHOST_USER_PROTOCOL_F_DEVICE_STATE);
 }
 
 static int vhost_user_set_device_state_fd(struct vhost_dev *dev,
-- 
MST


