Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD13C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 15:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc5fX-00052x-EN; Mon, 19 Feb 2024 10:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rc5fL-00052Y-PQ
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:34:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rc5fI-0007P4-Vn
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708356883;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDNKzR6fg9zr9ltk9Ur4N1mdVsWbdLEJEZLVmj7avjw=;
 b=NgoUC6uRkxsSZZOLwRWTWDt8Qb9yb6WF18SA4mv55NfQtoAamkqTf8MIhnG9uk4mfC42q+
 7RNUUZgaYLfhEbPrQqbtTR7yZF44IViWAq7TvrpoLdkQtoyLX4FiSHepeT62ZUVrdl4kkR
 rrJgw8WldJ9vwVBp7wQBjuk+wevdUUM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-HpDnAprtN0mtFkW453sKaw-1; Mon, 19 Feb 2024 10:34:42 -0500
X-MC-Unique: HpDnAprtN0mtFkW453sKaw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7876620c02aso131043785a.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 07:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708356882; x=1708961682;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RDNKzR6fg9zr9ltk9Ur4N1mdVsWbdLEJEZLVmj7avjw=;
 b=E2flqMQZj9ZuG5iiGIGfEB44bQj1DIJ+jDOjICghy30C3TjWk+KeGxIXIvJYWrKdNb
 EkAW72lyu8101ObHq/CDYDY8P/s+6F0QvAr0Z28I0cRORrRso99bSQY6+FQahCPVYn1j
 QZjeDkCpj30gFTMOhGVt/rjDY6jPxHEUGWEyxiivTuaeu6SwI75ALsu0b/SGLi8uhy84
 TaMCrOhvoEA+MWXbnqCTFyuBtABkONK5FZ3sEAweyBO2jxstK/ZcyaniedwUGSmWODaI
 QcG2J3lNnH8X/aAqG0+0BZbZliRTmRF8FAxnSCM084SVN/x/jwJloPUaJKuGy4IkuWXJ
 dPPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN5zKzxuEQpo3Gg8/5xQ543IxfFuIzaFf9VsbySyLhqz+zw/rRVCObv4On0FnRq1fdNt7ghs9Af3MZVuSwA/Jx4Bzab9s=
X-Gm-Message-State: AOJu0YxLS1J9tCxO44Zj5QZSZo4w6Ya72YKDTfGC8ficFhsjXyB3WCGG
 9++MgmJi5MECrSkGTKvwwDuKXFGRLy5Fat9rFbcpoe48OPvze4/blwaQyIHj1/jsd3P1JoYM6UD
 C9xDgM01p/aWpWn+THY1oxds2nSoxxSzIQtyT/pCTDE31Woj1sOwG
X-Received: by 2002:a05:620a:307:b0:787:3273:84e1 with SMTP id
 s7-20020a05620a030700b00787327384e1mr14046807qkm.44.1708356882194; 
 Mon, 19 Feb 2024 07:34:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSGe/E63Jcbs2zQBwj7Gi0wLguzS3Y7N8fqZkRrI/EexaT/SsuG5BtqlCQbVAA9812ezKyDw==
X-Received: by 2002:a05:620a:307:b0:787:3273:84e1 with SMTP id
 s7-20020a05620a030700b00787327384e1mr14046788qkm.44.1708356881928; 
 Mon, 19 Feb 2024 07:34:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a37e20c000000b0078721ebcfc8sm2583725qki.65.2024.02.19.07.34.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 07:34:40 -0800 (PST)
Message-ID: <dcca86cb-6184-4160-a3d1-a2f3e0f4e5d6@redhat.com>
Date: Mon, 19 Feb 2024 16:34:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 04/18] vfio: Add host iommu device instance into
 VFIODevice
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
 <20240201072818.327930-5-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240201072818.327930-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Zhenzhong,

On 2/1/24 08:28, Zhenzhong Duan wrote:
> Either IOMMULegacyDevice or IOMMUFDDevice into VFIODevice, neither
> both.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/vfio/vfio-common.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 8bfb9cbe94..1bbad003ee 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -32,6 +32,7 @@
>  #include "sysemu/sysemu.h"
>  #include "hw/vfio/vfio-container-base.h"
>  #include "sysemu/host_iommu_device.h"
> +#include "sysemu/iommufd.h"
>  
>  #define VFIO_MSG_PREFIX "vfio %s: "
>  
> @@ -132,8 +133,18 @@ typedef struct VFIODevice {
>      bool dirty_tracking;
>      int devid;
>      IOMMUFDBackend *iommufd;
> +    union {
> +        HostIOMMUDevice base_hdev;
I don't think we want the base object above to be usable here

Thanks

Eric
> +        IOMMULegacyDevice legacy_dev;
> +        IOMMUFDDevice iommufd_dev;
> +    };
>  } VFIODevice;
>  
> +QEMU_BUILD_BUG_ON(offsetof(VFIODevice, legacy_dev.base) !=
> +                  offsetof(VFIODevice, base_hdev));
> +QEMU_BUILD_BUG_ON(offsetof(VFIODevice, iommufd_dev.base) !=
> +                  offsetof(VFIODevice, base_hdev));
> +
>  struct VFIODeviceOps {
>      void (*vfio_compute_needs_reset)(VFIODevice *vdev);
>      int (*vfio_hot_reset_multi)(VFIODevice *vdev);


