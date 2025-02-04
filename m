Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1467FC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKTY-0007c1-RV; Tue, 04 Feb 2025 10:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tfKT1-0007FG-JY
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:04:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tfKSz-0003xi-MG
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738681436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bi+h1pfkI3Yz+In5LeSmtYdOhUO5gYb8aHUxN7Kbcg8=;
 b=d4XPhCmT0bqXR/hcJ0WduNKiNtgpxnA6/9GR0MdFFCj3Of4msPutsJW+zMvJGlY8ZCj730
 +TuHtK5uXDGJ8eg6AW+md6r9GTkErOUPtSfXzJuC4P+9NFgWnacSrXfG+eKx+LKdw+MTOR
 p9gD94U8gnsX0X2JQsuaUBczN0VTOQk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-tubFqFnxMEenF-lRCckY8g-1; Tue, 04 Feb 2025 10:03:52 -0500
X-MC-Unique: tubFqFnxMEenF-lRCckY8g-1
X-Mimecast-MFC-AGG-ID: tubFqFnxMEenF-lRCckY8g
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so40361585e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738681431; x=1739286231;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bi+h1pfkI3Yz+In5LeSmtYdOhUO5gYb8aHUxN7Kbcg8=;
 b=R73QQHZ4AisTRsQVEy+pM7b1Fs9S0Mb3VL1YmSlts7dc+QFnakLSwesLBl1j5cKjLd
 V5lNqM5R4JnXHZBA/KHCfwUZtkbVBTXWxWWacRH3iVIMJsPJtdybuzKmEn66UDZU6h7m
 9WYLFQEQNo42+HBCU0Gc0FqYSh94Os5ubOFGAlzPjXqjI/sgIDHTEA8fsagZVcLL+thF
 FEPzWe5BpOzqiNnUHZ586q/uIMYQGMq4VuV9tncAnUz3CuuuWlk28CKFZRDMoikiDIS5
 uH50lJDAWMvUfPRYrEqEgYVv1LEUFPCtHgqFTDlxNF1QteFREnLofeUc2ZUBMpiZWSx5
 TqEQ==
X-Gm-Message-State: AOJu0YzeIS9ol3gFVhtuyY8LxTM1EkjfKt8q4q6sW2T1U5hR5XkH4uQX
 geTuqv4VGujLZYxjc8sjaLU2b+hNDKanlhvAZv+PSGYS9YMELOvAMQve6/VA8OrRfdF4msM57fq
 uHVJiGSrEAZz6dmLkHQt6ImY0Ec1kR04KseuxJnQvWUR5RXaBdyUI
X-Gm-Gg: ASbGncuDV5GXBIoKGsYkJwctgtIn98gODKLSfqH9gr/anKT1wPC5nCK2Uqg9dlrD418
 Z3pIZN236VT6NHBUALgMWJjjF9Bvius1ZOMkf+c/uOXwLeT+7w4ah8vs+5Pe7GTfn6nF2bX9m7p
 8QN+xOlJ5tQt4JRVVMYDcNiTqDov6RyWpSdbpr0ZA0yp8a2To3IOP/+k2WmvBRzew+E+BATqVSK
 JPM/SNWEns+TdTPrpd7TP4htFWxvS62u6+H20R5ghR0kV4eysqe07rImn3qH99min+mCeVjr0Di
 KsByUza39WU1NTW9Z60PLuH63IDSr8+YXJAiHOHpfdPJUNYW7YlbQ8a/Ck/D0/jINsGYdp3BYA3
 mNv8GpX/W4Z/+tebzz6DHZGd0asU=
X-Received: by 2002:a05:600c:3556:b0:436:8a6f:b6db with SMTP id
 5b1f17b1804b1-438dc40d74cmr196856985e9.22.1738681430616; 
 Tue, 04 Feb 2025 07:03:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEx/sNVQuMkjJbA/BtUe+G1e+VGcctM5tropfwP3oS7qzV4fvvME3Zys7MaH+oxE7fBb7/fwg==
X-Received: by 2002:a05:600c:3556:b0:436:8a6f:b6db with SMTP id
 5b1f17b1804b1-438dc40d74cmr196856375e9.22.1738681430108; 
 Tue, 04 Feb 2025 07:03:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c70a:300:3ae1:c3c0:cef:8413?
 (p200300cbc70a03003ae1c3c00cef8413.dip0.t-ipconnect.de.
 [2003:cb:c70a:300:3ae1:c3c0:cef:8413])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc265c0sm227873895e9.10.2025.02.04.07.03.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 07:03:48 -0800 (PST)
Message-ID: <715ae765-81c6-4ab4-a00b-c98a9863ffac@redhat.com>
Date: Tue, 4 Feb 2025 16:03:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] physmem: teach cpu_memory_rw_debug() to write to
 more memory regions
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
References: <20250124154533.3534250-1-david@redhat.com>
 <Z6DzfFvgXw9AQs8p@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z6DzfFvgXw9AQs8p@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 03.02.25 17:49, Peter Xu wrote:
> On Fri, Jan 24, 2025 at 04:45:25PM +0100, David Hildenbrand wrote:
>> This is a follow-up to [1], implementing it by avoiding the use of
>> address_space_write_rom() in cpu_memory_rw_debug() completely, and
>> teaching address_space_write() about debug access instead, the can also
>> write to ROM.
>>
>> The goal is to let GDB via cpu_memory_rw_debug() to also properly write to
>> MMIO device regions, not just RAM/ROM.
>>
>> It's worth noting that other users of address_space_write_rom() are
>> left unchanged. Maybe hw/core/loader.c and friends could now be converted
>> to to a debug access via address_space_write() instead?
>>
>> Survives a basic gitlab CI build/check.
>>
>> [1] https://lore.kernel.org/all/20241220195923.314208-1-git@zabka.it/
>>
>> v1 -> v2:
>> * Split up "physmem: disallow direct access to RAM DEVICE in
>>    address_space_write_rom()" into 4 patches
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Alex Bennée <alex.bennee@linaro.org>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Eduardo Habkost <eduardo@habkost.net>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Cc: Jagannathan Raman <jag.raman@oracle.com>
>> Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
>> Cc: Stefan Zabka <git@zabka.it>
>>
>> David Hildenbrand (7):
>>    physmem: factor out memory_region_is_ram_device() check in
>>      memory_access_is_direct()
>>    physmem: factor out RAM/ROMD check in memory_access_is_direct()
>>    physmem: factor out direct access check into
>>      memory_region_supports_direct_access()
>>    physmem: disallow direct access to RAM DEVICE in
>>      address_space_write_rom()
> 
> IIUC the last patch will stop using this for debug path anyway, so I'm not
> sure whether this one is still needed.  The hope is it's only used to
> modify real ROMs?

There are still some remaining (other) non-debug users of 
address_space_write_rom(), such as hw/core/loader.c.

We could likely remove address_space_write_rom() by adding another 
"ignore-non-rom" tx flag, or allow for writing non-rom.

I'm not doing that as part of this series, though.

> 
>>    memory: pass MemTxAttrs to memory_access_is_direct()
>>    hmp: use cpu_get_phys_page_debug() in hmp_gva2gpa()
>>    physmem: teach cpu_memory_rw_debug() to write to more memory regions
> 
> Still, I can't think of anything harmful of patch 4.  So nothing I see
> wrong..
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!

-- 
Cheers,

David / dhildenb


