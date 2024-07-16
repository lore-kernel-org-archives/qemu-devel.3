Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2892C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTeTE-00016l-TI; Tue, 16 Jul 2024 05:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTeTC-00013t-LZ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTeTB-00050L-2S
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721122055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qoE5pxRWoC783eaJBydPASemyX0zbq2/a/jvVhOQtOU=;
 b=MyB1hSteevNnbv5IXHWABynIs2MuPnrxRXbazTcPSrDzRHwgFSptrxOU0NFlv9wMTVfA4b
 trK/WlIgTQuGss4vRD0n13K3V9/LfLJFbEhUMFbM29vF8moKbW8yJqVMplrcASKdaBaMlb
 plByoQOS+3Fp572bDfC8K+tJ7ZfO3f4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-KFEmKq9SNJ2CEfXTOCOCbw-1; Tue, 16 Jul 2024 05:27:33 -0400
X-MC-Unique: KFEmKq9SNJ2CEfXTOCOCbw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-427a7a65e7dso13829155e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721122052; x=1721726852;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qoE5pxRWoC783eaJBydPASemyX0zbq2/a/jvVhOQtOU=;
 b=maNTkn52U1UK5LedXjBXZlcdDcvO+k1ySCZd2A+1nFByptroVj/W4RU4mK6fOhj1U6
 1gYMsMY0jUvHXQ3DUxGnwAM2Sx4xj+oc4Sc7W5M9mj3ffYgmtrQBi7JzvpCg0zgvsDDA
 GT4WYlUiYg4rA+Q0/8K1XnK3nt/zm11UEQy9tEJ+Ii+Tp0Wvemj3kyQmVayQxdWdffK3
 GpZc7m9/qANy+z/TFZiTZ/Z4BIWoNM0pvwxad70O9ts5n8cMaJWhCdlxqteKkwURx/eE
 WLSbrkiGtGlJ15K15Kpkg6r//N6noYqODsxq6Iu0Juu6+Sr8MTIgPCdpZTK4GpImRkOB
 8BpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaOUmQmmwbXc5XPE38PF+L/A0gcxOdqPGvxEKCuRVo15hAed1BwXrqiANwQ5GuWaYzKzD6cn9gOdQrIyVcIzn73FN3R5c=
X-Gm-Message-State: AOJu0YwCIB2i9VHRCEP/FS7jSi0qBfW0anb5C6jMidfSGkB8Qhs/s8Jw
 nOYolnoArVvm+QjO9V0RzTA9U8Ka+tl4mBbtrs8v07yMhT413DdoYIR0GdQLcE1F2FwSXQ/iBmz
 CraZSBMAAimCscV9kanE3udENZoyUaiGlFFA7tYNfGOVIbcZBFzmN
X-Received: by 2002:a05:600c:1e09:b0:426:62a2:34fc with SMTP id
 5b1f17b1804b1-427bf39020amr1161125e9.11.1721122052672; 
 Tue, 16 Jul 2024 02:27:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFde64tvqtfv6hHRZeSl7y6WZFXP6xWFL0y3QbTfaWuDMBAfRXPN7gS96IxIhVOZfKh2sL8OQ==
X-Received: by 2002:a05:600c:1e09:b0:426:62a2:34fc with SMTP id
 5b1f17b1804b1-427bf39020amr1161025e9.11.1721122052314; 
 Tue, 16 Jul 2024 02:27:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5edb525sm115774265e9.34.2024.07.16.02.27.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 02:27:31 -0700 (PDT)
Message-ID: <75110bf5-a4d4-4d68-9c37-8a653be2bcac@redhat.com>
Date: Tue, 16 Jul 2024 11:27:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/12] vfio/iommufd: Return errno in
 iommufd_cdev_attach_ioas_hwpt()
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-5-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240712114704.8708-5-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 7/12/24 13:46, Joao Martins wrote:
> In preparation to implement auto domains have the attach function
> return the errno it got during domain attach instead of a bool.
> 
> -EINVAL is tracked to track domain incompatibilities, and decide whether
> to create a new IOMMU domain.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/iommufd.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 604eaa4d9a5d..077dea8f1b64 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -172,7 +172,7 @@ out:
>       return ret;
>   }
>   
> -static bool iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
> +static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
>                                            Error **errp)
>   {
>       int iommufd = vbasedev->iommufd->fd;
> @@ -187,12 +187,12 @@ static bool iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
>           error_setg_errno(errp, errno,
>                            "[iommufd=%d] error attach %s (%d) to id=%d",
>                            iommufd, vbasedev->name, vbasedev->fd, id);
> -        return false;
> +        return -errno;
>       }
>   
>       trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
>                                           vbasedev->fd, id);
> -    return true;
> +    return 0;
>   }
>   
>   static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
> @@ -216,7 +216,7 @@ static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>                                             VFIOIOMMUFDContainer *container,
>                                             Error **errp)
>   {
> -    return iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
> +    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
>   }
>   
>   static void iommufd_cdev_detach_container(VFIODevice *vbasedev,


