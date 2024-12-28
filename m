Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882CEE77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 10:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRTc9-0002a2-Mj; Sat, 28 Dec 2024 05:00:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tRTbx-0002VK-GB
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 04:59:57 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tRTbv-0002sg-Md
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 04:59:57 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-85b8c94a6b4so1677684241.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 01:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735379994; x=1735984794;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LlncXcVIEccT+1A1oiS85lylcaqeiQZ3UpIE8UOa3ec=;
 b=a6VBG4FHgzwwkNF5AWwobH/Xe+5ZoelOYxk/Wu0hSBl/2T2acz2oseIsPX6EqJTy/O
 TbXrU1fa4HBfQWHLOG8uQkgME7XCVjSsIbz5n9opev5sXH9+9WlyQnCNLtmNKfe/pc8m
 hYgZMOanRebakiFitO9hGyB7Mw2do2J9IrswWb3LPH0V73R12gRuzPLQjjS3vbf7V2Vb
 nOJx9CLA4sWrmN8njauAbKc5klWIUJkA6neHt3GevRhZ2WT7czvlx6UM1me6phuwaQAK
 L3T2o2CCZuBCGcETkeeXdrHoP2H19dZ3JO2G6CH09TpKgR2OcJFTv7u/sVB0skhXGqQr
 ohWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735379994; x=1735984794;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LlncXcVIEccT+1A1oiS85lylcaqeiQZ3UpIE8UOa3ec=;
 b=v4dJS7Mb8w6/glOkFwLkd0zUbGVEhRYkbfq4yJtpCIn5UO+bf1dB0+O+8VtnisKn0b
 VqwBO5mIEgqLt1kbrMsSnFSGV10hclLVk48GnNznkSjg8jEfybAm9+p2V57okeNlSKyx
 F/ThPTm3NG6bu7FBiLuWqCXKrVCQwc+9/QScZMO9aBVnI8XUwHrMZkn6+cvrVnWQiM9+
 yNIhbvZ9RKbfRQLDolPkWwdc9UtPVxhY3X5sQSAiEhtFvTnWjrbkErasNR/SJqh22GkG
 Y2m7Yfj7BYyHOI3ueAH+0lq6OhxOSll3hEG+BKHoRSvAvZ5dq0hJZtKFpHKWd06JaVKe
 bZqQ==
X-Gm-Message-State: AOJu0Yx5+TadECmkVeCSG6Nx0x1em/keTQ1ox+5Qic0ZDXCa7sdyIi61
 rCbMdpk41yL+dYAdacmRgn8VWEfgDLFSGtVL6gnhXO6IgCEcvAeDVZmf+/FsBhP5Mv93recamVD
 cR8oGe+sLyKtc5JopRxt/xA+MQjCdkhwPQoC4
X-Gm-Gg: ASbGncu0ia+mLnNv9SU3Mw/+BR+kMHe5VRnnpfS9346l82JFHCmuUK/a4CIjSu9piGb
 OgviA4EaK5RysuyDP2HTJjpAQn0kiMxtIc09xvg==
X-Google-Smtp-Source: AGHT+IFw5KSroPtXZyYs4idcBcuJSoNAa1ocx03E9/YgZQorCh5/Y/+6odkZ/wI+TySnDDGJBuaCSo/tKuCGp1/x5FY=
X-Received: by 2002:a05:6102:2c08:b0:4b2:543f:b454 with SMTP id
 ada2fe7eead31-4b2cc4654d9mr23392863137.21.1735379994482; Sat, 28 Dec 2024
 01:59:54 -0800 (PST)
MIME-Version: 1.0
References: <20241223221645.29911-1-phil@philjordan.eu>
 <20241223221645.29911-15-phil@philjordan.eu>
 <1211286e-9211-4d89-9021-f353169af6ad@linaro.org>
 <CAAibmn0q6cBc41J5mABd4bkUEo6pS0MhL8DU8fPfygDvjLSPBQ@mail.gmail.com>
 <49188838-5e52-4d9e-9c50-933e62678163@linaro.org>
In-Reply-To: <49188838-5e52-4d9e-9c50-933e62678163@linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sat, 28 Dec 2024 10:59:43 +0100
Message-ID: <CAAibmn0puNwDvHcU8xYi1EJ=dnAEhasoTKCk0kmF4DiQfR7dHQ@mail.gmail.com>
Subject: Re: [PATCH v16 14/14] hw/vmapple/vmapple: Add vmapple machine type
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, shorne@gmail.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, 
 marcandre.lureau@redhat.com, berrange@redhat.com, akihiko.odaki@daynix.com, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="0000000000001f2e31062a51a4ce"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::930;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x930.google.com
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

--0000000000001f2e31062a51a4ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Dec 2024 at 21:41, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g>
wrote:

> On 27/12/24 21:12, Phil Dennis-Jordan wrote:
>
> >      > diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> >      > index bcd1be63e3..6a4c4a7fa2 100644
> >      > --- a/hw/vmapple/Kconfig
> >      > +++ b/hw/vmapple/Kconfig
> >      > @@ -10,3 +10,23 @@ config VMAPPLE_CFG
> >      >   config VMAPPLE_VIRTIO_BLK
> >      >       bool
> >      >
> >      > +config VMAPPLE
> >      > +    bool
> >      > +    depends on ARM
> >      > +    depends on HVF
> >      > +    default y if ARM
> >      > +    imply PCI_DEVICES
> >      > +    select ARM_GIC
> >
> >     Hmmm I'm getting ...:
> >
> >     qemu-system-aarch64: unknown type 'arm-gicv3'
> >
> >      > +    select PLATFORM_BUS
> >      > +    select PCI_EXPRESS
> >      > +    select PCI_EXPRESS_GENERIC_BRIDGE
> >      > +    select PL011 # UART
> >      > +    select PL031 # RTC
> >      > +    select PL061 # GPIO
> >      > +    select GPIO_PWR
> >      > +    select PVPANIC_MMIO
> >      > +    select VMAPPLE_AES
> >      > +    select VMAPPLE_BDIF
> >      > +    select VMAPPLE_CFG
> >      > +    select MAC_PVG_MMIO
> >      > +    select VMAPPLE_VIRTIO_BLK
> >
> >
> >      > +static void create_gic(VMAppleMachineState *vms, MemoryRegion
> *mem)
> >      > +{
> >      > +    MachineState *ms =3D MACHINE(vms);
> >      > +    /* We create a standalone GIC */
> >      > +    SysBusDevice *gicbusdev;
> >      > +    QList *redist_region_count;
> >      > +    int i;
> >      > +    unsigned int smp_cpus =3D ms->smp.cpus;
> >      > +
> >      > +    vms->gic =3D qdev_new(gicv3_class_name());
> >
> >     ... I suppose due to this call ^^^.
> >
> >     $ git grep arm-gicv3
> >     hw/intc/arm_gicv3_kvm.c:45:#define TYPE_KVM_ARM_GICV3 "kvm-arm-gicv=
3"
> >     include/hw/intc/arm_gicv3.h:18:#define TYPE_ARM_GICV3 "arm-gicv3"
> >     $ git grep TYPE_ARM_GICV3
> >     hw/intc/arm_gicv3.c:466:    .name =3D TYPE_ARM_GICV3,
> >     $ git grep -FW arm_gicv3.c
> >     hw/intc/meson.build=3D9=3Dsystem_ss.add(when: 'CONFIG_ARM_GICV3_TCG=
',
> >     if_true: files(
> >     hw/intc/meson.build:10:  'arm_gicv3.c',
> >     ...
> >
> >
> > Ahhh, good catch! I suppose this is with =E2=80=94disable-tcg (or equiv=
alent)
>
> Yes, this is how I test HVF.
>
> >
> >
> >     I think commit a8a5546798c ("hw/intc/arm_gicv3: Introduce
> >     CONFIG_ARM_GIC_TCG Kconfig selector") is invalid as being
> >     too restrictive.
> >
> >     I can go a bit further with these changes on top (ignoring
> >     renaming ARM_GICV3_TCG -> ARM_GICV3):
> >
> >
> >     -- >8 --
> >     diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> >     index dd405bdb5d2..9e06c05b449 100644
> >     --- a/hw/intc/Kconfig
> >     +++ b/hw/intc/Kconfig
> >     @@ -26 +26 @@ config ARM_GIC
> >     -    select ARM_GICV3_TCG if TCG
> >     +    select ARM_GICV3_TCG if TCG || HVF
> >     @@ -32 +32 @@ config ARM_GICV3_TCG
> >     -    depends on ARM_GIC && TCG
> >     +    depends on ARM_GIC && (TCG || HVF)
>
> Now implemented as [*]:
>
> https://lore.kernel.org/qemu-devel/20241227202435.48055-1-philmd@linaro.o=
rg/
>
> >     diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> >     index 6a4c4a7fa2e..374a89f6a8f 100644
> >     --- a/hw/vmapple/Kconfig
> >     +++ b/hw/vmapple/Kconfig
> >     @@ -19 +19 @@ config VMAPPLE
> >     -    select ARM_GIC
> >     +    select ARM_GICV3_TCG
> >
> >
> > Is this last part necessary/advisable? It would seem like the above
> > changes in hw/intc/Kconfig should make ARM_GIC work too?
> > (The PVG dependency means we currently can=E2=80=99t support anything o=
ther than
> > macOS host systems and thus HVF or theoretically TCG anyway, but if QEM=
U
> > gained support for the HVF-provided GIC implementation, we=E2=80=99d ne=
ed to
> > change this line again.)
>
> Hmm indeed we can skip it, but vmapple machine enforces rev=3D3:
>
> >      > +    qdev_prop_set_uint32(vms->gic, "revision", 3);
>
> So directly selecting ARM_GICV3 sounds more explicit to me.
>

That's true.

We can sort out the HVF GICV3 if and when that ever gets implemented.


> The diff is now (on top of [*]):
>
>       -    select ARM_GIC
>       +    select ARM_GICV3
>
> WDYT?
>

Sounds good.

--0000000000001f2e31062a51a4ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 27 Dec =
2024 at 21:41, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 27/12/24 21:12, Phil Dennis-Jordan wrote:<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/vmapple/Kconfig b/hw/vmapple/=
Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index bcd1be63e3..6a4c4a7fa2 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/vmapple/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/vmapple/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -10,3 +10,23 @@ config VMAPPLE_CFG<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0config VMAPPLE_VIRTIO_BLK<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +config VMAPPLE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 depends on ARM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 depends on HVF<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 default y if ARM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 imply PCI_DEVICES<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select ARM_GIC<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hmmm I&#39;m getting ...:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu-system-aarch64: unknown type &#39;arm-gicv3&#3=
9;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select PLATFORM_BUS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select PCI_EXPRESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select PCI_EXPRESS_GENERIC_BRI=
DGE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select PL011 # UART<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select PL031 # RTC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select PL061 # GPIO<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select GPIO_PWR<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select PVPANIC_MMIO<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select VMAPPLE_AES<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select VMAPPLE_BDIF<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select VMAPPLE_CFG<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select MAC_PVG_MMIO<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 select VMAPPLE_VIRTIO_BLK<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void create_gic(VMAppleMachineState *=
vms, MemoryRegion *mem)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(v=
ms);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* We create a standalone GIC =
*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 SysBusDevice *gicbusdev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 QList *redist_region_count;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 unsigned int smp_cpus =3D ms-&=
gt;smp.cpus;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vms-&gt;gic =3D qdev_new(gicv3=
_class_name());<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0... I suppose due to this call ^^^.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0$ git grep arm-gicv3<br>
&gt;=C2=A0 =C2=A0 =C2=A0hw/intc/arm_gicv3_kvm.c:45:#define TYPE_KVM_ARM_GIC=
V3 &quot;kvm-arm-gicv3&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0include/hw/intc/arm_gicv3.h:18:#define TYPE_ARM_GIC=
V3 &quot;arm-gicv3&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0$ git grep TYPE_ARM_GICV3<br>
&gt;=C2=A0 =C2=A0 =C2=A0hw/intc/arm_gicv3.c:466:=C2=A0 =C2=A0 .name =3D TYP=
E_ARM_GICV3,<br>
&gt;=C2=A0 =C2=A0 =C2=A0$ git grep -FW arm_gicv3.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0hw/intc/meson.build=3D9=3Dsystem_ss.add(when: &#39;=
CONFIG_ARM_GICV3_TCG&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0if_true: files(<br>
&gt;=C2=A0 =C2=A0 =C2=A0hw/intc/meson.build:10:=C2=A0 &#39;arm_gicv3.c&#39;=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt; <br>
&gt; <br>
&gt; Ahhh, good catch! I suppose this is with =E2=80=94disable-tcg (or equi=
valent)<br>
<br>
Yes, this is how I test HVF.<br>
<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I think commit a8a5546798c (&quot;hw/intc/arm_gicv3=
: Introduce<br>
&gt;=C2=A0 =C2=A0 =C2=A0CONFIG_ARM_GIC_TCG Kconfig selector&quot;) is inval=
id as being<br>
&gt;=C2=A0 =C2=A0 =C2=A0too restrictive.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I can go a bit further with these changes on top (i=
gnoring<br>
&gt;=C2=A0 =C2=A0 =C2=A0renaming ARM_GICV3_TCG -&gt; ARM_GICV3):<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-- &gt;8 --<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0index dd405bdb5d2..9e06c05b449 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/hw/intc/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/hw/intc/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -26 +26 @@ config ARM_GIC<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 select ARM_GICV3_TCG if TCG<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 select ARM_GICV3_TCG if TCG || HVF<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -32 +32 @@ config ARM_GICV3_TCG<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 depends on ARM_GIC &amp;&amp; TCG<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 depends on ARM_GIC &amp;&amp; (TCG |=
| HVF)<br>
<br>
Now implemented as [*]:<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20241227202435.48055-1-philmd=
@linaro.org/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/=
qemu-devel/20241227202435.48055-1-philmd@linaro.org/</a><br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfi=
g<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 6a4c4a7fa2e..374a89f6a8f 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/hw/vmapple/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/hw/vmapple/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -19 +19 @@ config VMAPPLE<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 select ARM_GIC<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 select ARM_GICV3_TCG<br>
&gt; <br>
&gt; <br>
&gt; Is this last part necessary/advisable? It would seem like the above <b=
r>
&gt; changes in hw/intc/Kconfig should make ARM_GIC work too?<br>
&gt; (The PVG dependency means we currently can=E2=80=99t support anything =
other than <br>
&gt; macOS host systems and thus HVF or theoretically TCG anyway, but if QE=
MU <br>
&gt; gained support for the HVF-provided GIC implementation, we=E2=80=99d n=
eed to <br>
&gt; change this line again.)<br>
<br>
Hmm indeed we can skip it, but vmapple machine enforces rev=3D3:<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 qdev_prop_set_uint32(vms-&gt;g=
ic, &quot;revision&quot;, 3);<br>
<br>
So directly selecting ARM_GICV3 sounds more explicit to me.<br></blockquote=
><div><br></div><div>That&#39;s true.</div><div><br></div><div>We can sort =
out the HVF GICV3 if and when that ever gets implemented.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
The diff is now (on top of [*]):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 -=C2=A0 =C2=A0 select ARM_GIC<br>
=C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 select ARM_GICV3<br>
<br>
WDYT?<br></blockquote><div><br></div><div>Sounds good. <br></div></div></di=
v>

--0000000000001f2e31062a51a4ce--

