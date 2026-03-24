Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A65FEC0F1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 18:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w56aT-0006kE-GG; Tue, 24 Mar 2026 14:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w56aR-0006k1-9e
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:34:43 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w56aP-0002gX-Ih
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:34:42 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82a7539851fso2297504b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774377280; x=1774982080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HYCDysaSAZsmu6TFqlIx8x4TUGbFpnbrWy1nF0owSyA=;
 b=sKHk1xWtI4ya8pH7z9znYMH2I0n6Mtrc87pjTlXyeXSCYsZXKO7j8uXcTnGiZl1SZi
 0T1IvTc9VWVyHBlqq5174Ud1zzljZJ2YE8A5uHGAARQVVx16fhwpWSXcjMrAn5OwyWjF
 ndPuQDYwCUkyXK4+mve2ZcZIO8UDO+oUXEm/ODjyBrN86XA+lydoXEH4ggDVJfTFY8dA
 hSKoHQZxSpmnQ2optZ+7N1JVo4qohNe7ZuuPGPIvvoKMdXJZpTHAXvxBPaqufkkmnpYZ
 JPjUCyB9d65QYwBTENAcWuCaeHOqUT9NPELO3m98c18cM8cIhDIXcEo2wZGxv3LOXEM0
 y5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774377280; x=1774982080;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HYCDysaSAZsmu6TFqlIx8x4TUGbFpnbrWy1nF0owSyA=;
 b=Ymr6U8SWFd0n1V3pKoEg3SSxyXqYHju9+wR+3wcu7MUEji3tuNw6xoxT3curIH6Qci
 8M51siFrv55Tdht3kCTWK1V0SfIIOAg8m31vr1khf0HBwVHJQTqoq/XT2bDvJPl+0frm
 y7A3Y1EOxyFVYjocWDiko06oo8VLGMLAMH6wVSCo6lw+afku+A7WDDK3bVUdFZXowQw6
 Vyk2Ii0ghvS+iCfffAXId4ydKqqUYBMiFdfI/IaNTX9CAfPnRWzc8YX4BATGbAE+z6GX
 82HdSwrIaGoGb11HafTBNf/Zmj1FGswiT//gYsWUab6R7eZz07dcgLycRMlzoJ4dNOwB
 RTCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPXbyZSSNPusT9zBp0vNfK1lvrrjPl4g+yjACxy9AgEBixcprEk7P80+R6IuqD9P3utaaQbeDzOw34@nongnu.org
X-Gm-Message-State: AOJu0YxyygX1gnllUqDUvmq85qPOjPd5JvcJT7RyCFz308O9g1I9Y1zs
 N4M8g6IGlRwVz9SU75tDpgCyH7COErWGiymj6uDvAQpLQv0P+Vrfp9OqOlYP9ilgmsk+Zf/q1hm
 vQo+3BRs=
X-Gm-Gg: ATEYQzy4Pc9T+RSS7k7GQ09/3IZSzdVokfP65o7U9uIW2jx4mgDlrpLWaTcy1g5wGB0
 mepcEXx5HcMSv4qJuISuGfNdPTLGIDuBXhb/0GiYM1VPBsu5pXo6EJhiemqvnoFoFcMLNvo+uX7
 vPMnCbd4K+0dW5tmCvooIRNhq3QrEyOODfUgOX/5sLVF9IrqWtB3A77gKJ9yKGZbV8gR4F88thL
 TfwyKH1x25pNZSnQ6ced/mbvUfPJldR1dGbeXCmGwoGy1VLb2OYPpn4Lgx418Y8RmcpaqscF3gq
 SEjC2Y98AXiw6yCjDPxYA16e2rfe4Ia96zeQsxOs3Uwh8j5K2eg4fYPAOW54C/NGUFsqDE7XwSW
 jOdm9SPVVIZgk6r0LvRJfJum1wtOyAjvi8WPAf6QqsV8tWW+pgf6Qy+epchDY1QcxmGjGbZHaw0
 cFSP6X4ManQZKr1zoBvssDUTnO77NlvgixY/Uwaq1Fmrs8sW496RUrgiC21K7trNw5MIPt
X-Received: by 2002:a05:6a00:3d4b:b0:829:809e:8977 with SMTP id
 d2e1a72fcca58-82c6e0d4346mr589359b3a.49.1774377279887; 
 Tue, 24 Mar 2026 11:34:39 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b03bbf0c2sm15572088b3a.15.2026.03.24.11.34.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 11:34:39 -0700 (PDT)
Message-ID: <c0f35257-98ae-4cb8-a73e-2e36bac91a55@linaro.org>
Date: Tue, 24 Mar 2026 11:34:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 v6 3/6] monitor: Have MonitorDef::get_value()
 always return int64_t type
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260320091019.59902-1-philmd@linaro.org>
 <20260320091019.59902-4-philmd@linaro.org> <87pl4ts7vx.fsf@pond.sub.org>
 <CAFEAcA_y5amOwF-HCM8L3xc1_bSbXxno+HjrLBiOaN25fCt4eA@mail.gmail.com>
 <87tsu5qofj.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <87tsu5qofj.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/24/26 7:42 AM, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Tue, 24 Mar 2026 at 12:57, Markus Armbruster <armbru@redhat.com> wrote:
>>>
>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>
>>>> Simplify MonitorDef::get_value() handler by having it always
>>>> return a int64_t type. Truncate to 32-bit in the single caller.
>>>>
>>>> Note, this handler is only implemented once for the x86 targets.
>>
>>>> @@ -78,7 +80,8 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>>>>       for(; md->name != NULL; md++) {
>>>>           if (hmp_compare_cmd(name, md->name)) {
>>>>               if (md->get_value) {
>>>> -                *pval = md->get_value(mon, md, md->offset);
>>>> +                int64_t val = md->get_value(mon, md, md->offset);
>>>> +                *pval = target_long_bits() == 32 ? (int32_t)val : val;
>>>
>>> This assumes target_long_bits() returns either 32 or 64, doesn't it?
>>>
>>> Is this true today?
>>
>> It's certainly true today, and we insist on that: exec/target_long.h
>> handles TARGET_LONG_SIZE being 4 or 8 and will #error on anything else.
> 
> Good.
> 
>> What other values do you expect it could have ?
> 
> There might be a need for 128 in the future.  Not an easy change to
> make.
>

The day this will happen, there will be more places to fix than the 
current patch, as it's assumed everywhere else that target_long_bits or 
TARGET_LONG_BITS is 32 or 64 only. So I would not worry too much about 
it at the moment.

>>> Will it remain true?
>>>
>>> Could we use something like
>>>
>>>      val & ((1 << target_long_bits()) - 1)
>>>
>>> to truncate to target_long_bits() bits?
>>
>> This is UB for the case where target_long_bits returns 64,
>> and isn't what the code currently does because it zero
>> extends rather than sign extending.
> 
> I signalled my cavalier neglect for these details by writing "something
> like" ;)
> 
>> If we wanted to programmatically sign extend from
>> target_long_bits() to the int64_t, that would be
>>
>>   *pval = sextract64(val, 0, target_long_bits());
>>
>> (Whether sign extension is what we actually want for your
>> average register is questionable, but it's what the code
>> does now both for the get_value functions and also for the
>> generic cases handled by the switch on md->type.)
>>
>> Incidentally, we currently behave differently here for
>> qemu-system-i386 and qemu-system-x86_64:
>>
>> $ ./build/all/qemu-system-x86_64 -S -monitor stdio -display none
>> QEMU 10.2.50 monitor - type 'help' for more information
>> (qemu) print $pc
>> 0xfffffff0
>> (qemu) q
>> $ ./build/all/qemu-system-i386 -S -monitor stdio -display none
>> QEMU 10.2.50 monitor - type 'help' for more information
>> (qemu) print $pc
>> 0xfffffffffffffff0
>>
>> For qemu-system-x86_64 we have a 64-bit target_long, so
>> the unsigned addition of env->eip and env->segs[R_CS].base
>> in monitor_get_pc() is done at 64 bits, and that width is
>> then carried through get_monitor_def() and to the caller.
>> For qemu-system-i386 we have a 32-bit target_long, so
>> we do an unsigned 32-bit addition in monitor_get_pc(),
>> return a signed 32-bit result, and then sign extend that
>> to 64 bits in get_monitor_def().
> 
> I'm carefully retracing my steps out of this swamp.
> 
> Thanks!
> 


