Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB72C25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 19:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s98cW-0003tI-FD; Mon, 20 May 2024 15:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s98cU-0003t5-HC
 for qemu-devel@nongnu.org; Mon, 20 May 2024 15:24:26 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s98cR-0004eN-VU
 for qemu-devel@nongnu.org; Mon, 20 May 2024 15:24:26 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f44a2d1e3dso226082b3a.3
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 12:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716233062; x=1716837862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ojHxLGdPp0BgwnVuH4SV3rTtMAWpd2lmvZ2KaDLb59Y=;
 b=KuC4jVLnGy9662HPosqzam8xtf/iK0kaoFGOTMRaa2g0x13Ft7n9oJ/yqUFYViTQGy
 g2lFQim6jBMPqMxGhw/4QmCZvu4T1akP1oezIf8gq3bm4ph0cOmx0GM0hlFgDjSGr5xQ
 kzTRGDksNpUQKrwcEHN4X8wVBMR5s9/5d4QlmxgTww12RyA9lkeaQtJUV8U5HTn4JXfy
 mRw55imxAn2b9rmgENEfE7NS4B8w1bxVxNLEeQ1VaJBAHCjTPeeSKljA7q4Z6W7R/3vA
 AdkYZnnpqrTs0D57XkBZg4m3F2st3VUC3g7CCFA0ZgzEPuZtj51SMK7Sn+HkIRGXBiJU
 J1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716233062; x=1716837862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ojHxLGdPp0BgwnVuH4SV3rTtMAWpd2lmvZ2KaDLb59Y=;
 b=ZobYyLQ6OGgFF00vhd85YpHNLYafB/z2POBNJsQ1v71/JZpBS9YwBmCISF/d4NqEs6
 dzKlnb8YPPeox7qF9RE45MixkbD7M1KoxEj0SIh8J1ae3RtVdGo3AznpVWKpOxpuP5PV
 /EkfNxObUvbzUkX2jLorlxG/OloQ67kU7jkzSeUAzJ7NqFfs+wz4pctlCk/hCLKLnolv
 FfuIeppMy0JZykOUTgHojye14Mwb0UKcd1MrB3LVlo5z5WTbZijgWIo279NuIm7XtIdX
 3DSI2ZMvOojJ8tzy4qFdVG5mpMRYLDuKhVch6798Kb0OCAbCW9ay8eJO3CUG8p1llWjW
 X7zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt6ftPbVBAgZTEACkiFp1LtnilhnCC27MeN6vuuSSMSVJkjrfFlI/Z8nRB4bMRs6c6gHr8pD7gVP4pvqJmfhyL396Pi/c=
X-Gm-Message-State: AOJu0YzO4PrtpGt86bRUFJx2sEupeUyZevV3L9KrFRLCYLjvzKB3KC6i
 GZYVk9geeIO1iF4Y/lj3M/WST/tELmWDI53VTH5/99MAf2g1Wif/O946ogvvcDY=
X-Google-Smtp-Source: AGHT+IEGcVHn876iYmzpwBQZIbW8MU/amP8HvzIjGzufYtXPqeKEa3Ytq750oJBaVZiboUzDIC9diw==
X-Received: by 2002:a05:6a00:4f86:b0:6f3:e6ac:1a3f with SMTP id
 d2e1a72fcca58-6f4e02ad970mr35551506b3a.11.1716233062202; 
 Mon, 20 May 2024 12:24:22 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:4196:f8dc:1a46:f594:fa63?
 ([2804:7f0:bcc0:4196:f8dc:1a46:f594:fa63])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f694647472sm5683798b3a.199.2024.05.20.12.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 12:24:21 -0700 (PDT)
Message-ID: <20d0e737-0948-4df2-8a2d-bb438f323fa3@ventanamicro.com>
Date: Mon, 20 May 2024 16:24:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/virt: Add hotplugging and virtio-md-pci support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>
References: <20240514110615.399065-1-bjorn@kernel.org>
 <3cb00bbb-7742-40b7-858c-4bdd2f9cc79b@ventanamicro.com>
 <875xv8wcxq.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <875xv8wcxq.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/20/24 15:33, Björn Töpel wrote:
> Daniel,
> 
> Thanks for taking a look!
> 
> Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:
> 
>> Hi Björj,
>>
>> On 5/14/24 08:06, Björn Töpel wrote:
>>> From: Björn Töpel <bjorn@rivosinc.com>
>>>
>>> Virtio-based memory devices allows for dynamic resizing of virtual
>>> machine memory, and requires proper hotplugging (add/remove) support
>>> to work.
>>>
>>> Enable virtio-md-pci with the corresponding missing hotplugging
>>> callbacks for the RISC-V "virt" machine.
>>>
>>> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
>>> ---
>>> This is basic support for MHP that works with DT. There some minor
>>> ACPI SRAT plumbing in there as well. Ideally we'd like proper ACPI MHP
>>> support as well. I have a branch [1], where I've applied this patch,
>>> plus ACPI GED/PC-DIMM MHP support on top of Sunil's QEMU branch
>>> (contains some ACPI DSDT additions) [2], for the curious/brave ones.
>>> However, the ACPI MHP support this is not testable on upstream Linux
>>> yet (ACPI AIA support, and ACPI NUMA SRAT series are ongoing).
>>>
>>> I'll follow-up with proper ACPI GED/PC-DIMM MHP patches, once the
>>> dependencies land (Linux kernel and QEMU).
>>>
>>> I'll post the Linux MHP/virtio-mem v2 patches later this week!
>>>
>>>
>>> Cheers,
>>> Björn
>>>
>>> [1] https://github.com/bjoto/qemu/commits/virtio-mem-pc-dimm-mhp-acpi/
>>> [2] https://lore.kernel.org/linux-riscv/20240501121742.1215792-1-sunilvl@ventanamicro.com/
>>> ---
>>>    hw/riscv/Kconfig           |  2 ++
>>>    hw/riscv/virt-acpi-build.c |  7 +++++
>>>    hw/riscv/virt.c            | 64 +++++++++++++++++++++++++++++++++++++-
>>>    hw/virtio/virtio-mem.c     |  2 +-
>>>    4 files changed, 73 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>>> index a2030e3a6ff0..08f82dbb681a 100644
>>> --- a/hw/riscv/Kconfig
>>> +++ b/hw/riscv/Kconfig
>>> @@ -56,6 +56,8 @@ config RISCV_VIRT
>>>        select PLATFORM_BUS
>>>        select ACPI
>>>        select ACPI_PCI
>>> +    select VIRTIO_MEM_SUPPORTED
>>> +    select VIRTIO_PMEM_SUPPORTED
>>>    
>>>    config SHAKTI_C
>>>        bool
>>> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
>>> index 0925528160f8..6dc3baa9ec86 100644
>>> --- a/hw/riscv/virt-acpi-build.c
>>> +++ b/hw/riscv/virt-acpi-build.c
>>> @@ -610,6 +610,13 @@ build_srat(GArray *table_data, BIOSLinker *linker, RISCVVirtState *vms)
>>>            }
>>>        }
>>>    
>>> +    if (ms->device_memory) {
>>> +        build_srat_memory(table_data, ms->device_memory->base,
>>> +                          memory_region_size(&ms->device_memory->mr),
>>> +                          ms->numa_state->num_nodes - 1,
>>> +                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
>>> +    }
>>> +
>>>        acpi_table_end(linker, &table);
>>
>> When the time comes I believe we'll want this chunk in a separated ACPI patch.
> 
> Hmm, I first thought about adding this to the ACPI MHP series, but then
> realized that virtio-mem relies on SRAT for ACPI boots (again -- RISC-V
> Linux does not support that upstream yet...).
> 
> Do you mean that you'd prefer this chunk in a separate patch?

TBH I wouldn't mind keeping this ACPI chunk here but I reckon that the ACPI
subsystem review is usually done in separate, with a different set of people
reviewing it and so on.

We might as well keep it here for now. If more ACPI changes ended up being done
(e.g. ACPI unit test changes) then doing a separated ACPI patch makes more sense.


Thanks,

Daniel


> 
> 
> Björn

