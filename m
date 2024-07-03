Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60EDC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8j4-0002GV-3E; Wed, 03 Jul 2024 18:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8j2-0002AR-Fk
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8iy-0000yQ-KR
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bf3inGfH3C1OrX/KdJFaqQvDHDePnfUDWhDjBaZ52tk=;
 b=QfCY+A5I6haxeveELgfHaZX+/tJnGHaN2Cye38PiKhIHUw6Uf9dAk9yl9Z7Zb2Oj7TEsS3
 bWlpQ5P4aX8jctKNqxktQat5j3f0pxtyZNCFrVDIN468zq2Y/MpoB7yVQGFiWhR6s95Pxe
 r8Qw3PhmTsld+EIjHjZm2fEoEpDpg14=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-Al_VjRHoOiOpiEhHGFNO6A-1; Wed, 03 Jul 2024 18:45:10 -0400
X-MC-Unique: Al_VjRHoOiOpiEhHGFNO6A-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a725eed1cfeso1103966b.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046709; x=1720651509;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bf3inGfH3C1OrX/KdJFaqQvDHDePnfUDWhDjBaZ52tk=;
 b=AN2RbS/c6j1XeHWXj6UT7rW9woT9MXDAz+jjyNpi4LChwgMkTl0yp3HoKpC3cQN0rs
 X1ZS5ECGpBDYgKb1whn8KM7y9dL/dLaQIvEYwFiQT6bIV9fGvuuDNsZ70/BXbRD0wEw6
 brWHD1THLGbopYfBIxik8FVboTgnxB5aTHhmBXaQH5FGQSdGNwTKU0nxykXFsJw2T1F/
 rSd5rYZaHYmSG8sHl9K5NDE+UmQz3kEr7ywdm59F8NbR5xTbFtZxVMupxzEDSKbPmgxn
 9FJM5rjZ9U/ANTvm3GfgoUC8ekNYWJfHsEl08WSnx9q6H/ZDA77Ap1Og3LpehDq8UpOF
 Q2qQ==
X-Gm-Message-State: AOJu0YwmhuVgsfE/hiEZ/856cfzj6SO39zofU1Iv4Iu4w+LRl72mPDPy
 DlJs9+Nz7oNRcb59pEo6VR5gH6svcjrTygvejJmrkhGOlkqh31d0WcXEbTIiOhtsHtVBhvBg3+R
 QnT4w6OeEiX5+VbOwDwPCvHaNHGeed6XvpK/7N5LDo8MjCJ8niIeSQlVKz8Si/XCLYk3Kur96dL
 8MFrhnqzX0wZjg4TE1L0ObJ73hzENjvg==
X-Received: by 2002:a17:906:a854:b0:a72:b361:41df with SMTP id
 a640c23a62f3a-a75144a8a77mr743358366b.73.1720046709195; 
 Wed, 03 Jul 2024 15:45:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2HDThedYpbb99Ti4RJkj71FX4UuvnZi3mATmGLkUvACJLtWRqqto38n1iClVxJJHumt+ClA==
X-Received: by 2002:a17:906:a854:b0:a72:b361:41df with SMTP id
 a640c23a62f3a-a75144a8a77mr743356566b.73.1720046707995; 
 Wed, 03 Jul 2024 15:45:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0651f5sm547982366b.138.2024.07.03.15.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:45:07 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:45:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Wafer <wafer@jaguarmicro.com>,
 Jason Wang <jasowang@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL v3 11/85] hw/virtio: Fix obtain the buffer id from the last
 descriptor
Message-ID: <33abfea239592a706e98269b01c0096249612ea4.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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


