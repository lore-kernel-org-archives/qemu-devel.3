Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C83CC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 16:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvex4-0002iT-VW; Fri, 21 Mar 2025 12:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1tvex2-0002gt-Qj
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:10:28 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1tvex0-0003Wz-PC
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 12:10:28 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7C5F23FCCD
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1742573424;
 bh=aHgHJGToZT1OQYduJQXRMoo72hqz0GMO+qM67JO180s=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=dOfGLnIDe0IQwcFLcvqhXVWS3qU5hC+oFNvAJ8znzPRh2yZDYo1DAsdnvqG3C4jlC
 dLV7GeZVvV8UJJiGnmYwL9eYles07sPbFQNouEmqf91YtnBZjWAu4FdNaEqsXx6gxB
 NKvMEW1fkzP4kUiRh839vFd2rpS1ytaY/YGZTaZ50ez4uGtexQbLsPCLj/loyrJN7a
 SpXJj17gP97FE9aoguBHTLIEGH474WkxT/ihqFEE+Q6zG8kASzX8k0o6pzVcXyjMVr
 6uuub/z9seQjEav2n1NxiOPmT9mvk6yJ2TlN0sUB1kDavU4vO+tBiW5hiuYHW1ph3q
 ElQI76BpmxFGQ==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac28a2c7c48so208670866b.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 09:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742573424; x=1743178224;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aHgHJGToZT1OQYduJQXRMoo72hqz0GMO+qM67JO180s=;
 b=Yf6vjgwK4d4NOcY5FDvf2pp5M+g4nxlvQq/eBTPdGkUkbzZx5TvYy2HoqA4GmM02Sb
 0h4EjyTpgPtcIvJQ7p+Qa+IFHzwMqFb7M40GtOdIEPHULJwPONkOxtz1JywmOWckyqDX
 kDpDaVELhCGsF76x4SOJaloLoc0q3pvkK+IFnxCl/KKc00OFezjkj/6MHoqhhFL/UodD
 uBxTrBocoalvsTitHvWmnnjeAezgJYAS/hxz1LY24QF5zACY+xnN+wsSLn2f/FcKw641
 sFvz2465zpUlwfY958Lf/054nPByLZkHjxvveGGfvUoIXWyPuWQYZDk1gA4tN+XqBN0U
 7H8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq4KFnY+ub2V6XY4FzP4quoZDUvvZjBm/bljQDzAflK9ik+Jloz8Wgu0OKEcxff4mjax6N3B6rRtGZ@nongnu.org
X-Gm-Message-State: AOJu0YyJ8mzXNi2sH7HjOfT/REmM4ds93YIWSMfXUMSNHwNm/FGZ7A02
 zHz7MHUNWaiAL0xmxRiLE57a/pN8dBSbRrhSVq0yVVufrYdN0rqNS5/tZLrQJZDNeAV7c+CWqXl
 2pxG5qQs1JBk41IyXfM5yz6I8Sl4n40PMudufaPutN1YVsXxN5YQHyHBkcfQypw2nAXAc
X-Gm-Gg: ASbGncvw6tenJhQ2bu2M9Z8nSfrdMSwvofU6DD43Tq7pL0ymcrNdlK+YPc+raAg13OJ
 vqCbBGDD4kWs/EEFOgR2ZFH0BrjkWqhGqINAkdMcv7CdgHxsOSN/TYXaLmKvXQvAvY31uxdcO/J
 dH/qDQ1P3lZhYiyLOv9lhDyCIsB0ZwvozxHsGavyGfq+gNVXvYT0SgQRuGhq2Jf/OItb4zfyAIb
 IeY3XcsIp2Pd7G5L37gjbmuqCih0lxZh0PgqnmXy21LyQiX4Y/1wzfNZtkekn/HhA7rI+4qnpHB
 vQ5gr+mlp4wYuxYutW3uacTPWecUXqsWABqLl0eyqOsD2iHBn4GKRp5JA/DWGWybhRcbUTPCcAg
 jWYno3XcbKlDq
X-Received: by 2002:a17:907:86a7:b0:ac3:3fdf:d46f with SMTP id
 a640c23a62f3a-ac3f2081e8emr461197166b.8.1742573423700; 
 Fri, 21 Mar 2025 09:10:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFv3NFCC0rwLBqfAonoMUbJ/ssU/o+U1h1/mLTqbdhr2Ub8OF5JPDB/SKwUHZUsiy4/LPlUw==
X-Received: by 2002:a17:907:86a7:b0:ac3:3fdf:d46f with SMTP id
 a640c23a62f3a-ac3f2081e8emr461193066b.8.1742573423293; 
 Fri, 21 Mar 2025 09:10:23 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3ef869f9fsm179173966b.10.2025.03.21.09.10.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 09:10:22 -0700 (PDT)
Message-ID: <3252f0c4-654d-4066-8f9c-87d56d144a6f@canonical.com>
Date: Fri, 21 Mar 2025 17:10:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 1/1] goldfish_rtc: keep time offset when resetting
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Frederik Du Toit Lotter <fred.lotter@canonical.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Anup Patel <anup.patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
References: <20250321081255.30564-1-heinrich.schuchardt@canonical.com>
 <5dd32cd5-ff51-4d28-bbaa-3153493dec39@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <5dd32cd5-ff51-4d28-bbaa-3153493dec39@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 21.03.25 17:08, Philippe Mathieu-Daudé wrote:
> Hi Heinrich,
> 
> On 21/3/25 09:12, Heinrich Schuchardt wrote:
>> Currently resetting leads to resynchronizing the Goldfish RTC with the
>> system clock of the host. In real hardware an RTC reset would not change
>> the wall time. Other RTCs like pl031 do not show this behavior.
>>
>> Move the synchronization of the RTC with the system clock to the instance
>> realization.
>>
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 9a5b40b8427 ("hw: rtc: Add Goldfish RTC device")
> 
>> Reported-by: Frederik Du Toit Lotter <fred.lotter@canonical.com>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   hw/rtc/goldfish_rtc.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
>> index 0f1b53e0e4..203a343511 100644
>> --- a/hw/rtc/goldfish_rtc.c
>> +++ b/hw/rtc/goldfish_rtc.c
>> @@ -239,15 +239,8 @@ static const VMStateDescription 
>> goldfish_rtc_vmstate = {
>>   static void goldfish_rtc_reset(DeviceState *dev)
>>   {
>>       GoldfishRTCState *s = GOLDFISH_RTC(dev);
>> -    struct tm tm;
>>       timer_del(s->timer);
>> -
>> -    qemu_get_timedate(&tm, 0);
>> -    s->tick_offset = mktimegm(&tm);
>> -    s->tick_offset *= NANOSECONDS_PER_SECOND;
>> -    s->tick_offset -= qemu_clock_get_ns(rtc_clock);
>> -    s->tick_offset_vmstate = 0;
>>       s->alarm_next = 0;
>>       s->alarm_running = 0;
>>       s->irq_pending = 0;
>> @@ -258,6 +251,7 @@ static void goldfish_rtc_realize(DeviceState *d, 
>> Error **errp)
>>   {
>>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>>       GoldfishRTCState *s = GOLDFISH_RTC(d);
>> +    struct tm tm;
>>       memory_region_init_io(&s->iomem, OBJECT(s),
>>                             &goldfish_rtc_ops[s->big_endian], s,
>> @@ -267,6 +261,12 @@ static void goldfish_rtc_realize(DeviceState *d, 
>> Error **errp)
>>       sysbus_init_irq(dev, &s->irq);
>>       s->timer = timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
>> +
>> +    qemu_get_timedate(&tm, 0);
>> +    s->tick_offset = mktimegm(&tm);
>> +    s->tick_offset *= NANOSECONDS_PER_SECOND;
>> +    s->tick_offset -= qemu_clock_get_ns(rtc_clock);
> 
> OK
> 
>> +    s->tick_offset_vmstate = 0;
> 
> This last line is pointless. Otherwise:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks for reviewing. Is the DeviceState structure fill with 0x00 when 
allocated?

Best regards

Heinrich

> 
>>   }
> 


