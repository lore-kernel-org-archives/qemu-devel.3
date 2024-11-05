Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E3FD1267D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8H7o-0008NM-FA; Tue, 05 Nov 2024 05:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t8H7m-0008N6-Os
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:49:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t8H7k-0003pD-PR
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730803762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4+4OB7OGr4Sq5YRiLnEzRUjoN8MGPCtDFQ1TAOcRuXM=;
 b=dUCmyOnkzH/TQl/weYXPxe/gKj/PLlKTpZWxFUIKZD43kMkfN7Aoi+T83XaDqRxVWND1t0
 /D64CzEy18+nXdRpN5phqYU//pcMXGzVyh8FiDdYJlgvsNU+7zV9EOggaaiexSwlpA8bv/
 PrJK9a5ROBTASXRifWuXuRiA9GjaLqc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-qucWcuetOBCBLAOFzAJv2A-1; Tue, 05 Nov 2024 05:49:21 -0500
X-MC-Unique: qucWcuetOBCBLAOFzAJv2A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4316e350d6aso35007245e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 02:49:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730803759; x=1731408559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+4OB7OGr4Sq5YRiLnEzRUjoN8MGPCtDFQ1TAOcRuXM=;
 b=Ye5djP0fOavf8H8uvnd5wmQN8KZ9RIHHvgrcccaX2eIov0HEfikFmUBuYXCHUlix94
 +bheYC+9FWoq2gT9Znh3a+JmT2hLMqCJuHQyCd16PF73DFMvaRb0cfpSxbycFKXq3Zja
 on1tzESvL2GXldl0000UlfcjZvmqIsKPMj0w7zAoj9I8oLGorWwkdyPLJHsHhl/ZksYX
 VOSaOSGcc+DV+OXuOI44yxFWiG5UHxmqomFWqbZLbamcNRHzKXGd/9cXKQ1S4fMHrcIK
 2JarLlRx5X5mhTzRtfBCfuIZiezu5kD5cZ5CPO5k3mhbygr04FChsVe/vPP+S55Lb6QN
 LsRQ==
X-Gm-Message-State: AOJu0Yyn0HP181FWl/+I3J2+mK+abIU5D1PMjm8D896YGuMuOxDmuNVV
 DBxYdlCHQv6/+ETZH/xA3xKZGs8xDED6Xd3dnOAY7qt7JwJMrLcI58Unqq8noeIdRWXTaK6/XgH
 fMx6WRG3w/Nu6SY4Ifni0jtoTwM3FSJP44oGLLTNM7uh0rRbUVs3Yb226TGK8
X-Received: by 2002:a05:600c:5492:b0:431:251a:9dc9 with SMTP id
 5b1f17b1804b1-4328328481dmr139689835e9.25.1730803759456; 
 Tue, 05 Nov 2024 02:49:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6SqQ34kGyI7r+EY9zmIgZuinnwDDPg3P5fE0JezohVI7dVNfCrpugApANLuvGolAlHBsZKw==
X-Received: by 2002:a05:600c:5492:b0:431:251a:9dc9 with SMTP id
 5b1f17b1804b1-4328328481dmr139689495e9.25.1730803758851; 
 Tue, 05 Nov 2024 02:49:18 -0800 (PST)
Received: from sgarzare-redhat ([134.0.5.207])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd917f0bsm209068845e9.17.2024.11.05.02.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 02:49:18 -0800 (PST)
Date: Tue, 5 Nov 2024 11:49:12 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] vhost: fail device start if iotlb update fails
Message-ID: <a664pk3wefui7tyvs6rjln2tm2fxwir6yvshffwkjypksechjj@3amhddyqxwiz>
References: <20241105060053.61973-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241105060053.61973-1-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 05, 2024 at 11:30:53AM +0530, Prasad Pandit wrote:
>From: Prasad Pandit <pjp@fedoraproject.org>
>
>While starting a vhost device, updating iotlb entries
>via 'vhost_device_iotlb_miss' may return an error.
>
>  qemu-kvm: vhost_device_iotlb_miss:
>    700871,700871: Fail to update device iotlb
>
>Fail device start when such an error occurs.
>
>Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
>---
> hw/virtio/vhost.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>Note:
> - Earlier this patch was submitted as part of a series to fix vhost device
>   related issue. It remained unreviewed, because the other patch in that
>   series did not fix the issue entirely.
>
> - The error fixed in this patch is fairly independent of the other issue.
>   It can be reviewed as is, without waiting for the other patch in that
>   series. Not sure when the other patch will be revised again.
>   So sending this one alone, instead of holding it back.
>
>* https://lore.kernel.org/qemu-devel/20240808095147.291626-2-ppandit@redhat.com/
>* https://lore.kernel.org/qemu-devel/20240711131424.181615-3-ppandit@redhat.com/
>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 06fc71746e..a70b7422b5 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -2151,7 +2151,11 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>          * vhost-kernel code requires for this.*/
>         for (i = 0; i < hdev->nvqs; ++i) {
>             struct vhost_virtqueue *vq = hdev->vqs + i;
>-            vhost_device_iotlb_miss(hdev, vq->used_phys, true);
>+            r = vhost_device_iotlb_miss(hdev, vq->used_phys, true);
>+            if (r) {
>+                VHOST_OPS_DEBUG(r, "vhost_device_iotlb_miss failed");

VHOST_OPS_DEBUG() is usually used in the error path when calling a
`dev->vhost_ops` callback. In addition vhost_device_iotlb_miss() is
already reporting error through error_report() in the error path, so I
think we can remove this line.

>+                goto fail_start;

Should we add a new label in the error path and call
`hdev->vhost_ops->vhost_dev_start` with `false`?

Maybe we need to call also `hdev->vhost_ops->vhost_set_iotlb_callback`
with `false`.

Thanks,
Stefano

>+            }
>         }
>     }
>     vhost_start_config_intr(hdev);
>--
>2.47.0
>


