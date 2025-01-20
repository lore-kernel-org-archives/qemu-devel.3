Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E01EC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 18:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZwo7-0007f9-2P; Mon, 20 Jan 2025 13:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tZwo5-0007en-L9
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 13:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tZwo3-0008Mq-DP
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 13:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737398845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=J+iNXCU7mhQ3xjPD9HDDS+af++ea/Ik8vEVIaiKhR6c=;
 b=gwKsmMCIft8CFHq3UAMa3SJjTZPRSsu5CBBmWJL217zWLH9bD6eEOlOdW18DGP16vGfRts
 Spb8AkOp4MR+0CBu5Os4X3d9/4bqSE9mw3HLAfwOCC9aqfAU0kdvlv9ROFi/SSmtEQtuCE
 LpwCGTHm2jvD6L8vkWKL6qRzSbJftzc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-MjUY7kxyPQOVpYk9h7sYQw-1; Mon, 20 Jan 2025 13:47:23 -0500
X-MC-Unique: MjUY7kxyPQOVpYk9h7sYQw-1
X-Mimecast-MFC-AGG-ID: MjUY7kxyPQOVpYk9h7sYQw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4362b9c1641so23345095e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 10:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737398842; x=1738003642;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=J+iNXCU7mhQ3xjPD9HDDS+af++ea/Ik8vEVIaiKhR6c=;
 b=Ewdw9vqUzJPu0LJzalW6+z0kshZzCIfZr+KwlXjQy0+Ez1bjWnqgi2ihkECKPlCBNk
 ikqiLmhAJlVQ4/p8PD6xnqdlMY/M3N5OkUsaoV5Bqi4LizA5Ran8skxKjzLP3Gk2si07
 wIrM0k1hiccKImLVwGGf2Lugjr8lBHB75zd1RgVYg7bcazpzmUqPPbBSrkY2XrCnSECI
 xqH0E8AV9jGKO1Why0WUOnWG1dISW3KMsa/qypOyjnhET5qFuwc8z7NdmDGna6RPUgx/
 1idDz9TZJYVrFsLPO1QWCDWNQ2sN/SBxxQK7RoibAw5m+cRocH3qIqqtE1sBdlq8FIf0
 vDZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn+cKqCKBVFqYbB94DRX7+UQOfNLf6GtXauOQO28+taTQltAo6L5Ti+mcW43yZ/fXmkybd/4dbuuOs@nongnu.org
X-Gm-Message-State: AOJu0YxGONof3G4ZMdrSw2K/kYNAK1y3ScOJvjQFf1aic47QEPRkT1GU
 vQABZHth2ICvyW8rEE/9o5JuiK9Q2oDFIToEA8zy8Kg+Q5bUS8V8W//N7ZFbdqsvwvK3CZBP1pA
 iVpOVIPYyQy4+uBd2Fm39c29fcBVUDF2krnkt2WFDAd3WjStIi3lx
X-Gm-Gg: ASbGnctyAL4zHvMHzSDQ5fzZLM+w2GmQOVpOec/9QJD1xnon6sdkENSgHuc9x31q9Iw
 08s0O7X4Io1+uJGazybycZeZS0vUrtfc1Yg9u7hwiKo8ecN3Jr6dnpW5k3OXz3yYLBELPxOv2nZ
 T/Dnde2SvFJophio5X61p7g2iQ3K419/3YhcW37lnqicEF11zbiATB+1VI4fMc0SmWAQDxyqscT
 MUwWtOOT5ECh1rlv40NPcnzBZlW5ZZ5up0cMmhtN04Bd1O4AVP06kH+pDe0vN8uLouDL1BqQged
 cG9kwgDZXAcFPnFyJlrly37uzMWx9xPjo/OzsZBHFOdfGMmz68tL91CRgggqvkPSjo6eOYaL3KI
 8XtOSSGv3nMFjs4FntA83eg==
X-Received: by 2002:a05:600c:511b:b0:432:d797:404a with SMTP id
 5b1f17b1804b1-4389142e0e8mr122567175e9.22.1737398842522; 
 Mon, 20 Jan 2025 10:47:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYdUvvaXrsYkkmoO7RHHHfsnFKi2DDg33h/i/ludctvzM1edekD48JDVnkM/arqHk4x0c4IA==
X-Received: by 2002:a05:600c:511b:b0:432:d797:404a with SMTP id
 5b1f17b1804b1-4389142e0e8mr122566885e9.22.1737398842096; 
 Mon, 20 Jan 2025 10:47:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c72e:e400:431d:9c08:5611:693c?
 (p200300cbc72ee400431d9c085611693c.dip0.t-ipconnect.de.
 [2003:cb:c72e:e400:431d:9c08:5611:693c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499884sm214003645e9.5.2025.01.20.10.47.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 10:47:20 -0800 (PST)
Message-ID: <ba6ea305-fd04-4e88-8bdc-1d6c5dee95f8@redhat.com>
Date: Mon, 20 Jan 2025 19:47:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
To: Peter Xu <peterx@redhat.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Chenyi Qiang
 <chenyi.qiang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
 <20241213070852.106092-3-chenyi.qiang@intel.com>
 <d0b30448-5061-4e35-97ba-2d360d77f150@amd.com>
 <80ac1338-a116-48f5-9874-72d42b5b65b4@intel.com>
 <9dfde186-e3af-40e3-b79f-ad4c71a4b911@redhat.com>
 <c1723a70-68d8-4211-85f1-d4538ef2d7f7@amd.com>
 <f3aaffe7-7045-4288-8675-349115a867ce@redhat.com> <Z46GIsAcXJTPQ8yN@x1n>
 <7e60d2d8-9ee9-4e97-8a45-bd35a3b7b2a2@redhat.com> <Z46W7Ltk-CWjmCEj@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z46W7Ltk-CWjmCEj@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 20.01.25 19:33, Peter Xu wrote:
> On Mon, Jan 20, 2025 at 06:54:14PM +0100, David Hildenbrand wrote:
>> On 20.01.25 18:21, Peter Xu wrote:
>>> On Mon, Jan 20, 2025 at 11:48:39AM +0100, David Hildenbrand wrote:
>>>> Sorry, I was traveling end of last week. I wrote a mail on the train and
>>>> apparently it was swallowed somehow ...
>>>>
>>>>>> Not sure that's the right place. Isn't it the (cc) machine that controls
>>>>>> the state?
>>>>>
>>>>> KVM does, via MemoryRegion->RAMBlock->guest_memfd.
>>>>
>>>> Right; I consider KVM part of the machine.
>>>>
>>>>
>>>>>
>>>>>> It's not really the memory backend, that's just the memory provider.
>>>>>
>>>>> Sorry but is not "providing memory" the purpose of "memory backend"? :)
>>>>
>>>> Hehe, what I wanted to say is that a memory backend is just something to
>>>> create a RAMBlock. There are different ways to create a RAMBlock, even
>>>> guest_memfd ones.
>>>>
>>>> guest_memfd is stored per RAMBlock. I assume the state should be stored per
>>>> RAMBlock as well, maybe as part of a "guest_memfd state" thing.
>>>>
>>>> Now, the question is, who is the manager?
>>>>
>>>> 1) The machine. KVM requests the machine to perform the transition, and the
>>>> machine takes care of updating the guest_memfd state and notifying any
>>>> listeners.
>>>>
>>>> 2) The RAMBlock. Then we need some other Object to trigger that. Maybe
>>>> RAMBlock would have to become an object, or we allocate separate objects.
>>>>
>>>> I'm leaning towards 1), but I might be missing something.
>>>
>>> A pure question: how do we process the bios gmemfds?  I assume they're
>>> shared when VM starts if QEMU needs to load the bios into it, but are they
>>> always shared, or can they be converted to private later?
>>
>> You're probably looking for memory_region_init_ram_guest_memfd().
> 
> Yes, but I didn't see whether such gmemfd needs conversions there.  I saw
> an answer though from Chenyi in another email:
> 
> https://lore.kernel.org/all/fc7194ee-ed21-4f6b-bf87-147a47f5f074@intel.com/
> 
> So I suppose the BIOS region must support private / share conversions too,
> just like the rest part.
> 
> Though in that case, I'm not 100% sure whether that could also be done by
> reusing the major guest memfd with some specific offset regions.
> 
>>
>>>
>>> I wonder if it's possible (now, or in the future so it can be >2 fds) that
>>> a VM can contain multiple guest_memfds, meanwhile they request different
>>> security levels. Then it could be more future proof that such idea be
>>> managed per-fd / per-ramblock / .. rather than per-VM. For example, always
>>> shared gmemfds can avoid the manager but be treated like normal memories,
>>> while some gmemfds can still be confidential to install the manager.
>>
>> I think all of that is possible with whatever design we chose.
>>
>> The situation is:
>>
>> * guest_memfd is per RAMBlock (block->guest_memfd set in ram_block_add)
>> * Some RAMBlocks have a memory backend, others do not. In particular,
>>    the ones calling memory_region_init_ram_guest_memfd() do not.
>>
>> So the *guest_memfd information* (fd, bitmap) really must be stored per
>> RAMBlock.
>>
>> The question *which object* implements the RamDiscardManager interface to
>> manage the RAMBlocks that have a guest_memfd.
>>
>> We either need
>>
>> 1) Something attached to the RAMBlock or the RAMBlock itself. This
>>     series does it via a new object attached to the RAMBlock.
>> 2) A per-VM entity (e.g., machine, distinct management object)
>>
>> In case of 1) KVM looks up the RAMBlock->object to trigger the state change.
>> That object will inform all listeners.
>>
>> In case of 2) KVM calls the per-VM entity (e.g., guest_memfd manager), which
>> looks up the RAMBlock and triggers the state change. It will inform all
>> listeners.
> 
> (after I finished reading the whole discussion..)
> 
> Looks like Yilun raised another point, on how to reuse the same object for
> device TIO support here (conversions for device MMIOs):

I don't grasp the full picture, but I suspect it would not be RAM (no 
RAMBlock?)?

"memory_attribute_manager" is weird if it is not memory, but 
memory-mapped I/O ... :)

-- 
Cheers,

David / dhildenb


