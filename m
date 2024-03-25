Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1A4C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 16:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ronAf-00043P-Fo; Mon, 25 Mar 2024 12:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ronAe-00043G-DU
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 12:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ronAd-00022y-1Z
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 12:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711384053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZkMZkG2aomE7MUzFBDgGRZJTzRULe26C3lyNLaGMmwE=;
 b=JPd/kRsaGiXxBoNMu10YIudPlktYsNu1ndg2Ek9JHiGEE3gbetzZHTbcl+LNDvqmM2zFTh
 veOq1KGxkOkS80K3hUINT9oF+LV3GbfQtGk6zCr9s/rRrqKxCHD0AZz1EaAZm6Hoara0Jq
 aHNbkiukgDZdLNJh191ONPa+ay6kSNw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-lyJVfJULOA2glSYvz6U_zg-1; Mon, 25 Mar 2024 12:27:31 -0400
X-MC-Unique: lyJVfJULOA2glSYvz6U_zg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33ed44cb765so2576517f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 09:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711384050; x=1711988850;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZkMZkG2aomE7MUzFBDgGRZJTzRULe26C3lyNLaGMmwE=;
 b=jG59tm2bOuVF0AjVzxpvJQvee7qcFt90lRE12+uy4XHpIP8Yo1tlFy0PI4fuCcCT/b
 90BS5xXY+eOWf4CZQRrvWzdt6pg1GLeIId6MAcNwe1oyFoElsEcd4FJtUTk1vujietJ1
 kJVCCeNatofoRTVTQwJLLW/YWlGVNWNiV1vK/rEuSU7EwooMHicW9d94Mlrs7/vbsU6j
 7ze5e+9IZY/ETrutlUyd862szvmXcCRgCxUL5lqpOAji0rpC1OOk4Dnrgvr1MHYZkQxO
 XDoxZLLHYXVtCFw1NTy4GoYIvgn4VFTLXYsmH+3IO9+BJWEGgNXMyUfae07kOeIYQhrJ
 J5NQ==
X-Gm-Message-State: AOJu0Yyq9utH78ZYtqmghRIV92anNP9dr+y51ae/CiYgoMgdTExEZ5ci
 gxjl3TcTD7oxPqnQQn1sO3FNqQ6goe3JVjawvMRjjHpVPOlcaUobRGbzQpF2NugDVn1NASs0vl6
 fjtWxPGsKaTqIt7mGBetZwQygf93zpQQuMTE7QzgdsDAIBmFvFW9S
X-Received: by 2002:adf:ca09:0:b0:33e:c974:1290 with SMTP id
 o9-20020adfca09000000b0033ec9741290mr4668375wrh.18.1711384050282; 
 Mon, 25 Mar 2024 09:27:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuMabsGkQ3cCOmQWl4gpBYnDwZio1mZoLTYYyEPP3YmW4rZP3Z9mfA+eHPRVBQV3Atd1C7eg==
X-Received: by 2002:adf:ca09:0:b0:33e:c974:1290 with SMTP id
 o9-20020adfca09000000b0033ec9741290mr4668355wrh.18.1711384049908; 
 Mon, 25 Mar 2024 09:27:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:b400:6a82:1eac:2b5:8fca?
 (p200300cbc738b4006a821eac02b58fca.dip0.t-ipconnect.de.
 [2003:cb:c738:b400:6a82:1eac:2b5:8fca])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a056000054700b0033e7b05edf3sm9892571wrf.44.2024.03.25.09.27.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 09:27:29 -0700 (PDT)
Message-ID: <1e03601d-f55d-4527-8382-d884d226bd50@redhat.com>
Date: Mon, 25 Mar 2024 17:27:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] qapi: document parameters of query-cpu-model-* QAPI
 commands
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20240325150141.342720-1-david@redhat.com>
 <87edbyjp0x.fsf@pond.sub.org>
From: David Hildenbrand <david@redhat.com>
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
In-Reply-To: <87edbyjp0x.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

>>   #
>>   # Usually, a CPU model is compared against the maximum possible CPU
>>   # model of a certain configuration (e.g. the "host" model for KVM).
>> @@ -154,7 +155,14 @@
>>   # Some architectures may not support comparing CPU models.  s390x
>>   # supports comparing CPU models.
>>   #
>> -# Returns: a CpuModelBaselineInfo
>> +# @modela: description of the first CPU model to compare, referred to as
>> +#     "model A" in CpuModelCompareResult
>> +#
>> +# @modelb: description of the second CPU model to compare, referred to as
>> +#     "model B" in CpuModelCompareResult
>> +#
>> +# Returns: a CpuModelCompareInfo, describing how both CPU models
> 
> Scratch the comma?

Agreed to both. Do you want to fixup when applying or do you prefer a v2?

Thanks!

> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

-- 
Cheers,

David / dhildenb


