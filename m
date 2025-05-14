Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17517C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAeI-0006ww-QB; Wed, 14 May 2025 07:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdw-0006UZ-J4
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdt-0006ND-JG
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r130SNDHPsyHuJY951ydcB9zf5qK/Ak7BggOv+qCFfw=;
 b=CQT+u1+Wsl3fiOjQ/M5ySHvPIXUsvx3olaTllpOmZrLTjIyRVlj1MqfQYCynjsMM0xQqOA
 UIw6JkR6aZ0EqhvJPKt8u1XElnfyrE+tWbqa6YXXLIp8u7tINO5Xamen1u7NSviynQCXxz
 S7tsj6Cfqz3zaasdkZqoyqB+4hAO+UQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-c2fIguB9PxO4ypV2nSxp9w-1; Wed, 14 May 2025 07:51:16 -0400
X-MC-Unique: c2fIguB9PxO4ypV2nSxp9w-1
X-Mimecast-MFC-AGG-ID: c2fIguB9PxO4ypV2nSxp9w_1747223475
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43eed325461so35271335e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223475; x=1747828275;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r130SNDHPsyHuJY951ydcB9zf5qK/Ak7BggOv+qCFfw=;
 b=IOLzcBqmdM8YAEgb1Z4XhlqEtWkRzuSDj490tXjgFtI4iOunfTEJKnswb2rnASj+iv
 pm0KZN45KCt2KJDGXTGCj+O0LN2TQhywE44dMdUMFMT5Zc2YpNrwL4w+d+/2cR5mVe2M
 2E9WVpb4MnAWuNlhzP7kZPn63lFUXAQexFjT1OWtxg6egj8EnLktFIKWp7zslNB6P5er
 oJd9HS4v3t2PiDa9WlxYocdsR7HB1ISpFlZoRh+IOHo8mXReShJoxVgUJ2HwE1npQ+8r
 5DN/vnBt4RVNpfW49YkowOr1LhN56s3VgKuzHMYuVKdVQ1cbrNl7EOtTlrYo+dICgiDS
 FKEA==
X-Gm-Message-State: AOJu0YxOsv6nBcwN+C8j2E9pwxo/0N7h0Cz9CgFUApQAXh68qKGl1fO4
 vvxWyIU7/oW04XSHEbYvxXHuB2kkkceVtA3jF7BhUZuheskGS9T1nRqIQ2dbnb87xM++sgbyGoC
 zcwHIBJWNISa8U9MaK+hAPKl3UU0jxg32Gr4R9v9U8QVdP7OTDBa1kroo1X8r2b9O4XzSYsGkHe
 qfs0/bE1gG3iA3u/Fa/9mlQKRs+SLBwg==
X-Gm-Gg: ASbGncupgwgNfCNrQ9zd8Spya8vkv9TAkNAiW2EYluWPQPtloDXZr4pBXoHiaqcwsq+
 MiExbPOg7QAllWubksx5LUavKJDHvWcSU5R93hneuN3JDMph5K87jD3zlH6YwS5jY7bZJdJdgUX
 1/MKUPk4RXEdanPTOZdPfEOil4nFI1f3UDf/YlnLwQf/BkRUdAqU7CH8cC56Xh+dlzCJKiCc8KN
 VQk5pziErrKt1vRY8nxXjDNbtTgfczJGigIpdP6svlmqE53mMGW1IQtBigvD1BlmiS95nvC6rvS
 bEddsg==
X-Received: by 2002:a05:600c:1547:b0:43d:db5:7b1a with SMTP id
 5b1f17b1804b1-442f20e4994mr25701025e9.12.1747223474982; 
 Wed, 14 May 2025 04:51:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7lIZMd/cE34Bndss/Hyr5hiGECAzKCJvvcxAa35zIkhklTc/65+IM8CP+zhpE16E6Gr8mSA==
X-Received: by 2002:a05:600c:1547:b0:43d:db5:7b1a with SMTP id
 5b1f17b1804b1-442f20e4994mr25700775e9.12.1747223474496; 
 Wed, 14 May 2025 04:51:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f395166fsm27410915e9.18.2025.05.14.04.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:51:14 -0700 (PDT)
Date: Wed, 14 May 2025 07:51:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
Subject: [PULL 22/27] virtio: Call set_features during reset
Message-ID: <0caed25cd171c611781589b5402161d27d57229c.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

virtio-net expects set_features() will be called when the feature set
used by the guest changes to update the number of virtqueues but it is
not called during reset, which will clear all features, leaving the
queues added for VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS. Not only these
extra queues are visible to the guest, they will cause segmentation
fault during migration.

Call set_features() during reset to remove those queues for virtio-net
as we call set_status(). It will also prevent similar bugs for
virtio-net and other devices in the future.

Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support multiqueue")
Buglink: https://issues.redhat.com/browse/RHEL-73842
Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250421-reset-v2-1-e4c1ead88ea1@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 1b55d8d8a2..3300f4afb0 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2320,6 +2320,8 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
     }
 }
 
+static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val);
+
 void virtio_reset(void *opaque)
 {
     VirtIODevice *vdev = opaque;
@@ -2350,7 +2352,7 @@ void virtio_reset(void *opaque)
     vdev->start_on_kick = false;
     vdev->started = false;
     vdev->broken = false;
-    vdev->guest_features = 0;
+    virtio_set_features_nocheck(vdev, 0);
     vdev->queue_sel = 0;
     vdev->status = 0;
     vdev->disabled = false;
-- 
MST


