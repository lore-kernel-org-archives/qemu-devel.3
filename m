Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094A0CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 13:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsMgl-0003QB-0T; Thu, 04 Apr 2024 08:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rsMgU-0003KV-40; Thu, 04 Apr 2024 08:59:14 -0400
Received: from wfout7-smtp.messagingengine.com ([64.147.123.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rsMgS-00072S-5M; Thu, 04 Apr 2024 08:59:13 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id A03971C000A8;
 Thu,  4 Apr 2024 08:59:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Thu, 04 Apr 2024 08:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1712235547; x=
 1712321947; bh=guoisUAPuCy5hMqnhsJmvLqBquBENjAxj/rNNCRRwco=; b=u
 r9As0bQaf7k6GDtTlylbWTN8PDp/U/HbdQLQR+9S9wUxaPwI3pV/3aSPTY9otWp4
 6h06gy8O6BcRGi4xYNYSTTrT0nf1kpTK1RpSVRXrChHh44emdD1v8fpsO/pZamaf
 uynrlFDBXsmrCcELCXDJ8qEJbnLppgDsyevxVTjhzSN28PUBw/yX593M/uOxzCPb
 cOlotmoaBOqlEgvWNnNc0yY4EPSF+eyGmz3f2beXUlAGSjx0qufF+EiBFNMXfngC
 BVATPwym9CPqqiaHWb2W5Cm24beqA1JnhZrSFrKtjoFj0fAfuyyrNYiF9toEh+y0
 IA1z28LWFpti4rLKIKXCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1712235547; x=1712321947; bh=guoisUAPuCy5hMqnhsJmvLqBquBE
 NjAxj/rNNCRRwco=; b=P31z9SDNvB1FLem+cA3/vdFZ6HRo+Ug0ZiNJmx0QE/7E
 xbuugRnGGDMHcvVtbOKqk4sE40QSYMOHx/2vP+4bE8cLil5UDZpYXRSaSRFUveWw
 jlO8CTqlz/Bo3eYXfpzAp4RYjDDDk4zrmGU9DU8lLyrbz4dK9l3AU2sz9D3yHcDu
 cxrQJigCUxt3YPT2PPxeOJEkIJCq/4xdw3iiIPZc4uMpITp72pe3P4XYoXCsfcau
 ngYGpUnC97VK4ur5+6FTCV1bGpb75hBWf8VjI6OAlaBhbahz7Dgtuy5+Cxx8rlnA
 229GdV+Hd1fSFhVM95i2/NUqNrFx1Xl5r6YlkjU+KA==
X-ME-Sender: <xms:GqQOZhRbTRR0dniHue7afsAE_qjmDEWwn4jZ3XAWksSTV3ntSoOM3w>
 <xme:GqQOZqzbKbuKCgcAbM-cJT0wDk7jd5Bx2fUDDRAO4hncuru4ogUr6PSCJ-cLL5p3m
 BdoXt3YqJrHKYQ_UwE>
X-ME-Received: <xmr:GqQOZm1oH-6-4RrwxnTJp377FzycTYDv94eoBdkHyVpwOijPeFntvuK2iQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:GqQOZpDQkKpRvVTxWTdsaD4z5cDXY3yAKpqzFVfd2u7AOkKuvhOmWg>
 <xmx:GqQOZqjxDRyBp92vTKLpKfPksqnfH6_xgDS8yb7yFRbuAiLwQIJuww>
 <xmx:GqQOZtpw03BGC5ghfIM9fPCga2c2q11XpoMw7JGMcDHTLZ0dcU2oJQ>
 <xmx:GqQOZlh6AImhE8DdSnnes-dnyBTuevFm5zOpUibKl9bCAIeiuFMhFQ>
 <xmx:G6QOZjVG3R3-jUo2f0D6BZzuJ6XJpuHkeRIiNHj90ndhvSIScrS-F36t>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 08:59:05 -0400 (EDT)
Date: Thu, 4 Apr 2024 14:58:59 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: John Berg <jhnberg@amazon.co.uk>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, foss@defmacro.it,
 qemu-block@nongnu.org, John Berg <jhnberg@amazon.com>
Subject: Re: [PATCH] hw/nvme: Add support for setting the MQES for the NVMe
 emulation
Message-ID: <Zg6kE0Hvt7KK99wc@cormorant.local>
References: <20240404120418.1611513-1-jhnberg@amazon.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ps1feoi6pJQAgncx"
Content-Disposition: inline
In-Reply-To: <20240404120418.1611513-1-jhnberg@amazon.co.uk>
Received-SPF: pass client-ip=64.147.123.150; envelope-from=its@irrelevant.dk;
 helo=wfout7-smtp.messagingengine.com
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


--Ps1feoi6pJQAgncx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr  4 13:04, John Berg wrote:
> From: John Berg <jhnberg@amazon.com>
>=20
> The MQES field in the CAP register describes the Maximum Queue Entries
> Supported for the IO queues of an NVMe controller. Adding a +1 to the
> value in this field results in the total queue size. A full queue is
> when a queue of size N contains N - 1 entries, and the minimum queue
> size is 2. Thus the lowest MQES value is 1.
>=20
> This patch adds the new mqes property to the NVMe emulation which allows
> a user to specify the maximum queue size by setting this property. This
> is useful as it enables testing of NVMe controller where the MQES is
> relatively small. The smallest NVMe queue size supported in NVMe is 2
> submission and completion entries, which means that the smallest legal
> mqes value is 1.
>=20
> The following example shows how the mqes can be set for a the NVMe
> emulation:
>=20
> -drive id=3Dnvme0,if=3Dnone,file=3Dnvme.img,format=3Draw
> -device nvme,drive=3Dnvme0,serial=3Dfoo,mqes=3D1
>=20
> If the mqes property is not provided then the default mqes will still be
> 0x7ff (the queue size is 2048 entries).
>=20
> Signed-off-by: John Berg <jhnberg@amazon.co.uk>

LGTM,

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--Ps1feoi6pJQAgncx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmYOpBIACgkQTeGvMW1P
DemZ3wgAofo5f9sBczlchnUb+g9Z1f/fh1umLgP8XQO6dI6n/M4GxTgdwaByqMwK
vfMvFDecdI9vEWztBvNW5ZwfrMcNHYYleCQa3ZLjroCbMnDdqbbQBqDF4u/jgakf
eVp7oENp6LzTztMwO2S5YgjwNZdUoFQ5FAts0LcAmuqF56S1m063ZBJchDcFbxvY
dff1iDoi6F4SMj+QRno2Gbk7hY3+wxGCtYoOTqLppbGhC8Tq9cBusXrd7HXbZei2
yJ31wBpqI6X3sqVSihbplNgBMYwCDmhlzFSXH29FW6ugxO+WtP4WKamqkkW7x5rP
1K/GyjnwhEh5Lb88KbIDLbS7r8Ow6g==
=0/tb
-----END PGP SIGNATURE-----

--Ps1feoi6pJQAgncx--

