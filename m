Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7679EC31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8lP-0006FS-28; Wed, 03 Jul 2024 18:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lN-0006Ca-UU
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lJ-0001t1-6P
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6iaejVuyK6cotgddPWIYQA8dIBm4KoXB6zsOD2vQwU=;
 b=JhEWSjAFmJ3FqpmDMhqLPBVrpbpVuogHA4MxjN9qpHXV6SBUwiZp1G/tP2oy8dH2jg49QT
 t6gUEEX/qHkl/9qjMBZ2O/kkvtAFcXeNKPcxdoTdWeaz2BI5EEZ50XLzJky7SWDNWgMKDd
 9Ai8oq/cZ8UswQIqRpWkZZ1heTRfy7Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-U-3D-YjIOz2MEwcdV25q2w-1; Wed, 03 Jul 2024 18:47:38 -0400
X-MC-Unique: U-3D-YjIOz2MEwcdV25q2w-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57c93227bbeso2847627a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046856; x=1720651656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6iaejVuyK6cotgddPWIYQA8dIBm4KoXB6zsOD2vQwU=;
 b=JEr0HzyySoMvls1pNHre/fA7xxPf2iexTw4mrUtxZN+KM+OliHXe6oZ1C4n8tgEwfO
 dTTExFONlDF5pM8Wx8vBboAj7i9/Xmtd9uXY+JI7cfobPk9Xu+chjoCy3rok3lnxlvY+
 3H8euj7+y5k77diXMlOvot3BPcBtTltgQfdW/ctGeDTAS5sDjt59NlrO3pUHmjWp9q38
 /ShqPANuFv4ZwCJtiwAI9bWqENuRiVIyY1yotQhxzTXZrx50GJCnxdOF3KFK0lLQZ8/7
 pzB79xzytPuG8G1ycbLZQ1d/pIRcs3w3gvOcZ/O+dDQhoGZuUJC7+jgmYaSLRV2bEVDh
 idkA==
X-Gm-Message-State: AOJu0YxLUE8iBRxJkvU23umDtSjT18+TZBNw64jNN50j+qhu8G5uRKoV
 4NVGBEWwXmdViR1oYxU8xG0rpZjp7nMjRA/Y1vt+PfwJANtUXikZSVVjim84IrM1JPk15UejPP3
 jzn8To4ezPOWDy6T9fKGFU2duZBu3w5aKocjx7ZbUgG/+aysYT4ON1uVCEHNj/hhZoE3XqAAIa8
 JevMLAbI8PudgZAk+UZ4ItgKIO5K33mg==
X-Received: by 2002:a17:907:1ca0:b0:a75:100a:7966 with SMTP id
 a640c23a62f3a-a7514419725mr1110446766b.1.1720046856266; 
 Wed, 03 Jul 2024 15:47:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGHtGX/WuSUUSmSVxT8AYAPdIj/WcNwtqXJ7GqrO2j/GS7QYr+p9QPWp/2gJnt7ECL8KbiNg==
X-Received: by 2002:a17:907:1ca0:b0:a75:100a:7966 with SMTP id
 a640c23a62f3a-a7514419725mr1110445266b.1.1720046855642; 
 Wed, 03 Jul 2024 15:47:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77af07bd1bsm36213166b.172.2024.07.03.15.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:47:35 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:47:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v3 42/85] hw/virtio: Free vqs after vhost_dev_cleanup()
Message-ID: <25b8a0f40c7f408442c5fd4da195fce9997cfb78.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This fixes LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-san-v2-7-750bb0946dbd@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user-base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 11e72b1e3b..2bc3423326 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -223,6 +223,7 @@ static void vub_disconnect(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    struct vhost_virtqueue *vhost_vqs = vub->vhost_dev.vqs;
 
     if (!vub->connected) {
         goto done;
@@ -231,6 +232,7 @@ static void vub_disconnect(DeviceState *dev)
 
     vub_stop(vdev);
     vhost_dev_cleanup(&vub->vhost_dev);
+    g_free(vhost_vqs);
 
 done:
     /* Re-instate the event handler for new connections */
-- 
MST


