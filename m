Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D78DC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeAB-0001y6-Bz; Tue, 02 Jul 2024 10:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeA9-0001xY-3H
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeA6-0007qo-H4
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMYpex8C2s46cF0GfMcoGvUcCxmqXFvGY/Nt+8TTLHo=;
 b=b9LIPW/w6URdeJeZQ9ohIhX74ZnQYajski6rE/nXXjgMy9u/728TbUO3GghOifhtgMep5o
 ERRX9KnBiq6cXqa/UwdxYpasNdAjM7Ji07bm41fv/z/396ZEy7EmUURBfoSf8PFJx7fX2/
 ySHq9ujhumufwp/CBN52BSlX1uxvvPw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-9FCh_UpcODCHwOT5TWuc0g-1; Tue, 02 Jul 2024 10:07:11 -0400
X-MC-Unique: 9FCh_UpcODCHwOT5TWuc0g-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ec4efbbb7aso37510961fa.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929229; x=1720534029;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZMYpex8C2s46cF0GfMcoGvUcCxmqXFvGY/Nt+8TTLHo=;
 b=JORNwU1jWuFwyu/4znV1eIagnBVGiaDVTX/OCR+bXf+k0+UHKz/fa+AhEtx1Px8ADi
 k0wSNP842rXVYt74m3L96ycKndFwpk6Mq0pcEr4U0hNrSjqJ5rUgufUOXQwwArxDu+9w
 bIrVmcvRp7SmDEmF+iKTC7rWui0Cx0HcdhNB31YJjIMiY+qc9hxv8f1y+Sb8Hv5qHv65
 +pdw/16iBhUZ03kWBNfu4xqqBcxPKkdin1g4rolPBofdYHGEYWgpZW9mSRENjFkVt6SO
 gurbN7FKrvQBlm9qyefLTsol/5i9TF3qdA9jRNghzzUWN2qH1e0tRYITaJG4C+cBn7Gk
 hxtQ==
X-Gm-Message-State: AOJu0Yx0m1j+YXxQC5MLAtvyZMhxMvrX/VFlfJQcCmvMFtEoJD7bShZn
 DpD2o74kZNqLSkjAEZoMzX6u8l2quyoEOSOEkGBbz9LbkCKEyrVnV/EoB5oCqw6UMAfEbW4hzGS
 Jgiq/5+UVYydE0Czp108n99Q0tjit+RO48cSwi2z/QSqYCl6V9SdsaM96GdFXbSzpTiH4NSBLqa
 HEf5isLmqzTSPM73hP37ZBdUHcM1jaNw==
X-Received: by 2002:a2e:9985:0:b0:2ee:5b32:9d5d with SMTP id
 38308e7fff4ca-2ee5e707c04mr64091901fa.47.1719929229095; 
 Tue, 02 Jul 2024 07:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8ZXILvUxSkM5nA0R2F2YALp+IaGYAw73lLeo0L5l/6UfvGQXdI+H2Utq1FezF1veoQbqTHw==
X-Received: by 2002:a2e:9985:0:b0:2ee:5b32:9d5d with SMTP id
 38308e7fff4ca-2ee5e707c04mr64091471fa.47.1719929228317; 
 Tue, 02 Jul 2024 07:07:08 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3f14csm201524745e9.6.2024.07.02.07.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:07:07 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:07:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/91] vhost-vdpa: check vhost_vdpa_set_vring_ready() return
 value
Message-ID: <9d5a807c4cb56837f11be9a9250f854fab951290.1719929191.git.mst@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefano Garzarella <sgarzare@redhat.com>

vhost_vdpa_set_vring_ready() could already fail, but if Linux's
patch [1] will be merged, it may fail with more chance if
userspace does not activate virtqueues before DRIVER_OK when
VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated.

So better check its return value anyway.

[1] https://lore.kernel.org/virtualization/20240206145154.118044-1-sgarzare@redhat.com/T/#u

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240322092315.31885-1-sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 85e73dd6a7..eda714d1a4 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -399,7 +399,10 @@ static int vhost_vdpa_net_data_load(NetClientState *nc)
     }
 
     for (int i = 0; i < v->dev->nvqs; ++i) {
-        vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
+        int ret = vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
+        if (ret < 0) {
+            return ret;
+        }
     }
     return 0;
 }
@@ -1238,7 +1241,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
-    vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
+    r = vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
+    if (unlikely(r < 0)) {
+        return r;
+    }
 
     if (v->shadow_vqs_enabled) {
         n = VIRTIO_NET(v->dev->vdev);
@@ -1277,7 +1283,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
     }
 
     for (int i = 0; i < v->dev->vq_index; ++i) {
-        vhost_vdpa_set_vring_ready(v, i);
+        r = vhost_vdpa_set_vring_ready(v, i);
+        if (unlikely(r < 0)) {
+            return r;
+        }
     }
 
     return 0;
-- 
MST


