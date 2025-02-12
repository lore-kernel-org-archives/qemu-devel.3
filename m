Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652EEC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 10:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti9vG-0001wI-RJ; Wed, 12 Feb 2025 05:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ti9vE-0001vw-PV
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 05:24:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ti9vB-0004zI-Rc
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 05:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739355883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WB/yorcb8gycBiUHOiayVlA2poLr2ZbQ700ZfcKxQNA=;
 b=W8KU95xy1l7EjPYHH9GZO40G0YFtDU5e43beLgc1PmjC7/eHBClz5PyuEenvZvraKQmkVc
 afdm22D1NMhTChPWY1j56wjVMdz9C9pRgZZMJU5C3IX32xH3hWil/jDVhVvf2IclTan4Ei
 h0cqEzJUzWvj433r22TcmFe7WTw91DQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-kp_X4k4wP5ij514BinnwTw-1; Wed, 12 Feb 2025 05:24:39 -0500
X-MC-Unique: kp_X4k4wP5ij514BinnwTw-1
X-Mimecast-MFC-AGG-ID: kp_X4k4wP5ij514BinnwTw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38dd533dad0so2520413f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 02:24:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739355878; x=1739960678;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WB/yorcb8gycBiUHOiayVlA2poLr2ZbQ700ZfcKxQNA=;
 b=g5e1p1CrDvT3uRL7Z+YBllw+kOHqo0N42XL+qTXbEvynZS7v7016WhiYZQllLZlzFN
 ZWw7d2A5mopBF8QS7S+2o2b1FX+QIldWjtpduoigd+PN6fSSX51IzvcJu5+UXUqL1nRp
 86KF/E7XHo8X9bdifD047kvTdQtW7plICA26PGtWAVbD+Cd51l/rg1K5Jc6zn30AlFdw
 nHpKgEi6CijvmhnNQ96ox2aKT8kRPRLZZKdcz1Av+7XjAEV6arNw6eoOxREvK8tNSWOG
 wFbb5+SOx9qV8zkEWW8UmaoDRfQh5g7y9YayfR0xlKdETRj5UQ2omOgMgWPv+x2qOuXj
 xcSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViEVzcfMqt0r52n6PBhTfBK4RpKzMu7LxuuYNDCGeqMNwr+VpswOJYIVnH8KWS4lHS1QKYEgKli4u4@nongnu.org
X-Gm-Message-State: AOJu0YzyhWJyLNTMv9Uq9SCbrk3z9+WqmUU7RvjtRpdELoYE03VmWXFi
 H3kbfaMufZ1qBu+QMY5TJdiYBFFgaJgCDTJhh3PKHNTouUabAnBdb//bA6JdHgr8/yhAm5JKIE1
 1dkuNC4zqvuwJNYUXa7yrZY2Nsei4Q8TRN6Rh/OI1lWP+PnVDLVPC
X-Gm-Gg: ASbGncsIF6RwEVckBK14Y/E+KI83zQtDMhwQRcQV5gvUk5gbRjFqQiX0+E48YW/wlGE
 slEXnGYA7ssbsy95Yrg17orxOGwkhAvzVln/i8fLRmFuKahmqpmeMH4ly+xyovfOR+8oy2QVsAq
 PW/0gbHUf21uEH8xAwbHHa/R+D48Dkinx5YIGkAapjHmGrI+DmYhFOlDBU30kAo1Eou16Xv5o2c
 r/JhzifEcvbM/hm7bWJ/KLt88R9qU7UtnK9b8Owaku7qKxTyxMqENt+/FJe/N4yxak2rWxBsr9X
 hzElBSg2e48UJDv/22L8wnwZRYxZlP7gWQ==
X-Received: by 2002:a05:6000:1863:b0:38b:d9a3:6cff with SMTP id
 ffacd0b85a97d-38dea26e512mr2380693f8f.16.1739355878248; 
 Wed, 12 Feb 2025 02:24:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCjyZ4EHvu4xYI3Xgg6rPPKltuW6y3b6iNwVNSrYGqE6YhCjuSRKPtcWCqUa0Ooc0Uv+XVtQ==
X-Received: by 2002:a05:6000:1863:b0:38b:d9a3:6cff with SMTP id
 ffacd0b85a97d-38dea26e512mr2380656f8f.16.1739355877802; 
 Wed, 12 Feb 2025 02:24:37 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-37.web.vodafone.de. [109.42.48.37])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcd21fe18sm13960414f8f.91.2025.02.12.02.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 02:24:37 -0800 (PST)
Message-ID: <1a4dc9cf-69bb-4a9e-bd07-e50070fcf9a9@redhat.com>
Date: Wed, 12 Feb 2025 11:24:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/32] hw/timer/xilinx_timer: Make device endianness
 configurable
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
 <20250210204204.54407-5-philmd@linaro.org>
 <678561c5-4d06-494a-b12c-6013b07f3b05@redhat.com>
 <03446903-2100-4981-831e-7ee4741ffead@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <03446903-2100-4981-831e-7ee4741ffead@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 12/02/2025 10.19, Philippe Mathieu-Daudé wrote:
> On 12/2/25 09:27, Thomas Huth wrote:
>> On 10/02/2025 21.41, Philippe Mathieu-Daudé wrote:
>>> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
>>> of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
>>> Add the "little-endian" property to select the device
>>> endianness, defaulting to little endian.
>>> Set the proper endianness for each machine using the device.
>>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Message-Id: <20250206131052.30207-5-philmd@linaro.org>
>>> ---
>>>   hw/microblaze/petalogix_ml605_mmu.c      |  1 +
>>>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>>>   hw/ppc/virtex_ml507.c                    |  1 +
>>>   hw/timer/xilinx_timer.c                  | 35 +++++++++++++++---------
>>>   4 files changed, 25 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/ 
>>> petalogix_ml605_mmu.c
>>> index cf3b9574db3..bbda70aa93b 100644
>>> --- a/hw/microblaze/petalogix_ml605_mmu.c
>>> +++ b/hw/microblaze/petalogix_ml605_mmu.c
>>> @@ -127,6 +127,7 @@ petalogix_ml605_init(MachineState *machine)
>>>       /* 2 timers at irq 2 @ 100 Mhz.  */
>>>       dev = qdev_new("xlnx.xps-timer");
>>> +    qdev_prop_set_bit(dev, "little-endian", true);
>>>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>>>       qdev_prop_set_uint32(dev, "clock-frequency", 100 * 1000000);
>>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/ 
>>> petalogix_s3adsp1800_mmu.c
>>> index fbf52ba8f2f..9d4316b4036 100644
>>> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
>>> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
>>> @@ -114,6 +114,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>>>       /* 2 timers at irq 2 @ 62 Mhz.  */
>>>       dev = qdev_new("xlnx.xps-timer");
>>> +    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
>>>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>>>       qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
>>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
>>> index 23238119273..f87c221d076 100644
>>> --- a/hw/ppc/virtex_ml507.c
>>> +++ b/hw/ppc/virtex_ml507.c
>>> @@ -230,6 +230,7 @@ static void virtex_init(MachineState *machine)
>>>       /* 2 timers at irq 2 @ 62 Mhz.  */
>>>       dev = qdev_new("xlnx.xps-timer");
>>> +    qdev_prop_set_bit(dev, "little-endian", false);
>>>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>>>       qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
>>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>
>>   Hi,
>>
>> with this patch applied, the ppc_virtex_ml507 functional test is now 
>> failing for me ... could you please double-check whether "make check- 
>> functional-ppc" still works for you?
> 
> Thanks, not this patch problem, but patch #2 misses:
> 
> -- >8 --
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 23238119273..723f62c904b 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -219,2 +219,3 @@ static void virtex_init(MachineState *machine)
>       dev = qdev_new("xlnx.xps-intc");
> +    qdev_prop_set_bit(dev, "little-endian", false);
>       qdev_prop_set_uint32(dev, "kind-of-intr", 0);
> ---
> 
> Why is my CI green?

Looking at https://gitlab.com/philmd/qemu/-/pipelines/1664238124 it seems 
like you did not start the functional test jobs?

  Thomas


