Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B034C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trcxm-0003sI-Nh; Mon, 10 Mar 2025 09:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trcxh-0003ri-P8
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trcxf-0004wj-MQ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741612466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1YSaZOxdBQT0fHnKnAfQMNX+N3+DpnclNdpnsUrk8f8=;
 b=KiIz+YcAkBwZAEVL2n89AuWSM89eBSkEB4QbJOtrtnyQfZ9yMfY7BrtqkqBkUBIPgMoGmC
 K1nnwtulFwMkEb0BBTOCNGa68c03twiaA+F6xx0LJMpfZxR29/IKTQAIYIS2W6t/HvaKdl
 txkJfTAaS6D9gOL3rKc8dfHe2yOK1tw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-9y0jEgZFNJukooBmpHEPBA-1; Mon, 10 Mar 2025 09:14:23 -0400
X-MC-Unique: 9y0jEgZFNJukooBmpHEPBA-1
X-Mimecast-MFC-AGG-ID: 9y0jEgZFNJukooBmpHEPBA_1741612462
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cfda30a3cso2897145e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 06:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741612462; x=1742217262;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1YSaZOxdBQT0fHnKnAfQMNX+N3+DpnclNdpnsUrk8f8=;
 b=GLn3x7004kwCscePca6wfEkpOsgij75YPyCyDCWlvX9pRqw2r6qgDC13wkbphdXMni
 iatvHqE8kxfCV3BaLAcnJ93K1qgHlQfOTwmneNhLKlQK2PB4o4XeS16G6m2clDSXvmkX
 +CdeI4x/Sg79JtwMHuqNbAO+QcbWKBbGD1rn1jK/pF2oU182zwuL3cm9GggJo5RWU5gE
 qlWQkJ1XinSof1xRG67JYvz8HSlTdXZAAjbW0F3dqwXG1EZzMCHXORvb9cFZkwPs3Ga2
 8RrJq5yfL9oOOtOCG/F2/Y3VLqzqHnHOxHB+bdCHozFofeWW4GprdeGAgQ3aYV+FC4+n
 ynbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2loCobqGrb3oCP4t2Cjq1Sk+VERMkd3Qh6JaeRpAwmR+PaSWo0OvNGmVs5vlDdfGqeAcnC5lZwu36@nongnu.org
X-Gm-Message-State: AOJu0YwffeGfDkKiMxQPzfIgn96BpPDY6hbyjL7SIN0yBGmsR+0y2wHW
 2MAA9EYArpN1Oe1xZnKFqHHjWzdUiK8xIRk+mfKKBvYigi+a0Cej5L8vM5JbcRF5XIiDrfIimGD
 Xh2GEXqOH4zcp+K2Y34XPV1C2DRv9VTP+aE98sKRfJRI5hZhKGGSe
X-Gm-Gg: ASbGncs3wgM6yjMgBITuN22ORNrU74FQNs7G8I08QeE3Tf4F0cy2cFeLB7K//Zcrarb
 YEfXUPUyCtkUWbjY9FvquD2/eDioNlazkLm19OThQp27fm97sl4pt0/T5hpO1QxbzLdbgvORFgU
 kfV8hoTPyVjpdcG4Ee6xiq6ofPKZINJBepZs4ISG+7uPfTd024XeGAS5SAcrbJMhuQNtFW1HNya
 MWrFOVbBUDw3DHvhlYMmfW6hgFtOJQqvsanB3+l7bnkz1WhMf544+BnODzNjtbMtha5ttqECfWu
 38EUwUeRxYhCbSpFGLBsD1qbqRDXAYcvZMCDUmIRljS5lnZL/wwTZw==
X-Received: by 2002:a05:600c:35d1:b0:43b:ca39:6c81 with SMTP id
 5b1f17b1804b1-43c601d94e5mr73389845e9.9.1741612462413; 
 Mon, 10 Mar 2025 06:14:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/JHw2maAP0GWQOxdQomoM5AbFuOEGkPhmSoFbZ1KJBY1EeVFjwgkd0TjFdJ14WLUhm2dnrA==
X-Received: by 2002:a05:600c:35d1:b0:43b:ca39:6c81 with SMTP id
 5b1f17b1804b1-43c601d94e5mr73389545e9.9.1741612462038; 
 Mon, 10 Mar 2025 06:14:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf892d380sm33578735e9.24.2025.03.10.06.14.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 06:14:21 -0700 (PDT)
Message-ID: <ed182b44-3dd9-4ddf-9b8f-54882bc0d45f@redhat.com>
Date: Mon, 10 Mar 2025 14:14:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/migration: Use BE byte order for device state
 wire packets
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <dcfc04cc1a50655650dbac8398e2742ada84ee39.1741611079.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <dcfc04cc1a50655650dbac8398e2742ada84ee39.1741611079.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/10/25 13:53, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Wire data commonly use BE byte order (including in the existing migration
> protocol), use it also for for VFIO device state packets.
> 
> This will allow VFIO multifd device state transfer between hosts with
> different endianness.
> Although currently there is no such use case, it's good to have it now
> for completeness.
> 
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> --->   hw/vfio/migration-multifd.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)



Applied to vfio-next.

Thanks,

C.



  
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index a9d41b9f1cb1..e816461e1652 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -13,6 +13,7 @@
>   #include "hw/vfio/vfio-common.h"
>   #include "migration/misc.h"
>   #include "qapi/error.h"
> +#include "qemu/bswap.h"
>   #include "qemu/error-report.h"
>   #include "qemu/lockable.h"
>   #include "qemu/main-loop.h"
> @@ -208,12 +209,16 @@ bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
>           return false;
>       }
>   
> +    packet->version = be32_to_cpu(packet->version);
>       if (packet->version != VFIO_DEVICE_STATE_PACKET_VER_CURRENT) {
>           error_setg(errp, "%s: packet has unknown version %" PRIu32,
>                      vbasedev->name, packet->version);
>           return false;
>       }
>   
> +    packet->idx = be32_to_cpu(packet->idx);
> +    packet->flags = be32_to_cpu(packet->flags);
> +
>       if (packet->idx == UINT32_MAX) {
>           error_setg(errp, "%s: packet index is invalid", vbasedev->name);
>           return false;
> @@ -682,9 +687,9 @@ vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
>   
>       packet_len = sizeof(*packet) + bioc->usage;
>       packet = g_malloc0(packet_len);
> -    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
> -    packet->idx = idx;
> -    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
> +    packet->version = cpu_to_be32(VFIO_DEVICE_STATE_PACKET_VER_CURRENT);
> +    packet->idx = cpu_to_be32(idx);
> +    packet->flags = cpu_to_be32(VFIO_DEVICE_STATE_CONFIG_STATE);
>       memcpy(&packet->data, bioc->data, bioc->usage);
>   
>       if (!multifd_queue_device_state(idstr, instance_id,
> @@ -734,7 +739,7 @@ vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
>       }
>   
>       packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
> -    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
> +    packet->version = cpu_to_be32(VFIO_DEVICE_STATE_PACKET_VER_CURRENT);
>   
>       for (idx = 0; ; idx++) {
>           ssize_t data_size;
> @@ -755,7 +760,7 @@ vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
>               break;
>           }
>   
> -        packet->idx = idx;
> +        packet->idx = cpu_to_be32(idx);
>           packet_size = sizeof(*packet) + data_size;
>   
>           if (!multifd_queue_device_state(d->idstr, d->instance_id,
> 


