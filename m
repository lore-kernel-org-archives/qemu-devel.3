Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71948C3ABBB
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 13:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBvqG-0001MP-7l; Mon, 05 May 2025 09:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBvqD-0001Ln-PK
 for qemu-devel@nongnu.org; Mon, 05 May 2025 09:26:41 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBvqB-00072F-3o
 for qemu-devel@nongnu.org; Mon, 05 May 2025 09:26:41 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-22928d629faso40156185ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 06:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746451597; x=1747056397; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0QTPUwEj2WuOHn4mfaxMr2Vz3SFLgvMzMGm+xsMVPRs=;
 b=c6IKPVV4YGKhtXiDk6adB7ZGYoot65myHynQOJxT8Q8On7n2GIMXSQRvti+rHr1xPD
 Qjz0qI82Cni5n7FNelKiICS/8QRFFVy3N2eD86QudwiwUPPftTj6t7ylJ2G+Mj7heQ41
 Gxle6FYan9zzHkF0vMzEggZrqLMqIkXVViVfvasD92fDBcDIjubgakqqKtaSmzk+qbMF
 53H5nlivzxGK8A0ZfO9v6K56Snj/oDl5Qmud10a4896L2tbXccJqA8VKvJyMk2KY8ydY
 QXWB68a9Bj3CNi17XtA4E4e5R6lCoxc6Q39Xn9ACE9p81kbpyMVqGNdxf4S0jPmQLhDD
 UJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746451597; x=1747056397;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0QTPUwEj2WuOHn4mfaxMr2Vz3SFLgvMzMGm+xsMVPRs=;
 b=YTJIXG+GFsUguDa1RgkW+/9OzvsSl3JIaSnSFvDlDyuADZpI92+6jkrNqBGLtVuGOt
 bm0krA7k3NYmcDFRO+08m2PMVAvE8UoST27fk8qxbR8/dSRhW2Qh+VlJbBhqceUBQ+cC
 dxB9U9yVpIvGIJ7SBaAW2/ZuNI5LV9J29vnnpVVM38Ul5cmVRQXclEFHkPw/nHV16kLU
 a3KSdYSaD9OnjyTmOWtmmyQVm9IiouZ3s3VWStCd6Vl73aIKqpSZ0+THCIRSKwc/Syd/
 k1KzfbLRs6RWZWSZQt5CKyneEhxU8rMfQy7cCHWhClLjv7xA04zpkdINPjBovFPCeLwx
 QEQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFjSVlPTcmHMqBNnXIY3po3YCVoVHNIbSY2kQPqWU6pgJr/8AGq2aVLMYS41OttRmZ7yl4ExHjAs+k@nongnu.org
X-Gm-Message-State: AOJu0YzLLyeuxKJAmaLjYxjw5t6xHpZLyINst4XNg7FLScP72VZ8MHyv
 UTQ8rq3XvHB+iaLlkMg+njVhZXblU6MF9KZJbNSyceCQ4o0qh0Y6m+kJPGlRUdsv36BAmIt7zGK
 SCrPliQ==
X-Gm-Gg: ASbGncvgY7poc/MnqvjyuxzGgOYRMP6DRK7SwzvTt3xWA3XeE1z96bq5gxwOUUpTjMY
 XkLvR0ZzNuQ/i8SFRaFDAr+Q6rn9aXQHVAhWhLEeEDUCEWDnWwYKm3jREGS7hBvnd/xN3lY5Tc9
 F7p3GO+boW6IPWJ9ZsIw8+cUqoyG58mYgsVbuSjew3NE9cQm8cEw31EPFZavXl1tOgpbzkZjaZs
 GG7HiJavDYJ3amuHuWQw5Ozx1UZFbMVaVkXJ0QX0oqqksDZkee9aae6rGxnD35HFHkQAK2ALAT5
 /NAh/eirkL2yAL8REVFc3WuyAxnAPp2qC7XQme/K2AxD7FoPQXjQZsLZHiU39fjb9+ExcuEAdiA
 Y1qdOTblbYlea3+7uHMw=
X-Google-Smtp-Source: AGHT+IGjUezE/Hhk6x2fCfMkoMfHmbOcvxP8gFblcswbm3fgLzXAeqAkHUn+C+hzfH6tiTFLlYsGGg==
X-Received: by 2002:a17:902:d505:b0:220:d601:a704 with SMTP id
 d9443c01a7336-22e1e8eaf8dmr85391285ad.18.1746451596757; 
 Mon, 05 May 2025 06:26:36 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b400:8604:7950:93ed:53e9:9290?
 ([2804:7f0:b400:8604:7950:93ed:53e9:9290])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a4748e775sm8881194a91.27.2025.05.05.06.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 06:26:36 -0700 (PDT)
Message-ID: <6a52f974-3e13-49ba-bfeb-e30e683e4ce5@linaro.org>
Date: Mon, 5 May 2025 10:26:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/24] APCI PCI Hotplug support on ARM
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250428102628.378046-1-eric.auger@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250428102628.378046-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x641.google.com
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

Hi Eric,

On 4/28/25 07:25, Eric Auger wrote:
> This series enables APCI PCI hotplug/hotunplug on ARM
> and makes it default for 10.1 machine type. This aligns with
> x86 q35 machine. Expected benefits should be similar to
> those listed in [1].
> 
> The infrastructure used in x86 is heavily reused and a
> huge part of the series consists in moving code from
> hw/i386/acpi-build.c to a generic place and slightly
> adapting it to make it usable on ARM. The DSDT table is
> augmented to support ACPI PCI hotplug elements.
> 
> On ARM we use use a GED event to notify the OS about
> hotplug events.
> 
> I have not noticed any tests/qtest/bios-tables-test failures
> neither on x86 nor ARM. x86 DSDT table has not changed.
> ARM DSDT table definitively has but there are no tests
> impacted. ARM misses hotplug tests that do exist on x86. This
> most probably should be considered in the future.
> 
> Best Regards
> 
> Eric
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/arm-acpi-pcihp-rfc
> 
> [1] [PATCH v6 0/6] Use ACPI PCI hot-plug for Q35
> https://lore.kernel.org/all/20210713004205.775386-1-jusual@redhat.com/

I've just started to review your series and went to a quick smoke test
by hotplugging a net adapter and got the following kernel internal error:

(qemu) device_add virtio-net-pci,bus=pcie.1,addr=0,id=na
(qemu) [   64.165411] pci 0000:01:00.0: [1af4:1041] type 00 class 0x020000
[   64.165895] pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x00000fff]
[   64.166259] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
[   64.166658] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[   64.167153] pci 0000:01:00.0: enabling Extended Tags
[   64.179972] Internal error: synchronous external abort: 0000000096000050 [#1] SMP
[   64.180719] Modules linked in: aes_ce_blk aes_ce_cipher polyval_ce polyval_generic ghash_ce gf128mul sha2_ce binfmt_misc sha256_arm64 sha1_ce nls_ascii nls_cp437 vfat fat evdev cfg80211 rfkill loop fuse efi_pstore drm dm_mod dax configfs efivarfs qemu_fw_cfg ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic virtio_scsi virtio_net scsi_mod net_failover failover virtio_blk scsi_common crct10dif_ce crct10dif_common virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio_mmio
[   64.183656] CPU: 0 PID: 23 Comm: kworker/u2:1 Not tainted 6.1.0-30-arm64 #1  Debian 6.1.124-1
[   64.184071] Hardware name: QEMU QEMU Virtual Machine, BIOS edk2-stable202408-prebuilt.qemu.org 08/13/2024
[   64.184759] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[   64.185320] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   64.185737] pc : acpi_ex_system_memory_space_handler+0x290/0x300
[   64.186175] lr : acpi_ev_address_space_dispatch+0x124/0x334
[   64.186490] sp : ffff80000a6bb3b0
[   64.186663] x29: ffff80000a6bb3b0 x28: ffff0003fcbb08b8 x27: 0000000000000000
[   64.187126] x26: ffff0003fcbb0288 x25: ffff80000a6bb568 x24: 0000000000000001
[   64.187499] x23: ffff80000a6bb568 x22: 0000000000000004 x21: ffff0000c206cb00
[   64.187885] x20: 00000000090c0014 x19: 0000000000000020 x18: 0000000000000000
[   64.188265] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   64.188640] x14: 0000000000000000 x13: 4d43c3194dea1791 x12: 4d7a3553e5c937d0
[   64.189003] x11: 0000000000000001 x10: 0000000000000000 x9 : ffff800008735b34
[   64.189383] x8 : 0000000000000001 x7 : ffff80000873c850 x6 : 00000000000000f8
[   64.189778] x5 : ffff0000c206cb00 x4 : 0000000000000000 x3 : 00000000090c0018
[   64.190163] x2 : ffff80000a9af014 x1 : 00000000090c0018 x0 : 0000000000000001
[   64.190734] Call trace:
[   64.191086]  acpi_ex_system_memory_space_handler+0x290/0x300
[   64.191696]  acpi_ev_address_space_dispatch+0x124/0x334
[   64.192042]  acpi_ex_access_region+0xe4/0x2e0
[   64.192287]  acpi_ex_field_datum_io+0x88/0x200
[   64.192509]  acpi_ex_write_with_update_rule+0xd4/0x120
[   64.192793]  acpi_ex_insert_into_field+0x210/0x2b0
[   64.193048]  acpi_ex_write_data_to_field+0xa0/0x190
[   64.193298]  acpi_ex_store_object_to_node+0x150/0x240
[   64.193527]  acpi_ex_store+0x144/0x300
[   64.193726]  acpi_ex_opcode_1A_1T_1R+0x218/0x580
[   64.193971]  acpi_ds_exec_end_op+0x24c/0x4b0
[   64.194227]  acpi_ps_parse_loop+0x100/0x6a0
[   64.194477]  acpi_ps_parse_aml+0x94/0x3b0
[   64.194674]  acpi_ps_execute_method+0x128/0x25c
[   64.194922]  acpi_ns_evaluate+0x1f0/0x2d0
[   64.195148]  acpi_evaluate_object+0x138/0x2d0
[   64.195380]  acpi_evaluate_dsm+0xb8/0x134
[   64.195613]  acpi_check_dsm+0x34/0xdc
[   64.195822]  smbios_attr_is_visible+0x5c/0xb0
[   64.196089]  internal_create_group+0xd0/0x3d0
[   64.196335]  internal_create_groups+0x58/0xe0
[   64.196584]  sysfs_create_groups+0x20/0x30
[   64.196813]  device_add_groups+0x18/0x2c
[   64.197039]  bus_add_device+0x48/0x160
[   64.197260]  device_add+0x3a4/0x85c
[   64.197463]  pci_device_add+0x308/0x660
[   64.197680]  pci_scan_single_device+0xe4/0x114
[   64.197941]  pci_scan_slot+0x70/0x1fc
[   64.198155]  acpiphp_rescan_slot+0x90/0xa4
[   64.198366]  acpiphp_hotplug_notify+0x2a8/0x300
[   64.198584]  acpi_device_hotplug+0x138/0x4c0
[   64.198819]  acpi_hotplug_work_fn+0x2c/0x4c
[   64.199045]  process_one_work+0x1f4/0x460
[   64.199277]  worker_thread+0x188/0x4e0
[   64.199492]  kthread+0xe0/0xe4
[   64.199671]  ret_from_fork+0x10/0x20
[   64.200114] Code: f90002e0 52800000 17ffff97 f94002e0 (b9000040)
[   64.200820] ---[ end trace 0000000000000000 ]---

(qemu)

This is a Debian Bookworm stock kernel 6.1. I built QEMU from your GH branch.

The machine was started with:

./qemu-system-aarch64 -m 16G -nographic -machine type=virt,gic-version=max -cpu cortex-a57 -initrd /mnt/initrd.img-6.1.0-30-arm64 -kernel /mnt/vmlinuz-6.1.0-30-arm64 -append "root=/dev/vda1 console=ttyAMA0,115200 acpi=force" -device virtio-scsi-pci -device virtio-blk-pci,drive=root -drive if=none,id=root,file=/mnt/debian-12-nocloud-arm64.qcow2 -device pcie-root-port,id=pcie.1,chassis=1,slot=1 -bios ./pc-bios/edk2-aarch64-code.fd

./pc-bios/edk2-aarch64-code.fd is the one found under ./build dir, so nothing special.

It seems Linux acpi crashed when ingesting the _DSM method but I could not
figure out what exactly in it could cause it.


Cheers,
Gustavo

> 
> Eric Auger (24):
>    hw/pci/pcie_port: Fix pcie_slot_is_hotpluggbale_bus typo
>    hw/acpi/ged: Fix wrong identation
>    hw/i386/acpi-build: Fix build_append_notfication_callback typo
>    hw/i386/acpi-build: Make aml_pci_device_dsm() static
>    hw/arm/virt: Introduce machine state acpi pcihp flags and props
>    hw/acpi: Rename and move build_x86_acpi_pci_hotplug to pcihp
>    hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to
>      acpi_dsdt_add_pci_osc
>    hw/pci-host/gpex-acpi: Split host bridge OSC and DSM generation
>    hw/pci-host/gpex-acpi: Propagate hotplug type info from virt machine
>      downto gpex
>    hw/i386/acpi-build: Turn build_q35_osc_method into a generic method
>    hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method
>    hw/i386/acpi-build: Introduce build_append_pcihp_resources() helper
>    hw/acpi/pcihp: Add an AmlRegionSpace arg to build_acpi_pci_hotplug
>    hw/i386/acpi-build: Move build_append_notification_callback to pcihp
>    hw/i386/acpi-build: Move remaining pcihp generic functions to pcihp
>    hw/i386/acpi-build: Introduce and use acpi_get_pci_host
>    hw/arm/virt-acpi-build: Add DSDT additions for PCI hotplug
>    hw/acpi/ged: Prepare the device to react to PCI hotplug events
>    hw/acpi/ged: Call pcihp plug callbacks in hotplug handler
>      implementation
>    hw/acpi/ged: Support migration of AcpiPciHpState
>    hw/core/sysbus: Introduce sysbus_mmio_map_name() helper
>    hw/arm/virt: Let virt support pci hotplug/unplug GED event
>    hw/arm/virt: Plug pcihp hotplug/hotunplug callbacks
>    hw/arm/virt: Use ACPI PCI hotplug by default
> 
>   hw/i386/acpi-build.h                   |   4 -
>   include/hw/acpi/aml-build.h            |   2 +
>   include/hw/acpi/generic_event_device.h |   5 +
>   include/hw/acpi/pci.h                  |   4 +-
>   include/hw/acpi/pcihp.h                |  14 +
>   include/hw/arm/virt.h                  |   4 +
>   include/hw/pci-host/gpex.h             |   1 +
>   include/hw/sysbus.h                    |   1 +
>   hw/acpi/aml-build.c                    |  50 +++
>   hw/acpi/generic_event_device.c         |  64 +++-
>   hw/acpi/pci.c                          |  20 ++
>   hw/acpi/pcihp.c                        | 428 +++++++++++++++++++++-
>   hw/arm/virt-acpi-build.c               |  26 ++
>   hw/arm/virt.c                          | 100 +++++-
>   hw/core/sysbus.c                       |  11 +
>   hw/i386/acpi-build.c                   | 475 +------------------------
>   hw/pci-host/gpex-acpi.c                |  75 +---
>   hw/pci/pcie_port.c                     |   4 +-
>   hw/arm/Kconfig                         |   2 +
>   19 files changed, 748 insertions(+), 542 deletions(-)
> 


