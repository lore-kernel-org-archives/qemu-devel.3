Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5750DC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 06:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCvhM-0008HN-1q; Fri, 31 May 2024 02:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sCvhL-0008H1-7D
 for qemu-devel@nongnu.org; Fri, 31 May 2024 02:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sCvhJ-0000UU-0h
 for qemu-devel@nongnu.org; Fri, 31 May 2024 02:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717136704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Qli6wGJDv3ImbfgBPUT7KZ6ewHmOt9LW3ZuwZPSeyE=;
 b=YElc7iJr8z9VkL0j/CzK4yAJRmyI15ZJK3LLrV05/SISr3mV7yvndWUeIYVczH0KHQqUuO
 Zq/0j6psUzPXclNbFIk14CA5I2fU4GYZtiV2PJZTSe7UNwxzynD1Iu9CFCq+Bx6mWfdX+s
 jz3uffj/gSoUN1I+BfVuySpQEq398jk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-XHqwlGD_NqC5Wie7PmxRcw-1; Fri, 31 May 2024 02:23:20 -0400
X-MC-Unique: XHqwlGD_NqC5Wie7PmxRcw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-70239c35ee4so1354466b3a.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 23:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717136599; x=1717741399;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Qli6wGJDv3ImbfgBPUT7KZ6ewHmOt9LW3ZuwZPSeyE=;
 b=R88DcoEG3qFUjvi+xT0NcCtOIkCBREnpWPJHQCqpOxTXYZKQERDFMRVQZuf7zMzCIg
 luFeIjmP4cjbtfhzEJKyCqPNIpGVv6BVFKnS9IdIccA2jrK6DaWkPHh/IOy3J/neemQx
 4OnQ+PjNnL1h68NTfdNJj9FFVq/oQC9ecWEaVGdG0HT+d/dWIUIB1N6NnjaxWZhr+zA5
 Q2jmuYmPly+EGfjBddaayG83giOzeO6188Iq2aUwjMUrmQH7VARUGosNi7maLuNqGnPD
 z9ef4BKxhrsPaqaw7xMPawyeygDplZVMpQtbXliy/+J61GIFY+yMslxhUhAo+JjCSh2t
 bLAA==
X-Gm-Message-State: AOJu0YzBz1TZkvM0pob1RxhAzS0h9SdnEFzLTjO6YFpeAt6UoivRQhCV
 g9aSWJb1q48QOIH/8wmoiEj27SqMZ/bUkeX6x93L8IyXt0DXJg+xnRaQZhxIZ1BD/FhF8TBzl1l
 kqXSrd2W/z3kqkjh+aEhDCPlmYuzb3oyQktxcaCTpmNJSiZg0AudF
X-Received: by 2002:a05:6a20:72a2:b0:1b2:663a:968f with SMTP id
 adf61e73a8af0-1b26f1f725amr1334544637.31.1717136599361; 
 Thu, 30 May 2024 23:23:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmwgDA5E0qVCt+R/BoL1c/89WKK4ds4f0mx9Bz5Tko2l0/KJUu91yTS6WAs9uC+Ht9vdPzmg==
X-Received: by 2002:a05:6a20:72a2:b0:1b2:663a:968f with SMTP id
 adf61e73a8af0-1b26f1f725amr1334517637.31.1717136598636; 
 Thu, 30 May 2024 23:23:18 -0700 (PDT)
Received: from [192.168.68.50] ([103.210.27.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f632367195sm8310555ad.94.2024.05.30.23.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 23:23:18 -0700 (PDT)
Message-ID: <cbd630d7-01e8-49ba-9c8b-a6514d898ed2@redhat.com>
Date: Fri, 31 May 2024 16:23:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
To: Itaru Kitayama <itaru.kitayama@linux.dev>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
 <4e7aa598-1a5d-47e1-aaa3-78af05947eeb@linaro.org>
 <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
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

On 5/31/24 14:19, Itaru Kitayama wrote:
>> On May 30, 2024, at 22:30, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> Cc'ing more developers
>>
>> On 30/5/24 06:30, Itaru Kitayama wrote:
>>> Hi,
>>> When I see a Realm VM creation fails with:
>>> Unexpected error in rme_configure_one() at ../target/arm/kvm-rme.c:159:
>>> qemu-system-aarch64: RME: failed to configure SVE: Invalid argument
>>> test.sh: line 8:  2502 Aborted                 qemu-system-aarch64 -M 'virt,acpi=off,gic-version=3' -cpu host -enable-kvm -smp 2 -m 512M -overcommit 'mem-lock=on' -M 'confidential-guest-support=rme0' -object 'rme-guest,id=rme0,measurement-algo=sha512,num-pmu-counters=6,sve-vector-length=256' -kernel Image -initrd rootfs.cpio -append 'earycon console=ttyAMA0 rdinit=/sbin/init' -nographic -net none
>>> do I need to suspect first the VMM, QEMU, or the Image? The kernel is built with LLVM, does it matter?
>>> Thanks,
>>> Itaru.
>>
> 
> I’m testing Jean’s repo at:
> 
> https://git.codelinaro.org/linaro/dcap/qemu/-/tree/cca/v2?ref_type=heads
> 

I got a chance to try CCA software components, suggested by [1]. However, the edk2
is stuck somewhere. I didn't reach to stage of loading guest kernel yet. I'm replying
to see if anyone has a idea.

[1] https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/Building+an+RME+stack+for+QEMU


---> tf-rmm

# git clone https://git.codelinaro.org/linaro/dcap/rmm.git tf-rmm
# cd tf-rmm
# git checkout origin/cca/v2 -b cca/v2
# git submodule update --init --recursive
# export CROSS_COMPILE=
# cmake -DCMAKE_BUILD_TYPE=Debug -DRMM_CONFIG=qemu_virt_defcfg -B build-qemu
# cmake --build build-qemu

---> edk2

# git clone git@github.com:tianocore/edk2.git
# cd edk2
# git submodule update --init --recursive
# source edksetup.sh
# make -j -C BaseTools
# export GCC5_AARCH64_PREFIX=
# build -b RELEASE -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemuKernel.dsc

---> tf-a

# git clone https://git.codelinaro.org/linaro/dcap/tf-a/trusted-firmware-a.git tf-a
# cd tf-a
# git checkout origin/cca/v2 -b cca/v2
# make -j CROSS_COMPILE= PLAT=qemu ENABLE_RME=1 DEBUG=1 LOG_LEVEL=40 \
   QEMU_USE_GIC_DRIVER=QEMU_GICV3 RMM=../rmm/build-qemu/Debug/rmm.img \
   BL33=../edk2/Build/ArmVirtQemuKernel-AARCH64/RELEASE_GCC5/FV/QEMU_EFI.fd all fip
# dd if=build/qemu/debug/bl1.bin of=flash.bin
# dd if=build/qemu/debug/fip.bin of=flash.bin seek=64 bs=4096

---> QEMU

# git clone https://git.qemu.org/git/qemu.git qemu.main
# cd qemu.main
# ./configure --target-list=aarch64-softmmu
# make -j 60

---> boot the host on the emulated hardware

/home/gavin/sandbox/qemu.main/build/qemu-system-aarch64                            \
-M virt,virtualization=on,secure=on,gic-version=3,acpi=off                         \
-cpu max,x-rme=on -m 8G -smp 8                                                     \
-nodefaults -monitor none -serial mon:stdio -nographic                             \
-bios /home/gavin/sandbox/CCA/tf-a/flash.bin                                       \
-kernel /home/gavin/sandbox/CCA/linux/arch/arm64/boot/Image                        \
-drive format=raw,if=none,file=${CCA}/buildroot/output/images/rootfs.ext4,id=hd0   \
-device virtio-blk-pci,drive=hd0                                                   \
-append "root=/dev/vda console=ttyAMA0"
   :
NOTICE:  Booting Trusted Firmware
NOTICE:  BL1: v2.10.0(debug):99e0b97aa-dirty
NOTICE:  BL1: Built : 00:31:35, May 31 2024
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
NOTICE:  BL2: Built : 00:31:35, May 31 2024
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
NOTICE:  BL31: Built : 00:31:35, May 31 2024
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
RMI/RSI ABI v.1.0/1.0 built: May 31 2024 00:21:59
INFO:    RMM init end.
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0x60000000
INFO:    SPSR = 0x3c9
UEFI firmware (version  built at 01:31:23 on May 31 2024)

The boot is stuck and no more output after that. I tried adding more verbose output
from edk2 and found it's stuck at the following point.


ArmVirtPkg/PrePi/PrePi.c::PrePiMain
rmVirtPkg/Library/PlatformPeiLib/PlatformPeiLib.c::PlatformPeim

  #ifdef MDE_CPU_AARCH64
   //
   // Set the SMCCC conduit to SMC if executing at EL2, which is typically the
   // exception level that services HVCs rather than the one that invokes them.
   //
   if (ArmReadCurrentEL () == AARCH64_EL2) {
     Status = PcdSetBoolS (PcdMonitorConduitHvc, FALSE);       // The function is never returned in my case
     ASSERT_EFI_ERROR (Status);
   }
  #endif

Thanks,
Gavin



