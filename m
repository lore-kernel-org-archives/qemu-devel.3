Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A422EE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 16:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXjYc-0001Yb-OJ; Tue, 14 Jan 2025 11:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXjYU-0001WT-1g
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:14:14 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXjYR-0003vT-1b
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:14:13 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2164b662090so98282615ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 08:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736871247; x=1737476047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y//BXroZRvl/C+yUIMD+CUXOuvbdDtB8OCeJItWRgUE=;
 b=Rl93OSf3gVecEe3amHE4bTXptnQ5ozcXpBXLsURCN6phkBcuy9oigl0CrcLUmqdeBT
 rbATNqRu+DQhDI+6xJlGDuou5E04ImwrqkDTL/OdYxgcQSxJ5PU9/I7kUg2dE0AsA+k+
 2wWW2tIoXwfCKhnLpThNYWl4sSCws/atP/Ho5MZHFB140hdIkt8tklDEokslohkh8pnn
 0kAt4SEqhdh1yjNWJDKCtzFD2YJkJpdezpxoMsHPBomkAkMztMsexslCHxw7tlXcLqrv
 hE+ishHSnpIc8vvxqo+lPkxYvDDDV683EoFOk9OgbAffV9AWzZsFSwZKSgwscMpycid9
 t/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736871247; x=1737476047;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y//BXroZRvl/C+yUIMD+CUXOuvbdDtB8OCeJItWRgUE=;
 b=dpYziyKINVud7xMlW7a9eHo5rC7zF1G2YzvVjNrwoBC3PAPHBMcNWd7jpAvlrcvkz6
 d1KsorlULEczRIPSZkYuPWbu1v+Nyo9oPgsw7dHdxr8/3rv0jih92eq6j/i2XTq3rXUn
 B6gM6Hf40x80yEpsLzSdzz6HzQCJ4aDONY6C5HZMJ+/P1/4qtfxFARIq8R/5MjLuHgM8
 CI+Gkbxch+ingNtc8n1OX8IEUQ2ZGRaTXhcgUP6JUuVKY+GaJQjheSHxDZuSzg1u6yy2
 ae3WtpR17RYw0mxNihH4kFMLEQw6lO6dfT2QVNgo/FtL7Y0dWtp+SXjd+C/xJDcyJA9P
 nbKg==
X-Gm-Message-State: AOJu0YzEeEezsd/juFbjn8OHY1C8qhc1qXN6Zxnig8ftg5iyB4EJPqGj
 oug8PeT6zqI4ts0GHb5GIh90S2s90Ro5oaY8Ox82ZCYHcwl72r0Hsg794xZ3KG4=
X-Gm-Gg: ASbGncviTMAEVA5J9nQCGI7fI0GXJk98gLRwUG7DKwAcrQHHUtXi8cxoG6Bbly9d+vM
 TAXc/Yhwe4dQgrC7dyUS0FLfS6V6icQG9HRKFHYgs0xlv/W8BxKcO/CgeXRN7A96xIXxHjVEkjP
 u4//zNriKCRuax6aDdJ0rwVJTOmbwE2N3bEbQyx8QEwW7Ulum0qtfirza65ymGpbIgVTN0D+EhH
 pjSCstlJQopNUR/u3ROuqEOjj9/2U6X5DZvm/PodDqnoGdYDMBJFdwUtCSVh1F4Hdfl1Dxn
X-Google-Smtp-Source: AGHT+IEsS0rgZM0gU3TnxpmjG+0sL9+oxHs/BtCIP33GEwWFQK83MDOu4tWqIqZBEJyhu5NHMTLbKA==
X-Received: by 2002:a05:6a20:12cc:b0:1e1:e2d8:fd1d with SMTP id
 adf61e73a8af0-1e88d0a2b46mr37876502637.33.1736871247000; 
 Tue, 14 Jan 2025 08:14:07 -0800 (PST)
Received: from [192.168.68.110] ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40658db6sm7881635b3a.104.2025.01.14.08.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 08:14:06 -0800 (PST)
Message-ID: <f7ed01aa-2d8a-49d9-b082-6f31ae2b5fef@ventanamicro.com>
Date: Tue, 14 Jan 2025 13:14:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/riscv: add RVA23S64 profile
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20250114132012.1224941-1-dbarboza@ventanamicro.com>
 <20250114132012.1224941-5-dbarboza@ventanamicro.com>
 <20250114-a6a244e7bfc4b7bd2535750d@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250114-a6a244e7bfc4b7bd2535750d@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x641.google.com
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



On 1/14/25 12:25 PM, Andrew Jones wrote:
> On Tue, Jan 14, 2025 at 10:20:12AM -0300, Daniel Henrique Barboza wrote:
>> Add RVA23S64 as described in [1]. This profile inherits all mandatory
>> extensions of RVA23U64, making it a child of the U64 profile.
>>
>> A new "rva23s64" profile CPU is also added. This is the generated
>> riscv,isa for it (taken via -M dumpdtb):
>>
>> rv64imafdcbvh_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_
>> ziccrse_zicond_zicntr_zicsr_zihintntl_zihintpause_zihpm_zimop_zmmul_
>> za64rs_zaamo_zalrsc_zawrs_zfa_zfhmin_zca_zcb_zcd_zcmop_zba_zbb_zbs_zkt_
>> zvbb_zve32f_zve32x_zve64f_zve64d_zve64x_zvfhmin_zvkb_zvkt_shcounterenw_
>> sha_shgatpa_shtvala_shvsatpa_shvstvala_shvstvecd_smnpm_smstateen_ssccptr_
>> sscofpmf_sscounterenw_ssnpm_ssstateen_sstc_sstvala_sstvecd_ssu64xl_
>> supm_svade_svinval_svnapot_svpbmt
>>
>> [1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu-qom.h |  1 +
>>   target/riscv/cpu.c     | 43 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>> index 53ead481a9..4cfdb74891 100644
>> --- a/target/riscv/cpu-qom.h
>> +++ b/target/riscv/cpu-qom.h
>> @@ -41,6 +41,7 @@
>>   #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
>>   #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
>>   #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>> +#define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
>>   #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>>   #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>>   #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index e10ecc4ece..14af141349 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -2419,10 +2419,45 @@ static RISCVCPUProfile RVA23U64 = {
>>       }
>>   };
>>   
>> +/*
>> + * As with RVA23U64, RVA23S64 also defines 'named features'.
>> + *
>> + * Cache related features that we consider enabled since we don't
>> + * implement cache: Ssccptr
>> + *
>> + * Other named features that we already implement: Sstvecd, Sstvala,
>> + * Sscounterenw, Ssu64xl
>> + *
>> + * The remaining features/extensions comes from RVA23U64.
>> + */
>> +static RISCVCPUProfile RVA23S64 = {
>> +    .parent = &RVA23U64,
>> +    .name = "rva23s64",
>> +    .misa_ext = RVS,
>> +    .priv_spec = PRIV_VERSION_1_13_0,
>> +    .satp_mode = VM_1_10_SV39,
>> +    .ext_offsets = {
>> +        /* These were present in RVA22S64 */
>> +        CPU_CFG_OFFSET(ext_svade), CPU_CFG_OFFSET(ext_svpbmt),
>> +        CPU_CFG_OFFSET(ext_svinval),
>> +
>> +        /* New in RVA23S64 */
>> +        CPU_CFG_OFFSET(ext_svnapot), CPU_CFG_OFFSET(ext_sstc),
>> +        CPU_CFG_OFFSET(ext_sscofpmf),
>> +
>> +        /* Named features: Sha, ssu64xl, ssnpm */
>> +        CPU_CFG_OFFSET(ext_sha),
>> +        CPU_CFG_OFFSET(ext_ssnpm),
> 
> Why are we calling ssnpm a named feature? And same question for supm in
> the last patch.

They're both defined in RVA23 as follows:

- Supm Pointer masking, with the execution environment providing a means to
select PMLEN=0 and PMLEN=7 at minimum.

- Ssnpm Pointer masking, with senvcfg.PMM and henvcfg.PMM supporting, at minimum,
settings PMLEN=0 and PMLEN=7.


This is consistent to what we usually call a named feature, i.e. a special name
for a particular setting for an existing extension.

Granted, both are working as actual extensions in QEMU, so I guess we can treat
them as such regardless of what the spec says.


Thanks,

Daniel


> 
> Thanks,
> drew
> 
>> +
>> +        RISCV_PROFILE_EXT_LIST_END
>> +    }
>> +};
>> +
>>   RISCVCPUProfile *riscv_profiles[] = {
>>       &RVA22U64,
>>       &RVA22S64,
>>       &RVA23U64,
>> +    &RVA23S64,
>>       NULL,
>>   };
>>   
>> @@ -2916,6 +2951,13 @@ static void rva23u64_profile_cpu_init(Object *obj)
>>   
>>       RVA23U64.enabled = true;
>>   }
>> +
>> +static void rva23s64_profile_cpu_init(Object *obj)
>> +{
>> +    rv64i_bare_cpu_init(obj);
>> +
>> +    RVA23S64.enabled = true;
>> +}
>>   #endif
>>   
>>   static const gchar *riscv_gdb_arch_name(CPUState *cs)
>> @@ -3196,6 +3238,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>       DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
>>       DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
>>       DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_profile_cpu_init),
>> +    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  MXL_RV64,  rva23s64_profile_cpu_init),
>>   #endif /* TARGET_RISCV64 */
>>   };
>>   
>> -- 
>> 2.47.1
>>
>>


