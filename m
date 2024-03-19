Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DCAC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 17:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmdjz-0007Yq-Dk; Tue, 19 Mar 2024 13:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rmdjZ-0007I3-Ih
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rmdjS-0006ch-Fr
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710871118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYmU+L2QgZldk4KcApW+ioelmr5/F2Py6BDqP9YORtA=;
 b=PKzcgcwYbI2ZZkSQ6t7yTtZcXx0P5m1/Dz4AWWKkCbLvqB+6Xaa3K4AUrj7/jV+DvLj96H
 sM/Bq45blsocfXFtgGROzBUG7cjlpshlnvVBnKYJ/d6RDfOIP6BtZFNQzkAppdHWqEYhli
 FMxipWzGLrQnRZmpf4yxaX7K8xgYNAg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-3PAoL73mOFqY1Ttn4McKiw-1; Tue, 19 Mar 2024 13:58:36 -0400
X-MC-Unique: 3PAoL73mOFqY1Ttn4McKiw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ec0700091so3718327f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 10:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710871115; x=1711475915;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jYmU+L2QgZldk4KcApW+ioelmr5/F2Py6BDqP9YORtA=;
 b=NsxTYUGWSTZcL+Dd8PgfAmdiD5kDvZNLgKYpbKbb+xYJk09j/HaN3z+3u5nireZOUZ
 m3HxOkOLQI7NtmSD/eZJCMz2uO/I87h7tvGTwF5F4TyGMAcY82OMqWnCOLqyjJLA/cCj
 +lxJm/0JYXBo4O5T403Y4/sOuPS1L8XHKEp5sN+wQd5w6E/pyjc09394FMCm5OdqAYld
 w5ODfduww84H01jVlofH9SEJNY/d5ZuJxU/pPHg7rLrGXnbth6cy2dt9INo9pUk77pQR
 P8zHWT3m5s6xPPKeZhOlA7g0lKsX2LnDJLZdAy+3wAk9JS7FW+aMjkwqFakOl5ahKZLw
 eFQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB5yHFdEB5LCweZhJbKkT9utyB3sZiv4mpWn36YBcBpSlXegzqNpKdNRewBwv7OD+14MIsi3x6linDgwpgDWZR/nhzknk=
X-Gm-Message-State: AOJu0Yws/9ZP0IWrj1FYBpDGKaXknwUTEeurKVVsonNdKZTvMVmvX+0k
 KeDjUPomU7gV5hGy3hy5iE4608PNYOu68bam/skggWn/xvXfrySvpIjAJVwRMp7eXr7gpQeTA2M
 LbBS6FMzmiUqnxtNiGEL1vaARjOLPR+e4c/6WhekdazomORK0nyuM
X-Received: by 2002:adf:f583:0:b0:341:8efd:e20d with SMTP id
 f3-20020adff583000000b003418efde20dmr1471613wro.23.1710871115200; 
 Tue, 19 Mar 2024 10:58:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJaj9GK+Gn5lZ9KkbZqTGQDZfNRc+e2z6IHIpdRPOxzqcjSQsXBXG/qADG5Bw+HKzuiR6uMA==
X-Received: by 2002:adf:f583:0:b0:341:8efd:e20d with SMTP id
 f3-20020adff583000000b003418efde20dmr1471599wro.23.1710871114880; 
 Tue, 19 Mar 2024 10:58:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 y10-20020a5d4aca000000b0033e03d37685sm12909668wrs.55.2024.03.19.10.58.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 10:58:34 -0700 (PDT)
Message-ID: <84e01fa8-0de6-4d2b-8696-53cd3c3f42fa@redhat.com>
Date: Tue, 19 Mar 2024 18:58:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>
Cc: qemu-arm@nongnu.org, Sebastian Ott <sebott@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240221063431.76992-1-shahuang@redhat.com>
 <ZfmtxxlATpvhK61y@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <ZfmtxxlATpvhK61y@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
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

Hi Daniel,

On 3/19/24 16:22, Daniel P. Berrangé wrote:
> On Wed, Feb 21, 2024 at 01:34:31AM -0500, Shaoqin Huang wrote:
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
>>   # qemu-system-aarch64 \
>>         -accel kvm \
>>         -cpu host,kvm-pmu-filter="D:0x11-0x11"
> 
> snip
> 
>> @@ -517,6 +533,12 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
>>                               kvm_steal_time_set);
>>      object_property_set_description(obj, "kvm-steal-time",
>>                                      "Set off to disable KVM steal time.");
>> +
>> +    object_property_add_str(obj, "kvm-pmu-filter", kvm_pmu_filter_get,
>> +                            kvm_pmu_filter_set);
>> +    object_property_set_description(obj, "kvm-pmu-filter",
>> +                                    "PMU Event Filtering description for "
>> +                                    "guest PMU. (default: NULL, disabled)");
>>  }
> 
> Passing a string property, but....[1]
> 
>>  
>>  bool kvm_arm_pmu_supported(void)
>> @@ -1706,6 +1728,62 @@ static bool kvm_arm_set_device_attr(ARMCPU *cpu, struct kvm_device_attr *attr,
>>      return true;
>>  }
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
> If the user requested a filter and it can't be supported, QEMU
> must exit with an error, not ignore the user's request.
> 
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * The filter only needs to be initialized through one vcpu ioctl and it
>> +     * will affect all other vcpu in the vm.
>> +     */
>> +    if (pmu_filter_init) {
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
>> +        if (sscanf(event_filters[i], "%c:%hx-%hx", &act, &start, &end) != 3) {
>> +            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
>> +            continue;
> 
> Warning on user syntax errors is undesirable - it should be a fatal
> error of the user gets this wrong.
> 
>> +        }
>> +
>> +        if ((act != 'A' && act != 'D') || start > end) {
>> +            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
>> +            continue;
> 
> Likewise should be fatal.
> 
>> +        }
>> +
>> +        filter.base_event = start;
>> +        filter.nevents = end - start + 1;
>> +        filter.action = (act == 'A') ? KVM_PMU_EVENT_ALLOW :
>> +                                       KVM_PMU_EVENT_DENY;
>> +
>> +        if (!kvm_arm_set_device_attr(cpu, &attr, "PMU_V3_FILTER")) {
>> +            break;
>> +        }
>> +    }
>> +}
> 
> ..[1] then implementing a custom parser is rather a QEMU design anti-pattern,
> especially when the proposed syntax is incapable of being mapped into the
> normal QAPI syntax for a list of structs should we want to fully convert
> -cpu to QAPI parsing later. I wonder if can we model this property with
> QAPI now ?
I guess you mean creating a new property like those in
hw/core/qdev-properties-system.c for instance  and populating an array
of those at CPU object level?

Note there is v8 but most of your comments still apply
https://lore.kernel.org/all/20240312074849.71475-1-shahuang@redhat.com/

Thanks

Eric
> 
> With regards,
> Daniel


