Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5704C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 08:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbFpy-0007Pq-3k; Tue, 06 Aug 2024 04:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sbFpu-0007Ni-Bj
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:46:31 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sbFpq-0005Id-OL
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:46:29 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5a15692b6f6so646604a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 01:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1722933984; x=1723538784; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SKdQO9lNmyotl+McUc4P8iXJ9E9PAcwhErPgAFsMpYs=;
 b=BR4H8w7u82gQlGf49VwM8WH7qGEcHJf1wZ1DsHoWjUjOxSIAkV2ysvPsJ755fLukAS
 IVViAGmqPA3mIauXrUe/I0TyJpEiIrk60Quwe5A6xwQ8vP7Dq3Wr3pgNfn35qF+BnNE0
 knyhQg/mWPf+huzKDgQK5QTjji6sRAuMLDVSj8q6TdRxFoiUMu1nTOwe71csdTzpeIba
 zwnAjOtQqlxHJ337x5PkaVE/y4k3Sn0HMajzQhgTOp4TnBuQmGudZmWpDkDUR05Eo/ye
 OVQ6YG8ubA5fTBqXwJ1B0jJOF3zt6JeTlmPlaNKhzaoVBTs/OxTOsgjfRhY0cEughiSc
 Fq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722933984; x=1723538784;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKdQO9lNmyotl+McUc4P8iXJ9E9PAcwhErPgAFsMpYs=;
 b=EsWzMEE8Qx3xv88TMj0mKs4hi2Z8/QlMzUhio6hk0AGNf20fiaCDDdoRWD8xJufgAw
 VZ1YJ1DIqLCjw86kwnap1HNpucQHjEOhjD5XETJRTKAaoGd5Y322pDY/BVOegtr3W/UY
 9rFUD/utYK5zd83tFS+kMDdLfATzBzOZMolFYc63WebjGLH+m6ESCFOxlTNA1P0W6+D4
 xhfY0X9MJYXyC1adz6ZuNPfst69gYTAk4dRCVSRdfs+LBtbeEOKrCtYTD0Gb8HoJUBbL
 ITnxO4HfzjggOYeyl3yM3IXIuzjcaocQ/7gUZCGadnpPI/hzwn2XsuCKMbBpNtpf7YZX
 pzqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL9+JdaodjQXnik7vTOf2DpDEUlDit6zPHUpX+DV0obM5J8Rms2DsLJLaNzyxHHi+XXAe5qH0IdhGFp3Js8CqHbPIbqds=
X-Gm-Message-State: AOJu0YxwRY5XljaGjCoDCNhgOfrrVhSEGDcXGU3qYkaYM3VXB7eGo1PB
 7p1ia9eJJ2vQX7EyKMGwlK6GNrBTKcdmw8DltIb6wXDTDLJG4/EZIO7SnLVnkh4=
X-Google-Smtp-Source: AGHT+IFpbmVW1SE0L5hsJRKURWX1Qt8C/umdeQIyl489IOmLI5YdjAlJqTk8Ybd9l7y6KnW9R7cf2g==
X-Received: by 2002:a17:907:7b87:b0:a72:4281:bc72 with SMTP id
 a640c23a62f3a-a7dc51014efmr1072772366b.63.1722933982984; 
 Tue, 06 Aug 2024 01:46:22 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d426e6sm524618666b.122.2024.08.06.01.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 01:46:22 -0700 (PDT)
Date: Tue, 6 Aug 2024 10:46:21 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Subject: Re: [PATCH v2 13/13] target/riscv: Enable PMU related extensions to
 preferred rule
Message-ID: <20240806-9fdad33468ec103d83a85e77@orel>
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-13-c4170a5348ca@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723-counter_delegation-v2-13-c4170a5348ca@rivosinc.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52f.google.com
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

On Tue, Jul 23, 2024 at 04:30:10PM GMT, Atish Patra wrote:
> Counter delegation/configuration extension requires the following
> extensions to be enabled.
> 
> 1. Smcdeleg - To enable counter delegation from M to S
> 2. S[m|s]csrind - To enable indirect access CSRs
> 3. Smstateen - Indirect CSR extensions depend on it.
> 4. Sscofpmf - To enable counter overflow feature
> 5. S[m|s]aia - To enable counter overflow feature in virtualization
> 6. Smcntrpmf - To enable privilege mode filtering for cycle/instret
> 
> While first 3 are mandatory to enable the counter delegation,
> next 3 set of extension are preferred to enable all the PMU related
> features.

Just my 2 cents, but I think for the first three we can apply the concept
of extension bundles, which we need for other extensions as well. In those
cases we just auto enable all the dependencies. For the three preferred
extensions I think we can just leave them off for 'base', but we should
enable them by default for 'max' along with Ssccfg.

Thanks,
drew

> That's why, enable all of these if Ssccfg extension is
> enabled from the commandline.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  target/riscv/cpu.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 22ba43c7ff2a..abebfcc46dea 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2665,8 +2665,20 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>      NULL
>  };
>  
> +static RISCVCPUPreferredExtsRule SSCCFG_PREFERRED = {
> +    .ext = CPU_CFG_OFFSET(ext_ssccfg),
> +    .preferred_multi_exts = {
> +        CPU_CFG_OFFSET(ext_smcsrind), CPU_CFG_OFFSET(ext_sscsrind),
> +        CPU_CFG_OFFSET(ext_ssaia), CPU_CFG_OFFSET(ext_smaia),
> +        CPU_CFG_OFFSET(ext_smstateen), CPU_CFG_OFFSET(ext_sscofpmf),
> +        CPU_CFG_OFFSET(ext_smcntrpmf), CPU_CFG_OFFSET(ext_smcdeleg),
> +
> +        RISCV_PREFRRED_EXTS_RULE_END
> +    },
> +};
> +
>  RISCVCPUPreferredExtsRule *riscv_multi_ext_preferred_rules[] = {
> -    NULL
> +    &SSCCFG_PREFERRED, NULL
>  };
>  
>  static Property riscv_cpu_properties[] = {
> 
> -- 
> 2.34.1
> 
> 

