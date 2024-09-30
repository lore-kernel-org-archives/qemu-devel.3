Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BADCF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 10:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svDzl-000087-2f; Mon, 30 Sep 2024 06:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1svDzi-0008Vv-Nx; Mon, 30 Sep 2024 06:51:10 -0400
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1svDzd-0007ZV-8D; Mon, 30 Sep 2024 06:51:10 -0400
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B631F114025D;
 Mon, 30 Sep 2024 06:51:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 30 Sep 2024 06:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1727693463; x=
 1727779863; bh=mX5T3NblIPkbDeCd4cxbkHscVIkvHih143wN+MlvKKc=; b=M
 PN6ofDVinWTyZmi17gPi5Vy0gjYiIezmFpIt0Q7/+gql55QgPDd6e0ALoxSDf4nF
 AuYtkrtbk5iHBDD3FEnK7SW7sIvtU8lKYVrhMYSoRrbvsQ9RIXiDXrmfer30r8kV
 ZMyrTGLndQknqmHmUeQNl0ZAaBR39OjvWXFVBQXqIUJtTEmjFb5xxxnAMe+TBfrJ
 eqlwShetvnQfL+AKbbZvtKuS5KtpaijwBvYnoN1mLEcL39BHRvNEYraotzkrXkkw
 ObUOwpSL9Ot9kGmlRTY8OuylEeH4NOIYRpLRBr94qf5DJAE96N2SrXUvt8Lf0M9T
 1vE+l5p83E/xuqLtlorBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1727693463; x=1727779863; bh=mX5T3NblIPkbDeCd4cxbkHscVIkv
 Hih143wN+MlvKKc=; b=X7DqS014M8kUpeHASfeQK9FJzAggzMFi/Fq0NipaZ8ww
 Bhglk7WqMgGDeqJ13JD12c1v4x8uC2mp7Pq8gIZE6rL35tMwK5m5NOET4I0BuXBB
 bdHMJfXcIyGC9gFnAFNC+IowepYHjrG+Th5hhQGs9/1/wSbIH/YoVL8sdBniPygP
 WCvY8VJH/nMadwvLtMXyF+88kgIhsghIuZN84Vzo0G12XDzlHZZade6899Q3VZwr
 ejhA39CIcA87HbIObIvU5Wh6VNrNyoOUbUKCMfSqaL4CyrWM6f1PAS6NY/1K+ZsK
 /A1PfVwxheSs0/lW8Yi/pAaxkweQhEi/qEEwYPNVZw==
X-ME-Sender: <xms:l4L6ZqVlldv9f92vrSs37xv_J_VYhmGBt5v9fd8ntCH_VOgZli-5Rw>
 <xme:l4L6ZmmhAMpXgVF1RHgj41cWQpO2ZcuKJpWgcq9-BASGhGPIS0NzM0Pdyz6gRtd7R
 fCP4xjAQGTktCdcTPQ>
X-ME-Received: <xmr:l4L6ZuZndWVUAdUZ8KlciKDvR5h7VTlTroNI0idoJ7HJWAm-Es5sKppgtxNh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgfeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveej
 vedtuddugeeigeetffffjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlrghnrdgruggrmhhsoh
 hnsehorhgrtghlvgdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhg
 nhhurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtph
 htthhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepihht
 shesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:l4L6ZhVNQS_gHhOIbGUfhzOKgKSYIX0aAf0d9K6oR8KWAxNC2PbNVg>
 <xmx:l4L6Zkl0rktLuDMQLuAPTHptwP2EOrAOR_4uqrlTgzpZpkMKn9NQjw>
 <xmx:l4L6Zme18_fhAvrAv_LNp_vlpLgGJnObPwZfoQHjfL1QvLMhzyQJbg>
 <xmx:l4L6ZmFYUIdrcbm3u2JbDgion8HluxgRaQQTOSGpCeBWhVYyWTPOLg>
 <xmx:l4L6ZjtCUIjGWnUVgBGzTocUuoa07ozyH9CXrOkGX3SzbUwvHS4f3fbE>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 06:51:03 -0400 (EDT)
Date: Mon, 30 Sep 2024 12:51:01 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, qemu-block@nongnu.org
Subject: Re: [PATCH v3 0/1] hw/nvme: add atomic write support
Message-ID: <ZvqClfdYdTHbhtN2@AALNPWKJENSEN.aal.scsc.local>
References: <20240926212458.32449-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ori9GLEWMAeLKnN3"
Content-Disposition: inline
In-Reply-To: <20240926212458.32449-1-alan.adamson@oracle.com>
Received-SPF: pass client-ip=103.168.172.152; envelope-from=its@irrelevant.dk;
 helo=fhigh-a1-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--ori9GLEWMAeLKnN3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 26 14:24, Alan Adamson wrote:
> Changelog:
> v3:	- Use cpu_to_le16() to properly handle endianness.
>         - Use 'continue' rather than'break' when walking SQs.
>         - No need to lock all the SQs when walking them so remove atomic_=
lock
>           since it is running from the main loop.
>=20
> v2:	- Include changes suggested by Klaus
> 	- Check for READ/WRITE commmands when walking SQs.
> 	- Updated the "cover-letter" below with new fio example.
>=20

Hi Alan,

Applied to nvme-next!


Thanks!
Klaus

--ori9GLEWMAeLKnN3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmb6gpUACgkQTeGvMW1P
DeloeAf/eYB7lL7A8Lirz3AoJNfdQkjndyKV/2K1VwsspteJ3oQK/k/qz7dejK5Z
1/bxoJS3OYTwLlxl656lw4ZVGXdDApB/+pjiwnht91nDVXmofM5D6e5n5Q8iI2ai
OzH6n1x6/eFiTO6XuM31MHjC5mgvDGjYljGlxHKw5WZFi3UimIloXo83yAGgEszo
rcnX43fyarSviw0jT5EjQIFWueaBgX/gLSgMmQLVxXfBiIb9ijVzDcaqCF1dYOFm
Wa2RSJv0Q1lbcnXnAPepO5V/qIGE63cM2pZqruiwXH9BabKUlK7vsf9pIpXNMOeo
EfCjNt5dENMUhwYVlqhBPj4xi1Y8xQ==
=5WEY
-----END PGP SIGNATURE-----

--ori9GLEWMAeLKnN3--

