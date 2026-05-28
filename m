Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A8FCD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSakt-0001SN-8k; Thu, 28 May 2026 09:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wSakr-0001SE-K9
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wSako-0002J1-3Q
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779974789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OIv8LbFyJYIxKMq0rQelX5wyI9ncYTP9FeQxT19I+kc=;
 b=dwkapVqWxWrsc88TQjPx1ck2Mtzj5AiqTU1DRz6iumk83trYU/yW6jexMrZpYPORE4zDhJ
 YDq/45SKUJq6Yx4SbfWWLd+/t+T4OTMRTI10VGvLZU5x5ldoJLF8gwiGePWuYjKGFkDO3F
 P45sahLf33PVZ/RpDqiItgOmWFUh7mA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-GhwFZIhJOISIm67oKmApFQ-1; Thu,
 28 May 2026 09:26:25 -0400
X-MC-Unique: GhwFZIhJOISIm67oKmApFQ-1
X-Mimecast-MFC-AGG-ID: GhwFZIhJOISIm67oKmApFQ_1779974784
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A6BC18005BB; Thu, 28 May 2026 13:26:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.62])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D4FD30001BB; Thu, 28 May 2026 13:26:22 +0000 (UTC)
Date: Thu, 28 May 2026 09:26:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 fam@euphon.net
Subject: Re: [RFC v2 0/6] block/io: avoid failure caused by misaligned
 BLKZEROOUT ioctl
Message-ID: <20260528132621.GA40266@fedora>
References: <20260109120837.2772961-1-f.ebner@proxmox.com>
 <20260202221634.GB429972@fedora>
 <36a69637-d7b9-42cb-b16f-473091efb3ee@proxmox.com>
 <aYS_G-QHlbucVpUd@redhat.com>
 <CAJSP0QX22xxAq7sYChGMq9up3YOAXuxrbe99_8YoLFV0pKj0Zg@mail.gmail.com>
 <800f05f8-e77a-496b-8a25-253ad7cafecb@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PwhdZ9iCI6o1vH4Z"
Content-Disposition: inline
In-Reply-To: <800f05f8-e77a-496b-8a25-253ad7cafecb@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--PwhdZ9iCI6o1vH4Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 10:32:32AM +0200, Fiona Ebner wrote:
> Am 27.05.26 um 11:06 PM schrieb Stefan Hajnoczi:
> > On Thu, Feb 5, 2026 at 11:03=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> w=
rote:
> >>
> >> Am 05.02.2026 um 13:13 hat Fiona Ebner geschrieben:
> >>> Hi Stefan,
> >>>
> >>> Am 02.02.26 um 11:15 PM schrieb Stefan Hajnoczi:
> >>>> On Fri, Jan 09, 2026 at 01:08:27PM +0100, Fiona Ebner wrote:
> >>>>> Previous discussion here:
> >>>>> https://lore.kernel.org/qemu-devel/20260105143416.737482-1-f.ebner@=
proxmox.com/
> >>>>>
> >>>>> Commit 5634622bcb ("file-posix: allow BLKZEROOUT with -t writeback")
> >>>>> enables the BLKZEROOUT ioctl when using 'writeback' cache, regressi=
ng
> >>>>> certain 'qemu-img convert' invocations, because of a pre-existing
> >>>>> issue. Namely, the BLKZEROOUT ioctl might fail with errno EINVAL wh=
en
> >>>>> the request is shorter than the block size of the block device.
> >>>>>
> >>>>> Stefan suggested prioritizing bl.pwrite_zeroes_alignment in
> >>>>> bdrv_co_do_zero_pwritev(). This RFC explores that approach and the
> >>>>> issues with qcow2 I encountered, where
> >>>>> bl.pwrite_zeroes_alignment =3D s->subcluster_size;
> >>>>> I would be happy to discuss potential solutions and whether we shou=
ld
> >>>>> use this approach after all.
> >>>>
> >>>> Hi Fiona,
> >>>> I wanted to continue this discussion. My thoughts are that making
> >>>> bdrv_co_do_zero_pwritev() use bl.pwrite_zeroes_alignment is the right
> >>>> long-term solution to keep all the padding logic in one place.
> >>>>
> >>>> On the other hand, your series shows it involves fixing a bunch of t=
est
> >>>> failures and that's not fun. The original bug that is being solved h=
ere
> >>>> is my doing, so feel free to hand this over to me if you decide you
> >>>> don't want to work on it.
> >>>
> >>> in your other mail, you mentioned you'll ask Kevin for his opinion. So
> >>> in part, I was waiting for that. But I also was side-tracked by other
> >>> things, and it will be 1-2 more weeks until I can really focus on this
> >>> again. If that is too long, please go ahead and pick it up.
> >>
> >> I didn't review this thoroughly yet, but I agree that considering the
> >> alignment from the start is the better solution and also more consiste=
nt
> >> with what we're already doing for normal reads and writes.
> >>
> >> We just need to make sure that we use the right alignments in the right
> >> places, which can be a bit confusing with the fallbacks to buffered ze=
ro
> >> writes here and there.
> >>
> >> I assume that there is enough time left to do this before the 11.0
> >> release and there is no need to take something like v1 as an
> >> intermediate solution?
> >=20
> > No progress has been made and I'm unable to commit time at the moment.
>=20
> Me neither unfortunately.
>=20
> > Is everyone okay with merging Fiona's smaller original patch? While it
> > would be nice to implement a deeper fix, it's better to have a fix and
> > I think there is no great risk merging the original patch.
> >=20
> > https://lore.kernel.org/qemu-devel/20260105143416.737482-1-f.ebner@prox=
mox.com/
>=20
> FWIW, we have been using that patch downstream since mid-February [0]
> and nobody reported issues with it as far as I'm aware. I suppose it
> could use a 'TODO' code comment that the proper fix looks different. If
> you choose to go with that patch, should I send a v2 with such a comment
> or can that be added when applying?

I can add the comment when merging the patch. I will merge it on Monday
so Kevin still has some time to reply in case he has an opinion.

Stefan

>=20
> Best Regards,
> Fiona
>=20
> [0]:
> https://git.proxmox.com/?p=3Dpve-qemu.git;a=3Dcommitdiff;h=3D6960b5e033fa=
911f9882751950df28a193255683
>=20

--PwhdZ9iCI6o1vH4Z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoYQn0ACgkQnKSrs4Gr
c8hEqgf9FdgQGLYFgbwxatOXzsfW/H963U88BGbK/9+CO37LzGbF6jWc6+dbwv0B
e0R9kuz4rNmOUHO+MJNP627MstDtFZ+CrIg8KxCryzSg5HrcT9TIgARrNR+uvity
Eo4Gf8YB2cQ24FT/kgdtYqesX5ET1MtQeRKks2iv1m3WvY0nW/Ak9HmalEn5eKCn
IjuEhNUdhPHqIcjfxUX3Pi+X1OsvMbWzzOs1upBwOezSANo5qqAwCUqF+YMTNb72
9zF4lpDv1Z9el3DdH87YJ8JWhjug5aoNVZ2A1EooOZD9iPKcdn6GXcspaeyppkGw
Ma8VqTVpF9JHoD3bCYwx2awNLL6dxg==
=D4mk
-----END PGP SIGNATURE-----

--PwhdZ9iCI6o1vH4Z--


