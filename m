Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F463C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHTH-0002pa-Rl; Wed, 14 May 2025 15:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uFHNI-0005yT-IS
 for qemu-devel@nongnu.org; Wed, 14 May 2025 15:02:40 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uFHNE-0007pJ-R2
 for qemu-devel@nongnu.org; Wed, 14 May 2025 15:02:40 -0400
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-acae7e7587dso22019566b.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 12:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747249354; x=1747854154;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bq6IDucE41HGr9Cs1evHK9COXsFiy7GhBYd0kod3aH0=;
 b=Uh3cOdmxpnM56zohwvjZ2WF/DoGHlI1m3XsbtZP9Gs0nLRkqDla/Q34J2FmhowUSZQ
 zRTjhhsPrUuT6LvEjVP44DvYbYCuubjG3p84vnJ7sXifI0308YQoWf6JVNvSKZFid+23
 8qtLLsXXB692gvNJulUL6q8A7QRYtsRB+v4hA+NgS9VXCl8LgRuq7LR7BjdgtktqAwBT
 BkQdn4FZ2e2t1w7eRyp7CwfwUzO6UdJgPx38txv3L1OmSPWuN7PnqSudaR9jZACURUtB
 CbP2OieH8E5wwfYUAswLV8+Fco+JgSQAVtho4bkeqzrqLVKEMvPupKApnXbU2aw1kEz6
 3JrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV62kqwCmlX5LUvsGw5rWeNX3DmgM6Ubz0qiZNYyHEolKMUZWblvCUgfUAuyd3l5Fj5d5ub/f+wIztU@nongnu.org
X-Gm-Message-State: AOJu0YxNY0OUvGqNxCqN6wjcBF4ynq+ITLWg2k4lBsisqvUMgYEBvwLJ
 95kuym/pBMJN2+nDhn0LjDwDOzbwXQhUY/SJbb1FrGS3YRatLhrN
X-Gm-Gg: ASbGncslM6fgOBWXHN9wya87rUVnELqRvCK+2b9sYb2ETiltd8PBFKBjSVioBqLQyCn
 Y5tf8Tcb5MHSMLdRXbhXnt4k5Tue3NTCE/pHHM8QuElEWc6FzsNrNvATJrkBUCorgfx68/Ozodn
 9WTcK9nNJvXR/l8lTzB+KdbYX8cCqcyYp8qHhepT7mWsLjlubgrmoW5C5PThLHlI00w5pNIRpRr
 jl32qrM4Qr/vk8mgI6Rx822sSbf8WSQ7xvNhnIdj7vzGFsD3RwpcH5sgEFh1+jRVLhb/uqhHV/F
 dBTuai65s0w7FphX2zb6Ee5Sn9GlwiifXn+qwrSn7FJYIHxNOg6/dZIBTyb1XOrl+eciO+6moEH
 d9kiAbLhjNXlT
X-Google-Smtp-Source: AGHT+IGG54F/kugcdsakcLt6pdEoShf8wDwYxc/NO7MK3b2Is4aIBDAvjXf6GyYgXChNgD9z1939ZA==
X-Received: by 2002:a17:906:9c87:b0:ad4:cc66:1524 with SMTP id
 a640c23a62f3a-ad4f74d49d5mr399857066b.54.1747249353802; 
 Wed, 14 May 2025 12:02:33 -0700 (PDT)
Received: from [192.168.88.252] (78-80-121-182.customers.tmcz.cz.
 [78.80.121.182]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2197be6d7sm970242366b.157.2025.05.14.12.02.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 12:02:33 -0700 (PDT)
Message-ID: <03180a8b-bd9e-40c1-8711-bddf04d84aa3@ovn.org>
Date: Wed, 14 May 2025 21:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Jason Wang <jasowang@redhat.com>,
 Anton Protopopov <aspsk@isovalent.com>
Subject: Re: [PATCH] net/af-xdp: Support pinned map path for AF_XDP sockets
To: Daniel Borkmann <daniel@iogearbox.net>, qemu-devel@nongnu.org
References: <20250508123436.461030-1-daniel@iogearbox.net>
 <f044b02b-3b7a-4a64-ab38-3298f96955a9@ovn.org>
 <0d7285c0-15dc-4dcd-9436-b9134f07242d@iogearbox.net>
 <18f6aae8-2fa2-4fb6-a518-67e982623a5e@ovn.org>
 <e61edfd9-8979-4ef4-b1a5-28dfd802cba6@iogearbox.net>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <e61edfd9-8979-4ef4-b1a5-28dfd802cba6@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.65;
 envelope-from=i.maximets.ovn@gmail.com; helo=mail-ej1-f65.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/12/25 4:23 PM, Daniel Borkmann wrote:
> On 5/12/25 2:03 PM, Ilya Maximets wrote:
>> On 5/9/25 4:05 PM, Daniel Borkmann wrote:
>>> On 5/9/25 12:53 AM, Ilya Maximets wrote:
>>>> On 5/8/25 2:34 PM, Daniel Borkmann wrote:
>>>>> Extend inhibit=on setting with the option to specify a pinned XSK map
>>>>> path along with a starting index (default 0) to push the created XSK
>>>>> sockets into. Example usage:
>>>>>
>>>>>     # ./build/qemu-system-x86_64 [...] \
>>>>>       -netdev af-xdp,ifname=eth0,id=net0,mode=native,queues=2,inhibit=on,map-path=/sys/fs/bpf/foo,map-start-index=2
>>>>>       -device virtio-net-pci,netdev=net0 [...]
>>>>>
>>>>> This is useful for the case where an existing XDP program with XSK map
>>>>> is present on the AF_XDP supported phys device and the XSK map not yet
>>>>> populated. Qemu will then push the XSK sockets into the specified map.
>>>>
>>>> Thanks for the patch!
>>>>
>>>> Could you, please, explain the use case a little more?  Is this patch
>>>> aiming to improve usability?  Do you have a specific use case in mind?
>>>
>>> The use case we have is basically that the phys NIC has an XDP program
>>> already attached which redirects into xsk map (e.g. installed from separate
>>> control plane), the xsk map got pinned during that process into bpf fs,
>>> and now qemu is launched, it creates the xsk sockets and then places them
>>> into the map by gathering the map fd from the pinned bpf fs file.
>>
>> OK.  That's what I thought.  Would be good to expand the commit message
>> a bit explaining the use case.
> 
> Ack, I already adjusted locally. Planning to send v2 ~today with your feedback
> incorporated. Much appreciated!
> 
>>>> The main idea behind 'inhibit' is that the qemu doesn't need to have a lot
>>>> of privileges to use the pre-loaded program and the pre-created sockets.
>>>> But creating the sockets and setting them into a map doesn't allow us to
>>>> run without privileges, IIUC.  May be worth mentioning at least in the
>>>> commit message.
>>>
>>> Yes, privileges for above use case are still needed. Will clarify in the
>>> description.
>>
>> OK.
>>
>>>> Also, isn't map-start-index the same thing as start-queue ?  Do we need
>>>> both of them?
>>>
>>> I'd say yes given it does not have to be an exact mapping wrt queue index
>>> to map slot. The default is 0 though and I expect this to be the most used
>>> scenario.
>>
>> I'm still not sure about this.  For example, libxdp treats queue id as a map
>> index.  And this value is actually not being used much in libxdp when the
>> program load is inhibited.  I see that with a custom XDP program the indexes
>> inside the map may not directly correspond to queues in the device, and, in
>> fact, may have no relation to the actual queues in the device at all.
> 
> Right, that's correct.
> 
>> However, we're still calling them "queues" from the QEMU interface (as in the
>> "queues" parameter of the net/af-xdp device), and QEMU will just treat every
>> slot in the BPF map as separate queues, as this BPF map is essentially the
>> network device that QEMU is working with, it doesn't actually know what's
>> behind it.
>>
>> So, I think, it should be appropriate to simplify the interface and
>> just use existing start-queue configuration knob for this.
>>
>> What do you think?
> 
> I was thinking of an example like the below (plainly taken from the XDP example
> programs at github.com/xdp-project/bpf-examples).
> 
>    struct {
> 	__uint(type, BPF_MAP_TYPE_XSKMAP);
> 	__uint(max_entries, MAX_SOCKS);
> 	__uint(key_size, sizeof(int));
> 	__uint(value_size, sizeof(int));
>    } xsks_map SEC(".maps");
> 
>    int num_socks = 0;
>    static unsigned int rr;
> 
>    SEC("xdp_sock") int xdp_sock_prog(struct xdp_md *ctx)
>    {
> 	rr = (rr + 1) & (num_socks - 1);
> 	return bpf_redirect_map(&xsks_map, rr, XDP_DROP);
>    }
> 
> If we'd just reuse the start-queue configuration knob for this, then it wouldn't
> work. So I think having the flexibility of where to place the sockets in the map
> would make sense. But I can also drop that part of you think it does not warrant
> the extra knob and align to start-queue then the map always needs to be of the
> same size as the combined NIC queues.

I'm a little confused here.  The 'start-queue' is not used for anything important,
AFAICT, in case of inhibit=on.  So, why re-using it instead of adding a new
config option reduces the number of available use cases?

Bets regards, Ilya Maximets.

