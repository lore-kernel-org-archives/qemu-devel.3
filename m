Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70040C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4M5C-0003JY-Jr; Tue, 07 May 2024 10:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4M5A-0003Iz-3V
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:46:16 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4M56-00025p-13
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:46:14 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51f1e8eaee5so4330482e87.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715093170; x=1715697970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gYH1ud2ljraba1V8x5nofImDlQbBq2i1pB8J1ktnG7A=;
 b=oujDJDtN1vk8STTTa2WFE6bHp38Dj2D+2uQ6Zd2E4VyOjUKBiU2AoEdNzWrb3WxS4B
 vrhNFHt92Mj3Otx4JtlpTZG6SKIteVQXfKeZZ3sr5KXxHzcoeCEZJ6BKqm00kACwm/0x
 umsrT0Tv9raGaZ6Y4G7AD77SrD7h/ZZSLcrnLGIcMlqTpK/rLU1NPqYBEhKuBqwCIALp
 HRyBxdDUXwDQ0LOOTNWFcf3wJFPBy9JNxXXrioYmPI8EKAPzT9nvdUBSWjLvOw3ebwO6
 Fj1CmW4bkaOY7VRI634ApSkNHUsXX8fHYXkMzhxKxIUuXGdoKnuBQU15rSk+PzbHIBhe
 7Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715093170; x=1715697970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gYH1ud2ljraba1V8x5nofImDlQbBq2i1pB8J1ktnG7A=;
 b=XgqV1TzROSbx/g7H+Nz1xCNyZ1ou5IfDMYvsixAPp58kiIJANORQf60BWP2AnHBC0B
 FQsXIBguCbwQunH28GUIfrRhN9M/eFj+stqKpcZH83UalhSlM982DvlvyFWXdGCfxvYX
 205eZBY9UBuaUYzNWd/wJ2JGD4AjEh3zoxtvDGwByaBPUWzxNVjVpa6OhQE8MdjrD7ld
 KumLOl519SqavJagcVpIckAv2VgdvEAIXCmn48kbOYSCi9pwwPU9Xc0TD/eLoDS9p9fw
 8iBN2bfxmjqbt9nC28DnFyu1Styr13ReDsTW8/85sIo2AhsteJZIWeQaswZUsptEGp4Q
 rorA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXLFItp2IKaKIEZGooz7Kg70lFdxNhQnIC/NJZLEqZOy7TImrB4WMnFzW1QH0T3adPo33FDUswcJnLGDkzoyVPjhf3GUM=
X-Gm-Message-State: AOJu0YyLYUngB7wqAfJjW68j5Zhda8Bqt0/poIzs8K20Vm/nmwZe+nh0
 XGrnHvlUv82vT5v7N6GsTYUkdywg6sl9WicsYYLFGpkJ+ey3r1dmu/wC4jNQHGg=
X-Google-Smtp-Source: AGHT+IGO16LSv18T9rRqBgYK+kvZRvs5GzIeKfsjt2j6M3Es47p1HzfVUOibsjVQGpzRaaQMuMjDRg==
X-Received: by 2002:a05:6512:542:b0:51f:30dd:f35f with SMTP id
 2adb3069b0e04-52175623cc4mr10248e87.14.1715093169861; 
 Tue, 07 May 2024 07:46:09 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 w19-20020a05651234d300b0051e51cd61edsm2154929lfr.139.2024.05.07.07.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 07:46:09 -0700 (PDT)
Message-ID: <b239ed9c-df6c-4785-91cc-fb7139997209@linaro.org>
Date: Tue, 7 May 2024 16:46:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/5] softmmu: Support concurrent bounce buffers
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 jag.raman@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, john.levon@nutanix.com
References: <20240507094210.300566-1-mnissler@rivosinc.com>
 <20240507094210.300566-3-mnissler@rivosinc.com>
 <447ddc5a-ae1e-4fd1-b03a-dd7e1faa46e9@linaro.org>
 <CAGNS4Tb1FVFmzVLvSZD84n0q80bwDiAMaSr752jb4nDwkGHSjA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAGNS4Tb1FVFmzVLvSZD84n0q80bwDiAMaSr752jb4nDwkGHSjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

On 7/5/24 16:04, Mattias Nissler wrote:
> On Tue, May 7, 2024 at 2:57 PM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 7/5/24 11:42, Mattias Nissler wrote:
>>> When DMA memory can't be directly accessed, as is the case when
>>> running the device model in a separate process without shareable DMA
>>> file descriptors, bounce buffering is used.
>>>
>>> It is not uncommon for device models to request mapping of several DMA
>>> regions at the same time. Examples include:
>>>    * net devices, e.g. when transmitting a packet that is split across
>>>      several TX descriptors (observed with igb)
>>>    * USB host controllers, when handling a packet with multiple data TRBs
>>>      (observed with xhci)
>>>
>>> Previously, qemu only provided a single bounce buffer per AddressSpace
>>> and would fail DMA map requests while the buffer was already in use. In
>>> turn, this would cause DMA failures that ultimately manifest as hardware
>>> errors from the guest perspective.
>>>
>>> This change allocates DMA bounce buffers dynamically instead of
>>> supporting only a single buffer. Thus, multiple DMA mappings work
>>> correctly also when RAM can't be mmap()-ed.
>>>
>>> The total bounce buffer allocation size is limited individually for each
>>> AddressSpace. The default limit is 4096 bytes, matching the previous
>>> maximum buffer size. A new x-max-bounce-buffer-size parameter is
>>> provided to configure the limit for PCI devices.
>>>
>>> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
>>> ---
>>>    hw/pci/pci.c                |  8 ++++
>>>    include/exec/memory.h       | 14 +++----
>>>    include/hw/pci/pci_device.h |  3 ++
>>>    system/memory.c             |  5 ++-
>>>    system/physmem.c            | 82 ++++++++++++++++++++++++++-----------
>>>    5 files changed, 76 insertions(+), 36 deletions(-)


>>>    /**
>>>     * struct AddressSpace: describes a mapping of addresses to #MemoryRegion objects
>>> @@ -1143,8 +1137,10 @@ struct AddressSpace {
>>>        QTAILQ_HEAD(, MemoryListener) listeners;
>>>        QTAILQ_ENTRY(AddressSpace) address_spaces_link;
>>>
>>> -    /* Bounce buffer to use for this address space. */
>>> -    BounceBuffer bounce;
>>> +    /* Maximum DMA bounce buffer size used for indirect memory map requests */
>>> +    uint32_t max_bounce_buffer_size;
>>
>> Alternatively size_t.
> 
> While switching things over, I was surprised to find that
> DEFINE_PROP_SIZE wants a uint64_t field rather than a size_t field.
> There is a DEFINE_PROP_SIZE32 variant for uint32_t though. Considering
> my options, assuming that we want to use size_t for everything other
> than the property:
> 
> (1) Make PCIDevice::max_bounce_buffer_size size_t and have the
> preprocessor select DEFINE_PROP_SIZE/DEFINE_PROP_SIZE32. This makes
> the qdev property type depend on the host. Ugh.
> 
> (2) Make PCIDevice::max_bounce_buffer_size uint64_t and clamp if
> needed when used. Weird to allow larger values that are then clamped,
> although it probably doesn't matter in practice since address space is
> limited to 4GB anyways.
> 
> (3) Make PCIDevice::max_bounce_buffer_size uint32_t and accept the
> limitation that the largest bounce buffer limit is 4GB even on 64-bit
> hosts.
> 
> #3 seemed most pragmatic, so I'll go with that.

LGTM, thanks for updating.

> 
> 
>>
>>> +    /* Total size of bounce buffers currently allocated, atomically accessed */
>>> +    uint32_t bounce_buffer_size;
>>
>> Ditto.


