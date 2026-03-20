Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD1F1099B2D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 18:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3eHS-0004yw-Kl; Fri, 20 Mar 2026 14:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3eHL-0004yT-IE
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:09:00 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3eHJ-0002kj-5W
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:08:59 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35b905e9dc0so1530298a91.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774030136; x=1774634936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ITOs0GImWwj90gQZCWIzxhGFvp9zxgTlj/6JIFcC/zk=;
 b=Y0eGQSrdT5SOKR1HHy0GPND/EpmVdQ6QuSux/Baf4rEm0MDTUN0DYcU9/kkqkiMtnR
 VPOZQBknOT/6B74c6RwyLKF3MRUM7BMn9bExiOIAqLfwwfJ2MQqWctCCdkgkadllRCm6
 NRuwbTzA4fR5n4fjlaqqLMpD4m8GnQYYDCxG/4us7cY4z81gH7nyXWWHvFXHrc71IGOp
 VwW7xnfHgy8Huh/8GVfBkvrh3SKWYGxE6dHvXBHiuWQjaBQv3Ls0qljK9vtcYPzSmSOK
 GJIc+UftilMr14PpC/sQp+EwctFgmPm1Tjo9YnEH4ab1C1O4y3pnCxFFY+BsMquFT2o3
 tTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774030136; x=1774634936;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ITOs0GImWwj90gQZCWIzxhGFvp9zxgTlj/6JIFcC/zk=;
 b=Etut++fZqdTVHOi9+e6wVubjUVUbjZsSytTbr/4K339oFYWtUwtSXiMRX/qgMRKhLy
 nwsA0FafrKRLSFFwLmqPSAYHxYIIhNyVRlZdpBMsvncMCfxP5Hg/ZHwSLxjsU3lp0b3P
 m1mGfgHt5DstXbxueukD+vjnjyzkYuQQBRj5jxc4WZR8rHqOpCmYmjOwvg/XLASt99Lt
 mG2GEaZ1EeaGHd4sSDNyv1nbTI23YBjl02G6ctzadnxsmYQOKytLn7L8DFQIpxDU0U0M
 zi62ivaSHSDUm3LuVR2zHdAxbVEi6W3mv3QwBldOusNLUQU0/EpS5lx1xpjNwmt/GTd7
 ZAFA==
X-Gm-Message-State: AOJu0YyMb5ywhFarVFYupHr1KFmrZrPN9omGrlGNkDaFe1stAwF43Qtl
 pN5OWr8T658SuSRIkEvjBa5TyUAljiZmWnmkBPTcWGdJs0B4Bj079jH6rhCPTjhsuAg=
X-Gm-Gg: ATEYQzw0fag3n4IYGz8FXw+xS22rLjibAnbe3Ob2jrNhvjSOiDEUCpvsR4GgnEaL7iV
 aXK9tiQX9Pac/54D2QJxewdgDEjNh8hHDUiEwaKudLj/dWMK58JtINhtAy2PArhtz4w/Gv9dW1t
 K8AxrlQJa6Dr7h5ICm/bjBQpfxt1itMeoaZyJohdNhKS047Lp2KGPCbQ5dP2A9TfRnlu91Sj4Er
 tzRsyqefywA6dmjPrcqjo8nhJd4qf8JgBrF7NghxgJBmrCns6yeD/0zgSew56ds0SzEJmlBHJtk
 qPRTVQ88LQDNl3fu7+jceEVEXW50gcTJy1EEQSpqFivICFjeQhXwnGfDeppj7CIkEU4cU1xyArf
 ZjMySV2kza2HnoMz3XEloKktGuR8DIrxBy/R5oTmSq981gIrMGzeOuKKg2OBIZ1VEJhHTXZ8Q26
 NCX83rPAlWfiVCE74wAgIUBF8j/9sOyQUHSa0IJaXMe/8VMWTDYYLoMXhWCT3KW/hyGVOQ
X-Received: by 2002:a17:90b:1d4c:b0:359:915b:81f8 with SMTP id
 98e67ed59e1d1-35bd2cec4a5mr2952132a91.18.1774030135310; 
 Fri, 20 Mar 2026 11:08:55 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bc610c535sm6059987a91.16.2026.03.20.11.08.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 11:08:54 -0700 (PDT)
Message-ID: <79fca2cf-7618-4a35-a915-e2bf1811a851@linaro.org>
Date: Fri, 20 Mar 2026 11:08:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] plugins: Introduce Fault Injection framework and
 API extensions
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, alex.bennee@linaro.org,
 peter.maydell@linaro.org, philmd@linaro.org, Ruslan_Ruslichenko@epam.com
References: <20260318104640.239752-1-ruslichenko.r@gmail.com>
 <4e8f4e6e-e9d2-4457-af3d-755ced6d2a45@linaro.org>
 <CAN-aV1FER7w1rqw0zM=L2z7MT_RKsBhFg7m6NijxyQa6t5JNqw@mail.gmail.com>
 <4d2d16df-0047-4b96-8312-46489ba0f1bf@linaro.org>
 <CAN-aV1F6O3dv5F1946wEugdLxkYDp0BW6QZPxwye02A5-HYz9g@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAN-aV1F6O3dv5F1946wEugdLxkYDp0BW6QZPxwye02A5-HYz9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 3/19/26 3:29 PM, Ruslan Ruslichenko wrote:
> On Thu, Mar 19, 2026 at 8:04 PM Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 3/19/26 11:20 AM, Ruslan Ruslichenko wrote:
>>> Hi Pierrick,
>>>
>>> Thank you for the feedback and review!
>>>
>>> Our current plan is to put this plugin through our internal workflows to gather
>>> more data on its limitations and performance.
>>> Based on results, we may consider extending or refining the implementation
>>> in the future.
>>>
>>> Any further feedback on potential issues is highly appreciated.
>>>
>>
>> By design, the approach of modifying QEMU internals to allow to inject
>> IRQ, set a timer, or trigger SMMU has very few chances to be integrated
>> as it is. At least, it should be discussed with the concerned
>> maintainers, and see if they would be open to it or not.
>>
>> It's not wrong in itself, if you want a downstream solution, but it does
>> not scale upstream if we have to consider and accept everyone's needs.
>> The plugin API in itself can accept the burden for such things, but it's
>> harder to justify for internal stuff.
>>
>> I believe it would be better to rely on ad hoc devices generating this,
>> with the advantage that even if they don't get accepted upstream, it
>> will be more easy for you to maintain them downstream compared to more
>> intrusive patches.
>>
>>> On Wed, Mar 18, 2026 at 6:16 PM Pierrick Bouvier
>>> <pierrick.bouvier@linaro.org> wrote:
>>>>
>>>> Hi Ruslan,
>>>>
>>>> On 3/18/26 3:46 AM, Ruslan Ruslichenko wrote:
>>>>> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>>>>>
>>>>> This patch series is submitted as an RFC to gather early feedback on a Fault Injection (FI) framework built on top of the QEMU TCG plugin subsystem.
>>>>>
>>>>> Motivation
>>>>>
>>>>> Testing guest operating systems, hypervisors (like Xen), and low-level drivers against unexpected hardware failures can be difficult.
>>>>> This series provides an interface to inject faults dynamically without altering QEMU's core emulation source code for every test case.
>>>>>
>>>>> Architecture & Key Features
>>>>>
>>>>> The series introduces the core API extensions and implements a fault injection plugin (contrib/plugins/fault_injection.c) targeting AArch64.
>>>>> The plugin can be controlled statically via XML configurations on boot, or dynamically at runtime via a UNIX socket (enabling integration with automated testing frameworks via Python or GDB).
>>>>>
>>>>> New Plugin API Capabilities:
>>>>>
>>>>> MMIO Interception: Allows plugins to hook into memory_region_dispatch_read/write to modify hardware register reads or drop writes.
>>>>> Asynchronous Timers: Exposes QEMU_CLOCK_VIRTUAL to plugins, allowing callbacks to be scheduled based on guest virtual time.
>>>>> TB Cache Flushing: Exposes qemu_plugin_flush_tb_cache() so plugins can force re-translation when applying dynamic PC-based hooks.
>>>>> Interrupt & Exception Injection: Exposes APIs to raise/pulse hardware IRQs on the primary INTC and inject CPU exceptions (e.g., SErrors).
>>>>> Custom Device Faults: Introduces a registry where device models (e.g., SMMUv3) can expose specific fault handlers (like CMDQ errors) to be triggered externally by plugins.
>>>>>
>>>>> Patch Summary
>>>>> Patch 1 (target/arm): Adds support for asynchronous CPU exception injection.
>>>>> Patch 2-3 (plugins/api): Exposes virtual clock timers and TB cache flushing to the public plugin API.
>>>>> Patch 4 (plugins): Introduces the core fault injection subsystem, IRQ/Exception routing, and the Custom Fault registry.
>>>>> Patch 5 (system/memory): Adds the MMIO override hooks into the memory dispatch path.
>>>>> Patch 6 (hw/intc): Registers the ARM GIC (v2/v3) with the plugin subsystem to enable direct hardware IRQ injection.
>>>>> Patch 7 (hw/arm): Registers the SMMUv3 with the custom fault registry to demonstrate how device models can expose specific errors (like CMDQ faults) to plugins.
>>>>> Patch 8 (contrib/plugins): Implements the actual fault_injection plugin using the new APIs.
>>>>> Patch 9 (docs): Adds documentation and usage examples for the plugin.
>>>>>
>>>>> Request for Comments & Feedback
>>>>>
>>>>> Any suggestions on improvements, potential edge cases, or issues with the current design are highly welcome.
>>>>>
>>>>> Ruslan Ruslichenko (9):
>>>>>      target/arm: Add API for dynamic exception injection
>>>>>      plugins/api: Expose virtual clock timers to plugins
>>>>>      plugins: Expose Transaction Block cache flush API to plugins
>>>>>      plugins: Introduce fault injection API and core subsystem
>>>>>      system/memory: Add plugin callbacks to intercept MMIO accesses
>>>>>      hw/intc/arm_gic: Register primary GIC for plugin IRQ injection
>>>>>      hw/arm/smmuv3: Add plugin fault handler for CMDQ errors
>>>>>      contrib/plugins: Add fault injection plugin
>>>>>      docs: Add description of fault-injection plugin and subsystem
>>>>>
>>>>>     contrib/plugins/fault_injection.c | 772 ++++++++++++++++++++++++++++++
>>>>>     contrib/plugins/meson.build       |   1 +
>>>>>     docs/fault-injection.txt          | 111 +++++
>>>>>     hw/arm/smmuv3.c                   |  54 +++
>>>>>     hw/intc/arm_gic.c                 |  28 ++
>>>>>     hw/intc/arm_gicv3.c               |  28 ++
>>>>>     include/plugins/qemu-plugin.h     |  28 ++
>>>>>     include/qemu/plugin.h             |  39 ++
>>>>>     plugins/api.c                     |  62 +++
>>>>>     plugins/core.c                    |  11 +
>>>>>     plugins/fault.c                   | 116 +++++
>>>>>     plugins/meson.build               |   1 +
>>>>>     plugins/plugin.h                  |   2 +
>>>>>     system/memory.c                   |   8 +
>>>>>     target/arm/cpu.h                  |   4 +
>>>>>     target/arm/helper.c               |  55 +++
>>>>>     16 files changed, 1320 insertions(+)
>>>>>     create mode 100644 contrib/plugins/fault_injection.c
>>>>>     create mode 100644 docs/fault-injection.txt
>>>>>     create mode 100644 plugins/fault.c
>>>>>
>>>>
>>>> first, thanks for posting your series!
>>>>
>>>> About the general approach.
>>>> As you noticed, this is exposing a lot of QEMU internals, and it's
>>>> something we tend to avoid to do. As well, it's very architecture
>>>> specific, which is another pattern we try to avoid.
>>>>
>>>> For some of your needs (especially IRQ injection and timer injection),
>>>> did you consider writing a custom ad-hoc device and timer generating those?
>>>> There is nothing preventing you from writing a plugin that can
>>>> communicate with this specific device (through a socket for instance),
>>>> to request specific injections. I feel that it would scale better than
>>>> exposing all this to QEMU plugins API.
>>>>
>>>> For SMMU, this is trickier. Tao recently (6ce361b02c82) an iommu test
>>>> device, associated to qtest to unit test the smmu implementation. We
>>>> could maybe see to leverage that on a full machine, associated with the
>>>> communication method mentioned above, to generate specific operations at
>>>> runtime, all triggered via a plugin.
>>>>
>>>> Exposing qemu_plugin_flush_tb_cache is a hint we are missing something
>>>> on QEMU side. Better to fix it than expose this very internal function.
>>>
>>> The reason this was needed is that the plugin may receive PC trigger
>>> configuration
>>> dynamically and need to register instruction callback at runtime.
>>> If the TB for that PC is already translated and cached, our newly registered
>>> callback might not be executed.
>>>
>>> If there is a more proper way to force QEMU to re-translate a specific
>>> TB or attach
>>> a callback to cached TB it would be great to reduce the complexity here.
>>>
>>
>> I understand better. QEMU plugin current implementation is too limited
>> for this, and everything has to be done/known at translation time.
>> What is your use case for receiving PC trigger after translation? Do you
>> have some mechanism to communicate with the plugin for this?
> 
> Yes, exactly. If the guest has already executed the target code, the newly
> added trigger will be ignored, as the TB is cached.
> 
> For runtime configuration, the plugin spawns a background thread that listens
> on a socket. External Python test script connects to this socket to send
> dynamically generated XML faults.
>

Ok.

Internally, we have tb_invalidate_phys_range that will invalidate a 
given range of tb. This is called when writing to memory for a given 
address holding code.

Thus from your plugin, if you write to pc address with
qemu_plugin_write_memory_vaddr, it should trigger a re-translation of 
this tb. You'll need to read 1 byte, and write it back. As well, it 
should be more efficient, since you will only invalidate this tb.

Give it a try and let us know if it works for your need.

> There are several scenarios where this might be needed, mainly for faults that
> are difficult to define statically at boot time.
> Examples include injecting faults after specific chain of events, freezing or
> overriding system registers values at specific execution points (since this
> is currently implemented via PC triggers). Supporting environments with KASLR
> enabled might be one more case.
>

For system registers, you can (heavy but would work) instrument 
inconditionally all instructions that touch those registers, so there 
would be no need to flush anything. System registers are not accessed 
for every instruction, so hopefully, it should not impact too much 
execution time.

With both solutions, it should remove the need to expose tb_flush 
through plugin API.

>>
>>>> The associated TRIGGER_ON_PC is very similar to existing inline
>>>> operations. They could be enhanced to support writing to a given
>>>> register, all the bricks are there. For TRIGGER_ON_SYSREG it's a bit
>>>> more complex, but we might enhance inline operations also to support
>>>> hooks on specific register writes.
>>>
>>> TRIGGER_ON_PC may also be used for generating other faults too. For example,
>>> one use-case is to trigger CPU exceptions on specific instructions.
>>> Supporting TRIGGER_ON_SYSREG as an inline operation sounds like a
>>> really interesting
>>> direction to explore.
>>>
>>
>> In general, having inline operations support on register read/writes
>> would be a very nice thing to have (though might be tricky to implement
>> correctly), and more efficient that the existing approach that requires
>> to check their value everytime.
>>
>>>>
>>>> For MMIO override, the current approach you have is good, and it's
>>>> definitely something we could integrate.
>>>>
>>>> What are you toughts about this? (especially the device based approach
>>>> in case that you maybe tried first).
>>>
>>> I agree such an approach can work well for IRQ's and Timers, and would be
>>> more clean way to implement this.
>>>
>>> However, for SMMU and similar cases, triggering internal state errors is not
>>> easy and requires accessing internal logic. So for those specific cases,
>>> a different approach may be needed.
>>>
>>
>> Thus the iommu-testdev I mentioned, that could be extended to support this.
>>
>>>>
>>>> Regards,
>>>> Pierrick
>>>
>>> BR,
>>> Ruslan
>>
>> Regards,
>> Pierrick


