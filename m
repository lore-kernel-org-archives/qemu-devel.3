Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BBFC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4n80-0004GI-H3; Thu, 10 Sep 2026 18:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lJj-0002N5-7F
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lJQ-0000IP-66
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQDk4aDnIuGue9PuQFrUh0Z8Opb928Cl0XfZUcAFxaI=;
 b=a7wKiQAu/hmf3akun/HqhVQdSMf2tA9QAT4s7rje/VOaKGL7/pIdzW5bMES7lIOGsN2Jwv
 xC7alzvfTykLna6T97UHblUVRSIT19Z51kYcviLmmR+iporIqTO5aKoF/nBvqZp06cYrDx
 HYgaumPprd0Cq84R3ZjJ9lI/JrRGog4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-qHPP63j6Njeem71c1sQ4gw-1; Thu, 10 Sep 2026 16:11:49 -0400
X-MC-Unique: qHPP63j6Njeem71c1sQ4gw-1
X-Mimecast-MFC-AGG-ID: qHPP63j6Njeem71c1sQ4gw_1789071108
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so2209915e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071108; x=1789675908; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZQDk4aDnIuGue9PuQFrUh0Z8Opb928Cl0XfZUcAFxaI=;
 b=fziojBq4bnfIdq7uw4tT5EdjIv+yT+mtARiV+BDJWi4umV6GLep9ENEaNOIIoItbmS
 3fZmCvMLsy7sI5wcoVkmqVZCIsw5QtOlEAY9giu7FkX4KJZ0ZLi4/dmpScLX2uAVReMe
 BO0E4vseVhZj7D8qbUrTQgo5NrSFMgsrW898hgY/BJ8j6KvZTDTw5s9vD6aWZ3IT1pxx
 7xMPq4SK3Pah7Dvms7+3twI2ZFWRKFvTqlhEYry3r4/oGRrYR+FrK/E4pCbe2GIPOR84
 XWel0ZosEB0ojJQhpHpJJJ49PT4DjQacjMMkbNUvS012wKkq+lFBpzvDpJr0QyR7R+rC
 cZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071108; x=1789675908;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZQDk4aDnIuGue9PuQFrUh0Z8Opb928Cl0XfZUcAFxaI=;
 b=p0IO9klXsh3VJHN3XHD2yoS1oo8+923Of8fPH76WOVyPNnOT6m9y6/QIz5ZMLwxPQF
 G9zV3g5WVbHQo4H81gnt3xr22Nu0mHqtya5fMsYM9M2pPibkrs8JnUXyuf70LVSDEkMu
 gIZnH25+UHHbXv1+7Mpvh1VLxWqv6zErcMyxkEDvfG6PqwypwwVKkMtmLEA0blo5QSJG
 XJUj/mikZAyzcYacW6oDzEs80n12CwQ6GQewndXxqyLsJvjneBQmtoFWjMZdqEkgptF2
 fbGpzaHyZEneMba2W0Pc/ZFLRZf3fIUg4FmT0DxFtXc/or/3LMMQmYIjKIczUTBlx9BL
 e1EQ==
X-Gm-Message-State: AFuF++kgOUIxh/ix3Lxj5+tPTnExRoYwpHtDJagOnx1u4OM07ipkFmHY
 pRzCAFUPgeTiaI+0irlTV2FveI13DwIGXVLkNm5sosTKziCMW29YAngUrlvUcSXQnNQmHLBSevc
 OJ1BWwdrx8frs8iamnI2ejmOmJsgVqX8oo5WyM0WvHtinvBifLwBF9/N84Ewan0bX8/s23iHKpP
 lbFtXOEo4Xvccgbj5zBKo588LpcNz2SKpkBg==
X-Gm-Gg: AYBFou3mRu444lItw0YWbN6vekIAQdcRP8K5XhsLqJtIfQoNfvl1KIKR7aIPoek3bas
 iOUDaUQQ2VFBJCvx+GWM4lzaopEpXXFyBRO0GC6Z9CgJp1W0YlJ/c3t57letJgTZPFegtYZf6uc
 kQbKXQDl+fBJHvXW+cGLosSCJ3eXZagjIQdukgo2PzyO9eeh9/TWUrtNXMzyoP1qZvv66muvA2B
 gk/0yymGbrEpHiHo3emy/2N6a8+s49YocNF5xncTETtsZ2yZnOEYJmH30f+of4fesy/9S31XUEX
 8Ac1KBayUAK77h0CHYe1flY3LobPkpKucxp7AP01JxZmholXXanUezcTJZCTSRG03Y6HE7vTW02
 NtEHbGf1QxeZsRuCNjN35pNk=
X-Received: by 2002:a05:600c:1d08:b0:49d:2450:68ac with SMTP id
 5b1f17b1804b1-49e619b57admr14913625e9.5.1789071107815; 
 Thu, 10 Sep 2026 13:11:47 -0700 (PDT)
X-Received: by 2002:a05:600c:1d08:b0:49d:2450:68ac with SMTP id
 5b1f17b1804b1-49e619b57admr14912795e9.5.1789071107265; 
 Thu, 10 Sep 2026 13:11:47 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ea4fsm743680f8f.21.2026.09.10.13.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:11:46 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 10/90] vhost: factor out vhost_dev_init_backend()
Message-ID: <7bb122158b931f22b40f7e9bd3e44a63744661d5.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260820113955.509478-7-andrey.drobyshev@virtuozzo.com>
---
 include/hw/virtio/vhost.h | 22 ++++++++++++++++++++++
 hw/virtio/vhost.c         | 33 +++++++++++++++++++++++----------
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 684bafcaad..9b98d34dd0 100644
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
index 371dca17dd..f9b54c46f9 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1668,6 +1668,28 @@ static int vhost_dev_init_features(struct vhost_dev *hdev)
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
@@ -1680,10 +1702,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
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
@@ -1694,12 +1713,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
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


