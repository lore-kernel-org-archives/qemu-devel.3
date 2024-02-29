Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6AFC5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 02:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfWDq-0001K7-Nn; Wed, 28 Feb 2024 21:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1rfWDp-0001Jp-2G
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:32:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1rfWDm-0006q2-RR
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709173949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPsYBEJddN/xQ57WL3+GwTydxyzz4QoXjKgo1oJ6u6w=;
 b=GS97b6deVzr4R+i9vntrHSuFQGXI64I7b0GyM0/z1EVjJT7YLg/Vbc3s3+aD/ejZe2KfYn
 d5Euduk3RvsjwSmtksskRCCTqG4qrn4iqRF6N4ItpJMjOq4PUaAF45o6A5Xp0KcNz7x5hD
 n4c7hZyEdMQlrkmeiUZcPpBdZGQ26UE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-yNTcpKEJM9mpt84qhrrntg-1; Wed, 28 Feb 2024 21:32:27 -0500
X-MC-Unique: yNTcpKEJM9mpt84qhrrntg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1dc2d4c7310so441215ad.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 18:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709173947; x=1709778747;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PPsYBEJddN/xQ57WL3+GwTydxyzz4QoXjKgo1oJ6u6w=;
 b=DrZJ77GnLItyb5KkLcQ6GZo2MZBpF/PoIbRy73iUjTvqCoh2aDNTpxP1DPGvGFp1ku
 MqLY1Azr6vfYZOrmhkUzW9jbe0b9zLsUIvl1ZvudU3Y8b73/CZlZDu33HVvXiQUlLXJj
 WnCAJ7PYY2QWEQ0HLor0av2tumk3EnG/6h5Kz8hOjUVFlPj309c4eULMqJpzVxgjXhUh
 TxcySPXYTDEgIVSTudlSDZIdbTl64LtSWHkJF9u74LhpwNsH5W1I3Zpvk6oOXa1HcTrQ
 JmVaat947IEpQ61Gag1VovzNiX+NL9NvIB48vvRjGuiecMrUpr6TNRGtTj2DjNI4ERsQ
 jGrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvcacb8vTxGVUeNwX9YGDpMPknWOJBL6akXkO2qM/h/thMWM/BcwSwydJwI3v869UZK0OWGxCLTtrADPizw6NI9DWTJCY=
X-Gm-Message-State: AOJu0YxGHgCDSu8zg3LYVwrRXCSBEdFQ3FI+kguWSa76Y8X5X9xyj5rS
 KxKxEoRCxR5HeQZwjHj7Xs+nX1gPOIHkGKgvjkjznDOmtdF6QG7WL2CGZaYKlVNAMgA1OvPvCEB
 ModTfeFQjbWUeP+8HpcBuDdhZDYdl4eoSBgJA4+mLFYA2XbjLd1h/
X-Received: by 2002:a05:6a20:6a11:b0:1a0:f897:492e with SMTP id
 p17-20020a056a206a1100b001a0f897492emr1253888pzk.3.1709173946563; 
 Wed, 28 Feb 2024 18:32:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3gZGctzFdHsOkiyxlZx2notX2p2+NaZGh7I1jhWnkTKKw0O7Gy7Opyuz/raMPL2YQZay1Nw==
X-Received: by 2002:a05:6a20:6a11:b0:1a0:f897:492e with SMTP id
 p17-20020a056a206a1100b001a0f897492emr1253864pzk.3.1709173946061; 
 Wed, 28 Feb 2024 18:32:26 -0800 (PST)
Received: from [10.72.116.135] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 kw13-20020a170902f90d00b001dc90ac1cecsm151422plb.284.2024.02.28.18.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 18:32:25 -0800 (PST)
Message-ID: <c50ece12-0c20-4f37-a193-3d819937272b@redhat.com>
Date: Thu, 29 Feb 2024 10:32:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240221063431.76992-1-shahuang@redhat.com>
 <CAFEAcA-dAghULy_LibG8XLq4yUT3wZLUKvjrRzWZ+4ZSKfYEmQ@mail.gmail.com>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <CAFEAcA-dAghULy_LibG8XLq4yUT3wZLUKvjrRzWZ+4ZSKfYEmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Peter,

On 2/22/24 22:28, Peter Maydell wrote:
> On Wed, 21 Feb 2024 at 06:34, Shaoqin Huang <shahuang@redhat.com> wrote:
>>
>> The KVM_ARM_VCPU_PMU_V3_FILTER provides the ability to let the VMM decide
>> which PMU events are provided to the guest. Add a new option
>> `kvm-pmu-filter` as -cpu sub-option to set the PMU Event Filtering.
>> Without the filter, all PMU events are exposed from host to guest by
>> default. The usage of the new sub-option can be found from the updated
>> document (docs/system/arm/cpu-features.rst).
>>
>> Here is an example which shows how to use the PMU Event Filtering, when
>> we launch a guest by use kvm, add such command line:
>>
>>    # qemu-system-aarch64 \
>>          -accel kvm \
>>          -cpu host,kvm-pmu-filter="D:0x11-0x11"
>>
>> Since the first action is deny, we have a global allow policy. This
>> filters out the cycle counter (event 0x11 being CPU_CYCLES).
>>
>> And then in guest, use the perf to count the cycle:
>>
>>    # perf stat sleep 1
>>
>>     Performance counter stats for 'sleep 1':
>>
>>                1.22 msec task-clock                       #    0.001 CPUs utilized
>>                   1      context-switches                 #  820.695 /sec
>>                   0      cpu-migrations                   #    0.000 /sec
>>                  55      page-faults                      #   45.138 K/sec
>>     <not supported>      cycles
>>             1128954      instructions
>>              227031      branches                         #  186.323 M/sec
>>                8686      branch-misses                    #    3.83% of all branches
>>
>>         1.002492480 seconds time elapsed
>>
>>         0.001752000 seconds user
>>         0.000000000 seconds sys
>>
>> As we can see, the cycle counter has been disabled in the guest, but
>> other pmu events do still work.
>>
>> Reviewed-by: Sebastian Ott <sebott@redhat.com>
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>> ---
>> v6->v7:
>>    - Check return value of sscanf.
>>    - Improve the check condition.
>>
>> v5->v6:
>>    - Commit message improvement.
>>    - Remove some unused code.
>>    - Collect Reviewed-by, thanks Sebastian.
>>    - Use g_auto(Gstrv) to replace the gchar **.          [Eric]
>>
>> v4->v5:
>>    - Change the kvm-pmu-filter as a -cpu sub-option.     [Eric]
>>    - Comment tweak.                                      [Gavin]
>>    - Rebase to the latest branch.
>>
>> v3->v4:
>>    - Fix the wrong check for pmu_filter_init.            [Sebastian]
>>    - Fix multiple alignment issue.                       [Gavin]
>>    - Report error by warn_report() instead of error_report(), and don't use
>>    abort() since the PMU Event Filter is an add-on and best-effort feature.
>>                                                          [Gavin]
>>    - Add several missing {  } for single line of code.   [Gavin]
>>    - Use the g_strsplit() to replace strtok().           [Gavin]
>>
>> v2->v3:
>>    - Improve commits message, use kernel doc wording, add more explaination on
>>      filter example, fix some typo error.                [Eric]
>>    - Add g_free() in kvm_arch_set_pmu_filter() to prevent memory leak. [Eric]
>>    - Add more precise error message report.              [Eric]
>>    - In options doc, add pmu-filter rely on KVM_ARM_VCPU_PMU_V3_FILTER support in
>>      KVM.                                                [Eric]
>>
>> v1->v2:
>>    - Add more description for allow and deny meaning in
>>      commit message.                                     [Sebastian]
>>    - Small improvement.                                  [Sebastian]
>>
>>   docs/system/arm/cpu-features.rst | 23 +++++++++
>>   target/arm/cpu.h                 |  3 ++
>>   target/arm/kvm.c                 | 80 ++++++++++++++++++++++++++++++++
>>   3 files changed, 106 insertions(+)
> 
> The new syntax for the filter property seems quite complicated.
> I think it would be worth testing it with a new test in
> tests/qtest/arm-cpu-features.c.

I was trying to add a test in tests/qtest/arm-cpu-features.c. But I 
found all other cpu-feature is bool property.

When I use the 'query-cpu-model-expansion' to query the cpu-features, 
the kvm-pmu-filter will not shown in the returned results, just like below.

{'execute': 'query-cpu-model-expansion', 'arguments': {'type': 'full', 
'model': { 'name': 'host'}}}{"return": {}}

{"return": {"model": {"name": "host", "props": {"sve768": false, 
"sve128": false, "sve1024": false, "sve1280": false, "sve896": false, 
"sve256": false, "sve1536": false, "sve1792": false, "sve384": false, 
"sve": false, "sve2048": false, "pauth": false, "kvm-no-adjvtime": 
false, "sve512": false, "aarch64": true, "pmu": true, "sve1920": false, 
"sve1152": false, "kvm-steal-time": true, "sve640": false, "sve1408": 
false, "sve1664": false}}}}

I'm not sure if it's because the `query-cpu-model-expansion` only return 
the feature which is bool. Since the kvm-pmu-filter is a str, it won't 
be recognized as a feature.

So I want to ask how can I add the kvm-pmu-filter which is str property 
into the cpu-feature.c test.

> 
> 
>> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
>> index a5fb929243..7c8f6a60ef 100644
>> --- a/docs/system/arm/cpu-features.rst
>> +++ b/docs/system/arm/cpu-features.rst
>> @@ -204,6 +204,29 @@ the list of KVM VCPU features and their descriptions.
>>     the guest scheduler behavior and/or be exposed to the guest
>>     userspace.
>>
>> +``kvm-pmu-filter``
>> +  By default kvm-pmu-filter is disabled. This means that by default all pmu
> 
> "PMU"
> 

Got it.

>> +  events will be exposed to guest.
>> +
>> +  KVM implements PMU Event Filtering to prevent a guest from being able to
>> +  sample certain events. It depends on the KVM_ARM_VCPU_PMU_V3_FILTER
>> +  attribute supported in KVM. It has the following format:
>> +
>> +  kvm-pmu-filter="{A,D}:start-end[;{A,D}:start-end...]"
>> +
>> +  The A means "allow" and D means "deny", start is the first event of the
>> +  range and the end is the last one. The first registered range defines
>> +  the global policy(global ALLOW if the first @action is DENY, global DENY
> 
> Missing space before '('.
> 
> Why the '@' before 'action'?
> 

I copied the description from kvm document. And it has the @ before 
action, I think I can delete @ at there.

>> +  if the first @action is ALLOW). The start and end only support hexadecimal
>> +  format. For example:
>> +
>> +  kvm-pmu-filter="A:0x11-0x11;A:0x23-0x3a;D:0x30-0x30"
>> +
>> +  Since the first action is allow, we have a global deny policy. It
>> +  will allow event 0x11 (The cycle counter), events 0x23 to 0x3a are
> 
> lowercase "the".
> 

Gotta.

>> +  also allowed except the event 0x30 which is denied, and all the other
>> +  events are denied.
>> +
> 
> Did you check that the documentation builds and that this new
> documentation renders into HTML the way you want it?
> 

I can double check it.

>>   TCG VCPU Features
>>   =================
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 63f31e0d98..f7f2431755 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -948,6 +948,9 @@ struct ArchCPU {
>>
>>       /* KVM steal time */
>>       OnOffAuto kvm_steal_time;
>> +
>> +    /* KVM PMU Filter */
>> +    char *kvm_pmu_filter;
>>   #endif /* CONFIG_KVM */
>>
>>       /* Uniprocessor system with MP extensions */
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 81813030a5..5c62580d34 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -496,6 +496,22 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
>>       ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>>   }
>>
>> +static char *kvm_pmu_filter_get(Object *obj, Error **errp)
>> +{
>> +    ARMCPU *cpu = ARM_CPU(obj);
>> +
>> +    return g_strdup(cpu->kvm_pmu_filter);
>> +}
>> +
>> +static void kvm_pmu_filter_set(Object *obj, const char *pmu_filter,
>> +                               Error **errp)
>> +{
>> +    ARMCPU *cpu = ARM_CPU(obj);
>> +
>> +    g_free(cpu->kvm_pmu_filter);
>> +    cpu->kvm_pmu_filter = g_strdup(pmu_filter);
>> +}
>> +
>>   /* KVM VCPU properties should be prefixed with "kvm-". */
>>   void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
>>   {
>> @@ -517,6 +533,12 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
>>                                kvm_steal_time_set);
>>       object_property_set_description(obj, "kvm-steal-time",
>>                                       "Set off to disable KVM steal time.");
>> +
>> +    object_property_add_str(obj, "kvm-pmu-filter", kvm_pmu_filter_get,
>> +                            kvm_pmu_filter_set);
>> +    object_property_set_description(obj, "kvm-pmu-filter",
>> +                                    "PMU Event Filtering description for "
>> +                                    "guest PMU. (default: NULL, disabled)");
>>   }
>>
>>   bool kvm_arm_pmu_supported(void)
>> @@ -1706,6 +1728,62 @@ static bool kvm_arm_set_device_attr(ARMCPU *cpu, struct kvm_device_attr *attr,
>>       return true;
>>   }
>>
>> +static void kvm_arm_pmu_filter_init(ARMCPU *cpu)
>> +{
>> +    static bool pmu_filter_init;
>> +    struct kvm_pmu_event_filter filter;
>> +    struct kvm_device_attr attr = {
>> +        .group      = KVM_ARM_VCPU_PMU_V3_CTRL,
>> +        .attr       = KVM_ARM_VCPU_PMU_V3_FILTER,
>> +        .addr       = (uint64_t)&filter,
>> +    };
>> +    int i;
>> +    g_auto(GStrv) event_filters;
>> +
>> +    if (!cpu->kvm_pmu_filter) {
>> +        return;
>> +    }
>> +    if (kvm_vcpu_ioctl(CPU(cpu), KVM_HAS_DEVICE_ATTR, &attr)) {
>> +        warn_report("The KVM doesn't support the PMU Event Filter!");
> 
> Drop "The ".
> 
> Should this really only be a warning, rather than an error?
> 

I think this is an add-on feature, and shouldn't block the qemu init 
process. If we want to set the wrong pmu filter and it doesn't take 
affect to the VM, it can be detected in the VM.

>> +        return;
>> +    }
>> +
>> +    /*
>> +     * The filter only needs to be initialized through one vcpu ioctl and it
>> +     * will affect all other vcpu in the vm.
> 
> Weird. Why isn't it a VM ioctl if it affects the whole VM ?
> 
 From (kernel) commit d7eec2360e3 ("KVM: arm64: Add PMU event filtering
infrastructure"):
   Note that although the ioctl is per-vcpu, the map of allowed events is
   global to the VM (it can be setup from any vcpu until the vcpu PMU is
   initialized).

>> +     */
>> +    if (pmu_filter_init) {
>> +        return;
>> +    } else {
>> +        pmu_filter_init = true;
>> +    }
> 
> Shouldn't we do this before we do the kvm_vcpu_ioctl check
> for whether the kernel supports the filter? Otherwise presumably
> we'll print the warning once per vCPU, rather than only once.
> 

Yes. I will move this to the beginning of the function.

>> +
>> +    event_filters = g_strsplit(cpu->kvm_pmu_filter, ";", -1);
>> +    for (i = 0; event_filters[i]; i++) {
>> +        unsigned short start = 0, end = 0;
>> +        char act;
>> +
>> +        if (sscanf(event_filters[i], "%c:%hx-%hx", &act, &start, &end) != 3) {
>> +            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
>> +            continue;
>> +        }
>> +
>> +        if ((act != 'A' && act != 'D') || start > end) {
>> +            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
>> +            continue;
>> +        }
> 
> It would be better to do the syntax checking up-front when
> the user tries to set the property. Then you can make the
> property-setting return an error for invalid strings.
> 

Ok. I guess you mean to say move the syntax checking to the 
kvm_pmu_filter_set() function. But wouldn't it cause some code 
duplication? Since it should first check syntax of the string in 
kvm_pmu_filter_set() and then parse the string in this function.

>> +
>> +        filter.base_event = start;
>> +        filter.nevents = end - start + 1;
>> +        filter.action = (act == 'A') ? KVM_PMU_EVENT_ALLOW :
>> +                                       KVM_PMU_EVENT_DENY;
>> +
>> +        if (!kvm_arm_set_device_attr(cpu, &attr, "PMU_V3_FILTER")) {
> 
> Shouldn't we arrange for an error message if this fails?
> 

If it fails, the kvm_arm_set_device_attr() function would help us to 
report the error. So I think there is no need to report the error again.

Thanks,
Shaoqin

>> +            break;
>> +        }
>> +    }
>> +}
>> +
>>   void kvm_arm_pmu_init(ARMCPU *cpu)
>>   {
>>       struct kvm_device_attr attr = {
>> @@ -1716,6 +1794,8 @@ void kvm_arm_pmu_init(ARMCPU *cpu)
>>       if (!cpu->has_pmu) {
>>           return;
>>       }
>> +
>> +    kvm_arm_pmu_filter_init(cpu);
>>       if (!kvm_arm_set_device_attr(cpu, &attr, "PMU")) {
>>           error_report("failed to init PMU");
>>           abort();
>>
>> base-commit: 760b4dcdddba4a40b9fa0eb78fdfc7eda7cb83d0
>> --
>> 2.40.1
> 
> thanks
> -- PMM
> 

-- 
Shaoqin


