Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFA1C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcooT-0005ZL-77; Wed, 21 Feb 2024 10:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rcooR-0005TI-DE
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:47:11 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rcooO-0001Y9-32
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:47:11 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-599f5e71d85so4252125eaf.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 07:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708530426; x=1709135226; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pfv1dZFyfCzFvTo4r/H4ijZvY83rwxX5cvs6EjIVmzY=;
 b=bUwUYisZsC9OZWlkiT4a+AJHdWky2ty0JjMe5npGH602Tax/WupCI/Gdx7He254Zat
 dpGJ+gMtnhzz2aaTLSL6cg2Pr73K22MqLAXvy7m6ii+glY2lsbnAjRJMq3zK2XStINU9
 s2eNAnvzMHfLavTJQFuV/u1UGQzoPuhnAWbchMX5lCQLkjm8P7GI0aDEBPVcyoI61I5r
 avEncVqf7sk197oclL/yzfUrRwEGxp1AYwsFb8h0IruwAXXaDVJAFvyvTrkZmmOcgtfI
 HLBT0DP2a5ceOhYF/vz2n1iKM3tU1UclzbZ95XyNWT71Bmq2eVL9t1e/WhGNcfCRA4M4
 tbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708530426; x=1709135226;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pfv1dZFyfCzFvTo4r/H4ijZvY83rwxX5cvs6EjIVmzY=;
 b=WgUIPa845c1nuTB6hKqMwcNECYSv0T+ClN4lwJMqbO14iV3hbEi+Hn/GycSN4gLjuE
 D3ifoajrYGC/k/1blB66D8vcXcj+9L14z4xUmXMvNa4jLRGsTOlKD3PmP0G1PF7wv/5b
 P7Fy+pfoFPeiNhGbUVYHbyKawHHJy7zBXPn8JhsFVQWUmIfOgPDEggE8SiTQs+7UnyjH
 9l9NsGJsf7vn4XcoZtuD6s6t+/C14QU+twm4zeioyDCYMNSualudiPu4kGD9zj04YaII
 PI5JLeq/K5r12rB7OcJdcBmGKtcLYVM793tnPGCpK9lEnaSlurGg1Rku33BY568BH8GH
 ntxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAWZceMWu8TkBzmC0dB6QdmUGoaMPIQgbAqOO9CC/2yebITHUadfx6DGtlK0c85weAXQL54VjimZwheiYMwuavmEBqCZM=
X-Gm-Message-State: AOJu0YyDwHQ3zI9Alx6jgWa3ZfzrK818G6+TFsgFU2+Kw7HVpFDSAzz1
 f7csnb81TkvFAjmW+OE7a7yCbHedJdcSZxzTmhs2rcPdDaIDnLW3jjDlPrtybGc=
X-Google-Smtp-Source: AGHT+IGTuSVlsC8F7gIex/13YPt6po79ajFJwGQt585GpGEczdKz1eIlPzdgW6EIhwqBG7x5uHkDig==
X-Received: by 2002:a05:6358:786:b0:176:5cad:a2e1 with SMTP id
 n6-20020a056358078600b001765cada2e1mr21794821rwj.26.1708530425734; 
 Wed, 21 Feb 2024 07:47:05 -0800 (PST)
Received: from ?IPv6:2804:7f0:b400:285a:db64:c298:9515:1427?
 ([2804:7f0:b400:285a:db64:c298:9515:1427])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a63350d000000b005e17cad83absm6965186pga.74.2024.02.21.07.47.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 07:47:05 -0800 (PST)
Subject: Re: [PATCH] test/qtest: Add an API function to capture IRQ toggling
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com
References: <20231112013801.293970-1-gustavo.romero@linaro.org>
 <ddb3f1c5-28d1-472d-b491-703a3e1c6711@redhat.com>
 <d79587a5-ae52-4832-9859-aad3e8b7182d@linaro.org>
 <048454b2-86c3-4bda-5197-bfe44e864586@linaro.org>
 <2ebd589c-f25c-4751-823c-10d7ddcb2a02@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <ac89c47f-4956-0bca-cdca-5ae492cf0215@linaro.org>
Date: Wed, 21 Feb 2024 12:47:01 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2ebd589c-f25c-4751-823c-10d7ddcb2a02@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.297,
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

Hi Phil,

Apologies, I missed this and I just found it when preparing
now the v3 for ivshmem-flat.


On 12/13/23 6:15 AM, Philippe Mathieu-Daudé wrote:
> On 13/11/23 18:33, Gustavo Romero wrote:
>>>>> Currently the QTest API does not provide a function to allow capturing
>>>>> when an IRQ line is toggled (raised then lowered). Functions like
>>>>> qtest_get_irq() read the current state of the intercepted IRQ lines,
>>>>> which is already low when the function is called, since the line is
>>>>> toggled.
>>>>>
>>>>> This commit introduces a new function, qtest_get_irq_trigger_counter(),
>>>>> which returns the number of times a given intercepted IRQ line was
>>>>> triggered (raised), hence allowing to capture when an IRQ line was
>>>>> toggled.
>>>>>
>>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>>> ---
>>>>>   tests/qtest/libqtest.c | 12 ++++++++++++
>>>>>   tests/qtest/libqtest.h |  9 +++++++++
>>>>>   2 files changed, 21 insertions(+)
>>>>>
>>>>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>>>>> index f33a210861..21891b52f1 100644
>>>>> --- a/tests/qtest/libqtest.c
>>>>> +++ b/tests/qtest/libqtest.c
>>>>> @@ -82,6 +82,7 @@ struct QTestState
>>>>>       int expected_status;
>>>>>       bool big_endian;
>>>>>       bool irq_level[MAX_IRQ];
>>>>> +    uint64_t irq_trigger_counter[MAX_IRQ];
>>>>>       GString *rx;
>>>>>       QTestTransportOps ops;
>>>>>       GList *pending_events;
>>>>> @@ -498,6 +499,7 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
>>>>>       s->rx = g_string_new("");
>>>>>       for (i = 0; i < MAX_IRQ; i++) {
>>>>>           s->irq_level[i] = false;
>>>>> +        s->irq_trigger_counter[i] = 0;
>>>>>       }
>>>>>       /*
>>>>> @@ -690,6 +692,7 @@ redo:
>>>>>           if (strcmp(words[1], "raise") == 0) {
>>>>>               s->irq_level[irq] = true;
>>>>> +            s->irq_trigger_counter[irq]++;
>>>
>>> This is 'irq_raised_counter',
>>>
>>>> Not sure whether you can get some "raise" events in a row without some "lower" events in between ... but just in case, I wonder whether it would make sense to check whether it is really a rising edge, i.e.:
>>>>
>>>>             if (strcmp(words[1], "raise") == 0) {
>>>>                 if (!s->irq_level[irq]) {
>>>>                     s->irq_trigger_counter[irq]++;
>>>>                 }
>>>>                 s->irq_level[irq] = true;
>>>>
>>>> What do you think?
>>>
>>> This is 'irq_pulsed_counter'. 'irq_lowered_counter' could also be
>>> useful (at least for completeness).
>>
>> I understand that the code provided by Thomas actually has the exactly same
>> effect as my code. This happens because a "raise" (or "low) message is
>> not sent by the "server" side unless a transition state low -> high happens,
>> so the check 'if (!s->irq_level[irq]) { ... }' is always true. So it's still
>> capturing the raising state transition (as a side note, when one intercepts
>> an IRQ the current state of the IRQ line is saved -- so the old IRQ state is
>> always valid). Therefore, also as a consequence, like Thomas said, it's not
>> possible to get a 'raise' event in a row without a 'lower' event in between.
>>
>> Based on your comments, I gave a second thought on 'trigger' meaning. I think
>> 'trigger' refers to an event or action that automatically initiates a
>> procedure. Since raising an IRQ line does not always mean to generate an IRQ,
>> since the like can be active low in a device, maybe I should avoid using
>> trigger and synonymous for raising.
>>
>> I think since 'toggle' means to switch back and forth between two modes or
>> states, yep, it seems ok to me to use it as a synonymous for 'pulse'.
> 
> One definition of "to toggle" is:
> '''
> switch from one effect, feature, or state to another by using a toggle.
> '''
> 
> "pulsate":
> '''
> expand and contract with strong regular movements.
> '''
> 
> Maybe 'pulse' is simpler to understand?

I prefer 'toggle' (as you suggested initially). However, for v2,
I didn't add an API function to detect a pulse/trigger/toggle.
Instead, for v2, there are only qtest_get_irq_raised_counter() and
qtest_get_irq_lowered_counter(), as you suggested. The user can
then use these functions to create such a detector:

https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg03176.html

... as we do in the ivshmem-flat qtest (test_ivshmem_flat_irq_positive_pulse).

If you're ok with v2, could you please bless it? :)


> 
>> Hence, I removed the word 'trigger' from the API function name and elsewhere.
>>
>> Right, I think having a qtest_get_irq_lowered_counter() is better and also,
>> when used together with qtest_get_irq_raised_counter(), it's possible for a
>> test to check pulses on the IRQ lines.
>>
>>
>>> Per Gustavo's description, he indeed wants irq_pulsed_counter (or
>>> irq_toggled_counter'.
>>>
>>
>> That's a good point. So far I was testing just the high -> low transition,
>> but in fact the most correct way to test the device is also check for
>> a high -> low transition (so, yeah, indeed test a pulse).
>>
>> In the device I have:
>>
>> [...]
>>      /*
>>       * Toggle device's output line, which is connected to interrupt controller,
>>       * generating an interrupt request to the CPU.
>>       */
>>      qemu_set_irq(s->irq, true);
>>      qemu_set_irq(s->irq, false);
> 
> This is qemu_irq_pulse() from include/hw/irq.h.

oh! cool, totally missed that. I'm using it for the ivshmem-flat v3 series!


> 
>> }
>>
>> Thus having both qtest_get_irq_{lowered,raised}_counter() allows capturing
>> an IRQ toggle, for instance, as the following, where exactly 1 pulse is tested:
>>
>>      uint64_t num_raises;
>>      uint64_t num_lows;
>>
>>      while (1) {
>>          if ((num_raises = qtest_get_irq_raised_counter(qts, 0))) {
>>              num_lows = qtest_get_irq_lowered_counter(qts, 0);
>>              if (num_raises == num_lows && num_lows == 1) {
>>                  printf("Detected correct number of pulses.\n");
>>                  return 0;
>>              } else {
>>                  printf("Detected incorrect number of pulses.\n");
>>                  return 1;
>>              }
>>          }
>>      }
>>
>>>>
>>>>>           } else {
>>>>>               s->irq_level[irq] = false;
>>>>>           }
>>>>
>>>> Anyway:
>>>> Acked-by: Thomas Huth <thuth@redhat.com>
>> I'm sending a v2 with qtest_get_irq_lowered_counter().
>>
>> Thanks!
>>
>>
>> Cheers,
>> Gustavo
> 

