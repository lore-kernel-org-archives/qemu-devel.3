Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF9EC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 20:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhyEh-000824-Kh; Wed, 06 Mar 2024 15:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhyEf-00081g-Nz
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:51:33 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhyEd-0008IS-Oz
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:51:33 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412fc5f5152so1726355e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 12:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709758290; x=1710363090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zDlwdnMzWpfgxirVMfSqhya+/ChMKA7X5OQPV9rxm4w=;
 b=LsYpDWV+9AEHDLa76SHCATGRmIcfqcApHca0lGvjE4pjs8CPSnILgWoj6YFPVP6Ep1
 ePST47r3B4ALfPmPZFHkB3+vZYan9DvvvuaZAkE8d0LFcwTB97bLJaiAJlVLE5jICjth
 sbpJ3uDu0jVWw1rGEYsfi9LoI2WQdiW+2ODL9oEq3VKJqv0utlV7u9ONLvbCSaL0rDsY
 uwklbzEVKAniNCt7gj6WUVGdwwQJ7Lz53c1trMO3oK2dTF4lBcpVARKqbbFb0ab/PHpX
 XhJboICFxxdyu1FdviqwubQCp2zxsBzzNEHhdIHsOapxFY0LTNbe/XIxqTxjr8OUMC44
 vTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709758290; x=1710363090;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zDlwdnMzWpfgxirVMfSqhya+/ChMKA7X5OQPV9rxm4w=;
 b=dc3BNCYsDezlg0SBn77c//115zAHpihyj0s/BynGdU0QYdbFx80Em1F+H4Eyc1OL/i
 VmeWqw5CS1aBcJmsU2PRLRQAi8u9lMG1skbpxdvEHhMNwnZbX1XhbZt5/hLflGtNMsbo
 BeAOhaiHlcezDIiBB9hQGBPHI3Ntkn7PRCMC7wOobTDr8gGNdrkd1V4/KdkVL/8Hc16O
 1wcQSkVSE2xcMYygUFD9TTbV0ZwHf6j5xy9I/JXokt7dR/kpw+k2/P1KU7IjAWIQelFU
 dgCYzv0I4kIoQnrRgVpJYfAJVb0kRpCceAUAO6Vfrs4r7ZP61p2FttJC/dHV1z8aZxXn
 nnZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsE9s/yujn/8Fvd/Irs/8t0BmZ3h8jlyPiJk+jX9xq178Esc5UC7kwn84omA37t7OoV6dP7nEXSYFSvQTDQ0CtWc01Tjs=
X-Gm-Message-State: AOJu0YxOKc7mZmltOvz3YDSjFzsvCEResTCBB8AL11MDNe2ao+eXlTrE
 TOwTRjwtJOnswn0In9YZnzkT0oasd/s6xPUgs3sjefWre4ZzMNvcbCUTILtyg5U=
X-Google-Smtp-Source: AGHT+IGTOolS7n/Q9BTdkXqMwqVx9WWwWQCsV4JAIkWDVUaG6XhclbUrrsK5ngxFR+EeDehgs1fOBA==
X-Received: by 2002:a05:600c:3b96:b0:413:49a:c3b0 with SMTP id
 n22-20020a05600c3b9600b00413049ac3b0mr791850wms.2.1709758289795; 
 Wed, 06 Mar 2024 12:51:29 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 14-20020a5d47ae000000b0033cf80ad6f5sm18920951wrb.60.2024.03.06.12.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 12:51:29 -0800 (PST)
Message-ID: <bd25d169-cd34-4670-9194-04ee0ff18ef5@linaro.org>
Date: Wed, 6 Mar 2024 21:51:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/25] vfio: Reverse test on vfio_get_dirty_bitmap()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-22-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240306133441.2351700-22-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/3/24 14:34, Cédric Le Goater wrote:
> It will simplify the changes coming after.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/common.c | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 5b2e6a179cdd5f8ca5be84b7097661e96b391456..6820d2efe4923d5043da7eb8deecb6ff20e1fd16 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1241,16 +1241,20 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       }
>   
>       rcu_read_lock();
> -    if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
> -        ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
> -                                    translated_addr);
> -        if (ret) {
> -            error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> -                         "0x%"HWADDR_PRIx") = %d (%s)",
> -                         bcontainer, iova, iotlb->addr_mask + 1, ret,
> -                         strerror(-ret));
> -        }
> +    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
> +        goto out_lock;
>       }
> +
> +    ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
> +                                translated_addr);
> +    if (ret) {
> +        error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> +                     "0x%"HWADDR_PRIx") = %d (%s)",
> +                     bcontainer, iova, iotlb->addr_mask + 1, ret,
> +                     strerror(-ret));
> +    }
> +
> +out_lock:

Alternatively use WITH_RCU_READ_LOCK_GUARD() to avoid label.

>       rcu_read_unlock();
>   
>   out:


