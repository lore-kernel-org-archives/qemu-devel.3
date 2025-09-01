Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4CFCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 16:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut7W6-0000o3-Nd; Mon, 01 Sep 2025 12:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ut7W5-0000nu-41
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 12:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ut7W3-0000hk-0L
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 12:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756744578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Iz2EcYhPAHbf5FhiL7dcddXw2LrGLjvEQ1rsZUBLoNc=;
 b=gaWmAYQuObed0VY5i3309uCMWPDt5xcVwhWGwR7h5rQk4uxBuL2IHd9eIc3ARE/Q2ZKFEy
 Td/xvQ79Kv3SGXNOm8RVd0fQkSDYxbVB0Is+2BE2qxbtUtqlr6Y8l6zZg7dutNYlloyuVe
 TumtClQTZ/SWy86XZmGKBMSyhamXABM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-uNlx-tzSMbuZ8qFOzirC-w-1; Mon, 01 Sep 2025 12:36:17 -0400
X-MC-Unique: uNlx-tzSMbuZ8qFOzirC-w-1
X-Mimecast-MFC-AGG-ID: uNlx-tzSMbuZ8qFOzirC-w_1756744576
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-70ddadde46bso81047106d6.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 09:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756744576; x=1757349376;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Iz2EcYhPAHbf5FhiL7dcddXw2LrGLjvEQ1rsZUBLoNc=;
 b=W3O+Z9jHrxNulcPqLOzH7HY7ZQVMKy8ThAw2RGLjiNr54l6sMqTWCMyS6hEtYzSkRc
 ji1KV1DndMMWlj59tFCsb67UGywaY1frG1YqY8NHFUOJUvBKIEBW5HWrc5l4QfinXAHU
 dTyZjYhwTOD+X1A4FsnWoce2nymTy2ZC1J3XETYwSIezxVx1Nok+kh9yjeKoxIO3jw+K
 aJc5E4SDAnj8WgAsDiWhMqZH7Ss8BHh/FczEYRrimYCXnWGSEgjwCICAX5vK4iOAjjSE
 pzuxcKzYKpXKyORoMeuA5RabD7JaOUCozhVzyN//IaYcZamK2xpGc2iVIM4N852msx7f
 q/XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFDLptlFEa/s1/u9PFBHpqvWL3JhaRVWOCVaQJmUlchd71mlwyofJP96oi8tw80HIcVSVIjI0kLBrq@nongnu.org
X-Gm-Message-State: AOJu0Ywtm/2Zu3CXvDnbZaEADWpj2KWUjGybvSj/DoMyLx8lQeQrLe9v
 mWEnjdIKTnM8Z2u7EDQ94nfxvlwAnAy/TDeTPl1cesjbdCSgiy3SLkvzaFCHUcnMigefmKyrmfo
 sSDmiN1XxBIJRb/KR8j4mTiC2hh5NggTY6qrcvhMLwAEjtz9isYQwFGVR
X-Gm-Gg: ASbGncs5+zHohBu/AbS9sSZzknOLFlvay53ln0qpoDyFTSTEaazSnAS0xARZlkyYcLC
 T+WUPIXb3ZyJlFV81A8d7jC7rdhkHsjzgmXURtfToFnZBV8NzcIMcanHtf9mnNu+jHACtTuVjMq
 yHI6BPHqC1Dqkk8gSy1AF8Hvc9Z8tySKIVU0aKEppg5UosR3K3RblqOOFy0tuXsz8HAGyFY/H1P
 +UAbmX7PJV6GFnGef50OAhCMD9vZNEGRW5XSDnKNEb76A82rRMwQBdhugeC+b4yB5C5GWHzTwAC
 VecW6lMlogjGeTQ/6XD4jbunjDQ+YJnOpqRGkVHOJyxHdnvJUGVDw7vqk7UNrfDvW9wieo0BXoo
 PShg=
X-Received: by 2002:a05:620a:7105:b0:7e1:8e73:b92 with SMTP id
 af79cd13be357-7ff2869b802mr904443085a.36.1756744576380; 
 Mon, 01 Sep 2025 09:36:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDL5km3Uq0zcoQiGNlQVu/LRvgZe1RfYTlHmWEbO//7EZ8X9X3AKnD53QRkQQOVvDycPQd9Q==
X-Received: by 2002:a05:620a:7105:b0:7e1:8e73:b92 with SMTP id
 af79cd13be357-7ff2869b802mr904439985a.36.1756744575847; 
 Mon, 01 Sep 2025 09:36:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b30b3de01asm64700511cf.0.2025.09.01.09.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 09:36:15 -0700 (PDT)
Message-ID: <125624f5-824d-4b40-ac8e-38a2dd7ae8ef@redhat.com>
Date: Mon, 1 Sep 2025 18:36:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/21] vfio: Introduce helper
 vfio_pci_from_vfio_device()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-5-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250822064101.123526-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Zhenzhong,

On 8/22/25 08:40, Zhenzhong Duan wrote:
> Introduce helper vfio_pci_from_vfio_device() to transform from VFIODevice
> to VFIOPCIDevice, also to hide low level VFIO_DEVICE_TYPE_PCI type check.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/20250801023533.1458644-1-zhenzhong.duan@intel.com
> [ clg: Added documentation ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Would you like me to merge these VFIO changes upfront ?

They do not seem to conflict with the series I have queued for 10.2 so far.

C.



> ---
>   hw/vfio/pci.h       | 12 ++++++++++++
>   hw/vfio/container.c |  4 ++--
>   hw/vfio/device.c    |  2 +-
>   hw/vfio/iommufd.c   |  4 ++--
>   hw/vfio/listener.c  |  4 ++--
>   hw/vfio/pci.c       |  9 +++++++++
>   6 files changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 810a842f4a..beb8fb9ee7 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -221,6 +221,18 @@ void vfio_pci_write_config(PCIDevice *pdev,
>   uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
>   void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
>   
> +/**
> + * vfio_pci_from_vfio_device: Transform from VFIODevice to
> + * VFIOPCIDevice
> + *
> + * This function checks if the given @vbasedev is a VFIO PCI device.
> + * If it is, it returns the containing VFIOPCIDevice.
> + *
> + * @vbasedev: The VFIODevice to transform
> + *
> + * Return: The VFIOPCIDevice on success, NULL on failure.
> + */
> +VFIOPCIDevice *vfio_pci_from_vfio_device(VFIODevice *vbasedev);
>   void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev);
>   bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
>   bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp);
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 3e13feaa74..134ddccc52 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1087,7 +1087,7 @@ static int vfio_legacy_pci_hot_reset(VFIODevice *vbasedev, bool single)
>           /* Prep dependent devices for reset and clear our marker. */
>           QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>               if (!vbasedev_iter->dev->realized ||
> -                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
> +                !vfio_pci_from_vfio_device(vbasedev_iter)) {
>                   continue;
>               }
>               tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
> @@ -1172,7 +1172,7 @@ out:
>   
>           QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>               if (!vbasedev_iter->dev->realized ||
> -                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
> +                !vfio_pci_from_vfio_device(vbasedev_iter)) {
>                   continue;
>               }
>               tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 52a1996dc4..08f12ac31f 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -129,7 +129,7 @@ static inline const char *action_to_str(int action)
>   
>   static const char *index_to_str(VFIODevice *vbasedev, int index)
>   {
> -    if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
> +    if (!vfio_pci_from_vfio_device(vbasedev)) {
>           return NULL;
>       }
>   
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 48c590b6a9..8c27222f75 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -737,8 +737,8 @@ iommufd_cdev_dep_get_realized_vpdev(struct vfio_pci_dependent_device *dep_dev,
>       }
>   
>       vbasedev_tmp = iommufd_cdev_pci_find_by_devid(dep_dev->devid);
> -    if (!vbasedev_tmp || !vbasedev_tmp->dev->realized ||
> -        vbasedev_tmp->type != VFIO_DEVICE_TYPE_PCI) {
> +    if (!vfio_pci_from_vfio_device(vbasedev_tmp) ||
> +        !vbasedev_tmp->dev->realized) {
>           return NULL;
>       }
>   
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index f498e23a93..903dfd8bf2 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -450,7 +450,7 @@ static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
>        * MMIO region mapping failures are not fatal but in this case PCI
>        * peer-to-peer transactions are broken.
>        */
> -    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> +    if (vfio_pci_from_vfio_device(vbasedev)) {
>           error_append_hint(errp, "%s: PCI peer-to-peer transactions "
>                             "on BARs are not supported.\n", vbasedev->name);
>       }
> @@ -751,7 +751,7 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
>       owner = memory_region_owner(section->mr);
>   
>       QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> -        if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
> +        if (!vfio_pci_from_vfio_device(vbasedev)) {
>               continue;
>           }
>           pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 07257d0fa0..3fe5b03eb1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2833,6 +2833,15 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
>       return ret;
>   }
>   
> +/* Transform from VFIODevice to VFIOPCIDevice. Return NULL if fails. */
> +VFIOPCIDevice *vfio_pci_from_vfio_device(VFIODevice *vbasedev)
> +{
> +    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> +        return container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +    }
> +    return NULL;
> +}
> +
>   void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev)
>   {
>       PCIDevice *pdev = &vdev->pdev;


