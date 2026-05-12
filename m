Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2B1CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 16:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpfk-0008Nm-Pj; Tue, 12 May 2026 12:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@pjd.dev>)
 id 1wMpfg-0008Mi-M1; Tue, 12 May 2026 12:09:24 -0400
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@pjd.dev>)
 id 1wMpfc-0003R9-BZ; Tue, 12 May 2026 12:09:24 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 43C147A012C;
 Tue, 12 May 2026 12:09:16 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
 by phl-compute-02.internal (MEProxy); Tue, 12 May 2026 12:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pjd.dev; h=cc:cc
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1778602156; x=1778688556; bh=3TrpQRuG7b
 e40F4QJo/UjmxrHYzx5BeThhy2aM6nRkc=; b=cCVYIMEeKyrMRVuPa+1/gDtc6n
 inLufKWfLcb41DpcSF4Ou98Wx7blqe8udweWIYkXSd/D5JznYIvd6/k+WjawmYii
 ltVL7p1K6DuYLFCfuHixsEzhLQxnOV0pgBI2kGOGTT5qPoa/fuAql+CrJ5Ag6B6Z
 hwH3YD1HTxDnZC4PjIvyeqZbA1HwPunhdAyEFDzxlyXfEQ34vTvchNxIrIqRwAQV
 bA9FFp71F6ozdY286Iq/NMkBulffPZekspIoe6L0gCRhieBWCU/FEaGbZdQHz+mi
 1G39fo1VRrmtPeSat06Tebh4hX4jx1V9hnwy9WZNphwIa/Vu82O/tFRBjvOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1778602156; x=1778688556; bh=3TrpQRuG7be40F4QJo/UjmxrHYzx5BeThhy
 2aM6nRkc=; b=nqt9/c7EOMTZ4icYdFZrKhKrXG+sp9AUxZBIdnM/J4C3pCh/tjz
 0Vd3TBcNybE898v8XPZDXV1K+AnY/XIkAyHC0tWo2pRC8YXgtt4pB5IQyb8TBp55
 C71hDHezmhdR/wSox6iwMVlQ7pHwsg2HbTsB3AGKrISrxKY0kUDMQJa4gCr3ZZg9
 PhlR+6LwCcfJrCUGilnDh2VAtnq9TD13UWX5xitw+csRe8qHwIJpHqRvD2i7QseD
 Io/3H1AQ8IqyDpHMvNOT5b0rEdQK3244jQBxGQRXBnutR5V3Gwr8kErvob3yadZq
 bLY6TIwwv0jgSkmgdtUPGP90AnVmD3gUwcA==
X-ME-Sender: <xms:qlADagPnS9Ou2O8-fON9pHy7bvU30dWceDHGnUOFsS7oBy0SE1b_wg>
 <xme:qlADahziMJVDYGKcxBx9XC1UXZhyg7bL2171VeqD0mjqqGCqDbDjO2f-Zik63O6dM
 1DbnpOCZgafuedOoZmpZkJE24QTh-WmmLWvdAh6BMcXgNABdN5lGHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvvdegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgesrgdtreerredtjeenucfhrhhomhepfdfrvghtvghr
 ucffvghlvghvohhrhigrshdfuceomhgvsehpjhgurdguvghvqeenucggtffrrghtthgvrh
 hnpeegieehhefhhffhieekjefhgfegfedvhfelueeikeekvdffffehvedvhfetfeetuden
 ucffohhmrghinhepohhpvghntghomhhpuhhtvgdrohhrghdpghhithhhuhgsrdgtohhmpd
 hmvghtrgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
 fhhrohhmpehmvgesphhjugdruggvvhdpnhgspghrtghpthhtohepuddvpdhmohguvgepsh
 hmthhpohhuthdprhgtphhtthhopehjrghmihhnpghlihhnsegrshhpvggvughtvggthhdr
 tghomhdprhgtphhtthhopehkrghnvggptghhvghnsegrshhpvggvughtvggthhdrtghomh
 dprhgtphhtthhopehsthgvvhgvnhgplhgvvgesrghsphgvvgguthgvtghhrdgtohhmpdhr
 tghpthhtoheprghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprh
 gtphhtthhopehlvggvthhrohihsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhovghl
 sehjmhhsrdhiugdrrghupdhrtghpthhtoheptghlgheskhgrohgurdhorhhgpdhrtghpth
 htohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohep
 qhgvmhhuqdgrrhhmsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:qlADagKapnzTnKPON5r-XjPkXBCukAFDx7q-cJCl_y5t1Xaz4Wt1Cw>
 <xmx:qlADamjdj8lzmtd7fmNjZBThITP-LWIkEgCR5sLCTq--liHK-hHsjw>
 <xmx:qlADas_W_NvPasPooLbQ7mQRo0YYL5JeeGWMZkzW3SJVJof-TgtvOA>
 <xmx:qlADarMP58Hs3aZOn0FSjDMbaEVkAYNAYc87PfzLUWsFoYwQ7n8UMA>
 <xmx:rFADauSaxR6EbegbLJSYifZlc-yEL6F97LBplU9JIWrnasbX747S5PzZ>
Feedback-ID: idbf149bf:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 4028C15C008F; Tue, 12 May 2026 12:09:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AH2e3UL6sFa7
Date: Tue, 12 May 2026 09:08:54 -0700
From: "Peter Delevoryas" <me@pjd.dev>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, pierrick.bouvier@oss.qualcomm.com
Cc: "Peter Maydell" <peter.maydell@linaro.org>,
 "Steven Lee" <steven_lee@aspeedtech.com>, "Troy Lee" <leetroy@gmail.com>,
 "Jamin Lin" <jamin_lin@aspeedtech.com>, kane_chen@aspeedtech.com,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>,
 "Joel Stanley" <joel@jms.id.au>
Message-Id: <cf0a1b51-7ebd-4765-9301-bf97e5f6e29f@app.fastmail.com>
In-Reply-To: <089c31b4-d592-495c-90dd-ced4ce363423@kaod.org>
References: <20260510165704.2935316-1-clg@redhat.com>
 <20260510165704.2935316-5-clg@redhat.com>
 <089c31b4-d592-495c-90dd-ced4ce363423@kaod.org>
Subject: Re: [PATCH 4/4] hw/arm: Remove fby35 machine
Content-Type: multipart/alternative;
 boundary=2816ebfb3089dc722450d6011dd5e3eb2c81c35e
Received-SPF: pass client-ip=202.12.124.154; envelope-from=me@pjd.dev;
 helo=fhigh-b3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--2816ebfb3089dc722450d6011dd5e3eb2c81c35e
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Oh sure, yeah sounds good to me!

Acked-by: Peter Delevoryas <peter@pjd.dev>

On Tue, May 12, 2026, at 2:39 AM, C=C3=A9dric Le Goater wrote:
> Hi,
>=20
> + Peter for awareness. Forgot to add you, sorry about that.
>=20
> It would be nice to have an Ack for this removal.
>=20
> Thanks,
>=20
> C.
>=20
> On 5/10/26 18:57, C=C3=A9dric Le Goater wrote:
> > The fby35 machine was deprecated in QEMU 10.2 and is now removed in
> > QEMU 11.1.
> >=20
> > This multi-SoC machine was added as an example of heterogeneous
> > systems, but the models never evolved and no public firmware is
> > available to boot it. Users needing multi-SoC emulation should use t=
he
> > ast2700fc machine instead, which is based on newer AST2700 SoCs with
> > better support.
> >=20
> > Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> > ---
> >   MAINTAINERS                     |   2 -
> >   docs/about/deprecated.rst       |  10 --
> >   docs/about/removed-features.rst |  10 ++
> >   docs/system/arm/fby35.rst       |  52 --------
> >   docs/system/target-arm.rst      |   1 -
> >   hw/arm/fby35.c                  | 203 ----------------------------=
----
> >   hw/arm/meson.build              |   3 +-
> >   7 files changed, 11 insertions(+), 270 deletions(-)
> >   delete mode 100644 docs/system/arm/fby35.rst
> >   delete mode 100644 hw/arm/fby35.c
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9d3d64595370..14c8fe0da402 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1276,12 +1276,10 @@ F: include/hw/*/*aspeed*
> >   F: hw/net/ftgmac100.c
> >   F: include/hw/net/ftgmac100.h
> >   F: docs/system/arm/aspeed.rst
> > -F: docs/system/arm/fby35.rst
> >   F: docs/specs/aspeed*
> >   F: tests/functional/*/*aspeed*
> >   F: tests/*/*aspeed*
> >   F: tests/*/*ast2700*
> > -F: hw/arm/fby35.c
> >   F: pc-bios/ast27x0_bootrom.bin
> >   F: roms/vbootrom
> >  =20
> > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > index e416f3d8a74b..bf6182d61c6e 100644
> > --- a/docs/about/deprecated.rst
> > +++ b/docs/about/deprecated.rst
> > @@ -250,16 +250,6 @@ deprecated; use the new name ``dtb-randomness``=
 instead. The new name
> >   better reflects the way this property affects all random data with=
in
> >   the device tree blob, not just the ``kaslr-seed`` node.
> >  =20
> > -Arm ``fby35`` machine (since 10.2)
> > -''''''''''''''''''''''''''''''''''
> > -
> > -The ``fby35`` machine was originally added as an example of a
> > -multi-SoC system, with the expectation the models would evolve over
> > -time in an heterogeneous system. This hasn't happened and no public
> > -firmware is available to boot it. It can be replaced by the
> > -``ast2700fc``, another multi-SoC machine based on the newer AST2700
> > -SoCs which are excepted to receive better support in the future.
> > -
> >  =20
> >   RISC-V default machine option (since 10.0)
> >   ''''''''''''''''''''''''''''''''''''''''''
> > diff --git a/docs/about/removed-features.rst b/docs/about/removed-fe=
atures.rst
> > index 2da8283d0e1e..9bd83b183f46 100644
> > --- a/docs/about/removed-features.rst
> > +++ b/docs/about/removed-features.rst
> > @@ -1213,6 +1213,16 @@ models, it can be replaced by the ``ast2500-e=
vb`` machine using the
> >   ``fmc-model`` option to specify the flash type. The I2C devices
> >   connected to the board can be defined via the QEMU command line.
> >  =20
> > +Arm ``fby35`` machine (removed in 11.1)
> > +'''''''''''''''''''''''''''''''''''''''
> > +
> > +The ``fby35`` machine was originally added as an example of a
> > +multi-SoC system, with the expectation the models would evolve over
> > +time in an heterogeneous system. This hasn't happened and no public
> > +firmware is available to boot it. It can be replaced by the
> > +``ast2700fc``, another multi-SoC machine based on the newer AST2700
> > +SoCs which are excepted to receive better support in the future.
> > +
> >   linux-user mode CPUs
> >   --------------------
> >  =20
> > diff --git a/docs/system/arm/fby35.rst b/docs/system/arm/fby35.rst
> > deleted file mode 100644
> > index e19274e75c81..000000000000
> > --- a/docs/system/arm/fby35.rst
> > +++ /dev/null
> > @@ -1,52 +0,0 @@
> > -Facebook Yosemite v3.5 Platform and CraterLake Server (``fby35``)
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -Facebook has a series of multi-node compute server designs named
> > -Yosemite. The most recent version released was
> > -`Yosemite v3 <https://www.opencompute.org/documents/ocp-yosemite-v3=
-platform-design-specification-1v16-pdf>`__.
> > -
> > -Yosemite v3.5 is an iteration on this design, and is very similar: =
there's a
> > -baseboard with a BMC, and 4 server slots. The new server board desi=
gn termed
> > -"CraterLake" includes a Bridge IC (BIC), with room for expansion bo=
ards to
> > -include various compute accelerators (video, inferencing, etc). At =
the moment,
> > -only the first server slot's BIC is included.
> > -
> > -Yosemite v3.5 is itself a sled which fits into a 40U chassis, and 3=
 sleds
> > -can be fit into a chassis. See `here <https://www.opencompute.org/p=
roducts-chiplets/237/wiwynn-yosemite-v3-server>`__
> > -for an example.
> > -
> > -In this generation, the BMC is an AST2600 and each BIC is an AST103=
0. The BMC
> > -runs `OpenBMC <https://github.com/facebook/openbmc>`__, and the BIC=
 runs
> > -`OpenBIC <https://github.com/facebook/openbic>`__.
> > -
> > -Firmware images can be retrieved from the Github releases or built =
from the
> > -source code, see the README's for instructions on that. This image =
uses the
> > -"fby35" machine recipe from OpenBMC, and the "yv35-cl" target from =
OpenBIC.
> > -Some reference images can also be found here:
> > -
> > -.. code-block:: bash
> > -
> > -    $ wget https://github.com/facebook/openbmc/releases/download/op=
enbmc-e2294ff5d31d/fby35.mtd
> > -    $ wget https://github.com/peterdelevoryas/OpenBIC/releases/down=
load/oby35-cl-2022.13.01/Y35BCL.elf
> > -
> > -Since this machine has multiple SoC's, each with their own serial c=
onsole, the
> > -recommended way to run it is to allocate a pseudoterminal for each =
serial
> > -console and let the monitor use stdio. Also, starting in a paused s=
tate is
> > -useful because it allows you to attach to the pseudoterminals befor=
e the boot
> > -process starts.
> > -
> > -.. code-block:: bash
> > -
> > -    $ qemu-system-arm -machine fby35 \
> > -        -drive file=3Dfby35.mtd,format=3Draw,if=3Dmtd \
> > -        -device loader,file=3DY35BCL.elf,addr=3D0,cpu-num=3D2 \
> > -        -serial pty -serial pty -serial mon:stdio \
> > -        -display none -S
> > -    $ screen /dev/tty0 # In a separate TMUX pane, terminal window, =
etc.
> > -    $ screen /dev/tty1
> > -    $ (qemu) c    # Start the boot process once screen is setup.
> > -
> > -This machine model supports emulation of the boot from the CE0 flas=
h device by
> > -setting option ``execute-in-place``. When using this option, the CP=
U fetches
> > -instructions to execute by reading CE0 and not from a preloaded ROM
> > -initialized at machine init time. As a result, execution will be sl=
ower.
> > diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> > index c57102a4149f..e34492402f0a 100644
> > --- a/docs/system/target-arm.rst
> > +++ b/docs/system/target-arm.rst
> > @@ -87,7 +87,6 @@ Board-specific documentation
> >      arm/cubieboard
> >      arm/emcraft-sf2
> >      arm/exynos
> > -   arm/fby35
> >      arm/musicpal
> >      arm/kzm
> >      arm/nrf
> > diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
> > deleted file mode 100644
> > index d3bfd2c7d26a..000000000000
> > --- a/hw/arm/fby35.c
> > +++ /dev/null
> > @@ -1,203 +0,0 @@
> > -/*
> > - * Copyright (c) Meta Platforms, Inc. and affiliates. (http://www.m=
eta.com)
> > - *
> > - * This code is licensed under the GPL version 2 or later. See the =
COPYING
> > - * file in the top-level directory.
> > - */
> > -
> > -#include "qemu/osdep.h"
> > -#include "qemu/units.h"
> > -#include "qapi/error.h"
> > -#include "system/system.h"
> > -#include "system/block-backend.h"
> > -#include "hw/core/boards.h"
> > -#include "hw/core/qdev-clock.h"
> > -#include "hw/arm/aspeed_soc.h"
> > -#include "hw/arm/boot.h"
> > -#include "hw/arm/machines-qom.h"
> > -
> > -#define TYPE_FBY35 MACHINE_TYPE_NAME("fby35")
> > -OBJECT_DECLARE_SIMPLE_TYPE(Fby35State, FBY35);
> > -
> > -struct Fby35State {
> > -    MachineState parent_obj;
> > -
> > -    MemoryRegion bmc_memory;
> > -    MemoryRegion bmc_dram;
> > -    MemoryRegion bmc_boot_rom;
> > -    MemoryRegion bic_memory;
> > -    Clock *bic_sysclk;
> > -
> > -    Aspeed2600SoCState bmc;
> > -    Aspeed10x0SoCState bic;
> > -
> > -    bool mmio_exec;
> > -};
> > -
> > -#define FBY35_BMC_RAM_SIZE (2 * GiB)
> > -#define FBY35_BMC_FIRMWARE_ADDR 0x0
> > -
> > -static void fby35_bmc_write_boot_rom(DriveInfo *dinfo, MemoryRegion=
 *mr,
> > -                                     hwaddr offset, size_t rom_size,
> > -                                     Error **errp)
> > -{
> > -    BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
> > -    g_autofree void *storage =3D NULL;
> > -    int64_t size;
> > -
> > -    /*
> > -     * The block backend size should have already been 'validated' =
by
> > -     * the creation of the m25p80 object.
> > -     */
> > -    size =3D blk_getlength(blk);
> > -    if (size <=3D 0) {
> > -        error_setg(errp, "failed to get flash size");
> > -        return;
> > -    }
> > -
> > -    if (rom_size > size) {
> > -        rom_size =3D size;
> > -    }
> > -
> > -    storage =3D g_malloc0(rom_size);
> > -    if (blk_pread(blk, 0, rom_size, storage, 0) < 0) {
> > -        error_setg(errp, "failed to read the initial flash content"=
);
> > -        return;
> > -    }
> > -
> > -    /* TODO: find a better way to install the ROM */
> > -    memcpy(memory_region_get_ram_ptr(mr) + offset, storage, rom_siz=
e);
> > -}
> > -
> > -static void fby35_bmc_init(Fby35State *s)
> > -{
> > -    AspeedSoCState *soc;
> > -    AspeedSoCClass *sc;
> > -
> > -    object_initialize_child(OBJECT(s), "bmc", &s->bmc, "ast2600-a3"=
);
> > -    soc =3D ASPEED_SOC(&s->bmc);
> > -    sc =3D ASPEED_SOC_GET_CLASS(soc);
> > -
> > -    memory_region_init(&s->bmc_memory, OBJECT(&s->bmc), "bmc-memory=
",
> > -                       UINT64_MAX);
> > -    memory_region_add_subregion(get_system_memory(), 0, &s->bmc_mem=
ory);
> > -    memory_region_init_ram(&s->bmc_dram, OBJECT(&s->bmc), "bmc-dram=
",
> > -                           FBY35_BMC_RAM_SIZE, &error_abort);
> > -
> > -    object_property_set_int(OBJECT(&s->bmc), "ram-size", FBY35_BMC_=
RAM_SIZE,
> > -                            &error_abort);
> > -    object_property_set_link(OBJECT(&s->bmc), "memory", OBJECT(&s->=
bmc_memory),
> > -                             &error_abort);
> > -    object_property_set_link(OBJECT(&s->bmc), "dram", OBJECT(&s->bm=
c_dram),
> > -                             &error_abort);
> > -    object_property_set_int(OBJECT(&s->bmc), "hw-strap1", 0x000000C=
0,
> > -                            &error_abort);
> > -    object_property_set_int(OBJECT(&s->bmc), "hw-strap2", 0x0000000=
3,
> > -                            &error_abort);
> > -    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART5, sc->uarts_=
base,
> > -                            sc->uarts_num, serial_hd(0));
> > -    qdev_realize(DEVICE(&s->bmc), NULL, &error_abort);
> > -
> > -    aspeed_board_init_flashes(&soc->fmc, "n25q00", 2, 0);
> > -
> > -    /* Install first FMC flash content as a boot rom. */
> > -    if (!s->mmio_exec) {
> > -        DriveInfo *mtd0 =3D drive_get(IF_MTD, 0, 0);
> > -
> > -        if (mtd0) {
> > -            uint64_t rom_size =3D memory_region_size(&soc->spi_boot=
);
> > -
> > -            memory_region_init_rom(&s->bmc_boot_rom, NULL, "aspeed.=
boot_rom",
> > -                                   rom_size, &error_abort);
> > -            memory_region_add_subregion_overlap(&soc->spi_boot_cont=
ainer, 0,
> > -                                                &s->bmc_boot_rom, 1=
);
> > -
> > -            fby35_bmc_write_boot_rom(mtd0, &s->bmc_boot_rom,
> > -                                     FBY35_BMC_FIRMWARE_ADDR,
> > -                                     rom_size, &error_abort);
> > -        }
> > -    }
> > -}
> > -
> > -static void fby35_bic_init(Fby35State *s)
> > -{
> > -    AspeedSoCState *soc;
> > -    AspeedSoCClass *sc;
> > -
> > -    s->bic_sysclk =3D clock_new(OBJECT(s), "SYSCLK");
> > -    clock_set_hz(s->bic_sysclk, 200000000ULL);
> > -
> > -    object_initialize_child(OBJECT(s), "bic", &s->bic, "ast1030-a1"=
);
> > -    soc =3D ASPEED_SOC(&s->bic);
> > -    sc =3D ASPEED_SOC_GET_CLASS(soc);
> > -
> > -    memory_region_init(&s->bic_memory, OBJECT(&s->bic), "bic-memory=
",
> > -                       UINT64_MAX);
> > -
> > -    qdev_connect_clock_in(DEVICE(&s->bic), "sysclk", s->bic_sysclk);
> > -    object_property_set_link(OBJECT(&s->bic), "memory", OBJECT(&s->=
bic_memory),
> > -                             &error_abort);
> > -    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART5, sc->uarts_=
base,
> > -                            sc->uarts_num, serial_hd(1));
> > -    qdev_realize(DEVICE(&s->bic), NULL, &error_abort);
> > -
> > -    aspeed_board_init_flashes(&soc->fmc, "sst25vf032b", 2, 2);
> > -    aspeed_board_init_flashes(&soc->spi[0], "sst25vf032b", 2, 4);
> > -    aspeed_board_init_flashes(&soc->spi[1], "sst25vf032b", 2, 6);
> > -}
> > -
> > -static void fby35_init(MachineState *machine)
> > -{
> > -    Fby35State *s =3D FBY35(machine);
> > -
> > -    fby35_bmc_init(s);
> > -    fby35_bic_init(s);
> > -}
> > -
> > -
> > -static bool fby35_get_mmio_exec(Object *obj, Error **errp)
> > -{
> > -    return FBY35(obj)->mmio_exec;
> > -}
> > -
> > -static void fby35_set_mmio_exec(Object *obj, bool value, Error **er=
rp)
> > -{
> > -    FBY35(obj)->mmio_exec =3D value;
> > -}
> > -
> > -static void fby35_instance_init(Object *obj)
> > -{
> > -    FBY35(obj)->mmio_exec =3D false;
> > -}
> > -
> > -static void fby35_class_init(ObjectClass *oc, const void *data)
> > -{
> > -    MachineClass *mc =3D MACHINE_CLASS(oc);
> > -
> > -    mc->desc =3D "Meta Platforms fby35";
> > -    mc->deprecation_reason =3D "For a multi-soc machine, use 'ast27=
00fc' instead";
> > -    mc->init =3D fby35_init;
> > -    mc->no_floppy =3D 1;
> > -    mc->no_cdrom =3D 1;
> > -    mc->auto_create_sdcard =3D true;
> > -    mc->min_cpus =3D mc->max_cpus =3D mc->default_cpus =3D 3;
> > -
> > -    object_class_property_add_bool(oc, "execute-in-place",
> > -                                   fby35_get_mmio_exec,
> > -                                   fby35_set_mmio_exec);
> > -    object_class_property_set_description(oc, "execute-in-place",
> > -                           "boot directly from CE0 flash device");
> > -}
> > -
> > -static const TypeInfo fby35_types[] =3D {
> > -    {
> > -        .name =3D MACHINE_TYPE_NAME("fby35"),
> > -        .parent =3D TYPE_MACHINE,
> > -        .class_init =3D fby35_class_init,
> > -        .instance_size =3D sizeof(Fby35State),
> > -        .instance_init =3D fby35_instance_init,
> > -        .interfaces =3D arm_machine_interfaces,
> > -    },
> > -};
> > -
> > -DEFINE_TYPES(fby35_types);
> > diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> > index 063abf2cf654..80068f70bb9c 100644
> > --- a/hw/arm/meson.build
> > +++ b/hw/arm/meson.build
> > @@ -62,8 +62,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: fil=
es(
> >     'aspeed_ast2600_gb200nvl.c',
> >     'aspeed_ast2600_rainier.c',
> >     'aspeed_ast10x0.c',
> > -  'aspeed_ast10x0_evb.c',
> > -  'fby35.c'))
> > +  'aspeed_ast10x0_evb.c'))
> >   arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], i=
f_true: files(
> >     'aspeed_ast1700.c',
> >     'aspeed_ast27x0.c',
>=20
>=20

--2816ebfb3089dc722450d6011dd5e3eb2c81c35e
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><title></title></head><body><div><div>Oh sure=
, yeah sounds good to me!</div><div><br></div>Acked-by: Peter Delevoryas=
 &lt;<a href=3D"mailto:peter@pjd.dev">peter@pjd.dev</a>&gt;<br></div><di=
v><br></div><div>On Tue, May 12, 2026, at 2:39 AM, C=C3=A9dric Le Goater=
 wrote:</div><blockquote type=3D"cite" id=3D"qt" style=3D""><div>Hi,</di=
v><div><br></div><div>+ Peter for awareness. Forgot to add you, sorry ab=
out that.</div><div><br></div><div>It would be nice to have an Ack for t=
his removal.</div><div><br></div><div>Thanks,</div><div><br></div><div>C=
.</div><div><br></div><div>On 5/10/26 18:57, C=C3=A9dric Le Goater wrote=
:</div><div>&gt; The fby35 machine was deprecated in QEMU 10.2 and is no=
w removed in</div><div>&gt; QEMU 11.1.</div><div>&gt;&nbsp;</div><div>&g=
t; This multi-SoC machine was added as an example of heterogeneous</div>=
<div>&gt; systems, but the models never evolved and no public firmware i=
s</div><div>&gt; available to boot it. Users needing multi-SoC emulation=
 should use the</div><div>&gt; ast2700fc machine instead, which is based=
 on newer AST2700 SoCs with</div><div>&gt; better support.</div><div>&gt=
;&nbsp;</div><div>&gt; Signed-off-by: C=C3=A9dric Le Goater &lt;<a href=3D=
"mailto:clg@redhat.com">clg@redhat.com</a>&gt;</div><div>&gt; ---</div><=
div>&gt;&nbsp;&nbsp; MAINTAINERS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp;&nbsp; 2 -</div><div>&gt;&nbsp;&nbsp; docs/about/depreca=
ted.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 10 --</div><div>&gt;=
&nbsp;&nbsp; docs/about/removed-features.rst |&nbsp; 10 ++</div><div>&gt=
;&nbsp;&nbsp; docs/system/arm/fby35.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp; 52 --------</div><div>&gt;&nbsp;&nbsp; docs/system/target-ar=
m.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 -</div><div>&gt;&nbs=
p;&nbsp; hw/arm/fby35.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 203 ------------=
--------------------</div><div>&gt;&nbsp;&nbsp; hw/arm/meson.build&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 |&nbsp;&nbsp; 3 +-</div><div>&gt;&nbsp;&nbsp; 7 files changed, 11 inser=
tions(+), 270 deletions(-)</div><div>&gt;&nbsp;&nbsp; delete mode 100644=
 docs/system/arm/fby35.rst</div><div>&gt;&nbsp;&nbsp; delete mode 100644=
 hw/arm/fby35.c</div><div>&gt;&nbsp;</div><div>&gt; diff --git a/MAINTAI=
NERS b/MAINTAINERS</div><div>&gt; index 9d3d64595370..14c8fe0da402 10064=
4</div><div>&gt; --- a/MAINTAINERS</div><div>&gt; +++ b/MAINTAINERS</div=
><div>&gt; @@ -1276,12 +1276,10 @@ F: include/hw/*/*aspeed*</div><div>&g=
t;&nbsp;&nbsp; F: hw/net/ftgmac100.c</div><div>&gt;&nbsp;&nbsp; F: inclu=
de/hw/net/ftgmac100.h</div><div>&gt;&nbsp;&nbsp; F: docs/system/arm/aspe=
ed.rst</div><div>&gt; -F: docs/system/arm/fby35.rst</div><div>&gt;&nbsp;=
&nbsp; F: docs/specs/aspeed*</div><div>&gt;&nbsp;&nbsp; F: tests/functio=
nal/*/*aspeed*</div><div>&gt;&nbsp;&nbsp; F: tests/*/*aspeed*</div><div>=
&gt;&nbsp;&nbsp; F: tests/*/*ast2700*</div><div>&gt; -F: hw/arm/fby35.c<=
/div><div>&gt;&nbsp;&nbsp; F: pc-bios/ast27x0_bootrom.bin</div><div>&gt;=
&nbsp;&nbsp; F: roms/vbootrom</div><div>&gt;&nbsp;&nbsp;&nbsp;</div><div=
>&gt; diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst=
</div><div>&gt; index e416f3d8a74b..bf6182d61c6e 100644</div><div>&gt; -=
-- a/docs/about/deprecated.rst</div><div>&gt; +++ b/docs/about/deprecate=
d.rst</div><div>&gt; @@ -250,16 +250,6 @@ deprecated; use the new name `=
`dtb-randomness`` instead. The new name</div><div>&gt;&nbsp;&nbsp; bette=
r reflects the way this property affects all random data within</div><di=
v>&gt;&nbsp;&nbsp; the device tree blob, not just the ``kaslr-seed`` nod=
e.</div><div>&gt;&nbsp;&nbsp;&nbsp;</div><div>&gt; -Arm ``fby35`` machin=
e (since 10.2)</div><div>&gt; -''''''''''''''''''''''''''''''''''</div><=
div>&gt; -</div><div>&gt; -The ``fby35`` machine was originally added as=
 an example of a</div><div>&gt; -multi-SoC system, with the expectation =
the models would evolve over</div><div>&gt; -time in an heterogeneous sy=
stem. This hasn't happened and no public</div><div>&gt; -firmware is ava=
ilable to boot it. It can be replaced by the</div><div>&gt; -``ast2700fc=
``, another multi-SoC machine based on the newer AST2700</div><div>&gt; =
-SoCs which are excepted to receive better support in the future.</div><=
div>&gt; -</div><div>&gt;&nbsp;&nbsp;&nbsp;</div><div>&gt;&nbsp;&nbsp; R=
ISC-V default machine option (since 10.0)</div><div>&gt;&nbsp;&nbsp; '''=
'''''''''''''''''''''''''''''''''''''''</div><div>&gt; diff --git a/docs=
/about/removed-features.rst b/docs/about/removed-features.rst</div><div>=
&gt; index 2da8283d0e1e..9bd83b183f46 100644</div><div>&gt; --- a/docs/a=
bout/removed-features.rst</div><div>&gt; +++ b/docs/about/removed-featur=
es.rst</div><div>&gt; @@ -1213,6 +1213,16 @@ models, it can be replaced =
by the ``ast2500-evb`` machine using the</div><div>&gt;&nbsp;&nbsp; ``fm=
c-model`` option to specify the flash type. The I2C devices</div><div>&g=
t;&nbsp;&nbsp; connected to the board can be defined via the QEMU comman=
d line.</div><div>&gt;&nbsp;&nbsp;&nbsp;</div><div>&gt; +Arm ``fby35`` m=
achine (removed in 11.1)</div><div>&gt; +'''''''''''''''''''''''''''''''=
''''''''</div><div>&gt; +</div><div>&gt; +The ``fby35`` machine was orig=
inally added as an example of a</div><div>&gt; +multi-SoC system, with t=
he expectation the models would evolve over</div><div>&gt; +time in an h=
eterogeneous system. This hasn't happened and no public</div><div>&gt; +=
firmware is available to boot it. It can be replaced by the</div><div>&g=
t; +``ast2700fc``, another multi-SoC machine based on the newer AST2700<=
/div><div>&gt; +SoCs which are excepted to receive better support in the=
 future.</div><div>&gt; +</div><div>&gt;&nbsp;&nbsp; linux-user mode CPU=
s</div><div>&gt;&nbsp;&nbsp; --------------------</div><div>&gt;&nbsp;&n=
bsp;&nbsp;</div><div>&gt; diff --git a/docs/system/arm/fby35.rst b/docs/=
system/arm/fby35.rst</div><div>&gt; deleted file mode 100644</div><div>&=
gt; index e19274e75c81..000000000000</div><div>&gt; --- a/docs/system/ar=
m/fby35.rst</div><div>&gt; +++ /dev/null</div><div>&gt; @@ -1,52 +0,0 @@=
</div><div>&gt; -Facebook Yosemite v3.5 Platform and CraterLake Server (=
``fby35``)</div><div>&gt; -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</div><div>&gt; -</div><div>&gt; -Facebook has a series of mult=
i-node compute server designs named</div><div>&gt; -Yosemite. The most r=
ecent version released was</div><div>&gt; -`Yosemite v3 &lt;<a href=3D"h=
ttps://www.opencompute.org/documents/ocp-yosemite-v3-platform-design-spe=
cification-1v16-pdf">https://www.opencompute.org/documents/ocp-yosemite-=
v3-platform-design-specification-1v16-pdf</a>&gt;`__.</div><div>&gt; -</=
div><div>&gt; -Yosemite v3.5 is an iteration on this design, and is very=
 similar: there's a</div><div>&gt; -baseboard with a BMC, and 4 server s=
lots. The new server board design termed</div><div>&gt; -"CraterLake" in=
cludes a Bridge IC (BIC), with room for expansion boards to</div><div>&g=
t; -include various compute accelerators (video, inferencing, etc). At t=
he moment,</div><div>&gt; -only the first server slot's BIC is included.=
</div><div>&gt; -</div><div>&gt; -Yosemite v3.5 is itself a sled which f=
its into a 40U chassis, and 3 sleds</div><div>&gt; -can be fit into a ch=
assis. See `here &lt;<a href=3D"https://www.opencompute.org/products-chi=
plets/237/wiwynn-yosemite-v3-server">https://www.opencompute.org/product=
s-chiplets/237/wiwynn-yosemite-v3-server</a>&gt;`__</div><div>&gt; -for =
an example.</div><div>&gt; -</div><div>&gt; -In this generation, the BMC=
 is an AST2600 and each BIC is an AST1030. The BMC</div><div>&gt; -runs =
`OpenBMC &lt;<a href=3D"https://github.com/facebook/openbmc">https://git=
hub.com/facebook/openbmc</a>&gt;`__, and the BIC runs</div><div>&gt; -`O=
penBIC &lt;<a href=3D"https://github.com/facebook/openbic">https://githu=
b.com/facebook/openbic</a>&gt;`__.</div><div>&gt; -</div><div>&gt; -Firm=
ware images can be retrieved from the Github releases or built from the<=
/div><div>&gt; -source code, see the README's for instructions on that. =
This image uses the</div><div>&gt; -"fby35" machine recipe from OpenBMC,=
 and the "yv35-cl" target from OpenBIC.</div><div>&gt; -Some reference i=
mages can also be found here:</div><div>&gt; -</div><div>&gt; -.. code-b=
lock:: bash</div><div>&gt; -</div><div>&gt; -&nbsp;&nbsp;&nbsp; $ wget&n=
bsp;<a href=3D"https://github.com/facebook/openbmc/releases/download/ope=
nbmc-e2294ff5d31d/fby35.mtd">https://github.com/facebook/openbmc/release=
s/download/openbmc-e2294ff5d31d/fby35.mtd</a></div><div>&gt; -&nbsp;&nbs=
p;&nbsp; $ wget&nbsp;<a href=3D"https://github.com/peterdelevoryas/OpenB=
IC/releases/download/oby35-cl-2022.13.01/Y35BCL.elf">https://github.com/=
peterdelevoryas/OpenBIC/releases/download/oby35-cl-2022.13.01/Y35BCL.elf=
</a></div><div>&gt; -</div><div>&gt; -Since this machine has multiple So=
C's, each with their own serial console, the</div><div>&gt; -recommended=
 way to run it is to allocate a pseudoterminal for each serial</div><div=
>&gt; -console and let the monitor use stdio. Also, starting in a paused=
 state is</div><div>&gt; -useful because it allows you to attach to the =
pseudoterminals before the boot</div><div>&gt; -process starts.</div><di=
v>&gt; -</div><div>&gt; -.. code-block:: bash</div><div>&gt; -</div><div=
>&gt; -&nbsp;&nbsp;&nbsp; $ qemu-system-arm -machine fby35 \</div><div>&=
gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -drive file=3Dfby35.mtd,=
format=3Draw,if=3Dmtd \</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; -device loader,file=3DY35BCL.elf,addr=3D0,cpu-num=3D2 \</div>=
<div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -serial pty -seria=
l pty -serial mon:stdio \</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; -display none -S</div><div>&gt; -&nbsp;&nbsp;&nbsp; $ scree=
n /dev/tty0 # In a separate TMUX pane, terminal window, etc.</div><div>&=
gt; -&nbsp;&nbsp;&nbsp; $ screen /dev/tty1</div><div>&gt; -&nbsp;&nbsp;&=
nbsp; $ (qemu) c		&nbsp;&nbsp; # Start the boot process once screen is s=
etup.</div><div>&gt; -</div><div>&gt; -This machine model supports emula=
tion of the boot from the CE0 flash device by</div><div>&gt; -setting op=
tion ``execute-in-place``. When using this option, the CPU fetches</div>=
<div>&gt; -instructions to execute by reading CE0 and not from a preload=
ed ROM</div><div>&gt; -initialized at machine init time. As a result, ex=
ecution will be slower.</div><div>&gt; diff --git a/docs/system/target-a=
rm.rst b/docs/system/target-arm.rst</div><div>&gt; index c57102a4149f..e=
34492402f0a 100644</div><div>&gt; --- a/docs/system/target-arm.rst</div>=
<div>&gt; +++ b/docs/system/target-arm.rst</div><div>&gt; @@ -87,7 +87,6=
 @@ Board-specific documentation</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; arm/cubieboard</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arm/em=
craft-sf2</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arm/exynos</div><=
div>&gt; -&nbsp;&nbsp; arm/fby35</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; arm/musicpal</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arm/kzm<=
/div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arm/nrf</div><div>&gt; diff=
 --git a/hw/arm/fby35.c b/hw/arm/fby35.c</div><div>&gt; deleted file mod=
e 100644</div><div>&gt; index d3bfd2c7d26a..000000000000</div><div>&gt; =
--- a/hw/arm/fby35.c</div><div>&gt; +++ /dev/null</div><div>&gt; @@ -1,2=
03 +0,0 @@</div><div>&gt; -/*</div><div>&gt; - * Copyright (c) Meta Plat=
forms, Inc. and affiliates. (<a href=3D"http://www.meta.com">http://www.=
meta.com</a>)</div><div>&gt; - *</div><div>&gt; - * This code is license=
d under the GPL version 2 or later. See the COPYING</div><div>&gt; - * f=
ile in the top-level directory.</div><div>&gt; - */</div><div>&gt; -</di=
v><div>&gt; -#include "qemu/osdep.h"</div><div>&gt; -#include "qemu/unit=
s.h"</div><div>&gt; -#include "qapi/error.h"</div><div>&gt; -#include "s=
ystem/system.h"</div><div>&gt; -#include "system/block-backend.h"</div><=
div>&gt; -#include "hw/core/boards.h"</div><div>&gt; -#include "hw/core/=
qdev-clock.h"</div><div>&gt; -#include "hw/arm/aspeed_soc.h"</div><div>&=
gt; -#include "hw/arm/boot.h"</div><div>&gt; -#include "hw/arm/machines-=
qom.h"</div><div>&gt; -</div><div>&gt; -#define TYPE_FBY35 MACHINE_TYPE_=
NAME("fby35")</div><div>&gt; -OBJECT_DECLARE_SIMPLE_TYPE(Fby35State, FBY=
35);</div><div>&gt; -</div><div>&gt; -struct Fby35State {</div><div>&gt;=
 -&nbsp;&nbsp;&nbsp; MachineState parent_obj;</div><div>&gt; -</div><div=
>&gt; -&nbsp;&nbsp;&nbsp; MemoryRegion bmc_memory;</div><div>&gt; -&nbsp=
;&nbsp;&nbsp; MemoryRegion bmc_dram;</div><div>&gt; -&nbsp;&nbsp;&nbsp; =
MemoryRegion bmc_boot_rom;</div><div>&gt; -&nbsp;&nbsp;&nbsp; MemoryRegi=
on bic_memory;</div><div>&gt; -&nbsp;&nbsp;&nbsp; Clock *bic_sysclk;</di=
v><div>&gt; -</div><div>&gt; -&nbsp;&nbsp;&nbsp; Aspeed2600SoCState bmc;=
</div><div>&gt; -&nbsp;&nbsp;&nbsp; Aspeed10x0SoCState bic;</div><div>&g=
t; -</div><div>&gt; -&nbsp;&nbsp;&nbsp; bool mmio_exec;</div><div>&gt; -=
};</div><div>&gt; -</div><div>&gt; -#define FBY35_BMC_RAM_SIZE (2 * GiB)=
</div><div>&gt; -#define FBY35_BMC_FIRMWARE_ADDR 0x0</div><div>&gt; -</d=
iv><div>&gt; -static void fby35_bmc_write_boot_rom(DriveInfo *dinfo, Mem=
oryRegion *mr,</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwaddr offset, size_t rom_size,</div><di=
v>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Error **errp)</div><div>&gt; -{</div><div>&gt; -&nbsp;&nbsp;&nb=
sp; BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);</div><div>&gt; -&n=
bsp;&nbsp;&nbsp; g_autofree void *storage =3D NULL;</div><div>&gt; -&nbs=
p;&nbsp;&nbsp; int64_t size;</div><div>&gt; -</div><div>&gt; -&nbsp;&nbs=
p;&nbsp; /*</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp; * The block backend=
 size should have already been 'validated' by</div><div>&gt; -&nbsp;&nbs=
p;&nbsp;&nbsp; * the creation of the m25p80 object.</div><div>&gt; -&nbs=
p;&nbsp;&nbsp;&nbsp; */</div><div>&gt; -&nbsp;&nbsp;&nbsp; size =3D blk_=
getlength(blk);</div><div>&gt; -&nbsp;&nbsp;&nbsp; if (size &lt;=3D 0) {=
</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(e=
rrp, "failed to get flash size");</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return;</div><div>&gt; -&nbsp;&nbsp;&nbsp; }</div><=
div>&gt; -</div><div>&gt; -&nbsp;&nbsp;&nbsp; if (rom_size &gt; size) {<=
/div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rom_size =3D =
size;</div><div>&gt; -&nbsp;&nbsp;&nbsp; }</div><div>&gt; -</div><div>&g=
t; -&nbsp;&nbsp;&nbsp; storage =3D g_malloc0(rom_size);</div><div>&gt; -=
&nbsp;&nbsp;&nbsp; if (blk_pread(blk, 0, rom_size, storage, 0) &lt; 0) {=
</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(e=
rrp, "failed to read the initial flash content");</div><div>&gt; -&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;</div><div>&gt; -&nbsp;&nbsp=
;&nbsp; }</div><div>&gt; -</div><div>&gt; -&nbsp;&nbsp;&nbsp; /* TODO: f=
ind a better way to install the ROM */</div><div>&gt; -&nbsp;&nbsp;&nbsp=
; memcpy(memory_region_get_ram_ptr(mr) + offset, storage, rom_size);</di=
v><div>&gt; -}</div><div>&gt; -</div><div>&gt; -static void fby35_bmc_in=
it(Fby35State *s)</div><div>&gt; -{</div><div>&gt; -&nbsp;&nbsp;&nbsp; A=
speedSoCState *soc;</div><div>&gt; -&nbsp;&nbsp;&nbsp; AspeedSoCClass *s=
c;</div><div>&gt; -</div><div>&gt; -&nbsp;&nbsp;&nbsp; object_initialize=
_child(OBJECT(s), "bmc", &amp;s-&gt;bmc, "ast2600-a3");</div><div>&gt; -=
&nbsp;&nbsp;&nbsp; soc =3D ASPEED_SOC(&amp;s-&gt;bmc);</div><div>&gt; -&=
nbsp;&nbsp;&nbsp; sc =3D ASPEED_SOC_GET_CLASS(soc);</div><div>&gt; -</di=
v><div>&gt; -&nbsp;&nbsp;&nbsp; memory_region_init(&amp;s-&gt;bmc_memory=
, OBJECT(&amp;s-&gt;bmc), "bmc-memory",</div><div>&gt; -&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT64_MAX);</div><div>&gt;=
 -&nbsp;&nbsp;&nbsp; memory_region_add_subregion(get_system_memory(), 0,=
 &amp;s-&gt;bmc_memory);</div><div>&gt; -&nbsp;&nbsp;&nbsp; memory_regio=
n_init_ram(&amp;s-&gt;bmc_dram, OBJECT(&amp;s-&gt;bmc), "bmc-dram",</div=
><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; FBY35_BMC_RAM_SIZE, &amp;error_abort);</div><di=
v>&gt; -</div><div>&gt; -&nbsp;&nbsp;&nbsp; object_property_set_int(OBJE=
CT(&amp;s-&gt;bmc), "ram-size", FBY35_BMC_RAM_SIZE,</div><div>&gt; -&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &amp;error_abort);</div><div>&gt; -&nbsp;&nbsp;&nbsp; obj=
ect_property_set_link(OBJECT(&amp;s-&gt;bmc), "memory", OBJECT(&amp;s-&g=
t;bmc_memory),</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;error_abort=
);</div><div>&gt; -&nbsp;&nbsp;&nbsp; object_property_set_link(OBJECT(&a=
mp;s-&gt;bmc), "dram", OBJECT(&amp;s-&gt;bmc_dram),</div><div>&gt; -&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &amp;error_abort);</div><div>&gt; -&nbsp;&nbsp;&nbs=
p; object_property_set_int(OBJECT(&amp;s-&gt;bmc), "hw-strap1", 0x000000=
C0,</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;error_abort);</div><div>&gt;=
 -&nbsp;&nbsp;&nbsp; object_property_set_int(OBJECT(&amp;s-&gt;bmc), "hw=
-strap2", 0x00000003,</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;error_abor=
t);</div><div>&gt; -&nbsp;&nbsp;&nbsp; aspeed_soc_uart_set_chr(soc-&gt;u=
art, ASPEED_DEV_UART5, sc-&gt;uarts_base,</div><div>&gt; -&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sc-&gt;uarts_num, serial_hd(0));</div><div>&gt; -&nbsp;&nbsp;&nbsp;=
 qdev_realize(DEVICE(&amp;s-&gt;bmc), NULL, &amp;error_abort);</div><div=
>&gt; -</div><div>&gt; -&nbsp;&nbsp;&nbsp; aspeed_board_init_flashes(&am=
p;soc-&gt;fmc, "n25q00", 2, 0);</div><div>&gt; -</div><div>&gt; -&nbsp;&=
nbsp;&nbsp; /* Install first FMC flash content as a boot rom. */</div><d=
iv>&gt; -&nbsp;&nbsp;&nbsp; if (!s-&gt;mmio_exec) {</div><div>&gt; -&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DriveInfo *mtd0 =3D drive_get(IF_=
MTD, 0, 0);</div><div>&gt; -</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (mtd0) {</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t rom_size =3D memory_regi=
on_size(&amp;soc-&gt;spi_boot);</div><div>&gt; -</div><div>&gt; -&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memory_regio=
n_init_rom(&amp;s-&gt;bmc_boot_rom, NULL, "aspeed.boot_rom",</div><div>&=
gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rom_si=
ze, &amp;error_abort);</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memory_region_add_subregion_overlap(&a=
mp;soc-&gt;spi_boot_container, 0,</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;s-&gt;bmc_boot_rom, 1)=
;</div><div>&gt; -</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fby35_bmc_write_boot_rom(mtd0, &amp;s-&gt;=
bmc_boot_rom,</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FBY35_BMC_FIRMWARE_ADDR,</div><div>&gt; -=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 rom_size, &amp;error_abort);</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }</div><div>&gt; -&nbsp;&nbsp;&nbsp; }</div><div>&gt; -=
}</div><div>&gt; -</div><div>&gt; -static void fby35_bic_init(Fby35State=
 *s)</div><div>&gt; -{</div><div>&gt; -&nbsp;&nbsp;&nbsp; AspeedSoCState=
 *soc;</div><div>&gt; -&nbsp;&nbsp;&nbsp; AspeedSoCClass *sc;</div><div>=
&gt; -</div><div>&gt; -&nbsp;&nbsp;&nbsp; s-&gt;bic_sysclk =3D clock_new=
(OBJECT(s), "SYSCLK");</div><div>&gt; -&nbsp;&nbsp;&nbsp; clock_set_hz(s=
-&gt;bic_sysclk, 200000000ULL);</div><div>&gt; -</div><div>&gt; -&nbsp;&=
nbsp;&nbsp; object_initialize_child(OBJECT(s), "bic", &amp;s-&gt;bic, "a=
st1030-a1");</div><div>&gt; -&nbsp;&nbsp;&nbsp; soc =3D ASPEED_SOC(&amp;=
s-&gt;bic);</div><div>&gt; -&nbsp;&nbsp;&nbsp; sc =3D ASPEED_SOC_GET_CLA=
SS(soc);</div><div>&gt; -</div><div>&gt; -&nbsp;&nbsp;&nbsp; memory_regi=
on_init(&amp;s-&gt;bic_memory, OBJECT(&amp;s-&gt;bic), "bic-memory",</di=
v><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; UINT64_MAX);</div><div>&gt; -</div><div>&gt; -&nbsp;&nbsp;&nbsp; qdev_=
connect_clock_in(DEVICE(&amp;s-&gt;bic), "sysclk", s-&gt;bic_sysclk);</d=
iv><div>&gt; -&nbsp;&nbsp;&nbsp; object_property_set_link(OBJECT(&amp;s-=
&gt;bic), "memory", OBJECT(&amp;s-&gt;bic_memory),</div><div>&gt; -&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;error_abort);</div><div>&gt; -&nbsp;&nbsp;&nbsp=
; aspeed_soc_uart_set_chr(soc-&gt;uart, ASPEED_DEV_UART5, sc-&gt;uarts_b=
ase,</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sc-&gt;uarts_num, serial_hd(1));=
</div><div>&gt; -&nbsp;&nbsp;&nbsp; qdev_realize(DEVICE(&amp;s-&gt;bic),=
 NULL, &amp;error_abort);</div><div>&gt; -</div><div>&gt; -&nbsp;&nbsp;&=
nbsp; aspeed_board_init_flashes(&amp;soc-&gt;fmc, "sst25vf032b", 2, 2);<=
/div><div>&gt; -&nbsp;&nbsp;&nbsp; aspeed_board_init_flashes(&amp;soc-&g=
t;spi[0], "sst25vf032b", 2, 4);</div><div>&gt; -&nbsp;&nbsp;&nbsp; aspee=
d_board_init_flashes(&amp;soc-&gt;spi[1], "sst25vf032b", 2, 6);</div><di=
v>&gt; -}</div><div>&gt; -</div><div>&gt; -static void fby35_init(Machin=
eState *machine)</div><div>&gt; -{</div><div>&gt; -&nbsp;&nbsp;&nbsp; Fb=
y35State *s =3D FBY35(machine);</div><div>&gt; -</div><div>&gt; -&nbsp;&=
nbsp;&nbsp; fby35_bmc_init(s);</div><div>&gt; -&nbsp;&nbsp;&nbsp; fby35_=
bic_init(s);</div><div>&gt; -}</div><div>&gt; -</div><div>&gt; -</div><d=
iv>&gt; -static bool fby35_get_mmio_exec(Object *obj, Error **errp)</div=
><div>&gt; -{</div><div>&gt; -&nbsp;&nbsp;&nbsp; return FBY35(obj)-&gt;m=
mio_exec;</div><div>&gt; -}</div><div>&gt; -</div><div>&gt; -static void=
 fby35_set_mmio_exec(Object *obj, bool value, Error **errp)</div><div>&g=
t; -{</div><div>&gt; -&nbsp;&nbsp;&nbsp; FBY35(obj)-&gt;mmio_exec =3D va=
lue;</div><div>&gt; -}</div><div>&gt; -</div><div>&gt; -static void fby3=
5_instance_init(Object *obj)</div><div>&gt; -{</div><div>&gt; -&nbsp;&nb=
sp;&nbsp; FBY35(obj)-&gt;mmio_exec =3D false;</div><div>&gt; -}</div><di=
v>&gt; -</div><div>&gt; -static void fby35_class_init(ObjectClass *oc, c=
onst void *data)</div><div>&gt; -{</div><div>&gt; -&nbsp;&nbsp;&nbsp; Ma=
chineClass *mc =3D MACHINE_CLASS(oc);</div><div>&gt; -</div><div>&gt; -&=
nbsp;&nbsp;&nbsp; mc-&gt;desc =3D "Meta Platforms fby35";</div><div>&gt;=
 -&nbsp;&nbsp;&nbsp; mc-&gt;deprecation_reason =3D "For a multi-soc mach=
ine, use 'ast2700fc' instead";</div><div>&gt; -&nbsp;&nbsp;&nbsp; mc-&gt=
;init =3D fby35_init;</div><div>&gt; -&nbsp;&nbsp;&nbsp; mc-&gt;no_flopp=
y =3D 1;</div><div>&gt; -&nbsp;&nbsp;&nbsp; mc-&gt;no_cdrom =3D 1;</div>=
<div>&gt; -&nbsp;&nbsp;&nbsp; mc-&gt;auto_create_sdcard =3D true;</div><=
div>&gt; -&nbsp;&nbsp;&nbsp; mc-&gt;min_cpus =3D mc-&gt;max_cpus =3D mc-=
&gt;default_cpus =3D 3;</div><div>&gt; -</div><div>&gt; -&nbsp;&nbsp;&nb=
sp; object_class_property_add_bool(oc, "execute-in-place",</div><div>&gt=
; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fby35_ge=
t_mmio_exec,</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; fby35_set_mmio_exec);</div><div>&gt; -&nbsp;&nbsp;&nbs=
p; object_class_property_set_description(oc, "execute-in-place",</div><d=
iv>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; "boot directly from CE0 flash device");</div><div>=
&gt; -}</div><div>&gt; -</div><div>&gt; -static const TypeInfo fby35_typ=
es[] =3D {</div><div>&gt; -&nbsp;&nbsp;&nbsp; {</div><div>&gt; -&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D MACHINE_TYPE_NAME("fby35"),=
</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .parent =3D =
TYPE_MACHINE,</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 .class_init =3D fby35_class_init,</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .instance_size =3D sizeof(Fby35State),</div><div>&=
gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .instance_init =3D fby35=
_instance_init,</div><div>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; .interfaces =3D arm_machine_interfaces,</div><div>&gt; -&nbsp;&nbsp;&=
nbsp; },</div><div>&gt; -};</div><div>&gt; -</div><div>&gt; -DEFINE_TYPE=
S(fby35_types);</div><div>&gt; diff --git a/hw/arm/meson.build b/hw/arm/=
meson.build</div><div>&gt; index 063abf2cf654..80068f70bb9c 100644</div>=
<div>&gt; --- a/hw/arm/meson.build</div><div>&gt; +++ b/hw/arm/meson.bui=
ld</div><div>&gt; @@ -62,8 +62,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC'=
, if_true: files(</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 'aspeed_ast2600=
_gb200nvl.c',</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 'aspeed_ast2600_rai=
nier.c',</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 'aspeed_ast10x0.c',</div=
><div>&gt; -&nbsp; 'aspeed_ast10x0_evb.c',</div><div>&gt; -&nbsp; 'fby35=
.c'))</div><div>&gt; +&nbsp; 'aspeed_ast10x0_evb.c'))</div><div>&gt;&nbs=
p;&nbsp; arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64']=
, if_true: files(</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 'aspeed_ast1700=
.c',</div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 'aspeed_ast27x0.c',</div><di=
v><br></div><div><br></div></blockquote><div><br></div></body></html>
--2816ebfb3089dc722450d6011dd5e3eb2c81c35e--

