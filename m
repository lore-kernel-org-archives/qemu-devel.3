Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CB6C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 05:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHGoF-00034V-Ge; Wed, 12 Jun 2024 01:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sHGoD-00034E-Dx; Wed, 12 Jun 2024 01:46:09 -0400
Received: from fhigh1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sHGo8-0005Nf-NP; Wed, 12 Jun 2024 01:46:09 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 9985C11400A9;
 Wed, 12 Jun 2024 01:46:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 12 Jun 2024 01:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1718171161; x=
 1718257561; bh=m7roqio0aD7RxosC7iJZBlNkCBJwIMTgsJCVAhxEPvA=; b=P
 eOCYIG8XiPpslfi7oAP43n109Lf7z0jdkAOsCCagO6YSSXs0r9SvkAAoafHCTtxE
 hBi3MzybcD2qgDmrx7GKAorI6Tcop+xbCbMj18wbCQFudujfGl9qrgucTuGQnSPl
 K1L8fusJ2y/PmqQDeIIEdOVo+elNkAa6l2Zs7kmJqMUckGBqzOVBtf7AqYHyifMJ
 +D5oSXqXowHbJtNSOYpPcgW3kQmUJTTvhsw08K5BVkG58D0sLkeKdKxKm/3taBvr
 0wPbJ/ygCufFRjE8xq9S+9Xsdy3hDehsCUKORoZOODR/OAQNxTGwK63u17xtyWu7
 ZOl4MKD1mOMh4Wop26aAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1718171161; x=1718257561; bh=m7roqio0aD7RxosC7iJZBlNkCBJw
 IMTgsJCVAhxEPvA=; b=dCZki5TUcIVoVmweN1gU0SQPWKNvJIatTYHNIlp9dMOS
 xWD6rv24Wd/Dr/VHH201PNfHjEvmUVMxjbFfgEchEywGLLRaF3gKfKuL1672v9G6
 ApVgOYD3/cFE2xxy6UhhEFOadzAa3iZcv8gfYzG9rQ7TR57QmNG3NxbUHwxyKY6F
 CfAT00Fd+HwyeSly0dvdnp9Xnr4PezsOTb6YFfurfzV7VrtUdnoGPVk29qk6WZk4
 kw8nN3CeTTh3eeL1dzYbhn80acmFXFe6iBdBM5MIlopGRhwE5hbMa9Rx6how8O4t
 3czn5kjwYvKGUWqusO4SGPS65d2RWp5p4UxtDGszVw==
X-ME-Sender: <xms:GDZpZuPftgsgNcq71fGB-cITjcgVdioaHF1gLXF7ei7fDWOS1hkEng>
 <xme:GDZpZs9hPdHLqqRBpuJtLlDsa1PvUyO6Zy_Yzvm4UxT5HxiMYS1q9Utkvtg0SibHQ
 RUGCEhbne5OjhWFyko>
X-ME-Received: <xmr:GDZpZlT3NuEIYrganG-yA9ou9YsHgas1WNz7tGKOq2xdzx1HRjM-Eul9xsjM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedgleejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:GDZpZusy8GTQwEeIjfXuaFWI5RrJh7q5f_ldi8excMUMTYXT-nqYiQ>
 <xmx:GDZpZmeU7L78e1_EHA0UQhanMNzYffH5xNKShvwULz5I_VPbUAZofA>
 <xmx:GDZpZi1W6nna-ImZhKMT7iaz1PtGnE1HlXvsOza9XNkJxGv8z3bxVA>
 <xmx:GDZpZq-wTFz8yFB6grv_mWAC7mNaGdBKWQ4TKj5mQMauuWh54_LTlg>
 <xmx:GTZpZsv9jn9RUAOG412ZDK9r-1HC4p1937n-f89D0JgnQmqk4U3LR_UU>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 01:45:59 -0400 (EDT)
Date: Wed, 12 Jun 2024 07:45:53 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Minwoo Im <minwoo.im@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, gost.dev@samsung.com
Subject: Re: [PATCH v4 0/4] hw/nvme: FDP and SR-IOV enhancements
Message-ID: <Zmk2EeoLq59BDEkR@cormorant.local>
References: <CGME20240529125356epcas2p44725c6fa708097d0394eba22abafdc2b@epcas2p4.samsung.com>
 <20240529124234.1430707-1-minwoo.im@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LSpl/WBa3HQiUC7b"
Content-Disposition: inline
In-Reply-To: <20240529124234.1430707-1-minwoo.im@samsung.com>
Received-SPF: pass client-ip=103.168.172.152; envelope-from=its@irrelevant.dk;
 helo=fhigh1-smtp.messagingengine.com
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


--LSpl/WBa3HQiUC7b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 29 21:42, Minwoo Im wrote:
> Hello,
>=20
> This is v4 patchset to increase number of virtual functions for NVMe SR-I=
OV.
> Please consider the following change notes per version.
>=20
> This patchset has been tested with the following simple script more than
> 127 VFs.
>=20
> 	-device nvme-subsys,id=3Dsubsys0 \
> 	-device ioh3420,id=3Drp2,multifunction=3Don,chassis=3D12 \
> 	-device nvme,serial=3Dfoo,id=3Dnvme0,bus=3Drp2,subsys=3Dsubsys0,mdts=3D9=
,msix_qsize=3D130,max_ioqpairs=3D260,sriov_max_vfs=3D129,sriov_vq_flexible=
=3D258,sriov_vi_flexible=3D129 \
>=20
> 	$ cat nvme-enable-vfs.sh
> 	#!/bin/bash
>=20
> 	nr_vfs=3D129
>=20
> 	for (( i=3D1; i<=3D$nr_vfs; i++ ))
> 	do
> 		nvme virt-mgmt /dev/nvme0 -c $i -r 0 -a 8 -n 2
> 		nvme virt-mgmt /dev/nvme0 -c $i -r 1 -a 8 -n 1
> 	done
>=20
> 	bdf=3D"0000:01:00.0"
> 	sysfs=3D"/sys/bus/pci/devices/$bdf"
> 	nvme=3D"/sys/bus/pci/drivers/nvme"
>=20
> 	echo 0 > $sysfs/sriov_drivers_autoprobe
> 	echo $nr_vfs > $sysfs/sriov_numvfs
>=20
> 	for (( i=3D1; i<=3D$nr_vfs; i++ ))
> 	do
> 		nvme virt-mgmt /dev/nvme0 -c $i -a 9
>=20
> 		echo "nvme" > $sysfs/virtfn$(($i-1))/driver_override
> 		bdf=3D"$(basename $(readlink $sysfs/virtfn$(($i-1))))"
> 		echo $bdf > $nvme/bind
> 	done
>=20
> Thanks,
>=20
> v4:
>  - Rebased on the latest master.
>  - Update n->params.sriov_max_vfs to uint16_t as per spec.
>=20
> v3:
>  - Replace [3/4] patch with one allocating a dyanmic array of secondary
>    controller list rather than a static array with a fixed size of
>    maximum number of VF to support (Suggested by Klaus).
> v2:                                                    =20
>  - Added [2/4] commit to fix crash due to entry overflow
>=20
> Minwoo Im (4):
>   hw/nvme: add Identify Endurance Group List
>   hw/nvme: separate identify data for sec. ctrl list
>   hw/nvme: Allocate sec-ctrl-list as a dynamic array
>   hw/nvme: Expand VI/VQ resource to uint32
>=20
>  hw/nvme/ctrl.c       | 59 +++++++++++++++++++++++++++-----------------
>  hw/nvme/nvme.h       | 19 +++++++-------
>  hw/nvme/subsys.c     | 10 +++++---
>  include/block/nvme.h |  1 +
>  4 files changed, 54 insertions(+), 35 deletions(-)
>=20
> --=20
> 2.34.1
>=20

Looks good Minwoo!

Grabbing for nvme-next.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--LSpl/WBa3HQiUC7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmZpNhEACgkQTeGvMW1P
DekYmQf/cwCfZYVKJsW+MxZfCMiv8gfOj6W1ZegcSVCn8duR3TKABr7w2swm/sxH
tWl54wqrUxcRDld7nQTe/Lvhxcf1ZZX36x91tdq3nbo9p80mVMHP1fW0dyGfkB5q
BByVUjd7za+UtCengQGbinJFznsktSRALYRuCnYbIj/+ZAt1yly7l6EHcIXgLxPF
DdRjV58POvEBraFFHrYduzh808nVHMMirIkjpn3KHRAyietFE3fCGniwD1JH6vDN
zFfAhzAaLf7mO5NrNlfUigSypSvYGCPXRm3U1YvI+sIUWLHuLi4eH4QTrAjX01Im
4qdzddZYKtebWUiZhDkc3S7osL84eg==
=c+ZQ
-----END PGP SIGNATURE-----

--LSpl/WBa3HQiUC7b--

