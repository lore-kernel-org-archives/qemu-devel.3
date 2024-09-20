Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD306CF9C5C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2024 01:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sroeT-0003Fc-MG; Fri, 20 Sep 2024 21:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@nikitashushura.com>)
 id 1srmXu-0004Jb-Q1
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 18:56:14 -0400
Received: from mail-4323.proton.ch ([185.70.43.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@nikitashushura.com>)
 id 1srmXt-0004ye-3S
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 18:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nikitashushura.com;
 s=protonmail; t=1726872968; x=1727132168;
 bh=NB00E900VOP1Y+Js/KeqwpSAmSxTaOS5JpIwegnW40Q=;
 h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=NPRFjFSkaDM3O5YtiUhW+RmVthI9rVscv95xmodYOH+26wLzGcNDMPB0ywy4mxEuE
 QI+E9xGRbOmjff3d+VLFydyMgT+4iNMdlAzZIhW5KOTXHZA7mvtt49KlU+43/AnUlG
 ySZJ8Khw08Ul1trv4HpWud0roewwt9Xmxj9nu6CI/VV/oZn/0BbQuuq4moT0gYensA
 QdqgQVIqGNEG/VRDmh2ApuVSijVK9mfRRNMTgus/BCT7QTsS9qL6ZzFIlkNRFHzxKZ
 KudqvTZo0mlin06X+BvqV9QfiaSrpbJeKC+E5zhtkflQmcykuoOm+FtD03SxgrJaW6
 rA/OZnH0XXYKg==
Date: Fri, 20 Sep 2024 22:56:03 +0000
To: qemu-devel@nongnu.org
From: Nikita Shushura <me@nikitashushura.com>
Subject: Re: [PATCH 1/2] hw/intc/grlib_irqmp: add support for extended
 interrupts
Message-ID: <nhj3SvI-G3OnsjGxakqxufV-asrUaF42KaoOHdipG_MfkEiWo3xes_8HDPBTzgc8DbnKljhfIONdNlU-64h5h1qneShnT13_l1NtKjBAcbs=@nikitashushura.com>
In-Reply-To: <20240920224810.69038-1-me@nikitashushura.com>
References: <20240920224810.69038-1-me@nikitashushura.com>
Feedback-ID: 120968030:user:proton
X-Pm-Message-ID: 1df789241d63c2d4185e7a50629a690fe3b124e0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.23; envelope-from=me@nikitashushura.com;
 helo=mail-4323.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Sep 2024 21:11:05 -0400
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

Forgot to add 'Signed-off-by', so can be deleted.




Sent with Proton Mail secure email.

On Saturday, September 21st, 2024 at 1:48 AM, Nikita Shushura <me@nikitashu=
shura.com> wrote:

> ---
> hw/intc/grlib_irqmp.c | 68 +++++++++++++++++++++++++++++++------------
> 1 file changed, 49 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
> index 37ac63fd80..2fd76dd1b4 100644
> --- a/hw/intc/grlib_irqmp.c
> +++ b/hw/intc/grlib_irqmp.c
> @@ -1,8 +1,6 @@
> /*
> * QEMU GRLIB IRQMP Emulator
> *
> - * (Extended interrupt not supported)
> - *
> * SPDX-License-Identifier: MIT
> *
> * Copyright (c) 2010-2024 AdaCore
> @@ -38,25 +36,29 @@
> #include "qemu/module.h"
> #include "qom/object.h"
>=20
> -#define IRQMP_MAX_CPU 16
> -#define IRQMP_REG_SIZE 256 /* Size of memory mapped registers /
> +#define IRQMP_MAX_CPU (16)
> +#define IRQMP_REG_SIZE (256) / Size of memory mapped registers /
>=20
> / Memory mapped register offsets /
> -#define LEVEL_OFFSET 0x00
> -#define PENDING_OFFSET 0x04
> -#define FORCE0_OFFSET 0x08
> -#define CLEAR_OFFSET 0x0C
> -#define MP_STATUS_OFFSET 0x10
> -#define BROADCAST_OFFSET 0x14
> -#define MASK_OFFSET 0x40
> -#define FORCE_OFFSET 0x80
> -#define EXTENDED_OFFSET 0xC0
> +#define LEVEL_OFFSET (0x00)
> +#define PENDING_OFFSET (0x04)
> +#define FORCE0_OFFSET (0x08)
> +#define CLEAR_OFFSET (0x0C)
> +#define MP_STATUS_OFFSET (0x10)
> +#define BROADCAST_OFFSET (0x14)
> +#define MASK_OFFSET (0x40)
> +#define FORCE_OFFSET (0x80)
> +#define EXTENDED_OFFSET (0xC0)
>=20
> / Multiprocessor Status Register */
> #define MP_STATUS_CPU_STATUS_MASK ((1 << IRQMP_MAX_CPU)-2)
> -#define MP_STATUS_NCPU_SHIFT 28
> +#define MP_STATUS_NCPU_SHIFT (28)
> +#define MP_STATUS_EIRQ_OFFSET (16)
> +
> +#define MAX_PILS_STD (16)
> +#define MAX_PILS_EXT (32)
>=20
> -#define MAX_PILS 16
> +#define DEFAULT_EIRQ (12)
>=20
> OBJECT_DECLARE_SIMPLE_TYPE(IRQMP, GRLIB_IRQMP)
>=20
> @@ -68,6 +70,7 @@ struct IRQMP {
> MemoryRegion iomem;
>=20
> unsigned int ncpus;
> + unsigned int eirq;
> IRQMPState *state;
> qemu_irq start_signal[IRQMP_MAX_CPU];
> qemu_irq irq[IRQMP_MAX_CPU];
> @@ -89,13 +92,25 @@ struct IRQMPState {
>=20
> static void grlib_irqmp_check_irqs(IRQMPState *state)
> {
> - int i;
> + int i, j;
>=20
> assert(state !=3D NULL);
> assert(state->parent !=3D NULL);
>=20
>=20
> for (i =3D 0; i < state->parent->ncpus; i++) {
>=20
> uint32_t pend =3D (state->pending | state->force[i]) & state->mask[i];
>=20
> +
> + /*
> + * Check is pending interrupt is extended,
> + * if so set pending to EIRQ and acknowledge extended interrupt"
> + */
> + for (j =3D MAX_PILS_STD; j <=3D MAX_PILS_EXT; j++) {
> + if ((pend & (1 << j)) !=3D 0) {
> + pend =3D (1 << state->parent->eirq);
>=20
> + state->extended[i] =3D (j & 0xffff);
>=20
> + }
> + }
> +
> uint32_t level0 =3D pend & ~state->level;
>=20
> uint32_t level1 =3D pend & state->level;
>=20
>=20
> @@ -110,6 +125,10 @@ static void grlib_irqmp_check_irqs(IRQMPState *state=
)
> static void grlib_irqmp_ack_mask(IRQMPState *state, unsigned int cpu,
> uint32_t mask)
> {
> + if ((mask & (1 << state->parent->eirq)) !=3D 0) {
>=20
> + mask |=3D (1 << state->extended[cpu]);
>=20
> + }
> +
> /* Clear registers */
> state->pending &=3D ~mask;
>=20
> state->force[cpu] &=3D ~mask;
>=20
> @@ -144,7 +163,6 @@ static void grlib_irqmp_set_irq(void *opaque, int irq=
, int level)
> assert(s !=3D NULL);
> assert(s->parent !=3D NULL);
>=20
>=20
> -
> if (level) {
> trace_grlib_irqmp_set_irq(irq);
>=20
> @@ -278,6 +296,9 @@ static void grlib_irqmp_write(void *opaque, hwaddr ad=
dr,
> state->mpstatus &=3D ~(1 << i);
>=20
> }
> }
> +
> + /* Writing EIRQ number */
> + state->mpstatus |=3D (state->parent->eirq << MP_STATUS_EIRQ_OFFSET);
>=20
> return;
>=20
> case BROADCAST_OFFSET:
> @@ -345,7 +366,8 @@ static void grlib_irqmp_reset(DeviceState *d)
> memset(irqmp->state, 0, sizeof *irqmp->state);
>=20
> irqmp->state->parent =3D irqmp;
>=20
> irqmp->state->mpstatus =3D ((irqmp->ncpus - 1) << MP_STATUS_NCPU_SHIFT) |
>=20
> - ((1 << irqmp->ncpus) - 2);
>=20
> + ((1 << irqmp->ncpus) - 2) |
>=20
> + (irqmp->eirq << MP_STATUS_EIRQ_OFFSET);
>=20
> }
>=20
> static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
> @@ -359,7 +381,14 @@ static void grlib_irqmp_realize(DeviceState *dev, Er=
ror **errp)
> return;
> }
>=20
> - qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);
> + if ((!irqmp->eirq) || (irqmp->eirq >=3D MAX_PILS_STD)) {
>=20
> + error_setg(errp, "Invalid eirq properties: "
> + "%u, must be 0 < eirq < %u.", irqmp->eirq,
>=20
> + MAX_PILS_STD);
> + return;
> + }
> +
> + qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS_EXT);
>=20
> /*
> * Transitionning from 0 to 1 starts the CPUs. The opposite can't
> @@ -378,6 +407,7 @@ static void grlib_irqmp_realize(DeviceState *dev, Err=
or **errp)
>=20
> static Property grlib_irqmp_properties[] =3D {
> DEFINE_PROP_UINT32("ncpus", IRQMP, ncpus, 1),
> + DEFINE_PROP_UINT32("eirq", IRQMP, eirq, DEFAULT_EIRQ),
> DEFINE_PROP_END_OF_LIST(),
> };
>=20
> --
> 2.46.1

