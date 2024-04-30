Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB83CC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jzH-0004Vk-J1; Tue, 30 Apr 2024 05:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1jzE-0004PC-7o
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:41:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1jz9-0005ri-7t
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714470074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ED85lim9n322dDSDZk115uNsoc0H9fI+9cHrfzqApe8=;
 b=Pm4JaA19vymW18hqPABWjwr/5DGuRltkgF157ltztT+PV1jNb457JXBkP3n7AE2xqOP+BA
 +Ih8XhnVt8YsF/lIatj5EiN03hkc0Ha/5dTMdYTwb7oLHaOkzAWhit1dRfgDq5YqJMbui3
 +Y00nOOjwSFQty1b0zp1dxBXoyxKqis=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-xeRxhxGdMJaaB0GUpCi9Dw-1; Tue, 30 Apr 2024 05:41:12 -0400
X-MC-Unique: xeRxhxGdMJaaB0GUpCi9Dw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5721458fa6aso2716404a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 02:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714470071; x=1715074871;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ED85lim9n322dDSDZk115uNsoc0H9fI+9cHrfzqApe8=;
 b=oD2TQ+4NTh/ed+YsPuZO6q+aLo1Hsz+aa6HfndsE+F1xp/DCsxJ4R7rUrbwHByQLFK
 AVlAUa4e9pzUaAO/veGYCJNAiNqlpfP49i34xLRhdtP1crAHEEp6tdJKZA0kTeD7i6As
 89zlGQEx2ewummdL/rdhgdWkr614yxDvlfH7fkZkqoEnY9lRBfCwEJ1yGJXskSojTtOd
 4xGE5SbQH/mpC1YoW+J9qw9DPvH1+bWpx830l35DGV652iVzjg9BibLbbCZZpvgdtoGw
 CF2Ofl7JkvXBjKOcia7Fu5csvXvgg7oWTzTKUM3+efzRrF2y4EiYgb21CyNV8Mdv8nwl
 DHnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4lgY08JT/UftpY6twgpAx4mhColcZyImMlcjM0aMKTR8TplZ0BHDjzBlBr6u8XLCXGKA2t/pMrba9ZHfO5yyVGcNaWzo=
X-Gm-Message-State: AOJu0YxhcavglWM4qJtSDEoStSBKfjKmLsW1zwemly1511tqHkYcaiSM
 GHAGMzkFiKbPFds23VitADxGzVINzLbHAj/tXMD4vxvCT6972pwBAiSwkXr8z4cwwukVMX0sxqq
 /ZeWArtFGHU8lGn5ToQ10tZ0FW67RIKHvbfnWFDF08qtt4BP1vMhf
X-Received: by 2002:a50:aad2:0:b0:572:a126:6760 with SMTP id
 r18-20020a50aad2000000b00572a1266760mr257304edc.11.1714470071770; 
 Tue, 30 Apr 2024 02:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs1lEi561nZMqwT6GhOZ+2/0bIKW+CWsLKl6o++Rdx8n0ettpUoANlZi/lYfeBk/l7ynUTBQ==
X-Received: by 2002:a50:aad2:0:b0:572:a126:6760 with SMTP id
 r18-20020a50aad2000000b00572a1266760mr257292edc.11.1714470071562; 
 Tue, 30 Apr 2024 02:41:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a0564020e0900b005729337f955sm838975edh.97.2024.04.30.02.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 02:41:11 -0700 (PDT)
Message-ID: <bc6b71f7-242f-4de4-b440-67689039886a@redhat.com>
Date: Tue, 30 Apr 2024 11:41:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH v3 06/19] range: Introduce range_get_last_bit()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-7-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
In-Reply-To: <20240429065046.3688701-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/29/24 08:50, Zhenzhong Duan wrote:
> This helper get the highest 1 bit position of the upper bound.
> 
> If the range is empty or upper bound is zero, -1 is returned.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/qemu/range.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/include/qemu/range.h b/include/qemu/range.h
> index 205e1da76d..8e05bc1d9f 100644
> --- a/include/qemu/range.h
> +++ b/include/qemu/range.h
> @@ -20,6 +20,8 @@
>   #ifndef QEMU_RANGE_H
>   #define QEMU_RANGE_H
>   
> +#include "qemu/bitops.h"
> +
>   /*
>    * Operations on 64 bit address ranges.
>    * Notes:
> @@ -217,6 +219,15 @@ static inline int ranges_overlap(uint64_t first1, uint64_t len1,
>       return !(last2 < first1 || last1 < first2);
>   }
>   
> +/* Get highest non-zero bit position of a range */
> +static inline int range_get_last_bit(Range *range)
> +{
> +    if (range_is_empty(range) || !range->upb) {
> +        return -1;
> +    }
> +    return find_last_bit(&range->upb, sizeof(range->upb));

This breaks builds on 32-bit host systems.


Thanks,

C.


> +}
> +
>   /*
>    * Return -1 if @a < @b, 1 @a > @b, and 0 if they touch or overlap.
>    * Both @a and @b must not be empty.


