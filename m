Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063C3C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 06:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td1Uc-0004bB-67; Wed, 29 Jan 2025 01:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1td1UW-0004aw-Ef
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 01:24:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1td1UU-0004z0-Hg
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 01:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738131835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JaowsIHSZSb/9ERDDcjIqJqDjBZFMnMlyGplgNHNyuE=;
 b=ixSPzvNK/lwriutEGwsq5N/2NTD93rJ4fHUVfbmZnq70pH2U7K7F206yUoqadczlLaVgMH
 wPLvGh8H/MujDkK5l14Vw/BJICvutb1m4ASBRcM6mncxbNrAbCFwPZO3Wno3xWlXBxYo3h
 qF7o3EiDAdbdqnh+1eeLWgnnQYOqR/k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-rnUhAezAOzSpCkt15yZ2Sw-1; Wed, 29 Jan 2025 01:23:52 -0500
X-MC-Unique: rnUhAezAOzSpCkt15yZ2Sw-1
X-Mimecast-MFC-AGG-ID: rnUhAezAOzSpCkt15yZ2Sw
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5d3d9d6293fso6052056a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 22:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738131832; x=1738736632;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JaowsIHSZSb/9ERDDcjIqJqDjBZFMnMlyGplgNHNyuE=;
 b=JgL9pP3yywPpbozTMSt7x7/wAD+etvI9OnFULVBxegBL1EccR97xVfjNDgxLQ4bdLI
 mexP4kBCleHwCSoJCofRnNNEKns12DIuBXhXU+c0eLd8yHd8KIj1PsEOzs1SmpEn5Awd
 waKIM8qT9qfFMQtwut4FTqyyTcFYKX/D/Ro+iFNDPlLnq50zDwdQE6VuZYz2q96d5eZY
 d9HtkAXNiSH7nHDDGRySrWhNESPN9V553WS7pHLCQ8nxsY/F3zN9r1DjAxFRb9upiEGG
 eOCwRYxRusA1elZmkspbAWTMpm+Qcd1a0UMVc+mcl0Ege6tpo3N+P8ztBndqpgQcjaaO
 PSsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViF+wSLykx2Z5ZXTAYEn0vAlJbzveJ9hQJqdMgAm1YSXTpzpCpi1TKS1uVIWBgg+VpooilhYAiIXnd@nongnu.org
X-Gm-Message-State: AOJu0Ywz5WZQ68ncZhjCqvV96WJ6kBW5ytKRTvzGLE60cn5Lp6I/KqYc
 F9OlSHt/MZoVZPnyZvilqOW9V1WoCPut7b7Y0j2VyUopJH31SB5+WbJsv1rtUEcyjQwanRfk3Zp
 MHE64BIPSdsjyI/WcD/VIngIytkBZGTQLE1vFVc/dl94FbEnyH+sh
X-Gm-Gg: ASbGncuGRRe4slfWwVVLqGXgMoNApgtnxeGnSlnrJ2Posohu8wdwKA098hBUfGcuWpe
 TOL/rS1Nt2BEQ1UF/c4w0Z+03A5lqzBJ1s18WyzYFNsJXqbW8c5ux96tZQ1kxwVjyfXfjr2Pz5t
 M9YmCoBYLNZWcRKbCAjcEVVBU/65+v18BmC1U8SoZaqfzf6U8T063JRhhQXVc+LwBhKTc2iOS5b
 espytJZ7qJWlm19/gg87oaJHwvlHXJYA24ydYHLviubvQfuyteC9ZJXGWSCVlBWQxMlIgUZ0feh
 iGA4js29ruEKquYIxQUsaEigFAHNHnogR4zR
X-Received: by 2002:a05:6402:270b:b0:5dc:584e:853d with SMTP id
 4fb4d7f45d1cf-5dc5efec314mr1263939a12.25.1738131831640; 
 Tue, 28 Jan 2025 22:23:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA/QISZ6MKhuUYhO1TP9YHYZBHhV9igTo/D2c0JyqzLHVPCgtB2GNLSx9AzO8Qnv2INAbxag==
X-Received: by 2002:a05:6402:270b:b0:5dc:584e:853d with SMTP id
 4fb4d7f45d1cf-5dc5efec314mr1263926a12.25.1738131831165; 
 Tue, 28 Jan 2025 22:23:51 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc186d8a27sm8013842a12.73.2025.01.28.22.23.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 22:23:49 -0800 (PST)
Message-ID: <c13e207e-06a5-4f40-b319-f4f2e59d919a@redhat.com>
Date: Wed, 29 Jan 2025 07:23:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] meson: Deprecate 32-bit host systems
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, stefanha@redhat.com, pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk, Liviu Ionescu <ilg@livius.net>
References: <20250128004254.33442-1-richard.henderson@linaro.org>
 <9a280789-9248-4eca-b50c-048fc58e3f53@redhat.com>
 <87plk72tvr.fsf@draig.linaro.org>
 <ad6ca73a-c38a-4a9b-bdcb-ab50aa53ccd1@linaro.org>
 <Z5ii-ueFt5-5Brxz@redhat.com>
 <8c0eea44-d0bf-4b86-9b1b-1c2082ab2df9@linaro.org>
 <9bf6d4b0-7a89-4110-a1e1-46bbdb2fc793@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <9bf6d4b0-7a89-4110-a1e1-46bbdb2fc793@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 28/01/2025 11.02, Philippe Mathieu-Daudé wrote:
> On 28/1/25 11:01, Philippe Mathieu-Daudé wrote:
>> On 28/1/25 10:27, Daniel P. Berrangé wrote:
>>> On Tue, Jan 28, 2025 at 10:17:33AM +0100, Philippe Mathieu-Daudé wrote:
>>>> On 28/1/25 10:02, Alex Bennée wrote:
>>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>>
>>>>>> On 28/01/2025 01.42, Richard Henderson wrote:
>>>>>>> Time for our biennial attempt to kill ancient hosts.
>>>>>>> I've been re-working the tcg code generator a bit over the holidays.
>>>>>>> One place that screams for a bit of cleanup is with 64-bit guest
>>>>>>> addresses on 32-bit hosts.  Of course the best "cleanup" is to not
>>>>>>> have to handle such silliness at all.
>>>>>>> Two years after Thomas' last attempt,
>>>>>>>      https://lore.kernel.org/qemu-devel/20230130114428.1297295-1- 
>>>>>>> thuth@redhat.com/
>>>>>>> which resulted only in deprecation of i686 host for system
>>>>>>> emulation.
>>>>>>> By itself, this just isn't enough for large-scale cleanups.
>>>>>>> I'll note that we've separately deprecated mips32, set to expire
>>>>>>> with the end of Debian bookworm, set to enter LTS in June 2026.
>>>>>>> I'll note that there is *already* no Debian support for ppc32,
>>>>>>> and that I am currently unable to cross-compile that host at all.
>>>>>>
>>>>>> IIRC the biggest pushback that I got two years ago was with regards to
>>>>>> 32-bit arm: The recommended version of Raspberry Pi OS is still
>>>>>> 32-bit:
>>>>>>
>>>>>>    https://lore.kernel.org/qemu-devel/ 
>>>>>> F852C238-77B8-4E24-9494-8D060EB78F9F@livius.net/
>>>>>>
>>>>>> And looking at https://www.raspberrypi.com/software/operating-systems/
>>>>>> this still seems to be the case...
>>>>>>
>>>>>> So I guess the main question is now: Would it be ok to kill support
>>>>>> for 32-bit Raspberry Pi OS nowadays?
>>>>>
>>>>> I would argue yes for a few reasons.
>>>>>
>>>>>     - you can't buy 32 bit only Pi's AFAICT, even the Pi Zero 2W can work
>>>>>       with a 64 bit OS.
>>>>>
>>>>>     - It's not like the versions shipping in bullseye and bookworm will
>>>>>       stop working.
>>>>>
>>>>>     - Even if we deprecate now there will likely be one more Debian
>>>>>       release cycle that gets 32 bit host support.
>>>>>
>>>>>>> Showing my hand a bit, I am willing to limit deprecation to
>>>>>>> 64-bit guests on 32-bit hosts.  But I'd prefer to go the whole hog:
>>>>>>> unconditional support for TCG_TYPE_I64 would remove a *lot* of
>>>>>>> 32-bit fallback code.
>>>>>
>>>>> I support going the whole hog. I would be curious what use cases still
>>>>> exist for an up to date 32-on-32 QEMU based emulation?
>>>>
>>>> Current maintainers don't have spare time to support the 32-on-32
>>>> emulation. If there is interest in the community for such niche,
>>>> someone needs to step forward, willing to maintain it.
>>>
>>> I'm not sure that's the case here.
>>>
>>> 32-on-32 is already effectively unmaintained, so we're not suffering
>>> in terms of keeping the 32-on-32 code reliable.
>>>
>>> We're suffering from the complexity that 32-on-32 code places on the
>>> rest of the XX-on-64 code that we do care about.
>>>
>>> IOW if someone volunteered to maintain 32-on-32 that's not actually
>>> solving the complexity problem, just perpetuating it.
>>>
>>> The current maintainers only interested in XX-on-64 will still suffer
>>> ongoing burden from the code complexity caused by 32-on-32 merely
>>> existing.
>>>
>>> So again lets be clear...
>>>
>>> Either we...
>>>
>>>   * ...want to kill 32-on-32 code to reduce the complexity on the
>>>     main XX-on-64 codebase regardless of interest in 32-on-32
>>>
>>> Or
>>>
>>>   * ...want to kill 32-on-32 code because it is buggy due to lack
>>>     of maintainers, but would welcome someone to step forward to
>>>     maintain it
>>>
>>> It sounded like we were wanting the former, not the latter.
>>
>> Yes, we want to former. But as Thomas pointed out, last time
>> someone showed up, and while the maintainers weren't willing to
>> keep 32-on-32 [*], they kept maintaining it at the price of restricting
>> XX-on-64.
>>
>> [*] back then we proved system emulation XX-on-32 wasn't really useful
>> anymore, and user emulation 64-on-32 was partly broken, so only
>> 32-on-32 user emulation was functional.
> 
> So it seems reasonable to deprecate and ask interested 32-on-32 user
> emulation users to use QEMU 10.1 release.

So unless someone complains immediately with a good reason, I'm also in 
favor of marking it as deprecated now. If then someone complains during the 
deprecation period, we still can reconsider and remove the deprecation note 
again.

Thus for this patch from my side:
Reviewed-by: Thomas Huth <thuth@redhat.com>


