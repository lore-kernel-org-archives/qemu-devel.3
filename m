Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0A1C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3x7N-0001zp-8Z; Mon, 06 May 2024 08:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s3x7K-0001zU-QK
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s3x7I-0000NL-T2
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714997207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9C6FQ+bzUf15ctYtAuf3nSeEPdMzu1pXVkHwqZduYtI=;
 b=FBzpnYdhdgol4mA8cGajf8NG6zsYW5yJ4LBXu7uaqWeU0aV2kw/y01oeuO0alvycexEuRU
 iiUWaEKGuYoZtexzYTqJTdj2fDRfij1JmXXYHOv1LMHf9ukTAu4CKhAFTbbD1c/fklEDI/
 X4JKHxUaAW+a6REPlqIMt7Lr71suQUs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-pkVwAEryMtaNHhy27E85ag-1; Mon, 06 May 2024 08:06:43 -0400
X-MC-Unique: pkVwAEryMtaNHhy27E85ag-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-51f60b1644cso1608593e87.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714997202; x=1715602002;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9C6FQ+bzUf15ctYtAuf3nSeEPdMzu1pXVkHwqZduYtI=;
 b=DrpTJ+zy/3cFsjfTD2GbKQdCzMi2JJzPBs32xPmHGjEUxkj8ZQ8hTVDwRD28JEJWqY
 CqiraXaFA+wuzGDPyevcYWlWGxPphTvbssraGOwwqeI8YP+6Gdh83tuMp1ug4KuvEydq
 DUTGmVGlna3fPigDPZBja/kEPaXGvGjrboU/HHWrDaaX7NSdlTAb96nOSj9kFX69Yma7
 treoxbFdSfdE67dH0bhj9GE7CwDBOytjgl4HD7Agf21fmnDzzW4Ep64pBdu4eerF1wab
 NhuAV+2xJisfULqq8j9FJUGyZhQyDgelKhK4CdiyOyMzJJqbt4qK+jEuzldG52i8WD0U
 c6Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGH359qX29RHJwLlnHQc1kV6w7/ThIDTpFIOhmdP2kcDMqOOOuUbkZkx2ikJJtxsYYu+Ps+7Gvrhdn46PLBFfiW8ubCRU=
X-Gm-Message-State: AOJu0YxdxPg4t0HUWj6ZYll38vhRK/mG1d4azZnxkW13otXH7/dQDBH5
 /euW03XYgtZsMMWU/4a9pWd9JELbN3+4VUOhK6hrGtFgi1RbuAeWtPN22+BUpdEOXvAyc+k5kGX
 OYmmhKpAKAdB6g8ycwbTXrZKX74OFjAYiGEFo2F4emC3TgCycKJwQ
X-Received: by 2002:a19:ac48:0:b0:51e:e754:27dd with SMTP id
 r8-20020a19ac48000000b0051ee75427ddmr7283428lfc.41.1714997202424; 
 Mon, 06 May 2024 05:06:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3mYBO8PyvyQW/Keyy0au60P34z8QQlXBHfAHO/erLeNzxZQ4oXx84OJZRpSrun2roVkpGkQ==
X-Received: by 2002:a19:ac48:0:b0:51e:e754:27dd with SMTP id
 r8-20020a19ac48000000b0051ee75427ddmr7283409lfc.41.1714997201877; 
 Mon, 06 May 2024 05:06:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0?
 ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a05600c34c100b0041c130520f3sm19570306wmq.6.2024.05.06.05.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 05:06:41 -0700 (PDT)
Message-ID: <f470f4cb-285e-43d7-907e-d4e75d776f99@redhat.com>
Date: Mon, 6 May 2024 14:06:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] vfio: Make VFIOIOMMUClass::add_window() and its
 wrapper return bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20240506083352.4037226-1-zhenzhong.duan@intel.com>
 <20240506083352.4037226-4-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240506083352.4037226-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On 5/6/24 10:33, Zhenzhong Duan wrote:
> Make VFIOIOMMUClass::add_window() and its wrapper function
> vfio_container_add_section_window() return bool.
> 
> This is to follow the coding standand to return bool if 'Error **'
> is used to pass error.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

One comment below for the spapr maintainers,


> ---
>   include/hw/vfio/vfio-container-base.h | 12 ++++++------
>   hw/vfio/common.c                      |  2 +-
>   hw/vfio/container-base.c              |  8 ++++----
>   hw/vfio/spapr.c                       | 16 ++++++++--------
>   4 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 68539e3bed..e96cda78c8 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -76,9 +76,9 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>                                hwaddr iova, ram_addr_t size,
>                                IOMMUTLBEntry *iotlb);
> -int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
> -                                      MemoryRegionSection *section,
> -                                      Error **errp);
> +bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
> +                                       MemoryRegionSection *section,
> +                                       Error **errp);
>   void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>                                          MemoryRegionSection *section);
>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
> @@ -131,9 +131,9 @@ struct VFIOIOMMUClass {
>       int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);
>   
>       /* SPAPR specific */
> -    int (*add_window)(VFIOContainerBase *bcontainer,
> -                      MemoryRegionSection *section,
> -                      Error **errp);
> +    bool (*add_window)(VFIOContainerBase *bcontainer,
> +                       MemoryRegionSection *section,
> +                       Error **errp);
>       void (*del_window)(VFIOContainerBase *bcontainer,
>                          MemoryRegionSection *section);
>       void (*release)(VFIOContainerBase *bcontainer);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 890d30910e..9f1f2e19f7 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -585,7 +585,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>           return;
>       }
>   
> -    if (vfio_container_add_section_window(bcontainer, section, &err)) {
> +    if (!vfio_container_add_section_window(bcontainer, section, &err)) {
>           goto fail;
>       }
>   
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 913ae49077..98d71b3144 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -31,12 +31,12 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>       return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
>   }
>   
> -int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
> -                                      MemoryRegionSection *section,
> -                                      Error **errp)
> +bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
> +                                       MemoryRegionSection *section,
> +                                       Error **errp)
>   {
>       if (!bcontainer->ops->add_window) {
> -        return 0;
> +        return true;
>       }
>   
>       return bcontainer->ops->add_window(bcontainer, section, errp);
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 148b257c9c..47b040f1bc 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -323,7 +323,7 @@ static int vfio_spapr_create_window(VFIOContainer *container,
>       return 0;
>   }
>   
> -static int
> +static bool
>   vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
>                                           MemoryRegionSection *section,
>                                           Error **errp)
> @@ -351,13 +351,13 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
>               error_setg(errp, "Container %p can't map guest IOVA region"
>                          " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container,
>                          iova, end);
> -            return -EINVAL;
> +            return false;
>           }
> -        return 0;
> +        return true;
>       }
>   
>       if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
> -        return 0;
> +        return true;
>       }
>   
>       /* For now intersections are not allowed, we may relax this later */
> @@ -373,14 +373,14 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
>                   section->offset_within_address_space +
>                       int128_get64(section->size) - 1,
>                   hostwin->min_iova, hostwin->max_iova);
> -            return -EINVAL;
> +            return false;
>           }
>       }
>   
>       ret = vfio_spapr_create_window(container, section, &pgsize);

vfio_spapr_create_window() contains several calls to error_report() which
would be good to replace with error_setg().


Thanks,

C.




>       if (ret) {
>           error_setg_errno(errp, -ret, "Failed to create SPAPR window");
> -        return ret;
> +        return false;
>       }
>   
>       vfio_host_win_add(scontainer, section->offset_within_address_space,
> @@ -406,14 +406,14 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
>                                        "vfio: failed GROUP_SET_SPAPR_TCE for "
>                                        "KVM VFIO device %d and group fd %d",
>                                        param.tablefd, param.groupfd);
> -                    return -errno;
> +                    return false;
>                   }
>                   trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
>               }
>           }
>       }
>   #endif
> -    return 0;
> +    return true;
>   }
>   
>   static void


