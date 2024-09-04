Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235D8CD4F38
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 21:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slxi2-00024N-2m; Wed, 04 Sep 2024 17:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1slxi0-00023G-6D
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 17:38:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1slxhy-0002t9-Lg
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 17:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725485913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MqixTI1vhhI4pw6sc9CjCYmoyN3ATEYK2DlzoZPQ0Ko=;
 b=c7yUbe+SgPA8IF8fCIPV7iRCGV8Sxurpd/XLDpMC3SAbrxzpN/q591o8XR9nbpnvpx14+v
 9whUi9x3sr9E9S/Lbp1Z/vE5J+D+rfPSB90Djl6Nmlc96bSyhH1YPVCzOnzxFHLkXBt3hH
 uDmlmzoPXNxTbaryaTFa5t4J5unJis8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30--f_Y21lnMR2tAEHtTAteOg-1; Wed, 04 Sep 2024 17:38:32 -0400
X-MC-Unique: -f_Y21lnMR2tAEHtTAteOg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3730b54347cso6735f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 14:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725485911; x=1726090711;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MqixTI1vhhI4pw6sc9CjCYmoyN3ATEYK2DlzoZPQ0Ko=;
 b=dt0N0wJQYJG51Gmw4p/1P0+6IFSuFGKFFZeogrhzXPxYeClBtLJum+gKPxu/klSj4p
 5Byc74sME2e5tFvdh1H5+FR+vLUiaoCc9oYzgGdFEhrL7BniXMONOMkP2U0Nv4Mhm1iJ
 L5eI9fEgaqDNvlC3usqHEljhbgVKoBpZaME5niMgRwRQwowSwR6I2wsg8ZbhZkinQgC3
 qMgf1aCt+qDZ7VA0DOK//moXknjNRBYRPzd05EHetOGW1UHtXKAHeR1zfCXnBXbSaHlg
 olhZbe6Ba3xBt7JY9oDWrmYDpt3nFB4oV8wW68WB33h1vCQY3rZPf1Q0MdpICJ74kaJB
 FOzw==
X-Gm-Message-State: AOJu0YzEGwKR5Kdvbc0ryEqyckgIA6dmGF12CW2dKT63Oqw9TyxdJl9A
 Jw6HiWtuGRZB0u4yqzFasNnV/eK+wcb+/Mo20qrcDs7m14wiNiA73KK3gR//szyzQUwe0LhrdqX
 eNPSTPC8gGgHfN2tBpSvi/bencC43pyn7AXEBrojfKk6fGjIlRTgj
X-Received: by 2002:adf:fd0d:0:b0:374:c08c:1046 with SMTP id
 ffacd0b85a97d-374ecc8f6aemr5127597f8f.20.1725485911207; 
 Wed, 04 Sep 2024 14:38:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWTMA9RdeRzViPbxfCFWUHs/uckiBop6ChYKwqgTMaujjsNomnkbq6OsAogt+S62SsFU9BSA==
X-Received: by 2002:adf:fd0d:0:b0:374:c08c:1046 with SMTP id
 ffacd0b85a97d-374ecc8f6aemr5127579f8f.20.1725485910307; 
 Wed, 04 Sep 2024 14:38:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:d00:e9a5:ae4b:9bdb:d992?
 (p200300cbc7150d00e9a5ae4b9bdbd992.dip0.t-ipconnect.de.
 [2003:cb:c715:d00:e9a5:ae4b:9bdb:d992])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c1de81b2sm12290018f8f.30.2024.09.04.14.38.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 14:38:29 -0700 (PDT)
Message-ID: <62e22812-845c-4986-bb3a-fbf833185581@redhat.com>
Date: Wed, 4 Sep 2024 23:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] KVM: Dynamic sized kvm memslots array
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Zhiyi Guo <zhguo@redhat.com>
References: <20240904191635.3045606-1-peterx@redhat.com>
 <20240904191635.3045606-4-peterx@redhat.com>
 <b2cf2a87-848f-4c07-9d05-39b53c638950@redhat.com> <ZtjPA9eCN1Ro9HFp@x1n>
 <ff6430ac-f7f4-49f3-a63b-76eae5b2f791@redhat.com> <ZtjSbnb-yFOEsq0R@x1n>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZtjSbnb-yFOEsq0R@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On 04.09.24 23:34, Peter Xu wrote:
> On Wed, Sep 04, 2024 at 11:23:33PM +0200, David Hildenbrand wrote:
>>
>>>>
>>>> Then, you can remove the parameter from kvm_slots_grow() completely and just call it
>>>> kvm_slots_double() and simplify a bit:
>>>>
>>>> static bool kvm_slots_double(KVMMemoryListener *kml)
>>>> {
>>>>       unsigned int i, nr_slots_new, cur = kml->nr_slots_allocated;
>>>>       KVMSlot *slots;
>>>>
>>>>       nr_slots_new = MIN(cur * 2, kvm_state->nr_slots_max);
>>>>       if (nr_slots_new == kvm_state->nr_slots_max) {
>>>>           /* We reached the maximum */
>>>> 	return false;
>>>>       }
>>>>
>>>>       assert(kml->slots);
>>>>       slots = g_renew(KVMSlot, kml->slots, nr_slots_new);
>>>>       /*
>>>>        * g_renew() doesn't initialize extended buffers, however kvm
>>>>        * memslots require fields to be zero-initialized. E.g. pointers,
>>>>        * memory_size field, etc.
>>>>        */
>>>>       memset(&slots[cur], 0x0, sizeof(slots[0]) * (nr_slots_new - cur));
>>>>
>>>>       for (i = cur; i < nr_slots_new; i++) {
>>>>           slots[i].slot = i;
>>>>       }
>>>>
>>>>       kml->slots = slots;
>>>>       kml->nr_slots_allocated = nr_slots_new;
>>>>       trace_kvm_slots_grow(cur, nr_slots_new);
>>>>
>>>>       return true;
>>>> }
>>>
>>> Personally I still think it cleaner to allow setting whatever size.
>>
>> Why would one need that? If any, at some point we would want to shrink or
>> rather "compact".
>>
>>>
>>> We only have one place growing so far, which is pretty trivial to double
>>> there, IMO.  I'll wait for a second opinion, or let me know if you have
>>> strong feelings..
>>
>> I think the simplicity of kvm_slots_double() speaks for itself, but I won't
>> fight for it.
> 
> Using kvm_slots_double() won't be able to share the same code when
> initialize (to e.g. avoid hard-coded initialize of "slots[i].slot").

I don't see that as any problem and if you really care you could factor 
exactly that part out in a helper. Anyhow, I learned that I am not good 
at convincing you, so do what you think is best. The code itself should 
get the job done.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


