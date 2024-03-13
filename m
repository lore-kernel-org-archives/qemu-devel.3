Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB894C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWKt-0003MT-2r; Wed, 13 Mar 2024 17:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWKr-0003M5-Kb
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:40:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWKq-0000zc-0D
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:40:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-413ef82038eso1739525e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710366026; x=1710970826; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tYgcinaA7vaMv4T5/owPLAAkeG3/sKMeNrNbb57/8xE=;
 b=gG0gRe1doaeIbKIilKd6tkPLCulGvogSPOHK13f059O1BwMMQXmvSiLou08ZZRfRFN
 Xetr/c+tHTSZkbolBTvWHmjl8IBhG6ULoRSfMju6+VctXcPXw8PmtrKCyoOsIVJhpsWD
 PpGJ1ogltKKJcFcu/Uq6sZ2MfNKkZDTtcy9k4v2a+GSYVQGcHPTs+xG91fW88sGohG/0
 qwHD9taNjq5QSP4AXM80EL9Ve6j6dpNGJO63uxZ637E9z1T3Yc6fP7v0Eq5gb4DGUqzw
 XWdroF/9lBcioD63djH6Jh9rOyQltezwddk0G/vYHD3rUdtqbWK7feBDOyq/t3FGrku7
 tVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710366026; x=1710970826;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tYgcinaA7vaMv4T5/owPLAAkeG3/sKMeNrNbb57/8xE=;
 b=tis4xfobVdoPJAQ5LLJmA3PCZ9HPZl0w1Uka2mN+9EB3TiUbFzWzBwe8oMKLikbJNu
 SJC4LJIqWIshUBzhVORYN8G6O0/pKxfNvKV5Ds6Px0Rk27PjL6giKayKFXYdJpQ2lnKr
 Ll4Vj4liNG9UI+qQIW9/aIU1qtIZsnqlNbTq5HiDSZ+F7Qjp3DJsBexLcmq9davncEIL
 0NWx55ZqfnS0sQTEOZJS5pHQLgC08G7Nvo5RWz7sF0dEDQU8JAQMlPFrX/RhQdanP7pz
 +51abPynTzrBC4ChGT8+PXivvwdC/QuG7TSlU7PYJLzfe67uqTOJn7m2/kQTimNoxGRG
 4t1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7qEseCvPdvauUfRV6jJCh/7ckcvWyDetbumeVND3D38LjgkbPNH0wBFeIUEMOLV2SYUH8IUulPzlhgLIEiTenU+H26Rk=
X-Gm-Message-State: AOJu0YwHM3jRjpDk3WQ7r3joCRxAFTmxopi/fPZn1udr77a2hCwonbnf
 FizY2LP+n4/u9GObF40Kd9ieV0iAA33KB2lYy+MKgtyj6smtZGrP0maX2OoLIWPGMmzTDnGyJ6t
 k
X-Google-Smtp-Source: AGHT+IFGfO5gHri0xhXGi22JEQak7jt+FZW8je/LMN9q6dtdaTLnMYbB6hUPSJ7EDMdUtSlQZR5+Gg==
X-Received: by 2002:a05:600c:5124:b0:412:ebde:8873 with SMTP id
 o36-20020a05600c512400b00412ebde8873mr31863wms.30.1710366026333; 
 Wed, 13 Mar 2024 14:40:26 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a05600c458800b00413e8df267bsm276831wmo.48.2024.03.13.14.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 14:40:25 -0700 (PDT)
Message-ID: <ceca4488-a8ab-4dad-b54a-9059f982ce19@linaro.org>
Date: Wed, 13 Mar 2024 22:40:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] esp.c: replace cmdfifo use of esp_fifo_pop_buf()
 in do_command_phase()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-2-mark.cave-ayland@ilande.co.uk>
 <c0a5a1cc-a6bb-4856-a708-d19195aacb9f@linaro.org>
 <bcd010a7-c09c-483c-9ebb-0e75be578545@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bcd010a7-c09c-483c-9ebb-0e75be578545@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 13/3/24 22:08, Mark Cave-Ayland wrote:
> On 13/03/2024 11:03, Philippe Mathieu-Daudé wrote:
> 
>> On 13/3/24 09:57, Mark Cave-Ayland wrote:
>>> The aim is to restrict the esp_fifo_*() functions so that they only 
>>> operate on
>>> the hardware FIFO. When reading from cmdfifo in do_command_phase() 
>>> use the
>>> underlying Fifo8 functions directly.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>   hw/scsi/esp.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>>> index 590ff99744..f8230c74b3 100644
>>> --- a/hw/scsi/esp.c
>>> +++ b/hw/scsi/esp.c
>>> @@ -265,7 +265,7 @@ static void esp_do_nodma(ESPState *s);
>>>   static void do_command_phase(ESPState *s)
>>>   {
>>> -    uint32_t cmdlen;
>>> +    uint32_t cmdlen, n;
>>>       int32_t datalen;
>>>       SCSIDevice *current_lun;
>>>       uint8_t buf[ESP_CMDFIFO_SZ];
>>> @@ -275,7 +275,7 @@ static void do_command_phase(ESPState *s)
>>>       if (!cmdlen || !s->current_dev) {
>>>           return;
>>>       }
>>> -    esp_fifo_pop_buf(&s->cmdfifo, buf, cmdlen);
>>> +    memcpy(buf, fifo8_pop_buf(&s->cmdfifo, cmdlen, &n), cmdlen);
>>
>> 'n' is unused, use NULL?
> 
> I was sure I had tried that before and it had failed, but I see that you 
> made it work with NULL in commit cd04033dbe ("util/fifo8: Allow 
> fifo8_pop_buf() to not populate popped length") - thanks!

Ah!

So using NULL in patches 1 and 2:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> I'll make the change for v3, but I'll wait a couple of days first to see 
> if there are any further comments, in particular R-B tags for patches 10 
> and 11.

I still have them in my TOREVIEW queue and need to digest them.

> 
>>>       current_lun = scsi_device_find(&s->bus, 0, s->current_dev->id, 
>>> s->lun);
>>>       if (!current_lun) {
> 
> 
> ATB,
> 
> Mark.
> 


