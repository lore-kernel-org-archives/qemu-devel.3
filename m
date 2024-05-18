Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA55C25B79
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 19:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8Q4V-0007TS-Mo; Sat, 18 May 2024 15:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1s8Q4U-0007T6-9y
 for qemu-devel@nongnu.org; Sat, 18 May 2024 15:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1s8Q4S-0003sx-9Q
 for qemu-devel@nongnu.org; Sat, 18 May 2024 15:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716061818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ik2FYn6ZAfyD9RE9THJNGjY5gnm7Y2tSbx66/Qw1adY=;
 b=BF3ca8wYZB2K0n0/D3HpZHyspEB3vPKuuhJUIBCi9nZtD0BphzRGcmG3wJ6vModYIErKa9
 ZYtJzxOsrQPckWONmQB6FT/L3EFHCLm9nxEx2mOv8fMg5mBqG0t2rRp7NA2X9+NNYefiwY
 ADQXPQAynv9ncu/lvA2cLI5jh53+gYs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-3rvb7xslNj-xyct6xKZGvg-1; Sat, 18 May 2024 15:50:16 -0400
X-MC-Unique: 3rvb7xslNj-xyct6xKZGvg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41fda32e6c0so50448935e9.1
 for <qemu-devel@nongnu.org>; Sat, 18 May 2024 12:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716061815; x=1716666615;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ik2FYn6ZAfyD9RE9THJNGjY5gnm7Y2tSbx66/Qw1adY=;
 b=SKpbbBsr2Cv5IgKALfyN8mCfkUh5tRjTZxqxLgIf6hSUaHcqKJetU/ErOSt0FyXik2
 2YL4N/V0cCtreH8OLpP4Zcvr5/BiEbqrNJV9vxmJgoXi1qE7HDZkNzGTtRXNL3EwZp1Y
 fNLyEqd9TccKoMYhGupm+OGOSCqm1IS/Xcy0MdU/1fjmmz71uFGyAgN+0jhRqiiZrhNM
 9mcucGVW9siLIA+XMqq9SDrjnpyeoTJbFwcX8VvM5mcOunj7im25Dg3EcbBRjckc7Z7P
 dmjt3gUcBAVpvPyuNs9T6YJMh2nkLVRVDCREYycB2OLQQfjgpmCcD9cMVIFlFAZqr3sL
 VJRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2M3dqmIUlH0zHgc8arOX2QCYrIBDI2gMet7dIkzmAFIu0TUi1A/NE7A1qwSFbutbXFjIVY/pxQrLc6648DETlr5hKC5U=
X-Gm-Message-State: AOJu0YxsVe0EYxCEoMfq1Ul8rgQCKct8uNAGKmWR/2mRWV76QzUhkbT7
 p8zsibcVQk3lNtUv3yZENb0q9+jQhujzmc0J1yVgWn44rNRjhAptJSNyqtHsZM50qgIE3HSF1l6
 EPTkiDQKk/ePdQCVZop7q1JggOoJE9Kd7IXVG7T7+yipwipV7bEUh
X-Received: by 2002:a05:600c:1f84:b0:41a:4623:7ee9 with SMTP id
 5b1f17b1804b1-420e19e5b9emr19758015e9.10.1716061815351; 
 Sat, 18 May 2024 12:50:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8oEJr9TgURuMp6M4wxOO9+i4gDrbxIA77pwKdXMcnp71CTR8dpXBycPqqdsHef7cWHsetXw==
X-Received: by 2002:a05:600c:1f84:b0:41a:4623:7ee9 with SMTP id
 5b1f17b1804b1-420e19e5b9emr19757915e9.10.1716061814802; 
 Sat, 18 May 2024 12:50:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70f:e000:a92d:eec0:6582:6a06?
 (p200300cbc70fe000a92deec065826a06.dip0.t-ipconnect.de.
 [2003:cb:c70f:e000:a92d:eec0:6582:6a06])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42012d08bb9sm252505655e9.48.2024.05.18.12.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 May 2024 12:50:14 -0700 (PDT)
Message-ID: <91086379-1fbc-4179-863a-6bb2e797d564@redhat.com>
Date: Sat, 18 May 2024 21:50:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/virt: Add hotplugging and virtio-md-pci support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>
References: <20240514110615.399065-1-bjorn@kernel.org>
 <3cb00bbb-7742-40b7-858c-4bdd2f9cc79b@ventanamicro.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3cb00bbb-7742-40b7-858c-4bdd2f9cc79b@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.039,
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


Hi,


>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index 4fdb66052587..16c2bdbfe6b6 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -53,6 +53,8 @@
>>    #include "hw/pci-host/gpex.h"
>>    #include "hw/display/ramfb.h"
>>    #include "hw/acpi/aml-build.h"
>> +#include "hw/mem/memory-device.h"
>> +#include "hw/virtio/virtio-mem-pci.h"
>>    #include "qapi/qapi-visit-common.h"
>>    #include "hw/virtio/virtio-iommu.h"
>>    
>> @@ -1407,6 +1409,7 @@ static void virt_machine_init(MachineState *machine)
>>        DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
>>        int i, base_hartid, hart_count;
>>        int socket_count = riscv_socket_count(machine);
>> +    hwaddr device_memory_base, device_memory_size;
>>    
>>        /* Check socket count limit */
>>        if (VIRT_SOCKETS_MAX < socket_count) {
>> @@ -1553,6 +1556,25 @@ static void virt_machine_init(MachineState *machine)
>>        memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
>>                                    mask_rom);
>>    
>> +    device_memory_base = ROUND_UP(s->memmap[VIRT_DRAM].base + machine->ram_size,
>> +                                  GiB);
>> +    device_memory_size = machine->maxram_size - machine->ram_size;
>> +
>> +    if (riscv_is_32bit(&s->soc[0])) {
>> +        hwaddr memtop = device_memory_base + ROUND_UP(device_memory_size, GiB);
>> +
>> +        if (memtop > UINT32_MAX) {
>> +            error_report("Memory exceeds 32-bit limit by %lu bytes",
>> +                         memtop - UINT32_MAX);
>> +            exit(EXIT_FAILURE);
>> +        }
>> +    }
>> +
>> +    if (device_memory_size > 0) {
>> +        machine_memory_devices_init(machine, device_memory_base,
>> +                                    device_memory_size);
>> +    }
>> +
> 
> I think we need a design discussion before proceeding here. You're allocating all
> available memory as a memory device area, but in theory we might also support
> pc-dimm hotplugs (which would be the equivalent of adding physical RAM dimms to
> the board.) in the future too. If you're not familiar with this feature you can
> check it out the docs in [1].

Note that DIMMs are memory devices as well. You can plug into the memory 
device area both, ACPI-based memory devices (DIMM, NVDIMM) or 
virtio-based memory devices (virtio-mem, virtio-pmem).

> 
> As an example, the 'virt' ARM board (hw/arm/virt.c) reserves a space for this
> type of hotplug by checking how much 'ram_slots' we're allocating for it:
> 
> device_memory_size = ms->maxram_size - ms->ram_size + ms->ram_slots * GiB;
> 

Note that we increased the region size to be able to fit most requests 
even if alignment of memory devices is weird. See below.

In sane setups, this is usually not required (adding a single additional 
GB for some flexiility might be good enough).

> Other boards do the same with ms->ram_slots. We should consider doing it as well,
> now, even if we're not up to the point of supporting pc-dimm hotplug, to avoid
> having to change the memory layout later in the road and breaking existing
> setups.
> 
> If we want to copy the ARM board, ram_slots is capped to ACPI_MAX_RAM_SLOTS (256).
> Each RAM slot is considered to be a 1GiB dimm, i.e. we would reserve 256GiB for
> them.

This only reserves some *additional* space to fixup weird alignment of 
memory devices. *not* the actual space for these devices.

We don't consider each DIMM to be 1 GiB in size, but add an additional 1 
GiB in case we have to align DIMMs in physical address space.

I *think* this dates back to old x86 handling where we aligned the 
address of each DIMM to be at a 1 GiB boundary. So if you would have 
plugged two 128 MiB DIMMs, you'd have required more than 256 MiB of 
space in the area after aligning inside the memory device area.

> 
> Note: I do not have the visibility of discussions on the memory management space,
> and I might be missing details such as "we don't care about pc-dimm hotplug
> anymore, it's legacy, we're going to support only virtio-md-pci from now on". We
> had a situation like that with virtio-balloon and virtio-mem in the past, and I'm
> not sure if this might fall in the same category.

Not sure if I got your comment right, but virtio-mem was never supposed 
to be a virtio-balloon replacement (especially of the 
free-page-reporting and memory stats part).

> 
> I see that David Hildenbrand is also CCed in the patch so he'll let us know if
> I'm out of line with what I'm asking.

Supporting PC-DIMMs might be required at some point when dealing with 
OSes that don't support virtio-mem and friends.

-- 
Cheers,

David / dhildenb


