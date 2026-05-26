Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535E5CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnrf-0003gM-OG; Tue, 26 May 2026 05:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRnrZ-0003fu-9Y
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:14:13 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRnrX-0006Te-IO
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:14:13 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so6303963f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779786849; x=1780391649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nWbVrlX0nj+3Uug3k7bJ2d5MbKjBetVtl28RCg8MFN0=;
 b=IxmPtB7VH8OXBWk32mFcjPHjT9udqvu7BaWOJiTS1744IH9G2+fAbHbl5fW4Zua06A
 GoRGZLgBTbKsKfUFw4HcjjGDd5pW7UXTBhzYx7CuH4qkDD2itcmXfDib82dHtwWznadC
 tZl7FLpk60AoK6jG5dQ+60HSf1q531UXMbqMvJJpl2JOaKceo3my/t0R692R7kLKSxGS
 TAi9H77gCjuwgXoRgioN7o/bG867KGMn/oz5JNm/5lWWzZM/EYURxzNONP8/GEBjq2rg
 foPMfA106w8lRJAnjBx4inweRr2wtOn0U7w92LdRisis1Rm4llEo/sYXJMgf7hzp/wbh
 +0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779786849; x=1780391649;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nWbVrlX0nj+3Uug3k7bJ2d5MbKjBetVtl28RCg8MFN0=;
 b=VlV9fYUKxPS5tT7g9DDLP9dmSBAsC0ws7DHH9kYtVqGmZsHLzUCGj3ZuN/j8PaAIjQ
 VS2/e1VfpJLk9aX/663m7F0+j5ybeIILbEj5Sz6kPJvz2ci3ZLoLcp9ma9GR65JIBV0p
 0hbbdIrao19jQMqfHUbTcfrmSUEenthuj5prcaZ0S7vdNrdGvMjo4HE7irmnMdlbwG92
 iPsDIin6cFnQLwZ/V+/yTdhtn5sdxhQFijf7NAWD6cQ8n3iUrRXbY055msBXQHVYqP+3
 d/SNs0yhItzNi8vAW6vWdYYfueCGs1h2QzjUuFJZWYJvLSvyUY2/o6yfpqc/1jZI7gmG
 wZ8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ81uH+IVKe3Sxo88zV+Wg6bgte6Sa1SXwqGnwh2wRSejkVxBWw1F0rfo+sQtyU0AvgzwROttXA4UXQG@nongnu.org
X-Gm-Message-State: AOJu0YzulvN62n/skfAVVIAphP0XDjQO31E+5XwIB+z8AiIL/PB2T2H0
 lVuoBIQPqfZFSQmk1VftlGjry8gJgy1TbXyjTqRQwSJCQ+O5g2epLbaOByGuIsT8dzCs1HrQFps
 vqOsnGBP85vFy
X-Gm-Gg: Acq92OHczmojGlYxC6EEO1Ja+eB4sz+N5V2xaFaamG/LRIRZ0vFQMRWQID5pBMreI1Y
 JpxG+Q2bb8fxydUva8ZZRZ9Guud9tNi8FSlhwJYCWp7eZg3mbsjlVyL6mBTNBYSR6DNXq8PlatP
 TyDWdD/TjwyFFPKPvzY0yxWb0dIzi+SJoAYjDPCpjGHGVeui2k2Z6pq33kE3VsYdktvE60fZs3U
 RXEEAOkN7R5QnExCgPek+UZHsWxLhyioz6KJ5sm+1+SAy1+eyTufG5J2NrvHWwp64ry56d6NZiw
 qGBLmo8OHbyP8AhSf+EVie6doT8NTeNjw0e87NwIkv59vYPzKQ/pb95dntKjKq2yaG0jr/aassI
 7I2fpK2VJKLF72JqsSA9hRNDLmxFOmghHaqUxrm8IxFpEzObrqgEQ3+hAvjwm9ne0VV8sKNRdPW
 I2nfjcS9wb452eeqw19uJuiWYR4L/SsY7ohw19MSUbM08r+E73KU13MMFUVS9MP8qBGg==
X-Received: by 2002:a5d:59c6:0:b0:449:c1e8:7655 with SMTP id
 ffacd0b85a97d-45eb39e1e97mr28504285f8f.27.1779786849392; 
 Tue, 26 May 2026 02:14:09 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6cd10acsm28245005f8f.15.2026.05.26.02.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 02:14:08 -0700 (PDT)
Message-ID: <19f602ec-d2fa-42c8-b09e-26596617ef35@linaro.org>
Date: Tue, 26 May 2026 11:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCHv1 6/7] hw/arm: Enable Cortex-M7 AMP boot on
 i.MX8MP
Content-Language: en-US
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "shentey@gmail.com" <shentey@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20260519175635.3245229-1-gaurav.sharma_7@nxp.com>
 <20260519175635.3245229-7-gaurav.sharma_7@nxp.com>
 <28c31997-b4db-436c-bff7-12ead07254fd@linaro.org>
 <2aaa4dfc-cf5d-4381-9c77-d78679819ba7@linaro.org>
 <AM0PR04MB4370F4FD3CBBF074F41FD12C870C2@AM0PR04MB4370.eurprd04.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <AM0PR04MB4370F4FD3CBBF074F41FD12C870C2@AM0PR04MB4370.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

On 23/5/26 21:14, Gaurav Sharma wrote:
> 
> 
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Sent: 20 May 2026 03:18
>> To: Gaurav Sharma <gaurav.sharma_7@nxp.com>; qemu-devel@nongnu.org
>> Cc: pbonzini@redhat.com; peter.maydell@linaro.org; shentey@gmail.com;
>> Zhao Liu <zhao1.liu@intel.com>; Pierrick Bouvier
>> <pierrick.bouvier@oss.qualcomm.com>; Markus Armbruster
>> <armbru@redhat.com>; Alistair Francis <alistair.francis@wdc.com>; Daniel
>> Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Subject: [EXT] Re: [PATCHv1 6/7] hw/arm: Enable Cortex-M7 AMP boot on
>> i.MX8MP
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On 19/5/26 23:45, Philippe Mathieu-Daudé wrote:
>>> Hi Gaurav,
>>>
>>> On 19/5/26 19:56, Gaurav Sharma wrote:
>>>> Configure the i.MX8MP to boot the Cortex-M7 core alongside the
>>>> Cortex-A53 cores in an Asymmetric Multiprocessing (AMP)
>>>> configuration. The M7 firmware can be loaded and started from Linux
>>>> running on the A53 cores via the remoteproc framework.
>>>>
>>>> CM7 boot is made optional. A GPR IRQ is connected to a cpuwait handler.
>>>> The handler translates the CPUWAIT into STOP and RUN.It follows the
>>>> classic Cortex-M boot sequence: initial SP and reset vector taken
>>>> from the vector table.
>>>>
>>>> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
>>>> ---
>>>>    docs/system/arm/imx8m.rst   |  86 +++++++++++++++++++++-
>>>>    hw/arm/fsl-imx8mp.c         | 143
>> ++++++++++++++++++++++++++++++++++++
>>>>    include/hw/arm/fsl-imx8mp.h |  13 +++-
>>>>    3 files changed, 240 insertions(+), 2 deletions(-)
>>>
>>>
>>>> @@ -72,7 +155,8 @@ For i.MX 8M Plus EVK:
>>>>    .. code-block:: bash
>>>>      $ qemu-system-aarch64 -M imx8mp-evk \
>>>> -      -display none -serial null -serial stdio \
>>>> +      -display none -serial null -serial stdio -serial null -serial
>>>> + /
>>>> tmp/imx8mp-uart4 \
>>>> +      -smp 4,maxcpus=5 -global fsl-imx8mp.enable-cm7=on \
>>>
>>> Not a blocker; I wonder if this is a good use of the -smp/maxcpus
>>> (thinking about long term AMP modelling).
>>>
>>> Maybe we could use a machine property for the M core, and keep the smp
>>> default value to the A core cluster:
>>>
>>>     -M imx8mp-evk,enable_cm7=on -smp 4
>>
>> I missed you already add a machine 'enable-cm7' property in this very same
>> patch :)
>>
>>    static const Property fsl_imx8mp_properties[] = {
>>        DEFINE_PROP_UINT32("fec1-phy-num", FslImx8mpState, phy_num, 0),
>>        DEFINE_PROP_BOOL("fec1-phy-connected", FslImx8mpState,
>> phy_connected, true),
>> +    DEFINE_PROP_BOOL("enable-cm7", FslImx8mpState, enable_cm7, false),
>> +    DEFINE_PROP_UINT32("cm7-vector-base", FslImx8mpState,
>> +                       cm7_vector_base, 0x80000000),
>>    };
>>
>>>
>>> But IMHO even better is to always create all cores like on real
>>> hardware. If the M7 is not used it is just sitting here, created and
>>> halted, not disturbing anything. Personally I'd rather not accepting
>>> any -smp option for such machine, just reporting an error if used "Can
>>> not restrict this machine, it is always created with 4 Cortex A and 1
>>> Cortex M".
>>>
> 
> Hi Philippe,
> 
> Since the emulation should be as close to the hardware as possible, that means we can always leave the M7 realized (even if it is not being used). Wouldn't it be better to avoid passing 'smp' , 'maxcpus' or even 'enable-cm7' in the cli ? We can configure the defaults instead. A simple "qemu-system-aarch64 -M imx8mp-evk" should suffice.

Yes, the simpler the better :)

