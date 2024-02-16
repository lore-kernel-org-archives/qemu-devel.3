Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A220C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 08:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ratxB-0007tz-N9; Fri, 16 Feb 2024 03:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1ratx8-0007t6-M9; Fri, 16 Feb 2024 03:52:14 -0500
Received: from fout5-smtp.messagingengine.com ([103.168.172.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1ratx6-00014m-AV; Fri, 16 Feb 2024 03:52:14 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id 8F8621380090;
 Fri, 16 Feb 2024 03:52:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Fri, 16 Feb 2024 03:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1708073529; x=
 1708159929; bh=qtbGpNOmQBeh0EWgVDEzkwtA7IM+WUWndprA6WEiqDs=; b=O
 XORN7RvEfrZzvI5OWzMi9iqtmkJ+PuJ/qmDX79yicquicqM2q+zGAsj0i0KfYSQQ
 sRBFKzJM7/WxuCwGHurY/omHqULUbvWJp5jyHy7Rkdnt6Iqo3CDBxaZZG9YiltKd
 n74inNkA2Lc4w9JskmutTJ0pec1ktH5ZxAsNnen2TxaKRqqSWpLZuU6D+A9poUZe
 1WMRR3JJaPHPWRtaNm7lR1TUIZG9kAP11knqz/DF7nepLaiajiQpEUB0mpMV3XSx
 7TgKyJlwc3u/Q0D/d+WBYl01T7EDN8yDoPJzQ3rfEYez5KnnINvCWNc4NGa4NamX
 BKfvN2KY1mkbZ78kkzCOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1708073529; x=1708159929; bh=qtbGpNOmQBeh0EWgVDEzkwtA7IM+
 WUWndprA6WEiqDs=; b=FHYj+K9T72BZer6tBoftSOiymrtRAiHKuigS2f36AmP3
 GHMIXMnEakw1kD3JqWHMz1jcKh/XvviI3dofUfkwVGPAhJSLM4XD736m+UH3kqEu
 SIH5VmYn3vFBstyzmcdw0BFOEwgKyqLweumXf2zIYKVeKJJRBBVHUqYRbyFGgxT+
 bbYhQcWFlwaydmkaFyITVl54OY536f5zCosY+3FcrOn9r7rr6i0aPhqfPHZaiumY
 KsmlNd9UTNbihcaw31pLdyDJgD5JuP4XYj18J5YPU5j+hL0NG2KI+MqsjBK1nOcn
 dQqgj7qo5pHC5sy7wJ2UsA2jN6DM+vFqa/XLldA1TQ==
X-ME-Sender: <xms:OCLPZf_NEvh_kTO51iaQEwts9ef-iN_hDSD9Fl6-ieFj4Iw5UTrTvA>
 <xme:OCLPZbvrHtblIOQIiEn39P63ojuc26_gBIBU0_nT6gINonje1XBfzM3ECgMEvVNAd
 3JHx_T_PKy9nf4ExU0>
X-ME-Received: <xmr:OCLPZdC4uGTEIUGpBv-0nW2R6b1_sgGsqr6j-m51hCgPXX8TT9Igbr7nPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddugdduvdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:OCLPZbf8VN1b8t1FAbcgrgL42WJJdOKhdklVCetoxE4xT89qaIeAdQ>
 <xmx:OCLPZUPIM38ocLsabZ6NnMjgTc8wRN92Oof3HzolJCw76Npw26flNQ>
 <xmx:OCLPZdkSo-extKU0ltlCeMVvJjjh0VDO6BZGoMktxb-C6pqXkgbb6w>
 <xmx:OSLPZZvm2hgLE5KIX9zw3Ti0I53gQjFQd4hZ8J4FgQtUd6FW5yNkzg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 03:52:07 -0500 (EST)
Date: Fri, 16 Feb 2024 09:51:57 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alistair Francis <alistair23@gmail.com>, marcel.apfelbaum@gmail.com,
 mst@redhat.com, hchkuo@avery-design.com.tw, kbusch@kernel.org,
 lukas@wunner.de, wilfred.mallawa@wdc.com, cbrowy@avery-design.com,
 qemu-devel@nongnu.org, jiewen.yao@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 0/3] Initial support for SPDM Responders
Message-ID: <Zc8iLc3KWhcjChQo@cormorant.local>
References: <20240213024403.1060188-1-alistair.francis@wdc.com>
 <20240215144434.00005bf9@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xuBUPKsCBwrC9ezf"
Content-Disposition: inline
In-Reply-To: <20240215144434.00005bf9@Huawei.com>
Received-SPF: pass client-ip=103.168.172.148; envelope-from=its@irrelevant.dk;
 helo=fout5-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--xuBUPKsCBwrC9ezf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 15 14:44, Jonathan Cameron wrote:
> On Tue, 13 Feb 2024 12:44:00 +1000
> Alistair Francis <alistair23@gmail.com> wrote:
>=20
> Hi All,
>=20
> Just wanted to add that back in v2 Klaus Jensen stated:
>=20
> "I have no problem with picking this up for nvme, but I'd rather not take
>  the full series through my tree without reviews/acks from the pci
>  maintainers."
>=20
> So I'd like to add my request that Michael and/or Marcell takes a look
> when they have time.
>=20
> I've been carrying more or less the first 2 patches in my CXL staging
> tree for a couple of years (the initial Linux Kernel support that Lukas
> Wunner is now handling was developed against this) and I would love
> to see this upstream. Along with PCI and CXL and NVME usecases this
> is a major part of the Confidential Compute device assignment story
> via PCI/TDISP and CXL equivalent.
>=20
> It's not changed in significant ways since v2 back in October last year.
>=20

Would someone be willing to sign up to maintain the spdm_socket backend?

--xuBUPKsCBwrC9ezf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmXPIi0ACgkQTeGvMW1P
Dekz2wf9Gt9o1HSUmH7+wcHggFMBCQ7+tIXQU+ga+AX5C+U+Th+GjAXDbMoxS6nb
JHEg2Z7oh+m0J5pd2E8BL2J0UONmd5LFwQBjcuAYoda1C9NJe+JhctSnUSqjNMuC
kV8rsmsOt+KL0c0VXqkd0aXTULydMAa5Q+0QI+2db9PVcZbtRqS9NEZNe/4VIPNl
0a7HzXKiIGX3mS9oxcJkOT5dmaGD/Qx2qwXPSnw4eNzRVVg/rqDtkxpqj1B8uGYu
f+qJRiSWVWdBTLZmILuHasQO9XSnYxDIA4OVr56kuY4xjqTR+IC/L+RLFlE/x8a+
NS5riuvnzQCZGlN6pGmt3rUeKtw7Ow==
=iTVA
-----END PGP SIGNATURE-----

--xuBUPKsCBwrC9ezf--

