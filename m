Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103B3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 08:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scLOn-0001zK-2e; Fri, 09 Aug 2024 04:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scLOm-0001xZ-02
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:55:00 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scLOj-0003rr-Rd
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:54:59 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ef2c56d9dcso19642681fa.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723193695; x=1723798495; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rWcoeLFLhB6eHvwZe6tvRg6JNrJnc0vscCQEZ14clkQ=;
 b=zAdOUO6KrVmKEtLUaoaTI3kKoRMQP218ZU3ulm2CyuFkMmxWULj2qz2Ft63BkPVdwf
 XviuBUicx7mOfJqZjYSma5ENOaY6h2PVjgGzjRe+fUHNB0JkRQJXlpVPVCdcLBjYyodg
 bTDi8PF4vjwKGjchAvpjJEJ4QaS0QRGEhm6K63wHDM+YPAw/9Hf/nmZ6aW+c7ReZG7Bf
 VsbXutTyhxCUHTsrS4aT8GKjsC45RcxBZUeJQHkrpvH4MHyfv0IopKa1NihhKAZJuSyS
 W29XKxDV5oyXQW1ydb7F0+iYftYoOH0bcbQmMfST2QkokyuyY9Pqwr49Zakoc1Vlsbee
 Jvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723193695; x=1723798495;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rWcoeLFLhB6eHvwZe6tvRg6JNrJnc0vscCQEZ14clkQ=;
 b=P2r+OZ1LypJm89PcWwzZp8FUPknXzr8IUFI2Fj8PTtGC9sU2NRqR+hVHdjCwVWdE2B
 /w+wfyI17UB7jOfpljB3RTmsWYZaT/zRsemfNxTh2m5HaQ2pojQj+/gdZcqCcoL+Ej6k
 cflqdDxnZzcvrv/1Kv/h7Sb0WDQrZ2TuNokqsFw9x05gR3mv1VpmT/NkLxfvIn0YHVbV
 7I4LUjjNT3yiGGT1+zFmBcDCjzT37EjmSjFB/ZeysNADfGYelPGBW5YQXlUG/4dt635e
 VJX2k21IxLv6UCR11HEGNVNHdU/69gCHYqmpj8l2CpLMkV+KX1Re7wACado3JHPORdjM
 abvg==
X-Gm-Message-State: AOJu0YylWQ0q7NBaoQIW9mlY8nElQ9k/HVY3Vnn3V4q9YSThJZHdOQOY
 /6erv/mLHZG5zawnjWtsjo8wD7F2A6348NThDHYsNNCmjOJEKlRa/EKdOvOzjyw=
X-Google-Smtp-Source: AGHT+IEmNjKwYO1ar3A6LE3vIkL5B8s6n8rEIJ8g5EDK3RcvuVR7tzAxGxkEPCvA3ck/Ig7ROQVqAA==
X-Received: by 2002:a05:651c:2124:b0:2ef:2281:2158 with SMTP id
 38308e7fff4ca-2f1a6c4bdbdmr8444651fa.1.1723193695346; 
 Fri, 09 Aug 2024 01:54:55 -0700 (PDT)
Received: from [192.168.178.175] (41.red-95-127-42.staticip.rima-tde.net.
 [95.127.42.41]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290c77f078sm67322895e9.37.2024.08.09.01.54.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 01:54:54 -0700 (PDT)
Message-ID: <fc198ec6-d1d2-408f-b69e-d976d9576f03@linaro.org>
Date: Fri, 9 Aug 2024 10:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 20/23] hw/ssi: add support for flexspi
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com,
 pbonzini@redhat.com, alex.bennee@linaro.org, thuth@redhat.com,
 peter.maydell@linaro.org, marcandre.lureau@redhat.com,
 alistair@alistair23.me, berrange@redhat.com, jsnow@redhat.com,
 crosa@redhat.com, bleal@redhat.com
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-21-tavip@google.com>
 <d31e1020-ce8d-40d9-ac8c-1dd8a0294073@linaro.org>
 <CAGWr4cQ0rv=83srF4NdJQ3ppP8mUu4qoCxU+nPtrBEL+TbgwqQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAGWr4cQ0rv=83srF4NdJQ3ppP8mUu4qoCxU+nPtrBEL+TbgwqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

On 8/8/24 23:31, Octavian Purdila wrote:

>>> +static Property flexspi_properties[] = {
>>> +    DEFINE_PROP_UINT32("mmap_base", FlexSpiState, mmap_base, 0),
>>> +    DEFINE_PROP_UINT32("mmap_size", FlexSpiState, mmap_size, 0),

Preferably simply 'size'.

>>> +    DEFINE_PROP_END_OF_LIST(),
>>> +};
>>> +
>>> +static void flexspi_init(Object *obj)
>>> +{
>>> +    FlexSpiState *s = FLEXSPI(obj);
>>> +
>>> +    memory_region_init_io(&s->mmio, obj, &flexspi_ops, s, TYPE_FLEXSPI,
>>> +                          sizeof(FLEXSPI_Type));
>>> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>>> +}
>>> +
>>> +static void flexspi_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    FlexSpiState *s = FLEXSPI(dev);
>>> +
>>> +    if (s->mmap_size) {
>>> +        memory_region_init_ram(&s->mem, OBJECT(s), DEVICE(s)->id, s->mmap_size,
>>> +                               NULL);
>>> +        memory_region_add_subregion(get_system_memory(), s->mmap_base, &s->mem);
>>
>> Where is this region used?
>>
> 
> These regions are enabled in rt500.c when instantiating the flexspi
> peripherals. As implemented now they are backed by RAM, the full
> implementation should translate accesses to spi commands to FLASH or
> PSRAM devices.
> 
> We need the memory regions because even the simplest NXP SDK examples
> are using the memory mapped flexspi0 region.

Devices shouldn't access get_system_memory() directly (it is
documented as kind of deprecated =) ). Since you implement a
sysbus device, you need to export the region with sysbus_init_mmio()
then the upper layer (SoC) instantiating it gets the regions calling
sysbus_mmio_get_region() and maps it. Then you don't need the
'mmap_base' property.

