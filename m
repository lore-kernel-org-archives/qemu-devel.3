Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3337AC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 15:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5QlF-0004Hi-7r; Thu, 17 Apr 2025 11:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5QlD-0004Fk-HB
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 11:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5QlA-0008Mr-GM
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 11:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744902155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M0BpeQ+x6RViPhM7rsbZIPxlT6aM0YrZAr6a5GDf45I=;
 b=FpkkoLN1uz6ZLC9C9tymcK5q2iyKWtqRvRLywOW4/h2Kg8WQSnDsRkjy0GCpdtRA1fakL4
 56Y6IAtbFWs4DhsB2ZUNgb1VBBJfSxyHwbNMNTIRyv9lIqr6NhJqElKNdoFG1EZALHkdgN
 d3BWmwA1N92gq1hdEC1gePgT6Z8QfLY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615--Nik6wWnMMO618MO-vVERg-1; Thu,
 17 Apr 2025 11:02:32 -0400
X-MC-Unique: -Nik6wWnMMO618MO-vVERg-1
X-Mimecast-MFC-AGG-ID: -Nik6wWnMMO618MO-vVERg_1744902151
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D720519560BB; Thu, 17 Apr 2025 15:02:30 +0000 (UTC)
Received: from localhost (unknown [10.2.16.64])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 57D4419560AE; Thu, 17 Apr 2025 15:02:29 +0000 (UTC)
Date: Thu, 17 Apr 2025 11:02:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, eblake@redhat.com
Subject: Re: [PATCH v3 2/2] block/io: skip head/tail requests on EINVAL
Message-ID: <20250417150228.GC70767@fedora>
References: <20250414201214.241351-1-stefanha@redhat.com>
 <20250414201214.241351-3-stefanha@redhat.com>
 <aADAs7oerG789LTI@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AOer5y78u3SfjT2E"
Content-Disposition: inline
In-Reply-To: <aADAs7oerG789LTI@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--AOer5y78u3SfjT2E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 10:49:55AM +0200, Kevin Wolf wrote:
> Am 14.04.2025 um 22:12 hat Stefan Hajnoczi geschrieben:
> > When guests send misaligned discard requests, the block layer breaks
> > them up into a misaligned head, an aligned main body, and a misaligned
> > tail.
> >=20
> > The file-posix block driver on Linux returns -EINVAL on misaligned
> > discard requests. This causes bdrv_co_pdiscard() to fail and guests
> > configured with werror=3Dstop will pause.
> >=20
> > Add a special case for misaligned head/tail requests. Simply continue
> > when EINVAL is encountered so that the aligned main body of the request
> > can be completed and the guest is not paused. This is the best we can do
> > when guest discard limits do not match the host discard limits.
> >=20
> > Fixes: https://issues.redhat.com/browse/RHEL-86032
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
>=20
> It would be good to also update the comment a bit further up:
>=20
>     /* Discard is advisory, but some devices track and coalesce
>      * unaligned requests, so we must pass everything down rather than
>      * round here.  Still, most devices will just silently ignore
>      * unaligned requests (by returning -ENOTSUP), so we must fragment
>      * the request accordingly.  */
>=20
> I'm not sure where the -ENOTSUP came from (Eric, do you remember?), but
> we should at least mention this -EINVAL case separately.

Sounds good.

Stefan

--AOer5y78u3SfjT2E
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgBGAQACgkQnKSrs4Gr
c8i7FQgAhM8rr4crr6WdaqCQ9pO0EZfNroMioI4eAlVdc2gAd328uPwcxFZkidGc
FNRhXIOYV+y0T2x0/0ufM+Gje4gDID+/wDFCXaFTdut4GWIRJdX9iLJBJJ8i1RZL
w9RDa3s2x2Ue4cxyniZtJrluQACkMlDvDS+U6UPYWZw+gQ/ZgO9GS8qzI/ZImzxw
mUAr0ItYt6d8Bko+SolO+hmAtFilG+AlMWJQxbfKiX21ko8q1bn+3yg4c+85Pkb7
SmKJgVUr8X05oCO3aCCYqanj8v+mj6FQdb4jihdPbbFDv5mcw1qF17mDL8STtdBd
zeiEPUR4IW0W+fMEnVouRleqOm4WdA==
=LzG7
-----END PGP SIGNATURE-----

--AOer5y78u3SfjT2E--


