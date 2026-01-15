Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B00BD46627
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 22:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgW4D-00056n-9C; Thu, 15 Jan 2026 17:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vgW4B-000567-Dj
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:43:47 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vgW49-0006OZ-4U
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768517022; x=1769121822; i=lukasstraub2@web.de;
 bh=z+HvQp/Dfxd8ZbeuvuMziMuALNpM3s8zNVsM0nq0x8Y=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dXjXgIO90UsBrTuL2mbIA2Oc+Eg7qXAUpF3dPx81yfmOysO3pCe8nAQbxjPnYNSd
 JxS/7DilItVtV33s82LIk32q7+4v68wjQ09OqwHqyJ68rLguC9bp4IOYwJR06xsef
 2arQEAIAoeqO3FMVGnmH2NLrjKYXhdgz0zeVx+BwqNYkwQrlxBFBaALJ+fvtCCnPj
 C4oKbJZfi8jzN070WKijVbXZYAGqD7WXJpVnRuOz0Osry/WIHRP7L+RGMIKdnpzBM
 fYsPlxDaLgf1GSLalbTvvW1rHF6JacRqe3PBdRqFy31+PkJ2XA4bEN4wrxNWfWsLj
 rJHshQpsn9nlOUpWsw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.100.70]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjxiW-1w4oCc2wBc-00pE5U; Thu, 15
 Jan 2026 23:43:42 +0100
Date: Thu, 15 Jan 2026 23:43:40 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH 1/3] multifd: Add colo support
Message-ID: <20260115234340.30154904@penguin>
In-Reply-To: <aV1oj75xvV8IfrU8@x1.local>
References: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
 <20251230-colo_unit_test_multifd-v1-1-f9734bc74c71@web.de>
 <aV1oj75xvV8IfrU8@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d/7wW+4wiTeKgkTaXjOBUKO";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:wCBO8iJ4Y2r1udNsq71XomANQnajUDn1pxpozcgyMKg8HIza8XD
 cWpaYSvXSk37umZjmoSEZqoXOZK2VpbNPjA0Myxctqk4Hv4ihqhV3GKz9OUpAGLZknD0USd
 /oGBhke8CpBplcZ7Wt7d6ofMeUVbq7VVnYfQXeyIKZQi9P2lFTcP2c84XGP+mdo1X4yPNYC
 B5F+1ynAGtkRxZOZl7gYw==
UI-OutboundReport: notjunk:1;M01:P0:5lRwE5M2YHQ=;1qOCslCCQr0aOan1AbelEIoJ/nR
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--Sig_/d/7wW+4wiTeKgkTaXjOBUKO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Jan 2026 14:54:55 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Tue, Dec 30, 2025 at 03:05:44PM +0100, Lukas Straub wrote:
> > Like in the normal ram_load() path, put the received pages into the
> > colo cache and mark the pages in the bitmap so that they will be
> > flushed to the guest later.
> >=20
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  migration/meson.build    |  2 +-
> >  migration/multifd-colo.c | 57 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  migration/multifd-colo.h | 26 ++++++++++++++++++++++
> >  migration/multifd.c      | 14 +++++++++---
> >  4 files changed, 95 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/migration/meson.build b/migration/meson.build
> > index 16909d54c5110fc5d8187fd3a68c4a5b08b59ea7..1e59fe4f1f0bbfffed90df3=
8e8f39fa87bceb9b9 100644
> > --- a/migration/meson.build
> > +++ b/migration/meson.build
> > @@ -40,7 +40,7 @@ system_ss.add(files(
> >  ), gnutls, zlib)
> > =20
> >  if get_option('replication').allowed()
> > -  system_ss.add(files('colo-failover.c', 'colo.c'))
> > +  system_ss.add(files('colo-failover.c', 'colo.c', 'multifd-colo.c'))
> >  else
> >    system_ss.add(files('colo-stubs.c'))
> >  endif
> > diff --git a/migration/multifd-colo.c b/migration/multifd-colo.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..05a81e57b2bda517cbc0844=
b4f03dc78453f6af8
> > --- /dev/null
> > +++ b/migration/multifd-colo.c
> > @@ -0,0 +1,57 @@
> > +/*
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * multifd colo implementation
> > + *
> > + * Copyright (c) Lukas Straub <lukasstraub2@web.de>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "exec/target_page.h"
> > +#include "qemu/error-report.h"
> > +#include "qapi/error.h"
> > +#include "ram.h"
> > +#include "multifd.h"
> > +#include "options.h"
> > +#include "io/channel-socket.h"
> > +#include "migration/colo.h"
> > +#include "multifd-colo.h"
> > +#include "system/ramblock.h"
> > +
> > +void multifd_colo_prepare_recv(MultiFDRecvParams *p)
> > +{
> > +    if (!migrate_colo()) { =20
>=20
> We should avoid invoking *_colo_*() function, then check COLO enabled or
> not only reaching here.  Instead, we'd check "migrate_colo()" first and
> invoke it only if it's enabled.

Okay, I will fix that in the next version.

>=20
> > +        return;
> > +    }
> > +
> > +    assert(p->block->colo_cache);
> > +
> > +    /*
> > +     * While we're still in precopy state (not yet in colo state), we =
copy
> > +     * received pages to both guest and cache. No need to set dirty bi=
ts,
> > +     * since guest and cache memory are in sync.
> > +     */
> > +    if (migration_incoming_in_colo_state()) {
> > +        colo_record_bitmap(p->block, p->normal, p->normal_num);
> > +    }
> > +    p->host =3D p->block->colo_cache; =20
>=20
> May want to update the comment of "host" then, because it isn't always
> pointing to ramblock's buffer now when COLO is enabled.

Will do.

>=20
> > +}
> > +
> > +void multifd_colo_process_recv(MultiFDRecvParams *p)
> > +{
> > +    if (!migrate_colo()) { =20
>=20
> Same here.
>=20
> > +        return;
> > +    }
> > +
> > +    if (!migration_incoming_in_colo_state()) {
> > +        for (int i =3D 0; i < p->normal_num; i++) {
> > +            void *guest =3D p->block->host + p->normal[i];
> > +            void *cache =3D p->host + p->normal[i];
> > +            memcpy(guest, cache, multifd_ram_page_size());
> > +        }
> > +    }
> > +    p->host =3D p->block->host;
> > +}
> > diff --git a/migration/multifd-colo.h b/migration/multifd-colo.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..82eaf3f48c47de2f090f9de=
52f9d57a337d4754a
> > --- /dev/null
> > +++ b/migration/multifd-colo.h
> > @@ -0,0 +1,26 @@
> > +/*
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * multifd colo header
> > + *
> > + * Copyright (c) Lukas Straub <lukasstraub2@web.de>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#ifndef QEMU_MIGRATION_MULTIFD_COLO_H
> > +#define QEMU_MIGRATION_MULTIFD_COLO_H
> > +
> > +#ifdef CONFIG_REPLICATION
> > +
> > +void multifd_colo_prepare_recv(MultiFDRecvParams *p);
> > +void multifd_colo_process_recv(MultiFDRecvParams *p);
> > +
> > +#else
> > +
> > +static inline void multifd_colo_prepare_recv(MultiFDRecvParams *p) {}
> > +static inline void multifd_colo_process_recv(MultiFDRecvParams *p) {}
> > +
> > +#endif
> > +#endif
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index bf6da85af8a1e207235ce06b8dbace33beded6d8..9006f73cc5b52e8814da107=
c0b5c867ee6d03a95 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -29,6 +29,7 @@
> >  #include "qemu-file.h"
> >  #include "trace.h"
> >  #include "multifd.h"
> > +#include "multifd-colo.h"
> >  #include "threadinfo.h"
> >  #include "options.h"
> >  #include "qemu/yank.h"
> > @@ -1398,11 +1399,18 @@ static void *multifd_recv_thread(void *opaque)
> >              if (is_device_state) {
> >                  assert(use_packets);
> >                  ret =3D multifd_device_state_recv(p, &local_err);
> > +                if (ret !=3D 0) {
> > +                    break;
> > +                }
> >              } else {
> > +                multifd_colo_prepare_recv(p);
> > +
> >                  ret =3D multifd_recv_state->ops->recv(p, &local_err);
> > -            }
> > -            if (ret !=3D 0) {
> > -                break;
> > +                if (ret !=3D 0) {
> > +                    break;
> > +                }
> > +
> > +                multifd_colo_process_recv(p); =20
>=20
> Personally I'd suggest we introduce multifd_ram_state_recv() and put
> everything there.

Will do.

>=20
> Thanks,
>=20
> >              }
> >          } else if (is_device_state) {
> >              error_setg(&local_err,
> >=20
> > --=20
> > 2.39.5
> >  =20
>=20


--Sig_/d/7wW+4wiTeKgkTaXjOBUKO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmlpbZwACgkQNasLKJxd
slj/aw//ebWosqFdo0Q8/N1Pm3llXXTSE6T1HwqOCa6PD39YG4cuy2JlNr8mLSMu
Vl5x3eEgCkhB1eG+ZhzQfwzfXMFTnOGi9Ee7fqy+773ogdj+nBeEyVZu2rTFfKeB
RWaLrbgnwtDolfRvIqneJwE7xE8cyc6RcJr4LMA9nvVs533eHLJfIg0QFSz42TKm
3kDb4yBLBh3qTY4kWRZfylqP7hEA5lepfXZi7zcgErS33/LgdGcd4+BRv8yZxmKY
pH6CK+JFK2/xLnTZb7CwZg2mcpt4DtfHNL7v/mlPdCaVrIyWO1Vqux08qyny6Fel
WfjQiNDjUFXszPfOpSqtd/LugNXeTHr4zX3YwjmHuSOptb5/IUM7J/69RXgUC6Dt
WQPA3lM7V+Hg72Y6EpamspM5Gwyaf6a0Ig7qkA0vwFz4k0gObVMqbbk0oJ1mEpsE
RPNiDmH2tvGG94gHuRnJCeqjlcaLeXwsQk3Txz+4lrg9QUmBUJTBH8lkCQW6LWrG
cRn49E1g1V8YyNIkdYGb2N/KTLDQwHgBywdS9Mrn0MnsFhwiURaQdsJF/STS8qg2
6CZkuv91DVi4nGxv2WVBrs2cn/dkdQAtgE6RBFZ4BwStv6oyE0Xn81BUBRWo3UgK
jyrny28Q+0ZT1AE+jjL2/Qr1ZblMxoz+9FSQ6vlnKqtqPBhavyA=
=4VYW
-----END PGP SIGNATURE-----

--Sig_/d/7wW+4wiTeKgkTaXjOBUKO--

