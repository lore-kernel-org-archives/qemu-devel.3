Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA7CC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 13:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSd4Q-0004bt-3t; Wed, 24 Jan 2024 08:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rSd4P-0004bX-2R
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:13:33 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rSd4L-0004rM-DQ
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:13:32 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e60e135a7so53147295e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 05:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706102008; x=1706706808; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nKfuwYN2xEU+qQ/qctQ+qsY+IQW2fcQu4LKBLFIQxTA=;
 b=mOLcPlhuCxWxKu+6OH5C6f3X4PXyFHTj16EpRDLbiSyXQfH32RZEEZVLPegQTFBSx9
 Q90nz5xbk6b9B9zqKIiSONWh2RIhPxAt3u2eZjZmAFbRYzx0nZLYcKBuPOhg6a2wE4vy
 8s3xvOaFdYAf7MhLPN2ErKrlU77738jZqz/oXjsq01r5YcIFDPUbNfATHcBBBiexaRkq
 JozyXvfZPwKzupKqgX/eYUAa0x61TWR0xnsWSFGw3T49q4OGvTE0r068Trqa8uEcs8Ti
 kuZ8cn7aD+t7dU7dquFS0PekHsT06vjI9IYwjEPKtEbwBmzpJb7Acg18nrxup8g1zabC
 7/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706102008; x=1706706808;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKfuwYN2xEU+qQ/qctQ+qsY+IQW2fcQu4LKBLFIQxTA=;
 b=tdLDz9VGnfU4G+/klBZLBAcyjZ+twf4R3zY9cmxd/bIy1mhEvcqqdRz4TpTKRvJ1vA
 7zMkWJaBkRhXgeyFo5sWwL/TzbGzWkUfMEW3Cas0ydTkTGIE4/ISaYARLSUCiekMrZ7X
 +7ifoG1jeB2PEykfbbW2GisfN3OdQXY9H1bYwDmSaRONMYR26oCifYvBDfb1RuZXtD5O
 C686dCHEyvlzgrnXMmlEVcEtUhj+SmKvIYWgYbv2tHD9OCckpkzmO7xajy2f72lMlE6Y
 S2Arp4sSTZQxaaKCo1d2HcfGGanTpiiWo1ksguQU8646RKLlUKjgY3/Aa21pl/cvBdwA
 DrxA==
X-Gm-Message-State: AOJu0YxYdzGNiCT4uc37uvSp23G28yrMoiy2Xx7LkZXSNPd7rjbbt6Xj
 pIaF0ywTSYnqoozOW1YNlk/vTRJ0vbPFijntqdNxMUwPryT2d4Rz04zgiH1TFZM=
X-Google-Smtp-Source: AGHT+IGyvthcWGuJnnkqhZMj1rjBzM2LpUOGa9RuNIRdyv3CZpU6RZKZW5P+RBWAimQlPPQIdqAZEQ==
X-Received: by 2002:a7b:cd0a:0:b0:40e:66cf:81a9 with SMTP id
 f10-20020a7bcd0a000000b0040e66cf81a9mr1752290wmj.111.1706102007764; 
 Wed, 24 Jan 2024 05:13:27 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 je6-20020a05600c1f8600b0040d8d11bf63sm46004648wmb.41.2024.01.24.05.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 05:13:27 -0800 (PST)
Date: Wed, 24 Jan 2024 14:13:26 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor@kernel.org>
Cc: qemu-riscv@nongnu.org, Conor Dooley <conor.dooley@microchip.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 1/2] target/riscv: use misa_mxl_max to populate isa
 string rather than TARGET_LONG_BITS
Message-ID: <20240124-384b3a560423a271aa2e819a@orel>
References: <20240124-squatting-getup-a16a8499ad73@spud>
 <20240124-swear-monthly-56c281f809a6@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124-swear-monthly-56c281f809a6@spud>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32c.google.com
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

On Wed, Jan 24, 2024 at 12:55:49PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> A cpu may not have the same xlen as the compile time target, and
> misa_mxl_max is the source of truth for what the hart supports.
> 
> The conversion from misa_mxl_max to xlen already has one user, so
> introduce a helper and use that to populate the isa string.
> 
> Link: https://lore.kernel.org/qemu-riscv/20240108-efa3f83dcd3997dc0af458d7@orel/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I dropped the tags since I added the helper
> ---
>  target/riscv/cpu.c     | 9 ++++++++-
>  target/riscv/cpu.h     | 1 +
>  target/riscv/gdbstub.c | 2 +-
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ad1df2318b..4aa4b2e988 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -307,6 +307,11 @@ void riscv_cpu_set_misa(CPURISCVState *env, RISCVMXL mxl, uint32_t ext)
>      env->misa_ext_mask = env->misa_ext = ext;
>  }
>  
> +int riscv_cpu_max_xlen(CPURISCVState env)
> +{
> +    return 16 << env.misa_mxl_max;
> +}

Something like this could probably be a static inline in the header.

> +
>  #ifndef CONFIG_USER_ONLY
>  static uint8_t satp_mode_from_str(const char *satp_mode_str)
>  {
> @@ -2332,7 +2337,9 @@ char *riscv_isa_string(RISCVCPU *cpu)
>      int i;
>      const size_t maxlen = sizeof("rv128") + sizeof(riscv_single_letter_exts);
>      char *isa_str = g_new(char, maxlen);
> -    char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", TARGET_LONG_BITS);
> +    int xlen = riscv_cpu_max_xlen(cpu->env);
> +    char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", xlen);
> +
>      for (i = 0; i < sizeof(riscv_single_letter_exts) - 1; i++) {
>          if (cpu->env.misa_ext & RV(riscv_single_letter_exts[i])) {
>              *p++ = qemu_tolower(riscv_single_letter_exts[i]);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 05e83c4ac9..aacc031397 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -511,6 +511,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                          MMUAccessType access_type, int mmu_idx,
>                          bool probe, uintptr_t retaddr);
>  char *riscv_isa_string(RISCVCPU *cpu);
> +int riscv_cpu_max_xlen(CPURISCVState env);
>  bool riscv_cpu_option_set(const char *optname);
>  
>  #define cpu_mmu_index riscv_cpu_mmu_index
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 58b3ace0fe..f15980fdcf 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -218,7 +218,7 @@ static int riscv_gen_dynamic_csr_xml(CPUState *cs, int base_reg)
>      CPURISCVState *env = &cpu->env;
>      GString *s = g_string_new(NULL);
>      riscv_csr_predicate_fn predicate;
> -    int bitsize = 16 << env->misa_mxl_max;
> +    int bitsize = riscv_cpu_max_xlen(*env);
>      int i;
>  
>  #if !defined(CONFIG_USER_ONLY)
> -- 
> 2.43.0
> 

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

