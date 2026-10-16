Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5554CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHcDg-0000VL-O9; Fri, 16 Oct 2026 03:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHcDY-0000UX-Au
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 03:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHcDU-0001W3-6L
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 03:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792135138;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3f9/6LgmaKsPXYha8cSw0gPoaJfxngHRSEJk4YtEG3A=;
 b=K+6QSHUoS5z+rtuewR4Ei/X8MLubfRzLNDiKJHplcxP7VmlYcYC3NVHz3pXmpx+D0v71Hu
 JXL7kUTDJlY5QJH+BN5B+OJ+4N8R6eCqwrM5BowuHrfw7RMpxUsjH5e68G6TUl5kGJlaOz
 fAkRTIukzDjsmd6VMQOmQnTnWcOqYRU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-EoRvds2RMviMLS-PHuuYOw-1; Fri, 16 Oct 2026 07:18:57 +0000
X-MC-Unique: EoRvds2RMviMLS-PHuuYOw-1
X-Mimecast-MFC-AGG-ID: EoRvds2RMviMLS-PHuuYOw_1792135136
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a019d53f46so22664395e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 00:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792135136; x=1792739936;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3f9/6LgmaKsPXYha8cSw0gPoaJfxngHRSEJk4YtEG3A=;
 b=KN3z/yfDOAbiGeAAel9kbCOXRvYDg1KyLldgy9jNaBN8Hh+eFvrhzSYP73lorjY1qI
 2jw3sUiiGKjqQUKMujD+K4wJIKiDFay6eGUC0V4Pr6zrJLBxSZP6LqlrQ0PGf403rED/
 AKzn8yElBdyhful9BwKPS1+eB4m3fG6iJl44VZi6UONlF4mM4O5M5783lL9aUoOs/o7f
 /8o2KB7fVUuqB8RnVGLKnMPq++5emCFiGk+GmzYul7SnviNjl9mJmBbfu9di3EuNd3GP
 EfEO5JfbwtU5oR8gRdYz6pOhcbfsrHL/xXgkA/qr2AnKKX3Zs3IQnWfbKHpP4q/xhzmR
 U36Q==
X-Gm-Message-State: AFq9FYL28yOW28mXE0/VQM4lAXpMHac4OkhLJ1JPp2OV3EEpifnRmCLR
 geAqKEIO2dv8Ta1c7VC6ObNVWAt7IjKXrCVjXgeiIuvdCh7wBBS0MnJXNRuFlZ9NJ0mbAIif1GL
 yGMvDAQt3fW4y79W6l6irkIYC2mWW6avfGKm+dhDvkfSpQrBVPAtsFzgn
X-Gm-Gg: AYBFou0KEInWx5hlaRDSC+GZVW4Kq7RkoV81jP7YaLC6ej218naXPhVf1L8MbbEs/4o
 58oTdmbMn1idHAGDJN2DdG9J9zT+4t46QMLlReyr2hV0MUXEOo5sTu97ly/srprBqFR4T0vUZ8n
 Gd+UtJySn0aAO7lVBsB22ClQdGW6HqqLsCwXXgZ/uYDaMT1Pwtr+fj65CoKVMUUU5hvhufsZRDW
 CKRHtwZ9NCbcbBtp8LsIQVUQuLhh4LEJZvECyTDxbA1udawFR346ncW6fLLIvxY8ZMi7hUmiNMp
 kQOA0cDuQEhZioo5HFnFsbmogoAjoMEwY+H1SaabvcrOWqgq2ZQiqGQbKBE338/VhXRl+xwtdV/
 5Hd2u9VGgoUKlbHNNGHPXxrMOnlly2/2uz5dyie9MvQDStIIx
X-Received: by 2002:a05:600c:e54a:10b0:4a0:1f90:594b with SMTP id
 5b1f17b1804b1-4a1c6f89db5mr26497305e9.22.1792135135693; 
 Fri, 16 Oct 2026 00:18:55 -0700 (PDT)
X-Received: by 2002:a05:600c:e54a:10b0:4a0:1f90:594b with SMTP id
 5b1f17b1804b1-4a1c6f89db5mr26496835e9.22.1792135135186; 
 Fri, 16 Oct 2026 00:18:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfdeb18f8sm2607552f8f.20.2026.10.16.00.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 00:18:54 -0700 (PDT)
Message-ID: <88da51b4-bead-4446-8f33-d77ff605b59a@redhat.com>
Date: Fri, 16 Oct 2026 09:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 23/25] qmp: add query-cpu-props-info command
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 "ping@khushitshah.com" <ping@khushitshah.com>,
 Sandesh Patel <sandesh.patel@nutanix.com>
References: <20260921123249.1708067-1-khushit.shah@nutanix.com>
 <20260921123249.1708067-24-khushit.shah@nutanix.com>
 <543a8f0a-bd66-4c13-8117-07f069a754d8@redhat.com>
 <95CBB54C-21CB-4594-8EA4-9C596ADB65EE@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <95CBB54C-21CB-4594-8EA4-9C596ADB65EE@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/16/26 8:57 AM, Khushit Shah wrote:
>
>> On 15 Oct 2026, at 7:50 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>>
>>
>> On 9/21/26 2:32 PM, Khushit Shah wrote:
>>> Introduce the 'query-cpu-props-info' QMP command. For each CPU model
>>> property, it reports the type (boolean or number) and the set of values
>>> supported under the active accelerator and host.
>>>
>>> This helps the management stack to discover which values are supported
>>> for a given CPU property. This is especially important for non-boolean
>>> properties, where knowing that the host has value 'x' does not
>>> inherently reveal the full range of valid values supported on the host.
>>> For example, an Arm host with CTR_EL0.L1Ip=3 (PIPT) also allows 2
>>> (VIPT) but a host with CTR_EL0.L1Ip=2 does not allow CTR_EL0.L1Ip=3
>>> for a guest.
>>>
>>> For numerical properties, the supported values are expressed as a list
>>> of inclusive {min, max} ranges. For boolean properties, they are
>>> represented as a list of true/false values.
>>>
>>> The command and its return types (CpuPropertyType, CpuPropertyInfo and
>>> friends) are defined in qapi/machine.json rather than an Arm-specific
>>> schema, since the concept applies to other targets (e.g. x86, RISC-V)
>>> too. Targets that do not implement it return an error.
>>> (The following commit implements the command for Arm KVM.)
>>>
>>> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
>>> ---
>>> qapi/machine.json          | 82 ++++++++++++++++++++++++++++++++++++++
>>> stubs/meson.build          |  1 +
>>> stubs/qmp-cpu-props-info.c | 12 ++++++
>>> tests/qtest/qmp-cmd-test.c |  1 +
>>> 4 files changed, 96 insertions(+)
>>> create mode 100644 stubs/qmp-cpu-props-info.c
>>>
>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>> index 2d63c1bac3..6e65bdad86 100644
>>> --- a/qapi/machine.json
>>> +++ b/qapi/machine.json
>>> @@ -2291,3 +2291,85 @@
>>> # Since: 1.2
>>> ##
>>> { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'] }
>>> +
>>> +##
>>> +# @CpuPropertyType:
>>> +#
>>> +# The type of a CPU model property.
>>> +#
>>> +# @boolean: the property is of type boolean.
>>> +#
>>> +# @number: the property is of type unsigned integer.
>>> +#
>>> +# Since: 11.2
>>> +##
>>> +{ 'enum': 'CpuPropertyType',
>>> +  'data': [ 'boolean', 'number' ] }
>> why do we still need the boolean type? Can't we simplify and stick to
>> uint64_t for all SYSREG props?
> Hi Eric,
>
> Bools to support existing properties (sve, pauth, etc…) are booleans.
>>> +
>>> +##
>>> +# @CpuPropertyValueRange:
>>> +#
>>> +# An inclusive range of numeric values supported for the property.
>>> +#
>>> +# @min: the lowest supported value.
>>> +#
>>> +# @max: the highest supported value.
>>> +#
>>> +# Since: 11.2
>>> +##
>>> +{ 'struct': 'CpuPropertyValueRange',
>>> +  'data': { 'min': 'uint64', 'max': 'uint64' } }
>>> +
>>> +##
>>> +# @CpuPropertyInfoBoolean:
>>> +#
>>> +# @supported-values: list of boolean values supported for the
>>> +#     property.
>>> +#
>>> +# Since: 11.2
>>> +##
>>> +{ 'struct': 'CpuPropertyInfoBoolean',
>>> +  'data': { 'supported-values': ['bool'] } }
>> why can't you model that with a range too?
> I’m sorry I didn’t get you.

I meant I don't really understand why we need to bother about boolean
props and why we don't just model everything with list of uint64 ranges.
I was puzzled by "list of boolean values supported for the property" Eric
>
> Thanks,
> Khushit
>>> +
>>> +##
>>> +# @CpuPropertyInfoNumber:
>>> +#
>>> +# @supported-values: list of numeric value ranges supported
>>> +#     for the property.
>>> +#
>>> +# Since: 11.2
>>> +##
>>> +{ 'struct': 'CpuPropertyInfoNumber',
>>> +  'data': { 'supported-values': ['CpuPropertyValueRange'] } }
>>> +
>>> +##
>>> +# @CpuPropertyInfo:
>>> +#
>>> +# Information about a single CPU model property, including the values
>>> +# the host/accelerator supports for it.
>>> +#
>>> +# @name: the name of the property.
>>> +#
>>> +# @type: the type of the property, which selects the layout of
>>> +#     @supported-values.
>>> +#
>>> +# Since: 11.2
>>> +##
>>> +{ 'union': 'CpuPropertyInfo',
>>> +  'base': { 'name': 'str',
>>> +            'type': 'CpuPropertyType' },
>>> +  'discriminator': 'type',
>>> +  'data': { 'boolean': 'CpuPropertyInfoBoolean',
>>> +            'number': 'CpuPropertyInfoNumber' } }
>>> +
>>> +##
>>> +# @query-cpu-props-info:
>>> +#
>>> +# Return information about the CPU model properties.  For each
>>> +# property it reports the values supported under the active
>>> +# accelerator and host.
>>> +#
>>> +# Since: 11.2
>>> +##
>>> +{ 'command': 'query-cpu-props-info',
>>> +  'returns': ['CpuPropertyInfo'] }
>>> diff --git a/stubs/meson.build b/stubs/meson.build
>>> index 3b2f2680b1..3bb4028bab 100644
>>> --- a/stubs/meson.build
>>> +++ b/stubs/meson.build
>>> @@ -83,6 +83,7 @@ if have_system
>>>   stub_ss.add(files('qmp-i386-sgx.c'))
>>>   stub_ss.add(files('qmp-i386-xen.c'))
>>>   stub_ss.add(files('qmp-cpu.c'))
>>> +  stub_ss.add(files('qmp-cpu-props-info.c'))
>>>   stub_ss.add(files('qmp-cpu-s390x.c'))
>>>   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
>>>   stub_ss.add(files('hmp-cmd-info_mem.c'))
>>> diff --git a/stubs/qmp-cpu-props-info.c b/stubs/qmp-cpu-props-info.c
>>> new file mode 100644
>>> index 0000000000..36b0530b98
>>> --- /dev/null
>>> +++ b/stubs/qmp-cpu-props-info.c
>>> @@ -0,0 +1,12 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> +#include "qapi/qapi-commands-machine.h"
>>> +
>>> +CpuPropertyInfoList *
>>> +qmp_query_cpu_props_info(Error **errp)
>>> +{
>>> +    error_setg(errp, "query-cpu-props-info not supported on this target");
>>> +    return NULL;
>>> +}
>>> diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
>>> index 279a8f5614..2c25dbd8cb 100644
>>> --- a/tests/qtest/qmp-cmd-test.c
>>> +++ b/tests/qtest/qmp-cmd-test.c
>>> @@ -100,6 +100,7 @@ static bool query_is_ignored(const char *cmd)
>>>         "add-fd",
>>>         /* Success depends on target arch: */
>>>         "query-cpu-definitions",  /* arm, i386, ppc, s390x */
>>> +        "query-cpu-props-info", /* arm + kvm */
>>>         "query-gic-capabilities", /* arm */
>>>         "query-s390x-cpu-polarization", /* s390x */
>>>         /* Success depends on target-specific build configuration: */
>> Thanks
>>
>> Eric
>


