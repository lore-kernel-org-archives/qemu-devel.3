Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADF4C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1k0A-0005VL-QX; Tue, 30 Apr 2024 05:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1jzs-0005LI-R6
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1jzq-00061D-1K
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714470117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S/Cpp2bDKCkxl6q8f+ydpWefrCWFgLs9SANUXiL2h9w=;
 b=UhiL/AjeK5UsY2jK17v3IbG1T71qjbK11lwQmeSrHSE60+nLwCb8tDTxNwmtQkP1u/q6qs
 iqpuB2pZZsRhzf9EyDyNcFLM9oO+dAS8IoZbQhalCcA3M9eMSE5t2STGtASyUubd6sc5+A
 Nso+C9usDa83c4DiL43hfnv9+06wqkU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-RBcscjUCNZ-8yOcipFKHIA-1; Tue, 30 Apr 2024 05:41:55 -0400
X-MC-Unique: RBcscjUCNZ-8yOcipFKHIA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a58bbfd44f7so264209066b.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 02:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714470114; x=1715074914;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S/Cpp2bDKCkxl6q8f+ydpWefrCWFgLs9SANUXiL2h9w=;
 b=Y2wDeh6z71c8FBre+5gtDMDY67jzEKgbUuqjb5cxuZH9ZxexhYdQmy05t76RwONXf0
 PeZJtPlKMcn6pDQRJAKH6DkS8X2CPuXBNA1SppG4KYybiRQgv6Ea3N821zuRPUC+rdXG
 hr+mi85XgOmkuRWEKwrJ8wZptex4XBD8jfSJTMtQ3HPQZ+QbS2hTK7oxIbj8h1I+vL3H
 v0a8iUzyiDNevpOr/RaWhIbBie9u2oGzcREZeXt0YjklRpPRio/tP9RndgiUMQWfb80r
 MqJ2pWy46222u76nej+1auGfbb8Z6NXPacEd+ilrujB0fql7RqrCyek/BX7BG5NfjHoR
 KW9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv6jRaATOu+5bQ/9dhEuZK3rL+3oWPZTH0ZgB/mJYLcBthfrOOih8osOF9Sm3/ArRqs5qAf7K/iOA8LmB0Gl2GhV/X870=
X-Gm-Message-State: AOJu0YybdXfI3RQ/O8LFgsiYfXKGr88/3cBp9Zo/VsAICqXNX1Vwt9hh
 Y9FzFHXQhmQrVCHktYNum7Z2I9Dy4w1EM+E/tYNYxCLHSJUeGL9R/rTni7tplCqgZzsKOMX1EKg
 /k188pqUqJXoqtl0gvoaM7OyfZeDPQK6uLdlTZWrJgzBV6tk29zZf
X-Received: by 2002:a17:906:488e:b0:a52:71bf:925c with SMTP id
 v14-20020a170906488e00b00a5271bf925cmr7118929ejq.62.1714470114342; 
 Tue, 30 Apr 2024 02:41:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtzoF4mhX5nMjwBrdQGo1+E7Es7b/KCFz910EUESfqF/hRnAbcdPkBZHp9eoShXShgL7W5Uw==
X-Received: by 2002:a17:906:488e:b0:a52:71bf:925c with SMTP id
 v14-20020a170906488e00b00a5271bf925cmr7118919ejq.62.1714470114115; 
 Tue, 30 Apr 2024 02:41:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 l2-20020a1709060e0200b00a4da28f42f1sm15111670eji.177.2024.04.30.02.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 02:41:53 -0700 (PDT)
Message-ID: <0ca17106-a529-4d54-989f-9b9b47c6b8a7@redhat.com>
Date: Tue, 30 Apr 2024 11:41:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH v3 13/19] vfio: Create host IOMMU device instance
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-14-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
In-Reply-To: <20240429065046.3688701-14-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> Create host IOMMU device instance in vfio_attach_device() and call
> .realize() to initialize it further.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h |  1 +
>   hw/vfio/common.c              | 18 +++++++++++++++++-
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 0943add3bc..b204b93a55 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -126,6 +126,7 @@ typedef struct VFIODevice {
>       OnOffAuto pre_copy_dirty_page_tracking;
>       bool dirty_pages_supported;
>       bool dirty_tracking;
> +    HostIOMMUDevice *hiod;
>       int devid;
>       IOMMUFDBackend *iommufd;
>   } VFIODevice;
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 8f9cbdc026..0be8b70ebd 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1497,6 +1497,8 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
>   {
>       const VFIOIOMMUClass *ops =
>           VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
> +    HostIOMMUDevice *hiod;
> +    int ret;
>   
>       if (vbasedev->iommufd) {
>           ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
> @@ -1504,7 +1506,20 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
>   
>       assert(ops);
>   
> -    return ops->attach_device(name, vbasedev, as, errp);
> +    ret = ops->attach_device(name, vbasedev, as, errp);
> +    if (ret < 0) {
> +        return ret;


hmm, I wonder if we should change the return value of vfio_attach_device()
to be a bool.


Thanks,

C.

	

> +    }
> +
> +    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
> +    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
> +        object_unref(hiod);
> +        ops->detach_device(vbasedev);
> +        return -EINVAL;
> +    }
> +    vbasedev->hiod = hiod;
> +
> +    return 0;
>   }
>   
>   void vfio_detach_device(VFIODevice *vbasedev)
> @@ -1512,5 +1527,6 @@ void vfio_detach_device(VFIODevice *vbasedev)
>       if (!vbasedev->bcontainer) {
>           return;
>       }
> +    object_unref(vbasedev->hiod);
>       vbasedev->bcontainer->ops->detach_device(vbasedev);
>   }


