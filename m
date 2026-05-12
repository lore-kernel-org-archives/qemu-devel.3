Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC63CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 13:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMn63-0005NK-92; Tue, 12 May 2026 09:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wMn60-0005Ml-I4; Tue, 12 May 2026 09:24:24 -0400
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wMn5y-00043v-5F; Tue, 12 May 2026 09:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1778592252; x=1779197052; i=lukasstraub2@web.de;
 bh=Ae85CEu2c31C4JaGmgeBfM437TEA9dP1MJKJ2qAb7hI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JbTqNfROwXBXMZF0l6ExOmsr3tH7V/NsZoC4s0imTfr8Unwzwx1mSXbsNP6HFCT9
 mVfN7dIbYbv180vBaHc5LXl5IxO29OXDYhMUnRn8dDFWyK6cee4X4DTnnr+h7B9w0
 JVkI/oNw49ybrc/uZ2Jo3ztxlqzdZSnmEZVW9UFZjWOUTLGnj14DZi1j68cf4OsCm
 MkKEjqN/8CztseVFtF/m/NXXtoMsCRBQuVlGqGx8oxcbv5GgKfVv0iUtZoN87V593
 NT95drqrf/1X7dD+9TXZVAI7rqkSQ0T/SbmkYzJs5f51XT7FD8k1OmEbnSJIDCUz5
 ujVnxy/BcrCKfoEdfg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7ell-1wUE8f1q9d-00Asw9; Tue, 12
 May 2026 15:24:12 +0200
Date: Tue, 12 May 2026 15:24:02 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Hanna Reitz
 <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Xu
 <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>
Subject: Re: [PATCH 0/2] MAINTAINERS: Add myself as maintainer for replication
Message-ID: <20260512152402.0f18df61@penguin>
In-Reply-To: <agMeSMj8XETo1vMn@redhat.com>
References: <20260425-replication_maintainer-v1-0-f6ab019ff0ca@web.de>
 <agMeSMj8XETo1vMn@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W8n3VP5mUxkKEG5yG1DOcKs";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:YfNdUXl44AXH2ON94dPDbH+aLsN8GAykZ60N8GhL0JfAoTGBwbv
 7ZWRCujlrMmTQluz2kGWMz9SE6fE478Lf/gptU0cGHXBB0P0YRGpfSwlzu73EoZuSyELk30
 H9atT1esoFbnCa+b5w55zGQTBJyKH9+POvkK5pQV1zF4LfBeWtD/oUh40L90/aPr+RSVQyo
 p46GkHoctT8cN8+lxsWKQ==
UI-OutboundReport: notjunk:1;M01:P0:zQ0NJ9Z2P6Q=;dUF4RBTWOsGoGCC7+JhzjrWnutI
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--Sig_/W8n3VP5mUxkKEG5yG1DOcKs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 14:34:16 +0200
Kevin Wolf <kwolf@redhat.com> wrote:

> Hi Lukas,
>=20
> Am 25.04.2026 um 16:08 hat Lukas Straub geschrieben:
> > I recently took up maintainership for the orphaned COLO migraion compon=
ent.
> > Here I take over maintainership for replication which is another import=
ant
> > component for COLO. =20
>=20
> What are your plans with replication? Will you be sending pull requests
> directly to the global maintainer, or should we keep taking patches
> through the block layer queues with your Acked-by?

I would prefer to review patches and you take them trough the block
layer queue for now. The recent changes only have been drive-by/global
refactorings anyway.

I don't think I can send pull requests directly as my key is not yet
signed for that.

>=20
> Same question for this series, will you merge it yourself or would you
> like someone else to pick it up?

I would like someone else to pick it up.

>
>=20
> > To: qemu-devel@nongnu.org
> > Cc: qemu-block@nongnu.org
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Hanna Reitz <hreitz@redhat.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Zhang Chen <zhangckid@gmail.com>
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> > Lukas Straub (2):
> >       MAINTAINERS: Add myself as maintainer for replication
> >       MAINTAINERS: Rename Replication -> COLO block replication =20
>=20
> Acked-by: Kevin Wolf <kwolf@redhat.com>
>=20

Best regards,
Lukas Straub

--Sig_/W8n3VP5mUxkKEG5yG1DOcKs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmoDKfIACgkQNasLKJxd
slg9+w/9FUwInMt2WkpZtAGUZod1QToK8ZC1u8LrQwXnjMFkT3jHRI96kCqVmSbB
XH17z6QmL3bgBlEA/2Ixrq8Mxd3APwcQNbWvBvcJNVWy93M0wVBJS0p6XdIuZhb5
1mdVXUN2AP9LoSNS7XNjD1QmOOaqSnlHwMzMZK1nVCyU8oP+2cTbAmVFy4UXCtYz
8EzxxajmKNDQCT4pXVwUeq8pZvr757URkpY89xi3v4Zksb4ptO5yVvXmW5D5LG/c
OoAAqYMCuGVpL7dkUY+9vAFBtGu0J4iyLNchlbisSgjuiiHTBvbH9+zG8Zun14OS
ppc7ifT+CgJ/q17EYz1DtEegT4hU/KamGTaK/SuRe5Uc5kHhQ2V+VptkfAw+skU3
lsbIK8HZ/Ar7btABoubtOsn3LI12n2lAXVPuEz1zcWWjAuB2wEmbNd2Gn4qvVBn6
2vdt7Z7uPXmMf/1LRMCiWsKJuIo3ccXnP9bOtmn1e8OgC7pZd7ZiOGEgyvQOkZjV
Pg8bVrHgIdwFBwvmenj+1773LE31EsJvAAoW68ayUB+PrLZiJNLragutlgqpRDma
GBp2nlLJmV6tTsAOnIjY3w6EtzFnXzRUKqq8HeDxlC9QlcgHuwMYLOshGyKqQNsd
v+wRba60fdhz7JkZmhxF2hA07bZ4hm+j709YNYPFFNX35KNuleg=
=qcFV
-----END PGP SIGNATURE-----

--Sig_/W8n3VP5mUxkKEG5yG1DOcKs--

