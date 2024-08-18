Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EECC52D7C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2024 16:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfjE8-0002Mk-9J; Sun, 18 Aug 2024 12:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sfjE5-0002Io-O5; Sun, 18 Aug 2024 12:57:57 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sfjE1-0008Cq-Vm; Sun, 18 Aug 2024 12:57:57 -0400
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal
 [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id 2F1EA1387C78;
 Sun, 18 Aug 2024 12:57:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Sun, 18 Aug 2024 12:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1724000269; x=
 1724086669; bh=nVI5Q4w3LV17iiMT45eu4VsYFX2LwvI8HpclUJBOQa4=; b=k
 td/V2mYGwfwo6AIxReyA5BZ7WCxCdEdN9nkOZtX5JPnHSnMpw0v4OxvqxWLGQmrC
 YHuxRqvHRcAqR1sc1z1aH01Tg32sOeKaFCEHsZQ0aBhQeAlwrRd6a6w+QvH+lG5W
 X19bbnCdUDj32IoXi97YqtjGRHCsvxXyFpr3DObJ1lf52kJpo2gmDAxyNpomAEnA
 m5faKR79ylecWja1MN/h0yfOiX2CAjjg6/Qrk55fdeplkD4OJ+qyu+TrI89jvpdm
 LFzJv1je3xR1PlUh4JGdQdO4I4GR2kGR2F0pT6UQKx0TZfiCZROe9BhH7bK/WA3g
 hRgMjPX3fPCiftFInMZLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1724000269; x=1724086669; bh=nVI5Q4w3LV17iiMT45eu4VsYFX2L
 wvI8HpclUJBOQa4=; b=GjgWLf3WdFsGrzQ8vUhbblXOvwt/I6JDvGP3HbN3B4Jc
 xn4M0Nm++7cMLOjbqHMVayo9FAFlznstRIDpkvV3B+e1Fuweg3QWDlJu7g5IveLJ
 ZNP7UyNXGOCH7vN/naIqkXXCJUxXiZCPVPB8ghXs8hiitpdRg83AGdtlljNPh9Tp
 0iHJbtA4gZ2mykw4I84eRVkkJPxHQNoQn552tivQ373mGZwny69Q983W6R7P/luJ
 U//ZSHUUluLwdam4lAh5bG9MwI3yTkLyw+syUcN7R/xIhOIF4sxM/8EeyPNdbRym
 1XwQLmHm7dKGSW+L0KCJ7m1S0GWM9T2uBgNg3EbO4g==
X-ME-Sender: <xms:CyjCZgDhT1E8OaaeBV-54bzAwCnpPcRKTKeWwFy8Bw61izVqxfnjmg>
 <xme:CyjCZijpHheEkuUErBc2PkD2mC0ZRvWsdBgsjyRuIy7-YVbnM4czfJAKIC1iqPO06
 WK4wJE8AjwvVZiM6B4>
X-ME-Received: <xmr:CyjCZjmO4zVBj50wqVdG0rikSWRckKlxVsvkU-VBeO9jVcv3d__BB55Dyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduvddguddtjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:CyjCZmwwGjOtKKQ2sIhTPJASfQS8SOZRITzYa4b37VrIQD09zUn5LA>
 <xmx:CyjCZlRqe9ELxwSdxGK8F4A0hjK6sDS0Ufhf8JB7mZvwPKEv1fFfOQ>
 <xmx:CyjCZhZaanEOo8OCexgk4_0q_LVhn-preSjRQl1kKnHs5bf5bmqqew>
 <xmx:CyjCZuSwHWoegXEChNazWiYA1zNTA6_9pvF2kRj3IbW2E5KXuqWeUg>
 <xmx:DSjCZmBg6kNlbSlN7No2U8wfwLty2uSKZ250f-ZrTTjE2OjbknTRpCY9>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Aug 2024 12:57:46 -0400 (EDT)
Date: Sun, 18 Aug 2024 18:57:40 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: =?utf-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 foss@defmacro.it, philmd@linaro.org, pizhenwei@bytedance.com
Subject: Re: Ping: Re: [PATCH v9 09/10] hw/nvme: add reservation protocal
 command
Message-ID: <ZsIoBLfd40_QL9zk@cormorant.local>
References: <20240712023650.45626-1-luchangqi.123@bytedance.com>
 <20240712023650.45626-10-luchangqi.123@bytedance.com>
 <ZpT1ZnOjx48_6q0j@cormorant.local>
 <58383d65-83df-4527-81e4-b4d12c409b22@bytedance.com>
 <CAO5cSZDc9_o4=VZRDFA-CXAkF12r=v95zhNQ0gBM0NHExgkbMw@mail.gmail.com>
 <ZqNBSGmVTg-xkTs3@cormorant.local>
 <3a799eb6-3350-4b35-8e75-68d9020443cb@bytedance.com>
 <CAO5cSZDgv0V=bJx2Bj6p-Bx+1_2E4QcMrq2fSSdgoU_BtPLkrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6lcfkY/0Ax9DF0cx"
Content-Disposition: inline
In-Reply-To: <CAO5cSZDgv0V=bJx2Bj6p-Bx+1_2E4QcMrq2fSSdgoU_BtPLkrg@mail.gmail.com>
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


--6lcfkY/0Ax9DF0cx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug  6 04:56, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
> Hi;
>=20
> Klaus, Does the test method in the above email work properly?
>=20

I assume it will; I was on conference and was catching up all of last
week.

I'll take action on this this week.

> On 2024/7/26 17:53, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
> > Hi;
> >
> > You can test it in spdk.
> > First start spdk and execute the following command.
> >
> > ```
> > dd if=3D/dev/zero of=3Dtest.img bs=3D1G count=3D10
> > RPC=3D/root/source/spdk/spdk/scripts/rpc.py
> > FILE=3D/root/test.img
> >
> > $RPC bdev_aio_create $FILE aio0 512
> > $RPC iscsi_create_portal_group 1 127.0.0.1:3260
> > $RPC iscsi_create_initiator_group 2 ANY ANY
> > $RPC iscsi_create_target_node target0 target0_alias aio0:0 1:2 64 -d
> > ```
> >
> > Then start qemu and mount an nvme disk.
> > Execute the following test command.
> > ```
> > #reporter
> > nvme resv-report /dev/nvme0n1
> > #register
> > nvme resv-register /dev/nvme0n1 --nrkey 3 --rrega 0
> > #unregister
> > nvme resv-register /dev/nvme0n1 --crkey 3 --rrega 1
> > # register replace
> > nvme resv-register /dev/nvme0n1 --crkey 3 --nrkey 5 --rrega 2
> > #release
> > nvme resv-release /dev/nvme0n1 --crkey 5 --rtype 1 --rrela 0
> > #clear
> > nvme resv-release /dev/nvme0n1 --crkey 5 --rtype 1 --rrela 1
> > #reserve
> > nvme resv-acquire /dev/nvme0n1 --crkey 3 --rtype 1 --racqa 0
> > #premmpt
> > nvme resv-acquire /dev/nvme0n1 --crkey 6 --prkey 3 --rtype 1 --racqa 1
> > ```
> >
> >
> >
> > On 2024/7/26 14:25, Klaus Jensen wrote:
> >> On Jul 25 19:42, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
> >>> Hi,
> >>>
> >>> ```
> >>> 2685 nvme_status->regctl_ds[i].cntlid =3D nvme_ctrl(req)->cntlid;
> >>> 2686 nvme_status->regctl_ds[i].rkey =3D keys_info->keys[i];
> >>> 2687 nvme_status->regctl_ds[i].rcsts =3D keys_info->keys[i] =3D=3D
> >>> 2688 reservation->key ? 1 : 0;
> >>> 2689 /* hostid is not supported currently */
> >>> 2670 memset(&nvme_status->regctl_ds[i].hostid, 0, 8);
> >>> ```
> >>>
> >>> Klaus, I think hostid(2685) is stored locally like cntlid, i
> >>> can get cntlid by nvme_ctrl(req)->cntlid, but I can't
> >>> find a good way to get the host ID(2670). So I add a comment
> >>> "/* hostid is not supported currently */". Could you give me
> >>> some advices?
> >>>
> >>
> >> The Host Identifier is just a 64 or 128 bit value that the host can set
> >> with Set Feature. So, it is fine (and normal) that the value is
> >> initially zero, but the host should be able to set it on controllers
> >> with Set Feature to indicate if a controller belongs to the same host =
or
> >> not.
> >>
> >>> And using spdk as target will not fail, but it will show 0 at hostid
> >>> at present.
> >>
> >> Host Identifier 0 is a valid value when used with reservations; 0
> >> indicates that the host associated with the controller is not associat=
ed
> >> with any other controllers in the subsystem. So if two controllers have
> >> Host Identifier set to 0, that implicitly mean they are associated with
> >> two different hosts.
> >>
> >>> The relevant tests in qemu are as follows=EF=BC=8C
> >>>
> >>> ```
> >>> root@node1:~# nvme resv-report /dev/nvme0n1
> >>> NVME Reservation Report success
> >>>
> >>> NVME Reservation status:
> >>>
> >>> gen : 1
> >>> regctl : 1
> >>> rtype : 0
> >>> ptpls : 0
> >>> regctl[0] :
> >>> cntlid : 0
> >>> rcsts : 0
> >>> hostid : 0
> >>> rkey : 6
> >>> ```
> >>
> >> I was hoping for an example on how to setup some simple iscsi stuff so=
 I
> >> could test the feature.

--=20
One of us - No more doubt, silence or taboo about mental illness.

--6lcfkY/0Ax9DF0cx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmbCKAMACgkQTeGvMW1P
DeluuQf/cdrJqTZXqaYLooRoBJsjLY586LxcQ3ISzI6NNJgZ4jhZ5sm0HrierKff
d5XUGiIJWnvG+ywOEuIxIvciZcsp3gzT+hrhT3rDnTu7+Sb2DKweAfSyUwE9MPsA
XPlUBo39W1K9MIg2RpfxIfWUM/OUcxjs6fhYcKs7mYj5FOqyoBmnP5IJVTxnddSA
RAeWJUCIphjjX5/X9Nm0FFZP7HCha5Uwj18cOJCUo6wq/vyHpau4y9Q/bAFW0l1T
FEmrZftwLKlxfsYKpKGucXAIJjh1AAGuIX517r9M/83sMkRZiOwneHvLxv85S3o0
jxzAMhrgi/japIH5jPweWfxmJUEuFg==
=rpFI
-----END PGP SIGNATURE-----

--6lcfkY/0Ax9DF0cx--

