Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2542C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 13:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwMBg-0007gR-GK; Mon, 15 Apr 2024 09:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwMBf-0007g1-5K
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwMBa-0000PH-Qs
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713186949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vksJFxjr2JxF6E/j3OfSj8gb/pnDm6mlP4tYtGZ0egA=;
 b=L+sHHjHx5lcnvDJ7uRWniVp4IVfvaYMR1s8GFEtY19/tCSId6dDkg7WeYkd3QE1kVDhhAD
 xZB+wPJ/Ks+pmVCPiqXgSGGO1w3oOLirD9gtM1q9i+zw+aSolyT2jldZQ7Pn6rO5w3Hm3j
 2U94BN6IVDTSEDXkjGg2X4anWd0sbJY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-UevpvNqEP026mjK0N2jrng-1; Mon, 15 Apr 2024 09:15:47 -0400
X-MC-Unique: UevpvNqEP026mjK0N2jrng-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d87f4226b3so23200051fa.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 06:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713186946; x=1713791746;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vksJFxjr2JxF6E/j3OfSj8gb/pnDm6mlP4tYtGZ0egA=;
 b=vpY410DbBiOLFYbgtJAjmFw2mTGi+RWEPv0ti400T37D6B2pbrreP+1+aXAIaGOR3D
 SldoKsnxUt/rFpTGaFItaTKxRNCCfjMHuowZf3p1rJxW6teoyRpW8yztpnyoLwjb5r7L
 zpZpN6jctOra8BmWhuM4vmpcvsCzX2K9wfroeZ3w6ACKftHrqhC1M/BS2k27doZtY3Hl
 BzCcXi4tvP63wmaKPW+5q3dTZxjaaRrbZ4RJH56036NyCIFB98p12WtIVZa2qlPMhHu3
 Bgu3/4uj7b5ifd7Dg7EiiexQ8AGqJ5F/0PXy/uN30qXEl9aJe0CL9FjVlC/e09GC9Mtn
 /ghQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGZlGkEHivpEU0EOcLQezJvH7car7qUqmAv6EceAw4vtK3pJzABq8nFbrq5OpIeyCo2kbDiv80bohKVSWjByuEDNugTHk=
X-Gm-Message-State: AOJu0YwFIPP4Iv146zwhGV/zEAnJHWehf2rIyrm1QbDBN3nEKrvTHdwO
 XweL/oJ2LIek6ZtClvO+TviadEs92gIXqZqS+Y5gR4hJGAPl+N5ZPo0C5J2FyPnWVK3Z8UyyWEl
 cWbuOVmNlkhxwWcp6z01/8hCx6JqZokQUZ26vXENlnc+skwcdM/sR
X-Received: by 2002:a2e:9cd5:0:b0:2d9:fde0:86e2 with SMTP id
 g21-20020a2e9cd5000000b002d9fde086e2mr7228547ljj.15.1713186946034; 
 Mon, 15 Apr 2024 06:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSISEHk6gH0goCVA6FfpocJx02NQKz2QAhUu82FXGXXE+XZvzyolr+xJ5Pu06thAHCz+k9Jw==
X-Received: by 2002:a2e:9cd5:0:b0:2d9:fde0:86e2 with SMTP id
 g21-20020a2e9cd5000000b002d9fde086e2mr7228528ljj.15.1713186945626; 
 Mon, 15 Apr 2024 06:15:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a05600c3b1000b004182b87aaacsm8819995wms.14.2024.04.15.06.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 06:15:45 -0700 (PDT)
Message-ID: <e9b75cf0-49f4-4773-98c3-ec765c3adbb0@redhat.com>
Date: Mon, 15 Apr 2024 15:15:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] vfio: Implement get_host_iommu_info() callback
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-6-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240408081230.1030078-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

On 4/8/24 10:12, Zhenzhong Duan wrote:
> Utilize iova_ranges to calculate host IOMMU address width and
> package it in HIOD_LEGACY_INFO for vIOMMU usage.
> 
> HIOD_LEGACY_INFO will be used by both VFIO and VDPA so declare
> it in host_iommu_device.h.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/sysemu/host_iommu_device.h | 10 ++++++++++
>   hw/vfio/container.c                | 24 ++++++++++++++++++++++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> index 22ccbe3a5d..beb8be8231 100644
> --- a/include/sysemu/host_iommu_device.h
> +++ b/include/sysemu/host_iommu_device.h
> @@ -16,4 +16,14 @@ struct HostIOMMUDeviceClass {
>       int (*get_host_iommu_info)(HostIOMMUDevice *hiod, void *data, uint32_t len,
>                                  Error **errp);
>   };
> +
> +/*
> + * Define the format of host IOMMU related info that current VFIO
> + * or VDPA can privode to vIOMMU.
> + *
> + * @aw_bits: Host IOMMU address width. 0xff if no limitation.
> + */
> +typedef struct HIOD_LEGACY_INFO {

Please use CamelCase names.

> +    uint8_t aw_bits;
> +} HIOD_LEGACY_INFO;
>   #endif
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 44018ef085..ba0ad4a41b 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1143,8 +1143,32 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
>       vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
>   };
>   
> +static int hiod_legacy_vfio_get_host_iommu_info(HostIOMMUDevice *hiod,
> +                                                void *data, uint32_t len,
> +                                                Error **errp)
> +{
> +    VFIODevice *vbasedev = HIOD_LEGACY_VFIO(hiod)->vdev;
> +    /* iova_ranges is a sorted list */
> +    GList *l = g_list_last(vbasedev->bcontainer->iova_ranges);
> +    HIOD_LEGACY_INFO *info = data;
> +
> +    assert(sizeof(HIOD_LEGACY_INFO) <= len);
> +
> +    if (l) {
> +        Range *range = l->data;
> +        info->aw_bits = find_last_bit(&range->upb, BITS_PER_LONG) + 1;

There is a comment in range.h saying:

     /*
      * Do not access members directly, use the functions!

Please introduce a new helper.


Thanks,

C.



> +    } else {
> +        info->aw_bits = 0xff;
> +    }
> +
> +    return 0;
> +}
> +
>   static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
>   {
> +    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
> +
> +    hioc->get_host_iommu_info = hiod_legacy_vfio_get_host_iommu_info;
>   };
>   
>   static const TypeInfo types[] = {


