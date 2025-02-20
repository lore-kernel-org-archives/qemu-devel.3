Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B886C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 18:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlAxx-0004WO-97; Thu, 20 Feb 2025 13:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlAxu-0004Vv-Nv
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:08:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlAxt-0001Qz-1x
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740074878;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPp9XkIxoAtpjEN2dxHpDw0ESRTu0PHGHQ9/KN+FElk=;
 b=erEDxVps3bqd1jCEyoqyNJz+r/DorDgpWHp38JSZ1E0G4UNJFEN+91qoip79PAjW6LrAXV
 ppBbz74iFzPqXdH6KBwTAxYWx7f82jUvPl5CGvTb06Act7ryHKI53o6jaiRrdkgCupX2BU
 tOfyog8UqEVgM5DyZ4l7X5YrCx3UbT0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-KxwG6kveMgCzK1ffluI4Bg-1; Thu, 20 Feb 2025 13:07:56 -0500
X-MC-Unique: KxwG6kveMgCzK1ffluI4Bg-1
X-Mimecast-MFC-AGG-ID: KxwG6kveMgCzK1ffluI4Bg_1740074875
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43995bff469so9229775e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 10:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740074874; x=1740679674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bPp9XkIxoAtpjEN2dxHpDw0ESRTu0PHGHQ9/KN+FElk=;
 b=r/qqpJepU+kdKnAFeCOUBCGSgTaBmer9d1rdgajljOYTcYNrpDwUA+Y3zghpXhWs+3
 h805D1+Ux5ohNWJdGdAWLJ87MjCAnb2O7aOqiPB7rdTtN9dlY4v6WLnMN2ODJddXPz70
 lAblo0jKAlaq4zMf5VZb4zQgcvXZ3+MzS9Q8qP6cvoDiAFs8NB/Y1Ie/FeKDVgnY6IIh
 roafNhQfKHC+yZTfcJkzhYQ76S8yqmG+ZwY+1H+W/w27DLuBUgJ1k9wKnqpBG1pUNWE6
 G1kshOTwB2NWpkn6tEO4oNiNYcGa0fJzcnsMjmUw8fdKRsnG03MIULnBK7x4CNWpiyuY
 Y7qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG5V5VfRtyZUU1e5QCfhv0RyK8r+saek3Y4llBk4cy1hg+xVbyO4NHJ6vnT0H8k40O30uN/pm2C9eO@nongnu.org
X-Gm-Message-State: AOJu0YxaQNty7Z9uHBGfllLG8pBI5Y4dKGsEfEYtk0RIqm/QfCnqL/8e
 ECJicTFDFe/hTLx1u7CcyD6hLvERMlyzCJjZqn9N3CAwekha5QtJi7Cy6luz3euFGDyVef7RzSM
 suBCPjcMNplChxqsGR03uBDpmBA5O+Ce3gplnBHir4ABsbr1fFZxZ
X-Gm-Gg: ASbGnctSKzUYKY8Z+QczhGpaHaiMijMdfH9NUAHrMmME+kBu1j0cGRZ7ERnqbsyX3lB
 UUVyMGRb3uPScAEgZUb/WSWxykbn6fdVfifOuTn0qkmsGzY8V6i4q1ou18iD5tJZ0GxUyCkMPN9
 3Yt94r3OGc6RnVDEEhWHs3LkauP2UOuSbxpdRBKbFk8bJfZOSYVjJTII9kzdq/lJmLPOWr4y4m0
 wWaSLS0Ml3R576rc5QLBTVHBDHQfmPkOnsaYd96WlaOcVrIOYeKDMBaTCQ93zNSTMgSc86dUKiP
 nCsRH8LSMy1+O7fuapB0vf53y6N4R1wpbcgfmEgdoCMF3sEFO4yA
X-Received: by 2002:a05:600c:198e:b0:439:9cbc:7753 with SMTP id
 5b1f17b1804b1-439ae1eaa6dmr2461695e9.10.1740074874640; 
 Thu, 20 Feb 2025 10:07:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/+ThuX3fl7jbM/cR5Zzl3MTzRib3tWAh8M/WjksLjmlNyAVlgIauASClqPHWtGaLWcynukQ==
X-Received: by 2002:a05:600c:198e:b0:439:9cbc:7753 with SMTP id
 5b1f17b1804b1-439ae1eaa6dmr2461365e9.10.1740074874233; 
 Thu, 20 Feb 2025 10:07:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43992ad82cfsm90197985e9.37.2025.02.20.10.07.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 10:07:53 -0800 (PST)
Message-ID: <48df132c-b96a-475e-92de-55084a684794@redhat.com>
Date: Thu, 20 Feb 2025 19:07:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 04/20] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize_late() handler
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-5-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250219082228.3303163-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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




On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
> There are three iommufd related elements iommufd handle, devid and

There are three iommufd specific members in HostIOMMUDevice
IOMMUFD that need to be initialized after attach on realize_late() ...

> hwpt_id. hwpt_id is ready only after VFIO device attachment. Device
> id and iommufd handle are ready before attachment, but they are all
> iommufd related stuff, initialize them together with hwpt_id.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/iommufd.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index df61edffc0..53639bf88b 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -828,6 +828,19 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>      return true;
>  }
>  
> +static bool hiod_iommufd_vfio_realize_late(HostIOMMUDevice *hiod, void *opaque,
> +                                           Error **errp)
> +{
> +    VFIODevice *vdev = opaque;
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
> +
> +    idev->iommufd = vdev->iommufd;
> +    idev->devid = vdev->devid;
> +    idev->hwpt_id = vdev->hwpt->hwpt_id;
> +
> +    return true;
> +}
> +
>  static GList *
>  hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
>  {
> @@ -852,6 +865,7 @@ static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
>      HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
>  
>      hiodc->realize = hiod_iommufd_vfio_realize;
> +    hiodc->realize_late = hiod_iommufd_vfio_realize_late;
>      hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
>      hiodc->get_page_size_mask = hiod_iommufd_vfio_get_page_size_mask;
>  };


