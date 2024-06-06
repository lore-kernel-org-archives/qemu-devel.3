Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442B1C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFA8D-0000Dv-U5; Thu, 06 Jun 2024 06:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sFA8C-0000D6-29
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sFA88-00064k-Ll
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717668839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VeZe5kJeC7dJ2COJPaCPKXCLkxAytjF73XRXMWRERRA=;
 b=HRLJH7l8mNfubmKkEzgW4hOL0SmnPR3dj9+P+b1NyNvXoY/gABEiwrGtqZXEr2daUB3PeR
 XZ2UDPf+JKfHGfXn7TvZr1UDL5Ura5dCkzVUzmd0NrLDqaWBq4SrXY/rtG3yJJjxIfEY4f
 GNlQ4ILaE1htrdZj5FL4yYKQRSREaFc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-7lp7hEkkNbaq3u2FFyYqzg-1; Thu, 06 Jun 2024 06:13:57 -0400
X-MC-Unique: 7lp7hEkkNbaq3u2FFyYqzg-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-649731dd35bso690761a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 03:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717668837; x=1718273637;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VeZe5kJeC7dJ2COJPaCPKXCLkxAytjF73XRXMWRERRA=;
 b=O/IEAIdqTx4HAzqca4WZMbaggSiRK6JV/mLGthy3WXv2FRtu82XHG8MgWxkQSEKuxf
 cTddyM1/41/tIM63K38Ij/wb4xDwQ4T7B+8qTn4khAvmkerGNfS0ziLuA4q5v4MzVkPO
 VFjaf2rL/fSxe36aX2A17h7GIQWzuL5fzuG/5OaBJWS1MPpq6nv+WU0jmrt0fkDEejDw
 5EZmozr/LzfD3kYQRQGAzsMUBIcZ/KGPZcJqNuV2YnndZuo6ND+JzQLC4G/HEjP+x0Tu
 D+29syzOXKyuE/zRkZ/n3uKhiPUJycfYnvNalm8drdL6dmqkLATL3WS0aq7O4Hik4Mkl
 9owQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2cMa1huYqZSJtPF01UsRgcazs0BfsFNVvXF5xxyXHKGX5qdVZ3ukSl4ubqdwXHowjHQdEi5a+UPomXtmEEbPcAHbL1Xg=
X-Gm-Message-State: AOJu0Yz2MwZ8ReDfWlwaitwCW5ohH4DpNJr74G3hFNxaPM6q9H0adVXJ
 6cEQ4GAybacSr1DrkPqsril18EVQlX3jo75YMFOQPqzuqepBJD+2IPVYwqvWYpvbslaSmhlZtKM
 s8jaTlxCYPdNWr4xgH6UVy5SjaA1p0tm0QkhAk0DZRi+SwdtSBHa8
X-Received: by 2002:a05:6a20:4310:b0:1b0:9b7:bbce with SMTP id
 adf61e73a8af0-1b2b6e5ab6bmr6468907637.4.1717668836486; 
 Thu, 06 Jun 2024 03:13:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRbpmUOkAozBj6ZgTrDb8SUS88qnilW1R+QJx4/hg7QaNTYTdvx3v6zpbO/yxxq3yw3cPQGg==
X-Received: by 2002:a05:6a20:4310:b0:1b0:9b7:bbce with SMTP id
 adf61e73a8af0-1b2b6e5ab6bmr6468886637.4.1717668835940; 
 Thu, 06 Jun 2024 03:13:55 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.224])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c2806bd7d2sm3094282a91.36.2024.06.06.03.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 03:13:55 -0700 (PDT)
Message-ID: <e7497618-e300-4560-b752-11c77d177450@redhat.com>
Date: Thu, 6 Jun 2024 20:13:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
From: Gavin Shan <gshan@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Itaru Kitayama <itaru.kitayama@linux.dev>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>
References: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
 <4e7aa598-1a5d-47e1-aaa3-78af05947eeb@linaro.org>
 <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
 <cbd630d7-01e8-49ba-9c8b-a6514d898ed2@redhat.com>
 <20240531150922.GA83195@myrica>
 <bd1f84bd-e23c-4f4b-bc0b-a2a1b70081f4@redhat.com>
 <20240603082402.GA25688@myrica>
 <2c81cb47-b9bc-4875-a7fb-49c3a8ab6713@redhat.com>
 <20240604111517.GB875061@myrica>
 <e7748b25-a01b-49e9-bbeb-cd03abb91cf6@redhat.com>
 <20240605155608.GA3251699@myrica>
 <1089f920-aff9-4d16-829d-5d058908a11e@redhat.com>
Content-Language: en-US
In-Reply-To: <1089f920-aff9-4d16-829d-5d058908a11e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 6/6/24 15:05, Gavin Shan wrote:
> Even the edk2 for the guest can be built successfully, but I'm not able to try it
> because I'm unable to bring up the host now. I tried to rebuild the environment
> from scratch, the host runs into crash inside EDK2 unfortunately...
> 
>    TF-RMM:   https://git.codelinaro.org/linaro/dcap/rmm.git                       (branch: cca/v2)
>    EDK2:     git@github.com:tianocore/edk2.git                                    (tag:    edk2-stable202402)
>    TF-A:     https://git.codelinaro.org/linaro/dcap/tf-a/trusted-firmware-a.git   (branch: cca/v2)
>    QEMU:     https://git.qemu.org/git/qemu.git                                    (branch: master)
>    KERNEL:   https://git.gitlab.arm.com/linux-arm/linux-cca.git                   (branch: cca-full/v2)
>    BuildRoot: <doesn't matter at present>
> 
> arm64-server# home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>                -M virt,virtualization=on,secure=on,gic-version=3,acpi=off  \
>                -cpu max,x-rme=on -m 8G -smp 8                              \
>                -monitor none -serial mon:stdio -nographic -nodefaults      \
>                -bios /home/gavin/sandbox/CCA/tf-a/flash.bin                \
>                -kernel /home/gavin/sandbox/CCA/linux/arch/arm64/boot/Image \
>                -append console=ttyAMA0 root=/dev/vda                       \
>                -drive format=raw,if=none,file=/home/gavin/sandbox/CCA/buildroot/output/images/rootfs.ext4,id=hd0 \
>                -device virtio-blk-pci,drive=hd0                            \
>                -netdev tap,id=tap0,vhost=false,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
>                -device virtio-net-pci,netdev=tap0,mac=52:54:00:f1:26:b0                          \
>                -fsdev local,security_model=none,path=/home/gavin/sandbox/CCA,id=shr0             \
>                -device virtio-9p-device,fsdev=shr0,mount_tag=shr0
>                   :
> NOTICE:  Booting Trusted Firmware
> NOTICE:  BL1: v2.10.0(debug):99e0b97aa-dirty
> NOTICE:  BL1: Built : 23:14:56, Jun  5 2024
> INFO:    BL1: RAM 0xe0ee000 - 0xe0f7000
> INFO:    BL1: Loading BL2
> INFO:    Loading image id=1 at address 0xe06b000
> INFO:    Image id=1 loaded: 0xe06b000 - 0xe0742d1
> NOTICE:  BL1: Booting BL2
> INFO:    Entry point address = 0xe06b000
> INFO:    SPSR = 0x3cd
> INFO:    [GPT] Boot Configuration
> INFO:      PPS/T:     0x2/40
> INFO:      PGS/P:     0x0/12
> INFO:      L0GPTSZ/S: 0x0/30
> INFO:      PAS count: 0x6
> INFO:      L0 base:   0xedfe000
> INFO:    [GPT] PAS[0]: base 0xe001000, size 0xff000, GPI 0xa, type 0x1
> INFO:    [GPT] PAS[1]: base 0xe100000, size 0xcfe000, GPI 0x8, type 0x1
> INFO:    [GPT] PAS[2]: base 0xedfe000, size 0x202000, GPI 0xa, type 0x1
> INFO:    [GPT] PAS[3]: base 0x40000000, size 0x100000, GPI 0x9, type 0x1
> INFO:    [GPT] PAS[4]: base 0x40100000, size 0x2800000, GPI 0xb, type 0x1
> INFO:    [GPT] PAS[5]: base 0x42900000, size 0x1fd700000, GPI 0x9, type 0x1
> INFO:    Enabling Granule Protection Checks
> NOTICE:  BL2: v2.10.0(debug):99e0b97aa-dirty
> NOTICE:  BL2: Built : 23:14:56, Jun  5 2024
> INFO:    BL2: Doing platform setup
> INFO:    Reserved RMM memory [0x40100000, 0x428fffff] in Device tree
> INFO:    BL2: Loading image id 3
> INFO:    Loading image id=3 at address 0xe0a0000
> INFO:    Image id=3 loaded: 0xe0a0000 - 0xe0b10c4
> INFO:    BL2: Loading image id 35
> INFO:    Loading image id=35 at address 0x40100000
> INFO:    Image id=35 loaded: 0x40100000 - 0x403033b0
> INFO:    BL2: Loading image id 5
> INFO:    Loading image id=5 at address 0x60000000
> INFO:    Image id=5 loaded: 0x60000000 - 0x60200000
> NOTICE:  BL2: Booting BL31
> INFO:    Entry point address = 0xe0a0000
> INFO:    SPSR = 0x3cd
> NOTICE:  BL31: v2.10.0(debug):99e0b97aa-dirty
> NOTICE:  BL31: Built : 23:14:56, Jun  5 2024
> INFO:    GICv3 without legacy support detected.
> INFO:    ARM GICv3 driver initialized in EL3
> INFO:    Maximum SPI INTID supported: 287
> INFO:    BL31: Initializing runtime services
> INFO:    RMM setup done.
> INFO:    BL31: Initializing RMM
> INFO:    RMM init start.
> Booting RMM v.0.4.0(debug) 17924bc Built with GCC 11.4.1
> RMM-EL3 Interface v.0.2
> Boot Manifest Interface v.0.3
> RMI/RSI ABI v.1.0/1.0 built: Jun  5 2024 23:03:00
> INFO:    RMM init end.
> INFO:    BL31: Preparing for EL3 exit to normal world
> INFO:    Entry point address = 0x60000000
> INFO:    SPSR = 0x3c9
> Loading driver at 0x00060009160 EntryPoint=0x00000000000
> ArmVirtGetMemoryMap: Dumping System DRAM Memory Map:
>      PhysicalBase: 0x40000000
>      VirtualBase: 0x40000000
>      Length: 0x200000000
> UEFI firmware (version  built at 23:28:51 on Jun  5 2024)
> PlatformPeim: PL011 UART (console) @ 0x9000000
> PlatformPeim: PL011 UART (debug) @ 0x9000000
>    :
> EFI stub: Booting Linux Kernel...
> EFI stub: EFI_RNG_PROTOCOL unavailable
> SetMemoryAttributes: BaseAddress == 0x22DC00000, Length == 0x1CE0000, Attributes == 0x20000
> SetMemoryAttributes: BaseAddress == 0x22F8E0000, Length == 0xE50000, Attributes == 0x4000
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services...
> EFI stub: update_fdt() ... done
> EFI stub: efi_exit_boot_services: enter
> EFI stub: efi_exit_boot_services: efi_pci_disable_bridge_busmaster
> EFI stub: efi_exit_boot_services: efi_get_memory_map
> EFI stub: efi_exit_boot_services: priv_func
> =====> CoreExitBootServices
> MemoryProtectionExitBootServicesCallback - 0
> SetUefiImageMemoryAttributes - 0x000000023BE60000 - 0x0000000000040000 (0x0000000000000008)
> MemoryProtectionExitBootServicesCallback - 0
> SetUefiImageMemoryAttributes - 0x0000000238AF0000 - 0x0000000000040000 (0x0000000000000008)
> MemoryProtectionExitBootServicesCallback - 0
> SetUefiImageMemoryAttributes - 0x0000000238AA0000 - 0x0000000000040000 (0x0000000000000008)
> MemoryProtectionExitBootServicesCallback - 0
> SetUefiImageMemoryAttributes - 0x0000000238A50000 - 0x0000000000040000 (0x0000000000000008)
> MemoryProtectionExitBootServicesCallback - 0
> SetUefiImageMemoryAttributes - 0x0000000238960000 - 0x0000000000040000 (0x0000000000000008)
> MemoryProtectionExitBootServicesCallback - 0
> SetUefiImageMemoryAttributes - 0x000000023BE20000 - 0x0000000000030000 (0x0000000000000008)
> MemoryProtectionExitBootServicesCallback - 0
> SetUefiImageMemoryAttributes - 0x0000000238860000 - 0x0000000000030000 (0x0000000000000008)
> MemoryProtectionExitBootServicesCallback - 0
> SetUefiImageMemoryAttributes - 0x0000000238820000 - 0x0000000000030000 (0x0000000000000008)
> CoreExitBootServices: MemoryProtectionExitBootServicesCallback
> CoreExitBootServices: SaveAndSetDebugTimer
> CoreExitBootServices: gCpu->DisableInterrupt
> CoreExitBootServices: CalculateEfiHdrCrc
> CoreExitBootServices: Return with status=0x0
> 
> 
> Synchronous Exception at 0x000000023248E9B4
> PC 0x00023248E9B4
> PC 0x00023248EA70
> PC 0x00023248EBA8
> PC 0x000232490FC8
> PC 0x00023248A004
> PC 0x00023248973C
> PC 0x0002324894DC
> PC 0x00023F2C7FA8 (0x00023F2C1000+0x00006FA8) [ 1] DxeCore.dll
> PC 0x00023BCC6604 (0x00023BCBE000+0x00008604) [ 2] BdsDxe.dll
> PC 0x00023F2CBC68 (0x00023F2C1000+0x0000AC68) [ 3] DxeCore.dll
> [ 1] /home/gavin/sandbox/CCA/edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll
> [ 2] /home/gavin/sandbox/CCA/edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/BdsDxe/BdsDxe/DEBUG/BdsDxe.dll
> [ 3] /home/gavin/sandbox/CCA/edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll
> 
>    X0 0x0000000000000000   X1 0x000000023F2C0740   X2 0x000000000000000A   X3 0x00000002325D3E26
>    X4 0x0000000000000020   X5 0xFFFFFFFFFFFFFFFE   X6 0x0000000000000000   X7 0x0000000000000000
>    X8 0x0000000000000000   X9 0x0000000238820000  X10 0x000000000000002E  X11 0x00000000000023D0
>   X12 0x00000000000023C4  X13 0x0000000000000001  X14 0x0000000000000002  X15 0x0000000000000000
>   X16 0x000000023BD30280  X17 0x000000000066BD90  X18 0x0000000000000000  X19 0x000000023F2C0740
>   X20 0x00000002325D3E27  X21 0x000000000000FFFF  X22 0x000000000000000D  X23 0x000000000010FFFF
>   X24 0x000000000000D800  X25 0x000000023F2C0AA8  X26 0x00000002325E2000  X27 0x0000000000000002
>   X28 0x0000000000000018   FP 0x000000023F2C06F0   LR 0x000000023248EA70
> 
>    V0 0x0000000000000000 0000000000000000   V1 0xFFFFFF80FFFFFFD0 000000023F2C0800
>    V2 0x0000000000000000 0000000000000000   V3 0x0000000000000000 0000000000000000
>    V4 0x0000000000000000 0000000000000000   V5 0x0000000000000000 0000000000000000
>    V6 0x0000000000000000 0000000000000000   V7 0x0000000000000000 0000000000000000
>    V8 0x0000000000000000 0000000000000000   V9 0x0000000000000000 0000000000000000
>   V10 0x0000000000000000 0000000000000000  V11 0x0000000000000000 0000000000000000
>   V12 0x0000000000000000 0000000000000000  V13 0x0000000000000000 0000000000000000
>   V14 0x0000000000000000 0000000000000000  V15 0x0000000000000000 0000000000000000
>   V16 0x0000000000000000 0000000000000000  V17 0x0000000000000000 0000000000000000
>   V18 0x0000000000000000 0000000000000000  V19 0x0000000000000000 0000000000000000
>   V20 0x0000000000000000 0000000000000000  V21 0x0000000000000000 0000000000000000
>   V22 0x0000000000000000 0000000000000000  V23 0x0000000000000000 0000000000000000
>   V24 0x0000000000000000 0000000000000000  V25 0x0000000000000000 0000000000000000
>   V26 0x0000000000000000 0000000000000000  V27 0x0000000000000000 0000000000000000
>   V28 0x0000000000000000 0000000000000000  V29 0x0000000000000000 0000000000000000
>   V30 0x0000000000000000 0000000000000000  V31 0x0000000000000000 0000000000000000
> 
>    SP 0x000000023F2C06F0  ELR 0x000000023248E9B4  SPSR 0xA00002C9  FPSR 0x00000000
>   ESR 0x96000006          FAR 0x0000000000000008
> 
>   ESR : EC 0x25  IL 0x1  ISS 0x00000006
> 
> Data abort: Translation fault, second level
> 
> Stack dump:
>    000023F2C05F0: 000000023F2C06A0 000000023BD31FF4 0000000238820000 0000000000000002
>    000023F2C0610: 000000023B1E2000 000000023FFF9000 0000000000000E20 00000000001FFFFF
>    000023F2C0630: 0000000238850000 0000000000000001 0000000000000003 000000023FFF9E20
>    000023F2C0650: 000000000000070C 0000000000000000 000000023F2C06D0 000000023F2DD644
>    000023F2C0670: 000000023F2C07C8 000000023F2C095F 0000000000000001 000000023BD358ED
>    000023F2C0690: 000000000000070C 0000000000000000 000000023F2C0750 000000023BD31FF4
>    000023F2C06B0: 0000000238820000 0000000000000001 000000023FFF9000 000000023FFFA000
>    000023F2C06D0: 000000023F2C07F0 000000023F2C2534 0000000000000001 0000000000000000
>> 000023F2C06F0: 000000023F2C0700 000000023248EA70 000000023F2C0840 000000023248EBA8
>    000023F2C0710: 00000002325D42BF 000000023B17E918 00000002325E2000 0000000232489978
>    000023F2C0730: 000000023F2C0AB0 00000002325E2000 0020004900460045 0062007500740073
>    000023F2C0750: 000000000020003A 0000000000000001 000000023F2C0860 0000000000000001
>    000023F2C0770: 0000000000000002 00000000000000FF 0000000000000000 0000007F00000000
>    000023F2C0790: 000000023F2C07F0 000000023F2C2548 000000023F2C07C0 000000023F2DEDD8
>    000023F2C07B0: 000000023F2C088D 000000023F2EA000 000000023F2C07F0 000000023F2C2548
>    000023F2C07D0: 0000000000000001 0000000000000000 000000023F2EB000 000000023F2EA000
> ASSERT [ArmCpuDxe] /home/gavin/sandbox/CCA/edk2/ArmPkg/Library/DefaultExceptionHandlerLib/AArch64/DefaultExceptionHandler.c(343): ((BOOLEAN)(0==1))
> 

Please ignore the crash inside edk2, which is caused by verbose messages
added to Linux's EFI driver (wrapper). Those verbose messages are added
by myself and it caused stack overrun. They lead to the crash eventually.
With those verbose messages removed, I don't see the crash. However, the
Linux boots very...very slow.

EFI stub: Booting Linux Kernel...
EFI stub: EFI_RNG_PROTOCOL unavailable
SetMemoryAttributes: BaseAddress == 0x22DC00000, Length == 0x1CE0000, Attributes == 0x20000
SetMemoryAttributes: BaseAddress == 0x22F8E0000, Length == 0xE50000, Attributes == 0x4000
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services...
SetUefiImageMemoryAttributes - 0x000000023BE60000 - 0x0000000000040000 (0x0000000000000008)
SetUefiImageMemoryAttributes - 0x0000000238AF0000 - 0x0000000000040000 (0x0000000000000008)
SetUefiImageMemoryAttributes - 0x0000000238AA0000 - 0x0000000000040000 (0x0000000000000008)
SetUefiImageMemoryAttributes - 0x0000000238A50000 - 0x0000000000040000 (0x0000000000000008)
SetUefiImageMemoryAttributes - 0x0000000238960000 - 0x0000000000040000 (0x0000000000000008)
SetUefiImageMemoryAttributes - 0x000000023BE20000 - 0x0000000000030000 (0x0000000000000008)
SetUefiImageMemoryAttributes - 0x0000000238860000 - 0x0000000000030000 (0x0000000000000008)
SetUefiImageMemoryAttributes - 0x0000000238820000 - 0x0000000000030000 (0x0000000000000008)   <<< At least 10 minutes' gap between this and next line of log
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
       :
[   24.057340] Remapping and enabling EFI services.
[   26.618330] smp: Bringing up secondary CPUs ...                                            <<< PSCI service responses very slow
[   28.818256] Detected PIPT I-cache on CPU1
[   28.985946] GICv3: CPU1: found redistributor 1 region 0:0x00000000080c0000
[   29.055568] GICv3: CPU1: using allocated LPI pending table @0x00000001000c0000
[   29.203572] CPU1: Booted secondary processor 0x0000000001 [0x000f0510]
[   36.075187] Detected PIPT I-cache on CPU2
[   36.119712] GICv3: CPU2: found redistributor 2 region 0:0x00000000080e0000
[   36.144795] GICv3: CPU2: using allocated LPI pending table @0x00000001000d0000
[   36.213252] CPU2: Booted secondary processor 0x0000000002 [0x000f0510]
[  115.355610] Detected PIPT I-cache on CPU3
[  115.402037] GICv3: CPU3: found redistributor 3 region 0:0x0000000008100000
[  115.426918] GICv3: CPU3: using allocated LPI pending table @0x00000001000e0000
[  115.508456] CPU3: Booted secondary processor 0x0000000003 [0x000f0510]
[  134.596700] Detected PIPT I-cache on CPU4
[  134.645280] GICv3: CPU4: found redistributor 4 region 0:0x0000000008120000
[  134.670010] GICv3: CPU4: using allocated LPI pending table @0x00000001000f0000
[  134.763347] CPU4: Booted secondary processor 0x0000000004 [0x000f0510]
[  156.200377] Detected PIPT I-cache on CPU5
[  156.251349] GICv3: CPU5: found redistributor 5 region 0:0x0000000008140000
[  156.277133] GICv3: CPU5: using allocated LPI pending table @0x0000000100100000
[  156.382948] CPU5: Booted secondary processor 0x0000000005 [0x000f0510]
[  176.521840] Detected PIPT I-cache on CPU6
[  176.575053] GICv3: CPU6: found redistributor 6 region 0:0x0000000008160000
[  176.600415] GICv3: CPU6: using allocated LPI pending table @0x0000000100110000
[  176.720944] CPU6: Booted secondary processor 0x0000000006 [0x000f0510]
[  198.444988] Detected PIPT I-cache on CPU7
[  198.499710] GICv3: CPU7: found redistributor 7 region 0:0x0000000008180000
[  198.524345] GICv3: CPU7: using allocated LPI pending table @0x0000000100120000
[  198.654758] CPU7: Booted secondary processor 0x0000000007 [0x000f0510]
[  218.456900] smp: Brought up 1 node, 8 CPUs
[  218.590983] SMP: Total of 8 processors activated.
[  218.625265] CPU: All CPU(s) started at EL2
     :
[  758.664394] PTP clock support registered
[  760.772801] EDAC MC: Ver: 3.0.0
[  764.767946] scmi_core: SCMI protocol bus registered
[  767.858837] efivars: Registered efivars operations
[  779.386548] FPGA manager framework
[  780.749886] Advanced Linux Sound Architecture Driver Initialized.
[  797.557785] vgaarb: loaded                                                            <<< No more output after this

It seems the EDK2 binary, built from upstream's 'edk2-stable202402' tag, doesn't work well.

Thanks,
Gavin


