Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E7EC3ABBE
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 01:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCTnk-0004Cn-2V; Tue, 06 May 2025 21:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uCTne-0004CS-0i
 for qemu-devel@nongnu.org; Tue, 06 May 2025 21:42:18 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uCTnb-0002iA-Ob
 for qemu-devel@nongnu.org; Tue, 06 May 2025 21:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746582136; x=1778118136;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=nCf5ZmhbgXtBXjaqnXiaUHHtcuJ85NmqG5UJyMpPM04=;
 b=VGxFATF7si3oPDdp3IwIy3d0zFKRSM0mCF5SuNMEO9FRYp5m/lkY6RG9
 FI47odC9MrTBH6ISCdaMHwijb0TgIXmUj8Mf30VTqdzxXI6TtE9qeRP1/
 wTnd5P9QK7GAUcU5kzTpFtqai7RSXqHH9GtllwZhSTvdxBEASE6Ym6wmt
 4OYp22fF+nCd2RXf0ZPfyl56mi2NWTHKATl52gibXDvOzUbWu4boiVRLt
 OrQMDOSOEGx0otT0vqnggcrX0pYc1of2UGYoE5CfGFFe1S0VoHkY1FNF1
 vRi1wxXUipJJUfhgOLdgH42GCclZNl9eFISYeCX+tTdYONbGNCkzFJEqv g==;
X-CSE-ConnectionGUID: U43oORxxRpafxFtLhpWNlQ==
X-CSE-MsgGUID: Ez1BgX1uQHuJiT6KnB/OHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="52095580"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="52095580"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 18:42:11 -0700
X-CSE-ConnectionGUID: /t/T70mGTjaE1eZ5dFcuOQ==
X-CSE-MsgGUID: MkNpYIu/ReyT9uo4FbmzNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="166723803"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 18:42:08 -0700
Message-ID: <3256bf6a-e113-48fa-9e82-e847dc465bc0@intel.com>
Date: Wed, 7 May 2025 09:42:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 31/55] i386/cpu: introduce
 x86_confidential_guest_cpu_instance_init()
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-32-xiaoyao.li@intel.com>
 <884fdc77-94f8-41f5-a579-aa70fa652eb9@intel.com> <aBCkt7bI1o+x8MWk@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aBCkt7bI1o+x8MWk@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/29/2025 6:06 PM, Zhao Liu wrote:
> On Thu, Apr 24, 2025 at 01:51:55PM +0800, Xiaoyao Li wrote:
>> Date: Thu, 24 Apr 2025 13:51:55 +0800
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: Re: [PATCH v8 31/55] i386/cpu: introduce
>>   x86_confidential_guest_cpu_instance_init()
>>
>> Hi Paolo,
>>
>> On 4/1/2025 9:01 PM, Xiaoyao Li wrote:
>> ...
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index add6430f7edd..5c69d1489365 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -36,6 +36,7 @@
>>>    #include "hw/qdev-properties.h"
>>>    #include "hw/i386/topology.h"
>>>    #ifndef CONFIG_USER_ONLY
>>> +#include "confidential-guest.h"
>>>    #include "system/reset.h"
>>>    #include "qapi/qapi-commands-machine-target.h"
>>>    #include "exec/address-spaces.h"
>>> @@ -8504,6 +8505,15 @@ static void x86_cpu_post_initfn(Object *obj)
>>>        }
>>>        accel_cpu_instance_init(CPU(obj));
>>> +
>>> +#ifndef CONFIG_USER_ONLY
>>> +    MachineState *ms = MACHINE(object_dynamic_cast(qdev_get_machine(),
>>> +                                                   TYPE_MACHINE));
>>
>> It leads to
>>
>>    qemu-system-x86_64: ../hw/core/qdev.c:824: qdev_get_machine: Assertion
>> `dev' failed.
>>    Aborted (core dumped)
>>
>> for the case of "-cpu help" due to the assert(dev) in qdev_get_machine().
>>
>> How do you want to resolve it? I can think of two:
>> 1. remove the assert() in qdev_get_machine(). or
>> 2. drop the callback introduce by this patch. Instead just do
>>
>>     if (is_tdx_vm()) {
>> 	tdx_cpu_instance_init();
>>     }
> 
> Sorry I missed this mail when review this patch.
> 
> What about checking `current_machine`?
> 
> @@ -8541,10 +8541,8 @@ static void x86_cpu_post_initfn(Object *obj)
>       accel_cpu_instance_init(CPU(obj));
> 
>   #ifndef CONFIG_USER_ONLY
> -    MachineState *ms = MACHINE(object_dynamic_cast(qdev_get_machine(),
> -                                                   TYPE_MACHINE));
> -    if (ms && ms->cgs) {
> -        x86_confidential_guest_cpu_instance_init(X86_CONFIDENTIAL_GUEST(ms->cgs),
> +    if (current_machine && current_machine->cgs) {
> +        x86_confidential_guest_cpu_instance_init(X86_CONFIDENTIAL_GUEST(current_machine->cgs),
>                                                    (CPU(obj)));
>       }
>   #endif
> ---
> 
> "-cpu help" is processed before machine creation. The cpu-core
> (cpu_core_instance_init) also checks current_machine to avoid similar
> issue.

This is a really good suggestion! I'll take it.

Thanks!

> Regards,
> Zhao
> 
> 


