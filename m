Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A53C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeAe-00024x-Hk; Tue, 02 Jul 2024 10:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAa-00023R-T6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAY-0007x4-JN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bf3inGfH3C1OrX/KdJFaqQvDHDePnfUDWhDjBaZ52tk=;
 b=O3j5J0v0vFSMiLulKM068Y8mV2J+86e5fbBWGJYnSwvIT+SvwfoZd9BVtJPNEb82PanvTr
 e3xtifQpMqxon1cx2bbaq2DCgkn/jef5fhNSeFHre+27qhez6FPf/Yd1hNQM7LmwKzv481
 qsADgfDWmU2hyeIrm4R+l+bPTQThueY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-MJ4QSHjUOX-fLj2B6pW1HA-1; Tue, 02 Jul 2024 10:07:35 -0400
X-MC-Unique: MJ4QSHjUOX-fLj2B6pW1HA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42567dbbd20so31657415e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929254; x=1720534054;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bf3inGfH3C1OrX/KdJFaqQvDHDePnfUDWhDjBaZ52tk=;
 b=InVJs3fBH8s/6B/1pDV58pE0QXgadSZRvJZsempkgwv9+x/jdTwu7GgNMP4r1Ra72C
 W/vM/Hspb8lot8yyD6+RlDDjL7rSt0+jpXCNJYILQ5rnVgp3x2u7KMdpFrPXRNfCpGDF
 e+BrjtezYR1zXruYjjV/DnhzzLtcY8PCCm7KAMNk3NUKJUTHf7Po5IPQ3iZpXWCujOpl
 BmnRwCctgk1AwWQxX8RG6W3TIAduGaB0SSAezIwwmf/5GlaJtBOLm2vzKEaH4VjqGt0X
 2h8T4Vz6nzd+ZfF6uLDNi322RgL3a9rzcraUdYjLjYkzrLYFYTFcAvbJIOm0+I4DOElX
 eMSg==
X-Gm-Message-State: AOJu0YwloPrTHdOIl9J2K7uUSU+dhX5QEN85z6vW7oAno3OSIiUkfShM
 SRhYT4r6caUxcqjZhk/g3IOUrFNYXlCIQVrqByB8nylKG46FosTTDOZMIEuUMrTyD02RsbeZRYf
 X7nL3cpAR5xHcHxaNv424A5hDshmJCZQp6EMsk//m6ceGPcn+mI5hixj62qrC+t8XbVjjsmsnQu
 bIYPX3JZpQgb/g/bLG/5P2UdiuUV03qQ==
X-Received: by 2002:a05:600c:4da1:b0:425:64c4:e016 with SMTP id
 5b1f17b1804b1-4257a0098c1mr58126755e9.12.1719929254050; 
 Tue, 02 Jul 2024 07:07:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgqgXXTAj0rm4CAIuShkn4R+gTJ9PgwVNThobgo59qdwLkqdpgk8+yeCqyuWs3dnNY5m1lFA==
X-Received: by 2002:a05:600c:4da1:b0:425:64c4:e016 with SMTP id
 5b1f17b1804b1-4257a0098c1mr58126515e9.12.1719929253494; 
 Tue, 02 Jul 2024 07:07:33 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55cccsm199945575e9.16.2024.07.02.07.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:07:32 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:07:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Wafer <wafer@jaguarmicro.com>,
 Jason Wang <jasowang@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 11/91] hw/virtio: Fix obtain the buffer id from the last
 descriptor
Message-ID: <33abfea239592a706e98269b01c0096249612ea4.1719929191.git.mst@redhat.com>
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


