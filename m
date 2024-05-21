Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC90C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OpN-0000Ht-Rb; Tue, 21 May 2024 08:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OpG-0000Gq-U8
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OpF-0003hi-Dl
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716295358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L3wk4Ge2vHAUcPnEHToCfPAbDKQlZDEciher1P6dIa8=;
 b=E+/q0xuDoIr/o3HYnsoDJ5nYJwM/QfFHrelx6ej1wv02a+p04lPHN9ohK1+PGJx0fJZq6U
 2VKjvdRzC5armIAYY8VEyJPtQbwu4g7N0Sit6ZN8v5Yan9s+v7SGFgWRwTa0MOAy2ifUGL
 IySKse0SGKdVN84FtmZwyeJb73HugUM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-zRzGj9_gP8e5yZlHkG6MeQ-1; Tue, 21 May 2024 08:42:36 -0400
X-MC-Unique: zRzGj9_gP8e5yZlHkG6MeQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a592c35ac06so1253772366b.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716295355; x=1716900155;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L3wk4Ge2vHAUcPnEHToCfPAbDKQlZDEciher1P6dIa8=;
 b=gZeH4gOXTcrm0X53iyfVgBR2cicnNghNaiFe+esr20T4zEYmX7w6bEmG3fk+JbjRd6
 6rU8VeFVmPnr2sRqTLyXSAa7sYJ7zV7Y+P+XPtCqXi7nieTMh9HpKBMyPD5uo5RksgiL
 YVArECIAwq74ztSzb5rw7v5i3cB+7hLFRrctOo50J8rP6DneeZsyujk4dAZ4mQEuw95o
 sonPPIPvs1OV4bVZndn1sDnOefzJAEfyGl8HIjMRf7h8LZRTnGlxVNefAeR2vPibakdH
 89pCwuKe6eOqR4FrOXDVR9p8PzWQP0+M85Qft2cKf+ecGgcz/OIQfBpGX0SVfMCAOEjZ
 +NFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGMwCkztsT55BngrkYeDZUb1scPjMOtRxp8OblfCjHOVrf9pnus8ZcDLSGaYtnegPsApZ0q1Ge4eZK3iNQlpqC5oEEpGE=
X-Gm-Message-State: AOJu0YzoCgDIGKKkx2y4YUJ3nFQdHxEcqRZSHxwhAiQ9sVclDzICyeiV
 EZMzZ9BBIAXW6S/hE4E1rd6jwQys1uFYv3EpZE7X2OHhlKLbSK8DGqYspzhlBF4GWNpG13+rk29
 dYT1Yw4YQ84Uu9Tjuc5OlvKT7jsAljXB3gp1xzELTW0RaIAVKBQ+E
X-Received: by 2002:a17:906:4944:b0:a59:dba0:1544 with SMTP id
 a640c23a62f3a-a5d5cb0468cmr758617366b.31.1716295355593; 
 Tue, 21 May 2024 05:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjcixdzWIa0MjkGQzlLX+H2dFCxHjF9cBfKQ1hUOzrzd/SU4ycFkWbbxgD0sdMh+FQ5ckOjw==
X-Received: by 2002:a17:906:4944:b0:a59:dba0:1544 with SMTP id
 a640c23a62f3a-a5d5cb0468cmr758615866b.31.1716295355244; 
 Tue, 21 May 2024 05:42:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7da8sm1616438366b.99.2024.05.21.05.42.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:42:34 -0700 (PDT)
Message-ID: <9f14fdb8-e8ae-4588-a752-6ec1ae301319@redhat.com>
Date: Tue, 21 May 2024 14:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] vfio/pci: Make vfio_intx_enable() return bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-12-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 5/15/24 10:20, Zhenzhong Duan wrote:
> This is to follow the coding standand in qapi/error.h to return bool
> for bool-valued functions.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c091d21adf..e2ca4507f8 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -261,7 +261,7 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
>       vfio_intx_update(vdev, &vdev->intx.route);
>   }
>   
> -static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
> +static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>   {
>       uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
>       Error *err = NULL;
> @@ -270,7 +270,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>   
>   
>       if (!pin) {
> -        return 0;
> +        return true;
>       }
>   
>       vfio_disable_interrupts(vdev);
> @@ -292,7 +292,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>       ret = event_notifier_init(&vdev->intx.interrupt, 0);
>       if (ret) {
>           error_setg_errno(errp, -ret, "event_notifier_init failed");
> -        return ret;
> +        return false;
>       }
>       fd = event_notifier_get_fd(&vdev->intx.interrupt);
>       qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
> @@ -301,7 +301,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
>           event_notifier_cleanup(&vdev->intx.interrupt);
> -        return -errno;
> +        return false;
>       }
>   
>       if (!vfio_intx_enable_kvm(vdev, &err)) {
> @@ -311,7 +311,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>       vdev->interrupt = VFIO_INT_INTx;
>   
>       trace_vfio_intx_enable(vdev->vbasedev.name);
> -    return 0;
> +    return true;
>   }
>   
>   static void vfio_intx_disable(VFIOPCIDevice *vdev)
> @@ -836,8 +836,7 @@ static void vfio_msix_disable(VFIOPCIDevice *vdev)
>       vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
>   
>       vfio_msi_disable_common(vdev);
> -    vfio_intx_enable(vdev, &err);
> -    if (err) {
> +    if (!vfio_intx_enable(vdev, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>       }
>   
> @@ -2450,8 +2449,7 @@ void vfio_pci_post_reset(VFIOPCIDevice *vdev)
>       Error *err = NULL;
>       int nr;
>   
> -    vfio_intx_enable(vdev, &err);
> -    if (err) {
> +    if (!vfio_intx_enable(vdev, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>       }
>   
> @@ -3197,8 +3195,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>                                                vfio_intx_routing_notifier);
>           vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
>           kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
> -        ret = vfio_intx_enable(vdev, errp);
> -        if (ret) {
> +        if (!vfio_intx_enable(vdev, errp)) {
>               goto out_deregister;
>           }
>       }


