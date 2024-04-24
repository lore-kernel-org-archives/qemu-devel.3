Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3357C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzg3W-0000Rz-7g; Wed, 24 Apr 2024 13:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rzg3R-0000Rc-HM
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:05:09 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rzg3O-0004hM-Qd
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:05:09 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ed5109d924so136170b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713978305; x=1714583105; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=pxMsRIMJ+DYLqAKwua38zdR5mgT9McfR/xx92XBIL0Q=;
 b=d3JKS2zTrX035M5rlH/9urAhoejo+pAFCCW2Xt4WlaHt5Qn30y2EJEG3BmkIQsR7RI
 psS9RXEU49UHybJUF6cTtbGekIDZl8RoZfglgSiTO/xqS7H7IgUQP0bFZbsuw0TAMWsa
 Fo9pCOyWZgOtfpmxUx7F0bDxhHE0cOibUsv9UwdyBqhsp3tp1FrvNHRKqk5L/UhC/OKR
 sODFp3OOmbu0f9yv/DAD05m9ciQwBFIKBFIfFwV4ddtN4/mxORZFiEmy1aE9LJ6cATOg
 T4Sdj7zT05mVQ9J6u7auqze2CP/5eVU2kesrf86lkhcdSvTBGysQsvzwa73nwT0Phxsi
 3A3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713978305; x=1714583105;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxMsRIMJ+DYLqAKwua38zdR5mgT9McfR/xx92XBIL0Q=;
 b=knFIH/kviPFUmi7nNWF7LB2AO42RA86c+j84JnLm3eEB655b6dolC4yHn3mQluipsX
 deEL6mpekf0wEZxtIqB16ASBdS6p4/PR1uPtaRCnmOgrNZ9qCHcUYhx2HGnnrOSzz6eY
 0RS3/wiVG1XYDpFYVgpWBa1eUwpaJgyoxZCVQZfVo+Be8E7S2ZwSo3mmEsyCTf1pNLsT
 7/DPkSU6WW0R4xYh6KbgANyK1/BNDgGBnvfZPjZJlEu3M2SHZNO0JHxJPJCyFmzjnjJo
 8Q3oHmGtKQYK5S2ydeJpyk2Pg+uCiGQ/1OdOsIe+qqdJvo8oEX1Usp0EmUfjUqzg6YV2
 YTkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb9t7GacD5Hpzb2/v6MTI+D8OGHIETOIjBevYn29TiaRIOcU1hAG0H4iiPWrs5uGDxAEt1rM2kR8zBgw2ltUBjpdbU32U=
X-Gm-Message-State: AOJu0YyuJaWJjdT/gDhV1wUcT3G4t9/IFlgaOHKoZR5F6kY1cwQTj9i+
 Otv5r8+LJaFF23+G6lac9ZURgowgfVlnSMcIKH+RBNMrArIU8nGs
X-Google-Smtp-Source: AGHT+IHMkj5AhrYaGU7ll8Bk7rBQeDZgj1S/af7fvQlsJmsx6P6hwv4DGgIiQ+AeaplkiEAoZn63Vg==
X-Received: by 2002:a05:6a00:893:b0:6ed:63e:3525 with SMTP id
 q19-20020a056a00089300b006ed063e3525mr3878201pfj.31.1713978304690; 
 Wed, 24 Apr 2024 10:05:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 gj7-20020a056a00840700b006e8f75d3b07sm11693378pfb.181.2024.04.24.10.05.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 10:05:03 -0700 (PDT)
Message-ID: <394f6c85-9814-40e9-a9aa-ce7e497aad3c@roeck-us.net>
Date: Wed, 24 Apr 2024 10:05:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems (timeouts) when testing usb-ohci with qemu
From: Guenter Roeck <linux@roeck-us.net>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 qemu-devel@nongnu.org
References: <4664cf39-5dfe-4557-959d-149640ca36e1@roeck-us.net>
 <edfmff7qm46edap6nz2ppvfhcw4jp6ahjltrv76jsiq5rhz5hw@v2lcbclpdsjt>
 <b815670f-fea4-4ab5-bf67-671c8395bfa6@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <b815670f-fea4-4ab5-bf67-671c8395bfa6@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/24/24 08:23, Guenter Roeck wrote:
> On 4/24/24 04:16, Gerd Hoffmann wrote:
>>> qemu hack:
>>>
>>>   hw/usb/hcd-ohci.c | 11 +++++++++++
>>>   hw/usb/hcd-ohci.h |  1 +
>>>   2 files changed, 12 insertions(+)
>>>
>>> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
>>> index fc8fc91a1d..99e52ad13a 100644
>>> --- a/hw/usb/hcd-ohci.c
>>> +++ b/hw/usb/hcd-ohci.c
>>> @@ -267,6 +267,10 @@ static inline void ohci_intr_update(OHCIState *ohci)
>>>           (ohci->intr_status & ohci->intr))
>>>           level = 1;
>>> +    if (level && ohci->level)
>>> +        qemu_set_irq(ohci->irq, 0);
>>> +
>>> +    ohci->level = level;
>>>       qemu_set_irq(ohci->irq, level);
>>>   }
>>> diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
>>> index e1827227ac..6f82e72bd9 100644
>>> --- a/hw/usb/hcd-ohci.h
>>> +++ b/hw/usb/hcd-ohci.h
>>> @@ -52,6 +52,7 @@ struct OHCIState {
>>>       uint32_t ctl, status;
>>>       uint32_t intr_status;
>>>       uint32_t intr;
>>> +    int level;
>>>       /* memory pointer partition */
>>>       uint32_t hcca;
>>
>> Phew.  Disclaimer: Havn't looked at the ohci emulation code for years.
>>
>> It should not be needed to store the interrupt level that way.  It is
>> possible to calculate what the interrupt level should be, based on the
>> interrupt status register and the interrupt mask register, and the code
>> above seems to do exactly that (the "ohci->intr_status & ohci->intr"
>> bit).
>>
> 
> You are correct. For the purpose of this kludge a simpler
> +    qemu_set_irq(ohci->irq, 0);
>      qemu_set_irq(ohci->irq, level);
> 
> would have been sufficient. My original code added tracing,
> where this generated a lot of noise. I didn't completely simplify
> the kludge. Sorry for that and for any confusion it may have caused.
> 
>> ohci_intr_update() must be called if one of these two registers changes,
>> i.e. if the guest changes the mask, if the guest acks an IRQ by clearing
>> an status bit, if the device raises an IRQ by setting an status bit.
>> Might be the ohci emulation has a bug here.
>>
>> Another possible trouble spot is that the timing behavior is different
>> on virtual vs. physical hardware.  Specifically with the emulated
>> hardware some actions appear to complete instantly (when the vmexit to
>> handle the mmio register write returns it's finished already), which
>> will never complete that quickly on physical hardware.  So drivers can
>> have race conditions which only trigger on virtual hardware.  The error
>> pattern you are describing sounds like this could be the case here.
>>
> 
> I think the underlying problem is that both the qemu emulation and
> the Linux kernel driver expect that the interrupt is level triggered.
> It looks like some entity in between handles the interrupts as edge
> triggered. This makes the kludge necessary: All it does is to generate
> an artificial interrupt edge.
> 
> This can be worked around in the Linux interrupt handler by checking
> if another interrupt arrived while the original interrupt was handled.
> This will ensure that all interrupts are handled and cleared when the
> handler exits, and that a later arriving interrupt will generate the
> necessary edge and thus another interrupt. That doesn't fix the
> edge<->level triggered interrupt confusion (if that is indeed the root
> cause of the problem), but it does address its consequences.
> 
> If anyone has an idea how to find out where the interrupt confusion
> happens, please let me know, and I'll be happy to do some more testing.
> I am quite curious myself, and it would make sense to solve the problem
> at its root.
> 
Update:

I found upstream commit 0b60557230ad ("usb: ehci: Prevent missed ehci
interrupts with edge-triggered MSI") which I think explains the problem.

Guenter


