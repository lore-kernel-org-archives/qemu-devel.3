Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97013C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzadM-0007DP-Sh; Thu, 27 Aug 2026 09:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <claunia@claunia.com>)
 id 1wzZs6-0001uN-Ao
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:10:22 -0400
Received: from 110.red-2-139-146.staticip.rima-tde.net ([2.139.146.110]
 helo=mail.claunia.com) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <claunia@claunia.com>) id 1wzZs4-0004lh-7W
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=claunia.com; s=mail;
 t=1787836213; bh=6BZU5M6Lg2K5CCnj4GRQDN8GtbftkDjfuFzz8Yy2/MQ=;
 h=Subject:From:To:Date:In-Reply-To:References:From;
 b=HaPtkm8XXCkybuV7e7A4yGIj+OhvtgU9Zqc302t0u0i1INVAijjIAK+Qf7KnlS8CZ
 VM5mnueBSRyU9mgaQdU8zrQaTr6na5/05R/axOu/iD0XXd0XX0csUYpTRNyIj5U1DE
 CvbCNvAOYv5wOXaaPEzUhe2rfEgTwoHhwfP5EQHY=
Received: from [172.21.2.1] (unknown [172.20.0.8])
 by mail.claunia.com (Postfix) with ESMTPSA id 9F259212E0D2;
 Thu, 27 Aug 2026 14:10:13 +0100 (WEST)
Message-ID: <b6ab2b434cc3fd633586a0ae39b7aca36766b0a9.camel@claunia.com>
Subject: Re: [PATCH] docs/about: Deprecate the 'next-cube' m68k machine
From: Natalia Portillo <claunia@claunia.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth	
 <huth@tuxfamily.org>, qemu-devel@nongnu.org, Laurent Vivier
 <laurent@vivier.eu>
Date: Thu, 27 Aug 2026 14:10:12 +0100
In-Reply-To: <1826b106-2b9a-41e2-81a4-8a3439f9c511@ilande.co.uk>
References: <20231007072313.22108-1-huth@tuxfamily.org>
 <1826b106-2b9a-41e2-81a4-8a3439f9c511@ilande.co.uk>
Autocrypt: addr=claunia@claunia.com; prefer-encrypt=mutual;
 keydata=mQSuBFW3BcQRDADDMCshXp4uDul3ptZa+Q5tIBow18vjwwsgf9+5L+9vUv+Sr20k6gzZw
 XAb4MRg0+feQTRwv2+8f4JtkpSUJIhk1V4hpacX+kEcxbPFWWarip90skh1kBu9I61c+yAFTQG5R/
 GjppD2TmlWGTuusX1tO4abWUTcOC04Zl9h7IqRp5yDqtm55grx6EhM2cyeF64qtC0y88tNWXoxwh5
 Q7+rM6XSHwRRg+mWXrCjo8pBoXWhFWXGiaRJqYwR/2igC8B1DY0UEb9X0oY/DC9z1xUheJ0eBJ6yG
 B/PogkW2Cf2cbjRPJBKgPZAzV+Dy5AFvZQI907Af6cuLT8rWJg7FG0KqAyJf2G+cE7OmvijJ6IpnD
 Ij8gOoWHBkI9eAYqYLO/sflZDKJmo1tLZD0fbQzd9anTKNDME2EAZw0u2z0fF+ue4FKzPKch3ZFU9
 Gi73iLhBMJZVaGbnD5//e9di0FJyisVOlsGbeC1v6zY/kTqrwaknK/ep6hA80t82P8+jod8hcBAMh
 UCitJ+SkMnwImv44vwQBjGtvIrDI1HxjdtmnLoG0/C/9WmJt+LbrOqGI7he6TkH6uJ6UZGEJ4WX3K
 VuK32XOGlXoMxCwQ/BbxvPxme6MUTNfouI8ZaPLzi+7P8a9+wncXyDLCVnfcKem86FFxMu4cOjsdV
 yySqJ0RWaWRlDYFGDzKKwd2Nj+WGUwOG73AwmuLoHhnYi+7RPiSkbrwX6N/ntdE8ZREni/BgOesLj
 E4B9XM/yYoCl7PgU/9FtZEZHeZrQwdx83gx8cohTdcSOmTfxWJfhvatMIJ50W5NY0qVov80TQFcW9
 XdPE/ufPwpzPE8NMwpNaQP8zcbEzxdb7Z0QRgf+pqKplLEi/Q2C1UR777IQ0ZDbHFTpWHQYmSFiDc
 X6HGEwxtfm5A3N49VlNKW7ZAccyHPnj3u3MPM4AMhphVXCJ0ePigeZHuWkVpFzq20WO4XI54VazhD
 LtKwQIRKQUxaC5xlWIcqa7STDCnIaQgggHbrZnt30yiOpG5Tu5HbjSL0qGIy95oeWfeq7K66Cqrrv
 TiC1eIQGURxZzLVxsL/11JBTjV0P0jQ7pYsK6wgqbvR7TwTJvTdAwbAUYaRUQcg5PqLwcGfIQVste
 k2SLOjLwJoLeTp5m5HmVHIMQszEOCNDEDUvEUc58xV8Ko73C4sz/bW6+ZppNx6RD7ovcXM+qt5IOB
 BMq5O+BhgTF33r4745YqIB3he6yu9sdyJnkvQUGDTX1QSiBQPyQBsdYjdKc4Ic65FTC04cohz4efS
 KxCLwLooUeYuQbUiQMsK+SKOz4QjaQEipI/LETQTcAhxyig270CbYHQN9sT+4Q3sz3OrTPk8rjlJ5
 dpMCcYmvvlVkiUuiL1oCJV00+7/sUrAwOPsI/jAYLYt74gpE7Wa1q3ajV6tVnABDEmB/WesHoWsKS
 By8jKYsUXDXGTIIKPn7eV2NOUOGEehJxfwFqkIF6oAkNaNnTJpKfDA4oULVhEyKy4MgFSF8FJEU0v
 WN3NOCjcpYlsnXe9m2Qs0beMafrLd/A47MgRFdytZ2UWuygmEBTwT0EiRSYAJnZNtPqrubQmTmF0Y
 WxpYSBQb3J0aWxsbyA8Y2xhdW5pYUBjbGF1bmlhLmNvbT6IgQQTEQgAKQUCVbcFxAIbAwUJAcGPgA
 cLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEFRXegZ0dxAA/B8A/jzcEBYbBlkLm3NrHQ/pQ4T
 Oa7xPNsFI5GvrMRucG8SBAP9CbJbX4ixFQyM4K4EkeaTdklGEkAwavGGJQF5ssRs33A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2.139.146.110; envelope-from=claunia@claunia.com;
 helo=mail.claunia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 27 Aug 2026 09:59:11 -0400
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

Well we have now the previous emulator that fully emulates NeXTStep so
it's not so important we keep it but if it's not so much of a
maintenance burden and the latest ESP patched of Mark can make it work
further I think it's better to keep it.

You know my philosophy is for us to emulate as many machines as we can.

Bryce seemed to have his own sources, I do not have any source for
reverse engineering the NeXT machine certainly. Surely some technical
manuals are floating on the internet.

On Mon, 2023-10-09 at 20:39 +0100, Mark Cave-Ayland wrote:
> On 07/10/2023 08:23, Thomas Huth wrote:
>=20
> (added Natalia who was the GSoC mentor for the NeXT cube work)
>=20
> > The machine is incomplete, and unfortunately the hoped-for
> > improvements
> > never happened. So it's maybe best if we mark this machine as
> > deprecated
> > and finally remove it again in case it gets into the way of a code
> > refactoring or other reasons.
> >=20
> > Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> > ---
> > =C2=A0 docs/about/deprecated.rst | 8 ++++++++
> > =C2=A0 1 file changed, 8 insertions(+)
> >=20
> > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > index 3b074b9ed4..2f6dadd12f 100644
> > --- a/docs/about/deprecated.rst
> > +++ b/docs/about/deprecated.rst
> > @@ -253,6 +253,14 @@ deprecated; use the new name ``dtb-
> > randomness`` instead. The new name
> > =C2=A0 better reflects the way this property affects all random data
> > within
> > =C2=A0 the device tree blob, not just the ``kaslr-seed`` node.
> > =C2=A0=20
> > +``next-cube`` m68k machine (since 8.2)
> > +''''''''''''''''''''''''''''''''''''''
> > +
> > +The machine never got fully implemented and can only show the
> > firmware prompt.
> > +Given the incomplete state and slow progress on improvements, it
> > might get
> > +removed again without replacement.
> > +
> > +
> > =C2=A0 Backend options
> > =C2=A0 ---------------
>=20
> I'm torn a bit by this one - on the one hand the NeXT code could do
> with some love,=20
> but then given that the code already uses qdev/QOM then there isn't
> really much in=20
> the way of maintenance burden. The main concern for me at the moment
> is the use of=20
> the old-style memory accessors that pre-date the memory API.
>=20
> With my latest ESP patches I think it shouldn't be too hard to update
> the NeXT DMA=20
> controller to get SCSI working, so perhaps we can leave it for now if
> it doesn't=20
> cause too many problems?
>=20
> Natalia, any comments from your side? In particular what sources did
> you point Bryce=20
> towards in order to reverse engineer the NeXT hardware?
>=20
>=20
> ATB,
>=20
> Mark.

--=20
Regards,
Natalia Portillo
(fey/feyr)


