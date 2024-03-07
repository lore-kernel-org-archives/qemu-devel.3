Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0FCC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAt4-0005ww-91; Thu, 07 Mar 2024 05:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAsu-0005gy-BX
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:57 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAsr-0007FP-QL
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:55 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d269b2ff48so9020981fa.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709806911; x=1710411711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ufP5Es4sPtuAnhqjx+zsVTbp4J0z//3jgbKXkTq58Ic=;
 b=UJWg1UNYnw/lZwotnkTv58uI+rGCBF6BfBMi4QyBQ4lRxEsgCEIUn0Ctc3/gC0KMyM
 pEiEZf4qr9IaxwRSnrP7H+Nxoc7HoMNhTYcVulLjHbKfDCVxOVv+53xne+qtpzRC7x6B
 +R76J+H+tHdT8vEyJLy0p0+VV6S7Q4+0WiuZtoOk/+VeR7Ouz5IY30CgmkbVHY+sdA/W
 c2FpECp58y7aI6S6Hp470DKtodK040aj/jzaVCnGEwTCAyyu1uV0xDD3BM9Vc6fkqK/O
 YMk+SP/uBYNtfIZh9zUsMVqT+iUNZA4+xjMVGKWCLeaQKIr3IyHvhooqCCaPocepyQbJ
 c6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806911; x=1710411711;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ufP5Es4sPtuAnhqjx+zsVTbp4J0z//3jgbKXkTq58Ic=;
 b=uQkOE5r3gruftGHGuUR+iteg7xc08Huk19aMJkOUfx73SVMWQ2EvhTSwM4NjAbHl20
 4Zeiw80Z9c636CEoPcRCiYAvdS7qUnYIY+zaFW6RSCh7TBq35ziQIIj5OBTgdzyU0IQb
 rD/SjRAEXB3S1tJsT1JUqlJs7roafyl2JaQr7ppJgf4PGYfwpSmK978Q5Q72+g5B6x52
 HrEbZpWrDMNne9kH41TBdySCKa/zlqv6O9F68rPtgu8/xxGQkfXGZ0BmAcG10dOuWGYj
 Rs1fvgNUPchq2YE89vywPPRVm8Amnw8zAS1s8FPxOGGfw0ljWeMUjjxqycv71VAIkaMe
 xOIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs926N+0He3Gv7C9HyStRAbOjr8gOSC1Z0hQPBwOdXA3lRTXDmZtzPnhi+5pGHPA8KdduMgU1XN5rnExVrB/CYh9REAws=
X-Gm-Message-State: AOJu0YxrtXyWJL2SLEqOUAetd+paCYfY+eel5149z5lUd8OebtXvo9Sb
 OR5I7U1/IO5HfVE8pgsz/vUc3+ZRpJt+Kenes8mbnmKBeJqVRPjIom4kEEKKu7U=
X-Google-Smtp-Source: AGHT+IEPCpCVezTENNKG9wKOh5d501svGttdlqMSBNhV9uobm4KJSUrIg/ChPri8uU0CUf304eZJ8Q==
X-Received: by 2002:a2e:2e09:0:b0:2d2:45e0:f154 with SMTP id
 u9-20020a2e2e09000000b002d245e0f154mr1112162lju.26.1709806911517; 
 Thu, 07 Mar 2024 02:21:51 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 az7-20020adfe187000000b0033e433cb471sm4104471wrb.79.2024.03.07.02.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:21:51 -0800 (PST)
Message-ID: <d0ae5297-08ff-4f91-9ddb-0ae7acdc8748@linaro.org>
Date: Thu, 7 Mar 2024 11:21:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] qemu-options.hx: Document the virtio-iommu-pci
 granule option
Content-Language: en-US
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 imammedo@redhat.com, peter.maydell@linaro.org, clg@redhat.com,
 yanghliu@redhat.com, zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
References: <20240306203348.65776-1-eric.auger@redhat.com>
 <20240306203348.65776-5-eric.auger@redhat.com>
 <fcaf95d2-bb09-4c55-a333-21a93a707ad2@linaro.org>
 <07478583-ce74-4de3-8983-010c6617e4a8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <07478583-ce74-4de3-8983-010c6617e4a8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/3/24 08:32, Eric Auger wrote:
> Hi Philippe,
> 
> On 3/6/24 21:44, Philippe Mathieu-Daudé wrote:
>> On 6/3/24 21:32, Eric Auger wrote:
>>> We are missing an entry for the virtio-iommu-pci device. Add the
>>> information on which machine it is currently supported and document
>>> the new granule option.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> ---
>>>    qemu-options.hx | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index 9a47385c15..757df3eac0 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -1172,6 +1172,14 @@ SRST
>>>        Please also refer to the wiki page for general scenarios of VT-d
>>>        emulation in QEMU: https://wiki.qemu.org/Features/VT-d.
>>>    +``-device virtio-iommu-pci[,option=...]``
>>> +    This is only supported by ``-machine q35`` and ``-machine virt``.
>>
>> Don't we need to precise x86 and arm here?
> Well I got inspired of intel_iommu doc. I think this is sufficiently
> precise, no?

Apparently not:

$ git grep -w '"virt"' hw
hw/arm/virt.c:96:            mc->alias = "virt"; \
hw/m68k/virt.c:314:    .name       = MACHINE_TYPE_NAME("virt"),
hw/openrisc/virt.c:37:#define TYPE_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
hw/riscv/virt.c:1754:    .name       = MACHINE_TYPE_NAME("virt"),
hw/xtensa/virt.c:127:DEFINE_MACHINE("virt", xtensa_virt_machine_init)

