Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A66AC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 15:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQqHl-0006Cr-5R; Mon, 08 Jul 2024 11:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sQqHj-00068o-Vq
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sQqHi-0007Xi-D4
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720452488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zmQG/ctAarOldhq94wtuOKKlHsCmMFPRrRPUbh79YPI=;
 b=Gtl8wE6XUJP/xs5av6G471hww5CJS8zN+M3gBLdhvUTmpY1lDgXTqAPJV8w0GEnPIUoPr7
 icE9yPXwPoN1K9ue7EDidByuFOsWHLq3uchJDTvP4iKrDhkR6ffA9X2H292wv2Ai/8wxy1
 f/ckMCjjOpo5XUDx7zMTWtdfhI/atVg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-x22CcyIYO1mG96ba7hcXKA-1; Mon, 08 Jul 2024 11:28:07 -0400
X-MC-Unique: x22CcyIYO1mG96ba7hcXKA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36796a0687bso3168899f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 08:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720452486; x=1721057286;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zmQG/ctAarOldhq94wtuOKKlHsCmMFPRrRPUbh79YPI=;
 b=uchDzYKql9WYLn1Qc+cvVvV486tx0+Gwwx0da3nTdQUekscsQRstxttzdYEMuuXIa5
 YFrO4A8tudH7TMfWT19bJw5uRN01ahJg3hUubyEAIgZgjOxidSq/Xnht8oZX0A5zyPjT
 tUEHk3T/p2wL7w4rGURxZq/vueU8cxRItJG5Ot//VBUaOtfiOsWCj+l71JaosUQVWL/K
 K8eFaFpW1hKNUBIT9dGEDs4OmeBG9liHxlAK/PM/bqoL0icNDKYWSMO+TCzKNjerCSn6
 GSB6PXNtiKnxPK34L9WXaXB1/vUxE+Y/utwUBFp0d7f6m0OgEw/CWCBWm8Of70NPV1kb
 l0FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCN+bVLXyq1NadGqdv6RJ6H540hYJAaLBNEQTYIKAyeszvKU7IEHrmdWd7j37kECQV/kH3ViRbTXEAR2kqDyatoMqQkFQ=
X-Gm-Message-State: AOJu0YxIC03En3OvGqTRXqR5qyzrFsFr19eXyw9p8mki7qLY4f6OQKpb
 SJ5vKC+hYJ6Oe6jCMHVl/0YpC6VLBFq1LsuAxZRWg7vWNYXkkWxH4DCxJHfQYjft/UQ/Pz9Kb0a
 4kAPxpOJL05ZsBg7N4fwm3MFcfBVgYIqORWjAtpFjmbSsHMrwNxW9TJVTgfDB
X-Received: by 2002:a5d:5183:0:b0:362:40cd:1bc with SMTP id
 ffacd0b85a97d-3679dd29813mr7454168f8f.24.1720452485883; 
 Mon, 08 Jul 2024 08:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU4GpNFh/DZ6VxNo76l5LS39cory4it/iVBzJKj9d2J0cS1aK3FS6YG+dZIu7czOiEH8W+Ow==
X-Received: by 2002:a5d:5183:0:b0:362:40cd:1bc with SMTP id
 ffacd0b85a97d-3679dd29813mr7454156f8f.24.1720452485556; 
 Mon, 08 Jul 2024 08:28:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde846dfsm77009f8f.28.2024.07.08.08.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 08:28:04 -0700 (PDT)
Message-ID: <5420483f-03cf-4383-be73-e3a8ec2a4378@redhat.com>
Date: Mon, 8 Jul 2024 17:28:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] vfio/iommufd: Return errno in
 iommufd_cdev_attach_ioas_hwpt()
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-4-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240708143420.16953-4-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

Hello Joao,

On 7/8/24 4:34 PM, Joao Martins wrote:
> In preparation to implement auto domains have the attach function
> return the errno it got during domain attach instead of a bool.
> 
> -EINVAL is tracked to track domain incompatibilities, and decide whether
> to create a new IOMMU domain.

Please leave the return value as a bool unless there is a very
good reason not to.


Thanks,

C.


> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   hw/vfio/iommufd.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 9cee71659b1c..5a5993b17c2e 100644
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


