Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F844C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 12:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMS0k-0003mv-MZ; Wed, 26 Jun 2024 08:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sMS0f-0003lf-5o
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sMS0d-0000iF-MO
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719405862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=18VrglAW3/j+axokzwCmxHvnzRZtsIvQDdbWdooqZs8=;
 b=byThLi0eJQXIf0k9/AtFLV73b7GN2+4m6w7Oyjg8TSUzrgwSy1TsX5AtKG2y+xuP71RlWF
 P0u5ENe2kqLGUkrmkWu2crlGtuEAdLoARWlf5A2UjhQBfUr9SGONaerpqJ5mmjs48wE68/
 wY3HPZ4AZ2lJGXztcUDWz4eRz4e0bug=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-yJqPtzAtP-i68PtACjyvnQ-1; Wed, 26 Jun 2024 08:44:20 -0400
X-MC-Unique: yJqPtzAtP-i68PtACjyvnQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-79c117509adso173474985a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 05:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719405860; x=1720010660;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=18VrglAW3/j+axokzwCmxHvnzRZtsIvQDdbWdooqZs8=;
 b=AAdzvZsZHLf7ahUlzudFaL1UcSTquuiTJi0/VjujFesKpweh2GrxX4Zz0XMzpE+k0a
 PFs86nqgtw1pSgBcmD+qP2yPeQjDpWyl9GYTAX4i38/k6skWPRdHvGnbh7FXQLh4bqOr
 pZwxKZXCOlLTQcNqk6t/o6q269f4bSwkXGXuSHZEAB1OT/G7avO71Jx6MCcHxpyqm5Mz
 /7rClfIRevd8iF4FIuztSdNGEpoHEkVDkmZY/dUgqI4mfOKpP8B3Nb0hIjzRuZOCrZXM
 gRpwkQtg56jRy6hkLCGh7VQB6AVAT8BII4daojbD2AQP6greqN6dFCCh56GnYm/KfnSd
 xrpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfNXRkM6qUNoyiCTlRiLDuEqOLDcWHk6XHMjeIaMWVaJFguKywCkc3sYg0g2OAlJCHVtY8fyuFVGZ6XBJcddJN1mNwbcs=
X-Gm-Message-State: AOJu0YxgNJZP9XzwQc4b7dHaet0N34BRrkiFV6trRT08yV837iX4+RIl
 yQZoTn8SFF/5AnCrV+8VvVewlwNEUUiDjHst2of8pV4KIwe9Ftqv11sx1tCEWj8Y7Pmmthmwh7+
 wvWcZGmxirZ2GCsDncMlVuMavNtS44ToE34BublwcdVnoM55b4ID4
X-Received: by 2002:a05:620a:2903:b0:79d:55f0:d09a with SMTP id
 af79cd13be357-79d55f0d424mr73787885a.25.1719405860277; 
 Wed, 26 Jun 2024 05:44:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPDMenEc3TuSuhYAuAILK1y9kfSIxHKKP9FGRJg9rKCRKr0RaEvd2PY5zzfruiZbnIvPlFdA==
X-Received: by 2002:a05:620a:2903:b0:79d:55f0:d09a with SMTP id
 af79cd13be357-79d55f0d424mr73785985a.25.1719405859877; 
 Wed, 26 Jun 2024 05:44:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79c1117638bsm89513285a.3.2024.06.26.05.44.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 05:44:19 -0700 (PDT)
Message-ID: <975410b5-40e4-4f9a-8611-980b5beabd21@redhat.com>
Date: Wed, 26 Jun 2024 14:44:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] HostIOMMUDevice: Introduce get_page_size_mask()
 callback
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org, yanghliu@redhat.com,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com
References: <20240626082727.1278530-1-eric.auger@redhat.com>
 <20240626082727.1278530-5-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240626082727.1278530-5-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

On 6/26/24 10:26 AM, Eric Auger wrote:
> This callback will be used to retrieve the page size mask supported
> along a given Host IOMMU device.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-container-base.h |  7 +++++++
>   include/sysemu/host_iommu_device.h    |  8 ++++++++
>   hw/vfio/container.c                   | 10 ++++++++++
>   hw/vfio/iommufd.c                     | 11 +++++++++++
>   4 files changed, 36 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 45d7c40fce..62a8b60d87 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -88,6 +88,13 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>   
>   GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer);
>   
> +static inline uint64_t
> +vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
> +{
> +    assert(bcontainer);
> +    return bcontainer->pgsizes;
> +}
> +
>   #define TYPE_VFIO_IOMMU "vfio-iommu"
>   #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
>   #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> index 05c7324a0d..c1bf74ae2c 100644
> --- a/include/sysemu/host_iommu_device.h
> +++ b/include/sysemu/host_iommu_device.h
> @@ -89,6 +89,14 @@ struct HostIOMMUDeviceClass {
>        * @hiod: handle to the host IOMMU device
>        */
>       GList* (*get_iova_ranges)(HostIOMMUDevice *hiod);
> +    /**
> +     *
> +     * @get_page_size_mask: Return the page size mask supported along this
> +     * @hiod Host IOMMU device
> +     *
> +     * @hiod: handle to the host IOMMU device
> +     */
> +    uint64_t (*get_page_size_mask)(HostIOMMUDevice *hiod);
>   };
>   
>   /*
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index adeab1ac89..b5ce559a0d 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1174,6 +1174,15 @@ hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
>       return vfio_container_get_iova_ranges(vdev->bcontainer);
>   }
>   
> +static uint64_t
> +hiod_legacy_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
> +{
> +    VFIODevice *vdev = hiod->agent;
> +
> +    g_assert(vdev);
> +    return vfio_container_get_page_size_mask(vdev->bcontainer);
> +}
> +
>   static void vfio_iommu_legacy_instance_init(Object *obj)
>   {
>       VFIOContainer *container = VFIO_IOMMU_LEGACY(obj);
> @@ -1188,6 +1197,7 @@ static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
>       hioc->realize = hiod_legacy_vfio_realize;
>       hioc->get_cap = hiod_legacy_vfio_get_cap;
>       hioc->get_iova_ranges = hiod_legacy_vfio_get_iova_ranges;
> +    hioc->get_page_size_mask = hiod_legacy_vfio_get_page_size_mask;
>   };
>   
>   static const TypeInfo types[] = {
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 211e7223f1..7b5f87a148 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -652,12 +652,23 @@ hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
>       return vfio_container_get_iova_ranges(vdev->bcontainer);
>   }
>   
> +static uint64_t
> +hiod_iommufd_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
> +{
> +    VFIODevice *vdev = hiod->agent;
> +
> +    g_assert(vdev);
> +    return vfio_container_get_page_size_mask(vdev->bcontainer);
> +}
> +
> +
>   static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
>   {
>       HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
>   
>       hiodc->realize = hiod_iommufd_vfio_realize;
>       hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
> +    hiodc->get_page_size_mask = hiod_iommufd_vfio_get_page_size_mask;
>   };
>   
>   static const TypeInfo types[] = {


