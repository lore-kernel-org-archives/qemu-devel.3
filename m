Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13611D4662B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 21:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgVDz-0008My-00; Thu, 15 Jan 2026 16:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vgVDs-0008IX-MH
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 16:49:45 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vgVDq-0005mq-PF
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 16:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768513772; x=1769118572; i=lukasstraub2@web.de;
 bh=bLfYHL+qa4NXDtzHfCBCyhQoCUBx05RVDDeXFsVlA2s=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UIpcFNah3RX+YuTDTDJ+gm+D/ViMQ8FLPVLorPqCtjRslk/ghX0ty+XVv9npxdbB
 3qjq+4kueOeXPiCrmJAPIqN9LDI66BD7o7oMUCIF1C870hHLr6iECyzoE2iVuzbQi
 LfxufEivNSMSbOZ1lx6PdMtmE9a3c2Ncz8Rlzxr7YWuwqubjsz1EzR9oYaJEWZbyK
 AFvc2fkxmN8IF9UKy2CGIH3KACZSKwPaeTgI3ZT0JjucGRtMkPLHbkkM7aUtPNsxw
 iyBrezCnNBjfXIJFBghDXsZo8+CgwFO7QXpA27flpkAvwEOpQX7lQN12vr2OZeDQD
 /p/Cff46W+4ykJpyEQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.100.70]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2jWI-1voFSS0bca-013AKU; Thu, 15
 Jan 2026 22:49:32 +0100
Date: Thu, 15 Jan 2026 22:49:29 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, =?UTF-8?B?THVrw6HFoQ==?=
 Doktor <ldoktor@redhat.com>, Juan Quintela <quintela@trasno.org>, "Dr.
 David Alan Gilbert" <dave@treblig.org>, Zhang Chen <zhangckid@gmail.com>,
 zhanghailiang@xfusion.com, Li Zhijian <lizhijian@fujitsu.com>, Jason Wang
 <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <20260115224929.616aab85@penguin>
In-Reply-To: <aWf4i7EOXtpAljGX@x1.local>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L=Puqk4PVPigwWjgN+OSds3";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:pxISS2FGEKW+ZQmzq8KnH6T/f9j18JjfFTdaLjIh4sL4eZPLFY9
 5/30h0BWL11C7hfYGXzIxEhV7Ujl9VN3dAvOUfYCEwKNZeMbWtiBCbxIK5aDtGCYICrsI5W
 apGgJpvB/C9hiTXoskw5waxCQ0Xv8s1bKmLq2hKsxoezB8WRCCEBEm2vHvTkExX+sDjLYmQ
 zLQdwb6MqxKWdngdiVz9Q==
UI-OutboundReport: notjunk:1;M01:P0:jrDHfHqOWOU=;wkPc+o/Ut5mEpChLkhzV40g8b+z
 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
 hvM9mtjO2O2KV7t3lG4I
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/L=Puqk4PVPigwWjgN+OSds3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Jan 2026 15:11:55 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Wed, Jan 14, 2026 at 02:56:57PM -0500, Peter Xu wrote:
> > COLO was broken for QEMU release 10.0/10.1 without anyone noticed.  One
> > reason might be that we don't have an unit test for COLO (which we
> > explicitly require now for any new migration feature).  The other reason
> > should be that there are just no more active COLO users, at least based=
 on
> > the latest development of QEMU.
> >=20
> > I don't remember seeing anything really active in the past few years in
> > COLO development.
> >=20
> > Meanwhile, COLO migration framework maintainer (Hailiang Zhang)'s last
> > email to qemu-devel is in Dec 2021 where the patch proposed an email
> > change (<20211214075424.6920-1-zhanghailiang@xfusion.com>).
> >=20
> > We've discussed this for a while, see latest discussions here (our thou=
ghts
> > of deprecating COLO framework might be earlier than that, but still):
> >=20
> > https://lore.kernel.org/r/aQu6bDAA7hnIPg-y@x1.local/
> > https://lore.kernel.org/r/20251230-colo_unit_test_multifd-v1-0-f9734bc7=
4c71@web.de
> >=20
> > Let's make it partly official and put COLO into deprecation list.  If
> > anyone cares about COLO and is deploying it, please send an email to
> > qemu-devel to discuss.
> >=20
> > Otherwise, let's try to save some energy for either maintainers or
> > developers who is looking after QEMU. Let's save the work if we don't e=
ven
> > know what the work is for.
> >=20
> > Cc: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com> =20
>=20
> My apologize, I copied the wrong email.
>=20
> Cc: Lukas Straub <lukasstraub2@web.de>

Nack.

This code has users, as explained in my other email:
https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/#mc998=
39451d6841366619c4ec0d5af5264e2f6464

Regards,
Lukas Straub

>=20
> > Cc: Juan Quintela <quintela@trasno.org>
> > Cc: Dr. David Alan Gilbert <dave@treblig.org>
> > Cc: Zhang Chen <zhangckid@gmail.com>
> > Cc: zhanghailiang@xfusion.com
> > Cc: Li Zhijian <lizhijian@fujitsu.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  docs/about/deprecated.rst | 6 ++++++
> >  qapi/migration.json       | 5 ++---
> >  migration/options.c       | 4 ++++
> >  3 files changed, 12 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > index 7abb3dab59..b499b2acb0 100644
> > --- a/docs/about/deprecated.rst
> > +++ b/docs/about/deprecated.rst
> > @@ -580,3 +580,9 @@ command documentation for details on the ``fdset`` =
usage.
> > =20
> >  The ``zero-blocks`` capability was part of the block migration which
> >  doesn't exist anymore since it was removed in QEMU v9.1.
> > +
> > +COLO migration framework (since 11.0)
> > +'''''''''''''''''''''''''''''''''''''
> > +
> > +To be removed with no replacement, as the COLO migration framework doe=
sn't
> > +seem to have any active user for a while.
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 201dedd982..3c868efe38 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -531,8 +531,7 @@
> >  #
> >  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> >  #
> > -# @deprecated: Member @zero-blocks is deprecated as being part of
> > -#     block migration which was already removed.
> > +# @deprecated: Member @zero-blocks and @x-colo are deprecated.
> >  #
> >  # Since: 1.2
> >  ##
> > @@ -540,7 +539,7 @@
> >    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
> >             { 'name': 'zero-blocks', 'features': [ 'deprecated' ] },
> >             'events', 'postcopy-ram',
> > -           { 'name': 'x-colo', 'features': [ 'unstable' ] },
> > +           { 'name': 'x-colo', 'features': [ 'unstable', 'deprecated' =
] },
> >             'release-ram',
> >             'return-path', 'pause-before-switchover', 'multifd',
> >             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate=
',
> > diff --git a/migration/options.c b/migration/options.c
> > index 9a5a39c886..318850ba94 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -580,6 +580,10 @@ bool migrate_caps_check(bool *old_caps, bool *new_=
caps, Error **errp)
> >          warn_report("zero-blocks capability is deprecated");
> >      }
> > =20
> > +    if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
> > +        warn_report("COLO migration framework is deprecated");
> > +    }
> > +
> >  #ifndef CONFIG_REPLICATION
> >      if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
> >          error_setg(errp, "QEMU compiled without replication module"
> > --=20
> > 2.50.1
> >  =20
>=20


--Sig_/L=Puqk4PVPigwWjgN+OSds3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmlpYOkACgkQNasLKJxd
slgkqg//WyRjnMhXnCt/cYytaymHAmYwtEngPoqOFG8o00wiEju+rKY6iQcYuDMF
OBJRcUWGmJs3Gd0l8CVwapW2pqNA+LbPm5kqM6Ov/N0uovGPSCWuWz1XfX/qeZCS
wthJi6Z9BZW8B/+nHA68pKenArCc+qjgopvofzBBVHzkiOiTK2PgaLpHzKzZltC5
x77FCaIRk2kayicmI6iP9Y3AVcxvwkzouzKdCXEfwYPxZc6p0sFAvXgGDo9Gl4hx
Kzm3/3qZSK3GG0beyj8WHUM+stQIJMrTQr2B8frc4w+a+EWzfTqTLj7OWxoebB8J
qerUUifEe08Nw6QbJyt5CGVXHF9UHjjI6mbSKtibimIWoMouc1VKKy7R4mdyabfD
qIEF4VM1/sblFQw3cDP1g6IYnu//+1q9ySJTGebzn/h07rvdYEMnpyY5pJ7U1FWK
23d65O/3R7tfEDD9gRrAA0BOPgzS3c2uy1nesebb4zRkHBIZtgANL5HLYkwZ89+1
9PnqPDaE7vsCDMLJqAnv8BPMM4CU3Ht1y26Em/X6TzUNx3EqFEolwMGcF1Z+QXAs
BnNqBlilbnU+l0WfMKLDKBeBM2ZLp1/g93L0qVHIzNyQAGZhYqlKpRzdoQuDJrCH
S9FeCni+pn6aOVq5Rz6Wvaf4LQ+UBhXfcUPV6OjQmwNc/7x/ENs=
=D14w
-----END PGP SIGNATURE-----

--Sig_/L=Puqk4PVPigwWjgN+OSds3--

