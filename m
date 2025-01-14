Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E31E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 16:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXjO5-0006JH-OS; Tue, 14 Jan 2025 11:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXjO3-0006Ia-Ru
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:03:27 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXjO2-0001Ns-6G
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:03:27 -0500
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-71e3eb8d224so1488468a34.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 08:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736870604; x=1737475404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xeP/unzJ2ZQFkVxMp3AeBpniOWuig1h5j+IVaay2vVo=;
 b=jSM9AN8X/wFAvn0F7CXlFKUEpt7KH45flHYJxhSKab4I5a/sLZwPbmgWfgI14S3uc+
 JD3qnjtUO1rpkI7kCJQLbCFXsvUOQ5PJDB53Z+xvQPAadKY1UbL5eWh9OJ7gobqkXF+s
 H1dyqT7iNUvz+qSZBA1YRRJYyFgEgFd+/DOFIr76I95ydAFDADSL94aH7EilNnQWYwGG
 DK0bb0EVY0fiJU/fKaCAY7xym7FBg0lCiti6D81si6PCAYDTxggLtoKZtfopdppi1v58
 045eqK7jDhs+0zjp2JFYgkVyH4N+z5FYMe/JirPTrm0VnvpqUf4RqiPbZSGQUfD5ziuT
 J+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736870604; x=1737475404;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xeP/unzJ2ZQFkVxMp3AeBpniOWuig1h5j+IVaay2vVo=;
 b=AzLsKYDr6Dh5Eu+ezQlBjiaoVNMeUSCJWrBWsrXR7oD/M/T9wcmTuZlVCUQ2YQBZDo
 9T1I7+JU9kf6O+6/Dlxkks8hGGOEh0QFtQQQyRW8njRK4J7aL1j+u2XNdZV8EKR6XoxR
 Kt3JiYD4/SgLqjHo4tZHnsBMfnqGvaflYDxJWAh99dp+buAeuoiw0d+In3rzJGEzxL+6
 ZwdSxaI+oTrKrcjYxh4dwh3AYIZlfPA9LoDKxyVJqfaezFu3zIHXFaMclhszuGIUFha1
 dwdJtHme5MEudmuj761/qflv7OVIZywVECVMqxlNHqH6Q3+3+9l3EkEplHtuXwqq+Mvj
 UknA==
X-Gm-Message-State: AOJu0YxbkTlUwJbr54DSK/Mag735Ip6rlGKpqV9mNtEpGaT3MPygn/ek
 SuRuNu7OJfC/4Pe4XwwaK57WcZbPHyNrSLsx+9/ZCBIn9bYVVDySAMwe692HEg4=
X-Gm-Gg: ASbGncvNrWEYSD4R7GHz6xBpuVMvIO5uEvtmFYmk47SinrSYq94t7AlB/YDVy/Ys3J0
 sCLd2qYejg0KwKCFeLV78jLG6x/g3GAodZrOfr9bhegfWXnbwgKDtPNi5zd0naEp3iKeIs27tDX
 XM+mOQpd6n/VWrHRVNuxVOY1mexqghKzGBsqE+6BN9iRr+fyeuRX2tpQT/pTobCrh6G3VeCg/Md
 kdbf1zOTckevXSxgY5263eRoZtBe11jEmYvImCX5nAxfNbg29Us4OTvliGiu1AYcmsxstvm
X-Google-Smtp-Source: AGHT+IG/5oVBhugr3temWXTkDVxXaOYwF+RPXeSff8MoMFTTg/EWR3RKqa6rRS3pMePp7Epah6xqoQ==
X-Received: by 2002:a05:6830:3704:b0:71d:e89e:9af5 with SMTP id
 46e09a7af769-721e2e43209mr15755744a34.16.1736870604261; 
 Tue, 14 Jan 2025 08:03:24 -0800 (PST)
Received: from [192.168.68.110] ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7231855fd71sm4705542a34.42.2025.01.14.08.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 08:03:23 -0800 (PST)
Message-ID: <9da91b2b-0564-4dd1-8931-3a1982295a28@ventanamicro.com>
Date: Tue, 14 Jan 2025 13:03:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/riscv: add RVA23U64 profile
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20250114132012.1224941-1-dbarboza@ventanamicro.com>
 <20250114132012.1224941-4-dbarboza@ventanamicro.com>
 <20250114-65533b4fa14dbccc20496b88@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250114-65533b4fa14dbccc20496b88@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 1/14/25 11:57 AM, Andrew Jones wrote:
> On Tue, Jan 14, 2025 at 10:20:11AM -0300, Daniel Henrique Barboza wrote:
>> Add RVA23U64 as described in [1]. This profile does not share all
>> mandatory RVA22U64 extensions so we can't use RVA22U64 as a parent. We
>> need to declare all mandatory extensions from scratch.
> 
> But it does share all mandatory extensions of rva22u64 and you do use it
> as a parent :-)

Oooops. Forgot to update the commit msg :D


Daniel

> 
> Thanks,
> drew
> 
>>
>> A new "rva23u64" CPU is also added.
>>
>> [1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu-qom.h |  1 +
>>   target/riscv/cpu.c     | 34 ++++++++++++++++++++++++++++++++++
>>   2 files changed, 35 insertions(+)
>>
>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>> index d56b067bf2..53ead481a9 100644
>> --- a/target/riscv/cpu-qom.h
>> +++ b/target/riscv/cpu-qom.h
>> @@ -40,6 +40,7 @@
>>   #define TYPE_RISCV_CPU_RV64E            RISCV_CPU_TYPE_NAME("rv64e")
>>   #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
>>   #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
>> +#define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>>   #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>>   #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>>   #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 8d0563527f..e10ecc4ece 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -2394,9 +2394,35 @@ static RISCVCPUProfile RVA22S64 = {
>>       }
>>   };
>>   
>> +/*
>> + * All mandatory extensions from RVA22U64 are present
>> + * in RVA23U64 so set RVA22 as a parent. We need to
>> + * declare just the newly added mandatory extensions.
>> + */
>> +static RISCVCPUProfile RVA23U64 = {
>> +    .parent = &RVA22U64,
>> +    .name = "rva23u64",
>> +    .misa_ext = RVV,
>> +    .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
>> +    .satp_mode = RISCV_PROFILE_ATTR_UNUSED,
>> +    .ext_offsets = {
>> +        CPU_CFG_OFFSET(ext_zvfhmin), CPU_CFG_OFFSET(ext_zvbb),
>> +        CPU_CFG_OFFSET(ext_zvkt), CPU_CFG_OFFSET(ext_zihintntl),
>> +        CPU_CFG_OFFSET(ext_zicond), CPU_CFG_OFFSET(ext_zimop),
>> +        CPU_CFG_OFFSET(ext_zcmop), CPU_CFG_OFFSET(ext_zcb),
>> +        CPU_CFG_OFFSET(ext_zfa), CPU_CFG_OFFSET(ext_zawrs),
>> +
>> +        /* mandatory named features for this profile */
>> +        CPU_CFG_OFFSET(ext_supm),
>> +
>> +        RISCV_PROFILE_EXT_LIST_END
>> +    }
>> +};
>> +
>>   RISCVCPUProfile *riscv_profiles[] = {
>>       &RVA22U64,
>>       &RVA22S64,
>> +    &RVA23U64,
>>       NULL,
>>   };
>>   
>> @@ -2883,6 +2909,13 @@ static void rva22s64_profile_cpu_init(Object *obj)
>>   
>>       RVA22S64.enabled = true;
>>   }
>> +
>> +static void rva23u64_profile_cpu_init(Object *obj)
>> +{
>> +    rv64i_bare_cpu_init(obj);
>> +
>> +    RVA23U64.enabled = true;
>> +}
>>   #endif
>>   
>>   static const gchar *riscv_gdb_arch_name(CPUState *cs)
>> @@ -3162,6 +3195,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>       DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
>>       DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
>>       DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
>> +    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_profile_cpu_init),
>>   #endif /* TARGET_RISCV64 */
>>   };
>>   
>> -- 
>> 2.47.1
>>
>>


