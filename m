Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADF2C282C1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 18:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tniTN-0004E2-LQ; Thu, 27 Feb 2025 13:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tniTK-0004Ck-Ld
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 13:18:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tniTI-0007is-1U
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 13:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740680334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4EePHXPg+ENBH562N4nKUDE93xTZsSNviHB9skXihDU=;
 b=EwdC4I73aPUNwqGpem2JIu3K3QTPtvV+ZcWMnCitJuZ6fBX+LHPcB85LIwF4pGVY7a4blb
 ckWTBwsbEVqAEK+CXhM+FUF2UoS19/4/1NfChIgUH7gh7D5brh7hUzTF5BzxId+v7CgTiJ
 wgfc3J4v4VS7p1VJOK61wMWqYIVeQJY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-gRIsmUU9OuysVx7ypML0pQ-1; Thu, 27 Feb 2025 13:18:51 -0500
X-MC-Unique: gRIsmUU9OuysVx7ypML0pQ-1
X-Mimecast-MFC-AGG-ID: gRIsmUU9OuysVx7ypML0pQ_1740680330
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abb8f65af3dso128235966b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 10:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740680330; x=1741285130;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4EePHXPg+ENBH562N4nKUDE93xTZsSNviHB9skXihDU=;
 b=Yg9wjQvXXY8yUB1OoPcBIOQIOx/9WlbX5J/jHORCM81wniTQSCTwXdnX+4MgLvgXg0
 o7uZBJcTUrtRNFmNiUVIhfM25Qzlbg4KJZvwbTdfK+ddxR4Mlpgs/lsedzeNHtgtCQ/u
 X3KFAnR4SA5Nt43pFg+7Tg2JO7wWPotbzNEDtKCX5G0HpPiwbuBs+FKda4mMNmqKUwGQ
 aTxlTUNchWQLInJRVf/qCKx49yDBDPIm9XmWzGnwM+TAX9TQoLAdDl565psRXAB7gHzC
 uO2ljydKHoSxq2dIXCG1Ri7p/bqUsGdF563bf8Wyw8CPsOHNob8ul1W0fDP888pg4qtd
 45VA==
X-Gm-Message-State: AOJu0YzjxwFuRVPQHDqm1zqUXJj3b3SfWUOjdIKNme8XUoBSdzWzIv9M
 Z/BkA+6KXbz1cE+8g0/uoTcdDHYxn9vb34GNam6qBbp6BAQDmz3PGASAE2ukpHwo7P+cHZS1rab
 L6AbwNgcDD3NPjUOMg/Dy+TMwOzIUjK3afIQCqu7MhkpDox/vppXzaShUIQ4faFg=
X-Gm-Gg: ASbGncv9wXhQKQvxxKcH+SPAhv85dosDHP92CoUU3rM6GpFLKM7t3d87xz6cg+ZNcX4
 Zj35KnqDjZCgwvdJnpdMJxYnZTAD5Dyr/JoCu+hWAzugU2pPfBwptAfIqxd4LuJK2ePQQNlxaVt
 AR4bNmhI29SWAFVIf3Nt/UKhQXXRxcjOLVruQoKBnKZvXVobBhNJhs6ujwhCs9m7m3YxfUaD6ie
 81Wk84tDx064UntppVoRKhjxIFKAqBbQpPI37e6zo4HqhBT3qBJmQrtFQawHvCvzH/a6BgXOJo1
 yGQZP6lAaHW2YwutJg==
X-Received: by 2002:a17:907:7f88:b0:ab6:cdc2:bf57 with SMTP id
 a640c23a62f3a-abf25d945cfmr55219566b.1.1740680329583; 
 Thu, 27 Feb 2025 10:18:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaXXSZ1V/1d1bwJ83/v1blgFp/hg/tmqIrDFoTCS44e6o4GC5cFGbx2j6+LQN2GWTAsO8vHQ==
X-Received: by 2002:a17:907:7f88:b0:ab6:cdc2:bf57 with SMTP id
 a640c23a62f3a-abf25d945cfmr55217466b.1.1740680329181; 
 Thu, 27 Feb 2025 10:18:49 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-abf1c8b1158sm87292566b.113.2025.02.27.10.18.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 10:18:48 -0800 (PST)
Message-ID: <db282c29-7422-49f8-a02b-803c42d53173@redhat.com>
Date: Thu, 27 Feb 2025 19:18:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] rust: pl011: move register definitions out of lib.rs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250227164538.814576-1-pbonzini@redhat.com>
 <20250227164538.814576-3-pbonzini@redhat.com>
 <CAFEAcA86CEbeGK6mDju5jyR7JQKB7SfnO4-JoAnyiL2kRNufkg@mail.gmail.com>
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
In-Reply-To: <CAFEAcA86CEbeGK6mDju5jyR7JQKB7SfnO4-JoAnyiL2kRNufkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/27/25 18:28, Peter Maydell wrote:
> On Thu, 27 Feb 2025 at 16:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   rust/hw/char/pl011/src/device.rs    |   7 +-
>>   rust/hw/char/pl011/src/lib.rs       | 509 +---------------------------
>>   rust/hw/char/pl011/src/registers.rs | 507 +++++++++++++++++++++++++++
>>   3 files changed, 513 insertions(+), 510 deletions(-)
>>   create mode 100644 rust/hw/char/pl011/src/registers.rs
> 
> Looking at this patch I'm sorely tempted to suggest significantly
> trimming down the commentary in these comments: it contains
> rather more text cut-n-pasted from the PL011 TRM than I'm
> entirely comfortable with, and much of it is detail that
> is irrelevant to QEMU.

Yeah, that was a point that was made on the call last week, too.  I 
think I agree, but it wasn't a decision I really wanted to take or 
suggest myself...

That said, some of the stuff does not belong in the structs but could be 
added to lib.rs, too, with more fair-use justification than in 
registers.rs.  So perhaps we could delay removing it until more aspects 
of the FIFO are modeled correctly, so that one does not have to reinvent 
the wording from scratch.

Paolo


