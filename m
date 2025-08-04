Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC5EC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 09:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uirnh-00007t-5K; Mon, 04 Aug 2025 05:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1uirmQ-0007cQ-FO
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 05:47:03 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1uirmO-00080p-Tf
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 05:46:54 -0400
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id D8BE3EC00C6;
 Mon,  4 Aug 2025 05:46:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Mon, 04 Aug 2025 05:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1754300810; x=
 1754387210; bh=J+n1TZOyNrjtSEwFYz0WmFFap2Zp3igFoCkMv+cH3EQ=; b=N
 XAIyVhv47SlwRd0xDAqNMbO2iyNqtkXaKk4FOKUPyKrWkcA7stRrSeXqE6dzjdHQ
 cltxN+I7bOfprj3+IyeIN0GpQlppalvt33M4xjiVxqvasWK/5l1qPZFp4rb9/0KB
 eVBeW5cxBvXaqtzL5PyM/4zkwzESBNLCp6AjDwXatKwGvuwt0RsOHCQu8+gzR3uB
 CxsQYWRBEUAoancaCoLGv2/fyrhqLUHT5mQRtlQX+SzXF1UQQIAG7ZpQdQG81AAZ
 rX8KDKglj0/Lh7AkjMLRIraayJStk2lYufJsKG9+zf8isC4ozaOj6b31dQ50ADyc
 +xQLSB5qyVJECFfX9ZtHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1754300810; x=1754387210; bh=J+n1TZOyNrjtSEwFYz0WmFFap2Zp3igFoCk
 Mv+cH3EQ=; b=Uscg9b4fBQhXmBQAX2XdhVc6Jes+aoTkFbrEWvMW/cqR818Op0k
 AC/hB87EmsPNLRpz0g8EUUBaAzsLv3+oO1u6bml6AjhR6sx8Xb0X80WHYD4+2Nzw
 w7AAehgduCKIwkYIj4BdO8lP2pl+nR2ZEkURw0+Dh6+ZJX1APLtXR2iUMpNU+aId
 acIOA+KCOM3Nj7VNpFmDDzc2j8qpFDaZpVmQwniHQMZAIxx+bDQu6BhOF8P0cJXZ
 lENCToVI6YfDzgg6dKcHZxItDXoTUGVtCUIiKxlw7FWXKz2hPklVuur8QtcYXi4j
 6Lfwwgn52/FubDOqyzW4LorWgVIsv6HVDGw==
X-ME-Sender: <xms:ioGQaHco0C4AtctGGmcR2NaNb4_dc0KxYBfQ5Sw5x_RaV2vZNN2riw>
 <xme:ioGQaG3XRE6PbuLPHoEpgpdakDjiWt1hWv0hhAfziikNPmlK2o1UR0GGj2qyINPm5
 uYpAK6w-0RAyduvWIg>
X-ME-Received: <xmr:ioGQaAifKf29mgCAz1hOqxWogHQqKIOcaGN2IEz5ruX2JZACbvFmbiYd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtdorre
 dttdejnecuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghv
 rghnthdrughkqeenucggtffrrghtthgvrhhnpeeivefffffhledukeehhfetueelkeffud
 euieektdegtefhgeefleeiudelveelkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprh
 gtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgvfhhkihhs
 shesihgtlhhouhgurdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhngh
 hnuhdrohhrghdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:ioGQaMTud-9ntW6eGER0jNf14vQmLbIi-XgnO_gWYB9pI_KvU7tQtA>
 <xmx:ioGQaBhFD7Rf-KBkPEKIyYHSfGghHV3detZ4Nu7geAB5RC2AlsXfTg>
 <xmx:ioGQaM52FU8tcgiShdiNjpKJEFsUxCVZ6qbuamUt4poqzoeoOjKUDw>
 <xmx:ioGQaOAqWinCo5KXwwx9tK71YfBvdJwCVMykuSOA6EEEI_7GC_B1NQ>
 <xmx:ioGQaLi_sKH1zLE06S2OFJ8O8r8YLKDqDFgtroX0NEoRDJ5L14dC7DLn>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:46:50 -0400 (EDT)
Date: Mon, 4 Aug 2025 11:46:49 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: chefkiss@icloud.com
Cc: qemu-devel@nongnu.org
Subject: Re: NVMe VMStateDescription
Message-ID: <aJCBiRrIPkbNHUAo@AALNPWKJENSEN.aal.scsc.local>
References: <56AD2339-3C68-4466-86EE-CAF931987CB3@icloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5IRZI325LcBaZ7Vr"
Content-Disposition: inline
In-Reply-To: <56AD2339-3C68-4466-86EE-CAF931987CB3@icloud.com>
Received-SPF: pass client-ip=103.168.172.145; envelope-from=its@irrelevant.dk;
 helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--5IRZI325LcBaZ7Vr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul  9 21:26, chefkiss@icloud.com wrote:
> Hello,
>=20
> I am working with an SoC that only supports NVMe, and would like to be
> able to savevm/loadvm, and maybe also record/replay. The NVMe has a
> VMStateDescription with just unmigratable =3D 1 ever since it was first
> added in 2013. Is there a technical or other limitation/reason for why
> this is the case?
>=20

Hi,

No specific reason other than "nobody implemented it".



--5IRZI325LcBaZ7Vr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmiQgYgACgkQTeGvMW1P
DenJHgf/XhhMfgg26CyXM/lNUmPhQu0noc23D65Mop+UiOsVvUGxs2dVtfgZNwaD
SpH7rcXLzVi6BPClFmRAOvGWHvs+kyyig8lEYjSX9foYDL7h+U6ZgdUr69K8iQn7
un0kkyUcKh+EmgFHfbMotCmzLJOysYoISSHHCq+ToEZZpGFFb+wDw9YtdBOJsEJF
3L6rISlOnpVbr+8qKKPJmanTp4omQn38t7sJP2IjR8Y9XDEWcsaUJjwe1BCoaZlQ
rrIaBVTq3/2ZrKFCGomnmp9gRi13AZli3iWqI8YQRnHR53NKRBxsaNSeSnabpNyk
Uc7ADcROmksj5ySQDy20RAfyIFZKJg==
=DIFN
-----END PGP SIGNATURE-----

--5IRZI325LcBaZ7Vr--

