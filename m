Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D908C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTeN3-0001w0-UH; Tue, 16 Jul 2024 05:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTeN2-0001ly-FG
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:21:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTeN0-0004Cd-IZ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721121673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b4aszqtHwLiyYFZKFOuWs6dlsSCVyfwEeCtGna2akxY=;
 b=fKWjkCPkMHMJj5TRJiW7pnSaWnKS3ox+0CBJkyXXTDS63a/sKS3rqzZ3nit6xS61auK9Pg
 S3iRPTkfCvhSKphJbZOncfQdFq12G91kEk7XzvjPZSwYMKpipARqmJeoZGGy/NngfKywVB
 Fj94Xu9noJD/W1xpVuXy71THVDdGu1k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-BoCsHYwtP06ygOw8xzMbpg-1; Tue, 16 Jul 2024 05:21:11 -0400
X-MC-Unique: BoCsHYwtP06ygOw8xzMbpg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52e994d8e26so5155945e87.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721121670; x=1721726470;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b4aszqtHwLiyYFZKFOuWs6dlsSCVyfwEeCtGna2akxY=;
 b=n55AL4qnw0LmDmaIjEF9r0YeS2vykRDrB47DuGQI8EN08lRVOo9Xw5/YAPZBNxcjF0
 SD3pvPo7NzHUt7kNIy/es3g5nD9DSqX4PKGJySNefEp37iZEVAXfxH88YPgEGoqZEOby
 A5u4WPWiTlg4wSv7bEUpUO/jRIu8UKRC3wceiGFXASBgvzp03lP3s+x+vwaaCLNvf2h3
 dcwRIDhPfd8+YuA6uo6d43SieZx3VjJk2IV9k9lKxmUIbxOEynqLlbp+27EjRwaH9c0Y
 hHtzr0AcvtBi5U2V95CnWxWr8xqARHry2Voo1GY8A+ko4et93P4z3+44gB6iIIYeCR/u
 96wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4+Jn2DPRGVL+lnTqLRlc957x73mtlajN/WRkUY572NfoIZZxUcHuBRaSB79CGRzLi9d396ASBPa8Zd+Q9pwoCILNYv5M=
X-Gm-Message-State: AOJu0YzxVK5D8Nm6aSGfN7Fh/O+XgAKdGsJdNDnM8EQsqD/55VwYWqQl
 HbjzmlR1b4qQRUGDn88Cjr+JnIFyXoIfVTT6jqlCxSG+Lv3r3rsQKBchtxSS+0xXz5M3wC1BtyM
 EQsHtPqQiBr8IkBT8vU+MmhuZvByrJ8qQwVEOX+UegKOUEWmqeJd1
X-Received: by 2002:a05:6512:3d10:b0:52e:9951:7891 with SMTP id
 2adb3069b0e04-52edf0386a5mr965767e87.53.1721121669905; 
 Tue, 16 Jul 2024 02:21:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzMN4LvuHcSfw/i+VHnvWyTmvh/GW+4864v52E1DronexUaN5fZRJoBuyDUtdcxSm5KuEMaA==
X-Received: by 2002:a05:6512:3d10:b0:52e:9951:7891 with SMTP id
 2adb3069b0e04-52edf0386a5mr965752e87.53.1721121669520; 
 Tue, 16 Jul 2024 02:21:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc8217a4sm284602966b.224.2024.07.16.02.21.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 02:21:09 -0700 (PDT)
Message-ID: <36b9e5c2-660e-4020-a645-4f4f33b208b8@redhat.com>
Date: Tue, 16 Jul 2024 11:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] vfio/pci: Extract mdev check into an helper
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-2-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240712114704.8708-2-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Joao

On 7/12/24 13:46, Joao Martins wrote:
> In preparation to skip initialization of the HostIOMMUDevice for mdev,
> extract the checks that validate if a device is an mdev into helpers.
> 
> A vfio_set_mdev() is created, and subsystems consult VFIODevice::mdev
> to check if it's mdev or not.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   include/hw/vfio/vfio-common.h |  2 ++
>   hw/vfio/helpers.c             | 18 ++++++++++++++++++
>   hw/vfio/pci.c                 |  9 ++-------
>   3 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index e8ddf92bb185..7419466bca92 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -116,6 +116,7 @@ typedef struct VFIODevice {
>       DeviceState *dev;
>       int fd;
>       int type;
> +    bool mdev;
>       bool reset_works;
>       bool needs_reset;
>       bool no_mmap;
> @@ -231,6 +232,7 @@ void vfio_region_exit(VFIORegion *region);
>   void vfio_region_finalize(VFIORegion *region);
>   void vfio_reset_handler(void *opaque);
>   struct vfio_device_info *vfio_get_device_info(int fd);
> +void vfio_set_mdev(VFIODevice *vbasedev);
>   bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>                           AddressSpace *as, Error **errp);
>   void vfio_detach_device(VFIODevice *vbasedev);
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index b14edd46edc9..bace0e788a09 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -675,3 +675,21 @@ int vfio_device_get_aw_bits(VFIODevice *vdev)
>   
>       return HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX;
>   }
> +
> +void vfio_set_mdev(VFIODevice *vbasedev)

Could you please change this routine to :

   bool vfio_device_is_mdev(VFIODevice *vbasedev)

> +{
> +    g_autofree char *tmp = NULL;
> +    char *subsys;

a g_autofree variable is preferable here.

> +    bool is_mdev;
> +
> +    if (!vbasedev->sysfsdev) {
> +        return;
> +    }
> +
> +    tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
> +    subsys = realpath(tmp, NULL);
> +    is_mdev = subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);

simply return is the result here and ....

> +    free(subsys);
> +
> +    vbasedev->mdev = is_mdev;
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index e03d9f3ba546..585f23a18406 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2963,12 +2963,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       ERRP_GUARD();
>       VFIOPCIDevice *vdev = VFIO_PCI(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
> -    char *subsys;
>       int i, ret;
>       bool is_mdev;
>       char uuid[UUID_STR_LEN];
>       g_autofree char *name = NULL;
> -    g_autofree char *tmp = NULL;
>   
>       if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
>           if (!(~vdev->host.domain || ~vdev->host.bus ||
> @@ -2997,11 +2995,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>        * stays in sync with the active working set of the guest driver.  Prevent
>        * the x-balloon-allowed option unless this is minimally an mdev device.
>        */
> -    tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
> -    subsys = realpath(tmp, NULL);
> -    is_mdev = subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
> -    free(subsys);
> -
> +    vfio_set_mdev(vbasedev);
> +    is_mdev = vbasedev->mdev;

replace with :

   vbasedev->mdev = vfio_device_is_mdev(vbasedev);

and use vbasedev->mdev instead of is_mdev where needed.


Thanks,

C.




>       trace_vfio_mdev(vbasedev->name, is_mdev);
>   
>       if (vbasedev->ram_block_discard_allowed && !is_mdev) {


