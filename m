Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F7AE6B240
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 11:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6pdL-0002FD-Es; Fri, 01 Nov 2024 07:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t6pdF-0002DG-P3; Fri, 01 Nov 2024 07:15:57 -0400
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t6pdD-0004rj-Fu; Fri, 01 Nov 2024 07:15:57 -0400
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 7C91E13801D9;
 Fri,  1 Nov 2024 07:15:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Fri, 01 Nov 2024 07:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1730459752; x=
 1730546152; bh=zEVjdua++dH9O+M4OCYGUnyqHMswMe8N6kj+OnKEAYg=; b=P
 UNqE7RuoljXLaPOTMFPClC4PnQ/A5W24W/2Uenq7WrBukSBX2FBoDO/WgtWMu0zX
 TUnDYqU7dXwE9wwVg6BUqmBMBykhTiomUkyk3YuUXvzIFiuFNXr3uC7JPdw+GwNe
 xPMGZdsIv79FhYgdyJw0vVOuOzKEii7xn6sfP5h9Op0P9leoWQnbZFiCCEAHSaLa
 /zQNQlRwvLfBR3+oC9lzGBhjUK8x8SZEw4612N6JHsUEQaQKKjFZyVJrQxkjiGfF
 9dZomRtoNPFs4ZsJgYGL9/yi85exZLgvAfeX+IZRt4oUAtRAE2QwxMiqW29A+8WF
 +qPGl2ugzHwoaIyUzQyRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1730459752; x=1730546152; bh=zEVjdua++dH9O+M4OCYGUnyqHMswMe8N6kj
 +OnKEAYg=; b=Y64qH84DcFwTN1NkfmHg7ehAxmQxwcsY4zEssc9qO76Q1rAaroF
 MUzmjelb6v7niYrg7Q/tIJdZpyVCou8ywz2WQOHcQqk5CucL3yjbEF3XANoWJk1c
 OuksrkLVjjq+b5TSBEO+qD3QqGPh7yC460R5kNaMOo2n04jbEXQ/eOtlVEdaO4A1
 doy6y6+AIDYBa+jiBo6Mhj6Bz5QxnZe5Dij6iXNYBgRO8aaHQ3X3eFv+GybV8VHi
 WbBoW4obkVI+Xr7tmku4ZlhhW+R0XxnpxCvjP4KZOD0EQs7sjRJBw1aUz01i8xTd
 /2V+SzcIgCcCg8DqZe3fYqDg0fo7k06bXIw==
X-ME-Sender: <xms:ZrgkZ448Gmj01-UkLkxmFRtMKa5ydZ-PYTJDNrMSY_Ba5jW5UnTqGw>
 <xme:ZrgkZ554cSSQis8f84XyyfUEd7V8-iwcCIbcQZ0bj2j1UuKWKdIjWzEKDnbxsBSH3
 dEzxTknf4SLUaaAY9A>
X-ME-Received: <xmr:ZrgkZ3entqOziCm3NX07Ap-KetXPHcavUFcrDiOhQTECwvzt-DcqBUYQkYCWqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgvdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveej
 vedtuddugeeigeetffffjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhgthhgrnhhgqhhird
 duvdefsegshihtvggurghntggvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdgslhhotghk
 sehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnh
 hurdhorhhgpdhrtghpthhtohepkhifohhlfhesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohephhhrvghithiisehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgvfhgrnhhhrg
 esrhgvughhrghtrdgtohhmpdhrtghpthhtohepfhgrmhesvghuphhhohhnrdhnvghtpdhr
 tghpthhtoheprhhonhhnihgvshgrhhhlsggvrhhgsehgmhgrihhlrdgtohhmpdhrtghpth
 htohepphgsohhniihinhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:ZrgkZ9Kj0adviKzjNqEz13nh_3WC2t6vczLx8J2y_FANNf6kCLqUsg>
 <xmx:ZrgkZ8IwTSva_8Fdl7BaUu4sLe4_KA_TmQxUbPfcXqkzwz7RpAn78g>
 <xmx:ZrgkZ-yqann8xpl2TLdn5i9wM-wlshSat1HK6qnqPqppj_-VAh-2VQ>
 <xmx:ZrgkZwJgKDSYCN8bYWPY7Bg_sy7rcdUQ_NrhTKXe1KoYYQHi8eMNcw>
 <xmx:aLgkZ97e0jVaBqUzAHqn4wWMat_pSeZM1m3qhQd4hlSBCEqbWJMIBocX>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 07:15:49 -0400 (EDT)
Date: Fri, 1 Nov 2024 12:15:48 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com
Subject: Re: [PATCH v14 09/10] hw/nvme: add reservation protocal command
Message-ID: <ZyS4ZP63MRsuK1VI@AALNPWKJENSEN.aal.scsc.local>
References: <20241011121231.18333-1-luchangqi.123@bytedance.com>
 <20241011121231.18333-10-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="annKKvWoLgjEyM/N"
Content-Disposition: inline
In-Reply-To: <20241011121231.18333-10-luchangqi.123@bytedance.com>
Received-SPF: pass client-ip=103.168.172.148; envelope-from=its@irrelevant.dk;
 helo=fout-a5-smtp.messagingengine.com
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


--annKKvWoLgjEyM/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 11 20:12, Changqi Lu wrote:
> Add reservation acquire, reservation register,
> reservation release and reservation report commands
> in the nvme device layer.
>=20
> By introducing these commands, this enables the nvme
> device to perform reservation-related tasks, including
> querying keys, querying reservation status, registering
> reservation keys, initiating and releasing reservations,
> as well as clearing and preempting reservations held by
> other keys.
>=20
> These commands are crucial for management and control of
> shared storage resources in a persistent manner.
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> Acked-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c       | 347 +++++++++++++++++++++++++++++++++++++++++++
>  hw/nvme/ns.c         |   6 +
>  hw/nvme/nvme.h       |   9 ++
>  include/block/nvme.h |  58 ++++++++
>  4 files changed, 420 insertions(+)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index ad212de723..4821a7ff3b 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> +static uint16_t nvme_resv_report(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    int num_keys;
> +    uint32_t cdw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    uint32_t cdw11 =3D le32_to_cpu(req->cmd.cdw11);
> +    size_t buflen =3D (cdw10 + 1) * sizeof(uint32_t);
> +    bool eds =3D cdw11 & 0x1;
> +    NvmeNamespace *ns =3D req->ns;
> +    NvmeResvKeys *keys_info;
> +
> +    if (!nvme_support_pr(ns)) {
> +        return NVME_INVALID_OPCODE;
> +    }
> +
> +    if (eds) {
> +        if (buflen < sizeof(NvmeReservationStatusExt)) {
> +            return NVME_INVALID_FIELD;
> +        }
> +
> +        num_keys =3D (buflen - sizeof(NvmeReservationStatusExt)) /
> +                   sizeof(struct NvmeRegisteredCtrlExt);
> +    } else {
> +        if (buflen < sizeof(NvmeReservationStatusHeader)) {
> +            return NVME_INVALID_FIELD;
> +        }
> +
> +        num_keys =3D (buflen - sizeof(NvmeReservationStatusHeader)) /
> +                   sizeof(struct NvmeRegisteredCtrl);
> +    }
> +
> +    keys_info =3D g_new0(NvmeResvKeys, 1);
> +    /* num_keys is the maximum number of keys that can be transmitted */
> +    keys_info->num_keys =3D MAX(num_keys, 0);
> +    keys_info->keys =3D g_malloc(sizeof(uint64_t) * num_keys);
> +    keys_info->req =3D req;
> +
> +    req->aiocb =3D blk_aio_pr_read_keys(ns->blkconf.blk, &keys_info->gen=
eration,
> +                                      keys_info->num_keys, keys_info->ke=
ys,
> +                                      nvme_resv_read_keys_cb, keys_info);
> +
> +    return NVME_NO_COMPLETE;
> +}

This wasn't exactly what I meant when I mentioned that we could get rid
of the MAX_KEYS. I was thinking you would do the transfer in chunks.
With the above, I think there is a risk of DoS (we can end up allocating
A LOT of memory here).

I kinda want this to get into 9.2, so I suggest that you revert this
change to the MAX_KEYS approach you had in v13.

With that sorted out, consider this R-b'ed.

Stefan, I think it makes most sense this is PR'ed by block layer
maintainers. Or, it can be split so you can take the reviewed block
layer parts and I can PR the nvme one. What do you think?

--annKKvWoLgjEyM/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmckuGEACgkQTeGvMW1P
DemgTwf/ceE48EId8nFMCyll8nNWGzkDpt7aKRrly6ipMg/hwB2IRysZkCx5NjXW
aN+sUceb70xWK2TOyx780tOWAA4j98b5V5dwRjbxeRdv9USR7dEsJjQTUrgfhoSq
YQEZd7xbKQ4/JopZlhYtJH5RWCh+WorLQC1Wehpi/ayYYVu9o3j4wRG1D1r/aNxM
Tm0/UqFUidXeVkZpfJWCvEImnGHNrVPW5VGpU4hx85OAJ9aYIVpq1o/+d+4Zr8Oy
P5YwdlwFskS2mhspxCBW4ckKbk7BxHunqetWFnaILKNvfiEv+/txXHyreaODYb+V
h31m1mLO7tiiX6g0uyY20YcRQGUR1w==
=y/UR
-----END PGP SIGNATURE-----

--annKKvWoLgjEyM/N--

