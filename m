Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417EAC28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfNO-0002Lg-AV; Thu, 13 Mar 2025 06:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfNK-0002Hw-Up
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:01:15 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfNI-000853-2G
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:01:14 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so618703f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 03:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741860070; x=1742464870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v4j7ETWGosi5MlQXOvPpT3ZImee6Mk+7xoTJ/HKyf7k=;
 b=nt6uRICSvTOEez26SHcfWE3CSBpDjkp5g22XRvUYhj6S8SNQrXfkfCnHo9QaYmAkdD
 mOSZzrGrXjpDr59pYwkKbJLiyqqRNjljD9+ai0V/hJb3w/d1Fp18t3AkqeDkx2yt7vw1
 PpXHBD84wrYluGdwLDZRRESyGc5VbndK+izswK9dzIxY1jhJPPHNGJrYR2/NOrvtrCgJ
 fHGiNV0TmVT5cBvsNHFylUI8jpKScNfHagyOD9YniOu+moOr24ZrEB/y/DZp4qTRhWeP
 FnobAr5+zbDaYwPsWAxifc+YSiaNeT3czUBcjUZYwMEVtxUPE+R0CHZ6gAcMI9xH9EIg
 czOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741860070; x=1742464870;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v4j7ETWGosi5MlQXOvPpT3ZImee6Mk+7xoTJ/HKyf7k=;
 b=oDbDfDMohmBXRNrvaV8U2NGDCmBy06X8cKcj5fs2QWwygJwVQfceZpDncHQhsCm/gS
 U/gGrhu7bpGw/hJvnqrFuxHVDbkCDbzAMCeRAKjq2Oe19kij0cOWF/NKA6MzWY1pcsUo
 /HW5Amh4yRXbFN/ateHPJ317SBQpK0WIVpzEvraZH+RaaNAL2JesRWQdR6/S3Wf2bQST
 xCGwL3XXaMqBOzxcA5lq3me6LBwRfXBUogA+8DUpBqG5C4roNHeZb1V4X84ud35TEh3o
 l7f3mHHg1XAf6FNDx8CIuTvynqlQX9LS9Mz8dRP3cFr5Xdj4HELw8WdlNx8jMLmv6AvK
 DiWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6icrJXeihzmgqrx36p/vk8gTw77ba4LszD6TZL1+BMuS0TeZ8qmUdMkSGH1ynq2oIgdUCdHbLoAoa@nongnu.org
X-Gm-Message-State: AOJu0Yz/ucGwkCLy+18iOPvPCpD7VkBdoF+WDKxhfyR/TVQ32DjwFCqm
 dBrYcZ0GQhb8Pv72eP3PSA2clbi0/G4u24E+JVT9nE8fW1a0eRDi35VGTGJ1KWM=
X-Gm-Gg: ASbGnctdKlG2k09OmIDIuRrdytb2TmMsCFRu428+aOSw+3A3D4OIZsZOHLC/e+nOjPT
 Y4KCYiYKfPSAPq7LXurJloiEVt6e3ZAQDT1MtzmRB7ITJxpiaQVa054vjWwe5CBC8DoUdhZWRFo
 NGRekRUJBJatOz4oXict/ve55yY4O69RLt7hHyzLw+QE4Xe+tefgRAIxVPmxje8CtahPXtjgrYa
 k3FADLb9NqJtiPS+DHnZYXLBOTMRO1C/IM7W+lqgE1LE6Dk8PzGzpC0ddb9XvTSWI7sFEp1I+IX
 lgzspq5ciANk+shkSwpb39TGfhF8Sw+Y2pG96zM+Gk6GIg8Rys9SGFVQoHNcoYPMV4oRqbO3vPF
 0EaIo1Ybf3zhjFUI=
X-Google-Smtp-Source: AGHT+IErcaSGpDz8tqJyLiGYjUVGa/RunarDF+vzDjOwhKv8VRIMQ15gO1gNb7is9sOiczi3X7I1IA==
X-Received: by 2002:a05:6000:402a:b0:391:2dea:c9a5 with SMTP id
 ffacd0b85a97d-39132d6b61cmr19693847f8f.20.1741860070353; 
 Thu, 13 Mar 2025 03:01:10 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df3537sm1580827f8f.8.2025.03.13.03.01.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 03:01:09 -0700 (PDT)
Message-ID: <f5ad8905-b070-40cc-80d3-2abb797b7ecb@linaro.org>
Date: Thu, 13 Mar 2025 11:01:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/37] include/system: Move exec/address-spaces.h to
 system/address-spaces.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-16-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250313034524.3069690-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 13/3/25 04:44, Richard Henderson wrote:
> Convert the existing includes with sed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/net/i82596.h                           | 2 +-
>   hw/s390x/ipl.h                            | 2 +-
>   include/hw/misc/lasi.h                    | 2 +-
>   include/hw/nubus/nubus.h                  | 2 +-
>   include/hw/ppc/vof.h                      | 2 +-
>   include/hw/tricore/triboard.h             | 2 +-
>   include/{exec => system}/address-spaces.h | 8 ++------
>   include/system/dma.h                      | 2 +-
>   rust/wrapper.h                            | 2 +-
>   target/i386/hvf/vmx.h                     | 2 +-
>   accel/hvf/hvf-accel-ops.c                 | 2 +-
>   hw/acpi/erst.c                            | 2 +-
>   hw/arm/aspeed_ast10x0.c                   | 2 +-
>   hw/arm/bananapi_m2u.c                     | 2 +-
>   hw/arm/collie.c                           | 2 +-
>   hw/arm/exynos4_boards.c                   | 2 +-
>   hw/arm/fsl-imx31.c                        | 2 +-
>   hw/arm/fsl-imx8mp.c                       | 2 +-
>   hw/arm/imx8mp-evk.c                       | 2 +-
>   hw/arm/integratorcp.c                     | 2 +-
>   hw/arm/kzm.c                              | 2 +-
>   hw/arm/microbit.c                         | 2 +-
>   hw/arm/mps2-tz.c                          | 2 +-
>   hw/arm/mps2.c                             | 2 +-
>   hw/arm/mps3r.c                            | 2 +-
>   hw/arm/msf2-soc.c                         | 2 +-
>   hw/arm/msf2-som.c                         | 2 +-
>   hw/arm/musca.c                            | 2 +-
>   hw/arm/omap1.c                            | 2 +-
>   hw/arm/omap_sx1.c                         | 2 +-
>   hw/arm/orangepi.c                         | 2 +-
>   hw/arm/stellaris.c                        | 2 +-
>   hw/arm/stm32f100_soc.c                    | 2 +-
>   hw/arm/stm32f205_soc.c                    | 2 +-
>   hw/arm/stm32f405_soc.c                    | 2 +-
>   hw/arm/stm32l4x5_soc.c                    | 2 +-
>   hw/avr/atmega.c                           | 2 +-
>   hw/char/goldfish_tty.c                    | 2 +-
>   hw/char/omap_uart.c                       | 2 +-
>   hw/char/riscv_htif.c                      | 2 +-
>   hw/core/cpu-system.c                      | 2 +-
>   hw/core/null-machine.c                    | 2 +-
>   hw/core/sysbus.c                          | 2 +-
>   hw/dma/rc4030.c                           | 2 +-
>   hw/hyperv/hv-balloon.c                    | 2 +-
>   hw/hyperv/hyperv.c                        | 2 +-
>   hw/i386/kvm/xen_evtchn.c                  | 2 +-
>   hw/i386/kvm/xen_gnttab.c                  | 2 +-
>   hw/i386/kvm/xen_overlay.c                 | 2 +-
>   hw/i386/sgx-epc.c                         | 2 +-
>   hw/i386/sgx.c                             | 2 +-
>   hw/i386/vapic.c                           | 2 +-
>   hw/ide/ahci-sysbus.c                      | 2 +-
>   hw/input/lasips2.c                        | 2 +-
>   hw/intc/loongarch_extioi.c                | 2 +-
>   hw/intc/riscv_aplic.c                     | 2 +-
>   hw/intc/riscv_imsic.c                     | 2 +-
>   hw/loongarch/virt.c                       | 2 +-
>   hw/mem/memory-device.c                    | 2 +-
>   hw/microblaze/petalogix_ml605_mmu.c       | 2 +-
>   hw/microblaze/petalogix_s3adsp1800_mmu.c  | 2 +-
>   hw/microblaze/xlnx-zynqmp-pmu.c           | 2 +-
>   hw/mips/mipssim.c                         | 2 +-
>   hw/misc/allwinner-h3-dramc.c              | 2 +-
>   hw/misc/allwinner-r40-dramc.c             | 2 +-
>   hw/misc/ivshmem-flat.c                    | 2 +-
>   hw/misc/mac_via.c                         | 2 +-
>   hw/net/i82596.c                           | 2 +-
>   hw/nvram/fw_cfg.c                         | 2 +-
>   hw/openrisc/openrisc_sim.c                | 2 +-
>   hw/openrisc/virt.c                        | 2 +-
>   hw/pci-host/mv64361.c                     | 2 +-
>   hw/ppc/pegasos2.c                         | 2 +-
>   hw/ppc/pnv_psi.c                          | 2 +-
>   hw/ppc/ppc405_uc.c                        | 2 +-
>   hw/ppc/ppc4xx_sdram.c                     | 2 +-
>   hw/ppc/prep_systemio.c                    | 2 +-
>   hw/ppc/rs6000_mc.c                        | 2 +-
>   hw/ppc/spapr_ovec.c                       | 2 +-
>   hw/ppc/vof.c                              | 2 +-
>   hw/remote/iommu.c                         | 2 +-
>   hw/riscv/microblaze-v-generic.c           | 2 +-
>   hw/riscv/opentitan.c                      | 2 +-
>   hw/riscv/shakti_c.c                       | 2 +-
>   hw/s390x/css.c                            | 2 +-
>   hw/s390x/s390-skeys.c                     | 2 +-
>   hw/s390x/virtio-ccw.c                     | 2 +-
>   hw/sparc/sun4m_iommu.c                    | 2 +-
>   hw/sparc64/sun4u_iommu.c                  | 2 +-
>   hw/timer/hpet.c                           | 2 +-
>   hw/tpm/tpm_crb.c                          | 2 +-
>   hw/vfio/ap.c                              | 2 +-
>   hw/vfio/ccw.c                             | 2 +-
>   hw/vfio/common.c                          | 2 +-
>   hw/vfio/container.c                       | 2 +-
>   hw/vfio/platform.c                        | 2 +-
>   hw/vfio/spapr.c                           | 2 +-
>   hw/virtio/vhost-vdpa.c                    | 2 +-
>   hw/virtio/virtio-balloon.c                | 2 +-
>   hw/virtio/virtio-bus.c                    | 2 +-
>   monitor/hmp-cmds-target.c                 | 2 +-
>   monitor/hmp-cmds.c                        | 2 +-
>   system/ioport.c                           | 2 +-
>   system/memory.c                           | 2 +-
>   system/memory_mapping.c                   | 2 +-
>   target/arm/hvf/hvf.c                      | 2 +-
>   target/arm/kvm.c                          | 2 +-
>   target/avr/helper.c                       | 2 +-
>   target/i386/cpu-apic.c                    | 2 +-
>   target/i386/cpu.c                         | 2 +-
>   target/i386/kvm/xen-emu.c                 | 2 +-
>   target/i386/nvmm/nvmm-all.c               | 2 +-
>   target/i386/sev.c                         | 2 +-
>   target/i386/tcg/system/misc_helper.c      | 2 +-
>   target/i386/tcg/system/tcg-cpu.c          | 2 +-
>   target/i386/whpx/whpx-all.c               | 2 +-
>   target/loongarch/kvm/kvm.c                | 2 +-
>   target/riscv/kvm/kvm-cpu.c                | 2 +-
>   target/s390x/mmu_helper.c                 | 2 +-
>   target/s390x/sigp.c                       | 2 +-
>   target/s390x/tcg/excp_helper.c            | 2 +-
>   target/xtensa/dbg_helper.c                | 2 +-
>   hw/display/apple-gfx.m                    | 2 +-
>   123 files changed, 124 insertions(+), 128 deletions(-)
>   rename include/{exec => system}/address-spaces.h (89%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


