Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F79CC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE78m-0002bp-MH; Mon, 03 Jun 2024 08:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE78j-0002bP-Bn
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE78g-0000yc-6j
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717419011;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8onGgJrTXV5bK3F53cxRhBPgdJpmEbPj3pxIdMBfZ78=;
 b=g0AjmZewE6l8xBr6Jar9DceVrJ5NZubwlG1BbXdn0Pk3xkKZlxpkPcMxWJ3dVKxS1zH3uu
 8P9bsm7rJKfrtQhAJnJtn1n0UU7/3i7NEhBIgMHk5naO2/hqxmMX98S8+GMDi7y+/CBH9k
 qt/ibCorVzkmX4ikhIs+mzb7LAyXaqU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-h2D_aodjP3O27eH_qV1TPA-1; Mon, 03 Jun 2024 08:50:10 -0400
X-MC-Unique: h2D_aodjP3O27eH_qV1TPA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-795106b7c6dso48272585a.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717419010; x=1718023810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8onGgJrTXV5bK3F53cxRhBPgdJpmEbPj3pxIdMBfZ78=;
 b=cZVDtlD8N5ZXJhVHuCh6E78/sr8Z5slZD+c5mHk73oTPdpXFFJomO1qAch8sVzaqxe
 EWxIHP/FiBvgpldS+1rzk6Hls+Zeqsw1DmBL6Jc+LlZ6JI9R7qDbTqfUFsNGMm7/F7gd
 cOnGUpu4qsnEz1GRksHJAGYkLeMYv6rTlbMZIw0zGTQZoHhWhBF+GaAA6VmpD4n4po8H
 YoAsVTNwg9IegeLaeAGyCA09aBz/QdzBXJ0hOvAfKFzNWoHwAMdUwlP3+2tuCjz0UT0j
 sBHX63r5kDWI1ykf1Ta5kXoq11cSyAnci6okYE5a2bnDkFNnzItBjUwX0briNR8Kewc/
 wuBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzjRUK2k2aLWujSz34H57uPXeenzI6XrFru/yhDYuvYZXSL9kPBCFs37T08DrETS8id8g1TDv7RaogtOU1dGvk7U8RIks=
X-Gm-Message-State: AOJu0Yyiz6lorvc/KnsL9/EGIm+Xk+M4/FPG/INC12feHX5coDWr2Q0M
 Bl+QYDzX/ialvfHdDCFe7qJLEg3VHC0tBnEV6lcTFVNS5ljT8GDWHjP4gu+X5PFNaili318Do6y
 Zo7tJx3+XMYvqE5oBqzjW6DYq6CkX//mWFQGNIIH6dqyYPIeaQb2n
X-Received: by 2002:a05:620a:90d:b0:792:7d2f:156f with SMTP id
 af79cd13be357-794f5ebfe8amr813731585a.77.1717419009936; 
 Mon, 03 Jun 2024 05:50:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI3r/wrpwENTopyWo6KAoGoERtNbqVFg8l7trxCm5yZxskhtjEiqK/+8zhLEOL/wzRt0MWHg==
X-Received: by 2002:a05:620a:90d:b0:792:7d2f:156f with SMTP id
 af79cd13be357-794f5ebfe8amr813729385a.77.1717419009441; 
 Mon, 03 Jun 2024 05:50:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794f3172d94sm279945785a.99.2024.06.03.05.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:50:08 -0700 (PDT)
Message-ID: <f64ffbd9-fb34-474d-be4a-66c4c9ee223b@redhat.com>
Date: Mon, 3 Jun 2024 14:50:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/19] backends/iommufd: Introduce abstract
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD device
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-4-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240603061023.269738-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


Hi Zhenzhong,
On 6/3/24 08:10, Zhenzhong Duan wrote:
> TYPE_HOST_IOMMU_DEVICE_IOMMUFD represents a host IOMMU device under
> iommufd backend.
>
> It will have its own .get_cap() implementation.
>
> Opportunistically, add missed header to include/sysemu/iommufd.h.

I would explain why it is abstract, ie. because it is going to be
derived into VFIO or VDPA type'd device.

Besides I think I would simply squash patches 3 and 4

Thanks

Eric
>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/sysemu/iommufd.h | 16 ++++++++++++++++
>  backends/iommufd.c       | 35 ++++++++++++++++++-----------------
>  2 files changed, 34 insertions(+), 17 deletions(-)
>
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 293bfbe967..f6e6d6e1f9 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -1,9 +1,23 @@
> +/*
> + * iommufd container backend declaration
> + *
> + * Copyright (C) 2024 Intel Corporation.
> + * Copyright Red Hat, Inc. 2024
> + *
> + * Authors: Yi Liu <yi.l.liu@intel.com>
> + *          Eric Auger <eric.auger@redhat.com>
> + *          Zhenzhong Duan <zhenzhong.duan@intel.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
>  #ifndef SYSEMU_IOMMUFD_H
>  #define SYSEMU_IOMMUFD_H
>  
>  #include "qom/object.h"
>  #include "exec/hwaddr.h"
>  #include "exec/cpu-common.h"
> +#include "sysemu/host_iommu_device.h"
>  
>  #define TYPE_IOMMUFD_BACKEND "iommufd"
>  OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass, IOMMUFD_BACKEND)
> @@ -33,4 +47,6 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
>                              ram_addr_t size, void *vaddr, bool readonly);
>  int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>                                hwaddr iova, ram_addr_t size);
> +
> +#define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>  #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index c506afbdac..012f18d8d8 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -208,23 +208,24 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>      return ret;
>  }
>  
> -static const TypeInfo iommufd_backend_info = {
> -    .name = TYPE_IOMMUFD_BACKEND,
> -    .parent = TYPE_OBJECT,
> -    .instance_size = sizeof(IOMMUFDBackend),
> -    .instance_init = iommufd_backend_init,
> -    .instance_finalize = iommufd_backend_finalize,
> -    .class_size = sizeof(IOMMUFDBackendClass),
> -    .class_init = iommufd_backend_class_init,
> -    .interfaces = (InterfaceInfo[]) {
> -        { TYPE_USER_CREATABLE },
> -        { }
> +static const TypeInfo types[] = {
> +    {
> +        .name = TYPE_IOMMUFD_BACKEND,
> +        .parent = TYPE_OBJECT,
> +        .instance_size = sizeof(IOMMUFDBackend),
> +        .instance_init = iommufd_backend_init,
> +        .instance_finalize = iommufd_backend_finalize,
> +        .class_size = sizeof(IOMMUFDBackendClass),
> +        .class_init = iommufd_backend_class_init,
> +        .interfaces = (InterfaceInfo[]) {
> +            { TYPE_USER_CREATABLE },
> +            { }
> +        }
> +    }, {
> +        .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
> +        .parent = TYPE_HOST_IOMMU_DEVICE,
> +        .abstract = true,
>      }
>  };
>  
> -static void register_types(void)
> -{
> -    type_register_static(&iommufd_backend_info);
> -}
> -
> -type_init(register_types);
> +DEFINE_TYPES(types)


