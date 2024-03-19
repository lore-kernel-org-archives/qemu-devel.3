Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD3ECD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmau9-0008Gk-9j; Tue, 19 Mar 2024 10:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rmau7-0008Fu-TZ
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:57:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rmau4-0004kc-U2
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710860243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2KPdB2x/yvB4L4if+TmUzvgep4nVDADhAWMsGZPypc=;
 b=C4F3rB7CHRSAbEQFOYGoJWMZLwRQzHCq9fIDVEG89igsH2jlPWRaZHuvZ47zkMBqO5DDb9
 yh/KqofXTPYrIo+AAtOQFaRftp0rW/YbikW63ziRgUMh+Y7I3CzZK2aubA2PMNtHw3o/8y
 O0xqwD/TGvTkFQlB2HiMbYlibDrJR/w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-uU4wtOgUMIqu0hNU9BHzBA-1; Tue, 19 Mar 2024 10:57:22 -0400
X-MC-Unique: uU4wtOgUMIqu0hNU9BHzBA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41408ff5eabso17460085e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710860241; x=1711465041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H2KPdB2x/yvB4L4if+TmUzvgep4nVDADhAWMsGZPypc=;
 b=e9BdEBBodmA+7qNPqrt+sw9XsTp2bElCVIsD8spmGIhDkEcyGNJTYvLAvZ//zSKMVm
 I8R+0TKL7oLgykfKiwBlMS8iaim9fsWfyl/HkCFArcJt37cN/QZdX+cKF0XBYMPzISFf
 I+0XRO6PS8u8CxaD3Q/PlVZwAXoTtQV59YoOMhPzsIImMUSrG10smIo1EHIJSMIxHdK+
 H+KWu5s68Z4WeSwk4o+juU4mHU7kLQOu9YGBfgdvIo0yB0yiMUhvTEpooErfHtw0cg/W
 JubEptFzc+Ju3OTHsebZDw7lg8KdpgoZWOAq6Uq7pkk3+FR2NkO6iFD1JC/MwheXQcRm
 B1FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkpRns1vW5lDynhMfVAx0eFKJdx/wY2OkpVaHcMbJKavH6xA5KhMTD3R82qHH+39rpea1nJ9p82PFtFf5prF8PAw7KkFU=
X-Gm-Message-State: AOJu0Yy14gAkJvr9y0DR74SmiCPj6tLD+PXsJEDiz4owe34ezP60/4Ne
 QrxvzQuLuZgu7tEzz+/LQuseoeWuErsaw+AWu7Zt7k+Lwl4v6AxdXtwBXuLeo8JkBIH87QRV2In
 SnyTrRmtu1XPsLu9sOD7ZCx837Pd2NF+joZgasqi26fX4x3JMy/yj
X-Received: by 2002:adf:f649:0:b0:341:7864:b31e with SMTP id
 x9-20020adff649000000b003417864b31emr1802171wrp.68.1710860240797; 
 Tue, 19 Mar 2024 07:57:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7AppC5kQhBSOsfqAOCiqaQIWDROlSn+dMsR3saDNo1UXiDWUsm2NPLdzWJROdjF752jUXiw==
X-Received: by 2002:adf:f649:0:b0:341:7864:b31e with SMTP id
 x9-20020adff649000000b003417864b31emr1802149wrp.68.1710860240428; 
 Tue, 19 Mar 2024 07:57:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4006000000b0033e699fc6b4sm12584030wrp.69.2024.03.19.07.57.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 07:57:19 -0700 (PDT)
Message-ID: <0f8380d9-bdca-47b2-93d9-ee8f6382e7f1@redhat.com>
Date: Tue, 19 Mar 2024 15:57:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Shaoqin Huang <shahuang@redhat.com>
Cc: qemu-arm@nongnu.org, Sebastian Ott <sebott@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20240221063431.76992-1-shahuang@redhat.com>
 <CAFEAcA-dAghULy_LibG8XLq4yUT3wZLUKvjrRzWZ+4ZSKfYEmQ@mail.gmail.com>
 <c50ece12-0c20-4f37-a193-3d819937272b@redhat.com>
 <CAFEAcA-Yv05R7miBBRj4N1dkFUREHmTAi7ih8hffA3LXCmJkvQ@mail.gmail.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <CAFEAcA-Yv05R7miBBRj4N1dkFUREHmTAi7ih8hffA3LXCmJkvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/29/24 12:00, Peter Maydell wrote:
> On Thu, 29 Feb 2024 at 02:32, Shaoqin Huang <shahuang@redhat.com> wrote:
>>
>> Hi Peter,
>>
>> On 2/22/24 22:28, Peter Maydell wrote:
>>> On Wed, 21 Feb 2024 at 06:34, Shaoqin Huang <shahuang@redhat.com> wrote:
>>>>
>>>> The KVM_ARM_VCPU_PMU_V3_FILTER provides the ability to let the VMM decide
>>>> which PMU events are provided to the guest. Add a new option
>>>> `kvm-pmu-filter` as -cpu sub-option to set the PMU Event Filtering.
>>>> Without the filter, all PMU events are exposed from host to guest by
>>>> default. The usage of the new sub-option can be found from the updated
>>>> document (docs/system/arm/cpu-features.rst).
>>>>
>>>> Here is an example which shows how to use the PMU Event Filtering, when
>>>> we launch a guest by use kvm, add such command line:
>>>>
>>>>    # qemu-system-aarch64 \
>>>>          -accel kvm \
>>>>          -cpu host,kvm-pmu-filter="D:0x11-0x11"
>>>>
>>>> Since the first action is deny, we have a global allow policy. This
>>>> filters out the cycle counter (event 0x11 being CPU_CYCLES).
>>>>
>>>> And then in guest, use the perf to count the cycle:
>>>>
>>>>    # perf stat sleep 1
>>>>
>>>>     Performance counter stats for 'sleep 1':
>>>>
>>>>                1.22 msec task-clock                       #    0.001 CPUs utilized
>>>>                   1      context-switches                 #  820.695 /sec
>>>>                   0      cpu-migrations                   #    0.000 /sec
>>>>                  55      page-faults                      #   45.138 K/sec
>>>>     <not supported>      cycles
>>>>             1128954      instructions
>>>>              227031      branches                         #  186.323 M/sec
>>>>                8686      branch-misses                    #    3.83% of all branches
>>>>
>>>>         1.002492480 seconds time elapsed
>>>>
>>>>         0.001752000 seconds user
>>>>         0.000000000 seconds sys
>>>>
>>>> As we can see, the cycle counter has been disabled in the guest, but
>>>> other pmu events do still work.
> 
>>>
>>> The new syntax for the filter property seems quite complicated.
>>> I think it would be worth testing it with a new test in
>>> tests/qtest/arm-cpu-features.c.
>>
>> I was trying to add a test in tests/qtest/arm-cpu-features.c. But I
>> found all other cpu-feature is bool property.
>>
>> When I use the 'query-cpu-model-expansion' to query the cpu-features,
>> the kvm-pmu-filter will not shown in the returned results, just like below.
>>
>> {'execute': 'query-cpu-model-expansion', 'arguments': {'type': 'full',
>> 'model': { 'name': 'host'}}}{"return": {}}
>>
>> {"return": {"model": {"name": "host", "props": {"sve768": false,
>> "sve128": false, "sve1024": false, "sve1280": false, "sve896": false,
>> "sve256": false, "sve1536": false, "sve1792": false, "sve384": false,
>> "sve": false, "sve2048": false, "pauth": false, "kvm-no-adjvtime":
>> false, "sve512": false, "aarch64": true, "pmu": true, "sve1920": false,
>> "sve1152": false, "kvm-steal-time": true, "sve640": false, "sve1408":
>> false, "sve1664": false}}}}
>>
>> I'm not sure if it's because the `query-cpu-model-expansion` only return
>> the feature which is bool. Since the kvm-pmu-filter is a str, it won't
>> be recognized as a feature.
>>
>> So I want to ask how can I add the kvm-pmu-filter which is str property
>> into the cpu-feature.c test.
> 
> It doesn't appear because the list of properties that we advertise
> via query-cpu-model-expansion is set in the cpu_model_advertised_features[]
> array in target/arm/arm-qmp-cmds.c, and this patch doesn't add
> 'kvm-pmu-filter' to it. But you have a good point about all the
> others being bool properties: I don't know enough about that
> mechanism to know if simply adding this to the list is right.
> 
> This does raise a more general question: do we need to advertise
> the existence of this property to libvirt via QMP? Eric, Sebastian:
> do you know ?
sorry I missed this question. yes I think it is sensible to expose that
option to libvirt. There is no good default value to be set at qemu
level so to me it really depends on the upper stack to choose the
correct value (depending on the sensitiveness of the data that justified
the kernel uapi).
> 
> If we don't care about this being visible to libvirt then the
> importance of having a test case covering the command line
> syntax goes down a bit.
> 
>>>>
>>>> +static void kvm_arm_pmu_filter_init(ARMCPU *cpu)
>>>> +{
>>>> +    static bool pmu_filter_init;
>>>> +    struct kvm_pmu_event_filter filter;
>>>> +    struct kvm_device_attr attr = {
>>>> +        .group      = KVM_ARM_VCPU_PMU_V3_CTRL,
>>>> +        .attr       = KVM_ARM_VCPU_PMU_V3_FILTER,
>>>> +        .addr       = (uint64_t)&filter,
>>>> +    };
>>>> +    int i;
>>>> +    g_auto(GStrv) event_filters;
>>>> +
>>>> +    if (!cpu->kvm_pmu_filter) {
>>>> +        return;
>>>> +    }
>>>> +    if (kvm_vcpu_ioctl(CPU(cpu), KVM_HAS_DEVICE_ATTR, &attr)) {
>>>> +        warn_report("The KVM doesn't support the PMU Event Filter!");
>>>
>>> Drop "The ".
>>>
>>> Should this really only be a warning, rather than an error?
>>>
>>
>> I think this is an add-on feature, and shouldn't block the qemu init
>> process. If we want to set the wrong pmu filter and it doesn't take
>> affect to the VM, it can be detected in the VM.
> 
> But if the user explicitly asked for it, it's not optional
> for them, it's something they want. We should fail if the user
> passes us an option that we can't actually carry out.
> 
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * The filter only needs to be initialized through one vcpu ioctl and it
>>>> +     * will affect all other vcpu in the vm.
>>>
>>> Weird. Why isn't it a VM ioctl if it affects the whole VM ?
>>>
>>  From (kernel) commit d7eec2360e3 ("KVM: arm64: Add PMU event filtering
>> infrastructure"):
>>    Note that although the ioctl is per-vcpu, the map of allowed events is
>>    global to the VM (it can be setup from any vcpu until the vcpu PMU is
>>    initialized).
> 
> That just says it is a per-vcpu ioctl, it doesn't say why...

Marc said in a his cover letter
"
The filter state is global to the guest, despite the PMU being per CPU.
I'm not sure whether it would be worth it making it CPU-private."

I guess this is because Marc wanted to reuse the
KVM_ARM_VCPU_PMU_V3_CTRL group and just added a new attribute on top of
existing
KVM_ARM_VCPU_PMU_V3_IRQ, KVM_ARM_VCPU_PMU_V3_INIT

Thanks

Eric
> 
>>>> +    event_filters = g_strsplit(cpu->kvm_pmu_filter, ";", -1);
>>>> +    for (i = 0; event_filters[i]; i++) {
>>>> +        unsigned short start = 0, end = 0;
>>>> +        char act;
>>>> +
>>>> +        if (sscanf(event_filters[i], "%c:%hx-%hx", &act, &start, &end) != 3) {
>>>> +            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
>>>> +            continue;
>>>> +        }
>>>> +
>>>> +        if ((act != 'A' && act != 'D') || start > end) {
>>>> +            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
>>>> +            continue;
>>>> +        }
>>>
>>> It would be better to do the syntax checking up-front when
>>> the user tries to set the property. Then you can make the
>>> property-setting return an error for invalid strings.
>>>
>>
>> Ok. I guess you mean to say move the syntax checking to the
>> kvm_pmu_filter_set() function. But wouldn't it cause some code
>> duplication? Since it should first check syntax of the string in
>> kvm_pmu_filter_set() and then parse the string in this function.
> 
> No, you should check syntax and parse the string in
> kvm_pmu_filter_set(), and fill in a data structure so you don't
> have to do any string parsing here. kvm_pmu_filter_get()
> will need to reconstitute a string from the data structure.
> 
> thanks
> -- PMM
> 


