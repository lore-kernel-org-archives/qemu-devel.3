Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B76C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 15:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJEJK-0004D5-79; Mon, 17 Jun 2024 11:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJEJI-0004Cm-Tu
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJEJF-0007fR-Uf
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718638217;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkAaGXfofvqHBzfysOFb+9k9FPY5mWwcbVZh5odgNa0=;
 b=E6zh8ABDVf8H8zcOVNy5yo6vfig+X65FocaCOXcjw+jXyML7dil0IdcAJQ59U4aHZe5+t7
 lhUbOEyV0iIY3Z1abOlCH+LbRwxC+QyO0VLsDcuoE4umcI91a9sOWLCrdPjdNuKlbOxz69
 95xPK3ZMexuw9SRZz8Z7scfszMvC+l0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-3OngjWJ0Mc-qETD7XOdrIg-1; Mon, 17 Jun 2024 11:30:14 -0400
X-MC-Unique: 3OngjWJ0Mc-qETD7XOdrIg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-440cfb095c1so50043801cf.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 08:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718638214; x=1719243014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gkAaGXfofvqHBzfysOFb+9k9FPY5mWwcbVZh5odgNa0=;
 b=qLIZzJuY5Xz/mzZP19hbRu3xUTmPOV/hE/tiXQKQyyMII2asMp5NQe6Bq5EleZy8J/
 1iU5q8VvSKbDtzZTxVOq2d1gecaTzL8DEkBQg7NI2uur3pwHBbpq7nVTxMqpajYk2s+U
 Y20AQ++ZNI1sOUPi5Ih6tOrhdd4HA8RyGUOgplwuDzEmAwfjtkI2pailbNvp2M28x2Gh
 11RNPsuhbZulHDtCmCid7dywfL9ygjqe1uXG2lQ1Om4Tx36belnsJZ8TDJEA8hidqN2z
 4da31G2LhVruVxVnYt+5VFIHTonrzBCgUSEGiEVgUznfp0z/KOnqTQlsXwObbOWJLzfD
 x3wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM61uxk9vCJsqdv+sNvOZOjBr6D+FXA+gIsrXL5eu7p9N7bLfKwO0FC4Ut4y8w4UwLS0NTPFNpZuRT0eOpO14oqhdAuj8=
X-Gm-Message-State: AOJu0Yx3OrXnEzkrYC8QDqY3hNGFW8sbYCZ2VlmsPoPachDfdgxgMP6C
 1izPd3uDuLG7u1g0yrDFoT7/psHnNYpqsh7jhRwvtRTJVnDHkMtdpx2STZEN6qkbKHNqCQtsUTg
 lSYJQEnGPjqQhy1SPWC/ADCL+pb9iGgUK43THcAIl6K5gf+d5eZVD
X-Received: by 2002:ac8:5e06:0:b0:441:5887:a04d with SMTP id
 d75a77b69052e-442168a91c0mr139071751cf.11.1718638213725; 
 Mon, 17 Jun 2024 08:30:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3qT+NTJtz3vqVLGsbISOePRPY0rYTyvo8QvY+LcDGcg1rMzLhD/qhtcYaniCEsiUpo9l5Eg==
X-Received: by 2002:ac8:5e06:0:b0:441:5887:a04d with SMTP id
 d75a77b69052e-442168a91c0mr139071411cf.11.1718638213343; 
 Mon, 17 Jun 2024 08:30:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-441ef3d89c7sm47256291cf.20.2024.06.17.08.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 08:30:12 -0700 (PDT)
Message-ID: <fe470f59-65b3-4fec-a019-99b8d693ab21@redhat.com>
Date: Mon, 17 Jun 2024 17:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] vfio/container: Move vfio_container_destroy() to
 an instance_finalize() handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-18-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240617063409.34393-18-clg@redhat.com>
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

Hi Cédric,

On 6/17/24 08:34, Cédric Le Goater wrote:
> vfio_container_destroy() clears the resources allocated
> VFIOContainerBase object. Now that VFIOContainerBase is a QOM object,
> add an instance_finalize() handler to do the cleanup. It will be
> called through object_unref().
>
> Suggested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>  include/hw/vfio/vfio-container-base.h | 3 ---
>  hw/vfio/container-base.c              | 4 +++-
>  hw/vfio/container.c                   | 2 --
>  hw/vfio/iommufd.c                     | 1 -
>  4 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 6242a62771caa8cf19440a53ad6f4db862ca12d7..419e45ee7a5ac960dae4a993127fc9ee66d48db2 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -86,9 +86,6 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>  int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                     VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>  
> -void vfio_container_destroy(VFIOContainerBase *bcontainer);
> -
> -
>  #define TYPE_VFIO_IOMMU "vfio-iommu"
>  #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
>  #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 970ae2356a92f87df44e1dd58ff8c67045a24ef1..50b1664f89a8192cf4021498e59f2a92cd2f6e89 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -83,8 +83,9 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                                 errp);
>  }
>  
> -void vfio_container_destroy(VFIOContainerBase *bcontainer)
> +static void vfio_container_instance_finalize(Object *obj)
>  {
> +    VFIOContainerBase *bcontainer = VFIO_IOMMU(obj);
>      VFIOGuestIOMMU *giommu, *tmp;
>  
>      QLIST_REMOVE(bcontainer, next);
> @@ -116,6 +117,7 @@ static const TypeInfo types[] = {
>          .name = TYPE_VFIO_IOMMU,
>          .parent = TYPE_OBJECT,
>          .instance_init = vfio_container_instance_init,
> +        .instance_finalize = vfio_container_instance_finalize,
>          .instance_size = sizeof(VFIOContainerBase),
>          .class_size = sizeof(VFIOIOMMUClass),
>          .abstract = true,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 45123acbdd6a681f4ce7cae7aa2509100ea225ab..2e7ecdf10edc4d84963a45ae9507096965da64fc 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -712,8 +712,6 @@ static void vfio_disconnect_container(VFIOGroup *group)
>      if (QLIST_EMPTY(&container->group_list)) {
>          VFIOAddressSpace *space = bcontainer->space;
>  
> -        vfio_container_destroy(bcontainer);
> -
>          trace_vfio_disconnect_container(container->fd);
>          vfio_cpr_unregister_container(bcontainer);
>          close(container->fd);
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 09b71a6617807c621275c74b924cfd39eb643961..c2f158e60386502eef267769ac9bce1effb67033 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -237,7 +237,6 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
>          return;
>      }
>      memory_listener_unregister(&bcontainer->listener);
> -    vfio_container_destroy(bcontainer);
>      iommufd_backend_free_id(container->be, container->ioas_id);
>      object_unref(container);
>  }


