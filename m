Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBB3D1CDCA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 09:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3BGQ-0000oV-8w; Tue, 22 Oct 2024 05:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t3BGP-0000nX-5k
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 05:33:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t3BGM-00089c-V3
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 05:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729589593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PVXjarjpT2me/HEqV5U+dOBsyl8V0kY5yMijGXx3qRE=;
 b=K6wGcYgAkQssUFs3F5ABHmLT7+GgYioM41w0yJX/NDNUAMzawn8sVP25cw2MDum43Z+xLD
 XQDET7wDDDinNP5Zf7fIZZW6G3Hve8Kv8342Yo2HoGpDkps7ZW2ATmuYaShtdYLKRF3KG9
 QPMpgKecg1wOKVZIixSsbHrcht8gw8E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-iDvFBaf7NeiGxFMeaeVjsw-1; Tue, 22 Oct 2024 05:33:12 -0400
X-MC-Unique: iDvFBaf7NeiGxFMeaeVjsw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315c1b5befso39477325e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 02:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729589591; x=1730194391;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PVXjarjpT2me/HEqV5U+dOBsyl8V0kY5yMijGXx3qRE=;
 b=UnhCXo2d8yH5dKLpKrMUZmkre4T55Vl2LY2ohC3ssg58cf32QnYx2cJpfwZfYbIeCN
 KyXOpYNOxAhj3IQgG/XDkLqbP0k8GVc4A8cK6Lna6qG6NI1fVE4Tf408+Zjey3Nr2zTU
 ygr1TEEjqk42mhkFdL/a6qdvmuoGbc+GSL/0lUVgYDTHq1XSSGMIvuPgHC3s4knKT2++
 uSHkC760IUC2BRqjHQ0NG1inpZVE1pdaGFgwBU1XDSm4Mm7x1iT7G7TOa49Z6K6IjWyZ
 V7CZBnSFuAPncNr2pMX9gE28EX5sPeId1U/Lp9JV81mTjgAmAIDMhC6DqXx3cwY+Xw6V
 Lr0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLtcLOcYkY29Bb6UNLd+ZlKXD8w928ec0fi9GJf1K2kjmJzQnI6rJ33SBgttGsrkP8kGJDtAvxdc3j@nongnu.org
X-Gm-Message-State: AOJu0Yw9/soHfSMAtV2LufFSbRC09SH+sgsIXmCbAKM4saqh2KgIicrR
 RQ7DBQSQuWrX5cSHxjrVuTDe6okObTP496WC94yB9l2Abye051fBe8fV7NZJKH4MKgleVFvNvaW
 CWUsPStPSlyVm4Tc3LKcZHN+BURFZVSiQDloBu1CBczVVtszm7kgt
X-Received: by 2002:a05:600c:1d04:b0:431:43c6:e868 with SMTP id
 5b1f17b1804b1-4316168989amr116823855e9.23.1729589590833; 
 Tue, 22 Oct 2024 02:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsVMtr0vPoX3GC1cafvEWG+eXenTikKUk4UF7+4sSq9bykVMQaJpWzxJ8Y3D4BsFBHFgf+EQ==
X-Received: by 2002:a05:600c:1d04:b0:431:43c6:e868 with SMTP id
 5b1f17b1804b1-4316168989amr116823485e9.23.1729589590404; 
 Tue, 22 Oct 2024 02:33:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:f700:352b:d857:b95d:9072?
 (p200300cbc705f700352bd857b95d9072.dip0.t-ipconnect.de.
 [2003:cb:c705:f700:352b:d857:b95d:9072])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5c311bsm81820335e9.29.2024.10.22.02.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 02:33:09 -0700 (PDT)
Message-ID: <1238f2a3-88a2-4996-92f2-05735801002b@redhat.com>
Date: Tue, 22 Oct 2024 11:33:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
To: Gregory Price <gourry@gourry.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, John Groves <John@groves.net>,
 virtualization@lists.linux.dev, Oscar Salvador <osalvador@suse.de>,
 qemu-devel@nongnu.org, Dave Jiang <dave.jiang@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com,
 wangkefeng.wang@huawei.com, John Groves <jgroves@micron.com>,
 Fan Ni <fan.ni@samsung.com>, Navneet Singh <navneet.singh@intel.com>,
 =?UTF-8?B?4oCcTWljaGFlbCBTLiBUc2lya2lu4oCd?= <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240815172223.00001ca7@Huawei.com>
 <fc05d089-ce04-42d2-a0d7-ea32fd73fe90@redhat.com>
 <Zu07AU3aUrHBMXaw@PC2K9PVX.TheFacebook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zu07AU3aUrHBMXaw@PC2K9PVX.TheFacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 20.09.24 11:06, Gregory Price wrote:
>>> 2. Coarse grained memory increases for 'normal' memory.
>>>      Can use memory hot-plug. Recovery of capacity likely to only be possible on
>>>      VM shutdown.
>>
>> Is there are reason "movable" (ZONE_MOVABLE) is not an option, at least in
>> some setups? If not, why?
>>
> 
> 
> This seems like a bit of a muddied conversation.

Cleaning up my inbox ... well at least trying :)

> 
> "'normal' memory" has no defined meaning - so lets clear this up a bit
> 
> There is:
> * System-RAM (memory managed by kernel allocators)
> * Special Purpose Memory (generally presented as DAX)
 > > System-RAM is managed as zones - the relevant ones are
> * ZONE_NORMAL allows both movable and non-movable allocations

.. except in corner cases like MIGRATE_CMA :)

> * ZONE_MOVABLE only allows non-movable allocations
>    (Caveat: this generally only applies to allocation, you can
>     violate this with stuff like pinning)

Note that long-term pinning is forbidden on MOVABLE, just like it is on 
MIGRATE_CMA. So we try that common use cases cannot violate this.

> 
> Hotplug can be thought of as two discrete mechanisms
> * Exposing capacity to the kernel (CXL DCD Transactions)
> * Exposing capacity to allocators (mm/memory-hotplug.c)
 > > 1) if the intent is to primarily utilize dynamic capacity for VMs, then
>     the host does not need (read: should not need) to map the memory as
>     System-RAM in the host. The VMM should be made to consume it directly
>     via DAX or otherwise.
> 
>     That capacity is almost by definition "Capital G Guaranteed" to be
>     reclaimable regardless of what the guest does. A VMM can force a guest
>     to let go of resources - that's its job.
> 
> 2) if the intent is to provide dynamic capacity to a host as System-RAM, then
>     recoverability is dictated by system usage of that capacity. If onlined
>     into ZONE_MOVABLE, then if the system has avoided doing things like pinning
>     those pages it should *generally* be recoverable (but not guaranteed).

There is, of course, the use case of memory overcommit -- in which case 
you would want 2). But likely that's out of the picture for this tagged 
memory.

> 
> 
> For the virtualization discussion:
> 
> Hotplug and recoverability is a non-issue.  The capacity should never be
> exposed to system allocators and the VMM should be made to consume special
> purpose memory directly. That's on the VMM/orchestration software to get right.
> 
> 
> For the host System-RAM discussion:
> 
> Auto-onlined hotplug capacity presently defaults to ZONE_NORMAL, but we
> discussed (yesterday, at Plumbers) changing this default to ZONE_MOVABLE.
> 
> The only concern is when insufficient ZONE_NORMAL exists to support
> ZONE_MOVABLE capacity - but this is unlikely to be the general scenario AND
> can be mitigated w/ existing mechanisms.

It might be worthwhile looking at 
Documentation/admin-guide/mm/memory-hotplug.rst "auto-movable" memory 
onlining polciy. It might not fit all sue cases, though (just like 
ZONE_MOVABLE doesn't)

> 
> Manually onlined capacity defaults to ZONE_MOVABLE.
> 
> It would be nice to make this behavior consistent, since the general opinion
> appears to be that this capacity should default to ZONE_MOVABLE.

It's much easier to shoot yourself into the foot with ZONE_MOVABLE, 
that's why the default can be adjusted manually using "online_movable" 
with e.g., memhp_default_state.

It's all a bit complicated, because there are various use cases and 
mechanisms for memory hotplug ... IIRC RHEL defaults with its udev rules 
to "ZONE_MOVABLE" on bare metal and "ZONE_NORMAL" in VMs. Except on 
s390, where we default to "offline" (standby memory ....).

I once worked on a systemd unit to make this configuration easier (and 
avoid udev rules), and possibly more "automatic" depending on the 
detected environment.

-- 
Cheers,

David / dhildenb


