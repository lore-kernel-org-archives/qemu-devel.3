Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3812ECD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 15:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ5OF-0003Dv-58; Thu, 21 May 2026 11:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wQ5OD-0003CV-HO
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wQ5OB-0000vC-5o
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779377565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PQ+0TTr00gBP3CeVZqlZUIpy7FOgAIyl/08IRwZcLe0=;
 b=WTyy53wObUrYnuqBzgRt/1ThNshAXjvD6qqBPV2FoOlBkR3IDvHpna9xQszwrsbzh56tb+
 QEbSl9RMKXau1mzX/XPSbfBnN0WMjYFSuSm9oM0kF3SkxeaXC6y94ZXh3J/CsLeCiqYee7
 sy2BKfBdJgVlJvI3c9hlae8Bc3TOIq0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-Trm_OF5aOGmo22mjxTdQqw-1; Thu,
 21 May 2026 11:18:32 -0400
X-MC-Unique: Trm_OF5aOGmo22mjxTdQqw-1
X-Mimecast-MFC-AGG-ID: Trm_OF5aOGmo22mjxTdQqw_1779376711
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE100195396C; Thu, 21 May 2026 15:18:17 +0000 (UTC)
Received: from localhost (unknown [10.2.16.143])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA0493002D2D; Thu, 21 May 2026 15:18:16 +0000 (UTC)
Date: Thu, 21 May 2026 11:18:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: dlemoal@kernel.org, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v10 2/4] qcow2: add configurations for zoned format
 extension
Message-ID: <20260521151813.GE464582@fedora>
References: <20260510175059.311814-1-faithilikerun@gmail.com>
 <20260510175059.311814-3-faithilikerun@gmail.com>
 <20260514194906.GC1535937@fedora>
 <CAAAx-8K+12SGZqzpLGsxjsr6iGAHwQu-TUXe6Z6rtZA27OpjrQ@mail.gmail.com>
 <20260519154911.GB119642@fedora>
 <CAAAx-8Jooodx88LTJvVjHQYKj-SgkCxXkMTi1=ZdR3v3cpUvUg@mail.gmail.com>
 <20260520175905.GA384978@fedora>
 <CAAAx-8KMLBn1Fb1pMNHwsPsM2FKbJAhFFRFbjhvTvtbZ5FKfpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OQY6/m2SOw3YvsTT"
Content-Disposition: inline
In-Reply-To: <CAAAx-8KMLBn1Fb1pMNHwsPsM2FKbJAhFFRFbjhvTvtbZ5FKfpA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--OQY6/m2SOw3YvsTT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 08:23:41PM +0200, Sam Li wrote:
> On Wed, May 20, 2026 at 7:59=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Tue, May 19, 2026 at 11:20:18PM +0200, Sam Li wrote:
> > > On Tue, May 19, 2026 at 5:49=E2=80=AFPM Stefan Hajnoczi <stefanha@red=
hat.com> wrote:
> > > >
> > > > On Mon, May 18, 2026 at 12:21:55AM +0200, Sam Li wrote:
> > > > > On Thu, May 14, 2026 at 9:49=E2=80=AFPM Stefan Hajnoczi <stefanha=
@redhat.com> wrote:
> > > > > > On Sun, May 10, 2026 at 07:50:57PM +0200, Sam Li wrote:
> > > > > > > +         48 - 55:  zonedmeta_offset
> > > > > > > +                   The offset of zoned metadata structure in=
 the contained
> > > > > > > +                   image, in bytes.
> > > > > >
> > > > > > Do you want to say anything about the order in which metadata is
> > > > > > persisted to disk when zones used? I guess the data is written =
into the
> > > > > > image file first, then the non-zoned qcow2 L1/L2/refcount metad=
ata is
> > > > > > updated, and finally the write pointer is written. Write pointe=
rs are
> > > > > > not guaranteed to be updated on disk until the write request fo=
llowed by
> > > > > > a flush request are both completed.
> > > > >
> > > > > The current ordering is not like that. The write pointer is writt=
en
> > > > > persistently first, then the data writes and the non-zoned qcow2
> > > > > L1/L2/refcount metadata updates. On IO failure, the corresponding
> > > > > write pointer is re-read from disk. As noted in the previous comm=
ent,
> > > > > the wp must be updated when issuing the IO, under the assumption =
that
> > > > > the write IO will succeed.
> > > > >
> > > > > The ordering has been settled this way since v7 to deal with
> > > > > concurrent zone append writes. If the wp was only updated after d=
ata
> > > > > I/O, two concurrent appends would both have read the same wp and =
tried
> > > > > to write to the same position.
> > > > >
> > > > > >
> > > > > > (The idea is that the data must be visible in the qcow2 file be=
fore it
> > > > > > is safe to update the write pointer. Otherwise a power failure =
would
> > > > > > leave the file in an inconsistent state where the write pointer=
 has
> > > > > > advanced but the data was not written.)
> > > > >
> > > > > The crash-consistency is a concern...
> > > >
> > > > Yes, I'm thinking about crash-consistency. The ordering you describ=
ed
> > > > can result in qcow2 images where the write pointer is ahead of the
> > > > actually written data after a power failure or maybe a QEMU crash.
> > > >
> > > > QEMU's block layer must follow the same data integrity behavior that
> > > > real devices guarantee.
> > >
> > > I may have found a solution to deal with both cases. The fix is to
> > > update wp in memory instead of flushing it before qcow2 metadata and
> > > data writes. The zone append write path would become:
> > >
> > > On submission:
> > >
> > > 1) wp_lock()
> > > 2) Check write alignment
> > > 3) wp_update (in memory)
> > > 4) wp_unlock()
> > > 5) Issue write
> > >
> > > And on completion:
> > > 1) If no error: wp_flush with locks and return success
> >
> > The data may not be visible in the qcow2 file yet because qcow2's L1/L2=
/refcount
> > cache is not written back to the file until a flush request. I think the
> > write pointer updates should have a dependency on the qcow2 metadata so
> > that write pointers are only written after qcow2 metadata.
>=20
> Indeed. The qcow2 cache was also my concern. Since wp should be
> persisted after corresponding data is flushed, the cache dependency
> would be qcow2 metadata -> data -> wp. Can we set wp's dependency on
> the data so that wp is written after data is persisted? I might be
> missing something here.

The cached metadata is written after the data, so you don't need to do
anything special to ensure data -> qcow2 metadata -> wp ordering.

One thing to consider is when to increment the write pointer in the
cache. When there are concurrent requests, the wp written to file should
reflect the last _completed_ data write and not in-flight data writes.

It might be necessary to use additional state rather than incrementing
the wp cache immediately when submitting a write request. For example,
iterating over in-flight write requests to calculate the next wp based
on the maximum offset + length and only falling back to the wp cache
when there are no in-flight append requests in this zone.

>=20
> >
> > See block/qcow2-cache.c and qcow2_cache_set_dependency(). The idea is
> > that one type of cached metadata can set a dependency on another type of
> > cached metadata so that ordering is guaranteed.
>=20
> Thanks, I'll check it out.

By the way, I think this will require making the wp metadata a qcow2
cache object that is created with qcow2_cache_create().

Stefan

>=20
> >
> > > 2) else, wp_lock()
> > > 3) read_wp (from disk) and use the read wp value as the current wp
> > > 4) wp_unlock()
> > > 5) return IO error
> > >
> > > Sam
> > >
> > > >
> > > > Damien: Do real zoned block devices guarantee that the updated write
> > > > pointer is persisted only after appended data has written been
> > > > persisted?
> > > >
> > > > Stefan
> > >
>=20

--OQY6/m2SOw3YvsTT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoPIjUACgkQnKSrs4Gr
c8ipjQgAsIKsvuCTr3ENvxOJMs/FAgq61Iqzrqf9Kui91FYGgsM1k2xuqUStF2/1
4Kd6vconGNxwTESginihOgdgnZKF+O0vL3qu/qNNEGJhOFDuwMXhCvb+DVlLXykn
iayJ/H95S0YwqGwOikmWmGprehg5VCXhxj2czRT1X7UoVos8JChnY26V4GwzhqIb
WQw49Ka3NyuCgx6Vm3FFvCa8BbhGhy9Cl0DHY1MpVQ0XjgStuUeonjvj2AbIEdPM
gYOwHigGtD6RTNB5ufhd3Bh4FbpmZ8qYQblgmei29rpiBGDKlN3EOLWwtL38HJ6d
0QI2QXDKT059/jqEaDChEJ0cqcRV7Q==
=VL8x
-----END PGP SIGNATURE-----

--OQY6/m2SOw3YvsTT--


