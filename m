Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EA2C5474A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 06:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjCWc-0001m8-5f; Wed, 28 Aug 2024 02:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sjCWV-0001bk-IS; Wed, 28 Aug 2024 02:51:20 -0400
Received: from fhigh3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sjCWS-0007bi-Ad; Wed, 28 Aug 2024 02:51:19 -0400
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal
 [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id B19721151CDB;
 Wed, 28 Aug 2024 02:51:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Wed, 28 Aug 2024 02:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1724827874; x=
 1724914274; bh=uv/ZGDaOiF3z8n0k3m+c6M8nD8GB5EXQovB8/GJhA1o=; b=f
 YXhx+J5naKvJ3LnkwtR7opynAFtqiO+C4jblu6rbTpOhnkl/31GOSwfubyaT8v1q
 clY9dslJiejJLd8bjXo1UMWg3lIAG5Podpd/Cr2Th29shDSKBR75hKokd2L98DfC
 /xFeaF5/RkW7ePdI2wW4u6ycraNVXX5MGe9IVGW3oSRMmAR6RTASbb+wmVqEhH/C
 gtTfksxTCfRO0TNhV9RCEzCffOuFDekdVk1K1smWQ1AFFnY5gCXoIgwCvQDkARbo
 GIg8DL2G5gzeARbPzmym50n9Qr+JNJ2HVeDsZP68/jSgsNTqDD2Ixa6GXy8QcC2I
 J4YiI12LDlu3TnE22aS/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1724827874; x=1724914274; bh=uv/ZGDaOiF3z8n0k3m+c6M8nD8GB
 5EXQovB8/GJhA1o=; b=QmS1r5rzyZ2GipPN8OYtKzdtHfLDQIg1p1iBAad9aoDB
 0561t9p/4axmZYuYpW74LFeMSssYs6utMTQvT1fnkx09rmYZlNtANXxS57Hg2eoh
 J8aCbCR/kyAHJ0cVCTfv9wxZlutsA7v9yp09CL48PXR216JN6GjbZhzyU5W2I/8U
 7uqAeYPsQ7RaYLUTrSqcvZRjDrH6TB6XDzisyjvWiiw5fCaZhtTslr9dZ8toVqbv
 g4eskKSlRCX6ZATos/2LK/IMIXPXpITkNxEikulQI24tvW2GKrbxgxCLR2CcYmHR
 Du6cNsNQkbZT8AmQq7QSJkQdBWmvMye+ZeyYhhHhpg==
X-ME-Sender: <xms:4cjOZjpSomb6NDOa2NBoBl-xhExLIN4vzHQcdZ6y8tE9KHU4FZYe6Q>
 <xme:4cjOZto6a-pJXBX48m7bh1LnM5lX65df_XXy-b3X0OIMAtqCq0wa1SuEZVl2bgcgR
 xKV6FbtJnsKQguOou8>
X-ME-Received: <xmr:4cjOZgND4GobwRz9ZknZ2XM8trl82YrXNgZfrey6Q8wKUHyIXm3twBNlf4zs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefuddguddugecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdej
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeev
 jeevtdduudegieegteffffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhutghhrghnghhqih
 druddvfeessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehqvghmuhdqsghlohgt
 khesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhngh
 hnuhdrohhrghdprhgtphhtthhopehkfiholhhfsehrvgguhhgrthdrtghomhdprhgtphht
 thhopehhrhgvihhtiiesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshhtvghfrghnhh
 grsehrvgguhhgrthdrtghomhdprhgtphhtthhopehfrghmsegvuhhphhhonhdrnhgvthdp
 rhgtphhtthhopehrohhnnhhivghsrghhlhgsvghrghesghhmrghilhdrtghomhdprhgtph
 htthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:4cjOZm6mWKPVg7ztWFq1M3T_F2wjvUjZs4lMZ_Zu_D2EVvXUFN7mPg>
 <xmx:4cjOZi518T9oJyu0uapfk2WajchoNVtT8j2mj980lMkAKfzn08ZQCQ>
 <xmx:4cjOZujUZJSYUcLlUYXNRfZbUy5IcT3brRWLB5JKzRmR_H533SVyOg>
 <xmx:4cjOZk6otK7fmA5KZn6hZECo-unR3CIVHopqYIkuFyenirfk6TmgJw>
 <xmx:4sjOZuo6ulkxj8dHhsdNitLX1SyGVH4HpfzD1Wn5R3DEkQmtUv6nelII>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Aug 2024 02:51:13 -0400 (EDT)
Date: Wed, 28 Aug 2024 08:51:08 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v9 09/10] hw/nvme: add reservation protocal command
Message-ID: <Zs7I3AAzsO2Xe5iG@cormorant.local>
References: <20240712023650.45626-1-luchangqi.123@bytedance.com>
 <20240712023650.45626-10-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tRwxhxil8cQ/AHCd"
Content-Disposition: inline
In-Reply-To: <20240712023650.45626-10-luchangqi.123@bytedance.com>
Received-SPF: pass client-ip=103.168.172.154; envelope-from=its@irrelevant.dk;
 helo=fhigh3-smtp.messagingengine.com
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


--tRwxhxil8cQ/AHCd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 12 10:36, Changqi Lu wrote:
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
>  hw/nvme/ctrl.c       | 318 +++++++++++++++++++++++++++++++++++++++++++
>  hw/nvme/nvme.h       |   4 +
>  include/block/nvme.h |  37 +++++
>  3 files changed, 359 insertions(+)
>=20

> +static uint16_t nvme_resv_register(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    int ret;
> +    NvmeKeyInfo key_info;
> +    NvmeNamespace *ns =3D req->ns;
> +    uint32_t cdw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    bool ignore_key =3D cdw10 >> 3 & 0x1;
> +    uint8_t action =3D cdw10 & 0x7;
> +    uint8_t ptpl =3D cdw10 >> 30 & 0x3;
> +    bool aptpl;
> +
> +    switch (ptpl) {
> +    case NVME_RESV_PTPL_NO_CHANGE:
> +        aptpl =3D (ns->id_ns.rescap & NVME_PR_CAP_PTPL) ? true : false;
> +        break;
> +    case NVME_RESV_PTPL_DISABLE:
> +        aptpl =3D false;
> +        break;
> +    case NVME_RESV_PTPL_ENABLE:
> +        aptpl =3D true;
> +        break;
> +    default:
> +        return NVME_INVALID_FIELD;
> +    }
> +
> +    ret =3D nvme_h2c(n, (uint8_t *)&key_info, sizeof(NvmeKeyInfo), req);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    switch (action) {
> +    case NVME_RESV_REGISTER_ACTION_REGISTER:
> +        req->aiocb =3D blk_aio_pr_register(ns->blkconf.blk, 0,
> +                                         key_info.nr_key, 0, aptpl,
> +                                         ignore_key, nvme_misc_cb,
> +                                         req);
> +        break;
> +    case NVME_RESV_REGISTER_ACTION_UNREGISTER:
> +        req->aiocb =3D blk_aio_pr_register(ns->blkconf.blk, key_info.cr_=
key, 0,
> +                                         0, aptpl, ignore_key,
> +                                         nvme_misc_cb, req);
> +        break;
> +    case NVME_RESV_REGISTER_ACTION_REPLACE:
> +        req->aiocb =3D blk_aio_pr_register(ns->blkconf.blk, key_info.cr_=
key,
> +                                         key_info.nr_key, 0, aptpl, igno=
re_key,
> +                                         nvme_misc_cb, req);
> +        break;

There should be some check on rescap I think. On a setup without
reservation support from the block layer, these functions ends up
returning ENOTSUP which causes hw/nvme to end up returning a Write Fault
(which is a little wonky).

Should they return invalid field, invalid opcode?

--tRwxhxil8cQ/AHCd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmbOyNsACgkQTeGvMW1P
Dekk0Af+LMK7+YNLMqrQjVO9vodA++9IBaGMtEeLlP1JG2V8ZWvAfvIxHl47556o
ucw6b1OGgz1xL7B7dtydVUYmWS+WtOdmHwRpds+vUV8/AIDc5FVSR3GrvwhBEsLI
lLxqdJxBnoz29p0Hu0j5WYu4ZcXM92w+aukCNnKinBntm6/kp+KYPFHD3dIE/Bii
r5i0txqJIZBaYLRyla2Q6ki3gyMBFNNNczU7znYrvNwaFuhgRzN3AsbPWTVPX/ng
99dvz7xvzugDR93IjQ1BPTJnMgy3WX2+rAcPlfmv1Tgv3iDHsVtzqJZFzv2duhhT
O2c/GdAKDUSSc7x61e5Z610qApHfiA==
=Ln5+
-----END PGP SIGNATURE-----

--tRwxhxil8cQ/AHCd--

