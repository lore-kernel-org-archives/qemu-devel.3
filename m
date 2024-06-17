Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C60C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 15:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJEHT-0002oP-El; Mon, 17 Jun 2024 11:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJEHR-0002ny-Bh
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJEHP-0007Dx-Ag
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718638102;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3XeZbaSMeOWTbtV9q55FzkyfD8Uy1AVKpUG0GQmdKg=;
 b=NSWnrknDg98zPni1UtF/65fxND8CMFPk/vCxjmFed6ebZGN2SW417d4Dsk0AeT3vjyIY8W
 OooTEgSGmH8Si+sUg4o1WADS+Dj3euVBYcKX3mdf2qfmeQo8KHs1992TLWItody/WIZ0nn
 ZrjSWJdlAJd8e7slXmE+uC3XjaAnaM8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-ztBYSYCbONeI3_1Gmet-og-1; Mon, 17 Jun 2024 11:28:20 -0400
X-MC-Unique: ztBYSYCbONeI3_1Gmet-og-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-43fe401dd5aso50524801cf.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 08:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718638100; x=1719242900;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S3XeZbaSMeOWTbtV9q55FzkyfD8Uy1AVKpUG0GQmdKg=;
 b=CQuQO7sOZCEJAr8P7DxFdPv6EMnZaKqc7aUwIfQJwxUx3dOKRVmkXaiJk8PEhVfg8/
 EzXlOxSB7adNi3/sGIhx9qSOBr9pd/q5LMCoUrUGKHTlsgZ8nUNiHoc74qK+0tQE16u5
 mlJbDuqWa9mPVTNVoM28Pohdny+3z/FVd5TCFiLc9jvB28M1m5TCIq4aVYqnDQDyChlo
 y9mQgcxsfvQUB6EH5+H1Csc+IX5xD1fqGpWQxPO+mrfLfUGL1e74Bb5ddGjfT3JC2SFa
 rmeQWC1IUeEgAlIfB+HM6AgKZiGhbQf0E3yLz6SKpfWTENm75hF43L9ipHB5mL5H462s
 1ONw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPQ4ZLYn2wo95mRUg6HUwtHhEGyQ9008fmSx8nerwSzvgUU8x+6NMjA8D/BBtCARkJ2EyIhhIn2GICpdpZ5KkbcE1/ySw=
X-Gm-Message-State: AOJu0YwUcnO38qsCChOwX/SBBhC5hJHEgih6KlREiegE2n6ThZfH43+z
 grimsxIGmPNorgrxl9QBK1MPm6lFZrtgkEcxZFs+EtHp3v/jsFyxOHJW+L8uEtgNhtYaxIdxo+q
 ghEojmbOzfSmgdMTAP1pP8YMuwpexUpH1J6gBo9GWtB4+ZZJ5/dxj
X-Received: by 2002:a05:622a:15cd:b0:43a:cc5d:35b5 with SMTP id
 d75a77b69052e-442168b9f48mr100359941cf.22.1718638099804; 
 Mon, 17 Jun 2024 08:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3DvPTxR+A40q2xK7BU3nLDko4LGKA86+E0ypo/B8AQxiSztmAgBKpXzrv93sU4vexRi68iQ==
X-Received: by 2002:a05:622a:15cd:b0:43a:cc5d:35b5 with SMTP id
 d75a77b69052e-442168b9f48mr100359761cf.22.1718638099359; 
 Mon, 17 Jun 2024 08:28:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-441ef3d89c7sm47256291cf.20.2024.06.17.08.28.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 08:28:18 -0700 (PDT)
Message-ID: <622cbae3-d37f-4620-ba69-d65b773bff42@redhat.com>
Date: Mon, 17 Jun 2024 17:28:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/17] vfio/container: Remove vfio_container_init()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-16-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240617063409.34393-16-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/17/24 08:34, Cédric Le Goater wrote:
> It's now empty.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/hw/vfio/vfio-container-base.h | 2 --
>  hw/vfio/container-base.c              | 5 -----
>  hw/vfio/container.c                   | 3 ---
>  hw/vfio/iommufd.c                     | 1 -
>  4 files changed, 11 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 6b57cd8e7f5d7d2817f6e3b96ce4566d2630bb12..6242a62771caa8cf19440a53ad6f4db862ca12d7 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -86,8 +86,6 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>  int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                     VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>  
> -void vfio_container_init(VFIOContainerBase *bcontainer,
> -                         const VFIOIOMMUClass *ops);
>  void vfio_container_destroy(VFIOContainerBase *bcontainer);
>  
>  
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 24669d4d7472f49ac3adf2618a32bf7d82c5c344..970ae2356a92f87df44e1dd58ff8c67045a24ef1 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -83,11 +83,6 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                                 errp);
>  }
>  
> -void vfio_container_init(VFIOContainerBase *bcontainer,
> -                         const VFIOIOMMUClass *ops)
> -{
> -}
> -
>  void vfio_container_destroy(VFIOContainerBase *bcontainer)
>  {
>      VFIOGuestIOMMU *giommu, *tmp;
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index a2f5fbad00cd228e27a47df5cd683dbb34296113..3f2032d5c496de078c277ebacc49d7db89f4cc65 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -419,7 +419,6 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>                                              Error **errp)
>  {
>      int iommu_type;
> -    const VFIOIOMMUClass *vioc;
>      const char *vioc_name;
>      VFIOContainer *container;
>  
> @@ -433,12 +432,10 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>      }
>  
>      vioc_name = vfio_get_iommu_class_name(iommu_type);
> -    vioc = VFIO_IOMMU_CLASS(object_class_by_name(vioc_name));
>  
>      container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
>      container->fd = fd;
>      container->iommu_type = iommu_type;
> -    vfio_container_init(&container->bcontainer, vioc);
>      return container;
>  }
>  
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 7bc76f80b48ea5422e68fd4d4cb3f5bca90993f6..09b71a6617807c621275c74b924cfd39eb643961 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -357,7 +357,6 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>      container->ioas_id = ioas_id;
>  
>      bcontainer = &container->bcontainer;
> -    vfio_container_init(bcontainer, iommufd_vioc);
>      vfio_address_space_insert(space, bcontainer);
>  
>      if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {


