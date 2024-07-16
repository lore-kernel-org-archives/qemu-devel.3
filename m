Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE99C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTiMR-0001EY-Ax; Tue, 16 Jul 2024 09:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTiMG-0000d3-PF
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTiME-0005ku-Ry
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721137001;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0AhTLsumlCSxJGWq5iLzq6KO9f4s+l8Wpn9qDL1Xck=;
 b=UsPCNf1bJovWTlTIiwI2I3ugtMed2L7FCcnoYeGlOXSbVsc20P96Sn2ezwTbPTHywOFqqY
 m5gzhaWAl7RhpJQ2OqPxhBmeaQXcs2/LUvcAlIj84nAX/IUtXB01xVmjbZVHRbmyvm9KkR
 OdeyvRyJh5rW3xYfJbJh8ZrJ+SF5+uk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-zwSwN0KgOcm0Ob7FSAUuNA-1; Tue, 16 Jul 2024 09:36:40 -0400
X-MC-Unique: zwSwN0KgOcm0Ob7FSAUuNA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4266fbae4c6so41134405e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721136999; x=1721741799;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q0AhTLsumlCSxJGWq5iLzq6KO9f4s+l8Wpn9qDL1Xck=;
 b=MOz7Q+gHi2NZJiuCjC3hPd0yZJfnDp64zDQxB4E8txohazDJj/Dr5Sie0bqgyLThOz
 Usk89RLLqHUYzUwW1k+C4u/noDfWcpUUl0Q5KZrvb3+1gujMupk3fFKlKhMtjYeHAwrK
 pSthhzPxnXt9hnVMJ4994qobxfHZeaRaOM3F0A5JMo9xC1WzEdz2njRgvU3yJkdxh0Ag
 uMjb07qUWuwP4rniHFiDQYqhie9qy0L8+zgtFiydjID1PvGoJL7aXfzV2TzoAbIx/VFO
 +bjWFPeyZNs0r+u4S3CfQ9q6qrrlYvclcyVDxj5Cg/ztXTHfi4pFadDiWziK/4KgQfXB
 SUIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrezzfrv2pco02TmErEmN65Q/9UbJJQA2xvwEcAsYWjZ1Ewh0d/Yrm0AOaVPcz5p9dQsmHmbej89mKO6frnpV0ushzHtI=
X-Gm-Message-State: AOJu0YyHX0oDrCaFJJil3FjK4hrHgcD38Z90vfW5ngkgilieIi4jC4JN
 Xxbl2mCi4QhPZNVqLIEKgpL2ldgRfD4+gm/xb2kd98MPeGW6MamIrDRUBwOCNL2m0hv3SxQUbRY
 0vhrgjqFLiPGuS3q10hHMY6XVnkjv6JrbApzFSp9jkP4c3R4Ya/Fb
X-Received: by 2002:a05:600c:1383:b0:426:6455:f124 with SMTP id
 5b1f17b1804b1-427ba4b6547mr16103285e9.0.1721136999050; 
 Tue, 16 Jul 2024 06:36:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/8yx9B4k3i/SaB3QHGGN0yvfFoJYRpm2h5py1uAfUPN5EtoQcZu61NAbFM5FbGLISWtUlMA==
X-Received: by 2002:a05:600c:1383:b0:426:6455:f124 with SMTP id
 5b1f17b1804b1-427ba4b6547mr16103075e9.0.1721136998660; 
 Tue, 16 Jul 2024 06:36:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e8144dsm128513025e9.11.2024.07.16.06.36.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 06:36:38 -0700 (PDT)
Message-ID: <48782eee-4066-4b33-92ca-25bc0cbaa7ee@redhat.com>
Date: Tue, 16 Jul 2024 15:36:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/12] vfio/iommufd: Return errno in
 iommufd_cdev_attach_ioas_hwpt()
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-5-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240712114704.8708-5-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/iommufd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 604eaa4d9a5d..077dea8f1b64 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -172,7 +172,7 @@ out:
>      return ret;
>  }
>  
> -static bool iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
> +static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
>                                           Error **errp)
>  {
>      int iommufd = vbasedev->iommufd->fd;
> @@ -187,12 +187,12 @@ static bool iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
>          error_setg_errno(errp, errno,
>                           "[iommufd=%d] error attach %s (%d) to id=%d",
>                           iommufd, vbasedev->name, vbasedev->fd, id);
> -        return false;
> +        return -errno;
>      }
>  
>      trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
>                                          vbasedev->fd, id);
> -    return true;
> +    return 0;
>  }
>  
>  static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
> @@ -216,7 +216,7 @@ static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>                                            VFIOIOMMUFDContainer *container,
>                                            Error **errp)
>  {
> -    return iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
> +    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
>  }
>  
>  static void iommufd_cdev_detach_container(VFIODevice *vbasedev,


