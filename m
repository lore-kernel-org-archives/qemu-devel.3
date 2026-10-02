Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDC8CA5FE5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCjvP-0000aD-Sv; Fri, 02 Oct 2026 16:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjvM-0000ZP-6N
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:32:08 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjvH-0006om-OT
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:32:07 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-3a4c8262465so351671a91.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 13:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790973122; x=1791577922; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AHlsWKhIYMSy9PPscT7uDOI5j2DOuLJafaW6vdba0Vs=;
 b=fMe6s+yK3PBgtENpg+VnCd6KFGqESaoLdoIfPzIDfoY7etGRj1RrW9wy7i1g7BUCBa
 LMO9Hzw91LhJAp9fwZ/X8Jwftqge7chNrWgOkSeb553HrbC+KlJ+X3rZaZGaGg37JmGs
 2D/CrASALhyHc1WysHBd1pGHp/LTW33Hvm4dlcOcrYPeGwuquWLBdC/cGska1fod3K/o
 2XZt3ztq0Hno7zeHU0F1m4nipk65OuOy5pC/X5D1mWsQthd3wI3e0oaq5M1ctW4vImsA
 3G2UAAUoITmVg7mk8MiSJXffdoj8HEcgUKH1s5lfTn4yVmdsbr8nJ8cfpxS2u1X+m+qc
 s+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790973122; x=1791577922;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AHlsWKhIYMSy9PPscT7uDOI5j2DOuLJafaW6vdba0Vs=;
 b=jfRM/tDAwkzyEzX3NFx7h3d60/uPT+P0TrWZTsG1OJWeNzW2e3qEj6NX4ixkMFFeOm
 V0WlaR/OZNoumH1yewIq8hnfRncbiSoG6zwUG94JVVwvcwExjogQRF/huoCQnFRnXuk5
 Xlcfc8Z5UHxZ4glFGj8UdIUoBFQDy9h39lKzw+Yyn+Mk1w7OrbUuUCZY9Je/p67ZMz1N
 U+infcbzf5ekm7en2hsWd3PKowNq0y27AKY6wm+gYbybN+s7YpZCsUI7KuoVQ8zS1255
 69AI8dIKEBWfT0mToUPdo3DH8g31ZYAnXcNlFDNuFo2+yis7KcnBGmTI44FReiHxas+8
 6rzg==
X-Forwarded-Encrypted: i=1;
 AKwUvByyxU5hCSfLKb61tfD0hUu9O922x+Grgn17yl5hFP4DwHipbFlrFV3JFodHWutvdTzWM8AhED2q+fAE@nongnu.org
X-Gm-Message-State: AFq9FYKfrKJgkTXlTSqNoU6DuhBpbDHEPNgKbBdSLi/ynu9NC/Y6Ms7P
 Dnc7tq+e0yYqzUjp3JIkRxi8GraQ93vYVb9tCWDrtyW0t0w96dwC08JqcX9/UwO4sLQ=
X-Gm-Gg: AYBFou2SfpexpgQSwXClpydxMvDbdUG0giCev946FAOFryTCpJLS+beJjEAhKRcP6fO
 k/cZegy1IdqbIG8XSZlaif8UNsQxGaiwRKmH2L/FJ8JmIH4Er0IG/7O2h8EznXZqQ77AtcN0M7T
 joTxcc287XEqAN45j8prjDqmjoUxZMRYsRAG3mSM05Q96WbbO7kQX6ZklgfF32i73G7W0GOwNHt
 T+EC/8tZ/TEG+8+mKITAppUBpNcJMOCwMJb3zIvUTFFlmYWaneSOMFsw2ds4B5KSyb1vMt7FGLk
 SiViuKLPG3+OnA+gCPVuqdg+XChxe9+1rnpTIde9jIeAs581jPasJpTkrNV54bCjwyC/VXSRU57
 4ysw03fu4WezfgZPBTywP70whUslYCLKI1cXvjZpMulUAk4bfVirg7yC1/y3BBKtBYq582gRqkL
 1foKykEVeK+2je/X0eZ4yir8yXnfLDZsYZAVMByahkv31HrFPZ+42ERbPesPCUSl7J2peElTE1R
 A==
X-Received: by 2002:a17:90b:2251:b0:3a4:7195:ecbc with SMTP id
 98e67ed59e1d1-3a6ce791dcfmr3533567a91.29.1790973121660; 
 Fri, 02 Oct 2026 13:32:01 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:61ac:e744:6559:a357])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f471b16asm10533783a91.9.2026.10.02.13.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:32:01 -0700 (PDT)
Date: Fri, 2 Oct 2026 14:31:57 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
 enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [RFC v4 00/24] Add Realm support to QEMU-VMM
Message-ID: <asAUvdFhKSAi5QhE@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <7dea93a6-b119-4882-9c56-557a372b646a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dea93a6-b119-4882-9c56-557a372b646a@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Good day,

On Mon, Sep 21, 2026 at 02:05:19PM +1000, Gavin Shan wrote:
> Hi Mathieu,
> 
> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > This patchset provides minimal functionality to start a Realm VM
> > from an Arm RME capable host using the following command line:
> > 
> > qemu-system-aarch64 \
> >   -M confidential-guest-support=rme0,memory-backend=ram0 \
> >   -object rme-guest,id=rme0,convert-in-place=on \
> >   -object memory-backend-guest-memfd,id=ram0,size=1G,share=on \
> >   -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> > 
> > It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
> > back.  It is compatible with Steven Price's v16 revision [1] of his work adding
> > CCA support to KVM.
> > 
> > This revision is based on Michael Roth's work on guest memfd in-place memory
> > conversion [2], rebased to QEMU master.  I left out the AMD specific changes
> > from Michael's work because I can't test the result.  Other than the
> > modications to the linux headers, this series is identical to V3.
> > 
> > It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
> > here [3], along with the TF-A [4] and RMM [5] for the SBSA machine (compatible
> > with Steven's v16 patchset).  The Repository for the kernel [6] is also
> > available.  Note that for the latter, defines for
> > KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES and KVM_CAP_ARM_RMI have been modified to
> > follow QEMU master.
> > 
> > Instructions to compile and run the entire stack can be found here [7].
> > 
> > Device Assignment is not included.
> > 
> > Thanks,
> > Mathieu
> > 
> > [1]. https://lore.kernel.org/kvm/20260803134403.80630-1-steven.price@arm.com/
> > [2]. https://lore.kernel.org/kvm/20260528000416.8161-1-michael.roth@amd.com/
> > [3]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v4?ref_type=heads
> > [4]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
> > [5]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v16?ref_type=heads
> > [6]. https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v4?ref_type=heads
> > [7]. https://gitlab.com/Linaro/cca-public/build-instructions
> > 
> 
> Give this series and (v19) arm/cca host series [1] a try, and found the following
> issues. I'm sharing the found issues that I need take chance to look at them
> closely in future.

Thank you for taking the time.

> 
> [1] https://git.gitlab.arm.com/linux-arm/linux-cca.git  (branch: cca/cca-host/kvm-v19/integration)
> 
> Note that the host is emulated using qemu (TCG mode) via 'virt' platform, using
> the following command lines

I am currently focused on the SBSA machine but will try to reproduce your
manipulations using 'upstream-v5' that I just posted.

Note that upstream-v5 doesn't address any of the comments you posted today.
Since upstream-v4 was based on v16, I wanted to send another revision that is
based on the very latest (v21) to keep pace with Suzuki and Steven.

I am off to Linux Plumbers next week but rest assured that I will look into your
comments (and the content herein) when I'm back.  

Thanks,
Mathieu

> 
> laptop$ /home/gshan/sandbox/cca/host/qemu/build/qemu-system-aarch64                 \
>         -M virt,virtualization=on,secure=on,gic-version=3,acpi=off                  \
>         -cpu max,x-rme=on -m 4G -smp 8                                              \
>         -serial mon:stdio -monitor none -nographic -nodefaults                      \
>         -bios /home/gshan/sandbox/cca/host/tf-a/flash.bin                           \
>         -kernel /home/gshan/sandbox/cca/host/linux/arch/arm64/boot/Image            \
>         -initrd /home/gshan/sandbox/cca/host/buildroot/output/images/rootfs.cpio.xz \
>         -append kvm-arm.mode=rmm                                                    \
>         -device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                       \
>         -device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                       \
>         -device pcie-root-port,bus=pcie.0,chassis=3,id=pcie.3                       \
>         -device pcie-root-port,bus=pcie.0,chassis=4,id=pcie.4                       \
>         -device virtio-9p-device,fsdev=shr0,mount_tag=shr0                          \
>         -fsdev local,security_model=none,path=/home/gshan/sandbox/cca/guest,id=shr0 \
>         -netdev tap,id=tap1,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown       \
>         -device virtio-net-pci,bus=pcie.2,netdev=tap1,mac=b8:3f:d2:1d:3e:80
> 
> The realm VM is started using the following command lines.
> 
> host$ qemu-system-aarch64 -enable-kvm -object rme-guest,id=rme0,convert-in-place=on \
>       -machine virt,gic-version=3,confidential-guest-support=rme0 -m 2G -cpu host   \
>       -smp maxcpus=4,cpus=4,sockets=1,clusters=1,cores=2,threads=2                  \
>       -object memory-backend-guest-memfd,id=mem0,size=2G,share=on                   \
>       -numa node,nodeid=0,cpus=0-3,memdev=mem0                                      \
>       -serial mon:stdio -monitor none -nographic -nodefaults                        \
>       -kernel /mnt/linux/arch/arm64/boot/Image                                      \
>       -initrd /mnt/buildroot/output/images/rootfs.cpio.xz                           \
>       -append earlycon=pl011,mmio,0x10009000000
> 
> Found issues
> ============
> 
> (1) qemu is terminiated on qmp command 'dump-guest-memory'
> 
> (qemu) dump-guest-memory -p "/tmp/mem" 0x40000000 0x10000000
> **
> ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
> Bail out! ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
> 
> (2) qemu emulation can't be stopped and resumed
> 
> (qemu) stop
> (qemu) cont
> Failed to set KVM_REG_ARM_TIMER_CNT
> 
> (3) qemu is terminiated on qmp command 'system_reset'
> 
> (qemu) system_reset
> cpus are not resettable, terminating
> 
> (4) 'reboot' from the guest doesn't work
> 
> root@guest:~# reboot
>    :
> Requesting system reboot
> [  123.264893] reboot: Restarting system
> qemu-system-aarch64: cpus are not resettable, terminating
> 
> (5) Incompatible to virtio-iommu-pci. The realm guest doesn't boot up if a virtio-iommu-pci
>     device is specified in the command lines
> 
> host$ qemu-system-aarch64 -enable-kvm                                          \
> -object rme-guest,id=rme0,convert-in-place=on                                  \
> -machine virt,gic-version=3,confidential-guest-support=rme0                    \
> -m 2G -cpu host -smp maxcpus=4,cpus=4,sockets=1,clusters=1,cores=2,threads=2   \
> -object memory-backend-guest-memfd,id=mem0,size=2G,share=on                    \
> -numa node,nodeid=0,cpus=0-3,memdev=mem0                                       \
> -serial mon:stdio -monitor none -nographic -nodefaults                         \
> -kernel /mnt/linux/arch/arm64/boot/Image                                       \
> -initrd /mnt/buildroot/output/images/rootfs.cpio.xz                            \
> -append earlycon=pl011,mmio,0x10009000000                                      \
> -device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                          \
> -device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                          \
> -device virtio-iommu-pci,bus=pcie.0                                            \
> -drive file=/mnt/disk.qcow2,if=none,id=drive0                                  \
> -device virtio-blk-pci,id=virtblk0,bus=pcie.1,drive=drive0,num-queues=4        \
> -netdev tap,id=tap1,vhost=on,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
> -device virtio-net-pci,bus=pcie.2,netdev=tap1,mac=b8:3f:d2:1d:3e:c0
>      :
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> [    0.000000] Linux version 7.2.0-rc5-gavin-gf5098b6bae76 (gshan@nvidia-grace-hopper-01.khw.eng.bos2.dc.redhat.com) (gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4), GNU ld version 2.41-65.el10) #47 SMP PREEMPT Mon Jul 27 02:29:03 EDT 2026
> [    0.000000] KASLR enabled
> [    0.000000] Machine model: linux,dummy-virt
> [    0.000000] earlycon: pl11 at MMIO 0x0000010009000000 (options '')
> [    0.000000] printk: legacy bootconsole [pl11] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] OF: reserved mem: Reserved memory: No reserved-memory node in the DT
> [    0.000000] NODE_DATA(0) allocated [mem 0xbfbecb00-0xbfbf09bf]
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv1.1 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
> [    0.000000] psci: SMC Calling Convention v1.2
> [    0.000000] RME: Using RSI version 1.0
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000bfffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
>      :
> [    6.664423] Serial: AMBA PL011 UART driver
> [    7.151312] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 13, base_baud = 0) is a PL011 rev1
> [    7.213181] printk: console [ttyAMA0] enabled
> [    8.536454] HugeTLB: registered 1.00 Gi
> <...The realm guest stops here, no output since then...>
> 
> Thanks,
> Gavin
> 

