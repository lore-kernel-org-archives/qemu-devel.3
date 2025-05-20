Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF916C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOhl-0000c2-Cr; Tue, 20 May 2025 11:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHOhj-0000bm-DM
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHOhh-0004uK-7e
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747754187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pMbS6MXhAVfMMV0Lqo565rdqCrpEbuGU9c6h4Nte618=;
 b=LpP/xRBvpffYifdwuN5dht/Jw1sikK3Gdvx5Xzqz3hazGdnlbF6+pEdLe9k4wSr7aMCkri
 4VlnUiT3zXdnuK8Nza6Hx+ukEkERjSx8CqMO4LwmsxjIdMKqr7zeARZ7qqXeM9DN4Xi+2z
 AmW2eCdJvCXqt4kUb6THG5hTqF0z2C0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-8O0mm9BmMoaOuHQ2K-mR4w-1; Tue, 20 May 2025 11:16:25 -0400
X-MC-Unique: 8O0mm9BmMoaOuHQ2K-mR4w-1
X-Mimecast-MFC-AGG-ID: 8O0mm9BmMoaOuHQ2K-mR4w_1747754184
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a3684a5655so1763444f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 08:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747754184; x=1748358984;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pMbS6MXhAVfMMV0Lqo565rdqCrpEbuGU9c6h4Nte618=;
 b=YBSICUXIYY80M5bk3d9L6HYaCrATW6IFsdTNUdlYCWvlAu+opwn50ANZh3zdXuTJxP
 JaR6edB+jsXEhpiCzEtdPAArDiyvE7x5H9lU6r23x8BnZUFsCE9ZFE4t44FnWqNNJnbo
 mDAKAUAvAr7M5qyJJcHfDWmZ9LeQVRILo7Xt16DMbTFeCDFOpunpF4eGT2gPgjJ6voss
 PbPcC6acFCy/Fv/vLhXHGvh8dm4u62eGEd9vNAfEQ1Hycazq9urAxfMtOGyJr4kYViyr
 KsLqMe9Ko0PuycJ88VVtif/7FOfGbthcJkiwZe3IG1p/W7nqxxFUTW2r4/FkqJGQR3do
 F4ag==
X-Gm-Message-State: AOJu0YwkPenReqcqnlCtwP0UXCeJ9QCPyVCMeq6oPyXlB4LMM/gxZVe1
 8E+YUoSOmKoDbpah67vo+YvldcVvh8hBi4LzcNZ+HO3BZPZMdx3G2W7JqG2Ms54FwzIzzX3opwb
 8FofRyjRS30X7p391AC6P68uERimyO2LE7348rxfTROpHKHU7MjiVbylP
X-Gm-Gg: ASbGnctPh09AJH2NkO1fTjmveL95IFTa+/aJtEVPgLgxjVbqY8FjexOa0/GmHJpKXXk
 2Gj8zPeapG9GJsWJ8UrWc9+X6y24CkV9u9xExuoxE7bYnNFrGqBvg8YzbCWdkUhWPYftMds+asA
 DnvK4u/TgwcuO12tXSaB7ei85Fw0EWd7ZYEaI9jdHoEOlwsOVu5F4Rn77Va1ZPIjjYsMohzWMaj
 CvCWVdO4XGbEXzWgBCb1FCV8vSYvK9l8JOyrmOgQkr/ignu6Q4eEpN+lAI93pLHXGHKksXO4+iU
 YTNpDNWbl9cixw==
X-Received: by 2002:a05:6000:184c:b0:3a3:6aa4:bf28 with SMTP id
 ffacd0b85a97d-3a36aa4bfe0mr9747150f8f.10.1747754184275; 
 Tue, 20 May 2025 08:16:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ8V25wibgocO+xB92awbcwRJFOHdwAJ517gol3TbCIFo9DfBQsImXvhVghYptcP9WRzi/bA==
X-Received: by 2002:a05:6000:184c:b0:3a3:6aa4:bf28 with SMTP id
 ffacd0b85a97d-3a36aa4bfe0mr9747116f8f.10.1747754183882; 
 Tue, 20 May 2025 08:16:23 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a366e08747sm13425215f8f.95.2025.05.20.08.16.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 08:16:23 -0700 (PDT)
Message-ID: <20486914-1752-4710-b000-52ee04d4106d@redhat.com>
Date: Tue, 20 May 2025 17:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/timer/hpet: Adjust num_timers in hpet_init()
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250520152750.2542612-1-zhao1.liu@intel.com>
 <20250520152750.2542612-3-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250520152750.2542612-3-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/20/25 17:27, Zhao Liu wrote:
> Currently, HPET adjusts num_timers in hpet_realize(), and doesn't change
> it in any other place. And this field is initialized as a property.

Properties are initialized *after* hpet_init.  For hw/timer/hpet you can 
check s->num_timers and return an error if it's out of bounds, but for 
the Rust version we don't have Error** support yet. :(

Queued 1-4-5 for now.

Paolo

> Therefore, it's possible to move such adjustments to hept_init(), so
> that Rust side can synchronize this change.
> 
> Adjust num_timers in hpet_init().
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/timer/hpet.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 0fd1337a1564..48b1a9289f83 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -682,6 +682,12 @@ static void hpet_init(Object *obj)
>       /* HPET Area */
>       memory_region_init_io(&s->iomem, obj, &hpet_ram_ops, s, "hpet", HPET_LEN);
>       sysbus_init_mmio(sbd, &s->iomem);
> +
> +    if (s->num_timers < HPET_MIN_TIMERS) {
> +        s->num_timers = HPET_MIN_TIMERS;
> +    } else if (s->num_timers > HPET_MAX_TIMERS) {
> +        s->num_timers = HPET_MAX_TIMERS;
> +    }
>   }
>   
>   static void hpet_realize(DeviceState *dev, Error **errp)
> @@ -710,11 +716,6 @@ static void hpet_realize(DeviceState *dev, Error **errp)
>           sysbus_init_irq(sbd, &s->irqs[i]);
>       }
>   
> -    if (s->num_timers < HPET_MIN_TIMERS) {
> -        s->num_timers = HPET_MIN_TIMERS;
> -    } else if (s->num_timers > HPET_MAX_TIMERS) {
> -        s->num_timers = HPET_MAX_TIMERS;
> -    }
>       for (i = 0; i < HPET_MAX_TIMERS; i++) {
>           timer = &s->timer[i];
>           timer->qemu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, hpet_timer, timer);


