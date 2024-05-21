Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5325CC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OXz-0006jP-7M; Tue, 21 May 2024 08:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OXt-0006dd-VL
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OXo-0000FO-Ps
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716294280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N77yf6YEdOOh8Puc7T/cgckLsY5M+cwCbWOa91OOipc=;
 b=bM0dRLQyPyw+5zPzXV7IQZxjaEAOIt1ahePExBw/kStJNgNFt9RbGW0um/pgoYlCTltDHi
 y9DlQZ62ZLgZLZsOMDSsycgGOhWWwv7hM89h9//wg4ldgmERNkz9uT7PnX529aaczk4r4S
 Y724HsBfZn04t2X+MbzJbfziAXsOwOY=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-VwJ3iWhLO3ykYX26Ue6Xpw-1; Tue, 21 May 2024 08:24:35 -0400
X-MC-Unique: VwJ3iWhLO3ykYX26Ue6Xpw-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c61300a19dso10716287b6e.1
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716294275; x=1716899075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N77yf6YEdOOh8Puc7T/cgckLsY5M+cwCbWOa91OOipc=;
 b=QCymQwcUMCcWKIhHZ6RtWG2jo+CAi7WzmvbUmpQkkV2k/9jXjimNzODrgq/J4KxcET
 MUsZ5Kwo9ULpfjzF+jPAG1FrtMiDq6TGVm0+LD5/5GPm0Y05LF/RtOJVrkOMd037PjpN
 COhnPQz7k7WPVnI+hfA2tOCAKZHwV/YHsTW7HROuCY9Rs8dkBZdqRAIbi84QSxo231xs
 fTBHUVa6iOKTzLTeTuU9PIHpWvNgBa4Ptrn326ixT1ivGSxw2d15sA/i5ygQouyos8ia
 iAWlZ+m+V93U+2+ZIXUmmZXFcl803gnahP9+fciaXNbQT34bz7NUodlrG3PCaADRnVp+
 jUqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv1pW1efQUY4GNmENLVHrIP1bQHmKwYe15u+hfq0SJ/cJF2CgjlZtGdf6U/XsjifNYrW9/evm08+OCJOklTIMmnoeFvmU=
X-Gm-Message-State: AOJu0Yw/+ZZtGU7mTNCjDvffrbgbeHkPFML8L4wOPB1D4a19vcI/i9f1
 6vi3pJmjFxg9+FArCBkkDOzbAgbFcLZgDSG5hJxxmsdq0AZJiHNnTknRVKzFMLbuttbaf6omZiD
 DLnioCrozdlmtFeVr1a75xLiH4Qn1+P4ROa6187HjPsUDXflP1lZI
X-Received: by 2002:a05:6808:2186:b0:3c9:9598:c745 with SMTP id
 5614622812f47-3c997067e35mr47028137b6e.25.1716294274708; 
 Tue, 21 May 2024 05:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0Mc7Pmrfy2Y+nBuMMbKaJM0PxNUG/P8J4E4Z7efSzQK4BEEgeMe+2bTE8PlhEN9faxQ2a2Q==
X-Received: by 2002:a05:6808:2186:b0:3c9:9598:c745 with SMTP id
 5614622812f47-3c997067e35mr47028111b6e.25.1716294274395; 
 Tue, 21 May 2024 05:24:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792f69833b2sm687694785a.46.2024.05.21.05.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:24:33 -0700 (PDT)
Message-ID: <84ab2eec-63f7-49f9-b98c-be0b5a649d4b@redhat.com>
Date: Tue, 21 May 2024 14:24:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] vfio/helpers: Make vfio_set_irq_signaling() return
 bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com, 
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-5-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
>   include/hw/vfio/vfio-common.h |  4 ++--
>   hw/vfio/ap.c                  |  8 +++----
>   hw/vfio/ccw.c                 |  8 +++----
>   hw/vfio/helpers.c             | 18 ++++++----------
>   hw/vfio/pci.c                 | 40 ++++++++++++++++++-----------------
>   hw/vfio/platform.c            | 18 +++++++---------
>   6 files changed, 46 insertions(+), 50 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 2d8da32df4..fdce13f0f2 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -207,8 +207,8 @@ void vfio_spapr_container_deinit(VFIOContainer *container);
>   void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>   void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
>   void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
> -int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
> -                           int action, int fd, Error **errp);
> +bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
> +                            int action, int fd, Error **errp);
>   void vfio_region_write(void *opaque, hwaddr addr,
>                              uint64_t data, unsigned size);
>   uint64_t vfio_region_read(void *opaque,
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index ba653ef70f..d8a9615fee 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -117,8 +117,8 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>       fd = event_notifier_get_fd(notifier);
>       qemu_set_fd_handler(fd, fd_read, NULL, vapdev);
>   
> -    if (vfio_set_irq_signaling(vdev, irq, 0, VFIO_IRQ_SET_ACTION_TRIGGER, fd,
> -                               errp)) {
> +    if (!vfio_set_irq_signaling(vdev, irq, 0, VFIO_IRQ_SET_ACTION_TRIGGER, fd,
> +                                errp)) {
>           qemu_set_fd_handler(fd, NULL, NULL, vapdev);
>           event_notifier_cleanup(notifier);
>       }
> @@ -141,8 +141,8 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
>           return;
>       }
>   
> -    if (vfio_set_irq_signaling(&vapdev->vdev, irq, 0,
> -                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
> +    if (!vfio_set_irq_signaling(&vapdev->vdev, irq, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
>           warn_reportf_err(err, VFIO_MSG_PREFIX, vapdev->vdev.name);
>       }
>   
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 89bb980167..1f578a3c75 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -434,8 +434,8 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>       fd = event_notifier_get_fd(notifier);
>       qemu_set_fd_handler(fd, fd_read, NULL, vcdev);
>   
> -    if (vfio_set_irq_signaling(vdev, irq, 0,
> -                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
> +    if (!vfio_set_irq_signaling(vdev, irq, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
>           qemu_set_fd_handler(fd, NULL, NULL, vcdev);
>           event_notifier_cleanup(notifier);
>       }
> @@ -464,8 +464,8 @@ static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
>           return;
>       }
>   
> -    if (vfio_set_irq_signaling(&vcdev->vdev, irq, 0,
> -                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
> +    if (!vfio_set_irq_signaling(&vcdev->vdev, irq, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
>           warn_reportf_err(err, VFIO_MSG_PREFIX, vcdev->vdev.name);
>       }
>   
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 0bb7b40a6a..93e6fef6de 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -107,12 +107,12 @@ static const char *index_to_str(VFIODevice *vbasedev, int index)
>       }
>   }
>   
> -int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
> -                           int action, int fd, Error **errp)
> +bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
> +                            int action, int fd, Error **errp)
>   {
>       ERRP_GUARD();
>       g_autofree struct vfio_irq_set *irq_set = NULL;
> -    int argsz, ret = 0;
> +    int argsz;
>       const char *name;
>       int32_t *pfd;
>   
> @@ -127,15 +127,11 @@ int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
>       pfd = (int32_t *)&irq_set->data;
>       *pfd = fd;
>   
> -    if (ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> -        ret = -errno;
> +    if (!ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> +        return true;
>       }
>   
> -    if (!ret) {
> -        return 0;
> -    }
> -
> -    error_setg_errno(errp, -ret, "VFIO_DEVICE_SET_IRQS failure");
> +    error_setg_errno(errp, errno, "VFIO_DEVICE_SET_IRQS failure");
>   
>       name = index_to_str(vbasedev, index);
>       if (name) {
> @@ -146,7 +142,7 @@ int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
>       error_prepend(errp,
>                     "Failed to %s %s eventfd signaling for interrupt ",
>                     fd < 0 ? "tear down" : "set up", action_to_str(action));
> -    return ret;
> +    return false;
>   }
>   
>   /*
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a447013a1d..358da4497b 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -147,10 +147,10 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>           goto fail_irqfd;
>       }
>   
> -    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
> -                               VFIO_IRQ_SET_ACTION_UNMASK,
> -                               event_notifier_get_fd(&vdev->intx.unmask),
> -                               errp)) {
> +    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
> +                                VFIO_IRQ_SET_ACTION_UNMASK,
> +                                event_notifier_get_fd(&vdev->intx.unmask),
> +                                errp)) {
>           goto fail_vfio;
>       }
>   
> @@ -295,8 +295,8 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>       fd = event_notifier_get_fd(&vdev->intx.interrupt);
>       qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
>   
> -    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
> -                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
> +    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
>           event_notifier_cleanup(&vdev->intx.interrupt);
>           return -errno;
> @@ -590,9 +590,10 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>                   fd = event_notifier_get_fd(&vector->interrupt);
>               }
>   
> -            if (vfio_set_irq_signaling(&vdev->vbasedev,
> -                                       VFIO_PCI_MSIX_IRQ_INDEX, nr,
> -                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> +            if (!vfio_set_irq_signaling(&vdev->vbasedev,
> +                                        VFIO_PCI_MSIX_IRQ_INDEX, nr,
> +                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd,
> +                                        &err)) {
>                   error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>               }
>           }
> @@ -634,8 +635,9 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>           int32_t fd = event_notifier_get_fd(&vector->interrupt);
>           Error *err = NULL;
>   
> -        if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
> -                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> +        if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
> +                                    nr, VFIO_IRQ_SET_ACTION_TRIGGER, fd,
> +                                    &err)) {
>               error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>           }
>       }
> @@ -2873,8 +2875,8 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>       fd = event_notifier_get_fd(&vdev->err_notifier);
>       qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
>   
> -    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
> -                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> +    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
>           event_notifier_cleanup(&vdev->err_notifier);
> @@ -2890,8 +2892,8 @@ static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
>           return;
>       }
>   
> -    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
> -                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
> +    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>       }
>       qemu_set_fd_handler(event_notifier_get_fd(&vdev->err_notifier),
> @@ -2938,8 +2940,8 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>       fd = event_notifier_get_fd(&vdev->req_notifier);
>       qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
>   
> -    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
> -                           VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
> +    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
>           event_notifier_cleanup(&vdev->req_notifier);
> @@ -2956,8 +2958,8 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>           return;
>       }
>   
> -    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
> -                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
> +    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>       }
>       qemu_set_fd_handler(event_notifier_get_fd(&vdev->req_notifier),
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 2bd16096bb..3233ca8691 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -115,18 +115,17 @@ static int vfio_set_trigger_eventfd(VFIOINTp *intp,
>       VFIODevice *vbasedev = &intp->vdev->vbasedev;
>       int32_t fd = event_notifier_get_fd(intp->interrupt);
>       Error *err = NULL;
> -    int ret;
>   
>       qemu_set_fd_handler(fd, (IOHandler *)handler, NULL, intp);
>   
> -    ret = vfio_set_irq_signaling(vbasedev, intp->pin, 0,
> -                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err);
> -    if (ret) {
> +    if (!vfio_set_irq_signaling(vbasedev, intp->pin, 0,
> +                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
>           qemu_set_fd_handler(fd, NULL, NULL, NULL);
> +        return -EINVAL;
>       }
>   
> -    return ret;
> +    return 0;
>   }
>   
>   /*
> @@ -355,15 +354,14 @@ static int vfio_set_resample_eventfd(VFIOINTp *intp)
>       int32_t fd = event_notifier_get_fd(intp->unmask);
>       VFIODevice *vbasedev = &intp->vdev->vbasedev;
>       Error *err = NULL;
> -    int ret;
>   
>       qemu_set_fd_handler(fd, NULL, NULL, NULL);
> -    ret = vfio_set_irq_signaling(vbasedev, intp->pin, 0,
> -                                 VFIO_IRQ_SET_ACTION_UNMASK, fd, &err);
> -    if (ret) {
> +    if (!vfio_set_irq_signaling(vbasedev, intp->pin, 0,
> +                                VFIO_IRQ_SET_ACTION_UNMASK, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
> +        return -EINVAL;
>       }
> -    return ret;
> +    return 0;
>   }
>   
>   /**


