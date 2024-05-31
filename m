Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB830C27C44
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCyF8-0005TE-Vc; Fri, 31 May 2024 05:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sCyF7-0005Ss-B8
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sCyF5-0004ys-DR
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717146486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+lQD4h4RvLCsTFR0PhAuxoeKg0FIzIrmwJS4ma4qQoM=;
 b=JuqZPTUIZzlhYYNz3nKgFWzyH8ysOJci9mshAiA3hS9EMi9QgubqxjBg93AlCS2z4zok4y
 VGX947lI3PWOrEYvCENfFZt63rNmz7Vg7x9CpygtQHDUbErSfMhHwvRKbmlNvygipf6ErE
 xjJwwnoivKvDwqIWGmhmAH+j/1Vqeyo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-uC2mlWv_Pre2EBzQmKHf4A-1; Fri, 31 May 2024 05:08:03 -0400
X-MC-Unique: uC2mlWv_Pre2EBzQmKHf4A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35dc0949675so1362278f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717146482; x=1717751282;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lQD4h4RvLCsTFR0PhAuxoeKg0FIzIrmwJS4ma4qQoM=;
 b=ds9fRrtiAHceulqaxblFI/Pyik19n+DALvcACvF/NLDijjcPhvc5WDjeqH2DI1QDyS
 R+BffepAsl+PQy0mbdya4Y2YOeWxxJFigMx0yBIeafQxNCr5roWgAlpkkG98QrcCG46X
 4MOEV29Bc/TAkBuESBz1lOhYjdU2TrDPjFzqFO3D6M7l7TZFGRtcy8o0d/hRf9Nq/YGx
 G5/0mE2wJSRrn4FfBdyYUEngRw7a2NS6eVp36/HHD0Omm5xOrS/1bXv7Gc9q+mkR6lLy
 InjRhzaq6N0C+pfFeIaCRxzjbCe3RY1dt6dejkR6feF8Qr7V8sJxI2kT7Fubjsde31x7
 fvgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFQlFCZBKX7AUbT2yZA31lI9Q8FqElj2+JwTXNEfXOo18sse2h1Ge9NTAjWrpkpiTXKB6X4XFQfXNSRZ+SDo++B75PaIM=
X-Gm-Message-State: AOJu0YwRO5u10wRwj3kcbNLmHWySqU8nVa9s0zy36EKKETsVy8h0y9CA
 npGw7pMEst3AcsKLvBR+Xazz9he2NvNgal8bIxYsyHOR7Vqli5fBNoRjvCljNEog4jVNfSsB0Aa
 GsSVznrom77gCNLvbTzpVwCMcopWD5md4oyRJd4gcAo2klOcvPqy5
X-Received: by 2002:adf:f6c9:0:b0:354:f8a9:351 with SMTP id
 ffacd0b85a97d-35e0f255649mr1118974f8f.3.1717146481956; 
 Fri, 31 May 2024 02:08:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9G38VME8Vcl/VjbJuOazslzcuo7fmyim+mQxqhv9HXkuzkOKsvfc7qkDjpL6cXqR2w8KTOg==
X-Received: by 2002:adf:f6c9:0:b0:354:f8a9:351 with SMTP id
 ffacd0b85a97d-35e0f255649mr1118945f8f.3.1717146481424; 
 Fri, 31 May 2024 02:08:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:a000:d4df:4b8f:37d4:59e4?
 (p200300cbc717a000d4df4b8f37d459e4.dip0.t-ipconnect.de.
 [2003:cb:c717:a000:d4df:4b8f:37d4:59e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064bb21sm1380883f8f.102.2024.05.31.02.08.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 02:08:01 -0700 (PDT)
Message-ID: <370f6594-882d-455e-8b45-5d6cab7fcb85@redhat.com>
Date: Fri, 31 May 2024 11:08:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] osdep: Make qemu_madvise() to set errno in all
 cases
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, Cameron Esfahani <dirty@apple.com>,
 Eric Blake <eblake@redhat.com>
References: <cover.1717140354.git.mprivozn@redhat.com>
 <e2250aa1d69faffcfd12b6d809d98b0c8157ce36.1717140354.git.mprivozn@redhat.com>
 <81f8c7f8-a4a6-4f74-894f-be3ffbf25f9d@linaro.org>
 <12cba30e-4034-4d3b-a0b4-5e25dbc5d094@redhat.com>
 <577f65c3-23d3-44ce-8601-32c067912a8a@linaro.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <577f65c3-23d3-44ce-8601-32c067912a8a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 31.05.24 10:12, Philippe Mathieu-Daudé wrote:
> On 31/5/24 10:01, David Hildenbrand wrote:
>> On 31.05.24 09:57, Philippe Mathieu-Daudé wrote:
>>> Hi Michal,
>>>
>>> On 31/5/24 09:28, Michal Privoznik wrote:
>>>> The unspoken premise of qemu_madvise() is that errno is set on
>>>> error. And it is mostly the case except for posix_madvise() which
>>>> is documented to return either zero (on success) or a positive
>>>> error number.
>>>
>>> Watch out, Linux:
>>>
>>>      RETURN VALUE
>>>
>>>         On success, posix_madvise() returns 0.  On failure,
>>>         it returns a positive error number.
>>>
>>> but on Darwin:
>>>
>>>      RETURN VALUES
>>>
>>>         Upon successful completion, a value of 0 is returned.
>>>         Otherwise, a value of -1 is returned and errno is set
>>>         to indicate the error.
>>>
>>> (Haven't checked other POSIX OSes).
>>>
>>
>> ... but it's supposed to follow the "posix standard" :D Maybe an issue
>> in the docs?
>>
>> FreeBSD seems to follow the standard: "The posix_madvise() interface is
>> identical, except it returns an error number on error and does not
>> modify errno, and is provided for standards conformance."
>>
>> Same with OpenBSD: "The posix_madvise() interface has the same effect,
>> but returns the error value instead of only setting errno."
> 
> On Darwin, MADVISE(2):
> 
>      The posix_madvise() behaves same as madvise() except that it uses
>      values with POSIX_ prefix for the advice system call argument.
> 
>      The posix_madvise function is part of IEEE 1003.1-2001 and was first
>      implemented in Mac OS X 10.2.
> 
> Per IEEE 1003.1-2001
> (https://pubs.opengroup.org/onlinepubs/009695399/functions/posix_madvise.html):
> 
>     RETURN VALUE
> 
>       Upon successful completion, posix_madvise() shall return zero;
>       otherwise, an error number shall be returned to indicate the error.
> 
> Note the use of "shall" which is described in RFC2119 as:
> 
>      This word, or the adjective "RECOMMENDED", mean that there
>      may exist valid reasons in particular circumstances to ignore a
>      particular item, but the full implications must be understood and
>      carefully weighed before choosing a different course.

Agreed, so we have to be careful.

I do wonder if there would be the option for an automatic approach: for 
example, detect if the errno was/was not changed. Hm.

-- 
Cheers,

David / dhildenb


