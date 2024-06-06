Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BAAC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 05:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF5JS-0006Dp-2H; Thu, 06 Jun 2024 01:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sF5JQ-0006DY-Iq
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 01:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sF5JN-0003k9-UI
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 01:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717650314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCSumzjzDmjPXJOUPEKDGuagiSsXbpz9zqtzk7gilmY=;
 b=X0blJjWwq+nHRLBzhel8j7YyQWx8rWqWpEu78+W3+0bzqNlUQONnaJNlk5Nx5gBKTqmKz6
 Ctu7XAS49YvqPxO1kM+e6y8kCHXg039QpBqst0isp4Wai4hElXN1644Rec/ttfRuf/2UtP
 R5YNDRI5fPpDiOdIUx8ojvMF3VyZK14=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-d7XDOVi_P2m8RNc8y8L90A-1; Thu, 06 Jun 2024 01:05:10 -0400
X-MC-Unique: d7XDOVi_P2m8RNc8y8L90A-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-6ca1d5c4153so540879a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 22:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717650309; x=1718255109;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RCSumzjzDmjPXJOUPEKDGuagiSsXbpz9zqtzk7gilmY=;
 b=h7C1X0Gol1wONdEKpMQjA1ad4fRieA04lmedVcJcMQOutMcbUWWy2LuxJbvAQHSjY/
 SCU51CgQ3FsFYqCdOcjxnW1nzMHwwOf81iqqVJhl95BEslnqJSPV1KpHQsIGIv94cBcj
 a0aJ2jEcyrj1SCQTbHCEW/af6DT+sLroLCgMO6Jsb5zAqoJeB4gTIFCGyoEopBepad0f
 wK6jXoeqOLCGfNsGmLzcnIgUniEg/sBL4AS9m8Elv41KZEamNhStnaeSOMBVsh/QoEfe
 sboPGXnwdd+UUY05DfFdkHtpqmlJMuR8+jrKwOjyjMLLQEh0E3BrvznXTLs/63LVdGUi
 /OZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5Ddvau+7giusRNLwApJqqD68hFXnV0NWknTXUfL+l7tgh4bjVEXJw+vT/iXeF/p1trQjP98kASX9y2cSi878U6wWeto4=
X-Gm-Message-State: AOJu0YzxNxkRDNKVtA0ZT5rfNCazc/gL+yNU72fQZiIdu21FRYdEQSzn
 Mlo4EolYPXAnpwYwbxlJ6vIw8LLODPfRlurkH7Fw6d83xc+QGnTq+sLoA6GX+TBiqY9Mj1DB/8v
 Ykw5HbXlZNkGHmOrtrSe2MXz1bcqNRFWGJ/eWbFI1cSSLeecVEzE+
X-Received: by 2002:a05:6a20:2588:b0:1ad:999b:de34 with SMTP id
 adf61e73a8af0-1b2b710b89bmr6256367637.38.1717650308406; 
 Wed, 05 Jun 2024 22:05:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2cNP8RK4J3t42fG0hqJ/kpP5na0edumB4VXYvJNXwCd4HW1qVfft4gFZzIhis5qYqPCrD6g==
X-Received: by 2002:a05:6a20:2588:b0:1ad:999b:de34 with SMTP id
 adf61e73a8af0-1b2b710b89bmr6256342637.38.1717650307814; 
 Wed, 05 Jun 2024 22:05:07 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.224])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd774bf4sm4517435ad.114.2024.06.05.22.05.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 22:05:06 -0700 (PDT)
Message-ID: <1089f920-aff9-4d16-829d-5d058908a11e@redhat.com>
Date: Thu, 6 Jun 2024 15:05:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
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
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240605155608.GA3251699@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 6/6/24 01:56, Jean-Philippe Brucker wrote:
> On Wed, Jun 05, 2024 at 11:28:47AM +1000, Gavin Shan wrote:
>>>>     WriteSections64(): /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll AARCH64 small code model requires identical ELF and PE/COFF section offsets modulo 4 KB.
>>>
>>> Ah I've seen this once but it disappeared as I tried to investigate and
>>> I've since changed the implementation, so I don't have many notes about
>>> it.
>>>
>>> Maybe you could try to bisect from "ArmVirtPkg: ArmCcaIoMmu: Provide an
>>> implementation for SetAttribute", but it may give false positives if the
>>> error depends on some random linker placement. Could be
>>> "ArmVirtPkg/ArmPlatformLibQemu: Setup early UART mapping in a Realm" which
>>> adds a 4k page to the data section for the ealy RSI config call, though
>>> that has explicit 4kB alignment.
>>>
>>> In my notes I also wrote that changing "-z common-page-size=0x20" to 4k in
>>> the link flags may have made the error disappear, but I doubt it's the
>>> right fix.
>>>
>>> I'll try GCC 11 to see if I can reproduce.
>>>
>>
>> Ok. I run a git-bisect and the first problematic commit is 1153ae939c
>> ("ArmVirtPkg/ArmPlatformLibQemu: Add a third-level page table for the UART idmap")
> 
> Ah thanks, I'm able to reproduce the problem now, it was my local config
> that masked it.
> 
>>
>> I'm not familiar with edk2. The error is raised by BaseTools/Source/C/GenFw/Elf64Convert.c::WriteSections64()
>> where the relocatable address isn't properly aligned to 4KB. So I modified the code
>> as below, but I have to run two consecutive builds. In the first attempt build, I
>> still hit the same error.
> 
> This seems to be because GenFw generates a file even on error, so it
> doesn't retry the second time.
> 
> This commit moves the page tables from .rodata to .data. When linking
> IdMap.obj into ArmPlatformPrePeiCore.dll, the alignment of the .text
> section changes from 0x1000 to 0x800. This change comes from the linker
> script putting .rodata into .text. I don't know why the included .rodata
> alignment affects the .text alignment, but I don't think it matters here.
> 
> In GenFw, ScanSections64() calculates a mCoffAlignment as the max
> .text/.data/.hii section alignement. Since with this commit, .data
> alignement (0x1000) becomes larger than .text (0x800), it picks 0x1000 as
> the output text offset, and then WriteSections64() complains that this
> offset isn't equal to the input .text alignment modulo 0x1000.
> 
> The linker script says:
> 
>    /*
>     * The alignment of the .data section should be less than or equal to the
>     * alignment of the .text section. This ensures that the relative offset
>     * between these sections is the same in the ELF and the PE/COFF versions of
>     * this binary.
>     */
> 
> but that's not what we're getting. I don't have a fix yet, other than
> forcing the .text and .data alignment to 4k.
> 

Jean, thanks for your explanation. Right, the issue is caused by mismatched
alignments for ELF and PE/COFF sections. I ever dumped the variables at the
failing point, showing the mismatched alignments (0x800 vs 0x1000). Apart from
that, the virtual address of 'text' section is aligned to 0x800 instead of
0x1000 after ArmPlatformPrePeiCore.dll is dumped by 'readelf'.

SecHdr->sh_addr:                    0x800              <<< Mismatched alignment between ELF and PE/COFF
SecOffset:                          0x1000
SymShdr->sh_addr:                   0x800
mCoffSectionsOffset[Sym->st_shndx]: 0x1000
GenFw: ERROR 3000: Invalid
   WriteSections64(): /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll AARCH64 small code model requires identical ELF and PE/COFF section offsets modulo 4 KB.

# readelf -S Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll
Section Headers:
   [Nr] Name              Type             Address           Offset
        Size              EntSize          Flags  Link  Info  Align
   [ 0]                   NULL             0000000000000000  00000000
        0000000000000000  0000000000000000           0     0     0
   [ 1] .text             PROGBITS         0000000000000800  00000800       <<< Aligned to 0x800
        00000000000051b8  0000000000000000  AX       0     0     2048

With the following changes, I'm able to build the firmware successfully. I don't
see how COMMONPAGESIZE is sorted out because I don't find its definition in the
source code.

diff --git a/BaseTools/Scripts/GccBase.lds b/BaseTools/Scripts/GccBase.lds
index 9f27e83bb0..5463df47a9 100644
--- a/BaseTools/Scripts/GccBase.lds
+++ b/BaseTools/Scripts/GccBase.lds
@@ -20,7 +20,8 @@ SECTIONS {
     */
    . = PECOFF_HEADER_SIZE;
  
-  .text : ALIGN(CONSTANT(COMMONPAGESIZE)) {
+  /* .text : ALIGN(CONSTANT(COMMONPAGESIZE)) { */^M
+  .text : ALIGN(4096) {^M

# <rebuild>
# readelf -S Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll
There are 24 section headers, starting at offset 0x63050:

Section Headers:
   [Nr] Name              Type             Address           Offset
        Size              EntSize          Flags  Link  Info  Align
   [ 0]                   NULL             0000000000000000  00000000
        0000000000000000  0000000000000000           0     0     0
   [ 1] .text             PROGBITS         0000000000001000  00001000     <<< Aligned to 0x1000 now
        00000000000051b8  0000000000000000  AX       0     0     4096

Even the edk2 for the guest can be built successfully, but I'm not able to try it
because I'm unable to bring up the host now. I tried to rebuild the environment
from scratch, the host runs into crash inside EDK2 unfortunately...

   TF-RMM:   https://git.codelinaro.org/linaro/dcap/rmm.git                       (branch: cca/v2)
   EDK2:     git@github.com:tianocore/edk2.git                                    (tag:    edk2-stable202402)
   TF-A:     https://git.codelinaro.org/linaro/dcap/tf-a/trusted-firmware-a.git   (branch: cca/v2)
   QEMU:     https://git.qemu.org/git/qemu.git                                    (branch: master)
   KERNEL:   https://git.gitlab.arm.com/linux-arm/linux-cca.git                   (branch: cca-full/v2)
   BuildRoot: <doesn't matter at present>

arm64-server# home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
               -M virt,virtualization=on,secure=on,gic-version=3,acpi=off  \
               -cpu max,x-rme=on -m 8G -smp 8                              \
               -monitor none -serial mon:stdio -nographic -nodefaults      \
               -bios /home/gavin/sandbox/CCA/tf-a/flash.bin                \
               -kernel /home/gavin/sandbox/CCA/linux/arch/arm64/boot/Image \
               -append console=ttyAMA0 root=/dev/vda                       \
               -drive format=raw,if=none,file=/home/gavin/sandbox/CCA/buildroot/output/images/rootfs.ext4,id=hd0 \
               -device virtio-blk-pci,drive=hd0                            \
               -netdev tap,id=tap0,vhost=false,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
               -device virtio-net-pci,netdev=tap0,mac=52:54:00:f1:26:b0                          \
               -fsdev local,security_model=none,path=/home/gavin/sandbox/CCA,id=shr0             \
               -device virtio-9p-device,fsdev=shr0,mount_tag=shr0
                  :
NOTICE:  Booting Trusted Firmware
NOTICE:  BL1: v2.10.0(debug):99e0b97aa-dirty
NOTICE:  BL1: Built : 23:14:56, Jun  5 2024
INFO:    BL1: RAM 0xe0ee000 - 0xe0f7000
INFO:    BL1: Loading BL2
INFO:    Loading image id=1 at address 0xe06b000
INFO:    Image id=1 loaded: 0xe06b000 - 0xe0742d1
NOTICE:  BL1: Booting BL2
INFO:    Entry point address = 0xe06b000
INFO:    SPSR = 0x3cd
INFO:    [GPT] Boot Configuration
INFO:      PPS/T:     0x2/40
INFO:      PGS/P:     0x0/12
INFO:      L0GPTSZ/S: 0x0/30
INFO:      PAS count: 0x6
INFO:      L0 base:   0xedfe000
INFO:    [GPT] PAS[0]: base 0xe001000, size 0xff000, GPI 0xa, type 0x1
INFO:    [GPT] PAS[1]: base 0xe100000, size 0xcfe000, GPI 0x8, type 0x1
INFO:    [GPT] PAS[2]: base 0xedfe000, size 0x202000, GPI 0xa, type 0x1
INFO:    [GPT] PAS[3]: base 0x40000000, size 0x100000, GPI 0x9, type 0x1
INFO:    [GPT] PAS[4]: base 0x40100000, size 0x2800000, GPI 0xb, type 0x1
INFO:    [GPT] PAS[5]: base 0x42900000, size 0x1fd700000, GPI 0x9, type 0x1
INFO:    Enabling Granule Protection Checks
NOTICE:  BL2: v2.10.0(debug):99e0b97aa-dirty
NOTICE:  BL2: Built : 23:14:56, Jun  5 2024
INFO:    BL2: Doing platform setup
INFO:    Reserved RMM memory [0x40100000, 0x428fffff] in Device tree
INFO:    BL2: Loading image id 3
INFO:    Loading image id=3 at address 0xe0a0000
INFO:    Image id=3 loaded: 0xe0a0000 - 0xe0b10c4
INFO:    BL2: Loading image id 35
INFO:    Loading image id=35 at address 0x40100000
INFO:    Image id=35 loaded: 0x40100000 - 0x403033b0
INFO:    BL2: Loading image id 5
INFO:    Loading image id=5 at address 0x60000000
INFO:    Image id=5 loaded: 0x60000000 - 0x60200000
NOTICE:  BL2: Booting BL31
INFO:    Entry point address = 0xe0a0000
INFO:    SPSR = 0x3cd
NOTICE:  BL31: v2.10.0(debug):99e0b97aa-dirty
NOTICE:  BL31: Built : 23:14:56, Jun  5 2024
INFO:    GICv3 without legacy support detected.
INFO:    ARM GICv3 driver initialized in EL3
INFO:    Maximum SPI INTID supported: 287
INFO:    BL31: Initializing runtime services
INFO:    RMM setup done.
INFO:    BL31: Initializing RMM
INFO:    RMM init start.
Booting RMM v.0.4.0(debug) 17924bc Built with GCC 11.4.1
RMM-EL3 Interface v.0.2
Boot Manifest Interface v.0.3
RMI/RSI ABI v.1.0/1.0 built: Jun  5 2024 23:03:00
INFO:    RMM init end.
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0x60000000
INFO:    SPSR = 0x3c9
Loading driver at 0x00060009160 EntryPoint=0x00000000000
ArmVirtGetMemoryMap: Dumping System DRAM Memory Map:
	PhysicalBase: 0x40000000
	VirtualBase: 0x40000000
	Length: 0x200000000
UEFI firmware (version  built at 23:28:51 on Jun  5 2024)
PlatformPeim: PL011 UART (console) @ 0x9000000
PlatformPeim: PL011 UART (debug) @ 0x9000000
   :
EFI stub: Booting Linux Kernel...
EFI stub: EFI_RNG_PROTOCOL unavailable
SetMemoryAttributes: BaseAddress == 0x22DC00000, Length == 0x1CE0000, Attributes == 0x20000
SetMemoryAttributes: BaseAddress == 0x22F8E0000, Length == 0xE50000, Attributes == 0x4000
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services...
EFI stub: update_fdt() ... done
EFI stub: efi_exit_boot_services: enter
EFI stub: efi_exit_boot_services: efi_pci_disable_bridge_busmaster
EFI stub: efi_exit_boot_services: efi_get_memory_map
EFI stub: efi_exit_boot_services: priv_func
=====> CoreExitBootServices
MemoryProtectionExitBootServicesCallback - 0
SetUefiImageMemoryAttributes - 0x000000023BE60000 - 0x0000000000040000 (0x0000000000000008)
MemoryProtectionExitBootServicesCallback - 0
SetUefiImageMemoryAttributes - 0x0000000238AF0000 - 0x0000000000040000 (0x0000000000000008)
MemoryProtectionExitBootServicesCallback - 0
SetUefiImageMemoryAttributes - 0x0000000238AA0000 - 0x0000000000040000 (0x0000000000000008)
MemoryProtectionExitBootServicesCallback - 0
SetUefiImageMemoryAttributes - 0x0000000238A50000 - 0x0000000000040000 (0x0000000000000008)
MemoryProtectionExitBootServicesCallback - 0
SetUefiImageMemoryAttributes - 0x0000000238960000 - 0x0000000000040000 (0x0000000000000008)
MemoryProtectionExitBootServicesCallback - 0
SetUefiImageMemoryAttributes - 0x000000023BE20000 - 0x0000000000030000 (0x0000000000000008)
MemoryProtectionExitBootServicesCallback - 0
SetUefiImageMemoryAttributes - 0x0000000238860000 - 0x0000000000030000 (0x0000000000000008)
MemoryProtectionExitBootServicesCallback - 0
SetUefiImageMemoryAttributes - 0x0000000238820000 - 0x0000000000030000 (0x0000000000000008)
CoreExitBootServices: MemoryProtectionExitBootServicesCallback
CoreExitBootServices: SaveAndSetDebugTimer
CoreExitBootServices: gCpu->DisableInterrupt
CoreExitBootServices: CalculateEfiHdrCrc
CoreExitBootServices: Return with status=0x0


Synchronous Exception at 0x000000023248E9B4
PC 0x00023248E9B4
PC 0x00023248EA70
PC 0x00023248EBA8
PC 0x000232490FC8
PC 0x00023248A004
PC 0x00023248973C
PC 0x0002324894DC
PC 0x00023F2C7FA8 (0x00023F2C1000+0x00006FA8) [ 1] DxeCore.dll
PC 0x00023BCC6604 (0x00023BCBE000+0x00008604) [ 2] BdsDxe.dll
PC 0x00023F2CBC68 (0x00023F2C1000+0x0000AC68) [ 3] DxeCore.dll
[ 1] /home/gavin/sandbox/CCA/edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll
[ 2] /home/gavin/sandbox/CCA/edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/BdsDxe/BdsDxe/DEBUG/BdsDxe.dll
[ 3] /home/gavin/sandbox/CCA/edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll

   X0 0x0000000000000000   X1 0x000000023F2C0740   X2 0x000000000000000A   X3 0x00000002325D3E26
   X4 0x0000000000000020   X5 0xFFFFFFFFFFFFFFFE   X6 0x0000000000000000   X7 0x0000000000000000
   X8 0x0000000000000000   X9 0x0000000238820000  X10 0x000000000000002E  X11 0x00000000000023D0
  X12 0x00000000000023C4  X13 0x0000000000000001  X14 0x0000000000000002  X15 0x0000000000000000
  X16 0x000000023BD30280  X17 0x000000000066BD90  X18 0x0000000000000000  X19 0x000000023F2C0740
  X20 0x00000002325D3E27  X21 0x000000000000FFFF  X22 0x000000000000000D  X23 0x000000000010FFFF
  X24 0x000000000000D800  X25 0x000000023F2C0AA8  X26 0x00000002325E2000  X27 0x0000000000000002
  X28 0x0000000000000018   FP 0x000000023F2C06F0   LR 0x000000023248EA70

   V0 0x0000000000000000 0000000000000000   V1 0xFFFFFF80FFFFFFD0 000000023F2C0800
   V2 0x0000000000000000 0000000000000000   V3 0x0000000000000000 0000000000000000
   V4 0x0000000000000000 0000000000000000   V5 0x0000000000000000 0000000000000000
   V6 0x0000000000000000 0000000000000000   V7 0x0000000000000000 0000000000000000
   V8 0x0000000000000000 0000000000000000   V9 0x0000000000000000 0000000000000000
  V10 0x0000000000000000 0000000000000000  V11 0x0000000000000000 0000000000000000
  V12 0x0000000000000000 0000000000000000  V13 0x0000000000000000 0000000000000000
  V14 0x0000000000000000 0000000000000000  V15 0x0000000000000000 0000000000000000
  V16 0x0000000000000000 0000000000000000  V17 0x0000000000000000 0000000000000000
  V18 0x0000000000000000 0000000000000000  V19 0x0000000000000000 0000000000000000
  V20 0x0000000000000000 0000000000000000  V21 0x0000000000000000 0000000000000000
  V22 0x0000000000000000 0000000000000000  V23 0x0000000000000000 0000000000000000
  V24 0x0000000000000000 0000000000000000  V25 0x0000000000000000 0000000000000000
  V26 0x0000000000000000 0000000000000000  V27 0x0000000000000000 0000000000000000
  V28 0x0000000000000000 0000000000000000  V29 0x0000000000000000 0000000000000000
  V30 0x0000000000000000 0000000000000000  V31 0x0000000000000000 0000000000000000

   SP 0x000000023F2C06F0  ELR 0x000000023248E9B4  SPSR 0xA00002C9  FPSR 0x00000000
  ESR 0x96000006          FAR 0x0000000000000008

  ESR : EC 0x25  IL 0x1  ISS 0x00000006

Data abort: Translation fault, second level

Stack dump:
   000023F2C05F0: 000000023F2C06A0 000000023BD31FF4 0000000238820000 0000000000000002
   000023F2C0610: 000000023B1E2000 000000023FFF9000 0000000000000E20 00000000001FFFFF
   000023F2C0630: 0000000238850000 0000000000000001 0000000000000003 000000023FFF9E20
   000023F2C0650: 000000000000070C 0000000000000000 000000023F2C06D0 000000023F2DD644
   000023F2C0670: 000000023F2C07C8 000000023F2C095F 0000000000000001 000000023BD358ED
   000023F2C0690: 000000000000070C 0000000000000000 000000023F2C0750 000000023BD31FF4
   000023F2C06B0: 0000000238820000 0000000000000001 000000023FFF9000 000000023FFFA000
   000023F2C06D0: 000000023F2C07F0 000000023F2C2534 0000000000000001 0000000000000000
> 000023F2C06F0: 000000023F2C0700 000000023248EA70 000000023F2C0840 000000023248EBA8
   000023F2C0710: 00000002325D42BF 000000023B17E918 00000002325E2000 0000000232489978
   000023F2C0730: 000000023F2C0AB0 00000002325E2000 0020004900460045 0062007500740073
   000023F2C0750: 000000000020003A 0000000000000001 000000023F2C0860 0000000000000001
   000023F2C0770: 0000000000000002 00000000000000FF 0000000000000000 0000007F00000000
   000023F2C0790: 000000023F2C07F0 000000023F2C2548 000000023F2C07C0 000000023F2DEDD8
   000023F2C07B0: 000000023F2C088D 000000023F2EA000 000000023F2C07F0 000000023F2C2548
   000023F2C07D0: 0000000000000001 0000000000000000 000000023F2EB000 000000023F2EA000
ASSERT [ArmCpuDxe] /home/gavin/sandbox/CCA/edk2/ArmPkg/Library/DefaultExceptionHandlerLib/AArch64/DefaultExceptionHandler.c(343): ((BOOLEAN)(0==1))
  

>> ---> VirtPkg/Library/ArmPlatformLibQemu/IdMap.S
>>
>>    .align    12
>>    .globl    idmap
>>    .globl    uart_pte
>>    .section  ".data.idmap", "aw", %progbits
>>    .align    12
>>
>> # source edksetup.sh; export GCC5_AARCH64_PREFIX=
>> # make -j -C BaseTools; \                                               <<< Failed on the first attempt
>>    build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc
>>     :
>> WriteSections64(): /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll AARCH64 small code model requires identical ELF and PE/COFF section offsets modulo 4 KB.
>> make: *** [GNUmakefile:405: /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/OUTPUT/ArmPlatformPrePeiCore.efi] Error 2
>>
>> # make -j -C BaseTools; \                                              <<< Succeed on the second attempt
>>    build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc
>>     :
>> Generating FVMAIN FV
>> ######
>> Fd File Name:QEMU_VARS (/home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/QEMU_VARS.fd)
>>     :
>> - Done -
>> Build end time: 21:04:05, Jun.04 2024
>> Build total time: 00:00:06
>>
>> After that, I'm unable to start the guest with the edk2 image successfully.
>>
>> host# # mount | grep 9p
>> shr0 on /mnt/shr0 type 9p (rw,relatime,access=client,trans=virtio)
>> host# cat ./realm.sh
>> #!/bin/sh
>>
>> SHR_DIR="/mnt/shr0"
>>
>> qemu-system-aarch64 -accel kvm                              \
>> -machine virt,gic-version=3,confidential-guest-support=rme0 \
>> -cpu host -smp 2 -m 512M                                    \
>> -object 'rme-guest,id=rme0,measurement-algo=sha512'         \
>> -monitor none -serial mon:stdio -nographic                  \
>> -bios ${SHR_DIR}/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd \
>> -kernel ${SHR_DIR}/linux/arch/arm64/boot/Image              \
>> -initrd ${SHR_DIR}/buildroot/output/images/rootfs.cpio      \
>> -append 'console=ttyAMA0'
>>
>> host# ./realm.sh
>> UEFI firmware (version  built at 19:56:47 on Jun  4 2024)
>> add-symbol-file /home/gavin/sandbox/C                              <<< I don't see more output after it
> 
> I'm guessing in this case the firmware was corrupted because GenFw fails the
> first time and never generated a complete binary
> 

Yeah, the binary isn't reliable in this case.

>>>
>>> Note that the guest edk2 is optional and experimental, you can use direct
>>> kernel boot to get a working demo quicker.
>>>
>>
>> I never did this before. Could you please provide the detailed steps on this?
> 
> Removing the -bios parameter to QEMU should be enough. You can also add
> 'earlycon' to -append to show early boot errors.
> 

I didn't get a chance to try this yet since the host can't be brought up now.
I will try this later. I originally thought some sort of boot wrapper is needed
so that the kernel image has the capability to boot itself. For example, Mark
Rutland's boot wrapper [1] can be leveraged in this case. I don't think Image has
the capability to boot itself, right?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mark/boot-wrapper-aarch64.git

Thanks,
Gavin


