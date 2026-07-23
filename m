Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F034C531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvog-0003up-PA; Thu, 23 Jul 2026 11:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wmvof-0003pl-Ae; Thu, 23 Jul 2026 11:58:33 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1wmvod-0006UW-O3; Thu, 23 Jul 2026 11:58:33 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BD12D60A66;
 Thu, 23 Jul 2026 15:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB491F000E9;
 Thu, 23 Jul 2026 15:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784822309;
 bh=5+r86mwRtRBoR1e4DF4VtATXVn2bxOtWXeyyEnuB9ZI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lIm2CKD2N7sayKP91IjSeJ1SxSvVB3q7/Slrc6QZSwL5gnL7ytZfisHFx3aLzpEPR
 o39d9Y2+NuLbk0iOCR3p90i5MoYAv+L2diknUuzf4cgofaF5X3l92PyMRXurNNDlEm
 WgxAv67g0ucRwsreMpIP799INOiC2OCVkU+jkjGNGgLiXkjEMkhmh8dEH7PzQoPQnr
 Vm7MXRPZ3xg51/PT+ShKLnrmE8gxi3v4LeeOj6qfNJdhPkTwu/n9TNTbCvwi76Dvzm
 BdTiD8/I33Z3TGqXXqMpxflBUAZwRs8o4hxqHqvjPDFMJIvduQO6KvO5vmcXIQCPda
 rZHYJ5aFbWZvQ==
Date: Thu, 23 Jul 2026 16:58:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 16/26] hw/rtc: Add PolarFire SoC RTC model
Message-ID: <20260723-sliding-plural-bf980dc1e567@spud>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-17-bin.meng@processmission.com>
 <20260723-seducing-plunging-ef7d4c60d917@spud>
 <CAEUhbmVYdwUbp_y8TKZggoz7oNRWo7+sfe1Q+vbqApawp7jEmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+KMWyXSMzKPNP2Xv"
Content-Disposition: inline
In-Reply-To: <CAEUhbmVYdwUbp_y8TKZggoz7oNRWo7+sfe1Q+vbqApawp7jEmg@mail.gmail.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=conor@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
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

--+KMWyXSMzKPNP2Xv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 11:55:03PM +0800, Bin Meng wrote:
> On Thu, Jul 23, 2026 at 11:29=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Thu, Jul 23, 2026 at 11:18:43PM +0800, Bin Meng wrote:
> > > The PolarFire SoC exposes an RTC with binary and calendar modes,
> > > programmable prescaling, alarms, and wakeup and match interrupts.
> > >
> > > Add a standalone device model with explicit MMIO handling for time,
> > > commands, alarms, interrupt state, reset, and migration. Add its
> > > Kconfig and Meson entries and list it under the PolarFire SoC
> > > maintainer section.
> > >
> > > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > > +
> > > +#define RTC_REG(offset) ((offset) / sizeof(uint32_t))
> > > +
> > > +static uint64_t mchp_pfsoc_rtc_get_count(MchpPfSoCRtcState *s)
> > > +{
> > > +    if (!s->running) {
> > > +        return s->frozen_count;
> > > +    }
> > > +
> > > +    return s->tick_offset +
> > > +           qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
> > > +}
> >
> > Just to be sure, this is done to match the hardware's behaviour of
> > resetting the count when the device is power cycled?
> >
>=20
> Yes, the rtc_clock + tick_offset scheme is commonly used by other QEMU
> RTC models, such as PL031, etc. It is not specifically intended to

You say "yes" here, but the rest of the sentence is addressing something
I did not ask so it is not clear if you actually mean that this matches
the hardware's behaviour.
Could you clarify please?

> model the counter being reset on a power cycle. Instead, it maps
> QEMU's clock source to the guest-programmable RTC counter value.
>=20
> Regards,
> Bin
>=20

--+KMWyXSMzKPNP2Xv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamI6IgAKCRB4tDGHoIJi
0tQSAPkBDcUlHvJpXleX/zYOnK6+52FioWK645Z5igetS1KjrgD/cZXV/XuZ2uFK
JsvOG7XbKI8E0D+FEDV0DRK2KwVlCQI=
=CWBX
-----END PGP SIGNATURE-----

--+KMWyXSMzKPNP2Xv--

