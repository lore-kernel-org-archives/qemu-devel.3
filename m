Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC35C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 12:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMRze-0002Zn-It; Wed, 26 Jun 2024 08:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sMRzb-0002ZG-AK
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sMRzW-0000aC-GV
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719405793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOfnJ7jDzdU/A2Gk7+8IYysr5m9GuHyFj+n1x5ffO1s=;
 b=Ab8U91/N91yoM/Z/FV+P1kSW272KNoNlgoVEC8diSQ9IvPwmpFIPvRq3Jj+KzshYVG00Ex
 rnyP18XeoIifRUmcUe2z/TTKEmIC4/N3C6+slntqB4x2hiHGwb32d3WXAalmZsSnn7DyXc
 5l9Qi5rN3lNxbB8Gl2Q3kZEKBNdMi1c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-v_GfFGNvMDKdWabADbcdHA-1; Wed, 26 Jun 2024 08:43:12 -0400
X-MC-Unique: v_GfFGNvMDKdWabADbcdHA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-444c70c9171so101802201cf.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 05:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719405792; x=1720010592;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OOfnJ7jDzdU/A2Gk7+8IYysr5m9GuHyFj+n1x5ffO1s=;
 b=nhibUOvFyjg6jFw+x1FF2VI65x9jD/AJbHU0+LW8nJ4W2oX47xY9bG+c21Fbqkj146
 4qMWPC4NDZC9cA0qGa2NB+TH1+kK/YP4btWfum6aGyOokOcigwNzVquXF0vrEAddXjVC
 ntEys2p08W3OAIWggCuXXNB1dkkXAHhOY75M9cg+TbS8gSgLGngN1wz+qCUnpf5x2DHU
 X7wlBEqG8zhfqaZJwgbHpmYlBKz2+stjn9PWOFDTUxWLMlJTyDiWLw3xytqGQ8JVE2cK
 F6KdqZspU/B4GEJJnaewkGuFvdE4NWXS771haO2RunpK53YrQ/alR3AYku6Z2yIROw9q
 GCsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3R+nJXiBBZrKZFKj7jM7fNdAMq14SpRVG3g61It4swTUUNfEP7IMkFqWPWm6Ujx4624zGNnlaMQUJD68u/yTPRE8u/Gw=
X-Gm-Message-State: AOJu0Yy4AUUk5H9dBA9Fufa5cXdFXkBsTHB7ddguPqx37dxHnDj4fiGG
 jtRYmlEdmpg4arLsm4rskenvd3Vs0/I5dC5MmfqTpRyN2YQzORLKv6O3saJvnMJ1twgykoJeL60
 ECa1uL7rTYo+JAMcCEq7qXou72H1bx1/zEZ8BZ4kn0gMGpxBFmmY5
X-Received: by 2002:a05:622a:104:b0:444:f877:18aa with SMTP id
 d75a77b69052e-444f8771ebamr51492461cf.60.1719405791871; 
 Wed, 26 Jun 2024 05:43:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv89OYmc1AoPL//kT0T2CnsBmsrLMFXj4APzCMQHQfgU3xKwvlrzQWncRGeEO4MrJnITyCIQ==
X-Received: by 2002:a05:622a:104:b0:444:f877:18aa with SMTP id
 d75a77b69052e-444f8771ebamr51492221cf.60.1719405791498; 
 Wed, 26 Jun 2024 05:43:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-444c2b83fc8sm66951111cf.43.2024.06.26.05.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 05:43:11 -0700 (PDT)
Message-ID: <f4849fe4-1f6a-42a9-96e5-f7179c52d05d@redhat.com>
Date: Wed, 26 Jun 2024 14:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] HostIOMMUDevice : remove Error handle from
 get_iova_ranges callback
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org, yanghliu@redhat.com,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com
References: <20240626082727.1278530-1-eric.auger@redhat.com>
 <20240626082727.1278530-4-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240626082727.1278530-4-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 6/26/24 10:26 AM, Eric Auger wrote:
> The error handle argument is not used anywhere. let's remove it.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/sysemu/host_iommu_device.h | 3 +--
>   hw/vfio/container.c                | 2 +-
>   hw/vfio/iommufd.c                  | 2 +-
>   hw/virtio/virtio-iommu.c           | 2 +-
>   4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> index ee6c813c8b..05c7324a0d 100644
> --- a/include/sysemu/host_iommu_device.h
> +++ b/include/sysemu/host_iommu_device.h
> @@ -87,9 +87,8 @@ struct HostIOMMUDeviceClass {
>        * @hiod Host IOMMU device
>        *
>        * @hiod: handle to the host IOMMU device
> -     * @errp: error handle
>        */
> -    GList* (*get_iova_ranges)(HostIOMMUDevice *hiod, Error **errp);
> +    GList* (*get_iova_ranges)(HostIOMMUDevice *hiod);
>   };
>   
>   /*
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 2ad57cd845..adeab1ac89 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1166,7 +1166,7 @@ static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
>   }
>   
>   static GList *
> -hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
> +hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
>   {
>       VFIODevice *vdev = hiod->agent;
>   
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 890d8d6a38..211e7223f1 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -644,7 +644,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>   }
>   
>   static GList *
> -hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
> +hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
>   {
>       VFIODevice *vdev = hiod->agent;
>   
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index b708fb96fd..b8f75d2b1a 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -615,7 +615,7 @@ static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>   
>       if (hiodc->get_iova_ranges) {
>           int ret;
> -        host_iova_ranges = hiodc->get_iova_ranges(hiod, errp);
> +        host_iova_ranges = hiodc->get_iova_ranges(hiod);
>           if (!host_iova_ranges) {
>               return true; /* some old kernels may not support that capability */
>           }


