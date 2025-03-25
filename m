Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B26C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twxrS-0008AF-0T; Tue, 25 Mar 2025 02:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1twxrP-00089C-CK
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 02:34:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1twxrM-0008BP-RG
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 02:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742884439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=m8v+dd8VTemIkLQSz3J8vaQPP1L9zDxva3sohta3IzA=;
 b=R6mVuFuXNwQV/Cg6PDCg6DTxv+oo4ZMDUFVBwkWCD+WIVjvthSxcxacr3mLbOGPKa1c4d6
 uacpa++YA6fgSX8F0u/peBvr5rMhGYLdlrnkZ5GgReBVrxHJO0IOIzhTUl/7X8FjvCt1bJ
 kQo5zPVZl9qr4ypK0EikBgKC3PrZoQ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-fqd0JW32MqmbBGONqwR57w-1; Tue, 25 Mar 2025 02:33:57 -0400
X-MC-Unique: fqd0JW32MqmbBGONqwR57w-1
X-Mimecast-MFC-AGG-ID: fqd0JW32MqmbBGONqwR57w_1742884436
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so42031115e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 23:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742884436; x=1743489236;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8v+dd8VTemIkLQSz3J8vaQPP1L9zDxva3sohta3IzA=;
 b=ve/DCHoXwIlHk9qXOE5UO6nzDUYO4YWEuSRwoRe8Pw41ja/xDVONTLQF1UbJ+DhFla
 shIYfFbKlLUS+EAIqH+a5lGSQAgiDxxC0STaME/xzEMF90F/42fbg3jqzY7uU/f1AdYm
 Yi/xnLNkmcySBMDjzzrCkzPVjgIAMTafRim3u54Aq2NYO3yYgizRtzNadmuUWwXW8Au4
 ACEkWbSIB3Tivsg+33FXjwvRmdOIuBXVza3LroSCSkjnLo3sR0/413XlM/+i5z6q4+5N
 LVSGdgFL9PDLJMJBLS8bItZJLJpWEqzZrBFtPvVwhyB2HvuFMqbScS1RcCTYnIZPgZzD
 LErg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+k+pjdKhIJ+IXmE0KCfecUZJ7f4XxU+t5ABmLg/9guotXdrijDwnMir/csY0/BttVkLDb54/7NNVu@nongnu.org
X-Gm-Message-State: AOJu0YwyIlXCzdXnP0WoFnc7tg6jfrKLn81e29ml64+OaE+0247hTorU
 gn3w5mWTZHcs72AGgWhxihOIVLvSh2N+MkZlqpba0QcJMovJhgqNyNXjcHyXH78EjDww7nj/53m
 I97EaeqB63m97prlWyE1ShSk4P5Rdal4aXCZe7GxoHNX8+LLBAwzNv0DHlB3meQs=
X-Gm-Gg: ASbGncvxfk6tOq5I5YfKLzIGodGjfqBlTIUumD4leXSC1njBkFwxBL3PPZC1bTZX+Bm
 bnqB3FsF6uIlSr4rTcvgQkRkZdpymY1vgNEvRrf/6tM3ylFoaOaG4siUaFOpPMf738USnTqVrB0
 6TtIfGykaewVeKKYaF77/E+h1SMm+KppCAoRosIJHGnnLBNAW0GIBSajbT8F1lRqFjIWh5KhNFX
 DJnO19X+e5BoRv0diyhLbFYiTW+D47Sy9EpOi4QaygxuCogtK/w5vcljFZHfnyBilrOWIZ+ZguE
 Lokal8Z96PfyQkOHdx35r+lnmUvIGq5w6xm9RD0y/eKy00wKauMkqQ==
X-Received: by 2002:a05:600c:3502:b0:43c:f969:13c0 with SMTP id
 5b1f17b1804b1-43d50a4f8d5mr151174145e9.29.1742884435813; 
 Mon, 24 Mar 2025 23:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZk6ErzTg4gwOpYJhbdD+Ulfj6PnbBrJemYearGWOGe0SteNx/7DKa2Rst/k6g7gUBTTSSjg==
X-Received: by 2002:a05:600c:3502:b0:43c:f969:13c0 with SMTP id
 5b1f17b1804b1-43d50a4f8d5mr151173885e9.29.1742884435377; 
 Mon, 24 Mar 2025 23:33:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed4b8sm190263245e9.35.2025.03.24.23.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 23:33:54 -0700 (PDT)
Message-ID: <1cc2dacb-76db-49ec-9dd0-18f0a9c98780@redhat.com>
Date: Tue, 25 Mar 2025 07:33:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] aspeed queue
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>
References: <20250323174541.406860-1-clg@redhat.com>
 <08930285-903b-4413-bd6e-20a14b2d15bb@tls.msk.ru>
 <2616d3e5-443c-477f-a024-317fadb76a59@redhat.com>
 <debb6c58-2a38-40d6-ac9c-b90c60ba8b69@tls.msk.ru>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <debb6c58-2a38-40d6-ac9c-b90c60ba8b69@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 3/24/25 22:08, Michael Tokarev wrote:
> 24.03.2025 23:46, Cédric Le Goater wrote:
> 
>>> Is there anything in there worth to pick up for stable series?
>>
>> you are fast !
> 
> I was just about to send final announcements for a bunch of next
> stable releases, and noticed another pull request has been merged.. :)
> 
> 
>> - "aspeed: Fix maximum number of spi controller" is QEMU 10.0 material.
>> - "hw/intc/aspeed: Fix IRQ handler mask check" was merged in QEMU 9.1
>> - "hw/misc/aspeed_hace: Fix buffer overflow in has_padding function"
>>     was merged in QEMU 7.1
>>
>> The last 2 deserve to be backported IMO. They will need some massaging.
> 
> The "buffer overflow" fix seems to be okay for 9.2, 8.2 and 7.2.
> 
> The "IRQ handler mask check" seems to be this (for 9.2). Does it look sane?

It does.

Thanks,

C.




> Author: Steven Lee <steven_lee@aspeedtech.com>
> Date:   Thu Mar 20 17:25:43 2025 +0800
> 
>      hw/intc/aspeed: Fix IRQ handler mask check
> 
>      Updated the IRQ handler mask check to AND with select variable.
>      This ensures that the interrupt service routine is correctly triggered
>      for the interrupts within the same irq group.
> 
>      For example, both `eth0` and the debug UART are handled in `GICINT132`.
>      Without this fix, the debug console may hang if the `eth0` ISR is not
>      handled.
> 
>      Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
>      Change-Id: Ic3609eb72218dfd68be6057d78b8953b18828709
>      Reviewed-by: Cédric Le Goater <clg@redhat.com>
>      Fixes: d831c5fd8682 ("aspeed/intc: Add AST2700 support")
>      Link: https://lore.kernel.org/qemu-devel/20250320092543.4040672-2-steven_lee@aspeedtech.com
>      Signed-off-by: Cédric Le Goater <clg@redhat.com>
>      (cherry picked from commit 7b8cbe5162e69ad629c5326bf3c158b81857955d)
>      (Mjt: update for before v9.2.0-2466-g5824e8bf6beb
>       "hw/intc/aspeed: Introduce IRQ handler function to reduce code duplication")
>      Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> index 126b711b94..495fd2bdfa 100644
> --- a/hw/intc/aspeed_intc.c
> +++ b/hw/intc/aspeed_intc.c
> @@ -92,7 +92,7 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
> 
>       trace_aspeed_intc_select(select);
> 
> -    if (s->mask[irq] || s->regs[status_addr]) {
> +    if ((s->mask[irq] & select) || (s->regs[status_addr] & select)) {
>           /*
>            * a. mask is not 0 means in ISR mode
>            * sources interrupt routine are executing.
> 


