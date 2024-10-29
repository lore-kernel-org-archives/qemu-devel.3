Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83305D5B164
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hvJ-0004PH-4g; Tue, 29 Oct 2024 04:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5hvC-0004Ow-QR
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5hvB-00004r-5m
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730191787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ixR+LqgDRzMfXhFpmTKeqYDRU9CJhVk0K3gZw25yoaI=;
 b=ZLrE6KZl0dE4kam/NCz+HxiIDi3tjT/EqJXBENqUL/E2RL0F2rlua+eaBHXp58pS4XzVi5
 D2hRk2q0+afd7Nqn8UlVPJ7iBLJqwAaVgigYPohlT8Mv5PlmecUatsq8nHrImPZU3svaaC
 yCGCn7iul6AxB3m/qfIeEaMTOqJ5TWU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-winx9l0MN6m5efKD-Hedxg-1; Tue, 29 Oct 2024 04:49:42 -0400
X-MC-Unique: winx9l0MN6m5efKD-Hedxg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d60f3e458so3394510f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 01:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730191781; x=1730796581;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ixR+LqgDRzMfXhFpmTKeqYDRU9CJhVk0K3gZw25yoaI=;
 b=v+kuv3c2u5y/0mPtgavDmk3sn2LADPfmktFX5wFasDII0QESxzeiNrMxhVBhIMnZGY
 HuuL2bCpX+xuMHrWHIYDadk59H3kRj7dn9jvbQ043fwKPzmyMUqh8YQLCfGQaq7lUEo9
 SEhhwfHAcQXqc6KVrBI1IGY8MANVG/3FHQIFtjvbeWEMvM/kfmQkEks2nbkPbdEN8zBs
 gQrEm3CjW1XnLCd1zNtDJqor73IwmnGBY0c0LvBWkpfEuYX0YWX4JGLT9/0wjm/GALKI
 gBjI/QmSCjMYidJUr/pPk3LNaOGqKifShutoqkr7uKH27NQEo8pFmbk2m2qFeZbszuxD
 I17g==
X-Gm-Message-State: AOJu0YyP4qbgnwDa7KQFuqR+NG281S0IteIB9Fb03vgrWVmhHbTtTagS
 0ekSiAU8FmW9h02Scz0CqXC3I7Immp2fB/1/R5iNcjL1fLnZUyD3GIvDC3mS4JoGmUz0d24jsjt
 VWr4C+ILOk+c7LoZI51CVgpsOMe+UhmivO8zYzY+PIiCNRUBQj6tb
X-Received: by 2002:adf:e347:0:b0:37d:4cd6:e8e with SMTP id
 ffacd0b85a97d-3806123a5eamr9588270f8f.48.1730191781462; 
 Tue, 29 Oct 2024 01:49:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJuEr90KLoE4MEZv6+Qj9Aubeaa3e/16qBQgyqHw9dy+DDTlThJsHhflfBGMspdssrvu6DMw==
X-Received: by 2002:adf:e347:0:b0:37d:4cd6:e8e with SMTP id
 ffacd0b85a97d-3806123a5eamr9588252f8f.48.1730191781041; 
 Tue, 29 Oct 2024 01:49:41 -0700 (PDT)
Received: from [192.168.10.47] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4318b58b7e8sm169870625e9.48.2024.10.29.01.49.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 01:49:40 -0700 (PDT)
Message-ID: <f31b8bd3-07f1-4661-ae11-fc7fd2d6a90d@redhat.com>
Date: Tue, 29 Oct 2024 09:49:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/i386: Add AVX512 state when AVX10 is supported
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, mtosatti@redhat.com, xiaoyao.li@intel.com,
 xuelian.guo@intel.com
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-2-tao1.su@linux.intel.com>
 <3adc6dab-25c2-4303-b382-153e843123bf@redhat.com>
 <Zx9Yof/RWnub4Lmi@linux.bj.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <Zx9Yof/RWnub4Lmi@linux.bj.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/28/24 10:25, Tao Su wrote:
> On Mon, Oct 28, 2024 at 09:41:14AM +0100, Paolo Bonzini wrote:
>> On 10/28/24 03:45, Tao Su wrote:
>>> AVX10 state enumeration in CPUID leaf D and enabling in XCR0 register
>>> are identical to AVX512 state regardless of the supported vector lengths.
>>>
>>> Given that some E-cores will support AVX10 but not support AVX512, add
>>> AVX512 state components to guest when AVX10 is enabled.
>>>
>>> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
>>> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
>>> ---
>>>    target/i386/cpu.c | 14 ++++++++++++++
>>>    target/i386/cpu.h |  2 ++
>>>    2 files changed, 16 insertions(+)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 1ff1af032e..d845ff5e4e 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -7177,6 +7177,13 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
>>>            }
>>>            if (env->features[esa->feature] & esa->bits) {
>>>                xcr0 |= 1ull << i;
>>> +            continue;
>>> +        }
>>> +        if (i == XSTATE_OPMASK_BIT || i == XSTATE_ZMM_Hi256_BIT ||
>>> +            i == XSTATE_Hi16_ZMM_BIT) {
>>
>> Can you confirm that XSTATE_ZMM_Hi256_BIT depends on AVX10 and not
>> AVX10-512?
>>
> 
> Sorry, I should attach AVX10.2 spec [*].
> 
> In 3.1.3, spec said Intel AVX10 state enumeration in CPUID leaf 0xD and
> enabling in XCR0 register are identical to Intel AVX-512 regardless of the
> maximum vector length supported.
> 
> So XSTATE_ZMM_Hi256_BIT doesn't depend on AVX10-512.
> 
> [*] https://cdrdv2.intel.com/v1/dl/getContent/828965

Ok, thanks.

Another related issue is that kvm_cpu_xsave_init() is using esa->feature 
and esa->bits, which misses these three features.

I think we need to change the code to not look at esa->feature at all. 
I'll send a v2 of your series.

Paolo


