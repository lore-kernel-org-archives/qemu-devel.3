Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DC9C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 11:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKFfG-0003gZ-VR; Thu, 20 Jun 2024 07:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKFfE-0003fg-RZ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 07:09:12 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKFfC-00029z-UH
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 07:09:12 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57d1782679fso853824a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 04:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718881749; x=1719486549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o6QJ9SZ3OegkAAa1flGgzs96XVQRrdVLEc+wLqwcKo0=;
 b=xvW7647Xw6QUDsTWtH7/JGb3Zp8WVk9AN5EHlVMeQED8AeKUn2laH8wu32mXCaoFUV
 J4Ft2vEmC+wt/N6xmgm4uL2n5GOBhFZo4B83el+WbdVUEIwne4+GOsFCIH2gvEU5mLpl
 Q8cYExIKp0Y5NXU+uUFCKI3UG/ynqMip6ZyZ4PwZTMet+8vhAffINHmeGyXdbrgY54ew
 xr3RTM9w0IHQiKYW6keW4Zrea6iwDGCwGVuI3Un9vsbjUlbSuFLVV9hU4tmDPeWs8HuW
 WCB5J0ADwmlxM+yTosTlGM9nqxGinchzLMlKD4VK/ILUqcH98L2lgYwAxKr+pOIPFhnW
 dGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718881749; x=1719486549;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o6QJ9SZ3OegkAAa1flGgzs96XVQRrdVLEc+wLqwcKo0=;
 b=o7cURfMGE63GR+UUqO1kPJOTe15Unp5oSLo+kZ9kWCu0vjJ2gm4220MJLfQvUk6gzT
 W8puD+YYqBDI3w4RZXdkZOCuPWOUvOke53LO3BJjSdwDHH0KW5NzyVEUv5qkK7eLMBPM
 WuKweZBXG+dEHdwWOugN+/ZMyNfVwXXufGba/gqdVYVvQbduDwNsIdlRKBSnj+Ik6CDD
 lTA0T66LTLVD/z66T4OJ8j/a2CYEZWfBzOXBp9tz46styLsc0hp9KhpvXJDF13WrQB9E
 mFZiTtjf9/7LrLKINjtMwrYIVGdOIbgzUbyj+9xLTTMCLbBcvuZjnnxa3XWJrAp22rjE
 RDXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy5JMSviTcunfB+ahoxC7M7XXMNeeo0pj5moiBTUNM2JqT3Ll9Wh7xzyHLZQlurb2zruo0job/hl3XBXFOEKXd0Xc6eW4=
X-Gm-Message-State: AOJu0YwwD5+CVRUikxNnZQsV5/bwWy3RH7rqF2cLaTK3pr2Z9TYXBOBk
 RAtISjwLfI1zv+oMsKDfLjdqegeFInNcVYVHAzEjUKM6vrNGylf4kC70+4sZ7Bs=
X-Google-Smtp-Source: AGHT+IEjjZpSLIDnd08QJW+Lf9owKJVblZUB7C0BIgWI7vfAZk4k/TFa+GldlMpmpRZWPPJeIwPHrg==
X-Received: by 2002:a50:d012:0:b0:57c:bd49:9969 with SMTP id
 4fb4d7f45d1cf-57d07ebf0cemr3567816a12.39.1718881748595; 
 Thu, 20 Jun 2024 04:09:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.40])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72da82fsm9271355a12.32.2024.06.20.04.09.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 04:09:07 -0700 (PDT)
Message-ID: <f446fdbf-90f2-4d07-8f1f-06b697ec8c01@linaro.org>
Date: Thu, 20 Jun 2024 13:09:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/gpio/aspeed: Add reg_table_size to AspeedGPIOClass
To: Zheyu Ma <zheyuma97@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240619183638.4073070-1-zheyuma97@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240619183638.4073070-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

On 19/6/24 20:36, Zheyu Ma wrote:
> ASan detected a global-buffer-overflow error in the aspeed_gpio_read()
> function. This issue occurred when reading beyond the bounds of the
> reg_table.
> 
> To enhance the safety and maintainability of the Aspeed GPIO code, this commit
> introduces a reg_table_size member to the AspeedGPIOClass structure. This
> change ensures that the size of the GPIO register table is explicitly tracked
> and initialized, reducing the risk of errors if new register tables are
> introduced in the future.
> 
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display none \
> -machine accel=qtest, -m 512M -machine ast1030-evb -qtest stdio
> readq 0x7e780272
> EOF
> 
> ASAN log indicating the issue:
> ==2602930==ERROR: AddressSanitizer: global-buffer-overflow on address 0x55a5da29e128 at pc 0x55a5d700dc62 bp 0x7fff096c4e90 sp 0x7fff096c4e88
> READ of size 2 at 0x55a5da29e128 thread T0
>      #0 0x55a5d700dc61 in aspeed_gpio_read hw/gpio/aspeed_gpio.c:564:14
>      #1 0x55a5d933f3ab in memory_region_read_accessor system/memory.c:445:11
>      #2 0x55a5d92fba40 in access_with_adjusted_size system/memory.c:573:18
>      #3 0x55a5d92f842c in memory_region_dispatch_read1 system/memory.c:1426:16
>      #4 0x55a5d92f7b68 in memory_region_dispatch_read system/memory.c:1459:9
>      #5 0x55a5d9376ad1 in flatview_read_continue_step system/physmem.c:2836:18
>      #6 0x55a5d9376399 in flatview_read_continue system/physmem.c:2877:19
>      #7 0x55a5d93775b8 in flatview_read system/physmem.c:2907:12
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
> Changes in v3:
> - Add the reproducer
> 
> Changes in v2:
> - Introduce the reg_table_size to AspeedGPIOClass
> ---
>   hw/gpio/aspeed_gpio.c         | 17 +++++++++++++++++
>   include/hw/gpio/aspeed_gpio.h |  1 +
>   2 files changed, 18 insertions(+)


>   static const TypeInfo aspeed_gpio_info = {
> diff --git a/include/hw/gpio/aspeed_gpio.h b/include/hw/gpio/aspeed_gpio.h
> index 904eecf62c..e66036ac39 100644
> --- a/include/hw/gpio/aspeed_gpio.h
> +++ b/include/hw/gpio/aspeed_gpio.h
> @@ -75,6 +75,7 @@ struct AspeedGPIOClass {
>       uint32_t nr_gpio_pins;
>       uint32_t nr_gpio_sets;
>       const AspeedGPIOReg *reg_table;
> +    uint32_t reg_table_size;
>   };

- "reg_table_size" is a number of registers, using s/size/count/ might
   be clearer.
- No point in specifying 32-bit, "unsigned" is sufficient.

(Cédric, if you agree, you might update your tree).

Unrelated to this patch but figured out while reviewing, in
aspeed_gpio_read/write 'idx' is
- pointlessly assigned to -1
- of type 'uint64_t', also pointless, 'unsigned' is clearer.

Regards,

Phil.


