Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166FCC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 16:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6ucR-0004EC-Sb; Tue, 14 May 2024 12:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6ucN-00048J-Cv
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:03:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6uc8-0007GC-JO
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715702569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8Lf4L53wdIqOc7SP69LdeCJR3eT9QHaWFkHgm0UhwE=;
 b=AHAWecIJhd0dxBHvnuJaHJ2TkrMuX2t955K1LhJR6Fdc8AVheL5eFMM/y9VpL2O3z0eMjS
 OneD2MjK65vMuE0WMcMkbIhMJwiVbqfnSGipCFPnlwQZwIigTlBF0Kwha57878XOgn6cgv
 mRdQvFGr74zStizX6ZpymTMzeVlnWFg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-4hfq9q_cM5eqVhBemhbJeQ-1; Tue, 14 May 2024 12:02:48 -0400
X-MC-Unique: 4hfq9q_cM5eqVhBemhbJeQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6a0b3599f2cso58863686d6.3
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 09:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715702567; x=1716307367;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v8Lf4L53wdIqOc7SP69LdeCJR3eT9QHaWFkHgm0UhwE=;
 b=kmjip72wD+mZVdH3Rzwa+b1NKoy02NxKeTWGg9JU1Dr+96n09MaFXRdaWoqAj9hMjL
 s+ui0wIgyqQabFiS/qW7aTaW/jE25HlBFNUSnlpmtjw/KJY35VgsIp4X1i1dcunYKVAR
 dQ8oPVImhC0lIlAFGYpnR6ZRJ5hd4RF/A/XK466TNJ846Sm40yjTtW2q/HSSKzxsRnuQ
 u037g0wH5fjyOlRlmGOfn8UzhqxjsH2yJnVpgiW2dW+lxCQ0k9zaD8tLHaPKXwH9joX/
 hkT+QHBSkzHwiPbh8P60RXcy4MGJgfXItLLTm2EgtGrj/8WsHoHDwLe3RPX/ND4Cm8A6
 +H/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnFKfWZ87rj2ebTQEa3Bbu5DinOVQxF1U2e0JgkMoZIt6wBUKhMvWiAXi1NHlZnz4GwTlg4VdkDi5v75zrmkg+geMyJUM=
X-Gm-Message-State: AOJu0YzdDtZJQzAqeFFy4pWYwaCbg1YAfGRY1+pyAcFWo+L6ls8gH5Iq
 m0HH2eigkzHl9cbbHJcTzyUfz2SVVKGhUSDynRFeke0hJzWaiqn3xsOP9El0SkFUOkltEJBvvr4
 YWq9tgFuC5eEN5SgWhHEck+Va6YJ8aPZ8oyrjl2pRb/SgJqCJOC/h
X-Received: by 2002:a05:6214:5d86:b0:69b:579b:6147 with SMTP id
 6a1803df08f44-6a1681502b3mr144969776d6.18.1715702567555; 
 Tue, 14 May 2024 09:02:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiQAR0ds21TlvR91EvEI4ANRj402yreYQlEIOeXZg2U5IRdWpThmRSa2fVvcKGuFQimbeFbA==
X-Received: by 2002:a05:6214:5d86:b0:69b:579b:6147 with SMTP id
 6a1803df08f44-6a1681502b3mr144969526d6.18.1715702567194; 
 Tue, 14 May 2024 09:02:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1cd3b5sm54790506d6.82.2024.05.14.09.02.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 09:02:46 -0700 (PDT)
Message-ID: <822a5d82-6041-48ba-8e37-aabd25a9ffd2@redhat.com>
Date: Tue, 14 May 2024 18:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] vfio/cpr: Make vfio_cpr_register_container()
 return bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
 <20240507064252.457884-11-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240507064252.457884-11-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/7/24 08:42, Zhenzhong Duan wrote:
> This is to follow the coding standand to return bool if 'Error **'
> is used to pass error.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h | 2 +-
>   hw/vfio/container.c           | 3 +--
>   hw/vfio/cpr.c                 | 4 ++--
>   hw/vfio/iommufd.c             | 3 +--
>   4 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index a7b6fc8f46..e4c60374fa 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -205,7 +205,7 @@ void vfio_detach_device(VFIODevice *vbasedev);
>   int vfio_kvm_device_add_fd(int fd, Error **errp);
>   int vfio_kvm_device_del_fd(int fd, Error **errp);
>   
> -int vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
> +bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
>   void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
>   
>   extern const MemoryRegionOps vfio_region_ops;
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index b02583ea16..86266f3b83 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -616,8 +616,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>           goto free_container_exit;
>       }
>   
> -    ret = vfio_cpr_register_container(bcontainer, errp);
> -    if (ret) {
> +    if (!vfio_cpr_register_container(bcontainer, errp)) {
>           goto free_container_exit;
>       }
>   
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index 392c2dd95d..87e51fcee1 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -25,12 +25,12 @@ static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>       return 0;
>   }
>   
> -int vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
> +bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
>   {
>       migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
>                                   vfio_cpr_reboot_notifier,
>                                   MIG_MODE_CPR_REBOOT);
> -    return 0;
> +    return true;
>   }
>   
>   void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 84c86b970e..6a446b16dc 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -396,8 +396,7 @@ found_container:
>           goto err_listener_register;
>       }
>   
> -    ret = vfio_cpr_register_container(bcontainer, errp);
> -    if (ret) {
> +    if (!vfio_cpr_register_container(bcontainer, errp)) {
>           goto err_listener_register;
>       }
>   


