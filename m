Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C71FC02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 14:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXhUR-00087T-Gs; Tue, 14 Jan 2025 09:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tXhUO-00084D-Ry
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:01:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tXhUL-0002tT-EV
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736863308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5LiaySr94zDavTpMpv+RjEQ4WEDWDc58/LIfFci8ZtY=;
 b=UKUb0g7wYICr807f7pREaRKKfXDp9fgC1k4emaBhmLFDDj1S/rWouWMxfLQhB9q2RmP61L
 niNgVNaZaadZ3cWNXZH2ImDUykZsjU61HvrPoOQPFoj5mQ7nHvPMC7SX8t4tF7OCI7Iw8Y
 PAUY5RgFLEnRnVg5l/1emY+P4WkCfYs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-pU0BXI6sNYOTI4rOxu3WZQ-1; Tue, 14 Jan 2025 09:01:47 -0500
X-MC-Unique: pU0BXI6sNYOTI4rOxu3WZQ-1
X-Mimecast-MFC-AGG-ID: pU0BXI6sNYOTI4rOxu3WZQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385dcadffebso2675149f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 06:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736863306; x=1737468106;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5LiaySr94zDavTpMpv+RjEQ4WEDWDc58/LIfFci8ZtY=;
 b=SFvhuSeKpgoZyas0LZTaz1xV77Ovs78Twah5saykSr2DTwM+1VcPtdjIfSiCK2pdq8
 DR0V2KoA1xyAQVbKgH2bHKVt5FLWutXk0LiUVw8w/bWLNBszeG0I/ffi5J3cnEmEnzsB
 rueRiwybIux1U8LeBsal0302oBH/kiMnurGlSfKY333byBQ887GgQXH6tnWbOP6hc3Sq
 XQIbHUlKndh51SVdKMwmsxOW/TE2YbKxX1KGsajP6z2EujRk7GPisZI2fqMD98ddyy0h
 1UIDkxWjYtqt9oYmhWnpNWvGPxAzNs/q+5yBHBINbJ88Ymjf/GsANOXWfJb9hSuE6OH0
 ki/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpw5kWDlB0zxgxewI7DvP7V4fpTcppOjrusMqU0WLxFpZq4o471TVU6BSZkmEWJGaSc2V75ci08EOA@nongnu.org
X-Gm-Message-State: AOJu0YzTdeoPUVk59a0aQV0YHKG7v5YwlS4nHyJFesIthX4FC3DJ0jqQ
 ej/nXkOlBWTFexIy+kR95nyBHuKa7xuHJ9VzXRfIJ7YPjE32eGdMu4L+S+yEsM+LvMg4Uo/pSk4
 3oGS7DM2DdJY8N2j8DAMlZl7KBgC5qsL8NFxe8UcGEVD0gBlJfHfk
X-Gm-Gg: ASbGncskoK2e5HYsE0KDwIQCLxvkaCcG+nbkx2AvgAR3fvV4EX2Fhagh+KLLq6pISpQ
 Ec9Z2UXjFT0pv4LuqjiEnsvj/bpbd69/+Bwpg0ZOoCHZ0jsMpvkkhRyAQcN4/JM+tqfdiMdO1DE
 2bmJthQ63M+G2aUuQEtf9GiGo+ucbAAGwlJOYCTcdKjabPk4sJcyhOs76GZJKf/6ARGzPP02vnU
 wV9PQvVp8N+NZqr5x2RKtFLtFMkOM/g9WYvX2Xsxnt4fGjRBsX7+vkpfdYh2sxjbXvih3OI6LxV
 Rr5tjgC6H6Fio4GZBY2zaRd44bZPrAX6fbNod3QrZvIb6XoQiuYTujMjYmdVjayMs9TKNgyTbDo
 oZwoUdKge
X-Received: by 2002:a5d:64e2:0:b0:38b:e32a:10ab with SMTP id
 ffacd0b85a97d-38be32a13a4mr1543604f8f.9.1736863304434; 
 Tue, 14 Jan 2025 06:01:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1IQu7Zm9/XDgYD1XGvNzRJ4NlPuB0JZEzpzJrrtSb6wLsy+lwUAThfh1kfVWfyLnsa4VAFQ==
X-Received: by 2002:a5d:64e2:0:b0:38b:e32a:10ab with SMTP id
 ffacd0b85a97d-38be32a13a4mr1543559f8f.9.1736863303910; 
 Tue, 14 Jan 2025 06:01:43 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa?
 (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de.
 [2003:cb:c738:3100:8133:26cf:7877:94aa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38332asm14738420f8f.23.2025.01.14.06.01.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 06:01:43 -0800 (PST)
Message-ID: <120b94cd-e0c8-41a6-9afb-2e3fad477454@redhat.com>
Date: Tue, 14 Jan 2025 15:01:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] system/physmem: Memory settings applied on remap
 notification
To: William Roche <william.roche@oracle.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20241214134555.440097-1-william.roche@oracle.com>
 <20241214134555.440097-8-william.roche@oracle.com>
 <e13ddad7-77cf-489b-9e32-d336edb01c85@redhat.com>
 <fe018270-5c2f-4b13-9254-aa047fc48ccd@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <fe018270-5c2f-4b13-9254-aa047fc48ccd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10.01.25 21:57, William Roche wrote:
> On 1/8/25 22:53, David Hildenbrand wrote:
>> On 14.12.24 14:45, “William Roche wrote:
>>> From: William Roche <william.roche@oracle.com>
>>>
>>> Merging and dump settings are handled by the remap notification
>>> in addition to memory policy and preallocation.
>>>
>>> Signed-off-by: William Roche <william.roche@oracle.com>
>>> ---
>>>    system/physmem.c | 2 --
>>>    1 file changed, 2 deletions(-)
>>>
>>> diff --git a/system/physmem.c b/system/physmem.c
>>> index 9fc74a5699..c0bfa20efc 100644
>>> --- a/system/physmem.c
>>> +++ b/system/physmem.c
>>> @@ -2242,8 +2242,6 @@ void qemu_ram_remap(ram_addr_t addr)
>>>                        }
>>>                        qemu_ram_remap_mmap(block, vaddr, page_size,
>>> offset);
>>>                    }
>>> -                memory_try_enable_merging(vaddr, page_size);
>>> -                qemu_ram_setup_dump(vaddr, page_size);
>>>                    ram_block_notify_remap(block->host, offset, page_size);
>>>                }
>>
>> Ah yes, indeed.
> 
> I also merged this patch 7/7 [system/physmem: Memory settings applied on
> remap notification] into your patch 6/7 [hostmem: Handle remapping of
> RAM], removing also the unneeded vaddr.
> 
> So now we are down to 6 patches  (unless you want me to integrate the
> fix for ram_block_discard_range() I talked about for patch 2/7)
> 
> I'm sending my version v5 now.

Sorry for the delayed reply to v4.

-- 
Cheers,

David / dhildenb


