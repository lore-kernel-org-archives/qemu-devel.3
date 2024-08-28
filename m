Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24C2C5474A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 06:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjBtR-00018D-2Q; Wed, 28 Aug 2024 02:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sjBtP-00015E-91; Wed, 28 Aug 2024 02:10:55 -0400
Received: from fout7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sjBtN-0003qL-Kp; Wed, 28 Aug 2024 02:10:55 -0400
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal
 [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id C3A7A13900BA;
 Wed, 28 Aug 2024 02:10:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 28 Aug 2024 02:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1724825446; x=
 1724911846; bh=SieulTo1vDCd6Vq9LZYjU9WMFCrKH6BFKClrAfsmHHI=; b=g
 z2ZDRvUJt8UdDc8PHejU2dtmwGtXG8Qj9nriSqQq5WjH0guWfFGinPYlNMAU+9/4
 ED1R0ALg5ai6nqI/QRMGxVDWU3Y1W63ET2NXKPTlOD7vH76AX2eIoTwaP/8eVY0s
 ucugGtdRrnyUF98h8DGNLQVYaVgBs0tPAEmSs37ksYwIq5Hw3DQCdwg1Shzp9XuB
 Y6+xAgrrKYIXgH0ExvObdV/y5yuKwJHhTrlR0UozDnvF3sxKi4Kr6NCzYbkz1Eyc
 cq8+IzXImORe1cma329ZuVX9Y7+evT7u9JPDgSltL4lgBqiOsujZph7gpJMUivQX
 S30njB/sZVZqqypXQO2iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1724825446; x=1724911846; bh=SieulTo1vDCd6Vq9LZYjU9WMFCrK
 H6BFKClrAfsmHHI=; b=pbZGyGUJ19liV7vVoAlsrc88Mrq9mg/q8GVOebqbcGq7
 jyK/7dcV7W3mOjpD8GEgrGK3m5R5kXqqxZzPTZA6ar65Byv5FOofQsWE2HCdGfO7
 2vj/kASmFGkq09+zLTgTFCYzQNJkkyxxH8/mpH/7H174h6JOC2pewLraQCyLA+Mt
 nXX6znrhcf9JTF5QlLNqJf3cGbnrmuHp8ogKXiNPg2MEXYJYsfEzMSfGeVYrMG0C
 UkGF8/vvTMQN1DtA2IgmH6i8XckAqOQR9uw7BaCkml8HCqcOOax4YYiXLILhoftM
 hf9JAhXbwDPakFE2/xyjoaVju8BSqIsEb3+YfAGFMA==
X-ME-Sender: <xms:Zr_OZusU66kju7V3hZXbkYbiIcJgvGav1UI2lM0wA2B7HCes1GfByQ>
 <xme:Zr_OZjcmfeidbO_noG9tYvu0w9pYNsUnEM9g2rySq0eEOIEOmGY_YWLLmUPldk8gO
 NOCZ71aMqxdLuI-xx0>
X-ME-Received: <xmr:Zr_OZpwHs1E1JFVe8126VHmTzMh9-CjHVcXJf_PVw3nTfhsk4bO9BcezbEKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefuddguddtjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Zr_OZpPRwzIMJZ1-aTDAXrASzYuomgAhA1d2iMlflL4E2MZd1ymnDw>
 <xmx:Zr_OZu8RcnWyl-Axan0_gSjce-3u9-veXpxj-WIa5IVZRKAExsEFOQ>
 <xmx:Zr_OZhX56Mgum28kBeZeqmHnHBBLQ2A7YrPUpvG1c-N4tXjsmxRang>
 <xmx:Zr_OZnd99CKBTzZuICiP0RUND5ZkBbqXQrhIhgX87cS0LYflmA2ZPw>
 <xmx:Zr_OZuO5hh-g9h9-NpM7_x46AVEPKsz8eEBMfTth67z8fehJdb6sUpB0>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Aug 2024 02:10:45 -0400 (EDT)
Date: Wed, 28 Aug 2024 08:10:40 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v9 09/10] hw/nvme: add reservation protocal command
Message-ID: <Zs6_YDFJOmEvPTAT@cormorant.local>
References: <20240712023650.45626-1-luchangqi.123@bytedance.com>
 <20240712023650.45626-10-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Hy24UAIhgH01a9XR"
Content-Disposition: inline
In-Reply-To: <20240712023650.45626-10-luchangqi.123@bytedance.com>
Received-SPF: pass client-ip=103.168.172.150; envelope-from=its@irrelevant.dk;
 helo=fout7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


--Hy24UAIhgH01a9XR
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

> +static int nvme_read_reservation_cb(NvmeReadReservation *reservation)
> +{
> +    int rc;
> +    NvmeReservationStatus *nvme_status;
> +    NvmeRequest *req =3D reservation->req;
> +    NvmeCtrl *n =3D req->sq->ctrl;
> +    NvmeResvKeys *keys_info =3D reservation->keys_info;
> +    int len =3D sizeof(NvmeReservationStatusHeader) +
> +              sizeof(NvmeRegisteredCtrl) * keys_info->num_keys;
> +
> +    nvme_status =3D g_malloc(len);
> +    nvme_status->header.gen =3D reservation->generation;
> +    nvme_status->header.rtype =3D block_pr_type_to_nvme(reservation->typ=
e);
> +    nvme_status->header.regctl =3D keys_info->num_keys;
> +    for (int i =3D 0; i < keys_info->num_keys; i++) {
> +        nvme_status->regctl_ds[i].cntlid =3D nvme_ctrl(req)->cntlid;
> +        nvme_status->regctl_ds[i].rkey =3D keys_info->keys[i];
> +        nvme_status->regctl_ds[i].rcsts =3D keys_info->keys[i] =3D=3D
> +                                          reservation->key ? 1 : 0;
> +        /* hostid is not supported currently */
> +        memset(&nvme_status->regctl_ds[i].hostid, 0, 8);
> +    }
> +
> +    rc =3D nvme_c2h(n, (uint8_t *)nvme_status, len, req);
> +    g_free(nvme_status);
> +    return rc;
> +}
> +
> +static int nvme_read_reservation_ext_cb(NvmeReadReservation *reservation)
> +{
> +    int rc;
> +    NvmeReservationStatusExt *nvme_status_ext;
> +    NvmeRequest *req =3D reservation->req;
> +    NvmeCtrl *n =3D req->sq->ctrl;
> +    NvmeResvKeys *keys_info =3D reservation->keys_info;
> +    int len =3D sizeof(NvmeReservationStatusHeader) +
> +              sizeof(uint8_t) * 40 +
> +              sizeof(NvmeRegisteredCtrlExt) * keys_info->num_keys;
> +
> +    nvme_status_ext =3D g_malloc(len);

This leaks heap memory due to uninitialized reserved fields in
NvmeReservationStatusExt. Prefer g_malloc0.

The one above in nvme_read_reservation_cb looks safe, but prefer
g_malloc0 there anyway.

> +    nvme_status_ext->header.gen =3D cpu_to_be32(reservation->generation);
> +    nvme_status_ext->header.rtype =3D block_pr_type_to_nvme(reservation-=
>type);
> +    nvme_status_ext->header.regctl =3D cpu_to_be16(keys_info->num_keys);
> +
> +    for (int i =3D 0; i < keys_info->num_keys; i++) {
> +        uint16_t ctnlid =3D nvme_ctrl(req)->cntlid;
> +        nvme_status_ext->regctl_eds[i].cntlid =3D cpu_to_be16(ctnlid);
> +        nvme_status_ext->regctl_eds[i].rkey =3D cpu_to_be64(keys_info->k=
eys[i]);
> +        nvme_status_ext->regctl_eds[i].rcsts =3D keys_info->keys[i] =3D=
=3D
> +                                               reservation->key ? 1 : 0;
> +        /* hostid is not supported currently */
> +        memset(&nvme_status_ext->regctl_eds[i].hostid, 0, 16);
> +    }
> +
> +    rc =3D nvme_c2h(n, (uint8_t *)nvme_status_ext, len, req);
> +    g_free(nvme_status_ext);
> +    return rc;
> +}

--Hy24UAIhgH01a9XR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmbOv2AACgkQTeGvMW1P
DelX5Af+L+g4M4Qzhe3ZiOXhLnzsAxKSbvt1s5fNX3WvW0sCKD+Mj+iBCEQh/IEC
SJCkBF1t4pdtC7rxLvaDPfs4ZTy6k1JcPdKiU0BkUG9vI8J2Fl6PcHsDJVFw+Q2b
I8aCZWCmWkTgftxUGWSJFY8jkU0aRnrpjUsbscoqd6B9QmN3xGMc+WXmzt9hz6AR
J2TJXt0KKkrRuOTAYTNkt+AxFdOcSPhNukHqgMqE4UMDqpyv6RPDS+igV04+rfuW
ZGpZxH7bxdTNccUIa8/kuD5JBCnl4eRkv0o+KiUr+hgiR2OXFkhS0bKqx/WkYaEW
jlPOLKLGIhqO6EgGa/VabBtZMqchAQ==
=4yeo
-----END PGP SIGNATURE-----

--Hy24UAIhgH01a9XR--

