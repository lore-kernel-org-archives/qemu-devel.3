Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D34CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3sVF-0007f2-10; Wed, 01 Oct 2025 04:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1v3sV9-0007V4-6j; Wed, 01 Oct 2025 04:47:56 -0400
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1v3sUD-00010P-Kn; Wed, 01 Oct 2025 04:47:51 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id EE2BD1D000EA;
 Wed,  1 Oct 2025 04:46:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 01 Oct 2025 04:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1759308400; x=
 1759394800; bh=fZBo6p6H3VfOscdNy7C1CBZQBV5BBk4yJvi9gfdI9Sw=; b=m
 gV2CuVv3nxN4axhm/elfpqBgn5t1PdR2/jK9cG/3hNsRocDe3sdcjGtpSrxbJLQf
 o7K59HY9ruH5j6OSCj+V1sqpGC+5EoCTuzbezDj6KffTyqO2nFo1TojbkMz+K912
 4AmAm6Uv1ettkFHlaFvivFjrwp9LHcxTrZ036XxFrlvs2MWOJbzBjXzGJy/2iU2N
 lDC/gVNzaW9pM1jHNMrBDelCYK1aLcpmukDb707mBNfK1HDQQ4YEpp0gIUNYL8Sg
 ZDJixZlt1Lw9N58teVm1tolHbC0YlTPxrZ52jO7wM70pNTFtcfXUeMZ43nUO7v3+
 JfNeFoKF0KQV7f46+KSHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1759308400; x=1759394800; bh=fZBo6p6H3VfOscdNy7C1CBZQBV5BBk4yJvi
 9gfdI9Sw=; b=t3dovezy9ViP3bkHPWl7DlmEAcvEPJndO3xUPAGDfo8QYLgh4SC
 /jeHgWUyrvKZc9UD20nax0BnER6lLL9YZUk9aMeqJ3rGoq+OpleJNQvBwDlL8jTg
 pUrGrOE5HK8rVxo1uHUXxAtNnBdn0McPYZI5on7cCYExn4LknptSpdusz1V06JP5
 U/WQjEfcWBQcP4L7Y0q/bBCZXU8dk/6WgUsfd98iQ58Ld3g744rBR/G/vdTAOkMg
 jGIlSoxVFkPTYzNMqxcVDbI7Q2aGznB1wXnmTKGnxs6LFyJT87BMGMyXgWbcvyQW
 v/icdc1DwymFhjPl5EhRnxGqbxp1K/8jl4g==
X-ME-Sender: <xms:b-rcaE8UvEkjAx_bef2DmlGKIwHNYgMfeQc7esE4mv74FBuXb7gQzg>
 <xme:b-rcaMLDjrXgY-IGI7h6mq6qRR-WlGxOVNhgX7eNEgpBD6uB_uhQVhBYnBeR7YAIk
 P-TJNk7c2SvTF3DZgEuYfkHGnWAWVcJEILqA6T21gNQLwQsGrTLmiE>
X-ME-Received: <xmr:b-rcaLGqrNgMMY0V1AJEy5t92xqd3ZZUx5KEl_8lophRW4QHZuH5bSAUNADnawZ9JkFt5tdkEYtnEyj9peENhCrLM36-lC_dAG9ldBxsGXaB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekvdejtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffejveen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhsse
 hirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtohepfihilhhfrhgvugdrohhpvghnshhouhhrtggvsehgmhgrih
 hlrdgtohhmpdhrtghpthhtoheprghlihhsthgrihhrrdhfrhgrnhgtihhsseifuggtrdgt
 ohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
 hfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgv
 ughhrghtrdgtohhmpdhrtghpthhtohepfhgrmhesvghuphhhohhnrdhnvghtpdhrtghpth
 htohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopehkfiholhhfsehr
 vgguhhgrthdrtghomhdprhgtphhtthhopehhrhgvihhtiiesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:b-rcaIwmtm8UtPUqG3no16zCs6Lf-qww3IHIu4eaaBP8K9L6uWvy0A>
 <xmx:b-rcaM6hI4nVXve1KHdpHuGkRC0cYu81nFejeytdyw2McGvkC8dQAA>
 <xmx:b-rcaFfIBIx7qDjn6W8cIJOCzPk2YvJbEMX033RFYGwcQVfP7yOQGA>
 <xmx:b-rcaLGB5ibEoTV97AwQyLW-LC85ecVPFP6D0wgG6Vsysf38vfRozg>
 <xmx:cOrcaCf9YvUxWnYkFdMVFk8XwU1VGUDOs4U37grgxibjQXos-cDORqJY>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 04:46:39 -0400 (EDT)
Date: Wed, 1 Oct 2025 10:46:37 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v7 2/5] spdm: add spdm storage transport virtual header
Message-ID: <aNzqbYmO6jkT9-9-@AALNPWKJENSEN.aal.scsc.local>
References: <20250912021152.46556-1-wilfred.opensource@gmail.com>
 <20250912021152.46556-3-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zv4Bx/x3pYHfgncu"
Content-Disposition: inline
In-Reply-To: <20250912021152.46556-3-wilfred.opensource@gmail.com>
Received-SPF: pass client-ip=202.12.124.150; envelope-from=its@irrelevant.dk;
 helo=fout-b7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--zv4Bx/x3pYHfgncu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 12 12:11, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>=20
> This header contains the transport encoding for an SPDM message that
> uses the SPDM over Storage transport as defined by the DMTF DSP0286.
>=20
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>  include/system/spdm-socket.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
> index 29aa04fd52..80cd7021c1 100644
> --- a/include/system/spdm-socket.h
> +++ b/include/system/spdm-socket.h
> @@ -88,6 +88,18 @@ bool spdm_socket_send(const int socket, uint32_t socke=
t_cmd,
>   */
>  void spdm_socket_close(const int socket, uint32_t transport_type);
> =20
> +/*
> + * Defines the transport encoding for SPDM, this information shall be pa=
ssed
> + * down to the SPDM server, when conforming to the SPDM over Storage sta=
ndard
> + * as defined by DSP0286.
> + */
> +typedef struct {
> +    uint8_t security_protocol;              /* Must be 0xE8 for SPDM Com=
mands */
> +    uint16_t security_protocol_specific;    /* Bit[7:2] SPDM Operation
> +                                               Bit[0:1] Connection ID */
> +    uint32_t length;                        /* Length of the SPDM Messag=
e*/
> +} QEMU_PACKED StorageSpdmTransportHeader;
> +
>  #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
>  #define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
>  #define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003
> --=20
> 2.51.0
>=20

The above struct is specific to the communication protocol with the
specific SPDM server, correct? It's not defined by DSP0286 as far as I
can tell?

--zv4Bx/x3pYHfgncu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmjc6moACgkQTeGvMW1P
DemPUggAojTeHKZmZV8nsbkDBUj9AWSks3mpLDDDgfdM4GWPtg/Wm+BaGnoMb2nR
1KRJzIh1S0UgaRYE+hZ1aHqR1Rv0aHpC9MVMnFbmw2+SnxNtgMMgssgdoYW3RLw0
0HCYSog6fl3AcI6DDBhLT5Y95lY/zVDClQ6elzp4upqUERUn33MSjmc6RkdRdKoO
AhbvXb7Grwuwc2PBurmWTHxARRlnggVljXBJgMgOdXSmmsl1j7VnfbaaLfaliiV6
2Fpl1//jeDZCUmQxjgi5HfGQlsg8fITKrN8lXfnZVFDCDgPEW8X5NskGkildcvjU
LwubAK69mIXcE1nGdn2D6Dtx25NaEQ==
=Wqo6
-----END PGP SIGNATURE-----

--zv4Bx/x3pYHfgncu--

