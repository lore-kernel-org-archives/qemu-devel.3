Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78050C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pC2-0008Tn-Ha; Fri, 18 Apr 2025 13:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pBs-0008Nt-AD
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:07:48 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pBq-0005bd-Ae
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:07:47 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so14820335e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744996061; x=1745600861; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WQcUR+8DZpToY40YkzrKeJh5gMEQCSz+L8jocvc+Mgc=;
 b=y0b58yTC6C6VeFTnBgFYupIIvk1Vow5+nJuWAmR2oSeXidptwpxTAsJDh8Qzxa0wJ7
 8MhqdCeQBAFvDBItLFRHBG71FTbGnDDi5kYBQl+Rj4LXK/Mx8V6SePB04sNKdwDhIVSp
 KjPQsbNaJDwMmxsE2ddf/l4BJWt7Br9MNu623iJignU85wZOl9mBFnfytEtkY7SbaVm1
 Bb7hKWU9HoDyEqbPr1SUHQzmCv/4DANycRK/8+tc5GzCHao57UQqCtKvP9e+QXGSncS8
 2anhxiQ2V0hoZX6k+/T3mJE0XYs9dECIPbs0A6ijfMIIPD7ajeVbO1t/0AsgwbiE3AYa
 4VHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744996061; x=1745600861;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WQcUR+8DZpToY40YkzrKeJh5gMEQCSz+L8jocvc+Mgc=;
 b=f4U8Mgr+f9fAon0mCqyC1duWRQ2yUAAlvx1H2N94JmuorrXfS0KsMCTBMSyvEsPI4M
 CkGxbQ7QUk8E7whleOF9FKXkRD0V6rRGHLByz7i8ZDa0C73CtIIPZNWhtOrgUrLsBpiN
 f/ZiLolFdJG04kCaceWp95VGY4GlKd93aFYtG/r9VUuu73DmCjqLF9xVWmgETSK2uF0U
 XR5ClhT9/hnIszXHQse9TuQBZAMwwITTXHK6X1PYdyQmb+JjlA9iCneY1YJ8M3S+UxqZ
 X1h4lm+x/37hvvZVVPbGLZwEZNpOqLBxkfSJnBgMufrl6dlflxDfGayT8HUKFeMVuZtZ
 HOlw==
X-Gm-Message-State: AOJu0Yz7+xHhn+5+rGUsm2scRndr6fZ36UUxYDxy1hBRsIZpYj/5LoPc
 kQlDbJ8Y/bcnq9ZFvOTIqB1OyvKR6zptridN8GltuxZ9RrC9+lpV8Uw8vPYdMiA=
X-Gm-Gg: ASbGnctd0oDw59NGTXuDQCR+JEe+Lu/buMrVvIydAYZu3tutH1Bv/W1K6Q358QFT+Jz
 UIoiqJzA0f+qswzhJOcAG8VkA9wvrE5tAf5+hKlfw9595qeEXLIv09Sxz74QmmVIKpkJVt60lyH
 L6+E2iA3pdUGaTKulsAlONdMhclXfr88cB4P/Y5hihAg84IHUZI4VYeJG8x+sWfoLTwB3Y/wI8n
 JM/OosIH42A22hHJDBqiaSSTMjFUXiU1FtoRgeK5DPuQxSrOJf5k8m1y5QP5vEslhEZdYXOf/vV
 moVUi1dNYz2RoLfoQxsbMauUbcorVgCFzUjCRbAjorWY5OJhKshz+aqrSeedOrEWkWSQr1Zp//9
 cYBtEX3Bz
X-Google-Smtp-Source: AGHT+IHJ9iYzmhW/jH/beRGQ1lS/IAqhHL/Sdsjaw2FW8KO27jr9cT+HecZeYxRbsL8ucnq/R8jluQ==
X-Received: by 2002:a05:600c:1547:b0:439:6118:c188 with SMTP id
 5b1f17b1804b1-4406aba756emr26720995e9.19.1744996061226; 
 Fri, 18 Apr 2025 10:07:41 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5a9e0esm29601275e9.5.2025.04.18.10.07.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:07:40 -0700 (PDT)
Message-ID: <ee3c9b11-4c4e-41c7-8029-7e5c153215d7@linaro.org>
Date: Fri, 18 Apr 2025 19:07:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] hw/arm: Define machines as generic QOM types
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Felipe Balbi
 <balbi@kernel.org>, Bernhard Beschow <shentey@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Alistair Francis <alistair@alistair23.me>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20250417235814.98677-1-philmd@linaro.org>
 <a302fb91-e2d8-ef36-ac53-5e460476c2d0@eik.bme.hu>
 <25a82a76-cd63-4a42-bb68-5dcf826bd948@linaro.org>
 <26c2b844-dc96-448e-8978-e536ed1e61f6@linaro.org>
 <35ae8633-4195-446b-9a22-0c131b9cab88@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <35ae8633-4195-446b-9a22-0c131b9cab88@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 18/4/25 19:03, Pierrick Bouvier wrote:
> On 4/18/25 09:59, Philippe Mathieu-Daudé wrote:
>> On 18/4/25 18:33, Pierrick Bouvier wrote:
>>> On 4/18/25 01:53, BALATON Zoltan wrote:
>>>> On Fri, 18 Apr 2025, Philippe Mathieu-Daudé wrote:
>>>>> While DEFINE_MACHINE() is a succinct macro, it doesn't
>>>>> allow registering QOM interfaces to the defined machine.
>>>>> Convert to the generic DEFINE_TYPES() in preparation to
>>>>> register interfaces.
>>>>>
>>>>> Philippe Mathieu-Daudé (11):
>>>>>    hw/core/null-machine: Define machine as generic QOM type
>>>>>    hw/arm/bananapi: Define machine as generic QOM type
>>>>>    hw/arm/cubieboard: Define machine as generic QOM type
>>>>>    hw/arm/digic: Define machine as generic QOM type
>>>>>    hw/arm/imx: Define machines as generic QOM types
>>>>>    hw/arm/integratorcp: Define machine as generic QOM type
>>>>>    hw/arm/kzm: Define machine as generic QOM type
>>>>>    hw/arm/msf2: Define machine as generic QOM type
>>>>>    hw/arm/musicpal: Define machine as generic QOM type
>>>>>    hw/arm/orangepi: Define machine as generic QOM type
>>>>>    hw/arm/stm32: Define machines as generic QOM types
>>>>>
>>>>> hw/arm/bananapi_m2u.c      | 13 +++++++++++--
>>>>> hw/arm/cubieboard.c        | 13 +++++++++++--
>>>>> hw/arm/digic_boards.c      | 14 ++++++++++++--
>>>>> hw/arm/imx25_pdk.c         | 14 ++++++++++++--
>>>>> hw/arm/imx8mp-evk.c        | 15 +++++++++++++--
>>>>> hw/arm/integratorcp.c      | 16 +++++++++++++---
>>>>> hw/arm/kzm.c               | 14 ++++++++++++--
>>>>> hw/arm/mcimx6ul-evk.c      | 15 +++++++++++++--
>>>>> hw/arm/mcimx7d-sabre.c     | 15 +++++++++++++--
>>>>> hw/arm/msf2-som.c          | 13 +++++++++++--
>>>>> hw/arm/musicpal.c          | 16 +++++++++++++---
>>>>> hw/arm/netduino2.c         | 13 +++++++++++--
>>>>> hw/arm/netduinoplus2.c     | 13 +++++++++++--
>>>>> hw/arm/olimex-stm32-h405.c | 13 +++++++++++--
>>>>> hw/arm/orangepi.c          | 13 +++++++++++--
>>>>> hw/arm/sabrelite.c         | 14 ++++++++++++--
>>>>> hw/arm/stm32vldiscovery.c  | 13 +++++++++++--
>>>>> hw/core/null-machine.c     | 14 ++++++++++++--
>>>>> 18 files changed, 213 insertions(+), 38 deletions(-)
>>>>
>>>> This is much longer and exposing boiler plate code. Is it possible
>>>> instead
>>>> to change DEFINE_MACHINE or add another similar macro that allows
>>>> specifying more details such as class state type and interfaces like we
>>>> already have for OBJECT_DEFINE macros to keep the boiler plate code
>>>> hidden
>>>> and not bring it back?
>>>>
>>>
>>> We can eventually modify DEFINE_MACHINES, to take an additional
>>> interfaces parameter, and replace all call sites, with an empty list for
>>> all boards out of hw/arm.
>>>
>>> As long as we avoid something like:
>>> DEFINE_MACHINES_WITH_INTERFACE_1(...)
>>> DEFINE_MACHINES_WITH_INTERFACE_2(...)
>>> DEFINE_MACHINES_WITH_INTERFACE_3(...)
>>> I'm ok with keeping the macro.
>>>
>>> Would that work for you folks?
>>
>> But then we'll want DEFINE_PPC32_MACHINE() ->
>> DEFINE_MACHINES_WITH_INTERFACE_1() etc...
>>
> 
> We can see that later when touching other targets. For now, 
> DEFINE_MACHINE is not used in a lot of places, so replacing call sites 
> should be easy, and it will cover hw/arm, which is our point of interest 
> now.

I concur and share the same goal, but here Zoltan is concerned about
converting DEFINE_MACHINE to DEFINE_TYPES adds 12 lines of boilerplate
code.

