Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA16C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 16:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJyBN-0004sv-Qk; Wed, 19 Jun 2024 12:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJyBM-0004s7-52
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 12:29:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJyBK-0000fX-2X
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 12:29:11 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-421798185f0so133025e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 09:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718814548; x=1719419348; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6McMYb4tODsXiOnKF4xaY6QdMGubIuN3c32Tk0SrYzQ=;
 b=XUQScL4HTQONfMoUFGjHlPMyj0jydmBB8GwCvOWAqu91A/juVS2KTJeqj9/WfWhEph
 n1yO6DCD0mRaXLo5CVRkI0WYTxfJ5OIn7tb07Y+y9Sj6rBvymJmNt50S8hO6CD4iLf+y
 JjZHXejzrwwaXrBUmCnBBLzMjYlWxNtYNMhOk5PonkESLMZpUcbtPOfhnbVeGUqlUcsB
 lHMmnk9coWR5tNuuNfDh+QkjAHDlZYID8Btly7ko120oSqMHx25FWlggeOf8ddUzQtlv
 Ifui/T6GzKMyGzxLPH0K7yc3dZ9sov6wwtNH1+s2RsIkF9Dad06lkrIvl71JkNLVMwZp
 4HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718814548; x=1719419348;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6McMYb4tODsXiOnKF4xaY6QdMGubIuN3c32Tk0SrYzQ=;
 b=sWkfyEUWOjDyUeoL37GgHjdTG3iiegQYKN6g8AvYUSvjXeG/FiNVREB1+NQCuONtIp
 bTo+mnfu9QvjtixbZHHOkpNW2YTqOtm6PGhQRfqc6Ophvo0i9t8qdQlA/6xAj5fm1p+E
 lKVMSJ395NOiGXEzqKcrVCh5ppsiRGNQS+OFrMZPlZGOGzJc4P5yvwdEyg80sCd346en
 qoUkiUUnZWvDkli4s3pXYmlwkUgVafe5IA2kB+QqsOFkmLEXYTdUpbMBEcZ2GGR4RTwt
 ICVY93MGjVxS/TutPQEuWDQeGL6qN/cQWLSJdWyMwUK0xdtl58tNIhgbOtQ6N//iI7mc
 WbsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSybRDTFhqciEAOG3PuguYBjz9NBCSjeKrpTcwDwCzrcEWISma5EGZYvfd1WGhE7joNuQ4bq92RmoOm/LwNm0CCdgV9Ro=
X-Gm-Message-State: AOJu0Yyx5tt7lQkEUeQ+LQ6go3qK+h0JzsmHhHC9pgzXfieNrJzfktlx
 7ApSGMWmJepEgUva3GLv7YhM75aVrBKgGFAynP9SFTHjd/Ptb9mhc/HtNY6zGV8=
X-Google-Smtp-Source: AGHT+IGomLXkwnBEdEtpYgFv+teXGUFprTyC/qFjKP2jZ06Dhnm7ukgMqUawqFf5pLkNE+uZMqEJqw==
X-Received: by 2002:a05:600c:3b8d:b0:421:7ac9:460c with SMTP id
 5b1f17b1804b1-4247529a970mr20910195e9.39.1718814548438; 
 Wed, 19 Jun 2024 09:29:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.133.105])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f6127d6dsm236265685e9.26.2024.06.19.09.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 09:29:07 -0700 (PDT)
Message-ID: <49028fcf-40a9-446c-9606-da4471a4456f@linaro.org>
Date: Wed, 19 Jun 2024 18:29:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/gpio/aspeed: Add bounds checking for register table
 access
To: Zheyu Ma <zheyuma97@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240618130928.3075494-1-zheyuma97@gmail.com>
 <bd15ab0597caad4564ca8f9498dfd3bbbe67df89.camel@codeconstruct.com.au>
 <CAMhUBjm6vBO8RWx9OqCvFqGBNVRy3j2FyhZM4tTp0dZwh3L2aA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAMhUBjm6vBO8RWx9OqCvFqGBNVRy3j2FyhZM4tTp0dZwh3L2aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 19/6/24 08:49, Zheyu Ma wrote:
> Hi Andrew,
> 
> On Wed, Jun 19, 2024 at 1:58 AM Andrew Jeffery 
> <andrew@codeconstruct.com.au <mailto:andrew@codeconstruct.com.au>> wrote:
> 
>     Hello Zheyu Ma,
> 
>     On Tue, 2024-06-18 at 15:09 +0200, Zheyu Ma wrote:
>      > Added bounds checking in the aspeed_gpio_read() and
>     aspeed_gpio_write()
>      > functions to ensure the index idx is within the valid range of the
>      > reg_table array.
>      >
>      > The correct size of reg_table is determined dynamically based on
>     whether
>      > it is aspeed_3_3v_gpios or aspeed_1_8v_gpios. If idx exceeds the
>      > size of reg_table, an error is logged, and the function returns.
>      >
>      > AddressSanitizer log indicating the issue:
>      >
>      > ==2602930==ERROR: AddressSanitizer: global-buffer-overflow on
>     address 0x55a5da29e128 at pc 0x55a5d700dc62 bp 0x7fff096c4e90 sp
>     0x7fff096c4e88
>      > READ of size 2 at 0x55a5da29e128 thread T0
>      >     #0 0x55a5d700dc61 in aspeed_gpio_read
>     hw/gpio/aspeed_gpio.c:564:14
>      >     #1 0x55a5d933f3ab in memory_region_read_accessor
>     system/memory.c:445:11
>      >     #2 0x55a5d92fba40 in access_with_adjusted_size
>     system/memory.c:573:18
>      >     #3 0x55a5d92f842c in memory_region_dispatch_read1
>     system/memory.c:1426:16
>      >     #4 0x55a5d92f7b68 in memory_region_dispatch_read
>     system/memory.c:1459:9
>      >     #5 0x55a5d9376ad1 in flatview_read_continue_step
>     system/physmem.c:2836:18
>      >     #6 0x55a5d9376399 in flatview_read_continue
>     system/physmem.c:2877:19
>      >     #7 0x55a5d93775b8 in flatview_read system/physmem.c:2907:12
> 
>     I'm mildly interested in what you were doing to trigger this. Certainly
>     we could do with a guard in the model to prevent it, but I'm curious
>     all the same.
> 
> 
> Actually, I'm doing the virtual device fuzzing test and trying to 
> discover bugs.

Could you share the reproducer? (As you did in your other patches,
it is very useful to reproduce).

> 
>      >
>      > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com
>     <mailto:zheyuma97@gmail.com>>
>      > ---
>      >  hw/gpio/aspeed_gpio.c | 26 ++++++++++++++++++++++++++
>      >  1 file changed, 26 insertions(+)
>      >
>      > diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
>      > index c1781e2ba3..1441046f6c 100644
>      > --- a/hw/gpio/aspeed_gpio.c
>      > +++ b/hw/gpio/aspeed_gpio.c
>      > @@ -550,6 +550,7 @@ static uint64_t aspeed_gpio_read(void
>     *opaque, hwaddr offset, uint32_t size)
>      >      GPIOSets *set;
>      >      uint32_t value = 0;
>      >      uint64_t debounce_value;
>      > +    uint32_t reg_table_size;
>      >
>      >      idx = offset >> 2;
>      >      if (idx >= GPIO_DEBOUNCE_TIME_1 && idx <=
>     GPIO_DEBOUNCE_TIME_3) {
>      > @@ -559,6 +560,18 @@ static uint64_t aspeed_gpio_read(void
>     *opaque, hwaddr offset, uint32_t size)
>      >          return debounce_value;
>      >      }
>      >
>      > +    if (agc->reg_table == aspeed_3_3v_gpios) {
>      > +        reg_table_size = GPIO_3_3V_REG_ARRAY_SIZE;
>      > +    } else {
>      > +        reg_table_size = GPIO_1_8V_REG_ARRAY_SIZE;
>      > +    }
> 
>     I think I'd prefer we add reg_table_size as a member of AspeedGPIOClass
>     and initialise it at the same time as we initialise reg_table. I feel
>     it would help maintain safety in the face of future changes (i.e. if
>     another reg table were introduced). With that approach the hunk above
>     can be dropped.
> 
>      > +
>      > +    if (idx >= reg_table_size) {
> 
>     This condition would then become:
> 
>     ```
>     if (idx >= agc->reg_table_size) {
>     ```
> 
>     Thoughts?
> 
> 
> I agree with you, adding a new member is a more maintainable way, I'll 
> send a v2 patch, thanks!
> 
> Zheyu


