Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0A1CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 13:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwKiU-0007zv-B3; Wed, 10 Sep 2025 09:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uwKhd-0007fp-2t
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 09:17:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uwKhF-0004Bd-BY
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 09:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757510232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UglAbwONwB6IaMBrRSRdtkOzZF3BATPK8mLVm4yy2lc=;
 b=hUgpwIey+xScXEVaOe6lu0TpHgZYaRK5ED9uFk0ZWzbyM4B1rfmv7nyMR9jAq7Ba5BH/ux
 ZxQGqT0B5CbGrLzKngGbg6r4brVLvmUyGfjICIfNVJ25YflRN46QnqHvULJ9nLoFk+Pvdg
 1RaBXCxn3Dm1xCmmRKM3C1/dQAsguAI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-TOBDx7b5Pya97xejGCcGdg-1; Wed,
 10 Sep 2025 09:17:07 -0400
X-MC-Unique: TOBDx7b5Pya97xejGCcGdg-1
X-Mimecast-MFC-AGG-ID: TOBDx7b5Pya97xejGCcGdg_1757510226
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1581019560AF; Wed, 10 Sep 2025 13:17:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3903E1800446; Wed, 10 Sep 2025 13:17:05 +0000 (UTC)
Date: Wed, 10 Sep 2025 09:17:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH 3/4] export/fuse: Safe termination for FUSE-uring
Message-ID: <20250910131704.GB246746@fedora>
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-4-hibriansong@gmail.com>
 <20250909193358.GE218449@fedora>
 <128a530b-b375-4019-bfef-9482cc63af37@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m+8UwVox3h8R5ZXB"
Content-Disposition: inline
In-Reply-To: <128a530b-b375-4019-bfef-9482cc63af37@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--m+8UwVox3h8R5ZXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 04:51:32PM -0400, Brian Song wrote:
>=20
>=20
> On 9/9/25 3:33 PM, Stefan Hajnoczi wrote:
> > On Fri, Aug 29, 2025 at 10:50:24PM -0400, Brian Song wrote:
> > > @@ -901,24 +941,15 @@ static void fuse_export_shutdown(BlockExport *b=
lk_exp)
> > >            */
> > >           g_hash_table_remove(exports, exp->mountpoint);
> > >       }
> > > -}
> > > -
> > > -static void fuse_export_delete(BlockExport *blk_exp)
> > > -{
> > > -    FuseExport *exp =3D container_of(blk_exp, FuseExport, common);
> > > -    for (int i =3D 0; i < exp->num_queues; i++) {
> > > +    for (size_t i =3D 0; i < exp->num_queues; i++) {
> > >           FuseQueue *q =3D &exp->queues[i];
> > >           /* Queue 0's FD belongs to the FUSE session */
> > >           if (i > 0 && q->fuse_fd >=3D 0) {
> > >               close(q->fuse_fd);
> >=20
> > This changes the behavior of the non-io_uring code. Now all fuse fds and
> > fuse_session are closed while requests are potentially still being
> > processed.
> >=20
> > There is a race condition: if an IOThread is processing a request here
> > then it may invoke a system call on q->fuse_fd just after it has been
> > closed but not set to -1. If another thread has also opened a new file
> > then the fd could be reused, resulting in an accidental write(2) to the
> > new file. I'm not sure whether there is a way to trigger this in
> > practice, but it looks like a problem waiting to happen.
> >=20
> > Simply setting q->fuse_fd to -1 here doesn't fix the race. It would be
> > necessary to stop processing fuse_fd in the thread before closing it
> > here or to schedule a BH in each thread so that fuse_fd can be closed
> > in the thread that uses the fd.
>=20
> I get what you mean. This newly introduced cleanup code was originally in
> the deletion section, after the reconf counter decreased to 0, and it was
> meant to cancel the pending SQEs. But now we've moved it to the shutdown
> section, which may introduce a potential problem. How do you think we sho=
uld
> fix it? This is the last week of GSoC, I'm already busy on weekdays since
> the new term has started.

Hi Brian,
Two issues:
1. Change of behavior for non-io_uring code. It would be safer to keep
   the old behavior for non-io_uring code.
2. The race condition. Schedule a BH in each queue's IOThread and call
   close(fuse_fd) from the BH function. That way there is no race
   between threads.

Stefan

--m+8UwVox3h8R5ZXB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjBelAACgkQnKSrs4Gr
c8jw/gf9E2w+dYtQojetomfgxPeQdo2PaEE/Df6oU31L3zoam/WDB817pYzRuFJn
o5PT4mdlbG81MBNU7hvPCUqqdrrpIwiXhlAC/8Qlgp8WBQ62PxOHdyOrgLMbzSYs
BhsW3sPHixrU+31khUD2pyCGYUIlDoM8vtAuSBJAyAyZQwB6TXascLEXVR14QEfH
+kIASNcPGTJs3seZp8GXZmQ05UZx3nx1y6lYCoS6EYLOQVyOBA00I9VHNdB3NQz2
0DqEGtCgXP/8+rkpY/qiPQgTp/dQnBtzi0tt8LbL+qnXzaNzGpj546zmbe5FP9TU
wJss8O1a8HnU04TiRLiAKS09MUwHjQ==
=SSUE
-----END PGP SIGNATURE-----

--m+8UwVox3h8R5ZXB--


