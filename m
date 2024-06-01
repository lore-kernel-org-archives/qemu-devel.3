Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F78C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2024 10:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDLlS-0007dx-8F; Sat, 01 Jun 2024 06:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sDLlQ-0007d6-Hy
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 06:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sDLlN-0004Ac-0a
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 06:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717236897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y2DpfIgmiXljSAbvCsxE52pOuK29FTt6QPOWRmmD+tE=;
 b=UIbYuG35D0dFBX7o+nOC+Adu2VehcnEbsg9kpwcbjMisKlTIapYsSF3UVo3KyoOwQN26BB
 jnUP7qqqTORUl/CE9ZMXVovVq6vuGzhKwAvQVe0c1mvWVfsSoJ9IN7HTq9PKwQfQHGcVjm
 E1SUQQT0tvWEI/46Ehhw+44nooSXy4Y=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-46TVw6PGNYWnOpnTe1cY9Q-1; Sat, 01 Jun 2024 06:14:54 -0400
X-MC-Unique: 46TVw6PGNYWnOpnTe1cY9Q-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1f4d6fc14f3so22505665ad.1
 for <qemu-devel@nongnu.org>; Sat, 01 Jun 2024 03:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717236893; x=1717841693;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y2DpfIgmiXljSAbvCsxE52pOuK29FTt6QPOWRmmD+tE=;
 b=eC2oxXiGSBdoGik+CBfFMDJCL/9ToIy5fcdK8HkqWtp5k9p41ti0FzN1qLE9Z6+6Lr
 /j/4YtHUt9thwVnmAPb6OQzHcIEcywUmPTcNTXJo0RxKDO0WBt6JWxpH/n1xHuQMXO1Y
 FnsAI3lhRkTdjpEWjgDNZY6rybZqElgFowKaSlwVCg3n4rlQJFpEzutwD3fkcoPYo9/n
 gmklQvvPj3vduTYjGypyPF7/0xDswk5kjU7h2FWTHRHKiJ9lY397GTrrNuemrodjBolN
 vvm/arxEfn6M6jFkKeeKOxCO1RSvORDA6rV39Fw2FMSFAIdb9vcCfgfPO8z0EBLQI9Kp
 FixA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXulsossl55d8L7imAj1hQ0c9S/pVTuyj0SrM11oGWTm2RNZYx6e8kGintclu95IQ4C+eF7BuHbCEOi3CAorgMUHL5mzvk=
X-Gm-Message-State: AOJu0YzubfIuMVLx14hutrqsuXI2DhfpOORB6K+16wk2ExLGpwe63MTv
 H1/w1MIaLUBwbhP+KpXOW7IChtUEjBTt9eMttjq03YjdBFJwmcu8jw7Pjp711o4cVnwpddOceJ8
 oA/ff545s7MsDJMRGoFNhK6Ml+SEx87Tuo4VkdgN9cyb6vRBLHnPy
X-Received: by 2002:a17:902:cccb:b0:1f4:75ec:9968 with SMTP id
 d9443c01a7336-1f61be6be90mr119351765ad.16.1717236892773; 
 Sat, 01 Jun 2024 03:14:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIvSBcBcdSJoBMMcMbGus1yCmwSFOxuBtC1Z+6Jbiee10Wi0wPxa+S741Tri8a8sebQgzYWw==
X-Received: by 2002:a17:902:cccb:b0:1f4:75ec:9968 with SMTP id
 d9443c01a7336-1f61be6be90mr119351465ad.16.1717236892206; 
 Sat, 01 Jun 2024 03:14:52 -0700 (PDT)
Received: from [192.168.68.50] ([103.210.27.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6324013c3sm29984455ad.246.2024.06.01.03.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jun 2024 03:14:51 -0700 (PDT)
Message-ID: <bd1f84bd-e23c-4f4b-bc0b-a2a1b70081f4@redhat.com>
Date: Sat, 1 Jun 2024 20:14:46 +1000
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
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240531150922.GA83195@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Jean and Ard,

On 6/1/24 01:09, Jean-Philippe Brucker wrote:
> On Fri, May 31, 2024 at 04:23:13PM +1000, Gavin Shan wrote:
>> I got a chance to try CCA software components, suggested by [1]. However, the edk2
>> is stuck somewhere. I didn't reach to stage of loading guest kernel yet. I'm replying
>> to see if anyone has a idea.
> ...
>> INFO:    BL31: Preparing for EL3 exit to normal world
>> INFO:    Entry point address = 0x60000000
>> INFO:    SPSR = 0x3c9
>> UEFI firmware (version  built at 01:31:23 on May 31 2024)
>>
>> The boot is stuck and no more output after that. I tried adding more verbose output
>> from edk2 and found it's stuck at the following point.
>>
>>
>> ArmVirtPkg/PrePi/PrePi.c::PrePiMain
>> rmVirtPkg/Library/PlatformPeiLib/PlatformPeiLib.c::PlatformPeim
>>
>>   #ifdef MDE_CPU_AARCH64
>>    //
>>    // Set the SMCCC conduit to SMC if executing at EL2, which is typically the
>>    // exception level that services HVCs rather than the one that invokes them.
>>    //
>>    if (ArmReadCurrentEL () == AARCH64_EL2) {
>>      Status = PcdSetBoolS (PcdMonitorConduitHvc, FALSE);       // The function is never returned in my case
>>      ASSERT_EFI_ERROR (Status);
>>    }
>>   #endif
> 
> I'm able to reproduce this even without RME. This code was introduced
> recently by c98f7f755089 ("ArmVirtPkg: Use dynamic PCD to set the SMCCC
> conduit"). Maybe Ard (Cc'd) knows what could be going wrong here.
> 
> A slightly reduced reproducer:
> 
> $ cd edk2/
> $ build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemuKernel.dsc
> $ cd ..
> 
> $ git clone https://github.com/ARM-software/arm-trusted-firmware.git tf-a
> $ cd tf-a/
> $ make -j CROSS_COMPILE=aarch64-linux-gnu- PLAT=qemu DEBUG=1 LOG_LEVEL=40 QEMU_USE_GIC_DRIVER=QEMU_GICV3 BL33=../edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd all fip && \
>    dd if=build/qemu/debug/bl1.bin of=flash.bin && \
>    dd if=build/qemu/debug/fip.bin of=flash.bin seek=64 bs=4096
> $ qemu-system-aarch64 -M virt,virtualization=on,secure=on,gic-version=3 -cpu max -m 2G -smp 8 -monitor none -serial mon:stdio -nographic -bios flash.bin
> 

Thanks for the hints. Eventually, I'm able to start the host with 'edk2-stable202402'.
Note that 'edk2-stable202405' doesn't work. However, I failed to build the edk2 for
guest and unable to start the guest successfully, more information is provided below.

--> host's edk2

# git clone git@github.com:gwshan/edk2.git edk2
# cd edk2; git checkout edk2-stable202402 -b stable202402
# git submodule update --init --recursive;      \
   source edksetup.sh; make -j -C BaseTools;     \
   export GCC5_AARCH64_PREFIX=;                  \
   build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemuKernel.dsc

---> tf-a: rebuild using commands as you suggested.

---> Boot host

/home/gavin/sandbox/qemu.main/build/qemu-system-aarch64                                           \
-M virt,virtualization=on,secure=on,gic-version=3,acpi=off                                        \
-cpu max,x-rme=on -m 8G -smp 8                                                                    \
-nodefaults -monitor none -serial mon:stdio -nographic                                            \
-bios /home/gavin/sandbox/CCA/tf-a/flash.bin                                                      \
-kernel /home/gavin/sandbox/CCA/linux/arch/arm64/boot/Image                                       \
-drive format=raw,if=none,file=/home/gavin/sandbox/CCA/buildroot/output/images/rootfs.ext4,id=hd0 \
-device virtio-blk-pci,drive=hd0                                                                  \
-netdev tap,id=tap0,vhost=false,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown                 \
-device virtio-net-pci,netdev=tap0,mac=52:54:00:f1:26:b0                                          \
-append root=/dev/vda console=ttyAMA0                                                             \
-device virtio-9p-device,fsdev=shr0,mount_tag=shr0                                                \
-fsdev local,security_model=none,path=/home/gavin/sandbox/CCA,id=shr0
   :
NOTICE:  Booting Trusted Firmware
NOTICE:  BL1: v2.10.0(debug):99e0b97aa-dirty
NOTICE:  BL1: Built : 00:31:35, May 31 2024
INFO:    BL1: RAM 0xe0ee000 - 0xe0f7000
INFO:    BL1: Loading BL2
   :
Booting RMM v.0.4.0(debug) 17924bc Built with GCC 11.4.1
RMM-EL3 Interface v.0.2
Boot Manifest Interface v.0.3
RMI/RSI ABI v.1.0/1.0 built: May 31 2024 00:21:59
INFO:    RMM init end.
   :
UEFI firmware (version  built at 04:07:42 on Jun  1 2024)
PlatformPeim: PL011 UART (console) @ 0x9000000
PlatformPeim: PL011 UART (debug) @ 0x9000000
   :
EFI stub: Booting Linux Kernel...
EFI stub: EFI_RNG_PROTOCOL unavailable
   :
Welcome to Buildroot
buildroot login:
# ifconfig eth0 | grep 'inet addr'
           inet addr:10.26.1.212  Bcast:10.26.1.255  Mask:255.255.255.0

---> guest edk2

# git clone https://git.codelinaro.org/linaro/dcap/edk2.git edk2-guest
# cd edk2-guest; git checkout origin/cca/v2 -b cca/v2
# git submodule update --init --recursive;  \
   source edksetup.sh; make -j -C BaseTools; \
   export GCC5_AARCH64_PREFIX=;              \
   build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc
    :
   WriteSections64(): /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore/DEBUG/ArmPlatformPrePeiCore.dll AARCH64 small code model requires identical ELF and PE/COFF section offsets modulo 4 KB.
cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/OvmfPkg/VirtioFsDxe/VirtioFsDxe/DEBUG/VirtioFsDxe.dll /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/OvmfPkg/VirtioFsDxe/VirtioFsDxe/DEBUG/VirtioFsDxe.debug
cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/Disk/PartitionDxe/PartitionDxe/DEBUG/PartitionDxe.debug /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/PartitionDxe.debug
"gcc" -MMD -MF /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/CryptoPkg/Library/OpensslLib/OpensslLibCrypto/OUTPUT/openssl/crypto/asn1/x_sig.obj.deps @/home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/CryptoPkg/Library/OpensslLib/OpensslLibCrypto/OUTPUT/cc_resp.txt  -c -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/CryptoPkg/Library/OpensslLib/OpensslLibCrypto/OUTPUT/openssl/crypto/asn1/x_sig.obj  /home/gavin/sandbox/CCA/edk2-guest/CryptoPkg/Library/OpensslLib/openssl/crypto/asn1/x_sig.c
"GenFw" -e DXE_CORE -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/OUTPUT/DxeCore.efi /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll
GenSec -s EFI_SECTION_USER_INTERFACE -n ArmCpuDxe -o /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/Ffs/B8D9777E-D72A-451F-9BDB-BAFB52A68415ArmCpuDxe/B8D9777E-D72A-451F-9BDB-BAFB52A68415SEC3.ui
cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/DisplayEngineDxe/DisplayEngineDxe/DEBUG/*.map /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/DisplayEngineDxe/DisplayEngineDxe/OUTPUT
cp -p -f /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/Disk/UdfDxe/UdfDxe/OUTPUT/UdfDxe.efi /home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/MdeModulePkg/Universal/Disk/UdfDxe/UdfDxe/DEBUG
GenFw: ERROR 3000: Invalid
   :
build.py...
  : error 7000: Failed to execute command
	make tbuild [/home/gavin/sandbox/CCA/edk2-guest/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore]


build.py...
  : error F002: Failed to build module
	/home/gavin/sandbox/CCA/edk2-guest/ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore.inf [AARCH64, GCC5, DEBUG]

- Failed -
Build end time: 05:42:19, Jun.01 2024
Build total time: 00:00:31

---> Use the edk2 image from the latest QEMU source

# cd /home/gavin/sandbox/CCA
# cp /home/gavin/sandbox/qemu.main/build/pc-bios/edk2-aarch64-code.fd ./

---> Start the guest and no output from the console

host# mount | grep 9p
shr0 on /mnt/shr0 type 9p (rw,relatime,access=client,trans=virtio)
host# export SHR_DIR="/mnt/shr0"
host# qemu-system-aarch64 -accel kvm                              \
       -machine virt,gic-version=3,confidential-guest-support=rme0 \
       -cpu host -smp 2 -m 512M                                    \
       -object 'rme-guest,id=rme0,measurement-algo=sha512'         \
       -monitor none -serial mon:stdio -nographic                  \
       -bios /mnt/edk2-aarch64-code.fd                             \
       -kernel ${SHR_DIR}/linux/arch/arm64/boot/Image              \
       -initrd ${SHR_DIR}/buildroot/output/images/rootfs.cpio      \
       -append 'console=ttyAMA0'
         :
       <no output from the console>
         :
       (QEMU) q

There are some messages from host's console indicating RMI/RMM servicing
states when the guest is running at background. After the guest is terminated,
the host crashes.

SMC_RMM_RTT_CREATE            102dff000 122c2e000 1e00000 3 > RMI_SUCCESS
SMC_RMM_RTT_CREATE            102dff000 1234a7000 2000000 3 > RMI_SUCCESS
SMC_RMM_RTT_CREATE            102dff000 1235bd000 2200000 3 > RMI_SUCCESS
SMC_RMM_RTT_CREATE            102dff000 12387c000 2400000 3 > RMI_SUCCESS
SMC_RMM_RTT_CREATE            102dff000 123a5a000 2600000 3 > RMI_SUCCESS
SMC_RMM_RTT_CREATE            102dff000 12407d000 2800000 3 > RMI_SUCCESS
SMC_RMM_RTT_CREATE            102dff000 124109000 2a00000 3 > RMI_SUCCESS
SMC_RMM_RTT_CREATE            102dff000 123e49000 2c00000 3 > RMI_SUCCESS
SMC_RMM_RTT_CREATE            102dff000 124275000 2e00000 3 > RMI_SUCCESS
SMC_RMM_RTT_CREATE            102dff000 123138000 3000000 3 > RMI_SUCCESS
SMC_RMM_RTT_CREATE            102dff000 124d07000 3200000 3 > RMI_SUCCESS
  :
  :
[22768.994481] rcu: INFO: rcu_preempt self-detected stall on CPU
[22769.006861] rcu: 	3-....: (2751 ticks this GP) idle=93ec/1/0x4000000000000000 softirq=114451/115721 fqs=1160
[22769.020475] rcu: 	(t=5257 jiffies g=531913 q=7 ncpus=8)
[22769.030547] CPU: 3 PID: 198 Comm: qemu-system-aar Not tainted 6.9.0-rc1-gavin-gfcfc92d6ff07 #1
[22769.041847] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 2/2/2022
[22769.050548] pstate: 60402009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[22769.059382] pc : kvm_realm_unmap_range+0x308/0x32c
[22769.070275] lr : kvm_realm_unmap_range+0x304/0x32c
[22769.075893] sp : ffff800080a3b930
[22769.079929] x29: ffff800080a3b930 x28: 00000000003d7000 x27: 00000000003d6000
[22769.092990] x26: 00000000c4000152 x25: ffffffffffffffff x24: 0000000000000000
[22769.101150] x23: 0000010000000000 x22: 00000000c4000155 x21: 0000000102dff000
[22769.109056] x20: ffff8000801a5e00 x19: 0000000000000000 x18: 0000000000000001
[22769.117042] x17: 0000000000000000 x16: 000000000000000e x15: 0000000000000000
[22769.124991] x14: 0000ffff7fa14000 x13: 0000000000000002 x12: 000000000010d594
[22769.134213] x11: 0000000000000002 x10: 00000000ffffffff x9 : ffffffffffffffff
[22769.142951] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 00000000c2dff000
[22769.151413] x5 : 0000000102f56000 x4 : 0000000000000015 x3 : 0000000000000000
[22769.159932] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
[22769.169674] Call trace:
[22769.174026]  kvm_realm_unmap_range+0x308/0x32c
[22769.181046]  __unmap_stage2_range+0x60/0x7c
[22769.186396]  kvm_free_stage2_pgd+0xa0/0xd4
[22769.191766]  kvm_arch_flush_shadow_all+0x1c/0x34
[22769.197879]  kvm_mmu_notifier_release+0x30/0x84
[22769.203304]  __mmu_notifier_release+0x7c/0x1f8
[22769.209340]  exit_mmap+0x264/0x274
[22769.213992]  __mmput+0x40/0x150
[22769.218635]  mmput+0x50/0x5c
[22769.222606]  do_exit+0x288/0x92c
[22769.226935]  do_group_exit+0x34/0x90
[22769.231359]  get_signal+0x814/0x820
[22769.236537]  do_signal+0x90/0x1320
[22769.241145]  do_notify_resume+0xc8/0x140
[22769.246458]  el0_svc+0xc8/0xdc
[22769.250913]  el0t_64_sync_handler+0x13c/0x158
[22769.256045]  el0t_64_sync+0x190/0x194

Thanks,
Gavin





