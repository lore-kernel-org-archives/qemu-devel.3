Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDB3C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 08:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSWns-0007tF-IL; Fri, 20 Jun 2025 04:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSWnq-0007t3-24
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 04:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSWno-0005MR-1l
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 04:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750406926;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hvOP+nTKaEhpsBaKSOj8w5u50scPs2hv0iv7A3KJHTo=;
 b=AvTLE2e4vKhj8wauu+Rd34VTYaz8W1V2RpyurldL7rUDfJ0fqs0iffkEig2V7CypPBPRNB
 mvceLWv+inyOwMBb8AsVc29w/MCTkntUJuAYcMocwa3yqCIPZwKogY2oQ/uslTX+Y6Jujk
 QgbxP7u1ZoCso7CqNDDdKEezUMESDK4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654--5TmCDzMPz-ukQQuyH13EQ-1; Fri, 20 Jun 2025 04:08:44 -0400
X-MC-Unique: -5TmCDzMPz-ukQQuyH13EQ-1
X-Mimecast-MFC-AGG-ID: -5TmCDzMPz-ukQQuyH13EQ_1750406923
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45311704cdbso9706575e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 01:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750406923; x=1751011723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hvOP+nTKaEhpsBaKSOj8w5u50scPs2hv0iv7A3KJHTo=;
 b=E8R+ZcIb/IR2pNbF+jIh6BxBok65tMmAnY3TRYFWqPsirV5hU4b9Owi+oG0DqjLp6J
 k4LoCFFajIy23QU6UDl8pRe6MrhP0W3PqCFi2Sb1TB7V3Q2rSxkOgO/GMmyHqr8B1GLJ
 UfoyPHsIi2M6CQUA7qmt/KoLKIMUJ52V9CY9/X0vuoJpGg0WNIWYLpzEqWxGX8BrXxZA
 Yxd9Ruxm/SuciwXa7tWte5cubQcpjJqzatOwLV226c97FmmCyhhZIK/tUi5+PzZP1Z1m
 TaHoFsaMrd7fNRktwy0dKdjsMFyeudQldYYmebpPLuOaC0qigOygL6siWqvmQVmSB7Bn
 zhHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3DMTH97RrYexGngUEK8OuzmFGcjM0wHJ5NbfZuvgNgNMWwYOexTIUBKcfFt/fTZ/RjRzRw6v8neZL@nongnu.org
X-Gm-Message-State: AOJu0Yz+kT8N2jtwAAl1nHjG8li3epoNtkr1fR7u3H5XdHi5IqEbbw02
 yadoHDaDniHSET2tv/ERpTR3ToH1cusm9pScKoR3yEbb0KicjQgEsTACBQxp4H71/x9V9fFp0Dz
 G7D+wxnC6K+PS17fOXfLp9xbBGg51LVepPaETLMGyHH3EiyTQeylsR805
X-Gm-Gg: ASbGncv5dSPlYQ6Ihqv6LakSPzf1hZGCe4ZjsHtkpLNyssESQfJja6qTRrjSkfyg++s
 xa4RD8+m8Hj8fI0dhZadklS5nhdHriUuh9XtBNMAvZObfk+Yd+Lls3OO+ZqelKj1WuPGMg9UFL3
 k1Iw30pxhgPs37sRD5SpYa/LOqlTAbeEyJz6T9+Kg78sTG1zxlBYchPEASRvfUH8gDbmAaQPOsN
 Qxm05zjn/HWhc/OX7/l1c4e3ngbQRZy3N7vYGCIR7FFL2+A8m/j+D9aQ3SZywMoyLkeaSrRiKQH
 2M9Jcp1u8xi3EafhtMOg0QH1lPR9frKJ8sefRjTE61+Qukwt/ydwDeLu8CVy0gPv/O4ySg==
X-Received: by 2002:a05:600c:1d2a:b0:442:cab1:e092 with SMTP id
 5b1f17b1804b1-453662cb74emr9218965e9.11.1750406922912; 
 Fri, 20 Jun 2025 01:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQHQ6zgjfcBCJiCc97fXOms7mrzKU8AKlNaIfsxVT72TWp4zTPeOBt2fZKNUjhyp/lEG4gsQ==
X-Received: by 2002:a05:600c:1d2a:b0:442:cab1:e092 with SMTP id
 5b1f17b1804b1-453662cb74emr9218605e9.11.1750406922474; 
 Fri, 20 Jun 2025 01:08:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4536470370fsm16747475e9.29.2025.06.20.01.08.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 01:08:41 -0700 (PDT)
Message-ID: <a4d799f1-76fd-4608-af67-699e3dd4f1aa@redhat.com>
Date: Fri, 20 Jun 2025 10:08:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/19] vfio/iommufd: Force creating nested parent domain
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-5-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620071813.55571-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 6/20/25 9:17 AM, Zhenzhong Duan wrote:
> Call pci_device_get_viommu_cap() to get if vIOMMU supports VIOMMU_CAP_STAGE1,
> if yes, create nested parent domain which could be reused by vIOMMU to create
could? Is there a choice?
> nested domain.

I would add in the commit msg that it is safe because

hw_caps & VIOMMU_CAP_STAGE1 cannot be set yet because s->flts is forbidden until last patch of the series.

Eric

>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/iommufd.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index d3efef71af..83a632bdee 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -20,6 +20,7 @@
>  #include "trace.h"
>  #include "qapi/error.h"
>  #include "system/iommufd.h"
> +#include "hw/iommu.h"
>  #include "hw/qdev-core.h"
>  #include "hw/vfio/vfio-cpr.h"
>  #include "system/reset.h"
> @@ -352,6 +353,19 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>          flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>      }
>  
> +    /*
> +     * If vIOMMU supports stage-1 translation, force to create nested parent
> +     * domain which could be reused by vIOMMU to create nested domain.
> +     */
> +    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> +        VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +
> +        hw_caps = pci_device_get_viommu_cap(&vdev->pdev);
> +        if (hw_caps & VIOMMU_CAP_STAGE1) {
> +            flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
> +        }
> +    }
> +
>      if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>                                      container->ioas_id, flags,
>                                      IOMMU_HWPT_DATA_NONE, 0, NULL,


