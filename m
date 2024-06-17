Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A937DC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 15:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJEG8-0008Se-I3; Mon, 17 Jun 2024 11:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJEG6-0008SL-MB
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJEG4-0006xC-Vu
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718638020;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmcuE/UT0JOVmE6BA03aKlXgP76GZeiwh8vE0x45aoQ=;
 b=cQPKWcaL1AQknNDeBX87DFlKmbJ1qDWAF1vQlmilSGe4fG7+OshC6AP0xnPrvjKxp4UegR
 hfV1JlCt9EIx92vcJ4rWUPu/ZlntZclvKya/Z+ljgAhooqrhe/VFdjRlu2dKqpg45d0QPI
 RcA11R4VhlqEtk71ScQDIIgtYdxyQgs=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-cI2_nH-SPlGtz4vZphs2RQ-1; Mon, 17 Jun 2024 11:26:57 -0400
X-MC-Unique: cI2_nH-SPlGtz4vZphs2RQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3d282e7887aso4169499b6e.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 08:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718638017; x=1719242817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rmcuE/UT0JOVmE6BA03aKlXgP76GZeiwh8vE0x45aoQ=;
 b=OdZOKMja0kImqLXNMchxOJHDUv03wezR2oLZ26GGVIM2WR3sq/p80h+QgkI2vtGOkQ
 V4Do6tguH51CQF/tNQKUvjxxmb8ypzXfA5RAdDHVM7KkG65xQTG0yC4YNVqu1RiIh417
 whwArT2gngVJABW0MeOf7+OAGKplFowdTh8emzHDWj5r4lkxRpxvdV/KUh7NHAtTvdpX
 OjY1s6dWHmmMjUFI5GZA/0PIoJ5JDa9Izu42JxGWkj+oCWVur45cy+yIJSZkBoZjEmhs
 aoYgpiAhGClAk7O1wYHaLEjDBwczkRmwW4HfowNyCle7LVWK2K9uoA0KOVGQyS6k0W6v
 LWuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKAJvvTPeDIQVFXSZCP1/MzNUeYRido4X3wQu7Ou4q6jZadOKFg9F/Lk+/NWjfs7k1gxwfhPMJeBvVIVmw7wrA9tC8490=
X-Gm-Message-State: AOJu0Yyf8OlBB+hccVysPa6tZrqArljkxuxr9RfWj/ABXg35O0AQk8gF
 dxNBpeEvJIUHsq98wRFnqPUQjYBHKFbLC81ixmJ/oeK77h1R1pZSUBPXYSUdCRmDw3ZTBDGGDrh
 tx6UmYr6om1n9J6OyYUFNrKU75yAPxBdtFgFIP8moy723+WU0imOG
X-Received: by 2002:a05:6808:10cc:b0:3d2:2a2a:40d5 with SMTP id
 5614622812f47-3d24e9085f2mr13105199b6e.34.1718638017069; 
 Mon, 17 Jun 2024 08:26:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyiAWMFLLL4xNiWIeH2hnVX0jTrFwegJcSS9WTYk7hs5UuR67l4A+BPYtFYI2990Esq1rx6g==
X-Received: by 2002:a05:6808:10cc:b0:3d2:2a2a:40d5 with SMTP id
 5614622812f47-3d24e9085f2mr13105179b6e.34.1718638016746; 
 Mon, 17 Jun 2024 08:26:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-441ef3d89c7sm47256291cf.20.2024.06.17.08.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 08:26:56 -0700 (PDT)
Message-ID: <0c1c4c1a-d950-4b9f-a5a3-e2d11cd676ec@redhat.com>
Date: Mon, 17 Jun 2024 17:26:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/17] vfio/container: Switch to QOM
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-13-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240617063409.34393-13-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
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
> Instead of allocating the container struct, create a QOM object of the
> appropriate type.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric

> ---
>  hw/vfio/container.c | 6 +++---
>  hw/vfio/iommufd.c   | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 3ae52530a9b500bd53ec9f9e66c73253d97c9aba..ff3a6831da83c0fe11060cd57918c4d87b10197c 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -435,7 +435,7 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>      vioc_name = vfio_get_iommu_class_name(iommu_type);
>      vioc = VFIO_IOMMU_CLASS(object_class_by_name(vioc_name));
>  
> -    container = g_malloc0(sizeof(*container));
> +    container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
>      container->fd = fd;
>      container->iommu_type = iommu_type;
>      vfio_container_init(&container->bcontainer, vioc);
> @@ -674,7 +674,7 @@ unregister_container_exit:
>      vfio_cpr_unregister_container(bcontainer);
>  
>  free_container_exit:
> -    g_free(container);
> +    object_unref(container);
>  
>  close_fd_exit:
>      close(fd);
> @@ -718,7 +718,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>          trace_vfio_disconnect_container(container->fd);
>          vfio_cpr_unregister_container(bcontainer);
>          close(container->fd);
> -        g_free(container);
> +        object_unref(container);
>  
>          vfio_put_address_space(space);
>      }
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 3e9d642034c2d2234ea701952c94a78ab32e9147..d59df858407f3cadb9405386ad673c99cdad61d0 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -239,7 +239,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
>      memory_listener_unregister(&bcontainer->listener);
>      vfio_container_destroy(bcontainer);
>      iommufd_backend_free_id(container->be, container->ioas_id);
> -    g_free(container);
> +    object_unref(container);
>  }
>  
>  static int iommufd_cdev_ram_block_discard_disable(bool state)
> @@ -352,7 +352,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>  
>      trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd->fd, ioas_id);
>  
> -    container = g_malloc0(sizeof(*container));
> +    container = VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>      container->be = vbasedev->iommufd;
>      container->ioas_id = ioas_id;
>  


