Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D04D3ABC1
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 00:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRgLh-00048w-Vw; Fri, 05 Dec 2025 19:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter@pjd.dev>)
 id 1vRgLd-00047w-M2; Fri, 05 Dec 2025 19:40:30 -0500
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter@pjd.dev>)
 id 1vRgLc-0000bM-3S; Fri, 05 Dec 2025 19:40:29 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id C3AE91D0011A;
 Fri,  5 Dec 2025 19:40:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 05 Dec 2025 19:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pjd.dev; h=cc:cc
 :content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1764981624;
 x=1765068024; bh=0Mhf038//AHQsdp3Av1SWmjEBY894UvN1RnTfEP5E/s=; b=
 QlO39se2Mr199uJwi0a6SgBr8AZ9VypCX8E5xt70PXsD2NfkaZ2DTYZnpuguiVWX
 yHrn2dr1d0W7S6MYXD8fBIDRRFkFSIkCbQGjRZsgv/PIle0zAlOTsKkb65+RnbVJ
 CPLwpKl077E40nhFIqq5MfyyQwV4QfC1o75JX66rn8N1BKOYMDw8WXAmPzqY6Z5I
 IG4cdOZRsIZO2tLLfh+s3lQz0KjgYyIVHsZnqKMZTzY/45CL6vNNGTqpWcDjzZHG
 mNynvuBx6yX077UfKcGTn0FTX8w8JHZmeBhVD8whpfKyATv3c6cVgyA8TMVep+M5
 cjQ//6OAQoEmqr9m3Lj3BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764981624; x=
 1765068024; bh=0Mhf038//AHQsdp3Av1SWmjEBY894UvN1RnTfEP5E/s=; b=J
 I/j3arhRTXN2aGiVr2Bx9eOyUDpLCzYjuaZTfqrutDMZZ0weLtJksfooLEDXf4HJ
 EjMZMlWJjPFVgY2/UeLG3TDQHCQ8HqPtAFspL+YG/Ft0ixr2d08zl3GL6hRJ2sAt
 baIP37EXxWukGWCnx3+N+hWszAlWFrTjUOFyUEYhs+OyNASzy0hpT/bQAK+70H5D
 0OvjZwFvGgGvngIsDQVJTz34Vo/nCZ6CwVfhb7masy0uAksWzIEQN+zp5amaZTXR
 qd3qUG670gMt1Dg57zGlPCe2XNbJ5xIK3POiw06pVd7zz0p5L6VVb4LutQ3dilDs
 mYUq1dmsjRf2Tkx3CX91w==
X-ME-Sender: <xms:d3szacaCHANfoDUwLnL-ZsEyX-XKvkVGtrufrQs5TGo0Wpb8AW1WTA>
 <xme:d3szaVoYopWK7u9B85hziK6BU3CGTQ0gPvwGPUjsBcCFVKNSKKtngnBL6gujS5Y2F
 ZqmoHE5kRyhulUXg6gj0nmp0QIjK-vfxuGQaSt1qsiTYJmHQLHLGmo>
X-ME-Received: <xmr:d3szaQR-K85pvDZgfd46vy-tzQQw4Bi7rAlKMY6X9cmYgn1xkATZTQp4ozn5wzDhc3k1X38>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelieejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 eptgfghfggufffkfhfvegjvffosehtqhhmtdhhtdejnecuhfhrohhmpefrvghtvghrucff
 vghlvghvohhrhigrshcuoehpvghtvghrsehpjhgurdguvghvqeenucggtffrrghtthgvrh
 hnpeeuiedtvdejgfegfffgudetvddtueffueejffejgeelveeutddtveehfffhfeetieen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpvghtvg
 hrsehpjhgurdguvghvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtohepshhtvghvvghnpghlvggvsegrshhpvggvughtvggthhdrtghomhdprh
 gtphhtthhopegtlhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpvghtvghrrdhm
 rgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopegrnhgurhgvfiestghoug
 gvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtohepqhgvmhhuqdgrrhhmsehn
 ohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurd
 horhhgpdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthho
 pehjohgvlhesjhhmshdrihgurdgruhdprhgtphhtthhopehlvggvthhrohihsehgmhgrih
 hlrdgtohhm
X-ME-Proxy: <xmx:d3szaZoSUXaKozdEhTGtimn6foOi_Ep30Nn10vBoEOb2lzxnRnNyow>
 <xmx:d3szaa1i_rjujVhrkvAiEdgpwC4Ey9-z60ADOV0r6WB4PcfzwWxS7g>
 <xmx:d3szaY7cpAujl2Nz4_q8fOhlhu13N-NwqXUOP2C4KFnAODyDH9U7Xg>
 <xmx:d3szaeS1klLvIfrXdmoyIQfJAumYXYiGE0rZzO01VQcb1oklB4IVpg>
 <xmx:eHszaRfnLEaGlfCm1FuPg70elG_mZdN7QE26bq-DYUFQIqqNbnhBolzM>
Feedback-ID: i9e814621:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 19:40:23 -0500 (EST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Peter Delevoryas <peter@pjd.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] aspeed: Deprecate the fby35 machine
Date: Fri, 5 Dec 2025 16:40:11 -0800
Message-Id: <FCC487BB-4A87-4235-BAAF-A6577D6C4658@pjd.dev>
References: <f0cb1f8e-bccd-4360-911a-f74560a350a8@kaod.org>
Cc: =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Maydell Peter <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f0cb1f8e-bccd-4360-911a-f74560a350a8@kaod.org>
To: =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
X-Mailer: iPhone Mail (23B85)
Received-SPF: pass client-ip=202.12.124.146; envelope-from=peter@pjd.dev;
 helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On Dec 5, 2025, at 12:43=E2=80=AFAM, C=C3=A9dric Le Goater <clg@kaod.org> w=
rote:
>=20
> =EF=BB=BFOn 12/4/25 20:45, Peter Delevoryas wrote:
>>>> On Dec 2, 2025, at 11:42=E2=80=AFPM, C=C3=A9dric Le Goater <clg@kaod.or=
g> wrote:
>>>=20
>>> =EF=BB=BFHello,
>>>=20
>>>> On 11/26/25 11:24, C=C3=A9dric Le Goater wrote:
>>>> There are no functional tests for the 'fby35' machine which makes
>>>> harder to determine when something becomes deprecated or unused.
>>>> The 'fby35' machine was originally added as an example of a multi-SoC
>>>> system, with the expectation the models would evolve over time in an
>>>> heterogeneous system. This hasn't happened and no public firmware is
>>>> available to boot it. It can be replaced by the 'ast2700fc', another
>>>> multi-SoC machine based on the newer AST2700 SoCs which are excepted
>>>> to receive better support in the future.
>>>> Cc: Peter Delevoryas <peter@pjd.dev>
>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
>>>=20
>>>=20
>>> No objections ? If not, I will queue the deprecation for QEMU 10.2.
>>> Since deprecation is tolerated in the -rc phase.
>> Oh hey, sorry I missed the original email, yeah no objections! Totally fa=
ir. :) We=E2=80=99re not using this internally either, we=E2=80=99ve mostly e=
nded up pursuing multi-process solutions.
>=20
> Could we have your Acked-by then ?

Oh sure, ehh:

Acked-by: Peter Delevoryas <peter@pjd.dev>

>=20
>> Even though I think single-process stuff is interesting, getting multi ma=
ster i2c to work between socs in the same process can be tricky.
>=20
> Yeah. This is still WIP. Making good progres though.
>=20
> Thanks,
>=20
> C.
>=20
>=20


