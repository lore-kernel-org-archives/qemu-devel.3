Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80115CF65DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkKGo-0003bQ-4E; Mon, 26 Jan 2026 05:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vkKGm-0003aO-CP
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 05:56:32 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vkKGk-0006wH-4V
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 05:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769424987; x=1770029787; i=lukasstraub2@web.de;
 bh=Pbut40gUjXTs4zpGqEYwGXNMomrYfPgLVYSPw96AeO0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Px5KlhhXz/9AvmdFObTGKBlV5n3lizri6up1PmZvvImZvxOX+MpNZkiLTO3wu6GK
 xvid+wsByFo27g5e9f+kIrXpETYAEflLHXXocgkuFSaUesq2TwPvYZhwHG5XQf2EO
 nJo+Ea/QRaw1+puWJDum+tp8I8jvESwynLviMhQrkMKw2KcBxGSQfH9JzyQbfIEml
 kvfdWzRd7BjJJ+sR5XyV4FbExXL5HJuh53GaaMhqcQPo9dXKXsS0Qo9osDGTSt20a
 1XGYANNeVVCBlWUR6bm+FKuazkUIvdqnBA6th9uT9ROpkH23a12WWXwEdf1a1EBxi
 +52qGnsaRVAedvMqfg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.97.172]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXoYQ-1vGbdn1Vro-00PlR2; Mon, 26
 Jan 2026 11:56:27 +0100
Date: Mon, 26 Jan 2026 11:56:08 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 08/10] qemu-colo.rst: Miscellaneous changes
Message-ID: <20260126115608.1dc7a6a2@penguin>
In-Reply-To: <CAK3tnvLohfapCAXg_+L5W_foVXzLtkDQ7bFhY-8esbo+LPUd0A@mail.gmail.com>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-8-ae926ccd8eae@web.de>
 <CAK3tnvLohfapCAXg_+L5W_foVXzLtkDQ7bFhY-8esbo+LPUd0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WVLtXikn_/SG1n98lH79YGw";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:UxQm/50DfbBw58WoeDXlMCcJYe4t1nzfwtMqoqQB+IZd7OATI87
 5774Wm4HWKP0PUSaRrNnnhMoyH39KVYIt+c33M7cVAJIsJTFVhvo3qoZyvfkbSKWAt2+QW8
 GleDHXZX2v6VztsZxWxzGOhrXI18jY9/07CQj3eEcjUeivRTRCOXKwODvi+FPiUEuxwJcdt
 NHz9B30NK/LhLAf2NZjCQ==
UI-OutboundReport: notjunk:1;M01:P0:9gW37f84qfI=;4iWncZpLm0k8+wMxgpnwDlmgWT5
 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
 XtBIbed1DpNTGjBXZrrL
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

--Sig_/WVLtXikn_/SG1n98lH79YGw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Jan 2026 18:21:10 +0800
Zhang Chen <zhangckid@gmail.com> wrote:

> On Mon, Jan 26, 2026 at 4:40=E2=80=AFAM Lukas Straub <lukasstraub2@web.de=
> wrote:
> >
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de> =20
>=20
> It seems this patch doesn't offer any major changes and merging it
> with the previous patch(7/10) would be more appropriate.

It's better to have it separately to see what is changed exactly. The
previous patch only does 1:1 conversion from text to rst without any
other changes.

If merged with the previous patch it becomes harder to see that I moved
and added a few lines here, which are changes that where not in the
original text file.

Regards,
Lukas Straub

>=20
> Thanks
>=20
> Chen
>=20
> > ---
> >  docs/system/qemu-colo.rst | 35 ++++++++++++++++++-----------------
> >  1 file changed, 18 insertions(+), 17 deletions(-)
> >
> > diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
> > index 4b5fbbf398f8a5c4ea6baad615bde94b2b4678d2..a70e61aa09391cda9330315=
35fa982d27cf6654b 100644
> > --- a/docs/system/qemu-colo.rst
> > +++ b/docs/system/qemu-colo.rst
> > @@ -1,13 +1,6 @@
> >  Qemu COLO Fault Tolerance
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > -| Copyright (c) 2016 Intel Corporation
> > -| Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> > -| Copyright (c) 2016 Fujitsu, Corp.
> > -
> > -This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
> > -See the COPYING file in the top-level directory.
> > -
> >  This document gives an overview of COLO's design and how to use it.
> >
> >  Background
> > @@ -82,8 +75,8 @@ Overview::
> >          |   Storage     |  |External Network|       | External Network=
 | |   Storage    |
> >          +---------------+  +----------------+       +-----------------=
-+ +--------------+
> >
> > -Components introduction
> > -^^^^^^^^^^^^^^^^^^^^^^^
> > +Components
> > +^^^^^^^^^^
> >  You can see there are several components in COLO's diagram of architec=
ture.
> >  Their functions are described below.
> >
> > @@ -157,14 +150,21 @@ in test procedure.
> >
> >  Test procedure
> >  --------------
> > -Note: Here we are running both instances on the same host for testing,
> > +
> > +Setup
> > +^^^^^
> > +
> > +Here we are running both instances on the same host for testing,
> >  change the IP Addresses if you want to run it on two hosts. Initially
> >  ``127.0.0.1`` is the Primary Host and ``127.0.0.2`` is the Secondary H=
ost.
> >
> > +COLO uses double the guest ram size on the secondary side. The Qemu ve=
rsion
> > +should be the same on both hosts.
> > +
> >  Startup qemu
> >  ^^^^^^^^^^^^
> >  **1. Primary**:
> > -Note: Initially, ``$imagefolder/primary.qcow2`` needs to be copied to =
all hosts.
> > +Initially, ``$imagefolder/primary.qcow2`` needs to be copied to all ho=
sts.
> >  You don't need to change any IP's here, because ``0.0.0.0`` listens on=
 any
> >  interface. The chardev's with ``127.0.0.1`` IP's loopback to the local=
 qemu
> >  instance::
> > @@ -192,7 +192,7 @@ instance::
> >
> >
> >  **2. Secondary**:
> > -Note: Active and hidden images need to be created only once and the
> > +Active and hidden images need to be created only once and the
> >  size should be the same as ``primary.qcow2``. Again, you don't need to=
 change
> >  any IP's here, except for the ``$primary_ip`` variable::
> >
> > @@ -353,8 +353,9 @@ Wait until disk is synced, then::
> >      {"execute": "migrate-set-capabilities", "arguments":{ "capabilitie=
s": [ {"capability": "x-colo", "state": true } ] } }
> >      {"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.1:9998" }=
 }
> >
> > -TODO
> > -----
> > -1. Support shared storage.
> > -2. Develop the heartbeat part.
> > -3. Reduce checkpoint VM=E2=80=99s downtime while doing checkpoint.
> > +| Copyright (c) 2016 Intel Corporation
> > +| Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> > +| Copyright (c) 2016 Fujitsu, Corp.
> > +
> > +This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
> > +See the COPYING file in the top-level directory.
> >
> > --
> > 2.39.5
> > =20


--Sig_/WVLtXikn_/SG1n98lH79YGw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAml3SEgACgkQNasLKJxd
slhCEw/9HdTMNZjXIe0BZfaEwW985ycvICSBwZddVwcG20fG6PSG4oqZg99+zt3R
4xs/lxhT2sxX7YK1NGBg36/Lzhm7AeHW/eh9S2ujaXfLBvpnL7K4g0WFg15zdE5Z
4yssWURItpQB9m7NEg8J1PL/JptkjePaRutUA6+Qj6LNNkVNfyvg//AosAE4dHIa
zWUbtJV1l8I/boSWbbSEFPQX6/t7VK6RuJhvV23aqEiy3etbBI6YfOV4Dx5RvZfR
zY9Az92chQtWrur9kqFpPQ0rNVRTZAyHhfRTW9w4Td+t/NMgtkt3675gye0aqCKu
UaN9x+Cyy3N3uE7GwMNZzIJ+ih4aUh46JtX+DBwvJUzrvwR9h6KjTLFKUEFyJcRh
g+lUm7Hl89DZfXQKO1bZvsyXFKzVyfYxuFgV55nQjrWsY+HAj4seU1qxWnpB710G
hI85L2MRh02oa05X8yBUA793BacFrqV4/a8sEHbiP+Uj6yb2rTkpN8ziEsdkJtDf
b/OiOKgTdQK/pBS9V8R4pnKncrKKWyfN9JEI9VnILcxRbgxuS38DLOmjud58rPwh
Kf80o+C/xxpIds4SFcYuSi1gAJapfcYSPICuOTv1m2fr7ZyHRfor5jg8NOav5u8r
3kkTohGvFq39Co9MGq2l/1VZL6svMds4/FFgYbWJcsP+krWPRes=
=HcDH
-----END PGP SIGNATURE-----

--Sig_/WVLtXikn_/SG1n98lH79YGw--

