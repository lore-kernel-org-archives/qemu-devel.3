Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05F3C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 07:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTH6U-0007UQ-QB; Fri, 26 Jan 2024 02:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1rTH6O-0007TR-DQ
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 02:58:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1rTH6L-0002Tg-Vs
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 02:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706255889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D3Buiu182838u1oatISapL/bAKzONckxOrRoF1t1zgM=;
 b=DGK6z0FnseY2FC6Kvll6gLUosnNyYMP8QPidDnbUSRm602sJkxlLSgWhPGh55xGWq1ccuR
 0wY+BUtBnvnSdEySrFoJfgTp8plW+Yj5Fw+6AYQdEIsiY6cbP7UX4QsphCrkt2Kw1XQvES
 rKbjpCH4icQ8AzsUmJ07GNf3qgZuFZs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-Cca2nxAEOESfmgelXpDIqA-1; Fri, 26 Jan 2024 02:58:07 -0500
X-MC-Unique: Cca2nxAEOESfmgelXpDIqA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5d57b2d2758so86455a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 23:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706255886; x=1706860686;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D3Buiu182838u1oatISapL/bAKzONckxOrRoF1t1zgM=;
 b=butLnrDnfZ4f8SMb328s3ZZEp2fsKH+pkFrJ7oo9H0lzTntQJrCX3nQ2GaQLLqZdXs
 1rbX6v9jCEchCQtApf+I+OnMWmiHGwwcEGS9pTOiV4rsRgPOU+SY5SXtxHlXjTPpwere
 xY5i5DtvjqZTpzxGXWpcaLlrxLL9oE+PIdzqq5FY50bI3dLDaGK++OeqgEAn9VN2ML7y
 dxDwJ/Mmk9SOooYp+SVdSgKZxsciORH9yL9+iPfjs89tvRtbExmsOhYfA0MGItRV2Voz
 2vMGBsRfTe0AKsNN1UDCJRX/fs4jdI/7yEKaA0CfNcGwP7igmrZ96zaQIsWSxc/LLZQK
 Mvxg==
X-Forwarded-Encrypted: i=0;
 AJvYcCUhXwn9jBA3q8V3XnjPa3kDYp7PZgA5ODAAdD3kELrQKuH1bUVhV4qeLFU4B6SHUNpjecKDFxb3zezeQo2hARhuERcAc1Y=
X-Gm-Message-State: AOJu0YztXfWMbEKwNHkVsBb1YNITx8vs4hfVijIRmcBiuVLqIsoc15z0
 mkRp7JsgSJzePdvQ+6L5hv6rynOuzxs2F4JGLFt8uDX1OnTB543xyHbzml97GiVzM0RLuTJxbsW
 b2A/DwLopEVDN1jXSbXT4nolSl+tqMmMRsR1/6XiVjwxIWS0ZmgRR
X-Received: by 2002:a05:6a20:438b:b0:19a:40f3:e460 with SMTP id
 i11-20020a056a20438b00b0019a40f3e460mr1900208pzl.2.1706255885906; 
 Thu, 25 Jan 2024 23:58:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMjzHrrTDlQTWUlAVe3VC27ZolQDRB8EJaUUcRXrUas+YYiVfkyB7k5Pl4uVIFuaUmINrUxA==
X-Received: by 2002:a05:6a20:438b:b0:19a:40f3:e460 with SMTP id
 i11-20020a056a20438b00b0019a40f3e460mr1900188pzl.2.1706255885305; 
 Thu, 25 Jan 2024 23:58:05 -0800 (PST)
Received: from [10.72.116.129] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a17090a388500b00290f8afd8acsm696483pjb.47.2024.01.25.23.58.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 23:58:04 -0800 (PST)
Message-ID: <19930d3f-d7ef-44ed-aee1-e3537d973cf8@redhat.com>
Date: Fri, 26 Jan 2024 15:58:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
To: Eric Auger <eauger@redhat.com>, qemu-arm@nongnu.org
Cc: Gavin Shan <gshan@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20240115080144.44944-1-shahuang@redhat.com>
 <852ee2a3-b69f-4480-a6f4-f2b274f5e01c@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <852ee2a3-b69f-4480-a6f4-f2b274f5e01c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Eric,

On 1/17/24 20:59, Eric Auger wrote:
> Hi  Shaoqin,
> 
> On 1/15/24 09:01, Shaoqin Huang wrote:
>> The KVM_ARM_VCPU_PMU_V3_FILTER provides the ability to let the VMM decide
>> which PMU events are provided to the guest. Add a new option
>> `kvm-pmu-filter` as -cpu sub-option to set the PMU Event Filtering.
>> Without the filter, all PMU events are exposed from host to guest by
>> default. The usage of the new sub-option can be found from the updated
>> document (docs/system/arm/cpu-features.rst).
> 
> do not hesitate to cc qemu-arm@nongnu.org for ARM specific topics.
> 
>>
>> Here is an example shows how to use the PMU Event Filtering, when
> which shows
>> we launch a guest by use kvm, add such command line:
>>
>>    # qemu-system-aarch64 \
>>          -accel kvm \
>>          -cpu host,kvm-pmu-filter="D:0x11-0x11"
>>
>> Since the first action is deny, we have a global allow policy. This
>> disables the filtering of the cycle counter (event 0x11 being CPU_CYCLES).
> Actually it filters it ;-) It would rather say this filters out the
> cycle counter. But I am not a native speaker either ;-)
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
>> other pmu events are still work.
> do still work
>>
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>> ---
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
>>   docs/system/arm/cpu-features.rst | 23 ++++++++++
>>   include/sysemu/kvm_int.h         |  1 +
>>   target/arm/cpu.h                 |  3 ++
>>   target/arm/kvm.c                 | 78 ++++++++++++++++++++++++++++++++
>>   4 files changed, 105 insertions(+)
>>
>> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
>> index a5fb929243..44a797c50e 100644
>> --- a/docs/system/arm/cpu-features.rst
>> +++ b/docs/system/arm/cpu-features.rst
>> @@ -204,6 +204,29 @@ the list of KVM VCPU features and their descriptions.
>>     the guest scheduler behavior and/or be exposed to the guest
>>     userspace.
>>   
>> +``kvm-pmu-filter``
>> +  By default kvm-pmu-filter is disabled. This means that by default all pmu
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
>> +  if the first @action is ALLOW). The start and end only support hexadecimal
>> +  format now. For example:
>> +
>> +  kvm-pmu-filter="A:0x11-0x11;A:0x23-0x3a;D:0x30-0x30"
>> +
>> +  Since the first action is allow, we have a global deny policy. It
>> +  will allow event 0x11 (The cycle counter), events 0x23 to 0x3a is
> s/is/are
>> +  also allowed except the event 0x30 is denied, and all the other events
> 0x30 is/0x30 which is
>> +  are disallowed.
> s/disallowed/denied just to match the above terminology.
>> +
>>   TCG VCPU Features
>>   =================
>>   
>> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
>> index fd846394be..8f4601474f 100644
>> --- a/include/sysemu/kvm_int.h
>> +++ b/include/sysemu/kvm_int.h
>> @@ -120,6 +120,7 @@ struct KVMState
>>       uint32_t xen_caps;
>>       uint16_t xen_gnttab_max_frames;
>>       uint16_t xen_evtchn_max_pirq;
>> +    char *kvm_pmu_filter;
> I think this is not needed anymore
>>   };
>>   
>>   void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 8c3ca2e231..1be7dca4aa 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -971,6 +971,9 @@ struct ArchCPU {
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
>> index c5a3183843..413ee2720e 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -495,6 +495,22 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
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
>> @@ -516,6 +532,12 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
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
>> @@ -1705,6 +1727,60 @@ static bool kvm_arm_set_device_attr(ARMCPU *cpu, struct kvm_device_attr *attr,
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
>> +    gchar **event_filters;
> wonder if you couldn't use g_auto(GStrv) event_filters with auto
> cleenup? examples in qom/object.c for instance
>> +
>> +    if (!cpu->kvm_pmu_filter) {
>> +        return;
>> +    }
>> +    if (kvm_vcpu_ioctl(CPU(cpu), KVM_HAS_DEVICE_ATTR, &attr)) {
>> +        warn_report("The KVM doesn't support the PMU Event Filter!");
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * The filter only needs to be initialized through one vcpu ioctl and it
>> +     * will affect all other vcpu in the vm.
>> +     */
>> +    if (pmu_filter_init) {
> I think I commented on that on the v4. Maybe I missed your reply. You
> sure you don't need to call it for each vcpu?
> 
>> +        return;
>> +    } else {
>> +        pmu_filter_init = true;
>> +    }
>> +
>> +    event_filters = g_strsplit(cpu->kvm_pmu_filter, ";", -1);
>> +    for (i = 0; event_filters[i]; i++) {
>> +        unsigned short start = 0, end = 0;
>> +        char act;
>> +
>> +        sscanf(event_filters[i], "%c:%hx-%hx", &act, &start, &end);
>> +        if ((act != 'A' && act != 'D') || (!start && !end)) {
>> +            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
>> +            continue;
>> +        }
>> +
>> +        filter.base_event = start;
>> +        filter.nevents = end - start + 1;
>> +        filter.action = (act == 'A') ? KVM_PMU_EVENT_ALLOW :
>> +                                       KVM_PMU_EVENT_DENY;
>> +
>> +        if (!kvm_arm_set_device_attr(cpu, &attr, "PMU Event Filter")) {
> Nit: maybe s/PMU Event Filter/PMU_V3_FILTER
>> +            break;
>> +        }
>> +    }
>> +
>> +    g_strfreev(event_filters);
>> +}
>> +
>>   void kvm_arm_pmu_init(ARMCPU *cpu)
>>   {
>>       struct kvm_device_attr attr = {
>> @@ -1715,6 +1791,8 @@ void kvm_arm_pmu_init(ARMCPU *cpu)
>>       if (!cpu->has_pmu) {
>>           return;
>>       }
>> +
>> +    kvm_arm_pmu_filter_init(cpu);
>>       if (!kvm_arm_set_device_attr(cpu, &attr, "PMU")) {
>>           error_report("failed to init PMU");
>>           abort();
> Along with this new vcpu feature you may want to add a test like what
> was done in 68970d1e0d07 ("hw/arm/virt: Implement kvm-steal-time"), in
> tests/qtest/arm-cpu-features.c
> 

I have some doubts about adding the qtest into the qtest/arm-cpu-features.c.

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
be recognized as a feature. As a result, we don't have the way add new 
test like other cpu feature.

Do you have any suggestions?

Thanks,
Shaoqin


> Thanks
> 
> Eric
> 

-- 
Shaoqin


