Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAC7C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE16Z-0003PN-3J; Mon, 03 Jun 2024 02:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE16X-0003PB-IC
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE16V-0002kj-Uu
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717395807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=26+Xu0z+mwmWvkWDSsZC5vhT82QxGNFOFenwPmqO37c=;
 b=g+MmeLqIu2VKmw7jmuF74HOjIo6FQNj8ZueiMAL2VXn7o3vnmqx8wwgrkROEKHsdDvjkkU
 hfU07SThRWwxtWX+h9awbPXUzaA9YzrJIzGFUtmK7KqvdI32jeGVgLz7aUn06d68xW8lpb
 2qLUpKuteiZDAhKhC9I+86yDv0jwLzg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-F7yEf_tKO-qfW4JFICY3Bg-1; Mon, 03 Jun 2024 02:23:24 -0400
X-MC-Unique: F7yEf_tKO-qfW4JFICY3Bg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6929fc5b52so3323966b.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 23:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717395803; x=1718000603;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=26+Xu0z+mwmWvkWDSsZC5vhT82QxGNFOFenwPmqO37c=;
 b=Ee6Cqe6IkknhN1PnpL4UyeFBU7UIUpR3Jzp8gVkqdr0AO5Ei2cICdOjdj9DeUcA8/z
 RVtN1ee9Vhtkuwcjq1HlpgUBn9MNNJPuQvPmLq5AvOgKUg0nsrpUZ0iheOIOjtyZKZ1M
 gI7JgoVLIpsX3OTWVx7SQa8ur5LL/DpT9chRFhz96CXRJZthRsdcPRAnWi14+ndpEg7B
 Sf1Z5ZNjGoiAoyuVpAKq8favTJcP5bn/5jiYNJeD+gU/rNInhtI68SbZxQ1brBHJBoXZ
 JesUHPuysYUZtn+F6ApmWhDFI1nz6Z6WrIkCKhTBGIkdc0U3T6aUban6eQS/n+EXNvti
 bvdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL3VGMhEIXdyqTz/DsiGlXo4scCfZjWTy+KqORO2ETLiUupRN9IpHAMX27RoRo673HCUzdmeKWJOX6gnadE3g2UlYqTXc=
X-Gm-Message-State: AOJu0YyUjfz6jQw7T5OPVppxOnWRLiA5n89ngXas7z6qBatRCtV+K1xl
 mzpGf1kDyhx0b0uO9Gl/ZdDR0UQFETikNVa+yWF3pwKAM5VOVwmXpTJ1pYVleMSR5BwnQDm9sX7
 xDLoOVY/gFns8pMIpQ+NfCGvPZXHbGbuozo5l3RRsT3KhofUfkAdH
X-Received: by 2002:a17:907:7241:b0:a62:1347:ad40 with SMTP id
 a640c23a62f3a-a681fb608f4mr673311566b.16.1717395802975; 
 Sun, 02 Jun 2024 23:23:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxkj8jL4elFrx4eH4kazTe8F11JtukOzJUfxXkOYich2nzmZS9ODGgQni2qhKeMnHKX4vpdA==
X-Received: by 2002:a17:907:7241:b0:a62:1347:ad40 with SMTP id
 a640c23a62f3a-a681fb608f4mr673309566b.16.1717395802501; 
 Sun, 02 Jun 2024 23:23:22 -0700 (PDT)
Received: from [192.168.10.81] ([151.81.115.112])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a690e5ee90esm98772866b.117.2024.06.02.23.23.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jun 2024 23:23:21 -0700 (PDT)
Message-ID: <0666159b-9e1e-4564-abca-240c518b044f@redhat.com>
Date: Mon, 3 Jun 2024 08:23:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386: removes microvm from default build since microvm
 doesn't support Xen accel.
To: Will Gyda <vilhelmgyda@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, richard.henderson@linaro.org, 
 eduardo@habkost.net, manos.pitsidianakis@linaro.org
References: <20240602103810.21356-1-vilhelmgyda@gmail.com>
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
In-Reply-To: <20240602103810.21356-1-vilhelmgyda@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/2/24 12:38, Will Gyda wrote:
> i386: removes microvm from default build since microvm doesn't support Xen accel.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2294

This is already done in (what will be) QEMU 9.1; 
configs/devices/i386-softmmu.mak has:

# Boards are selected by default, uncomment to keep out of the build.
# CONFIG_ISAPC=n
# CONFIG_I440FX=n
# CONFIG_Q35=n
# CONFIG_MICROVM=n

So we would only have to add the "depends on".  I don't oppose that, but 
also I don't see why microvm cannot support Xen.

Paolo


