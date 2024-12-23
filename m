Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE0CE7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 13:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPisn-00010P-4s; Mon, 23 Dec 2024 08:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tPisk-0000zz-Bz
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 08:54:02 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tPise-0002Mt-45
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 08:54:02 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-85c436db302so2005964241.0
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 05:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734962034; x=1735566834;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kaXGsPxOsiOMnQlL1Dh9OznV6TV8D7aY2ZCDOgU6GWA=;
 b=1muxT4uiYvdXe1yxvpqIwUagKu5yWiUlN1CsRRg3fSbZBmtn3Swm7HlFkZrthINf7a
 JmtxGbSwjlFqTHOXqRpshIAUylFpNvTqHMBuvlEY0PAAijkmADGFz/sjSZMZHt4+9cdR
 XdtzLS9O7k0Mknoh9TWBoh4fiBXk009+Ex0RWUqZazmgef3rEBHtDNlgah8TrnRPNAwl
 VBA9RgTJJeKLyCCxu5d7pske/uPyLOUKFWi0RywFvRMWempC6zWQRz04gu97ExJe4PIW
 m9HxhevnGuggBgsZwqOURaCCMJiN1cTlyJoha/AeuJSZUXaWqmUaWnUN5HbD/Yblmv7+
 /FRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734962034; x=1735566834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kaXGsPxOsiOMnQlL1Dh9OznV6TV8D7aY2ZCDOgU6GWA=;
 b=Dc6s6Xqekw5nIcUElXsEoI5poiqoJTVgDQMpL/g+Gqoa9MsLqb5Dyr3epaP4d/mY5y
 m5yhLLopyXafLM5i4R68hnSHB7Oc94Sw9rtuT3LroI1Pg9YU4YT94M25lMUaIzXrsZ5B
 jKIo/RATPI71rwxZK+NlZHTHiV/+3in6IqemD+TynZYDMZrI/KYznYb0tOS0n/qjb7B0
 ywfUexWRkhf6NejFLXAtMEm8ZHYUFdXZM33Gr5Dg4Rr2cL3JBmSEOVlAuJOiDxxHQm8J
 EwxIlv646YV7E4x+hoXkQc3XS5Rjsf3AoGCZPcbzaRfDqvtKujuHQe5Dfwtg3wGg3l7H
 w9lw==
X-Gm-Message-State: AOJu0YyvgCy5N3L2pZc1v2FGLIaDMYYC3RJehlWvGatfXNzqje8ol6LQ
 SPU4OKzIfwYFJxHZc9KtfmloULcZrPhlZBjBAbAlQwtmG9k1V4ZVK+L+AZI2ZOA2634qjc3kMAc
 f4yDXIh5sM5GLPC9kSMyqOmwFplCNUwTu2eDm
X-Gm-Gg: ASbGnctdtNq/RWql3xX9Ha0VPYQgCPn0x21uKT3RjNlRpykiSDVh/c+sXHbVc15OlPl
 T5qWIQ+Ug92SGAmzlwJpHXoCJAbXr6eXaSDV83w==
X-Google-Smtp-Source: AGHT+IFp2icdCrXRtkuxeFc0ODFNTqaM1OXsSXi6678O//8tCIUH95jVBq7By8nQdpHMsZJcj8ccVckxYvD3/ap7dF8=
X-Received: by 2002:a67:e884:0:b0:4af:d554:add4 with SMTP id
 ada2fe7eead31-4b2bbd80fb9mr13969941137.0.1734962034104; Mon, 23 Dec 2024
 05:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20241218202036.80064-1-phil@philjordan.eu>
 <20241218202036.80064-16-phil@philjordan.eu>
 <1253b5c5-ddf3-4b55-8a7a-f3ab6ccb0fbe@daynix.com>
In-Reply-To: <1253b5c5-ddf3-4b55-8a7a-f3ab6ccb0fbe@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 23 Dec 2024 14:53:43 +0100
Message-ID: <CAAibmn1w46yD3qXueCMNZOge6PSXPdAgj9PhOn1CG+n9AcmsXg@mail.gmail.com>
Subject: Re: [PATCH v15 15/15] hw/vmapple/vmapple: Add vmapple machine type
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="000000000000bdf0890629f053ef"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::936;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x936.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000bdf0890629f053ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Dec 2024 at 11:50, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> Reviewing "[PATCH v2 6/6] hw/vmapple: XHCI controller's interrupt
> mapping workaround for macOS", I found a few problems so I'm adding
> comments for them:
>
> On 2024/12/19 5:20, Phil Dennis-Jordan wrote:
> > From: Alexander Graf <graf@amazon.com>
> >
> > Apple defines a new "vmapple" machine type as part of its proprietary
> > macOS Virtualization.Framework vmm. This machine type is similar to the
> > virt one, but with subtle differences in base devices, a few special
> > vmapple device additions and a vastly different boot chain.
> >
> > This patch reimplements this machine type in QEMU. To use it, you
> > have to have a readily installed version of macOS for VMApple,
> > run on macOS with -accel hvf, pass the Virtualization.Framework
> > boot rom (AVPBooter) in via -bios, pass the aux and root volume as pfla=
sh
> > and pass aux and root volume as virtio drives. In addition, you also
> > need to find the machine UUID and pass that as -M vmapple,uuid=3D
> parameter:
> >
> > $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=3D0x1234 -m 4G \
> >      -bios
> /System/Library/Frameworks/Virtualization.framework/Versions/A/Resources/=
AVPBooter.vmapple2.bin
> >      -drive file=3Daux,if=3Dpflash,format=3Draw \
> >      -drive file=3Droot,if=3Dpflash,format=3Draw \
> >      -drive file=3Daux,if=3Dnone,id=3Daux,format=3Draw \
> >      -device vmapple-virtio-blk-pci,variant=3Daux,drive=3Daux \
> >      -drive file=3Droot,if=3Dnone,id=3Droot,format=3Draw \
> >      -device vmapple-virtio-blk-pci,variant=3Droot,drive=3Droot
> >
> > With all these in place, you should be able to see macOS booting
> > successfully.
> >
> > Known issues:
> >   - Keyboard and mouse/tablet input is laggy. The reason for this is
> >     that macOS's XHCI driver seems to expect interrupter mapping to
> >     be disabled when MSI/MSI-X is unavailable. I have found a
> >     workaround but discovered a bunch of other XHCI spec non-compliance
> >     in the process, so I'm fixing all of those in a separate patch
> >     set.
> >   - Currently only macOS 12 guests are supported. The boot process for
> >     13+ will need further investigation and adjustment.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >
> > v3:
> >   * Rebased on latest upstream, updated affinity and NIC creation
> >     API usage
> >   * Included Apple-variant virtio-blk in build dependency
> >   * Updated API usage for setting 'redist-region-count' array-typed
> property on GIC.
> >   * Switched from virtio HID devices (for which macOS 12 does not conta=
in
> >     drivers) to an XHCI USB controller and USB HID devices.
> >
> > v4:
> >   * Fixups for v4 changes to the other patches in the set.
> >   * Corrected the assert macro to use
> >   * Removed superfluous endian conversions corresponding to cfg's.
> >   * Init error handling improvement.
> >   * No need to select CPU type on TCG, as only HVF is supported.
> >   * Machine type version bumped to 9.2
> >   * #include order improved
> >
> > v5:
> >   * Fixed memory reservation for ecam alias region.
> >   * Better error handling setting properties on devices.
> >   * Simplified the machine ECID/UUID extraction script and actually
> created a
> >     file for it rather than quoting its code in documentation.
> >
> > v7:
> >   * Tiny error handling fix, un-inlined function.
> >
> > v8:
> >   * Use object_property_add_uint64_ptr rather than defining custom UUID
> >     property get/set functions.
> >
> > v9:
> >   * Documentation improvements
> >   * Fixed variable name and struct field used during pvpanic device
> creation.
> >
> > v10:
> >   * Documentation fixup for changed virtio-blk device type.
> >   * Small improvements to shell commands in documentation.
> >   * Improved propagation of errors during cfg device instantiation.
> >
> > v11:
> >   * Quoted more strings in the documentation's shell script code.
> >
> > v13:
> >   * Bumped the machine type version from 9.2 to 10.0.
> >
> >   MAINTAINERS                 |   1 +
> >   contrib/vmapple/uuid.sh     |   9 +
> >   docs/system/arm/vmapple.rst |  63 ++++
> >   docs/system/target-arm.rst  |   1 +
> >   hw/vmapple/Kconfig          |  20 ++
> >   hw/vmapple/meson.build      |   1 +
> >   hw/vmapple/vmapple.c        | 648 +++++++++++++++++++++++++++++++++++=
+
> >   7 files changed, 743 insertions(+)
> >   create mode 100755 contrib/vmapple/uuid.sh
> >   create mode 100644 docs/system/arm/vmapple.rst
> >   create mode 100644 hw/vmapple/vmapple.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5d9d65e6df7..a8e3d3b74a2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2777,6 +2777,7 @@ M: Phil Dennis-Jordan <phil@philjordan.eu>
> >   S: Maintained
> >   F: hw/vmapple/*
> >   F: include/hw/vmapple/*
> > +F: docs/system/arm/vmapple.rst
> >
> >   Subsystems
> >   ----------
> > diff --git a/contrib/vmapple/uuid.sh b/contrib/vmapple/uuid.sh
> > new file mode 100755
> > index 00000000000..956e8c3afed
> > --- /dev/null
> > +++ b/contrib/vmapple/uuid.sh
> > @@ -0,0 +1,9 @@
> > +#!/bin/sh
> > +# Used for converting a guest provisioned using Virtualization.framewo=
rk
> > +# for use with the QEMU 'vmapple' aarch64 machine type.
> > +#
> > +# Extracts the Machine UUID from Virtualization.framework VM JSON file=
.
> > +# (as produced by 'macosvm', passed as command line argument)
> > +
> > +plutil -extract machineId raw "$1" | base64 -d | plutil -extract ECID
> raw -
> > +
> > diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst
> > new file mode 100644
> > index 00000000000..5090a8997c3
> > --- /dev/null
> > +++ b/docs/system/arm/vmapple.rst
> > @@ -0,0 +1,63 @@
> > +VMApple machine emulation
> >
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +VMApple is the device model that the macOS built-in hypervisor called
> "Virtualization.framework"
> > +exposes to Apple Silicon macOS guests. The "vmapple" machine model in
> QEMU implements the same
> > +device model, but does not use any code from Virtualization.Framework.
> > +
> > +Prerequisites
> > +-------------
> > +
> > +To run the vmapple machine model, you need to
> > +
> > + * Run on Apple Silicon
> > + * Run on macOS 12.0 or above
> > + * Have an already installed copy of a Virtualization.Framework macOS
> 12 virtual
> > +   machine. Note that newer versions than 12.x are currently NOT
> supported on
> > +   the guest side. I will assume that you installed it using the
> > +   `macosvm <https://github.com/s-u/macosvm>` CLI.
> > +
> > +First, we need to extract the UUID from the virtual machine that you
> installed. You can do this
> > +by running the shell script in contrib/vmapple/uuid.sh on the
> macosvm.json file.
> > +
> > +.. code-block:: bash
> > +  :caption: uuid.sh script to extract the UUID from a macosvm.json fil=
e
> > +
> > +  $ contrib/vmapple/uuid.sh "path/to/macosvm.json"
> > +
> > +Now we also need to trim the aux partition. It contains metadata that
> we can just discard:
> > +
> > +.. code-block:: bash
> > +  :caption: Command to trim the aux file
> > +
> > +  $ dd if=3D"aux.img" of=3D"aux.img.trimmed" bs=3D$(( 0x4000 )) skip=
=3D1
> > +
> > +How to run
> > +----------
> > +
> > +Then, we can launch QEMU with the Virtualization.Framework pre-boot
> environment and the readily
> > +installed target disk images. I recommend to port forward the VM's ssh
> and vnc ports to the host
> > +to get better interactive access into the target system:
> > +
> > +.. code-block:: bash
> > +  :caption: Example execution command line
> > +
> > +  $ UUID=3D"$(contrib/vmapple/uuid.sh 'macosvm.json')"
> > +  $
> AVPBOOTER=3D"/System/Library/Frameworks/Virtualization.framework/Resource=
s/AVPBooter.vmapple2.bin"
> > +  $ AUX=3D"aux.img.trimmed"
> > +  $ DISK=3D"disk.img"
> > +  $ qemu-system-aarch64 \
> > +       -serial mon:stdio \
> > +       -m 4G \
> > +       -accel hvf \
> > +       -M vmapple,uuid=3D"$UUID" \
> > +       -bios "$AVPBOOTER" \
> > +       -drive file=3D"$AUX",if=3Dpflash,format=3Draw \
> > +       -drive file=3D"$DISK",if=3Dpflash,format=3Draw \
> > +       -drive file=3D"$AUX",if=3Dnone,id=3Daux,format=3Draw \
> > +       -drive file=3D"$DISK",if=3Dnone,id=3Droot,format=3Draw \
> > +       -device vmapple-virtio-blk-pci,variant=3Daux,drive=3Daux \
> > +       -device vmapple-virtio-blk-pci,variant=3Droot,drive=3Droot \
> > +       -netdev
> user,id=3Dnet0,ipv6=3Doff,hostfwd=3Dtcp::2222-:22,hostfwd=3Dtcp::5901-:59=
00 \
> > +       -device virtio-net-pci,netdev=3Dnet0
> > +
> > diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> > index 9aaa9c414c9..3426f79100b 100644
> > --- a/docs/system/target-arm.rst
> > +++ b/docs/system/target-arm.rst
> > @@ -102,6 +102,7 @@ Board-specific documentation
> >      arm/stellaris
> >      arm/stm32
> >      arm/virt
> > +   arm/vmapple
> >      arm/xenpvh
> >      arm/xlnx-versal-virt
> >      arm/xlnx-zynq
> > diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> > index bcd1be63e3c..6a4c4a7fa2e 100644
> > --- a/hw/vmapple/Kconfig
> > +++ b/hw/vmapple/Kconfig
> > @@ -10,3 +10,23 @@ config VMAPPLE_CFG
> >   config VMAPPLE_VIRTIO_BLK
> >       bool
> >
> > +config VMAPPLE
> > +    bool
> > +    depends on ARM
> > +    depends on HVF
> > +    default y if ARM
> > +    imply PCI_DEVICES
> > +    select ARM_GIC
> > +    select PLATFORM_BUS
> > +    select PCI_EXPRESS
> > +    select PCI_EXPRESS_GENERIC_BRIDGE
> > +    select PL011 # UART
> > +    select PL031 # RTC
> > +    select PL061 # GPIO
> > +    select GPIO_PWR
> > +    select PVPANIC_MMIO
> > +    select VMAPPLE_AES
> > +    select VMAPPLE_BDIF
> > +    select VMAPPLE_CFG
> > +    select MAC_PVG_MMIO
> > +    select VMAPPLE_VIRTIO_BLK
> > diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> > index bf17cf906c9..e572f7d5602 100644
> > --- a/hw/vmapple/meson.build
> > +++ b/hw/vmapple/meson.build
> > @@ -2,3 +2,4 @@ system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true:
> files('aes.c'))
> >   system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'))
> >   system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true: files('cfg.c'))
> >   system_ss.add(when: 'CONFIG_VMAPPLE_VIRTIO_BLK',  if_true:
> files('virtio-blk.c'))
> > +specific_ss.add(when: 'CONFIG_VMAPPLE',     if_true: files('vmapple.c'=
))
> > diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
> > new file mode 100644
> > index 00000000000..66336942c8d
> > --- /dev/null
> > +++ b/hw/vmapple/vmapple.c
> > @@ -0,0 +1,648 @@
> > +/*
> > + * VMApple machine emulation
> > + *
> > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Right=
s
> Reserved.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * VMApple is the device model that the macOS built-in hypervisor call=
ed
> > + * "Virtualization.framework" exposes to Apple Silicon macOS guests. T=
he
> > + * machine model in this file implements the same device model in QEMU=
,
> but
> > + * does not use any code from Virtualization.Framework.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/bitops.h"
> > +#include "qemu/datadir.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/guest-random.h"
> > +#include "qemu/help-texts.h"
> > +#include "qemu/log.h"
> > +#include "qemu/module.h"
> > +#include "qemu/option.h"
> > +#include "qemu/units.h"
> > +#include "monitor/qdev.h"
> > +#include "hw/boards.h"
> > +#include "hw/irq.h"
> > +#include "hw/loader.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/sysbus.h"
> > +#include "hw/usb.h"
> > +#include "hw/arm/boot.h"
> > +#include "hw/arm/primecell.h"
> > +#include "hw/char/pl011.h"
> > +#include "hw/intc/arm_gic.h"
> > +#include "hw/intc/arm_gicv3_common.h"
> > +#include "hw/misc/pvpanic.h"
> > +#include "hw/pci-host/gpex.h"
> > +#include "hw/usb/xhci.h"
> > +#include "hw/virtio/virtio-pci.h"
> > +#include "hw/vmapple/vmapple.h"
> > +#include "net/net.h"
> > +#include "qapi/error.h"
> > +#include "qapi/qmp/qlist.h"
> > +#include "qapi/visitor.h"
> > +#include "qapi/qapi-visit-common.h"
> > +#include "standard-headers/linux/input.h"
> > +#include "sysemu/hvf.h"
> > +#include "sysemu/kvm.h"
> > +#include "sysemu/reset.h"
> > +#include "sysemu/runstate.h"
> > +#include "sysemu/sysemu.h"
> > +#include "target/arm/internals.h"
> > +#include "target/arm/kvm_arm.h"
> > +
> > +struct VMAppleMachineClass {
> > +    MachineClass parent;
> > +};
> > +
> > +struct VMAppleMachineState {
> > +    MachineState parent;
> > +
> > +    Notifier machine_done;
> > +    struct arm_boot_info bootinfo;
> > +    MemMapEntry *memmap;
> > +    const int *irqmap;
> > +    DeviceState *gic;
> > +    DeviceState *cfg;
> > +    DeviceState *pvpanic;
> > +    Notifier powerdown_notifier;
> > +    PCIBus *bus;
> > +    MemoryRegion fw_mr;
> > +    MemoryRegion ecam_alias;
> > +    uint64_t uuid;
> > +};
> > +
> > +#define DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, latest) \
>
> This macro has suffix "_LATEST", but it is used not only for the latest
> version but also for older versions.
>
> include/hw/boards.h suggests using "_IMPL" suffix.
>

Thanks for pointing this out, I've fixed it locally and will include it in
v16.

Adapting this giant macro for each machine type seems rather error-prone
and the kind of thing a computer does better than a human writing the code.
I can't help but wonder if we could define a generic version in boards.h
and only implement the DEFINE_*_MACHINE{_LATEST,}() wrappers specifically
for each machine type. I've created an issue for this on GitLab:
https://gitlab.com/qemu-project/qemu/-/issues/2744 I might attack that once
I've cut down my backlog of unmerged patches.


> > +    static void vmapple##major##_##minor##_class_init(ObjectClass *oc,=
 \
> > +                                                    void *data) \
> > +    { \
> > +        MachineClass *mc =3D MACHINE_CLASS(oc); \
> > +        vmapple_machine_##major##_##minor##_options(mc); \
> > +        mc->desc =3D "QEMU " # major "." # minor " Apple Virtual
> Machine"; \
> > +        if (latest) { \
> > +            mc->alias =3D "vmapple"; \
> > +        } \
> > +    } \
> > +    static const TypeInfo machvmapple##major##_##minor##_info =3D { \
> > +        .name =3D MACHINE_TYPE_NAME("vmapple-" # major "." # minor), \
> > +        .parent =3D TYPE_VMAPPLE_MACHINE, \
> > +        .class_init =3D vmapple##major##_##minor##_class_init, \
> > +    }; \
> > +    static void machvmapple_machine_##major##_##minor##_init(void) \
> > +    { \
> > +        type_register_static(&machvmapple##major##_##minor##_info); \
> > +    } \
> > +    type_init(machvmapple_machine_##major##_##minor##_init);
> > +
> > +#define DEFINE_VMAPPLE_MACHINE_AS_LATEST(major, minor) \
> > +    DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, true)
> > +#define DEFINE_VMAPPLE_MACHINE(major, minor) \
> > +    DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, false)
> > +
> > +#define TYPE_VMAPPLE_MACHINE   MACHINE_TYPE_NAME("vmapple")
> > +OBJECT_DECLARE_TYPE(VMAppleMachineState, VMAppleMachineClass,
> VMAPPLE_MACHINE)
> > +
> > +/* Number of external interrupt lines to configure the GIC with */
> > +#define NUM_IRQS 256
> > +
> > +enum {
> > +    VMAPPLE_FIRMWARE,
> > +    VMAPPLE_CONFIG,
> > +    VMAPPLE_MEM,
> > +    VMAPPLE_GIC_DIST,
> > +    VMAPPLE_GIC_REDIST,
> > +    VMAPPLE_UART,
> > +    VMAPPLE_RTC,
> > +    VMAPPLE_PCIE,
> > +    VMAPPLE_PCIE_MMIO,
> > +    VMAPPLE_PCIE_ECAM,
> > +    VMAPPLE_GPIO,
> > +    VMAPPLE_PVPANIC,
> > +    VMAPPLE_APV_GFX,
> > +    VMAPPLE_APV_IOSFC,
> > +    VMAPPLE_AES_1,
> > +    VMAPPLE_AES_2,
> > +    VMAPPLE_BDOOR,
> > +    VMAPPLE_MEMMAP_LAST,
> > +};
> > +
> > +static MemMapEntry memmap[] =3D {
> > +    [VMAPPLE_FIRMWARE] =3D           { 0x00100000, 0x00100000 },
> > +    [VMAPPLE_CONFIG] =3D             { 0x00400000, 0x00010000 },
> > +
> > +    [VMAPPLE_GIC_DIST] =3D           { 0x10000000, 0x00010000 },
> > +    [VMAPPLE_GIC_REDIST] =3D         { 0x10010000, 0x00400000 },
> > +
> > +    [VMAPPLE_UART] =3D               { 0x20010000, 0x00010000 },
> > +    [VMAPPLE_RTC] =3D                { 0x20050000, 0x00001000 },
> > +    [VMAPPLE_GPIO] =3D               { 0x20060000, 0x00001000 },
> > +    [VMAPPLE_PVPANIC] =3D            { 0x20070000, 0x00000002 },
> > +    [VMAPPLE_BDOOR] =3D              { 0x30000000, 0x00200000 },
> > +    [VMAPPLE_APV_GFX] =3D            { 0x30200000, 0x00010000 },
> > +    [VMAPPLE_APV_IOSFC] =3D          { 0x30210000, 0x00010000 },
> > +    [VMAPPLE_AES_1] =3D              { 0x30220000, 0x00004000 },
> > +    [VMAPPLE_AES_2] =3D              { 0x30230000, 0x00004000 },
> > +    [VMAPPLE_PCIE_ECAM] =3D          { 0x40000000, 0x10000000 },
> > +    [VMAPPLE_PCIE_MMIO] =3D          { 0x50000000, 0x1fff0000 },
> > +
> > +    /* Actual RAM size depends on configuration */
> > +    [VMAPPLE_MEM] =3D                { 0x70000000ULL, GiB},
> > +};
> > +
> > +static const int irqmap[] =3D {
> > +    [VMAPPLE_UART] =3D 1,
> > +    [VMAPPLE_RTC] =3D 2,
> > +    [VMAPPLE_GPIO] =3D 0x5,
> > +    [VMAPPLE_APV_IOSFC] =3D 0x10,
> > +    [VMAPPLE_APV_GFX] =3D 0x11,
> > +    [VMAPPLE_AES_1] =3D 0x12,
> > +    [VMAPPLE_PCIE] =3D 0x20,
> > +};
> > +
> > +#define GPEX_NUM_IRQS 16
> > +
> > +static void create_bdif(VMAppleMachineState *vms, MemoryRegion *mem)
> > +{
> > +    DeviceState *bdif;
> > +    SysBusDevice *bdif_sb;
> > +    DriveInfo *di_aux =3D drive_get(IF_PFLASH, 0, 0);
> > +    DriveInfo *di_root =3D drive_get(IF_PFLASH, 0, 1);
> > +
> > +    if (!di_aux) {
> > +        error_report("No AUX device. Please specify one as pflash
> drive.");
> > +        exit(1);
> > +    }
> > +
> > +    if (!di_root) {
> > +        /* Fall back to the first IF_VIRTIO device as root device */
> > +        di_root =3D drive_get(IF_VIRTIO, 0, 0);
> > +    }
> > +
> > +    if (!di_root) {
> > +        error_report("No root device. Please specify one as virtio
> drive.");
> > +        exit(1);
> > +    }
> > +
> > +    /* PV backdoor device */
> > +    bdif =3D qdev_new(TYPE_VMAPPLE_BDIF);
> > +    bdif_sb =3D SYS_BUS_DEVICE(bdif);
> > +    sysbus_mmio_map(bdif_sb, 0, vms->memmap[VMAPPLE_BDOOR].base);
> > +
> > +    qdev_prop_set_drive(DEVICE(bdif), "aux",
> blk_by_legacy_dinfo(di_aux));
> > +    qdev_prop_set_drive(DEVICE(bdif), "root",
> blk_by_legacy_dinfo(di_root));
> > +
> > +    sysbus_realize_and_unref(bdif_sb, &error_fatal);
> > +}
> > +
> > +static void create_pvpanic(VMAppleMachineState *vms, MemoryRegion *mem=
)
> > +{
> > +    SysBusDevice *pvpanic;
> > +
> > +    vms->pvpanic =3D qdev_new(TYPE_PVPANIC_MMIO_DEVICE);
> > +    pvpanic =3D SYS_BUS_DEVICE(vms->pvpanic);
> > +    sysbus_mmio_map(pvpanic, 0, vms->memmap[VMAPPLE_PVPANIC].base);
> > +
> > +    sysbus_realize_and_unref(pvpanic, &error_fatal);
> > +}
> > +
> > +static bool create_cfg(VMAppleMachineState *vms, MemoryRegion *mem,
> > +                       Error **errp)
> > +{
> > +    ERRP_GUARD();
> > +    SysBusDevice *cfg;
> > +    MachineState *machine =3D MACHINE(vms);
> > +    uint32_t rnd =3D 1;
> > +
> > +    vms->cfg =3D qdev_new(TYPE_VMAPPLE_CFG);
> > +    cfg =3D SYS_BUS_DEVICE(vms->cfg);
> > +    sysbus_mmio_map(cfg, 0, vms->memmap[VMAPPLE_CONFIG].base);
> > +
> > +    qemu_guest_getrandom_nofail(&rnd, sizeof(rnd));
> > +
> > +    qdev_prop_set_uint32(vms->cfg, "nr-cpus", machine->smp.cpus);
> > +    qdev_prop_set_uint64(vms->cfg, "ecid", vms->uuid);
> > +    qdev_prop_set_uint64(vms->cfg, "ram-size", machine->ram_size);
> > +    qdev_prop_set_uint32(vms->cfg, "rnd", rnd);
> > +
> > +    if (!sysbus_realize_and_unref(cfg, errp)) {
> > +        error_prepend(errp, "Error creating vmapple cfg device: ");
> > +        return false;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> > +static void create_gfx(VMAppleMachineState *vms, MemoryRegion *mem)
> > +{
> > +    int irq_gfx =3D vms->irqmap[VMAPPLE_APV_GFX];
> > +    int irq_iosfc =3D vms->irqmap[VMAPPLE_APV_IOSFC];
> > +    SysBusDevice *gfx;
> > +
> > +    gfx =3D SYS_BUS_DEVICE(qdev_new("apple-gfx-mmio"));
> > +    sysbus_mmio_map(gfx, 0, vms->memmap[VMAPPLE_APV_GFX].base);
> > +    sysbus_mmio_map(gfx, 1, vms->memmap[VMAPPLE_APV_IOSFC].base);
> > +    sysbus_connect_irq(gfx, 0, qdev_get_gpio_in(vms->gic, irq_gfx));
> > +    sysbus_connect_irq(gfx, 1, qdev_get_gpio_in(vms->gic, irq_iosfc));
> > +    sysbus_realize_and_unref(gfx, &error_fatal);
> > +}
> > +
> > +static void create_aes(VMAppleMachineState *vms, MemoryRegion *mem)
> > +{
> > +    int irq =3D vms->irqmap[VMAPPLE_AES_1];
> > +    SysBusDevice *aes;
> > +
> > +    aes =3D SYS_BUS_DEVICE(qdev_new(TYPE_APPLE_AES));
> > +    sysbus_mmio_map(aes, 0, vms->memmap[VMAPPLE_AES_1].base);
> > +    sysbus_mmio_map(aes, 1, vms->memmap[VMAPPLE_AES_2].base);
> > +    sysbus_connect_irq(aes, 0, qdev_get_gpio_in(vms->gic, irq));
> > +    sysbus_realize_and_unref(aes, &error_fatal);
> > +}
> > +
> > +static int arm_gic_ppi_index(int cpu_nr, int ppi_index)
> > +{
> > +    return NUM_IRQS + cpu_nr * GIC_INTERNAL + ppi_index;
> > +}
> > +
> > +static void create_gic(VMAppleMachineState *vms, MemoryRegion *mem)
> > +{
> > +    MachineState *ms =3D MACHINE(vms);
> > +    /* We create a standalone GIC */
> > +    SysBusDevice *gicbusdev;
> > +    QList *redist_region_count;
> > +    int i;
> > +    unsigned int smp_cpus =3D ms->smp.cpus;
> > +
> > +    vms->gic =3D qdev_new(gicv3_class_name());
> > +    qdev_prop_set_uint32(vms->gic, "revision", 3);
> > +    qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
> > +    /*
> > +     * Note that the num-irq property counts both internal and externa=
l
> > +     * interrupts; there are always 32 of the former (mandated by GIC
> spec).
> > +     */
> > +    qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
> > +
> > +    uint32_t redist0_capacity =3D
> > +                vms->memmap[VMAPPLE_GIC_REDIST].size /
> GICV3_REDIST_SIZE;
> > +    uint32_t redist0_count =3D MIN(smp_cpus, redist0_capacity);
> > +
> > +    redist_region_count =3D qlist_new();
> > +    qlist_append_int(redist_region_count, redist0_count);
> > +    qdev_prop_set_array(vms->gic, "redist-region-count",
> redist_region_count);
> > +
> > +    gicbusdev =3D SYS_BUS_DEVICE(vms->gic);
> > +    sysbus_realize_and_unref(gicbusdev, &error_fatal);
> > +    sysbus_mmio_map(gicbusdev, 0, vms->memmap[VMAPPLE_GIC_DIST].base);
> > +    sysbus_mmio_map(gicbusdev, 1, vms->memmap[VMAPPLE_GIC_REDIST].base=
);
> > +
> > +    /*
> > +     * Wire the outputs from each CPU's generic timer and the GICv3
> > +     * maintenance interrupt signal to the appropriate GIC PPI inputs,
> > +     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's
> inputs.
> > +     */
> > +    for (i =3D 0; i < smp_cpus; i++) {
> > +        DeviceState *cpudev =3D DEVICE(qemu_get_cpu(i));
> > +
> > +        /* Map the virt timer to PPI 27 */
> > +        qdev_connect_gpio_out(cpudev, GTIMER_VIRT,
> > +                              qdev_get_gpio_in(vms->gic,
> > +                                               arm_gic_ppi_index(i,
> 27)));
> > +
> > +        /* Map the GIC IRQ and FIQ lines to CPU */
> > +        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev,
> ARM_CPU_IRQ));
> > +        sysbus_connect_irq(gicbusdev, i + smp_cpus,
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> > +    }
> > +}
> > +
> > +static void create_uart(const VMAppleMachineState *vms, int uart,
> > +                        MemoryRegion *mem, Chardev *chr)
> > +{
> > +    hwaddr base =3D vms->memmap[uart].base;
> > +    int irq =3D vms->irqmap[uart];
> > +    DeviceState *dev =3D qdev_new(TYPE_PL011);
> > +    SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
> > +
> > +    qdev_prop_set_chr(dev, "chardev", chr);
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > +    memory_region_add_subregion(mem, base,
> > +                                sysbus_mmio_get_region(s, 0));
> > +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
> > +}
> > +
> > +static void create_rtc(const VMAppleMachineState *vms)
> > +{
> > +    hwaddr base =3D vms->memmap[VMAPPLE_RTC].base;
> > +    int irq =3D vms->irqmap[VMAPPLE_RTC];
> > +
> > +    sysbus_create_simple("pl031", base, qdev_get_gpio_in(vms->gic,
> irq));
> > +}
> > +
> > +static DeviceState *gpio_key_dev;
> > +static void vmapple_powerdown_req(Notifier *n, void *opaque)
> > +{
> > +    /* use gpio Pin 3 for power button event */
> > +    qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
> > +}
> > +
> > +static void create_gpio_devices(const VMAppleMachineState *vms, int
> gpio,
> > +                                MemoryRegion *mem)
> > +{
> > +    DeviceState *pl061_dev;
> > +    hwaddr base =3D vms->memmap[gpio].base;
> > +    int irq =3D vms->irqmap[gpio];
> > +    SysBusDevice *s;
> > +
> > +    pl061_dev =3D qdev_new("pl061");
> > +    /* Pull lines down to 0 if not driven by the PL061 */
> > +    qdev_prop_set_uint32(pl061_dev, "pullups", 0);
> > +    qdev_prop_set_uint32(pl061_dev, "pulldowns", 0xff);
> > +    s =3D SYS_BUS_DEVICE(pl061_dev);
> > +    sysbus_realize_and_unref(s, &error_fatal);
> > +    memory_region_add_subregion(mem, base, sysbus_mmio_get_region(s,
> 0));
> > +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
> > +    gpio_key_dev =3D sysbus_create_simple("gpio-key", -1,
> > +                                        qdev_get_gpio_in(pl061_dev, 3)=
);
> > +}
> > +
> > +static void vmapple_firmware_init(VMAppleMachineState *vms,
> > +                                  MemoryRegion *sysmem)
> > +{
> > +    hwaddr size =3D vms->memmap[VMAPPLE_FIRMWARE].size;
> > +    hwaddr base =3D vms->memmap[VMAPPLE_FIRMWARE].base;
> > +    const char *bios_name;
> > +    int image_size;
> > +    char *fname;
> > +
> > +    bios_name =3D MACHINE(vms)->firmware;
> > +    if (!bios_name) {
> > +        error_report("No firmware specified");
> > +        exit(1);
> > +    }
> > +
> > +    fname =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> > +    if (!fname) {
> > +        error_report("Could not find ROM image '%s'", bios_name);
> > +        exit(1);
> > +    }
> > +
> > +    memory_region_init_ram(&vms->fw_mr, NULL, "firmware", size,
> &error_fatal);
> > +    image_size =3D load_image_mr(fname, &vms->fw_mr);
> > +
> > +    g_free(fname);
> > +    if (image_size < 0) {
> > +        error_report("Could not load ROM image '%s'", bios_name);
> > +        exit(1);
> > +    }
> > +
> > +    memory_region_add_subregion(get_system_memory(), base, &vms->fw_mr=
);
> > +}
> > +
> > +static void create_pcie(VMAppleMachineState *vms)
> > +{
> > +    hwaddr base_mmio =3D vms->memmap[VMAPPLE_PCIE_MMIO].base;
> > +    hwaddr size_mmio =3D vms->memmap[VMAPPLE_PCIE_MMIO].size;
> > +    hwaddr base_ecam =3D vms->memmap[VMAPPLE_PCIE_ECAM].base;
> > +    hwaddr size_ecam =3D vms->memmap[VMAPPLE_PCIE_ECAM].size;
> > +    int irq =3D vms->irqmap[VMAPPLE_PCIE];
> > +    MemoryRegion *mmio_alias;
> > +    MemoryRegion *mmio_reg;
> > +    MemoryRegion *ecam_reg;
> > +    DeviceState *dev;
> > +    int i;
> > +    PCIHostState *pci;
> > +    DeviceState *usb_controller;
> > +    USBBus *usb_bus;
> > +
> > +    dev =3D qdev_new(TYPE_GPEX_HOST);
> > +    qdev_prop_set_uint32(dev, "num-irqs", GPEX_NUM_IRQS);
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > +
> > +    /* Map only the first size_ecam bytes of ECAM space */
> > +    ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> > +    memory_region_init_alias(&vms->ecam_alias, OBJECT(dev), "pcie-ecam=
",
> > +                             ecam_reg, 0, size_ecam);
> > +    memory_region_add_subregion(get_system_memory(), base_ecam,
> > +                                &vms->ecam_alias);
> > +
> > +    /*
> > +     * Map the MMIO window from [0x50000000-0x7fff0000] in PCI space
> into
> > +     * system address space at [0x50000000-0x7fff0000].
> > +     */
> > +    mmio_alias =3D g_new0(MemoryRegion, 1);
> > +    mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> > +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> > +                             mmio_reg, base_mmio, size_mmio);
> > +    memory_region_add_subregion(get_system_memory(), base_mmio,
> mmio_alias);
> > +
> > +    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
> > +                           qdev_get_gpio_in(vms->gic, irq + i));
> > +        gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
> > +    }
> > +
> > +    pci =3D PCI_HOST_BRIDGE(dev);
> > +    vms->bus =3D pci->bus;
> > +    g_assert(vms->bus);
> > +
> > +    while ((dev =3D qemu_create_nic_device("virtio-net-pci", true,
> NULL))) {
> > +        qdev_realize_and_unref(dev, BUS(vms->bus), &error_fatal);
> > +    }
> > +
> > +    if (defaults_enabled()) {
> > +        usb_controller =3D qdev_new(TYPE_QEMU_XHCI);
> > +        qdev_realize_and_unref(usb_controller, BUS(pci->bus),
> &error_fatal);
> > +
> > +        usb_bus =3D USB_BUS(object_resolve_type_unambiguous(TYPE_USB_B=
US,
> > +
> &error_fatal));
> > +        usb_create_simple(usb_bus, "usb-kbd");
> > +        usb_create_simple(usb_bus, "usb-tablet");
> > +    }
> > +}
> > +
> > +static void vmapple_reset(void *opaque)
> > +{
> > +    VMAppleMachineState *vms =3D opaque;
> > +    hwaddr base =3D vms->memmap[VMAPPLE_FIRMWARE].base;
> > +
> > +    cpu_set_pc(first_cpu, base);
> > +}
> > +
> > +static void mach_vmapple_init(MachineState *machine)
> > +{
> > +    VMAppleMachineState *vms =3D VMAPPLE_MACHINE(machine);
> > +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> > +    const CPUArchIdList *possible_cpus;
> > +    MemoryRegion *sysmem =3D get_system_memory();
> > +    int n;
> > +    unsigned int smp_cpus =3D machine->smp.cpus;
> > +    unsigned int max_cpus =3D machine->smp.max_cpus;
> > +
> > +    vms->memmap =3D memmap;
> > +    machine->usb =3D true;
> > +
> > +    possible_cpus =3D mc->possible_cpu_arch_ids(machine);
> > +    assert(possible_cpus->len =3D=3D max_cpus);
> > +    for (n =3D 0; n < possible_cpus->len; n++) {
> > +        Object *cpu;
> > +        CPUState *cs;
> > +
> > +        if (n >=3D smp_cpus) {
> > +            break;
> > +        }
> > +
> > +        cpu =3D object_new(possible_cpus->cpus[n].type);
> > +        object_property_set_int(cpu, "mp-affinity",
> > +                                possible_cpus->cpus[n].arch_id,
> &error_fatal);
> > +
> > +        cs =3D CPU(cpu);
> > +        cs->cpu_index =3D n;
> > +
> > +        numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index],
> DEVICE(cpu),
> > +                          &error_fatal);
> > +
> > +        if (object_property_find(cpu, "has_el3")) {
> > +            object_property_set_bool(cpu, "has_el3", false,
> &error_fatal);
> > +        }
> > +        if (object_property_find(cpu, "has_el2")) {
> > +            object_property_set_bool(cpu, "has_el2", false,
> &error_fatal);
> > +        }
> > +        object_property_set_int(cpu, "psci-conduit",
> QEMU_PSCI_CONDUIT_HVC,
> > +                                &error_fatal);
> > +
> > +        /* Secondary CPUs start in PSCI powered-down state */
> > +        if (n > 0) {
> > +            object_property_set_bool(cpu, "start-powered-off", true,
> > +                                     &error_fatal);
> > +        }
> > +
> > +        object_property_set_link(cpu, "memory", OBJECT(sysmem),
> &error_abort);
> > +        qdev_realize(DEVICE(cpu), NULL, &error_fatal);
> > +        object_unref(cpu);
> > +    }
> > +
> > +    memory_region_add_subregion(sysmem, vms->memmap[VMAPPLE_MEM].base,
> > +                                machine->ram);
> > +
> > +    create_gic(vms, sysmem);
> > +    create_bdif(vms, sysmem);
> > +    create_pvpanic(vms, sysmem);
> > +    create_aes(vms, sysmem);
> > +    create_gfx(vms, sysmem);
> > +    create_uart(vms, VMAPPLE_UART, sysmem, serial_hd(0));
> > +    create_rtc(vms);
> > +    create_pcie(vms);
> > +
> > +    create_gpio_devices(vms, VMAPPLE_GPIO, sysmem);
> > +
> > +    vmapple_firmware_init(vms, sysmem);
> > +    create_cfg(vms, sysmem, &error_fatal);
> > +
> > +    /* connect powerdown request */
> > +    vms->powerdown_notifier.notify =3D vmapple_powerdown_req;
> > +    qemu_register_powerdown_notifier(&vms->powerdown_notifier);
> > +
> > +    vms->bootinfo.ram_size =3D machine->ram_size;
> > +    vms->bootinfo.board_id =3D -1;
> > +    vms->bootinfo.loader_start =3D vms->memmap[VMAPPLE_MEM].base;
> > +    vms->bootinfo.skip_dtb_autoload =3D true;
> > +    vms->bootinfo.firmware_loaded =3D true;
> > +    arm_load_kernel(ARM_CPU(first_cpu), machine, &vms->bootinfo);
> > +
> > +    qemu_register_reset(vmapple_reset, vms);
> > +}
> > +
> > +static CpuInstanceProperties
> > +vmapple_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> > +{
> > +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> > +    const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids(m=
s);
> > +
> > +    assert(cpu_index < possible_cpus->len);
> > +    return possible_cpus->cpus[cpu_index].props;
> > +}
> > +
> > +
> > +static int64_t vmapple_get_default_cpu_node_id(const MachineState *ms,
> int idx)
> > +{
> > +    return idx % ms->numa_state->num_nodes;
> > +}
> > +
> > +static const CPUArchIdList *vmapple_possible_cpu_arch_ids(MachineState
> *ms)
> > +{
> > +    int n;
> > +    unsigned int max_cpus =3D ms->smp.max_cpus;
> > +
> > +    if (ms->possible_cpus) {
> > +        assert(ms->possible_cpus->len =3D=3D max_cpus);
> > +        return ms->possible_cpus;
> > +    }
> > +
> > +    ms->possible_cpus =3D g_malloc0(sizeof(CPUArchIdList) +
> > +                                  sizeof(CPUArchId) * max_cpus);
> > +    ms->possible_cpus->len =3D max_cpus;
> > +    for (n =3D 0; n < ms->possible_cpus->len; n++) {
> > +        ms->possible_cpus->cpus[n].type =3D ms->cpu_type;
> > +        ms->possible_cpus->cpus[n].arch_id =3D
> > +            arm_build_mp_affinity(n, GICV3_TARGETLIST_BITS);
> > +        ms->possible_cpus->cpus[n].props.has_thread_id =3D true;
> > +        ms->possible_cpus->cpus[n].props.thread_id =3D n;
> > +    }
> > +    return ms->possible_cpus;
> > +}
> > +
> > +static void vmapple_machine_class_init(ObjectClass *oc, void *data)
> > +{
> > +    MachineClass *mc =3D MACHINE_CLASS(oc);
> > +
> > +    mc->init =3D mach_vmapple_init;
> > +    mc->max_cpus =3D 32;
> > +    mc->block_default_type =3D IF_VIRTIO;
> > +    mc->no_cdrom =3D 1;
> > +    mc->pci_allow_0_address =3D true;
> > +    mc->minimum_page_bits =3D 12;
> > +    mc->possible_cpu_arch_ids =3D vmapple_possible_cpu_arch_ids;
> > +    mc->cpu_index_to_instance_props =3D vmapple_cpu_index_to_props;
> > +    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("host");
> > +    mc->get_default_cpu_node_id =3D vmapple_get_default_cpu_node_id;
> > +    mc->default_ram_id =3D "mach-vmapple.ram";
> > +
> > +    object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legacy",
> > +                               "on", true);
>
> This global property default is written in a suboptiomal manner.
>
> Global properties are held with the following variable in qom/object.c:
>
> /*
>   * Global property defaults
>   * Slot 0: accelerator's global property defaults
>   * Slot 1: machine's global property defaults
>   * Slot 2: global properties from legacy command line option
>   * Each is a GPtrArray of of GlobalProperty.
>   * Applied in order, later entries override earlier ones.
>   */
> static GPtrArray *object_compat_props[3];
>
> object_register_sugar_prop() uses slot 2, but we are creating machine's
> global property defaults, so we should use slot 1. Besides it also
> includes a few unnecessary allocations.
>
> Please pull the code from "[PATCH v2 6/6] hw/vmapple: XHCI controller's
> interrupt mapping workaround for macOS" to remove this
> object_register_sugar_prop() call.
>

I see what you mean, add { TYPE_VIRTIO_PCI, "disable-legacy", "on" }, to
the vmapple_compat_defaults table introduced in the commit you mentioned.
Yeah, that makes sense.


> > +}
> > +
> > +static void vmapple_instance_init(Object *obj)
> > +{
> > +    VMAppleMachineState *vms =3D VMAPPLE_MACHINE(obj);
> > +
> > +    vms->irqmap =3D irqmap;
> > +
> > +    object_property_add_uint64_ptr(obj, "uuid", &vms->uuid,
> > +                                   OBJ_PROP_FLAG_READWRITE);
> > +    object_property_set_description(obj, "uuid", "Machine UUID (SDOM)"=
);
> > +}
> > +
> > +static const TypeInfo vmapple_machine_info =3D {
> > +    .name          =3D TYPE_VMAPPLE_MACHINE,
> > +    .parent        =3D TYPE_MACHINE,
> > +    .abstract      =3D true,
> > +    .instance_size =3D sizeof(VMAppleMachineState),
> > +    .class_size    =3D sizeof(VMAppleMachineClass),
> > +    .class_init    =3D vmapple_machine_class_init,
> > +    .instance_init =3D vmapple_instance_init,
> > +};
> > +
> > +static void machvmapple_machine_init(void)
> > +{
> > +    type_register_static(&vmapple_machine_info);
> > +}
> > +type_init(machvmapple_machine_init);
> > +
> > +static void vmapple_machine_10_0_options(MachineClass *mc)
> > +{
> > +}
> > +DEFINE_VMAPPLE_MACHINE_AS_LATEST(10, 0)
> > +
>
>

--000000000000bdf0890629f053ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 19 Dec =
2024 at 11:50, Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
">akihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Reviewing &quot;[PATCH v2 6/6] hw/vmapple: XHCI c=
ontroller&#39;s interrupt <br>
mapping workaround for macOS&quot;, I found a few problems so I&#39;m addin=
g <br>
comments for them:<br>
<br>
On 2024/12/19 5:20, Phil Dennis-Jordan wrote:<br>
&gt; From: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" target=3D"=
_blank">graf@amazon.com</a>&gt;<br>
&gt; <br>
&gt; Apple defines a new &quot;vmapple&quot; machine type as part of its pr=
oprietary<br>
&gt; macOS Virtualization.Framework vmm. This machine type is similar to th=
e<br>
&gt; virt one, but with subtle differences in base devices, a few special<b=
r>
&gt; vmapple device additions and a vastly different boot chain.<br>
&gt; <br>
&gt; This patch reimplements this machine type in QEMU. To use it, you<br>
&gt; have to have a readily installed version of macOS for VMApple,<br>
&gt; run on macOS with -accel hvf, pass the Virtualization.Framework<br>
&gt; boot rom (AVPBooter) in via -bios, pass the aux and root volume as pfl=
ash<br>
&gt; and pass aux and root volume as virtio drives. In addition, you also<b=
r>
&gt; need to find the machine UUID and pass that as -M vmapple,uuid=3D para=
meter:<br>
&gt; <br>
&gt; $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=3D0x1234 -m 4G \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -bios /System/Library/Frameworks/Virtualization.fr=
amework/Versions/A/Resources/AVPBooter.vmapple2.bin<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Daux,if=3Dpflash,format=3Draw \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Droot,if=3Dpflash,format=3Draw \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Daux,if=3Dnone,id=3Daux,format=3Draw =
\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -device vmapple-virtio-blk-pci,variant=3Daux,drive=
=3Daux \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Droot,if=3Dnone,id=3Droot,format=3Dra=
w \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -device vmapple-virtio-blk-pci,variant=3Droot,driv=
e=3Droot<br>
&gt; <br>
&gt; With all these in place, you should be able to see macOS booting<br>
&gt; successfully.<br>
&gt; <br>
&gt; Known issues:<br>
&gt;=C2=A0 =C2=A0- Keyboard and mouse/tablet input is laggy. The reason for=
 this is<br>
&gt;=C2=A0 =C2=A0 =C2=A0that macOS&#39;s XHCI driver seems to expect interr=
upter mapping to<br>
&gt;=C2=A0 =C2=A0 =C2=A0be disabled when MSI/MSI-X is unavailable. I have f=
ound a<br>
&gt;=C2=A0 =C2=A0 =C2=A0workaround but discovered a bunch of other XHCI spe=
c non-compliance<br>
&gt;=C2=A0 =C2=A0 =C2=A0in the process, so I&#39;m fixing all of those in a=
 separate patch<br>
&gt;=C2=A0 =C2=A0 =C2=A0set.<br>
&gt;=C2=A0 =C2=A0- Currently only macOS 12 guests are supported. The boot p=
rocess for<br>
&gt;=C2=A0 =C2=A0 =C2=A013+ will need further investigation and adjustment.=
<br>
&gt; <br>
&gt; Signed-off-by: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" t=
arget=3D"_blank">graf@amazon.com</a>&gt;<br>
&gt; Co-authored-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjord=
an.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.=
com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt; Tested-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.co=
m" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; v3:<br>
&gt;=C2=A0 =C2=A0* Rebased on latest upstream, updated affinity and NIC cre=
ation<br>
&gt;=C2=A0 =C2=A0 =C2=A0API usage<br>
&gt;=C2=A0 =C2=A0* Included Apple-variant virtio-blk in build dependency<br=
>
&gt;=C2=A0 =C2=A0* Updated API usage for setting &#39;redist-region-count&#=
39; array-typed property on GIC.<br>
&gt;=C2=A0 =C2=A0* Switched from virtio HID devices (for which macOS 12 doe=
s not contain<br>
&gt;=C2=A0 =C2=A0 =C2=A0drivers) to an XHCI USB controller and USB HID devi=
ces.<br>
&gt; <br>
&gt; v4:<br>
&gt;=C2=A0 =C2=A0* Fixups for v4 changes to the other patches in the set.<b=
r>
&gt;=C2=A0 =C2=A0* Corrected the assert macro to use<br>
&gt;=C2=A0 =C2=A0* Removed superfluous endian conversions corresponding to =
cfg&#39;s.<br>
&gt;=C2=A0 =C2=A0* Init error handling improvement.<br>
&gt;=C2=A0 =C2=A0* No need to select CPU type on TCG, as only HVF is suppor=
ted.<br>
&gt;=C2=A0 =C2=A0* Machine type version bumped to 9.2<br>
&gt;=C2=A0 =C2=A0* #include order improved<br>
&gt; <br>
&gt; v5:<br>
&gt;=C2=A0 =C2=A0* Fixed memory reservation for ecam alias region.<br>
&gt;=C2=A0 =C2=A0* Better error handling setting properties on devices.<br>
&gt;=C2=A0 =C2=A0* Simplified the machine ECID/UUID extraction script and a=
ctually created a<br>
&gt;=C2=A0 =C2=A0 =C2=A0file for it rather than quoting its code in documen=
tation.<br>
&gt; <br>
&gt; v7:<br>
&gt;=C2=A0 =C2=A0* Tiny error handling fix, un-inlined function.<br>
&gt; <br>
&gt; v8:<br>
&gt;=C2=A0 =C2=A0* Use object_property_add_uint64_ptr rather than defining =
custom UUID<br>
&gt;=C2=A0 =C2=A0 =C2=A0property get/set functions.<br>
&gt; <br>
&gt; v9:<br>
&gt;=C2=A0 =C2=A0* Documentation improvements<br>
&gt;=C2=A0 =C2=A0* Fixed variable name and struct field used during pvpanic=
 device creation.<br>
&gt; <br>
&gt; v10:<br>
&gt;=C2=A0 =C2=A0* Documentation fixup for changed virtio-blk device type.<=
br>
&gt;=C2=A0 =C2=A0* Small improvements to shell commands in documentation.<b=
r>
&gt;=C2=A0 =C2=A0* Improved propagation of errors during cfg device instant=
iation.<br>
&gt; <br>
&gt; v11:<br>
&gt;=C2=A0 =C2=A0* Quoted more strings in the documentation&#39;s shell scr=
ipt code.<br>
&gt; <br>
&gt; v13:<br>
&gt;=C2=A0 =C2=A0* Bumped the machine type version from 9.2 to 10.0.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0contrib/vmapple/uuid.sh=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A09=
 +<br>
&gt;=C2=A0 =C2=A0docs/system/arm/vmapple.rst |=C2=A0 63 ++++<br>
&gt;=C2=A0 =C2=A0docs/system/target-arm.rst=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 20 ++<br>
&gt;=C2=A0 =C2=A0hw/vmapple/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01=
 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/vmapple.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 648 ++++=
++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A07 files changed, 743 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100755 contrib/vmapple/uuid.sh<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/system/arm/vmapple.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/vmapple.c<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 5d9d65e6df7..a8e3d3b74a2 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -2777,6 +2777,7 @@ M: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil=
@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt;=C2=A0 =C2=A0S: Maintained<br>
&gt;=C2=A0 =C2=A0F: hw/vmapple/*<br>
&gt;=C2=A0 =C2=A0F: include/hw/vmapple/*<br>
&gt; +F: docs/system/arm/vmapple.rst<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0Subsystems<br>
&gt;=C2=A0 =C2=A0----------<br>
&gt; diff --git a/contrib/vmapple/uuid.sh b/contrib/vmapple/uuid.sh<br>
&gt; new file mode 100755<br>
&gt; index 00000000000..956e8c3afed<br>
&gt; --- /dev/null<br>
&gt; +++ b/contrib/vmapple/uuid.sh<br>
&gt; @@ -0,0 +1,9 @@<br>
&gt; +#!/bin/sh<br>
&gt; +# Used for converting a guest provisioned using Virtualization.framew=
ork<br>
&gt; +# for use with the QEMU &#39;vmapple&#39; aarch64 machine type.<br>
&gt; +#<br>
&gt; +# Extracts the Machine UUID from Virtualization.framework VM JSON fil=
e.<br>
&gt; +# (as produced by &#39;macosvm&#39;, passed as command line argument)=
<br>
&gt; +<br>
&gt; +plutil -extract machineId raw &quot;$1&quot; | base64 -d | plutil -ex=
tract ECID raw -<br>
&gt; +<br>
&gt; diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst=
<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..5090a8997c3<br>
&gt; --- /dev/null<br>
&gt; +++ b/docs/system/arm/vmapple.rst<br>
&gt; @@ -0,0 +1,63 @@<br>
&gt; +VMApple machine emulation<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; +<br>
&gt; +VMApple is the device model that the macOS built-in hypervisor called=
 &quot;Virtualization.framework&quot;<br>
&gt; +exposes to Apple Silicon macOS guests. The &quot;vmapple&quot; machin=
e model in QEMU implements the same<br>
&gt; +device model, but does not use any code from Virtualization.Framework=
.<br>
&gt; +<br>
&gt; +Prerequisites<br>
&gt; +-------------<br>
&gt; +<br>
&gt; +To run the vmapple machine model, you need to<br>
&gt; +<br>
&gt; + * Run on Apple Silicon<br>
&gt; + * Run on macOS 12.0 or above<br>
&gt; + * Have an already installed copy of a Virtualization.Framework macOS=
 12 virtual<br>
&gt; +=C2=A0 =C2=A0machine. Note that newer versions than 12.x are currentl=
y NOT supported on<br>
&gt; +=C2=A0 =C2=A0the guest side. I will assume that you installed it usin=
g the<br>
&gt; +=C2=A0 =C2=A0`macosvm &lt;<a href=3D"https://github.com/s-u/macosvm" =
rel=3D"noreferrer" target=3D"_blank">https://github.com/s-u/macosvm</a>&gt;=
` CLI.<br>
&gt; +<br>
&gt; +First, we need to extract the UUID from the virtual machine that you =
installed. You can do this<br>
&gt; +by running the shell script in contrib/vmapple/uuid.sh on the macosvm=
.json file.<br>
&gt; +<br>
&gt; +.. code-block:: bash<br>
&gt; +=C2=A0 :caption: uuid.sh script to extract the UUID from a macosvm.js=
on file<br>
&gt; +<br>
&gt; +=C2=A0 $ contrib/vmapple/uuid.sh &quot;path/to/macosvm.json&quot;<br>
&gt; +<br>
&gt; +Now we also need to trim the aux partition. It contains metadata that=
 we can just discard:<br>
&gt; +<br>
&gt; +.. code-block:: bash<br>
&gt; +=C2=A0 :caption: Command to trim the aux file<br>
&gt; +<br>
&gt; +=C2=A0 $ dd if=3D&quot;aux.img&quot; of=3D&quot;aux.img.trimmed&quot;=
 bs=3D$(( 0x4000 )) skip=3D1<br>
&gt; +<br>
&gt; +How to run<br>
&gt; +----------<br>
&gt; +<br>
&gt; +Then, we can launch QEMU with the Virtualization.Framework pre-boot e=
nvironment and the readily<br>
&gt; +installed target disk images. I recommend to port forward the VM&#39;=
s ssh and vnc ports to the host<br>
&gt; +to get better interactive access into the target system:<br>
&gt; +<br>
&gt; +.. code-block:: bash<br>
&gt; +=C2=A0 :caption: Example execution command line<br>
&gt; +<br>
&gt; +=C2=A0 $ UUID=3D&quot;$(contrib/vmapple/uuid.sh &#39;macosvm.json&#39=
;)&quot;<br>
&gt; +=C2=A0 $ AVPBOOTER=3D&quot;/System/Library/Frameworks/Virtualization.=
framework/Resources/AVPBooter.vmapple2.bin&quot;<br>
&gt; +=C2=A0 $ AUX=3D&quot;aux.img.trimmed&quot;<br>
&gt; +=C2=A0 $ DISK=3D&quot;disk.img&quot;<br>
&gt; +=C2=A0 $ qemu-system-aarch64 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-serial mon:stdio \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-m 4G \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-accel hvf \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-M vmapple,uuid=3D&quot;$UUID&quot; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-bios &quot;$AVPBOOTER&quot; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D&quot;$AUX&quot;,if=3Dpflash=
,format=3Draw \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D&quot;$DISK&quot;,if=3Dpflas=
h,format=3Draw \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D&quot;$AUX&quot;,if=3Dnone,i=
d=3Daux,format=3Draw \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D&quot;$DISK&quot;,if=3Dnone,=
id=3Droot,format=3Draw \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-device vmapple-virtio-blk-pci,variant=3Da=
ux,drive=3Daux \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-device vmapple-virtio-blk-pci,variant=3Dr=
oot,drive=3Droot \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-netdev user,id=3Dnet0,ipv6=3Doff,hostfwd=
=3Dtcp::2222-:22,hostfwd=3Dtcp::5901-:5900 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-device virtio-net-pci,netdev=3Dnet0<br>
&gt; +<br>
&gt; diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst<b=
r>
&gt; index 9aaa9c414c9..3426f79100b 100644<br>
&gt; --- a/docs/system/target-arm.rst<br>
&gt; +++ b/docs/system/target-arm.rst<br>
&gt; @@ -102,6 +102,7 @@ Board-specific documentation<br>
&gt;=C2=A0 =C2=A0 =C2=A0 arm/stellaris<br>
&gt;=C2=A0 =C2=A0 =C2=A0 arm/stm32<br>
&gt;=C2=A0 =C2=A0 =C2=A0 arm/virt<br>
&gt; +=C2=A0 =C2=A0arm/vmapple<br>
&gt;=C2=A0 =C2=A0 =C2=A0 arm/xenpvh<br>
&gt;=C2=A0 =C2=A0 =C2=A0 arm/xlnx-versal-virt<br>
&gt;=C2=A0 =C2=A0 =C2=A0 arm/xlnx-zynq<br>
&gt; diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig<br>
&gt; index bcd1be63e3c..6a4c4a7fa2e 100644<br>
&gt; --- a/hw/vmapple/Kconfig<br>
&gt; +++ b/hw/vmapple/Kconfig<br>
&gt; @@ -10,3 +10,23 @@ config VMAPPLE_CFG<br>
&gt;=C2=A0 =C2=A0config VMAPPLE_VIRTIO_BLK<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +config VMAPPLE<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +=C2=A0 =C2=A0 depends on ARM<br>
&gt; +=C2=A0 =C2=A0 depends on HVF<br>
&gt; +=C2=A0 =C2=A0 default y if ARM<br>
&gt; +=C2=A0 =C2=A0 imply PCI_DEVICES<br>
&gt; +=C2=A0 =C2=A0 select ARM_GIC<br>
&gt; +=C2=A0 =C2=A0 select PLATFORM_BUS<br>
&gt; +=C2=A0 =C2=A0 select PCI_EXPRESS<br>
&gt; +=C2=A0 =C2=A0 select PCI_EXPRESS_GENERIC_BRIDGE<br>
&gt; +=C2=A0 =C2=A0 select PL011 # UART<br>
&gt; +=C2=A0 =C2=A0 select PL031 # RTC<br>
&gt; +=C2=A0 =C2=A0 select PL061 # GPIO<br>
&gt; +=C2=A0 =C2=A0 select GPIO_PWR<br>
&gt; +=C2=A0 =C2=A0 select PVPANIC_MMIO<br>
&gt; +=C2=A0 =C2=A0 select VMAPPLE_AES<br>
&gt; +=C2=A0 =C2=A0 select VMAPPLE_BDIF<br>
&gt; +=C2=A0 =C2=A0 select VMAPPLE_CFG<br>
&gt; +=C2=A0 =C2=A0 select MAC_PVG_MMIO<br>
&gt; +=C2=A0 =C2=A0 select VMAPPLE_VIRTIO_BLK<br>
&gt; diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build<br>
&gt; index bf17cf906c9..e572f7d5602 100644<br>
&gt; --- a/hw/vmapple/meson.build<br>
&gt; +++ b/hw/vmapple/meson.build<br>
&gt; @@ -2,3 +2,4 @@ system_ss.add(when: &#39;CONFIG_VMAPPLE_AES&#39;,=C2=
=A0 if_true: files(&#39;aes.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_VMAPPLE_BDIF&#39;, if_true=
: files(&#39;bdif.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_VMAPPLE_CFG&#39;,=C2=A0 if=
_true: files(&#39;cfg.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_VMAPPLE_VIRTIO_BLK&#39;,=
=C2=A0 if_true: files(&#39;virtio-blk.c&#39;))<br>
&gt; +specific_ss.add(when: &#39;CONFIG_VMAPPLE&#39;,=C2=A0 =C2=A0 =C2=A0if=
_true: files(&#39;vmapple.c&#39;))<br>
&gt; diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..66336942c8d<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/vmapple/vmapple.c<br>
&gt; @@ -0,0 +1,648 @@<br>
&gt; +/*<br>
&gt; + * VMApple machine emulation<br>
&gt; + *<br>
&gt; + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Righ=
ts Reserved.<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + *<br>
&gt; + * VMApple is the device model that the macOS built-in hypervisor cal=
led<br>
&gt; + * &quot;Virtualization.framework&quot; exposes to Apple Silicon macO=
S guests. The<br>
&gt; + * machine model in this file implements the same device model in QEM=
U, but<br>
&gt; + * does not use any code from Virtualization.Framework.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qemu/bitops.h&quot;<br>
&gt; +#include &quot;qemu/datadir.h&quot;<br>
&gt; +#include &quot;qemu/error-report.h&quot;<br>
&gt; +#include &quot;qemu/guest-random.h&quot;<br>
&gt; +#include &quot;qemu/help-texts.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;qemu/option.h&quot;<br>
&gt; +#include &quot;qemu/units.h&quot;<br>
&gt; +#include &quot;monitor/qdev.h&quot;<br>
&gt; +#include &quot;hw/boards.h&quot;<br>
&gt; +#include &quot;hw/irq.h&quot;<br>
&gt; +#include &quot;hw/loader.h&quot;<br>
&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;hw/usb.h&quot;<br>
&gt; +#include &quot;hw/arm/boot.h&quot;<br>
&gt; +#include &quot;hw/arm/primecell.h&quot;<br>
&gt; +#include &quot;hw/char/pl011.h&quot;<br>
&gt; +#include &quot;hw/intc/arm_gic.h&quot;<br>
&gt; +#include &quot;hw/intc/arm_gicv3_common.h&quot;<br>
&gt; +#include &quot;hw/misc/pvpanic.h&quot;<br>
&gt; +#include &quot;hw/pci-host/gpex.h&quot;<br>
&gt; +#include &quot;hw/usb/xhci.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio-pci.h&quot;<br>
&gt; +#include &quot;hw/vmapple/vmapple.h&quot;<br>
&gt; +#include &quot;net/net.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qapi/qmp/qlist.h&quot;<br>
&gt; +#include &quot;qapi/visitor.h&quot;<br>
&gt; +#include &quot;qapi/qapi-visit-common.h&quot;<br>
&gt; +#include &quot;standard-headers/linux/input.h&quot;<br>
&gt; +#include &quot;sysemu/hvf.h&quot;<br>
&gt; +#include &quot;sysemu/kvm.h&quot;<br>
&gt; +#include &quot;sysemu/reset.h&quot;<br>
&gt; +#include &quot;sysemu/runstate.h&quot;<br>
&gt; +#include &quot;sysemu/sysemu.h&quot;<br>
&gt; +#include &quot;target/arm/internals.h&quot;<br>
&gt; +#include &quot;target/arm/kvm_arm.h&quot;<br>
&gt; +<br>
&gt; +struct VMAppleMachineClass {<br>
&gt; +=C2=A0 =C2=A0 MachineClass parent;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct VMAppleMachineState {<br>
&gt; +=C2=A0 =C2=A0 MachineState parent;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 Notifier machine_done;<br>
&gt; +=C2=A0 =C2=A0 struct arm_boot_info bootinfo;<br>
&gt; +=C2=A0 =C2=A0 MemMapEntry *memmap;<br>
&gt; +=C2=A0 =C2=A0 const int *irqmap;<br>
&gt; +=C2=A0 =C2=A0 DeviceState *gic;<br>
&gt; +=C2=A0 =C2=A0 DeviceState *cfg;<br>
&gt; +=C2=A0 =C2=A0 DeviceState *pvpanic;<br>
&gt; +=C2=A0 =C2=A0 Notifier powerdown_notifier;<br>
&gt; +=C2=A0 =C2=A0 PCIBus *bus;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion fw_mr;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion ecam_alias;<br>
&gt; +=C2=A0 =C2=A0 uint64_t uuid;<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, latest) \<br>
<br>
This macro has suffix &quot;_LATEST&quot;, but it is used not only for the =
latest <br>
version but also for older versions.<br>
<br>
include/hw/boards.h suggests using &quot;_IMPL&quot; suffix.<br></blockquot=
e><div><br></div><div>Thanks for pointing this out, I&#39;ve fixed it local=
ly and will include it in v16.</div><div><br></div><div>Adapting this giant=
 macro for each machine type seems rather error-prone and the kind of thing=
 a computer does better than a human writing the code. I can&#39;t help but=
 wonder if we could define a generic version in boards.h and only implement=
 the DEFINE_*_MACHINE{_LATEST,}() wrappers specifically for each machine ty=
pe. I&#39;ve created an issue for this on GitLab: <a href=3D"https://gitlab=
.com/qemu-project/qemu/-/issues/2744">https://gitlab.com/qemu-project/qemu/=
-/issues/2744</a> I might attack that once I&#39;ve cut down my backlog of =
unmerged patches.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
&gt; +=C2=A0 =C2=A0 static void vmapple##major##_##minor##_class_init(Objec=
tClass *oc, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *data) \<br>
&gt; +=C2=A0 =C2=A0 { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc); \=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vmapple_machine_##major##_##minor##_optio=
ns(mc); \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mc-&gt;desc =3D &quot;QEMU &quot; # major=
 &quot;.&quot; # minor &quot; Apple Virtual Machine&quot;; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (latest) { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mc-&gt;alias =3D &quot;vmap=
ple&quot;; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } \<br>
&gt; +=C2=A0 =C2=A0 } \<br>
&gt; +=C2=A0 =C2=A0 static const TypeInfo machvmapple##major##_##minor##_in=
fo =3D { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D MACHINE_TYPE_NAME(&quot;vmapple=
-&quot; # major &quot;.&quot; # minor), \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_VMAPPLE_MACHINE, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init =3D vmapple##major##_##minor#=
#_class_init, \<br>
&gt; +=C2=A0 =C2=A0 }; \<br>
&gt; +=C2=A0 =C2=A0 static void machvmapple_machine_##major##_##minor##_ini=
t(void) \<br>
&gt; +=C2=A0 =C2=A0 { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 type_register_static(&amp;machvmapple##ma=
jor##_##minor##_info); \<br>
&gt; +=C2=A0 =C2=A0 } \<br>
&gt; +=C2=A0 =C2=A0 type_init(machvmapple_machine_##major##_##minor##_init)=
;<br>
&gt; +<br>
&gt; +#define DEFINE_VMAPPLE_MACHINE_AS_LATEST(major, minor) \<br>
&gt; +=C2=A0 =C2=A0 DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, true)<br>
&gt; +#define DEFINE_VMAPPLE_MACHINE(major, minor) \<br>
&gt; +=C2=A0 =C2=A0 DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, false)<br>
&gt; +<br>
&gt; +#define TYPE_VMAPPLE_MACHINE=C2=A0 =C2=A0MACHINE_TYPE_NAME(&quot;vmap=
ple&quot;)<br>
&gt; +OBJECT_DECLARE_TYPE(VMAppleMachineState, VMAppleMachineClass, VMAPPLE=
_MACHINE)<br>
&gt; +<br>
&gt; +/* Number of external interrupt lines to configure the GIC with */<br=
>
&gt; +#define NUM_IRQS 256<br>
&gt; +<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_FIRMWARE,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_CONFIG,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_MEM,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_GIC_DIST,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_GIC_REDIST,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_UART,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_RTC,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_PCIE,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_PCIE_MMIO,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_PCIE_ECAM,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_GPIO,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_PVPANIC,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_APV_GFX,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_APV_IOSFC,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_AES_1,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_AES_2,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_BDOOR,<br>
&gt; +=C2=A0 =C2=A0 VMAPPLE_MEMMAP_LAST,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static MemMapEntry memmap[] =3D {<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_FIRMWARE] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0{ 0x00100000, 0x00100000 },<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_CONFIG] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0{ 0x00400000, 0x00010000 },<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_GIC_DIST] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0{ 0x10000000, 0x00010000 },<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_GIC_REDIST] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0{ 0x10010000, 0x00400000 },<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_UART] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0{ 0x20010000, 0x00010000 },<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_RTC] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 { 0x20050000, 0x00001000 },<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_GPIO] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0{ 0x20060000, 0x00001000 },<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_PVPANIC] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 { 0x20070000, 0x00000002 },<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_BDOOR] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 { 0x30000000, 0x00200000 },<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_APV_GFX] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 { 0x30200000, 0x00010000 },<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_APV_IOSFC] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 { 0x30210000, 0x00010000 },<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_AES_1] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 { 0x30220000, 0x00004000 },<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_AES_2] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 { 0x30230000, 0x00004000 },<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_PCIE_ECAM] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 { 0x40000000, 0x10000000 },<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_PCIE_MMIO] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 { 0x50000000, 0x1fff0000 },<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Actual RAM size depends on configuration */<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_MEM] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 { 0x70000000ULL, GiB},<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const int irqmap[] =3D {<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_UART] =3D 1,<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_RTC] =3D 2,<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_GPIO] =3D 0x5,<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_APV_IOSFC] =3D 0x10,<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_APV_GFX] =3D 0x11,<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_AES_1] =3D 0x12,<br>
&gt; +=C2=A0 =C2=A0 [VMAPPLE_PCIE] =3D 0x20,<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define GPEX_NUM_IRQS 16<br>
&gt; +<br>
&gt; +static void create_bdif(VMAppleMachineState *vms, MemoryRegion *mem)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceState *bdif;<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *bdif_sb;<br>
&gt; +=C2=A0 =C2=A0 DriveInfo *di_aux =3D drive_get(IF_PFLASH, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 DriveInfo *di_root =3D drive_get(IF_PFLASH, 0, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!di_aux) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;No AUX device. Please =
specify one as pflash drive.&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!di_root) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fall back to the first IF_VIRTIO devic=
e as root device */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 di_root =3D drive_get(IF_VIRTIO, 0, 0);<b=
r>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!di_root) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;No root device. Please=
 specify one as virtio drive.&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* PV backdoor device */<br>
&gt; +=C2=A0 =C2=A0 bdif =3D qdev_new(TYPE_VMAPPLE_BDIF);<br>
&gt; +=C2=A0 =C2=A0 bdif_sb =3D SYS_BUS_DEVICE(bdif);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(bdif_sb, 0, vms-&gt;memmap[VMAPPLE_BDOO=
R].base);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_drive(DEVICE(bdif), &quot;aux&quot;, blk_=
by_legacy_dinfo(di_aux));<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_drive(DEVICE(bdif), &quot;root&quot;, blk=
_by_legacy_dinfo(di_root));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(bdif_sb, &amp;error_fatal);<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +static void create_pvpanic(VMAppleMachineState *vms, MemoryRegion *me=
m)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *pvpanic;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vms-&gt;pvpanic =3D qdev_new(TYPE_PVPANIC_MMIO_DEVICE);=
<br>
&gt; +=C2=A0 =C2=A0 pvpanic =3D SYS_BUS_DEVICE(vms-&gt;pvpanic);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(pvpanic, 0, vms-&gt;memmap[VMAPPLE_PVPA=
NIC].base);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(pvpanic, &amp;error_fatal);<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +static bool create_cfg(VMAppleMachineState *vms, MemoryRegion *mem,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 ERRP_GUARD();<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *cfg;<br>
&gt; +=C2=A0 =C2=A0 MachineState *machine =3D MACHINE(vms);<br>
&gt; +=C2=A0 =C2=A0 uint32_t rnd =3D 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vms-&gt;cfg =3D qdev_new(TYPE_VMAPPLE_CFG);<br>
&gt; +=C2=A0 =C2=A0 cfg =3D SYS_BUS_DEVICE(vms-&gt;cfg);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(cfg, 0, vms-&gt;memmap[VMAPPLE_CONFIG].=
base);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_guest_getrandom_nofail(&amp;rnd, sizeof(rnd));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(vms-&gt;cfg, &quot;nr-cpus&quot;, =
machine-&gt;smp.cpus);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint64(vms-&gt;cfg, &quot;ecid&quot;, vms=
-&gt;uuid);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint64(vms-&gt;cfg, &quot;ram-size&quot;,=
 machine-&gt;ram_size);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(vms-&gt;cfg, &quot;rnd&quot;, rnd)=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!sysbus_realize_and_unref(cfg, errp)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp, &quot;Error creating =
vmapple cfg device: &quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void create_gfx(VMAppleMachineState *vms, MemoryRegion *mem)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int irq_gfx =3D vms-&gt;irqmap[VMAPPLE_APV_GFX];<br>
&gt; +=C2=A0 =C2=A0 int irq_iosfc =3D vms-&gt;irqmap[VMAPPLE_APV_IOSFC];<br=
>
&gt; +=C2=A0 =C2=A0 SysBusDevice *gfx;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 gfx =3D SYS_BUS_DEVICE(qdev_new(&quot;apple-gfx-mmio&qu=
ot;));<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(gfx, 0, vms-&gt;memmap[VMAPPLE_APV_GFX]=
.base);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(gfx, 1, vms-&gt;memmap[VMAPPLE_APV_IOSF=
C].base);<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(gfx, 0, qdev_get_gpio_in(vms-&gt;gic=
, irq_gfx));<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(gfx, 1, qdev_get_gpio_in(vms-&gt;gic=
, irq_iosfc));<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(gfx, &amp;error_fatal);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void create_aes(VMAppleMachineState *vms, MemoryRegion *mem)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int irq =3D vms-&gt;irqmap[VMAPPLE_AES_1];<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *aes;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 aes =3D SYS_BUS_DEVICE(qdev_new(TYPE_APPLE_AES));<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(aes, 0, vms-&gt;memmap[VMAPPLE_AES_1].b=
ase);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(aes, 1, vms-&gt;memmap[VMAPPLE_AES_2].b=
ase);<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(aes, 0, qdev_get_gpio_in(vms-&gt;gic=
, irq));<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(aes, &amp;error_fatal);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int arm_gic_ppi_index(int cpu_nr, int ppi_index)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return NUM_IRQS + cpu_nr * GIC_INTERNAL + ppi_index;<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +static void create_gic(VMAppleMachineState *vms, MemoryRegion *mem)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(vms);<br>
&gt; +=C2=A0 =C2=A0 /* We create a standalone GIC */<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *gicbusdev;<br>
&gt; +=C2=A0 =C2=A0 QList *redist_region_count;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 unsigned int smp_cpus =3D ms-&gt;smp.cpus;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vms-&gt;gic =3D qdev_new(gicv3_class_name());<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(vms-&gt;gic, &quot;revision&quot;,=
 3);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(vms-&gt;gic, &quot;num-cpu&quot;, =
smp_cpus);<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Note that the num-irq property counts both inte=
rnal and external<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* interrupts; there are always 32 of the former (=
mandated by GIC spec).<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(vms-&gt;gic, &quot;num-irq&quot;, =
NUM_IRQS + 32);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t redist0_capacity =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vms-&gt;memma=
p[VMAPPLE_GIC_REDIST].size / GICV3_REDIST_SIZE;<br>
&gt; +=C2=A0 =C2=A0 uint32_t redist0_count =3D MIN(smp_cpus, redist0_capaci=
ty);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 redist_region_count =3D qlist_new();<br>
&gt; +=C2=A0 =C2=A0 qlist_append_int(redist_region_count, redist0_count);<b=
r>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_array(vms-&gt;gic, &quot;redist-region-co=
unt&quot;, redist_region_count);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 gicbusdev =3D SYS_BUS_DEVICE(vms-&gt;gic);<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(gicbusdev, &amp;error_fatal);<=
br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(gicbusdev, 0, vms-&gt;memmap[VMAPPLE_GI=
C_DIST].base);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(gicbusdev, 1, vms-&gt;memmap[VMAPPLE_GI=
C_REDIST].base);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Wire the outputs from each CPU&#39;s generic ti=
mer and the GICv3<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* maintenance interrupt signal to the appropriate=
 GIC PPI inputs,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* and the GIC&#39;s IRQ/FIQ/VIRQ/VFIQ interrupt o=
utputs to the CPU&#39;s inputs.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; smp_cpus; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DeviceState *cpudev =3D DEVICE(qemu_get_c=
pu(i));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Map the virt timer to PPI 27 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_connect_gpio_out(cpudev, GTIMER_VIRT=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(vms-&gt;gic,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0arm_gic_ppi_index(i, 27)));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Map the GIC IRQ and FIQ lines to CPU *=
/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(gicbusdev, i, qdev_get=
_gpio_in(cpudev, ARM_CPU_IRQ));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(gicbusdev, i + smp_cpu=
s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void create_uart(const VMAppleMachineState *vms, int uart,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 MemoryRegion *mem, Chardev *chr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 hwaddr base =3D vms-&gt;memmap[uart].base;<br>
&gt; +=C2=A0 =C2=A0 int irq =3D vms-&gt;irqmap[uart];<br>
&gt; +=C2=A0 =C2=A0 DeviceState *dev =3D qdev_new(TYPE_PL011);<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *s =3D SYS_BUS_DEVICE(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_chr(dev, &quot;chardev&quot;, chr);<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &amp;erro=
r_fatal);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(mem, base,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_get_region(s, 0));<b=
r>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms-&gt;gic, =
irq));<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void create_rtc(const VMAppleMachineState *vms)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 hwaddr base =3D vms-&gt;memmap[VMAPPLE_RTC].base;<br>
&gt; +=C2=A0 =C2=A0 int irq =3D vms-&gt;irqmap[VMAPPLE_RTC];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_create_simple(&quot;pl031&quot;, base, qdev_get_=
gpio_in(vms-&gt;gic, irq));<br>
&gt; +}<br>
&gt; +<br>
&gt; +static DeviceState *gpio_key_dev;<br>
&gt; +static void vmapple_powerdown_req(Notifier *n, void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* use gpio Pin 3 for power button event */<br>
&gt; +=C2=A0 =C2=A0 qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void create_gpio_devices(const VMAppleMachineState *vms, int g=
pio,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryRegion *mem)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceState *pl061_dev;<br>
&gt; +=C2=A0 =C2=A0 hwaddr base =3D vms-&gt;memmap[gpio].base;<br>
&gt; +=C2=A0 =C2=A0 int irq =3D vms-&gt;irqmap[gpio];<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *s;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 pl061_dev =3D qdev_new(&quot;pl061&quot;);<br>
&gt; +=C2=A0 =C2=A0 /* Pull lines down to 0 if not driven by the PL061 */<b=
r>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(pl061_dev, &quot;pullups&quot;, 0)=
;<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(pl061_dev, &quot;pulldowns&quot;, =
0xff);<br>
&gt; +=C2=A0 =C2=A0 s =3D SYS_BUS_DEVICE(pl061_dev);<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(s, &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(mem, base, sysbus_mmio_get_=
region(s, 0));<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms-&gt;gic, =
irq));<br>
&gt; +=C2=A0 =C2=A0 gpio_key_dev =3D sysbus_create_simple(&quot;gpio-key&qu=
ot;, -1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev=
_get_gpio_in(pl061_dev, 3));<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vmapple_firmware_init(VMAppleMachineState *vms,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryRegion *sysmem)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 hwaddr size =3D vms-&gt;memmap[VMAPPLE_FIRMWARE].size;<=
br>
&gt; +=C2=A0 =C2=A0 hwaddr base =3D vms-&gt;memmap[VMAPPLE_FIRMWARE].base;<=
br>
&gt; +=C2=A0 =C2=A0 const char *bios_name;<br>
&gt; +=C2=A0 =C2=A0 int image_size;<br>
&gt; +=C2=A0 =C2=A0 char *fname;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 bios_name =3D MACHINE(vms)-&gt;firmware;<br>
&gt; +=C2=A0 =C2=A0 if (!bios_name) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;No firmware specified&=
quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 fname =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name=
);<br>
&gt; +=C2=A0 =C2=A0 if (!fname) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Could not find ROM ima=
ge &#39;%s&#39;&quot;, bios_name);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_ram(&amp;vms-&gt;fw_mr, NULL, &quot;=
firmware&quot;, size, &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 image_size =3D load_image_mr(fname, &amp;vms-&gt;fw_mr)=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_free(fname);<br>
&gt; +=C2=A0 =C2=A0 if (image_size &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Could not load ROM ima=
ge &#39;%s&#39;&quot;, bios_name);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), base, =
&amp;vms-&gt;fw_mr);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void create_pcie(VMAppleMachineState *vms)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 hwaddr base_mmio =3D vms-&gt;memmap[VMAPPLE_PCIE_MMIO].=
base;<br>
&gt; +=C2=A0 =C2=A0 hwaddr size_mmio =3D vms-&gt;memmap[VMAPPLE_PCIE_MMIO].=
size;<br>
&gt; +=C2=A0 =C2=A0 hwaddr base_ecam =3D vms-&gt;memmap[VMAPPLE_PCIE_ECAM].=
base;<br>
&gt; +=C2=A0 =C2=A0 hwaddr size_ecam =3D vms-&gt;memmap[VMAPPLE_PCIE_ECAM].=
size;<br>
&gt; +=C2=A0 =C2=A0 int irq =3D vms-&gt;irqmap[VMAPPLE_PCIE];<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *mmio_alias;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *mmio_reg;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *ecam_reg;<br>
&gt; +=C2=A0 =C2=A0 DeviceState *dev;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 PCIHostState *pci;<br>
&gt; +=C2=A0 =C2=A0 DeviceState *usb_controller;<br>
&gt; +=C2=A0 =C2=A0 USBBus *usb_bus;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dev =3D qdev_new(TYPE_GPEX_HOST);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(dev, &quot;num-irqs&quot;, GPEX_NU=
M_IRQS);<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &amp;erro=
r_fatal);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Map only the first size_ecam bytes of ECAM space */<=
br>
&gt; +=C2=A0 =C2=A0 ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev)=
, 0);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_alias(&amp;vms-&gt;ecam_alias, OBJEC=
T(dev), &quot;pcie-ecam&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ecam_reg, 0, size_ecam);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), base_e=
cam,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;vms-&gt;ecam_alias);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Map the MMIO window from [0x50000000-0x7fff0000=
] in PCI space into<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* system address space at [0x50000000-0x7fff0000]=
.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 mmio_alias =3D g_new0(MemoryRegion, 1);<br>
&gt; +=C2=A0 =C2=A0 mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev)=
, 1);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_alias(mmio_alias, OBJECT(dev), &quot=
;pcie-mmio&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmio_reg, base_mmio, size_mmio);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), base_m=
mio, mmio_alias);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; GPEX_NUM_IRQS; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(dev), i=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(vms-&gt;gic, irq + i));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpex_set_irq_num(GPEX_HOST(dev), i, irq +=
 i);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 pci =3D PCI_HOST_BRIDGE(dev);<br>
&gt; +=C2=A0 =C2=A0 vms-&gt;bus =3D pci-&gt;bus;<br>
&gt; +=C2=A0 =C2=A0 g_assert(vms-&gt;bus);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 while ((dev =3D qemu_create_nic_device(&quot;virtio-net=
-pci&quot;, true, NULL))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_realize_and_unref(dev, BUS(vms-&gt;b=
us), &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (defaults_enabled()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usb_controller =3D qdev_new(TYPE_QEMU_XHC=
I);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_realize_and_unref(usb_controller, BU=
S(pci-&gt;bus), &amp;error_fatal);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usb_bus =3D USB_BUS(object_resolve_type_u=
nambiguous(TYPE_USB_BUS,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fata=
l));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usb_create_simple(usb_bus, &quot;usb-kbd&=
quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usb_create_simple(usb_bus, &quot;usb-tabl=
et&quot;);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vmapple_reset(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VMAppleMachineState *vms =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 hwaddr base =3D vms-&gt;memmap[VMAPPLE_FIRMWARE].base;<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cpu_set_pc(first_cpu, base);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void mach_vmapple_init(MachineState *machine)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VMAppleMachineState *vms =3D VMAPPLE_MACHINE(machine);<=
br>
&gt; +=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_GET_CLASS(machine);<br>
&gt; +=C2=A0 =C2=A0 const CPUArchIdList *possible_cpus;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *sysmem =3D get_system_memory();<br>
&gt; +=C2=A0 =C2=A0 int n;<br>
&gt; +=C2=A0 =C2=A0 unsigned int smp_cpus =3D machine-&gt;smp.cpus;<br>
&gt; +=C2=A0 =C2=A0 unsigned int max_cpus =3D machine-&gt;smp.max_cpus;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vms-&gt;memmap =3D memmap;<br>
&gt; +=C2=A0 =C2=A0 machine-&gt;usb =3D true;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 possible_cpus =3D mc-&gt;possible_cpu_arch_ids(machine)=
;<br>
&gt; +=C2=A0 =C2=A0 assert(possible_cpus-&gt;len =3D=3D max_cpus);<br>
&gt; +=C2=A0 =C2=A0 for (n =3D 0; n &lt; possible_cpus-&gt;len; n++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Object *cpu;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUState *cs;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n &gt;=3D smp_cpus) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu =3D object_new(possible_cpus-&gt;cpus=
[n].type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_int(cpu, &quot;mp-aff=
inity&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 possible_cpus-&gt;cpus[n].arch_i=
d, &amp;error_fatal);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cs =3D CPU(cpu);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;cpu_index =3D n;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 numa_cpu_pre_plug(&amp;possible_cpus-&gt;=
cpus[cs-&gt;cpu_index], DEVICE(cpu),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (object_property_find(cpu, &quot;has_e=
l3&quot;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(cp=
u, &quot;has_el3&quot;, false, &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (object_property_find(cpu, &quot;has_e=
l2&quot;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(cp=
u, &quot;has_el2&quot;, false, &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_int(cpu, &quot;psci-c=
onduit&quot;, QEMU_PSCI_CONDUIT_HVC,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Secondary CPUs start in PSCI powered-d=
own state */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(cp=
u, &quot;start-powered-off&quot;, true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_f=
atal);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_link(cpu, &quot;memor=
y&quot;, OBJECT(sysmem), &amp;error_abort);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_realize(DEVICE(cpu), NULL, &amp;erro=
r_fatal);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unref(cpu);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(sysmem, vms-&gt;memmap[VMAP=
PLE_MEM].base,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 machine-&gt;ram);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 create_gic(vms, sysmem);<br>
&gt; +=C2=A0 =C2=A0 create_bdif(vms, sysmem);<br>
&gt; +=C2=A0 =C2=A0 create_pvpanic(vms, sysmem);<br>
&gt; +=C2=A0 =C2=A0 create_aes(vms, sysmem);<br>
&gt; +=C2=A0 =C2=A0 create_gfx(vms, sysmem);<br>
&gt; +=C2=A0 =C2=A0 create_uart(vms, VMAPPLE_UART, sysmem, serial_hd(0));<b=
r>
&gt; +=C2=A0 =C2=A0 create_rtc(vms);<br>
&gt; +=C2=A0 =C2=A0 create_pcie(vms);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 create_gpio_devices(vms, VMAPPLE_GPIO, sysmem);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vmapple_firmware_init(vms, sysmem);<br>
&gt; +=C2=A0 =C2=A0 create_cfg(vms, sysmem, &amp;error_fatal);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* connect powerdown request */<br>
&gt; +=C2=A0 =C2=A0 vms-&gt;powerdown_notifier.notify =3D vmapple_powerdown=
_req;<br>
&gt; +=C2=A0 =C2=A0 qemu_register_powerdown_notifier(&amp;vms-&gt;powerdown=
_notifier);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vms-&gt;bootinfo.ram_size =3D machine-&gt;ram_size;<br>
&gt; +=C2=A0 =C2=A0 vms-&gt;bootinfo.board_id =3D -1;<br>
&gt; +=C2=A0 =C2=A0 vms-&gt;bootinfo.loader_start =3D vms-&gt;memmap[VMAPPL=
E_MEM].base;<br>
&gt; +=C2=A0 =C2=A0 vms-&gt;bootinfo.skip_dtb_autoload =3D true;<br>
&gt; +=C2=A0 =C2=A0 vms-&gt;bootinfo.firmware_loaded =3D true;<br>
&gt; +=C2=A0 =C2=A0 arm_load_kernel(ARM_CPU(first_cpu), machine, &amp;vms-&=
gt;bootinfo);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_register_reset(vmapple_reset, vms);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static CpuInstanceProperties<br>
&gt; +vmapple_cpu_index_to_props(MachineState *ms, unsigned cpu_index)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_GET_CLASS(ms);<br>
&gt; +=C2=A0 =C2=A0 const CPUArchIdList *possible_cpus =3D mc-&gt;possible_=
cpu_arch_ids(ms);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 assert(cpu_index &lt; possible_cpus-&gt;len);<br>
&gt; +=C2=A0 =C2=A0 return possible_cpus-&gt;cpus[cpu_index].props;<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static int64_t vmapple_get_default_cpu_node_id(const MachineState *ms=
, int idx)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return idx % ms-&gt;numa_state-&gt;num_nodes;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const CPUArchIdList *vmapple_possible_cpu_arch_ids(MachineStat=
e *ms)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int n;<br>
&gt; +=C2=A0 =C2=A0 unsigned int max_cpus =3D ms-&gt;smp.max_cpus;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (ms-&gt;possible_cpus) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ms-&gt;possible_cpus-&gt;len =3D=
=3D max_cpus);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ms-&gt;possible_cpus;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ms-&gt;possible_cpus =3D g_malloc0(sizeof(CPUArchIdList=
) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(CPUArchId) * max_c=
pus);<br>
&gt; +=C2=A0 =C2=A0 ms-&gt;possible_cpus-&gt;len =3D max_cpus;<br>
&gt; +=C2=A0 =C2=A0 for (n =3D 0; n &lt; ms-&gt;possible_cpus-&gt;len; n++)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ms-&gt;possible_cpus-&gt;cpus[n].type =3D=
 ms-&gt;cpu_type;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ms-&gt;possible_cpus-&gt;cpus[n].arch_id =
=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arm_build_mp_affinity(n, GI=
CV3_TARGETLIST_BITS);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ms-&gt;possible_cpus-&gt;cpus[n].props.ha=
s_thread_id =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ms-&gt;possible_cpus-&gt;cpus[n].props.th=
read_id =3D n;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ms-&gt;possible_cpus;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vmapple_machine_class_init(ObjectClass *oc, void *data)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;init =3D mach_vmapple_init;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;max_cpus =3D 32;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;block_default_type =3D IF_VIRTIO;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;no_cdrom =3D 1;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;pci_allow_0_address =3D true;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;minimum_page_bits =3D 12;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;possible_cpu_arch_ids =3D vmapple_possible_cpu_a=
rch_ids;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;cpu_index_to_instance_props =3D vmapple_cpu_inde=
x_to_props;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;default_cpu_type =3D ARM_CPU_TYPE_NAME(&quot;hos=
t&quot;);<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;get_default_cpu_node_id =3D vmapple_get_default_=
cpu_node_id;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;default_ram_id =3D &quot;mach-vmapple.ram&quot;;=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_register_sugar_prop(TYPE_VIRTIO_PCI, &quot;disab=
le-legacy&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;on&quot;, true);<br>
<br>
This global property default is written in a suboptiomal manner.<br>
<br>
Global properties are held with the following variable in qom/object.c:<br>
<br>
/*<br>
=C2=A0 * Global property defaults<br>
=C2=A0 * Slot 0: accelerator&#39;s global property defaults<br>
=C2=A0 * Slot 1: machine&#39;s global property defaults<br>
=C2=A0 * Slot 2: global properties from legacy command line option<br>
=C2=A0 * Each is a GPtrArray of of GlobalProperty.<br>
=C2=A0 * Applied in order, later entries override earlier ones.<br>
=C2=A0 */<br>
static GPtrArray *object_compat_props[3];<br>
<br>
object_register_sugar_prop() uses slot 2, but we are creating machine&#39;s=
 <br>
global property defaults, so we should use slot 1. Besides it also <br>
includes a few unnecessary allocations.<br>
<br>
Please pull the code from &quot;[PATCH v2 6/6] hw/vmapple: XHCI controller&=
#39;s <br>
interrupt mapping workaround for macOS&quot; to remove this <br>
object_register_sugar_prop() call.<br></blockquote><div><br></div><div>I se=
e what you mean, add { TYPE_VIRTIO_PCI, &quot;disable-legacy&quot;, &quot;o=
n&quot; }, to the vmapple_compat_defaults table introduced in the commit yo=
u mentioned. Yeah, that makes sense.<br></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
&gt; +}<br>
&gt; +<br>
&gt; +static void vmapple_instance_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VMAppleMachineState *vms =3D VMAPPLE_MACHINE(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vms-&gt;irqmap =3D irqmap;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_add_uint64_ptr(obj, &quot;uuid&quot;, &=
amp;vms-&gt;uuid,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJ_PROP_FLAG_READW=
RITE);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_description(obj, &quot;uuid&quot;, =
&quot;Machine UUID (SDOM)&quot;);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo vmapple_machine_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_VMAPPL=
E_MACHINE,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_MACHINE,<br=
>
&gt; +=C2=A0 =C2=A0 .abstract=C2=A0 =C2=A0 =C2=A0 =3D true,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VMAppleMachineState),<br>
&gt; +=C2=A0 =C2=A0 .class_size=C2=A0 =C2=A0 =3D sizeof(VMAppleMachineClass=
),<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D vmapple_machine_class_init=
,<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D vmapple_instance_init,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void machvmapple_machine_init(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;vmapple_machine_info);<br>
&gt; +}<br>
&gt; +type_init(machvmapple_machine_init);<br>
&gt; +<br>
&gt; +static void vmapple_machine_10_0_options(MachineClass *mc)<br>
&gt; +{<br>
&gt; +}<br>
&gt; +DEFINE_VMAPPLE_MACHINE_AS_LATEST(10, 0)<br>
&gt; +<br>
<br>
</blockquote></div></div>

--000000000000bdf0890629f053ef--

