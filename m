Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1022AC31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8iE-0001xe-07; Wed, 03 Jul 2024 18:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8iC-0001xB-51
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8i8-0000rU-2x
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gfd+vfybB3O3+4pkXHRWr1BbxFsd2M2r8td4r0aSbjQ=;
 b=DpakpC+RHtybI+92CYXmmvWyEaCPajkHdmO6DksKYxZ1JMOkwIa3Xyp/+T8HBm7782RK4p
 xR7tnw/DJ16G7ELyPzd2re5bX4LgvngMjbeXZWSEn7GuF5B+7fdPvhl0tNGBBkudl3bozy
 B8HtXovjLrgQfctKSXIHZMog2eKUW8k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-VcZP3O6JPY6Kz1FwZBMPZw-1; Wed, 03 Jul 2024 18:44:21 -0400
X-MC-Unique: VcZP3O6JPY6Kz1FwZBMPZw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-58c7800d03eso4724a12.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046660; x=1720651460;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfd+vfybB3O3+4pkXHRWr1BbxFsd2M2r8td4r0aSbjQ=;
 b=IxuziDzHyDsYa3ktKCGobVQIIv0bOJtWNX7ESDm6KcBNklzHNYfCTjIu3wWUxVWen7
 chMIXawif+OT4bnKXr7swP7IqlKt6OvN3RbYCKufVe5X6SOOrTaQxVz08qbzI5M0Cg4Y
 6l9xhA0u1Szv5cxCtuytK+nUb0f+HjKSiObrhxstgQNeOl8ZYyZNnBR49J6BlVSMWp8w
 c43CbjOkrzCzPrLYD852bAFPaNkG0K1HWj4jNcXTZrAebTM4rv5nmxxnfocsuDVOtNEa
 LnOpFuJItZXLn05/JeTysCIviXNaqcuarz11BrketR2hNzfLf8k2dyGyo505p2u9GHNy
 +B+A==
X-Gm-Message-State: AOJu0YwzAlk3bXCbVYKh9QT7TWGAsEtjTSAToeKcdDdgbaSFji2hpw2U
 5mq/W/Q/CXCfv2eLitanpCLkFaNg9j8TY4yblVYl8Q6cDG3mymVT4zWa9SI1P5fTg55DnetMdkF
 Tnjoc9lkr8sDiWvqFHuZMRrdHbtqlWbegBLQGH9nAIeGRmFMNnQYOm+JGdzhfXqzSSXwX/5q4C3
 Qa9nntFD/oI+dzuiccyPyizf+m49leyg==
X-Received: by 2002:a05:6402:234f:b0:58d:b83c:6404 with SMTP id
 4fb4d7f45d1cf-58db83c65dcmr1084961a12.13.1720046659967; 
 Wed, 03 Jul 2024 15:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvcN4XQqXSHuRAhpXDQO35qvl+D4d+Z490OpTN05A3CxxU3CmAwKUebV/X1LB3ywCenaBryA==
X-Received: by 2002:a05:6402:234f:b0:58d:b83c:6404 with SMTP id
 4fb4d7f45d1cf-58db83c65dcmr1084941a12.13.1720046659138; 
 Wed, 03 Jul 2024 15:44:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58613159103sm7632478a12.24.2024.07.03.15.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:44:18 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:44:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Si-Wei Liu <si-wei.liu@oracle.com>
Subject: [PULL v3 01/85] vhost: dirty log should be per backend type
Message-ID: <51d59a64eed6c2cd2d2f991f44ffbe21eb33c733.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Si-Wei Liu <si-wei.liu@oracle.com>

There could be a mix of both vhost-user and vhost-kernel clients
in the same QEMU process, where separate vhost loggers for the
specific vhost type have to be used. Make the vhost logger per
backend type, and have them properly reference counted.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Message-Id: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4acd77e890..a1e8b79e1a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -43,8 +43,8 @@
     do { } while (0)
 #endif
 
-static struct vhost_log *vhost_log;
-static struct vhost_log *vhost_log_shm;
+static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
+static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
 
 /* Memslots used by backends that support private memslots (without an fd). */
 static unsigned int used_memslots;
@@ -287,6 +287,10 @@ static int vhost_set_backend_type(struct vhost_dev *dev,
         r = -1;
     }
 
+    if (r == 0) {
+        assert(dev->vhost_ops->backend_type == backend_type);
+    }
+
     return r;
 }
 
@@ -319,16 +323,22 @@ static struct vhost_log *vhost_log_alloc(uint64_t size, bool share)
     return log;
 }
 
-static struct vhost_log *vhost_log_get(uint64_t size, bool share)
+static struct vhost_log *vhost_log_get(VhostBackendType backend_type,
+                                       uint64_t size, bool share)
 {
-    struct vhost_log *log = share ? vhost_log_shm : vhost_log;
+    struct vhost_log *log;
+
+    assert(backend_type > VHOST_BACKEND_TYPE_NONE);
+    assert(backend_type < VHOST_BACKEND_TYPE_MAX);
+
+    log = share ? vhost_log_shm[backend_type] : vhost_log[backend_type];
 
     if (!log || log->size != size) {
         log = vhost_log_alloc(size, share);
         if (share) {
-            vhost_log_shm = log;
+            vhost_log_shm[backend_type] = log;
         } else {
-            vhost_log = log;
+            vhost_log[backend_type] = log;
         }
     } else {
         ++log->refcnt;
@@ -340,11 +350,20 @@ static struct vhost_log *vhost_log_get(uint64_t size, bool share)
 static void vhost_log_put(struct vhost_dev *dev, bool sync)
 {
     struct vhost_log *log = dev->log;
+    VhostBackendType backend_type;
 
     if (!log) {
         return;
     }
 
+    assert(dev->vhost_ops);
+    backend_type = dev->vhost_ops->backend_type;
+
+    if (backend_type == VHOST_BACKEND_TYPE_NONE ||
+        backend_type >= VHOST_BACKEND_TYPE_MAX) {
+        return;
+    }
+
     --log->refcnt;
     if (log->refcnt == 0) {
         /* Sync only the range covered by the old log */
@@ -352,13 +371,13 @@ static void vhost_log_put(struct vhost_dev *dev, bool sync)
             vhost_log_sync_range(dev, 0, dev->log_size * VHOST_LOG_CHUNK - 1);
         }
 
-        if (vhost_log == log) {
+        if (vhost_log[backend_type] == log) {
             g_free(log->log);
-            vhost_log = NULL;
-        } else if (vhost_log_shm == log) {
+            vhost_log[backend_type] = NULL;
+        } else if (vhost_log_shm[backend_type] == log) {
             qemu_memfd_free(log->log, log->size * sizeof(*(log->log)),
                             log->fd);
-            vhost_log_shm = NULL;
+            vhost_log_shm[backend_type] = NULL;
         }
 
         g_free(log);
@@ -376,7 +395,8 @@ static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
 
 static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
 {
-    struct vhost_log *log = vhost_log_get(size, vhost_dev_log_is_shared(dev));
+    struct vhost_log *log = vhost_log_get(dev->vhost_ops->backend_type,
+                                          size, vhost_dev_log_is_shared(dev));
     uint64_t log_base = (uintptr_t)log->log;
     int r;
 
@@ -2044,7 +2064,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
         uint64_t log_base;
 
         hdev->log_size = vhost_get_log_size(hdev);
-        hdev->log = vhost_log_get(hdev->log_size,
+        hdev->log = vhost_log_get(hdev->vhost_ops->backend_type,
+                                  hdev->log_size,
                                   vhost_dev_log_is_shared(hdev));
         log_base = (uintptr_t)hdev->log->log;
         r = hdev->vhost_ops->vhost_set_log_base(hdev,
-- 
MST


