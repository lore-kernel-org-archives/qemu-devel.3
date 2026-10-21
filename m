Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E46606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Y+SOuqho
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJdTC-0001SD-MK; Wed, 21 Oct 2026 17:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xJdT0-0001RK-Oa
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 17:03:23 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xJdSy-000084-D9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 17:03:22 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3ad91684554so611737a91.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 14:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792616598; x=1793221398; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WQT0qPzr3Ls1jasnVTpNHtajcbGWRZOPvuwt8bwWQHU=;
 b=Y+SOuqhocbDdardjs3qyttJnTig/+DgRkUspgeadlvXl2u+E+mpKuYqIngACu1EKRt
 W48InLAoXFNz4I4s84HXtPYCqZy2iOfLhk1SjrS4Q1s5qkY6+EMpJk2Q34aQqCf24Dg0
 j0KVIqFItbnknamrgzvlIKxn6d4mtLR1HbZWqbjQ3PrFyI7jrdqJdYW5mvwyndkEq0CB
 SlEdI5lgrLhF3085yn8jZr6daArj3ENe5E1KQ6AiRackQGzHlp47duxZamVmsbgG/0gJ
 OV0VPJXqv9dmssAs3vo3KsmYQQzpymrf393lNwxruD11vO0F+3ESqQDaxvrp00KTc4l1
 UWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792616598; x=1793221398;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WQT0qPzr3Ls1jasnVTpNHtajcbGWRZOPvuwt8bwWQHU=;
 b=CgNlsHxjdbhjXxLZu0Jd/7oADac1HcnSdbPjIG9+gzZMhvfvAAT009xdNd7Nb11ee8
 xEjQeyKjD5jkaYSN2Y0vdczbH+AAWoqFm4E9XfqYsWdowhqheGrAv6RHRnkWc+O1JD9v
 7H4peLFSTDS8tHOc0LD0NbALiQT6yNrr9W7NYZ+sbWrTYMNOE4wC7JX/fRYK/89CdSW0
 9wI2Fg5/3tRv1+ysF6X8G/b4tb/FqP/C/RUx9yLF7BDJJTV/ONFL6db1S8mDWo2oWVbQ
 Su9IBPOZqWoNZZ1quiYqJYO9tVfMLC4Kux1QmUL8y3YyoeCnSZL9vp/L0jensF26WNFN
 vq5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+7zFA6YElypWHq2UYtkozFgAD1VgYAb8cqZIeAvVivHX6zGpjO2omBL84lph2pYFLNwF8V9CKS4hz@nongnu.org
X-Gm-Message-State: AFq9FYJGOdWoriPuReBiHyrCJGO5Qqbg6Uwk/x70QhVrMU9f+i8pLV9H
 qSKm/+LOVZ2BBSyQS+Rv/dZVN5tpec4P82QaTwwNCGYnd9MZMjjURoRnw0DluWipHNg=
X-Gm-Gg: AYBFou0wB49SmB1Xh3UOVfKuhW/R/LkSISoIWMNbkPvEDCp1lD6RNTYJVrgziUCj1Vj
 SDEvs6CqD/GjkVjqsmgVvmc7kcTus8Jrw8pyADEQI9vEboDfHOSm2R2iUgJ8JGRQbwdTv5/FXk8
 OtMTkS6WBkBjRXtcrHaZzdu1LzT4hICEfBtXGNbSZUgSAG0djqPzW3wcyfoKq5zo0H86wgJegjQ
 znmzBlu4UhG8khFjgYE4jxnqjUwNfE1qLA9cZV81oDbEpBy1lUjk1T6JJOGcBZSLd3MFHEna+zi
 713wm3x3SQ5RfXPpwJWpiUYV9IHV/uB/lNN7QGteB8pzvknfm6nYH45AJAIMXmdYPhTs0G3ib65
 udZkPKN8JSs9/oZ8PO8NuFBxz0CtjGlCS0z46d4THLs80tgpq9YMs2Lwjxz28W1zTNH366qgjfz
 FnWSWt3GCENbhz7c0JH7ikypuVYIWhtCwtitgQFo+eGhBgUjmroFYwkfD47ROgdeJDhXyhGt4zy
 cVJtiK3T9ZQEPSRKf+rLIYuKQOjZ6bMfMIEOvOKhGSSoyosqiCYWHk9f+0=
X-Received: by 2002:a17:90a:c887:b0:3a7:9413:cfae with SMTP id
 98e67ed59e1d1-3ad86f36215mr2395188a91.42.1792616597688; 
 Wed, 21 Oct 2026 14:03:17 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:8e8e:37a7:da6e:5dab])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada49544f1sm975697a91.16.2026.10.21.14.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 14:03:17 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:03:14 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
 enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [RFC v4 00/24] Add Realm support to QEMU-VMM
Message-ID: <atkokvqTHygpI8dt@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <7dea93a6-b119-4882-9c56-557a372b646a@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dea93a6-b119-4882-9c56-557a372b646a@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1035.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Gavin,

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
> 
> [1] https://git.gitlab.arm.com/linux-arm/linux-cca.git  (branch: cca/cca-host/kvm-v19/integration)
> 
> Note that the host is emulated using qemu (TCG mode) via 'virt' platform, using
> the following command lines
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

I was able to do the same manipulations on my side, but using the SBSA machine
for system emulation, with results as described below: 

> 
> (1) qemu is terminiated on qmp command 'dump-guest-memory'
> 
> (qemu) dump-guest-memory -p "/tmp/mem" 0x40000000 0x10000000
> **
> ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
> Bail out! ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
>

On my side this command causes the Realm to abort, as I expected it to be.
Realm memory should not be observable from the host.  There may be a debug mode
to enable this kind of operation but I will have to look at the documentation
for details.
 
> (2) qemu emulation can't be stopped and resumed
> 
> (qemu) stop
> (qemu) cont
> Failed to set KVM_REG_ARM_TIMER_CNT
> 

That too I was expecting.  Anything that can comprimise a Realm will cause the
HW to abort.  I'll investigate the "Failed to set KVM_REG_ARM_TIMER_CNT" error
message though.

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

I suspect 'system_reset' from the monitor and a 'reboot' from the command line
will, at some point, end up following the same sequence.  I need to think about
the 'reboot' use case further. 


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


I added the following to my Realm's boot command parameters:

-device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1 \
-device virtio-iommu-pci,bus=pcie.0 \


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

On my side I get to user space but virtio-serial and virtio-net don't work.  I'm
guessing virtio-iommu-pci does the same thing as this patch [1], but virtio
devices are disrupted because it is not configured properly.  I need to
investigate to find the best approach to follow, i.e implicitly use (and
configure) a virtio-iommu-pci or make sure that [1] and a virtio-iommu-pci
device can play nice together.   

Thanks,
Mathieu

[1]. [RFC v4 21/24] target/arm/kvm-rme: Add DMA remapping for the shared memory region


> Thanks,
> Gavin
> 

