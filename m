Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D99C3601A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 07:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzsuH-0006LC-Od; Wed, 02 Apr 2025 03:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tzsuF-0006Kk-89
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 03:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tzsuD-000722-Di
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 03:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743580379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wriINkZkZpGWijzRwmZBFYZy0bTL8sr377Vbjy19pTQ=;
 b=M0tPR+673QrF3OI5NGdh8hSI8C4UQF/zxz6DouOmvBQOmmMLM9tVlz4fantomKadTPzUV6
 oqOb76TBvMQaWzi27bVUdjAKCfGr5CI6DIM4+EhcwOSLHplc06oBN3tmTjiiPUAkzkvxmS
 qSslcoRPTsfkulGY8elbf5WFspIR0DY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-MS1k8WdcPterIyF-DhPMJQ-1; Wed, 02 Apr 2025 03:52:56 -0400
X-MC-Unique: MS1k8WdcPterIyF-DhPMJQ-1
X-Mimecast-MFC-AGG-ID: MS1k8WdcPterIyF-DhPMJQ_1743580375
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so57198885e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 00:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743580375; x=1744185175;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wriINkZkZpGWijzRwmZBFYZy0bTL8sr377Vbjy19pTQ=;
 b=SAuETzmn34iItm5PDEwr9jPpuGq+ki4hOGXqns5JbrKx7iSbaqJxAr0pUmK38KfQfW
 /2ywFiKkChuoW35JmkIFpqPhmd7hNQqNTBXhpT0MEzWzg28Q3qaIH+F2nF2K93gYCsjO
 JULdQME+tUOXI+QlLKBhzgyJu4e0YGuniHCco0rAcR9IlCfJQo7vKAAPUL0uDWx4Coev
 Ik5sBIZ+7XLcG290CJgae7NQ+8ufaA19cwd8jbgoflWlx4E1zTKKutAMB5QYzI+qSpFe
 WTcQD0CxXFQGK+7iTRi8cXLPySgUx1aU0ja8edgcYQ9QtztOyoJQqZoljFJfTAeFefVZ
 J2fA==
X-Gm-Message-State: AOJu0YxN0a8tE1cEATZkaAmw/0nNYI9SAoF8X9cqMrfDjXIUkF6bz/Sq
 w5L7zZSQgHb2av46ihxclpPgdUFYqScjEf1EVLQX8qtVgzGHlPqoIbHcRXlPQcxQ3mJxir3xzwv
 AvLbqWRm15uP4xjbFojmUVqs1BkucQRxA8hFzNBVUvP9wEVE2wQpe
X-Gm-Gg: ASbGncuGDIUSNZrYXS+h5zMUBOfZVSW2K7Cf7IjhylJ0VIESOSNj8ZHseU4ICatAjto
 tdW+VbgkIsQoBrgrohKNZ8LPYrH0nppvqy04uEw34AKK19kIQb5ni4v5ogQ5btNheixMRuvTFse
 m5gbKvFCaKNhk/QeGPMnG4Q/9vEQZ+cB84ZfA/jxjbhhIJ44n5KPdw53eJnl/3vtkyFluUsoMx9
 2aJSGFbSrBGFoBF6aFw+txLYa2Ijxzwh38de5OYZrmu5UWAtqScaXMilCK5DpVCIdur0O3MgEiB
 sx0p/FlPvXt4/qszTCrRZh3inLZfyB92iF2cQWMG
X-Received: by 2002:a5d:6d84:0:b0:391:2dea:c98d with SMTP id
 ffacd0b85a97d-39c120cbb15mr11071498f8f.8.1743580375289; 
 Wed, 02 Apr 2025 00:52:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH58/i0MiAlhMCXt0uyd8c1/uXplQjWuZHMvu1y2xb56skKKRRxzYcEBlHVJ5xdSN/WW5eVSA==
X-Received: by 2002:a5d:6d84:0:b0:391:2dea:c98d with SMTP id
 ffacd0b85a97d-39c120cbb15mr11071480f8f.8.1743580374935; 
 Wed, 02 Apr 2025 00:52:54 -0700 (PDT)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb5fd125fsm12436345e9.12.2025.04.02.00.52.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 00:52:54 -0700 (PDT)
Message-ID: <1584a6d0-63b8-459b-9f4b-84192a9256e1@redhat.com>
Date: Wed, 2 Apr 2025 09:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] hw/s390x: compat handling for backward migration
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Daniel Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250331140041.3133621-1-shalini@linux.ibm.com>
 <20250331140041.3133621-5-shalini@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250331140041.3133621-5-shalini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 31/03/2025 16.00, Shalini Chellathurai Saroja wrote:
> Add Control-Program Identification (CPI) device to QOM only when the virtual
> machine supports CPI. CPI is supported from "s390-ccw-virtio-10.0" machine
> and higher.
> 
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> ---
>   hw/s390x/event-facility.c  | 27 ++++++++++++++++++++++-----
>   hw/s390x/s390-virtio-ccw.c |  1 +
>   2 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index c0fb6e098c..cb23bbc54b 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -22,6 +22,7 @@
>   #include "hw/s390x/sclp.h"
>   #include "migration/vmstate.h"
>   #include "hw/s390x/event-facility.h"
> +#include "hw/qdev-properties.h"
>   
>   typedef struct SCLPEventsBus {
>       BusState qbus;
> @@ -54,6 +55,7 @@ struct SCLPEventFacility {
>       bool allow_all_mask_sizes;
>       /* length of the receive mask */
>       uint16_t mask_length;
> +    bool use_cpi;
>   };
>   
>   /* return true if any child has event pending set */
> @@ -455,11 +457,20 @@ static void realize_event_facility(DeviceState *dev, Error **errp)
>           qdev_unrealize(DEVICE(&event_facility->quiesce));
>           return;
>       }
> -    if (!qdev_realize(DEVICE(&event_facility->cpi),
> -                      BUS(&event_facility->sbus), errp)) {
> -        qdev_unrealize(DEVICE(&event_facility->quiesce));
> -        qdev_unrealize(DEVICE(&event_facility->cpu_hotplug));
> -        return;
> +    /*
> +     * Add sclpcpi device to QOM only when the virtual machine supports
> +     * Control-Program Identification. It is supported by "s390-ccw-virtio-10.0"
> +     * machine and higher.
> +     */
> +    if (!event_facility->use_cpi) {
> +        object_unparent(OBJECT(&event_facility->cpi));
> +    } else {
> +        if (!qdev_realize(DEVICE(&event_facility->cpi),
> +                          BUS(&event_facility->sbus), errp)) {
> +            qdev_unrealize(DEVICE(&event_facility->quiesce));
> +            qdev_unrealize(DEVICE(&event_facility->cpu_hotplug));
> +            return;
> +        }

Hmm, first doing object_initialize_child() in init_event_facility() and then 
unparenting it here again in case we are running with an older machine type 
is a little bit ugly. I wonder whether it would be nicer to add the QOM 
object from ccw_init() init instead, similar to what we do with the 
SCLP-console in s390_create_sclpconsole() ? If you've got some spare 
minutes, could you please give it a try whether that looks nicer?

  Thanks,
   Thomas


