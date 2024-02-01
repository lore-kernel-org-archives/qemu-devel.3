Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6285C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 15:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVYdz-0006nW-Qy; Thu, 01 Feb 2024 10:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rVYdy-0006mV-Li
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:06:22 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rVYdw-00038m-Er
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 10:06:22 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a357cba4a32so139031066b.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 07:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706799977; x=1707404777; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ydodzi5mkvIz5Auw1VR9isoTRD7y8azWMN5eCfOjOF0=;
 b=FXRVASPJ4qucc0MmM0o9xum++FI4PZ98SYQNgwrayqulJbWNpYr5EcT6F3ZtU2DJgm
 CoAp1LpZoGj07+hFV0ubedEx6xzrdExsfg87gXv2sdvTrHNf5HYyj6YBTnLq78NnoTxF
 jiSiWDYt3oy8e50HBKxZs59lZ42ajorQYpEidmcesMVDMSQ6Q0xIdsBHt0TKIP0N1X9z
 b1iv9oqj72uWxXNYg+925DCWBN4ftJwGDb+a3H5q4rlbHEaZwiv+xYXw3hnMcehVA4Px
 rLck8wnS/4OODssWveUSqTJmbYVSPr+Rwc2rbWnY17FXg1f+zSCeDRyZp/2gGfU0aeX2
 TKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706799977; x=1707404777;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ydodzi5mkvIz5Auw1VR9isoTRD7y8azWMN5eCfOjOF0=;
 b=GK2QcOZmHeBEPE1QHKn9njWbAaRMcofUMDN9s1MMq/XFLKWX9NiBnssE1xd3Ifipcr
 DpfNLADU8UkadrUfwP9i+c5c750i92mhA9VLa8KzbU6KjizvP2TS+bJxQyeUOfkt6GaC
 9ISvZF4KxJdGZyFYn9/rXSrqHinX93fefFJoSYQ5sdNqkoMRCfH/O+2dHAdCjSO5QTlV
 mF1hTDFU70D4KfGf+TfWXJE7ivQx8aaNXuDEwytnVTDMB7OsVze7tpRmC9H/34gGrS0u
 a282NgEGWhzrxf3sQ2V3jizpBxRwKqGF8jlilv9alIM7i6x/b3OjYIPIgMK60XzuA5Yl
 uWxQ==
X-Gm-Message-State: AOJu0Yx91RUvkZv0kpchB/cAeNyLK/i0zjiHCUCphMuYT6HpF/4AlpaN
 nEZmxtHWv9AAOE5tZOAGR36tsBSVTOSQtGmQ8nnzm7BN5HzjzzrP3aZhKEfhYqIflWdYu3Hc9xR
 0
X-Google-Smtp-Source: AGHT+IE8sD+VdVVE7FFoCQVjCTmbbhNHmt2sqqgsRrLwvlbD7DZIaHNx6CbxE2JNh3hF3G+szMXvdA==
X-Received: by 2002:a17:906:408b:b0:a36:3edb:aeac with SMTP id
 u11-20020a170906408b00b00a363edbaeacmr2217948ejj.17.1706799977076; 
 Thu, 01 Feb 2024 07:06:17 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW3A1XS/cQlV8EzzwB6cq0s5gVWNKTEWASrx1xq41Fys63qEU7WOr8g3ICi4rl/m8f8ubbs854AUjEnTcPsKcL1Vnm13oQ=
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 vw16-20020a170907a71000b00a354f8fc19fsm5982481ejc.214.2024.02.01.07.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 07:06:16 -0800 (PST)
Date: Thu, 1 Feb 2024 16:06:15 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] RISC-V: Report the QEMU vendor/arch IDs on virtual CPUs
Message-ID: <20240201-65329fd8836e03549298b340@orel>
References: <20240131182430.20174-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131182430.20174-1-palmer@rivosinc.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x633.google.com
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

On Wed, Jan 31, 2024 at 10:24:30AM -0800, Palmer Dabbelt wrote:
> Right now we just report 0 for marchid/mvendorid in QEMU.  That's legal,
> but it's tricky for users that want to check if they're running on QEMU
> to do so.  This sets marchid to 42, which I've proposed as the QEMU
> architecture ID (mvendorid remains 0, just explicitly set, as that's how
> the ISA handles open source implementations).

Hi Palmer,

marchid has this text

"""
Open-source project architecture IDs are allocated globally by RISC-V
International, and have non-zero architecture IDs with a zero
most-significant-bit (MSB). Commercial architecture IDs are allocated
by each commercial vendor independently, but must have the MSB set and
cannot contain zero in the remaining MXLEN-1 bits.
"""

and mvendorid has this text

"""
...a value of 0 can be
returned to indicate the field is not implemented or that this is a
non-commercial implementation.
"""

We must select zero for mvendorid, since we're a non-commercial
implementation, and that means we can't set the marchid to a commercial
ID of our choosing, i.e. some ID with the MSB set. We also can't select
an archid without the MSB set, though, because RVI needs to allocate
us that ID. Long story short, I think we need to use mvendorid=0,marchid=0
unless we ask for and receive an marchid from RVI. Now, looking at mimpid,
I think we're free to set that to whatever we want, even if the other IDs
must be zero, but we should probably consider if we also want some bits
reserved for revisions or something before settling on an ID. Actually,
my vote would be to get an official marchid from RVI and then mimpid can
be reserved for other uses.

Thanks,
drew



> 
> Link: https://github.com/riscv/riscv-isa-manual/pull/1213
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  target/riscv/cpu.c          | 16 ++++++++++++++++
>  target/riscv/cpu_vendorid.h |  3 +++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8cbfc7e781..1aef186f87 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -415,6 +415,9 @@ static void riscv_any_cpu_init(Object *obj)
>      cpu->cfg.ext_zicsr = true;
>      cpu->cfg.mmu = true;
>      cpu->cfg.pmp = true;
> +
> +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> +    cpu->cfg.marchid = QEMU_MARCHID;
>  }
>  
>  static void riscv_max_cpu_init(Object *obj)
> @@ -432,6 +435,8 @@ static void riscv_max_cpu_init(Object *obj)
>      set_satp_mode_max_supported(RISCV_CPU(obj), mlx == MXL_RV32 ?
>                                  VM_1_10_SV32 : VM_1_10_SV57);
>  #endif
> +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> +    cpu->cfg.marchid = QEMU_MARCHID;
>  }
>  
>  #if defined(TARGET_RISCV64)
> @@ -445,6 +450,8 @@ static void rv64_base_cpu_init(Object *obj)
>  #ifndef CONFIG_USER_ONLY
>      set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
>  #endif
> +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> +    cpu->cfg.marchid = QEMU_MARCHID;
>  }
>  
>  static void rv64_sifive_u_cpu_init(Object *obj)
> @@ -569,6 +576,8 @@ static void rv128_base_cpu_init(Object *obj)
>  #ifndef CONFIG_USER_ONLY
>      set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
>  #endif
> +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> +    cpu->cfg.marchid = QEMU_MARCHID;
>  }
>  
>  static void rv64i_bare_cpu_init(Object *obj)
> @@ -591,6 +600,8 @@ static void rv64i_bare_cpu_init(Object *obj)
>  #ifndef CONFIG_USER_ONLY
>      set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV64);
>  #endif
> +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> +    cpu->cfg.marchid = QEMU_MARCHID;
>  }
>  #else
>  static void rv32_base_cpu_init(Object *obj)
> @@ -603,6 +614,8 @@ static void rv32_base_cpu_init(Object *obj)
>  #ifndef CONFIG_USER_ONLY
>      set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
>  #endif
> +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> +    cpu->cfg.marchid = QEMU_MARCHID;
>  }
>  
>  static void rv32_sifive_u_cpu_init(Object *obj)
> @@ -672,6 +685,9 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
>      cpu->cfg.ext_zifencei = true;
>      cpu->cfg.ext_zicsr = true;
>      cpu->cfg.pmp = true;
> +
> +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> +    cpu->cfg.marchid = QEMU_MARCHID;
>  }
>  #endif
>  
> diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
> index 96b6b9c2cb..486832cd53 100644
> --- a/target/riscv/cpu_vendorid.h
> +++ b/target/riscv/cpu_vendorid.h
> @@ -7,4 +7,7 @@
>  #define VEYRON_V1_MIMPID        0x111
>  #define VEYRON_V1_MVENDORID     0x61f
>  
> +#define QEMU_VIRT_MVENDORID     0
> +#define QEMU_VIRT_MARCHID       42
> +
>  #endif /*  TARGET_RISCV_CPU_VENDORID_H */
> -- 
> 2.43.0
> 
> 

