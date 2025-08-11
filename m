Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BC2C87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 07:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulMZq-0006Yj-VR; Mon, 11 Aug 2025 03:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1ulMZp-0006Y9-2V
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 03:04:13 -0400
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1ulMZi-0003Eh-01
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 03:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1754895836; x=1755500636; i=lukasstraub2@web.de;
 bh=j1CtE4Hp05572NcI9Zle9XQZ0lrnpJhL/wiB9Ni1phM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Anqsj8bzmhACUe+JQf0Kvz7qf5tnZTo/3bjNuxQW0n6m71NtN0KypNHElUxoL8VL
 CD7aB5a4KntyE3Rzr1EgPODvP5QSpd5mE5lch9TmiR5o4Cy2BDS8PpavjSH2lAwwC
 Wv8GJ2Hworslh3IWvEu6jmLKea2oPkW6Deo5M7Fz6pNHNYgrjDHf1ScHpKfMbxbf0
 h2qxGeaZcaG7KsWuDA2+a2eHC+FUflI+gXMJxajQ1d4xSPks+x8jbJJ+9EOGFZPBw
 +Am10uBglIzMjfvaXV8PHmjfj7SqgeA8hz8CtADucc7NKfAjoKlkhBTfr7YOsDOvW
 J5+5h0ETfNdigPeMpg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([84.133.41.102]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml4B6-1uJlWp3wK4-00afa3; Mon, 11
 Aug 2025 09:03:56 +0200
Date: Mon, 11 Aug 2025 09:03:45 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Yong Huang <yong.huang@smartx.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
Message-ID: <20250811090345.4360fec4@penguin>
In-Reply-To: <aJYZs9NnAOqVMcd1@x1.local>
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
 <20250807113639.66d1c5bf@penguin>
 <CAK9dgmZb=5uEwVq65Ygcza0+qtng+-5zmtQRdviX2npg_qhJRQ@mail.gmail.com>
 <20250808090054.13cb8342@penguin>
 <CAK9dgmbybw+WkC2C_qdZnwSYjGn3Q2Du4yjLOz+EmCx1po8YPg@mail.gmail.com>
 <87o6sp2a0i.fsf@suse.de> <aJYZs9NnAOqVMcd1@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/h.bagEfEGb1akI6JnySLKmT";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:v9ghsamfxh0RrljRY6LXbNdEKr2xnQf8ZGG7cxYlOPh+F334dOe
 FCHuNVlFxY7SdArD63zMERe/4yrPMgbumfMU0UqiMYurU5juVU2x22bEcDBRUpUNW8GlXfb
 XrU0qHnzs+iRbQ5OZVe2cqRJ7oQ+Pta+thX7NitiU3guAH2Xg1bDN973R8pZqd184iCEZWi
 dfZ4HfUtBIcGnc7cE489Q==
UI-OutboundReport: notjunk:1;M01:P0:sftHuBNo+4k=;SqqVOW8+i0JXR8B04IuKiZqHUNT
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/h.bagEfEGb1akI6JnySLKmT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Aug 2025 11:37:23 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Fri, Aug 08, 2025 at 10:55:25AM -0300, Fabiano Rosas wrote:
> > Please work with Lukas to figure out whether yank can be used here. I
> > think that's the correct approach. If the main loop is blocked, then
> > some out-of-band cancellation routine is needed. migrate_cancel() could
> > be it, but at the moment it's not. Yank is the second best thing. =20
>=20
> I agree.
>=20
> migrate_cancel() should really be an OOB command..  It should be a supers=
et
> of yank features, plus anything migration speficic besides yanking the
> channels, for example, when migration thread is blocked in PRE_SWITCHOVER.

Hmm, I think the migration code should handle this properly even if the
yank command is used. From the POV of migration, it sees that the
connection broke with connection reset. That is the same error as if the
other side crashes/is killed or a NAT/stateful firewall in between
reboots.

>=20
> I'll add this into my todo; maybe I can do something with it this release.
> I'm happy if anyone would beat me to it.
>=20
> >=20
> > The need for a timeout is usually indicative of a design issue. In this
> > case, the choice of a coroutine for the incoming side is the obvious
> > one. Peter will tell you all about it! =3D) =20
>=20
> Nah. :)
>=20


--Sig_/h.bagEfEGb1akI6JnySLKmT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmiZldEACgkQNasLKJxd
sli7kw//WxXqhZwcoOu7qw/ZM3bsD6wN8r8Bsv82QZWZuhBhIVerMVgJqHZWrKp/
xq+6566HMBKlVsiICCmuKq8TTKeJ2v2Yx/xy3j6LnEBqQx9N6uexX2hxQUVK/hGo
CCUNSfQ8ymNcnZ89NpqhdtgCn6EwykjtKv8ASZeEV1EGmtNpexYicOvDQG6cElXG
vZJOFtzRgQdE5p7DXtSALzo3X3lw+68ReKfQtjGFnsQgLNHHw8tbY9yFtcNLXQfY
xuhVGX7mq2eBXTCFoQO/mdFtaIEQuitWoLK6lHbWLrigyDPnkJBzeR8PDW5nWPX8
jXRd1WD7c+2m2wdVg3LJiiW5r4T2R7e72fCuNyeL34GWLUwtw0xnJjO/XuH4xEcT
XbTi6MazIKX/7k7f+Z+K3VE5H1wQMXLxCVznycR81MQ0d+gA6nPXNq6o3tESUsJ/
ttOi7MCaCanQ4Fdtc+X/GUfqhKSQNJg1Tx5Nf1PkLxychuUxEf+4G/aLnXr6pSvp
QCGiWM9VCfJfAUUjJM/EelhEEStS1oeBskc/GOWLl44/ShcRcbozE7jpGxdqPSff
BOlOvDKdESPcxegwP4jd8MWIvWxt89kN1BWue3NKfzcs7N3KiA6NlXDav58A3k/y
vzweZ5durA5JT10o3aZ1HCygZSqoRcZqXvYn3LvJ3LHr2OtSTr4=
=ABST
-----END PGP SIGNATURE-----

--Sig_/h.bagEfEGb1akI6JnySLKmT--

