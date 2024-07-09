Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5B5C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 06:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR4LJ-0005e7-MD; Tue, 09 Jul 2024 02:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR4LI-0005bO-V2
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR4LH-0001Kj-8C
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720506526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wPYTjyM4Ib7qX4y8xQcl6TLblUxB61z0xj6qB5xqn9k=;
 b=TvCzIhTBEVUdp1f+QLT1Nf1vyE/1x23noIlgbUtn+17jdP51S7a252VT8PT4OhLCcUtC6i
 E0GdKNfNmTHhZtF2iO5CFjTnphWxj5VX34VqykBAAZ+aniH6rvAwevu2BX/WFtRO26k0Yg
 2k2UCEG4UlxEQCRMDkfHFS0vCxyfKMM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-F4LTYoyLNTqV_BMXtzJvlg-1; Tue, 09 Jul 2024 02:28:44 -0400
X-MC-Unique: F4LTYoyLNTqV_BMXtzJvlg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367990b4beeso3343828f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 23:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720506523; x=1721111323;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wPYTjyM4Ib7qX4y8xQcl6TLblUxB61z0xj6qB5xqn9k=;
 b=qYQWGK7QcA65FbTds+ndcbVzHZu9bkBcihfmGAN45nc+Jx34bU78ooLXNw/uebmNt2
 vqiyWhNCXaaAhOGlWFVfPpIWSg2LeG+xAKkPwZsD+X1F7gqQbU7xNSrF7h1eUDS20B3y
 21CA7FFVStVVgAGEajp5d6Vyvrl3IP/NyJvL9FVl7G4nfZx8OX+5x+ycPnxq0RoKcwNi
 BhwYw3VSEhCL/lRbIfVLi2acr7+O0C7NAHWuhsnQ7qwhtt3u4dgmbrsICgltNthSy1TS
 GUKr0kxniQOEQk1hLIHuRWPmH/dHkuk8jJnBeiOFygYvy/bnMf2DYn9CQRvr7VChsEWr
 CbxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdmJgbnIbASRsPrfcXnUBF4hxmBGGF2gjYcHxbzQ2eauzSbssX2oW85J1E7wY83nPpBMsfWbbumeLU6JfspIuBrgHHGjw=
X-Gm-Message-State: AOJu0Yytwm3iERGJNuGs8kbtk2Xoh58ur+oKsxm88thqoHAMYh5dtZKm
 aUsKTDpJ/1NHkEUZaSVw7BOkVgOFWtp6WEUJjGS/raA90eerbIfCEofIr9x0RaUQ7Dk+cR6iPS/
 cLgR6ngyaI6ri/a1xrArmJzU8vdjUp5C4iU3WGfCVjOt6vwzOPW33
X-Received: by 2002:a05:6000:156a:b0:364:aafb:6020 with SMTP id
 ffacd0b85a97d-367cea46790mr1336256f8f.14.1720506523566; 
 Mon, 08 Jul 2024 23:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiqmQOYYncq2pIieUfPaVEsoEOSFnhW7rSEl/Cp0pfKACAVBuZPmqs8cWGzYrPzzOML7jOIQ==
X-Received: by 2002:a05:6000:156a:b0:364:aafb:6020 with SMTP id
 ffacd0b85a97d-367cea46790mr1336242f8f.14.1720506523163; 
 Mon, 08 Jul 2024 23:28:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde84912sm1552024f8f.40.2024.07.08.23.28.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 23:28:42 -0700 (PDT)
Message-ID: <a3f22b3b-e3bc-4dd6-b6fb-cfb726addfbe@redhat.com>
Date: Tue, 9 Jul 2024 08:28:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-6-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240708143420.16953-6-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 7/8/24 4:34 PM, Joao Martins wrote:
> Probe hardware dirty tracking support by querying device hw capabilities via
> IOMMUFD_GET_HW_INFO.
> 
> In preparation to using the dirty tracking UAPI, request dirty tracking in the
> HWPT flags when the IOMMU supports dirty tracking.
> 
> The auto domain logic allows different IOMMU domains to be created when DMA
> dirty tracking is not desired (and VF can provide it) while others doesn't have
> it and want the IOMMU capability. This is not used in this way here given how
> VFIODevice migration capability checking takes place *after* the device
> attachment. But such granularity is a nice property that can be implemented
> later on.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   include/hw/vfio/vfio-common.h |  1 +
>   hw/vfio/iommufd.c             | 26 ++++++++++++++++++++++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 82c5a4aaa61e..7ce925cfab19 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
>   
>   typedef struct VFIOIOASHwpt {
>       uint32_t hwpt_id;
> +    uint32_t hwpt_flags;
>       QLIST_HEAD(, VFIODevice) device_list;
>       QLIST_ENTRY(VFIOIOASHwpt) next;
>   } VFIOIOASHwpt;
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 2ca9a32cc7b6..1b5b46d28ed6 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -212,6 +212,20 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>       return true;
>   }
>   
> +static bool iommufd_device_dirty_tracking(IOMMUFDBackend *iommufd,
> +                                          VFIODevice *vbasedev)
> +{
> +    enum iommu_hw_info_type type;
> +    uint64_t caps;
> +
> +    if (!iommufd_backend_get_device_info(iommufd, vbasedev->devid, &type,
> +                                         NULL, 0, &caps, NULL)) {

I think we should report the error and not ignore it.

That said, since we are probing the hw features of the host IOMMU device,
could we use the data cached in the HostIOMMUDevice struct instead ?
This means would need to move the ->realize() call doing the probing
before attaching the device in vfio_attach_device(). That way we would
catch probing errors in one place. Does this make sense ?

Thanks,

C.




> +        return false;
> +    }
> +
> +    return caps & IOMMU_HW_CAP_DIRTY_TRACKING;
> +}
> +
>   static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>                                            VFIOIOMMUFDContainer *container,
>                                            Error **errp)
> @@ -239,6 +253,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>           }
>       }
>   
> +    /*
> +     * This is quite early and VFIODevice isn't yet fully initialized,
> +     * thus rely on IOMMU hardware capabilities as to whether IOMMU dirty
> +     * tracking is going to be needed.
> +     */
> +    if (iommufd_device_dirty_tracking(iommufd, vbasedev)) {
> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +    }
> +
>       ret = iommufd_backend_alloc_hwpt(iommufd,
>                                        vbasedev->devid,
>                                        container->ioas_id, flags,
> @@ -255,6 +278,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>   
>       hwpt = g_malloc0(sizeof(*hwpt));
>       hwpt->hwpt_id = hwpt_id;
> +    hwpt->hwpt_flags = flags;
>       QLIST_INIT(&hwpt->device_list);
>   
>       ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
> @@ -267,6 +291,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       vbasedev->hwpt = hwpt;
>       QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>       QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
> +    container->bcontainer.dirty_pages_supported |=
> +                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
>       return true;
>   }
>   


