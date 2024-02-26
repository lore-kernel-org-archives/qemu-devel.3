Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB93C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeDb-0001r8-UP; Mon, 26 Feb 2024 11:52:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeDW-0001od-5G
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:52:38 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeDU-0006uk-JV
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:52:37 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412a9a3dba2so2812615e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966355; x=1709571155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tSU6Tsgy9/9NrFLddBu3RNWmoRCIbFiXaAJyrof4SeI=;
 b=OIXRqK10idLsS7BY8GbznHT2guS70WOdbuCi/d/+eeoWE445BP9m6YMqEbdDbPdWod
 M74VUyBXqkL/TlOz6aIvNQh87BUSDEUqqUrCnf2VBlJE3+nv7SnPz+/CD4Dzs6Hvu81J
 tEcko0I+U378SzL8/wKBx255817NnFq2NjYfqa42cY/JGtUi/gHxxDQjVypV8jHc6r1Z
 WTqDjRM53A2A4oCZOKeSSQXrNtaiuY9TG7N/ZNAmcYRdF5z1hgn2onM8m+Hdwod7q3pl
 2KGqY+3XqjF85tBVDjLwjj2Uh8FMX7j15N8z1DhKELu1dfFAvmAXO1ROVmOb4AJyrwSR
 Uzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966355; x=1709571155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tSU6Tsgy9/9NrFLddBu3RNWmoRCIbFiXaAJyrof4SeI=;
 b=W6lNJ85je3ZJ1qbqCt4vu3f6gickvJBvZ53UPRIewRiFJ2D8ESh4FSJ07mh2o9jtj3
 k1glx9H4/Ful4GDp1lUa/IWMwm0Z9ttdGAOSF2OEiioJhf40pTTwHgPBD4sZZ03EvJMp
 qnrSE4aamHhLxvxTMFinmF1hpgjYzemRLSrr4H3dvKVPNXJyHoDVe+uAy0XwJGQiY24D
 EK1tLfTffc9Kdxmb96vVza6SONZcrqGhBEGlyp4dAcB2XE5T0gI8pWcztWXKIpk+ExrY
 RzPoxLayXTHr72s5ohYsYzm2U3lQx9NIEzPo1QYe2Ok4aREzJ622uo9EUAUOEnm/Rvgj
 MHhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXmW+SczaduFRJ61qNpl4u1SRgzFY3OV41ueKI++Sxn4lkUB9RcdZIpIYmycv6xlk8lz4zCWeSlvgooMC4mO85+fcihlQ=
X-Gm-Message-State: AOJu0YzSjoq1XFOz+pDitkK2HmJBLCvd1SHP3lU7Q1QDEvE6Z2MPnZuv
 kGrPkxusKxhVE0yzzZPcvGA2E0l3IoTcUMIXtRN9fM6d232+4t/+0tpXUI8HQsY=
X-Google-Smtp-Source: AGHT+IE2+6Boc8dr6WF3sbGNluZC4Y/aZaNu1FAv2ceZSq2mMLoW01+4S/VPJ3ek6mt0Y7Er99oQmw==
X-Received: by 2002:a05:600c:3514:b0:412:69da:e9d5 with SMTP id
 h20-20020a05600c351400b0041269dae9d5mr5135698wmq.5.1708966354888; 
 Mon, 26 Feb 2024 08:52:34 -0800 (PST)
Received: from [192.168.69.100] ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a05600c474f00b004129860d532sm8865188wmo.2.2024.02.26.08.52.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 08:52:34 -0800 (PST)
Message-ID: <37c4bf08-c3df-4311-9f3c-a4a5c9da215d@linaro.org>
Date: Mon, 26 Feb 2024 17:52:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 41/41] Add RPi4B to raspi.rst
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sergey Kambalin <sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-42-sergey.kambalin@auriga.com>
 <CAFEAcA_xdowvZkxFC7ypEFRJSTLDkdx+9E3_fwPNY=S2sK5=UA@mail.gmail.com>
 <CAFEAcA88NqshmyH5czz8ZC0Kbb81_-8VHRMCSQDbpHrPwm6AWA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA88NqshmyH5czz8ZC0Kbb81_-8VHRMCSQDbpHrPwm6AWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 26/2/24 17:43, Peter Maydell wrote:
> On Mon, 26 Feb 2024 at 16:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Mon, 26 Feb 2024 at 00:03, Sergey Kambalin <serg.oker@gmail.com> wrote:
>>>
>>> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>   docs/system/arm/raspi.rst | 11 +++++++----
>>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
>>> index d0a6f08b2b..c21b27744e 100644
>>> --- a/docs/system/arm/raspi.rst
>>> +++ b/docs/system/arm/raspi.rst
>>> @@ -1,5 +1,5 @@
>>> -Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b``)
>>> -======================================================================================
>>> +Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b``, ``raspi4b-2g``)
>>> +======================================================================================================
>>>
>>>
>>>   QEMU provides models of the following Raspberry Pi boards:
>>> @@ -12,12 +12,13 @@ QEMU provides models of the following Raspberry Pi boards:
>>>     Cortex-A53 (4 cores), 512 MiB of RAM
>>>   ``raspi3b``
>>>     Cortex-A53 (4 cores), 1 GiB of RAM
>>> -
>>> +``raspi4b-2g``
>>> +  Cortex-A72 (4 cores), 2 GiB of RAM
>>>
>>>   Implemented devices
>>>   -------------------
>>>
>>> - * ARM1176JZF-S, Cortex-A7 or Cortex-A53 CPU
>>> + * ARM1176JZF-S, Cortex-A7, Cortex-A53 or Cortex-A72 CPU
>>>    * Interrupt controller
>>>    * DMA controller
>>>    * Clock and reset controller (CPRMAN)
>>> @@ -34,6 +35,8 @@ Implemented devices
>>>    * MailBox controller (MBOX)
>>>    * VideoCore firmware (property)
>>>    * Peripheral SPI controller (SPI)
>>> + * PCIE Root Port (raspi4b-2g)
>>> + * GENET Ethernet Controller (raspi4b-2g)
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> For the "no PCI/no ethernet" initial version, I'll drop these last
>> two lines; we can add them in when we land the pci and ethernet
>> patches.
> 
> ...better, I'll move them to "missing devices":
> 
> --- a/docs/system/arm/raspi.rst
> +++ b/docs/system/arm/raspi.rst
> @@ -35,12 +35,11 @@ Implemented devices
>    * MailBox controller (MBOX)
>    * VideoCore firmware (property)
>    * Peripheral SPI controller (SPI)
> - * PCIE Root Port (raspi4b-2g)
> - * GENET Ethernet Controller (raspi4b-2g)

When we add them back, no need to precise "raspi4b-2g" IMO.

>   Missing devices
>   ---------------
> 
>    * Analog to Digital Converter (ADC)
>    * Pulse Width Modulation (PWM)
> + * PCIE Root Port (raspi4b-2g)
> + * GENET Ethernet Controller (raspi4b-2g)
> 
> -- PMM
> 


