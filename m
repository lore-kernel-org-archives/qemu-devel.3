Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78100109879C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3bpB-0001dv-0V; Fri, 20 Mar 2026 11:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <califano.tommaso@gmail.com>)
 id 1w3bp9-0001df-F8
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:31:43 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <califano.tommaso@gmail.com>)
 id 1w3bp7-0000jP-LH
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:31:43 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43b467dcf0bso2079043f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774020700; x=1774625500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ciUNjB6LjluLW5sYgrhRg9Xhj16iAUsYEhwS7K8oIw=;
 b=lR2ABErY67heXINpWwWzLlxLM+DcrQtv66OBjbWCQwP3+DRuWrrKXuU57u3OFPdlBF
 xT6zxQLfJXrqNxrg7PL+maRvN+0KAWA58S1KaW6JM5JoYyXmY6zkMICJL5dg23qL7qJq
 VNspUOX7K58obh90sNxI37BgALTQ47LoGfszaA8D+ktjUNVcXQ81xtIEqv3t9Kuu/ofM
 oVQp7gVwL9InHe9LbSnURw5rxZwSO2EZ74hadoQrZ6XJyL/A2Vj1Yh+47I6G/nwJ/SIl
 xPQa757aEoyP4zCo7Ou4sp1Okw1jHkUQT7s1TY45sXrq9uNyxECSOWCXEUJgokwzH2dN
 4/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774020700; x=1774625500;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ciUNjB6LjluLW5sYgrhRg9Xhj16iAUsYEhwS7K8oIw=;
 b=NxAXLFMdcXnGPj9ajdceFdEjSnkj7CbWgd9r5WXTw/Xr+pjMuLuBJo+jO+Y61wCvbP
 pZW8m2S2i8X1yHw/KHmKsbFrvOX1f5tNwkK1zol3Mh2vUMWMa2SnI7aAMoaT2Mta+KBW
 tYck/Q0KyxCXt3taCE0rgHPTUEeg3InFG3l+EnldZLR4+pV7bchaACm6yqnx9GufxscB
 xTdi7SDPjNQpahyJEUWXrR0hfwm5j2EaSg40vvEHppeCGq6vVDsfepFkrr/tUkWESnM8
 3z044wwOsaqQxFgbhZMpGWjU383ZqWBV/L318hhV6iow96PwyK5xfKJB58H++X+1BJ5F
 +iMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXaEHsqWXOVcp31vscCWCHUzpp8itM+CoTOiEn3guT4GEP4IZ+oDLOqwlwD69aRjqDcOtHwxcUoscn@nongnu.org
X-Gm-Message-State: AOJu0Ywvn3HupNfouXp7b10TGCBEEtWvEeaCDijZkMRtkPIfFve2O3tN
 5eHhdr1MTqE6CS0QjEpFf3dnHI7WLCKosv3oF5s35xWQovsUwUHP3AYE
X-Gm-Gg: ATEYQzxscbpksdPPnaHK5kCrOR8ghpZgzIf4ZbmFuT96BT9LrPQ5T/tw9VW0MaSbyb6
 mzEQj0KGv7P0jusqyJyVogs/Bql+giC6ZptUIu+rSSRFzpAIoyVIqUCfqq3d7xIH2TZadPQ8XgZ
 ArmBBnyqJRYsdFQahtVsOvQIqvGOSkBZSYXw5O2zIrEkGyPSPH1D5Ca8VYy4wDNqcTKpkgr+y5x
 73vTpqHih1ajGaYyZ+pmC5b72hn19H/yFTvqaWLC20PlOdPMeRQpGqaBIpjhT91J+FMJqSUuLpN
 GP/+MWde+j5OxCx1Ql7uZ/gQScz+sX7CHyh6Elrmtc7InmXjLI4VFqYMd+SdEUEluB89aRWqSka
 BjE2GESqlDo2i9BRDWL1gJ8Qcf7/SSYpx2qbZ2N8STRxzFbiutqza+jnvNx0kg6CzrsfQBlsVXD
 FCbxiFRIE+lnnc5oU8Xwu8gsrRbC1eFfIkpaEl82NzL9Kcc45SEcsdRcjB
X-Received: by 2002:a05:6000:701:b0:43b:4951:6b37 with SMTP id
 ffacd0b85a97d-43b577233cbmr13088055f8f.15.1774020699830; 
 Fri, 20 Mar 2026 08:31:39 -0700 (PDT)
Received: from [192.168.10.55] (77-32-38-61.dyn.eolo.it. [77.32.38.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b646b0d3dsm7678915f8f.16.2026.03.20.08.31.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 08:31:39 -0700 (PDT)
Message-ID: <cfc8f64b-f14d-4903-bfb8-a71bc1bbde80@gmail.com>
Date: Fri, 20 Mar 2026 16:32:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] i386/sev: Add sev-emulated QOM object with TCG support
From: Tommaso Califano <califano.tommaso@gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Blake <eblake@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Paolo Bonzini <pbonzini@redhat.com>, Luigi Leonardi <leonardi@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
 <20260317113840.33017-2-califano.tommaso@gmail.com>
 <abw3HqBJqEWiY7GP@redhat.com> <ab1ABNvEOlIc2WCU@redhat.com>
 <68682ef3-945f-41ef-814a-8c5bc77dab1c@gmail.com>
Content-Language: en-US, it
In-Reply-To: <68682ef3-945f-41ef-814a-8c5bc77dab1c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=califano.tommaso@gmail.com; helo=mail-wr1-x436.google.com
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



Il 20/03/26 16:03, Tommaso Califano ha scritto:
> 
> 
> Il 20/03/26 13:39, Daniel P. Berrangé ha scritto:
>> On Thu, Mar 19, 2026 at 05:49:18PM +0000, Daniel P. Berrangé wrote:
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
>>>
>>>  sev-guest options:
>>>   dh-cert-file=<string>  - guest owners DH certificate (encoded with base64)
>>>   kernel-hashes=<bool>   - add kernel hashes to guest firmware for measured Linux boot
>>>   legacy-vm-type=<OnOffAuto> - use legacy VM type to maintain measurement compatibility with older QEMU or kernel versions.
>>>   session-file=<string>  - guest owners session parameters (encoded with base64)
>>>   sev-device=<string>    - SEV device to use
>>
>> Sigh, I was mislead by  '-object sev-guest,help' omitting
>> information about anything that is not a class property.
>> So there is also
>>
>>   - cbitpos=<int>
>>   - reduced-phys-bits=<int>
>>   - handle=<int>
>>   - policy=<int>
>>
>>>
>>>
>>> Of those properties
>>>
>>>  * dh-cert-file + session-file are traditionally used
>>>    as a means to transfer the TIK+TEK to the SEV firmware,
>>>    with wrapping to protect them from the hypervisor.
>>>
>>>    These can't be used with sev-emulated, as implemented,
>>>    since they require a key derivation  from the PDH, a
>>>    concept which IIUC is not implemented in this series.
>>>
>>>    Instead, in a later patch 'tik' and 'tek' properties
>>>    are added to 'sev-emulated', and to pass the TIK+TEK
>>>    in clear text.
>>>
>>>  * sev-device + legacy-vm-type - these are only relevant
>>>    to the KVM integration, so not applicable for emulation
>>>
>>>  * kernel-hashes - would be relevant if formally emulating
>>>    LAUNCH_UPDATE_DATA for attestation, but IIUC, this is
>>>    not done/used by this series

LAUNCH_UPDATE_DATA is supported in the sense that the called
memory regions are saved for measurement calculation. With this
method, even if kernel-hashes is active, the measurement remains
correct and the attestation workflow stays the same.

Thinking of it now, I could add a small improvement by checking
if the memory region is already in the QEMUIOVector ld_data,
avoiding multiple addition of the same region.

>>>   
>>>
>>> IOW, we're deriving from 'sev-guest' but AFAICT none of
>>> its properties are relevant to the emulation. The
>>> dh-cert-file and session-file could potentially be
>>> relevant if implementing the PDH concept and key
>>> derivation, but that's not done, instead the tik/tek
>>> are passed explicitly.
>>>
>>> What is the value we get from this sev-guest -> sev-emulated
>>> inheritance ?  My gut feeling is that this perhaps isn't
>>> the right way to be modelling things unless there's a plan
>>> for future work that would benefit from them.
>>>
> 
> I know most of these properties aren't used in emulation. I chose
> to derive from `sev-guest' primarily for the policy property
> (needed for SEV-ES future implementation).
> 
> For the TIK and TEK properties, I considered reusing dh-cert-file
> and session-file, but since those keys are CPU-generated anyway,
> I opted to simplify the cryptographic protocol given the fact
> that security isn't the focus here.
> 
> That said, you're right that sev-guest inheritance may not add
> much value. If you'd prefer interface consistency for testing
> (reusing dh-cert-file/session-file) those properties could then
> become relevant. Otherwise, for pure SEV emulation, deriving from
> sev-common makes sense instead; though I'm unsure how that would
> impact the SEV-ES implementation, perhaps we could re-add just the
> policy property if needed.
> 
>>> Another question related to modelling is whether there is
>>> an intention to support SEV-SNP at a later date, would that
>>> imply a sev-snp-emulated object type too ? If so, would it
>>> inherit from sev-emulated or from sev-snp-guest ?
>>>
> 
> While I haven't studied it in depth, I think it will. It seems
> best to derive a new object (sev-snp-emulated) from sev-guest-snp
> because of the sev_snp_enabled() function, which will work through
> TYPE_SEV_SNP_GUEST casting (similar to the current sev_enabled()
> function).
> 

Apologies for the multiple emails; I forgot to explain the kernel-hashes
implementation.

Best regards,
Tommaso Califano


