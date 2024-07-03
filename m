Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1447C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 05:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOsGR-0006yK-Iy; Wed, 03 Jul 2024 01:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sOsGP-0006y2-Aq
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 01:10:41 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sOsGM-0006Dy-CG
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 01:10:41 -0400
Received: from [192.168.68.112]
 (ppp118-210-145-155.adl-adc-lon-bras33.tpg.internode.on.net
 [118.210.145.155])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D74BC20174;
 Wed,  3 Jul 2024 13:10:21 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1719983425;
 bh=s3MYnDTFpz0EKynOjcCBRBaXBrQ7j4Jt/efEvnpM9rY=;
 h=Subject:From:To:Date:In-Reply-To:References;
 b=U8O5gNuhFkQhXmBA8XVbrmKByjar9xERRqPTZcSeboM5vIRQ2+gN6IJywbA9XidLt
 Vzrgch2t8fTEAyMnN9gXtdSHRmRrwqHCYuUYrL++q+yBRW3CNxCXjipXWOmm7bXIMW
 1sdKLjz8gI8rKWP4rtkrobhQAxkMkpAKEMB2VX1MmoNpxWHm2Ngjq0Q6gtOWVDKvx6
 Wmi8vdHLR4PPAhXdzSiOBHm1sCaEAI3TJj3XJy0z0GIfvHiOEH6U0KjOaJuP2kt/ph
 bsV4rwlaorpeEcARdkeHvhfxkzlhOEVO21d9Nr9QwnHFk2oFlZQMizR0bGpZoFo+n4
 IGDcAQRkbfcRQ==
Message-ID: <b9824203375f3ebec3fa4ba4b5cb1721a00e8030.camel@codeconstruct.com.au>
Subject: Re: [SPAM] [RFC PATCH v42 90/98] hw/sd/sdcard: Add experimental
 'x-aspeed-emmc-kludge' property
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>, Troy
 Lee <troy_lee@aspeedtech.com>
Date: Wed, 03 Jul 2024 14:40:19 +0930
In-Reply-To: <2b425f32-41de-4057-a8d0-79411f2519b4@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-91-philmd@linaro.org>
 <4b55f817-0e29-45c0-8f56-f997f34e0e97@kaod.org>
 <e1a6b93038e67271fc0bd9efcc7d40802cbbede7.camel@codeconstruct.com.au>
 <2b425f32-41de-4057-a8d0-79411f2519b4@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
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

On Tue, 2024-07-02 at 18:15 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/7/24 07:06, Andrew Jeffery wrote:
> > On Fri, 2024-06-28 at 11:16 +0200, C=C3=A9dric Le Goater wrote:
> > > On 6/28/24 9:02 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > > > When booting U-boot/Linux on Aspeed boards via eMMC,
> > > > some commands don't behave as expected from the spec.
> > > >=20
> > > > Add the 'x-aspeed-emmc-kludge' property to allow non
> > > > standard uses until we figure out the reasons.
> > >=20
> > > I am not aware of any singularity in the eMMC logic provided by Aspee=
d.
> > > U-Boot and Linux drivers seem very generic. May be others can tell.
> >=20
> > I'm not aware of any command kludges. The main problem I had when I
> > wrote the Linux driver for the Aspeed controller was the phase tuning,
> > but that doesn't sound related.
>=20
> Yeah I don't think anything Aspeed nor U-boot related, we
> model CSD/CID registers per the SD spec, not MMC. Various
> fields are identical, but few differ, this might be the
> problem.
>=20
> I rather respect the spec by default, so until we figure
> the issue, are you OK to use a 'x-emmc-kludge' property
> and set it on the Aspeed boards?

Dropping the implication that it's the fault of the Aspeed controller
seems reasonable (without further evidence that it's true).

Andrew


