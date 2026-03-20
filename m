Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9FD1098796
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3bNF-00023F-16; Fri, 20 Mar 2026 11:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <califano.tommaso@gmail.com>)
 id 1w3bND-00022r-B2
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:02:51 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <califano.tommaso@gmail.com>)
 id 1w3bNB-000148-Iw
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:02:51 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-486fd3a577eso5972385e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774018967; x=1774623767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Zj3pqCGOJKAY2IYhlrVORUKcc3AyQX6JCd7bR8/pZ4=;
 b=IOki6olJqpaKZBsxQrxxy1m9uTfl8Eeg7jAq0V4L7vBlHbU2NkQvV7P7PS5tpGunzC
 Z907Ws4pUlwRioH85xlLWkTp270lI3zu2uFJoaqWF1bncwtp1yj5PxMvuLWqrOhqhBu8
 69J/E+eIVmNXPeGAmhu9wDS4NXTkT5kKB6NaW9oUoso26j14KT4K9xOTIKfcXlLdxTsQ
 YZzoNab8d+3QmNmrC4nM8izYdCXT6cjmPyO+nZAGnEP5+JcE/qUalMINR/GiZGA80i0J
 giA4p9fvY/1Aq7j7Y3BRhhJ0wYpPZ0vbf9bR84/EAz94a2IA5Ef7JuPmaMiviDDiN4v1
 NhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774018967; x=1774623767;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Zj3pqCGOJKAY2IYhlrVORUKcc3AyQX6JCd7bR8/pZ4=;
 b=GafgIHPFZpTNXAso9QHqGfWGE/qStsn9yPG6HtKo3WJlwcEp58j1RydifWemykrLcy
 FJi+IRIO/Vz2va3OY2XTHwPI7qdQBRWojaVNrg698X5T4JVe/XIwY8BUgFOZN3fqBZEg
 CWJN3YJBBGksbePLgSMfI0yWTuDGYippMz2lqIS6KqzWhDQ59nId7VuMW3wmyC+OITCT
 zsK9fssFdR6a+IGXDtCnRh5YnVhP3XVOH00DZ+Bq6p96PYsoNRdO88CMOtgcgXq0Zh5O
 eFvKtOEMFVJfnOd6RBnfJW5UwbHm+KvUcz4swlvklSPtvFidRNvAlqkculFePOlOKlR7
 3TDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlNH2g0f1Jw3OEH34dN0peuJYHZfbftSNUspz2k20m8IbtD7k2b8ftO/PLniHHCioHRn/xUo8AfHrK@nongnu.org
X-Gm-Message-State: AOJu0Yxh9KPTLgPwmK+aeIN5fnh8YtaG6PJgfBj4jqKqm4V9ah7B0oLV
 J1XBvUsxAVMeJedeYSdROFGb+Tn4szbWvUMA4r0sY4ymnWss7p7vmBku
X-Gm-Gg: ATEYQzw4vtLuTD6GBRBUuPlrhhU8xNLOEsd2TIY3ZaevdV9j/nlrXqP8SfIV3B8xuXh
 JeHKiY+08aYCfOrl3SGsjmnOL4j4Ts/UekKwe5u3HeaS7+caAQoel6cFIKM5Pufx9MBC+Bpm0+B
 zC3R9z+YBw5NVthOAu7aHEPUY+vnoI/cjKdfSsopUsfz4bUlPLwtwmOEKNz6Oy/18aLhyHWJoNc
 3WWhN1hhaz8d+aUk61VPy76z4+VaI4le5l8zpMdGc3DzJ54WzH5faxQ5amCaMOcz3qDTiCzXYGO
 WoRFPPt8Te6b7kO7CgwqJxyxsUq/a9iutX2VRV8V/MdVsYkwfBom0VHRJH/a5Fgqwi/7wPhJITg
 qVNpEgFNM1XmtXUX5c6EPULf7wI0IvGPqqrII0N6CJoKBmhFDW8u1qJG9xdEf3dvE3dZT5MXyYF
 AglyZg4R8je4dgR1mZeK5r0jOFKRhLH2uzDk5me47SPrf7B2MRtl924PM88z3sr0w50CZvcAO08
 RPS/kPMEZok
X-Received: by 2002:a05:600c:1d15:b0:485:2ce2:4c75 with SMTP id
 5b1f17b1804b1-486febbc648mr48103335e9.1.1774018967289; 
 Fri, 20 Mar 2026 08:02:47 -0700 (PDT)
Received: from [192.168.10.55] (host-87-27-45-215.business.telecomitalia.it.
 [87.27.45.215]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff109b95sm49229875e9.1.2026.03.20.08.02.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 08:02:46 -0700 (PDT)
Message-ID: <68682ef3-945f-41ef-814a-8c5bc77dab1c@gmail.com>
Date: Fri, 20 Mar 2026 16:03:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] i386/sev: Add sev-emulated QOM object with TCG support
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
Content-Language: en-US, it
From: Tommaso Califano <califano.tommaso@gmail.com>
In-Reply-To: <ab1ABNvEOlIc2WCU@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=califano.tommaso@gmail.com; helo=mail-wm1-x32e.google.com
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



Il 20/03/26 13:39, Daniel P. Berrangé ha scritto:
> On Thu, Mar 19, 2026 at 05:49:18PM +0000, Daniel P. Berrangé wrote:
>> On Tue, Mar 17, 2026 at 12:38:36PM +0100, Tommaso Califano wrote:
>>> With this change it is possible to run a VM with the SEV CPUID active
>>> adding:
>>>
>>>     -accel tcg \
>>>     -object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1 \
>>>     -machine memory-encryption=sev0
>>
>> snip
>>
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index c653248f85..35cda819ec 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -1057,6 +1057,19 @@
>>>              '*handle': 'uint32',
>>>              '*legacy-vm-type': 'OnOffAuto' } }
>>>  
>>> +##
>>> +# @SevEmulatedProperties:
>>> +#
>>> +# Properties for sev-emulated objects.
>>> +# This object functionally emulates AMD SEV hardware via TCG, so
>>> +# it does not require real hardware to run.
>>> +#
>>> +# Since: 10.1.0
>>> +##
>>> +{ 'struct': 'SevEmulatedProperties',
>>> +  'base': 'SevGuestProperties',
>>> +  'data': {}}
>>
>> This is deriving 'sev-emulated' from 'sev-guest' which means it
>> supports all the properties that 'sev-guest' does, which for
>> the record is:
>>
>>  sev-guest options:
>>   dh-cert-file=<string>  - guest owners DH certificate (encoded with base64)
>>   kernel-hashes=<bool>   - add kernel hashes to guest firmware for measured Linux boot
>>   legacy-vm-type=<OnOffAuto> - use legacy VM type to maintain measurement compatibility with older QEMU or kernel versions.
>>   session-file=<string>  - guest owners session parameters (encoded with base64)
>>   sev-device=<string>    - SEV device to use
> 
> Sigh, I was mislead by  '-object sev-guest,help' omitting
> information about anything that is not a class property.
> So there is also
> 
>   - cbitpos=<int>
>   - reduced-phys-bits=<int>
>   - handle=<int>
>   - policy=<int>
> 
>>
>>
>> Of those properties
>>
>>  * dh-cert-file + session-file are traditionally used
>>    as a means to transfer the TIK+TEK to the SEV firmware,
>>    with wrapping to protect them from the hypervisor.
>>
>>    These can't be used with sev-emulated, as implemented,
>>    since they require a key derivation  from the PDH, a
>>    concept which IIUC is not implemented in this series.
>>
>>    Instead, in a later patch 'tik' and 'tek' properties
>>    are added to 'sev-emulated', and to pass the TIK+TEK
>>    in clear text.
>>
>>  * sev-device + legacy-vm-type - these are only relevant
>>    to the KVM integration, so not applicable for emulation
>>
>>  * kernel-hashes - would be relevant if formally emulating
>>    LAUNCH_UPDATE_DATA for attestation, but IIUC, this is
>>    not done/used by this series
>>   
>>
>> IOW, we're deriving from 'sev-guest' but AFAICT none of
>> its properties are relevant to the emulation. The
>> dh-cert-file and session-file could potentially be
>> relevant if implementing the PDH concept and key
>> derivation, but that's not done, instead the tik/tek
>> are passed explicitly.
>>
>> What is the value we get from this sev-guest -> sev-emulated
>> inheritance ?  My gut feeling is that this perhaps isn't
>> the right way to be modelling things unless there's a plan
>> for future work that would benefit from them.
>>

I know most of these properties aren't used in emulation. I chose
to derive from `sev-guest' primarily for the policy property
(needed for SEV-ES future implementation).

For the TIK and TEK properties, I considered reusing dh-cert-file
and session-file, but since those keys are CPU-generated anyway,
I opted to simplify the cryptographic protocol given the fact
that security isn't the focus here.

That said, you're right that sev-guest inheritance may not add
much value. If you'd prefer interface consistency for testing
(reusing dh-cert-file/session-file) those properties could then
become relevant. Otherwise, for pure SEV emulation, deriving from
sev-common makes sense instead; though I'm unsure how that would
impact the SEV-ES implementation, perhaps we could re-add just the
policy property if needed.

>> Another question related to modelling is whether there is
>> an intention to support SEV-SNP at a later date, would that
>> imply a sev-snp-emulated object type too ? If so, would it
>> inherit from sev-emulated or from sev-snp-guest ?
>>

While I haven't studied it in depth, I think it will. It seems
best to derive a new object (sev-snp-emulated) from sev-guest-snp
because of the sev_snp_enabled() function, which will work through
TYPE_SEV_SNP_GUEST casting (similar to the current sev_enabled()
function).

Best regards,
Tommaso Califano


