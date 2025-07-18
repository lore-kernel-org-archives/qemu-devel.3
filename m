Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693EAC83F34
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 21:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucsgo-0005Kn-Dr; Fri, 18 Jul 2025 17:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ucsFE-0005do-Pa
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ucsFC-0005LM-Iy
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752872625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mtLVFHZuD9Er5AmiQZBHgDo2cjPXZEH7W81bkTEKOI8=;
 b=fgJRmUsiau2qZ9DkKNrO0n2nMiP8Ut0XaWRKxAU5oL/5sIaKb6sv0KpEKbWUPwerE9CLlb
 QDJWDAOlR54Jk9ZIqSrB5kvM0XKjtO5h6JX4HBN0CrE1rcX1ycfrCnhvG/LWQuIA0BM7TA
 Fy4Rod6vy2zopG1h33fPr3wEoRwwaD4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-fxdQFB0mM3Cg_qDAwaIk3A-1; Fri, 18 Jul 2025 17:03:43 -0400
X-MC-Unique: fxdQFB0mM3Cg_qDAwaIk3A-1
X-Mimecast-MFC-AGG-ID: fxdQFB0mM3Cg_qDAwaIk3A_1752872623
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-455f7b86aeeso11957775e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 14:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752872622; x=1753477422;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtLVFHZuD9Er5AmiQZBHgDo2cjPXZEH7W81bkTEKOI8=;
 b=eZNNV7dcpVXj/IgUd9J/5Xp8UlfvvfJGWpLtKomUToxUASwL0n/xpsFijLLq7HXNoH
 jjkrW59tQZGMVS4IyrnDKefHkn6O4t/rmDBnkOwaAhTpqCfwmNjxCWiCOxmwHIrS1Qfj
 dPY7Wd+P0XTLL4LvI75bRUoTt0sWAXKHqww/Q2gCzZu7obR2Iog4UiAvpIcGkvjrWzcF
 s9XzrLycos9O/A52/u6RPY+tFMz6nD8V2QVTGSEyzl/0NcQdOHPvx7hD0EQWP3/OGE+w
 S72fNUB0/tlko95HQmxDBkFJXoZzYp60Llh2TLSrYPaMppdWi0MhVsj83aADz0tFPw6+
 WIyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhprarrWYHlpmWkrH2Es9PC/sMfrrs2/F/M698QJCrEjcba0HTE2S7lHqh/3WxPJRKFZLW7NjrnS70@nongnu.org
X-Gm-Message-State: AOJu0YxxoNboXD41JEe66jL/Fy2GpjMdeuifR4vwQGyjmbQubgiavHLg
 jQ5nFuRC2pWUTkQ01nl1kq/Ky8KCzEW9KF2NFbvXCrO3FO6LXIH1QkeVACRd+00lRFJ97/RVWoM
 n9cZNWsfifxJ8Zl+y+A13RXbYFLQ7bVAF3Wo6aajF6qEx2nsER3hoilo+
X-Gm-Gg: ASbGncuWtnIAPXrK1EvulF5jAZqCfQdzlwkZePqXk1TP9ly/0nMekVV2YTPNBtWIlwl
 d7G7pqxTEal0m1gwV5Jh+nNdPkkrF7pmR/boWhYIC/WMfgEVOm4eZtb9ZLb38QoWU/siOyf3DHP
 phBqq3hr04ilfXLJfWdfRgAtllqA0IvFX1gbB9qK5UjzOGDeqDicv0cv+WlREFsouVPd7i4GUZf
 QohKT9iFqY8iZacFlppqi/0lQofaD4j2L01TnD8Zw3rV9pphzteGTkQ4q9ME9pKM2lUYrcTkjal
 gUMiESb1P9Y9Qj4ExM6csYJp3mztYthahEf7yE/Wx0idx85xee+zWj5y6IyytLgKRSF6JMngpjM
 p1Q==
X-Received: by 2002:a05:600c:3b8e:b0:456:d1c:ef38 with SMTP id
 5b1f17b1804b1-4563609ddb1mr64544295e9.24.1752872622376; 
 Fri, 18 Jul 2025 14:03:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ2M+XFe3cA/0v5jSXFFa/Gk8BE0gsVvq3q0Y726S2mPRx0x+mbKDNdi3EUndFWarOxjMxwQ==
X-Received: by 2002:a05:600c:3b8e:b0:456:d1c:ef38 with SMTP id
 5b1f17b1804b1-4563609ddb1mr64544145e9.24.1752872621796; 
 Fri, 18 Jul 2025 14:03:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4563b75ca42sm28705065e9.31.2025.07.18.14.03.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 14:03:41 -0700 (PDT)
Message-ID: <4fff6291-7121-4b4e-b271-77b859206817@redhat.com>
Date: Fri, 18 Jul 2025 23:03:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/3] vfio: Move the TYPE_* to hw/vfio/types.h
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Shaoqin Huang <shahuang@redhat.com>
References: <20250718194349.65771-1-kraxel@redhat.com>
 <20250718194349.65771-3-kraxel@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250718194349.65771-3-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 7/18/25 21:43, Gerd Hoffmann wrote:
> From: Shaoqin Huang <shahuang@redhat.com>
> 
> Move the TYPE_* to a new file hw/vfio/types.h because the
> TYPE_VFIO_PCI will be used in later patch, but directly include the
> hw/vfio/pci.h can cause some compilation error when cross build the
> windows version.
> 
> The hw/vfio/types.h can be included to mitigate that problem.

As said earlier, the string literal "vfio-pci" could be used instead
of the TYPE_VFIO_PCI define and avoid the extra vfio header file.

C.

> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> Message-ID: <20250717100941.2230408-3-shahuang@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/vfio/pci.h   | 10 +---------
>   hw/vfio/types.h | 21 +++++++++++++++++++++
>   2 files changed, 22 insertions(+), 9 deletions(-)
>   create mode 100644 hw/vfio/types.h
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 826db8c1319b..0fd151c5dc2c 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -14,6 +14,7 @@
>   
>   #include "system/memory.h"
>   #include "hw/pci/pci_device.h"
> +#include "hw/vfio/types.h"
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/vfio-region.h"
>   #include "qemu/event_notifier.h"
> @@ -119,17 +120,8 @@ typedef struct VFIOMSIXInfo {
>       MemoryRegion *pba_region;
>   } VFIOMSIXInfo;
>   
> -/*
> - * TYPE_VFIO_PCI_BASE is an abstract type used to share code
> - * between VFIO implementations that use a kernel driver
> - * with those that use user sockets.
> - */
> -#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
>   
> -#define TYPE_VFIO_PCI "vfio-pci"
> -/* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
> -
>   struct VFIOPCIDevice {
>       PCIDevice pdev;
>       VFIODevice vbasedev;
> diff --git a/hw/vfio/types.h b/hw/vfio/types.h
> new file mode 100644
> index 000000000000..fa20c29b9fbb
> --- /dev/null
> +++ b/hw/vfio/types.h
> @@ -0,0 +1,21 @@
> +/*
> + * VFIO types definition
> + *
> + * Copyright Red Hat, Inc. 2025
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef HW_VFIO_VFIO_TYPES_H
> +#define HW_VFIO_VFIO_TYPES_H
> +
> +/*
> + * TYPE_VFIO_PCI_BASE is an abstract type used to share code
> + * between VFIO implementations that use a kernel driver
> + * with those that use user sockets.
> + */
> +#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
> +
> +#define TYPE_VFIO_PCI "vfio-pci"
> +/* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
> +
> +#endif /* HW_VFIO_VFIO_TYPES_H */


