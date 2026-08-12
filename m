Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA30C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCbZ-0001eB-Nb; Wed, 12 Aug 2026 13:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuCaF-0000H6-3T; Wed, 12 Aug 2026 13:17:44 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuCaC-0000xP-Ql; Wed, 12 Aug 2026 13:17:42 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E468F14000A2;
 Wed, 12 Aug 2026 13:17:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 12 Aug 2026 13:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786555059; x=1786641459; bh=yS9diBy5il9B/DYHRIMjCVVbNXaO8HI5
 YcUpOD5yi3U=; b=fJKkzNJ+xzsQddb+Z9n+TudgWTzavU2Z+xdTs+ewbEb7bsKq
 fFR9+KlO0sIS041EXcFRpyyDvINtW6Fab5BeZeOhurCsSN1gMbGI4df7gb790diD
 imLZ3VimclLl2PXDaEtkP4vIUVBMgPKrbDJmyh/4N8XqDJvPUxVrYtwKPRLcUeww
 0CteIZQNS0eisu8+lMD1onwLSIsk218/S0WZmS3P7jYAJhCKrSQFRWxl1GWXzzSN
 GbMw0YjOm8e5RSZq5ofI1IJNeI2U0psm+CWw5BkgIwXjp82YqQgt1P9xBIPqqS03
 pKIVbplxijt6vbukTNd8OwVixzH4wpZS3wGrnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786555059; x=
 1786641459; bh=yS9diBy5il9B/DYHRIMjCVVbNXaO8HI5YcUpOD5yi3U=; b=h
 +vQQocRnxV0NcgkGVYGl2T0HYpMoV4G2G3wAaqoEPb8eP/IXmjpLnLGZbaZutT34
 lIdU+vI+4xpXCMERvrOygl38wuxbImec1TpwYft2VIg9LrNNop69e12Gq0a41lUz
 y/ixDGSMhSpzZvvoKJ8xa2vFRFpNY6ZFlbnW9gCsJ66PQbYx6G++GeqYFH1BZf4+
 zqEVbFp973fgY39Yb66smQWXmbTGVNL7g+laWF55ifcZg1zLdxeXxY0BtUWARPIB
 jOEN53LexwEYBGHqNO+OD9JMOSYT+V0JOy0jTguRk2LBksw5ovSgo1rONiV0z8WC
 UijletG3yN25pyrRLZ92Q==
X-ME-Sender: <xms:sqp8akuNB4swtFhasvWqWCFfn0zCOiYarpciE0RpqCgwxn6303wJ3A>
 <xme:sqp8auLW9lNJgrOfjliQjsglRlp-m4iOQT5iQPBcoldsHBcXis7WpminL7I0Tyf94
 kQemLk6i2TSkM9zDJzOtk5TjN58ulSyyy1a2eXZA-1tBA7KJPMvcn4>
X-ME-Received: <xmr:sqp8ajptbhOJUs6JQErwTxSPXh7kMwvAsXQLAet1fTqvNq9CRZ1RWrhw1NgAz2pHTPQ95g>
X-ME-Proxy-Cause: dmFkZTEQ+oFfdH7n4Z0aWDQrBwrgymjq9FjcnAifwofopfoi5qs6jZ381IDSv9TkI+VehD
 pTxQpiRDNNNJDzPF7SNAX/RyvxFIGuekBmM5tL5B2CMNGiozFcZEbC79jk6Qk01j+LOb2u
 A8Ny4W+6DvWpCfWXTZ8/oEp7NmtyKzKz50fJBSxj5O/ptLJV7KJyivsLN3XMF37Lpao0vV
 iBlUFXV9Se2jfx3DDguRNVQhOa6gMq/zrz55CnjoquYg69Nu1etl+ebkBSgXbj1tv8aXST
 TtgmOp37WWMtGD3lRO/ISZF/9qWoWdsOaSSA3GNhIMem+7p0zaKbgsTwApUDHuZKswogeC
 4DvQka3VUdD++xGRdeJvu5PW606DoyByMpvMDt1gZZxJtdZQces5yJKqQjJ7OkelaweGvu
 NGRBtwSIpOJSlVYmtKKKNHdbM8T5U000GohrgzhqK+zqvo9ZE6dYa80k4Cd7pBYr48y81Q
 5IWmFQPsajurZrE4uVJ1kzA/fHHPBv71thOEzp4m4qy0wcoboxGcxhqQF1KQFs4EqLdEpA
 HrIwtlj7tWsvbeoYV4GiLnlgT8Xx6c5B+gy1nSw9tZdBW+QWCQKTlR/wEd57nNKpC01cwy
 OWW7eG0IEHE3ykGufvupigV1DjoYtPRnWaEOtTNGwdSHIa3ZJiUgDVbrl7RA
X-ME-Proxy: <xmx:sqp8ahWRZBezwaIsPa6_LTIPocN4U0SNBgmuSb9j3QuVEULZDtPZ5A>
 <xmx:sqp8ao3x_Qy3hKjLSzLxFa-lYgbVxNrVJZ-Y_RDyNkG5j4hvA6yOEQ>
 <xmx:sqp8aoTOoNMDtKcalN1ygAkG4yLx-A8wG_SV7tPcLQSmJ_93SRFzog>
 <xmx:sqp8akQOHY7VjH1b3IcQSh0qmK5_TgljL3xmdRm0ENVHXezxSzTErQ>
 <xmx:s6p8akoR8mBWSDekyceItVVj5bFQWTqaFxWBNBZwV-ZWbzHOwLngB2yl>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 13:17:38 -0400 (EDT)
Message-ID: <a1dd5df7148d868922dd78f53056918e81353b1f.camel@alistair23.me>
Subject: Re: [PATCH v2 1/3] hw/misc/k230_iomux: add Kendryte K230 IOMUX model
From: Alistair <alistair@alistair23.me>
To: Chao Liu <chao.liu@processmission.com>, Kangjie Huang
 <flamboyant.h.01@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Alistair Francis	
 <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li	
 <liwei1518@gmail.com>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Date: Thu, 13 Aug 2026 03:17:38 +1000
In-Reply-To: <aloxy47qh79wHYr9@ChaodeMacBook-Pro.local>
References: <cover.1784022244.git.flamboyant.h.01@gmail.com>
 <42d005d6e530e2cf2c7df8634e8b82c0f77d1702.1784022244.git.flamboyant.h.01@gmail.com>
 <aloxy47qh79wHYr9@ChaodeMacBook-Pro.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.153;
 envelope-from=alistair@alistair23.me; helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 2026-07-17 at 21:44 +0800, Chao Liu wrote:
> On Tue, Jul 14, 2026 at 06:22:00PM +0800, Kangjie Huang wrote:
> > Add a SysBus model for the 64 K230 Function IO configuration
> > registers documented by the K230 Technical Reference Manual.
> >=20
> > Preserve the writable configuration fields across aligned 32-bit
> > accesses, apply the documented reset values, and ignore writes to
> > read-only and reserved fields. Offsets outside the documented
> > register
> > list read as zero and ignore writes.
> >=20
> > This provides the register behavior used by the Kendryte SDK U-Boot
> > pinctrl-single driver and Linux IOMUX configuration code.
> >=20
> > Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
> Suggested-by: Chao Liu <chao.liu@processmission.com>

Are you able to review these patches as well Chao?

I feel that you know the hardware well and are probably the best person
for it

Alistair

>=20
> Thanks,
> Chao
>=20
> > ---
> > =C2=A0hw/misc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> > =C2=A0hw/misc/k230_iomux.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 124
> > +++++++++++++++++++++++++++++++++++
> > =C2=A0hw/misc/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > =C2=A0hw/misc/trace-events=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 4 ++
> > =C2=A0include/hw/misc/k230_iomux.h |=C2=A0 34 ++++++++++
> > =C2=A05 files changed, 167 insertions(+)
> > =C2=A0create mode 100644 hw/misc/k230_iomux.c
> > =C2=A0create mode 100644 include/hw/misc/k230_iomux.h
> >=20
> > diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> > index 1543ee6653..573d24a9df 100644
> > --- a/hw/misc/Kconfig
> > +++ b/hw/misc/Kconfig
> > @@ -257,4 +257,7 @@ config XLNX_VERSAL_TRNG
> > =C2=A0config XLNX_ZYNQ_DDRC
> > =C2=A0=C2=A0=C2=A0=C2=A0 bool
> > =C2=A0
> > +config K230_IOMUX
> > +=C2=A0=C2=A0=C2=A0 bool
> > +
> > =C2=A0source macio/Kconfig
> > diff --git a/hw/misc/k230_iomux.c b/hw/misc/k230_iomux.c
> > new file mode 100644
> > index 0000000000..cc40dc8ae4
> > --- /dev/null
> > +++ b/hw/misc/k230_iomux.c
> > @@ -0,0 +1,124 @@
> > +/*
> > + * Kendryte K230 IOMUX
> > + *
> > + * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * Provides the Function IO configuration registers documented by
> > the K230
> > + * Technical Reference Manual.
> > + *
> > + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> > + *
> > https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Tec=
hnical_Reference_Manual_V0.3.1_20241118.pdf
> > + *
> > + * For more information, see
> > <https://www.kendryte.com/en/proDetail/230>
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/misc/k230_iomux.h"
> > +#include "migration/vmstate.h"
> > +#include "qemu/module.h"
> > +#include "trace.h"
> > +
> > +/* TRM V0.3.1 section 12.9.2.1 Function IO register list. */
> > +static const uint32_t k230_iomux_reset_values[K230_IOMUX_NUM_REGS]
> > =3D {
> > +=C2=A0=C2=A0=C2=A0 0x944, 0x944, 0x929, 0x908, 0x888, 0x908, 0x948, 0x=
890,
> > +=C2=A0=C2=A0=C2=A0 0x890, 0x890, 0x910, 0x890, 0x890, 0x8a9, 0xa9e, 0x=
abf,
> > +=C2=A0=C2=A0=C2=A0 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0x=
b9e,
> > +=C2=A0=C2=A0=C2=A0 0xb1e, 0xa90, 0xabf, 0xb9e, 0xb9e, 0xb9e, 0xb9e, 0x=
b9e,
> > +=C2=A0=C2=A0=C2=A0 0xbd0, 0xbd0, 0xbd0, 0xbd0, 0xbd0, 0xbd0, 0x890, 0x=
910,
> > +=C2=A0=C2=A0=C2=A0 0x890, 0x910, 0x890, 0x910, 0x890, 0x910, 0x890, 0x=
910,
> > +=C2=A0=C2=A0=C2=A0 0x890, 0x910, 0x890, 0x910, 0x890, 0x910, 0x89e, 0x=
89f,
> > +=C2=A0=C2=A0=C2=A0 0x99e, 0x99e, 0x99e, 0x99e, 0x890, 0x890, 0x8a9, 0x=
8a9,
> > +};
> > +
> > +static void k230_iomux_reset(DeviceState *dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0 K230IomuxState *s =3D K230_IOMUX(dev);
> > +
> > +=C2=A0=C2=A0=C2=A0 memcpy(s->regs, k230_iomux_reset_values,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(k2=
30_iomux_reset_values));
> > +}
> > +
> > +static uint64_t k230_iomux_read(void *opaque, hwaddr offset,
> > unsigned size)
> > +{
> > +=C2=A0=C2=A0=C2=A0 K230IomuxState *s =3D K230_IOMUX(opaque);
> > +=C2=A0=C2=A0=C2=A0 uint32_t value =3D 0;
> > +
> > +=C2=A0=C2=A0=C2=A0 if (offset < K230_IOMUX_REGS_SIZE) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D s->regs[offset >>=
 2];
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 trace_k230_iomux_read(offset, value);
> > +=C2=A0=C2=A0=C2=A0 return value;
> > +}
> > +
> > +static void k230_iomux_write(void *opaque, hwaddr offset,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t value, unsigned size)
> > +{
> > +=C2=A0=C2=A0=C2=A0 K230IomuxState *s =3D K230_IOMUX(opaque);
> > +
> > +=C2=A0=C2=A0=C2=A0 trace_k230_iomux_write(offset, value);
> > +=C2=A0=C2=A0=C2=A0 if (offset < K230_IOMUX_REGS_SIZE) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->regs[offset >> 2] =3D va=
lue & K230_IOMUX_WRITABLE_MASK;
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
> > +
> > +static const MemoryRegionOps k230_iomux_ops =3D {
> > +=C2=A0=C2=A0=C2=A0 .read =3D k230_iomux_read,
> > +=C2=A0=C2=A0=C2=A0 .write =3D k230_iomux_write,
> > +=C2=A0=C2=A0=C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +=C2=A0=C2=A0=C2=A0 .valid =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .min_access_size =3D 4,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .max_access_size =3D 4,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .unaligned =3D false,
> > +=C2=A0=C2=A0=C2=A0 },
> > +=C2=A0=C2=A0=C2=A0 .impl =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .min_access_size =3D 4,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .max_access_size =3D 4,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .unaligned =3D false,
> > +=C2=A0=C2=A0=C2=A0 },
> > +};
> > +
> > +static void k230_iomux_init(Object *obj)
> > +{
> > +=C2=A0=C2=A0=C2=A0 K230IomuxState *s =3D K230_IOMUX(obj);
> > +
> > +=C2=A0=C2=A0=C2=A0 memory_region_init_io(&s->mmio, obj, &k230_iomux_op=
s, s,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 TYPE_K230_IOMUX, K230_IOMUX_MMIO_SIZE);
> > +=C2=A0=C2=A0=C2=A0 sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> > +}
> > +
> > +static const VMStateDescription vmstate_k230_iomux =3D {
> > +=C2=A0=C2=A0=C2=A0 .name =3D "k230.iomux",
> > +=C2=A0=C2=A0=C2=A0 .version_id =3D 1,
> > +=C2=A0=C2=A0=C2=A0 .minimum_version_id =3D 1,
> > +=C2=A0=C2=A0=C2=A0 .fields =3D (const VMStateField[]) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32_ARRAY(regs, =
K230IomuxState,
> > K230_IOMUX_NUM_REGS),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_END_OF_LIST()
> > +=C2=A0=C2=A0=C2=A0 }
> > +};
> > +
> > +static void k230_iomux_class_init(ObjectClass *klass, const void
> > *data)
> > +{
> > +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +=C2=A0=C2=A0=C2=A0 dc->desc =3D "Kendryte K230 IOMUX";
> > +=C2=A0=C2=A0=C2=A0 dc->vmsd =3D &vmstate_k230_iomux;
> > +=C2=A0=C2=A0=C2=A0 device_class_set_legacy_reset(dc, k230_iomux_reset)=
;
> > +}
> > +
> > +static const TypeInfo k230_iomux_info =3D {
> > +=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D TYPE_K230_IOMUX,
> > +=C2=A0=C2=A0=C2=A0 .parent=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D TYPE_SYS_BUS_DEVICE,
> > +=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(K230IomuxState),
> > +=C2=A0=C2=A0=C2=A0 .instance_init =3D k230_iomux_init,
> > +=C2=A0=C2=A0=C2=A0 .class_init=C2=A0=C2=A0=C2=A0 =3D k230_iomux_class_=
init,
> > +};
> > +
> > +static void k230_iomux_register_types(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0 type_register_static(&k230_iomux_info);
> > +}
> > +
> > +type_init(k230_iomux_register_types)
> > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> > index 23265f6035..31e5145a35 100644
> > --- a/hw/misc/meson.build
> > +++ b/hw/misc/meson.build
> > @@ -168,3 +168,5 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true:
> > files('sbsa_ec.c'))
> > =C2=A0
> > =C2=A0# HPPA devices
> > =C2=A0system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
> > +
> > +system_ss.add(when: 'CONFIG_K230_IOMUX', if_true:
> > files('k230_iomux.c'))
> > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> > index c9a868b3ef..388967c9e1 100644
> > --- a/hw/misc/trace-events
> > +++ b/hw/misc/trace-events
> > @@ -405,6 +405,10 @@ djmemc_write(int reg, uint64_t value, unsigned
> > int size) "reg=3D0x%x value=3D0x%"PRI
> > =C2=A0iosb_read(int reg, uint64_t value, unsigned int size) "reg=3D0x%x
> > value=3D0x%"PRIx64" size=3D%u"
> > =C2=A0iosb_write(int reg, uint64_t value, unsigned int size) "reg=3D0x%=
x
> > value=3D0x%"PRIx64" size=3D%u"
> > =C2=A0
> > +# k230_iomux.c
> > +k230_iomux_read(uint64_t offset, uint32_t value) "offset=3D0x%"
> > PRIx64 " value=3D0x%" PRIx32
> > +k230_iomux_write(uint64_t offset, uint64_t value) "offset=3D0x%"
> > PRIx64 " value=3D0x%" PRIx64
> > +
> > =C2=A0# aspeed_sli.c
> > =C2=A0aspeed_sli_write(uint64_t offset, unsigned int size, uint32_t
> > data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> > =C2=A0aspeed_sli_read(uint64_t offset, unsigned int size, uint32_t data=
)
> > "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> > diff --git a/include/hw/misc/k230_iomux.h
> > b/include/hw/misc/k230_iomux.h
> > new file mode 100644
> > index 0000000000..15a16ef4de
> > --- /dev/null
> > +++ b/include/hw/misc/k230_iomux.h
> > @@ -0,0 +1,34 @@
> > +/*
> > + * Kendryte K230 IOMUX
> > + *
> > + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> > + *
> > https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Tec=
hnical_Reference_Manual_V0.3.1_20241118.pdf
> > + *
> > + * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#ifndef HW_MISC_K230_IOMUX_H
> > +#define HW_MISC_K230_IOMUX_H
> > +
> > +#include "hw/core/sysbus.h"
> > +#include "qom/object.h"
> > +
> > +#define TYPE_K230_IOMUX "riscv.k230.iomux"
> > +OBJECT_DECLARE_SIMPLE_TYPE(K230IomuxState, K230_IOMUX)
> > +
> > +#define K230_IOMUX_MMIO_SIZE 0x800
> > +#define K230_IOMUX_NUM_REGS 64
> > +#define K230_IOMUX_REGS_SIZE \
> > +=C2=A0=C2=A0=C2=A0 (K230_IOMUX_NUM_REGS * sizeof(uint32_t))
> > +#define K230_IOMUX_WRITABLE_MASK 0x00003fff
> > +
> > +struct K230IomuxState {
> > +=C2=A0=C2=A0=C2=A0 SysBusDevice parent_obj;
> > +
> > +=C2=A0=C2=A0=C2=A0 MemoryRegion mmio;
> > +=C2=A0=C2=A0=C2=A0 uint32_t regs[K230_IOMUX_NUM_REGS];
> > +};
> > +
> > +#endif /* HW_MISC_K230_IOMUX_H */
> > --=20
> > 2.43.0
> >=20

