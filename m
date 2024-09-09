Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831CBECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sni8z-0007M3-Jx; Mon, 09 Sep 2024 13:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sni8x-0007LA-Lw
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:25:39 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sni8v-0005sS-Vo
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:25:39 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2f029e9c9cfso62355541fa.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902735; x=1726507535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2QJFqvmVgOo0PF4qWFgpFcH+z+LPlJIUOsg1OJnLygU=;
 b=cjl8KSRm9n7SVUcmdQuOMpyJAyca3xY+ZqjqCAu4kE2ZA94xAljUppPCgeBZbF6ENq
 LwPg9Ieq12ALYYNcK6FnrFwzv9YbPco3Pwg+oNGdx03R9r5rLV0dbgSq6zCvnuAmyjTx
 EBLr82UFYvGLczrsKJKkTJTPyktmwBfBD20kBREahiSmAH7+7x9ZALm7EGP44jnZVcLY
 pSft+l+9z/5idE/lkQbrFj1Fj92/KemQvCNx/ho9JuYJ6ajh4TvBFO9rjbthrUeTe+/N
 9gudpjWzeu6xhVHzxAmxJ9IjxrKWOy/gA92he80cwG02G1VJoyZKzvj3T1pmrMqujOWl
 TLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902735; x=1726507535;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2QJFqvmVgOo0PF4qWFgpFcH+z+LPlJIUOsg1OJnLygU=;
 b=uqBcgyRgprZB0NwskZ4lmm8SN6BS/cc/mL447RgyFGNalTHVAaReZYs9//wKATnkO5
 SYt373RD2cDvi1UlhHgyas/9+mTT+LRwzJN2fbdjfqJv+hunTDURrQi2twOp8LcltU9P
 VPCZZKY8LSVCNc03sl0+XgJ+rW+QhyE1oR7aHzHY5u8bxrqczy6SgHp9BMjAftdTbo+3
 7bLoR2/wFJbndlMkWHFJhvkMDobxyj/1JIOkkoi2p/4//qJ1I6PHM8tQ+hLVqqdB2f0M
 +85RnDtiaOV+iidmdCrGkuet9AF1j6QUbBxq9KAjsqF3l3E8sKmMt/wdzJY6un+2coqH
 uotA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGhb3O9O8nRKe+WZZNKpJRLpmgxvInuoQwTs+Oq9J14lPdzNv5/zXK8CKOOono2VU8/VLzbcJDmNn/@nongnu.org
X-Gm-Message-State: AOJu0YwV/sgD45LE4mYd0JcQp7QHnIc2L9WyUSFZmUfnH/+0GFCq/t2s
 2WpccK/sPuywoEEsT5gL2x5ok01/SdyLZ/U37gw3A/a7VW2HXsihYuptANyNcAA=
X-Google-Smtp-Source: AGHT+IHIWfmp4ruS9y97lc6VmC/ZM1pwRPQTJxlfAEjUrE885ZpUMhjRI2qMdQfNsZf9Kj0aTHGCIw==
X-Received: by 2002:a05:6512:3a84:b0:530:dfab:9315 with SMTP id
 2adb3069b0e04-536587a67b6mr8043914e87.10.1725902735150; 
 Mon, 09 Sep 2024 10:25:35 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25835d31sm369665166b.10.2024.09.09.10.25.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:25:34 -0700 (PDT)
Message-ID: <3d622822-b4a9-49b1-950e-8f33b6532d8f@linaro.org>
Date: Mon, 9 Sep 2024 19:25:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 00/53] arm: Drop deprecated boards
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Guenter Roeck <linux@roeck-us.net>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <fabedae0-d748-4a9d-b802-14d15f3cd44a@linaro.org>
 <CAFEAcA9z9Mf52pOVCHv_Y1hvPPWt7Me5CDcxYS_cXvj7OFDuSw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9z9Mf52pOVCHv_Y1hvPPWt7Me5CDcxYS_cXvj7OFDuSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

Hi Peter,

On 9/9/24 15:44, Peter Maydell wrote:
> On Mon, 9 Sept 2024 at 14:41, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi,
>>
>> On 3/9/24 18:06, Peter Maydell wrote:
>>> This patchset removes the various Arm machines which we deprecated
>>> for the 9.0 release and are therefore allowed to remove for the 9.2
>>> release:
>>>    akita, borzoi, cheetah, connex, mainstone, n800, n810,
>>>    spitz, terrier, tosa, verdex, z2
>>
>>> The series includes removal of some code which while not strictly
>>> specific to these machines was in practice used only by them:
>>>    * the OneNAND flash memory device
>>>    * the PCMCIA subsystem
>>>    * the MUSB USB2.0 OTG USB controller chip (hcd-musb)
>>
>>> thanks
>>> -- PMM
>>>
>>> Peter Maydell (53):
>>>     hw/input: Drop ADS7846 device
>>>     hw/adc: Remove MAX111X device
>>>     hw/gpio: Remove MAX7310 device
>>>     hw/input: Remove tsc2005 touchscreen controller
>>>     hw/input: Remove tsc210x device
>>>     hw/rtc: Remove twl92230 device
>>>     hw/input: Remove lm832x device
>>>     hw/usb: Remove tusb6010 USB controller
>>>     hw/usb: Remove MUSB USB host controller
>>
>> Some of these devices are user-creatable and only rely on a bus
>> (not a particular removed machine), so could potentially be used
>> on other maintained machines which expose a similar bus.
> 
> Which ones in particular? Almost all of them are sysbus.
> At least one of them that I looked at (lm832x) is an I2C
> device but it also requires the board to wire up a GPIO line
> and to call a specific C function to inject key events, so it's
> not actually generally usable.
> 
>> We don't have in-tree (tests/) examples, but I wonder if it is OK
>> to remove them without first explicitly deprecating them in
>> docs/about/deprecated.rst. I wouldn't surprise users when 9.2 is
>> release. Maybe this isn't an issue, but I prefer to mention it
>> now to be sure.
> 
> I think this is unlikely to be a problem, but if you have
> a specific device you think might be a problem we can
> look at whether it seems likely (e.g. whether a web search
> turns up users using it in odd ways).

I don't have specific example and am happy to remove these
legacy devices.

I'm wondering more generically about removing user-creatable &
on-bus devices, when explicit use is removed (deprecated board
removed), but we can still use them elsewhere. IMHO for clarity
in the future we should list them in deprecated.rst along with
some lines like "this device is explicitly used by the FOO machine which
is being deprecated; if you want to keep them, provide test cases".

(To be clear, I'm not asking we do that for this devices set.)

Regards,

Phil.

