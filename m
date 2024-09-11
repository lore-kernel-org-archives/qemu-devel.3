Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C493EE01F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 05:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soGHA-0007Xr-42; Wed, 11 Sep 2024 01:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soGH8-0007Rt-Gi
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:52:22 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soGH6-0006Pk-Tn
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:52:22 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c3cdbe4728so6533286a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 22:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726033939; x=1726638739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3r6mSXGLBbRapn0yIBRKRM9UfT3yGLKlP3O/6Mg/4iE=;
 b=ImMyogCDKEULihDYu8QsdZ1UVsDPk6eoHJd+Yez2u9B9NT6FssQFqR+s+23mQTruHE
 fQQD5bpVRKrExiNyded82yKsIVxCuWubGVludfTPdgohfgdSYnLg8oS4ppnZiFxJoh63
 tT7M8Ci5g0ILXog3is2jd5EjpdhrSVMr/AmhaRnEyeTQrx6SHN1he7NgO8LBD2lqqMNG
 KhsubzMWhXGxROZfRbexuPqaHJi3nn0Dd2JGs+XIR16+hSAxf2rh9Rg/ELD/M4Z9cO7c
 YI/wiIDgBtMh3IAfpi6RZRUAnn+WALKHm1/Edx66ABDI7pSfvApKyRQpp4/CSjH2pB10
 kCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726033939; x=1726638739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3r6mSXGLBbRapn0yIBRKRM9UfT3yGLKlP3O/6Mg/4iE=;
 b=fH5AWe/ibvSs73Kte9QyxWYKlzWBzW5rByzgUm3HBQay09wL14ZH+kuRIvcL5VU2ZD
 1+Vt6j2ZUt2nVb1FcSUHxthVIMrrXhMkqSukqFJ2UISN77/S6+hNRg+WPv37e5wZpAs/
 GNWVwKdVZuc1eOsdvPmm7M/QiqmBu4Z7tAaLqHvKtgB63x1eSeMG73ERTaF5uSUUm8h5
 Zm5RaKinWJb+d/NknT774e5WhqjJUPOBjnowWUP5hTQN02YPu4WZ3glSReu6sd2F5HAO
 6qDtiW4HKeEIDzO4GuAOCuOg1t8CCZYZp7CTxSzWVsQvpFlabe84SbALUf22twSyEWwY
 VzOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdBE6VONsKPHXlFULpRtRWJgme4tRqqeL3jPHEMT/82r5PkoOBF/6OGCPbvqMhvcYYiURsLFwbrGD5@nongnu.org
X-Gm-Message-State: AOJu0YxwCbrw0uX7tuOln92+SCzksI8Htb9fGH1ol86QV8ZHzYRm+sJ1
 ZDOoj586boy2C2EXkhbhAwKvqYf+AkV+uyY3cbRX9c7K10jUD/UZuY4EZEddLtY=
X-Google-Smtp-Source: AGHT+IH+dwUhChWSNrsblya0tptazg0YeYH3thG0MdJGrWDu8vCXEta/+B1wIIbhRgXP8V7aCpIvxw==
X-Received: by 2002:a17:907:3d8a:b0:a88:b90a:ff30 with SMTP id
 a640c23a62f3a-a8ffad98911mr290199566b.50.1726033939167; 
 Tue, 10 Sep 2024 22:52:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2583fc73sm568014566b.34.2024.09.10.22.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 22:52:18 -0700 (PDT)
Message-ID: <f0442712-8e4e-4790-94b5-458b67fda15a@linaro.org>
Date: Wed, 11 Sep 2024 07:52:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] adb-mouse: convert to use QemuInputHandler
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, hsp.cat7@gmail.com
References: <20240907173700.348818-1-mark.cave-ayland@ilande.co.uk>
 <970cfa94-c8e8-4fa5-96a7-45b964e4bef3@linaro.org>
 <5a28f05c-c90c-419e-9d23-8c3a3e6fcf72@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5a28f05c-c90c-419e-9d23-8c3a3e6fcf72@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 10/9/24 22:36, Mark Cave-Ayland wrote:
> On 10/09/2024 15:48, Philippe Mathieu-Daudé wrote:
> 
>> Hi Mark,
>>
>> On 7/9/24 19:37, Mark Cave-Ayland wrote:
>>> Update the ADB mouse implementation to use QemuInputHandler instead 
>>> of the
>>> legacy qemu_add_mouse_event_handler() function.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>   hw/input/adb-mouse.c | 56 ++++++++++++++++++++++++++++++++++++--------
>>>   1 file changed, 46 insertions(+), 10 deletions(-)
>>>
>>> v2:
>>> - Rebase onto master
>>>
>>> - Replace (DeviceState *)s with dev in adb_mouse_realize() as 
>>> suggested by
>>>    Phil
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>>> +static const QemuInputHandler adb_mouse_handler = {
>>> +    .name  = "QEMU ADB Mouse",
>>> +    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
>>> +    .event = adb_mouse_handle_event,
>>> +};
>>
>> Do you mind if you amend your comment from v1 for clarity?
>> I could squash the following and take in my next PR:
>>
>> diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
>> index c0e0282fee..15e6e91804 100644
>> --- a/hw/input/adb-mouse.c
>> +++ b/hw/input/adb-mouse.c
>> @@ -97,6 +97,11 @@ static const QemuInputHandler adb_mouse_handler = {
>>       .name  = "QEMU ADB Mouse",
>>       .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
>>       .event = adb_mouse_handle_event,
>> +    /*
>> +     * We do not need the .sync handler because unlike e.g. PS/2 
>> where async
>> +     * mouse events are sent over the serial port, an ADB mouse is 
>> constantly
>> +     * polled by the host via the adb_mouse_poll() callback.
>> +     */
>>   };
>>
>> Regards,
>>
>> Phil.
> 
> Sure! If you think it is useful to an external set of eyes, then feel 
> free to add it in.

Thanks, patch queued then.


