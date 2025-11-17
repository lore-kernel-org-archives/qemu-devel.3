Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CE5CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL3Ub-0000Yl-1i; Mon, 17 Nov 2025 12:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vL3U2-0008MN-Nd
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:57:49 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vL3Ty-0007M0-RB
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:57:45 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-450b90e6bcbso222610b6e.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 09:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763402260; x=1764007060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=psiYa7+6mddVnP5SlGVSIu1eWh5vsyL2fgOE804Kq7k=;
 b=cgGHk+MVVhW5xuvUeMd61eZJ6JQpek8K7Ol2tHMA4chS1eYUx6YWfMNLEH3ePJ+w3D
 ls52fF9cPlGO1Lch5h9fkaCnMNd0hh7+9utq56u9DCHeOBeJYai0aM6fGorFgf1d6yxO
 OMblcMRibiT83gFYD+jug65RM/o65/4xuOI4apnLoEy0AAZEljbDQ/dWYcUVk5YwdUxP
 2ZMK/JRsUnoIot4JrsfGxeS5QqmMuMmevDekTUMIXwYf7KugvpIA/ezi4VvzTvAcwOGO
 vTHA9Zk35gbnBme9JzXA9TMbLzVHweou3BwQezBzGHR/6IX8MKBIQ1RgzSdZqVQmOmof
 aikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763402260; x=1764007060;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=psiYa7+6mddVnP5SlGVSIu1eWh5vsyL2fgOE804Kq7k=;
 b=C+A4DPBWyZYDdo/0JCm+8cOLjIJ2thOB4sZAbqb96P6xFKh4LwHdEbAiAL0ElOgzGZ
 aOr+M4DrJ0kCasl0MUWHR0scBK8ahe5R2QkV5tbGtwzW1zqtEK/MFnbQX+BOSOHK5V46
 76cytaBgioXJicLT6X6QRiIU3WXi+jvfcRyKeJTCbeyCSHTOR8Kl20/uXN0kK0YqNETK
 u14gonI+RRBQXn/QfcBkOVJlvqDdN5R8saN0omlcMUJfCWRZJ1aGz1+WKod8sieymVEH
 GROSZ5FE+wPR5FGo96nY7JXCe6dBRZTkjPbVqIHxgqLy7flNurFMRkLNvs89UoFEkaf3
 lHeg==
X-Gm-Message-State: AOJu0YwLQL7eSYbcvCwqJ1mgIFJzTNZHBOZWJb7QJYBxOlvINBS9n2Z8
 LK/M1jZdvQXDNttlomHT4YNodjSARvl2Y4EkeKYlfzdon3P4tGcqULfWkypAijcZ0pk=
X-Gm-Gg: ASbGncv+GpW7t0sKYaZ7fXAgFp7PmSf0/FuGqwfC4XDrGm5NJrZkrWUP+DQRx4+AP3f
 UhalWaABi5SJvre05Q476ifw66A8HJwZqe9zFNMSOYXtL2Kj1yjuM8qFrlKYF3wfGxC5rj81dFT
 c7vtyV098Y+lyOMx/NdQx6tkg/ETT3VEWEXKs//gCGtwdszVXIhEK6ZP6ceXxT2lF7eVhd9eLQK
 ZYuiaP0V/2KD6CVoM+DNIS6pkhw3wBRSpJrYnUgKBxf9YJRjhggCSlZx+AsBs7HHVU4ld4YrYh3
 KfVyHWBCpq7xjlJmzo1CGaZ+J4zSmeJh9syg7dzWHlzmwg93Wf4pYJYFjgyrWoULOC6WMVwj1bo
 zMPCq0f7pD2ZIRr7i6pJdWOCk98wVAw8SWI/nSesGht0ODd9n2eGFFbKhpEW2uErntUXIFxPvtZ
 CrG37WQW4jH5nqa45LVxcTd/oRPw==
X-Google-Smtp-Source: AGHT+IF+FMq1MfRS0GbQ9jOrjYjM1IxXTECP0pk336zuSYpBTZCHboklw/Md3qN0iQB5n9yhDf0jFg==
X-Received: by 2002:a05:6808:2444:b0:450:c49f:9a38 with SMTP id
 5614622812f47-450c49fa214mr2393165b6e.17.1763402260450; 
 Mon, 17 Nov 2025 09:57:40 -0800 (PST)
Received: from [192.168.68.110] ([191.202.237.26])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a531221sm4411650b6e.1.2025.11.17.09.57.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 09:57:39 -0800 (PST)
Message-ID: <ff6a9d8f-9d8e-46f2-90e8-a04b10bb21bc@ventanamicro.com>
Date: Mon, 17 Nov 2025 14:57:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] target/riscv: Add server platform reference cpu
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Fei Wu <wu.fei9@sanechips.com.cn>
References: <20251111182944.2895892-1-dbarboza@ventanamicro.com>
 <20251111182944.2895892-3-dbarboza@ventanamicro.com>
 <20251111-e4f4062f326aef78ef820d00@orel>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251111-e4f4062f326aef78ef820d00@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22c.google.com
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



On 11/11/25 8:05 PM, Andrew Jones wrote:
> On Tue, Nov 11, 2025 at 03:29:41PM -0300, Daniel Henrique Barboza wrote:
>> From: Fei Wu <wu.fei9@sanechips.com.cn>
>>
>> The harts requirements of RISC-V server platform [1] require RVA23 ISA
>> profile support, plus Sv48, Svadu, H, Sscofmpf etc.
>>
>> This patch provides a CPU type (rvsp-ref) to go along with the rvsp-ref
>> board.
>>
>> [1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
>>
>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu-qom.h |  1 +
>>   target/riscv/cpu.c     | 14 ++++++++++++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>> index 75f4e43408..07e96a14ba 100644
>> --- a/target/riscv/cpu-qom.h
>> +++ b/target/riscv/cpu-qom.h
>> @@ -42,6 +42,7 @@
>>   #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
>>   #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>>   #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
>> +#define TYPE_RISCV_CPU_RVSP_REF         RISCV_CPU_TYPE_NAME("rvsp-ref")
>>   #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>>   #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>>   #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 975f7953e1..3ddb249970 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -3305,6 +3305,20 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>           .cfg.max_satp_mode = VM_1_10_SV48,
>>       ),
>>   
>> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSP_REF, TYPE_RISCV_BARE_CPU,
>> +        .misa_mxl_max = MXL_RV64,
>> +        .profile = &RVA23S64,
>> +
>> +        /*
>> +         * ISA extensions
>> +         * NOTE: we're missing 'sdext'.
>> +         */
>> +        .cfg.ext_zkr = true,
>> +        .cfg.ext_svadu = true,
> 
> Svadu is no longer required.
> 
>> +
>> +        .cfg.max_satp_mode = VM_1_10_SV57,
> 
> Shouldn't this be SV48 and then allow instantiations to use
> rvsp-ref,sv57=on.

Makes sense.

> 
> We also need Ssccfg and Sdtrig.

Sdtrig is enabled by default, and somehow I forgot to add ssccfg. I'll add it.


Thanks,

Daniel

> 
>> +    ),
>> +
>>   #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>>           .cfg.max_satp_mode = VM_1_10_SV57,
>> -- 
>> 2.51.1
>>
>>
> 
> Thanks,
> drew


