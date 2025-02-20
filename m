Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFB2C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 18:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlB36-00063L-Dm; Thu, 20 Feb 2025 13:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlB31-00062k-7y
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:13:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlB2z-000245-Le
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740075196;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WOBMQ/L0iOXhv84/flNPOlpCEMahQnji7y8yFANmkvk=;
 b=W7dAdA8YW+GFFuaYaV1XKwsBegZnZwKJBTACGd+2a4XBGcFF2BbOMNc2JdfPo/0gLLNVol
 XlZiU97qCEmL5/xLXnJya0ok91G+o8/u+S0uwbagn7N52haShAcjtq6fK8aiRJSW5FRHad
 h7Ydra6T009r/uyO3fF/JmEFmw4Psok=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-VFuSdw8wOcyrF5jr1y9foA-1; Thu, 20 Feb 2025 13:13:14 -0500
X-MC-Unique: VFuSdw8wOcyrF5jr1y9foA-1
X-Mimecast-MFC-AGG-ID: VFuSdw8wOcyrF5jr1y9foA_1740075193
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f4cce15c8so649009f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 10:13:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740075193; x=1740679993;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WOBMQ/L0iOXhv84/flNPOlpCEMahQnji7y8yFANmkvk=;
 b=gxiNEBWNn3Hy6ZIoeHD8x9eO6PRHHhyvf2ZQ2uDZujOVxSBYPFavBapqCRomxxL9Py
 uBmAmgV/lojUi6VXqcz/4/iif8Z1UfMS0y1/hWcQ2EYwvss5y830dHahHOcgvIRQyASt
 DH/5PA97z0rinp5+5GZLa69KSXfOvjH28c3LuUnaJmpHzRnzffbV4JArsKvTWxhQVKQW
 lrdM/s9YshKf+x/iiGfxB1kX8n2hzY2bqKwrVPCKEHd2i+wBTXUTxFzXvspyP0Q4+5+U
 LnNoBy22P8/VwtBHeYdx0n5w4e9GJJzH3lvVcB9Kqkp/klL72YZZm+WjUKIswpAipqma
 iTbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVZQYT0RWkrHAaiR3CiA917QoIfSxn+tIo4USOv2yoas13f/5/epPZ2IlDwo7s0o/X6crfWTz/+GQE@nongnu.org
X-Gm-Message-State: AOJu0YwJzrdG1Bwo2J0UGQ87qGbebvgV5FknzRndE+f+Q8QOiU13y2wD
 TrorcxXEocyEtTcRd4T2TVYbcafl/IVWxHej2kTf4gZG0JV/+MtiF5Zu30clviPkKFzWf051eQ9
 KrePxy1fchmbMaZfw/B7nU9O9qx2ks4na7ZRjs2m7hk8A9xbv5pZ6
X-Gm-Gg: ASbGncvPvfmhIhfplg7nYkjVLSil6Vwz0n5oa4ZrBG1XOPC9T8cDysX2cmB8qf5qbTh
 fFCOxUrZoKL2v4CBjAbq5gM871/lxmP2G0VUXok3IFExaE96JpIj5ByETlZOxjlNcAB+RuGol+M
 sfBgMF2bKEDGFmEv38Dp66MPEDyIMtoWpBccRit1dXy9DcV+ZlWJRmWqz2dib9y5PidfIb7nRw9
 316XZnhBg3Ub3popBgZ3LI74NUM0ht2mv6xebWeeTggtcNqGQHaizrzhn7VJbhPxe0769zhU5BZ
 3+kocUVwisSqgwEJYbgjbrWra46akfVMlsxegEA3+Wc5gU06apPP
X-Received: by 2002:a05:6000:1a45:b0:38d:dd8c:51a1 with SMTP id
 ffacd0b85a97d-38f6e97b000mr255152f8f.27.1740075193210; 
 Thu, 20 Feb 2025 10:13:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5VRPEUc0jq/44xJOqIS/Fb60hcSHj+bxpA2nxYOjqq7eNda1uCNOj8Y/j6OufMDAAcrIL+g==
X-Received: by 2002:a05:6000:1a45:b0:38d:dd8c:51a1 with SMTP id
 ffacd0b85a97d-38f6e97b000mr255117f8f.27.1740075192825; 
 Thu, 20 Feb 2025 10:13:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04ee48sm251401425e9.3.2025.02.20.10.13.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 10:13:11 -0800 (PST)
Message-ID: <65c7bf72-10d2-4183-b548-f0f842083c49@redhat.com>
Date: Thu, 20 Feb 2025 19:13:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 05/20] vfio/iommufd: Implement [at|de]tach_hwpt
 handlers
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-6-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250219082228.3303163-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
> Implement [at|de]tach_hwpt handlers in VFIO subsystem. vIOMMU
> utilizes them to attach to or detach from hwpt on host side.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/iommufd.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 53639bf88b..175c4fe1f4 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -802,6 +802,24 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>      vioc->query_dirty_bitmap = iommufd_query_dirty_bitmap;
>  };
>  
> +static bool
can't we return an integer instead. This looks more standard to me

Eric
> +host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                           uint32_t hwpt_id, Error **errp)
> +{
> +    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
> +
> +    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
> +}
> +
> +static bool
> +host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                           Error **errp)
> +{
> +    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
> +
> +    return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
> +}
> +
>  static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>                                        Error **errp)
>  {
> @@ -863,11 +881,15 @@ hiod_iommufd_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
>  static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
>  {
>      HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
> +    HostIOMMUDeviceIOMMUFDClass *idevc = HOST_IOMMU_DEVICE_IOMMUFD_CLASS(oc);
>  
>      hiodc->realize = hiod_iommufd_vfio_realize;
>      hiodc->realize_late = hiod_iommufd_vfio_realize_late;
>      hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
>      hiodc->get_page_size_mask = hiod_iommufd_vfio_get_page_size_mask;
> +
> +    idevc->attach_hwpt = host_iommu_device_iommufd_vfio_attach_hwpt;
> +    idevc->detach_hwpt = host_iommu_device_iommufd_vfio_detach_hwpt;
>  };
>  
>  static const TypeInfo types[] = {


