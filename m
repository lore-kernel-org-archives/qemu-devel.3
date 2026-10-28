Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4EC606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dnvTk8KF;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=M1zj4r7Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Fl-0007Ej-6z; Wed, 28 Oct 2026 13:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7F3-0005nj-5J
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7F1-0003jG-0B
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ONBqiIIeXuqhfBEs1ZPmh1Yj9HtXJ7T1cWYaW2ga7lE=;
 b=dnvTk8KFqnh0eHX6X0O1JIvFaX2VEnxiIerZJQF8O+xIfKLCjOP68j3hwMZLvZNoglmYZf
 ckPqDgiTlRarpw2vgZvAYQST++T6fav0JqFMyZkegHYa98JjxQS19HdEqQtjZlYlAanQhL
 ENprSLUm58PTALKq+/dQgwLvV6bSA6A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-idX3cU0NMXCCI-vfUi0Qqg-1; Wed, 28 Oct 2026 13:15:02 -0400
X-MC-Unique: idX3cU0NMXCCI-vfUi0Qqg-1
X-Mimecast-MFC-AGG-ID: idX3cU0NMXCCI-vfUi0Qqg_1793207702
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a9d51dc486so4491805e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207701; x=1793812501; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ONBqiIIeXuqhfBEs1ZPmh1Yj9HtXJ7T1cWYaW2ga7lE=;
 b=M1zj4r7QERfVK+Di3c+v94scbWDnSfVNMbLCUUjXpC73tq99LDBRt0mzghj1PdxsGJ
 MXG7jCizxrk1zLzkenIoDw5fV8yG7ruzUVobC5OEY0wgrVCi/4npUBmFaIF2B898vUrn
 gZHvvIXBxWFkca0bkpiTkfisAEk0140FBFkbwq51min9AeGDlWpLYDi2JQAcyx2LoIIP
 fC4svjO6nQv61eK5pEjrqnDw2s6oftz/LupbyEIqWM4T8M8/wf62CUx30sVE2i1S7yWO
 s7es4tItPuy6FqNjjHmAB4XYTBBNN55QksJ5ueY6AUKJp+Yi3sm6L2PNpE1niJx31/NU
 XWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207701; x=1793812501;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ONBqiIIeXuqhfBEs1ZPmh1Yj9HtXJ7T1cWYaW2ga7lE=;
 b=kpODty0kv/7w78sD5Yogq6E4cbQU1ZfwAeTpN7TywIFRaq1Qq4d8WkrNQR6ymtX5uH
 ZPaiqzwiFF7HCeM6/3mxFR+60FX9D4dxX7b2+sZz13cIbk5va/p3mqf/vFXmsMbJRt6D
 Au4If2kR3B6tSRXxlaiaEHyUfYct0D2SsbaJSelK1i1oenKQ12oc7m0TeyG4Qa56vkkK
 YS1WR5+bMWFcduTNjHST0wIJJki8VJ35XS1i8eDyjD4z4oLnvhOI9Qr4P9QNylW4DMn3
 DRPhPUxvd/4fo1jJBEMgN4cTMXKj9yLjSwrz5OvTZpLKopFCRSiUi4ko0GwOhlt4hENF
 vkLg==
X-Gm-Message-State: AFq9FYJEkpMxpRtdnZ4azQ+eLwqi7hb4fgR5TthoAJXFya3A8j0FValB
 Sn2aXTx4ABXdjsIciFmzSzhikoVifFLMW2NonQ/SgxxWbqfVuLOxJl6D+qm83Fobn4VTuK/I/Fs
 W82zSjG6RP9k3tocDywxrgueBD1lN5rErYxOOF4vTs4R4gzcGvsw4BYDJIjWML9Bq9lcuzcLVQQ
 KBfVNnQuX0sI8xSCMXajMw+xG+slpztW8mAA==
X-Gm-Gg: AYBFou1TKMDYliED8GPgXX6spd2+81IVTDBdD+kYRlXumD8/0Y1qMB0r2i7MbxZrQEF
 EPAfhGMbYx+l0LEEOo/SEGzfCTfh88Grqnyg0gQ1rE0kjNt39WViM+cmZoNYsFe2hxbHBaVpwvD
 Ht+rgQtjT8n5bTn0b8sRtQAB9Zt2sAyA6rOvYoPJUM++NxgdDLnLlueP3l5kkPaat/+D5YC1yTx
 3+2uaZjOa9s3XPHfbAnnPtvbE9OgNlUN4JwTcLQcULYUckDca04nK5DOgLK6hc6NwcUNggo2pXo
 6xImH6bPZICosPzdSuKgjeHjp4OPqG7tgsYr3ARqZPAXI9v+RwCV5AZtO2SXqkotOnWOC96IlmA
 xsyfdaGBbCduQxNquLKWxWvxtHnphrOduyWWzeP05
X-Received: by 2002:a05:600c:540f:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4aa871e8bd4mr5895535e9.5.1793207701343; 
 Wed, 28 Oct 2026 10:15:01 -0700 (PDT)
X-Received: by 2002:a05:600c:540f:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4aa871e8bd4mr5894375e9.5.1793207700653; 
 Wed, 28 Oct 2026 10:15:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa813d295csm5240885e9.7.2026.10.28.10.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:00 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 23/78] vhost: add vhost_dev_is_initialized() helper
Message-ID: <c6f0c17d1617f9869caf80f0b9b08099f369a042.1793207602.git.mst@redhat.com>
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

The upcoming CPR support for vhost-vsock defers the full vhost_dev_init()
to .post_load(). On an incoming CPR .realize() only sets up the backend,
so we need a way to tell a fully initialized vhost device from a partially
initialized one.

Add an explicit 'bool initialized' field, set once vhost_dev_init()
succeeds, and cleared only in vhost_dev_cleanup() (by memset(0)). Also add
a public vhost_dev_is_initialized() helper.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-14-36c38bd15ffc@virtuozzo.com>
---
 include/hw/virtio/vhost.h | 14 ++++++++++++++
 hw/virtio/vhost.c         |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 8127a9a5a2..73ea130d7e 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -109,6 +109,8 @@ struct vhost_dev {
     uint64_t backend_cap;
     /* @started: is the vhost device started? */
     bool started;
+    /* @initialized: has the full vhost_dev_init() completed? */
+    bool initialized;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;
@@ -248,6 +250,18 @@ static inline bool vhost_dev_is_started(struct vhost_dev *hdev)
     return hdev->started;
 }
 
+/**
+ * vhost_dev_is_initialized() - report init status of vhost device
+ * @hdev: common vhost_dev structure
+ *
+ * Return true if the full vhost_dev_init() has completed successfully
+ * (and vhost_dev_cleanup() has not run since).
+ */
+static inline bool vhost_dev_is_initialized(struct vhost_dev *hdev)
+{
+    return hdev->initialized;
+}
+
 static inline int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
 {
     if (!hdev->vhost_ops->vhost_set_vring_enable) {
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 56fa434588..c01ccc800c 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1834,6 +1834,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
+    hdev->initialized = true;
+
     trace_vhost_dev_init_out(hdev);
 
     return 0;
-- 
MST


