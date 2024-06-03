Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559B0C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE9Yk-0001tX-Ej; Mon, 03 Jun 2024 11:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE9Yj-0001tI-EU
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:25:17 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE9Yh-0007Jx-6Q
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:25:17 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-572c65cea55so7893119a12.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717428309; x=1718033109; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K6e09LwcEU1ABlWM3qZK/0WigiPLPGLjVRCDbxFxVn0=;
 b=CAulFrUMuc1EfJe9zBT5NrD9BBUQeAY6rRrr1HPewyRLLINMeqIfTIAhn1D+/chT9q
 kh75dpyuK+zrcWgi8y1QjAGK+qrqio8l5YoFPFB/CuwxzW22L7nM/vAUZGKPCPUzs7y/
 dE3A73GOEEiNudVE2yEKIOZq1hHNIXKTOOHu/rJMghAJAcNpHSb5fJscElWerKVyiaFn
 Hen6YjwbPlCE58zYfmlJQ5PKLaJPpEpydzJwX11/iq6jcalwb17jEm0E/DJVe4EBFQa4
 rxnVJwBJpIest/sEpsar0UPmEEhJ9dxNOKn42mZn+8FxupvF+frbdi+et5gwEsflCpLW
 ugIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717428309; x=1718033109;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K6e09LwcEU1ABlWM3qZK/0WigiPLPGLjVRCDbxFxVn0=;
 b=IGBK82DaArSKqhHL1jkqeRa+KkbP9eg/9HGBY39AYXaBu58oRaiaaDZy5zqTpFRlA8
 UFjHqwONi6UjGQ2Stfvk1/ZlILnXDGPTGB74xPJ752jgJuiQLYdl0Az/SBkeevp2PRfs
 nlQ/okT2kqXI2/RGuiRc4ALdD+yHCB7/f5LUldsdzMQxkiDCWCIvNaXlH1Z3aICk0wrW
 QNcYsKLL3hdGBumsNeimWJKoya04xWEmuRDvi5lLk2ipFcWeYDL4jpPJGpFzMZHstO0n
 OFSZRwuBE4QzAJMqxZuujjwnrmEaqD8/EyRcinDXsvFsuUClIowcnCewqy6g/n9XcL7s
 YJIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6J9AGtp89uJFFqGTcIf8Em8nfOKk6cdgGwa83eg1k3d4SwENag5uPzlFUk1BoyjfUc5tC/QbS4+ppXiT8fS/QIPh1RJk=
X-Gm-Message-State: AOJu0YyoRuF+W9IBxRTWp8gH3HZpzQHzjS8IHcYVJNEjMNshJuwQjnW9
 8L+oQblObD6mP0nesqzP62MCKl1Dyz09fOfzoCNEw6AQm9/0L26de69XqRukcZA=
X-Google-Smtp-Source: AGHT+IHQsOFIWzHMW/VWMOkG5lOH0zkkFB59nW0Gcm4eH5twKpi8JzyAMD1aOxynj1ZMJdHEBy9jPw==
X-Received: by 2002:a50:9fc3:0:b0:57a:79c2:e9d1 with SMTP id
 4fb4d7f45d1cf-57a79c2ea97mr199710a12.8.1717428309425; 
 Mon, 03 Jun 2024 08:25:09 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a4f172062sm3704696a12.90.2024.06.03.08.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 08:25:08 -0700 (PDT)
Message-ID: <40853796-e4a1-48ef-a61c-ae4984864e45@linaro.org>
Date: Mon, 3 Jun 2024 17:25:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] vga/cirrus: deprecate, don't build by default
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240530112718.1752905-1-kraxel@redhat.com>
 <20240530112718.1752905-5-kraxel@redhat.com>
 <3efcf132-dec1-3765-e77e-3fd207224eeb@eik.bme.hu>
 <c928e9e7-21b2-4017-be45-b0a4b91f1d06@ilande.co.uk>
 <Zl2rxIYdohROHXbg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zl2rxIYdohROHXbg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 3/6/24 13:40, Daniel P. Berrangé wrote:
> On Thu, May 30, 2024 at 01:22:11PM +0100, Mark Cave-Ayland wrote:
>> On 30/05/2024 12:40, BALATON Zoltan wrote:
>>
>>> On Thu, 30 May 2024, Gerd Hoffmann wrote:
>>>> stdvga is the much better option.
>>>>
>>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>>> ---
>>>> hw/display/cirrus_vga.c     | 1 +
>>>> hw/display/cirrus_vga_isa.c | 1 +
>>>> hw/display/Kconfig          | 1 -
>>>> 3 files changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
>>>> index 150883a97166..81421be1f89d 100644
>>>> --- a/hw/display/cirrus_vga.c
>>>> +++ b/hw/display/cirrus_vga.c
>>>> @@ -3007,6 +3007,7 @@ static void cirrus_vga_class_init(ObjectClass
>>>> *klass, void *data)
>>>>      dc->vmsd = &vmstate_pci_cirrus_vga;
>>>>      device_class_set_props(dc, pci_vga_cirrus_properties);
>>>>      dc->hotpluggable = false;
>>>> +    klass->deprecation_note = "use stdvga instead";
>>>> }
>>>>
>>>> static const TypeInfo cirrus_vga_info = {
>>>> diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
>>>> index 84be51670ed8..3abbf4dddd90 100644
>>>> --- a/hw/display/cirrus_vga_isa.c
>>>> +++ b/hw/display/cirrus_vga_isa.c
>>>> @@ -85,6 +85,7 @@ static void isa_cirrus_vga_class_init(ObjectClass
>>>> *klass, void *data)
>>>>      dc->realize = isa_cirrus_vga_realizefn;
>>>>      device_class_set_props(dc, isa_cirrus_vga_properties);
>>>>      set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
>>>> +    klass->deprecation_note = "use stdvga instead";
>>>
>>> Excepr some old OSes work better with this than stdvga so could this be
>>> left and not removed? Does it cause a lot of work to keep this device? I
>>> thought it's stable already and were not many changes for it lately. If
>>> something works why drop it?
>>
>> Seconded: whilst stdvga is preferred, there are a lot of older OSs that work
>> well in QEMU using the Cirrus emulation. I appreciate that the code could do
>> with a bit of work, but is there a more specific reason that it should be
>> deprecated?
> 
> I think there's different answers here for upstream vs downstream.
> 
> Upstream QEMU's scope is to emulate pretty much arbitrary hardware that
> may have existed at any point in time. Emulating Cirrus is very much
> in scope upstream, and even if there are other better VGA devices, that
> doesn't make emulation of Cirrus redundant.
> 
> Downstream is a different matter - if a downstream vendor wants to be
> opinionated and limit the scope of devices they ship to customers, it
> is totally valid to cull Cirrus.

Few years ago I suggested qemu_security_policy_taint() "which allows
unsafe (read "not very maintained") code to 'taint' QEMU security
policy." (Gerd FYI):
https://lore.kernel.org/qemu-devel/20210908232024.2399215-1-philmd@redhat.com/


Upstream we could add a boolean in DeviceClass about device security
status / maintenance (or enum or bitfield); then downstreams could
use it to be sure unsafe devices aren't linked in.


> IOW, I think device deprecation *framework* is relevant to include
> upstream, but most actual usage of it will be downstream.
> 
> Upstream might use *object* deprecation, if we replace an backend
> implementation with a different one.
> 
> With regards,
> Daniel


