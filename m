Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A394660A2604
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FeG4HTs4;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PxX7ATpW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7F6-0005xJ-44; Wed, 28 Oct 2026 13:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7En-0005Da-Re
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7El-0003W0-Jh
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tN4e6i3WOisIPWKmdrnGmFzSpxDoQJwX2FraaPsaVxE=;
 b=FeG4HTs4pwcQoSyAt8ABtE5uKRLvIGo61INYkW8vPDcqTvUxgY+pkLmsnaXD8NeRP7hjUE
 GXzpaAjkdd0w3Wko8OXp2bnljb6MAmLxmPXs2WxHhnNQ2nkBQguh20ffLT52tlNnxri8Et
 7JNO5702a941xhDuyCIbPH7h/pAiHbg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-E8oWxosvNMCPYx8SSpteLw-1; Wed, 28 Oct 2026 13:14:53 -0400
X-MC-Unique: E8oWxosvNMCPYx8SSpteLw-1
X-Mimecast-MFC-AGG-ID: E8oWxosvNMCPYx8SSpteLw_1793207692
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49953abe51fso8991475e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207692; x=1793812492; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tN4e6i3WOisIPWKmdrnGmFzSpxDoQJwX2FraaPsaVxE=;
 b=PxX7ATpWmrogHZFrYw0fldMjtBQdLtMXEDJRnMzHbfBDa34ptoEFBZpjM+uwuoK/to
 lIM6JrNE18KkZTIcOQil4H3mzZqIK4Ucl/QQw2Qg1RC45pXNgQ6C0fsmyAq7ZJnDDd86
 FfbXF+FvpPtZhK+jKu/OS20eMHL393QQutm5mtzXaZ0/p0SWnDaMe5xzZ/iXdAgrE6tx
 zTLYD0ztQgfjGYP2WOChX/bRZj1t0kkejVkXkJ2D25eP0SE/ZK8gUSgRze5ziAuXYdat
 Gr3ynEkqiTasWCEe7TgHaH5+9Ykj0pjUN3ZJqg4yc5XJreuPPWGtJ15ZfxcJpb+UTejf
 GB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207692; x=1793812492;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tN4e6i3WOisIPWKmdrnGmFzSpxDoQJwX2FraaPsaVxE=;
 b=TW1hZthZ/sxgz4HUnGTBHw1BOlNtNzlg5JpqTkYfi0NHOtbLflG3F9sEJ0RZxPH4CH
 qGYtCpePrUhIjIJJqaXKC/AEm4rV+2UTAd6yKeaHXCRpCd00CDJcn0fCmBXNnq9U8FSe
 ezpvIVbxDFZlR5VqfqtnJf2P835yTFVZC+eDGjKcInqd4yKolR2cJ2g/iitICbXhN2vs
 x7BidzKB6aZPPZhzR7ihEfxADj9Bp6rLFg/Ygmx+ulqPbouQyz1JlKQ+VgjxPnwFFgU0
 qAUvzjeev5QYz4YE2uS6Yt8a18HalQYRSnt1OHTXziNkrMv0wszJ3/YyHw7DBZ2OpkJJ
 U5Jg==
X-Gm-Message-State: AFq9FYIDkP4DXq3EtqG8zjrHsu6TjVFHFSCv9k1H2HTuojvA0TmUpCer
 ke55n/d+oMoT0gPyC+z+t/Xy5WOV2hr8y48TZzw86NrgAABn+cn9cm8WPI9HrKPjkEqOvWJX0vr
 VqYkfEbgqLvU4zTWE2nlE3AiomI9ONS6lMt3QcRzxhqdxc2C4laIvWuHsSBfE5jxdE6F8BMwQ4p
 Igg+o06Z1jzV/PZWkGothPyChjUQlQI7Ss+g==
X-Gm-Gg: AYBFou33RrUVl8sCQohqUwU3Uu9FRTKjOxYckoTbKDHLfyRLW0A2qEuDV6nxduL0QEs
 Sw3jtWsPkuM6JvuTfxneAoXhC47nUZKIS2Z96kltEK5cqTCW00JSZgdlSTioHAIyhDDP/pYHGbv
 oYNq2ixmlX54fm32bcIdz4rnoQae2zE3vUEUhrYtDNV7BQ9ySPM78+GevPLBnYzBiOY/ZK1cE7v
 ZyfolQpJhj2ZDDjeSCtUB0GBZfN/wsJZEMH29qq8enshmJlOVjaQXN2tDyjPvL87LT3CW/T9mfh
 VHquL+nRsGZrEplXkPBqcWDQoRBofHsnmX6BUkiKEsSlh2VF/K1wRgkECvl6jRWBWEGs3eyREYT
 FdddAj0ky3lUHB8G0JrjNJjfE/vPzdYXhMRjcI6Oa
X-Received: by 2002:a05:600c:a103:b0:4a1:ddca:8b66 with SMTP id
 5b1f17b1804b1-4a9672f98b9mr50334585e9.31.1793207692308; 
 Wed, 28 Oct 2026 10:14:52 -0700 (PDT)
X-Received: by 2002:a05:600c:a103:b0:4a1:ddca:8b66 with SMTP id
 5b1f17b1804b1-4a9672f98b9mr50333725e9.31.1793207691661; 
 Wed, 28 Oct 2026 10:14:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80286fc6sm6219015e9.15.2026.10.28.10.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:49 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 20/78] vhost: factor out vhost_dev_init_backend()
Message-ID: <0d3f5df94f23ea2858793abe054af09b38527b22.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Split the first part of vhost_dev_init(): selecting the backend, calling
its .vhost_init() and reading the supported features - into a new
vhost_dev_init_backend() helper, and call it from vhost_dev_init().

This is in preparation for CPR restore of vhost-vsock, which needs to learn
the backend's features at realize time to negotiate them when loading the
incoming virtio state, but also must defer taking ownership of the device
to post_load.  vhost_dev_init_backend() does exactly the pre-ownership part.

As a result VHOST_SET_OWNER now follows the feature query rather than
precedes it.  This should be safe, as no backend requires ownership before
VHOST_GET_FEATURES - the kernel and vdpa backends do not check ownership
for it, and vhost-user already does query features from its .vhost_init()
before set_owner().

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-11-36c38bd15ffc@virtuozzo.com>
---
 include/hw/virtio/vhost.h | 22 ++++++++++++++++++++++
 hw/virtio/vhost.c         | 33 +++++++++++++++++++++++----------
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 0a322efec1..b2b644c0d1 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -156,6 +156,28 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type,
                    uint32_t busyloop_timeout, Error **errp);
 
+/**
+ * vhost_dev_init_backend() - set up the backend and query its features
+ * @hdev: the common vhost_dev structure
+ * @opaque: opaque ptr passed to backend (vhost/vhost-user/vdpa)
+ * @backend_type: type of backend
+ * @errp: error handle
+ *
+ * Select the backend, initialise the backend instance and read its supported
+ * features into @hdev, without issuing VHOST_SET_OWNER, setting up the
+ * virtqueues or registering the memory listener.  This is the part of
+ * vhost_dev_init() that precedes taking ownership; it can be used on its own
+ * so feature negotiation can happen before ownership is acquired (e.g. by CPR
+ * restore).
+ *
+ * On failure the backend may be left partially initialised; the caller must
+ * still call vhost_dev_cleanup() to release it.
+ *
+ * Return: 0 on success, non-zero on error while setting errp.
+ */
+int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
+                           VhostBackendType backend_type, Error **errp);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 68a8e40481..99561ac586 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1681,6 +1681,28 @@ static int vhost_dev_init_features(struct vhost_dev *hdev)
     return r;
 }
 
+int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
+                           VhostBackendType backend_type, Error **errp)
+{
+    int r;
+
+    r = vhost_set_backend_type(hdev, backend_type);
+    assert(r >= 0);
+
+    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
+    if (r < 0) {
+        return r;
+    }
+
+    r = vhost_dev_init_features(hdev);
+    if (r < 0) {
+        error_setg_errno(errp, -r, "vhost_init_features failed");
+        return r;
+    }
+
+    return 0;
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1693,10 +1715,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
 
-    r = vhost_set_backend_type(hdev, backend_type);
-    assert(r >= 0);
-
-    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
+    r = vhost_dev_init_backend(hdev, opaque, backend_type, errp);
     if (r < 0) {
         goto fail;
     }
@@ -1707,12 +1726,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = vhost_dev_init_features(hdev);
-    if (r < 0) {
-        error_setg_errno(errp, -r, "vhost_init_features failed");
-        goto fail;
-    }
-
     limit = hdev->vhost_ops->vhost_memslots_limit(hdev);
     if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
         memory_devices_memslot_auto_decision_active()) {
-- 
MST


