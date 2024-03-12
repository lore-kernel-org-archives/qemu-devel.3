Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46783C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 21:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk9le-0000tq-6B; Tue, 12 Mar 2024 17:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk9lb-0000tL-4x
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk9lZ-0002T3-D7
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710279272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yhi4mPxe+MZ2b3KijonWxPn64duCQdPF/Um8HURpQRE=;
 b=SM0ruBv8h8Sh6ouORFxSeSooelV9x56g7ouR1PraYiP5j+DWpbnWFcO+6JPVZI+9UauG9F
 h09nmE7FkF+92pOPF0nxAvQS8UkdnWPVbKcIaA60jSpM8kUWuQih75K+hg+xmJe7DpwbVu
 igjO9hwLKMIhxxJMYk3n64PCa6oU+ac=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-6GiNgxJrM1-h2t_zXTZS1g-1; Tue,
 12 Mar 2024 17:34:29 -0400
X-MC-Unique: 6GiNgxJrM1-h2t_zXTZS1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F68228EC113;
 Tue, 12 Mar 2024 21:34:29 +0000 (UTC)
Received: from localhost (unknown [10.39.192.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85C3E40C6CB2;
 Tue, 12 Mar 2024 21:34:28 +0000 (UTC)
Date: Tue, 12 Mar 2024 17:34:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH for 9.0] migration: Skip only empty block devices
Message-ID: <20240312213426.GA449817@fedora>
References: <20240312120431.550054-1-clg@redhat.com>
 <20240312184106.GC389553@fedora>
 <1b9016a1-ad58-47ba-9dda-96095c1e59bc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cc+9LwI24sP4RmF7"
Content-Disposition: inline
In-Reply-To: <1b9016a1-ad58-47ba-9dda-96095c1e59bc@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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


--cc+9LwI24sP4RmF7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 09:22:06PM +0100, C=E9dric Le Goater wrote:
> On 3/12/24 19:41, Stefan Hajnoczi wrote:
> > On Tue, Mar 12, 2024 at 01:04:31PM +0100, C=E9dric Le Goater wrote:
> > > The block .save_setup() handler calls a helper routine
> > > init_blk_migration() which builds a list of block devices to take into
> > > account for migration. When one device is found to be empty (sectors
> > > =3D=3D 0), the loop exits and all the remaining devices are ignored. =
This
> > > is a regression introduced when bdrv_iterate() was removed.
> > >=20
> > > Change that by skipping only empty devices.
> > >=20
> > > Cc: Markus Armbruster <armbru@redhat.com>
> > > Suggested: Kevin Wolf <kwolf@redhat.com>
> > > Fixes: fea68bb6e9fa ("block: Eliminate bdrv_iterate(), use bdrv_next(=
)")
> >=20
> > It's not clear to me that fea68bb6e9fa introduced the bug. The code is
> > still <=3D 0 there and I don't see anything else that skips empty devic=
es.
> > Can you explain the bug in fea68bb6e9fa?
>=20
> Let me try. Initially, the code was :
>     static void init_blk_migration_it(void *opaque, BlockDriverState *bs)
>     {
>         BlockDriverState *bs;
>         BlkMigDevState *bmds;
>         int64_t sectors;
>         if (!bdrv_is_read_only(bs)) {
>              sectors =3D bdrv_nb_sectors(bs);
>              if (sectors <=3D 0) {
>                  return;
>         ...
>     }
>     =09
>     static void init_blk_migration(QEMUFile *f)
>     {
>         block_mig_state.submitted =3D 0;
>         block_mig_state.read_done =3D 0;
>         block_mig_state.transferred =3D 0;
>         block_mig_state.total_sector_sum =3D 0;
>         block_mig_state.prev_progress =3D -1;
>         block_mig_state.bulk_completed =3D 0;
>         block_mig_state.zero_blocks =3D migrate_zero_blocks();
>         bdrv_iterate(init_blk_migration_it, NULL);
>     }
>=20
> bdrv_iterate() was iterating on all devices and exiting one iteration
> early if the device was empty or an error detected. The loop applied
> on all devices always, only empty devices and the ones with a failure
> were skipped.
> It was replaced by :
>=20
>     static void init_blk_migration(QEMUFile *f)
>     {
>          BlockDriverState *bs;
>          BlkMigDevState *bmds;
>          int64_t sectors;
>          block_mig_state.submitted =3D 0;
>          block_mig_state.read_done =3D 0;
>          block_mig_state.transferred =3D 0;
>          block_mig_state.total_sector_sum =3D 0;
>          block_mig_state.prev_progress =3D -1;
>          block_mig_state.bulk_completed =3D 0;
>          block_mig_state.zero_blocks =3D migrate_zero_blocks();
>          for (bs =3D bdrv_next(NULL); bs; bs =3D bdrv_next(bs)) {
>              if (bdrv_is_read_only(bs)) {
>                  continue;
>              }
>              sectors =3D bdrv_nb_sectors(bs);
>              if (sectors <=3D 0) {
>                  return;
> 	=09
>            ...
>       }
>=20
> The loop and function exit at first failure or first empty device,
> skipping the remaining devices. This is a different behavior.
>=20
> What we would want today is ignore empty devices, as it done for
> the read only ones, return at first failure and let the caller of
> init_blk_migration() report.
>=20
> This is a short term fix for 9.0 because the block migration code
> is deprecated and should be removed in 9.1.

I understand now. I missed that returning from init_blk_migration_it()
did not abort iteration. Thank you!

Stefan

--cc+9LwI24sP4RmF7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXwymIACgkQnKSrs4Gr
c8goVQf/aBJAEO3Fwzqkw3ULhiMmEkMqRFqIUbvaYb5toHiCyPCctVr6HFYlwQoP
Xql73TA4XkFOUhoy4HgN1kpqx/4QBbCGeHbu76bPNiAXcJCYyc2fPooQMQiwLue4
GnJgYbEsJ+WDDPhDwVqTX9SpzuqxJGOPRSMzpizmD8Nle3BnMG7IyYaXntRHFLRE
DhmBtMHOl3HgNXR6B8qudEKtzsoIKzUviRecwidX7JmAra/JNfcCSEyz4TuFDERO
++0JhaVBqiAc2E1v0y5WASalNrul1LZsjOaeYlXVN/89ZvmOoWzVbhUb1AXluM0y
ItqIhdQZhTxX0Ek3OCXB08hggZBU5Q==
=UMLK
-----END PGP SIGNATURE-----

--cc+9LwI24sP4RmF7--


