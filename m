Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A48CC6B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 02:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGova-0004Y0-CE; Tue, 13 Oct 2026 22:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xGovS-0004XA-NL
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 22:41:08 -0400
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xGovN-0005O4-GP
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 22:41:04 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B5AF8140017A
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 22:40:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 22:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791945658; x=1792032058; bh=grqR549geILkBhXJNUVwyo7XM+f/qEb8
 6qmp1doK4lo=; b=GAvhRXZJndx04mtjmrN5fiRbZTp8swm7Hr9a9Mqa/C4+fU2s
 VBfIfSu5/cSc7m9H0zH3Vqz5QLl1D+uQBTn8lLs/8bJ5DT3ZG7X60Ymc7xgtyEun
 dFfym3J9IDu5rsK7J0wY2Pi+te/78p7hGEAI8oVdsUG8+n22lCNa4tqsYPEQzrsD
 gzikm1EiLbO4L2ZETSmU0AscAlsMa8MEUWfrRKiOU2CROhXPsQUL6+pVICZmlpy1
 3ZyQ2sfpBixyUOd25hiRJL4Pyd9+7ZOc/g9jDT6tYr5gX5p/kp+Uewtfy4drnNzb
 6wenL//hceh5Y+VJGcy5IHfQUOFr4dnWyBeQdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791945658; x=
 1792032058; bh=grqR549geILkBhXJNUVwyo7XM+f/qEb86qmp1doK4lo=; b=l
 JfIJuULl7lXPtt1g6BK5poaNhy8WmIZWhcXkyJ+3UEcN9qCNAYLK8HMmeapzIoBf
 Zjdgr7iQpS5ibh9VbdDJbbAQgyVvSeVMEQUcQYMJqIouriJoO+8ZlSnwIJu29alV
 YP8HdKQR1SkbyKzUwlSBaj9wNEjRBLL9NsN9Py+tBFa3zGHyUBxP/3ssi2FKtrfY
 eNGr3qEigOwVmha+Mjd28fxP/Hczbv7OqwfyvoIL+hQcxG9noQwmE2o4CCdHGwWx
 Rh6FcOO0Cpt4TbeF+o4j7pAd0eJluGM3dB86p5myR0tWLO4kIlMLnVo2Q7IKmp2h
 Ocoy/vaKe7c96Xy6jWC4Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791945658; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:Aq2byuWrEkyrAFYl71+QYdS+4YSuink7C4ZgyXr4Jcx90AB
 I/quk6kb6cLFkX/8LxiRekQYr0v42NTXDJ9gCIgKkNK23ZzFbkGXHhwXWcWdlyk8
 BPWRJF32KUcNNZ2vUryNhmCAXj3BOnrEN9P4qC/8tbJ/n7sy+ZLTvN0ycmL3aWRo
 Ae8iOA3WWBLUxK+6AVm+UdzUpv9awBcd+qzxhEdXz4xUMUqTDE8RijpXkCJCQmtn
 QkhiwnMzbBkElrtWrN04a50P5K0mR8cG7GoxhjDHamPS4hJYV2PdL+LIAitSeNjL
 4M/QMC9KT8VmoQm4ngYYz3MYw0DZ3GVWfI71Sgg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:N4Ydih/SiDbx7+zIrQBYdF3fLgPa7yUDzdZQ/IxRYuM=:grqR549geILkBhXJNUVwyo7XM+f/qEb86qmp1doK4lo=;
X-ME-Sender: <xms:uevOalsnAkgH7dFqBLHCKYJwbBRJYX-g-V0qYV5Px9H9VDqEtRWwIQ>
 <xme:uevOaqQLfN4eA8tEoRxzaC9ECtDF9wnkFeEvYck-nUQD5dfL_Ny6aeuIpOv0PETIM
 k6HG0QqW2pkezcBA4_B_1kfiENrK_YPM-d7dQ6SOG2M29jiUzKmdfw>
X-ME-Received: <xmr:uevOauSK_P-oFo9q1TZJfy_MPhRopxjuLcWnhGZjuQGouMrE60tuRWeLnaujw2MKjU4VtxEIRAURv0Vz5hSyashXwsk>
X-ME-Proxy-Cause: dmFkZTFy4syGFbYD8tZhftRBWtnDjTNrWx/dtBTzP8TRnhu7FzUzI6R9PoQnnFDywCbTb8
 eRhy3gRuYxVa0eLmtLIBG1d49QWqqZ2OWxXpoo7eqRKeu+xVrNn5vV4XGzWFeVO2QFiypo
 Wl5SkmqPFi7gRj+oe02LhTcgG2nTljPRiR8AkljmzgYbC4sH4XoUDb3Mx3LOXa/eMyeuc1
 iZheyaBKtfCbKa1xeftbfOpu8Z90tbDxuKGFjx9YXstxx6HG3x7i9zMUilW543gFz0X/ZX
 JZJTW1oLy6OIdWYM5F9wFmZL1JdF33WvNdmT8M0l9QOG6YakReSgb8Dk1ZKxwWN5uDVxNR
 lz5R2DAJuj6WzZjtXITZ0UqCKUw9ZDp77lDZkvzI5Im9ffNxy22XJf0pfCsNz/u6ucCZ48
 bqxjDTFqaSO4L8kDOGU2jg0gLxopRh8hqdebCpz/V8yt3D0m4Zo0KO2O7e4K9B+3WRxD4D
 jsb2McyEjY7nGRRXMuF/aYZtKCPK6reeDcD5wW1Fp+M4s87WzRdDpefkM9yIhQBQGZYRdF
 CGK/gHyKMwymEz3ZB1bKis2c3a+q0xPtAIrAFPTMf8ukSyjEacQlLcXTLQSNOWCkTjzW1Q
 /RJvGb0uuGRWojGkjwpN1VUsFoy3TArSEt1mGk5IUM4L7wziuIIsWJ3i1QGQ
X-ME-Proxy: <xmx:uevOauoWfBtYjrwd7CYSsY8trd3JMEYIWCkMzElLkgqNKhRLq20O2g>
 <xmx:uevOamBJig2O_6a9mbTLyUypcOUBZ2BUp94qugi8sI0s3InQ1g5r8g>
 <xmx:uevOaru7TLZPwth5mHIZKX01THzNcVN4WQ2BrV1zxwyIfGjw_RPDuw>
 <xmx:uevOatZu8gVPvfelwo8UDBlKCIORCQ4eS0EY7qhIUy0XWO3LQCM3HQ>
 <xmx:uuvOamYBgnba-mHgVX9fs4aGI6-4W1bsII1l_nH1e2uFkvsdSb6dYNwh>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 22:40:53 -0400 (EDT)
Message-ID: <0a3ed698bfa98cd967788863d4cab1dd50f98b2f.camel@alistair23.me>
Subject: Re: [PATCH v3 3/4] hw/riscv/atlantis: Add machine property to
 select default uart
From: Alistair <alistair@alistair23.me>
To: Portia Stephens <portias@oss.tenstorrent.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Anirudh Srinivasan
 <asrinivasan@oss.tenstorrent.com>, Daniel Henrique Barboza	
 <daniel.barboza@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Nicholas Piggin <npiggin@gmail.com>, Michael
 Ellerman <mpe@kernel.org>,  Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	 <marcandre.lureau@redhat.com>, Liu
 Zhiwei <zhiwei_liu@linux.alibaba.com>,  Joel Stanley <joel@jms.id.au>
Date: Wed, 14 Oct 2026 12:40:51 +1000
In-Reply-To: <79349810-29d7-43bb-a3f4-91c0b70e73df@oss.tenstorrent.com>
References: <20261001233324.2636629-1-portias@oss.tenstorrent.com>
 <20261001233324.2636629-4-portias@oss.tenstorrent.com>
 <41b85b9ad64efab7ae41cdc4a7315ffe6903264b.camel@alistair23.me>
 <79349810-29d7-43bb-a3f4-91c0b70e73df@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.156;
 envelope-from=alistair@alistair23.me; helo=fhigh-a5-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Thu, 2026-10-08 at 09:02 +1000, Portia Stephens wrote:
>=20
> On 6/10/2026 11:35 PM, Alistair wrote:
> > On Fri, 2026-10-02 at 09:33 +1000, Portia Stephens wrote:
> > > The Atlantis SoC has 5 UARTs. This adds a machine property to set
> > > which uart is on the first serial interface. This is the same
> > > pattern
> > > that is used by aspeed. The rest of the uart's will be added in
> > > sequential order starting at serial interface 1.
> > >=20
> > > The default value is uart1 which means the Ascalon console will
> > > be on
> > > serial interface 0 by default.
> > >=20
> > > Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> > > Reviewed-by: Daniel Henrique Barboza
> > > <daniel.barboza@oss.qualcomm.com>
> > > ---
> > > =C2=A0=C2=A0hw/riscv/tt_atlantis.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 77
> > > ++++++++++++++++++++++++++++++--
> > > --
> > > =C2=A0=C2=A0include/hw/riscv/tt_atlantis.h |=C2=A0 1 +
> > > =C2=A0=C2=A02 files changed, 69 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> > > index 2342edce93..7a5e1ddcd1 100644
> > > --- a/hw/riscv/tt_atlantis.c
> > > +++ b/hw/riscv/tt_atlantis.c
> > > @@ -12,6 +12,7 @@
> > > =C2=A0=C2=A0#include "qemu/error-report.h"
> > > =C2=A0=C2=A0#include "qemu/guest-random.h"
> > > =C2=A0=C2=A0#include "qemu/units.h"
> > > +#include "qapi/visitor.h"
> > > =C2=A0=20
> > > =C2=A0=C2=A0#include "hw/core/boards.h"
> > > =C2=A0=C2=A0#include "hw/core/loader.h"
> > > @@ -422,6 +423,26 @@ static void load_fdt(TTAtlantisState *ams)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 create_fdt_memory(ms->fdt, &ams->soc);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > +static inline int tt_atlantis_uart_index(int uart_dev)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 return uart_dev - TT_ATL_UART0;
> > > +}
> > > +
> > > +static void
> > > tt_atlantis_connect_serial_hds_to_uarts(TTAtlantisState
> > > *ams)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 TTAtlantisSoCState *s =3D &ams->soc;
> > > +=C2=A0=C2=A0=C2=A0 int uart_index =3D tt_atlantis_uart_index(ams->ua=
rt_chosen);
> > > +
> > > +=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(DEVICE(&s->uart[uart_index]), "=
chardev",
> > > serial_hd(0));
> > > +
> > > +=C2=A0=C2=A0=C2=A0 for (int i =3D 1, uart =3D 0; i < TT_ATL_NUM_UART=
S; uart++) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (uart =3D=3D uart_inde=
x) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(DEVICE(=
&s->uart[uart]), "chardev",
> > > serial_hd(i++));
> > > +=C2=A0=C2=A0=C2=A0 }
> > I don't like this. We shouldn't dynamically change the command line
> > API
> > based on a property
>=20
>=20
> Fair enough, can we just take the first 3 patches in the series and
> drop=20
> this one? That will add modeling for all the uarts but only expose
> uart1=20
> on command line.

This is path 3 though. Do you mean take the first 2 patches?

I can do that if you want

Alistair

>=20
>=20
> We will expose the remaining uarts as features as added to the model=20
> that produce output that anyone would care to look at. For example,=20
> uart0 is the system controller's console, when the system controller
> is=20
> added to the model then we will expose uart0 on the command line.
> This=20
> will prevent us from locking into a command line API before we need
> to.
>=20
>=20
>=20
> >=20
> > Alistair
> >=20
> > > +}
> > > +
> > > =C2=A0=C2=A0static void tt_atlantis_machine_done(Notifier *n, void *d=
ata)
> > > =C2=A0=C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TTAtlantisState *ams =3D container_of(=
n, TTAtlantisState,
> > > machine_done);
> > > @@ -484,11 +505,6 @@ static void
> > > tt_atlantis_machine_done(Notifier
> > > *n, void *data)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fdt_load_addr);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > -static inline int tt_atlantis_uart_index(int uart_dev)
> > > -{
> > > -=C2=A0=C2=A0=C2=A0 return uart_dev - TT_ATL_UART0;
> > > -}
> > > -
> > > =C2=A0=C2=A0static void tt_atlantis_soc_init(Object *obj)
> > > =C2=A0=C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TTAtlantisSoCState *s =3D TT_ATLANTIS_=
SOC(obj);
> > > @@ -592,10 +608,6 @@ static void
> > > tt_atlantis_soc_realize(DeviceState
> > > *dev, Error **errp)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory_region_add_subregion(s->memory,=
 s-
> > > > memmap[TT_ATL_BOOTROM].base,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &s->bootrom);
> > > =C2=A0=20
> > > -=C2=A0=C2=A0=C2=A0 /* UART1, the soc console (UART0 is for the boot
> > > microcontroller
> > > */
> > > -=C2=A0=C2=A0=C2=A0 qdev_prop_set_chr(DEVICE(&s-
> > > > uart[tt_atlantis_uart_index(TT_ATL_UART1)]),
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "chardev", ser=
ial_hd(0));
> > > -
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < TT_ATL_NUM_UARTS=
; i++) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SysBusDevice *=
sbd =3D SYS_BUS_DEVICE(&s->uart[i]);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!sysbus_re=
alize(sbd, errp)) {
> > > @@ -663,6 +675,10 @@ static void
> > > tt_atlantis_machine_init(MachineState *machine)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OBJECT(&ams->soc_memory),
> > > &error_abort);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_link(OBJECT(&ams->=
soc), "dram",
> > > OBJECT(machine->ram),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &error_abort);
> > > +
> > > +=C2=A0=C2=A0=C2=A0 /* Map serial interfaces to uart */
> > > +=C2=A0=C2=A0=C2=A0 tt_atlantis_connect_serial_hds_to_uarts(ams);
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_realize(DEVICE(&ams->soc), NULL, =
&error_fatal);
> > > =C2=A0=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* I2C peripherals: qemu specific */
> > > @@ -680,6 +696,47 @@ static void
> > > tt_atlantis_machine_init(MachineState *machine)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_add_machine_init_done_notifier(&a=
ms->machine_done);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > +static void tt_atlantis_get_console(Object *obj, Visitor *v,
> > > const
> > > char *name,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void =
*opaque, Error **errp)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 TTAtlantisState *ams =3D TT_ATLANTIS_MACHINE(obj)=
;
> > > +=C2=A0=C2=A0=C2=A0 uint32_t uart_index =3D tt_atlantis_uart_index(am=
s-
> > > >uart_chosen);
> > > +
> > > +=C2=A0=C2=A0=C2=A0 visit_type_uint32(v, name, &uart_index, errp);
> > > +}
> > > +
> > > +static void tt_atlantis_set_console(Object *obj, Visitor *v,
> > > const
> > > char *name,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void =
*opaque, Error **errp)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 TTAtlantisState *ams =3D TT_ATLANTIS_MACHINE(obj)=
;
> > > +=C2=A0=C2=A0=C2=A0 uint32_t value;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 if (!visit_type_uint32(v, name, &value, errp)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0 if (value >=3D TT_ATL_NUM_UARTS) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "\"conso=
le\" should be in range [%d -
> > > %d]",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, TT_ATL_NUM_UARTS - 1);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 ams->uart_chosen =3D value + TT_ATL_UART0;
> > > +}
> > > +
> > > +static void tt_atlantis_machine_class_props_init(ObjectClass
> > > *oc)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 ObjectProperty *console;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 console =3D object_class_property_add(oc, "consol=
e",
> > > "uint32_t",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 tt_atlantis_get_console,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 tt_atlantis_set_console,
> > > NULL, NULL);
> > > +=C2=A0=C2=A0=C2=A0 object_class_property_set_description(oc, "consol=
e",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=
Change the default UART index on -serial. Valid
> > > values
> > > are 0 " \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=
through 4");
> > > +=C2=A0=C2=A0=C2=A0 /* Default to UART1, the Ascalon console */
> > > +=C2=A0=C2=A0=C2=A0 object_property_set_default_uint(console, 1);
> > > +}
> > > +
> > > =C2=A0=C2=A0static void tt_atlantis_machine_class_init(ObjectClass *o=
c,
> > > const
> > > void *data)
> > > =C2=A0=C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc)=
;
> > > @@ -693,6 +750,8 @@ static void
> > > tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->block_default_type =3D IF_VIRTIO;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->no_cdrom =3D 1;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->default_ram_id =3D "tt_atlantis.ra=
m";
> > > +
> > > +=C2=A0=C2=A0=C2=A0 tt_atlantis_machine_class_props_init(oc);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > =C2=A0=C2=A0static const TypeInfo tt_atlantis_types[] =3D {
> > > diff --git a/include/hw/riscv/tt_atlantis.h
> > > b/include/hw/riscv/tt_atlantis.h
> > > index b81b7c8abd..7bd46e9c9b 100644
> > > --- a/include/hw/riscv/tt_atlantis.h
> > > +++ b/include/hw/riscv/tt_atlantis.h
> > > @@ -56,6 +56,7 @@ struct TTAtlantisState {
> > > =C2=A0=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MemoryRegion soc_memory;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TTAtlantisSoCState soc;
> > > +=C2=A0=C2=A0=C2=A0 uint32_t uart_chosen;
> > > =C2=A0=C2=A0};
> > > =C2=A0=20
> > > =C2=A0=C2=A0enum {

