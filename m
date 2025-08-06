Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C960C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 09:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uja5X-0005Lg-AT; Wed, 06 Aug 2025 05:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uja3O-00046B-AX
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 05:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uja3M-0006LX-7n
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 05:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754470996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Osm7RAccpZZBrNRQaWjeyQ8yeXkODzrKLf0+W29EHts=;
 b=U2eimgKAbtwSfLOP+1VwXxLcymvly7J3tAP4CtgTbn0/Y6ksIlgORquJsGsoXkodUTgteG
 hKaFUK6pVdVHTlxYMm5V9YkzRlLjC+6YoMnglVdQLu5q9Y2bqjCjCCunJWdAehAc2pamVH
 xqs5hdgXJubFS8NNRQ/XTgpoyzOg/Dg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-LCefNWdSPtmro_SXeP4DJA-1; Wed, 06 Aug 2025 05:02:58 -0400
X-MC-Unique: LCefNWdSPtmro_SXeP4DJA-1
X-Mimecast-MFC-AGG-ID: LCefNWdSPtmro_SXeP4DJA_1754470977
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b8d8935418so3304069f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 02:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754470977; x=1755075777;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Osm7RAccpZZBrNRQaWjeyQ8yeXkODzrKLf0+W29EHts=;
 b=TTbLQRKFKxiqbRNMTm2wxkfYu8kcKnFZr5pdyfurl525vQkK8XYueDaqfl80uFGy+U
 c1zEQ7Y2g225ObhQKqHy3ALdNGc/HJcEzXWbDQlckYU7AvTw5fwKGHZKSdcM6kcfekT2
 P+ytHWVP/lyz0JrKiM+n0QcQ4Z/cZoSCOvSbY5V7wES+tfpyPPezG/+r8UTkXrS8eGjx
 UPI8RhTu7ExES11j4xbX7jQHKHjtd44oEZnbEkahv8bsYWvZ7mOLmz+DxtxMDX9p+gwR
 4NcyciXgVcbrgRmo+y3wzUq75CaN+u0TXpK1nwBg4SeWn5iJExrqo0tnh8EDEcrW+JEm
 8RWg==
X-Gm-Message-State: AOJu0YyESXHDFqchmjA0zWRwojQ4gTrssXvIYegUDfV1Gp3jK/6kWZM1
 M46rhmebsYexPQyJSEZEgh7wb1Y3qBy/+B9hqmOkd3MWTuJcUeeI6ioWsOFI1mZU1D2lx0CHxEF
 2ajwyYgD0ETbegrXoa1293LIfwFHOrdf+H4rVsnhPuWV+t+K/ZooF2+pu
X-Gm-Gg: ASbGnct/JQA9kwHrVasePqNujx2H7P5K3kj2gimkjBshKpuR1MszJLGS/0nncp3sepX
 OGlrrWmKAWvrJy7uPk225rPIIqxeYEIh3Pgnc/XNtsyMbTOsg3/wNXimTH1UlL7xzrg/+GvnHma
 NgZH80diLR8KGO1dzpuhm2tSK7WOppL/EtcbBMrByG7l3T2KQeb/wf6SpA8biYAuJMq1BO+aUkp
 a51Ix77NWxJJhCEIRl9vIh8QUjuiId87vKVBrsXbb14wj6a/91jJaQly7E99+3hImrGrOYYc/VO
 RuJ4hmpz/KQdI8xYOls2XCoviPw7LvY+0AoUHxhOs0RO
X-Received: by 2002:a5d:5f8a:0:b0:3b7:9aff:db60 with SMTP id
 ffacd0b85a97d-3b8f4160c8fmr1500073f8f.10.1754470976726; 
 Wed, 06 Aug 2025 02:02:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHLP6cW7npRyfqRgtC/lsDNI6x5yWcOkYRLruA58O0KyrqvlZx0QbjwL3K3qLHbNivuiZD1w==
X-Received: by 2002:a5d:5f8a:0:b0:3b7:9aff:db60 with SMTP id
 ffacd0b85a97d-3b8f4160c8fmr1500040f8f.10.1754470976291; 
 Wed, 06 Aug 2025 02:02:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.253.173])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b79c48a05bsm22418518f8f.69.2025.08.06.02.02.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 02:02:55 -0700 (PDT)
Message-ID: <ad404bb4-93fb-4a27-995f-734e647c1da0@redhat.com>
Date: Wed, 6 Aug 2025 11:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] rust: implement tracing
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org
References: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
 <aJIrpoEhrl7aLBMg@redhat.com>
 <CAAjaMXa6ManykYJJk--vNZT7oeBW9UR2v6WixaaQ8LUCSjy9Ug@mail.gmail.com>
 <aJI0mr5HDgtE9HIc@redhat.com>
 <CAAjaMXZ0Dho+5FSyc4zkOZXZT6UvHtjgmpj6_0QZQcH_AD9=VQ@mail.gmail.com>
 <aJJFVgkt7R49ZwIF@redhat.com>
 <CAAjaMXYhWsWPoDdfoNyTGrJSRfiYJDqBkv8fC87+Zi3YCtU06Q@mail.gmail.com>
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
In-Reply-To: <CAAjaMXYhWsWPoDdfoNyTGrJSRfiYJDqBkv8fC87+Zi3YCtU06Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/5/25 22:06, Manos Pitsidianakis wrote:
>> If you're thinking this is all rather complicated, you'd be right,
>> which is why for initial feature parity I figured the simplest is
>> likely to just wrap the existing QEMU inline probe function, so
>> Rust doesn't need to know about the different backends... yet...

It's not too hard to add individual backends (other than dtrace---see 
below--and ust which doesn't build for me(*) and I wanted to deprecate). 
  Tanish is pretty close to being able to post initial work.

> Yes, that indeed makes sense.  Generated C trace headers statically
> linked to a standalone trace crate library for each subsystem, that
> rust qemu crates can link to in return is the cleanest solution for
> this approach IMHO, because doing this kind of codegen via macros
> needs interaction with meson to generate the C sources and then run
> bindgen all while compiling this one crate which is a single meson lib
> target.
> 
> It might be possible to generate the equivalent of the C code for each
> backend just like this RFC generates only the log backend code, I'll
> take a look out of curiosity...
>
>> FWIW, the original DTrace authors created a Rust crate with native
>> rust integration of dynamic probes.
>>
>>    https://github.com/oxidecomputer/usdt
>>
>> I think that (somehow) we probably want to integrate that with QEMU
>> and its tracetool.

This unfortunately only works for macOS and Solaris.  It also has quite 
a few dependencies (~25) on other crates.  There is also a "probe" crate 
(https://github.com/cuviper/probe-rs) that is minimal and (currently) 
specific to Linux, which is what I planned to use.

By the way, while I like the idea of using Rust format strings, there 
are parts of tracetool (e.g. format/log_stap.py) that need the printf 
strings, and also backends (e.g. backend/syslog.py) that call into libc 
and therefore need to use printf format strings.  So I think we're stuck.

Paolo

(*) that's because this tracepoint:

visit_type_str(void *v, const char *name, char **obj) "v=%p name=%s obj=%p

incorrectly handles 'char **' as a string.  The breakage has been there 
since 2016, though probably it's only more recent versions of ust that 
actually fail to compile and until then the bug was latent until you 
enabled this tracepoint.  But it seems unlikely that anyone has used the 
ust backend recently.


