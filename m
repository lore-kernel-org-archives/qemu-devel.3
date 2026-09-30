Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5198ECA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBpnU-0001bh-Kd; Wed, 30 Sep 2026 04:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7264c68bd=Conor.Dooley@microchip.com>)
 id 1xBpnN-0001bH-FY; Wed, 30 Sep 2026 04:36:11 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7264c68bd=Conor.Dooley@microchip.com>)
 id 1xBpnJ-0001BI-Q1; Wed, 30 Sep 2026 04:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1790757371; x=1822293371;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=QR0i+XtVua+1TQNXBBPG4sti4dk0yxtLN7ubZoTFKFk=;
 b=L0EXcLIsTwG0zF/0n13OShXjtedZpueuNLYLtzksSF4/RNzc4OHGc98d
 uOFLuN2k58cYDGFA1t9/YAXarrg5E+fF1LlkmQRY5twq92GtPv5XOStoi
 CH0TDKV9cYLYewh7gAFdDZ1EqoUEN6RQhe61gqotBfSJEm4SkFxPCide2
 +WU/giy4yMnE7zGoCUY7AAe/pqBwHl/JG88p9Y4PFbUk4atJZlkXiWAjY
 O2o+bE3bwZec+Ao2k0FPN/wJzmTa3bxin/MsIjwiGXzwl23QceSJ7UGd2
 O5klWxDPr7aKPZS31J9WiNKY0FJupLoHKCPTTBly2w4GWDIBwYgVcj0Dj w==;
X-CSE-ConnectionGUID: 8erKCFyARAe4TVXE7vXfoQ==
X-CSE-MsgGUID: dlIaA2OXT5eKryd5sxRFGw==
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
 d="asc'?scan'208";a="64656054"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 01:36:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 30 Sep 2026 01:36:01 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Wed, 30 Sep 2026 01:36:00 -0700
Date: Wed, 30 Sep 2026 09:34:41 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Bin Meng <bin.meng@processmission.com>
CC: QEMU <qemu-devel@nongnu.org>, Conor Dooley <conor@kernel.org>, Sebastian
 Huber <sebastian.huber@embedded-brains.de>, <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 12/24] hw/misc: pfsoc: Model PolarFire SoC serial
 number service
Message-ID: <20260930-attitude-dragging-9c89c9c27c5b@wendy>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <20260904155758.3833179-13-bin.meng@processmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IuWrzff9L5xvEMEC"
Content-Disposition: inline
In-Reply-To: <20260904155758.3833179-13-bin.meng@processmission.com>
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

--IuWrzff9L5xvEMEC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2026 at 11:57:31PM +0800, Bin Meng wrote:
> U-Boot requests the PolarFire SoC device serial number during board
> late initialization. The IOSCB previously rejected every request, so

This is kinda crazy actually, we probably should change u-boot to not do
this since the reason for acquiring the serial number is populating the
mac address.
I guess it just never actually ever is problematic in hardware, but it
does seem a bit mad to reject boot over.

> board setup could not complete.
>=20
> Model the System Services control registers and byte-addressable
> mailbox. Obtain the 128-bit serial number from an optional device
> property, using a deterministic value when it is not configured.
> Return an explicit failure for unsupported services and reset the new
> runtime state with the rest of the device.
>=20
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
>=20
> (no changes since v1)
>=20
>  include/hw/misc/mchp_pfsoc_ioscb.h |   6 ++
>  hw/misc/mchp_pfsoc_ioscb.c         | 141 +++++++++++++++++++++++++----
>  2 files changed, 130 insertions(+), 17 deletions(-)
>=20
> diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pf=
soc_ioscb.h
> index 9687ea25b1..fd31427304 100644
> --- a/include/hw/misc/mchp_pfsoc_ioscb.h
> +++ b/include/hw/misc/mchp_pfsoc_ioscb.h
> @@ -25,6 +25,8 @@
> =20
>  #include "hw/core/sysbus.h"
> =20
> +#define MCHP_PFSOC_IOSCB_MAILBOX_SIZE 0x1000
> +
>  typedef struct MchpPfSoCIoscbState {
>      SysBusDevice parent;
>      MemoryRegion container;
> @@ -47,6 +49,10 @@ typedef struct MchpPfSoCIoscbState {
>      MemoryRegion cfm_sgmii;
>      MemoryRegion bc_sgmii;
>      MemoryRegion io_calib_sgmii;
> +    uint32_t services_cr;
> +    uint32_t services_sr;
> +    uint8_t mailbox_data[MCHP_PFSOC_IOSCB_MAILBOX_SIZE];
> +    char *serial_number;
>      qemu_irq irq;
>  } MchpPfSoCIoscbState;
> =20
> diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
> index 09b702e520..7c82b55986 100644
> --- a/hw/misc/mchp_pfsoc_ioscb.c
> +++ b/hw/misc/mchp_pfsoc_ioscb.c
> @@ -25,6 +25,7 @@
>  #include "qemu/log.h"
>  #include "qapi/error.h"
>  #include "hw/core/irq.h"
> +#include "hw/core/qdev-properties.h"
>  #include "hw/core/sysbus.h"
>  #include "hw/misc/mchp_pfsoc_ioscb.h"
> =20
> @@ -37,6 +38,9 @@
>  #define IOSCB_CCC_REG_SIZE          0x2000000
>  #define IOSCB_CTRL_REG_SIZE         0x800
>  #define IOSCB_QSPIXIP_REG_SIZE      0x200
> +#define IOSCB_SERIAL_NUMBER_SIZE    16U
> +#define IOSCB_DEFAULT_SERIAL_NUMBER "0123456789abcdef"
> +#define IOSCB_PROP_SERIAL_NUMBER    "serial-number"
> =20
> =20
>  /*
> @@ -186,33 +190,71 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_dd=
r_ops =3D {
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
> =20
> -#define SERVICES_CR             0x50
> -#define SERVICES_SR             0x54
> -#define SERVICES_STATUS_SHIFT   16
> +#define SERVICES_CR                         0x50
> +#define SERVICES_CR_REQUEST                 BIT(0)
> +#define SERVICES_CR_COMMAND_SHIFT           16
> +#define SERVICES_CR_COMMAND_WIDTH           8

This I think should actually be 7.

> +#define SERVICES_CR_COMMAND_MASK            \
> +        MAKE_64BIT_MASK(SERVICES_CR_COMMAND_SHIFT, SERVICES_CR_COMMAND_W=
IDTH)
> +#define SERVICES_CR_MASK                    \
> +        (SERVICES_CR_REQUEST | SERVICES_CR_COMMAND_MASK)
> +#define SERVICES_SR                         0x54
> +#define SERVICES_SR_STATUS_SHIFT            16
> +#define SERVICES_COMMAND_SERIAL_NUMBER      0
> +#define SERVICES_STATUS_SUCCESS             0
> +#define SERVICES_STATUS_FAILED              1
> +#define SERVICES_MAILBOX_RESPONSE_OFFSET    0
> +
> +static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
> +{
> +    uint32_t command;
> +    uint32_t status =3D SERVICES_STATUS_FAILED;
> +
> +    if (device_is_in_reset(DEVICE(s)) ||
> +        !(value & SERVICES_CR_REQUEST)) {
> +        return;
> +    }
> +
> +    /*
> +     * System services complete synchronously in this model, so clear the
> +     * request bit before exposing the response to the guest.
> +     */
> +    s->services_cr &=3D ~SERVICES_CR_REQUEST;
> +
> +    command =3D (value & SERVICES_CR_COMMAND_MASK) >>
> +              SERVICES_CR_COMMAND_SHIFT;
> +    if (command =3D=3D SERVICES_COMMAND_SERIAL_NUMBER) {
> +        /*
> +         * The serial-number service returns a 128-bit response starting=
 at
> +         * the beginning of the mailbox.

That's not actually strictly true, bits 15:7 of the command actually
determine the location in the mailbox. I'm not actually aware of any users
of this feature, Linux and U-Boot both leave this at 0, so it doesn't really
matter for functionality, but the comment is wrong.
See section 3 of the document in the comment you're removing below for
how this works.

> +         */
> +        memset(&s->mailbox_data[SERVICES_MAILBOX_RESPONSE_OFFSET], 0,
> +               IOSCB_SERIAL_NUMBER_SIZE);
> +        memcpy(&s->mailbox_data[SERVICES_MAILBOX_RESPONSE_OFFSET],
> +               s->serial_number, strlen(s->serial_number));
> +        status =3D SERVICES_STATUS_SUCCESS;
> +    }
> +
> +    s->services_sr =3D status << SERVICES_SR_STATUS_SHIFT;
> +    qemu_irq_raise(s->irq);
> +}
> =20
>  static uint64_t mchp_pfsoc_ctrl_read(void *opaque, hwaddr offset,
>                                       unsigned size)
>  {
> -    uint32_t val =3D 0;
> +    MchpPfSoCIoscbState *s =3D opaque;
> =20
>      switch (offset) {
> +    case SERVICES_CR:
> +        return s->services_cr;
>      case SERVICES_SR:
> -        /*
> -         * Although some services have no error codes, most do. All serv=
ices
> -         * that do implement errors, begin their error codes at 1. Treat=
 all
> -         * service requests as failures & return 1.
> -         * See the "PolarFire=AE FPGA and PolarFire SoC FPGA System Serv=
ices"
		       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> -         * user guide for more information on service error codes.
> -         */
> -        val =3D 1u << SERVICES_STATUS_SHIFT;
> -        break;
> +        return s->services_sr;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
>                        "(size %d, offset 0x%" HWADDR_PRIx ")\n",
>                        __func__, size, offset);
> +        return 0;
>      }
> -
> -    return val;
>  }
> =20
>  static void mchp_pfsoc_ctrl_write(void *opaque, hwaddr offset,
> @@ -222,13 +264,17 @@ static void mchp_pfsoc_ctrl_write(void *opaque, hwa=
ddr offset,
> =20
>      switch (offset) {
>      case SERVICES_CR:
> -        qemu_irq_raise(s->irq);
> +        s->services_cr =3D value & SERVICES_CR_MASK;
> +        services_cr_write(s, value);
> +        break;
> +    case SERVICES_SR:
>          break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
>                        "(size %d, value 0x%" PRIx64
>                        ", offset 0x%" HWADDR_PRIx ")\n",
>                        __func__, size, value, offset);
> +        break;
>      }
>  }
> =20
> @@ -236,6 +282,55 @@ static const MemoryRegionOps mchp_pfsoc_ctrl_ops =3D=
 {
>      .read =3D mchp_pfsoc_ctrl_read,
>      .write =3D mchp_pfsoc_ctrl_write,
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D sizeof(uint32_t),

I'm not au fait enough with qemu to know, but does this mean that
accessing these registers with an 8 or 16 bit accessor will fail
somehow?
If so, that's not how the hardware behaves, and below...

> +        .max_access_size =3D sizeof(uint32_t),
> +    },
> +};
> +
> +/*
> + * The System Controller uses the mailbox as a byte-addressable shared b=
uffer
> + * for service command payloads and responses.
> + */
> +static uint64_t mchp_pfsoc_mailbox_read(void *opaque, hwaddr offset,
> +                                        unsigned size)
> +{
> +    MchpPfSoCIoscbState *s =3D opaque;
> +
> +    return ldn_le_p(&s->mailbox_data[offset], size);
> +}
> +
> +static void mchp_pfsoc_mailbox_write(void *opaque, hwaddr offset,
> +                                     uint64_t value, unsigned size)
> +{
> +    MchpPfSoCIoscbState *s =3D opaque;
> +
> +    stn_le_p(&s->mailbox_data[offset], size, value);
> +}
> +
> +static const MemoryRegionOps mchp_pfsoc_mailbox_ops =3D {
> +    .read =3D mchp_pfsoc_mailbox_read,
> +    .write =3D mchp_pfsoc_mailbox_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D sizeof(uint8_t),

=2E..you have the more expected 8.

> +        .max_access_size =3D sizeof(uint32_t),
> +    },
> +};
> +
> +static void mchp_pfsoc_ioscb_reset(DeviceState *dev)
> +{
> +    MchpPfSoCIoscbState *s =3D MCHP_PFSOC_IOSCB(dev);
> +
> +    s->services_cr =3D 0;
> +    s->services_sr =3D 0;
> +    memset(s->mailbox_data, 0, sizeof(s->mailbox_data));
> +    qemu_irq_lower(s->irq);
> +}
> +
> +static const Property mchp_pfsoc_ioscb_properties[] =3D {
> +    DEFINE_PROP_STRING(IOSCB_PROP_SERIAL_NUMBER,
> +                       MchpPfSoCIoscbState, serial_number),
>  };
> =20
>  static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
> @@ -243,6 +338,16 @@ static void mchp_pfsoc_ioscb_realize(DeviceState *de=
v, Error **errp)
>      MchpPfSoCIoscbState *s =3D MCHP_PFSOC_IOSCB(dev);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> =20
> +    /* Use a deterministic identity when no serial number is configured =
*/
> +    if (!s->serial_number) {
> +        s->serial_number =3D g_strdup(IOSCB_DEFAULT_SERIAL_NUMBER);
> +    }
> +    if (strlen(s->serial_number) > IOSCB_SERIAL_NUMBER_SIZE) {
> +        error_setg(errp, "The serial number can't be longer than %u byte=
s",
> +                   IOSCB_SERIAL_NUMBER_SIZE);
> +        return;
> +    }
> +
>      memory_region_init(&s->container, OBJECT(s),
>                         "mchp.pfsoc.ioscb", IOSCB_WHOLE_REG_SIZE);
>      sysbus_init_mmio(sbd, &s->container);
> @@ -265,7 +370,7 @@ static void mchp_pfsoc_ioscb_realize(DeviceState *dev=
, Error **errp)
>                            "mchp.pfsoc.ioscb.qspixip", IOSCB_QSPIXIP_REG_=
SIZE);
>      memory_region_add_subregion(&s->container, IOSCB_QSPIXIP_BASE, &s->q=
spixip);
> =20
> -    memory_region_init_io(&s->mailbox, OBJECT(s), &mchp_pfsoc_dummy_ops,=
 s,
> +    memory_region_init_io(&s->mailbox, OBJECT(s), &mchp_pfsoc_mailbox_op=
s, s,
>                            "mchp.pfsoc.ioscb.mailbox", IOSCB_SUBMOD_REG_S=
IZE);
>      memory_region_add_subregion(&s->container, IOSCB_MAILBOX_BASE, &s->m=
ailbox);
> =20
> @@ -343,6 +448,8 @@ static void mchp_pfsoc_ioscb_class_init(ObjectClass *=
klass, const void *data)
> =20
>      dc->desc =3D "Microchip PolarFire SoC IOSCB modules";
>      dc->realize =3D mchp_pfsoc_ioscb_realize;
> +    device_class_set_legacy_reset(dc, mchp_pfsoc_ioscb_reset);
> +    device_class_set_props(dc, mchp_pfsoc_ioscb_properties);
>  }
> =20
>  static const TypeInfo mchp_pfsoc_ioscb_info =3D {
> --=20
> 2.53.0
>=20
>=20

--IuWrzff9L5xvEMEC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarzJoQAKCRB4tDGHoIJi
0nPnAQDgjM6SrPFrHMGDwQyihgghgWIsxLOFzzrgkf41jGXG+gEAnALcOUkteMCP
LTO8MPqiNJGcUz1Z87j5PePZUuLPswQ=
=RKQ4
-----END PGP SIGNATURE-----

--IuWrzff9L5xvEMEC--

