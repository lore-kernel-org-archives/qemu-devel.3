Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE375C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 14:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUoIt-0002cG-K0; Fri, 19 Jul 2024 10:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sUoIq-0002bk-VD
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 10:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sUoIp-0002qj-7H
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 10:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721398181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dim+ij29Xt4Y3CJpKOhvALG1fw1/X5DPBuYaBj9oOEs=;
 b=OVuapczqbohVuGPCM+ZQXznXVoOn4fE0fXeMCkcFlj6G7wHwMJxSB9lEoE2+ITEPJwGHLP
 WtfPHHMS9Kk194IqrX6UA62IA4JBL3c3ieck8+3bzJYZ1k28cd8/btuLxg3HtbInIUZZA6
 +4PTqeAOoBXnSF9cppRIVe1GdYCyBm8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-aXNTpxIFOlms53nlL7NDyg-1; Fri, 19 Jul 2024 10:09:39 -0400
X-MC-Unique: aXNTpxIFOlms53nlL7NDyg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42726545762so11385875e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 07:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721398178; x=1722002978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dim+ij29Xt4Y3CJpKOhvALG1fw1/X5DPBuYaBj9oOEs=;
 b=DVZfRrcyUXqtqmCJe1iJgZcfN9WagOTMRgUJpT151yqvracbGXCXd0ySr9bZ+Z8HTl
 2LEJEdanlEQEfJx/oFk+dgPvRAzngIGYpO4p8gbeiEo5ZjYXns2KUmoE6C+IfRFIvi4M
 7yn4PMg149fXNP4NYICe8Le17O5QsuR3FtN6w5rxICYUasBO7ohdRSWbgDcAcQJHxBuc
 p1N47W0VK7BiXXLTxOCXac4iVi367xE+My6tKYYd/WJNNaWF1qhkiSAO/9ggRGoF6/qv
 d1PIQQKe7xnNC4+J6959Um0Ti7heQHsntQLM1w8f6YhbK6cKT0PD8kXdxL3x7r5roIHu
 uDrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpnqODN1G53F7FL25blp78vEsQixO7Qhn2lhxri9cqxwUiPRCdB7owUI8Gt+EsXEDCwKRYA8t66tw5QmsOCf+q3VpBFl0=
X-Gm-Message-State: AOJu0Yzak0x9DpDu/vhW/yCBTZ4/laWCdVvdogwIQX6C7/4k7FydUCTz
 qUiA1cZx4+JSeRIDkUtd7ebGOFjRQ7ASUk3odkM+vpaO2857W4QAAxroST4sGzfzz/ZVOsoHOVc
 uuEIehxQ1RxiGI4EWEGxetgQkGa0TjIDJu4zaGCwibTvWhfssY0TR
X-Received: by 2002:a05:600c:4f56:b0:426:68dd:bc92 with SMTP id
 5b1f17b1804b1-427c2cadeefmr46438195e9.5.1721398178247; 
 Fri, 19 Jul 2024 07:09:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzxgWfpdkWG9UNq8se++r8Qh/8xQLQgdsIZoekFg7kofbbTlY+4IpPUhwlZno2XSQmV+Dg7g==
X-Received: by 2002:a05:600c:4f56:b0:426:68dd:bc92 with SMTP id
 5b1f17b1804b1-427c2cadeefmr46438115e9.5.1721398177830; 
 Fri, 19 Jul 2024 07:09:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8d8f9sm53392895e9.37.2024.07.19.07.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 07:09:37 -0700 (PDT)
Message-ID: <c2891709-1a4d-4a34-9769-b572e0563ab2@redhat.com>
Date: Fri, 19 Jul 2024 16:09:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/13] vfio/pci: Extract mdev check into an helper
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-2-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240719120501.81279-2-joao.m.martins@oracle.com>
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

On 7/19/24 14:04, Joao Martins wrote:
> In preparation to skip initialization of the HostIOMMUDevice for mdev,
> extract the checks that validate if a device is an mdev into helpers.
> 
> A vfio_device_is_mdev() is created, and subsystems consult VFIODevice::mdev
> to check if it's mdev or not.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h |  2 ++
>   hw/vfio/helpers.c             | 14 ++++++++++++++
>   hw/vfio/pci.c                 | 12 +++---------
>   3 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index e8ddf92bb185..98acae8c1c97 100644
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
> +bool vfio_device_is_mdev(VFIODevice *vbasedev);
>   bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>                           AddressSpace *as, Error **errp);
>   void vfio_detach_device(VFIODevice *vbasedev);
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index b14edd46edc9..7e23e9080c9d 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -675,3 +675,17 @@ int vfio_device_get_aw_bits(VFIODevice *vdev)
>   
>       return HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX;
>   }
> +
> +bool vfio_device_is_mdev(VFIODevice *vbasedev)
> +{
> +    g_autofree char *subsys = NULL;
> +    g_autofree char *tmp = NULL;
> +
> +    if (!vbasedev->sysfsdev) {
> +        return false;
> +    }
> +
> +    tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
> +    subsys = realpath(tmp, NULL);
> +    return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index e03d9f3ba546..b34e91468a53 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2963,12 +2963,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       ERRP_GUARD();
>       VFIOPCIDevice *vdev = VFIO_PCI(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
> -    char *subsys;
>       int i, ret;
> -    bool is_mdev;
>       char uuid[UUID_STR_LEN];
>       g_autofree char *name = NULL;
> -    g_autofree char *tmp = NULL;
>   
>       if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
>           if (!(~vdev->host.domain || ~vdev->host.bus ||
> @@ -2997,14 +2994,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>        * stays in sync with the active working set of the guest driver.  Prevent
>        * the x-balloon-allowed option unless this is minimally an mdev device.
>        */
> -    tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
> -    subsys = realpath(tmp, NULL);
> -    is_mdev = subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
> -    free(subsys);
> +    vbasedev->mdev = vfio_device_is_mdev(vbasedev);
>   
> -    trace_vfio_mdev(vbasedev->name, is_mdev);
> +    trace_vfio_mdev(vbasedev->name, vbasedev->mdev);
>   
> -    if (vbasedev->ram_block_discard_allowed && !is_mdev) {
> +    if (vbasedev->ram_block_discard_allowed && !vbasedev->mdev) {
>           error_setg(errp, "x-balloon-allowed only potentially compatible "
>                      "with mdev devices");
>           goto error;


