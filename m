Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E401CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vENhd-0007Xt-UA; Thu, 30 Oct 2025 04:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vENhb-0007XC-6E; Thu, 30 Oct 2025 04:08:11 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vENhY-0001uD-DM; Thu, 30 Oct 2025 04:08:10 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 048DC140018F;
 Thu, 30 Oct 2025 04:08:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 30 Oct 2025 04:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1761811683; x=
 1761898083; bh=/3QYjGTp1OFaxWBx8XJ1huB8mMWVb66+F/yey7XPPJo=; b=l
 qBavK0Dpl4aPa3YLkBaSo1dNRMP5VVmmeXjxrNV5JjiK2J2WCd4GrIZrvCWxlGPY
 EMJqUwQ0O2MnsejTLE+yHNF2+auN3tNcmlh8CmXk1ZDzgJSywW89wSrqpMPbqn1U
 +38jme3tCNuGy0ItMK0vaX+7INHa8VbILhU3GVW4QAHhYdaQB72nI+6YYNVuiwUh
 Zk+dAJLqIlaKxig+tcJ4eBMBms9SpK0n0II0BtOHyF0E7dszy/oSvw6ZKZ7EdcV2
 pZIf+QqSOGGvJYL9zJPkc+MwHq9OuQkpdC0Rv//GVtcROU2HH3JO5TpxNCyXHREa
 jFlPQI7wKE0O2316fHOwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1761811683; x=1761898083; bh=/3QYjGTp1OFaxWBx8XJ1huB8mMWVb66+F/y
 ey7XPPJo=; b=U5G8aeMt1ZIurQofruJauc2WuDAeIzIpACIeaa33zWRoRpL+41A
 Q2ZpwCHaG6pVUYutWDGXLQGwWMlmiQ9rNtqmOnRocJqYVImtFXGqgG2yclb8X0Co
 bvY+s2D/B5GR7aQo4TwqjmoJjJjTKPbjVr63Ta659qrW8Uhq0uusWrPHXn5MIyiZ
 dbLJu34oNgsaf7Rk2EBVCEWiQOrXHzoCbBWp5etXWnMMJ0yJr5I6S+Fda+BxwUzB
 k5QgzU0VhQjutGqCw4xBzVcAA8hy3oxEevgh0DbsP/QBbY28hOgoC/4+QQxB65OP
 VWSxWOlgFDtULz92opYMKdV/78Uuj7RsELQ==
X-ME-Sender: <xms:4xwDaX3G61vcfocEdOxKcfOpCJnzdCD0fAh5wOPf3O-NGzTVAtU_3w>
 <xme:4xwDaUAZLa8fL-6tbyBboFKU8qQhzJcg1I2IzQvOv426A2AkTRAMm0QWP4wRcoT9j
 0mTTJ0LbouPfNDRbor5HU0Kq6AQjbjM0gUu3_lZ8RjnRSf0rOha61g>
X-ME-Received: <xmr:4xwDaaOBVNlI8gH-qEZwQGQR1ximTDiXfDPQsexEFGUmHgPxA1BUANIsD4rWXv7O1pkxFeASYqx_SoWvVuO6EpEIsRcgnDPCE6w_lAEmhKEr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeitdelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffffjeev
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtoheprghlrghnrdgruggrmhhsohhnsehorhgrtghlvgdrtghomh
 dprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthht
 ohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepkhgsuhhstghhsehkvg
 hrnhgvlhdrohhrghdprhgtphhtthhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdho
 rhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:4xwDaRb_eppZSK4waG61PaS15aUXVh1ymSNmN73vC8xVXJ2-DjgPJw>
 <xmx:4xwDaRvQwWfeZVhlbLAuwTla8mBVcSl2oK2ubxyy6smtxfNdEf4e_A>
 <xmx:4xwDabOs1_cF4y_z0Yy-NN4F0RKKkPos0cn_eZQUrbSR7YihZym8VQ>
 <xmx:4xwDaQ55MUpMpk-I2Ble0HCwnGS_EFND-m43fKymAmd_j5QmrWo4Qg>
 <xmx:4xwDaQ66b4kboqpcYYOVeGfQLEjtZAs3aHKibsLjbxIVeYB2uCvXfi8P>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 04:08:02 -0400 (EDT)
Date: Thu, 30 Oct 2025 09:08:02 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: qemu-devel@nongnu.org, foss@defmacro.it, kbusch@kernel.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH 0/2] Add support for NVMe Namespace and Boundary Atomic
 Parameters
Message-ID: <aQMc4vSkEgsjAaYY@AALNPWKJENSEN.aal.scsc.local>
References: <20250602230458.1073148-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a9I+gAIDwFAgIVLM"
Content-Disposition: inline
In-Reply-To: <20250602230458.1073148-1-alan.adamson@oracle.com>
Received-SPF: pass client-ip=103.168.172.153; envelope-from=its@irrelevant.dk;
 helo=fhigh-a2-smtp.messagingengine.com
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


--a9I+gAIDwFAgIVLM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun  2 16:04, Alan Adamson wrote:
> This patch set is a follow on to commit ebd1568fc732 ("hw/nvme: add atomic
> write support").  These patches introduces two updates to the NVMe subsys=
tem in QEMU,
> both aimed at enhancing atomic write support for namespaces.
>=20
> hw/nvme: enable ns atomic writes
> --------------------------------
> This patch introduces support for namespace-specific atomic write paramet=
ers: NAWUN
> and NAWUPF, as defined by the NVMe specification. The atomic parameters a=
re
> utilized to guarantee that writes conforming to these boundaries will be =
atomic,
> improving data integrity for namespaces that require atomic operations.
>=20
> The patch introduces new NVMe QEMU parameters:
> 	atomic.nawun (default: 0)
> 	atomic.nawupf (default: 0)
> 	atomic.nsfeat (default: off)
>=20
> The addition of atomic.nsfeat sets the Namespace Supported Atomic Boundar=
y &
> Power (NSABP) bit in the Identify Namespace Data Structure, enabling name=
space-specific
> atomic write features. The patch also ensures that atomic write behavior =
adheres to the
> NACWU and NAWUPF parameters.
>=20
> hw/nvme: add atomic boundary support
> ------------------------------------
> The second patch expands on the atomic write capabilities by adding suppo=
rt for atomic
> boundary parameters: NABO, NABSN, and NABSPF. These parameters define the=
 atomic
> boundary size for writes and ensure that any writes crossing these bounda=
ries are
> treated atomically, based on the AWUN and AWUPF values.
>=20
> The following parameters are added:
> 	atomic.nabo (default: 0)
> 	atomic.nabsn (default: 0)
> 	atomic.nabspf (default: 0)
>=20
> If the atomic boundary is crossed, the writes are guaranteed to be atomic=
 only if their
> size does not exceed the values defined by AWUN and AWUPF. This ensures t=
hat larger
> writes crossing atomic boundaries are not subject to partial updates, the=
reby improving
> the robustness of atomic operations across boundaries.
>=20
> See the NVMe Specification for more information.
>=20
> Alan Adamson (2):
>   hw/nvme: enable ns atomic writes
>   hw/nvme: add atomic boundary support
>=20
>  hw/nvme/ctrl.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/nvme/ns.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/nvme/nvme.h | 14 ++++++++++
>  3 files changed, 164 insertions(+)
>=20
> --=20
> 2.43.5
>=20

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

Thanks Alan; merged!

--a9I+gAIDwFAgIVLM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmkDHOEACgkQTeGvMW1P
DemkCggAs33D1hdci6BMyvIRvjFMpoheNbyNad12Ho4kVy06n5Oty1poputcUBFJ
qoUbrnz4oDpxJkQe7xNB9e+qmZG56agwEySzM88fdK76Jl4nPp0htPnPVPO0NTci
hcROAaU9buiwVmSSp7D9Zmj7G9cESSPhjAE6039Fm0A2Yi6Q2HYIUJp4YX2E4s+b
miNQ+OIrQDrY7a7eJrs9OUtPzcoUmDEOdlm2xjeOdxUzHJuJWKP/wj7BjlbkgkyH
uDAr4DNez11xrwOnkts3b4PcEvo/7y0R8GR3Oj9PmzRUJV0rInLSIVuAewqIQmcE
Jf/ZIsNMzQPXG3dswnPBfzu+XAbIFg==
=cl3C
-----END PGP SIGNATURE-----

--a9I+gAIDwFAgIVLM--

