Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1B4CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UDl-0007TN-OA; Sun, 05 Oct 2025 15:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDh-0007SO-OG
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDf-0006Mx-1j
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T9JiUJVF1IY5GSi12FGsN+bySZ+KyddxbfjDd0ABMyI=;
 b=Ojw7RRMQt8lI8OakStICf/yteUqlaiTXLJfZ4RO3djQSjDoXZEWKk+XftpgaxMYsY5Y0dC
 HjtxsOZHmxNjc6kG28GuT49F4vYeuTGSnuZoAkcJNUsw8Y2u45CTXU65FYXqDrw5kNuTi7
 YUPd7CKizQdsP1boJN5ACm0yFDgLn64=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-fycBWVaFO4C5nqDsVRS78g-1; Sun, 05 Oct 2025 15:16:27 -0400
X-MC-Unique: fycBWVaFO4C5nqDsVRS78g-1
X-Mimecast-MFC-AGG-ID: fycBWVaFO4C5nqDsVRS78g_1759691786
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e31191379so26930945e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691786; x=1760296586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9JiUJVF1IY5GSi12FGsN+bySZ+KyddxbfjDd0ABMyI=;
 b=ezd1fCYsouAkuHdUKTlYV91FXIRG6pF1EEoiwagMMTCen4CFBfkQhefmZmK9Jtw4eN
 mELGpy3BJSQ/cWJL+IpgiFiEgDtVmgyagxZhYrPWUbzw0RB1fv+Cx9zECb7bX/AO0pma
 1FOko2k6rcysBLU89Y3c082ehFQmRLAxObFjJYK7G7eg1qg3esZa4gWprBMIv4M6jC+U
 1no699mCl2/Kgc4csL+GImk2wI8uyBQHoeotZteqfu2Cg6OEoZspbskwxQL5nqL+4d1+
 t917V1Lj2gFdpFc52W6NxPraJHlg4I8GgRJvWBeW8nr1TlmNF086LUOMV7RigSSRrfQd
 9ZmA==
X-Gm-Message-State: AOJu0YySHS/nLmeQhgjZ63EN4EiySE2wBGwsyy+jjBh7mHjh4fxJQV3w
 J6PzlAYTl1qYQCva4/TvLT0wXyjI1OBDOx6TTpOXAv7sMJcuL8+q+eLzgjMlA/AbYNs/8erjnTi
 czSzkyGQQxU7YuYVakCOwXg7d/KEGNyA+c0/fPSDazJhww7fGwjqQv5nI0Ty6OEDP7HjPFZUJ7r
 cOYUXDv9WyG4M2eNpwcCNJEJGfRfOuXbzRuw==
X-Gm-Gg: ASbGncsx38TbSUAN8ym88if8to6kTDe4YW1YQBPO1eM7QkphRoQjF09B95SCG3vh+yw
 PCuzJJP4vTBoLOUy3aeCO6it+VVa6tq443MdY6pZ4WmHwPu1J1oh0ygYxqTVoPyUbiW4sLtNntY
 AMDbtaY9POXfzk5FjOZ6ncZC2wJGf81LzBv+MxE2OdGCIpwJMvPizRDWaJtOs5lprq21nam85hj
 MQY5DXlaF6Y7+hsjwWamL3D6AfV8HTNYCSQwmgwOF59UB6/7nseUPhRO1Tlj0zhWYQfL8S3rM3s
 GSNkme8DsNOpWlbC0fKD77y3jsURtvB7vI+cKIQ=
X-Received: by 2002:a05:600c:350b:b0:459:e398:ed89 with SMTP id
 5b1f17b1804b1-46e710fe3a0mr61011225e9.1.1759691785971; 
 Sun, 05 Oct 2025 12:16:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYqrY5rQ+cewOwkdChC4gU0ClZemwx0HVQHJ0DU8aamsFmWPjG1tYZ2vir4AiUGsKrg09UbQ==
X-Received: by 2002:a05:600c:350b:b0:459:e398:ed89 with SMTP id
 5b1f17b1804b1-46e710fe3a0mr61011065e9.1.1759691785502; 
 Sun, 05 Oct 2025 12:16:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619c3b75sm217407595e9.7.2025.10.05.12.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:25 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Abeni <pabeni@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PULL 10/75] vhost-backend: implement extended features support
Message-ID: <f412c1f57ab58fd595efee26264193759220ca6f.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Abeni <pabeni@redhat.com>

Leverage the kernel extended features manipulation ioctls(), if
available, and fallback to old ops otherwise. Error out when setting
extended features but kernel support is not available.

Note that extended support for get/set backend features is not needed,
as the only feature that can be changed belongs to the 64 bit range.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <150daade3d59e77629276920e014ee8e5fc12121.1758549625.git.pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-backend.c | 62 ++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 833804dd40..4367db0d95 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -20,6 +20,11 @@
 #include <linux/vhost.h>
 #include <sys/ioctl.h>
 
+struct vhost_features {
+    uint64_t count;
+    uint64_t features[VIRTIO_FEATURES_NU64S];
+};
+
 static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int request,
                              void *arg)
 {
@@ -182,12 +187,6 @@ static int vhost_kernel_get_vring_worker(struct vhost_dev *dev,
     return vhost_kernel_call(dev, VHOST_GET_VRING_WORKER, worker);
 }
 
-static int vhost_kernel_set_features(struct vhost_dev *dev,
-                                     uint64_t features)
-{
-    return vhost_kernel_call(dev, VHOST_SET_FEATURES, &features);
-}
-
 static int vhost_kernel_set_backend_cap(struct vhost_dev *dev)
 {
     uint64_t features;
@@ -210,10 +209,51 @@ static int vhost_kernel_set_backend_cap(struct vhost_dev *dev)
     return 0;
 }
 
-static int vhost_kernel_get_features(struct vhost_dev *dev,
-                                     uint64_t *features)
+static int vhost_kernel_set_features(struct vhost_dev *dev,
+                                     const uint64_t *features)
 {
-    return vhost_kernel_call(dev, VHOST_GET_FEATURES, features);
+    struct vhost_features farray;
+    bool extended_in_use;
+    int r;
+
+    farray.count = VIRTIO_FEATURES_NU64S;
+    virtio_features_copy(farray.features, features);
+    extended_in_use = virtio_features_use_ex(farray.features);
+
+    /*
+     * Can't check for ENOTTY: for unknown ioctls the kernel interprets
+     * the argument as a virtio queue id and most likely errors out validating
+     * such id, instead of reporting an unknown operation.
+     */
+    r = vhost_kernel_call(dev, VHOST_SET_FEATURES_ARRAY, &farray);
+    if (!r) {
+        return 0;
+    }
+
+    if (extended_in_use) {
+        error_report("Trying to set extended features without kernel support");
+        return -EINVAL;
+    }
+    return vhost_kernel_call(dev, VHOST_SET_FEATURES, &farray.features[0]);
+}
+
+static int vhost_kernel_get_features(struct vhost_dev *dev, uint64_t *features)
+{
+    struct vhost_features farray;
+    int r;
+
+    farray.count = VIRTIO_FEATURES_NU64S;
+    r = vhost_kernel_call(dev, VHOST_GET_FEATURES_ARRAY, &farray);
+    if (r) {
+        memset(&farray, 0, sizeof(farray));
+        r = vhost_kernel_call(dev, VHOST_GET_FEATURES, &farray.features[0]);
+    }
+    if (r) {
+        return r;
+    }
+
+    virtio_features_copy(features, farray.features);
+    return 0;
 }
 
 static int vhost_kernel_set_owner(struct vhost_dev *dev)
@@ -341,8 +381,8 @@ const VhostOps kernel_ops = {
         .vhost_attach_vring_worker = vhost_kernel_attach_vring_worker,
         .vhost_new_worker = vhost_kernel_new_worker,
         .vhost_free_worker = vhost_kernel_free_worker,
-        .vhost_set_features = vhost_kernel_set_features,
-        .vhost_get_features = vhost_kernel_get_features,
+        .vhost_set_features_ex = vhost_kernel_set_features,
+        .vhost_get_features_ex = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
-- 
MST


