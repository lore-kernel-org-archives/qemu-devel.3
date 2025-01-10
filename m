Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F583E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWAwF-0001W8-9l; Fri, 10 Jan 2025 04:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tWAwC-0001Vl-3D; Fri, 10 Jan 2025 04:04:16 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tWAw9-0005MN-Eu; Fri, 10 Jan 2025 04:04:15 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 106F111400E6;
 Fri, 10 Jan 2025 04:04:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Fri, 10 Jan 2025 04:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1736499848; x=
 1736586248; bh=hUA3nmMhJyK9hdrOaj1evG+66g2Op91EbA0ROtgSIt8=; b=W
 7eHHW1pVWpxZgNuUS/RN1cSeJlpZTTL8PoyND+ZJ+QkIUrc3AoQq2H9DcNShzJKl
 5TnnAaSbGBavhLCgTZfCCHiuDYySH8a8eQ93SA7yAotNCkVkvVQy9/tBL4r8HYJn
 en+pK6TWrmNbTxsEgv0ZlebGPwZ3Zdz80ZPoi8galfl+5UTKtR19QDuu0UM+Qjdd
 mD14g5MWB38x1fMWhWVp8wawNUml9dUFqaR4novhreDYikDuBd4h5NOST3SE51nc
 FG82MOh2bWN0fjt1n25ok42acRZzO436VloMmfOQlbcst3EmNqbDb1Nx07RUX9mk
 HBDgTDpNs/fLlIQSvuZUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1736499848; x=1736586248; bh=hUA3nmMhJyK9hdrOaj1evG+66g2Op91EbA0
 ROtgSIt8=; b=v60LloTLD5PTAEYEcxdbq2PDNN8rIK3hQsxQl/ptIVOhg2Lbu6h
 IJGCcu9+/AzfFMf2x8bFAvliuiV4mULpinrgjcDhSWXctDf2rDMWm4m8oCp+gYOJ
 fikHEF+VQz9xr5veTeuQCEMf+LSUf9z3zlCqITDkZ+LFacspK2/bi5XaHkgHw3Ri
 fVIDBHM3qo6uIKR4pL36tAs/a5BknzDBDjbWGlXZu3QuoUh8IW/ate08AYr36Y6w
 Jehs55Jk4TM3RfLDEfo9Cxg5ZRIMTaYuOWK0crCs2nCm+tmb1zFZCH30pjs5aFPC
 X+v7dHXO1LwGdpQgawRGGnK+x43F6SPreGQ==
X-ME-Sender: <xms:h-KAZ_mDWyKAGP689TffiNxejaSwk7k0Q1b5bJyAWn9vA1YY5qO4mQ>
 <xme:h-KAZy0DC7nWrIjE3md5_iMMa2WMz0AxjuYfdxUG_VYKEwY1DHTwsX-8_gY_CgNjS
 o_f0Dolj2QBNztOEFE>
X-ME-Received: <xmr:h-KAZ1ogZ5mgGg_zspfWl4bCbYjhmrP7cXj5OqsjIT5TgCn3jDVsDZD7zLbN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkecutefuodetggdotefrodftvfcurf
 hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
 kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
 dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhr
 ohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqe
 enucggtffrrghtthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtddu
 udegieegteffffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopedu
 gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfihilhhfrhgvugdrmhgrlhhlrg
 ifrgesfigutgdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhu
 rdhorhhgpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprh
 gtphhtthhopegrlhhishhtrghirhdrfhhrrghntghishesfigutgdrtghomhdprhgtphht
 thhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhoshhsseguvg
 hfmhgrtghrohdrihhtpdhrtghpthhtohepshhtvghfrghnhhgrsehrvgguhhgrthdrtgho
 mhdprhgtphhtthhopehfrghmsegvuhhphhhonhdrnhgvthdprhgtphhtthhopehphhhilh
 hmugeslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:h-KAZ3kO1RscRBfl0WInrGWrDSexlVB3b44mwgmM2icwyhSjfJzSSw>
 <xmx:h-KAZ92jh8biatqZkugHDvLlIpb1gZOqbegbCvIVcOvy2GfnDOvQOA>
 <xmx:h-KAZ2vvm5tuoAxppDQVeHXWrBpMyaU4cmOxRTw85iBXFJiycnXb_g>
 <xmx:h-KAZxWkwE2G8-dHyRemV8vuFKZCZMwBJSFOXM4HZbfMLA2ePEAPcA>
 <xmx:iOKAZ3O26N0eGVlvlIXrJMZnjq2bUku6Xn8RG4XeAG1Tqcxfy6pkP5pF>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 04:04:07 -0500 (EST)
Date: Fri, 10 Jan 2025 10:04:06 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, alistair.francis@wdc.com,
 kbusch@kernel.org, foss@defmacro.it, stefanha@redhat.com,
 fam@euphon.net, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com
Subject: Re: [RFC 2/4] spdm: add spdm storage transport virtual header
Message-ID: <Z4DihskLy0wS9ts3@AALNPWKJENSEN.aal.scsc.local>
References: <20250107052906.249973-2-wilfred.mallawa@wdc.com>
 <20250107052906.249973-5-wilfred.mallawa@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8IKRZgLi89MO+UGB"
Content-Disposition: inline
In-Reply-To: <20250107052906.249973-5-wilfred.mallawa@wdc.com>
Received-SPF: pass client-ip=202.12.124.147; envelope-from=its@irrelevant.dk;
 helo=fout-b4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--8IKRZgLi89MO+UGB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan  7 15:29, Wilfred Mallawa via wrote:
> This header contains the transport encoding for an SPDM message that
> uses the SPDM over Storage transport as defined by the DMTF DSP0286.
>=20
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
>  include/system/spdm-socket.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
> index 2b7d03f82d..fc007e5b48 100644
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
> +typedef struct QEMU_PACKED {
> +    uint8_t security_protocol;
> +    uint16_t security_protocol_specific;
> +    bool inc_512;
> +    uint32_t length;
> +} StorageSpdmTransportHeader;

Does it make sense to pack a bool? Is this defined by the SPDM server in
use? I can't find the definition of this header anywhere.

> +
>  #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
>  #define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
>  #define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003
> --=20
> 2.47.1
>=20
>=20

--8IKRZgLi89MO+UGB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmeA4oMACgkQTeGvMW1P
Dele/Af9Gns0ZZXekLWbWCrJsBlv/l/1jq4Y/HcDHrYHMpBvvPrP9v0IU6XpM8ef
ChWvcHMhOqHw5WKyWJdBdtVlv4P4SRqbpiziDGGE//io3ILAZhtupGBtmOym93cv
iUzD9Xxwqk/OpQupHj5cTC+t6+xKz7WesK+kMgXRytgHfREVFw25sQ5VfJZ7rOCI
O6G+XCgzhlW6hl04EpsbNgvvM6EaqgxhkwbTI9Oj0CROx6qhgIUVp42LU7FkrISg
vGiUundsH3Rck8wWDTVV+bSaJdQCB1TxYI4wDqfhijEqnJiABPQt+c7E7UisxBQf
CRXBPIWcS1gXqmnuYTUPj9OTUfJz1g==
=4Cih
-----END PGP SIGNATURE-----

--8IKRZgLi89MO+UGB--

