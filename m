Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EBFC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 12:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMRzQ-0002XW-Ny; Wed, 26 Jun 2024 08:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sMRzP-0002X5-2w
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sMRzB-0000Yd-57
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719405772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08m5ugK9T+OFvszkVn2IlOhibxzPIICM9l31TAR/N7E=;
 b=d+66i6ycAMvftdNtw1hKgXsF7suYBIgQ1Sh7XF1OEc2F6wBK8dUp1svlVSg40Ibih1045j
 7m55Jg+Gxw2nGMhmw3B2N9S+zU41r12HCfDlIeMvrstaTV9/kNpIjF6dDXwhMZRpUBLje8
 u2yprOwEsrflmRPcPdI0s2mUMSoWLpc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-40bxhaENO96bJu8ClLJwBg-1; Wed, 26 Jun 2024 08:42:50 -0400
X-MC-Unique: 40bxhaENO96bJu8ClLJwBg-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-700d3fdd40aso504196a34.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 05:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719405769; x=1720010569;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=08m5ugK9T+OFvszkVn2IlOhibxzPIICM9l31TAR/N7E=;
 b=RwMxQbmJdu4QuY+l8195PYjfVtva6rm3+rNmhWTX/AkSf6gewxYPTaOm/+kmpikT84
 irfvd2p9UfaACXvSLHtQfNfPPCsIU7dFQz6SGzKpGcIb7/Zo0wjfRzJGUoaTm7io8cC9
 1sPP2AYrrTuOmfM+6gDktKoddxrQnRXqwfUDEAb9I/HTEozuEkoE+D9Uw0U+6KmJqJVx
 TyfQmyFr5BpJjUFD3T1MJZ0PZK09AEagJknHgaSFfZVqArdP8iACq3dtmjCXozuJG6yA
 Vi8+LC4pwQTFncVKCVD3aqMGI+LrYxabBBju1CrImwndYvlAxs/ebAbgt7tNzrtM1W0b
 rsIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd9zlsqTrJkpf5SjS7+vnUgH/BaiiAAJ7/ZhbrUJ5CBDGiEUgZREWdhT87ic0O2djiTgljR0RiFWfL/vfSG00b6i+kvCE=
X-Gm-Message-State: AOJu0Yw3u3UbREhF+NS4EZWFTD+jR6HQKeSFQ7MjO2Eq/iC49s1Xorcd
 tTy3K2Ox0UP514gWlpXLPpo1QgV4Pt2wBhcRcx8SUO1HbBpLS0HVkjAzOky0AnucjntVUvebrQy
 myeZgF3XtpYvUYQ3D4qpgBGNNQpwVMNx0ATB2wBdR3mw6kh7ShfEf
X-Received: by 2002:a05:6830:161a:b0:700:d506:cfe9 with SMTP id
 46e09a7af769-700d506d7aamr887970a34.19.1719405769375; 
 Wed, 26 Jun 2024 05:42:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3SeI3YwbPyaQb8qXBNt2XLPpJ2isaQFyD/IcFPDTNimfMdn6u7eGC7qhEuyiDuhtF7liCRA==
X-Received: by 2002:a05:6830:161a:b0:700:d506:cfe9 with SMTP id
 46e09a7af769-700d506d7aamr887954a34.19.1719405769019; 
 Wed, 26 Jun 2024 05:42:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79c0afadd93sm124036085a.92.2024.06.26.05.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 05:42:48 -0700 (PDT)
Message-ID: <ec68e91f-898f-418e-89bc-24c6223c262d@redhat.com>
Date: Wed, 26 Jun 2024 14:42:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] vfio-container-base: Introduce
 vfio_container_get_iova_ranges() helper
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org, yanghliu@redhat.com,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com
References: <20240626082727.1278530-1-eric.auger@redhat.com>
 <20240626082727.1278530-3-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240626082727.1278530-3-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
> Introduce vfio_container_get_iova_ranges() to retrieve the usable
> IOVA regions of the base container and use it in the Host IOMMU
> device implementations of get_iova_ranges() callback.
> 
> We also fix a UAF bug as the list was shallow copied while
> g_list_free_full() was used both on the single call site, in
> virtio_iommu_set_iommu_device() but also in
> vfio_container_instance_finalize(). Instead use g_list_copy_deep.
> 
> Fixes: cf2647a76e ("virtio-iommu: Compute host reserved regions")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Cédric Le Goater <clg@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-container-base.h |  2 ++
>   hw/vfio/container-base.c              | 15 +++++++++++++++
>   hw/vfio/container.c                   |  8 +-------
>   hw/vfio/iommufd.c                     |  8 +-------
>   4 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 419e45ee7a..45d7c40fce 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -86,6 +86,8 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                      VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>   
> +GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer);
> +
>   #define TYPE_VFIO_IOMMU "vfio-iommu"
>   #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
>   #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 50b1664f89..809b157674 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -83,6 +83,21 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                                  errp);
>   }
>   
> +static gpointer copy_iova_range(gconstpointer src, gpointer data)
> +{
> +     Range *source = (Range *)src;
> +     Range *dest = g_new(Range, 1);
> +
> +     range_set_bounds(dest, range_lob(source), range_upb(source));
> +     return dest;
> +}
> +
> +GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer)
> +{
> +    assert(bcontainer);
> +    return g_list_copy_deep(bcontainer->iova_ranges, copy_iova_range, NULL);
> +}
> +
>   static void vfio_container_instance_finalize(Object *obj)
>   {
>       VFIOContainerBase *bcontainer = VFIO_IOMMU(obj);
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 2e7ecdf10e..2ad57cd845 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1169,15 +1169,9 @@ static GList *
>   hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
>   {
>       VFIODevice *vdev = hiod->agent;
> -    GList *l = NULL;
>   
>       g_assert(vdev);
> -
> -    if (vdev->bcontainer) {
> -        l = g_list_copy(vdev->bcontainer->iova_ranges);
> -    }
> -
> -    return l;
> +    return vfio_container_get_iova_ranges(vdev->bcontainer);
>   }
>   
>   static void vfio_iommu_legacy_instance_init(Object *obj)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index c2f158e603..890d8d6a38 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -647,15 +647,9 @@ static GList *
>   hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
>   {
>       VFIODevice *vdev = hiod->agent;
> -    GList *l = NULL;
>   
>       g_assert(vdev);
> -
> -    if (vdev->bcontainer) {
> -        l = g_list_copy(vdev->bcontainer->iova_ranges);
> -    }
> -
> -    return l;
> +    return vfio_container_get_iova_ranges(vdev->bcontainer);
>   }
>   
>   static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)


