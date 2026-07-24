Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C216EC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnNXT-0004lZ-Cw; Fri, 24 Jul 2026 17:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wnNXR-0004lF-NV
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 17:34:37 -0400
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wnNXO-0002Eq-GJ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 17:34:36 -0400
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A9BB97A01F0;
 Fri, 24 Jul 2026 17:34:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Fri, 24 Jul 2026 17:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1784928872;
 x=1785015272; bh=5BH7SlBv6Eda0kwguNCiZ6NheZ94jrFydpBjKikr9gw=; b=
 F28kF31SFTqWApuIXvqpSQcbg0EpbHRZr4vkJeYwXSDuTRKAHT10RWcSGdDUkN/g
 8FEqYnHjrKgV9DMLwX0RsY2yesGewc0Sulrsc59f5+c2V3G4NJscHFhU3yv5FA4/
 AJ2z5pCfr6/npHSGI3McnivGRzT9B9ze42L6NWPITfFqGlJMPCXXUKgt3T/CCsV4
 mzhMziV7nKjiO3UcHJKapo+5Jp9AaRo750734q5FMFEO7mL5Z08gLl6gbPV0/msD
 p84pv68XZhRu9a1agKSJvnI+msMTjhgE2GUKu1k8rOg33yi2CIEugC4v5PKWF3OE
 1Lp30/PnCW3cAHa7EtMKAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784928872; x=
 1785015272; bh=5BH7SlBv6Eda0kwguNCiZ6NheZ94jrFydpBjKikr9gw=; b=Y
 sJKCcYhx/rrewaKcdoI6S8OCKicybZ50SatzeP6/uHaEQt3CMepw7MxhHy2z6eXl
 L6m4Z6+CpuGOT/RPKfbRtkE+zIyQw1jkJooo3r8svhoD4Iy6xNvRzsAg3r6xMbDz
 QE4xCAESYWzZrUhSKy4i1xwpOZfK/O05TELEccA29EZ4gaSk15bC8qfOHsBT2THg
 gUcwb39QycfA1nTthu4STQBcXoxrHw1pVL3Zyg4xYVdhbXHNMZxjyjYx2OfuCEt9
 B1S4Eal6ZyiJA4hy12LgD7jSVZdnT+Um9fix+3sHZvBHufr/CVj83gRATEbLfA21
 5LgA4AHxhry4I8plkvaQw==
X-ME-Sender: <xms:Z9pjarSyDB9WFNBJ37K33ZBZKX5bpZsH0NiqjUagTPzqXB1NAYFQ0Q>
 <xme:Z9pjajq1EpIYKXwlIUoVtsbqg7CDPE2mpO3QuxG9xyLxxI7AFY-A-vdRaGBbxjs7-
 0T2UsszqlrdX1TWMDxnS-R7IOY9QvXrTgmT67V4rWBPuCis05HjapU>
X-ME-Received: <xmr:Z9pjapLYUwH2Xgs7IIKeinPOxabyK98G9C464EO2pPvb1ZC2_mMZervJ-ddo9w>
X-ME-Proxy-Cause: dmFkZTGYDePFYvNCrayhackMFBoi/8yNtSBeU3odj03pe66Nw+Jj0+ieC9YEidUOWnlB21
 nuLYrckES9ubMDkN0vCy34IxnwTIbQK0MktiVq9yLIiJc13lwF+mJkw7yed1pT3HeJdZnF
 tcKbO2rsdbIdYAsknTE1yb7EM+3TwzXB3Arn0Sohkm0FUT7lM7Ivv44FGKHp4+Wind/4Pg
 mmuf9cCuWqb64HKF+PceGTojoet2dOtT2dKAoup6LXk/xJFqIg4RCPVopn5xtdoB+TCdBs
 RGhLYQwStOsgPmGozAPNqS28FOwJI/9Y1Z3TN4QjFOjuugnlWxDdU3Z/tkwWjeGYooESsF
 Kp9bG0TSBDUPNRGFnUu64bqdzw10ReiyNUKJcmtKi6tejuYMOmJam5B0KNmSWjnzE9sABv
 VaBChBK1j57RkP6AvD31018xqRt9eys3SKy2+0rhY8DqIJOUPlFX4p/0ywqUMZRv1JQy4r
 LHZ+fkZtGXxGeLGHd/QQGjTO1RJhPtXedpP/Kq4aCACpRGgRN7iPSaRss+zlkz7nnp+m01
 BBhtnBxkHlVGMXzCpjSqLaAp264Nrf3Bu6dq4s2reDVWqbDaA9gROGtt4aAjKpqR3ogy2f
 Hcm0pusZhNy1/ZOTA4QDZTmcUaP7O/eCAqeTeQqTO50owEy1kOgrdevTNeyQ
X-ME-Proxy: <xmx:Z9pjamqMf601W-B2ERbYcMJmoXmm8OeTApkGucGa8IbvnaxFQG2DPw>
 <xmx:aNpjahzCQwqeytQyU9nrxV3EvT1SsqUl2ewf6fN4ydMHuzuuK8IAbg>
 <xmx:aNpjaqMnC33Brl-fFJ0EoKMszdsFhMo3FOINFQKpRQKRFa_QMw6nig>
 <xmx:aNpjam6a2X0HyT0P9ggEm1yVMGYjvrL4UlOYOpKRRbpnhsFwZ0j0IA>
 <xmx:aNpjarVIrtmzNbGyxI3jdOj2H2YOYxTk7SgA95x5TT5tAVSEIZBxXiHS>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 17:34:31 -0400 (EDT)
Date: Fri, 24 Jul 2026 15:34:28 -0600
From: Alex Williamson <alex@shazbot.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, mcasquer@redhat.com, alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: Fix ROM load failure handling in vfio_rom_read()
Message-ID: <20260724153428.35f5c108@shazbot.org>
In-Reply-To: <fb57df9c-66aa-4671-80a2-a5e98a0fa7f7@oss.qualcomm.com>
References: <20260724092413.348354-1-clg@redhat.com>
 <fb57df9c-66aa-4671-80a2-a5e98a0fa7f7@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.159; envelope-from=alex@shazbot.org;
 helo=fhigh-b8-smtp.messagingengine.com
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

On Fri, 24 Jul 2026 17:41:45 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> wrote:

> On 24/7/26 11:24, C=C3=83=C2=A9dric Le Goater wrote:
> > When vfio_pci_load_rom() fails, vdev->rom is NULL but the memcpy
> > still computes a source pointer from it, which is undefined behavior.
> > Guard the access and return a 0xff pattern instead, which is what
> > hardware returns for an absent ROM.
> >=20
> > Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> > ---
> >   hw/vfio/pci.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index a3147d28665abd29fd804bd08bdffc3c7440033c..16d4f70ea58c9e5b174dd57=
950df55dc2ab91f6f 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -1176,8 +1176,13 @@ static uint64_t vfio_rom_read(void *opaque, hwad=
dr addr, unsigned size)
> >           }
> >       }
> >  =20
> > -    memcpy(&val, vdev->rom + addr,
> > -           (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) =
: 0);
> > +    /* If ROM loading failed, return 0xff pattern */
> > +    if (vdev->rom_read_failed) {
> > +        memset(&val, 0xff, sizeof(val));
> > +    } else {
> > +        memcpy(&val, vdev->rom + addr,
> > +               (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - ad=
dr) : 0);
> > +    }
> >  =20
> >       switch (size) {
> >       case 1: =20
>=20
> Maybe simpler:
>=20
> -- >8 -- =20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c204706e630..d06a2d76523 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1151,13 +1151,18 @@ static uint64_t vfio_rom_read(void *opaque,=20
> hwaddr addr, unsigned size)
>       } val =3D { .qword =3D ~0ULL };
>       uint64_t data =3D 0;
>=20
> +    if (unlikely(vdev->rom_read_failed)) {
> +        return -1;
> +    }
> +
>       /* Load the ROM lazily when the guest tries to read it */
> -    if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
> +    if (unlikely(!vdev->rom)) {
>           Error *local_err =3D NULL;
>=20
>           vdev->rom_read_failed =3D !vfio_pci_load_rom(vdev, &local_err);
>           if (vdev->rom_read_failed) {
>               error_report_err(local_err);
> +            return -1;
>           }
>       }
> ---

Loses tracing, introduces more return paths, uses implicit -1 handling
to fill return value... not simpler, imo.

>=20
> But we can also rewrite into a more readable code using ld/st
> (also avoiding memcpy zero-sized):
>=20
> -- >8 -- =20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c204706e630..af51c898f50 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -33,6 +33,7 @@
>   #include "migration/vmstate.h"
>   #include "migration/cpr.h"
>   #include "qobject/qdict.h"
> +#include "qemu/bswap.h"
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/module.h"
> @@ -1143,42 +1144,30 @@ static int=20
> vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
>   static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
>   {
>       VFIOPCIDevice *vdev =3D opaque;
> -    union {
> -        uint8_t byte;
> -        uint16_t word;
> -        uint32_t dword;
> -        uint64_t qword;
> -    } val =3D { .qword =3D ~0ULL };
> -    uint64_t data =3D 0;
> +    uint64_t data =3D -1;
> +
> +    if (unlikely(vdev->rom_read_failed)) {
> +        goto out;
> +    }
>=20
>       /* Load the ROM lazily when the guest tries to read it */
> -    if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
> +    if (unlikely(!vdev->rom)) {
>           Error *local_err =3D NULL;
>=20
>           vdev->rom_read_failed =3D !vfio_pci_load_rom(vdev, &local_err);
>           if (vdev->rom_read_failed) {
>               error_report_err(local_err);
> +            goto out;
>           }
>       }
>=20
> -    memcpy(&val, vdev->rom + addr,
> -           (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : =
0);
> -
> -    switch (size) {
> -    case 1:
> -        data =3D val.byte;
> -        break;
> -    case 2:
> -        data =3D le16_to_cpu(val.word);
> -        break;
> -    case 4:
> -        data =3D le32_to_cpu(val.dword);
> -        break;
> -    default:
> -        hw_error("vfio: unsupported read size, %d bytes\n", size);
> -        break;
> +    if (addr < vdev->rom_size) {
> +        memcpy(&val, vdev->rom + addr, MIN(size, vdev->rom_size - addr));
>       }
>=20
> +    data =3D ldn_le_p(&val, size);

val is undeclared.

> +
> +out:
>       trace_vfio_rom_read(vdev->vbasedev.name, addr, size, data);
>=20
>       return data;
> ---

As described in my previous reply, there's not actually a bug to fix
here.  The code behaves as intended and, in this respect, always has.
I don't really see a need for the churn.  Thanks,

Alex

