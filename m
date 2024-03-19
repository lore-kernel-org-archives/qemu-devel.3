Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856DDC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 18:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rme37-0001Dm-2k; Tue, 19 Mar 2024 14:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rme35-0001Bu-NM
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:18:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rme33-0001a1-UJ
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710872332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0i1FXUp3Se0Q8v6HAao+2JETY0/VPzWwNUhVoeedqFg=;
 b=DLTgm/WujYiJXZtmrAonB1F31NUxfFEmSAA7MuvaQjU1LpOGFLnOwUByNsQRCiIoepnzdj
 1GgehGceReOf2NB3p9rWVF6GecNqCwktk8VqzdYIVDwVrzqs2cNNz+YA3s6SnxgZW9a7ew
 qTnxKm3hwzoz6g1mHJ7oLQKAq/F/las=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-5m-74j0nMvy0vID_euFRog-1; Tue, 19 Mar 2024 14:18:50 -0400
X-MC-Unique: 5m-74j0nMvy0vID_euFRog-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ec0700091so3729262f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 11:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710872329; x=1711477129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0i1FXUp3Se0Q8v6HAao+2JETY0/VPzWwNUhVoeedqFg=;
 b=QE62Rh7R1NCJcyw1J3DIvHvCM4XF+kZuR8PlWAq7OGCopo7GaJQCbjS7pDAy/wcOI3
 3nGt66MdFie1D0Ev1nj3g8R0+8kDYMuZFMsyZu5uKW5moqYZx1dBpSi+iMJvvfdbP/eq
 Y4ezq9Nxsc+VIA+OuSx3CLs8fAGay0TmnTLCBnE5sVDISwmy0pWM2rxvziRX7irrzTVh
 BpqB8dNKDh+lH2QKGOVWyMw9gIISDMXFX4AYdMKjICzLlcD5fWg6uI7SztjFF33SExoe
 HM6gwnRf6qUSrIqcxPkYDOY96KWSkazETtzlr8pFgEGKiUgRTgmXCBw0Y/o3bGxmTcxK
 2Llg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOgh+ZAIAeiH2Z7cvoirwUucWgq2t073pf0KQVpgvxuKjqsFjqAHESZYxd9VMtm5ZGSUkohwy7FtyMGX/5bt1ptVPYUTQ=
X-Gm-Message-State: AOJu0Ywxi60ulxmKxIj4VjsdJzRqJ912RecJDi+5Mr4rWSosaxB/+m8f
 0+E/AJrNibH197beDkisVJRxKGnb/ZKjeYc5u/tMuAetHeWccM5Wulsr+sE6EBVg0Zh8uxRKbfo
 C+4JIyvaIIjWwK6/YRGMRs1SfGpunu3PPsgoTTrbXtPp/e4KlHCMR
X-Received: by 2002:a5d:6505:0:b0:33e:1e0:2679 with SMTP id
 x5-20020a5d6505000000b0033e01e02679mr10466486wru.47.1710872329404; 
 Tue, 19 Mar 2024 11:18:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFabTZcYR2CWBvnYuMUxPYalH15zeGyYk2U9hmhf16bKkWsKNfW+fEYPxikdl7MgJ+RVcgwMw==
X-Received: by 2002:a5d:6505:0:b0:33e:1e0:2679 with SMTP id
 x5-20020a5d6505000000b0033e01e02679mr10466468wru.47.1710872329046; 
 Tue, 19 Mar 2024 11:18:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a056000038e00b0033e34c53354sm8525278wrf.56.2024.03.19.11.18.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 11:18:48 -0700 (PDT)
Message-ID: <f26c5a3d-8ca8-4fbc-860e-d170cd5973c8@redhat.com>
Date: Tue, 19 Mar 2024 19:18:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org,
 Sebastian Ott <sebott@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20240221063431.76992-1-shahuang@redhat.com>
 <ZfmtxxlATpvhK61y@redhat.com>
 <84e01fa8-0de6-4d2b-8696-53cd3c3f42fa@redhat.com>
 <ZfnUZKf3p8jv2yEM@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <ZfnUZKf3p8jv2yEM@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

Hi,

On 3/19/24 19:07, Daniel P. Berrangé wrote:
> On Tue, Mar 19, 2024 at 06:58:33PM +0100, Eric Auger wrote:
>> Hi Daniel,
>>
>> On 3/19/24 16:22, Daniel P. Berrangé wrote:
>>> On Wed, Feb 21, 2024 at 01:34:31AM -0500, Shaoqin Huang wrote:
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
>>>>   # qemu-system-aarch64 \
>>>>         -accel kvm \
>>>>         -cpu host,kvm-pmu-filter="D:0x11-0x11"
>>>
>>> snip
>>>
>>>> @@ -517,6 +533,12 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
>>>>                               kvm_steal_time_set);
>>>>      object_property_set_description(obj, "kvm-steal-time",
>>>>                                      "Set off to disable KVM steal time.");
>>>> +
>>>> +    object_property_add_str(obj, "kvm-pmu-filter", kvm_pmu_filter_get,
>>>> +                            kvm_pmu_filter_set);
>>>> +    object_property_set_description(obj, "kvm-pmu-filter",
>>>> +                                    "PMU Event Filtering description for "
>>>> +                                    "guest PMU. (default: NULL, disabled)");
>>>>  }
>>>
>>> Passing a string property, but....[1]
>>>
>>>>  
>>>>  bool kvm_arm_pmu_supported(void)
>>>> @@ -1706,6 +1728,62 @@ static bool kvm_arm_set_device_attr(ARMCPU *cpu, struct kvm_device_attr *attr,
>>>>      return true;
>>>>  }
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
>>> If the user requested a filter and it can't be supported, QEMU
>>> must exit with an error, not ignore the user's request.
>>>
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * The filter only needs to be initialized through one vcpu ioctl and it
>>>> +     * will affect all other vcpu in the vm.
>>>> +     */
>>>> +    if (pmu_filter_init) {
>>>> +        return;
>>>> +    } else {
>>>> +        pmu_filter_init = true;
>>>> +    }
>>>> +
>>>> +    event_filters = g_strsplit(cpu->kvm_pmu_filter, ";", -1);
>>>> +    for (i = 0; event_filters[i]; i++) {
>>>> +        unsigned short start = 0, end = 0;
>>>> +        char act;
>>>> +
>>>> +        if (sscanf(event_filters[i], "%c:%hx-%hx", &act, &start, &end) != 3) {
>>>> +            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
>>>> +            continue;
>>>
>>> Warning on user syntax errors is undesirable - it should be a fatal
>>> error of the user gets this wrong.
>>>
>>>> +        }
>>>> +
>>>> +        if ((act != 'A' && act != 'D') || start > end) {
>>>> +            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
>>>> +            continue;
>>>
>>> Likewise should be fatal.
>>>
>>>> +        }
>>>> +
>>>> +        filter.base_event = start;
>>>> +        filter.nevents = end - start + 1;
>>>> +        filter.action = (act == 'A') ? KVM_PMU_EVENT_ALLOW :
>>>> +                                       KVM_PMU_EVENT_DENY;
>>>> +
>>>> +        if (!kvm_arm_set_device_attr(cpu, &attr, "PMU_V3_FILTER")) {
>>>> +            break;
>>>> +        }
>>>> +    }
>>>> +}
>>>
>>> ..[1] then implementing a custom parser is rather a QEMU design anti-pattern,
>>> especially when the proposed syntax is incapable of being mapped into the
>>> normal QAPI syntax for a list of structs should we want to fully convert
>>> -cpu to QAPI parsing later. I wonder if can we model this property with
>>> QAPI now ?
>> I guess you mean creating a new property like those in
>> hw/core/qdev-properties-system.c for instance  and populating an array
>> of those at CPU object level?
> 
> Yeah, something like the IOThreadVirtQueueMapping data type would
> be the more QAPI like code pattern.
OK thank you for the confirmation. Then if we create such kind of
property it would be nice that this latter also matches the need of x86
PMU filtering. I think the uapi exists at KVM level but has never been
integrated in qemu.
> 
>> Note there is v8 but most of your comments still apply
>> https://lore.kernel.org/all/20240312074849.71475-1-shahuang@redhat.com/
> 
> Yes, sorry I just saw Peter's query about libvirt on this v7 and
> didn't think to look for a newer version

no problem. Thank you for your time

Eric
> 
> With regards,
> Daniel


