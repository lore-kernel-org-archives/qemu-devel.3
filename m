Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED3FC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 08:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPHFL-0005Jz-Ey; Wed, 11 Jun 2025 04:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uPHFJ-0005JQ-Bm; Wed, 11 Jun 2025 04:55:45 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uPHFH-0005sT-2t; Wed, 11 Jun 2025 04:55:45 -0400
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id AD76813804FB;
 Wed, 11 Jun 2025 04:55:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 11 Jun 2025 04:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1749632139; x=
 1749718539; bh=szgnzdUoHOuwLT3WmiJB8t5r72SSVz+GGLmXxx3C8Vk=; b=l
 d/uHH4WgS91pGopMXztideSYxII0c23/KdDXOPX6ux20oDFGPgwD6DuI+06cY1Zf
 tBJ05BHmwohUdhDoOBbF+GQCLu+6NDGFkyP6249r09ayif3xwv6SEkYSLfDRKNnm
 snbHjsUJ/TLTlr3c3FQBZJTAGcI84Go6CHjCZ5pDEkvSIDAVNlONArWxQeQjPegG
 H4HTIXibMXF7FgA/K09wn+yY7B/rMbafMO63vaFONq9senGbO3eyaSg31vJVM09s
 VyubSW4sVCXV7nbY22RIgquOp7gBBw6yomp/1GDoT5TkbdSx7ibh2Q2MX1G6giYj
 aRcHAeSXo+53OptjrPj8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1749632139; x=1749718539; bh=szgnzdUoHOuwLT3WmiJB8t5r72SSVz+GGLm
 Xxx3C8Vk=; b=cM08dFpiazcj6dFU9YGqVxC15eSwA6J0Fz4ihfFzBtWsawdqMSv
 ggowC5UVBuARUQuhqaosF5ktlgV8NcXPzjBQBky5TWtPzDc2RKWhVvoxD4l3PKuR
 JBizRMkgcFXTJfFrL4EaKyFW4falP4lmC01UnKhXgX80Yf6U1JMOUf6gNslZPki8
 D/TxdRdiOqtbTG6ZHbq7rmDCDglWWuj9yPUPCsVFpRlsh9qNjBmWmI63T9JuQ6Th
 gA0P0aNPoJ43mcHirr6HWVzvrxSkfUXK5hKzlWreYpiqPqKs2i4RLNF3kOl/2p3S
 KVdckZo1JkGVI9W2F7yoHLhT5JVYsuQdAOA==
X-ME-Sender: <xms:ikRJaKAxTGco1_KesAcNKm0qZ8nSWWiCOFJj0196R53J2jgcWWWWaw>
 <xme:ikRJaEj9fDcJLwpa7jpegy5mtOfdbMLL3TXtylBXbD7sxGpz51hcdwx382qifTitn
 UzxI6Ha-VLY0FYt6k0>
X-ME-Received: <xmr:ikRJaNnfhtF-aX_AJ7JZ6irkrCUH8uLYQI7DYpBCzo00VMGXAfrD-TK129oUXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudeljecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttdej
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeeivefffffhledukeehhfetueelkeffudeuieek
 tdegtefhgeefleeiudelveelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghrrhgrnhhgvgesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdr
 ohhrghdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhrtghpthhtoh
 epmhhsthesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghl
 lheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhngh
 hnuhdrohhrghdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhr
 tghpthhtohepkhifohhlfhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepihhtshesih
 hrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:ikRJaIyxeTLtS1cWmjYxd5qgYduzMUfc6s01DOWbAQtl9QXUtTP9nA>
 <xmx:ikRJaPQkqCQxu5MwGwAJRtD02iFUOuBiS_htrqLCi9SOQkdGikjVVg>
 <xmx:ikRJaDaQodbyJXgnOKYYiy7KviO-8Nop2W_dMBa2jLw-u19k_qPUnA>
 <xmx:ikRJaIR8wMLaDmrTbqGzSlcgodEAvyBhz4SJQ12MDIhabG-e_5bL7A>
 <xmx:i0RJaICARpcZonYwolqMrxCFXIaBNRB9adRiDghuQMN44xvjwHuRscKn>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 04:55:38 -0400 (EDT)
Date: Wed, 11 Jun 2025 10:55:37 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 23/31] hw/nvme/ctrl: skip automatic zero-init of large
 arrays
Message-ID: <aElEiSvlOBIbjtzd@AALNPWKJENSEN.aal.scsc.local>
References: <20250610123709.835102-1-berrange@redhat.com>
 <20250610123709.835102-24-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E+ZanLtZY22kH0kM"
Content-Disposition: inline
In-Reply-To: <20250610123709.835102-24-berrange@redhat.com>
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout-a1-smtp.messagingengine.com
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


--E+ZanLtZY22kH0kM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 10 13:37, Daniel P. Berrang=C3=A9 wrote:
> The 'nvme_map_sgl' method has a 256 element array used for copying
> data from the device. Skip the automatic zero-init of this array
> to eliminate the performance overhead in the I/O hot path.
>=20
> The 'segment' array will be fully initialized when reading data from
> the device.
>=20
> The 'nme_changed_nslist' method has a 4k byte array that is manually
> initialized with memset(). The compiler ought to be intelligent
> enough to turn the memset() into a static initialization operation,
> and thus not duplicate the automatic zero-init. Replacing memset()
> with '{}' makes it unambiguous that the array is statically initialized.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  hw/nvme/ctrl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index fd935507bc..220002830d 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -1057,7 +1057,8 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, NvmeSg *s=
g, NvmeSglDescriptor sgl,
>       */
>  #define SEG_CHUNK_SIZE 256
> =20
> -    NvmeSglDescriptor segment[SEG_CHUNK_SIZE], *sgld, *last_sgld;
> +    QEMU_UNINITIALIZED NvmeSglDescriptor segment[SEG_CHUNK_SIZE];
> +    NvmeSglDescriptor *sgld, *last_sgld;
>      uint64_t nsgld;
>      uint32_t seg_len;
>      uint16_t status;
> @@ -5128,7 +5129,7 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_=
t rae, uint32_t buf_len,
>  static uint16_t nvme_changed_nslist(NvmeCtrl *n, uint8_t rae, uint32_t b=
uf_len,
>                                      uint64_t off, NvmeRequest *req)
>  {
> -    uint32_t nslist[1024];
> +    uint32_t nslist[1024] =3D {};
>      uint32_t trans_len;
>      int i =3D 0;
>      uint32_t nsid;
> @@ -5138,7 +5139,6 @@ static uint16_t nvme_changed_nslist(NvmeCtrl *n, ui=
nt8_t rae, uint32_t buf_len,
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> =20
> -    memset(nslist, 0x0, sizeof(nslist));
>      trans_len =3D MIN(sizeof(nslist) - off, buf_len);
> =20
>      while ((nsid =3D find_first_bit(n->changed_nsids, NVME_CHANGED_NSID_=
SIZE)) !=3D
> --=20
> 2.49.0
>=20
>=20

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--E+ZanLtZY22kH0kM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmhJRIYACgkQTeGvMW1P
Den57gf/f7SkkSOlTkoyRcHscWfId/XmYcxWyvmxVzj79uBL0FR/1RJmYPlbhZ0D
kCSEcSxdC3t4CPwfqLVE4Pf1kYN0hMsehYm29VMdl4mb+sY+zUXIFWmOsM3yOVhL
7AhPIXYS8msqIAMo3aAyVVaOBb/mgwc53BeNwNH4+v/IFnnStmswJkgKEUfDUZ7f
EH7s1wi8H/t3Dct41sN9PoqHSvHe7GQ9WGfQoljoEA0K5CEunvAue1241vWGrTfJ
8pj8Q4oTZ75IRWbg92DNbYpfCOjinkzcpklT1/2WRY+0hMWiF6dtUtUJpQciJmgp
oGRyIhWJm1NJ4bywanpqm3OLGlyZPw==
=x6y4
-----END PGP SIGNATURE-----

--E+ZanLtZY22kH0kM--

