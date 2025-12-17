Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CF7D65C5F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 15:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVtDK-000387-8T; Wed, 17 Dec 2025 10:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVtDJ-00037y-5M
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 10:13:17 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVtDH-00086Q-2F
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 10:13:16 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so64537915e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 07:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765984393; x=1766589193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8/lahAcrKIrw99hhd3KFnPKEUndDKedBetmK0ztvpZQ=;
 b=vAgFxjeq83710vbT2CZp0PHLfpYvPtWbHPFwMcnlT3og1Hpkf0HLBMyEVJ4kqsb2Mi
 gZAyHTTDV0MMxnZwDuiGDs/LDt/Esr66eTdiqGs906B38FaTCC5+JrBUWxo1AtS4dh3h
 Pu+WXet3IziSTeBSV4H8a0rY31+SD3IypwSy6wnMBXu7R58bUXyn62OgPkTjRKVBla2p
 tAVHVw6sCHp9g10EqxuahFVogOoJNM+CQWyzUfFSsIPbgbUJcX0shISr2QNC+TkjljAo
 ozxL4cObTdALOtSmvlcBJpJZf8LmNyb6MwD4B715ssNAuObcX/vjcNfOZTdw0syvBdDx
 pegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765984393; x=1766589193;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8/lahAcrKIrw99hhd3KFnPKEUndDKedBetmK0ztvpZQ=;
 b=GnrvhTPYQtReRgx3lPVIaz8rVhgV2pmlaYINEZRwdtFk2rVbPasWI52BBSy5ReNB0P
 Nz2FeXRhMz9+X+RZlrpNfSJrb8QqIFKA5i5yYAx3CfuW97WDJWjKquqjZdzoLDykTond
 IPSvSgKrj9WxnYci679Q4kvQwXmrtzCraobfq+62boEO2ycoACno9/phZsZbpBmVIXLG
 O76hAK5TLwMyAhVGVxrP2T31JmKcS1sxI4FPlhAoRAUI1jmdlby1HRYv+lLz1eaj3SES
 KksONnpKXxDxUorA8z0duSh7zE/4MZVKJedWZbAFNsmBGxO45eqCDrI+joLKPTOg+B+T
 lMQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlTJTMLA+3NynIRslWLCKrXDJ1pcqf8WqL91W1xvWOp0pCld6FP2Dnd+KnFXTPnbvgHzS3YczlIXMs@nongnu.org
X-Gm-Message-State: AOJu0Yw9MS/ano/ykQywq7AMGdSonpmUGpZYL2UyOiO7WZewNW5OpUQM
 AcyxHSz8Mvck+dg3Ml/MLr8RxkZd8XGgtHL03qm+JUouZf9ell8hRLAbjZ3vzONKCWhLfSuYMjK
 f92u4YrB9LQ==
X-Gm-Gg: AY/fxX5ehLBbfzG5ifQAsEpAMgrtiYvKh8Nvd09rBRhhPAKNwhMCRS7wesVTmu2ZJ5g
 dfKTav+z1srbTUG+Bpler1cMwXy0V9BCf4alPQ0IvMPr2vtOtaEHmQotZUgvV2+zv8IFtw2R6XT
 onLDTI7tZzx/XLUVr/ar+NLarSNIKpbciHpsCNpCplKkN7JVFOCtYI4BfTZZ9nqWUXf9T8JIO41
 bykHhDTF11DPpzURk/u/PNynUrSeQb5IXBU8dFybm69IOiKidXlzh0ws2k98BY1YBZeHHnRR6U1
 lpk53KHmirjRZwigiO6DOxGbRj9BqxWYRMK1nKZfvzgNldf5t88ijpfcmP0JeEQJPnJ3MwigILi
 AWlF0uQtB4ZKgv85eL1WQpuQ/JifsrA+7V4bWftLgp/UsqO7MVEe7yfJHUiZ7IcjkdQiaT1P/9X
 AA4gwK52ZAX1Ie1gY0gIXHudKZK9jw7+W4ZnGGsfDt+eV/Ql1so0oijA==
X-Google-Smtp-Source: AGHT+IH70Y2orOmVZ2ouJTCX36PY4bhZgfmoK4L41aolCQaEIOwcKmHr/7MvdUxD9KZqdmACI9Tg0g==
X-Received: by 2002:a05:600c:4ed0:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-47a8f90ea5fmr216134695e9.30.1765984393150; 
 Wed, 17 Dec 2025 07:13:13 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4310ade8072sm5482464f8f.25.2025.12.17.07.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 07:13:12 -0800 (PST)
Message-ID: <b1c5fa3e-f716-46f0-9ce1-1bdb8af18076@linaro.org>
Date: Wed, 17 Dec 2025 16:13:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] hw/riscv: Define SiFive E/U CPUs using runtime
 conditions
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-13-d24a4048d3aa@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-13-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 17/12/25 00:51, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/hw/riscv/sifive_cpu.h | 26 +++++++++++++++++++-------
>   hw/riscv/sifive_e.c           |  2 +-
>   hw/riscv/sifive_u.c           |  4 ++--
>   3 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/riscv/sifive_cpu.h b/include/hw/riscv/sifive_cpu.h
> index 136799633a..8391141d5e 100644
> --- a/include/hw/riscv/sifive_cpu.h
> +++ b/include/hw/riscv/sifive_cpu.h
> @@ -20,12 +20,24 @@
>   #ifndef HW_SIFIVE_CPU_H
>   #define HW_SIFIVE_CPU_H
>   
> -#if defined(TARGET_RISCV32)
> -#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E31
> -#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U34
> -#elif defined(TARGET_RISCV64)
> -#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E51
> -#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U54
> -#endif
> +#include "qemu/target-info.h"
> +
> +static inline const char *sifive_e_cpu(void)
> +{
> +    if (target_riscv64()) {
> +        return TYPE_RISCV_CPU_SIFIVE_E51;
> +    } else {
> +        return TYPE_RISCV_CPU_SIFIVE_E31;
> +    }
> +}
> +
> +static inline const char *sifive_u_cpu(void)
> +{
> +    if (target_riscv64()) {
> +        return TYPE_RISCV_CPU_SIFIVE_U54;
> +    } else {
> +        return TYPE_RISCV_CPU_SIFIVE_U34;
> +    }
> +}
>   
>   #endif /* HW_SIFIVE_CPU_H */
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 7ed419cf69..458b21b9e3 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -151,7 +151,7 @@ static void sifive_e_machine_class_init(ObjectClass *oc, const void *data)
>       mc->desc = "RISC-V Board compatible with SiFive E SDK";
>       mc->init = sifive_e_machine_init;
>       mc->max_cpus = 1;
> -    mc->default_cpu_type = SIFIVE_E_CPU;
> +    mc->default_cpu_type = sifive_e_cpu();
>       mc->default_ram_id = "riscv.sifive.e.ram";
>       mc->default_ram_size = sifive_e_memmap[SIFIVE_E_DEV_DTIM].size;
>   
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 2ff2059bb9..a04481806e 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -723,7 +723,7 @@ static void sifive_u_machine_class_init(ObjectClass *oc, const void *data)
>       mc->init = sifive_u_machine_init;
>       mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
>       mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
> -    mc->default_cpu_type = SIFIVE_U_CPU;
> +    mc->default_cpu_type = sifive_u_cpu();
>       mc->default_cpus = mc->min_cpus;
>       mc->default_ram_id = "riscv.sifive.u.ram";
>       mc->auto_create_sdcard = true;
> @@ -764,7 +764,7 @@ static void sifive_u_soc_instance_init(Object *obj)
>                               TYPE_RISCV_HART_ARRAY);
>       qdev_prop_set_uint32(DEVICE(&s->e_cpus), "num-harts", 1);
>       qdev_prop_set_uint32(DEVICE(&s->e_cpus), "hartid-base", 0);
> -    qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", SIFIVE_E_CPU);
> +    qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", sifive_e_cpu());
>       qdev_prop_set_uint64(DEVICE(&s->e_cpus), "resetvec", 0x1004);
>   
>       object_initialize_child(obj, "u-cluster", &s->u_cluster, TYPE_CPU_CLUSTER);
> 

Just inline and remove the header. With that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


