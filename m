Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D735C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXtl-0005Lh-0D; Thu, 27 Aug 2026 07:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wzXtU-0005Kc-JE; Thu, 27 Aug 2026 07:03:40 -0400
Received: from fhigh-b1-smtp.messagingengine.com ([202.12.124.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wzXtS-0003hn-0B; Thu, 27 Aug 2026 07:03:40 -0400
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3CAE37A017E;
 Thu, 27 Aug 2026 07:03:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Thu, 27 Aug 2026 07:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1787828614; x=1787915014; bh=RT10QtGBhX0F+CryNdj9CJ+/n4njSmml
 qQRCoDl1hKo=; b=J4/0jyJ9pKeVaei0jITYMNmJS6sImbiHNrxvg7gjhzSNCzk0
 T2Kx32r/WwR82TQDp7BZLM84KrbshtYjJg6ljEEspk3pi8T+7m24FBSfOVSmdMqK
 cxE4jJpm0kygpOK0PhaqXao9/byjtUjbddRZqtlbcJu496EEInucly7kMcMGA0WI
 f9LJM/SlEgcIqF9R5vRRmL9cR/1tLXwh4AknU0llbRJSBUcRwC0slY2ZPds9/l+A
 OObMPTH34F8fTjMG0d1GYppm0j/J0Mk5sawmr+m5c1N6j6nCUMQtjQV3ybnUq2fD
 Vv8RguPgC2zXwSuF0rpMnptQYoTefWXl8V3EyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787828614; x=
 1787915014; bh=RT10QtGBhX0F+CryNdj9CJ+/n4njSmmlqQRCoDl1hKo=; b=V
 Jfh5Paj87E6e5TswxzhO3bb6A3dAFVNaHIBKZ7Bp4ssIySFpyzuoqg62ZqtfudEu
 l7JPStZ+dr2oBzAa5jh4Ae533xgnQsqRyHdWUixoApVF12MmlbyuK+ZybMZR651n
 tXE8rtTx5gMgmU+azwTwxO9/UJbsfydbN3N/CQVs3ApdCFsvH5SeVEBxfbh1KM+s
 KOGQEgkNDWoM7R6a6fZP3Y+1+8bs8+Aq4Nz0DkQ/zLV7/hxgdQrqzAXhcg42aBse
 6hAb/V0TD4ie7yWQ1KOYv9Dsk3b27swh3mWXZhM37Z5QYPFdGGxkev3oF4jF6Z6D
 D77dYM7CZ+UI6+mrDd+9g==
X-ME-Sender: <xms:hBmQavjhwmkrggv47GvYXrPnxlpEKpi6EuETaX59GN2-rv6EdjG4Zw>
 <xme:hBmQatplrsPl-iohOJehjsbhBRFZgrBAt_L_npx2DKeCAVch8EkEb4T5tOnJMv1LG
 g95xTx4jmMu1VLZjB2prU9LuP6_IBSfTsWEaKHXIK6lBY8m2s4o8g>
X-ME-Received: <xmr:hBmQatzjrJXHjs_tb7wxNgsUoZDu1x_SPkwmOvGiM14ZE8SHPY0gThOwiFzF6HBqdtY-chVVIMb6djEWGGHu>
X-ME-Proxy-Cause: dmFkZTFK18F1qLTavhdDoXSd6ljD6SafRZLFHJSVi2DgUh3O1gSP6o8uYfBYwBArlF0Wtc
 k77se2pfO6d4MSnQ4x7EYCafg8R2wggSN60mvjS9R4/WnRJLb00fFN87yyV8RAXGFom1li
 hPGNr531s5ean3KJXvkaqu9sMZlrqvXwoBHl+y4WJB/vAU/EzAUINMsqtVX6b3Od+Strsb
 m2CIuy9P3PHPgZJFp/eYiWm9uWFJCJ3elK8bzFJboDjNXyj4qi9nz/xu+7RTkLraOohxOI
 ppQJvDTxHZl3aI9+9XI3SnSkOjFE4ZBVrw092VuhCIGxSJb9Dodz7bhN+NitwLIK/G7YCG
 zPEeSfaxUrHoXfSPBCFX+cWhZNdzKk1sYhJOCM93Jf97c0WEbOdo6ZCouFSBCdJJv9aq28
 GnN616XEb3llCeHvW7icdGbSv1MGAooZuitj/pUWH4p2FrcKdyUywxsXyYXIQ1nYgUs0cJ
 qpXY/uD50sf1jQ0n1yqb2WDfXtjcyxRd3jPVyaftsXoGiLZ6jhAQtuSuypzTP5uUpGgV4y
 XpKSt96nrUKO4ED40dV5wKfc42rLT/Ewa2Qn/4LjKLxTnnTTE0N6266zpX2Ar91nD7HdvL
 tbTN5s4W6aPTqt+5LLh44N473u45n7APBNQ7xD7CvK5oOvG6vrXsM3Bbf2JQ
X-ME-Proxy: <xmx:hBmQakwEHJ5yBLUJbdjS2pTet0y7IwD8SUIXbmsZPPnwqEKjw59IoA>
 <xmx:hBmQatYyfuVintsaJFHTGJrYxpO2xUWxvbbACGQ5dcDwXB47XMUf4A>
 <xmx:hBmQatnyYNma7FIdNZGKkGRFIFYDX14mEXOVpXkug12YwJLMZHklAQ>
 <xmx:hBmQaqE9MLRTRqZ-1aLsDrAOkrTdHItcuT6lOr6nlOYoKLRWvaESsg>
 <xmx:hhmQaraLJTPYhKNZ7JjLfUpp07aI6EtBTjkdlCWqxzRBWcV5C4Irx5Z5>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 07:03:21 -0400 (EDT)
Message-ID: <ac30bd54b6f1f4e4753638c9e95dbb85d8b81eca.camel@alistair23.me>
Subject: Re: [PATCH 0/4] Rename ssi_transfer to ssi_transfer8
From: Alistair <alistair@alistair23.me>
To: Peter Maydell <peter.maydell@linaro.org>, Portia Stephens
 <stephensportia@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Jamin Lin	 <jamin_lin@aspeedtech.com>, qemu-ppc@nongnu.org,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery	 <andrew@codeconstruct.com.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Troy Lee <leetroy@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@mailo.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Nicholas Piggin	 <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Kane Chen	 <kane_chen@aspeedtech.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 Glenn Miles <milesg@linux.ibm.com>, 	qemu-riscv@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Portia Stephens <portias@oss.tenstorrent.com>
Date: Thu, 27 Aug 2026 21:03:19 +1000
In-Reply-To: <CAFEAcA-Ncv9_jMMg1i+Ox_xa9oM4D_MMLGnPpqbyGJV_5B9iMg@mail.gmail.com>
References: <20260825040452.1322251-1-stephensportia@gmail.com>
 <CAFEAcA9etHvjL1igO4mFy5iQNy1pCbNFGaSg5HFva+YCeMkGEA@mail.gmail.com>
 <CACYNXwKU_UuhrBWHNFtYYmSfzRsUd5jRFjSc1++xvQHxPk6rew@mail.gmail.com>
 <CAFEAcA-Ncv9_jMMg1i+Ox_xa9oM4D_MMLGnPpqbyGJV_5B9iMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.152;
 envelope-from=alistair@alistair23.me; helo=fhigh-b1-smtp.messagingengine.com
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

On Thu, 2026-08-27 at 11:53 +0100, Peter Maydell wrote:
> On Thu, 27 Aug 2026 at 11:37, Portia Stephens
> <stephensportia@gmail.com> wrote:
> >=20
> > On Thu, Aug 27, 2026 at 7:19=E2=80=AFPM Peter Maydell
> > <peter.maydell@linaro.org> wrote:
> > >=20
> > > On Tue, 25 Aug 2026 at 05:05, <stephensportia@gmail.com> wrote:
> > > >=20
> > > > From: Portia Stephens <portias@oss.tenstorrent.com>
> > > >=20
> > > > The ssi_transfer function comments say that it takes a word
> > > > varying
> > > > between 8-bits and 32-bits. ssi_transfer takes a 32-bit arg to
> > > > transfer
> > > > but there is no means to indicate the number of bits that
> > > > should
> > > > actually be transferred. All child classes of SSI_PERIPHERAL
> > > > class have
> > > > transfer functions that, despite accepting a 32-bit tx, only
> > > > transfer a
> > > > single byte; m25p80_transfer8(), ssi_sd_transfer(),
> > > > ssd0323_transfer().
> > > >=20
> > > > The current implementation depends on the SSI model to know
> > > > what peripheral model will be attached and what transfer size
> > > > it
> > > > expects which is error prone. If a SSI_PERIPHERAL model was
> > > > written that
> > > > accepted 32-bit transfers, it could not attach to any existing
> > > > SSI
> > > > models.
> > >=20
> > > What is the motivation for this change?
> >=20
> > The motivation came from reviewing the designware ssi driver [1]
> > and
> > realizing how error prone it was. The designware ssi supports
> > varying
> > frame width but there is no way for the controller logic to know
> > what
> > the transfer size an attached device expects.
>=20
> But isn't this just the way the SSI specification is? If we're
> modelling a "you just have to get this right in software" bit
> of hardware then we don't need to somehow try to add extra
> checks in QEMU for whether the software hasn't actually done
> things right.

From my reading of things this is a bug in QEMU, not a guest issue.

The fact that aspeed_smc_flash_setup() for example iterates over a
larger value to send a single byte at a time shows that currently
everyone *thinks* think function should send a single byte.

So it does seem broken today. Making the current function clear seems
like a good step. Supporting different or larger transfers in the
future is then possible.

>=20
> > It seems like all the
> > code, that is actually connected to devices, is just written to
> > expect
> > 8-bit transfers so it should be made explicit.
> >=20
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg1218153.html
> >=20
> > >=20
> > > As far as I know for the hardware SSI protocol, it is indeed
> > > the case that the SSI controller (and/or the guest software)
> > > needs
> > > to know what transfer size the attached device expects: the
> > > controller just transmits (or expects to receive) however many
> > > bits it is programmed for.
> >=20
> > This is true but do the devices currently model only support 8-bit
> > transfers in hardware, do they not support multiframe transfer? SPI
> > supports varying framewidth but the devices are not actually
> > modeled
> > in this way.
>=20
> Do the actual devices we implement support varying framewidth,
> or do they actually have exactly one frame width that the controller
> needs to be programmed by the guest to use ?
>=20
> > A better solution may be to have multiple transfer functions,
> > ssi_transfer8, ssi_transfer32, etc. This would require the device
> > to
> > explicitly set what it is expecting. It is challenging since the
> > only
> > model's not using 8-bit transfer don't have any devices connected
> > upstream so testing is challenging.
>=20
> This doesn't allow for bit widths that aren't a multiple of 8.

Wouldn't a ssi_transfer32() just be the same as today?

Alistair

>=20
> thanks
> -- PMM

