Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8A7CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXSM-0003Tv-HR; Fri, 19 Sep 2025 05:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzXSK-0003TU-1K
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzXSH-0001IU-Gk
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758274258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cZIxGeNnU09xVcZDXBVdQM0OiBU6r79vhA+rB3ZMtuI=;
 b=GrFJmR7ahLY+iQn9Gx6btm3LW6NY9HA633pZPyrqedzBmZhNdrNMIg+RhEAK9aOUqbGMgw
 NzbGGtKbZFSr7VEfX9jOb2wXWVm+qIIlLhk1JEcb3eKbNTnBA0dgZ7srp3nEspZ7wdHMvU
 F2fhch3vt3HppllzNMmAYS9cebRDjus=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-xbdOPLqMMXiZH2QEz_reQg-1; Fri, 19 Sep 2025 05:30:54 -0400
X-MC-Unique: xbdOPLqMMXiZH2QEz_reQg-1
X-Mimecast-MFC-AGG-ID: xbdOPLqMMXiZH2QEz_reQg_1758274254
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-469666a417bso1299975e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 02:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758274253; x=1758879053;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cZIxGeNnU09xVcZDXBVdQM0OiBU6r79vhA+rB3ZMtuI=;
 b=ftUPqCKU8YnDh5Elu1sSw83uR69XC3iwNKBuB0y65hsULLwURp51TDbyJHEAQufTgZ
 ZJQhB7a/q9n84mEy479zLGVFxGSih8f1GHxxzUkBhTAashE0zUZ0zOrtIcMD6icjk3+Q
 1MYU3gPSbnLMxL63KxwWU080ldqb30xXyDMMFemZX2lfngrRHo5ayPI483CbBdu7mZe/
 hOUKWp8Xf7HeRDQxAYAVbktWJUnHr2xUNA/0z7KcxY4r4mvBzoY2HpgpxUwiEdsaHs63
 hw3CBQi3Tsh5dtv5oP956onAprOI5ii+PTDBq5fBhPkpIq0Th3SK2xSQI6Pqh+Ne22ku
 7kiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU548af78fz/obLzzH5EO9G7LF18KYUXXOOW7p0nBO+/3GYiu5d5lPOVDfbWY/vohC6eo3VaqwpW4fh@nongnu.org
X-Gm-Message-State: AOJu0YwS2MYni1+EAOrrFqDh2jU5Fu9sCVMDo/6IqyNVg5UJlD69AwvK
 kgjCyHH1vu3Xfi0Hu/axHxi+NokQtWZBk1ODj9wF1olcgaxSI4LPU7wkbQ3B5JT1QASSYvopj/r
 KQZCnADP0Y5wYV99DJ4yMYx9FFspqUA8x9Bei+Q+/wNCz2+g1sjhVy8Fw
X-Gm-Gg: ASbGncuLCzf5Z96yxDTcsySQqg1mSEK1XTNP4CupC5l4KeKaFAZKnwFXIEOftQoLtME
 +qihANVMjttRCe0VybQy67JOncX2JN1jPZLMhhB3+MHQI933zWIEInWrrlknGbtL1+3QjKAM3nx
 WgLOsDTeipkDGzj2cusvSWaF0dLcFma6TL5WYR1N79943xcKgvvIzwS+QsL87tcQD4dfgN/BIlf
 whND9dqnxcTscIyqeEWKENND36qhSfAtiaA8G2dafn7Y6uax3OdP2piUCMfy5Q8Zyv9acrV/5WR
 RmYM3S4SpTrrkj3s1mlhUYYEthYO+Q5lmTFDma16S8SpuXhyXAOo5ytgJYlprKsdHr5fwkLebcC
 5Dts=
X-Received: by 2002:a05:600c:190c:b0:45f:2843:e76d with SMTP id
 5b1f17b1804b1-467e6b64cd3mr23015905e9.4.1758274253557; 
 Fri, 19 Sep 2025 02:30:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkNfaKQZpKkMyMKE1BjspKLXiuYpAa4NB4+W98wuQ1pTyRFoGHnO9l8AcJfn+qHQL9T2XXtg==
X-Received: by 2002:a05:600c:190c:b0:45f:2843:e76d with SMTP id
 5b1f17b1804b1-467e6b64cd3mr23015555e9.4.1758274253053; 
 Fri, 19 Sep 2025 02:30:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4613e849a41sm117090055e9.20.2025.09.19.02.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 02:30:52 -0700 (PDT)
Message-ID: <ee5c9d7c-a85e-4da4-bd5a-a59951a19a06@redhat.com>
Date: Fri, 19 Sep 2025 11:30:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] vfio/iommufd: Add framework code to support getting
 dirty bitmap before unmap
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, avihaih@nvidia.com, xudong.hao@intel.com,
 giovanni.cabiddu@intel.com, mark.gross@intel.com, arjan.van.de.ven@intel.com
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-2-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250910023701.244356-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Zhenzhong

On 9/10/25 04:36, Zhenzhong Duan wrote:
> Currently we support device and iommu dirty tracking, device dirty
> tracking is preferred.
> 
> Add the framework code in iommufd_cdev_unmap_one() to choose either
> device or iommu dirty tracking, just like vfio_legacy_dma_unmap_one().

I wonder if commit 567d7d3e6be5 ("vfio/common: Work around kernel
overflow bug in DMA unmap") could be removed now to make the code
common to both VFIO IOMMU Type1 and IOMMUFD backends.

I asked Alex and Peter in another thread.

Thanks,

C.




> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
> ---
>   hw/vfio/iommufd.c | 56 +++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 48c590b6a9..b5d6e54c45 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -58,33 +58,67 @@ static int iommufd_cdev_map_file(const VFIOContainerBase *bcontainer,
>                                           iova, size, fd, start, readonly);
>   }
>   
> -static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
> -                              hwaddr iova, ram_addr_t size,
> -                              IOMMUTLBEntry *iotlb, bool unmap_all)
> +static int iommufd_cdev_unmap_one(const VFIOContainerBase *bcontainer,
> +                                  hwaddr iova, ram_addr_t size,
> +                                  IOMMUTLBEntry *iotlb)
>   {
>       const VFIOIOMMUFDContainer *container =
>           container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
> +    bool need_dirty_sync = false;
> +    Error *local_err = NULL;
> +    IOMMUFDBackend *be = container->be;
> +    uint32_t ioas_id = container->ioas_id;
> +    int ret;
> +
> +    if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
> +        if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
> +            bcontainer->dirty_pages_supported) {
> +            /* TODO: query dirty bitmap before DMA unmap */
> +            return iommufd_backend_unmap_dma(be, ioas_id, iova, size);
> +        }
> +
> +        need_dirty_sync = true;
> +    }
> +
> +    ret = iommufd_backend_unmap_dma(be, ioas_id, iova, size);
> +    if (ret) {
> +        return ret;
> +    }
>   
> +    if (need_dirty_sync) {
> +        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
> +                                                iotlb->translated_addr,
> +                                                &local_err);
> +        if (ret) {
> +            error_report_err(local_err);
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}
> +static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
> +                              hwaddr iova, ram_addr_t size,
> +                              IOMMUTLBEntry *iotlb, bool unmap_all)
> +{
>       /* unmap in halves */
>       if (unmap_all) {
>           Int128 llsize = int128_rshift(int128_2_64(), 1);
>           int ret;
>   
> -        ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
> -                                        0, int128_get64(llsize));
> +        ret = iommufd_cdev_unmap_one(bcontainer, 0, int128_get64(llsize),
> +                                     iotlb);
>   
>           if (ret == 0) {
> -            ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
> -                                            int128_get64(llsize),
> -                                            int128_get64(llsize));
> +            ret = iommufd_cdev_unmap_one(bcontainer, int128_get64(llsize),
> +                                         int128_get64(llsize), iotlb);
>           }
>   
>           return ret;
>       }
>   
> -    /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
> -    return iommufd_backend_unmap_dma(container->be,
> -                                     container->ioas_id, iova, size);
> +    return iommufd_cdev_unmap_one(bcontainer, iova, size, iotlb);
>   }
>   
>   static bool iommufd_cdev_kvm_device_add(VFIODevice *vbasedev, Error **errp)


