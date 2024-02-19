Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4306DC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 15:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc5pm-0000GI-DJ; Mon, 19 Feb 2024 10:45:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rc5pg-0000DR-OY
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:45:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rc5pe-00011I-JB
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708357525;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=voS9eT8qh6lq+PojwwQhtdgbtAE1EnfOW9rmavkYfrw=;
 b=Z/hM7AE1IQ2mVxiaX/naXDQgwV9yzgWrhM1XhScSavw+t7Ljre7vO27l75Kr4MVk4CjQsK
 gTLL+aSET4n5AiQxnG+taVaTddMZkOS0oGSRLBp0rzpD3QWc1RVf/s9DWOiJpRb69+DfQ4
 UJx1jFNIodQLBDs+BKnT6fUezY8Wzhg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-mjqCuf0_MgaD-pUVrz4tWQ-1; Mon, 19 Feb 2024 10:45:24 -0500
X-MC-Unique: mjqCuf0_MgaD-pUVrz4tWQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7873b392eb3so551507385a.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 07:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708357524; x=1708962324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=voS9eT8qh6lq+PojwwQhtdgbtAE1EnfOW9rmavkYfrw=;
 b=Uynxq3T0PwuGKUzubvrpCWWEPiOxswsWQQNhoqv9sDNi+2rNayFcjnQUaPl7Nt7tJn
 qg77oUsQGw033amgaSGQSWSnyKSI+qHXAASoDiMeJScOJAwh1s2iHDC/EQs21HiUIiuT
 3zDI+Y1y6GBNFxjau3DnSjGGeBATiHboy3wpbswzn+HZd5C06LlEYI1/B6RmJpNmL7bA
 ZTCQg+BWVHmbiQE19ldkDHG0C+a4ABfotymWokP0S7xubFGT6qTYqfW0DoYue4wlUTqG
 IW8yDXscipQZK6QgvXeZT6YR6PAXo7kV/rRaJJtOGLWcXcKViGuqrEu6Ua/hFtmGAZp4
 R0fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMOJ/CUfcehLwnzcxDZEyCBtZQwmnMNbcfqFYQUs7z2qQm/7MzcOr+EkXwh6OL0+oMkMwotciv3UHkU9joEZKVxUOTBS8=
X-Gm-Message-State: AOJu0Yx6XQ0v+G721dALGvQb6LvPpF9YUqmzr5b7d2+krScl2tcH/Jzm
 td7xSN6eHzok8cQhXaj0QJMyWWr+3b3SOexlNMhrBowaof7wlFUOUh1xwapC7ROWyvlxos7AtFX
 o1pmsCsGRodTaSOfj+5idG/q9i6B+0KbWmYB62EoTVoG+E6n2Wwld
X-Received: by 2002:a05:620a:801b:b0:787:730b:11e9 with SMTP id
 ee27-20020a05620a801b00b00787730b11e9mr1261408qkb.36.1708357523850; 
 Mon, 19 Feb 2024 07:45:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKvrfi8JvVjzHMxyxYWZ8ZI1iIcgj6Nlik4XD0YCl72e+1bcaNvpJKcOwIyx73F5DjWg/Dew==
X-Received: by 2002:a05:620a:801b:b0:787:730b:11e9 with SMTP id
 ee27-20020a05620a801b00b00787730b11e9mr1261372qkb.36.1708357523588; 
 Mon, 19 Feb 2024 07:45:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 vq26-20020a05620a559a00b007873b3d0573sm2570572qkn.123.2024.02.19.07.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 07:45:22 -0800 (PST)
Message-ID: <60307c1a-bff5-48ff-99a3-a44c1fd23db2@redhat.com>
Date: Mon, 19 Feb 2024 16:45:17 +0100
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
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
> +        IOMMULegacyDevice legacy_dev;
> +        IOMMUFDDevice iommufd_dev;
I think you should rather have a HostIOMMUDevice handle.

host_iommu_device_init cb would allocate the right type of the derived object and you would store the base object pointer here.

Eric
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


