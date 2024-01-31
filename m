Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0814C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 19:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVG3d-0003TS-DH; Wed, 31 Jan 2024 14:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVG3a-0003Ru-JE
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 14:15:34 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVG3Y-0002wy-78
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 14:15:34 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6de2e24ea87so34152b3a.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 11:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706728530; x=1707333330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pWQveSsFJ/3CVVd/Ztg7/c4z2PNpagKkX/j/QMzbWnQ=;
 b=R0uJkubb93VHNLMhgIljppXLToQ79+OLtLxT4hZRQfJ4wq7By8Pqp3Kof19RMKVdGZ
 TcddlQ5eF/K7IfdcWFM8urdkn2k9AjMVF+ShRCAS2tK4iguNtIbNVcPToyC2PtgvIz6O
 KvGquLJVmNFovMeFdoVEhvmEXTvbKQjJ1r5ULyUMY47dCc/TEqFcWSuYeslxRDyDmUCz
 if+bYLl0j9xGJCezFYwUEbjp2/VfkOaoM40rkccK1uAO0gy81BvtQbRcUM2Uidoce1R7
 44vARWv6c1D3mK+nqEIztI16AdgIgKkqKu3DC04UFlSZ9y9U+JoCfxFQqm1UxBc0qLz2
 ki8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706728530; x=1707333330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pWQveSsFJ/3CVVd/Ztg7/c4z2PNpagKkX/j/QMzbWnQ=;
 b=UHsUStlItr3+1pbKkxLnolCQTahs6abOeCe22YA7qXF9HtZ701Zb2q9+z9SYcOTwwg
 b+lSvUOESxKpNgcEOHdMHVSXW4kyoantAAgYnhzxcwO0K5bqNYY+Fd0KJXwlqxoeEmK0
 4nqTu1cNbzjM4XgRGUtUBxWRjsLU7kKKejzntwvVlS/l5TgOuwotpS29T6rT18kqk/3y
 O0TlzXgnSdhrOUBHf6oD5vvUvO4/x45XQrfKB9Jq7nQ59FM6OicBGAcUF2wCJxcNb5I6
 icLIrtTMJZQ7eO3VN1pt1tP+7D1yKPxIolh7gmiu/EkKrhzp09dIKys5LA78QMYfXX9e
 UplA==
X-Gm-Message-State: AOJu0YzZBQ7zmEXSk9l90RpwvR2r4prS7q1xGafkZSuwo5JYo5pndyLI
 0H/u2NT3A11ots2bbNwKOVwB3fGwbSI/jN84xQ6UoG/xW8ADfpeVKLOaBayr718=
X-Google-Smtp-Source: AGHT+IGg27grFLp3NK1IhkRqHk0uiDPtA2JS10EuTOVm9fg7rKjG0QGubSxLdTg9pGOBHQo8iWIeuA==
X-Received: by 2002:a05:6a00:1803:b0:6db:acb2:a95d with SMTP id
 y3-20020a056a00180300b006dbacb2a95dmr2707304pfa.21.1706728530627; 
 Wed, 31 Jan 2024 11:15:30 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 y11-20020a056a00190b00b006da8f6650a2sm10141463pfi.155.2024.01.31.11.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 11:15:30 -0800 (PST)
Message-ID: <92c19649-4799-44c1-b7df-c958e1d5b2cc@ventanamicro.com>
Date: Wed, 31 Jan 2024 16:15:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/riscv: add remaining named features
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com
References: <20240125195319.329181-1-dbarboza@ventanamicro.com>
 <20240125195319.329181-4-dbarboza@ventanamicro.com>
 <CAKmqyKNZ73Ep1sBKGBoX=wNvOPq_R+UU_K9qSRABBQUzK-LFLA@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAKmqyKNZ73Ep1sBKGBoX=wNvOPq_R+UU_K9qSRABBQUzK-LFLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 1/29/24 22:10, Alistair Francis wrote:
> On Fri, Jan 26, 2024 at 5:54 AM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> The RVA22U64 and RVA22S64 profiles mandates certain extensions that,
>> until now, we were implying that they were available.
>>
>> We can't do this anymore since named features also has a riscv,isa
>> entry.  Let's add them to riscv_cpu_named_features[].
>>
>> They will also need to be explicitly enabled in both profile
>> descriptions. TCG will enable the named features it already implements,
>> other accelerators are free to handle it as they like.
>>
>> After this patch, here's the riscv,isa from a buildroot using the
>> 'rva22s64' CPU:
>>
>>   # cat /proc/device-tree/cpus/cpu@0/riscv,isa
>> rv64imafdc_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_ziccrse_
>> zicntr_zicsr_zifencei_zihintpause_zihpm_za64rs_zfhmin_zca_zcd_zba_zbb_
>> zbs_zkt_sscounterenw_sstvala_sstvecd_svade_svinval_svpbmt#
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu.c         | 41 +++++++++++++++++++++++++++++---------
>>   target/riscv/cpu_cfg.h     |  9 +++++++++
>>   target/riscv/tcg/tcg-cpu.c | 19 +++++++++++++++++-
>>   3 files changed, 59 insertions(+), 10 deletions(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 28d3cfa8ce..1ecd8a57ed 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -101,6 +101,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
>>       ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
>>       ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
>> +    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, ext_ziccamoa),
>> +    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, ext_ziccif),
>> +    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_zicclsm),
>> +    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
>>       ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
>>       ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
>>       ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
>> @@ -109,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
>>       ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
>>       ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>> +    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, ext_za64rs),
>>       ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
>>       ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
>>       ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
>> @@ -170,8 +175,12 @@ const RISCVIsaExtData isa_edata_arr[] = {
>>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>> +    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, ext_ssccptr),
>>       ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
>> +    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, ext_sscounterenw),
>>       ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>> +    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, ext_sstvala),
>> +    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, ext_sstvecd),
>>       ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
>>       ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
>>       ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>> @@ -1523,6 +1532,22 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
>>       MULTI_EXT_CFG_BOOL("svade", ext_svade, true),
>>       MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
>>
>> +    /*
>> +     * cache-related extensions that are always enabled
>> +     * since QEMU RISC-V does not have a cache model.
>> +     */
>> +    MULTI_EXT_CFG_BOOL("za64rs", ext_za64rs, true),
>> +    MULTI_EXT_CFG_BOOL("ziccif", ext_ziccif, true),
>> +    MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
>> +    MULTI_EXT_CFG_BOOL("ziccamoa", ext_ziccamoa, true),
>> +    MULTI_EXT_CFG_BOOL("zicclsm", ext_zicclsm, true),
>> +    MULTI_EXT_CFG_BOOL("ssccptr", ext_ssccptr, true),
>> +
>> +    /* Other named features that QEMU TCG always implements */
>> +    MULTI_EXT_CFG_BOOL("sstvecd", ext_sstvecd, true),
>> +    MULTI_EXT_CFG_BOOL("sstvala", ext_sstvala, true),
>> +    MULTI_EXT_CFG_BOOL("sscounterenw", ext_sscounterenw, true),
>> +
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>
>> @@ -2116,13 +2141,8 @@ static const PropertyInfo prop_marchid = {
>>   };
>>
>>   /*
>> - * RVA22U64 defines some 'named features' or 'synthetic extensions'
>> - * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
>> - * and Zicclsm. We do not implement caching in QEMU so we'll consider
>> - * all these named features as always enabled.
>> - *
>> - * There's no riscv,isa update for them (nor for zic64b, despite it
>> - * having a cfg offset) at this moment.
>> + * RVA22U64 defines some cache related extensions: Za64rs,
>> + * Ziccif, Ziccrse, Ziccamoa and Zicclsm.
>>    */
>>   static RISCVCPUProfile RVA22U64 = {
>>       .parent = NULL,
>> @@ -2139,7 +2159,9 @@ static RISCVCPUProfile RVA22U64 = {
>>           CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
>>
>>           /* mandatory named features for this profile */
>> -        CPU_CFG_OFFSET(ext_zic64b),
>> +        CPU_CFG_OFFSET(ext_za64rs), CPU_CFG_OFFSET(ext_zic64b),
>> +        CPU_CFG_OFFSET(ext_ziccif), CPU_CFG_OFFSET(ext_ziccrse),
>> +        CPU_CFG_OFFSET(ext_ziccamoa), CPU_CFG_OFFSET(ext_zicclsm),
>>
>>           RISCV_PROFILE_EXT_LIST_END
>>       }
>> @@ -2170,7 +2192,8 @@ static RISCVCPUProfile RVA22S64 = {
>>           CPU_CFG_OFFSET(ext_svinval),
>>
>>           /* rva22s64 named features */
>> -        CPU_CFG_OFFSET(ext_svade),
>> +        CPU_CFG_OFFSET(ext_sstvecd), CPU_CFG_OFFSET(ext_sstvala),
>> +        CPU_CFG_OFFSET(ext_sscounterenw), CPU_CFG_OFFSET(ext_svade),
>>
>>           RISCV_PROFILE_EXT_LIST_END
>>       }
>> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
>> index 698f926ab1..f79fc3dfd1 100644
>> --- a/target/riscv/cpu_cfg.h
>> +++ b/target/riscv/cpu_cfg.h
>> @@ -125,6 +125,15 @@ struct RISCVCPUConfig {
>>       /* Named features  */
>>       bool ext_svade;
>>       bool ext_zic64b;
>> +    bool ext_za64rs;
>> +    bool ext_ziccif;
>> +    bool ext_ziccrse;
>> +    bool ext_ziccamoa;
>> +    bool ext_zicclsm;
>> +    bool ext_ssccptr;
>> +    bool ext_sstvecd;
>> +    bool ext_sstvala;
>> +    bool ext_sscounterenw;
> 
> Overall this and the previous patch look fine.
> 
> One thing though, why store this information? I feel it could be
> confusing having these variables. If a developer sets them to false
> nothing actually happens, which is a little misleading

These extensions aren't being exposed to users. riscv_cpu_named_features[] isn't
being used to create any CPU user properties. I should've mentioned that in
patch 2 ...

As for the extra booleans that we'll be setting to 'true', as it is now
isa_edata_arr[] stores a string name, priv_ver and a cpu->cfg offset, so
everyone that adds a riscv,isa str must also have a valid bool offset in
RISCVCPUConfig. Having a bool also allow us to treat them as regular extensions
because we can re-use existing code to blindly enable them in profiles like
any other profile extension.

And, in case we need to promote them as regular user extensions, having the
booleans in place make it easier to do so. Patch 6 is doing that with 'svade'.


Thanks,

Daniel


We could create a single boolean that is always true in cpu->cfg and use it
for these entries. Another idea would be to change the riscv,isa functions to
handle these extensions separately, then we can add them in the array without
a valid cpu->cfg offfset.

> 
> Alistair
> 
>>
>>       /* Vendor-specific custom extensions */
>>       bool ext_xtheadba;
>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>> index 90861cc065..6d5028cf84 100644
>> --- a/target/riscv/tcg/tcg-cpu.c
>> +++ b/target/riscv/tcg/tcg-cpu.c
>> @@ -206,7 +206,8 @@ static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_offset)
>>           cpu->cfg.ext_svadu = false;
>>           break;
>>       default:
>> -        g_assert_not_reached();
>> +        /* Named feature already enabled in riscv_tcg_cpu_instance_init */
>> +        return;
>>       }
>>   }
>>
>> @@ -1342,6 +1343,20 @@ static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
>>       return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) != NULL;
>>   }
>>
>> +/* Named features that TCG always implements */
>> +static void riscv_tcg_cpu_enable_named_feats(RISCVCPU *cpu)
>> +{
>> +    cpu->cfg.ext_za64rs = true;
>> +    cpu->cfg.ext_ziccif = true;
>> +    cpu->cfg.ext_ziccrse = true;
>> +    cpu->cfg.ext_ziccamoa = true;
>> +    cpu->cfg.ext_zicclsm = true;
>> +    cpu->cfg.ext_ssccptr = true;
>> +    cpu->cfg.ext_sstvecd = true;
>> +    cpu->cfg.ext_sstvala = true;
>> +    cpu->cfg.ext_sscounterenw = true;
>> +}
>> +
>>   static void riscv_tcg_cpu_instance_init(CPUState *cs)
>>   {
>>       RISCVCPU *cpu = RISCV_CPU(cs);
>> @@ -1354,6 +1369,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
>>       if (riscv_cpu_has_max_extensions(obj)) {
>>           riscv_init_max_cpu_extensions(obj);
>>       }
>> +
>> +    riscv_tcg_cpu_enable_named_feats(cpu);
>>   }
>>
>>   static void riscv_tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClass *cc)
>> --
>> 2.43.0
>>
>>

