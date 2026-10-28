Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E250606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CQ51oGQO;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UggelPxX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7FA-00069C-HN; Wed, 28 Oct 2026 13:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7F1-0005fM-6x
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Ey-0003iv-TG
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1M4kEDa7xNZiFlRm9G/PDjppHiJkBJP48N5iy6ugTQs=;
 b=CQ51oGQObpU/52HAkMSfThnvJJ1PXUwZ1MtxfnKeJecSSnFT8TvHGNhdq1Mg6qkuaM8SvJ
 2PxI9XrzulppAINlZa7tpb9MDpriezmFd44GbcsTaqOBIgg7qT4rT2bMug0zFb+2PXpPAB
 FQHDEWqXYIWvNlwHcNd7b8Rap1mSmik=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-m57ayr84NsmWuVqN4QGBzw-1; Wed, 28 Oct 2026 13:15:05 -0400
X-MC-Unique: m57ayr84NsmWuVqN4QGBzw-1
X-Mimecast-MFC-AGG-ID: m57ayr84NsmWuVqN4QGBzw_1793207704
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a20fd059ddso9027305e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207704; x=1793812504; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1M4kEDa7xNZiFlRm9G/PDjppHiJkBJP48N5iy6ugTQs=;
 b=UggelPxXPv4C6qtJMw9LvKxVpLtE1GMQMsOwoX3Ow4extEC5AKV2mmV8jFO8cJnQe7
 NhCUJZwOOMPfHV+PPYqIG5grdB2VlgsUJe2LAXwD/rpBa6XqKrqfBVwMToEgAoILgzA5
 uio8Me2+/tcl0DiQ34tyynhSBU3i7QZMcpwOpfsKGm5tbjn1TIzIDomByTVHRwe4cTMs
 /a5WkPpOKTrZNOWiIvotwgGfbbiOMO8HvPEaDvE8KZdlsaBlrZ/2yTiXFLYzlk72Qpvx
 ZvcrIscLcGnMfweRRDeMyLgr15ljzpSTn6/xkaJUHDEWzsuY0QZZpdcQJ68YI6wEiBBN
 oSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207704; x=1793812504;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1M4kEDa7xNZiFlRm9G/PDjppHiJkBJP48N5iy6ugTQs=;
 b=Eq09WNGLtzIrzVY+6dkuff72DTwuIRHtC3tIEecpy18VqD5AEZXMGqydWamY1sToHN
 kw0uF7wIV9t+CW3+AV1mJbXyltvodaxlsLZtZi1mF3WXx0teMJmuNwI40TclSTfYkcFB
 uUlxXWlvFybtw0vjhCSipxK1bLq9H6hsqFk7zyNQnGCIAwusYcl4a/CsLpnYsh2CdTOs
 uDflAMLj2AJY8V+J6YGyp4ty3q5RmDBWCOOL+AaXGoybFOt/pQBspEedapBU6fsI/1y0
 pRD3YfRO/ETbU33LyUgRJ2rLLyuGXnWHYri7iXa0KVMmTAmzJrtY5/0CMEGdJVavk15F
 Dpiw==
X-Gm-Message-State: AFq9FYKD0xeUhe/hskt7/ypkq7BDl8ZwfTjgJMNZdBB8NYRbrKz8JGMU
 wpNndUXl78pNBLrhsB5Kk8mMn+Ni6YVc+WtFPVn2VRtAq7M/5zJSxIAkJZHPLdmrbXwy79+A1GY
 NukAU35gQicy0PNK/55FIG9e+kd7LReAI/oefrRdg+JYpSAJT9SqHgKkF+c3Mebp+JvvE/UC/k5
 ZxsLXUMwuLNl49bF8V57cHtcracsOCOQeetA==
X-Gm-Gg: AYBFou2m1xBSLgmw8g+goXdqs4nV/U6hwJxXMxnU4LGFJOLsrWwBhCeIXsuDXr/tIv4
 izo9R5xmIKxfPPJrIy+TJ7pfflfUoZq/XkivMgi5nSzerpORNPfkx73ywMz3nuNjgBJ5lC1ou4x
 66foMihctzKekhQDstSkbnV2lEB4lG5YcTY4AegvAwkkE0Ltu5zWaghGyJxOEIttq6mA7cgrlPE
 AApsfQ+yAGSUeSJrxNZdn1JNkuh4sw4ciYPLlHrilLIj3PU9Px6w2F7xrp4PyBIvwj+D4Zv1uFG
 /ewsekz3eE+oLWX5pErYqqdP53QcYjlisagpwk/Q1crortQedspkJCjtD1feL8lKHLvmdPri8Y6
 MaUnTAO3R2QTzp2kD/A6phAEo1XUpi9Ew1FLZmKgU
X-Received: by 2002:a05:600c:1f93:b0:49f:fe39:5bc8 with SMTP id
 5b1f17b1804b1-4a96667edddmr64692095e9.12.1793207704324; 
 Wed, 28 Oct 2026 10:15:04 -0700 (PDT)
X-Received: by 2002:a05:600c:1f93:b0:49f:fe39:5bc8 with SMTP id
 5b1f17b1804b1-4a96667edddmr64691115e9.12.1793207703668; 
 Wed, 28 Oct 2026 10:15:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa8213ead6sm5390795e9.14.2026.10.28.10.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:02 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 24/78] vhost: release ownership in vhost_dev_cleanup()
Message-ID: <207854552170f0129b2fbd0895856d48674095d5.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

vhost_dev_cleanup() closes the backend FD, but that doesn't release the
device ownership taken with VHOST_SET_OWNER if the same file is open
elsewhere.  That's the case on a CPR target: the source keeps the FD,
so if the target fails after SET_OWNER, either inside vhost_dev_init()
or later in its caller, the ownership stays with the target.  Once the
source is resumed it can't take the device back, SET_OWNER fails with
EBUSY.

Track the ownership with a new 'owner' flag in struct vhost_dev, set and
cleared by vhost_dev_set_owner() and vhost_dev_reset_owner(), and issue
VHOST_RESET_OWNER in vhost_dev_cleanup() as the common teardown for all
those paths.  Only do it if the ownership was handed over to us by
another process, which is marked by the device with a new bool flag
'owner_handed_over'.  Upon ownership release failure, we have nothing to
unwind at this point (CPR target teardown), so we just report the failure.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-15-36c38bd15ffc@virtuozzo.com>
---
 include/hw/virtio/vhost.h | 11 +++++++++++
 hw/virtio/vhost.c         | 40 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 73ea130d7e..efe1eed260 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -111,6 +111,17 @@ struct vhost_dev {
     bool started;
     /* @initialized: has the full vhost_dev_init() completed? */
     bool initialized;
+    /*
+     * @owner: has this vhost_dev acquired the device ownership?
+     * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
+     */
+    bool owner;
+    /*
+     * @owner_handed_over: CPR target side.  The ownership was handed over
+     * to us by another process (the CPR source) and must be given back
+     * when this vhost_dev goes away.  Set by the device.
+     */
+    bool owner_handed_over;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c01ccc800c..085e2ef6f1 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -53,6 +53,25 @@ static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
 static QLIST_HEAD(, vhost_dev) vhost_devices =
     QLIST_HEAD_INITIALIZER(vhost_devices);
 
+/*
+ * Release the device ownership if it was handed over to us by another
+ * process, e.g. the CPR source.
+ */
+static void vhost_dev_try_release_owner(struct vhost_dev *hdev,
+                                        const char *when)
+{
+    int r;
+
+    if (!hdev->owner || !hdev->owner_handed_over) {
+        return;
+    }
+    r = vhost_dev_reset_owner(hdev);
+    if (r < 0) {
+        error_report("vhost: cannot release device ownership on %s: %s",
+                     when, strerror(-r));
+    }
+}
+
 unsigned int vhost_get_max_memslots(void)
 {
     unsigned int max = UINT_MAX;
@@ -1705,20 +1724,32 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
 
 int vhost_dev_set_owner(struct vhost_dev *hdev)
 {
+    int r;
+
     assert(hdev->vhost_ops);
     if (!hdev->vhost_ops->vhost_set_owner) {
         return -ENOSYS;
     }
-    return hdev->vhost_ops->vhost_set_owner(hdev);
+    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    if (!r) {
+        hdev->owner = true;
+    }
+    return r;
 }
 
 int vhost_dev_reset_owner(struct vhost_dev *hdev)
 {
+    int r;
+
     assert(hdev->vhost_ops);
     if (!hdev->vhost_ops->vhost_reset_owner) {
         return -ENOSYS;
     }
-    return hdev->vhost_ops->vhost_reset_owner(hdev);
+    r = hdev->vhost_ops->vhost_reset_owner(hdev);
+    if (!r) {
+        hdev->owner = false;
+    }
+    return r;
 }
 
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
@@ -1864,6 +1895,11 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
     if (hdev->vhost_ops) {
+        /*
+         * Release the device ownership if we hold it.  Needed e.g. for
+         * failing CPR target, so the source can re-acquire it.
+         */
+        vhost_dev_try_release_owner(hdev, "cleanup");
         hdev->vhost_ops->vhost_cleanup(hdev);
     }
     assert(!hdev->log);
-- 
MST


