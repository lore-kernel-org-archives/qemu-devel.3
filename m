Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13051C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 09:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVpim-000695-80; Fri, 02 Feb 2024 04:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rVpij-00068Z-22
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 04:20:25 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rVpih-0006nY-4P
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 04:20:24 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a3510d79ae9so245279766b.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 01:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706865621; x=1707470421; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OASn6kEoXyCoVKp97SPYUuVvkZbUtXfGlt7A7XeGah0=;
 b=CqPXM3WqypFYnFE/n1jGEFrU6cDS0uDq9cr1xheFbMbf1RZVSY+j/moFGRqmHJ46wo
 /TsC+dnRb7iROkXhSYR8G9ceO0/wzY18TKubeizjZTqievAVWa0CZejRwOJ1Zquz1dxy
 GoN6l3geNBCNubU/RxNhdaemUZlYxaFPxwFXSmC76Og/35ii5x0px14xAeIzyu5NzecL
 x7UK3dHV27q/hncs6rYwH4JiLFgoOuTt2HFd1ZIIEkMRfdk2EfeST/FvhEEd2VWKI/HG
 Ug1+a3sITqB5biIDAUP6DBwsVpNiMbZIzrPOVysxR/a8vkqtxP80RnftQOvahxEToI7E
 Lj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706865621; x=1707470421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OASn6kEoXyCoVKp97SPYUuVvkZbUtXfGlt7A7XeGah0=;
 b=CTCFDT8sNFxBmx/Pzcxv0VwY6AHeLfMDVT9hYkE6CPKVtW2nhs2TmstJ0R9ysoiTTs
 ZkWvh9/DDzKzEsRJNuRTqgXLXsDuzCTQQ55IZvfCQV1rBzR8kqSAqTNXdPDFeOsL1hJN
 2AzZPhjamuakwx8FzRFOUsJMlz3iuG8igaZ2YFOPfoP3+tEPcDbH9KtwI+QLVBe9XQb3
 Yc+W2ME7OUf59j+/cr62GxFqU1MqegmJtCF17GI99rqpfIn/om6c2ncJWlZWoV4grFgF
 6q1LDPZXT9tCTnnd5l7SPQaV9olfm5lUpxonWQE9VNFi7+qhFDhnwaBTTBBmxBwVLPkd
 i9sA==
X-Gm-Message-State: AOJu0YyWNZV+vtB0G+IBIZG4cPhx1yaNzsBXCPIefFMhPDxq6GYcfH1E
 O9jtylLT2wT4Glnp26BMRP7Ixb4bkDfVZB/QXwqLkg09WElKHOiy/70niv8ejYY=
X-Google-Smtp-Source: AGHT+IFw0mvUPYZPM6h4LMbPX3gUkT0qC3ve+B2OYzUg9rH4v8nVNcOmKCo7/qJyUfM0hSd8wSKepw==
X-Received: by 2002:a17:906:11d7:b0:a31:805b:4172 with SMTP id
 o23-20020a17090611d700b00a31805b4172mr4896355eja.9.1706865621592; 
 Fri, 02 Feb 2024 01:20:21 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW31307NIMcCIoggQQaNTGK9bMadK0OZNQL8QOSajdTzG2JtTd/xygvUTLv2ruA+p/6X5XLpZ69VGh9ArYq+5A+KjjVGuk=
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 mf17-20020a170906cb9100b00a3535b76c42sm691488ejb.15.2024.02.02.01.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 01:20:21 -0800 (PST)
Date: Fri, 2 Feb 2024 10:20:20 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: Re: [PATCH] RISC-V: Report the QEMU vendor/arch IDs on virtual
 CPUs
Message-ID: <20240202-13177c2e19ebcf62d96b3e67@orel>
References: <20240131182430.20174-1-palmer@rivosinc.com>
 <20240201-65329fd8836e03549298b340@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-65329fd8836e03549298b340@orel>
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62e.google.com
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

On Thu, Feb 01, 2024 at 04:06:15PM +0100, Andrew Jones wrote:
> On Wed, Jan 31, 2024 at 10:24:30AM -0800, Palmer Dabbelt wrote:
> > Right now we just report 0 for marchid/mvendorid in QEMU.  That's legal,
> > but it's tricky for users that want to check if they're running on QEMU
> > to do so.  This sets marchid to 42, which I've proposed as the QEMU
> > architecture ID (mvendorid remains 0, just explicitly set, as that's how
> > the ISA handles open source implementations).
> 
> Hi Palmer,
> 
> marchid has this text
> 
> """
> Open-source project architecture IDs are allocated globally by RISC-V
> International, and have non-zero architecture IDs with a zero
> most-significant-bit (MSB). Commercial architecture IDs are allocated
> by each commercial vendor independently, but must have the MSB set and
> cannot contain zero in the remaining MXLEN-1 bits.
> """
> 
> and mvendorid has this text
> 
> """
> ...a value of 0 can be
> returned to indicate the field is not implemented or that this is a
> non-commercial implementation.
> """
> 
> We must select zero for mvendorid, since we're a non-commercial
> implementation, and that means we can't set the marchid to a commercial
> ID of our choosing, i.e. some ID with the MSB set. We also can't select
> an archid without the MSB set, though, because RVI needs to allocate
> us that ID. Long story short, I think we need to use mvendorid=0,marchid=0
> unless we ask for and receive an marchid from RVI. Now, looking at mimpid,
> I think we're free to set that to whatever we want, even if the other IDs
> must be zero, but we should probably consider if we also want some bits
> reserved for revisions or something before settling on an ID. Actually,
> my vote would be to get an official marchid from RVI and then mimpid can
> be reserved for other uses.

So it looks like my vote was the plan all along :-) After reading
Alistair's "this has been approved" comment regarding the Link below I
actually bothered to check it and see that 42 is indeed the official RVI
marchid. That wasn't clear to me from the commit message, but I guess I
should have clicked the link!

Sorry for the noise.

Thanks,
drew

> 
> Thanks,
> drew
> 
> 
> 
> > 
> > Link: https://github.com/riscv/riscv-isa-manual/pull/1213
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > ---
> >  target/riscv/cpu.c          | 16 ++++++++++++++++
> >  target/riscv/cpu_vendorid.h |  3 +++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 8cbfc7e781..1aef186f87 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -415,6 +415,9 @@ static void riscv_any_cpu_init(Object *obj)
> >      cpu->cfg.ext_zicsr = true;
> >      cpu->cfg.mmu = true;
> >      cpu->cfg.pmp = true;
> > +
> > +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> > +    cpu->cfg.marchid = QEMU_MARCHID;
> >  }
> >  
> >  static void riscv_max_cpu_init(Object *obj)
> > @@ -432,6 +435,8 @@ static void riscv_max_cpu_init(Object *obj)
> >      set_satp_mode_max_supported(RISCV_CPU(obj), mlx == MXL_RV32 ?
> >                                  VM_1_10_SV32 : VM_1_10_SV57);
> >  #endif
> > +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> > +    cpu->cfg.marchid = QEMU_MARCHID;
> >  }
> >  
> >  #if defined(TARGET_RISCV64)
> > @@ -445,6 +450,8 @@ static void rv64_base_cpu_init(Object *obj)
> >  #ifndef CONFIG_USER_ONLY
> >      set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
> >  #endif
> > +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> > +    cpu->cfg.marchid = QEMU_MARCHID;
> >  }
> >  
> >  static void rv64_sifive_u_cpu_init(Object *obj)
> > @@ -569,6 +576,8 @@ static void rv128_base_cpu_init(Object *obj)
> >  #ifndef CONFIG_USER_ONLY
> >      set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
> >  #endif
> > +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> > +    cpu->cfg.marchid = QEMU_MARCHID;
> >  }
> >  
> >  static void rv64i_bare_cpu_init(Object *obj)
> > @@ -591,6 +600,8 @@ static void rv64i_bare_cpu_init(Object *obj)
> >  #ifndef CONFIG_USER_ONLY
> >      set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV64);
> >  #endif
> > +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> > +    cpu->cfg.marchid = QEMU_MARCHID;
> >  }
> >  #else
> >  static void rv32_base_cpu_init(Object *obj)
> > @@ -603,6 +614,8 @@ static void rv32_base_cpu_init(Object *obj)
> >  #ifndef CONFIG_USER_ONLY
> >      set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
> >  #endif
> > +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> > +    cpu->cfg.marchid = QEMU_MARCHID;
> >  }
> >  
> >  static void rv32_sifive_u_cpu_init(Object *obj)
> > @@ -672,6 +685,9 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
> >      cpu->cfg.ext_zifencei = true;
> >      cpu->cfg.ext_zicsr = true;
> >      cpu->cfg.pmp = true;
> > +
> > +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> > +    cpu->cfg.marchid = QEMU_MARCHID;
> >  }
> >  #endif
> >  
> > diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
> > index 96b6b9c2cb..486832cd53 100644
> > --- a/target/riscv/cpu_vendorid.h
> > +++ b/target/riscv/cpu_vendorid.h
> > @@ -7,4 +7,7 @@
> >  #define VEYRON_V1_MIMPID        0x111
> >  #define VEYRON_V1_MVENDORID     0x61f
> >  
> > +#define QEMU_VIRT_MVENDORID     0
> > +#define QEMU_VIRT_MARCHID       42
> > +
> >  #endif /*  TARGET_RISCV_CPU_VENDORID_H */
> > -- 
> > 2.43.0
> > 
> > 

