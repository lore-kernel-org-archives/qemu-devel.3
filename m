Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE01CCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 13:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsMYb-00077W-Vr; Thu, 04 Apr 2024 08:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rsMYZ-00076U-A5
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rsMYX-0000q4-BZ
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712235059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3HFsGqiytSwxQzVUwJvwuSIHXOEKYRI7LxSSzH5h9bU=;
 b=T5IVQuQKTZsH6Y82BhJyLClGM1rMsguC9EBkSTbsSUai3C+6K5bapBlmYaqNPVcezE1JAe
 CaersBNRjeLynpK8cSvgHXfaZ0oKGWC2m3YxsVMlF4Tr0XGoGj9HmqMUnOucVK1VXgVkoY
 CiEM5rdbRdfMsWiO0TKre1meQ3orefg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-zdO3Jy9WP52Tq6AaY6RR0g-1; Thu, 04 Apr 2024 08:50:57 -0400
X-MC-Unique: zdO3Jy9WP52Tq6AaY6RR0g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-41489c04e3aso4997165e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 05:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712235056; x=1712839856;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HFsGqiytSwxQzVUwJvwuSIHXOEKYRI7LxSSzH5h9bU=;
 b=UI+dyQO7xghSGehu5NUvJCmHvUbXGV7VZlSKQHza9X5+hYo8CQ6Q4gS98+OJQApJhG
 Tyy4w8aEvoACb/GasFfQRm0nJpBnZ/8DRWrOHhLIsRnZZF1VFAEnMf8bfqpRmfQ9PXSz
 +SBLmfOBMm+b9OtynDkCftNM2FayBu3K2D/EZZDqooyK/GnZ1YWouVFxpEeQc/6mpq4j
 y6UKnSckV33eWi9KKFogWJe+GQEMAU3gAfkipHQR/2oN/2nki3kby6XDKx/cqdHE1VBs
 2lShk0tjl/tBIHicpuw6szvH92CgvzKyvCca0xam6PUF8TvhIPEuoxj9xP/v5l4k5XFU
 6mpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBwRw1lzYvXMHxFMWvR14VmvzQ0wTY/OTWUxpm3iBCBIDRhORaf+z73bNbOIMy2WnxawhYf4/rsKGBkvZvfcnSjHNAuBY=
X-Gm-Message-State: AOJu0YwhOEM+Fwm/q8vNvoxuuk7nxmiqrn3Gefd9X5wtc8kO0W/UNiqS
 hGbHpdlD6GsHYum5XQN8NeVTuKJ3FiPLZ1turB9q5YmO8/X/dA71ZNCrC1vrFgv+FjdHktIP1c8
 EDH4VT8mKi0FvK3odtcQGNx4xjIKwRiXFRv3BjZFfbSp+PKSyI8D5
X-Received: by 2002:a05:600c:3b08:b0:416:2b3c:2861 with SMTP id
 m8-20020a05600c3b0800b004162b3c2861mr983501wms.30.1712235056271; 
 Thu, 04 Apr 2024 05:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVWNLlKZvSJT3oSIONPdIkYMs/vSjaqlTfdieghahmPNOagSxs9VsKl0fk+nZEuYqgmt6vOQ==
X-Received: by 2002:a05:600c:3b08:b0:416:2b3c:2861 with SMTP id
 m8-20020a05600c3b0800b004162b3c2861mr983479wms.30.1712235055638; 
 Thu, 04 Apr 2024 05:50:55 -0700 (PDT)
Received: from redhat.com ([206.84.25.133]) by smtp.gmail.com with ESMTPSA id
 bx6-20020a5d5b06000000b00341e67a7a90sm20402929wrb.19.2024.04.04.05.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 05:50:55 -0700 (PDT)
Date: Thu, 4 Apr 2024 08:50:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: Eric Auger <eric.auger@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio-iommu: Do not process commands with bad size
Message-ID: <20240404084840-mutt-send-email-mst@kernel.org>
References: <20240404124505.2108743-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404124505.2108743-1-zheyuma97@gmail.com>
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

On Thu, Apr 04, 2024 at 02:45:05PM +0200, Zheyu Ma wrote:
> The device should not handle the commands which have bad request/reply
> size, it should just report the error instead of raising an assertation.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

I do not get what problem you are trying to solve here.
Can guest trigger this assert? I do not see how.


> ---
>  hw/virtio/virtio-iommu.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 1326c6ec41..3a7cdfe777 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -770,8 +770,8 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>              return;
>          }
>  
> -        if (iov_size(elem->in_sg, elem->in_num) < sizeof(tail) ||
> -            iov_size(elem->out_sg, elem->out_num) < sizeof(head)) {
> +        if (iov_size(elem->in_sg, elem->in_num) != sizeof(tail) ||
> +            iov_size(elem->out_sg, elem->out_num) != sizeof(head)) {
>              virtio_error(vdev, "virtio-iommu bad head/tail size");
>              virtqueue_detach_element(vq, elem, 0);
>              g_free(elem);
> @@ -818,8 +818,6 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>  out:
>          sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
>                            buf ? buf : &tail, output_size);
> -        assert(sz == output_size);
> -
>          virtqueue_push(vq, elem, sz);
>          virtio_notify(vdev, vq);
>          g_free(elem);
> @@ -852,7 +850,7 @@ static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t reason,
>          return;
>      }
>  
> -    if (iov_size(elem->in_sg, elem->in_num) < sizeof(fault)) {
> +    if (iov_size(elem->in_sg, elem->in_num) != sizeof(fault)) {
>          virtio_error(vdev, "error buffer of wrong size");
>          virtqueue_detach_element(vq, elem, 0);
>          g_free(elem);
> @@ -861,8 +859,6 @@ static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t reason,
>  
>      sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
>                        &fault, sizeof(fault));
> -    assert(sz == sizeof(fault));
> -
>      trace_virtio_iommu_report_fault(reason, flags, endpoint, address);
>      virtqueue_push(vq, elem, sz);
>      virtio_notify(vdev, vq);
> -- 
> 2.34.1


