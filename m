Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE32CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBqVs-0007xP-Bw; Wed, 30 Sep 2026 05:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7264c68bd=Conor.Dooley@microchip.com>)
 id 1xBqVq-0007xC-Pt; Wed, 30 Sep 2026 05:22:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7264c68bd=Conor.Dooley@microchip.com>)
 id 1xBqVo-0005Wp-9X; Wed, 30 Sep 2026 05:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1790760129; x=1822296129;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1s6iiEDwHUewvAKDqCXOKXZw9ghp1BXQVwEHNqpBDSk=;
 b=sRSbfuXqyNJWQpTEcTbIML+bJIV5q/qZVHayarIrGWq0Q0IQ6hVz+WAh
 oXdGMBs1rcMmX7yPUJYGC9c9vJnfA+5ZZgFsf8HRfU2XXjtvvOTFRACQp
 VwlMXnABxh2oevOHQAIgasndYFNGVAoLVU86XCPuTXxwOvrAK8J+EImrG
 1/+ZXu3TM6tuR9xATvI48rdeYy6KBiJsGMqI9abOFYwTcgDVSsoWgjI4t
 K0nG2Ja6t3I1DXpLxKG/xN8x8JrAfnAzWfLEA7IMWdOKH1GHbsTYqNc4J
 LQbF2hbNEx0M14Px8zB7GJ0fI6JxL7frYOPiyQVORQprrN8OyhcwhHumz A==;
X-CSE-ConnectionGUID: uLPlHziYRrSIOrjwDmPEzQ==
X-CSE-MsgGUID: DfEJeoCuRwWFQhLaGHKeMg==
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
 d="asc'?scan'208";a="64658238"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 02:22:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 30 Sep 2026 02:22:01 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Wed, 30 Sep 2026 02:21:59 -0700
Date: Wed, 30 Sep 2026 10:20:40 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Bin Meng <bin.meng@processmission.com>
CC: QEMU <qemu-devel@nongnu.org>, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, Weiwei Li
 <liwei1518@gmail.com>, <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 16/24] hw/misc: pfsoc: Honor PolarFire service
 notification requests
Message-ID: <20260930-stapling-pajamas-0b49d92348dd@wendy>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <20260904155758.3833179-17-bin.meng@processmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2fu0j6JvtvFrnXo+"
Content-Disposition: inline
In-Reply-To: <20260904155758.3833179-17-bin.meng@processmission.com>
Received-SPF: pass client-ip=68.232.154.123;
 envelope-from=prvs=7264c68bd=Conor.Dooley@microchip.com;
 helo=esa.microchip.iphmx.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

--2fu0j6JvtvFrnXo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2026 at 11:57:35PM +0800, Bin Meng wrote:
> Polling firmware requests system services without requesting an
> interrupt. The old model ignored this distinction:
>=20
> 1. HSS requests the serial number with REQUEST set and NOTIFY clear.
> 2. QEMU synchronously fills the mailbox and clears REQUEST.
> 3. QEMU incorrectly asserts PLIC source 96.
> 4. HSS polls REQUEST and neither waits for nor handles the interrupt.
> 5. PLIC source 96 remains pending.
> 6. Linux registers the MPFS mailbox driver.
> 7. The stale interrupt immediately enters mpfs_mbox_inbox_isr().
> 8. Linux has not submitted a request or installed its response pointer.
> 9. The ISR dereferences that null pointer and faults near address 0x10.

This makes sense, and should probably have a fixes tag pointing to my
2022 commit? Since I was direct kernel booting, I would never had
noticed anything of this nature.

> Honor SERVICES_CR.NOTIFY, let IOSCB own the pending interrupt state,
> and route the SYSREG acknowledgement through an IOSCB clear input.
>=20
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> ---
>=20
> (no changes since v1)
>=20
>  include/hw/misc/mchp_pfsoc_ioscb.h |  2 ++
>  hw/misc/mchp_pfsoc_ioscb.c         | 39 +++++++++++++++++++++++++++---
>  hw/misc/mchp_pfsoc_sysreg.c        |  9 ++++++-
>  hw/riscv/microchip_pfsoc.c         |  6 ++---
>  4 files changed, 49 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pf=
soc_ioscb.h
> index fd31427304..e39d995b64 100644
> --- a/include/hw/misc/mchp_pfsoc_ioscb.h
> +++ b/include/hw/misc/mchp_pfsoc_ioscb.h
> @@ -26,6 +26,7 @@
>  #include "hw/core/sysbus.h"
> =20
>  #define MCHP_PFSOC_IOSCB_MAILBOX_SIZE 0x1000
> +#define MCHP_PFSOC_IOSCB_IRQ_CLEAR "irq-clear"
> =20
>  typedef struct MchpPfSoCIoscbState {
>      SysBusDevice parent;
> @@ -53,6 +54,7 @@ typedef struct MchpPfSoCIoscbState {
>      uint32_t services_sr;
>      uint8_t mailbox_data[MCHP_PFSOC_IOSCB_MAILBOX_SIZE];
>      char *serial_number;
> +    bool irq_pending;
>      qemu_irq irq;
>  } MchpPfSoCIoscbState;
> =20
> diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
> index 7c82b55986..ccc2201b7a 100644
> --- a/hw/misc/mchp_pfsoc_ioscb.c
> +++ b/hw/misc/mchp_pfsoc_ioscb.c
> @@ -192,12 +192,13 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_dd=
r_ops =3D {
> =20
>  #define SERVICES_CR                         0x50
>  #define SERVICES_CR_REQUEST                 BIT(0)
> +#define SERVICES_CR_NOTIFY                  BIT(3)
>  #define SERVICES_CR_COMMAND_SHIFT           16
>  #define SERVICES_CR_COMMAND_WIDTH           8
>  #define SERVICES_CR_COMMAND_MASK            \
>          MAKE_64BIT_MASK(SERVICES_CR_COMMAND_SHIFT, SERVICES_CR_COMMAND_W=
IDTH)
>  #define SERVICES_CR_MASK                    \
> -        (SERVICES_CR_REQUEST | SERVICES_CR_COMMAND_MASK)
> +        (SERVICES_CR_REQUEST | SERVICES_CR_NOTIFY | SERVICES_CR_COMMAND_=
MASK)
>  #define SERVICES_SR                         0x54
>  #define SERVICES_SR_STATUS_SHIFT            16
>  #define SERVICES_COMMAND_SERIAL_NUMBER      0
> @@ -205,6 +206,21 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_ddr=
_ops =3D {
>  #define SERVICES_STATUS_FAILED              1
>  #define SERVICES_MAILBOX_RESPONSE_OFFSET    0
> =20
> +static void mchp_pfsoc_ioscb_update_irq(MchpPfSoCIoscbState *s)
> +{
> +    qemu_set_irq(s->irq, s->irq_pending);
> +}
> +
> +static void mchp_pfsoc_ioscb_clear_irq(void *opaque, int n, int level)
> +{
> +    MchpPfSoCIoscbState *s =3D opaque;
> +
> +    if (level) {
> +        s->irq_pending =3D false;
> +        mchp_pfsoc_ioscb_update_irq(s);
> +    }
> +}
> +
>  static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
>  {
>      uint32_t command;
> @@ -236,7 +252,15 @@ static void services_cr_write(MchpPfSoCIoscbState *s=
, uint32_t value)
>      }
> =20
>      s->services_sr =3D status << SERVICES_SR_STATUS_SHIFT;
> -    qemu_irq_raise(s->irq);
> +    /*
> +     * HSS and U-Boot submit polling requests with REQUEST set and NOTIFY
> +     * clear, then poll REQUEST/BUSY for completion. Linux sets both bits
> +     * and expects completion through PLIC source 96.
> +     */
> +    if (value & SERVICES_CR_NOTIFY) {
> +        s->irq_pending =3D true;
> +        mchp_pfsoc_ioscb_update_irq(s);
> +    }
>  }
> =20
>  static uint64_t mchp_pfsoc_ctrl_read(void *opaque, hwaddr offset,
> @@ -325,7 +349,8 @@ static void mchp_pfsoc_ioscb_reset(DeviceState *dev)
>      s->services_cr =3D 0;
>      s->services_sr =3D 0;
>      memset(s->mailbox_data, 0, sizeof(s->mailbox_data));
> -    qemu_irq_lower(s->irq);
> +    s->irq_pending =3D false;
> +    mchp_pfsoc_ioscb_update_irq(s);
>  }
> =20
>  static const Property mchp_pfsoc_ioscb_properties[] =3D {
> @@ -333,6 +358,13 @@ static const Property mchp_pfsoc_ioscb_properties[] =
=3D {
>                         MchpPfSoCIoscbState, serial_number),
>  };
> =20
> +static void mchp_pfsoc_ioscb_init(Object *obj)
> +{
> +    /* Accept service interrupt acknowledgements from SYSREG MESSAGE_INT=
 */
> +    qdev_init_gpio_in_named(DEVICE(obj), mchp_pfsoc_ioscb_clear_irq,
> +                            MCHP_PFSOC_IOSCB_IRQ_CLEAR, 1);
> +}
> +
>  static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
>  {
>      MchpPfSoCIoscbState *s =3D MCHP_PFSOC_IOSCB(dev);
> @@ -456,6 +488,7 @@ static const TypeInfo mchp_pfsoc_ioscb_info =3D {
>      .name          =3D TYPE_MCHP_PFSOC_IOSCB,
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(MchpPfSoCIoscbState),
> +    .instance_init =3D mchp_pfsoc_ioscb_init,
>      .class_init    =3D mchp_pfsoc_ioscb_class_init,
>  };
> =20
> diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
> index 1d9154280a..899b485da6 100644
> --- a/hw/misc/mchp_pfsoc_sysreg.c
> +++ b/hw/misc/mchp_pfsoc_sysreg.c
> @@ -77,7 +77,14 @@ static void mchp_pfsoc_sysreg_write(void *opaque, hwad=
dr offset,
>          }
>          break;
>      case MESSAGE_INT:
> -        qemu_irq_lower(s->irq);
> +        /*
> +         * A MESSAGE_INT write is an acknowledgement event, not a level =
that
> +         * remains asserted. Model it as an active-high pulse. The risin=
g edge

I found this comment to be really confusing. Why would someone expect
that a write-zero-clear bit is an asserted level? Mentioning modelling
it as a pulse further makes it seem like software writing will generate an
interrupt, which it doesn't - it writes here to clear the interrupt. I
think this needs to be very clear that modelling this as an interrupt at
all is just being done for QEMU's sake.

I think this needs to be split in two, with the fix for the problem
(which I think is limited to only raising the interrupt) kept apart from
this change. Part of that is because I don't actually understand the
reason for adding this "fake" interrupt and the commit message is
currently focused around the bug and doesn't actually provide
justification for it. Maybe it's obvious to people more familiar with
Qemu than I, but this complication makes no sense to me!

> +         * invokes IOSCB's irq-clear input with level 1, which clears
> +         * irq_pending and lowers PLIC source 96. The falling edge invok=
es the
> +         * input with level 0 and is ignored.
> +         */
> +        qemu_irq_pulse(s->irq);
>          break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index fb0e18edba..87c9c89cb0 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -336,9 +336,6 @@ static void microchip_pfsoc_soc_realize(DeviceState *=
dev, Error **errp)
>      sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), errp);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysreg), 0,
>                      memmap[MICROCHIP_PFSOC_SYSREG].base);
> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sysreg), 0,
> -                       qdev_get_gpio_in(DEVICE(s->plic),
> -                       MICROCHIP_PFSOC_MAILBOX_IRQ));
> =20
>      /* AXISW */
>      create_unimplemented_device("microchip.pfsoc.axisw",
> @@ -492,6 +489,9 @@ static void microchip_pfsoc_soc_realize(DeviceState *=
dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioscb), 0,
>                         qdev_get_gpio_in(DEVICE(s->plic),
>                         MICROCHIP_PFSOC_MAILBOX_IRQ));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sysreg), 0,
> +        qdev_get_gpio_in_named(DEVICE(&s->ioscb),
> +                               MCHP_PFSOC_IOSCB_IRQ_CLEAR, 0));
> =20
>      /* FPGA Fabric */
>      create_unimplemented_device("microchip.pfsoc.fabricfic3",
> --=20
> 2.53.0
>=20
>=20

--2fu0j6JvtvFrnXo+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarzUaAAKCRB4tDGHoIJi
0oB/AP0a3qtXV8dcnDDGc5mMFy37ZgtBkjVkKlkYH6HTqwDRfQD9FjEoC8bLLv5+
v3EV6gfCORuf7LluR3fcpx+F/T6uxw4=
=xX/Q
-----END PGP SIGNATURE-----

--2fu0j6JvtvFrnXo+--

