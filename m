Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD191098799
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3bge-0000LU-U0; Fri, 20 Mar 2026 11:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <califano.tommaso@gmail.com>)
 id 1w3bgc-0000LJ-CC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:22:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <califano.tommaso@gmail.com>)
 id 1w3bgZ-00080J-UW
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:22:54 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso17210815e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774020170; x=1774624970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SZLBiGzqpjQCsZMr+SMhn+yTqMt/Kd2sugURDgwEUZA=;
 b=RUlckA17X+xWTyKxn6GuDqTBKVlmr9AyhGSY/a5LRKHoET0LYPmlzI4G2bLn/JahmP
 hVEoUKFhoDfVFsulC/GqGke9RLKNdcOO/TkBc9gIydSmlZmHuynJDUe3dFyT7wAf38e6
 BpZHoWwZiiVLuFhoaU+8ms3yT7H3cje+IOtyL3lRX163IUYgb7dout0fCD/q6p5MnvKu
 +5v7yIsLR5889cjU8hf3ICwhpiyeJ8IVZo1i1/wlcWXm2WIDLPNNtbPSrpMPxEnTL20p
 c/Kwx4rJLZPTdrsAfYle1eKDzeTykx9LbD6+Y+MRh/JzOCyIBz6t7QXhXdvsp/Nd7mpN
 D0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774020170; x=1774624970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SZLBiGzqpjQCsZMr+SMhn+yTqMt/Kd2sugURDgwEUZA=;
 b=sfjsKMssCIV21i4YYbXr+Xm4YzWPpNOL2ctyKEf9nPs+zP77UDvsZrS0JfIseUKfn4
 7gR/QyadClA8OMY+vG6VQxXhBHfBPXEKtGV4AdiS99ruVjqPNr2FknX5l772IdUuJY5G
 VaImjjQ42adw12kkSeTVGYHZvAQ/B/8nsql8sGVfcf8RT/rASwfBfHDW2nEosZNdHXu4
 ptT4+Ovd/qyvM1jNvBL8hIVJ8JRNkpHrj4dfWCFCQ6j4JAkk9XulAYmz0UlGm2Po9JpD
 93S7B6KDdxZEeVpMV94t6Jtnmai274c6W9vU0P0hFNk/sxqKW0NaxyFSynRC8ncDSUvq
 WjNA==
X-Gm-Message-State: AOJu0Yynvy+h6boB/JOLsSR/H9wWjwvJADKcitvus3zdI2Du99qBWh5W
 nHmyPPnHNkwVQUnGumiSMU2AwB6fx0m3jAjJgA2QplS/8/NTrWLdYSUR
X-Gm-Gg: ATEYQzwy6WmycJCHQweDTzYtqS7VQKOu0cECnXfMwCEGq8bWBEH/Y8qTyy5TcgHQ5UL
 sITvSGT2l+x9RI0cVvVrXGCf+he2b8jKjK7u6I31DdeeKH90dl1BHX6FFaQLXz4fszPUHByK374
 ITVe8a1zWPVa3KYZS/XAvnckO+OI1xTMIHnWWwoHtONh72wYdI6yLGmBR3s8hhCkDAjpjqLuuoU
 wlIi/txypguF5hzQvff1USPiSb+P+CHBRQxzU6edAfnwbX+BD8Jbqu7Y5V16jdbd6RkUL+VdNuE
 byqHvVbkF2PKvglDP+g8HbTijxttaTiZbrqUuRW0Q/LCBcCS8OwOGofdD/W7sOU65puf0vtbuYA
 G1prymQKL8J5s+GQH+W+yh08g5E77yWysxyOrtLewAwTZqMu+p98xNibkzN3ogERrWMlDZ9FBb0
 yfApgWsQhIzouyB6PdZRMtYqI1NZ+r0MYA99PYCqsiZPBug7cHjoDuD4z3
X-Received: by 2002:a05:600c:608e:b0:485:419c:4eba with SMTP id
 5b1f17b1804b1-486febb58a9mr48327525e9.1.1774020169408; 
 Fri, 20 Mar 2026 08:22:49 -0700 (PDT)
Received: from [192.168.10.55] (77-32-38-61.dyn.eolo.it. [77.32.38.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe6d9896sm80456805e9.2.2026.03.20.08.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 08:22:48 -0700 (PDT)
Message-ID: <b6149c81-73a2-4f3f-8083-8fe2613110e1@gmail.com>
Date: Fri, 20 Mar 2026 16:23:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] i386/sev: Add sev-emulated QOM object with TCG support
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Blake <eblake@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Paolo Bonzini <pbonzini@redhat.com>, Luigi Leonardi <leonardi@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
 <20260317113840.33017-2-califano.tommaso@gmail.com>
 <abw3HqBJqEWiY7GP@redhat.com> <87eclfj66v.fsf@pond.sub.org>
 <ab1ALDdqxwSWxPOx@redhat.com>
Content-Language: en-US, it
From: Tommaso Califano <califano.tommaso@gmail.com>
In-Reply-To: <ab1ALDdqxwSWxPOx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=califano.tommaso@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Il 20/03/26 13:40, Daniel P. Berrangé ha scritto:
> On Fri, Mar 20, 2026 at 08:44:40AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>
>>> On Tue, Mar 17, 2026 at 12:38:36PM +0100, Tommaso Califano wrote:
>>>> With this change it is possible to run a VM with the SEV CPUID active
>>>> adding:
>>>>
>>>>     -accel tcg \
>>>>     -object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1 \
>>>>     -machine memory-encryption=sev0
>>>
>>> snip
>>>
>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>> index c653248f85..35cda819ec 100644
>>>> --- a/qapi/qom.json
>>>> +++ b/qapi/qom.json
>>>> @@ -1057,6 +1057,19 @@
>>>>              '*handle': 'uint32',
>>>>              '*legacy-vm-type': 'OnOffAuto' } }
>>>>  
>>>> +##
>>>> +# @SevEmulatedProperties:
>>>> +#
>>>> +# Properties for sev-emulated objects.
>>>> +# This object functionally emulates AMD SEV hardware via TCG, so
>>>> +# it does not require real hardware to run.
>>>> +#
>>>> +# Since: 10.1.0
>>>> +##
>>>> +{ 'struct': 'SevEmulatedProperties',
>>>> +  'base': 'SevGuestProperties',
>>>> +  'data': {}}
>>>
>>> This is deriving 'sev-emulated' from 'sev-guest' which means it
>>> supports all the properties that 'sev-guest' does, which for
>>> the record is:
>>
>> Uh, I somehow misread the base as SevCommonProperties!  Had I read
>> correctly, I would've had similar questions.
> 
> Even SevCommonProperties has stuff that's irrelevant for
> emulation that I mentioned.
> 

Maybe I'm missing something, but the only sev-common property not being
used is `sev-device`, since "/dev/sev" doesn't exist in the emulated context.

That said, all other properties are functional:
  - cbitpos=<int>
  - reduced-phys-bits=<int>
  - kernel-hashes=<bool>

Additionally, deriving from sev-common ensures the TYPE_SEV_COMMON type
for the sev_enabled() cast.

So I think deriving from sev-common is beneficial.


Best regards,
Tommaso Califano

