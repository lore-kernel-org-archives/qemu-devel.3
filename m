Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AFFC5472D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 06:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjBoN-0004eS-KY; Wed, 28 Aug 2024 02:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sjBoL-0004bn-AJ; Wed, 28 Aug 2024 02:05:41 -0400
Received: from fout7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sjBoI-0003Md-2c; Wed, 28 Aug 2024 02:05:40 -0400
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal
 [10.202.2.44])
 by mailfout.nyi.internal (Postfix) with ESMTP id 5A586139009A;
 Wed, 28 Aug 2024 02:05:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 28 Aug 2024 02:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1724825132; x=
 1724911532; bh=/uyUog+gzcS9a7GYlPoT3D4Zd958ufTmMTJSw2ZlVeY=; b=c
 vMctoyDxDJ3sTuMnsr7JVhSVpqaOA2/6JlizSrVGWdKuCsoOA6qvn/7S9NV9tB7x
 7UQuGDF5yCGkb7DWSXQELcprxYZgvG7uMB6tI5ynWpKSU8W7NkU6CCoG38ukI2Ws
 1zsXe63aIY2JTxI87asjlRZqRLZMNerALi3Cwag+zAariEjrWnfxGFikTz4EEvt6
 5QGtohYCNRJOAG6rY2t6dQhZNEV9XWL4hH3YfEFuzonOTEq8w/+zVRFbXrWnmbF3
 a1/63tS5fa47CoDUOA2rekh9Ih1BhzmPk2DidhdWjNwgP3XmWlFIFO4calv750Px
 /l0HhTs3zs8WnodY+KnUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1724825132; x=1724911532; bh=/uyUog+gzcS9a7GYlPoT3D4Zd958
 ufTmMTJSw2ZlVeY=; b=rrQYZ/EFuRALaiSaw5XoX29+AF/sLs57fIcGAWHyAUNy
 yWn25oCRzq0skguJHPm5R/JpyhUl9FdKyFhg1vbU7sYnquGaUPbEyKpYZMfGJdqc
 dxu7L+BCtH+JXiBynY4gOde1Arq0iH+LeAlzFYri+VGlXjhCzYgOkiJY7PCPa6Mt
 HvTDFfs9tSIWfq0G7eRrL/gwYWOBgPgRE44ocZb0IHaL+mC/tYWcKX4thL79XM2s
 zdYocFfbLrOZCmdZiY4YK6PQxYiqRSaq0jyYHY0ac1zrqVXaMcUT/vG8TKix/TKV
 CcM/gPtaJYJ+sPBqV7ENH0km3hmsiZeiY4uzmK+7oA==
X-ME-Sender: <xms:Kr7OZr5hCfwJ_NISmdGyVGOIoboPLe6iBCb5ykanwBlUKt9GHdOT9w>
 <xme:Kr7OZg5u7eSZb4mzt7lHcog6cPZWnG8p1EcUxBarJtl70ViyGsDI9ZJveHPbhtBFr
 veO0nI93z1xD97UfOE>
X-ME-Received: <xmr:Kr7OZifIQFqHgY97iDVv8dqnQGoEVBDpXl-ay1N4cz06LHEAO-d4qZ6BLMxi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefuddguddthecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
 evuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushculfgvnhhsvghn
 uceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnhepjefgje
 efffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffffjeevnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlh
 gvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdp
 rhgtphhtthhopehluhgthhgrnhhgqhhirdduvdefsegshihtvggurghntggvrdgtohhmpd
 hrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohep
 qhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdqug
 gvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhifohhlfhesrhgvughhrght
 rdgtohhmpdhrtghpthhtohephhhrvghithiisehrvgguhhgrthdrtghomhdprhgtphhtth
 hopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfhgrmhesvghu
 phhhohhnrdhnvghtpdhrtghpthhtoheprhhonhhnihgvshgrhhhlsggvrhhgsehgmhgrih
 hlrdgtohhm
X-ME-Proxy: <xmx:Kr7OZsKuPzw6vxZT1SzpPgWAss9SER2StL_TJzi2KvQwjZLMfnFkFw>
 <xmx:Kr7OZvJ4O3EyjOlb1TKYAA9Jj08Q0AeDkGRWH9MNzdhQyY3HSNApAg>
 <xmx:Kr7OZlyH-oCVoruId5PokTs2-7ERprU_hGNQ4xCZmpWaD3KM9aZDMA>
 <xmx:Kr7OZrLbtQM61KD7UgTMzx0i_drGoSdG9QO5MyvoY9zwYacXMPNkCw>
 <xmx:LL7OZo5xDZM6QCpNBABxRReeZBgNegjat5zhJeVCALCrnlxcelT8w81M>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Aug 2024 02:05:29 -0400 (EDT)
Date: Wed, 28 Aug 2024 08:05:25 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: =?utf-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 foss@defmacro.it, philmd@linaro.org, pizhenwei@bytedance.com
Subject: Re: [External] Re: [PATCH v9 09/10] hw/nvme: add reservation
 protocal command
Message-ID: <Zs6-JTAIaWILMOYM@cormorant.local>
References: <20240712023650.45626-1-luchangqi.123@bytedance.com>
 <20240712023650.45626-10-luchangqi.123@bytedance.com>
 <ZpT1ZnOjx48_6q0j@cormorant.local>
 <58383d65-83df-4527-81e4-b4d12c409b22@bytedance.com>
 <CAO5cSZDc9_o4=VZRDFA-CXAkF12r=v95zhNQ0gBM0NHExgkbMw@mail.gmail.com>
 <ZqNBSGmVTg-xkTs3@cormorant.local>
 <CAO5cSZD8Vk-=z-REXjusrXXemN4T4=-kA=_aXiPsiR4MsjL10Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tuzDTpDvhvpsrRW0"
Content-Disposition: inline
In-Reply-To: <CAO5cSZD8Vk-=z-REXjusrXXemN4T4=-kA=_aXiPsiR4MsjL10Q@mail.gmail.com>
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


--tuzDTpDvhvpsrRW0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 26 05:54, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
> Hi;
>=20
> You can test it in spdk.
> First start spdk and execute the following command.
>=20
> ```
> dd if=3D/dev/zero of=3Dtest.img bs=3D1G count=3D10
> RPC=3D/root/source/spdk/spdk/scripts/rpc.py
> FILE=3D/root/test.img
>=20
> $RPC bdev_aio_create $FILE aio0 512
> $RPC iscsi_create_portal_group 1 127.0.0.1:3260
> $RPC iscsi_create_initiator_group 2 ANY ANY
> $RPC iscsi_create_target_node target0 target0_alias aio0:0 1:2 64 -d
> ```
>=20
> Then start qemu and mount an nvme disk.

Forgive my ignorance when it comes to iSCSI, but can you enlighten me as
to what the name of the target is? I tried a bunch of combinations.

I configured QEMU with

  -drive id=3Dtarget0,file=3Discsi://127.0.0.1/target0/0
  -device nvme,serial=3Ddeadbeef,drive=3Dtarget0

But on the spdk side (iscsi_tgt) I'm getting "target0 not found".

> Execute the following test command.
> ```
> #reporter
> nvme resv-report /dev/nvme0n1
> #register
> nvme resv-register /dev/nvme0n1 --nrkey 3 --rrega 0
> #unregister
> nvme resv-register /dev/nvme0n1 --crkey 3 --rrega 1
> # register replace
> nvme resv-register /dev/nvme0n1 --crkey 3 --nrkey 5 --rrega 2
> #release
> nvme resv-release /dev/nvme0n1 --crkey 5 --rtype 1 --rrela 0
> #clear
> nvme resv-release /dev/nvme0n1 --crkey 5 --rtype 1 --rrela 1
> #reserve
> nvme resv-acquire /dev/nvme0n1 --crkey 3 --rtype 1 --racqa 0
> #premmpt
> nvme resv-acquire /dev/nvme0n1 --crkey 6 --prkey 3 --rtype 1 --racqa 1
> ```
>=20
>=20
>=20
> On 2024/7/26 14:25, Klaus Jensen wrote:
> > On Jul 25 19:42, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
> >> Hi,
> >>
> >> ```
> >> 2685 nvme_status->regctl_ds[i].cntlid =3D nvme_ctrl(req)->cntlid;
> >> 2686 nvme_status->regctl_ds[i].rkey =3D keys_info->keys[i];
> >> 2687 nvme_status->regctl_ds[i].rcsts =3D keys_info->keys[i] =3D=3D
> >> 2688 reservation->key ? 1 : 0;
> >> 2689 /* hostid is not supported currently */
> >> 2670 memset(&nvme_status->regctl_ds[i].hostid, 0, 8);
> >> ```
> >>
> >> Klaus, I think hostid(2685) is stored locally like cntlid, i
> >> can get cntlid by nvme_ctrl(req)->cntlid, but I can't
> >> find a good way to get the host ID(2670). So I add a comment
> >> "/* hostid is not supported currently */". Could you give me
> >> some advices?
> >>
> >
> > The Host Identifier is just a 64 or 128 bit value that the host can set
> > with Set Feature. So, it is fine (and normal) that the value is
> > initially zero, but the host should be able to set it on controllers
> > with Set Feature to indicate if a controller belongs to the same host or
> > not.
> >
> >> And using spdk as target will not fail, but it will show 0 at hostid
> >> at present.
> >
> > Host Identifier 0 is a valid value when used with reservations; 0
> > indicates that the host associated with the controller is not associated
> > with any other controllers in the subsystem. So if two controllers have
> > Host Identifier set to 0, that implicitly mean they are associated with
> > two different hosts.
> >
> >> The relevant tests in qemu are as follows=EF=BC=8C
> >>
> >> ```
> >> root@node1:~# nvme resv-report /dev/nvme0n1
> >> NVME Reservation Report success
> >>
> >> NVME Reservation status:
> >>
> >> gen : 1
> >> regctl : 1
> >> rtype : 0
> >> ptpls : 0
> >> regctl[0] :
> >> cntlid : 0
> >> rcsts : 0
> >> hostid : 0
> >> rkey : 6
> >> ```
> >
> > I was hoping for an example on how to setup some simple iscsi stuff so I
> > could test the feature.

--=20
One of us - No more doubt, silence or taboo about mental illness.

--tuzDTpDvhvpsrRW0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmbOviQACgkQTeGvMW1P
DembMgf+NsLOJtUfcS8cagljIF180/8v+dR9VSwD0TNcCYT8i6kWm+2XvFeTZYd3
YROoXRMwi6PmQVVcBjp6QrCSU5mb+0dWhCgL0zDCe0eQ0JYwvRZWeQy7el4rWSGN
ap0vE/V+seRxMoht8aUeESSZO6e4DLl++FWXf7wo6K+dWJfErt/SHLALJ0eM6c+a
WwRAVOqnMsjeJKQZetUnUPaHyZZYF/IVb5xOkAuGiZkdb3Y4wsFdAWT+/ob9zaIN
wPDuoWG8GUie0W76mMir9g9VgqGmCnFnr9fb1ehSXxO+w/XZem6r9PINjZi/kU3p
Eb9I4NJbGjLThmGs5NMpG3XvIkTTeA==
=F46I
-----END PGP SIGNATURE-----

--tuzDTpDvhvpsrRW0--

