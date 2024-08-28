Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A31C5472D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 07:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjD64-0008UB-2w; Wed, 28 Aug 2024 03:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sjD62-0008Sy-FY; Wed, 28 Aug 2024 03:28:02 -0400
Received: from fout8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sjD60-0003A5-81; Wed, 28 Aug 2024 03:28:02 -0400
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal
 [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id E112C13900B6;
 Wed, 28 Aug 2024 03:27:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 28 Aug 2024 03:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1724830078; x=
 1724916478; bh=+EHeWOHZT5Yu13qDrsGulqzLWgptwcPZGD66kBuXGvU=; b=Z
 J1m8PWDc/oJ25ZzSlqRc1rsJYJXhyWrhISt7fvF/ofA7TItJhiI93TUxFKh2yEpx
 wjq2FC1YS3ZeUNPstaljivv/QNBGKT0PqQWv+HQQGCGyrUCOrulDQavMd7QcmdHG
 X7SkYyHQPZO0jjVcj6+Nt8OnfTOV6+7abMolJm8lFWbYDLq7F1ci/L8T5AGCnNOx
 cl11e0WUJBG8ffJ9FeWleHkQnE5uoB0+bX+mVoB3wWNJv9Z0gaNwN+fhYzNyWz/A
 ifugeA1l/YO/R8A2R4nYiaBzTpOJiuA2/jelmjH+K78c/Tz8qVTb577SUngJtYQG
 Y+nxJnsBNhXyR3KC2ZpeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1724830078; x=1724916478; bh=+EHeWOHZT5Yu13qDrsGulqzLWgpt
 wcPZGD66kBuXGvU=; b=Qf+xxc1e3IBxtZAfVxrKj3S+eiqs1CVLsXj85s0eQGSm
 MT/1DhlT7c/Q255enxj65xV2cwP7cSWPGMKQKrBipwgBwvCHdq9efphSwxs0W4cP
 ZHm9zCa9QxzAFJEiBYWTt/N/JgSDyvF0TVgSdQe+BYe4Z/xEhuQxYs0dRWaYXwmM
 ZF94XUEFRZq5vYKxpAKtW2W2bqsC6Nz9cLy7s0b6zf2ZlMmPZ1MSzLUxtKkoScVN
 1op3aRe8yBDCC6hZxJOWWQNzI6bFVNbXUbk9gf2vCUjn6IsMBRwRGwvWl3QWsDgt
 bQRDArZWyURhPFhZag2mRyK4dvzwCItH4iQkHhv8IA==
X-ME-Sender: <xms:ftHOZjcoXf1kTtL96FquddvRYiGkEGKhoNStDHx6r9no-lZIfuHbLg>
 <xme:ftHOZpOldZ9ql6GuqLYcAzm4PqTZWe2zWRey8htPglKaOmY1Y-ZD37QGsbOVVum92
 ZRlSLfz9Cdp6ZY-7fY>
X-ME-Received: <xmr:ftHOZsjpvayEYZmPvl0JEIB3jYuPRVOkNf9ySmB5SKc7LNU0WWD41yjcGdvXdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefuddguddvvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
 evuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushculfgvnhhsvghn
 uceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnhepjefgje
 efffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffffjeevnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlh
 gvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdp
 rhgtphhtthhopehluhgthhgrnhhgqhhirdduvdefsegshihtvggurghntggvrdgtohhmpd
 hrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgtphhtthho
 pehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhifohhlfh
 esrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhrvghithiisehrvgguhhgrthdrtgho
 mhdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
 epfhgrmhesvghuphhhohhnrdhnvghtpdhrtghpthhtoheprhhonhhnihgvshgrhhhlsggv
 rhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgsohhniihinhhisehrvgguhhgrth
 drtghomh
X-ME-Proxy: <xmx:ftHOZk-mKWYMNlWzfwgn2_eWoRRagVEkwmzAaGqqMxYZ4YYG5CJHgQ>
 <xmx:ftHOZvuNPvoVjAdx-bIQ96TpgSEv1jNgUike-U_6KSgHg8vVtwB0Gw>
 <xmx:ftHOZjGSfM5eYWHEZo-Rley8YzcOo5Mw1SIKvSrhN9B44jMXMCvIpQ>
 <xmx:ftHOZmPWK4xL9T7mAYardTj-TPIF9GMHJqJYMjqlD6nuIYu3aow-HA>
 <xmx:ftHOZo94yXTGpi4fseSVFSaGM4X2IySxk2NB-WWJqJ3nwzui4Xt4nGb3>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Aug 2024 03:27:57 -0400 (EDT)
Date: Wed, 28 Aug 2024 09:27:53 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: =?utf-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [External] Re: [PATCH v9 09/10] hw/nvme: add reservation
 protocal command
Message-ID: <Zs7RecGJzBD1yTMA@cormorant.local>
References: <20240712023650.45626-1-luchangqi.123@bytedance.com>
 <20240712023650.45626-10-luchangqi.123@bytedance.com>
 <Zs7I3AAzsO2Xe5iG@cormorant.local>
 <CAO5cSZCkHCM0nrgQO4ykJ808UCxF-TEy7_0zkA3LDaZ0S8zyCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6LlipYTCtAli3XuJ"
Content-Disposition: inline
In-Reply-To: <CAO5cSZCkHCM0nrgQO4ykJ808UCxF-TEy7_0zkA3LDaZ0S8zyCg@mail.gmail.com>
Received-SPF: pass client-ip=103.168.172.151; envelope-from=its@irrelevant.dk;
 helo=fout8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--6LlipYTCtAli3XuJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 28 00:20, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
> Hi,
>=20
> I want to know if I understand it correctly.
>=20
> ```
> static void nvme_aio_err(NvmeRequest *req, int ret)
> {
> uint16_t status =3D NVME_SUCCESS;
> Error *local_err =3D NULL;
>=20
> switch (req->cmd.opcode) {
> case NVME_CMD_READ:
> case NVME_CMD_RESV_REPORT:
> status =3D NVME_UNRECOVERED_READ;
> break;
> case NVME_CMD_FLUSH:
> case NVME_CMD_WRITE:
> case NVME_CMD_WRITE_ZEROES:
> case NVME_CMD_ZONE_APPEND:
> case NVME_CMD_COPY:
> case NVME_CMD_RESV_REGISTER:
> case NVME_CMD_RESV_ACQUIRE:
> case NVME_CMD_RESV_RELEASE:
> status =3D NVME_WRITE_FAULT;
> break;
> default:
> status =3D NVME_INTERNAL_DEV_ERROR;
> break;
> }
>=20
> trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), status);
>=20
> error_setg_errno(&local_err, -ret, "aio failed");
> error_report_err(local_err);
>=20
> /*
> * Set the command status code to the first encountered error but
> allow a
> * subsequent Internal Device Error to trump it.
> */
> if (req->status && status !=3D NVME_INTERNAL_DEV_ERROR) {
> return;
> }
>=20
> req->status =3D status;
> }
> ```
> In the above use case, if it is a pr-related command and the error code
> is not supported, the invalid error code should be returned instead of
> the Fault error code.
>=20

Yes, as far as I can tell from the spec, if a Reservations related
command is issued on a controller/namespace that does not BOTH support
Reservations (i.e., in ONCS and RESCAP), then return Invalid Command
Opcode.

--6LlipYTCtAli3XuJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmbO0XgACgkQTeGvMW1P
Delr1wf/eTrHuX6h22UhUW5flw2cxGUxCTqiQpkxv+szqXXhVh3dbbgS5h9Yrv9l
N+NbDQ3ImkH657v/S+uzibKH4bZzZzPS7WtZjuePWWZlAPcf73UAjKoJTHL/K0zG
mErE9hwI9V66QfYpqv/qZA1wGGmGUyS2vWaY1+202Rn2w8nCVYmxktm59xTwQsWM
L4hfsQP2Bbz0/1Olk/ynX6ioAfofpN7fd1WbrShXonKw6qI5i0j21sJg/fttYT1X
dUFo5Ywn6xC/xo8kIwiBYTqwi8TGSrSZ5CkF/ad0Lnx67VO8EcequOuhnTnia2gP
+ST7lnk1cbMdqN4jBiCbbGvmkFcE8w==
=X2hS
-----END PGP SIGNATURE-----

--6LlipYTCtAli3XuJ--

