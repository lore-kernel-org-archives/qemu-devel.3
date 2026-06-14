Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C117FCD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAh-0000Al-AO; Sun, 14 Jun 2026 15:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAd-0008Na-W3
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAc-0001po-6o
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UIGef6JbwrI6g4S4pS+Dx1r4bKu5n50rC/TnxegWTg8=;
 b=S/NqiQiyDcQWr7kDX+fnespjqWAEDqf4fo+KahSVYm3nVdxG2IDcIWFg0ukkF+Gvm2FTmH
 BpuEJFbrePV4o8iZsYaD4jCQbiWQhNCqPRMN71+rR9B5Wc/SwRJ2ZKt06V4A/v3bt6SRvF
 9zpuROjz0qE2j5nSYI87sGmlsWxbJLQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-uPASGT2TNnSF1aoEiW0dKg-1; Sun, 14 Jun 2026 15:06:55 -0400
X-MC-Unique: uPASGT2TNnSF1aoEiW0dKg-1
X-Mimecast-MFC-AGG-ID: uPASGT2TNnSF1aoEiW0dKg_1781464014
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490cc1ae292so15155575e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464014; x=1782068814; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UIGef6JbwrI6g4S4pS+Dx1r4bKu5n50rC/TnxegWTg8=;
 b=cotPMi3JQoAyDIKTrHPszPAD8VnNs3fYAcis1lApbpll+qjby2P0JCvvoL6aWJ3Fq8
 jBCqfW9BcR/H2Ydkc1o2HZ8nrPD7f7QlBfo6jmCfDSy2ScpRqRUsYALtriWxGzNUEk+P
 M4/SBY+9Ug0KJVgzomeRaLLsOD1d1DgSZPsOYp6KR3ccpJU9BEhpIlZDd8eNs/qDflRD
 hZRK7ko4dt4SCnUpa3nMwc9naQLVDwTHzMtQJ2qnpBKTGcviQ4dY+6XsWzroV8utRRdz
 1lyzDxI1lg/O0djM824kAkIq80OOnRS/xnHxgNNxk1asWmv9aV2tXYB+2ZyQd3TJlV7s
 n5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464014; x=1782068814;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UIGef6JbwrI6g4S4pS+Dx1r4bKu5n50rC/TnxegWTg8=;
 b=P6gOGk2iu+ua21GCG9Fx+FvXwp3ZAAx+SWh5vONTlwHQMb5QfK5OVoaIVkVX8G5YeQ
 +ZW5VCXSr0TRSMt67ViVBTrudAj8jpWK2H36cAbuZeg0iR1/hahqB4rjqAqaUCpUt8m8
 E20YmV+E+3DWAmszO9sNdGRaVl3GNdZKYOvjQ7wPdN4qOoTftaU3H3buDdcbndXUL9qU
 d+jyoa/7B/6HN0niqLyxjclPnTESTLtat2DIwiJSxpH4RcE1wWzPd6qyMv2+0wYH2rGa
 QGCv9nI8zcvBfUocXNfp6UTs7UdPqPRhcYFiPHAsvtE7HthdNWkf/rTkecYMN+TsZ/ZE
 yVlA==
X-Gm-Message-State: AOJu0Yydtg5/KUYwYc7mNY1eD6wibjg+spNGpXHPAgU118THRg5Euryl
 l4j1eVWpt0EStE/SitWKmCOIBPYmLU7ebc+Gl2Bw/o/lZGxdFr29pYWQgQ4j6aozmgQluUOhPbH
 GdpJB/Aapk2FGLiMBn8dDjCTruXU17V8cZkbcAfH1nzFHVOUMMuvCq0XbTYgIlhDxdnek6xnqNk
 fkqIH8bhIhXBI2lCkO192J5rJKmElTLVyY+A==
X-Gm-Gg: Acq92OHynpMXm7CRnbGy6bDz8UOxpNuy6NIOKFK0olnpJYeEY1yY/9WrUJftrfvvFCv
 2G8Dg3U9xgn9djEff/F6sSB21oNgY6ZvKJIKasoQSS4HyRChEtV2MDtpQhQWvOuO9/6rQSi8WnJ
 cRtzwJskR7RCifjIq+oWAaMiho/HgFYvujA+Dvst5OLy5dVCoVHM2Rf3G6eqnlgqdSAXACzIOWE
 rF/APFFZxxhY8pcXfG/859CYA6ywzsaes/7MuiEojPoj4ZD2abXx5ijUlA5dzaSnnsCbkbydYxR
 j4z99dxOw9LMgTAvAAB1QzIQUpiV2Q+euWqrAU5VMf2v6OMsvccOyb8ipRwrVc1aawFSeHqdDD/
 Fo4s9vyatLRrATm4BZpQROGUHz5ST4u7EyrMKc3fJrqw=
X-Received: by 2002:a05:600c:3542:b0:490:b4a8:e031 with SMTP id
 5b1f17b1804b1-490ec480e65mr121591635e9.4.1781464013911; 
 Sun, 14 Jun 2026 12:06:53 -0700 (PDT)
X-Received: by 2002:a05:600c:3542:b0:490:b4a8:e031 with SMTP id
 5b1f17b1804b1-490ec480e65mr121591275e9.4.1781464013340; 
 Sun, 14 Jun 2026 12:06:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922035b4absm184569895e9.11.2026.06.14.12.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:52 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Lei Yang <leiyang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 027/106] vhost-user: rework enabling vrings
Message-ID: <44c8f42d5824ab652ddeedb79851fa72d2af7be1.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We call the handler almost the same way in three places:

 - cryptodev-vhost.c
 - vhost_net.c
 - vhost.c

The only difference, is that in vhost.c we don't try to call the handler
for old vhost-user (when VHOST_USER_F_PROTOCOL_FEATURES is not supported).

cryptodev-vhost and vhost_net code will just fail in this case. Probably
they were developed only for newer vhost-user. Anyway, it doesn't seem
correct to rely on this error path, if these devices want to check,
that they don't communicate to old vhost-user protocol, they should
do that earlier.

Let's create the common helper, to call .vhost_set_vring_enable and
use in all three places. For vhost-user let's just always skip
enable/disable if it's unsupported.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-2-vsementsov@yandex-team.ru>
---
 backends/cryptodev-vhost.c |  8 +-------
 hw/net/vhost_net.c         |  7 +------
 hw/virtio/vhost-user.c     |  7 ++++++-
 hw/virtio/vhost.c          | 21 ---------------------
 include/hw/virtio/vhost.h  |  9 +++++++++
 5 files changed, 17 insertions(+), 35 deletions(-)

diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index 943680a23a..abdfce33af 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -152,7 +152,6 @@ vhost_set_vring_enable(CryptoDevBackendClient *cc,
 {
     CryptoDevBackendVhost *crypto =
                        cryptodev_get_vhost(cc, b, queue);
-    const VhostOps *vhost_ops;
 
     cc->vring_enable = enable;
 
@@ -160,12 +159,7 @@ vhost_set_vring_enable(CryptoDevBackendClient *cc,
         return 0;
     }
 
-    vhost_ops = crypto->dev.vhost_ops;
-    if (vhost_ops->vhost_set_vring_enable) {
-        return vhost_ops->vhost_set_vring_enable(&crypto->dev, enable);
-    }
-
-    return 0;
+    return vhost_dev_set_vring_enable(&crypto->dev, enable);
 }
 
 int cryptodev_vhost_start(VirtIODevice *dev, int total_queues)
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index a8ee18a912..25e9f1fd24 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -587,7 +587,6 @@ VHostNetState *get_vhost_net(NetClientState *nc)
 int vhost_net_set_vring_enable(NetClientState *nc, int enable)
 {
     VHostNetState *net = get_vhost_net(nc);
-    const VhostOps *vhost_ops = net->dev.vhost_ops;
 
     /*
      * vhost-vdpa network devices need to enable dataplane virtqueues after
@@ -601,11 +600,7 @@ int vhost_net_set_vring_enable(NetClientState *nc, int enable)
 
     nc->vring_enable = enable;
 
-    if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
-        return vhost_ops->vhost_set_vring_enable(&net->dev, enable);
-    }
-
-    return 0;
+    return vhost_dev_set_vring_enable(&net->dev, enable);
 }
 
 int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index a8907cca74..13c73e7b17 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1230,7 +1230,12 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
     int i;
 
     if (!virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES)) {
-        return -EINVAL;
+        /*
+         * For vhost-user devices, if VHOST_USER_F_PROTOCOL_FEATURES has not
+         * been negotiated, the rings start directly in the enabled state,
+         * and can't be disabled.
+         */
+        return 0;
     }
 
     for (i = 0; i < dev->nvqs; ++i) {
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b9dc4ed13b..b89797df95 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2078,27 +2078,6 @@ int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
     return 0;
 }
 
-static int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
-{
-    if (!hdev->vhost_ops->vhost_set_vring_enable) {
-        return 0;
-    }
-
-    /*
-     * For vhost-user devices, if VHOST_USER_F_PROTOCOL_FEATURES has not
-     * been negotiated, the rings start directly in the enabled state, and
-     * .vhost_set_vring_enable callback will fail since
-     * VHOST_USER_SET_VRING_ENABLE is not supported.
-     */
-    if (hdev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER &&
-        !virtio_has_feature(hdev->backend_features,
-                            VHOST_USER_F_PROTOCOL_FEATURES)) {
-        return 0;
-    }
-
-    return hdev->vhost_ops->vhost_set_vring_enable(hdev, enable);
-}
-
 /*
  * Host notifiers must be enabled at this point.
  *
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 89817bd848..3dfec5e15c 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -215,6 +215,15 @@ static inline bool vhost_dev_is_started(struct vhost_dev *hdev)
     return hdev->started;
 }
 
+static inline int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
+{
+    if (!hdev->vhost_ops->vhost_set_vring_enable) {
+        return 0;
+    }
+
+    return hdev->vhost_ops->vhost_set_vring_enable(hdev, enable);
+}
+
 /**
  * vhost_dev_start() - start the vhost device
  * @hdev: common vhost_dev structure
-- 
MST


