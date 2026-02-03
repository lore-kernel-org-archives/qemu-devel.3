Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01AEE8306B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 09:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnD1Z-00040n-SE; Tue, 03 Feb 2026 04:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnD1W-0003zA-30
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 04:48:42 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnD1T-0007EB-SY
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 04:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770112104; x=1770716904; i=lukasstraub2@web.de;
 bh=OJ0j3Wq3kMbkQOF0J4n8LG+9C18vagFA9q42yt4ILp0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=vCyA5t96XnBAQ3Ra9GvbSvEVc4SrGz+4Wn27ej939RBQ28FZmWFZvq6DIQeMfrAH
 bPbi8C/UpmUOd2xHN3hljfz+mdBRIy4cm/91UffxfFpLdL1yRNpngSvEoeYyrwcXo
 mhLjeC7GcVfCll4Xq+eWXuNvHqWLsc8kX22wLbBh5WwAX3iTK4dNIJZmPKOLfmhT2
 Yfd8KZoMZlhMG3eoWtBpmfqPHq1LmZyn/DegyYANnzdWhg3vjLTVu9Py2UgBbdvSd
 3E5xJQvQwA0xGzZGLhT0Nmjqts5J+IjaX3XdjKh1THXbPX/Y46PEKzwzFlB9QQ5oL
 WzIq2AmU3xGbc8PmEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.97.172]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1LsV-1vgiyh1koV-00zVii; Tue, 03
 Feb 2026 10:48:24 +0100
Date: Tue, 3 Feb 2026 10:47:54 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>, Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH v3 04/10] multifd: Add COLO support
Message-ID: <20260203104754.17e7baf6@penguin>
In-Reply-To: <87v7glgbrz.fsf@suse.de>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-4-ae926ccd8eae@web.de>
 <87ms20h2ae.fsf@suse.de> <20260126203358.0f8dc224@penguin>
 <878qdkgin8.fsf@suse.de> <aXkh0Sy9WUqi_3Rr@x1.local>
 <87v7glgbrz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tNlFYpWPj8dL5eo1xxquh/P";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:4yB3a6+u63obpghoSgbtKQiEzTzo0ne/zWmqBPv/zJjoQFqqNBP
 E6w8dKVk2xqfIIX4OluSj6xOO2Wb4aswKDwFxlZUK/iQojZUYekNNTkg4y1mEUkmrG3qKZH
 lKqGt6wRrVYkw2Rqy+HrEYrG/D0jmxUf47XOr+oFXHdEb8Suf3VKT02NoXJYwxqPqs/RIX/
 s5G2rQ8bqqzwiaSdTRl3w==
UI-OutboundReport: notjunk:1;M01:P0:BDEiPl3BmD4=;D6DdB5yw433vx/GD9aKqLkxRr6W
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

--Sig_/tNlFYpWPj8dL5eo1xxquh/P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Jan 2026 09:30:24 -0300
Fabiano Rosas <farosas@suse.de> wrote:

> Peter Xu <peterx@redhat.com> writes:
>=20
> > On Mon, Jan 26, 2026 at 06:37:31PM -0300, Fabiano Rosas wrote: =20
> >> Lukas Straub <lukasstraub2@web.de> writes:
> >>  =20
> >> >> [...]
> >> >>  =20
> >> >> > +        for (int i =3D 0; i < p->zero_num; i++) {
> >> >> > +            void *guest =3D p->block->host + p->zero[i];
> >> >> > +            memset(guest, 0, multifd_ram_page_size());
> >> >> > +        }   =20
> >> >>=20
> >> >> At multifd_nocomp_recv, there will be a call to
> >> >> multifd_recv_zero_page_process(), which by that point will have p->=
host
> >> >> =3D=3D p->block->colo_cache, so it looks like that function will do=
 some
> >> >> zero page processing in the colo_cache, setting the rb->receivedmap=
 for
> >> >> pages in the colo_cache and potentially also doing a memcpy. Is this
> >> >> intended? =20
> >> >
> >> > rb->receivedmap is only for postcopy, right? So it doesn't apply with
> >> > colo.
> >> > =20
> >>=20
> >> It's not anymore since commit 5ef7e26bdb ("migration/multifd: solve ze=
ro
> >> page causing multiple page faults"). So it seems we might be doing ext=
ra
> >> work on top of the colo_cache. =20
> >
> > IIUC not extra, but exactly what will be needed.
> >
> > The logic was about "in a vanilla precopy, if we see one page arriving =
the
> > 1st time we don't need to zero the buffer because the buffer should be =
zero
> > allocated".
> >
> > In COLO's case, COLO always puts RAM data into colo_cache, hence it sho=
uld
> > apply to colo_cache too, avoiding unnecessary memset() for colo_cache
> > instead.
> >
> > E.g. colo_cache is allocated from qemu_anon_ram_alloc(), it's also
> > guaranteed to be zeros when never touched.
> > =20
> >>  =20
> >> >>=20
> >> >> I'm thinking that maybe it would overall be better to hook colo dir=
ectly
> >> >> in to multifd_nocomp_recv: =20
> >> >
> >> > But then it will only work for nocomp, right? It feels like the wrong
> >> > level of abstraction to me.
> >> > =20
> >>=20
> >> Ah, nocomp !=3D ram indeed.
> >>  =20
> >> >>=20
> >> >> > [...]
> >> >> > diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocom=
p.c
> >> >> > index 9be79b3b8e00371ebff9e112766c225bec260bf7..9f7a792fa761b3bc3=
0b971b35f464103a61787f0 100644
> >> >> > --- a/migration/multifd-nocomp.c
> >> >> > +++ b/migration/multifd-nocomp.c
> >> >> > @@ -16,6 +16,7 @@
> >> >> >  #include "file.h"
> >> >> >  #include "migration-stats.h"
> >> >> >  #include "multifd.h"
> >> >> > +#include "multifd-colo.h"
> >> >> >  #include "options.h"
> >> >> >  #include "migration.h"
> >> >> >  #include "qapi/error.h"
> >> >> > @@ -269,7 +270,6 @@ int multifd_ram_unfill_packet(MultiFDRecvPara=
ms *p, Error **errp)
> >> >> >          return -1;
> >> >> >      }
> >> >> > =20
> >> >> > -    p->host =3D p->block->host;
> >> >> >      for (i =3D 0; i < p->normal_num; i++) {
> >> >> >          uint64_t offset =3D be64_to_cpu(packet->offset[i]);
> >> >> > =20
> >> >> > @@ -294,6 +294,14 @@ int multifd_ram_unfill_packet(MultiFDRecvPar=
ams *p, Error **errp)
> >> >> >          p->zero[i] =3D offset;
> >> >> >      }
> >> >> > =20
> >> >> > +    if (migrate_colo()) {
> >> >> > +        multifd_colo_prepare_recv(p);
> >> >> > +        assert(p->block->colo_cache);
> >> >> > +        p->host =3D p->block->colo_cache;   =20
> >> >>=20
> >> >> Can't you just use p->block->colo_cache later? I don't see why p->h=
ost
> >> >> needs to be set beforehand even in the non-colo case. =20
> >> >
> >> > We should not touch the guest ram directly while in colo state, since
> >> > the incoming guest is running and we either want to receive and appl=
y a
> >> > whole checkpoint with all ram into colo cache and all device state,
> >> > or if anything goes wrong during checkpointing, keep the currently
> >> > running guest on the incoming side in pristine state.
> >> > =20
> >>=20
> >> I was asking about setting p->host at this specific point. I don't thi=
nk
> >> any of this fits the unfill function. However, I see those were
> >> suggested by Peter so let's not go back and forth. =20
> >
> > Actually I don't know why p->host existed before this work; IIUC we cou=
ld
> > have always used p->block->host.  Maybe when Juan was developing this J=
uan
> > kept COLO in mind; or maybe Juan wanted to avoid frequent p->block poin=
ter
> > reference.
> > =20
>=20
> Maybe p->block was being reset at some point and p->host was passed
> being the point where the (whatever) lock was release. I checked and
> today there's no such thing. The p->mutex seems to be there just to
> protect against this in multifd_recv_sync_main:
>=20
> WITH_QEMU_LOCK_GUARD(&p->mutex) {
>     if (multifd_recv_state->packet_num < p->packet_num) {
>         multifd_recv_state->packet_num =3D p->packet_num;
>     }
> }
>=20
> > IIUC, we could remove p->host, but when we need to access "the buffer of
> > the ramblock" we'll need to call a helper to fetch that (either rambloc=
k's
> > buffer, or colo_cache, per migrate_colo()).  And it might be slightly
> > slower than p->host indeed.
> > =20
>=20
> Yeah, let's keep it, the compression code also uses it, there's no point
> removing it now.
>=20

Actually p->host was there first p->block was added later for COLO in
5d1d1fcf4 multifd: Add the ramblock to MultiFDRecvParams

--Sig_/tNlFYpWPj8dL5eo1xxquh/P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmBxEoACgkQNasLKJxd
sljXfQ/9FblXbs8nur/lSQ0yqRotbEtnOZqyswtgJRkz0O3/P7ebhBi1+B4I0gjj
Tuhl23Jb8RYsnBan3R3qSNxvUrnX6IoQIw0hrygcLPWuyBhTWs+ZhBl8rnwiDwOy
SWVqU0TiBcnXqGa6jnMZK4xnYZ6BPsT2DOs9k1BcpEPmFavIme3VSS5ReBv9iJ1I
18Pa0JOjfyRJRGGUTUii5uhyPBGNwz66Ztm1EtJ/9MCgpCr65s5gInjSmk+4I5hc
Uen7VZZtT1lhvLEPlVnfYXHGp/MYkcJbwaaiFBemEyhxW3qmER++JH+uKPEim3Ok
+B0iKenfseoyjdfRrOr95GhozV1105ZpfKAZAy7bPMk+BmxRSta0KeRaqzwtxES+
w4o+5PyQ1leod1fTfCD5ZAJUprdavwazAUbMeMiZYEIrl1ILK3sxpB3oSRkEDl8I
Uj6fHzUBDegVzAsb5YjwvSid7rutBKpvPpaHugfwPjf27LB1wTlPJoAPEtP6gvHN
QKXuU+48hJW8Dt4A62Xz3zBakP2mUhOXeGGCGtCZM6Lt6y19AQ/QTKMNXQhWcxdZ
sLvfOAK//uAmkct1BEuWf4ZVCfVi1mrEHlcXO83vrwjgzKvm/sQULZoLtjPJXTmq
7sH+bZ6L4VdRjk99w7kj+/ISrzBVeD1aSmJtbulJYs5Zuikeu3s=
=7pCp
-----END PGP SIGNATURE-----

--Sig_/tNlFYpWPj8dL5eo1xxquh/P--

