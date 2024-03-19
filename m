Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016D6CD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 17:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmdgT-00053r-Oi; Tue, 19 Mar 2024 13:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rmdgQ-00053h-8J
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rmdgI-000626-GU
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710870921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E3QsfNIFUKwWFIe9Zh9Voz/kmBNgSp6ceUnuL7MhDo4=;
 b=GtRVrnF5qvZoXDAeo+p2dN6uq239am66CGONN2lB8TBBVoz5P8DvzTjwT/4GE5hvGJOzGF
 oDoovRU7M1LaddB1NXD6XYxR46p5X+cTn3SWFs0M3edq6gylilZwpt5ILJX+nwjM/TkB8K
 wjZwn76ekPEMmcSahzOzLaZqD4qTMos=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-9owqBDUTNBqteWURTtH24A-1; Tue, 19 Mar 2024 13:55:17 -0400
X-MC-Unique: 9owqBDUTNBqteWURTtH24A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12CE7800267
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 17:55:17 +0000 (UTC)
Received: from localhost (unknown [10.39.195.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C3802166B33;
 Tue, 19 Mar 2024 17:55:16 +0000 (UTC)
Date: Tue, 19 Mar 2024 13:55:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Sanjay Rao <srao@redhat.com>, Boaz Ben Shabat <bbenshab@redhat.com>,
 Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH] coroutine: cap per-thread local pool size
Message-ID: <20240319175510.GA1127203@fedora>
References: <20240318183429.1039340-1-stefanha@redhat.com>
 <ZfmWhDaG5mN-GCeO@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gltH31HKHF/K70LA"
Content-Disposition: inline
In-Reply-To: <ZfmWhDaG5mN-GCeO@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--gltH31HKHF/K70LA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 01:43:32PM +0000, Daniel P. Berrang=E9 wrote:
> On Mon, Mar 18, 2024 at 02:34:29PM -0400, Stefan Hajnoczi wrote:
> > The coroutine pool implementation can hit the Linux vm.max_map_count
> > limit, causing QEMU to abort with "failed to allocate memory for stack"
> > or "failed to set up stack guard page" during coroutine creation.
> >=20
> > This happens because per-thread pools can grow to tens of thousands of
> > coroutines. Each coroutine causes 2 virtual memory areas to be created.
>=20
> This sounds quite alarming. What usage scenario is justified in
> creating so many coroutines ?

The coroutine pool hides creation and deletion latency. The pool
initially has a modest size of 64, but each virtio-blk device increases
the pool size by num_queues * queue_size (256) / 2.

The issue pops up with large SMP guests (i.e. large num_queues) with
multiple virtio-blk devices.

> IIUC, coroutine stack size is 1 MB, and so tens of thousands of
> coroutines implies 10's of GB of memory just on stacks alone.
>=20
> > Eventually vm.max_map_count is reached and memory-related syscalls fail.
>=20
> On my system max_map_count is 1048576, quite alot higher than
> 10's of 1000's. Hitting that would imply ~500,000 coroutines and
> ~500 GB of stacks !

Fedora recently increased the limit to 1048576. Before that it was
65k-ish and still is on most other distros.

Regarding why QEMU might have 65k coroutines pooled, it's because the
existing coroutine pool algorithm is per thread. So if the max pool size
is 15k but you have 4 IOThreads then up to 4 x 15k total coroutines can
be sitting in pools. This patch addresses this by setting a small fixed
size on per thread pools (256).

>=20
> > diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> > index 5fd2dbaf8b..2790959eaf 100644
> > --- a/util/qemu-coroutine.c
> > +++ b/util/qemu-coroutine.c
>=20
> > +static unsigned int get_global_pool_hard_max_size(void)
> > +{
> > +#ifdef __linux__
> > +    g_autofree char *contents =3D NULL;
> > +    int max_map_count;
> > +
> > +    /*
> > +     * Linux processes can have up to max_map_count virtual memory are=
as
> > +     * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this =
limit. We
> > +     * must limit the coroutine pool to a safe size to avoid running o=
ut of
> > +     * VMAs.
> > +     */
> > +    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, N=
ULL,
> > +                            NULL) &&
> > +        qemu_strtoi(contents, NULL, 10, &max_map_count) =3D=3D 0) {
> > +        /*
> > +         * This is a conservative upper bound that avoids exceeding
> > +         * max_map_count. Leave half for non-coroutine users like libr=
ary
> > +         * dependencies, vhost-user, etc. Each coroutine takes up 2 VM=
As so
> > +         * halve the amount again.
> > +         */
> > +        return max_map_count / 4;
>=20
> That's 256,000 coroutines, which still sounds incredibly large
> to me.

Any ideas for tweaking this heuristic?

>=20
> > +    }
> > +#endif
> > +
> > +    return UINT_MAX;
>=20
> Why UINT_MAX as a default ?  If we can't read procfs, we should
> assume some much smaller sane default IMHO, that corresponds to
> what current linux default max_map_count would be.

This line is not Linux-specific. I don't know if other OSes have an
equivalent to max_map_count.

I agree with defaulting to 64k-ish on Linux.

Stefan

>=20
> > +}
> > +
> > +static void __attribute__((constructor)) qemu_coroutine_init(void)
> > +{
> > +    qemu_mutex_init(&global_pool_lock);
> > +    global_pool_hard_max_size =3D get_global_pool_hard_max_size();
> >  }
> > --=20
> > 2.44.0
> >=20
> >=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20

--gltH31HKHF/K70LA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmX50X4ACgkQnKSrs4Gr
c8iwcggAmXEBmPam6TWN/FCNUbGDpFMCNKtlEgKciJsDgLNiiKTbvDNOAMTV2zSD
XgQZ+rzE5QMniCE6L19w2a1QjiWBLohK/Q+uuyiIsRK6P9cilEkKlJDv1yd333gn
m3DL8o0DfcAaiyvcVxlZYSKd6E2bGNrvpjelRcY1oZ2n/LMT1b6M9Es0eeaCs57k
wQsCI9eYlKUbDR4hmkC3nXRYzCdmGPJbLaGTWMyibPyHxyPY6IPkZjrGq3NVsOZG
snbLcIbORo5JEhbv5DbnDwlURFUwKLONEz1T1xsuAiolhTetV8wG7IoTvCOdzpCu
tDmM87fzsFqBx3cUqbJX/XPGrthC8A==
=n0Lz
-----END PGP SIGNATURE-----

--gltH31HKHF/K70LA--


