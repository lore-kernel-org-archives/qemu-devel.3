Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84D7C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 06:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYKYc-0005D1-FT; Fri, 09 Feb 2024 01:40:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYKYX-0005Cr-Ux
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 01:40:14 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYKYW-00024L-0o
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 01:40:13 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40fb3b5893eso4936825e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 22:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707460808; x=1708065608; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p8pAjLzGdeGGNTxQpARlEMWP5pBXCwRv1spM3uKVCNA=;
 b=fhUOzdenwyPALpCr4HwYmENOFRaJmxCywwgmo6tKjkyOB7jp+nbQW+nwjSp4H6Mnkn
 0uxJcCEFzIGPmrcjqKEkBYk7mVpOyVPn0vngclW59SlHzzdPUaoWCjUV7VBMdTOCSHsc
 3y8GEpZXxNoQULWemXlmS0jDvAQwzQAw6yh+i17BMjSlZ/nEztACCuwxfARbGUyheVK0
 Qi8v9aimPQcH2KdOIuylK3emaLiSdw28El3tyTOWXZO9R/GnaMaAZEzrIeeeBYOVaKQx
 Ksl9BlfTnGyFS9PSmLR//9QP7GIzJt8Vy/XV/jz4Gkuge3Io8qQQazExXMCl9ba0Z7nP
 uoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707460808; x=1708065608;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p8pAjLzGdeGGNTxQpARlEMWP5pBXCwRv1spM3uKVCNA=;
 b=c8lq4ctIX4QxgWnOAUdt46Ey8Rvrb7KX0Fft4t0PMVWv7qhFVgan4H5hyS/qd8p477
 7FrCMb5BRWNRCU2ILTZhpD9vdmAgxSFB/pVZKXlZWIoVN92kvPzE8TklfOlFtk0Vua8+
 Imh0OFHgKwn0Y2BBihNNaazYyoFG0uI73rr8umyPe8zkRJOKDdQeQGNFjH47Np+5Pr5O
 VKKg5b4AYLrh//RPYJWSEqLlgrUx6UN1c2S/QIcngZ5T1jiCa3K57TeFI9m3lKyOvGM+
 MxPhth2rIfcsm0gdJnpFmfYrt+hRhjJQoRROvIKglM1bAgM5PWWUnW8tvjwmhZokNYke
 zLmQ==
X-Gm-Message-State: AOJu0YwZQVQk2RXJ8LCz6Yk9rz0ne8iVxrk/fDoa3N/kRgcpjnL9PsY3
 Ed7ufgXbun+Y3rNNUn+e7JQlDYePXz27vuwq/pbn1uWwIayCOZhXMlKRzG0qhac=
X-Google-Smtp-Source: AGHT+IFNrg9z+q/s1EaCUQT+HwNzLQ86tWBWNtcscsF4tOI7agt6JtAEvSoZwWczQRWWIV5lAu97tg==
X-Received: by 2002:a05:600c:4f4b:b0:40f:dd7e:4a4d with SMTP id
 m11-20020a05600c4f4b00b0040fdd7e4a4dmr482043wmq.31.1707460808566; 
 Thu, 08 Feb 2024 22:40:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWyz//Yyo/542MPxONwao60tJSvaL+Jmsnl5mXzCXj4q7Zjvysp4+fqKHGpMjAf2WRUtZuuXBHrPOKelNZjGnDGVAE+Oc99erkPkxV2Dsm23f1sL13flKam4afHPeqFB3u9Fm/x+Wpb6XavoZeS7vAI8IGxP/IPdWUoNlNyqTvgfdT40C0L9/WYJec7CHQIJs6FS/bSHAvN+i9Xr8lmQRY4u1s4QqUwWiWYvjJKUwYEI9fZDizBVsSs6LCgM2sh44OpE6S7e820sh4LEIKfbNOUmwbwyQfL2K1oQm4OvGdQDNBNqSp2oRTDweO1Eao41nG8wzN7Cgs7V8b8MDgUl5F0Sw==
Received: from [192.168.69.100] ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a05600c3b8300b0040e527602c8sm1567676wms.9.2024.02.08.22.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 22:40:08 -0800 (PST)
Message-ID: <465292c7-1212-4e48-aa9e-9a0c3fe2923d@linaro.org>
Date: Fri, 9 Feb 2024 07:40:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] hw/misc/macio: Realize IDE controller before
 accessing it
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-7-philmd@linaro.org>
 <4f25c957-3019-2dcf-56ac-cf34a2fb6c53@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4f25c957-3019-2dcf-56ac-cf34a2fb6c53@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 8/2/24 19:33, BALATON Zoltan wrote:
> On Thu, 8 Feb 2024, Philippe Mathieu-Daudé wrote:
>> We should not wire IRQs on unrealized device.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/misc/macio/macio.c | 8 +++++---
>> 1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
>> index c9f22f8515..db662a2065 100644
>> --- a/hw/misc/macio/macio.c
>> +++ b/hw/misc/macio/macio.c
>> @@ -122,15 +122,17 @@ static bool macio_realize_ide(MacIOState *s, 
>> MACIOIDEState *ide,
>>                               Error **errp)
>> {
>>     SysBusDevice *sbd = SYS_BUS_DEVICE(ide);
>> +    bool success;
>>
>> -    sysbus_connect_irq(sbd, 0, irq0);
>> -    sysbus_connect_irq(sbd, 1, irq1);
>>     qdev_prop_set_uint32(DEVICE(ide), "channel", dmaid);
>>     object_property_set_link(OBJECT(ide), "dbdma", OBJECT(&s->dbdma),
>>                              &error_abort);
>>     macio_ide_register_dma(ide);
>> +    success = qdev_realize(DEVICE(ide), BUS(&s->macio_bus), errp);
> 
> If realize is unsuccessful can you connect irqs if device may be 
> unrealized? So maybe either the next two lines should be in an if block 
> or drop the success flag and return false here if (!qdev_realize) and 
> true at end of func?

Doh you are right, thanks!

>> +    sysbus_connect_irq(sbd, 0, irq0);
>> +    sysbus_connect_irq(sbd, 1, irq1);
>>
>> -    return qdev_realize(DEVICE(ide), BUS(&s->macio_bus), errp);
>> +    return success;
>> }
>>
>> static void macio_oldworld_realize(PCIDevice *d, Error **errp)
>>


