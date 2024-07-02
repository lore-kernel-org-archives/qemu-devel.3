Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788E2C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwI-0007Sx-Pc; Tue, 02 Jul 2024 16:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjux-0005nU-TO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjuw-00089u-6p
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bf3inGfH3C1OrX/KdJFaqQvDHDePnfUDWhDjBaZ52tk=;
 b=M7O+MS1jSNuDl2WHUT+abSkPRjJzNyWaMZHYQrfB2QSj3AsjpFc4E4LJFHt+8IhigMwvzL
 7Nkrzw31GNn8SdxE74CKyH2N3+xb0jhm/Is3WULoCdfcRHZDCrgRlUaUeukKMU2F63y9x2
 Y1GdSBEjfE5EfPYdiv967hptQ3z/O9A=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-eHB2cmKSOcqF8wSIIvKYLQ-1; Tue, 02 Jul 2024 16:15:56 -0400
X-MC-Unique: eHB2cmKSOcqF8wSIIvKYLQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52ce04ea31cso4981528e87.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951354; x=1720556154;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bf3inGfH3C1OrX/KdJFaqQvDHDePnfUDWhDjBaZ52tk=;
 b=BRspsVZCc+2zDkiSUXTC904DBdFkdnfCo0VNVI11+4AQ7/ug362Ars1tgJQDzCn7YX
 5yHsD4gVDOnNRtDQg8hFA5MejWFL/6A24yAod1+t8N8wC7Vzke5XICFGJit+3vVVXQpW
 xnhSF/i0fS+oxF1oncOWMR0+WmxWNFJ4OmCLXapuwqbC4TivJ+p/5yqYwgt3/P5VQjki
 +nk74mYSePgjL/dmsrtLLivla9nmBHlPuXItLBoWr3VPCVTykxGuahu5qyTqAbI2zzx8
 LOvov8T+JQ1BDPD869mB6lOase5UOq7HRBJo8BvnMZPijQayeSn7+oFYO1cbOu182ab/
 uDkw==
X-Gm-Message-State: AOJu0YzhALwBSQUHKgcZMew055XXRWmCfGtD9xWZqd/8Qitl6hBcRqF6
 63td5gNr6B4KcmfIG7cqWzC2z0B/dTHuAtBE+0x6SRE0QznW9EIMaI+QGM8pMbNwPqlYZvH+6oy
 acBYG/Ryay2On1ekmj8Pg3eHJt/4nHIC0efk3tDteAIn8Qbu5TLCBJthUiCx4QeGn7+dqJ/KmB1
 lB355Crj6ucVtZggxav1j2iLcLYtKYVg==
X-Received: by 2002:a05:6512:3ca9:b0:52e:765b:c00e with SMTP id
 2adb3069b0e04-52e8264c2femr6470295e87.7.1719951354496; 
 Tue, 02 Jul 2024 13:15:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp91x5VfntW+nGeizM8iVLQtgW8Pd0YhVe1U3xHTQ5oa1gOXS9/jLY8Y4tj2tMPxaoF4swrA==
X-Received: by 2002:a05:6512:3ca9:b0:52e:765b:c00e with SMTP id
 2adb3069b0e04-52e8264c2femr6470275e87.7.1719951353804; 
 Tue, 02 Jul 2024 13:15:53 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b098426sm208920815e9.32.2024.07.02.13.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:15:53 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:15:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Wafer <wafer@jaguarmicro.com>,
 Jason Wang <jasowang@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL v2 11/88] hw/virtio: Fix obtain the buffer id from the last
 descriptor
Message-ID: <33abfea239592a706e98269b01c0096249612ea4.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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


