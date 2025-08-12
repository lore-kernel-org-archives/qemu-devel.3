Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64CCC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 13:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulp2d-0004lo-L1; Tue, 12 Aug 2025 09:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulp2c-0004lg-KH
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:27:50 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulp2X-0000vj-KR
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:27:50 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b913b7dbe3so295138f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 06:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755005261; x=1755610061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jNjUzMIbour4t9m+Ur6cjACD01Gv7DIbXsV8ETBdw+U=;
 b=zbqnyl8co8Ew3Ys1+HUxch3uTrBEnRKECjCqrraFDyaf5DUeqUin6sWjVKQ8s5WPnn
 visqNlnprrZ1lRxe79jUTLvFflANJVT8G9K5ZCDJ9prK+EKD+5r+HSTF5bStuyfWhn/M
 QVRVu+o3qMesopG0fWQAu8JpqQooa21OStwdPKtI70pOLxnRGDt+OfRATxUJ8O7BEgu8
 s12UEmuiCz5/co/jrjwQHPDGthC5wVYIvi2z7Yll4cQKnZVaksqefV8SXGeP3k40kcKe
 bIC9Jw3MLynkZU9jyquwMoFxNR3DB9tEuvQF5KjTHRgx75KQvFW8hMsfPG+BINugNYjx
 DYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755005261; x=1755610061;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jNjUzMIbour4t9m+Ur6cjACD01Gv7DIbXsV8ETBdw+U=;
 b=KWpOe5HoU+TQRJcDrDeLNd4ElWYXX3OaakvtvCUiY8fhSFxGBuS8gXO43WC/MoXMk9
 7DdHkIduQZc7Dgu7NLz6AcoCu8cGmqpNsQXtix/rEXtJxVo1n3C2/sJFBYjvokQF3aSw
 rtmQJDBv7o11M6thDfljquRHqT3qrrU2CUGn75zdg7vdn3ca5dT2IFPcQ6z9qOH/5pZJ
 N7shcbwOGybDhhRws4Cf2HbfMxfel3sBF7dIebAtR1JlPJItKs0Ho+S3iJuFTjwNCLFB
 K7ejqW5u3ObJcXrQm+SlTTSotwZGZFc9WjXd0jOfe4FAyQjNXvOSgtbWEJ9ICIzL+5c8
 w0fg==
X-Gm-Message-State: AOJu0YzhNp14JyWHliwUKPbQoydFEh6TJybwI0SiyfOdf8g6Jg0aCldP
 30rf4L90RhSr/BfXH5tMsIpiCP32ChgIMTbPq3vCYXpA/HKzNCyxq524EPhdXYIUQNA=
X-Gm-Gg: ASbGnctUvweztR8GslGpuHAvmXbTNreqL68nnb88ZEZag2K+s88pz+SIp2VRimJ/pDp
 rIKlJAo62XHJKJLgozuyLeKWjDIJi8Tn2vDx9Z0tvSZqBMS4RySGbG3iBSCm39U4RyU5DIfhr/K
 CswguMIfu49VtmLvD+Z/iDPS1+4UfDH6qYumscIwxwIFDMlmXz7ReO+UNqHRKzGDyhTi+9y5kGt
 eFI8oj2mLxUp76938ElV4HuSLozl61sJBAUxG07eOlRZTfWbqW986E4t7nRJK0skPK+hARstQJ4
 pYoSy8g7gPJId70o3gooKaeHkFzTRKDJBL6f6ZWEitfSR7hfnhlM9nhzOzmMfm0Q9OQVF6+JLsm
 7NQXplzFb0Vo6OQTY913spTVM3eYfdfvuY4kFiK/WKh/9z4GtzRaUIP93aYCov+1sUFfrmc/htM
 ju
X-Google-Smtp-Source: AGHT+IHMnMs73Gl/6RxGuQnMH6YU/9yNkxEESVLp1VUa+xKA4H4JM6P5L5kTTn47AACff54MEsQbbg==
X-Received: by 2002:a5d:5f82:0:b0:3b5:e714:9c1e with SMTP id
 ffacd0b85a97d-3b90092ca4bmr11840120f8f.12.1755005260591; 
 Tue, 12 Aug 2025 06:27:40 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bf970sm44081104f8f.25.2025.08.12.06.27.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 06:27:39 -0700 (PDT)
Message-ID: <681ecca9-272b-4851-8726-9daf7630b5ac@linaro.org>
Date: Tue, 12 Aug 2025 15:27:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 1/2] hw/sd/ssi-sd: Return noise (dummy byte) when
 no card connected
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-block@nongnu.org
References: <20250808135115.77310-1-philmd@linaro.org>
 <20250808135115.77310-2-philmd@linaro.org> <87o6skad76.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87o6skad76.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/8/25 15:20, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Commit 1585ab9f1ba ("hw/sd/sdcard: Fill SPI response bits in card
>> code") exposed a bug in the SPI adapter: if no SD card is plugged,
>> we shouldn't return any particular packet response, but the noise
>> shifted on the MISO line. Return the dummy byte, otherwise we get:
>>
>>    qemu-system-riscv64: ../hw/sd/ssi-sd.c:160: ssi_sd_transfer: Assertion `s->arglen > 0' failed.
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Fixes: 775616c3ae8 ("Partial SD card SPI mode support")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/sd/ssi-sd.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
>> index 594dead19ee..3aacbd03871 100644
>> --- a/hw/sd/ssi-sd.c
>> +++ b/hw/sd/ssi-sd.c
>> @@ -89,6 +89,10 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
>>       SDRequest request;
>>       uint8_t longresp[5];
>>   
>> +    if (!sdbus_get_inserted(&s->sdbus)) {
>> +        return SSI_DUMMY;
>> +    }
>> +
> 
> Seems fair although it's hard to track what is consuming this value. I
> think we end up in ssi_transfer() which a surprising number of calls
> don't even bother checking the return value, other just seem to | the
> result when iterating across devices.

A SPI transaction consists of shifting bit in sync the CLK line,
writing on the MOSI (output) line / and reading MISO (input) line.

IOW, each time you write a word, you also read it at the same time.

When a driver just wants to write, it is OK to ignore the returned
values.

In this case, we don't want to return "There is a card with error"
because there is no card. We shift the request on the MOSI line,
but nothing replies on the MISO line.

Should I reword the commit description?

> 
> We should probably improve on the definitions of transfer/transfer_raw
> and explain what the return value is.

Agreed.

> 
> Anyway:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks!

