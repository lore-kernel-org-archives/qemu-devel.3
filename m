Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B447D3B9A4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 15:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFxX6-00069j-3K; Tue, 26 Nov 2024 10:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weichenforschung@gmail.com>)
 id 1tFxX4-00069B-Uj
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:31:18 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weichenforschung@gmail.com>)
 id 1tFxX2-00086h-La
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:31:18 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-724f383c5bfso2815184b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 07:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732635075; x=1733239875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5t1UI6Vy74P4TmmIiFgAZTOrANDO8y/ww/YFNRW9uI=;
 b=DWTPEI2XHcm+it6kl3thntTF8KlCSsQ5CwGThCsCsNs2NE+DQMR3trlnR2uZA+wON0
 vwc2qASJaUMOTzHO+EOu+vjipM+J8PDiB57xa9U9WBwUzAzXbkZvaB24WoJa0NXzQfF1
 0PNzASFkjKPMpbuGEdYVIPeAffyW0zSLYBTAFjfcN+uQdRde/MibyKbgXG/0yps2vAOs
 2vcGBW0y59NAbGlhOYwbbJ4w3+CFht1NTCeHxxr/nKpAtpGCoMkIoU8qti3HG/7hk+s/
 mwRGZoHOK6F8918+DlFidSMzEThdP5rQOPQZa0xsKiEF4DgeMRQHiCWHgReY8hIqFNGh
 GhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635075; x=1733239875;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=b5t1UI6Vy74P4TmmIiFgAZTOrANDO8y/ww/YFNRW9uI=;
 b=Z0w/TwiQ4NncGMfd4V8U9xdPeXUmM7MJ7TvXuXhy2k6Luwi0DxToDCizvZE9GAFW7d
 KwxNJ55mkzYmoeR1LnD+eKY50F1mnl9p+Jz9LKUR1oiIpracnAqahK+mTGM30ebztIDn
 R1OworpvpCXUZBWEI0YX3A7KstzSYNPonVaS61j8rZQgG1dBWBaw9aU0+9Jj7dkTRi8E
 SJ+YVcuL0ZkxdkRfi7imoA1+i+IOJZA06aN5ay07rz3l4CUR99PenHHYxivPOlfXDD6t
 R0nutGcl0lL2YasUunGC0VnRQdXmL/yC0eFNG1xjChBi6La7tG+bHce5nSFSTHekfZIq
 oJPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0jTTDmFMkHeTrZYgizNkk73GScZzo4p5uxvsk6NIkQMxfOeetpS3uCEnQD3zNHezYfQwIj6rWPOBo@nongnu.org
X-Gm-Message-State: AOJu0Yw+lcVeBuXHxdAJWoU5xyqsi1a7K1fX5/k0I+ho6hIDkyH5f230
 Xt/tcrAlHHPhWQe7CmLAa6Y9Yx5VreT2LdhPPaGQPHrQUxtQakmG
X-Gm-Gg: ASbGncukqYyCG5zSX54XZIENro+0tQuScqaVU9uG5h6aTCMHyw7WgXymi/aV58coFmU
 ceiwXgfx/eJ/XnuM2Mt+gFjh2Oj3UL8iRU6bTP9fdzygSKkFUhIGC0dwlO6ccVuXUC2PlubFUB9
 2ezPOkM7VsDJBTHCdde0FqVGsVWkecl/tz7X8HRIe64EugtV0Kjl2jssg20oeEYBCfzCl5gzl/J
 SPEuUpLYlP1UPasJhWzHDvn78KZWM1EveXl1DXNXS2sZbatukOB4/gCDs7SUY3V
X-Google-Smtp-Source: AGHT+IEpyRXHZJ4MFMzYhJzEpBhDsZxS2EzsnsAN/vZe4Q+YzwQgtrSE/IIc0Z/bnZDEErUxMXeDeA==
X-Received: by 2002:a17:902:c949:b0:20b:6624:70b2 with SMTP id
 d9443c01a7336-2129f5db7b8mr206759775ad.19.1732635074818; 
 Tue, 26 Nov 2024 07:31:14 -0800 (PST)
Received: from [192.168.5.232] ([212.107.30.68])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dbff331sm86255305ad.140.2024.11.26.07.31.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 07:31:14 -0800 (PST)
Message-ID: <93616a1e-3614-49ca-9515-697f1c9205b6@gmail.com>
Date: Tue, 26 Nov 2024 23:31:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/virtio-mem: Prohibit unplugging when size <=
 requested_size
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, yuval.yarom@rub.de, genkin@gatech.edu,
 Zhi Zhang <zzhangphd@gmail.com>
References: <20241126080213.248-1-weichenforschung@gmail.com>
 <2ac194a7-9790-4aa7-bb41-65f8bb21f616@redhat.com>
 <f02565f6-c584-44d0-944f-26c062cc2be9@gmail.com>
 <553cf07a-a603-402d-8e86-b4ada42a2dcd@redhat.com>
From: Wei Chen <weichenforschung@gmail.com>
In-Reply-To: <553cf07a-a603-402d-8e86-b4ada42a2dcd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=weichenforschung@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

 > How can you be sure (IOW trigger) that the system will store
 > "important data" like EPTs?

We cannot, but we have designed the attack (see below) to improve the
possibility.

 > So is one magic bit really that for your experiments, one needs a
 > viommu?

Admittedly the way we accomplish a VM escape is a bit arcane.

We require device passthrough because it pins the VM's memory down and
converts them to MIGRATE_UNMOVABLE. Hotplugged memory will also be
converted to MIGRATE_UNMOVABLE. That way when we give memory back to the
hypervisor, they stay UNMOVABLE. Otherwise we will have to convert the
pages to UNMOVABLE or exhaust ALL MIGRATE_MOVALE pages, both of which
cannot be easily accomplished.

Then we require vIOMMU because vIOMMU mappings, much like EPTEs, use
MIGRATE_UNMOVABLE pages as well. By spawning lots of meaningless vIOMMU
entries, we exhaust UNMOVABLE page blocks of lower orders (<9). Next
time KVM tries to allocate pages to store EPTEs, the kernel has to split
an order-9 page block, which is exactly the size of a 2MB sub-block.

 > Out of curiosity, are newer CPUs no longer affected?

When qemu pins down the VM's memory, it also establishes every possible
mapping to the VM's memory in the EPT.

To spawn new EPTEs, we exploit KVM's fix to the iTLB multihit bug.
Basically, we execute a bunch of no-op functions, and KVM will have to
split hugepages into 4KB pages. This process creates a large number of
EPTEs.

The iTLB multihit bug roughly speaking is only present on non-Atom Intel
CPUs manufactured before 2020.

 > So it won't be sufficient to have a single sub-block plugged and then
 > trigger VIRTIO_MEM_REQ_UNPLUG_ALL?

Could work in theory, but if the newly plugged sub-block does not
contain vulnerable pages, there is no promise that the attacker would
get a sub-block containing a different set of pages next time.

It also depends heavily on the configuration of the virtio-mem device.
If there is not much non-virtio-mem memory for the VM, the attacker
could easily run out of memory.


Best regards,
Wei Chen

On 2024/11/26 22:46, David Hildenbrand wrote:
> On 26.11.24 15:20, Wei Chen wrote:
>>   > Please provide more information how this is supposed to work
>>
>
> Thanks for the information. A lot of what you wrote belongs into the 
> patch description. Especially, that this might currently only be 
> relevant with device passthrough + viommu.
>
>> We initially discovered that virtio-mem could be used by a malicious
>> agent to trigger the Rowhammer vulnerability and further achieve a VM
>> escape.
>>
>> Simply speaking, Rowhammer is a DRAM vulnerability where frequent access
>> to a memory location might cause voltage leakage to adjacent locations,
>> effectively flipping bits in these locations. In other words, with
>> Rowhammer, an adversary can modify the data stored in the memory.
>>
>> For a complete attack, an adversary needs to: a) determine which parts
>> of the memory are prone to bit flips, b) trick the system to store
>> important data on those parts of memory and c) trigger bit flips to
>> tamper important data.
>>
>> Now, for an attacker who only has access to their VM but not to the
>> hypervisor, one important challenge among the three is b), i.e., to give
>> back the memory they determine as vulnerable to the hypervisor. This is
>> where the pitfall for virtio-mem lies: the attacker can modify the
>> virtio-mem driver in the VM's kernel and unplug memory proactively.
>
> But b), as you write, is not only about giving back that memory to the 
> hypervisor. How can you be sure (IOW trigger) that the system will 
> store "important data" like EPTs?
>
>>
>> The current impl of virtio-mem in qemu does not check if it is valid for
>> the VM to unplug memory. Therefore, as is proved by our experiments,
>> this method works in practice.
>>
>>   > whether this is a purely theoretical case, and how relevant this 
>> is in
>>   > practice.
>>
>> In our design, on a host machine equipped with certain Intel processors
>> and inside a VM that a) has a passed-through PCI device, b) has a vIOMMU
>> and c) has a virtio-mem device, an attacker can force the EPT to use
>> pages that are prone to Rowhammer bit flips and thus modify the EPT to
>> gain read and write privileges to an arbitrary memory location.
>>
>> Our efforts involved conducting end-to-end attacks on two separate
>> machines with the Core i3-10100 and the Xeon E2124 processors
>> respectively, and has achieved successful VM escapes.
>
> Out of curiosity, are newer CPUs no longer affected?
>
>>
>>   > Further, what about virtio-balloon, which does not even support
>>   > rejecting requests?
>>
>> virtio-balloon does not work with device passthrough currently, so we
>> have yet to produce a feasible attack with it.
>
> So is one magic bit really that for your experiments, one needs a viommu?
>
> The only mentioning of rohammer+memory ballooning I found is: 
> https://www.whonix.org/pipermail/whonix-devel/2016-September/000746.html
>
>>
>>   > I recall that that behavior was desired once the driver would 
>> support
>>   > de-fragmenting unplugged memory blocks.
>>
>> By "that behavior" do you mean to unplug memory when size <=
>> requested_size? I am not sure how that is to be implemented.
>
> To defragment, the idea was to unplug one additional block, so we can 
> plug another block.
>
>>
>>   > Note that VIRTIO_MEM_REQ_UNPLUG_ALL would still always be allowed
>>
>> That is true, but the attacker will want the capability to release a
>> specific sub-block.
>
> So it won't be sufficient to have a single sub-block plugged and then 
> trigger VIRTIO_MEM_REQ_UNPLUG_ALL?
>
>>
>> In fact, a sub-block is still somewhat coarse, because most likely there
>> is only one page in a sub-block that contains potential bit flips. When
>> the attacker spawns EPTEs, they have to spawn enough to make sure the
>> target page is used to store the EPTEs.
>>
>> A 2MB sub-block can store 2MB/4KB*512=262,144 EPTEs, equating to at
>> least 1GB of memory. In other words, the attack program exhausts 1GB of
>> memory just for the possibility that KVM uses the target page to store
>> EPTEs.
>
> Ah, that makes sense.
>
> Can you compress what you wrote into the patch description? Further, I 
> assume we want to add a Fixes: tag and Cc: QEMU Stable 
> <qemu-stable@nongnu.org>
>
> Thanks!
>

