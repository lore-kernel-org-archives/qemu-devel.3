Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B33C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3sXN-0000cp-AB; Mon, 06 May 2024 03:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1s3sX9-0000c0-6D
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:13:11 -0400
Received: from fout8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1s3sX2-00084U-3W
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:13:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.nyi.internal (Postfix) with ESMTP id 4B5F91380097;
 Mon,  6 May 2024 03:13:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 06 May 2024 03:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1714979581; x=
 1715065981; bh=FnOn90UbIzbektb8O/fqi76ef1wt9a4KE8F/dvxGVUQ=; b=e
 4nulRnS9mXfkymiM3kdL1mfw730z4BBnaF/QuPqr7bv5tQNSGn81MXMaFAhFhxX8
 DccAoOq/NYPvwuUZ8Wxg8166UKaVR851Koay3lw7N0TXNZNmE9A8VErfjm9jY4/W
 yf2u81CHwxWu65HPL9u4kIh8jAI7EU+8Sm4PTDJtXkxljnoYtGWEo27X3MwxNdgl
 Emt5Q/szH1HTUoVACvyGHsllsYldNRM4Dy/V/CzX+kfDDs/sPHYgNXG7Z1SscKKx
 wQqTqvorU+00yQ4Oacva00VGHTJyqKV3Z+PzEW8wnBY9YFby8utwfWUO03Mlzg0B
 U7GPKHKVqyp4P8XNLddaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1714979581; x=1715065981; bh=FnOn90UbIzbektb8O/fqi76ef1wt
 9a4KE8F/dvxGVUQ=; b=h6wR52ROyuRongCnOVL8MDOjn3Jq2HW98GlZAmURBDcK
 e0sWrsRkZsR2zhmVoL6inI5r7opBe7DfWay9aXof0qaeKarbw25N0QlarK/K5vqh
 okjdcN0B+7FCiU0U6iBFxt+qiD5xfHex7gMfvWMWumwc4WNZCO5LjM4D95IszlPz
 zm3+c0wliujG5f3yNv1dlTrF50OJsTqeYH/fcrU/xKFfJXpAJhMYIzP+OKXd460Z
 9ZjnKcTyW+qgdueVzmlT14G20N51l8fpjcwGNAYYyL/yClEnKpCZYJ+zAVWP2fOk
 sw1KyQ4xjk1bAZkyqR7BEtrmfL4x/75YDpZuXh7lUg==
X-ME-Sender: <xms:_II4ZmuAM-i6ONUhdx_DkV5BXJhafxJLA3LSdFixfT2d2Mq7UMonXQ>
 <xme:_II4Zrfr55c6AdMPl67-3dKgu3A3egmJuLxlpl7iC59NjpBlWnc1VGK5dchCpMwIo
 6ZfiIMeOd8JlHvV-Rs>
X-ME-Received: <xmr:_II4ZhwfmgECf8KpM2DRMstwoqJxrJ8CjZhQXzpc9UUqWC4KlGeM_5iFxloK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedgudduiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteff
 ffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:_II4ZhPTRWHq8vgjxgAXYTHkd3UNiX53BBr8uJ2j_Y-Tg23-sj7puQ>
 <xmx:_II4Zm-1JXL_qEN6ubr0rifMp1H0caz4DU4pzOCViFDsNg1VVY2Y3A>
 <xmx:_II4ZpWWSoBap9FODTqXrwBYkkPh7X0NE3Pfr5cXakJ2yO81o5mwHg>
 <xmx:_II4ZveMBR1v7wU1DefBc75SvnIELVbNIQJtUZ_GTZ5PydDqFKeXVg>
 <xmx:_YI4ZtlHnKcy3ap-LEkj1zQfHo_IFRkU2ouU2u7QwXb8nilx7a-x1SWt>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 03:13:00 -0400 (EDT)
Date: Mon, 6 May 2024 09:12:55 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Vincent Fu <vincentfu@gmail.com>
Cc: qemu-devel@nongnu.org, k.jensen@samsung.com,
 Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH] hw/nvme: fix number of PIDs for FDP RUH update
Message-ID: <ZjiC9zVPuRJ81nBE@cormorant.local>
References: <20240503175004.1573-1-vincent.fu@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TLvKzQMBfu3xAMD3"
Content-Disposition: inline
In-Reply-To: <20240503175004.1573-1-vincent.fu@samsung.com>
Received-SPF: pass client-ip=103.168.172.151; envelope-from=its@irrelevant.dk;
 helo=fout8-smtp.messagingengine.com
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


--TLvKzQMBfu3xAMD3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May  3 13:50, Vincent Fu wrote:
> The number of PIDs is in the upper 16 bits of cdw10. So we need to
> right-shift by 16 bits instead of only a single bit.
>=20
> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
> ---
>  hw/nvme/ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..e89f9f7808 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -4352,7 +4352,7 @@ static uint16_t nvme_io_mgmt_send_ruh_update(NvmeCt=
rl *n, NvmeRequest *req)
>      NvmeNamespace *ns =3D req->ns;
>      uint32_t cdw10 =3D le32_to_cpu(cmd->cdw10);
>      uint16_t ret =3D NVME_SUCCESS;
> -    uint32_t npid =3D (cdw10 >> 1) + 1;
> +    uint32_t npid =3D (cdw10 >> 16) + 1;
>      unsigned int i =3D 0;
>      g_autofree uint16_t *pids =3D NULL;
>      uint32_t maxnpid;
> --=20
> 2.43.0
>=20

Hi Vincent,

Thanks, LGTM! Applied to nvme-next!

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

I'll also add,

Cc: qemu-stable@nongnu.org
Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")

--TLvKzQMBfu3xAMD3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmY4gvYACgkQTeGvMW1P
DemrLAf+LHMavj4uK5Mj5opww2bjXGhNKO3ujOOHZfpq031TXM+6Q/I5ik9Le0Cx
udH4VI4QLrirNHy/oASvBH+QKeVzAZsA3b2rts9535vF7AZE8MYzQoaGuRxGj40B
qQNe1LCOYGBU+fNGt6lkcUQmTmOB3LDeKPjT4SUYMJM45LjqPjuf7Ys6zviO4d7J
xcVIsyPae5gbJIoT5F7UfVNxJYBu9ZreWo1osLmy0yWo5fcmVLuUAxqmzbt89CLT
BJk9ptYYCzPa4Ub2CoTivQXYCnaGjom2KWUBTXgLSAGeJj5dqNuI2bQ+co2aUpSW
HkdKjKnC/hvhzBzeJiLcL3y4hz2ayw==
=jOPi
-----END PGP SIGNATURE-----

--TLvKzQMBfu3xAMD3--

