Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1C3109C04D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 17:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5SAp-0006sJ-4y; Wed, 25 Mar 2026 13:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5SAn-0006rw-8q
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:37:41 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5SAl-0003o1-KN
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:37:41 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c741db5d610so79490a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774460258; x=1775065058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=F9LWkCOzKUDTGJ3PQHKuY/f1ygEDZFwkagGEOjXIElU=;
 b=hxzFhajmYJh21ljE036d+GnEQTjGEcaJ3SHlR7Pa0qRohQJrob5Os3U6Czk+pCNgd+
 HeGmxfmNa01XpCN9Rjim5GpRl9xoWkxn9zqjD2szZaGV18nOaAeKy/wNPe8H2WMWZjhf
 3jooFluDCPspS8SGEUVKgohQCrCa566SjL3tLCY7c6fbvqUfsWWIfAMpYqqJWGvBJ0+v
 KRech5bXosc+ghSR7n1I+G565nIBOeJc/DvKQMTPmS+fj476jYGj86dcb4hKi4VLJKBr
 BuDdlQR/frkxdZr7BmVeqTxhjf73vZSxdDk02t4k+SMsfrgVYqUUi0hLtbpf72ol92si
 q5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774460258; x=1775065058;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9LWkCOzKUDTGJ3PQHKuY/f1ygEDZFwkagGEOjXIElU=;
 b=OgNax73HdLEezTbCtnGV4/SR483bE9K0gVgR5TLUUQEqAf4zfwwqGsTWkdD62x9+nM
 ehzzf9Tff0fIFYthFrNeAFRlQvnDEgLfIQUCd4w9VqT4vNzz/3J9u1QjPt/jAcYBkdq5
 Ubpvc5qxtK+/Pb0LPF/Jye9wb/ZFJ1otJI2neg/pDVlSHiEpn741UPolgj8Y0zpvCCeW
 Q3sGZSa+2cYQyXWkINvsjB90FA+uIaoo68lh/Q8smcJR8RzcaR1GQZ+vbj8mX8/Xn1SZ
 RC6sVwl/lzajG/nAaxeX9WI7x4UbC3hK83XWovSVyIJEmv5gX6dLYDy1TC4cTSD5lHMw
 z/bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCgznCJ1AvxMDzBToKkHcAOcb59rFR2Ks4Y0mA6SDnQH0Q9MnKZ1Q+p3eWZFOJy6zlO15PzEwEHUt9@nongnu.org
X-Gm-Message-State: AOJu0YzTSNMlEaYFMhgAC8QyYezL5FIQ5Zs7ojTib6tSe+DzzTKrRSBD
 wRSFsWBCH99fQXfEONzdbQ/rS6dD1kmw/xk8YBDlMCnHJ8S9AUFVXJLd8gNFdldoT9k=
X-Gm-Gg: ATEYQzyWBaRcOabq01CebD3yahztuIJn7HO7Ffryr+Ypd0Fop1SbIbE4tIZtblx0+T6
 8pDJqx70ZCZwdRL6xYRVlIiALA1mETxFMvPg+29qvhKF2RTr4TJxvwDYTigrDxHxjPfatZRoZf2
 4r9O+rdIY03T0ZGW02WNl4i6nUU+KxRnoFX2Usy1jJ7vpJDzKfPqbXfs+J68pRw/bDi+V5VpHsk
 Iy2Eb+UPpMXNwPnPP8l0beFHESVde8PHB26whr7TVtihgkc4hImyqT9cPEqq1z/Fo8O6M+wHhfp
 iA1I0Eq7T6KKZNSN5mxULpLEa/Ook3/grqqOgke8aQF0/RYXR34eZq8FnMJeqER0OXiEEwuJwLS
 iRXortFwrya5PJY7yDCKXXh5DyW+T1Re1WTbD2bNKDX2Cxh5Z6A3iRqiMocVaryQvUT03IBfCHs
 hPf5o7rEW+GMskv57EyohJFou37700Hjit4gU7cezxK2TPDdxsiHnomcqmSB34tIoLH0Tp
X-Received: by 2002:a05:6a20:1593:b0:39b:ef0f:a49 with SMTP id
 adf61e73a8af0-39c4ada7ecdmr4821794637.37.1774460257521; 
 Wed, 25 Mar 2026 10:37:37 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d23c7a4sm306962b3a.27.2026.03.25.10.37.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 10:37:37 -0700 (PDT)
Message-ID: <3159e57a-a21f-4fe5-b523-954f13ed97c4@linaro.org>
Date: Wed, 25 Mar 2026 10:37:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 v6 3/6] monitor: Have MonitorDef::get_value()
 always return int64_t type
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
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
 <c0f35257-98ae-4cb8-a73e-2e36bac91a55@linaro.org>
 <871ph8picl.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <871ph8picl.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

On 3/24/26 10:51 PM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 3/24/26 7:42 AM, Markus Armbruster wrote:
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>>> On Tue, 24 Mar 2026 at 12:57, Markus Armbruster <armbru@redhat.com> wrote:
>>>>>
>>>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>>>
>>>>>> Simplify MonitorDef::get_value() handler by having it always
>>>>>> return a int64_t type. Truncate to 32-bit in the single caller.
>>>>>>
>>>>>> Note, this handler is only implemented once for the x86 targets.
>>>>
>>>>>> @@ -78,7 +80,8 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>>>>>>        for(; md->name != NULL; md++) {
>>>>>>            if (hmp_compare_cmd(name, md->name)) {
>>>>>>                if (md->get_value) {
>>>>>> -                *pval = md->get_value(mon, md, md->offset);
>>>>>> +                int64_t val = md->get_value(mon, md, md->offset);
>>>>>> +                *pval = target_long_bits() == 32 ? (int32_t)val : val;
>>>>>
>>>>> This assumes target_long_bits() returns either 32 or 64, doesn't it?
>>>>>
>>>>> Is this true today?
>>>>
>>>> It's certainly true today, and we insist on that: exec/target_long.h
>>>> handles TARGET_LONG_SIZE being 4 or 8 and will #error on anything else.
>>>
>>> Good.
>>>
>>>> What other values do you expect it could have ?
>>>
>>> There might be a need for 128 in the future.  Not an easy change to
>>> make.
>>>
>>
>> The day this will happen, there will be more places to fix than the
>> current patch, as it's assumed everywhere else that target_long_bits or
>> TARGET_LONG_BITS is 32 or 64 only. So I would not worry too much about
>> it at the moment.
> 
> Yes, not an easy change to make.
> 
> I guess my comment came out of a feeling of unease about
> 
>      target_long_bits() == 32 ? [32 bit code] : [64 bit code]
> 
> I feel there's a bit of friction between abstract requirements and the
> concrete software interface.  In the abstract, we need to ask a yes/no
> question here.  The concrete interface provides a function that returns
> 32/64, which works, but isn't obvious from the type.  I guess it's
> obvious enough for anybody working in this area of the code.
> 
> If truncating to the target's actual width is common, consider providing
> function for that.
>

I think the initial reason for this to be written this way was to allow 
arithmetic expressions (and masks) with this value directly, instead of 
having ternary expression everywhere:
TARGET_IS_64_BITS ? _ : _

> Feel free to ignore me :)
> 
> [...]
> 

