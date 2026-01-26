Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF044CF65DF
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 11:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkKXz-00065I-7D; Mon, 26 Jan 2026 06:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vkKXt-00063u-PV
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 06:14:13 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vkKXq-00010Q-7E
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 06:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769426045; x=1770030845; i=lukasstraub2@web.de;
 bh=qUbqs1gB4yi2EtO1SyD9m3Naf+QbVO4KFO9g5bTBzDs=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ca4gFIFOVrrcmtwALoKw33vPla168jhv1qAzdj2vumxrYqApbGsQXDMxWu6woMd9
 A8oNl6ysmNxMMpSI3UlDuIjkgefkOJqGEdGSmSaUe+yQmdR6yv2TrAKCrjkjKZ9ig
 zYAUJRSKDquEVVp6doc7Eer2lP/mPsFllYCzqRm76hwA2M4OesTyA9I9ebMgojlY8
 SKG2h2WAgKxLahMT8JD8rEeQIZEDCLFVJYvmL82NM2c+2jDcXK8dUyNxd0QusprTF
 450mpKfmvnIm3XlMQNvgzZs3PFXrcPYGJPq1f3Kgvnnsu0mxNv3gjF+TZygWH5s33
 uAHrjZkUC7sIS4eA+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.97.172]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRF3I-1vNAwy3YOK-00QPgo; Mon, 26
 Jan 2026 12:14:04 +0100
Date: Mon, 26 Jan 2026 12:13:36 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>, Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH v3 04/10] multifd: Add COLO support
Message-ID: <20260126121336.4a5a7ec9@penguin>
In-Reply-To: <CAK3tnv+uzkmetL443GW3KZPkH9UoVCeqLLtZCND1P02qi==CPg@mail.gmail.com>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-4-ae926ccd8eae@web.de>
 <CAK3tnv+uzkmetL443GW3KZPkH9UoVCeqLLtZCND1P02qi==CPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xkp0uOzZve4YxooKCi=PI+i";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:zSgKFSwvjl2io5Z/UdYy1beE9Ugjv068lhkI5wjbjd9Heri/v5W
 oYilyC0seRUcIgYdpo8HoXzyIuedSs1W9v+LdtNLRTLVkJjQ523klsxyo2rVnPuC3gNEEVj
 SyOfCUQvg/bNTLwwXyfyD74O4Eq7IH0hlsJUIGmBzgOKp6dV7kRYaGLlwGgcfSVmZ9k1owL
 HGEmXO6HXMG5fGO+4X5kA==
UI-OutboundReport: notjunk:1;M01:P0:laIQWpDhCq8=;ZUFNuh3dxmL4KVA+egeXPp7OHjQ
 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
 Sl3+zb/oMepFCSEA6Gl7
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

--Sig_/xkp0uOzZve4YxooKCi=PI+i
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Jan 2026 18:36:39 +0800
Zhang Chen <zhangckid@gmail.com> wrote:

> On Mon, Jan 26, 2026 at 4:40=E2=80=AFAM Lukas Straub <lukasstraub2@web.de=
> wrote:
> >
> > Like in the normal ram_load() path, put the received pages into the
> > colo cache and mark the pages in the bitmap so that they will be
> > flushed to the guest later.
> >
> > Multifd with COLO is useful to reduce the VM pause time during checkpoi=
nting
> > for latency sensitive workloads. In such workloads the worst-case laten=
cy
> > is especially important.
> >
> > Also, this is already worth it for the precopy phase as it helps with
> > converging. Moreover, multifd migration is the preferred way to do migr=
ation
> > nowadays and this allows to use multifd compression with COLO.
> >
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
> >
> > Results
> > Plain
> >  idle mean: 4.50ms 99per: 10.33ms
> >  load mean: 24.30ms 99per: 78.05ms
> > Multifd-4
> >  idle mean: 6.48ms 99per: 10.41ms
> >  load mean: 14.12ms 99per: 31.27ms
> >
> > Evaluation
> > While multifd has slightly higher latency when the guest idles, it is
> > 10ms faster under load and more importantly it's worst case latency is
> > less than 1/2 of plain under load as can be seen in the 99. Percentile.
> > =20
>=20
> Why the multifd get higher latency when the guest idles?  The status same
> with normal live migration? Where is the time spent? The Sorry, I
> don't know this background yet.

Not sure, it could be more overhead due to coordinating the multifd
threads.

But it also can be explained from the sample variation. Here I also
calculate the standard deviation of the sample.
60% of samples are within +- one stddev.

plain idle: mean 4.50 99per 10.33 stddev 1.80
plain load: mean 24.30 99per 78.05 stddev 13.65
multifd-4 idle: mean 6.48 99per 10.41 stddev 2.53
multifd-4 load: mean 14.12 99per 31.27 stddev 7.48

So, I don't think its a significant difference.

>=20
> Thanks
> Chen
>=20
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  MAINTAINERS                |  1 +
> >  migration/meson.build      |  2 +-
> >  migration/multifd-colo.c   | 50 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  migration/multifd-colo.h   | 26 ++++++++++++++++++++++++
> >  migration/multifd-nocomp.c | 10 +++++++++-
> >  migration/multifd.c        |  8 ++++++++
> >  migration/multifd.h        |  5 ++++-
> >  7 files changed, 99 insertions(+), 3 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1e9bdd87c3a2f84f3abfc56986cd793976810fdd..883f0a8f4eb92d0bf0f89fc=
ab4674ccc4aed1cc1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3853,6 +3853,7 @@ COLO Framework
> >  M: Lukas Straub <lukasstraub2@web.de>
> >  S: Maintained
> >  F: migration/colo*
> > +F: migration/multifd-colo.*
> >  F: include/migration/colo.h
> >  F: include/migration/failover.h
> >  F: docs/COLO-FT.txt
> > diff --git a/migration/meson.build b/migration/meson.build
> > index c7f39bdb55239ecb0e775c77b90a1aa9e6a4a9ce..c9f0f5f9f2137536497e53e=
960ce70654ad1b394 100644
> > --- a/migration/meson.build
> > +++ b/migration/meson.build
> > @@ -39,7 +39,7 @@ system_ss.add(files(
> >  ), gnutls, zlib)
> >
> >  if get_option('replication').allowed()
> > -  system_ss.add(files('colo-failover.c', 'colo.c'))
> > +  system_ss.add(files('colo-failover.c', 'colo.c', 'multifd-colo.c'))
> >  else
> >    system_ss.add(files('colo-stubs.c'))
> >  endif
> > diff --git a/migration/multifd-colo.c b/migration/multifd-colo.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..c47f5044663969e0c9af56d=
a5ec34902d635810a
> > --- /dev/null
> > +++ b/migration/multifd-colo.c
> > @@ -0,0 +1,50 @@
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
> > +    /*
> > +     * While we're still in precopy state (not yet in colo state), we =
copy
> > +     * received pages to both guest and cache. No need to set dirty bi=
ts,
> > +     * since guest and cache memory are in sync.
> > +     */
> > +    if (migration_incoming_in_colo_state()) {
> > +        colo_record_bitmap(p->block, p->normal, p->normal_num);
> > +        colo_record_bitmap(p->block, p->zero, p->zero_num);
> > +    }
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
> > +        for (int i =3D 0; i < p->zero_num; i++) {
> > +            void *guest =3D p->block->host + p->zero[i];
> > +            memset(guest, 0, multifd_ram_page_size());
> > +        }
> > +    }
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
> > diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> > index 9be79b3b8e00371ebff9e112766c225bec260bf7..9f7a792fa761b3bc30b971b=
35f464103a61787f0 100644
> > --- a/migration/multifd-nocomp.c
> > +++ b/migration/multifd-nocomp.c
> > @@ -16,6 +16,7 @@
> >  #include "file.h"
> >  #include "migration-stats.h"
> >  #include "multifd.h"
> > +#include "multifd-colo.h"
> >  #include "options.h"
> >  #include "migration.h"
> >  #include "qapi/error.h"
> > @@ -269,7 +270,6 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p,=
 Error **errp)
> >          return -1;
> >      }
> >
> > -    p->host =3D p->block->host;
> >      for (i =3D 0; i < p->normal_num; i++) {
> >          uint64_t offset =3D be64_to_cpu(packet->offset[i]);
> >
> > @@ -294,6 +294,14 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p=
, Error **errp)
> >          p->zero[i] =3D offset;
> >      }
> >
> > +    if (migrate_colo()) {
> > +        multifd_colo_prepare_recv(p);
> > +        assert(p->block->colo_cache);
> > +        p->host =3D p->block->colo_cache;
> > +    } else {
> > +        p->host =3D p->block->host;
> > +    }
> > +
> >      return 0;
> >  }
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 332e6fc58053462419f3171f6c320ac37648ef7b..220ed8564960fdabc58e4ba=
a069dd252c8ad293c 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -29,6 +29,7 @@
> >  #include "qemu-file.h"
> >  #include "trace.h"
> >  #include "multifd.h"
> > +#include "multifd-colo.h"
> >  #include "options.h"
> >  #include "qemu/yank.h"
> >  #include "io/channel-file.h"
> > @@ -1258,6 +1259,13 @@ static int multifd_ram_state_recv(MultiFDRecvPar=
ams *p, Error **errp)
> >      int ret;
> >
> >      ret =3D multifd_recv_state->ops->recv(p, errp);
> > +    if (ret !=3D 0) {
> > +        return ret;
> > +    }
> > +
> > +    if (migrate_colo()) {
> > +        multifd_colo_process_recv(p);
> > +    }
> >
> >      return ret;
> >  }
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index 89a395aef2b09a6762c45b5361e0ab63256feff6..fbc35702b062fdc3213ce92=
baed35994f5967c2b 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -279,7 +279,10 @@ typedef struct {
> >      uint64_t packets_recved;
> >      /* ramblock */
> >      RAMBlock *block;
> > -    /* ramblock host address */
> > +    /*
> > +     * Normally, it points to ramblock's host address.  When COLO
> > +     * is enabled, it points to the mirror cache for the ramblock.
> > +     */
> >      uint8_t *host;
> >      /* buffers to recv */
> >      struct iovec *iov;
> >
> > --
> > 2.39.5
> > =20


--Sig_/xkp0uOzZve4YxooKCi=PI+i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAml3TGAACgkQNasLKJxd
slh4dw/+LCgW3ATmb3nJ+ckeEQc2JEHmkQ8jx4Tp1LhNWLzY/vvGv4qpS34w9IZs
AzjuCsSUJ9fdWWpmbcg+ScIhlPwzKrbmrSeDxbkwsN0n0FQL8TBp9zCjpwsvWZpt
rhby7uPTRIfP5sgI5HOf9u9nzoaetyy1iQewowbTQynjTuVbjpPCjZHZtroeLkY5
idk6nhBKgtACqAe/9NbITwIoCFGm/PVWqwQ9GuEIjWA91WpXWibO56Y9fFowAR1A
9JHd3Wfgprd0eXDalJ9xUcM04wDVM4hQ5m6RGtzzFPu4m4qnj8zNshEdf6fkRbFS
a/qPMTDmthSvegrWy6Sn98CDjwf7XOGguE92b5QrikKTlsEK5QOQa1Yll80N+LgW
pQS0Y6MSUNqDJdATTVaqp4HxYuMeMPxcwahsSZC7Ay7OBD2Lj7o4spnr3xvxWfR1
quCOqHHPOkGF7zaqyNaCAIKsjesNoNOg66yE00890m2J0P3RRjCJzN1EiAd6oey6
IjqDW6BEMdXAy7A4D5QnLt7B/Zq62Fk/cWMw3tyE7bxiFNva3mGAlvBWjZhvp05V
jM4sdiZSSYWFPgfKkhpj0js2/6HA9DhuEvXNQ2qT/S+U8eF5wvkggSnC0bBdyFo5
YRR3folwg5KwVS1cw9jyVU93oBL5zgTkzGQRPnPIPtu9E3Oq+4g=
=ye3M
-----END PGP SIGNATURE-----

--Sig_/xkp0uOzZve4YxooKCi=PI+i--

