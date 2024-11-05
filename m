Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCCCD40CE0
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SZB-0006EU-IS; Tue, 05 Nov 2024 18:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SZ8-0006E3-O4; Tue, 05 Nov 2024 18:02:26 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SZ7-0007Od-1n; Tue, 05 Nov 2024 18:02:26 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso51067665e9.1; 
 Tue, 05 Nov 2024 15:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730847743; x=1731452543; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+1zRsQOSlz5lLxWp81jnxAZHaOYR3Y4jOwTntP9DeL0=;
 b=XNgCBFMscZCXE2rcZkMkgiOJAunrdmG6UI9IIQrgECbS4S3EphZIJ7/jkrU5xRfBvL
 M3Jo6y7svc6n0T4gdYo7TEcLWZb2zkweX22hDUNMZsO5ESUF85Nzb2N2XAfBVYVJTNfz
 PqcH2JsfUpKPayWEdxIDnIKKG910uH9RoVgzds2oBQUYlzoZPJnLc78InWylDfF8nt8C
 ia0eWyOz+6q9DMNc8toFUIG8jNBJgbkReT/+UWURxKiH74RDiDX1MqK6Jqjh6BrVHZsZ
 E1EfL20Sp5DrBIqR/Sxv8D2liq2w66Opyupt8vpBWHJgE05kPEwwqNV9nO3/52jr9YNZ
 mPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730847743; x=1731452543;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+1zRsQOSlz5lLxWp81jnxAZHaOYR3Y4jOwTntP9DeL0=;
 b=OTWb4PFU6Iwm6xexw4G+x6K70OB/9BPTERr9fFyruEDLss0YgTmusevE7P7IdQSkCE
 uctlDM8o0wwaP8kE0UoGVutiWZotmM7gbtiQMPu+FTaw1lpFU8amp5VsRbe+PtiLSmwv
 +Y5Qj8lCHr+PfFkpRJ7X3ARgA72mxV4YgjhiilF5uXQknv+RNJGk0h8qBXXNUwOASI7i
 nwp/2u7eL7q9TkJWucrFVTO45a3eYXX8Bj2xGcSalyIsj8qBHCCclG8i81/EHXAWWhhL
 EkponmO8qWl64WxRJjJBkybuJNu5/4j0dTXjUnn32loS9EZIzqNPuq2VT3zDZV1qpanK
 sjgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVHQsOYOyM6FXVmKCuHHwIihBxaM7VGHTUDyU4WxRioeeVk2zRnsS/MPdO88B7LDpXOCLkZ53QHA==@nongnu.org
X-Gm-Message-State: AOJu0YxuEOuH9oUKcRQaFW32Nu5CF+b3g2oZ1KI3RG/RfOwLeSF2S9F+
 I3vMjqN2OixfokqflsQ7xI1oOohKhGhwVlEhELRXhgbeJKuwVf0u
X-Google-Smtp-Source: AGHT+IGddxc8Qp1XCFCYSOw3TVflbqngeXcey5ZutrtvjPuV58f3+ZmFp6UfFWCS8MfxuIX663f3sQ==
X-Received: by 2002:a05:600c:35cf:b0:431:3b53:105e with SMTP id
 5b1f17b1804b1-43283244e02mr157282855e9.9.1730847742928; 
 Tue, 05 Nov 2024 15:02:22 -0800 (PST)
Received: from gmail.com ([89.101.60.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e734csm17386214f8f.60.2024.11.05.15.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 15:02:22 -0800 (PST)
Date: Wed, 6 Nov 2024 00:02:22 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 08/19] hw/microblaze: Propagate CPU endianness to
 microblaze_load_kernel()
Message-ID: <Zyqj_mB8pkuQ2rG4@zapote>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105130431.22564-9-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Nov 05, 2024 at 02:04:20PM +0100, Philippe Mathieu-Daudé wrote:
> Pass vCPU endianness as argument so we can load kernels
> with different endianness (different from the qemu-system-binary
> builtin one).

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/microblaze/boot.h                     | 4 ++--
>  hw/microblaze/boot.c                     | 8 ++++----
>  hw/microblaze/petalogix_ml605_mmu.c      | 2 +-
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 +-
>  hw/microblaze/xlnx-zynqmp-pmu.c          | 2 +-
>  5 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/microblaze/boot.h b/hw/microblaze/boot.h
> index 5a8c2f79750..d179a551a69 100644
> --- a/hw/microblaze/boot.h
> +++ b/hw/microblaze/boot.h
> @@ -2,8 +2,8 @@
>  #define MICROBLAZE_BOOT_H
>  
>  
> -void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
> -                            uint32_t ramsize,
> +void microblaze_load_kernel(MicroBlazeCPU *cpu, bool is_little_endian,
> +                            hwaddr ddr_base, uint32_t ramsize,
>                              const char *initrd_filename,
>                              const char *dtb_filename,
>                              void (*machine_cpu_reset)(MicroBlazeCPU *));
> diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
> index ed61e483ee8..3675489fa5b 100644
> --- a/hw/microblaze/boot.c
> +++ b/hw/microblaze/boot.c
> @@ -114,8 +114,8 @@ static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
>      return addr - 0x30000000LL;
>  }
>  
> -void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
> -                            uint32_t ramsize,
> +void microblaze_load_kernel(MicroBlazeCPU *cpu, bool is_little_endian,
> +                            hwaddr ddr_base, uint32_t ramsize,
>                              const char *initrd_filename,
>                              const char *dtb_filename,
>                              void (*machine_cpu_reset)(MicroBlazeCPU *))
> @@ -144,13 +144,13 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
>          /* Boots a kernel elf binary.  */
>          kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
>                                 &entry, NULL, &high, NULL,
> -                               TARGET_BIG_ENDIAN, EM_MICROBLAZE, 0, 0);
> +                               !is_little_endian, EM_MICROBLAZE, 0, 0);
>          base32 = entry;
>          if (base32 == 0xc0000000) {
>              kernel_size = load_elf(kernel_filename, NULL,
>                                     translate_kernel_address, NULL,
>                                     &entry, NULL, NULL, NULL,
> -                                   TARGET_BIG_ENDIAN, EM_MICROBLAZE, 0, 0);
> +                                   !is_little_endian, EM_MICROBLAZE, 0, 0);
>          }
>          /* Always boot into physical ram.  */
>          boot_info.bootstrap_pc = (uint32_t)entry;
> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
> index 61e47d83988..d2b2109065d 100644
> --- a/hw/microblaze/petalogix_ml605_mmu.c
> +++ b/hw/microblaze/petalogix_ml605_mmu.c
> @@ -204,7 +204,7 @@ petalogix_ml605_init(MachineState *machine)
>      cpu->cfg.pvr_regs[5] = 0xc56be000;
>      cpu->cfg.pvr_regs[10] = 0x0e000000; /* virtex 6 */
>  
> -    microblaze_load_kernel(cpu, MEMORY_BASEADDR, ram_size,
> +    microblaze_load_kernel(cpu, true, MEMORY_BASEADDR, ram_size,
>                             machine->initrd_filename,
>                             BINARY_DEVICE_TREE_FILE,
>                             NULL);
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> index 6c0f5c6c651..8110be83715 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -129,7 +129,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>  
>      create_unimplemented_device("xps_gpio", GPIO_BASEADDR, 0x10000);
>  
> -    microblaze_load_kernel(cpu, ddr_base, ram_size,
> +    microblaze_load_kernel(cpu, !TARGET_BIG_ENDIAN, ddr_base, ram_size,
>                             machine->initrd_filename,
>                             BINARY_DEVICE_TREE_FILE,
>                             NULL);
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
> index 567aad47bfc..bdbf7328bf4 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -172,7 +172,7 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
>      qdev_realize(DEVICE(pmu), NULL, &error_fatal);
>  
>      /* Load the kernel */
> -    microblaze_load_kernel(&pmu->cpu, XLNX_ZYNQMP_PMU_RAM_ADDR,
> +    microblaze_load_kernel(&pmu->cpu, true, XLNX_ZYNQMP_PMU_RAM_ADDR,
>                             machine->ram_size,
>                             machine->initrd_filename,
>                             machine->dtb,
> -- 
> 2.45.2
> 

