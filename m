Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA78FC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 13:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmw6z-00086g-S4; Wed, 20 Mar 2024 09:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rmw6x-00084h-KP
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rmw6v-0005SV-NC
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710941764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6S04FVBGBHFrUXZwpGM/mUPd4tC7ugDzVhOtiaWOZ4=;
 b=hpqXpUhK/VuFETT6KpttAmol3rrc8Xuc5D6L+mxVa+PINJg/pWzp6niXdAvQtM4pys1q45
 WxE+372H5CM0ag6ExX3y4257009A5JakxI1mBM2rkQnoIPUPHLNcHePotG9Hcp/5Tz9sWX
 Ds0mFvPH+Rm2WiRnCeIDcS+Zy5KcCwA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-Kyg1UGk0Pr2JHDs2Jv5i3w-1; Wed,
 20 Mar 2024 09:36:01 -0400
X-MC-Unique: Kyg1UGk0Pr2JHDs2Jv5i3w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AB9F2801E6A
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 13:36:01 +0000 (UTC)
Received: from localhost (unknown [10.39.194.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A11723C20;
 Wed, 20 Mar 2024 13:36:00 +0000 (UTC)
Date: Wed, 20 Mar 2024 09:35:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Sanjay Rao <srao@redhat.com>, Boaz Ben Shabat <bbenshab@redhat.com>,
 Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH] coroutine: cap per-thread local pool size
Message-ID: <20240320133539.GA1190824@fedora>
References: <20240318183429.1039340-1-stefanha@redhat.com>
 <ZfmWhDaG5mN-GCeO@redhat.com> <20240319175510.GA1127203@fedora>
 <ZfnxSd4lseZuWoQ5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="diEhgda288nGRzYs"
Content-Disposition: inline
In-Reply-To: <ZfnxSd4lseZuWoQ5@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--diEhgda288nGRzYs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 08:10:49PM +0000, Daniel P. Berrang=E9 wrote:
> On Tue, Mar 19, 2024 at 01:55:10PM -0400, Stefan Hajnoczi wrote:
> > On Tue, Mar 19, 2024 at 01:43:32PM +0000, Daniel P. Berrang=E9 wrote:
> > > On Mon, Mar 18, 2024 at 02:34:29PM -0400, Stefan Hajnoczi wrote:
> > > > diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> > > > index 5fd2dbaf8b..2790959eaf 100644
> > > > --- a/util/qemu-coroutine.c
> > > > +++ b/util/qemu-coroutine.c
> > >=20
> > > > +static unsigned int get_global_pool_hard_max_size(void)
> > > > +{
> > > > +#ifdef __linux__
> > > > +    g_autofree char *contents =3D NULL;
> > > > +    int max_map_count;
> > > > +
> > > > +    /*
> > > > +     * Linux processes can have up to max_map_count virtual memory=
 areas
> > > > +     * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond t=
his limit. We
> > > > +     * must limit the coroutine pool to a safe size to avoid runni=
ng out of
> > > > +     * VMAs.
> > > > +     */
> > > > +    if (g_file_get_contents("/proc/sys/vm/max_map_count", &content=
s, NULL,
> > > > +                            NULL) &&
> > > > +        qemu_strtoi(contents, NULL, 10, &max_map_count) =3D=3D 0) {
> > > > +        /*
> > > > +         * This is a conservative upper bound that avoids exceeding
> > > > +         * max_map_count. Leave half for non-coroutine users like =
library
> > > > +         * dependencies, vhost-user, etc. Each coroutine takes up =
2 VMAs so
> > > > +         * halve the amount again.
>=20
> Leaving half for loaded libraries, etc is quite conservative
> if max_map_count is the small-ish 64k default.
>=20
> That reservation could perhaps a fixed number like 5,000 ?

While I don't want QEMU to abort, once this heuristic is in the code it
will be scary to make it more optimistic and we may never change it. So
now is the best time to try 5,000.

I'll send a follow-up patch that reserves 5,000 mappings. If that turns
out to be too optimistic we can increase the reservation.

> > > > +         */
> > > > +        return max_map_count / 4;
> > >=20
> > > That's 256,000 coroutines, which still sounds incredibly large
> > > to me.
> >=20
> > Any ideas for tweaking this heuristic?
>=20
> The awkward thing about this limit is that its hardcoded, and
> since it is indeed a "heuristic", we know it is going to be
> sub-optimal for some use cases / scenarios.
>=20
> The worst case upper limit is
>=20
>    num virtio-blk * num threads * num queues
>=20
> Reducing the number of devices isn't practical if the guest
> genuinely needs that many volumes.
>=20
> Reducing the threads or queues artificially limits the peak
> performance of a single disk handling in isolation, while
> other disks are idle, so that's not desirable.
>=20
> So there's no way to cap the worst case scenario, while
> still maximising the single disk performance possibilities.
>=20
> With large VMs with many CPUs and many disks, it could be
> reasonable to not expect a real guest to need to maximise
> I/O on every disk at the same time, and thus want to put
> some cap there to control worst case resource usage.
>=20
> It feels like it leans towards being able to control the
> coroutine pool limit explicitly, as a CLI option, to override
> this default hueristic.
>=20
> > > > +    }
> > > > +#endif
> > > > +
> > > > +    return UINT_MAX;
> > >=20
> > > Why UINT_MAX as a default ?  If we can't read procfs, we should
> > > assume some much smaller sane default IMHO, that corresponds to
> > > what current linux default max_map_count would be.
> >=20
> > This line is not Linux-specific. I don't know if other OSes have an
> > equivalent to max_map_count.
> >=20
> > I agree with defaulting to 64k-ish on Linux.
>=20
>=20
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

--diEhgda288nGRzYs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmX65isACgkQnKSrs4Gr
c8j9pAf/Tk1LrTrnVCdjF7Zl2OT5mRDXmzPlOaBoCH/pEDVkec89ZY5Nj9QHN9vw
alhNG9J015WlKkWqttBMBSNHAILKy3HCw0n/DyQFWX8Hx1ubn9X3ar08KQEt/vlo
2RzZfJeGLeML9gGsvmVlCejChvQrUUmuwB/DYvHu6JdCQZi3a/0SWegpBA25Cln2
1NnxIZPA5go7uy5pWDBmHMcLWsLjz14+XZEHtIFF9OsHiQwunStmSrxkPhAPnFQU
lw8p5iFtY5jlIaQ3q9HFPSwfv94N89vsbpqVD2vL5pkJTrRtPBFAn4/FaDJ0BFPj
ys3UMWd8EaV4zjHi2lw7KaSJbTWeiw==
=LPlI
-----END PGP SIGNATURE-----

--diEhgda288nGRzYs--


