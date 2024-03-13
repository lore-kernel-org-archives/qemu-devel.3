Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C686BC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 17:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkSqP-000491-GO; Wed, 13 Mar 2024 13:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rkSqN-00048I-IE
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 13:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rkSqJ-0003q2-UM
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 13:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710352603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7eWOGLB2dMVcYwjmOhFWrAi7fxVHTYBk9ZrsuY6Z4d8=;
 b=DGFKgub50T5cmo852qhpjdrbMjHAP/lGW9V+vzRa0LExDXx9V2nW2tF3+B3/FaKOAgOuFK
 oUhKZ1DAFEQFCfhacAK37EkVAK1qCodg8njg95j2cdBIABlgBFNqVWf/yTwkwsgqW5DunX
 OXSsIpkKtxCCS5KaISXMx03ZsqNynTA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-9wNgl7OhORODvDDViV9rtw-1; Wed, 13 Mar 2024 13:56:39 -0400
X-MC-Unique: 9wNgl7OhORODvDDViV9rtw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CAA089C56F;
 Wed, 13 Mar 2024 17:56:39 +0000 (UTC)
Received: from localhost (unknown [10.39.192.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B77A440C6DAD;
 Wed, 13 Mar 2024 17:56:38 +0000 (UTC)
Date: Wed, 13 Mar 2024 13:56:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mtosatti@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v3] linux-aio: add IO_CMD_FDSYNC command support
Message-ID: <20240313175637.GA559155@fedora>
References: <20240313084935.1412274-1-ppandit@redhat.com>
 <20240313151839.GA545171@fedora>
 <CAE8KmOy7Lj1tJ2mNTA3rEOoFEzCW+x1O-NrP+7Xy6hhoedH3EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J2OZ0kj2die5IXxi"
Content-Disposition: inline
In-Reply-To: <CAE8KmOy7Lj1tJ2mNTA3rEOoFEzCW+x1O-NrP+7Xy6hhoedH3EA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--J2OZ0kj2die5IXxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 10:49:31PM +0530, Prasad Pandit wrote:
> On Wed, 13 Mar 2024 at 20:48, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > +extern bool laio_has_fdsync(int);
> > Please declare this in include/block/raw-aio.h alongside the other laio=
 APIs.
> >
> > FDSYNC support should be probed at open() time and the result should be
> > stored in a new bool field like s->laio_supports_fdsync. That way the
> > cost of laio_has_fdsync() on every flush request is avoided.
>=20
> * Okay. Here 's' is a BDRVRawState object and file open seems to
> happen in the raw_open_common() function? I'll move the
> laio_has_fdsync() call there and see how it works.

Yes. Thanks!

Stefan

--J2OZ0kj2die5IXxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXx6NUACgkQnKSrs4Gr
c8hJHQf/dQeBV7Glrit5O2I2oeIKlRnkMX5JLecUErVI3vlL56F7iz8hDFVA1WfY
kc/nmLgaSExGvDJmIOgN67hFeL5/WSVTHgTaH/NGG9DxN5D5RoJyUSRk4Y/yBoFA
dD6BoxsvYjN2vQ8DIjQcaJt5dkZDaQ/BtQO0b/G66Z0hjf5/Ay9d8hds9wUSE5i9
qaevE8BxMNEJQ5fHXJp8LU9eBDBi28Oulj14oJYELYtwSWzmm3QYX92ljLNQ5QTu
QzUQ1snnIvzGHzJqA/tXcPRc4+/w/BgFmj13V07B2UfQpfV7DkgZ7hVzG6pV0Rhi
6PSdQo4br8+dZHP+yMnmm+QTdiif2w==
=cSfd
-----END PGP SIGNATURE-----

--J2OZ0kj2die5IXxi--


