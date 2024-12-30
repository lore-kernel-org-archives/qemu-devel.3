Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EDEE7718F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 20:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSMBK-0006OC-Ex; Mon, 30 Dec 2024 15:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tSMBG-0006NL-Qr
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 15:16:03 -0500
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tSMBA-0007mI-Us
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 15:16:01 -0500
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4afed12283eso6073287137.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 12:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735589754; x=1736194554;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wybM68fpXbDHB//YAvjA46jZ2lQmgi3mdSGDy9MZ3ig=;
 b=Wv3TRzqDeWhkx75goscXkRsLju4EvXbh/c74SeVOl/ioXIz6GRAruN31ogo+8MtCO7
 cs6WjCK7v3S1YB3Y0qNU03w6QCwJMlNWMUyaCMBiaYcdVMar8K4gFqoTHpmz+aWxrs5+
 XAupwktKKhbkhA4ENt8INWUpHlI+RuHkT+kfaRfe5dn+sUxIPHFqNJKgAtyH7S5afrXO
 rWK5MWMTHLZgxhc64txJm6gemPpiaAUI8L6U7Fp1+wxLFYodqWlfXbiTS1eU31gn1QlC
 obBd2M8pnhst0f1Acc4ZqpRtJto2ih2OhcCst370gWyNJKSOf8kC6uJ0dECbZehSwkZC
 80RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735589754; x=1736194554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wybM68fpXbDHB//YAvjA46jZ2lQmgi3mdSGDy9MZ3ig=;
 b=S5IcXw2bidfT1uuh3KA/vhqoLhZ/0Ae0lvCHYhmvzwCM8UbrTjSkep3p100WUXSnHm
 8prSdkC0x3fIoV1bG7FmP9736yiKI2cYlXm1m0bFSqWMoqf6f4Vw7IFc1LeFjxR70boH
 VQ2bLB0+fDWebWSGGb+YlJ5VHFzsMKd3+XqyIgZvMD2Bn64ISMS+KNeNpqpcv7Cs6XtK
 NPWxt96c8qPNdjXBqsJ2+EfAP2nzrpQ9NmasgoeiI9ygvX13VTJFdZWAEzdPKgr59TQt
 /caCNZPLAnTJdhcRUUzxLAhDmDbjQlEtq4die6tTGJ3srB+iexd29s/xVIZxqSQ1lRde
 R7uQ==
X-Gm-Message-State: AOJu0YzUApZsQ1yl9DUP1oUEKSESTU0cF/uzHh8SMIpFhtsKrcJ8HPB8
 og4qbMbHVDPGpHU+DwrynKFMrAOQLaALxhZOrLijmk+FWBVrvYwq8ajtOXFJPxlCMTC7XZHgArA
 +5VnYXriancv+BxFcR4I49xT2vLsAR8hwqfg9
X-Gm-Gg: ASbGncsyxq/ha/4zEAljCMWdNh6G+Z4XuzoGXV2P2qAcVEpboYKKnURzBrLA7DthNBM
 xZKcb8lhzsbwagMdbh6/hHz+wzfNd13SZCBsMow==
X-Google-Smtp-Source: AGHT+IEqDFKa5UJnA43V0euCwkut0h/ebu3d81kq148j+GRBwQI9Cy1dpyzHqRNN5e293/+EnVH/4KpBwgUL2hk0pOo=
X-Received: by 2002:a05:6102:370d:b0:4b2:48dd:aade with SMTP id
 ada2fe7eead31-4b2cc38276emr32374440137.12.1735589754402; Mon, 30 Dec 2024
 12:15:54 -0800 (PST)
MIME-Version: 1.0
References: <20241223221645.29911-1-phil@philjordan.eu>
 <5aeaca68-50c0-41f4-8cd2-81a931377954@linaro.org>
In-Reply-To: <5aeaca68-50c0-41f4-8cd2-81a931377954@linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 30 Dec 2024 21:15:43 +0100
Message-ID: <CAAibmn12xCO3q8LKk4RiHYsPyJJJ5e-PyFE9=mdm0YGTt9fWDA@mail.gmail.com>
Subject: Re: [PATCH v16 00/14] macOS PV Graphics and new vmapple machine type
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Joelle van Dyne <j@getutm.app>, agraf@csgraf.de, 
 peter.maydell@linaro.org, pbonzini@redhat.com, rad@semihalf.com, 
 quic_llindhol@quicinc.com, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, shorne@gmail.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org, balaton@eik.bme.hu
Content-Type: multipart/alternative; boundary="000000000000c98efb062a827a6c"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e33;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe33.google.com
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

--000000000000c98efb062a827a6c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Dec 2024 at 19:55, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g>
wrote:

> Cc'ing Joelle (FYI https://github.com/utmapp/UTM/issues/3491)
>
> On 23/12/24 23:16, Phil Dennis-Jordan wrote:
> > This patch set introduces a new ARM and macOS HVF specific machine type
> > called "vmapple", as well as a family of display devices based on the
> > ParavirtualizedGraphics.framework in macOS. One of the display adapter
> > variants, apple-gfx-mmio, is required for the new machine type, while
> > apple-gfx-pci can be used to enable 3D graphics acceleration with x86-6=
4
> > macOS guest OSes.
> >
> > Previous versions of this patch set were submitted semi-separately:
> > the original vmapple patch set by Alexander Graf included a monolithic
> > implementation of apple-gfx-mmio. I subsequently reviewed and reworked
> > the latter to support the PCI variant of the device as well and submitt=
ed
> > the result in isolation. As requested in subsequent review, I have now
> > recombined this with the original vmapple patch set, which I have updat=
ed
> > and improved in a few ways as well.
> >
> > The vmapple machine type approximates the configuration in macOS's own
> > Virtualization.framework when running arm64 macOS guests. In addition t=
o
> > generic components such as a GICv3 and an XHCI USB controller, it
> > includes nonstandard extensions to the virtio block device, a special
> > "hardware" aes engine, a configuration device, a pvpanic variant, a
> > "backdoor" interface, and of course the apple-gfx paravirtualised displ=
ay
> > adapter.
> >
> > There are currently a few limitations to this which aren't intrinsic,
> > just imperfect emulation of the VZF, but it's good enough to be just
> > about usable for some purposes:
> >
> >   * macOS 12 guests only. Versions 13+ currently fail during early boot=
.
> >   * macOS 11+ arm64 hosts only, with hvf accel. (Perhaps some differenc=
es
> >     between Apple M series CPUs and TCG's aarch64 implementation? macOS
> >     hosts only because ParavirtualizedGraphics.framework is a black box
> >     implementing most of the logic behind the apple-gfx device.)
> >   * PCI devices use legacy IRQs, not MSI/MSI-X. As far as I can tell,
> >     we'd need to include the GICv3 ITS, but it's unclear to me what
> >     exactly needs wiring up.
> >   * Due to a quirk (bug?) in the macOS XHCI driver when MSI-X is not
> >     available, correct functioning of the USB controller (and thus
> >     keyboard/tablet) requires a small workaround in the XHCI controller
> >     device. This is part of another patch series:
> >     https://patchew.org/QEMU/20241208191646.64857-1-phil@philjordan.eu/
> >   * The guest OS must first be provisioned using
> Virtualization.framework;
> >     the disk images can subsequently be used in Qemu. (See docs.)
> >
> > The apple-gfx device can be used independently from the vmapple machine
> > type, at least in the PCI variant. It mainly targets x86-64 macOS guest=
s
> > from version 11 on, but also includes a UEFI bootrom for basic
> > framebuffer mode. macOS 11 is also required on the host side, as well
> > as a GPU that supports the Metal API. On the guest side, this provides
> > 3D acceleration/GPGPU support with a baseline Metal feature set,
> > irrespective of the host GPU's feature set. A few limitations in the
> > current integration:
> >
> >   * Although it works fine with TCG, it does not work correctly
> >     cross-architecture: x86-64 guests on arm64 hosts appear to make
> >     some boot progress, but rendering is corrupted. I suspect
> >     incompatible texture memory layouts; I have no idea if this is
> >     fixable.
>
> Zoltan, does that ring a bell?
>
> Phil, should we display a warning in this configuration case? Or only
> allow it with some developper option, like:
>
>      -device '{"driver":"apple-gfx-pci", \
>                "display-modes":["3840x2160@60"], \
>                "x-force-cross-rendering":"true"}'
>
>
This is a good idea. I think the override option is probably better, as
warnings are easily missed and the resulting behaviour seems to be
generally unusable. Do you want me to put this together? If so, what's the
most acceptable way to check the target and host architectures respectively
from (I guess?) the device instance init function?


> >   * ParavirtualizedGraphics.framework and the guest driver support
> >     multi-headed configurations. The current Qemu integration always
> >     connects precisely 1 display.
> >   * State serialisation and deserialisation is currently not
> >     implemented, though supported in principle by the framework.
> >     Both apple-gfx variants thus set up a migration blocker.
> >   * Rendering efficiency could be better. The GPU-rendered guest
> >     framebuffer is copied to system memory and uses Qemu's usual
> >     CPU-based drawing. For maximum efficiency, the Metal texture
> >     containing the guest framebuffer could be drawn directly to
> >     a Metal view in the host window, staying on the GPU. (Similar
> >     to the OpenGL/virgl render path on other platforms.)
> >
> > Some of my part of this work has been sponsored by Sauce Labs Inc.
> >
> > ---
>
>
> > Alexander Graf (8):
> >    hw: Add vmapple subdir
> >    hw/misc/pvpanic: Add MMIO interface
> >    gpex: Allow more than 4 legacy IRQs
> >    hw/vmapple/aes: Introduce aes engine
> >    hw/vmapple/bdif: Introduce vmapple backdoor interface
> >    hw/vmapple/cfg: Introduce vmapple cfg region
> >    hw/vmapple/virtio-blk: Add support for apple virtio-blk
> >    hw/vmapple/vmapple: Add vmapple machine type
> >
> > Phil Dennis-Jordan (6):
> >    ui & main loop: Redesign of system-specific main thread event handli=
ng
> >    hw/display/apple-gfx: Introduce ParavirtualizedGraphics.Framework
> >      support
> >    hw/display/apple-gfx: Adds PCI implementation
> >    hw/display/apple-gfx: Adds configurable mode list
> >    MAINTAINERS: Add myself as maintainer for apple-gfx, reviewer for HV=
F
> >    hw/block/virtio-blk: Replaces request free function with g_free
> >
> >   MAINTAINERS                         |  15 +
> >   contrib/vmapple/uuid.sh             |   9 +
> >   docs/system/arm/vmapple.rst         |  63 ++
> >   docs/system/target-arm.rst          |   1 +
> >   hw/Kconfig                          |   1 +
> >   hw/arm/sbsa-ref.c                   |   2 +-
> >   hw/arm/virt.c                       |   2 +-
> >   hw/block/virtio-blk.c               |  58 +-
> >   hw/core/qdev-properties-system.c    |   8 +
> >   hw/display/Kconfig                  |  13 +
> >   hw/display/apple-gfx-mmio.m         | 288 +++++++++
> >   hw/display/apple-gfx-pci.m          | 156 +++++
> >   hw/display/apple-gfx.h              |  77 +++
> >   hw/display/apple-gfx.m              | 880 +++++++++++++++++++++++++++=
+
> >   hw/display/meson.build              |   7 +
> >   hw/display/trace-events             |  30 +
> >   hw/i386/microvm.c                   |   2 +-
> >   hw/loongarch/virt.c                 |  12 +-
> >   hw/meson.build                      |   1 +
> >   hw/mips/loongson3_virt.c            |   2 +-
> >   hw/misc/Kconfig                     |   4 +
> >   hw/misc/meson.build                 |   1 +
> >   hw/misc/pvpanic-mmio.c              |  60 ++
> >   hw/openrisc/virt.c                  |  12 +-
> >   hw/pci-host/gpex.c                  |  43 +-
> >   hw/riscv/virt.c                     |  12 +-
> >   hw/vmapple/Kconfig                  |  32 +
> >   hw/vmapple/aes.c                    | 581 ++++++++++++++++++
> >   hw/vmapple/bdif.c                   | 274 +++++++++
> >   hw/vmapple/cfg.c                    | 195 ++++++
> >   hw/vmapple/meson.build              |   5 +
> >   hw/vmapple/trace-events             |  21 +
> >   hw/vmapple/trace.h                  |   1 +
> >   hw/vmapple/virtio-blk.c             | 204 +++++++
> >   hw/vmapple/vmapple.c                | 612 +++++++++++++++++++
> >   hw/xen/xen-pvh-common.c             |   2 +-
> >   hw/xtensa/virt.c                    |   2 +-
> >   include/hw/misc/pvpanic.h           |   1 +
> >   include/hw/pci-host/gpex.h          |   7 +-
> >   include/hw/pci/pci_ids.h            |   1 +
> >   include/hw/qdev-properties-system.h |   5 +
> >   include/hw/virtio/virtio-blk.h      |  11 +-
> >   include/hw/vmapple/vmapple.h        |  23 +
> >   include/qemu-main.h                 |  14 +-
> >   include/qemu/cutils.h               |  15 +
> >   meson.build                         |   5 +
> >   qapi/virtio.json                    |  14 +
> >   system/main.c                       |  37 +-
> >   ui/cocoa.m                          |  54 +-
> >   ui/gtk.c                            |   4 +
> >   ui/sdl2.c                           |   4 +
> >   util/hexdump.c                      |  18 +
> >   52 files changed, 3791 insertions(+), 110 deletions(-)
> >   create mode 100755 contrib/vmapple/uuid.sh
> >   create mode 100644 docs/system/arm/vmapple.rst
> >   create mode 100644 hw/display/apple-gfx-mmio.m
> >   create mode 100644 hw/display/apple-gfx-pci.m
> >   create mode 100644 hw/display/apple-gfx.h
> >   create mode 100644 hw/display/apple-gfx.m
> >   create mode 100644 hw/misc/pvpanic-mmio.c
> >   create mode 100644 hw/vmapple/Kconfig
> >   create mode 100644 hw/vmapple/aes.c
> >   create mode 100644 hw/vmapple/bdif.c
> >   create mode 100644 hw/vmapple/cfg.c
> >   create mode 100644 hw/vmapple/meson.build
> >   create mode 100644 hw/vmapple/trace-events
> >   create mode 100644 hw/vmapple/trace.h
> >   create mode 100644 hw/vmapple/virtio-blk.c
> >   create mode 100644 hw/vmapple/vmapple.c
> >   create mode 100644 include/hw/vmapple/vmapple.h
> >
>
>

--000000000000c98efb062a827a6c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 30 Dec =
2024 at 19:55, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Cc&#39;ing Joelle (FYI <a href=3D"https://github.=
com/utmapp/UTM/issues/3491" rel=3D"noreferrer" target=3D"_blank">https://gi=
thub.com/utmapp/UTM/issues/3491</a>)<br>
<br>
On 23/12/24 23:16, Phil Dennis-Jordan wrote:<br>
&gt; This patch set introduces a new ARM and macOS HVF specific machine typ=
e<br>
&gt; called &quot;vmapple&quot;, as well as a family of display devices bas=
ed on the<br>
&gt; ParavirtualizedGraphics.framework in macOS. One of the display adapter=
<br>
&gt; variants, apple-gfx-mmio, is required for the new machine type, while<=
br>
&gt; apple-gfx-pci can be used to enable 3D graphics acceleration with x86-=
64<br>
&gt; macOS guest OSes.<br>
&gt; <br>
&gt; Previous versions of this patch set were submitted semi-separately:<br=
>
&gt; the original vmapple patch set by Alexander Graf included a monolithic=
<br>
&gt; implementation of apple-gfx-mmio. I subsequently reviewed and reworked=
<br>
&gt; the latter to support the PCI variant of the device as well and submit=
ted<br>
&gt; the result in isolation. As requested in subsequent review, I have now=
<br>
&gt; recombined this with the original vmapple patch set, which I have upda=
ted<br>
&gt; and improved in a few ways as well.<br>
&gt; <br>
&gt; The vmapple machine type approximates the configuration in macOS&#39;s=
 own<br>
&gt; Virtualization.framework when running arm64 macOS guests. In addition =
to<br>
&gt; generic components such as a GICv3 and an XHCI USB controller, it<br>
&gt; includes nonstandard extensions to the virtio block device, a special<=
br>
&gt; &quot;hardware&quot; aes engine, a configuration device, a pvpanic var=
iant, a<br>
&gt; &quot;backdoor&quot; interface, and of course the apple-gfx paravirtua=
lised display<br>
&gt; adapter.<br>
&gt; <br>
&gt; There are currently a few limitations to this which aren&#39;t intrins=
ic,<br>
&gt; just imperfect emulation of the VZF, but it&#39;s good enough to be ju=
st<br>
&gt; about usable for some purposes:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* macOS 12 guests only. Versions 13+ currently fail during=
 early boot.<br>
&gt;=C2=A0 =C2=A0* macOS 11+ arm64 hosts only, with hvf accel. (Perhaps som=
e differences<br>
&gt;=C2=A0 =C2=A0 =C2=A0between Apple M series CPUs and TCG&#39;s aarch64 i=
mplementation? macOS<br>
&gt;=C2=A0 =C2=A0 =C2=A0hosts only because ParavirtualizedGraphics.framewor=
k is a black box<br>
&gt;=C2=A0 =C2=A0 =C2=A0implementing most of the logic behind the apple-gfx=
 device.)<br>
&gt;=C2=A0 =C2=A0* PCI devices use legacy IRQs, not MSI/MSI-X. As far as I =
can tell,<br>
&gt;=C2=A0 =C2=A0 =C2=A0we&#39;d need to include the GICv3 ITS, but it&#39;=
s unclear to me what<br>
&gt;=C2=A0 =C2=A0 =C2=A0exactly needs wiring up.<br>
&gt;=C2=A0 =C2=A0* Due to a quirk (bug?) in the macOS XHCI driver when MSI-=
X is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0available, correct functioning of the USB controlle=
r (and thus<br>
&gt;=C2=A0 =C2=A0 =C2=A0keyboard/tablet) requires a small workaround in the=
 XHCI controller<br>
&gt;=C2=A0 =C2=A0 =C2=A0device. This is part of another patch series:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://patchew.org/QEMU/20241208191646.=
64857-1-phil@philjordan.eu/" rel=3D"noreferrer" target=3D"_blank">https://p=
atchew.org/QEMU/20241208191646.64857-1-phil@philjordan.eu/</a><br>
&gt;=C2=A0 =C2=A0* The guest OS must first be provisioned using Virtualizat=
ion.framework;<br>
&gt;=C2=A0 =C2=A0 =C2=A0the disk images can subsequently be used in Qemu. (=
See docs.)<br>
&gt; <br>
&gt; The apple-gfx device can be used independently from the vmapple machin=
e<br>
&gt; type, at least in the PCI variant. It mainly targets x86-64 macOS gues=
ts<br>
&gt; from version 11 on, but also includes a UEFI bootrom for basic<br>
&gt; framebuffer mode. macOS 11 is also required on the host side, as well<=
br>
&gt; as a GPU that supports the Metal API. On the guest side, this provides=
<br>
&gt; 3D acceleration/GPGPU support with a baseline Metal feature set,<br>
&gt; irrespective of the host GPU&#39;s feature set. A few limitations in t=
he<br>
&gt; current integration:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Although it works fine with TCG, it does not work correc=
tly<br>
&gt;=C2=A0 =C2=A0 =C2=A0cross-architecture: x86-64 guests on arm64 hosts ap=
pear to make<br>
&gt;=C2=A0 =C2=A0 =C2=A0some boot progress, but rendering is corrupted. I s=
uspect<br>
&gt;=C2=A0 =C2=A0 =C2=A0incompatible texture memory layouts; I have no idea=
 if this is<br>
&gt;=C2=A0 =C2=A0 =C2=A0fixable.<br>
<br>
Zoltan, does that ring a bell?<br>
<br>
Phil, should we display a warning in this configuration case? Or only<br>
allow it with some developper option, like:<br>
<br>
=C2=A0 =C2=A0 =C2=A0-device &#39;{&quot;driver&quot;:&quot;apple-gfx-pci&qu=
ot;, \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;display-modes&=
quot;:[&quot;3840x2160@60&quot;], \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;x-force-cross-=
rendering&quot;:&quot;true&quot;}&#39;<br>
<br></blockquote><div><br></div><div>This is a good idea. I think the overr=
ide option is probably better, as warnings are easily missed and the result=
ing behaviour seems to be generally unusable. Do you want me to put this to=
gether? If so, what&#39;s the most acceptable way to check the target and h=
ost architectures respectively from (I guess?) the device instance init fun=
ction?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
&gt;=C2=A0 =C2=A0* ParavirtualizedGraphics.framework and the guest driver s=
upport<br>
&gt;=C2=A0 =C2=A0 =C2=A0multi-headed configurations. The current Qemu integ=
ration always<br>
&gt;=C2=A0 =C2=A0 =C2=A0connects precisely 1 display.<br>
&gt;=C2=A0 =C2=A0* State serialisation and deserialisation is currently not=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0implemented, though supported in principle by the f=
ramework.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Both apple-gfx variants thus set up a migration blo=
cker.<br>
&gt;=C2=A0 =C2=A0* Rendering efficiency could be better. The GPU-rendered g=
uest<br>
&gt;=C2=A0 =C2=A0 =C2=A0framebuffer is copied to system memory and uses Qem=
u&#39;s usual<br>
&gt;=C2=A0 =C2=A0 =C2=A0CPU-based drawing. For maximum efficiency, the Meta=
l texture<br>
&gt;=C2=A0 =C2=A0 =C2=A0containing the guest framebuffer could be drawn dir=
ectly to<br>
&gt;=C2=A0 =C2=A0 =C2=A0a Metal view in the host window, staying on the GPU=
. (Similar<br>
&gt;=C2=A0 =C2=A0 =C2=A0to the OpenGL/virgl render path on other platforms.=
)<br>
&gt; <br>
&gt; Some of my part of this work has been sponsored by Sauce Labs Inc.<br>
&gt; <br>
&gt; ---<br>
<br>
<br>
&gt; Alexander Graf (8):<br>
&gt;=C2=A0 =C2=A0 hw: Add vmapple subdir<br>
&gt;=C2=A0 =C2=A0 hw/misc/pvpanic: Add MMIO interface<br>
&gt;=C2=A0 =C2=A0 gpex: Allow more than 4 legacy IRQs<br>
&gt;=C2=A0 =C2=A0 hw/vmapple/aes: Introduce aes engine<br>
&gt;=C2=A0 =C2=A0 hw/vmapple/bdif: Introduce vmapple backdoor interface<br>
&gt;=C2=A0 =C2=A0 hw/vmapple/cfg: Introduce vmapple cfg region<br>
&gt;=C2=A0 =C2=A0 hw/vmapple/virtio-blk: Add support for apple virtio-blk<b=
r>
&gt;=C2=A0 =C2=A0 hw/vmapple/vmapple: Add vmapple machine type<br>
&gt; <br>
&gt; Phil Dennis-Jordan (6):<br>
&gt;=C2=A0 =C2=A0 ui &amp; main loop: Redesign of system-specific main thre=
ad event handling<br>
&gt;=C2=A0 =C2=A0 hw/display/apple-gfx: Introduce ParavirtualizedGraphics.F=
ramework<br>
&gt;=C2=A0 =C2=A0 =C2=A0 support<br>
&gt;=C2=A0 =C2=A0 hw/display/apple-gfx: Adds PCI implementation<br>
&gt;=C2=A0 =C2=A0 hw/display/apple-gfx: Adds configurable mode list<br>
&gt;=C2=A0 =C2=A0 MAINTAINERS: Add myself as maintainer for apple-gfx, revi=
ewer for HVF<br>
&gt;=C2=A0 =C2=A0 hw/block/virtio-blk: Replaces request free function with =
g_free<br>
&gt; <br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 15 +<br>
&gt;=C2=A0 =C2=A0contrib/vmapple/uuid.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A09 +<br>
&gt;=C2=A0 =C2=A0docs/system/arm/vmapple.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 63 ++<br>
&gt;=C2=A0 =C2=A0docs/system/target-arm.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/arm/sbsa-ref.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 =C2=A0hw/arm/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 =C2=A0hw/block/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 58 +-<br>
&gt;=C2=A0 =C2=A0hw/core/qdev-properties-system.c=C2=A0 =C2=A0 |=C2=A0 =C2=
=A08 +<br>
&gt;=C2=A0 =C2=A0hw/display/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 13 +<br>
&gt;=C2=A0 =C2=A0hw/display/apple-gfx-mmio.m=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 288 +++++++++<br>
&gt;=C2=A0 =C2=A0hw/display/apple-gfx-pci.m=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 156 +++++<br>
&gt;=C2=A0 =C2=A0hw/display/apple-gfx.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 77 +++<br>
&gt;=C2=A0 =C2=A0hw/display/apple-gfx.m=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 880 ++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/display/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0hw/display/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 30 +<br>
&gt;=C2=A0 =C2=A0hw/i386/microvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 =C2=A0hw/loongarch/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 12 +-<br>
&gt;=C2=A0 =C2=A0hw/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/mips/loongson3_virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 =C2=A0hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0hw/misc/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/misc/pvpanic-mmio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 60 ++<br>
&gt;=C2=A0 =C2=A0hw/openrisc/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 12 +-<br>
&gt;=C2=A0 =C2=A0hw/pci-host/gpex.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 43 +-<br>
&gt;=C2=A0 =C2=A0hw/riscv/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 12 +-<br>
&gt;=C2=A0 =C2=A0hw/vmapple/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 32 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/aes.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 581 ++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/vmapple/bdif.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 274 +++++++++<br>
&gt;=C2=A0 =C2=A0hw/vmapple/cfg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 195 ++++++<br>
&gt;=C2=A0 =C2=A0hw/vmapple/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 21 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/trace.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 204 +++++++<br>
&gt;=C2=A0 =C2=A0hw/vmapple/vmapple.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 612 +++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/xen/xen-pvh-common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 =C2=A0hw/xtensa/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 =C2=A0include/hw/misc/pvpanic.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0include/hw/pci-host/gpex.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A07 +-<br>
&gt;=C2=A0 =C2=A0include/hw/pci/pci_ids.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0include/hw/qdev-properties-system.h |=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0include/hw/virtio/virtio-blk.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 11 +-<br>
&gt;=C2=A0 =C2=A0include/hw/vmapple/vmapple.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 23 +<br>
&gt;=C2=A0 =C2=A0include/qemu-main.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 +-<br>
&gt;=C2=A0 =C2=A0include/qemu/cutils.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 15 +<br>
&gt;=C2=A0 =C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0qapi/virtio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +<br>
&gt;=C2=A0 =C2=A0system/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 37 +-<br>
&gt;=C2=A0 =C2=A0ui/cocoa.m=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 54 +-<br>
&gt;=C2=A0 =C2=A0ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0ui/sdl2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0util/hexdump.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 +<br>
&gt;=C2=A0 =C2=A052 files changed, 3791 insertions(+), 110 deletions(-)<br>
&gt;=C2=A0 =C2=A0create mode 100755 contrib/vmapple/uuid.sh<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/system/arm/vmapple.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/apple-gfx-mmio.m<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/apple-gfx-pci.m<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/apple-gfx.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/apple-gfx.m<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/misc/pvpanic-mmio.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/Kconfig<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/aes.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/bdif.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/cfg.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/meson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/trace-events<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/trace.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/virtio-blk.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/vmapple.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/vmapple/vmapple.h<br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000c98efb062a827a6c--

