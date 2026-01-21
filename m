Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B3DC44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 19:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vie84-0000Zs-J9; Wed, 21 Jan 2026 14:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vie83-0000Ze-Bx
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 14:44:35 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vie81-0007MJ-BG
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 14:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769024669; x=1769629469; i=lukasstraub2@web.de;
 bh=ob1OeaFKxRqQmm0ksld32NAbVUfbXk96/sZnCEZmd/E=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nlNJOI3a6VtaFy7GRGbTuTKKsvzXAcBhYWjHJvkUW5cMp2AoDu/WfMSo7bxtkjHx
 NhRN9UikuAUIYavRHvDHl86vkqKOsHiI9M4quJqWZnu951n/KkVyMHsy8oy9AMftP
 y2E5GgzjEU9Amm/IAMhY+/L1XlFV9msFDzC8EjB4KKY9JMAU65E0n/ZxX+o06MUx5
 olhYzVKOOccbVJOm3vLTy/JXSLtdlF79HUKSYUaroPg3kfi3iI2zoWtxkl9WzlOBf
 8PyOsdKICb3YwbiLhzbyK+tcplE/+1hfQHhAFQ0rfULPeRbiD9Zb8NgEHPfF+pTT+
 3MeDjpei6Fh/J3VN7g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.100.70]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MEUS0-1vYAo31rII-007gaS; Wed, 21
 Jan 2026 20:44:29 +0100
Date: Wed, 21 Jan 2026 20:44:27 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 6/8] Convert colo main documentation to restructuredText
Message-ID: <20260121204427.3eb64618@penguin>
In-Reply-To: <aW-6uSs0kO-4imOp@x1.local>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-6-ab521777fa51@web.de>
 <aW-6uSs0kO-4imOp@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DbIWRDgh5KhtUzTXFMVQe9a";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:QCNCoUVLfvHJzcaqqCPDmaDFgF+ld4SEaQzPR+QDvOFpnyMSkMX
 qi8sp0o48GILPkSM9aaxJbQnRIrUxrTJllfPMehhUAr9nxKY/ZW7MwA+4DEzDPENBWxNXPo
 OyZQEw1bKZcU7EbeakFdx6a7FLWMC3Ysn2fCAh1BVxchauWH2O0HKZkEbbJ/4Zkq5hNcvz8
 oGsrckQX7yrhgkV+OXrvQ==
UI-OutboundReport: notjunk:1;M01:P0:qEqQrjUM9fs=;vIAXa7uGNh6mLLtOlW39VMrTPFo
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--Sig_/DbIWRDgh5KhtUzTXFMVQe9a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jan 2026 12:26:17 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Sat, Jan 17, 2026 at 03:09:13PM +0100, Lukas Straub wrote:
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  MAINTAINERS               |   2 +-
> >  docs/COLO-FT.txt          | 334 --------------------------------------=
----
> >  docs/system/index.rst     |   1 +
> >  docs/system/qemu-colo.rst | 361 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 363 insertions(+), 335 deletions(-) =20
>=20
> Thank you.
>=20
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 92ca20c9d4186a08519d15bfe8cbd583ab061a8b..4c30dc50d15c74b317443e4=
3920e01b4560b03a5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3841,7 +3841,7 @@ F: migration/multifd-colo.*
> >  F: include/migration/colo.h
> >  F: include/migration/failover.h
> >  F: tests/qtest/migration/colo-tests.c
> > -F: docs/COLO-FT.txt
> > +F: docs/devel/qemu-colo.rst =20
>=20
> Should we still put it under docs/devel/migration?
>=20
> COLO framework is under migration/.  COLO tests will be under
> tests/qtest/migration/.  I still think we should keep doc under migration/
> too, IOW when someone touches that we want to get copied too.

Whoops, this should be docs/system/qemu-colo.rst so user documentation.

I think this document is more for users, so they can test it just with
standalone qemu.
Also I want to replace the wiki page with this so they don't go
out of sync.

>=20
> I also raised some other requests while discussing with you on the COLO
> details.  If you want, feel free to attach one more patch to add those
> contents into the doc (after this conversion patch), on either doubled mem
> consumption of SVM, or RAM mgmt details.

Will do.
I think I will make a extra doc for devel/migration.

>=20
> Thanks,
>=20


--Sig_/DbIWRDgh5KhtUzTXFMVQe9a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmlxLJsACgkQNasLKJxd
slgFhRAAut+vfPYZM2sLHykg+dUjP3pH1S9iXFfcP/HXT+2CuOmDUaBqGhF631fh
Yi0nunmSPv5wMwW7YpW/3+/10bofzmB/DV3munj5u7WRnwArQTHPigHE0rXayJa2
INjowR8Wi1qLGTNQnxkmDnh7Paj6MEdePqUpJx7ZjjDyf6TjTbet7PD18pYVcF5l
F+HB0F4AYoivQD7qIQIGd42uhv3/ydnTcoWQ3Qtm1nNN7Xj1k30Hv9fOUINeNiuD
e5R7xJERjRcH6pkhEpqv0LEriMraPLH3PcaA0JpQ+AdaqmOfK+LaBT6AP12pwHEY
OSe0lWWJeLtNakp5U+a3NHXaauNF2RvbnuaxbJSs6pKhkw0W2D3pBOvBJE7oFp2c
YUK1EBA8U9v8mXmNxab3qz//964z4gNjHNhYA66hn3GRontOpHZKXA/CFVre8SsM
1bYzT5Q/a9TWTR1tY8UNyUffb1ypfw77yTqm8km3Kmxsbz65S+xMxbTdfjUjZIWX
OxPLPY4eS2ft6KNq/L/nyeSnQThA1Wjta5+moj8VpYromwX0Bj7lXgX7zr3ldvtK
2i7voxGKuD9FPkXJhvnktdI1aVEx9Z8zzQMkPP2nqw/u7Vk5ozW+Xx08b0gN+yZn
XtmRKXidBoLRx1CNEpXkzlOumMlEKttM7746Ah1QNDGuTaxY11U=
=bY6/
-----END PGP SIGNATURE-----

--Sig_/DbIWRDgh5KhtUzTXFMVQe9a--

