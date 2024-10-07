Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43727CFA754
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxv2t-00045x-JI; Mon, 07 Oct 2024 17:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxv2r-00045A-Hv
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:13:33 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxv2q-0000V7-4d
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:13:33 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso3172750a12.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 14:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728335611; x=1728940411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r/bJEglI2GQMK/HVXY2j7Vewahl+B7/H5ox3hZJZE5s=;
 b=mozZdxR61TK2MLUwrjCsG1X2ZuiK333eNkjNYelgkufqm7b/zyUpvHJRuNI6pgXIuw
 AGBMDKALWlOJ+fZjxvvuXmZGiqlpxWYnjeFoSBXTdQ9xpn0BTWp5z4hNCpii+FFHDDA1
 UvxCXK/wYyvrcGATbpRCwEPjAIuB7UfvKE0hvUgzknMUCmRCrRzQmndotpii99g2Glh5
 F/sSlAECUJ9fGctHKR7AuQW2ua+oR6J2fszzA/mEbavRLP+k+zUfMuZQovSOXT9vPxcN
 3ajYCDvbKbeIqEjkQ1aSQW6KB3qutlb6TuHP987J94KKuLXG4KyAEg27BkbjnQQZ/Nkk
 fF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728335611; x=1728940411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r/bJEglI2GQMK/HVXY2j7Vewahl+B7/H5ox3hZJZE5s=;
 b=SjwF+q6gZzN9LyM2MupjqASliRwkP7A5EMV8mjOVXKFACqu/Pjr5zHl0fG+rDAal1H
 PaGV7fbNEKbqMd5eAfj6LuH6N0eyNyBqvfw8Rq+ookU6D/gozU0LbjBL8xHzOlgfW+oJ
 RH8/3Do3TLLcZ23PgYmtGZm5hiKFo9Z7vGEaMozuCjzXJ61SIyi3I4RDJhYhm/4G0ljM
 2pL+/Fs/BMnr8Ha5heaw3TU7tDjde/5t3NCfKIJAT6/sDMh/aA+uBNyZl6LpsxMOdWgz
 co4TKtGVHTx4SkJDF4eesIfsBJtyd1jjVXC5x4zRLQW9O+xYniT1Y4ZOo9QoAMV4Rjrb
 reUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYtGGjBOS1J7zv9+iaLPEiZv8b2mtfLx/2LFogcfKKd6T+080B2ni1vMoDGOTjCWWhNXHWmJVwSHbC@nongnu.org
X-Gm-Message-State: AOJu0YwX6jXBlOtn5wdIHBUQAEyxwSjEfeZKYBfS5Y4gElFMo26ZJIy5
 AE3gSpUqk1YVzlUwDoyFOcOhmufa3k1v8IO+By4KKsWbYad9eor6II53yL47RVU=
X-Google-Smtp-Source: AGHT+IGQ1Pv25CHSdZDE9d/Oo7bibhhMHy+GtmowzgiPTkFPsvn2DwwqYbGR0PJkmA4wc7iHTwEcAA==
X-Received: by 2002:a17:903:1cd:b0:207:15f9:484a with SMTP id
 d9443c01a7336-20bfe061a46mr167915935ad.15.1728335605849; 
 Mon, 07 Oct 2024 14:13:25 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13988d0bsm43574295ad.262.2024.10.07.14.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 14:13:25 -0700 (PDT)
Message-ID: <d094728d-a7bd-4e16-b3c1-82065ca9bf08@linaro.org>
Date: Mon, 7 Oct 2024 18:13:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/ppc/e500: Reuse TYPE_GPIO_PWR
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org
References: <20241005100228.28094-1-shentey@gmail.com>
 <20241005100228.28094-3-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241005100228.28094-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/10/24 07:02, Bernhard Beschow wrote:
> Taking inspiration from the ARM virt machine, port away from
> qemu_allocate_irq() by reusing TYPE_GPIO_PWR.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/ppc/e500.c  | 16 ++++------------
>   hw/ppc/Kconfig |  1 +
>   2 files changed, 5 insertions(+), 12 deletions(-)


> @@ -892,13 +890,6 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
>       return dev;
>   }
>   
> -static void ppce500_power_off(void *opaque, int line, int on)
> -{
> -    if (on) {
> -        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> -    }
> -}
> -
>   void ppce500_init(MachineState *machine)
>   {
>       MemoryRegion *address_space_mem = get_system_memory();
> @@ -1086,7 +1077,7 @@ void ppce500_init(MachineState *machine)
>       sysbus_create_simple("e500-spin", pmc->spin_base, NULL);
>   
>       if (pmc->has_mpc8xxx_gpio) {
> -        qemu_irq poweroff_irq;
> +        DeviceState *gpio_pwr_dev;

Can we keep a reference in PPCE500MachineState?

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   
>           dev = qdev_new("mpc8xxx_gpio");
>           s = SYS_BUS_DEVICE(dev);
> @@ -1096,8 +1087,9 @@ void ppce500_init(MachineState *machine)
>                                       sysbus_mmio_get_region(s, 0));
>   
>           /* Power Off GPIO at Pin 0 */
> -        poweroff_irq = qemu_allocate_irq(ppce500_power_off, NULL, 0);
> -        qdev_connect_gpio_out(dev, 0, poweroff_irq);
> +        gpio_pwr_dev = sysbus_create_simple("gpio-pwr", -1, NULL);
> +        qdev_connect_gpio_out(dev, 0, qdev_get_gpio_in_named(gpio_pwr_dev,
> +                                                             "shutdown", 0));
>       }

