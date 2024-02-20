Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FD5C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcRjO-00047K-Sx; Tue, 20 Feb 2024 10:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rcRjO-00046q-3L
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:08:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rcRjL-0003in-1J
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708441701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7ZlrA5IF5cJqD+Dl5ZUbAqsuZNshIgXHWFz7slzpNDg=;
 b=gS5knLCwSczPORA9jifh9K2usztIt2FZAc7XULxHhOKB76rEz4CJyiCDkFJ8ANkF+y/yN/
 zzVWIE73fxueZftIwIZwitDSGIapSkymnKOH8d5DStUa7SisgWuQROlNfAs9y+pjh6Z+jj
 aFYHyJgchjwd+Va2Z2ZweIzif+3iSIE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-wJpuz5OMNiWoZ0CljlMRNw-1; Tue, 20 Feb 2024 10:08:18 -0500
X-MC-Unique: wJpuz5OMNiWoZ0CljlMRNw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e435a606aso34647875e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 07:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708441697; x=1709046497;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZlrA5IF5cJqD+Dl5ZUbAqsuZNshIgXHWFz7slzpNDg=;
 b=bPGnB6+eZlfOY+GgOZt4wdBYyG90IdZyN/N8olwxKKQD27x+TNSguaQBkY7vFWfaNS
 SkKDTmqLDjOBYt3y+f29CFw3pdb4IqfkYh6x2ukOeZv8la6SsoeNc/0FQh0uujbiiDlD
 d+DaYG8Zthd47OhkRVWGTeoFElx6DTmA7yOrVsftylt/1OM/l1GkXO6bKJm8QbqjT+/M
 axDKV3EP+uV8r5YdSzcv9AwBW+riodOyrxJ3VYf8aeaLuZYWT94mXlxOclX8xHvXCTji
 MgOPbW3ISpjdnfbnZJvMaIVo9Nr4mST/nheg1NBnr6v+XPUcupHoabsJg9VS+SIwetd5
 2Y0g==
X-Gm-Message-State: AOJu0YxyJb4E9QjlweuvdVg3ltHqSWHJ5JoeCP+4hbKWuX/mFXnkTfJy
 fB07nsTiXZFQ9F/O+fVq9n1y+ji/UNTu7tLjqd+MsTayRybJc5/PWRQMdDMIzS7iED8OlMGKjI7
 eVKKbZ9fA35wozujf3iW70LfHjEdF+o6q32rx6YLD4y4Yd+rr4ymM
X-Received: by 2002:a05:600c:5197:b0:412:7061:d7f with SMTP id
 fa23-20020a05600c519700b0041270610d7fmr1082474wmb.1.1708441697366; 
 Tue, 20 Feb 2024 07:08:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBMmNPvdUNWc7NikEv0sF6oScEjQB6V9rmmAFfaI/CpEpGj8DvQdTUpM7rgmPio6bLn058iA==
X-Received: by 2002:a05:600c:5197:b0:412:7061:d7f with SMTP id
 fa23-20020a05600c519700b0041270610d7fmr1082448wmb.1.1708441696952; 
 Tue, 20 Feb 2024 07:08:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb?
 (p200300cbc72abc009a2d8a48ef5196fb.dip0.t-ipconnect.de.
 [2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb])
 by smtp.gmail.com with ESMTPSA id
 6-20020a05600c22c600b004120537210esm14853048wmg.46.2024.02.20.07.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 07:08:16 -0800 (PST)
Message-ID: <631563e8-f063-4351-99d3-4c4a5d7c581e@redhat.com>
Date: Tue, 20 Feb 2024 16:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 33/66] i386/tdx: Make memory type private by default
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, Sean Christopherson
 <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
 <20240125032328.2522472-34-xiaoyao.li@intel.com>
 <12d89ebd-3497-4e60-8900-7a7a1ffbd6e2@redhat.com>
 <86cda9fa-3921-458f-9930-d73d247ccaa1@intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <86cda9fa-3921-458f-9930-d73d247ccaa1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

On 29.01.24 03:18, Xiaoyao Li wrote:
> On 1/26/2024 10:58 PM, David Hildenbrand wrote:
>> On 25.01.24 04:22, Xiaoyao Li wrote:
>>> By default (due to the recent UPM change), restricted memory attribute is
>>> shared.  Convert the memory region from shared to private at the memory
>>> slot creation time.
>>>
>>> add kvm region registering function to check the flag
>>> and convert the region, and add memory listener to TDX guest code to set
>>> the flag to the possible memory region.
>>>
>>> Without this patch
>>> - Secure-EPT violation on private area
>>> - KVM_MEMORY_FAULT EXIT (kvm -> qemu)
>>> - qemu converts the 4K page from shared to private
>>> - Resume VCPU execution
>>> - Secure-EPT violation again
>>> - KVM resolves EPT Violation
>>> This also prevents huge page because page conversion is done at 4K
>>> granularity.  Although it's possible to merge 4K private mapping into
>>> 2M large page, it slows guest boot.
>>>
>>> With this patch
>>> - After memory slot creation, convert the region from private to shared
>>> - Secure-EPT violation on private area.
>>> - KVM resolves EPT Violation
>>>
>>> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>>    include/exec/memory.h |  1 +
>>>    target/i386/kvm/tdx.c | 20 ++++++++++++++++++++
>>>    2 files changed, 21 insertions(+)
>>>
>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>> index 7229fcc0415f..f25959f6d30f 100644
>>> --- a/include/exec/memory.h
>>> +++ b/include/exec/memory.h
>>> @@ -850,6 +850,7 @@ struct IOMMUMemoryRegion {
>>>    #define MEMORY_LISTENER_PRIORITY_MIN            0
>>>    #define MEMORY_LISTENER_PRIORITY_ACCEL          10
>>>    #define MEMORY_LISTENER_PRIORITY_DEV_BACKEND    10
>>> +#define MEMORY_LISTENER_PRIORITY_ACCEL_HIGH     20
>>>    /**
>>>     * struct MemoryListener: callbacks structure for updates to the
>>> physical memory map
>>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>>> index 7b250d80bc1d..f892551821ce 100644
>>> --- a/target/i386/kvm/tdx.c
>>> +++ b/target/i386/kvm/tdx.c
>>> @@ -19,6 +19,7 @@
>>>    #include "standard-headers/asm-x86/kvm_para.h"
>>>    #include "sysemu/kvm.h"
>>>    #include "sysemu/sysemu.h"
>>> +#include "exec/address-spaces.h"
>>>    #include "hw/i386/x86.h"
>>>    #include "kvm_i386.h"
>>> @@ -621,6 +622,19 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>>>        return 0;
>>>    }
>>> +static void tdx_guest_region_add(MemoryListener *listener,
>>> +                                 MemoryRegionSection *section)
>>> +{
>>> +    memory_region_set_default_private(section->mr);
>>> +}
>>
>> That looks fishy. Why is TDX to decide what happens to other memory
>> regions it doesn't own?
>>
>> We should define that behavior when creating these memory region, and
>> TDX could sanity check that they have been setup properly.
>>
>> Let me ask differently: For which memory region where we have
>> RAM_GUEST_MEMFD set would we *not* want to set private as default right
>> from the start?
> 
> All memory regions have RAM_GUEST_MEMFD set will benefit from being
> private as default, for TDX guest.
> 
> I will update the implementation to set RAM_DEFAULT_PRIVATE flag when
> guest_memfd is created successfully, like
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index fc59470191ef..60676689c807 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1850,6 +1850,8 @@ static void ram_block_add(RAMBlock *new_block,
> Error **errp)
>                qemu_mutex_unlock_ramlist();
>                return;
>            }
> +
> +        new_block->flags |= RAM_DEFAULT_PRIVATE;
>        }
> 
> then this patch can be dropped, and the calling of
> memory_region_set_default_private(mr) of Patch 45 can be dropped too.
> 
> I think this is what you suggested, right?

Yes, if that works, great!

-- 
Cheers,

David / dhildenb


