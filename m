Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A060EC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 21:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBghp-0002IK-96; Sun, 04 May 2025 17:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBgho-0002IB-E7
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:17:00 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBghm-0000WQ-Q8
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:17:00 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so3470277a91.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746393416; x=1746998216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FpIFs1seEd6wWhy0wSnACTWHDXJwWjaJJ7/amBuWMOk=;
 b=pLPBB1njaXtHuXOp2WBL/laR/tXq7pKHXybR0awpTvI88SV98+C7Gp+l1Ohxo8Xk4X
 O1FHl9NLnn6WCvJWTyXhPHt772GrDiIlMD20cWzxt2otNXxQ8IDQ6Q0re1Z1NwIinLLr
 x/gJVIaOKklOqTt2SBQ+/rHdgG8+13kW8WOY9OhrinRr2zdaly2FaljAcAwnzCnPHuNC
 ZpSVFBNJxjJlToUfIMy8C5YMyrM4Zr7rI9xDuCQo6moECwAbO3HZX9laB+c9KTCaCqtA
 SDe7VQkekogXPKsGeoAJYaEZPy24eg4S36kSRHjASbpbuFN/eiGb2ytQnQAKU022WZbX
 drCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746393416; x=1746998216;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FpIFs1seEd6wWhy0wSnACTWHDXJwWjaJJ7/amBuWMOk=;
 b=LiM7rte8JnFH1vRMt+cqXgenbdYDV/Fr/pXUhxO+aoyWPrSsyxNE5ApbGCNDvi0ghz
 0OxmSRZkhjq5zuHf3Yv8T3WdvSpAagM+GID4Oxcxl8XeoOxV99WeZgi/XG9s+4icTF16
 GrA6KxRxMi3fJMakGZBGRVY8kb3JT/cNZx8nlN42Pcx/fj0qJjel2/GmTvV2ElZRNWPg
 /6FU4K7mfSaWsWpX4axFbviiXJsrQj7Tpj2uoTaFdQBpV0OO0kYlFRnKshkpnSgK2Fr2
 Zx0GJcdkuBBeNMPaXt3RUUHACrdNXdvhU0BB5zsmPvmBPfce21UAsfGuT6dNUZUXihxZ
 YqFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC1hNk78zpXJrYwO/45+rB8RhGQRZItqn+yUy3zVV5UsHJA1EPwZJQuwb8ev4BTK0C9Z47Ws8i0WWH@nongnu.org
X-Gm-Message-State: AOJu0YzClV6RYN6OQGpnmgyqhnU4EdvBQ5AKZR+jEjJfTlQPOQqPEF3e
 qYpEiT/iN7HIWp5r//Z6KQTjsanlgKeRNAEna07q459mWNbNQS+U6McbRxTs/Mk=
X-Gm-Gg: ASbGnctIyH8nD7BxIUyRxrQdbswIX8ZWjJrJAR4epsmrQlORYflusTykmUydM6gv3/U
 w567F4u+OPZ7v/0ayMgQdrFH70zrzNQxqvp5dYAkKxq1Nt851ZXOhe4lmUcq0BrOeVZQhv2sNt3
 J1bykHWVnqUR01ZFFC9DH9sjUm85U5DiudeIqXeJZsoptvMCe867BqbHZo3zKbGBj1fOeiP7RDo
 X6tqXLU+ButenWmvAJ9xsWP1wSvG4fjfg/QeHicfjt9bzfjV0aKRbJ97sNmuDfp99J+e1H7Cpdg
 fJ+UeaJLGsg+6xgBqoKimfgjLA7XAvBU1BXVrQGqgQtXIcIfl6raHg==
X-Google-Smtp-Source: AGHT+IHKYuupeiJWlKsPWKyYmBkKhyEAWCYh/Bkf/CdX6JME0zGrDCg19809CLtzzNhhAT15OK4GUw==
X-Received: by 2002:a17:90b:4c84:b0:2ee:b875:6d30 with SMTP id
 98e67ed59e1d1-30a6197c311mr8390788a91.9.1746393416030; 
 Sun, 04 May 2025 14:16:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a3471ee73sm9959521a91.3.2025.05.04.14.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 14:16:55 -0700 (PDT)
Message-ID: <c917a18e-a764-4387-b220-b11f793136c7@linaro.org>
Date: Sun, 4 May 2025 14:16:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] qemu/target-info: Factor target_system_arch() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20250502214551.80401-1-philmd@linaro.org>
 <20250502214551.80401-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20250502214551.80401-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

On 5/2/25 2:45 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/target-info.h |  9 +++++++++
>   hw/core/machine-qmp-cmds.c |  6 ++----
>   target-info.c              | 12 ++++++++++++
>   3 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index 850a2958b9c..87b4b0e0cbb 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -9,6 +9,8 @@
>   #ifndef QEMU_TARGET_INFO_H
>   #define QEMU_TARGET_INFO_H
>   
> +#include "qapi/qapi-types-machine.h"
> +
>   /**
>    * target_name:
>    *
> @@ -16,6 +18,13 @@
>    */
>   const char *target_name(void);
>   
> +/**
> + * target_system_arch:
> + *
> + * Returns: QAPI SysEmuTarget enum (i.e. SYS_EMU_TARGET_I386).
> + */
> +SysEmuTarget target_system_arch(void);
> +
>   /**
>    * target_long_bits:
>    *
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index d82043e1c68..8f491dba441 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -37,8 +37,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
>       MachineState *ms = MACHINE(qdev_get_machine());
>       MachineClass *mc = MACHINE_GET_CLASS(ms);
>       CpuInfoFastList *head = NULL, **tail = &head;
> -    SysEmuTarget target = qapi_enum_parse(&SysEmuTarget_lookup, target_name(),
> -                                          -1, &error_abort);
> +    SysEmuTarget target = target_system_arch();
>       CPUState *cpu;
>   
>       CPU_FOREACH(cpu) {
> @@ -139,8 +138,7 @@ QemuTargetInfo *qmp_query_target(Error **errp)
>   {
>       QemuTargetInfo *info = g_malloc0(sizeof(*info));
>   
> -    info->arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
> -                                 &error_abort);
> +    info->arch = target_system_arch();
>   
>       return info;
>   }
> diff --git a/target-info.c b/target-info.c
> index 16fdca7aaaf..8232d488870 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -9,6 +9,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/target-info.h"
>   #include "qemu/target-info-impl.h"
> +#include "qapi/error.h"
>   
>   const char *target_name(void)
>   {
> @@ -20,6 +21,17 @@ unsigned target_long_bits(void)
>       return target_info()->long_bits;
>   }
>   
> +SysEmuTarget target_system_arch(void)
> +{
> +    static SysEmuTarget system_arch = SYS_EMU_TARGET__MAX;
> +

It would be better to squash next commit, and modify 
target_info()->target_arch directly, instead of introducing this static 
variable.

> +    if (system_arch == SYS_EMU_TARGET__MAX) {
> +        system_arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
> +                                      &error_abort);
> +    }
> +    return system_arch;
> +}
> +
>   const char *target_cpu_type(void)
>   {
>       return target_info()->cpu_type;


