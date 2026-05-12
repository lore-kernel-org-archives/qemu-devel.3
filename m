Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17682CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 10:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMkjg-0004Rs-H5; Tue, 12 May 2026 06:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMkjR-0004Qg-88
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:52:58 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMkjN-0001LT-Nc
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:52:55 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso62319415e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778583172; x=1779187972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XBNWRyzbtz1TGns5QgnSSPkjv9oZzZcM1M39ETy5/JI=;
 b=nloGdYy9SPC72ZomzmIzqnUd8VgGucqHuJGg2bljfRL0gpfkmYSkoxqmCTsFvjYTyB
 AAy/lhQChp8VLRcwVQGkHDDR5da0m3MkYHQcNKnIa8x/jtfYoVIoQwwZiZBfIoBGK/KA
 UNMgdvT9vK+AAQyfAKy0zNC6zlrSTIk0fGkAUKaXuH/8TzVHAuBPQjMOYvNWMP//XIv5
 srwX9QmYsO0ylC3uXG2s3v2ZikopKmTN9qzmgo1dahGJi8Y1qDn39UOdcEb3B7CvVLq0
 7grIlMaoKe28CkSGuCbIlQTYwxxQyLDYY+qatRVRUQsSj+DxghJCY+nAw2q8IPB1Q1Z6
 EsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778583172; x=1779187972;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XBNWRyzbtz1TGns5QgnSSPkjv9oZzZcM1M39ETy5/JI=;
 b=nMbLDTYL8UXdWrcWmTREMJarvyKIeOUuHUTztllDgf9BOhNVXqRdz4Fhtp0E1oZ7XU
 qwZcKo5cRv5va5pKqI0AU2qrCjJ1rZ/6NXEg3JxMmttqc5mJ/5M3j0fx7lefRVlpGdRR
 CLT/LUDnjN7N7li1Me98DXlfelo/yXEl9lZKvVm+zKLfbwDL89EOlTwsSKF/BhTrQdlY
 Q1lK+/P9vwPYsJZegNadkxAfqIGDTInazildr22l7Cd4KpXZecvpUzyUAvCBDrf7kF/Y
 riEeRBXjrY70OjDtYUQ9uBxWQA80PsOK20S68u26GfG0Dqkg5bGbPL3Q2rXIwr/wqihM
 foIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Md5QkZZWMoZqhqejXSHM2RKxu90vIvbyk0lSjd8s69R/ppZwmCYAJjt6lfDSS5admr5sBaVxbkD9C@nongnu.org
X-Gm-Message-State: AOJu0YzGQ7a2nH/tgCK9hm2o5ZGD2Zndq0gp0k0cj7JWS1iptlxXeEkH
 g8GpufImRJ0LM91hLXXN48O2lraT5+XOWt3Vz+kgIyhB4kJiTTUk+K4RNwcJRY0uskwxxRqCJp7
 rqL9gL3c=
X-Gm-Gg: Acq92OGaai3rxWxfOCuBIPDUjuIkFWR7vu3PGqGvdJQZy/QQWmegmPJuqRAjlxLj9TC
 +Um3RKt9i+SqVyY7JTX4jdJSyeGbC4IGvGwcO2CV5d8JYQC9W/LHrrJHoF4oA7bHESsvU2PkS//
 UQaJ2ylWsoJKVgCj890VYbiWT5wnJVP9yyWGc2GJxWmlB+CIHhpP+xHMXUIl5kERcP7EFJxcDz4
 Nwlmu6sGaodTIC5maz3KAo2U2FYMa3iqraHmVmYMVuaO4HuYMwKAzbNWq+QINWjfP2QsERQDgUb
 sZQapRGJ4T8WIcBsjgKq7mbNUNFJ0tFg3/xU3F/XQXcf17xzQRj5UMTcajxw1DL5CnYnbCUVTiu
 TOB/vl+CTV1YsVYOmQD09q2/yU2aEgKjGVtrO5lBqX6Cw84zd5cBXFIPk4I3fq34g9zEpgnQOGc
 NESLG3I1najPxHUo8vuJPzeVmP+gRk1uHuSrJpKwu8iMabcKOpBV0SUXIwQXSFieJwzAMUzBMf0
 CFv
X-Received: by 2002:a05:600c:2e15:b0:48e:5990:96b1 with SMTP id
 5b1f17b1804b1-48e599097b8mr224977865e9.23.1778583171771; 
 Tue, 12 May 2026 03:52:51 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6c221sm32746757f8f.13.2026.05.12.03.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 03:52:51 -0700 (PDT)
Message-ID: <42e934a6-67e9-4edd-89c2-92f77f0af5f3@linaro.org>
Date: Tue, 12 May 2026 12:52:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i2c/microbit_i2c: Don't index off end of
 twi_read_sequence[]
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>
References: <20260501162634.4092394-1-peter.maydell@linaro.org>
 <CAFEAcA8nVfzFrQ8y5x9_Qp62QogVcvN09Q0JkqcFrJv73g80oQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8nVfzFrQ8y5x9_Qp62QogVcvN09Q0JkqcFrJv73g80oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/5/26 16:48, Peter Maydell wrote:
> Hi; ping for review?
> 
> thanks
> -- PMM
> 
> On Fri, 1 May 2026 at 17:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> If the guest tries to read more bytes from our fake stub I2C device
>> than we have provided, we incorrectly read one byte beyond the end of
>> this array. Avoid this, and instead keep reporting the RXD register
>> as containing the last byte of the "data transfer".

Having the accelerator data buried in an i2c controller is not good
practice. Anyway good enough for how we use it. Same for this fix:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 9d68bf564ec ("arm: Stub out NRF51 TWI magnetometer/accelerometer detection")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3408
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   hw/i2c/microbit_i2c.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i2c/microbit_i2c.c b/hw/i2c/microbit_i2c.c
>> index 2291d6370e..d9689b6f1a 100644
>> --- a/hw/i2c/microbit_i2c.c
>> +++ b/hw/i2c/microbit_i2c.c
>> @@ -41,8 +41,13 @@ static uint64_t microbit_i2c_read(void *opaque, hwaddr addr, unsigned int size)
>>           data = 0x01;
>>           break;
>>       case NRF51_TWI_REG_RXD:
>> +        /*
>> +         * Return the next byte from our fake data sequence. If
>> +         * the guest keeps reading the register after that, keep
>> +         * returning the same last byte value.
>> +         */
>>           data = twi_read_sequence[s->read_idx];
>> -        if (s->read_idx < G_N_ELEMENTS(twi_read_sequence)) {
>> +        if (s->read_idx + 1 < G_N_ELEMENTS(twi_read_sequence)) {
>>               s->read_idx++;
>>           }
>>           break;
>> --
> 


