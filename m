Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B450DC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 09:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXzxs-000714-Cl; Wed, 15 Jan 2025 04:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXzxo-00070G-8y
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 04:45:28 -0500
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXzxm-0006yt-B9
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 04:45:27 -0500
Received: by mail-oo1-xc42.google.com with SMTP id
 006d021491bc7-5f33ad7d6faso4585060eaf.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 01:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736934325; x=1737539125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OxtSI0UKUan1aEzVvRDNZV590slTk3di1OHAHwaRJco=;
 b=Ut1316CQ6a8rSlJuSS2ypUnvn5eM36PXb6PGVI3WtwKkl/swnMV/yVKA7C9J/XrTG2
 FzTvV1/3ZAqyi7V2Up8xSs4+XLHHudSeuGU+OkBxph0HgLZrrlV0nuNh/zbR2EaLholR
 /BzFbG76DdyCwYddEbQgaxgybX08PdH8KuHhUz+0laZnkvrYl/RL6hvgEY8yrtlu+/hN
 mAVFkQvpBlNNN6XbMLMwiNpE2cUFMQDZdPZADrSFCKwJCo3OxM5QNq6ZVk+1hjKbDcD3
 aI4u05+zQ+0nxBzcH03xUMYTREL/eJ1BxmGZWeY6UktkpWENX2Q4zyw+aTXzY5ZrskTt
 MZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736934325; x=1737539125;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OxtSI0UKUan1aEzVvRDNZV590slTk3di1OHAHwaRJco=;
 b=X9Znabikb1CBDitvpADabJdrgzGFDZnVo5HRioCwIKxzXux0qhI7QymV/GeIb1+3/L
 kqntgiWx+nLIe4y5HZcKfviXSE+HHY3F4jaSLg4NshA57tKJUyF9uHAzM1Ox9RWvreTt
 RhcZRvGf0eBa+xwu1iMLg+SS9cigKYZI1ym8EKvTtKKCaNcb1g0McrCANQSe2OgUPQmf
 RCIAjfC/4Am/A9PWJRIMO1JWNwy/Xf98wkerXJrdV9GmcVWC3y/x9MXgz0TAvliUxpcg
 u9QqHE8gnrRX12B2KnWLx6uRHKReHu8GCA9GI/Va19aFCMnNkNLbGKKE6/fZZ/u+xM17
 fjzA==
X-Gm-Message-State: AOJu0YyteXhBsDflGvuI8lAA1h+1NqGC9L5gOOYqscb/fgZjleQ8pV8Q
 6FHXpCnpOGqMat7alC7A36gkVyCO6dyDPJixq4RvuwdQz/xphrvPJgEI734WYyA=
X-Gm-Gg: ASbGncsp7RsGcHNorbQ8lNL4mEren7pfjxa53IV7ApM3QI3XU/icMSEZ9OKIo62DGbz
 FH/+3rHS28tlxCSnEB3nuUGECDv3NbohskGjkiovQuhMJpgUKy02aGKp+2RxDkhvyUrAyEPXUBI
 pgb7om3KN5++m5mv/HMzSXsowb4p5erdvM2br/ZkZ4CP4TsFaKuKrCtjA8WKV65XF72rWr6sWKx
 cLWT7AcHE4s5FQ9erQDPcq96k6WC+u0/zrtyEWpywNZf/Ua77SHgub30drHXeOssSgVAm0=
X-Google-Smtp-Source: AGHT+IHV5pizCpKIxz9GGJyUWwRMvwHJPZEDQ9EgXL3oKel5sALUncR5TyOWwXcAJz9p5T0YszQQkA==
X-Received: by 2002:a05:6820:a06:b0:5f8:c64a:f293 with SMTP id
 006d021491bc7-5f8c64af4b7mr3949176eaf.5.1736934325002; 
 Wed, 15 Jan 2025 01:45:25 -0800 (PST)
Received: from [192.168.68.110] ([191.202.238.10])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7231855fd71sm5517431a34.42.2025.01.15.01.45.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 01:45:23 -0800 (PST)
Message-ID: <cef01dd4-a4fd-4a3a-b8bb-b2fd1c9dabdd@ventanamicro.com>
Date: Wed, 15 Jan 2025 06:45:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] target/riscv: add RVA23S64 profile
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20250114190001.1650942-1-dbarboza@ventanamicro.com>
 <20250114190001.1650942-5-dbarboza@ventanamicro.com>
 <20250115-7dc96d44b7516a71858d6d81@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250115-7dc96d44b7516a71858d6d81@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc42.google.com
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



On 1/15/25 5:24 AM, Andrew Jones wrote:
> On Tue, Jan 14, 2025 at 04:00:01PM -0300, Daniel Henrique Barboza wrote:
>> Add RVA23S64 as described in [1]. This profile inherits all mandatory
>> extensions of RVA23U64, making it a child of the U64 profile.
>>
>> A new "rva23s64" profile CPU is also added. This is the generated
>> riscv,isa for it (taken via -M dumpdtb):
>>
>> rv64imafdcbvh_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_
>> ziccrse_zicond_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zimop_
>> zmmul_za64rs_zaamo_zalrsc_zawrs_zfa_zfhmin_zca_zcb_zcd_zcmop_zba_zbb_zbs_
>> zkt_zvbb_zve32f_zve32x_zve64f_zve64d_zve64x_zvfhmin_zvkb_zvkt_shcounterenw_
>> sha_shgatpa_shtvala_shvsatpa_shvstvala_shvstvecd_smnpm_smstateen_ssccptr_
>> sscofpmf_sscounterenw_ssnpm_ssstateen_sstc_sstvala_sstvecd_ssu64xl_
>> supm_svade_svinval_svnapot_svpbmt
>>
>> [1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu-qom.h |  1 +
>>   target/riscv/cpu.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 43 insertions(+)
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
>> index 371a7d63fa..9225459bf8 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -2418,10 +2418,44 @@ static RISCVCPUProfile RVA23U64 = {
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
> 
> I'd prefer we come up with a way to inherit rva22s64, as it'll
> make the fact that later profiles should expand earlier profiles
> more clear and also avoid issues like missing zifencei. I guess
> it should be as easy as renaming parent to uparent and adding an
> sparent, right?

I think it's worth a shot. I'll see what I can do in v3. Thanks,


Daniel


> 
> Thanks,
> drew
> 
>> +        CPU_CFG_OFFSET(ext_zifencei), CPU_CFG_OFFSET(ext_svade),
>> +        CPU_CFG_OFFSET(ext_svpbmt), CPU_CFG_OFFSET(ext_svinval),
>> +
>> +        /* New in RVA23S64 */
>> +        CPU_CFG_OFFSET(ext_svnapot), CPU_CFG_OFFSET(ext_sstc),
>> +        CPU_CFG_OFFSET(ext_sscofpmf), CPU_CFG_OFFSET(ext_ssnpm),
>> +
>> +        /* Named features: Sha */
>> +        CPU_CFG_OFFSET(ext_sha),
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
>> @@ -2915,6 +2949,13 @@ static void rva23u64_profile_cpu_init(Object *obj)
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
>> @@ -3195,6 +3236,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


