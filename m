Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F2BC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 11:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWwqc-0005jG-UY; Thu, 25 Jul 2024 07:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sWwqb-0005im-6D
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:41:25 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sWwqZ-0001aj-7n
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:41:24 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7a263f6439eso501510a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721907681; x=1722512481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4BjiPeeHBWLhSj4uJU2ToVH3O0/femhQQB0EUVqahOo=;
 b=SGswuBpF6BGf4ZnBxdDhQ1aEyy7+GUh023IGRbNhT/MoMXQHLbXjIlFxiiol+ckEKk
 ltN619HsLaqIXR+LMNQy9NuxYlW5VB5mre+oStbllsm0oradY8HcTO+kReWWMJ5LstQ2
 bVergTru58bhRiMbLvDHUdXo1h1JD1TgANY09jmhtTFRNQN5hB4JbN8bVGjF+0WSREq3
 i/CdHONUNslf6fSyzlZglBVxki7u+9FbM8mI03O1PoOFmJwjd99qGGyNw/yNBzh28iPv
 ZH4Ae0IhOE5LtXGUNaxuXxmQPdCZNN0smLRbeXYKnydVaBD2zLx76h32fZeCZ3Rpqjnl
 GPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721907681; x=1722512481;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4BjiPeeHBWLhSj4uJU2ToVH3O0/femhQQB0EUVqahOo=;
 b=KDKrbETPJu/Z8rIiB8nci58E4eX4BvI68TZeX80a/pjLlMVtyu1/OOHUVX16s+7EGb
 DdfKV+c4vjt1O4OfzQ667FZZmLszAUnx4SpmwhLpZTFY1eaZaLHUcQhvpyW7B2K0B8uz
 8rCgl/ovkMZLuYL8B7voiAsOzIPvcNERxPEs6vl4jZXY8DeeXLKYJuHTGv+r+xGPnpej
 VtuKdfo4JP7lCt6IUz5rYjiT7INqf6KWbV99OBIke5LVBAi3+EOq7YisG7pmcOfIrzU7
 UeGzYvyeIY8SYrS9m3KdvA3Afb70T0cyrPaXrm1KPhsMJQ8YkFzJFvQ7IgsiBDwAsbGl
 dewA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQNQ1sYK2X3IqTHFCDX4vylfhYrV/OUHGUY/Tc8o5dmC5Hr8rB/rh/JU0rzbYyBAS6Fs8b28QwV7ot3b9YW0hJlClbUEQ=
X-Gm-Message-State: AOJu0YyaHya9g4pBOAcJ46AxfQxezYy4xffJBTHL5Mm+TkS5v4Wg7u21
 u9DvYPEBh+l9tmZaJv1jLig2Cl2D7TlYZEgJN83ygDcmqDGvhBj8mDNWw5MbSaQ=
X-Google-Smtp-Source: AGHT+IFb5FsvM9EEWWw2n+gVgpg7QtSUNe0zmpOlNbHfhFgLdLEtJb0LC9/EbeNfi94XmCdBURdELw==
X-Received: by 2002:a05:6a20:a11a:b0:1c2:905c:db0 with SMTP id
 adf61e73a8af0-1c47b4aef68mr1670792637.33.1721907681468; 
 Thu, 25 Jul 2024 04:41:21 -0700 (PDT)
Received: from [192.168.68.110] ([179.193.8.144])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7c8c6f4sm12146155ad.24.2024.07.25.04.41.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 04:41:21 -0700 (PDT)
Message-ID: <565a0b5c-bf9b-4ae0-8332-14c2e986604d@ventanamicro.com>
Date: Thu, 25 Jul 2024 08:41:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] target/riscv: Remove the deprecated 'any' CPU type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, devel@lists.libvirt.org,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20240724130717.95629-1-philmd@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240724130717.95629-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x536.google.com
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



On 7/24/24 10:07 AM, Philippe Mathieu-Daudé wrote:
> The 'any' CPU is deprecated since commit f57d5f8004b
> ("target/riscv: deprecate the 'any' CPU type"). Users
> are better off using the default CPUs or the 'max' CPU.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/about/deprecated.rst       | 13 -------------
>   docs/about/removed-features.rst |  8 ++++++++
>   target/riscv/cpu-qom.h          |  1 -
>   target/riscv/cpu.c              | 28 ----------------------------
>   4 files changed, 8 insertions(+), 42 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 88f0f037865..0ac49b15b44 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -347,19 +347,6 @@ QEMU's ``vhost`` feature, which would eliminate the high latency costs under
>   which the 9p ``proxy`` backend currently suffers. However as of to date nobody
>   has indicated plans for such kind of reimplementation unfortunately.
>   
> -RISC-V 'any' CPU type ``-cpu any`` (since 8.2)
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -The 'any' CPU type was introduced back in 2018 and has been around since the
> -initial RISC-V QEMU port. Its usage has always been unclear: users don't know
> -what to expect from a CPU called 'any', and in fact the CPU does not do anything
> -special that isn't already done by the default CPUs rv32/rv64.
> -
> -After the introduction of the 'max' CPU type, RISC-V now has a good coverage
> -of generic CPUs: rv32 and rv64 as default CPUs and 'max' as a feature complete
> -CPU for both 32 and 64 bit builds. Users are then discouraged to use the 'any'
> -CPU type starting in 8.2.
> -
>   RISC-V CPU properties which start with capital 'Z' (since 8.2)
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index fc7b28e6373..f3e9474a73e 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -850,6 +850,14 @@ The RISC-V no MMU cpus have been removed. The two CPUs: ``rv32imacu-nommu`` and
>   ``rv64imacu-nommu`` can no longer be used. Instead the MMU status can be specified
>   via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
>   
> +RISC-V 'any' CPU type ``-cpu any`` (removed in 9.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''

With the '9.1' changed to '9.2':

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> +
> +The 'any' CPU type was introduced back in 2018 and was around since the
> +initial RISC-V QEMU port. Its usage was always been unclear: users don't know
> +what to expect from a CPU called 'any', and in fact the CPU does not do anything
> +special that isn't already done by the default CPUs rv32/rv64.
> +
>   ``compat`` property of server class POWER CPUs (removed in 6.0)
>   '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>   
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 3670cfe6d9a..4464c0fd7a3 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -29,7 +29,6 @@
>   #define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
>   #define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)
>   
> -#define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
>   #define TYPE_RISCV_CPU_MAX              RISCV_CPU_TYPE_NAME("max")
>   #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
>   #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a90808a3bac..4bda754b013 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -438,27 +438,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
>   }
>   #endif
>   
> -static void riscv_any_cpu_init(Object *obj)
> -{
> -    RISCVCPU *cpu = RISCV_CPU(obj);
> -    CPURISCVState *env = &cpu->env;
> -    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVU);
> -
> -#ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(RISCV_CPU(obj),
> -        riscv_cpu_mxl(&RISCV_CPU(obj)->env) == MXL_RV32 ?
> -        VM_1_10_SV32 : VM_1_10_SV57);
> -#endif
> -
> -    env->priv_ver = PRIV_VERSION_LATEST;
> -
> -    /* inherited from parent obj via riscv_cpu_init() */
> -    cpu->cfg.ext_zifencei = true;
> -    cpu->cfg.ext_zicsr = true;
> -    cpu->cfg.mmu = true;
> -    cpu->cfg.pmp = true;
> -}
> -
>   static void riscv_max_cpu_init(Object *obj)
>   {
>       RISCVCPU *cpu = RISCV_CPU(obj);
> @@ -1161,11 +1140,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>       RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
>       Error *local_err = NULL;
>   
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_RISCV_CPU_ANY) != NULL) {
> -        warn_report("The 'any' CPU is deprecated and will be "
> -                    "removed in the future.");
> -    }
> -
>       cpu_exec_realizefn(cs, &local_err);
>       if (local_err != NULL) {
>           error_propagate(errp, local_err);
> @@ -2952,7 +2926,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .abstract = true,
>       },
>   #if defined(TARGET_RISCV32)
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,       MXL_RV32,  riscv_any_cpu_init),
>       DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cpu_init),
>       DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,    MXL_RV32,  rv32_base_cpu_init),
>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cpu_init),
> @@ -2962,7 +2935,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>       DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32I,        MXL_RV32,  rv32i_bare_cpu_init),
>       DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32E,        MXL_RV32,  rv32e_bare_cpu_init),
>   #elif defined(TARGET_RISCV64)
> -    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_ANY,       MXL_RV64,  riscv_any_cpu_init),
>       DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV64,  riscv_max_cpu_init),
>       DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cpu_init),
>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),

