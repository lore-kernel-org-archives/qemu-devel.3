Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892F9C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkZQ-0002yT-K3; Sun, 01 Jun 2025 11:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZP-0002uR-6K
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZN-0004fu-Hv
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04O3W6vzLxgn86PWEaMIddUURG4vqFHvy1Jt5dN9Jtg=;
 b=fRWAtpwrmVt5LPLt76lTuTInfhseKboqctZ0Hib82QlTS3sxMaICmgR+dicCeQCPFSYB0u
 VlxE+Fftt01z97uy9oSk1E3XO18LlWUgHObTpr4SgiZk6lG6f7lpfjEpA6hBkR6wzgEy1H
 uNANIKCBt42pBJnJ7BMw9+3cEnEtG3s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-7r6fcW3qOPGxjXzNM_xdkg-1; Sun, 01 Jun 2025 11:25:52 -0400
X-MC-Unique: 7r6fcW3qOPGxjXzNM_xdkg-1
X-Mimecast-MFC-AGG-ID: 7r6fcW3qOPGxjXzNM_xdkg_1748791551
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4e713e05bso1680199f8f.3
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791550; x=1749396350;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=04O3W6vzLxgn86PWEaMIddUURG4vqFHvy1Jt5dN9Jtg=;
 b=ObdKZC4jodS44XQkzDSOc+CfZLmcsYG4csMVkpivdACvrTgB72K/kPhmBAzbUPjimS
 AL3jSzxzDMTRp91l7197xtDEnSlG8avrX74dwTR15rDCkyHsKQSlFuNBL/Q4gqqT2jo2
 3FSfO4oyH3ndTSPzZZrmBDMRLwVoKh8u575+axv5rea8Ezr5Zc5zQuDanH5xNy3iSl+p
 5oXDUkXpPmanw4KL4HvoNE2i+OFuE0cc9GDNqNhhLTvk3Uc9VCNrqo7Zh7yIEaVrwNsx
 oAomTXAwdgnOV+0FSU6ENxzp8/0mVz9BPLjmIJRA6XWjSt/vMVt39/EJ9lMUbaaOXv+D
 w0Ag==
X-Gm-Message-State: AOJu0Yyo5vMhbJUv14I9h4hoT+eb0Qb/Tnzo+u90wBuAbcZRwHCsfC1J
 6EZ3wjn1Ll30t5zprST4ENTFXsWP2TMupj++9F24zuukQcH2OGPaTJGi2ONdGHutO5OmFh9sKyp
 POanBhW7GYr9V1UAxo6IyHrimCPU5beGfHgQ5APZeCaP/RMgw/p+0Igt8mAuHjeOXTjFeLGpj3p
 hDtVOeQFh89lerz9e9ysE2bBXjO3tN8OOn7A==
X-Gm-Gg: ASbGnctSi73GWShUqB0+sKecs0YrZ8EF6zg+dd8+fS7GYHk9pFc3hFOff3d04fM2FGn
 WuZUFCWplKSe0g44xKs0UrSqKNXssuFPtANKRAonh+vGsk7JP/B+G/pRHE/t1LNvTv3b20WYfHp
 RUffPav5duKmM5uwpNT5Sx5PZFJiXYz2nJx/ZiuyLEOPO3uLzDdx1oHBJLmevlziLWIldVIoKaz
 hIKJXU+3bBZE5DwdgIScw1KzVQtP5nRQDeV/QvbSbkEYMG2VUuvQfoJPx8pIM6By6eufVFC987H
 AzWB7Q==
X-Received: by 2002:a05:6000:2204:b0:3a4:ea7e:4634 with SMTP id
 ffacd0b85a97d-3a4fe1618afmr3969459f8f.10.1748791550487; 
 Sun, 01 Jun 2025 08:25:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEqcpc2e6YmT+xlb9gBQzAxXyWTH0o5j2OoJWb/2hnmDyfjqmHI3LrQBmWE+L58VPUHcoXrg==
X-Received: by 2002:a05:6000:2204:b0:3a4:ea7e:4634 with SMTP id
 ffacd0b85a97d-3a4fe1618afmr3969438f8f.10.1748791550086; 
 Sun, 01 Jun 2025 08:25:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b7bbsm11636706f8f.4.2025.06.01.08.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:49 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 25/31] vdpa: reorder vhost_vdpa_set_backend_cap
Message-ID: <c61f0d0938ff452974f319cc4fcae9975d2f20dd.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

It will be used directly by vhost_vdpa_init.

Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20250522145839.59974-3-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 60 +++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 1ab2c11fa8..6b242ca56a 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -594,6 +594,36 @@ static void vhost_vdpa_init_svq(struct vhost_dev *hdev, struct vhost_vdpa *v)
     v->shadow_vqs = g_steal_pointer(&shadow_vqs);
 }
 
+static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
+{
+    struct vhost_vdpa *v = dev->opaque;
+
+    uint64_t features;
+    uint64_t f = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2 |
+        0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH |
+        0x1ULL << VHOST_BACKEND_F_IOTLB_ASID |
+        0x1ULL << VHOST_BACKEND_F_SUSPEND;
+    int r;
+
+    if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &features)) {
+        return -EFAULT;
+    }
+
+    features &= f;
+
+    if (vhost_vdpa_first_dev(dev)) {
+        r = vhost_vdpa_call(dev, VHOST_SET_BACKEND_FEATURES, &features);
+        if (r) {
+            return -EFAULT;
+        }
+    }
+
+    dev->backend_cap = features;
+    v->shared->backend_cap = features;
+
+    return 0;
+}
+
 static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
 {
     struct vhost_vdpa *v = opaque;
@@ -841,36 +871,6 @@ static int vhost_vdpa_set_features(struct vhost_dev *dev,
     return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
 }
 
-static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
-{
-    struct vhost_vdpa *v = dev->opaque;
-
-    uint64_t features;
-    uint64_t f = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2 |
-        0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH |
-        0x1ULL << VHOST_BACKEND_F_IOTLB_ASID |
-        0x1ULL << VHOST_BACKEND_F_SUSPEND;
-    int r;
-
-    if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &features)) {
-        return -EFAULT;
-    }
-
-    features &= f;
-
-    if (vhost_vdpa_first_dev(dev)) {
-        r = vhost_vdpa_call(dev, VHOST_SET_BACKEND_FEATURES, &features);
-        if (r) {
-            return -EFAULT;
-        }
-    }
-
-    dev->backend_cap = features;
-    v->shared->backend_cap = features;
-
-    return 0;
-}
-
 static int vhost_vdpa_get_device_id(struct vhost_dev *dev,
                                     uint32_t *device_id)
 {
-- 
MST


