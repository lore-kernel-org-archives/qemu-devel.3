Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1481C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 19:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vidjR-00021A-CB; Wed, 21 Jan 2026 14:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vidjO-0001y8-4d
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 14:19:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vidjJ-00087l-Qf
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 14:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769023140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XMJY5iC1duFjkV2vd+WTebKmxFCuajpUpMsosWqW08Y=;
 b=gGrCyrVvJC3wFkyGUoP9VMpv5VKFvQBTAW/7tYMwVtEYb6z2yhMtHYMVdfxpuyVKILwzsz
 bIYc/9E+PqR+UnRPeWd3L8riqsORWVhEV7NPeHME79Ey1FdxgiP8NlRzBb25XlIBp9Bxpx
 JdZDzeuuAmbiAB96mqq9VnZn4F32pa8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-CTXr3l4uM7uJJtJDTIKhZw-1; Wed,
 21 Jan 2026 14:18:57 -0500
X-MC-Unique: CTXr3l4uM7uJJtJDTIKhZw-1
X-Mimecast-MFC-AGG-ID: CTXr3l4uM7uJJtJDTIKhZw_1769023136
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 266C8195605F; Wed, 21 Jan 2026 19:18:56 +0000 (UTC)
Received: from localhost (unknown [10.2.17.50])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1646719560A2; Wed, 21 Jan 2026 19:18:54 +0000 (UTC)
Date: Wed, 21 Jan 2026 14:18:53 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 qemu-stable@nongnu.org, eblake@redhat.com
Subject: Re: [PATCH] block/mirror: check range when setting zero bitmap for
 sync write
Message-ID: <20260121191853.GB1009471@fedora>
References: <20260112152544.261923-1-f.ebner@proxmox.com>
 <20260119201059.GA869317@fedora>
 <3e89208c-b0b9-44a8-beed-e122daabaf54@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zoQPYqj3rZx2Wgq6"
Content-Disposition: inline
In-Reply-To: <3e89208c-b0b9-44a8-beed-e122daabaf54@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--zoQPYqj3rZx2Wgq6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 09:57:42AM +0100, Fiona Ebner wrote:
> Am 19.01.26 um 9:10 PM schrieb Stefan Hajnoczi:
> > On Mon, Jan 12, 2026 at 04:23:51PM +0100, Fiona Ebner wrote:
> >> Some Proxmox users reported an occasional assertion failure [0][1] in
> >> busy VMs when using drive mirror with active mode. In particular, the
> >> failure may occur for zero writes shorter than the job granularity:
> >>
> >>> #0  0x00007b421154b507 in abort ()
> >>> #1  0x00007b421154b420 in ?? ()
> >>> #2  0x0000641c582e061f in bitmap_set (map=3D0x7b4204014e00, start=3D1=
4, nr=3D-1)
> >>> #3  0x0000641c58062824 in do_sync_target_write (job=3D0x641c7e73d1e0,
> >>>       method=3DMIRROR_METHOD_ZERO, offset=3D852480, bytes=3D4096, qio=
v=3D0x0, flags=3D0)
> >>> #4  0x0000641c58062250 in bdrv_mirror_top_do_write (bs=3D0x641c7e62e1=
f0,
> >>         method=3DMIRROR_METHOD_ZERO, copy_to_target=3Dtrue, offset=3D8=
52480,
> >>         bytes=3D4096, qiov=3D0x0, flags=3D0)
> >>> #5  0x0000641c58061f31 in bdrv_mirror_top_pwrite_zeroes (bs=3D0x641c7=
e62e1f0,
> >>         offset=3D852480, bytes=3D4096, flags=3D0)
> >>
> >> The range for the dirty bitmap described by dirty_bitmap_offset and
> >> dirty_bitmap_end is narrower than the original range and in fact,
> >> dirty_bitmap_end might be smaller than dirty_bitmap_offset. There
> >> already is a check for 'dirty_bitmap_offset < dirty_bitmap_end' before
> >> resetting the dirty bitmap. Add such a check for setting the zero
> >> bitmap too, which uses the same narrower range.
> >>
> >> [0]: https://forum.proxmox.com/threads/177981/
> >> [1]: https://bugzilla.proxmox.com/show_bug.cgi?id=3D7222
> >>
> >> Cc: qemu-stable@nongnu.org
> >> Fixes: 7e277545b9 ("mirror: Skip writing zeroes when target is already=
 zero")
> >> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> >> ---
> >>  block/mirror.c | 9 ++++++---
> >>  1 file changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/block/mirror.c b/block/mirror.c
> >> index b344182c74..bc982cb99a 100644
> >> --- a/block/mirror.c
> >> +++ b/block/mirror.c
> >> @@ -1514,9 +1514,12 @@ do_sync_target_write(MirrorBlockJob *job, Mirro=
rMethod method,
> >>          assert(!qiov);
> >>          ret =3D blk_co_pwrite_zeroes(job->target, offset, bytes, flag=
s);
> >>          if (job->zero_bitmap && ret >=3D 0) {
> >> -            bitmap_set(job->zero_bitmap, dirty_bitmap_offset / job->g=
ranularity,
> >> -                       (dirty_bitmap_end - dirty_bitmap_offset) /
> >> -                       job->granularity);
> >> +            if (dirty_bitmap_offset < dirty_bitmap_end) {
> >> +                bitmap_set(job->zero_bitmap,
> >> +                           dirty_bitmap_offset / job->granularity,
> >> +                           (dirty_bitmap_end - dirty_bitmap_offset) /
> >> +                           job->granularity);
> >> +            }
> >=20
> > Why does this case clause use dirty_bitmap_offset and dirty_bitmap_end
> > instead of zero_bitmap_offset and zero_bitmap_end like the other
> > zero_bitmap operations in this switch statement?
> >=20
> >    if (job->zero_bitmap && ret >=3D 0) {
> > -      bitmap_set(job->zero_bitmap, dirty_bitmap_offset / job->granular=
ity,
> > -                 (dirty_bitmap_end - dirty_bitmap_offset) /
> > -                 job->granularity);
> > +      bitmap_set(job->zero_bitmap, zero_bitmap_offset,
> > +                 zero_bitmap_end - zero_bitmap_offset);
> >    }
> >=20
> > I'm probably missing something, but it's not obvious to me :).
>=20
> Sorry, I could've mentioned this in the commit message. There is a
> comment explaining it further up in the function:
>=20
> >     /*
> >      * Tails are either clean or shrunk, so for dirty bitmap resetting
> >      * we safely align the range narrower.  But for zero bitmap, round
> >      * range wider for checking or clearing, and narrower for setting.
> >      */

Thanks!

Stefan

--zoQPYqj3rZx2Wgq6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmlxJp0ACgkQnKSrs4Gr
c8j5MwgAsysV4s4EwnQzf/NEt1PT8Kh6aIEee1BrcgI5Lh+pt4UF1ggsAmnlG3Cg
oWET/ZkmZ9Kj2jAdEDpJXHwdBXmf5KPRPN1+PHJWXZkhYoabqFmbFJfrFFjj61lq
rOmXMflluNWFohS/6MjP2g11Nsrqk5RmpjCSKxFkO08fbRhih49+21QY0nbzp3WS
tr6XSPWy4s3sxBCHowkKEBXX8hhoc1ar9NdjCbsO+UJR+e2eCxF55FviHAVreqKs
6rZXUztx92PTMQTn2NSizIMqFXkxgfjB7c6IF1KSv+QDMXd9kox8Pu4nFZuB2w5B
SkI8nnmsucTwAu3IkhF37yS6tBCBIw==
=Dr5T
-----END PGP SIGNATURE-----

--zoQPYqj3rZx2Wgq6--


