Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2298DD3DEA4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 17:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1rEJ-0006oM-Rn; Fri, 18 Oct 2024 13:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t1rEG-0006ny-S6
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 13:57:36 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t1rEE-0006xx-Qy
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 13:57:36 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso1658010a12.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729274252; x=1729879052; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=37YAwA6jmj5B2ksCnI6JguhoKlr/zVOd2wFRbZXqFR8=;
 b=SWPgZZB4EYWOIkmPxbM9X1b376TImHtLgavb+Rb8DETRGGTQNmO//fhauVYAfLyBkb
 5u6VL/utswBzOD+OCaXxnclKfivavyXjv5RMTwN90nqjaJJESjeZ9AfxZGr//nGfLYFN
 7EntO+yBxIEIb5TLg/7VojHopOuOvUTabwLpzJEU/4/QQ1BKUITA007d5uycdB7Xkf7m
 g+mCIQD26JbfKC/or5gfig+BClqh4/uo6vNQWOfHVM3pOg3vvDMa0lZXf2+nL5XnufUO
 W3Et0hZ3vsPGm17/DUhJz8p1E48xhnAwanAT4ZNZnvNLM43rHbuL9CFzG/JqEfAR2d2+
 kBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729274252; x=1729879052;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=37YAwA6jmj5B2ksCnI6JguhoKlr/zVOd2wFRbZXqFR8=;
 b=VgW6QJlVkLJ3lqASNT89oEsYMfFpWMYcJykwjjDM4Wb9y3LDlb1gFmyjOtihxDR/F5
 TcPHE511OOZ4g6oDRhs2mRbMiVyypBI2QWFnaRFgv8dmQpP4JJR8DTSBObUP3hT+7Apu
 NQNBPphdiKD6EM9WlPeim/YSpNljYUCOdJM8nV3fNAWbZVkf4mzpVxjv+9ahZuKX90mG
 Yx/RcC8bBL3PNv1oHQ18ZBLyq8QQtuyA77j1RHA+tC23YtMqOIh+qlPK7VAR01XuZeFO
 ScyyMYncba3jnYIEeBo2uuE+/aFJSqObu6H7UnTe93og3dAeunUZyuoF0WAbOh9l78vv
 qMdA==
X-Gm-Message-State: AOJu0YyWzp6rLt4+KBVY/q6T3t1VtZtQUT21otIWY/SY0qQ9jq1VvhwD
 SL1/50lel7pxi8bMq2QNBAeiVm8x65WXbVPhO4GFfPyELqWshPplJTUiT1cgdHw=
X-Google-Smtp-Source: AGHT+IH33XdDRgvGEdS9BK/E1OP1krwEuFUk8/wehx7C7xji3uWrQJwxGpPxthGlv69cnw1F2MSPgQ==
X-Received: by 2002:a05:6a20:e605:b0:1d9:a94:8d90 with SMTP id
 adf61e73a8af0-1d92c51fb44mr3903646637.27.1729274251020; 
 Fri, 18 Oct 2024 10:57:31 -0700 (PDT)
Received: from [192.168.0.102] ([187.121.94.4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eacc29c736sm1641743a12.88.2024.10.18.10.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2024 10:57:30 -0700 (PDT)
Message-ID: <b2593ab0-f5b2-46fe-8a8c-3725598a6ae1@linaro.org>
Date: Fri, 18 Oct 2024 14:57:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 0/4] Arch agnostic ACPI changes to support vCPU Hotplug
 (on Archs like ARM)
To: Miguel Luis <miguel.luis@oracle.com>, Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 Karl Heubaum <karl.heubaum@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 "zhukeqian1@huawei.com" <zhukeqian1@huawei.com>,
 "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <B1CFD37B-3422-4766-A5EE-64D000FDEC2B@oracle.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <B1CFD37B-3422-4766-A5EE-64D000FDEC2B@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x536.google.com
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

Hi Miguel,

On 10/15/24 15:41, Miguel Luis wrote:
> Hi Salil,
> 
> I’ve ran the usual tests successfully of hotplug/unplug from the number of cold-booted cpus up to maxcpus and migration on ARM. Please feel free to add:

Do you mind sharing what cpus you used for your tests?

Did you use tcg or kvm for the tests?

Thanks!


Cheers,
Gustavo
  
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> 
> Thanks
> Miguel
> 
>> On 14 Oct 2024, at 19:22, Salil Mehta <salil.mehta@huawei.com> wrote:
>>
>> Certain CPU architecture specifications [1][2][3] prohibit changes to the CPUs
>> *presence* after the kernel has booted. This is because many system
>> initializations depend on the exact CPU count at boot time and do not expect it
>> to change afterward. For example, components like interrupt controllers that are
>> closely coupled with CPUs, or various per-CPU features, may not support
>> configuration changes once the kernel has been initialized.
>>
>> This requirement poses a challenge for virtualization features like vCPU
>> hotplug. To address this, changes to the ACPI AML are necessary to update the
>> `_STA.PRES` (presence) and `_STA.ENA` (enabled) bits accordingly during guest
>> initialization, as well as when vCPUs are hot-plugged or hot-unplugged. The
>> presence of unplugged vCPUs may need to be deliberately *simulated* at the ACPI
>> level to maintain a *persistent* view of vCPUs for the guest kernel.
>>
>> This patch set introduces the following features:
>>
>> 1. ACPI Interface with Explicit PRESENT and ENABLED CPU States: It allows the
>>    guest kernel to evaluate these states using the `_STA` ACPI method.
>>
>> 2. Initialization of ACPI CPU States: These states are initialized during
>>    `machvirt_init` and when vCPUs are hot-(un)plugged. This enables hotpluggable
>>    vCPUs to be exposed to the guest kernel via ACPI.
>>
>> 3. Support for Migrating ACPI CPU States: The patch set ensures the migration of
>>    the newly introduced `is_{present,enabled}` ACPI CPU states to the
>>    destination VM.
>>
>> The approach is flexible enough to accommodate ARM-like architectures that
>> intend to implement vCPU hotplug functionality. It is suitable for architectures
>> facing similar constraints to ARM or those that plan to implement vCPU
>> hotplugging independently of hardware support (if available).
>>
>> This patch set is derived from the ARM-specific vCPU hotplug implementation [4]
>> and includes migration components adaptable to other architectures, following
>> suggestions [5] made by Igor Mammedov <imammedo@redhat.com>.
>>
>> It can be applied independently, ensuring compatibility with existing hotplug
>> support in other architectures. I have tested this patch set in conjunction with
>> the ARM-specific vCPU hotplug changes (included in the upcoming RFC V5 [6]), and
>> everything worked as expected. I kindly request maintainers of other
>> architectures to provide a "Tested-by" after running their respective regression
>> tests.
>>
>> Many thanks!
>>
>>
>> References:
>> [1] KVMForum 2023 Presentation: Challenges Revisited in Supporting Virt CPU Hotplug on
>>     architectures that don’t Support CPU Hotplug (like ARM64)
>>     a. Kernel Link: https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
>>     b. Qemu Link:  https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
>> [2] KVMForum 2020 Presentation: Challenges in Supporting Virtual CPU Hotplug on
>>     SoC Based Systems (like ARM64)
>>     Link: https://kvmforum2020.sched.com/event/eE4m
>> [3] Check comment 5 in the bugzilla entry
>>     Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
>> [4] [PATCH RFC V4 00/33] Support of Virtual CPU Hotplug for ARMv8 Arch
>>     Link: https://lore.kernel.org/qemu-devel/20241009031815.250096-1-salil.mehta@huawei.com/T/#mf32be203baa568a871dc625b732f666a4c4f1e68
>> [5] Architecture agnostic ACPI VMSD state migration (Discussion)
>>     Link: https://lore.kernel.org/qemu-devel/20240715155436.577d34c5@imammedo.users.ipa.redhat.com/
>> [6] Upcoming RFC V5, Support of Virtual CPU Hotplug for ARMv8 Arch
>>     Link: https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v5
>>
>> Salil Mehta (4):
>>   hw/acpi: Initialize ACPI Hotplug CPU Status with Support for vCPU
>>     `Persistence`
>>   hw/acpi: Update ACPI CPU Status `is_{present, enabled}` during vCPU
>>     hot(un)plug
>>   hw/acpi: Reflect ACPI vCPU {present,enabled} states in ACPI
>>     _STA.{PRES,ENA} Bits
>>   hw/acpi: Populate vCPU Hotplug VMSD to migrate `is_{present,enabled}`
>>     states
>>
>> cpu-target.c         patches.vcpuhp.rfc-v5.arch.agnostic.acpi          |  1 +
>> hw/acpi/cpu.c                  | 70 +++++++++++++++++++++++++++++++---
>> hw/acpi/generic_event_device.c | 11 ++++++
>> include/hw/acpi/cpu.h          | 21 ++++++++++
>> include/hw/core/cpu.h          | 21 ++++++++++
>> 5 files changed, 119 insertions(+), 5 deletions(-)
>>
>> -- 
>> 2.34.1
>>
> 


