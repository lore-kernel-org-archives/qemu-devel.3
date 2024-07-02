Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A319C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjta-0001yU-Iy; Tue, 02 Jul 2024 16:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjtZ-0001tI-Jp
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:14:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjtY-0007bU-1h
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bf3inGfH3C1OrX/KdJFaqQvDHDePnfUDWhDjBaZ52tk=;
 b=PoA7wVDbQjNMPKaUm1saLTclwd1D6aUd4HzO50fIC0UeMu3o3T88sKRKM6YvPMpHJXy3jJ
 fOnixuz90StSVlkNbPILKUWrY1jUxvuGngoAfmgHEHO9atxa0w2aI+yRChSx0v+7Zh6aHK
 9hrLww4fKpHi9o11FRjwGanzRGNQYVc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-TnU8WdSWM9SLpvxZQJjqjg-1; Tue, 02 Jul 2024 16:14:29 -0400
X-MC-Unique: TnU8WdSWM9SLpvxZQJjqjg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4258675a531so14497775e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951268; x=1720556068;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bf3inGfH3C1OrX/KdJFaqQvDHDePnfUDWhDjBaZ52tk=;
 b=Vd9SEypN9hdBwGi6DrUUmU2WWdLpHjlX6+GLBY+YThsDFJA/zsq9yUhRAmguMHh5qB
 tCzRC4zRkNPt1R6AferuK05QUKeuGZYxNkZcED8XJKdJzt/QkyRovvTrkZoOhFe9ow+B
 8FHzvryZyvt/OGecNpROTfu0+bCc8Mp0IfRT/IW0pJUgec0Ig2kAhCbr69H4L4KIuKzW
 Zu7YMrxrPrDnepezk9qLBCko5bGcMAGt+F2nHDqTjHVPFl2up/3o+ZIqGTZV4q2SNQc8
 p+4nXbWgLGd7UGJzqACe8kFdBHDhnXf/t7IyAf3aBsT9E5KnAM4dCDOh7ScsbBWQb/DM
 iaRQ==
X-Gm-Message-State: AOJu0Yys15UKerJHrQTqSqaYNlH1FmhYxif0+rJqGseLe5F7Akjkxk1V
 j1bOfHbaSTGcWlU1bcrWWRmfi/fOZUPFFjBazhI0APb25gi/MfQ5zj1xi9oKQgoA/skmcAVw29G
 jQTw6MeQoQGp5FXFZtjt8JpffDytArNlu/1cA3TVJiJI5YVqtxXIpu5yKc4ToDka6MNN4jgdHY4
 yJaPQ7pA3g3yQyhjPI8wo1vrqjmk6kuA==
X-Received: by 2002:a05:600c:3594:b0:425:602f:d62c with SMTP id
 5b1f17b1804b1-4257a00d420mr63548645e9.9.1719951267787; 
 Tue, 02 Jul 2024 13:14:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzUclVT4OZq71sYTIPH5j84XeLCN9z+SyLrD66TIoypUsUPfB2mXm7rGt14XXkS9Iz2c+Kzg==
X-Received: by 2002:a05:600c:3594:b0:425:602f:d62c with SMTP id
 5b1f17b1804b1-4257a00d420mr63548475e9.9.1719951267269; 
 Tue, 02 Jul 2024 13:14:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a104727sm14085938f8f.111.2024.07.02.13.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:14:26 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:14:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Wafer <wafer@jaguarmicro.com>,
 Jason Wang <jasowang@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL v2 11/91] hw/virtio: Fix obtain the buffer id from the last
 descriptor
Message-ID: <33abfea239592a706e98269b01c0096249612ea4.1719951026.git.mst@redhat.com>
References: <cover.1719951026.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951026.git.mst@redhat.com>
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

From: Wafer <wafer@jaguarmicro.com>

The virtio-1.3 specification
<https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html> writes:
2.8.6 Next Flag: Descriptor Chaining
      Buffer ID is included in the last descriptor in the list.

If the feature (_F_INDIRECT_DESC) has been negotiated, install only
one descriptor in the virtqueue.
Therefor the buffer id should be obtained from the first descriptor.

In descriptor chaining scenarios, the buffer id should be obtained
from the last descriptor.

Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")

Signed-off-by: Wafer <wafer@jaguarmicro.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20240510072753.26158-2-wafer@jaguarmicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 28cd406e16..3678ec2f88 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1745,6 +1745,11 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
                                              &indirect_desc_cache);
     } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
+    if (desc_cache != &indirect_desc_cache) {
+        /* Buffer ID is included in the last descriptor in the list. */
+        id = desc.id;
+    }
+
     /* Now copy what we have collected and mapped */
     elem = virtqueue_alloc_element(sz, out_num, in_num);
     for (i = 0; i < out_num; i++) {
-- 
MST


