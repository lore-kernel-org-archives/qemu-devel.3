Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3586CC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTiK1-0000TP-H1; Tue, 16 Jul 2024 09:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTiJs-0008Ob-KK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTiJn-0004p5-5f
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721136850;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lelqN2hWH9MCiSjjNVjWfJJjffHUXRvDMnilVB7vEy4=;
 b=KUcZWI4OM3hxvB+k/0TBwTpyIUnFCJziHK9RXURvaiS33iLtaPngLIALQuxc8/L0M4A/+8
 YW7I9PhVzjT+CR5GZeV+YourbyALKQxKc8lQtSQPFXn5jfI1rClNnzKItihysap00H8/pC
 UWbi2tZR1uiQFzkGoxOOVEkPrqXDA4U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-G4B4T397M3GXZNq06T70SQ-1; Tue, 16 Jul 2024 09:34:08 -0400
X-MC-Unique: G4B4T397M3GXZNq06T70SQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36789def10eso3699842f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721136847; x=1721741647;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lelqN2hWH9MCiSjjNVjWfJJjffHUXRvDMnilVB7vEy4=;
 b=LupvSMRady1qWE3p5ukKL02/82SLMZ/73Cmk7pl4QppBxoPiggIh9SqGiTFUwvsNVv
 6RQUC1AaLpUR2fFuTn6ZeWEvJp20hi5TEbqyvpkY0/zn3mfvDWU2pZ73rAipzgFeLMn+
 lT6OIYJ5QSY/qi4XmBcwF1QVBuowE6iSyvOPSRX0D33Noof/vo8lt2MRvjQPtNzscX1a
 D1Axq53GVhHOfFDJGoLMqP6LJhKgIyZQLNUbpaB+3blQXEQV9me1ZhhUOE56bgrSajv9
 rqPDsJLZkgGFf9AVJb8YjLQFpdDzzbdMD9YQrVwlYfGU1RZNoYDWMTf9tOeBBuHtIplD
 Lbng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwnm5lQZ3vG/ZM36FiXXNPDzn6HdiSIum2k/wMToCsdWUZ9eO+bl4fgtR6KZXRds1tWstWl9bUnCkD3Wbbm/h9PJzNoEM=
X-Gm-Message-State: AOJu0YyDd9N/ub6iGSFqI1SjA4Kb2WKzYHe9Vbn2SRvaoU2ZNr2xMmI6
 RUfEgZW/fj8G00czQKx3wFLr+GDxnOWs/wMxVkPq0icbQMlb/VOwel3pL86wy/wmN5+WsvkszVW
 18bjVKso/90yGuOTF/IiFF7ugmJ4uik4dn5/SML4CQt+TZa39ddj4
X-Received: by 2002:adf:e80e:0:b0:367:9bc8:8c10 with SMTP id
 ffacd0b85a97d-36826107477mr1755054f8f.23.1721136847589; 
 Tue, 16 Jul 2024 06:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiJWWH50pFxxgLmkYyK5EioLZiiU0JOJh0TfRynmcEprQNhYaaHZm86nFqkMxc+lFQag1c+g==
X-Received: by 2002:adf:e80e:0:b0:367:9bc8:8c10 with SMTP id
 ffacd0b85a97d-36826107477mr1755025f8f.23.1721136847186; 
 Tue, 16 Jul 2024 06:34:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f25ac47sm163084575e9.18.2024.07.16.06.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 06:34:06 -0700 (PDT)
Message-ID: <49b5a26b-9f58-41f1-8b7d-497248e0bae8@redhat.com>
Date: Tue, 16 Jul 2024 15:34:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] backends/iommufd: Extend
 iommufd_backend_get_device_info() to fetch HW capabilities
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-4-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240712114704.8708-4-joao.m.martins@oracle.com>
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

Hi Joao,

On 7/12/24 13:46, Joao Martins wrote:
> The helper will be able to fetch vendor agnostic IOMMU capabilities
> supported both by hardware and software. Right now it is only iommu dirty
> tracking.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/sysemu/iommufd.h | 2 +-
>  backends/iommufd.c       | 4 +++-
>  hw/vfio/iommufd.c        | 4 +++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 9edfec604595..57d502a1c79a 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -49,7 +49,7 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>                                hwaddr iova, ram_addr_t size);
>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                       uint32_t *type, void *data, uint32_t len,
> -                                     Error **errp);
> +                                     uint64_t *caps, Error **errp);
>  
>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>  #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 84fefbc9ee7a..2b3d51af26d2 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -210,7 +210,7 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>  
>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                       uint32_t *type, void *data, uint32_t len,
> -                                     Error **errp)
> +                                     uint64_t *caps, Error **errp)
>  {
>      struct iommu_hw_info info = {
>          .size = sizeof(info),
> @@ -226,6 +226,8 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>  
>      g_assert(type);
>      *type = info.out_data_type;
> +    g_assert(caps);
> +    *caps = info.out_capabilities;
>  
>      return true;
>  }
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index c2f158e60386..604eaa4d9a5d 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -628,11 +628,13 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>      union {
>          struct iommu_hw_info_vtd vtd;
>      } data;
> +    uint64_t hw_caps;
>  
>      hiod->agent = opaque;
>  
>      if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
> -                                         &type, &data, sizeof(data), errp)) {
> +                                         &type, &data, sizeof(data),
> +                                         &hw_caps, errp)) {
>          return false;
>      }
>  


