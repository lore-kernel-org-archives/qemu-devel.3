Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B20CD0EE3F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 22:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szNrD-0008Rw-Bv; Fri, 11 Oct 2024 18:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1szNrC-0008QK-7s
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 18:11:34 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1szNr9-0003F3-6c
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 18:11:34 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5398996acbeso2935721e87.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 15:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728684689; x=1729289489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=unsVltNUFL0Z5VZfJot5DeP2qCj7b8KICAcuxr+k0Ho=;
 b=O4J2oMn90wT5BDkjPzQsX+bx4h4PWYQKpGnTN4khjQrGU1CBt8f1gJ2f1D35WYKM8V
 N1YTjpDrz7DA+f2ps1/qSEb8a5lyAg6CsydrTZOS6TFPVk/uQMFijZfKSIATJ5MgU61+
 roV9rnrS/RfADvnczFKSf+pwn5z+B65Lv3MOaU1G+HxUGZRyrAHYNz9IoidujgFsJ5f4
 x5FO/t9FnjbEzetBQnzYDIknY3W4q3g7ueILdWEX7nFRGqFqsIgWI3PyGP4X0atCgFw/
 cfeADAEHgCZS7j8IY/HDYojk1JRFMb4lXAk4S7M05zy72up+XzPNiAxH0cQlAMX2XWp8
 fxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728684689; x=1729289489;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=unsVltNUFL0Z5VZfJot5DeP2qCj7b8KICAcuxr+k0Ho=;
 b=SOJX4rM1boc61/JxxQgB4nVkZ+2Wj1F7+UfzqjgVvPind1lDTYSxN3dYMViKVbeiLw
 EpTdjOsmHriCOqQFEiW9PERtYz4yb3xWo1qLVInquatNBr97h/hMhKKkWD7eqygKOV3y
 GYsaHz3kEsVbSjSQhyE2FjiEGHduqFeBUzpqpWDE3XcgvFhuHoqIAdUNSmGE2FFxHpVK
 agSuiwlPCC949hXgY7NPrlT2BCArDyNMZIAdoEBauPNUxjLj2IJSUN1/GMJNwAFiUqBY
 QSQZr9jg6Ede91LTqR+G7FnkdDeUw6B2qXFBbd1Zka1Zo+OKjJ6cOIbVVuID4y3c9Udq
 6Krg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLgR9uEmpoXERt0CUVABTvOT/IIXUSrJr8DvgFYbqwM8QBvgApmmv4k5sjaJ56OTNsMhD8/44lm0td@nongnu.org
X-Gm-Message-State: AOJu0YzAS1TAc25a9L8fOMa7/mgbB0/gwYPu6UYTnObPlDpWdPrcBL8o
 +qIisxkjJ18q6/uZ4lOmBAG3fkumpcezE66EsC2HEZXYOOXGjbpIrdbT8tIZBeA=
X-Google-Smtp-Source: AGHT+IFgIoJ4CkpH8RuXzjuazmltGBuysSoTzuwOOHYI3PxOue+8FcHxZTHiJ1eTFOJid8U8PVvxRg==
X-Received: by 2002:a05:6512:6606:b0:539:dc87:fd3a with SMTP id
 2adb3069b0e04-539dc87ff49mr1897228e87.6.1728684688527; 
 Fri, 11 Oct 2024 15:11:28 -0700 (PDT)
Received: from [192.168.222.92] ([91.209.212.130])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539dc70b8d9sm324712e87.125.2024.10.11.15.11.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 15:11:27 -0700 (PDT)
Message-ID: <a7aa5078-0787-4fa5-95d4-62dbd9a89ac9@linaro.org>
Date: Fri, 11 Oct 2024 19:11:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] hw: Strengthen SysBus & QBus API
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhao Liu <zhao1.liu@linux.intel.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <20240208181245.96617-1-philmd@linaro.org>
 <2758986e-72f4-4706-a3d3-c63c6283af86@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2758986e-72f4-4706-a3d3-c63c6283af86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

On 11/10/24 05:56, Paolo Bonzini wrote:
> On 2/8/24 19:12, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> This series ensure following is called *before* a
>> device is realized:
>> - qbus_new()
>> - sysbus_init_mmio()
>> - qdev_init_gpio_in_named_with_opaque()
>>
>> and these are called *after* it is:
>> - sysbus_mmio_map()
>> - sysbus_connect_irq(),
>> - qdev_connect_gpio_out()
>> - qdev_connect_gpio_out_named()
> 
> This series is missing a _why_.  The original vision for qdev was that 
> the whole machine would be realized at once from vl.c, and therefore 
> there would be no need for realizing subcomponents by hand.
> 
> This probably will never happen, but it is still worth explaining why 
> it's now considered so conceptually wrong, that it is (or will be) 
> enforced by the API.

When looking at a roadmap toward "dynamic machines" with Markus we
needed to clarify the QOM life cycle before thinking about possible
DSL to declare machines and components. See:

= Problem 4: The /machine/unattached/ orphanage =
= Problem 5: QOM lacks a clear life cycle =
= Problem 7: Design of the machine specification DSL =
in https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/,
in particular:

     '''
     We need to manage a state transition from "object created,
     but not ready for use" to "object configured and ready for
     use".  In what order do the objects change state?
     '''

and:

     '''
     Ideally, a composite object's components go through the life
     cycle together.  First, create all the components and assign
     parents.  This also creates all the properties.  Then configure
     the object by setting property values.  Finally, complete / realize
     all components.
     '''

We need a better QOM documentation, "Device Life-cycle" in
docs/devel/qom.rst doesn't reallyr describe the life cycle, and
doesn't mention the "realization" API contract.
Since you have more experience and historical view on the APIs,
I wouldn't mind if you want to clarify that; otherwise I'll try
to do it.

Regards,

Phil.


> Paolo


