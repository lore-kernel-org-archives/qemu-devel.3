Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B129BCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlCQ-0001zk-79; Wed, 20 May 2026 13:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPlCO-0001yw-PC
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPlCM-0003V0-UW
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779299953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fku5smRupIEscUvC5ZT5agM/LIy5YV9jRH44rNCPX5M=;
 b=YpBIpTjAjbukBPyNf1gRI81emYmNeXNJpbGqf4Iokm2Gg5/KbZXMsuixz/Z6Ywe6rAwt0g
 51eGFTbPS2bAubNby86+DLiakuAinRaknlOm7rUZw2dkxWjqyeexlJqnANJ3K/CHg4Too4
 malCMjpbuKO/UvFSeBPfKOoM1dlmnIQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-16sKa5pHP9mPfQIkfoVSEA-1; Wed,
 20 May 2026 13:59:09 -0400
X-MC-Unique: 16sKa5pHP9mPfQIkfoVSEA-1
X-Mimecast-MFC-AGG-ID: 16sKa5pHP9mPfQIkfoVSEA_1779299948
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7191195605F; Wed, 20 May 2026 17:59:07 +0000 (UTC)
Received: from localhost (unknown [10.2.16.222])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A192819560A2; Wed, 20 May 2026 17:59:06 +0000 (UTC)
Date: Wed, 20 May 2026 13:59:05 -0400
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
Message-ID: <20260520175905.GA384978@fedora>
References: <20260510175059.311814-1-faithilikerun@gmail.com>
 <20260510175059.311814-3-faithilikerun@gmail.com>
 <20260514194906.GC1535937@fedora>
 <CAAAx-8K+12SGZqzpLGsxjsr6iGAHwQu-TUXe6Z6rtZA27OpjrQ@mail.gmail.com>
 <20260519154911.GB119642@fedora>
 <CAAAx-8Jooodx88LTJvVjHQYKj-SgkCxXkMTi1=ZdR3v3cpUvUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jQ+qFQZI19rf9d0Q"
Content-Disposition: inline
In-Reply-To: <CAAAx-8Jooodx88LTJvVjHQYKj-SgkCxXkMTi1=ZdR3v3cpUvUg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--jQ+qFQZI19rf9d0Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:20:18PM +0200, Sam Li wrote:
> On Tue, May 19, 2026 at 5:49=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Mon, May 18, 2026 at 12:21:55AM +0200, Sam Li wrote:
> > > On Thu, May 14, 2026 at 9:49=E2=80=AFPM Stefan Hajnoczi <stefanha@red=
hat.com> wrote:
> > > > On Sun, May 10, 2026 at 07:50:57PM +0200, Sam Li wrote:
> > > > > +         48 - 55:  zonedmeta_offset
> > > > > +                   The offset of zoned metadata structure in the=
 contained
> > > > > +                   image, in bytes.
> > > >
> > > > Do you want to say anything about the order in which metadata is
> > > > persisted to disk when zones used? I guess the data is written into=
 the
> > > > image file first, then the non-zoned qcow2 L1/L2/refcount metadata =
is
> > > > updated, and finally the write pointer is written. Write pointers a=
re
> > > > not guaranteed to be updated on disk until the write request follow=
ed by
> > > > a flush request are both completed.
> > >
> > > The current ordering is not like that. The write pointer is written
> > > persistently first, then the data writes and the non-zoned qcow2
> > > L1/L2/refcount metadata updates. On IO failure, the corresponding
> > > write pointer is re-read from disk. As noted in the previous comment,
> > > the wp must be updated when issuing the IO, under the assumption that
> > > the write IO will succeed.
> > >
> > > The ordering has been settled this way since v7 to deal with
> > > concurrent zone append writes. If the wp was only updated after data
> > > I/O, two concurrent appends would both have read the same wp and tried
> > > to write to the same position.
> > >
> > > >
> > > > (The idea is that the data must be visible in the qcow2 file before=
 it
> > > > is safe to update the write pointer. Otherwise a power failure would
> > > > leave the file in an inconsistent state where the write pointer has
> > > > advanced but the data was not written.)
> > >
> > > The crash-consistency is a concern...
> >
> > Yes, I'm thinking about crash-consistency. The ordering you described
> > can result in qcow2 images where the write pointer is ahead of the
> > actually written data after a power failure or maybe a QEMU crash.
> >
> > QEMU's block layer must follow the same data integrity behavior that
> > real devices guarantee.
>=20
> I may have found a solution to deal with both cases. The fix is to
> update wp in memory instead of flushing it before qcow2 metadata and
> data writes. The zone append write path would become:
>=20
> On submission:
>=20
> 1) wp_lock()
> 2) Check write alignment
> 3) wp_update (in memory)
> 4) wp_unlock()
> 5) Issue write
>=20
> And on completion:
> 1) If no error: wp_flush with locks and return success

The data may not be visible in the qcow2 file yet because qcow2's L1/L2/ref=
count
cache is not written back to the file until a flush request. I think the
write pointer updates should have a dependency on the qcow2 metadata so
that write pointers are only written after qcow2 metadata.

See block/qcow2-cache.c and qcow2_cache_set_dependency(). The idea is
that one type of cached metadata can set a dependency on another type of
cached metadata so that ordering is guaranteed.

> 2) else, wp_lock()
> 3) read_wp (from disk) and use the read wp value as the current wp
> 4) wp_unlock()
> 5) return IO error
>=20
> Sam
>=20
> >
> > Damien: Do real zoned block devices guarantee that the updated write
> > pointer is persisted only after appended data has written been
> > persisted?
> >
> > Stefan
>=20

--jQ+qFQZI19rf9d0Q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoN9mkACgkQnKSrs4Gr
c8hdqAgAv/k71Vx6Yd+774dLDe1LwZW65nPeQay/00+ipfz6YAq+Ab5SDgn8p5og
LxrS2iSTIv3SyBmZaJmdBsr60Dd4K12qQ/zJ6C2fKsjPnW+FRVoJpbp8UUPNY/Qw
i1MhWTAYvkBZMxUfdWDjuEEKKwX6tZuq2nMCn8AYBfveFTh+iSPDT0480xW2q75Y
FM47uWmrVp/jrvfQVZ5kHdz7/tI8+afZL2xivFnDcfYS0j5AmUMQtpAXdwvn6kvk
3axygYqiMTXBzG34KZXv23TaFGnMMgIzxQd99YAMRXR+T9igADBEIlUoeK3UYNvt
KoJyAjUpnvne+yI7g2g5tX84uUKY9w==
=KpCC
-----END PGP SIGNATURE-----

--jQ+qFQZI19rf9d0Q--


