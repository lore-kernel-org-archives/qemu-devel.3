Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF31CCF2EE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 20:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhvaj-00053y-0A; Mon, 19 Jan 2026 15:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhvah-000532-76
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 15:11:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhvad-0003Q1-9B
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 15:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768853465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a3CKzCll4s0CdsixfST1oZ+0xS5UOVq+BJiF7sYOqE8=;
 b=W7xoxiXKJBqTG6hlaNlH983WBuafKe1EXNgtrQNu32VNBfxHiuWDudHn+aL/i1SNBrHsC+
 eo/aJpAFW7H806VQ7VzZz+QyCh7HFM91LG+RctwmeCsST105ehrcvRAVyU6QGe3xmbk+PI
 KMA0nsNFOraIaaRXHh9GQ1l6A1cIlgU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-fHD52PLmNmmtP9RGHwdv1A-1; Mon,
 19 Jan 2026 15:11:03 -0500
X-MC-Unique: fHD52PLmNmmtP9RGHwdv1A-1
X-Mimecast-MFC-AGG-ID: fHD52PLmNmmtP9RGHwdv1A_1768853462
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C470619560AE; Mon, 19 Jan 2026 20:11:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.150])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E20D1955F43; Mon, 19 Jan 2026 20:10:59 +0000 (UTC)
Date: Mon, 19 Jan 2026 15:10:59 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 qemu-stable@nongnu.org, eblake@redhat.com
Subject: Re: [PATCH] block/mirror: check range when setting zero bitmap for
 sync write
Message-ID: <20260119201059.GA869317@fedora>
References: <20260112152544.261923-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fpHW0qS8zpLog7zp"
Content-Disposition: inline
In-Reply-To: <20260112152544.261923-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--fpHW0qS8zpLog7zp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 04:23:51PM +0100, Fiona Ebner wrote:
> Some Proxmox users reported an occasional assertion failure [0][1] in
> busy VMs when using drive mirror with active mode. In particular, the
> failure may occur for zero writes shorter than the job granularity:
>=20
> > #0  0x00007b421154b507 in abort ()
> > #1  0x00007b421154b420 in ?? ()
> > #2  0x0000641c582e061f in bitmap_set (map=3D0x7b4204014e00, start=3D14,=
 nr=3D-1)
> > #3  0x0000641c58062824 in do_sync_target_write (job=3D0x641c7e73d1e0,
> >       method=3DMIRROR_METHOD_ZERO, offset=3D852480, bytes=3D4096, qiov=
=3D0x0, flags=3D0)
> > #4  0x0000641c58062250 in bdrv_mirror_top_do_write (bs=3D0x641c7e62e1f0,
>         method=3DMIRROR_METHOD_ZERO, copy_to_target=3Dtrue, offset=3D8524=
80,
>         bytes=3D4096, qiov=3D0x0, flags=3D0)
> > #5  0x0000641c58061f31 in bdrv_mirror_top_pwrite_zeroes (bs=3D0x641c7e6=
2e1f0,
>         offset=3D852480, bytes=3D4096, flags=3D0)
>=20
> The range for the dirty bitmap described by dirty_bitmap_offset and
> dirty_bitmap_end is narrower than the original range and in fact,
> dirty_bitmap_end might be smaller than dirty_bitmap_offset. There
> already is a check for 'dirty_bitmap_offset < dirty_bitmap_end' before
> resetting the dirty bitmap. Add such a check for setting the zero
> bitmap too, which uses the same narrower range.
>=20
> [0]: https://forum.proxmox.com/threads/177981/
> [1]: https://bugzilla.proxmox.com/show_bug.cgi?id=3D7222
>=20
> Cc: qemu-stable@nongnu.org
> Fixes: 7e277545b9 ("mirror: Skip writing zeroes when target is already ze=
ro")
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  block/mirror.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index b344182c74..bc982cb99a 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1514,9 +1514,12 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMe=
thod method,
>          assert(!qiov);
>          ret =3D blk_co_pwrite_zeroes(job->target, offset, bytes, flags);
>          if (job->zero_bitmap && ret >=3D 0) {
> -            bitmap_set(job->zero_bitmap, dirty_bitmap_offset / job->gran=
ularity,
> -                       (dirty_bitmap_end - dirty_bitmap_offset) /
> -                       job->granularity);
> +            if (dirty_bitmap_offset < dirty_bitmap_end) {
> +                bitmap_set(job->zero_bitmap,
> +                           dirty_bitmap_offset / job->granularity,
> +                           (dirty_bitmap_end - dirty_bitmap_offset) /
> +                           job->granularity);
> +            }

Why does this case clause use dirty_bitmap_offset and dirty_bitmap_end
instead of zero_bitmap_offset and zero_bitmap_end like the other
zero_bitmap operations in this switch statement?

   if (job->zero_bitmap && ret >=3D 0) {
-      bitmap_set(job->zero_bitmap, dirty_bitmap_offset / job->granularity,
-                 (dirty_bitmap_end - dirty_bitmap_offset) /
-                 job->granularity);
+      bitmap_set(job->zero_bitmap, zero_bitmap_offset,
+                 zero_bitmap_end - zero_bitmap_offset);
   }

I'm probably missing something, but it's not obvious to me :).

Stefan

--fpHW0qS8zpLog7zp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmluj9IACgkQnKSrs4Gr
c8jzugf+P+Avd6meRYWvXPW34c+ov0w73OhD/DDZJCSwLxbYddYqsqR9LRniCiyt
qwy9b4U2Pbh1zZ0KWR+yO5TW7KzNr0kzifeKok/5CgvNtnndofRwru63SCdnkq9C
92hb4p14/CGl29qhBAWcOs/RGbO7fYJ8MgORDTn7tEA8JHc6v4ksmEM+V1vwQOY4
LjvmWfgJrLaRKSIW3n2Vn4w+v30YjiigSz9eeJgDf94+5E1OJfp58r77NZ8l6IfC
CjLE9mH06PxaTfzReKeeKdwnjtW1/tTdqoyKEZe4wtwpnMveO9iHXqY8YamZ5whT
yXoDLPFXEKCFzNerYj336EZ/s86Suw==
=r+6M
-----END PGP SIGNATURE-----

--fpHW0qS8zpLog7zp--


