Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1EEC54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 19:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkqn6-0004Bx-I3; Thu, 14 Mar 2024 15:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkqmw-00049w-5a
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 15:30:54 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkqmt-0006ck-Cg
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 15:30:49 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a467322d52eso124481466b.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 12:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710444645; x=1711049445; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ulZAaVKJTw9X2UKdX4yyunm97F08ExefyaVwt+nR5AI=;
 b=AHV7tC08JS4jPtz8fJ08dlw8Zfzh3LoP6cDgGbsHcCdCNXyvsPYME2/0p4gVchbnp1
 S7f/i0fU9R3f7AbOpLLnSSQnd3wvp+MMKTO/F9ip/f2KM2DjMuE/tg9v4lcMazcQK52N
 /saZyHhvmQC/kYGCozWeZFUr/1kWKLDpgKFVDjrXpxegvcVe/7XiDoM3Gz6xHkmRfJbq
 72vBeHr5zPww23qr1I8KoHtVMGwwFIRtMGuMF4T/UoMb+zhr131yPno5vHOPsOCdUW+h
 9820VdhKzM8gDWu6aK0tbFBDXtWQbic6zfzdhNgbMNRsUr2g8nBbOgMOJWUkSRCN1yED
 liaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710444645; x=1711049445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulZAaVKJTw9X2UKdX4yyunm97F08ExefyaVwt+nR5AI=;
 b=t8mfdqd0TBug7hHlRjLWhwEucgY7CFMRsLstUPgCLCKPCU4hyZqQen935sqx5PFlYE
 ptNYdNVHYB4MvNG3y3dKhx6mcgBGmrA3J56wFeE1KZJI8kq/URTHkeaN53busA5swRDE
 2TjroDySiNwzL2HvNC6sHgT2MzpM8H95AP6gALB8Fcu9WX7+LY9SBysVkMC1xixXdLJu
 JR8dgxWM1qsCYePMIDpmVMU9iXteNVuRRbZNCA3bOyIzSUgNhZ1NTltM6frBaWn2ZxFJ
 f7NE4hQKVnCipYQDNiDIwHeQ30CkbY5EOcWMDI4+YgxZwSV+yZA7/+BY9kBcpIfC2evr
 TscA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+95LRjwsX/aL5tTIJoCiM0t2zTKkaFKDb4iri9IGDXdn39Q9N2iP4eIhSRB13Hs3zA/Ppa0nxtcKhXBCEIk/8JeltF8o=
X-Gm-Message-State: AOJu0YwbgoVgHwAK4OzvZxDSJzDniSTTE0xpfsUXb2/1qvTQOka6rdYU
 ARuTDsVN57498Eybt6Chy/yzldZVywIxujmzY7vr4EkMCkT3tiiFWp8duzSoAyA=
X-Google-Smtp-Source: AGHT+IESEQutNnmvX6fcJ8I7wle1QrZxFfSA6Lo84I0NKSlyuV2ST1wLOabfGjQh4TvzCosO75JMBw==
X-Received: by 2002:a17:907:1689:b0:a46:755b:ddf3 with SMTP id
 cx9-20020a170907168900b00a46755bddf3mr1681001ejd.21.1710444644964; 
 Thu, 14 Mar 2024 12:30:44 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 ci11-20020a170906c34b00b00a466ec7eb11sm974868ejb.43.2024.03.14.12.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 12:30:44 -0700 (PDT)
Date: Thu, 14 Mar 2024 20:30:43 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v7 3/4] target/riscv: Expose sdtrig ISA extension
Message-ID: <20240314-98842e47b5be1cdc22657450@orel>
References: <20240314185957.36940-1-hchauhan@ventanamicro.com>
 <20240314185957.36940-4-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314185957.36940-4-hchauhan@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x632.google.com
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

On Fri, Mar 15, 2024 at 12:29:56AM +0530, Himanshu Chauhan wrote:
> This patch adds "sdtrig" in the ISA string when sdtrig extension is enabled.
> The sdtrig extension may or may not be implemented in a system. Therefore, the
>            -cpu rv64,sdtrig=<true/false>
> option can be used to dynamically turn sdtrig extension on or off.
> 
> By default, the sdtrig extension is disabled and debug property enabled as usual.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ab631500ac..4231f36c1b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -175,6 +175,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),

So we're sure this should be 1.12? Or do we need to introduce
PRIV_VERSION_1_13_0?

>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
> @@ -1485,6 +1486,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
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

Thanks,
drew

