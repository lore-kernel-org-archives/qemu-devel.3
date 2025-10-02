Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD84CAC5BB
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 02:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v48xT-0007Z6-6b; Wed, 01 Oct 2025 22:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1v48xQ-0007WT-HW; Wed, 01 Oct 2025 22:22:12 -0400
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1v48xH-0001EQ-D8; Wed, 01 Oct 2025 22:22:09 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 390B01D007F7;
 Wed,  1 Oct 2025 22:21:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 01 Oct 2025 22:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1759371705; x=1759458105; bh=j+30Y+qcrT
 Ic2Yi220jrPi+ylUldv4RrtBJEEKaXUgY=; b=vF+5VDwLlneOlxX5dKS+tabeiv
 8XlgFElZJb/jv+HuPtGq0MWmKRKp6YUEqmFhMRYd4bi6gWA7hokWs3xsyoyZ9/US
 Z6KeH8Y40aOHBxCi2VyTf+cQd9xrfzoKbeSsW9UB6ZMRGrMoFV9KH424+Mg5E7sz
 3FbAc/WEmMQYb8hfTYPRwtPDtef9dtj8E8rGTqADD1ngNiLDyK+4wkrQIlT6fqUU
 0McL6S9G+MoRtpw3U96dKpIG+K5nbPnv7YaKoQIxMusTcRrtEvlWUtuD7lGwJCnn
 kVD4lAfbQwbXdmggYMlHh08cTu/Gf0m9aMZsvSb2nYi/+5ZvAwNXfRIbfeQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1759371705; x=1759458105; bh=j+30Y+qcrTIc2Yi220jrPi+ylUldv4RrtBJ
 EEKaXUgY=; b=rrxVIgeLE/0jtbOwGcYVicz9zQJTF87bjmQkWTk1S2mp7n7nDGp
 w9pKzBsO54F9ie9LS2s1gcb1rjbMpyNuSyH+CRGvVYQYtWQ9JigdhMFOnvtX6zQS
 sBQdWk3dcH9BQ9W31rOQAaGFBOHhD+eMbIkqBDEJX3OvF5boeYpENxfTVskoYKP7
 X/jCOLIq9VlxXKvA1neo0RbDJQ4MGsbFBFCSkuY+d/HxiMJD12pWz6O1cI9xkz5W
 NnqICPx5OaZKY4L59T9RHhMzphPmcm4QK25Cvb3th1UKfIZ9jD+idQNevpCM/zqq
 Tj2IOapMtt+4/HwzAVG+MAUubwJNsvA2Yug==
X-ME-Sender: <xms:uOHdaNdOnrBnfvrE5HsT3pwp1snHcuXJ9Rtu6zIfLbTSqYnxzcEhwg>
 <xme:uOHdaOS85b4TbU85jAN63iu0vzYugCivotW3jizuIwC4NSKyk6SqZSUaARuaWgXMI
 awOmHkBBGFGHoxvs7xW-Tnp-H3Z_kIf6BSHeEDl6nn-MM1Lzlu4NzA>
X-ME-Received: <xmr:uOHdaBId1OWwTGFKvVsnnAJZbBqXYeCQ6A8wzdhQqBQSEuz2c6Clh0nlZ5o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeekudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtuden
 ucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhesshhtfi
 gtgidrgiihiieqnecuggftrfgrthhtvghrnheptdejjefgudeghfetvddugffhjeefjeef
 hffffeefleegudevjeellefffedvffelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihiidpnhgspghr
 tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtlhhgsehkrg
 hougdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdr
 ohhrghdprhgtphhtthhopegrnhgurhgvfiesrghjrdhiugdrrghupdhrtghpthhtoheprg
 hmihhthhgrshhhsehfsgdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhho
 nhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdgrrhhmsehnohhnghhnuhdrohhrgh
 dprhgtphhtthhopehvihhjrgihkhhhvghmkhgrsehfsgdrtghomhdprhgtphhtthhopehj
 ohgvlhesjhhmshdrihgurdgruhdprhgtphhtthhopehpkhgrrhhthhhikhgvhigrnhduhe
 dtleesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:uOHdaDIECa8kooUPER_z2Z7uPErY9G06v2cBjUR3P1dA-fYGa9wgvA>
 <xmx:uOHdaEgedG5c1yPiGpmV4aN2StELrB1nCKloIEsnqoBfOZqCXl9uqw>
 <xmx:uOHdaFOld3cwauZCQq9ZExFS6X2e6SNh7Ul8Bi5vR76L1PLBCjmpkQ>
 <xmx:uOHdaHq4eEiIosdkR7gfNJ4ehoV3oOfQK8Loeve_-arEpkF7R0z2JA>
 <xmx:ueHdaAutdUwG8PRrbkQjV1wS3N2Xlf_uTLeREPZOjVqdfx4E8IuIzlga>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 22:21:43 -0400 (EDT)
Date: Wed, 1 Oct 2025 22:21:43 -0400
From: Patrick Williams <patrick@stwcx.xyz>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, Amithash Prasad <amithash@fb.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 Vijay Khemka <vijaykhemka@fb.com>, Joel Stanley <joel@jms.id.au>,
 Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>,
 Peter Delevoryas <pdel@fb.com>
Subject: Re: [PATCH v3] aspeed: Add support for the sonorapass-bmc board
Message-ID: <aN3ht1MdFppiDcPz@heinlein>
References: <20200506173035.2154053-1-patrick@stwcx.xyz>
 <20200506183219.2166987-1-patrick@stwcx.xyz>
 <0165086d-3ab4-4986-84ff-452984d16153@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XNcrLs6Jc4wQQXFC"
Content-Disposition: inline
In-Reply-To: <0165086d-3ab4-4986-84ff-452984d16153@kaod.org>
Received-SPF: pass client-ip=202.12.124.145; envelope-from=patrick@stwcx.xyz;
 helo=fout-b2-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--XNcrLs6Jc4wQQXFC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 07:51:15AM +0200, C=E9dric Le Goater wrote:
> Hello Patrick
>=20
> Would it be possible to contribute a functional test for this
> machine ?
>=20
> The request applies to these Facebook machines :
>=20
>    sonorapass-bmc

This machine type is deprecated and never went to production.

>    yosemitev2-bmc
>    tiogapass-bmc
>    fuji-bmc
>    fby35-bmc

All of these are used by OpenBMC and/or Meta for QEMU validation of
new BMC images.  I can get you an image for these if necessary.

>=20
> Since these machines contribute little to the Aspeed models,
> their value lies in the firmware they can run to exercise the
> models. Without functional tests, I plan to schedule their
> removal in the QEMU 10.2 cycle.

I don't understand this statement.  What does "little value to the
Aspeed models" have to do with keeping machines in place.  If we are
only going to have support for machines that you deem as "valuable" why
would anyone contribute a new machine?  Is this a new policy that QEMU
only wants specific machine models for any particular SOC?

> The fby35-bmc value is in its multisoc nature. We now have the
> ast2700fc available as its replacement

We actually don't use the multisoc aspect of this machine.  I'd be fine
if we drop those pieces specifically but the general "can the BMC image
boot" is regularly used.


--=20
Patrick Williams

--XNcrLs6Jc4wQQXFC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmjd4bUACgkQqwNHzC0A
wRnZYw/+NrLkjuYUl73xo7q438D0K0dBioy4mMnSU2h1WDi4xT2Zu89n0dI62Kus
4JcSutRKtwoXNC7/6Ky731tsyfzjdg7h+GvcT0IKfbOtDZu78qQJW/j8Lo8TkXqU
EChgMJq+8n/8zVJMbE1gOEcHhgBlSWFB+QJOtbNzgaFgcCwi42D6S0P2M5E5ne+R
cvNbJHTCPSa8W0yNV2j6FFyO00bH8xRDitM6O8WHDDbSLrkqtVfnh50KzG26nSuL
BZcVWfgdIv/KLAbdf+yhKRt+WfBIPDZan3gcN9EgK6vqL6doKnRCl5bAVMH3hVTJ
ad2IGBVICa33rPPiqcfjDir3ISHPgmrHnUGkRfM3tF7zvW6LV/3YX/qEeNELCgpx
a2xcUHtIKAreygwYLPr2I78B1crfpJ6sUQPv66j9Ppa2Djf+iHy/wyojpskO1U+m
4D36+VCqfhU6tz3qsInyoFu7zyP5+z8GdEqOglcT5q7DKLorXTeEsDihIlGoPdCB
+aVmAMA2c0rUnNmqbWI4gYWh1B/V9v1J+5S9tFudgKcqRz8ZkHj/NQiZEaPah9yl
DB/ACgpTvDK6+XT1rSu7Up2R71N5L2eqg/F29/qMx716kenQj/Vi8meMRFwra/jO
t5uaoGhQl7KpJy49Zpm36dANKovU8H43kgmDYJEDEzAOTLd3B0U=
=DtZQ
-----END PGP SIGNATURE-----

--XNcrLs6Jc4wQQXFC--

