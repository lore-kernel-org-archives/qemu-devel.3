Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0FFCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 10:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrbZb-0007Y2-UB; Tue, 02 Apr 2024 06:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rrbZO-0007VW-4Z; Tue, 02 Apr 2024 06:40:51 -0400
Received: from wflow6-smtp.messagingengine.com ([64.147.123.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rrbZA-0007R1-FI; Tue, 02 Apr 2024 06:40:35 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailflow.west.internal (Postfix) with ESMTP id 79EC52CC012E;
 Tue,  2 Apr 2024 06:40:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 02 Apr 2024 06:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1712054420; x=
 1712061620; bh=ouACABr9NP1bin1bM5KhmKIQ/eCmcokAYF2vMuWnl8o=; b=Y
 7PbHul+tPmsy6HrVegW1OcL5gLksipVWQu/Eg8ycwEzUXag4l1NqnQdbHh1rEYnD
 kPyg7QmZXT1i16mz3EQ64nbjmZxg0VlJLnGTuWorRJ/CLsLnQfG+1B5qTdcKiaQV
 EHqOREdErmL7S8HZ4Fq/Ah7Io7JtOloXu+QOqPp9/ZVPEqMhY06em1zj7PpwUTBp
 z3yMGUx85iOPsNE/XcC6RPT+ATgvFQsPEZmK2GJWpGZur5wGLkW6Enx7uGTxfr60
 ZpQLSW6vlfGdT3HdSukxKRiu1mERKLnCsq9+jfGcAOD8XcGO/UHRz/V9iFQL+Zad
 5msmihEHOGlmv2H0H8DMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1712054420; x=1712061620; bh=ouACABr9NP1bin1bM5KhmKIQ/eCm
 cokAYF2vMuWnl8o=; b=Dnr+Wkm2UqIauZjMi5vI8Boxkxz/ccrdEREvEp9NdWSU
 lNTcGzqnOIFFsdRAMZnmsq4uHny2zxVa95xK/MarQlJyuNhELDAePVRn1nt+AgOb
 hWqJJqRnoULAZQvrtHum7m8FNXCzoqgxTqNm8PY6g4JimgC3LG2ohFDnpwbVb23H
 DpQtanCX6/MWij5FIigogKKaGdDEMvQh5mMrBnFDRlUf9bKzTBvdCQ676DmlRLs7
 RejO5c3femjFUwy9uFQNaBdkpBmSJ5SqJoI3LlAtTcWjfH+ATf9U7TKfb9j2EMxc
 Z6jUflZrh7Ml5AbQCZq1pwLCH6yNwC5mNAUosaNpzw==
X-ME-Sender: <xms:kuALZrcy1a99AId8VuZxauQoFtYoFwvFKtRusdeugcRHnqxbljpAjQ>
 <xme:kuALZhMeASQgbnBu7RVQEigxfwV13dbkzWnfkuFO_2H-4vFj7_fTvHC4KKsKvhlFC
 Wv7F5WnQXAAWm0YAwA>
X-ME-Received: <xmr:kuALZkg4Y4Ak4w7OBv6tdz1VNkgUocheItx5w_E75hfGagbhu9FmkL8kw_rn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgfedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:kuALZs8SE2ZHhqHG7LQOxIAZB2fRecxbsnYJWzwgQUfzogpDPaeTVQ>
 <xmx:kuALZnvAHK7jKOM9V1zn8S48nvl3lqKaNKH0RllV71ItJIAzQlWUNQ>
 <xmx:kuALZrESd5N8-CmLr3laUv6sU4bLLe0A0F4k6SaB-PJwJWbDzwrZBw>
 <xmx:kuALZuOMR_CFq_T6959rUCvES0DlJsZDjhoyqzqQGvJE_PwM4OGDcQ>
 <xmx:k-ALZrD91Mw9TubV1ZEs6hYknfk65sLxcDcN81dmeqwvmjCo37GPZ-BV>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 06:40:17 -0400 (EDT)
Date: Tue, 2 Apr 2024 12:40:12 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,	Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org,	Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,	Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>,	"Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 17/19] hw/nvme: fix -Werror=maybe-uninitialized
Message-ID: <ZgvgjEnKiEAEYB0N@cormorant.local>
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
 <20240328102052.3499331-18-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TgejOZZuv9UEq02T"
Content-Disposition: inline
In-Reply-To: <20240328102052.3499331-18-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=64.147.123.141; envelope-from=its@irrelevant.dk;
 helo=wflow6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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


--TgejOZZuv9UEq02T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 28 14:20, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> ../hw/nvme/ctrl.c:6081:21: error: =E2=80=98result=E2=80=99 may be used un=
initialized [-Werror=3Dmaybe-uninitialized]
>=20
> It's not obvious that 'result' is set in all code paths. When &result is
> a returned argument, it's even less clear.
>=20
> Looking at various assignments, 0 seems to be a suitable default value.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/nvme/ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index c2b17de987..127c3d2383 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -5894,7 +5894,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeR=
equest *req)
>      uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
>      uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
>      uint32_t nsid =3D le32_to_cpu(cmd->nsid);
> -    uint32_t result;
> +    uint32_t result =3D 0;
>      uint8_t fid =3D NVME_GETSETFEAT_FID(dw10);
>      NvmeGetFeatureSelect sel =3D NVME_GETFEAT_SELECT(dw10);
>      uint16_t iv;
> --=20
> 2.44.0
>=20

Thanks!

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--TgejOZZuv9UEq02T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmYL4IwACgkQTeGvMW1P
DemY3AgAo7OaZ+ZzYhAiQTN8c3Xwo3J8g/taDXAFp+wtUAsQK6UA8m9WWgZcvs7I
RRNlD4BIr6MI2cONaC0j484uE192SlkYvnpNuf7l827bowejqtrB+/NappgqMUWG
+C9bQd11FA5AgUVCIfgWdvhV312FyqTASJNXBK+Xl9WYCEG1LrbKQAX8s1JXhiOJ
t3wZ4TKbFRJAWCsYaiHtLzyQpbH0FQDS9RxLAn2F12Ecb/g8jORDAkLIMNzF2pVm
YELgkBYOHQF45MXzP8vCnYmhg5nZFd08nCEA5RamLlPWjOpOTlTUe1D43M2NpUl6
iWQJPND5ZFOpOsWnARbeQk4J6vod5A==
=udwf
-----END PGP SIGNATURE-----

--TgejOZZuv9UEq02T--

