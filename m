Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D087CDE012
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 15:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stqNK-0004Aj-Qg; Thu, 26 Sep 2024 11:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1stqNJ-00048R-4x
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 11:25:49 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1stqNG-0006Ou-Pi
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 11:25:48 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-27b7a1480bdso574207fac.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727364345; x=1727969145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2af62LfA3YaO+ersa+4qbrxEQzuZbXDbfR69g7WoisY=;
 b=Vi2ArdOsRDv6Pkcz33x0KZauGhJ0wpFKm44Pu1iXZt53UlIdNuwfz32riEdr/AbkhO
 MDuprBNyMoZ4VNxXM20cpCZhMRO/JzMwRP3xRXiiKPqL6g4vCFLtrTaqkwvTX09DS2Rz
 zgNHR9DecCSJ/ta4PIK8MiFjozo/uZoyv27HmyNLgNXlDFkQIgZjeF+qJC8I4FQfxMAL
 4ghhZEU5+V0KNFQ6bkxGrwjI5kMDM2PDsu9drWwRHafDTkAdIGMEclzHuTUctcF/4rYe
 SKjIr7i0BSwwXJuMGUQuGxo2coBfJN3seLDQz5BUKLd+MTZwilTYAOYfMAsEOhfAStsY
 NlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727364345; x=1727969145;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2af62LfA3YaO+ersa+4qbrxEQzuZbXDbfR69g7WoisY=;
 b=g/5ST8Q0NcmiDH9sdwJnfBkRWcwRkkYgbKWns+5xdkZCqSJyuSbk1t87zWQ4pLfHnJ
 yL8AU+bemo6f36IU2QvGVAj4/S3QcSrp/Xv4SUK5107a8S0t0zUZLWIZxyTpOuiPcZSI
 zWBZbqRY99tf0n7bndSwXu7dRUAqwq0DObzvQ/GxqRZP6Z5+LLCpJ/g/ShJfIHro3W/e
 AAdwmZuzZK54FXoXHEscrOtJYj/NP7+PpzGv0EhSe5EhXZgjj68oYN29bFVAdwtA0vsX
 FFXowd/r/iqJ3LPjaFGNyU0LrunNMhl1vpoaw2cHgWYilaowV1+u+cSizNketb2mE3QO
 plXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4WpOMwMJli5JS/8Z05bTah8Ja6CE9wkJj4dEBDAQ1UTVeqNtA0o8iaKxy8MIjaw+U+zeWuU6yvkMj@nongnu.org
X-Gm-Message-State: AOJu0YyVAgpBLED9ia/rMTU8OOOIRo4Qt4YOWhBzYT4UlbUgfq6oNqQz
 dZ6h7YNdsmB9P1Detr48P3D0iB3JyasZPnGWzWdCh/t+fXMMb1sOFa3r7Pc6Ujg=
X-Google-Smtp-Source: AGHT+IG8U0j8XEl6RQyFHFPSvdZ/v4Zrq7IYzv6i4wbxRVfA03cXBhoXaXbujZFtUbxioglA2PTlZg==
X-Received: by 2002:a05:6870:f2a8:b0:27c:cf52:dc76 with SMTP id
 586e51a60fabf-28710c45be3mr186782fac.45.1727364344819; 
 Thu, 26 Sep 2024 08:25:44 -0700 (PDT)
Received: from [192.168.0.100] ([187.75.38.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e6db5ed0e9sm19960a12.57.2024.09.26.08.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 08:25:43 -0700 (PDT)
Message-ID: <96406bf3-731b-49aa-a2e4-a43259bfbb57@linaro.org>
Date: Thu, 26 Sep 2024 12:25:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] arm/kvm: add support for MTE
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, cohuck@redhat.com, darren@os.amperecomputing.com
References: <20240920073725.410373-1-gankulkarni@os.amperecomputing.com>
 <4b1a7f9b-4a69-4c0a-93be-4ecd27b08196@linaro.org>
 <29815c60-a246-4be3-9685-4d192efcf037@os.amperecomputing.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <29815c60-a246-4be3-9685-4d192efcf037@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oa1-x35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Ganapatrao,

On 9/25/24 19:40, Ganapatrao Kulkarni wrote:
>
> Hi Gustavo,
>
> On 25-09-2024 09:17 pm, Gustavo Romero wrote:
>> Hi Ganapatrao,
>>
>> Sorry for the delay on replying it. I was attending KVM Forum and 
>> commuting.
>>
>> On 9/20/24 09:37, Ganapatrao Kulkarni wrote:
>>> Extend the 'mte' property for the virt machine to cover KVM as
>>> well. For KVM, we don't allocate tag memory, but instead enable
>>> the capability.
>>>
>>> If MTE has been enabled, we need to disable migration, as we do not
>>> yet have a way to migrate the tags as well. Therefore, MTE will stay
>>> off with KVM unless requested explicitly.
>>>
>>> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
>>> which broke TCG since it made the TCG -cpu max
>>> report the presence of MTE to the guest even if the board hadn't
>>> enabled MTE by wiring up the tag RAM. This meant that if the guest
>>> then tried to use MTE QEMU would segfault accessing the
>>> non-existent tag RAM.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>>> ---
>>>
>>> Changes since V2:
>>>     Updated with review comments.
>>>
>>> Changes since V1:
>>>     Added code to enable MTE before reading register
>>> id_aa64pfr1 (unmasked MTE bits).
>>>
>>> This patch is boot tested on ARM64 with KVM and on X86 with TCG for 
>>> mte=on
>>> and default case(i.e, no mte).
>>>
>>>   hw/arm/virt.c        | 72 
>>> ++++++++++++++++++++++++++------------------
>>>   target/arm/cpu.c     | 11 +++++--
>>>   target/arm/cpu.h     |  2 ++
>>>   target/arm/kvm.c     | 57 +++++++++++++++++++++++++++++++++++
>>>   target/arm/kvm_arm.h | 19 ++++++++++++
>>>   5 files changed, 129 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>> index 7934b23651..a33af7d996 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -2211,7 +2211,7 @@ static void machvirt_init(MachineState *machine)
>>>           exit(1);
>>>       }
>>> -    if (vms->mte && (kvm_enabled() || hvf_enabled())) {
>>> +    if (vms->mte && hvf_enabled()) {
>>>           error_report("mach-virt: %s does not support providing "
>>>                        "MTE to the guest CPU",
>>>                        current_accel_name());
>>> @@ -2281,39 +2281,51 @@ static void machvirt_init(MachineState 
>>> *machine)
>>>           }
>>>           if (vms->mte) {
>>> -            /* Create the memory region only once, but link to all 
>>> cpus. */
>>> -            if (!tag_sysmem) {
>>> -                /*
>>> -                 * The property exists only if MemTag is supported.
>>> -                 * If it is, we must allocate the ram to back that up.
>>> -                 */
>>> -                if (!object_property_find(cpuobj, "tag-memory")) {
>>> -                    error_report("MTE requested, but not supported "
>>> -                                 "by the guest CPU");
>>> -                    exit(1);
>>> +            if (tcg_enabled()) {
>>> +                /* Create the memory region only once, but link to 
>>> all cpus. */
>>> +                if (!tag_sysmem) {
>>> +                    /*
>>> +                     * The property exists only if MemTag is 
>>> supported.
>>> +                     * If it is, we must allocate the ram to back 
>>> that up.
>>> +                     */
>>> +                    if (!object_property_find(cpuobj, "tag-memory")) {
>>> +                        error_report("MTE requested, but not 
>>> supported "
>>> +                                     "by the guest CPU");
>>> +                        exit(1);
>>> +                    }
>>> +
>>> +                    tag_sysmem = g_new(MemoryRegion, 1);
>>> +                    memory_region_init(tag_sysmem, OBJECT(machine),
>>> +                                       "tag-memory", UINT64_MAX / 32);
>>> +
>>> +                    if (vms->secure) {
>>> +                        secure_tag_sysmem = g_new(MemoryRegion, 1);
>>> +                        memory_region_init(secure_tag_sysmem, 
>>> OBJECT(machine),
>>> + "secure-tag-memory",
>>> +                                           UINT64_MAX / 32);
>>> +
>>> +                        /* As with ram, secure-tag takes precedence 
>>> over tag. */
>>> + memory_region_add_subregion_overlap(secure_tag_sysmem,
>>> + 0, tag_sysmem, -1);
>>> +                    }
>>>                   }
>>> -                tag_sysmem = g_new(MemoryRegion, 1);
>>> -                memory_region_init(tag_sysmem, OBJECT(machine),
>>> -                                   "tag-memory", UINT64_MAX / 32);
>>> -
>>> +                object_property_set_link(cpuobj, "tag-memory",
>>> +                                         OBJECT(tag_sysmem), 
>>> &error_abort);
>>>                   if (vms->secure) {
>>> -                    secure_tag_sysmem = g_new(MemoryRegion, 1);
>>> -                    memory_region_init(secure_tag_sysmem, 
>>> OBJECT(machine),
>>> -                                       "secure-tag-memory", 
>>> UINT64_MAX / 32);
>>> -
>>> -                    /* As with ram, secure-tag takes precedence 
>>> over tag.  */
>>> - memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
>>> - tag_sysmem, -1);
>>> +                    object_property_set_link(cpuobj, 
>>> "secure-tag-memory",
>>> + OBJECT(secure_tag_sysmem),
>>> + &error_abort);
>>>                   }
>>> -            }
>>> -
>>> -            object_property_set_link(cpuobj, "tag-memory", 
>>> OBJECT(tag_sysmem),
>>> -                                     &error_abort);
>>> -            if (vms->secure) {
>>> -                object_property_set_link(cpuobj, "secure-tag-memory",
>>> - OBJECT(secure_tag_sysmem),
>>> -                                         &error_abort);
>>> +            } else if (kvm_enabled()) {
>>> +                if (!kvm_arm_mte_supported()) {
>>> +                    error_report("MTE requested, but not supported 
>>> by KVM");
>>> +                    exit(1);
>>> +                }
>>> +                kvm_arm_enable_mte(cpuobj, &error_abort);
>>> +            } else {
>>> +                    error_report("MTE requested, but not supported ");
>>> +                    exit(1);
>>>               }
>>>           }
>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>> index 19191c2391..8a2fc471ce 100644
>>> --- a/target/arm/cpu.c
>>> +++ b/target/arm/cpu.c
>>> @@ -2390,14 +2390,21 @@ static void arm_cpu_realizefn(DeviceState 
>>> *dev, Error **errp)
>>>   #ifndef CONFIG_USER_ONLY
>>>           /*
>>> -         * If we do not have tag-memory provided by the machine,
>>> +         * If we do not have tag-memory provided by the TCG,
>>>            * reduce MTE support to instructions enabled at EL0.
>>>            * This matches Cortex-A710 BROADCASTMTE input being LOW.
>>>            */
>>> -        if (cpu->tag_memory == NULL) {
>>> +        if (tcg_enabled() && cpu->tag_memory == NULL) {
>>>               cpu->isar.id_aa64pfr1 =
>>>                   FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, 
>>> MTE, 1);
>>>           }
>>> +
>>> +        /*
>>> +         * Clear MTE bits, if not enabled in KVM mode.
>>> +         */
>>> +        if (kvm_enabled() && !cpu->kvm_mte) {
>>> +                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 
>>> 0);
>>> +        }
>>
>> I 've discussed a bit with Richard about the need of setting the MTE 
>> field here
>>
>> to 0. This is already a reduction since it's inside the condition block:
>>
>> if (cpu_isar_feature(aa64_mte, cpu)) { ... }, which is only taken if 
>> we already
>>
>> have MTE field >= 1. At this point the MTE bits 
>> in cpu->isar.id_aa64pfr1 should
>>
>> already be set correctly accordingly to the host bits since 
>> kvm_arm_get_host_cpu_features()
>>
>> was called.
>>
>>
>> The check for TCG (cpu->tag_memory == NULL) exists because even if 
>> MTE instructions
>>
>> are supported by the CPU it's possible that the machine's memory does 
>> not support tags,
>>
>> but we don't check for that in KVM afaics.
>>
>>
>> For KVM, isn't the cpu->isar.id_aa64pfr1 MTE bits already correct 
>> here so we don't need to touch them?
>
> id_aa64pfr1.MTE bits are masked/zero when we read without enabling the 
> MTE(KVM_CAP_ARM_MTE). Hence to read the real value we are enabling MTE 
> while reading the register.
>
> Later, If user is not passed argument "mte=on", we want to revert the 
> value that is read with MTE enabled since we are enabling MTE on 
> actual VM  only if "mte=on".
>
> Are you saying, let us have the MTE enabled for KVM by default and 
> disable only if user passes mte=off?.

No, it's ok the way it is. I missed one obvious case: host supports MTE 
but user _didn't_ ask to enable it.


Thanks for the clarifications. It makes sense to me.


I think it would be good to explain this in the comment, i.e. explain 
the rationale for the reduction

(I'm calling  reduction the fact that we check for aa64pfr1.MTE bits and 
then we mask them (set to zero, in this case).

I'll comment it inline in the other thread were Cornelia suggests a 
change on it too.


Cheers,

Gustavo


>>
>> cpu->kvm_mte is false here only if kvm_check_extension(kvm_state, 
>> KVM_CAP_ARM_MTE) is true but
>>
>> kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_MTE, 0) is false -- can that 
>> happen ever happen? _or_ when
>
> This can be, if hardware is not supporting it.
> Since user is trying to enable with mte=on but hardware is not 
> capable, in that case qemu aborts with error message.
>
>>
>> we can't block migration? So basically we are telling to the guest 
>> that MTE is not supported if we have
>>
>> MTE supported in the host _but_ we can't block migration?
>>
>>
>>
>> Cheers,
>>
>> Gustavo
>>
>

