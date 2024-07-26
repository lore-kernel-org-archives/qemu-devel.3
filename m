Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35C7C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 06:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXEOX-00063n-Eb; Fri, 26 Jul 2024 02:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sXEON-00060o-HV; Fri, 26 Jul 2024 02:25:27 -0400
Received: from fhigh5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sXEOJ-0002oV-VO; Fri, 26 Jul 2024 02:25:27 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id EB3581140228;
 Fri, 26 Jul 2024 02:25:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Fri, 26 Jul 2024 02:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1721975120; x=
 1722061520; bh=nO5MIPvLM3O6G5pAt5pxZItN7yXl78ep+7TDHfOMBgY=; b=e
 G2F7tmbIEUTKHuOC4RbW+mFtWC1sVlESwCu3Yw+M5PhTtssn2erNcTITjetz9wVz
 /1/3DeL9BGuO5IMomtu6zxY0BxQ3MmzMyQa4YX8PFYi0tRm+ctNqO3zgG1yX5yC+
 NoEx+Y2iFRb7y4jO9MzVZC/ElbcmvjXrOcGXcwFojox42VyMLr1ue4GT3bZeaw75
 Fc/ykJnZL5nJWRWK9eEWmfadcm027bGoC5VhYLPNgaxgB4hydQe1URDB1e0fxAIm
 A5ck23NvUOOZ4qJWbwyjnDYJrKOUhrm7H6J1z4pxy347rBM1iIbcERKuagHR+xZC
 IXe3P0eXDqzfkXezqsvRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1721975120; x=1722061520; bh=nO5MIPvLM3O6G5pAt5pxZItN7yXl
 78ep+7TDHfOMBgY=; b=arQD4G33a7ujlUxjYlOFqgfqcfOq/ohlTCtvwS5Vk8P5
 OVVmwqrmd/vf3MnBRgc6jC7mK8dt2BgAotbz4F7HbL0Ci919S+oqHjlN0kd7Aemn
 /jlZShj/KW35rPv8utyT27DJ131mSG2tWM1QI42/ANvIU+L/jfhopS1JD7KJ+T+K
 WM7wusMH7gr3hYq603O7iYTV5qcWquOqprfztSbqmPqlFSt2aUDuXGqgBPS9C8Qp
 8vkyxTCx6G7cVBpXpxynNdZBT2hpjjfhrPsvgEdvS6ipsz1BA+eu32J1sF1I0tIC
 0zH+5Kw0PIBPF1qHAOaOtpzc/Vi3n5SX/JxZbCRQsQ==
X-ME-Sender: <xms:T0GjZkK2RKs0CwYaAC4zoJLhmBvZrQ3XdWUeKxL9o8lnbUZc-byGhg>
 <xme:T0GjZkICzzAtdTv7Q4GI9duoklZ7XwUmMQJZ5hUUq4Y4118YIAkfQUUHQI-rkod_z
 aOSPbpChbXG6hd3dTw>
X-ME-Received: <xmr:T0GjZkuaYwyM8Xuwwx1-RD8k22r7OUZuWs8rASG_Il4AUQVD769dV0gBpxUJ9gJbzkhW6o9JZsTrpq4X3KqY6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieeggddutdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
 erredttdejnecuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghl
 vghvrghnthdrughkqeenucggtffrrghtthgvrhhnpeejgfejfeffvdeuhfeifefhgffgue
 elhedukeevjeevtdduudegieegteffffejveenucevlhhushhtvghrufhiiigvpedtnecu
 rfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsg
 gprhgtphhtthhopedt
X-ME-Proxy: <xmx:T0GjZhaAD0-jsWx5zdRQrIDEMXALvsveGXpNCFZpZNAOBEKedcrguQ>
 <xmx:T0GjZrYROfsZc8yWA2mFiWoLHfQtrdSRW8PCWC5qajXidMnGnvpz3g>
 <xmx:T0GjZtCq5OXN_cPpRNyppTvNVm4TSh3SGQ8eaeHU0sbAO2w-te9Dng>
 <xmx:T0GjZhYsMZ7Wll-0YQ33aS4ywAIE6XE9EX7kxziOlzYAtiwmg4EhEg>
 <xmx:UEGjZjLV1E97wcsRoLLyrbpChVgPeSeEbxFkV727WQZ5YbEHSR8949d_>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jul 2024 02:25:18 -0400 (EDT)
Date: Fri, 26 Jul 2024 08:25:12 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: =?utf-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 foss@defmacro.it, philmd@linaro.org, pizhenwei@bytedance.com
Subject: Re: [PATCH v9 09/10] hw/nvme: add reservation protocal command
Message-ID: <ZqNBSGmVTg-xkTs3@cormorant.local>
References: <20240712023650.45626-1-luchangqi.123@bytedance.com>
 <20240712023650.45626-10-luchangqi.123@bytedance.com>
 <ZpT1ZnOjx48_6q0j@cormorant.local>
 <58383d65-83df-4527-81e4-b4d12c409b22@bytedance.com>
 <CAO5cSZDc9_o4=VZRDFA-CXAkF12r=v95zhNQ0gBM0NHExgkbMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8aif0EHKLDQZr6s1"
Content-Disposition: inline
In-Reply-To: <CAO5cSZDc9_o4=VZRDFA-CXAkF12r=v95zhNQ0gBM0NHExgkbMw@mail.gmail.com>
Received-SPF: pass client-ip=103.168.172.156; envelope-from=its@irrelevant.dk;
 helo=fhigh5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--8aif0EHKLDQZr6s1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 25 19:42, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
> Hi,
>=20
> ```
> 2685 nvme_status->regctl_ds[i].cntlid =3D nvme_ctrl(req)->cntlid;
> 2686 nvme_status->regctl_ds[i].rkey =3D keys_info->keys[i];
> 2687 nvme_status->regctl_ds[i].rcsts =3D keys_info->keys[i] =3D=3D
> 2688 reservation->key ? 1 : 0;
> 2689 /* hostid is not supported currently */
> 2670 memset(&nvme_status->regctl_ds[i].hostid, 0, 8);
> ```
>=20
> Klaus, I think hostid(2685) is stored locally like cntlid, i
> can get cntlid by nvme_ctrl(req)->cntlid, but I can't
> find a good way to get the host ID(2670). So I add a comment
> "/* hostid is not supported currently */". Could you give me
> some advices?
>=20

The Host Identifier is just a 64 or 128 bit value that the host can set
with Set Feature. So, it is fine (and normal) that the value is
initially zero, but the host should be able to set it on controllers
with Set Feature to indicate if a controller belongs to the same host or
not.

> And using spdk as target will not fail, but it will show 0 at hostid
> at present.

Host Identifier 0 is a valid value when used with reservations; 0
indicates that the host associated with the controller is not associated
with any other controllers in the subsystem. So if two controllers have
Host Identifier set to 0, that implicitly mean they are associated with
two different hosts.

> The relevant tests in qemu are as follows=EF=BC=8C
>=20
> ```
> root@node1:~# nvme resv-report /dev/nvme0n1
> NVME Reservation Report success
>=20
> NVME Reservation status:
>=20
> gen : 1
> regctl : 1
> rtype : 0
> ptpls : 0
> regctl[0] :
> cntlid : 0
> rcsts : 0
> hostid : 0
> rkey : 6
> ```

I was hoping for an example on how to setup some simple iscsi stuff so I
could test the feature.

--8aif0EHKLDQZr6s1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmajQUgACgkQTeGvMW1P
Den9tgf7BNvRI1WaEA3ORR36tgDPj66sSAowd/k1mg1gV/h1rtx639DCLLoDcPNi
UGs0REOQ++sJ5TQaq7Ajsrk8/V2RvEBny+V07H/nE2+ssslZWOzle7xqIN44eoJQ
sFPWocCX5Hae/M2sbukrtA/jptAyFqTkGjFX4Kc1nMrkTBq5JUL4Su464/zZB1Et
oiQmdhX7H53/GfNeignBCjKOJx6Qt9wTwdchBFuHYjscI+dB5nOpHYUS9ghPKi44
a2D3wPWu2p8EWJ6DRhb5qSfT5FLx8HTBmbR26I4HFa0X/Qtpt1uTHrhpFqWJChbA
uff0PkIv6v82P0JT43W6IC0/IIP0tg==
=zjFP
-----END PGP SIGNATURE-----

--8aif0EHKLDQZr6s1--

