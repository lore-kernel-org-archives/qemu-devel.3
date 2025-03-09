Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAD4C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 22:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trPTU-00075z-Cc; Sun, 09 Mar 2025 18:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trPTJ-00074x-KN
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 18:50:14 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trPTG-0001oj-Ln
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 18:50:13 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3913cf69784so1393638f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 15:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741560608; x=1742165408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=emhrjQh6rm6pY3Eq5kh1A/vXP/P4B0XqxYTQWqK6tq0=;
 b=ZUP78vkNV65fXrXAomApTqyaEPoVw0MJqUi0URoqt51+WJWKLQs7IbVL1JanquYJZk
 5ZjAcKJ4IB1o+wKaXCVdNTVe+5MDRQTggtVHvYeqbJEyMMa9d2CL+V806BAxYAThGDnw
 WHrfmpZb3BloZUg8b+estLDpinnPummFZ1mpgzk97PyU47xHzlqShtdjxER2expvKpEb
 gObp/IoHZ4j4OV2JBc4ajuEuEEUqkygbUeMjtmy/4bf1kCWoS5s79qrCsYQfR9eJT5TD
 hokBXWh0Pc4N3RZm1InhUd/757J/cbrbA422OuO4LTRkFpBrTULjWxYyZkSblg/UhuJf
 jMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741560608; x=1742165408;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=emhrjQh6rm6pY3Eq5kh1A/vXP/P4B0XqxYTQWqK6tq0=;
 b=XW9PriC6f+InwmYNP8gfcMr9/eTwgSGHDV9oX3VM5KKxSycD2FWrtEZ7g+hFguRFvI
 oHMYM9QV7U3qq7ZQ9uzc5pfdRI5W/hPzn8npxnNBYvTve6kfRFSyzv+8j/ugikDnw57u
 aWiaJieEsAWaPGhfVx8JHFH0Kilgw1OpjX4htPVekUmY7uc877MCcEJBar5opnukL7Ws
 A93jE/oR/aB6gVlk3/JCLz55QYTSctyPdtYlOIpauiXzykVXrP9TzSKixlQzrr05oHPK
 CQATu3B+boHs8cVg+fAOIMSlkY3Lf6u8NOiUFO4+ABMPFVsetplvmQRkWx22tYdBE+yp
 OFOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6RZQOVJGPWwYu2Bxq7623BV2ToNX2sfvn2nImFIptYR4teaMAxzmpf+RN38LvFmAaIwJwoU4oA4Sb@nongnu.org
X-Gm-Message-State: AOJu0YyQmY6LXyGLIY7qnb6pR9kZ/V03RezJozeyLUk/UTJLfVj6QT4a
 HawggIzQyPdyyYc/ujH54TbEum0MN8ol+eO2vaU8QX/jV8SjaUHNpeJoepe43Xo=
X-Gm-Gg: ASbGnculhnt9Cr3hcFhX6cDlMBMvqoW9Oosllj0Q+z/NEfgEyrNyxPUcCkowhPF29OT
 XOnrfT5IGlKKGguVJnJSiq0HsQ6Y1Gzq9qvUy72HQUilpr0JuX/m4aBJgxCbhPmkkLONolczjQQ
 yRsQoMU8/bi+jEpwzuYw3zBu4yyAGDJDiFZqt/rJ1BSgUXi2hoOuGrvaJCLYV6zXib5Rxjg2rO1
 1+Z8YdaFpCgXRm4LdjNIjTpli4aPYwVfKAd3dPohFrUMHMQYRYOzxyaRTn1FpwC+BHuIS9sipci
 ntESc/TBZfIDUKO1kRKzNTd/Ifay4waUje0Y4wry3tFa98471veIxOiZR1dPc9bnypqY5hGQ00D
 BHKsUWmIgbyTP
X-Google-Smtp-Source: AGHT+IGmi8i3lb4MbgeQPolaHxckVQNMs3lqNXIK931hjE10HcYt6wIzkeYBLXdQ3VYiL7n7vOGvGA==
X-Received: by 2002:a05:6000:1f8a:b0:391:2e31:c7e5 with SMTP id
 ffacd0b85a97d-39132d093f8mr8314320f8f.6.1741560608090; 
 Sun, 09 Mar 2025 15:50:08 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01d2cdsm13216634f8f.57.2025.03.09.15.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 15:50:07 -0700 (PDT)
Message-ID: <6797072b-6a7d-46e0-bfdb-17b9888d8b0b@linaro.org>
Date: Sun, 9 Mar 2025 23:50:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] hw/sd/sdhci: Unify default MemoryRegionOps
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
References: <20250308213640.13138-1-philmd@linaro.org>
 <20250308213640.13138-10-philmd@linaro.org>
 <6FAA573C-D92D-451B-B69B-F4B9095F9F0C@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6FAA573C-D92D-451B-B69B-F4B9095F9F0C@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 9/3/25 10:27, Bernhard Beschow wrote:
> 
> 
> Am 8. März 2025 21:36:35 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> Note, sdhci_mmio_le_ops[] was missing .impl.access_size = 4.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/sd/sdhci.c | 46 ++++++++++++++++++++--------------------------
>> 1 file changed, 20 insertions(+), 26 deletions(-)
>>
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index a2e7162e289..23af3958a1d 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -1372,30 +1372,22 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>>                         value >> shift, value >> shift);
>> }
>>
>> -static const MemoryRegionOps sdhci_mmio_le_ops = {
>> -    .read = sdhci_read,
>> -    .write = sdhci_write,
>> -    .valid = {
>> -        .min_access_size = 1,
>> -        .max_access_size = 4,
>> -        .unaligned = false
>> +static const MemoryRegionOps sdhci_mmio_ops[2] = {
>> +    [0 ... 1] = {
>> +        .read = sdhci_read,
>> +        .write = sdhci_write,
>> +        .impl = {
>> +            .min_access_size = 4,
>> +            .max_access_size = 4,
>> +        },
>> +        .valid = {
>> +            .min_access_size = 1,
>> +            .max_access_size = 4,
>> +            .unaligned = false
>> +        },
>>      },
>> -    .endianness = DEVICE_LITTLE_ENDIAN,
>> -};
>> -
>> -static const MemoryRegionOps sdhci_mmio_be_ops = {
>> -    .read = sdhci_read,
>> -    .write = sdhci_write,
>> -    .impl = {
>> -        .min_access_size = 4,
>> -        .max_access_size = 4,
>> -    },
>> -    .valid = {
>> -        .min_access_size = 1,
>> -        .max_access_size = 4,
>> -        .unaligned = false
>> -    },
>> -    .endianness = DEVICE_BIG_ENDIAN,
>> +    [0].endianness = DEVICE_LITTLE_ENDIAN,
>> +    [1].endianness = DEVICE_BIG_ENDIAN,
>> };
> 
> We introduced sdhci_mmio_be_ops and the endianness property specifically for the e500 machine. We always lied about the endianness property to be implemented for all SDHC types, e.g. USDHC doesn't implement it. Since you'll introduce a dedicated FSL_ESDHC type a few commits later, along with its own MemoryRegionOps, I think we should drop the endianness property and sdhci_mmio_ops doesn't need to become an array. Dropping the endianness property also results in avoiding the error conditions you have to deal with in the realize method.

Great idea!


