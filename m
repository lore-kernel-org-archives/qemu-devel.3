Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A26C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 10:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUpN-0005qs-NU; Mon, 26 May 2025 06:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uJUpL-0005qG-M4
 for qemu-devel@nongnu.org; Mon, 26 May 2025 06:13:03 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uJUpJ-0001Eb-SQ
 for qemu-devel@nongnu.org; Mon, 26 May 2025 06:13:03 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-528ce9731dbso404139e0c.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748254380; x=1748859180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZF4WH1L926HBZQvALbKypa7jXOpWVLWvgKJeNMDiD+Q=;
 b=bz+IDjGaOjTaAh4dzTnKRPtAl+qPAt+sp4eLe4vk71iE5CW14XCl7ahl8/We0h763A
 ErAfWjSqp6N/NaZIX8JfXMjoQawbMxbU5FgN9epl3WmhfqlSjJbjJWTpG5jQytmdJAOC
 zWH5PzNH4Beop862khVW8080tE8YkNQG89hJTP5dOtCqzVw80sJavcC3lYBnwt4YLKZF
 3Z7Zorvf82ncBgBtZAazEa3SoWWQaBTLkxTiZkPgGZq75lVthKBdHuThpce/BnCmgfNk
 b5MjT5N0J7OJfLP4s8xsuVlx5UYvm2ypJ8y+M1gtqlCeyw6Bg0ifBQcxS5sOFkmGb39Z
 vu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254380; x=1748859180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZF4WH1L926HBZQvALbKypa7jXOpWVLWvgKJeNMDiD+Q=;
 b=uBCPCyKahGsMXLk/QixptsUz9en8C5Z6tkUlxPyARubEX7+CMAzBjrCDTtatoHrP4D
 2M9TPpWGo+Sn5FNZyo2ACTc/sGAdM4EV6FjbAZFPASMhuRBzeZvY81S9hPHTG0h7ItSi
 0a6h6os7/xltC04MyVgcxDc4wOyl3QXnzZBxMZxvaq7FsDQoZjTZhn7/JtFpJs/Xgyr5
 w19i6NRnN8a4+GRT9LESRFoXyprRkl4n/4Zn+K3XdMDJvvbWp3ZnfaPtaIgJp9BUZyVB
 J+5ou8ejx4N/qmQIvbQJKXfN1BNggZdIH5VCyHkNEVo94bL6MMMB+ln/yZqTpXfauGur
 3Gcg==
X-Gm-Message-State: AOJu0Ywd+xVuUGSNCAKP8CzKpoCee5Gc32I+sViIi94+8+jqcrHcyjbT
 JxDQeyEIOS2kVtI/bwt1qDQW0KA8HulbA8YhTKQ3yyIf245TsoSrDXXzH3R4dmHwvrA=
X-Gm-Gg: ASbGnctxiYQn8ghu5kVmouJAD5DH73EHi9dJg2h2FTD02P5GXinwxUqVfYH5MgeR5a0
 BsSF2CK9L3oExQILE7uvBqWeUM8PlmDKjkUvJT7QRs773aBT1QxLdzgNvgshRosQtdU+uWSIc0w
 9k32thWdP5IT9143eUdBn5+HI+ZJeVeBejsdxUgt/EMaN1xhTMlHltmixzoW2TXsXe2I3d+rU3h
 kqNSFmMsdrudYt+rs7Jn42MwsVPoyTanqCyFgB2ePBSUAqAKGZnMsx2kudKopR/auTzvsrckcap
 O1vxlyH3I5NbQH5/VjeelXbJTEVYwCS81LH8xmmtwnfqpkBTkKCfxZ+BDyAHb6F6dA==
X-Google-Smtp-Source: AGHT+IGQH78t9mPwnKoomMddqi+VDN9ipN8vu5OwLS8xHR0BWblFIWoDAbH1hN/6J01abSfJmFokZA==
X-Received: by 2002:a05:6122:a23:b0:520:3536:feb5 with SMTP id
 71dfb90a1353d-52f2c5ab85emr5908390e0c.11.1748254380502; 
 Mon, 26 May 2025 03:13:00 -0700 (PDT)
Received: from [192.168.68.110] ([191.255.35.190])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52dba910d62sm17330183e0c.10.2025.05.26.03.12.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 03:13:00 -0700 (PDT)
Message-ID: <1223c068-062c-44f9-91b4-d9a456556b29@ventanamicro.com>
Date: Mon, 26 May 2025 07:12:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/riscv: add cva6 cpu type
To: Ben Dooks <ben.dooks@codethink.co.uk>, nazar.kazakov@codethink.co.uk,
 joseph.baker@codethink.co.uk, fran.redondo@codethink.co.uk,
 lawrence.hunter@codethink.co.uk, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250521155458.24255-1-ben.dooks@codethink.co.uk>
 <20250521155458.24255-3-ben.dooks@codethink.co.uk>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250521155458.24255-3-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vk1-xa36.google.com
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



On 5/21/25 12:54 PM, Ben Dooks wrote:
> Add CVA6 CPU type, for the OpenHW CVA6 cores
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---

The patch LGTM but I'm afraid you'll have to rebase it with the current
master: we changed how CPUs are declared after the RISCVCPUDef changes
landed.


Thanks,

Daniel

>   target/riscv/cpu-qom.h |  1 +
>   target/riscv/cpu.c     | 19 +++++++++++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 4cfdb74891..b5460771d7 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -34,6 +34,7 @@
>   #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
>   #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
>   #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
> +#define TYPE_RISCV_CPU_CVA6             RISCV_CPU_TYPE_NAME("cva6")
>   #define TYPE_RISCV_CPU_RV32I            RISCV_CPU_TYPE_NAME("rv32i")
>   #define TYPE_RISCV_CPU_RV32E            RISCV_CPU_TYPE_NAME("rv32e")
>   #define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d92874baa0..0ad6a7b616 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -496,6 +496,24 @@ static void rv64_base_cpu_init(Object *obj)
>   #endif
>   }
>   
> +static void rv64_cva6_cpu_init(Object *obj)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +    CPURISCVState *env = &cpu->env;
> +
> +    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVS | RVU);
> +    env->priv_ver = PRIV_VERSION_1_12_0;
> +#ifndef CONFIG_USER_ONLY
> +    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV39);
> +#endif
> +
> +    /* inherited from parent obj via riscv_cpu_init() */
> +    cpu->cfg.ext_zifencei = true;
> +    cpu->cfg.ext_zicsr = true;
> +    cpu->cfg.mmu = true;
> +    cpu->cfg.pmp = true;
> +}
> +
>   static void rv64_sifive_u_cpu_init(Object *obj)
>   {
>       RISCVCPU *cpu = RISCV_CPU(obj);
> @@ -3247,6 +3265,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>   
>   #if defined(TARGET_RISCV64)
>       DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cpu_init),
> +    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_CVA6,       MXL_RV64,  rv64_cva6_cpu_init),
>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),
>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),


