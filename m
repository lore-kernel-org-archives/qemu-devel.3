Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A924BC61DC4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 00:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzk8m-0006E1-Lo; Thu, 27 Aug 2026 20:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wzk8k-0006DO-Kb; Thu, 27 Aug 2026 20:08:14 -0400
Received: from fhigh-b1-smtp.messagingengine.com ([202.12.124.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wzk8h-0006WG-Ix; Thu, 27 Aug 2026 20:08:14 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 690807A00D9;
 Thu, 27 Aug 2026 20:08:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 27 Aug 2026 20:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1787875688; x=1787962088; bh=BOZJR3VVH47eUCp5RvSlZ5FawNdXQA0y
 3EkgMljkMEE=; b=wlJ4MkH9wFSWsO3Sji2Sq4BGe1fZEROW8EQTS09diOtPla+E
 FtAD0tYQv+0UCWHyqYoeAxdoMcjJ28JEyP1W6ZsLmaftpC/rzL/CBB0xF7LAgaGr
 uDBbxvR6M9BYL8YatwFzBNqqTJ5AETIY1BluGZLCCXS16TDhY4+VECIepeNqUuKe
 qXGxZKIgisNh+UoVRcM6sW+/hYbbNeUrUZykCEPqBKXWpUYSsS9apJVGhk5IiibB
 Jo5/Z77ZS/MOksIHgXwfSbcp+uAIiUsAQWQirrPJQ+n1iGOs6V2sZdOTV122QsIa
 NexX/hI6f6VNj4zbpmHapXb6pO1p9AJ6KB8PVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787875688; x=
 1787962088; bh=BOZJR3VVH47eUCp5RvSlZ5FawNdXQA0y3EkgMljkMEE=; b=j
 RnTxIfa3eoQqesteWXOgr8PtLGrnHL4k4sqBx9FXRw/dSgkhADwIs7wYg9z58z/E
 kKGWUxD6FUbu53RjUi4YVPJVmm5wS/UUN9mLP+H5VwS3a8DRTF8FqluASO9k21jE
 ITbojPyc0jU3RegJAw41IV8LzzdbQSjRQEQ0muWcirNQMnbU927weCbBGerANhs6
 vz2PpeE+DQYgWQKiC13j3Jm1TcUMBJmu8E3PjPRtEvD4RkAZiJmjtyoRRy3KOY2D
 YQt7oB/o1E8mjkGZI/V9zO5q3yuGaOt2jgYti0PbNblsfaOEmgSfaKL8qnIq0W2m
 ShS1TB7xo6/ZvQ6sz4lxg==
X-ME-Sender: <xms:ZtGQari9ElGEo5z4Ywi-IoaHF_OaJtodeg-XMXufi66iGKTVc2qbQA>
 <xme:ZtGQapp2HRWHezFxL_JOqFdko50RjukKXl8reimjyNREwwuvmdd6pdhZ-WBxBRPWX
 En3-cXZuafEMjLJlrTF72otDSqk664LjQSsrWj-HaEb9A0he5HxPN4>
X-ME-Received: <xmr:ZtGQapyFA_zD3oJqCSNkHtwbDLnn_vnWHsNRVW2jRrqXiap55XmvmO-Z0PCU2f5fRQqiY-q9q3Fbo_IJ8srlMmRy9jQ>
X-ME-Proxy-Cause: dmFkZTGoUImZX0MgnIa0NA3cVRDDZ6yZQ5ecoNAMTTjH5DBE+LuNLzuOjXKtL75mZvws5Y
 Vdg4ooMMVtA6b5uOkOqkw7ZxcjoszrZMJF0GX76e9m2fuALSZ3VPf8dZz+Rio2fCdjRcfd
 Y/2+9fSkN2dWy37jzlCSQHbSTBQuGi8OpbkZsIa+Ads0CsMHCqMopQmfk7El0TdV8php9N
 SdXFmVZwod+58HRfVGaOfE12IN6Kr2gthhOMqSO0ntB0Hp6vpZUZYaHwrkfH2JLlK/QShM
 w04AHAfErEIWbd2457e4GqNEqjL1cQl2dwBWCBRrTlRTT6Rdvx0W/DY4/Z1scdBn0Kr1ET
 VKmhZv9ea7oihM9VdeM0jQqh9qzbzJmjPB7AD3HEizb5IpIb4SoNZbKTbLXNKp1R9+ilQQ
 TLifrnBr9zhjRk2AwdlJhCiJI5yHx5GWuJy+O1sqSBUaWoJo0ZpZiCTvXoRITv1EXhhawg
 TZ1V/3BkycSk0xDGRPnNaBvuByv83g+Q9eKeC68rLFa3oKwQog9e6xkxA3l6T085SHdsnA
 Ftpy0pPtW+pcomoNfByUK8WYM4g/NByXF4k8wZy3KyybcsRTsQT8zPkDgfPFLidil1cBt1
 nam2p0l7YktKqFUNZpbPNgE0RXKHEtjMKKF6pBG6toLPvG41VNWBtaaZAxpg
X-ME-Proxy: <xmx:ZtGQagxjUaPhUtrEd6rDMEgXcELYugXOKr2LuWVXRVUkpW1hEdmpuQ>
 <xmx:ZtGQapYKWOlxQKqwiJZIMUfQAigGf5wA4vFy9lXX7Ei3C8CFOs4XPw>
 <xmx:ZtGQaplP-JlbZ9cRZ35KiBxlFgZUvkIspJxljmNwCtPXEn9r6oi5wA>
 <xmx:ZtGQamE797IGoIqSMu4ZURzdWaEfuvp0gGMQU3hsuBfO6lA-5k8-Ow>
 <xmx:aNGQanYQZCrO1hjVsEvuInoY3yRZM7KRbF2Vuzq-62oQXM9ujdpGXj9M>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 20:07:58 -0400 (EDT)
Message-ID: <3796c9917796a0fe26f2462645d95cc7039539af.camel@alistair23.me>
Subject: Re: [PATCH 0/4] Rename ssi_transfer to ssi_transfer8
From: Alistair <alistair@alistair23.me>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Portia Stephens <stephensportia@gmail.com>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
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
Date: Fri, 28 Aug 2026 10:07:56 +1000
In-Reply-To: <CAFEAcA9zz60hTDMEMePnc1osis7dPjn5KmSksrWKATpSMc8SHw@mail.gmail.com>
References: <20260825040452.1322251-1-stephensportia@gmail.com>
 <CAFEAcA9etHvjL1igO4mFy5iQNy1pCbNFGaSg5HFva+YCeMkGEA@mail.gmail.com>
 <CACYNXwKU_UuhrBWHNFtYYmSfzRsUd5jRFjSc1++xvQHxPk6rew@mail.gmail.com>
 <CAFEAcA-Ncv9_jMMg1i+Ox_xa9oM4D_MMLGnPpqbyGJV_5B9iMg@mail.gmail.com>
 <ac30bd54b6f1f4e4753638c9e95dbb85d8b81eca.camel@alistair23.me>
 <CAFEAcA9zz60hTDMEMePnc1osis7dPjn5KmSksrWKATpSMc8SHw@mail.gmail.com>
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

On Thu, 2026-08-27 at 12:17 +0100, Peter Maydell wrote:
> On Thu, 27 Aug 2026 at 12:03, Alistair <alistair@alistair23.me>
> wrote:
> >=20
> > On Thu, 2026-08-27 at 11:53 +0100, Peter Maydell wrote:
> > > But isn't this just the way the SSI specification is? If we're
> > > modelling a "you just have to get this right in software" bit
> > > of hardware then we don't need to somehow try to add extra
> > > checks in QEMU for whether the software hasn't actually done
> > > things right.
> >=20
> > From my reading of things this is a bug in QEMU, not a guest issue.
> >=20
> > The fact that aspeed_smc_flash_setup() for example iterates over a
> > larger value to send a single byte at a time shows that currently
> > everyone *thinks* think function should send a single byte.
>=20
> Doesn't that just show that the aspeed flash controller knows
> it is always talking to an 8-bit SSI device ? It wouldn't

But I don't think that's guaranteed to be true.

On real hardware the software could know that it's only ever connected
to an 8-bit SSI device, and set the driver accordingly. That seems
entirely possible.

But the hardware seems to support larger sizes reading [1].

In this case the QEMU code is the hardware, and I don't see how we know
we are only ever accessing an 8-bit device.

1:
https://patchew.org/linux/20220304083643.1079142-1-clg@kaod.org/20220304083=
643.1079142-5-clg@kaod.org/

> surprise me if the SPI-NOR standard in particular insisted on
> 8-bit transfers, though I can't find anything claiming to be
> that standard.
>=20
> > So it does seem broken today. Making the current function clear
> > seems
> > like a good step. Supporting different or larger transfers in the
> > future is then possible.
>=20
> I think the current interface already supports different or
> larger transfers. We just happen to not be using that.

Kind of. It does support larger transfers, but there is no size
argument. So how can the SSI device know how much was sent? Everything
seems to just assume a single byte, but it has no way to actually know
that.

Alistair

>=20
> -- PMM

