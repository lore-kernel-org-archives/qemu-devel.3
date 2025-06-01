Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F01C5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkZU-0003Da-1G; Sun, 01 Jun 2025 11:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZR-00032A-Sn
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZQ-0004gB-8j
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOzRFXQKwYUGhNGpKvBwxp6FWf6JjZqCT1oic4AmAzI=;
 b=De0reKEKZJ0h9/Wn+WR4CFvRXx+ZA2aOKX5U2abinZBNAqTR3D5O3geO62asZvhYb8NoaR
 ipUwO8qdwnX7c2qPiJW7daKIfKfH1fDPsW9uYHz0N6I6OvahqjA7oKubSe+sfis4tPLYW3
 /M6X7cSAFtETqnA+fIme0sCypkSmjXY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-0tasNZvWNtKVheB_K8WGfg-1; Sun, 01 Jun 2025 11:25:54 -0400
X-MC-Unique: 0tasNZvWNtKVheB_K8WGfg-1
X-Mimecast-MFC-AGG-ID: 0tasNZvWNtKVheB_K8WGfg_1748791554
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43eed325461so22432985e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791553; x=1749396353;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dOzRFXQKwYUGhNGpKvBwxp6FWf6JjZqCT1oic4AmAzI=;
 b=Vy4W5rUymHbD0ZpwqZ4pbnz+mYXZhciOo0E5cWjukYQRZysIpNGwY0/NR1jprmM4BQ
 khh9YGZ42wfi0EtyokLu+1ZlpEe8ebqYEGHPl8f6A+3G9XJWcF/KYJR4k8ZiiNUJCObq
 ODnL1Miw5ExcijSHdR1OMHrpHmijMrJBfSdSrlYLnao3NjKTYbHLqPIE4fZb4w6iSI78
 /ikcd5knPBiR3Al6UVdAlqB6jeTsMcPR9OVk9d+NGHkkOVYmLJ6h+ubWkjmExHKtxGMD
 RjjznmE7kAU9XE90+8cGNXGCA73H3jQFOXPgC62cvCaacjhnCpSj8YH0gP7GweZ2JrV0
 UC+w==
X-Gm-Message-State: AOJu0YxOQ2BkWZH1wPJD7LbXHn97Ze1ZYqxYs3490+Bh6+JBgRMWloBp
 Z8GiKbuaW2HwMVUIPXWpFQwzS5yveHYVd9x2+YoKrEOk/kwAyVAGn1PAelLVl3gAYIGMsMTCA30
 qmEvGb+fTlz3gL/yfowHjMoVYus/s4Tybmm30m/9lwvy6r2lTaof6T7DKdrdbXRqOEPGneG+ALg
 VuycN9cJDfrBMZglOwjBHA5BI8MusjXFrlIw==
X-Gm-Gg: ASbGncuTahkB0zqzphlblNmMXUwj/sLvPMmXgEPAw/1RsUaQo4B/YoDInIp+CL1HjUm
 QX01qHi5CHWKB9QehCsb90JfbpahoqnVNYkPCNRnPigJuI88bJHLicNYZOW6D65p3Lfu2rbwxVf
 RyCGCc6e1oumR2W3/MAcGkz7tccVP9GlPHwAC9SL/JZhcbqXgKSn4hgEAO0u/AOdIeV63MtlWyF
 p/9iiI68cSoPkHvIKHTg0O+kOW91E2clS91szFOaUJT+8bACAv8BZSNURDb94Ar7NaiPU3nIA7q
 7YovJw6UPLZfXkHK
X-Received: by 2002:a5d:588d:0:b0:3a4:c9d4:2fb2 with SMTP id
 ffacd0b85a97d-3a4f89dccf0mr7208668f8f.46.1748791553042; 
 Sun, 01 Jun 2025 08:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL+yn40MFveH2hya/kju2NBRF+i59FVk6IRpq/5D5RN8Lbq7r18bLSWIay3oTzgyFRkdH/FA==
X-Received: by 2002:a5d:588d:0:b0:3a4:c9d4:2fb2 with SMTP id
 ffacd0b85a97d-3a4f89dccf0mr7208647f8f.46.1748791552539; 
 Sun, 01 Jun 2025 08:25:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fc1b60sm89962615e9.34.2025.06.01.08.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:51 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 26/31] vdpa: set backend capabilities at vhost_vdpa_init
Message-ID: <8f0b6836a0d8dc7d2159d61bc35a42d7c9a9e22a.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

The backend does not reset them until the vdpa file descriptor is closed
so there is no harm in doing it only once.

This allows the destination of a live migration to premap memory in
batches, using VHOST_BACKEND_F_IOTLB_BATCH.

Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20250522145839.59974-4-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 6b242ca56a..e9826ede2c 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -634,6 +634,12 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
     v->dev = dev;
     dev->opaque =  opaque ;
     v->shared->listener = vhost_vdpa_memory_listener;
+
+    ret = vhost_vdpa_set_backend_cap(dev);
+    if (unlikely(ret != 0)) {
+        return ret;
+    }
+
     vhost_vdpa_init_svq(dev, v);
 
     error_propagate(&dev->migration_blocker, v->migration_blocker);
@@ -1563,7 +1569,6 @@ const VhostOps vdpa_ops = {
         .vhost_set_vring_kick = vhost_vdpa_set_vring_kick,
         .vhost_set_vring_call = vhost_vdpa_set_vring_call,
         .vhost_get_features = vhost_vdpa_get_features,
-        .vhost_set_backend_cap = vhost_vdpa_set_backend_cap,
         .vhost_set_owner = vhost_vdpa_set_owner,
         .vhost_set_vring_endian = NULL,
         .vhost_backend_memslots_limit = vhost_vdpa_memslots_limit,
-- 
MST


