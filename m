Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF85FC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 14:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJDVo-00043a-7M; Mon, 17 Jun 2024 10:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJDVl-000421-V8
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJDVk-0006Zd-AP
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718635147;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3L/APnsRXZiMTFb0aCFi3dMJPQFBlQcV4SCocPoqbuE=;
 b=ZWFh6FsrfB8LEAOGe16Jb0obIbwzVlxk/HAqmCUsoagspCwvMGYc+4jNgcna0J16fXKkTz
 DI808oUVkj9VeKivhYtbVZkc98lNC5ZybhzwZVyiHIchj3oLfEfARXblTOz3rpajQ7NnIL
 9dyf3gQY7sYf049Skz6IU5tRwbyTp2k=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-R2OO1W6iM4exz_alQErW9A-1; Mon, 17 Jun 2024 10:39:06 -0400
X-MC-Unique: R2OO1W6iM4exz_alQErW9A-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b062eba328so57588476d6.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 07:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718635146; x=1719239946;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3L/APnsRXZiMTFb0aCFi3dMJPQFBlQcV4SCocPoqbuE=;
 b=oyb6mpRt/K958CKx5T6Zd2PDWJV4q0AlBbyXJDH0j/OLJWJwavRbDKivXxdXAihZsw
 X47uwDaTYkY6ZSoAereAN5tAqk0dp6FcB+2taq/Pfm29Z4x0SffgSjSY65VOKd2aoYk8
 FeXX+qhRN7fLCrcn8TtkCsShttu0WMf6d6x55Ro5sgTeSa0fCDamZn95KLdsNqElOkrC
 HLgLym6CLR9Vx4WAixYfOqgha+BJVMGnylNJq6Tfctmzb7F5tI8hgmvXpyRBRLU0BjzQ
 0GAQg9fSBmgHPrAhFHuGAadwDwhlu2Ll4sAjZWAcy4ZwBSf1+My54+hwifcpypN489SF
 tTxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW22wqx9zytp0f+WWjARcYpw4131u+6t4iDmhVrwr6YRM+RieO+jPyeyWAAj056SxGc6HIZ7Zplre/LO5otyqIZaWuOQL8=
X-Gm-Message-State: AOJu0Yy49wZqreALSLiiC4TOv5dHObo82YtD1svCSV4Js7Y4Cp780HPG
 kAdPhWVc0+z1tZqyL11lrHWwfDQdx5RbNBlvWSM+6u2uDD70iimrtnBHi+HrlPzSS56REp8z14m
 CF9RMAX1P9NxA4Wv4Cxwi0pe5Z6zvyYuioKvVW3IawU6t8QTe1URG
X-Received: by 2002:ad4:4051:0:b0:6b0:7b29:da8a with SMTP id
 6a1803df08f44-6b2afd9351bmr100717226d6.63.1718635145988; 
 Mon, 17 Jun 2024 07:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfiacAdkQTx61APkIepXHC1q/50PVR/dyOIJg1abIWGQA8dsFh/HgNKi9c6mrsvc2zwu96rg==
X-Received: by 2002:ad4:4051:0:b0:6b0:7b29:da8a with SMTP id
 6a1803df08f44-6b2afd9351bmr100716966d6.63.1718635145320; 
 Mon, 17 Jun 2024 07:39:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5eb49a8sm56124576d6.90.2024.06.17.07.39.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 07:39:04 -0700 (PDT)
Message-ID: <6063cd73-1b0e-4d24-8f65-135df4145d29@redhat.com>
Date: Mon, 17 Jun 2024 16:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/17] vfio/container: Discover IOMMU type before
 creating the container
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-11-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240617063409.34393-11-clg@redhat.com>
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
> Since the QEMU struct type representing the VFIO container is deduced
> from the IOMMU type exposed by the host, this type should be well
> defined *before* creating the container struct. This will be necessary
> to instantiate a QOM object of the correct type in future changes.
>
> Rework vfio_set_iommu() to extract the part doing the container
> initialization and move it under vfio_create_container().
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/container.c | 47 ++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
>
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index a8691942791006f44f7a3c34b32c67ca51766182..31bdc46a96d1626b237227a25007957e1d472757 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -389,54 +389,56 @@ static const char *vfio_get_iommu_class_name(int iommu_type)
>      };
>  }
>  
> -static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
> -                           Error **errp)
> +static bool vfio_set_iommu(int container_fd, int group_fd,
> +                           int *iommu_type, Error **errp)
>  {
> -    int iommu_type;
> -    const VFIOIOMMUClass *vioc;
> -    const char *vioc_name;
> -
> -    iommu_type = vfio_get_iommu_type(container->fd, errp);
> -    if (iommu_type < 0) {
> -        return false;
> -    }
> -
> -    if (ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
> +    if (ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container_fd)) {
>          error_setg_errno(errp, errno, "Failed to set group container");
>          return false;
>      }
>  
> -    while (ioctl(container->fd, VFIO_SET_IOMMU, iommu_type)) {
> -        if (iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
> +    while (ioctl(container_fd, VFIO_SET_IOMMU, *iommu_type)) {
> +        if (*iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
>              /*
>               * On sPAPR, despite the IOMMU subdriver always advertises v1 and
>               * v2, the running platform may not support v2 and there is no
>               * way to guess it until an IOMMU group gets added to the container.
>               * So in case it fails with v2, try v1 as a fallback.
>               */
> -            iommu_type = VFIO_SPAPR_TCE_IOMMU;
> +            *iommu_type = VFIO_SPAPR_TCE_IOMMU;
>              continue;
>          }
>          error_setg_errno(errp, errno, "Failed to set iommu for container");
>          return false;
>      }
>  
> -    container->iommu_type = iommu_type;
> -
> -    vioc_name = vfio_get_iommu_class_name(iommu_type);
> -    vioc = VFIO_IOMMU_CLASS(object_class_by_name(vioc_name));
> -
> -    vfio_container_init(&container->bcontainer, vioc);
>      return true;
>  }
>  
>  static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>                                              Error **errp)
>  {
> +    int iommu_type;
> +    const VFIOIOMMUClass *vioc;
> +    const char *vioc_name;
>      VFIOContainer *container;
>  
> +    iommu_type = vfio_get_iommu_type(fd, errp);
> +    if (iommu_type < 0) {
> +        return NULL;
> +    }
> +
> +    if (!vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
> +        return NULL;
> +    }
> +
> +    vioc_name = vfio_get_iommu_class_name(iommu_type);
> +    vioc = VFIO_IOMMU_CLASS(object_class_by_name(vioc_name));
> +
>      container = g_malloc0(sizeof(*container));
>      container->fd = fd;
> +    container->iommu_type = iommu_type;
> +    vfio_container_init(&container->bcontainer, vioc);
>      return container;
>  }
>  
> @@ -618,9 +620,6 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>      if (!container) {
>          goto close_fd_exit;
>      }
> -    if (!vfio_set_iommu(container, group->fd, errp)) {
> -        goto free_container_exit;
> -    }
>      bcontainer = &container->bcontainer;
>  
>      if (!vfio_cpr_register_container(bcontainer, errp)) {


