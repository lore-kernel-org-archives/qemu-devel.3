Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37581D41144
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 08:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgIw4-0004U8-2H; Thu, 15 Jan 2026 03:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emckean@protonmail.com>)
 id 1vgIDz-00059d-Hx; Thu, 15 Jan 2026 02:56:59 -0500
Received: from mail-0701.mail-europe.com ([51.83.17.38]
 helo=mail-07.mail-europe.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emckean@protonmail.com>)
 id 1vgIDx-0002ue-Pe; Thu, 15 Jan 2026 02:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1768463810; x=1768723010;
 bh=fqmesBnwB+wTVZRd+/9qpEYTfuDDmVjMJOMhDs00iSQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=BkMieD2ZCagwwpQcuDvpMPaDfma8c1lib909+99rNmR6o8x5U1GBzSwavL3KQNyN+
 IKW98mxQOA9L+GdM756RR9HYufH40XOkw3GaytK4JOGdnBFrm+80X/Yc11uCAXAzIg
 ZhZLmmlbWmLSKTPMj4OW7dHEVfI9/zHhfS3isSx3fA59BFv/LQ2Dafy0+esJ5cMxuF
 v5vw/yOAKz5jOVjNoW6+F07ngqxeWhmJMgMxJG3brROU4QqmjGY3x4r3A94TRTrNNE
 5fBWG5q+Zrz02ELBqk5/HAph5LyjxJUMJOXixSR/tMq38JotF4CacQBQ/OaZ/SDCdO
 0R+09yXe26LDA==
Date: Thu, 15 Jan 2026 07:56:45 +0000
To: Peter Maydell <peter.maydell@linaro.org>
From: e <emckean@protonmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH qemu] hw/arm/max78000: Fix num-irq to match hardware
 specification
Message-ID: <DUWQ5Ve-tVEHGZDWH-XpmErxJDu5_tIsPEcYNxE4YX1w1u_skMBv2xWS9SIiEQoLlFXH11WuMIinhvXQaWcdnGSdpMc60Ea0Dm3i9lTaxCg=@protonmail.com>
In-Reply-To: <CAFEAcA_YkEVkm_6ihHHrDv43wAEw2qceBWW2xHjZdQzW0H4KSg@mail.gmail.com>
References: <176663430090.23028.16926971585326050904-0@git.sr.ht>
 <CAFEAcA_YkEVkm_6ihHHrDv43wAEw2qceBWW2xHjZdQzW0H4KSg@mail.gmail.com>
Feedback-ID: 173361351:user:proton
X-Pm-Message-ID: 14015f9d8a2588b0c51f860050499871cf9f5b74
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=51.83.17.38;
 envelope-from=emckean@protonmail.com; helo=mail-07.mail-europe.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 15 Jan 2026 03:42:30 -0500
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

I appreciate the detailed reply and breakdown. Apologies for the lack of du=
e diligence on the previous discussion. I do not have the hardware with me =
currently but will confirm the real number of external interrupts in a few =
months when I do again.

- Ethan

On Tuesday, January 13th, 2026 at 1:19 AM, Peter Maydell <peter.maydell@lin=
aro.org> wrote:

>=20
>=20
> On Thu, 25 Dec 2025 at 04:14, ~emckean emckean@git.sr.ht wrote:
>=20
> > From: Ethan McKean emckean@protonmail.com
> >=20
> > The MAX78000 user guide Section 5.2 and Table 5-1 specify 119 interrupt
> > entries. The previous value of 120 was based on a misreading of the
> > table which spans three pages, with entries 0-104 on pages 102-103 and
> > the remaining entries 105-118 on page 104.
> >=20
> > Signed-off-by: Ethan McKean emckean@protonmail.com
> > ---
> > hw/arm/max78000_soc.c | 8 +-------
> > 1 file changed, 1 insertion(+), 7 deletions(-)
> >=20
> > diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
> > index 7f1856f5ba..1e2f66428d 100644
> > --- a/hw/arm/max78000_soc.c
> > +++ b/hw/arm/max78000_soc.c
> > @@ -88,13 +88,7 @@ static void max78000_soc_realize(DeviceState *dev_so=
c, Error **errp)
> >=20
> > armv7m =3D DEVICE(&s->armv7m);
> >=20
> > - /*
> > - * The MAX78000 user guide's Interrupt Vector Table section
> > - * suggests that there are 120 IRQs in the text, while only listing
> > - * 104 in table 5-1. Implement the more generous of the two.
> > - * This has not been tested in hardware.
> > - */
> > - qdev_prop_set_uint32(armv7m, "num-irq", 120);
> > + qdev_prop_set_uint32(armv7m, "num-irq", 119);
>=20
>=20
> The num-irq property of the armv7m QEMU device is the number
> of external interrupts (see the comments in the props_nvic[]
> definition in hw/intc/armv7m_nvic.c). Table 5-1 includes in
> its count the 16 internal interrupts (from 0, unused, through
> to 15, systick). So to get from the last listed external interrupt
> number in table 5-1 (which is # 119) to the total number of external
> interrupts we must subtract 15. That gets us 119 - 15 =3D=3D 104,
> which is what our comment says for the table 5-1 figure.
>=20
> But the datasheet also says this in section 5.2:
>=20
> "Including the 15 system exceptions for the Arm
> Cortex-M4 with FPU, the total number of entries is 134."
>=20
> That's where we get the "more generous" number from. If you
> strictly believe the 134 figure and that they weren't off
> by one by not accounting for the unused zero internal exception
> then that would be 134 - 15 =3D=3D 119, but I am very reluctant to
> believe in a non-multiple-of-8 number of external interrupts
> unless somebody goes and finds the real hardware and tests
> by writing to the NVIC_ISERn register bank to find where the
> RAZ/WI bits start. If anybody did do that it would not
> massively surprise me if it turned out that the actual number
> of external interrupts is 104 and the datasheet text was wrong.
>=20
> Getting the number slightly high in QEMU is pretty harmless.
>=20
> The original discussion about what we should set num-irq to
> in the review of the patchseries is in this mail thread:
> https://lore.kernel.org/qemu-devel/CAFEAcA96fap_EJiFtX6a_PFmWeP1OPZGABueA=
yE_=3DJQwFi-spA@mail.gmail.com/
>=20
> thanks
> -- PMM

