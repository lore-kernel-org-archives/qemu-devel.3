Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E57C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 07:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2mek-00028K-PT; Thu, 10 Apr 2025 03:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u2mej-000282-Id
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 03:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u2meh-0005Ui-Ml
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 03:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744271338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RHHLMcejXh0BkxISROtMPsAYzslFIfFWOjQfC3ZAXo=;
 b=evfjaTjy6bUmkccmku5Jmwq2Rha0Eyr5EvgfCVomy9G2RPlT1zybpKiXxrHPgz8o1KpaMx
 BYVExFiJb+J7lN2Mn8UaP13Mk7VUSYzEfQwNI58lLBOWn5uWy6IELbDLy14AlhPeO4WlWV
 d9UYZSceG0w7ykA2/84NJGYVr7jup4A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-SEhK-m6KPXO5c7VEBolHyw-1; Thu, 10 Apr 2025 03:48:55 -0400
X-MC-Unique: SEhK-m6KPXO5c7VEBolHyw-1
X-Mimecast-MFC-AGG-ID: SEhK-m6KPXO5c7VEBolHyw_1744271335
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d733063cdso4609185e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 00:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744271334; x=1744876134;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RHHLMcejXh0BkxISROtMPsAYzslFIfFWOjQfC3ZAXo=;
 b=RKRhVlbdd1uqxgZkHlAAh1bzH4OIOqR/Qnp5kkC9vlbSHmVNyKANOrJcYxBpFpGK/n
 qmBikWOGDkbxQtkm44xI+RLIIvwiDp9sPTR8sV0ZKyRhNayyU5JEwYeX3XRac2d4flTa
 cFLB3sHrD0ieqeU6awNfnBn309tPjNNFvKDyNE3I092SDyFmpOScKzTVZMklnClsF6sf
 Y56ic9bM49QVhNcLtAw8ppl+LbMWT4qr0BXeHl3PW4gp9vS11hKjagk6zCDIAYPoYJ/M
 6Pl8V3zJmSF66Dj4/kHTW9ywUNPHhGEkJ23osAduzVvubKXGeaCYASeUP83oTQbNlNOA
 cEsQ==
X-Gm-Message-State: AOJu0Yy95APKZtGd0YL2pPoowNs/jLXlJqzZ5YB67yW+JtSN4kGdsKw7
 qLa0jwa4UOgcUTsSVaMUCmzBwZHazw45UxD/E0KfDZ/Qfj0SZarTyFp8eWPP0hxwIbkUqQmiT72
 T0InBnRJD+qh6wbeieTY1TICckgZjBw4N9H/5HnUCXcEDDAd2o1ARVkVZlHZI
X-Gm-Gg: ASbGncu5OyLJ30aFwyAHXiOfSSB1rYPqr6Y4sSf+Wz1uSCVVHdLAXe/BbPFXH6eXLL5
 S45eYh5A5ScddJOq9uGApG3WFAlAfA10/DqVX2jJXRSF7li7iZ2Kka/Wkz/OmlikEjRHpAjynKb
 /ElMPPP0YqhxwgZCTAwLmz6Pw8M2oq/zm92QhcFtsbmZ19l2UP2NwW7w0ERlkgQhRBG/tKmQWpb
 L1s3aBNszRNJc7N4ubp4ZRdvbHRdRzlQpk8qwW8yaUL26hK0y+1NcVh254t8zk6KK+FGC8N7GW5
 RYUWyg==
X-Received: by 2002:a05:600c:5114:b0:43d:7bfa:2739 with SMTP id
 5b1f17b1804b1-43f2d952382mr15677125e9.23.1744271333974; 
 Thu, 10 Apr 2025 00:48:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG86w9TLAcUJPw0lMLUS5O5Ur4AhRHXOWME8t3xpqllS0kIGrlkUkj5FTY9VVsg/ehTyU+Gow==
X-Received: by 2002:a05:600c:5114:b0:43d:7bfa:2739 with SMTP id
 5b1f17b1804b1-43f2d952382mr15676995e9.23.1744271333598; 
 Thu, 10 Apr 2025 00:48:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2066d109sm46166975e9.20.2025.04.10.00.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 00:48:52 -0700 (PDT)
Date: Thu, 10 Apr 2025 03:48:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, qemu-stable@nongnu.org
Subject: Re: [PATCH] virtio: Call set_features during reset
Message-ID: <20250410034550-mutt-send-email-mst@kernel.org>
References: <20250410-reset-v1-1-751cd0064395@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-reset-v1-1-751cd0064395@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 10, 2025 at 04:42:06PM +0900, Akihiko Odaki wrote:
> virtio-net expects set_features() will be called when the feature set
> used by the guest changes to update the number of virtqueues. Call it
> during reset as reset clears all features and the queues added for
> VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS will need to be removed.
> 
> Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support multiqueue")
> Buglink: https://issues.redhat.com/browse/RHEL-73842
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

The issue seems specific to virtio net: rset is reset,
it is distict from set features.
Why not just call the necessary functionality from virtio_net_reset?


> ---
>  hw/virtio/virtio.c | 86 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 85110bce3744..033e87cdd3b9 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2316,49 +2316,6 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
>      }
>  }
>  
> -void virtio_reset(void *opaque)
> -{
> -    VirtIODevice *vdev = opaque;
> -    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
> -    int i;
> -
> -    virtio_set_status(vdev, 0);
> -    if (current_cpu) {
> -        /* Guest initiated reset */
> -        vdev->device_endian = virtio_current_cpu_endian();
> -    } else {
> -        /* System reset */
> -        vdev->device_endian = virtio_default_endian();
> -    }
> -
> -    if (k->get_vhost) {
> -        struct vhost_dev *hdev = k->get_vhost(vdev);
> -        /* Only reset when vhost back-end is connected */
> -        if (hdev && hdev->vhost_ops) {
> -            vhost_reset_device(hdev);
> -        }
> -    }
> -
> -    if (k->reset) {
> -        k->reset(vdev);
> -    }
> -
> -    vdev->start_on_kick = false;
> -    vdev->started = false;
> -    vdev->broken = false;
> -    vdev->guest_features = 0;
> -    vdev->queue_sel = 0;
> -    vdev->status = 0;
> -    vdev->disabled = false;
> -    qatomic_set(&vdev->isr, 0);
> -    vdev->config_vector = VIRTIO_NO_VECTOR;
> -    virtio_notify_vector(vdev, vdev->config_vector);
> -
> -    for(i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> -        __virtio_queue_reset(vdev, i);
> -    }
> -}
> -
>  void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
>  {
>      if (!vdev->vq[n].vring.num) {
> @@ -3169,6 +3126,49 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>      return ret;
>  }
>  
> +void virtio_reset(void *opaque)
> +{
> +    VirtIODevice *vdev = opaque;
> +    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
> +    int i;
> +
> +    virtio_set_status(vdev, 0);
> +    if (current_cpu) {
> +        /* Guest initiated reset */
> +        vdev->device_endian = virtio_current_cpu_endian();
> +    } else {
> +        /* System reset */
> +        vdev->device_endian = virtio_default_endian();
> +    }
> +
> +    if (k->get_vhost) {
> +        struct vhost_dev *hdev = k->get_vhost(vdev);
> +        /* Only reset when vhost back-end is connected */
> +        if (hdev && hdev->vhost_ops) {
> +            vhost_reset_device(hdev);
> +        }
> +    }
> +
> +    if (k->reset) {
> +        k->reset(vdev);
> +    }
> +
> +    vdev->start_on_kick = false;
> +    vdev->started = false;
> +    vdev->broken = false;
> +    virtio_set_features_nocheck(vdev, 0);
> +    vdev->queue_sel = 0;
> +    vdev->status = 0;
> +    vdev->disabled = false;
> +    qatomic_set(&vdev->isr, 0);
> +    vdev->config_vector = VIRTIO_NO_VECTOR;
> +    virtio_notify_vector(vdev, vdev->config_vector);
> +
> +    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> +        __virtio_queue_reset(vdev, i);
> +    }
> +}
> +
>  static void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
>                                                             Error **errp)
>  {
> 
> ---
> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
> change-id: 20250406-reset-5ed5248ee3c1
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


