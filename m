Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBF7CD5BD0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 07:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTDiH-0002i3-7A; Sat, 30 May 2026 03:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1wTDiF-0002hD-PA
 for qemu-devel@nongnu.org; Sat, 30 May 2026 03:02:27 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1wTDiE-0006fB-2L
 for qemu-devel@nongnu.org; Sat, 30 May 2026 03:02:27 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4E910443C1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 07:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250361F0089B
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 07:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780124536;
 bh=WYUUekz3ah0PjeSfGY4gTaBWBaVYFU3X5F54Wity180=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=XnuUOL+PtxOyjBxzjFZo8tUbMnhIqRWIwiMJaQzTTkpYU6EHhtIUQxMduxVCK38pQ
 fioYkw+IHytIP4d3XA1G3uQehqkxTnM0JhikV9EfTr76fOsgDEX9m6H3qxFCO+7plT
 kfJAS0ubTsEr/Cm+5JyvMsolG0Ep9q1Gx1PvwqkQLuKttBzBBOim8whblYWWq5VgzQ
 JubGH/F0gYI/3L7k18NuOCFVFlZh6wK8cJwFmv5fKDR8RA8M4WcxjyZtjZXgQIYsqm
 15AMEDoRIl3xFvYP8h2RImKtU9q3G9h00SvkM+14Sxcy4pBD7Pp3XRw/i0T8JBYrjX
 Z5oUQedAK6QnQ==
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-beabc001b0bso70964266b.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 00:02:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+GOSU3MVe/ImovW/2mwZL0FMyvuRLWX86BSswnBdD5dJPwfEXdo7CrwBpqqMoeIoT/smX00f4Nt0jl@nongnu.org
X-Gm-Message-State: AOJu0Yy5xxYae9cS64hk60vg0lWUeZKIeekXvfqVs6v6grZYApJfnFUU
 /rSyTsVbISXVFtkfO+rHcWdHSlKmnlCkPBnGBul+idIAIxi/Rc7weMThcRnBome2Np3uZNNqTUi
 MzZPu2/9BVPyJvXbWcW89TxQxPknb1Zg=
X-Received: by 2002:a17:907:980b:b0:bd1:77c4:acc9 with SMTP id
 a640c23a62f3a-be9a78d0eefmr315522266b.16.1780124534748; Sat, 30 May 2026
 00:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260529140559.1775511-1-chenhuacai@loongson.cn>
 <CAFEAcA_Li+07XNfE+GpvZOzwJReqbG=x8nz=kMrQy5vqkReEUQ@mail.gmail.com>
 <CAFEAcA9-RixpW9Br1_3vhSsBY8KTwpcCMPar39pNX+c_vAPgrw@mail.gmail.com>
In-Reply-To: <CAFEAcA9-RixpW9Br1_3vhSsBY8KTwpcCMPar39pNX+c_vAPgrw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 30 May 2026 15:02:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5G-JAkjoTJCK8iHDWxFpFhfNgvr=R9WmoKP2QRoS6GSA@mail.gmail.com>
X-Gm-Features: AVHnY4L57gN6gVx36Qj5wur7_kvw8ntqm4_at-GQJkbHHXQrEMNeLTY_Eojjj6M
Message-ID: <CAAhV-H5G-JAkjoTJCK8iHDWxFpFhfNgvr=R9WmoKP2QRoS6GSA@mail.gmail.com>
Subject: Re: [PATCH] fw_cfg: Add support for LoongArch architecture
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Gabriel Somlo <somlo@cmu.edu>, 
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 loongarch@lists.linux.dev, 
 Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=chenhuacai@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, Peter,

On Sat, May 30, 2026 at 1:53=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 29 May 2026 at 16:52, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > On Fri, 29 May 2026 at 15:42, Huacai Chen <chenhuacai@loongson.cn> wrot=
e:
> > >
> > > Qemu fw_cfg support was missing for LoongArch, which made some functi=
ons
> > > unusable in virtual machines. So add the missing LoongArch defines.
> > >
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  drivers/firmware/Kconfig       | 2 +-
> > >  drivers/firmware/qemu_fw_cfg.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> > > index bbd2155d8483..9ec747716389 100644
> > > --- a/drivers/firmware/Kconfig
> > > +++ b/drivers/firmware/Kconfig
> > > @@ -121,7 +121,7 @@ config RASPBERRYPI_FIRMWARE
> > >
> > >  config FW_CFG_SYSFS
> > >         tristate "QEMU fw_cfg device support in sysfs"
> > > -       depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || RI=
SCV || SPARC || X86)
> > > +       depends on SYSFS && (ARM || ARM64 || LOONGARCH || PARISC || P=
PC_PMAC || RISCV || SPARC || X86)
> > >         depends on HAS_IOPORT_MAP
> > >         default n
> > >         help
> > > diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_f=
w_cfg.c
> > > index 87a5421bc7d5..0c51a9df589f 100644
> > > --- a/drivers/firmware/qemu_fw_cfg.c
> > > +++ b/drivers/firmware/qemu_fw_cfg.c
> > > @@ -211,7 +211,7 @@ static void fw_cfg_io_cleanup(void)
> > >
> > >  /* arch-specific ctrl & data register offsets are not available in A=
CPI, DT */
> > >  #if !(defined(FW_CFG_CTRL_OFF) && defined(FW_CFG_DATA_OFF))
> > > -# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG=
_RISCV))
> > > +# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG=
_LOONGARCH) || defined(CONFIG_RISCV))
> > >  #  define FW_CFG_CTRL_OFF 0x08
> > >  #  define FW_CFG_DATA_OFF 0x00
> > >  #  define FW_CFG_DMA_OFF 0x10
> >
> > On the QEMU specification side we could probably nail this down
> > to "x86, sun, ppc, parisc have funny register layouts for
> > legacy reasons and all others have the 8-bytes-apart layout",
> > which might help to avoid having all this architecture-specific
> > ifdeffery changing for each new architecture, if that's
> > something people care about.
>
> I sent this QEMU patchset proposing that (and cleaning
> up some of the implementation to make it less likely that
> we add fw_cfg to any new board types with different layouts
> from the arm/riscv/loongarch "standard" one):
>
> https://lore.kernel.org/qemu-devel/20260529174639.451353-1-peter.maydell@=
linaro.org/
Thank you for your effort.

Huacai

>
> -- PMM

