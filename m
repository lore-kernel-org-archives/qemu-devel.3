Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF8BCDE03D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 21:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stwRs-0002CW-ER; Thu, 26 Sep 2024 17:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1stwRq-00029l-1d
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 17:54:54 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1stwRo-00041e-6h
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 17:54:53 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2068bee21d8so15753335ad.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 14:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727387689; x=1727992489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QDhMwVp4WPp75qDkVYZW8GjhKxnmHDCQVmLs6bLp9g0=;
 b=cKlfVD8g7tbtDgZQkM3HIiqGjpjc8NjXSx3KgKljO5FYKVhoenS69btLFe1XuhqAzF
 qmDB1nsmEQypTgTe1OyCRImTBtKAlRpUxyrK7Yp+whWfFN66vBMMejcBiBOhmtS3VqML
 tGfyo8NWBqFeSPlkZhdtxLHVbCNxju7y9KdwkWAQLYapeCGoNBLN7hpAn5/NwNBTCkwo
 3bimCYBzif4v4E2AFxaQjsI8VcBOE6548dPgyXj1EM9sSIo7uLZ4Wl8DdU5MRKNwJNwV
 xKU3bVjqdhx5iXLjNMQB5SmJlo8oXliDds8n8LYK4QRYr6PtPDApA+ercE/WMVFy4+gd
 PJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727387689; x=1727992489;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QDhMwVp4WPp75qDkVYZW8GjhKxnmHDCQVmLs6bLp9g0=;
 b=e3hg4W+5v9tKJnhjBkmy45U/m98T3vDoxfCfwnj4fj2oDKe0GNi49T2hWYwCOrglKA
 939m4nY82+zHoFRkGaZLv0XsTyB9CDZs9HNTyHlA6FvUXPB4MTAtH82FHoRwov7hEX1B
 9rUuZVhCF0wMBts/M9RaT2X998w3yGn8oAhxISZbl+hkn318MMFNPZwOo5iyG4pBvCvu
 qemExjC14oM9opLOaYvv9BIPO+pelHv/MEZHxoviH249xYCQYvUj2pJ4tjSFvDZLFp6C
 0EkEqgv++78bHaMr6fvdOp+tf9hWoyMC6ULjlTV1Zz/GbonRXCZ+ogGB4uGHK0GyiEtJ
 2BWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy0kmvQR/gQEUJvQDNS01FdjjyjpFRI0liW9OQn6gFHkCwnkk7Kc81aXCzeC/GYzbMqJ+NBPhvCsjz@nongnu.org
X-Gm-Message-State: AOJu0YzzOsww+5JiOPz3sv4bg8PAEXLInXJh4Of/wN2sQQcoYywMd6Kg
 pjf8xQkpYbUeCCZxcaz4wSHqAP/aahqevQGBLTQN3oyHmd7jH7Md99/HFRdYs2k=
X-Google-Smtp-Source: AGHT+IEK+hcxyOKXxBOxHtYwZ1QXIoej7AGmEQioCQXxwyq12I5N2oYkM+f2WmxsbTaCFO2mvvCLRQ==
X-Received: by 2002:a17:902:d490:b0:200:abb6:4daf with SMTP id
 d9443c01a7336-20b37b7b72amr16412175ad.39.1727387689618; 
 Thu, 26 Sep 2024 14:54:49 -0700 (PDT)
Received: from [192.168.68.110] ([187.101.184.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e4dbc0sm2819305ad.243.2024.09.26.14.54.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 14:54:49 -0700 (PDT)
Message-ID: <230d58bc-6c92-4ee3-a28c-e2f0c93a819b@ventanamicro.com>
Date: Thu, 26 Sep 2024 18:54:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] target/riscv: Add max32 CPU for RV64 QEMU
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240919055048.562-1-zhiwei_liu@linux.alibaba.com>
 <20240919055048.562-8-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240919055048.562-8-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 9/19/24 2:50 AM, LIU Zhiwei wrote:
> We may need 32-bit max for RV64 QEMU. Thus we add these two CPUs
> for RV64 QEMU.
> 
> The reason we don't expose them to RV32 QEMU is that we already have
> max cpu with the same configuration. Another reason is that we want
> to follow the RISC-V custom where addw instruction doesn't exist in
> RV32 CPU.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu-qom.h |  1 +
>   target/riscv/cpu.c     | 12 +++++++-----
>   2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 4464c0fd7a..62115375cd 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -30,6 +30,7 @@
>   #define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)
>   
>   #define TYPE_RISCV_CPU_MAX              RISCV_CPU_TYPE_NAME("max")
> +#define TYPE_RISCV_CPU_MAX32            RISCV_CPU_TYPE_NAME("max32")
>   #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
>   #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
>   #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 86ce15252a..baf8fba467 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -448,11 +448,9 @@ static void riscv_max_cpu_init(Object *obj)
>   
>       env->priv_ver = PRIV_VERSION_LATEST;
>   #ifndef CONFIG_USER_ONLY
> -#ifdef TARGET_RISCV32
> -    set_satp_mode_max_supported(cpu, VM_1_10_SV32);
> -#else
> -    set_satp_mode_max_supported(cpu, VM_1_10_SV57);
> -#endif
> +    set_satp_mode_max_supported(RISCV_CPU(obj),
> +        riscv_cpu_mxl(&RISCV_CPU(obj)->env) == MXL_RV32 ?
> +        VM_1_10_SV32 : VM_1_10_SV57);
>   #endif
>   }
>   
> @@ -2945,6 +2943,10 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>       DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32E,        MXL_RV32,  rv32e_bare_cpu_init),
>   #endif
>   
> +#if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
> +    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX32,     MXL_RV32,  riscv_max_cpu_init),
> +#endif
> +
>   #if defined(TARGET_RISCV64)
>       DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cpu_init),
>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),

