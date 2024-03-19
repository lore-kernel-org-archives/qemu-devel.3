Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746BCC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 18:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmdxL-0006l2-In; Tue, 19 Mar 2024 14:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmdxJ-0006kJ-5F
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:12:57 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmdxG-0000hL-0q
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:12:56 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-512f54fc2dbso5486541e87.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710871970; x=1711476770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FB3YqW4Uz4oF+ZT7QZKeFJc7YepbHj5rdBwBsiNNT74=;
 b=tOeYp17dx9iQFPd1lCtxQWWEAe7HuUGTf3hqReLzMjq81nhyYW7Mj/vDoX8sBJiEye
 bUJT+tvcfVYTLGdcitva+3TIDdOWgei9sa9KAFnTVEunGPYgttD0eTGVYWOJXrHbGIIL
 IEVgHuy9D1e7C5LHxn5ikPVYrWzi5TH9ghOl8Q8gHrn/z/RD7eBYhCVXWIXbgyIdIhnI
 DxFuBj08qhrtNQnpB990ceU72kef9BqLsFF77gVX+P+dqDenluFif+pqkwqbMx5yx+Ix
 HK1S5zwWUhqAF4Tiin2iwyeIWgfu1JkgDcZz15ind+CjzqX+CBNdVPNTrMWarnjxxdTK
 y4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710871970; x=1711476770;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FB3YqW4Uz4oF+ZT7QZKeFJc7YepbHj5rdBwBsiNNT74=;
 b=OqAm4XBFRa6MfmUyTgS817uYqLjXlaxrgqb8yojR0BP22nlxtIJ7PJXdVOhc89LkT3
 KGlyWP/3f3oXjrfHI5CgfL6u7qEkWU9HT+1bLBucRCK44eo2RFzuIC1xA0Ee0h8VnNkg
 4AAGhlC0KY6zdSk/OBt5Kd2fD7ik88e7cnH4sUQmpJOlwJYrEJf3E6fmYnTzAlATojS4
 zmazeHZFhAf5OfoB/Hv9ueEkcKegN3frl6X+eQpY1sUTeyROaMslTfgl3T8l+Nse+Ggr
 GMYUeY79k9QmWRGHQMKbybPjeiqBbTj1/0JWdbgdR0FAkEXB/CEEAuKNsN4vBKjQl8Lb
 hK0Q==
X-Gm-Message-State: AOJu0Yw9Nke9U3ls6HyKcMIY1s9vxwfERwifRh24pMrEbHQqarNnXegv
 t7+Zv4G1dOrNIj7JxTRtcxpl1ZUUgnyFXPUSVudf0NV95ev4OHnF6TASqocoC7oy1g4Uq6tSB0z
 Y
X-Google-Smtp-Source: AGHT+IHoKELfbuECkuyLTUglf/dSA5ERaIVTmAVO/Cip6Uc4c6+9VYEZkr434C24QN3zzUUzDRX9Ww==
X-Received: by 2002:a05:6512:20c6:b0:513:bf23:ce3 with SMTP id
 u6-20020a05651220c600b00513bf230ce3mr11096828lfr.62.1710871969986; 
 Tue, 19 Mar 2024 11:12:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 bw9-20020a170906c1c900b00a45ff821e09sm6328790ejb.150.2024.03.19.11.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 11:12:49 -0700 (PDT)
Message-ID: <53e1f69f-3a52-4972-b1ba-6ad07507b197@linaro.org>
Date: Tue, 19 Mar 2024 19:12:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 07/21] target/mips: Make MIPS_CPU common to new
 MIPS32_CPU / MIPS64_CPU types
Content-Language: en-US
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@kernel.org>
References: <20240315130910.15750-1-philmd@linaro.org>
 <20240315130910.15750-8-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240315130910.15750-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 15/3/24 14:08, Philippe Mathieu-Daudé wrote:
> "target/foo/cpu-qom.h" can not use any target specific definitions.
> 
> Currently "target/mips/cpu-qom.h" defines TYPE_MIPS_CPU depending
> on the mips(32)/mips64 build type. This doesn't scale in a
> heterogeneous context where we need to access both types concurrently.
> 
> In order to do that, introduce the new MIPS32_CPU / MIPS64_CPU types,
> both inheriting a common TYPE_MIPS_CPU base type.
> 
> Keep the current CPU types registered in mips_register_cpudef_type()
> as 32 or 64-bit, but instead of depending on the binary built being
> targeting 32/64-bit, check whether the CPU is 64-bit by looking at
> the CPU_MIPS64 bit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/cpu-qom.h              | 13 +++++++------
>   target/mips/cpu.c                  | 11 ++++++++++-
>   target/mips/sysemu/mips-qmp-cmds.c | 26 ++------------------------
>   3 files changed, 19 insertions(+), 31 deletions(-)
> 
> diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
> index 0eea2a2598..bf464f16b6 100644
> --- a/target/mips/cpu-qom.h
> +++ b/target/mips/cpu-qom.h
> @@ -1,5 +1,5 @@
>   /*
> - * QEMU MIPS CPU
> + * QEMU MIPS CPU QOM header (target agnostic)
>    *
>    * Copyright (c) 2012 SUSE LINUX Products GmbH
>    *
> @@ -22,14 +22,15 @@
>   
>   #include "hw/core/cpu.h"
>   
> -#ifdef TARGET_MIPS64
> -#define TYPE_MIPS_CPU "mips64-cpu"
> -#else
> -#define TYPE_MIPS_CPU "mips-cpu"
> -#endif
> +#define TYPE_MIPS_CPU   "mips-cpu"
> +#define TYPE_MIPS32_CPU "mips32-cpu"
> +#define TYPE_MIPS64_CPU "mips64-cpu"
>   
>   OBJECT_DECLARE_CPU_TYPE(MIPSCPU, MIPSCPUClass, MIPS_CPU)
>   
> +OBJECT_DECLARE_CPU_TYPE(MIPS32CPU, MIPSCPUClass, MIPS32_CPU)
> +OBJECT_DECLARE_CPU_TYPE(MIPS64CPU, MIPSCPUClass, MIPS64_CPU)
> +
>   #define MIPS_CPU_TYPE_SUFFIX "-" TYPE_MIPS_CPU
>   #define MIPS_CPU_TYPE_NAME(model) model MIPS_CPU_TYPE_SUFFIX
>   
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index c096d97fe3..f3ea6175f2 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -604,6 +604,14 @@ static const TypeInfo mips_cpu_types[] = {
>           .abstract       = true,
>           .class_size     = sizeof(MIPSCPUClass),
>           .class_init     = mips_cpu_class_init,
> +    }, {
> +        .name           = TYPE_MIPS32_CPU,
> +        .parent         = TYPE_MIPS_CPU,
> +        .abstract       = true,
> +    }, {
> +        .name           = TYPE_MIPS64_CPU,
> +        .parent         = TYPE_MIPS_CPU,
> +        .abstract       = true,
>       }
>   };
>   
> @@ -620,7 +628,8 @@ static void mips_register_cpudef_type(const struct mips_def_t *def)
>       char *typename = mips_cpu_type_name(def->name);
>       TypeInfo ti = {
>           .name = typename,
> -        .parent = TYPE_MIPS_CPU,
> +        .parent = def->insn_flags & CPU_MIPS64
> +                  ? TYPE_MIPS64_CPU : TYPE_MIPS32_CPU,
>           .class_init = mips_cpu_cpudef_class_init,
>           .class_data = (void *)def,
>       };

Oops, I got 2 commits squashed by mistake here...

> diff --git a/target/mips/sysemu/mips-qmp-cmds.c b/target/mips/sysemu/mips-qmp-cmds.c
> index 7340ac70ba..329db3a028 100644
> --- a/target/mips/sysemu/mips-qmp-cmds.c
> +++ b/target/mips/sysemu/mips-qmp-cmds.c
> @@ -8,31 +8,9 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/qapi-commands-machine-target.h"
> -#include "cpu.h"
> -
> -static void mips_cpu_add_definition(gpointer data, gpointer user_data)
> -{
> -    ObjectClass *oc = data;
> -    CpuDefinitionInfoList **cpu_list = user_data;
> -    CpuDefinitionInfo *info;
> -    const char *typename;
> -
> -    typename = object_class_get_name(oc);
> -    info = g_malloc0(sizeof(*info));
> -    info->name = cpu_model_from_type(typename);
> -    info->q_typename = g_strdup(typename);
> -
> -    QAPI_LIST_PREPEND(*cpu_list, info);
> -}
> +#include "qapi/commands-target-compat.h"
>   
>   CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
>   {
> -    CpuDefinitionInfoList *cpu_list = NULL;
> -    GSList *list;
> -
> -    list = object_class_get_list(TYPE_MIPS_CPU, false);
> -    g_slist_foreach(list, mips_cpu_add_definition, &cpu_list);
> -    g_slist_free(list);
> -
> -    return cpu_list;
> +    return generic_query_cpu_definitions(errp);
>   }


