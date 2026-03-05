Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C69F30946
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 12:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy87P-0007yJ-Dm; Thu, 05 Mar 2026 07:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1vy87M-0007xm-DO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:47:53 -0500
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1vy87K-00042m-A1
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:47:52 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 95420EC0098;
 Thu,  5 Mar 2026 07:47:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Thu, 05 Mar 2026 07:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772714867; x=
 1772801267; bh=sOYDO8/TPo347qqhEyHDAVBJYsDiTALu0Qbhvb0Kqjk=; b=C
 dsD8F4eQvE15hQOytfimpBrwwv+0v+m7q1tRC/HokBvw1tSAml+eBiODW8nRBWNP
 5INe183ob9EFNgpqmoRuVaxCa9tjFvogmcmKxEcnwwR82+E8V56vWHy8FqKDMLxa
 WkAw3GF7tWdv/fE5erMkASChkTSBm7K32kzaGfoXP1ctVwMvo8Pjw/gAcURe0KlZ
 IJ0Hh7FfyXx+QpH97z2XJYSFeY3cDeSf8xmuqEl9HGrHFTgisk98jqpgb1dX8zrN
 H4Xji2nQF2kwC19OTPw3bsGHFz2TudnGUdWn0/fXTGPRPJIJC1XmABDRtKkiVAlH
 DrvwVdazV5CJ2j1CAHr7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1772714867; x=1772801267; bh=sOYDO8/TPo347qqhEyHDAVBJYsDiTALu0Qb
 hvb0Kqjk=; b=lPdxvYNPgmcRXaD6Oa1dXEi+gh+vrgNmJ11nCmdXd0fzHCTDYW1
 dJtqHjEzkPihyVKOmGcD78xnb8ohjEtJfyKxTS0tYIePzKCr8cBncLQiX3GXhd6h
 +Xp5iois4TTLk+5e2M9goaz+n/AMtsW7Fyqh5sR+kXNHiSDky6b3SZ9ClOtSXh9d
 50bCu1/B79xBTmY1hLJB2c+qUGIim1aT6asp3JFwxvjvDcKuIsQy3wk0GpK48Tba
 oFY1VhtzBUWCxCn21JPTI19Pg2b+9dMEyYD79yqCCpGnxk3duZrEaKaYNkf2O6qf
 gimO/MB46MWjoilqMbhUYUJi9aktGnPRYuA==
X-ME-Sender: <xms:c3upaQxeW8VLUBJDi5_LNTR24d_rsXVXh0-8-WXBW5LDWGOepat5hw>
 <xme:c3upaUZUB0SsLH1mFk52MAudBtfLV_-lKEpGL4NCXUa_ctDhHnR5aT_M0Ofp5scPv
 7hqahLe5UBNJ5sO-FcVHlQdsGkOzmkMRKKJTpZ-fmDKfmTxrBHoMg>
X-ME-Received: <xmr:c3upaaTPMF88zLLJppxmphEM8o4nYLOf_KPLH1-gSOcbsXUftPgc_3a_FZCEOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeigedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffffjeev
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtoheprghvihesshgthihllhgruggsrdgtohhmpdhrtghpthhtoh
 epsggvrhhrrghnghgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghmuhdquggv
 vhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnh
 htrdgukh
X-ME-Proxy: <xmx:c3upaWyBtGgs7CTIk-uCGlwZdhA2-t-9po7bOeyVOsvM-WxMtOom3A>
 <xmx:c3upac0wnCYquXqea-ssJtXch7hPAEnku87n8fbJQy0Y_XLuU6A0gA>
 <xmx:c3upaU4DdWCzZM2e6RUn1s-fQy-9bQejJRse5N2G5beScH3goymB8Q>
 <xmx:c3upafWx84_tT3QDXcktK1d2qIAbYlGvE2m-7fK9kZmXee6PBK8xfQ>
 <xmx:c3upaesNLFN-Hs3ZRx2gYXqANOcKh7T_yHDHXGUTw_fCQZh2CeOl_fIr>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 07:47:46 -0500 (EST)
Date: Thu, 5 Mar 2026 13:47:45 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Avi Kivity <avi@scylladb.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/nvme: add `model` parameter
Message-ID: <aal7cdCf2A0SUO_u@AALNPWKJENSEN.aal.scsc.local>
References: <20260302142831.1269291-1-avi@scylladb.com>
 <aaWhHEI4QaDINc8K@redhat.com>
 <CAF950WLOB1BXkJ+rmRea3nWuLRZG=O3gDas9HUhM1LMsmrnffA@mail.gmail.com>
 <CAF950WJJC+Wr+K4DQeyqM=_NdQfz=DJ+mN0fM-nyu0XBQe2pag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uTzYK1y2qq9X2WuC"
Content-Disposition: inline
In-Reply-To: <CAF950WJJC+Wr+K4DQeyqM=_NdQfz=DJ+mN0fM-nyu0XBQe2pag@mail.gmail.com>
Received-SPF: pass client-ip=103.168.172.147; envelope-from=its@irrelevant.dk;
 helo=fout-a4-smtp.messagingengine.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--uTzYK1y2qq9X2WuC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar  5 13:11, Avi Kivity wrote:
> On Mon, Mar 2, 2026 at 4:50=E2=80=AFPM Avi Kivity <avi@scylladb.com> wrot=
e:
>=20
> >
> >
> > On Mon, Mar 2, 2026 at 4:39=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com>
> > wrote:
> >
> >> On Mon, Mar 02, 2026 at 04:27:48PM +0200, Avi Kivity wrote:
> >> > Add a `model` parameter, readable with nvme-cli. This allows
> >> > impersonating other disk manufacturers or hypervisors, similar
> >> > to the the -smbios option.
> >> >
> >> > Signed-off-by: Avi Kivity <avi@scylladb.com>
> >> > ---
> >> >
> >> > Disclosure: prepared with AI assistance. I believe it to be of good
> >> > quality.
> >>
> >> Can you clarify how AI was involved,
> >
> >
> > I asked an LLM (Claude) to add a model parameter to the nvme code, which
> > it did, then I asked it to documented it, which it also did.
> >
> >
> >> as QEMU's policy is to decline
> >> any contributions where AI was involing in an authoring role:
> >>
> >
> > Very unfortunate. It would have taken me an hour or two to re-orient
> > myself in the code base, for something that took me a couple of minutes
> > with AI.
> >
>=20
> So what's the verdict?
>=20
> FWIW I think the probability of AI copying these few lines from some
> non-GPL project is zero.

As maintainer I don't have a problem taking this patch, but I'm not sure
how to deal with the policy in this instance.

Daniel, please advise if I can take this. I'd have written the patch
like this myself.

--uTzYK1y2qq9X2WuC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmmpe24ACgkQTeGvMW1P
DekfVQf/QxJjmZOPl3uSl/SgIeoWEopSWytVOiq1ge5DWNMrniD6HeQvqMsEx7p6
LlDpyomLGXvsNEDwc8ycN2Hbwl/wlFwmft1a9m5DMvMe2bqXIAGHbiTJ685eMaXH
Wa7rTQesQ/xhLF3rpfkFRAa8xRk8Z4qk9OV0+rM7krB44cng8caPqBmeNyAeI3Gd
OhA7L/PwHAmj+0qYAZ/4KW1GZq6z3o7dCB0CZxUid63a2xFr1RVeF/0byWuBBjq6
9cAfm0yyGuRvZHa7lpZeyMFt4a0+utyN5MuD4vKpMMifFkKej1gChpvyetJQGWr/
EH+scqfc57D18Lsh26s/bPNxYer3EA==
=LB7f
-----END PGP SIGNATURE-----

--uTzYK1y2qq9X2WuC--

