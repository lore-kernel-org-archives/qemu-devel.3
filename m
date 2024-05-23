Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E508C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9xS-0001MA-Ba; Thu, 23 May 2024 11:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sA9xQ-00013c-EG
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sA9xO-0004zi-LG
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MaCTFtf6DOSs05csWYBqXWMVWQDGstGUYLGm/TvbN1U=;
 b=VHd/fKVQbNzmEc9NuOGWAYP63dCPxz0mN4fSIT+QKVAoXKJ3IY8A/ZSt8tQMTDiQOgR+SH
 ErNfkf1apXY6e1kW6OIjGc4jlzHwXmLItvja2vThIarPk9crCqbcBwkGBMhnEsq764zmTg
 HoupZA5zwv7LZVyhifs6MiJ3Pv6Lb2g=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-mpfsl2PiOHO1oANXgxsp8g-1; Thu, 23 May 2024 11:02:12 -0400
X-MC-Unique: mpfsl2PiOHO1oANXgxsp8g-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2e9589df409so731541fa.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476531; x=1717081331;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MaCTFtf6DOSs05csWYBqXWMVWQDGstGUYLGm/TvbN1U=;
 b=gLDkIL7xV1ayL+eHJTzvyeTzXiAwwSdsNpjTVIgT2NqrvPl9JViWq33s8QcWlq/5ki
 woErymr84gse3Jey+YG9Dr5tD4K9lLxGgY/48bsbyWPoJwBZLLfXt1MnFicHpyEXcLFz
 /XWukgx9RR/LtaeuA5pati0bqJ8Wieq3M8ujezH6ieLI/h8tWBWz7Axlt7EEMthmCfEQ
 5jLeEyqLWTVuBS0+/yz03RPlBqivetOKILI87Te4l9DY9ybByrHXgM/+xA60R2ZJNjPJ
 JKOGVzM3O3MUA0mcnQtf1hGlZ2yyABnVHLscxFfzVfPizMYj5jFMWScuOTWOCdtpI7Gw
 eUqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlVB/hJW9vLqFgJvA0pJ56UM6/jK1/VINWVImYptd7uASKXhBoMpoqv+08HqE6szspanoW2q5qtJM0uxG0aVTYdcdUhMU=
X-Gm-Message-State: AOJu0YzulmNZTx9+VDva39so5GyLXlCTd6Sk+fu8p3mvnYaBO7eC4D28
 9PPFOg362oYyJwCE43Vi28Dpt3XMQelO6VxlnSclXEkcY/kKsY5VM7cWL0zd6C7FybFMcsGgdov
 zFMQXtwkmP73Fj5uuF3RhQ3VPCUAanb2cBDieo0MgIGOql5oWIQzf
X-Received: by 2002:a2e:a549:0:b0:2df:b7cf:9607 with SMTP id
 38308e7fff4ca-2e9494f2a5bmr41759291fa.22.1716476531245; 
 Thu, 23 May 2024 08:02:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTZWTuOZt8qZoV0qN+MAIn5YyTxL/CJAAlWmq2uPPVH5xz+vgv1PjqfOQ6Gh6USFDdsXO+dQ==
X-Received: by 2002:a2e:a549:0:b0:2df:b7cf:9607 with SMTP id
 38308e7fff4ca-2e9494f2a5bmr41757671fa.22.1716476529324; 
 Thu, 23 May 2024 08:02:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:5f00:c949:6700:cce1:e60b?
 (p200300cbc7175f00c9496700cce1e60b.dip0.t-ipconnect.de.
 [2003:cb:c717:5f00:c949:6700:cce1:e60b])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2e4d16200f4sm43289701fa.118.2024.05.23.08.02.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 08:02:08 -0700 (PDT)
Message-ID: <c6b56c83-4a25-40fd-b905-9b11f74e040e@redhat.com>
Date: Thu, 23 May 2024 17:02:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/13] contrib/vhost-user-blk: fix bind() using the
 right size of the address
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, gmaglione@redhat.com,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20240523145522.313012-1-sgarzare@redhat.com>
 <20240523145522.313012-6-sgarzare@redhat.com>
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
In-Reply-To: <20240523145522.313012-6-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 23.05.24 16:55, Stefano Garzarella wrote:
> On macOS passing `-s /tmp/vhost.socket` parameter to the vhost-user-blk
> application, the bind was done on `/tmp/vhost.socke` pathname,
> missing the last character.
> 
> This sounds like one of the portability problems described in the
> unix(7) manpage:
> 
>     Pathname sockets
>         When  binding  a socket to a pathname, a few rules should
>         be observed for maximum portability and ease of coding:
> 
>         •  The pathname in sun_path should be null-terminated.
> 
>         •  The length of the pathname, including the  terminating
>            null byte, should not exceed the size of sun_path.
> 
>         •  The  addrlen  argument  that  describes  the enclosing
>            sockaddr_un structure should have a value of at least:
> 
>                offsetof(struct sockaddr_un, sun_path) +
>                strlen(addr.sun_path)+1
> 
>            or,  more  simply,  addrlen  can   be   specified   as
>            sizeof(struct sockaddr_un).
> 
> So let's follow the last advice and simplify the code as well.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


