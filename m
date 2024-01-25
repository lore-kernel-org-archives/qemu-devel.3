Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1E5C46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 00:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSnlR-0000JZ-FB; Wed, 24 Jan 2024 19:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rSnlP-0000JA-EF
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 19:38:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rSnlN-0005df-4H
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 19:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706143113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIj6P1tNbRwe5dKGPMdzdesdNNE+q5xWFbnT86L0tLk=;
 b=DiLlVD/q5o+N++lmM+ihMP3gomaDN10w/lPTXg3T8CmhsN7ze3Md3n3+6NAel0JBAziwo1
 3i4gRJU1SW49V/FxCMsbBfCLoP0lO2T5vf8pOuBrvqq1EQOD6ORI6ZCS1vPbg2Zoa+8td0
 xxkQzrot5aWjhjK1polnfR1hWpGbMoA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-y8Gjbh2UPnSnx-iPJPSzGA-1; Wed, 24 Jan 2024 19:38:32 -0500
X-MC-Unique: y8Gjbh2UPnSnx-iPJPSzGA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6dd7c6edc39so2545836b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 16:38:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706143111; x=1706747911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIj6P1tNbRwe5dKGPMdzdesdNNE+q5xWFbnT86L0tLk=;
 b=qqzzZ8Zx9rwuvZ/FJfTsxt5oyRE1ozllzy10Llwt6fRe4qlM7/9PEg+CAEg/HXI8Go
 hTXOHP2O8+vcYnnlitlnUuymvKou0w7ktKzsWB6RYpjwZUEedNoVWL2cgXP8Ushf1yhZ
 7FJgvde3XdqTYJldwSQbubPlE65GenbupeVV9DlpAZ0gs7C4rSw4fQUmu/hbBwUZ9TxF
 lxBepHXXaxTYgJv1BfHwR3hemM8enYwTagzCt0cML0o211379shR/LrL0f7YfUaq4+u2
 8KygqYaNbin872+vx1jeXgH4XY+fVKi+VD+y1iPZmlalN1tGgbMcRLqmQLGL1wnWIVbS
 F9iw==
X-Gm-Message-State: AOJu0Yw+FEcTWOBOM7oo7aIGcb8yBpRvb1eVbkYkUdoa0Bh0c5yAaJCs
 SgiJBpNfzEGGLrFObupn9OZpzeTVkK1rO8MrhVxkIqPFUqPXOMPGN8CqakWXhdnakYZwkzW+za6
 Bd1s1UOblZr/nKkEO/YOJn6u2kqc2bH+IEkiK9HZ3kjw3yx9TJnLSDKElcpO8wQRrCvzWi63/SQ
 UusGMn7ksIknjZ9/OxZVqct0O7nNY=
X-Received: by 2002:a05:6a21:a58a:b0:19a:2af4:e36d with SMTP id
 gd10-20020a056a21a58a00b0019a2af4e36dmr421488pzc.4.1706143110871; 
 Wed, 24 Jan 2024 16:38:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxoLSDzJe9xU2euGiY19ApJPTymcHWfQ01dCFpiLNb2GcDI1MTVs9/ALIetWxSodBv+dXneC4kTyf8a+HK0yw=
X-Received: by 2002:a05:6a21:a58a:b0:19a:2af4:e36d with SMTP id
 gd10-20020a056a21a58a00b0019a2af4e36dmr421482pzc.4.1706143110521; Wed, 24 Jan
 2024 16:38:30 -0800 (PST)
MIME-Version: 1.0
References: <20240108204909.564514-1-dwmw2@infradead.org>
 <ec354ea42daa8c7ae8bb1fbb521db9d69e6d0fc9.camel@infradead.org>
In-Reply-To: <ec354ea42daa8c7ae8bb1fbb521db9d69e6d0fc9.camel@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Jan 2024 08:38:19 +0800
Message-ID: <CACGkMEtN0HrZRob70OubkCk+2f6GtVtf-eijB1TmpbQ800q+=Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/46] Rework matching of network devices to -nic
 options
To: David Woodhouse <dwmw2@infradead.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 24, 2024 at 9:14=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> Hi Jason,
>
> I think this series probably lives or dies with you. I think it's a
> worthwhile cleanup, but I no longer have an immediate need for it; I
> shipped a slightly ugly workaround in QEMU 8.2.
>
> Please could you let me know if it's worth persisting with it?

Yes it is.

Thomas, I remember you've done tweaks for -nic in the past. would you
like to review this series?

Thanks

>
> Thanks.
>
> On Mon, 2024-01-08 at 20:26 +0000, David Woodhouse wrote:
> >
> > Most platforms iterating directly over the nd_table[] are doing one of
> > two things. Either they are creating the NIC for their platform and wan=
t
> > to find a matching -nic configuration for it, if such exists. Or they
> > are only going to create that platform NIC if a matching config *does*
> > exist.
> >
> > All of those can be converted to the new qemu_configure_nic_device()
> > and qemu_create_nic_device() functions. The latter of which will call
> > qdev_new() to create the device (and apply the config) if a matching
> > NIC config does exist for it. The existing behaviour of each platform
> > has been preserved for now, despite it being apparently fairly random.
> >
> > PCI and indeed XenBus can use a qemu_create_nic_bus_devices() which wil=
l
> > create all NICs that live on a given bus type. That covers most
> > platforms, but some PCI platforms do something special with the first
> > NIC of a given type, placing it in the slot where it would have been on
> > the real hardware. There were various inconsistencies in the way the
> > platforms did so, and whether they cared what model the NIC was. Those
> > subtle behavioural changes I *have* allowed to change, and now the
> > pci_init_nic_slot() function will pick the first NIC that the user
> > specified which isn't explicitly *not* the default type, and put that
> > in the specified slot.
> >
> > The tests for npcm7xx used to lament that they had to instantiate both
> > NICs even when they wanted to test only the second, because there was
> > no way to specify which hardware devices gets which configuration. I
> > made that untrue, by allowing 'emc0' and 'emc1' aliases, and fixed up
> > the test accordingly.
> >
> > There are one or two special cases which want to do special things with
> > the MAC address of the primary NIC, to set up a system identification
> > (or force it to use an Apple OUI, in the case of m68k/q400). All those
> > work out relatively cleanly too.
> >
> > And I can clean up the ugly patch which fixed up the Xen network device
> > handling, and replace it with a simple call to the new
> > qemu_create_nic_bus_devices() function.
> >
> > I suspect that we can remove the pci_init_nic_devices() from platform
> > code and just do it later, except for platforms which *care* which
> > PCI bus the dynamic devices go on (is that just sun4u which puts its
> > primary NIC onto a different bus?).
> >
> > Finally, while we're at it, clean up -nic model=3Dhelp to only print
> > the device models which are actually usable on the given platform
> > rather than just listing them *all*.
> >
> > And now we can make nd_table[] and nb_nics static in net/net.c because
> > nothing else has any business poking at them directly.
> >
> >  v3: Rebase to 8.2
> >
> >  v2: Some build fixes after better coverage testing, revert the Xen fix
> >      in this series because I'm putting the less invasive hack into 8.2
> >      (hopefully).
> >
> > David Woodhouse (46):
> >       net: add qemu_{configure,create}_nic_device(), qemu_find_nic_info=
()
> >       net: report list of available models according to platform
> >       net: add qemu_create_nic_bus_devices()
> >       hw/pci: add pci_init_nic_devices(), pci_init_nic_in_slot()
> >       hw/i386/pc: use qemu_get_nic_info() and pci_init_nic_devices()
> >       hw/xen: use qemu_create_nic_bus_devices() to instantiate Xen NICs
> >       hw/alpha/dp264: use pci_init_nic_devices()
> >       hw/arm/sbsa-ref: use pci_init_nic_devices()
> >       hw/arm/virt: use pci_init_nic_devices()
> >       hw/hppa: use pci_init_nic_devices()
> >       hw/loongarch: use pci_init_nic_devices()
> >       hw/mips/fuloong2e: use pci_init_nic_devices()
> >       hw/mips/malta: use pci_init_nic_devices()
> >       hw/mips/loongson3_virt: use pci_init_nic_devices()
> >       hw/ppc/prep: use pci_init_nic_devices()
> >       hw/ppc/spapr: use qemu_get_nic_info() and pci_init_nic_devices()
> >       hw/ppc: use pci_init_nic_devices()
> >       hw/sh4/r2d: use pci_init_nic_devices()
> >       hw/sparc64/sun4u: use pci_init_nic_devices()
> >       hw/xtensa/virt: use pci_init_nic_devices()
> >       hw/arm/allwinner: use qemu_configure_nic_device()
> >       hw/arm/aspeed: use qemu_configure_nic_device()
> >       hw/arm/exynos4: use qemu_create_nic_device()
> >       hw/arm/fsl: use qemu_configure_nic_device()
> >       hw/net/smc91c111: use qemu_configure_nic_device()
> >       hw/net/lan9118: use qemu_configure_nic_device()
> >       hw/arm/highbank: use qemu_create_nic_device()
> >       hw/arm/npcm7xx: use qemu_configure_nic_device, allow emc0/emc1 as=
 aliases
> >       hw/arm/stellaris: use qemu_find_nic_info()
> >       hw/arm: use qemu_configure_nic_device()
> >       hw/net/etraxfs-eth: use qemu_configure_nic_device()
> >       hw/m68k/mcf5208: use qemu_create_nic_device()
> >       hw/m68k/q800: use qemu_find_nic_info()
> >       hw/microblaze: use qemu_configure_nic_device()
> >       hw/mips/mipssim: use qemu_create_nic_device()
> >       hw/mips/jazz: use qemu_find_nic_info()
> >       hw/net/lasi_i82596: use qemu_configure_nic_device()
> >       hw/openrisc/openrisc_sim: use qemu_create_nic_device()
> >       hw/riscv: use qemu_configure_nic_device()
> >       hw/s390x/s390-virtio-ccw: use qemu_create_nic_device()
> >       hw/sparc/sun4m: use qemu_find_nic_info()
> >       hw/xtensa/xtfpga: use qemu_create_nic_device()
> >       net: remove qemu_check_nic_model()
> >       hw/pci: remove pci_nic_init_nofail()
> >       net: remove qemu_show_nic_models(), qemu_find_nic_model()
> >       net: make nb_nics and nd_table[] static in net/net.c
> >
> >  hw/alpha/dp264.c                         |   4 +-
> >  hw/arm/allwinner-a10.c                   |   6 +-
> >  hw/arm/allwinner-h3.c                    |   6 +-
> >  hw/arm/allwinner-r40.c                   |  27 +---
> >  hw/arm/aspeed.c                          |   9 +-
> >  hw/arm/exynos4_boards.c                  |   6 +-
> >  hw/arm/fsl-imx25.c                       |   2 +-
> >  hw/arm/fsl-imx6.c                        |   2 +-
> >  hw/arm/fsl-imx6ul.c                      |   2 +-
> >  hw/arm/fsl-imx7.c                        |   2 +-
> >  hw/arm/gumstix.c                         |   6 +-
> >  hw/arm/highbank.c                        |  12 +-
> >  hw/arm/integratorcp.c                    |   5 +-
> >  hw/arm/kzm.c                             |   4 +-
> >  hw/arm/mainstone.c                       |   3 +-
> >  hw/arm/mps2-tz.c                         |   8 +-
> >  hw/arm/mps2.c                            |   2 +-
> >  hw/arm/msf2-soc.c                        |   6 +-
> >  hw/arm/musicpal.c                        |   3 +-
> >  hw/arm/npcm7xx.c                         |  16 +-
> >  hw/arm/realview.c                        |  25 ++-
> >  hw/arm/sbsa-ref.c                        |   4 +-
> >  hw/arm/stellaris.c                       |  30 +++-
> >  hw/arm/versatilepb.c                     |  15 +-
> >  hw/arm/vexpress.c                        |   4 +-
> >  hw/arm/virt.c                            |   4 +-
> >  hw/arm/xilinx_zynq.c                     |  11 +-
> >  hw/arm/xlnx-versal.c                     |   7 +-
> >  hw/arm/xlnx-zynqmp.c                     |   8 +-
> >  hw/cris/axis_dev88.c                     |   9 +-
> >  hw/hppa/machine.c                        |   7 +-
> >  hw/i386/pc.c                             |  33 ++--
> >  hw/i386/pc_piix.c                        |   2 +-
> >  hw/i386/pc_q35.c                         |   2 +-
> >  hw/loongarch/virt.c                      |   4 +-
> >  hw/m68k/mcf5208.c                        |  19 +--
> >  hw/m68k/q800.c                           |  29 ++--
> >  hw/microblaze/petalogix_ml605_mmu.c      |   3 +-
> >  hw/microblaze/petalogix_s3adsp1800_mmu.c |   3 +-
> >  hw/mips/fuloong2e.c                      |  16 +-
> >  hw/mips/jazz.c                           |  15 +-
> >  hw/mips/loongson3_virt.c                 |   4 +-
> >  hw/mips/malta.c                          |  15 +-
> >  hw/mips/mipssim.c                        |  13 +-
> >  hw/net/etraxfs_eth.c                     |   5 +-
> >  hw/net/lan9118.c                         |   5 +-
> >  hw/net/lasi_i82596.c                     |   3 +-
> >  hw/net/smc91c111.c                       |   5 +-
> >  hw/openrisc/openrisc_sim.c               |  18 +--
> >  hw/pci/pci.c                             |  73 +++------
> >  hw/ppc/e500.c                            |   4 +-
> >  hw/ppc/mac_newworld.c                    |   4 +-
> >  hw/ppc/mac_oldworld.c                    |   4 +-
> >  hw/ppc/ppc440_bamboo.c                   |  14 +-
> >  hw/ppc/prep.c                            |   8 +-
> >  hw/ppc/spapr.c                           |  18 +--
> >  hw/riscv/microchip_pfsoc.c               |  14 +-
> >  hw/riscv/sifive_u.c                      |   7 +-
> >  hw/s390x/s390-virtio-ccw.c               |  11 +-
> >  hw/sh4/r2d.c                             |   6 +-
> >  hw/sparc/sun4m.c                         |  20 ++-
> >  hw/sparc64/sun4u.c                       |  27 +---
> >  hw/xen/xen-bus.c                         |   6 +-
> >  hw/xen/xen_devconfig.c                   |  25 ---
> >  hw/xenpv/xen_machine_pv.c                |   9 --
> >  hw/xtensa/virt.c                         |   4 +-
> >  hw/xtensa/xtfpga.c                       |  13 +-
> >  include/hw/cris/etraxfs.h                |   2 +-
> >  include/hw/i386/pc.h                     |   4 +-
> >  include/hw/net/lan9118.h                 |   2 +-
> >  include/hw/net/ne2000-isa.h              |   2 -
> >  include/hw/net/smc91c111.h               |   2 +-
> >  include/hw/pci/pci.h                     |   7 +-
> >  include/hw/xen/xen-bus.h                 |   2 +-
> >  include/hw/xen/xen-legacy-backend.h      |   1 -
> >  include/net/net.h                        |  18 +--
> >  net/net.c                                | 253 +++++++++++++++++++++++=
++------
> >  system/globals.c                         |   2 -
> >  tests/qtest/npcm7xx_emc-test.c           |  18 +--
> >  79 files changed, 479 insertions(+), 550 deletions(-)
> >
> >
> >
> >
>


