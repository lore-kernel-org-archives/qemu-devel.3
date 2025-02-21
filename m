Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D989C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS5J-0001Q8-K2; Fri, 21 Feb 2025 07:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS51-0008QZ-FF
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4z-0007D6-NS
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0LpIbNsQ+dt+JvKUY8+SWh8i4my2OzTIZC5O+PsCrUY=;
 b=YkZr5iUV9enX8mZmF2c7nDdYgxLiT1Y6/Q02TG2eZeObrI2fdUF1WnebWny+Oh98wY6dTC
 zQbmSk81wt8QQZBLh7HPw2RCplaBbk0Mso4iLSTnR82Suu5tbWQ8Vofjvf7jyHj+2r0h5G
 faUvdS0QiILyxFVoh/LmbVVocB2GjEc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-UKnG_SJcMJiToIkYm2WLew-1; Fri, 21 Feb 2025 07:24:27 -0500
X-MC-Unique: UKnG_SJcMJiToIkYm2WLew-1
X-Mimecast-MFC-AGG-ID: UKnG_SJcMJiToIkYm2WLew_1740140667
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4393b6763a3so9536315e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140666; x=1740745466;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0LpIbNsQ+dt+JvKUY8+SWh8i4my2OzTIZC5O+PsCrUY=;
 b=CRTWvbk5rWhACCEukoXKmQNZVWGLsg9/CATpVQg7AxANw1LWVBfdHrv184MunAHf2r
 yUhsb27QDKtnsE4vhlPyfjl9/ETErcoveB5ZLKmX/+guyGhGXN+aP90cs3DFG/YuqY79
 iQ1e+Tjt7XGilKhCKDHlX8xb+ZfCj5sZ3FoE/1Cuk05jaTP+CJ0HB9QXNdS1t9B7ys/L
 DEulAet6nv0a1hAAn7p+OdroTZsknEyk8k8TsanU8lXDU7ise85Yf/jvadLAf9yHm7xh
 AvgGAeWsLaUYBKCobfs0WEbz28eyvd9GNpwvq8yGejPJ5Z5M7E9gf/kpBLUBn8IGYrjC
 YfRg==
X-Gm-Message-State: AOJu0Yw3JWcd0Ces0xhIXTUIk+UvKRncJtLImqiMoC8cYKId4vKqRMVW
 DzOP0iQatlYHR6X4m/f8K3htZNSKqefJwJKSV71c9q757mRqdQuB+wl5rwNFFj5HsPjpMbta0ib
 B/e8CeKm4PLU7K+IpNmE+yzA9ZjD7Jj10EwjyvuD7CCpIz+f8kUdan2XI7IfRqsHuYEl090In/k
 Qxj6iGvA15kRQIuc8TMVnN3DN3uO8WMg==
X-Gm-Gg: ASbGnctZzuveSBugLT/Go2asQ2M7Hnf0A55S5uVVyFhyXrpXBp1z014q5GkkNXhtc+F
 K9jODfgP/bogcMJFJZ5GYo9iAW1PXndaGT/Fnd9iIhMrLWRbrOShLZQyOH/Ls5AhCfvH+Sb/Dxk
 zCjwmYEyxKhCqhUEd297UsVBykzb4/6Q3uNJINaOgdo3EsKHJQ259ySTX3fqB6bWsabi7bM/MJE
 Vs0Dxocb6SkbHYIM5V6w5G+UL6o93rY65A2Qa1cf9Psi+fcfCb7iwHU6ZGMhe2/VdkFmNmf+7V9
 Is/Wow==
X-Received: by 2002:a05:600c:3c90:b0:439:a202:86dd with SMTP id
 5b1f17b1804b1-439b155b048mr15027135e9.26.1740140666226; 
 Fri, 21 Feb 2025 04:24:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3DqUfrNt+5E8efvA4ge4PEvPvxxIj1UbxOtGVHHSmIjAJzSbsPusm/w+FqHQbYdxCuImAzw==
X-Received: by 2002:a05:600c:3c90:b0:439:a202:86dd with SMTP id
 5b1f17b1804b1-439b155b048mr15026825e9.26.1740140665730; 
 Fri, 21 Feb 2025 04:24:25 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399bea8577sm64824915e9.0.2025.02.21.04.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:24:25 -0800 (PST)
Date: Fri, 21 Feb 2025 07:24:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 33/41] vdpa: Fix endian bugs in shadow virtqueue
Message-ID: <50e9754149066dc91f58405d3378b589098cb408.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Konstantin Shkolnyy <kshk@linux.ibm.com>

VDPA didn't work on a big-endian machine due to missing/incorrect
CPU<->LE data format conversions.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Message-Id: <20250212164923.1971538-1-kshk@linux.ibm.com>
Fixes: 10857ec0ad ("vhost: Add VhostShadowVirtqueue")
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 30ba565f03..2481d49345 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -182,10 +182,10 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
         descs[i].len = cpu_to_le32(iovec[n].iov_len);
 
         last = i;
-        i = cpu_to_le16(svq->desc_next[i]);
+        i = svq->desc_next[i];
     }
 
-    svq->free_head = le16_to_cpu(svq->desc_next[last]);
+    svq->free_head = svq->desc_next[last];
     return true;
 }
 
@@ -247,10 +247,12 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
     smp_mb();
 
     if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
-        uint16_t avail_event = *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]);
+        uint16_t avail_event = le16_to_cpu(
+                *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]));
         needs_kick = vring_need_event(avail_event, svq->shadow_avail_idx, svq->shadow_avail_idx - 1);
     } else {
-        needs_kick = !(svq->vring.used->flags & VRING_USED_F_NO_NOTIFY);
+        needs_kick =
+                !(svq->vring.used->flags & cpu_to_le16(VRING_USED_F_NO_NOTIFY));
     }
 
     if (!needs_kick) {
@@ -386,7 +388,7 @@ static bool vhost_svq_more_used(VhostShadowVirtqueue *svq)
         return true;
     }
 
-    svq->shadow_used_idx = cpu_to_le16(*(volatile uint16_t *)used_idx);
+    svq->shadow_used_idx = le16_to_cpu(*(volatile uint16_t *)used_idx);
 
     return svq->last_used_idx != svq->shadow_used_idx;
 }
@@ -404,7 +406,7 @@ static bool vhost_svq_enable_notification(VhostShadowVirtqueue *svq)
 {
     if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         uint16_t *used_event = (uint16_t *)&svq->vring.avail->ring[svq->vring.num];
-        *used_event = svq->shadow_used_idx;
+        *used_event = cpu_to_le16(svq->shadow_used_idx);
     } else {
         svq->vring.avail->flags &= ~cpu_to_le16(VRING_AVAIL_F_NO_INTERRUPT);
     }
@@ -429,7 +431,7 @@ static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqueue *svq,
                                              uint16_t num, uint16_t i)
 {
     for (uint16_t j = 0; j < (num - 1); ++j) {
-        i = le16_to_cpu(svq->desc_next[i]);
+        i = svq->desc_next[i];
     }
 
     return i;
@@ -704,7 +706,7 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
     svq->desc_state = g_new0(SVQDescState, svq->vring.num);
     svq->desc_next = g_new0(uint16_t, svq->vring.num);
     for (unsigned i = 0; i < svq->vring.num - 1; i++) {
-        svq->desc_next[i] = cpu_to_le16(i + 1);
+        svq->desc_next[i] = i + 1;
     }
 }
 
-- 
MST


