Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2C4C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 09:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwIVN-0000Y7-NS; Mon, 15 Apr 2024 05:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwIVL-0000Sf-0z
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:19:59 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwIVJ-0000ZN-7Z
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:19:58 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2da63269e75so10019531fa.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 02:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713172794; x=1713777594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LOqENKHtQAIVxNF2sHpgB3aN5FNf2of++gKu2P+laVM=;
 b=EQUYGp3T3otFUSJUgPMLIhCKSELssmPp6qHhwGGeGaZXD1fCjye9dT011sk1n4AUqR
 I3gV3KoRgxNIA+r10I9tXJpntnYU9xvjaZkHsLmPw3ta0ZwmUfEYseeVKFIy+2sApuK+
 9Gjp1jyhdFMgAzrpV70p13Lt8guj4RwMPmP+pZsytn36zaQR/UlGrJjL0aYRI1GVXbuO
 M23Lv9AHM+sKZUrlwthDqLsGu8tyZLh2yVE2okeiltOQEvCAtj1TXSxU3kVbkClJThdp
 ztd6/PapbLrYMNyDKdJfQoycpV589m1B5gP2ITUUz+QZynMJYbnfKXkdXRltVIBvTcwb
 EDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713172794; x=1713777594;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LOqENKHtQAIVxNF2sHpgB3aN5FNf2of++gKu2P+laVM=;
 b=LpHFJOrzzbqRtLsTnFjGgBaPS8/y7g6r6fHcHTJQUb0SKjOJDt/ugfI5HDeWqsLgCQ
 Q/PV8wmGJei1t8NgG0q2NJeWrrNrRGLUKKaSTMLck0PCEL4eTcgEyzzsgW7lQ11yI/QU
 tMzqdN6QPqhgXXkZuAosT4qUN4+adF7pRS3T25wooWGcyG/jhUderhC0jDhE4TJUxZZb
 taWY5Z7ui/ES6tTWqz7fCkYE/w058rs+QTSfZq703ZuUYsSxoRljG9V6m4sB3NN2jCZB
 uOu8iebA/zRBta0cSLxKDdZH8gC32O99yecOGB9EvQuM8vbZYa/x6So6QXIsMdtxUYKJ
 JOXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLi/bG7A54agB0oT0v4tnUlszfMB82g6m+2ZFtE4Ogtmc3X7UVvEtnZer9mpdE3MDsserA2Rss8TOXW6rEDeEtW3N9f48=
X-Gm-Message-State: AOJu0Yw9Hw06rhHJmKpM+qPpc6N0kuJ3M2ho5f8XrgtZUAEC1f2NPUqc
 4mrfM+htjmgD2Itm11nva4XXYMqYBi1bweBAA21iuomHrqXVG8rDTkBCpCijjxgEqAf7TkPjTtw
 k
X-Google-Smtp-Source: AGHT+IHf1n1KmPvfRuP8BTe1ZFZjKtrOB6Zr4HhZAwQYPPrlWFHnGvr6o9S8ARlNs6rPrpzAm9tBtw==
X-Received: by 2002:a05:651c:205a:b0:2d8:8232:8c6d with SMTP id
 t26-20020a05651c205a00b002d882328c6dmr5755224ljo.52.1713172794087; 
 Mon, 15 Apr 2024 02:19:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 j18-20020a5d6052000000b00343d1d09550sm11539838wrt.60.2024.04.15.02.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 02:19:53 -0700 (PDT)
Message-ID: <9e71a87e-ad23-4048-bc9a-c26dfafa646c@linaro.org>
Date: Mon, 15 Apr 2024 11:19:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] vfio: Introduce HIODLegacyVFIO device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240408081230.1030078-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/4/24 10:12, Zhenzhong Duan wrote:
> HIODLegacyVFIO represents a host IOMMU device under VFIO legacy
> container backend.
> 
> It includes a link to VFIODevice.
> 
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h | 11 +++++++++++
>   hw/vfio/container.c           | 11 ++++++++++-
>   2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b9da6c08ef..f30772f534 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -31,6 +31,7 @@
>   #endif
>   #include "sysemu/sysemu.h"
>   #include "hw/vfio/vfio-container-base.h"
> +#include "sysemu/host_iommu_device.h"
>   
>   #define VFIO_MSG_PREFIX "vfio %s: "
>   
> @@ -147,6 +148,16 @@ typedef struct VFIOGroup {
>       bool ram_block_discard_allowed;
>   } VFIOGroup;
>   
> +#define TYPE_HIOD_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
> +OBJECT_DECLARE_SIMPLE_TYPE(HIODLegacyVFIO, HIOD_LEGACY_VFIO)
> +
> +/* Abstraction of VFIO legacy host IOMMU device */
> +struct HIODLegacyVFIO {
> +    /*< private >*/

Please drop this comment.

> +    HostIOMMUDevice parent;

Please name 'parent_obj'.

> +    VFIODevice *vdev;
> +};


