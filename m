Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77506C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 07:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFpnQ-0004Nl-61; Fri, 16 May 2025 03:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uFpnO-0004L5-L9
 for qemu-devel@nongnu.org; Fri, 16 May 2025 03:47:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uFpnL-0000Pv-TC
 for qemu-devel@nongnu.org; Fri, 16 May 2025 03:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747381667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7IHi2JoajN6y8n/tT9OYiAX9fqR8ZvSlGeEMZmH6v6U=;
 b=SYFkocBGiwuW83/Jmym4iV+DfI5B1vqt8chbKlabqTVZyXDzMGkX+3wPTAk6gPiBmhaqOm
 nmE1ujJwXHa3UyHQpQkUyzazp2IDCBURYx5P2svNPAaG50JDUB1CwknXvQmcj74Wo/tS9S
 GMVgAD8YvR5xkRyz7W8wk0fFoWVn+Qw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-IHHeLnvBPHCjTLkKKDwoQg-1; Fri, 16 May 2025 03:47:45 -0400
X-MC-Unique: IHHeLnvBPHCjTLkKKDwoQg-1
X-Mimecast-MFC-AGG-ID: IHHeLnvBPHCjTLkKKDwoQg_1747381665
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-440667e7f92so9520215e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 00:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747381664; x=1747986464;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7IHi2JoajN6y8n/tT9OYiAX9fqR8ZvSlGeEMZmH6v6U=;
 b=YAlFcFH6BAF9ljZ8BTiPBTLIQ2ZApg+WBsez2kn2afsTcMGUE6t4jDdCUzkH1Ll3EF
 VpgEPw9HsbTOkdjmGsbB/BsuUYcsIqVQZhzjwOR90qPLbeDzuXM2m7GgHpVaiIeeFihn
 DHGuXpov2x5R2KQ/P4CljzArx2nTM8gOHMh3VbExouRdeCOuXv9BDoZ676mpTJ9FvoHA
 Q5kRs7BuNbbSyO4Me2Otn4QMaU0HlKeyUmL3WwZBS10mu5kfw8J+3v4blXHtbi35jSU/
 NblW2UnQjuaFlcz/Xal7R7bT7fACefRd8jqx3I/xqWj6bc6wWpXOxDGdlGCCk01agSWW
 pyKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNJ4i9+I/ClXaMOaCh1CCqdm2mdQXogmkUkg5EbOb57xfsnbeGIkx2TAyDn7WoZ0ewN8Ihz1Mc4toK@nongnu.org
X-Gm-Message-State: AOJu0Yy+Ff9lniDvVVmtprDlfFaqLX0P+xLsxwGRMhPYoxy0Vwtru0JI
 pUR+ocf/pd0Ps7mHk31EEw0rb/tGMxIQrxOPSKTfKaYnbVO+j5/jBKRPDfpF6jjRj9FTfxpt8+t
 wdu36nFmd4gOLsOKrHIBJKXK4sqUDperc5ssnko9nCz4IXshJ/ijcoIzG
X-Gm-Gg: ASbGnct0UUc5OVmyERdEpsxFs5UNfdGhLT3gbKQIK94HjU+4o8kqj8zFXtpDVPWh/9x
 9ZWg6k++DYu7IdR58H6XcsHHdIiQE6Caoa4h3tgaSav4cuAZZCyeWoolTesCd3nbB7t6brI6coy
 /OshbmimkVXCjVQRIHnLURKgAHTj8UIglZ8V96N4HdFPG8nYn15dqPX5M8N+io/U/mMwfz8Wu2I
 VRD8PmP+jAep8FSiw2oMEVt6Lh44EHGrv8B7GlFWP6b0//lFo/Bm5oN0PFww0PIIN6FjdcwXTRF
 MSZ/ptxGyQjkD6DRsrm7tPv/Gt+6wbkiyFmzFIh6sQGjKbrscH6Dwu7JfsHclurRgO+h3xO2Goa
 stGSBrHmZFmC7/7+xgBp3orSiD1IowpcczdIz2zU=
X-Received: by 2002:a05:600c:3114:b0:439:6118:c188 with SMTP id
 5b1f17b1804b1-442fd63c6f6mr18502075e9.19.1747381664689; 
 Fri, 16 May 2025 00:47:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES3YeWi3Ip3CwTZobDsOrW8KY2q9hLWMgcfhBv1Im/wcP74LKzoNXFEcqg5CPNF+BdLpxAig==
X-Received: by 2002:a05:600c:3114:b0:439:6118:c188 with SMTP id
 5b1f17b1804b1-442fd63c6f6mr18501835e9.19.1747381664328; 
 Fri, 16 May 2025 00:47:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:4700:e6f9:f453:9ece:7602?
 (p200300d82f474700e6f9f4539ece7602.dip0.t-ipconnect.de.
 [2003:d8:2f47:4700:e6f9:f453:9ece:7602])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd583f3dsm23755035e9.30.2025.05.16.00.47.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 00:47:43 -0700 (PDT)
Message-ID: <d864bd65-a6cd-4190-8350-65aa9817c44e@redhat.com>
Date: Fri, 16 May 2025 09:47:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] target/s390x/kvm/pv: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
To: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-9-zhao1.liu@intel.com>
 <e0146386-ccf4-44ba-b58f-0bb4d3317f89@redhat.com>
 <aCS8aHsF+VAuj01D@intel.com>
 <7dec9c8e-93d6-81f0-b075-e29b8ede44a2@eik.bme.hu>
 <aCXxHEVZb8+ZCW/m@intel.com>
 <c2466a27-8f8a-780d-ff78-491921bb41e5@eik.bme.hu>
 <aCYSTHiXtBsjw510@redhat.com> <aCavqdZ/PI461DDe@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aCavqdZ/PI461DDe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 16.05.25 05:23, Zhao Liu wrote:
> On Thu, May 15, 2025 at 05:11:56PM +0100, Daniel P. Berrangé wrote:
>> Date: Thu, 15 May 2025 17:11:56 +0100
>> From: "Daniel P. Berrangé" <berrange@redhat.com>
>> Subject: Re: [PATCH 8/9] target/s390x/kvm/pv: Consolidate
>>   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
>>
>> On Thu, May 15, 2025 at 05:41:40PM +0200, BALATON Zoltan wrote:
>>> On Thu, 15 May 2025, Zhao Liu wrote:
>>>> On Wed, May 14, 2025 at 06:24:03PM +0200, BALATON Zoltan wrote:
>>>>> Date: Wed, 14 May 2025 18:24:03 +0200
>>>>> From: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> Subject: Re: [PATCH 8/9] target/s390x/kvm/pv: Consolidate
>>>>>   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
>>>>>
>>>>> On Wed, 14 May 2025, Zhao Liu wrote:
>>>>>>>> +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(S390PVGuest,
>>>>>>>> +                                          s390_pv_guest,
>>>>>>>> +                                          S390_PV_GUEST,
>>>>>>>> +                                          CONFIDENTIAL_GUEST_SUPPORT,
>>>>>>>> +                                          { TYPE_USER_CREATABLE },
>>>>>>>> +                                          { NULL })
>>>>>>>
>>>>>>> I'll note that existing callers of OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
>>>>>>> happily ignore the line limit and put it into a single line.
>>>>>>>
>>>>>>> (which ends up looking better IMHO)
>>>>>>
>>>>>> Ok, I'll onor the existing conventions (which I'll apply to other
>>>>>> patches as well).
>>>>>
>>>>> There are two line limits. If something is clearer on one line you could
>>>>> exceed the normal 80 chars and put up to 90 chars on one line for which
>>>>> checkpatch will issue a warning that can be ignored for these cases. Over 90
>>>>> lines checkpatch will give an error and I think you should not ignore that.
>>>>
>>>> Thank you. This makes sense!
>>>>
>>>>> Maybe try to put as much on one line as possible instead of new line after
>>>>> each argument but without exceeding the 80 chars or if the whole line fits
>>>>> in 90 chars then use that. Or maybe do not indent second line under ( but
>>>>> with 4 spaces then you can fit it in two lines but lines over 90 chars are
>>>>> undesirable.
>>>>
>>>> HMM, I understand you mean:
>>>>
>>>> OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(S390PVGuest, s390_pv_guest,
>>>>     S390_PV_GUEST, CONFIDENTIAL_GUEST_SUPPORT, { TYPE_USER_CREATABLE }, { NULL })
>>>>
>>>> The second line is 82 chars and now I think this version is better.
>>>
>>> Yes and maybe can even fit in 80 chars if using { } instead of { NULL }.
>>
>> Personally, once you have to break the line, I would be inclined
>> to have *nothing* after the '(' on the first line, and then break
>> at the list of interfaces. ie
>>
>>   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(
>>      S390PVGuest, s390_pv_guest, S390_PV_GUEST, CONFIDENTIAL_GUEST_SUPPORT,
>>      { TYPE_USER_CREATABLE }, { NULL })
>>   
> 
> This version looks better! Thank you all for your patience.
> 
> (How to elegantly break lines is indeed a matter of taste, and I've
> improved in this area now with your help :-).)

Sorry for starting this :) And thanks for your patience.

Back when I added a OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES, I did it 
just like everybody else:

Cram it all into a single line because it's all unbelievable unreadable 
already, no need to fake that breaking lines would improve that in any 
way ...

-- 
Cheers,

David / dhildenb


