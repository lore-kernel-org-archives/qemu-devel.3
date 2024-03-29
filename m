Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5E8CD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 13:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqBtl-0006Tz-0F; Fri, 29 Mar 2024 09:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rqBti-0006SR-WF
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 09:03:55 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rqBth-0004gT-0x
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 09:03:54 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56b0af675deso2276245a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 06:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711717431; x=1712322231; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fF0AEMcN53T8zLpULJXCYH56leqwh2GeC0VdcdisnsI=;
 b=pb9DKbq4lUeVCptzYpIly5E5LB0jA7ygK+hB1HNIkleyS3POwCcuSXm5WPN4aMSfZ3
 2rQuBGvRLF/BKAmRXLxQ7oLoWs9ji7KM9BQV6Xxgk8TbWOe7q9P4PuK4pli4lwvfaMr/
 cemepGeMd/jn4QU4eQYKMsbS9vEYAVqLQSPiWoYkf9K2Hosa4akGOwKQaLJFZZFiF0mj
 z+e7TWVqU7n0PGNwGOTBDffWMVnJU0SnLOPXlz0PAFs3D+/GTbQmvKwFPJVHUvP4oPSP
 bsdwVFXY4KoBsWy8RON4LHEx8TKv2dguWQT7MIKLAyjXUIz9AsPntCIIieJ/bJ8a17XZ
 q0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711717431; x=1712322231;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fF0AEMcN53T8zLpULJXCYH56leqwh2GeC0VdcdisnsI=;
 b=b1E1wvXzdq6fm7t3/n+X5rxfPQ9QE3COKS1deyfD1VyF79nBpuio36lZMYSBJIfk5L
 Q7gNQaCchXzwT6PQYTpfX3pGGVS27rCCM+urX9eMLkJu6js+278tSwwEUJuh3ki65H14
 1RK+rB9NwCvgEBUdgIb/nLoZR2DdQ6uEqG+CjWNFw997QNpOBfVhVS6ZSHyozVO/cQt8
 Swm2fGkubw3tL/v5+kcSIgaijNZ1mm5zjsPsf5J9RnHp2NwHVuZyBZdnR0K5rf01HkRK
 SZYUyp+Ljb71kyAi9qBh+dh79H2cso4feWYxsPOVP0JvmLsSsvpu+LDE8nhIGqAJJUSP
 Yr8w==
X-Gm-Message-State: AOJu0Ywl3LlAwjt7ZRfJ5KWwQSHWSrEKy3c4/UDTrB4FmBbh3BYWqSRj
 Zxt3z2wX8bv4Mx0ZUDWw1gu3ULoXVO9cL6EjN6F9Mv5u2AKkUY9B89NlFmMyVI0=
X-Google-Smtp-Source: AGHT+IGusDVQ3jg0+CI+1zek0hD2iAfaouUn42nWLXeYMVkdB3NDh3jjiz+sA4UW771dJxUwH2T1wg==
X-Received: by 2002:a17:906:3605:b0:a46:fb17:8871 with SMTP id
 q5-20020a170906360500b00a46fb178871mr1634695ejb.76.1711717431337; 
 Fri, 29 Mar 2024 06:03:51 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-242.dsl.sta.abo.bbox.fr.
 [176.184.39.242]) by smtp.gmail.com with ESMTPSA id
 o1-20020a1709064f8100b00a46baba1a0asm1914163eju.100.2024.03.29.06.03.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Mar 2024 06:03:50 -0700 (PDT)
Message-ID: <96bcb673-18dd-49bc-8bcb-281c7409b410@linaro.org>
Date: Fri, 29 Mar 2024 14:03:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.1 14/21] system: Introduce QMP
 generic_query_cpu_definitions()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>
References: <20240315130910.15750-1-philmd@linaro.org>
 <20240315130910.15750-15-philmd@linaro.org> <87v859m89y.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87v859m89y.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

Hi Markus,

On 26/3/24 14:28, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Each target use a common template for qmp_query_cpu_definitions().
>>
>> Extract it as generic_query_cpu_definitions(), keeping the
>> target-specific implementations as the following SysemuCPUOps
>> handlers:
>>   - cpu_list_compare()
>>   - add_definition()
>>   - add_alias_definitions()
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   MAINTAINERS                           |  2 +
>>   include/hw/core/sysemu-cpu-ops.h      | 14 ++++++
>>   include/qapi/commands-target-compat.h | 14 ++++++
>>   system/cpu-qmp-cmds.c                 | 71 +++++++++++++++++++++++++++
>>   system/meson.build                    |  1 +
>>   5 files changed, 102 insertions(+)
>>   create mode 100644 include/qapi/commands-target-compat.h
>>   create mode 100644 system/cpu-qmp-cmds.c


>> diff --git a/system/cpu-qmp-cmds.c b/system/cpu-qmp-cmds.c
>> new file mode 100644
>> index 0000000000..daeb131159
>> --- /dev/null
>> +++ b/system/cpu-qmp-cmds.c
>> @@ -0,0 +1,71 @@
>> +/*
>> + * QAPI helpers for target specific QMP commands
>> + *
>> + * SPDX-FileCopyrightText: 2024 Linaro Ltd.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qom/object.h"
>> +#include "qapi/commands-target-compat.h"
>> +#include "sysemu/arch_init.h"
>> +#include "hw/core/cpu.h"
>> +#include "hw/core/sysemu-cpu-ops.h"
>> +
>> +static void cpu_common_add_definition(gpointer data, gpointer user_data)
>> +{
>> +    ObjectClass *oc = data;
>> +    CpuDefinitionInfoList **cpu_list = user_data;
>> +    CpuDefinitionInfo *info;
>> +    const char *typename;
>> +
>> +    typename = object_class_get_name(oc);
>> +    info = g_malloc0(sizeof(*info));
>> +    info->name = cpu_model_from_type(typename);
>> +    info->q_typename = g_strdup(typename);
>> +
>> +    QAPI_LIST_PREPEND(*cpu_list, info);
>> +}
>> +
>> +static void arch_add_cpu_definitions(CpuDefinitionInfoList **cpu_list,
>> +                                     const char *cpu_typename)
>> +{
>> +    ObjectClass *oc;
>> +    GSList *list;
>> +    const struct SysemuCPUOps *ops;
>> +
>> +    oc = object_class_by_name(cpu_typename);
>> +    if (!oc) {
>> +        return;
>> +    }
>> +    ops = CPU_CLASS(oc)->sysemu_ops;
>> +
>> +    list = object_class_get_list(cpu_typename, false);
>> +    if (ops->cpu_list_compare) {
>> +        list = g_slist_sort(list, ops->cpu_list_compare);
>> +    }
>> +    g_slist_foreach(list, ops->add_definition ? : cpu_common_add_definition,
>> +                    cpu_list);
>> +    g_slist_free(list);
>> +
>> +    if (ops->add_alias_definitions) {
>> +        ops->add_alias_definitions(cpu_list);
>> +    }
>> +}
>> +
>> +CpuDefinitionInfoList *generic_query_cpu_definitions(Error **errp)
>> +{
>> +    CpuDefinitionInfoList *cpu_list = NULL;
>> +
>> +    for (unsigned i = 0; i <= QEMU_ARCH_BIT_LAST; i++) {
>> +        const char *cpu_typename;
>> +
>> +        cpu_typename = cpu_typename_by_arch_bit(i);
>> +        if (!cpu_typename) {
>> +            continue;
>> +        }
>> +        arch_add_cpu_definitions(&cpu_list, cpu_typename);
>> +    }
>> +
>> +    return cpu_list;
>> +}
> 
> The target-specific qmp_query_cpu_definitions() this is going to replace
> each execute the equivalent of *one* loop iteration: the one
> corresponding to their own arch bit.
> 
> For the replacement to be faithful, as cpu_typename_by_arch_bit() must
> return non-null exactly once.
> 
> This is the case for the qemu-system-TARGET.  The solution feels
> overengineered there.
> 
> I figure cpu_typename_by_arch_bit() will return non-null multiple times
> in a future single binary supporting heterogeneous machines.
> 
> Such a single binary then can't serve as drop-in replacement for the
> qemu-system-TARGET, because query-cpu-definitions returns more.
> 
> To get a drop-in replacement, we'll need additional logic to restrict
> the query for the homogeneous use case.

Can we ask the management layer to provide the current homogeneous
target via argument? Otherwise we can add a new query-cpu-definitions-v2
command requiring an explicit target argument, allowing 'all', and
deprecate the current query-cpu-definitions.

> I think this needs to be discussed in the commit message.
> 
> Possibly easier: don't loop over the bits, relying on
> cpu_typename_by_arch_bit() to select the right one.  Instead get the
> right bit from somewhere.
> 
> We can switch to a loop when we need it for the heterogeneous case.

Alex suggested to consider heterogeneous emulation the new default,
and the current homogeneous use as a particular case. I'd rather not
plan on a "heterogeneous switch day" and get things integrated in
the way, otherwise we'll never get there...

Regards,

Phil.

