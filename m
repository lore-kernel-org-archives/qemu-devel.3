Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1455CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62hq-0004LE-6y; Tue, 07 Oct 2025 04:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1v62ho-0004Jp-DN; Tue, 07 Oct 2025 04:05:56 -0400
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1v62hl-0000pR-JP; Tue, 07 Oct 2025 04:05:55 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 624247A01BE;
 Tue,  7 Oct 2025 04:05:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 07 Oct 2025 04:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1759824348; x=
 1759910748; bh=JY7HMFNfrjCUxX0hvx85OzMn0wAnT6w7ahjuwbeEsKU=; b=a
 cbFQA5DRCixyNfOoD1dadLZIhpclOJnjDMk8SxAZC5PMXD9YIO71r8tFOyzR/8oQ
 Mwn5vjkt3oirx05p3vkazrGx8SPzGuCWfNu3760i7pzLlf/atn7W0FFAwHvA1XSd
 zOlQTOVGxXLpvHN4929vFdd9RxQUXO/EQTOflsAD4AbXP2ESGccC2arxoavb82wY
 luILG+J27g/3Twl7YfVqOJ9fy0qEKAhpBsM3CPAGC+yGXygQd1OgDYbuRPLnSnLm
 HU3imYTImstaoxSyRo2jfCtsQaRl/52unCT3tw6JiGT8BnxCGv4ztjsDU021Cm7J
 JvXScdxNyeqCNnxhnfqVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1759824348; x=1759910748; bh=JY7HMFNfrjCUxX0hvx85OzMn0wAnT6w7ahj
 uwbeEsKU=; b=lzpVCxALMKGmWxJuS/mZpqVyXU5saz8x/cwGPeWX53YzP6kZnGW
 zyC6h0YAp9DbK1PA5+TsOOzUnaKswGl4kEz9qw44ZApZ2X6yqwa+MimItYo4eTkm
 Hco6j5GEbI/D802IaYxA4rJdkSWWSdl6avEglzxpU/UVQdn7zIu4vJhpF2eaoTWi
 hHB1LD3OSMTkP2HwHpRLWJa+OtmpbagTHwNHn/4AqkNTizKYhSAOLG9gqS/ugjhr
 ommoz2H/fR491rSPJfWENS6o253CxpHLYfZCB7R/ZTQlpNug8awu2dXBRZ2LMz6L
 dL4jFlsFI2KDOvL/oS6adUarcbh8ucZ7REQ==
X-ME-Sender: <xms:28nkaP9RjaPxQNkboiufRv3F-DEVm6rzhzAL5_mGRseYd94cxjE7kA>
 <xme:28nkaHsBozQr-j80QFtZetKZ9PvuQ7qLj9T_fkjXgAVMZtd8qCEs_FBsp82RJcovf
 bGKvGdsC0MuVhLs4w0ECzfq0OiMd1OdZqECVjL9TU4QgMTwBXPrADo>
X-ME-Received: <xmr:28nkaPNz42bcTbyXDp5AkVHqws6A1VGWcfqcLHvr-_FYMUp_otiwalenOgArfyZvi53cazHz8hZEH8P42zmtbzxPyYatAHek421MFcc7DbXi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelleeltdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffejveen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhsse
 hirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhp
 ohhuthdprhgtphhtthhopeifihhlfhhrvggurdhophgvnhhsohhurhgtvgesghhmrghilh
 drtghomhdprhgtphhtthhopegrlhhishhtrghirhdrfhhrrghntghishesfigutgdrtgho
 mhdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsh
 htvghfrghnhhgrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdr
 tggrmhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvg
 hlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdqsghlohgtkhesnhhonhhg
 nhhurdhorhhgpdhrtghpthhtohepfihilhhfrhgvugdrmhgrlhhlrgifrgesfigutgdrtg
 homhdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:28nkaMiQvPkRm0wkMSvSr8Eavx-W5ufmd-gVST0h-u10oO59T5O-og>
 <xmx:28nkaB4q2y5ddb9Mj3hZqwU9W0xnUxs0G-bfo_9LTZcHwbXJWuHVmQ>
 <xmx:28nkaD2YXMDSFG4xDnKrNHaoQxsu1JLi5y80s-t26pgqem84yw3vKg>
 <xmx:28nkaMvP79eGP3c332ejFCiB7o6A8HVZkOMlZHqC0UeuYfiwYhXo-w>
 <xmx:3MnkaGCCTwZ88TscOVVL_39s3R4s8qKJTn_lDhfBGo17lJxY5Yxjyp2P>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 04:05:46 -0400 (EDT)
Date: Tue, 7 Oct 2025 10:05:45 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v8 0/5] NVMe: Add SPDM over the storage transport support
Message-ID: <aOTJ2QLZhaLJl3-3@AALNPWKJENSEN.aal.scsc.local>
References: <20251003113945.87962-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F/f2rtjqv9s9eDIy"
Content-Disposition: inline
In-Reply-To: <20251003113945.87962-2-wilfred.opensource@gmail.com>
Received-SPF: pass client-ip=202.12.124.158; envelope-from=its@irrelevant.dk;
 helo=fhigh-b7-smtp.messagingengine.com
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


--F/f2rtjqv9s9eDIy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alistair,

I'm ready to merge this. Are you OK with me sending the pull request
including the SPDM changes, or do you want to take that part through
your tree?

On Oct  3 21:39, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>=20
> This series extends the existing SPDM support in QEMU to support the DSP0=
286
> SPDM Storage Transport [1] for NVMe. SPDM Storage Transport uses the NVMe
> Admin Security Send/Receive commands, as such, support for these commands=
 have
> also been added.
>=20
> With the addition of a new `spdm-trans` CLI argument for NVMe controllers,
> users can specify `spdm_trans=3Dnvme` or `spdm_trans=3Ddoe`. This allows =
for the
> selection of the SPDM transport. The `doe` option is the current default,
> `nvme` would select SPDM Storage Transport for the controller, where SPDM
> communication happens over the NVMe Admin Security Send/Receive commands.
>=20
> Support for DSP0286 already exists in `libspdm` [2] and support for the Q=
EMU
> SPDM server is being upstreamed for `spdm-utils` [3]. This series was tes=
ted by
> using `spdm-utils` as the qemu SPDM server with SPDM Storage Transport su=
pport
> built with `libspdm` v3.8.0, and `spdm-utils` also as the SPDM requester.
>=20
> Changes V1 -> V2:
> 	- spdm_socket_rsp() now uses the new spdm_socket_send/receive()
> 	 functions. spdm_socket_command_valid() is added to parse the
> 	 command value incase some bytes were received (result =3D true) but
> 	 with an invalid command.
>=20
> 	- Added inline comments to describe fields of
> 	 StorageSpdmTransportHeader. Checkpatch generates warnings, but lots of
> 	 existing code does this. The QEMU_PACKED attribute now follows the
> 	 StorageSpdmTransportHeader struct definition.
>=20
> 	- Use extract32() instead of manual shifting/masking in
> 	 nvme_sec_prot_spdm_send/recv().
>=20
> 	- Use g_autofree for send/recv buffer allocation
> 	 in nvme_sec_prot_spdm_send/recv().
> =09
> 	- Added explicit fallthrough comment for checking `secp` in
> 	 nvme_security_receive()
> =09
> 	- Added enum support for SPDM transport type, such that a user defined
> 	 transport type string, can be mapped to the respective enum for
> 	 internal use.
>=20
> Changes V2 -> V3:
> 	- Fixed up the incorrect use of `NVME_NO_COMPLETE` to more appropriate
> 	 NVMe error codes in Patch [3/5]. Note that DSP0286 does not define
> 	 error codes for transport level failures.
> =09
> 	- Removed NULL check for g_malloc0(). Should abort instead.
>=20
> Changes V3 -> V4:
>     - Added integer overflow and MDTS checking for spdm_sends
>     - Use g_try_malloc0() over g_malloc0()
>     - Fixed up endian conversion for command status received from
>       the server.
>     - Added check to only accept SPDM send/receive if the socket
>       has been setup.
>     - Only show SPDM as a supported protocol if the socket
>       has been setup.
>      =20
> Changes V4 -> V5:
>     - Init spdm_socket fd to -1 for NVMe. Allow 0 to be a valid file desc=
riptor
>       for the socket.
>     - Move transport definitions to the patches they are used in.
>     - Avoid splitting SPSP0/SPSP1. Use a uint16 instead.
>     - Fixup up incorrect (uint8_t *) casting in calls to
>       spdm_socket_receive/send().
>     - Default to SPDM over DoE if transport is not specified.
>     - Fixup alignment (style).
>=20
> Changes V5 -> V6:
>     - Minor comment style fixup for the description of StorageSpdmTranspo=
rtHeader
>     - Change spdm_socket_rsp() to directly return spdm_socket_receive()
>=20
> Changes V6 -> V7:
>     - Added an assert() to check that only one spdm socket was setup in
>       nvme_exit().
>     - Merged spdm_socket_close() calls into an else if for DoE/NVMe.
>=20
> Changes V7 -> V8:
>     - Added specification references for StorageSpdmTransportHeader
>=20
> Wilfred Mallawa (5):
>   spdm-socket: add seperate send/recv functions
>   spdm: add spdm storage transport virtual header
>   hw/nvme: add NVMe Admin Security SPDM support
>   spdm: define SPDM transport enum types
>   hw/nvme: connect SPDM over NVMe Security Send/Recv
>=20
>  backends/spdm-socket.c       |  79 +++++++++--
>  docs/specs/spdm.rst          |  10 +-
>  hw/nvme/ctrl.c               | 257 +++++++++++++++++++++++++++++++++--
>  hw/nvme/nvme.h               |   5 +
>  include/block/nvme.h         |  15 ++
>  include/hw/pci/pci_device.h  |   2 +
>  include/system/spdm-socket.h |  65 ++++++++-
>  7 files changed, 404 insertions(+), 29 deletions(-)
>=20
> --=20
> 2.51.0
>=20
>=20

--F/f2rtjqv9s9eDIy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmjkydYACgkQTeGvMW1P
DekdpQf/YcNnx7uT6oPWSQO7/X1e+1EfSq8LB03drfpzrHqVcPu1BkPs3KL+WZu2
dOvIE8m2HtSqOSj5zidIQzSXX2EyEd9YRW/h+VqnmbKVVLzldKUmDftJjEXpLM9e
n5EpJ9HpRKukyG2t/elZBvwe9Gsei/q5gjIq21q8ghrSduBJ4kqKT1/gevKXZT3G
EJtQecVuIr3POakSy1rUgY6h7SMuyNpozuzqKx9vFzdyWBVovjffDm2rf8laq7bL
A/mkUkav8FoSPUsgkq7CzXZi2Wvnj62U2AbhNsSUqJwgpGRTeljWB8MsZ/neGLL+
DBAQj5NhWlUlDaZxkm1+t6MLl3ig2w==
=QJXJ
-----END PGP SIGNATURE-----

--F/f2rtjqv9s9eDIy--

