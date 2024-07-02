Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E2EC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeAc-00023m-3I; Tue, 02 Jul 2024 10:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAa-00023D-A0
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAK-0007tg-P0
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCCVtvSfvqBAUBpNFi/zb/m65iBLwl7XEHTViiftxcE=;
 b=TzRWAnLUcdJ5mVcKDwRl/YXyAXiR1lj/5U7J/j3AZW5a/y6RAeTig4z3i04+U9EnDeShMk
 AYd9wEAIglTaG+rq3LlH3tJi/+CDmKXKlxTFE36WLC6XPpkIXZSrJ8uhhiaLSMIQ3/3uaH
 +45BMU+UndPNlEAKOqFHnT3R1e3KXTM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-OXqlBY9RNHCM1RCR8YqT-g-1; Tue, 02 Jul 2024 10:07:25 -0400
X-MC-Unique: OXqlBY9RNHCM1RCR8YqT-g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3678e523e32so273425f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929244; x=1720534044;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OCCVtvSfvqBAUBpNFi/zb/m65iBLwl7XEHTViiftxcE=;
 b=OcqKnpfL1btLGcJCzlm66TZtMgYUKgaZv8jIR4aekzyLSjmObt+EqBzURuvwPYt7HC
 yWB5w2AQofgVkGEPV9Ulb0cnq5wmC6THpY4c2EZO99ZVsTQmIu9k4GpqWeRBFEBZ1HkT
 fXb6XehfGVl7rC076/DFv5NuGdXkMnIgz5kmMaRZnFaB/AnB60rV05F423Oi6nNizuzJ
 csFfyS747vRF/mIuOqAV9oRAKdfe1fQzZmDoN5KjQ/wBrwGszYJUpcWjsnOTIdmPT8be
 iuKXJK6AoVEZPpL8QPAQVB/VKCkZvKZzBLVcgBrMQHgX768AMy8sad+rN8G4B0up0GQ3
 byeQ==
X-Gm-Message-State: AOJu0Yy+bj10xl8dc81XDMuy6VW+iRhLmW0LTyKV2QgemlvzSbhPrS75
 LgPwYmsJo37Oo0L93WHj8dWWlO7Sth1dtIs7KdGsvm+rL7hHHJqKHQiTSHYcHuTjb8km5MnZfJ5
 Qn6AL+i9f8PnOTNTD2+eyBACrLfIvITmI3Cq6DboR00s9djUWLbAq5WjuMGDFs1fPEM7BJO7X6w
 ++VvTCb0O+pi2N3JfO52jpWm2t5Sw7YQ==
X-Received: by 2002:adf:a381:0:b0:366:f34d:d0b7 with SMTP id
 ffacd0b85a97d-367756bb806mr7373704f8f.29.1719929244386; 
 Tue, 02 Jul 2024 07:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUI4bM55YqPJYK0Ha8aEnXWd8xVDASX3XaOoSllRi7/BUeVM6uH00B7hv5HZIsY2c/gPfHDw==
X-Received: by 2002:adf:a381:0:b0:366:f34d:d0b7 with SMTP id
 ffacd0b85a97d-367756bb806mr7373666f8f.29.1719929243818; 
 Tue, 02 Jul 2024 07:07:23 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd6b4sm13274976f8f.17.2024.07.02.07.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:07:23 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:07:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>, Lei Yang <leiyang@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Srujana Challa <schalla@marvell.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev
Subject: [PULL 08/91] vhost/vhost-user: Add VIRTIO_F_NOTIFICATION_DATA to
 vhost feature bits
Message-ID: <b937fa896321fb7b6d7f2205edb5490e0e5d6c69.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Add support for the VIRTIO_F_NOTIFICATION_DATA feature across a variety
of vhost devices.

The inclusion of VIRTIO_F_NOTIFICATION_DATA in the feature bits arrays
for these devices ensures that the backend is capable of offering and
providing support for this feature, and that it can be disabled if the
backend does not support it.

Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240315165557.26942-6-jonah.palmer@oracle.com>
Acked-by: Srujana Challa <schalla@marvell.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/vhost-user-blk.c    | 1 +
 hw/net/vhost_net.c           | 2 ++
 hw/scsi/vhost-scsi.c         | 1 +
 hw/scsi/vhost-user-scsi.c    | 1 +
 hw/virtio/vhost-user-fs.c    | 2 +-
 hw/virtio/vhost-user-vsock.c | 1 +
 net/vhost-vdpa.c             | 1 +
 7 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 9e6bbc6950..bc2677dbef 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -51,6 +51,7 @@ static const int user_feature_bits[] = {
     VIRTIO_F_RING_PACKED,
     VIRTIO_F_IOMMU_PLATFORM,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_NOTIFICATION_DATA,
     VHOST_INVALID_FEATURE_BIT
 };
 
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index fd1a93701a..18898afe81 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -48,6 +48,7 @@ static const int kernel_feature_bits[] = {
     VIRTIO_F_IOMMU_PLATFORM,
     VIRTIO_F_RING_PACKED,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_NOTIFICATION_DATA,
     VIRTIO_NET_F_HASH_REPORT,
     VHOST_INVALID_FEATURE_BIT
 };
@@ -55,6 +56,7 @@ static const int kernel_feature_bits[] = {
 /* Features supported by others. */
 static const int user_feature_bits[] = {
     VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_F_NOTIFICATION_DATA,
     VIRTIO_RING_F_INDIRECT_DESC,
     VIRTIO_RING_F_EVENT_IDX,
 
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index ae26bc19a4..3d5fe0994d 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -38,6 +38,7 @@ static const int kernel_feature_bits[] = {
     VIRTIO_RING_F_EVENT_IDX,
     VIRTIO_SCSI_F_HOTPLUG,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_NOTIFICATION_DATA,
     VHOST_INVALID_FEATURE_BIT
 };
 
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index a63b1f4948..0b050805a8 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -36,6 +36,7 @@ static const int user_feature_bits[] = {
     VIRTIO_RING_F_EVENT_IDX,
     VIRTIO_SCSI_F_HOTPLUG,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_NOTIFICATION_DATA,
     VHOST_INVALID_FEATURE_BIT
 };
 
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index cca2cd41be..ae48cc1c96 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -33,7 +33,7 @@ static const int user_feature_bits[] = {
     VIRTIO_F_RING_PACKED,
     VIRTIO_F_IOMMU_PLATFORM,
     VIRTIO_F_RING_RESET,
-
+    VIRTIO_F_NOTIFICATION_DATA,
     VHOST_INVALID_FEATURE_BIT
 };
 
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index 9431b9792c..802b44a07d 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -21,6 +21,7 @@ static const int user_feature_bits[] = {
     VIRTIO_RING_F_INDIRECT_DESC,
     VIRTIO_RING_F_EVENT_IDX,
     VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_F_NOTIFICATION_DATA,
     VHOST_INVALID_FEATURE_BIT
 };
 
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index eda714d1a4..daa38428c5 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -62,6 +62,7 @@ const int vdpa_feature_bits[] = {
     VIRTIO_F_RING_PACKED,
     VIRTIO_F_RING_RESET,
     VIRTIO_F_VERSION_1,
+    VIRTIO_F_NOTIFICATION_DATA,
     VIRTIO_NET_F_CSUM,
     VIRTIO_NET_F_CTRL_GUEST_OFFLOADS,
     VIRTIO_NET_F_CTRL_MAC_ADDR,
-- 
MST


