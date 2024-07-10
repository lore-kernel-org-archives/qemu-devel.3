Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2AFC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 09:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRTKn-0005JA-T2; Wed, 10 Jul 2024 05:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1sRTKl-0005I2-D7
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 05:09:55 -0400
Received: from fout5-smtp.messagingengine.com ([103.168.172.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1sRTKj-00062d-5c
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 05:09:55 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfout.nyi.internal (Postfix) with ESMTP id 0AFA7138210A;
 Wed, 10 Jul 2024 05:09:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Wed, 10 Jul 2024 05:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1720602592; x=
 1720688992; bh=INhKqYTHZjQLf/jjS2n0vg5cORvIwNfsbQuIC8f/+Wc=; b=v
 SIXrDlWz8Vk7VEO5X8jHGus9ZmEI2H4xobbasOcRY8Ge4nNlNKODlcZwVuNrGv+i
 WBXQ6qk6ehZuZL3Wsty+1bpzYAcXO7D9IcfOix+dB/RKnkoBjYlxHjxD51hhGfgg
 ijXfitTjL/GbBisiyvnvx0kTXCi71fCtYDqmfMXlsXA72cM7+zCMGooQbuBJj1DZ
 W+Lw/+Bi3+JGWI4l2wGYi1SZLH9PvSdUAqQPddROJomy4JxyPY9sf+gpLqmsPN4/
 thcUJnI077d6dwvkCaEItySuciCYtlvdQ5MNm3HCSt/3d47ti9DKf3rtBwUlygwH
 hVmnCscKlLiv+LCxHCokw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1720602592; x=1720688992; bh=INhKqYTHZjQLf/jjS2n0vg5cORvI
 wNfsbQuIC8f/+Wc=; b=RczawgWhzDlLuccneyVqAn5lh7o0qCRtaKg5u2la5Bxu
 b5pwDuUfcDylKrloansK6uLqSBuapk9kHbrXqdJdd5E2YWVp85eFZbUvKuqxYmkd
 Vf2vh3ukUuBrjwrrwOsNnxdUxKDijv5tMiXpEh2lGvNnVjx+N8zbxbLkmrVUTWzz
 gx+bam82CbxjiQP/GG7CtksyXADMKA0NIbRmpRGycm3PdoCO5j6NUITLnzAhpn4E
 NTEXmTOdBox16o5h+dRxP0p0pBUOB/6/rGgFkHKv/8iSufKkDBj0aofzNrrMS3M+
 CKcUMx68bQjWacsBVylyWO97VgD+Er7R2gcXGWoeYQ==
X-ME-Sender: <xms:3U-OZoU1441nWUPbdtoqruiBkI5efOWlIq1NVPuK2k6QPLQRPc_j4A>
 <xme:3U-OZsljZYBBZS5gDLN_rBsmtDyWtOT6gh5LLnnBl0ExgmFoUoTdpjMULQ6N2-D1A
 UYz5wgR7SIQUOnoPcc>
X-ME-Received: <xmr:3U-OZsZqfgXhFY1ajtEToPIk9dVUS1w6loSjbE9HT7X6wv5H_XOPDtSTyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfedugddufecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
 veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:3U-OZnXGLFJbUSOjSyXKt6SYFIU3zQNvT0Dpj0KPznD5jE2LdDEjRQ>
 <xmx:3U-OZilifd0nEzUupksHvGfKskqpc2aILL_AdkRaHOopNcUiS6L98A>
 <xmx:3U-OZsc9RoH0ugh-RgfcrlayvADLZdyY2xH8RGbI0pI3kmQJrIL2SQ>
 <xmx:3U-OZkGpeh5OE2LEjCsdI7uI13Jg309TWw12iQu83PRfXbn-awLZTw>
 <xmx:4E-OZpt9ABc_i4lbaAlaZ6rHgMk-JOhHNiN18LQhAj7_elJeytPswqQS>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jul 2024 05:09:49 -0400 (EDT)
Date: Wed, 10 Jul 2024 11:09:43 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Cc: Ayush Mishra <ayush.m55@samsung.com>, qemu-devel@nongnu.org,
 foss@defmacro.it
Subject: Re: [PATCH] hw/nvme: actually implement abort
Message-ID: <Zo5P18w2P0jbmgxL@cormorant.local>
References: <CGME20240702133144epcas5p22b982613bfbfce0e7ad0c74fd72a7956@epcas5p2.samsung.com>
 <20240702080232.848849-1-ayush.m55@samsung.com>
 <ZoQby9WzEesIhuLz@kbusch-mbp> <ZoRNKb_u5SW3Ts0e@cormorant.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MMwpjxQe2z0AZVYP"
Content-Disposition: inline
In-Reply-To: <ZoRNKb_u5SW3Ts0e@cormorant.local>
Received-SPF: pass client-ip=103.168.172.148; envelope-from=its@irrelevant.dk;
 helo=fout5-smtp.messagingengine.com
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


--MMwpjxQe2z0AZVYP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul  2 20:55, Klaus Jensen wrote:
> On Jul  2 09:24, Keith Busch wrote:
> > On Tue, Jul 02, 2024 at 01:32:32PM +0530, Ayush Mishra wrote:
> > > Abort was not implemented previously, but we can implement it for AER=
s and asynchrnously for I/O.
> >=20
> > Not implemented for a reason. The target has no idea if the CID the
> > host requested to be aborted is from the same context that the target
> > has. Target may have previoulsy completed it, and the host re-issued a
> > new command after the abort, and due to the queueing could have been
> > observed in a different order, and now you aborted the wrong command.
>=20
> I might be missing something here, but are you saying that the Abort
> command is fundamentally flawed? Isn't this a host issue? The Abort is
> for a specific CID on a specific SQID. The host *should* not screw this
> up and reuse a CID it has an outstanding Abort on?
>=20
> I don't think there are a lot of I/O commands that a host would be able
> to cancel (in QEMU, not at all, because only the iscsi backend
> actually implements blk_aio_cancel_async). But some commands that issue
> multiple AIOs, like Copy, may be long running and with this it can
> actually be cancelled.
>=20
> And with regards to AERs, I don't see why it is not advantageous to be
> able to Abort one?

Keith, any thoughts on this?

--MMwpjxQe2z0AZVYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmaOT9cACgkQTeGvMW1P
DekgSgf+LqM7ajy4xipZeGqf/koC4JZ1ql+56iCGqb2xZaKddLDtrnWFuTUcwN7S
4IxEudzWbqq++zZXV/pzflxcXWAdd7P3uMgo259p2hSmieATerFZdoi+oB+UpuDV
svCgMStmCrusJTnvbszLluXnTzBDobPACMb7EVUSkL3YKA30Fp4VOdHQrS1gEg7L
Ee9xJ1Qcc0Z0L7CvZRSuZD7S/4/iOGW3nfn5Ljdrxz6UVpDD8ZmMy4/vMkJN9Yf5
3CB/mES9dM4JPbdDgCuBKEAQt52o8CWUZtQpHufO87CeT8QJ9N7umTFzJSorfvgj
IvebBdBii6L1cQlmPsvsYHTDcIvBfw==
=9URF
-----END PGP SIGNATURE-----

--MMwpjxQe2z0AZVYP--

