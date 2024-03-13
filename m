Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9E7C54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 19:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkU2n-0002GT-Vf; Wed, 13 Mar 2024 15:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkU2m-0002GG-5x
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:13:40 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkU2k-0007q1-Ed
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:13:39 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33e285a33bdso75391f8f.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710357217; x=1710962017; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M0CA2nix0wV2J5uQwNl9MwdTxI2MrfDGwK524T4Sy78=;
 b=V53VNmvCySzbM1xJ5w4CxfmJbG5/JmEMLpt6clBn9DX2XHjxwI0mMfQQsjQLDsdDzU
 0pRXb9mc1WTWTLu4Ry1+10K/FoG+cNI1RmaMk2n9EyHT0sCC9Nu/YB49vPaOuWzkh74v
 5GNT/X2Xad/Ig/0fpg9OD4dHmR2ZI/1pUJHSrbv5M82p21V9vo/idj7OoJTKghI0ASsI
 0fJF8rrnBxe4+Os5G8igNrrQWHgszWF3+Fu7SNXyFpnpdH77gDNUD5KDKv/jNXFjMSS5
 CZ/MwHks9T5dyL2BUQcI4ODR/IV9HjLiZ14BdatnOmguyL1A3oD3JyeG+h/8AiESSIgY
 pO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710357217; x=1710962017;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M0CA2nix0wV2J5uQwNl9MwdTxI2MrfDGwK524T4Sy78=;
 b=SAeohHuGX25n5usstP285yvfIpf3ZoLwaJMSy/mT5sFDywOVf5nGJW4hGW6lwON5RU
 Bke04mFFlYk9VqMUvcUQuCMdWJjs3Yma02oAZnWVRY7V8fyJekpc5rfnbTW1ar3kOckv
 peAvtGcv9OKDR6XGy+Mc9AbbpyYKMiSILsMGA62AuRhxjHv/JiD2VRkgW5s6zHn/2wD0
 UttSkOSNcUdyznWVI2cwnNAZml/d1qbgXx/SXDDBA+1CpuFAxXWETPACaXIxQatHIAd4
 ceDPqpfJ74N3BA90U0t7BHVNeQ5qcAJSjfaXyBruFHKWjB8ujcA9J+66LYKoegOr4fo6
 RLzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8dj3DYsyeEAcXG/pKu1IiYsJBsqkwS1c6sZnmp4lppIM1KEkM4iPUBgy3PsLqAWcr8iYDR2W9u07Rg1Ek50uFwKPv3R8=
X-Gm-Message-State: AOJu0YxOJInL+C4iawMG1rdVX32/Do+QJRsd/kF5EcvcFSz61arlhgdG
 wJ6V5VXmr6ejvn06QA/vRwZBBaA8LHZdw32+p6anuOOLiO582dhiMDIGSXY6c70=
X-Google-Smtp-Source: AGHT+IGgqromNdxxuPDKvGImOUGZSIEUy6CvxU8dEDq1RdF/CV2Vp2Zf7FE1glk6mrOG6nxmrGq+Zg==
X-Received: by 2002:a5d:6751:0:b0:33d:50cd:4672 with SMTP id
 l17-20020a5d6751000000b0033d50cd4672mr1965853wrw.21.1710357216709; 
 Wed, 13 Mar 2024 12:13:36 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a5d526f000000b0033e7a102cfesm12286150wrc.64.2024.03.13.12.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 12:13:36 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:13:34 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 2/3] target/riscv: Expose sdtrig ISA extension
Message-ID: <20240313-e296698984d8f6fc914169a2@orel>
References: <20240313182009.608685-1-hchauhan@ventanamicro.com>
 <20240313182009.608685-3-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313182009.608685-3-hchauhan@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42b.google.com
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

On Wed, Mar 13, 2024 at 11:50:08PM +0530, Himanshu Chauhan wrote:
> This patch adds "sdtrig" in the ISA string when sdtrig extension is enabled.
> The sdtrig extension may or may not be implemented in a system. Therefore, the
>            -cpu rv64,sdtrig=<true/false>
> option can be used to dynamically turn sdtrig extension on or off.
> 
> Since, the sdtrig ISA extension is a superset of debug specification, disable
> the debug property when sdtrig is enabled. A warning is printed when this is
> done.
> 
> By default, the sdtrig extension is disabled and debug property enabled as usual.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2602aae9f5..e0710010f5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -175,6 +175,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
> @@ -1008,6 +1009,10 @@ static void riscv_cpu_reset_hold(Object *obj)
>      set_default_nan_mode(1, &env->fp_status);
>  
>  #ifndef CONFIG_USER_ONLY
> +    if (!cpu->cfg.debug && cpu->cfg.ext_sdtrig) {
> +	    cpu->cfg.debug = 1;

nit: '= true'

I also wonder if we need a warning here that says something like
"reenabling 'debug' since 'sdtrig' is enabled...", since the only way we'd
get here is if the user did 'debug=off,sdtrig=on'. But, I think I might be
OK with just silently ignoring that 'debug=off' too.

Thanks,
drew

> +    }
> +
>      if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
>          riscv_trigger_reset_hold(env);
>      }
> @@ -1480,6 +1485,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>      MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
>      MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
>  
> +    MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, false),
>      MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
>      MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
>      MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
> -- 
> 2.34.1
> 
> 

