Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B21C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jzV-0004as-E5; Tue, 30 Apr 2024 05:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1jzO-0004Zv-5I
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:41:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1jzM-0005t9-Fl
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714470086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVxdtptPhaXvdA5cUFAh+H+Sz0QkNwx/0vKjtoz67sM=;
 b=cYCiv5YdFp7qit+m+Gi/2kN6iIzF0E5NaYKpvEkiGloztkNmuUDAZgaRn/C1rBtzn+J9Bj
 E4HZBwTIlAmWcVspfsAvIvbPkBuxmA8LVHTUEht2/0NxkNfemKv1shutUaihtDuHqJGRjj
 4QHBZZ0BeqvyyK6g2XDBXSVckUcew/U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-_fSrMQohMxGsyZO_038uQQ-1; Tue, 30 Apr 2024 05:41:23 -0400
X-MC-Unique: _fSrMQohMxGsyZO_038uQQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5704900f94fso3478081a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 02:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714470082; x=1715074882;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FVxdtptPhaXvdA5cUFAh+H+Sz0QkNwx/0vKjtoz67sM=;
 b=KZAHt7nhxqrsUzZ1iZDj1emujz56PN+7XBfrPsyW4ON4FNZtdQFK0mI+55bNPYbsVN
 S5hPbp0uHma1MuHm5lmszmtGmQXzGemb0dMJ9/lD5e/AxMd3S3Ph7m8QlYmluXTvwBOV
 zOAaPsGFIt1lft2g/xizLTSZq6LZR0TjfwV3TVPcxR7w82DySBjh++2XKutCF5RmHCc4
 xd0uvCGLtfUUnNhB0e/5L4yBR9eX//AHV0WQpGmPZ2dvvbVKo4hlflLDsszslpUPOdNF
 GIYjkqA/HcfBxOwLVREROwst1pFx/he+rQ3P0j2fayFXDdR1fooVNSkkghQtsbhlpOh6
 foOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0Se5RPA9+vioqHVrXgN1V4pRXyZCzBydy3+jaws4BVAR8aQviUL0hmT9wicwMVXg8/eHpAe1ntt+pM6IvogFxYTtaabU=
X-Gm-Message-State: AOJu0YyUunP/egxLpGeC7AZkfHjWHjR05c+valRdCMHGTWptrn7K4QcA
 rPs67a3jNnWxxMWXrnZEDm6HuIbbBq9DoOjPM2FMx1Tea1qdHxms/e0IUw0aSkEFWDACVdEZzZU
 wQaSLng+x+PEudhzVBKgI0F4UyGYfGEUfiLWW0TrCTr5TxMhNtWx4AReyJw4q
X-Received: by 2002:a17:906:4115:b0:a52:58a7:11cf with SMTP id
 j21-20020a170906411500b00a5258a711cfmr10344097ejk.2.1714470081914; 
 Tue, 30 Apr 2024 02:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQSz/VR3C/4kvvED5Radc7CcO+S3d+Zre6dWW9JYBr/65UNfjfTOhPes/c02CcqSOqL+/Ztg==
X-Received: by 2002:a17:906:4115:b0:a52:58a7:11cf with SMTP id
 j21-20020a170906411500b00a5258a711cfmr10344080ejk.2.1714470081535; 
 Tue, 30 Apr 2024 02:41:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 q23-20020a170906771700b00a590f9c1db3sm1169503ejm.150.2024.04.30.02.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 02:41:20 -0700 (PDT)
Message-ID: <6a24df9b-9851-4304-b962-a98a65758a00@redhat.com>
Date: Tue, 30 Apr 2024 11:41:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH v3 07/19] vfio/container: Implement
 HostIOMMUDeviceClass::realize() handler
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-8-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
In-Reply-To: <20240429065046.3688701-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On 4/29/24 08:50, Zhenzhong Duan wrote:
> Utilize range_get_last_bit() to get host IOMMU address width and
> package it in HostIOMMUDeviceCaps for query with .check_cap().
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/container.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 3b6826996a..863eec3943 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1143,6 +1143,34 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
>       vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
>   };
>   
> +static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
> +                                     Error **errp)
> +{
> +    VFIODevice *vdev = opaque;
> +    /* iova_ranges is a sorted list */
> +    GList *l = g_list_last(vdev->bcontainer->iova_ranges);
> +
> +    /* There is no VFIO uAPI to query host platform IOMMU type */
> +    hiod->caps.type = IOMMU_HW_INFO_TYPE_NONE;
> +    HOST_IOMMU_DEVICE_IOMMUFD_VFIO(hiod)->vdev = vdev;

cast uses the wrong type and I am not sure the ->vdev is useful.


Thanks,

C.

  
> +
> +    if (l) {
> +        Range *range = l->data;
> +        hiod->caps.aw_bits = range_get_last_bit(range) + 1;
> +    } else {
> +        hiod->caps.aw_bits = 0xff;
> +    }
> +
> +    return true;
> +}
> +
> +static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
> +{
> +    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
> +
> +    hioc->realize = hiod_legacy_vfio_realize;
> +};
> +
>   static const TypeInfo types[] = {
>       {
>           .name = TYPE_VFIO_IOMMU_LEGACY,
> @@ -1152,6 +1180,7 @@ static const TypeInfo types[] = {
>           .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
>           .parent = TYPE_HOST_IOMMU_DEVICE,
>           .instance_size = sizeof(HostIOMMUDeviceLegacyVFIO),
> +        .class_init = hiod_legacy_vfio_class_init,
>       }
>   };
>   


