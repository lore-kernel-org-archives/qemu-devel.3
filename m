Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BCAC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwirh-0001CO-R1; Tue, 16 Apr 2024 09:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgross@suse.com>) id 1rwirf-0001Bz-Ju
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:28:47 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jgross@suse.com>) id 1rwird-00057j-0i
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:28:47 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56e78970853so8360020a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713274123; x=1713878923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nrphme9PznmU4fpqJRprcUnPzNkG0J1sP+MgqiS0S5M=;
 b=SWCLk4TErsmseLx4AQGZlIDLcAFbO5kWi/qsTi4RRry/5fRiOVx6lWys/5yoc2o77L
 uR2tE7vh+pEqqlGwgHgp6anuAvv/q5sy0wj6qxl/91ZmB0H8TmWqmzGL7C5YSb/KuWOB
 HekJp2qD6zBjMbZ5RmqViHsUaVi0wVVBt//+6G87iHv+9T3izY3yioLix126Snx8Tx5R
 vkhPLL05kP26z3lDDqZMoKpbKbOGO+G9qiOd4tdjHD/N7mRC6PZnV/3u7MvD6EH3mcm8
 Zf9eLkKDAzmKtFPfCruMoQ+gD3aF9w41eZQ36PQO14GAeQxGJCyIISkOW9d96m4X9yI3
 DJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713274123; x=1713878923;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nrphme9PznmU4fpqJRprcUnPzNkG0J1sP+MgqiS0S5M=;
 b=TLv7sb1HoS5Ruc1NHuFsX2HoGs3CR2vbW6vmPL2o7qOLUCkqkMKM+MlC1FqeN3AEtM
 dI1mnljRpnVP5acXfYK8co6pKBU+o0WRcFaOTZH/03qyMhN7rdqK8Yd8ShqbV0EmzCeH
 5YoKcrNlJxQFxuSMqCJEE1Et8vRsagRk24OelBr1IJaKDsMR9s5zBY259M1a0s9U9tSj
 glBii84xH8lwdxdKQCT+2BPA6yQtFo8Vat69jnSCrt/ZqmIjFWoZwmzbT4WnSA65Wh5B
 IVKTwV4r9BYAHDmQsvZjCHysvOpM0s8XEyKAL4DSEvb5rFyrnBV4H5dKcq/LjRcyQQdQ
 GnjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ6Adrx2s/WhtK8BT4fGFeNZLLrnFREKJfUP6LcSYaD2TBkMQkJD4FVajEvP7CCEdjMb8Hy0ugtMvr5Gu/U5iNHSM4ztM=
X-Gm-Message-State: AOJu0YzBthIgRP954PYVoj6l5unCi5DpS0XcjBBNEXWNZFvEloUffdYa
 fCukZJ+o2eFoqAp7PBUrH8zF3Nci+6Lj6+cJ4IBE2U5aAMmCJbv/VB9nag8jAb4=
X-Google-Smtp-Source: AGHT+IHXSil6iGM6aIAJri9H2bj+eAIeOIagFpUAsZhEZmsYACgqQPvL6cvnxG+8VvSFUGCisyzZYw==
X-Received: by 2002:a17:906:3b13:b0:a52:71d6:d605 with SMTP id
 g19-20020a1709063b1300b00a5271d6d605mr1597846ejf.23.1713274122736; 
 Tue, 16 Apr 2024 06:28:42 -0700 (PDT)
Received: from ?IPV6:2003:e5:8705:9b00:4df1:9dd5:4f97:24a?
 (p200300e587059b004df19dd54f97024a.dip0.t-ipconnect.de.
 [2003:e5:8705:9b00:4df1:9dd5:4f97:24a])
 by smtp.gmail.com with ESMTPSA id
 x13-20020a170906b08d00b00a51d073da7esm6813015ejy.82.2024.04.16.06.28.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 06:28:42 -0700 (PDT)
Message-ID: <3abfdbdd-ee70-4b61-a652-c7b2490732d6@suse.com>
Date: Tue, 16 Apr 2024 15:28:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU][PATCH v3 5/7] memory: add MemoryRegion map and unmap
 callbacks
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org, sstabellini@kernel.org,
 vikram.garhwal@amd.com
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-6-vikram.garhwal@amd.com>
 <CAJy5ezpCWkOqthGR1c5Nsfyi_W_yGL_d17Jcp0VckaCEwx9z3Q@mail.gmail.com>
 <Zhbg9alYH1-J9poU@x1n>
 <CAJy5ezpfNGDC4Q=eMcQ-df_xZVYnc-CR5wfn4izW2CT532PbAA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <CAJy5ezpfNGDC4Q=eMcQ-df_xZVYnc-CR5wfn4izW2CT532PbAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::531;
 envelope-from=jgross@suse.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 16.04.24 13:32, Edgar E. Iglesias wrote:
> On Wed, Apr 10, 2024 at 8:56 PM Peter Xu <peterx@redhat.com> wrote:
>>
>> On Wed, Apr 10, 2024 at 06:44:38PM +0200, Edgar E. Iglesias wrote:
>>> On Tue, Feb 27, 2024 at 11:37 PM Vikram Garhwal <vikram.garhwal@amd.com>
>>> wrote:
>>>
>>>> From: Juergen Gross <jgross@suse.com>
>>>>
>>>> In order to support mapping and unmapping guest memory dynamically to
>>>> and from qemu during address_space_[un]map() operations add the map()
>>>> and unmap() callbacks to MemoryRegionOps.
>>>>
>>>> Those will be used e.g. for Xen grant mappings when performing guest
>>>> I/Os.
>>>>
>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
>>>>
>>>
>>>
>>> Paolo, Peter, David, Phiippe, do you guys have any concerns with this patch?
>>
> 
> Thanks for your comments Peter,
> 
> 
>> This introduces a 3rd memory type afaict, neither direct nor !direct.
>>
>> What happens if someone does address_space_write() to it?  I didn't see it
>> covered here..
> 
> You're right, that won't work, the memory needs to be mapped before it
> can be used.
> At minimum there should be some graceful failure, right now this will crash.
> 
>>
>> OTOH, the cover letter didn't mention too much either on the big picture:
>>
>> https://lore.kernel.org/all/20240227223501.28475-1-vikram.garhwal@amd.com/
>>
>> I want to have a quick grasp on whether it's justified worthwhile we should
>> introduce this complexity to qemu memory core.
>>
>> Could I request a better cover letter when repost?  It'll be great to
>> mention things like:
> 
> I'll do that, but also answer inline in the meantime since we should
> perhaps change the approach.
> 
>>
>>    - what is grant mapping, why it needs to be used, when it can be used (is
>>      it only relevant to vIOMMU=on)?  Some more information on the high
>>      level design using this type or MR would be great.
> 
> https://github.com/xen-project/xen/blob/master/docs/misc/grant-tables.txt
> 
> Xen VM's that use QEMU's VirtIO have a QEMU instance running in a separate VM.
> 
> There's basically two mechanisms for QEMU's Virtio backends to access
> the guest's RAM.
> 1. Foreign mappings. This gives the VM running QEMU access to the
> entire RAM of the guest VM.

Additionally it requires qemu to run in dom0, while in general Xen allows
to run backends in less privileged "driver domains", which are usually not
allowed to perform foreign mappings.

> 2. Grant mappings. This allows the guest to dynamically grant and
> remove access to pages as needed.
> So the VM running QEMU, cannot map guest RAM unless it's been
> instructed to do so by the guest.
> 
> #2 is desirable because if QEMU gets compromised it has a smaller
> attack surface onto the guest.

And it allows to run the virtio backend in a less privileged VM.

> 
>>
>>    - why a 3rd memory type is required?  Do we have other alternatives?
> 
> Yes, there are alternatives.
> 
> 1. It was suggested by Stefano to try to handle this in existing qemu/hw/xen/*.
> This would be less intrusive but perhaps also less explicit.
> Concerns about touching the Memory API have been raised before, so
> perhaps we should try this.
> I'm a little unsure how we would deal with unmapping when the guest
> removes our grants and we're using models that don't map but use
> address_space_read/write().

Those would either need to use grant-copy hypercalls, or they'd need to map,
read/write, unmap.

> 
> 2. Another approach could be to change the Xen grant-iommu in the
> Linux kernel to work with a grant vIOMMU in QEMU.
> Linux could explicitly ask QEMU's grant vIOMMU to map/unmap granted regions.
> This would have the benefit that we wouldn't need to allocate
> address-bit 63 for grants.
> A drawback is that it may be slower since we're going to need to
> bounce between guest/qemu a bit more.

It would be a _lot_ slower, unless virtio-iommu and grants are both modified
to match. I have looked into that, but the needed effort is rather large. At
the last Xen summit I have suggested to introduce a new grant format which
would work more like a normal page table structure. Using the same format
for virtio-iommu would allow to avoid the additional bounces between qemu and
the guest (and in fact that was one of the motivations to suggest the new
grant format).


Juergen

