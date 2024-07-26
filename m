Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C532C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 19:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXR4R-00004y-LU; Fri, 26 Jul 2024 15:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sXR4O-0008VI-0X
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 15:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sXR4L-0002gd-Ps
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 15:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722023856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2EWKVSASi+6+EBoOpHsqj4q37i1KyDvOiyE7Jc/4eJU=;
 b=LO3yJy5j0KMe0XeomQ954HTk+pLrG/7TuwA/AUEOpIfxx+dRF/b/yEHfitWy+/jVOY+7Ni
 SegknC9sBNolAsMbR5ncaSbbxqPES9wJdbFn5D2jr3tz7VHxjmsnsA0BuMK3+WRk/0bFhG
 QCk1uxwUEiQ9iW7LRjXABbztkubnuGI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-JFxGbvCpNf6Fwl3RLdR4iQ-1; Fri, 26 Jul 2024 15:57:34 -0400
X-MC-Unique: JFxGbvCpNf6Fwl3RLdR4iQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4280291f739so115515e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 12:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722023853; x=1722628653;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2EWKVSASi+6+EBoOpHsqj4q37i1KyDvOiyE7Jc/4eJU=;
 b=WKkwOiCPbtCiBdxnoJQ5deCAcHzU4dyECoPXkiTfuMVCqNqvqvFovW7c/bQ4pHKOG7
 Y5w5Cux5kwqBl02hgn/+0Mp3wMdE412M6wwGWOXsPr0BPrxHDY7fU77K9fyG+KBI+zo7
 rDzCCQI2uvTMWtern1uMGSTSCaYTapOE3qYoGv/YcTiQ1uFWXuMhPo2pZLwZerF5VHvL
 XX2+38QCoY55ZFLz0jiIJVnp7/vX5S2SoTsRd4DF1/6lg1AgvzHqfhjTP9Vpt4RieTUT
 8wncd0l6MOV81sXwkVaUu7/2iqORb+p2Y3/DJCkhL0uf6ppw1EhGpzBrLabXBDiH8H8Y
 2RjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1VUu6UKWHClu/hq+WIdsi4cx+bATU9fWKajsvL5GvZw0gbGqRHxltl2zgCwwQoyHQhbFhlxNY5/H7tflOUXKIlxTjxPs=
X-Gm-Message-State: AOJu0Yx7VM0zhNWZsnfln1zRsK2RckyiQb0zY106dEvzHPK/XtBeTtZg
 m0MiTGO/3Sdhmj5jKhSesZ1GrWCXXfTcp8iutfDoD9dddFCuMYAClOoBUimZXo0UtxRgQcNW8bc
 bDXNuRImE/qnotszfFJidZ416PbeYMMHCGn8GHuOrXjAmFpTO1O+Y
X-Received: by 2002:a05:600c:2d53:b0:426:59fc:cdec with SMTP id
 5b1f17b1804b1-42811da1b88mr4117425e9.21.1722023853392; 
 Fri, 26 Jul 2024 12:57:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHca4IrHU+3sBQnbZ3lhoLEm8PKDjpqkXnrVu/E4SbqRBehzkKq7FqxoOGDj9H0TQZDBVFsnw==
X-Received: by 2002:a05:600c:2d53:b0:426:59fc:cdec with SMTP id
 5b1f17b1804b1-42811da1b88mr4117305e9.21.1722023852965; 
 Fri, 26 Jul 2024 12:57:32 -0700 (PDT)
Received: from [192.168.3.141] (p4ff238dc.dip0.t-ipconnect.de. [79.242.56.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428054b9196sm89371445e9.0.2024.07.26.12.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 12:57:32 -0700 (PDT)
Message-ID: <6f7b3367-4f13-44f0-8a04-f2be798e7bd3@redhat.com>
Date: Fri, 26 Jul 2024 21:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] target/s390x: filter deprecated properties based on
 model expansion type
To: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: thuth@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com,
 Jiri Denemark <jdenemar@redhat.com>
References: <20240725183909.24144-1-walling@linux.ibm.com>
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
In-Reply-To: <20240725183909.24144-1-walling@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On 25.07.24 20:39, Collin Walling wrote:
> Currently, there is no way to execute the query-cpu-model-expansion
> command to retrieve a comprehenisve list of deprecated properties, as
> the result is dependent per-model. To enable this, the expansion output
> is modified as such:
> 
> When reporting a "static" CPU model, the command will only show
> deprecated properties that are a subset of the model's *enabled*
> properties. This is more accurate than how the query was handled
> before, which blindly reported properties that were never introduced
> for certain models.
> 
> When reporting a "full" CPU model, show the *entire* list of deprecated
> properties regardless if they are supported on the model. A full
> expansion outputs all known CPU model properties anyway, so it makes
> sense to report all deprecated properties here too. This allows
> management apps to query a single model (e.g. host) to acquire the
> full list of deprecated properties.
> 
> Additionally, the @deprecated-props array has been moved from the
> CpuModelInfo struct to the CpuModelExpansionInfo struct, since the data
> did not belong in the former.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Jiri Denemark <jdenemar@redhat.com>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
> 

Hmmm, this does not apply on current master ... maybe because Thomas 
already merged part of it?

-- 
Cheers,

David / dhildenb


