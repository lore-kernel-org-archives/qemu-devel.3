Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970A6E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 16:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXjfd-0003rn-QL; Tue, 14 Jan 2025 11:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXjfZ-0003qy-3Q
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:21:34 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXjfW-0005F3-NV
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:21:32 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-216634dd574so66913095ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 08:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736871688; x=1737476488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k7/mhpKZT4G4e8PT0xIft9JMuvq8L0okChkv9+rRC6M=;
 b=FzyeOfpi+uHMFVhMH+CXMT/ByzBlk267R+hnFK0oz1+NRBwe+xqtq5b6y+ram/Z+Yy
 cEBKONWEURgVkS8AU2Hs5ZNg7uxIT0VS+ropyYuWUqw992H6AmFJj0dM5uIxcqu7v9kE
 2qmQvkXmPRjB/0qg4mP7P0c6t6KqeKcG7l6KoX657us/yh8NhIm7XrKCnE8T+bG4Ow3N
 57MZfMgISqjWMiVcKuqsxj4tU1X6xV3R0FzKnEWjTlvSc3wZe6RIzXMHAaIepIKz6RGM
 5jX/NTKW6uYHe22tSfqVkG7OHMVkcAn8clBwtIdyVLuBa0YRMke4vFelQ2BmJl8noHp2
 nZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736871688; x=1737476488;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k7/mhpKZT4G4e8PT0xIft9JMuvq8L0okChkv9+rRC6M=;
 b=S+ZqmGRkol9MyKSk2M99iRakCgr59vuMdJHy3iMvFSt/NebtJn44RW8frAToSyY0jR
 177fqCvENfA53ibfLF7QJ8fjHkaAzz0oAEfjx0F3B7Vh538XT3BZ0ZjGtpP+cRDCzizm
 XGvnAMR+CUDWJMN02djU+iFGlX5RRnVGwVBaZXQYtV/jsutJKlOTlm0+3ct8GmT8gKNw
 emv5VvTxF9UDq8DsQ7zmvwoLGnDNNPt9jvyk/pesfdh2qug0VusdgoGCvHdf+Q/8UlIj
 B7inptf9QwAabisbx2eg4nF8Vpe3LSDDnUN6e5mQDhO/yaEyFUAv0hZsGHM1IqYnZGiP
 bLDQ==
X-Gm-Message-State: AOJu0YzqSBOHfSF+2kpEUM6ixxZNcOhGY37XRsJYwUUQDsOmaVrO9RRD
 OOiU+m9YBoW1h1+8p7cEWLQKhE5+gzdCXd42fFhm81XTP9IiuaFHh0ZKIIdy80YCpV/VyK726sQ
 pH87x0A==
X-Gm-Gg: ASbGncvLAEp46StWCU3maccd20Hzl5fIeE3BY6zSnGCFLUClRz3xsJbeH5vuIJMuTqN
 bp6Vlek5V/39YAy+ddeeix8qWaJ1shBNwsianhmRWSBRwhgB6dqf4p7R/AgnYnuWnG6q2N3C+gG
 Hkok6EQijYpKLx8uxx5N/xlgZ0R+Ord3+thoU8mXZLfxWykTIbDYv91ZU+UBvDctX7E9fcRfomF
 mOspaGSlPFh1ZJCjkReyhGjfLMJybF7SepQvcBn1FIZcmCJm0Ymj2i6rRglPCxMD37KRFBJ
X-Google-Smtp-Source: AGHT+IGJ5q79En67yrMda/Meg/Ci6mVbnaowK9ym7WNi8a0Ou6diwKxVd11FW4JUENy1/JKKrWtZkw==
X-Received: by 2002:a17:903:41c3:b0:216:18f9:528b with SMTP id
 d9443c01a7336-21a83f6299emr370477525ad.26.1736871688602; 
 Tue, 14 Jan 2025 08:21:28 -0800 (PST)
Received: from [192.168.68.110] ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f22d11fsm69115895ad.178.2025.01.14.08.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 08:21:28 -0800 (PST)
Message-ID: <5c8e6416-91db-42e8-84b4-062572436950@ventanamicro.com>
Date: Tue, 14 Jan 2025 13:21:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/riscv: add RVA23S64 profile
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20250114132012.1224941-1-dbarboza@ventanamicro.com>
 <20250114132012.1224941-5-dbarboza@ventanamicro.com>
 <20250114-96a4217891128dc91926b19c@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250114-96a4217891128dc91926b19c@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x644.google.com
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



On 1/14/25 12:09 PM, Andrew Jones wrote:
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
> 
> yeah, zba/zbb/zbs are still here as expected. So patch 2's bios table
> change was likely just the 'b', which we see at the start.
> 
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
> 
> I guess we can't inherit from both rva23u64 and rva22s64, which is what
> we'd like to do.

Not at this moment, although it wouldn't be hard to pull it off if we want.

> 
> What about zifencei?

Oh dear I forgot about it. I'll add it in v2. Good catch.


Daniel


> 
>> +
>> +        /* New in RVA23S64 */
>> +        CPU_CFG_OFFSET(ext_svnapot), CPU_CFG_OFFSET(ext_sstc),
>> +        CPU_CFG_OFFSET(ext_sscofpmf),
>> +
>> +        /* Named features: Sha, ssu64xl, ssnpm */
>> +        CPU_CFG_OFFSET(ext_sha),
>> +        CPU_CFG_OFFSET(ext_ssnpm),
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
> 
> Thanks,
> drew


