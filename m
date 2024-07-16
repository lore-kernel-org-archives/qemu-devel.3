Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82D6C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTiCb-00062s-BP; Tue, 16 Jul 2024 09:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTiCZ-00061u-H8
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTiCV-0003MR-KU
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721136395;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwYBYSx+R7/E/8HsXUFCxs5MwT3+6mafjqne8dQCWg4=;
 b=S1NP+fQAfTluX7rhu2M8RpIc4QRyQhQ9KaF82LiHODRUfHHHu/480qtKl5Gyj1S/+PicIG
 B5ZQ34Lvf2UwuckoQdjdJArEMOVWruJjPd969v0kK5TOJjUdud9xIKBW97nL1uEcN4VQok
 GJizlOooVrs/Ewycc3pWX9MJHVOm/+A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-1-RAS4yHO4-xNjUj9__W_g-1; Tue, 16 Jul 2024 09:26:33 -0400
X-MC-Unique: 1-RAS4yHO4-xNjUj9__W_g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6af35481ea6so79998246d6.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721136393; x=1721741193;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pwYBYSx+R7/E/8HsXUFCxs5MwT3+6mafjqne8dQCWg4=;
 b=NwKyuNt8Ebk8h5IRuuGqLgJTZxmJaOMwc8XORE9QBvjeP1ZRBinUqM+bb9Zt4VrZlC
 uxwQwMWfnhgITGi8Ec50YodVgypaLg0os5eK3MQUkFnabDnRpp2QCafwtNKSaJX1L8Xg
 6t16SkCFCm/rTB7wBtYN01uJh9TU+Vd+BpeHrKCvJ3sA0N4k+Rp2/f73ZzwlKlSV7txt
 wPWD8sXSoJMZAggQqJE3tvTR+dDpHzRQG0Q6W9ZhsqMT8kSWB4qATmmXcMRHMxHORCUB
 W8Xz4aLsgMl5DDx2QzlSUYQwf5BpEgbesGHPywo/FB8xFk7/6E7Y8dbKywYfLcmBHreU
 ME0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX67Vb+TzmIsZz5kUpbJCuXdzkvJz1ui8HK2JdoCDp8DwKInIqtarDeIjxxvMdx+H95QNiINwoDaI3lJoRP6aYS679poI=
X-Gm-Message-State: AOJu0Yz5VdMPO4/x5/fJGve+za/3IorE8r+iDbOyuAK2GFRvYlnkHJXM
 McjY1QuI05ccrb+mIFVNBxLNQQDXBAjW+MFNGY2lLLNmFd1rkdmF52WkZpK+OXGALnGiBLDY8Mp
 rBAgdRN6u0FhdDCLrWZ/R8R6dy/crxEB2JDousls2XfklTe8+kNWt
X-Received: by 2002:a05:6214:2524:b0:6b5:4249:7c5 with SMTP id
 6a1803df08f44-6b77f54d483mr28681656d6.36.1721136393068; 
 Tue, 16 Jul 2024 06:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOYeJGev2u3QL8JsgDti8kGD1hKUX/LNnWPqZVwuiu6sJEmaNgY7/KgZzRPDv+wQwxcJp6TQ==
X-Received: by 2002:a05:6214:2524:b0:6b5:4249:7c5 with SMTP id
 6a1803df08f44-6b77f54d483mr28681436d6.36.1721136392756; 
 Tue, 16 Jul 2024 06:26:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b76197d5b3sm30678616d6.41.2024.07.16.06.26.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 06:26:32 -0700 (PDT)
Message-ID: <12699274-15e7-49fa-8f37-c97dbf79ac44@redhat.com>
Date: Tue, 16 Jul 2024 15:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] vfio/iommufd: Don't initialize nor set a
 HOST_IOMMU_DEVICE with mdev
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-3-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240712114704.8708-3-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
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
With or without Cédric's suggestion
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/common.c |  4 ++++
>  hw/vfio/pci.c    | 10 +++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7cdb969fd396..b0beed44116e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1556,6 +1556,10 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>          return false;
>      }
>  
> +    if (vbasedev->mdev) {
> +        return true;
> +    }
> +
>      hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>      if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
>          object_unref(hiod);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 585f23a18406..3fc72e898a25 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3116,7 +3116,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>  
>      vfio_bars_register(vdev);
>  
> -    if (!pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
> +    if (!is_mdev && !pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
>          error_prepend(errp, "Failed to set iommu_device: ");
>          goto out_teardown;
>      }
> @@ -3239,7 +3239,9 @@ out_deregister:
>          timer_free(vdev->intx.mmap_timer);
>      }
>  out_unset_idev:
> -    pci_device_unset_iommu_device(pdev);
> +    if (!is_mdev) {
> +        pci_device_unset_iommu_device(pdev);
> +    }
>  out_teardown:
>      vfio_teardown_msi(vdev);
>      vfio_bars_exit(vdev);
> @@ -3284,7 +3286,9 @@ static void vfio_exitfn(PCIDevice *pdev)
>      vfio_pci_disable_rp_atomics(vdev);
>      vfio_bars_exit(vdev);
>      vfio_migration_exit(vbasedev);
> -    pci_device_unset_iommu_device(pdev);
> +    if (!vbasedev->mdev) {
> +        pci_device_unset_iommu_device(pdev);
> +    }
>  }
>  
>  static void vfio_pci_reset(DeviceState *dev)


