Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581C8CEF162
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 12:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy9Ai-00017x-Qu; Tue, 08 Oct 2024 08:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sy9AR-00016U-7e
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 08:18:26 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sy9AK-00069y-Kr
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 08:18:18 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e25cf3c7278so4865031276.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1728389888; x=1728994688;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dDYE5dsqRA89jxWlPVOatVITRo+ZkrFcqTaFkOp/0Uk=;
 b=o8RDh8Dzo3tbvqmcylCnHbeABGampL3hoHjSL/1hdAOZoCC2taFGHyhMFZ8Kvo9EKu
 eDM1op5lsclXCgWC6joYF+onLccl5FXUSiMO9hw4zKcg0wXZ/Q2HDN3665CSudvAUKfB
 fyoNbXCcWWH0OUH2Yn2oW0YDy/dPHO/seGNM9AfdeeO1Ppo9oDPsmf8IfaUxXHCTQ6Em
 halL9nD/5xW0cfzt+4EQQ78tdXDMRoB+fXt3JXW1EpwHvMkUScASSWikKnukuoW54ryo
 ZkmFs7DBMQQdAC+nTTOrC8+Md9iRi0pOwSUUqqXGAiPSO9hGMVevKE9q7x+dt0cz5snD
 PO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728389888; x=1728994688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dDYE5dsqRA89jxWlPVOatVITRo+ZkrFcqTaFkOp/0Uk=;
 b=Vmc8uCU4Rxmy5fzJHXHvqcbBDfb31RtyLD/Rsmgl1w/MRxTtmrItLfTQftwqqWBnxO
 QPO/2P5hJ1dMn5JQHAMZ7oxQ66uFR7+jtLB+dkXc9uXr8a88plKzM1w8lMVn4ETupz08
 a0PRKHZ4pwPy62kG46LJZM7GHRBT6bhbqDyuz9bngm+x6kjzAdENA+I3gk/sRQkwLo/l
 i2usJcdyUJCCd4vItQp50S04XUu27HksNutLGAxSxNcFwMddlQbQGOb2XGJWw01js+wX
 QB1SPMIiWCVTXcKAvKoDDA/AQHIj1NYtMKlEnTNkhNs9pPfIcOcYT9mKJpwNlvVZwBCj
 TsZw==
X-Gm-Message-State: AOJu0YxjCsvVx1TxpZBwXclbNP0POcyMwV6ATdrZmr9KU3Vgzt8Lh2LL
 gIryktp9xAf/GkMuY2y8GPndXOMVcygNg7jwPM3SnofLBMLgTvj1AQiUu20YJQgoQPOCJOKcCgL
 fbDvg0AeSFqd59+Z1hDAavB6OufOQQIN/nROb
X-Google-Smtp-Source: AGHT+IFNKyoMRx6pIAcyQepBNyYiTDHHuOAoK7I3uVpLXoOOBH3qXKwW8OzBGeLHwFTluGiZea8AIau6rmNWwXXdFoA=
X-Received: by 2002:a05:6902:2385:b0:e24:cae9:4e39 with SMTP id
 3f1490d57ef6-e2893963223mr10883020276.51.1728389888115; Tue, 08 Oct 2024
 05:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-15-phil@philjordan.eu>
 <80274a57-84e8-4499-b09d-d829aca2a5c2@daynix.com>
In-Reply-To: <80274a57-84e8-4499-b09d-d829aca2a5c2@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 8 Oct 2024 14:17:56 +0200
Message-ID: <CAAibmn0+NoRZxRqcPmOZ_f+EEg8Ci0NMHLqSixUQgbpEcckNTg@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] hw/vmapple/vmapple: Add vmapple machine type
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="00000000000050d95c0623f621ab"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::b34;
 envelope-from=phil@philjordan.eu; helo=mail-yb1-xb34.google.com
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

--00000000000050d95c0623f621ab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 5 Oct 2024 at 08:11, Akihiko Odaki <akihiko.odaki@daynix.com> wrote=
:

> On 2024/09/28 17:57, Phil Dennis-Jordan wrote:
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
> >      -device vmapple-virtio-aux,drive=3Daux \
> >      -drive file=3Droot,if=3Dnone,id=3Droot,format=3Draw \
> >      -device vmapple-virtio-root,drive=3Droot
> >
> > With all these in place, you should be able to see macOS booting
> > successfully.
> >
> > Known issues:
> >   - Keyboard and mouse/tablet input is laggy. The reason for this is
> >     either that macOS's XHCI driver is broken when the device/platform
> >     does not support MSI/MSI-X, or there's some unfortunate interplay
> >     with Qemu's XHCI implementation in this scenario.
> >   - Currently only macOS 12 guests are supported. The boot process for
> >     13+ will need further investigation and adjustment.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> >
> > ---
> > v3:
> >   * Rebased on latest upstream, updated affinity and NIC creation
> > API usage
> >   * Included Apple-variant virtio-blk in build dependency
> >   * Updated API usage for setting 'redist-region-count' array-typed
> property on GIC.
> >   * Switched from virtio HID devices (for which macOS 12 does not
> contain drivers) to an XHCI USB controller and USB HID devices.
> >
> >   MAINTAINERS                 |   1 +
> >   docs/system/arm/vmapple.rst |  63 ++++
> >   docs/system/target-arm.rst  |   1 +
> >   hw/vmapple/Kconfig          |  20 ++
> >   hw/vmapple/meson.build      |   1 +
> >   hw/vmapple/vmapple.c        | 661 +++++++++++++++++++++++++++++++++++=
+
> >   6 files changed, 747 insertions(+)
> >   create mode 100644 docs/system/arm/vmapple.rst
> >   create mode 100644 hw/vmapple/vmapple.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4e7f25e5299..89ef071a01a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2783,6 +2783,7 @@ R: Phil Dennis-Jordan <phil@philjordan.eu>
> >   S: Maintained
> >   F: hw/vmapple/*
> >   F: include/hw/vmapple/*
> > +F: docs/system/arm/vmapple.rst
> >
> >   Subsystems
> >   ----------
> > diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst
> > new file mode 100644
> > index 00000000000..acb921ffb35
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
> 12 virtual machine. I will
> > +   assume that you installed it using the macosvm CLI.
> > +
> > +First, we need to extract the UUID from the virtual machine that you
> installed. You can do this
> > +by running the following shell script:
> > +
> > +.. code-block:: bash
> > +  :caption: uuid.sh script to extract the UUID from a macosvm.json fil=
e
> > +
> > +  #!/bin/bash
> > +
> > +  MID=3D$(cat "$1" | python3 -c 'import
> json,sys;obj=3Djson.load(sys.stdin);print(obj["machineId"]);')
> > +  echo "$MID" | base64 -d | plutil -extract ECID raw -
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
> > +  $ UUID=3D$(uuid.sh macosvm.json)
> > +  $
> AVPBOOTER=3D/System/Library/Frameworks/Virtualization.framework/Resources=
/AVPBooter.vmapple2.bin
> > +  $ AUX=3Daux.img.trimmed
> > +  $ DISK=3Ddisk.img
> > +  $ qemu-system-aarch64 \
> > +       -serial mon:stdio \
> > +       -m 4G \
> > +       -accel hvf \
> > +       -M vmapple,uuid=3D$UUID \
> > +       -bios $AVPBOOTER \
> > +        -drive file=3D"$AUX",if=3Dpflash,format=3Draw \
> > +        -drive file=3D"$DISK",if=3Dpflash,format=3Draw \
> > +       -drive file=3D"$AUX",if=3Dnone,id=3Daux,format=3Draw \
> > +       -drive file=3D"$DISK",if=3Dnone,id=3Droot,format=3Draw \
> > +       -device vmapple-virtio-aux,drive=3Daux \
> > +       -device vmapple-virtio-root,drive=3Droot \
> > +       -net user,ipv6=3Doff,hostfwd=3Dtcp::2222-:22,hostfwd=3Dtcp::590=
1-:5900
> \
> > +       -net nic,model=3Dvirtio-net-pci \
> > diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> > index 7b992722846..f1948abb545 100644
> > --- a/docs/system/target-arm.rst
> > +++ b/docs/system/target-arm.rst
> > @@ -107,6 +107,7 @@ undocumented; you can get a complete list by runnin=
g
> >      arm/stellaris
> >      arm/stm32
> >      arm/virt
> > +   arm/vmapple
> >      arm/xenpvh
> >      arm/xlnx-versal-virt
> >      arm/xlnx-zynq
> > diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> > index bcd1be63e3c..0f83d4259fc 100644
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
> > +    select MAC_PVG_VMAPPLE
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
> > index 00000000000..f0060a6f7ee
> > --- /dev/null
> > +++ b/hw/vmapple/vmapple.c
> > @@ -0,0 +1,661 @@
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
> > +#include "qemu/help-texts.h"
> > +#include "qemu/datadir.h"
> > +#include "qemu/units.h"
> > +#include "qemu/option.h"
> > +#include "monitor/qdev.h"
> > +#include "hw/sysbus.h"
> > +#include "hw/arm/boot.h"
> > +#include "hw/arm/primecell.h"
> > +#include "hw/boards.h"
> > +#include "hw/usb.h"
> > +#include "net/net.h"
> > +#include "sysemu/sysemu.h"
> > +#include "sysemu/runstate.h"
> > +#include "sysemu/kvm.h"
> > +#include "sysemu/hvf.h"
> > +#include "hw/loader.h"
> > +#include "qapi/error.h"
> > +#include "qapi/qmp/qlist.h"
> > +#include "qemu/bitops.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/module.h"
> > +#include "hw/pci-host/gpex.h"
> > +#include "hw/virtio/virtio-pci.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/intc/arm_gic.h"
> > +#include "hw/intc/arm_gicv3_common.h"
> > +#include "hw/irq.h"
> > +#include "hw/usb/xhci.h"
> > +#include "qapi/visitor.h"
> > +#include "qapi/qapi-visit-common.h"
> > +#include "standard-headers/linux/input.h"
> > +#include "target/arm/internals.h"
> > +#include "target/arm/kvm_arm.h"
> > +#include "hw/char/pl011.h"
> > +#include "qemu/guest-random.h"
> > +#include "sysemu/reset.h"
> > +#include "qemu/log.h"
> > +#include "hw/vmapple/cfg.h"
> > +#include "hw/misc/pvpanic.h"
> > +#include "hw/vmapple/bdif.h"
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
> > +    Notifier powerdown_notifier;
> > +    PCIBus *bus;
> > +    MemoryRegion fw_mr;
> > +    uint64_t uuid;
> > +};
> > +
> > +#define DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, latest) \
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
> > +        error_report("No AUX device found. Please specify one as pflas=
h
> drive");
> > +        exit(1);
> > +    }
> > +
> > +    if (!di_root) {
> > +        /* Fall back to the first IF_VIRTIO device as root device */
> > +        di_root =3D drive_get(IF_VIRTIO, 0, 0);
> > +    }
> > +
> > +    if (!di_root) {
> > +        error_report("No root device found. Please specify one as
> virtio drive");
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
> > +    SysBusDevice *cfg;
> > +
> > +    vms->cfg =3D qdev_new(TYPE_PVPANIC_MMIO_DEVICE);
> > +    cfg =3D SYS_BUS_DEVICE(vms->cfg);
> > +    sysbus_mmio_map(cfg, 0, vms->memmap[VMAPPLE_PVPANIC].base);
> > +
> > +    sysbus_realize_and_unref(cfg, &error_fatal);
> > +}
> > +
> > +static void create_cfg(VMAppleMachineState *vms, MemoryRegion *mem)
> > +{
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
> > +    sysbus_realize_and_unref(cfg, &error_fatal);
> > +}
> > +
> > +static void create_gfx(VMAppleMachineState *vms, MemoryRegion *mem)
> > +{
> > +    int irq_gfx =3D vms->irqmap[VMAPPLE_APV_GFX];
> > +    int irq_iosfc =3D vms->irqmap[VMAPPLE_APV_IOSFC];
> > +    SysBusDevice *aes;
> > +
> > +    aes =3D SYS_BUS_DEVICE(qdev_new("apple-gfx-vmapple"));
> > +    sysbus_mmio_map(aes, 0, vms->memmap[VMAPPLE_APV_GFX].base);
> > +    sysbus_mmio_map(aes, 1, vms->memmap[VMAPPLE_APV_IOSFC].base);
> > +    sysbus_connect_irq(aes, 0, qdev_get_gpio_in(vms->gic, irq_gfx));
> > +    sysbus_connect_irq(aes, 1, qdev_get_gpio_in(vms->gic, irq_iosfc));
> > +    sysbus_realize_and_unref(aes, &error_fatal);
> > +}
> > +
> > +static void create_aes(VMAppleMachineState *vms, MemoryRegion *mem)
> > +{
> > +    int irq =3D vms->irqmap[VMAPPLE_AES_1];
> > +    SysBusDevice *aes;
> > +
> > +    aes =3D SYS_BUS_DEVICE(qdev_new("apple-aes"));
> > +    sysbus_mmio_map(aes, 0, vms->memmap[VMAPPLE_AES_1].base);
> > +    sysbus_mmio_map(aes, 1, vms->memmap[VMAPPLE_AES_2].base);
> > +    sysbus_connect_irq(aes, 0, qdev_get_gpio_in(vms->gic, irq));
> > +    sysbus_realize_and_unref(aes, &error_fatal);
> > +}
> > +
> > +static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
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
> > +    memory_region_init_ram(&vms->fw_mr, NULL, "firmware", size, NULL);
>
> Pass: &error_fatal
>
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
> > +    MemoryRegion *ecam_alias;
> > +    MemoryRegion *ecam_reg;
> > +    DeviceState *dev;
> > +    int i;
> > +    PCIHostState *pci;
> > +    DeviceState *usb_controller;
> > +    USBBus *usb_bus;
> > +
> > +    dev =3D qdev_new(TYPE_GPEX_HOST);
> > +    qdev_prop_set_uint32(dev, "nr-irqs", GPEX_NUM_IRQS);
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > +
> > +    /* Map only the first size_ecam bytes of ECAM space */
> > +    ecam_alias =3D g_new0(MemoryRegion, 1);
> > +    ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> > +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> > +                             ecam_reg, 0, size_ecam);
> > +    memory_region_add_subregion(get_system_memory(), base_ecam,
> ecam_alias);
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
> > +    g_assert_nonnull(vms->bus);
> > +
> > +    while ((dev =3D qemu_create_nic_device("virtio-net-pci", true,
> NULL))) {
> > +        qdev_realize_and_unref(dev, BUS(vms->bus), &error_fatal);
> > +    }
> > +
> > +    usb_controller =3D qdev_new(TYPE_QEMU_XHCI);
> > +    qdev_realize_and_unref(usb_controller, BUS(pci->bus), &error_fatal=
);
> > +
> > +    usb_bus =3D USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
> > +                                                      &error_fatal));
> > +    usb_create_simple(usb_bus, "usb-kbd");
> > +    usb_create_simple(usb_bus, "usb-tablet");
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
> > +                                possible_cpus->cpus[n].arch_id, NULL);
> > +
> > +        cs =3D CPU(cpu);
> > +        cs->cpu_index =3D n;
> > +
> > +        numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index],
> DEVICE(cpu),
> > +                          &error_fatal);
> > +
> > +        object_property_set_bool(cpu, "has_el3", false, NULL);
> > +        object_property_set_bool(cpu, "has_el2", false, NULL);
> > +        object_property_set_int(cpu, "psci-conduit",
> QEMU_PSCI_CONDUIT_HVC,
> > +                                NULL);
> > +
> > +        /* Secondary CPUs start in PSCI powered-down state */
> > +        if (n > 0) {
> > +            object_property_set_bool(cpu, "start-powered-off", true,
> NULL);
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
> > +    create_cfg(vms, sysmem);
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
> > +static void vmapple_get_uuid(Object *obj, Visitor *v, const char *name=
,
> > +                             void *opaque, Error **errp)
> > +{
> > +    VMAppleMachineState *vms =3D VMAPPLE_MACHINE(obj);
> > +    uint64_t value =3D be64_to_cpu(vms->uuid);
> > +
> > +    visit_type_uint64(v, name, &value, errp);
> > +}
> > +
> > +static void vmapple_set_uuid(Object *obj, Visitor *v, const char *name=
,
> > +                             void *opaque, Error **errp)
> > +{
> > +    VMAppleMachineState *vms =3D VMAPPLE_MACHINE(obj);
> > +    Error *error =3D NULL;
> > +    uint64_t value;
> > +
> > +    visit_type_uint64(v, name, &value, &error);
> > +    if (error) {
> > +        error_propagate(errp, error);
> > +        return;
> > +    }
> > +
> > +    vms->uuid =3D cpu_to_be64(value);
> > +}
>
> vmapple converts the value to big endian here and vmapple-cfg converts
> it back later. What's the intention?
>

Good question. This isn't originally my code, so I could at best guess.
Removing all the conversions seems to have no negative effects in practice.
(As you'd expect.) The Cfg area is memory-mapped into the guest, but none
of the other fields are endian-adjusted, and as you say it's done twice so
there doesn't really seem to be a good reason for any conversion here.


>  > +> +static void vmapple_machine_class_init(ObjectClass *oc, void *data=
)
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
> > +    if (hvf_enabled()) {
> > +        mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("host");
> > +    } else {
> > +        mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("max");
> > +    }
>
> Remove this conditional. VMApple only works with the host model.
>
> (I wonder if this works on KVM on Asahi Linux by the way.
> apple-gfx-vmapple won't work, but perhaps anything else may just work.)
>

I don't think macOS boots without a graphics device, and on aarch64 there's
no UEFI framebuffer or VGA fallback device driver available. In fact the
vmapple kernel doesn't even contain the driver for the physical GPUs found
on Macs, and vice versa. I don't know if the PVG guest driver supports some
kind of framebuffer-only mode similar to the UEFI driver for it, I'll leave
that for someone else to figure out. :-)


> > +    mc->get_default_cpu_node_id =3D vmapple_get_default_cpu_node_id;
> > +    mc->default_ram_id =3D "mach-vmapple.ram";
> > +
> > +    object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legacy",
> > +                               "on", true);
> > +
> > +    object_class_property_add(oc, "uuid", "uint64", vmapple_get_uuid,
> > +                              vmapple_set_uuid, NULL, NULL);
> > +    object_class_property_set_description(oc, "uuid", "Machine UUID
> (SDOM)");
> > +}
> > +
> > +static void vmapple_instance_init(Object *obj)
> > +{
> > +    VMAppleMachineState *vms =3D VMAPPLE_MACHINE(obj);
> > +
> > +    vms->irqmap =3D irqmap;
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
> > +static void vmapple_machine_8_1_options(MachineClass *mc)
> > +{
> > +}
> > +DEFINE_VMAPPLE_MACHINE_AS_LATEST(8, 1)
>
> Please update this.
>
> > +
>
>

--00000000000050d95c0623f621ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, 5 Oct 2024 at 08:11, Akihiko =
Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blank">aki=
hiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">On 2024/09/28 17:57, Phil Dennis-Jordan wrote:<br>
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
&gt;=C2=A0 =C2=A0 =C2=A0 -device vmapple-virtio-aux,drive=3Daux \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Droot,if=3Dnone,id=3Droot,format=3Dra=
w \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -device vmapple-virtio-root,drive=3Droot<br>
&gt; <br>
&gt; With all these in place, you should be able to see macOS booting<br>
&gt; successfully.<br>
&gt; <br>
&gt; Known issues:<br>
&gt;=C2=A0 =C2=A0- Keyboard and mouse/tablet input is laggy. The reason for=
 this is<br>
&gt;=C2=A0 =C2=A0 =C2=A0either that macOS&#39;s XHCI driver is broken when =
the device/platform<br>
&gt;=C2=A0 =C2=A0 =C2=A0does not support MSI/MSI-X, or there&#39;s some unf=
ortunate interplay<br>
&gt;=C2=A0 =C2=A0 =C2=A0with Qemu&#39;s XHCI implementation in this scenari=
o.<br>
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
&gt; <br>
&gt; ---<br>
&gt; v3:<br>
&gt;=C2=A0 =C2=A0* Rebased on latest upstream, updated affinity and NIC cre=
ation<br>
&gt; API usage<br>
&gt;=C2=A0 =C2=A0* Included Apple-variant virtio-blk in build dependency<br=
>
&gt;=C2=A0 =C2=A0* Updated API usage for setting &#39;redist-region-count&#=
39; array-typed property on GIC.<br>
&gt;=C2=A0 =C2=A0* Switched from virtio HID devices (for which macOS 12 doe=
s not contain drivers) to an XHCI USB controller and USB HID devices.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0docs/system/arm/vmapple.rst |=C2=A0 63 ++++<br>
&gt;=C2=A0 =C2=A0docs/system/target-arm.rst=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 20 ++<br>
&gt;=C2=A0 =C2=A0hw/vmapple/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01=
 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/vmapple.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 661 ++++=
++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A06 files changed, 747 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/system/arm/vmapple.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/vmapple.c<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 4e7f25e5299..89ef071a01a 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -2783,6 +2783,7 @@ R: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil=
@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt;=C2=A0 =C2=A0S: Maintained<br>
&gt;=C2=A0 =C2=A0F: hw/vmapple/*<br>
&gt;=C2=A0 =C2=A0F: include/hw/vmapple/*<br>
&gt; +F: docs/system/arm/vmapple.rst<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0Subsystems<br>
&gt;=C2=A0 =C2=A0----------<br>
&gt; diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst=
<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..acb921ffb35<br>
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
 12 virtual machine. I will<br>
&gt; +=C2=A0 =C2=A0assume that you installed it using the macosvm CLI.<br>
&gt; +<br>
&gt; +First, we need to extract the UUID from the virtual machine that you =
installed. You can do this<br>
&gt; +by running the following shell script:<br>
&gt; +<br>
&gt; +.. code-block:: bash<br>
&gt; +=C2=A0 :caption: uuid.sh script to extract the UUID from a macosvm.js=
on file<br>
&gt; +<br>
&gt; +=C2=A0 #!/bin/bash<br>
&gt; +<br>
&gt; +=C2=A0 MID=3D$(cat &quot;$1&quot; | python3 -c &#39;import json,sys;o=
bj=3Djson.load(sys.stdin);print(obj[&quot;machineId&quot;]);&#39;)<br>
&gt; +=C2=A0 echo &quot;$MID&quot; | base64 -d | plutil -extract ECID raw -=
<br>
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
&gt; +=C2=A0 $ UUID=3D$(uuid.sh macosvm.json)<br>
&gt; +=C2=A0 $ AVPBOOTER=3D/System/Library/Frameworks/Virtualization.framew=
ork/Resources/AVPBooter.vmapple2.bin<br>
&gt; +=C2=A0 $ AUX=3Daux.img.trimmed<br>
&gt; +=C2=A0 $ DISK=3Ddisk.img<br>
&gt; +=C2=A0 $ qemu-system-aarch64 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-serial mon:stdio \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-m 4G \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-accel hvf \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-M vmapple,uuid=3D$UUID \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-bios $AVPBOOTER \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 -drive file=3D&quot;$AUX&quot;,if=3Dpflas=
h,format=3Draw \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 -drive file=3D&quot;$DISK&quot;,if=3Dpfla=
sh,format=3Draw \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D&quot;$AUX&quot;,if=3Dnone,i=
d=3Daux,format=3Draw \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D&quot;$DISK&quot;,if=3Dnone,=
id=3Droot,format=3Draw \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-device vmapple-virtio-aux,drive=3Daux \<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-device vmapple-virtio-root,drive=3Droot \=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-net user,ipv6=3Doff,hostfwd=3Dtcp::2222-:=
22,hostfwd=3Dtcp::5901-:5900 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-net nic,model=3Dvirtio-net-pci \<br>
&gt; diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst<b=
r>
&gt; index 7b992722846..f1948abb545 100644<br>
&gt; --- a/docs/system/target-arm.rst<br>
&gt; +++ b/docs/system/target-arm.rst<br>
&gt; @@ -107,6 +107,7 @@ undocumented; you can get a complete list by runni=
ng<br>
&gt;=C2=A0 =C2=A0 =C2=A0 arm/stellaris<br>
&gt;=C2=A0 =C2=A0 =C2=A0 arm/stm32<br>
&gt;=C2=A0 =C2=A0 =C2=A0 arm/virt<br>
&gt; +=C2=A0 =C2=A0arm/vmapple<br>
&gt;=C2=A0 =C2=A0 =C2=A0 arm/xenpvh<br>
&gt;=C2=A0 =C2=A0 =C2=A0 arm/xlnx-versal-virt<br>
&gt;=C2=A0 =C2=A0 =C2=A0 arm/xlnx-zynq<br>
&gt; diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig<br>
&gt; index bcd1be63e3c..0f83d4259fc 100644<br>
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
&gt; +=C2=A0 =C2=A0 select MAC_PVG_VMAPPLE<br>
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
&gt; index 00000000000..f0060a6f7ee<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/vmapple/vmapple.c<br>
&gt; @@ -0,0 +1,661 @@<br>
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
&gt; +#include &quot;qemu/help-texts.h&quot;<br>
&gt; +#include &quot;qemu/datadir.h&quot;<br>
&gt; +#include &quot;qemu/units.h&quot;<br>
&gt; +#include &quot;qemu/option.h&quot;<br>
&gt; +#include &quot;monitor/qdev.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;hw/arm/boot.h&quot;<br>
&gt; +#include &quot;hw/arm/primecell.h&quot;<br>
&gt; +#include &quot;hw/boards.h&quot;<br>
&gt; +#include &quot;hw/usb.h&quot;<br>
&gt; +#include &quot;net/net.h&quot;<br>
&gt; +#include &quot;sysemu/sysemu.h&quot;<br>
&gt; +#include &quot;sysemu/runstate.h&quot;<br>
&gt; +#include &quot;sysemu/kvm.h&quot;<br>
&gt; +#include &quot;sysemu/hvf.h&quot;<br>
&gt; +#include &quot;hw/loader.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qapi/qmp/qlist.h&quot;<br>
&gt; +#include &quot;qemu/bitops.h&quot;<br>
&gt; +#include &quot;qemu/error-report.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;hw/pci-host/gpex.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio-pci.h&quot;<br>
&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; +#include &quot;hw/intc/arm_gic.h&quot;<br>
&gt; +#include &quot;hw/intc/arm_gicv3_common.h&quot;<br>
&gt; +#include &quot;hw/irq.h&quot;<br>
&gt; +#include &quot;hw/usb/xhci.h&quot;<br>
&gt; +#include &quot;qapi/visitor.h&quot;<br>
&gt; +#include &quot;qapi/qapi-visit-common.h&quot;<br>
&gt; +#include &quot;standard-headers/linux/input.h&quot;<br>
&gt; +#include &quot;target/arm/internals.h&quot;<br>
&gt; +#include &quot;target/arm/kvm_arm.h&quot;<br>
&gt; +#include &quot;hw/char/pl011.h&quot;<br>
&gt; +#include &quot;qemu/guest-random.h&quot;<br>
&gt; +#include &quot;sysemu/reset.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;hw/vmapple/cfg.h&quot;<br>
&gt; +#include &quot;hw/misc/pvpanic.h&quot;<br>
&gt; +#include &quot;hw/vmapple/bdif.h&quot;<br>
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
&gt; +=C2=A0 =C2=A0 Notifier powerdown_notifier;<br>
&gt; +=C2=A0 =C2=A0 PCIBus *bus;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion fw_mr;<br>
&gt; +=C2=A0 =C2=A0 uint64_t uuid;<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define DEFINE_VMAPPLE_MACHINE_LATEST(major, minor, latest) \<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;No AUX device found. P=
lease specify one as pflash drive&quot;);<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;No root device found. =
Please specify one as virtio drive&quot;);<br>
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
&gt; +=C2=A0 =C2=A0 SysBusDevice *cfg;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vms-&gt;cfg =3D qdev_new(TYPE_PVPANIC_MMIO_DEVICE);<br>
&gt; +=C2=A0 =C2=A0 cfg =3D SYS_BUS_DEVICE(vms-&gt;cfg);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(cfg, 0, vms-&gt;memmap[VMAPPLE_PVPANIC]=
.base);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(cfg, &amp;error_fatal);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void create_cfg(VMAppleMachineState *vms, MemoryRegion *mem)<b=
r>
&gt; +{<br>
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
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(cfg, &amp;error_fatal);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void create_gfx(VMAppleMachineState *vms, MemoryRegion *mem)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int irq_gfx =3D vms-&gt;irqmap[VMAPPLE_APV_GFX];<br>
&gt; +=C2=A0 =C2=A0 int irq_iosfc =3D vms-&gt;irqmap[VMAPPLE_APV_IOSFC];<br=
>
&gt; +=C2=A0 =C2=A0 SysBusDevice *aes;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 aes =3D SYS_BUS_DEVICE(qdev_new(&quot;apple-gfx-vmapple=
&quot;));<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(aes, 0, vms-&gt;memmap[VMAPPLE_APV_GFX]=
.base);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(aes, 1, vms-&gt;memmap[VMAPPLE_APV_IOSF=
C].base);<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(aes, 0, qdev_get_gpio_in(vms-&gt;gic=
, irq_gfx));<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(aes, 1, qdev_get_gpio_in(vms-&gt;gic=
, irq_iosfc));<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(aes, &amp;error_fatal);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void create_aes(VMAppleMachineState *vms, MemoryRegion *mem)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int irq =3D vms-&gt;irqmap[VMAPPLE_AES_1];<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *aes;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 aes =3D SYS_BUS_DEVICE(qdev_new(&quot;apple-aes&quot;))=
;<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(aes, 0, vms-&gt;memmap[VMAPPLE_AES_1].b=
ase);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(aes, 1, vms-&gt;memmap[VMAPPLE_AES_2].b=
ase);<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(aes, 0, qdev_get_gpio_in(vms-&gt;gic=
, irq));<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(aes, &amp;error_fatal);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)<br>
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
firmware&quot;, size, NULL);<br>
<br>
Pass: &amp;error_fatal<br>
<br>
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
&gt; +=C2=A0 =C2=A0 MemoryRegion *ecam_alias;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *ecam_reg;<br>
&gt; +=C2=A0 =C2=A0 DeviceState *dev;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 PCIHostState *pci;<br>
&gt; +=C2=A0 =C2=A0 DeviceState *usb_controller;<br>
&gt; +=C2=A0 =C2=A0 USBBus *usb_bus;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dev =3D qdev_new(TYPE_GPEX_HOST);<br>
&gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(dev, &quot;nr-irqs&quot;, GPEX_NUM=
_IRQS);<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &amp;erro=
r_fatal);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Map only the first size_ecam bytes of ECAM space */<=
br>
&gt; +=C2=A0 =C2=A0 ecam_alias =3D g_new0(MemoryRegion, 1);<br>
&gt; +=C2=A0 =C2=A0 ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev)=
, 0);<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_alias(ecam_alias, OBJECT(dev), &quot=
;pcie-ecam&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ecam_reg, 0, size_ecam);<br>
&gt; +=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), base_e=
cam, ecam_alias);<br>
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
&gt; +=C2=A0 =C2=A0 g_assert_nonnull(vms-&gt;bus);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 while ((dev =3D qemu_create_nic_device(&quot;virtio-net=
-pci&quot;, true, NULL))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_realize_and_unref(dev, BUS(vms-&gt;b=
us), &amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 usb_controller =3D qdev_new(TYPE_QEMU_XHCI);<br>
&gt; +=C2=A0 =C2=A0 qdev_realize_and_unref(usb_controller, BUS(pci-&gt;bus)=
, &amp;error_fatal);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 usb_bus =3D USB_BUS(object_resolve_type_unambiguous(TYP=
E_USB_BUS,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal));<br>
&gt; +=C2=A0 =C2=A0 usb_create_simple(usb_bus, &quot;usb-kbd&quot;);<br>
&gt; +=C2=A0 =C2=A0 usb_create_simple(usb_bus, &quot;usb-tablet&quot;);<br>
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
d, NULL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cs =3D CPU(cpu);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;cpu_index =3D n;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 numa_cpu_pre_plug(&amp;possible_cpus-&gt;=
cpus[cs-&gt;cpu_index], DEVICE(cpu),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(cpu, &quot;has_e=
l3&quot;, false, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(cpu, &quot;has_e=
l2&quot;, false, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_int(cpu, &quot;psci-c=
onduit&quot;, QEMU_PSCI_CONDUIT_HVC,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Secondary CPUs start in PSCI powered-d=
own state */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(cp=
u, &quot;start-powered-off&quot;, true, NULL);<br>
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
&gt; +=C2=A0 =C2=A0 create_cfg(vms, sysmem);<br>
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
&gt; +static void vmapple_get_uuid(Object *obj, Visitor *v, const char *nam=
e,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VMAppleMachineState *vms =3D VMAPPLE_MACHINE(obj);<br>
&gt; +=C2=A0 =C2=A0 uint64_t value =3D be64_to_cpu(vms-&gt;uuid);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 visit_type_uint64(v, name, &amp;value, errp);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vmapple_set_uuid(Object *obj, Visitor *v, const char *nam=
e,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VMAppleMachineState *vms =3D VMAPPLE_MACHINE(obj);<br>
&gt; +=C2=A0 =C2=A0 Error *error =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 uint64_t value;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 visit_type_uint64(v, name, &amp;value, &amp;error);<br>
&gt; +=C2=A0 =C2=A0 if (error) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, error);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vms-&gt;uuid =3D cpu_to_be64(value);<br>
&gt; +}<br>
<br>
vmapple converts the value to big endian here and vmapple-cfg converts <br>
it back later. What&#39;s the intention?<br></blockquote><div><br></div><di=
v>Good question. This isn&#39;t originally my code, so I could at best gues=
s. Removing all the conversions seems to have no negative effects in practi=
ce. (As you&#39;d expect.) The Cfg area is memory-mapped into the guest, bu=
t none of the other fields are endian-adjusted, and as you say it&#39;s don=
e twice so there doesn&#39;t really seem to be a good reason for any conver=
sion here.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
=C2=A0&gt; +&gt; +static void vmapple_machine_class_init(ObjectClass *oc, v=
oid *data)<br>
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
&gt; +=C2=A0 =C2=A0 if (hvf_enabled()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mc-&gt;default_cpu_type =3D ARM_CPU_TYPE_=
NAME(&quot;host&quot;);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mc-&gt;default_cpu_type =3D ARM_CPU_TYPE_=
NAME(&quot;max&quot;);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Remove this conditional. VMApple only works with the host model.<br>
<br>
(I wonder if this works on KVM on Asahi Linux by the way. <br>
apple-gfx-vmapple won&#39;t work, but perhaps anything else may just work.)=
<br></blockquote><div><br></div><div>I don&#39;t think macOS boots without =
a graphics device, and on aarch64 there&#39;s no UEFI framebuffer or VGA fa=
llback device driver available. In fact the vmapple kernel doesn&#39;t even=
 contain the driver for the physical GPUs found on Macs, and vice versa. I =
don&#39;t know if the PVG guest driver supports some kind of framebuffer-on=
ly mode similar to the UEFI driver for it, I&#39;ll leave that for someone =
else to figure out. :-)<br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 mc-&gt;get_default_cpu_node_id =3D vmapple_get_default_=
cpu_node_id;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;default_ram_id =3D &quot;mach-vmapple.ram&quot;;=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_register_sugar_prop(TYPE_VIRTIO_PCI, &quot;disab=
le-legacy&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;on&quot;, true);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_class_property_add(oc, &quot;uuid&quot;, &quot;u=
int64&quot;, vmapple_get_uuid,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmapple_set_uuid, NULL, NULL);<br>
&gt; +=C2=A0 =C2=A0 object_class_property_set_description(oc, &quot;uuid&qu=
ot;, &quot;Machine UUID (SDOM)&quot;);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vmapple_instance_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VMAppleMachineState *vms =3D VMAPPLE_MACHINE(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vms-&gt;irqmap =3D irqmap;<br>
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
&gt; +static void vmapple_machine_8_1_options(MachineClass *mc)<br>
&gt; +{<br>
&gt; +}<br>
&gt; +DEFINE_VMAPPLE_MACHINE_AS_LATEST(8, 1)<br>
<br>
Please update this.<br>
<br>
&gt; +<br>
<br>
</blockquote></div></div>

--00000000000050d95c0623f621ab--

