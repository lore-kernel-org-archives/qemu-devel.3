Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EE7C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTeNl-0005Co-DE; Tue, 16 Jul 2024 05:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTeNj-00054w-EL
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTeNh-0004Dt-V3
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721121717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKDiKtmursMnnMtaNxa3jatJLhYXm3V3OaNf6Tc5zoA=;
 b=Q0qC7FyjIhVwf4OS1hOy91aCquRWn/O0xjTehb+lMaecsZ7TZzeTUnNIi0zMR3BI6nUs7J
 CiuzMl1pG7GCy/lLFzwj4waPS/pXEY83HE9h0O1am08FvMe5kTIyW5+2/w+zIQZdqKg0Dw
 pXuFBDkw0S9qG9pK73KA7KqfKGWQtCE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-P63dKvz_OSCu3xL1Y1Ru-Q-1; Tue, 16 Jul 2024 05:21:54 -0400
X-MC-Unique: P63dKvz_OSCu3xL1Y1Ru-Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3678fbf4aa7so3026207f8f.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721121713; x=1721726513;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gKDiKtmursMnnMtaNxa3jatJLhYXm3V3OaNf6Tc5zoA=;
 b=bBhTedJvDPm0nm6XafV4Wx4s99cB5fywp97MxpiuVTOXt2ps4UdhGoYWPB7+qFgby3
 Di7MUeRjdPS/tx+oi5Vl0mvzXuWnh0jAZU37m4zSP46xP5RqcsUsKt4O6TkjfqCNnM+1
 yQLxdNlu40Trg1KS3zof3E+cuotZOP2E8xTGYGtdeqGDJZIkv1mR0cGJkmo9l3/gEJv4
 FyBQgqbbz9XP9EiMNkii6++fAecD9uuHWUiPZXwwIt0M8LLogS0xb5ZFXf2yJGQZDSfi
 SZHmgsT5ejYg14jg9+Ym9/bFZARJgyqpHlmxhfesY/vmHcBAmVuVFWDYGeP2DAe39Zjq
 lgkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCIv35XQ7FV9He722FXms9Xo9kKKcwathaOrtpQ9mcvTrkcOUrYkfthSZ/gIDUe7jgFRPjAGQE74NfN4bxXparVEzGM78=
X-Gm-Message-State: AOJu0YyxWcs5DTjCYMFcMdnxSEuqfVm7MWT58hSSVT/ETOT3V+HN5RNh
 Lvo1jCJhh+QtPByms31xbuX76KbKU7T+3IFepHPDz8xBV/wV9VYnO11TvMy8nPoghwFdv2moK7e
 aGN8irFv+9Tr2cL14ZaXTS0QfeqDrosygWgZlTd1q21Mfzqy8Dhdk
X-Received: by 2002:a5d:5f4d:0:b0:367:9088:fecc with SMTP id
 ffacd0b85a97d-36825f66d1cmr1057946f8f.7.1721121713732; 
 Tue, 16 Jul 2024 02:21:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFte2Bo0dvWrHip6q4CkzN/d+7zUU72h861I9bj6y3xkboNP4HjL4QBszpssLeba+9eNqgyg==
X-Received: by 2002:a5d:5f4d:0:b0:367:9088:fecc with SMTP id
 ffacd0b85a97d-36825f66d1cmr1057933f8f.7.1721121713367; 
 Tue, 16 Jul 2024 02:21:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb9aasm8422501f8f.67.2024.07.16.02.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 02:21:52 -0700 (PDT)
Message-ID: <57e947c7-6fca-4ee7-9c4b-e3ca86ad93e5@redhat.com>
Date: Tue, 16 Jul 2024 11:21:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] vfio/iommufd: Don't initialize nor set a
 HOST_IOMMU_DEVICE with mdev
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-3-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240712114704.8708-3-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 7/12/24 13:46, Joao Martins wrote:
> mdevs aren't "physical" devices and when asking for backing IOMMU info, it
> fails the entire provisioning of the guest. Fix that by skipping
> HostIOMMUDevice initialization in the presence of mdevs, and skip setting
> an iommu device when it is known to be an mdev.
> 
> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Fixes: 930589520128 ("vfio/iommufd: Implement HostIOMMUDeviceClass::realize() handler")
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   hw/vfio/common.c |  4 ++++
>   hw/vfio/pci.c    | 10 +++++++---
>   2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7cdb969fd396..b0beed44116e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1556,6 +1556,10 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>           return false;
>       }
>   
> +    if (vbasedev->mdev) {
> +        return true;
> +    }
> +
>       hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>       if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
>           object_unref(hiod);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 585f23a18406..3fc72e898a25 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3116,7 +3116,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>   
>       vfio_bars_register(vdev);
>   
> -    if (!pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
> +    if (!is_mdev && !pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {

let's use vbasedev->mdev instead.


Thanks,

C.


>           error_prepend(errp, "Failed to set iommu_device: ");
>           goto out_teardown;
>       }
> @@ -3239,7 +3239,9 @@ out_deregister:
>           timer_free(vdev->intx.mmap_timer);
>       }
>   out_unset_idev:
> -    pci_device_unset_iommu_device(pdev);
> +    if (!is_mdev) {
> +        pci_device_unset_iommu_device(pdev);
> +    }
>   out_teardown:
>       vfio_teardown_msi(vdev);
>       vfio_bars_exit(vdev);
> @@ -3284,7 +3286,9 @@ static void vfio_exitfn(PCIDevice *pdev)
>       vfio_pci_disable_rp_atomics(vdev);
>       vfio_bars_exit(vdev);
>       vfio_migration_exit(vbasedev);
> -    pci_device_unset_iommu_device(pdev);
> +    if (!vbasedev->mdev) {
> +        pci_device_unset_iommu_device(pdev);
> +    }
>   }
>   
>   static void vfio_pci_reset(DeviceState *dev)


