Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650531098788
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3amL-0008D7-Ni; Fri, 20 Mar 2026 10:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <califano.tommaso@gmail.com>)
 id 1w3amJ-0008Cf-P0
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:24:44 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <califano.tommaso@gmail.com>)
 id 1w3amH-0007vI-Tz
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:24:43 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so14787865e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774016673; x=1774621473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fthiLTuf+I5jeGebor5z+DXDHTxh9yqgwY89zBw9Yfg=;
 b=O5/OCCfkTqQr2pOOwIqtYmiYqeCR1z+L8Dqki7K+3158Qvgothq25+Xp3QH9s2dV1H
 YuHWQHAW8kHlu51q8Q7yIdxZKh+ID0LrDJThS1tMKoXRMHbE864D0GtJhhvm/VAe5sIJ
 WRrOGxl1Hg1krDjoMewv6rkeisgnJKC7KBDcsufG/TtQbfI3z+7oxZ8B6XXmO0J5ybjh
 NZ4NcnQGr3zpeH7cF28sVkqqTf8W0doPZP0el3jtHwKMhJbsniVn5hmMWMZOyvVQxwGB
 rdt+mFFmvJMmKBAQUiqFHvw7V8mDstxjZepAwyo+uVmjj8QzaVIgRzCuRD4yTjnkp9XT
 UWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774016673; x=1774621473;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fthiLTuf+I5jeGebor5z+DXDHTxh9yqgwY89zBw9Yfg=;
 b=Kw6QqrikAUujKzviFO/hp7QuKIzyZkF3mGtka4L3CSiqUyOYkqaKVlxpTN/370nim4
 qm+H+A6EnXivfM5k3hMDh0erctBDxgppb4WD/HRSMpq1VDpQM88KQ+d3Emt5CXOSr7Z7
 YahTm97tp6k+TRfe3Dy5IaIk25SqZKrIMP2pPuuL23mGroUHVpoT2hAX8kd5WZMQlAxT
 ManUMOwsoOvJPnn+slyuYJG0iUChQG6jI6GAjSxxSxdwDDDTNbGxDcu8Fm/7fT3jEUeu
 1c+099hFlBxccfBm+6WRh6rU3NuNne/hCszM+AiuGz8K0LM49ag8qg9KoFjxSm39Knv8
 60sw==
X-Gm-Message-State: AOJu0Ywpf72y8jfYf2+My8qJm4Ha0QQ4S4F9wwT9gasn6MJGCenB/aMH
 Mz1tI5JqeML6BIPQk63aHinTcxsSyiE9RhK9DUweQLkj5p0+/E7ZerIb
X-Gm-Gg: ATEYQzwA+3rOc4L06wZhCRp0QIjNZubotrNPhTd17B6VNuggsBiRXXcP1/3NoPp6TB2
 y+80or9NPoAkkFw25cdx6o8AnynpfulToFtBpQGJhfTb9rWM0YPo1GkUF4EXVAi5Iixem/6ggvF
 6xCUFXe6FcZ0QCZaen87ElKONu8dBZi8IXz5BSVSntHLZ3qT9zeYmeEmne1IQuiF/VrblIrhzGA
 y85lR6FiSJDamJHgsibx7dGhl8+ujPqiTAxs2hO6zz+hHvRCAedOeiPX3RFrLy6pyfp0qX7LOvN
 TH9amoJYpwrZ5ObWnBIG70PVaiSazxUfB8b3wvVJunh2NI1QZCZqeHuIciQZiac+B+Z22/tlitV
 KaiuVnArjI+6z/i4Hb3ptQcM06+Tet2ksfsK2S60jpvKiWnsIhPRsWSw5R0vy4B9xC72re869cT
 PkMvUUgFiI1i4rpMgdbbXdn4PBs7GR+1Us7M9O+tYBpu0dcz58HRvSqSACwV8Sn1qqUTKyETdoQ
 rY4oZCwIVl3
X-Received: by 2002:a05:600c:3b94:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-486fe8ef087mr56191865e9.12.1774016672928; 
 Fri, 20 Mar 2026 07:24:32 -0700 (PDT)
Received: from [192.168.10.55] (host-87-27-45-215.business.telecomitalia.it.
 [87.27.45.215]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1dd9f1sm24913205e9.8.2026.03.20.07.24.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 07:24:32 -0700 (PDT)
Message-ID: <1694998d-ea3d-4707-bf95-726ba9aee6c4@gmail.com>
Date: Fri, 20 Mar 2026 15:25:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] i386/sev: Add sev-emulated QOM object with TCG support
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Blake <eblake@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Paolo Bonzini <pbonzini@redhat.com>, Luigi Leonardi <leonardi@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
 <20260317113840.33017-2-califano.tommaso@gmail.com>
 <87tsucvw3k.fsf@pond.sub.org>
Content-Language: en-US, it
From: Tommaso Califano <califano.tommaso@gmail.com>
In-Reply-To: <87tsucvw3k.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=califano.tommaso@gmail.com; helo=mail-wm1-x332.google.com
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



Il 19/03/26 13:31, Markus Armbruster ha scritto:
> Tommaso Califano <califano.tommaso@gmail.com> writes:
> 
>> QEMU's AMD SEV support requires KVM on costly AMD EPYC processors,
>> limiting development and testing to users with specialized server
>> hardware. This makes it hard to validate SEV guest behavior, like
>> OVMF boots or SEV-aware software, on common dev machines.
>> A solution to this is the emulation of SEV from the guest's
>> perspective using TCG.
>>
>> This change begins this process with the exposure of the SEV CPUID leaf.
>> In target/i386/cpu.c:cpu_x86_cpuid() case 0x8000001F:
>>
>> case 0x8000001F:
>>     *eax = *ebx = *ecx = *edx = 0;
>>     if (sev_enabled()) {
>>         *eax = 0x2;
>>         *eax |= sev_es_enabled() ? 0x8 : 0;
>>         *eax |= sev_snp_enabled() ? 0x10 : 0;
>>         *ebx = sev_get_cbit_position() & 0x3f; /* EBX[5:0] */
>>         *ebx |= (sev_get_reduced_phys_bits() & 0x3f) << 6; /* EBX[11:6] */
>>     }
>>     break;
>>
>> sev_enabled() verifies if the QOM object is TYPE_SEV_GUEST;
>> TYPE_SEV_EMULATED is derived from TYPE_SEV_GUEST with SevEmulatedState
>> to satisfy this check with minimal changes. In particular this allows
>> to bypass all the sev_enabled() checks for future features.
>>
>> Since KVM hardware isn't available, override the QOM's kvm_init() and add
>> a conditional confidential_guest_kvm_init() call during machine_init() to
>> set up emulated confidential support using the ConfidentialGuestSupport
>> structure.
>>
>> With this change it is possible to run a VM with the SEV CPUID active
>> adding:
>>
>>     -accel tcg \
>>     -object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1 \
>>     -machine memory-encryption=sev0
>>
>> To the QEMU start arguments.
>>
>> Signed-off-by: Tommaso Califano <califano.tommaso@gmail.com>
> 
> [...]
> 
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index c653248f85..35cda819ec 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -1057,6 +1057,19 @@
>>              '*handle': 'uint32',
>>              '*legacy-vm-type': 'OnOffAuto' } }
>>  
>> +##
>> +# @SevEmulatedProperties:
>> +#
>> +# Properties for sev-emulated objects.
>> +# This object functionally emulates AMD SEV hardware via TCG, so
>> +# it does not require real hardware to run.
> 
> Wrap the paragraph, please:
> 
>    # Properties for sev-emulated objects.  This object functionally
>    # emulates AMD SEV hardware via TCG, so it does not require real
>    # hardware to run.
> 

I'll do it.

>> +#
>> +# Since: 10.1.0
> 
> 11.0 right now, but realistically 11.1.
> 

I'll update it to 11.1.

>> +##
>> +{ 'struct': 'SevEmulatedProperties',
>> +  'base': 'SevGuestProperties',
>> +  'data': {}}
>> +
>>  ##
>>  # @SevSnpGuestProperties:
>>  #
>> @@ -1241,6 +1254,7 @@
>>      { 'name': 'secret_keyring',
>>        'if': 'CONFIG_SECRET_KEYRING' },
>>      'sev-guest',
>> +    'sev-emulated',
>>      'sev-snp-guest',
>>      'thread-context',
>>      's390-pv-guest',
> 
> Please insert before sev-guest to keep things more or less sorted.
> 

I'll do it, but I don't understand the convention. I'd organized them
by object derivation hierarchy, so what is the expected sorting order?

>> @@ -1318,6 +1332,7 @@
>>        'secret_keyring':             { 'type': 'SecretKeyringProperties',
>>                                        'if': 'CONFIG_SECRET_KEYRING' },
>>        'sev-guest':                  'SevGuestProperties',
>> +      'sev-emulated':               'SevEmulatedProperties',
> 
> Likewise.
> 

Yes.

>>        'sev-snp-guest':              'SevSnpGuestProperties',
>>        'tdx-guest':                  'TdxGuestProperties',
>>        'thread-context':             'ThreadContextProperties',
> 

Best regards,
Tommaso Califano

