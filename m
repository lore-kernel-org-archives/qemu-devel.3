Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B52C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThBy-0004lp-9O; Tue, 16 Jul 2024 08:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sThBu-0004l0-V5
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sThBq-0006lO-Qi
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721132513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xMuj4EK4kqfgUO1n0py68lKj8rAeh0YzitqvfWm6EZA=;
 b=BGk8BqTCoXzkgkfnEv6IuD9KbBuxJgWaOwpr+gHEqAYa5+ZEEjbfD0wg/Ri1ZVVm1XuyMU
 gmFBs11VfILF3NHXljNWtZuALwJbKR++RhgUMlTkHUj3Cie2yn2+wyNXDviCxByd91Rt+e
 InMd5aUosQMqE1g5Js22zaeYuYnos9o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-ttJgH7s3MJ6rUJ-qdY4qcA-1; Tue, 16 Jul 2024 08:21:51 -0400
X-MC-Unique: ttJgH7s3MJ6rUJ-qdY4qcA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-367a058fa21so3157966f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721132510; x=1721737310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xMuj4EK4kqfgUO1n0py68lKj8rAeh0YzitqvfWm6EZA=;
 b=wwOXNft+uTDodQu+i6AI2Gq79HzYjLEfWwgMi4KTOqkKaeFTvbX34IYrbm5lRV08y/
 6jXDUXPBrJzC+ACsCAWd59lbJLl+D50Ckpm9RMx+EEfCD4HibYw7EZOwExreB+hRFGEn
 IX07kQfMyGYBvfDnQ//7TIWyGjrmn8lUBE8KTWLq3dqDGM99SZxARL/NozlGZvh8imOL
 2+3ODlg+PsAofxWDvoVj+i2fAK2S93On+qdqe3EQ8E3GfqveSOeeVsZv+y7F9DnxAGnH
 4QFyVBbBKGl1XBgZA7lB2F8Ud7BCOWrGZ52lk58KkJscGTETulAnCnqasViFDxeAM9qG
 mwzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVId98VUMwxKyjvQ6p0o1rh1Mrm4rE7X6wr/lorG/aGavTJArH1bhA3vhttv4mTop2Z0ZDSE2EU0o4Tz+VicV0W0yYer6s=
X-Gm-Message-State: AOJu0YzOzNYlBJEqxrYheLXLAp8gUU5In9p+amX83aneEPAB6uCw5lBY
 kDKAr4g0K8PSrBqwFpQMmKuXsJKTMmljc46BCIEAMSPNKZe+IWkYHo3BQ/dFN0A1+6ktdya3sk1
 q4U1FNHKEe2tzCpAcm6yXoOBEe2b2TxnRp2iweEFc8Wkt3lUw56fC
X-Received: by 2002:a5d:6b8f:0:b0:367:865d:30b6 with SMTP id
 ffacd0b85a97d-368273b9a8emr1211767f8f.8.1721132510719; 
 Tue, 16 Jul 2024 05:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkt+rEkL0OxXbWiYKdqJb4uFXMidy2gnOac8MxN91JyuX2Amx8VKGRCK+RmD/8PZZ5MN5OGw==
X-Received: by 2002:a5d:6b8f:0:b0:367:865d:30b6 with SMTP id
 ffacd0b85a97d-368273b9a8emr1211749f8f.8.1721132510380; 
 Tue, 16 Jul 2024 05:21:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbf19sm8812126f8f.68.2024.07.16.05.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 05:21:49 -0700 (PDT)
Message-ID: <deb8811d-7293-4e99-aa99-415c1bf8d324@redhat.com>
Date: Tue, 16 Jul 2024 14:21:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-9-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240712114704.8708-9-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/12/24 13:47, Joao Martins wrote:
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
> attachment.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   include/hw/vfio/vfio-common.h |  1 +
>   hw/vfio/iommufd.c             | 12 ++++++++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 2dd468ce3c02..760f31d84ac8 100644
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
> index d34dc88231ec..edc8f97d8f3d 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -246,6 +246,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>           }
>       }
>   
> +    /*
> +     * This is quite early and VFIODevice isn't yet fully initialized,
> +     * thus rely on IOMMU hardware capabilities as to whether IOMMU dirty
> +     * tracking is going to be needed.
> +     */
> +    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +    }
> +
>       if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>                                       container->ioas_id, flags,
>                                       IOMMU_HWPT_DATA_NONE, 0, NULL,
> @@ -255,6 +264,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>   
>       hwpt = g_malloc0(sizeof(*hwpt));
>       hwpt->hwpt_id = hwpt_id;
> +    hwpt->hwpt_flags = flags;
>       QLIST_INIT(&hwpt->device_list);
>   
>       ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
> @@ -267,6 +277,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       vbasedev->hwpt = hwpt;
>       QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>       QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
> +    container->bcontainer.dirty_pages_supported |=
> +                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
>       return true;
>   }
>   


Could you please introduce in this patch helper :

   static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
   {
       return hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
   }



Thanks,

C.



