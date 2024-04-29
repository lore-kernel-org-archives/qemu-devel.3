Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB7CC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 09:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1NXm-0004re-ID; Mon, 29 Apr 2024 05:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1NXk-0004oK-Vg
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:43:28 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1NXj-000859-6u
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 05:43:28 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-343d7ff2350so3214314f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 02:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714383805; x=1714988605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ixKo5e77KFZthOZGNZHtnMw657Zma4QNzD2BhhdMfGg=;
 b=H7TL7//osITHKZEsnLNUH8IQcIvifgQhkUHQjyvkx7y3qQsMGgoqaigEuqSPTV3hXV
 0cOCA0EHbiaefQEj56wl8xR+2FxajwV+U2CcmDYoNqIAwoVrqInGdDH+yQlKv32M/1Tr
 TWSdCrOL6C3VdeJq+cGFtWIu5qLQ8DbPfZHAmFOcnBLEwGZIPr0Q8dK3dlbh7gH7t3BS
 4rmQYBzdscWSf9hGcdIy0ytCvYM2S1yLiC+HwxzUEKmhta6gBSoZVMak2/ka4Od1wTPa
 +OCiVaAwaS5fDN7nHzgjp0ehGwGjuRAz38RO9egBDtky24Uj5+/wMMOywLDpVgOHcQzq
 skmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714383805; x=1714988605;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ixKo5e77KFZthOZGNZHtnMw657Zma4QNzD2BhhdMfGg=;
 b=r2ISP/FxeBnZrNOscgu2LbG7sPxghSQy4qxIM/AT1BBPBZ/6Wk3MdNK4SwhhIwV+Kc
 VEWAkilC++MkjuahiDiRJnDOi6Q1HoYPV44afGSbr3xTxtzN9C6pl46ca595OwbuSr3h
 DmymlLX+Euio7s74edw/967lwCvAQGgxwMRErU2tss+gp1H38BBXb+kni/Q1OLcb/rso
 5yz1jEndaleDSulFjkwi+MsJv7onJfVJgn2j9VnFpVnCfogcld0aYh9EfDbfnMTtU+NQ
 6ZWWpHnrZPMYH4MsMCuAP6NAC3IiqaC8POhclSbuRuFvOaxM+2cjd49/KY/VptVhbPCZ
 QFaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL0gRR1+FXLWKYpkSryGQ1FlG0euhLmhHV46v7AJ8KyXfBruua7vDJGZ5aETKGmn9Tmngf5+On8ZxabjhD6xhsvNUOdtM=
X-Gm-Message-State: AOJu0YyZwW+VHY6X6cT2KRoVwZUDCCtV0xCNt1weYLEda36xh//2u/4M
 2YKUCNlix6S3tI3d9cfF7Hay6jhR76/TQVpwGB/BnoIJ0Yc1LqceNc9ddC3uyVl/703tJmFPq42
 0nwY=
X-Google-Smtp-Source: AGHT+IGiPe9ThaoCApg2OjXwKhDHtUFp010+TE0Lq4G9hrYCY4yzCNgd/E7I8CSxM2Y1FhrVjzaH7w==
X-Received: by 2002:a5d:5412:0:b0:34c:ff8c:c263 with SMTP id
 g18-20020a5d5412000000b0034cff8cc263mr2438043wrv.59.1714383805468; 
 Mon, 29 Apr 2024 02:43:25 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a5d5084000000b0034c6077c625sm7911623wrt.29.2024.04.29.02.43.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 02:43:24 -0700 (PDT)
Message-ID: <d31decf9-72d2-4515-b4b4-526ab7ddedbf@linaro.org>
Date: Mon, 29 Apr 2024 11:43:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mc146818rtc: add a way to generate RTC interrupts via QMP
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20240425133745.464091-1-d-tatianin@yandex-team.ru>
 <87v844y0ul.fsf@pond.sub.org>
 <11c78645-e87b-4a43-8191-a73540c364a9@linaro.org>
Content-Language: en-US
In-Reply-To: <11c78645-e87b-4a43-8191-a73540c364a9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 26/4/24 11:48, Philippe Mathieu-Daudé wrote:
> Hi Daniil, Markus,
> 
> On 26/4/24 10:39, Markus Armbruster wrote:
>> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>>
>>> This can be used to force-synchronize the time in guest after a long
>>> stop-cont pause, which can be useful for serverless-type workload.
>>>
>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>> ---
>>>   hw/rtc/mc146818rtc.c         | 15 +++++++++++++++
>>>   include/hw/rtc/mc146818rtc.h |  1 +
>>>   qapi/misc-target.json        | 16 ++++++++++++++++
>>>   3 files changed, 32 insertions(+)
>>>
>>> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
>>> index f4c1869232..6980a78d5f 100644
>>> --- a/hw/rtc/mc146818rtc.c
>>> +++ b/hw/rtc/mc146818rtc.c
>>> @@ -116,6 +116,21 @@ void qmp_rtc_reset_reinjection(Error **errp)
>>>       }
>>>   }
>>> +void qmp_rtc_notify(Error **errp)
>>> +{
>>> +    MC146818RtcState *s;
>>> +
>>> +    /*
>>> +     * See:
>>> +     * 
>>> https://www.kernel.org/doc/Documentation/virtual/kvm/timekeeping.txt
>>> +     */
>>> +    QLIST_FOREACH(s, &rtc_devices, link) {
>>> +        s->cmos_data[RTC_REG_B] |= REG_B_UIE;
>>> +        s->cmos_data[RTC_REG_C] |= REG_C_IRQF | REG_C_UF;
>>> +        qemu_irq_raise(s->irq);
>>> +    }
>>> +}
>>> +
>>
>> Note for later: qmp_rtc_notify() works on all realized mc146818rtc
>> devices.  Other kinds of RTC devices are silently ignored.  Just like
>> qmp_rtc_reset_reinjection().
> 
> IMO to avoid any future ambiguity (in heterogeneous machines), this
> command must take a QOM device path (or a list of) and only notify
> those.

If you disagree, at least please rename the command/method using
"broadcast" for trailer.

