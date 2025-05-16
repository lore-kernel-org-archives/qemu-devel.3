Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE01C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 15:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFwy5-00035F-QV; Fri, 16 May 2025 11:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFwy2-0002s3-Jr
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:27:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFwxz-00079g-OV
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747409239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mcYrF6oHh4HHPCeklc+93BMzo7/8MknrgNFM8uUGfRg=;
 b=VZGGvRpwTxM4JCD/Luz1wStU6BvPWrtmMPb8qIGrHM0pCF54JwPm6xZmv+b7C9IuHlR50b
 xSrO/bWyp5+ovjyUHVh+uHM3teb0m6Wj39p2zAHYQHs6FWoIzVBbnrNKa71iueEyhJl0bJ
 ea09rMfYe1CL5k2bW80SOjVH4nDnWLQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462--UM0y-xaPvqyvmtd6fpx4w-1; Fri, 16 May 2025 11:27:15 -0400
X-MC-Unique: -UM0y-xaPvqyvmtd6fpx4w-1
X-Mimecast-MFC-AGG-ID: -UM0y-xaPvqyvmtd6fpx4w_1747409234
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43e9a3d2977so16795465e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 08:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747409234; x=1748014034;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mcYrF6oHh4HHPCeklc+93BMzo7/8MknrgNFM8uUGfRg=;
 b=tPnUI4qRCJJxKfHnBGaaeahFkD1M2TH8myLHIsIk34elcWWTRU/d/Bm/5LdCS0nOll
 qRwkDZCMaRgUB6InpSrKlnudT1jyMmZVV/6IIwR0ssaUg3Ges86cuGtdjBMGORRQIMID
 iC9Gl03RW8FZwN2Ovu/MZAY1Ye33fJ9h8vE9j/A2Uq71BS5HOfQ1oClVEOaz8bGotJCM
 Z3ZHHihWprQgy8uz1oBJfBdcNe5CXFqWlMb2Cs2DFGTTcSW8az/EShNaBzojYJhBGGBq
 1d9MjbGtcApycw05kUprkn9f0MuLBa2LMQVaQY1MX14zxUc+HCH/wCPPH5kbQlGLpqTC
 HjSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjhRVy6FlSx5n/2u0qX5cRRJ8y2snhLjk9zud+j15k6MunHCDBpGTCNzjBNxTfmwSPfyyd8p71RszO@nongnu.org
X-Gm-Message-State: AOJu0YxtS4rmWi0pTdpdcIaqk0+oDitjGy8uS5Fm0EYROeYFulq4Ayth
 rF7smix2S24L//iPe6u0WJPZHssxLGGqgKCN1pmhtApOLhwpTTnRtMFoaO4OiM5XIwtTizq0k8e
 qYVab1hW4m2O7Gwti6SeZwG8Y3PUEB6L/wIrrOZJQvhHAjSOCnVWvzlSh
X-Gm-Gg: ASbGncsC8ID9w6SdZpTS3yYX4SKC6HoF3QPoexKUtnsjZJ877PN4BepWWOJYkG6JBZx
 RaTEhUnt2w/hHYFZeDN2rM6s/odQxYF+TaGXByHILP3vv3m2OH/7c7AunVWga1hsNxymOktSWt1
 RkAn7rKTNdkByzW/USQ/cU0tG1pQtqdoQdpPqUhwI+ahUGxy9B46Nj8ct/njpfTj/f6YpXXbodc
 pfnVAFMuGRbXs55PaFhr5gM4fmmaohynzsME9vYDZJMzz/W2lvNF9kQBPpKUFVYRIW3NzAXXf4K
 ZzQZVtjrazWPqX8XxGswJPlEA4R8amMuGDnjtZAFAe5aaaQ=
X-Received: by 2002:a05:600c:5305:b0:441:b19c:96fe with SMTP id
 5b1f17b1804b1-442fd622eb4mr49057335e9.10.1747409234488; 
 Fri, 16 May 2025 08:27:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVRLJorTjpA6iU4Fd4bC403ABplh8VIH0S6duInoNN76CcHBs3UPLDc5qMm2VqkNZSIcKdmg==
X-Received: by 2002:a05:600c:5305:b0:441:b19c:96fe with SMTP id
 5b1f17b1804b1-442fd622eb4mr49057055e9.10.1747409234022; 
 Fri, 16 May 2025 08:27:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39ef8bbsm112495485e9.37.2025.05.16.08.27.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 08:27:13 -0700 (PDT)
Message-ID: <6f9f081e-f251-49b5-a7d2-484cd8e03b48@redhat.com>
Date: Fri, 16 May 2025 17:27:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/27] vfio: refactor out IRQ signalling setup
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250515154413.210315-1-john.levon@nutanix.com>
 <20250515154413.210315-6-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250515154413.210315-6-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On 5/15/25 17:43, John Levon wrote:
> This makes for a slightly more readable vfio_msix_vector_do_use()
> implementation, and we will rely on this shortly.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 35 ++++++++++++++++++++---------------
>   1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 7912c17dd2..9dd0bd4068 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -511,6 +511,25 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
>       kvm_irqchip_commit_routes(kvm_state);
>   }
>   
> +static void set_irq_signalling(VFIODevice *vbasedev, VFIOMSIVector *vector,
> +                               unsigned int nr)
> +{
> +    Error *err = NULL;
> +    int32_t fd;
> +
> +    if (vector->virq >= 0) {
> +        fd = event_notifier_get_fd(&vector->kvm_interrupt);
> +    } else {
> +        fd = event_notifier_get_fd(&vector->interrupt);
> +    }
> +
> +    if (!vfio_device_irq_set_signaling(vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
> +                                       VFIO_IRQ_SET_ACTION_TRIGGER,
> +                                       fd, &err)) {
> +        error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
> +    }
> +}
> +
>   static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>                                      MSIMessage *msg, IOHandler *handler)
>   {
> @@ -583,21 +602,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>                                strerror(-ret));
>               }
>           } else {
> -            Error *err = NULL;
> -            int32_t fd;
> -
> -            if (vector->virq >= 0) {
> -                fd = event_notifier_get_fd(&vector->kvm_interrupt);
> -            } else {
> -                fd = event_notifier_get_fd(&vector->interrupt);
> -            }
> -
> -            if (!vfio_device_irq_set_signaling(&vdev->vbasedev,
> -                                        VFIO_PCI_MSIX_IRQ_INDEX, nr,
> -                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd,
> -                                        &err)) {
> -                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> -            }
> +            set_irq_signalling(&vdev->vbasedev, vector, nr);
>           }
>       }
>   


