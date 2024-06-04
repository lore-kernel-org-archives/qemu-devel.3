Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52162C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZU5-0004xz-H7; Tue, 04 Jun 2024 15:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZU2-0004xH-Us
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZU1-0000gr-Am
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717527968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gfd+vfybB3O3+4pkXHRWr1BbxFsd2M2r8td4r0aSbjQ=;
 b=GdHye96uTOtEpCtgGtHa1xVgQ1i7cSXRSSzdb22g475+UHNfO2u2RvySIHWHq799sd9iFA
 PO8B+lL2M7HBpRK2Vs1bsHYMMstXkfVZF4Vz3fmKlr9uIgZPBqRoLajpkSvBa7qwriG63l
 CtO+F9AcrzpxDwUAHG+wusAlxL9n+Qc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-hArG0UZaOTagcJQ8XjIjYg-1; Tue, 04 Jun 2024 15:06:07 -0400
X-MC-Unique: hArG0UZaOTagcJQ8XjIjYg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35dca355ffaso3517561f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717527965; x=1718132765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfd+vfybB3O3+4pkXHRWr1BbxFsd2M2r8td4r0aSbjQ=;
 b=UkdPE7RGMP4Vh/ZW7zd0ttra8G6T8eDeULppt7Hu9wKUwk97SHpWeJWJER/7REp2tr
 SEs08TcG6XERq+VUeRlWJwpbiJtgdboz2yketX+RCyEiuzWCfCyYLFNkYdMaRXnEUohQ
 cfj5vdnvNYEMQZdT6yH5dgvPFbGHfxcYi96kwoLCZLsgy6P1/4am54wCHFWdGic7vmD/
 rkzCZ8BNHBnxX7tEjeZmDxbscB5NeHkefCSITKgRDSu5XqOEZ/nc3rnOslMMNo7jMIpD
 ybZh2AvA2YPHQay686CENtKsRdG04E2McrRKTkW+jnJZTFWfEdkcc97sZsMlD8771dm4
 ZfxQ==
X-Gm-Message-State: AOJu0YzU/4xnwbEKYKuPIM0bDamQmw/stCR3oRMcjrfps4Fm/LbEVwJI
 HZsdiuiWrLct5ReEjFOTUT55Q5dwpHDPUps6YgUIjj/4Jap3kHiZHe2JdOR8xyFwHnblPtqf4qB
 8oL7OxXURQ1fZPV1+JcGXqf/dLyR50Qt6crhLjQdDvYhn8Db4qxJopbYkeIErzkHfzwMZXxIMvq
 rcfCsEIDzMnuZF8U/AZBPeen5qMUiT9A==
X-Received: by 2002:a5d:4e8f:0:b0:35e:5b2a:1191 with SMTP id
 ffacd0b85a97d-35e840678f7mr230996f8f.18.1717527965345; 
 Tue, 04 Jun 2024 12:06:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOlKd+Sx9HuvNacLdaJyPkWeq0f6MFm6oxM6nspWlljSJryAxVZnZo6ksCGJhsM0n5My5Ixg==
X-Received: by 2002:a5d:4e8f:0:b0:35e:5b2a:1191 with SMTP id
 ffacd0b85a97d-35e840678f7mr230969f8f.18.1717527964668; 
 Tue, 04 Jun 2024 12:06:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35e7e07d7besm2777211f8f.18.2024.06.04.12.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:06:04 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:06:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Si-Wei Liu <si-wei.liu@oracle.com>
Subject: [PULL 01/46] vhost: dirty log should be per backend type
Message-ID: <0b7ca10a059089caef535e86c6523991240e5f29.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


