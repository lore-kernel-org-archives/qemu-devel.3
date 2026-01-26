Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3C9D19517
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 19:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkSLx-0000Eu-5V; Mon, 26 Jan 2026 14:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vkSLt-0000EP-HB
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:34:21 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vkSLp-0004Xf-Qo
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769456051; x=1770060851; i=lukasstraub2@web.de;
 bh=HRyhMKXpyo8WJgj79j4EL1ie0/ZBtt30CpAZCb0Nz8o=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BM+SpUJxuUybIG/V3/d4dbteRWZ9lr458WqcprlDrPaHJWQ75yws42WjjWq7qIU6
 eSuq0H+sxjzkpxwNkC1kCrXf+KYD1Z8EyH1l06P1xhpqyTBj+/jupZADWlY8T09wb
 Px/b15VucUhFwgg9J+xgZqo0tRbpsc/FyVh2LG+g82oMXq/ymsMNXxs91IeA5j33Q
 5MC7pPd36ejUHjRcv/N/4Xt8uHWCKtCxM/Ibju9XV1IKt/ZMf/CQYQcnWZ+odrcUI
 Xw9FSnKX17i6NBVPINd1taQkfGFdejYmWfbTHISKuIQH65+TEIuSUAXj8RMuqCv0X
 60ggnp1rKGCqwpmkXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.97.172]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4N9I-1vrRLB0d1C-00smRh; Mon, 26
 Jan 2026 20:34:11 +0100
Date: Mon, 26 Jan 2026 20:33:58 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>, Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH v3 04/10] multifd: Add COLO support
Message-ID: <20260126203358.0f8dc224@penguin>
In-Reply-To: <87ms20h2ae.fsf@suse.de>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-4-ae926ccd8eae@web.de>
 <87ms20h2ae.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8lJ_zlz5GtApj8jjLGsFYK7";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:5LaL7WHRiebxWniMrg4VYiWQd494YTa7VaM5PnABZmKOE5c5lhK
 cdpRW4JSe8KkwxoV7WN/765kmMO0X+V3edA0PAkJmMS30x6wEmth2suskH3U7VNGgt1VF+z
 +6O5dkQTmIUSB6VeNWJdPyFQqjazv0/+xEqx8ZuTT5J8FkJ8QG8jUMFWAD8tip0rXlw8vsO
 ORgcMyStydDpC+7WLRcUA==
UI-OutboundReport: notjunk:1;M01:P0:pjVmPqlVrxc=;6ssXtPPOhJHiO9N9yiSAyuxoi7K
 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
 W3fKec+/AHM
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

--Sig_/8lJ_zlz5GtApj8jjLGsFYK7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Jan 2026 11:33:13 -0300
Fabiano Rosas <farosas@suse.de> wrote:

> Lukas Straub <lukasstraub2@web.de> writes:
>=20
> > Like in the normal ram_load() path, put the received pages into the
> > colo cache and mark the pages in the bitmap so that they will be
> > flushed to the guest later.
> > =20
>=20
>=20
>=20
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
> >
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
> > =20
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
> > +    if (migration_incoming_in_colo_state()) { =20
>=20
> What's the relationship between migration_incoming_in_colo_state() and
> migration_incoming_colo_enabled()? ram_load_precopy() checks both. Would
> migration_incoming_colo_enabled affect multifd as well?

So first off migration_incoming_colo_enabled() and migrate_colo()
are equivalent in practice since
121ccedc2b migration: block incoming colo when capability is disabled

(I have some cleanup patches lying around, but that will be for later)

For colo, we do normal precopy migration and at the end we go into colo
state and then
migration_incoming_in_colo_state() will be true.

Here we check migrate_colo() outside of these functions as Peter
requested that in a previous version.

>=20
> The multifd recv threads will be running until after
> process_incoming_migration_bh(), which is when
> migration_incoming_disable_colo() runs.

That is not an issue as we use migrate_colo() here.

>=20
> Also, is the colo_cache guaranteed to be around until multifd threads
> exit?

This is an issue. I will fix it in the next version.

>
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
> > +        } =20
>=20
> I see some differences between what ram.c does and what multifd will do
> after this patch regarding which flags are checked and order of copies
> (code below):
>=20
> ram.c:
>=20
>   - migration_incoming_colo_enabled && migration_incoming_in_colo_state:
>   Reads from stream into colo_cache.
>  =20
>   - migration_incoming_colo_enabled && !migration_incoming_in_colo_state:
>   Reads from stream into guest and then memcpy into colo_cache.
>=20
>   - !migration_incoming_colo_enabled
>   Reads from stream into guest.
>=20
> multifd.c:
>=20
>   - migrate_colo:
>   Reads from stream into colo_cache.
>  =20
>   - !migration_incoming_in_colo_state:
>   memcpy from colo_cache into guest.
>=20
>   - !migration_incoming_colo_enabled
>   ???
>=20
> The resulting state should be the same, but I wonder if we want to i) use
> the same checks in multifd

migration_incoming_colo_enabled() shouldn't even exist anymore, so I'm
not using it here. migrate_colo() is much easier to reason about.

> and ii) when not in colo state, copy first
> into guest (using readv) and later memcpy into the colo_cache.

I think it is easier the way it is now.

>=20
> ---
> ram.c:
>=20
> host =3D host_from_ram_block_offset(block, addr);
> if (migration_incoming_colo_enabled()) {
>     if (migration_incoming_in_colo_state()) {
>         host =3D colo_cache_from_block_offset(block, addr, true);
>     } else {
>         host_bak =3D colo_cache_from_block_offset(block, addr, false);
>     }
> }
> qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
> if (host_bak) {
>     memcpy(host_bak, host, TARGET_PAGE_SIZE);
> }
>=20
> multifd:
>=20
> if (migrate_colo()) {
>     p->host =3D p->block->colo_cache;
> }
>=20
> for (int i =3D 0; i < p->normal_num; i++) {
>     p->iov[i].iov_base =3D p->host + p->normal[i];
> }
> return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
>=20
> if (!migration_incoming_in_colo_state()) {
>     for (int i =3D 0; i < p->normal_num; i++) {
>         void *guest =3D p->block->host + p->normal[i];
>         void *cache =3D p->host + p->normal[i];
>         memcpy(guest, cache, multifd_ram_page_size());
>     }
> }
> ---
>=20
> > +        for (int i =3D 0; i < p->zero_num; i++) {
> > +            void *guest =3D p->block->host + p->zero[i];
> > +            memset(guest, 0, multifd_ram_page_size());
> > +        } =20
>=20
> At multifd_nocomp_recv, there will be a call to
> multifd_recv_zero_page_process(), which by that point will have p->host
> =3D=3D p->block->colo_cache, so it looks like that function will do some
> zero page processing in the colo_cache, setting the rb->receivedmap for
> pages in the colo_cache and potentially also doing a memcpy. Is this
> intended?

rb->receivedmap is only for postcopy, right? So it doesn't apply with
colo.

>=20
> I'm thinking that maybe it would overall be better to hook colo directly
> in to multifd_nocomp_recv:

But then it will only work for nocomp, right? It feels like the wrong
level of abstraction to me.

>=20
> static int multifd_nocomp_recv(MultiFDRecvParams *p, Error **errp)
> {
>     uint32_t flags;
>=20
>     if (migrate_mapped_ram()) {
>         return multifd_file_recv_data(p, errp);
>     }
>=20
>     flags =3D p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
>=20
>     if (flags !=3D MULTIFD_FLAG_NOCOMP) {
>         error_setg(errp, "multifd %u: flags received %x flags expected %x=
",
>                    p->id, flags, MULTIFD_FLAG_NOCOMP);
>         return -1;
>     }
>=20
> +    if (migration_incoming_colo_enabled() && migration_incoming_in_colo_=
state()) {
> +        p->host =3D p->block->colo_cache;
> +    } // or else{}, depending on how deal with zero pages in the cache
>=20
>     multifd_recv_zero_page_process(p);
>=20
>     if (!p->normal_num) {
>         return 0;
>     }
>=20
>     for (int i =3D 0; i < p->normal_num; i++) {
>         p->iov[i].iov_base =3D p->host + p->normal[i];
>         p->iov[i].iov_len =3D multifd_ram_page_size();
>         ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
>     }
> +    ret =3D qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
> +    if (ret !=3D 0) {
> +        return ret;
> +    }
> +
> +    if (migration_incoming_colo_enabled()) {
> +        multifd_colo_process_recv();
> +    }
>=20
>     return ret;
> }
>=20
>=20
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
> > =20
> > -    p->host =3D p->block->host;
> >      for (i =3D 0; i < p->normal_num; i++) {
> >          uint64_t offset =3D be64_to_cpu(packet->offset[i]);
> > =20
> > @@ -294,6 +294,14 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p=
, Error **errp)
> >          p->zero[i] =3D offset;
> >      }
> > =20
> > +    if (migrate_colo()) {
> > +        multifd_colo_prepare_recv(p);
> > +        assert(p->block->colo_cache);
> > +        p->host =3D p->block->colo_cache; =20
>=20
> Can't you just use p->block->colo_cache later? I don't see why p->host
> needs to be set beforehand even in the non-colo case.

We should not touch the guest ram directly while in colo state, since
the incoming guest is running and we either want to receive and apply a
whole checkpoint with all ram into colo cache and all device state,
or if anything goes wrong during checkpointing, keep the currently
running guest on the incoming side in pristine state.

I have written more about colo migration here:

https://lore.kernel.org/qemu-devel/20260117204913.584e1829@penguin/
https://lore.kernel.org/qemu-devel/aXE1i9xJ81EWokYz@x1.local/

>=20
> > +    } else {
> > +        p->host =3D p->block->host;
> > +    }
> > +
> >      return 0;
> >  }
> > =20
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
> > =20
> >      ret =3D multifd_recv_state->ops->recv(p, errp);
> > +    if (ret !=3D 0) {
> > +        return ret;
> > +    }
> > +
> > +    if (migrate_colo()) {
> > +        multifd_colo_process_recv(p);
> > +    } =20
>=20
> Either put all of colo hooks in multifd.c or multifd-nocomp.c. I think
> the latter is more appropriate as we have mapped_ram already in
> there. Let's drop patch 3 and put this in multifd_nocomp_recv().

Again, it also should work with compression and multifd_nocomp_recv()
is for nocomp only.

>=20
> > =20
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
> >      struct iovec *iov; =20


--Sig_/8lJ_zlz5GtApj8jjLGsFYK7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAml3waYACgkQNasLKJxd
slgo+BAAsw9qw+2wzHlR4MNWH/azvlhLuak7dax2f9FMERMfXMjZGItVc86McktC
FyJy5QdInrfBfiB5lLqeDq2NbURbYR+N6U/WlOa3yfaSN39yh4th7xN8XESg8uo8
78li+6QdYnaxunt6zQO9beVhhju30Nxah2UyQf1LfdEXYEp3zskuMyO5yzBsCZlZ
vMnBXsEGzkljvC+VYBXSxXkwVrsHcn75AQ1NkSwkCmNgxIMotGAvImHWvlaOxhkp
cLqxvCY26RRgxw96+ot5Qe5PgcRBcgNQfqQdQs+xwr+ylD+tMphPAGGDDBBSJHkb
IJCHGKUxhtSSz/9ZlnUsuLVwam0vzKPcw8HIotJYQjXuZDiF6aa8WmiN2vueL6bu
cCBBkfqMmzmJ9pNMUAABc91XXvwqmpozn3YWPLucFDSqRgWmrlqE5wd74ZBTTJXe
0gxw23JiKywujgA7aABSHDB0/9trNgHjO0FxZtuPO1dejSsU1k8y27yhx1dy5xeu
Akw3Pw2dlxZD3WMVYMVrQRRMoCQ3FLVlqjTrv0WwSQrFH+RlpF+wiY8qvzYwMYCH
BWW/PRtJPKdWJ5s0HuKWgKhmatQjI/oLFvKi3j+4VrvE3RuwRMr8vwyo5Pv7OmTx
7J5ooXGaSngnQsTdVMBbnt4S8ElGHr0LFzyVYzdRrd4OrSxBKLY=
=vIz/
-----END PGP SIGNATURE-----

--Sig_/8lJ_zlz5GtApj8jjLGsFYK7--

