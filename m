Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04484C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXwp-00078r-Id; Thu, 27 Aug 2026 07:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wzXwn-00077u-Dr; Thu, 27 Aug 2026 07:07:05 -0400
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wzXwl-0004HD-Ng; Thu, 27 Aug 2026 07:07:05 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 4E3F91D000F0;
 Thu, 27 Aug 2026 07:07:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 27 Aug 2026 07:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1787828821; x=1787915221; bh=XztJHRpcO9IJGDHgZHcfXNqajY7MGL7t
 JlQ4vnPQER8=; b=Kk7TXezOeJcurKRerY+gAZVNh+3VAnvu9yGsNO7Ia+9QhfYn
 rslylGnhO0T/DtDhlHG06gER4l2ao/gqa8j6nWCJaHbgIAa+6bU81+Og87MDK7Cb
 y/4Nz2AgWgQ5Vbd9TMrO3NzKhZb/6OECTCbog0iIcjt+XNulsFeNe8ungduvckeG
 WRuwtUA7YfjHSvKB21xXIsaJthLdgy+ZLiPZfy3DfLdEscaQIHfS0g37DQ2Tn4cU
 65SzVop5uUCyTBvymcxHqSXMdjzhH3aqrdT3gjLq3grA6FuoyxZt0uxoCiRh20Gp
 7H3B7WVbzGudCwLp6DAwayrcIO2g/tSGTcpMhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787828821; x=
 1787915221; bh=XztJHRpcO9IJGDHgZHcfXNqajY7MGL7tJlQ4vnPQER8=; b=D
 mnva2OvJ3TsqXIOAMoaattLrjfzsFo94RQH5UbuwYv/l3LnCexmgLtJTHpIZxCCe
 QjKk4bTVDJhkV1BAyOR4iY0rCMzfxBruEe/M3q5DVVVTpv2BDbRSFKw40rQxIfCk
 v7PbFo1u7fOv0OM63veryUl2PM5sBLQ1GCMFteZGe4yGA7P6OqvSmUviRXbvCFqW
 4OgViWNth3n/O12DWYkHlq94BW0jItCJPwV9jZ++u9FI/Z5J3EgJeMlnxfCg8bCU
 1HFXAdHVQSbpgYOOVO4w5YXksATcaE1PhdZ4FVfCwUoLljWuPs03JVsodYccr0wC
 ExR0jrZItH+ahIZ3F4pMA==
X-ME-Sender: <xms:VBqQar5yzdxiHlnveqLb097e6utFUbqJlEw-ASxdXhj4atySDX01jQ>
 <xme:VBqQaijux2dq9YVOe4RZ0rukuF4ibi64k9wsrM7lu92ZWRo_t8YgfByXg1XDjokCc
 6mUW6eh-n6yEutFmkLsHgNK--pBbc1IUSi_8Sd7xsRjPUwLQhP3AeYr>
X-ME-Received: <xmr:VBqQahIB6rAiCnhfV-5nkKIU3ZKfhox4VOsUVQ6jiSfRf7RycvzmdlHa4mouKZOdhG12inx7XfXavwBLb7jW>
X-ME-Proxy-Cause: dmFkZTEm9UgKYeNLo1/fbZ+KeAKIAO+VA0MHj5qTsLBez87SjMicA3wwd9qhocMO+IPYbv
 37sIIckPQczY6GJBhiwE9vZRbIWUaYRHsmFZm2gkwuuy7dBK50b6vmi0krbOcGeNl1zwh6
 bBOokES6Fu6uXHpqtLRR+qN8Cd6tEEt1EO4uhAfC5PbFRk/sBg33/cs66x3RNENS6VsFRV
 Sy+tnIjYa7uLqosNCaOpSuq2UTUzNy/8YpVBfU6tB4Ka/QBELuJB3llCpkrWIrhkbffDM5
 Qr+2p7X+VgufWK0LyoSm1JHR8PJfkCEmGSUsdQ1m8gVh7gBNCz3pfC+JNL9iRy6x18LhLu
 pSZvTWV0abGoq0ltXqbEu5LK7TjoyZwKNFmbmRXhVaSvLJQ04Nfw8PQyDpRG/P1takqLvf
 KeobDrL2qJlm/VjxbSw6d6wCB/E4AjmTdN73QxHSQsa1I1yJ0lOTnUSRWUXhfmNyq0EWB3
 eqeWCwsngwDtkroyLeY0E4slhuUtsQkn/d7bK+Z2b0zwgAqLP5GyDIyMcNJO2xqzZYvFtP
 fVtJz3Tol1btK5q1h7UxDPYarSEqK5jmaoeMt/hGF6nvRTo8YXoIWSmZu90HepSAIkEvaa
 DMpnnlVC/25vE2l/qMwuLlxJmSZly1KGnm6BjxpLkcJkcWlaELoVBE3nEQqQ
X-ME-Proxy: <xmx:VBqQakr4J-Ee2OyPfZzdOoVS-WhFn2oN7dx5EINKF-efouWbbGWmMQ>
 <xmx:VBqQavxJ82D3eb1GyfBN9caq2LxUHc0TmPVXpt7FEc-bMgGQJ8J6VQ>
 <xmx:VBqQagfyD-i-Ph-ec8I3GOSNy0ROXV7sTOzsjnkASCr0SfGYCueNaA>
 <xmx:VBqQajc4XlA8fG76ztcj4uyQDdm8iMjbCwcG3juDTraOS1hr3FYjNw>
 <xmx:VRqQaumJMl117c03gJ1tk897NEAHsUDJtnX2T2qzYwUlWyi5GdQssXRa>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 07:06:51 -0400 (EDT)
Message-ID: <e45c6442cda83608af1259e99b31f2be1c0ee473.camel@alistair23.me>
Subject: Re: [PATCH 0/4] Rename ssi_transfer to ssi_transfer8
From: Alistair <alistair@alistair23.me>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: stephensportia@gmail.com, qemu-devel@nongnu.org,
 Palmer Dabbelt	 <palmer@dabbelt.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-ppc@nongnu.org,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater	 <clg@kaod.org>,
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
Date: Thu, 27 Aug 2026 21:06:48 +1000
In-Reply-To: <CAFEAcA-OE2+H0Gapxqv61kSSgTzns-FWCyagAX0hzewu0Ab2xA@mail.gmail.com>
References: <20260825040452.1322251-1-stephensportia@gmail.com>
 <d88347aa69db68c498b593eabcd2377413ff4af5.camel@alistair23.me>
 <CAFEAcA-OE2+H0Gapxqv61kSSgTzns-FWCyagAX0hzewu0Ab2xA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.145;
 envelope-from=alistair@alistair23.me; helo=fout-b2-smtp.messagingengine.com
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

On Thu, 2026-08-27 at 10:20 +0100, Peter Maydell wrote:
> On Thu, 27 Aug 2026 at 06:37, Alistair <alistair@alistair23.me>
> wrote:
> >=20
> > On Tue, 2026-08-25 at 14:04 +1000, stephensportia@gmail.com=C2=A0wrote:
> > > From: Portia Stephens <portias@oss.tenstorrent.com>
> > >=20
> > > The ssi_transfer function comments say that it takes a word
> > > varying
> > > between 8-bits and 32-bits. ssi_transfer takes a 32-bit arg to
> > > transfer
> > > but there is no means to indicate the number of bits that should
> > > actually be transferred. All child classes of SSI_PERIPHERAL
> > > class
> > > have
> > > transfer functions that, despite accepting a 32-bit tx, only
> > > transfer
> > > a
> > > single byte; m25p80_transfer8(), ssi_sd_transfer(),
> > > ssd0323_transfer().
> > >=20
> > > The current implementation depends on the SSI model to know
> > > what peripheral model will be attached and what transfer size it
> > > expects which is error prone. If a SSI_PERIPHERAL model was
> > > written
> > > that
> > > accepted 32-bit transfers, it could not attach to any existing
> > > SSI
> > > models.
> > >=20
> > > This change updates the the naming of ssi_transfer to
> > > ssi_transfer8,
> > > as
> > > well as changes the return value and transmit argument to be 8-
> > > bit.
> > >=20
> > > Most ssi models handle this correctly already, sending a single
> > > byte
> > > at
> > > a time. There are a few models that are written to support non 8-
> > > bit
> > > transfers but there are no in-tree use cases that connect a
> > > peripheral
> > > to the SSI device. These have been updated to use 8-bit
> > > transfers.
> > >=20
> > > Portia Stephens (4):
> > > =C2=A0 hw/ssi: Rename ssi_transfer to ssi_transfer8
> > > =C2=A0 hw/ssi/pl022: Fix dropped upper bytes of ssi transfer
> > > =C2=A0 hw/arm/strongarm: Fix dropped upper byte of ssi transfer
> > > =C2=A0 hw/ssi/pnv_spi: Fix dropped upper bytes of ssi transfer
> >=20
> > Thanks!
> >=20
> > Applied to riscv-to-apply.next
>=20
> Would you mind holding off on that until we figure out whether
> this is a correct change and why we need it, please?

Sure. Sorry I thought no one else was interested in reading it. Will
drop it until discussions are sorted

Alistair

>=20
> thanks
> -- PMM

