Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840A110A88E5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5n7x-0003Yk-Bo; Thu, 26 Mar 2026 12:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5n7u-0003WI-Cy
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:00:06 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5n7r-0000uo-Cc
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:00:06 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2b0ba3bfe16so11450205ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 09:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774540801; x=1775145601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lpblExgXcFScHHXpUbGacXULwolEaIZ5lYqJF2JH4Tg=;
 b=YPt8seQxQw5fhbNnzg+qz3urGSsg8JD/bpnjOkjF1bXYauTNavEztJmoARYSufN0Gw
 tdB2SHUB1hD5yP4BSZLBEz7ufe2BNfjJBZKaBA1SHXb16gK7GnZenWvvMQDWbUZe3A3B
 tMTXA5LRzQm7a5m/qoasiuOorGZ1E7aM2JRAaZlTmTpxMfXfhbXPbYdBs93YLDFZR7cp
 RfsT6lp3JZxta3XZHr/mWEOu/L2JYlc1yy26NlXX+uMAvTY+AotVciQYhbrUz0gE7aIU
 vFi1wvKzNMAIZ7ArHseGDABPFiF1dpJrRjKwl8edHlJgxH8kWeoZSKdTA9aDkf+KL7SY
 9mKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774540801; x=1775145601;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lpblExgXcFScHHXpUbGacXULwolEaIZ5lYqJF2JH4Tg=;
 b=R3rzApIKSxbqzlRa1CZXVxytNpmvrsjdsI+AzQMd9be+FXy4+bYJ7XZHJEDX5EgaXQ
 CwUBPNgXzPvaBRSNpDMX33J3y0qfXLsrIkRdnA+iBmpwdElZBD7PmqxrN3NRzGEMY+G8
 RBvVVgY9fTM/8OwAXa8nXIX1BQf/qFlt+sARQHuAbpFoYFohzuH0Xi7w0xA/ZXSGf6gb
 u/f/P100jm7U5BabuzREV5DDZHNsoTtDbk2Qa1QEEBuNhi/fHSHKRxkRrtoeFi15IGb1
 3sW3+5Wni/byWmmGqew2p4cA56nj/bXXC8+LbURJORyhVWX1EgJHz53GpQaJyJ5PMLYu
 h5rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvd5RJ3/o17xK6AZlO2XujqSPDBhhw+POBiXN96wg3qTtFhakP0PslzHqAuq43FKSugbGONbEpbNIK@nongnu.org
X-Gm-Message-State: AOJu0Yzoe3gALLguWuV0pY8Wl5kXT9n43mP4L44QrW2LnU3ij0H4zyAt
 BWqswJMOVVZL0CnjvsIeBUfXY/oSgJz+sS4DCtyOHT32Kpz87++9f7wwtKp+v9MnSO8=
X-Gm-Gg: ATEYQzztBbef/4Cca2lXsDLYNKO2sYM0mwAah+albpu7Zpktj4h887L+UBENVMwg574
 FiCXo0ccl2TbUgyFncTHViDDQIyfmA03kE273NWgsJTqe/UnWrFAAfebz1E46m1YI2r2fs1+M6J
 dqmO5yNKbKnkxRHMzi+EanxwySq0iRJpDzwBz5e0NXvFHh79U03E8GvAnJTJBlgsevNaqV+L8f3
 zjrAIaeTHN+r/HzWIAFBpk/ullPQn6FNuxLYDdW/uMcrnncQqI5/2Fju+XwdndkCvdDVSMV+hIe
 cZK5BPRYokM7BPGTrPTog8TVrCyapHeNnHfBGGuMnBTTOD18LaffPfN2GbiKB47vw1jF9hGwVpp
 cBOoUhDKseZ3yhpYgFgIjCEET6OeKMHTgISLMRxsy4daVB0hjjXeUeEq3BidENYRXzMvfaKGwo/
 TBJz/TziI5JMWpJr6MXGckTkXaCiZM/Gym3tecqKBnEUV2mV0DT/EBXF44w4TsrYlvQE5b
X-Received: by 2002:a17:903:2449:b0:2b0:91e6:bc19 with SMTP id
 d9443c01a7336-2b0c4818b1amr20668975ad.2.1774540801105; 
 Thu, 26 Mar 2026 09:00:01 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc7afad1sm41554475ad.31.2026.03.26.09.00.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 09:00:00 -0700 (PDT)
Message-ID: <ebb0227f-87c1-4436-b48b-10f5dc150884@linaro.org>
Date: Thu, 26 Mar 2026 08:59:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] plugins: Introduce Fault Injection framework and
 API extensions
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Ruslan Ruslichenko <ruslichenko.r@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, philmd@linaro.org, Ruslan_Ruslichenko@epam.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260318104640.239752-1-ruslichenko.r@gmail.com>
 <4e8f4e6e-e9d2-4457-af3d-755ced6d2a45@linaro.org>
 <CAN-aV1FER7w1rqw0zM=L2z7MT_RKsBhFg7m6NijxyQa6t5JNqw@mail.gmail.com>
 <4d2d16df-0047-4b96-8312-46489ba0f1bf@linaro.org>
 <CAN-aV1F6O3dv5F1946wEugdLxkYDp0BW6QZPxwye02A5-HYz9g@mail.gmail.com>
 <79fca2cf-7618-4a35-a915-e2bf1811a851@linaro.org>
 <CAN-aV1HRZPxuS_U4mHYhnobbKkq2G5T9P2cJ2=LahT3TzGsC6A@mail.gmail.com>
 <005aa40d-4749-44d5-a65c-8f59cbd06d0c@linaro.org>
 <87a4vu3jcn.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <87a4vu3jcn.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/26/26 4:45 AM, Alex Bennée wrote:
> 
> (adding Richard to Cc)
> 
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 3/25/26 4:39 PM, Ruslan Ruslichenko wrote:
>>> On Fri, Mar 20, 2026 at 7:08 PM Pierrick Bouvier
>>> <pierrick.bouvier@linaro.org> wrote:
>>>>
>>>> On 3/19/26 3:29 PM, Ruslan Ruslichenko wrote:
>>>>> On Thu, Mar 19, 2026 at 8:04 PM Pierrick Bouvier
>>>>> <pierrick.bouvier@linaro.org> wrote:
>>>>>>
>>>>>> On 3/19/26 11:20 AM, Ruslan Ruslichenko wrote:
>>>>>>> Hi Pierrick,
>>>>>>>
>>>>>>> Thank you for the feedback and review!
>>>>>>>
>>>>>>> Our current plan is to put this plugin through our internal workflows to gather
>>>>>>> more data on its limitations and performance.
>>>>>>> Based on results, we may consider extending or refining the implementation
>>>>>>> in the future.
>>>>>>>
>>>>>>> Any further feedback on potential issues is highly appreciated.
>>>>>>>
>>>>>>
>>>>>> By design, the approach of modifying QEMU internals to allow to inject
>>>>>> IRQ, set a timer, or trigger SMMU has very few chances to be integrated
>>>>>> as it is. At least, it should be discussed with the concerned
>>>>>> maintainers, and see if they would be open to it or not.
>>>>>>
>>>>>> It's not wrong in itself, if you want a downstream solution, but it does
>>>>>> not scale upstream if we have to consider and accept everyone's needs.
>>>>>> The plugin API in itself can accept the burden for such things, but it's
>>>>>> harder to justify for internal stuff.
>>>>>>
>>>>>> I believe it would be better to rely on ad hoc devices generating this,
>>>>>> with the advantage that even if they don't get accepted upstream, it
>>>>>> will be more easy for you to maintain them downstream compared to more
>>>>>> intrusive patches.
>>>>>>
>>>>>>> On Wed, Mar 18, 2026 at 6:16 PM Pierrick Bouvier
>>>>>>> <pierrick.bouvier@linaro.org> wrote:
>>>>>>>>
>>>>>>>> Hi Ruslan,
>>>>>>>>
>>>>>>>> On 3/18/26 3:46 AM, Ruslan Ruslichenko wrote:
>>>>>>>>> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>>>>>>>>>
>>>>>>>>> This patch series is submitted as an RFC to gather early feedback on a Fault Injection (FI) framework built on top of the QEMU TCG plugin subsystem.
>>>>>>>>>
>>>>>>>>> Motivation
>>>>>>>>>
>>>>>>>>> Testing guest operating systems, hypervisors (like Xen), and low-level drivers against unexpected hardware failures can be difficult.
>>>>>>>>> This series provides an interface to inject faults dynamically without altering QEMU's core emulation source code for every test case.
>>>>>>>>>
>>>>>>>>> Architecture & Key Features
>>>>>>>>>
>>>>>>>>> The series introduces the core API extensions and implements a fault injection plugin (contrib/plugins/fault_injection.c) targeting AArch64.
>>>>>>>>> The plugin can be controlled statically via XML configurations on boot, or dynamically at runtime via a UNIX socket (enabling integration with automated testing frameworks via Python or GDB).
>>>>>>>>>
>>>>>>>>> New Plugin API Capabilities:
>>>>>>>>>
>>>>>>>>> MMIO Interception: Allows plugins to hook into memory_region_dispatch_read/write to modify hardware register reads or drop writes.
>>>>>>>>> Asynchronous Timers: Exposes QEMU_CLOCK_VIRTUAL to plugins, allowing callbacks to be scheduled based on guest virtual time.
>>>>>>>>> TB Cache Flushing: Exposes qemu_plugin_flush_tb_cache() so plugins can force re-translation when applying dynamic PC-based hooks.
>>>>>>>>> Interrupt & Exception Injection: Exposes APIs to raise/pulse hardware IRQs on the primary INTC and inject CPU exceptions (e.g., SErrors).
>>>>>>>>> Custom Device Faults: Introduces a registry where device models (e.g., SMMUv3) can expose specific fault handlers (like CMDQ errors) to be triggered externally by plugins.
>>>>>>>>>
>>>>>>>>> Patch Summary
>>>>>>>>> Patch 1 (target/arm): Adds support for asynchronous CPU exception injection.
>>>>>>>>> Patch 2-3 (plugins/api): Exposes virtual clock timers and TB cache flushing to the public plugin API.
>>>>>>>>> Patch 4 (plugins): Introduces the core fault injection subsystem, IRQ/Exception routing, and the Custom Fault registry.
>>>>>>>>> Patch 5 (system/memory): Adds the MMIO override hooks into the memory dispatch path.
>>>>>>>>> Patch 6 (hw/intc): Registers the ARM GIC (v2/v3) with the plugin subsystem to enable direct hardware IRQ injection.
>>>>>>>>> Patch 7 (hw/arm): Registers the SMMUv3 with the custom fault registry to demonstrate how device models can expose specific errors (like CMDQ faults) to plugins.
>>>>>>>>> Patch 8 (contrib/plugins): Implements the actual fault_injection plugin using the new APIs.
>>>>>>>>> Patch 9 (docs): Adds documentation and usage examples for the plugin.
>>>>>>>>>
>>>>>>>>> Request for Comments & Feedback
>>>>>>>>>
>>>>>>>>> Any suggestions on improvements, potential edge cases, or issues with the current design are highly welcome.
>>>>>>>>>
>>>>>>>>> Ruslan Ruslichenko (9):
>>>>>>>>>        target/arm: Add API for dynamic exception injection
>>>>>>>>>        plugins/api: Expose virtual clock timers to plugins
>>>>>>>>>        plugins: Expose Transaction Block cache flush API to plugins
>>>>>>>>>        plugins: Introduce fault injection API and core subsystem
>>>>>>>>>        system/memory: Add plugin callbacks to intercept MMIO accesses
>>>>>>>>>        hw/intc/arm_gic: Register primary GIC for plugin IRQ injection
>>>>>>>>>        hw/arm/smmuv3: Add plugin fault handler for CMDQ errors
>>>>>>>>>        contrib/plugins: Add fault injection plugin
>>>>>>>>>        docs: Add description of fault-injection plugin and subsystem
>>>>>>>>>
>>>>>>>>>       contrib/plugins/fault_injection.c | 772 ++++++++++++++++++++++++++++++
>>>>>>>>>       contrib/plugins/meson.build       |   1 +
>>>>>>>>>       docs/fault-injection.txt          | 111 +++++
>>>>>>>>>       hw/arm/smmuv3.c                   |  54 +++
>>>>>>>>>       hw/intc/arm_gic.c                 |  28 ++
>>>>>>>>>       hw/intc/arm_gicv3.c               |  28 ++
>>>>>>>>>       include/plugins/qemu-plugin.h     |  28 ++
>>>>>>>>>       include/qemu/plugin.h             |  39 ++
>>>>>>>>>       plugins/api.c                     |  62 +++
>>>>>>>>>       plugins/core.c                    |  11 +
>>>>>>>>>       plugins/fault.c                   | 116 +++++
>>>>>>>>>       plugins/meson.build               |   1 +
>>>>>>>>>       plugins/plugin.h                  |   2 +
>>>>>>>>>       system/memory.c                   |   8 +
>>>>>>>>>       target/arm/cpu.h                  |   4 +
>>>>>>>>>       target/arm/helper.c               |  55 +++
>>>>>>>>>       16 files changed, 1320 insertions(+)
>>>>>>>>>       create mode 100644 contrib/plugins/fault_injection.c
>>>>>>>>>       create mode 100644 docs/fault-injection.txt
>>>>>>>>>       create mode 100644 plugins/fault.c
>>>>>>>>>
>>>>>>>>
>>>>>>>> first, thanks for posting your series!
>>>>>>>>
>>>>>>>> About the general approach.
>>>>>>>> As you noticed, this is exposing a lot of QEMU internals, and it's
>>>>>>>> something we tend to avoid to do. As well, it's very architecture
>>>>>>>> specific, which is another pattern we try to avoid.
>>>>>>>>
>>>>>>>> For some of your needs (especially IRQ injection and timer injection),
>>>>>>>> did you consider writing a custom ad-hoc device and timer generating those?
>>>>>>>> There is nothing preventing you from writing a plugin that can
>>>>>>>> communicate with this specific device (through a socket for instance),
>>>>>>>> to request specific injections. I feel that it would scale better than
>>>>>>>> exposing all this to QEMU plugins API.
>>>>>>>>
>>>>>>>> For SMMU, this is trickier. Tao recently (6ce361b02c82) an iommu test
>>>>>>>> device, associated to qtest to unit test the smmu implementation. We
>>>>>>>> could maybe see to leverage that on a full machine, associated with the
>>>>>>>> communication method mentioned above, to generate specific operations at
>>>>>>>> runtime, all triggered via a plugin.
>>>>>>>>
>>>>>>>> Exposing qemu_plugin_flush_tb_cache is a hint we are missing something
>>>>>>>> on QEMU side. Better to fix it than expose this very internal function.
>>>>>>>
>>>>>>> The reason this was needed is that the plugin may receive PC trigger
>>>>>>> configuration
>>>>>>> dynamically and need to register instruction callback at runtime.
>>>>>>> If the TB for that PC is already translated and cached, our newly registered
>>>>>>> callback might not be executed.
>>>>>>>
>>>>>>> If there is a more proper way to force QEMU to re-translate a specific
>>>>>>> TB or attach
>>>>>>> a callback to cached TB it would be great to reduce the complexity here.
>>>>>>>
>>>>>>
>>>>>> I understand better. QEMU plugin current implementation is too limited
>>>>>> for this, and everything has to be done/known at translation time.
>>>>>> What is your use case for receiving PC trigger after translation? Do you
>>>>>> have some mechanism to communicate with the plugin for this?
>>>>>
>>>>> Yes, exactly. If the guest has already executed the target code, the newly
>>>>> added trigger will be ignored, as the TB is cached.
>>>>>
>>>>> For runtime configuration, the plugin spawns a background thread that listens
>>>>> on a socket. External Python test script connects to this socket to send
>>>>> dynamically generated XML faults.
>>>>>
>>>>
>>>> Ok.
>>>>
>>>> Internally, we have tb_invalidate_phys_range that will invalidate a
>>>> given range of tb. This is called when writing to memory for a given
>>>> address holding code.
>>>>
>>>> Thus from your plugin, if you write to pc address with
>>>> qemu_plugin_write_memory_vaddr, it should trigger a re-translation of
>>>> this tb. You'll need to read 1 byte, and write it back. As well, it
>>>> should be more efficient, since you will only invalidate this tb.
>>>>
>>>> Give it a try and let us know if it works for your need.
>>>>
>>> Thank you for your suggestion. This is really useful information
>>> regarding
>>> internals of tb processing.
>>> I set up a test to simulate a scenario where a TB flush is needed
>>> and used the described mechanism. However, there is a threading limitation:
>>> qemu_plugin_write_memory_vaddr() must be called from a CPU thread.
>>> In our current implementation dynamic faults are received and processed
>>> by a background thread listening on a socket, so we cannot directly
>>> use API from that context to trigger invalidation.
>>>
>>
>> Indeed, when writing to a virtual address, we need to know the current
>> execution context and page table setup to translate it. I have two
>> ideas:
>> - Register a callback per tb. When hitting a tb containing address
>>    where to inject the fault, perform the read/write described above.
> 
> You could use a conditional callback with a scoreboard (or possibly
> introduce a map feature similar to ebpf). You would track the address
> ranges and latch the scoreboard when you want to look at something more
> closely.
> 
> I wonder if allowing the TB itself to be invalidates conditionally would
> be ok? We do try really hard to avoid exposing internal implementation
> details to plugins but the concept of a block of instructions is kinda
> already baked in. However we want to avoid plugins having to track a lot
> of translation state to be useful.
>

In general yes. As explained on the thread, this plugin has a specific 
use case of instrumenting code *after* it's translated, which implies 
there is a need to track something to fulfill the need.

>> You always instrument, and selectively "poke" the code to trigger a
>> new translation.
>> - Simulate a given number of cpu watchpoints (N) by using N
>>    conditional callback on every instruction, comparing current pc to N
>>    addresses. I'm afraid it will be too slow.
> 
> I think you want at most one conditional check per instruction and then
> take the slow path to check.
>

Yes, it might be cheaper than having several conditional checks. I still 
think idea above is better.

>>
>> One thing that could be considered on API side is to add a possibility
>> to invalidate a specific hardware address (not all tb), based on
>> tb_invalidate_phys_range. The problem is that plugin now need to keep
>> track of all physical addresses matching virtual ones you want to
>> invalidate, which is not convenient.
>>
>> Else, the easiest way to solve all this is to expose tb_flush, like
>> you did, but keep this patch downstream for now.
>> If your final plugin will stay downstream (which I expect, given it
>> has its own protocol for injecting faults and no source for it), it's
>> really the cheapest solution.
>>
>> The current design is built around the assumption that instrumentation
>> is made at translation time (and not later). So changing it by
>> instrumenting after translation brings new constraints we can't solve
>> at the moment without exposing internal details.
> 
> We should certainly consider automatically triggering tb_flush() on each
> qemu_plugin_register_vcpu_tb_trans_cb() so at least the case of
> dynamically loading a plugin doesn't miss previous translations.
>

Sounds fair yes, but not sure it covers the current use case.
It would require the plugin to register several tb_trans to achieve the 
desired effect, which I'm not sure is a good idea. At this point, maybe 
we just accept to expose tb_flush through plugin API and call it a day.

>>
>>>>> There are several scenarios where this might be needed, mainly for faults that
>>>>> are difficult to define statically at boot time.
>>>>> Examples include injecting faults after specific chain of events, freezing or
>>>>> overriding system registers values at specific execution points (since this
>>>>> is currently implemented via PC triggers). Supporting environments with KASLR
>>>>> enabled might be one more case.
>>>>>
>>>>
>>>> For system registers, you can (heavy but would work) instrument
>>>> inconditionally all instructions that touch those registers, so there
>>>> would be no need to flush anything. System registers are not accessed
>>>> for every instruction, so hopefully, it should not impact too much
>>>> execution time.
>>>>
>>> Agree, this is a good optimization and indeed simplifies dynamic
>>> faults
>>> handling for system register reads.
>>> Thank you for the recommendation!
>>>
>>>> With both solutions, it should remove the need to expose tb_flush
>>>> through plugin API.
>>>>
>>>>>>
>>>>>>>> The associated TRIGGER_ON_PC is very similar to existing inline
>>>>>>>> operations. They could be enhanced to support writing to a given
>>>>>>>> register, all the bricks are there. For TRIGGER_ON_SYSREG it's a bit
>>>>>>>> more complex, but we might enhance inline operations also to support
>>>>>>>> hooks on specific register writes.
>>>>>>>
>>>>>>> TRIGGER_ON_PC may also be used for generating other faults too. For example,
>>>>>>> one use-case is to trigger CPU exceptions on specific instructions.
>>>>>>> Supporting TRIGGER_ON_SYSREG as an inline operation sounds like a
>>>>>>> really interesting
>>>>>>> direction to explore.
>>>>>>>
>>>>>>
>>>>>> In general, having inline operations support on register read/writes
>>>>>> would be a very nice thing to have (though might be tricky to implement
>>>>>> correctly), and more efficient that the existing approach that requires
>>>>>> to check their value everytime.
>>>>>>
>>>>>>>>
>>>>>>>> For MMIO override, the current approach you have is good, and it's
>>>>>>>> definitely something we could integrate.
>>>>>>>>
>>>>>>>> What are you toughts about this? (especially the device based approach
>>>>>>>> in case that you maybe tried first).
>>>>>>>
>>>>>>> I agree such an approach can work well for IRQ's and Timers, and would be
>>>>>>> more clean way to implement this.
>>>>>>>
>>>>>>> However, for SMMU and similar cases, triggering internal state errors is not
>>>>>>> easy and requires accessing internal logic. So for those specific cases,
>>>>>>> a different approach may be needed.
>>>>>>>
>>>>>>
>>>>>> Thus the iommu-testdev I mentioned, that could be extended to support this.
>>>>>>
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Pierrick
>>>>>>>
>>>>>>> BR,
>>>>>>> Ruslan
>>>>>>
>>>>>> Regards,
>>>>>> Pierrick
>>>>
>>
>> Regards,
>> Pierrick
> 


