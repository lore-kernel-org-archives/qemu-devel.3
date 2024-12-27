Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFFFE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 19:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRFvr-0000L2-J1; Fri, 27 Dec 2024 14:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRFvq-0000Ka-7V
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 14:23:34 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRFvo-00053m-Al
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 14:23:33 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so85128135e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 11:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735327409; x=1735932209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BgLcHu3Bnj489iUxaRiLjyWTt1ElSMhlJFts1rbOW5A=;
 b=V9mSlLfmXKTBrAOEAXibyW0bmJU4pd9/VJwGJfeB/hRHFMVLmYIyNGjVeQpcOZIs2g
 SyZFTalTrErFAK09IE41EowuJ46JUjd/Dkvp0w9UQPRY3NOtsYmigvuKJZdPQ9K79KUt
 KdFGIr9UtnamYrvERAhLJy0aRIAACOEU8dl6i3jqrzkESYAK2AqQLJ9xnxVmcAMA5BGa
 afbn5AWigbDz/ZCY+Xq84nRnb/LQKOJWrk9qPxGxpxYi7DXS4F+wNV5nISV2RCEAM/iI
 t7+4UsjaTyppZFJFDuuNR5QM7EILo3ziyT/wsrzh1hWJow0+ohWBDy/K43GMcUeesonV
 mFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735327409; x=1735932209;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BgLcHu3Bnj489iUxaRiLjyWTt1ElSMhlJFts1rbOW5A=;
 b=f1cgX3B0+ba02v9eJgXJGrn6tk+TzrG26elziMyP3g+Meya84qmX2CrwPH/aQfIG1U
 3SSlYXmiNwLvXqUX95QOywGVHMMVRf+/tkRToKJX+FL3DgG7EsQ4PwJc09iWtUk7tOfF
 ZwEMQwAff/Vo7opkKp6Xt2vTpK/L4NSKuICDDTvR9xfpgtQ5WPgOrTD6w9GWtU29b3KZ
 guJfmz7KB1c/kR8oCHlxUG2tU6Cu1jydfvJ5FToZb0JvoHhTLOh/+adZ/BrnWaLcmVEY
 i02qMvYg/oNfw/DuruLIIeUk9PyhuZ6nioYXPCddDJkgCmgh1KY14ECqqcD3inCtNm3K
 VlZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSCPKSk4W5sUU8/13ZZonyu5HnvA+zvYFharSlS1SxpGn1WhGoKzHiseMGz33BnGBbnZKppItEaC8V@nongnu.org
X-Gm-Message-State: AOJu0Yx8g3lFsh3v9ndwNAtv57rAoJJ3lAVaXTvBZwSlwK6u8FwO+HBu
 ItaHse5WM1UOOKfMCBZO6YzsgCWhVmOmUnct43J2xr38+BBGZl2wws9Ps8qTWak=
X-Gm-Gg: ASbGncvzo/55VFvHnFctmWHLLabYVgxbPhE9Dxcl+IGIBCiR/Sm0W8JlPTDttdMl5Ug
 iVkTx9kRetKINEjrpVhyK+PcKEWi6+Px2DtKxF3LFRgdsU6HN7dqLR53s2e9EPwzPB3xj1JDY3R
 lbKYiypGPhwdv87Cm/btc5iVHUL0iIlXfaWUDyWbK2t1K8PwrODoGw2K+HS9j9Kjk9Ffwz67iLe
 mmf3y+wonOjsYUHXbEBOL+Bou6ftpyJWXRy33xB6OHv+U+YY9zj1PvjNwQbeOlAGm12VK5mmOF9
 iwrKoPyBaGelNYvaWhS3yoXo
X-Google-Smtp-Source: AGHT+IFv5TipGstqyYk2iXRjgD9jI9vmtZvLZwATAuzzeqmpZEUZhyjpehrwoPNBswIsvh8Mu8BkiQ==
X-Received: by 2002:a05:600c:468f:b0:434:a815:2b5d with SMTP id
 5b1f17b1804b1-43668b785ddmr217078055e9.24.1735327408842; 
 Fri, 27 Dec 2024 11:23:28 -0800 (PST)
Received: from [192.168.69.103] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8472b3sm22825261f8f.58.2024.12.27.11.23.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Dec 2024 11:23:28 -0800 (PST)
Message-ID: <1211286e-9211-4d89-9021-f353169af6ad@linaro.org>
Date: Fri, 27 Dec 2024 20:23:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 14/14] hw/vmapple/vmapple: Add vmapple machine type
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, akihiko.odaki@daynix.com,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
References: <20241223221645.29911-1-phil@philjordan.eu>
 <20241223221645.29911-15-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241223221645.29911-15-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 23/12/24 23:16, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> Apple defines a new "vmapple" machine type as part of its proprietary
> macOS Virtualization.Framework vmm. This machine type is similar to the
> virt one, but with subtle differences in base devices, a few special
> vmapple device additions and a vastly different boot chain.
> 
> This patch reimplements this machine type in QEMU. To use it, you
> have to have a readily installed version of macOS for VMApple,
> run on macOS with -accel hvf, pass the Virtualization.Framework
> boot rom (AVPBooter) in via -bios, pass the aux and root volume as pflash
> and pass aux and root volume as virtio drives. In addition, you also
> need to find the machine UUID and pass that as -M vmapple,uuid= parameter:
> 
> $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=0x1234 -m 4G \
>      -bios /System/Library/Frameworks/Virtualization.framework/Versions/A/Resources/AVPBooter.vmapple2.bin
>      -drive file=aux,if=pflash,format=raw \
>      -drive file=root,if=pflash,format=raw \
>      -drive file=aux,if=none,id=aux,format=raw \
>      -device vmapple-virtio-blk-pci,variant=aux,drive=aux \
>      -drive file=root,if=none,id=root,format=raw \
>      -device vmapple-virtio-blk-pci,variant=root,drive=root
> 
> With all these in place, you should be able to see macOS booting
> successfully.
> 
> Known issues:
>   - Keyboard and mouse/tablet input is laggy. The reason for this is
>     that macOS's XHCI driver seems to expect interrupter mapping to
>     be disabled when MSI/MSI-X is unavailable. I have found a
>     workaround but discovered a bunch of other XHCI spec non-compliance
>     in the process, so I'm fixing all of those in a separate patch
>     set.
>   - Currently only macOS 12 guests are supported. The boot process for
>     13+ will need further investigation and adjustment.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---


> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> index bcd1be63e3..6a4c4a7fa2 100644
> --- a/hw/vmapple/Kconfig
> +++ b/hw/vmapple/Kconfig
> @@ -10,3 +10,23 @@ config VMAPPLE_CFG
>   config VMAPPLE_VIRTIO_BLK
>       bool
>   
> +config VMAPPLE
> +    bool
> +    depends on ARM
> +    depends on HVF
> +    default y if ARM
> +    imply PCI_DEVICES
> +    select ARM_GIC

Hmmm I'm getting ...:

qemu-system-aarch64: unknown type 'arm-gicv3'

> +    select PLATFORM_BUS
> +    select PCI_EXPRESS
> +    select PCI_EXPRESS_GENERIC_BRIDGE
> +    select PL011 # UART
> +    select PL031 # RTC
> +    select PL061 # GPIO
> +    select GPIO_PWR
> +    select PVPANIC_MMIO
> +    select VMAPPLE_AES
> +    select VMAPPLE_BDIF
> +    select VMAPPLE_CFG
> +    select MAC_PVG_MMIO
> +    select VMAPPLE_VIRTIO_BLK


> +static void create_gic(VMAppleMachineState *vms, MemoryRegion *mem)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    /* We create a standalone GIC */
> +    SysBusDevice *gicbusdev;
> +    QList *redist_region_count;
> +    int i;
> +    unsigned int smp_cpus = ms->smp.cpus;
> +
> +    vms->gic = qdev_new(gicv3_class_name());

... I suppose due to this call ^^^.

$ git grep arm-gicv3
hw/intc/arm_gicv3_kvm.c:45:#define TYPE_KVM_ARM_GICV3 "kvm-arm-gicv3"
include/hw/intc/arm_gicv3.h:18:#define TYPE_ARM_GICV3 "arm-gicv3"
$ git grep TYPE_ARM_GICV3
hw/intc/arm_gicv3.c:466:    .name = TYPE_ARM_GICV3,
$ git grep -FW arm_gicv3.c
hw/intc/meson.build=9=system_ss.add(when: 'CONFIG_ARM_GICV3_TCG', 
if_true: files(
hw/intc/meson.build:10:  'arm_gicv3.c',
...

I think commit a8a5546798c ("hw/intc/arm_gicv3: Introduce
CONFIG_ARM_GIC_TCG Kconfig selector") is invalid as being
too restrictive.

I can go a bit further with these changes on top (ignoring
renaming ARM_GICV3_TCG -> ARM_GICV3):

-- >8 --
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index dd405bdb5d2..9e06c05b449 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -26 +26 @@ config ARM_GIC
-    select ARM_GICV3_TCG if TCG
+    select ARM_GICV3_TCG if TCG || HVF
@@ -32 +32 @@ config ARM_GICV3_TCG
-    depends on ARM_GIC && TCG
+    depends on ARM_GIC && (TCG || HVF)
diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
index 6a4c4a7fa2e..374a89f6a8f 100644
--- a/hw/vmapple/Kconfig
+++ b/hw/vmapple/Kconfig
@@ -19 +19 @@ config VMAPPLE
-    select ARM_GIC
+    select ARM_GICV3_TCG
---

> +    qdev_prop_set_uint32(vms->gic, "revision", 3);
> +    qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
> +    /*
> +     * Note that the num-irq property counts both internal and external
> +     * interrupts; there are always 32 of the former (mandated by GIC spec).
> +     */
> +    qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
> +
> +    uint32_t redist0_capacity =
> +                vms->memmap[VMAPPLE_GIC_REDIST].size / GICV3_REDIST_SIZE;
> +    uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
> +
> +    redist_region_count = qlist_new();
> +    qlist_append_int(redist_region_count, redist0_count);
> +    qdev_prop_set_array(vms->gic, "redist-region-count", redist_region_count);
> +
> +    gicbusdev = SYS_BUS_DEVICE(vms->gic);
> +    sysbus_realize_and_unref(gicbusdev, &error_fatal);
> +    sysbus_mmio_map(gicbusdev, 0, vms->memmap[VMAPPLE_GIC_DIST].base);
> +    sysbus_mmio_map(gicbusdev, 1, vms->memmap[VMAPPLE_GIC_REDIST].base);
> +
> +    /*
> +     * Wire the outputs from each CPU's generic timer and the GICv3
> +     * maintenance interrupt signal to the appropriate GIC PPI inputs,
> +     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
> +     */
> +    for (i = 0; i < smp_cpus; i++) {
> +        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
> +
> +        /* Map the virt timer to PPI 27 */
> +        qdev_connect_gpio_out(cpudev, GTIMER_VIRT,
> +                              qdev_get_gpio_in(vms->gic,
> +                                               arm_gic_ppi_index(i, 27)));
> +
> +        /* Map the GIC IRQ and FIQ lines to CPU */
> +        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> +        sysbus_connect_irq(gicbusdev, i + smp_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> +    }
> +}


