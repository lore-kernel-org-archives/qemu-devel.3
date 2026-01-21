Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C1AC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 19:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vidS1-0004fm-DP; Wed, 21 Jan 2026 14:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vidRz-0004ez-HW
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 14:01:07 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vidRw-0008BV-Kp
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 14:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769022060; x=1769626860; i=lukasstraub2@web.de;
 bh=EHC6BM8Gpg68nIw+bmfE8wamqv+Ibc4xIftYsbSWvKg=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=t7YJdltTvSwNgMGnsr0GjWV8wJ7aOZJmC/dyckQjgPXUI3a6qNu/H+5cB0/06thv
 gdVuB4sN/7Plr6I3MjCM7JiVChB09h07T1knksFFb5saF4EuWw3CE8t7/xfxO2Uoh
 NIiK5ynDOcsv1y6N3JclFWXhgPBMDEYVXLCBOvKmtTwLagi9cpJS28CLvcKdtWTNH
 VvW3SuG7yRZfrKeZa+QF9SVIbhv3oKm6MizQeSI//oPwbZxirTGfPEDe6/am7TVnu
 0Rg41RGL7Hxk+nOdTvd/3cmSIG9A0RV0x8i9G8PA0l9/qw/rjKxjtTGqIA1fc7GrH
 9Ti3DUPZgIKzs/DMkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.100.70]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlLE9-1wCAxl0sO5-00lioj; Wed, 21
 Jan 2026 20:01:00 +0100
Date: Wed, 21 Jan 2026 20:00:30 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH v2 4/8] multifd: Add COLO support
Message-ID: <20260121200030.30e8537c@penguin>
In-Reply-To: <aW-31rQky14G8_lq@x1.local>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-4-ab521777fa51@web.de>
 <aW-31rQky14G8_lq@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kH4PwY4VCpdzS=R11cw/8r5";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:fGTe7sNzcEtFuInySgHIW9FnStXAGfvE5SsFvVEB2aBudYaKTSM
 UMr2fp5wybq44NeduP3PhWX9eGHIdKzBDxSFBD5QNKfxrkl2lv0bis0HSVptltgzPZ4I2Cr
 8hFYN/1P0Rq/DQjXyLPcWUXQcaftj0lmy8QokpN/4v/hPc0p2O06msRQqI58EVwI1IiUwbu
 o5+BJA5vDYDR5e8iKBNWw==
UI-OutboundReport: notjunk:1;M01:P0:XQ2YEyWGBeQ=;MEmej4IaVuECebh218p7SPpCCne
 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
 yeiO7Rpz8O47MtOTuzTz
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--Sig_/kH4PwY4VCpdzS=R11cw/8r5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jan 2026 12:13:58 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Sat, Jan 17, 2026 at 03:09:11PM +0100, Lukas Straub wrote:
> > Like in the normal ram_load() path, put the received pages into the
> > colo cache and mark the pages in the bitmap so that they will be
> > flushed to the guest later.
> >=20
> > Multifd with COLO is useful to reduce the VM pause time during checkpoi=
nting
> > for latency sensitive workloads. In such workloads the worst-case laten=
cy
> > is especially important.
> >=20
> > Also, multifd migration is the preferred way to do migration nowadays a=
nd this
> > allows to use multifd compression with COLO.
> >=20
> > Benchmark:
> > Cluster nodes
> >  - Intel Xenon E5-2630 v3
> >  - 48Gb RAM
> >  - 10G Ethernet
> > Guest
> >  - Windows Server 2016
> >  - 6Gb RAM
> >  - 4 cores
> > Workload
> >  - Upload a file to the guest with SMB to simulate moderate
> >    memory dirtying
> >  - Measure the memory transfer time portion of each checkpoint
> >  - 600ms COLO checkpoint interval
> >=20
> > Results
> > Plain
> >  idle mean: 4.50ms 99per: 10.33ms
> >  load mean: 24.30ms 99per: 78.05ms
> > Multifd-4
> >  idle mean: 6.48ms 99per: 10.41ms
> >  load mean: 14.12ms 99per: 31.27ms =20
>=20
> Thanks for the numbers.  They're persuasive at least from 1st look.
>=20
> Said that, one major question is, multifd should only help with throughput
> when cpu is a bottleneck sending, in your case it's 10Gbps NIC.  Normally
> any decent cpu should be able to push closer to 10Gbps even without
> multifd.
>=20
> Per my previous experiences, multifd can only show a difference when the
> hosts have at least 25GBps+ bandwidth available.
>=20
> Maybe you turned on compression already?  If so, worth stating the
> compressor methods chosen / parameters.

No, it's just the old Haswell CPU I guess. My clients also use it on
embedded platforms with embedded/mobile CPUs, so not necessarily the
fastest CPUs.

Btw, I forgot to mention, it's already worth it for the precopy phase
as it helps with converging. And also for my other patch that sends
dirty ram in the time between the checkpoints.

>=20
> >=20
> > Evaluation
> > While multifd has slightly higher latency when the guest idles, it is
> > 10ms faster under load and more importantly it's worst case latency is
> > less than 1/2 of plain under load as can be seen in the 99. Percentile.
> >=20
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  MAINTAINERS              |  1 +
> >  migration/meson.build    |  2 +-
> >  migration/multifd-colo.c | 49 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  migration/multifd-colo.h | 26 +++++++++++++++++++++++++
> >  migration/multifd.c      | 12 ++++++++++++
> >  migration/multifd.h      |  1 +
> >  6 files changed, 90 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 563804345fec68ee72793dbb7c1b7e5be4c32083..dbb217255c2cf35dc0ce971=
c2021b130fac5469b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3837,6 +3837,7 @@ COLO Framework
> >  M: Lukas Straub <lukasstraub2@web.de>
> >  S: Maintained
> >  F: migration/colo*
> > +F: migration/multifd-colo.*
> >  F: include/migration/colo.h
> >  F: include/migration/failover.h
> >  F: docs/COLO-FT.txt
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
> > index 0000000000000000000000000000000000000000..d8d98e79b12ed52c41f3410=
52a682d7786e221b5
> > --- /dev/null
> > +++ b/migration/multifd-colo.c
> > @@ -0,0 +1,49 @@
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
> I should have mentioned it while reviewing the previous version, anyway..
>=20
> IMHO it would be better to have one place setting p->host instead of
> overwritting it.
>=20
> So instead of hooking before ->recv(), we should do it in
> multifd_ram_unfill_packet(), moving the p->host update to the end of
> function and hook it there with COLO (so that you can still record the
> bitmaps, only after normal[]).

Okay, will fix that in the next version.

>=20
> Another thing, which might be more important: you seem to have ignored
> zero[], but I think you need it.  zero[] keeps all pages that are zeros
> (which may not used to be zeros).  So IMHO you'll need to record them as
> dirty too in COLO's dest bitmap, otherwise you may hit hard to debug RAM
> corruptions.

Yes, that is a good catch. I missed that during forward porting.

>=20
> > +}
> > +
> > +void multifd_colo_process_recv(MultiFDRecvParams *p)
> > +{
> > +    if (!migration_incoming_in_colo_state()) {
> > +        for (int i =3D 0; i < p->normal_num; i++) {
> > +            void *guest =3D p->block->host + p->normal[i];
> > +            void *cache =3D p->host + p->normal[i];
> > +            memcpy(guest, cache, multifd_ram_page_size());
> > +        }
> > +    }
> > +    p->host =3D p->block->host; =20
>=20
> Is resetting the pointer required?  If not, we can skip it.

Not that I can see, i will remove this in the next version.

>=20
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
> > index 8e71171fb7a17726ba7eb0705e293c41e8aa32ec..6c85acec3bac134e85cfcee=
0d32057134f5af8d1 100644
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
> > @@ -1269,7 +1270,18 @@ static int multifd_ram_state_recv(MultiFDRecvPar=
ams *p, Error **errp)
> >  {
> >      int ret;
> > =20
> > +    if (migrate_colo()) {
> > +        multifd_colo_prepare_recv(p);
> > +    }
> > +
> >      ret =3D multifd_recv_state->ops->recv(p, errp);
> > +    if (ret !=3D 0) {
> > +        return ret;
> > +    }
> > +
> > +    if (migrate_colo()) {
> > +        multifd_colo_process_recv(p);
> > +    }
> > =20
> >      return ret;
> >  }
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index 9b6d81e7ede024f05d4cd235de95e73840d0bbc4..7036f438fade1baed2442bf=
dcf8b5d6397c4a448 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -280,6 +280,7 @@ typedef struct {
> >      /* ramblock */
> >      RAMBlock *block;
> >      /* ramblock host address */
> > +    /* or points to the corresponding address in the colo cache */ =20
>=20
> Nit: we can merge it with /* ... */, and some wording change:
>=20
>        /*
>         * Normally, it points to ramblock's host address.  When COLO
>         * enabled, it points to the mirror cache for the ramblock.
>         */

Okay, will fix this.

>=20
> >      uint8_t *host;
> >      /* buffers to recv */
> >      struct iovec *iov;
> >=20
> > --=20
> > 2.39.5
> >  =20
>=20


--Sig_/kH4PwY4VCpdzS=R11cw/8r5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmlxIk4ACgkQNasLKJxd
sljsRxAAnTTPZAroOVEBQ6ize3cFmcUOPN/kvCVkGOGOxG4+Y0bRTGvcqdP1QCRo
L+Fcz+N3RaAgPmFhYTCZqs5Unt4/CmLL9h7SYPSWNLKyipVkv3mrHzws8I/U4Ulr
stzalAyaIGWE/TPwQHQGoaKiJX8PGg6l6Uc7yUlcUThZch74/m7mxfAUISVGdfxu
HVwH+7eDHB+9r4P5pKRxQYkxuxnxutLdt6uCKAyJ2pZQrlT7Dg9c6aCTEnSCqBUH
pteOYO8lkpR0LUrZwi3OY6OATp63qhqVjhEZID2urFN6d6Ok/+x+O1AtyriXKWEz
S/Nf6+JNj8jJ3BsEo0Uqln3xmw4+s+89q3EnDAow2+thXCYN2gYpi3JrY3H2Fiz0
q/0buQP9dUuJaCDgfWRzj/hrbbjp/Su4l0z3UrNxF5EOFlFjLb2mVpBGJs1rty1a
0A33UO9Bbq7EgD8v6HWEijBeGNxWQGUdVm39lmeGXSc0FK/LxkP+YgfekAD+CyJC
vWTO2z7mXlg5BayeyqgWIU6ZIoY5m/WpM2gv8Uio36zTf4TJifDyTwi5eOASjIh2
HliJPI7vZwJC1UO8VYiW7llLZGs09JAO4twV0Uxwz1+CFBSOYhUSBg4BJokqJQE5
xJVMMUN5WUO8SHJ3ZRxaM54iDt4wBiR02y130YV//nQ9zwL8+N8=
=t6Xp
-----END PGP SIGNATURE-----

--Sig_/kH4PwY4VCpdzS=R11cw/8r5--

