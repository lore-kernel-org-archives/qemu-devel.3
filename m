Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A593C31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8iw-00029y-PC; Wed, 03 Jul 2024 18:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8is-00027s-Qp
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8iq-0000vn-8L
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QKgBtghpdntZCNxsubdg5dbN8fdbQsXq4OpajtHNP9c=;
 b=R2AzVgrgsoph+785N35kc7Cl/ErY29uW/0dIVROOH7cKkWZiheKyIMiqPTeyY00TwufC4r
 rqchoI6e1BK9jOBQ9vq3T3k5rs9kiRjvcuI1Tya8JMymLCkRV+VNBoQ4KD3kEZYoalLv5C
 k4N52QxWUovI42UAR8mK2fdZg/S0iiA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-bG9D81FqM9mKCv6JljQWVQ-1; Wed, 03 Jul 2024 18:45:06 -0400
X-MC-Unique: bG9D81FqM9mKCv6JljQWVQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ee848b2fedso11601011fa.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046704; x=1720651504;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKgBtghpdntZCNxsubdg5dbN8fdbQsXq4OpajtHNP9c=;
 b=OqBDaHFfWw1I0XSBC57kyBfcdUNA6iVZymjN5GNh2QwOu6s7ZGlBsxo8fY90HiuVEC
 d5hIIQXyoYBdh2yJWY68w9iDzvggzRSU0JsQbXWdF9otfk6C0b/JHWoLfYxWQmENcXJx
 0+AxuPxFxCM9fwzgNz88RJ6U9l4M8BllNF2dHhHSIqAkhg/FW3Ueg9o8sfHz77A1Gqyp
 JHzpdveqwfj9I4mkN7HoxQj93TWVW96Rg+wrABVTUxnLB5zU6fwSOJonPq0MgAqo2vjd
 H/4HKNzL/1DiFOHPmTdQ2D0B3tY1jHW+zQSygbzNmNrBZLE+jvfn8YaGa4UJmvKxxDgt
 BIRQ==
X-Gm-Message-State: AOJu0Yz2nsgJ+fh4Ib/dX1P6nmlxYgP11rzOMDmjkCkkMPIG15TlD/Yy
 E7b2yFXXJ6r7BStcms1bsxZ81tbV1bJi1lfLANMGph4buEbJ8nR37x7YFzVLRGkTi5n6zUULwal
 slwb3TyteiYXU7WA5ftlODjNrB60jEW+ovakg1rUSCYH8CjExWpgg+ISrABcdYcgSqY/97CaDmQ
 7xvouHk6S1cRwtOYJjqmCkAJkX46jCbw==
X-Received: by 2002:a05:6512:b8e:b0:52c:8210:13bc with SMTP id
 2adb3069b0e04-52e8273e3acmr8869018e87.64.1720046704454; 
 Wed, 03 Jul 2024 15:45:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE84nkf35ngiUNRT2yltt70Aw4yWlCZ3EPgIZZL/eHBTnkq2TYJtHXDUMYwCLHy4nGtnYI+bg==
X-Received: by 2002:a05:6512:b8e:b0:52c:8210:13bc with SMTP id
 2adb3069b0e04-52e8273e3acmr8869005e87.64.1720046703705; 
 Wed, 03 Jul 2024 15:45:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0651dfsm556055166b.142.2024.07.03.15.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:45:03 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:45:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PULL v3 10/85] vhost-vsock: add VIRTIO_F_RING_PACKED to feature_bits
Message-ID: <a0eebd790ca4f90fc1e3662cb38542ccc21963bf.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Halil Pasic <pasic@linux.ibm.com>

Not having VIRTIO_F_RING_PACKED in feature_bits[] is a problem when the
vhost-vsock device does not offer the feature bit VIRTIO_F_RING_PACKED
but the in QEMU device is configured to try to use the packed layout
(the virtio property "packed" is on).

As of today, the  Linux kernel vhost-vsock device does not support the
packed queue layout (as vhost does not support packed), and does not
offer VIRTIO_F_RING_PACKED. Thus when for example a vhost-vsock-ccw is
used with packed=on, VIRTIO_F_RING_PACKED ends up being negotiated,
despite the fact that the device does not actually support it, and
one gets to keep the pieces.

Fixes: 74b3e46630 ("virtio: add property to enable packed virtqueue")
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Message-Id: <20240429113334.2454197-1-pasic@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vsock-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index 12ea87d7a7..fd88df2560 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -22,6 +22,7 @@
 const int feature_bits[] = {
     VIRTIO_VSOCK_F_SEQPACKET,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_RING_PACKED,
     VHOST_INVALID_FEATURE_BIT
 };
 
-- 
MST


