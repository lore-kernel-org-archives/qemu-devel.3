Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8991BC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 20:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkUz0-00044x-NQ; Wed, 13 Mar 2024 16:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkUyw-00044W-4f
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 16:13:46 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkUys-0001Cy-VR
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 16:13:44 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33e76d653b5so152733f8f.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710360818; x=1710965618; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0Vf2B6tC4MZzaC6/m0aUN6BnnhK5icLLwrdce5nWMKA=;
 b=SdJcK9TnRCWwm/u30xmu/GK66YbFQMnrP2UYhGm/yJrBxyHPpo1dSugUKBDFHP1y43
 eTObRskKSGx2a0EeYMpUZNTwnm97rPXWSC6ZkPo6kc9pmNvSvyXzWpKHbNJIvFo6ed8/
 tdAGNtRS7H4cPuzdLWgxpYnpK6/dXqHbovu+bJeJ+EGuZWiShtRkSvJiq9mBZtWEKzl7
 qudhodWOfHVME24N3oHouOuoz6qyjUISHilRB/9B6fE6ixG7Amm6ha6p2deyl3fzsEk3
 JVTUkSwTq+QJpQBwfBQRy1tIKq2cs9A32OfoH6wMmQt7VW0TizIwWCy+FhO/zJekSPva
 08sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710360818; x=1710965618;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Vf2B6tC4MZzaC6/m0aUN6BnnhK5icLLwrdce5nWMKA=;
 b=h0KPajlBOIgl6wUWq43Qj25r9L1+GKBGzskMsCFYrKf83OnJ/FLYeLpSxFiw8YKqQB
 j2HsTxhKD9Ijm8X7t+59mC2mYhgwbZyHtdTIh+acnABGTIuoRgyFf5JqVoZiEGSzxtOL
 DTontu33MKg7Nl4U+dpA20+DslUxstSVLpSsyo7N191jyhSS9l0k31zMIPRynDhDH0ws
 2DzKUn7BIposax8qPe4eHSo9RBIVs66GIb8Wfg/6YMahMxgdqI60Vi/zBFMyzaB6FPop
 BCdgu/cw1gsNmmxxWoRXj/gX/QYmMZlG5vWMB1n62w7TOI82a4++6EwW9GvDHmRG7sjN
 Zqhg==
X-Gm-Message-State: AOJu0YzH9aFHcaGS0YwvBuMw0raYiMG3dRYDxCocrSr9rS1Sxu2dTHi1
 tKOYIhNeogidQpHSB02xihgihgfexpt6u8AcTg2nR3xZq2kB3uohfP4gR0jwgWo=
X-Google-Smtp-Source: AGHT+IHx5Khx0amAfQmSTwjf5dF49jRvaYSmgP8vWl06Fuew5sOf3K0+ci0O3IrVF4Vm2H/rnsqyAA==
X-Received: by 2002:a5d:5051:0:b0:33e:7fbd:5e6d with SMTP id
 h17-20020a5d5051000000b0033e7fbd5e6dmr2411457wrt.11.1710360818162; 
 Wed, 13 Mar 2024 13:13:38 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 c13-20020adfe74d000000b0033cf4e47496sm12434862wrn.51.2024.03.13.13.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 13:13:37 -0700 (PDT)
Date: Wed, 13 Mar 2024 21:13:36 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>
Subject: Re: [PATCH for-9.0] target/riscv: do not enable all named features
 by default
Message-ID: <20240313-bc3b8f00c9077858a90f5c88@orel>
References: <20240312203214.350980-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312203214.350980-1-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Mar 12, 2024 at 05:32:14PM -0300, Daniel Henrique Barboza wrote:
> Commit 3b8022269c added the capability of named features/profile
> extensions to be added in riscv,isa. To do that we had to assign priv
> versions for each one of them in isa_edata_arr[]. But this resulted in a
> side-effect: vendor CPUs that aren't running priv_version_latest started
> to experience warnings for these profile extensions [1]:
> 
>   | $ qemu-system-riscv32  -M sifive_e
>   | qemu-system-riscv32: warning: disabling zic64b extension for hart
> 0x00000000 because privilege spec version does not match
>   | qemu-system-riscv32: warning: disabling ziccamoa extension for
> hart 0x00000000 because privilege spec version does not match
> 
> This is benign as far as the CPU behavior is concerned since disabling
> both extensions is a no-op (aside from riscv,isa). But the warnings are
> unpleasant to deal with, especially because we're sending user warnings
> for extensions that users can't enable/disable.
> 
> Instead of enabling all named features all the time, separate them by
> priv version. During finalize() time, after we decided which
> priv_version the CPU is running, enable/disable all the named extensions
> based on the priv spec chosen. This will be enough for a bug fix, but as
> a future work we should look into how we can name these extensions in a
> way that we don't need an explicit ext_name => priv_ver as we're doing
> here.
> 
> The named extensions being added in isa_edata_arr[] that will be
> enabled/disabled based solely on priv version can be removed from
> riscv_cpu_named_features[]. 'zic64b' is an extension that can be
> disabled based on block sizes so it'll retain its own flag and entry.
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg02592.html
> 
> Reported-by: Clément Chigot <chigot@adacore.com>
> Fixes: 3b8022269c ("target/riscv: add riscv,isa to named features")
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c         | 40 +++++++++-----------------------------
>  target/riscv/cpu_cfg.h     |  8 +++++---
>  target/riscv/tcg/tcg-cpu.c | 14 ++++++++++---
>  3 files changed, 25 insertions(+), 37 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5a48d30828..1da5417764 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -102,10 +102,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
>      ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
>      ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
> -    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, ext_always_enabled),
> -    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, ext_always_enabled),
> -    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_always_enabled),
> -    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_always_enabled),
> +    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
> +    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
> +    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
> +    ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
>      ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
>      ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
> @@ -114,7 +114,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
>      ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
> -    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, ext_always_enabled),
> +    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
>      ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
>      ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
> @@ -179,12 +179,12 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> -    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, ext_always_enabled),
> +    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
> -    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, ext_always_enabled),
> +    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
> -    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, ext_always_enabled),
> -    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, ext_always_enabled),
> +    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
> +    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
>      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
> @@ -1575,11 +1575,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> -#define ALWAYS_ENABLED_FEATURE(_name) \
> -    {.name = _name, \
> -     .offset = CPU_CFG_OFFSET(ext_always_enabled), \
> -     .enabled = true}
> -
>  /*
>   * 'Named features' is the name we give to extensions that we
>   * don't want to expose to users. They are either immutable
> @@ -1590,23 +1585,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>  const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
>      MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
>  
> -    /*
> -     * cache-related extensions that are always enabled
> -     * in TCG since QEMU RISC-V does not have a cache
> -     * model.
> -     */
> -    ALWAYS_ENABLED_FEATURE("za64rs"),
> -    ALWAYS_ENABLED_FEATURE("ziccif"),
> -    ALWAYS_ENABLED_FEATURE("ziccrse"),
> -    ALWAYS_ENABLED_FEATURE("ziccamoa"),
> -    ALWAYS_ENABLED_FEATURE("zicclsm"),
> -    ALWAYS_ENABLED_FEATURE("ssccptr"),
> -
> -    /* Other named features that TCG always implements */
> -    ALWAYS_ENABLED_FEATURE("sstvecd"),
> -    ALWAYS_ENABLED_FEATURE("sstvala"),
> -    ALWAYS_ENABLED_FEATURE("sscounterenw"),
> -
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 2040b90da0..cb750154bd 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -130,10 +130,12 @@ struct RISCVCPUConfig {
>      bool ext_zic64b;
>  
>      /*
> -     * Always 'true' boolean for named features
> -     * TCG always implement/can't be disabled.
> +     * Always 'true' booleans for named features
> +     * TCG always implement/can't be user disabled,
> +     * based on spec version.
>       */
> -    bool ext_always_enabled;
> +    bool has_priv_1_12;
> +    bool has_priv_1_11;
>  
>      /* Vendor-specific custom extensions */
>      bool ext_xtheadba;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index ab6db817db..63192ef54f 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -315,9 +315,19 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
>  
>  static void riscv_cpu_update_named_features(RISCVCPU *cpu)
>  {
> +    if (cpu->env.priv_ver >= PRIV_VERSION_1_11_0) {
> +        cpu->cfg.has_priv_1_11 = true;
> +    }
> +
> +    if (cpu->env.priv_ver >= PRIV_VERSION_1_12_0) {
> +        cpu->cfg.has_priv_1_12 = true;
> +    }
> +
> +    /* zic64b is 1.12 or later */
>      cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
>                            cpu->cfg.cbop_blocksize == 64 &&
> -                          cpu->cfg.cboz_blocksize == 64;
> +                          cpu->cfg.cboz_blocksize == 64 &&
> +                          cpu->cfg.has_priv_1_12;
>  }
>  
>  static void riscv_cpu_validate_g(RISCVCPU *cpu)
> @@ -1316,8 +1326,6 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      Object *obj = OBJECT(cpu);
>  
> -    cpu->cfg.ext_always_enabled = true;
> -
>      misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
>      multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
>      riscv_cpu_add_user_properties(obj);
> -- 
> 2.43.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

