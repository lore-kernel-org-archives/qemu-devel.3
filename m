Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B9FCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPMhB-0004Fj-3F; Tue, 19 May 2026 11:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPMh9-0004F3-4k
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPMh7-0007KV-Dt
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779205759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YLc5HOX+HHl9DNacM1UmQ/k758gzrma5gFobMU+xi4s=;
 b=ba4prCXJOV62AQxeWGoUKR5YV8FzL3YbC3qT45hXtR0Khp3dzH1taxGnyVQSx5hFtN/wG6
 UT/pX8nFHcD/Ph8YCykaP3Oh+U38KqP3+jJFIPO/dfd91ocODYRw68LLeljT/0+AdFWyoD
 SJ8WJpZ+klJ2SR8nG+Pv1igKWTZqjPc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-JFC9uRNaP7-vnLJQIzB1Xw-1; Tue,
 19 May 2026 11:49:15 -0400
X-MC-Unique: JFC9uRNaP7-vnLJQIzB1Xw-1
X-Mimecast-MFC-AGG-ID: JFC9uRNaP7-vnLJQIzB1Xw_1779205753
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 561E71956058; Tue, 19 May 2026 15:49:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 604B71684; Tue, 19 May 2026 15:49:12 +0000 (UTC)
Date: Tue, 19 May 2026 11:49:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>, dlemoal@kernel.org
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v10 2/4] qcow2: add configurations for zoned format
 extension
Message-ID: <20260519154911.GB119642@fedora>
References: <20260510175059.311814-1-faithilikerun@gmail.com>
 <20260510175059.311814-3-faithilikerun@gmail.com>
 <20260514194906.GC1535937@fedora>
 <CAAAx-8K+12SGZqzpLGsxjsr6iGAHwQu-TUXe6Z6rtZA27OpjrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xOU5amG3E/U9fVBO"
Content-Disposition: inline
In-Reply-To: <CAAAx-8K+12SGZqzpLGsxjsr6iGAHwQu-TUXe6Z6rtZA27OpjrQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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


--xOU5amG3E/U9fVBO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 12:21:55AM +0200, Sam Li wrote:
> On Thu, May 14, 2026 at 9:49=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> > On Sun, May 10, 2026 at 07:50:57PM +0200, Sam Li wrote:
> > > +         48 - 55:  zonedmeta_offset
> > > +                   The offset of zoned metadata structure in the con=
tained
> > > +                   image, in bytes.
> >
> > Do you want to say anything about the order in which metadata is
> > persisted to disk when zones used? I guess the data is written into the
> > image file first, then the non-zoned qcow2 L1/L2/refcount metadata is
> > updated, and finally the write pointer is written. Write pointers are
> > not guaranteed to be updated on disk until the write request followed by
> > a flush request are both completed.
>=20
> The current ordering is not like that. The write pointer is written
> persistently first, then the data writes and the non-zoned qcow2
> L1/L2/refcount metadata updates. On IO failure, the corresponding
> write pointer is re-read from disk. As noted in the previous comment,
> the wp must be updated when issuing the IO, under the assumption that
> the write IO will succeed.
>=20
> The ordering has been settled this way since v7 to deal with
> concurrent zone append writes. If the wp was only updated after data
> I/O, two concurrent appends would both have read the same wp and tried
> to write to the same position.
>=20
> >
> > (The idea is that the data must be visible in the qcow2 file before it
> > is safe to update the write pointer. Otherwise a power failure would
> > leave the file in an inconsistent state where the write pointer has
> > advanced but the data was not written.)
>=20
> The crash-consistency is a concern...

Yes, I'm thinking about crash-consistency. The ordering you described
can result in qcow2 images where the write pointer is ahead of the
actually written data after a power failure or maybe a QEMU crash.

QEMU's block layer must follow the same data integrity behavior that
real devices guarantee.

Damien: Do real zoned block devices guarantee that the updated write
pointer is persisted only after appended data has written been
persisted?

Stefan

--xOU5amG3E/U9fVBO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoMhncACgkQnKSrs4Gr
c8gMkggAyZyYszb7FSU9FgqGlMcHwKQG4WM5UWL3wdB0pBRGZ9bLI1gqsI/sxkfV
EBwrJddxC7SkfbxvmgPFhs2yMNqW6DMRWTMB33SQtAcHrADzPONo1fDPKy1Vk2vl
K/dAxfLxGtWSs7SsnHnZzhajjm9vrD0t8tDVMp4O8tQO9kWP49XdaFMZ8dCkZgAS
tdwwMtgtZlIW45kmeUcoJ0bI1MrVCSRvWt8aOYs7y1OPYhkkB7S+MMMoyw6Fs8fU
cvu4dO1b1/4ENvZ9VJLRD7kzMJVv2xGBl3zwbtFC+dY/Mnpvc60v583ARENn1J2n
mDwChYGu5mRYAF9RxQ1vMgeoKxQjbg==
=8VHn
-----END PGP SIGNATURE-----

--xOU5amG3E/U9fVBO--


